Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbTDEJ5j (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 04:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbTDEJ5j (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 04:57:39 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:41953 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S261977AbTDEJ5d (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 04:57:33 -0500
Date: Sat, 05 Apr 2003 22:05:51 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: PATCH: swsusp - 2.5.66 incremental
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1049537149.1709.6.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's the first incremental patch for you, Pavel. As requested, I've
sent patches to Alan Cox (ide-disk.c) and Richard Gooch (mtrrs - I
didn't implement the driver model - just attached the relevant portion
and asked for his feedback). This is patch 3, then.

It's pretty simple - just replaces (temporarily) the assembly with code
that we can patch, as we've previously discussed. You'll remember that I
found I needed to use the 2.4 version to get it working - that's what's
included here. Only one small change - it uses longs rather than chars
during copying, making restoring the image take 1/4 of the time. (Not
significant when there are only 2000 pages being saved, but remember
this is groundwork for future patches).

I'm off to bed now. You won't hear from me again for ~36 hours. Feel
free to flame/correct in the meantime :>

Regards,

Nigel


diff -ruN linux-2.5.66-inc02/arch/i386/kernel/Makefile linux-2.5.66-inc03/arch/i386/kernel/Makefile
--- linux-2.5.66-inc02/arch/i386/kernel/Makefile	2003-04-05 20:55:20.000000000 +1200
+++ linux-2.5.66-inc03/arch/i386/kernel/Makefile	2003-04-05 21:07:37.000000000 +1200
@@ -23,7 +23,7 @@
 obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
-obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o suspend_asm.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o swsusp.o
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
 obj-$(CONFIG_EDD)             	+= edd.o
 obj-$(CONFIG_MODULES)		+= module.o
diff -ruN linux-2.5.66-inc02/arch/i386/kernel/swsusp.c linux-2.5.66-inc03/arch/i386/kernel/swsusp.c
--- linux-2.5.66-inc02/arch/i386/kernel/swsusp.c	1970-01-01 12:00:00.000000000 +1200
+++ linux-2.5.66-inc03/arch/i386/kernel/swsusp.c	2003-04-05 21:33:38.000000000 +1200
@@ -0,0 +1,273 @@
+ /*
+  * Copyright 2001-2002 Pavel Machek <pavel@suse.cz>
+  * Based on code
+  * Copyright 2001 Patrick Mochel <mochel@osdl.org>
+  */
+#include <asm/desc.h>
+#include <asm/i387.h>
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/spinlock.h>
+#include <linux/poll.h>
+#include <linux/delay.h>
+#include <linux/sysrq.h>
+#include <linux/compatmac.h>
+#include <linux/proc_fs.h>
+#include <linux/irq.h>
+#include <linux/pm.h>
+#include <linux/device.h>
+#include <linux/suspend.h>
+#include <linux/acpi.h>
+#include <asm/uaccess.h>
+#include <asm/acpi.h>
+#include <asm/tlbflush.h>
+
+/* image of the saved processor state */
+struct swsusp_saved_context {
+	u32 eax, ebx, ecx, edx;
+	u32 esp, ebp, esi, edi;
+	u16 es, fs, gs, ss;
+	u32 cr0, cr2, cr3, cr4;
+	u16 gdt_pad;
+	u16 gdt_limit;
+	u32 gdt_base;
+	u16 idt_pad;
+	u16 idt_limit;
+	u32 idt_base;
+	u16 ldt;
+	u16 tss;
+	u32 tr;
+	u32 safety;
+	u32 return_address;
+	u32 eflags;
+} __attribute__((packed));
+
+struct swsusp_saved_context saved_context;
+
+#define loaddebug(thread,register) \
+               __asm__("movl %0,%%db" #register  \
+                       : /* no output */ \
+                       :"r" ((thread)->debugreg[register]))
+
+ 
+/*
+ * save_processor_context
+ * 
+ * Save the state of the processor before we go to sleep.
+ *
+ * return_stack is the value of the stack pointer (%esp) as the caller sees it.
+ * A good way could not be found to obtain it from here (don't want to make _too_
+ * many assumptions about the layout of the stack this far down.) Also, the 
+ * handy little __builtin_frame_pointer(level) where level > 0, is blatantly 
+ * buggy - it returns the value of the stack at the proper location, not the 
+ * location, like it should (as of gcc 2.91.66)
+ * 
+ * Note that the context and timing of this function is pretty critical.
+ * With a minimal amount of things going on in the caller and in here, gcc
+ * does a good job of being just a dumb compiler.  Watch the assembly output
+ * if anything changes, though, and make sure everything is going in the right
+ * place. 
+ */
+static inline void save_processor_context (void)
+{
+	kernel_fpu_begin();
+
+	/*
+	 * descriptor tables
+	 */
+	asm volatile ("sgdt (%0)" : "=m" (saved_context.gdt_limit));
+	asm volatile ("sidt (%0)" : "=m" (saved_context.idt_limit));
+	asm volatile ("sldt (%0)" : "=m" (saved_context.ldt));
+	asm volatile ("str (%0)"  : "=m" (saved_context.tr));
+
+	/*
+	 * save the general registers.
+	 * note that gcc has constructs to specify output of certain registers,
+	 * but they're not used here, because it assumes that you want to modify
+	 * those registers, so it tries to be smart and save them beforehand.
+	 * It's really not necessary, and kinda fishy (check the assembly output),
+	 * so it's avoided. 
+	 */
+	asm volatile ("movl %%esp, (%0)" : "=m" (saved_context.esp));
+	asm volatile ("movl %%eax, (%0)" : "=m" (saved_context.eax));
+	asm volatile ("movl %%ebx, (%0)" : "=m" (saved_context.ebx));
+	asm volatile ("movl %%ecx, (%0)" : "=m" (saved_context.ecx));
+	asm volatile ("movl %%edx, (%0)" : "=m" (saved_context.edx));
+	asm volatile ("movl %%ebp, (%0)" : "=m" (saved_context.ebp));
+	asm volatile ("movl %%esi, (%0)" : "=m" (saved_context.esi));
+	asm volatile ("movl %%edi, (%0)" : "=m" (saved_context.edi));
+
+	/*
+	 * segment registers
+	 */
+	asm volatile ("movw %%es, %0" : "=r" (saved_context.es));
+	asm volatile ("movw %%fs, %0" : "=r" (saved_context.fs));
+	asm volatile ("movw %%gs, %0" : "=r" (saved_context.gs));
+	asm volatile ("movw %%ss, %0" : "=r" (saved_context.ss));
+
+	/*
+	 * control registers 
+	 */
+	asm volatile ("movl %%cr0, %0" : "=r" (saved_context.cr0));
+	asm volatile ("movl %%cr2, %0" : "=r" (saved_context.cr2));
+	asm volatile ("movl %%cr3, %0" : "=r" (saved_context.cr3));
+	asm volatile ("movl %%cr4, %0" : "=r" (saved_context.cr4));
+
+	/*
+	 * eflags
+	 */
+	asm volatile ("pushfl ; popl (%0)" : "=m" (saved_context.eflags));
+}
+
+static void
+do_fpu_end(void)
+{
+        /* restore FPU regs if necessary */
+	/* Do it out of line so that gcc does not move cr0 load to some stupid place */
+        kernel_fpu_end();
+}
+
+/*
+ * restore_processor_context
+ * 
+ * Restore the processor context as it was before we went to sleep
+ * - descriptor tables
+ * - control registers
+ * - segment registers
+ * - flags
+ * 
+ * Note that it is critical that this function is declared inline.  
+ * It was separated out from restore_state to make that function
+ * a little clearer, but it needs to be inlined because we won't have a
+ * stack when we get here (so we can't push a return address).
+ */
+static inline void restore_processor_context (void)
+{
+	/*
+	 * first restore %ds, so we can access our data properly
+	 */
+	asm volatile (".align 4");
+	asm volatile ("movw %0, %%ds" :: "r" ((u16)__KERNEL_DS));
+
+
+	/*
+	 * control registers
+	 */
+	asm volatile ("movl %0, %%cr4" :: "r" (saved_context.cr4));
+	asm volatile ("movl %0, %%cr3" :: "r" (saved_context.cr3));
+	asm volatile ("movl %0, %%cr2" :: "r" (saved_context.cr2));
+	asm volatile ("movl %0, %%cr0" :: "r" (saved_context.cr0));
+	
+	/*
+	 * segment registers
+	 */
+	asm volatile ("movw %0, %%es" :: "r" (saved_context.es));
+	asm volatile ("movw %0, %%fs" :: "r" (saved_context.fs));
+	asm volatile ("movw %0, %%gs" :: "r" (saved_context.gs));
+	asm volatile ("movw %0, %%ss" :: "r" (saved_context.ss));
+
+	/*
+	 * the other general registers
+	 *
+	 * note that even though gcc has constructs to specify memory 
+	 * input into certain registers, it will try to be too smart
+	 * and save them at the beginning of the function.  This is esp.
+	 * bad since we don't have a stack set up when we enter, and we 
+	 * want to preserve the values on exit. So, we set them manually.
+	 */
+	asm volatile ("movl %0, %%esp" :: "m" (saved_context.esp));
+	asm volatile ("movl %0, %%ebp" :: "m" (saved_context.ebp));
+	asm volatile ("movl %0, %%eax" :: "m" (saved_context.eax));
+	asm volatile ("movl %0, %%ebx" :: "m" (saved_context.ebx));
+	asm volatile ("movl %0, %%ecx" :: "m" (saved_context.ecx));
+	asm volatile ("movl %0, %%edx" :: "m" (saved_context.edx));
+	asm volatile ("movl %0, %%esi" :: "m" (saved_context.esi));
+	asm volatile ("movl %0, %%edi" :: "m" (saved_context.edi));
+
+	/*
+	 * now restore the descriptor tables to their proper values
+	 * ltr is done i fix_processor_context().
+	 */
+	asm volatile ("lgdt (%0)" :: "m" (saved_context.gdt_limit));
+	asm volatile ("lidt (%0)" :: "m" (saved_context.idt_limit));
+	asm volatile ("lldt (%0)" :: "m" (saved_context.ldt));
+
+	fix_processor_context();
+
+	/*
+	 * the flags
+	 */
+	asm volatile ("pushl %0 ; popfl" :: "m" (saved_context.eflags));
+
+	do_fpu_end();
+}
+
+//#ifdef SUSPEND_C
+/* Local variables for do_magic */
+static int loop __nosavedata = 0;
+static int loop2 __nosavedata = 0;
+extern suspend_pagedir_t *pagedir_nosave __nosavedata;
+
+/*
+ * FIXME: This function should really be written in assembly. Actually
+ * requirement is that it does not touch stack, because %esp will be
+ * wrong during resume before restore_processor_context(). Check
+ * assembly if you modify this.
+ */
+void do_swsusp_lowlevel(int resume)
+{
+	if (!resume) {
+		do_magic_suspend_1();
+		save_processor_context();	/* We need to capture registers and memory at "same time" */
+		do_magic_suspend_2();		/* If everything goes okay, this function does not return */
+		return;
+	}
+
+	/* We want to run from swapper_pg_dir, since swapper_pg_dir is stored in constant
+	 * place in memory 
+	 */
+
+        __asm__( "movl %%ecx,%%cr3\n" ::"c"(__pa(swapper_pg_dir)));
+
+/*
+ * Final function for resuming: after copying the pages to their original
+ * position, it restores the register state.
+ *
+ * What about page tables? Writing data pages may toggle
+ * accessed/dirty bits in our page tables. That should be no problems
+ * with 4MB page tables. That's why we require have_pse.  
+ *
+ * This loops destroys stack from under itself, so it better should
+ * not use any stack space, itself. When this function is entered at
+ * resume time, we move stack to _old_ place.  This is means that this
+ * function must use no stack and no local variables in registers,
+ * until calling restore_processor_context();
+ *
+ * Critical section here: noone should touch saved memory after
+ * do_magic_resume_1; copying works, because nr_copy_pages,
+ * pagedir_nosave, loop and loop2 are nosavedata.
+ */
+	do_magic_resume_1();
+
+	for (loop=0; loop < nr_copy_pages; loop++) {
+		/* You may not call something (like copy_page) here: see above */
+		for (loop2=0; loop2 < (PAGE_SIZE / sizeof(unsigned long)); loop2++) {
+			*(((unsigned long *)((pagedir_nosave+loop)->orig_address))+loop2) =
+				*(((unsigned long *)((pagedir_nosave+loop)->address))+loop2);
+			__flush_tlb();
+		}
+		
+	}
+
+	restore_processor_context();
+
+/* Ahah, we now run with our old stack, and with registers copied from
+   suspend time */
+
+	do_magic_resume_2();
+}
+//#endif 
diff -ruN linux-2.5.66-inc02/kernel/suspend.c linux-2.5.66-inc03/kernel/suspend.c
--- linux-2.5.66-inc02/kernel/suspend.c	2003-04-05 20:55:20.000000000 +1200
+++ linux-2.5.66-inc03/kernel/suspend.c	2003-04-05 21:25:18.000000000 +1200
@@ -869,7 +869,7 @@
 			 * unsuspends all device drivers, and writes memory to disk
 			 * using normal kernel mechanism.
 			 */
-			do_magic(0);
+			do_swsusp_lowlevel(0);
 		PRINTK("Restarting processes...\n");
 		thaw_processes();
 	}
@@ -1232,7 +1232,7 @@
 	printk( "resuming from %s\n", resume_file);
 	if(read_suspend_image(resume_file, 0))
 		goto read_failure;
-	do_magic(1);
+	do_swsusp_lowlevel(1);
 	panic("This never returns");
 
 read_failure:



