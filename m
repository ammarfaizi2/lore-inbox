Return-Path: <linux-kernel-owner+w=401wt.eu-S1751446AbXAOT3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbXAOT3q (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 14:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbXAOT3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 14:29:45 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:44055 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751425AbXAOT3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 14:29:43 -0500
Date: Tue, 16 Jan 2007 00:58:58 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Paul E McKenney <paulmck@linux.vnet.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [mm PATCH 4/6] RCU: preemptible RCU
Message-ID: <20070115192858.GE32238@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20070115191909.GA32238@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070115191909.GA32238@in.ibm.com>
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



diff -puN include/linux/init_task.h~rcu-preempt include/linux/init_task.h
--- linux-2.6.20-rc3-mm1-rcu/include/linux/init_task.h~rcu-preempt	2007-01-15 15:36:51.000000000 +0530
+++ linux-2.6.20-rc3-mm1-rcu-dipankar/include/linux/init_task.h	2007-01-15 15:36:51.000000000 +0530
@@ -90,6 +90,14 @@ extern struct nsproxy init_nsproxy;
 
 extern struct group_info init_groups;
 
+#ifdef CONFIG_PREEMPT_RCU
+#define INIT_PREEMPT_RCU						\
+	.rcu_read_lock_nesting = 0,					\
+	.rcu_flipctr_idx = 0,
+#else
+#define INIT_PREEMPT_RCU
+#endif
+
 /*
  *  INIT_TASK is used to set up the first task table, touch at
  * your own risk!. Base=0, limit=0x1fffff (=2MB)
@@ -111,6 +119,7 @@ extern struct group_info init_groups;
 	.run_list	= LIST_HEAD_INIT(tsk.run_list),			\
 	.ioprio		= 0,						\
 	.time_slice	= HZ,						\
+	INIT_PREEMPT_RCU						\
 	.tasks		= LIST_HEAD_INIT(tsk.tasks),			\
 	.ptrace_children= LIST_HEAD_INIT(tsk.ptrace_children),		\
 	.ptrace_list	= LIST_HEAD_INIT(tsk.ptrace_list),		\
diff -puN include/linux/rcuclassic.h~rcu-preempt include/linux/rcuclassic.h
--- linux-2.6.20-rc3-mm1-rcu/include/linux/rcuclassic.h~rcu-preempt	2007-01-15 15:36:51.000000000 +0530
+++ linux-2.6.20-rc3-mm1-rcu-dipankar/include/linux/rcuclassic.h	2007-01-15 15:36:51.000000000 +0530
@@ -142,7 +142,6 @@ extern int rcu_needs_cpu(int cpu);
 extern void __rcu_init(void);
 extern void rcu_check_callbacks(int cpu, int user);
 extern void rcu_restart_cpu(int cpu);
-extern long rcu_batches_completed(void);
 
 #endif /* __KERNEL__ */
 #endif /* __LINUX_RCUCLASSIC_H */
diff -puN include/linux/rcupdate.h~rcu-preempt include/linux/rcupdate.h
--- linux-2.6.20-rc3-mm1-rcu/include/linux/rcupdate.h~rcu-preempt	2007-01-15 15:36:51.000000000 +0530
+++ linux-2.6.20-rc3-mm1-rcu-dipankar/include/linux/rcupdate.h	2007-01-15 15:36:51.000000000 +0530
@@ -41,7 +41,11 @@
 #include <linux/percpu.h>
 #include <linux/cpumask.h>
 #include <linux/seqlock.h>
+#ifdef CONFIG_CLASSIC_RCU
 #include <linux/rcuclassic.h>
+#else
+#include <linux/rcupreempt.h>
+#endif
 
 /**
  * struct rcu_head - callback structure for use with RCU
@@ -216,10 +220,13 @@ extern void FASTCALL(call_rcu_bh(struct 
 /* Exported common interfaces */
 extern void synchronize_rcu(void);
 extern void rcu_barrier(void);
+extern long rcu_batches_completed(void);
+extern long rcu_batches_completed_bh(void);
   
 /* Internal to kernel */
 extern void rcu_init(void);
 extern void rcu_check_callbacks(int cpu, int user);
+extern int rcu_needs_cpu(int cpu);
 
 #endif /* __KERNEL__ */
 #endif /* __LINUX_RCUPDATE_H */
diff -puN /dev/null include/linux/rcupreempt.h
--- /dev/null	2006-03-26 18:34:52.000000000 +0530
+++ linux-2.6.20-rc3-mm1-rcu-dipankar/include/linux/rcupreempt.h	2007-01-15 15:36:51.000000000 +0530
@@ -0,0 +1,65 @@
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
+ * Copyright IBM Corporation, 2006
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
+
+#endif /* __KERNEL__ */
+#endif /* __LINUX_RCUPREEMPT_H */
diff -puN include/linux/sched.h~rcu-preempt include/linux/sched.h
--- linux-2.6.20-rc3-mm1-rcu/include/linux/sched.h~rcu-preempt	2007-01-15 15:36:51.000000000 +0530
+++ linux-2.6.20-rc3-mm1-rcu-dipankar/include/linux/sched.h	2007-01-15 15:36:51.000000000 +0530
@@ -848,6 +848,11 @@ struct task_struct {
 	cpumask_t cpus_allowed;
 	unsigned int time_slice, first_time_slice;
 
+#ifdef CONFIG_PREEMPT_RCU
+        int rcu_read_lock_nesting;
+        int rcu_flipctr_idx;
+#endif
+
 #if defined(CONFIG_SCHEDSTATS) || defined(CONFIG_TASK_DELAY_ACCT)
 	struct sched_info sched_info;
 #endif
diff -puN kernel/fork.c~rcu-preempt kernel/fork.c
--- linux-2.6.20-rc3-mm1-rcu/kernel/fork.c~rcu-preempt	2007-01-15 15:36:51.000000000 +0530
+++ linux-2.6.20-rc3-mm1-rcu-dipankar/kernel/fork.c	2007-01-15 15:36:51.000000000 +0530
@@ -941,6 +941,16 @@ static inline void rt_mutex_init_task(st
 #endif
 }
 
+#ifdef CONFIG_PREEMPT_RCU
+static inline void rcu_task_init(struct task_struct *p)
+{
+	p->rcu_read_lock_nesting = 0;
+	p->rcu_flipctr_idx = 0;
+}
+#else
+static inline void rcu_task_init(struct task_struct *p) {}
+#endif
+
 /*
  * This creates a new process as a copy of the old one,
  * but does not actually start it yet.
@@ -1026,6 +1036,7 @@ static struct task_struct *copy_process(
 
 	INIT_LIST_HEAD(&p->children);
 	INIT_LIST_HEAD(&p->sibling);
+	rcu_task_init(p);
 	p->vfork_done = NULL;
 	spin_lock_init(&p->alloc_lock);
 
diff -puN kernel/Kconfig.preempt~rcu-preempt kernel/Kconfig.preempt
--- linux-2.6.20-rc3-mm1-rcu/kernel/Kconfig.preempt~rcu-preempt	2007-01-15 15:36:51.000000000 +0530
+++ linux-2.6.20-rc3-mm1-rcu-dipankar/kernel/Kconfig.preempt	2007-01-15 15:36:51.000000000 +0530
@@ -63,3 +63,29 @@ config PREEMPT_BKL
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
diff -puN kernel/Makefile~rcu-preempt kernel/Makefile
--- linux-2.6.20-rc3-mm1-rcu/kernel/Makefile~rcu-preempt	2007-01-15 15:36:51.000000000 +0530
+++ linux-2.6.20-rc3-mm1-rcu-dipankar/kernel/Makefile	2007-01-15 15:36:51.000000000 +0530
@@ -6,9 +6,9 @@ obj-y     = sched.o fork.o exec_domain.o
 	    exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o user_namespace.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
-	    rcupdate.o rcuclassic.o extable.o params.o posix-timers.o \
+	    extable.o params.o posix-timers.o \
 	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o mutex.o \
-	    hrtimer.o rwsem.o latency.o nsproxy.o srcu.o
+	    hrtimer.o rwsem.o latency.o nsproxy.o rcupdate.o srcu.o
 
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
 obj-y += time/
@@ -46,6 +46,8 @@ obj-$(CONFIG_DETECT_SOFTLOCKUP) += softl
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
+obj-$(CONFIG_CLASSIC_RCU) += rcuclassic.o
+obj-$(CONFIG_PREEMPT_RCU) += rcupreempt.o
 obj-$(CONFIG_DEBUG_SYNCHRO_TEST) += synchro-test.o
 obj-$(CONFIG_RELAY) += relay.o
 obj-$(CONFIG_UTS_NS) += utsname.o
diff -puN /dev/null kernel/rcupreempt.c
--- /dev/null	2006-03-26 18:34:52.000000000 +0530
+++ linux-2.6.20-rc3-mm1-rcu-dipankar/kernel/rcupreempt.c	2007-01-15 15:36:51.000000000 +0530
@@ -0,0 +1,595 @@
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
+ * Copyright IBM Corporation, 2006
+ *
+ * Authors: Paul E. McKenney <paulmck@us.ibm.com>
+ *		With thanks to Esben Nielsen, Bill Huey, and Ingo Molnar
+ *		for pushing me away from locks and towards counters, and
+ *		to Suparna Bhattacharya for pushing me completely away
+ *		from atomic instructions on the read side.
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
+	struct rcu_head *nextlist;
+	struct rcu_head **nexttail;
+	struct rcu_head *waitlist;
+	struct rcu_head **waittail;
+	struct rcu_head *donelist;
+	struct rcu_head **donetail;
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
+static DEFINE_PER_CPU(int [2], rcu_flipctr) = { 0, 0 };
+
+/*
+ * States for rcu_try_flip() and friends.
+ */
+enum rcu_try_flip_state {
+	RCU_TRY_FLIP_IDLE,	/* "I" */
+	RCU_TRY_FLIP_GP,	/* "G" */
+	RCU_TRY_FLIP_WAITACK, 	/* "A" */
+	RCU_TRY_FLIP_WAITZERO,	/* "Z" */
+	RCU_TRY_FLIP_WAITMB	/* "M" */
+};
+static enum rcu_try_flip_state rcu_try_flip_state = RCU_TRY_FLIP_IDLE;
+
+/*
+ * Enum and per-CPU flag to determine when each CPU has seen
+ * the most recent counter flip.
+ */
+enum rcu_flip_flag_value {
+	RCU_FLIP_SEEN,		/* Steady/initial state, last flip seen. */
+				/* Only GP detector can update. */
+	RCU_FLIPPED		/* Flip just completed, need confirmation. */
+				/* Only corresponding CPU can update. */
+};
+static DEFINE_PER_CPU(enum rcu_flip_flag_value, rcu_flip_flag) = RCU_FLIP_SEEN;
+
+/*
+ * Enum and per-CPU flag to determine when each CPU has executed the
+ * needed memory barrier to fence in memory references from its last RCU
+ * read-side critical section in the just-completed grace period.
+ */
+enum rcu_mb_flag_value {
+	RCU_MB_DONE,		/* Steady/initial state, no mb()s required. */
+				/* Only GP detector can update. */
+	RCU_MB_NEEDED		/* Flip just completed, need an mb(). */
+				/* Only corresponding CPU can update. */
+};
+static DEFINE_PER_CPU(enum rcu_mb_flag_value, rcu_mb_flag) = RCU_MB_DONE;
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
+long rcu_batches_completed_bh(void)
+{
+	return rcu_ctrlblk.completed;
+}
+
+void __rcu_read_lock(void)
+{
+	int idx;
+	int nesting;
+
+	nesting = current->rcu_read_lock_nesting;
+	if (nesting != 0) {
+
+		/* An earlier rcu_read_lock() covers us, just count this one. */
+		current->rcu_read_lock_nesting = nesting + 1;
+
+	} else {
+		unsigned long oldirq;
+
+		/*
+		 * Disable local interrupts to prevent the grace-period
+		 * detection state machine from seeing us half-done.
+		 */
+		local_irq_save(oldirq);
+
+		/*
+		 * Outermost nesting of rcu_read_lock(), so atomically
+		 * increment the current counter for the current CPU.
+		 */
+		idx = rcu_ctrlblk.completed & 0x1;
+		smp_read_barrier_depends();
+		barrier();
+		__get_cpu_var(rcu_flipctr)[idx]++;
+		barrier();
+
+		/*
+		 * Now that the per-CPU counter has been incremented, we
+		 * are protected.  We can therefore safely increment
+		 * the nesting counter, relieving further NMIs of the
+		 * need to do so.
+		 */
+		current->rcu_read_lock_nesting = nesting + 1;
+		barrier();
+
+		/*
+		 * Now that we have prevented any NMIs from storing
+		 * to the ->rcu_flipctr_idx, we can safely use it to
+		 * remember which counter to decrement in the matching
+		 * rcu_read_unlock().
+		 */
+		current->rcu_flipctr_idx = idx;
+		local_irq_restore(oldirq);
+	}
+}
+
+void __rcu_read_unlock(void)
+{
+	int idx;
+	int nesting;
+
+	nesting = current->rcu_read_lock_nesting;
+	if (nesting > 1) {
+		/*
+		 * We are still protected by an enclosing rcu_read_lock(),
+		 * so simply decrement the counter.
+		 */
+		current->rcu_read_lock_nesting = nesting - 1;
+
+	} else {
+		unsigned long oldirq;
+
+		/*
+		 * Disable local interrupts to prevent the grace-period
+		 * detection state machine from seeing us half-done.
+		 */
+		local_irq_save(oldirq);
+
+		/*
+		 * Outermost nesting of rcu_read_unlock(), so we must
+		 * decrement the current counter for the current CPU.
+		 * This must be done carefully, because NMIs can
+		 * occur at any point in this code, and any rcu_read_lock()
+		 * and rcu_read_unlock() pairs in the NMI handlers
+		 * must interact non-destructively with this code.
+		 * Lots of barrier() calls, and -very- careful ordering.
+		 *
+		 * Changes to this code, including this one, must be
+		 * inspected, validated, and tested extremely carefully!!!
+		 */
+
+		/* 
+		 * First, pick up the index.  Enforce ordering for
+		 * both compilers and for DEC Alpha.
+		 */
+		idx = current->rcu_flipctr_idx;
+		smp_read_barrier_depends();
+		barrier();
+
+		/*
+		 * It is now safe to decrement the task's nesting count.
+		 * NMIs that occur after this statement will route
+		 * their rcu_read_lock() calls through this "else" clause
+		 * of this "if" statement, and thus will start incrementing
+		 * the per-CPU counter on their own.  Enforce ordering for
+		 * compilers.
+		 */
+		current->rcu_read_lock_nesting = nesting - 1;
+		barrier();
+
+		/*
+		 * Decrement the per-CPU counter. NMI handlers
+		 * might increment it as well, but they had better
+		 * properly nest their rcu_read_lock()/rcu_read_unlock()
+		 * pairs so that the value is restored before the handler
+		 * returns to us.
+		 */
+		__get_cpu_var(rcu_flipctr)[idx]--;
+		local_irq_restore(oldirq);
+	}
+}
+
+static void __rcu_advance_callbacks(void)
+{
+	if ((rcu_data.completed >> 1) != (rcu_ctrlblk.completed >> 1)) {
+		if (rcu_data.waitlist != NULL) {
+			*rcu_data.donetail = rcu_data.waitlist;
+			rcu_data.donetail = rcu_data.waittail;
+		}
+		if (rcu_data.nextlist != NULL) {
+			rcu_data.waitlist = rcu_data.nextlist;
+			rcu_data.waittail = rcu_data.nexttail;
+			rcu_data.nextlist = NULL;
+			rcu_data.nexttail = &rcu_data.nextlist;
+		} else {
+			rcu_data.waitlist = NULL;
+			rcu_data.waittail = &rcu_data.waitlist;
+		}
+		rcu_data.completed = rcu_ctrlblk.completed;
+	} else if (rcu_data.completed != rcu_ctrlblk.completed)
+		rcu_data.completed = rcu_ctrlblk.completed;
+}
+
+/*
+ * Get here when RCU is idle.  Decide whether we need to
+ * move out of idle state, and return zero if so.
+ * "Straightforward" approach for the moment, might later
+ * use callback-list lengths, grace-period duration, or
+ * some such to determine when to exit idle state.
+ * Might also need a pre-idle test that does not acquire
+ * the lock, but let's get the simple case working first...
+ */
+static int rcu_try_flip_idle(int flipctr)
+{
+	if (!rcu_pending(smp_processor_id()))
+		return 1;
+	return 0;
+}
+
+/*
+ * Flip processing up to and including the flip, as well as
+ * telling CPUs to acknowledge the flip.
+ */
+static int rcu_try_flip_in_gp(int flipctr)
+{
+	int cpu;
+
+	/*
+	 * Do the flip.
+	 */
+	rcu_ctrlblk.completed++;  /* stands in for rcu_try_flip_g2 */
+
+	/*
+	 * Need a memory barrier so that other CPUs see the new
+	 * counter value before they see the subsequent change of all
+	 * the rcu_flip_flag instances to RCU_FLIPPED.
+	 */
+	smp_mb();
+
+	/* Now ask each CPU for acknowledgement of the flip. */
+
+	for_each_possible_cpu(cpu)
+		per_cpu(rcu_flip_flag, cpu) = RCU_FLIPPED;
+
+	return 0;
+}
+
+/*
+ * Wait for CPUs to acknowledge the flip.
+ */
+static int rcu_try_flip_waitack(int flipctr)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		if (per_cpu(rcu_flip_flag, cpu) != RCU_FLIP_SEEN) 
+			return 1;
+
+	/*
+	 * Make sure our checks above don't bleed into subsequent
+	 * waiting for the sum of the counters to reach zero.
+	 */
+	smp_mb();
+	return 0;
+}
+
+/*
+ * Wait for collective ``last'' counter to reach zero,
+ * then tell all CPUs to do an end-of-grace-period memory barrier.
+ */
+static int rcu_try_flip_waitzero(int flipctr)
+{
+	int cpu;
+	int lastidx = !(flipctr & 0x1);
+	int sum = 0;
+
+	/* Check to see if the sum of the "last" counters is zero. */
+
+	for_each_possible_cpu(cpu)
+		sum += per_cpu(rcu_flipctr, cpu)[lastidx];
+	if (sum != 0)
+		return 1;
+
+	/* Make sure we don't call for memory barriers before we see zero. */
+	smp_mb();
+
+	/* Call for a memory barrier from each CPU. */
+	for_each_possible_cpu(cpu)
+		per_cpu(rcu_mb_flag, cpu) = RCU_MB_NEEDED;
+
+	return 0;
+}
+
+/*
+ * Wait for all CPUs to do their end-of-grace-period memory barrier.
+ * Return 0 once all CPUs have done so.
+ */
+static int rcu_try_flip_waitmb(int flipctr)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		if (per_cpu(rcu_mb_flag, cpu) != RCU_MB_DONE)
+			return 1;
+
+	smp_mb(); /* Ensure that the above checks precede any following flip. */
+	return 0;
+}
+
+/*
+ * Attempt a single flip of the counters.  Remember, a single flip does
+ * -not- constitute a grace period.  Instead, the interval between
+ * at least three consecutive flips is a grace period.
+ *
+ * If anyone is nuts enough to run this CONFIG_PREEMPT_RCU implementation
+ * on a large SMP, they might want to use a hierarchical organization of
+ * the per-CPU-counter pairs.
+ */
+static void rcu_try_flip(void)
+{
+	long flipctr;
+	unsigned long oldirq;
+
+	if (unlikely(!spin_trylock_irqsave(&rcu_ctrlblk.fliplock, oldirq))) 
+		return;
+
+	/*
+	 * Take the next transition(s) through the RCU grace-period
+	 * flip-counter state machine.
+	 */
+	flipctr = rcu_ctrlblk.completed;
+	switch (rcu_try_flip_state) {
+	case RCU_TRY_FLIP_IDLE:
+		if (rcu_try_flip_idle(flipctr))
+			break;
+		rcu_try_flip_state = RCU_TRY_FLIP_GP;
+	case RCU_TRY_FLIP_GP:
+		if (rcu_try_flip_in_gp(flipctr))
+			break;
+		rcu_try_flip_state = RCU_TRY_FLIP_WAITACK;
+	case RCU_TRY_FLIP_WAITACK:
+		if (rcu_try_flip_waitack(flipctr))
+			break;
+		rcu_try_flip_state = RCU_TRY_FLIP_WAITZERO;
+	case RCU_TRY_FLIP_WAITZERO:
+		if (rcu_try_flip_waitzero(flipctr))
+			break;
+		rcu_try_flip_state = RCU_TRY_FLIP_WAITMB;
+	case RCU_TRY_FLIP_WAITMB:
+		if (rcu_try_flip_waitmb(flipctr))
+			break;
+		rcu_try_flip_state = RCU_TRY_FLIP_IDLE;
+	}
+	spin_unlock_irqrestore(&rcu_ctrlblk.fliplock, oldirq);
+}
+
+/*
+ * Check to see if this CPU needs to report that it has seen the most
+ * recent counter flip, thereby declaring that all subsequent
+ * rcu_read_lock() invocations will respect this flip.
+ */
+static void rcu_check_flipseen(int cpu)
+{
+	if (per_cpu(rcu_flip_flag, cpu) == RCU_FLIPPED) {
+		smp_mb();  /* Subsequent counter acccesses must see new value */
+		per_cpu(rcu_flip_flag, cpu) = RCU_FLIP_SEEN;
+		smp_mb();  /* probably be implied by interrupt, but... */
+	}
+}
+
+/*
+ * Check to see if this CPU needs to do a memory barrier in order to
+ * ensure that any prior RCU read-side critical sections have committed
+ * their counter manipulations and critical-section memory references
+ * before declaring the grace period to be completed.
+ */
+static void rcu_check_mb(int cpu)
+{
+	if (per_cpu(rcu_mb_flag, cpu) == RCU_MB_NEEDED) {
+		smp_mb();
+		per_cpu(rcu_mb_flag, cpu) = RCU_MB_DONE;
+	}
+}
+
+/*
+ * This function is periodically called from hardware-irq context on
+ * each CPU.
+ */
+void rcu_check_callbacks(int cpu, int user)
+{
+	unsigned long oldirq;
+
+	rcu_check_flipseen(cpu);
+	rcu_check_mb(cpu);
+	if (rcu_ctrlblk.completed == rcu_data.completed) {
+		rcu_try_flip();
+		if (rcu_ctrlblk.completed == rcu_data.completed) {
+			return;
+		}
+	}
+	spin_lock_irqsave(&rcu_data.lock, oldirq);
+	__rcu_advance_callbacks();
+	if (rcu_data.donelist == NULL)
+		spin_unlock_irqrestore(&rcu_data.lock, oldirq);
+	else {
+		spin_unlock_irqrestore(&rcu_data.lock, oldirq);
+		raise_softirq(RCU_SOFTIRQ);
+	}
+}
+
+/*
+ * Check to see if any future RCU-related work will need to be done
+ * by the current CPU, even if none need be done immediately, returning
+ * 1 if so.  This function is part of the RCU implementation; it is -not-
+ * an exported member of the RCU API.
+ */
+int rcu_needs_cpu(int cpu)
+{
+	return rcu_pending(cpu);
+}
+
+/*
+ * Needed by dynticks, to make sure all RCU processing has finished
+ * when we go idle:
+ */
+void rcu_advance_callbacks(int cpu, int user)
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
+	__rcu_advance_callbacks();
+	spin_unlock_irqrestore(&rcu_data.lock, oldirq);
+}
+
+static void rcu_process_callbacks(struct softirq_action *unused)
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
+	spin_unlock_irqrestore(&rcu_data.lock, flags);
+	while (list) {
+		next = list->next;
+		list->func(list);
+		list = next;
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
+	spin_unlock_irqrestore(&rcu_data.lock, flags);
+}
+
+/*
+ * Wait until all currently running preempt_disable() code segments
+ * (including hardware-irq-disable segments) complete.  Note that
+ * in -rt this does -not- necessarily result in all currently executing
+ * interrupt -handlers- having completed.
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
+	spin_lock_init(&rcu_data.lock);
+	rcu_data.completed = 0;
+	rcu_data.nextlist = NULL;
+	rcu_data.nexttail = &rcu_data.nextlist;
+	rcu_data.waitlist = NULL;
+	rcu_data.waittail = &rcu_data.waitlist;
+	rcu_data.donelist = NULL;
+	rcu_data.donetail = &rcu_data.donelist;
+	open_softirq(RCU_SOFTIRQ, rcu_process_callbacks, NULL);
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
+
+EXPORT_SYMBOL_GPL(call_rcu);
+EXPORT_SYMBOL_GPL(rcu_batches_completed);
+EXPORT_SYMBOL_GPL(rcu_batches_completed_bh);
+EXPORT_SYMBOL_GPL(__synchronize_sched);
+EXPORT_SYMBOL_GPL(__rcu_read_lock);
+EXPORT_SYMBOL_GPL(__rcu_read_unlock);
+

_
