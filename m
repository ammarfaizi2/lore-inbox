Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289025AbSCGBIo>; Wed, 6 Mar 2002 20:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289026AbSCGBIf>; Wed, 6 Mar 2002 20:08:35 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:62731 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S289025AbSCGBIY>; Wed, 6 Mar 2002 20:08:24 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] User per-cpu data in softirq.c
Date: Thu, 07 Mar 2002 12:11:41 +1100
Message-Id: <E16imRa-0001kr-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

This makes tasklet_vec and tasklet_hi_vec static inside softirq.c (the
only place they are accessed), and makes them __per_cpu_data.

Thanks,
Rusty.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.3-pre6-percpu/include/linux/interrupt.h working-2.5.3-pre6-percpu-tasklet/include/linux/interrupt.h
--- working-2.5.3-pre6-percpu/include/linux/interrupt.h	Thu Jan 17 16:35:24 2002
+++ working-2.5.3-pre6-percpu-tasklet/include/linux/interrupt.h	Wed Jan 30 12:00:08 2002
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.3-pre6-percpu/kernel/ksyms.c working-2.5.3-pre6-percpu-tasklet/kernel/ksyms.c
--- working-2.5.3-pre6-percpu/kernel/ksyms.c	Tue Jan 29 09:17:09 2002
+++ working-2.5.3-pre6-percpu-tasklet/kernel/ksyms.c	Wed Jan 30 12:00:16 2002
@@ -542,8 +542,6 @@
 EXPORT_SYMBOL(strsep);
 
 /* software interrupts */
-EXPORT_SYMBOL(tasklet_hi_vec);
-EXPORT_SYMBOL(tasklet_vec);
 EXPORT_SYMBOL(bh_task_vec);
 EXPORT_SYMBOL(init_bh);
 EXPORT_SYMBOL(remove_bh);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.3-pre6-percpu/kernel/softirq.c working-2.5.3-pre6-percpu-tasklet/kernel/softirq.c
--- working-2.5.3-pre6-percpu/kernel/softirq.c	Tue Jan 29 09:17:09 2002
+++ working-2.5.3-pre6-percpu-tasklet/kernel/softirq.c	Wed Jan 30 12:34:12 2002
@@ -145,9 +145,13 @@
 
 
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
@@ -155,8 +159,8 @@
 	unsigned long flags;
 
 	local_irq_save(flags);
-	t->next = tasklet_vec[cpu].list;
-	tasklet_vec[cpu].list = t;
+	t->next = per_cpu(tasklet_vec, cpu).list;
+	per_cpu(tasklet_vec, cpu).list = t;
 	cpu_raise_softirq(cpu, TASKLET_SOFTIRQ);
 	local_irq_restore(flags);
 }
@@ -167,8 +171,8 @@
 	unsigned long flags;
 
 	local_irq_save(flags);
-	t->next = tasklet_hi_vec[cpu].list;
-	tasklet_hi_vec[cpu].list = t;
+	t->next = per_cpu(tasklet_hi_vec, cpu).list;
+	per_cpu(tasklet_hi_vec, cpu).list = t;
 	cpu_raise_softirq(cpu, HI_SOFTIRQ);
 	local_irq_restore(flags);
 }
@@ -179,8 +183,8 @@
 	struct tasklet_struct *list;
 
 	local_irq_disable();
-	list = tasklet_vec[cpu].list;
-	tasklet_vec[cpu].list = NULL;
+	list = per_cpu(tasklet_vec, cpu).list;
+	per_cpu(tasklet_vec, cpu).list = NULL;
 	local_irq_enable();
 
 	while (list) {
@@ -200,8 +204,8 @@
 		}
 
 		local_irq_disable();
-		t->next = tasklet_vec[cpu].list;
-		tasklet_vec[cpu].list = t;
+		t->next = per_cpu(tasklet_vec, cpu).list;
+		per_cpu(tasklet_vec, cpu).list = t;
 		__cpu_raise_softirq(cpu, TASKLET_SOFTIRQ);
 		local_irq_enable();
 	}
@@ -213,8 +217,8 @@
 	struct tasklet_struct *list;
 
 	local_irq_disable();
-	list = tasklet_hi_vec[cpu].list;
-	tasklet_hi_vec[cpu].list = NULL;
+	list = per_cpu(tasklet_hi_vec, cpu).list;
+	per_cpu(tasklet_hi_vec, cpu).list = NULL;
 	local_irq_enable();
 
 	while (list) {
@@ -234,8 +238,8 @@
 		}
 
 		local_irq_disable();
-		t->next = tasklet_hi_vec[cpu].list;
-		tasklet_hi_vec[cpu].list = t;
+		t->next = per_cpu(tasklet_hi_vec, cpu).list;
+		per_cpu(tasklet_hi_vec, cpu).list = t;
 		__cpu_raise_softirq(cpu, HI_SOFTIRQ);
 		local_irq_enable();
 	}

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
