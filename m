Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268788AbSIRSxP>; Wed, 18 Sep 2002 14:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268824AbSIRSxP>; Wed, 18 Sep 2002 14:53:15 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:40846 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S268788AbSIRSxH>;
	Wed, 18 Sep 2002 14:53:07 -0400
Date: Thu, 19 Sep 2002 00:33:32 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Read-Copy Update 2.5.36
Message-ID: <20020919003332.E23055@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <200209181937.39385.m.c.p@gmx.net> <20020919001018.C23055@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020919001018.C23055@in.ibm.com>; from dipankar@in.ibm.com on Thu, Sep 19, 2002 at 12:10:18AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 12:10:18AM +0530, Dipankar Sarma wrote:
> On Wed, Sep 18, 2002 at 07:38:30PM +0200, Marc-Christian Petersen wrote:
> > Hi Dipankar,
> > 
> > > Here is RCU for 2.5.36. It is just a rediff from earlier version.
> > unfortunately it does not build the modules correctly.
> > 
> > Output of "make modules"
> > 
> > make[1]: Entering directory `/usr/src/linux-2.5.36-vanilla/fs'
> >   gcc -Wp,-MD,./.binfmt_misc.o.d -D__KERNEL__ 
> > -I/usr/src/linux-2.5.36-vanilla/include -Wall -Wstrict-prototypes 
> > -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
> > -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include 
> > -DMODULE   -DKBUILD_BASENAME=binfmt_misc   -c -o binfmt_misc.o binfmt_misc.c
> > In file included from /usr/src/linux-2.5.36-vanilla/include/linux/mm.h:4,
> >                  from /usr/src/linux-2.5.36-vanilla/include/linux/pagemap.h:7,
> >                  from binfmt_misc.c:26:
> > /usr/src/linux-2.5.36-vanilla/include/linux/sched.h:480: parse error before 
> > `cpu_quiescent'
> > /usr/src/linux-2.5.36-vanilla/include/linux/sched.h:480: warning: type 
> > defaults to `int' in declaration of `DEFINE_PER_CPU'
> > /usr/src/linux-2.5.36-vanilla/include/linux/sched.h:480: warning: function 
> > declaration isn't a prototype
> 
> Ok, so DEFINE_PER_CPU() has now been excluded when MODULE is defined.
> The included patch below should fix that.
> 

Here is the entire rcu_poll patch with this fix -

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.

rcu_poll-2.5.36-2.patch
-----------------------

diff -urN linux-2.5.36-base/include/linux/init_task.h linux-2.5.36-rcu_poll/include/linux/init_task.h
--- linux-2.5.36-base/include/linux/init_task.h	Wed Sep 18 06:28:45 2002
+++ linux-2.5.36-rcu_poll/include/linux/init_task.h	Wed Sep 18 16:17:08 2002
@@ -98,6 +98,7 @@
 	.alloc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
+	.cpu_preempt_cntr = NULL,					\
 }
 
 
diff -urN linux-2.5.36-base/include/linux/rcupdate.h linux-2.5.36-rcu_poll/include/linux/rcupdate.h
--- linux-2.5.36-base/include/linux/rcupdate.h	Thu Jan  1 05:30:00 1970
+++ linux-2.5.36-rcu_poll/include/linux/rcupdate.h	Wed Sep 18 16:17:08 2002
@@ -0,0 +1,86 @@
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
+#ifndef _LINUX_RCUPDATE_H
+#define _LINUX_RCUPDATE_H
+
+#ifdef __KERNEL__
+
+#include <linux/list.h>
+#include <linux/spinlock.h>
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
+		{.list = LIST_HEAD_INIT((head).list), .func = NULL, .arg = NULL}
+#define RCU_HEAD(head) struct rcu_head head = RCU_HEAD_INIT(head)
+#define INIT_RCU_HEAD(ptr) do { \
+	INIT_LIST_HEAD(&(ptr)->list); (ptr)->func = NULL; (ptr)->arg = NULL; \
+} while (0)
+
+extern void FASTCALL(call_rcu(struct rcu_head *head, 
+				void (*func)(void *arg), void *arg));
+
+#ifdef CONFIG_PREEMPT
+
+#define rcu_read_lock()         preempt_disable()
+#define rcu_read_unlock()       preempt_enable()
+extern void FASTCALL(call_rcu_preempt(struct rcu_head *head,
+				void (*func)(void *arg), void *arg));
+
+#else
+
+#define rcu_read_lock()         do {} while(0)
+#define rcu_read_unlock()       do {} while(0)
+static inline void call_rcu_preempt(struct rcu_head *head, 
+				void (*func)(void *arg), void *arg)
+{
+	call_rcu(head, func, arg);
+}
+
+#endif
+
+extern void synchronize_kernel(void);
+extern void rcu_init(void);
+
+#endif /* __KERNEL__ */
+#endif /* _LINUX_RCUPDATE_H */
diff -urN linux-2.5.36-base/include/linux/sched.h linux-2.5.36-rcu_poll/include/linux/sched.h
--- linux-2.5.36-base/include/linux/sched.h	Wed Sep 18 06:28:45 2002
+++ linux-2.5.36-rcu_poll/include/linux/sched.h	Wed Sep 18 22:49:51 2002
@@ -28,6 +28,7 @@
 #include <linux/fs_struct.h>
 #include <linux/compiler.h>
 #include <linux/completion.h>
