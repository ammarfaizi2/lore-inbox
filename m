Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264885AbTAPAEA>; Wed, 15 Jan 2003 19:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266964AbTAPAEA>; Wed, 15 Jan 2003 19:04:00 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:26012 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264885AbTAPADv>;
	Wed, 15 Jan 2003 19:03:51 -0500
Subject: Re: [PATCH 2.5.58] new NUMA scheduler: fix
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Erich Focht <efocht@ess.nec.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Christoph Hellwig <hch@infradead.org>,
       Andrew Theurer <habanero@us.ibm.com>, Robert Love <rml@tech9.net>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <200301151610.43204.efocht@ess.nec.de>
References: <52570000.1042156448@flay>
	<200301141743.25513.efocht@ess.nec.de>
	<1042570956.27149.178.camel@dyn9-47-17-164.beaverton.ibm.com> 
	<200301151610.43204.efocht@ess.nec.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 15 Jan 2003 16:14:00 -0800
Message-Id: <1042676046.24867.300.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-15 at 07:10, Erich Focht wrote:
> Thanks for the patience with the problems in the yesterday patches. I
> resend the patches in the same form. Made following changes:
> 
> - moved NODE_BALANCE_{RATE,MIN,MAX} to topology.h
> - removed the divide in the find_busiest_node() loop (thanks, Martin)
> - removed the modulo (%) in in the cross-node balancing trigger
> - re-added node_nr_running_init() stub, nr_running_init() and comments
>   from Christoph
> - removed the constant factor 4 in find_busiest_node. The
>   find_busiest_queue routine will take care of the case where the
>   busiest_node is running only few processes (at most one per CPU) and
>   return busiest=NULL .

These applied clean and looked good.  I ran numbers for kernels
with patches 1-4 and patches 1-5.  Results below.
> 
> I hope we can start tuning the parameters now. In the basic NUMA
> scheduler part these are:
>   NODE_THRESHOLD     : minimum percentage of node overload to
>                        trigger cross-node balancing
>   NODE_BALANCE_RATE  : arch specific, cross-node balancing is called
>                        after this many intra-node load balance calls

I need to spend a some time staring at this code and putting together
a series of tests to try.  I think the basic mechanism looks good, so
hopefully we are down to finding the best numbers for the architecture.
> 
> In the extended NUMA scheduler the fixed value of NODE_BALANCE_RATE is
> replaced by a variable rate set to :
>   NODE_BALANCE_MIN : if own node load is less then avg_load/2
>   NODE_BALANCE_MAX : if load is larger than avg_load/2
> Together with the reduced number of steals across nodes this might
> help us in achieving equal load among nodes. I'm not aware of any
> simple benchmark which can demonstrate this...
> 
> Regards,
> Erich
> ----
>
results:

stock58h: linux 2.5.58 with cputime stats patch
sched14r2-58: stock58h with latest NUMA sched patches 1 through 4
sched15r2-58: stock58h with latest NUMA sched patches 1 through 5
sched1-4-58: stock58h with previous NUMA sched patches 1 through 4

Kernbench:
                        Elapsed       User     System        CPU
        sched14r2-58    29.488s    284.02s    82.132s    1241.8%
        sched15r2-58    29.778s   282.792s    83.478s    1229.8%
            stock58h    31.656s    305.85s    89.232s    1248.2%
         sched1-4-58    29.886s   287.506s     82.94s      1239%

Schedbench 4:
                        AvgUser    Elapsed  TotalUser   TotalSys
        sched14r2-58      22.50      37.20      90.03       0.94
        sched15r2-58      16.63      24.23      66.56       0.69
            stock58h      27.73      42.80     110.96       0.85
         sched1-4-58      32.86      46.41     131.47       0.85

Schedbench 8:
                        AvgUser    Elapsed  TotalUser   TotalSys
        sched14r2-58      30.27      43.22     242.23       1.75
        sched15r2-58      30.90      42.46     247.28       1.48
            stock58h      45.97      61.87     367.81       2.11
         sched1-4-58      31.39      49.18     251.22       2.15

Schedbench 16:
                        AvgUser    Elapsed  TotalUser   TotalSys
        sched14r2-58      52.78      57.28     844.61       3.70
        sched15r2-58      48.44      65.31     775.25       3.30
            stock58h      60.91      83.63     974.71       6.18
         sched1-4-58      54.31      62.11     869.11       3.84

Schedbench 32:
                        AvgUser    Elapsed  TotalUser   TotalSys
        sched14r2-58      56.60     116.99    1811.56       5.94
        sched15r2-58      56.42     116.75    1805.82       6.45
            stock58h      84.26     195.16    2696.65      16.53
         sched1-4-58      61.49     140.51    1968.06       9.57

Schedbench 64:
                        AvgUser    Elapsed  TotalUser   TotalSys
        sched14r2-58      56.48     232.63    3615.55      16.02
        sched15r2-58      56.38     236.25    3609.03      15.41
            stock58h     123.27     511.77    7889.77      27.78
         sched1-4-58      63.39     266.40    4057.92      20.55

 
-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

