Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbWFQW2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWFQW2x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 18:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbWFQW2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 18:28:52 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:27619 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751005AbWFQW2v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 18:28:51 -0400
Date: Sat, 17 Jun 2006 15:29:20 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC, PATCH] Permitting sleeping in RCU read-side critical sections
Message-ID: <20060617222920.GA5720@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Over the years, a number of people have asked for the ability to block
(as opposed to merely be preempted or wait for a lock) in RCU read-side
critical sections.  After years of saying "no way!!!", I find that it
is in fact possible to build an RCU-like primitive that permits this,
patch attached.  Of course, the people wanting this have probably
figured out some other way to solve their problem, but just in case
similar needs arises again...

Passes 20 hours of rcutorture on i386 and ppc64, which constitutes a
reasonable "smoke test".

This patch includes:

o	Documentation updates.

o	Changes to the rcutorture test that permits it to test alternative
	RCU implementations.  Addition of option for testing call_rcu_bh()
	as well, with a new torture_type module parameter selecting the
	RCU implementation to test.  But you currently cannot test all
	three RCU variants on the same system at the same time.  Sorry!!!

o	Sleepable RCU itself, or SRCU.  There are some differences from
	classic and realtime RCU:

	o	Each use of SRCU creates its own srcu_struct, and each
		srcu_struct has its own set of grace periods.  This is
		critical, as it prevents one subsystem with a blocking
		reader from holding up SRCU grace periods for other
		subsystems.

	o	The SRCU primitives (srcu_read_lock(), srcu_read_unlock(),
		and synchronize_srcu()) all take a pointer to a srcu_struct.

	o	The SRCU primitives must be called from process context.

	o	srcu_read_lock() returns an int that must be passed to
		the matching srcu_read_unlock().  Realtime RCU avoids the
		need for this by storing the state in the task struct,
		but SRCU needs to allow a given code path to pass through
		multiple SRCU domains -- storing state in the task struct
		would therefore require either arbitrary space in the
		task struct or arbitrary limits on SRCU nesting.  So I
		kicked the state-storage problem up to the caller.

	o	There is no call_srcu().  It would not be hard to implement
		one, but it seems like too easy a way to OOM the system.
		(Hey, we have enough trouble with call_rcu(), which does
		-not- permit readers to sleep!!!)  So, if you want it,
		please tell me why...

	Other than the above differences, SRCU acts very much like RCU.

o	I do -not- anticipate SRCU ever folding into the main RCU
	implementation.  For one thing, the API is different...

o	SRCU is fairly simple as RCU implementations go -- about 200
	lines for the actual implementation.  That said,
	synchronize_srcu() is fairly simple and unoptimized.

Signed-off-by: Paul E. McKenney <paulmck@us.ibm.com>
---

 Documentation/RCU/checklist.txt |   32 ++++
 Documentation/RCU/rcu.txt       |    3 
 Documentation/RCU/torture.txt   |   44 +++++-
 Documentation/RCU/whatisRCU.txt |    3 
 include/linux/srcu.h            |   42 ++++++
 kernel/Makefile                 |    2 
 kernel/rcupdate.c               |   10 +
 kernel/rcutorture.c             |  278 ++++++++++++++++++++++++++++++++++------
 kernel/srcu.c                   |  173 ++++++++++++++++++++++++
 9 files changed, 536 insertions(+), 51 deletions(-)

diff -urpNa -X dontdiff linux-2.6.17-rc6/Documentation/RCU/checklist.txt linux-2.6.17-rc6-srcu/Documentation/RCU/checklist.txt
--- linux-2.6.17-rc6/Documentation/RCU/checklist.txt	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.17-rc6-srcu/Documentation/RCU/checklist.txt	2006-06-16 16:25:10.000000000 -0700
@@ -183,3 +183,35 @@ over a rather long period of time, but i
 	disable irq on a given acquisition of that lock will result in
 	deadlock as soon as the RCU callback happens to interrupt that
 	acquisition's critical section.
