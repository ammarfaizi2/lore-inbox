Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVGLQdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVGLQdy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 12:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVGLQc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 12:32:27 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:19663 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261548AbVGLQaD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 12:30:03 -0400
Date: Tue, 12 Jul 2005 09:30:32 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu, dipankar@in.ibm.com, shemminger@osdl.org
Subject: PREEMPT/PREEMPT_RT question
Message-ID: <20050712163031.GA1323@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

OK, counter-flip RCU actually survives a pair of overnight runs on
CONFIG_PREEMPT running on 4-CPU machines, and also survives five
kernbenches and an LTP on another 4-CPU machine.  (Overnight-run script
later in this message, FWIW.)

So, time to get serious about a bit of code cleanup:

o	The heavyweight atomic operations in rcu_read_lock() and
	rcu_read_unlock() are not needed in UP kernels, since
	interrupts are disabled.

	Is there already something like smp_atomic_inc() and
	smp_atomic_dec() that generate atomic_inc()/atomic_dec() in
	SMP kernels, but ++/-- in UP kernels?  If not, any reasons
	not to add them, for example, as follows?

		#ifdef CONFIG_SMP
		#define smp_atomic_inc(v) atomic_inc(v)
		#define smp_atomic_dec(v) atomic_dec(v)
		#else /* #ifdef CONFIG_SMP */
		#define smp_atomic_inc(v) ((v)++)
		#define smp_atomic_dec(v) ((v)++)
		#endif /* #else #ifdef CONFIG_SMP */

	Since interrupts must be disabled for these to be safe,
	my guess is that I should define them locally in rcupdate.c.
	If there turns out to be a general need for them, they can
	be moved somewhere more public.

	Objections?

o	In order to get things to work in both CONFIG_PREEMPT and
	CONFIG_PREEMPT_RT, I ended up using the following:

		#ifdef CONFIG_PREEMPT_RT

		#define rcu_spinlock_t _raw_spinlock_t
		#define rcu_spin_lock(l, f) _raw_spin_lock(l)
		#define rcu_spin_trylock(l, f) _raw_spin_trylock(l)
		#define rcu_spin_unlock(l, f) _raw_spin_unlock(l)
		#define RCU_SPIN_LOCK_UNLOCKED RAW_SPIN_LOCK_UNLOCKED

		#else /* #ifdef CONFIG_PREEMPT_RT */

		#define rcu_spinlock_t spinlock_t
		#define rcu_spin_lock(l, f) spin_lock_irqsave(l, f)
		#define rcu_spin_trylock(l, f) spin_trylock_irqsave(l, f)
		#define rcu_spin_unlock(l, f) spin_unlock_irqrestore(l, f)
		#define RCU_SPIN_LOCK_UNLOCKED SPIN_LOCK_UNLOCKED

		#endif /* #else #ifdef CONFIG_PREEMPT_RT */

	Then using rcu_spin_lock() &c everywhere.  The problem is
	that (as near as I can tell) the only way to prevent interrupts 
	from running on the current CPU in CONFIG_PREEMPT kernels is
	to use the _irq spinlock primitives, but _raw_spin_lock() does
	the job in CONFIG_PREEMPT_RT (since interrupts are run in process
	context, right).  I could use _irq in both, but that would
	unnecessarily degrade interrupt latency in CONFIG_PREEMPT_RT.

	Suggestions???

Some remaining shortcomings of the current code:

o	Untested on CONFIG_PREEMPT_RT (working on this, suggestions
	for 4-CPU-stable CONFIG_PREEMPT_RT versions most welcome).

o	Uses atomic operations and memory barriers in the
	rcu_read_lock() and rcu_read_unlock() fastpaths.
	Getting rid of the atomic operations in UP is easy,
	in SMP in the common case is reasonably straightforward,
	getting rid of memory barriers is harder, but is likely
	doable.

o	Global callback management slows things down on SMP
	(need to move to per-CPU callback management).

o	Gross debug code needs pruning (working on this).

