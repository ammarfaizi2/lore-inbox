Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281306AbRKEUJK>; Mon, 5 Nov 2001 15:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281307AbRKEUJB>; Mon, 5 Nov 2001 15:09:01 -0500
Received: from abasin.nj.nec.com ([138.15.150.16]:12293 "HELO
	abasin.nj.nec.com") by vger.kernel.org with SMTP id <S281306AbRKEUIn>;
	Mon, 5 Nov 2001 15:08:43 -0500
From: Sven Heinicke <sven@research.nj.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15334.61892.392055.542002@abasin.nj.nec.com>
Date: Mon, 5 Nov 2001 15:08:36 -0500 (EST)
To: linux-kernel@vger.kernel.org
Subject: Unwanted Swapping in 2.4.14-pre8, no swapping in 2.4.14-pre6aa1
X-Mailer: VM 6.72 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We have a system with 4G of memory that process streams of information
in the order of a Terabyte of information.  We worked hard to make is
to we never have more then ~3G of data in memory at any one time, so
we would not go into swap.  We tested our code, and the began to swap,
I downloaded 2.4.14-pre8, and it still swaps.  But, if I turn off our
swap partitions it works well, so swap was not needed.

With the 2.4.14-pre6aa1 kernel, with swap turned on, we have no
problem.

In the beginning I though it was the same bug as the google bug, but
following and asking stupid questions I realized it wasn't.  The
following program, which approximates what our processing does on a
small scale, can demonstrate the bug.  You need the chunk files as
used in the google bug test code.  The comments of the code show a
fast way to make the chunk files.

Any possibility of this being fixed in the stable kernel?  Any way to
raise the priority of reclaiming cached memory over swapping out
pages?  I'd like to try to stay away from development kernels on what
are meant to be stable systems, but for now it's aa kernels for me.

    Sven

#include <stdio.h>
#include <stdlib.h>

// Use the following create the needed files for eading.
// for i in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19; do perl -e "open(FILE, '>chunk' . $i); seek (FILE, 6682555 * 64, 0); print FILE NULL;" ; done

// This number should be the same number as fake datafile you have
static const int INPUT_COUNT=19;
static const char* INPUT_PATTERN="chunk%d";

static const int OUTPUT_COUNT=25;
static const char* OUTPUT_PATTERN="out%d";

static const size_t MAX_BLOCK_SIZE=1<<12;
static const size_t TICK_EVERY=1<<14;

FILE*
check_fopen(const char* path, const char* mode)
{
  FILE* fp;

  fp = fopen(path, mode);
  if (fp == NULL)
    {
      perror(path);
      abort();
    }
  return fp;
}

int
main ()
{
  FILE* output[OUTPUT_COUNT];
  register int a_loop;

  // Open up all the output files.
  for (a_loop = 0; a_loop < OUTPUT_COUNT; a_loop++)
    {
      char* filename;

      asprintf(&filename, OUTPUT_PATTERN, a_loop);
      output[a_loop] = check_fopen(filename, "w");
      free(filename);
    }

  // loop through all the input files, one at a time.
  for (a_loop = 0; a_loop < INPUT_COUNT; a_loop++)
    {
      FILE* input;
      char* filename;
      size_t block_size;
      int buffer[MAX_BLOCK_SIZE];
      size_t tick = 0;

      asprintf(&filename, INPUT_PATTERN, a_loop);
      input = check_fopen(filename, "r");
      printf("Reading input: %s\n", filename);
      free(filename);

      // pick random output files to put random chunks of data.
      while (!feof(input))
	{
	  int random_output = rand() % OUTPUT_COUNT;

	  block_size = rand() % MAX_BLOCK_SIZE;
	  fread(buffer, block_size, 1, input);
	  fwrite(buffer, block_size, 1, output[random_output]);

	  // Just a little output to slow things down a bit.
	  tick += block_size;
	  if (tick >= (TICK_EVERY * MAX_BLOCK_SIZE))
	    {
	      fputs("tick ", stdout);
	      fflush(stdout);
	      tick = 0;
	    }
	}
      fputc('\n', stdout);
      fclose(input);
    }

  // Close all the random files.
  for (a_loop = 0; a_loop < OUTPUT_COUNT; a_loop++)
    {
      fclose(output[a_loop]);
    }

  return 0;
}

