Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTI1WYZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 18:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbTI1WYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 18:24:25 -0400
Received: from gprs144-121.eurotel.cz ([160.218.144.121]:640 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262321AbTI1WYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 18:24:23 -0400
Date: Mon, 29 Sep 2003 00:24:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: [pm] Make software resume be called at resume
Message-ID: <20030928222404.GA227@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This adds neccessary initcall() so that machine really does resume,
and adds gpl, and makes sure we do not do random bit flips on non-PSE
machine. Please apply,
								Pavel
[Yes, software_suspend needs to return int and do some error
handling. But not today, and this is better than random bit flips.]

PS: echo -n mem > /sys/power/state works here (good!), but echo 3 >
/proc/acpi/sleep fails to even put machine to sleep.

--- clean/kernel/power/swsusp.c	2003-09-28 22:06:45.000000000 +0200
+++ linux/kernel/power/swsusp.c	2003-09-29 00:19:37.000000000 +0200
@@ -5,7 +5,10 @@
  * machine suspend feature using pretty near only high-level routines
  *
  * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
- * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 1998,2001-2003 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 2003 Patrick Mochel <mochel@osdl.org>
+ *
+ * This file is released under the GPLv2.
  *
  * I'd like to thank the following people for their work:
  * 
@@ -681,7 +678,8 @@
 
 static void do_software_suspend(void)
 {
-	arch_prepare_suspend();
+	if (arch_prepare_suspend())
+		panic("Architecture failed to prepare\n");
 	if (pm_prepare_console())
 		printk( "%sCan't allocate a console... proceeding\n", name_suspend);
 	if (!prepare_suspend_processes()) {
@@ -1031,12 +1029,18 @@
 	return error;
 }
 
-/*
- * Called from init kernel_thread.
- * We check if we have an image and if so we try to resume
+/**
+ *	software_resume - Resume from a saved image.
+ *
+ *	Called as a late_initcall (so all devices are discovered and 
+ *	initialized), we call swsusp to see if we have a saved image or not.
+ *	If so, we quiesce devices, the restore the saved image. We will 
+ *	return above (in pm_suspend_disk() ) if everything goes well. 
+ *	Otherwise, we fail gracefully and return to the normally 
+ *	scheduled program.
+ *
  */
-
-void software_resume(void)
+static void software_resume(void)
 {
 	if (num_online_cpus() > 1) {
 		printk(KERN_WARNING "Software Suspend has malfunctioning SMP support. Disabled :(\n");	
@@ -1075,6 +1079,8 @@
 	return;
 }
 
+late_initcall(software_resume);
+
 static int __init resume_setup(char *str)
 {
 	if (resume_status == NORESUME)



-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
