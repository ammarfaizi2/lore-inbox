Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314278AbSFTNBi>; Thu, 20 Jun 2002 09:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314325AbSFTNBh>; Thu, 20 Jun 2002 09:01:37 -0400
Received: from loke.as.arizona.edu ([128.196.209.61]:20228 "EHLO
	loke.as.arizona.edu") by vger.kernel.org with ESMTP
	id <S314278AbSFTNBf>; Thu, 20 Jun 2002 09:01:35 -0400
Date: Thu, 20 Jun 2002 06:00:48 -0700 (MST)
From: Craig Kulesa <ckulesa@as.arizona.edu>
To: linux-kernel@vger.kernel.org
Subject: VM benchmarks for 2.5 (mainline & rmap patches)
Message-ID: <Pine.LNX.4.44.0206200554590.4448-100000@loke.as.arizona.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



[Reposted as I didn't see this hit the list; apologies to anyone who gets 
 it twice... -CK]


Following are a short sample of simple benchmarks that I used to test 
2.5.23 and the two rmap-based variants.  The tests are being run on a 
uniprocessor PII/333 IBM Thinkpad 390E with 192 MB of ram and using 
ext3 in data=writeback journalling mode.  Randy Hron can do a much 
better job of this on "real hardware", but this is a start.  ;)


Here are the kernels:

2.5.1-pre1:	totally vanilla, from the beginning of the 2.5 tree
2.5.23: 	"almost vanilla", modified only to make it compile
2.5.23-rmap:  	simple application of rmap to the 2.5.23 classzone VM
2.5.23-rmap13b:	 Rik's full rmap patch using his page-aging VM

Here we go...

-------------------------------------------------------------------

Test 1: (non-swap) 'time make -j2 bzImage' for 2.5.23 tree, config at
	the rmap patch site (bottom of this email).  This is mostly a 
	fastpath test.  Fork, exec, substantive memory allocation and 
	use, but no swap allocation.  Record 'time' output.

2.5.1-pre1:     1145.450u 74.290s 20:58.40 96.9%   0+0k 0+0io 1270393pf+0w
2.5.23:	        1153.490u 79.380s 20:58.79 97.9%   0+0k 0+0io 1270393pf+0w
2.5.23-rmap:    1149.840u 83.350s 21:01.37 97.7%   0+0k 0+0io 1270393pf+0w
2.5.23-rmap13b: 1145.930u 83.640s 20:53.16 98.1%   0+0k 0+0io 1270393pf+0w

Comments: You can see the rmap overhead in the system times, but it
	  doesn't really pan out in the wall clock time, at least for
	  rmap13b.  Maybe for minimal rmap.

	  Note that system times increased from 2.5.1 to 2.5.23, but
	  that's not evident on the wall clock.

	  These tests are with ext3 in writeback mode, so we're doing
	  direct-to-BIO for a lot of stuff.  It's presumably not the
	  BIO/bh duplication of effort, at least as much as it has been...

---------------------------------------------------------------------

Test 2: 'time make -j32 bzImage' for 2.5.23, only building fs/ mm/ ipc/ 
	init/ and kernel/.  Same as above, but push the kernel into swap.  
	Record time and vmstat output.

2.5.23:          193.260u 17.540s 3:49.86 93.5%  0+0k 0+0io 223130pf+0w
		 Total kernel swapouts during test = 143992 kB
		 Total kernel swapins during test  = 188244 kB

2.5.23-rmap:     190.390u 17.310s 4:03.16 85.4%  0+0k 0+0io 220703pf+0w
		 Total kernel swapouts during test = 141700 kB
		 Total kernel swapins during test  = 162784 kB

2.5.23-rmap13b:  189.120u 16.670s 3:36.68 94.7%  0+0k 0+0io 219363pf+0w
		 Total kernel swapouts during test =  87736 kB
		 Total kernel swapins during test  =  18576 kB

Comments:  rmap13b is the real winner here.  Swap access is enormously
	   lower than with mainline or the minimal rmap patch.  The
	   minimal rmap patch is a bit less than mainline, but is 
	   definitely wasting its time somewhere...

	   Wall clock times are not as variable as swap access
	   between the kernels, but the trends do hold.
	   
	   It is valuable to note that this is a laptop hard drive
	   with the usual awful seek times.  If swap reads are
	   fragmented all-to-hell with rmap, with lots of disk seeks
	   necessary, we're still coming out ahead when we minimize
	   swap reads! 

---------------------------------------------------------------------

Test 3: (non-swap) dbench 1,2,4,8 ... just because everyone else does...

2.5.1:
Throughput 31.8967 MB/sec (NB=39.8709 MB/sec  318.967 MBit/sec)  1 procs
1.610u 2.120s 0:05.14 72.5%     0+0k 0+0io 129pf+0w
Throughput 33.0695 MB/sec (NB=41.3369 MB/sec  330.695 MBit/sec)  2 procs
3.490u 4.000s 0:08.99 83.3%     0+0k 0+0io 152pf+0w
Throughput 31.4901 MB/sec (NB=39.3626 MB/sec  314.901 MBit/sec)  4 procs
6.900u 8.290s 0:17.78 85.4%     0+0k 0+0io 198pf+0w
Throughput 15.4436 MB/sec (NB=19.3045 MB/sec  154.436 MBit/sec)  8 procs
13.780u 16.750s 1:09.38 44.0%   0+0k 0+0io 290pf+0w

