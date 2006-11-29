Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967465AbWK2Q1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967465AbWK2Q1A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 11:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967467AbWK2Q1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 11:27:00 -0500
Received: from madara.hpl.hp.com ([192.6.19.124]:31941 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S967465AbWK2Q07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 11:26:59 -0500
Date: Wed, 29 Nov 2006 08:25:40 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ak@suse.de, Stephane Eranian <eranian@hpl.hp.com>
Subject: [PATCH] i386 add idle notifier
Message-ID: <20061129162540.GL28007@frankl.hpl.hp.com>
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

Here is a patch that adds an idle notifier to the i386 tree.
The idle notifier functionalities and implementation are
identical to the x86_64 idle notifier. We use the idle notifier
in the context of perfmon.

The patch is against Andi Kleen's x86_64-2.6.19-rc6-061128-1.bz2
kernel. It may apply to other kernels but it needs some updates
to poll_idle() and default_idle() to work correctly.

changelog:
	- add an idle notifier mechanism to i386 tree

signed-off-by: stephane eranian <eranain@hpl.hp.com>

diff --exclude=.gitignore -urNp linux-2.6.19-rc6-ak.orig/arch/i386/kernel/apic.c linux-2.6.19-rc6-ak.base/arch/i386/kernel/apic.c
--- linux-2.6.19-rc6-ak.orig/arch/i386/kernel/apic.c	2006-11-28 13:17:21.000000000 -0800
+++ linux-2.6.19-rc6-ak.base/arch/i386/kernel/apic.c	2006-11-29 06:31:26.000000000 -0800
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
diff --exclude=.gitignore -urNp linux-2.6.19-rc6-ak.orig/arch/i386/kernel/cpu/mcheck/p4.c linux-2.6.19-rc6-ak.base/arch/i386/kernel/cpu/mcheck/p4.c
--- linux-2.6.19-rc6-ak.orig/arch/i386/kernel/cpu/mcheck/p4.c	2006-11-28 13:16:35.000000000 -0800
+++ linux-2.6.19-rc6-ak.base/arch/i386/kernel/cpu/mcheck/p4.c	2006-11-29 06:31:30.000000000 -0800
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
diff --exclude=.gitignore -urNp linux-2.6.19-rc6-ak.orig/arch/i386/kernel/irq.c linux-2.6.19-rc6-ak.base/arch/i386/kernel/irq.c
--- linux-2.6.19-rc6-ak.orig/arch/i386/kernel/irq.c	2006-11-28 13:16:35.000000000 -0800
+++ linux-2.6.19-rc6-ak.base/arch/i386/kernel/irq.c	2006-11-29 06:31:34.000000000 -0800
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
diff --exclude=.gitignore -urNp linux-2.6.19-rc6-ak.orig/arch/i386/kernel/process.c linux-2.6.19-rc6-ak.base/arch/i386/kernel/process.c
--- linux-2.6.19-rc6-ak.orig/arch/i386/kernel/process.c	2006-11-28 13:17:21.000000000 -0800
+++ linux-2.6.19-rc6-ak.base/arch/i386/kernel/process.c	2006-11-29 06:55:58.000000000 -0800
@@ -48,6 +48,7 @@
 #include <asm/i387.h>
 #include <asm/desc.h>
 #include <asm/vm86.h>
+#include <asm/idle.h>
 #ifdef CONFIG_MATH_EMULATION
 #include <asm/math_emu.h>
 #endif
@@ -80,6 +81,46 @@ void (*pm_idle)(void);
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
+	/* needs to be atomic w.r.t. interrupts, not against other CPUs */
+	__set_bit(0, &__get_cpu_var(idle_state));
+	atomic_notifier_call_chain(&idle_notifier, IDLE_START, NULL);
+}
+
+void __exit_idle(void)
+{
+	/* needs to be atomic w.r.t. interrupts, not against other CPUs */
+	if (__test_and_clear_bit(0, &__get_cpu_var(idle_state)) == 0)
+		return;
+	atomic_notifier_call_chain(&idle_notifier, IDLE_END, NULL);
+}
+
+/* Called from interrupts to signify idle end */
+void exit_idle(void)
+{
+	/* idle loop has pid 0 */
+	if (current->pid)
+		return;
+	__exit_idle();
+}
+
 void disable_hlt(void)
 {
 	hlt_counter++;
@@ -184,7 +225,9 @@ void cpu_idle(void)
 				play_dead();
 
 			__get_cpu_var(irq_stat).idle_timestamp = jiffies;
+			enter_idle();
 			idle();
+			__exit_idle();
 		}
 		preempt_enable_no_resched();
 		schedule();
diff --exclude=.gitignore -urNp linux-2.6.19-rc6-ak.orig/arch/i386/kernel/smp.c linux-2.6.19-rc6-ak.base/arch/i386/kernel/smp.c
--- linux-2.6.19-rc6-ak.orig/arch/i386/kernel/smp.c	2006-11-28 13:16:35.000000000 -0800
+++ linux-2.6.19-rc6-ak.base/arch/i386/kernel/smp.c	2006-11-29 06:31:38.000000000 -0800
@@ -23,6 +23,7 @@
 
 #include <asm/mtrr.h>
 #include <asm/tlbflush.h>
+#include <asm/idle.h>
 #include <mach_apic.h>
 
 /*
@@ -629,6 +630,7 @@ fastcall void smp_call_function_interrup
 	/*
 	 * At this point the info structure may be out of scope unless wait==1
 	 */
+	exit_idle();
 	irq_enter();
 	(*func)(info);
 	irq_exit();
diff --exclude=.gitignore -urNp linux-2.6.19-rc6-ak.orig/include/asm-i386/idle.h linux-2.6.19-rc6-ak.base/include/asm-i386/idle.h
--- linux-2.6.19-rc6-ak.orig/include/asm-i386/idle.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.19-rc6-ak.base/include/asm-i386/idle.h	2006-11-29 06:35:06.000000000 -0800
@@ -0,0 +1,15 @@
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
+}
+
+#endif
