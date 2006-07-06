Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWGFSfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWGFSfr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 14:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWGFSfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 14:35:47 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:7077 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750720AbWGFSfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 14:35:45 -0400
Date: Thu, 6 Jul 2006 10:20:22 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@us.ibm.com
Cc: akpm@osdl.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       stern@rowland.harvard.edu, mingo@elte.hu, tytso@us.ibm.com,
       dvhltc@us.ibm.com, oleg@tv-sign.ru, jes@sgi.com
Subject: [PATCH 1/2] srcu-3: RCU variant permitting read-side blocking
Message-ID: <20060706172022.GA1901@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060706171401.GA1768@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060706171401.GA1768@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updated patch adding a variant of RCU that permits sleeping in read-side
critical sections.  SRCU is as follows:

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

	Of course, it is not permitted to call synchronize_srcu()
	while in an SRCU read-side critical section.

o	There is no call_srcu().  It would not be hard to implement
	one, but it seems like too easy a way to OOM the system.
	(Hey, we have enough trouble with call_rcu(), which does
	-not- permit readers to sleep!!!)  So, if you want it,
	please tell me why...

Signed-off-by: Paul E. McKenney <paulmck@us.ibm.com>
---

 Documentation/RCU/checklist.txt |   38 ++++++
 Documentation/RCU/rcu.txt       |    3 
 Documentation/RCU/whatisRCU.txt |    3 
 include/linux/srcu.h            |   49 ++++++++
 kernel/Makefile                 |    2 
 kernel/srcu.c                   |  238 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 331 insertions(+), 2 deletions(-)

diff -urpNa -X dontdiff linux-2.6.17-torturercu_bh/Documentation/RCU/checklist.txt linux-2.6.17-srcu/Documentation/RCU/checklist.txt
--- linux-2.6.17-torturercu_bh/Documentation/RCU/checklist.txt	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17-srcu/Documentation/RCU/checklist.txt	2006-06-30 17:07:02.000000000 -0700
@@ -183,3 +183,41 @@ over a rather long period of time, but i
 	disable irq on a given acquisition of that lock will result in
 	deadlock as soon as the RCU callback happens to interrupt that
 	acquisition's critical section.
+
+13.	SRCU (srcu_read_lock(), srcu_read_unlock(), and synchronize_srcu())
+	may only be invoked from process context.  Unlike other forms of
+	RCU, it -is- permissible to block in an SRCU read-side critical
+	section (demarked by srcu_read_lock() and srcu_read_unlock()),
+	hence the "SRCU": "sleepable RCU".  Please note that if you
+	don't need to sleep in read-side critical sections, you should
+	be using RCU rather than SRCU, because RCU is almost always
+	faster and easier to use than is SRCU.
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
+	Therefore, SRCU is less prone to OOM the system than RCU would
+	be if RCU's read-side critical sections were permitted to
+	sleep.
+
+	The ability to sleep in read-side critical sections does not
+	come for free.	First, corresponding srcu_read_lock() and
+	srcu_read_unlock() calls must be passed the same srcu_struct.
+	Second, grace-period-detection overhead is amortized only
+	over those updates sharing a given srcu_struct, rather than
+	being globally amortized as they are for other forms of RCU.
+	Therefore, SRCU should be used in preference to rw_semaphore
+	only in extremely read-intensive situations, or in situations
+	requiring SRCU's read-side deadlock immunity or low read-side
+	realtime latency.
+
+	Note that, rcu_assign_pointer() and rcu_dereference() relate to
+	SRCU just as they do to other forms of RCU.
diff -urpNa -X dontdiff linux-2.6.17-torturercu_bh/Documentation/RCU/rcu.txt linux-2.6.17-srcu/Documentation/RCU/rcu.txt
--- linux-2.6.17-torturercu_bh/Documentation/RCU/rcu.txt	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17-srcu/Documentation/RCU/rcu.txt	2006-06-24 08:04:07.000000000 -0700
@@ -45,7 +45,8 @@ o	How can I see where RCU is currently u
 
 	Search for "rcu_read_lock", "rcu_read_unlock", "call_rcu",
 	"rcu_read_lock_bh", "rcu_read_unlock_bh", "call_rcu_bh",
