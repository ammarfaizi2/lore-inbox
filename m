Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265305AbTANXz0>; Tue, 14 Jan 2003 18:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265351AbTANXz0>; Tue, 14 Jan 2003 18:55:26 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:62118 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265305AbTANXzX>;
	Tue, 14 Jan 2003 18:55:23 -0500
Subject: Re: [PATCH 2.5.58] new NUMA scheduler: fix
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Erich Focht <efocht@ess.nec.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <200301141723.29613.efocht@ess.nec.de>
References: <52570000.1042156448@flay>
	<200301141214.12323.efocht@ess.nec.de>
	<200301141655.06660.efocht@ess.nec.de> 
	<200301141723.29613.efocht@ess.nec.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Jan 2003 16:05:32 -0800
Message-Id: <1042589135.27149.216.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 January 2003 16:55, Erich Focht wrote:
> Here's the new version of the NUMA scheduler built on top of the
> miniature scheduler of Martin. I incorporated Michael's ideas and
> Christoph's suggestions and rediffed for 2.5.58.
>
> The whole patch is really tiny: 9.5k. This time I attached the numa
> scheduler in form of two patches:

Ran tests on three different kernels:

stock58 - linux 2.5.58 with the cputime_stats patch
sched1-4-58 - stock58 with the first 4 NUMA scheduler patches
sched1-5-58 - stock58 with all 5 NUMA scheduler patches

Kernbench:
                        Elapsed       User     System        CPU
             stock58    31.656s    305.85s    89.232s    1248.2%
         sched1-4-58    29.886s   287.506s     82.94s      1239%
         sched1-5-58    29.994s   288.796s    84.706s      1245%

Schedbench 4:
                        AvgUser    Elapsed  TotalUser   TotalSys
             stock58      27.73      42.80     110.96       0.85
         sched1-4-58      32.86      46.41     131.47       0.85
         sched1-5-58      32.37      45.34     129.52       0.89

Schedbench 8:
                        AvgUser    Elapsed  TotalUser   TotalSys
             stock58      45.97      61.87     367.81       2.11
         sched1-4-58      31.39      49.18     251.22       2.15
         sched1-5-58      37.52      61.32     300.22       2.06

Schedbench 16:
                        AvgUser    Elapsed  TotalUser   TotalSys
             stock58      60.91      83.63     974.71       6.18
         sched1-4-58      54.31      62.11     869.11       3.84
         sched1-5-58      51.60      59.05     825.72       4.74

Schedbench 32:
                        AvgUser    Elapsed  TotalUser   TotalSys
             stock58      84.26     195.16    2696.65      16.53
         sched1-4-58      61.49     140.51    1968.06       9.57
         sched1-5-58      55.23     117.32    1767.71       7.78

Schedbench 64:
                        AvgUser    Elapsed  TotalUser   TotalSys
             stock58     123.27     511.77    7889.77      27.78
         sched1-4-58      63.39     266.40    4057.92      20.55
         sched1-5-58      59.57     250.25    3813.39      17.05

One anomaly noted was that the kernbench system time went up
about 5% with the 2.5.58 kernel from what it was on the last
version I tested with (2.5.55).  This increase is in both stock
and with the NUMA scheduler, so is not caused by the NUMA scheduler.

Now that I've got baselines for these, I plan to next look at
tweaking various parameters within the scheduler and see how what
happens.  Also, I owe Erich numbers running hackbench.  Overall, I am
pleased with these results.

And just for grins, here are the detailed results for running 
numa_test 32

sched1-4-58:

