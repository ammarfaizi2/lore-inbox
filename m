Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271094AbTHGX3Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 19:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271103AbTHGX3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 19:29:25 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:27842 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S271094AbTHGX3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 19:29:23 -0400
Date: Fri, 8 Aug 2003 01:28:21 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: [PM] Gracefully handle errors from device_suspend()
Message-ID: <20030807232820.GA149@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This makes drivers_suspend() correctly fail when some driver vetoes
the suspend. Device disable is moved after pm_send_all; that looks
more correct to me as pm_send_all may expect some mainboard devices to
still work. Few small whitespace/codingstyle fixes.

[Sorry, filename is wrong, but it should be easy to fix.]

Please apply,
								Pavel

--- /usr/src/tmp/linux/kernel/suspend.c	2003-08-08 01:19:01.000000000 +0200
+++ /usr/src/linux/kernel/suspend.c	2003-08-08 01:14:26.000000000 +0200
@@ -636,19 +637,23 @@
 /* Called from process context */
 static int drivers_suspend(void)
 {
-	device_suspend(4, SUSPEND_NOTIFY);
-	device_suspend(4, SUSPEND_SAVE_STATE);
-	device_suspend(4, SUSPEND_DISABLE);
-	if(!pm_suspend_state) {
+	if (device_suspend(4, SUSPEND_NOTIFY))
+		return -EIO;
+	if (device_suspend(4, SUSPEND_SAVE_STATE)) {
+		device_resume(RESUME_RESTORE_STATE);
+		return -EIO;
+	}
+	if (!pm_suspend_state) {
 		if(pm_send_all(PM_SUSPEND,(void *)3)) {
 			printk(KERN_WARNING "Problem while sending suspend event\n");
-			return(1);
+			return -EIO;
 		}
 		pm_suspend_state=1;
 	} else
 		printk(KERN_WARNING "PM suspend state already raised\n");
+	device_suspend(4, SUSPEND_DISABLE);
 	  
-	return(0);
+	return 0;
 }
 
 #define RESUME_PHASE1 1 /* Called from interrupts disabled */
@@ -661,7 +666,7 @@
 		device_resume(RESUME_ENABLE);
 	}
   	if (flags & RESUME_PHASE2) {
-		if(pm_suspend_state) {
+		if (pm_suspend_state) {
 			if(pm_send_all(PM_RESUME,(void *)0))
 				printk(KERN_WARNING "Problem while sending resume event\n");
 			pm_suspend_state=0;
@@ -868,7 +873,7 @@
 		blk_run_queues();
 
 		/* Save state of all device drivers, and stop them. */		   
-		if(drivers_suspend()==0)
+		if (drivers_suspend()==0)
 			/* If stopping device drivers worked, we proceed basically into
 			 * suspend_save_image.
 			 *

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
