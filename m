Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWH1QKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWH1QKN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 12:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWH1QKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 12:10:13 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:40669 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751160AbWH1QKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 12:10:09 -0400
Date: Mon, 28 Aug 2006 21:40:11 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Paul E McKenney <paulmck@us.ibm.com>
Subject: Re: [PATCH 1/4] RCU: split classic rcu
Message-ID: <20060828161011.GC3325@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060828160845.GB3325@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060828160845.GB3325@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch re-organizes the RCU code to enable multiple implementations
of RCU. Users of RCU continues to include rcupdate.h and the
RCU interfaces remain the same. This is in preparation for
subsequently merging the preepmtpible RCU implementation.

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
---




 include/linux/rcuclassic.h |  149 +++++++++++
 include/linux/rcupdate.h   |  153 +++---------
 kernel/Makefile            |    2 
 kernel/rcuclassic.c        |  558 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/rcupdate.c          |  559 ++-------------------------------------------
 5 files changed, 781 insertions(+), 640 deletions(-)

diff -puN /dev/null include/linux/rcuclassic.h
--- /dev/null	2006-08-26 20:47:46.475534750 +0530
+++ linux-2.6.18-rc3-rcu-dipankar/include/linux/rcuclassic.h	2006-08-27 00:52:40.000000000 +0530
@@ -0,0 +1,149 @@
+/*
+ * Read-Copy Update mechanism for mutual exclusion (classic version)
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
+ * Author: Dipankar Sarma <dipankar@in.ibm.com>
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
+#ifndef __LINUX_RCUCLASSIC_H
+#define __LINUX_RCUCLASSIC_H
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
+
+/* Global control variables for rcupdate callback mechanism. */
+struct rcu_ctrlblk {
+	long	cur;		/* Current batch number.                      */
+	long	completed;	/* Number of the last completed batch         */
+	int	next_pending;	/* Is the next batch already waiting?         */
+
+	spinlock_t	lock	____cacheline_internodealigned_in_smp;
+	cpumask_t	cpumask; /* CPUs that need to switch in order    */
+	                         /* for current batch to proceed.        */
+} ____cacheline_internodealigned_in_smp;
+
+/* Is batch a before batch b ? */
+static inline int rcu_batch_before(long a, long b)
+{
+        return (a - b) < 0;
+}
+
+/* Is batch a after batch b ? */
+static inline int rcu_batch_after(long a, long b)
+{
+        return (a - b) > 0;
+}
+
+/*
+ * Per-CPU data for Read-Copy UPdate.
+ * nxtlist - new callbacks are added here
+ * curlist - current batch for which quiescent cycle started if any
+ */
+struct rcu_data {
+	/* 1) quiescent state handling : */
+	long		quiescbatch;     /* Batch # for grace period */
+	int		passed_quiesc;	 /* User-mode/idle loop etc. */
+	int		qs_pending;	 /* core waits for quiesc state */
+
+	/* 2) batch handling */
+	long  	       	batch;           /* Batch # for current RCU batch */
+	struct rcu_head *nxtlist;
+	struct rcu_head **nxttail;
+	long            qlen; 	 	 /* # of queued callbacks */
+	struct rcu_head *curlist;
+	struct rcu_head **curtail;
+	struct rcu_head *donelist;
+	struct rcu_head **donetail;
+	long		blimit;		 /* Upper limit on a processed batch */
+	int cpu;
+#ifdef CONFIG_SMP
+	long		last_rs_qlen;	 /* qlen during the last resched */
+#endif
+};
+
+DECLARE_PER_CPU(struct rcu_data, rcu_data);
+DECLARE_PER_CPU(struct rcu_data, rcu_bh_data);
+
+/*
+ * Increment the quiescent state counter.
+ * The counter is a bit degenerated: We do not need to know
+ * how many quiescent states passed, just if there was at least
+ * one since the start of the grace period. Thus just a flag.
+ */
+static inline void rcu_qsctr_inc(int cpu)
+{
+	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
+	rdp->passed_quiesc = 1;
+}
+static inline void rcu_bh_qsctr_inc(int cpu)
+{
+	struct rcu_data *rdp = &per_cpu(rcu_bh_data, cpu);
+	rdp->passed_quiesc = 1;
+}
+
+extern int rcu_pending(int cpu);
+extern int rcu_needs_cpu(int cpu);
+
+#define __rcu_read_lock() \
+	do { \
+		preempt_disable(); \
+		__acquire(RCU); \
+	} while(0)
+#define __rcu_read_unlock() \
+	do { \
+		__release(RCU); \
+		preempt_enable(); \
+	} while(0)
+
+#define __rcu_read_lock_bh() \
+	do { \
+		local_bh_disable(); \
+		__acquire(RCU_BH); \
+	} while(0)
+#define __rcu_read_unlock_bh() \
+	do { \
+		__release(RCU_BH); \
+		local_bh_enable(); \
+	} while(0)
+
+#define __synchronize_sched()	synchronize_rcu()
+
+extern void __rcu_init(void);
+extern void rcu_check_callbacks(int cpu, int user);
+extern void rcu_restart_cpu(int cpu);
+extern long rcu_batches_completed(void);
+
+#endif /* __KERNEL__ */
+#endif /* __LINUX_RCUCLASSIC_H */
diff -puN include/linux/rcupdate.h~rcu-split-classic include/linux/rcupdate.h
--- linux-2.6.18-rc3-rcu/include/linux/rcupdate.h~rcu-split-classic	2006-08-06 03:07:10.000000000 +0530
+++ linux-2.6.18-rc3-rcu-dipankar/include/linux/rcupdate.h	2006-08-27 00:48:50.000000000 +0530
@@ -41,6 +41,7 @@
 #include <linux/percpu.h>
 #include <linux/cpumask.h>
 #include <linux/seqlock.h>
