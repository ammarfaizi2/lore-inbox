Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264722AbTGGFku (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 01:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264695AbTGGFku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 01:40:50 -0400
Received: from dp.samba.org ([66.70.73.150]:664 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266834AbTGGFkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 01:40:43 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@rustcorp.com.au
Subject: Re: [PATCH] kstat_this_cpu in terms of __get_cpu_var and use it 
In-reply-to: Your message of "Thu, 03 Jul 2003 19:24:21 MST."
             <Pine.LNX.4.44.0307031923230.3664-100000@home.osdl.org> 
Date: Mon, 07 Jul 2003 15:32:18 +1000
Message-Id: <20030707055517.2548A2C135@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0307031923230.3664-100000@home.osdl.org> you write:
> 
> On Fri, 4 Jul 2003, Rusty Russell wrote:
> > 
> > kstat_this_cpu() is defined in terms of per_cpu instead of __get_cpu_var.
> > This patch changes that, and uses it where appropriate.
> 
> This makes some things much slower, since we'll re-compute the cpu number 
> over and over and over again.

Not quite, even on i386.

I did actually test the gcc 3.3 x86 output on other examples: it's
quite happy to optimize away multiple
__per_cpu_offset[smp_processor_id()] references.

Unfortunately (for my argument), you're right here: gcc doesn't cover
itself in glory.  For example, the old case calculated "current" 4
times, the new case does it 6 times (if were recalculated every time,
it would be 9 times, so it's not completely hopeless).

So this version of the patch explicitly puts the kstat in a local
variable.  It's smaller (and presumably faster) than the original:
clearly, noone was so anal about the original code.

Hope this helps!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Make kstat_this_cpu in terms of __get_cpu_var and use it
Author: Rusty Russell
Status: Tested on 2.5.74-bk1

D: kstat_this_cpu() is defined in terms of per_cpu instead of __get_cpu_var.
D: This patch changes that, and uses it everywhere appropriate.  The sched.c
D: change puts it in a local variable, which helps gcc generate better code.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.74-bk4/arch/i386/kernel/irq.c working-2.5.74-bk4-kstat-percpu/arch/i386/kernel/irq.c
--- linux-2.5.74-bk4/arch/i386/kernel/irq.c	2003-06-15 11:29:47.000000000 +1000
+++ working-2.5.74-bk4-kstat-percpu/arch/i386/kernel/irq.c	2003-07-07 14:03:14.000000000 +1000
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.74-bk4/include/linux/kernel_stat.h working-2.5.74-bk4-kstat-percpu/include/linux/kernel_stat.h
--- linux-2.5.74-bk4/include/linux/kernel_stat.h	2003-02-07 19:17:07.000000000 +1100
+++ working-2.5.74-bk4-kstat-percpu/include/linux/kernel_stat.h	2003-07-07 14:03:14.000000000 +1000
@@ -31,7 +31,8 @@ struct kernel_stat {
 DECLARE_PER_CPU(struct kernel_stat, kstat);
 
 #define kstat_cpu(cpu)	per_cpu(kstat, cpu)
-#define kstat_this_cpu	kstat_cpu(smp_processor_id())
+/* Must have preemption disabled for this to be meaningful. */
+#define kstat_this_cpu	__get_cpu_var(kstat)
 
 extern unsigned long nr_context_switches(void);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.74-bk4/kernel/sched.c working-2.5.74-bk4-kstat-percpu/kernel/sched.c
--- linux-2.5.74-bk4/kernel/sched.c	2003-07-03 09:44:01.000000000 +1000
+++ working-2.5.74-bk4-kstat-percpu/kernel/sched.c	2003-07-07 15:18:20.000000000 +1000
@@ -1175,6 +1176,7 @@ DEFINE_PER_CPU(struct kernel_stat, kstat
 void scheduler_tick(int user_ticks, int sys_ticks)
 {
 	int cpu = smp_processor_id();
+	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
 	runqueue_t *rq = this_rq();
 	task_t *p = current;
 
@@ -1184,19 +1186,19 @@ void scheduler_tick(int user_ticks, int 
 	if (p == rq->idle) {
 		/* note: this timer irq context must be accounted for as well */
 		if (irq_count() - HARDIRQ_OFFSET >= SOFTIRQ_OFFSET)
-			kstat_cpu(cpu).cpustat.system += sys_ticks;
+			cpustat->system += sys_ticks;
 		else if (atomic_read(&rq->nr_iowait) > 0)
-			kstat_cpu(cpu).cpustat.iowait += sys_ticks;
+			cpustat->iowait += sys_ticks;
 		else
-			kstat_cpu(cpu).cpustat.idle += sys_ticks;
+			cpustat->idle += sys_ticks;
 		rebalance_tick(rq, 1);
 		return;
 	}
 	if (TASK_NICE(p) > 0)
-		kstat_cpu(cpu).cpustat.nice += user_ticks;
+		cpustat->nice += user_ticks;
 	else
-		kstat_cpu(cpu).cpustat.user += user_ticks;
-	kstat_cpu(cpu).cpustat.system += sys_ticks;
+		cpustat->user += user_ticks;
+	cpustat->system += sys_ticks;
 
 	/* Task might have expired already, but not scheduled off yet */
 	if (p->array != rq->active) {
