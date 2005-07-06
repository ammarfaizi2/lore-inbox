Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbVGFCbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbVGFCbM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 22:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbVGFC3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 22:29:23 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:64152 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262045AbVGFCTS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:18 -0400
Subject: [PATCH] [18/48] Suspend2 2.1.9.8 for 2.6.12: 501-tlb-flushing-functions.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:41 +1000
Message-Id: <11206164411236@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 510-version-specific-mac.patch-old/arch/ppc/Kconfig 510-version-specific-mac.patch-new/arch/ppc/Kconfig
--- 510-version-specific-mac.patch-old/arch/ppc/Kconfig	2005-06-20 11:46:44.000000000 +1000
+++ 510-version-specific-mac.patch-new/arch/ppc/Kconfig	2005-07-04 23:14:19.000000000 +1000
@@ -1081,7 +1081,7 @@ config PROC_HARDWARE
 
 source "drivers/zorro/Kconfig"
 
-source kernel/power/Kconfig
+source "kernel/power/Kconfig"
 
 endmenu
 
diff -ruNp 510-version-specific-mac.patch-old/arch/ppc/kernel/signal.c 510-version-specific-mac.patch-new/arch/ppc/kernel/signal.c
--- 510-version-specific-mac.patch-old/arch/ppc/kernel/signal.c	2005-07-06 11:25:14.000000000 +1000
+++ 510-version-specific-mac.patch-new/arch/ppc/kernel/signal.c	2005-07-04 23:14:19.000000000 +1000
@@ -711,6 +711,15 @@ int do_signal(sigset_t *oldset, struct p
 			goto no_signal;
 	}
 
+	if (freezing(current)) {
+		try_to_freeze();
+		signr = 0;
+		ret = regs->gpr[3];
+		recalc_sigpending();
+		if (!signal_pending(current))
+			goto no_signal;
+	}
+
 	if (!oldset)
 		oldset = &current->blocked;
 
diff -ruNp 510-version-specific-mac.patch-old/arch/ppc/kernel/swsusp.c 510-version-specific-mac.patch-new/arch/ppc/kernel/swsusp.c
--- 510-version-specific-mac.patch-old/arch/ppc/kernel/swsusp.c	1970-01-01 10:00:00.000000000 +1000
+++ 510-version-specific-mac.patch-new/arch/ppc/kernel/swsusp.c	2005-07-04 23:14:19.000000000 +1000
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
diff -ruNp 510-version-specific-mac.patch-old/arch/ppc/kernel/vmlinux.lds.S 510-version-specific-mac.patch-new/arch/ppc/kernel/vmlinux.lds.S
--- 510-version-specific-mac.patch-old/arch/ppc/kernel/vmlinux.lds.S	2005-06-20 11:46:45.000000000 +1000
+++ 510-version-specific-mac.patch-new/arch/ppc/kernel/vmlinux.lds.S	2005-07-04 23:14:19.000000000 +1000
@@ -80,6 +80,12 @@ SECTIONS
   . = ALIGN(4096);
   __nosave_end = .;
 
+  . = ALIGN(4096);
+  __nosave_begin = .;
+  .data_nosave : { *(.data.nosave) }
+  . = ALIGN(4096);
+  __nosave_end = .;
+
   . = ALIGN(32);
   .data.cacheline_aligned : { *(.data.cacheline_aligned) }
 
diff -ruNp 510-version-specific-mac.patch-old/arch/ppc/mm/init.c 510-version-specific-mac.patch-new/arch/ppc/mm/init.c
--- 510-version-specific-mac.patch-old/arch/ppc/mm/init.c	2005-06-20 11:46:45.000000000 +1000
+++ 510-version-specific-mac.patch-new/arch/ppc/mm/init.c	2005-07-04 23:14:19.000000000 +1000
@@ -32,6 +32,7 @@
 #include <linux/highmem.h>
 #include <linux/initrd.h>
 #include <linux/pagemap.h>
+#include <linux/suspend.h>
 
 #include <asm/pgalloc.h>
 #include <asm/prom.h>
