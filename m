Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbTGCHzy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 03:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265540AbTGCHzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 03:55:54 -0400
Received: from dp.samba.org ([66.70.73.150]:34541 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265531AbTGCHzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 03:55:51 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] Make ksoftirqd a normal per-cpu variable
Date: Thu, 03 Jul 2003 18:08:55 +1000
Message-Id: <20030703081017.B712A2C0CB@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

Moves the ksoftirqd pointers out of the irq_stat struct, and use a
normal per-cpu variable.  It's not that time critical, nor referenced
in assembler.  This moves us closer to making irq_stat a per-cpu variable.

Because some archs have hardcoded asm references to offsets in this
structure, I haven't touched non-x86.  The __ksoftirqd_task field
is unused in other archs, too.

Name: ksoftirqds in per-cpu variable
Author: Rusty Russell
Status: Tested on 2.5.74
Depends: Percpu/irq_syscall_count_removal.patch.gz

D: Moves the ksoftirqd pointers out of the irq_stat struct, and use a
D: normal per-cpu variable.  It's not that time critical, nor referenced
D: in assembler.  This moves us closer to making irq_stat a per-cpu variable.
D: 
D: Because some archs have hardcoded asm references to offsets in this
D: structure, I haven't touched non-x86.  The __ksoftirqd_task field
D: is unused in other archs, too.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5097-2.5.73-bk8-ksoftirqd_percpu.pre/include/asm-i386/hardirq.h .5097-2.5.73-bk8-ksoftirqd_percpu/include/asm-i386/hardirq.h
--- .5097-2.5.73-bk8-ksoftirqd_percpu.pre/include/asm-i386/hardirq.h	2003-07-01 15:26:58.000000000 +1000
+++ .5097-2.5.73-bk8-ksoftirqd_percpu/include/asm-i386/hardirq.h	2003-07-01 15:26:58.000000000 +1000
@@ -7,7 +7,6 @@
 
 typedef struct {
 	unsigned int __softirq_pending;
-	struct task_struct * __ksoftirqd_task; /* waitqueue is too large */
 	unsigned long idle_timestamp;
 	unsigned int __nmi_count;	/* arch dependent */
 	unsigned int apic_timer_irqs;	/* arch dependent */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5097-2.5.73-bk8-ksoftirqd_percpu.pre/include/linux/irq_cpustat.h .5097-2.5.73-bk8-ksoftirqd_percpu/include/linux/irq_cpustat.h
--- .5097-2.5.73-bk8-ksoftirqd_percpu.pre/include/linux/irq_cpustat.h	2003-07-01 15:26:58.000000000 +1000
+++ .5097-2.5.73-bk8-ksoftirqd_percpu/include/linux/irq_cpustat.h	2003-07-01 15:26:58.000000000 +1000
@@ -29,8 +29,6 @@ extern irq_cpustat_t irq_stat[];		/* def
   /* arch independent irq_stat fields */
 #define softirq_pending(cpu)	__IRQ_STAT((cpu), __softirq_pending)
 #define local_softirq_pending()	softirq_pending(smp_processor_id())
-#define ksoftirqd_task(cpu)	__IRQ_STAT((cpu), __ksoftirqd_task)
-#define local_ksoftirqd_task()	ksoftirqd_task(smp_processor_id())
 
   /* arch dependent irq_stat fields */
 #define nmi_count(cpu)		__IRQ_STAT((cpu), __nmi_count)	/* i386 */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5097-2.5.73-bk8-ksoftirqd_percpu.pre/kernel/softirq.c .5097-2.5.73-bk8-ksoftirqd_percpu/kernel/softirq.c
--- .5097-2.5.73-bk8-ksoftirqd_percpu.pre/kernel/softirq.c	2003-06-15 11:30:11.000000000 +1000
+++ .5097-2.5.73-bk8-ksoftirqd_percpu/kernel/softirq.c	2003-07-01 15:26:58.000000000 +1000
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/notifier.h>
+#include <linux/percpu.h>
 #include <linux/cpu.h>
 
 /*
@@ -41,15 +42,18 @@ EXPORT_SYMBOL(irq_stat);
 
 static struct softirq_action softirq_vec[32] __cacheline_aligned_in_smp;
 
+static DEFINE_PER_CPU(struct task_struct *, ksoftirqd);
+
 /*
  * we cannot loop indefinitely here to avoid userspace starvation,
  * but we also don't want to introduce a worst case 1/HZ latency
  * to the pending events, so lets the scheduler to balance
  * the softirq load for us.
  */
-static inline void wakeup_softirqd(unsigned cpu)
+static inline void wakeup_softirqd(void)
 {
-	struct task_struct * tsk = ksoftirqd_task(cpu);
+	/* Interrupts are disabled: no need to stop preemption */
+	struct task_struct *tsk = __get_cpu_var(ksoftirqd);
 
 	if (tsk && tsk->state != TASK_RUNNING)
 		wake_up_process(tsk);
@@ -96,7 +100,7 @@ restart:
 			goto restart;
 		}
 		if (pending)
-			wakeup_softirqd(smp_processor_id());
+			wakeup_softirqd();
 		__local_bh_enable();
 	}
 
@@ -131,7 +135,7 @@ inline void cpu_raise_softirq(unsigned i
 	 * schedule the softirq soon.
 	 */
 	if (!in_interrupt())
-		wakeup_softirqd(cpu);
+		wakeup_softirqd();
 }
 
 void raise_softirq(unsigned int nr)
@@ -325,7 +329,7 @@ static int ksoftirqd(void * __bind_cpu)
 	__set_current_state(TASK_INTERRUPTIBLE);
 	mb();
 
-	local_ksoftirqd_task() = current;
+	__get_cpu_var(ksoftirqd) = current;
 
 	for (;;) {
 		if (!local_softirq_pending())
@@ -354,7 +358,7 @@ static int __devinit cpu_callback(struct
 			return NOTIFY_BAD;
 		}
 
-		while (!ksoftirqd_task(hotcpu))
+		while (!per_cpu(ksoftirqd, hotcpu))
 			yield();
  	}
 	return NOTIFY_OK;

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
