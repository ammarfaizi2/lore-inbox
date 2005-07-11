Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbVGKPyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbVGKPyJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 11:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVGKPwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 11:52:08 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:53745 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262072AbVGKPu5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 11:50:57 -0400
Date: Mon, 11 Jul 2005 08:51:20 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: [RFC] RCU and CONFIG_PREEMPT_RT progress, part 2
Message-ID: <20050711155120.GB1304@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050625013821.GA2996@us.ibm.com> <20050711150728.GA1497@us.ibm.com> <20050711151627.GA19794@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050711151627.GA19794@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2005 at 05:16:27PM +0200, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@us.ibm.com> wrote:
> 
> > Hello!
> > 
> > More progress on CONFIG_PREEMPT_RT-compatible RCU.
> > 
> > o	Continued prototyping Linux-kernel implementation, still
> > 	in the CONFIG_PREEMPT environment.
> 
> cool! With the debugging code removed it doesnt look all that complex.  
> Do you think i can attempt to plug this into the -RT tree, or should i 
> wait some more? (One observation: if you know some branch is slowpath in 
> a common codepath then it's useful to mark the condition via unlikely().  
> That results in better code layout and is also a guidance for the casual 
> reader of the code.)

I would hold off, as it is still quite fragile.  I can make it break
quite easily, so it is not yet time to unleash it on all users of
CONFIG_PREEMPT_RT.

Good point on the unlikely(), updated the ones checking for races.
The checks in rcu_read_lock() and rcu_read_unlock() for racing
counter flips seem to be the most important, but I also added them
to the checks for concurrent synchronize_rcu() calls, see below.

							Thanx, Paul

diff -urpN -X dontdiff linux-2.6.12-rc6/arch/i386/Kconfig linux-2.6.12-rc6-ctrRCU/arch/i386/Kconfig
--- linux-2.6.12-rc6/arch/i386/Kconfig	2005-06-17 16:34:16.000000000 -0700
+++ linux-2.6.12-rc6-ctrRCU/arch/i386/Kconfig	2005-06-25 11:45:40.000000000 -0700
@@ -523,6 +523,34 @@ config PREEMPT
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
+	  This option provides /proc stats to provide debugging info.
+	  real-time or interactive events by allowing a low priority process to
+	  be preempted even if it is in an RCU read-side critical section.
+	  This allows applications to run more reliably even when the system is
+	  under load.
+
+	  Say Y here if you want to see RCU stats in /proc
+	  Say N if you are unsure.
+
 config PREEMPT_BKL
 	bool "Preempt The Big Kernel Lock"
 	depends on PREEMPT
