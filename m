Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281716AbRKQIE1>; Sat, 17 Nov 2001 03:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281715AbRKQIER>; Sat, 17 Nov 2001 03:04:17 -0500
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:43256 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S281716AbRKQIEG>; Sat, 17 Nov 2001 03:04:06 -0500
Date: Sat, 17 Nov 2001 03:06:11 -0500
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Cc: undisclosed-recipients:;
Subject: I/O tests using elvtune to improve interactive performance
Message-ID: <20011117030611.A214@earthlink.net>
In-Reply-To: <138.49c8e42.29247804@aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <138.49c8e42.29247804@aol.com>; from Dohmcap4@aol.com on Wed, Nov 14, 2001 at 08:44:36PM -0500
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel:	2.4.15-pre5

Test:	Run growfiles tests from Linux Test Project that really hurt
	interactive performance.  Simultaneously run "ls -laR /".
	Change the elevator read latency value with elvtune.
	Also run mp3blaster tests.


Summary:	Smaller values for the I/O elevator read latency
		have a signficant positive impact on interactive 
		performance; and throughput is as good or better
		than default value of 8192.

The idea for this came from Andrea Arcangeli's excellent doc at
http://tux.u-strasbg.fr/jl3/features-2.3-1.html .  That page shows 
that dbench throughput can be good with low values for read
latency too.

My initial tests were just to run growfiles and do commands that
were slow to respond in the past.  Things like "ls -l", "login", 
"ps aux", etc.  I didn't time these tests, but it was amazing what 
a difference using elvtune to set read latency to 128 or 32 made.  
Each growfiles test prints the number of iterations for a 120 second 
interval, and I was happy to see that the number of iterations went 
up while interactive performance was dramatically better.

Of course, running ls -l in big directories isn't exactly scientific,
so I tried to come up with something to measure interactive performance.

For these tests, the ls -laR / is running at the same time as some
growfiles tests.  I picked ls for a couple reasons:

1) It's slow to respond when I/O is high.
2) It's easy to measure and repeat.
3) My disk has 5 partitions and lots of files spread on each partition,
   which will require some seeking on the disk.

ls -laR / is not ideal though; it isn't interactive.

Total time for the 4 growfiles tests is 8 minutes (120 seconds per test).
The ls command finished before the last growfiles test completed in
each run.

I rebooted between each of these tests.

read_latency = 2
----------------
The ls was the slowest here, and none of the growfiles were the fastest.

ls -laR / > /var/tmp/ls-laR2
Elapsed (wall clock) time (h:mm:ss or m:ss): 7:40.52
Percent of CPU this job got: 4%

growfiles -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
13969 iterations to 10 files. Hit time value of 120

growfiles -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
12252 iterations to 10 files. Hit time value of 120

growfiles -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 Lgfile1
48352 iterations to 1 files. Hit time value of 120

growfiles -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_
59807 iterations to 2 files. Hit time value of 120


read_latency = 32
-----------------
This value had 3 of the best results for growfiles.  ls was 16% slower than
the default read latency though.  Interative performance was great though.

ls -laR / > /var/tmp/ls-laR32
Elapsed (wall clock) time (h:mm:ss or m:ss): 5:08.23
Percent of CPU this job got: 6%

growfiles -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
14181 iterations to 10 files. Hit time value of 120

growfiles -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
11691 iterations to 10 files. Hit time value of 120

growfiles -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 Lgfile1
54768 iterations to 1 files. Hit time value of 120

growfiles -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_
68342 iterations to 2 files. Hit time value of 120


read_latency = 8192 (default)
-------------------
ls -laR / > /var/tmp/ls-laR8192
Elapsed (wall clock) time (h:mm:ss or m:ss): 4:26.13
Percent of CPU this job got: 7%

growfiles -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
11085 iterations to 10 files. Hit time value of 120

growfiles -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
13797 iterations to 10 files. Hit time value of 120

growfiles -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 Lgfile1
53198 iterations to 1 files. Hit time value of 120

growfiles -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_
63542 iterations to 2 files. Hit time value of 120


mtest01 and mmap001
-------------------

I also ran the mtest01 and mmap001 tests playing mp3blaster with various
elevator settings.  These are the same tests I've run before.  Below is just
the total time for the test, and the percentage of time the mp3 played.

read_latency = 16 was best here.  Test was fastest and had the highest
mp3 playtime.

read_latency = 2
mtest01 - mp3 played 280 seconds of 316 second run.  (88%)
mmap001 not run because changing elvtune didn't seem to affect this test.

read_latency = 16
mtest01 - mp3 played 280 seconds of 309 second run.  (91%)
mmap001 - mp3 played 908 seconds of 908 second run.

read_latency = 64
mtest01 - mp3 played 280 seconds of 309 second run.  (80%)
mmap001 - mp3 played 908 seconds of 908 second run.

read_latency = 8192
mtest01 - mp3 played 262 seconds of 314 second run.  (83%)
mmap001 - mp3 played 901 seconds of 901 second run.


Hardware
--------
Athlon 1333
512 Mb RAM
(1) 40 Gb IDE hard drive with 5 partitions 


It's exciting to see Linux have good interactive performance under heavy
disk load.  

Have fun!
-- 
Randy Hron

