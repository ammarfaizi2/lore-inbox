Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262129AbSJNSKb>; Mon, 14 Oct 2002 14:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262126AbSJNSKa>; Mon, 14 Oct 2002 14:10:30 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:17644 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262124AbSJNSKW>;
	Mon, 14 Oct 2002 14:10:22 -0400
Date: Mon, 14 Oct 2002 23:52:01 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Read-Copy Update 2.5.42 
Message-ID: <20021014235201.A20643@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is the RCU core patch from akpm's tree. It has been in his
tree since about 2.5.37-mm1 along with dcache_rcu and so far it has
worked fine. For 2.5, I am hoping that we might get the following
RCU patches included -

1. rt_rcu - ipv4 routecache lookup. Davem agreed to include this patch
   if and when you include RCU core in your tree.

2. dcache_rcu (by Maneesh Soni) - dcache lookup avoiding dcache_lock as 
   much as possible. This has been akpm's tree - stable and gives us 
   good yield. I have been submitting this to Viro and I will publish
   some more benchmark numbers later to help decide on this.

This RCU core implements RCU APIs, call_rcu() and synchronize_kernel(),
by monitoring a per-CPU quiescent state (idle/user etc.) counter.
call_rcu() queues a callback to be invoked after all the CPUs have
gone through a quiescent state. Queuing is per-CPU and each per-CPU
batch gets a batch number. As batches get their turn, a global
cpu mask is used to keep track of CPUs pending quiescent state.
Checking for quiescent cycle is done by saving the per-CPU
counter at the beginning of the batch and then monitoring it for change
through the local timer interrupt handler.

Please include.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.


 include/linux/rcupdate.h |  134 ++++++++++++++++++++++++++
 init/main.c              |    2 
 kernel/Makefile          |    5 
 kernel/rcupdate.c        |  242 +++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched.c           |    5 
 5 files changed, 386 insertions(+), 2 deletions(-)


diff -urN linux-2.5.42-base/include/linux/rcupdate.h linux-2.5.42-rcu/include/linux/rcupdate.h
--- linux-2.5.42-base/include/linux/rcupdate.h	Thu Jan  1 05:30:00 1970
+++ linux-2.5.42-rcu/include/linux/rcupdate.h	Mon Oct 14 12:45:54 2002
@@ -0,0 +1,134 @@
+/*
+ * Read-Copy Update mechanism for mutual exclusion 
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
+ * Copyright (c) IBM Corporation, 2001
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
+#ifndef __LINUX_RCUPDATE_H
+#define __LINUX_RCUPDATE_H
+
+#ifdef __KERNEL__
+
+#include <linux/cache.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/threads.h>
+
+/**
+ * struct rcu_head - callback structure for use with RCU
+ * @list: list_head to queue the update requests
+ * @func: actual update function to call after the grace period.
+ * @arg: argument to be passed to the actual update function.
+ */
+struct rcu_head {
+	struct list_head list;
+	void (*func)(void *obj);
+	void *arg;
+};
+
+#define RCU_HEAD_INIT(head) \
+		{ list: LIST_HEAD_INIT(head.list), func: NULL, arg: NULL }
+#define RCU_HEAD(head) struct rcu_head head = RCU_HEAD_INIT(head)
+#define INIT_RCU_HEAD(ptr) do { \
+       INIT_LIST_HEAD(&(ptr)->list); (ptr)->func = NULL; (ptr)->arg = NULL; \
+} while (0)
+
+
+
+/* Control variables for rcupdate callback mechanism. */
+struct rcu_ctrlblk {
+	spinlock_t	mutex;		/* Guard this struct                  */
+	long		curbatch;	/* Current batch number.	      */
+	long		maxbatch;	/* Max requested batch number.        */
+	unsigned long	rcu_cpu_mask; 	/* CPUs that need to switch in order  */
+					/* for current batch to proceed.      */
+};
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
+	long		qsctr;		 /* User-mode/idle loop etc. */
+        long            last_qsctr;	 /* value of qsctr at beginning */
+                                         /* of rcu grace period */
+        long  	       	batch;           /* Batch # for current RCU batch */
+        struct list_head  nxtlist;
+        struct list_head  curlist;
+} ____cacheline_aligned_in_smp;
+
+extern struct rcu_data rcu_data[NR_CPUS];
+extern struct rcu_ctrlblk rcu_ctrlblk;
+
+#define RCU_qsctr(cpu) 		(rcu_data[(cpu)].qsctr)
+#define RCU_last_qsctr(cpu) 	(rcu_data[(cpu)].last_qsctr)
+#define RCU_batch(cpu) 		(rcu_data[(cpu)].batch)
+#define RCU_nxtlist(cpu) 	(rcu_data[(cpu)].nxtlist)
+#define RCU_curlist(cpu) 	(rcu_data[(cpu)].curlist)
+
+#define RCU_QSCTR_INVALID	0
+
+static inline int rcu_pending(int cpu) 
+{
+	if ((!list_empty(&RCU_curlist(cpu)) &&
+	     rcu_batch_before(RCU_batch(cpu), rcu_ctrlblk.curbatch)) ||
+	    (list_empty(&RCU_curlist(cpu)) &&
+			 !list_empty(&RCU_nxtlist(cpu))) ||
+	    test_bit(cpu, &rcu_ctrlblk.rcu_cpu_mask))
+		return 1;
+	else
+		return 0;
+}
+
+#define rcu_read_lock()		preempt_disable()
+#define rcu_read_unlock()	preempt_enable()
+
+extern void rcu_init(void);
+extern void rcu_check_callbacks(int cpu, int user);
+
+/* Exported interfaces */
+extern void FASTCALL(call_rcu(struct rcu_head *head, 
+                          void (*func)(void *arg), void *arg));
+extern void synchronize_kernel(void);
+
+#endif /* __KERNEL__ */
+#endif /* __LINUX_RCUPDATE_H */
diff -urN linux-2.5.42-base/init/main.c linux-2.5.42-rcu/init/main.c
--- linux-2.5.42-base/init/main.c	Sat Oct 12 09:51:34 2002
+++ linux-2.5.42-rcu/init/main.c	Mon Oct 14 12:30:06 2002
@@ -31,6 +31,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/security.h>
 #include <linux/workqueue.h>
