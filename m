Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbWAXH4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbWAXH4S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 02:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbWAXH4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 02:56:18 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:42959 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030222AbWAXH4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 02:56:17 -0500
Date: Tue, 24 Jan 2006 08:56:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: RCU latency regression in 2.6.16-rc1
Message-ID: <20060124075640.GA24806@elte.hu>
References: <1138089139.2771.78.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138089139.2771.78.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> I ported the latency tracer to 2.6.16 and got this 13ms latency within 
> a few hours.  This is a regression from 2.6.15.
> 
> It appears that RCU can invoke ipv4_dst_destroy thousands of times in 
> a single batch.

could you try the PREEMPT_RCU patch below?

	Ingo

--------
The resulting patch compiles in the following configurations, and has
been tested on x86 and ppc64:

o	CONFIG_RCU_TORTURE_TEST:

	o	CONFIG_RCU_STATS & CONFIG_PREEMPT & CONFIG_PREEMPT_RCU

	o	!CONFIG_RCU_STATS & CONFIG_PREEMPT & CONFIG_PREEMPT_RCU

	o	!CONFIG_RCU_STATS & CONFIG_PREEMPT & !CONFIG_PREEMPT_RCU

	o	!CONFIG_RCU_STATS & !CONFIG_PREEMPT & !CONFIG_PREEMPT_RCU

And ditto with !CONFIG_RCU_TORTURE_TEST.  Note that one cannot do
CONFIG_RCU_STATS with !CONFIG_PREEMPT_RCU, since CONFIG_RCU_STATS is
currently only capable of working with CONFIG_PREEMPT_RCU's internal
data structures.  One for the todo list.  In principle, one could do
CONFIG_PREEMPT_RCU & !CONFIG_PREEMPT, but there is little point in having
preemptible RCU read-side critical sections in a non-preemptible kernel.
I will make this work later (but only for performance comparison purposes)
when I have the heavyweight instructions cleaned out of rcu_read_lock()
and rcu_read_unlock().

And yes, "classic RCU" does pass the torture test.  Though I got a bit
of a scare with a broken version of CONFIG_RCU_TORTURE_TEST.  ;-)

							Thanx, Paul

Signed-off-by: <paulmck@us.ibm.com>

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 Documentation/RCU/proc.txt |  207 +++++++++++++++++
 fs/proc/proc_misc.c        |   48 ++++
 include/linux/rcupdate.h   |   29 ++
 include/linux/sched.h      |    5 
 kernel/Kconfig.preempt     |   24 ++
 kernel/rcupdate.c          |  533 +++++++++++++++++++++++++++++++++++++++++----
 6 files changed, 799 insertions(+), 47 deletions(-)

