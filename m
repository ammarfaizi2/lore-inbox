Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbVJFDNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbVJFDNM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 23:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbVJFDNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 23:13:12 -0400
Received: from ns.ustc.edu.cn ([202.38.64.1]:36245 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750713AbVJFDNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 23:13:11 -0400
Date: Thu, 6 Oct 2005 11:14:16 +0800
From: WU Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Adaptive read-ahead
Message-ID: <20051006031416.GA4518@mail.ustc.edu.cn>
Mail-Followup-To: WU Fengguang <wfg@mail.ustc.edu.cn>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an updated patch for the adaptive read-ahead logic.

The current read-ahead logic uses an inflexible algorithm with 128KB
VM_MAX_READAHEAD. Less memory leads to thrashing, more memory helps no
throughput. The new logic is simply safer and faster. It makes sure
every single read-ahead request is safe for the current load. Memory
tight systems are expected to benefit a lot: no thrashing any more.
It can also help boost I/O throughput for large memory systems, for
VM_MAX_READAHEAD is now defaulted to 1MB. The value is no longer tightly
coupled with the thrashing problem, and therefore constrained by it.

The code has been expanded, reorganized, cleaned up and documented.
The changes include:
	- stateful estimation of thrashing-threshold
	- context method with accelerated grow up phase
	- adaptive look-ahead
	- early detection and rescue of pages in danger
	- statistics data collection
	- synchronized page aging between zones

The page aging problem showed up when I was testing many slow reads with
limited memory. Pages in the DMA zone were found out to be aged about 3
times faster than that of Normal zone in systems with 64-512M memory.
That is a BIG threat to the read-ahead pages. So I added some code to
make the aging rates synchronized. You can see the effect by running:
$ tar c / | cat > /dev/null &
$ watch -n1 'grep "age " /proc/zoneinfo'
There are still some extra DMA scans in the direct page reclaim path.
It tend to happen in large memory system and is therefore not a big
problem.

The benchmarks are pretty optimistic. Some of the highlights:
	- 20-100% speed up for parallel reads
	- 50-100% speed up for parallel NFS reads
	- 800 1KB/s streams with 64M memory without thrashing
	- 91% cache hit, 7:1 read-ahead:random requests(on my PC)

Advices are appreciated. Please CC to me, thank you.

WU Fengguang

________________________________________________________________________________
Most tests were performed on a server with Xeon 2.80GHz x2/2G/73G.
Every test was run twice. They all used zsh's buildtin time with
TIMEFMT="%E real  %S system  %U user  %w+%c cs  %J"

BIG FILE: equals
================
readahead_ratio = 0, ra_max = 128kb
10.59s real  1.00s system  0.06s user  2866+0 cs  dd if=$FILE of=/dev/nu
readahead_ratio = 50, ra_max = 1024kb
10.59s real  0.91s system  0.10s user  518+1 cs  dd if=$FILE of=/dev/nul

readahead_ratio = 0, ra_max = 128kb
10.62s real  0.82s system  0.08s user  2866+1 cs  dd if=$FILE of=/dev/nu
readahead_ratio = 50, ra_max = 1024kb
10.60s real  0.86s system  0.10s user  519+0 cs  dd if=$FILE of=/dev/nul

SMALL FILES: equals
===================
readahead_ratio = 0, ra_max = 128kb
20.14s real  0.68s system  14.45s user  21954+83 cs  grep -r 'asdfghjkl;
readahead_ratio = 50, ra_max = 1024kb
19.91s real  0.74s system  14.27s user  20298+433 cs  grep -r 'asdfghjkl

readahead_ratio = 0, ra_max = 128kb
20.10s real  0.66s system  14.19s user  21945+91 cs  grep -r 'asdfghjkl;
readahead_ratio = 50, ra_max = 1024kb
20.08s real  0.77s system  14.12s user  20464+251 cs  grep -r 'asdfghjkl


readahead_ratio = 0, ra_max = 128kb
19.73s real  1.78s system  0.90s user  44044+3 cs  diff -r $DIR $DIR2 >
readahead_ratio = 50, ra_max = 1024kb
19.85s real  1.79s system  0.92s user  45992+2 cs  diff -r $DIR $DIR2 >

readahead_ratio = 0, ra_max = 128kb
19.50s real  1.82s system  0.90s user  44039+0 cs  diff -r $DIR $DIR2 >
readahead_ratio = 50, ra_max = 1024kb
19.33s real  1.69s system  0.88s user  45991+4 cs  diff -r $DIR $DIR2 >

PARALLEL READS: 20-100% speed up
================================
dahead_ratio = 0, ra_max = 128kb
33.56s real  1.82s system  1.08s user  6342+15 cs  diff $FILE2 $FILE3
readahead_ratio = 50, ra_max = 1024kb
26.08s real  1.68s system  1.16s user  982+315 cs  diff $FILE2 $FILE3

readahead_ratio = 0, ra_max = 128kb
33.68s real  1.82s system  1.16s user  6283+24 cs  diff $FILE2 $FILE3
readahead_ratio = 50, ra_max = 1024kb
25.82s real  1.75s system  1.19s user  928+159 cs  diff $FILE2 $FILE3


readahead_ratio = 0, ra_max = 128kb
126.97s real  5.88s system  0.37s user  4050+200 cs  lftp -c "pget -n30
readahead_ratio = 50, ra_max = 1024kb
64.01s real  5.70s system  0.27s user  1058+125 cs  lftp -c "pget -n30 

readahead_ratio = 0, ra_max = 128kb
126.77s real  5.60s system  0.30s user  4034+170 cs  lftp -c "pget -n30
readahead_ratio = 50, ra_max = 1024kb
63.73s real  5.74s system  0.28s user  1066+169 cs  lftp -c "pget -n30 

NFS PARALLEL READS: 50-100% speed up
=================================
There are 8 nfs daemon running.  The NFS dir is exported with `ro,sync'
and mounted on localhost with `udp,rsize=8192'.

readahead_ratio = 0, ra_max = 128kb
61.67s real  2.29s system  1.16s user  34827+278 cs  diff $NFSFILE $NFSF
readahead_ratio = 50, ra_max = 1024kb
31.06s real  4.30s system  1.51s user  38823+10546 cs  diff $NFSFILE $NF

readahead_ratio = 0, ra_max = 128kb
61.57s real  2.14s system  1.05s user  35361+28 cs  diff $NFSFILE $NFSFI
readahead_ratio = 50, ra_max = 1024kb
31.31s real  4.45s system  1.72s user  38912+9458 cs  diff $NFSFILE $NFS

Change mount option to `tcp,rsize=32768' helps both:

readahead_ratio = 0, ra_max = 128kb
41.83s real  1.78s system  1.14s user  16926+34 cs  diff $NFSFILE $NFSFI
readahead_ratio = 50, ra_max = 1024kb
29.20s real  2.67s system  1.25s user  3323+9808 cs  diff $NFSFILE $NFSF

readahead_ratio = 0, ra_max = 128kb
41.22s real  1.89s system  1.82s user  13854+615 cs  diff $NFSFILE $NFSF
readahead_ratio = 50, ra_max = 1024kb
30.22s real  2.52s system  1.30s user  3365+9089 cs  diff $NFSFILE $NFSF


NFS SMALL READS: slightly speed up
==================================
readahead_ratio = 0, ra_max = 128kb
27.08s real  4.26s system  1.10s user  123702+11 cs  diff -r $NFSDIR $NF
readahead_ratio = 50, ra_max = 1024kb
26.59s real  4.03s system  1.16s user  122303+79 cs  diff -r $NFSDIR $NF

readahead_ratio = 0, ra_max = 128kb
27.11s real  4.22s system  1.17s user  123526+4 cs  diff -r $NFSDIR $NFS
readahead_ratio = 50, ra_max = 1024kb
26.41s real  4.13s system  1.15s user  122337+58 cs  diff -r $NFSDIR $NF

There should be more gain. The debug traces are full of 

[17217264.592000] readrandom(ino=6373709, pages=2, index=2-2-4) = 2
[17217264.592000] readrandom(ino=6373709, pages=7, index=4-4-6) = 2
[17217264.592000] readahead-newfile(ino=6373709, index=0, ra=0+10-0) = 10
[17217264.592000] readahead-newfile(ino=6373709, index=0, ra=0+10-0) = 8

[17217264.636000] readahead-newfile(ino=6373743, index=0, ra=0+8-6) = 8
[17217264.636000] readahead-newfile(ino=6373743, index=0, ra=0+12-0) = 12
[17217264.636000] readrandom(ino=6373743, pages=10, index=8-8-10) = 2
[17217264.636000] readrandom(ino=6373743, pages=12, index=10-10-12) = 2

It shows that there are multiple adjacent requests being processed at
the same time, which leads to unnecessary overheads and fragmented
requests. It can be solved by running only one nfsd daemon. I wonder
whether it should be fixed for NFSv3.  There are also many out of order
requests, which can be solved by using TCP.

SLOW READS: 800 streams on 64M without thrashing!
=================================================

In the test, a server is booted with mem=64M and 800 1KB/s read streams
on 2M files are created.

# echo 50 > /proc/sys/vm/readahead_ratio
# /usr/src/test/read_threads 80
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--------------------------------------------------------------------------------
# tail -36 /proc/vmstat
cache_miss 93123
readrandom 191
pgreadrandom 191
readahead_rescue 1412
pgreadahead_rescue 1412
readahead_end 74
readahead 128500
readahead_return 127607
readahead_eof 825
pgreadahead 410126
pgreadahead_hit 409948
pgreadahead_eof 2780
ra_newfile 967
ra_newfile_return 822
ra_newfile_eof 82
pgra_newfile 3719
pgra_newfile_hit 3609
pgra_newfile_eof 179
ra_state 34601
ra_state_return 34511
ra_state_eof 85
pgra_state 34906
pgra_state_hit 34838
pgra_state_eof 196
ra_context 92132
ra_context_return 91474
ra_context_eof 658
pgra_context 368301
pgra_context_hit 368301
pgra_context_eof 2405
ra_contexta 800
ra_contexta_return 800
ra_contexta_eof 0
pgra_contexta 3200
pgra_contexta_hit 3200
pgra_contexta_eof 0

That's near perfect: there are 191 thrashings out of 128500 read-aheads.

The stream number is only limited by the 16KB VM_MIN_READAHEAD. Adding
more readers just leads to a mixture of 4KB random reads and 16KB minimal
read-aheads.

Debug traces show that the current logic is only able to stay free of
thrashing within 70 streams. It seems that it has better ability to grab
memory:
When the current one runs with 70 streams:
Active:           9272 kB
Inactive:        35364 kB
When the new one runs with 50 streams:
Active:          11264 kB
Inactive:        33640 kB
When the new one runs with 800 streams:
Active:          11960 kB
Inactive:        30860 kB

Trimmed outputs of `iostat -x 100`:
New logic with 1000 streams:
rrqm/s   r/s    rsec/s   rkB/s  avgrq-sz avgqu-sz   await  svctm  %util
  0.15 100.77  1972.60  986.30     22.29     1.73   10.90   2.60  41.42
  0.17 103.37  2060.27 1030.14     22.51     1.53    9.32   2.46  40.50
  0.22 102.66  2041.61 1020.80     22.50     1.83   11.18   2.57  42.06
  0.08 103.56  2040.68 1020.34     22.37     1.51    9.14   2.57  42.40

New logic with 800 streams:
rrqm/s    r/s   rsec/s   rkB/s  avgrq-sz avgqu-sz   await  svctm  %util
  0.18  62.08  1633.92  816.96     26.83     0.51    4.60   1.44  15.95
  0.09  66.74  1552.56  776.28     25.05     0.39    3.42   0.95  10.86
  0.06  72.29  1607.36  803.68     24.37     0.48    4.01   1.18  14.05
  0.15  65.49  1594.96  797.48     25.40     0.36    3.14   0.96  10.90
  0.14  57.17  1534.16  767.08     26.91     0.41    3.90   1.02  10.78
  0.10  67.19  1590.32  795.16     25.22     0.38    3.28   0.93  10.79

New logic with 100 streams:
rrqm/s    r/s  rsec/s   rkB/s   avgrq-sz avgqu-sz   await  svctm  %util
  0.01   3.90  282.77  141.39      37.49     0.05    3.81   2.31   2.81
  0.02   2.63  222.88  111.44      36.50     0.03    3.19   1.51   1.64
  0.02   1.58  144.39   72.19      32.29     0.03    2.56   1.01   0.99
  0.00   2.64  233.22  116.61      37.40     0.03    2.88   1.65   1.79
  0.01   2.00  178.42   89.21      34.46     0.03    2.77   1.55   1.58
  0.04   2.90  205.34  102.67      33.55     0.04    3.08   1.51   1.72
  0.01   2.14  205.44  102.72      36.40     0.03    2.78   1.54   1.60
  0.02   2.11  199.02   99.51      35.76     0.03    2.66   1.50   1.56
  0.03   2.22  204.48  102.24      35.89     0.03    3.28   1.57   1.65

Current logic running 100 streams:
rrqm/s    r/s   rsec/s   rkB/s  avgrq-sz avgqu-sz   await  svctm  %util
  0.03  15.46   352.36  176.18     22.41     0.03    1.47   0.84   1.67
  0.02  21.37   281.20  140.60     14.44     0.02    0.81   0.47   1.20
  0.02  22.03   378.60  189.30     17.81     0.02    0.95   0.48   1.26
  0.00  16.43   237.44  118.72     15.82     0.02    0.85   0.41   0.85
  0.01  11.60   265.17  132.59     22.53     0.02    1.55   0.77   1.21
  0.00   7.06   246.18  123.09     29.73     0.02    2.19   1.06   1.19

Current logic running 70 streams:
rrqm/s    r/s   rsec/s   rkB/s  avgrq-sz avgqu-sz   await  svctm  %util
  0.05   2.85   273.63  136.81     51.40     0.03    4.12   2.38   1.72
  0.00   1.23   153.60   76.80     43.56     0.02    2.76   1.21   0.72
  0.02   1.25   153.62   76.81     43.69     0.02    2.81   1.15   0.68
  0.01   1.24   153.62   76.81     44.09     0.01    2.46   1.07   0.63
  0.01   0.87   110.08   55.04     39.08     0.01    2.14   0.90   0.50
  0.03   1.07    90.81   45.40     34.55     0.01    2.00   0.92   0.53
  0.00   1.46   179.22   89.61     46.26     0.02    2.81   1.37   0.85
  0.02   1.50   179.12   89.56     46.28     0.02    3.29   1.47   0.91
  0.00   1.36   166.34   83.17     45.11     0.02    2.55   1.35   0.82
  0.05   0.31    17.84    8.92     24.84     0.00    0.96   0.36   0.18
  0.01   1.46   179.24   89.62     46.54     0.02    2.80   1.31   0.81

Current logic running 50 streams:
rrqm/s    r/s   rsec/s   rkB/s  avgrq-sz avgqu-sz   await  svctm  %util
  0.09   5.77   145.09   72.55     25.92     0.05    5.17   1.19   1.15
  0.03   2.57   315.49  157.74     56.83     0.03    4.05   2.14   1.55
  0.00   0.00     0.00    0.00     20.68     0.00    0.54   0.07   0.03
  0.02   1.06   128.09   64.05     40.03     0.02    3.26   1.26   0.69
  0.00   1.03   128.03   64.01     40.74     0.01    2.48   1.07   0.58
  0.01   1.02   128.00   64.00     40.76     0.01    2.64   1.11   0.60
  0.00   0.00     0.00    0.00     20.97     0.00    0.88   0.11   0.05
  0.00   1.04   128.01   64.01     40.61     0.01    2.42   1.06   0.57
  0.01   1.05   128.01   64.01     40.21     0.01    2.53   1.03   0.56
  0.00   1.02   128.00   64.00     40.23     0.01    2.28   1.06   0.58
  0.00   0.47    56.33   28.16     29.92     0.01    1.76   0.74   0.36
  0.01   0.57    71.69   35.85     32.29     0.01    1.97   0.77   0.39
  0.00   1.02   127.99   63.99     40.55     0.01    2.28   1.06   0.57

New logic with 50 streams:
rrqm/s    r/s   rsec/s   rkB/s  avgrq-sz avgqu-sz   await  svctm  %util
  0.00   1.22   125.13   62.57     38.11     0.02    2.86   1.04   0.60
  0.00   0.45    49.76   24.88     29.35     0.01    1.52   0.46   0.22
  0.01   1.25   129.76   64.88     39.68     0.02    2.75   1.00   0.56
  0.00   1.14   120.48   60.24     38.50     0.02    3.25   1.19   0.65
  0.01   0.27    31.76   15.88     26.21     0.01    1.24   0.49   0.23
  0.00   1.29   129.29   64.65     38.89     0.02    3.09   1.22   0.69
  0.01   1.07   111.60   55.80     36.99     0.02    2.85   1.15   0.63
  0.00   0.58    61.45   30.72     30.31     0.01    1.75   0.76   0.39


CACHE HIT RATE: 91% hit on my PC
================================
The data represents my desktop activities:

cache-hit-rate = 100 * 31784 / 34694 % = 91%
read-ahead : random requests = 2589 : 369 = 7 : 1

% tail -n36 /proc/vmstat
cache_miss 548
readrandom 369
pgreadrandom 436
readahead_rescue 16
pgreadahead_rescue 421
readahead_end 6
readahead 2589
readahead_return 478
readahead_eof 1596
pgreadahead 34694
pgreadahead_hit 31784
pgreadahead_eof 8939
ra_newfile 2007
ra_newfile_return 218
ra_newfile_eof 1345
pgra_newfile 5543
pgra_newfile_hit 5132
pgra_newfile_eof 2499
ra_state 397
ra_state_return 146
ra_state_eof 229
pgra_state 24256
pgra_state_hit 22598
pgra_state_eof 6120
ra_context 131
ra_context_return 44
ra_context_eof 10
pgra_context 1817
pgra_context_hit 1254
pgra_context_eof 251
ra_contexta 54
ra_contexta_return 26
ra_contexta_eof 12
pgra_contexta 3078
pgra_contexta_hit 2794
pgra_contexta_eof 69

CACHE HIT PROBLEM
=================
The current logic constantly output debug traces like this:

[17201690.584000] blockable-readahead(ino=32397, ra=0+8) = 0
[17201690.584000] blockable-readahead(ino=35299, ra=0+8) = 0
[17201690.584000] blockable-readahead(ino=35299, ra=8+16) = 0
[17201690.588000] blockable-readahead(ino=35299, ra=24+32) = 0
[17201690.588000] blockable-readahead(ino=34842, ra=0+8) = 0
[17201690.592000] blockable-readahead(ino=240025, ra=0+8) = 0
[17201690.592000] blockable-readahead(ino=192049, ra=0+8) = 0
[17201690.592000] blockable-readahead(ino=128014, ra=0+8) = 0
[17201690.592000] blockable-readahead(ino=35299, ra=0+8) = 0
[17201690.592000] blockable-readahead(ino=35299, ra=8+16) = 0
[17201690.596000] blockable-readahead(ino=35299, ra=24+32) = 0
[17201690.596000] blockable-readahead(ino=34842, ra=0+8) = 0
[17201690.880000] blockable-readahead(ino=355834, ra=0+8) = 0
[17201690.880000] blockable-readahead(ino=192049, ra=0+8) = 0
[17201690.880000] blockable-readahead(ino=128014, ra=0+8) = 0

That cache hit problem will not ever happen in the new logic. It is
avoided implicitly.

OVERHEADS
=========
Most overheads are expected to happen when copying a big file with the
context based method. Here are the oprofile reports for the current
logic and the new logic with stateful method disabled:

  oprofile.8.4k                         |  oprofile.58.4k
--------------------------------------------------------------------------------
  CPU: P4 / Xeon with 2 hyper-threads, s|  CPU: P4 / Xeon with 2 hyper-threads,
  Counted GLOBAL_POWER_EVENTS events (ti|  Counted GLOBAL_POWER_EVENTS events (t
  samples  %        symbol name         |  samples  %        symbol name
  9734     29.2400  strnlen_user        |  9386     28.4097  strnlen_user       
  1489      4.4728  system_call         |  1471      4.4524  system_call        
  982       2.9498  do_generic_mapping_r|  1001      3.0298  do_generic_mapping_
  824       2.4752  add_to_page_cache   |  940       2.8452  __mod_page_state   
  698       2.0967  invalidate_complete_|  856       2.5910  add_to_page_cache  
  681       2.0457  do_mpage_readpage   |  694       2.1006  invalidate_complete
  631       1.8955  release_pages       |  681       2.0613  do_mpage_readpage  
  608       1.8264  __find_get_block    |  664       2.0098  release_pages      
  603       1.8114  kmap_atomic         |  609       1.8433  find_get_page      
  579       1.7393  radix_tree_delete   |  598       1.8100  __find_get_block   
  566       1.7002  find_get_page       |  571       1.7283  find_get_pages     
  540       1.6221  bad_range           |  524       1.5861  radix_tree_delete  
  520       1.5620  find_get_pages      |  505       1.5285  bad_range          
  495       1.4869  __wake_up_bit       |  494       1.4952  .text.lock.fs_write
  474       1.4239  .text.lock.fs_writeb|  470       1.4226  __inode_dir_notify 
  439       1.3187  __mod_page_state    |  430       1.3015  ext3_get_block_hand
  409       1.2286  __do_page_cache_read|  406       1.2289  __do_page_cache_rea
  387       1.1625  __inode_dir_notify  |  390       1.1805  __wake_up_bit      
  383       1.1505  __getblk_slow       |  373       1.1290  unlock_page        
  383       1.1505  unlock_page         |  367       1.1108  buffered_rmqueue   
  380       1.1415  buffered_rmqueue    |  354       1.0715  kmap_atomic        
  359       1.0784  ext3_get_block_handl|  353       1.0685  radix_tree_insert  
  341       1.0243  inotify_dentry_paren|  351       1.0624  __getblk_slow      
  340       1.0213  inotify_inode_queue_|  349       1.0564  inotify_dentry_pare
  334       1.0033  radix_tree_insert   |  346       1.0473  free_hot_cold_page 
  333       1.0003  mwait_idle          |  325       0.9837  dnotify_parent     
  331       0.9943  free_hot_cold_page  |  312       0.9444  inotify_inode_queue
  296       0.8892  invalidate_mapping_p|  312       0.9444  mwait_idle         
  294       0.8831  dnotify_parent      |  293       0.8869  invalidate_mapping_
  268       0.8050  __pagevec_lru_add   |  256       0.7749  __alloc_pages      
  250       0.7510  current_fs_time     |  250       0.7567  __pagevec_lru_add  
  233       0.6999  free_pages_bulk     |  248       0.7507  free_pages_bulk    
  228       0.6849  __alloc_pages       |  223       0.6750  __rmqueue          
  225       0.6759  restore_nocheck     |  219       0.6629  mark_offset_pmtmr  
  217       0.6518  mark_offset_pmtmr   |  213       0.6447  mark_page_accessed 
  202       0.6068  __rmqueue           |  213       0.6447  page_waitqueue     
  202       0.6068  find_busiest_group  |  206       0.6235  restore_nocheck    
  194       0.5828  mark_page_accessed  |  197       0.5963  current_fs_time    
  188       0.5647  page_waitqueue      |  188       0.5690  find_busiest_group 
  186       0.5587  apic_timer_interrupt|  180       0.5448  vfs_write          

  73        0.2193  page_cache_readahead|
  15        0.0451  ra_access           |
  6         0.0180  make_ahead_window   |
                                        |  52        0.1574  ra_access          
                                        |  26        0.0787  ra_dispatch        
                                        |  20        0.0605  page_cache_readahea
                                        |  13        0.0393  count_sequential_pa
                                        |  1         0.0030  lru_scan_forward   

This is another run:
  66        0.2189  page_cache_readahead|
  7         0.0232  make_ahead_window   |
                                        |  56        0.1871  ra_access          
                                        |  24        0.0802  ra_dispatch        
                                        |  20        0.0668  count_sequential_pa
                                        |  19        0.0635  page_cache_readahea
                                        |  2         0.0067  first_absent_page  
                                        |  1         0.0033  lru_scan_forward   

It shows that
- There are 79:112 / 73:122 samples in the two logics respectively.
- the main overheads happen in the accounting lines, which can be disabled.

TEST SCRIPTS
============
Please modify them before using.

# cat functions.sh
[[ -z "$bs" ]] && bs=4k

TIMEFMT="%E real  %S system  %U user  %w+%c cs  %J"
FILE=/test/bigfile
FILE2=${FILE}2
FILE3=${FILE}3
HUGEFILE=/test/hugefile

NFSFILE=/mnt/bigfile
NFSFILE2=${NFSFILE}2
NFSFILE3=${NFSFILE}3

DIR=/test/linux-2.6.13
DIR2=/test/linux-2.6.13.1

NFSDIR=/mnt/linux-2.6.13
NFSDIR2=/mnt/linux-2.6.13.1

clear_cache() {
        for file
        do
                fadvise $file 0 12345678900 dontneed
        done
}

init_test() {
        umount /test
        mount /test
        echo deadline > /sys/block/sdc/queue/scheduler
}

init_test_nfs() {
        umount /mnt
        /etc/init.d/nfs-kernel-server stop >/dev/null
        umount /test
        mount /test
        /etc/init.d/nfs-kernel-server start >/dev/null
        # mount -o rsize=8192 localhost:/test /mnt
        mount -o tcp,rsize=32768 localhost:/test /mnt
        echo deadline > /sys/block/sdc/queue/scheduler
}

init_readahead_ratio() {
        echo $1 > /proc/sys/vm/readahead_ratio
        if test $1 -lt 5; then
                RA_MAX=256
        else
                RA_MAX=2048
        fi
        blockdev --setra $RA_MAX /dev/sdc
        echo "readahead_ratio = $1, ra_max = $((RA_MAX/2))kb"
}

oprofile() {
        if [[ $1 == "start" ]]; then
                opcontrol --vmlinux=/usr/src/linux/vmlinux
                opcontrol --start
                opcontrol --reset
        else
                opcontrol --stop
                ra_ratio=$(< /proc/sys/vm/readahead_ratio)
                opreport -l -o oprofile.$ra_ratio.$bs /usr/src/linux/vmlinux
        fi
}

wait_program() {
        while {pidof $* > /dev/null};
        do
                sleep 1
        done
}
# cat test_ra.sh
#!/bin/zsh

source ./functions.sh

while test -n "$1"
do
        init_test
        init_readahead_ratio $1

        # time dd if=$FILE of=/dev/null bs=$bs 2>/dev/null
        # time diff $FILE2 $FILE3
        # time tar c $DIR | cat >/dev/null 2>/dev/null
        time diff -r $DIR $DIR2 >/dev/null
        # time grep -r 'asdfghjkl;' $DIR
        # time lftp -c "pget -n30 file://$HUGEFILE -o /dev/null"

        shift
done
# cat test_nfs.sh
#!/bin/zsh

. ./functions.sh

while test -n "$1"
do
        init_test_nfs
        init_readahead_ratio $1

        time diff $NFSFILE $NFSFILE2
        # time diff -r $NFSDIR $NFSDIR2 >/dev/null
        # time grep -r 'asdfghjkl;' $DIR

        shift
done
# cat read_threads.c
/* gcc -lpthread -o read_threads read_threads.c */
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/syscall.h>
#include <string.h>


#define READ_THREADS    100
#define THREAD_FILES    10
#define BLOCK_SIZE      4096

void *read_routine (void *arg)
{
        int i;
        int fd[THREAD_FILES];
        char buf[BLOCK_SIZE];


        memset(fd, 0, sizeof(fd));
        sleep(rand() % 10);
        printf("+");
        fflush(stdout);

        for (i = 0; i < THREAD_FILES; i++) {
                snprintf(buf, sizeof(buf), "/temp/kernel/test/%d", i + THREAD_FILES * (int)arg);
                if ((fd[i] = open(buf, O_RDONLY)) < 0)
                        goto out;
        }

        for (;;) {
                for (i = 0; i < THREAD_FILES; i++) {
                        if (read(fd[i], buf, sizeof(buf)) <= 0)
                                goto out;
                        usleep((BLOCK_SIZE / 1024) * 1000000 / THREAD_FILES);
                }
        }

out:
        for (i = 0; i < THREAD_FILES; i++)
                if (fd[i] > 0)
                        close(fd[i]);

        printf("-");
        fflush(stdout);
        return NULL;
}

int main (int argc, char *argv[])
{
        pthread_t thread_id[READ_THREADS];
        int i;
        int count = 0;
        int status;

        srand(time(NULL));

        /* enable early reclaim */
        /* syscall(251,0,1,1); */

        if (argc > 1)
                count = atoi(argv[1]);
        if (count > READ_THREADS)
                count = READ_THREADS;

        for (i = 0; i < count; i++) {
                status = pthread_create (&thread_id[i], NULL,
                                read_routine, (void*)i);
                if (status != 0)
                        break;
                usleep(10000);
        }

        for (i--; i >= 0; i--)
                pthread_join (thread_id[i], NULL);

        printf("\n");

        return 0;
}


diff -rup linux-2.6.13.1-orig/drivers/block/loop.c linux-2.6.13.1/drivers/block/loop.c
--- linux-2.6.13.1-orig/drivers/block/loop.c	2005-09-09 22:42:58.000000000 -0400
+++ linux-2.6.13.1/drivers/block/loop.c	2005-10-03 19:17:16.000000000 -0400
@@ -768,6 +768,11 @@ static int loop_set_fd(struct loop_devic
 
 	mapping = file->f_mapping;
 	inode = mapping->host;
+	/*
+	 * The upper layer should already do proper read-ahead,
+	 * unlimited read-ahead here only ruins the cache hit rate.
+	 */
+	file->f_ra.ra_pages = 32 >> (PAGE_CACHE_SHIFT - 10);
 
 	if (!(file->f_mode & FMODE_WRITE))
 		lo_flags |= LO_FLAGS_READ_ONLY;
diff -rup linux-2.6.13.1-orig/include/linux/fs.h linux-2.6.13.1/include/linux/fs.h
--- linux-2.6.13.1-orig/include/linux/fs.h	2005-09-09 22:42:58.000000000 -0400
+++ linux-2.6.13.1/include/linux/fs.h	2005-10-03 15:27:44.000000000 -0400
@@ -577,10 +577,26 @@ struct file_ra_state {
 	unsigned long ra_pages;		/* Maximum readahead window */
 	unsigned long mmap_hit;		/* Cache hit stat for mmap accesses */
 	unsigned long mmap_miss;	/* Cache miss stat for mmap accesses */
+
+	unsigned long la_index;
+	unsigned long ra_index;
+	unsigned long lookahead_index;
+	unsigned long readahead_index;
+	unsigned long nr_page_aging;
 };
 #define RA_FLAG_MISS 0x01	/* a cache miss occured against this file */
 #define RA_FLAG_INCACHE 0x02	/* file is already in cache */
 
+#define RA_CLASS_SHIFT 3
+#define RA_CLASS_MASK  ((1 << RA_CLASS_SHIFT) - 1)
+enum file_ra_class { /* the same order must be kept in page_state */
+	RA_CLASS_NEWFILE = 1,
+	RA_CLASS_STATE,
+	RA_CLASS_CONTEXT,
+	RA_CLASS_CONTEXT_ACCELERATED,
+	RA_CLASS_END
+};
+
 struct file {
 	struct list_head	f_list;
 	struct dentry		*f_dentry;
diff -rup linux-2.6.13.1-orig/include/linux/mm.h linux-2.6.13.1/include/linux/mm.h
--- linux-2.6.13.1-orig/include/linux/mm.h	2005-09-09 22:42:58.000000000 -0400
+++ linux-2.6.13.1/include/linux/mm.h	2005-10-01 22:02:41.000000000 -0400
@@ -875,7 +875,7 @@ extern int filemap_populate(struct vm_ar
 int write_one_page(struct page *page, int wait);
 
 /* readahead.c */
-#define VM_MAX_READAHEAD	128	/* kbytes */
+#define VM_MAX_READAHEAD	1024	/* kbytes */
 #define VM_MIN_READAHEAD	16	/* kbytes (includes current page) */
 #define VM_MAX_CACHE_HIT    	256	/* max pages in a row in cache before
 					 * turning readahead off */
@@ -889,6 +889,13 @@ unsigned long  page_cache_readahead(stru
 			  struct file *filp,
 			  unsigned long offset,
 			  unsigned long size);
+unsigned long
+page_cache_readahead_adaptive(struct address_space *mapping,
+			struct file_ra_state *ra, struct file *filp,
+			struct page *prev_page, struct page *page,
+			unsigned long first_index,
+			unsigned long index, unsigned long last_index);
+void fastcall ra_access(struct file_ra_state *ra, struct page *page);
 void handle_ra_miss(struct address_space *mapping, 
 		    struct file_ra_state *ra, pgoff_t offset);
 unsigned long max_sane_readahead(unsigned long nr);
diff -rup linux-2.6.13.1-orig/include/linux/mm_inline.h linux-2.6.13.1/include/linux/mm_inline.h
--- linux-2.6.13.1-orig/include/linux/mm_inline.h	2005-09-09 22:42:58.000000000 -0400
+++ linux-2.6.13.1/include/linux/mm_inline.h	2005-10-03 15:43:53.000000000 -0400
@@ -11,6 +11,7 @@ add_page_to_inactive_list(struct zone *z
 {
 	list_add(&page->lru, &zone->inactive_list);
 	zone->nr_inactive++;
+	zone->nr_page_aging++;
 }
 
 static inline void
diff -rup linux-2.6.13.1-orig/include/linux/mmzone.h linux-2.6.13.1/include/linux/mmzone.h
--- linux-2.6.13.1-orig/include/linux/mmzone.h	2005-09-09 22:42:58.000000000 -0400
+++ linux-2.6.13.1/include/linux/mmzone.h	2005-10-05 10:48:26.000000000 -0400
@@ -153,6 +153,20 @@ struct zone {
 	unsigned long		pages_scanned;	   /* since last reclaim */
 	int			all_unreclaimable; /* All pages pinned */
 
+	/* Fields for balanced page aging:
+	 * nr_page_aging   - The accumulated number of activities that may
+	 *                   cause page aging, that is, make some pages closer
+	 *                   to the tail of inactive_list.
+	 * aging_milestone - A snapshot of nr_page_aging every time a full
+	 *                   inactive_list of pages become aged.
+	 * page_age        - A normalized value showing the percent of pages
+	 *                   have been aged.  It is compared between zones to
+	 *                   balance the rate of page aging.
+	 */
+	unsigned long		nr_page_aging;
+	unsigned long		aging_milestone;
+	unsigned long		page_age;
+
 	/*
 	 * Does the allocator try to reclaim pages from the zone as soon
 	 * as it fails a watermark_ok() in __alloc_pages?
@@ -314,6 +328,43 @@ static inline void memory_present(int ni
 unsigned long __init node_memmap_size_bytes(int, unsigned long, unsigned long);
 #endif
 
+#ifdef CONFIG_HIGHMEM64G
+#define		PAGE_AGE_SHIFT  8
+#elif BITS_PER_LONG == 32
+#define		PAGE_AGE_SHIFT  12
+#elif BITS_PER_LONG == 64
+#define		PAGE_AGE_SHIFT  20
+#else
+#error unknown BITS_PER_LONG
+#endif
+#define		PAGE_AGE_MASK   ((1 << PAGE_AGE_SHIFT) - 1)
+
+/*
+ * The percent of pages in inactive_list that have been scanned / aged.
+ * It's not really ##%, but a high resolution normalized value.
+ */
+static inline void update_page_age(struct zone *z)
+{
+	if (z->nr_page_aging - z->aging_milestone > z->nr_inactive)
+		z->aging_milestone += z->nr_inactive;
+
+	z->page_age = ((z->nr_page_aging - z->aging_milestone)
+				<< PAGE_AGE_SHIFT) / (1 + z->nr_inactive);
+}
+
+/*
+ * The simplified code is:
+ *         return (a->page_age > b->page_age);
+ * The complexity deals with the wrap-around problem.
+ * Two page ages not close enough should also be ignored:
+ * they are out of sync and the comparison may be nonsense.
+ */
+static inline int pages_more_aged(struct zone *a, struct zone *b)
+{
+	return ((b->page_age - a->page_age) & PAGE_AGE_MASK) >
+			PAGE_AGE_MASK - (1 << (PAGE_AGE_SHIFT - 2));
+}
+
 /*
  * zone_idx() returns 0 for the ZONE_DMA zone, 1 for the ZONE_NORMAL zone, etc.
  */
diff -rup linux-2.6.13.1-orig/include/linux/page-flags.h linux-2.6.13.1/include/linux/page-flags.h
--- linux-2.6.13.1-orig/include/linux/page-flags.h	2005-09-09 22:42:58.000000000 -0400
+++ linux-2.6.13.1/include/linux/page-flags.h	2005-10-04 22:46:25.000000000 -0400
@@ -75,6 +75,8 @@
 #define PG_reclaim		17	/* To be reclaimed asap */
 #define PG_nosave_free		18	/* Free, should not be written */
 #define PG_uncached		19	/* Page has been mapped as uncached */
+#define PG_activate		20	/* delayed activate */
+#define PG_readahead		21	/* check readahead when reading this page */
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -131,6 +133,48 @@ struct page_state {
 
 	unsigned long pgrotated;	/* pages rotated to tail of the LRU */
 	unsigned long nr_bounce;	/* pages for bounce buffers */
+
+	unsigned long cache_miss;	/* read cache misses */
+	unsigned long readrandom;	/* random reads */
+	unsigned long pgreadrandom;	/* random read pages */
+	unsigned long readahead_rescue; /* read-aheads rescued*/
+	unsigned long pgreadahead_rescue;
+	unsigned long readahead_end;	/* read-aheads passed EOF */
+
+	unsigned long readahead;	/* read-aheads issued */
+	unsigned long readahead_return;	/* look-ahead marks returned */
+	unsigned long readahead_eof;	/* read-aheads stop at EOF */
+	unsigned long pgreadahead;	/* read-ahead pages issued */
+	unsigned long pgreadahead_hit;	/* read-ahead pages accessed */
+	unsigned long pgreadahead_eof;
+
+	unsigned long ra_newfile;	/* read-ahead on start of file */
+	unsigned long ra_newfile_return;
+	unsigned long ra_newfile_eof;
+	unsigned long pgra_newfile;
+	unsigned long pgra_newfile_hit;
+	unsigned long pgra_newfile_eof;
+
+	unsigned long ra_state;		/* state based read-ahead */
+	unsigned long ra_state_return;
+	unsigned long ra_state_eof;
+	unsigned long pgra_state;
+	unsigned long pgra_state_hit;
+	unsigned long pgra_state_eof;
+
+	unsigned long ra_context;	/* context based read-ahead */
+	unsigned long ra_context_return;
+	unsigned long ra_context_eof;
+	unsigned long pgra_context;
+	unsigned long pgra_context_hit;
+	unsigned long pgra_context_eof;
+
+	unsigned long ra_contexta;	/* accelerated context based read-ahead */
+	unsigned long ra_contexta_return;
+	unsigned long ra_contexta_eof;
+	unsigned long pgra_contexta;
+	unsigned long pgra_contexta_hit;
+	unsigned long pgra_contexta_eof;
 };
 
 extern void get_page_state(struct page_state *ret);
@@ -305,6 +349,18 @@ extern void __mod_page_state(unsigned lo
 #define SetPageUncached(page)	set_bit(PG_uncached, &(page)->flags)
 #define ClearPageUncached(page)	clear_bit(PG_uncached, &(page)->flags)
 
+#define PageActivate(page)	test_bit(PG_activate, &(page)->flags)
+#define SetPageActivate(page)	set_bit(PG_activate, &(page)->flags)
+#define ClearPageActivate(page)	clear_bit(PG_activate, &(page)->flags)
+#define TestClearPageActivate(page) test_and_clear_bit(PG_activate, &(page)->flags)
+#define TestSetPageActivate(page) test_and_set_bit(PG_activate, &(page)->flags)
+
+#define PageReadahead(page)	test_bit(PG_readahead, &(page)->flags)
+#define SetPageReadahead(page)	set_bit(PG_readahead, &(page)->flags)
+#define ClearPageReadahead(page) clear_bit(PG_readahead, &(page)->flags)
+#define TestClearPageReadahead(page) test_and_clear_bit(PG_readahead, &(page)->flags)
+#define TestSetPageReadahead(page) test_and_set_bit(PG_readahead, &(page)->flags)
+
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
diff -rup linux-2.6.13.1-orig/include/linux/sysctl.h linux-2.6.13.1/include/linux/sysctl.h
--- linux-2.6.13.1-orig/include/linux/sysctl.h	2005-09-09 22:42:58.000000000 -0400
+++ linux-2.6.13.1/include/linux/sysctl.h	2005-10-03 15:41:19.000000000 -0400
@@ -180,6 +180,7 @@ enum
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
 	VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
+	VM_READAHEAD_RATIO=29, /* percent of read-ahead size to thrashing-threshold */
 };
 
 
diff -rup linux-2.6.13.1-orig/kernel/sysctl.c linux-2.6.13.1/kernel/sysctl.c
--- linux-2.6.13.1-orig/kernel/sysctl.c	2005-09-09 22:42:58.000000000 -0400
+++ linux-2.6.13.1/kernel/sysctl.c	2005-10-01 22:02:41.000000000 -0400
@@ -66,6 +66,7 @@ extern int min_free_kbytes;
 extern int printk_ratelimit_jiffies;
 extern int printk_ratelimit_burst;
 extern int pid_max_min, pid_max_max;
+extern int readahead_ratio;
 
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 int unknown_nmi_panic;
@@ -851,6 +852,16 @@ static ctl_table vm_table[] = {
 		.strategy	= &sysctl_jiffies,
 	},
 #endif
+	{
+		.ctl_name	= VM_READAHEAD_RATIO,
+		.procname	= "readahead_ratio",
+		.data		= &readahead_ratio,
+		.maxlen		= sizeof(readahead_ratio),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+	},
 	{ .ctl_name = 0 }
 };
 
diff -rup linux-2.6.13.1-orig/mm/filemap.c linux-2.6.13.1/mm/filemap.c
--- linux-2.6.13.1-orig/mm/filemap.c	2005-09-09 22:42:58.000000000 -0400
+++ linux-2.6.13.1/mm/filemap.c	2005-10-01 22:02:41.000000000 -0400
@@ -699,6 +699,8 @@ grab_cache_page_nowait(struct address_sp
 
 EXPORT_SYMBOL(grab_cache_page_nowait);
 
+extern int readahead_ratio;
+
 /*
  * This is a generic file read routine, and uses the
  * mapping->a_ops->readpage() function for the actual low-level
@@ -726,10 +728,12 @@ void do_generic_mapping_read(struct addr
 	unsigned long prev_index;
 	loff_t isize;
 	struct page *cached_page;
+	struct page *prev_page;
 	int error;
 	struct file_ra_state ra = *_ra;
 
 	cached_page = NULL;
+	prev_page = NULL;
 	index = *ppos >> PAGE_CACHE_SHIFT;
 	next_index = index;
 	prev_index = ra.prev_page;
@@ -758,16 +762,35 @@ void do_generic_mapping_read(struct addr
 		nr = nr - offset;
 
 		cond_resched();
-		if (index == next_index)
+		
+		if (readahead_ratio <= 9 && index == next_index)
 			next_index = page_cache_readahead(mapping, &ra, filp,
 					index, last_index - index);
 
 find_page:
 		page = find_get_page(mapping, index);
+		if (readahead_ratio > 9) {
+			if (unlikely(page == NULL)) {
+				page_cache_readahead_adaptive(mapping, &ra,
+						filp, prev_page, NULL,
+						*ppos >> PAGE_CACHE_SHIFT,
+						index, last_index);
+				page = find_get_page(mapping, index);
+			} else if (PageReadahead(page)) {
+				page_cache_readahead_adaptive(mapping, &ra,
+						filp, prev_page, page,
+						*ppos >> PAGE_CACHE_SHIFT,
+						index, last_index);
+			}
+		}
 		if (unlikely(page == NULL)) {
-			handle_ra_miss(mapping, &ra, index);
+			if (readahead_ratio <= 9)
+				handle_ra_miss(mapping, &ra, index);
 			goto no_cached_page;
 		}
+		if (prev_page)
+			page_cache_release(prev_page);
+		prev_page = page;
 		if (!PageUptodate(page))
 			goto page_not_up_to_date;
 page_ok:
@@ -783,8 +806,10 @@ page_ok:
 		 * When (part of) the same page is read multiple times
 		 * in succession, only mark it as accessed the first time.
 		 */
-		if (prev_index != index)
+		if (prev_index != index) {
+			ra_access(&ra, page);
 			mark_page_accessed(page);
+		}
 		prev_index = index;
 
 		/*
@@ -802,7 +827,6 @@ page_ok:
 		index += offset >> PAGE_CACHE_SHIFT;
 		offset &= ~PAGE_CACHE_MASK;
 
-		page_cache_release(page);
 		if (ret == nr && desc->count)
 			continue;
 		goto out;
@@ -814,7 +838,6 @@ page_not_up_to_date:
 		/* Did it get unhashed before we got the lock? */
 		if (!page->mapping) {
 			unlock_page(page);
-			page_cache_release(page);
 			continue;
 		}
 
@@ -839,7 +862,6 @@ readpage:
 					 * invalidate_inode_pages got it
 					 */
 					unlock_page(page);
-					page_cache_release(page);
 					goto find_page;
 				}
 				unlock_page(page);
@@ -860,7 +882,6 @@ readpage:
 		isize = i_size_read(inode);
 		end_index = (isize - 1) >> PAGE_CACHE_SHIFT;
 		if (unlikely(!isize || index > end_index)) {
-			page_cache_release(page);
 			goto out;
 		}
 
@@ -869,7 +890,6 @@ readpage:
 		if (index == end_index) {
 			nr = ((isize - 1) & ~PAGE_CACHE_MASK) + 1;
 			if (nr <= offset) {
-				page_cache_release(page);
 				goto out;
 			}
 		}
@@ -879,7 +899,6 @@ readpage:
 readpage_error:
 		/* UHHUH! A synchronous read error occurred. Report it */
 		desc->error = error;
-		page_cache_release(page);
 		goto out;
 
 no_cached_page:
@@ -904,15 +923,22 @@ no_cached_page:
 		}
 		page = cached_page;
 		cached_page = NULL;
+		if (prev_page)
+			page_cache_release(prev_page);
+		prev_page = page;
 		goto readpage;
 	}
 
 out:
 	*_ra = ra;
+	if (readahead_ratio > 9)
+		_ra->prev_page = prev_index;
 
 	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;
 	if (cached_page)
 		page_cache_release(cached_page);
+	if (prev_page)
+		page_cache_release(prev_page);
 	if (filp)
 		file_accessed(filp);
 }
@@ -1210,19 +1236,33 @@ retry_all:
 	 *
 	 * For sequential accesses, we use the generic readahead logic.
 	 */
-	if (VM_SequentialReadHint(area))
+	if (readahead_ratio <= 9 && VM_SequentialReadHint(area))
 		page_cache_readahead(mapping, ra, file, pgoff, 1);
 
+
 	/*
 	 * Do we have something in the page cache already?
 	 */
 retry_find:
 	page = find_get_page(mapping, pgoff);
+	if (VM_SequentialReadHint(area) && readahead_ratio > 9) {
+		if (!page) {
+			page_cache_readahead_adaptive(mapping, ra,
+						file, NULL, NULL,
+						pgoff, pgoff, pgoff + 1);
+			page = find_get_page(mapping, pgoff);
+		} else if (PageReadahead(page)) {
+			page_cache_readahead_adaptive(mapping, ra,
+						file, NULL, page,
+						pgoff, pgoff, pgoff + 1);
+		}
+	}
 	if (!page) {
 		unsigned long ra_pages;
 
 		if (VM_SequentialReadHint(area)) {
-			handle_ra_miss(mapping, ra, pgoff);
+			if (readahead_ratio <= 9)
+				handle_ra_miss(mapping, ra, pgoff);
 			goto no_cached_page;
 		}
 		ra->mmap_miss++;
@@ -1247,6 +1287,13 @@ retry_find:
 		if (ra_pages) {
 			pgoff_t start = 0;
 
+			/*
+			 * Max read-around should be much smaller than
+			 * max read-ahead.
+			 * How about adding a tunable parameter for this?
+			 */
+			if (ra_pages > 64)
+				ra_pages = 64;
 			if (pgoff > ra_pages / 2)
 				start = pgoff - ra_pages / 2;
 			do_page_cache_readahead(mapping, file, start, ra_pages);
@@ -1270,6 +1317,7 @@ success:
 	/*
 	 * Found the page and have a reference on it.
 	 */
+	ra_access(ra, page);
 	mark_page_accessed(page);
 	if (type)
 		*type = majmin;
diff -rup linux-2.6.13.1-orig/mm/page_alloc.c linux-2.6.13.1/mm/page_alloc.c
--- linux-2.6.13.1-orig/mm/page_alloc.c	2005-09-09 22:42:58.000000000 -0400
+++ linux-2.6.13.1/mm/page_alloc.c	2005-10-05 16:25:20.000000000 -0400
@@ -109,9 +109,10 @@ static void bad_page(const char *functio
 			1 << PG_private |
 			1 << PG_locked	|
 			1 << PG_active	|
+			1 << PG_activate|
 			1 << PG_dirty	|
 			1 << PG_reclaim |
-			1 << PG_slab    |
+			1 << PG_slab	|
 			1 << PG_swapcache |
 			1 << PG_writeback);
 	set_page_count(page, 0);
@@ -459,6 +460,7 @@ static void prep_new_page(struct page *p
 
 	page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
 			1 << PG_referenced | 1 << PG_arch_1 |
+			1 << PG_activate | 1 << PG_readahead |
 			1 << PG_checked | 1 << PG_mappedtodisk);
 	page->private = 0;
 	set_page_refs(page, order);
@@ -783,9 +785,15 @@ __alloc_pages(unsigned int __nocast gfp_
 	struct task_struct *p = current;
 	int i;
 	int classzone_idx;
+	int do_reclaim;
 	int do_retry;
 	int can_try_harder;
 	int did_some_progress;
+	unsigned long zones_mask;
+	int left_count;
+	int batch_size;
+	int batch_base;
+	int batch_idx;
 
 	might_sleep_if(wait);
 
@@ -806,9 +814,57 @@ __alloc_pages(unsigned int __nocast gfp_
 	classzone_idx = zone_idx(zones[0]);
 
 restart:
-	/* Go through the zonelist once, looking for a zone with enough free */
-	for (i = 0; (z = zones[i]) != NULL; i++) {
-		int do_reclaim = should_reclaim_zone(z, gfp_mask);
+	/*
+	 * To fulfill three goals:
+	 * - balanced page aging
+	 * - locality
+	 * - predefined zonelist priority
+	 *
+	 * The logic employs the following rules:
+	 * 1. Zones are checked in predefined order in general.
+	 * 2. Skip to the next zone if it has lower page_age.
+	 * 3. Checkings are carried out in batch, all zones in a batch must be
+	 *    checked before entering the next batch.
+	 * 4. All local zones in the zonelist forms the first batch.
+	 */
+
+	/* TODO: Avoid this loop by putting the values into struct zonelist.
+	 * The (more general) desired batch counts can also go there.
+	 */
+	for (batch_size = 0, i = 0; (z = zones[i]) != NULL; i++) {
+		if (z->zone_pgdat == zones[0]->zone_pgdat)
+			batch_size++;
+	}
+	BUG_ON(!batch_size);
+
+	left_count = i - batch_size;
+	batch_base = 0;
+	batch_idx = 0;
+	zones_mask = 0;
+
+	for (;;) {
+		if (zones_mask == (1 << batch_size) - 1) {
+			if (left_count <= 0) {
+				break;
+			}
+			batch_base += batch_size;
+			batch_size = min(left_count, (int)sizeof(zones_mask) * 8);
+			left_count -= batch_size;
+			batch_idx = 0;
+			zones_mask = 0;
+		}
+
+		do {
+			i = batch_idx;
+			do {
+				if (++batch_idx >= batch_size)
+					batch_idx = 0;
+			} while (zones_mask & (1 << batch_idx));
+		} while (pages_more_aged(zones[batch_base + i],
+					 zones[batch_base + batch_idx]));
+
+		zones_mask |= (1 << i);
+		z = zones[batch_base + i];
 
 		if (!cpuset_zone_allowed(z))
 			continue;
@@ -818,11 +874,12 @@ restart:
 		 * will try to reclaim pages and check the watermark a second
 		 * time before giving up and falling back to the next zone.
 		 */
+		do_reclaim = should_reclaim_zone(z, gfp_mask);
 zone_reclaim_retry:
 		if (!zone_watermark_ok(z, order, z->pages_low,
 				       classzone_idx, 0, 0)) {
 			if (!do_reclaim)
-				continue;
+				goto try_harder;
 			else {
 				zone_reclaim(z, gfp_mask, order);
 				/* Only try reclaim once */
@@ -834,19 +891,17 @@ zone_reclaim_retry:
 		page = buffered_rmqueue(z, order, gfp_mask);
 		if (page)
 			goto got_pg;
-	}
 
-	for (i = 0; (z = zones[i]) != NULL; i++)
+try_harder:
 		wakeup_kswapd(z, order);
 
-	/*
-	 * Go through the zonelist again. Let __GFP_HIGH and allocations
-	 * coming from realtime tasks to go deeper into reserves
-	 *
-	 * This is the last chance, in general, before the goto nopage.
-	 * Ignore cpuset if GFP_ATOMIC (!wait) rather than fail alloc.
-	 */
-	for (i = 0; (z = zones[i]) != NULL; i++) {
+		/*
+		 * Put stress on the zone. Let __GFP_HIGH and allocations
+		 * coming from realtime tasks to go deeper into reserves.
+		 *
+		 * This is the last chance, in general, before the goto nopage.
+		 * Ignore cpuset if GFP_ATOMIC (!wait) rather than fail alloc.
+		 */
 		if (!zone_watermark_ok(z, order, z->pages_min,
 				       classzone_idx, can_try_harder,
 				       gfp_mask & __GFP_HIGH))
@@ -1335,6 +1390,8 @@ void show_free_areas(void)
 			" active:%lukB"
 			" inactive:%lukB"
 			" present:%lukB"
+			" aging:%lukB"
+			" age:%lu"
 			" pages_scanned:%lu"
 			" all_unreclaimable? %s"
 			"\n",
@@ -1346,6 +1403,8 @@ void show_free_areas(void)
 			K(zone->nr_active),
 			K(zone->nr_inactive),
 			K(zone->present_pages),
+			K(zone->nr_page_aging),
+			zone->page_age,
 			zone->pages_scanned,
 			(zone->all_unreclaimable ? "yes" : "no")
 			);
@@ -1909,6 +1968,9 @@ static void __init free_area_init_core(s
 		zone->nr_scan_inactive = 0;
 		zone->nr_active = 0;
 		zone->nr_inactive = 0;
+		zone->nr_page_aging = 0;
+		zone->aging_milestone = 0;
+		zone->page_age = 0;
 		atomic_set(&zone->reclaim_in_progress, -1);
 		if (!size)
 			continue;
@@ -2080,6 +2142,8 @@ static int zoneinfo_show(struct seq_file
 			   "\n        high     %lu"
 			   "\n        active   %lu"
 			   "\n        inactive %lu"
+			   "\n        aging    %lu"
+			   "\n        age      %lu"
 			   "\n        scanned  %lu (a: %lu i: %lu)"
 			   "\n        spanned  %lu"
 			   "\n        present  %lu",
@@ -2089,6 +2153,8 @@ static int zoneinfo_show(struct seq_file
 			   zone->pages_high,
 			   zone->nr_active,
 			   zone->nr_inactive,
+			   zone->nr_page_aging,
+			   zone->page_age,
 			   zone->pages_scanned,
 			   zone->nr_scan_active, zone->nr_scan_inactive,
 			   zone->spanned_pages,
@@ -2210,6 +2276,49 @@ static char *vmstat_text[] = {
 
 	"pgrotated",
 	"nr_bounce",
+
+	"cache_miss",
+	"readrandom",
+	"pgreadrandom",
+	"readahead_rescue",
+	"pgreadahead_rescue",
+	"readahead_end",
+
+	"readahead",
+	"readahead_return",
+	"readahead_eof",
+	"pgreadahead",
+	"pgreadahead_hit",
+	"pgreadahead_eof",
+
+	"ra_newfile",
+	"ra_newfile_return",
+	"ra_newfile_eof",
+	"pgra_newfile",
+	"pgra_newfile_hit",
+	"pgra_newfile_eof",
+
+	"ra_state",
+	"ra_state_return",
+	"ra_state_eof",
+	"pgra_state",
+	"pgra_state_hit",
+	"pgra_state_eof",
+
+	"ra_context",
+	"ra_context_return",
+	"ra_context_eof",
+	"pgra_context",
+	"pgra_context_hit",
+	"pgra_context_eof",
+
+	"ra_contexta",
+	"ra_contexta_return",
+	"ra_contexta_eof",
+	"pgra_contexta",
+	"pgra_contexta_hit",
+	"pgra_contexta_eof",
+
 };
 
 static void *vmstat_start(struct seq_file *m, loff_t *pos)
diff -rup linux-2.6.13.1-orig/mm/readahead.c linux-2.6.13.1/mm/readahead.c
--- linux-2.6.13.1-orig/mm/readahead.c	2005-09-09 22:42:58.000000000 -0400
+++ linux-2.6.13.1/mm/readahead.c	2005-10-06 08:16:32.000000000 -0400
@@ -15,6 +15,54 @@
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
 
+#if 1
+#define dprintk(args...) \
+	if (readahead_ratio & 1) printk(KERN_DEBUG args)
+#define ddprintk(args...) \
+	if ((readahead_ratio & 3) == 3) printk(KERN_DEBUG args)
+
+#define ra_account_page(ra, member, delta)	do {			\
+	unsigned long opg = offsetof(struct page_state, pgreadahead) - 	\
+				offsetof(struct page_state, readahead);	\
+	unsigned long o1 = offsetof(struct page_state, member);		\
+	unsigned long o2 = o1 + 2 * opg * ((ra)->flags & RA_CLASS_MASK);\
+	BUG_ON(opg + o2 >= sizeof(struct page_state));			\
+	__mod_page_state(o1, 1UL);					\
+	__mod_page_state(o2, 1UL);					\
+	__mod_page_state(opg + o1, (delta));				\
+	__mod_page_state(opg + o2, (delta));				\
+} while (0)
+
+#define ra_account(member, class, delta)	do {			\
+	unsigned long opg = offsetof(struct page_state, pgreadahead) - 	\
+				offsetof(struct page_state, readahead);	\
+	unsigned long o1 = offsetof(struct page_state, member);		\
+	unsigned long o2 = o1 + 2 * opg * (class);			\
+	if ((class) >= RA_CLASS_END)					\
+		break;							\
+	BUG_ON(o2 >= sizeof(struct page_state));			\
+	__mod_page_state(o1, (delta));					\
+	__mod_page_state(o2, (delta));					\
+} while (0)
+
+#else
+#undef inc_page_state
+#undef mod_page_state
+#define inc_page_state(a)    do {} while(0)
+#define mod_page_state(a, b) do {} while(0)
+#define dprintk(args...)     do {} while(0)
+#define ddprintk(args...)    do {} while(0)
+#define ra_account(member, class, delta)	do {} while(0)
+#define ra_account_page(member, class, delta)	do {} while(0)
+#endif
+
+/* Set look-ahead size to 1/8 of the read-ahead size. */
+#define LOOKAHEAD_RATIO 8
+
+/* Set read-ahead size to ##% of the thrashing-threshold. */
+int readahead_ratio = 0;   
+EXPORT_SYMBOL(readahead_ratio);
+
 void default_unplug_io_fn(struct backing_dev_info *bdi, struct page *page)
 {
 }
@@ -254,10 +302,11 @@ out:
  */
 static int
 __do_page_cache_readahead(struct address_space *mapping, struct file *filp,
-			unsigned long offset, unsigned long nr_to_read)
+			unsigned long offset, unsigned long nr_to_read,
+			unsigned long lookahead_size)
 {
 	struct inode *inode = mapping->host;
-	struct page *page;
+	struct page *page = NULL;
 	unsigned long end_index;	/* The last page we want to read */
 	LIST_HEAD(page_pool);
 	int page_idx;
@@ -267,7 +316,7 @@ __do_page_cache_readahead(struct address
 	if (isize == 0)
 		goto out;
 
- 	end_index = ((isize - 1) >> PAGE_CACHE_SHIFT);
+	end_index = ((isize - 1) >> PAGE_CACHE_SHIFT);
 
 	/*
 	 * Preallocate as many pages as we will need.
@@ -290,6 +339,9 @@ __do_page_cache_readahead(struct address
 			break;
 		page->index = page_offset;
 		list_add(&page->lru, &page_pool);
+		if (readahead_ratio > 9 &&
+				page_idx == nr_to_read - lookahead_size)
+			SetPageReadahead(page);
 		ret++;
 	}
 	read_unlock_irq(&mapping->tree_lock);
@@ -326,7 +378,7 @@ int force_page_cache_readahead(struct ad
 		if (this_chunk > nr_to_read)
 			this_chunk = nr_to_read;
 		err = __do_page_cache_readahead(mapping, filp,
-						offset, this_chunk);
+						offset, this_chunk, 0);
 		if (err < 0) {
 			ret = err;
 			break;
@@ -373,7 +425,7 @@ int do_page_cache_readahead(struct addre
 	if (bdi_read_congested(mapping->backing_dev_info))
 		return -1;
 
-	return __do_page_cache_readahead(mapping, filp, offset, nr_to_read);
+	return __do_page_cache_readahead(mapping, filp, offset, nr_to_read, 0);
 }
 
 /*
@@ -393,7 +445,10 @@ blockable_page_cache_readahead(struct ad
 	if (!block && bdi_read_congested(mapping->backing_dev_info))
 		return 0;
 
-	actual = __do_page_cache_readahead(mapping, filp, offset, nr_to_read);
+	actual = __do_page_cache_readahead(mapping, filp, offset, nr_to_read, 0);
+
+	dprintk("blockable-readahead(ino=%lu, ra=%lu+%lu) = %d\n",
+			mapping->host->i_ino, offset, nr_to_read, actual);
 
 	return check_ra_success(ra, nr_to_read, actual);
 }
@@ -555,3 +610,860 @@ unsigned long max_sane_readahead(unsigne
 	__get_zone_counts(&active, &inactive, &free, NODE_DATA(numa_node_id()));
 	return min(nr, (inactive + free) / 2);
 }
+
+/*
+ * Adaptive read-ahead.
+ *
+ * Good read patterns are compact both in space and time. The read-ahead logic
+ * tries to grant larger read-ahead size to better readers under the constraint
+ * of system memory and load pressures.
+ *
+ * It employs two methods to estimate the max thrashing safe read-ahead size:
+ *   1. state based   - the default one
+ *   2. context based - the fail safe one
+ * The integration of the dual methods has the merit of being agile and robust.
+ * It makes the overall design clean: special cases are handled in general by
+ * the stateless method, leaving the stateful one simple and fast.
+ *
+ * To improve throughput and decrease read delay, the logic 'looks ahead'.
+ * In every read-ahead chunk, it selects one page and tag it with PG_readahead.
+ * Later when the page with PG_readahead is to be read, the logic knows that
+ * it's time to carry out the next read-ahead chunk in advance.
+ *    
+ *                 a read-ahead chunk
+ *    +-----------------------------------------+       
+ *    |       # PG_readahead                    |       
+ *    +-----------------------------------------+       
+ *            ^ When this page is read, we submit I/O for the next read-ahead.
+ *
+ *
+ * Here are some variable names used frequently:
+ *
+ *                                   |<------- la_size ------>|
+ *                  +-----------------------------------------+       
+ *                  |                #                        |       
+ *                  +-----------------------------------------+       
+ *      ra_index -->|<---------------- ra_size -------------->|
+ *
+ */
+
+/*
+ * The nature of read-ahead allows most tests to fail or even be wrong.
+ * Here we just do not bother to call get_page(), it's meaningless anyway.
+ */
+struct page *find_page(struct address_space *mapping, unsigned long offset)
+{
+	struct page *page;
+
+	read_lock_irq(&mapping->tree_lock);
+	page = radix_tree_lookup(&mapping->page_tree, offset);
+	read_unlock_irq(&mapping->tree_lock);
+	return page;
+}
+
+/*
+ * Move pages in danger (of thrashing) to the head of inactive_list.
+ * Not expected to happen frequently.
+ */
+static int rescue_pages(struct page *page, unsigned long nr_pages)
+{
+	unsigned long pgrescue = 0;
+	unsigned long index = page->index;
+	struct address_space *mapping = page_mapping(page);
+	struct zone *zone;
+
+	dprintk("rescue_pages(ino=%lu, index=%lu nr=%lu)\n",
+			mapping->host->i_ino, index, nr_pages);
+	BUG_ON(!nr_pages);
+
+	for(;;) {
+		zone = page_zone(page);
+		spin_lock_irq(&zone->lru_lock);
+
+		if (!PageLRU(page))
+			goto out_unlock;
+
+		while (page->mapping == mapping && page->index == index) {
+			struct page *the_page = page;
+			page = list_entry(page->lru.prev, struct page, lru);
+			if (!PageActive(the_page) &&
+					!PageActivate(the_page) &&
+					!PageLocked(the_page) &&
+					page_count(the_page) == 1) {
+				list_move(&the_page->lru, &zone->inactive_list);
+				zone->nr_page_aging++;
+				pgrescue++;
+			}
+			index++;
+			if (!--nr_pages)
+				goto out_unlock;
+		}
+
+		spin_unlock_irq(&zone->lru_lock);
+
+		page = find_page(mapping, index);
+		if (!page)
+			goto out;
+	}
+out_unlock:
+	spin_unlock_irq(&zone->lru_lock);
+out:
+	inc_page_state(readahead_rescue);
+	mod_page_state(pgreadahead_rescue, pgrescue);
+
+	return nr_pages ? index : 0;
+}
+
+/*
+ * State based calculation of read-ahead request.
+ *
+ * This figure shows the meaning of file_ra_state members:
+ *
+ *             chunk A                            chunk B
+ *  +---------------------------+-------------------------------------------+
+ *  |             #             |                   #                       |
+ *  +---------------------------+-------------------------------------------+
+ *                ^             ^                   ^                       ^
+ *              la_index      ra_index     lookahead_index         readahead_index        
+ */
+
+/*
+ * The global effective length of the inactive_list(s).
+ */
+static unsigned long nr_free_inactive(void)
+{
+	unsigned int i;
+	unsigned long sum = 0;
+	struct zone *zones = NODE_DATA(numa_node_id())->node_zones;
+
+	for (i = 0; i < MAX_NR_ZONES; i++)
+		sum += zones[i].nr_inactive +
+			zones[i].free_pages - zones[i].pages_low;
+
+	return sum;
+}
+
+/*
+ * The accumulated count of pages pushed into inactive_list(s).
+ */
+static unsigned long nr_page_aging(void)
+{
+	unsigned int i;
+	unsigned long sum = 0;
+	struct zone *zones = NODE_DATA(numa_node_id())->node_zones;
+
+	for (i = 0; i < MAX_NR_ZONES; i++)
+		sum += zones[i].nr_page_aging;
+
+	return sum;
+}
+
+/*
+ * Set class of read-ahead
+ */
+static inline void set_ra_class(struct file_ra_state *ra,
+				enum file_ra_class ra_class)
+{
+	ra->flags <<= RA_CLASS_SHIFT;
+	ra->flags += ra_class;
+}
+
+/*
+ * Prepare file_ra_state for a new read-ahead sequence.
+ */
+static inline void ra_state_init(struct file_ra_state *ra,
+				unsigned long la_index, unsigned long ra_index)
+{
+	ra->lookahead_index = la_index;
+	ra->readahead_index = ra_index;
+}
+
+/*
+ * Take down a new read-ahead request in file_ra_state.
+ */
+static inline void ra_state_update(struct file_ra_state *ra,
+				unsigned long ra_size, unsigned long la_size)
+{
+	ra->cache_hit = 0;
+	ra->ra_index = ra->readahead_index;
+	ra->la_index = ra->lookahead_index;
+	ra->readahead_index += ra_size;
+	ra->lookahead_index = ra->readahead_index - la_size;
+	ra->nr_page_aging = nr_page_aging();
+}
+
+/*
+ * Adjust the read-ahead request in file_ra_state.
+ */
+static inline void ra_state_adjust(struct file_ra_state *ra,
+				unsigned long ra_size, unsigned long la_size)
+{
+	ra->readahead_index = ra->ra_index + ra_size;
+	ra->lookahead_index = ra->readahead_index - la_size;
+}
+
+/*
+ * Submit IO for the read-ahead request in file_ra_state.
+ */
+static int ra_dispatch(struct file_ra_state *ra,
+			struct address_space *mapping, struct file *filp)
+{
+	unsigned long eof_index;
+	unsigned long ra_size;
+	unsigned long la_size;
+	int actual;
+	enum file_ra_class ra_class;
+	static char *ra_class_name[] = {
+		"newfile",
+		"state",
+		"context",
+		"contexta"
+	};
+
+	ra_class = (ra->flags & RA_CLASS_MASK);
+	BUG_ON(ra_class == 0 || ra_class > RA_CLASS_END);
+
+	eof_index = ((i_size_read(mapping->host) - 1) >> PAGE_CACHE_SHIFT) + 1;
+	ra_size = ra->readahead_index - ra->ra_index;
+	la_size = ra->readahead_index - ra->lookahead_index;
+
+	/* Snap to EOF. */
+	if (unlikely(ra->ra_index >= eof_index)) {
+		inc_page_state(readahead_end);
+		return 0;
+	}
+	if (ra->readahead_index + ra_size / 2 > eof_index) {
+		if (ra_class == RA_CLASS_CONTEXT_ACCELERATED &&
+				eof_index > ra->lookahead_index + 1)
+			la_size = eof_index - ra->lookahead_index;
+		else
+			la_size = 0;
+		ra_size = eof_index - ra->ra_index;
+		ra_state_adjust(ra, ra_size, la_size);
+	}
+
+	actual = __do_page_cache_readahead(mapping, filp,
+					ra->ra_index, ra_size, la_size);
+
+	if (!la_size)
+		ra_account_page(ra, readahead_eof, actual);
+	ra_account_page(ra, readahead, actual);
+
+	dprintk("readahead-%s(ino=%lu, index=%lu, ra=%lu+%lu-%lu) = %d\n",
+			ra_class_name[ra_class - 1],
+			mapping->host->i_ino, ra->la_index,
+			ra->ra_index, ra_size, la_size, actual);
+
+	return actual;
+}
+
+/*
+ * Determine the request parameters from primitive values.
+ *
+ * It applies the following rules:
+ *   - Substract ra_size by the old look-ahead to get real safe read-ahead;
+ *   - Set new la_size according to the (still large) ra_size;
+ *   - Apply upper limits;
+ *   - Make sure stream_shift is not too small.
+ *     (So that the next global_shift will not be too small.)
+ *
+ * Input:
+ * ra_size stores the estimated thrashing-threshold.
+ * la_size stores the look-ahead size of previous request.
+ */
+static inline int adjust_rala(unsigned long ra_max,
+				unsigned long *ra_size, unsigned long *la_size)
+{
+	unsigned long stream_shift = *la_size;
+
+	if (*ra_size > *la_size)
+		*ra_size -= *la_size;
+	else
+		return 0;
+
+	*la_size = 1 + *ra_size / LOOKAHEAD_RATIO;
+
+	if (*ra_size > ra_max)
+		*ra_size = ra_max;
+	if (*la_size > *ra_size)
+		*la_size = *ra_size;
+
+	stream_shift += (*ra_size - *la_size);
+	if (stream_shift < *ra_size / 4)
+		*la_size -= (*ra_size / 4 - stream_shift);
+
+	return 1;
+}
+
+/*
+ * The function estimates two values:
+ * 1. thrashing-threshold for the current stream
+ *    It is returned to make the next read-ahead request.
+ * 2. the remained space for the current chunk
+ *    It will be checked to ensure that the current chunk is safe.
+ * 
+ * The computation will be pretty accurate under heavy load, and will change
+ * vastly with light load(small global_shift), so the grow speed of ra_size
+ * must be limited, and a moderate large stream_shift must be insured.
+ *
+ * This figure illustrates the formula:
+ * While the stream reads stream_shift pages inside the chunks,
+ * the chunks are shifted global_shift pages inside inactive_list.
+ *
+ *      chunk A                    chunk B
+ *                          |<=============== global_shift ================|
+ *  +-------------+         +-------------------+                          |
+ *  |       #     |         |           #       |            inactive_list |
+ *  +-------------+         +-------------------+                     head |
+ *          |---->|         |---------->|
+ *             |                  |
+ *             +-- stream_shift --+
+ */
+static inline unsigned long compute_thrashing_threshold(
+						struct file_ra_state *ra,
+						unsigned long *remain)
+{
+	unsigned long global_size;
+	unsigned long global_shift;
+	unsigned long stream_shift;
+	unsigned long ra_size;
+
+	global_size = nr_free_inactive();
+	global_shift = nr_page_aging() - ra->nr_page_aging;
+	stream_shift = ra->lookahead_index - ra->la_index;
+
+	ra_size = stream_shift *
+			global_size * readahead_ratio / 100 / global_shift;
+
+	if (global_size > global_shift)
+		*remain = stream_shift *
+				(global_size - global_shift) / global_shift;
+	else
+		*remain = 0;
+
+	ddprintk("compute_thrashing_threshold: "
+			"ra=%lu=%lu*%lu/%lu, remain %lu for %lu\n",
+			ra_size, stream_shift, global_size, global_shift,
+			*remain, ra->readahead_index - ra->lookahead_index);
+
+	return ra_size;
+}
+
+/* 
+ * Main function for file_ra_state based read-ahead.
+ */
+static inline unsigned long
+state_based_readahead(struct address_space *mapping, struct file *filp,
+			struct file_ra_state *ra, struct page *page,
+			unsigned long ra_max)
+{
+	unsigned long ra_old;
+	unsigned long ra_size;
+	unsigned long la_size;
+	unsigned long remain_space;
+
+	la_size = ra->readahead_index - ra->lookahead_index;
+	ra_old = ra->readahead_index - ra->ra_index;
+	ra_size = compute_thrashing_threshold(ra, &remain_space);
+
+	if (remain_space <= la_size && la_size > 1) {
+		rescue_pages(page, la_size);
+		return 0;
+	}
+
+	if (!adjust_rala(min(ra_max, 2 * ra_old + (ra_max - ra_old) / 16),
+				&ra_size, &la_size))
+		return 0;
+
+	set_ra_class(ra, RA_CLASS_STATE);
+	ra_state_update(ra, ra_size, la_size);
+
+	return ra_dispatch(ra, mapping, filp);
+}
+
+
+/*
+ * Page cache context based estimation of read-ahead/look-ahead size/index.
+ *
+ * The logic first looks backward in the inactive_list to get an estimation of
+ * the thrashing-threshold, and then, if necessary, looks forward to determine
+ * the start point of next read-ahead.
+ *
+ * The estimation theory can be illustrated with figure:
+ * 
+ *   chunk A           chunk B                      chunk C                 head
+ *
+ *   l01 l11           l12   l21                    l22
+ *| |-->|-->|       |------>|-->|                |------>| 
+ *| +-------+       +-----------+                +-------------+               |
+ *| |   #   |       |       #   |                |       #     |               |
+ *| +-------+       +-----------+                +-------------+               |
+ *| |<==============|<===========================|<============================|
+ *        L0                     L1                            L2
+ *
+ * Let f(l) = L be a map from
+ * 	l: the number of pages read by the stream
+ * to
+ * 	L: the number of pages pushed into inactive_list in the mean time
+ * then
+ * 	f(l01) <= L0
+ * 	f(l11 + l12) = L1
+ * 	f(l21 + l22) = L2
+ * 	...
+ * 	f(l01 + l11 + ...) <= Sum(L0 + L1 + ...)
+ *                         <= Length(inactive_list) = f(thrashing-threshold)
+ *
+ * So the count of countinuous history pages left in the inactive_list is always
+ * a lower estimation of the true thrashing-threshold.
+ */
+
+#define SEQUENTIAL_CLASS_NONEXIST	0
+#define SEQUENTIAL_CLASS_FRESH		1
+#define SEQUENTIAL_CLASS_STALE		2
+#define SEQUENTIAL_CLASS_DISTURBED	4
+#define SEQUENTIAL_CLASS_DISTURBED_MORE	8
+/*
+ * STATUS	VALUE		TYPE
+ *  ___ 	0		not in inactive list
+ *  L__ 	1		fresh
+ *  L_R 	2		stale
+ *  LA_ 	4		disturbed once
+ *  LAR 	8		disturbed twice
+ */
+static inline int get_sequential_class(struct page *page)
+{
+	if (!page || !PageLRU(page) || PageActive(page))
+		return 0;
+
+	if (!PageActivate(page))
+		return 1 + PageReferenced(page);
+
+	return 4 + 4 * PageReferenced(page);
+}
+
+
+/*
+ * Look back and count history pages to estimate thrashing-threshold.
+ *
+ * Strategies
+ * - Sequential read that extends from index 0
+ * 	The counted value may well be far under the true threshold, so return
+ * 	it unmodified for further process in adjust_rala_accelerated().
+ * - Sequential read with a large history count
+ * 	Check 3 evenly spread pages to be sure there is no hole or many
+ * 	not-yet-accessed pages. This prevents unnecessary IO, and allows some
+ * 	almost sequential patterns to survive.
+ * - Return equal or smaller count; but ensure a reasonable minimal value.
+ *
+ * Optimization
+ * - The count will normally be min(nr_lookback, offset), unless either memory
+ *   or read speed is low, or it is still in grow up phase.
+ * - A rigid implementation would be a simple loop to scan page by page
+ *   backward, though this may be unnecessary and inefficient, so the
+ *   stepping backward/forward scheme is used.
+ */
+static int count_sequential_pages(struct address_space *mapping,
+			int sequential_class, unsigned long *remain,
+			unsigned long offset,
+			unsigned long ra_min, unsigned long ra_max)
+{
+	int step;
+	int count;
+	unsigned long index;
+	unsigned long nr_lookback;
+	struct page *page;
+
+	*remain = 0;
+	nr_lookback = ra_max * (LOOKAHEAD_RATIO + 1) *
+						100 / (readahead_ratio + 1);
+	if (nr_lookback > offset)
+		nr_lookback = offset;
+
+	read_lock_irq(&mapping->tree_lock);
+
+	index = offset - nr_lookback;
+	page = radix_tree_lookup(&mapping->page_tree, index);
+	if (get_sequential_class(page) >= sequential_class) {
+		step = 1 + nr_lookback / 3;
+		if(nr_lookback > ra_max / 8) {
+			count = 1;
+			goto check_more;
+		} else {
+			*remain = nr_lookback;
+			goto out_unlock;
+		}
+	}
+
+	count = 0; /* just to make gcc happy */
+	for(step = ra_min; step < nr_lookback; step *= 4) {
+		index = offset - step;
+		page = radix_tree_lookup(&mapping->page_tree, index);
+		if (!page)
+			goto check_more;
+	}
+	index = offset - nr_lookback;
+	page = NULL;
+
+check_more:
+	for(;;) {
+		if (page && !*remain)
+			*remain = offset - index;
+		if (get_sequential_class(page) < sequential_class) {
+			count = 0;
+			step = (offset - index + 3) / 4;
+		} else if (++count >= 3 || step < ra_max / 16)
+			break;
+		index += step;
+		if (index >= offset)
+			break;
+		page = radix_tree_lookup(&mapping->page_tree, index);
+	}
+out_unlock:
+	read_unlock_irq(&mapping->tree_lock);
+
+	if (3 * step > nr_lookback)
+		return nr_lookback;
+	
+	if (!*remain)
+		*remain = 3 * step;
+
+	count = (3 * step) * readahead_ratio / 100;
+	if (count < get_min_readahead(NULL))
+		count = get_min_readahead(NULL);
+
+	return count;
+}
+
+/*
+ * Scan forward in inactive_list for the first non-present page.
+ * It takes advantage of the adjacency of pages in inactive_list.
+ */
+static unsigned long lru_scan_forward(struct page *page, int nr_pages)
+{
+	unsigned long index = page->index;
+	struct address_space *mapping = page->mapping;
+	struct zone *zone;
+
+	for(;;) {
+		zone = page_zone(page);
+		spin_lock_irq(&zone->lru_lock);
+
+		if (!PageLRU(page))
+			goto out;
+
+		do {    
+			index++;
+			if (!--nr_pages)
+				goto out;
+			page = list_entry(page->lru.prev, struct page, lru);
+		} while (page->mapping == mapping && page->index == index);
+
+		spin_unlock_irq(&zone->lru_lock);
+
+		page = find_page(mapping, index);
+		if (!page)
+			return index;
+	}
+out:    
+	spin_unlock_irq(&zone->lru_lock);
+	return nr_pages ? index : 0;
+}
+
+/* Directly calling lru_scan_forward() would be slow.
+ * This function tries to avoid unnecessary scans for the most common cases:
+ * - Slow reads should scan forward directly;
+ * - Fast reads should step backward first;
+ * - Aggressive reads may well have max allowed look-ahead.
+ */
+static unsigned long first_absent_page(struct address_space *mapping,
+				struct page *page, unsigned long index,
+				unsigned long ra_size, unsigned long ra_max)
+{
+	if (ra_size < ra_max)
+		goto scan_forward;
+
+	read_lock_irq(&mapping->tree_lock);
+
+	if (ra_size < LOOKAHEAD_RATIO * ra_max)
+		goto scan_backward;
+
+	page = radix_tree_lookup(&mapping->page_tree, index + ra_max);
+	if (page) {
+		read_unlock_irq(&mapping->tree_lock);
+		return 0;
+	}
+	page = radix_tree_lookup(&mapping->page_tree, index + ra_max - 1);
+	if (page) {
+		read_unlock_irq(&mapping->tree_lock);
+		return index + ra_max;
+	}
+
+scan_backward:
+	if (ra_size == index)
+		ra_size /= 4;
+	else
+		ra_size /= (LOOKAHEAD_RATIO * 2);
+	for(;; ra_size /= 2) {
+		page = radix_tree_lookup(&mapping->page_tree, index + ra_size);
+		if (page)
+			break;
+		if (!ra_size)
+			return index + 1;
+	}
+	read_unlock_irq(&mapping->tree_lock);
+	ra_size = ra_max;
+
+scan_forward:
+	return lru_scan_forward(page, ra_size + 1);
+}
+
+/*
+ * Determine the request parameters for context based read-ahead that extends
+ * from start of file.
+ *
+ * The major weakness of stateless method is perhaps the slow grow up speed of
+ * ra_size. The logic tries to make up for this in the important case of
+ * sequential reads that extend from start of file. In this case, the ra_size
+ * is not choosed to make the whole next chunk safe(as in normal ones). Only
+ * half of which is safe. The added 'unsafe' half is the look-ahead part. It
+ * is expected to be safeguarded by rescue_pages() in adjust_rala() when the
+ * previous chunks are lost.
+ */
+static inline int adjust_rala_accelerated(unsigned long ra_max,
+				unsigned long *ra_size, unsigned long *la_size)
+{
+	if (*ra_size <= *la_size)
+		return 0;
+
+	*la_size = (*ra_size - *la_size) * readahead_ratio / 100;
+	*ra_size = *la_size * 2;
+
+	if (*ra_size > ra_max)
+		*ra_size = ra_max;
+	if (*la_size > *ra_size)
+		*la_size = *ra_size;
+
+	return 1;
+}
+
+/* 
+ * Main function for page context based read-ahead.
+ */
+static inline unsigned long
+context_based_readahead(struct address_space *mapping,
+			struct file *filp, struct file_ra_state *ra,
+			int sequential_class, struct page *page,
+			unsigned long index,
+			unsigned long ra_min, unsigned long ra_max)
+{
+	unsigned long ra_index;
+	unsigned long ra_size;
+	unsigned long la_size;
+	unsigned long remain_pages;
+	unsigned long ret;
+	
+	ra_size = count_sequential_pages(mapping, sequential_class,
+			&remain_pages, index, ra_min, ra_max);
+	BUG_ON(!ra_size || !remain_pages);
+
+	/* Where to start read-ahead? */
+	if (!page)
+		ra_index = index;
+	else {
+		ra_index = first_absent_page(
+				mapping, page, index, ra_size, ra_max);
+		if (unlikely(!ra_index))
+			return 0;
+	}
+
+	la_size = ra_index - index;
+	if (remain_pages <= la_size && la_size > 1) {
+		rescue_pages(page, la_size);
+		return 0;
+	}
+
+	if (ra_size == index) {
+		ret = adjust_rala_accelerated(ra_max, &ra_size, &la_size);
+		set_ra_class(ra, RA_CLASS_CONTEXT_ACCELERATED);
+	} else {
+		ret = adjust_rala(ra_max, &ra_size, &la_size);
+		set_ra_class(ra, RA_CLASS_CONTEXT);
+	}
+	if (unlikely(!ret))
+		return 0;
+
+	ra_state_init(ra, index, ra_index);
+	ra_state_update(ra, ra_size, la_size);
+
+	return ra_dispatch(ra, mapping, filp);
+}
+
+/*
+ * Read-ahead on start of file.
+ *
+ * It is most important for small files.
+ * 1. Set a moderate large read-ahead size;
+ * 2. Issue the next read-ahead request as soon as possible.
+ *
+ * But be careful, there are some applications that dip into only the very head
+ * of a file. The most important thing is to prevent them from triggering the
+ * next (much larger) read-ahead request, which leads to lots of cache misses.
+ * Two pages should be enough for them, correct me if I'm wrong.
+ */
+static inline unsigned long
+newfile_readahead(struct address_space *mapping,
+		struct file *filp, struct file_ra_state *ra,
+		unsigned long req_size, unsigned long ra_min)
+{
+	unsigned long ra_size;
+	unsigned long la_size;
+
+	if (req_size > ra_min)
+		req_size = ra_min;
+
+	ra_size = 4 * req_size;
+	la_size = 2 * req_size;
+
+	set_ra_class(ra, RA_CLASS_NEWFILE);
+	ra_state_init(ra, 0, 0);
+	ra_state_update(ra, ra_size, la_size);
+
+	return ra_dispatch(ra, mapping, filp);
+}
+
+/*
+ * ra_size is mainly determined by:
+ * 1. sequential-start: min(KB(16 + mem_mb/16), KB(64))
+ * 2. sequential-max:	min(KB(64 + mem_mb*64), KB(2048))
+ * 3. sequential:	(thrashing-threshold) * readahead_ratio / 100
+ *
+ * Table of concrete numbers for 4KB page size:
+ *  (inactive + free) (in MB):    4   8   16   32   64  128  256  512 1024
+ *    initial ra_size (in KB):   16  16   16   16   20   24   32   48   64
+ *	  max ra_size (in KB):  320 576 1088 2048 2048 2048 2048 2048 2048
+ */
+
+static inline void get_readahead_bounds(struct file_ra_state *ra,
+					unsigned long *ra_min,
+					unsigned long *ra_max)
+{
+	unsigned long mem_mb;
+
+#define KB(size)	(((size) * 1024) / PAGE_CACHE_SIZE)
+	mem_mb = nr_free_inactive() * PAGE_CACHE_SIZE / 1024 / 1024;
+	*ra_max = min(min(KB(64 + mem_mb*64), KB(2048)), ra->ra_pages); 
+	*ra_min = min(min(KB(VM_MIN_READAHEAD + mem_mb/16), KB(128)), *ra_max/2);
+#undef KB
+}
+
+/* 
+ * This is the entry point of the adaptive read-ahead logic.
+ *
+ * It is only called on two conditions:
+ * 1. page == NULL
+ *    A cache miss happened, it can be either a random read or a sequential one.
+ * 2. page != NULL 
+ *    There is a look-ahead mark(PG_readahead) from a previous sequential read.
+ *    It's time to do some checking and submit the next read-ahead IO.
+ *
+ * That makes both methods happy, and lives in harmony with application managed
+ * read-aheads via fadvise() / madvise(). The cache hit problem is also
+ * eliminated naturally.
+ */
+unsigned long
+page_cache_readahead_adaptive(struct address_space *mapping,
+			struct file_ra_state *ra, struct file *filp,
+			struct page *prev_page, struct page *page,
+			unsigned long first_index,
+			unsigned long index, unsigned long last_index)
+{
+	unsigned long size;
+	unsigned long ra_min;
+	unsigned long ra_max;
+	int sequential_class;
+
+	if (page) {
+		if(!TestClearPageReadahead(page))
+			return 0;
+		if (bdi_read_congested(mapping->backing_dev_info))
+			return 0;
+	}
+
+	if (page)
+		ra_account(readahead_return, ra->flags & RA_CLASS_MASK, 1);
+	else if (index)
+		inc_page_state(cache_miss);
+
+	get_readahead_bounds(ra, &ra_min, &ra_max);
+
+	/* readahead disabled? */
+	if (unlikely(!ra_min || !readahead_ratio)) {
+		size = max_sane_readahead(last_index - index);
+		goto readit;
+	}
+
+	/*
+	 * Start of file.
+	 */
+	if (index == 0)
+		return newfile_readahead(mapping, filp, ra, last_index, ra_min);
+
+	/*
+	 * State based sequential read-ahead.
+	 */
+	if ((readahead_ratio % 5) == 0 &&
+		page && index == ra->lookahead_index &&
+		(ra->cache_hit * 2 > (ra->lookahead_index - ra->la_index) ||
+		 last_index - first_index >= ra_max))
+		return state_based_readahead(mapping, filp, ra, page, ra_max);
+
+	/* 
+	 * Context based sequential read-ahead.
+	 */ 
+	if (!prev_page)
+		prev_page = find_page(mapping, index - 1);
+	sequential_class = get_sequential_class(prev_page);
+	if (sequential_class >= SEQUENTIAL_CLASS_STALE)
+		return context_based_readahead(mapping, filp, ra,
+				sequential_class, page, index,
+				ra_min, ra_max);
+
+	if (page)
+		return 0;
+
+	/*
+	 * Random read.
+	 */
+	size = min(last_index - index, ra_max);
+
+readit:
+	size = __do_page_cache_readahead(mapping, filp, index, size, 0);
+
+	inc_page_state(readrandom);
+	mod_page_state(pgreadrandom, size);
+
+	dprintk("readrandom(ino=%lu, pages=%lu, index=%lu-%lu-%lu) = %lu\n",
+			mapping->host->i_ino, mapping->nrpages,
+			first_index, index, last_index, size);
+
+	return size;
+}
+
+/*
+ * Call me!
+ */
+void fastcall ra_access(struct file_ra_state *ra, struct page *page)
+{
+	if (PageActive(page) || PageActivate(page) || PageReferenced(page))
+		return;
+
+	if (page->index < ra->la_index || page->index >= ra->readahead_index)
+		return;
+
+	ra->cache_hit++;
+	if (page->index >= ra->ra_index)
+		ra_account(pgreadahead_hit, ra->flags & RA_CLASS_MASK, 1);
+	else
+		ra_account(pgreadahead_hit,
+				(ra->flags >> RA_CLASS_SHIFT) & RA_CLASS_MASK, 1);
+}
diff -rup linux-2.6.13.1-orig/mm/swap.c linux-2.6.13.1/mm/swap.c
--- linux-2.6.13.1-orig/mm/swap.c	2005-09-09 22:42:58.000000000 -0400
+++ linux-2.6.13.1/mm/swap.c	2005-10-05 16:11:11.000000000 -0400
@@ -96,6 +96,8 @@ int rotate_reclaimable_page(struct page 
 	return 0;
 }
 
+extern int readahead_ratio;
+
 /*
  * FIXME: speed this up?
  */
@@ -122,8 +124,13 @@ void fastcall activate_page(struct page 
  */
 void fastcall mark_page_accessed(struct page *page)
 {
-	if (!PageActive(page) && PageReferenced(page) && PageLRU(page)) {
-		activate_page(page);
+	if (!PageActive(page) && !PageActivate(page) &&
+			PageReferenced(page) && PageLRU(page)) {
+		if (readahead_ratio > 9 || (readahead_ratio & 1)) {
+			page_zone(page)->nr_page_aging++;
+			SetPageActivate(page);
+		} else
+			activate_page(page);
 		ClearPageReferenced(page);
 	} else if (!PageReferenced(page)) {
 		SetPageReferenced(page);
@@ -299,6 +306,7 @@ void __pagevec_lru_add(struct pagevec *p
 			if (zone)
 				spin_unlock_irq(&zone->lru_lock);
 			zone = pagezone;
+			update_page_age(zone);
 			spin_lock_irq(&zone->lru_lock);
 		}
 		if (TestSetPageLRU(page))
diff -rup linux-2.6.13.1-orig/mm/vmscan.c linux-2.6.13.1/mm/vmscan.c
--- linux-2.6.13.1-orig/mm/vmscan.c	2005-09-09 22:42:58.000000000 -0400
+++ linux-2.6.13.1/mm/vmscan.c	2005-10-05 16:17:22.000000000 -0400
@@ -370,6 +370,8 @@ static pageout_t pageout(struct page *pa
 	return PAGE_CLEAN;
 }
 
+extern int readahead_ratio;
+
 /*
  * shrink_list adds the number of reclaimed pages to sc->nr_reclaimed
  */
@@ -407,6 +409,11 @@ static int shrink_list(struct list_head 
 		if (PageWriteback(page))
 			goto keep_locked;
 
+		if (PageActivate(page)) {
+			ClearPageActivate(page);
+			goto activate_locked;
+		}
+
 		referenced = page_referenced(page, 1, sc->priority <= 0);
 		/* In active use or really unfreeable?  Activate it. */
 		if (referenced && page_mapping_inuse(page))
@@ -771,6 +778,7 @@ refill_inactive_zone(struct zone *zone, 
 		pgmoved++;
 		if (!pagevec_add(&pvec, page)) {
 			zone->nr_inactive += pgmoved;
+			zone->nr_page_aging += pgmoved;
 			spin_unlock_irq(&zone->lru_lock);
 			pgdeactivate += pgmoved;
 			pgmoved = 0;
@@ -780,6 +788,7 @@ refill_inactive_zone(struct zone *zone, 
 			spin_lock_irq(&zone->lru_lock);
 		}
 	}
+	zone->nr_page_aging += pgmoved;
 	zone->nr_inactive += pgmoved;
 	pgdeactivate += pgmoved;
 	if (buffer_heads_over_limit) {
@@ -860,6 +869,7 @@ shrink_zone(struct zone *zone, struct sc
 		}
 	}
 
+	update_page_age(zone);
 	throttle_vm_writeout();
 }
 
@@ -1045,6 +1055,7 @@ loop_again:
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
 		int end_zone = 0;	/* Inclusive.  0 = ZONE_DMA */
+		int begin_zone = -1;
 		unsigned long lru_pages = 0;
 
 		all_zones_ok = 1;
@@ -1057,6 +1068,8 @@ loop_again:
 			for (i = pgdat->nr_zones - 1; i >= 0; i--) {
 				struct zone *zone = pgdat->node_zones + i;
 
+				update_page_age(zone);
+
 				if (zone->present_pages == 0)
 					continue;
 
@@ -1066,16 +1079,33 @@ loop_again:
 
 				if (!zone_watermark_ok(zone, order,
 						zone->pages_high, 0, 0, 0)) {
-					end_zone = i;
-					goto scan;
+					if (!end_zone)
+						begin_zone = end_zone = i;
+					else /* if (begin_zone == i + 1) */
+						begin_zone = i;
 				}
 			}
-			goto out;
+			if (begin_zone < 0)
+				goto out;
 		} else {
+			begin_zone = 0;
 			end_zone = pgdat->nr_zones - 1;
 		}
-scan:
-		for (i = 0; i <= end_zone; i++) {
+
+		/*
+		 * Prepare enough free pages for zones with small page_age,
+		 * they are going to be reclaimed in the page allocation.
+		 */
+		while (end_zone < pgdat->nr_zones - 1 &&
+			pages_more_aged(pgdat->node_zones + end_zone,
+					pgdat->node_zones + end_zone + 1))
+			end_zone++;
+		while (begin_zone &&
+			pages_more_aged(pgdat->node_zones + begin_zone,
+					pgdat->node_zones + begin_zone - 1))
+			begin_zone--;
+
+		for (i = begin_zone; i <= end_zone; i++) {
 			struct zone *zone = pgdat->node_zones + i;
 
 			lru_pages += zone->nr_active + zone->nr_inactive;
@@ -1090,7 +1120,7 @@ scan:
 		 * pages behind kswapd's direction of progress, which would
 		 * cause too much scanning of the lower zones.
 		 */
-		for (i = 0; i <= end_zone; i++) {
+		for (i = begin_zone; i <= end_zone; i++) {
 			struct zone *zone = pgdat->node_zones + i;
 			int nr_slab;
 
-- 
WU Fengguang
Dept. of Automation
University of Science and Technology of China
Hefei, Anhui
