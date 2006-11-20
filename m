Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966448AbWKTTQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966448AbWKTTQN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 14:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966452AbWKTTQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 14:16:13 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:25574 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S966448AbWKTTQL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 14:16:11 -0500
Date: Mon, 20 Nov 2006 11:17:28 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oleg Nesterov <oleg@tv-sign.ru>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061120191728.GE8033@us.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20061119214315.GI4427@us.ibm.com> <Pine.LNX.4.44L0.0611201212040.3224-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0611201212040.3224-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 12:19:19PM -0500, Alan Stern wrote:
> Paul:
> 
> Here's my version of your patch from yesterday.  It's basically the same,
> but I cleaned up the code in a few places and fixed a bug (the sign of idx
> in srcu_read_unlock).  Also I changed the init routine back to void, since
> it's no longer an error if the per-cpu allocation fails.

I don't see any changes in the sign of idx.

> More importantly, I added a static initializer and included the fast-path
> in synchronize_srcu.  It's protected by the new symbol
> SMP__STORE_MB_LOAD_WORKS, which should be defined in arch-specific headers
> for those architectures where the store-mb-load pattern is safe.

I did take most of your changes.  Comments interspersed below...

I will send out an updated patch after a bit of testing.

> Alan
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> ---
> 
> Index: usb-2.6/include/linux/srcu.h
> ===================================================================
> --- usb-2.6.orig/include/linux/srcu.h
> +++ usb-2.6/include/linux/srcu.h
> @@ -35,19 +35,19 @@ struct srcu_struct {
>  	int completed;
>  	struct srcu_struct_array *per_cpu_ref;
>  	struct mutex mutex;
> +	atomic_t hardluckref[2];
>  };
> 
> -#ifndef CONFIG_PREEMPT
> -#define srcu_barrier() barrier()
> -#else /* #ifndef CONFIG_PREEMPT */
> -#define srcu_barrier()
> -#endif /* #else #ifndef CONFIG_PREEMPT */
> +#define SRCU_INITIALIZER(srcu_name) {				\
> +	.mutex = __MUTEX_INITIALIZER(srcu_name.mutex),		\
> +	.hardluckref = {ATOMIC_INIT(0), ATOMIC_INIT(0)} }

Took this, very good.

> -int init_srcu_struct(struct srcu_struct *sp);
> -void cleanup_srcu_struct(struct srcu_struct *sp);
> -int srcu_read_lock(struct srcu_struct *sp) __acquires(sp);
> -void srcu_read_unlock(struct srcu_struct *sp, int idx) __releases(sp);
> -void synchronize_srcu(struct srcu_struct *sp);
> -long srcu_batches_completed(struct srcu_struct *sp);
> +extern void init_srcu_struct(struct srcu_struct *sp);
> +extern void cleanup_srcu_struct(struct srcu_struct *sp);
> +extern int srcu_read_lock(struct srcu_struct *sp) __acquires(sp);
> +extern void srcu_read_unlock(struct srcu_struct *sp, int idx) __releases(sp);
> +extern void synchronize_srcu(struct srcu_struct *sp);
> +extern long srcu_batches_completed(struct srcu_struct *sp);
> +extern int srcu_readers_active(struct srcu_struct *sp);

Took this as well.

>  #endif
> Index: usb-2.6/kernel/srcu.c
> ===================================================================
> --- usb-2.6.orig/kernel/srcu.c
> +++ usb-2.6/kernel/srcu.c
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
> +	return sap;
> +}
> +
>  /**
>   * init_srcu_struct - initialize a sleep-RCU structure
>   * @sp: structure to initialize.
> @@ -42,12 +54,13 @@
>   * to any other function.  Each srcu_struct represents a separate domain
>   * of SRCU protection.
>   */
> -int init_srcu_struct(struct srcu_struct *sp)
> +void init_srcu_struct(struct srcu_struct *sp)
>  {
>  	sp->completed = 0;
>  	mutex_init(&sp->mutex);
> -	sp->per_cpu_ref = alloc_percpu(struct srcu_struct_array);
> -	return (sp->per_cpu_ref ? 0 : -ENOMEM);
> +	sp->per_cpu_ref = alloc_srcu_struct_percpu();
> +	atomic_set(&sp->hardluckref[0], 0);
> +	atomic_set(&sp->hardluckref[1], 0);
>  }

Nack -- the caller is free to ignore the error return, but should be
able to detect it in case the caller is unable to tolerate the overhead
of running in hardluckref mode, perhaps instead choosing to fail a
user-level request in order to try to reduce memory pressure.

I did update the comment to say that you can use SRCU_INITIALIZER()
instead.