+
+13.	SRCU (srcu_read_lock(), srcu_read_unlock(), and synchronize_srcu())
+	may only be invoked from process context.  Unlike other forms of
+	RCU, it -is- permissible to block in an SRCU read-side critical
+	section (demarked by srcu_read_lock() and srcu_read_unlock()),
+	hence the "SRCU": "sleepable RCU".
+
+	Also unlike other forms of RCU, explicit initialization
+	and cleanup is required via init_srcu_struct() and
+	cleanup_srcu_struct().	These are passed a "struct srcu_struct"
+	that defines the scope of a given SRCU domain.	Once initialized,
+	the srcu_struct is passed to srcu_read_lock(), srcu_read_unlock()
+	and synchronize_srcu().  A given synchronize_srcu() waits only
+	for SRCU read-side critical sections governed by srcu_read_lock()
+	and srcu_read_unlock() calls that have been passd the same
+	srcu_struct.  This property is what makes sleeping read-side
+	critical sections tolerable -- a given subsystem delays only
+	its own updates, not those of other subsystems using SRCU.
+
+	This benefit does not come for free.  First, corresponding
+	srcu_read_lock() and srcu_read_unlock() calls must be passed
+	the same srcu_struct.  Second, grace-period-detection overhead
+	is amortized only over those updates sharing a given srcu_struct,
+	rather than being globally amortized as they are for other forms
+	of RCU.  This means that SRCU should be used only in extremely
+	read-intensive situations if performance is the goal (of course,
+	if the goal is instead read-side deadlock avoidance or read-side
+	realtime latency, then SRCU might be applicable to less extreme
+	degrees of read intensity).
+
+	Note that, rcu_assign_pointer() and rcu_dereference() relate to
+	SRCU just as they do to other forms of RCU.
diff -urpNa -X dontdiff linux-2.6.17-rc6/Documentation/RCU/rcu.txt linux-2.6.17-rc6-srcu/Documentation/RCU/rcu.txt
--- linux-2.6.17-rc6/Documentation/RCU/rcu.txt	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.17-rc6-srcu/Documentation/RCU/rcu.txt	2006-06-16 15:41:18.000000000 -0700
@@ -45,7 +45,8 @@ o	How can I see where RCU is currently u
 
 	Search for "rcu_read_lock", "rcu_read_unlock", "call_rcu",
 	"rcu_read_lock_bh", "rcu_read_unlock_bh", "call_rcu_bh",
-	"synchronize_rcu", and "synchronize_net".
+	"srcu_read_lock", "srcu_read_unlock", "synchronize_rcu",
+	"synchronize_net", and "synchronize_srcu".
 
 o	What guidelines should I follow when writing code that uses RCU?
 
diff -urpNa -X dontdiff linux-2.6.17-rc6/Documentation/RCU/torture.txt linux-2.6.17-rc6-srcu/Documentation/RCU/torture.txt
--- linux-2.6.17-rc6/Documentation/RCU/torture.txt	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.17-rc6-srcu/Documentation/RCU/torture.txt	2006-06-16 16:00:58.000000000 -0700
@@ -35,6 +35,19 @@ stat_interval	The number of seconds betw
 		be printed -only- when the module is unloaded, and this
 		is the default.
 
+shuffle_interval
+		The number of seconds to keep the test threads affinitied
+		to a particular subset of the CPUs.  Used in conjunction
+		with test_no_idle_hz.
+
+test_no_idle_hz	Whether or not to test the ability of RCU to operate in
+		a kernel that disables the scheduling-clock interrupt to
+		idle CPUs.  Boolean parameter, "1" to test, "0" otherwise.
+
+torture_type	The type of RCU to test: "rcu" for the rcu_read_lock()
+		API, "rcu_bh" for the rcu_read_lock_bh() API, and "srcu"
+		for the "srcu_read_lock()" API.
+
 verbose		Enable debug printk()s.  Default is disabled.
 
 
@@ -42,12 +55,12 @@ OUTPUT
 
 The statistics output is as follows:
 
-	rcutorture: --- Start of test: nreaders=16 stat_interval=0 verbose=0
-	rcutorture: rtc: 0000000000000000 ver: 1916 tfle: 0 rta: 1916 rtaf: 0 rtf: 1915
-	rcutorture: Reader Pipe:  1466408 9747 0 0 0 0 0 0 0 0 0
-	rcutorture: Reader Batch:  1464477 11678 0 0 0 0 0 0 0 0
-	rcutorture: Free-Block Circulation:  1915 1915 1915 1915 1915 1915 1915 1915 1915 1915 0
-	rcutorture: --- End of test
+	rcu-torture: --- Start of test: nreaders=16 stat_interval=0 verbose=0
+	rcu-torture: rtc: 0000000000000000 ver: 1916 tfle: 0 rta: 1916 rtaf: 0 rtf: 1915
+	rcu-torture: Reader Pipe:  1466408 9747 0 0 0 0 0 0 0 0 0
+	rcu-torture: Reader Batch:  1464477 11678 0 0 0 0 0 0 0 0
+	rcu-torture: Free-Block Circulation:  1915 1915 1915 1915 1915 1915 1915 1915 1915 1915 0
+	rcu-torture: --- End of test
 
 The command "dmesg | grep rcutorture:" will extract this information on
 most systems.  On more esoteric configurations, it may be necessary to
@@ -105,6 +118,20 @@ o	"Free-Block Circulation": Shows the nu
 	as it is only incremented if a torture structure's counter
 	somehow gets incremented farther than it should.
 