Executing 32 times: ./randupdt 1000000 
Running 'hackbench 20' in the background: Time: 9.044
Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
  1     0.0  100.0    0.0    0.0 |    1     1    |  55.04
  2     0.0    0.0    4.8   95.2 |    2     3   *|  70.38
  3     0.0    0.0    3.2   96.8 |    2     3   *|  72.72
  4     0.0   26.4    2.8   70.7 |    2     3   *|  72.99
  5   100.0    0.0    0.0    0.0 |    0     0    |  57.03
  6   100.0    0.0    0.0    0.0 |    0     0    |  55.06
  7   100.0    0.0    0.0    0.0 |    0     0    |  57.18
  8     0.0  100.0    0.0    0.0 |    1     1    |  55.38
  9   100.0    0.0    0.0    0.0 |    0     0    |  54.37
 10     0.0  100.0    0.0    0.0 |    1     1    |  56.06
 11     0.0   13.2    0.0   86.8 |    3     3    |  64.33
 12     0.0    0.0    0.0  100.0 |    3     3    |  62.35
 13     1.7    0.0   98.3    0.0 |    2     2    |  67.47
 14   100.0    0.0    0.0    0.0 |    0     0    |  55.94
 15     0.0   29.4   61.9    8.6 |    3     2   *|  78.76
 16     0.0  100.0    0.0    0.0 |    1     1    |  56.42
 17    18.9    0.0   74.9    6.2 |    3     2   *|  70.57
 18     0.0    0.0  100.0    0.0 |    2     2    |  63.01
 19     0.0  100.0    0.0    0.0 |    1     1    |  55.97
 20     0.0    0.0   92.7    7.3 |    3     2   *|  65.62
 21     0.0    0.0  100.0    0.0 |    2     2    |  62.70
 22     0.0  100.0    0.0    0.0 |    1     1    |  55.53
 23     0.0    1.5    0.0   98.5 |    3     3    |  56.95
 24     0.0  100.0    0.0    0.0 |    1     1    |  55.75
 25     0.0   30.0    2.3   67.7 |    2     3   *|  77.78
 26     0.0    0.0    0.0  100.0 |    3     3    |  57.71
 27    13.6    0.0   86.4    0.0 |    0     2   *|  66.55
 28   100.0    0.0    0.0    0.0 |    0     0    |  55.43
 29     0.0  100.0    0.0    0.0 |    1     1    |  56.12
 30    19.8    0.0   62.5   17.6 |    3     2   *|  66.92
 31   100.0    0.0    0.0    0.0 |    0     0    |  54.90
 32   100.0    0.0    0.0    0.0 |    0     0    |  54.70
AverageUserTime 61.49 seconds
ElapsedTime     140.51
TotalUserTime   1968.06
TotalSysTime    9.57

sched1-5-58:

Executing 32 times: ./randupdt 1000000 
Running 'hackbench 20' in the background: Time: 9.145
Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
  1   100.0    0.0    0.0    0.0 |    0     0    |  54.88
  2     0.0  100.0    0.0    0.0 |    1     1    |  54.08
  3     0.0    0.0    0.0  100.0 |    3     3    |  55.48
  4     0.0    0.0    0.0  100.0 |    3     3    |  55.47
  5   100.0    0.0    0.0    0.0 |    0     0    |  53.84
  6   100.0    0.0    0.0    0.0 |    0     0    |  53.37
  7     0.0    0.0    0.0  100.0 |    3     3    |  55.41
  8    90.9    9.1    0.0    0.0 |    1     0   *|  55.58
  9     0.0  100.0    0.0    0.0 |    1     1    |  55.61
 10     0.0  100.0    0.0    0.0 |    1     1    |  54.56
 11     0.0    0.0   98.1    1.9 |    2     2    |  56.25
 12     0.0    0.0    0.0  100.0 |    3     3    |  55.07
 13     0.0    0.0    0.0  100.0 |    3     3    |  54.92
 14     0.0  100.0    0.0    0.0 |    1     1    |  54.59
 15   100.0    0.0    0.0    0.0 |    0     0    |  55.10
 16     5.0    0.0   95.0    0.0 |    2     2    |  56.97
 17     0.0    0.0  100.0    0.0 |    2     2    |  55.51
 18   100.0    0.0    0.0    0.0 |    0     0    |  53.97
 19     0.0    4.7   95.3    0.0 |    2     2    |  57.21
 20     0.0    0.0  100.0    0.0 |    2     2    |  55.53
 21     0.0    0.0  100.0    0.0 |    2     2    |  56.46
 22     0.0    0.0  100.0    0.0 |    2     2    |  55.48
 23     0.0    0.0    0.0  100.0 |    3     3    |  55.99
 24     0.0  100.0    0.0    0.0 |    1     1    |  55.32
 25     0.0    6.2   93.8    0.0 |    2     2    |  57.66
 26     0.0    0.0    0.0  100.0 |    3     3    |  55.60
 27     0.0  100.0    0.0    0.0 |    1     1    |  54.65
 28     0.0    0.0    0.0  100.0 |    3     3    |  56.39
 29     0.0  100.0    0.0    0.0 |    1     1    |  54.91
 30   100.0    0.0    0.0    0.0 |    0     0    |  53.58
 31   100.0    0.0    0.0    0.0 |    0     0    |  53.53
 32    31.5   68.4    0.0    0.0 |    0     1   *|  54.41
AverageUserTime 55.23 seconds
ElapsedTime     117.32
TotalUserTime   1767.71
TotalSysTime    7.78

-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

