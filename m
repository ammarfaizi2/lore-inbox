Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262708AbSKMUVp>; Wed, 13 Nov 2002 15:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262790AbSKMUVp>; Wed, 13 Nov 2002 15:21:45 -0500
Received: from [195.39.17.254] ([195.39.17.254]:1284 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262708AbSKMUVl>;
	Wed, 13 Nov 2002 15:21:41 -0500
Date: Tue, 12 Nov 2002 22:51:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp: cleanups
Message-ID: <20021112215106.GA132@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

These are cleanups, it makes swsusp really power down machine (out of
test mode for now), uses new "memory shrinking" interface by akpm, and
avoids calling drivers_resume() with interupts disabled. Please
apply,
								Pavel


--- clean/kernel/suspend.c	2002-11-01 00:37:42.000000000 +0100
+++ linux-swsusp/kernel/suspend.c	2002-11-08 11:37:06.000000000 +0100
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
@@ -500,9 +500,8 @@
 			/*
 			 * Just copy whole code segment. Hopefully it is not that big.
 			 */
-			if (ADDRESS(pfn) >= (unsigned long)
-				&__nosave_begin && ADDRESS(pfn) < 
-				(unsigned long)&__nosave_end) {
+			if ((ADDRESS(pfn) >= (unsigned long) &__nosave_begin) && 
+			    (ADDRESS(pfn) <  (unsigned long) &__nosave_end)) {
 				PRINTK("[nosave %x]", ADDRESS(pfn));
 				continue;
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
+void suspend_save_image(void)
+{
+	drivers_unsuspend();
 
 	lock_swapdevices();
 	write_suspend_image();
@@ -738,7 +744,6 @@
 	 * filesystem clean: it is not. (And it does not matter, if we resume
 	 * correctly, we'll mark system clean, anyway.)
 	 */
-	return 0;
 }
 
 void suspend_power_down(void)
@@ -788,8 +793,8 @@
 
 	PRINTK( "Freeing prev allocated pagedir\n" );
 	free_suspend_pagedir((unsigned long) pagedir_save);
-	drivers_resume(RESUME_ALL_PHASES);
 	spin_unlock_irq(&suspend_pagedir_lock);
+	drivers_resume(RESUME_ALL_PHASES);
 
 	PRINTK( "Fixing swap signatures... " );
 	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
@@ -804,14 +809,17 @@
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
