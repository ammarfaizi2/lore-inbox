Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266702AbTBGVmE>; Fri, 7 Feb 2003 16:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266716AbTBGVmE>; Fri, 7 Feb 2003 16:42:04 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:58047 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266702AbTBGVmB>;
	Fri, 7 Feb 2003 16:42:01 -0500
Subject: Re: [patch] HT scheduler, sched-2.5.59-F3
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Theurer <habanero@us.ibm.com>, Rick Lindsley <ricklind@us.ibm.com>,
       Robert Love <rml@tech9.net>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Erich Focht <efocht@ess.nec.de>, Christoph Hellwig <hch@infradead.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0302070855560.3787-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0302070855560.3787-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Feb 2003 13:55:03 -0800
Message-Id: <1044654906.30909.198.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-07 at 00:38, Ingo Molnar wrote:
> 
> the attached patch is against current BK. I tested it on the following 6
> kernel/hardware combinations:
> 
>   (HT SMP kernel, SMP kernel, UP kernel) X (non-HT SMP box, HT SMP box)
> 
> all kernels compiled & booted fine.
> 
> 	Ingo
> 
Tested on a 4 node (16 700 MHZ P3 processors, 16 GB memory) NUMAQ.
Works fine.  Ran kernbench and schedbench (aka numatest) on this.
Also tested the E6 variant of this patch.  Both show similar results
as on stock kernels, except for light loads where the stock kernel
tends to spread processes more evenly across nodes.

On Tue, 2003-02-04 at 10:48, Erich Focht suggested the following to
address this light load case:
> > +#define CAN_MIGRATE_TASK(p,rq,cpu)             \
> > +       (((idle && AGRESSIVE_IDLE_STEAL) ||     \
> > +               (jiffies - (p)->last_run > cache_decay_ticks)) && \
> > +                       !task_running(p) && task_allowed(p, cpu))
> 
> this is still either all or nothing. I like the idle rebalancing
> beeing more aggressive than the non-idle one, but it could be
> smoother. What speaks against the following?
> 
> > +#define CAN_MIGRATE_TASK(p,rq,cpu)             \
> > +      ((jiffies - (p)->last_run > (cache_decay_ticks >> idle)) && \
> > +                       !task_running(p) && task_allowed(p, cpu))
> 
> 
> Where it hurts? As Andrew mentioned, Michael has seen weird behavior
> with the D7..E6(AGRESSIVE_IDLE_STEAL=1) alike schedulers. 

My testing did not show any noticeable difference with Erich's change.

Results below include the following kernels:

ingoF3 = linux 2.5.59 + Ingo's F3 patch + cputime_stats patch
ingoE6-59 = linux 2.5.59 + Ingo's E6 patch + cputime_stats patch
ingoE6-erich-59 = ingoE6-59 with change suggested by Erich Focht 
stock59 = linux 2.5.59 + cputime_stats patch

Kernbench:
                        Elapsed       User     System        CPU
              ingoF3     27.97s    275.96s    71.916s    1243.6%
           ingoE6-59    27.826s   276.514s    71.542s    1250.4%
     ingoE6-erich-59     27.59s   276.028s    69.964s    1254.2%
             stock59     27.58s    275.92s    71.134s    1258.4%

Schedbench 4:
                        AvgUser    Elapsed  TotalUser   TotalSys
              ingoF3      33.64      41.43     134.61       0.71
           ingoE6-59      33.21      44.76     132.88       0.70
     ingoE6-erich-59      33.49      43.80     134.02       0.81
             stock59      22.62      37.16      90.50       0.82

Schedbench 8:
                        AvgUser    Elapsed  TotalUser   TotalSys
              ingoF3      35.86      53.73     286.97       1.93
           ingoE6-59      32.65      44.14     261.25       1.52
     ingoE6-erich-59      35.83      68.42     286.69       1.90
             stock59      29.26      42.79     234.18       1.62

Schedbench 16:
                        AvgUser    Elapsed  TotalUser   TotalSys
              ingoF3      52.66      56.65     842.81       4.09
           ingoE6-59      52.94      56.69     847.25       3.57
     ingoE6-erich-59      52.90      58.27     846.57       3.93
             stock59      52.91      57.08     846.75       3.58

Schedbench 32:
                        AvgUser    Elapsed  TotalUser   TotalSys
              ingoF3      56.42     115.94    1805.65       6.31
           ingoE6-59      56.62     116.70    1812.17       6.76
     ingoE6-erich-59      56.45     117.27    1806.68       6.17
             stock59      56.66     117.14    1813.41       6.15

Schedbench 64:
                        AvgUser    Elapsed  TotalUser   TotalSys
              ingoF3      56.52     231.19    3617.94      14.84
           ingoE6-59      56.93     237.63    3644.36      16.78
     ingoE6-erich-59      56.98     236.96    3647.06      15.64
             stock59      56.56     230.71    3620.70      15.94

-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

