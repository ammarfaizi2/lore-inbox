Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263053AbVGNQOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbVGNQOX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 12:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbVGNQOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 12:14:20 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:44192 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263057AbVGNQNt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 12:13:49 -0400
Date: Thu, 14 Jul 2005 09:14:08 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu, dipankar@in.ibm.com, rostedt@goodmis.org, bhuey@lnxw.com,
       shemminger@osdl.org, rusty@au1.ibm.com
Subject: [RFC,PATCH] RCU and CONFIG_PREEMPT_RT semi-sane patch
Message-ID: <20050714161408.GA1712@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The attached patch passed about 36 hours of torture test on each of two
4-CPU x86 machines (about 100 passes through the torture-test script), so
am officially declaring it to be semi-sane.  That said, on eight runs of
kernbench+LTP (also on 4-CPU x86 machines), only six passed, and the other
two hung in LTP (but both did make it through five rounds of kernbench).
So there are still some problems in there somewhere.  The hangs were such
that I got no debug info of any sort :-/ , so will be continuing testing.

But this patch might be acceptable to courageous users of the
CONFIG_PREEMPT_RT patch who aren't too concerned about SMP performance
and scalability.  ;-)

The following caveats still apply:

o	Still have heavyweight operations in rcu_read_lock() and
	rcu_read_unlock().  Will work on removing the atomic_inc()
	and atomic_dec() first, with the memory barriers later.

o	Global callback queues result in poor SMP performance.  On
	the list to fix.  Will likely require handling CPU hotplug
	(current code is too stupid to need to care about CPU hotplug).

o	Grace-period-detection code is probably too aggressive, but will
	worry about that later.  This will interact with OOM on systems
	with small memories.

o	There are likely still bugs.  Which might cause occasional
	hangs.  ;-)

o	Applies against V0.7.51-27 of Ingo's patch.

However, the code (but not the patch) should work in a stock kernel
as well as in the CONFIG_PREEMPT_RT environment.  Thanks to Steve
Rostedt and Bill Huey for their help with this!

Thoughts?

						Thanx, Paul

PS.  Will be on travel next week, so response time may be a bit slow.

Signed-off-by: <paulmck@us.ibm.com>

diff -urpN -X dontdiff linux-2.6.12-realtime-preempt-V0.7.51-27/fs/proc/proc_misc.c linux-2.6.12-realtime-preempt-V0.7.51-27-ctrRCU/fs/proc/proc_misc.c
--- linux-2.6.12-realtime-preempt-V0.7.51-27/fs/proc/proc_misc.c	2005-07-13 14:52:43.000000000 -0700
+++ linux-2.6.12-realtime-preempt-V0.7.51-27-ctrRCU/fs/proc/proc_misc.c	2005-07-13 14:54:10.000000000 -0700
@@ -599,6 +599,38 @@ void create_seq_entry(char *name, mode_t
 		entry->proc_fops = f;
 }
 
