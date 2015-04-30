require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/game')
require('./lib/board')
require('./lib/space')
require('./lib/player')
require('pry')



get('/test') do
  erb(:test)
end

get('/') do


  if Game.load == nil #start a new game if one is not in progress
    this_game = Game.new()
    this_game.save()
  else #load game if one is in progress
    this_game = Game.load()
  end

  @board = this_game.board

  erb(:index)
end

get('/move/:x/:y') do
  x = params.fetch('x').to_i()
  y = params.fetch('y').to_i()
  this_game = Game.load()
  this_game.take_turn(x, y) 
  @board = this_game.board
  this_game.save()
  erb(:index)
end