2.5.23:
Throughput 35.1563 MB/sec (NB=43.9454 MB/sec  351.563 MBit/sec)  1 procs
1.710u 1.990s 0:04.76 77.7%     0+0k 0+0io 130pf+0w
Throughput 33.237 MB/sec (NB=41.5463 MB/sec  332.37 MBit/sec)  2 procs
3.430u 4.050s 0:08.95 83.5%     0+0k 0+0io 153pf+0w
Throughput 28.9504 MB/sec (NB=36.188 MB/sec  289.504 MBit/sec)  4 procs
6.780u 8.090s 0:19.24 77.2%     0+0k 0+0io 199pf+0w
Throughput 17.1113 MB/sec (NB=21.3891 MB/sec  171.113 MBit/sec)  8 procs
13.810u 21.870s 1:02.73 56.8%   0+0k 0+0io 291pf+0w

2.5.23-rmap:
Throughput 34.9151 MB/sec (NB=43.6439 MB/sec  349.151 MBit/sec)  1 procs
1.770u 1.940s 0:04.78 77.6%     0+0k 0+0io 133pf+0w
Throughput 33.875 MB/sec (NB=42.3437 MB/sec  338.75 MBit/sec)  2 procs
3.450u 4.000s 0:08.80 84.6%     0+0k 0+0io 156pf+0w
Throughput 29.6639 MB/sec (NB=37.0798 MB/sec  296.639 MBit/sec)  4 procs
6.640u 8.270s 0:18.81 79.2%     0+0k 0+0io 202pf+0w
Throughput 15.7686 MB/sec (NB=19.7107 MB/sec  157.686 MBit/sec
14.060u 21.850s 1:07.97 52.8%   0+0k 0+0io 294pf+0w

2.5.23-rmap13b:
Throughput 35.1443 MB/sec (NB=43.9304 MB/sec  351.443 MBit/sec)  1 procs
1.800u 1.930s 0:04.76 78.3%     0+0k 0+0io 132pf+0w
Throughput 33.9223 MB/sec (NB=42.4028 MB/sec  339.223 MBit/sec)  2 procs
3.280u 4.100s 0:08.79 83.9%     0+0k 0+0io 155pf+0w
Throughput 25.0807 MB/sec (NB=31.3509 MB/sec  250.807 MBit/sec)  4 procs
6.990u 7.910s 0:22.09 67.4%     0+0k 0+0io 202pf+0w
Throughput 14.1789 MB/sec (NB=17.7236 MB/sec  141.789 MBit/sec)  8 procs
13.780u 17.830s 1:15.52 41.8%   0+0k 0+0io 293pf+0w


Comments:  Stock 2.5 has gotten faster since the tree began.  That's
	   good.  Rmap patches don't affect this for small numbers of
	   processes, but symptomatically show a small slowdown by the
	   time we reach 'dbench 8'.  

---------------------------------------------------------------------

Test 4: (non-swap) cached (first) value from 'hdparm -Tt /dev/hda'

2.5.1-pre1: 	76.89 MB/sec
2.5.23:		75.99 MB/sec
2.5.23-rmap:	77.85 MB/sec
2.5.23-rmap13b:	76.58 MB/sec

Comments:  Within the statistical noise, no rmap slowdown in cached hdparm 
	   scores.  Otherwise not much to see here.

---------------------------------------------------------------------

Test 5: (non-swap) forkbomb test.  Fork() and malloc() lots of times.
	This is supposed to be one of rmap's achilles' heels.  
	The first line results from forking 10000 times with
	10000*sizeof(int) allocations.  The second is from 1 million
	forks with 1000*sizeof(int) allocations.  Average a large
	number of tests for the final results.

2.5.1-pre1:	0.000u 0.120s 0:12.66 0.9%      0+0k 0+0io 71pf+0w
		0.010u 0.100s 0:01.24 8.8%      0+0k 0+0io 70pf+0w

2.5.23:		0.000u 0.260s 0:12.96 2.0%      0+0k 0+0io 71pf+0w
		0.010u 0.220s 0:01.31 17.5%     0+0k 0+0io 71pf+0w

2.5.23-rmap:	0.000u 0.400s 0:13.19 3.0%      0+0k 0+0io 71pf+0w
		0.000u 0.250s 0:01.43 17.4%     0+0k 0+0io 71pf+0w

2.5.23-rmap13b:	0.000u 0.360s 0:13.36 2.4%      0+0k 0+0io 71pf+0w
		0.000u 0.250s 0:01.46 17.1%     0+0k 0+0io 71pf+0w


Comments:  The rmap overhead shows up here at the 2-3% level in the
	   first test, and 9-11% in the second, versus 2.5.23.  
	   This makes sense, as fork() activity is higher in the
	   second test. 

	   Strangely, mainline 2.5 also shows an increase (??) in
	   overhead, at about the same level, from 2.5.1 to present.

	   This silly little program is available with the rmap
	   patches at:  
		http://loke.as.arizona.edu/~ckulesa/kernel/rmap-vm/
	
---------------------------------------------------------------------


Hope this provides some useful food for thought.  

I'm sure it reassures Rik that my simple hack of rmap onto the
classzone VM isn't nearly as balanced as the first benchmark suggested
it was. ;)  But it might make a good base to start from, and that's 
actually the point of the exercise. :) 


That's all. <yawns>  Bedtime. :)

Craig Kulesa
Steward Observatory, Univ. of Arizona

