Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314686AbSEFTgl>; Mon, 6 May 2002 15:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314694AbSEFTgk>; Mon, 6 May 2002 15:36:40 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:8843 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314686AbSEFTgg>;
	Mon, 6 May 2002 15:36:36 -0400
Date: Tue, 7 May 2002 01:08:29 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] New 2.5.14 Hotplug CPU Work
Message-ID: <20020507010829.A23528@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


In article <E174dnM-0007ns-00@wagner.rustcorp.com.au> Rusty Russell wrote:
> Hi all,

> 	After some delay, a new scratch implementation of hotplug CPU
> for x86 is available:
[..]
> I'm pretty happy with the simpler boot code, but there are several
> problems with this version:

> 1) It needs synchronize_kernel to be 100% correct, which was broken by
>    preempt.

Hi Rusty,

Here is a patch (rcu_poll) that supports synchronize_kernel() in
preemptible environment. This is a work in progress, there are
issues related to handling very long grace periods gracefully in 
preemptible kernel that I am working on.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rcu_poll_preempt-2.5.12-1.patch"

diff -urN linux-2.5.12-base/include/linux/init_task.h linux-2.5.12-rcu_poll_preempt/include/linux/init_task.h
--- linux-2.5.12-base/include/linux/init_task.h	Wed May  1 05:38:47 2002
+++ linux-2.5.12-rcu_poll_preempt/include/linux/init_task.h	Thu May  2 18:59:09 2002
@@ -79,6 +79,7 @@
     blocked:		{{0}},						\
     alloc_lock:		SPIN_LOCK_UNLOCKED,				\
     journal_info:	NULL,						\
+    cpu_preempt_cntr:	NULL,					\
 }
 
 
diff -urN linux-2.5.12-base/include/linux/rcupdate.h linux-2.5.12-rcu_poll_preempt/include/linux/rcupdate.h
--- linux-2.5.12-base/include/linux/rcupdate.h	Thu Jan  1 05:30:00 1970
+++ linux-2.5.12-rcu_poll_preempt/include/linux/rcupdate.h	Thu May  2 18:40:45 2002
@@ -0,0 +1,59 @@
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
+ * Copyright (c) International Business Machines Corp., 2001
+ *
+ * Author: Dipankar Sarma <dipankar@in.ibm.com>
+ * 
+ * Based on the original work by Paul McKenney <paul.mckenney@us.ibm.com>
+ * and inputs from Andrea Arcangeli, Rusty Russell, Andi Kleen etc.
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
+#include <linux/list.h>
+
+/*
+ * Callback structure for use with call_rcu(). 
+ */
+struct rcu_head {
+	struct list_head list;
+	void (*func)(void *obj);
+	void *arg;
+};
+
+#define RCU_HEAD_INIT(head) { LIST_HEAD_INIT(head.list), NULL, NULL }
+#define RCU_HEAD(head) struct rcu_head head = RCU_HEAD_INIT(head)
+#define INIT_RCU_HEAD(ptr) do { \
+	INIT_LIST_HEAD(&(ptr)->list); (ptr)->func = NULL; (ptr)->arg = NULL; \
+} while (0)
+
+
+extern void FASTCALL(call_rcu(struct rcu_head *head, void (*func)(void *arg), void *arg));
+extern void synchronize_kernel(void);
+
+extern void rcu_init(void);
+
+#endif /* __LINUX_RCUPDATE_H */
diff -urN linux-2.5.12-base/include/linux/sched.h linux-2.5.12-rcu_poll_preempt/include/linux/sched.h
--- linux-2.5.12-base/include/linux/sched.h	Wed May  1 05:38:47 2002
+++ linux-2.5.12-rcu_poll_preempt/include/linux/sched.h	Thu May  2 18:39:48 2002
@@ -28,6 +28,7 @@
 #include <linux/securebits.h>
 #include <linux/fs_struct.h>
 #include <linux/compiler.h>
