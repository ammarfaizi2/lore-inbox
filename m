Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270650AbTHORRg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 13:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270652AbTHORRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 13:17:36 -0400
Received: from mail.ccur.com ([208.248.32.212]:36873 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S270650AbTHORR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 13:17:26 -0400
Date: Fri, 15 Aug 2003 13:17:21 -0400
From: Joe Korty <joe.korty@ccur.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] add missing vectors to /proc/interrupts
Message-ID: <20030815171720.GA12312@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Display in /proc/interrupts all interesting vectors.

Joe

 arch/i386/kernel/apic.c          |    3 +
 arch/i386/kernel/cpu/mcheck/p4.c |    2 +
 arch/i386/kernel/i8259.c         |    2 -
 arch/i386/kernel/io_apic.c       |    3 +
 arch/i386/kernel/irq.c           |   68 +++++++++++++++++++++++++++++++++++----
 arch/i386/kernel/smp.c           |    4 +-
 include/asm-i386/apic.h          |    4 ++
 include/asm-i386/hw_irq.h        |    7 ++--
 8 files changed, 81 insertions(+), 12 deletions(-)


diff -Nura 2.6.0-test3/arch/i386/kernel/apic.c proc.interrupts/arch/i386/kernel/apic.c
--- 2.6.0-test3/arch/i386/kernel/apic.c	2003-08-09 00:42:27.000000000 -0400
+++ proc.interrupts/arch/i386/kernel/apic.c	2003-08-15 11:17:21.000000000 -0400
@@ -1077,6 +1077,7 @@
 	v = apic_read(APIC_ISR + ((SPURIOUS_APIC_VECTOR & ~0x1f) >> 1));
 	if (v & (1 << (SPURIOUS_APIC_VECTOR & 0x1f)))
 		ack_APIC_irq();
+	atomic_inc(&irq_spur_counts[smp_processor_id()]);
 
 	/* see sw-dev-man vol 3, chapter 7.4.13.5 */
 	printk(KERN_INFO "spurious APIC interrupt on CPU#%d, should never happen.\n",
@@ -1098,7 +1099,7 @@
 	apic_write(APIC_ESR, 0);
 	v1 = apic_read(APIC_ESR);
 	ack_APIC_irq();
-	atomic_inc(&irq_err_count);
+	atomic_inc(&irq_err_counts[smp_processor_id()]);
 
 	/* Here is what the APIC error bits mean:
 	   0: Send CS error
diff -Nura 2.6.0-test3/arch/i386/kernel/cpu/mcheck/p4.c proc.interrupts/arch/i386/kernel/cpu/mcheck/p4.c
--- 2.6.0-test3/arch/i386/kernel/cpu/mcheck/p4.c	2003-08-09 00:38:07.000000000 -0400
+++ proc.interrupts/arch/i386/kernel/cpu/mcheck/p4.c	2003-08-15 10:29:54.000000000 -0400
@@ -59,11 +59,13 @@
 }
 
 /* Thermal interrupt handler for this CPU setup */
+
 static void (*vendor_thermal_interrupt)(struct pt_regs *regs) = unexpected_thermal_interrupt;
 
 asmlinkage void smp_thermal_interrupt(struct pt_regs regs)
 {
 	irq_enter();
+	atomic_inc(&irq_thermal_counts[smp_processor_id()]);
 	vendor_thermal_interrupt(&regs);
 	irq_exit();
 }
diff -Nura 2.6.0-test3/arch/i386/kernel/i8259.c proc.interrupts/arch/i386/kernel/i8259.c
--- 2.6.0-test3/arch/i386/kernel/i8259.c	2003-08-09 00:41:31.000000000 -0400
+++ proc.interrupts/arch/i386/kernel/i8259.c	2003-08-15 10:29:54.000000000 -0400
@@ -228,7 +228,7 @@
 			printk("spurious 8259A interrupt: IRQ%d.\n", irq);
 			spurious_irq_mask |= irqmask;
 		}
