Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267190AbSKSTVt>; Tue, 19 Nov 2002 14:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267179AbSKSTVt>; Tue, 19 Nov 2002 14:21:49 -0500
Received: from [195.39.17.254] ([195.39.17.254]:7428 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267176AbSKSTVo>;
	Tue, 19 Nov 2002 14:21:44 -0500
Date: Tue, 19 Nov 2002 18:20:50 +0100
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp, S3: cleanups, support 64-bit machines, md support
Message-ID: <20021119172050.GA222@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This adds support for 64-bit machines (I've actually done swsusp on
hammer, wow!, but that still has to be cleaned up a lot), cleans
things up a bit, and adds preliminary support to md.c. Oh and it will
no longer call device drivers resume method with interrupts off, and
will use akpm's memory freeing. Please apply,

								Pavel

--- clean/arch/i386/kernel/acpi_wakeup.S	2002-11-19 16:45:58.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/acpi_wakeup.S	2002-11-19 16:17:58.000000000 +0100
@@ -1,11 +1,16 @@
-
 .text
 #include <linux/linkage.h>
 #include <asm/segment.h>
+#include <asm/page.h>
 
-# Do we need to deal with A20?
+#
+# wakeup_code runs in real mode, and at unknown address (determined at run-time).
+# Therefore it must only use relative jumps/calls. 
+#
+# Do we need to deal with A20? It seems okay
 
 ALIGN
+	.align	4096
 wakeup_start:
 wakeup_code:
 	wakeup_code_start = .
@@ -228,7 +262,7 @@
 
 	movl	%eax, %edi
 	leal	wakeup_start, %esi
-	movl	$(wakeup_end - wakeup_start) >> 2, %ecx
+	movl	$(wakeup_end - wakeup_start + 3) >> 2, %ecx
 
 	rep ;  movsl
 
@@ -290,8 +324,8 @@
 	ret
 	.p2align 4,,7
 .L1432:
-	movl $104,%eax
-	movw %eax, %ds
+	movl $__KERNEL_DS,%eax
+	movw %ax, %ds
 	movl saved_context_esp, %esp
 	movl saved_context_ebp, %ebp
 	movl saved_context_eax, %eax
@@ -310,5 +344,4 @@
 saved_idt:	.long	0,0
 saved_ldt:	.long	0
 saved_tss:	.long	0
-saved_cr0:	.long	0
 
--- clean/drivers/md/md.c	2002-11-19 16:46:05.000000000 +0100
+++ linux-swsusp/drivers/md/md.c	2002-11-19 15:38:15.000000000 +0100
@@ -36,6 +36,7 @@
 #include <linux/bio.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/buffer_head.h> /* for invalidate_bdev */
+#include <linux/suspend.h>
 
 #include <linux/init.h>
 
@@ -2470,6 +2471,8 @@
 
 		wait_event_interruptible(thread->wqueue,
 					 test_bit(THREAD_WAKEUP, &thread->flags));
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_IOTHREAD);
 
 		clear_bit(THREAD_WAKEUP, &thread->flags);
 
