Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263875AbUGQW6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbUGQW6l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 18:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUGQW55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 18:57:57 -0400
Received: from digitalimplant.org ([64.62.235.95]:31977 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S262418AbUGQWfP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 18:35:15 -0400
Date: Sat, 17 Jul 2004 15:35:10 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: pavel@ucw.cz
Subject: [9/25] Merge pmdisk and swsusp
Message-ID: <Pine.LNX.4.50.0407171529130.22290-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet 1.1851, 2004/07/17 11:11:04-07:00, mochel@digitalimplant.org

[Power Mgmt] Consolidate pmdisk and swsusp low-level handling.

- Split do_magic into swsusp_arch_suspend() and swsusp_arch_resume().
- Clean up based on pmdisk implementation
  - Only save registers we need to.
  - Use rep;movsl for copying, rather than doing each byte.
- Create swsusp_suspend and swsusp_resume wrappers for calling the assmebly
  routines that:
  - Call {save,restore}_processor_state() in each.
  - Disable/enable interrupts in each.
- Call swsusp_{suspend,restore} in software_{suspend,resume}
- Kill all the do_magic_* functions.
- Remove prototypes from linux/suspend.h
- Remove similar pmdisk functions.
- Update calls in kernel/power/disk.c to use swsusp versions.


 arch/i386/power/Makefile |    1
 arch/i386/power/swsusp.S |   78 ++++++++----------------------
 include/linux/suspend.h  |    6 --
 kernel/power/disk.c      |    8 +--
 kernel/power/pmdisk.c    |   89 ----------------------------------
 kernel/power/swsusp.c    |  121 +++++++++++++++++++----------------------------
 6 files changed, 74 insertions(+), 229 deletions(-)


diff -Nru a/arch/i386/power/Makefile b/arch/i386/power/Makefile
--- a/arch/i386/power/Makefile	2004-07-17 14:51:25 -07:00
+++ b/arch/i386/power/Makefile	2004-07-17 14:51:25 -07:00
@@ -1,3 +1,2 @@
 obj-$(CONFIG_PM)		+= cpu.o
-obj-$(CONFIG_PM_DISK)		+= pmdisk.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o
diff -Nru a/arch/i386/power/swsusp.S b/arch/i386/power/swsusp.S
--- a/arch/i386/power/swsusp.S	2004-07-17 14:51:25 -07:00
+++ b/arch/i386/power/swsusp.S	2004-07-17 14:51:25 -07:00
@@ -15,83 +15,47 @@

 	.text

-ENTRY(do_magic)
-	pushl %ebx
-	cmpl $0,8(%esp)
-	jne resume
-	call do_magic_suspend_1
-	call save_processor_state
+ENTRY(swsusp_arch_suspend)

 	movl %esp, saved_context_esp
-	movl %eax, saved_context_eax
 	movl %ebx, saved_context_ebx
-	movl %ecx, saved_context_ecx
-	movl %edx, saved_context_edx
 	movl %ebp, saved_context_ebp
 	movl %esi, saved_context_esi
 	movl %edi, saved_context_edi
 	pushfl ; popl saved_context_eflags

-	call do_magic_suspend_2
-	popl %ebx
+	call swsusp_save
 	ret

-resume:
+ENTRY(swsusp_arch_resume)
 	movl $swsusp_pg_dir-__PAGE_OFFSET,%ecx
 	movl %ecx,%cr3

-	call do_magic_resume_1
-	movl $0,loop
-	cmpl $0,nr_copy_pages
-	je copy_done
-copy_loop:
-	movl $0,loop2
+	movl	pagedir_nosave,%ebx
+	xorl	%eax, %eax
+	xorl	%edx, %edx
 	.p2align 4,,7
-copy_one_page:
-	movl pagedir_nosave,%ecx
-	movl loop,%eax
-	movl loop2,%edx
-	sall $4,%eax
-	movl 4(%ecx,%eax),%ebx
-	movl (%ecx,%eax),%eax
-	movb (%edx,%eax),%al
-	movb %al,(%edx,%ebx)
-
-	movl loop2,%eax
-	leal 1(%eax),%edx
-	movl %edx,loop2
-	movl %edx,%eax
-	cmpl $4095,%eax
-	jbe copy_one_page
-	movl loop,%eax
-	leal 1(%eax),%edx
-	movl %edx,loop
-	movl %edx,%eax
-	cmpl nr_copy_pages,%eax
-	jb copy_loop

-copy_done:
-	movl $__USER_DS,%eax
+copy_loop:
+	movl	4(%ebx,%edx),%edi
+	movl	(%ebx,%edx),%esi
+
+	movl	$1024, %ecx
+	rep
+	movsl
+
+	incl	%eax
+	addl	$16, %edx
+	cmpl	nr_copy_pages,%eax
+	jb copy_loop
+	.p2align 4,,7

-	movw %ax, %ds
-	movw %ax, %es
 	movl saved_context_esp, %esp
 	movl saved_context_ebp, %ebp
-	movl saved_context_eax, %eax
 	movl saved_context_ebx, %ebx
-	movl saved_context_ecx, %ecx
-	movl saved_context_edx, %edx
 	movl saved_context_esi, %esi
 	movl saved_context_edi, %edi
-	call restore_processor_state
+
 	pushl saved_context_eflags ; popfl
-	call do_magic_resume_2
-	popl %ebx
+	call swsusp_restore
 	ret
-
-       .section .data.nosave
-loop:
-       .quad 0
-loop2:
-       .quad 0
-       .previous
diff -Nru a/include/linux/suspend.h b/include/linux/suspend.h
--- a/include/linux/suspend.h	2004-07-17 14:51:25 -07:00
+++ b/include/linux/suspend.h	2004-07-17 14:51:25 -07:00
@@ -75,12 +75,6 @@
 static inline void enable_nonboot_cpus(void) {}
 #endif

-asmlinkage void do_magic(int is_resume);
-asmlinkage void do_magic_resume_1(void);
-asmlinkage void do_magic_resume_2(void);
-asmlinkage void do_magic_suspend_1(void);
-asmlinkage void do_magic_suspend_2(void);
-
 void save_processor_state(void);
 void restore_processor_state(void);
 struct saved_context;
diff -Nru a/kernel/power/disk.c b/kernel/power/disk.c
--- a/kernel/power/disk.c	2004-07-17 14:51:25 -07:00
+++ b/kernel/power/disk.c	2004-07-17 14:51:25 -07:00
@@ -23,10 +23,10 @@
 extern u32 pm_disk_mode;
 extern struct pm_ops * pm_ops;

-extern int pmdisk_save(void);
+extern int swsusp_suspend(void);
 extern int pmdisk_write(void);
 extern int pmdisk_read(void);
-extern int pmdisk_restore(void);
+extern int swsusp_resume(void);
 extern int pmdisk_free(void);


@@ -161,7 +161,7 @@

 	pr_debug("PM: snapshotting memory.\n");
 	in_suspend = 1;
-	if ((error = pmdisk_save()))
+	if ((error = swsusp_save()))
 		goto Done;

 	if (in_suspend) {
@@ -227,7 +227,7 @@
 	mdelay(1000);

 	pr_debug("PM: Restoring saved image.\n");
-	pmdisk_restore();
+	swsusp_resume();
 	pr_debug("PM: Restore failed, recovering.n");
 	finish();
  Free:
diff -Nru a/kernel/power/pmdisk.c b/kernel/power/pmdisk.c
--- a/kernel/power/pmdisk.c	2004-07-17 14:51:25 -07:00
+++ b/kernel/power/pmdisk.c	2004-07-17 14:51:25 -07:00
@@ -249,28 +249,7 @@


 extern void free_suspend_pagedir(unsigned long);
-extern int suspend_prepare_image(void);

-/**
- *	pmdisk_suspend - Atomically snapshot the system.
- *
- *	This must be called with interrupts disabled, to prevent the
- *	system changing at all from underneath us.
- *
- *	To do this, we count the number of pages in the system that we
- *	need to save; make sure	we have enough memory and swap to clone
- *	the pages and save them in swap, allocate the space to hold them,
- *	and then snapshot them all.
- */
-
-int pmdisk_suspend(void)
-{
-	int error = 0;
-
-	if ((error = swsusp_swap_check()))
-		return error;
-	return suspend_prepare_image();
-}


 /**
@@ -297,36 +276,6 @@
 	return error;
 }

-/*
- * Magic happens here
- */
-
-int pmdisk_resume(void)
-{
-	BUG_ON (nr_copy_pages_check != nr_copy_pages);
-	BUG_ON (pagedir_order_check != pagedir_order);
-
-	/* Even mappings of "global" things (vmalloc) need to be fixed */
-	__flush_tlb_global();
-	return 0;
-}
-
-/* pmdisk_arch_suspend() is implemented in arch/?/power/pmdisk.S,
-   and basically does:
-
-	if (!resume) {
-		save_processor_state();
-		SAVE_REGISTERS
-		return pmdisk_suspend();
-	}
-	GO_TO_SWAPPER_PAGE_TABLES
-	COPY_PAGES_BACK
-	RESTORE_REGISTERS
-	restore_processor_state();
-	return pmdisk_resume();
-
- */
-

 /* More restore stuff */

@@ -563,28 +512,6 @@
 	goto Done;
 }

-/**
- *	pmdisk_save - Snapshot memory
- */
-
-int pmdisk_save(void)
-{
-	int error;
-
-#if defined (CONFIG_HIGHMEM) || defined (CONFIG_DISCONTIGMEM)
-	pr_debug("pmdisk: not supported with high- or discontig-mem.\n");
-	return -EPERM;
-#endif
-	if ((error = arch_prepare_suspend()))
-		return error;
-	local_irq_disable();
-	save_processor_state();
-	error = pmdisk_arch_suspend(0);
-	restore_processor_state();
-	local_irq_enable();
-	return error;
-}
-

 /**
  *	pmdisk_write - Write saved memory image to swap.
@@ -628,22 +555,6 @@
 		pr_debug("Reading resume file was successful\n");
 	else
 		pr_debug("pmdisk: Error %d resuming\n", error);
-	return error;
-}
-
-
-/**
- *	pmdisk_restore - Replace running kernel with saved image.
- */
-
-int __init pmdisk_restore(void)
-{
-	int error;
-	local_irq_disable();
-	save_processor_state();
-	error = pmdisk_arch_suspend(1);
-	restore_processor_state();
-	local_irq_enable();
 	return error;
 }

diff -Nru a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c	2004-07-17 14:51:25 -07:00
+++ b/kernel/power/swsusp.c	2004-07-17 14:51:25 -07:00
@@ -893,80 +893,58 @@
 #endif
 }

