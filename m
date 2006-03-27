Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWC0IH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWC0IH0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 03:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWC0IHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 03:07:25 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:15793 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750781AbWC0IHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 03:07:25 -0500
Date: Mon, 27 Mar 2006 00:07:41 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH -rt, RFC] rid rcu_read_lock() and _unlock() of common-case memory barriers
Message-ID: <20060327080741.GA8150@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Another step towards lighter-weight rcu_read_lock() and rcu_read_unlock()
for PREEMPT_RCU.  Removes both atomic operations and memory barriers in
the common case.  Further work in progress to remove them in -all- cases,
so probably not worth applying this one.

This patch relies on the fact that only the first and last RCU read-side
critical sections really need the memory barriers.  This means that the
memory barriers can be associated with grace-period detection rather
than with RCU read-side critical sections, which is a win in the usual
case where there are far more RCU read-side critical sections than there
are grace periods.

Signed-off-by: <paulmck@us.ibm.com>

 include/linux/sched.h |    1 
 kernel/rcupreempt.c   |  114 ++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 107 insertions(+), 8 deletions(-)

diff -urpNa -X dontdiff linux-2.6.15-rt16-splitPREEMPT_RCU/include/linux/sched.h linux-2.6.15-rt16-sPR-optmb/include/linux/sched.h
--- linux-2.6.15-rt16-splitPREEMPT_RCU/include/linux/sched.h	2006-03-15 22:10:19.000000000 -0800
+++ linux-2.6.15-rt16-sPR-optmb/include/linux/sched.h	2006-03-17 11:27:53.000000000 -0800
@@ -893,6 +893,7 @@ struct task_struct {
 	int rcu_read_lock_nesting;
 	atomic_t *rcu_flipctr1;
 	atomic_t *rcu_flipctr2;
+	int rcu_read_lock_cpu;
 #endif
 #ifdef CONFIG_SCHEDSTATS
 	struct sched_info sched_info;
diff -urpNa -X dontdiff linux-2.6.15-rt16-splitPREEMPT_RCU/kernel/rcupreempt.c linux-2.6.15-rt16-sPR-optmb/kernel/rcupreempt.c
--- linux-2.6.15-rt16-splitPREEMPT_RCU/kernel/rcupreempt.c	2006-02-24 11:19:50.000000000 -0800
+++ linux-2.6.15-rt16-sPR-optmb/kernel/rcupreempt.c	2006-03-17 14:35:26.000000000 -0800
@@ -92,6 +92,7 @@ struct rcu_data {
 	atomic_t	n_rcu_try_flip_e1;
 	long		n_rcu_try_flip_e2;
 	long		n_rcu_try_flip_e3;
+	long		n_rcu_try_flip_e4;
 #endif /* #ifdef CONFIG_RCU_STATS */
 };
 struct rcu_ctrlblk {
@@ -106,6 +107,15 @@ static struct rcu_ctrlblk rcu_ctrlblk = 
 static DEFINE_PER_CPU(atomic_t [2], rcu_flipctr) =
 	{ ATOMIC_INIT(0), ATOMIC_INIT(0) };
 
+enum rcu_mb_flag_values {
+	rcu_mb_done,		/* Steady/initial state, no mb()s required. */
+				/* Only GP detector can update. */
+	rcu_mb_needed		/* Flip just completed, need an mb(). */
+				/* Only corresponding CPU can update. */
+};
+
+static DEFINE_PER_CPU(enum rcu_mb_flag_values, rcu_mb_flag) = rcu_mb_done;
+
 /*
  * Return the number of RCU batches processed thus far.  Useful
  * for debug and statistics.
@@ -127,14 +137,22 @@ rcu_read_lock(void)
 		/*
 		 * Outermost nesting of rcu_read_lock(), so atomically
 		 * increment the current counter for the current CPU.
+		 * However, if the counter is zero, there can be no
+		 * race with another decrement.  In addition, since
+		 * we have interrupts disabled, there can be no race
+		 * with another increment.
 		 */
 
 		flipctr = rcu_ctrlblk.completed & 0x1;
 		smp_read_barrier_depends();
 		current->rcu_flipctr1 = &(__get_cpu_var(rcu_flipctr)[flipctr]);
-		/* Can optimize to non-atomic on fastpath, but start simple. */
-		atomic_inc(current->rcu_flipctr1);
-		smp_mb__after_atomic_inc();  /* might optimize out... */
+		current->rcu_read_lock_cpu = smp_processor_id();
+		if (atomic_read(current->rcu_flipctr1) == 0) {
+			atomic_set(current->rcu_flipctr1,
+				   atomic_read(current->rcu_flipctr1) + 1);
+		} else {
+			atomic_inc(current->rcu_flipctr1);
+		}
 		if (unlikely(flipctr != (rcu_ctrlblk.completed & 0x1))) {
 
 			/*
@@ -154,7 +172,6 @@ rcu_read_lock(void)
 				&(__get_cpu_var(rcu_flipctr)[!flipctr]);
 			/* Can again optimize to non-atomic on fastpath. */
 			atomic_inc(current->rcu_flipctr2);
-			smp_mb__after_atomic_inc();  /* might optimize out... */
 		}
 	}
 	raw_local_irq_restore(oldirq);
@@ -170,13 +187,22 @@ rcu_read_unlock(void)
 
 		/*
 		 * Just atomically decrement whatever we incremented.
+		 * However, if the counter is equal to one, there can
+		 * be no other concurrent decrement.  In addition, since
+		 * we have interrupts disabled, there can be no
+		 * concurrent increment.
 		 * Might later want to awaken some task waiting for the
 		 * grace period to complete, but keep it simple for the
 		 * moment.
 		 */
 
-		smp_mb__before_atomic_dec();
-		atomic_dec(current->rcu_flipctr1);
+		if ((atomic_read(current->rcu_flipctr1) == 1) &&
+		    (current->rcu_read_lock_cpu == smp_processor_id())) {
+			atomic_set(current->rcu_flipctr1,
+				   atomic_read(current->rcu_flipctr1) - 1);
+		} else {
+			atomic_dec(current->rcu_flipctr1);
+		}
 		current->rcu_flipctr1 = NULL;
 		if (unlikely(current->rcu_flipctr2 != NULL)) {
 			atomic_dec(current->rcu_flipctr2);
@@ -274,22 +300,93 @@ rcu_try_flip(void)
 		}
 	}
 