-		atomic_inc(&irq_err_count);
+		atomic_inc(&irq_err_counts[smp_processor_id()]);
 		/*
 		 * Theoretically we do not have to handle this IRQ,
 		 * but in Linux this does not cause problems and is
diff -Nura 2.6.0-test3/arch/i386/kernel/io_apic.c proc.interrupts/arch/i386/kernel/io_apic.c
--- 2.6.0-test3/arch/i386/kernel/io_apic.c	2003-08-09 00:34:38.000000000 -0400
+++ proc.interrupts/arch/i386/kernel/io_apic.c	2003-08-15 10:29:54.000000000 -0400
@@ -1859,7 +1859,8 @@
 #endif
 
 #ifdef APIC_MISMATCH_DEBUG
-		atomic_inc(&irq_mis_count);
+		/* accumulated per-cpu as this makes /proc/interrupts code simple */
+		atomic_inc(&irq_mis_counts[smp_processor_id()]);
 #endif
 		spin_lock(&ioapic_lock);
 		__mask_and_edge_IO_APIC_irq(irq);
diff -Nura 2.6.0-test3/arch/i386/kernel/irq.c proc.interrupts/arch/i386/kernel/irq.c
--- 2.6.0-test3/arch/i386/kernel/irq.c	2003-08-09 00:32:00.000000000 -0400
+++ proc.interrupts/arch/i386/kernel/irq.c	2003-08-15 10:29:54.000000000 -0400
@@ -126,10 +126,15 @@
 	end_none
 };
 
-atomic_t irq_err_count;
+atomic_t irq_resched_counts [ NR_CPUS];
+atomic_t irq_call_counts [ NR_CPUS];
+atomic_t irq_spur_counts [ NR_CPUS];
+atomic_t irq_tlb_counts [ NR_CPUS];
+atomic_t irq_thermal_counts [ NR_CPUS];
+atomic_t irq_err_counts [NR_CPUS];
 #ifdef CONFIG_X86_IO_APIC
 #ifdef APIC_MISMATCH_DEBUG
-atomic_t irq_mis_count;
+atomic_t irq_mis_counts[NR_CPUS];
 #endif
 #endif
 
@@ -176,18 +181,69 @@
 	for (j = 0; j < NR_CPUS; j++)
 		if (cpu_online(j))
 			seq_printf(p, "%10u ", nmi_count(j));
-	seq_putc(p, '\n');
+	seq_printf(p, "  Non-maskable interrupts\n");
 #ifdef CONFIG_X86_LOCAL_APIC
 	seq_printf(p, "LOC: ");
 	for (j = 0; j < NR_CPUS; j++)
 		if (cpu_online(j))
 			seq_printf(p, "%10u ", irq_stat[j].apic_timer_irqs);
-	seq_putc(p, '\n');
+	seq_printf(p, "  Local interrupts\n");
+#endif
+#ifdef CONFIG_SMP
+#ifdef RESCHEDULE_VECTOR
+	seq_printf(p, "RES: ");
+	for (j = 0; j < NR_CPUS; j++)
+		if (cpu_online(j))
+			seq_printf(p, "%10u ", atomic_read(&irq_resched_counts[j]));
+	seq_printf(p, "  Rescheduling interrupts\n");
+#endif
+#endif
+#ifdef CONFIG_SMP
+#ifdef CALL_FUNCTION_VECTOR
+	seq_printf(p, "CAL: ");
+	for (j = 0; j < NR_CPUS; j++)
+		if (cpu_online(j))
+			seq_printf(p, "%10u ", atomic_read(&irq_call_counts[j]));
+	seq_printf(p, "  function call interrupts\n");
+#endif
+#endif
+#ifdef CONFIG_SMP
+#ifdef INVALIDATE_TLB_VECTOR
+	seq_printf(p, "TLB: ");
+	for (j = 0; j < NR_CPUS; j++)
+		if (cpu_online(j))
+			seq_printf(p, "%10u ", atomic_read(&irq_tlb_counts[j]));
+	seq_printf(p, "  TLB shootdowns\n");
+#endif
+#endif
+#ifdef THERMAL_APIC_VECTOR
+	seq_printf(p, "TRM: ");
+	for (j = 0; j < NR_CPUS; j++)
+		if (cpu_online(j))
+			seq_printf(p, "%10u ", atomic_read(&irq_thermal_counts[j]));
+	seq_printf(p, "  Thermal event interrupts\n");
+#endif
+#ifdef SPURIOUS_APIC_VECTOR
+	seq_printf(p, "SPU: ");
+	for (j = 0; j < NR_CPUS; j++)
+		if (cpu_online(j))
+			seq_printf(p, "%10u ", atomic_read(&irq_spur_counts[j]));
+	seq_printf(p, "  Spurious interrupts\n");
+#endif
+#ifdef ERROR_APIC_VECTOR
+	seq_printf(p, "ERR: ");
+	for (j = 0; j < NR_CPUS; j++)
+		if (cpu_online(j))
+			seq_printf(p, "%10u ", atomic_read(&irq_err_counts[j]));
+	seq_printf(p, "  Error interrupts\n");
 #endif
