Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbWI3MLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWI3MLo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 08:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbWI3MLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 08:11:44 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:18349 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750930AbWI3MLm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 08:11:42 -0400
Date: Sat, 30 Sep 2006 17:41:29 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 16/23] dynticks: core
Message-ID: <20060930121129.GB8763@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060929234435.330586000@cruncher.tec.linutronix.de> <20060929234440.636609000@cruncher.tec.linutronix.de> <20060930014456.55543e93.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060930014456.55543e93.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2006 at 01:44:56AM -0700, Andrew Morton wrote:
> On Fri, 29 Sep 2006 23:58:35 -0000
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > From: Ingo Molnar <mingo@elte.hu>
> > 
> > dynticks core code.
> > 
> > Add idling-stats to the cpu base (to be used to optimize power
> > management decisions), add the scheduler tick and its stop/restart
> > functions, and the jiffies-update function to be called when an irq
> > context hits the idle context.
> > 
> 
> I worry that we're making this feature optional.
> > +	/*
> > +	 * RCU normally depends on the timer IRQ kicking completion
> > +	 * in every tick. We have to do this here now:
> > +	 */
> > +	if (rcu_pending(cpu)) {
> > +		/*
> > +		 * We are in quiescent state, so advance callbacks:
> > +		 */
> > +		rcu_advance_callbacks(cpu, 1);
> > +		local_irq_enable(); <----------------- Here
> > +		local_bh_disable();
> > +		rcu_process_callbacks(0);
> > +		local_bh_enable();
> > +	}
> > +
> > +	local_irq_restore(flags);
> > +
> > +	return need_resched();
> > +}
> 
> Are the RCU guys OK with this?

What prevents more RCU callbacks getting queued up by an
irq after irqs are enabled (marked Here) ? This seems racy.
The s390 implementation is correct - there we back out
if RCU is pending. Also, one call
to rcu_process_callbacks() doesn't guarantee that all
the RCUs are processed. They can be rate limited.

Thanks
Dipankar
