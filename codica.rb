class CodicaArray
  class TooLittleElementsInArrayError < StandardError; end

  def initialize array
    @array = array
  end

  def min_max_swap
  	check_array_validity

  	array_copy = @array.clone
    min, max = @array.each_with_index.minmax
    array_copy[min[1]], array_copy[max[1]] = max[0], min[0]
    array_copy
  end

  def min_indexes_n num    # можно было и попроще написать, но захотелось с использованием рекурсии
  	check_array_validity
  	array_clone = @array.clone
  	min_elems = []

  	__find_min_el_index = ->() {
  		if min_elems.size == num
  			min_elems
  		else
	  		min_elems << array_clone.each_with_index.min[1] + min_elems.size
	  		array_clone.delete_at(array_clone.each_with_index.min[1])
	  		__find_min_el_index.call
  		end
  	}

  	__find_min_el_index.call
  end

  private def check_array_validity
    raise(TooLittleElementsInArrayError, 'Array must contain at least two numeric elements') if @array.size < 2
  end
end


require 'minitest/autorun'

describe 'CodicaArray' do
	before do
		array_valid = [1,33,2,3,2,2,2,4,5,6]
		array_invalid = [1]

		@codica = CodicaArray.new array_valid
		@codica2 = CodicaArray.new array_invalid
	end

	it 'should swap the minimum and maximum elements.' do
		@codica.min_max_swap.must_equal([33,1,2,3,2,2,2,4,5,6])
	end

	it 'should raise an error if aray size less than two' do
		assert_raises CodicaArray::TooLittleElementsInArrayError do
			@codica2.min_max_swap
		end
	end

	it 'should find the indices of the two smallest elements' do
		@codica.min_indexes_n(2).must_equal([0,2])
	end
end