+#include <linux/percpu.h>
 
 struct exec_domain;
 
@@ -162,6 +163,7 @@
 extern void flush_scheduled_tasks(void);
 extern int start_context_thread(void);
 extern int current_is_keventd(void);
+extern void force_cpu_reschedule(int cpu);
 
 struct namespace;
 
@@ -347,6 +349,7 @@
 /* journalling filesystem info */
 	void *journal_info;
 	struct dentry *proc_dentry;
+	atomic_t *cpu_preempt_cntr;
 };
 
 extern void __put_task_struct(struct task_struct *tsk);
@@ -418,6 +421,7 @@
 
 extern struct   mm_struct init_mm;
 extern struct task_struct *init_tasks[NR_CPUS];
+extern long cpu_quiescent __per_cpu_data;
 
 /* PID hashing. (shouldnt this be dynamic?) */
 #define PIDHASH_SZ (4096 >> 2)
@@ -875,6 +879,53 @@
 		clear_thread_flag(TIF_SIGPENDING);
 }
 
+#ifdef CONFIG_PREEMPT
+
+extern atomic_t rcu_preempt_cntr[2] __per_cpu_data;
+extern atomic_t *curr_preempt_cntr __per_cpu_data;
+extern atomic_t *next_preempt_cntr __per_cpu_data;
+
+static inline void rcu_switch_preempt_cntr(int cpu)
+{
+	atomic_t *tmp;
+	tmp = per_cpu(curr_preempt_cntr, cpu);
+	per_cpu(curr_preempt_cntr, cpu) = per_cpu(next_preempt_cntr, cpu);
+	per_cpu(next_preempt_cntr, cpu) = tmp;
+
+}
+
+static inline void rcu_preempt_put(void)
+{
+	if (unlikely(current->cpu_preempt_cntr != NULL)) {
+		atomic_dec(current->cpu_preempt_cntr);
+		current->cpu_preempt_cntr = NULL;
+	}
+}
+
+/* Must not be preempted */
+static inline void rcu_preempt_get(void)
+{
+	if (likely(current->cpu_preempt_cntr == NULL)) {
+		current->cpu_preempt_cntr = 
+				this_cpu(next_preempt_cntr);
+		atomic_inc(current->cpu_preempt_cntr);
+	}
+}
+
+static inline int rcu_cpu_preempted(int cpu)
+{
+	return (atomic_read(per_cpu(curr_preempt_cntr, cpu)) != 0);
+}
+#else
+
+#define rcu_init_preempt_cntr(cpu) do { } while(0)
+#define rcu_switch_preempt_cntr(cpu) do { } while(0)
+#define rcu_preempt_put() do { } while(0)
+#define rcu_preempt_get() do { } while(0)
+#define rcu_cpu_preempted(cpu) (0)
+
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif
diff -urN linux-2.5.12-base/init/main.c linux-2.5.12-rcu_poll_preempt/init/main.c
--- linux-2.5.12-base/init/main.c	Wed May  1 05:38:48 2002
+++ linux-2.5.12-rcu_poll_preempt/init/main.c	Thu May  2 17:53:50 2002
@@ -28,6 +28,7 @@
 #include <linux/bootmem.h>
 #include <linux/tty.h>
 #include <linux/percpu.h>
+#include <linux/rcupdate.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -346,6 +347,7 @@
 	printk("Kernel command line: %s\n", saved_command_line);
 	parse_options(command_line);
 	trap_init();
+	rcu_init();
 	init_IRQ();
 	sched_init();
 	softirq_init();
