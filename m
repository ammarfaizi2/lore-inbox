Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261552AbSJGQgd>; Mon, 7 Oct 2002 12:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261600AbSJGQgc>; Mon, 7 Oct 2002 12:36:32 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:745 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261552AbSJGQgU>;
	Mon, 7 Oct 2002 12:36:20 -0400
Subject: Re: [RFC] NUMA schedulers benchmark results
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Erich Focht <efocht@ess.nec.de>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200210061851.45401.efocht@ess.nec.de>
References: <200210061851.45401.efocht@ess.nec.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 07 Oct 2002 09:37:51 -0700
Message-Id: <1034008671.1280.82.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erich,

These numbers look pretty good for your scheduler.  It would be good
if you could post numbers against 2.5.x where x is the same for all
tests.  I thought you had your scheduler working on 2.5.x recently.

Running numa_test on my systems I find a lot of variation (as much
as 10%) between identical runs.  Are all of these results averaged
over multiple runs?  Any idea why the hackbench times vary so widely?

Looking at the results for my scheduler, it is real obvious what the
algorithm is that I use for selecting a cpu for a process.  This has
not been quite as apparent on my systems, probably due to other tasks
running in the background.  The code in your scheduler that causes a
different node to start the search for a cpu really pays off here.  

I know that there are some balance issues, especially on light loads
for my scheduler.  I've got two tweaks that help that, but I think that
adding something similar to what you have done to keep track of the last
node picked and starting at the next node could be beneficial.

                  Michael

On Sun, 2002-10-06 at 09:51, Erich Focht wrote:
> Hi,
> 
> here are some results from testing various versions and approaches
> to a NUMA scheduler. I used the numa_test benchmark which I'll post
> in a separate email. It runs in parallel N tasks doing the same job:
> access randomly a large array. As the array is large enough not to
> fit into cache, this is very memory latency sensitive. Also it is
> memory bandwidth sensitive. To emulate a real multi-user environment, the
> jobs are disturbed by a short load peak. This is simulated by a call
> to "hackbench" 3 seconds after the tasks were started. The performance
> of the user tasks is depending very much on where they are scheduled
> and are CPU hoggers such that the user times are quite independent of
> the non-scheduler part of the underlying kernel. The elapsed times
> are depending on "hackbench" which actually blocks the machine for the
> time it is running. Hackbench is depending on the underlying kernel
> and one should compare "elapsed_time - hackbench_time".
> 
> The test machine is a 16 CPU NEC Azusa with Itanium processors and
> four nodes. The tested schedulers are:
> 
> A: O(1) scheduler in 2.5.39
> B: O(1) scheduler with task steal limited to only one task (node
>    affine scheduler with CONFIG_NUMA_SCHED=n) under 2.4.18
> C: Michael Hohnbaum's "simple NUMA scheduler" under 2.5.39
> D: pooling NUMA scheduler, no initial load balancing, idle pool_delay
>    set to 0, under 2.4.18
> E: node affine scheduler with initial load balancing and static homenode
> F: node affine scheduler without initial load balancing and dynamic
>    homenode selection (homenode selected where most of the memory is
>    allocated).
> 
> As I'm rewriting the node affine scheduler to be more modular, I'll
> redo the tests for cases D, E, F on top of 2.5.X kernels soon.
> 
> The results are summarized in the tables below. A set of outputs (for
> N=8, 16, 32) is attached. They show clearly why the node affine
> scheduler beats them all: The initial load balancing is node-aware,
> the task-stealing too. Sometimes the node affine force is not large
> enough to bring the task back to the homenode, but it is almost always
> good enough.
> 
> The (F) solution with dynamically determined homenode show that the
> initial load balancing is crucial, as the equal node balance is not
> strongly enforced dynamically. So the optimal solution is probably
> (F) with initial load balancing.
> 
> 
> Average user time (U) and total user time (TU). Minimum per row should
> be considered.
> ----------------------------------------------------------------------
> Scheduler:	A	B	C	D	E	F
> N=4	U	28.12	30.77	33.00	-	27.20	30.29
> 	TU	112.55	123.13	132.08	-	108.88	121.25
> N=8	U	30.47	31.39	31.65	30.76	28.67	30.08
> 	TU	243.86	251.27	253.30	246.23	229.51	240.75
> N=16	U	36.42	33.64	32.18	32.27	31.50	32.83
> 	TU	582.91	538.49	515.11	516.53	504.17	525.59
> N=32	U	38.69	34.83	34.05	33.76	33.89	34.11
> 	TU	1238.4	1114.9	1090.1	1080.8	1084.9	1091.9
> N=64	U	39.73	34.73	34.23	-	(33.32)	34.98
> 	TU	2543.4	2223.4	2191.7	-	(2133)	2239.5
> 
> 
> Elapsed time (E), hackbench time (H). Diferences between 2.4.18 and
> 2.5.39 based kernels due to "hackbench", which performs differently.
> Compare E-H within a row, but don't take it too seriously.
> --------------------------------------------------------------------
> Scheduler:	A	B	C	D	E	F
> N=4	E	37.33	37.96	48.31	-	28.14	35.91
> 	H	9.98	1.49	10.65	-	1.99	1.43
> N=8	E	46.17	39.50	42.53	39.72	30.28	38.28
> 	H	9.64	1.86	7.27	2.07	2.33	1.86
> N=16	E	47.21	44.67	49.66	42.97	36.98	42.51
> 	H	5.90	4.69	2.93	5.178	5.56	5.94
> N=32	E	88.60	79.92	80.34	78.35	76.84	77.38
> 	H	6.29	5.23	2.85	4.51	5.29	4.28
> N=64	E	167.10	147.16	150.59	-	(133.9)	148.94
> 	H	5.96	4.67	3.10	-	(-)	6.86
> 
> (The E:N=64 results are without hackbench disturbance.)
> 
> Best regards,
> Erich
> ----
> 

