Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVACMcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVACMcG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 07:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVACMcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 07:32:06 -0500
Received: from [220.248.27.114] ([220.248.27.114]:3733 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S261432AbVACMbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 07:31:48 -0500
Date: Mon, 3 Jan 2005 20:26:53 +0800
From: hugang@soulinfo.com
To: linux-kernel@vger.kernel.org
Subject: [hugang@soulinfo.com: [PATH]software suspend for ppc.]
Message-ID: <20050103122653.GB8827@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Forwarded message from hugang@soulinfo.com -----

Date: Mon, 3 Jan 2005 20:25:57 +0800
To: benh@kernel.crashing.org
Subject: [PATH]software suspend for ppc.

Hi Benjamin Herrenschmidt:

  Here is a patch to make ppc32 support suspend, Test passed in my
  PowerBook, against with 2.6.10-mm1. Have a look. :)

  I'm also someone can do more test with it. 

  thanks.

--- 2.6.10-mm1/arch/ppc/Kconfig	2005-01-03 18:53:25.000000000 +0800
+++ 2.6.10-mm1-swsusp//arch/ppc/Kconfig	2005-01-03 19:00:44.000000000 +0800
@@ -1062,6 +1062,8 @@ config PROC_HARDWARE
 
 source "drivers/zorro/Kconfig"
 
+source "kernel/power/Kconfig"
+
 endmenu
 
 menu "Bus options"
--- 2.6.10-mm1/arch/ppc/kernel/Makefile	2005-01-03 18:53:25.000000000 +0800
+++ 2.6.10-mm1-swsusp//arch/ppc/kernel/Makefile	2005-01-03 19:16:34.000000000 +0800
@@ -16,6 +16,7 @@ obj-y				:= entry.o traps.o irq.o idle.o
 					semaphore.o syscalls.o setup.o \
 					cputable.o ppc_htab.o perfmon.o
 obj-$(CONFIG_6xx)		+= l2cr.o cpu_setup_6xx.o
+obj-$(CONFIG_SOFTWARE_SUSPEND) += swsusp.o
 obj-$(CONFIG_POWER4)		+= cpu_setup_power4.o
 obj-$(CONFIG_MODULES)		+= module.o ppc_ksyms.o
 obj-$(CONFIG_NOT_COHERENT_CACHE)	+= dma-mapping.o
--- 2.6.10-mm1/arch/ppc/kernel/signal.c	2005-01-03 18:53:25.000000000 +0800
+++ 2.6.10-mm1-swsusp//arch/ppc/kernel/signal.c	2005-01-03 19:03:39.000000000 +0800
@@ -28,6 +28,7 @@
 #include <linux/elf.h>
 #include <linux/tty.h>
 #include <linux/binfmts.h>
+#include <linux/suspend.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -704,6 +705,14 @@ int do_signal(sigset_t *oldset, struct p
 	unsigned long frame, newsp;
 	int signr, ret;
 
+	if (current->flags & PF_FREEZE) {
+		refrigerator(PF_FREEZE);
+		signr = 0;
+		ret = regs->gpr[3];
+		if (!signal_pending(current))
+			goto no_signal;
+	}
+
 	if (!oldset)
 		oldset = &current->blocked;
 