Index: linux-rt.q/Documentation/RCU/proc.txt
===================================================================
--- /dev/null
+++ linux-rt.q/Documentation/RCU/proc.txt
@@ -0,0 +1,207 @@
+/proc Filesystem Entries for RCU
+
+
+CONFIG_RCU_STATS
+
+The CONFIG_RCU_STATS config option is available only in conjunction with
+CONFIG_PREEMPT_RCU.  It makes four /proc entries available, namely: rcuctrs,
+rcuptrs, rcugp, and rcustats.
+
+/proc/rcuctrs
+
+	CPU last cur
+	  0    1   1
+	  1    1   1
+	  2    1   1
+	  3    0   2
+	ggp = 230725
+
+This displays the number of processes that started RCU read-side critical
+sections on each CPU.  In absence of preemption, the "last" and "cur"
+counts for a given CPU will always sum to one.  Therefore, in the example
+output above, each CPU has started one RCU read-side critical section
+that was later preempted.  The "last" column counts RCU read-side critical
+sections that started prior to the last counter flip, while the "cur"
+column counts critical sections that started after the last counter flip.
+
+The "ggp" count is a count of the number of counter flips since boot.
+Since this is shown as an odd number, the "cur" counts are stored in
+the zero-th element of each of the per-CPU arrays, and the "last" counts
+are stored in the first element of each of the per-CPU arrays.
+
+
+/proc/rcuptrs
+
+	nl=c04c7160/c04c7960 nt=c04c72d0
+	 wl=c04c7168/c04c794c wt=c04c72bc dl=c04c7170/00000000 dt=c04c7170
+
+This displays the head and tail of each of CONFIG_PREEMPT_RCU's three
+callback lists.  This will soon change to display this on a per-CPU
+basis, since each CPU will soon have its own set of callback lists.
+In the example above, the "next" list header is located at hex address
+0xc04c7160, the first element on the list at hex address 0xc04c7960,
+and the last element on the list at hex address 0xc04c72d0.  The "wl="
+and "wt=" output is similar for the "wait" list, and the "dl=" and "dt="
+output for the "done" list.  The "done" list is normally emptied very
+quickly after being filled, so will usually be empty as shown above.
+Note that the tail pointer points into the list header in this case.
+
+Callbacks are placed in the "next" list by call_rcu(), moved to the
+"wait" list after the next counter flip, and moved to the "done" list
+on the counter flip after that.  Once on the "done" list, the callbacks
+are invoked.
+
+
+/proc/rcugp
+
+	oldggp=241419  newggp=241421
+
+This entry invokes synchronize_rcu() and prints out the number of counter
+flips since boot before and after the synchronize_rcu().  These two
+numbers will always differ by at least two.  Unless RCU is broken.  ;-)
+
+
+/proc/rcustats
+
+	ggp=242416 lgp=242416 sr=0 rcc=396233
+	na=2090938 nl=9 wa=2090929 wl=9 dl=0 dr=2090920 di=2090920
+	rtf1=22230730 rtf2=20139162 rtf3=242416 rtfe1=2085911 rtfe2=5657 rtfe3=19896746
+
+The quantities printed are as follows:
+
+o	"ggp=": The number of flips since boot.
+
+o	"lgp=": The number of flips sensed by the local structure since
+	boot.  This will soon be per-CPU.
+
+o	"sr=": The number of explicit call to synchronize_rcu().
+	Except that this is currently broken, so always reads as zero.
+	It is likely to be removed...
+
+o	"rcc=": The number of calls to rcu_check_callbacks().
+
+o	"na=": The number of callbacks that call_rcu() has registered
+	since boot.
+
+o	"nl=": The number of callbacks currently on the "next" list.
+
+o	"wa=": The number of callbacks that have moved to the "wait"
+	list since boot.
+
+o	"wl=": The number of callbacks currently on the "wait" list.
+
+o	"da=": The number of callbacks that have been moved to the
+	"done" list since boot.
+
+o	"dl=": The number of callbacks currently on the "done" list.
+
+o	"dr=": The number of callbacks that have been removed from the
+	"done" list since boot.
+
+o	"di=": The number of callbacks that have been invoked after being
+	removed from the "done" list.
+
+o	"rtf1=": The number of attempts to flip the counters.
+
+o	"rtf2=": The number of attempts to flip the counters that successfully
+	acquired the fliplock.
+
+o	"rtf3=": The number of successful counter flips.
+
+o	"rtfe1=": The number of attempts to flip the counters that failed
+	due to the lock being held by someone else.
+
+o	"rtfe2=": The number of attempts to flip the counters that were
+	abandoned due to someone else doing the job for us.
+
+o	"rtfe3=": The number of attempts to flip the counters that failed
+	due to some task still being in an RCU read-side critical section
+	starting from before the last successful counter flip.
+
+
+CONFIG_RCU_TORTURE_TEST
+
+The CONFIG_RCU_TORTURE_TEST config option is available for all RCU
+implementations.  It makes three /proc entries available, namely: rcutw,
+rcutr, and rcuts.
+
+
+/proc/rcutw
+
+Reading this entry starts a new torture test, or ends an earlier one
+if one is already in progress (in other words, there can be only one
+writer at a time).  This sleeps uninterruptibly, so be sure to run
+it in the background.  One could argue that it would be good to have
+multiple writers, but Linux uses RCU heavily enough that you will get
+write-side contention whether you want it or not.  If you want additional
+write-side contention, repeatedly create and destroy several large file
+trees in parallel.  Or use some other RCU-protected update.
+
+
+/proc/rcutr
+
+Reading this entry starts a new torture reader, which runs until sent
+a signal (e.g., control-C).  If testing an RCU implementation with
+preemptible read-side critical sections, make sure to spawn at least
+two /proc/rcutr instances for each CPU.
+
+
+/proc/rcuts
+
+Displays the current state of the torture test:
+
+	ggp = 20961
+	rtc: c04496f4 ver: 8734 tfle: 0 rta: 8734 rtaf: 0 rtf: 8715
+	Reader Pipe:  88024120 63914 0 0 0 0 0 0 0 0 0
+	Reader Batch:  88024097 63937 0 0 0 0 0 0 0 0
+	Free-Block Circulation:  8733 8731 8729 8727 8725 8723 8721 8719 8717 8715 0
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
+o	"Reader Pipe": Histogram of "ages" of structures seen by readers.
+	If any entries past the first two are non-zero, RCU is broken.
+	And /proc/rcuts prints "!!!" to make sure you notice.  The age
+	of a newly allocated structure is zero, it becomes one when
+	removed from reader visibility, and is incremented once per
+	grace period subsequently -- and is freed after passing through
+	(RCU_TORTURE_PIPE_LEN-2) grace periods.
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
Index: linux-rt.q/fs/proc/proc_misc.c
===================================================================
--- linux-rt.q.orig/fs/proc/proc_misc.c
+++ linux-rt.q/fs/proc/proc_misc.c
@@ -563,6 +563,48 @@ void create_seq_entry(char *name, mode_t
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
+#endif /* #ifdef CONFIG_RCU_STATS */
+
 void __init proc_misc_init(void)
 {
 	struct proc_dir_entry *entry;
@@ -585,6 +627,12 @@ void __init proc_misc_init(void)
 		{"cmdline",	cmdline_read_proc},
 		{"locks",	locks_read_proc},
 		{"execdomains",	execdomains_read_proc},
+#ifdef CONFIG_RCU_STATS
+		{"rcustats",	rcu_read_proc},
+		{"rcugp",	rcu_read_proc_gp},
+		{"rcuptrs",	rcu_read_proc_ptrs},
+		{"rcuctrs",	rcu_read_proc_ctrs},
+#endif /* #ifdef CONFIG_RCU_STATS */
 		{NULL,}
 	};
 	for (p = simple_ones; p->name; p++)
Index: linux-rt.q/include/linux/rcupdate.h
===================================================================
--- linux-rt.q.orig/include/linux/rcupdate.h
+++ linux-rt.q/include/linux/rcupdate.h
@@ -59,6 +59,7 @@ struct rcu_head {
 } while (0)
 
 
+#ifndef CONFIG_PREEMPT_RCU
 
 /* Global control variables for rcupdate callback mechanism. */
 struct rcu_ctrlblk {
@@ -185,14 +186,26 @@ static inline int rcu_pending(int cpu)
  *
  * It is illegal to block while in an RCU read-side critical section.
  */
-#define rcu_read_lock()		preempt_disable()
+#define rcu_read_lock preempt_disable
 
 /**
  * rcu_read_unlock - marks the end of an RCU read-side critical section.
  *
  * See rcu_read_lock() for more information.
  */
-#define rcu_read_unlock()	preempt_enable()
+#define rcu_read_unlock preempt_enable
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
@@ -215,14 +228,22 @@ static inline int rcu_pending(int cpu)
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
@@ -271,7 +292,11 @@ static inline int rcu_pending(int cpu)
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
Index: linux-rt.q/include/linux/sched.h
===================================================================
--- linux-rt.q.orig/include/linux/sched.h
+++ linux-rt.q/include/linux/sched.h
@@ -711,6 +711,11 @@ struct task_struct {
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
Index: linux-rt.q/kernel/Kconfig.preempt
===================================================================
--- linux-rt.q.orig/kernel/Kconfig.preempt
+++ linux-rt.q/kernel/Kconfig.preempt
@@ -63,3 +63,27 @@ config PREEMPT_BKL
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
Index: linux-rt.q/kernel/rcupdate.c
===================================================================
--- linux-rt.q.orig/kernel/rcupdate.c
+++ linux-rt.q/kernel/rcupdate.c
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
@@ -47,6 +47,69 @@
 #include <linux/rcupdate.h>
 #include <linux/rcuref.h>
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
+#ifndef __HAVE_ARCH_CMPXCHG
+/*
+ * We use an array of spinlocks for the rcurefs -- similar to ones in sparc
+ * 32 bit atomic_t implementations, and a hash function similar to that
+ * for our refcounting needs.
+ * Can't help multiprocessors which donot have cmpxchg :(
+ */
+spinlock_t __rcuref_hash[RCUREF_HASH_SIZE];
+
+static inline void init_rcurefs(void)
+{
+	int i;
+
+	for (i = 0; i < RCUREF_HASH_SIZE; i++)
+		spin_lock_init(&__rcuref_hash[i]);
+}
+#else
+#define init_rcurefs()	do { } while (0)
+#endif
+
+#ifndef CONFIG_PREEMPT_RCU
 
 /* Definition for rcupdate control block. */
 struct rcu_ctrlblk rcu_ctrlblk = 
@@ -73,18 +136,6 @@ DEFINE_PER_CPU(struct rcu_data, rcu_bh_d
 static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
 static int maxbatch = 10000;
 
-#ifndef __HAVE_ARCH_CMPXCHG
-/*
- * We use an array of spinlocks for the rcurefs -- similar to ones in sparc
- * 32 bit atomic_t implementations, and a hash function similar to that
- * for our refcounting needs.
- * Can't help multiprocessors which donot have cmpxchg :(
- */
-
-spinlock_t __rcuref_hash[RCUREF_HASH_SIZE] = {
-	[0 ... (RCUREF_HASH_SIZE-1)] = SPIN_LOCK_UNLOCKED
-};
-#endif
 
 /**
  * call_rcu - Queue an RCU callback for invocation after a grace period.
@@ -506,48 +557,370 @@ static struct notifier_block __devinitda
 void __init rcu_init(void)
 {
 	sema_init(&rcu_barrier_sema, 1);
+	init_rcurefs();
 	rcu_cpu_notify(&rcu_nb, CPU_UP_PREPARE,
 			(void *)(long)smp_processor_id());
 	/* Register notifier for non-boot CPUs */
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
+	long		completed;	/* Number of last completed batch. */
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
+	atomic_t	n_rcu_try_flip1;
+	long		n_rcu_try_flip2;
+	long		n_rcu_try_flip3;
+	atomic_t	n_rcu_try_flip_e1;
+	long		n_rcu_try_flip_e2;
+	long		n_rcu_try_flip_e3;
+#endif /* #ifdef CONFIG_RCU_STATS */
+};
+struct rcu_ctrlblk {
+	raw_spinlock_t	fliplock;
+	long		completed;	/* Number of last completed batch. */
 };
+static struct rcu_data rcu_data;
+static struct rcu_ctrlblk rcu_ctrlblk = {
+	.fliplock = RAW_SPIN_LOCK_UNLOCKED,
+	.completed = 0,
+};
+static DEFINE_PER_CPU(atomic_t [2], rcu_flipctr) =
+	{ ATOMIC_INIT(0), ATOMIC_INIT(0) };
 
-/* Because of FASTCALL declaration of complete, we use this wrapper */
-static void wakeme_after_rcu(struct rcu_head  *head)
+/*
+ * Return the number of RCU batches processed thus far.  Useful
+ * for debug and statistics.
+ */
+long rcu_batches_completed(void)
 {
-	struct rcu_synchronize *rcu;
+	return rcu_ctrlblk.completed;
+}
 
-	rcu = container_of(head, struct rcu_synchronize, head);
-	complete(&rcu->completion);
+void
+rcu_read_lock(void)
+{
+	int flipctr;
+	unsigned long oldirq;
+
+	raw_local_irq_save(oldirq);
+	if (current->rcu_read_lock_nesting++ == 0) {
+
+		/*
+		 * Outermost nesting of rcu_read_lock(), so atomically
+		 * increment the current counter for the current CPU.
+		 */
+
+		flipctr = rcu_ctrlblk.completed & 0x1;
+		smp_read_barrier_depends();
+		current->rcu_flipctr1 = &(__get_cpu_var(rcu_flipctr)[flipctr]);
+		/* Can optimize to non-atomic on fastpath, but start simple. */
+		atomic_inc(current->rcu_flipctr1);
+		smp_mb__after_atomic_inc();  /* might optimize out... */
+		if (unlikely(flipctr != (rcu_ctrlblk.completed & 0x1))) {
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
+	if (rcu_data.completed != rcu_ctrlblk.completed) {
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
+		rcu_data.completed = rcu_ctrlblk.completed;
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
+ */
+static void
+rcu_try_flip(void)
+{
+	int cpu;
+	long flipctr;
+	unsigned long oldirq;
+
+	flipctr = rcu_ctrlblk.completed;
+#ifdef CONFIG_RCU_STATS
+	atomic_inc(&rcu_data.n_rcu_try_flip1);
+#endif /* #ifdef CONFIG_RCU_STATS */
+	if (unlikely(!spin_trylock_irqsave(&rcu_ctrlblk.fliplock, oldirq))) {
+#ifdef CONFIG_RCU_STATS
+		atomic_inc(&rcu_data.n_rcu_try_flip_e1);
+#endif /* #ifdef CONFIG_RCU_STATS */
+		return;
+	}
+	if (unlikely(flipctr != rcu_ctrlblk.completed)) {
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
+
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
+	rcu_ctrlblk.completed++;
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
+	if (rcu_ctrlblk.completed == rcu_data.completed) {
+		rcu_try_flip();
+		if (rcu_ctrlblk.completed == rcu_data.completed) {
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
+	init_rcurefs();
+/*&&&&*/printk("WARNING: experimental RCU implementation.\n");
+	rcu_data.lock = RAW_SPIN_LOCK_UNLOCKED;
+	rcu_data.completed = 0;
+	rcu_data.nextlist = NULL;
+	rcu_data.nexttail = &rcu_data.nextlist;
+	rcu_data.waitlist = NULL;
+	rcu_data.waittail = &rcu_data.waitlist;
+	rcu_data.donelist = NULL;
+	rcu_data.donetail = &rcu_data.donelist;
+	tasklet_init(&rcu_data.rcu_tasklet, rcu_process_callbacks, 0UL);
 }
 
 /*
@@ -558,9 +931,79 @@ void synchronize_kernel(void)
 	synchronize_rcu();
 }
 
-module_param(maxbatch, int, 0);
+#ifdef CONFIG_RCU_STATS
+int rcu_read_proc_data(char *page)
+{
+	return sprintf(page,
+		       "ggp=%ld lgp=%ld rcc=%ld\n"
+		       "na=%ld nl=%ld wa=%ld wl=%ld da=%ld dl=%ld dr=%ld di=%d\n"
+		       "rtf1=%d rtf2=%ld rtf3=%ld rtfe1=%d rtfe2=%ld rtfe3=%ld\n",
+
+		       rcu_ctrlblk.completed,
+		       rcu_data.completed,
+		       rcu_data.n_rcu_check_callbacks,
+
+		       rcu_data.n_next_add,
+		       rcu_data.n_next_length,
+		       rcu_data.n_wait_add,
+		       rcu_data.n_wait_length,
+		       rcu_data.n_done_add,
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
+	long oldgp = rcu_ctrlblk.completed;
+
+	synchronize_rcu();
+	return sprintf(page, "oldggp=%ld  newggp=%ld\n",
+		       oldgp, rcu_ctrlblk.completed);
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
+	int f = rcu_data.completed & 0x1;
+
+	cnt += sprintf(&page[cnt], "CPU last cur\n");
+	for_each_cpu(cpu) {
+		cnt += sprintf(&page[cnt], "%3d %4d %3d\n",
+			       cpu,
+			       atomic_read(&per_cpu(rcu_flipctr, cpu)[!f]),
+			       atomic_read(&per_cpu(rcu_flipctr, cpu)[f]));
+	}
+	cnt += sprintf(&page[cnt], "ggp = %ld\n", rcu_data.completed);
+	return (cnt);
+}
+
+#endif /* #ifdef CONFIG_RCU_STATS */
+
+EXPORT_SYMBOL(call_rcu); /* WARNING: GPL-only in April 2006. */
 EXPORT_SYMBOL_GPL(rcu_batches_completed);
-EXPORT_SYMBOL(call_rcu);  /* WARNING: GPL-only in April 2006. */
-EXPORT_SYMBOL(call_rcu_bh);  /* WARNING: GPL-only in April 2006. */
 EXPORT_SYMBOL_GPL(synchronize_rcu);
-EXPORT_SYMBOL(synchronize_kernel);  /* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL_GPL(synchronize_sched);
+EXPORT_SYMBOL(rcu_read_lock);  /* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL(rcu_read_unlock);  /* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL(synchronize_kernel);  /* WARNING: Removal in April 2006. */
+
+#endif /* #else #ifndef CONFIG_PREEMPT_RCU */