-	"synchronize_rcu", and "synchronize_net".
+	"srcu_read_lock", "srcu_read_unlock", "synchronize_rcu",
+	"synchronize_net", and "synchronize_srcu".
 
 o	What guidelines should I follow when writing code that uses RCU?
 
diff -urpNa -X dontdiff linux-2.6.17-torturercu_bh/Documentation/RCU/whatisRCU.txt linux-2.6.17-srcu/Documentation/RCU/whatisRCU.txt
--- linux-2.6.17-torturercu_bh/Documentation/RCU/whatisRCU.txt	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17-srcu/Documentation/RCU/whatisRCU.txt	2006-06-24 08:04:07.000000000 -0700
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
 
diff -urpNa -X dontdiff linux-2.6.17-torturercu_bh/include/linux/srcu.h linux-2.6.17-srcu/include/linux/srcu.h
--- linux-2.6.17-torturercu_bh/include/linux/srcu.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17-srcu/include/linux/srcu.h	2006-07-02 07:27:32.000000000 -0700
@@ -0,0 +1,49 @@
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
+};
+
+struct srcu_struct {
+	int completed;
+	struct srcu_struct_array *per_cpu_ref;
+	struct mutex mutex;
+};
+
+#ifndef CONFIG_PREEMPT
+#define srcu_barrier() barrier()
+#else /* #ifndef CONFIG_PREEMPT */
+#define srcu_barrier()
+#endif /* #else #ifndef CONFIG_PREEMPT */
+
+void init_srcu_struct(struct srcu_struct *sp);
+void cleanup_srcu_struct(struct srcu_struct *sp);
+int srcu_read_lock(struct srcu_struct *sp);
+void srcu_read_unlock(struct srcu_struct *sp, int idx);
+void synchronize_srcu(struct srcu_struct *sp);
+long srcu_batches_completed(struct srcu_struct *sp);
+void cleanup_srcu_struct(struct srcu_struct *sp);
diff -urpNa -X dontdiff linux-2.6.17-torturercu_bh/kernel/Makefile linux-2.6.17-srcu/kernel/Makefile
--- linux-2.6.17-torturercu_bh/kernel/Makefile	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17-srcu/kernel/Makefile	2006-06-24 08:04:07.000000000 -0700
@@ -8,7 +8,7 @@ obj-y     = sched.o fork.o exec_domain.o
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o extable.o params.o posix-timers.o \
 	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o mutex.o \
-	    hrtimer.o
+	    hrtimer.o srcu.o
 
 obj-$(CONFIG_DEBUG_MUTEXES) += mutex-debug.o
 obj-$(CONFIG_FUTEX) += futex.o
