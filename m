Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317020AbSEWVwf>; Thu, 23 May 2002 17:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317022AbSEWVwe>; Thu, 23 May 2002 17:52:34 -0400
Received: from [195.39.17.254] ([195.39.17.254]:30875 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317020AbSEWVwd>;
	Thu, 23 May 2002 17:52:33 -0400
Date: Thu, 23 May 2002 23:51:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: swsusp fixes
Message-ID: <20020523215118.GA705@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This kills unneccessary include from ide-disk.c, kills #ifdef from
reiserfs/journal.c, makes suspend_device local as it should be,
abstains from suspending devices two times in a row (typo), and makes
sure we do not run_task_queue() while we hold spinlock. Please apply,

								Pavel

--- linux-swsusp.linus/drivers/ide/ide-disk.c	Wed May 22 21:12:16 2002
+++ linux-swsusp/drivers/ide/ide-disk.c	Wed May 22 21:18:29 2002
@@ -27,7 +27,6 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/ide.h>
-#include <linux/suspend.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
--- linux-swsusp.linus/fs/reiserfs/journal.c	Wed May 22 21:12:17 2002
+++ linux-swsusp/fs/reiserfs/journal.c	Wed May 22 02:35:21 2002
@@ -1901,12 +1901,9 @@
       break ;
     }
     wake_up(&reiserfs_commit_thread_done) ;
-#ifdef CONFIG_SOFTWARE_SUSPEND
-    if (current->flags & PF_FREEZE) {
-	    refrigerator(PF_IOTHREAD);
-    } else
-#endif
-	    interruptible_sleep_on_timeout(&reiserfs_commit_thread_wait, 5 * HZ) ;
+    if (current->flags & PF_FREEZE)
+      refrigerator(PF_IOTHREAD);
+    interruptible_sleep_on_timeout(&reiserfs_commit_thread_wait, 5 * HZ) ;
   }
   unlock_kernel() ;
   wake_up(&reiserfs_commit_thread_done) ;
--- linux-swsusp.linus/kernel/suspend.c	Wed May 22 21:12:17 2002
+++ linux-swsusp/kernel/suspend.c	Wed May 22 22:05:48 2002
@@ -409,15 +404,12 @@
 	swap_list_lock();
 	for(i = 0; i< MAX_SWAPFILES; i++)
 		if(swapfile_used[i] == SWAPFILE_IGNORED) {
-//			PRINTS( "device %s locked\n", swap_info[i].swap_file->d_name.name );
 			swap_info[i].flags ^= 0xFF; /* we make the device unusable. A new call to
 						       lock_swapdevices can unlock the devices. */
 		}
 	swap_list_unlock();
 }
 
-kdev_t suspend_device;
-
 static int write_suspend_image(void)
 {
 	int i;
@@ -425,6 +417,7 @@
 	int nr_pgdir_pages = SUSPEND_PD_PAGES(nr_copy_pages);
 	union diskpage *cur,  *buffer = (union diskpage *)get_free_page(GFP_ATOMIC);
 	unsigned long address;
+	kdev_t suspend_device;
 
 	PRINTS( "Writing data to swap (%d pages): ", nr_copy_pages );
 	for (i=0; i<nr_copy_pages; i++) {
@@ -809,7 +747,6 @@
 	 *
 	 * Following line enforces not writing to disk until we choose.
 	 */
-	suspend_device = NODEV;					/* We do not want any writes, thanx */
 	drivers_unsuspend();
 	spin_unlock_irq(&suspend_pagedir_lock);
 	PRINTS( "critical section/: done (%d pages copied)\n", nr_copy_pages );
@@ -899,13 +836,9 @@
 static void do_magic_suspend_2(void)
 {
 	read_swapfiles();
-	if (!suspend_save_image()) {
-#if 1
-		suspend_power_down ();	/* FIXME: if suspend_power_down is commented out, console is lost after few suspends ?! */
-#endif
-	}
+	if (!suspend_save_image())
+		suspend_power_down();	/* FIXME: if suspend_power_down is commented out, console is lost after few suspends ?! */
 
-	suspend_device = NODEV;
 	printk(KERN_WARNING "%sSuspend failed, trying to recover...\n", name_suspend);
 	MDELAY(1000); /* So user can wait and report us messages if armageddon comes :-) */
 
@@ -944,9 +877,8 @@
 			 * We sync here -- so you have consistent filesystem state when things go wrong.
 			 * -- so that noone writes to disk after we do atomic copy of data.
 			 */
-			PRINTS( "Syncing disks before copy\n" );
+			PRINTS("Syncing disks before copy\n");
 			do_suspend_sync();
-			drivers_suspend();
 			if(drivers_suspend()==0)
 				do_magic(0);			/* This function returns after machine woken up from resume */
 			PRINTR("Restarting processes...\n");
--- linux-swsusp.linus/mm/pdflush.c	Wed May 22 21:12:17 2002
+++ linux-swsusp/mm/pdflush.c	Wed May 22 02:01:58 2002
@@ -108,16 +108,16 @@
 	for ( ; ; ) {
 		struct pdflush_work *pdf;
 
-#ifdef CONFIG_SOFTWARE_SUSPEND
-		run_task_queue(&tq_bdflush);
-#endif
 		list_add(&my_work->list, &pdflush_list);
 		my_work->when_i_went_to_sleep = jiffies;
 		set_current_state(TASK_INTERRUPTIBLE);
 		spin_unlock_irq(&pdflush_lock);
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
+		run_task_queue(&tq_bdflush);
 		if (current->flags & PF_FREEZE)
 			refrigerator(PF_IOTHREAD);
+#endif
 		schedule();
 
 		preempt_enable();

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
