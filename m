Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966647AbWKTUXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966647AbWKTUXA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 15:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966642AbWKTUXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 15:23:00 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:1202 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S966644AbWKTUW7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 15:22:59 -0500
Date: Mon, 20 Nov 2006 15:22:58 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
cc: Oleg Nesterov <oleg@tv-sign.ru>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
In-Reply-To: <20061120191728.GE8033@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0611201502090.7569-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006, Paul E. McKenney wrote:

> On Mon, Nov 20, 2006 at 12:19:19PM -0500, Alan Stern wrote:
> > Paul:
> > 
> > Here's my version of your patch from yesterday.  It's basically the same,
> > but I cleaned up the code in a few places and fixed a bug (the sign of idx
> > in srcu_read_unlock).  Also I changed the init routine back to void, since
> > it's no longer an error if the per-cpu allocation fails.
> 
> I don't see any changes in the sign of idx.

Your earlier patch had srcu_read_unlock doing:

+	if (likely(idx <= 0)) {
+		preempt_disable();
+		smp_mb();
+		per_cpu_ptr(rcu_dereference(sp->per_cpu_ref),
+			    smp_processor_id())->c[idx]--;
+		preempt_enable();
+		return;
+	}

Obviously you meant the test to be "idx >= 0".

> > -int init_srcu_struct(struct srcu_struct *sp)
> > +void init_srcu_struct(struct srcu_struct *sp)
> >  {
> >  	sp->completed = 0;
> >  	mutex_init(&sp->mutex);
> > -	sp->per_cpu_ref = alloc_percpu(struct srcu_struct_array);
> > -	return (sp->per_cpu_ref ? 0 : -ENOMEM);
> > +	sp->per_cpu_ref = alloc_srcu_struct_percpu();
> > +	atomic_set(&sp->hardluckref[0], 0);
> > +	atomic_set(&sp->hardluckref[1], 0);
> >  }
> 
> Nack -- the caller is free to ignore the error return, but should be
> able to detect it in case the caller is unable to tolerate the overhead
> of running in hardluckref mode, perhaps instead choosing to fail a
> user-level request in order to try to reduce memory pressure.

Okay.  Remember to change back the declaration in srcu.h as well.

> I did update the comment to say that you can use SRCU_INITIALIZER()
> instead.

Good.

> >  int srcu_read_lock(struct srcu_struct *sp)
> >  {
> >  	int idx;
> > +	struct srcu_struct_array *sap;
> > +
> > +	if (unlikely(sp->per_cpu_ref == NULL &&
> > +			mutex_trylock(&sp->mutex))) {
> > +		if (sp->per_cpu_ref == NULL)
> > +			sp->per_cpu_ref = alloc_srcu_struct_percpu();
> > +		mutex_unlock(&sp->mutex);
> > +	}
> > 
> >  	preempt_disable();
> >  	idx = sp->completed & 0x1;
> >  	barrier();  /* ensure compiler looks -once- at sp->completed. */
> > -	per_cpu_ptr(sp->per_cpu_ref, smp_processor_id())->c[idx]++;
> > -	srcu_barrier();  /* ensure compiler won't misorder critical section. */
> > +	sap = rcu_dereference(sp->per_cpu_ref);
> > +	if (likely(sap != NULL)) {
> > +		per_cpu_ptr(sap, smp_processor_id())->c[idx]++;
> > +		smp_mb();
> > +	} else {
> > +		atomic_inc(&sp->hardluckref[idx]);
> > +		smp_mb__after_atomic_inc();
> > +		idx = -1 - idx;
> > +	}
> >  	preempt_enable();
> >  	return idx;
> >  }
> 
> Good restructuring -- took this, though I restricted the unlikely() to
> cover only the comparison to NULL, since the mutex_trylock() has a
> reasonable chance of success assuming that the read path has substantial
> overhead from other sources.

I vacillated over that.  It's not clear what difference it will make to 
the compiler, but I guess you would make it a little clearer to a reader 
that the unlikely part is the test for NULL.

> > @@ -131,10 +166,16 @@ int srcu_read_lock(struct srcu_struct *s
> >   */
> >  void srcu_read_unlock(struct srcu_struct *sp, int idx)
> >  {
> > -	preempt_disable();
> > -	srcu_barrier();  /* ensure compiler won't misorder critical section. */
> > -	per_cpu_ptr(sp->per_cpu_ref, smp_processor_id())->c[idx]--;
> > -	preempt_enable();
> > +	if (likely(idx >= 0)) {
> > +		smp_mb();
> > +		preempt_disable();
> > +		per_cpu_ptr(rcu_dereference(sp->per_cpu_ref),
> > +			    smp_processor_id())->c[idx]--;
> > +		preempt_enable();
> > +	} else {
> > +		smp_mb__before_atomic_dec();
> > +		atomic_dec(&sp->hardluckref[-1 - idx]);
> > +	}
> >  }
> 
> I took the moving smp_mb() out from under preempt_disable().
> I left the "return" -- same number of lines either way.
> I don't see any changes in sign compared to what I had, FWIW.

Compare your "if" statement to mine.

> > @@ -168,71 +214,35 @@ void synchronize_srcu(struct srcu_struct
> >  	 * either (1) wait for two or (2) supply the second ourselves.
> >  	 */
> > 
> > -	if ((sp->completed - idx) >= 2) {
> > -		mutex_unlock(&sp->mutex);
> > -		return;
> > -	}
> > +	if ((sp->completed - idx) >= 2)
> > +		goto done;
> 
> I don't see the benefit of gathering all the mutex_unlock()s together.
> If the unwinding was more complicated, I would take this change, however.

It's not a big deal.  A couple of extra function calls won't add much 
code.

> > +#ifdef	SMP__STORE_MB_LOAD_WORKS	/* The fast path */
> > +	if (srcu_readers_active_idx(sp, idx) == 0)
> > +		goto done;
> > +#endif
> 
> I still don't trust this one.  I would trust it a bit more if it were
> srcu_readers_active() rather than srcu_readers_active_idx(), but even
> then I suspect that external synchronization is required.

There should be some sort of assertion at the start of synchronize_srcu 
(just after the mutex is acquired) that srcu_readers_active_idx() yields 0 
for the inactive idx, and a similar assertion at the end (just before the 
mutex is released).  Hence there's no need to check both indices.

>  Or is there
> something that I am missing that makes it safe in face of the sequence
> of events that you, Oleg, and I were discussing?

Consider the sequence of events we were discussing.

	srcu_read_lock and synchronize_srcu are invoked at the same
	time.  The writer sees that the count is 0 and takes the fast
	path, leaving sp->completed unchanged.  The reader sees the
	new value of the data pointer and starts using it.

	While the reader is still running, synchronize_srcu is called
	again.  This time it sees that the count is > 0, so it doesn't
	take the fast path.  Everything follows according to your
	original code.

The underlying problem with Oleg's code was that the reader could end up 
incrementing the wrong counter.  That can't happen with the fast path,
because sp->completed doesn't change.

> For the moment, this optimization should be done by the caller, and
> should be prominently commented.

Prominent commenting is certainly a good idea.  However I don't see how 
the caller can make this optimization without getting into the guts of the 
SRCU implementation.  After all, a major part of the optimization is 
to avoid calling synchronize_sched().

Alan

