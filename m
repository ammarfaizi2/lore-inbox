Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbVKMUpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbVKMUpH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 15:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbVKMUpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 15:45:07 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:37780 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750770AbVKMUpE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 15:45:04 -0500
Date: Sun, 13 Nov 2005 12:45:42 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: [PATCH -rt] Make rcutorture be a module
Message-ID: <20051113204542.GA8739@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Make rcutorture be a module, as it currently is in mainline.  Also add
a definite success/failure indication and a test for architecture-specific
memory barriers (in their interaction with RCU).

Signed-off-by: <paulmck@us.ibm.com>

---

 Documentation/RCU/proc.txt    |   88 -------
 Documentation/RCU/torture.txt |  127 ++++++++++
 fs/proc/proc_misc.c           |   37 ---
 include/linux/rcupdate.h      |    1 
 kernel/Kconfig.preempt        |    9 
 kernel/Makefile               |    1 
 kernel/rcupdate.c             |  308 +------------------------
 kernel/rcutorture.c           |  512 ++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug             |   21 +
 mm/mmap.c                     |    2 
 10 files changed, 683 insertions(+), 423 deletions(-)

diff -urpNa -X dontdiff linux-2.6.14-rt10/Documentation/RCU/proc.txt linux-2.6.14-rt10-rcutorture/Documentation/RCU/proc.txt
--- linux-2.6.14-rt10/Documentation/RCU/proc.txt	2005-11-11 11:14:33.000000000 -0800
+++ linux-2.6.14-rt10-rcutorture/Documentation/RCU/proc.txt	2005-11-12 15:22:35.000000000 -0800
@@ -117,91 +117,3 @@ o	"rtfe2=": The number of attempts to fl
 o	"rtfe3=": The number of attempts to flip the counters that failed
 	due to some task still being in an RCU read-side critical section
 	starting from before the last successful counter flip.
