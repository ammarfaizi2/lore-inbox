Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270592AbTGZWnX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 18:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270624AbTGZWnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 18:43:23 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:145 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S270592AbTGZWnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 18:43:06 -0400
Date: Sun, 27 Jul 2003 00:58:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: [PM] suspend.c cleanups
Message-ID: <20030726225809.GA528@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

These are only cleanups.
							Pavel

Index: linux/kernel/suspend.c
===================================================================
--- linux.orig/kernel/suspend.c	2003-07-22 13:39:43.000000000 +0200
+++ linux/kernel/suspend.c	2003-07-22 13:46:26.000000000 +0200
@@ -139,40 +139,45 @@
 
 static const char name_suspend[] = "Suspend Machine: ";
 static const char name_resume[] = "Resume Machine: ";
 #endif
 
 /*
  * Debug
  */
-#define	DEBUG_DEFAULT
-#undef	DEBUG_PROCESS
+#undef	DEBUG_DEFAULT
 #undef	DEBUG_SLOW
-#define TEST_SWSUSP 0		/* Set to 1 to reboot instead of halt machine after suspension */
+#define TEST_SWSUSP 1		/* Set to 1 to reboot instead of halt machine after suspension */
 
 #ifdef DEBUG_DEFAULT
-# define PRINTK(f, a...)       printk(f, ## a)
+# define PRINTK(f, a...)	printk(f, ## a)
 #else
-# define PRINTK(f, a...)
+# define PRINTK(f, a...)	do {} while (0)
 #endif
 
 #ifdef DEBUG_SLOW
 #define MDELAY(a) mdelay(a)
 #else
-#define MDELAY(a)
+#define MDELAY(a) do {} while (0)
 #endif

@@ -283,17 +329,6 @@
 	return 0;
 }
 
-/*
- * This is our sync function. With this solution we probably won't sleep
- * but that should not be a problem since tasks are stopped..
- */
-
-static inline void do_suspend_sync(void)
-{
-	blk_run_queues();
-#warning This might be broken. We need to somehow wait for data to reach the disk
-}
-
 /* We memorize in swapfile_used what swap devices are used for suspension */
 #define SWAPFILE_UNUSED    0
 #define SWAPFILE_SUSPEND   1	/* This is the suspending device */
@@ -861,20 +861,13 @@
 	if (prepare_suspend_console())
 		printk( "%sCan't allocate a console... proceeding\n", name_suspend);
 	if (!prepare_suspend_processes()) {
-
 		/* At this point, all user processes and "dangerous"
                    kernel threads are stopped. Free some memory, as we
                    need half of memory free. */
-
 		free_some_memory();
 		
-		/* No need to invalidate any vfsmnt list -- they will be valid after resume, anyway.
-		 *
-		 * We sync here -- so you have consistent filesystem state when things go wrong.
-		 * -- so that noone writes to disk after we do atomic copy of data.
-		 */
-		PRINTK("Syncing disks before copy\n");
-		do_suspend_sync();
+		/* No need to invalidate any vfsmnt list -- they will be valid after resume, anyway. */
+		blk_run_queues();
 
 		/* Save state of all device drivers, and stop them. */		   
 		if(drivers_suspend()==0)
@@ -906,7 +898,7 @@
 		return;
 
 	software_suspend_enabled = 0;
-	BUG_ON(in_interrupt());
+	BUG_ON(in_atomic());
 	do_software_suspend();
 }
 


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
