Return-Path: <linux-kernel-owner+w=401wt.eu-S965069AbWLTOOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbWLTOOb (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 09:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbWLTOOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 09:14:31 -0500
Received: from madara.hpl.hp.com ([192.6.19.124]:49890 "EHLO madara.hpl.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965069AbWLTOOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 09:14:30 -0500
X-Greylist: delayed 546 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2006 09:14:30 EST
Date: Wed, 20 Dec 2006 06:05:00 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ak@suse.de, Stephane Eranian <eranian@hpl.hp.com>
Subject: [PATCH] add i386 idle notifier (take 3)
Message-ID: <20061220140500.GB30752@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is the latest version of the idle notifier for i386.
This patch is against 2.6.20-rc1 (GIT). In this kernel, the idle
loop code was modified such that the lowest level idle
routines do not have loops anymore (e.g., poll_idle). As such,
we do not need to call enter_idle() in all the interrupt handlers.

This patch also duplicates the x86-64 bug fix for a race condition
as posted by Venkatesh Pallipadi from Intel.

changelog:
	- add idle notification mechanism to i386

signed-off-by: stephane eranian <eranian@hpl.hp.com>

diff --exclude=.git -urNp linux-2.6.orig/arch/i386/kernel/apic.c linux-2.6.base/arch/i386/kernel/apic.c
--- linux-2.6.orig/arch/i386/kernel/apic.c	2006-12-13 16:22:10.000000000 -0800
+++ linux-2.6.base/arch/i386/kernel/apic.c	2006-12-18 04:51:35.000000000 -0800
@@ -36,6 +36,7 @@
 #include <asm/hpet.h>
 #include <asm/i8253.h>
 #include <asm/nmi.h>
+#include <asm/idle.h>
 
 #include <mach_apic.h>
 #include <mach_apicdef.h>
@@ -1255,6 +1256,7 @@ fastcall void smp_apic_timer_interrupt(s
 	 * Besides, if we don't timer interrupts ignore the global
 	 * interrupt lock, which is the WrongThing (tm) to do.
 	 */
+	exit_idle();
 	irq_enter();
 	smp_local_timer_interrupt();
 	irq_exit();
@@ -1305,6 +1307,7 @@ fastcall void smp_spurious_interrupt(str
 {
 	unsigned long v;
 
+	exit_idle();
 	irq_enter();
 	/*
 	 * Check if this really is a spurious interrupt and ACK it
@@ -1329,6 +1332,7 @@ fastcall void smp_error_interrupt(struct
 {
 	unsigned long v, v1;
 
+	exit_idle();
 	irq_enter();
 	/* First tickle the hardware, only then report what went on. -- REW */
 	v = apic_read(APIC_ESR);
diff --exclude=.git -urNp linux-2.6.orig/arch/i386/kernel/cpu/mcheck/p4.c linux-2.6.base/arch/i386/kernel/cpu/mcheck/p4.c
--- linux-2.6.orig/arch/i386/kernel/cpu/mcheck/p4.c	2006-10-17 05:33:35.000000000 -0700
+++ linux-2.6.base/arch/i386/kernel/cpu/mcheck/p4.c	2006-12-18 04:52:37.000000000 -0800
@@ -12,6 +12,7 @@
 #include <asm/system.h>
 #include <asm/msr.h>
 #include <asm/apic.h>
+#include <asm/idle.h>
 
 #include <asm/therm_throt.h>
 
@@ -59,6 +60,7 @@ static void (*vendor_thermal_interrupt)(
 
 fastcall void smp_thermal_interrupt(struct pt_regs *regs)
 {
+	exit_idle();
 	irq_enter();
 	vendor_thermal_interrupt(regs);
 	irq_exit();
diff --exclude=.git -urNp linux-2.6.orig/arch/i386/kernel/irq.c linux-2.6.base/arch/i386/kernel/irq.c
--- linux-2.6.orig/arch/i386/kernel/irq.c	2006-10-26 14:12:56.000000000 -0700
+++ linux-2.6.base/arch/i386/kernel/irq.c	2006-12-18 04:52:42.000000000 -0800
@@ -19,6 +19,8 @@
 #include <linux/cpu.h>
 #include <linux/delay.h>
 
+#include <asm/idle.h>
+
 DEFINE_PER_CPU(irq_cpustat_t, irq_stat) ____cacheline_internodealigned_in_smp;
 EXPORT_PER_CPU_SYMBOL(irq_stat);
 
@@ -61,6 +63,7 @@ fastcall unsigned int do_IRQ(struct pt_r
 	union irq_ctx *curctx, *irqctx;
 	u32 *isp;
 #endif
+	exit_idle();
 
 	if (unlikely((unsigned)irq >= NR_IRQS)) {
 		printk(KERN_EMERG "%s: cannot handle IRQ %d\n",
diff --exclude=.git -urNp linux-2.6.orig/arch/i386/kernel/process.c linux-2.6.base/arch/i386/kernel/process.c
--- linux-2.6.orig/arch/i386/kernel/process.c	2006-12-13 16:22:10.000000000 -0800
+++ linux-2.6.base/arch/i386/kernel/process.c	2006-12-18 04:54:36.000000000 -0800
@@ -48,6 +48,7 @@
 #include <asm/i387.h>
 #include <asm/desc.h>
 #include <asm/vm86.h>
+#include <asm/idle.h>
 #ifdef CONFIG_MATH_EMULATION
 #include <asm/math_emu.h>
 #endif
@@ -80,6 +81,43 @@ void (*pm_idle)(void);
 EXPORT_SYMBOL(pm_idle);
 static DEFINE_PER_CPU(unsigned int, cpu_idle_state);
 
+static ATOMIC_NOTIFIER_HEAD(idle_notifier);
+
+void idle_notifier_register(struct notifier_block *n)
+{
+	atomic_notifier_chain_register(&idle_notifier, n);
+}
+EXPORT_SYMBOL_GPL(idle_notifier_register);
+
+void idle_notifier_unregister(struct notifier_block *n)
+{
+	atomic_notifier_chain_unregister(&idle_notifier, n);
+}
+EXPORT_SYMBOL(idle_notifier_unregister);
+
+static DEFINE_PER_CPU(volatile unsigned long, idle_state);
+
+void enter_idle(void)
+{
+	__get_cpu_var(idle_state) = 1;
+	atomic_notifier_call_chain(&idle_notifier, IDLE_START, NULL);
+}
+
+static void __exit_idle()
+{
+	/* needs to be atomic w.r.t. interrupts, not against other CPUs */
+	if (__test_and_clear_bit(0, &__get_cpu_var(idle_state)) == 0)
+		return;
+	atomic_notifier_call_chain(&idle_notifier, IDLE_END, NULL);
+}
+
+void exit_idle(void)
+{
+	if (current->pid)
+		return;
+	__exit_idle();
+}
+
 void disable_hlt(void)
 {
 	hlt_counter++;
@@ -125,6 +163,7 @@ EXPORT_SYMBOL(default_idle);
  */
 static void poll_idle (void)
 {
+	local_irq_enable();
 	cpu_relax();
 }
 
@@ -184,7 +223,16 @@ void cpu_idle(void)
 				play_dead();
 
 			__get_cpu_var(irq_stat).idle_timestamp = jiffies;
+
+			/*
+			 * Idle routines should keep interrupts disabled
+			 * from here on, until they go to idle.
+			 * Otherwise, idle callbacks can misfire.
+			 */
+			local_irq_disable();
+			enter_idle();
 			idle();
+			__exit_idle();
 		}
 		preempt_enable_no_resched();
 		schedule();
@@ -238,7 +286,11 @@ void mwait_idle_with_hints(unsigned long
 		__monitor((void *)&current_thread_info()->flags, 0, 0);
 		smp_mb();
 		if (!need_resched())
-			__mwait(eax, ecx);
+			__sti_mwait(eax, ecx);
+		else
+			local_irq_enable();
+	} else {
+		local_irq_enable();
 	}
 }
 
diff --exclude=.git -urNp linux-2.6.orig/arch/i386/kernel/smp.c linux-2.6.base/arch/i386/kernel/smp.c
--- linux-2.6.orig/arch/i386/kernel/smp.c	2006-12-13 16:22:10.000000000 -0800
+++ linux-2.6.base/arch/i386/kernel/smp.c	2006-12-18 04:56:30.000000000 -0800
@@ -23,6 +23,7 @@
 
 #include <asm/mtrr.h>
 #include <asm/tlbflush.h>
+#include <asm/idle.h>
 #include <mach_apic.h>
 
 /*
@@ -624,6 +625,7 @@ fastcall void smp_call_function_interrup
 	/*
 	 * At this point the info structure may be out of scope unless wait==1
 	 */
+	exit_idle();
 	irq_enter();
 	(*func)(info);
 	irq_exit();
diff --exclude=.git -urNp linux-2.6.orig/include/asm-i386/idle.h linux-2.6.base/include/asm-i386/idle.h
--- linux-2.6.orig/include/asm-i386/idle.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.base/include/asm-i386/idle.h	2006-12-18 04:49:27.000000000 -0800
@@ -0,0 +1,14 @@
+#ifndef _ASM_I386_IDLE_H
+#define _ASM_I386_IDLE_H 1
+
+#define IDLE_START 1
+#define IDLE_END 2
+
+struct notifier_block;
+void idle_notifier_register(struct notifier_block *n);
+void idle_notifier_unregister(struct notifier_block *n);
+
+void exit_idle(void);
+void enter_idle(void);
+
+#endif
diff --exclude=.git -urNp linux-2.6.orig/include/asm-i386/processor.h linux-2.6.base/include/asm-i386/processor.h
--- linux-2.6.orig/include/asm-i386/processor.h	2006-12-13 16:22:22.000000000 -0800
+++ linux-2.6.base/include/asm-i386/processor.h	2006-12-13 16:38:11.000000000 -0800
@@ -257,6 +257,14 @@ static inline void __mwait(unsigned long
 		: :"a" (eax), "c" (ecx));
 }
 
+static inline void __sti_mwait(unsigned long eax, unsigned long ecx)
+{
+	/* "mwait %eax,%ecx;" */
+	asm volatile(
+		"sti; .byte 0x0f,0x01,0xc9;"
+		: :"a" (eax), "c" (ecx));
+}
+
 extern void mwait_idle_with_hints(unsigned long eax, unsigned long ecx);
 
 /* from system description table in BIOS.  Mostly for MCA use, but