-
-
-CONFIG_RCU_TORTURE_TEST
-
-The CONFIG_RCU_TORTURE_TEST config option is available for all RCU
-implementations.  It makes three /proc entries available, namely: rcutw,
-rcutr, and rcuts.
-
-
-/proc/rcutw
-
-Reading this entry starts a new torture test, or ends an earlier one
-if one is already in progress (in other words, there can be only one
-writer at a time).  This sleeps uninterruptibly, so be sure to run
-it in the background.  One could argue that it would be good to have
-multiple writers, but Linux uses RCU heavily enough that you will get
-write-side contention whether you want it or not.  If you want additional
-write-side contention, repeatedly create and destroy several large file
-trees in parallel.  Or use some other RCU-protected update.
-
-
-/proc/rcutr
-
-Reading this entry starts a new torture reader, which runs until sent
-a signal (e.g., control-C).  If testing an RCU implementation with
-preemptible read-side critical sections, make sure to spawn at least
-two /proc/rcutr instances for each CPU.
-
-
-/proc/rcuts
-
-Displays the current state of the torture test:
-
-	ggp = 20961
-	rtc: c04496f4 ver: 8734 tfle: 0 rta: 8734 rtaf: 0 rtf: 8715
-	Reader Pipe:  88024120 63914 0 0 0 0 0 0 0 0 0
-	Reader Batch:  88024097 63937 0 0 0 0 0 0 0 0
-	Free-Block Circulation:  8733 8731 8729 8727 8725 8723 8721 8719 8717 8715 0
-
-The entries are as follows:
-
-o	"ggp": The number of counter flips (or batches) since boot.
-
-o	"rtc": The hexadecimal address of the structure currently visible
-	to readers.
-
-o	"ver": The number of times since boot that the rcutw writer task
-	has changed the structure visible to readers.
-
-o	"tfle": If non-zero, indicates that the "torture freelist"
-	containing structure to be placed into the "rtc" area is empty.
-	This condition is important, since it can fool you into thinking
-	that RCU is working when it is not.  :-/
-
-o	"rta": Number of structures allocated from the torture freelist.
-
-o	"rtaf": Number of allocations from the torture freelist that have
-	failed due to the list being empty.
-
-o	"rtf": Number of frees into the torture freelist.
-
-o	"Reader Pipe": Histogram of "ages" of structures seen by readers.
-	If any entries past the first two are non-zero, RCU is broken.
-	And /proc/rcuts prints "!!!" to make sure you notice.  The age
-	of a newly allocated structure is zero, it becomes one when
-	removed from reader visibility, and is incremented once per
-	grace period subsequently -- and is freed after passing through
-	(RCU_TORTURE_PIPE_LEN-2) grace periods.
-
-	The output displayed above was taken from a correctly working
-	RCU.  If you want to see what it looks like when broken, break
-	it yourself.  ;-)
-
-o	"Reader Batch": Another histogram of "ages" of structures seen
-	by readers, but in terms of counter flips (or batches) rather
-	than in terms of grace periods.  The legal number of non-zero
-	entries is again two.  The reason for this separate view is
-	that it is easier to get the third entry to show up in the
-	"Reader Batch" list than in the "Reader Pipe" list.
-
-o	"Free-Block Circulation": Shows the number of torture structures
-	that have reached a given point in the pipeline.  The first element
-	should closely correspond to the number of structures allocated,
-	the second to the number that have been removed from reader view,
-	and all but the last remaining to the corresponding number of
-	passes through a grace period.  The last entry should be zero,
-	as it is only incremented if a torture structure's counter
-	somehow gets incremented farther than it should.
diff -urpNa -X dontdiff linux-2.6.14-rt10/Documentation/RCU/torture.txt linux-2.6.14-rt10-rcutorture/Documentation/RCU/torture.txt
--- linux-2.6.14-rt10/Documentation/RCU/torture.txt	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.14-rt10-rcutorture/Documentation/RCU/torture.txt	2005-11-13 09:41:42.000000000 -0800
@@ -0,0 +1,127 @@
+RCU Torture Test Operation
+
+
+CONFIG_RCU_TORTURE_TEST
+
+The CONFIG_RCU_TORTURE_TEST config option is available for all RCU
+implementations.  It creates an rcutorture kernel module that can
+be loaded to run a torture test.  The test periodically outputs
+status messages via printk(), which can be examined via the dmesg
+command (perhaps grepping for "rcutorture").  The test is started
+when the module is loaded, and stops when the module is unloaded.
+
+However, actually setting this config option to "y" results in the system
+running the test immediately upon boot, and ending only when the system
+is taken down.  Normally, one will instead want to build the system
+with CONFIG_RCU_TORTURE_TEST=m and to use modprobe and rmmod to control
+the test, perhaps using a script similar to the one shown at the end of
+this document.  Note that you will need CONFIG_MODULE_UNLOAD in order
+to be able to end the test.
+
+
+MODULE PARAMETERS
+
+This module has the following parameters:
+
+nreaders	This is the number of RCU reading threads supported.
+		The default is twice the number of CPUs.  Why twice?
+		To properly exercise RCU implementations with preemptible
+		read-side critical sections.
+
+stat_interval	The number of seconds between output of torture
+		statistics (via printk()).  Regardless of the interval,
+		statistics are printed when the module is unloaded.
+		Setting the interval to zero causes the statistics to
+		be printed -only- when the module is unloaded, and this
+		is the default.
+
+verbose		Enable debug printk()s.  Default is disabled.
+
+
+OUTPUT
+
+The statistics output is as follows:
+
+	rcutorture: --- Start of test: nreaders=16 stat_interval=0 verbose=0
+	rcutorture: rtc: 0000000000000000 ver: 1916 tfle: 0 rta: 1916 rtaf: 0 rtf: 1915 rtbme: 0
+	rcutorture: Reader Pipe:  1466408 9747 0 0 0 0 0 0 0 0 0
+	rcutorture: Reader Batch:  1464477 11678 0 0 0 0 0 0 0 0
+	rcutorture: Free-Block Circulation:  1915 1915 1915 1915 1915 1915 1915 1915 1915 1915 0
+	rcutorture: --- End of test: SUCCESS
+
+The command "dmesg | grep rcutorture:" will extract this information on
+most systems.  On more esoteric configurations, it may be necessary to
+use other commands to access the output of the printk()s used by
+the RCU torture test.  The printk()s use KERN_ALERT, so they should
+be evident.  ;-)
+
+The entries are as follows:
+
+o	"ggp": The number of counter flips (or batches) since boot.
+
+o	"rtc": The hexadecimal address of the structure currently visible
+	to readers.
+
+o	"ver": The number of times since boot that the rcutw writer task
+	has changed the structure visible to readers.
+
+o	"tfle": If non-zero, indicates that the "torture freelist"
+	containing structure to be placed into the "rtc" area is empty.
+	This condition is important, since it can fool you into thinking
+	that RCU is working when it is not.  :-/
+
+o	"rta": Number of structures allocated from the torture freelist.
+
+o	"rtaf": Number of allocations from the torture freelist that have
+	failed due to the list being empty.
+
+o	"rtf": Number of frees into the torture freelist.
+
+o	"rtmbe": Number of memory-barrier failures detected (which would
+	indicate problems with either the test itself or the underlying
+	memory-barrier primitives for the CPU architecture on which the
+	failure occurred.
+
+o	"Reader Pipe": Histogram of "ages" of structures seen by readers.
+	If any entries past the first two are non-zero, RCU is broken.
+	And rcutorture prints the error flag string "!!!" to make sure
+	you notice.  The age of a newly allocated structure is zero,
+	it becomes one when removed from reader visibility, and is
+	incremented once per grace period subsequently -- and is freed
+	after passing through (RCU_TORTURE_PIPE_LEN-2) grace periods.
+
+	The output displayed above was taken from a correctly working
+	RCU.  If you want to see what it looks like when broken, break
+	it yourself.  ;-)
+
+o	"Reader Batch": Another histogram of "ages" of structures seen
+	by readers, but in terms of counter flips (or batches) rather
+	than in terms of grace periods.  The legal number of non-zero
+	entries is again two.  The reason for this separate view is
+	that it is easier to get the third entry to show up in the
+	"Reader Batch" list than in the "Reader Pipe" list.
+
+o	"Free-Block Circulation": Shows the number of torture structures
+	that have reached a given point in the pipeline.  The first element
+	should closely correspond to the number of structures allocated,
+	the second to the number that have been removed from reader view,
+	and all but the last remaining to the corresponding number of
+	passes through a grace period.  The last entry should be zero,
+	as it is only incremented if a torture structure's counter
+	somehow gets incremented farther than it should.
+
+
+USAGE
+
+The following script may be used to torture RCU:
+
+	#!/bin/sh
+
+	modprobe rcutorture
+	sleep 100
+	rmmod rcutorture
+	dmesg | grep rcutorture:
+
+The output can be manually inspected for the error flag of "!!!".
+One could of course create a more elaborate script that automatically
+checked for such errors.
diff -urpNa -X dontdiff linux-2.6.14-rt10/fs/proc/proc_misc.c linux-2.6.14-rt10-rcutorture/fs/proc/proc_misc.c
--- linux-2.6.14-rt10/fs/proc/proc_misc.c	2005-11-11 11:14:37.000000000 -0800
+++ linux-2.6.14-rt10-rcutorture/fs/proc/proc_misc.c	2005-11-12 21:01:50.000000000 -0800
@@ -655,38 +655,6 @@ int rcu_read_proc_ctrs(char *page, char 
 }
 #endif /* #ifdef CONFIG_RCU_STATS */
 
-#ifdef CONFIG_RCU_TORTURE_TEST
-int rcu_read_proc_torture_writer(char *page, char **start, off_t off,
-			         int count, int *eof, void *data)
-{
-	int len;
-	extern int rcu_read_proc_torture_writer_data(char *page);
-
-	len = rcu_read_proc_torture_writer_data(page);
-	return proc_calc_metrics(page, start, off, count, eof, len);
-}
-
-int rcu_read_proc_torture_reader(char *page, char **start, off_t off,
-			         int count, int *eof, void *data)
-{
-	int len;
-	extern int rcu_read_proc_torture_reader_data(char *page);
-
-	len = rcu_read_proc_torture_reader_data(page);
-	return proc_calc_metrics(page, start, off, count, eof, len);
-}
-
-int rcu_read_proc_torture_stats(char *page, char **start, off_t off,
-			        int count, int *eof, void *data)
-{
-	int len;
-	extern int rcu_read_proc_torture_stats_data(char *page);
-
-	len = rcu_read_proc_torture_stats_data(page);
-	return proc_calc_metrics(page, start, off, count, eof, len);
-}
-#endif /* #ifdef CONFIG_RCU_TORTURE_TEST */
-
 void __init proc_misc_init(void)
 {
 	struct proc_dir_entry *entry;
@@ -715,11 +683,6 @@ void __init proc_misc_init(void)
 		{"rcuptrs",	rcu_read_proc_ptrs},
 		{"rcuctrs",	rcu_read_proc_ctrs},
 #endif /* #ifdef CONFIG_RCU_STATS */
-#ifdef CONFIG_RCU_TORTURE_TEST
-		{"rcutw",	rcu_read_proc_torture_writer},
-		{"rcutr",	rcu_read_proc_torture_reader},
-		{"rcuts",	rcu_read_proc_torture_stats},
-#endif /* #ifdef CONFIG_RCU_TORTURE_TEST */
 		{NULL,}
 	};
 	for (p = simple_ones; p->name; p++)