+#include <linux/percpu.h>
 
 struct exec_domain;
 
@@ -167,6 +168,7 @@
 extern void flush_scheduled_tasks(void);
 extern int start_context_thread(void);
 extern int current_is_keventd(void);
+extern void force_cpu_reschedule(int cpu);
 
 struct namespace;
 
@@ -396,6 +398,7 @@
 /* journalling filesystem info */
 	void *journal_info;
 	struct dentry *proc_dentry;
+	atomic_t *cpu_preempt_cntr;
 };
 
 extern void __put_task_struct(struct task_struct *tsk);
@@ -473,6 +476,10 @@
 extern struct task_struct init_task;
 
 extern struct   mm_struct init_mm;
+extern struct task_struct *init_tasks[NR_CPUS];
+#ifndef MODULE
+extern DEFINE_PER_CPU(long, cpu_quiescent);
+#endif
 
 /* PID hashing. (shouldnt this be dynamic?) */
 #define PIDHASH_SZ 8192
@@ -1024,6 +1031,55 @@
 
 #endif /* CONFIG_SMP */
 
+#if defined(CONFIG_PREEMPT) && !defined(MODULE)
+
+extern DEFINE_PER_CPU(atomic_t[2], rcu_preempt_cntr);
+extern DEFINE_PER_CPU(atomic_t, *curr_preempt_cntr);
+extern DEFINE_PER_CPU(atomic_t, *next_preempt_cntr);
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
+	preempt_disable();
+	if (unlikely(current->cpu_preempt_cntr != NULL)) {
+		atomic_dec(current->cpu_preempt_cntr);
+		current->cpu_preempt_cntr = NULL;
+	}
+	preempt_enable();
+}
+
+/* Must not be preempted */
+static inline void rcu_preempt_get(void)
+{
+	if (likely(current->cpu_preempt_cntr == NULL)) {
+		current->cpu_preempt_cntr = 
+				per_cpu(next_preempt_cntr, smp_processor_id());
+		atomic_inc(current->cpu_preempt_cntr);
+	}
+}
+
+static inline int is_rcu_cpu_preempted(int cpu)
+{
+	return (atomic_read(per_cpu(curr_preempt_cntr, cpu)) != 0);
+}
+#else
+
+#define rcu_init_preempt_cntr(cpu) do { } while(0)
+#define rcu_switch_preempt_cntr(cpu) do { } while(0)
+#define rcu_preempt_put() do { } while(0)
+#define rcu_preempt_get() do { } while(0)
+#define is_rcu_cpu_preempted(cpu) (0)
+
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif
diff -urN linux-2.5.36-base/init/main.c linux-2.5.36-rcu_poll/init/main.c
--- linux-2.5.36-base/init/main.c	Wed Sep 18 06:28:47 2002
+++ linux-2.5.36-rcu_poll/init/main.c	Wed Sep 18 16:17:08 2002
@@ -30,6 +30,7 @@
 #include <linux/percpu.h>
 #include <linux/kernel_stat.h>
 #include <linux/security.h>
+#include <linux/rcupdate.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -395,6 +396,7 @@
 	printk("Kernel command line: %s\n", saved_command_line);
 	parse_options(command_line);
 	trap_init();
+	rcu_init();
 	init_IRQ();
 	sched_init();
 	softirq_init();