> A: 2.5.39 O(1) scheduler
> 
> Running 'hackbench 20' in the background: Time: 9.639
> Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
>   1     7.5   92.5    0.0    0.0 |    0     1   *|  38.29
>   2     0.0    0.0    0.0  100.0 |    0     3   *|  30.19
>   3     0.0  100.0    0.0    0.0 |    0     1   *|  27.84
>   4     0.0    0.0    0.0  100.0 |    0     3   *|  30.38
>   5   100.0    0.0    0.0    0.0 |    0     0    |  29.96
>   6   100.0    0.0    0.0    0.0 |    0     0    |  29.63
>   7     0.0    0.0  100.0    0.0 |    0     2   *|  27.33
>   8     0.0    0.0    0.0  100.0 |    0     3   *|  30.14
> AverageUserTime 30.47 seconds
> ElapsedTime     46.17
> TotalUserTime   243.86
> TotalSysTime    0.41
> 
> Running 'hackbench 20' in the background: Time: 5.896
> Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
>   1     0.0   98.7    1.3    0.0 |    0     1   *|  41.07
>   2    89.2   10.8    0.0    0.0 |    0     0    |  39.16
>   3     9.4    0.0   90.6    0.0 |    0     2   *|  40.72
>   4     0.0    0.0    0.0  100.0 |    0     3   *|  31.96
>   5     0.0    0.1   99.0    0.9 |    0     2   *|  41.36
>   6     0.0    0.0  100.0    0.0 |    0     2   *|  30.62
>   7     0.6    0.0   86.2   13.2 |    0     2   *|  40.11
>   8   100.0    0.0    0.0    0.0 |    0     0    |  31.25
>   9     8.0    0.0    0.0   92.0 |    0     3   *|  40.63
>  10     0.0  100.0    0.0    0.0 |    0     1   *|  30.43
>  11     0.0    0.0    0.0  100.0 |    0     3   *|  31.64
>  12    91.6    0.0    8.4    0.0 |    0     0    |  39.92
>  13     0.0  100.0    0.0    0.0 |    0     1   *|  30.46
>  14    92.1    0.0    7.9    0.0 |    0     0    |  40.36
>  15     0.0    0.0    0.0  100.0 |    0     3   *|  32.29
>  16     4.8   95.2    0.0    0.0 |    0     1   *|  40.70
> AverageUserTime 36.42 seconds
> ElapsedTime     47.21
> TotalUserTime   582.91
> TotalSysTime    0.85
> 
> Running 'hackbench 20' in the background: Time: 6.293
> Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
>   1     0.0    0.0  100.0    0.0 |    0     2   *|  31.53
>   2   100.0    0.0    0.0    0.0 |    0     0    |  34.84
>   3   100.0    0.0    0.0    0.0 |    0     0    |  32.70
>   4     0.0  100.0    0.0    0.0 |    0     1   *|  32.25
>   5     0.0    0.0    0.0  100.0 |    0     3   *|  33.41
>   6    96.5    2.7    0.8    0.0 |    0     0    |  43.39
>   7     5.6    0.0   94.4    0.0 |    0     2   *|  44.42
>   8    73.4   22.9    3.7    0.0 |    0     0    |  42.14
>   9     0.9    0.0   99.1    0.0 |    0     2   *|  45.10
>  10     0.0    8.4   91.6    0.0 |    0     2   *|  42.85
>  11     0.0    0.0    0.0  100.0 |    0     3   *|  32.11
>  12     0.0  100.0    0.0    0.0 |    0     1   *|  32.16
>  13     0.0    0.0    0.0  100.0 |    0     3   *|  33.48
>  14     0.0    0.0  100.0    0.0 |    0     2   *|  31.35
>  15     0.0    0.3    3.2   96.4 |    0     3   *|  42.27
>  16    91.0    0.0    0.0    9.0 |    0     0    |  35.50
>  17     0.0  100.0    0.0    0.0 |    0     1   *|  32.45
>  18     0.0   97.6    2.4    0.0 |    0     1   *|  41.97
>  19     0.0  100.0    0.0    0.0 |    0     1   *|  32.46
>  20     1.3    0.0   74.2   24.5 |    0     2   *|  43.78
>  21     0.0    0.0    0.9   99.1 |    0     3   *|  32.74
>  22     0.8    0.0   99.2    0.0 |    0     2   *|  45.61
>  23   100.0    0.0    0.0    0.0 |    0     0    |  33.78
>  24    97.0    1.0    0.0    1.9 |    0     0    |  43.74
>  25     0.0    1.8    0.0   98.2 |    0     3   *|  43.31
>  26     0.0   96.1    0.0    3.9 |    0     1   *|  43.61
>  27     2.6    0.0    0.3   97.0 |    0     3   *|  46.54
>  28     0.0    0.0    0.0  100.0 |    0     3   *|  33.59
>  29     0.0   92.1    0.0    7.9 |    0     1   *|  43.43
>  30     2.2    0.0   97.8    0.0 |    0     2   *|  45.19
>  31    26.0   72.3    0.0    1.8 |    0     1   *|  43.29
>  32    98.5    1.3    0.2    0.0 |    0     0    |  42.97
> AverageUserTime 38.69 seconds
> ElapsedTime     88.60
> TotalUserTime   1238.43
> TotalSysTime    1.85
> 
> -------------------------------------------------------------
> B: O(1) scheduler equivalent, 1 task steal per load balance step
> (2.4.18 node affine scheduler with CONFIG_NUMA_SCHED=n)
> 
> Running 'hackbench 20' in the background: Time: 1.861
> Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
>   1     0.0    0.0  100.0    0.0 |    2     2    |  31.62
>   2     0.0    0.0  100.0    0.0 |    2     2    |  31.68
>   3   100.0    0.0    0.0    0.0 |    0     0    |  29.40
>   4     0.0    0.0  100.0    0.0 |    2     2    |  31.56
>   5     0.0    0.0  100.0    0.0 |    2     2    |  31.60
>   6    95.0    5.0    0.0    0.0 |    1     0   *|  38.14
>   7   100.0    0.0    0.0    0.0 |    0     0    |  29.27
>   8     0.0  100.0    0.0    0.0 |    1     1    |  27.87
> AverageUserTime 31.39 seconds
> ElapsedTime     39.50
> TotalUserTime   251.27
> TotalSysTime    0.48
> 
> Running 'hackbench 20' in the background: Time: 4.688
> Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
>   1     0.0    0.0  100.0    0.0 |    2     2    |  31.49
>   2     0.0    0.0  100.0    0.0 |    2     2    |  31.33
>   3     0.0    0.0  100.0    0.0 |    2     2    |  31.30
>   4   100.0    0.0    0.0    0.0 |    0     0    |  31.98
>   5   100.0    0.0    0.0    0.0 |    0     0    |  32.21
>   6     0.0   91.3    8.7    0.0 |    2     1   *|  39.88
>   7     0.0  100.0    0.0    0.0 |    1     1    |  30.72
>   8     0.0    0.0    0.0  100.0 |    3     3    |  31.56
>   9     1.2   98.8    0.0    0.0 |    0     1   *|  41.31
>  10     0.0    0.0    0.0  100.0 |    3     3    |  31.56
>  11     0.0  100.0    0.0    0.0 |    1     1    |  30.67
>  12     0.0    0.0    0.0  100.0 |    3     3    |  31.45
>  13   100.0    0.0    0.0    0.0 |    0     0    |  31.94
>  14     5.5    0.0   94.5    0.0 |    0     2   *|  40.83
>  15     0.0    0.0    0.0  100.0 |    3     3    |  31.53
>  16    83.0   17.0    0.0    0.0 |    1     0   *|  38.50
> AverageUserTime 33.64 seconds
> ElapsedTime     44.67
> TotalUserTime   538.49
> TotalSysTime    1.02
> 
> Running 'hackbench 20' in the background: Time: 5.229
> Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
>   1    67.6    0.0   17.4   15.0 |    2     0   *|  41.36
>   2     0.0    0.0  100.0    0.0 |    2     2    |  32.78
>   3   100.0    0.0    0.0    0.0 |    0     0    |  32.92
>   4     0.0    0.0  100.0    0.0 |    2     2    |  33.56
>   5    22.4   75.3    2.3    0.0 |    2     1   *|  43.26
>   6     0.0    0.0  100.0    0.0 |    2     2    |  33.38
>   7   100.0    0.0    0.0    0.0 |    0     0    |  33.16
>   8     0.0    0.0    0.0  100.0 |    3     3    |  32.03
>   9     0.0  100.0    0.0    0.0 |    1     1    |  32.64
>  10     0.0    0.0    0.0  100.0 |    3     3    |  32.00
>  11     4.5    0.0    0.0   95.5 |    0     3   *|  43.82
>  12     0.0    0.0    0.0  100.0 |    3     3    |  31.91
>  13   100.0    0.0    0.0    0.0 |    0     0    |  33.46
>  14     0.0  100.0    0.0    0.0 |    1     1    |  32.39
>  15     0.0    0.0    0.0  100.0 |    3     3    |  31.86
>  16     0.0    0.0  100.0    0.0 |    2     2    |  33.35
>  17   100.0    0.0    0.0    0.0 |    0     0    |  33.95
>  18     0.0    0.0    0.0  100.0 |    3     3    |  31.68
>  19     0.0    5.3    0.0   94.7 |    1     3   *|  42.97
>  20     2.0   98.0    0.0    0.0 |    0     1   *|  43.56
>  21     0.0    0.0    0.0  100.0 |    3     3    |  31.65
>  22   100.0    0.0    0.0    0.0 |    0     0    |  34.13
>  23     0.0  100.0    0.0    0.0 |    1     1    |  32.52
>  24     9.9   90.1    0.0    0.0 |    1     1    |  33.58
>  25     0.0    3.2   96.8    0.0 |    1     2   *|  42.51
>  26    89.8    0.0    0.0   10.2 |    0     0    |  34.18
>  27     0.0  100.0    0.0    0.0 |    1     1    |  32.44
>  28     0.0    2.4   97.6    0.0 |    2     2    |  33.59
>  29     8.4    0.0   91.6    0.0 |    2     2    |  33.78
>  30   100.0    0.0    0.0    0.0 |    0     0    |  33.52
>  31     0.0    6.3   93.7    0.0 |    2     2    |  33.37
>  32     0.0  100.0    0.0    0.0 |    1     1    |  33.20
> AverageUserTime 34.83 seconds
> ElapsedTime     79.92
> TotalUserTime   1114.91
> TotalSysTime    2.30
> 
> -----------------------------------------------------------
> C: simple scheduler MH
> 
> Running 'hackbench 20' in the background: Time: 7.271
> Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
>   1   100.0    0.0    0.0    0.0 |    0     0    |  32.66
>   2   100.0    0.0    0.0    0.0 |    0     0    |  32.53
>   3   100.0    0.0    0.0    0.0 |    0     0    |  32.47
>   4     0.0  100.0    0.0    0.0 |    1     1    |  30.33
>   5     0.0  100.0    0.0    0.0 |    1     1    |  30.20
>   6     0.0  100.0    0.0    0.0 |    1     1    |  30.06
>   7   100.0    0.0    0.0    0.0 |    0     0    |  32.35
>   8   100.0    0.0    0.0    0.0 |    0     0    |  32.58
> AverageUserTime 31.65 seconds
> ElapsedTime     42.53
> TotalUserTime   253.30
> TotalSysTime    0.48
> 
> Running 'hackbench 20' in the background: Time: 2.929
> Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
>   1   100.0    0.0    0.0    0.0 |    0     0    |  31.07
>   2   100.0    0.0    0.0    0.0 |    0     0    |  30.97
>   3   100.0    0.0    0.0    0.0 |    0     0    |  30.86
>   4     0.0  100.0    0.0    0.0 |    1     1    |  31.91
>   5     0.0  100.0    0.0    0.0 |    1     1    |  32.04
>   6     0.0  100.0    0.0    0.0 |    1     1    |  31.98
>   7     0.0  100.0    0.0    0.0 |    1     1    |  32.01
>   8     0.0    0.0  100.0    0.0 |    2     2    |  31.83
>   9     0.0    0.0  100.0    0.0 |    2     2    |  31.66
>  10     0.0    0.0  100.0    0.0 |    2     2    |  31.47
>  11     0.0    0.0  100.0    0.0 |    2     2    |  31.74
>  12     0.0    0.0    0.0  100.0 |    3     3    |  31.54
>  13     0.0    0.0    0.0  100.0 |    3     3    |  31.48
>  14     0.0    0.0    0.0  100.0 |    3     3    |  31.49
>  15     0.0    0.0    0.0  100.0 |    3     3    |  31.97
>  16     5.4    0.0    0.0   94.6 |    0     3   *|  40.86
> AverageUserTime 32.18 seconds
> ElapsedTime     49.66
> TotalUserTime   515.11
> TotalSysTime    0.95
> 
> Running 'hackbench 20' in the background: Time: 2.849
> Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
>   1   100.0    0.0    0.0    0.0 |    0     0    |  33.75
>   2   100.0    0.0    0.0    0.0 |    0     0    |  33.89
>   3   100.0    0.0    0.0    0.0 |    0     0    |  33.87
>   4     0.0  100.0    0.0    0.0 |    1     1    |  33.34
>   5     0.0  100.0    0.0    0.0 |    1     1    |  33.41
>   6     0.0  100.0    0.0    0.0 |    1     1    |  33.16
>   7     0.0  100.0    0.0    0.0 |    1     1    |  33.25
>   8     0.0    0.0  100.0    0.0 |    2     2    |  32.90
>   9     0.0    0.0  100.0    0.0 |    2     2    |  33.08
>  10     0.0    0.0  100.0    0.0 |    2     2    |  33.07
>  11     0.0    0.0  100.0    0.0 |    2     2    |  33.11
>  12     0.0    0.0    0.0  100.0 |    3     3    |  31.46
>  13     0.0    0.0    0.0  100.0 |    3     3    |  32.04
>  14     0.0    0.0    0.0  100.0 |    3     3    |  31.59
>  15     0.0    0.0    0.0  100.0 |    3     3    |  31.83
>  16   100.0    0.0    0.0    0.0 |    0     0    |  33.95
>  17     1.2    0.0    0.0   98.8 |    0     3   *|  44.66
>  18   100.0    0.0    0.0    0.0 |    0     0    |  34.02
>  19    55.4    0.0    0.0   44.6 |    3     0    |  37.11
>  20   100.0    0.0    0.0    0.0 |    0     0    |  33.62
>  21     0.0  100.0    0.0    0.0 |    1     1    |  33.33
>  22     0.0  100.0    0.0    0.0 |    1     1    |  33.26
>  23     0.0  100.0    0.0    0.0 |    1     1    |  33.41
>  24     0.0  100.0    0.0    0.0 |    1     1    |  33.14
>  25     0.0    0.0  100.0    0.0 |    2     2    |  33.26
>  26     0.0    0.0  100.0    0.0 |    2     2    |  33.05
>  27     0.0    0.0    3.1   96.9 |    2     3   *|  43.50
>  28   100.0    0.0    0.0    0.0 |    0     0    |  34.02
>  29    60.4    0.0   39.6    0.0 |    2     0   *|  37.05
>  30     0.0    0.0    0.0  100.0 |    3     3    |  31.53
>  31   100.0    0.0    0.0    0.0 |    0     0    |  33.94
>  32     0.0    0.0  100.0    0.0 |    2     2    |  33.03
> AverageUserTime 34.05 seconds
> ElapsedTime     80.34
> TotalUserTime   1090.10
> TotalSysTime    2.15
> 
> ---------------------------------------------------------------
> D: numasched : pooling only (idle pool delay set to 0)
> 
> Running 'hackbench 20' in the background: Time: 2.066
> Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
>   1     0.0    0.0    0.0  100.0 |    3     3    |  28.50
>   2   100.0    0.0    0.0    0.0 |    0     0    |  30.97
>   3     0.0    0.0    0.0  100.0 |    3     3    |  28.49
>   4     0.0    0.0  100.0    0.0 |    2     2    |  28.65
>   5   100.0    0.0    0.0    0.0 |    0     0    |  31.18
>   6   100.0    0.0    0.0    0.0 |    0     0    |  30.96
>   7     5.7   94.3    0.0    0.0 |    0     1   *|  38.69
>   8     0.0    0.0  100.0    0.0 |    2     2    |  28.65
> AverageUserTime 30.76 seconds
> ElapsedTime     39.72
> TotalUserTime   246.23
> TotalSysTime    0.46
> 
> Running 'hackbench 20' in the background: Time: 5.178
> Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
>   1   100.0    0.0    0.0    0.0 |    0     0    |  32.01
>   2   100.0    0.0    0.0    0.0 |    0     0    |  31.82
>   3     0.0    3.4    0.0   96.6 |    1     3   *|  41.01
>   4   100.0    0.0    0.0    0.0 |    0     0    |  32.24
>   5   100.0    0.0    0.0    0.0 |    0     0    |  31.91
>   6     0.0    0.0  100.0    0.0 |    2     2    |  31.75
>   7     0.0    0.0    0.0  100.0 |    3     3    |  30.55
>   8     0.0    0.0  100.0    0.0 |    2     2    |  31.74
>   9     0.0    0.0  100.0    0.0 |    2     2    |  31.74
>  10     0.0    0.0    0.0  100.0 |    3     3    |  30.63
>  11     0.0    0.0    0.0  100.0 |    3     3    |  30.67
>  12     0.0    0.0  100.0    0.0 |    2     2    |  31.75
>  13     0.0  100.0    0.0    0.0 |    1     1    |  31.94
>  14     0.0  100.0    0.0    0.0 |    1     1    |  32.20
>  15     0.0  100.0    0.0    0.0 |    1     1    |  32.24
>  16     0.0  100.0    0.0    0.0 |    1     1    |  32.07
> AverageUserTime 32.27 seconds
> ElapsedTime     42.97
> TotalUserTime   516.53
> TotalSysTime    1.16
> 
> Running 'hackbench 20' in the background: Time: 4.505
> Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
>   1     0.0   49.4    0.0   50.6 |    3     3    |  36.48
>   2     0.3   99.7    0.0    0.0 |    0     1   *|  39.21
>   3     0.0  100.0    0.0    0.0 |    1     1    |  32.23
>   4   100.0    0.0    0.0    0.0 |    0     0    |  32.88
>   5   100.0    0.0    0.0    0.0 |    0     0    |  32.98
>   6   100.0    0.0    0.0    0.0 |    0     0    |  32.97
>   7     0.0   18.3   81.7    0.0 |    2     2    |  35.13
>   8     0.0    5.7   94.3    0.0 |    2     2    |  34.00
>   9     0.0    0.0  100.0    0.0 |    2     2    |  33.14
>  10     0.0    3.3   96.7    0.0 |    2     2    |  34.22
>  11     0.0  100.0    0.0    0.0 |    1     1    |  32.34
>  12     0.0  100.0    0.0    0.0 |    1     1    |  32.37
>  13     0.0   13.4    0.0   86.6 |    3     3    |  34.55
>  14     0.0    0.0    0.0  100.0 |    3     3    |  33.93
>  15     0.0    0.0    0.0  100.0 |    3     3    |  33.08
>  16   100.0    0.0    0.0    0.0 |    0     0    |  33.31
>  17   100.0    0.0    0.0    0.0 |    0     0    |  33.08
>  18     0.0    8.2    0.0   91.8 |    3     3    |  33.76
>  19     0.0    0.0    0.0  100.0 |    3     3    |  33.23
>  20     0.0   32.7    0.0   67.3 |    3     3    |  34.79
>  21     0.0    0.0    0.0  100.0 |    3     3    |  32.94
>  22   100.0    0.0    0.0    0.0 |    0     0    |  33.23
>  23     0.0  100.0    0.0    0.0 |    1     1    |  32.35
>  24     0.0    0.0  100.0    0.0 |    2     2    |  33.44
>  25     0.0  100.0    0.0    0.0 |    1     1    |  32.42
>  26     0.0    0.0  100.0    0.0 |    2     2    |  33.25
>  27     0.0    0.0  100.0    0.0 |    2     2    |  33.82
>  28     0.0    0.0  100.0    0.0 |    2     2    |  32.88
>  29     0.0    0.0    0.0  100.0 |    3     3    |  31.99
>  30     0.0  100.0    0.0    0.0 |    1     1    |  31.90
>  31   100.0    0.0    0.0    0.0 |    0     0    |  32.93
>  32    99.6    0.0    0.4    0.0 |    2     0   *|  41.48
> AverageUserTime 33.76 seconds
> ElapsedTime     78.35
> TotalUserTime   1080.75
> TotalSysTime    2.03
> 
> -----------------------------------------------------------
> 
> E: node affine scheduler with initial load balancing, statically
> assigned homenode
> 
> Running 'hackbench 20' in the background: Time: 2.330
> Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
>   1     0.0    0.0  100.0    0.0 |    2     2    |  28.86
>   2     0.0  100.0    0.0    0.0 |    1     1    |  28.82
>   3     0.0  100.0    0.0    0.0 |    1     1    |  28.85
>   4     0.0    0.0    0.0  100.0 |    3     3    |  28.47
>   5   100.0    0.0    0.0    0.0 |    0     0    |  28.69
>   6     0.0    0.0  100.0    0.0 |    2     2    |  28.65
>   7     0.0    0.0    0.0  100.0 |    3     3    |  28.49
>   8   100.0    0.0    0.0    0.0 |    0     0    |  28.55
> AverageUserTime 28.67 seconds
> ElapsedTime     30.28
> TotalUserTime   229.51
> TotalSysTime    0.43
> 
> 
> Running 'hackbench 20' in the background: Time: 5.562
> Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
>   1     0.0  100.0    0.0    0.0 |    1     1    |  31.47
>   2     0.0  100.0    0.0    0.0 |    1     1    |  31.38
>   3     0.0    0.0    0.0  100.0 |    3     3    |  31.53
>   4     0.0    0.0    0.0  100.0 |    3     3    |  31.46
>   5   100.0    0.0    0.0    0.0 |    0     0    |  31.64
>   6   100.0    0.0    0.0    0.0 |    0     0    |  31.57
>   7   100.0    0.0    0.0    0.0 |    0     0    |  31.57
>   8     0.0    0.0    0.0  100.0 |    3     3    |  31.51
>   9     0.0    0.0  100.0    0.0 |    2     2    |  31.63
>  10     0.0    0.0  100.0    0.0 |    2     2    |  31.56
>  11     0.0    0.0  100.0    0.0 |    2     2    |  31.42
>  12     0.0  100.0    0.0    0.0 |    1     1    |  31.44
>  13     0.0    0.0    0.0  100.0 |    3     3    |  31.43
>  14     0.0    0.0  100.0    0.0 |    2     2    |  31.61
>  15   100.0    0.0    0.0    0.0 |    0     0    |  31.34
>  16     0.0  100.0    0.0    0.0 |    1     1    |  31.36
> AverageUserTime 31.50 seconds
> ElapsedTime     36.98
> TotalUserTime   504.17
> TotalSysTime    1.03
> 
> Running 'hackbench 20' in the background: Time: 5.288
> Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
>   1     0.0    0.0   46.1   53.9 |    2     3   *|  37.11
>   2     0.0    0.0    0.0  100.0 |    3     3    |  31.32
>   3     0.0  100.0    0.0    0.0 |    1     1    |  33.15
>   4     0.0    4.9   95.1    0.0 |    2     2    |  33.55
>   5     0.0    0.0  100.0    0.0 |    2     2    |  32.81
>   6     0.0  100.0    0.0    0.0 |    1     1    |  32.88
>   7     0.0  100.0    0.0    0.0 |    1     1    |  33.31
>   8    82.9   17.1    0.0    0.0 |    1     0   *|  40.70
>   9   100.0    0.0    0.0    0.0 |    0     0    |  33.36
>  10     9.3    0.0    0.0   90.7 |    0     3   *|  42.12
>  11   100.0    0.0    0.0    0.0 |    0     0    |  33.38
>  12     0.0    0.0    0.0  100.0 |    3     3    |  31.28
>  13     0.0    0.0    0.0  100.0 |    3     3    |  31.43
>  14     0.0  100.0    0.0    0.0 |    1     1    |  33.33
>  15     0.0  100.0    0.0    0.0 |    1     1    |  33.04
>  16   100.0    0.0    0.0    0.0 |    0     0    |  33.02
>  17    95.2    4.8    0.0    0.0 |    0     0    |  33.82
>  18     3.8    0.0    0.0   96.2 |    0     3   *|  43.21
>  19     0.0    0.0    0.0  100.0 |    3     3    |  31.11
>  20     0.0    0.0  100.0    0.0 |    2     2    |  32.19
>  21     0.0  100.0    0.0    0.0 |    1     1    |  33.43
>  22     0.0    0.0  100.0    0.0 |    2     2    |  33.03
>  23     0.0    0.0  100.0    0.0 |    2     2    |  33.06
>  24   100.0    0.0    0.0    0.0 |    0     0    |  33.04
>  25   100.0    0.0    0.0    0.0 |    0     0    |  33.07
>  26     0.0    0.0  100.0    0.0 |    2     2    |  33.07
>  27     0.0    0.0  100.0    0.0 |    2     2    |  33.22
>  28     0.0    0.0    0.0  100.0 |    3     3    |  31.06
>  29     0.0   15.3   84.7    0.0 |    2     2    |  33.25
>  30     0.0  100.0    0.0    0.0 |    1     1    |  33.36
>  31    85.0    0.0    0.0   15.0 |    0     0    |  34.50
>  32     0.0   86.4    0.0   13.6 |    1     1    |  34.27
> AverageUserTime 33.89 seconds
> ElapsedTime     76.84
> TotalUserTime   1084.86
> TotalSysTime    2.12
> 
> --------------------------------------------------------
> 
> F: node affine scheduler, dynamically assigned homenode, no
> initial load balancing
> 
> Running 'hackbench 20' in the background: Time: 1.861
> Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
>   1     0.0    0.0    0.0  100.0 |    3     3    |  30.75
>   2   100.0    0.0    0.0    0.0 |    0     0    |  27.12
>   3     0.0    0.0    0.0  100.0 |    3     3    |  30.60
>   4     0.0    0.0    0.0  100.0 |    3     3    |  30.65
>   5     0.0  100.0    0.0    0.0 |    1     1    |  28.65
>   6     0.0    0.0   78.4   21.6 |    3     2   *|  36.63
>   7     0.0  100.0    0.0    0.0 |    1     1    |  28.57
>   8     0.0    0.0  100.0    0.0 |    2     2    |  27.65
> AverageUserTime 30.08 seconds
> ElapsedTime     38.28
> TotalUserTime   240.75
> TotalSysTime    0.49
> 
> Running 'hackbench 20' in the background: Time: 5.936
> Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
>   1     0.0    0.0    0.0  100.0 |    3     3    |  31.47
>   2   100.0    0.0    0.0    0.0 |    0     0    |  29.90
>   3    88.2    0.0    4.6    7.2 |    2     0   *|  40.96
>   4     0.0    0.0    0.0  100.0 |    3     3    |  31.53
>   5     0.0    0.0    0.0  100.0 |    3     3    |  31.50
>   6     0.0  100.0    0.0    0.0 |    1     1    |  32.25
>   7     0.0   84.5    0.0   15.5 |    1     1    |  33.41
>   8     0.0    0.0  100.0    0.0 |    2     2    |  32.38
>   9    83.0   17.0    0.0    0.0 |    1     0   *|  39.29
>  10     0.0    0.0    0.0  100.0 |    3     3    |  31.51
>  11     0.0  100.0    0.0    0.0 |    1     1    |  32.38
>  12     0.0    0.0  100.0    0.0 |    2     2    |  32.30
>  13     0.0  100.0    0.0    0.0 |    1     1    |  32.06
>  14   100.0    0.0    0.0    0.0 |    0     0    |  29.85
>  15     0.0    0.0  100.0    0.0 |    2     2    |  32.18
>  16     0.0    0.0  100.0    0.0 |    2     2    |  32.39
> AverageUserTime 32.83 seconds
> ElapsedTime     42.51
> TotalUserTime   525.59
> TotalSysTime    1.14
> 
> Running 'hackbench 20' in the background: Time: 4.277
> Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
>   1     0.0    0.0    0.0  100.0 |    3     3    |  31.69
>   2     0.0    0.0  100.0    0.0 |    2     2    |  33.81
>   3   100.0    0.0    0.0    0.0 |    0     0    |  33.10
>   4     1.4    4.9    2.8   90.9 |    2     3   *|  44.26
>   5     0.0    0.0    0.0  100.0 |    3     3    |  31.76
>   6     0.0    0.0    0.0  100.0 |    3     3    |  31.69
>   7     0.0    0.0    3.6   96.4 |    2     3   *|  43.73
>   8     0.0  100.0    0.0    0.0 |    1     1    |  33.07
>   9     0.0    0.0  100.0    0.0 |    2     2    |  34.04
>  10     0.0  100.0    0.0    0.0 |    1     1    |  33.24
>  11     0.0  100.0    0.0    0.0 |    1     1    |  33.23
>  12   100.0    0.0    0.0    0.0 |    0     0    |  33.77
>  13     0.0  100.0    0.0    0.0 |    1     1    |  33.10
>  14   100.0    0.0    0.0    0.0 |    0     0    |  33.26
>  15     0.0  100.0    0.0    0.0 |    1     1    |  33.16
>  16   100.0    0.0    0.0    0.0 |    0     0    |  33.23
>  17     3.9    0.0    0.0   96.1 |    0     3   *|  42.74
>  18     0.0  100.0    0.0    0.0 |    1     1    |  32.97
>  19   100.0    0.0    0.0    0.0 |    0     0    |  33.21
>  20     0.0    0.0   92.1    7.9 |    2     2    |  34.30
>  21     0.0    0.0   95.9    4.1 |    2     2    |  34.31
>  22     0.0    0.0  100.0    0.0 |    2     2    |  33.88
>  23     0.0    0.0    0.0  100.0 |    3     3    |  30.85
>  24     0.0  100.0    0.0    0.0 |    1     1    |  32.99
>  25     0.0    0.0  100.0    0.0 |    2     2    |  33.84
>  26     0.0  100.0    0.0    0.0 |    1     1    |  33.35
>  27   100.0    0.0    0.0    0.0 |    0     0    |  33.29
>  28     0.0    0.0  100.0    0.0 |    2     2    |  33.79
>  29   100.0    0.0    0.0    0.0 |    0     0    |  33.25
>  30   100.0    0.0    0.0    0.0 |    0     0    |  33.41
>  31     0.0    0.0  100.0    0.0 |    2     2    |  33.92
>  32     0.0    0.0    0.0  100.0 |    3     3    |  31.16
> AverageUserTime 34.11 seconds
> ElapsedTime     77.38
> TotalUserTime   1091.86
> TotalSysTime    2.14
> 
-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

