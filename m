Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264432AbTEJQ2q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 12:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264435AbTEJQ2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 12:28:46 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:10221 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264432AbTEJQ2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 12:28:40 -0400
Date: Sat, 10 May 2003 18:41:14 +0200 (MEST)
Message-Id: <200305101641.h4AGfEVE002970@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: torvalds@transmeta.com
Subject: Re: [PATCH] restore sysenter MSRs at resume
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003 10:39:35 -0700 (PDT), Linus Torvalds wrote:
>On Wed, 7 May 2003 mikpe@csd.uu.se wrote:
>> I could probably get away with simply having apm.c invoke the C code
>> in suspend.c, which does restore the SYSENTER MSRs. suspend.c itself
>> doesn't seem to depend on the SOFTWARE_SUSPEND machinery, but
>> suspend_asm.S does.
>> 
>> Does that sound reasonable?
>
>Sounds reasonable to me. In fact, it looks like it really already exists
>as the current "restore_processor_state()" thing.
>
>In fact, that one already _does_ call "enable_sep_cpu()", so what's up?

This patch should be better. It changes apm.c to invoke
suspend.c's save and restore processor state procedures
around suspends, which fixes the SYSENTER MSR problem.

The patch also decouples sysenter.c from SOFTWARE_SUSPEND:
the variables used (only!) in suspend_asm.S are moved there,
and the include file now declares the procedures called from
apm.c (previously they were only called from suspend_asm.S).

/Mikael

--- linux-2.5.69/arch/i386/kernel/Makefile.~1~	2003-05-05 22:56:28.000000000 +0200
+++ linux-2.5.69/arch/i386/kernel/Makefile	2003-05-10 16:24:56.710471008 +0200
@@ -17,7 +17,7 @@
 obj-$(CONFIG_X86_MSR)		+= msr.o
 obj-$(CONFIG_X86_CPUID)		+= cpuid.o
 obj-$(CONFIG_MICROCODE)		+= microcode.o
-obj-$(CONFIG_APM)		+= apm.o
+obj-$(CONFIG_APM)		+= apm.o suspend.o
 obj-$(CONFIG_X86_SMP)		+= smp.o smpboot.o
 obj-$(CONFIG_X86_TRAMPOLINE)	+= trampoline.o
 obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
--- linux-2.5.69/arch/i386/kernel/apm.c.~1~	2003-05-05 22:56:28.000000000 +0200
+++ linux-2.5.69/arch/i386/kernel/apm.c	2003-05-10 16:27:40.556562616 +0200
@@ -226,6 +226,7 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/desc.h>
+#include <asm/suspend.h>
 
 #include "io_ports.h"
 
@@ -1212,7 +1213,9 @@
 	spin_unlock(&i8253_lock);
 	write_sequnlock_irq(&xtime_lock);
 
+	save_processor_state();
 	err = set_system_power_state(APM_STATE_SUSPEND);
+	restore_processor_state();
 
 	write_seqlock_irq(&xtime_lock);
 	spin_lock(&i8253_lock);
--- linux-2.5.69/arch/i386/kernel/suspend.c.~1~	2003-04-20 13:08:15.000000000 +0200
+++ linux-2.5.69/arch/i386/kernel/suspend.c	2003-05-10 16:24:02.261748472 +0200
@@ -27,9 +27,7 @@
 #include <asm/tlbflush.h>
 
 static struct saved_context saved_context;
-unsigned long saved_context_eax, saved_context_ebx, saved_context_ecx, saved_context_edx;
-unsigned long saved_context_esp, saved_context_ebp, saved_context_esi, saved_context_edi;
-unsigned long saved_context_eflags;
+static void fix_processor_context(void);
 
 extern void enable_sep_cpu(void *);
 
@@ -107,7 +105,7 @@
 	do_fpu_end();
 }
 
-void fix_processor_context(void)
+static void fix_processor_context(void)
 {
 	int cpu = smp_processor_id();
 	struct tss_struct * t = init_tss + cpu;
--- linux-2.5.69/arch/i386/kernel/suspend_asm.S.~1~	2003-01-02 14:27:54.000000000 +0100
+++ linux-2.5.69/arch/i386/kernel/suspend_asm.S	2003-05-10 16:19:58.000000000 +0200
@@ -6,6 +6,28 @@
 #include <asm/segment.h>
 #include <asm/page.h>
 
+	.data
+saved_context_eax:
+	.long	0
+saved_context_ebx:
+	.long	0
+saved_context_ecx:
+	.long	0
+saved_context_edx:
+	.long	0
+saved_context_esp:
+	.long	0
+saved_context_ebp:
+	.long	0
+saved_context_esi:
+	.long	0
+saved_context_edi:
+	.long	0
+saved_context_eflags:
+	.long	0
+
+	.text
+
 ENTRY(do_magic)
 	pushl %ebx
 	cmpl $0,8(%esp)
--- linux-2.5.69/include/asm-i386/suspend.h.~1~	2002-11-23 17:59:41.000000000 +0100
+++ linux-2.5.69/include/asm-i386/suspend.h	2003-05-10 16:23:26.257221992 +0200
@@ -30,18 +30,14 @@
 	unsigned long return_address;
 } __attribute__((packed));
 
-/* We'll access these from assembly, so we'd better have them outside struct */
-extern unsigned long saved_context_eax, saved_context_ebx, saved_context_ecx, saved_context_edx;
-extern unsigned long saved_context_esp, saved_context_ebp, saved_context_esi, saved_context_edi;
-extern unsigned long saved_context_eflags;
-
-
 #define loaddebug(thread,register) \
                __asm__("movl %0,%%db" #register  \
                        : /* no output */ \
                        :"r" ((thread)->debugreg[register]))
 
-extern void fix_processor_context(void);
+extern void save_processor_state(void);
+extern void restore_processor_state(void);
+
 extern void do_magic(int resume);
 
 #ifdef CONFIG_ACPI_SLEEP


