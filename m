Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316161AbSGNMXD>; Sun, 14 Jul 2002 08:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316182AbSGNMXC>; Sun, 14 Jul 2002 08:23:02 -0400
Received: from sj-msg-core-2.cisco.com ([171.69.24.11]:1781 "EHLO
	sj-msg-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S316161AbSGNMWz>; Sun, 14 Jul 2002 08:22:55 -0400
Message-Id: <5.1.0.14.2.20020714202539.022c4270@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 14 Jul 2002 22:22:56 +1000
To: Andrew Morton <akpm@zip.com.au>, Benjamin LaHaise <bcrl@redhat.com>,
       Andrea Arcangeli <andrea@suse.de>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, Steve Lord <lord@sgi.com>
From: Lincoln Dale <ltd@cisco.com>
Subject: ext2 performance in 2.5.25 versus 2.4.19pre8aa2
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <3D2CFF48.9EFF9C59@zip.com.au>
References: <3D2CFA75.FBFD6D92@zip.com.au>
 <5.1.0.14.2.20020711132113.021a6de0@mira-sjcm-3.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wanted me to do some benchmarking of large files on ext2 
filesystems rather than the usual block-device testing
i've had some time to do this, here are the results.

one-line summary is that some results are better, some are worse; CPU usage 
is better in 2.5.25, but thoughput is sometimes
worse.

Summary:
========

Test #1: create a single large (12GB) file on each disk.
          use 12288 blocks of 1048576 bytes each on each of 8 disks.

   2.5.25	Wrote 98304MB across 8 files using 96k blocks of 1M in 
579.935968s (169.51 MB/sec), 44717usec, ~90% cpu
   2.4.19pre8aa2	Wrote 98304MB across 8 files using 96k blocks of 1M in 
607.542648s (161.81 MB/sec), 46684usec, ~88% cpu


Test #2: read back from large (12GB) files on each disk.
          use 4k reads across 3 million blocks on each of 8 disks:

   2.5.25	Read 98304MB across 8 files using 24m blocks of 4k in 508.925829s 
(193.16 MB/sec), 158usec mean, ~61% cpu
   2.4.19pre8aa2	Read 98304MB across 8 files using 24m blocks of 4k in 
526.866882s (186.58 MB/sec), 157usec mean, ~88% cpu


Test #3: same test as #2, but using "nocopy" hack to see if copy_to_user 
(memory bandwidth) is the bottleneck.

   2.5.25	Read 98304MB across 8 files using 24m blocks of 4k in 507.792229s 
(193.59 MB/sec), 160usec mean, ~25% cpu
   2.4.19pre8aa2	Read 98304MB across 8 files using 24m blocks of 4k in 
511.353691s (192.24 MB/sec), 148usec mean, ~50% cpu


test #4: measure read performance when reads are entirely out of the 
page-cache.
          test first primes page-cache with data and then issues random 
reads from that.
          working size is 8 x 200mbyte (1.6GB), test is iterated 10 times.
          no I/O is recorded on FC switch, so data is served entirely out 
of page cache.

   2.5.25	Read 16GB across 8 files using 4096M blocks of 4k in 75.304798s 
(212.47 MB/sec), 145usec mean, ~81% cpu
   2.4.19pre8aa2	Read 16GB across 8 files using 4096M blocks of 4k in 
70.526170s (226.87 MB/sec), 134usec mean, 100% cpu


Test #5: same test as #4, but using "nocopy" hack to see if copy_to_user 
(memory bandwidth) is the bottleneck.

   2.5.25	Read 16GB across 8 files using 4096M blocks of 4k in 61.694199s 
(259.34 MB/sec), 119usec mean, ~65% cpu

		** since performance wasn't much higher, i rebooted the machine and loaded
		** it with "profile=2" and lockmeter.  results of that are at the very end
		** of thie email; looks to me like the scheduler was the culplit.

   2.4.19pre8aa2	Read 16GB across 8 files using 4096M blocks of 4k in 
55.924164s (286.10MB/sec), 108usec mean, ~80% cpu



Details:
========

machine is Dual P3-Xeon, 733MHz processors.  2GB of PC133 SDRAM.
disks are 8 x 15K RPM 18G FC disks, connected to FC switches via 1 x QLogic 
FC 2300 HBA @ 2gbit/s.
FC HBA is in a 64/66 PCI slot.

all tests conducted using current in-house test-tool.  it uses a 
thread-per-device.

8 x empty ext2 filesystems created and mounted

kernels:
  - stock 2.3.25 kernel + PAGE_OFFSET modified to 0x80000000 (no highmem), 
QLogic FC 2300 HBA +
    Andrew Morton's direct-bio patch [not exercised in these benchmarks]



Test #1
-------

create a single large (12GB) file on each disk:
writing to 8 filesystems, using a write block-size of 1 megabyte in 
sequential writes.
12288 blocks (12G) per disk, 8 disks is 96GB total.
./test_disk_performance bs=1m blocks=12288 mode=basic operation=write 
/mnt/scrap-sd*/bigfile

   Linux 2.5.25
	Completed writing 98304 mbytes across 8 devices using 98304 blocks of 1048576
	in 579.935968 seconds (169.51 Mbytes/sec), 44717usec mean
	 #0 (/mnt/scrap-sde/bigfile) 12GB in 571.327206s using 12k writes of 1M 
(21.51MB/sec), 40876usec
	 #1 (/mnt/scrap-sdf/bigfile) 12GB in 574.606073s using 12k writes of 1M 
(21.39MB/sec), 36949usec
	 #2 (/mnt/scrap-sdg/bigfile) 12GB in 569.347650s using 12k writes of 1M 
(21.58MB/sec), 49047usec
	 #3 (/mnt/scrap-sdh/bigfile) 12GB in 569.929641s using 12k writes of 1M 
(21.56MB/sec), 48534usec
	 #4 (/mnt/scrap-sdi/bigfile) 12GB in 579.561403s using 12k writes of 1M 
(21.20MB/sec), 28629usec
	 #5 (/mnt/scrap-sdj/bigfile) 12GB in 579.925156s using 12k writes of 1M 
(21.19MB/sec), 27282usec
	 #6 (/mnt/scrap-sdk/bigfile) 12GB in 579.160854s using 12k writes of 1M 
(21.22MB/sec), 31282usec
	 #7 (/mnt/scrap-sdl/bigfile) 12GB in 578.200229s using 12k writes of 1M 
(21.25MB/sec), 30292usec

	during test, machine had ~10% idle cpu.

   Linux 2.4.19pre8aa2
	Completed writing 98304 mbytes across 8 devices using 98304 blocks of 1048576
	in 607.542648 seconds (161.81 Mbytes/sec), 46684usec mean
	 #0 (/mnt/scrap-sde/bigfile) 12GB in 603.074257s using 12k writes of 1M 
(20.38MB/sec), 37131usec
	 #1 (/mnt/scrap-sdf/bigfile) 12GB in 606.433219s using 12k writes of 1M 
(20.26MB/sec), 25851usec
	 #2 (/mnt/scrap-sdg/bigfile) 12GB in 603.926881s using 12k writes of 1M 
(20.35MB/sec), 43734usec
	 #3 (/mnt/scrap-sdh/bigfile) 12GB in 603.114330s using 12k writes of 1M 
(20.37MB/sec), 39455usec
	 #4 (/mnt/scrap-sdi/bigfile) 12GB in 604.618177s using 12k writes of 1M 
(20.32MB/sec), 43179usec
	 #5 (/mnt/scrap-sdj/bigfile) 12GB in 597.328666s using 12k writes of 1M 
(20.57MB/sec), 40354usec
	 #6 (/mnt/scrap-sdk/bigfile) 12GB in 590.982972s using 12k writes of 1M 
(20.79MB/sec), 44772usec
	 #7 (/mnt/scrap-sdl/bigfile) 12GB in 607.630086s using 12k writes of 1M 
(20.22MB/sec), 22741usec

	during test, machine was ~12% idle cpu.


Test #2
-------

read back from large (12GB) files on each disk sequentially using 4k reads 
across 3 million blocks:
./test_disk_performance bs=4k blocks=3m mode=basic operation=read 
/mnt/scrap-sd*/bigfile


   Linux 2.5.25
	Completed reading 98304 mbytes across 8 devices using 25165824 blocks of 4096
	in 508.925829 seconds (193.16 Mbytes/sec), 158usec mean
	 #0 (/mnt/scrap-sde/bigfile) 12GB in 505.979550s using 3145728 reads of 4k 
(24.29 MB/sec), 160usec
	 #1 (/mnt/scrap-sdf/bigfile) 12GB in 506.537340s using 3145728 reads of 4k 
(24.26 MB/sec), 160usec
	 #2 (/mnt/scrap-sdg/bigfile) 12GB in 506.582859s using 3145728 reads of 4k 
(24.26 MB/sec), 159usec
	 #3 (/mnt/scrap-sdh/bigfile) 12GB in 507.796716s using 3145728 reads of 4k 
(24.20 MB/sec), 152usec
	 #4 (/mnt/scrap-sdi/bigfile) 12GB in 505.965224s using 3145728 reads of 4k 
(24.29 MB/sec), 160usec
	 #5 (/mnt/scrap-sdj/bigfile) 12GB in 508.235475s using 3145728 reads of 4k 
(24.18 MB/sec), 138usec
	 #6 (/mnt/scrap-sdk/bigfile) 12GB in 508.378988s using 3145728 reads of 4k 
(24.17 MB/sec), 137usec
	 #7 (/mnt/scrap-sdl/bigfile) 12GB in 508.925429s using 3145728 reads of 4k 
(24.14 MB/sec), 137usec

	during test, machine had approximately 39% idle cpu.
	performance is fairly close to FC line-rate -- for interests-sake, test #3 
(below)
	repeats the test, but using the no-copy hack to see if performance 
increases as a
	result of reducing the number of memory-copies.

   Linux 2.4.19pre8aa2
	Completed reading 98304 mbytes across 8 devices using 25165824 blocks of 4096
	in 526.866882 seconds (186.58 Mbytes/sec), 157usec mean
	 #0 (/mnt/scrap-sde/bigfile) 12GB in 496.930413s using 3145728 reads of 4k 
(24.73MB/sec), 139usec
	 #1 (/mnt/scrap-sdf/bigfile) 12GB in 497.684209s using 3145728 reads of 4k 
(24.69MB/sec), 134usec
	 #2 (/mnt/scrap-sdg/bigfile) 12GB in 500.584528s using 3145728 reads of 4k 
(24.55MB/sec), 112usec
	 #3 (/mnt/scrap-sdh/bigfile) 12GB in 526.866829s using 3145728 reads of 4k 
(23.32MB/sec), 575usec
	 #4 (/mnt/scrap-sdi/bigfile) 12GB in 497.065359s using 3145728 reads of 4k 
(24.72MB/sec), 137usec
	 #5 (/mnt/scrap-sdj/bigfile) 12GB in 499.433604s using 3145728 reads of 4k 
(24.60MB/sec), 121usec
	 #6 (/mnt/scrap-sdk/bigfile) 12GB in 506.116496s using 3145728 reads of 4k 
(24.28MB/sec), 81usec
	 #7 (/mnt/scrap-sdl/bigfile) 12GB in 514.755508s using 3145728 reads of 4k 
(23.87MB/sec), 80usec

	during test, machine had approximately 12% idle cpu.


Test #3
-------

read back from large (12GB) files on each disk sequentially using 4k reads 
across 3 million blocks
in order to determine if memory-bandwidth / front-side-bus was the 
bottleneck, the kernel was patched with the
bogus "nocopy" read_file_actor hack.
the benchmark as Test #2 was used
./test_disk_performance bs=4k blocks=3m mode=nocopy operation=read 
/mnt/scrap-sd*/bigfile

   Linux 2.5.25
	Completed reading 98304 mbytes across 8 devices using 25165824 blocks of 4096
	in 507.792229 seconds (193.59 Mbytes/sec), 160usec mean
          #0 (/mnt/scrap-sde/bigfile) 12GB in 507.622831s using 3145728 
reads of 4k (24.21 MB/sec), 160usec
          #1 (/mnt/scrap-sdf/bigfile) 12GB in 507.543491s using 3145728 
reads of 4k (24.21 MB/sec), 159usec
          #2 (/mnt/scrap-sdg/bigfile) 12GB in 507.219204s using 3145728 
reads of 4k (24.23 MB/sec), 160usec
          #3 (/mnt/scrap-sdh/bigfile) 12GB in 507.346622s using 3145728 
reads of 4k (24.22 MB/sec), 160usec
          #4 (/mnt/scrap-sdi/bigfile) 12GB in 507.739317s using 3145728 
reads of 4k (24.20 MB/sec), 160usec
          #5 (/mnt/scrap-sdj/bigfile) 12GB in 507.706553s using 3145728 
reads of 4k (24.20 MB/sec), 160usec
          #6 (/mnt/scrap-sdk/bigfile) 12GB in 507.791357s using 3145728 
reads of 4k (24.20 MB/sec), 161usec
          #7 (/mnt/scrap-sdl/bigfile) 12GB in 507.791288s using 3145728 
reads of 4k (24.20 MB/sec), 160usec

	during this test, the machine had ~75% idle cpu and was saturating 2gbit/s FC.
	memory-bandwidth / front-side-bus (copy_to_user()) weren't the bottleneck.
	the bottleneck in this test was certainly the 2gbit/s FC HBA.

   Linux 2.4.19pre8aa2
	Completed reading 98304 mbytes across 8 devices using 25165824 blocks of 4096
	in 511.353691 seconds (192.24 Mbytes/sec), 148usec mean
	 #0 (/mnt/scrap-sde/bigfile) 12GB in 501.421399s using 3145728 reads of 4k 
(24.51MB/sec), 122usec
	 #1 (/mnt/scrap-sdf/bigfile) 12GB in 500.688465s using 3145728 reads of 4k 
(24.54MB/sec), 128usec
	 #2 (/mnt/scrap-sdg/bigfile) 12GB in 499.800663s using 3145728 reads of 4k 
(24.59MB/sec), 133usec
	 #3 (/mnt/scrap-sdh/bigfile) 12GB in 505.030670s using 3145728 reads of 4k 
(24.33MB/sec), 95usec
	 #4 (/mnt/scrap-sdi/bigfile) 12GB in 492.732146s using 3145728 reads of 4k 
(24.94MB/sec), 156usec
	 #5 (/mnt/scrap-sdj/bigfile) 12GB in 495.600828s using 3145728 reads of 4k 
(24.79MB/sec), 151usec
	 #6 (/mnt/scrap-sdk/bigfile) 12GB in 504.890322s using 3145728 reads of 4k 
(24.34MB/sec), 101usec
	 #7 (/mnt/scrap-sdl/bigfile) 12GB in 511.353661s using 3145728 reads of 4k 
(24.03MB/sec), 80usec

	during test, machine cpu was ~50% idle.


Test #4
-------
this test was constructed to show read performance when reads are entirely 
out of the page-cache.
randomly read back from a relatively small (200 mbyte) portion of each 12GB 
file on each disk spindle.  total working size is

8 x 200mbyte (1.6GB), which fits into the page-cache.

firstly, "prime" the page-cache:
   ./test_disk_performance bs=4k blocks=50k mode=basic operation=read 
/mnt/scrap-sd*/bigfile

secondly, randomly seek-once-per-block for 50k blocks of 4k into the file 
(i.e. working-set is 200mbyte on each file).
iterate the test 10 times.
   ./test_disk_performance bs=4k blocks=50k mode=basic operation=read 
seek=random iterations=10 /mnt/scrap-sd*/bigfile

   Linux 2.5.25
	Completed reading 16000 mbytes across 8 devices using 4096000 blocks of 4096
	in 75.304798 seconds (212.47 Mbytes/sec), 145usec mean
          #0 (/mnt/scrap-sde/bigfile) 2GB in 75.304670s using 512K reads of 
4k (26.56 MB/sec), 144usec
          #1 (/mnt/scrap-sdf/bigfile) 2GB in 75.201499s using 512K reads of 
4k (26.60 MB/sec), 144usec
          #2 (/mnt/scrap-sdg/bigfile) 2GB in 75.260114s using 512K reads of 
4k (26.57 MB/sec), 144usec
          #3 (/mnt/scrap-sdh/bigfile) 2GB in 75.287700s using 512K reads of 
4k (26.56 MB/sec), 146usec
          #4 (/mnt/scrap-sdi/bigfile) 2GB in 75.298464s using 512K reads of 
4k (26.56 MB/sec), 144usec
          #5 (/mnt/scrap-sdj/bigfile) 2GB in 75.203990s using 512K reads of 
4k (26.59 MB/sec), 144usec
          #6 (/mnt/scrap-sdk/bigfile) 2GB in 75.204889s using 512K reads of 
4k (26.59 MB/sec), 145usec
          #7 (/mnt/scrap-sdl/bigfile) 2GB in 74.981378s using 512K reads of 
4k (26.67 MB/sec), 144usec

	during this test, there was zero activity on the FC switching infrastructure,
	so all i/o was served from the page-cache.
	cpu during the test was ~19% idle.

	since there was so much idle time, my guess is that the system had hit its 
peak
	memory-bandwidth.  test #5 (below) proves that this is the case.

   Linux 2.4.19pre8aa2
	Completed reading 16000 mbytes across 8 devices using 4096000 blocks of 4096
	in 70.526170 seconds (226.87 Mbytes/sec), 134usec mean
	 #0 (/mnt/scrap-sde/bigfile) 2GB in 70.321070s using 512K reads of 4k 
(28.44 MB/sec), 135usec
	 #1 (/mnt/scrap-sdf/bigfile) 2GB in 69.913954s using 512K reads of 4k 
(28.61 MB/sec), 135usec
	 #2 (/mnt/scrap-sdg/bigfile) 2GB in 70.449511s using 512K reads of 4k 
(28.39 MB/sec), 133usec
	 #3 (/mnt/scrap-sdh/bigfile) 2GB in 70.467109s using 512K reads of 4k 
(28.38 MB/sec), 134usec
	 #4 (/mnt/scrap-sdi/bigfile) 2GB in 70.491946s using 512K reads of 4k 
(28.37 MB/sec), 133usec
	 #5 (/mnt/scrap-sdj/bigfile) 2GB in 70.350087s using 512K reads of 4k 
(28.43 MB/sec), 133usec
	 #6 (/mnt/scrap-sdk/bigfile) 2GB in 70.496071s using 512K reads of 4k 
(28.37 MB/sec), 134usec
	 #7 (/mnt/scrap-sdl/bigfile) 2GB in 70.526164s using 512K reads of 4k 
(28.36 MB/sec), 134usec

	cpu was 0% idle during test.


Test #5
-------
randomly read back from a relatively small (200 mbyte) portion of each 12GB 
file on each disk spindle.  total working size is

8 x 200mbyte (1.6GB), which fits into the page-cache.

in order to determine if memory-bandwidth / front-side-bus was the 
bottleneck, the 2.5.25 kernel was patched with the
bogus "nocopy" read_file_actor hack.
the same methodology in test #4 was used:
prime the page-cache with
   ./test_disk_performance bs=4k blocks=50k mode=basic operation=read 
/mnt/scrap-sd*/bigfile
secondly, randomly seek-once-per-block for 50k blocks of 4k into the file 
(i.e. working-set is 200mbyte on each file).
iterate the test 10 times.
	./test_disk_performance bs=4k blocks=50k mode=nocopy operation=read 
seek=random iterations=10 /mnt/scrap-sd*/bigfile


   Linux 2.5.25
	Completed reading 16000 mbytes across 8 devices using 4096000 blocks of 4096
	in 61.694199 seconds (259.34 Mbytes/sec), 119usec mean
          #0 (/mnt/scrap-sde/bigfile) 2GB in 61.639063s using 512K reads of 
4k (32.45 MB/sec), 119usec
          #1 (/mnt/scrap-sdf/bigfile) 2GB in 61.684894s using 512K reads of 
4k (32.42 MB/sec), 119usec
          #2 (/mnt/scrap-sdg/bigfile) 2GB in 61.693891s using 512K reads of 
4k (32.42 MB/sec), 119usec
          #3 (/mnt/scrap-sdh/bigfile) 2GB in 61.647535s using 512K reads of 
4k (32.44 MB/sec), 119usec
          #4 (/mnt/scrap-sdi/bigfile) 2GB in 61.653856s using 512K reads of 
4k (32.44 MB/sec), 119usec
          #5 (/mnt/scrap-sdj/bigfile) 2GB in 61.642686s using 512K reads of 
4k (32.45 MB/sec), 119usec
          #6 (/mnt/scrap-sdk/bigfile) 2GB in 61.638954s using 512K reads of 
4k (32.45 MB/sec), 119usec
          #7 (/mnt/scrap-sdl/bigfile) 2GB in 61.639063s using 512K reads of 
4k (32.45 MB/sec), 119usec

	this time, cpu was ~35% idle, yet performance didn't improve significantly.
	because of this, i compiled a kernel with lockmeter forward-ported to 2.5.25
	and rebooted with "profile=2".

   Linux 2.4.19pre8aa2
	Completed reading 16000 mbytes across 8 devices using 4096000 blocks of 4096
	in 55.924164 seconds (286.10 Mbytes/sec), 108usec mean
	 #0 (/mnt/scrap-sde/bigfile) 2GB in 55.919840s using 512K reads of 4k 
(35.77 MB/sec), 107usec
	 #1 (/mnt/scrap-sdf/bigfile) 2GB in 55.921253s using 512K reads of 4k 
(35.76 MB/sec), 108usec
	 #2 (/mnt/scrap-sdg/bigfile) 2GB in 55.923975s using 512K reads of 4k 
(35.76 MB/sec), 108usec
	 #3 (/mnt/scrap-sdh/bigfile) 2GB in 55.900788s using 512K reads of 4k 
(35.78 MB/sec), 108usec
	 #4 (/mnt/scrap-sdi/bigfile) 2GB in 55.910989s using 512K reads of 4k 
(35.77 MB/sec), 108usec
	 #5 (/mnt/scrap-sdj/bigfile) 2GB in 55.903394s using 512K reads of 4k 
(35.78 MB/sec), 107usec
	 #6 (/mnt/scrap-sdk/bigfile) 2GB in 55.868038s using 512K reads of 4k 
(35.80 MB/sec), 108usec
	 #7 (/mnt/scrap-sdl/bigfile) 2GB in 55.895071s using 512K reads of 4k 
(35.78 MB/sec), 108usec

	during test, cpu was ~20% idle.

Test #5 of 2.5.25 kernel with lockmeter & profile=2
---------------------------------------------------

using profile=2 and lockmeter on test #5:

given performance wasn't significantly higher (it should have been), i 
rebooted the machine, and loaded 2.5.25 with
"profile=2" and patched in lockmeter.

the same benchmark in test #5 was executed as follows:
	readprofile -r; ./lockstat/lockstat on; ./lockstat/lockstat reset; 
./test_disk_performance3 bs=4k blocks=50k

mode=nocopy operation=read seek=random iterations=10 
/mnt/scrap-sd*/bigfile; readprofile -v | sort -n -k4 | tail -20;

./lockstat/lockstat print

the results were very odd -- i've removed all locks with 0% contention.
the contention seems to be in the scheduler:

Completed reading 16000 mbytes across 8 devices using 4096000 blocks of 
4096 in 91.014923 seconds (175.80 Mbytes/sec),

175usec mean
          #0 (/mnt/scrap-sde/bigfile) 2000MB in 91.014743s using 512000 
reads of 4096 bytes (21.97 Mbytes/sec), 139usec
          #1 (/mnt/scrap-sdf/bigfile) 2000MB in 90.945358s using 512000 
reads of 4096 bytes (21.99 Mbytes/sec), 178usec
          #2 (/mnt/scrap-sdg/bigfile) 2000MB in 90.430662s using 512000 
reads of 4096 bytes (22.12 Mbytes/sec), 174usec
          #3 (/mnt/scrap-sdh/bigfile) 2000MB in 90.474412s using 512000 
reads of 4096 bytes (22.11 Mbytes/sec), 174usec
          #4 (/mnt/scrap-sdi/bigfile) 2000MB in 90.443735s using 512000 
reads of 4096 bytes (22.11 Mbytes/sec), 174usec
          #5 (/mnt/scrap-sdj/bigfile) 2000MB in 90.494653s using 512000 
reads of 4096 bytes (22.10 Mbytes/sec), 174usec
          #6 (/mnt/scrap-sdk/bigfile) 2000MB in 90.488251s using 512000 
reads of 4096 bytes (22.10 Mbytes/sec), 174usec
          #7 (/mnt/scrap-sdl/bigfile) 2000MB in 90.620444s using 512000 
reads of 4096 bytes (22.07 Mbytes/sec), 174usec
80108938 resume_userspace                             59   3.6875
8011b540 sys_gettimeofday                            729   4.5563
80108650 handle_signal                              1963   5.5767
801087b0 do_signal                                  1046   5.9432
80107a20 sys_rt_sigsuspend                          2058   6.1250
80107dd0 sys_sigreturn                              1984   6.5263
80108974 syscall_call                                 73   6.6364
8010a3f0 math_state_restore                          450   7.0312
8010f140 restore_i387                               3040   7.0370
8011bc40 do_softirq                                 1473   7.0817
8010ef10 save_i387                                  4281   7.6446
80120ab0 get_signal_to_deliver                      5523  10.7871
80113ba0 schedule                                  10230  10.8369
8010ed80 restore_fpu                                 475  14.8438
80109418 device_not_available                        787  16.3958
8010897f syscall_exit                                203  18.4545
8010de50 do_gettimeofday                            7115  49.4097
80120440 send_sig_info                              9599  54.5398
80108948 system_call                                5549 126.1136
80106d30 default_idle                              52095 813.9844


lockstat results -- all contended locks shown:

___________________________________________________________________________________________
System: Linux mel-stglab-host1 2.5.25 #12 SMP Sun Jul 14 19:25:43 EST 2002 i686
Total counts

All (32) CPUs

Start time: Sun Jul 14 20:06:07 2002
End   time: Sun Jul 14 20:11:46 2002
Delta Time: 338.84 sec.
Hash table slots in use:      432.
Global read lock slots in use: 999.


- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
- - - - - - - - - - - - - - -
SPINLOCKS         HOLD            WAIT
   UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN 
RJECT  NAME

         1.2%  0.7us(3768us)  1.7us( 286us)(0.02%)  88382474 98.8%  1.1% 
0.02%  *TOTAL*


  0.03% 0.20%  1.6us( 7.5us)  2.6us(  12us)(0.00%)     61102 99.8% 
0.20%    0%  [0xf7b1c008]
  0.03% 0.11%  3.2us( 7.5us)  2.1us( 4.9us)(0.00%)     30551 99.9% 
0.11%    0%    qla2x00_done+0x1e8
  0.00% 0.30%  0.1us( 0.6us)  2.7us(  12us)(0.00%)     30551 99.7% 
0.30%    0%    qla2x00_queuecommand+0x484

  0.01% 0.03%  0.2us( 1.1us)  0.9us( 2.2us)(0.00%)    244002  100% 
0.03%    0%  [0xf7b1e35c]
  0.00% 0.02%  0.1us( 0.6us)  0.9us( 1.2us)(0.00%)     30551  100% 
0.02%    0%    qla2x00_callback+0x54
  0.00% 0.02%  0.2us( 0.7us)  1.1us( 1.9us)(0.00%)     30145  100% 
0.02%    0%    qla2x00_done+0x34
  0.00% 0.03%  0.2us( 1.1us)  0.7us( 0.9us)(0.00%)     30551  100% 
0.03%    0%    qla2x00_get_new_sp+0x18
  0.00% 0.02%  0.2us( 1.1us)  1.2us( 1.9us)(0.00%)     61102  100% 
0.02%    0%    qla2x00_next+0x20
  0.00% 0.06%  0.1us( 0.9us)  0.8us( 1.6us)(0.00%)     30551  100% 
0.06%    0%    qla2x00_next+0x10c
  0.00% 0.05%  0.1us( 0.5us)  0.9us( 1.7us)(0.00%)     30551  100% 
0.05%    0%    qla2x00_queuecommand+0x424
  0.00% 0.03%  0.2us( 0.9us)  1.1us( 2.2us)(0.00%)     30551  100% 
0.03%    0%    qla2x00_status_entry+0x830

  0.06% 0.06%  3.4us(  11us)  2.8us( 5.3us)(0.00%)     60704  100% 
0.06%    0%  [0xf7b1e388]
  0.02% 0.10%  2.2us( 8.0us)  3.0us( 5.3us)(0.00%)     30551  100% 
0.10%    0%    qla2x00_64bit_start_scsi+0x15c
  0.00%    0%  0.3us( 
0.4us)    0us                        8  100%    0%    0% 
qla2x00_cmd_timeout+0x190
  0.04% 0.02%  4.7us(  11us)  2.2us( 3.0us)(0.00%)     30145  100% 
0.02%    0%    qla2x00_intr_handler+0x40

  0.26% 0.04%  0.1us( 1.0us)  0.6us( 1.5us)(0.00%)   8927899  100% 
0.04%    0%  blk_plug_lock
  0.00% 0.01%  0.1us( 0.8us)  0.3us( 0.4us)(0.00%)     28901  100% 
0.01%    0%    blk_plug_device+0x1c
  0.26% 0.04%  0.1us( 1.0us)  0.6us( 1.5us)(0.00%)   8870097  100% 
0.04%    0%    blk_run_queues+0x18
  0.00%  1.0%  0.1us( 0.5us)  0.6us( 1.1us)(0.00%)     28901 
99.0%  1.0%    0%    generic_unplug_device+0x2c

  0.03% 0.05%  0.5us( 9.2us)  1.2us( 3.0us)(0.00%)    158705  100% 
0.05%    0%  contig_page_data+0xb4
  0.00% 0.12%  0.2us( 3.0us)  1.3us( 2.0us)(0.00%)     27794 99.9% 
0.12%    0%    __free_pages_ok+0x174
  0.02% 0.03%  0.6us( 9.2us)  1.1us( 3.0us)(0.00%)    130911  100% 
0.03%    0%    rmqueue+0x28

  0.01% 0.03%  1.5us(  44us)  5.6us(  12us)(0.00%)     23127  100% 
0.03%    0%  dcache_lock
  0.00% 0.04%  0.3us( 6.4us)  4.0us( 6.5us)(0.00%)      7053  100% 
0.04%    0%    dput+0x30
  0.01% 0.04%  3.8us(  44us)  7.1us(  12us)(0.00%)      7114  100% 
0.04%    0%    path_lookup+0xd8

  0.00% 0.01%  0.3us(  28us)  0.3us( 0.3us)(0.00%)     13515  100% 
0.01%    0%  files_lock
  0.00% 0.02%  0.2us(  28us)  0.3us( 0.3us)(0.00%)      4489  100% 
0.02%    0%    __fput+0x70

  0.18% 0.02%  1.7us( 4.8us)  1.7us( 3.3us)(0.00%)    367354  100% 
0.02%    0%  ioapic_lock
  0.18% 0.02%  1.7us( 4.8us)  1.7us( 3.3us)(0.00%)    367354  100% 
0.02%    0%    set_ioapic_affinity+0x20

  0.02%  2.7%  9.3us( 306us)   14us( 286us)(0.00%)      7358 
97.3%  2.7%    0%  kernel_flag
  0.00% 0.28%  0.4us( 4.1us)   15us(  15us)(0.00%)       351 99.7% 
0.28%    0%    de_put+0x2c
  0.00% 0.88%   21us(  97us)   15us(  21us)(0.00%)       342 99.1% 
0.88%    0%    ext3_dirty_inode+0x2c
  0.00% 0.50%  2.0us(  70us)   24us(  24us)(0.00%)       202 99.5% 
0.50%    0%    ext3_get_block_handle+0xb8
  0.00%  2.9%  4.9us( 7.0us)  146us( 146us)(0.00%)        35 
97.1%  2.9%    0%    ext3_write_super+0x24
  0.00% 27.0%   52us( 306us)   29us( 286us)(0.00%)       226 73.0% 
27.0%    0%    schedule+0x394
  0.00% 0.79%  0.7us( 1.2us)  9.2us(  14us)(0.00%)       379 99.2% 
0.79%    0%    sem_exit+0x24
  0.00% 0.83%  2.4us(  21us)  5.3us( 8.5us)(0.00%)       845 99.2% 
0.83%    0%    sys_ioctl+0x44
  0.00% 12.0%  6.7us(  36us)  4.2us(  12us)(0.00%)       502 88.0% 
12.0%    0%    tty_read+0xc4
  0.01%  3.2%  8.8us(  53us)  6.2us(  25us)(0.00%)      2004 
96.8%  3.2%    0%    tty_write+0x1f4

  0.02% 0.01%  0.2us(  37us)  3.3us(  16us)(0.00%)    247810  100% 
0.01%    0%  pagemap_lru_lock
  0.01% 0.00%  0.4us(  36us)   14us(  16us)(0.00%)    102714  100% 
0.00%    0%    activate_page+0xc
  0.01% 0.01%  0.1us(  31us)  0.6us( 1.0us)(0.00%)    124041  100% 
0.01%    0%    lru_cache_add+0x1c
  0.00% 0.01%  0.2us(  30us)  0.9us( 0.9us)(0.00%)     21044  100% 
0.01%    0%    lru_cache_del+0xc

  0.00% 83.2%  0.6us( 2.2us)  1.0us( 2.4us)(0.00%)      7652 16.8% 
83.2%    0%  runqueues
  0.00% 83.2%  0.6us( 2.2us)  1.0us( 2.4us)(0.00%)      7652 16.8% 
83.2%    0%    load_balance+0x13c

  0.00% 42.6%  0.8us( 4.2us)  1.0us( 3.0us)(0.00%)     15467 57.4% 
42.6%    0%  runqueues+0x9a0
  0.00% 84.3%  0.4us( 1.9us)  1.0us( 3.0us)(0.00%)      7815 15.7% 
84.3%    0%    load_balance+0x188

  0.05% 0.02%  0.3us( 4.0us)  0.8us( 2.5us)(0.00%)    560160  100% 
0.02%    0%  timerlist_lock
  0.01% 0.04%  0.2us( 1.6us)  0.8us( 1.4us)(0.00%)     93886  100% 
0.04%    0%    add_timer+0x10
  0.00% 0.05%  0.1us( 0.7us)  0.8us( 2.5us)(0.00%)     61444  100% 
0.05%    0%    del_timer+0x14
  0.00% 0.02%  0.2us( 0.9us)  0.8us( 1.3us)(0.00%)     32154  100% 
0.02%    0%    del_timer_sync+0x1c
  0.00% 0.46%  0.5us( 1.6us)  0.6us( 0.7us)(0.00%)       647 99.5% 
0.46%    0%    mod_timer+0x18
  0.03% 0.01%  0.3us( 4.0us)  0.8us( 1.2us)(0.00%)    339146  100% 
0.01%    0%    timer_bh+0xd4
  0.00% 0.01%  0.1us( 0.8us)  0.9us( 1.0us)(0.00%)     32883  100% 
0.01%    0%    timer_bh+0x274

  0.04% 0.36%  3.8us(  12us)  3.2us(  14us)(0.00%)     31764 99.6% 
0.36%    0%  __make_request+0x70
  0.07% 0.10%  7.5us(  44us)  2.5us( 4.5us)(0.00%)     30805  100% 
0.10%    0%  __scsi_end_request+0x20
  0.01% 0.00%  0.6us( 6.9us)  0.5us( 0.8us)(0.00%)     81580  100% 
0.00%    0%  __wake_up+0x20
  0.00% 0.29%  7.7us(  68us)  4.8us( 4.8us)(0.00%)       348 99.7% 
0.29%    0%  ahc_linux_isr+0x28
  0.03%  1.3%  3.2us(  12us)  1.5us( 9.2us)(0.00%)     28915 
98.7%  1.3%    0%  generic_unplug_device+0x14
  0.31%  1.2%  0.8us( 3.7us)    0us                  1321702 
98.8%    0%  1.2%  load_balance+0x120
  0.00% 0.59%  0.2us( 0.8us)  1.1us( 1.8us)(0.00%)      1525 99.4% 
0.59%    0%  n_tty_chars_in_buffer+0x18
  0.00% 0.40%  0.1us( 0.5us)  0.6us( 0.6us)(0.00%)       501 99.6% 
0.40%    0%  read_chan+0x538
  0.00% 0.60%  0.1us( 0.2us)  0.9us( 1.2us)(0.00%)       501 99.4% 
0.60%    0%  read_chan+0x59c
  0.00% 0.02%  0.1us( 0.7us)  0.8us( 1.2us)(0.00%)     28530  100% 
0.02%    0%  remove_wait_queue+0x10
   5.2%  3.0%  1.5us(  13us)  1.1us( 3.2us)(0.00%)  11473908 
97.0%  3.0%    0%  schedule+0x8c
  0.02%  1.6%  0.2us( 5.3us)  1.0us( 2.6us)(0.00%)    308882 
98.4%  1.6%    0%  scheduler_tick+0x10c
  0.08% 0.88%  0.8us( 4.7us)  1.0us( 2.2us)(0.00%)    369477 99.1% 
0.88%    0%  scheduler_tick+0x80
  0.00% 0.45%  0.2us(  13us)  2.7us( 7.7us)(0.00%)     30819 99.5% 
0.45%    0%  scsi_dispatch_cmd+0x138
  0.00% 0.21%  0.2us( 1.0us)  2.4us( 5.6us)(0.00%)     30819 99.8% 
0.21%    0%  scsi_finish_command+0x18
  0.00% 0.22%  0.5us( 3.2us)  2.7us( 6.4us)(0.00%)     30819 99.8% 
0.22%    0%  scsi_queue_next_request+0x18
  0.00% 0.08%  0.3us( 4.0us)  5.1us(  18us)(0.00%)     30819  100% 
0.08%    0%  scsi_request_fn+0x3bc
   5.2% 0.00%  2.0us(  12us)  0.7us( 1.0us)(0.00%)   8750674  100% 
0.00%    0%  send_sig_info+0x4c
  0.00% 0.93%  0.8us( 1.9us)  0.2us( 0.2us)(0.00%)       108 99.1% 
0.93%    0%  sys_sched_yield+0x38
   1.6%  7.3%  0.6us( 4.8us)  2.0us( 6.7us)(0.01%)   8758669 
92.7%  7.3%    0%  try_to_wake_up+0x40
  0.00% 0.26%  0.7us( 2.0us)  0.3us( 0.3us)(0.00%)       379 99.7% 
0.26%    0%  wake_up_forked_process+0x30

- - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - 
- - - - - - - - - - - - - - - - - - - - -
RWLOCK READS   HOLD    MAX  RDR BUSY PERIOD      WAIT
   UTIL  CON    MEAN   RDRS   MEAN(  MAX )   MEAN(  MAX )( %CPU)     TOTAL 
NOWAIT SPIN  NAME

        0.14%                               4.7us(  13us)(0.00%)  60230957 
99.9% 0.14%  *TOTAL*

   7.3% 0.00%   2.8us     2  2.8us( 245us)  3.1us( 
9.0us)(0.00%)   8751481  100% 0.00%  tasklist_lock
        0.26%                               2.6us( 2.6us)(0.00%)       379 
99.7% 0.26%    exit_notify+0x18
        11.1%                               2.6us( 2.6us)(0.00%)         9 
88.9% 11.1%    sig_exit+0x90

   1.4% 0.44%   0.2us     2  0.3us( 3.3us)  4.7us(  13us)(0.00%)  19266661 
99.6% 0.44%  xtime_lock
        0.44%                               4.7us(  13us)(0.00%)  19266661 
99.6% 0.44%    do_gettimeofday+0x14

- - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - 
- - - - - - - - - - - - - - - - - - - - - - - - -
RWLOCK WRITES     HOLD           WAIT (ALL)           WAIT (WW)
   UTIL  CON    MEAN(  MAX )   MEAN(  MAX )( %CPU)   MEAN(  MAX )     TOTAL 
NOWAIT SPIN(  WW )  NAME

        0.13%  0.7us( 230us)  1.0us( 9.0us)(0.00%)  0.3us( 2.9us)  10490234 
99.9% 0.09%(0.05%)  *TOTAL*

  0.00%  7.8%  0.5us( 3.0us)  1.8us( 9.0us)(0.00%)  0.7us( 2.9us)      1224 
92.2%  6.7%( 1.1%)  tasklist_lock
  0.00%  7.7%  0.7us( 1.3us)  1.6us( 7.4us)(0.00%)  0.3us( 0.7us)       379 
92.3%  6.3%( 1.3%)    do_fork+0x588
     0%  7.1%                 2.0us( 3.1us)(0.00%)  1.5us( 2.9us)       379 
92.9%  5.8%( 1.3%)    exit_notify+0x1c4
  0.00%  4.6%  0.1us( 0.1us)  1.4us( 1.7us)(0.00%)  0.6us( 0.6us)        87 
95.4%  3.4%( 1.1%)    pid_base_iput+0x18
  0.00%  9.5%  0.8us( 3.0us)  1.8us( 9.0us)(0.00%)  0.2us( 0.6us)       379 
90.5%  8.7%(0.79%)    unhash_process+0x14

   1.0%  2.1%  5.2us(  18us)  1.0us( 2.3us)(0.00%)  0.3us( 1.2us)    678292 
97.9%  1.3%(0.74%)  xtime_lock
  0.04%  2.1%  0.4us( 4.8us)  1.0us( 2.3us)(0.00%)  0.3us( 1.2us)    339146 
97.9%  1.3%(0.81%)    timer_bh+0xc
   1.0%  2.0%   10us(  18us)  0.9us( 2.2us)(0.00%)  0.3us( 0.9us)    339146 
98.0%  1.3%(0.68%)    timer_interrupt+0x10

   1.1%    0%  0.4us( 
230us)    0us                   0us           9604614  100%    0%(   0%) 
do_generic_file_read+0x8c

