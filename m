Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272385AbRIKLD6>; Tue, 11 Sep 2001 07:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272393AbRIKLDt>; Tue, 11 Sep 2001 07:03:49 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:18458 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S272385AbRIKLDc>; Tue, 11 Sep 2001 07:03:32 -0400
Date: Tue, 11 Sep 2001 13:04:30 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: hch@caldera.de, linux-kernel@vger.kernel.org,
        Paul Mckenney <paul.mckenney@us.ibm.com>
Subject: Re: 2.4.10pre7aa1
Message-ID: <20010911130430.L715@athlon.random>
In-Reply-To: <20010911142158.A1537@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010911142158.A1537@in.ibm.com>; from dipankar@in.ibm.com on Tue, Sep 11, 2001 at 02:21:58PM +0530
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2001 at 02:21:58PM +0530, Dipankar Sarma wrote:
> Hi Christoph,
> 
> In article <20010910205250.B22889@caldera.de> you wrote:
> 
> > Hmm, I don't see why latency is important for rcu - we only want to
> > free datastructures.. (mm load?).
> 
> While it is not important for RCU to do the updates quickly, it is
> still necessary that updates are not completely starved out by
> high-priority tasks. So, the idea behind using high-priority
> krcuds is to ensure that they don't get starved thereby delaying
> updates for unreasonably long periods of time which could lead
> to memory pressure or other performance problems depending on
> how RCU is being used. 

good point.

> I agree that it is not always a good idea to use kernel threads for
> everything, but in this case this seems to be the safest and
> most reasonable option.

pretty much agreed.

BTW, I fixed a few more issues in the rcu patch (grep for
down_interruptible for instance), here an updated patch (will be
included in 2.4.10pre8aa1 [or later -aa]) with the name of rcu-2.

diff -urN 2.4.10pre8/include/linux/rcupdate.h rcu/include/linux/rcupdate.h
--- 2.4.10pre8/include/linux/rcupdate.h	Thu Jan  1 01:00:00 1970
+++ rcu/include/linux/rcupdate.h	Tue Sep 11 06:14:17 2001
@@ -0,0 +1,48 @@
+/*
+ * Read-Copy Update mechanism for Linux
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
+ * For detailed explanation of Read-Copy Update mechanism see -
+ *              http://lse.sourceforge.net/locking/rcupdate.html
+ *
+ */
+
+#ifndef _LINUX_RCUPDATE_H
+#define _LINUX_RCUPDATE_H
+
+#include <linux/malloc.h>
+#include <linux/vmalloc.h>
+#include <linux/cache.h>
+#include <asm/semaphore.h>
+
+struct rcu_data {
+	struct task_struct *krcud_task;
+	struct semaphore krcud_sema;
+} ____cacheline_aligned_in_smp;
+
+#define krcud_task(cpu) rcu_data[(cpu)].krcud_task
+#define krcud_sema(cpu) rcu_data[(cpu)].krcud_sema
+
+struct rcu_head
+{
+	struct list_head list;
+	void (*func)(void * arg);
+	void * arg;
+};
+
+extern void call_rcu(struct rcu_head * head, void (*func)(void * arg), void * arg);
+
+#endif
diff -urN 2.4.10pre8/kernel/Makefile rcu/kernel/Makefile
--- 2.4.10pre8/kernel/Makefile	Tue Sep 11 04:10:03 2001
+++ rcu/kernel/Makefile	Tue Sep 11 06:14:17 2001
@@ -9,12 +9,12 @@
 
 O_TARGET := kernel.o
 
-export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o
+export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o rcupdate.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
 	    sysctl.o acct.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o
