Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265780AbUATWrl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 17:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265763AbUATWrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 17:47:41 -0500
Received: from gprs214-112.eurotel.cz ([160.218.214.112]:55427 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265838AbUATWrT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 17:47:19 -0500
Date: Tue, 20 Jan 2004 23:46:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, benh@kernel.crashing.org
Subject: swsusp does not stop DMA properly during resume
Message-ID: <20040120224653.GA19159@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

As Ben pointed out, swsusp is not doing the right thing with devices
in 2.6.1. I had patch for a long time here, and it needs to go
in... It stops them before copying pages back, so there are no issues
with running DMAs etc.

								Pavel

Ben:

> Looking at swsusp code in current 2.6, when do you do that pass ? On the
> shutdown pass, you call devices_suspend(4); which is fine. But I don't see
> where you call devices_suspend(X) on the resume path. IMHO, that should be
> done from the boot kernel after loading the suspend image and before
> starting the resume process. Your mdelay(1000) for waiting for DMA to settle
> down is PLAIN WRONG imho, even dangerous. (And typically, an USB controller
> will still be hapilly be DMA'ing all over your memory). That's what I call
> idling devices at this point, and that's where I'd call devices_suspend(1),
> and we should do that for kexec too.

Index: linux/kernel/power/swsusp.c
===================================================================
--- linux.orig/kernel/power/swsusp.c	2004-01-13 22:52:40.000000000 +0100
+++ linux/kernel/power/swsusp.c	2004-01-09 20:33:05.000000000 +0100
@@ -488,33 +492,6 @@
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
@@ -569,7 +546,7 @@
 
 static void suspend_save_image(void)
 {
-	drivers_unsuspend();
+	device_resume();
 
 	lock_swapdevices();
 	write_suspend_image();
@@ -615,6 +592,7 @@
 	mb();
 	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */ 
 
+	device_power_down(4);
 	PRINTK( "Waiting for DMAs to settle down...\n");
 	mdelay(1000);	/* We do not want some readahead with DMA to corrupt our memory, right?
 			   Do it with disabled interrupts for best effect. That way, if some
@@ -630,8 +608,10 @@
 
 	PRINTK( "Freeing prev allocated pagedir\n" );
 	free_suspend_pagedir((unsigned long) pagedir_save);
+	device_power_up();
 	spin_unlock_irq(&suspend_pagedir_lock);
-	drivers_resume(RESUME_ALL_PHASES);
+	device_resume();
+	update_screen(fg_console);	/* Hmm, is this the problem? */
 
 	PRINTK( "Fixing swap signatures... " );
 	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
@@ -672,7 +652,9 @@
 {
 	int is_problem;
 	read_swapfiles();
+	device_power_down(4);
 	is_problem = suspend_prepare_image();
+	device_power_up();
 	spin_unlock_irq(&suspend_pagedir_lock);
 	if (!is_problem) {
 		kernel_fpu_end();	/* save_processor_state() does kernel_fpu_begin, and we need to revert it in order to pass in_atomic() checks */
@@ -716,7 +709,7 @@
 		blk_run_queues();
 
 		/* Save state of all device drivers, and stop them. */		   
-		if(drivers_suspend()==0)
+		if ((res = device_suspend(4))==0)
 			/* If stopping device drivers worked, we proceed basically into
 			 * suspend_save_image.
 			 *
@@ -1091,6 +1072,7 @@
 	printk( "resuming from %s\n", resume_file);
 	if (read_suspend_image(resume_file, 0))
 		goto read_failure;
+	device_suspend(4);
 	do_magic(1);
 	panic("This never returns");
 
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
