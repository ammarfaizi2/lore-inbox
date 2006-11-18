Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756103AbWKRA1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756103AbWKRA1i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 19:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756104AbWKRA1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 19:27:37 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:47756 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1756103AbWKRA1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 19:27:36 -0500
Date: Fri, 17 Nov 2006 16:28:45 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Jens Axboe <jens.axboe@oracle.com>, Alan Stern <stern@rowland.harvard.edu>,
       Linus Torvalds <torvalds@osdl.org>, Thomas Gleixner <tglx@timesys.com>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>, David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, manfred@colorfullife.com
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061118002845.GF2632@us.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <Pine.LNX.4.64.0611161414580.3349@woody.osdl.org> <Pine.LNX.4.44L0.0611162148360.24994-100000@netrider.rowland.org> <20061117065128.GA5452@us.ibm.com> <20061117092925.GT7164@kernel.dk> <20061117183945.GA367@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117183945.GA367@oleg>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 09:39:45PM +0300, Oleg Nesterov wrote:
> Paul E. McKenney wrote:
> >
> >  int srcu_read_lock(struct srcu_struct *sp)
> >  {
> > @@ -112,11 +126,24 @@ int srcu_read_lock(struct srcu_struct *s
> >  
> >  	preempt_disable();
> >  	idx = sp->completed & 0x1;
> > -	barrier();  /* ensure compiler looks -once- at sp->completed. */
> > -	per_cpu_ptr(sp->per_cpu_ref, smp_processor_id())->c[idx]++;
> > -	srcu_barrier();  /* ensure compiler won't misorder critical section. */
> > +	if (likely(sp->per_cpu_ref != NULL)) {
> > +		barrier();  /* ensure compiler looks -once- at sp->completed. */
> > +		per_cpu_ptr(rcu_dereference(sp->per_cpu_ref),
> > +			    smp_processor_id())->c[idx]++;
> > +		smp_mb();
> > +		preempt_enable();
> > +		return idx;
> > +	}
> >  	preempt_enable();
> > -	return idx;
> > +	mutex_lock(&sp->mutex);
> > +	sp->per_cpu_ref = alloc_srcu_struct_percpu();
> 
> We should re-check sp->per_cpu_ref != NULL after taking sp->mutex,
> it was probably allocated by another thread.

Good catch!!!

> >  void srcu_read_unlock(struct srcu_struct *sp, int idx)
> >  {
> > -	preempt_disable();
> > -	srcu_barrier();  /* ensure compiler won't misorder critical section. */
> > -	per_cpu_ptr(sp->per_cpu_ref, smp_processor_id())->c[idx]--;
> > -	preempt_enable();
> > +	if (likely(idx != -1)) {
> > +		preempt_disable();
> > +		smp_mb();
> > +		per_cpu_ptr(sp->per_cpu_ref, smp_processor_id())->c[idx]--;
> > +		preempt_enable();
> > +		return;
> > +	}
> > +	mutex_lock(&sp->mutex);
> > +	sp->hardluckref--;
> > +	mutex_unlock(&sp->mutex);
> >  }
> 
> I think this is deadlockable, synchronize_srcu() does
> 
>   	while (srcu_readers_active_idx(sp, idx))
>   		schedule_timeout_interruptible(1);
> 
> under sp->mutex, so the loop above may spin forever while the reader
> waits for sp->mutex in srcu_read_unlock(sp, -1).

Indeed it is!  This requires a nested reader, so that the outer reader
blocks synchronize_srcu() and synchronize_srcu() blocks the inner
reader -- but that is legal.

So I made hardluckref be an atomic_t, and changed the mutex_lock()
in srcu_read_lock() be a mutex_trylock() -- which cannot block, right?

I also added the srcu_readers_active() declaration to srcu.h for Jens.
Oleg, any thoughts about Jens's optimization?  He would code something
like:

	if (srcu_readers_active(&my_srcu))
		synchronize_srcu();
	else
		smp_mb();

However, he is doing ordered I/O requests rather than protecting data
structures.

Changes:

o	Make hardluckref be an atomic_t.

o	Put the now-needed rcu_dereference()s for per_cpu_ref
	(used to be constant...).

o	Moved to mutex_trylock() in srcu_read_lock() to avoid Oleg's
	deadlock scenario.

o	Added per_cpu_ref NULL rechecks to avoid the Oleg's memory
	leak (and worse).

o	Added srcu_readers_active() to srcu.h.

Still untested (aside from Jens's runs).

Signed-off-by: paulmck@linux.vnet.ibm.com (AKA paulmck@us.ibm.com)

---


 include/linux/srcu.h |    8 ---
 kernel/srcu.c        |  130 +++++++++++++++++++++++++++------------------------
 2 files changed, 73 insertions(+), 65 deletions(-)

diff -urpNa -X dontdiff linux-2.6.19-rc5/include/linux/srcu.h linux-2.6.19-rc5-dsrcu/include/linux/srcu.h
--- linux-2.6.19-rc5/include/linux/srcu.h	2006-11-17 13:54:15.000000000 -0800
+++ linux-2.6.19-rc5-dsrcu/include/linux/srcu.h	2006-11-17 15:14:07.000000000 -0800
@@ -35,19 +35,15 @@ struct srcu_struct {
 	int completed;
 	struct srcu_struct_array *per_cpu_ref;
 	struct mutex mutex;
+	atomic_t hardluckref;
 };
 
-#ifndef CONFIG_PREEMPT
-#define srcu_barrier() barrier()
-#else /* #ifndef CONFIG_PREEMPT */
-#define srcu_barrier()
-#endif /* #else #ifndef CONFIG_PREEMPT */
-
 int init_srcu_struct(struct srcu_struct *sp);
 void cleanup_srcu_struct(struct srcu_struct *sp);
 int srcu_read_lock(struct srcu_struct *sp) __acquires(sp);
 void srcu_read_unlock(struct srcu_struct *sp, int idx) __releases(sp);
 void synchronize_srcu(struct srcu_struct *sp);
 long srcu_batches_completed(struct srcu_struct *sp);
+int srcu_readers_active(struct srcu_struct *sp);
 
 #endif
diff -urpNa -X dontdiff linux-2.6.19-rc5/kernel/srcu.c linux-2.6.19-rc5-dsrcu/kernel/srcu.c
--- linux-2.6.19-rc5/kernel/srcu.c	2006-11-17 13:54:17.000000000 -0800
+++ linux-2.6.19-rc5-dsrcu/kernel/srcu.c	2006-11-17 14:15:06.000000000 -0800
@@ -34,6 +34,18 @@
 #include <linux/smp.h>
 #include <linux/srcu.h>
 
+/*
+ * Initialize the per-CPU array, returning the pointer.
+ */
+static inline struct srcu_struct_array *alloc_srcu_struct_percpu(void)
+{
+	struct srcu_struct_array *sap;
+
+	sap = alloc_percpu(struct srcu_struct_array);
+	smp_wmb();
+	return (sap);
+}
+
 /**
  * init_srcu_struct - initialize a sleep-RCU structure
  * @sp: structure to initialize.
@@ -46,7 +58,8 @@ int init_srcu_struct(struct srcu_struct 
 {
 	sp->completed = 0;
 	mutex_init(&sp->mutex);
-	sp->per_cpu_ref = alloc_percpu(struct srcu_struct_array);
+	sp->per_cpu_ref = alloc_srcu_struct_percpu();
+	atomic_set(&sp->hardluckref, 0);
 	return (sp->per_cpu_ref ? 0 : -ENOMEM);
 }
 
@@ -58,12 +71,15 @@ int init_srcu_struct(struct srcu_struct 
 static int srcu_readers_active_idx(struct srcu_struct *sp, int idx)
 {
 	int cpu;
+	struct srcu_struct_array *sap;
 	int sum;
 
 	sum = 0;
-	for_each_possible_cpu(cpu)
-		sum += per_cpu_ptr(sp->per_cpu_ref, cpu)->c[idx];
-	return sum;
+	sap = rcu_dereference(sp->per_cpu_ref);
+	if (likely(sap != NULL))
+		for_each_possible_cpu(cpu)
+			sum += per_cpu_ptr(sap, cpu)->c[idx];
+	return sum + atomic_read(&sp->hardluckref);
 }
 
 /**
@@ -76,7 +92,9 @@ static int srcu_readers_active_idx(struc
  */
 int srcu_readers_active(struct srcu_struct *sp)
 {
-	return srcu_readers_active_idx(sp, 0) + srcu_readers_active_idx(sp, 1);
+	return srcu_readers_active_idx(sp, 0) +
+	       srcu_readers_active_idx(sp, 1) -
+	       atomic_read(&sp->hardluckref);  /* No one will care, but... */
 }
 
 /**
@@ -94,7 +112,8 @@ void cleanup_srcu_struct(struct srcu_str
 	WARN_ON(sum);  /* Leakage unless caller handles error. */
 	if (sum != 0)
 		return;
-	free_percpu(sp->per_cpu_ref);
+	if (sp->per_cpu_ref != NULL)
+		free_percpu(sp->per_cpu_ref);
 	sp->per_cpu_ref = NULL;
 }
 
@@ -105,18 +124,39 @@ void cleanup_srcu_struct(struct srcu_str
  * Counts the new reader in the appropriate per-CPU element of the
  * srcu_struct.  Must be called from process context.
  * Returns an index that must be passed to the matching srcu_read_unlock().
+ * The index is -1 if the srcu_struct is not and cannot be initialized.
  */
 int srcu_read_lock(struct srcu_struct *sp)
 {
 	int idx;
+	struct srcu_struct_array *sap;
 
 	preempt_disable();
 	idx = sp->completed & 0x1;
-	barrier();  /* ensure compiler looks -once- at sp->completed. */
-	per_cpu_ptr(sp->per_cpu_ref, smp_processor_id())->c[idx]++;
-	srcu_barrier();  /* ensure compiler won't misorder critical section. */
+	sap = rcu_dereference(sp->per_cpu_ref);
+	if (likely(sap != NULL)) {
+		barrier();  /* ensure compiler looks -once- at sp->completed. */
+		per_cpu_ptr(rcu_dereference(sap),
+			    smp_processor_id())->c[idx]++;
+		smp_mb();
+		preempt_enable();
+		return idx;
+	}
+	if (mutex_trylock(&sp->mutex)) {
+		preempt_enable();
+		if (sp->per_cpu_ref == NULL)
+			sp->per_cpu_ref = alloc_srcu_struct_percpu();
+		if (sp->per_cpu_ref == NULL) {
+			atomic_inc(&sp->hardluckref);
+			mutex_unlock(&sp->mutex);
+			return -1;
+		}
+		mutex_unlock(&sp->mutex);
+		return srcu_read_lock(sp);
+	}
 	preempt_enable();
-	return idx;
+	atomic_inc(&sp->hardluckref);
+	return -1;
 }
 
 /**
@@ -131,10 +171,17 @@ int srcu_read_lock(struct srcu_struct *s
  */
 void srcu_read_unlock(struct srcu_struct *sp, int idx)
 {
-	preempt_disable();
-	srcu_barrier();  /* ensure compiler won't misorder critical section. */
-	per_cpu_ptr(sp->per_cpu_ref, smp_processor_id())->c[idx]--;
-	preempt_enable();
+	if (likely(idx != -1)) {
+		preempt_disable();
+		smp_mb();
+		per_cpu_ptr(rcu_dereference(sp->per_cpu_ref),
+			    smp_processor_id())->c[idx]--;
+		preempt_enable();
+		return;
+	}
+	mutex_lock(&sp->mutex);
+	atomic_dec(&sp->hardluckref);
+	mutex_unlock(&sp->mutex);
 }
 
 /**
@@ -158,6 +205,11 @@ void synchronize_srcu(struct srcu_struct
 	idx = sp->completed;
 	mutex_lock(&sp->mutex);
 
+	/* Initialize if not already initialized. */
+
+	if (sp->per_cpu_ref == NULL)
+		sp->per_cpu_ref = alloc_srcu_struct_percpu();
+
 	/*
 	 * Check to see if someone else did the work for us while we were
 	 * waiting to acquire the lock.  We need -two- advances of
@@ -173,65 +225,25 @@ void synchronize_srcu(struct srcu_struct
 		return;
 	}
 
-	synchronize_sched();  /* Force memory barrier on all CPUs. */
-
-	/*
-	 * The preceding synchronize_sched() ensures that any CPU that
-	 * sees the new value of sp->completed will also see any preceding
-	 * changes to data structures made by this CPU.  This prevents
-	 * some other CPU from reordering the accesses in its SRCU
-	 * read-side critical section to precede the corresponding
-	 * srcu_read_lock() -- ensuring that such references will in
-	 * fact be protected.
-	 *
-	 * So it is now safe to do the flip.
-	 */
-
+	smp_mb();  /* ensure srcu_read_lock() sees prior change first! */
 	idx = sp->completed & 0x1;
 	sp->completed++;
 
-	synchronize_sched();  /* Force memory barrier on all CPUs. */
+	synchronize_sched();
 
 	/*
 	 * At this point, because of the preceding synchronize_sched(),
 	 * all srcu_read_lock() calls using the old counters have completed.
 	 * Their corresponding critical sections might well be still
 	 * executing, but the srcu_read_lock() primitives themselves
-	 * will have finished executing.
+	 * will have finished executing.  The "old" rank of counters
+	 * can therefore only decrease, never increase in value.
 	 */
 
 	while (srcu_readers_active_idx(sp, idx))
 		schedule_timeout_interruptible(1);
 
-	synchronize_sched();  /* Force memory barrier on all CPUs. */
-
-	/*
-	 * The preceding synchronize_sched() forces all srcu_read_unlock()
-	 * primitives that were executing concurrently with the preceding
-	 * for_each_possible_cpu() loop to have completed by this point.
-	 * More importantly, it also forces the corresponding SRCU read-side
-	 * critical sections to have also completed, and the corresponding
-	 * references to SRCU-protected data items to be dropped.
-	 *
-	 * Note:
-	 *
-	 *	Despite what you might think at first glance, the
-	 *	preceding synchronize_sched() -must- be within the
-	 *	critical section ended by the following mutex_unlock().
-	 *	Otherwise, a task taking the early exit can race
-	 *	with a srcu_read_unlock(), which might have executed
-	 *	just before the preceding srcu_readers_active() check,
-	 *	and whose CPU might have reordered the srcu_read_unlock()
-	 *	with the preceding critical section.  In this case, there
-	 *	is nothing preventing the synchronize_sched() task that is
-	 *	taking the early exit from freeing a data structure that
-	 *	is still being referenced (out of order) by the task
-	 *	doing the srcu_read_unlock().
-	 *
-	 *	Alternatively, the comparison with "2" on the early exit
-	 *	could be changed to "3", but this increases synchronize_srcu()
-	 *	latency for bulk loads.  So the current code is preferred.
-	 */
+	smp_mb();  /* must see critical section prior to srcu_read_unlock() */
 
 	mutex_unlock(&sp->mutex);
 }
