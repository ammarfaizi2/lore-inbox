Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267485AbTAQOZ7>; Fri, 17 Jan 2003 09:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267516AbTAQOZ6>; Fri, 17 Jan 2003 09:25:58 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:11956 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S267485AbTAQOZ4> convert rfc822-to-8bit; Fri, 17 Jan 2003 09:25:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: Ingo Molnar <mingo@elte.hu>, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [patch] sched-2.5.59-A2
Date: Fri, 17 Jan 2003 15:35:21 +0100
User-Agent: KMail/1.4.3
Cc: Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
References: <Pine.LNX.4.44.0301170921430.3723-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0301170921430.3723-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301171535.21226.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

I tried your patch on the small NEC TX7 I can access easilly (8
Itanium2 CPUs on 4 nodes). I actually used your patch on top of the
2.5.52-ia64 kernel, but that shouldn't matter.

I like the cleanup of the topology.h. Also the renaming to
prev_cpu_load. There was a mistake (I think) in the call to
load_balance() in the idle path, guess you wanted to have:
+           load_balance(this_rq, 1, __node_to_cpu_mask(this_node));
instead of
+           load_balance(this_rq, 1, this_cpumask);
otherwise you won't load balance at all for idle cpus.

Here are the results:

kernbench (average of 5 kernel compiles) (standard error in brackets)
---------
           Elapsed       UserTime      SysTime
orig       134.43(1.79)  944.79(0.43)  21.41(0.28)
ingo       136.74(1.58)  951.55(0.73)  21.16(0.32)
ingofix    135.22(0.59)  952.17(0.78)  21.16(0.19)


hackbench (chat benchmark alike) (elapsed time for N groups of 20
---------           senders & receivers, stats from 10 measurements)

          N=10        N=25        N=50        N=100
orig      0.77(0.03)  1.91(0.06)  3.77(0.06)  7.78(0.21)
ingo      1.70(0.35)  3.11(0.47)  4.85(0.55)  8.80(0.98)
ingofix   1.16(0.14)  2.67(0.53)  5.05(0.26)  9.99(0.13)


numabench (N memory intensive tasks running in parallel, disturbed for
---------  a short time by a "hackbench 10" call)


numa_test N=4   ElapsedTime  TotalUserTime  TotalSysTime
orig:           26.13(2.54)  86.10(4.47)    0.09(0.01)
ingo:           27.60(2.16)  88.06(4.58)    0.11(0.01)
ingofix:        25.51(3.05)  83.55(2.78)    0.10(0.01)

numa_test N=8   ElapsedTime  TotalUserTime  TotalSysTime
orig:           24.81(2.71)  164.94(4.82)   0.17(0.01)
ingo:           27.38(3.01)  170.06(5.60)   0.30(0.03)
ingofix:        29.08(2.79)  172.10(4.48)   0.32(0.03)

numa_test N=16  ElapsedTime  TotalUserTime  TotalSysTime
orig:           45.19(3.42)  332.07(5.89)   0.32(0.01)
ingo:           50.18(0.38)  359.46(9.31)   0.46(0.04)
ingofix:        50.30(0.42)  357.38(9.12)   0.46(0.01)

numa_test N=32  ElapsedTime  TotalUserTime  TotalSysTime
orig:           86.84(1.83)  671.99(9.98)   0.65(0.02)
ingo:           93.44(2.13)  704.90(16.91)  0.82(0.06)
ingofix:        93.92(1.28)  727.58(9.26)   0.77(0.03)


>From these results I would prefer to either leave the numa scheduler
as it is or to introduce an IDLE_NODEBALANCE_TICK and a
BUSY_NODEBALANCE_TICK instead of just having one NODE_REBALANCE_TICK
which balances very rarely. In that case it would make sense to keep
the cpus_to_balance() function.

Best regards,
Erich


On Friday 17 January 2003 09:47, Ingo Molnar wrote:
> Martin, Erich,
>
> could you give the attached patch a go, it implements my
> cleanup/reorganization suggestions ontop of 2.5.59:
>
>  - decouple the 'slow' rebalancer from the 'fast' rebalancer and attach it
>    to the scheduler tick. Remove rq->nr_balanced.
>
>  - do idle-rebalancing every 1 msec, intra-node rebalancing every 200
>    msecs and inter-node rebalancing every 400 msecs.
>
>  - move the tick-based rebalancing logic into rebalance_tick(), it looks
>    more organized this way and we have all related code in one spot.
>
>  - clean up the topology.h include file structure. Since generic kernel
>    code uses all the defines already, there's no reason to keep them in
>    asm-generic.h. I've created a linux/topology.h file that includes
>    asm/topology.h and takes care of the default and generic definitions.
>    Moved over a generic topology definition from mmzone.h.
>
>  - renamed rq->prev_nr_running[] to rq->prev_cpu_load[] - this further
>    unifies the SMP and NUMA balancers and is more in line with the
>    prev_node_load name.
>
> If performance drops due to this patch then the benchmarking goal would be
> to tune the following frequencies:
>
>  #define IDLE_REBALANCE_TICK (HZ/1000 ?: 1)
>  #define BUSY_REBALANCE_TICK (HZ/5 ?: 1)
>  #define NODE_REBALANCE_TICK (BUSY_REBALANCE_TICK * 2)
>
> In theory NODE_REBALANCE_TICK could be defined by the NUMA platform,
> although in the past such per-platform scheduler tunings used to end
> 'orphaned' after some time. 400 msecs is pretty conservative at the
> moment, it could be made more frequent if benchmark results support it.
>
> the patch compiles and boots on UP and SMP, it compiles on x86-NUMA.
>
> 	Ingo

