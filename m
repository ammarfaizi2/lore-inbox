Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316533AbSEUHhL>; Tue, 21 May 2002 03:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316538AbSEUHhK>; Tue, 21 May 2002 03:37:10 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:48051 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S316533AbSEUHhI>; Tue, 21 May 2002 03:37:08 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, kuznet@ms2.inr.ac.ru
Subject: [PATCH] Tasklet cleanup
Date: Tue, 21 May 2002 17:40:55 +1000
Message-Id: <E17A4GO-0003uj-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey, not sure why you exported tasklet_vec & tasklet_hi_vec?  Noone
uses them...

Name: Tasklet Per-CPU Cleanup Patch
Author: Rusty Russell
Status: Cleanup

D: This makes tasklet_vec and tasklet_hi_vec static inside softirq.c, and
D: makes them __per_cpu_data.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7-pre1/include/linux/interrupt.h working-2.5.7-pre1-percpu-sched/include/linux/interrupt.h
--- linux-2.5.7-pre1/include/linux/interrupt.h	Fri Mar 15 13:01:00 2002
+++ working-2.5.7-pre1-percpu-sched/include/linux/interrupt.h	Fri Mar 15 14:02:23 2002
@@ -124,14 +124,6 @@
 	TASKLET_STATE_RUN	/* Tasklet is running (SMP only) */
 };
 
-struct tasklet_head
-{
-	struct tasklet_struct *list;
-} __attribute__ ((__aligned__(SMP_CACHE_BYTES)));
-
-extern struct tasklet_head tasklet_vec[NR_CPUS];
-extern struct tasklet_head tasklet_hi_vec[NR_CPUS];
-
 #ifdef CONFIG_SMP
 static inline int tasklet_trylock(struct tasklet_struct *t)
 {
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7-pre1/kernel/ksyms.c working-2.5.7-pre1-percpu-sched/kernel/ksyms.c
--- linux-2.5.7-pre1/kernel/ksyms.c	Wed Mar 13 13:30:39 2002
+++ working-2.5.7-pre1-percpu-sched/kernel/ksyms.c	Fri Mar 15 14:11:36 2002
@@ -565,8 +565,6 @@
 EXPORT_SYMBOL(strsep);
 
 /* software interrupts */
-EXPORT_SYMBOL(tasklet_hi_vec);
-EXPORT_SYMBOL(tasklet_vec);
 EXPORT_SYMBOL(bh_task_vec);
 EXPORT_SYMBOL(init_bh);
 EXPORT_SYMBOL(remove_bh);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7-pre1/kernel/softirq.c working-2.5.7-pre1-percpu-sched/kernel/softirq.c
--- linux-2.5.7-pre1/kernel/softirq.c	Wed Feb 20 17:56:17 2002
+++ working-2.5.7-pre1-percpu-sched/kernel/softirq.c	Fri Mar 15 14:02:45 2002
@@ -16,6 +16,7 @@
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/tqueue.h>
+#include <linux/percpu.h>
 
 /*
    - No shared variables, all the data are CPU local.
@@ -145,42 +146,43 @@
 
 
 /* Tasklets */
+struct tasklet_head
+{
+	struct tasklet_struct *list;
+};
 
-struct tasklet_head tasklet_vec[NR_CPUS] __cacheline_aligned_in_smp;
-struct tasklet_head tasklet_hi_vec[NR_CPUS] __cacheline_aligned_in_smp;
+static struct tasklet_head tasklet_vec __per_cpu_data;
+static struct tasklet_head tasklet_hi_vec __per_cpu_data;
 
 void __tasklet_schedule(struct tasklet_struct *t)
 {
-	int cpu = smp_processor_id();
 	unsigned long flags;
 
 	local_irq_save(flags);
-	t->next = tasklet_vec[cpu].list;
-	tasklet_vec[cpu].list = t;
-	cpu_raise_softirq(cpu, TASKLET_SOFTIRQ);
+	t->next = this_cpu(tasklet_vec).list;
+	this_cpu(tasklet_vec).list = t;
+	cpu_raise_softirq(smp_processor_id(), TASKLET_SOFTIRQ);
 	local_irq_restore(flags);
 }
 
 void __tasklet_hi_schedule(struct tasklet_struct *t)
 {
-	int cpu = smp_processor_id();
 	unsigned long flags;
 
 	local_irq_save(flags);
-	t->next = tasklet_hi_vec[cpu].list;
-	tasklet_hi_vec[cpu].list = t;
-	cpu_raise_softirq(cpu, HI_SOFTIRQ);
+	t->next = this_cpu(tasklet_hi_vec).list;
+	this_cpu(tasklet_hi_vec).list = t;
+	cpu_raise_softirq(smp_processor_id(), HI_SOFTIRQ);
 	local_irq_restore(flags);
 }
 
 static void tasklet_action(struct softirq_action *a)
 {
-	int cpu = smp_processor_id();
 	struct tasklet_struct *list;
 
 	local_irq_disable();
-	list = tasklet_vec[cpu].list;
-	tasklet_vec[cpu].list = NULL;
+	list = this_cpu(tasklet_vec).list;
+	this_cpu(tasklet_vec).list = NULL;
 	local_irq_enable();
 
 	while (list) {
@@ -200,21 +202,20 @@
 		}
 
 		local_irq_disable();
-		t->next = tasklet_vec[cpu].list;
-		tasklet_vec[cpu].list = t;
-		__cpu_raise_softirq(cpu, TASKLET_SOFTIRQ);
+		t->next = this_cpu(tasklet_vec).list;
+		this_cpu(tasklet_vec).list = t;
+		__cpu_raise_softirq(smp_processor_id(), TASKLET_SOFTIRQ);
 		local_irq_enable();
 	}
 }
 
 static void tasklet_hi_action(struct softirq_action *a)
 {
-	int cpu = smp_processor_id();
 	struct tasklet_struct *list;
 
 	local_irq_disable();
-	list = tasklet_hi_vec[cpu].list;
-	tasklet_hi_vec[cpu].list = NULL;
+	list = this_cpu(tasklet_hi_vec).list;
+	this_cpu(tasklet_hi_vec).list = NULL;
 	local_irq_enable();
 
 	while (list) {
@@ -234,9 +235,9 @@
 		}
 
 		local_irq_disable();
-		t->next = tasklet_hi_vec[cpu].list;
-		tasklet_hi_vec[cpu].list = t;
-		__cpu_raise_softirq(cpu, HI_SOFTIRQ);
+		t->next = this_cpu(tasklet_hi_vec).list;
+		this_cpu(tasklet_hi_vec).list = t;
+		__cpu_raise_softirq(smp_processor_id(), HI_SOFTIRQ);
 		local_irq_enable();
 	}
 }



--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