+Different implementations of RCU can provide implementation-specific
+additional information.  For example, SRCU provides the following:
+
+	srcu-torture: rtc: f8cf46a8 ver: 355 tfle: 0 rta: 356 rtaf: 0 rtf: 346 rtmbe: 0
+	srcu-torture: Reader Pipe:  559738 939 0 0 0 0 0 0 0 0 0
+	srcu-torture: Reader Batch:  560434 243 0 0 0 0 0 0 0 0
+	srcu-torture: Free-Block Circulation:  355 354 353 352 351 350 349 348 347 346 0
+	srcu-torture: per-CPU(idx=1): 0(0,1) 1(0,1) 2(0,0) 3(0,1)
+
+The first four lines are similar to those for RCU.  The last line shows
+the per-CPU counter state.  The numbers in parentheses are the values
+of the "old" and "current" counters for the corresponding CPU.  The
+"idx" value maps the "old" and "current" values to the underlying array,
+and is useful for debugging.
 
 USAGE
 
@@ -115,8 +142,9 @@ The following script may be used to tort
 	modprobe rcutorture
 	sleep 100
 	rmmod rcutorture
-	dmesg | grep rcutorture:
+	dmesg | grep torture:
 
 The output can be manually inspected for the error flag of "!!!".
 One could of course create a more elaborate script that automatically
-checked for such errors.
+checked for such errors.  The "rmmod" command forces a "SUCCESS" or
+"FAILURE" indication to be printk()ed.
diff -urpNa -X dontdiff linux-2.6.17-rc6/Documentation/RCU/whatisRCU.txt linux-2.6.17-rc6-srcu/Documentation/RCU/whatisRCU.txt
--- linux-2.6.17-rc6/Documentation/RCU/whatisRCU.txt	2006-06-14 16:32:07.000000000 -0700
+++ linux-2.6.17-rc6-srcu/Documentation/RCU/whatisRCU.txt	2006-06-16 16:01:47.000000000 -0700
@@ -767,6 +767,8 @@ Markers for RCU read-side critical secti
 	rcu_read_unlock
 	rcu_read_lock_bh
 	rcu_read_unlock_bh
+	srcu_read_lock
+	srcu_read_unlock
 
 RCU pointer/list traversal:
 
@@ -794,6 +796,7 @@ RCU grace period:
 	synchronize_net
 	synchronize_sched
 	synchronize_rcu
+	synchronize_srcu
 	call_rcu
 	call_rcu_bh
 
diff -urpNa -X dontdiff linux-2.6.17-rc6/include/linux/srcu.h linux-2.6.17-rc6-srcu/include/linux/srcu.h
--- linux-2.6.17-rc6/include/linux/srcu.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17-rc6-srcu/include/linux/srcu.h	2006-06-16 08:29:12.000000000 -0700
@@ -0,0 +1,42 @@
+/*
+ * Sleepable Read-Copy Update mechanism for mutual exclusion
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
+ * Copyright (C) IBM Corporation, 2006
+ *
+ * Author: Paul McKenney <paulmck@us.ibm.com>
+ *
+ * For detailed explanation of Read-Copy Update mechanism see -
+ * 		Documentation/RCU/ *.txt
+ *
+ */
+
+struct srcu_struct_array {
+	int c[2];
+} ____cacheline_internode_aligned_in_smp;
+
+struct srcu_struct {
+	int completed;
+	struct srcu_struct_array *per_cpu_ref;
+	struct mutex mutex;
+};
+
+void init_srcu_struct(struct srcu_struct *sp);
+void cleanup_srcu_struct(struct srcu_struct *sp);
+int srcu_read_lock(struct srcu_struct *sp);
+void srcu_read_unlock(struct srcu_struct *sp, int idx);
+void synchronize_srcu(struct srcu_struct *sp);
+long srcu_batches_completed(struct srcu_struct *sp);
diff -urpNa -X dontdiff linux-2.6.17-rc6/kernel/Makefile linux-2.6.17-rc6-srcu/kernel/Makefile
--- linux-2.6.17-rc6/kernel/Makefile	2006-06-14 16:32:18.000000000 -0700
+++ linux-2.6.17-rc6-srcu/kernel/Makefile	2006-06-14 16:39:22.000000000 -0700
@@ -8,7 +8,7 @@ obj-y     = sched.o fork.o exec_domain.o
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o extable.o params.o posix-timers.o \
 	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o mutex.o \
-	    hrtimer.o
+	    hrtimer.o srcu.o
 
 obj-$(CONFIG_DEBUG_MUTEXES) += mutex-debug.o
 obj-$(CONFIG_FUTEX) += futex.o
