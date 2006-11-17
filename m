Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755512AbWKQHDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512AbWKQHDF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 02:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755513AbWKQHDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 02:03:05 -0500
Received: from pool-71-111-72-250.ptldor.dsl-w.verizon.net ([71.111.72.250]:27655
	"EHLO IBM-8EC8B5596CA.beaverton.ibm.com") by vger.kernel.org
	with ESMTP id S1755512AbWKQHDC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 02:03:02 -0500
Date: Thu, 16 Nov 2006 22:51:28 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linus Torvalds <torvalds@osdl.org>, Thomas Gleixner <tglx@timesys.com>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>, David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, jens.axboe@oracle.com,
       manfred@colorfullife.com, oleg@tv-sign.ru
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061117065128.GA5452@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <Pine.LNX.4.64.0611161414580.3349@woody.osdl.org> <Pine.LNX.4.44L0.0611162148360.24994-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0611162148360.24994-100000@netrider.rowland.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2006 at 10:06:25PM -0500, Alan Stern wrote:
> On Thu, 16 Nov 2006, Linus Torvalds wrote:
> 
> > 
> > 
> > On Thu, 16 Nov 2006, Alan Stern wrote:
> > > On Thu, 16 Nov 2006, Linus Torvalds wrote:
> > > >
> > > > Paul, it would be _really_ nice to have some way to just initialize 
> > > > that SRCU thing statically. This kind of crud is just crazy.
> > > 
> > > I looked into this back when SRCU was first added.  It's essentially 
> > > impossible to do it, because the per-cpu memory allocation & usage APIs 
> > > are completely different for the static and the dynamic cases.
> > 
> > I don't think that's how you'd want to do it.
> > 
> > There's no way to do an initialization of a percpu allocation statically. 
> > That's pretty obvious.
> 
> Hmmm...  What about DEFINE_PER_CPU in include/asm-generic/percpu.h 
> combined with setup_per_cpu_areas() in init/main.c?  So long as you want 
> all the CPUs to start with the same initial values, it should work.
> 
> > What I'd suggest instead, is to make the allocation dynamic, and make it 
> > inside the srcu functions (kind of like I did now, but I did it at a 
> > higher level).
> > 
> > Doing it at the high level was trivial right now, but we may well end up 
> > hitting this problem again if people start using SRCU more. Right now I 
> > suspect the cpufreq notifier is the only thing that uses SRCU, and it 
> > already showed this problem with SRCU initializers.
> > 
> > So I was more thinking about moving my "one special case high level hack" 
> > down lower, down to the SRCU level, so that we'll never see _more_ of 
> > those horrible hacks. We'll still have the hacky thing, but at least it 
> > will be limited to a single place - the SRCU code itself.
> 
> Another possible approach (but equally disgusting) is to use this static 
> allocation approach, and have the SRCU structure include both a static and 
> a dynamic percpu pointer together with a flag indicating which should be 
> used.

I am actually taking some suggestions you made some months ago.  At the
time, I rejected them because they injected extra branches into the
fastpath.  However, recent experience indicates that you (Alan Stern)
were right and I was wrong -- turns out that the update-side overhead
cannot be so lightly disregarded, which forces memory barriers (but
neither atomics nor cache misses) into the fastpath.  If some application
ends up being provably inconvenienced by the read-side overhead, they old
implementation can be re-introduced under a different name or some such.

So, here is my current plan:

o	Add NULL checks on srcu_struct_array to srcu_read_lock(),
	srcu_read_unlock(), and synchronize_srcu.  These will
	acquire the mutex and attempt to initialize.  If out
	of memory, they will use the new hardluckref field.

o	Add memory barriers to srcu_read_lock() and srcu_read_unlock().

o	Also add a memory barrier or two to synchronize_srcu(), which,
	in combination with those in srcu_read_lock() and srcu_read_unlock(),
	permit removing two of the three synchronize_sched() calls
	in synchronize_srcu(), decreasing its latency by roughly
	a factor of three.

	This change should have the added benefit of making
	synchronize_srcu() much easier to understand.

o	I left out the super-fastpath synchronize_srcu() because
	after sleeping on it, it scared me silly.  Might be OK,
	but needs careful thought.  The fastpath is of the form:

	if (srcu_readers_active(sp) == 0) {
		smp_mb();
		return;
	}

	prior to the mutex_lock() in synchronize_srcu().

Attached is a patch that compiles, but probably goes down in flames
otherwise.

Thoughts?

						Thanx, Paul

 include/linux/srcu.h |    7 ---
 kernel/srcu.c        |  111 +++++++++++++++++++++++----------------------------
 2 files changed, 53 insertions(+), 65 deletions(-)

