Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316900AbSE1Uhz>; Tue, 28 May 2002 16:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316903AbSE1Uhy>; Tue, 28 May 2002 16:37:54 -0400
Received: from [195.39.17.254] ([195.39.17.254]:57756 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316900AbSE1Uht>;
	Tue, 28 May 2002 16:37:49 -0400
Date: Tue, 28 May 2002 22:24:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: swsusp: cleanups from Florent, fix usb
Message-ID: <20020528202428.GA4908@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This contains some trivial cleanups from Florent, usb fix (also from
him) and docs updates (also...). Please apply,
									Pavel

--- linux-swsusp.test/Documentation/kernel-parameters.txt	Thu Apr 18 22:45:20 2002
+++ linux-swsusp/Documentation/kernel-parameters.txt	Tue May 28 21:55:53 2002
@@ -45,6 +45,7 @@
 	SERIAL	Serial support is enabled.
 	SMP 	The kernel is an SMP kernel.
 	SOUND	Appropriate sound system support is enabled.
+	SWSUSP  Software suspension is enabled.
 	V4L	Video For Linux support is enabled.
 	VGA 	The VGA console has been enabled.
 	VT	Virtual terminal support is enabled.
@@ -392,6 +393,8 @@
 			initial RAM disk.
 
 	nointroute	[IA-64]
+
+	noresume	[SWSUSP] Disables resume and restore original swap space.
  
 	no-scroll	[VGA]
 
@@ -518,6 +521,8 @@
 	reboot=		[BUGS=ix86]
 
 	reserve=	[KNL,BUGS] force the kernel to ignore some iomem area.
+
+	resume=		[SWSUSP] specify the partition device for software suspension.
 
 	riscom8=	[HW,SERIAL]
 
--- linux-swsusp.test/drivers/block/loop.c	Sun May 26 19:31:49 2002
+++ linux-swsusp/drivers/block/loop.c	Tue May 28 21:57:18 2002
@@ -535,7 +535,9 @@
 	daemonize();
 
 	sprintf(current->comm, "loop%d", lo->lo_number);
-	current->flags |= PF_IOTHREAD;
+	current->flags |= PF_IOTHREAD;	/* loop can be used in an encrypted device
+					   hence, it mustn't be stopped at all because it could
+					   be indirectly used during suspension */
 
 	spin_lock_irq(&current->sigmask_lock);
 	sigfillset(&current->blocked);
--- linux-swsusp.test/drivers/usb/core/hub.c	Sun May 26 19:31:57 2002
+++ linux-swsusp/drivers/usb/core/hub.c	Tue May 28 21:41:56 2002
@@ -25,6 +25,7 @@
 #endif
 #include <linux/usb.h>
 #include <linux/usbdevice_fs.h>
+#include <linux/suspend.h>
 
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
@@ -1064,6 +1065,8 @@
 	/* Send me a signal to get me die (for debugging) */
 	do {
 		usb_hub_events();
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_IOTHREAD);
 		wait_event_interruptible(khubd_wait, !list_empty(&hub_event_list)); 
 	} while (!signal_pending(current));
 
--- linux-swsusp.test/fs/jbd/journal.c	Sun May 26 19:32:00 2002
+++ linux-swsusp/fs/jbd/journal.c	Tue May 28 22:10:32 2002
@@ -226,7 +226,6 @@
 			journal->j_commit_interval / HZ);
 	list_add(&journal->j_all_journals, &all_journals);
 
-	current->flags |= PF_KERNTHREAD;
 	/* And now, wait forever for commit wakeup events. */
 	while (1) {
 		if (journal->j_flags & JFS_UNMOUNT)
--- linux-swsusp.test/fs/reiserfs/journal.c	Sun May 26 19:32:02 2002
+++ linux-swsusp/fs/reiserfs/journal.c	Tue May 28 22:10:21 2002
@@ -1888,7 +1888,6 @@
   spin_unlock_irq(&current->sigmask_lock);
 
   sprintf(current->comm, "kreiserfsd") ;
-  current->flags |= PF_KERNTHREAD;
   lock_kernel() ;
   while(1) {
 
--- linux-swsusp.test/kernel/suspend.c	Tue May 28 10:37:06 2002
+++ linux-swsusp/kernel/suspend.c	Tue May 28 21:51:38 2002
@@ -1,5 +1,5 @@
 /*
- * linux/kernel/swsusp.c
+ * linux/kernel/suspend.c
  *
  * This file is to realize architecture-independent
  * machine suspend feature using pretty near only high-level routines
@@ -73,7 +73,7 @@
    we probably do not take enough locks for switching consoles, etc,
    so bad things might happen.
 */
-#ifndef CONFIG_VT
+#if !defined(CONFIG_VT) || !defined(CONFIG_VT_CONSOLE)
 #undef SUSPEND_CONSOLE
 #endif
 
@@ -859,22 +859,22 @@
 void do_software_suspend(void)
 {
 	arch_prepare_suspend();
-	if (!prepare_suspend_console()) {
-		if (!prepare_suspend_processes()) {
-			free_some_memory();
-
-			/* No need to invalidate any vfsmnt list -- they will be valid after resume, anyway.
-			 *
-			 * We sync here -- so you have consistent filesystem state when things go wrong.
-			 * -- so that noone writes to disk after we do atomic copy of data.
-			 */
-			PRINTS("Syncing disks before copy\n");
-			do_suspend_sync();
-			if(drivers_suspend()==0)
-				do_magic(0);			/* This function returns after machine woken up from resume */
-			PRINTR("Restarting processes...\n");
-			thaw_processes();
-		}
+	if (prepare_suspend_console())
+		printk( "Can't allocate a console... proceeding\n");
+	if (!prepare_suspend_processes()) {
+		free_some_memory();
+		
+		/* No need to invalidate any vfsmnt list -- they will be valid after resume, anyway.
+		 *
+		 * We sync here -- so you have consistent filesystem state when things go wrong.
+		 * -- so that noone writes to disk after we do atomic copy of data.
+		 */
+		PRINTS("Syncing disks before copy\n");
+		do_suspend_sync();
+		if(drivers_suspend()==0)
+			do_magic(0);			/* This function returns after machine woken up from resume */
+		PRINTR("Restarting processes...\n");
+		thaw_processes();
 	}
 	software_suspend_enabled = 1;
 	MDELAY(1000);
--- linux-swsusp.test/mm/pdflush.c	Sun May 26 20:56:18 2002
+++ linux-swsusp/mm/pdflush.c	Tue May 28 22:10:42 2002
@@ -91,7 +91,7 @@
 	recalc_sigpending();
 	spin_unlock_irq(&current->sigmask_lock);
 
-	current->flags |= PF_FLUSHER | PF_KERNTHREAD;
+	current->flags |= PF_FLUSHER;
 	my_work->fn = NULL;
 	my_work->who = current;
 
--- linux-swsusp.test/mm/vmscan.c	Sun May 26 19:32:05 2002
+++ linux-swsusp/mm/vmscan.c	Tue May 28 22:08:36 2002
@@ -782,7 +782,7 @@
 	 * us from recursively trying to free more memory as we're
 	 * trying to free the first piece of memory in the first place).
 	 */
-	tsk->flags |= PF_MEMALLOC | PF_KERNTHREAD;
+	tsk->flags |= PF_MEMALLOC;
 
 	/*
 	 * Kswapd main loop.

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
