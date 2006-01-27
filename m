Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422703AbWA0XnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422703AbWA0XnH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 18:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422706AbWA0XnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 18:43:07 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:24965 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422703AbWA0XnG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 18:43:06 -0500
Date: Fri, 27 Jan 2006 15:42:31 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 1/2] rcu batch tuning
Message-ID: <20060127234231.GD10075@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <43DA7B47.11D10B09@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DA7B47.11D10B09@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 10:57:59PM +0300, Oleg Nesterov wrote:
> Dipankar Sarma wrote:
> >
> > +static void force_quiescent_state(struct rcu_data *rdp,
> > +			struct rcu_ctrlblk *rcp)
> > +{
> > +	int cpu;
> > +	cpumask_t cpumask;
> > +	set_need_resched();
> > +	if (unlikely(rdp->qlen - rdp->last_rs_qlen > rsinterval)) {
> > +		rdp->last_rs_qlen = rdp->qlen;
> > +		/*
> > +		 * Don't send IPI to itself. With irqs disabled,
> > +		 * rdp->cpu is the current cpu.
> > +		 */
> > +		cpumask = rcp->cpumask;
> > +		cpu_clear(rdp->cpu, cpumask);
> > +		for_each_cpu_mask(cpu, cpumask)
> > +			smp_send_reschedule(cpu);
> > +	}
> > +}
> > [ ... snip ... ]
> >
> > @@ -92,17 +128,13 @@ void fastcall call_rcu(struct rcu_head *
> >  	rdp = &__get_cpu_var(rcu_data);
> >  	*rdp->nxttail = head;
> >  	rdp->nxttail = &head->next;
> > -
> > -	if (unlikely(++rdp->count > 10000))
> > -		set_need_resched();
> > -
> > +	if (unlikely(++rdp->qlen > qhimark)) {
> > +		rdp->blimit = INT_MAX;
> > +		force_quiescent_state(rdp, &rcu_ctrlblk);
> > +	}
> 
> When ->qlen exceeds qhimark for the first time we send reschedule IPI to
> other CPUs and force_quiescent_state() records ->last_rs_qlen = ->qlen.
> But we don't reset ->last_rs_qlen when ->qlen goes to 0, this means that
> next time we need ++rdp->qlen > qhimark + rsinterval to force other CPUS
> to pass quiescent state, no?

Good catch -- this could well explain Lee's continuing to hit
latency problems.  Although this would not cause the first
latency event, only subsequent ones, it seems to me that ->last_rs_qlen
should be reset whenever ->blimit is reset.

Dipankar, thoughts?

> Also, it seems to me it's better to have 2 counters, one for length(->donelist)
> and another for length(->curlist + ->nxtlist). I think we don't need
> force_quiescent_state() when all rcu callbacks are placed in ->donelist,
> we only need to increase rdp->blimit in this case.

True, currently the patch keeps the sum of the length of all three lists,
and takes both actions when the sum gets too large.  But the only way
you would get unneeded IPIs would be if callback processing was
stalled, but callback generation and grace-period processing was
still proceeding.  Seems at first glance to be an unusual corner
case, with the only downside being some extra IPIs.  Or am I missing
some aspect?

						Thanx, Paul
