Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318326AbSIKFj6>; Wed, 11 Sep 2002 01:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318348AbSIKFj5>; Wed, 11 Sep 2002 01:39:57 -0400
Received: from packet.digeo.com ([12.110.80.53]:30092 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S318326AbSIKFjw>;
	Wed, 11 Sep 2002 01:39:52 -0400
Message-ID: <3D7EDBCE.4FD0B9B4@digeo.com>
Date: Tue, 10 Sep 2002 22:59:42 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: rwhron@earthlink.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Performance differences in recent kernels
References: <20020911035400.GB26348@rushmore>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Sep 2002 05:44:31.0494 (UTC) FILETIME=[4D12EA60:01C25956]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rwhron@earthlink.net wrote:
> 
> Just to note a few differences in recent benchmarks on quad xeon
> with 3.75 gb ram and qlogic 2200 -> raid 5 array.

Awesome.  Thanks.

> For AIM7, the outstanding metrics are jobs/min (high is good),
> and cpu time (in seconds).  The tasks column is equivalent to
> load average.
> 
> AIM7 database workload

I'll have to get my hands on this.
 
> Andrea's tree has the v6.0 qlogic driver which helps i/o a lot.
> It's the only tree with that driver atm.  The other trees look
> pretty similar at load averages of 32 and 256.
> 
> kernel                   Tasks   Jobs/Min       Real    CPU
> 2.4.19-rc5-aa1           32     555.4           342.2   146.1
> 2.4.20-pre5              32     470.7           403.8   147.2
> 2.4.20-pre4-ac1          32     472.0           402.7   142.4
> 2.5.33-mm5               32     474.4           400.7   144.2
> 
> 2.4.19-rc5-aa1           256    905.2           1679.9  931.9
> 2.4.20-pre5              256    769.1           1977.0 1048.5
> 2.4.20-pre4-ac1          256    766.4           1984.2  945.5
> 2.5.33-mm5               256    763.0           1992.9 1020.8

I assume that's seconds of CPU for the entire run?
 
> AIM7 file server workload
> 
> Interesting here to note that with low load averages,
> 2.5.33-mm5 is on top, but as load average increases, -aa is
> ahead.
> 
> kernel                   Tasks   Jobs/Min        Real    CPU
> 2.4.19-rc5-aa1           4      131.6           184.2   45.5
> 2.4.20-pre5              4      132.7           182.7   44.1
> 2.4.20-pre4-ac1          4      132.7           182.6   46.0
> 2.5.33-mm5               4      140.4           172.6   37.7
> 
> 2.4.19-rc5-aa1           32     264.8           732.3   219.1
> 2.4.20-pre5              32     230.5           841.5   265.7
> 2.4.20-pre4-ac1          32     227.7           851.6   257.6
> 2.5.33-mm5               32     229.8           843.7   224.7
> 
> AIM7 shared multiuser workload
> 
> This is more cpu intensive than the other aim7 workloads.
> 2.5.33-mm5 is using a lot more cpu time.  That may be a bug in
> the workload.  I'm investigating that.
> 
> kernel                   Tasks   Jobs/Min        Real    CPU
> 2.4.19-rc5-aa1           64     2319.6          160.6   163.8
> 2.4.20-pre4-ac1          64     1960.4          190.0   164.8
> 2.4.20-pre5              64     1980.3          188.1   185.1
> 2.5.33-mm5               64     1461.2          254.9   566.2
> 
> 2.4.19-rc5-aa1           256    2835.5          525.5   652.6
> 2.4.20-pre4-ac1          256    2444.2          609.6   656.6
> 2.4.20-pre5              256    2432.8          612.4   701.0
> 2.5.33-mm5               256    1890.5          788.1  2316.4

I think there may be a couple of spots where I'm spinning out of control
in there. Badari has reported a big regression in writeout speed to
sixty(!) disks.  Or possibly block-highmem got broken again; don't
know yet.
 
> IRMAN - interactive response measurement.
> 2.5.33-mm5 has much lower max response time for file io.
> The standard deviation is very low too (which is good).
> 
>                    FILE_IO Response time measurements (milliseconds)
>                            Max         Min         Avg       StdDev
> 2.4.20-pre4-ac1          40.603       0.008       0.009       0.043
> 2.4.20-pre5              52.405       0.009       0.011       0.080
> 2.5.33-mm5                2.955       0.008       0.010       0.004

For many things, 1/latency == throughput.  But the averages are
the same here.  Be interesting to run it on the 384 megabyte machine.

irman's io test doesn't seem to be very good, actually.  It creates
a megabyte of pagecache and seeks around it.  That's an uncommon
thing to do.

It would be interesting to run irman in conjunction with tiobench
or dbench.  One the same disk and on a different disk.

> autoconf-2.53 build (12 times) creates about 1.2 million processes.
> It's a good fork test.  rmap slows this one down.  There is a healthy
> difference between the rmap in 2.5.33-mm5 and 2.4.20-pre4-ac1.
> 
> kernel                           seconds (smaller is better)
> 2.4.20-pre4-ac1                    856.4
> 2.4.19-rc5-aa1                     727.2
> 2.4.20-pre5                        718.4
> 2.5.33                             799.2
> 2.5.33-mm5                         782.0

Yup.  We've pulled back half of the rmap CPU cost, and half of its
space consumption.
 
> Time to build the kernel 12 times.  Not a lot of difference here.
> 
> kernel                           seconds
> 2.4.19-rc5-aa1                     718.8
> 2.4.20-pre4-ac1                    735.8
> 2.4.20-pre5                        728.1
> 2.5.33                             728.2
> 2.5.33-mm5                         736.8

Should have been better than that.  Although the kmap work doesn't
seem to affect these machines.  Is that a `make -j1', `-j6'???

> The Open Source database benchmark doesn't vary much between trees.
> 
> dbench on various filesystems.   This isn't meant to compare
> filesystem because the disk geometry is different for each fs.
> 
> rmap has generally not done well on dbench when the process
> count is high, but 2.5.33* on ext2 and ext3 really smokes at
> 64 processes.
>
> dbench ext2 64 processes                Average (5 runs)
> 2.4.19-rc5-aa1                          179.61  MB/second
> 2.4.20-pre4-ac1                         140.63
> 2.4.20-pre5                             145.00
> 2.5.33                                  220.54
> 2.5.33-mm5                              214.78

At 64 processes you're pretty much CPU-bound.  The difference is due
to the buffer-layer rework.  -mm5 would have done more IO here.  The
lower dirty memory threshold costs 15% here.

> dbench ext2 192 processes               Average
> 2.4.19-rc5-aa1                          155.44
> 2.4.20-pre4-ac1                          79.16
> 2.4.20-pre5                             115.31
> 2.5.33                                  134.27
> 2.5.33-mm5                              174.17

-mm5 starts writeback much earlier than 2.5.33 and does more IO.  
It is faster because the VM does not wait on individual dirty pages.

> dbench ext3 64 processes                Average
> 2.4.19-rc5-aa1                           97.69
> 2.4.20-pre4-ac1                          59.42
> 2.4.20-pre5                              80.79
> 2.5.33-mm5                              112.20
> 
> dbench ext3 192 processes               Average
> 2.4.19-rc5-aa1                           77.06
> 2.4.20-pre4-ac1                          28.48
> 2.4.20-pre5                              58.66
> 2.5.33-mm5                               72.92
> 
> dbench reiserfs 64 processes            Average
> 2.4.19-rc5-aa1                           70.50
> 2.4.20-pre4-ac1                          57.30
> 2.4.20-pre5                              62.60
> 2.5.33-mm5                               77.22
> 
> dbench reiserfs 192 processes           Average
> 2.4.19-rc5-aa1                           55.37
> 2.4.20-pre4-ac1                          20.56
> 2.4.20-pre5                              44.14
> 2.5.33-mm5                               49.61

Odd.  I've been steadily winding down the dirty memory thresholds.
dbench 192 should have suffered more.

It is useful to watch the amount of CPU which is consumed with dbench,
btw.  That's one thing which tends to be fairly repeatable between runs.
 
> The O(1) scheduler helps tbench a lot when the process
> count is high.  The ac tree may not have the latest
> scheduler updates.
> 
> tbench 192 processes            Average
> 2.4.19-rc5-aa1                  116.76
> 2.4.20-pre4-ac1                 100.30
> 2.4.20-pre5                      27.98
> 2.5.33                          115.93
> 2.5.33-mm5                      117.91
> 
> LMbench latency running /bin/sh had a big regression in the
> -mm tree recently.
> 
>                       fork    execve  /bin/sh
> kernel              process  process  process
> ------------------  -------  -------  -------
> 2.4.19-rc5-aa1        186.8    883.1   3937.9
> 2.4.20-pre4-ac1       227.9    904.5   3866.0
> 2.4.20-pre5           310.0    990.9   4178.1
> 2.5.33-mm5            244.3    949.0  71588.2

Something went horridly wrong with that in 2.5.33.  I think it got
fixed up.
 
> Context switching with 32K - times in microseconds - smaller is better
> ----------------------------------------------------------------------
>                    32prc/32k  64prc/32k  96prc/32k
> kernel             ctx swtch  ctx swtch  ctx swtch
> ----------------   ---------  ---------  ---------
> 2.4.19-rc5-aa1        35.411     65.120     64.686
> 2.4.20-pre4-ac1       30.642     49.307     56.068
> 2.4.20-pre5           17.716     27.205     43.716
> 2.5.33-mm5            21.786     49.555     63.000
> 
> Context switching with 64K - times in microseconds - smaller is better
> ----------------------------------------------------------------------
>                    16prc/64k  32prc/64k  64prc/64k
> kernel             ctx swtch  ctx swtch  ctx swtch
> ----------------   ---------  ---------  ---------
> 2.4.19-rc5-aa1        50.523    111.320    137.383
> 2.4.20-pre4-ac1       50.691     92.204    122.261
> 2.4.20-pre5           36.763     44.498    111.952
> 2.5.33-mm5            27.113     42.679    124.907
> 
> File create/delete and VM system latencies in microseconds - smaller is better
> ----------------------------------------------------------------------------
> The -aa tree higher latency for file creation.  File delete latency is
> similar for all trees.  2.4.20-pre5 has the lowest mmap latency, 2.5.33-mm5
> the highest.
> 
>                    0K         1K       10K      10K     Mmap     Page
> kernel           Create     Create    Create   Delete   Latency  Fault
> ---------------- -------    -------   -------  -------  -------  ------
> 2.4.19-rc5-aa1    126.57     174.70    256.64    62.50   3728.2    4.00
> 2.4.20-pre4-ac1    86.92     137.28    217.73    61.22   3557.2    3.00
> 2.4.20-pre5        90.24     140.22    219.17    61.38   2673.8    3.00
> 2.5.33-mm5         93.43     143.58    225.19    63.83   4634.7    4.00

Most of the create cost is in a bit of debug code in ext2.

> *Local* Communication latencies in microseconds - smaller is better
> -------------------------------------------------------------------
> 2.5.33-mm5 has significanly lower latency here, except for tcp connection.
> 
> kernel               Pipe   AF/Unix     UDP       TCP   RPC/TCP  TCPconn
> -----------------  -------  -------  -------   -------  -------  -------
> 2.4.19-rc5-aa1      36.697   48.436  55.3271   50.8352  80.8498   88.330
> 2.4.20-pre4-ac1     34.110   56.582  53.9643   54.7447  84.4660   86.195
> 2.4.20-pre5         10.819   25.379  38.4917   45.2661  79.1166   86.745
> 2.5.33-mm5           8.337   14.122  23.6442   35.4457  77.0814  111.252
> 
> *Local* Communication bandwidths in MB/s - bigger is better
> -----------------------------------------------------------
> 
> kernel               Pipe   AF/Unix    TCP
> -----------------  -------  -------  -------
> 2.4.19-rc5-aa1      541.56   253.43   166.08
> 2.4.20-pre4-ac1     552.99   240.54   168.34
> 2.4.20-pre5         462.82   273.55   161.28
> 2.5.33-mm5          515.64   543.57   171.01
> 
> tiobench-0.3.3 is create 12 gigabytes worth of files.
> 
> Unit information
> ================
> Rate      = megabytes per second
> CPU%      = percentage of CPU used during the test
> Latency   = milliseconds
> Lat%      = percent of requests that took longer than 10 seconds
> CPU Eff   = Rate divided by CPU% - throughput per cpu load
> 
> Sequential Reads ext2
> 2.5.33-mm5 has much lower max latency when the thread count is high for
> sequentional reads.  The qlogic driver in -aa helps a lot here too.
> 
>                    Num                    Avg       Maximum      Lat%   CPU
> Kernel             Thr   Rate  (CPU%)   Latency     Latency      >10s   Eff
> ------------------ ---  ---------------------------------------------------
> 
> 2.4.19-rc5-aa1       1   51.21 28.87%     0.226      103.26   0.00000   177
> 2.4.20-pre4-ac1      1   34.14 17.25%     0.341      851.34   0.00000   198
> 2.4.20-pre5          1   33.68 20.36%     0.345      110.11   0.00000   165
> 2.5.33               1   25.36 13.67%     0.460     1512.99   0.00000   185
> 2.5.33-mm5           1   31.73 14.80%     0.367      853.99   0.00000   214
> 
> 2.4.19-rc5-aa1     256   40.68 25.39%    64.084   107977.97   0.36264   160
> 2.4.20-pre4-ac1    256   34.51 19.63%    51.031   845159.88   0.02919   176
> 2.4.20-pre5        256   31.89 22.95%    57.236   849792.70   0.03459   139
> 2.5.33             256   24.54 14.46%    94.422   449274.89   0.09794   170
> 2.5.33-mm5         256   22.39 18.56%   104.515    24623.21   0.00000   121

That's actually a bug.  There is some form of interaction between readahead
and request merging which results in single read streams not being able
to capture the disk head for a decent amount of time.
 
> Sequential Writes ext2
> There is a dramatic reduction in cpu utilization in 2.5.33-mm5 and increase in
> throughput compared to 2.5.33 when thread count is high.
> 
>                    Num                    Avg       Maximum      Lat%   CPU
> Kernel             Thr   Rate  (CPU%)   Latency     Latency      >10s   Eff
> ------------------ ---  ---------------------------------------------------
> 2.4.19-rc5-aa1     128   37.40 45.99%    32.405    46333.30   0.00105    81
> 2.4.20-pre4-ac1    128   34.01 36.94%    40.121    47331.57   0.00058    92
> 2.4.20-pre5        128   32.98 49.33%    39.692    52093.19   0.01446    67
> 2.5.33             128   12.17 222.9%   108.966   910455.61   0.19503     5
> 2.5.33-mm5         128   30.78 30.03%    32.973   909931.81   0.07858   102

This test is highly dependent upon the size of the request queues.  The
queues have 128 slots and you're running 128 threads.  One would expect
to see a lot of variability with that combo.  Would be interesting to also
test 64 threads, and 256.

-aa has the "merge even after latency has expired" logic in the elevator,
which could make some difference at the 128 thread level.

> Sequential Reads ext3
> 2.5.33-mm5 has a more graceful degradation in throughput on ext3.
> Fairness is better too.
> 
>                    Num                    Avg       Maximum      Lat%   CPU
> Kernel             Thr   Rate  (CPU%)   Latency     Latency      >10s   Eff
> ------------------ ---  ---------------------------------------------------
> 2.4.19-rc5-aa1       1   51.13 29.59%     0.227      460.92   0.00000   173
> 2.4.20-pre4-ac1      1   34.12 17.37%     0.341     1019.65   0.00000   196
> 2.4.20-pre5          1   33.28 20.62%     0.350      137.44   0.00000   161
> 2.5.33-mm5           1   31.70 14.75%     0.367      581.89   0.00000   215

20% drop in CPU load is typical, but the reduced bandwidth on such
a simple test is unexpected.  Presumably that's the driver thing.

> 2.4.19-rc5-aa1      64    7.38  4.51%    98.947    20638.56   0.00000   164
> 2.4.20-pre4-ac1     64    6.55  3.94%   110.432    14937.49   0.00000   166
> 2.4.20-pre5         64    6.34  4.16%   111.299    14234.83   0.00000   152
> 2.5.33-mm5          64   12.29  8.51%    55.372     8799.99   0.00000   144

hm.  Don't know.  Something went right in the 2.5 elevator I guess.

> Sequential Writes ext3
> Here 2.5.33-mm5 is great with 1 thread, but takes a hit at 32 threads.
> Latency is pretty high too.  Cpu utilization is quite low though.
> 
>                    Num                    Avg       Maximum      Lat%   CPU
> Kernel             Thr   Rate  (CPU%)   Latency     Latency      >10s   Eff
> ------------------ ---  ---------------------------------------------------
> 2.4.19-rc5-aa1       1   44.23 53.01%     0.243     6084.88   0.00000    83
> 2.4.20-pre4-ac1      1   37.86 50.66%     0.300     4288.99   0.00000    75
> 2.4.20-pre5          1   37.58 55.38%     0.295    14659.06   0.00003    68
> 2.5.33-mm5           1   54.16 65.87%     0.211     5605.87   0.00000    82
> 
> 2.4.19-rc5-aa1      32   20.86 121.6%     8.861    13693.99   0.00000    17
> 2.4.20-pre4-ac1     32   28.33 156.6%    10.041    15724.46   0.00000    18
> 2.4.20-pre5         32   22.36 114.3%    10.382    12867.96   0.00000    20
> 2.5.33-mm5          32    5.90 11.67%    52.386  1150696.62   0.08252    50

There's a funny situation where ext3 ends up going all synchronous when
someone wants to modify an inode at a particular part of the commit
lifecycle.  Perhaps that happened..
