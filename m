Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262567AbVHDOSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbVHDOSJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 10:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262565AbVHDOP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 10:15:56 -0400
Received: from mx2.elte.hu ([157.181.151.9]:11964 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262556AbVHDOP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 10:15:27 -0400
Date: Thu, 4 Aug 2005 16:15:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com, rostedt@goodmis.org,
       bhuey@lnxw.com, shemminger@osdl.org, rusty@au1.ibm.com
Subject: Re: [RFC,PATCH] RCU and CONFIG_PREEMPT_RT sane patch
Message-ID: <20050804141527.GA15447@elte.hu>
References: <20050801171137.GA1754@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <20050801171137.GA1754@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Paul E. McKenney <paulmck@us.ibm.com> wrote:

> Hello!
> 
> The attached patch passes 20 hours of the internal-to-RCU torture test 
> (see the code in the attached patch under CONFIG_RCU_TORTURE_TEST), 
> which is a good improvement over last week's version, which would fail 
> this test in less than two seconds -- this despite passing kernbench 
> with flying colors and passing LTP 90% of the time.  Sometimes there 
> is no substitute for a good in-kernel stress test...
> 
> The attached version of the patch seems to me to be ready for a larger 
> audience.

Cool! I've merged your patch to the -52-12 version of the -RT patch. You 
can get it from the usual place:

  http://redhat.com/~mingo/realtime-preempt/

also, i've attached a port against 2.6.13-rc4. I have done this because 
the PREEMPT_RCU patch in my tree is applied before the core-PREEMPT_RT 
patch. I have fixed up the CONFIG_PREEMPT compilation branch and have 
removed your #error define - it built and booted fine on an UP box but 
there are no guarantees ...

	Ingo

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="preempt-rcu.patch"


make rcu_read_lock() critical sections preemptible.

 fs/proc/proc_misc.c      |   81 ++++
 include/linux/rcupdate.h |   50 ++-
 include/linux/sched.h    |    5 
 kernel/Kconfig.preempt   |   36 ++
 kernel/rcupdate.c        |  783 +++++++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 918 insertions(+), 37 deletions(-)

Index: linux/fs/proc/proc_misc.c
===================================================================
--- linux.orig/fs/proc/proc_misc.c
+++ linux/fs/proc/proc_misc.c
@@ -563,6 +563,78 @@ void create_seq_entry(char *name, mode_t
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
@@ -585,6 +657,15 @@ void __init proc_misc_init(void)
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
Index: linux/include/linux/rcupdate.h
===================================================================
--- linux.orig/include/linux/rcupdate.h
+++ linux/include/linux/rcupdate.h
@@ -59,6 +59,7 @@ struct rcu_head {
 } while (0)
 
 
+#ifndef CONFIG_PREEMPT_RCU
 
 /* Global control variables for rcupdate callback mechanism. */
 struct rcu_ctrlblk {
@@ -99,6 +100,9 @@ struct rcu_data {
 	struct rcu_head *donelist;
 	struct rcu_head **donetail;
 	int cpu;
+#ifdef CONFIG_PREEMPT_RCU
+	atomic_t	active_readers;
+#endif
 };
 
 DECLARE_PER_CPU(struct rcu_data, rcu_data);
@@ -115,12 +119,18 @@ extern struct rcu_ctrlblk rcu_bh_ctrlblk
 static inline void rcu_qsctr_inc(int cpu)
 {
 	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
-	rdp->passed_quiesc = 1;
+#ifdef CONFIG_PREEMPT_RCU
+	if (!atomic_read(&rdp->active_readers))
+#endif
+		rdp->passed_quiesc = 1;
 }
 static inline void rcu_bh_qsctr_inc(int cpu)
 {
 	struct rcu_data *rdp = &per_cpu(rcu_bh_data, cpu);
-	rdp->passed_quiesc = 1;
+#ifdef CONFIG_PREEMPT_RCU
+	if (!atomic_read(&rdp->active_readers))
+#endif
+		rdp->passed_quiesc = 1;
 }
 
 static inline int __rcu_pending(struct rcu_ctrlblk *rcp,
@@ -183,14 +193,34 @@ static inline int rcu_pending(int cpu)
  *
  * It is illegal to block while in an RCU read-side critical section.
  */
-#define rcu_read_lock()		preempt_disable()
+#ifdef CONFIG_PREEMPT_RCU
+  extern void rcu_read_lock(void);
+#else
+# define rcu_read_lock preempt_disable
+#endif
 
 /**
  * rcu_read_unlock - marks the end of an RCU read-side critical section.
  *
  * See rcu_read_lock() for more information.
  */
-#define rcu_read_unlock()	preempt_enable()
+#ifdef CONFIG_PREEMPT_RCU
+  extern void rcu_read_unlock(void);
+#else
+# define rcu_read_unlock preempt_enable
+#endif
+
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
 
 /*
  * So where is rcu_write_lock()?  It does not exist, as there is no
@@ -213,14 +243,22 @@ static inline int rcu_pending(int cpu)
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
@@ -269,7 +307,11 @@ static inline int rcu_pending(int cpu)
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
Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h
+++ linux/include/linux/sched.h
@@ -623,6 +623,11 @@ struct task_struct {
 	cpumask_t cpus_allowed;
 	unsigned int time_slice, first_time_slice;
 
+#ifdef CONFIG_PREEMPT_RCU
+	int rcu_read_lock_nesting;
+	atomic_t *rcu_flipctr1;
+	atomic_t *rcu_flipctr2;
+#endif
 #ifdef CONFIG_SCHEDSTATS
 	struct sched_info sched_info;
 #endif
Index: linux/kernel/Kconfig.preempt
===================================================================
--- linux.orig/kernel/Kconfig.preempt
+++ linux/kernel/Kconfig.preempt
@@ -63,3 +63,39 @@ config PREEMPT_BKL
 	  Say Y here if you are building a kernel for a desktop system.
 	  Say N if you are unsure.
 
+config PREEMPT_RCU
+	bool "Preemptible RCU"
+	default n
+	depends on PREEMPT
+	help
+	  This option reduces the latency of the kernel by making certain
+	  RCU sections preemptible. Normally RCU code is non-preemptible, if
+	  this option is selected then read-only RCU sections become
+	  preemptible. This helps latency, but may expose bugs due to
+	  now-naive assumptions about each RCU read-side critical section
+	  remaining on a given CPU through its execution.
+
+	  Say N if you are unsure.
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
Index: linux/kernel/rcupdate.c
===================================================================
--- linux.orig/kernel/rcupdate.c
+++ linux/kernel/rcupdate.c
@@ -19,15 +19,15 @@
  *
  * Authors: Dipankar Sarma <dipankar@in.ibm.com>
  *	    Manfred Spraul <manfred@colorfullife.com>
+ *	    Paul E. McKenney <paulmck@us.ibm.com> (PREEMPT_RCU)
  * 
  * Based on the original work by Paul McKenney <paulmck@us.ibm.com>
  * and inputs from Rusty Russell, Andrea Arcangeli and Andi Kleen.
- * Papers:
- * http://www.rdrop.com/users/paulmck/paper/rclockpdcsproof.pdf
- * http://lse.sourceforge.net/locking/rclock_OLS.2001.05.01c.sc.pdf (OLS2001)
+ *
+ * Papers:  http://www.rdrop.com/users/paulmck/RCU
  *
  * For detailed explanation of Read-Copy Update mechanism see -
- * 		http://lse.sourceforge.net/locking/rcupdate.html
+ * 		Documentation/RCU/ *.txt
  *
  */
 #include <linux/types.h>
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
@@ -429,42 +472,395 @@ void __init rcu_init(void)
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
+# define raw_spinlock_t spinlock_t
+# define RAW_SPIN_LOCK_UNLOCKED SPIN_LOCK_UNLOCKED
+# define raw_local_irq_save local_irq_save
+# define raw_local_irq_restore local_irq_restore
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
+};
+static struct rcu_data rcu_data;
+static struct rcu_ctrlblk rcu_ctrlblk = {
+	.fliplock = RAW_SPIN_LOCK_UNLOCKED,
+	.batch = 0,
 };
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
+static struct rcu_torture rcu_tortures[10 * RCU_TORTURE_PIPE_LEN];
+static DEFINE_SPINLOCK(rcu_torture_lock);
+static DEFINE_PER_CPU(long [RCU_TORTURE_PIPE_LEN + 1], rcu_torture_count) =
+	{ 0 };
+static DEFINE_PER_CPU(long [RCU_TORTURE_PIPE_LEN + 1], rcu_torture_batch) =
+	{ 0 };
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
+
+	flipctr = rcu_ctrlblk.batch;
+#ifdef CONFIG_RCU_STATS
+	atomic_inc(&rcu_data.n_rcu_try_flip1);
+#endif /* #ifdef CONFIG_RCU_STATS */
+	if (unlikely(!spin_trylock_irqsave(&rcu_ctrlblk.fliplock, oldirq))) {
+#ifdef CONFIG_RCU_STATS
+		atomic_inc(&rcu_data.n_rcu_try_flip_e1);
+#endif /* #ifdef CONFIG_RCU_STATS */
+		return;
+	}
+	if (unlikely(flipctr != rcu_ctrlblk.batch)) {
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
 
-	init_completion(&rcu.completion);
-	/* Will wake me after RCU finished */
-	call_rcu(&rcu.head, wakeme_after_rcu);
+	/*
+	 * Check for completion of all RCU read-side critical sections
+	 * that started prior to the previous flip.
+	 */
 
-	/* Wait for it */
-	wait_for_completion(&rcu.completion);
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
+	if (rcu_ctrlblk.batch == rcu_data.batch) {
+		rcu_try_flip();
+		if (rcu_ctrlblk.batch == rcu_data.batch) {
+			return;
+		}
+	}
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
+	for (i = 0; i < sizeof(rcu_tortures) / sizeof(rcu_tortures[0]); i++) {
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
@@ -475,8 +871,329 @@ void synchronize_kernel(void)
 	synchronize_rcu();
 }
 
-module_param(maxbatch, int, 0);
-EXPORT_SYMBOL(call_rcu);  /* WARNING: GPL-only in April 2006. */
-EXPORT_SYMBOL(call_rcu_bh);  /* WARNING: GPL-only in April 2006. */
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
+
+	synchronize_rcu();
+	return sprintf(page, "oldggp=%ld  newggp=%ld\n",
+		       oldgp, rcu_ctrlblk.batch);
+}
+
+int rcu_read_proc_ptrs_data(char *page)
+{
+	return sprintf(page,
+		       "nl=%p/%p nt=%p\n wl=%p/%p wt=%p dl=%p/%p dt=%p\n",
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
+	}
+	cnt += sprintf(&page[cnt], "ggp = %ld\n", rcu_data.batch);
+	return (cnt);
+}
+
+#ifdef CONFIG_RCU_TORTURE_TEST
+
+/*
+ * Allocate an element from the rcu_tortures pool.
+ */
+struct rcu_torture *
+rcu_torture_alloc(void)
+{
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
+		schedule_timeout(1);
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
+	int batch;
+	DEFINE_RCU_RANDOM(rand);
+	struct rcu_torture *p;
+	int pipe_count;
+
+	while (!signal_pending(current)) {
+		rcu_read_lock();
+		batch = rcu_ctrlblk.batch;
+		p = rcu_torture_current;
+		if (p == NULL) {
+			rcu_read_unlock();
+			return sprintf(page, "Need to do /proc/rcutw!\n");
+		}
+		udelay(rcu_random(&rand) & 0x7f);
+		preempt_disable();
+		pipe_count = p->rtort_pipe_count;
+		if (pipe_count > RCU_TORTURE_PIPE_LEN) {
+			/* Should not happen, but... */
+			pipe_count = RCU_TORTURE_PIPE_LEN;
+		}
+		++__get_cpu_var(rcu_torture_count)[pipe_count];
+		batch = rcu_ctrlblk.batch - batch;
+		if (batch > RCU_TORTURE_PIPE_LEN) {
+			/* Should not happen, but... */
+			batch = RCU_TORTURE_PIPE_LEN;
+		}
+		++__get_cpu_var(rcu_torture_batch)[batch];
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
+	int cpu;
+	int i;
+	long pipesummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
+	long batchsummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
+
+	for_each_cpu(cpu) {
+		for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++) {
+			pipesummary[i] += per_cpu(rcu_torture_count, cpu)[i];
+			batchsummary[i] += per_cpu(rcu_torture_batch, cpu)[i];
+		}
+	}
+	for (i = RCU_TORTURE_PIPE_LEN - 1; i >= 0; i--) {
+		if (pipesummary[i] != 0) {
+			break;
+		}
+	}
+	cnt += sprintf(&page[cnt],
+		       "rtc: %p ver: %ld tfle: %d rta: %d rtaf: %d rtf: %d\n",
+		       rcu_torture_current,
+		       rcu_torture_current_version,
+		       list_empty(&rcu_torture_freelist),
+		       atomic_read(&rcu_data.n_rcu_torture_alloc),
+		       atomic_read(&rcu_data.n_rcu_torture_alloc_fail),
+		       atomic_read(&rcu_data.n_rcu_torture_free));
+	if (i > 1) {
+		cnt += sprintf(&page[cnt], "!!! ");
+	}
+	cnt += sprintf(&page[cnt], "Reader Pipe: ");
+	for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++) {
+		cnt += sprintf(&page[cnt], " %ld", pipesummary[i]);
+	}
+	cnt += sprintf(&page[cnt], "\nReader Batch: ");
+	for (i = 0; i < RCU_TORTURE_PIPE_LEN; i++) {
+		cnt += sprintf(&page[cnt], " %ld", batchsummary[i]);
+	}
+	cnt += sprintf(&page[cnt], "\nFree-Block Circulation: ");
+	for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++) {
+		cnt += sprintf(&page[cnt], " %d",
+			       atomic_read(&rcu_torture_wcount[i]));
+	}
+	cnt += sprintf(&page[cnt], "\n");
+	return (cnt);
+
+}
+
+#endif /* #ifdef CONFIG_RCU_TORTURE_TEST */
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

--d6Gm4EdcadzBjdND--