diff -urN linux-2.5.36-base/kernel/Makefile linux-2.5.36-rcu_poll/kernel/Makefile
--- linux-2.5.36-base/kernel/Makefile	Wed Sep 18 06:28:48 2002
+++ linux-2.5.36-rcu_poll/kernel/Makefile	Wed Sep 18 16:17:08 2002
@@ -10,12 +10,12 @@
 O_TARGET := kernel.o
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o platform.o suspend.o dma.o
+		printk.o platform.o suspend.o dma.o rcupdate.o
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o futex.o platform.o
+	    signal.o sys.o kmod.o context.o futex.o platform.o rcupdate.o
 
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o
diff -urN linux-2.5.36-base/kernel/exit.c linux-2.5.36-rcu_poll/kernel/exit.c
--- linux-2.5.36-base/kernel/exit.c	Wed Sep 18 06:28:50 2002
+++ linux-2.5.36-rcu_poll/kernel/exit.c	Wed Sep 18 16:17:08 2002
@@ -637,6 +637,7 @@
 	preempt_disable();
 	if (current->exit_signal == -1)
 		release_task(current);
+	rcu_preempt_put();
 	schedule();
 	BUG();
 /*
diff -urN linux-2.5.36-base/kernel/fork.c linux-2.5.36-rcu_poll/kernel/fork.c
--- linux-2.5.36-base/kernel/fork.c	Wed Sep 18 06:28:45 2002
+++ linux-2.5.36-rcu_poll/kernel/fork.c	Wed Sep 18 16:17:08 2002
@@ -155,6 +155,7 @@
 	tsk->thread_info = ti;
 	ti->task = tsk;
 	atomic_set(&tsk->usage,1);
+	tsk->cpu_preempt_cntr = NULL;
 
 	return tsk;
 }
diff -urN linux-2.5.36-base/kernel/rcupdate.c linux-2.5.36-rcu_poll/kernel/rcupdate.c
--- linux-2.5.36-base/kernel/rcupdate.c	Thu Jan  1 05:30:00 1970
+++ linux-2.5.36-rcu_poll/kernel/rcupdate.c	Wed Sep 18 16:17:08 2002
@@ -0,0 +1,294 @@
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
+struct rcu_data {
+	struct list_head nxtlist;
+	struct list_head curlist;
+	struct tasklet_struct tasklet;
+	unsigned long qsmask;
+	int polling;
+	long qcheckpt[NR_CPUS];
+} ____cacheline_aligned_in_smp;
+
+static struct rcu_data rcu_data[NR_CPUS] __cacheline_aligned;
+static void rcu_data_init(struct rcu_data *);
+
+#ifdef CONFIG_PREEMPT
+static spinlock_t rcu_lock_preempt = SPIN_LOCK_UNLOCKED;
+static struct rcu_data rcu_data_preempt __cacheline_aligned;
+static inline void rcu_preempt_lock(void) 
+{
+	spin_lock_bh(&rcu_lock_preempt);
+}
+static inline void rcu_preempt_unlock(void) 
+{
+	spin_unlock_bh(&rcu_lock_preempt);
+}
+static inline void rcu_data_preempt_init(void) 
+{
+	rcu_data_init(&rcu_data_preempt);
+}
+#define is_rcu_preempt_data(rdata) (rdata == &rcu_data_preempt)
+#else
+static inline void rcu_preempt_lock(void)	{}
+static inline void rcu_preempt_unlock(void) 	{}
+static inline void rcu_data_preempt_init(void)  {}
+#define is_rcu_preempt_data(rdata) (0)
+#endif
+
+#define RCU_quiescent(cpu) per_cpu(cpu_quiescent, cpu)
+
+/**
+ * call_rcu - Queue an RCU update request. 
+ * @head: structure to be used for queueing the RCU updates.
+ * @func: actual update function to be invoked after the grace period
+ * @arg: argument to be passed to the update function
+ *
+ * The update function will be invoked as soon as all CPUs have performed a 
+ * context switch or been seen in the idle loop or in a user process. 
+ * It can be called only from process or BH context, however can be 
+ * made to work from irq context too with minor code changes 
+ * if necessary. The read-side of critical section that use 
+ * call_rcu() for updation must be protected by 
+ * rcu_read_lock()/rcu_read_unlock().
+ */
+void call_rcu(struct rcu_head *head, void (*func)(void *arg), void *arg)
+{
+	struct rcu_data *rdata;
+
+	head->func = func;
+	head->arg = arg;
+ 	rdata = &rcu_data[get_cpu()];
+	local_bh_disable();
+	list_add(&head->list, &rdata->nxtlist);
+	local_bh_enable();
+	tasklet_hi_schedule(&rdata->tasklet);
+	put_cpu();
+}
+
+#ifdef CONFIG_PREEMPT
+/**
+ * call_rcu_preempt - Queue an RCU update request for preempt-safe reads
+ * @head: structure to be used for queueing the RCU updates.
+ * @func: actual update function to be invoked after the grace period
+ * @arg: argument to be passed to the update function
+ *
+ * The update function will be invoked as soon as all CPUs have performed a
+ * context switch or been seen in the idle loop or in a user process. 
+ * It can be called only from process or BH context, however can be 
+ * made to work from irq context too with minor code changes 
+ * if necessary. The read-side of critical section  doesn't require any 
+ * protection, but updates may have long grace period in preemptive kernels.
+ * It should not be used for things like deferred kfree() unless such 
+ * use can be guaranteed to be extremely infrequent. Doing otherwise 
+ * can result in all your memory consumed while waiting for a 
+ * low-priority preempted task to be rescheduled.
+ */
+void call_rcu_preempt(struct rcu_head *head, void (*func)(void *arg), void *arg)
+{
+	struct rcu_data *rdata = &rcu_data_preempt;
+
+	head->func = func;
+	head->arg = arg;
+	rcu_preempt_lock();
+	list_add(&head->list, &rdata->nxtlist);
+	rcu_preempt_unlock();
+	tasklet_hi_schedule(&rdata->tasklet);
+}
+#endif
+
+/*
+ * Set up grace period detection for one batch of RCUs.
+ */
+static int rcu_prepare_polling(struct rcu_data *rdata)
+{
+	int stop;
+	int i;
+
+	stop = 1;
+	if (!list_empty(&rdata->nxtlist)) {
+		list_splice(&rdata->nxtlist, &rdata->curlist);
+		INIT_LIST_HEAD(&rdata->nxtlist);
+
+		rdata->polling = 1;
+
+		for (i = 0; i < NR_CPUS; i++) {
+			if (!cpu_online(i))
+				continue;
+			rdata->qsmask |= 1UL << i;
+			rdata->qcheckpt[i] = RCU_quiescent(i);
+			if (is_rcu_preempt_data(rdata))
+				rcu_switch_preempt_cntr(i);
+			force_cpu_reschedule(i);
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
+static void rcu_invoke_callbacks(struct rcu_data *rdata)
+{
+	struct list_head *entry;
+	struct rcu_head *head;
+
+	entry = rdata->curlist.prev;
+	do {
+		head = list_entry(entry, struct rcu_head, list);
+		entry = entry->prev;
+		head->func(head->arg);
+	} while (entry != &rdata->curlist);
+	INIT_LIST_HEAD(&rdata->curlist);
+}
+
+static int rcu_completion(struct rcu_data *rdata)
+{
+	int stop;
+
+	rdata->polling = 0;
+	rcu_invoke_callbacks(rdata);
+	stop = rcu_prepare_polling(rdata);
+	return stop;
+}
+
+/*
+ * Poll for completion of grace period for this batch.
+ */
+static int rcu_polling(struct rcu_data *rdata)
+{
+	int i;
+	int stop;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_online(i) ||
+		    !(rdata->qsmask & (1UL << i)))
+			continue;
+
+		if ((rdata->qcheckpt[i] != RCU_quiescent(i)) &&
+		    (!is_rcu_preempt_data(rdata) || !is_rcu_cpu_preempted(i)))
+				rdata->qsmask &= ~(1UL << i);
+		else
+			break;
+	}
+	stop = 0;
+	if (!rdata->qsmask)
+		stop = rcu_completion(rdata);
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
+	struct rcu_data *rdata = (struct rcu_data *)data;
+
+	if (is_rcu_preempt_data(rdata))
+		rcu_preempt_lock();
+	if (!rdata->polling)
+		stop = rcu_prepare_polling(rdata);
+	else
+		stop = rcu_polling(rdata);
+	if (is_rcu_preempt_data(rdata))
+		rcu_preempt_unlock();
+
+	if (!stop)
+		tasklet_hi_schedule(&rdata->tasklet);
+}
+
+/* Because of FASTCALL declaration of complete, we use this wrapper */
+static void wakeme_after_rcu(void *completion)
+{
+	complete(completion);
+}
+
+static void rcu_data_init(struct rcu_data *rdata)
+{
+	tasklet_init(&rdata->tasklet, rcu_process_callbacks, 
+			(unsigned long)rdata);
+	INIT_LIST_HEAD(&rdata->nxtlist);
+	INIT_LIST_HEAD(&rdata->curlist);
+}
+
+/*
+ * Initializes rcu mechanism.  Assumed to be called early.
+ * That is before local timer(SMP) or jiffie timer (uniproc) is setup.
+ */
+void __init rcu_init(void)
+{
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		rcu_data_init(&rcu_data[i]);
+	}
+	rcu_data_preempt_init();
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
+	call_rcu_preempt(&rcu, wakeme_after_rcu, &completion);
+
+	/* Wait for it */
+	wait_for_completion(&completion);
+}
+
+EXPORT_SYMBOL(call_rcu);
+EXPORT_SYMBOL(synchronize_kernel);
+#ifdef CONFIG_PREEMPT
+EXPORT_SYMBOL(call_rcu_preempt);
+#endif
diff -urN linux-2.5.36-base/kernel/sched.c linux-2.5.36-rcu_poll/kernel/sched.c
--- linux-2.5.36-base/kernel/sched.c	Wed Sep 18 06:28:48 2002
+++ linux-2.5.36-rcu_poll/kernel/sched.c	Wed Sep 18 16:17:08 2002
@@ -25,6 +25,7 @@
 #include <asm/mmu_context.h>
 #include <linux/interrupt.h>
 #include <linux/completion.h>
