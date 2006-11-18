Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755173AbWKRQPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755173AbWKRQPa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 11:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755178AbWKRQPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 11:15:30 -0500
Received: from mx2.rowland.org ([192.131.102.7]:2321 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1755173AbWKRQP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 11:15:29 -0500
Date: Sat, 18 Nov 2006 11:15:27 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
cc: Oleg Nesterov <oleg@tv-sign.ru>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
In-Reply-To: <20061118002845.GF2632@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0611181054470.28058-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few things I don't like about this patch.

On Fri, 17 Nov 2006, Paul E. McKenney wrote:

> diff -urpNa -X dontdiff linux-2.6.19-rc5/kernel/srcu.c linux-2.6.19-rc5-dsrcu/kernel/srcu.c
> --- linux-2.6.19-rc5/kernel/srcu.c	2006-11-17 13:54:17.000000000 -0800
> +++ linux-2.6.19-rc5-dsrcu/kernel/srcu.c	2006-11-17 14:15:06.000000000 -0800
> @@ -34,6 +34,18 @@
>  #include <linux/smp.h>
>  #include <linux/srcu.h>
>  
> +/*
> + * Initialize the per-CPU array, returning the pointer.
> + */
> +static inline struct srcu_struct_array *alloc_srcu_struct_percpu(void)
> +{
> +	struct srcu_struct_array *sap;
> +
> +	sap = alloc_percpu(struct srcu_struct_array);
> +	smp_wmb();
> +	return (sap);

Style: Don't use () here.

> +}
> +
>  /**
>   * init_srcu_struct - initialize a sleep-RCU structure
>   * @sp: structure to initialize.

> @@ -94,7 +112,8 @@ void cleanup_srcu_struct(struct srcu_str
>  	WARN_ON(sum);  /* Leakage unless caller handles error. */
>  	if (sum != 0)
>  		return;
> -	free_percpu(sp->per_cpu_ref);
> +	if (sp->per_cpu_ref != NULL)
> +		free_percpu(sp->per_cpu_ref);

Now that Andrew has accepted the "allow free_percpu(NULL)" change, you can 
remove the test here.

>  	sp->per_cpu_ref = NULL;
>  }
>  
> @@ -105,18 +124,39 @@ void cleanup_srcu_struct(struct srcu_str
>   * Counts the new reader in the appropriate per-CPU element of the
>   * srcu_struct.  Must be called from process context.
>   * Returns an index that must be passed to the matching srcu_read_unlock().
> + * The index is -1 if the srcu_struct is not and cannot be initialized.
>   */
>  int srcu_read_lock(struct srcu_struct *sp)
>  {
>  	int idx;
> +	struct srcu_struct_array *sap;
>  
>  	preempt_disable();
>  	idx = sp->completed & 0x1;
> -	barrier();  /* ensure compiler looks -once- at sp->completed. */
> -	per_cpu_ptr(sp->per_cpu_ref, smp_processor_id())->c[idx]++;
> -	srcu_barrier();  /* ensure compiler won't misorder critical section. */
> +	sap = rcu_dereference(sp->per_cpu_ref);
> +	if (likely(sap != NULL)) {
> +		barrier();  /* ensure compiler looks -once- at sp->completed. */

Put this barrier() back where the old one was (outside the "if").

> +		per_cpu_ptr(rcu_dereference(sap),

You don't need the rcu_dereference here, you already have it above.

> +			    smp_processor_id())->c[idx]++;
> +		smp_mb();
> +		preempt_enable();
> +		return idx;
> +	}
> +	if (mutex_trylock(&sp->mutex)) {
> +		preempt_enable();

Move the preempt_enable() before the "if", then get rid of the 
preempt_enable() after the "if" block.

> +		if (sp->per_cpu_ref == NULL)
> +			sp->per_cpu_ref = alloc_srcu_struct_percpu();

It would be cleaner to put the mutex_unlock() and closing '}' right here.

> +		if (sp->per_cpu_ref == NULL) {
> +			atomic_inc(&sp->hardluckref);
> +			mutex_unlock(&sp->mutex);
> +			return -1;
> +		}
> +		mutex_unlock(&sp->mutex);
> +		return srcu_read_lock(sp);
> +	}
>  	preempt_enable();
> -	return idx;
> +	atomic_inc(&sp->hardluckref);
> +	return -1;
>  }
>  
>  /**
> @@ -131,10 +171,17 @@ int srcu_read_lock(struct srcu_struct *s
>   */
>  void srcu_read_unlock(struct srcu_struct *sp, int idx)
>  {
> -	preempt_disable();
> -	srcu_barrier();  /* ensure compiler won't misorder critical section. */
> -	per_cpu_ptr(sp->per_cpu_ref, smp_processor_id())->c[idx]--;
> -	preempt_enable();
> +	if (likely(idx != -1)) {
> +		preempt_disable();
> +		smp_mb();
> +		per_cpu_ptr(rcu_dereference(sp->per_cpu_ref),
> +			    smp_processor_id())->c[idx]--;
> +		preempt_enable();
> +		return;
> +	}
> +	mutex_lock(&sp->mutex);
> +	atomic_dec(&sp->hardluckref);
> +	mutex_unlock(&sp->mutex);

You don't need the mutex to protect an atomic_dec.

>  }
>  
>  /**
> @@ -158,6 +205,11 @@ void synchronize_srcu(struct srcu_struct
>  	idx = sp->completed;
>  	mutex_lock(&sp->mutex);
>  
> +	/* Initialize if not already initialized. */
> +
> +	if (sp->per_cpu_ref == NULL)
> +		sp->per_cpu_ref = alloc_srcu_struct_percpu();

What happens if a prior reader failed to allocate the memory but this call 
succeeds?  You need to check hardluckref before doing this.  The same is 
true in srcu_read_lock().

> +
>  	/*
>  	 * Check to see if someone else did the work for us while we were
>  	 * waiting to acquire the lock.  We need -two- advances of
> @@ -173,65 +225,25 @@ void synchronize_srcu(struct srcu_struct
>  		return;
>  	}
>  
> -	synchronize_sched();  /* Force memory barrier on all CPUs. */
> -
> -	/*
> -	 * The preceding synchronize_sched() ensures that any CPU that
> -	 * sees the new value of sp->completed will also see any preceding
> -	 * changes to data structures made by this CPU.  This prevents
> -	 * some other CPU from reordering the accesses in its SRCU
> -	 * read-side critical section to precede the corresponding
> -	 * srcu_read_lock() -- ensuring that such references will in
> -	 * fact be protected.
> -	 *
> -	 * So it is now safe to do the flip.
> -	 */
> -
> +	smp_mb();  /* ensure srcu_read_lock() sees prior change first! */
>  	idx = sp->completed & 0x1;
>  	sp->completed++;
>  
> -	synchronize_sched();  /* Force memory barrier on all CPUs. */
> +	synchronize_sched();
>  
>  	/*
>  	 * At this point, because of the preceding synchronize_sched(),
>  	 * all srcu_read_lock() calls using the old counters have completed.
>  	 * Their corresponding critical sections might well be still
>  	 * executing, but the srcu_read_lock() primitives themselves
> -	 * will have finished executing.
> +	 * will have finished executing.  The "old" rank of counters
> +	 * can therefore only decrease, never increase in value.
>  	 */
>  
>  	while (srcu_readers_active_idx(sp, idx))
>  		schedule_timeout_interruptible(1);
>  
> -	synchronize_sched();  /* Force memory barrier on all CPUs. */
> -
> -	/*
> -	 * The preceding synchronize_sched() forces all srcu_read_unlock()
> -	 * primitives that were executing concurrently with the preceding
> -	 * for_each_possible_cpu() loop to have completed by this point.
> -	 * More importantly, it also forces the corresponding SRCU read-side
> -	 * critical sections to have also completed, and the corresponding
> -	 * references to SRCU-protected data items to be dropped.
> -	 *
> -	 * Note:
> -	 *
> -	 *	Despite what you might think at first glance, the
> -	 *	preceding synchronize_sched() -must- be within the
> -	 *	critical section ended by the following mutex_unlock().
> -	 *	Otherwise, a task taking the early exit can race
> -	 *	with a srcu_read_unlock(), which might have executed
> -	 *	just before the preceding srcu_readers_active() check,
> -	 *	and whose CPU might have reordered the srcu_read_unlock()
> -	 *	with the preceding critical section.  In this case, there
> -	 *	is nothing preventing the synchronize_sched() task that is
> -	 *	taking the early exit from freeing a data structure that
> -	 *	is still being referenced (out of order) by the task
> -	 *	doing the srcu_read_unlock().
> -	 *
> -	 *	Alternatively, the comparison with "2" on the early exit
> -	 *	could be changed to "3", but this increases synchronize_srcu()
> -	 *	latency for bulk loads.  So the current code is preferred.
> -	 */
> +	smp_mb();  /* must see critical section prior to srcu_read_unlock() */
>  
>  	mutex_unlock(&sp->mutex);
>  }
> 

Alan Stern

