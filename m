Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030780AbWKURyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030780AbWKURyc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 12:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966972AbWKURyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 12:54:32 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:24496 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S966971AbWKURyb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 12:54:31 -0500
Date: Tue, 21 Nov 2006 09:55:48 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Oleg Nesterov <oleg@tv-sign.ru>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061121175548.GA2013@us.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20061120191728.GE8033@us.ibm.com> <Pine.LNX.4.44L0.0611201502090.7569-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0611201502090.7569-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 03:22:58PM -0500, Alan Stern wrote:
> On Mon, 20 Nov 2006, Paul E. McKenney wrote:
> 
> > On Mon, Nov 20, 2006 at 12:19:19PM -0500, Alan Stern wrote:
> > > Paul:
> > >
> > > Here's my version of your patch from yesterday.  It's basically the same,
> > > but I cleaned up the code in a few places and fixed a bug (the sign of idx
> > > in srcu_read_unlock).  Also I changed the init routine back to void, since
> > > it's no longer an error if the per-cpu allocation fails.
> >
> > I don't see any changes in the sign of idx.
> 
> Your earlier patch had srcu_read_unlock doing:
> 
> +	if (likely(idx <= 0)) {
> +		preempt_disable();
> +		smp_mb();
> +		per_cpu_ptr(rcu_dereference(sp->per_cpu_ref),
> +			    smp_processor_id())->c[idx]--;
> +		preempt_enable();
> +		return;
> +	}
> 
> Obviously you meant the test to be "idx >= 0".

That would explain the oops upon kicking off rcutorture.  ;-) Good catch --
must be time for me to visit the optometrist or something...

> > > -int init_srcu_struct(struct srcu_struct *sp)
> > > +void init_srcu_struct(struct srcu_struct *sp)
> > >  {
> > >  	sp->completed = 0;
> > >  	mutex_init(&sp->mutex);
> > > -	sp->per_cpu_ref = alloc_percpu(struct srcu_struct_array);
> > > -	return (sp->per_cpu_ref ? 0 : -ENOMEM);
> > > +	sp->per_cpu_ref = alloc_srcu_struct_percpu();
> > > +	atomic_set(&sp->hardluckref[0], 0);
> > > +	atomic_set(&sp->hardluckref[1], 0);
> > >  }
> >
> > Nack -- the caller is free to ignore the error return, but should be
> > able to detect it in case the caller is unable to tolerate the overhead
> > of running in hardluckref mode, perhaps instead choosing to fail a
> > user-level request in order to try to reduce memory pressure.
> 
> Okay.  Remember to change back the declaration in srcu.h as well.

I did manage to get this one right.  ;-)

> > I did update the comment to say that you can use SRCU_INITIALIZER()
> > instead.
> 
> Good.
> 
> > >  int srcu_read_lock(struct srcu_struct *sp)
> > >  {
> > >  	int idx;
> > > +	struct srcu_struct_array *sap;
> > > +
> > > +	if (unlikely(sp->per_cpu_ref == NULL &&
> > > +			mutex_trylock(&sp->mutex))) {
> > > +		if (sp->per_cpu_ref == NULL)
> > > +			sp->per_cpu_ref = alloc_srcu_struct_percpu();
> > > +		mutex_unlock(&sp->mutex);
> > > +	}
> > >
> > >  	preempt_disable();
> > >  	idx = sp->completed & 0x1;
> > >  	barrier();  /* ensure compiler looks -once- at sp->completed. */
> > > -	per_cpu_ptr(sp->per_cpu_ref, smp_processor_id())->c[idx]++;
> > > -	srcu_barrier();  /* ensure compiler won't misorder critical section. */
> > > +	sap = rcu_dereference(sp->per_cpu_ref);
> > > +	if (likely(sap != NULL)) {
> > > +		per_cpu_ptr(sap, smp_processor_id())->c[idx]++;
> > > +		smp_mb();
> > > +	} else {
> > > +		atomic_inc(&sp->hardluckref[idx]);
> > > +		smp_mb__after_atomic_inc();
> > > +		idx = -1 - idx;
> > > +	}
> > >  	preempt_enable();
> > >  	return idx;
> > >  }
> >
> > Good restructuring -- took this, though I restricted the unlikely() to
> > cover only the comparison to NULL, since the mutex_trylock() has a
> > reasonable chance of success assuming that the read path has substantial
> > overhead from other sources.
> 
> I vacillated over that.  It's not clear what difference it will make to
> the compiler, but I guess you would make it a little clearer to a reader
> that the unlikely part is the test for NULL.

