Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262281AbVCOGcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbVCOGcu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 01:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbVCOGcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 01:32:50 -0500
Received: from 209-204-138-32.dsl.static.sonic.net ([209.204.138.32]:23302
	"EHLO graphe.net") by vger.kernel.org with ESMTP id S262281AbVCOGcm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 01:32:42 -0500
Date: Mon, 14 Mar 2005 22:32:34 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: akpm@osdl.org
cc: shai@scalex86.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Per cpu irq stat 
Message-ID: <Pine.LNX.4.58.0503142230050.11651@server.graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The definition of the irq_stat as an array means that the individual
elements of the irq_stat array are located on one NUMA node requiring
internode traffic to access irq_stat from other nodes. This patch makes
irq_stat a per_cpu variable which allows most accesses to be local.

Signed-off-by: Christoph Lameter <christoph@lameter.com>
Signed-off-by: Shai Fultheim <Shai@Scalex86.org>

Index: linux-2.6.11/arch/i386/kernel/apic.c
===================================================================
--- linux-2.6.11.orig/arch/i386/kernel/apic.c	2005-03-01
23:38:33.000000000 -0800
+++ linux-2.6.11/arch/i386/kernel/apic.c	2005-03-08
15:01:43.000000000 -0800
@@ -1165,7 +1165,7 @@ fastcall void smp_apic_timer_interrupt(s
 	/*
 	 * the NMI deadlock-detector uses this.
 	 */
-	irq_stat[cpu].apic_timer_irqs++;
+	per_cpu(irq_stat, cpu).apic_timer_irqs++;

 	/*
 	 * NOTE! We'd better ACK the irq immediately,
Index: linux-2.6.11/arch/i386/kernel/io_apic.c
===================================================================
--- linux-2.6.11.orig/arch/i386/kernel/io_apic.c	2005-03-01
23:37:54.000000000 -0800
+++ linux-2.6.11/arch/i386/kernel/io_apic.c	2005-03-08
16:56:24.923078776 -0800
@@ -275,7 +275,7 @@ struct irq_cpu_info {
 #define IRQ_DELTA(cpu,irq) 	(irq_cpu_data[cpu].irq_delta[irq])

 #define IDLE_ENOUGH(cpu,now) \
-		(idle_cpu(cpu) && ((now) -
irq_stat[(cpu)].idle_timestamp > 1))
+		(idle_cpu(cpu) && ((now) - per_cpu(irq_stat,
(cpu)).idle_timestamp > 1))

 #define IRQ_ALLOWED(cpu, allowed_mask)	cpu_isset(cpu, allowed_mask)

Index: linux-2.6.11/arch/i386/kernel/irq.c
===================================================================
--- linux-2.6.11.orig/arch/i386/kernel/irq.c	2005-03-01
23:37:48.000000000 -0800
+++ linux-2.6.11/arch/i386/kernel/irq.c	2005-03-08 17:57:13.623392016
-0800
@@ -16,6 +16,9 @@
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>

+DEFINE_PER_CPU(irq_cpustat_t, irq_stat)
____cacheline_maxaligned_in_smp;
+EXPORT_PER_CPU_SYMBOL(irq_stat);
+
 #ifndef CONFIG_X86_LOCAL_APIC
 /*
  * 'what should we do if we get a hw irq event on an illegal vector'.
@@ -246,7 +249,7 @@ skip:
 		for (j = 0; j < NR_CPUS; j++)
 			if (cpu_online(j))
 				seq_printf(p, "%10u ",
-					irq_stat[j].apic_timer_irqs);
+
per_cpu(irq_stat,j).apic_timer_irqs);
 		seq_putc(p, '\n');
 #endif
 		seq_printf(p, "ERR: %10u\n",
atomic_read(&irq_err_count));
Index: linux-2.6.11/arch/i386/kernel/nmi.c
===================================================================
--- linux-2.6.11.orig/arch/i386/kernel/nmi.c	2005-03-01
23:38:10.000000000 -0800
+++ linux-2.6.11/arch/i386/kernel/nmi.c	2005-03-08 15:01:43.000000000
-0800
@@ -110,7 +110,7 @@ int __init check_nmi_watchdog (void)
 	printk(KERN_INFO "testing NMI watchdog ... ");

 	for (cpu = 0; cpu < NR_CPUS; cpu++)
-		prev_nmi_count[cpu] = irq_stat[cpu].__nmi_count;
+		prev_nmi_count[cpu] = per_cpu(irq_stat,
cpu).__nmi_count;
 	local_irq_enable();
 	mdelay((10*1000)/nmi_hz); // wait 10 ticks

@@ -483,7 +483,7 @@ void nmi_watchdog_tick (struct pt_regs *
 	 */
 	int sum, cpu = smp_processor_id();

-	sum = irq_stat[cpu].apic_timer_irqs;
+	sum = per_cpu(irq_stat, cpu).apic_timer_irqs;

 	if (last_irq_sums[cpu] == sum) {
 		/*
Index: linux-2.6.11/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.11.orig/arch/i386/kernel/process.c	2005-03-08
15:01:42.000000000 -0800
+++ linux-2.6.11/arch/i386/kernel/process.c	2005-03-08
18:06:03.695808760 -0800
@@ -161,7 +161,7 @@ void cpu_idle (void)
 			if (!idle)
 				idle = default_idle;

-			irq_stat[cpu].idle_timestamp = jiffies;
+			__get_cpu_var(irq_stat).idle_timestamp =
jiffies;
 			idle();
 		}
 		schedule();
Index: linux-2.6.11/include/asm-i386/hardirq.h
===================================================================
--- linux-2.6.11.orig/include/asm-i386/hardirq.h	2005-03-01
23:38:17.000000000 -0800
+++ linux-2.6.11/include/asm-i386/hardirq.h	2005-03-08
18:10:52.545896872 -0800
@@ -12,8 +12,13 @@ typedef struct {
 	unsigned int apic_timer_irqs;	/* arch dependent */
 } ____cacheline_aligned irq_cpustat_t;

-#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t
above */
+DECLARE_PER_CPU(irq_cpustat_t, irq_stat);
+extern irq_cpustat_t irq_stat[];
+
+#define __ARCH_IRQ_STAT
+#define __IRQ_STAT(cpu, member) (per_cpu(irq_stat, cpu).member)

 void ack_bad_irq(unsigned int irq);
+#include <linux/irq_cpustat.h>

 #endif /* __ASM_HARDIRQ_H */