diff -urpNa -X dontdiff linux-2.6.17-rc6/kernel/rcupdate.c linux-2.6.17-rc6-srcu/kernel/rcupdate.c
--- linux-2.6.17-rc6/kernel/rcupdate.c	2006-06-14 16:32:18.000000000 -0700
+++ linux-2.6.17-rc6-srcu/kernel/rcupdate.c	2006-06-16 16:46:12.000000000 -0700
@@ -182,6 +182,15 @@ long rcu_batches_completed(void)
 	return rcu_ctrlblk.completed;
 }
 
+/*
+ * Return the number of RCU batches processed thus far.  Useful
+ * for debug and statistics.
+ */
+long rcu_batches_completed_bh(void)
+{
+	return rcu_bh_ctrlblk.completed;
+}
+
 static void rcu_barrier_callback(struct rcu_head *notused)
 {
 	if (atomic_dec_and_test(&rcu_barrier_cpu_count))
@@ -627,6 +636,7 @@ module_param(qlowmark, int, 0);
 module_param(rsinterval, int, 0);
 #endif
 EXPORT_SYMBOL_GPL(rcu_batches_completed);
+EXPORT_SYMBOL_GPL(rcu_batches_completed_bh);
 EXPORT_SYMBOL_GPL_FUTURE(call_rcu);	/* WARNING: GPL-only in April 2006. */
 EXPORT_SYMBOL_GPL_FUTURE(call_rcu_bh);	/* WARNING: GPL-only in April 2006. */
 EXPORT_SYMBOL_GPL(synchronize_rcu);
diff -urpNa -X dontdiff linux-2.6.17-rc6/kernel/rcutorture.c linux-2.6.17-rc6-srcu/kernel/rcutorture.c
--- linux-2.6.17-rc6/kernel/rcutorture.c	2006-06-14 16:32:18.000000000 -0700
+++ linux-2.6.17-rc6-srcu/kernel/rcutorture.c	2006-06-16 15:58:32.000000000 -0700
@@ -1,5 +1,5 @@
 /*
- * Read-Copy Update /proc-based torture test facility
+ * Read-Copy Update module-based torture test facility
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -44,6 +44,7 @@
 #include <linux/delay.h>
 #include <linux/byteorder/swabb.h>
 #include <linux/stat.h>
+#include <linux/srcu.h>
 
 MODULE_LICENSE("GPL");
 
@@ -53,6 +54,7 @@ static int stat_interval;	/* Interval be
 static int verbose;		/* Print more debug info. */
 static int test_no_idle_hz;	/* Test RCU's support for tickless idle CPUs. */
 static int shuffle_interval = 5; /* Interval between shuffles (in sec)*/
+static char *torture_type = "rcu"; /* What to torture: rcu, srcu. */
 
 module_param(nreaders, int, 0);
 MODULE_PARM_DESC(nreaders, "Number of RCU reader threads");
@@ -64,13 +66,16 @@ module_param(test_no_idle_hz, bool, 0);
 MODULE_PARM_DESC(test_no_idle_hz, "Test support for tickless idle CPUs");
 module_param(shuffle_interval, int, 0);
 MODULE_PARM_DESC(shuffle_interval, "Number of seconds between shuffles");
-#define TORTURE_FLAG "rcutorture: "
+module_param(torture_type, charp, 0);
+MODULE_PARM_DESC(torture_type, "Number of seconds between shuffles");
+
+#define TORTURE_FLAG "-torture:"
 #define PRINTK_STRING(s) \
-	do { printk(KERN_ALERT TORTURE_FLAG s "\n"); } while (0)
+	do { printk(KERN_ALERT "%s" TORTURE_FLAG s "\n", torture_type); } while (0)
 #define VERBOSE_PRINTK_STRING(s) \
-	do { if (verbose) printk(KERN_ALERT TORTURE_FLAG s "\n"); } while (0)
+	do { if (verbose) printk(KERN_ALERT "%s" TORTURE_FLAG s "\n", torture_type); } while (0)
 #define VERBOSE_PRINTK_ERRSTRING(s) \
-	do { if (verbose) printk(KERN_ALERT TORTURE_FLAG "!!! " s "\n"); } while (0)
+	do { if (verbose) printk(KERN_ALERT "%s" TORTURE_FLAG "!!! " s "\n", torture_type); } while (0)
 
 static char printk_buf[4096];
 
@@ -139,6 +144,71 @@ rcu_torture_free(struct rcu_torture *p)
 	spin_unlock_bh(&rcu_torture_lock);
 }
 
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
+ * Operations vector for selecting different types of tests.
+ */
+
+struct rcu_torture_ops {
+	void (*init)(void);
+	void (*cleanup)(void);
+	int (*readlock)(void);
+	void (*readunlock)(int idx);
+	int (*completed)(void);
+	void (*deferredfree)(struct rcu_torture *p);
+	int (*stats)(char *page);
+	char *name;
+};
+static struct rcu_torture_ops *cur_ops = NULL;
+
+/*
+ * Definitions for rcu torture testing.
+ */
+
+static int rcu_torture_read_lock(void)
+{
+	rcu_read_lock();
+	return 0;
+}
+
+static void rcu_torture_read_unlock(int idx)
+{
+	rcu_read_unlock();
+}
+
+static int rcu_torture_completed(void)
+{
+	return rcu_batches_completed();
+}
+
 static void
 rcu_torture_cb(struct rcu_head *p)
 {
@@ -158,38 +228,146 @@ rcu_torture_cb(struct rcu_head *p)
 		rp->rtort_mbtest = 0;
 		rcu_torture_free(rp);
 	} else