Agreed, probably mostly for the benefit of the human reader.

> > > @@ -131,10 +166,16 @@ int srcu_read_lock(struct srcu_struct *s
> > >   */
> > >  void srcu_read_unlock(struct srcu_struct *sp, int idx)
> > >  {
> > > -	preempt_disable();
> > > -	srcu_barrier();  /* ensure compiler won't misorder critical section. */
> > > -	per_cpu_ptr(sp->per_cpu_ref, smp_processor_id())->c[idx]--;
> > > -	preempt_enable();
> > > +	if (likely(idx >= 0)) {
> > > +		smp_mb();
> > > +		preempt_disable();
> > > +		per_cpu_ptr(rcu_dereference(sp->per_cpu_ref),
> > > +			    smp_processor_id())->c[idx]--;
> > > +		preempt_enable();
> > > +	} else {
> > > +		smp_mb__before_atomic_dec();
> > > +		atomic_dec(&sp->hardluckref[-1 - idx]);
> > > +	}
> > >  }
> >
> > I took the moving smp_mb() out from under preempt_disable().
> > I left the "return" -- same number of lines either way.
> > I don't see any changes in sign compared to what I had, FWIW.
> 
> Compare your "if" statement to mine.

<red face>

> > > @@ -168,71 +214,35 @@ void synchronize_srcu(struct srcu_struct
> > >  	 * either (1) wait for two or (2) supply the second ourselves.
> > >  	 */
> > >
> > > -	if ((sp->completed - idx) >= 2) {
> > > -		mutex_unlock(&sp->mutex);
> > > -		return;
> > > -	}
> > > +	if ((sp->completed - idx) >= 2)
> > > +		goto done;
> >
> > I don't see the benefit of gathering all the mutex_unlock()s together.
> > If the unwinding was more complicated, I would take this change, however.
> 
> It's not a big deal.  A couple of extra function calls won't add much
> code.

And some compilers do this kind of gathering automatically anyway.

> > > +#ifdef	SMP__STORE_MB_LOAD_WORKS	/* The fast path */
> > > +	if (srcu_readers_active_idx(sp, idx) == 0)
> > > +		goto done;
> > > +#endif
> >
> > I still don't trust this one.  I would trust it a bit more if it were
> > srcu_readers_active() rather than srcu_readers_active_idx(), but even
> > then I suspect that external synchronization is required.
> 
> There should be some sort of assertion at the start of synchronize_srcu
> (just after the mutex is acquired) that srcu_readers_active_idx() yields 0
> for the inactive idx, and a similar assertion at the end (just before the
> mutex is released).  Hence there's no need to check both indices.

OK, good point -- the non-active set is indeed supposed to sum to zero
unless someone is in synchronize_srcu().

> >  Or is there
> > something that I am missing that makes it safe in face of the sequence
> > of events that you, Oleg, and I were discussing?
> 
> Consider the sequence of events we were discussing.
> 
> 	srcu_read_lock and synchronize_srcu are invoked at the same
> 	time.  The writer sees that the count is 0 and takes the fast
> 	path, leaving sp->completed unchanged.  The reader sees the
> 	new value of the data pointer and starts using it.
> 
> 	While the reader is still running, synchronize_srcu is called
> 	again.  This time it sees that the count is > 0, so it doesn't
> 	take the fast path.  Everything follows according to your
> 	original code.
> 
> The underlying problem with Oleg's code was that the reader could end up
> incrementing the wrong counter.  That can't happen with the fast path,
> because sp->completed doesn't change.

OK, then the remaining area of my paranoia centers around unfortunate
sequences of preemptions, increments, and decrements of the counters
while synchronize_srcu() is reading them out (and also being preempted).
Intuitively, it seems like this should always be safe, but I am worried
about it nonetheless.

> > For the moment, this optimization should be done by the caller, and
> > should be prominently commented.
> 
> Prominent commenting is certainly a good idea.  However I don't see how
> the caller can make this optimization without getting into the guts of the
> SRCU implementation.  After all, a major part of the optimization is
> to avoid calling synchronize_sched().

In general, I agree.  There may be special cases where the caller knows
it is safe due to things unknown to synchronize_srcu() -- Jens's example
might be a case in point.

							Thanx, Paul
