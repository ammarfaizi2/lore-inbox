Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbVLICMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbVLICMV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 21:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbVLICMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 21:12:21 -0500
Received: from fmr21.intel.com ([143.183.121.13]:1929 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751136AbVLICMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 21:12:20 -0500
Date: Thu, 8 Dec 2005 18:12:11 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Rohit Seth <rohit.seth@intel.com>,
       Len Brown <len.brown@intel.com>
Subject: [RFC][PATCH 3/3]i386,x86-64 Handle missing local APIC timer interrupts on C3 state
Message-ID: <20051208181211.D32524@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Whenever we see that a CPU is capable of C3 (during ACPI cstate init), we 
disable local APIC timer and switch to using a broadcast from external timer
interrupt (IRQ 0).

Patch below adds the code for x86_64.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.14/arch/x86_64/kernel/apic.c
===================================================================
--- linux-2.6.14.orig/arch/x86_64/kernel/apic.c	2005-12-05 15:15:28.300789192 -0800
+++ linux-2.6.14/arch/x86_64/kernel/apic.c	2005-12-08 09:42:51.929229344 -0800
@@ -25,6 +25,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
+#include <linux/module.h>
 
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -38,6 +39,12 @@
 
 int disable_apic_timer __initdata;
 
+/*
+ * cpu_mask that denotes the CPUs that needs timer interrupt coming in as
+ * IPIs in place of local APIC timers
+ */
+static cpumask_t timer_interrupt_broadcast_ipi_mask;
+
 /* Using APIC to generate smp_local_timer_interrupt? */
 int using_apic_timer = 0;
 
@@ -781,7 +788,7 @@
 	local_irq_enable();
 }
 
-void __cpuinit disable_APIC_timer(void)
+void disable_APIC_timer(void)
 {
 	if (using_apic_timer) {
 		unsigned long v;
@@ -801,6 +808,40 @@
 	}
 }
 
+void switch_APIC_timer_to_ipi(void *cpumask)
+{
+	cpumask_t mask = *(cpumask_t *)cpumask;
+	int cpu = smp_processor_id();
+
+	if (cpu_isset(cpu, mask) && 
+	    !cpu_isset(cpu, timer_interrupt_broadcast_ipi_mask)) {
+		disable_APIC_timer();
+		cpu_set(cpu, timer_interrupt_broadcast_ipi_mask);
+	}
+}
+EXPORT_SYMBOL(switch_APIC_timer_to_ipi);
+
+void smp_send_timer_broadcast_ipi(void)
+{
+	if (!cpus_empty(timer_interrupt_broadcast_ipi_mask)) {
+		send_IPI_mask(timer_interrupt_broadcast_ipi_mask,
+		              LOCAL_TIMER_VECTOR);
+	}
+}
+
+void switch_ipi_to_APIC_timer(void *cpumask)
+{
+	cpumask_t mask = *(cpumask_t *)cpumask;
+	int cpu = smp_processor_id();
+
+	if (cpu_isset(cpu, mask) &&
+	    cpu_isset(cpu, timer_interrupt_broadcast_ipi_mask)) {
+		cpu_clear(cpu, timer_interrupt_broadcast_ipi_mask);
+		enable_APIC_timer();
+	}
+}
+EXPORT_SYMBOL(switch_ipi_to_APIC_timer);
+
 int setup_profiling_timer(unsigned int multiplier)
 {
 	return -EINVAL;
Index: linux-2.6.14/include/asm-x86_64/apic.h
===================================================================
--- linux-2.6.14.orig/include/asm-x86_64/apic.h	2005-12-05 16:24:35.718285896 -0800
+++ linux-2.6.14/include/asm-x86_64/apic.h	2005-12-05 16:27:36.115861296 -0800
@@ -113,6 +113,12 @@
 
 extern void setup_threshold_lvt(unsigned long lvt_off);
 
+void smp_send_timer_broadcast_ipi(void);
+void switch_APIC_timer_to_ipi(void *cpumask);
+void switch_ipi_to_APIC_timer(void *cpumask);
+
+#define ARCH_APICTIMER_STOPS_ON_C3	1
+
 #endif /* CONFIG_X86_LOCAL_APIC */
 
 extern unsigned boot_cpu_id;
Index: linux-2.6.14/arch/x86_64/kernel/time.c
===================================================================
--- linux-2.6.14.orig/arch/x86_64/kernel/time.c	2005-12-01 18:04:25.878829032 -0800
+++ linux-2.6.14/arch/x86_64/kernel/time.c	2005-12-05 16:26:37.470776704 -0800
@@ -476,6 +476,11 @@
  
 	write_sequnlock(&xtime_lock);
 
+#ifdef CONFIG_X86_LOCAL_APIC
+	if (using_apic_timer)
+		smp_send_timer_broadcast_ipi();
+#endif
+
 	return IRQ_HANDLED;
 }
 