+#include <linux/percpu.h>
 #include <linux/kernel_stat.h>
 #include <linux/security.h>
 #include <linux/notifier.h>
@@ -158,12 +159,33 @@
 
 static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
 
+/* Fake initialization to work around compiler breakage */
+DEFINE_PER_CPU(long, cpu_quiescent) = 0L;
+
 #define cpu_rq(cpu)		(runqueues + (cpu))
 #define this_rq()		cpu_rq(smp_processor_id())
 #define task_rq(p)		cpu_rq(task_cpu(p))
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define rt_task(p)		((p)->prio < MAX_RT_PRIO)
 
+#ifdef CONFIG_PREEMPT
+/* Fake initialization to work around compiler breakage */
+DEFINE_PER_CPU(atomic_t[2], rcu_preempt_cntr) = 
+			{ATOMIC_INIT(0), ATOMIC_INIT(0)};
+DEFINE_PER_CPU(atomic_t, *curr_preempt_cntr) = NULL;
+DEFINE_PER_CPU(atomic_t, *next_preempt_cntr) = NULL;
+static inline void rcu_init_preempt_cntr(int cpu)
+{
+
+	atomic_set(&(per_cpu(rcu_preempt_cntr, cpu)[0]), 0);
+	atomic_set(&(per_cpu(rcu_preempt_cntr, cpu)[1]), 0);
+	per_cpu(curr_preempt_cntr, cpu) = 
+			&(per_cpu(rcu_preempt_cntr, cpu)[1]);
+	per_cpu(next_preempt_cntr, cpu) = 
+			&(per_cpu(rcu_preempt_cntr, cpu)[0]);
+}
+#endif
+
 /*
  * Default context-switch locking:
  */
