Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266602AbTGFDbL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 23:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266603AbTGFDbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 23:31:10 -0400
Received: from dp.samba.org ([66.70.73.150]:64648 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266602AbTGFDbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 23:31:06 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Daily per-cpu patch: kstat_this_cpu
Date: Sun, 06 Jul 2003 13:41:03 +1000
Message-Id: <20030706034538.817882C0EF@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kstat_this_cpu() is defined in terms of per_cpu instead of __get_cpu_var.
This patch changes that, and uses it everywhere appropriate.

Name: Make kstat_this_cpu in terms of __get_cpu_var and use it
Author: Rusty Russell
Status: Tested on 2.5.74-bk1

D: kstat_this_cpu() is defined in terms of per_cpu instead of __get_cpu_var.
D: This patch changes that, and uses it everywhere appropriate.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .19878-linux-2.5.74-bk1/arch/i386/kernel/irq.c .19878-linux-2.5.74-bk1.updated/arch/i386/kernel/irq.c
--- .19878-linux-2.5.74-bk1/arch/i386/kernel/irq.c	2003-06-15 11:29:47.000000000 +1000
+++ .19878-linux-2.5.74-bk1.updated/arch/i386/kernel/irq.c	2003-07-04 11:40:36.000000000 +1000
@@ -416,7 +416,6 @@ asmlinkage unsigned int do_IRQ(struct pt
 	 * handled by some other CPU. (or is disabled)
 	 */
 	int irq = regs.orig_eax & 0xff; /* high bits used in ret_from_ code  */
-	int cpu = smp_processor_id();
 	irq_desc_t *desc = irq_desc + irq;
 	struct irqaction * action;
 	unsigned int status;
@@ -437,7 +436,7 @@ asmlinkage unsigned int do_IRQ(struct pt
 		}
 	}
 #endif
-	kstat_cpu(cpu).irqs[irq]++;
+	kstat_this_cpu.irqs[irq]++;
 	spin_lock(&desc->lock);
 	desc->handler->ack(irq);
 	/*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .19878-linux-2.5.74-bk1/include/linux/kernel_stat.h .19878-linux-2.5.74-bk1.updated/include/linux/kernel_stat.h
--- .19878-linux-2.5.74-bk1/include/linux/kernel_stat.h	2003-02-07 19:17:07.000000000 +1100
+++ .19878-linux-2.5.74-bk1.updated/include/linux/kernel_stat.h	2003-07-04 11:39:39.000000000 +1000
@@ -31,7 +31,8 @@ struct kernel_stat {
 DECLARE_PER_CPU(struct kernel_stat, kstat);
 
 #define kstat_cpu(cpu)	per_cpu(kstat, cpu)
-#define kstat_this_cpu	kstat_cpu(smp_processor_id())
+/* Must have preemption disabled for this to be meaningful. */
+#define kstat_this_cpu	__get_cpu_var(kstat)
 
 extern unsigned long nr_context_switches(void);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .19878-linux-2.5.74-bk1/kernel/sched.c .19878-linux-2.5.74-bk1.updated/kernel/sched.c
--- .19878-linux-2.5.74-bk1/kernel/sched.c	2003-07-03 09:44:01.000000000 +1000
+++ .19878-linux-2.5.74-bk1.updated/kernel/sched.c	2003-07-04 11:39:39.000000000 +1000
@@ -1184,19 +1184,19 @@ void scheduler_tick(int user_ticks, int 
 	if (p == rq->idle) {
 		/* note: this timer irq context must be accounted for as well */
 		if (irq_count() - HARDIRQ_OFFSET >= SOFTIRQ_OFFSET)
-			kstat_cpu(cpu).cpustat.system += sys_ticks;
+			kstat_this_cpu.cpustat.system += sys_ticks;
 		else if (atomic_read(&rq->nr_iowait) > 0)
-			kstat_cpu(cpu).cpustat.iowait += sys_ticks;
+			kstat_this_cpu.cpustat.iowait += sys_ticks;
 		else
-			kstat_cpu(cpu).cpustat.idle += sys_ticks;
+			kstat_this_cpu.cpustat.idle += sys_ticks;
 		rebalance_tick(rq, 1);
 		return;
 	}
 	if (TASK_NICE(p) > 0)
-		kstat_cpu(cpu).cpustat.nice += user_ticks;
+		kstat_this_cpu.cpustat.nice += user_ticks;
 	else
-		kstat_cpu(cpu).cpustat.user += user_ticks;
-	kstat_cpu(cpu).cpustat.system += sys_ticks;
+		kstat_this_cpu.cpustat.user += user_ticks;
+	kstat_this_cpu.cpustat.system += sys_ticks;
 
 	/* Task might have expired already, but not scheduled off yet */
 	if (p->array != rq->active) {

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