+	    signal.o sys.o kmod.o context.o rcupdate.o
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
diff -urN 2.4.10pre8/kernel/rcupdate.c rcu/kernel/rcupdate.c
--- 2.4.10pre8/kernel/rcupdate.c	Thu Jan  1 01:00:00 1970
+++ rcu/kernel/rcupdate.c	Tue Sep 11 06:16:39 2001
@@ -0,0 +1,165 @@
+/*
+ * Read-Copy Update mechanism for Linux
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
+ * For detailed explanation of Read-Copy Update mechanism see -
+ *              http://lse.sourceforge.net/locking/rcupdate.html
+ *
+ */
+
+#include <linux/rcupdate.h>
+#include <linux/spinlock.h>
+#include <linux/tqueue.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/tqueue.h>
+
+asmlinkage long sys_sched_get_priority_max(int policy);
+
+static spinlock_t rcu_lock = SPIN_LOCK_UNLOCKED;
+static struct list_head rcu_wait_list;
+static struct tq_struct rcu_task;
+static struct semaphore rcu_sema;
+static struct rcu_data rcu_data[NR_CPUS];
+
+/*
+ * Wait for all the CPUs to go through a quiescent state. It assumes
+ * that current CPU doesn't have any reference to RCU protected
+ * data and thus has already undergone a quiescent state since update.
+ */
+static void wait_for_rcu(void)
+{
+	int cpu;
+	int count;
+
+        for (cpu = 0; cpu < smp_num_cpus; cpu++) {
+                if (cpu == smp_processor_id())
+                        continue;
+                up(&krcud_sema(cpu));
+	}
+	count = 0;
+	while (count++ < smp_num_cpus - 1)
+		down(&rcu_sema);
+}
+
+/*
+ * Process a batch of RCU callbacks (the batch can be empty).
+ * There can be only one batch processed at any point of time.
+ */
+static void process_pending_rcus(void *arg)
+{
+	LIST_HEAD(rcu_current_list);
+	struct list_head * entry;
+
+	spin_lock_irq(&rcu_lock);
+	list_splice(&rcu_wait_list, rcu_current_list.prev);
+	INIT_LIST_HEAD(&rcu_wait_list);
+	spin_unlock_irq(&rcu_lock);
+
+	wait_for_rcu();
+
+	while ((entry = rcu_current_list.prev) != &rcu_current_list) {
+		struct rcu_head * head;
+
+		list_del(entry);
+		head = list_entry(entry, struct rcu_head, list);
+		head->func(head->arg);
+	}
+}
+
+/*
+ * Register a RCU callback to be invoked after all CPUs have
+ * gone through a quiescent state.
+ */
+void call_rcu(struct rcu_head * head, void (*func)(void * arg), void * arg)
+{
+	unsigned long flags;
+	int start = 0;
+
+	head->func = func;
+	head->arg = arg;
+
+	spin_lock_irqsave(&rcu_lock, flags);
+	if (list_empty(&rcu_wait_list))
+		start = 1;
+	list_add(&head->list, &rcu_wait_list);
+	spin_unlock_irqrestore(&rcu_lock, flags);
+
+	if (start)
+		schedule_task(&rcu_task);
+}
+
+/*
+ * Per-CPU RCU dameon. It runs at an absurdly high priority so
+ * that it is not starved out by the scheduler thereby holding
+ * up RC updates.
+ */
+static int krcud(void * __bind_cpu)
+{
+	int bind_cpu = *(int *) __bind_cpu;
+	int cpu = cpu_logical_map(bind_cpu);
+
+	daemonize();
+        current->policy = SCHED_FIFO;
+        current->rt_priority = 1001 + sys_sched_get_priority_max(SCHED_FIFO);
+
+	sigfillset(&current->blocked);
+
+	/* Migrate to the right CPU */
+	current->cpus_allowed = 1UL << cpu;
+	while (smp_processor_id() != cpu)
+		schedule();
+
+	sprintf(current->comm, "krcud_CPU%d", bind_cpu);
+	sema_init(&krcud_sema(cpu), 0);
+
+	krcud_task(cpu) = current;
+
+	for (;;) {
+		while (down_interruptible(&krcud_sema(cpu)));
+		up(&rcu_sema);
+	}
+}
+
+static void spawn_krcud(void)
+{
+	int cpu;
+
+	for (cpu = 0; cpu < smp_num_cpus; cpu++) {
+		if (kernel_thread(krcud, (void *) &cpu,
+				  CLONE_FS | CLONE_FILES | CLONE_SIGNAL) < 0)
+			printk("spawn_krcud() failed for cpu %d\n", cpu);
+		else {
+			while (!krcud_task(cpu_logical_map(cpu))) {
+				current->policy |= SCHED_YIELD;
+				schedule();
+			}
+		}
+	}
+}
+
+static __init int rcu_init(void)
+{
+	sema_init(&rcu_sema, 0);
+	rcu_task.routine = process_pending_rcus;
+	spawn_krcud();
+	return 0;
+}
+
+__initcall(rcu_init);
+
+EXPORT_SYMBOL(call_rcu);

Andrea
