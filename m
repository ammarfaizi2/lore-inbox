Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbVJYOXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbVJYOXv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 10:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbVJYOXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 10:23:51 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:9963 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932159AbVJYOXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 10:23:50 -0400
Subject: 2.6.14-rc5-rt6  -- False NMI lockup detects
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
Cc: john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 25 Oct 2005 10:23:38 -0400
Message-Id: <1130250219.21118.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo and Thomas,

On some of my machines, I've been experiencing false NMI lockups.  This
usually happens on slower machines, and taking a look into this, it
seems to be due to a short time where no processes are using timers, and
the ktimer interrupts aren't needed. So the APIC timer, which now is
used only for the ktimers, has a five second pause, and causes the NMI
to go off.  The NMI uses the apic timer to determine lockups.

So, I added a more generic method. This only works for x86 for now, but
it has a #ifdef to keep other archs working until it implements this as
well.  I added a nmi_irq_incr which is called by __do_IRQ in the generic
code.  This is what is used in the NMI code to determine if the CPU has
locked up.  This way we don't have to worry about what resource we are
using for timers.

-- Steve

Index: rt_linux_ernie/arch/i386/kernel/nmi.c
===================================================================
--- rt_linux_ernie.orig/arch/i386/kernel/nmi.c	2005-10-25 10:06:23.000000000 -0400
+++ rt_linux_ernie/arch/i386/kernel/nmi.c	2005-10-25 10:06:06.000000000 -0400
@@ -484,6 +484,12 @@
 	touch_softlockup_watchdog();
 }
 
+static DEFINE_PER_CPU(int, nmi_irq_incr);
+void nmi_irq_incr(int cpu)
+{
+	per_cpu(nmi_irq_incr, cpu)++;
+}
+
 extern void die_nmi(struct pt_regs *, const char *msg);
 
 int nmi_show_regs[NR_CPUS];
@@ -521,7 +527,7 @@
 	 */
 	int sum, cpu = smp_processor_id();
 
-	sum = per_cpu(irq_stat, cpu).apic_timer_irqs;
+	sum = per_cpu(nmi_irq_incr, cpu);
 
 	profile_tick(CPU_PROFILING, regs);
 	if (nmi_show_regs[cpu]) {
Index: rt_linux_ernie/arch/i386/kernel/apic.c
===================================================================
--- rt_linux_ernie.orig/arch/i386/kernel/apic.c	2005-10-25 08:49:37.000000000 -0400
+++ rt_linux_ernie/arch/i386/kernel/apic.c	2005-10-25 10:14:37.000000000 -0400
@@ -1161,9 +1161,6 @@
 {
 	int cpu = smp_processor_id();
 
-	/*
-	 * the NMI deadlock-detector uses this.
-	 */
 	per_cpu(irq_stat, cpu).apic_timer_irqs++;
 
         trace_special(regs->eip, 0, 0);
Index: rt_linux_ernie/include/asm-i386/irq.h
===================================================================
--- rt_linux_ernie.orig/include/asm-i386/irq.h	2005-08-28 19:41:01.000000000 -0400
+++ rt_linux_ernie/include/asm-i386/irq.h	2005-10-25 09:59:44.000000000 -0400
@@ -25,6 +25,7 @@
 
 #ifdef CONFIG_X86_LOCAL_APIC
 # define ARCH_HAS_NMI_WATCHDOG		/* See include/linux/nmi.h */
+# define ARCH_HAS_NMI_IRQ_INCR
 #endif
 
 #ifdef CONFIG_4KSTACKS
Index: rt_linux_ernie/include/linux/nmi.h
===================================================================
--- rt_linux_ernie.orig/include/linux/nmi.h	2005-10-25 09:21:06.000000000 -0400
+++ rt_linux_ernie/include/linux/nmi.h	2005-10-25 09:26:28.000000000 -0400
@@ -19,4 +19,10 @@
 # define touch_nmi_watchdog() do { } while(0)
 #endif
 
+#ifdef ARCH_HAS_NMI_IRQ_INCR
+extern void nmi_irq_incr(int cpu);
+#else
+# define nmi_irq_incr(cpu) do { } while(0)
+#endif
+
 #endif
Index: rt_linux_ernie/kernel/irq/handle.c
===================================================================
--- rt_linux_ernie.orig/kernel/irq/handle.c	2005-10-25 08:49:42.000000000 -0400
+++ rt_linux_ernie/kernel/irq/handle.c	2005-10-25 09:45:13.000000000 -0400
@@ -16,6 +16,7 @@
 #include <linux/kallsyms.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
+#include <linux/nmi.h>
 
 #if defined(CONFIG_NO_IDLE_HZ)
 #include <asm/dyntick.h>
@@ -533,6 +534,12 @@
 	if (user_mode(regs))
 		touch_light_softlockup_watchdog();
 
+	/*
+	 * Moved the NMI lockup detect here, since this we really
+	 * know a CPU is locked up when it stops receiving interrupts.
+	 */
+	nmi_irq_incr(smp_processor_id());
+
 	kstat_this_cpu.irqs[irq]++;
 	if (CHECK_IRQ_PER_CPU(desc->status)) {
 		irqreturn_t action_ret;


