Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422728AbWF0Xjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422728AbWF0Xjj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 19:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422734AbWF0Xji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 19:39:38 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:50091 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422732AbWF0Xjh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 19:39:37 -0400
Date: Tue, 27 Jun 2006 16:40:13 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       stern@rowland.harvard.edu, mingo@elte.hu, tytso@us.ibm.com,
       dvhltc@us.ibm.com, oleg@tv-sign.ru
Subject: [PATCH 1/2] srcu-2: RCU variant permitting read-side blocking
Message-ID: <20060627234012.GA2734@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060627233702.GA2696@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627233702.GA2696@us.ibm.com>
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

o	There is no call_srcu().  It would not be hard to implement
	one, but it seems like too easy a way to OOM the system.
	(Hey, we have enough trouble with call_rcu(), which does
	-not- permit readers to sleep!!!)  So, if you want it,
	please tell me why...

Signed-off-by: Paul E. McKenney <paulmck@us.ibm.com>
---

 Documentation/RCU/checklist.txt |   32 ++++++
 Documentation/RCU/rcu.txt       |    3 
 Documentation/RCU/whatisRCU.txt |    3 
 include/linux/srcu.h            |   42 ++++++++
 kernel/Makefile                 |    2 
 kernel/srcu.c                   |  188 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 268 insertions(+), 2 deletions(-)

diff -urpNa -X dontdiff linux-2.6.17-torturercu_bh/Documentation/RCU/checklist.txt linux-2.6.17-srcu/Documentation/RCU/checklist.txt
--- linux-2.6.17-torturercu_bh/Documentation/RCU/checklist.txt	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17-srcu/Documentation/RCU/checklist.txt	2006-06-24 08:04:07.000000000 -0700
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
+++ linux-2.6.17-srcu/include/linux/srcu.h	2006-06-26 18:19:49.000000000 -0700
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
+};
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
+++ linux-2.6.17-srcu/kernel/srcu.c	2006-06-27 12:48:33.000000000 -0700
@@ -0,0 +1,188 @@
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
+/**
+ * cleanup_srcu_struct - deconstruct a sleep-RCU structure
+ * @sp: structure to clean up.
+ *
+ * Must invoke this after you are finished using a given srcu_struct.
+ * Failure to do so will result in a memory leak.
+ */
+void cleanup_srcu_struct(struct srcu_struct *sp)
+{
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
+	barrier();
+	per_cpu_ptr(sp->per_cpu_ref, smp_processor_id())->c[idx]++;
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
+	per_cpu_ptr(sp->per_cpu_ref, smp_processor_id())->c[idx]--;
+	preempt_enable();
+}
+
+/*
+ * Do a single flip of the SRCU counters -- a pair of flips is required
+ * to force a grace period.  The reason that a single flip is insufficient
+ * is that there are no memory barriers in srcu_read_lock(), which
+ * means that the corresponding critical section can "bleed out", so
+ * that the old pointer is fetched, but the new counter incremented.
+ * Doing a pair of flips guarantees that -all- read-side critical sections
+ * are accounted for.
+ *
+ * We still need to flip the counters, since we want the grace period
+ * to end even when there might be at least one read-side critical section
+ * in progress at all times.
+ */
+static void synchronize_srcu_flip(struct srcu_struct *sp)
+{
+	int cpu;
+	int idx;
+	int sum;
+
+	/* Do the flip. */
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
+		for_each_possible_cpu(cpu)
+			sum += per_cpu_ptr(sp->per_cpu_ref, cpu)->c[idx];
+		if (sum == 0)
+			break;
+		schedule_timeout_interruptible(1);
+	}
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
+	mutex_lock(&sp->mutex);
+
+	smp_mb();  /* Prevent operations from leaking in. */
+
+	/* Do a pair of flips to ensure that all prior readers complete. */
+
+	synchronize_srcu_flip(sp);
+	synchronize_srcu_flip(sp);
+
+	/* Force all concurrent srcu_read_unlock() calls to finish cleanly. */
+
+	synchronize_sched();
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
