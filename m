Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262040AbSJOABe>; Mon, 14 Oct 2002 20:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262154AbSJOABe>; Mon, 14 Oct 2002 20:01:34 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:10397 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262040AbSJOABb>;
	Mon, 14 Oct 2002 20:01:31 -0400
Subject: Re: NUMA schedulers tests
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Erich Focht <efocht@ess.nec.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       "Luck, Tony" <tony.luck@intel.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200210131317.35544.efocht@ess.nec.de>
References: <200210131317.35544.efocht@ess.nec.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 14 Oct 2002 17:01:38 -0700
Message-Id: <1034640106.1280.680.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erich,

Thanks for the numbers.  These are quite interesting.  Your 
scheduler which goes through much effort to spread the load
evenly across all of the nodes appears to do much better on 
small loads, but as the system becomes loaded, the difference
gets smaller.  Still, your best combination is the clear winner
on the numa_test.  But on kernbench, that changes and all the
runs look quite close.

While numa_test is interesting and might be quite relevant to
the HPC loads that you focus on, I'm not sure it should be the
defining test for NUMA scheduler performance.  The main problem
is that we have differing workloads that we care about.  

I would be happy to see you NUMA scheduler get accepted into
mainline, as I think there are enough knobs that it can be
tuned for varying workloads.  It will just require some time
and testing to establish these.

On the other hand, my NUMA scheduler is a definite improvement
for NUMA boxes, so if your scheduler cannot be included in
mainline, getting mine in would be of benefit.  

Ingo, do you have any thoughts on this you would be willing to
pass along?

                Michael



On Sun, 2002-10-13 at 04:17, Erich Focht wrote:
> Hi,
> 
> here is a set of measurements for three benchmarks and five schedulers.
> They were performed on an NEC Azusa, 16 CPU Itanium machine with NUMA
> architecture, 4 CPUs per node, 4 nodes with 8GB memory each.
> 
> The benchmarks are:
> - hackbench: a variant of the wellknown chatroom benchmark
> - numa_test: runs a certain number of memory bandwidth hungry and latency
>   dependent processes in parallel
> - kernbench: parallel kernel compile (5 times, make -j24, compile an ia64
>   2.4.18 kernel with gcc 2.96. As gcc's speed is VERY dependent on the
>   number of registers of the target architecture, the results are not
>   comparable to i386 compiles.)
> 
> Schedulers tested (all on top of discontigmem for ia64):
> 
> A: vanilla O(1) scheduler from 2.5.39
> B: Michael Hohnbaums simple NUMA scheduler (latest published rev 2)
> C: pooling NUMA scheduler with initial load balancing (patches 01+02
>    from the 5 patches sent out)
> D: node affine NUMA scheduler (patches 01+02+03)
> E: node affine NUMA scheduler with dynamic homenode (patches 01+02+03+05)
> 
> All results are averages over several measurements, the numbers in braces
> are the standard deviation or "error bars".
> 
> There's a lot to say about the results, e.g that E is the best because it
> has most features. But the only comment I really want to make on this now
> is: the numa_test is not good enough for testing node affinity as
> "hackbench 20" doesn't seem to disturb the initialy balance too much.
> I'll improve this to make it more realistic. Otherwise it's good enough
> to see the advantage of not moving around tasks across the nodes.
> 
> Best regards,
> Erich
> 
> Hackbench: (averages over 4 tests, execution time)
> -------------------------------------------------------------------
> N:	10		25		50		100
> A	5.54(0.10)	15.28(0.03)	32.65(0.35)	67.67(0.69)
> B	5.37(0.06)	15.13(0.44)	31.96(0.49)	67.14(0.43)
> C	1.31(0.08)	 2.91(0.12)	 5.95(0.13)	13.37(0.11)
> D	2.45(0.44)	 8.89(1.47)	21.98(1.08)	30.57(17.10)
> E	1.39(0.08)	 2.92(0.09)	 6.20(0.34)	14.30(0.28)
> 
> 
> numa_test: N=4
> ----------------------------------------------------------------------------
> 	Elapsed		AvgUserTime	TotUserTime	TotSysTime	Runs
> A	42.95(3.23)	30.40(1.16)	121.65(4.62)			10
> B	35.08(2.24)	28.51(0.77)	114.10(3.07)	0.19(0.03)	20
> C	27.44(0.06)	27.14(0.04)	108.62(0.15)	0.16(0.01)	20
> D	27.42(0.08)	27.10(0.04)	108.48(0.14)	0.15(0.01)	20
> E	27.50(0.23)	27.10(0.03)	108.48(0.13)	0.15(0.01)	20
> 
> 
> numa_test: N=8
> ----------------------------------------------------------------------------
> 	Elapsed		AvgUserTime	TotUserTime	TotSysTime	Runs
> A	42.75(2.31)	31.34(0.93)	250.82(7.46)			10
> B	34.82(2.74)	29.76(0.67)	238.19(5.34)	0.44(0.04)	20
> C	29.29(0.47)	28.80(0.14)	230.55(1.13)	0.35(0.02)	20
> D	29.23(0.40)	28.76(0.12)	230.20(0.92)	0.34(0.02)	20
> E	29.08(0.06)	28.76(0.03)	230.22(0.27)	0.34(0.01)	20
> 
> 
> numa_test: N=16
> ----------------------------------------------------------------------------
> 	Elapsed		AvgUserTime	TotUserTime	TotSysTime	Runs
> A	47.02(0.88)	33.80(0.90)	541.15(14.47)			10
> B	41.82(8.26)	32.04(0.47)	512.91(7.57)	1.08(0.05)	20
> C	41.30(5.50)	31.80(0.18)	509.11(2.84)	1.00(0.05)	20
> D	39.89(6.42)	31.80(0.10)	509.13(1.67)	0.95(0.03)	20
> E	41.61(5.42)	31.76(0.27)	508.44(4.32)	0.96(0.04)	20
> 
> 
> numa_test: N=32
> ----------------------------------------------------------------------------
> 	Elapsed		AvgUserTime	TotUserTime	TotSysTime	Runs
> A	83.52(2.25)	37.44(1.16)	1198.57(37.18)			10
> B	80.33(4.35)	33.86(0.60)	1083.94(19.07)	2.13(0.06)	10
> C	77.84(4.10)	33.58(0.36)	1074.82(11.47)			4
> D	73.59(6.31)	33.20(0.11)	1062.88(3.38)			4
> E	69.86(0.41)	33.26(0.06)	1064.72(1.88)	2.01(0.03)	10
> 
> 
> numa_test: N=64
> ----------------------------------------------------------------------------
> 	Elapsed		AvgUserTime	TotUserTime	TotSysTime	Runs
> A	164.15(3.40)	38.73(0.77)	2479.61(49.41)			10
> B	149.63(2.89)	34.61(0.40)	2215.80(25.42)	4.28(0.06)	10
> C	147.22(1.82)	34.41(0.13)	2202.88(8.39)			4
> D	139.32(5.26)	33.37(0.05)	2136.66(3.59)			4
> E	137.10(2.15)	33.40(0.02)	2138.13(1.37)	4.08(0.05)	10
> 
> 
> Kernbench: (averages over 5 compiles)
> -----------------------------------------------
> 	Elapsed		UserTime	SysTime
> A	93.78(0.43)	1321.05(1.20)	49.31(0.14)
> B	93.47(1.57)	1303.11(0.53)	52.27(0.46)
> C	92.67(1.08)	1304.09(0.74)	52.79(0.32)
> D	93.19(1.45)	1300.30(0.89)	52.46(0.20)
> E	93.63(1.00)	1299.44(0.67)	52.81(0.19)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