@@ -726,6 +735,7 @@ int do_signal(sigset_t *oldset, struct p
 			regs->gpr[3] = EINTR;
 			/* note that the cr0.SO bit is already set */
 		} else {
+no_signal:
 			regs->nip -= 4;	/* Back up & retry system call */
 			regs->result = 0;
 			regs->trap = 0;
--- /dev/null	2004-06-07 18:45:47.000000000 +0800
+++ 2.6.10-mm1-swsusp//arch/ppc/kernel/swsusp.c	2005-01-03 20:15:06.000000000 +0800
@@ -0,0 +1,88 @@
+/*
+ * Written by Hu Gang (hugang@soulinfo.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
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
+#include <linux/proc_fs.h>
+#include <linux/irq.h>
+#include <linux/pm.h>
+#include <linux/adb.h>
+#include <linux/cuda.h>
+#include <linux/pmu.h>
+#include <linux/device.h>
+#include <linux/suspend.h>
+#include <asm/mmu_context.h>
+#include <asm/uaccess.h>
+#include <asm/suspend.h>
+
+#include "cpu_context.h"
+
+extern suspend_pagedir_t *pagedir_nosave __nosavedata;
+extern int nr_copy_pages __nosavedata;
+
+extern asmlinkage int swsusp_save(void);
+
+static void inline do_swsusp_copyback(void)
+{
+	register int i = 0; 
+	
+	for (i = 0; i < nr_copy_pages; i++) {
+		register int loop;
+		register unsigned long *orig, *copy;
+		
+		copy = (unsigned long *)pagedir_nosave[i].address;
+		orig = (unsigned long *)pagedir_nosave[i].orig_address;
+		
+		for (loop = 0; 
+		     loop < (PAGE_SIZE / sizeof(unsigned long));
+		     loop ++)
+			*(orig + loop) = *(copy + loop);
+	}
+}
+
+static struct saved_context swsusp_saved_context;
+
+void save_processor_state(void)
+{
+	__save_processor_state(&swsusp_saved_context);
+}
+
+void restore_processor_state(void)
+{
+	__restore_processor_state(&swsusp_saved_context);
+}
+
+void __flush_tlb_global(void)
+{
+	/* do nothing */
+}
+
+static struct saved_context saved_context;
+
+void swsusp_arch_suspend(void)
+{
+	save_context();
+	__save_processor_state(&saved_context);
+	swsusp_save();
+}
+
+void swsusp_arch_resume(void)
+{
+	save_context();
+	do_swsusp_copyback();
+	__restore_processor_state(&saved_context);
+	restore_context();
+}
--- /dev/null	2004-06-07 18:45:47.000000000 +0800
+++ 2.6.10-mm1-swsusp//arch/ppc/kernel/cpu_context.h	2005-01-03 20:16:09.000000000 +0800
@@ -0,0 +1,89 @@
+/*
+ * Written by Hu Gang (hugang@soulinfo.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+void inline __save_processor_state(struct saved_context *s)
+{
+	/*asm volatile ("mflr 0; stw 0,%0" : "=m" (s->lr));*/
+	asm volatile ("mfcr 0; stw 0,%0" : "=m" (s->cr));
+	asm volatile ("stw 1,%0" : "=m" (s->sp));
+	asm volatile ("stw 2,%0" : "=m" (s->r2));
+	asm volatile ("stmw 12,%0" : "=m" (s->r12));
+
+	/* Save MSR & SDR1 */
+	asm volatile ("mfmsr 4; stw 4,%0" : "=m" (s->msr));
+	asm volatile ("mfsdr1 4; stw 4,%0": "=m" (s->sdr1));
+
+	/* Get a stable timebase and save it */
+	asm volatile ("1:\n"
+		      "mftbu 4;stw 4,%0\n"
+		      "mftb  5;stw 5,%1\n"
+		      "mftbu 3\n"
+		      "cmpw 3,4;\n"
+			  "bne 1b" : 
+			  "=m" (s->tb1),
+			  "=m" (s->tb2));
+		
+	/* Save SPRGs */
+	asm volatile ("mfsprg 4,0; stw 4,%0 " : "=m" (s->sprg[0]));
+	asm volatile ("mfsprg 4,1; stw 4,%0 " : "=m" (s->sprg[1]));
+	asm volatile ("mfsprg 4,2; stw 4,%0 " : "=m" (s->sprg[2]));
+	asm volatile ("mfsprg 4,3; stw 4,%0 " : "=m" (s->sprg[3]));
+}
+
+void inline __restore_processor_state(struct saved_context *s)
+{
+	/* Restore the BATs, and SDR1 */
+	asm volatile ("lwz 4,%0; mtsdr1 4" : "=m" (s->sdr1));
+	/* asm volatile ("lwz 3,%0" : "=m" (saved_context.msr)); */
+
+	asm volatile ("lwz 4,%0; mtsprg 0,4": "=m" (s->sprg[0]));
+	asm volatile ("lwz 4,%0; mtsprg 1,4": "=m" (s->sprg[1]));
+	asm volatile ("lwz 4,%0; mtsprg 2,4": "=m" (s->sprg[2]));
+	asm volatile ("lwz 4,%0; mtsprg 3,4": "=m" (s->sprg[3]));
+
+	/* Restore TB */
+	asm volatile ("li 3,0; mttbl 3; \n"
+		      "lwz 3,%0\n; lwz 4,%1\n"
+		      "mttbu 3; mttbl 4" :
+		      "=m" (s->tb1),
+		      "=m" (s->tb2));
+
+	/* Restore the callee-saved registers and return */
+	asm volatile ("lmw 12,%0" : "=m" (s->r12)); 
+	asm volatile ("lwz 2,%0" : "=m" (s->r2));
+	asm volatile ("lwz 1,%0" : "=m" (s->sp));
+	asm volatile ("lwz 0,%0; mtcr 0" : "=m" (s->cr)); 	
+	/*asm volatile ("lwz 0,%0; mtlr 0" : "=m" (s->lr));*/
+}
+
+static inline void save_context(void)
+{
+	pmu_suspend();
+}
+
+extern void enable_kernel_altivec(void);
+
+static inline void restore_context(void)
+{
+	printk("set context: <%p>\n", current);
+	set_context(current->active_mm->context,
+			current->active_mm->pgd);
+
+	printk("pmu_resume\n");
+	pmu_resume();
+
+#ifdef CONFIG_ALTIVEC
+	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_ALTIVEC) {
+		printk("enable altivec\n");
+		enable_kernel_altivec();
+	}
+#endif
+	printk("enable fp\n");
+	enable_kernel_fp();
+}
--- 2.6.10-mm1/arch/ppc/kernel/vmlinux.lds.S	2004-12-30 14:55:39.000000000 +0800
+++ 2.6.10-mm1-swsusp//arch/ppc/kernel/vmlinux.lds.S	2005-01-03 19:04:05.000000000 +0800
@@ -74,6 +74,12 @@ SECTIONS
     CONSTRUCTORS
   }
 
