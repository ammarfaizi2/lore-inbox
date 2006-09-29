Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422851AbWI3AIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422851AbWI3AIa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 20:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422856AbWI3AGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 20:06:38 -0400
Received: from www.osadl.org ([213.239.205.134]:30100 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1422851AbWI3AEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 20:04:14 -0400
Message-Id: <20060929234440.865232000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
Date: Fri, 29 Sep 2006 23:58:37 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [patch 18/23] dynticks: i386 arch code
Content-Disposition: inline; filename=i368-prepare-no-hz.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

prepare i386 for dyntick: idle handler callbacks and IRQ callback.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
----
 arch/i386/kernel/nmi.c     |    3 ++-
 arch/i386/kernel/process.c |   27 +++++++++++++++------------
 2 files changed, 17 insertions(+), 13 deletions(-)

Index: linux-2.6.18-mm2/arch/i386/kernel/nmi.c
===================================================================
--- linux-2.6.18-mm2.orig/arch/i386/kernel/nmi.c	2006-09-30 01:41:10.000000000 +0200
+++ linux-2.6.18-mm2/arch/i386/kernel/nmi.c	2006-09-30 01:41:19.000000000 +0200
@@ -20,6 +20,7 @@
 #include <linux/sysdev.h>
 #include <linux/sysctl.h>
 #include <linux/percpu.h>
+#include <linux/kernel_stat.h>
 #include <linux/dmi.h>
 #include <linux/kprobes.h>
 
@@ -908,7 +909,7 @@ __kprobes int nmi_watchdog_tick(struct p
 		touched = 1;
 	}
 
-	sum = per_cpu(irq_stat, cpu).apic_timer_irqs;
+	sum = per_cpu(irq_stat, cpu).apic_timer_irqs + kstat_irqs(0);
 
 	/* if the apic timer isn't firing, this cpu isn't doing much */
 	if (!touched && last_irq_sums[cpu] == sum) {
Index: linux-2.6.18-mm2/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.18-mm2.orig/arch/i386/kernel/process.c	2006-09-30 01:41:10.000000000 +0200
+++ linux-2.6.18-mm2/arch/i386/kernel/process.c	2006-09-30 01:41:19.000000000 +0200
@@ -178,24 +178,27 @@ void cpu_idle(void)
 
 	/* endless idle loop with no priority at all */
 	while (1) {
-		while (!need_resched()) {
-			void (*idle)(void);
+		if (!hrtimer_stop_sched_tick()) {
+			while (!need_resched()) {
+				void (*idle)(void);
 
-			if (__get_cpu_var(cpu_idle_state))
-				__get_cpu_var(cpu_idle_state) = 0;
+				if (__get_cpu_var(cpu_idle_state))
+					__get_cpu_var(cpu_idle_state) = 0;
 
-			rmb();
-			idle = pm_idle;
+				rmb();
+				idle = pm_idle;
 
-			if (!idle)
-				idle = default_idle;
+				if (!idle)
+					idle = default_idle;
 
-			if (cpu_is_offline(cpu))
-				play_dead();
+				if (cpu_is_offline(cpu))
+					play_dead();
 
-			__get_cpu_var(irq_stat).idle_timestamp = jiffies;
-			idle();
+				__get_cpu_var(irq_stat).idle_timestamp = jiffies;
+				idle();
+			}
 		}
+		hrtimer_restart_sched_tick();
 		preempt_enable_no_resched();
 		schedule();
 		preempt_disable();

--

