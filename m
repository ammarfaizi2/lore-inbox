Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbVLMCSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbVLMCSN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 21:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbVLMCSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 21:18:13 -0500
Received: from fmr24.intel.com ([143.183.121.16]:32448 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S932350AbVLMCSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 21:18:12 -0500
Date: Mon, 12 Dec 2005 18:17:49 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Rohit Seth <rohit.seth@intel.com>,
       Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 2/3]i386,x86-64 (take 3) Handle missing local APIC timer interrupts on C3 state
Message-ID: <20051212181749.A13345@unix-os.sc.intel.com>
References: <20051212174927.C10234@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20051212174927.C10234@unix-os.sc.intel.com>; from venkatesh.pallipadi@intel.com on Mon, Dec 12, 2005 at 05:49:27PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My bad....
take 2 version of this patch was broken too. Here is take 3.



Whenever we see that a CPU is capable of C3 (during ACPI cstate init), we 
disable local APIC timer and switch to using a broadcast from external timer
interrupt (IRQ 0).

Patch below adds the code for i386 and also the ACPI hunk.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.15-rc3/arch/i386/kernel/time.c
===================================================================
--- linux-2.6.15-rc3.orig/arch/i386/kernel/time.c
+++ linux-2.6.15-rc3/arch/i386/kernel/time.c
@@ -302,6 +302,12 @@ irqreturn_t timer_interrupt(int irq, voi
 	do_timer_interrupt(irq, regs);
 
 	write_sequnlock(&xtime_lock);
+
+#ifdef CONFIG_X86_LOCAL_APIC
+	if (using_apic_timer)
+		smp_send_timer_broadcast_ipi(regs);
+#endif
+
 	return IRQ_HANDLED;
 }
 
Index: linux-2.6.15-rc3/include/asm-i386/apic.h
===================================================================
--- linux-2.6.15-rc3.orig/include/asm-i386/apic.h
+++ linux-2.6.15-rc3/include/asm-i386/apic.h
@@ -132,6 +132,11 @@ extern unsigned int nmi_watchdog;
 
 extern int disable_timer_pin_1;
 
+void smp_send_timer_broadcast_ipi(struct pt_regs *regs);
+void switch_APIC_timer_to_ipi(void *cpumask);
+void switch_ipi_to_APIC_timer(void *cpumask);
+#define ARCH_APICTIMER_STOPS_ON_C3	1
+
 #else /* !CONFIG_X86_LOCAL_APIC */
 static inline void lapic_shutdown(void) { }
 
Index: linux-2.6.15-rc3/arch/i386/kernel/apic.c
===================================================================
--- linux-2.6.15-rc3.orig/arch/i386/kernel/apic.c
+++ linux-2.6.15-rc3/arch/i386/kernel/apic.c
@@ -26,6 +26,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
 #include <linux/cpu.h>
+#include <linux/module.h>
 
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -37,10 +38,17 @@
 #include <asm/i8253.h>
 
 #include <mach_apic.h>
+#include <mach_ipi.h>
 
 #include "io_ports.h"
 
 /*
+ * cpu_mask that denotes the CPUs that needs timer interrupt coming in as
+ * IPIs in place of local APIC timers
+ */
+static cpumask_t timer_interrupt_broadcast_ipi_mask;
+
+/*
  * Knob to control our willingness to enable the local APIC.
  */
 int enable_local_apic __initdata = 0; /* -1=force-disable, +1=force-enable */
