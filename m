Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbVLIRxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbVLIRxO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 12:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbVLIRxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 12:53:14 -0500
Received: from fmr24.intel.com ([143.183.121.16]:40645 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S964826AbVLIRxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 12:53:13 -0500
Date: Fri, 9 Dec 2005 09:52:43 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Rohit Seth <rohit.seth@intel.com>,
       Len Brown <len.brown@intel.com>
Subject: Re: [RFC][PATCH 2/3]i386,x86-64 Handle missing local APIC timer interrupts on C3 state
Message-ID: <20051209095243.A22139@unix-os.sc.intel.com>
References: <20051208181040.C32524@unix-os.sc.intel.com> <Pine.LNX.4.64.0512090003460.26307@montezuma.fsmlabs.com> <20051209044938.A26619@unix-os.sc.intel.com> <Pine.LNX.4.64.0512090933540.26307@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.64.0512090933540.26307@montezuma.fsmlabs.com>; from zwane@arm.linux.org.uk on Fri, Dec 09, 2005 at 09:35:36AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 09:35:36AM -0800, Zwane Mwaikambo wrote:
> > +void switch_ipi_to_APIC_timer(void *cpumask);
> > Called by acpi processor driver again to reset to APIC_timer when C3 is not 
> > supported by the CPU.
> 
> Well i was more curious as to where in the patchset the 
> switch_ipi_to_APIC_timer is used;
> 
> zwane@montezuma linux-2.6-hg-x86_64 {0:1} grep switch_ipi_to_APIC_timer /tmp/patch[1234]
> /tmp/patch2:+void switch_ipi_to_APIC_timer(void *cpumask);
> /tmp/patch2:+void switch_ipi_to_APIC_timer(void *cpumask)
> /tmp/patch2:+EXPORT_SYMBOL(switch_ipi_to_APIC_timer);
> /tmp/patch4:+void switch_ipi_to_APIC_timer(void *cpumask)
> /tmp/patch4:+EXPORT_SYMBOL(switch_ipi_to_APIC_timer);
> /tmp/patch4:+void switch_ipi_to_APIC_timer(void *cpumask);
> 
> Or will it only be used in future?
> 

That calls for updated patch 2/3 (That was a typo on my original patch :()

Both switch_ipi_to_APIC_timer and switch_APIC_timer_to_ipi are called in
acpi/processor_idle.c in this patch.

--

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
@@ -1068,7 +1076,7 @@ void __devinit setup_secondary_APIC_cloc
 	setup_APIC_timer(calibration_result);
 }
 
-void __devinit disable_APIC_timer(void)
+void disable_APIC_timer(void)
 {
 	if (using_apic_timer) {
 		unsigned long v;
@@ -1088,6 +1096,32 @@ void enable_APIC_timer(void)
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
@@ -1152,6 +1186,36 @@ fastcall void smp_apic_timer_interrupt(s
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
+	if (!cpus_empty(timer_interrupt_broadcast_ipi_mask)) {
+#ifdef CONFIG_SMP
+		send_IPI_mask(timer_interrupt_broadcast_ipi_mask, 
+		              LOCAL_TIMER_VECTOR);
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
 