diff -urpNa -X dontdiff linux-2.6.19-rc5/include/linux/srcu.h linux-2.6.19-rc5-dsrcu/include/linux/srcu.h
--- linux-2.6.19-rc5/include/linux/srcu.h	2006-11-07 18:24:20.000000000 -0800
+++ linux-2.6.19-rc5-dsrcu/include/linux/srcu.h	2006-11-16 21:40:03.000000000 -0800
@@ -35,14 +35,9 @@ struct srcu_struct {
 	int completed;
 	struct srcu_struct_array *per_cpu_ref;
 	struct mutex mutex;
+	int hardluckref;
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
diff -urpNa -X dontdiff linux-2.6.19-rc5/kernel/srcu.c linux-2.6.19-rc5-dsrcu/kernel/srcu.c
--- linux-2.6.19-rc5/kernel/srcu.c	2006-11-07 18:24:20.000000000 -0800
+++ linux-2.6.19-rc5-dsrcu/kernel/srcu.c	2006-11-16 22:40:33.000000000 -0800
@@ -34,6 +34,14 @@
 #include <linux/smp.h>
 #include <linux/srcu.h>
 
+/*
+ * Initialize the per-CPU array, returning the pointer.
+ */
+static inline struct srcu_struct_array *alloc_srcu_struct_percpu(void)
+{
+	return alloc_percpu(struct srcu_struct_array);
+}
+
 /**
  * init_srcu_struct - initialize a sleep-RCU structure
  * @sp: structure to initialize.
@@ -46,7 +54,8 @@ int init_srcu_struct(struct srcu_struct 
 {
 	sp->completed = 0;
 	mutex_init(&sp->mutex);
-	sp->per_cpu_ref = alloc_percpu(struct srcu_struct_array);
+	sp->per_cpu_ref = alloc_srcu_struct_percpu();
+	sp->hardluckref = 0;
 	return (sp->per_cpu_ref ? 0 : -ENOMEM);
 }
 
@@ -61,9 +70,10 @@ static int srcu_readers_active_idx(struc
 	int sum;
 
 	sum = 0;
-	for_each_possible_cpu(cpu)
-		sum += per_cpu_ptr(sp->per_cpu_ref, cpu)->c[idx];
-	return sum;
+	if (likely(sp->per_cpu_ref != NULL))
+		for_each_possible_cpu(cpu)
+			sum += per_cpu_ptr(sp->per_cpu_ref, cpu)->c[idx];
+	return sum + sp->hardluckref;
 }
 
 /**
@@ -76,7 +86,9 @@ static int srcu_readers_active_idx(struc
  */
 int srcu_readers_active(struct srcu_struct *sp)
 {
-	return srcu_readers_active_idx(sp, 0) + srcu_readers_active_idx(sp, 1);
+	return srcu_readers_active_idx(sp, 0) +
+	       srcu_readers_active_idx(sp, 1) -
+	       sp->hardluckref;  /* No one will ever care, but... */
 }
 
 /**
@@ -94,7 +106,8 @@ void cleanup_srcu_struct(struct srcu_str
 	WARN_ON(sum);  /* Leakage unless caller handles error. */
 	if (sum != 0)
 		return;
-	free_percpu(sp->per_cpu_ref);
+	if (sp->per_cpu_ref != NULL)
+		free_percpu(sp->per_cpu_ref);
 	sp->per_cpu_ref = NULL;
 }
 
@@ -105,6 +118,7 @@ void cleanup_srcu_struct(struct srcu_str
  * Counts the new reader in the appropriate per-CPU element of the
  * srcu_struct.  Must be called from process context.
  * Returns an index that must be passed to the matching srcu_read_unlock().
+ * The index is -1 if the srcu_struct is not and cannot be initialized.
  */
 int srcu_read_lock(struct srcu_struct *sp)
 {
@@ -112,11 +126,24 @@ int srcu_read_lock(struct srcu_struct *s
 
 	preempt_disable();
 	idx = sp->completed & 0x1;
-	barrier();  /* ensure compiler looks -once- at sp->completed. */
-	per_cpu_ptr(sp->per_cpu_ref, smp_processor_id())->c[idx]++;
-	srcu_barrier();  /* ensure compiler won't misorder critical section. */
+	if (likely(sp->per_cpu_ref != NULL)) {
+		barrier();  /* ensure compiler looks -once- at sp->completed. */
+		per_cpu_ptr(rcu_dereference(sp->per_cpu_ref),
+			    smp_processor_id())->c[idx]++;
+		smp_mb();
+		preempt_enable();
+		return idx;
+	}
 	preempt_enable();
-	return idx;
+	mutex_lock(&sp->mutex);
+	sp->per_cpu_ref = alloc_srcu_struct_percpu();
+	if (sp->per_cpu_ref == NULL) {
+		sp->hardluckref++;
+		mutex_unlock(&sp->mutex);
+		return -1;
+	}
+	mutex_unlock(&sp->mutex);
+	return srcu_read_lock(sp);
 }
 
 /**
@@ -131,10 +158,16 @@ int srcu_read_lock(struct srcu_struct *s
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
+		per_cpu_ptr(sp->per_cpu_ref, smp_processor_id())->c[idx]--;
+		preempt_enable();
+		return;
+	}
+	mutex_lock(&sp->mutex);
+	sp->hardluckref--;
+	mutex_unlock(&sp->mutex);
 }
 
 /**
@@ -173,65 +206,25 @@ void synchronize_srcu(struct srcu_struct
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
