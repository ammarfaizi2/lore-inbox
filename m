Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316483AbSEOUHe>; Wed, 15 May 2002 16:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316484AbSEOUHd>; Wed, 15 May 2002 16:07:33 -0400
Received: from [195.39.17.254] ([195.39.17.254]:29847 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316483AbSEOUHI>;
	Wed, 15 May 2002 16:07:08 -0400
Date: Wed, 15 May 2002 21:52:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: alan@redhat.com, kernel list <linux-kernel@vger.kernel.org>,
        fchabaud@free.fr
Subject: swsusp cleanups
Message-ID: <20020515195226.GA8635@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This cleans up swsusp a bit, many of this originaly by Florent. Oh,
this makes it actually turn off machine, not debugging behaviour we
had before. Please apply.

								Pavel

--- linux-ac/drivers/ide/ide-disk.c	Thu May  9 00:02:39 2002
+++ linux-swsusp.24/drivers/ide/ide-disk.c	Wed May 15 21:35:13 2002
@@ -1540,7 +1540,6 @@
 void ide_disk_suspend(void)
 {
 	int i;
-	printk("ide_disk_suspend()\n");
 	while (ide_disks_busy()) {
 		printk("*");
 		schedule();
@@ -1562,7 +1561,6 @@
 void ide_disk_unsuspend(void)
 {
 	int i;
-	printk("ide_disk_unsuspend()\n");
 	for (i=0; i<MAX_HWIFS; i++) {
 		struct hwgroup_s *hwgroup = ide_hwifs[i].hwgroup;
 
@@ -1576,7 +1574,6 @@
 void ide_disk_resume(void)
 {
 	int i;
-	printk("ide_disk_resume()\n");
 	for (i=0; i<MAX_HWIFS; i++) {
 		struct hwgroup_s *hwgroup = ide_hwifs[i].hwgroup;
 
--- linux-ac/kernel/suspend.c	Thu May  9 00:02:42 2002
+++ linux-swsusp.24/kernel/suspend.c	Wed May 15 21:41:02 2002
@@ -161,6 +161,7 @@
 #define	DEBUG_DEFAULT	1
 #undef	DEBUG_PROCESS
 #undef	DEBUG_SLOW
+#define TEST_SWSUSP 0		/* Set to 1 to reboot instead of halt machine after suspension */
 
 #ifdef DEBUG_DEFAULT
 #define PRINTD(func, f, a...)	\
@@ -380,7 +381,7 @@
 			swapfile_used[i]=SWAPFILE_UNUSED;
 		} else {
 			if(!len) {
-	    			PRINTS(KERN_WARNING "resume= option should be used to set suspend device" );
+	    			printk(KERN_WARNING "resume= option should be used to set suspend device" );
 				if(root_swap == 0xFFFF) {
 					swapfile_used[i] = SWAPFILE_SUSPEND;
 					root_swap = i;
@@ -834,10 +835,6 @@
 	 * filesystem clean: it is not. (And it does not matter, if we resume
 	 * correctly, we'll mark system clean, anyway.)
 	 */
-#if 0
-	do_suspend_sync();
-/* Is this really so bright idea? We might corrupt FS here! */
-#endif
 	return 0;
 }
 
@@ -848,12 +845,11 @@
 #ifdef CONFIG_VT
 	printk(KERN_EMERG "shift_state: %04x\n", shift_state);
 	mdelay(1000);
-	if ((shift_state & (1 << KG_CTRL)))
-		machine_power_off();
+	if (TEST_SWSUSP ^ (!!(shift_state & (1 << KG_CTRL))))
+		machine_restart(NULL);
 	else
 #endif
-		machine_restart(NULL);
-
+		machine_power_off();
 
 	printk(KERN_EMERG "%sProbably not capable for powerdown. System halted.\n", name_suspend);
 	machine_halt();
@@ -862,17 +858,6 @@
 	/* NOTREACHED */
 }
 
-static void restore_task(void)
-{
-	MDELAY(1000);
-#if 0
-	/* Should not be neccessary -- we saved whole CPU context */
-	PRINTR( "Activating task\n" );
-	activate_mm(current->mm,current->mm);
-	activate_task(current);
-#endif
-}
-
 /* forward decl */
 static void do_software_suspend(void);
 
@@ -909,9 +894,6 @@
 	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
 	PRINTK( "ok\n" );
 
-#if 0
-	restore_task ();	/* Should not be neccessary! */
-#endif
 #ifdef SUSPEND_CONSOLE
 	update_screen(fg_console);	/* Hmm, is this the problem? */
 #endif
@@ -975,9 +957,6 @@
 			 */
 			PRINTS( "Syncing disks before copy\n" );
 			do_suspend_sync();
-#if 0
-			schedule_timeout(1*HZ);	/* Is this needed to get data properly to disk? */
-#endif
 			drivers_suspend();
 			if(drivers_suspend()==0)
 				do_magic(0);			/* This function returns after machine woken up from resume */
@@ -1148,13 +1127,14 @@
 		return -1;
 	}
 	memcpy(buf, bh->b_data, PAGE_SIZE);
-	brelse(bh);			/* FIXME: maybe bforget should be here */
+	BUG_ON(!buffer_uptodate(bh));
+	brelse(bh);
 	return 0;
 } 
 
 /* Checked up-to HERE */
 
-int resume_try_to_read(const char * specialfile)
+static int resume_try_to_read(const char * specialfile, int noresume)
 {
 	union diskpage *cur;
 	swp_entry_t next;
@@ -1284,7 +1264,7 @@
 			printk( "%sError %d resuming\n", name_resume, error );
 			panic("Wanted to resume but it did not work\n");
 	}
-	set_blocksize(resume_device, blksize);	/* Needed! In case its is normal swap space */
+	set_blocksize(resume_device, blksize);	/* Needed! In case it is normal swap space */
 	MDELAY(1000);
 	return error;
 }
@@ -1322,7 +1302,7 @@
 	}
 
 	printk( "resuming from %s\n", resume_file);
-	if(resume_try_to_read(resume_file))
+	if(resume_try_to_read(resume_file, 0))
 		goto read_failure;
 	do_magic(1);
 	panic("This never returns");
@@ -1332,8 +1312,7 @@
 	return;
 }
 
-
-int resume_setup(char *str)
+static int __init resume_setup(char *str)
 {
 	if(resume_status)
 		return 1;
@@ -1347,7 +1326,7 @@
 static int __init software_noresume(char *str)
 {
 	if(!resume_status)
-		printk(KERN_WARNING "noresume option has overridden a resume= option\n");
+		printk(KERN_WARNING "noresume option lacks a resume= option\n");
 	resume_status = NORESUME;
 	
 	return 1;

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
