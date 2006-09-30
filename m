Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbWI3Nwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWI3Nwk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 09:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbWI3Nwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 09:52:40 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:19096 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750968AbWI3Nwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 09:52:39 -0400
Date: Sat, 30 Sep 2006 19:22:26 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>, Jim Gettys <jg@laptop.org>,
       John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 08/23] dynticks: prepare the RCU code
Message-ID: <20060930135226.GF8763@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060929234435.330586000@cruncher.tec.linutronix.de> <20060929234439.721237000@cruncher.tec.linutronix.de> <20060930013641.263a1cc3.akpm@osdl.org> <20060930122514.GC8763@in.ibm.com> <20060930130958.GA12021@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060930130958.GA12021@elte.hu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2006 at 03:09:58PM +0200, Ingo Molnar wrote:
> * Dipankar Sarma <dipankar@in.ibm.com> wrote:
> 
> > It is duplicating code. That can be easily fixed, but we need to 
> > figure out what we really want from RCU when we are about to switch 
> > off the ticks. It is hard if you want to finish off all the pending 
> > RCUs and go to nohz state. Can you live with backing out if there are 
> > pending RCUs ?
> 
> the thing is that when we go idle we /want/ to process whatever delayed 
> work there might be - rate limited or not. Do you agree with that 
> approach? I consider this a performance feature as well: this way we can 
> utilize otherwise lost idle time. It is not a problem that we dont 
> 'batch' this processing: we are really idle and we've got free cycles to 
> burn. We could even do an RCU processing loop that immediately breaks 
> out if need_resched() gets set [by an IRQ or by another CPU].

If you don't care about rate limiting RCU processing (you wouldn't
in CONFIG_PREEMPT_RT), you still have to deal with the situation
that one CPU going idle doesn't guarantee that you can process
all pending RCUs. You can process the finished ones, but what
about the ones that are still waiting for the grace period
beyond the current cpu ?

> 
> secondly, i think i saw functionality problems when RCU was not 
> completed before going idle - for example synchronize_rcu() on another 
> CPU would hang.

That is probably because of what I mention above. In the original
CONFIG_NO_IDLE_HZ, we don't go into a nohz state if there are
RCUs pending in that cpu.

> 
> what approach would you suggest to achieve these goals?

There is no way to finish all the RCUs in a given cpu
unless you are prepared to wait for a grace period or so. 
So, you go to idle, keep checking in the timer tick and as soon 
as all RCUs are done, go to nohz state. You can keep
processing RCUs in every idle tick so that if you have only
finished RCU callbacks on that cpu, you can go to nohz rightaway.
I can add that API.

Of course, you can do what cpu hotplug does - move the RCUs
to another CPU. But that is an expensive operaation.

Thanks
Dipankar