-		call_rcu(p, rcu_torture_cb);
+		cur_ops->deferredfree(rp);
 }
 
-struct rcu_random_state {
-	unsigned long rrs_state;
-	unsigned long rrs_count;
+static void rcu_torture_deferred_free(struct rcu_torture *p)
+{
+	call_rcu(&p->rtort_rcu, rcu_torture_cb);
+}
+
+static struct rcu_torture_ops rcu_ops = {
+	.init = NULL,
+	.cleanup = NULL,
+	.readlock = rcu_torture_read_lock,
+	.readunlock = rcu_torture_read_unlock,
+	.completed = rcu_torture_completed,
+	.deferredfree = rcu_torture_deferred_free,
+	.stats = NULL,
+	.name = "rcu"
 };
 
-#define RCU_RANDOM_MULT 39916801  /* prime */
-#define RCU_RANDOM_ADD	479001701 /* prime */
-#define RCU_RANDOM_REFRESH 10000
+/*
+ * Definitions for rcu_bh torture testing.
+ */
 
-#define DEFINE_RCU_RANDOM(name) struct rcu_random_state name = { 0, 0 }
+static int rcu_bh_torture_read_lock(void)
+{
+	rcu_read_lock_bh();
+	return 0;
+}
+
+static void rcu_bh_torture_read_unlock(int idx)
+{
+	rcu_read_unlock_bh();
+}
+
+static int rcu_bh_torture_completed(void)
+{
+	return rcu_batches_completed_bh();
+}
+
+static void rcu_bh_torture_deferred_free(struct rcu_torture *p)
+{
+	call_rcu_bh(&p->rtort_rcu, rcu_torture_cb);
+}
+
+static struct rcu_torture_ops rcu_bh_ops = {
+	.init = NULL,
+	.cleanup = NULL,
+	.readlock = rcu_bh_torture_read_lock,
+	.readunlock = rcu_bh_torture_read_unlock,
+	.completed = rcu_bh_torture_completed,
+	.deferredfree = rcu_bh_torture_deferred_free,
+	.stats = NULL,
+	.name = "rcu_bh"
+};
 
 /*
- * Crude but fast random-number generator.  Uses a linear congruential
- * generator, with occasional help from get_random_bytes().
+ * Definitions for srcu torture testing.
  */
-static long
-rcu_random(struct rcu_random_state *rrsp)
+
+static struct srcu_struct srcu_ctl;
+static struct list_head srcu_removed;
+
+static void srcu_torture_init(void)
 {
-	long refresh;
+	init_srcu_struct(&srcu_ctl);
+	INIT_LIST_HEAD(&srcu_removed);
+}
 
-	if (--rrsp->rrs_count < 0) {
-		get_random_bytes(&refresh, sizeof(refresh));
-		rrsp->rrs_state += refresh;
-		rrsp->rrs_count = RCU_RANDOM_REFRESH;
+static void srcu_torture_cleanup(void)
+{
+	synchronize_srcu(&srcu_ctl);
+	cleanup_srcu_struct(&srcu_ctl);
+}
+
+static int srcu_torture_read_lock(void)
+{
+	return (srcu_read_lock(&srcu_ctl));
+}
+
+static void srcu_torture_read_unlock(int idx)
+{
+	srcu_read_unlock(&srcu_ctl, idx);
+}
+
+static int srcu_torture_completed(void)
+{
+	return srcu_batches_completed(&srcu_ctl);
+}
+
+static void srcu_torture_deferred_free(struct rcu_torture *p)
+{
+	int i;
+	struct rcu_torture *rp;
+	struct rcu_torture *rp1;
+
+	synchronize_srcu(&srcu_ctl);
+	list_add(&p->rtort_free, &srcu_removed);
+	list_for_each_entry_safe(rp, rp1, &srcu_removed, rtort_free) {
+		i = rp->rtort_pipe_count;
+		if (i > RCU_TORTURE_PIPE_LEN)
+			i = RCU_TORTURE_PIPE_LEN;
+		atomic_inc(&rcu_torture_wcount[i]);
+		if (++rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
+			rp->rtort_mbtest = 0;
+			list_del(&rp->rtort_free);
+			rcu_torture_free(rp);
+		}
 	}
-	rrsp->rrs_state = rrsp->rrs_state * RCU_RANDOM_MULT + RCU_RANDOM_ADD;
-	return swahw32(rrsp->rrs_state);
 }
 
+int srcu_torture_stats(char *page)
+{
+	int cnt = 0;
+	int cpu;
+	int idx = srcu_ctl.completed & 0x1;
+
+	cnt += sprintf(&page[cnt], "%s%s per-CPU(idx=%d):", torture_type, TORTURE_FLAG, idx);
+	for_each_cpu(cpu) {
+		cnt += sprintf(&page[cnt], " %d(%d,%d)", cpu,
+			       srcu_ctl.per_cpu_ref[cpu].c[!idx],
+			       srcu_ctl.per_cpu_ref[cpu].c[idx]);
+	}
+	cnt += sprintf(&page[cnt], "\n");
+	return (cnt);
+}
+
+static struct rcu_torture_ops srcu_ops = {
+	.init = srcu_torture_init,
+	.cleanup = srcu_torture_cleanup,
+	.readlock = srcu_torture_read_lock,
+	.readunlock = srcu_torture_read_unlock,
+	.completed = srcu_torture_completed,
+	.deferredfree = srcu_torture_deferred_free,
+	.stats = srcu_torture_stats,
+	.name = "srcu"
+};
+
+static struct rcu_torture_ops *torture_ops[] =
+	{ &rcu_ops, &rcu_bh_ops, &srcu_ops, NULL };
+
 /*
  * RCU torture writer kthread.  Repeatedly substitutes a new structure
  * for that pointed to by rcu_torture_current, freeing the old structure
@@ -209,8 +387,6 @@ rcu_torture_writer(void *arg)
 
 	do {
 		schedule_timeout_uninterruptible(1);
-		if (rcu_batches_completed() == oldbatch)
-			continue;
 		if ((rp = rcu_torture_alloc()) == NULL)
 			continue;
 		rp->rtort_pipe_count = 0;
@@ -225,10 +401,10 @@ rcu_torture_writer(void *arg)
 				i = RCU_TORTURE_PIPE_LEN;
 			atomic_inc(&rcu_torture_wcount[i]);
 			old_rp->rtort_pipe_count++;
-			call_rcu(&old_rp->rtort_rcu, rcu_torture_cb);
+			cur_ops->deferredfree(old_rp);
 		}
 		rcu_torture_current_version++;
-		oldbatch = rcu_batches_completed();
+		oldbatch = cur_ops->completed();
 	} while (!kthread_should_stop() && !fullstop);
 	VERBOSE_PRINTK_STRING("rcu_torture_writer task stopping");
 	while (!kthread_should_stop())
@@ -246,6 +422,7 @@ static int
 rcu_torture_reader(void *arg)
 {
 	int completed;
+	int idx;
 	DEFINE_RCU_RANDOM(rand);
 	struct rcu_torture *p;
 	int pipe_count;
@@ -254,12 +431,12 @@ rcu_torture_reader(void *arg)
 	set_user_nice(current, 19);
 
 	do {
-		rcu_read_lock();
-		completed = rcu_batches_completed();
+		idx = cur_ops->readlock();
+		completed = cur_ops->completed();
 		p = rcu_dereference(rcu_torture_current);
 		if (p == NULL) {
 			/* Wait for rcu_torture_writer to get underway */
-			rcu_read_unlock();
+			cur_ops->readunlock(idx);
 			schedule_timeout_interruptible(HZ);
 			continue;
 		}
@@ -273,14 +450,14 @@ rcu_torture_reader(void *arg)
 			pipe_count = RCU_TORTURE_PIPE_LEN;
 		}
 		++__get_cpu_var(rcu_torture_count)[pipe_count];