o	Current implementation is probably too aggressive about
	finishing out grace periods -- one of the machines
	averaged one grace period every 29 milliseconds over a
	15-hour time period.  This likely understates the
	aggressiveness, since the test is quite bursty.

o	Given the small amount testing, there are undoubtably
	more bugs.

All that aside, only a moderately severe degree of insanity is
required to run this code.

Improvements since last time:

o	Boots and runs reasonably reliably.

o	Got rid of the workqueue stuff, simplifying grace-period
	detection code.  Also allows synchronize_sched() to be
	common code between "classic" and realtime RCU
	implementations.

o	Enabled preemption in RCU read-side critical sections
	(even in CONFIG_PREEMPT kernels).

Test script (assumes that you have a linux-2.6.11.tar.bz2 file in
the current directory), relies on the fact that dcache's heavy use
of RCU:

	#!/bin/sh

	while :
	do
		i=0
		while expr $i '<' 10
		do
			tar -xjf linux-2.6.11.tar.bz2
			echo tar status $?
			mv linux-2.6.11 argh$i
			echo $i : `grep dentry_cache /proc/slabinfo`
			i=`expr $i + 1`
		done
		for i in argh[0-9]
		do
			rm -rf $i &
		done
		wait
		echo rm : `grep dentry_cache /proc/slabinfo`
	done

Current (ugly) patch:

Not-signed-off-by: <paulmck@us.ibm.com>

diff -urpN -X dontdiff linux-2.6.12-rc6/arch/i386/Kconfig linux-2.6.12-rc6-ctrRCU/arch/i386/Kconfig
--- linux-2.6.12-rc6/arch/i386/Kconfig	2005-06-17 16:34:16.000000000 -0700
+++ linux-2.6.12-rc6-ctrRCU/arch/i386/Kconfig	2005-07-11 10:50:47.000000000 -0700
@@ -523,6 +523,31 @@ config PREEMPT
 	  Say Y here if you are building a kernel for a desktop, embedded
 	  or real-time system.  Say N if you are unsure.
 
+config PREEMPT_RCU
+	bool "Preemptible RCU read-side critical sections"
+	depends on PREEMPT
+	default y
+	help
+	  This option reduces the latency of the kernel when reacting to
+	  real-time or interactive events by allowing a low priority process to
+	  be preempted even if it is in an RCU read-side critical section.
+	  This allows applications to run more reliably even when the system is
+	  under load.
+
+	  Say Y here if you enjoy debugging random oopses.
+	  Say N if, for whatever reason, you want your kernel to actually work.
+
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
 config PREEMPT_BKL
 	bool "Preempt The Big Kernel Lock"
 	depends on PREEMPT
