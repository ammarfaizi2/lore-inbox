Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266181AbTGIV1T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 17:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266159AbTGIVZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 17:25:34 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:13226 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S266158AbTGIVZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 17:25:17 -0400
Date: Wed, 9 Jul 2003 23:38:21 +0200
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Fix swsusp with PREEMPT
Message-ID: <20030709213820.GA142@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes swsusp with CONFIG_PREEMPT and makes locking a bit more
obvious. Please apply,
							Pavel

--- clean/kernel/suspend.c	2003-05-27 13:44:03.000000000 +0200
+++ linux/kernel/suspend.c	2003-07-09 23:30:12.000000000 +0200
@@ -692,7 +694,6 @@
 		printk(KERN_CRIT "%sCouldn't get enough free pages, on %d pages short\n",
 		       name_suspend, nr_needed_pages-nr_free_pages());
 		root_swap = 0xFFFF;
-		spin_unlock_irq(&suspend_pagedir_lock);
 		return 1;
 	}
 	si_swapinfo(&i);	/* FIXME: si_swapinfo(&i) returns all swap devices information.
@@ -700,7 +701,6 @@
 	if (i.freeswap < nr_needed_pages)  {
 		printk(KERN_CRIT "%sThere's not enough swap space available, on %ld pages short\n",
 		       name_suspend, nr_needed_pages-i.freeswap);
-		spin_unlock_irq(&suspend_pagedir_lock);
 		return 1;
 	}
 
@@ -710,7 +710,6 @@
 		/* Shouldn't happen */
 		printk(KERN_CRIT "%sCouldn't allocate enough pages\n",name_suspend);
 		panic("Really should not happen");
-		spin_unlock_irq(&suspend_pagedir_lock);
 		return 1;
 	}
 	nr_copy_pages_check = nr_copy_pages;
@@ -724,12 +723,9 @@
 	 * End of critical section. From now on, we can write to memory,
 	 * but we should not touch disk. This specially means we must _not_
 	 * touch swap space! Except we must write out our image of course.
-	 *
-	 * Following line enforces not writing to disk until we choose.
 	 */
 
 	printk( "critical section/: done (%d pages copied)\n", nr_copy_pages );
-	spin_unlock_irq(&suspend_pagedir_lock);
 	return 0;
 }
 
@@ -808,6 +804,24 @@
 #endif
 }
 
+/* do_magic() is implemented in arch/?/kernel/suspend_asm.S, and basically does:
+
+	if (!resume) {
+		do_magic_suspend_1();
+		save_processor_state();
+		SAVE_REGISTERS
+		do_magic_suspend_2();
+		return;
+	}
+	GO_TO_SWAPPER_PAGE_TABLES
+	do_magic_resume_1();
+	COPY_PAGES_BACK
+	RESTORE_REGISTERS
+	restore_processor_state();
+	do_magic_resume_2();
+
+ */
+
 void do_magic_suspend_1(void)
 {
 	mb();
@@ -818,8 +832,13 @@
 
 void do_magic_suspend_2(void)
 {
+	int is_problem;
 	read_swapfiles();
-	if (!suspend_prepare_image()) {	/* suspend_save_image realeses suspend_pagedir_lock */
+	is_problem = suspend_prepare_image();
+	spin_unlock_irq(&suspend_pagedir_lock);
+	if (!is_problem) {
+		kernel_fpu_end();	/* save_processor_state() does kernel_fpu_begin, and we need to revert it in order to pass in_atomic() checks */
+		BUG_ON(in_atomic());
 		suspend_save_image();
 		suspend_power_down();	/* FIXME: if suspend_power_down is commented out, console is lost after few suspends ?! */
 	}
@@ -1224,13 +1243,13 @@
 	orig_loglevel = console_loglevel;
 	console_loglevel = new_loglevel;
 
-	if(!resume_file[0] && resume_status == RESUME_SPECIFIED) {
+	if (!resume_file[0] && resume_status == RESUME_SPECIFIED) {
 		printk( "suspension device unspecified\n" );
 		return;
 	}
 
 	printk( "resuming from %s\n", resume_file);
-	if(read_suspend_image(resume_file, 0))
+	if (read_suspend_image(resume_file, 0))
 		goto read_failure;
 	do_magic(1);
 	panic("This never returns");

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
