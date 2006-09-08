Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWIHQBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWIHQBu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 12:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWIHQBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 12:01:50 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:22666 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750769AbWIHQBt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 12:01:49 -0400
Date: Fri, 8 Sep 2006 09:02:34 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Dipankar Sarma <dipankar@in.ibm.com>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Eric Dumazet <dada1@cosmosbay.com>,
       "David S. Miller" <davem@davemloft.net>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, josht@us.ibm.com
Subject: Re: [PATCH] simplify/improve rcu batch tuning
Message-ID: <20060908160234.GE1314@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060903163419.GA235@oleg> <20060907203727.GE1293@us.ibm.com> <20060908113930.GB250@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060908113930.GB250@oleg>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2006 at 03:39:30PM +0400, Oleg Nesterov wrote:
> On 09/07, Paul E. McKenney wrote:
> >
> > Some thoughts for testing...
> >
> > 1.	Modify rcutorture.c to keep all the rcutorture kernel threads
> > 	off of at least one CPU.  Run a CPU-bound user process on that
> > 	CPU.  Compare the rate a which grace periods progress in
> > 	the following three situations:
> >
> > 	a.	With your patch.
> >
> > 	b.	With stock kernel.
> >
> > 	c.	With the function disabled (e.g., use the
> > 		not-CONFIG_SMP version of force_quiescent_state()).
> >
> > 	You would expect to see fast grace-period progress for (a) and
> > 	(b), slow for (c).
> >
> > 2.	As above, but have another process generating lots of
> > 	RCU callbacks, for example, by opening and closing lots
> > 	of files, creating and deleting lots of files with long
> > 	randomly selected names, thrashing the route cache, or
> > 	whatever.
> 
> Thanks for review and suggestions. I'll try to run these tests next week.
> Afaics, it is enough to just do
> 
> 	for (;;) close(open(...))
> 
> for '2.'.

That code sequence certainly has been known to generate very large
numbers of RCU callbacks very quickly in the past...  ;-)

> > > @@ -86,8 +83,8 @@ static void force_quiescent_state(struct
> > >  	int cpu;
> > >  	cpumask_t cpumask;
> > >  	set_need_resched();
> >
> > Not that it makes a big difference, but why is the above
> > set_need_resched() not in the body of the following "if" statement?
> > It used to be important, because it could prevent additional IPIs in
> > the same grace period, but since the current code will only send one
> > IPI per grace period, it seems like it can safely be tucked under the
> > "if" statement.
> 
> I think there was another reason to do set_need_resched() unconditionally,
> but this is only my guess. We are sending IPIs to speedup the flashing of
> callbacks we already have in the queue. But set_need_resched() tries to
> suppress current process from adding new callbacks (not that it is perfect,
> though). Consider the 'for (;;) close(open(...))' loop.

Good point -- should get things going upon return from the next syscall.

> Actually I think it also makes sense to do tasklet_schedule(rcu_tasklet)
> in call_rcu(), this way we can detect that we need to start the next batch
> earlier.

As long as we don't do this too often...  One way to prevent doing this
too often would be to check rcp->completed against rdp->batch similarly
to __rcu_process_callbacks()'s checks.  In call_rcu(), perhaps something
like the following inside the ->qlen check:

	if (__rcu_pending(&rcu_ctrlblk, rdp) {
		tasklet_schedule(&per_cpu(rcu_tasklet, rdp->cpu));
	}

with similar code in call_rcu_bh().

> > > -	if (unlikely(rdp->qlen - rdp->last_rs_qlen > rsinterval)) {
> > > -		rdp->last_rs_qlen = rdp->qlen;
> > > +	if (unlikely(!rcp->signaled)) {
> > > +		rcp->signaled = 1;
> > >  		/*
> > >  		 * Don't send IPI to itself. With irqs disabled,
> > >  		 * rdp->cpu is the current cpu.
> > > @@ -297,6 +294,7 @@ static void rcu_start_batch(struct rcu_c
> > >  		smp_mb();
> > >  		cpus_andnot(rcp->cpumask, cpu_online_map, nohz_cpu_mask);
> > >
> > > +		rcp->signaled = 0;
> >
> > Would it make sense to invoke force_quiescent_state() here in the
> > case that rdp->qlen is still large?  The disadvantage is that qlen
> > still counts the number of callbacks that are already slated for
> > invocation.
> 
> This is not easy to do. rcu_start_batch() is "global", we need
> to scan all per-cpu 'struct rcu_data' and check it's ->qlen.

My thought was that it might make sense to check only this CPU's struct
rcu_data.  But I agree that the next approach seems more promising.

> >              Another approach would be to check rdp->qlen and
> > rcp->signaled in rcu_do_batch(), but only once rdp->donlist goes
> > NULL.
> 
> Agree. Probably we don't need to check !rdp->donlist, it should be
> empty after rcu_do_batch() invocation when ->qlen > qhimark, because
> in that case ->blimit == INT_MAX.

And rcu_do_batch() already checks rdp->donelist anyway, so this code
could just be put into the "else" clause of the existing rdp->donelist
check at the end of rcu_do_batch().  So, yes, this does appear to be
the best approach.

> But first I'd like to do a couple of other cleanups here, I'll send
> the patches on weekend.

Look forward to seeing them!

							Thanx, Paul