diff -urN linux-2.5.12-base/kernel/Makefile linux-2.5.12-rcu_poll_preempt/kernel/Makefile
--- linux-2.5.12-base/kernel/Makefile	Wed May  1 05:38:49 2002
+++ linux-2.5.12-rcu_poll_preempt/kernel/Makefile	Thu May  2 17:53:50 2002
@@ -10,12 +10,12 @@
 O_TARGET := kernel.o
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o platform.o 
+		printk.o platform.o rcupdate.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o futex.o platform.o
+	    signal.o sys.o kmod.o context.o futex.o platform.o rcupdate.o
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
diff -urN linux-2.5.12-base/kernel/exit.c linux-2.5.12-rcu_poll_preempt/kernel/exit.c
--- linux-2.5.12-base/kernel/exit.c	Wed May  1 05:38:54 2002
+++ linux-2.5.12-rcu_poll_preempt/kernel/exit.c	Thu May  2 17:59:09 2002
@@ -550,6 +550,7 @@
 
 	tsk->exit_code = code;
 	exit_notify();
+	rcu_preempt_put();
 	schedule();
 	BUG();
 /*
diff -urN linux-2.5.12-base/kernel/fork.c linux-2.5.12-rcu_poll_preempt/kernel/fork.c
--- linux-2.5.12-base/kernel/fork.c	Wed May  1 05:38:47 2002
+++ linux-2.5.12-rcu_poll_preempt/kernel/fork.c	Thu May  2 17:59:09 2002
@@ -117,6 +117,7 @@
 	tsk->thread_info = ti;
 	ti->task = tsk;
 	atomic_set(&tsk->usage,1);
+	tsk->cpu_preempt_cntr = NULL;
 
 	return tsk;
 }
diff -urN linux-2.5.12-base/kernel/rcupdate.c linux-2.5.12-rcu_poll_preempt/kernel/rcupdate.c
--- linux-2.5.12-base/kernel/rcupdate.c	Thu Jan  1 05:30:00 1970
+++ linux-2.5.12-rcu_poll_preempt/kernel/rcupdate.c	Thu May  2 18:07:38 2002
@@ -0,0 +1,218 @@
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
+ * Copyright (c) International Business Machines Corp., 2001
+ * Copyright (C) Andrea Arcangeli <andrea@suse.de> SuSE, 2001
+ *
+ * Author: Dipankar Sarma <dipankar@in.ibm.com>,
+ *	   Andrea Arcangeli <andrea@suse.de>
+ * 
+ * Based on the original work by Paul McKenney <paul.mckenney@us.ibm.com>
+ * and inputs from Andrea Arcangeli, Rusty Russell, Andi Kleen etc.
+ * Papers:
+ * http://www.rdrop.com/users/paulmck/paper/rclockpdcsproof.pdf
+ * http://lse.sourceforge.net/locking/rclock_OLS.2001.05.01c.sc.pdf (OLS2001)
+ *
+ * For detailed explanation of Read-Copy Update mechanism see -
+ * 		http://lse.sourceforge.net/locking/rcupdate.html
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/sched.h>
+#include <linux/smp.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/completion.h>
+#include <linux/percpu.h>
+#include <linux/rcupdate.h>
+
+/* Definition for rcupdate control block. */
+static spinlock_t rcu_lock;
+static struct list_head rcu_nxtlist;
+static struct list_head rcu_curlist;
+static struct tasklet_struct rcu_tasklet;
+static unsigned long rcu_qsmask;
+static int rcu_polling_in_progress;
+static long rcu_quiescent_checkpoint[NR_CPUS];
+
+#define RCU_quiescent(cpu) per_cpu(cpu_quiescent, cpu)
+
+/*
+ * Register a new rcu callback. This will be invoked as soon
+ * as all CPUs have performed a context switch or been seen in the
+ * idle loop or in a user process. It can be called only from
+ * process or BH context, however can be made to work from irq
+ * context too with minor code changes if necessary.
+ */
+void call_rcu(struct rcu_head *head, void (*func)(void *arg), void *arg)
+{
+	head->func = func;
+	head->arg = arg;
+
+	spin_lock_bh(&rcu_lock);
+	list_add(&head->list, &rcu_nxtlist);
+	spin_unlock_bh(&rcu_lock);
+
+	tasklet_hi_schedule(&rcu_tasklet);
+}
+
+static int rcu_prepare_polling(void)
+{
+	int stop;
+	int i;
+
+#ifdef DEBUG
+	if (!list_empty(&rcu_curlist))
+		BUG();
+#endif
+
+	stop = 1;
+	if (!list_empty(&rcu_nxtlist)) {
+		list_splice(&rcu_nxtlist, &rcu_curlist);
+		INIT_LIST_HEAD(&rcu_nxtlist);
+
+		rcu_polling_in_progress = 1;
+
+		for (i = 0; i < smp_num_cpus; i++) {
+			int cpu = cpu_logical_map(i);
+
+			rcu_qsmask |= 1UL << cpu;
+			rcu_quiescent_checkpoint[cpu] = RCU_quiescent(cpu);
+			rcu_switch_preempt_cntr(cpu);
+			force_cpu_reschedule(cpu);
+		}
+		stop = 0;
+	}
+
+	return stop;
+}
+
+/*
+ * Invoke the completed RCU callbacks.
+ */
+static void rcu_invoke_callbacks(void)
+{
+	struct list_head *entry;
+	struct rcu_head *head;
+
+#ifdef DEBUG
+	if (list_empty(&rcu_curlist))
+		BUG();
+#endif
+
+	entry = rcu_curlist.prev;
+	do {
+		head = list_entry(entry, struct rcu_head, list);
+		entry = entry->prev;
+
+		head->func(head->arg);
+	} while (entry != &rcu_curlist);
+
+	INIT_LIST_HEAD(&rcu_curlist);
+}
+
+static int rcu_completion(void)
+{
+	int stop;
+
+	rcu_polling_in_progress = 0;
+	rcu_invoke_callbacks();
+
+	stop = rcu_prepare_polling();
+
+	return stop;
+}
+
+static int rcu_polling(void)
+{
+	int i;
+	int stop;
+
+	for (i = 0; i < smp_num_cpus; i++) {
+		int cpu = cpu_logical_map(i);
+
+		if (rcu_qsmask & (1UL << cpu))
+			if ((rcu_quiescent_checkpoint[cpu] != 
+						RCU_quiescent(cpu)) && 
+			     !rcu_cpu_preempted(cpu))
+				rcu_qsmask &= ~(1UL << cpu);
+	}
+
+	stop = 0;
+	if (!rcu_qsmask)
+		stop = rcu_completion();
+
+	return stop;
+}
+
+/*
+ * Look into the per-cpu callback information to see if there is
+ * any processing necessary - if so do it.
+ */
+static void rcu_process_callbacks(unsigned long data)
+{
+	int stop;
+
+	spin_lock(&rcu_lock);
+	if (!rcu_polling_in_progress)
+		stop = rcu_prepare_polling();
+	else
+		stop = rcu_polling();
+	spin_unlock(&rcu_lock);
+
+	if (!stop)
+		tasklet_hi_schedule(&rcu_tasklet);
+}
+
+/* Because of FASTCALL declaration of complete, we use this wrapper */
+static void wakeme_after_rcu(void *completion)
+{
+	complete(completion);
+}
+
+/*
+ * Initializes rcu mechanism.  Assumed to be called early.
+ * That is before local timer(SMP) or jiffie timer (uniproc) is setup.
+ */
+void __init rcu_init(void)
+{
+	tasklet_init(&rcu_tasklet, rcu_process_callbacks, 0UL);
+	INIT_LIST_HEAD(&rcu_nxtlist);
+	INIT_LIST_HEAD(&rcu_curlist);
+	spin_lock_init(&rcu_lock);
+}
+
+/*
+ * Wait until all the CPUs have gone through a "quiescent" state.
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
+EXPORT_SYMBOL(call_rcu);
+EXPORT_SYMBOL(synchronize_kernel);
diff -urN linux-2.5.12-base/kernel/sched.c linux-2.5.12-rcu_poll_preempt/kernel/sched.c
--- linux-2.5.12-base/kernel/sched.c	Wed May  1 05:38:50 2002
+++ linux-2.5.12-rcu_poll_preempt/kernel/sched.c	Thu May  2 18:00:13 2002
@@ -22,6 +22,7 @@
 #include <linux/interrupt.h>
 #include <linux/completion.h>
 #include <linux/kernel_stat.h>
+#include <linux/percpu.h>
 
 /*
  * Priority of a process goes from 0 to 139. The 0-99
@@ -156,12 +157,32 @@
 
 static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
 
+long cpu_quiescent __per_cpu_data;
+
 #define cpu_rq(cpu)		(runqueues + (cpu))
 #define this_rq()		cpu_rq(smp_processor_id())
 #define task_rq(p)		cpu_rq((p)->thread_info->cpu)
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define rt_task(p)		((p)->prio < MAX_RT_PRIO)
 
+#ifdef CONFIG_PREEMPT
+atomic_t rcu_preempt_cntr[2] __per_cpu_data;
+atomic_t *curr_preempt_cntr __per_cpu_data;
+atomic_t *next_preempt_cntr __per_cpu_data;
+#endif
+
+#ifdef CONFIG_PREEMPT
+static inline void rcu_init_preempt_cntr(int cpu)
+{
+        atomic_set(&per_cpu(rcu_preempt_cntr[0], cpu), 0);
+        atomic_set(&per_cpu(rcu_preempt_cntr[1], cpu), 0);
+	per_cpu(curr_preempt_cntr, cpu) = 
+			&per_cpu(rcu_preempt_cntr[1], cpu);
+	per_cpu(next_preempt_cntr, cpu) = 
+			&per_cpu(rcu_preempt_cntr[0], cpu);
+}
+#endif
+
 static inline runqueue_t *task_rq_lock(task_t *p, unsigned long *flags)
 {
 	struct runqueue *rq;
@@ -773,8 +794,11 @@
 	 * if entering from preempt_schedule, off a kernel preemption,
 	 * go straight to picking the next task.
 	 */