-		completed = rcu_batches_completed() - completed;
+		completed = cur_ops->completed() - completed;
 		if (completed > RCU_TORTURE_PIPE_LEN) {
 			/* Should not happen, but... */
 			completed = RCU_TORTURE_PIPE_LEN;
 		}
 		++__get_cpu_var(rcu_torture_batch)[completed];
 		preempt_enable();
-		rcu_read_unlock();
+		cur_ops->readunlock(idx);
 		schedule();
 	} while (!kthread_should_stop() && !fullstop);
 	VERBOSE_PRINTK_STRING("rcu_torture_reader task stopping");
@@ -311,7 +488,7 @@ rcu_torture_printk(char *page)
 		if (pipesummary[i] != 0)
 			break;
 	}
-	cnt += sprintf(&page[cnt], "rcutorture: ");
+	cnt += sprintf(&page[cnt], "%s%s ", torture_type, TORTURE_FLAG);
 	cnt += sprintf(&page[cnt],
 		       "rtc: %p ver: %ld tfle: %d rta: %d rtaf: %d rtf: %d "
 		       "rtmbe: %d",
@@ -324,7 +501,7 @@ rcu_torture_printk(char *page)
 		       atomic_read(&n_rcu_torture_mberror));
 	if (atomic_read(&n_rcu_torture_mberror) != 0)
 		cnt += sprintf(&page[cnt], " !!!");