+#include <linux/rcuclassic.h>
 
 /**
  * struct rcu_head - callback structure for use with RCU
@@ -59,81 +60,6 @@ struct rcu_head {
 } while (0)
 
 
-
-/* Global control variables for rcupdate callback mechanism. */
-struct rcu_ctrlblk {
-	long	cur;		/* Current batch number.                      */
-	long	completed;	/* Number of the last completed batch         */
-	int	next_pending;	/* Is the next batch already waiting?         */
-
-	spinlock_t	lock	____cacheline_internodealigned_in_smp;
-	cpumask_t	cpumask; /* CPUs that need to switch in order    */
-	                         /* for current batch to proceed.        */
-} ____cacheline_internodealigned_in_smp;
-
-/* Is batch a before batch b ? */
-static inline int rcu_batch_before(long a, long b)
-{
-        return (a - b) < 0;
-}
-
-/* Is batch a after batch b ? */
-static inline int rcu_batch_after(long a, long b)
-{
-        return (a - b) > 0;
-}
-
-/*
- * Per-CPU data for Read-Copy UPdate.
- * nxtlist - new callbacks are added here
- * curlist - current batch for which quiescent cycle started if any
- */
-struct rcu_data {
-	/* 1) quiescent state handling : */
-	long		quiescbatch;     /* Batch # for grace period */
-	int		passed_quiesc;	 /* User-mode/idle loop etc. */
-	int		qs_pending;	 /* core waits for quiesc state */
-
-	/* 2) batch handling */
-	long  	       	batch;           /* Batch # for current RCU batch */
-	struct rcu_head *nxtlist;
-	struct rcu_head **nxttail;
-	long            qlen; 	 	 /* # of queued callbacks */
-	struct rcu_head *curlist;
-	struct rcu_head **curtail;
-	struct rcu_head *donelist;
-	struct rcu_head **donetail;
-	long		blimit;		 /* Upper limit on a processed batch */
-	int cpu;
-	struct rcu_head barrier;
-#ifdef CONFIG_SMP
-	long		last_rs_qlen;	 /* qlen during the last resched */
-#endif
-};
-
-DECLARE_PER_CPU(struct rcu_data, rcu_data);
-DECLARE_PER_CPU(struct rcu_data, rcu_bh_data);
-
-/*
- * Increment the quiescent state counter.
- * The counter is a bit degenerated: We do not need to know
- * how many quiescent states passed, just if there was at least
- * one since the start of the grace period. Thus just a flag.
- */
-static inline void rcu_qsctr_inc(int cpu)
-{
-	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
-	rdp->passed_quiesc = 1;
-}
-static inline void rcu_bh_qsctr_inc(int cpu)
-{
-	struct rcu_data *rdp = &per_cpu(rcu_bh_data, cpu);
-	rdp->passed_quiesc = 1;
-}
-
-extern int rcu_pending(int cpu);
-extern int rcu_needs_cpu(int cpu);
-
 /**
  * rcu_read_lock - mark the beginning of an RCU read-side critical section.
  *
@@ -163,22 +89,14 @@ extern int rcu_needs_cpu(int cpu);
  *
  * It is illegal to block while in an RCU read-side critical section.
  */
-#define rcu_read_lock() \
-	do { \
-		preempt_disable(); \
-		__acquire(RCU); \
-	} while(0)
+#define rcu_read_lock() __rcu_read_lock()
 
 /**
  * rcu_read_unlock - marks the end of an RCU read-side critical section.
  *
  * See rcu_read_lock() for more information.
  */
-#define rcu_read_unlock() \
-	do { \
-		__release(RCU); \
-		preempt_enable(); \
-	} while(0)
+#define rcu_read_unlock() __rcu_read_unlock()
 
 /*
  * So where is rcu_write_lock()?  It does not exist, as there is no
@@ -201,23 +119,15 @@ extern int rcu_needs_cpu(int cpu);
  * can use just rcu_read_lock().
  *
  */
-#define rcu_read_lock_bh() \
-	do { \
-		local_bh_disable(); \
-		__acquire(RCU_BH); \
-	} while(0)
-
-/*
+#define rcu_read_lock_bh()	__rcu_read_lock_bh()
+  
+/**
  * rcu_read_unlock_bh - marks the end of a softirq-only RCU critical section
  *
  * See rcu_read_lock_bh() for more information.
  */
-#define rcu_read_unlock_bh() \
-	do { \
-		__release(RCU_BH); \
-		local_bh_enable(); \
-	} while(0)
-
+#define rcu_read_unlock_bh()	__rcu_read_unlock_bh()
+  
 /**
  * rcu_dereference - fetch an RCU-protected pointer in an
  * RCU read-side critical section.  This pointer may later
@@ -268,22 +178,49 @@ extern int rcu_needs_cpu(int cpu);
  * In "classic RCU", these two guarantees happen to be one and
  * the same, but can differ in realtime RCU implementations.
  */
-#define synchronize_sched() synchronize_rcu()
+#define synchronize_sched()	__synchronize_sched()
+  
+/**
+ * call_rcu - Queue an RCU callback for invocation after a grace period.
+ * @head: structure to be used for queueing the RCU updates.
+ * @func: actual update function to be invoked after the grace period
+ *
+ * The update function will be invoked some time after a full grace
+ * period elapses, in other words after all currently executing RCU
+ * read-side critical sections have completed.  RCU read-side critical
+ * sections are delimited by rcu_read_lock() and rcu_read_unlock(),
+ * and may be nested.
+ */
+extern void FASTCALL(call_rcu(struct rcu_head *head, 
+  				void (*func)(struct rcu_head *head)));
 
-extern void rcu_init(void);
-extern void rcu_check_callbacks(int cpu, int user);
-extern void rcu_restart_cpu(int cpu);
-extern long rcu_batches_completed(void);
-extern long rcu_batches_completed_bh(void);
 
-/* Exported interfaces */
-extern void FASTCALL(call_rcu(struct rcu_head *head, 
-				void (*func)(struct rcu_head *head)));
+/**
+ * call_rcu_bh - Queue an RCU for invocation after a quicker grace period.
+ * @head: structure to be used for queueing the RCU updates.
+ * @func: actual update function to be invoked after the grace period
+ *
+ * The update function will be invoked some time after a full grace
+ * period elapses, in other words after all currently executing RCU
+ * read-side critical sections have completed. call_rcu_bh() assumes
+ * that the read-side critical sections end on completion of a softirq
+ * handler. This means that read-side critical sections in process
+ * context must not be interrupted by softirqs. This interface is to be
+ * used when most of the read-side critical sections are in softirq context.
+ * RCU read-side critical sections are delimited by rcu_read_lock() and
+ * rcu_read_unlock(), * if in interrupt context or rcu_read_lock_bh()
+ * and rcu_read_unlock_bh(), if in process context. These may be nested.
+ */
 extern void FASTCALL(call_rcu_bh(struct rcu_head *head,
 				void (*func)(struct rcu_head *head)));
+
+/* Exported common interfaces */
 extern void synchronize_rcu(void);
-void synchronize_idle(void);
 extern void rcu_barrier(void);
+  
+/* Internal to kernel */
+extern void rcu_init(void);
+extern void rcu_check_callbacks(int cpu, int user);
 
 #endif /* __KERNEL__ */
 #endif /* __LINUX_RCUPDATE_H */
diff -puN kernel/Makefile~rcu-split-classic kernel/Makefile
--- linux-2.6.18-rc3-rcu/kernel/Makefile~rcu-split-classic	2006-08-06 03:07:10.000000000 +0530
+++ linux-2.6.18-rc3-rcu-dipankar/kernel/Makefile	2006-08-27 00:48:50.000000000 +0530
@@ -6,7 +6,7 @@ obj-y     = sched.o fork.o exec_domain.o
 	    exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