+#ifdef CONFIG_RCU_STATS
+int rcu_read_proc(char *page, char **start, off_t off,
+		  int count, int *eof, void *data)
+{
+	int len;
+	extern int rcu_read_proc_data(char *page);
+
+	len = rcu_read_proc_data(page);
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+
+int rcu_read_proc_gp(char *page, char **start, off_t off,
+		     int count, int *eof, void *data)
+{
+	int len;
+	extern int rcu_read_proc_gp_data(char *page);
+
+	len = rcu_read_proc_gp_data(page);
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+
+int rcu_read_proc_ptrs(char *page, char **start, off_t off,
+		       int count, int *eof, void *data)
+{
+	int len;
+	extern int rcu_read_proc_ptrs_data(char *page);
+
+	len = rcu_read_proc_ptrs_data(page);
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+#endif /* #ifdef CONFIG_RCU_STATS */
+
 void __init proc_misc_init(void)
 {
 	struct proc_dir_entry *entry;
@@ -621,6 +653,11 @@ void __init proc_misc_init(void)
 		{"cmdline",	cmdline_read_proc},
 		{"locks",	locks_read_proc},
 		{"execdomains",	execdomains_read_proc},
+#ifdef CONFIG_RCU_STATS
+		{"rcustats",	rcu_read_proc},
+		{"rcugp",	rcu_read_proc_gp},
+		{"rcuptrs",	rcu_read_proc_ptrs},
+#endif /* #ifdef CONFIG_RCU_STATS */
 		{NULL,}
 	};
 	for (p = simple_ones; p->name; p++)
diff -urpN -X dontdiff linux-2.6.12-realtime-preempt-V0.7.51-27/include/linux/rcupdate.h linux-2.6.12-realtime-preempt-V0.7.51-27-ctrRCU/include/linux/rcupdate.h
--- linux-2.6.12-realtime-preempt-V0.7.51-27/include/linux/rcupdate.h	2005-07-13 14:52:43.000000000 -0700
+++ linux-2.6.12-realtime-preempt-V0.7.51-27-ctrRCU/include/linux/rcupdate.h	2005-07-13 14:54:10.000000000 -0700
@@ -59,6 +59,7 @@ struct rcu_head {
 } while (0)
 
 
+#ifndef CONFIG_PREEMPT_RCU
 
 /* Global control variables for rcupdate callback mechanism. */
 struct rcu_ctrlblk {
@@ -209,6 +210,18 @@ static inline int rcu_pending(int cpu)
 # define rcu_read_unlock preempt_enable
 #endif
 
+#else /* #ifndef CONFIG_PREEMPT_RCU */
+
+#define rcu_qsctr_inc(cpu)
+#define rcu_bh_qsctr_inc(cpu)
+#define call_rcu_bh(head, rcu) call_rcu(head, rcu)
+
+extern void rcu_read_lock(void);
+extern void rcu_read_unlock(void);
+extern int rcu_pending(int cpu);
+
+#endif /* #else #ifndef CONFIG_PREEMPT_RCU */
+
 /*
  * So where is rcu_write_lock()?  It does not exist, as there is no
  * way for writers to lock out RCU readers.  This is a feature, not
@@ -230,16 +243,22 @@ static inline int rcu_pending(int cpu)
  * can use just rcu_read_lock().
  *
  */
-//#define rcu_read_lock_bh()	local_bh_disable()
+#ifndef CONFIG_PREEMPT_RCU
+#define rcu_read_lock_bh()	local_bh_disable()
+#else /* #ifndef CONFIG_PREEMPT_RCU */
 #define rcu_read_lock_bh()	{ rcu_read_lock(); local_bh_disable(); }
+#endif /* #else #ifndef CONFIG_PREEMPT_RCU */
 
 /*
  * rcu_read_unlock_bh - marks the end of a softirq-only RCU critical section
  *
  * See rcu_read_lock_bh() for more information.
  */
-//#define rcu_read_unlock_bh()	local_bh_enable()
+#ifndef CONFIG_PREEMPT_RCU
+#define rcu_read_unlock_bh()	local_bh_enable()
+#else /* #ifndef CONFIG_PREEMPT_RCU */
 #define rcu_read_unlock_bh()	{ local_bh_enable(); rcu_read_unlock(); }
+#endif /* #else #ifndef CONFIG_PREEMPT_RCU */
 
 /**
  * rcu_dereference - fetch an RCU-protected pointer in an
@@ -288,7 +307,11 @@ static inline int rcu_pending(int cpu)
  * synchronize_kernel() API.  In contrast, synchronize_rcu() only
  * guarantees that rcu_read_lock() sections will have completed.
  */
+#ifndef CONFIG_PREEMPT_RCU
 #define synchronize_sched() synchronize_rcu()
+#else /* #ifndef CONFIG_PREEMPT_RCU */
+extern void synchronize_sched(void);
+#endif /* #else #ifndef CONFIG_PREEMPT_RCU */
 
 extern void rcu_init(void);
 extern void rcu_check_callbacks(int cpu, int user);
diff -urpN -X dontdiff linux-2.6.12-realtime-preempt-V0.7.51-27/include/linux/sched.h linux-2.6.12-realtime-preempt-V0.7.51-27-ctrRCU/include/linux/sched.h
--- linux-2.6.12-realtime-preempt-V0.7.51-27/include/linux/sched.h	2005-07-13 14:52:43.000000000 -0700
+++ linux-2.6.12-realtime-preempt-V0.7.51-27-ctrRCU/include/linux/sched.h	2005-07-13 14:54:10.000000000 -0700
@@ -917,7 +917,8 @@ struct task_struct {
 #endif
 #ifdef CONFIG_PREEMPT_RCU
 	int rcu_read_lock_nesting;
-	struct rcu_data *rcu_data;
+	atomic_t *rcu_flipctr1;
+	atomic_t *rcu_flipctr2;
 #endif
 };
 
diff -urpN -X dontdiff linux-2.6.12-realtime-preempt-V0.7.51-27/kernel/Kconfig.preempt linux-2.6.12-realtime-preempt-V0.7.51-27-ctrRCU/kernel/Kconfig.preempt
--- linux-2.6.12-realtime-preempt-V0.7.51-27/kernel/Kconfig.preempt	2005-07-13 14:52:43.000000000 -0700
+++ linux-2.6.12-realtime-preempt-V0.7.51-27-ctrRCU/kernel/Kconfig.preempt	2005-07-13 14:55:48.000000000 -0700
@@ -127,10 +127,23 @@ config PREEMPT_RCU
 	  This option reduces the latency of the kernel by making certain
 	  RCU sections preemptible. Normally RCU code is non-preemptible, if
 	  this option is selected then read-only RCU sections become
-	  preemptible. This helps latency, but may increase memory utilization.
+	  preemptible. This helps latency, but may expose bugs due to
+	  now-naive assumptions about each RCU read-side critical section
+	  remaining on a given CPU through its execution.
 
 	  Say N if you are unsure.
 
+config RCU_STATS
+	bool "/proc stats for preemptible RCU read-side critical sections"
+	depends on PREEMPT_RCU
+	default y
+	help
+	  This option provides /proc stats to provide debugging info for
+	  the preemptible realtime RCU implementation.
+
+	  Say Y here if you want to see RCU stats in /proc
+	  Say N if you are unsure.
+
 config SPINLOCK_BKL
 	bool "Old-Style Big Kernel Lock"
 	depends on (PREEMPT || SMP) && !PREEMPT_RT
diff -urpN -X dontdiff linux-2.6.12-realtime-preempt-V0.7.51-27/kernel/rcupdate.c linux-2.6.12-realtime-preempt-V0.7.51-27-ctrRCU/kernel/rcupdate.c
--- linux-2.6.12-realtime-preempt-V0.7.51-27/kernel/rcupdate.c	2005-07-13 14:52:43.000000000 -0700
+++ linux-2.6.12-realtime-preempt-V0.7.51-27-ctrRCU/kernel/rcupdate.c	2005-07-13 16:57:46.000000000 -0700
@@ -47,6 +47,46 @@
 #include <linux/rcupdate.h>
 #include <linux/cpu.h>
 
+struct rcu_synchronize {
+	struct rcu_head head;
+	struct completion completion;
+};
+
+/* Because of FASTCALL declaration of complete, we use this wrapper */
+static void wakeme_after_rcu(struct rcu_head  *head)
+{
+	struct rcu_synchronize *rcu;
+
+	rcu = container_of(head, struct rcu_synchronize, head);
+	complete(&rcu->completion);
+}
+
+/**
+ * synchronize_rcu - wait until a grace period has elapsed.
+ *
+ * Control will return to the caller some time after a full grace
+ * period has elapsed, in other words after all currently executing RCU
+ * read-side critical sections have completed.  RCU read-side critical
+ * sections are delimited by rcu_read_lock() and rcu_read_unlock(),
+ * and may be nested.
+ *
+ * If your read-side code is not protected by rcu_read_lock(), do -not-
+ * use synchronize_rcu().
+ */
+void synchronize_rcu(void)
+{
+	struct rcu_synchronize rcu;
+
+	init_completion(&rcu.completion);
+	/* Will wake me after RCU finished */
+	call_rcu(&rcu.head, wakeme_after_rcu);
+
+	/* Wait for it */
+	wait_for_completion(&rcu.completion);
+}
+
+#ifndef CONFIG_PREEMPT_RCU
+
 /* Definition for rcupdate control block. */
 struct rcu_ctrlblk rcu_ctrlblk = 
 	{ .cur = -300, .completed = -300 };
@@ -429,44 +469,6 @@ void __init rcu_init(void)
 	register_cpu_notifier(&rcu_nb);
 }
 
-struct rcu_synchronize {
-	struct rcu_head head;
-	struct completion completion;
-};
-
-/* Because of FASTCALL declaration of complete, we use this wrapper */
-static void wakeme_after_rcu(struct rcu_head  *head)
-{
-	struct rcu_synchronize *rcu;
-
-	rcu = container_of(head, struct rcu_synchronize, head);
-	complete(&rcu->completion);
-}
-
-/**
- * synchronize_rcu - wait until a grace period has elapsed.
- *
- * Control will return to the caller some time after a full grace
- * period has elapsed, in other words after all currently executing RCU
- * read-side critical sections have completed.  RCU read-side critical
- * sections are delimited by rcu_read_lock() and rcu_read_unlock(),
- * and may be nested.
- *
- * If your read-side code is not protected by rcu_read_lock(), do -not-
- * use synchronize_rcu().
- */
-void synchronize_rcu(void)
-{
-	struct rcu_synchronize rcu;
-
-	init_completion(&rcu.completion);
-	/* Will wake me after RCU finished */
-	call_rcu(&rcu.head, wakeme_after_rcu);
-
-	/* Wait for it */
-	wait_for_completion(&rcu.completion);
-}
-
 /*
  * Deprecated, use synchronize_rcu() or synchronize_sched() instead.
  */
@@ -481,38 +483,365 @@ EXPORT_SYMBOL(call_rcu_bh);  /* WARNING:
 EXPORT_SYMBOL_GPL(synchronize_rcu);
 EXPORT_SYMBOL(synchronize_kernel);  /* WARNING: GPL-only in April 2006. */
 
-#ifdef CONFIG_PREEMPT_RCU
+#else /* #ifndef CONFIG_PREEMPT_RCU */
+
+#ifndef CONFIG_PREEMPT_RT
+
+#define raw_spinlock_t spinlock_t
+#define RAW_SPIN_LOCK_UNLOCKED SPIN_LOCK_UNLOCKED
 
-void rcu_read_lock(void)
+#endif /* #ifndef CONFIG_PREEMPT_RT */
+
+struct rcu_data {
+	raw_spinlock_t	lock;
+	long		batch;
+	struct tasklet_struct rcu_tasklet;
+	struct rcu_head *nextlist;
+	struct rcu_head **nexttail;
+	struct rcu_head *waitlist;
+	struct rcu_head **waittail;
+	struct rcu_head *donelist;
+	struct rcu_head **donetail;
+#ifdef CONFIG_RCU_STATS
+	long		n_next_length;
+	long		n_next_add;
+	long		n_wait_length;
+	long		n_wait_add;
+	long		n_done_length;
+	long		n_done_add;
+	long		n_done_remove;
+	atomic_t	n_done_invoked;
+	long		n_rcu_check_callbacks;
+	atomic_t	n_synchronize_rcu;
+#endif /* #ifdef CONFIG_RCU_STATS */
+};
+struct rcu_ctrlblk {
+	raw_spinlock_t	fliplock;
+	long		batch;
+};
+static struct rcu_data rcu_data;
+static struct rcu_ctrlblk rcu_ctrlblk = {
+	.fliplock = RAW_SPIN_LOCK_UNLOCKED,
+	.batch = 0,
+};
+static DEFINE_PER_CPU(atomic_t [2], rcu_flipctr) =
+	{ ATOMIC_INIT(0), ATOMIC_INIT(0) };
+
+void
+rcu_read_lock(void)
 {
+	int flipctr;
+	unsigned long oldirq;
+
+	local_irq_save(oldirq);	/* @@@ inside "if" for PREEMPT_RT... */
 	if (current->rcu_read_lock_nesting++ == 0) {
-		current->rcu_data = &get_cpu_var(rcu_data);
-		atomic_inc(&current->rcu_data->active_readers);
-		smp_mb__after_atomic_inc();
-		put_cpu_var(rcu_data);
+
+		/*
+		 * Outermost nesting of rcu_read_lock(), so atomically
+		 * increment the current counter for the current CPU.
+		 */
+
+		flipctr = rcu_ctrlblk.batch & 0x1;
+		smp_read_barrier_depends();
+		current->rcu_flipctr1 = &(__get_cpu_var(rcu_flipctr)[flipctr]);
+		/* Can optimize to non-atomic on fastpath, but start simple. */
+		atomic_inc(current->rcu_flipctr1);
+		smp_mb__after_atomic_inc();  /* might optimize out... */
+		if (unlikely(flipctr != (rcu_ctrlblk.batch & 0x1))) {
+
+			/*
+			 * We raced with grace-period processing (flip).
+			 * Although we cannot be preempted here, there
+			 * could be interrupts, ECC errors and the like,
+			 * so just nail down both sides of the rcu_flipctr
+			 * array for the duration of our RCU read-side
+			 * critical section, preventing a second flip
+			 * from racing with us.  At some point, it would
+			 * be safe to decrement one of the counters, but
+			 * we have no way of knowing when that would be.
+			 * So just decrement them both in rcu_read_unlock().
+			 */
+
+			current->rcu_flipctr2 =
+				&(__get_cpu_var(rcu_flipctr)[!flipctr]);
+			/* Can again optimize to non-atomic on fastpath. */
+			atomic_inc(current->rcu_flipctr2);
+			smp_mb__after_atomic_inc();  /* might optimize out... */
+		}
 	}
+	local_irq_restore(oldirq);  /*@@@ should be able to precede. */
 }
-EXPORT_SYMBOL(rcu_read_lock);
 
-void rcu_read_unlock(void)
+void
+rcu_read_unlock(void)
 {
-	int cpu;
+	unsigned long oldirq;
 
+	local_irq_save(oldirq);  /* @@@ should be able to reverse... */
 	if (--current->rcu_read_lock_nesting == 0) {
-		atomic_dec(&current->rcu_data->active_readers);
-		smp_mb__after_atomic_dec();
+
 		/*
-		 * Check whether we have reached quiescent state.
-		 * Note! This is only for the local CPU, not for
-		 * current->rcu_data's CPU [which typically is the
-		 * current CPU, but may also be another CPU].
+		 * Just atomically decrement whatever we incremented.
+		 * Might later want to awaken some task waiting for the
+		 * grace period to complete, but keep it simple for the
+		 * moment.
 		 */
-		cpu = get_cpu();
-		rcu_qsctr_inc(cpu);
-		put_cpu();
+
+		smp_mb__before_atomic_dec();
+		atomic_dec(current->rcu_flipctr1);
+		current->rcu_flipctr1 = NULL;
+		if (unlikely(current->rcu_flipctr2 != NULL)) {
+			atomic_dec(current->rcu_flipctr2);
+			current->rcu_flipctr2 = NULL;
+		}
 	}
+	local_irq_restore(oldirq);
 }
-EXPORT_SYMBOL(rcu_read_unlock);
 
-#endif
+static void
+__rcu_advance_callbacks(void)
+{
+
+	if (rcu_data.batch != rcu_ctrlblk.batch) {
+		if (rcu_data.waitlist != NULL) {
+			*rcu_data.donetail = rcu_data.waitlist;
+			rcu_data.donetail = rcu_data.waittail;
+#ifdef CONFIG_RCU_STATS
+			rcu_data.n_done_length += rcu_data.n_wait_length;
+			rcu_data.n_done_add += rcu_data.n_wait_length;
+			rcu_data.n_wait_length = 0;
+#endif /* #ifdef CONFIG_RCU_STATS */
+		}
+		if (rcu_data.nextlist != NULL) {
+			rcu_data.waitlist = rcu_data.nextlist;
+			rcu_data.waittail = rcu_data.nexttail;
+			rcu_data.nextlist = NULL;
+			rcu_data.nexttail = &rcu_data.nextlist;
+#ifdef CONFIG_RCU_STATS
+			rcu_data.n_wait_length += rcu_data.n_next_length;
+			rcu_data.n_wait_add += rcu_data.n_next_length;
+			rcu_data.n_next_length = 0;
+#endif /* #ifdef CONFIG_RCU_STATS */
+		} else {
+			rcu_data.waitlist = NULL;
+			rcu_data.waittail = &rcu_data.waitlist;
+		}
+		rcu_data.batch = rcu_ctrlblk.batch;
+	}
+}
+
+/*
+ * Attempt a single flip of the counters.  Remember, a single flip does
+ * -not- constitute a grace period.  Instead, the interval between
+ * a pair of consecutive flips is a grace period.
+ *
+ * If anyone is nuts enough to run this CONFIG_PREEMPT_RCU implementation
+ * on a large SMP, they might want to use a hierarchical organization of
+ * the per-CPU-counter pairs.
+ */
+static void
+rcu_try_flip(void)
+{
+	int cpu;
+	long flipctr;
+
+	flipctr = rcu_data.batch;
+	if (unlikely(!spin_trylock(&rcu_ctrlblk.fliplock)))
+		return;
+	if (unlikely(flipctr != rcu_data.batch)) {
+	
+		/* Our work is done!  ;-) */
+
+		spin_unlock(&rcu_ctrlblk.fliplock);
+		return;
+	}
+	flipctr &= 0x1;
+
+	/*
+	 * Check for completion of all RCU read-side critical sections
+	 * that started prior to the previous flip.
+	 */
+
+	for_each_cpu(cpu) {
+		if (atomic_read(&per_cpu(rcu_flipctr, cpu)[!flipctr]) != 0) {
+			spin_unlock(&rcu_ctrlblk.fliplock);
+			return;
+		}
+	}
+
+	/* Do the flip. */
+
+	smp_mb();
+	rcu_ctrlblk.batch++;
+
+	
+	spin_unlock(&rcu_ctrlblk.fliplock);
+}
+
+void
+rcu_check_callbacks(int cpu, int user)
+{
+
+	rcu_try_flip();
+	spin_lock(&rcu_data.lock);
+#ifdef CONFIG_RCU_STATS
+	rcu_data.n_rcu_check_callbacks++;
+#endif /* #ifdef CONFIG_RCU_STATS */
+	__rcu_advance_callbacks();
+	if (rcu_data.donelist == NULL) {
+		spin_unlock(&rcu_data.lock);
+	} else {
+		spin_unlock(&rcu_data.lock);
+		tasklet_schedule(&rcu_data.rcu_tasklet);
+	}
+}
+
+static
+void rcu_process_callbacks(unsigned long data)
+{
+	unsigned long flags;
+	struct rcu_head *next, *list;
+
+	spin_lock_irqsave(&rcu_data.lock, flags);
+	list = rcu_data.donelist;
+	if (list == NULL) {
+		spin_unlock_irqrestore(&rcu_data.lock, flags);
+		return;
+	}
+	rcu_data.donelist = NULL;
+	rcu_data.donetail = &rcu_data.donelist;
+#ifdef CONFIG_RCU_STATS
+	rcu_data.n_done_remove += rcu_data.n_done_length;
+	rcu_data.n_done_length = 0;
+#endif /* #ifdef CONFIG_RCU_STATS */
+	spin_unlock_irqrestore(&rcu_data.lock, flags);
+	while (list) {
+		next = list->next;
+		list->func(list);
+		list = next;
+#ifdef CONFIG_RCU_STATS
+		atomic_inc(&rcu_data.n_done_invoked);
+#endif /* #ifdef CONFIG_RCU_STATS */
+	}
+}
+
+void fastcall
+call_rcu(struct rcu_head *head,
+	 void (*func)(struct rcu_head *rcu))
+{
+	unsigned long flags;
+
+	head->func = func;
+	head->next = NULL;
+	spin_lock_irqsave(&rcu_data.lock, flags);
+	__rcu_advance_callbacks();
+	*rcu_data.nexttail = head;
+	rcu_data.nexttail = &head->next;
+#ifdef CONFIG_RCU_STATS
+	rcu_data.n_next_add++;
+	rcu_data.n_next_length++;
+#endif /* #ifdef CONFIG_RCU_STATS */
+	spin_unlock_irqrestore(&rcu_data.lock, flags);
+}
+
+/*
+ * Crude hack, reduces but does not eliminate possibility of failure.
+ * Needs to wait for all CPUs to pass through a -voluntary- context
+ * switch to eliminate possibility of failure.  (Maybe just crank
+ * priority down...)
+ */
+void
+synchronize_sched(void)
+{
+	cpumask_t oldmask;
+	int cpu;
+
+	if (sched_getaffinity(0, &oldmask) < 0) {
+		oldmask = cpu_possible_map; 
+	}
+	for_each_cpu(cpu) {
+		sched_setaffinity(0, cpumask_of_cpu(cpu));
+		schedule();
+	}
+	sched_setaffinity(0, oldmask);
+}
+
+int
+rcu_pending(int cpu)
+{
+	return (rcu_data.donelist != NULL ||
+		rcu_data.waitlist != NULL ||
+		rcu_data.nextlist != NULL);
+}
+
+void __init rcu_init(void)
+{
+/*&&&&*/printk("WARNING: experimental RCU implementation.\n");
+	rcu_data.lock = RAW_SPIN_LOCK_UNLOCKED;
+	rcu_data.batch = 0;
+	rcu_data.nextlist = NULL;
+	rcu_data.nexttail = &rcu_data.nextlist;
+	rcu_data.waitlist = NULL;
+	rcu_data.waittail = &rcu_data.waitlist;
+	rcu_data.donelist = NULL;
+	rcu_data.donetail = &rcu_data.donelist;
+	tasklet_init(&rcu_data.rcu_tasklet, rcu_process_callbacks, 0UL);
+}
+
+/*
+ * Deprecated, use synchronize_rcu() or synchronize_sched() instead.
+ */
+void synchronize_kernel(void)
+{
+	synchronize_rcu();
+}
+
+#ifdef CONFIG_RCU_STATS
+int rcu_read_proc_data(char *page)
+{
+	return sprintf(page,
+		       "ggp=%ld lgp=%ld sr=%d rcc=%ld\n"
+		       "na=%ld nl=%ld wa=%ld wl=%ld dl=%ld dr=%ld di=%d\n",
+
+		       rcu_ctrlblk.batch,
+		       rcu_data.batch,
+		       atomic_read(&rcu_data.n_synchronize_rcu),
+		       rcu_data.n_rcu_check_callbacks,
+
+		       rcu_data.n_next_add,
+		       rcu_data.n_next_length,
+		       rcu_data.n_wait_add,
+		       rcu_data.n_wait_length,
+		       rcu_data.n_done_length,
+		       rcu_data.n_done_remove,
+		       atomic_read(&rcu_data.n_done_invoked));
+}
+
+int rcu_read_proc_gp_data(char *page)
+{
+	long oldgp = rcu_ctrlblk.batch;
+
+	synchronize_rcu();
+	return sprintf(page, "oldggp=%ld  newggp=%ld\n",
+		       oldgp, rcu_ctrlblk.batch);
+}
+
+int rcu_read_proc_ptrs_data(char *page)
+{
+	return sprintf(page,
+		       "nl=%p/%p nt=%p wl=%p/%p wt=%p dl=%p/%p dt=%p\n",
+		       &rcu_data.nextlist, rcu_data.nextlist, rcu_data.nexttail,
+		       &rcu_data.waitlist, rcu_data.waitlist, rcu_data.waittail,
+		       &rcu_data.donelist, rcu_data.donelist, rcu_data.donetail
+		      );
+}
+#endif /* #ifdef CONFIG_RCU_STATS */
+
+EXPORT_SYMBOL(call_rcu); /* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL_GPL(synchronize_rcu);
+EXPORT_SYMBOL_GPL(synchronize_sched);
+EXPORT_SYMBOL(rcu_read_lock);  /* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL(rcu_read_unlock);  /* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL(synchronize_kernel);  /* WARNING: Removal in April 2006. */
 
+#endif /* #else #ifndef CONFIG_PREEMPT_RCU */