@@ -931,11 +939,16 @@ void (*wait_timer_tick)(void) __devinitd
 static void __setup_APIC_LVTT(unsigned int clocks)
 {
 	unsigned int lvtt_value, tmp_value, ver;
+	int cpu = smp_processor_id();
 
 	ver = GET_APIC_VERSION(apic_read(APIC_LVR));
 	lvtt_value = APIC_LVT_TIMER_PERIODIC | LOCAL_TIMER_VECTOR;
 	if (!APIC_INTEGRATED(ver))
 		lvtt_value |= SET_APIC_TIMER_BASE(APIC_TIMER_BASE_DIV);
+
+	if (cpu_isset(cpu, timer_interrupt_broadcast_ipi_mask))
+		lvtt_value |= APIC_LVT_MASKED;
+
 	apic_write_around(APIC_LVTT, lvtt_value);
 
 	/*
@@ -1068,7 +1081,7 @@ void __devinit setup_secondary_APIC_cloc
 	setup_APIC_timer(calibration_result);
 }
 
-void __devinit disable_APIC_timer(void)
+void disable_APIC_timer(void)
 {
 	if (using_apic_timer) {
 		unsigned long v;
@@ -1080,7 +1093,10 @@ void __devinit disable_APIC_timer(void)
 
 void enable_APIC_timer(void)
 {
-	if (using_apic_timer) {
+	int cpu = smp_processor_id();
+
+	if (using_apic_timer &&
+	    !cpu_isset(cpu, timer_interrupt_broadcast_ipi_mask)) {
 		unsigned long v;
 
 		v = apic_read(APIC_LVTT);
@@ -1088,6 +1104,32 @@ void enable_APIC_timer(void)
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
 #undef APIC_DIVISOR
 
 /*
@@ -1152,6 +1194,38 @@ fastcall void smp_apic_timer_interrupt(s
 	irq_exit();
 }
 
+#ifndef CONFIG_SMP
+static void up_apic_timer_interrupt_call(struct pt_regs *regs)
+{
+	int cpu = smp_processor_id();
+
+	/*
+	 * the NMI deadlock-detector uses this.
+	 */
+	per_cpu(irq_stat, cpu).apic_timer_irqs++;
+
+	smp_local_timer_interrupt(regs);
+}
+#endif
+
+void smp_send_timer_broadcast_ipi(struct pt_regs *regs)
+{
+	cpumask_t mask;
+
+	cpus_and(mask, cpu_online_map, timer_interrupt_broadcast_ipi_mask);
+	if (!cpus_empty(mask)) {
+#ifdef CONFIG_SMP
+		send_IPI_mask(mask, LOCAL_TIMER_VECTOR);
+#else
+		/*
+		 * We can directly call the apic timer interrupt handler 
+		 * in UP case. Minus all irq related functions
+		 */
+		up_apic_timer_interrupt_call(regs);
+#endif
+	}
+}
+
 int setup_profiling_timer(unsigned int multiplier)
 {
 	return -EINVAL;
Index: linux-2.6.15-rc3/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.15-rc3.orig/drivers/acpi/processor_idle.c
+++ linux-2.6.15-rc3/drivers/acpi/processor_idle.c
@@ -929,6 +929,15 @@ static int acpi_processor_power_verify(s
 	unsigned int i;
 	unsigned int working = 0;
 
+#ifdef ARCH_APICTIMER_STOPS_ON_C3
+	struct cpuinfo_x86 *c = cpu_data + pr->id;
+	cpumask_t mask = cpumask_of_cpu(pr->id);
+
+	if (c->x86_vendor == X86_VENDOR_INTEL) {
+		on_each_cpu(switch_ipi_to_APIC_timer, &mask, 1, 1);
+	}
+#endif
+
 	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
 		struct acpi_processor_cx *cx = &pr->power.states[i];
 
@@ -943,6 +952,12 @@ static int acpi_processor_power_verify(s
 
 		case ACPI_STATE_C3:
 			acpi_processor_power_verify_c3(pr, cx);
+#ifdef ARCH_APICTIMER_STOPS_ON_C3
+			if (c->x86_vendor == X86_VENDOR_INTEL) {
+				on_each_cpu(switch_APIC_timer_to_ipi, 
+						&mask, 1, 1);
+			}
+#endif
 			break;
 		}
 