diff -urpNa -X dontdiff linux-2.6.17-torturercu_bh/kernel/srcu.c linux-2.6.17-srcu/kernel/srcu.c
--- linux-2.6.17-torturercu_bh/kernel/srcu.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17-srcu/kernel/srcu.c	2006-07-04 18:49:13.000000000 -0700
@@ -0,0 +1,238 @@
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
+#include <linux/percpu.h>
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
+	sp->completed = 0;
+	sp->per_cpu_ref = alloc_percpu(struct srcu_struct_array);
+	mutex_init(&sp->mutex);
+}
+
+/*
+ * srcu_readers_active_idx -- returns approximate number of readers
+ *	active on the specified rank of per-CPU counters.
+ */
+
+static int srcu_readers_active_idx(struct srcu_struct *sp, int idx)
+{
+	int cpu;
+	int sum;
+
+	sum = 0;
+	for_each_possible_cpu(cpu)
+		sum += per_cpu_ptr(sp->per_cpu_ref, cpu)->c[idx];
+	return (sum);
+}
+
+/**
+ * srcu_readers_active - returns approximate number of readers.
+ * @sp: which srcu_struct to count active readers (holding srcu_read_lock).
+ *
+ * Note that this is not an atomic primitive, and can therefore suffer
+ * severe errors when invoked on an active srcu_struct.  That said, it
+ * can be useful as an error check at cleanup time.
+ */
+int srcu_readers_active(struct srcu_struct *sp)
+{
+	return srcu_readers_active_idx(sp, 0) + srcu_readers_active_idx(sp, 1);
+}
+
+/**
+ * cleanup_srcu_struct - deconstruct a sleep-RCU structure
+ * @sp: structure to clean up.
+ *
+ * Must invoke this after you are finished using a given srcu_struct that
+ * was initialized via init_srcu_struct(), else you leak memory.
+ */
+void cleanup_srcu_struct(struct srcu_struct *sp)
+{
+	int sum;
+
+	sum = srcu_readers_active(sp);
+	WARN_ON(sum);  /* Leakage unless caller handles error. */
+	if (sum != 0)
+		return;
+	free_percpu(sp->per_cpu_ref);
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
+	barrier();  /* ensure compiler looks -once- at sp->completed. */
+	per_cpu_ptr(sp->per_cpu_ref, smp_processor_id())->c[idx]++;
+	srcu_barrier();  /* ensure compiler won't misorder critical section. */
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
+	srcu_barrier();  /* ensure compiler won't misorder critical section. */
+	per_cpu_ptr(sp->per_cpu_ref, smp_processor_id())->c[idx]--;
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
+	int idx;
+	int sum;
+
+	idx = sp->completed;
+	mutex_lock(&sp->mutex);
+
+	/*
+	 * Check to see if someone else did the work for us while we were
+	 * waiting to acquire the lock.  We need -two- advances of
+	 * the counter, not just one.  If there was but one, we might have
+	 * shown up -after- our helper's first synchronize_sched(), thus
+	 * having failed to prevent CPU-reordering races with concurrent
+	 * srcu_read_unlock()s on other CPUs (see comment below).  So we
+	 * either (1) wait for two or (2) supply the second ourselves.
+	 */
+
+	if ((sp->completed - idx) >= 2) {
+		mutex_unlock(&sp->mutex);
+		return;
+	}
+
+	synchronize_sched();  /* Force memory barrier on all CPUs. */
+
+	/*
+	 * The preceding synchronize_sched() ensures that any CPU that
+	 * sees the new value of sp->completed will also see any preceding
+	 * changes to data structures made by this CPU.  This prevents
+	 * some other CPU from reordering the accesses in its SRCU
+	 * read-side critical section to precede the corresponding
+	 * srcu_read_lock() -- ensuring that such references will in
+	 * fact be protected.
+	 *
+	 * So it is now safe to do the flip.
+	 */
+
+	idx = sp->completed & 0x1;
+	sp->completed++;
+
+	synchronize_sched();  /* Force memory barrier on all CPUs. */
+
+	/*
+	 * At this point, because of the preceding synchronize_sched(),
+	 * all srcu_read_lock() calls using the old counters have completed.
+	 * Their corresponding critical sections might well be still
+	 * executing, but the srcu_read_lock() primitives themselves
+	 * will have finished executing.
+	 */
+
+	for (;;) {
+		sum = srcu_readers_active_idx(sp, idx);
+		if (sum == 0)
+			break;
+		schedule_timeout_interruptible(1);
+	}
+
+	synchronize_sched();  /* Force memory barrier on all CPUs. */
+
+	/*
+	 * The preceding synchronize_sched() forces all srcu_read_unlock()
+	 * primitives that were executing concurrently with the preceding
+	 * for_each_possible_cpu() loop to have completed by this point.
+	 * More importantly, it also forces the corresponding SRCU read-side
+	 * critical sections to have also completed, and the corresponding
+	 * references to SRCU-protected data items to be dropped.
+	 */
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
+	return sp->completed;
+}
+
+EXPORT_SYMBOL_GPL(init_srcu_struct);
+EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
+EXPORT_SYMBOL_GPL(srcu_read_lock);
+EXPORT_SYMBOL_GPL(srcu_read_unlock);
+EXPORT_SYMBOL_GPL(synchronize_srcu);
+EXPORT_SYMBOL_GPL(srcu_batches_completed);
+EXPORT_SYMBOL_GPL(srcu_readers_active);