-/*
- * Magic happens here
- */

-asmlinkage void do_magic_resume_1(void)
+extern asmlinkage int swsusp_arch_suspend(void);
+extern asmlinkage int swsusp_arch_resume(void);
+
+
+asmlinkage int swsusp_save(void)
 {
-	barrier();
-	mb();
-	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */
+	int error = 0;

-	device_power_down(3);
-	PRINTK( "Waiting for DMAs to settle down...\n");
-	mdelay(1000);	/* We do not want some readahead with DMA to corrupt our memory, right?
-			   Do it with disabled interrupts for best effect. That way, if some
-			   driver scheduled DMA, we have good chance for DMA to finish ;-). */
+	if ((error = swsusp_swap_check()))
+		return error;
+	return suspend_prepare_image();
 }

-asmlinkage void do_magic_resume_2(void)
+int swsusp_suspend(void)
+{
+	int error;
+	if ((error = arch_prepare_suspend()))
+		return error;
+	local_irq_disable();
+	save_processor_state();
+	error = swsusp_arch_suspend();
+	restore_processor_state();
+	local_irq_enable();
+	return error;
+}
+
+
+asmlinkage int swsusp_restore(void)
 {
 	BUG_ON (nr_copy_pages_check != nr_copy_pages);
 	BUG_ON (pagedir_order_check != pagedir_order);
+
+	/* Even mappings of "global" things (vmalloc) need to be fixed */
+	__flush_tlb_global();
+	return 0;
+}

