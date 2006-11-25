Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757852AbWKYGtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757852AbWKYGtO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 01:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757853AbWKYGtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 01:49:14 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:52960 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1757852AbWKYGtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 01:49:12 -0500
Message-ID: <364437345.17522@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Sat, 25 Nov 2006 14:49:05 +0800
From: Fengguang Wu <fengguang.wu@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Steven Pratt <slpratt@austin.ibm.com>,
       Ram Pai <linuxram@us.ibm.com>, Neil Brown <neilb@suse.de>,
       Voluspa <lista1@comhem.se>, Linux Portal <linportal@gmail.com>
Subject: Adaptive readahead V16 benchmarks
Message-ID: <20061125064905.GA5887@mail.ustc.edu.cn>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Steven Pratt <slpratt@austin.ibm.com>,
	Ram Pai <linuxram@us.ibm.com>, Neil Brown <neilb@suse.de>,
	Voluspa <lista1@comhem.se>, Linux Portal <linportal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Here are some benchmarks for the latest adaptive readahead patchset.

Most benchmarks have 3+ runs and have the numbers averaged.
However some testing times are short and not quite stable.

Most of them are carried out on my PC:
        Seagate ST3250820A 250G/8M IDE disk, 512M Memory, AMD Sempron 2200+

Basic conclusions:
- equivalent performance in normal cases
- much better in: busy NFS server; sparse/backward reading
- adapts to memory size very well on randomly loading a file


128K stock vs 1M adaptive
=========================

        grep /lib               9.06    8.78     -3.1%
        dd   debian.iso         2.45    2.54     +3.7%
        diff /lib /lib.1        7.47    6.50    -13.0%
        diff debian.iso        13.41    5.67    -57.7%

- trivial  reads: come close (3% is kind of normal variation)
- parallel reads: a lot faster


The following tests are side-by-side comparison of the stock/adaptive
readahead, with the same 1M max readahead size.


daily usage
===========
        grep /lib               8.22      7.98     -2.9%
        diff /lib /lib.1        6.69      6.41     -4.2%
        dd   sparse            13.36     13.26     -0.7%
        dd   dsl.iso            1.06      0.97     -8.5%
        diff dsl.iso dsl.iso.1  0.99      1.00     +1.0%

- small files: improved a little
               (due to more aggressive ramping up of readahead size)
- sparse file: improved a little, which means less overhead
               (for 4k sized reads, the stock/adaptive logic will be
               invoked for every 1/256 page(s))
- big files:   come close; a little worse for parallel reads(?)


lighttpd serving ~1200 clients
==============================

Tested in an AMD Opteron 250 server with 16G mem(2 nodes, interleaved policy).
A lighttpd process is serving big files to about 1200 clients.

        clients               1232     1240

        avg ra size(pages)      15      228
        avg io size(sectors)   155.18   216.22

        cpu %iowait             25.20    21.00
        disk %util              13.03     9.62
        net bw(MBps)            37.00    43.40
        disk bw(MBps)           28.18    36.46

Obviously the adaptive readahead outperforms the stock one.

But wait... The stock readahead's average readahead size, 15, is way
too low and abnormal. It is found to be a bug which can be triggered
by the following syscall trace:

        sendfile(188, 1921, [1478592], 19553028) = 37440
        sendfile(188, 1921, [1516032], 19515588) = 28800
        sendfile(188, 1921, [1544832], 19486788) = 37440
        sendfile(188, 1921, [1582272], 19449348) = 14400
        sendfile(188, 1921, [1596672], 19434948) = 37440
        sendfile(188, 1921, [1634112], 19397508) = 37440

Note that
        - it's sequential reading
        - every sendfile() returns with only _partial_ work done