diff -urpNa -X dontdiff linux-2.6.14-rt10/include/linux/rcupdate.h linux-2.6.14-rt10-rcutorture/include/linux/rcupdate.h
--- linux-2.6.14-rt10/include/linux/rcupdate.h	2005-11-11 11:14:38.000000000 -0800
+++ linux-2.6.14-rt10-rcutorture/include/linux/rcupdate.h	2005-11-12 15:12:02.000000000 -0800
@@ -300,6 +300,7 @@ extern void synchronize_sched(void);
 extern void rcu_init(void);
 extern void rcu_check_callbacks(int cpu, int user);
 extern void rcu_restart_cpu(int cpu);
+extern long rcu_batches_completed(void);
 
 /* Exported interfaces */
 extern void FASTCALL(call_rcu(struct rcu_head *head, 
diff -urpNa -X dontdiff linux-2.6.14-rt10/kernel/Kconfig.preempt linux-2.6.14-rt10-rcutorture/kernel/Kconfig.preempt
--- linux-2.6.14-rt10/kernel/Kconfig.preempt	2005-11-11 11:14:39.000000000 -0800
+++ linux-2.6.14-rt10-rcutorture/kernel/Kconfig.preempt	2005-11-12 22:38:42.000000000 -0800
@@ -163,12 +163,3 @@ config RCU_STATS
 	  Say Y here if you want to see RCU stats in /proc
 	  Say N if you are unsure.
 
-config RCU_TORTURE_TEST
-	bool "/proc torture tests for RCU"
-	default y
-	help
-	  This option provides /proc files that run torture tests on
-	  the preemptible realtime RCU implementation.
-
-	  Say Y here if you want to be able to run RCU torture tests.
-	  Say N if you are unsure.
diff -urpNa -X dontdiff linux-2.6.14-rt10/kernel/Makefile linux-2.6.14-rt10-rcutorture/kernel/Makefile
--- linux-2.6.14-rt10/kernel/Makefile	2005-11-11 11:14:39.000000000 -0800
+++ linux-2.6.14-rt10-rcutorture/kernel/Makefile	2005-11-12 15:12:02.000000000 -0800
@@ -38,6 +38,7 @@ obj-$(CONFIG_DETECT_SOFTLOCKUP) += softl
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
+obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -urpNa -X dontdiff linux-2.6.14-rt10/kernel/rcupdate.c linux-2.6.14-rt10-rcutorture/kernel/rcupdate.c
--- linux-2.6.14-rt10/kernel/rcupdate.c	2005-11-11 11:14:39.000000000 -0800
+++ linux-2.6.14-rt10-rcutorture/kernel/rcupdate.c	2005-11-13 09:25:37.000000000 -0800
@@ -90,12 +90,6 @@ void synchronize_rcu(void)
 	wait_for_completion(&rcu.completion);
 }
 
-#ifdef CONFIG_RCU_TORTURE_TEST
-static void rcu_torture_init(void);
-#else
-static inline void rcu_torture_init(void) { }
-#endif
-
 #ifndef __HAVE_ARCH_CMPXCHG
 /*
  * We use an array of spinlocks for the rcurefs -- similar to ones in sparc
@@ -212,6 +206,15 @@ void fastcall call_rcu_bh(struct rcu_hea
 }
 
 /*
+ * Return the number of RCU batches processed thus far.  Useful
+ * for debug and statistics.
+ */
+long rcu_batches_completed(void)
+{
+	return rcu_ctrlblk.completed;
+}
+
+/*
  * Invoke the completed RCU callbacks. They are expected to be in
  * a per-cpu list.
  */
@@ -507,7 +510,6 @@ static struct notifier_block __devinitda
 void __init rcu_init(void)
 {
 	init_rcurefs();
-	rcu_torture_init();
 	rcu_cpu_notify(&rcu_nb, CPU_UP_PREPARE,
 			(void *)(long)smp_processor_id());
 	/* Register notifier for non-boot CPUs */
@@ -523,6 +525,7 @@ void synchronize_kernel(void)
 }
 
 module_param(maxbatch, int, 0);
+EXPORT_SYMBOL_GPL(rcu_batches_completed);
 EXPORT_SYMBOL(call_rcu);  /* WARNING: GPL-only in April 2006. */
 EXPORT_SYMBOL(call_rcu_bh);  /* WARNING: GPL-only in April 2006. */
 EXPORT_SYMBOL_GPL(synchronize_rcu);
@@ -570,6 +573,15 @@ static struct rcu_ctrlblk rcu_ctrlblk = 
 static DEFINE_PER_CPU(atomic_t [2], rcu_flipctr) =
 	{ ATOMIC_INIT(0), ATOMIC_INIT(0) };
 
+/*
+ * Return the number of RCU batches processed thus far.  Useful
+ * for debug and statistics.
+ */
+long rcu_batches_completed(void)
+{
+	return rcu_ctrlblk.completed;
+}
+
 void
 rcu_read_lock(void)
 {
@@ -845,7 +857,6 @@ rcu_pending(int cpu)
 void __init rcu_init(void)
 {
 	init_rcurefs();
-	rcu_torture_init();
 /*&&&&*/printk("WARNING: experimental RCU implementation.\n");
 	spin_lock_init(&rcu_data.lock);
 	rcu_data.completed = 0;
@@ -933,6 +944,7 @@ int rcu_read_proc_ctrs_data(char *page)
 
 #endif /* #ifdef CONFIG_RCU_STATS */
 
+EXPORT_SYMBOL_GPL(rcu_batches_completed);
 EXPORT_SYMBOL(call_rcu); /* WARNING: GPL-only in April 2006. */
 EXPORT_SYMBOL_GPL(synchronize_rcu);
 EXPORT_SYMBOL_GPL(synchronize_sched);
@@ -941,283 +953,3 @@ EXPORT_SYMBOL(rcu_read_unlock);  /* WARN
 EXPORT_SYMBOL(synchronize_kernel);  /* WARNING: Removal in April 2006. */
 
 #endif /* #else #ifndef CONFIG_PREEMPT_RCU */
-
-#ifdef CONFIG_RCU_TORTURE_TEST
-
-#define RCU_TORTURE_PIPE_LEN 10
-
-struct rcu_torture {
-	struct rcu_head rtort_rcu;
-	int rtort_pipe_count;
-	struct list_head rtort_free;
-};
-
-static LIST_HEAD(rcu_torture_freelist);
-static struct rcu_torture *rcu_torture_current = NULL;
-static long rcu_torture_current_version = 0;
-static struct rcu_torture rcu_tortures[10 * RCU_TORTURE_PIPE_LEN];
-static DEFINE_SPINLOCK(rcu_torture_lock);
-static DEFINE_PER_CPU(long [RCU_TORTURE_PIPE_LEN + 1], rcu_torture_count) =
-	{ 0 };
-static DEFINE_PER_CPU(long [RCU_TORTURE_PIPE_LEN + 1], rcu_torture_batch) =
-	{ 0 };
-static atomic_t rcu_torture_wcount[RCU_TORTURE_PIPE_LEN + 1] =
-	{ ATOMIC_INIT(0) };
-#define RCU_TORTURE_NOWRITER		0
-#define RCU_TORTURE_WRITERACTIVE	1
-#define RCU_TORTURE_STOPWRITER		2
-static int rcu_torture_wstatus = RCU_TORTURE_NOWRITER;
-atomic_t n_rcu_torture_alloc = ATOMIC_INIT(0);
-atomic_t n_rcu_torture_alloc_fail = ATOMIC_INIT(0);
-atomic_t n_rcu_torture_free = ATOMIC_INIT(0);
-
-/*
- * Allocate an element from the rcu_tortures pool.
- */
-struct rcu_torture *
-rcu_torture_alloc(void)
-{
-	struct list_head *p;
-
-	spin_lock(&rcu_torture_lock);
-	if (list_empty(&rcu_torture_freelist)) {
-		atomic_inc(&n_rcu_torture_alloc_fail);
-		spin_unlock(&rcu_torture_lock);
-		return (NULL);
-	}
-	atomic_inc(&n_rcu_torture_alloc);
-	p = rcu_torture_freelist.next;
-	list_del_init(p);
-	spin_unlock(&rcu_torture_lock);
-	return (container_of(p, struct rcu_torture, rtort_free));
-}
-
-/*
- * Free an element to the rcu_tortures pool.
- */
-void
-rcu_torture_free(struct rcu_torture *p)
-{
-	atomic_inc(&n_rcu_torture_free);
-	spin_lock(&rcu_torture_lock);
-	list_add_tail(&p->rtort_free, &rcu_torture_freelist);
-	spin_unlock(&rcu_torture_lock);
-}
-
-void
-rcu_torture_cb(struct rcu_head *p)
-{
-	int i;
-	struct rcu_torture *rp = container_of(p, struct rcu_torture, rtort_rcu);
-
-	i = rp->rtort_pipe_count;
-	if (i > RCU_TORTURE_PIPE_LEN) {
-		i = RCU_TORTURE_PIPE_LEN;
-	}
-	atomic_inc(&rcu_torture_wcount[i]);
-	if (++rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
-		rcu_torture_free(rp);
-	} else {
-		call_rcu(p, rcu_torture_cb);
-	}
-}
-
-struct rcu_random_state {
-	unsigned long rrs_state;
-	unsigned long rrs_count;
-};
-
-#define RCU_RANDOM_MULT 39916801  /* prime */
-#define RCU_RANDOM_ADD	479001701 /* prime */
-#define RCU_RANDOM_REFRESH 10000
-
-#define DEFINE_RCU_RANDOM(name) struct rcu_random_state name = { 0, 0 }
-
-/*
- * Crude but fast random-number generator.  Uses a linear congruential
- * generator, with occasional help from get_random_bytes().
- */
-static long
-rcu_random(struct rcu_random_state *rrsp)
-{
-	long refresh;
-
-	if (--rrsp->rrs_count < 0) {
-		get_random_bytes(&refresh, sizeof(refresh));
-		rrsp->rrs_state += refresh;
-		rrsp->rrs_count = RCU_RANDOM_REFRESH;
-	}
-	rrsp->rrs_state = rrsp->rrs_state * RCU_RANDOM_MULT + RCU_RANDOM_ADD;
-	return (swahw32(rrsp->rrs_state));
-}
-
-/*
- * Handles /proc/rcutw.  Unusual in that the user must cat /proc/rcutw
- * a second time to allow the first read of /proc/rcutw to complete.
- * Only one writer may be in existence at a time.
- */
-int
-rcu_read_proc_torture_writer_data(char *page)
-{
-	int i;
-	long oldbatch = rcu_ctrlblk.completed;
-	struct rcu_torture *rp;
-	struct rcu_torture *old_rp;
-	static DEFINE_RCU_RANDOM(rand);
-
-	spin_lock(&rcu_torture_lock);
-	if (rcu_torture_wstatus == RCU_TORTURE_WRITERACTIVE) {
-		rcu_torture_wstatus = RCU_TORTURE_STOPWRITER;
-		spin_unlock(&rcu_torture_lock);
-		return sprintf(page, "Terminating prior /proc/rcutw test.\n");
-	} else if (rcu_torture_wstatus == RCU_TORTURE_STOPWRITER) {
-		spin_unlock(&rcu_torture_lock);
-		return sprintf(page, "Wait for prior /proc/rcutw test.\n");
-	} else if (rcu_torture_wstatus != RCU_TORTURE_NOWRITER) {
-		return sprintf(page, "Unexpected rcu_torture_wstatus = %d",
-			       rcu_torture_wstatus);
-	}
-	rcu_torture_wstatus = RCU_TORTURE_WRITERACTIVE;
-	spin_unlock(&rcu_torture_lock);
-	while (rcu_torture_wstatus == RCU_TORTURE_WRITERACTIVE) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1);
-		if (rcu_ctrlblk.completed == oldbatch) {
-			continue;
-		}
-		if ((rp = rcu_torture_alloc()) == NULL) {
-			continue;
-		}
-		rp->rtort_pipe_count = 0;
-		udelay(rcu_random(&rand) & 0x3ff);
-		old_rp = rcu_torture_current;
-		rcu_assign_pointer(rcu_torture_current, rp);
-		smp_wmb();
-		if (old_rp != NULL) {
-			i = old_rp->rtort_pipe_count;
-			if (i > RCU_TORTURE_PIPE_LEN) {
-				i = RCU_TORTURE_PIPE_LEN;
-			}
-			atomic_inc(&rcu_torture_wcount[i]);
-			old_rp->rtort_pipe_count++;
-			call_rcu(&old_rp->rtort_rcu, rcu_torture_cb);
-		}
-		rcu_torture_current_version++;
-		oldbatch = rcu_ctrlblk.completed;
-	}
-
-	spin_lock(&rcu_torture_lock);
-	rcu_torture_wstatus = RCU_TORTURE_NOWRITER;
-	spin_unlock(&rcu_torture_lock);
-
-	return sprintf(page, "End of /proc/rcutw\n");
-}
-
-/*
- * Handles /proc/rcutr.  Unusual in that the user must send a signal
- * to the process to allow the read to complete.  Multiple readers
- * may run in parallel, but each must be sent a separate signal to
- * stop.
- */
-int
-rcu_read_proc_torture_reader_data(char *page)
-{
-	int completed;
-	DEFINE_RCU_RANDOM(rand);
-	struct rcu_torture *p;
-	int pipe_count;
-
-	while (!signal_pending(current)) {
-		rcu_read_lock();
-		completed = rcu_ctrlblk.completed;
-		p = rcu_torture_current;
-		if (p == NULL) {
-			rcu_read_unlock();
-			return sprintf(page, "Need to do /proc/rcutw!\n");
-		}
-		udelay(rcu_random(&rand) & 0x7f);
-		preempt_disable();
-		pipe_count = p->rtort_pipe_count;
-		if (pipe_count > RCU_TORTURE_PIPE_LEN) {
-			/* Should not happen, but... */
-			pipe_count = RCU_TORTURE_PIPE_LEN;
-		}
-		++__get_cpu_var(rcu_torture_count)[pipe_count];
-		completed = rcu_ctrlblk.completed - completed;
-		if (completed > RCU_TORTURE_PIPE_LEN) {
-			/* Should not happen, but... */
-			completed = RCU_TORTURE_PIPE_LEN;
-		}
-		++__get_cpu_var(rcu_torture_batch)[completed];
-		preempt_enable();
-		rcu_read_unlock();
-		schedule();
-	}
-	return sprintf(page, "End of /proc/rcutr\n");
-}
-
-/*
- * Handles /proc/rcuts, printing out counts of how long readers were
- * allowed to look at RCU-protected data structures.
- */
-int
-rcu_read_proc_torture_stats_data(char *page)
-{
-	int cnt = 0;
-	int cpu;
-	int i;
-	long pipesummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
-	long batchsummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
-
-	for_each_cpu(cpu) {
-		for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++) {
-			pipesummary[i] += per_cpu(rcu_torture_count, cpu)[i];
-			batchsummary[i] += per_cpu(rcu_torture_batch, cpu)[i];
-		}
-	}
-	for (i = RCU_TORTURE_PIPE_LEN - 1; i >= 0; i--) {
-		if (pipesummary[i] != 0) {
-			break;
-		}
-	}
-	cnt += sprintf(&page[cnt],
-		       "rtc: %p ver: %ld tfle: %d rta: %d rtaf: %d rtf: %d\n",
-		       rcu_torture_current,
-		       rcu_torture_current_version,
-		       list_empty(&rcu_torture_freelist),
-		       atomic_read(&n_rcu_torture_alloc),
-		       atomic_read(&n_rcu_torture_alloc_fail),
-		       atomic_read(&n_rcu_torture_free));
-	if (i > 1) {
-		cnt += sprintf(&page[cnt], "!!! ");
-	}
-	cnt += sprintf(&page[cnt], "Reader Pipe: ");
-	for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++) {
-		cnt += sprintf(&page[cnt], " %ld", pipesummary[i]);
-	}
-	cnt += sprintf(&page[cnt], "\nReader Batch: ");
-	for (i = 0; i < RCU_TORTURE_PIPE_LEN; i++) {
-		cnt += sprintf(&page[cnt], " %ld", batchsummary[i]);
-	}
-	cnt += sprintf(&page[cnt], "\nFree-Block Circulation: ");
-	for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++) {
-		cnt += sprintf(&page[cnt], " %d",
-			       atomic_read(&rcu_torture_wcount[i]));
-	}
-	cnt += sprintf(&page[cnt], "\n");
-	return (cnt);
-
-}
-
-static void
-rcu_torture_init(void)
-{
-	int i;
-
-	for (i = 0; i < sizeof(rcu_tortures) / sizeof(rcu_tortures[0]); i++) {
-		list_add_tail(&rcu_tortures[i].rtort_free,
-			      &rcu_torture_freelist);
-	}
-}
-
-#endif /* #ifdef CONFIG_RCU_TORTURE_TEST */
diff -urpNa -X dontdiff linux-2.6.14-rt10/kernel/rcutorture.c linux-2.6.14-rt10-rcutorture/kernel/rcutorture.c
--- linux-2.6.14-rt10/kernel/rcutorture.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.14-rt10-rcutorture/kernel/rcutorture.c	2005-11-13 09:48:19.000000000 -0800
@@ -0,0 +1,512 @@
+/*
+ * Read-Copy Update module-based torture test facility
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) IBM Corporation, 2005
+ *
+ * Authors: Paul E. McKenney <paulmck@us.ibm.com>
+ *
+ * See also:  Documentation/RCU/torture.txt
+ */
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kthread.h>
+#include <linux/err.h>
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+#include <linux/rcupdate.h>
+#include <linux/interrupt.h>
+#include <linux/sched.h>
+#include <asm/atomic.h>
+#include <linux/bitops.h>
+#include <linux/module.h>
+#include <linux/completion.h>
+#include <linux/moduleparam.h>
+#include <linux/percpu.h>
+#include <linux/notifier.h>
+#include <linux/rcuref.h>
+#include <linux/cpu.h>
+#include <linux/random.h>
+#include <linux/delay.h>
+#include <linux/byteorder/swabb.h>
+#include <linux/stat.h>
+
+MODULE_LICENSE("GPL");
+
+static int nreaders = -1;	/* # reader threads, defaults to 4*ncpus */
+static int stat_interval = 0;	/* Interval between stats, in seconds. */
+				/*  Defaults to "only at end of test". */
+static int verbose = 0;		/* Print more debug info. */
+
+MODULE_PARM(nreaders, "i");
+MODULE_PARM_DESC(nreaders, "Number of RCU reader threads");
+MODULE_PARM(stat_interval, "i");
+MODULE_PARM_DESC(stat_interval, "Number of seconds between stats printk()s");
+MODULE_PARM(verbose, "i");
+MODULE_PARM_DESC(verbose, "Enable verbose debugging printk()s");
+#define TORTURE_FLAG "rcutorture: "
+#define PRINTK_STRING(s) \
+	do { printk(KERN_ALERT TORTURE_FLAG s "\n"); } while (0)
+#define VERBOSE_PRINTK_STRING(s) \
+	do { if (verbose) printk(KERN_ALERT TORTURE_FLAG s "\n"); } while (0)
+#define VERBOSE_PRINTK_ERRSTRING(s) \
+	do { if (verbose) printk(KERN_ALERT TORTURE_FLAG "!!! " s "\n"); } while (0)
+
+static char printk_buf[4096];
+
+static int nrealreaders;
+static struct task_struct *writer_task;
+static struct task_struct **reader_tasks;
+static struct task_struct *stats_task;
+
+#define RCU_TORTURE_PIPE_LEN 10
+
+struct rcu_torture {
+	struct rcu_head rtort_rcu;
+	int rtort_pipe_count;
+	struct list_head rtort_free;
+	int rtort_mbtest;
+};
+
+static int fullstop = 0;	/* stop generating callbacks at test end. */
+static LIST_HEAD(rcu_torture_freelist);
+static struct rcu_torture *rcu_torture_current = NULL;
+static long rcu_torture_current_version = 0;
+static struct rcu_torture rcu_tortures[10 * RCU_TORTURE_PIPE_LEN];
+static DEFINE_SPINLOCK(rcu_torture_lock);
+static DEFINE_PER_CPU(long [RCU_TORTURE_PIPE_LEN + 1], rcu_torture_count) =
+	{ 0 };
+static DEFINE_PER_CPU(long [RCU_TORTURE_PIPE_LEN + 1], rcu_torture_batch) =
+	{ 0 };
+static atomic_t rcu_torture_wcount[RCU_TORTURE_PIPE_LEN + 1];
+atomic_t n_rcu_torture_alloc;
+atomic_t n_rcu_torture_alloc_fail;
+atomic_t n_rcu_torture_free;
+atomic_t n_rcu_torture_mberror;
+atomic_t n_rcu_torture_error;
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
+		atomic_inc(&n_rcu_torture_alloc_fail);
+		spin_unlock(&rcu_torture_lock);
+		return NULL;
+	}
+	atomic_inc(&n_rcu_torture_alloc);
+	p = rcu_torture_freelist.next;
+	list_del_init(p);
+	spin_unlock(&rcu_torture_lock);
+	return container_of(p, struct rcu_torture, rtort_free);
+}
+
+/*
+ * Free an element to the rcu_tortures pool.
+ */
+static void
+rcu_torture_free(struct rcu_torture *p)
+{
+	atomic_inc(&n_rcu_torture_free);
+	spin_lock(&rcu_torture_lock);
+	list_add_tail(&p->rtort_free, &rcu_torture_freelist);
+	spin_unlock(&rcu_torture_lock);
+}
+
+static void
+rcu_torture_cb(struct rcu_head *p)
+{
+	int i;
+	struct rcu_torture *rp = container_of(p, struct rcu_torture, rtort_rcu);
+
+	if (fullstop) {
+		/* Test is ending, just drop callbacks on the floor. */
+		/* The next initialization will pick up the pieces. */
+		return;
+	}
+	i = rp->rtort_pipe_count;
+	if (i > RCU_TORTURE_PIPE_LEN)
+		i = RCU_TORTURE_PIPE_LEN;
+	atomic_inc(&rcu_torture_wcount[i]);
+	if (++rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
+		rp->rtort_mbtest = 0;
+		rcu_torture_free(rp);
+	} else
+		call_rcu(p, rcu_torture_cb);
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
+	return swahw32(rrsp->rrs_state);
+}
+
+/*
+ * RCU torture writer kthread.  Repeatedly substitutes a new structure
+ * for that pointed to by rcu_torture_current, freeing the old structure
+ * after a series of grace periods (the "pipeline").
+ */
+static int
+rcu_torture_writer(void *arg)
+{
+	int i;
+	long oldbatch = rcu_batches_completed();
+	struct rcu_torture *rp;
+	struct rcu_torture *old_rp;
+	static DEFINE_RCU_RANDOM(rand);
+
+	VERBOSE_PRINTK_STRING("rcu_torture_writer task started");
+	set_user_nice(current, 19);
+	do {
+		schedule_timeout_uninterruptible(1);
+		if (rcu_batches_completed() == oldbatch)
+			continue;
+		if ((rp = rcu_torture_alloc()) == NULL)
+			continue;
+		rp->rtort_pipe_count = 0;
+		udelay(rcu_random(&rand) & 0x3ff);
+		old_rp = rcu_torture_current;
+		rp->rtort_mbtest = 1;
+		rcu_assign_pointer(rcu_torture_current, rp);
+		smp_wmb();
+		if (old_rp != NULL) {
+			i = old_rp->rtort_pipe_count;
+			if (i > RCU_TORTURE_PIPE_LEN)
+				i = RCU_TORTURE_PIPE_LEN;
+			atomic_inc(&rcu_torture_wcount[i]);
+			old_rp->rtort_pipe_count++;
+			call_rcu(&old_rp->rtort_rcu, rcu_torture_cb);
+		}
+		rcu_torture_current_version++;
+		oldbatch = rcu_batches_completed();
+	} while (!kthread_should_stop() && !fullstop);
+	VERBOSE_PRINTK_STRING("rcu_torture_writer task stopping");
+	while (!kthread_should_stop())
+		schedule_timeout_uninterruptible(1);
+	return 0;
+}
+
+/*
+ * RCU torture reader kthread.  Repeatedly dereferences rcu_torture_current,
+ * incrementing the corresponding element of the pipeline array.  The
+ * counter in the element should never be greater than 1, otherwise, the
+ * RCU implementation is broken.
+ */
+static int
+rcu_torture_reader(void *arg)
+{
+	int completed;
+	DEFINE_RCU_RANDOM(rand);
+	struct rcu_torture *p;
+	int pipe_count;
+
+	VERBOSE_PRINTK_STRING("rcu_torture_reader task started");
+	set_user_nice(current, 19);
+	do {
+		rcu_read_lock();
+		completed = rcu_batches_completed();
+		p = rcu_dereference(rcu_torture_current);
+		if (p == NULL) {
+			/* Wait for rcu_torture_writer to get underway */
+			rcu_read_unlock();
+			schedule_timeout_interruptible(HZ);
+			continue;
+		}
+		if (p->rtort_mbtest == 0)
+			atomic_inc(&n_rcu_torture_mberror);
+		udelay(rcu_random(&rand) & 0x7f);
+		preempt_disable();
+		pipe_count = p->rtort_pipe_count;
+		if (pipe_count > RCU_TORTURE_PIPE_LEN) {
+			/* Should not happen, but... */
+			pipe_count = RCU_TORTURE_PIPE_LEN;
+		}
+		++__get_cpu_var(rcu_torture_count)[pipe_count];
+		completed = rcu_batches_completed() - completed;
+		if (completed > RCU_TORTURE_PIPE_LEN) {
+			/* Should not happen, but... */
+			completed = RCU_TORTURE_PIPE_LEN;
+		}
+		++__get_cpu_var(rcu_torture_batch)[completed];
+		preempt_enable();
+		rcu_read_unlock();
+		schedule();
+	} while (!kthread_should_stop() && !fullstop);
+	VERBOSE_PRINTK_STRING("rcu_torture_reader task stopping");
+	while (!kthread_should_stop())
+		schedule_timeout_uninterruptible(1);
+	return 0;
+}
+
+/*
+ * Create an RCU-torture statistics message in the specified buffer.
+ */
+static int
+rcu_torture_printk(char *page)
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
+		if (pipesummary[i] != 0)
+			break;
+	}
+	cnt += sprintf(&page[cnt], "rcutorture: ");
+	cnt += sprintf(&page[cnt],
+		       "rtc: %p ver: %ld tfle: %d rta: %d rtaf: %d rtf: %d "
+		       "rtmbe: %d",
+		       rcu_torture_current,
+		       rcu_torture_current_version,
+		       list_empty(&rcu_torture_freelist),
+		       atomic_read(&n_rcu_torture_alloc),
+		       atomic_read(&n_rcu_torture_alloc_fail),
+		       atomic_read(&n_rcu_torture_free),
+		       atomic_read(&n_rcu_torture_mberror));
+	if (atomic_read(&n_rcu_torture_mberror) != 0)
+		cnt += sprintf(&page[cnt], " !!!");
+	cnt += sprintf(&page[cnt], "\nrcutorture: ");
+	if (i > 1) {
+		cnt += sprintf(&page[cnt], "!!! ");
+		atomic_inc(&n_rcu_torture_error);
+	}
+	cnt += sprintf(&page[cnt], "Reader Pipe: ");
+	for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++)
+		cnt += sprintf(&page[cnt], " %ld", pipesummary[i]);
+	cnt += sprintf(&page[cnt], "\nrcutorture: ");
+	cnt += sprintf(&page[cnt], "Reader Batch: ");
+	for (i = 0; i < RCU_TORTURE_PIPE_LEN; i++)
+		cnt += sprintf(&page[cnt], " %ld", batchsummary[i]);
+	cnt += sprintf(&page[cnt], "\nrcutorture: ");
+	cnt += sprintf(&page[cnt], "Free-Block Circulation: ");
+	for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++) {
+		cnt += sprintf(&page[cnt], " %d",
+			       atomic_read(&rcu_torture_wcount[i]));
+	}
+	cnt += sprintf(&page[cnt], "\n");
+	return cnt;
+}
+
+/*
+ * Print torture statistics.  Caller must ensure that there is only
+ * one call to this function at a given time!!!  This is normally
+ * accomplished by relying on the module system to only have one copy
+ * of the module loaded, and then by giving the rcu_torture_stats
+ * kthread full control (or the init/cleanup functions when rcu_torture_stats
+ * thread is not running).
+ */
+static void
+rcu_torture_stats_print(void)
+{
+	int cnt;
+
+	cnt = rcu_torture_printk(printk_buf);
+	printk(KERN_ALERT "%s", printk_buf);
+}
+
+/*
+ * Periodically prints torture statistics, if periodic statistics printing
+ * was specified via the stat_interval module parameter.
+ *
+ * No need to worry about fullstop here, since this one doesn't reference
+ * volatile state or register callbacks.
+ */
+static int
+rcu_torture_stats(void *arg)
+{
+	VERBOSE_PRINTK_STRING("rcu_torture_stats task started");
+	do {
+		schedule_timeout_interruptible(stat_interval * HZ);
+		rcu_torture_stats_print();
+	} while (!kthread_should_stop());
+	VERBOSE_PRINTK_STRING("rcu_torture_stats task stopping");
+	return 0;
+}
+
+static void
+rcu_torture_cleanup(void)
+{
+	int i;
+
+	fullstop = 1;
+	if (writer_task != NULL) {
+		VERBOSE_PRINTK_STRING("Stopping rcu_torture_writer task");
+		kthread_stop(writer_task);
+	}
+	writer_task = NULL;
+
+	if (reader_tasks != NULL) {
+		for (i = 0; i < nrealreaders; i++) {
+			if (reader_tasks[i] != NULL) {
+				VERBOSE_PRINTK_STRING(
+					"Stopping rcu_torture_reader task");
+				kthread_stop(reader_tasks[i]);
+			}
+			reader_tasks[i] = NULL;
+		}
+		kfree(reader_tasks);
+		reader_tasks = NULL;
+	}
+	rcu_torture_current = NULL;
+
+	if (stats_task != NULL) {
+		VERBOSE_PRINTK_STRING("Stopping rcu_torture_stats task");
+		kthread_stop(stats_task);
+	}
+	stats_task = NULL;
+
+	/* Wait for all RCU callbacks to fire.  */
+
+	for (i = 0; i < RCU_TORTURE_PIPE_LEN; i++)
+		synchronize_rcu();
+	rcu_torture_stats_print();  /* -After- the stats thread is stopped! */
+	printk(KERN_ALERT TORTURE_FLAG
+	       "--- End of test: %s\n",
+	       atomic_read(&n_rcu_torture_error) == 0 ? "SUCCESS" : "FAILURE");
+}
+
+static int
+rcu_torture_init(void)
+{
+	int i;
+	int cpu;
+	int firsterr = 0;
+
+	/* Process args and tell the world that the torturer is on the job. */
+
+	if (nreaders >= 0)
+		nrealreaders = nreaders;
+	else
+		nrealreaders = 2 * num_online_cpus();
+	printk(KERN_ALERT TORTURE_FLAG
+	       "--- Start of test: nreaders=%d stat_interval=%d verbose=%d\n",
+	       nrealreaders, stat_interval, verbose);
+	fullstop = 0;
+
+	/* Set up the freelist. */
+
+	INIT_LIST_HEAD(&rcu_torture_freelist);
+	for (i = 0; i < sizeof(rcu_tortures) / sizeof(rcu_tortures[0]); i++) {
+		rcu_tortures[i].rtort_mbtest = 0;
+		list_add_tail(&rcu_tortures[i].rtort_free,
+			      &rcu_torture_freelist);
+	}
+
+	/* Initialize the statistics so that each run gets its own numbers. */
+
+	rcu_torture_current = NULL;
+	rcu_torture_current_version = 0;
+	atomic_set(&n_rcu_torture_alloc, 0);
+	atomic_set(&n_rcu_torture_alloc_fail, 0);
+	atomic_set(&n_rcu_torture_free, 0);
+	atomic_set(&n_rcu_torture_mberror, 0);
+	atomic_set(&n_rcu_torture_error, 0);
+	for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++)
+		atomic_set(&rcu_torture_wcount[i], 0);
+	for_each_cpu(cpu) {
+		for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++) {
+			per_cpu(rcu_torture_count, cpu)[i] = 0;
+			per_cpu(rcu_torture_batch, cpu)[i] = 0;
+		}
+	}
+
+	/* Start up the kthreads. */
+
+	VERBOSE_PRINTK_STRING("Creating rcu_torture_writer task");
+	writer_task = kthread_run(rcu_torture_writer, NULL,
+				  "rcu_torture_writer");
+	if (IS_ERR(writer_task)) {
+		firsterr = PTR_ERR(writer_task);
+		VERBOSE_PRINTK_ERRSTRING("Failed to create writer");
+		writer_task = NULL;
+		goto unwind;
+	}
+	reader_tasks = kmalloc(nrealreaders * sizeof(reader_tasks[0]),
+			       GFP_KERNEL);
+	if (reader_tasks == NULL) {
+		VERBOSE_PRINTK_ERRSTRING("out of memory");
+		firsterr = -ENOMEM;
+		goto unwind;
+	}
+	for (i = 0; i < nrealreaders; i++) {
+		VERBOSE_PRINTK_STRING("Creating rcu_torture_reader task");
+		reader_tasks[i] = kthread_run(rcu_torture_reader, NULL,
+					      "rcu_torture_reader");
+		if (IS_ERR(reader_tasks[i])) {
+			firsterr = PTR_ERR(reader_tasks[i]);
+			VERBOSE_PRINTK_ERRSTRING("Failed to create reader");
+			reader_tasks[i] = NULL;
+			goto unwind;
+		}
+	}
+	if (stat_interval > 0) {
+		VERBOSE_PRINTK_STRING("Creating rcu_torture_stats task");
+		stats_task = kthread_run(rcu_torture_stats, NULL,
+					"rcu_torture_stats");
+		if (IS_ERR(stats_task)) {
+			firsterr = PTR_ERR(stats_task);
+			VERBOSE_PRINTK_ERRSTRING("Failed to create stats");
+			stats_task = NULL;
+			goto unwind;
+		}
+	}
+	return 0;
+
+unwind:
+	rcu_torture_cleanup();
+	return firsterr;
+}
+
+module_init(rcu_torture_init);
+module_exit(rcu_torture_cleanup);
diff -urpNa -X dontdiff linux-2.6.14-rt10/lib/Kconfig.debug linux-2.6.14-rt10-rcutorture/lib/Kconfig.debug
--- linux-2.6.14-rt10/lib/Kconfig.debug	2005-11-11 11:14:39.000000000 -0800
+++ linux-2.6.14-rt10-rcutorture/lib/Kconfig.debug	2005-11-12 15:12:02.000000000 -0800
@@ -378,8 +378,29 @@ config USE_FRAME_POINTER
 	  on some architectures or you use external debuggers.
 	  If you don't debug the kernel, you can say N.
 