-	cnt += sprintf(&page[cnt], "\nrcutorture: ");
+	cnt += sprintf(&page[cnt], "\n%s%s ", torture_type, TORTURE_FLAG);
 	if (i > 1) {
 		cnt += sprintf(&page[cnt], "!!! ");
 		atomic_inc(&n_rcu_torture_error);
@@ -332,17 +509,19 @@ rcu_torture_printk(char *page)
 	cnt += sprintf(&page[cnt], "Reader Pipe: ");
 	for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++)
 		cnt += sprintf(&page[cnt], " %ld", pipesummary[i]);
-	cnt += sprintf(&page[cnt], "\nrcutorture: ");
+	cnt += sprintf(&page[cnt], "\n%s%s ", torture_type, TORTURE_FLAG);
 	cnt += sprintf(&page[cnt], "Reader Batch: ");
-	for (i = 0; i < RCU_TORTURE_PIPE_LEN; i++)
+	for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++)
 		cnt += sprintf(&page[cnt], " %ld", batchsummary[i]);
-	cnt += sprintf(&page[cnt], "\nrcutorture: ");
+	cnt += sprintf(&page[cnt], "\n%s%s ", torture_type, TORTURE_FLAG);
 	cnt += sprintf(&page[cnt], "Free-Block Circulation: ");
 	for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++) {
 		cnt += sprintf(&page[cnt], " %d",
 			       atomic_read(&rcu_torture_wcount[i]));
 	}
 	cnt += sprintf(&page[cnt], "\n");
+	if (cur_ops->stats != NULL)
+		cnt += cur_ops->stats(&page[cnt]);
 	return cnt;
 }
 
@@ -444,11 +623,11 @@ rcu_torture_shuffle(void *arg)
 static inline void
 rcu_torture_print_module_parms(char *tag)
 {
-	printk(KERN_ALERT TORTURE_FLAG "--- %s: nreaders=%d "
+	printk(KERN_ALERT "%s" TORTURE_FLAG "--- %s: nreaders=%d "
 		"stat_interval=%d verbose=%d test_no_idle_hz=%d "
 		"shuffle_interval = %d\n",
-		tag, nrealreaders, stat_interval, verbose, test_no_idle_hz,
-		shuffle_interval);
+		torture_type, tag, nrealreaders, stat_interval, verbose,
+		test_no_idle_hz, shuffle_interval);
 }
 
 static void
@@ -493,6 +672,9 @@ rcu_torture_cleanup(void)
 	rcu_barrier();
 
 	rcu_torture_stats_print();  /* -After- the stats thread is stopped! */
+
+	if (cur_ops->cleanup != NULL)
+		cur_ops->cleanup();
 	if (atomic_read(&n_rcu_torture_error))
 		rcu_torture_print_module_parms("End of test: FAILURE");
 	else
@@ -508,6 +690,20 @@ rcu_torture_init(void)
 
 	/* Process args and tell the world that the torturer is on the job. */
 
+	for (i = 0; cur_ops = torture_ops[i], cur_ops != NULL; i++) {
+		cur_ops = torture_ops[i];
+		if (strcmp(torture_type, cur_ops->name) == 0) {
+			break;
+		}
+	}
+	if (cur_ops == NULL) {
+		printk(KERN_ALERT "rcutorture: invalid torture type: \"%s\"\n",
+		       torture_type);
+		return (-EINVAL);
+	}
+	if (cur_ops->init != NULL)
+		cur_ops->init(); /* no "goto unwind" prior to this point!!! */
+
 	if (nreaders >= 0)
 		nrealreaders = nreaders;
 	else