page_cache_readahead() expects that if it returns @next_index, it is
called exactly at @next_index next time. That's not true here. Now it
ends up with premature-readaheads, which lead to false `cache hits'.

This patch attempts to address the problem, but not tested yet:

--- linux-2.6.19-rc6-mm1.orig/mm/readahead.c
+++ linux-2.6.19-rc6-mm1/mm/readahead.c
@@ -581,6 +581,10 @@ page_cache_readahead(struct address_spac
 	unsigned long max, newsize;
 	int sequential;
 
+	/* Previous read request partially done */
+	if (offset > ra->start && offset < ra->prev_page)
+		goto out;
+
 	/*
 	 * We avoid doing extra work and bogusly perturbing the readahead
 	 * window expansion logic.


general file server with high concurrency
=========================================

With fine tuned readahead_ratio, the adaptive readahead can save about 1G
memory per 1000 clients, without hurting the overall disk utilization.

That means more cache available for a memory bounty server, or much better
disk/memory utilization for a memory tight server, due to larger overall I/O
size and thrashing safety.

Only theory here ;-)
The excellent memory management capability has already been demonstrated here:

        SLOW READS: 800 streams on 64M without thrashing!
        http://marc.theaimsgroup.com/?l=linux-kernel&m=112856866504476&w=2


NFS server
==========

grep /lib
                  8k    9.10    9.38     +3.1%
                 32k    9.06    8.94     -1.3%
                128k    9.05    8.91     -1.5%
diff /lib /lib.1
                  8k    8.02    8.27     +3.1%
                 32k    7.74    7.54     -2.6%
                128k    7.56    7.44     -1.6%
dd dsl.iso
                  8k    1.48    1.20    -18.9%
                 32k    1.10    1.09     -0.9%
                128k    1.09    1.14     +4.6%
diff dsl.iso dsl.iso.1
                  8k    3.00    2.35    -21.7%
                 32k    3.08    2.01    -34.7%
                128k    2.79    1.94    -30.5%

To be sure I ran another round of tests some time later:

grep /lib
                  8k    2.49    2.53     +1.6%
                 32k    2.22    2.02     -9.0%
                128k    2.04    2.01     -1.5%
diff /lib /lib.1
                  8k    7.61    7.95     +4.5%
                 32k    7.86    7.17     -8.8%
                128k    7.14    7.05     -1.3%
dd debian.iso
                  8k    3.37    2.70    -19.9%
                 32k    2.43    3.23    +32.9%
                128k    2.41    2.20     -8.7%
diff debian.iso debian.iso.1
                  8k    7.96    6.39    -19.7%
                 32k    7.81    5.58    -28.6%
                128k    7.77    5.22    -32.8%

- small files: come close
- big files:   faster, or much faster
-   8k rsize:  much better in big file; worse in dir-tree
-  32k rsize:  much better; much worse in single file read(FIXME)
- 128k rsize:  (much) better

The nfsd requests are not well handled by the stock readahead.
The newly introduced context based readahead can do it properly,
especially on the most important case:
        client: rsize=32-128k
        server: busy ones with many parallel reads.


random reads
============

Linux Portal posted a nice randomly-prime-memory-from-dbfile benchmark:
http://linux.inet.hr/adaptive_readahead_benchmark.html

It shows that adaptive readahead is 3 times faster. However, there are
concerns about readahead thrashing when (dbfile > memory).

Inspired by Linux Portal's and Steven Pratt's testing scenarios,
this test tries to answer the question:

        How the logic behaves under different (file:memory) ratios?

The following numbers are collected with a 100M file and 300/80/40M
free memory. Each run consists of 8 stages, in each stage 20M data are
randomly read. Two set of read sizes are visited: 64k unaligned/4k aligned.

             THIS STAGE TIME            |           ACCUMULATED TIME
STAGE STOCK   HR=0   HR=1   HR=2   HR=8 |  STOCK   HR=0    HR=1    HR=2    HR=8
----------------------------------------+---------------------------------------
300M.64k (300M free memory, 64k size unaligned read)
 1    7.67    7.62   7.52   7.44   7.36 |   7.67    7.62    7.52    7.44    7.36
 2    6.75    6.67   6.59   5.38   5.27 |  14.42   14.29   14.11   12.82   12.63
 3    5.79    5.62   5.37   3.6    3.31 |  20.21   19.91   19.48   16.42   15.94
 4    5.21    4.85   4.44   2.24   1.78 |  25.42   24.76   23.92   18.66   17.72
 5    4.43    4.04   3.78   1.39   0.96 |  29.85   28.8    27.7    20.05   18.68
 6    3.68    3.26   2.97   0.8    0.34 |  33.53   32.06   30.67   20.85   19.02
 7    3.15    2.84   2.41   0.55   0.28 |  36.68   34.9    33.08   21.4    19.3
 8    2.7     2.3    2.04   0.45   0.17 |  39.38   37.2    35.12   21.85   19.47
80M.64k
 1    7.62    7.9    7.61   7.61   7.63 |   7.62    7.9     7.61    7.61    7.63
 2    6.76    6.9    6.7    6.43   6.39 |  14.38   14.8    14.31   14.04   14.02
 3    6.02    5.89   5.7    5.49   5.45 |  20.4    20.69   20.01   19.53   19.47
 4    5.68    5.66   5.41   5.29   5.2  |  26.08   26.35   25.42   24.82   24.67
 5    5.7     5.57   5.65   5.45   5.52 |  31.78   31.92   31.07   30.27   30.19
 6    5.82    5.76   5.76   5.7    5.7  |  37.6    37.68   36.83   35.97   35.89
 7    5.93    5.91   5.93   5.73   5.83 |  43.53   43.59   42.76   41.7    41.72
 8    5.9     5.73   5.6    5.46   5.47 |  49.43   49.32   48.36   47.16   47.19
40M.64k
 1    7.83    7.7    7.84   7.86   8.01 |   7.83    7.7     7.84    7.86    8.01
 2    7.74    7.74   7.97   7.88   7.75 |  15.57   15.44   15.81   15.74   15.76
 3    7.85    7.66   8      7.81   7.99 |  23.42   23.1    23.81   23.55   23.75
 4    7.42    7.73   7.5    7.5    7.68 |  30.84   30.83   31.31   31.05   31.43
 5    7.92    7.88   7.72   7.85   7.64 |  38.76   38.71   39.03   38.9    39.07
 6    7.79    7.65   7.84   7.67   7.56 |  46.55   46.36   46.87   46.57   46.63
 7    7.76    7.78   7.87   7.7    7.81 |  54.31   54.14   54.74   54.27   54.44
 8    7.55    8.69   7.53   7.5    7.5  |  61.86   62.83   62.27   61.77   61.94
300M.4k (300M free memory, 4k size aligned read)
 1    26.74  26.96  26.66  22.41  22.05 |  26.74   26.96   26.66   22.41   22.05
 2    21.97  21.98  21.47   9.26   7.01 |  48.71   48.94   48.13   31.67   29.06
 3    17.96  17.92  16.84   4.13   2.32 |  66.67   66.86   64.97   35.8    31.38
 4    14.48  14.53  13.28   1.95   0.67 |  81.15   81.39   78.25   37.75   32.05
 5    11.73  11.76  10.85   1.33   0.31 |  92.88   93.15   89.1    39.08   32.36
 6    10.28  10.17   8.79   0.86   0.32 | 103.16  103.32   97.89   39.94   32.68
 7     8.2    8.21   7.02   0.73   0.3  | 111.36  111.53  104.91   40.67   32.98
 8     6.75   6.75   5.78   0.52   0.29 | 118.11  118.28  110.69   41.19   33.27
40M.4k
 1    26.79  26.76  26.7   26.17  26.09 |  26.79   26.76   26.7    26.17   26.09
 2    24.52  24.42  24.6   24.36  24.06 |  51.31   51.18   51.3    50.53   50.15
 3    23.82  23.92  23.99  24.37  24.34 |  75.13   75.1    75.29   74.9    74.49
 4    23.92  24     24.11  24.27  24.06 |  99.05   99.1    99.4    99.17   98.55
 5    23.89  23.81  23.57  23.69  23.6  | 122.94  122.91  122.97  122.86  122.15
 6    23.6   23.51  23.45  24.19  24.19 | 146.54  146.42  146.42  147.05  146.34
 7    23.47  23.6   23.45  24.11  23.75 | 170.01  170.02  169.87  171.16  170.09
 8    23.33  23.53  23.55  23.64  23.74 | 193.34  193.55  193.42  194.8   193.83

Turning that into relative numbers(adaptive : stock):

                  THIS STAGE TIME          |         ACCUMULATED TIME
STAGE        HR=0    HR=1    HR=2    HR=8  |   HR=0    HR=1    HR=2    HR=8
-------------------------------------------+-------------------------------
300M.64k
 1          -0.7%   -2.0%   -3.0%   -4.0%  |  -0.7%   -2.0%   -3.0%   -4.0%
 2          -1.2%   -2.4%  -20.3%  -21.9%  |  -0.9%   -2.1%  -11.1%  -12.4%
 3          -2.9%   -7.3%  -37.8%  -42.8%  |  -1.5%   -3.6%  -18.8%  -21.1%
 4          -6.9%  -14.8%  -57.0%  -65.8%  |  -2.6%   -5.9%  -26.6%  -30.3%
 5          -8.8%  -14.7%  -68.6%  -78.3%  |  -3.5%   -7.2%  -32.8%  -37.4%
 6         -11.4%  -19.3%  -78.3%  -90.8%  |  -4.4%   -8.5%  -37.8%  -43.3%
 7          -9.8%  -23.5%  -82.5%  -91.1%  |  -4.9%   -9.8%  -41.7%  -47.4%
 8         -14.8%  -24.4%  -83.3%  -93.7%  |  -5.5%  -10.8%  -44.5%  -50.6%
80M.64k
 1          +3.7%   -0.1%   -0.1%   +0.1%  |  +3.7%   -0.1%   -0.1%   +0.1%
 2          +2.1%   -0.9%   -4.9%   -5.5%  |  +2.9%   -0.5%   -2.4%   -2.5%
 3          -2.2%   -5.3%   -8.8%   -9.5%  |  +1.4%   -1.9%   -4.3%   -4.6%
 4          -0.4%   -4.8%   -6.9%   -8.5%  |  +1.0%   -2.5%   -4.8%   -5.4%
 5          -2.3%   -0.9%   -4.4%   -3.2%  |  +0.4%   -2.2%   -4.8%   -5.0%
 6          -1.0%   -1.0%   -2.1%   -2.1%  |  +0.2%   -2.0%   -4.3%   -4.5%
 7          -0.3%    0.0%   -3.4%   -1.7%  |  +0.1%   -1.8%   -4.2%   -4.2%
 8          -2.9%   -5.1%   -7.5%   -7.3%  |  -0.2%   -2.2%   -4.6%   -4.5%
40M.64k
 1          -1.7%   +0.1%   +0.4%   +2.3%  |  -1.7%   +0.1%   +0.4%   +2.3%
 2           0.0%   +3.0%   +1.8%   +0.1%  |  -0.8%   +1.5%   +1.1%   +1.2%
 3          -2.4%   +1.9%   -0.5%   +1.8%  |  -1.4%   +1.7%   +0.6%   +1.4%
 4          +4.2%   +1.1%   +1.1%   +3.5%  |  -0.0%   +1.5%   +0.7%   +1.9%
 5          -0.5%   -2.5%   -0.9%   -3.5%  |  -0.1%   +0.7%   +0.4%   +0.8%
 6          -1.8%   +0.6%   -1.5%   -3.0%  |  -0.4%   +0.7%    0.0%   +0.2%
 7          +0.3%   +1.4%   -0.8%   +0.6%  |  -0.3%   +0.8%   -0.1%   +0.2%
 8         +15.1%   -0.3%   -0.7%   -0.7%  |  +1.6%   +0.7%   -0.1%   +0.1%
300M.4k
 1          +0.8%   -0.3%  -16.2%  -17.5%  |  +0.8%   -0.3%  -16.2%  -17.5%
 2           0.0%   -2.3%  -57.9%  -68.1%  |  +0.5%   -1.2%  -35.0%  -40.3%
 3          -0.2%   -6.2%  -77.0%  -87.1%  |  +0.3%   -2.5%  -46.3%  -52.9%
 4          +0.3%   -8.3%  -86.5%  -95.4%  |  +0.3%   -3.6%  -53.5%  -60.5%
 5          +0.3%   -7.5%  -88.7%  -97.4%  |  +0.3%   -4.1%  -57.9%  -65.2%
 6          -1.1%  -14.5%  -91.6%  -96.9%  |  +0.2%   -5.1%  -61.3%  -68.3%
 7          +0.1%  -14.4%  -91.1%  -96.3%  |  +0.2%   -5.8%  -63.5%  -70.4%
 8           0.0%  -14.4%  -92.3%  -95.7%  |  +0.1%   -6.3%  -65.1%  -71.8%
40M.4k
 1          -0.1%   -0.3%   -2.3%   -2.6%  |  -0.1%   -0.3%   -2.3%   -2.6%
 2          -0.4%   +0.3%   -0.7%   -1.9%  |  -0.3%   -0.0%   -1.5%   -2.3%
 3          +0.4%   +0.7%   +2.3%   +2.2%  |  -0.0%   +0.2%   -0.3%   -0.9%
 4          +0.3%   +0.8%   +1.5%   +0.6%  |  +0.1%   +0.4%   +0.1%   -0.5%
 5          -0.3%   -1.3%   -0.8%   -1.2%  |  -0.0%    0.0%   -0.1%   -0.6%
 6          -0.4%   -0.6%   +2.5%   +2.5%  |  -0.1%   -0.1%   +0.3%   -0.1%
 7          +0.6%   -0.1%   +2.7%   +1.2%  |   0.0%   -0.1%   +0.7%    0.0%
 8          +0.9%   +0.9%   +1.3%   +1.8%  |  +0.1%    0.0%   +0.8%   +0.3%

Or just full test times in relative numbers:

                    HR=0    HR=1    HR=2    HR=8
        300M.64k   -5.5%  -10.8%  -44.5%  -50.6%
        300M.4k    +0.1%   -6.3%  -65.1%  -71.8%
         80M.64k   -0.2%   -2.2%   -4.6%   -4.5%
         40M.64k   +1.6%   +0.7%   -0.1%   +0.1%
         40M.4k    +0.1%    0.0%   +0.8%   +0.3%

I did not mean to do serious readahead for random reads. The original
intent is to catch possible sequential patterns mixed in random ones.
However it seems that its `side effect' on pure random reads is mostly
good:

        The stable performance ranges from 1.6% slower, to 3x faster.


sparse reading
==============

This is an amazing user report. The adaptive readahead helped 
their production backup servers greatly:

        The throughput leaped from 5MBps to 200MBps.
        
They are doing some sparse sequential reads on RAID5 arrays,
which have been totally ignored by the stock readahead.


backward reading
================

 64k     2.00   1.28     -36.0%
  4k    11.87   4.49     -62.2%

Backward prefetching is now supported :-)


loop mounted debian.iso
=======================

grep -r         17.92   17.46   -2.6%
diff -r          8.62    8.26   -4.2%

This test is a bit sensitive to memory size. With sufficient memory, it may be
a little better to set readahead_hit_rate to >= 1, since the context
readahead can recognize sequential patterns hidden in many random ones.


Regards,
Fengguang Wu