diff -urpN -X dontdiff linux-2.6.12-rc6/fs/proc/proc_misc.c linux-2.6.12-rc6-ctrRCU/fs/proc/proc_misc.c
--- linux-2.6.12-rc6/fs/proc/proc_misc.c	2005-06-17 16:35:03.000000000 -0700
+++ linux-2.6.12-rc6-ctrRCU/fs/proc/proc_misc.c	2005-07-11 11:46:04.000000000 -0700
@@ -549,6 +549,38 @@ void create_seq_entry(char *name, mode_t
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
@@ -571,6 +603,11 @@ void __init proc_misc_init(void)
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
diff -urpN -X dontdiff linux-2.6.12-rc6/include/linux/rcupdate.h linux-2.6.12-rc6-ctrRCU/include/linux/rcupdate.h
--- linux-2.6.12-rc6/include/linux/rcupdate.h	2005-06-17 16:35:13.000000000 -0700
+++ linux-2.6.12-rc6-ctrRCU/include/linux/rcupdate.h	2005-07-01 14:55:35.000000000 -0700
@@ -59,6 +59,7 @@ struct rcu_head {
 } while (0)
 
 
+#ifndef CONFIG_PREEMPT_RCU
 
 /* Global control variables for rcupdate callback mechanism. */
 struct rcu_ctrlblk {
@@ -192,6 +193,18 @@ static inline int rcu_pending(int cpu)
  */
 #define rcu_read_unlock()	preempt_enable()
 
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
@@ -213,14 +226,22 @@ static inline int rcu_pending(int cpu)
  * can use just rcu_read_lock().
  *
  */
+#ifndef CONFIG_PREEMPT_RCU
 #define rcu_read_lock_bh()	local_bh_disable()
+#else /* #ifndef CONFIG_PREEMPT_RCU */
+#define rcu_read_lock_bh()	{ rcu_read_lock(); local_bh_disable(); }
+#endif /* #else #ifndef CONFIG_PREEMPT_RCU */
 
 /*
  * rcu_read_unlock_bh - marks the end of a softirq-only RCU critical section
  *
  * See rcu_read_lock_bh() for more information.
  */
+#ifndef CONFIG_PREEMPT_RCU
 #define rcu_read_unlock_bh()	local_bh_enable()
+#else /* #ifndef CONFIG_PREEMPT_RCU */
+#define rcu_read_unlock_bh()	{ local_bh_enable(); rcu_read_unlock(); }
+#endif /* #else #ifndef CONFIG_PREEMPT_RCU */
 
 /**
  * rcu_dereference - fetch an RCU-protected pointer in an
@@ -269,7 +290,11 @@ static inline int rcu_pending(int cpu)
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
diff -urpN -X dontdiff linux-2.6.12-rc6/include/linux/sched.h linux-2.6.12-rc6-ctrRCU/include/linux/sched.h
--- linux-2.6.12-rc6/include/linux/sched.h	2005-06-17 16:35:13.000000000 -0700
+++ linux-2.6.12-rc6-ctrRCU/include/linux/sched.h	2005-06-22 17:25:49.000000000 -0700
@@ -740,6 +740,11 @@ struct task_struct {
 	nodemask_t mems_allowed;
 	int cpuset_mems_generation;
 #endif
+#ifdef CONFIG_PREEMPT_RCU
+	int rcu_read_lock_nesting;
+	atomic_t *rcu_flipctr1;
+	atomic_t *rcu_flipctr2;
+#endif
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
diff -urpN -X dontdiff linux-2.6.12-rc6/kernel/rcupdate.c linux-2.6.12-rc6-ctrRCU/kernel/rcupdate.c
--- linux-2.6.12-rc6/kernel/rcupdate.c	2005-06-17 16:35:15.000000000 -0700
+++ linux-2.6.12-rc6-ctrRCU/kernel/rcupdate.c	2005-07-11 16:27:10.000000000 -0700
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
@@ -429,42 +469,392 @@ void __init rcu_init(void)
 	register_cpu_notifier(&rcu_nb);
 }
 
-struct rcu_synchronize {
-	struct rcu_head head;
-	struct completion completion;
+/*
+ * Deprecated, use synchronize_rcu() or synchronize_sched() instead.
+ */
+void synchronize_kernel(void)
+{
+	synchronize_rcu();
+}
+
+module_param(maxbatch, int, 0);
+EXPORT_SYMBOL(call_rcu);  /* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL(call_rcu_bh);  /* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL_GPL(synchronize_rcu);
+EXPORT_SYMBOL(synchronize_kernel);  /* WARNING: GPL-only in April 2006. */
+
+#else /* #ifndef CONFIG_PREEMPT_RCU */
+
+#ifdef CONFIG_PREEMPT_RT
+
+#error "Hey!!!  This fails miserably even in straightforward testing!!!"
+
+#define rcu_spinlock_t _raw_spinlock_t
+#define rcu_spin_lock(l, f) _raw_spin_lock(l)
+#define rcu_spin_trylock(l, f) _raw_spin_trylock(l)
+#define rcu_spin_unlock(l, f) _raw_spin_unlock(l)
+#define RCU_SPIN_LOCK_UNLOCKED RAW_SPIN_LOCK_UNLOCKED
+
+#else /* #ifdef CONFIG_PREEMPT_RT */
+
+#define rcu_spinlock_t spinlock_t
+#define rcu_spin_lock(l, f) spin_lock_irqsave(l, f)
+#define rcu_spin_trylock(l, f) spin_trylock_irqsave(l, f)
+#define rcu_spin_unlock(l, f) spin_unlock_irqrestore(l, f)
+#define RCU_SPIN_LOCK_UNLOCKED SPIN_LOCK_UNLOCKED
+
+#endif /* #else #ifdef CONFIG_PREEMPT_RT */
+
+struct rcu_data {
+	rcu_spinlock_t	lock;
+	long		batch;
+	struct tasklet_struct rcu_tasklet;
+	struct rcu_head *nextlist;
+	struct rcu_head **nexttail;
+	struct rcu_head *waitlist;
+	struct rcu_head **waittail;
+	struct rcu_head *donelist;
+	struct rcu_head **donetail;
+	long		n_next_length;
+#ifdef CONFIG_RCU_STATS
+	long		n_next_add;
+	long		n_wait_length;
+	long		n_wait_add;
+	long		n_done_length;
+	long		n_done_add;
+	long		n_done_remove;
+	atomic_t	n_done_invoked;
+	long		n_rcu_process_callbacks;
+	long		n_rcu_check_callbacks;
+	long		n_rcu_advance_callbacks1;
+	long		n_rcu_advance_callbacks2;
+	long		n_rcu_advance_callbacks3;
+	long		n_rcu_advance_callbacks4;
+	long		n_rcu_advance_callbacks5;
+	atomic_t	n_synchronize_rcu;
+	atomic_t	n_synchronize_rcu_flip1; /*&&&&*/
+	atomic_t	n_synchronize_rcu_flip2; /*&&&&*/
+	atomic_t	n_synchronize_rcu_flip3; /*&&&&*/
+	atomic_t	n_synchronize_rcu_flip4; /*&&&&*/
+	long		n_synchronize_rcu_flip_early1;
+#endif /* #ifdef CONFIG_RCU_STATS */
+};
+struct rcu_ctrlblk {
+	spinlock_t	fliplock;
+	long		batch;
 };
+static struct rcu_data rcu_data;
+static struct rcu_ctrlblk rcu_ctrlblk = {
+	.fliplock = RCU_SPIN_LOCK_UNLOCKED,
+	.batch = 0,
+};
+static DEFINE_PER_CPU(atomic_t [2], rcu_flipctr) =
+	{ ATOMIC_INIT(0), ATOMIC_INIT(0) };
 
-/* Because of FASTCALL declaration of complete, we use this wrapper */
-static void wakeme_after_rcu(struct rcu_head  *head)
+void
+rcu_read_lock(void)
 {
-	struct rcu_synchronize *rcu;
+	int flipctr;
+	unsigned long oldirq;
 
-	rcu = container_of(head, struct rcu_synchronize, head);
-	complete(&rcu->completion);
+	local_irq_save(oldirq);	/* @@@ inside "if" for PREEMPT_RT... */
+	if (current->rcu_read_lock_nesting++ == 0) {
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
+	}
+#ifndef CONFIG_PREEMPT_RT
+	/* preempt_disable(); */
+#endif /* #ifndef CONFIG_PREEMPT_RT */
+	local_irq_restore(oldirq);  /*@@@ should be able to precede. */
+}
+
+void
+rcu_read_unlock(void)
+{
+#ifndef CONFIG_PREEMPT_RT
+	unsigned long oldirq;
+
+	local_irq_save(oldirq);  /* @@@ should be able to reverse... */
+	/* preempt_enable(); */
+#endif /* #ifndef CONFIG_PREEMPT_RT */
+	if (--current->rcu_read_lock_nesting == 0) {
+
+		/*
+		 * Just atomically decrement whatever we incremented.
+		 * Might later want to awaken some task waiting for the
+		 * grace period to complete, but keep it simple for the
+		 * moment.
+		 */
+
+		smp_mb__before_atomic_dec();
+		atomic_dec(current->rcu_flipctr1);
+		current->rcu_flipctr1 = NULL;
+		if (unlikely(current->rcu_flipctr2 != NULL)) {
+			atomic_dec(current->rcu_flipctr2);
+			current->rcu_flipctr2 = NULL;
+		}
+	}
+#ifndef CONFIG_PREEMPT_RT
+	local_irq_restore(oldirq);
+#endif /* #ifndef CONFIG_PREEMPT_RT */
+}
+
+static void
+__rcu_advance_callbacks(void)
+{
+
+#ifdef CONFIG_RCU_STATS
+	rcu_data.n_rcu_advance_callbacks1++;
+#endif /* #ifdef CONFIG_RCU_STATS */
+	if (rcu_data.batch != rcu_ctrlblk.batch) {
+#ifdef CONFIG_RCU_STATS
+		rcu_data.n_rcu_advance_callbacks2++;
+#endif /* #ifdef CONFIG_RCU_STATS */
+		if (rcu_data.waitlist != NULL) {
+#ifdef CONFIG_RCU_STATS
+			rcu_data.n_rcu_advance_callbacks3++;
+#endif /* #ifdef CONFIG_RCU_STATS */
+			*rcu_data.donetail = rcu_data.waitlist;
+			rcu_data.donetail = rcu_data.waittail;
+#ifdef CONFIG_RCU_STATS
+			rcu_data.n_done_length += rcu_data.n_wait_length;
+			rcu_data.n_done_add += rcu_data.n_wait_length;
+			rcu_data.n_wait_length = 0;
+#endif /* #ifdef CONFIG_RCU_STATS */
+		}
+		if (rcu_data.nextlist != NULL) {
+#ifdef CONFIG_RCU_STATS
+			rcu_data.n_rcu_advance_callbacks4++;
+#endif /* #ifdef CONFIG_RCU_STATS */
+			rcu_data.waitlist = rcu_data.nextlist;
+			rcu_data.waittail = rcu_data.nexttail;
+			rcu_data.nextlist = NULL;
+			rcu_data.nexttail = &rcu_data.nextlist;
+#ifdef CONFIG_RCU_STATS
+			rcu_data.n_wait_length += rcu_data.n_next_length;
+			rcu_data.n_wait_add += rcu_data.n_next_length;
+#endif /* #ifdef CONFIG_RCU_STATS */
+			rcu_data.n_next_length = 0;
+		} else {
+#ifdef CONFIG_RCU_STATS
+			rcu_data.n_rcu_advance_callbacks5++;
+#endif /* #ifdef CONFIG_RCU_STATS */
+			rcu_data.waitlist = NULL;
+			rcu_data.waittail = &rcu_data.waitlist;
+		}
+		rcu_data.batch = rcu_ctrlblk.batch;
+	}
 }
 
-/**
- * synchronize_rcu - wait until a grace period has elapsed.
- *
- * Control will return to the caller some time after a full grace
- * period has elapsed, in other words after all currently executing RCU
- * read-side critical sections have completed.  RCU read-side critical
- * sections are delimited by rcu_read_lock() and rcu_read_unlock(),
- * and may be nested.
+/*
+ * Attempt a single flip of the counters.  Remember, a single flip does
+ * -not- constitute a grace period.  Instead, the interval between
+ * a pair of consecutive flips is a grace period.
  *
- * If your read-side code is not protected by rcu_read_lock(), do -not-
- * use synchronize_rcu().
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
+#ifdef CONFIG_RCU_STATS
+	atomic_inc(&rcu_data.n_synchronize_rcu_flip1);
+#endif /* #ifdef CONFIG_RCU_STATS */
+	flipctr = rcu_data.batch;
+	if (unlikely(!spin_trylock(&rcu_ctrlblk.fliplock)))
+		return;
+#if 0
+	spin_lock(&rcu_ctrlblk.fliplock);
+#endif
+	if (unlikely(flipctr != rcu_data.batch)) {
+	
+		/* Our work is done!  ;-) */
+
+#ifdef CONFIG_RCU_STATS
+		rcu_data.n_synchronize_rcu_flip_early1++;
+#endif /* #ifdef CONFIG_RCU_STATS */
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
+#ifdef CONFIG_RCU_STATS
+	atomic_inc(&rcu_data.n_synchronize_rcu_flip2);
+#endif /* #ifdef CONFIG_RCU_STATS */
+	for_each_cpu(cpu) {
+		if (atomic_read(&per_cpu(rcu_flipctr, cpu)[!flipctr]) != 0) {
+			spin_unlock(&rcu_ctrlblk.fliplock);
+			return;
+		}
+	}
+
+	/* Do the flip. */
+
+#ifdef CONFIG_RCU_STATS
+	atomic_inc(&rcu_data.n_synchronize_rcu_flip3);
+#endif /* #ifdef CONFIG_RCU_STATS */
+	smp_mb();
+	rcu_ctrlblk.batch++;
+
+#ifdef CONFIG_RCU_STATS
+	atomic_inc(&rcu_data.n_synchronize_rcu_flip4);
+#endif /* #ifdef CONFIG_RCU_STATS */
+	
+	spin_unlock(&rcu_ctrlblk.fliplock);
+}
+
+void
+rcu_check_callbacks(int cpu, int user)
+{
+	unsigned long flags;
+
+	rcu_try_flip();
+	rcu_spin_lock(&rcu_data.lock, flags);
+#ifdef CONFIG_RCU_STATS
+	rcu_data.n_rcu_check_callbacks++;
+#endif /* #ifdef CONFIG_RCU_STATS */
+	__rcu_advance_callbacks();
+	if (rcu_data.donelist == NULL) {
+		rcu_spin_unlock(&rcu_data.lock, flags);
+	} else {
+		rcu_spin_unlock(&rcu_data.lock, flags);
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
+	rcu_spin_lock(&rcu_data.lock, flags);
+#ifdef CONFIG_RCU_STATS
+	rcu_data.n_rcu_process_callbacks++;
+#endif /* #ifdef CONFIG_RCU_STATS */
+	list = rcu_data.donelist;
+	if (list == NULL) {
+		rcu_spin_unlock(&rcu_data.lock, flags);
+		return;
+	}
+	rcu_data.donelist = NULL;
+	rcu_data.donetail = &rcu_data.donelist;
+#ifdef CONFIG_RCU_STATS
+	rcu_data.n_done_remove += rcu_data.n_done_length;
+	rcu_data.n_done_length = 0;
+#endif /* #ifdef CONFIG_RCU_STATS */
+	rcu_spin_unlock(&rcu_data.lock, flags);
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
+	rcu_spin_lock(&rcu_data.lock, flags);
+	__rcu_advance_callbacks();
+	*rcu_data.nexttail = head;
+	rcu_data.nexttail = &head->next;
+#ifdef CONFIG_RCU_STATS
+	rcu_data.n_next_add++;
+#endif /* #ifdef CONFIG_RCU_STATS */
+	rcu_data.n_next_length++;
+	rcu_spin_unlock(&rcu_data.lock, flags);
+}
+
+/*
+ * Crude hack, reduces but does not eliminate possibility of failure.
+ * Needs to wait for all CPUs to pass through a -voluntary- context
+ * switch to eliminate possibility of failure.  (Maybe just crank
+ * priority down...)
  */
-void synchronize_rcu(void)
+void
+synchronize_sched(void)
 {
-	struct rcu_synchronize rcu;
+	cpumask_t oldmask;
+	int cpu;
 
-	init_completion(&rcu.completion);
-	/* Will wake me after RCU finished */
-	call_rcu(&rcu.head, wakeme_after_rcu);
+	if (sched_getaffinity(0, &oldmask) < 0) {
+		oldmask = cpu_possible_map; 
+	}
+	for_each_cpu(cpu) {
+		sched_setaffinity(0, cpumask_of_cpu(cpu));
+		schedule();
+	}
+	sched_setaffinity(0, oldmask);
+}
 
-	/* Wait for it */
-	wait_for_completion(&rcu.completion);
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
+	rcu_data.lock = RCU_SPIN_LOCK_UNLOCKED;
+	rcu_data.batch = 0;
+	rcu_data.nextlist = NULL;
+	rcu_data.nexttail = &rcu_data.nextlist;
+	rcu_data.waitlist = NULL;
+	rcu_data.waittail = &rcu_data.waitlist;
+	rcu_data.donelist = NULL;
+	rcu_data.donetail = &rcu_data.donelist;
+	tasklet_init(&rcu_data.rcu_tasklet, rcu_process_callbacks, 0UL);
 }
 
 /*
@@ -472,11 +862,71 @@ void synchronize_rcu(void)
  */
 void synchronize_kernel(void)
 {
+	synchronize_sched();
+}
+
+#ifdef CONFIG_RCU_STATS
+int rcu_read_proc_data(char *page)
+{
+	return sprintf(page,
+		       "ggp=%ld lgp=%ld\n"
+		       "sr=%d srf1=%d srf2=%d srf3=%d srf4=%d\n"
+		       "ac1=%ld ac2=%ld ac3=%ld ac4=%ld ac5=%ld\n"
+		       "sre1=%ld\n"
+		       "na=%ld nl=%ld wa=%ld wl=%ld rcc=%ld rpc=%ld dl=%ld dr=%ld di=%d\n",
+		       rcu_ctrlblk.batch,
+		       rcu_data.batch,
+
+		       atomic_read(&rcu_data.n_synchronize_rcu),
+		       atomic_read(&rcu_data.n_synchronize_rcu_flip1),
+		       atomic_read(&rcu_data.n_synchronize_rcu_flip2),
+		       atomic_read(&rcu_data.n_synchronize_rcu_flip3),
+		       atomic_read(&rcu_data.n_synchronize_rcu_flip4),
+
+		       rcu_data.n_rcu_advance_callbacks1,
+		       rcu_data.n_rcu_advance_callbacks2,
+		       rcu_data.n_rcu_advance_callbacks3,
+		       rcu_data.n_rcu_advance_callbacks4,
+		       rcu_data.n_rcu_advance_callbacks5,
+
+		       rcu_data.n_synchronize_rcu_flip_early1,
+
+		       rcu_data.n_next_add,
+		       rcu_data.n_next_length,
+		       rcu_data.n_wait_add,
+		       rcu_data.n_wait_length,
+		       rcu_data.n_rcu_check_callbacks,
+		       rcu_data.n_rcu_process_callbacks,
+		       rcu_data.n_done_length,
+		       rcu_data.n_done_remove,
+		       atomic_read(&rcu_data.n_done_invoked));
+}
+
+int rcu_read_proc_gp_data(char *page)
+{
+	long oldgp = rcu_ctrlblk.batch;
+
 	synchronize_rcu();
+	return sprintf(page, "oldggp=%ld  newggp=%ld\n",
+		       oldgp, rcu_ctrlblk.batch);
 }
 
-module_param(maxbatch, int, 0);
-EXPORT_SYMBOL(call_rcu);  /* WARNING: GPL-only in April 2006. */
-EXPORT_SYMBOL(call_rcu_bh);  /* WARNING: GPL-only in April 2006. */
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
 EXPORT_SYMBOL_GPL(synchronize_rcu);
-EXPORT_SYMBOL(synchronize_kernel);  /* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL_GPL(synchronize_sched);
+EXPORT_SYMBOL(rcu_read_lock);  /* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL(rcu_read_unlock);  /* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL(synchronize_kernel);  /* WARNING: Removal in April 2006. */
+
+#endif /* #else #ifndef CONFIG_PREEMPT_RCU */
