Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291692AbSBHSKO>; Fri, 8 Feb 2002 13:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291693AbSBHSJ4>; Fri, 8 Feb 2002 13:09:56 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:24062 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S291692AbSBHSJm>;
	Fri, 8 Feb 2002 13:09:42 -0500
Date: Fri, 8 Feb 2002 23:42:17 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
        Paul McKenney <paul.mckenney@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Read-Copy Update 2.5.4-pre2
Message-ID: <20020208234217.A18466@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Will you consider this simple RCU implementation for inclusion
into your 2.5 tree ? This is essentially the rcu_poll patch that
has been a part of Andrea's aa series of kernels for a while.

Read-Copy Update mutual exclusion mechanism has been discussed
in lkml in the past. Currently there are several potential 
applications of RCU that are being developed and some of them look 
very promising. Our revamped webpage 
(http://lse.sourceforge.net/locking/rcupdate.html)
documents these as well as various approaches to RCU.
The RCU howto (http://lse.sourceforge.net/locking/rcu/HOWTO)
describes how to use RCU along with an example.

rcu_poll uses a simple global list to maintain RCU callbacks
and a per-cpu context switch counter to monitor the each
CPU passing through a "quiescent" state. When needed it
forces all CPUs to reschedule thereby completing a
quiescent cycle, after which the RCU callbacks can be invoked.
The patch is fairly safe as it has only a per-cpu counter
increment in the fast path. It has been tested both UP and
SMP with LTP.

Also, any suggestion you may have regarding the direction
we should take would be greatly appreciated.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.

rcu_poll-2.5.4-pre2-1.patch
---------------------------

diff -urN linux-2.5.4-pre2/include/linux/rcupdate.h linux-2.5.4-pre2-rcu_poll/include/linux/rcupdate.h
--- linux-2.5.4-pre2/include/linux/rcupdate.h	Thu Jan  1 05:30:00 1970
+++ linux-2.5.4-pre2-rcu_poll/include/linux/rcupdate.h	Fri Feb  8 22:00:32 2002
@@ -0,0 +1,67 @@
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
+/*
+ * This should go away with per-CPU area patch, otherwise waste the cacheline
+ */
+struct rcu_data {
+	long	quiescent;
+} ____cacheline_aligned_in_smp;
+extern struct rcu_data rcu_data[];
+#define RCU_quiescent(cpu)  rcu_data[(cpu)].quiescent
+
+extern void FASTCALL(call_rcu(struct rcu_head *head, void (*func)(void *arg), void *arg));
+extern void synchronize_kernel(void);
+
+extern void rcu_init(void);
+
+#endif /* __LINUX_RCUPDATE_H */
diff -urN linux-2.5.4-pre2/include/linux/sched.h linux-2.5.4-pre2-rcu_poll/include/linux/sched.h
--- linux-2.5.4-pre2/include/linux/sched.h	Fri Feb  8 21:45:23 2002
+++ linux-2.5.4-pre2-rcu_poll/include/linux/sched.h	Fri Feb  8 22:00:32 2002
@@ -161,6 +161,7 @@
 extern void flush_scheduled_tasks(void);
 extern int start_context_thread(void);
 extern int current_is_keventd(void);
+extern void force_cpu_reschedule(int cpu);
 
 struct namespace;
 
diff -urN linux-2.5.4-pre2/init/main.c linux-2.5.4-pre2-rcu_poll/init/main.c
--- linux-2.5.4-pre2/init/main.c	Fri Feb  8 21:45:23 2002
+++ linux-2.5.4-pre2-rcu_poll/init/main.c	Fri Feb  8 21:48:05 2002
@@ -27,6 +27,7 @@
 #include <linux/iobuf.h>
 #include <linux/bootmem.h>
 #include <linux/tty.h>
+#include <linux/rcupdate.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -317,6 +318,7 @@
 	printk("Kernel command line: %s\n", saved_command_line);
 	parse_options(command_line);
 	trap_init();
+	rcu_init();
 	init_IRQ();
 	sched_init();
 	softirq_init();
diff -urN linux-2.5.4-pre2/kernel/Makefile linux-2.5.4-pre2-rcu_poll/kernel/Makefile
--- linux-2.5.4-pre2/kernel/Makefile	Fri Jan 25 03:37:46 2002
+++ linux-2.5.4-pre2-rcu_poll/kernel/Makefile	Fri Feb  8 21:48:05 2002
@@ -10,12 +10,12 @@
 O_TARGET := kernel.o
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o 
+		printk.o  rcupdate.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
 	    sysctl.o acct.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o 
+	    signal.o sys.o kmod.o context.o rcupdate.o
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
diff -urN linux-2.5.4-pre2/kernel/rcupdate.c linux-2.5.4-pre2-rcu_poll/kernel/rcupdate.c
--- linux-2.5.4-pre2/kernel/rcupdate.c	Thu Jan  1 05:30:00 1970
+++ linux-2.5.4-pre2-rcu_poll/kernel/rcupdate.c	Fri Feb  8 21:48:05 2002
@@ -0,0 +1,214 @@
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
+struct rcu_data rcu_data[NR_CPUS] __cacheline_aligned;
+
+/*
+ * Register a new rcu callback. This will be invoked as soon
+ * as all CPUs have performed a context switch or been seen in the
+ * idle loop or in a user process.
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
+			if (cpu != smp_processor_id()) {
+				rcu_qsmask |= 1UL << cpu;
+				rcu_quiescent_checkpoint[cpu] = RCU_quiescent(cpu);
+				force_cpu_reschedule(cpu);
+			}
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
+			if (rcu_quiescent_checkpoint[cpu] != RCU_quiescent(cpu))
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
diff -urN linux-2.5.4-pre2/kernel/sched.c linux-2.5.4-pre2-rcu_poll/kernel/sched.c
--- linux-2.5.4-pre2/kernel/sched.c	Tue Jan 29 04:42:47 2002
+++ linux-2.5.4-pre2-rcu_poll/kernel/sched.c	Fri Feb  8 21:48:05 2002
@@ -18,6 +18,7 @@
 #include <asm/uaccess.h>
 #include <linux/smp_lock.h>
 #include <linux/interrupt.h>
+#include <linux/rcupdate.h>
 #include <asm/mmu_context.h>
 
 #define BITMAP_SIZE ((((MAX_PRIO+7)/8)+sizeof(long)-1)/sizeof(long))
@@ -685,6 +686,7 @@
 switch_tasks:
 	prefetch(next);
 	prev->work.need_resched = 0;
+ 	RCU_quiescent(prev->cpu)++;
 
 	if (likely(prev != next)) {
 		rq->nr_switches++;
@@ -910,6 +912,21 @@
 	unlock_task_rq(rq, &flags);
 }
 
+void force_cpu_reschedule(int cpu)
+{
+	unsigned long flags;
+	struct runqueue *rq, *newrq;
+	struct task_struct *p;
+
+	rq = cpu_rq(cpu);
+	p = rq->curr;
+	newrq = lock_task_rq(p, &flags);
+	if (newrq == rq)
+		resched_task(p);
+	unlock_task_rq(newrq, &flags);
+}
+
+
 #ifndef __alpha__
 
 /*
