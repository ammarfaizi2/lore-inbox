Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266011AbSKBSft>; Sat, 2 Nov 2002 13:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266016AbSKBSft>; Sat, 2 Nov 2002 13:35:49 -0500
Received: from [195.39.17.254] ([195.39.17.254]:26884 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266011AbSKBSfq>;
	Sat, 2 Nov 2002 13:35:46 -0500
Date: Sat, 2 Nov 2002 19:41:02 +0100
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp: Use akpm's mem freeing code, small cleanups
Message-ID: <20021102184102.GA162@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This uses new memory-freeing code from Andrew Morton (thanx!), cleans
sources a bit and makes suspend possible with md enabled, drivers are
no longer resumed from atomic context.

Please apply,
								Pavel

--- clean/arch/i386/kernel/suspend.c	2002-11-01 00:37:05.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/suspend.c	2002-10-13 20:19:43.000000000 +0200
@@ -175,7 +175,6 @@
 	 * the flags
 	 */
 	asm volatile ("pushl %0 ; popfl" :: "m" (saved_context.eflags));
-
 	do_fpu_end();
 }
 
--- clean/drivers/md/md.c	2002-11-01 00:37:17.000000000 +0100
+++ linux-swsusp/drivers/md/md.c	2002-11-01 00:44:22.000000000 +0100
@@ -37,6 +37,7 @@
 #include <linux/raid/xor.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/buffer_head.h> /* for invalidate_bdev */
+#include <linux/suspend.h>
 
 #include <linux/init.h>
 
@@ -2463,6 +2464,8 @@
 
 		wait_event_interruptible(thread->wqueue,
 					 test_bit(THREAD_WAKEUP, &thread->flags));
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_IOTHREAD);
 
 		clear_bit(THREAD_WAKEUP, &thread->flags);
 
--- clean/kernel/suspend.c	2002-11-01 00:37:42.000000000 +0100
+++ linux-swsusp/kernel/suspend.c	2002-11-02 19:28:02.000000000 +0100
@@ -145,10 +145,10 @@
 /*
  * Debug
  */
 #undef	DEBUG_DEFAULT
 #undef	DEBUG_PROCESS
 #undef	DEBUG_SLOW
-#define TEST_SWSUSP 1		/* Set to 1 to reboot instead of halt machine after suspension */
+#define TEST_SWSUSP 0		/* Set to 1 to reboot instead of halt machine after suspension */
 
 #ifdef DEBUG_DEFAULT
 # define PRINTK(f, a...)       printk(f, ## a)
@@ -235,6 +235,7 @@
 	} while(todo);
 	
 	printk( "|\n" );
+	BUG_ON(in_atomic());
 	return 0;
 }
 
@@ -489,7 +490,6 @@
 			if (PageNosave(page))
 				continue;
 
-
 			if ((chunk_size=is_head_of_free_region(page))!=0) {
 				pfn += chunk_size - 1;
 				continue;
@@ -549,7 +549,7 @@
 
 	pagedir_order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
 
-	p = pagedir = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC, pagedir_order);
+	p = pagedir = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD, pagedir_order);
 	if(!pagedir)
 		return NULL;
 
@@ -558,11 +558,12 @@
 		SetPageNosave(page++);
 		
 	while(nr_copy_pages--) {
-		p->address = get_zeroed_page(GFP_ATOMIC);
+		p->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
 		if(!p->address) {
 			free_suspend_pagedir((unsigned long) pagedir);
 			return NULL;
 		}
+		printk(".");
 		SetPageNosave(virt_to_page(p->address));
 		p->orig_address = 0;
 		p++;
@@ -623,7 +624,7 @@
 static void free_some_memory(void)
 {
 	printk("Freeing memory: ");
-	while (try_to_free_pages(&contig_page_data.node_zones[ZONE_HIGHMEM], GFP_KSWAPD, 0))
+	while (shrink_all_memory(10000))
 		printk(".");
 	printk("|\n");
 }
@@ -676,7 +677,7 @@
 	}
 }
 
-static int suspend_save_image(void)
+static int suspend_prepare_image(void)
 {
 	struct sysinfo i;
 	unsigned int nr_needed_pages = 0;
@@ -725,9 +726,15 @@
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
+void suspend_save_image(void)
+{
+	drivers_unsuspend();
 
 	lock_swapdevices();
 	write_suspend_image();
@@ -738,7 +745,6 @@
 	 * filesystem clean: it is not. (And it does not matter, if we resume
 	 * correctly, we'll mark system clean, anyway.)
 	 */
-	return 0;
 }
 
 void suspend_power_down(void)
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

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