-	if (unlikely(preempt_get_count() & PREEMPT_ACTIVE))
+	if (unlikely(preempt_get_count() & PREEMPT_ACTIVE)) {
 		goto pick_next_task;
+	} else {
+		rcu_preempt_put();
+	}
 	
 	switch (prev->state) {
 	case TASK_INTERRUPTIBLE:
@@ -817,6 +841,7 @@
 switch_tasks:
 	prefetch(next);
 	clear_tsk_need_resched(prev);
+	per_cpu(cpu_quiescent, prev->thread_info->cpu)++;
 
 	if (likely(prev != next)) {
 		rq->nr_switches++;
@@ -857,6 +882,7 @@
 		return;
 
 	ti->preempt_count = PREEMPT_ACTIVE;
+	rcu_preempt_get();
 	schedule();
 	ti->preempt_count = 0;
 	barrier();
@@ -1031,6 +1057,21 @@
 	task_rq_unlock(rq, &flags);
 }
 
+void force_cpu_reschedule(int cpu)
+{
+	unsigned long flags;
+	struct runqueue *rq, *newrq;
+	struct task_struct *p;
+
+	rq = cpu_rq(cpu);
+	p = rq->curr;
+	newrq = task_rq_lock(p, &flags);
+	if (newrq == rq)
+		resched_task(p);
+	task_rq_unlock(newrq, &flags);
+}
+
+
 #ifndef __alpha__
 
 /*
@@ -1592,6 +1633,7 @@
 		spin_lock_init(&rq->lock);
 		spin_lock_init(&rq->frozen);
 		INIT_LIST_HEAD(&rq->migration_queue);
+		rcu_init_preempt_cntr(i);
 
 		for (j = 0; j < 2; j++) {
 			array = rq->arrays + j;

--J2SCkAp4GZ/dPZZf--
