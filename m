Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318721AbSHAMGP>; Thu, 1 Aug 2002 08:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318725AbSHAMFj>; Thu, 1 Aug 2002 08:05:39 -0400
Received: from [195.39.17.254] ([195.39.17.254]:11392 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S318721AbSHAMEh>;
	Thu, 1 Aug 2002 08:04:37 -0400
Date: Thu, 1 Aug 2002 12:38:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp: comment updates and warning fixes
Message-ID: <20020801103838.GA115@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Better comments and less warnings, please apply
								Pavel

--- clean/kernel/suspend.c	Tue Jul 23 10:40:06 2002
+++ linux-swsusp/kernel/suspend.c	Mon Jul 29 20:30:53 2002
@@ -66,6 +66,7 @@
 #include <linux/swapops.h>
 
 extern void signal_wake_up(struct task_struct *t);
+extern int sys_sync(void);
 
 unsigned char software_suspend_enabled = 0;
 
@@ -815,17 +816,17 @@
 	PRINTK(KERN_WARNING "%sLeaving do_magic_suspend_2...\n", name_suspend);	
 }
 
-/*
- * We try to swap out as much as we can then make a copy of the
- * occupied pages in memory so we can make a copy of kernel state
- * atomically, the I/O needed by saving won't bother us anymore. 
- */
 void do_software_suspend(void)
 {
 	arch_prepare_suspend();
 	if (prepare_suspend_console())
 		printk( "%sCan't allocate a console... proceeding\n", name_suspend);
 	if (!prepare_suspend_processes()) {
+
+		/* At this point, all user processes and "dangerous"
+                   kernel threads are stopped. Free some memory, as we
+                   need half of memory free. */
+
 		free_some_memory();
 		
 		/* No need to invalidate any vfsmnt list -- they will be valid after resume, anyway.
@@ -835,8 +836,19 @@
 		 */
 		PRINTK("Syncing disks before copy\n");
 		do_suspend_sync();
+
+		/* Save state of all device drivers, and stop them. */		   
 		if(drivers_suspend()==0)
-			do_magic(0);			/* This function returns after machine woken up from resume */
+			/* If stopping device drivers worked, we proceed basically into
+			 * suspend_save_image.
+			 *
+			 * do_magic(0) returns after system is resumed.
+			 *
+			 * do_magic() copies all "used" memory to "free" memory, then
+			 * unsuspends all device drivers, and writes memory to disk
+			 * using normal kernel mechanism.
+			 */
+			do_magic(0);
 		PRINTK("Restarting processes...\n");
 		thaw_processes();
 	}
@@ -1004,8 +1016,8 @@
 
 static int bdev_write_page(struct block_device *bdev, long pos, void *buf)
 {
-	struct buffer_head *bh;
 #if 0
+	struct buffer_head *bh;
 	BUG_ON (pos%PAGE_SIZE);
 	bh = __bread(bdev, pos/PAGE_SIZE, PAGE_SIZE);
 	if (!bh || (!bh->b_data)) {

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