@@ -858,6 +880,10 @@
 	runqueue_t *rq = this_rq();
 	task_t *p = current;
 
+	if (user_ticks ||
+            (idle_cpu(cpu) && !in_softirq() && hardirq_count() <= 1))
+		per_cpu(cpu_quiescent, cpu)++;
+
 	if (p == rq->idle) {
 		/* note: this timer irq context must be accounted for as well */
 		if (irq_count() - HARDIRQ_OFFSET >= SOFTIRQ_OFFSET)
@@ -961,6 +987,8 @@
 	 */
 	if (unlikely(preempt_count() & PREEMPT_ACTIVE))
 		goto pick_next_task;
+	else
+		rcu_preempt_put();
 
 	switch (prev->state) {
 	case TASK_INTERRUPTIBLE:
@@ -1003,6 +1031,7 @@
 switch_tasks:
 	prefetch(next);
 	clear_tsk_need_resched(prev);
+	per_cpu(cpu_quiescent, prev->thread_info->cpu)++;
 
 	if (likely(prev != next)) {
 		rq->nr_switches++;
@@ -1041,6 +1070,7 @@
 
 need_resched:
 	ti->preempt_count = PREEMPT_ACTIVE;
+	rcu_preempt_get();
 	schedule();
 	ti->preempt_count = 0;
 
@@ -1269,6 +1299,18 @@
 	task_rq_unlock(rq, &flags);
 }
 
+void force_cpu_reschedule(int cpu)
+{
+	struct runqueue *rq;
+
+	rq = cpu_rq(cpu);
+	/* Need to save flags if someday called from irq context */
+	spin_lock_irq(&rq->lock);
+	resched_task(rq->curr);
+	spin_unlock_irq(&rq->lock);
+}
+
+
 #ifndef __alpha__
 
 /*
@@ -2108,6 +2150,7 @@
 		rq->expired = rq->arrays + 1;
 		spin_lock_init(&rq->lock);
 		INIT_LIST_HEAD(&rq->migration_queue);
+		rcu_init_preempt_cntr(i);
 
 		for (j = 0; j < 2; j++) {
 			array = rq->arrays + j;
