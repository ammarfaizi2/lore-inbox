Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbUKPBxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbUKPBxX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 20:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbUKPBxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 20:53:23 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:43955 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261751AbUKPBxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 20:53:16 -0500
Subject: Re: [patch] scheduler: rebalance_tick interval update
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Darren Hart <dvhltc@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Rick Lindsley <ricklind@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <4199550E.1030704@cyberone.com.au>
References: <1100558313.17202.58.camel@localhost.localdomain>
	 <4199550E.1030704@cyberone.com.au>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1100569992.30259.20.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 15 Nov 2004 17:53:13 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-15 at 17:17, Nick Piggin wrote:
> Darren Hart wrote:
> 
> >The current rebalance_tick() code assigns each sched_domain's
> >last_balance field to += interval after performing a load_balance.  If
> >interval is 10, this has the effect of saying:  we want to run
> >load_balance at time = 10, 20, 30, 40, etc...  If for example
> >last_balance=10 and for some reason rebalance_tick can't be run until
> >30, load_balance will be called and last_balance will be updated to 20,
> >causing it to call load_balance again immediately the next time it is
> >called since the interval is 10 and we are already at >30.  It seems to
> >me that it would make much more sense for last_balance to be assigned
> >jiffies after a load_balance, then the meaning of last_balance is more
> >exact: "this domain was last balanced at jiffies" rather than "we last
> >handled the balance we were supposed to do at 20, at some indeterminate
> >time".  The following patch makes this change.
> >
> >
> 
> Hi Darren,
> 
> This is how I first implemented it... but I think this will cause
> rebalance points of each processor to tend to become synchronised
> (rather than staggered) as ticks get lost.


But isn't that what this is supposed to stop:

        unsigned long j = jiffies + CPU_OFFSET(this_cpu);
....
                if (j - sd->last_balance >= interval) {
                        if (load_balance(this_cpu, this_rq, sd, idle)) {
                                /* We've pulled tasks over so no longer idle */
                                idle = NOT_IDLE;
                        }
                        sd->last_balance += interval;
                }

The CPU_OFFSET() macro is designed to spread out the balancing so they
don't all occur at the same time, no?

-Matt