+  . = ALIGN(4096);
+  __nosave_begin = .;
+  .data_nosave : { *(.data.nosave) }
+  . = ALIGN(4096);
+  __nosave_end = .;
+
   . = ALIGN(32);
   .data.cacheline_aligned : { *(.data.cacheline_aligned) }
 
--- /dev/null	2004-06-07 18:45:47.000000000 +0800
+++ 2.6.10-mm1-swsusp//include/asm-ppc/suspend.h	2005-01-03 19:35:02.000000000 +0800
@@ -0,0 +1,28 @@
+/*
+ * Written by Hu Gang (hugang@soulinfo.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_PPC_SUSPEND_H_
+#define _ASM_PPC_SUSPEND_H_
+
+static inline int
+arch_prepare_suspend(void)
+{
+
+	return 0;
+}
+
+/* image of the saved processor states */
+struct saved_context {
+	u32 lr, cr, sp, r2;
+	u64 r12;
+	u32 sprg[4];
+	u32 msr, sdr1, tb1, tb2;
+} __attribute__((packed));
+
+#endif
--- 2.6.10-mm1/include/linux/suspend.h	2005-01-03 18:53:51.000000000 +0800
+++ 2.6.10-mm1-swsusp//include/linux/suspend.h	2005-01-03 19:32:29.000000000 +0800
@@ -1,7 +1,7 @@
 #ifndef _LINUX_SWSUSP_H
 #define _LINUX_SWSUSP_H
 
-#if defined(CONFIG_X86) || defined(CONFIG_FRV)
+#if defined(CONFIG_X86) || defined(CONFIG_FRV) || defined(CONFIG_PPC32)
 #include <asm/suspend.h>
 #endif
 #include <linux/swap.h>
-- 
Hu Gang       .-.
              /v\
             // \\ 
Linux User  /(   )\  [204016]
GPG Key ID   ^^-^^   http://soulinfo.com/~hugang/hugang.asc

----- End forwarded message -----

-- 
Hu Gang       .-.
              /v\
             // \\ 
Linux User  /(   )\  [204016]
GPG Key ID   ^^-^^   http://soulinfo.com/~hugang/hugang.asc