-	/* Do the flip. */
+	/* Check that all CPUs have done their end-of-GP smp_mb(). */
+
+	for_each_cpu(cpu) {
+		if (per_cpu(rcu_mb_flag, cpu) != rcu_mb_done) {
+#ifdef CONFIG_RCU_STATS
+			rcu_data.n_rcu_try_flip_e4++;
+#endif /* #ifdef CONFIG_RCU_STATS */
+			spin_unlock_irqrestore(&rcu_ctrlblk.fliplock, oldirq);
+			return;
+		}
+	}
+
+	/*
+	 * Do the flip.
+	 *
+	 * But first do a memory barrier so that all prior checks
+	 * happen before the counter is updated.
+	 */
 
 	smp_mb();
 	rcu_ctrlblk.completed++;
 
+	/*
+	 * Need another memory barrier so that other CPUs see the new
+	 * counter value before they see the subsequent change of all
+	 * the rcu_mb_flag instances to rcu_mb_needed.
+	 */
+
+	smp_mb();
+	for_each_cpu(cpu)
+		per_cpu(rcu_mb_flag, cpu) = rcu_mb_needed;
+
 #ifdef CONFIG_RCU_STATS
 	rcu_data.n_rcu_try_flip3++;
 #endif /* #ifdef CONFIG_RCU_STATS */
 	spin_unlock_irqrestore(&rcu_ctrlblk.fliplock, oldirq);
 }
 
+/*
+ * Check to see if this CPU needs to do a memory barrier in order to
+ * ensure that any prior RCU read-side critical sections have committed
+ * their counter manipulations and critical-section memory references
+ * before declaring the grace period to be completed.
+ */
+
+void
+rcu_check_mb(int cpu)
+{
+	int flipctr = rcu_ctrlblk.completed & 0x1;
+
+	if ((__get_cpu_var(rcu_mb_flag) == rcu_mb_needed) &&
+	    (atomic_read(&__get_cpu_var(rcu_flipctr)[flipctr]) == 0)) {
+
+		/*
+		 * We might need a memory barrier, but the above condition
+		 * is racy.  So, do a memory barrier, and then recheck.
+		 * Note that the value of this CPU's rcu_mb_flag cannot
+		 * change, since only this CPU is permitted to change it.
+		 * If this code ever becomes callable from multiple CPUs
+		 * (like when we need to speed up grace-period detection),
+		 * then rcu_mb_flag will need to be updated atomically.
+		 */
+
+		smp_mb();
+		flipctr = rcu_ctrlblk.completed & 0x1;
+		if (atomic_read(&__get_cpu_var(rcu_flipctr)[flipctr]) == 0)
+			__get_cpu_var(rcu_mb_flag) = rcu_mb_done;
+	}
+
+	/*
+	 * We can mistakenly get here if we race with a counter flip,
+	 * but this race is harmless, as we will see the new value
+	 * at the next scheduling-clock interrupt.
+	 */
+}
+
+/*
+ * This function is called periodically on each CPU in hardware interrupt
+ * context.
+ */
+
 void
 rcu_check_callbacks(int cpu, int user)
 {
 	unsigned long oldirq;
 
+	rcu_check_mb(cpu);
 	if (rcu_ctrlblk.completed == rcu_data.completed) {
 		rcu_try_flip();
 		if (rcu_ctrlblk.completed == rcu_data.completed) {
@@ -416,7 +513,7 @@ int rcu_read_proc_data(char *page)
 	return sprintf(page,
 		       "ggp=%ld lgp=%ld rcc=%ld\n"
 		       "na=%ld nl=%ld wa=%ld wl=%ld da=%ld dl=%ld dr=%ld di=%d\n"
-		       "rtf1=%d rtf2=%ld rtf3=%ld rtfe1=%d rtfe2=%ld rtfe3=%ld\n",
+		       "rtf1=%d rtf2=%ld rtf3=%ld rtfe1=%d rtfe2=%ld rtfe3=%ld rtfe4=%ld\n",
 
 		       rcu_ctrlblk.completed,
 		       rcu_data.completed,
@@ -436,6 +533,7 @@ int rcu_read_proc_data(char *page)
 		       rcu_data.n_rcu_try_flip3,
 		       atomic_read(&rcu_data.n_rcu_try_flip_e1),
 		       rcu_data.n_rcu_try_flip_e2,
+		       rcu_data.n_rcu_try_flip_e3,
 		       rcu_data.n_rcu_try_flip_e3);
 }
 