>  /*
> @@ -58,11 +71,14 @@ int init_srcu_struct(struct srcu_struct
>  static int srcu_readers_active_idx(struct srcu_struct *sp, int idx)
>  {
>  	int cpu;
> +	struct srcu_struct_array *sap;
>  	int sum;
> 
> -	sum = 0;
> -	for_each_possible_cpu(cpu)
> -		sum += per_cpu_ptr(sp->per_cpu_ref, cpu)->c[idx];
> +	sum = atomic_read(&sp->hardluckref[idx]);
> +	sap = rcu_dereference(sp->per_cpu_ref);
> +	if (likely(sap != NULL))
> +		for_each_possible_cpu(cpu)
> +			sum += per_cpu_ptr(sap, cpu)->c[idx];
>  	return sum;
>  }

Took the initialization based on hardluckref rather than adding it in
at the end, good!

> @@ -94,7 +110,8 @@ void cleanup_srcu_struct(struct srcu_str
>  	WARN_ON(sum);  /* Leakage unless caller handles error. */
>  	if (sum != 0)
>  		return;
> -	free_percpu(sp->per_cpu_ref);
> +	if (sp->per_cpu_ref != NULL)
> +		free_percpu(sp->per_cpu_ref);
>  	sp->per_cpu_ref = NULL;
>  }
> 
> @@ -102,19 +119,37 @@ void cleanup_srcu_struct(struct srcu_str
>   * srcu_read_lock - register a new reader for an SRCU-protected structure.
>   * @sp: srcu_struct in which to register the new reader.
>   *
> - * Counts the new reader in the appropriate per-CPU element of the
> - * srcu_struct.  Must be called from process context.
> + * Counts the new reader in the appropriate per-CPU element of @sp.
> + * Must be called from process context.

Good -- took the "@sp".

>   * Returns an index that must be passed to the matching srcu_read_unlock().
> + * The index is mapped to negative numbers if the per-cpu array in @sp
> + * is not and cannot be allocated.
>   */
>  int srcu_read_lock(struct srcu_struct *sp)
>  {
>  	int idx;
> +	struct srcu_struct_array *sap;
> +
> +	if (unlikely(sp->per_cpu_ref == NULL &&
> +			mutex_trylock(&sp->mutex))) {
> +		if (sp->per_cpu_ref == NULL)
> +			sp->per_cpu_ref = alloc_srcu_struct_percpu();
> +		mutex_unlock(&sp->mutex);
> +	}
> 
>  	preempt_disable();
>  	idx = sp->completed & 0x1;
>  	barrier();  /* ensure compiler looks -once- at sp->completed. */
> -	per_cpu_ptr(sp->per_cpu_ref, smp_processor_id())->c[idx]++;
> -	srcu_barrier();  /* ensure compiler won't misorder critical section. */
> +	sap = rcu_dereference(sp->per_cpu_ref);
> +	if (likely(sap != NULL)) {
> +		per_cpu_ptr(sap, smp_processor_id())->c[idx]++;
> +		smp_mb();
> +	} else {
> +		atomic_inc(&sp->hardluckref[idx]);
> +		smp_mb__after_atomic_inc();
> +		idx = -1 - idx;
> +	}
>  	preempt_enable();
>  	return idx;
>  }

Good restructuring -- took this, though I restricted the unlikely() to
cover only the comparison to NULL, since the mutex_trylock() has a
reasonable chance of success assuming that the read path has substantial
overhead from other sources.

> @@ -131,10 +166,16 @@ int srcu_read_lock(struct srcu_struct *s
>   */
>  void srcu_read_unlock(struct srcu_struct *sp, int idx)
>  {
> -	preempt_disable();
> -	srcu_barrier();  /* ensure compiler won't misorder critical section. */
> -	per_cpu_ptr(sp->per_cpu_ref, smp_processor_id())->c[idx]--;
> -	preempt_enable();
> +	if (likely(idx >= 0)) {
> +		smp_mb();
> +		preempt_disable();
> +		per_cpu_ptr(rcu_dereference(sp->per_cpu_ref),
> +			    smp_processor_id())->c[idx]--;
> +		preempt_enable();
> +	} else {
> +		smp_mb__before_atomic_dec();
> +		atomic_dec(&sp->hardluckref[-1 - idx]);
> +	}
>  }

I took the moving smp_mb() out from under preempt_disable().
I left the "return" -- same number of lines either way.
I don't see any changes in sign compared to what I had, FWIW.

>  /**
> @@ -158,6 +199,11 @@ void synchronize_srcu(struct srcu_struct
>  	idx = sp->completed;
>  	mutex_lock(&sp->mutex);
> 
> +	/* Initialize if not already initialized. */
> +
> +	if (sp->per_cpu_ref == NULL)
> +		sp->per_cpu_ref = alloc_srcu_struct_percpu();
> +
>  	/*
>  	 * Check to see if someone else did the work for us while we were
>  	 * waiting to acquire the lock.  We need -two- advances of
> @@ -168,71 +214,35 @@ void synchronize_srcu(struct srcu_struct
>  	 * either (1) wait for two or (2) supply the second ourselves.
>  	 */
> 
> -	if ((sp->completed - idx) >= 2) {
> -		mutex_unlock(&sp->mutex);
> -		return;
> -	}
> +	if ((sp->completed - idx) >= 2)
> +		goto done;

I don't see the benefit of gathering all the mutex_unlock()s together.
If the unwinding was more complicated, I would take this change, however.

> -	synchronize_sched();  /* Force memory barrier on all CPUs. */
> +	smp_mb();  /* ensure srcu_read_lock() sees prior change first! */
> +	idx = sp->completed & 0x1;
> 
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
> +#ifdef	SMP__STORE_MB_LOAD_WORKS	/* The fast path */
> +	if (srcu_readers_active_idx(sp, idx) == 0)
> +		goto done;
> +#endif

I still don't trust this one.  I would trust it a bit more if it were
srcu_readers_active() rather than srcu_readers_active_idx(), but even
then I suspect that external synchronization is required.  Or is there
something that I am missing that makes it safe in face of the sequence
of events that you, Oleg, and I were discussing?

For the moment, this optimization should be done by the caller, and
should be prominently commented.

							Thanx, Paul

> -	idx = sp->completed & 0x1;
>  	sp->completed++;
> -
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
> +done:
>  	mutex_unlock(&sp->mutex);
>  }
> 
> 
