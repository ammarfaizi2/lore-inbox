Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265423AbTAJQ0G>; Fri, 10 Jan 2003 11:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265409AbTAJQ0E>; Fri, 10 Jan 2003 11:26:04 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:13984 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S265402AbTAJQZu> convert rfc822-to-8bit; Fri, 10 Jan 2003 11:25:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: Michael Hohnbaum <hohnbaum@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [Lse-tech] Minature NUMA scheduler
Date: Fri, 10 Jan 2003 17:34:56 +0100
User-Agent: KMail/1.4.3
Cc: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
References: <52570000.1042156448@flay> <1042176966.30434.148.camel@kenai>
In-Reply-To: <1042176966.30434.148.camel@kenai>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301101734.56182.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin & Michael,

indeed, restricting a process to the node on which it was started
helps, as the memory will always be local. The NUMA scheduler allows a
process to move away from it's node, if the load conditions require
it, but in the current form the process will not come back to its
homenode. That's what the "node affine scheduler" tried to realise.

The miniature NUMA scheduler relies on the quality of the initial load
balancer, and that one seems to be good enough. As you mentioned,
multithreaded jobs are disadvantaged as their threads have to stick on
the originating node.

Having some sort of automatic node affinity of processes and equal
node loads in mind (as design targets), we could:
 - take the minimal NUMA scheduler
 - if the normal (node-restricted) find_busiest_queue() fails and
 certain conditions are fulfilled (tried to balance inside own node
 for a while and didn't succeed, own CPU idle, etc... ???) rebalance
 over node boundaries (eg. using my load balancer)
This actually resembles the original design of the node affine
scheduler, having the cross-node balancing separate is ok and might
make the ideas clearer.

I made some measurements, too, and found basically what I
expected. The numbers are from a machine with 4 nodes of 2 CPUs
each. It's on ia64, so 2.5.52 based.

As the minsched cannot make mistakes (by moving tasks away from their
homenode), it leads to the best results with numa_test. OTOH hackbench
suffers a lot from the limitation to one node. The hackbench tasks are
not latency/bandwidth limited, the faster they spread over the whole
machine, the quicker finishes the job. That's why NUMA-sched is
slightly worse than a stock kernel. But minsched looses >50%. Funilly,
on my machine kernbench is slightly faster with the normal NUMA
scheduler.

Regards,
Erich

Results on a 8 CPU machine with 4 nodes (2 CPUs per node).

kernbench:
                elapsed       user          system
      stock52   134.52(0.84)  951.64(0.97)  20.72(0.22)
      sched52   133.19(1.49)  944.24(0.50)  21.36(0.24)
   minsched52   135.47(0.47)  937.61(0.20)  21.30(0.14)

schedbench/hackbench: time(s)
               10         25         50         100
      stock52  0.81(0.04) 2.06(0.07) 4.09(0.13) 7.89(0.25)
      sched52  0.81(0.04) 2.03(0.07) 4.14(0.20) 8.61(0.35)
   minsched52  1.28(0.05) 3.19(0.06) 6.59(0.13) 13.56(0.27)

numabench/numa_test 4
               AvgUserTime ElapsedTime TotUserTime TotSysTime
      stock52  ---         27.23(0.52) 89.30(4.18) 0.09(0.01)
      sched52  22.32(1.00) 27.39(0.42) 89.29(4.02) 0.10(0.01)
   minsched52  20.01(0.01) 23.40(0.13) 80.05(0.02) 0.08(0.01)

numabench/numa_test 8
               AvgUserTime ElapsedTime TotUserTime  TotSysTime
      stock52  ---         27.50(2.58) 174.74(6.66) 0.18(0.01)
      sched52  21.73(1.00) 33.70(1.82) 173.87(7.96) 0.18(0.01)
   minsched52  20.31(0.00) 23.50(0.12) 162.47(0.04) 0.16(0.01)

numabench/numa_test 16
               AvgUserTime ElapsedTime TotUserTime   TotSysTime
      stock52  ---         52.68(1.51) 390.03(15.10) 0.34(0.01)
      sched52  21.51(0.80) 47.18(3.24) 344.29(12.78) 0.36(0.01)
   minsched52  20.50(0.03) 43.82(0.08) 328.05(0.45)  0.34(0.01)

numabench/numa_test 32
               AvgUserTime ElapsedTime  TotUserTime   TotSysTime
      stock52  ---         102.60(3.89) 794.57(31.72) 0.65(0.01)
      sched52  21.93(0.57) 92.46(1.10)  701.75(18.38) 0.67(0.02)
   minsched52  20.64(0.10) 89.95(3.16)  660.72(3.13)  0.68(0.07)



On Friday 10 January 2003 06:36, Michael Hohnbaum wrote:
> On Thu, 2003-01-09 at 15:54, Martin J. Bligh wrote:
> > I tried a small experiment today - did a simple restriction of
> > the O(1) scheduler to only balance inside a node. Coupled with
> > the small initial load balancing patch floating around, this
> > covers 95% of cases, is a trivial change (3 lines), performs
> > just as well as Erich's patch on a kernel compile, and actually
> > better on schedbench.
> >
> > This is NOT meant to be a replacement for the code Erich wrote,
> > it's meant to be a simple way to get integration and acceptance.
> > Code that just forks and never execs will stay on one node - but
> > we can take the code Erich wrote, and put it in seperate rebalancer
> > that fires much less often to do a cross-node rebalance.
>
> I tried this on my 4 node NUMAQ (16 procs, 16GB memory) and got
> similar results.  Also, added in the cputime_stats patch and am
> attaching the matrix results from the 32 process run.  Basically,
> all runs show that the initial load balancer is able to place the
> tasks evenly across the nodes, and the better overall times show
> that not migrating to keep the nodes balanced over time results
> in better performance - at least on these boxes.
>
> Obviously, there can be situations where load balancing across
> nodes is necessary, but these results point to less load balancing
> being better, at least on these machines.  It will be interesting
> to repeat this on boxes with other interconnects.
>
> $ reportbench hacksched54 sched54 stock54
> Kernbench:
>                         Elapsed       User     System        CPU
>          hacksched54    29.406s    282.18s    81.716s    1236.8%
>              sched54    29.112s   283.888s     82.84s    1259.4%
>              stock54    31.348s   303.134s    87.824s    1247.2%
>
> Schedbench 4:
>                         AvgUser    Elapsed  TotalUser   TotalSys
>          hacksched54      21.94      31.93      87.81       0.53
>              sched54      22.03      34.90      88.15       0.75
>              stock54      49.35      57.53     197.45       0.86
>
> Schedbench 8:
>                         AvgUser    Elapsed  TotalUser   TotalSys
>          hacksched54      28.23      31.62     225.87       1.11
>              sched54      27.95      37.12     223.66       1.50
>              stock54      43.14      62.97     345.18       2.12
>
> Schedbench 16:
>                         AvgUser    Elapsed  TotalUser   TotalSys
>          hacksched54      49.29      71.31     788.83       2.88
>              sched54      55.37      69.58     886.10       3.79
>              stock54      66.00      81.25    1056.25       7.12
>
> Schedbench 32:
>                         AvgUser    Elapsed  TotalUser   TotalSys
>          hacksched54      56.41     117.98    1805.35       5.90
>              sched54      57.93     132.11    1854.01      10.74
>              stock54      77.81     173.26    2490.31      12.37
>
> Schedbench 64:
>                         AvgUser    Elapsed  TotalUser   TotalSys
>          hacksched54      56.62     231.93    3624.42      13.32
>              sched54      72.91     308.87    4667.03      21.06
>              stock54      86.68     368.55    5548.57      25.73
>
> hacksched54 = 2.5.54 + Martin's tiny NUMA patch +
>               03-cputimes_stat-2.5.53.patch +
>               02-numa-sched-ilb-2.5.53-21.patch
> sched54 = 2.5.54 + 01-numa-sched-core-2.5.53-24.patch +
>           02-ilb-2.5.53-21.patch02 +
>           03-cputimes_stat-2.5.53.patch
> stock54 - 2.5.54 + 03-cputimes_stat-2.5.53.patch