+config DEBUG_VM
+	bool "Debug VM"
+	depends on DEBUG_KERNEL
+	help
+	  Enable this to debug the virtual-memory system.
+
+	  If unsure, say N.
+
 config FRAME_POINTER
 	bool
 	depends on USE_FRAME_POINTER || MCOUNT
 	default y
 
+config RCU_TORTURE_TEST
+	tristate "torture tests for RCU"
+	depends on DEBUG_KERNEL
+	default n
+	help
+	  This option provides a kernel module that runs torture tests
+	  on the RCU infrastructure.  The kernel module may be built
+	  after the fact on the running kernel to be tested, if desired.
+
+	  Say Y here if you want RCU torture tests to start automatically
+	  at boot time (you probably don't).
+	  Say M if you want the RCU torture tests to build as a module.
+	  Say N if you are unsure.
diff -urpNa -X dontdiff linux-2.6.14-rt10/mm/mmap.c linux-2.6.14-rt10-rcutorture/mm/mmap.c
--- linux-2.6.14-rt10/mm/mmap.c	2005-11-11 11:14:39.000000000 -0800
+++ linux-2.6.14-rt10-rcutorture/mm/mmap.c	2005-11-12 15:21:28.000000000 -0800
@@ -1821,7 +1821,7 @@ asmlinkage long sys_munmap(unsigned long
 
 static inline void verify_mm_writelocked(struct mm_struct *mm)
 {
-#ifdef CONFIG_DEBUG_KERNEL
+#ifdef CONFIG_DEBUG_VM
 # ifdef CONFIG_PREEMPT_RT
 	if (unlikely(!rt_rwsem_is_locked(&mm->mmap_sem))) {
 		WARN_ON(1);