+#include <linux/rcupdate.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -398,6 +399,7 @@
 	printk("Kernel command line: %s\n", saved_command_line);
 	parse_options(command_line);
 	trap_init();
+	rcu_init();
 	init_IRQ();
 	sched_init();
 	softirq_init();
diff -urN linux-2.5.42-base/kernel/Makefile linux-2.5.42-rcu/kernel/Makefile
--- linux-2.5.42-base/kernel/Makefile	Sat Oct 12 09:51:34 2002
+++ linux-2.5.42-rcu/kernel/Makefile	Mon Oct 14 12:30:06 2002
@@ -3,12 +3,13 @@
 #
 
 export-objs = signal.o sys.o kmod.o workqueue.o ksyms.o pm.o exec_domain.o \
-	      printk.o platform.o suspend.o dma.o module.o cpufreq.o
+	      printk.o platform.o suspend.o dma.o module.o cpufreq.o rcupdate.o
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o workqueue.o futex.o platform.o pid.o
+	    signal.o sys.o kmod.o workqueue.o futex.o platform.o pid.o \
+	    rcupdate.o
 
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o
diff -urN linux-2.5.42-base/kernel/rcupdate.c linux-2.5.42-rcu/kernel/rcupdate.c
--- linux-2.5.42-base/kernel/rcupdate.c	Thu Jan  1 05:30:00 1970
+++ linux-2.5.42-rcu/kernel/rcupdate.c	Mon Oct 14 12:47:57 2002
@@ -0,0 +1,242 @@
+/*
+ * Read-Copy Update mechanism for mutual exclusion
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
+ * Copyright (c) IBM Corporation, 2001
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
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+#include <linux/interrupt.h>
+#include <linux/sched.h>
+#include <asm/atomic.h>
+#include <asm/bitops.h>
+#include <linux/module.h>
+#include <linux/completion.h>
+#include <linux/percpu.h>
+#include <linux/rcupdate.h>
+
+/* Definition for rcupdate control block. */
+struct rcu_ctrlblk rcu_ctrlblk = 
+	{ .mutex = SPIN_LOCK_UNLOCKED, .curbatch = 1, 
+	  .maxbatch = 1, .rcu_cpu_mask = 0 };
+struct rcu_data rcu_data[NR_CPUS] __cacheline_aligned;
+
+/* Fake initialization required by compiler */
+static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
+#define RCU_tasklet(cpu) (per_cpu(rcu_tasklet, cpu))
+
+/**
+ * call_rcu - Queue an RCU update request.
+ * @head: structure to be used for queueing the RCU updates.
+ * @func: actual update function to be invoked after the grace period
+ * @arg: argument to be passed to the update function
+ *
+ * The update function will be invoked as soon as all CPUs have performed 
+ * a context switch or been seen in the idle loop or in a user process. 
+ * The read-side of critical section that use call_rcu() for updation must 
+ * be protected by rcu_read_lock()/rcu_read_unlock().
+ */
+void call_rcu(struct rcu_head *head, void (*func)(void *arg), void *arg)
+{
+	int cpu;
+	unsigned long flags;
+
+	head->func = func;
+	head->arg = arg;
+	local_irq_save(flags);
+	cpu = smp_processor_id();
+	list_add_tail(&head->list, &RCU_nxtlist(cpu));
+	local_irq_restore(flags);
+}
+
+/*
+ * Invoke the completed RCU callbacks. They are expected to be in
+ * a per-cpu list.
+ */
+static void rcu_do_batch(struct list_head *list)
+{
+	struct list_head *entry;
+	struct rcu_head *head;
+
+	while (!list_empty(list)) {
+		entry = list->next;
+		list_del(entry);
+		head = list_entry(entry, struct rcu_head, list);
+		head->func(head->arg);
+	}
+}
+
+/*
+ * Register a new batch of callbacks, and start it up if there is currently no
+ * active batch and the batch to be registered has not already occurred.
+ * Caller must hold the rcu_ctrlblk lock.
+ */
+static void rcu_start_batch(long newbatch)
+{
+	if (rcu_batch_before(rcu_ctrlblk.maxbatch, newbatch)) {
+		rcu_ctrlblk.maxbatch = newbatch;
+	}
+	if (rcu_batch_before(rcu_ctrlblk.maxbatch, rcu_ctrlblk.curbatch) ||
+	    (rcu_ctrlblk.rcu_cpu_mask != 0)) {
+		return;
+	}
+	rcu_ctrlblk.rcu_cpu_mask = cpu_online_map;
+}
+
+/*
+ * Check if the cpu has gone through a quiescent state (say context
+ * switch). If so and if it already hasn't done so in this RCU
+ * quiescent cycle, then indicate that it has done so.
+ */
+static void rcu_check_quiescent_state(void)
+{
+	int cpu = smp_processor_id();
+
+	if (!test_bit(cpu, &rcu_ctrlblk.rcu_cpu_mask)) {
+		return;
+	}
+
+	/* 
+	 * Races with local timer interrupt - in the worst case
+	 * we may miss one quiescent state of that CPU. That is
+	 * tolerable. So no need to disable interrupts.
+	 */
+	if (RCU_last_qsctr(cpu) == RCU_QSCTR_INVALID) {
+		RCU_last_qsctr(cpu) = RCU_qsctr(cpu);
+		return;
+	}
+	if (RCU_qsctr(cpu) == RCU_last_qsctr(cpu)) {
+		return;
+	}
+
+	spin_lock(&rcu_ctrlblk.mutex);
+	if (!test_bit(cpu, &rcu_ctrlblk.rcu_cpu_mask)) {
+		spin_unlock(&rcu_ctrlblk.mutex);
+		return;
+	}
+	clear_bit(cpu, &rcu_ctrlblk.rcu_cpu_mask);
+	RCU_last_qsctr(cpu) = RCU_QSCTR_INVALID;
+	if (rcu_ctrlblk.rcu_cpu_mask != 0) {
+		spin_unlock(&rcu_ctrlblk.mutex);
+		return;
+	}
+	rcu_ctrlblk.curbatch++;
+	rcu_start_batch(rcu_ctrlblk.maxbatch);
+	spin_unlock(&rcu_ctrlblk.mutex);
+}
+
+
+/*
+ * This does the RCU processing work from tasklet context. 
+ */
+static void rcu_process_callbacks(unsigned long unused)
+{
+	int cpu = smp_processor_id();
+	LIST_HEAD(list);
+
+	if (!list_empty(&RCU_curlist(cpu)) &&
+	    rcu_batch_after(rcu_ctrlblk.curbatch, RCU_batch(cpu))) {
+		list_splice(&RCU_curlist(cpu), &list);
+		INIT_LIST_HEAD(&RCU_curlist(cpu));
+	}
+
+	local_irq_disable();
+	if (!list_empty(&RCU_nxtlist(cpu)) && list_empty(&RCU_curlist(cpu))) {
+		list_splice(&RCU_nxtlist(cpu), &RCU_curlist(cpu));
+		INIT_LIST_HEAD(&RCU_nxtlist(cpu));
+		local_irq_enable();
+
+		/*
+		 * start the next batch of callbacks
+		 */
+		spin_lock(&rcu_ctrlblk.mutex);
+		RCU_batch(cpu) = rcu_ctrlblk.curbatch + 1;
+		rcu_start_batch(RCU_batch(cpu));
+		spin_unlock(&rcu_ctrlblk.mutex);
+	} else {
+		local_irq_enable();
+	}
+	rcu_check_quiescent_state();
+	if (!list_empty(&list))
+		rcu_do_batch(&list);
+}
+
+void rcu_check_callbacks(int cpu, int user)
+{
+	if (user || 
+	    (idle_cpu(cpu) && !in_softirq() && hardirq_count() <= 1))
+		RCU_qsctr(cpu)++;
+	tasklet_schedule(&RCU_tasklet(cpu));
+}
+
+/*
+ * Initializes rcu mechanism.  Assumed to be called early.
+ * That is before local timer(SMP) or jiffie timer (uniproc) is setup.
+ * Note that rcu_qsctr and friends are implicitly
+ * initialized due to the choice of ``0'' for RCU_CTR_INVALID.
+ */
+void __init rcu_init(void)
+{
+	int i;
+
+	memset(&rcu_data[0], 0, sizeof(rcu_data));
+	for (i = 0; i < NR_CPUS; i++) {
+		tasklet_init(&RCU_tasklet(i), rcu_process_callbacks, 0UL);
+		INIT_LIST_HEAD(&RCU_nxtlist(i));
+		INIT_LIST_HEAD(&RCU_curlist(i));
+	}
+}
+
+/* Because of FASTCALL declaration of complete, we use this wrapper */
+static void wakeme_after_rcu(void *completion)
+{
+	complete(completion);
+}
+
+/**
+ * synchronize-kernel - wait until all the CPUs have gone
+ * through a "quiescent" state. It may sleep.
+ */
+void synchronize_kernel(void)
+{
+	struct rcu_head rcu;
+	DECLARE_COMPLETION(completion);
+
+	/* Will wake me after RCU finished */
+	call_rcu(&rcu, wakeme_after_rcu, &completion);
+
+	/* Wait for it */
+	wait_for_completion(&completion);
+}
+
+
+EXPORT_SYMBOL(call_rcu);
+EXPORT_SYMBOL(synchronize_kernel);
diff -urN linux-2.5.42-base/kernel/sched.c linux-2.5.42-rcu/kernel/sched.c
--- linux-2.5.42-base/kernel/sched.c	Sat Oct 12 09:52:18 2002
+++ linux-2.5.42-rcu/kernel/sched.c	Mon Oct 14 12:30:06 2002
@@ -31,6 +31,7 @@
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/timer.h>
+#include <linux/rcupdate.h>
 
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
@@ -865,6 +866,9 @@
 	runqueue_t *rq = this_rq();
 	task_t *p = current;
 
+ 	if (rcu_pending(cpu))
+ 		rcu_check_callbacks(cpu, user_ticks);
+
 	if (p == rq->idle) {
 		/* note: this timer irq context must be accounted for as well */
 		if (irq_count() - HARDIRQ_OFFSET >= SOFTIRQ_OFFSET)
@@ -1023,6 +1027,7 @@
 switch_tasks:
 	prefetch(next);
 	clear_tsk_need_resched(prev);
+	RCU_qsctr(prev->thread_info->cpu)++;
 
 	if (likely(prev != next)) {
 		rq->nr_switches++;
