# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Seeding the three sections of KIEI925.

Course.destroy_all

courses = [{:dept=>"KIEI", :number=>"925", :title=>"Lecture"}, {:dept=>"KIEI", :number=>"925", :title=>"Discussion"}, {:dept=>"KIEI", :number=>"925", :title=>"Office Hours"}]

courses.each do |course_hash|
  c = Course.new
  c.dept = course_hash[:dept]
  c.number = course_hash[:number]
  c.title = course_hash[:title]
  c.save
end

puts "There are now #{Course.count} courses in the database."


# Seeding the 29 students of KIEI925.

Student.destroy_all

require 'open-uri'
require 'json'

url = 'http://kiei925.herokuapp.com/students.json?access_token=broncos'
raw_data = open(url).read
students = JSON.parse(raw_data)
students.each do |student_hash|
  s = Student.new
  s.first_name = student_hash["first_name"]
  s.last_name = student_hash["last_name"]
  s.image_url = student_hash["image_url"]
  s.save
end

puts "There are now #{Student.count} students in the database."


# Seeding all the meetings of the lectures.

Meeting.destroy_all

first_day = Date.parse("26/9/2013")
last_day = Date.parse("12/12/2013")
c = Course.find_by(:title => "Lecture")

(first_day..last_day).step(7).each do |day|
  m = Meeting.new
  m.course_id = c.id
  m.held_on = day
  m.save
end

puts "There are now #{Meeting.count} meetings in the database."


