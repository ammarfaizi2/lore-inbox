Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261568AbTARACV>; Fri, 17 Jan 2003 19:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261581AbTARACV>; Fri, 17 Jan 2003 19:02:21 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:57755 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261568AbTARACS>; Fri, 17 Jan 2003 19:02:18 -0500
Subject: Re: [Lse-tech] Re: [patch] sched-2.5.59-A2
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Erich Focht <efocht@ess.nec.de>, Ingo Molnar <mingo@elte.hu>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Andrew Theurer <habanero@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <148970000.1042831603@flay>
References: <Pine.LNX.4.44.0301170921430.3723-100000@localhost.localdomain>
	<200301171535.21226.efocht@ess.nec.de>
	<200301171911.29514.efocht@ess.nec.de> <147000000.1042830254@flay> 
	<148970000.1042831603@flay>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Jan 2003 16:13:26 -0800
Message-Id: <1042848809.24867.483.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-17 at 11:26, Martin J. Bligh wrote:
> 
> System times are little higher (multipliers are set at busy = 10,
> idle = 10) .... I'll try setting the idle multipler to 100, but
> the other thing to do would be into increase the cross-node migrate
> resistance by setting some minimum imbalance offsets. That'll 
> probably have to be node-specific ... something like the number
> of cpus per node ... but probably 0 for the simple HT systems.
> 
> M.

I tried several values for the multipliers (IDLE_NODE_REBALANCE_TICK
and BUSY_NODE_REBALANCE_TICK) on a 4 node NUMAQ (16 700MHZ Pentium III
CPUs, 16 GB memory).  The interesting results follow:

Kernels:

stock59 - linux 2.5.59 with cputime_stats patch
ingoI50B10 - stock59 with Ingo's B0 patch as modified by Martin
             with a IDLE_NODE_REBALANCE_TICK multiplier of 50
             and a BUSY_NODE_REBALANCE_TICK multiplier of 10
ingoI2B2 - stock59 with Ingos B0 patch with the original multipliers (2)

Kernbench:
                        Elapsed       User     System        CPU
          ingoI50B10    29.574s   284.922s    84.542s      1249%
             stock59    29.498s   283.976s     83.05s    1243.8%
            ingoI2B2    30.212s   289.718s    84.926s      1240%

Schedbench 4:
                        AvgUser    Elapsed  TotalUser   TotalSys
          ingoI50B10      22.49      37.04      90.00       0.86
             stock59      22.25      35.94      89.06       0.81
            ingoI2B2      24.98      40.71      99.98       1.03

Schedbench 8:
                        AvgUser    Elapsed  TotalUser   TotalSys
          ingoI50B10      31.16      49.63     249.32       1.86
             stock59      28.40      42.25     227.26       1.67
            ingoI2B2      36.81      59.38     294.57       2.02

Schedbench 16:
                        AvgUser    Elapsed  TotalUser   TotalSys
          ingoI50B10      52.73      56.61     843.91       3.56
             stock59      52.97      57.19     847.70       3.29
            ingoI2B2      57.88      71.32     926.29       5.51

Schedbench 32:
                        AvgUser    Elapsed  TotalUser   TotalSys
          ingoI50B10      58.85     139.76    1883.59       8.07
             stock59      56.57     118.05    1810.53       5.97
            ingoI2B2      61.48     137.38    1967.52      10.92

Schedbench 64:
                        AvgUser    Elapsed  TotalUser   TotalSys
          ingoI50B10      70.74     297.25    4528.25      19.09
             stock59      56.75     234.12    3632.72      15.70
            ingoI2B2      70.56     298.45    4516.67      21.41

Martin already posted numbers with 10/10 for the multipliers.

It looks like on the NUMAQ the 50/10 values give the best results,
at least on these tests.  I suspect that on other architectures
the optimum numbers will vary.  Most likely on machines with lower
latency to off node memory, lower multipliers will help.  It will
be interesting to see numbers from Erich from the NEC IA64 boxes.
-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

