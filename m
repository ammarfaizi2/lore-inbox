Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262759AbVG3BER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262759AbVG3BER (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 21:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262865AbVG3BCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 21:02:47 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:12747 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262759AbVG3BAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 21:00:03 -0400
Date: Fri, 29 Jul 2005 18:00:30 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu, dipankar@in.ibm.com, rostedt@goodmis.org, bhuey@lnxw.com,
       shemminger@osdl.org, rusty@au1.ibm.com
Subject: [RFC,PATCH] RCU and CONFIG_PREEMPT_RT three-quarters-sane patch
Message-ID: <20050730010029.GF1382@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The attached patch fixes an interrupt-masking problem in the previous
round, so gets about 90% pass rate on LTP (up from 60-80% on the
earlier patch).  So, call it three-quarters sane.  :-/

I have added some debug support and an internal-to-RCU torture test,
which has the interesting property of being able to make RCU fail
without crashing the kernel.  And gets failures to happen a -lot-
more quickly than LTP, even if LTP were to fail 100% of the time rather
than only 10% of the time.  I believe I have a lead on at least
one additional bug, but thought I should post this intermediate result
in the meantime.

Again, this patch might be acceptable to courageous users of the
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

o	There is still at least one bug that causes RCU to declare a
	grace period completed before it should.

o	Applies against V0.7.51-27 of Ingo's patch.

As before, the code (but not the patch) should work in a stock kernel
as well as in the CONFIG_PREEMPT_RT environment.

Thoughts?

						Thanx, Paul

Signed-off-by: <paulmck@us.ibm.com>

 fs/proc/proc_misc.c      |   81 ++++
 include/linux/rcupdate.h |   27 +
 include/linux/sched.h    |    3 
 kernel/Kconfig.preempt   |   26 +
 kernel/rcupdate.c        |  767 +++++++++++++++++++++++++++++++++++++++++++----
 5 files changed, 847 insertions(+), 57 deletions(-)

diff -urpN -X dontdiff linux-2.6.12-realtime-preempt-V0.7.51-27/fs/proc/proc_misc.c linux-2.6.12-realtime-preempt-V0.7.51-27-ctrRCUtt/fs/proc/proc_misc.c
--- linux-2.6.12-realtime-preempt-V0.7.51-27/fs/proc/proc_misc.c	2005-07-13 14:52:43.000000000 -0700
+++ linux-2.6.12-realtime-preempt-V0.7.51-27-ctrRCUtt/fs/proc/proc_misc.c	2005-07-25 03:18:58.000000000 -0700
@@ -599,6 +599,78 @@ void create_seq_entry(char *name, mode_t
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
+
+int rcu_read_proc_ctrs(char *page, char **start, off_t off,
+		       int count, int *eof, void *data)
+{
+	int len;
+	extern int rcu_read_proc_ctrs_data(char *page);
+
+	len = rcu_read_proc_ctrs_data(page);
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+
+int rcu_read_proc_torture_writer(char *page, char **start, off_t off,
+			         int count, int *eof, void *data)
+{
+	int len;
+	extern int rcu_read_proc_torture_writer_data(char *page);
+
+	len = rcu_read_proc_torture_writer_data(page);
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+
+int rcu_read_proc_torture_reader(char *page, char **start, off_t off,
+			         int count, int *eof, void *data)
+{
+	int len;
+	extern int rcu_read_proc_torture_reader_data(char *page);
+
+	len = rcu_read_proc_torture_reader_data(page);
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+
+int rcu_read_proc_torture_stats(char *page, char **start, off_t off,
+			        int count, int *eof, void *data)
+{
+	int len;
+	extern int rcu_read_proc_torture_stats_data(char *page);
+
+	len = rcu_read_proc_torture_stats_data(page);
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+#endif /* #ifdef CONFIG_RCU_STATS */
+
 void __init proc_misc_init(void)
 {
 	struct proc_dir_entry *entry;
@@ -621,6 +693,15 @@ void __init proc_misc_init(void)
 		{"cmdline",	cmdline_read_proc},
 		{"locks",	locks_read_proc},
 		{"execdomains",	execdomains_read_proc},
+#ifdef CONFIG_RCU_STATS
+		{"rcustats",	rcu_read_proc},
+		{"rcugp",	rcu_read_proc_gp},
+		{"rcuptrs",	rcu_read_proc_ptrs},
+		{"rcuctrs",	rcu_read_proc_ctrs},
+		{"rcutw",	rcu_read_proc_torture_writer},
+		{"rcutr",	rcu_read_proc_torture_reader},
+		{"rcuts",	rcu_read_proc_torture_stats},
+#endif /* #ifdef CONFIG_RCU_STATS */
 		{NULL,}
 	};
 	for (p = simple_ones; p->name; p++)
diff -urpN -X dontdiff linux-2.6.12-realtime-preempt-V0.7.51-27/include/linux/rcupdate.h linux-2.6.12-realtime-preempt-V0.7.51-27-ctrRCUtt/include/linux/rcupdate.h
--- linux-2.6.12-realtime-preempt-V0.7.51-27/include/linux/rcupdate.h	2005-07-13 14:52:43.000000000 -0700
+++ linux-2.6.12-realtime-preempt-V0.7.51-27-ctrRCUtt/include/linux/rcupdate.h	2005-07-20 06:06:02.000000000 -0700
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
diff -urpN -X dontdiff linux-2.6.12-realtime-preempt-V0.7.51-27/include/linux/sched.h linux-2.6.12-realtime-preempt-V0.7.51-27-ctrRCUtt/include/linux/sched.h
--- linux-2.6.12-realtime-preempt-V0.7.51-27/include/linux/sched.h	2005-07-13 14:52:43.000000000 -0700
+++ linux-2.6.12-realtime-preempt-V0.7.51-27-ctrRCUtt/include/linux/sched.h	2005-07-20 06:06:02.000000000 -0700
@@ -917,7 +917,8 @@ struct task_struct {
 #endif
 #ifdef CONFIG_PREEMPT_RCU
 	int rcu_read_lock_nesting;
-	struct rcu_data *rcu_data;
+	atomic_t *rcu_flipctr1;
+	atomic_t *rcu_flipctr2;
 #endif
 };
 
diff -urpN -X dontdiff linux-2.6.12-realtime-preempt-V0.7.51-27/kernel/Kconfig.preempt linux-2.6.12-realtime-preempt-V0.7.51-27-ctrRCUtt/kernel/Kconfig.preempt
--- linux-2.6.12-realtime-preempt-V0.7.51-27/kernel/Kconfig.preempt	2005-07-13 14:52:43.000000000 -0700
+++ linux-2.6.12-realtime-preempt-V0.7.51-27-ctrRCUtt/kernel/Kconfig.preempt	2005-07-20 06:06:02.000000000 -0700
@@ -127,10 +127,34 @@ config PREEMPT_RCU
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
+config RCU_TORTURE_TEST
+	bool "/proc torture tests for RCU"
+	depends on RCU_STATS
+	default y
+	help
+	  This option provides /proc files that run torture tests on
+	  the preemptible realtime RCU implementation.
+
+	  Say Y here if you want to be able to run RCU torture tests.
+	  Say N if you are unsure.
+
 config SPINLOCK_BKL
 	bool "Old-Style Big Kernel Lock"
 	depends on (PREEMPT || SMP) && !PREEMPT_RT
diff -urpN -X dontdiff linux-2.6.12-realtime-preempt-V0.7.51-27/kernel/rcupdate.c linux-2.6.12-realtime-preempt-V0.7.51-27-ctrRCUtt/kernel/rcupdate.c
--- linux-2.6.12-realtime-preempt-V0.7.51-27/kernel/rcupdate.c	2005-07-13 14:52:43.000000000 -0700
+++ linux-2.6.12-realtime-preempt-V0.7.51-27-ctrRCUtt/kernel/rcupdate.c	2005-07-29 08:34:18.000000000 -0700
@@ -46,6 +46,49 @@
 #include <linux/notifier.h>
 #include <linux/rcupdate.h>
 #include <linux/cpu.h>
+#include <linux/random.h>
+#include <linux/delay.h>
+#include <linux/byteorder/swabb.h>
+
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
 
 /* Definition for rcupdate control block. */
 struct rcu_ctrlblk rcu_ctrlblk = 
@@ -429,42 +472,388 @@ void __init rcu_init(void)
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
+#ifndef CONFIG_PREEMPT_RT
+
+#define raw_spinlock_t spinlock_t
+#define RAW_SPIN_LOCK_UNLOCKED SPIN_LOCK_UNLOCKED
+#error "Don't want to be running CONFIG_PREEMPT right now"
+
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
+	atomic_t	n_rcu_try_flip1;
+	long		n_rcu_try_flip2;
+	long		n_rcu_try_flip3;
+	atomic_t	n_rcu_try_flip_e1;
+	long		n_rcu_try_flip_e2;
+	long		n_rcu_try_flip_e3;
+#ifdef CONFIG_RCU_TORTURE_TEST
+	atomic_t	n_rcu_torture_alloc;
+	atomic_t	n_rcu_torture_alloc_fail;
+	atomic_t	n_rcu_torture_free;
+#endif /* #ifdef CONFIG_RCU_TORTURE_TEST */
+#endif /* #ifdef CONFIG_RCU_STATS */
+};
+struct rcu_ctrlblk {
+	raw_spinlock_t	fliplock;
+	long		batch;
 };
+static struct rcu_data rcu_data;
+static struct rcu_ctrlblk rcu_ctrlblk = {
+	.fliplock = RAW_SPIN_LOCK_UNLOCKED,
+	.batch = 0,
+};
+static DEFINE_PER_CPU(atomic_t [2], rcu_flipctr) =
+	{ ATOMIC_INIT(0), ATOMIC_INIT(0) };
 
-/* Because of FASTCALL declaration of complete, we use this wrapper */
-static void wakeme_after_rcu(struct rcu_head  *head)
+#ifdef CONFIG_RCU_TORTURE_TEST
+
+#define RCU_TORTURE_PIPE_LEN 10
+
+struct rcu_torture {
+	struct rcu_head rtort_rcu;
+	int rtort_pipe_count;
+	struct list_head rtort_free;
+};
+
+static LIST_HEAD(rcu_torture_freelist);
+static struct rcu_torture *rcu_torture_current = NULL;
+static long rcu_torture_current_version = 0;
+static struct rcu_torture rcu_tortures[2 * RCU_TORTURE_PIPE_LEN];
+static DEFINE_SPINLOCK(rcu_torture_lock);
+static DEFINE_PER_CPU(long [RCU_TORTURE_PIPE_LEN], rcu_torture_count) = { 0 };
+static atomic_t rcu_torture_wcount[RCU_TORTURE_PIPE_LEN + 1] =
+	{ ATOMIC_INIT(0) };
+#define RCU_TORTURE_NOWRITER		0
+#define RCU_TORTURE_WRITERACTIVE	1
+#define RCU_TORTURE_STOPWRITER		2
+static int rcu_torture_wstatus = RCU_TORTURE_NOWRITER;
+
+#endif /* #ifdef CONFIG_RCU_TORTURE_TEST */
+
+void
+rcu_read_lock(void)
 {
-	struct rcu_synchronize *rcu;
+	int flipctr;
+	unsigned long oldirq;
 
-	rcu = container_of(head, struct rcu_synchronize, head);
-	complete(&rcu->completion);
+	raw_local_irq_save(oldirq);
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
+	raw_local_irq_restore(oldirq);
 }
 
-/**
- * synchronize_rcu - wait until a grace period has elapsed.
- *
- * Control will return to the caller some time after a full grace
- * period has elapsed, in other words after all currently executing RCU
- * read-side critical sections have completed.  RCU read-side critical
- * sections are delimited by rcu_read_lock() and rcu_read_unlock(),
- * and may be nested.
+void
+rcu_read_unlock(void)
+{
+	unsigned long oldirq;
+
+	raw_local_irq_save(oldirq);
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
+	raw_local_irq_restore(oldirq);
+}
+
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
  *
- * If your read-side code is not protected by rcu_read_lock(), do -not-
- * use synchronize_rcu().
+ * If anyone is nuts enough to run this CONFIG_PREEMPT_RCU implementation
+ * on a large SMP, they might want to use a hierarchical organization of
+ * the per-CPU-counter pairs.
  */
-void synchronize_rcu(void)
+static void
+rcu_try_flip(void)
 {
-	struct rcu_synchronize rcu;
+	int cpu;
+	long flipctr;
+	unsigned long oldirq;
 
-	init_completion(&rcu.completion);
-	/* Will wake me after RCU finished */
-	call_rcu(&rcu.head, wakeme_after_rcu);
+	flipctr = rcu_data.batch;
+#ifdef CONFIG_RCU_STATS
+	atomic_inc(&rcu_data.n_rcu_try_flip1);
+#endif /* #ifdef CONFIG_RCU_STATS */
+	if (unlikely(!spin_trylock_irqsave(&rcu_ctrlblk.fliplock, oldirq))) {
+#ifdef CONFIG_RCU_STATS
+		atomic_inc(&rcu_data.n_rcu_try_flip_e1);
+#endif /* #ifdef CONFIG_RCU_STATS */
+		return;
+	}
+	if (unlikely(flipctr != rcu_data.batch)) {
+	
+		/* Our work is done!  ;-) */
+
+#ifdef CONFIG_RCU_STATS
+		rcu_data.n_rcu_try_flip_e2++;
+#endif /* #ifdef CONFIG_RCU_STATS */
+		spin_unlock_irqrestore(&rcu_ctrlblk.fliplock, oldirq);
+		return;
+	}
+	flipctr &= 0x1;
 
-	/* Wait for it */
-	wait_for_completion(&rcu.completion);
+	/*
+	 * Check for completion of all RCU read-side critical sections
+	 * that started prior to the previous flip.
+	 */
+
+#ifdef CONFIG_RCU_STATS
+	rcu_data.n_rcu_try_flip2++;
+#endif /* #ifdef CONFIG_RCU_STATS */
+	for_each_cpu(cpu) {
+		if (atomic_read(&per_cpu(rcu_flipctr, cpu)[!flipctr]) != 0) {
+#ifdef CONFIG_RCU_STATS
+			rcu_data.n_rcu_try_flip_e3++;
+#endif /* #ifdef CONFIG_RCU_STATS */
+			spin_unlock_irqrestore(&rcu_ctrlblk.fliplock, oldirq);
+			return;
+		}
+	}
+
+	/* Do the flip. */
+
+	smp_mb();
+	rcu_ctrlblk.batch++;
+
+#ifdef CONFIG_RCU_STATS
+	rcu_data.n_rcu_try_flip3++;
+#endif /* #ifdef CONFIG_RCU_STATS */
+	spin_unlock_irqrestore(&rcu_ctrlblk.fliplock, oldirq);
+}
+
+void
+rcu_check_callbacks(int cpu, int user)
+{
+	unsigned long oldirq;
+
+	rcu_try_flip();
+	spin_lock_irqsave(&rcu_data.lock, oldirq);
+#ifdef CONFIG_RCU_STATS
+	rcu_data.n_rcu_check_callbacks++;
+#endif /* #ifdef CONFIG_RCU_STATS */
+	__rcu_advance_callbacks();
+	if (rcu_data.donelist == NULL) {
+		spin_unlock_irqrestore(&rcu_data.lock, oldirq);
+	} else {
+		spin_unlock_irqrestore(&rcu_data.lock, oldirq);
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
+#ifdef CONFIG_RCU_TORTURE_TEST
+	int i;
+
+	for (i = 0; i < RCU_TORTURE_PIPE_LEN; i++) {
+		list_add_tail(&rcu_tortures[i].rtort_free,
+			      &rcu_torture_freelist);
+	}
+#endif /* #ifdef CONFIG_RCU_TORTURE_TEST */
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
 }
 
 /*
@@ -475,44 +864,316 @@ void synchronize_kernel(void)
 	synchronize_rcu();
 }
 
-module_param(maxbatch, int, 0);
-EXPORT_SYMBOL(call_rcu);  /* WARNING: GPL-only in April 2006. */
-EXPORT_SYMBOL(call_rcu_bh);  /* WARNING: GPL-only in April 2006. */
-EXPORT_SYMBOL_GPL(synchronize_rcu);
-EXPORT_SYMBOL(synchronize_kernel);  /* WARNING: GPL-only in April 2006. */
+#ifdef CONFIG_RCU_STATS
+int rcu_read_proc_data(char *page)
+{
+	return sprintf(page,
+		       "ggp=%ld lgp=%ld sr=%d rcc=%ld\n"
+		       "na=%ld nl=%ld wa=%ld wl=%ld dl=%ld dr=%ld di=%d\n"
+		       "rtf1=%d rtf2=%ld rtf3=%ld rtfe1=%d rtfe2=%ld rtfe3=%ld\n",
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
+		       atomic_read(&rcu_data.n_done_invoked),
+		       
+		       atomic_read(&rcu_data.n_rcu_try_flip1),
+		       rcu_data.n_rcu_try_flip2,
+		       rcu_data.n_rcu_try_flip3,
+		       atomic_read(&rcu_data.n_rcu_try_flip_e1),
+		       rcu_data.n_rcu_try_flip_e2,
+		       rcu_data.n_rcu_try_flip_e3);
+}
+
+int rcu_read_proc_gp_data(char *page)
+{
+	long oldgp = rcu_ctrlblk.batch;
 
-#ifdef CONFIG_PREEMPT_RCU
+	synchronize_rcu();
+	return sprintf(page, "oldggp=%ld  newggp=%ld\n",
+		       oldgp, rcu_ctrlblk.batch);
+}
 
-void rcu_read_lock(void)
+int rcu_read_proc_ptrs_data(char *page)
 {
-	if (current->rcu_read_lock_nesting++ == 0) {
-		current->rcu_data = &get_cpu_var(rcu_data);
-		atomic_inc(&current->rcu_data->active_readers);
-		smp_mb__after_atomic_inc();
-		put_cpu_var(rcu_data);
+	return sprintf(page,
+		       "nl=%p/%p nt=%p wl=%p/%p wt=%p dl=%p/%p dt=%p\n",
+		       &rcu_data.nextlist, rcu_data.nextlist, rcu_data.nexttail,
+		       &rcu_data.waitlist, rcu_data.waitlist, rcu_data.waittail,
+		       &rcu_data.donelist, rcu_data.donelist, rcu_data.donetail
+		      );
+}
+
+int rcu_read_proc_ctrs_data(char *page)
+{
+	int cnt = 0;
+	int cpu;
+	int f = rcu_data.batch & 0x1;
+
+	cnt += sprintf(&page[cnt], "CPU last cur\n");
+	for_each_cpu(cpu) {
+		cnt += sprintf(&page[cnt], "%3d %4d %3d\n",
+			       cpu, 
+			       atomic_read(&per_cpu(rcu_flipctr, cpu)[!f]),
+			       atomic_read(&per_cpu(rcu_flipctr, cpu)[f]));
 	}
+	cnt += sprintf(&page[cnt], "ggp = %ld\n", rcu_data.batch);
+	return (cnt);
 }
-EXPORT_SYMBOL(rcu_read_lock);
 
-void rcu_read_unlock(void)
+#ifdef CONFIG_RCU_TORTURE_TEST
+
+/*
+ * Allocate an element from the rcu_tortures pool.
+ */
+struct rcu_torture *
+rcu_torture_alloc(void)
 {
+	struct list_head *p;
+
+	spin_lock(&rcu_torture_lock);
+	if (list_empty(&rcu_torture_freelist)) {
+#ifdef CONFIG_RCU_STATS
+		atomic_inc(&rcu_data.n_rcu_torture_alloc_fail);
+#endif /* #ifdef CONFIG_RCU_STATS */
+		spin_unlock(&rcu_torture_lock);
+		return (NULL);
+	}
+#ifdef CONFIG_RCU_STATS
+	atomic_inc(&rcu_data.n_rcu_torture_alloc);
+#endif /* #ifdef CONFIG_RCU_STATS */
+	p = rcu_torture_freelist.next;
+	list_del_init(p);
+	spin_unlock(&rcu_torture_lock);
+	return (container_of(p, struct rcu_torture, rtort_free));
+}
+
+/*
+ * Free an element to the rcu_tortures pool.
+ */
+void
+rcu_torture_free(struct rcu_torture *p)
+{
+#ifdef CONFIG_RCU_STATS
+	atomic_inc(&rcu_data.n_rcu_torture_free);
+#endif /* #ifdef CONFIG_RCU_STATS */
+	spin_lock(&rcu_torture_lock);
+	list_add_tail(&p->rtort_free, &rcu_torture_freelist);
+	spin_unlock(&rcu_torture_lock);
+}
+
+void
+rcu_torture_cb(struct rcu_head *p)
+{
+	int i;
+	struct rcu_torture *rp = container_of(p, struct rcu_torture, rtort_rcu);
+
+#ifdef CONFIG_RCU_STATS
+	i = rp->rtort_pipe_count;
+	if (i > RCU_TORTURE_PIPE_LEN) {
+		i = RCU_TORTURE_PIPE_LEN;
+	}
+	atomic_inc(&rcu_torture_wcount[i]);
+#endif /* #ifdef CONFIG_RCU_STATS */
+	if (++rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
+		rcu_torture_free(rp);
+	} else {
+		call_rcu(p, rcu_torture_cb);
+	}
+}
+
+struct rcu_random_state {
+	unsigned long rrs_state;
+	unsigned long rrs_count;
+};
+
+#define RCU_RANDOM_MULT 39916801  /* prime */
+#define RCU_RANDOM_ADD	479001701 /* prime */
+#define RCU_RANDOM_REFRESH 10000
+
+#define DEFINE_RCU_RANDOM(name) struct rcu_random_state name = { 0, 0 }
+
+/*
+ * Crude but fast random-number generator.  Uses a linear congruential
+ * generator, with occasional help from get_random_bytes().
+ */
+static long
+rcu_random(struct rcu_random_state *rrsp)
+{
+	long refresh;
+
+	if (--rrsp->rrs_count < 0) {
+		get_random_bytes(&refresh, sizeof(refresh));
+		rrsp->rrs_state += refresh;
+		rrsp->rrs_count = RCU_RANDOM_REFRESH;
+	}
+	rrsp->rrs_state = rrsp->rrs_state * RCU_RANDOM_MULT + RCU_RANDOM_ADD;
+	return (swahw32(rrsp->rrs_state));
+}
+
+/*
+ * Handles /proc/rcutw.  Unusual in that the user must cat /proc/rcutw
+ * a second time to allow the first read of /proc/rcutw to complete.
+ * Only one writer may be in existence at a time.
+ */
+int
+rcu_read_proc_torture_writer_data(char *page)
+{
+	int i;
+	long oldbatch = rcu_ctrlblk.batch;
+	struct rcu_torture *rp;
+	struct rcu_torture *old_rp;
+	static DEFINE_RCU_RANDOM(rand);
+
+	spin_lock(&rcu_torture_lock);
+	if (rcu_torture_wstatus == RCU_TORTURE_WRITERACTIVE) {
+		rcu_torture_wstatus = RCU_TORTURE_STOPWRITER;
+		spin_unlock(&rcu_torture_lock);
+		return sprintf(page, "Terminating prior /proc/rcutw test.\n");
+	} else if (rcu_torture_wstatus == RCU_TORTURE_STOPWRITER) {
+		spin_unlock(&rcu_torture_lock);
+		return sprintf(page, "Wait for prior /proc/rcutw test.\n");
+	} else if (rcu_torture_wstatus != RCU_TORTURE_NOWRITER) {
+		return sprintf(page, "Unexpected rcu_torture_wstatus = %d",
+			       rcu_torture_wstatus);
+	}
+	rcu_torture_wstatus = RCU_TORTURE_WRITERACTIVE;
+	spin_unlock(&rcu_torture_lock);
+	while (rcu_torture_wstatus == RCU_TORTURE_WRITERACTIVE) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(2);
+		if (rcu_ctrlblk.batch == oldbatch) {
+			continue;
+		}
+		if ((rp = rcu_torture_alloc()) == NULL) {
+			continue;
+		}
+		rp->rtort_pipe_count = 0;
+		udelay(rcu_random(&rand) & 0x3ff);
+		old_rp = rcu_torture_current;
+		rcu_assign_pointer(rcu_torture_current, rp);
+		smp_wmb();
+		if (old_rp != NULL) {
+#ifdef CONFIG_RCU_STATS
+			i = old_rp->rtort_pipe_count;
+			if (i > RCU_TORTURE_PIPE_LEN) {
+				i = RCU_TORTURE_PIPE_LEN;
+			}
+			atomic_inc(&rcu_torture_wcount[i]);
+#endif /* #ifdef CONFIG_RCU_STATS */
+			old_rp->rtort_pipe_count++;
+			call_rcu(&old_rp->rtort_rcu, rcu_torture_cb);
+		}
+		rcu_torture_current_version++;
+		oldbatch = rcu_ctrlblk.batch;
+	}
+
+	spin_lock(&rcu_torture_lock);
+	rcu_torture_wstatus = RCU_TORTURE_NOWRITER;
+	spin_unlock(&rcu_torture_lock);
+
+	return sprintf(page, "End of /proc/rcutw\n");
+}
+
+/*
+ * Handles /proc/rcutr.  Unusual in that the user must send a signal
+ * to the process to allow the read to complete.  Multiple readers
+ * may run in parallel, but each must be sent a separate signal to
+ * stop.
+ */
+int
+rcu_read_proc_torture_reader_data(char *page)
+{
+	DEFINE_RCU_RANDOM(rand);
+	struct rcu_torture *p;
+	int pipe_count;
+
+	while (!signal_pending(current)) {
+		rcu_read_lock();
+		p = rcu_torture_current;
+		if (p == NULL) {
+			rcu_read_unlock();
+			return sprintf(page, "Need to do /proc/rcutw!\n");
+		}
+		udelay(rcu_random(&rand) & 0x7f);
+		preempt_disable();
+		pipe_count = p->rtort_pipe_count;
+		if (pipe_count >= RCU_TORTURE_PIPE_LEN) {
+			/* Should not happen, but... */
+			pipe_count = RCU_TORTURE_PIPE_LEN - 1;
+		}
+		++__get_cpu_var(rcu_torture_count)[pipe_count];
+		preempt_enable();
+		rcu_read_unlock();
+		schedule();
+	}
+	return sprintf(page, "End of /proc/rcutr\n");
+}
+
+/*
+ * Handles /proc/rcuts, printing out counts of how long readers were
+ * allowed to look at RCU-protected data structures.
+ */
+int
+rcu_read_proc_torture_stats_data(char *page)
+{
+	int cnt = 0;
 	int cpu;
+	int i;
+	long summary[RCU_TORTURE_PIPE_LEN] = { 0 };
 
-	if (--current->rcu_read_lock_nesting == 0) {
-		atomic_dec(&current->rcu_data->active_readers);
-		smp_mb__after_atomic_dec();
-		/*
-		 * Check whether we have reached quiescent state.
-		 * Note! This is only for the local CPU, not for
-		 * current->rcu_data's CPU [which typically is the
-		 * current CPU, but may also be another CPU].
-		 */
-		cpu = get_cpu();
-		rcu_qsctr_inc(cpu);
-		put_cpu();
+	for_each_cpu(cpu) {
+		for (i = 0; i < RCU_TORTURE_PIPE_LEN; i++) {
+			summary[i] += per_cpu(rcu_torture_count, cpu)[i];
+		}
+	}
+	for (i = RCU_TORTURE_PIPE_LEN - 1; i >= 0; i--) {
+		if (summary[i] != 0) {
+			break;
+		}
 	}
+	cnt += sprintf(&page[cnt],
+		       "rtc: %p ver: %ld tfle: %d rta: %d rtaf: %d rtf: %d\n",
+		       rcu_torture_current,
+		       rcu_torture_current_version,
+		       list_empty(&rcu_torture_freelist),
+		       atomic_read(&rcu_data.n_rcu_torture_alloc),
+		       atomic_read(&rcu_data.n_rcu_torture_alloc_fail),
+		       atomic_read(&rcu_data.n_rcu_torture_free));
+	if (i > 1) {
+		cnt += sprintf(&page[cnt], "!!!");
+	}
+	cnt += sprintf(&page[cnt], "Readers: ");
+	for (i = 0; i < RCU_TORTURE_PIPE_LEN; i++) {
+		cnt += sprintf(&page[cnt], " %ld", summary[i]);
+	}
+	cnt += sprintf(&page[cnt], "\n");
+	cnt += sprintf(&page[cnt], "Free-Block Circulation: ");
+	for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++) {
+		cnt += sprintf(&page[cnt], " %d",
+			       atomic_read(&rcu_torture_wcount[i]));
+	}
+	cnt += sprintf(&page[cnt], "\n");
+	return (cnt);
+
 }
-EXPORT_SYMBOL(rcu_read_unlock);
 
-#endif
+#endif /* #ifdef CONFIG_RCU_TORTURE_TEST */
+#endif /* #ifdef CONFIG_RCU_STATS */
+
+EXPORT_SYMBOL(call_rcu); /* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL_GPL(synchronize_rcu);
+EXPORT_SYMBOL_GPL(synchronize_sched);
+EXPORT_SYMBOL(rcu_read_lock);  /* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL(rcu_read_unlock);  /* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL(synchronize_kernel);  /* WARNING: Removal in April 2006. */
 
+#endif /* #else #ifndef CONFIG_PREEMPT_RCU */
