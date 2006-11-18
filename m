Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753375AbWKRVAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375AbWKRVAh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 16:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753309AbWKRVAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 16:00:37 -0500
Received: from mx2.rowland.org ([192.131.102.7]:44555 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1753375AbWKRVAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 16:00:37 -0500
Date: Sat, 18 Nov 2006 16:00:35 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Oleg Nesterov <oleg@tv-sign.ru>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
In-Reply-To: <20061118171410.GB4427@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0611181536050.15971-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Nov 2006, Paul E. McKenney wrote:

> > > @@ -94,7 +112,8 @@ void cleanup_srcu_struct(struct srcu_str
> > >  	WARN_ON(sum);  /* Leakage unless caller handles error. */
> > >  	if (sum != 0)
> > >  		return;
> > > -	free_percpu(sp->per_cpu_ref);
> > > +	if (sp->per_cpu_ref != NULL)
> > > +		free_percpu(sp->per_cpu_ref);
> > 
> > Now that Andrew has accepted the "allow free_percpu(NULL)" change, you can
> > remove the test here.
> 
> OK.  I thought that there was some sort of error-checking involved,
> but if not, will fix.

Just make sure that _you_ have the free_percpu(NULL) patch installed on 
your machine before testing this -- otherwise you'll get a nice hard 
crash!

> > >  	preempt_disable();
> > >  	idx = sp->completed & 0x1;
> > > -	barrier();  /* ensure compiler looks -once- at sp->completed. */
> > > -	per_cpu_ptr(sp->per_cpu_ref, smp_processor_id())->c[idx]++;
> > > -	srcu_barrier();  /* ensure compiler won't misorder critical section. */
> > > +	sap = rcu_dereference(sp->per_cpu_ref);
> > > +	if (likely(sap != NULL)) {
> > > +		barrier();  /* ensure compiler looks -once- at sp->completed. */
> > 
> > Put this barrier() back where the old one was (outside the "if").
> 
> Why?  Outside this "if", I don't use "sap".

Because it looks funny to see the comment here talking about sp->completed
when sp->completed hasn't been used for several lines.  (Maybe it looks
less funny in the patched source than in the patch itself.)  The best
place to prevent extra accesses of sp->completed is immediately after
the required access.

> > > +			    smp_processor_id())->c[idx]++;
> > > +		smp_mb();
> > > +		preempt_enable();
> > > +		return idx;
> > > +	}
> > > +	if (mutex_trylock(&sp->mutex)) {
> > > +		preempt_enable();
> > 
> > Move the preempt_enable() before the "if", then get rid of the
> > preempt_enable() after the "if" block.
> 
> No can do.  The preempt_enable() must follow the increment and
> the memory barrier, otherwise the synchronize_sched() inside
> synchronize_srcu() can't do its job.

You misunderstood -- I was talking about the preempt_enable() in the last
line quoted above (not the one in the third line) and the "if
(mutex_trylock" (not the earlier "if (likely").

> > > +		if (sp->per_cpu_ref == NULL)
> > > +			sp->per_cpu_ref = alloc_srcu_struct_percpu();
> > 
> > It would be cleaner to put the mutex_unlock() and closing '}' right here.
> 
> I can move the mutex_unlock() to this point, but I cannot otherwise
> merge the two following pieces of code -- at least not without doing
> an otherwise-gratuitous preempt_disable().  Which I suppose I could
> do, but seems like it would be more confusing than would the
> separate code.  I will play with this a bit and see if I can eliminate
> the duplication.

If you follow the advice above then you won't need to add a gratuitous 
preempt_disable().  Try it and see how it comes out; the idea is that 
you can use the same code for testing sp->per_cpu_ref regardless of 
whether the mutex_trylock() or the call to alloc_srcu_struct_percpu() 
succeeded.


> > What happens if a prior reader failed to allocate the memory but this call
> > succeeds?  You need to check hardluckref before doing this.  The same is
> > true in srcu_read_lock().
> 
> All accounted for by the fact that hardluckref is unconditionally
> added in by srcu_readers_active().  Right?

Yes, you're right.

> Will spin a new patch...

Good -- it's getting pretty messy to look at this one!

By the way, I think the fastpath for synchronize_srcu() should be safe, 
now that you have added the memory barriers into srcu_read_lock() and 
srcu_read_unlock().  You might as well try putting it in.

Although now that I look at it again, you have forgotten to put smp_mb()
after the atomic_inc() call and before the atomic_dec().  In 
srcu_read_unlock() you could just move the existing smp_mb() back before 
the test of idx.

Alan Stern