@@ -2909,6 +2918,9 @@
 		 */
 		cond_resched();
 
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_IOTHREAD);
+
 		currspeed = (j-mddev->resync_mark_cnt)/2/((jiffies-mddev->resync_mark)/HZ +1) +1;
 
 		if (currspeed > sysctl_speed_limit_min) {
--- clean/kernel/suspend.c	2002-11-19 16:46:15.000000000 +0100
+++ linux-swsusp/kernel/suspend.c	2002-11-19 15:38:28.000000000 +0100
@@ -80,9 +80,9 @@
 #endif
 
 #define TIMEOUT	(6 * HZ)			/* Timeout for stopping processes */
-#define ADDRESS(x) ((unsigned long) phys_to_virt(((x) << PAGE_SHIFT)))
-
-extern int C_A_D;
+#define __ADDRESS(x)  ((unsigned long) phys_to_virt(x))
+#define ADDRESS(x) __ADDRESS((x) << PAGE_SHIFT)
+#define ADDRESS2(x) __ADDRESS(__pa(x))		/* Needed for x86-64 where some pages are in memory twice */
 
 /* References to section boundaries */
 extern char _text, _etext, _edata, __bss_start, _end;
@@ -145,10 +145,10 @@
 /*
  * Debug
  */
-#undef	DEBUG_DEFAULT
+#define	DEBUG_DEFAULT
 #undef	DEBUG_PROCESS
 #undef	DEBUG_SLOW
-#define TEST_SWSUSP 1		/* Set to 1 to reboot instead of halt machine after suspension */
+#define TEST_SWSUSP 0		/* Set to 1 to reboot instead of halt machine after suspension */
 
 #ifdef DEBUG_DEFAULT
 # define PRINTK(f, a...)       printk(f, ## a)
@@ -322,20 +323,20 @@
 	rw_swap_page_sync(READ, entry, page);
 
 	if (mode == MARK_SWAP_RESUME) {
-	  	if (!memcmp("SUSP1R",cur->swh.magic.magic,6))
+	  	if (!memcmp("S1",cur->swh.magic.magic,2))
 		  	memcpy(cur->swh.magic.magic,"SWAP-SPACE",10);
-		else if (!memcmp("SUSP2R",cur->swh.magic.magic,6))
+		else if (!memcmp("S2",cur->swh.magic.magic,2))
 			memcpy(cur->swh.magic.magic,"SWAPSPACE2",10);
 		else printk("%sUnable to find suspended-data signature (%.10s - misspelled?\n", 
 		      	name_resume, cur->swh.magic.magic);
 	} else {
 	  	if ((!memcmp("SWAP-SPACE",cur->swh.magic.magic,10)))
-		  	memcpy(cur->swh.magic.magic,"SUSP1R....",10);
+		  	memcpy(cur->swh.magic.magic,"S1SUSP....",10);
 		else if ((!memcmp("SWAPSPACE2",cur->swh.magic.magic,10)))
-			memcpy(cur->swh.magic.magic,"SUSP2R....",10);
+			memcpy(cur->swh.magic.magic,"S2SUSP....",10);
 		else panic("\nSwapspace is not swapspace (%.10s)\n", cur->swh.magic.magic);
 		cur->link.next = prev; /* prev is the first/last swap page of the resume area */
-		/* link.next lies *no more* in last 4 bytes of magic */
+		/* link.next lies *no more* in last 4/8 bytes of magic */
 	}
 	rw_swap_page_sync(WRITE, entry, page);
 	__free_page(page);
@@ -489,7 +490,6 @@
 			if (PageNosave(page))
 				continue;
 
-
 			if ((chunk_size=is_head_of_free_region(page))!=0) {
 				pfn += chunk_size - 1;
 				continue;
@@ -500,10 +500,9 @@
 			/*
 			 * Just copy whole code segment. Hopefully it is not that big.
 			 */
-			if (ADDRESS(pfn) >= (unsigned long)
-				&__nosave_begin && ADDRESS(pfn) < 
-				(unsigned long)&__nosave_end) {
-				PRINTK("[nosave %x]", ADDRESS(pfn));
+			if ((ADDRESS(pfn) >= (unsigned long) ADDRESS2(&__nosave_begin)) && 
+			    (ADDRESS(pfn) <  (unsigned long) ADDRESS2(&__nosave_end))) {
+				PRINTK("[nosave %lx]", ADDRESS(pfn));
 				continue;
 			}
 			/* Hmm, perhaps copying all reserved pages is not too healthy as they may contain 
@@ -513,7 +512,7 @@
 		nr_copy_pages++;
 		if (pagedir_p) {
 			pagedir_p->orig_address = ADDRESS(pfn);
-			copy_page(pagedir_p->address, pagedir_p->orig_address);
+			copy_page((void *) pagedir_p->address, (void *) pagedir_p->orig_address);
 			pagedir_p++;
 		}
 	}
@@ -623,7 +623,7 @@
 static void free_some_memory(void)
 {
 	printk("Freeing memory: ");
-	while (try_to_free_pages(&contig_page_data.node_zones[ZONE_HIGHMEM], GFP_KSWAPD, 0))
+	while (shrink_all_memory(10000))
 		printk(".");
 	printk("|\n");
 }
@@ -676,7 +676,7 @@
 	}
 }
 
-static int suspend_save_image(void)
+static int suspend_prepare_image(void)
 {
 	struct sysinfo i;
 	unsigned int nr_needed_pages = 0;
@@ -725,9 +725,15 @@
 	 *
 	 * Following line enforces not writing to disk until we choose.
 	 */
-	drivers_unsuspend();
-	spin_unlock_irq(&suspend_pagedir_lock);
+
 	printk( "critical section/: done (%d pages copied)\n", nr_copy_pages );
+	spin_unlock_irq(&suspend_pagedir_lock);
+	return 0;
+}
+
+static void suspend_save_image(void)
+{
+	drivers_unsuspend();
 
 	lock_swapdevices();
 	write_suspend_image();
@@ -738,11 +744,11 @@
 	 * filesystem clean: it is not. (And it does not matter, if we resume
 	 * correctly, we'll mark system clean, anyway.)
 	 */
-	return 0;
 }
 
-void suspend_power_down(void)
+static void suspend_power_down(void)
 {
+	extern int C_A_D;
 	C_A_D = 0;
 	printk(KERN_EMERG "%s%s Trying to power down.\n", name_suspend, TEST_SWSUSP ? "Disable TEST_SWSUSP. NOT ": "");
 #ifdef CONFIG_VT
@@ -788,8 +794,8 @@
 
 	PRINTK( "Freeing prev allocated pagedir\n" );
 	free_suspend_pagedir((unsigned long) pagedir_save);
-	drivers_resume(RESUME_ALL_PHASES);
 	spin_unlock_irq(&suspend_pagedir_lock);
+	drivers_resume(RESUME_ALL_PHASES);
 
 	PRINTK( "Fixing swap signatures... " );
 	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
@@ -804,14 +810,17 @@
 {
 	mb();
 	barrier();
+	BUG_ON(in_atomic());
 	spin_lock_irq(&suspend_pagedir_lock);
 }
 
 void do_magic_suspend_2(void)
 {
 	read_swapfiles();
-	if (!suspend_save_image())
+	if (!suspend_prepare_image()) {	/* suspend_save_image realeses suspend_pagedir_lock */
+		suspend_save_image();
 		suspend_power_down();	/* FIXME: if suspend_power_down is commented out, console is lost after few suspends ?! */
+	}
 
 	printk(KERN_EMERG "%sSuspend failed, trying to recover...\n", name_suspend);
 	MDELAY(1000); /* So user can wait and report us messages if armageddon comes :-) */
@@ -827,7 +836,7 @@
 	PRINTK(KERN_WARNING "%sLeaving do_magic_suspend_2...\n", name_suspend);	
 }
 
-void do_software_suspend(void)
+static void do_software_suspend(void)
 {
 	arch_prepare_suspend();
 	if (prepare_suspend_console())
@@ -1069,9 +1078,9 @@
 
 	PREPARENEXT; /* We have to read next position before we overwrite it */
 
-	if (!memcmp("SUSP1R",cur->swh.magic.magic,6))
+	if (!memcmp("S1",cur->swh.magic.magic,2))
 		memcpy(cur->swh.magic.magic,"SWAP-SPACE",10);
-	else if (!memcmp("SUSP2R",cur->swh.magic.magic,6))
+	else if (!memcmp("S2",cur->swh.magic.magic,2))
 		memcpy(cur->swh.magic.magic,"SWAPSPACE2",10);
 	else {
 		panic("%sUnable to find suspended-data signature (%.10s - misspelled?\n", 

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
