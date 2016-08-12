#!/usr/bin/env ruby

require 'piggybank'
require 'pp'

# Single URSI or comma separated string of URSIS
ursi = ARGV[0]
study_id = ARGV[1]

pb = Piggybank.logged_in_from_file(nil, nil, "https://chronus.mrn.org/")


# Some small infmri examples with limited URSIs and instruments

instruments = [
  "Demo FC",
  "Demo T2",
  "Tracker: FC-T2",
  "Tracker T3",
  "Tracker T3-T6",
]

ursis = ["M53780807","M53791621"]

results = pb.get_query_builder_results(study_id, instruments, ursis: ursis, returnType: :mostComplete)
puts "'Most-complete' URSI results are in #{results}"

results = pb.get_query_builder_results(study_id, instruments, ursis: ursis, returnType: :all)
puts "'All' URSI results are in #{results}"

results = pb.get_query_builder_results(study_id, instruments, ursis: ursis, returnType: :onlyDoubleEntryComplete)
puts "'Double entry complete' URSI results are in #{results}"

results = pb.get_query_builder_results(study_id, ["Demo FC", "Demo T2"])
puts "All URSI results are in #{results}"


# Now some crazier heavy-duty NCCAM tests

puts "Starting NCCAM WS export"
results = pb.get_query_builder_results(6860, ["WS_ALL","WS_INCEXC","WS_LTM","WS_MNP-A","WS_MNP-NA"])
puts "NCCAM WS results are in #{results}"

puts "Starting NCCAM ET export"
results = pb.get_query_builder_results(6860, ["ET"])
puts "NCCAM ET results are in #{results}"

