Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWIWPf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWIWPf2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 11:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWIWPf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 11:35:28 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:53657 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751248AbWIWPf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 11:35:26 -0400
Date: Sat, 23 Sep 2006 21:05:14 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Paul E McKenney <paulmck@us.ibm.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [-mm PATCH 3/4] RCU: preemptible RCU
Message-ID: <20060923153514.GD13432@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060923152957.GA13432@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060923152957.GA13432@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul McKenney <paulmck@us.ibm.com>

This patch implements a new version of RCU which allows its read-side
critical sections to be preempted. It uses a set of counter pairs
to keep track of the read-side critical sections and flips them
when all tasks exit read-side critical section. The details
of this implementation can be found in this paper -

http://www.rdrop.com/users/paulmck/RCU/OLSrtRCU.2006.08.11a.pdf

This patch was developed as a part of the -rt kernel
development and meant to provide better latencies when
read-side critical sections of RCU don't disable preemption.
As a consequence of keeping track of RCU readers, the readers
have a slight overhead (optimizations in the paper).
This implementation co-exists with the "classic" RCU
implementations and can be switched to at compiler.

Signed-off-by: Paul McKenney <paulmck@us.ibm.com>
Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>


 include/linux/rcupdate.h   |    5 
 include/linux/rcupreempt.h |   66 ++++++
 include/linux/sched.h      |    6 
 kernel/Kconfig.preempt     |   37 +++
 kernel/Makefile            |    4 
 kernel/rcupreempt.c        |  464 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 581 insertions(+), 1 deletion(-)

diff -puN include/linux/rcupdate.h~rcu-preempt include/linux/rcupdate.h
--- linux-2.6.18-rc6-mm1-rcu/include/linux/rcupdate.h~rcu-preempt	2006-09-23 10:00:31.000000000 +0530
+++ linux-2.6.18-rc6-mm1-rcu-dipankar/include/linux/rcupdate.h	2006-09-23 10:00:31.000000000 +0530
@@ -41,7 +41,12 @@
 #include <linux/percpu.h>
 #include <linux/cpumask.h>
 #include <linux/seqlock.h>
+#include <linux/config.h>
+#ifdef CONFIG_CLASSIC_RCU
 #include <linux/rcuclassic.h>
