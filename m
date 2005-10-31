Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbVJaV7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbVJaV7m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 16:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbVJaV7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 16:59:42 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:21483 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964855AbVJaV7l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 16:59:41 -0500
Date: Mon, 31 Oct 2005 13:59:55 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, cfriesen@nortel.com, dada1@cosmosbay.com,
       khali@linux-fr.org, dipankar@in.ibm.com, belyshev@depni.sinp.msu.ru,
       manfred@colorfullife.com, torvalds@osdl.org
Subject: [PATCH] Alternative RCU implementation for short grace periods and realtime response
Message-ID: <20051031215955.GA3276@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The issue of realtime response and RCU short grace periods arose again
recently:

	http://marc.theaimsgroup.com/?l=linux-kernel&m=112938253403552&w=2

and was resolved (in the short term) in favor for short grace periods.
This patch provides an alternative RCU implementation with limited
scalability, but which provides both short grace periods and realtime
response.  The default RCU implementation remains "classic RCU"
(as it should unless/until the performance and scalability of the
alternative counter-based RCU implentation improves to the point that
it is indistinguishable from that of classic RCU -- and, yes, there is
work going on in this direction).

This alternative implementation can be selected with a config parameter
(CONFIG_RCU_COUNTER vs. the default CONFIG_RCU_CLASSIC), and provides
the hooks needed for the RCU torture tests.  This implementation passes
the torture tests on a number of platforms, and has seen extensive use
in Ingo Molnar's -rt tree over the past few months.

Signed-off-by: <paulmck@us.ibm.com>

 include/linux/rcupdate.h |   25 ++
 include/linux/sched.h    |    5 
 kernel/Kconfig.preempt   |   33 +++
 kernel/Makefile          |    4 
 kernel/rcucommon.h       |   73 +++++++
 kernel/rcucounter.c      |  481 +++++++++++++++++++++++++++++++++++++++++++++++
 kernel/rcupdate.c        |   63 ------
 7 files changed, 627 insertions(+), 57 deletions(-)
 
diff -urpNa -X dontdiff linux-2.6.14/include/linux/rcupdate.h linux-2.6.14-CtrRCU/include/linux/rcupdate.h
--- linux-2.6.14/include/linux/rcupdate.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14-CtrRCU/include/linux/rcupdate.h	2005-10-30 16:47:59.000000000 -0800
@@ -59,6 +59,7 @@ struct rcu_head {
 } while (0)
 
 
