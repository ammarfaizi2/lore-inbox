Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267286AbTAVDHu>; Tue, 21 Jan 2003 22:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267287AbTAVDHu>; Tue, 21 Jan 2003 22:07:50 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:2960 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267286AbTAVDHs>;
	Tue, 21 Jan 2003 22:07:48 -0500
Subject: Re: [patch] HT scheduler, sched-2.5.59-D7
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Theurer <habanero@us.ibm.com>, Erich Focht <efocht@ess.nec.de>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <Pine.LNX.4.44.0301202204210.18235-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0301202204210.18235-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Jan 2003 19:15:43 -0800
Message-Id: <1043205347.5161.42.camel@kenai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-20 at 13:18, Ingo Molnar wrote:
> 
> the attached patch (against 2.5.59) is my current scheduler tree, it
> includes two main areas of changes:
> 
>  - interactivity improvements, mostly reworked bits from Andrea's tree and 
>    various tunings.
> 
>  - HT scheduler: 'shared runqueue' concept plus related logic: HT-aware
>    passive load balancing, active-balancing, HT-aware task pickup,
>    HT-aware affinity and HT-aware wakeup.

I ran Erich's numatest on a system with this patch, plus the 
cputime_stats patch (so that we would get meaningful numbers),
and found a problem.  It appears that on the lightly loaded system
sched_best_cpu is now loading up one node before moving on to the
next.  Once the system is loaded (i.e., a process per cpu) things
even out.  Before applying the D7 patch, processes were distributed
evenly across nodes, even in low load situations.  

The numbers below on schedbench show that on 4 and 8 process runs, 
the D7 patch gets the same average user time as on the 16 and greater
runs.  However, without the D7 patch, the 4 and 8 process runs tend
to have significantly decreased average user time.

Below I'm including the summarized output, and then the detailed
output for the relevant runs on both D7 patched systems and stock.

Overall performance is improved with the D7 patch, so I would like
to find out and fix what went wrong on the light load cases and
encourage the adoption of the the D7 patch (or at least the parts 
that make the NUMA scheduler even faster).  I'm not likely to have 
time to chase this down for the next few days, so am posting
results to see if anyone else can find the cause.

kernels: 
 * stock59-stats = stock 2.5.59 with the cputime_stats patch
 * ingoD7-59.stats = testD7-59 = stock59-stats + Ingo's D7 patch

Kernbench:
                        Elapsed       User     System        CPU
           testD7-59     28.96s   285.314s    79.616s    1260.6%
     ingoD7-59.stats    28.824s   284.834s    79.164s    1263.6%
       stock59-stats    29.498s   283.976s     83.05s    1243.8%

Schedbench 4:
                        AvgUser    Elapsed  TotalUser   TotalSys
           testD7-59      53.19      53.43     212.81       0.59
     ingoD7-59.stats      44.77      46.52     179.10       0.78
       stock59-stats      22.25      35.94      89.06       0.81

Schedbench 8:
                        AvgUser    Elapsed  TotalUser   TotalSys
           testD7-59      53.22      53.66     425.81       1.40
     ingoD7-59.stats      39.44      47.15     315.62       1.62
       stock59-stats      28.40      42.25     227.26       1.67

Schedbench 16:
                        AvgUser    Elapsed  TotalUser   TotalSys
           testD7-59      52.84      58.26     845.49       2.78
     ingoD7-59.stats      52.85      57.31     845.68       3.29
       stock59-stats      52.97      57.19     847.70       3.29

Schedbench 32:
                        AvgUser    Elapsed  TotalUser   TotalSys
           testD7-59      56.77     122.51    1816.80       7.58
     ingoD7-59.stats      56.54     125.79    1809.67       6.97
       stock59-stats      56.57     118.05    1810.53       5.97

Schedbench 64:
                        AvgUser    Elapsed  TotalUser   TotalSys
           testD7-59      57.52     234.27    3681.86      18.18
     ingoD7-59.stats      58.25     242.61    3728.46      17.40
       stock59-stats      56.75     234.12    3632.72      15.70

Detailed stats from running numatest with 4 processes on the D7 patch. 
Note how most of the load is put on node 0.

Executing 4 times: ./randupdt 1000000 
Running 'hackbench 20' in the background: Time: 5.039
Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
  1   100.0    0.0    0.0    0.0 |    0     0    |  46.27
  2    58.4    0.0    0.0   41.6 |    0     0    |  41.18
  3   100.0    0.0    0.0    0.0 |    0     0    |  45.72
  4   100.0    0.0    0.0    0.0 |    0     0    |  45.89
AverageUserTime 44.77 seconds
ElapsedTime     46.52
TotalUserTime   179.10
TotalSysTime    0.78

Detailed stats from running numatest with 8 processes on the D7 patch.
In this one it appears that node 0 was loaded, then node 1.

Executing 8 times: ./randupdt 1000000 
Running 'hackbench 20' in the background: Time: 11.185
Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
  1   100.0    0.0    0.0    0.0 |    0     0    |  46.89
  2   100.0    0.0    0.0    0.0 |    0     0    |  46.20
  3   100.0    0.0    0.0    0.0 |    0     0    |  46.31
  4     0.0  100.0    0.0    0.0 |    1     1    |  39.44
  5     0.0    0.0   99.9    0.0 |    2     2    |  16.00
  6    62.6    0.0    0.0   37.4 |    0     0    |  42.23
  7     0.0  100.0    0.0    0.0 |    1     1    |  39.12
  8     0.0  100.0    0.0    0.0 |    1     1    |  39.35
AverageUserTime 39.44 seconds
ElapsedTime     47.15
TotalUserTime   315.62
TotalSysTime    1.62

Control run - detailed stats running numatest with 4 processes
on a stock59 kernel.

Executing 4 times: ./randupdt 1000000 
Running 'hackbench 20' in the background: Time: 8.297
Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
  1     0.0   99.8    0.0    0.0 |    1     1    |  16.63
  2   100.0    0.0    0.0    0.0 |    0     0    |  27.83
  3     0.0    0.0   99.9    0.0 |    2     2    |  16.27
  4   100.0    0.0    0.0    0.0 |    0     0    |  28.29
AverageUserTime 22.25 seconds
ElapsedTime     35.94
TotalUserTime   89.06
TotalSysTime    0.81

Control run - detailed stats running numatest with 8 processes
on a stock59 kernel.

Executing 8 times: ./randupdt 1000000 
Running 'hackbench 20' in the background: Time: 9.458
Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
  1     0.0   99.9    0.0    0.0 |    1     1    |  27.77
  2   100.0    0.0    0.0    0.0 |    0     0    |  29.34
  3     0.0    0.0  100.0    0.0 |    2     2    |  28.03
  4     0.0    0.0    0.0  100.0 |    3     3    |  24.15
  5    13.1    0.0    0.0   86.9 |    0     3   *|  33.36
  6     0.0  100.0    0.0    0.0 |    1     1    |  27.94
  7     0.0    0.0  100.0    0.0 |    2     2    |  28.02
  8   100.0    0.0    0.0    0.0 |    0     0    |  28.58

-- 
Michael Hohnbaum            503-578-5486
hohnbaum@us.ibm.com         T/L 775-5486

