Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316289AbSEZS6i>; Sun, 26 May 2002 14:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316293AbSEZS6h>; Sun, 26 May 2002 14:58:37 -0400
Received: from [195.39.17.254] ([195.39.17.254]:64667 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316289AbSEZS6f>;
	Sun, 26 May 2002 14:58:35 -0400
Date: Sun, 26 May 2002 20:57:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp for 2.5.18: kill broken Magic-D support
Message-ID: <20020526185724.GA16004@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

It is probably good idea to create rule that suspend may only be done
from process context... And it simplifies code a lot. Here's the
patch.

Plus I move acpi_wakeup from acpi_wakeup.S to setup.c, to avoid
ifdef and clean up floppy.c a bit (first three hunks). Please apply, 

									Pavel

--- clean/arch/i386/kernel/acpi_wakeup.S	Sun May 26 19:31:44 2002
+++ linux-swsusp/arch/i386/kernel/acpi_wakeup.S	Wed May 22 23:22:53 2002
@@ -262,7 +262,6 @@
 
 ENTRY(saved_magic)	.long	0
 ENTRY(saved_magic2)	.long	0	
-ENTRY(saved_videomode)	.long	0
 
 ALIGN
 # saved registers
--- clean/arch/i386/kernel/setup.c	Sun May 26 19:31:44 2002
+++ linux-swsusp/arch/i386/kernel/setup.c	Sun May 26 19:46:10 2002
@@ -168,6 +168,8 @@
 static int disable_x86_serial_nr __initdata = 1;
 static int disable_x86_fxsr __initdata = 0;
 
+unsigned long saved_videomode;
+
 extern unsigned long saved_videomode;
 
 /*
@@ -684,10 +686,8 @@
  	drive_info = DRIVE_INFO;
  	screen_info = SCREEN_INFO;
 	apm_info.bios = APM_BIOS_INFO;
-#ifdef CONFIG_ACPI_SLEEP
 	saved_videomode = VIDEO_MODE;
 	printk("Video mode to be used for restore is %lx\n", saved_videomode);
-#endif
 	if( SYS_DESC_TABLE.length != 0 ) {
 		MCA_bus = SYS_DESC_TABLE.table[3] &0x2;
 		machine_id = SYS_DESC_TABLE.table[0];
--- clean/drivers/block/floppy.c	Sun May 26 19:31:49 2002
+++ linux-swsusp/drivers/block/floppy.c	Sun May 26 19:57:41 2002
@@ -4226,14 +4226,15 @@
 
 static int have_no_fdc= -ENODEV;
 
-static struct device device_floppy;
+static struct device device_floppy = {
+	name:		"floppy",
+	bus_id:		"03?0",
+};
 
 int __init floppy_init(void)
 {
 	int i,unit,drive;
 
-	strcpy(device_floppy.name, "floppy");
-	strcpy(device_floppy.bus_id, "03?0");
 	register_sys_device(&device_floppy);
 
 	raw_cmd = NULL;
--- clean/fs/buffer.c	Sun May 26 19:31:59 2002
+++ linux-swsusp/fs/buffer.c	Sun May 26 19:48:20 2002
@@ -122,8 +122,6 @@
 	wake_up_buffer(bh);
 }
 
-DECLARE_TASK_QUEUE(tq_bdflush);
-
 /*
  * Block until a buffer comes unlocked.  This doesn't stop it
  * from becoming locked again - you have to lock it yourself
--- clean/include/linux/tqueue.h	Sun May 26 19:32:04 2002
+++ linux-swsusp/include/linux/tqueue.h	Sun May 26 20:00:06 2002
@@ -66,7 +66,7 @@
 #define DECLARE_TASK_QUEUE(q)	LIST_HEAD(q)
 #define TQ_ACTIVE(q)		(!list_empty(&q))
 
-extern task_queue tq_timer, tq_immediate, tq_disk, tq_bdflush;
+extern task_queue tq_timer, tq_immediate, tq_disk;
 
 /*
  * To implement your own list of active bottom halfs, use the following
--- clean/kernel/suspend.c	Sun May 26 19:32:05 2002
+++ linux-swsusp/kernel/suspend.c	Sun May 26 20:01:48 2002
@@ -34,13 +34,6 @@
  * For TODOs,FIXMEs also look in Documentation/swsusp.txt
  */
 
-/*
- * TODO:
- *
- * - we should launch a kernel_thread to process suspend request, cleaning up
- * bdflush from this task. (check apm.c for something similar).
- */
-
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/swapctl.h>
@@ -66,6 +59,7 @@
 #include <linux/swap.h>
 #include <linux/pm.h>
 #include <linux/device.h>
+#include <linux/buffer_head.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -784,9 +778,6 @@
 	/* NOTREACHED */
 }
 
-/* forward decl */
-void do_software_suspend(void);
-
 /*
  * Magic happens here
  */
@@ -823,7 +814,6 @@
 #ifdef SUSPEND_CONSOLE
 	update_screen(fg_console);	/* Hmm, is this the problem? */
 #endif
-	suspend_tq.routine = (void *)do_software_suspend;
 }
 
 static void do_magic_suspend_1(void)
@@ -852,7 +842,6 @@
 	drivers_resume(RESUME_PHASE1);
 	spin_unlock_irq(&suspend_pagedir_lock);
 	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
-	suspend_tq.routine = (void *)do_software_suspend;
 	printk(KERN_WARNING "%sLeaving do_magic_suspend_2...\n", name_suspend);	
 }
 
@@ -860,10 +849,9 @@
 #include <asm/suspend.h>
 
 /*
- * This function is triggered using process bdflush. We try to swap out as
- * much as we can then make a copy of the occupied pages in memory so we can
- * make a copy of kernel state atomically, the I/O needed by saving won't
- * bother us anymore.
+ * We try to swap out as much as we can then make a copy of the
+ * occupied pages in memory so we can make a copy of kernel state
+ * atomically, the I/O needed by saving won't bother us anymore. 
  */
 void do_software_suspend(void)
 {
@@ -890,13 +878,9 @@
 	restore_console ();
 }
 
-struct tq_struct suspend_tq =
-	{ routine: (void *)(void *)do_software_suspend, 
-	  data: 0 };
-
 /*
- * This is the trigger function, we must queue ourself since we
- * can be called from interrupt && bdflush context is needed
+ * This is main interface to the outside world. It needs to be
+ * called from process context.
  */
 void software_suspend(void)
 {
@@ -904,8 +888,8 @@
 		return;
 
 	software_suspend_enabled = 0;
-	queue_task(&suspend_tq, &tq_bdflush);
-	wakeup_bdflush();
+	BUG_ON(in_interrupt());
+	do_software_suspend();
 }
 
 /* More restore stuff */
--- clean/mm/pdflush.c	Sun May 26 19:32:05 2002
+++ linux-swsusp/mm/pdflush.c	Sun May 26 19:54:22 2002
@@ -106,15 +106,12 @@
 		set_current_state(TASK_INTERRUPTIBLE);
 		spin_unlock_irq(&pdflush_lock);
 
-#ifdef CONFIG_SOFTWARE_SUSPEND
-		run_task_queue(&tq_bdflush);
 		if (current->flags & PF_FREEZE)
 			refrigerator(PF_IOTHREAD);
-#endif
 		schedule();
 
 		if (my_work->fn)
 			(*my_work->fn)(my_work->arg0);
 
 		/*
 		 * Thread creation: For how long have there been zero



-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
