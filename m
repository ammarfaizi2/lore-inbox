Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316213AbSEZQrh>; Sun, 26 May 2002 12:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316214AbSEZQrg>; Sun, 26 May 2002 12:47:36 -0400
Received: from [195.39.17.254] ([195.39.17.254]:48539 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316213AbSEZQre>;
	Sun, 26 May 2002 12:47:34 -0400
Date: Sun, 26 May 2002 18:35:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: swsusp: killing sysrq-d support
Message-ID: <20020526163528.GA2381@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

swsusp supported being called from interrupt. I no longer think that's
good idea. It killes tq_bdflush and cleans code up at pieces. This
kills it.

[I'm not sure what version of pdflush.c do you have. If it rejects,
then sorry, and just kill run_task_queue(&tq_pdflush) manually, or
ignore it and I'll fix swsusp compilation in 2.5.18.]
								Pavel

--- linux-swsusp.linusplus/drivers/acpi/acpi_system.c	Sun May 19 17:25:33 2002
+++ linux-swsusp/drivers/acpi/acpi_system.c	Sun May 26 17:25:20 2002
@@ -774,11 +771,9 @@
 	if (!system->states[state])
 		return_VALUE(-ENODEV);
 
-	
 #ifdef CONFIG_SOFTWARE_SUSPEND
 	if (state == 4) {
-		/* We are working from process context, that's why we may call it directly. */ 
-		do_software_suspend();
+		software_suspend();
 		return_VALUE(count);
 	}
 #endif
--- linux-swsusp.linusplus/drivers/char/sysrq.c	Fri May  3 00:08:35 2002
+++ linux-swsusp/drivers/char/sysrq.c	Sun May 26 17:15:57 2002
@@ -27,7 +27,6 @@
 #include <linux/quotaops.h>
 #include <linux/smp_lock.h>
 #include <linux/module.h>
-#include <linux/suspend.h>
 
 #include <linux/spinlock.h>
 
@@ -318,22 +317,6 @@
 	action_msg:	"Kill All Tasks",
 };
 
-#ifdef CONFIG_SOFTWARE_SUSPEND
-static void sysrq_handle_swsusp(int key, struct pt_regs *pt_regs,
-		struct kbd_struct *kbd, struct tty_struct *tty) {
-        if(!software_suspend_enabled) {
-		printk("Software Suspend is not possible now\n");
-		return;
-	}
-	software_suspend();
-}
-static struct sysrq_key_op sysrq_swsusp_op = {
-	handler:	sysrq_handle_swsusp,
-	help_msg:	"suspenD",
-	action_msg:	"Software suspend\n",
-};
-#endif
-
 /* END SIGNAL SYSRQ HANDLERS BLOCK */
 
 
@@ -356,11 +339,7 @@
 		 and will never arive */
 /* b */	&sysrq_reboot_op,
 /* c */	NULL,
-#ifdef CONFIG_SOFTWARE_SUSPEND
-/* d */	&sysrq_swsusp_op,
-#else
 /* d */	NULL,
-#endif
 /* e */	&sysrq_term_op,
 /* f */	NULL,
 /* g */	NULL,
--- linux-swsusp.linusplus/fs/buffer.c	Tue May 21 23:33:34 2002
+++ linux-swsusp/fs/buffer.c	Sun May 26 17:21:44 2002
@@ -32,7 +32,6 @@
 #include <linux/writeback.h>
 #include <linux/mempool.h>
 #include <linux/hash.h>
-#include <linux/suspend.h>
 #include <asm/bitops.h>
 
 #define BH_ENTRY(list) list_entry((list), struct buffer_head, b_assoc_buffers)
@@ -123,8 +122,6 @@
 	smp_mb__after_clear_bit();
 	wake_up_buffer(bh);
 }
-
-DECLARE_TASK_QUEUE(tq_bdflush);
 
 /*
  * Block until a buffer comes unlocked.  This doesn't stop it
--- linux-swsusp.linusplus/include/linux/tqueue.h	Tue May 21 23:37:55 2002
+++ linux-swsusp/include/linux/tqueue.h	Sun May 26 17:22:12 2002
@@ -66,7 +66,7 @@
 #define DECLARE_TASK_QUEUE(q)	LIST_HEAD(q)
 #define TQ_ACTIVE(q)		(!list_empty(&q))
 
-extern task_queue tq_timer, tq_immediate, tq_disk, tq_bdflush;
+extern task_queue tq_timer, tq_immediate, tq_disk;
 
 /*
  * To implement your own list of active bottom halfs, use the following
--- linux-swsusp.linusplus/kernel/suspend.c	Tue May 21 23:49:20 2002
+++ linux-swsusp/kernel/suspend.c	Sun May 26 17:24:58 2002
@@ -34,15 +34,6 @@
  * For TODOs,FIXMEs also look in Documentation/swsusp.txt
  */
 
-/*
- * TODO:
- *
- * - we should launch a kernel_thread to process suspend request, cleaning up
- * bdflush from this task. (check apm.c for something similar).
- */
-
-/* FIXME: try to poison to memory */
-
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/swapctl.h>
@@ -847,9 +777,6 @@
 	/* NOTREACHED */
 }
 
-/* forward decl */
-void do_software_suspend(void);
-
 /*
  * Magic happens here
  */
@@ -886,7 +813,6 @@
 #ifdef SUSPEND_CONSOLE
 	update_screen(fg_console);	/* Hmm, is this the problem? */
 #endif
-	suspend_tq.routine = (void *)do_software_suspend;
 }
 
 static void do_magic_suspend_1(void)
@@ -919,7 +841,6 @@
 	drivers_resume(RESUME_PHASE1);
 	spin_unlock_irq(&suspend_pagedir_lock);
 	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
-	suspend_tq.routine = (void *)do_software_suspend;
 	printk(KERN_WARNING "%sLeaving do_magic_suspend_2...\n", name_suspend);	
 }
 
@@ -927,10 +848,9 @@
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
@@ -958,13 +877,9 @@
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
@@ -972,8 +887,8 @@
 		return;
 
 	software_suspend_enabled = 0;
-	queue_task(&suspend_tq, &tq_bdflush);
-	wakeup_bdflush();
+	BUG_ON(in_interrupt());
+	do_software_suspend();
 }
 
 /* More restore stuff */
--- linux-swsusp.linusplus/mm/pdflush.c	Tue May 21 23:33:38 2002
+++ linux-swsusp/mm/pdflush.c	Sun May 26 17:23:08 2002
@@ -108,9 +108,6 @@
 	for ( ; ; ) {
 		struct pdflush_work *pdf;
 
-#ifdef CONFIG_SOFTWARE_SUSPEND
-		run_task_queue(&tq_bdflush);
-#endif
 		list_add(&my_work->list, &pdflush_list);
 		my_work->when_i_went_to_sleep = jiffies;
 		set_current_state(TASK_INTERRUPTIBLE);

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