diff -urpN -X dontdiff linux-2.6.12-rc6/fs/proc/proc_misc.c linux-2.6.12-rc6-ctrRCU/fs/proc/proc_misc.c
--- linux-2.6.12-rc6/fs/proc/proc_misc.c	2005-06-17 16:35:03.000000000 -0700
+++ linux-2.6.12-rc6-ctrRCU/fs/proc/proc_misc.c	2005-06-29 11:22:11.000000000 -0700
@@ -549,6 +549,48 @@ void create_seq_entry(char *name, mode_t
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
+int rcu_read_proc_wqgp(char *page, char **start, off_t off,
+		       int count, int *eof, void *data)
+{
+	int len;
+	extern int rcu_read_proc_wqgp_data(char *page);
+
+	len = rcu_read_proc_wqgp_data(page);
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
@@ -571,6 +613,12 @@ void __init proc_misc_init(void)
 		{"cmdline",	cmdline_read_proc},
 		{"locks",	locks_read_proc},
 		{"execdomains",	execdomains_read_proc},
+#ifdef CONFIG_RCU_STATS
+		{"rcustats",	rcu_read_proc},
+		{"rcugp",	rcu_read_proc_gp},
+		{"rcuwqgp",	rcu_read_proc_wqgp},
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
+++ linux-2.6.12-rc6-ctrRCU/kernel/rcupdate.c	2005-07-11 08:47:08.000000000 -0700
@@ -46,6 +46,9 @@
 #include <linux/notifier.h>
 #include <linux/rcupdate.h>
 #include <linux/cpu.h>
+#include <linux/workqueue.h>
+
+#ifndef CONFIG_PREEMPT_RCU
 
 /* Definition for rcupdate control block. */
 struct rcu_ctrlblk rcu_ctrlblk = 
@@ -480,3 +483,526 @@ EXPORT_SYMBOL(call_rcu);  /* WARNING: GP
 EXPORT_SYMBOL(call_rcu_bh);  /* WARNING: GPL-only in April 2006. */
 EXPORT_SYMBOL_GPL(synchronize_rcu);
 EXPORT_SYMBOL(synchronize_kernel);  /* WARNING: GPL-only in April 2006. */
+
+#else /* #ifndef CONFIG_PREEMPT_RCU */
+
+#ifdef CONFIG_PREEMPT_RT
+#error "Hey!!!  This fails miserably even in straightforward testing!!!"
+#endif /* #ifdef CONFIG_PREEMPT_RT */
+
+#define raw_spinlock_t spinlock_t
+#define _raw_spin_lock(l) spin_lock(l)
+#define _raw_spin_unlock(l) spin_unlock(l)
+#define RAW_SPIN_LOCK_UNLOCKED SPIN_LOCK_UNLOCKED
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
+	atomic_t	n_synchronize_rcu_early1;
+	atomic_t	n_synchronize_rcu_flip1; /*&&&&*/
+	atomic_t	n_synchronize_rcu_flip2; /*&&&&*/
+	atomic_t	n_synchronize_rcu_flip3; /*&&&&*/
+	atomic_t	n_synchronize_rcu_flip4; /*&&&&*/
+	atomic_t	n_synchronize_rcu_flip5; /*&&&&*/
+	atomic_t	n_synchronize_rcu_flip6; /*&&&&*/
+	atomic_t	n_synchronize_rcu_flip_early1;
+	long		n_synchronize_rcu_flip_early2;
+#endif /* #ifdef CONFIG_RCU_STATS */
+};
+struct rcu_ctrlblk {
+	long		batch;
+};
+static struct rcu_data rcu_data;
+static struct rcu_ctrlblk rcu_ctrlblk = {
+	.batch = 0,
+};
+DECLARE_MUTEX(rcu_flipmutex);
+static DEFINE_PER_CPU(atomic_t [2], rcu_flipctr) =
+	{ ATOMIC_INIT(0), ATOMIC_INIT(0) };
+
+#define RCU_NEXT_LIST_TRIGGER_LENGTH 100
+
+void
+rcu_read_lock(void)
+{
+	int flipctr;
+	unsigned long oldirq;
+
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
+	preempt_disable();
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
+	preempt_enable();
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
+}
+
+void
+synchronize_rcu_wqh(void *dummy)
+{
+	synchronize_rcu();  /* @@@ need non-blocking attempt to flip... */
+}
+
+DECLARE_WORK(synchronize_rcu_wq, synchronize_rcu_wqh, NULL);
+
+void
+rcu_check_callbacks(int cpu, int user)
+{
+	_raw_spin_lock(&rcu_data.lock);
+#ifdef CONFIG_RCU_STATS
+	rcu_data.n_rcu_check_callbacks++;
+#endif /* #ifdef CONFIG_RCU_STATS */
+	__rcu_advance_callbacks();
+	if (rcu_data.donelist == NULL) {
+		_raw_spin_unlock(&rcu_data.lock);
+	} else {
+		_raw_spin_unlock(&rcu_data.lock);
+		tasklet_schedule(&rcu_data.rcu_tasklet);
+	}
+	if (unlikely(rcu_data.n_next_length >= RCU_NEXT_LIST_TRIGGER_LENGTH)) {
+		schedule_work(&synchronize_rcu_wq);
+	}
+}
+
+static
+void rcu_process_callbacks(unsigned long data)
+{
+	struct rcu_head *next, *list;
+
+	_raw_spin_lock(&rcu_data.lock);
+#ifdef CONFIG_RCU_STATS
+	rcu_data.n_rcu_process_callbacks++;
+#endif /* #ifdef CONFIG_RCU_STATS */
+	list = rcu_data.donelist;
+	if (list == NULL) {
+		_raw_spin_unlock(&rcu_data.lock);
+		return;
+	}
+	rcu_data.donelist = NULL;
+	rcu_data.donetail = &rcu_data.donelist;
+#ifdef CONFIG_RCU_STATS
+	rcu_data.n_done_remove += rcu_data.n_done_length;
+	rcu_data.n_done_length = 0;
+#endif /* #ifdef CONFIG_RCU_STATS */
+	_raw_spin_unlock(&rcu_data.lock);
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
+/*
+ * Force a single flip of the counters.  Remember, a single flip does
+ * -not- constitute a grace period.  Instead, the interval between
+ * a pair of consecutive flips is a grace period.
+ *
+ * If anyone is nuts enough to run this CONFIG_PREEMPT_RCU implementation
+ * on a large SMP, they might want to use a hierarchical organization of
+ * the per-CPU-counter pairs.
+ */
+static void
+__synchronize_rcu_flip(void)
+{
+	int cpu;
+	long flipctr;
+
+#ifdef CONFIG_RCU_STATS
+	atomic_inc(&rcu_data.n_synchronize_rcu_flip3);
+#endif /* #ifdef CONFIG_RCU_STATS */
+	flipctr = rcu_data.batch;
+	down(&rcu_flipmutex);
+	if (unlikely(flipctr != rcu_data.batch)) {
+	
+		/* Our work is done!  ;-) */
+
+#ifdef CONFIG_RCU_STATS
+		rcu_data.n_synchronize_rcu_flip_early2++;
+#endif /* #ifdef CONFIG_RCU_STATS */
+		up(&rcu_flipmutex);
+		return;
+	}
+	flipctr &= 0x1;
+
+	/*
+	 * Wait for the completion of all RCU read-side critical sections
+	 * that started prior to the previous flip.
+	 */
+
+#ifdef CONFIG_RCU_STATS
+	atomic_inc(&rcu_data.n_synchronize_rcu_flip4);
+#endif /* #ifdef CONFIG_RCU_STATS */
+	for_each_cpu(cpu) {
+		while (atomic_read(&per_cpu(rcu_flipctr, cpu)[!flipctr]) != 0) {
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout(HZ / 100);
+		}
+	}
+
+	/* Do the flip. */
+
+#ifdef CONFIG_RCU_STATS
+	atomic_inc(&rcu_data.n_synchronize_rcu_flip5);
+#endif /* #ifdef CONFIG_RCU_STATS */
+	smp_mb();
+	rcu_ctrlblk.batch++;
+	smp_mb(); /* Not 100% certain that this one is required. */
+		  /* In fact, it seems likely that it can go. */
+#ifdef CONFIG_RCU_STATS
+	atomic_inc(&rcu_data.n_synchronize_rcu_flip6);
+#endif /* #ifdef CONFIG_RCU_STATS */
+	
+	/* A bit awkward -- looking ahead to per-CPU callback queues. */
+	/* Process callbacks... */
+
+	_raw_spin_lock(&rcu_data.lock);
+	__rcu_advance_callbacks();
+	_raw_spin_unlock(&rcu_data.lock);
+	tasklet_schedule(&rcu_data.rcu_tasklet);
+
+	up(&rcu_flipmutex);
+}
+
+/*
+ * Force a single flip of the counters, but do it lazily, waiting
+ * a bit to see if someone else will do it for us.
+ */
+static void
+synchronize_rcu_flip(void)
+{
+	long oldbatch = rcu_data.batch;
+
+#ifdef CONFIG_RCU_STATS
+	atomic_inc(&rcu_data.n_synchronize_rcu_flip1);
+#endif /* #ifdef CONFIG_RCU_STATS */
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(HZ / 100);
+	if (unlikely(rcu_data.batch != oldbatch)) {
+		
+		/* Our work is done! */
+
+#ifdef CONFIG_RCU_STATS
+		atomic_inc(&rcu_data.n_synchronize_rcu_flip_early1);
+#endif /* #ifdef CONFIG_RCU_STATS */
+		return;
+	}
+
+	/* No one else did it for us, so force the flip. */
+
+#ifdef CONFIG_RCU_STATS
+	atomic_inc(&rcu_data.n_synchronize_rcu_flip2);
+#endif /* #ifdef CONFIG_RCU_STATS */
+	__synchronize_rcu_flip();
+}
+
+void
+synchronize_rcu(void)
+{
+	long oldbatch = rcu_data.batch;
+
+	/* Need two flips to get a grace period. */
+
+/*&&&&  printk("Entering synchronize_rcu()\n"); */
+#ifdef CONFIG_RCU_STATS
+	atomic_inc(&rcu_data.n_synchronize_rcu);
+#endif /* #ifdef CONFIG_RCU_STATS */
+	synchronize_rcu_flip();
+
+	if (unlikely((rcu_data.batch - oldbatch) >= 2)) {
+
+		/* Someone else helped with the second flip, we are done! */
+
+#ifdef CONFIG_RCU_STATS
+		atomic_inc(&rcu_data.n_synchronize_rcu_early1);
+#endif /* #ifdef CONFIG_RCU_STATS */
+		return;
+	}
+
+	synchronize_rcu_flip();
+/*&&&&*/printk("Exiting synchronize_rcu()\n");
+}
+
+void fastcall
+call_rcu(struct rcu_head *head,
+	 void (*func)(struct rcu_head *rcu))
+{
+	head->func = func;
+	head->next = NULL;
+	_raw_spin_lock(&rcu_data.lock);
+	__rcu_advance_callbacks();
+	*rcu_data.nexttail = head;
+	rcu_data.nexttail = &head->next;
+#ifdef CONFIG_RCU_STATS
+	rcu_data.n_next_add++;
+#endif /* #ifdef CONFIG_RCU_STATS */
+	rcu_data.n_next_length++;
+	_raw_spin_unlock(&rcu_data.lock);
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
+		       "ggp=%ld lgp=%ld\n"
+		       "sr=%d srf1=%d srf2=%d srf3=%d srf4=%d srf5=%d srf6=%d\n"
+		       "ac1=%ld ac2=%ld ac3=%ld ac4=%ld ac5=%ld\n"
+		       "sre1=%d srfe1=%d srfe2=%ld\n"
+		       "na=%ld nl=%ld wa=%ld wl=%ld rcc=%ld rpc=%ld dl=%ld dr=%ld di=%d\n",
+		       rcu_ctrlblk.batch,
+		       rcu_data.batch,
+
+		       atomic_read(&rcu_data.n_synchronize_rcu),
+		       atomic_read(&rcu_data.n_synchronize_rcu_flip1),
+		       atomic_read(&rcu_data.n_synchronize_rcu_flip2),
+		       atomic_read(&rcu_data.n_synchronize_rcu_flip3),
+		       atomic_read(&rcu_data.n_synchronize_rcu_flip4),
+		       atomic_read(&rcu_data.n_synchronize_rcu_flip5),
+		       atomic_read(&rcu_data.n_synchronize_rcu_flip6),
+
+		       rcu_data.n_rcu_advance_callbacks1,
+		       rcu_data.n_rcu_advance_callbacks2,
+		       rcu_data.n_rcu_advance_callbacks3,
+		       rcu_data.n_rcu_advance_callbacks4,
+		       rcu_data.n_rcu_advance_callbacks5,
+
+		       atomic_read(&rcu_data.n_synchronize_rcu_early1),
+		       atomic_read(&rcu_data.n_synchronize_rcu_flip_early1),
+		       rcu_data.n_synchronize_rcu_flip_early2,
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
+	synchronize_rcu();
+	return sprintf(page, "oldggp=%ld  newggp=%ld\n",
+		       oldgp, rcu_ctrlblk.batch);
+}
+
+int rcu_read_proc_wqgp_data(char *page)
+{
+	long oldgp = rcu_ctrlblk.batch;
+
+	schedule_work(&synchronize_rcu_wq);
+	return sprintf(page, "oldggp=%ld\n", oldgp);
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
+
+#endif /* #else #ifndef CONFIG_PREEMPT_RCU */