diff -urpNa -X dontdiff linux-2.6.17-rc6/kernel/srcu.c linux-2.6.17-rc6-srcu/kernel/srcu.c
--- linux-2.6.17-rc6/kernel/srcu.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17-rc6-srcu/kernel/srcu.c	2006-06-16 16:25:15.000000000 -0700
@@ -0,0 +1,173 @@
+/*
+ * Sleepable Read-Copy Update mechanism for mutual exclusion.
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
+ * Copyright (C) IBM Corporation, 2006
+ *
+ * Author: Paul McKenney <paulmck@us.ibm.com>
+ *
+ * For detailed explanation of Read-Copy Update mechanism see -
+ * 		Documentation/RCU/ *.txt
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/preempt.h>
+#include <linux/rcupdate.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/srcu.h>
+
+/**
+ * init_srcu_struct - initialize a sleep-RCU structure
+ * @sp: structure to initialize.
+ *
+ * Must invoke this on a given srcu_struct before passing that srcu_struct
+ * to any other function.  Each srcu_struct represents a separate domain
+ * of SRCU protection.
+ */
+void init_srcu_struct(struct srcu_struct *sp)
+{
+	int cpu;
+
+	sp->completed = 0;
+	sp->per_cpu_ref = (struct srcu_struct_array *)
+			  kmalloc(NR_CPUS * sizeof(*sp->per_cpu_ref),
+				  GFP_KERNEL);
+	for_each_cpu(cpu) {
+		sp->per_cpu_ref[cpu].c[0] = 0;
+		sp->per_cpu_ref[cpu].c[1] = 0;
+	}
+	mutex_init(&sp->mutex);
+}
+
+/**
+ * cleanup_srcu_struct - deconstruct a sleep-RCU structure
+ * @sp: structure to clean up.
+ *
+ * Must invoke this after you are finished using a given srcu_struct.
+ * Failure to do so will result in a memory leak.
+ */
+void cleanup_srcu_struct(struct srcu_struct *sp)
+{
+	kfree(sp->per_cpu_ref);
+	sp->per_cpu_ref = NULL;
+}
+
+/**
+ * srcu_read_lock - register a new reader for an SRCU-protected structure.
+ * @sp: srcu_struct in which to register the new reader.
+ *
+ * Counts the new reader in the appropriate per-CPU element of the
+ * srcu_struct.  Must be called from process context.
+ * Returns an index that must be passed to the matching srcu_read_unlock().
+ */
+int srcu_read_lock(struct srcu_struct *sp)
+{
+	int idx;
+
+	preempt_disable();
+	idx = sp->completed & 0x1;
+	barrier();
+	sp->per_cpu_ref[smp_processor_id()].c[idx]++;
+	preempt_enable();
+	return idx;
+}
+
+/**
+ * srcu_read_unlock - unregister a old reader from an SRCU-protected structure.
+ * @sp: srcu_struct in which to unregister the old reader.
+ * @idx: return value from corresponding srcu_read_lock().
+ *
+ * Removes the count for the old reader from the appropriate per-CPU
+ * element of the srcu_struct.  Note that this may well be a different
+ * CPU than that which was incremented by the corresponding srcu_read_lock().
+ * Must be called from process context.
+ */
+void srcu_read_unlock(struct srcu_struct *sp, int idx)
+{
+	preempt_disable();
+	sp->per_cpu_ref[smp_processor_id()].c[idx]--;
+	preempt_enable();
+}
+
+/**
+ * synchronize_srcu - wait for prior SRCU read-side critical-section completion
+ * @sp: srcu_struct with which to synchronize.
+ *
+ * Flip the completed counter, and wait for the old count to drain to zero.
+ * As with classic RCU, the updater must use some separate means of
+ * synchronizing concurrent updates.  Can block; must be called from
+ * process context.
+ */
+void synchronize_srcu(struct srcu_struct *sp)
+{
+	int cpu;
+	int idx;
+	int sum;
+
+	might_sleep();
+
+	mutex_lock(&sp->mutex);
+
+	smp_mb();  /* Prevent operations from leaking in. */
+
+	idx = sp->completed & 0x1;
+	sp->completed++;
+
+	synchronize_sched();  /* forces memory barriers all around. */
+
+	/*
+	 * At this point, all srcu_read_lock() calls using the
+	 * old counters have completed.
+	 */
+
+	for (;;) {
+		sum = 0;
+		for_each_cpu(cpu) {
+			sum += sp->per_cpu_ref[cpu].c[idx];
+		}
+		if (sum == 0)
+			break;
+		schedule_timeout_interruptible(1);
+	}
+
+	synchronize_sched();  /* forces memory barriers all around. */
+
+	mutex_unlock(&sp->mutex);
+}
+
+/**
+ * srcu_batches_completed - return batches completed.
+ * @sp: srcu_struct on which to report batch completion.
+ *
+ * Report the number of batches, correlated with, but not necessarily
+ * precisely the same as, the number of grace periods that have elapsed.
+ */
+
+long srcu_batches_completed(struct srcu_struct *sp)
+{
+	return (sp->completed);
+}
+
+EXPORT_SYMBOL_GPL(init_srcu_struct);
+EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
+EXPORT_SYMBOL_GPL(srcu_read_lock);
+EXPORT_SYMBOL_GPL(srcu_read_unlock);
+EXPORT_SYMBOL_GPL(synchronize_srcu);
+EXPORT_SYMBOL_GPL(srcu_batches_completed);
