Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbVLMCTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbVLMCTs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 21:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVLMCTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 21:19:48 -0500
Received: from fmr23.intel.com ([143.183.121.15]:28836 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932358AbVLMCTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 21:19:47 -0500
Date: Mon, 12 Dec 2005 18:19:23 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Rohit Seth <rohit.seth@intel.com>,
       Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 3/3]i386,x86-64 (take 3) Handle missing local APIC timer interrupts on C3 state
Message-ID: <20051212181923.B13345@unix-os.sc.intel.com>
References: <20051212175015.D10234@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20051212175015.D10234@unix-os.sc.intel.com>; from venkatesh.pallipadi@intel.com on Mon, Dec 12, 2005 at 05:50:15PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My bad....
take 2 version of this patch was broken too. Here is take 3.


Whenever we see that a CPU is capable of C3 (during ACPI cstate init), we 
disable local APIC timer and switch to using a broadcast from external timer
interrupt (IRQ 0).

Patch below adds the code for x86_64.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.14/arch/x86_64/kernel/apic.c
===================================================================
--- linux-2.6.14.orig/arch/x86_64/kernel/apic.c	2005-12-05 15:15:28.000000000 -0800
+++ linux-2.6.14/arch/x86_64/kernel/apic.c	2005-12-12 14:34:28.427171400 -0800
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
 
@@ -656,9 +663,14 @@
 static void __setup_APIC_LVTT(unsigned int clocks)
 {
 	unsigned int lvtt_value, tmp_value, ver;
+	int cpu = smp_processor_id();
 
 	ver = GET_APIC_VERSION(apic_read(APIC_LVR));
 	lvtt_value = APIC_LVT_TIMER_PERIODIC | LOCAL_TIMER_VECTOR;
+
+	if (cpu_isset(cpu, timer_interrupt_broadcast_ipi_mask))
+		lvtt_value |= APIC_LVT_MASKED;
+
 	apic_write_around(APIC_LVTT, lvtt_value);
 
 	/*
@@ -781,7 +793,7 @@
 	local_irq_enable();
 }
 
-void __cpuinit disable_APIC_timer(void)
+void disable_APIC_timer(void)
 {
 	if (using_apic_timer) {
 		unsigned long v;
@@ -793,7 +805,10 @@
 
 void enable_APIC_timer(void)
 {
-	if (using_apic_timer) {
+	int cpu = smp_processor_id();
+
+	if (using_apic_timer &&
+	    !cpu_isset(cpu, timer_interrupt_broadcast_ipi_mask)) {
 		unsigned long v;
 
 		v = apic_read(APIC_LVTT);
@@ -801,6 +816,42 @@
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
+	cpumask_t mask;
+
+	cpus_and(mask, cpu_online_map, timer_interrupt_broadcast_ipi_mask);
+	if (!cpus_empty(mask)) {
+		send_IPI_mask(mask, LOCAL_TIMER_VECTOR);
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
--- linux-2.6.14.orig/include/asm-x86_64/apic.h	2005-12-05 16:24:35.000000000 -0800
+++ linux-2.6.14/include/asm-x86_64/apic.h	2005-12-05 16:27:36.000000000 -0800
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
--- linux-2.6.14.orig/arch/x86_64/kernel/time.c	2005-12-01 18:04:25.000000000 -0800
+++ linux-2.6.14/arch/x86_64/kernel/time.c	2005-12-05 16:26:37.000000000 -0800
@@ -476,6 +476,11 @@
  
 	write_sequnlock(&xtime_lock);
 
+#ifdef CONFIG_X86_LOCAL_APIC
+	if (using_apic_timer)
+		smp_send_timer_broadcast_ipi();
+#endif
+
 	return IRQ_HANDLED;
 }
 