+#else
+#include <linux/rcupreempt.h>
+#endif
 
 /**
  * struct rcu_head - callback structure for use with RCU
diff -puN /dev/null include/linux/rcupreempt.h
--- /dev/null	2006-09-20 22:20:57.873117750 +0530
+++ linux-2.6.18-rc6-mm1-rcu-dipankar/include/linux/rcupreempt.h	2006-09-23 10:00:31.000000000 +0530
@@ -0,0 +1,66 @@
+/*
+ * Read-Copy Update mechanism for mutual exclusion (RT implementation)
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
+ * Author:  Paul McKenney <paulmck@us.ibm.com>
+ * 
+ * Based on the original work by Paul McKenney <paul.mckenney@us.ibm.com>
+ * and inputs from Rusty Russell, Andrea Arcangeli and Andi Kleen.
+ * Papers:
+ * http://www.rdrop.com/users/paulmck/paper/rclockpdcsproof.pdf
+ * http://lse.sourceforge.net/locking/rclock_OLS.2001.05.01c.sc.pdf (OLS2001)
+ *
+ * For detailed explanation of Read-Copy Update mechanism see -
+ * 		http://lse.sourceforge.net/locking/rcupdate.html
+ *
+ */
+
+#ifndef __LINUX_RCUPREEMPT_H
+#define __LINUX_RCUPREEMPT_H
+
+#ifdef __KERNEL__
+
+#include <linux/cache.h>
+#include <linux/spinlock.h>
+#include <linux/threads.h>
+#include <linux/percpu.h>
+#include <linux/cpumask.h>
+#include <linux/seqlock.h>
+
+#define rcu_qsctr_inc(cpu)
+#define rcu_bh_qsctr_inc(cpu)
+#define call_rcu_bh(head, rcu) call_rcu(head, rcu)
+
+extern void __rcu_read_lock(void);
+extern void __rcu_read_unlock(void);
+extern int rcu_pending(int cpu);
+
+#define __rcu_read_lock_bh()	{ rcu_read_lock(); local_bh_disable(); }
+#define __rcu_read_unlock_bh()	{ local_bh_enable(); rcu_read_unlock(); }
+
+#define __rcu_read_lock_nesting()	(current->rcu_read_lock_nesting)
+
+extern void __synchronize_sched(void);
+
+extern void __rcu_init(void);
+extern void rcu_check_callbacks(int cpu, int user);
+extern void rcu_restart_cpu(int cpu);
+extern long rcu_batches_completed(void);
+
+#endif /* __KERNEL__ */
+#endif /* __LINUX_RCUPREEMPT_H */
diff -puN include/linux/sched.h~rcu-preempt include/linux/sched.h
--- linux-2.6.18-rc6-mm1-rcu/include/linux/sched.h~rcu-preempt	2006-09-23 10:00:31.000000000 +0530
+++ linux-2.6.18-rc6-mm1-rcu-dipankar/include/linux/sched.h	2006-09-23 10:00:31.000000000 +0530
@@ -826,6 +826,12 @@ struct task_struct {
 	cpumask_t cpus_allowed;
 	unsigned int time_slice, first_time_slice;
 
+#ifdef CONFIG_PREEMPT_RCU
+        int rcu_read_lock_nesting;
+        atomic_t *rcu_flipctr1;
+        atomic_t *rcu_flipctr2;
+#endif
+
 #if defined(CONFIG_SCHEDSTATS) || defined(CONFIG_TASK_DELAY_ACCT)
 	struct sched_info sched_info;
 #endif
diff -puN kernel/Kconfig.preempt~rcu-preempt kernel/Kconfig.preempt
--- linux-2.6.18-rc6-mm1-rcu/kernel/Kconfig.preempt~rcu-preempt	2006-09-23 10:00:31.000000000 +0530
+++ linux-2.6.18-rc6-mm1-rcu-dipankar/kernel/Kconfig.preempt	2006-09-23 10:00:31.000000000 +0530
@@ -63,3 +63,40 @@ config PREEMPT_BKL
 	  Say Y here if you are building a kernel for a desktop system.
 	  Say N if you are unsure.
 
+choice
+	prompt "RCU implementation type:"
+	default CLASSIC_RCU
+
+config CLASSIC_RCU
+	bool "Classic RCU"
+	help
+	  This option selects the classic RCU implementation that is
+	  designed for best read-side performance on non-realtime
+	  systems.
+
+	  Say Y if you are unsure.
+
+config PREEMPT_RCU
+	bool "Preemptible RCU"
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
+endchoice
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
diff -puN kernel/Makefile~rcu-preempt kernel/Makefile
--- linux-2.6.18-rc6-mm1-rcu/kernel/Makefile~rcu-preempt	2006-09-23 10:00:31.000000000 +0530
+++ linux-2.6.18-rc6-mm1-rcu-dipankar/kernel/Makefile	2006-09-23 10:01:34.000000000 +0530
@@ -6,7 +6,7 @@ obj-y     = sched.o fork.o exec_domain.o
 	    exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
-	    rcupdate.o rcuclassic.o extable.o params.o posix-timers.o \
+	    extable.o params.o posix-timers.o \
 	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o mutex.o \
 	    hrtimer.o rwsem.o latency.o nsproxy.o srcu.o
 
@@ -47,6 +47,8 @@ obj-$(CONFIG_DETECT_SOFTLOCKUP) += softl
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
+obj-$(CONFIG_CLASSIC_RCU) += rcupdate.o rcuclassic.o
+obj-$(CONFIG_PREEMPT_RCU) += rcupdate.o rcupreempt.o
 obj-$(CONFIG_DEBUG_SYNCHRO_TEST) += synchro-test.o
 obj-$(CONFIG_RELAY) += relay.o
 obj-$(CONFIG_UTS_NS) += utsname.o
diff -puN /dev/null kernel/rcupreempt.c
--- /dev/null	2006-09-20 22:20:57.873117750 +0530
+++ linux-2.6.18-rc6-mm1-rcu-dipankar/kernel/rcupreempt.c	2006-09-23 10:00:31.000000000 +0530
@@ -0,0 +1,464 @@
+/*
+ * Read-Copy Update mechanism for mutual exclusion, realtime implementation
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
+ *		With thanks to Esben Nielsen, Bill Huey, and Ingo Molnar
+ *		for pushing me away from locks and towards counters.
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
+#include <linux/rcupdate.h>
+#include <linux/cpu.h>
+#include <linux/random.h>
+#include <linux/delay.h>
+#include <linux/byteorder/swabb.h>
+#include <linux/cpumask.h>
+
+/*
+ * PREEMPT_RCU data structures.
+ */
+
+struct rcu_data {
+	spinlock_t	lock;
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
+	spinlock_t	fliplock;
+	long		completed;	/* Number of last completed batch. */
+};
+static struct rcu_data rcu_data;
+static struct rcu_ctrlblk rcu_ctrlblk = {
+	.fliplock = SPIN_LOCK_UNLOCKED,
+	.completed = 0,
+};
+static DEFINE_PER_CPU(atomic_t [2], rcu_flipctr) =
+	{ ATOMIC_INIT(0), ATOMIC_INIT(0) };
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
+void __rcu_read_lock(void)
+{
+	int flipctr;
+	unsigned long oldirq;
+
+	local_irq_save(oldirq);
+
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
+	local_irq_restore(oldirq);
+}
+
+void __rcu_read_unlock(void)
+{
+	unsigned long oldirq;
+
+	local_irq_save(oldirq);
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
+
+	local_irq_restore(oldirq);
+}
+
+static void __rcu_advance_callbacks(void)
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
+static void rcu_try_flip(void)
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
+	for_each_possible_cpu(cpu) {
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
+void rcu_check_callbacks(int cpu, int user)
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
+static void rcu_process_callbacks(unsigned long data)
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
+void fastcall call_rcu(struct rcu_head *head, 
+				void (*func)(struct rcu_head *rcu))
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
+void __synchronize_sched(void)
+{
+	cpumask_t oldmask;
+	int cpu;
+
+	if (sched_getaffinity(0, &oldmask) < 0) {
+		oldmask = cpu_possible_map;
+	}
+	for_each_online_cpu(cpu) {
+		sched_setaffinity(0, cpumask_of_cpu(cpu));
+		schedule();
+	}
+	sched_setaffinity(0, oldmask);
+}
+
+int rcu_pending(int cpu)
+{
+	return (rcu_data.donelist != NULL ||
+		rcu_data.waitlist != NULL ||
+		rcu_data.nextlist != NULL);
+}
+
+void __init __rcu_init(void)
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
+	for_each_online_cpu(cpu) {
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
+EXPORT_SYMBOL_GPL(call_rcu);
+EXPORT_SYMBOL_GPL(rcu_batches_completed);
+EXPORT_SYMBOL_GPL(__synchronize_sched);
+EXPORT_SYMBOL_GPL(__rcu_read_lock);
+EXPORT_SYMBOL_GPL(__rcu_read_unlock);
+

_
