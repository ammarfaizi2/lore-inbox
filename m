Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbUKPDx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbUKPDx6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 22:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbUKPDwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 22:52:54 -0500
Received: from dvhart.com ([64.146.134.43]:42881 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261769AbUKPDvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 22:51:24 -0500
Subject: Re: [patch] scheduler: rebalance_tick interval update
From: Darren Hart <darren@dvhart.com>
To: Matt Dobson <colpatch@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Martin J Bligh <mbligh@aracnet.com>,
       Rick Lindsley <ricklind@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <41996353.1060604@cyberone.com.au>
References: <1100558313.17202.58.camel@localhost.localdomain>
	 <4199550E.1030704@cyberone.com.au> <1100569992.30259.20.camel@arrakis>
	 <41996353.1060604@cyberone.com.au>
Content-Type: text/plain
Date: Mon, 15 Nov 2004 19:51:21 -0800
Message-Id: <1100577081.14742.26.camel@farah.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-16 at 13:17 +1100, Nick Piggin wrote:
> 
> Matthew Dobson wrote:
> 
> >On Mon, 2004-11-15 at 17:17, Nick Piggin wrote:
> >
> >>Darren Hart wrote:
> >>
> >>
> >>>The current rebalance_tick() code assigns each sched_domain's
> >>>last_balance field to += interval after performing a load_balance.  If
> >>>interval is 10, this has the effect of saying:  we want to run
> >>>load_balance at time = 10, 20, 30, 40, etc...  If for example
> >>>last_balance=10 and for some reason rebalance_tick can't be run until
> >>>30, load_balance will be called and last_balance will be updated to 20,
> >>>causing it to call load_balance again immediately the next time it is
> >>>called since the interval is 10 and we are already at >30.  It seems to
> >>>me that it would make much more sense for last_balance to be assigned
> >>>jiffies after a load_balance, then the meaning of last_balance is more
> >>>exact: "this domain was last balanced at jiffies" rather than "we last
> >>>handled the balance we were supposed to do at 20, at some indeterminate
> >>>time".  The following patch makes this change.
> >>>
> >>>
> >>>
> >>Hi Darren,
> >>
> >>This is how I first implemented it... but I think this will cause
> >>rebalance points of each processor to tend to become synchronised
> >>(rather than staggered) as ticks get lost.
> >>
> >
> >
> >But isn't that what this is supposed to stop:
> >
> >        unsigned long j = jiffies + CPU_OFFSET(this_cpu);
> >....
> >                if (j - sd->last_balance >= interval) {
> >                        if (load_balance(this_cpu, this_rq, sd, idle)) {
> >                                /* We've pulled tasks over so no longer idle */
> >                                idle = NOT_IDLE;
> >                        }
> >                        sd->last_balance += interval;
> >                }
> >
> >The CPU_OFFSET() macro is designed to spread out the balancing so they
> >don't all occur at the same time, no?
> >
> >
> 
> Yes, but if you balance n ticks since the last _rebalance_, then things will
> be able to drift. Let's say 2 CPUs, they balance at 10 jiffies intervals,
> 5 jiffies apart:
> 
> jiffy   CPU0                              CPU1
> 0       rebalance (next, 10)
> 5                                         rebalance (next, 15)
> 10      rebalance (next, 20)
> 15                                        rebalance can't be run until
>                                           30 as per Darren's example.
> 20      rebalance (next, 30)
> 30      rebalance (next, 40)              rebalance (next, 40)
> 

This example didn't take into account:
	unsigned long j = jiffies + CPU_OFFSET(this_cpu);
Which, even if the last_balance's were equal and intervals were the same
(unlikely since each CPU has it's own domain and the intervals are
adjusted independently?), would prevent them from both running on the
same timer tick.  So I don't think this example is accurate.  On the
other hand, even if it was valid, I would prefer this to running the
load_balance code on the same CPU and domain several ticks in a row
(which obviously accomplishes nothing).


-- 
Darren Hart <darren@dvhart.com>

