CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo "Finished cloning"

cd student-submission
if [[ -f ListExamples.java ]]
then
echo "ListExamples found"
else
    echo "Error: $expected_file not found in the current directory."
    echo "Please ensure you have submitted the correct file."
    exit 1
fi

mkdir new
dest_dir="new"
mkdir -p "$dest_dir"
cp ListExamples.java "$dest_dir"
cp ../TestListExamples.java "$dest_dir"
javac -cp CPATH "${dest_dir}"/TestListExamples.java > compile_output.txt 2>&1

if [ $? -ne 0 ]
then
    echo "Error: Compilation failed. See compile_errors.txt for details."
    exit 1
fi

java -cp CPATH org.junit.runner.JUnitCore "${dest_dir}"/TestListExample > test_results.txt

if [ $? -ne 0 ]; then
    # Tests failed, so print an error message and exit
    echo "Error: Tests failed. See test_results.txt for details."
    exit 1
fi

