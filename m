Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262813AbTAJF2V>; Fri, 10 Jan 2003 00:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbTAJF2V>; Fri, 10 Jan 2003 00:28:21 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:46225 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262813AbTAJF2T>; Fri, 10 Jan 2003 00:28:19 -0500
Subject: Re: [Lse-tech] Minature NUMA scheduler
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Erich Focht <efocht@ess.nec.de>, Robert Love <rml@tech9.net>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <52570000.1042156448@flay>
References: <52570000.1042156448@flay>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Jan 2003 21:36:03 -0800
Message-Id: <1042176966.30434.148.camel@kenai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-09 at 15:54, Martin J. Bligh wrote:
> I tried a small experiment today - did a simple restriction of
> the O(1) scheduler to only balance inside a node. Coupled with
> the small initial load balancing patch floating around, this
> covers 95% of cases, is a trivial change (3 lines), performs 
> just as well as Erich's patch on a kernel compile, and actually
> better on schedbench.
> 
> This is NOT meant to be a replacement for the code Erich wrote,
> it's meant to be a simple way to get integration and acceptance.
> Code that just forks and never execs will stay on one node - but
> we can take the code Erich wrote, and put it in seperate rebalancer
> that fires much less often to do a cross-node rebalance. 

I tried this on my 4 node NUMAQ (16 procs, 16GB memory) and got
similar results.  Also, added in the cputime_stats patch and am 
attaching the matrix results from the 32 process run.  Basically,
all runs show that the initial load balancer is able to place the
tasks evenly across the nodes, and the better overall times show
that not migrating to keep the nodes balanced over time results
in better performance - at least on these boxes.

Obviously, there can be situations where load balancing across
nodes is necessary, but these results point to less load balancing
being better, at least on these machines.  It will be interesting
to repeat this on boxes with other interconnects.

$ reportbench hacksched54 sched54 stock54
Kernbench:
                        Elapsed       User     System        CPU
         hacksched54    29.406s    282.18s    81.716s    1236.8%
             sched54    29.112s   283.888s     82.84s    1259.4%
             stock54    31.348s   303.134s    87.824s    1247.2%

Schedbench 4:
                        AvgUser    Elapsed  TotalUser   TotalSys
         hacksched54      21.94      31.93      87.81       0.53
             sched54      22.03      34.90      88.15       0.75
             stock54      49.35      57.53     197.45       0.86

Schedbench 8:
                        AvgUser    Elapsed  TotalUser   TotalSys
         hacksched54      28.23      31.62     225.87       1.11
             sched54      27.95      37.12     223.66       1.50
             stock54      43.14      62.97     345.18       2.12

Schedbench 16:
                        AvgUser    Elapsed  TotalUser   TotalSys
         hacksched54      49.29      71.31     788.83       2.88
             sched54      55.37      69.58     886.10       3.79
             stock54      66.00      81.25    1056.25       7.12

Schedbench 32:
                        AvgUser    Elapsed  TotalUser   TotalSys
         hacksched54      56.41     117.98    1805.35       5.90
             sched54      57.93     132.11    1854.01      10.74
             stock54      77.81     173.26    2490.31      12.37

Schedbench 64:
                        AvgUser    Elapsed  TotalUser   TotalSys
         hacksched54      56.62     231.93    3624.42      13.32
             sched54      72.91     308.87    4667.03      21.06
             stock54      86.68     368.55    5548.57      25.73

hacksched54 = 2.5.54 + Martin's tiny NUMA patch +          
              03-cputimes_stat-2.5.53.patch +
              02-numa-sched-ilb-2.5.53-21.patch
sched54 = 2.5.54 + 01-numa-sched-core-2.5.53-24.patch + 
          02-ilb-2.5.53-21.patch02 +
          03-cputimes_stat-2.5.53.patch
stock54 - 2.5.54 + 03-cputimes_stat-2.5.53.patch

Detailed results from running numa_test 32:

Executing 32 times: ./randupdt 1000000 
Running 'hackbench 20' in the background: Time: 4.557
Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
  1   100.0    0.0    0.0    0.0 |    0     0    |  57.12
  2     0.0  100.0    0.0    0.0 |    1     1    |  55.89
  3   100.0    0.0    0.0    0.0 |    0     0    |  55.39
  4     0.0    0.0  100.0    0.0 |    2     2    |  56.67
  5     0.0    0.0    0.0  100.0 |    3     3    |  57.08
  6     0.0  100.0    0.0    0.0 |    1     1    |  56.31
  7   100.0    0.0    0.0    0.0 |    0     0    |  57.11
  8     0.0    0.0    0.0  100.0 |    3     3    |  56.66
  9     0.0  100.0    0.0    0.0 |    1     1    |  55.87
 10     0.0    0.0  100.0    0.0 |    2     2    |  55.83
 11     0.0    0.0    0.0  100.0 |    3     3    |  56.01
 12     0.0  100.0    0.0    0.0 |    1     1    |  56.56
 13     0.0    0.0  100.0    0.0 |    2     2    |  56.31
 14     0.0    0.0    0.0  100.0 |    3     3    |  56.40
 15   100.0    0.0    0.0    0.0 |    0     0    |  55.82
 16     0.0  100.0    0.0    0.0 |    1     1    |  57.47
 17     0.0    0.0  100.0    0.0 |    2     2    |  56.76
 18     0.0    0.0    0.0  100.0 |    3     3    |  57.10
 19     0.0  100.0    0.0    0.0 |    1     1    |  57.26
 20     0.0    0.0  100.0    0.0 |    2     2    |  56.48
 21     0.0    0.0    0.0  100.0 |    3     3    |  56.65
 22     0.0  100.0    0.0    0.0 |    1     1    |  55.81
 23     0.0    0.0  100.0    0.0 |    2     2    |  55.77
 24     0.0    0.0    0.0  100.0 |    3     3    |  56.91
 25     0.0  100.0    0.0    0.0 |    1     1    |  56.86
 26     0.0    0.0  100.0    0.0 |    2     2    |  56.62
 27     0.0    0.0    0.0  100.0 |    3     3    |  57.16
 28     0.0    0.0  100.0    0.0 |    2     2    |  56.36
 29   100.0    0.0    0.0    0.0 |    0     0    |  55.72
 30   100.0    0.0    0.0    0.0 |    0     0    |  56.00
 31   100.0    0.0    0.0    0.0 |    0     0    |  55.48
 32   100.0    0.0    0.0    0.0 |    0     0    |  55.59
AverageUserTime 56.41 seconds
ElapsedTime     117.98
TotalUserTime   1805.35
TotalSysTime    5.90

Runs with 4, 8, 16, and 64 processes all showed the same even
distribution across all nodes and 100% time on node for each
process.
-- 
Michael Hohnbaum            503-578-5486
hohnbaum@us.ibm.com         T/L 775-5486