-	    rcupdate.o extable.o params.o posix-timers.o \
+	    rcupdate.o rcuclassic.o extable.o params.o posix-timers.o \
 	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o mutex.o \
 	    hrtimer.o rwsem.o
 
diff -puN /dev/null kernel/rcuclassic.c
--- /dev/null	2006-08-26 20:47:46.475534750 +0530
+++ linux-2.6.18-rc3-rcu-dipankar/kernel/rcuclassic.c	2006-08-27 00:49:58.000000000 +0530
@@ -0,0 +1,558 @@
+/*
+ * Read-Copy Update mechanism for mutual exclusion, classic implementation
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
+ * Authors: Dipankar Sarma <dipankar@in.ibm.com>
+ *	    Manfred Spraul <manfred@colorfullife.com>
+ * 
+ * Based on the original work by Paul McKenney <paulmck@us.ibm.com>
+ * and inputs from Rusty Russell, Andrea Arcangeli and Andi Kleen.
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
+
+
+/* Definition for rcupdate control block. */
+static struct rcu_ctrlblk rcu_ctrlblk = {
+	.cur = -300,
+	.completed = -300,
+	.lock = SPIN_LOCK_UNLOCKED,
+	.cpumask = CPU_MASK_NONE,
+};
+static struct rcu_ctrlblk rcu_bh_ctrlblk = {
+	.cur = -300,
+	.completed = -300,
+	.lock = SPIN_LOCK_UNLOCKED,
+	.cpumask = CPU_MASK_NONE,
+};
+
+DEFINE_PER_CPU(struct rcu_data, rcu_data) = { 0L };
+DEFINE_PER_CPU(struct rcu_data, rcu_bh_data) = { 0L };
+
+/* Fake initialization required by compiler */
+static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
+static int blimit = 10;
+static int qhimark = 10000;
+static int qlowmark = 100;
+#ifdef CONFIG_SMP
+static int rsinterval = 1000;
+#endif
+
+#ifdef CONFIG_SMP
+static void force_quiescent_state(struct rcu_data *rdp,
+			struct rcu_ctrlblk *rcp)
+{
+	int cpu;
+	cpumask_t cpumask;
+	set_need_resched();
+	if (unlikely(rdp->qlen - rdp->last_rs_qlen > rsinterval)) {
+		rdp->last_rs_qlen = rdp->qlen;
+		/*
+		 * Don't send IPI to itself. With irqs disabled,
+		 * rdp->cpu is the current cpu.
+		 */
+		cpumask = rcp->cpumask;
+		cpu_clear(rdp->cpu, cpumask);
+		for_each_cpu_mask(cpu, cpumask)
+			smp_send_reschedule(cpu);
+	}
+}
+#else
+static inline void force_quiescent_state(struct rcu_data *rdp,
+			struct rcu_ctrlblk *rcp)
+{
+	set_need_resched();
+}
+#endif
+
+/*
+ * call_rcu - Queue an RCU callback for invocation after a grace period.
+ * @head: structure to be used for queueing the RCU updates.
+ * @func: actual update function to be invoked after the grace period
+ *
+ * The update function will be invoked some time after a full grace
+ * period elapses, in other words after all currently executing RCU
+ * read-side critical sections have completed.  RCU read-side critical
+ * sections are delimited by rcu_read_lock() and rcu_read_unlock(),
+ * and may be nested.
+ */
+void fastcall call_rcu(struct rcu_head *head,
+				void (*func)(struct rcu_head *rcu))
+{
+	unsigned long flags;
+	struct rcu_data *rdp;
+
+	head->func = func;
+	head->next = NULL;
+	local_irq_save(flags);
+	rdp = &__get_cpu_var(rcu_data);
+	*rdp->nxttail = head;
+	rdp->nxttail = &head->next;
+	if (unlikely(++rdp->qlen > qhimark)) {
+		rdp->blimit = INT_MAX;
+		force_quiescent_state(rdp, &rcu_ctrlblk);
+	}
+	local_irq_restore(flags);
+}
+
+/*
+ * call_rcu_bh - Queue an RCU for invocation after a quicker grace period.
+ * @head: structure to be used for queueing the RCU updates.
+ * @func: actual update function to be invoked after the grace period
+ *
+ * The update function will be invoked some time after a full grace
+ * period elapses, in other words after all currently executing RCU
+ * read-side critical sections have completed. call_rcu_bh() assumes
+ * that the read-side critical sections end on completion of a softirq
+ * handler. This means that read-side critical sections in process
+ * context must not be interrupted by softirqs. This interface is to be
+ * used when most of the read-side critical sections are in softirq context.
+ * RCU read-side critical sections are delimited by rcu_read_lock() and
+ * rcu_read_unlock(), * if in interrupt context or rcu_read_lock_bh()
+ * and rcu_read_unlock_bh(), if in process context. These may be nested.
+ */
+void fastcall call_rcu_bh(struct rcu_head *head,
+				void (*func)(struct rcu_head *rcu))
+{
+	unsigned long flags;
+	struct rcu_data *rdp;
+
+	head->func = func;
+	head->next = NULL;
+	local_irq_save(flags);
+	rdp = &__get_cpu_var(rcu_bh_data);
+	*rdp->nxttail = head;
+	rdp->nxttail = &head->next;
+
+	if (unlikely(++rdp->qlen > qhimark)) {
+		rdp->blimit = INT_MAX;
+		force_quiescent_state(rdp, &rcu_bh_ctrlblk);
+	}
+
+	local_irq_restore(flags);
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
+ * Return the number of RCU batches processed thus far.  Useful
+ * for debug and statistics.
+ */
+long rcu_batches_completed_bh(void)
+{
+	return rcu_bh_ctrlblk.completed;
+}
+
+/*
+ * Invoke the completed RCU callbacks. They are expected to be in
+ * a per-cpu list.
+ */
+static void rcu_do_batch(struct rcu_data *rdp)
+{
+	struct rcu_head *next, *list;
+	int count = 0;
+
+	list = rdp->donelist;
+	while (list) {
+		next = rdp->donelist = list->next;
+		list->func(list);
+		list = next;
+		rdp->qlen--;
+		if (++count >= rdp->blimit)
+			break;
+	}
+	if (rdp->blimit == INT_MAX && rdp->qlen <= qlowmark)
+		rdp->blimit = blimit;
+	if (!rdp->donelist)
+		rdp->donetail = &rdp->donelist;
+	else
+		tasklet_schedule(&per_cpu(rcu_tasklet, rdp->cpu));
+}
+
+/*
+ * Grace period handling:
+ * The grace period handling consists out of two steps:
+ * - A new grace period is started.
+ *   This is done by rcu_start_batch. The start is not broadcasted to
+ *   all cpus, they must pick this up by comparing rcp->cur with
+ *   rdp->quiescbatch. All cpus are recorded  in the
+ *   rcu_ctrlblk.cpumask bitmap.
+ * - All cpus must go through a quiescent state.
+ *   Since the start of the grace period is not broadcasted, at least two
+ *   calls to rcu_check_quiescent_state are required:
+ *   The first call just notices that a new grace period is running. The
+ *   following calls check if there was a quiescent state since the beginning
+ *   of the grace period. If so, it updates rcu_ctrlblk.cpumask. If
+ *   the bitmap is empty, then the grace period is completed.
+ *   rcu_check_quiescent_state calls rcu_start_batch(0) to start the next grace
+ *   period (if necessary).
+ */
+/*
+ * Register a new batch of callbacks, and start it up if there is currently no
+ * active batch and the batch to be registered has not already occurred.
+ * Caller must hold rcu_ctrlblk.lock.
+ */
+static void rcu_start_batch(struct rcu_ctrlblk *rcp)
+{
+	if (rcp->next_pending &&
+			rcp->completed == rcp->cur) {
+		rcp->next_pending = 0;
+		/*
+		 * next_pending == 0 must be visible in
+		 * __rcu_process_callbacks() before it can see new value of cur.
+		 */
+		smp_wmb();
+		rcp->cur++;
+
+		/*
+		 * Accessing nohz_cpu_mask before incrementing rcp->cur needs a
+		 * Barrier  Otherwise it can cause tickless idle CPUs to be
+		 * included in rcp->cpumask, which will extend graceperiods
+		 * unnecessarily.
+		 */
+		smp_mb();
+		cpus_andnot(rcp->cpumask, cpu_online_map, nohz_cpu_mask);
+
+	}
+}
+
+/*
+ * cpu went through a quiescent state since the beginning of the grace period.
+ * Clear it from the cpu mask and complete the grace period if it was the last
+ * cpu. Start another grace period if someone has further entries pending
+ */
+static void cpu_quiet(int cpu, struct rcu_ctrlblk *rcp)
+{
+	cpu_clear(cpu, rcp->cpumask);
+	if (cpus_empty(rcp->cpumask)) {
+		/* batch completed ! */
+		rcp->completed = rcp->cur;
+		rcu_start_batch(rcp);
+	}
+}
+
+/*
+ * Check if the cpu has gone through a quiescent state (say context
+ * switch). If so and if it already hasn't done so in this RCU
+ * quiescent cycle, then indicate that it has done so.
+ */
+static void rcu_check_quiescent_state(struct rcu_ctrlblk *rcp,
+					struct rcu_data *rdp)
+{
+	if (rdp->quiescbatch != rcp->cur) {
+		/* start new grace period: */
+		rdp->qs_pending = 1;
+		rdp->passed_quiesc = 0;
+		rdp->quiescbatch = rcp->cur;
+		return;
+	}
+
+	/* Grace period already completed for this cpu?
+	 * qs_pending is checked instead of the actual bitmap to avoid
+	 * cacheline trashing.
+	 */
+	if (!rdp->qs_pending)
+		return;
+
+	/* 
+	 * Was there a quiescent state since the beginning of the grace
+	 * period? If no, then exit and wait for the next call.
+	 */
+	if (!rdp->passed_quiesc)
+		return;
+	rdp->qs_pending = 0;
+
+	spin_lock(&rcp->lock);
+	/*
+	 * rdp->quiescbatch/rcp->cur and the cpu bitmap can come out of sync
+	 * during cpu startup. Ignore the quiescent state.
+	 */
+	if (likely(rdp->quiescbatch == rcp->cur))
+		cpu_quiet(rdp->cpu, rcp);
+
+	spin_unlock(&rcp->lock);
+}
+
+
+#ifdef CONFIG_HOTPLUG_CPU
+
+/* warning! helper for rcu_offline_cpu. do not use elsewhere without reviewing
+ * locking requirements, the list it's pulling from has to belong to a cpu
+ * which is dead and hence not processing interrupts.
+ */
+static void rcu_move_batch(struct rcu_data *this_rdp, struct rcu_head *list,
+				struct rcu_head **tail)
+{
+	local_irq_disable();
+	*this_rdp->nxttail = list;
+	if (list)
+		this_rdp->nxttail = tail;
+	local_irq_enable();
+}
+
+static void __rcu_offline_cpu(struct rcu_data *this_rdp,
+				struct rcu_ctrlblk *rcp, struct rcu_data *rdp)
+{
+	/* if the cpu going offline owns the grace period
+	 * we can block indefinitely waiting for it, so flush
+	 * it here
+	 */
+	spin_lock_bh(&rcp->lock);
+	if (rcp->cur != rcp->completed)
+		cpu_quiet(rdp->cpu, rcp);
+	spin_unlock_bh(&rcp->lock);
+	rcu_move_batch(this_rdp, rdp->curlist, rdp->curtail);
+	rcu_move_batch(this_rdp, rdp->nxtlist, rdp->nxttail);
+	rcu_move_batch(this_rdp, rdp->donelist, rdp->donetail);
+}
+
+static void rcu_offline_cpu(int cpu)
+{
+	struct rcu_data *this_rdp = &get_cpu_var(rcu_data);
+	struct rcu_data *this_bh_rdp = &get_cpu_var(rcu_bh_data);
+
+	__rcu_offline_cpu(this_rdp, &rcu_ctrlblk,
+					&per_cpu(rcu_data, cpu));
+	__rcu_offline_cpu(this_bh_rdp, &rcu_bh_ctrlblk,
+					&per_cpu(rcu_bh_data, cpu));
+	put_cpu_var(rcu_data);
+	put_cpu_var(rcu_bh_data);
+	tasklet_kill_immediate(&per_cpu(rcu_tasklet, cpu), cpu);
+}
+
+#else
+
+static void rcu_offline_cpu(int cpu)
+{
+}
+
+#endif
+
+/*
+ * This does the RCU processing work from tasklet context. 
+ */
+static void __rcu_process_callbacks(struct rcu_ctrlblk *rcp,
+					struct rcu_data *rdp)
+{
+	if (rdp->curlist && !rcu_batch_before(rcp->completed, rdp->batch)) {
+		*rdp->donetail = rdp->curlist;
+		rdp->donetail = rdp->curtail;
+		rdp->curlist = NULL;
+		rdp->curtail = &rdp->curlist;
+	}
+
+	if (rdp->nxtlist && !rdp->curlist) {
+		local_irq_disable();
+		rdp->curlist = rdp->nxtlist;
+		rdp->curtail = rdp->nxttail;
+		rdp->nxtlist = NULL;
+		rdp->nxttail = &rdp->nxtlist;
+		local_irq_enable();
+
+		/*
+		 * start the next batch of callbacks
+		 */
+
+		/* determine batch number */
+		rdp->batch = rcp->cur + 1;
+		/* see the comment and corresponding wmb() in
+		 * the rcu_start_batch()
+		 */
+		smp_rmb();
+
+		if (!rcp->next_pending) {
+			/* and start it/schedule start if it's a new batch */
+			spin_lock(&rcp->lock);
+			rcp->next_pending = 1;
+			rcu_start_batch(rcp);
+			spin_unlock(&rcp->lock);
+		}
+	}
+
+	rcu_check_quiescent_state(rcp, rdp);
+	if (rdp->donelist)
+		rcu_do_batch(rdp);
+}
+
+static void rcu_process_callbacks(unsigned long unused)
+{
+	__rcu_process_callbacks(&rcu_ctrlblk, &__get_cpu_var(rcu_data));
+	__rcu_process_callbacks(&rcu_bh_ctrlblk, &__get_cpu_var(rcu_bh_data));
+}
+
+static int __rcu_pending(struct rcu_ctrlblk *rcp, struct rcu_data *rdp)
+{
+	/* This cpu has pending rcu entries and the grace period
+	 * for them has completed.
+	 */
+	if (rdp->curlist && !rcu_batch_before(rcp->completed, rdp->batch))
+		return 1;
+
+	/* This cpu has no pending entries, but there are new entries */
+	if (!rdp->curlist && rdp->nxtlist)
+		return 1;
+
+	/* This cpu has finished callbacks to invoke */
+	if (rdp->donelist)
+		return 1;
+
+	/* The rcu core waits for a quiescent state from the cpu */
+	if (rdp->quiescbatch != rcp->cur || rdp->qs_pending)
+		return 1;
+
+	/* nothing to do */
+	return 0;
+}
+
+/*
+ * Check to see if there is any immediate RCU-related work to be done
+ * by the current CPU, returning 1 if so.  This function is part of the
+ * RCU implementation; it is -not- an exported member of the RCU API.
+ */
+int rcu_pending(int cpu)
+{
+	return __rcu_pending(&rcu_ctrlblk, &per_cpu(rcu_data, cpu)) ||
+		__rcu_pending(&rcu_bh_ctrlblk, &per_cpu(rcu_bh_data, cpu));
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
+	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
+	struct rcu_data *rdp_bh = &per_cpu(rcu_bh_data, cpu);
+
+	return (!!rdp->curlist || !!rdp_bh->curlist || rcu_pending(cpu));
+}
+
+void rcu_check_callbacks(int cpu, int user)
+{
+	if (user || 
+	    (idle_cpu(cpu) && !in_softirq() && 
+				hardirq_count() <= (1 << HARDIRQ_SHIFT))) {
+		rcu_qsctr_inc(cpu);
+		rcu_bh_qsctr_inc(cpu);
+	} else if (!in_softirq())
+		rcu_bh_qsctr_inc(cpu);
+	tasklet_schedule(&per_cpu(rcu_tasklet, cpu));
+}
+
+static void rcu_init_percpu_data(int cpu, struct rcu_ctrlblk *rcp,
+						struct rcu_data *rdp)
+{
+	memset(rdp, 0, sizeof(*rdp));
+	rdp->curtail = &rdp->curlist;
+	rdp->nxttail = &rdp->nxtlist;
+	rdp->donetail = &rdp->donelist;
+	rdp->quiescbatch = rcp->completed;
+	rdp->qs_pending = 0;
+	rdp->cpu = cpu;
+	rdp->blimit = blimit;
+}
+
+static void __devinit rcu_online_cpu(int cpu)
+{
+	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
+	struct rcu_data *bh_rdp = &per_cpu(rcu_bh_data, cpu);
+
+	rcu_init_percpu_data(cpu, &rcu_ctrlblk, rdp);
+	rcu_init_percpu_data(cpu, &rcu_bh_ctrlblk, bh_rdp);
+	tasklet_init(&per_cpu(rcu_tasklet, cpu), rcu_process_callbacks, 0UL);
+}
+
+static int __devinit rcu_cpu_notify(struct notifier_block *self,
+				unsigned long action, void *hcpu)
+{
+	long cpu = (long)hcpu;
+	switch (action) {
+	case CPU_UP_PREPARE:
+		rcu_online_cpu(cpu);
+		break;
+	case CPU_DEAD:
+		rcu_offline_cpu(cpu);
+		break;
+	default:
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block __devinitdata rcu_nb = {
+	.notifier_call	= rcu_cpu_notify,
+};
+
+/*
+ * Initializes rcu mechanism.  Assumed to be called early.
+ * That is before local timer(SMP) or jiffie timer (uniproc) is setup.
+ * Note that rcu_qsctr and friends are implicitly
+ * initialized due to the choice of ``0'' for RCU_CTR_INVALID.
+ */
+void __init __rcu_init(void)
+{
+	rcu_cpu_notify(&rcu_nb, CPU_UP_PREPARE,
+			(void *)(long)smp_processor_id());
+	/* Register notifier for non-boot CPUs */
+	register_cpu_notifier(&rcu_nb);
+}
+
+module_param(blimit, int, 0);
+module_param(qhimark, int, 0);
+module_param(qlowmark, int, 0);
+#ifdef CONFIG_SMP
+module_param(rsinterval, int, 0);
+#endif
+
+EXPORT_SYMBOL_GPL(rcu_batches_completed);
+EXPORT_SYMBOL_GPL(rcu_batches_completed_bh);
+EXPORT_SYMBOL_GPL(call_rcu);
+EXPORT_SYMBOL_GPL(call_rcu_bh);
diff -puN kernel/rcupdate.c~rcu-split-classic kernel/rcupdate.c
--- linux-2.6.18-rc3-rcu/kernel/rcupdate.c~rcu-split-classic	2006-08-06 03:07:10.000000000 +0530
+++ linux-2.6.18-rc3-rcu-dipankar/kernel/rcupdate.c	2006-08-06 09:58:28.000000000 +0530
@@ -40,155 +40,53 @@
 #include <linux/sched.h>
 #include <asm/atomic.h>
 #include <linux/bitops.h>
-#include <linux/module.h>
 #include <linux/completion.h>
-#include <linux/moduleparam.h>
 #include <linux/percpu.h>
-#include <linux/notifier.h>
-#include <linux/rcupdate.h>
 #include <linux/cpu.h>
 #include <linux/mutex.h>
+#include <linux/module.h>
 
-/* Definition for rcupdate control block. */
-static struct rcu_ctrlblk rcu_ctrlblk = {
-	.cur = -300,
-	.completed = -300,
-	.lock = __SPIN_LOCK_UNLOCKED(&rcu_ctrlblk.lock),
-	.cpumask = CPU_MASK_NONE,
-};
-static struct rcu_ctrlblk rcu_bh_ctrlblk = {
-	.cur = -300,
-	.completed = -300,
-	.lock = __SPIN_LOCK_UNLOCKED(&rcu_bh_ctrlblk.lock),
-	.cpumask = CPU_MASK_NONE,
+struct rcu_synchronize {
+	struct rcu_head head;
+	struct completion completion;
 };
 
-DEFINE_PER_CPU(struct rcu_data, rcu_data) = { 0L };
-DEFINE_PER_CPU(struct rcu_data, rcu_bh_data) = { 0L };
-
-/* Fake initialization required by compiler */
-static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
-static int blimit = 10;
-static int qhimark = 10000;
-static int qlowmark = 100;
-#ifdef CONFIG_SMP
-static int rsinterval = 1000;
-#endif
-
+static DEFINE_PER_CPU(struct rcu_head, rcu_barrier_head);
 static atomic_t rcu_barrier_cpu_count;
 static DEFINE_MUTEX(rcu_barrier_mutex);
 static struct completion rcu_barrier_completion;
 
-#ifdef CONFIG_SMP
-static void force_quiescent_state(struct rcu_data *rdp,
-			struct rcu_ctrlblk *rcp)
-{
-	int cpu;
-	cpumask_t cpumask;
-	set_need_resched();
-	if (unlikely(rdp->qlen - rdp->last_rs_qlen > rsinterval)) {
-		rdp->last_rs_qlen = rdp->qlen;
-		/*
-		 * Don't send IPI to itself. With irqs disabled,
-		 * rdp->cpu is the current cpu.
-		 */
-		cpumask = rcp->cpumask;
-		cpu_clear(rdp->cpu, cpumask);
-		for_each_cpu_mask(cpu, cpumask)
-			smp_send_reschedule(cpu);
-	}
-}
-#else
-static inline void force_quiescent_state(struct rcu_data *rdp,
-			struct rcu_ctrlblk *rcp)
+/* Because of FASTCALL declaration of complete, we use this wrapper */
+static void wakeme_after_rcu(struct rcu_head  *head)
 {
-	set_need_resched();
+	struct rcu_synchronize *rcu;
+
+	rcu = container_of(head, struct rcu_synchronize, head);
+	complete(&rcu->completion);
 }
-#endif
 
 /**
- * call_rcu - Queue an RCU callback for invocation after a grace period.
- * @head: structure to be used for queueing the RCU updates.
- * @func: actual update function to be invoked after the grace period
+ * synchronize_rcu - wait until a grace period has elapsed.
  *
- * The update function will be invoked some time after a full grace
- * period elapses, in other words after all currently executing RCU
+ * Control will return to the caller some time after a full grace
+ * period has elapsed, in other words after all currently executing RCU
  * read-side critical sections have completed.  RCU read-side critical
  * sections are delimited by rcu_read_lock() and rcu_read_unlock(),
  * and may be nested.
- */
-void fastcall call_rcu(struct rcu_head *head,
-				void (*func)(struct rcu_head *rcu))
-{
-	unsigned long flags;
-	struct rcu_data *rdp;
-
-	head->func = func;
-	head->next = NULL;
-	local_irq_save(flags);
-	rdp = &__get_cpu_var(rcu_data);
-	*rdp->nxttail = head;
-	rdp->nxttail = &head->next;
-	if (unlikely(++rdp->qlen > qhimark)) {
-		rdp->blimit = INT_MAX;
-		force_quiescent_state(rdp, &rcu_ctrlblk);
-	}
-	local_irq_restore(flags);
-}
-
-/**
- * call_rcu_bh - Queue an RCU for invocation after a quicker grace period.
- * @head: structure to be used for queueing the RCU updates.
- * @func: actual update function to be invoked after the grace period
  *
- * The update function will be invoked some time after a full grace
- * period elapses, in other words after all currently executing RCU
- * read-side critical sections have completed. call_rcu_bh() assumes
- * that the read-side critical sections end on completion of a softirq
- * handler. This means that read-side critical sections in process
- * context must not be interrupted by softirqs. This interface is to be
- * used when most of the read-side critical sections are in softirq context.
- * RCU read-side critical sections are delimited by rcu_read_lock() and
- * rcu_read_unlock(), * if in interrupt context or rcu_read_lock_bh()
- * and rcu_read_unlock_bh(), if in process context. These may be nested.
- */
-void fastcall call_rcu_bh(struct rcu_head *head,
-				void (*func)(struct rcu_head *rcu))
-{
-	unsigned long flags;
-	struct rcu_data *rdp;
-
-	head->func = func;
-	head->next = NULL;
-	local_irq_save(flags);
-	rdp = &__get_cpu_var(rcu_bh_data);
-	*rdp->nxttail = head;
-	rdp->nxttail = &head->next;
-
-	if (unlikely(++rdp->qlen > qhimark)) {
-		rdp->blimit = INT_MAX;
-		force_quiescent_state(rdp, &rcu_bh_ctrlblk);
-	}
-
-	local_irq_restore(flags);
-}
-
-/*
- * Return the number of RCU batches processed thus far.  Useful
- * for debug and statistics.
- */
-long rcu_batches_completed(void)
-{
-	return rcu_ctrlblk.completed;
-}
-
-/*
- * Return the number of RCU batches processed thus far.  Useful
- * for debug and statistics.
+ * If your read-side code is not protected by rcu_read_lock(), do -not-
+ * use synchronize_rcu().
  */
-long rcu_batches_completed_bh(void)
+void synchronize_rcu(void)
 {
-	return rcu_bh_ctrlblk.completed;
+	struct rcu_synchronize rcu;
+ 
+	init_completion(&rcu.completion);
+	/* Will wake me after RCU finished */
+	call_rcu(&rcu.head, wakeme_after_rcu);
+ 
+	/* Wait for it */
+	wait_for_completion(&rcu.completion);
 }
 
 static void rcu_barrier_callback(struct rcu_head *notused)
@@ -203,10 +101,8 @@ static void rcu_barrier_callback(struct 
 static void rcu_barrier_func(void *notused)
 {
 	int cpu = smp_processor_id();
-	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
-	struct rcu_head *head;
+	struct rcu_head *head = &per_cpu(rcu_barrier_head, cpu);
 
-	head = &rdp->barrier;
 	atomic_inc(&rcu_barrier_cpu_count);
 	call_rcu(head, rcu_barrier_callback);
 }
@@ -225,410 +121,11 @@ void rcu_barrier(void)
 	wait_for_completion(&rcu_barrier_completion);
 	mutex_unlock(&rcu_barrier_mutex);
 }
-EXPORT_SYMBOL_GPL(rcu_barrier);
-
-/*
- * Invoke the completed RCU callbacks. They are expected to be in
- * a per-cpu list.
- */
-static void rcu_do_batch(struct rcu_data *rdp)
-{
-	struct rcu_head *next, *list;
-	int count = 0;
-
-	list = rdp->donelist;
-	while (list) {
-		next = rdp->donelist = list->next;
-		list->func(list);
-		list = next;
-		rdp->qlen--;
-		if (++count >= rdp->blimit)
-			break;
-	}
-	if (rdp->blimit == INT_MAX && rdp->qlen <= qlowmark)
-		rdp->blimit = blimit;
-	if (!rdp->donelist)
-		rdp->donetail = &rdp->donelist;
-	else
-		tasklet_schedule(&per_cpu(rcu_tasklet, rdp->cpu));
-}
-
-/*
- * Grace period handling:
- * The grace period handling consists out of two steps:
- * - A new grace period is started.
- *   This is done by rcu_start_batch. The start is not broadcasted to
- *   all cpus, they must pick this up by comparing rcp->cur with
- *   rdp->quiescbatch. All cpus are recorded  in the
- *   rcu_ctrlblk.cpumask bitmap.
- * - All cpus must go through a quiescent state.
- *   Since the start of the grace period is not broadcasted, at least two
- *   calls to rcu_check_quiescent_state are required:
- *   The first call just notices that a new grace period is running. The
- *   following calls check if there was a quiescent state since the beginning
- *   of the grace period. If so, it updates rcu_ctrlblk.cpumask. If
- *   the bitmap is empty, then the grace period is completed.
- *   rcu_check_quiescent_state calls rcu_start_batch(0) to start the next grace
- *   period (if necessary).
- */
-/*
- * Register a new batch of callbacks, and start it up if there is currently no
- * active batch and the batch to be registered has not already occurred.
- * Caller must hold rcu_ctrlblk.lock.
- */
-static void rcu_start_batch(struct rcu_ctrlblk *rcp)
-{
-	if (rcp->next_pending &&
-			rcp->completed == rcp->cur) {
-		rcp->next_pending = 0;
-		/*
-		 * next_pending == 0 must be visible in
-		 * __rcu_process_callbacks() before it can see new value of cur.
-		 */
-		smp_wmb();
-		rcp->cur++;
-
-		/*
-		 * Accessing nohz_cpu_mask before incrementing rcp->cur needs a
-		 * Barrier  Otherwise it can cause tickless idle CPUs to be
-		 * included in rcp->cpumask, which will extend graceperiods
-		 * unnecessarily.
-		 */
-		smp_mb();
-		cpus_andnot(rcp->cpumask, cpu_online_map, nohz_cpu_mask);
-
-	}
-}
-
-/*
- * cpu went through a quiescent state since the beginning of the grace period.
- * Clear it from the cpu mask and complete the grace period if it was the last
- * cpu. Start another grace period if someone has further entries pending
- */
-static void cpu_quiet(int cpu, struct rcu_ctrlblk *rcp)
-{
-	cpu_clear(cpu, rcp->cpumask);
-	if (cpus_empty(rcp->cpumask)) {
-		/* batch completed ! */
-		rcp->completed = rcp->cur;
-		rcu_start_batch(rcp);
-	}
-}
-
-/*
- * Check if the cpu has gone through a quiescent state (say context
- * switch). If so and if it already hasn't done so in this RCU
- * quiescent cycle, then indicate that it has done so.
- */
-static void rcu_check_quiescent_state(struct rcu_ctrlblk *rcp,
-					struct rcu_data *rdp)
-{
-	if (rdp->quiescbatch != rcp->cur) {
-		/* start new grace period: */
-		rdp->qs_pending = 1;
-		rdp->passed_quiesc = 0;
-		rdp->quiescbatch = rcp->cur;
-		return;
-	}
-
-	/* Grace period already completed for this cpu?
-	 * qs_pending is checked instead of the actual bitmap to avoid
-	 * cacheline trashing.
-	 */
-	if (!rdp->qs_pending)
-		return;
-
-	/* 
-	 * Was there a quiescent state since the beginning of the grace
-	 * period? If no, then exit and wait for the next call.
-	 */
-	if (!rdp->passed_quiesc)
-		return;
-	rdp->qs_pending = 0;
-
-	spin_lock(&rcp->lock);
-	/*
-	 * rdp->quiescbatch/rcp->cur and the cpu bitmap can come out of sync
-	 * during cpu startup. Ignore the quiescent state.
-	 */
-	if (likely(rdp->quiescbatch == rcp->cur))
-		cpu_quiet(rdp->cpu, rcp);
-
-	spin_unlock(&rcp->lock);
-}
-
-
-#ifdef CONFIG_HOTPLUG_CPU
-
-/* warning! helper for rcu_offline_cpu. do not use elsewhere without reviewing
- * locking requirements, the list it's pulling from has to belong to a cpu
- * which is dead and hence not processing interrupts.
- */
-static void rcu_move_batch(struct rcu_data *this_rdp, struct rcu_head *list,
-				struct rcu_head **tail)
-{
-	local_irq_disable();
-	*this_rdp->nxttail = list;
-	if (list)
-		this_rdp->nxttail = tail;
-	local_irq_enable();
-}
-
-static void __rcu_offline_cpu(struct rcu_data *this_rdp,
-				struct rcu_ctrlblk *rcp, struct rcu_data *rdp)
-{
-	/* if the cpu going offline owns the grace period
-	 * we can block indefinitely waiting for it, so flush
-	 * it here
-	 */
-	spin_lock_bh(&rcp->lock);
-	if (rcp->cur != rcp->completed)
-		cpu_quiet(rdp->cpu, rcp);
-	spin_unlock_bh(&rcp->lock);
-	rcu_move_batch(this_rdp, rdp->curlist, rdp->curtail);
-	rcu_move_batch(this_rdp, rdp->nxtlist, rdp->nxttail);
-	rcu_move_batch(this_rdp, rdp->donelist, rdp->donetail);
-}
-
-static void rcu_offline_cpu(int cpu)
-{
-	struct rcu_data *this_rdp = &get_cpu_var(rcu_data);
-	struct rcu_data *this_bh_rdp = &get_cpu_var(rcu_bh_data);
-
-	__rcu_offline_cpu(this_rdp, &rcu_ctrlblk,
-					&per_cpu(rcu_data, cpu));
-	__rcu_offline_cpu(this_bh_rdp, &rcu_bh_ctrlblk,
-					&per_cpu(rcu_bh_data, cpu));
-	put_cpu_var(rcu_data);
-	put_cpu_var(rcu_bh_data);
-	tasklet_kill_immediate(&per_cpu(rcu_tasklet, cpu), cpu);
-}
 
-#else
-
-static void rcu_offline_cpu(int cpu)
-{
-}
-
-#endif
-
-/*
- * This does the RCU processing work from tasklet context. 
- */
-static void __rcu_process_callbacks(struct rcu_ctrlblk *rcp,
-					struct rcu_data *rdp)
-{
-	if (rdp->curlist && !rcu_batch_before(rcp->completed, rdp->batch)) {
-		*rdp->donetail = rdp->curlist;
-		rdp->donetail = rdp->curtail;
-		rdp->curlist = NULL;
-		rdp->curtail = &rdp->curlist;
-	}
-
-	if (rdp->nxtlist && !rdp->curlist) {
-		local_irq_disable();
-		rdp->curlist = rdp->nxtlist;
-		rdp->curtail = rdp->nxttail;
-		rdp->nxtlist = NULL;
-		rdp->nxttail = &rdp->nxtlist;
-		local_irq_enable();
-
-		/*
-		 * start the next batch of callbacks
-		 */
-
-		/* determine batch number */
-		rdp->batch = rcp->cur + 1;
-		/* see the comment and corresponding wmb() in
-		 * the rcu_start_batch()
-		 */
-		smp_rmb();
-
-		if (!rcp->next_pending) {
-			/* and start it/schedule start if it's a new batch */
-			spin_lock(&rcp->lock);
-			rcp->next_pending = 1;
-			rcu_start_batch(rcp);
-			spin_unlock(&rcp->lock);
-		}
-	}
-
-	rcu_check_quiescent_state(rcp, rdp);
-	if (rdp->donelist)
-		rcu_do_batch(rdp);
-}
-
-static void rcu_process_callbacks(unsigned long unused)
-{
-	__rcu_process_callbacks(&rcu_ctrlblk, &__get_cpu_var(rcu_data));
-	__rcu_process_callbacks(&rcu_bh_ctrlblk, &__get_cpu_var(rcu_bh_data));
-}
-
-static int __rcu_pending(struct rcu_ctrlblk *rcp, struct rcu_data *rdp)
-{
-	/* This cpu has pending rcu entries and the grace period
-	 * for them has completed.
-	 */
-	if (rdp->curlist && !rcu_batch_before(rcp->completed, rdp->batch))
-		return 1;
-
-	/* This cpu has no pending entries, but there are new entries */
-	if (!rdp->curlist && rdp->nxtlist)
-		return 1;
-
-	/* This cpu has finished callbacks to invoke */
-	if (rdp->donelist)
-		return 1;
-
-	/* The rcu core waits for a quiescent state from the cpu */
-	if (rdp->quiescbatch != rcp->cur || rdp->qs_pending)
-		return 1;
-
-	/* nothing to do */
-	return 0;
-}
-
-/*
- * Check to see if there is any immediate RCU-related work to be done
- * by the current CPU, returning 1 if so.  This function is part of the
- * RCU implementation; it is -not- an exported member of the RCU API.
- */
-int rcu_pending(int cpu)
-{
-	return __rcu_pending(&rcu_ctrlblk, &per_cpu(rcu_data, cpu)) ||
-		__rcu_pending(&rcu_bh_ctrlblk, &per_cpu(rcu_bh_data, cpu));
-}
-
-/*
- * Check to see if any future RCU-related work will need to be done
- * by the current CPU, even if none need be done immediately, returning
- * 1 if so.  This function is part of the RCU implementation; it is -not-
- * an exported member of the RCU API.
- */
-int rcu_needs_cpu(int cpu)
-{
-	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
-	struct rcu_data *rdp_bh = &per_cpu(rcu_bh_data, cpu);
-
-	return (!!rdp->curlist || !!rdp_bh->curlist || rcu_pending(cpu));
-}
-
-void rcu_check_callbacks(int cpu, int user)
-{
-	if (user || 
-	    (idle_cpu(cpu) && !in_softirq() && 
-				hardirq_count() <= (1 << HARDIRQ_SHIFT))) {
-		rcu_qsctr_inc(cpu);
-		rcu_bh_qsctr_inc(cpu);
-	} else if (!in_softirq())
-		rcu_bh_qsctr_inc(cpu);
-	tasklet_schedule(&per_cpu(rcu_tasklet, cpu));
-}
-
-static void rcu_init_percpu_data(int cpu, struct rcu_ctrlblk *rcp,
-						struct rcu_data *rdp)
-{
-	memset(rdp, 0, sizeof(*rdp));
-	rdp->curtail = &rdp->curlist;
-	rdp->nxttail = &rdp->nxtlist;
-	rdp->donetail = &rdp->donelist;
-	rdp->quiescbatch = rcp->completed;
-	rdp->qs_pending = 0;
-	rdp->cpu = cpu;
-	rdp->blimit = blimit;
-}
-
-static void __devinit rcu_online_cpu(int cpu)
-{
-	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
-	struct rcu_data *bh_rdp = &per_cpu(rcu_bh_data, cpu);
-
-	rcu_init_percpu_data(cpu, &rcu_ctrlblk, rdp);
-	rcu_init_percpu_data(cpu, &rcu_bh_ctrlblk, bh_rdp);
-	tasklet_init(&per_cpu(rcu_tasklet, cpu), rcu_process_callbacks, 0UL);
-}
-
-static int __devinit rcu_cpu_notify(struct notifier_block *self,
-				unsigned long action, void *hcpu)
-{
-	long cpu = (long)hcpu;
-	switch (action) {
-	case CPU_UP_PREPARE:
-		rcu_online_cpu(cpu);
-		break;
-	case CPU_DEAD:
-		rcu_offline_cpu(cpu);
-		break;
-	default:
-		break;
-	}
-	return NOTIFY_OK;
-}
-
-static struct notifier_block __devinitdata rcu_nb = {
-	.notifier_call	= rcu_cpu_notify,
-};
-
-/*
- * Initializes rcu mechanism.  Assumed to be called early.
- * That is before local timer(SMP) or jiffie timer (uniproc) is setup.
- * Note that rcu_qsctr and friends are implicitly
- * initialized due to the choice of ``0'' for RCU_CTR_INVALID.
- */
 void __init rcu_init(void)
 {
-	rcu_cpu_notify(&rcu_nb, CPU_UP_PREPARE,
-			(void *)(long)smp_processor_id());
-	/* Register notifier for non-boot CPUs */
-	register_cpu_notifier(&rcu_nb);
-}
-
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
+	__rcu_init();
 }
 
-module_param(blimit, int, 0);
-module_param(qhimark, int, 0);
-module_param(qlowmark, int, 0);
-#ifdef CONFIG_SMP
-module_param(rsinterval, int, 0);
-#endif
-EXPORT_SYMBOL_GPL(rcu_batches_completed);
-EXPORT_SYMBOL_GPL(rcu_batches_completed_bh);
-EXPORT_SYMBOL_GPL(call_rcu);
-EXPORT_SYMBOL_GPL(call_rcu_bh);
+EXPORT_SYMBOL_GPL(rcu_barrier);
 EXPORT_SYMBOL_GPL(synchronize_rcu);

_
