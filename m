Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbUGIByu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbUGIByu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 21:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbUGIByu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 21:54:50 -0400
Received: from 234.69-93-232.reverse.theplanet.com ([69.93.232.234]:35488 "EHLO
	urbanisp01.urban-isp.net") by vger.kernel.org with ESMTP
	id S262768AbUGIBxq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 21:53:46 -0400
From: "Shai Fultheim" <shai@scalex86.org>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: "'Linux Kernel ML'" <linux-kernel@vger.kernel.org>,
       "'Martin Hicks'" <mort@wildopensource.com>,
       "'Jes Sorensen'" <jes@wildopensource.com>
Subject: [PATCH] PER_CPU [2/4] - PER_CPU-irq_stat
Date: Thu, 8 Jul 2004 18:53:40 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2142
Thread-Index: AcRlV47hNDmACYLyTpC5ACfaGdKQ0Q==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - urbanisp01.urban-isp.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Message-Id: <S262768AbUGIBxq/20040709015346Z+1744@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Please find below one out of collection of patched that move NR_CPU array variables to the per-cpu area.  Please consider applying,
any comment will highly appreciated.

1/4. PER_CPU-cpu_tlbstate
2/4. PER_CPU-irq_stat
3/4. PER_CPU-init_tss
4/4. PER_CPU-cpu_gdt_table

PER_CPU-irq_stat:
 arch/i386/kernel/apic.c     |    2 +-
 arch/i386/kernel/io_apic.c  |    2 +-
 arch/i386/kernel/irq.c      |    3 ++-
 arch/i386/kernel/nmi.c      |    4 ++--
 arch/i386/kernel/process.c  |    2 +-
 include/linux/irq_cpustat.h |    4 ++--
 kernel/softirq.c            |    4 ++--
 7 files changed, 11 insertions(+), 10 deletions(-)

Signed-off-by: Martin Hicks <mort@wildopensource.com>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

=================================================================================
diff -Nru a/arch/i386/kernel/apic.c b/arch/i386/kernel/apic.c
--- a/arch/i386/kernel/apic.c	2004-07-08 14:43:13 -07:00
+++ b/arch/i386/kernel/apic.c	2004-07-08 14:43:13 -07:00
@@ -1083,7 +1083,7 @@
 	/*
 	 * the NMI deadlock-detector uses this.
 	 */
-	irq_stat[cpu].apic_timer_irqs++;
+	per_cpu(irq_stat, cpu).apic_timer_irqs++;
 
 	/*
 	 * NOTE! We'd better ACK the irq immediately,
diff -Nru a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c	2004-07-08 14:43:13 -07:00
+++ b/arch/i386/kernel/io_apic.c	2004-07-08 14:43:13 -07:00
@@ -313,7 +313,7 @@
 #define IRQ_DELTA(cpu,irq) 	(irq_cpu_data[cpu].irq_delta[irq])
 
 #define IDLE_ENOUGH(cpu,now) \
-		(idle_cpu(cpu) && ((now) - irq_stat[(cpu)].idle_timestamp > 1))
+		(idle_cpu(cpu) && ((now) - per_cpu(irq_stat, (cpu)).idle_timestamp > 1))
 
 #define IRQ_ALLOWED(cpu, allowed_mask)	cpu_isset(cpu, allowed_mask)
 
diff -Nru a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	2004-07-08 14:43:13 -07:00
+++ b/arch/i386/kernel/irq.c	2004-07-08 14:43:13 -07:00
@@ -188,7 +188,8 @@
 		seq_printf(p, "LOC: ");
 		for (j = 0; j < NR_CPUS; j++)
 			if (cpu_online(j))
-				seq_printf(p, "%10u ", irq_stat[j].apic_timer_irqs);
+				seq_printf(p, "%10u ",
+					   per_cpu(irq_stat, j).apic_timer_irqs);
 		seq_putc(p, '\n');
 #endif
 		seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
diff -Nru a/arch/i386/kernel/nmi.c b/arch/i386/kernel/nmi.c
--- a/arch/i386/kernel/nmi.c	2004-07-08 14:43:13 -07:00
+++ b/arch/i386/kernel/nmi.c	2004-07-08 14:43:13 -07:00
@@ -106,7 +106,7 @@
 	printk(KERN_INFO "testing NMI watchdog ... ");
 
 	for (cpu = 0; cpu < NR_CPUS; cpu++)
-		prev_nmi_count[cpu] = irq_stat[cpu].__nmi_count;
+		prev_nmi_count[cpu] = per_cpu(irq_stat, cpu).__nmi_count;
 	local_irq_enable();
 	mdelay((10*1000)/nmi_hz); // wait 10 ticks
 
@@ -469,7 +469,7 @@
 	 */
 	int sum, cpu = smp_processor_id();
 
-	sum = irq_stat[cpu].apic_timer_irqs;
+	sum = per_cpu(irq_stat, cpu).apic_timer_irqs;
 
 	if (last_irq_sums[cpu] == sum) {
 		/*
diff -Nru a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c	2004-07-08 14:43:13 -07:00
+++ b/arch/i386/kernel/process.c	2004-07-08 14:43:13 -07:00
@@ -147,7 +147,7 @@
 			if (!idle)
 				idle = default_idle;
 
-			irq_stat[smp_processor_id()].idle_timestamp = jiffies;
+			__get_cpu_var(irq_stat).idle_timestamp = jiffies;
 			idle();
 		}
 		schedule();
diff -Nru a/include/linux/irq_cpustat.h b/include/linux/irq_cpustat.h
--- a/include/linux/irq_cpustat.h	2004-07-08 14:43:13 -07:00
+++ b/include/linux/irq_cpustat.h	2004-07-08 14:43:13 -07:00
@@ -18,8 +18,8 @@
  */
 
 #ifndef __ARCH_IRQ_STAT
-extern irq_cpustat_t irq_stat[];		/* defined in asm/hardirq.h */
-#define __IRQ_STAT(cpu, member)	(irq_stat[cpu].member)
+DECLARE_PER_CPU(irq_cpustat_t, irq_stat);	/* defined in kernel/softirq.h */
+#define __IRQ_STAT(cpu, member)	(per_cpu(irq_stat, cpu).member)
 #endif
 
   /* arch independent irq_stat fields */
diff -Nru a/kernel/softirq.c b/kernel/softirq.c
--- a/kernel/softirq.c	2004-07-08 14:43:13 -07:00
+++ b/kernel/softirq.c	2004-07-08 14:43:13 -07:00
@@ -36,8 +36,8 @@
  */
 
 #ifndef __ARCH_IRQ_STAT
-irq_cpustat_t irq_stat[NR_CPUS] ____cacheline_aligned;
-EXPORT_SYMBOL(irq_stat);
+DEFINE_PER_CPU(irq_cpustat_t, irq_stat ____cacheline_maxaligned_in_smp);
+EXPORT_PER_CPU_SYMBOL(irq_stat);
 #endif
 
 static struct softirq_action softirq_vec[32] __cacheline_aligned_in_smp;
=================================================================================

 
-----------------
Shai Fultheim
Scalex86.org



