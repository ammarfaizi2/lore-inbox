Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267623AbTAQSCB>; Fri, 17 Jan 2003 13:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267624AbTAQSCB>; Fri, 17 Jan 2003 13:02:01 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:6841 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S267623AbTAQSB7> convert rfc822-to-8bit; Fri, 17 Jan 2003 13:01:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: Ingo Molnar <mingo@elte.hu>, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [patch] sched-2.5.59-A2
Date: Fri, 17 Jan 2003 19:11:29 +0100
User-Agent: KMail/1.4.3
Cc: Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
References: <Pine.LNX.4.44.0301170921430.3723-100000@localhost.localdomain> <200301171535.21226.efocht@ess.nec.de>
In-Reply-To: <200301171535.21226.efocht@ess.nec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301171911.29514.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

I repeated the tests with your B0 version and it's still not
satisfying. Maybe too aggressive NODE_REBALANCE_IDLE_TICK, maybe the
difference is that the other calls of load_balance() never have the
chance to balance across nodes.

Here are the results:

kernbench (average of 5 kernel compiles) (standard error in brackets)
---------
           Elapsed       UserTime      SysTime
orig       134.43(1.79)  944.79(0.43)  21.41(0.28)
ingo       136.74(1.58)  951.55(0.73)  21.16(0.32)
ingofix    135.22(0.59)  952.17(0.78)  21.16(0.19)
ingoB0     134.69(0.51)  951.63(0.81)  21.12(0.15)


hackbench (chat benchmark alike) (elapsed time for N groups of 20
---------           senders & receivers, stats from 10 measurements)

          N=10        N=25        N=50        N=100
orig      0.77(0.03)  1.91(0.06)  3.77(0.06)  7.78(0.21)
ingo      1.70(0.35)  3.11(0.47)  4.85(0.55)  8.80(0.98)
ingofix   1.16(0.14)  2.67(0.53)  5.05(0.26)  9.99(0.13)
ingoB0    0.84(0.03)  2.12(0.12)  4.20(0.22)  8.04(0.16)


numabench (N memory intensive tasks running in parallel, disturbed for
---------  a short time by a "hackbench 10" call)


numa_test N=4   ElapsedTime  TotalUserTime  TotalSysTime
orig:           26.13(2.54)  86.10(4.47)    0.09(0.01)
ingo:           27.60(2.16)  88.06(4.58)    0.11(0.01)
ingofix:        25.51(3.05)  83.55(2.78)    0.10(0.01)
ingoB0:         27.58(0.08)  90.86(4.42)    0.09(0.01)	

numa_test N=8   ElapsedTime  TotalUserTime  TotalSysTime
orig:           24.81(2.71)  164.94(4.82)   0.17(0.01)
ingo:           27.38(3.01)  170.06(5.60)   0.30(0.03)
ingofix:        29.08(2.79)  172.10(4.48)   0.32(0.03)
ingoB0:         26.05(3.28)  171.61(7.76)   0.18(0.01)

numa_test N=16  ElapsedTime  TotalUserTime  TotalSysTime
orig:           45.19(3.42)  332.07(5.89)   0.32(0.01)
ingo:           50.18(0.38)  359.46(9.31)   0.46(0.04)
ingofix:        50.30(0.42)  357.38(9.12)   0.46(0.01)
ingoB0:         50.96(1.33)  371.72(18.58)  0.34(0.01)

numa_test N=32  ElapsedTime  TotalUserTime  TotalSysTime
orig:           86.84(1.83)  671.99(9.98)   0.65(0.02)
ingo:           93.44(2.13)  704.90(16.91)  0.82(0.06)
ingofix:        93.92(1.28)  727.58(9.26)   0.77(0.03)
ingoB0:         99.72(4.13)  759.03(29.41)  0.69(0.01)


The kernbench user time is still too large.
Hackbench improved a lot (understandeable, as idle CPUs steal earlier
from remote nodes).
Numa_test didn't improve, in average we have the same results.

Hmmm, now I really tend towards letting it the way it is in
2.5.59. Except the topology cleanup and renaming, of course. I have no
more time to test a more conservative setting of
IDLE_NODE_REBALANCE_TICK today, but that could help...

Regards,
Erich