+#ifdef CONFIG_RCU_CLASSIC
 
 /* Global control variables for rcupdate callback mechanism. */
 struct rcu_ctrlblk {
@@ -193,6 +194,18 @@ static inline int rcu_pending(int cpu)
  */
 #define rcu_read_unlock()	preempt_enable()
 
+#else /* #ifdef CONFIG_RCU_CLASSIC */
+
+#define rcu_qsctr_inc(cpu)
+#define rcu_bh_qsctr_inc(cpu)
+#define call_rcu_bh(head, rcu) call_rcu(head, rcu)
+
+extern void rcu_read_lock(void);
+extern void rcu_read_unlock(void);
+extern int rcu_pending(int cpu);
+
+#endif /* #else #ifdef CONFIG_RCU_CLASSIC */
+
 /*
  * So where is rcu_write_lock()?  It does not exist, as there is no
  * way for writers to lock out RCU readers.  This is a feature, not
@@ -214,14 +227,22 @@ static inline int rcu_pending(int cpu)
  * can use just rcu_read_lock().
  *
  */
+#ifdef CONFIG_RCU_CLASSIC
 #define rcu_read_lock_bh()	local_bh_disable()
+#else /* #ifdef CONFIG_RCU_CLASSIC */
+#define rcu_read_lock_bh()	{ rcu_read_lock(); local_bh_disable(); }
+#endif /* #else #ifdef CONFIG_RCU_CLASSIC */
 
 /*
  * rcu_read_unlock_bh - marks the end of a softirq-only RCU critical section
  *
  * See rcu_read_lock_bh() for more information.
  */
+#ifdef CONFIG_RCU_CLASSIC
 #define rcu_read_unlock_bh()	local_bh_enable()
+#else /* #ifdef CONFIG_RCU_CLASSIC */
+#define rcu_read_unlock_bh()	{ local_bh_enable(); rcu_read_unlock(); }
+#endif /* #else #ifdef CONFIG_RCU_CLASSIC */
 
 /**
  * rcu_dereference - fetch an RCU-protected pointer in an
@@ -270,7 +291,11 @@ static inline int rcu_pending(int cpu)
  * synchronize_kernel() API.  In contrast, synchronize_rcu() only
  * guarantees that rcu_read_lock() sections will have completed.
  */
+#ifdef CONFIG_RCU_CLASSIC
 #define synchronize_sched() synchronize_rcu()
+#else /* #ifdef CONFIG_RCU_CLASSIC */
+extern void synchronize_sched(void);
+#endif /* #else #ifdef CONFIG_RCU_CLASSIC */
 
 extern void rcu_init(void);
 extern void rcu_check_callbacks(int cpu, int user);
diff -urpNa -X dontdiff linux-2.6.14/include/linux/sched.h linux-2.6.14-CtrRCU/include/linux/sched.h
--- linux-2.6.14/include/linux/sched.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14-CtrRCU/include/linux/sched.h	2005-10-30 17:42:21.000000000 -0800
@@ -666,6 +666,11 @@ struct task_struct {
 	cpumask_t cpus_allowed;
 	unsigned int time_slice, first_time_slice;
 
+#ifdef CONFIG_RCU_COUNTER
+	int rcu_read_lock_nesting;
+	atomic_t *rcu_flipctr1;
+	atomic_t *rcu_flipctr2;
+#endif
 #ifdef CONFIG_SCHEDSTATS
 	struct sched_info sched_info;
 #endif
diff -urpNa -X dontdiff linux-2.6.14/kernel/Kconfig.preempt linux-2.6.14-CtrRCU/kernel/Kconfig.preempt
--- linux-2.6.14/kernel/Kconfig.preempt	2005-10-30 17:07:58.000000000 -0800
+++ linux-2.6.14-CtrRCU/kernel/Kconfig.preempt	2005-10-30 17:07:10.000000000 -0800
@@ -63,3 +63,36 @@ config PREEMPT_BKL
 	  Say Y here if you are building a kernel for a desktop system.
 	  Say N if you are unsure.
 
+choice
+	prompt "RCU infrastructure implementation"
+	default RCU_CLASSIC
+
+config RCU_CLASSIC
+	bool "Classic RCU implementation"
+	help
+	  This is the classic Linux implementation of the RCU
+	  infrastructure, intended for excellent performance and
+	  scalability on machines that are not severely memory-constrained
+	  and that do not require aggressive realtime latencies.
+
+	  Select this option if you are building a kernel for a server or
+	  scientific/computation system, or if you want to maximize the
+	  raw processing power of the kernel, irrespective of scheduling
+	  latencies.
+
+config RCU_COUNTER
+	bool "Counter-based RCU implementation"
+	help
+	  This implementation of the RCU infrastructure manipulates
+	  per-CPU counters to mark the beginnings and ends of RCU
+	  read-side critical sections.	It is intended for aggressive
+	  realtime environments and for machines that are either severely
+	  memory-constrained or subject to exteme denial-of-service
+	  attacks.  Note that this implementation permits RCU
+	  read-side critical sections to be preempted.
+
+	  Select this if you are experimenting with the new RCU
+	  implementation or if RCU_CLASSIC is not meeting your realtime
+	  needs or your memory constraints.
+
+endchoice
diff -urpNa -X dontdiff linux-2.6.14/kernel/Makefile linux-2.6.14-CtrRCU/kernel/Makefile
--- linux-2.6.14/kernel/Makefile	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14-CtrRCU/kernel/Makefile	2005-10-30 16:59:50.000000000 -0800
@@ -6,7 +6,7 @@ obj-y     = sched.o fork.o exec_domain.o
 	    exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
-	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
+	    intermodule.o extable.o params.o posix-timers.o \
 	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o
 
 obj-$(CONFIG_FUTEX) += futex.o
@@ -32,6 +32,8 @@ obj-$(CONFIG_DETECT_SOFTLOCKUP) += softl
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
+obj-$(CONFIG_RCU_CLASSIC) += rcupdate.o 
+obj-$(CONFIG_RCU_COUNTER) += rcucounter.o 
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -urpNa -X dontdiff linux-2.6.14/kernel/rcucommon.h linux-2.6.14-CtrRCU/kernel/rcucommon.h
--- linux-2.6.14/kernel/rcucommon.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.14-CtrRCU/kernel/rcucommon.h	2005-10-30 15:01:01.000000000 -0800
@@ -0,0 +1,73 @@
+/*
+ * Read-Copy Update mechanism for mutual exclusion: implementation-
+ * independent definitions.
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
+ */
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
+ * Can't help multiprocessors which do not have cmpxchg :(
+ */
+spinlock_t __rcuref_hash[RCUREF_HASH_SIZE] = {
+	[0 ... (RCUREF_HASH_SIZE-1)] = SPIN_LOCK_UNLOCKED
+};
+#endif
diff -urpNa -X dontdiff linux-2.6.14/kernel/rcucounter.c linux-2.6.14-CtrRCU/kernel/rcucounter.c
--- linux-2.6.14/kernel/rcucounter.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.14-CtrRCU/kernel/rcucounter.c	2005-10-30 22:46:37.000000000 -0800
@@ -0,0 +1,481 @@
+/*
+ * Read-Copy Update counter-based infrastructure for mutual exclusion
+ *	This implementation offers better realtime response and smaller
+ *	memory footprint, but worse performance and scalability than
+ *	does the "classic" infrastructure.  EXPERIMENTAL
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
+ * Copyright (C) IBM Corporation, 2001
+ *
+ * Authors: Paul E. McKenney <paulmck@us.ibm.com>
+ *
+ * Papers:  http://www.rdrop.com/users/paulmck/RCU
+ *
+ * For detailed explanation of Read-Copy Update mechanism see -
+ * 		Documentation/RCU/ *.txt
+ *
+ */
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+#include <linux/interrupt.h>
+#include <linux/sched.h>
+#include <asm/atomic.h>
+#include <linux/bitops.h>
+#include <linux/module.h>
+#include <linux/completion.h>
+#include <linux/moduleparam.h>
+#include <linux/percpu.h>
+#include <linux/notifier.h>
+#include <linux/rcupdate.h>
+#include <linux/rcuref.h>
+#include <linux/cpu.h>
+
+#include "rcucommon.h"
+
+/* Definitions to allow common code between mainline and PREEMPT_RT. */
+
+#ifndef CONFIG_PREEMPT_RT
+#define raw_spinlock_t spinlock_t
+#define raw_local_irq_save local_irq_save
+#define raw_local_irq_restore local_irq_restore
+#define RAW_SPIN_LOCK_UNLOCKED SPIN_LOCK_UNLOCKED
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
+};
+static struct rcu_data rcu_data;
+static struct rcu_ctrlblk rcu_ctrlblk = {
+	.fliplock = RAW_SPIN_LOCK_UNLOCKED,
+	.completed = 0,
+};
+static DEFINE_PER_CPU(atomic_t [2], rcu_flipctr) =
+	{ ATOMIC_INIT(0), ATOMIC_INIT(0) };
+
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
+}
+
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
+	spin_lock_init(&rcu_data.lock);
+	rcu_data.completed = 0;
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
+ * Return the number of RCU batches processed thus far.  Useful
+ * for debug and statistics.
+ */
+long rcu_batches_completed(void)
+{
+	return rcu_ctrlblk.completed;
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
+EXPORT_SYMBOL_GPL(rcu_read_proc_data);
+EXPORT_SYMBOL_GPL(rcu_read_proc_gp_data);
+EXPORT_SYMBOL_GPL(rcu_read_proc_ptrs_data);
+EXPORT_SYMBOL_GPL(rcu_read_proc_ctrs_data);
+
+#endif /* #ifdef CONFIG_RCU_STATS */
+
+EXPORT_SYMBOL_GPL(rcu_batches_completed);
+EXPORT_SYMBOL(call_rcu); /* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL_GPL(synchronize_rcu);
+EXPORT_SYMBOL_GPL(synchronize_sched);
+EXPORT_SYMBOL(rcu_read_lock);  /* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL(rcu_read_unlock);  /* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL(synchronize_kernel);  /* WARNING: Removal in April 2006. */
diff -urpNa -X dontdiff linux-2.6.14/kernel/rcupdate.c linux-2.6.14-CtrRCU/kernel/rcupdate.c
--- linux-2.6.14/kernel/rcupdate.c	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14-CtrRCU/kernel/rcupdate.c	2005-10-30 17:45:37.000000000 -0800
@@ -1,5 +1,5 @@
 /*
- * Read-Copy Update mechanism for mutual exclusion
+ * Read-Copy Update "classic" infrastructure for mutual exclusion
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -19,15 +19,15 @@
  *
  * Authors: Dipankar Sarma <dipankar@in.ibm.com>
  *	    Manfred Spraul <manfred@colorfullife.com>
+ *	    Paul E. McKenney <paulmck@us.ibm.com>
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
@@ -48,6 +48,8 @@
 #include <linux/rcuref.h>
 #include <linux/cpu.h>
 
+#include "rcucommon.h"
+
 /* Definition for rcupdate control block. */
 struct rcu_ctrlblk rcu_ctrlblk = 
 	{ .cur = -300, .completed = -300 };
@@ -73,19 +75,6 @@ DEFINE_PER_CPU(struct rcu_data, rcu_bh_d
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
-
 /**
  * call_rcu - Queue an RCU callback for invocation after a grace period.
  * @head: structure to be used for queueing the RCU updates.
@@ -454,44 +443,6 @@ void __init rcu_init(void)
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