-	seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
 #ifdef CONFIG_X86_IO_APIC
 #ifdef APIC_MISMATCH_DEBUG
-	seq_printf(p, "MIS: %10u\n", atomic_read(&irq_mis_count));
+	seq_printf(p, "MIS: ");
+	for (j = 0; j < NR_CPUS; j++)
+		if (cpu_online(j))
+			seq_printf(p, "%10u ", atomic_read(&irq_mis_counts[j]));
+	seq_printf(p, "  APIC errata fixups\n");
 #endif
 #endif
 	return 0;
diff -Nura 2.6.0-test3/arch/i386/kernel/smp.c proc.interrupts/arch/i386/kernel/smp.c
--- 2.6.0-test3/arch/i386/kernel/smp.c	2003-08-09 00:32:31.000000000 -0400
+++ proc.interrupts/arch/i386/kernel/smp.c	2003-08-15 11:20:01.000000000 -0400
@@ -304,12 +304,12 @@
  * 1) Flush the tlb entries if the cpu uses the mm that's being flushed.
  * 2) Leave the mm if we are in the lazy tlb mode.
  */
-
 asmlinkage void smp_invalidate_interrupt (void)
 {
 	unsigned long cpu;
 
 	cpu = get_cpu();
+	atomic_inc(&irq_tlb_counts[cpu]);
 
 	if (!test_bit(cpu, &flush_cpumask))
 		goto out;
@@ -562,6 +562,7 @@
 asmlinkage void smp_reschedule_interrupt(void)
 {
 	ack_APIC_irq();
+	atomic_inc(&irq_resched_counts[smp_processor_id()]);
 }
 
 asmlinkage void smp_call_function_interrupt(void)
@@ -571,6 +572,7 @@
 	int wait = call_data->wait;
 
 	ack_APIC_irq();
+	atomic_inc(&irq_call_counts[smp_processor_id()]);
 	/*
 	 * Notify initiating CPU that I've grabbed the data and am
 	 * about to execute the function
diff -Nura 2.6.0-test3/include/asm-i386/apic.h proc.interrupts/include/asm-i386/apic.h
--- 2.6.0-test3/include/asm-i386/apic.h	2003-08-09 00:42:18.000000000 -0400
+++ proc.interrupts/include/asm-i386/apic.h	2003-08-15 10:29:54.000000000 -0400
@@ -6,6 +6,7 @@
 #include <asm/fixmap.h>
 #include <asm/apicdef.h>
 #include <asm/system.h>
+#include <asm/atomic.h>
 
 #define APIC_DEBUG 0
 
@@ -91,6 +92,9 @@
 extern int check_nmi_watchdog (void);
 extern void enable_NMI_through_LVT0 (void * dummy);
 
+extern atomic_t irq_spur_counts [NR_CPUS];
+extern atomic_t irq_thermal_counts [NR_CPUS];
+
 extern unsigned int nmi_watchdog;
 #define NMI_NONE	0
 #define NMI_IO_APIC	1
diff -Nura 2.6.0-test3/include/asm-i386/hw_irq.h proc.interrupts/include/asm-i386/hw_irq.h
--- 2.6.0-test3/include/asm-i386/hw_irq.h	2003-08-09 00:42:18.000000000 -0400
+++ proc.interrupts/include/asm-i386/hw_irq.h	2003-08-15 10:29:54.000000000 -0400
@@ -61,8 +61,11 @@
 
 extern unsigned long io_apic_irqs;
 
-extern atomic_t irq_err_count;
-extern atomic_t irq_mis_count;
+extern atomic_t irq_err_counts [NR_CPUS];
+extern atomic_t irq_mis_counts [NR_CPUS];
+extern atomic_t irq_call_counts [NR_CPUS];
+extern atomic_t irq_resched_counts [NR_CPUS];
+extern atomic_t irq_tlb_counts [NR_CPUS];
 
 #define IO_APIC_IRQ(x) (((x) >= 16) || ((1<<(x)) & io_apic_irqs))
 