@@ -150,6 +151,7 @@ static void free_sec(unsigned long start
 
 	while (start < end) {
 		ClearPageReserved(virt_to_page(start));
+		ClearPageNosave(virt_to_page(start));
 		set_page_count(virt_to_page(start), 1);
 		free_page(start);
 		cnt++;
@@ -190,6 +192,7 @@ void free_initrd_mem(unsigned long start
 
 	for (; start < end; start += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(start));
+		ClearPageNosave(virt_to_page(start));
 		set_page_count(virt_to_page(start), 1);
 		free_page(start);
 		totalram_pages++;
@@ -425,8 +428,10 @@ void __init mem_init(void)
 	/* if we are booted from BootX with an initial ramdisk,
 	   make sure the ramdisk pages aren't reserved. */
 	if (initrd_start) {
-		for (addr = initrd_start; addr < initrd_end; addr += PAGE_SIZE)
+		for (addr = initrd_start; addr < initrd_end; addr += PAGE_SIZE) {
 			ClearPageReserved(virt_to_page(addr));
+			ClearPageNosave(virt_to_page(addr));
+		}
 	}
 #endif /* CONFIG_BLK_DEV_INITRD */
 
@@ -452,6 +457,12 @@ void __init mem_init(void)
 	     addr += PAGE_SIZE) {
 		if (!PageReserved(virt_to_page(addr)))
 			continue;
+		/*
+		 * Mark nosave pages
+		 */
+		if (addr >= (void *)&__nosave_begin && addr < (void *)&__nosave_end)
+			SetPageNosave(virt_to_page(addr));
+
 		if (addr < (ulong) etext)
 			codepages++;
 		else if (addr >= (unsigned long)&__init_begin
@@ -469,6 +480,7 @@ void __init mem_init(void)
 			struct page *page = mem_map + pfn;
 
 			ClearPageReserved(page);
+			ClearPageNosave(page);
 			set_bit(PG_highmem, &page->flags);
 			set_page_count(page, 1);
 			__free_page(page);
diff -ruNp 510-version-specific-mac.patch-old/arch/ppc/platforms/pmac_feature.c 510-version-specific-mac.patch-new/arch/ppc/platforms/pmac_feature.c
--- 510-version-specific-mac.patch-old/arch/ppc/platforms/pmac_feature.c	2005-06-20 11:46:45.000000000 +1000
+++ 510-version-specific-mac.patch-new/arch/ppc/platforms/pmac_feature.c	2005-07-04 23:14:19.000000000 +1000
@@ -2291,7 +2291,10 @@ static struct pmac_mb_def pmac_mb_defs[]
 	},
 	{	"PowerBook5,1",			"PowerBook G4 17\"",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
-		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
+#ifdef CONFIG_SOFTWARE_REPLACE_SLEEP
+		| PMAC_MB_CAN_SLEEP,
+#endif
 	},
 	{	"PowerBook5,2",			"PowerBook G4 15\"",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
diff -ruNp 510-version-specific-mac.patch-old/arch/ppc/syslib/of_device.c 510-version-specific-mac.patch-new/arch/ppc/syslib/of_device.c
--- 510-version-specific-mac.patch-old/arch/ppc/syslib/of_device.c	2004-11-03 21:55:03.000000000 +1100
+++ 510-version-specific-mac.patch-new/arch/ppc/syslib/of_device.c	2005-07-04 23:14:19.000000000 +1000
@@ -104,7 +104,7 @@ static int of_device_remove(struct devic
 	return 0;
 }
 
-static int of_device_suspend(struct device *dev, u32 state)
+static int of_device_suspend(struct device *dev, pm_message_t state)
 {
 	struct of_device * of_dev = to_of_device(dev);
 	struct of_platform_driver * drv = to_of_platform_driver(dev->driver);
diff -ruNp 510-version-specific-mac.patch-old/drivers/macintosh/Kconfig 510-version-specific-mac.patch-new/drivers/macintosh/Kconfig
--- 510-version-specific-mac.patch-old/drivers/macintosh/Kconfig	2005-06-20 11:46:55.000000000 +1000
+++ 510-version-specific-mac.patch-new/drivers/macintosh/Kconfig	2005-07-04 23:14:19.000000000 +1000
@@ -195,4 +195,8 @@ config ANSLCD
 	tristate "Support for ANS LCD display"
 	depends on ADB_CUDA && PPC_PMAC
 
+config SOFTWARE_REPLACE_SLEEP
+	bool "Using Software suspend replace broken sleep function"
+	depends on SOFTWARE_SUSPEND2
+
 endmenu
diff -ruNp 510-version-specific-mac.patch-old/drivers/macintosh/via-pmu.c 510-version-specific-mac.patch-new/drivers/macintosh/via-pmu.c
--- 510-version-specific-mac.patch-old/drivers/macintosh/via-pmu.c	2005-07-06 11:25:14.000000000 +1000
+++ 510-version-specific-mac.patch-new/drivers/macintosh/via-pmu.c	2005-07-04 23:14:19.000000000 +1000
@@ -2894,6 +2894,13 @@ pmu_ioctl(struct inode * inode, struct f
 			return -EACCES;
 		if (sleep_in_progress)
 			return -EBUSY;
+#ifdef CONFIG_SOFTWARE_REPLACE_SLEEP
+		{
+		extern void software_suspend_pending(void);
+		software_suspend_pending();
+		return (0);
+		}
+#endif
 		sleep_in_progress = 1;
 		switch (pmu_kind) {
 		case PMU_OHARE_BASED:
diff -ruNp 510-version-specific-mac.patch-old/include/asm-ppc/cpu_context.h 510-version-specific-mac.patch-new/include/asm-ppc/cpu_context.h
--- 510-version-specific-mac.patch-old/include/asm-ppc/cpu_context.h	1970-01-01 10:00:00.000000000 +1000
+++ 510-version-specific-mac.patch-new/include/asm-ppc/cpu_context.h	2005-07-04 23:14:19.000000000 +1000
@@ -0,0 +1,98 @@
+/*
+ * Written by Hu Gang (hugang@soulinfo.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+/* image of the saved processor states */
+struct saved_context {
+	u32 lr, cr, sp, r2;
+	u32 r[20]; /* r12 - r31 */                                                 
+	u32 sprg[4];
+	u32 msr, sdr1, tb1, tb2;
+} __attribute__((packed));
+
+inline static void __save_processor_state(struct saved_context *s)
+{
+	/*asm volatile ("mflr 0; stw 0,%0" : "=m" (s->lr));*/
+	asm volatile ("mfcr 0; stw 0,%0" : "=m" (s->cr));
+	asm volatile ("stw 1,%0" : "=m" (s->sp));
+	asm volatile ("stw 2,%0" : "=m" (s->r2));
+	asm volatile ("stmw 12,%0" : "=m" (s->r));
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
+inline static void __restore_processor_state(struct saved_context *s)
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
+	asm volatile ("lmw 12,%0" : "=m" (s->r)); 
+	asm volatile ("lwz 2,%0" : "=m" (s->r2));
+	asm volatile ("lwz 1,%0" : "=m" (s->sp));
+	asm volatile ("lwz 0,%0; mtcr 0" : "=m" (s->cr)); 	
+	/*asm volatile ("lwz 0,%0; mtlr 0" : "=m" (s->lr));*/
+}
+
+static inline void save_context(void)
+{
+	printk("pmu suspend\n");
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
diff -ruNp 510-version-specific-mac.patch-old/include/asm-ppc/suspend2.h 510-version-specific-mac.patch-new/include/asm-ppc/suspend2.h
--- 510-version-specific-mac.patch-old/include/asm-ppc/suspend2.h	1970-01-01 10:00:00.000000000 +1000
+++ 510-version-specific-mac.patch-new/include/asm-ppc/suspend2.h	2005-07-04 23:14:19.000000000 +1000
@@ -0,0 +1,74 @@
+/*
+ * Written by Hu Gang (hugang@soulinfo.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include "asm/cpu_context.h"
+
+static struct saved_context suspend_saved_context;
+
+static inline void suspend2_save_processor_context(void)
+{
+	__save_processor_state(&suspend_saved_context);
+}
+
+static inline void suspend2_restore_processor_context(void)
+{
+	__restore_processor_state(&suspend_saved_context);
+
+	restore_context();
+}
+
+static inline void suspend2_pre_copy(void)
+{
+}
+
+static inline void suspend2_post_copy(void)
+{
+}
+
+static inline void suspend2_pre_copyback(void)
+{
+	save_context();
+}
+
+static inline void suspend2_post_copyback(void)
+{
+}
+
+static inline void suspend2_flush_caches(void)
+{
+}
+
+static unsigned long new_stack_page;
+
+static inline void move_stack_to_nonconflicing_area(void)
+{
+	unsigned long old_stack, src;
+
+	new_stack_page = 
+		suspend2_get_nonconflicting_pages(get_order(THREAD_SIZE));
+
+	BUG_ON(!new_stack_page);
+	
+	local_irq_disable();
+
+	/* geting stack address */
+	asm volatile ("stw %%r1, %0" : "=m" (old_stack));
+
+	src = old_stack & (~(THREAD_SIZE - 1));
+	
+	/* Copy stack */
+	memcpy((void*)new_stack_page, (void*)src, THREAD_SIZE);
+
+	new_stack_page += (old_stack - src);
+
+	/* switch to new stack */
+	asm volatile ("lwz %%r1, %0" : "=m" (new_stack_page));
+	
+	local_irq_enable();
+}
diff -ruNp 510-version-specific-mac.patch-old/kernel/kthread.c 510-version-specific-mac.patch-new/kernel/kthread.c
--- 510-version-specific-mac.patch-old/kernel/kthread.c	2005-07-06 11:25:15.000000000 +1000
+++ 510-version-specific-mac.patch-new/kernel/kthread.c	2005-07-04 23:14:19.000000000 +1000
@@ -94,10 +94,6 @@ static int kthread(void *_create)
 	current->flags |= flags_used;
 	atomic_set(&(current->freeze_status), 0);
 
-	/* Set our freezer flags */
-	current->flags &= ~(PF_SYNCTHREAD | PF_NOFREEZE);
-	current->flags |= create->freezer_flags;
-
 	/* OK, tell user we're spawned, wait for stop or wakeup */
 	__set_current_state(TASK_INTERRUPTIBLE);
 	complete(&create->started);

