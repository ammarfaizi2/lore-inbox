Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbTJVXcI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 19:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbTJVXcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 19:32:08 -0400
Received: from gprs144-47.eurotel.cz ([160.218.144.47]:12676 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261226AbTJVXcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 19:32:02 -0400
Date: Thu, 23 Oct 2003 01:31:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [pm] fix device suspend/resume handling
Message-ID: <20031022233127.GA6410@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

swsusp was completely wrong at device handling. Wrong calls with
interrupts disabled, where they should be enabled etc. And it forgot
to suspend devices before copying memory snapshot back [please check
your pmdisk code, you are likely to do the same mistake].

								Pavel

[Oops, this one:

-               if(drivers_suspend()==0)
+               if ((res = device_suspend(4))==0)

probably will reject. Sorry about that, should be easy to fix up].

--- tmp/linux/kernel/power/swsusp.c	2003-10-23 01:09:52.000000000 +0200
+++ linux/kernel/power/swsusp.c	2003-10-23 00:59:17.000000000 +0200
@@ -491,33 +491,6 @@
 	printk("|\n");
 }
 
-/* Make disk drivers accept operations, again */
-static void drivers_unsuspend(void)
-{
-	device_resume();
-}
-
-/* Called from process context */
-static int drivers_suspend(void)
-{
-	return device_suspend(4);
-}
-
-#define RESUME_PHASE1 1 /* Called from interrupts disabled */
-#define RESUME_PHASE2 2 /* Called with interrupts enabled */
-#define RESUME_ALL_PHASES (RESUME_PHASE1 | RESUME_PHASE2)
-static void drivers_resume(int flags)
-{
-	if (flags & RESUME_PHASE1) {
-		device_resume();
-	}
-  	if (flags & RESUME_PHASE2) {
-#ifdef SUSPEND_CONSOLE
-		update_screen(fg_console);	/* Hmm, is this the problem? */
-#endif
-	}
-}
-
 static int suspend_prepare_image(void)
 {
 	struct sysinfo i;
@@ -572,7 +545,7 @@
 
 static void suspend_save_image(void)
 {
-	drivers_unsuspend();
+	device_resume();
 
 	lock_swapdevices();
 	write_suspend_image();
@@ -618,6 +591,7 @@
 	mb();
 	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */ 
 
+	device_power_down(4);
 	PRINTK( "Waiting for DMAs to settle down...\n");
 	mdelay(1000);	/* We do not want some readahead with DMA to corrupt our memory, right?
 			   Do it with disabled interrupts for best effect. That way, if some
@@ -633,8 +607,10 @@
 
 	PRINTK( "Freeing prev allocated pagedir\n" );
 	free_suspend_pagedir((unsigned long) pagedir_save);
+	device_power_up();
 	spin_unlock_irq(&suspend_pagedir_lock);
-	drivers_resume(RESUME_ALL_PHASES);
+	device_resume();
+	update_screen(fg_console);	/* Hmm, is this the problem? */
 
 	PRINTK( "Fixing swap signatures... " );
 	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
@@ -675,7 +651,9 @@
 {
 	int is_problem;
 	read_swapfiles();
+	device_power_down(4);
 	is_problem = suspend_prepare_image();
+	device_power_up();
 	spin_unlock_irq(&suspend_pagedir_lock);
 	if (!is_problem) {
 		kernel_fpu_end();	/* save_processor_state() does kernel_fpu_begin, and we need to revert it in order to pass in_atomic() checks */
@@ -719,7 +708,7 @@
 		blk_run_queues();
 
 		/* Save state of all device drivers, and stop them. */		   
-		if(drivers_suspend()==0)
+		if ((res = device_suspend(4))==0)
 			/* If stopping device drivers worked, we proceed basically into
 			 * suspend_save_image.
 			 *
@@ -1094,6 +1071,7 @@
 	printk( "resuming from %s\n", resume_file);
 	if (read_suspend_image(resume_file, 0))
 		goto read_failure;
+	device_suspend(4);
 	do_magic(1);
 	panic("This never returns");
 
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