-	__flush_tlb_global();		/* Even mappings of "global" things (vmalloc) need to be fixed */
-	device_power_up();
-	spin_unlock_irq(&suspend_pagedir_lock);
-}
-
-/* do_magic() is implemented in arch/?/kernel/suspend_asm.S, and basically does:
-
-	if (!resume) {
-		do_magic_suspend_1();
-		save_processor_state();
-		SAVE_REGISTERS
-		do_magic_suspend_2();
-		return;
-	}
-	GO_TO_SWAPPER_PAGE_TABLES
-	do_magic_resume_1();
-	COPY_PAGES_BACK
-	RESTORE_REGISTERS
+int swsusp_resume(void)
+{
+	int error;
+	local_irq_disable();
+	save_processor_state();
+	error = swsusp_arch_resume();
 	restore_processor_state();
-	do_magic_resume_2();
-
- */
+	local_irq_enable();
+	return error;
+}

-asmlinkage void do_magic_suspend_1(void)
-{
-	mb();
-	barrier();
-	BUG_ON(in_atomic());
-	spin_lock_irq(&suspend_pagedir_lock);
-}
-
-asmlinkage void do_magic_suspend_2(void)
-{
-	int is_problem;
-	swsusp_swap_check();
-	device_power_down(3);
-	is_problem = suspend_prepare_image();
-	device_power_up();
-	spin_unlock_irq(&suspend_pagedir_lock);
-	if (!is_problem) {
-		kernel_fpu_end();	/* save_processor_state() does kernel_fpu_begin, and we need to revert it in order to pass in_atomic() checks */
-		BUG_ON(in_atomic());
-		suspend_save_image();
-		suspend_power_down();	/* FIXME: if suspend_power_down is commented out, console is lost after few suspends ?! */
-	}

-	printk(KERN_EMERG "%sSuspend failed, trying to recover...\n", name_suspend);
-	MDELAY(1000); /* So user can wait and report us messages if armageddon comes :-) */

-	barrier();
-	mb();
-}
+static int in_suspend __nosavedata = 0;

 /*
  * This is main interface to the outside world. It needs to be
@@ -998,16 +976,15 @@
 		/* Save state of all device drivers, and stop them. */
 		printk("Suspending devices... ");
 		if ((res = device_suspend(3))==0) {
-			/* If stopping device drivers worked, we proceed basically into
-			 * suspend_save_image.
-			 *
-			 * do_magic(0) returns after system is resumed.
-			 *
-			 * do_magic() copies all "used" memory to "free" memory, then
-			 * unsuspends all device drivers, and writes memory to disk
-			 * using normal kernel mechanism.
-			 */
-			do_magic(0);
+			in_suspend = 1;
+
+			res = swsusp_save();
+
+			if (!res && in_suspend) {
+				suspend_save_image();
+				suspend_power_down();
+			}
+			in_suspend = 0;
 			suspend_finish();
 		}
 		thaw_processes();
@@ -1352,7 +1329,7 @@
 	/* FIXME: Should we stop processes here, just to be safer? */
 	disable_nonboot_cpus();
 	device_suspend(3);
-	do_magic(1);
+	swsusp_resume();
 	panic("This never returns");

 read_failure:
