Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270623AbTGZWlt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 18:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270626AbTGZWlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 18:41:49 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:50576 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S270623AbTGZWlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 18:41:44 -0400
Date: Sun, 27 Jul 2003 00:56:46 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: [PM] save/restore screen support for ACPI S3 sleep
Message-ID: <20030726225646.GA519@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This way console should be correctly restored after S3...

[Prototype should be added to include/linux/suspend.h].

kernel/suspend.c part only moves code out of "SWSUSP_ONLY"
section.



Index: linux/drivers/acpi/sleep/main.c
===================================================================
--- linux.orig/drivers/acpi/sleep/main.c	2003-07-22 13:39:42.000000000 +0200
+++ linux/drivers/acpi/sleep/main.c	2003-07-22 12:53:27.000000000 +0200
@@ -226,6 +234,7 @@
 	if (state == ACPI_STATE_S4 && !acpi_gbl_FACS->S4bios_f)
 		return AE_ERROR;
 
+	prepare_suspend_console();
 	/*
 	 * TBD: S1 can be done without device_suspend.  Make a CONFIG_XX
 	 * to handle however when S1 failed without device_suspend.
@@ -270,6 +279,7 @@
 	/* reset firmware waking vector */
 	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
 	thaw_processes();
+	restore_console();
 
 	return status;
 }
Index: linux/kernel/suspend.c
===================================================================
--- linux.orig/kernel/suspend.c	2003-07-22 13:39:43.000000000 +0200
+++ linux/kernel/suspend.c	2003-07-22 13:46:26.000000000 +0200
@@ -5,7 +5,7 @@
  * machine suspend feature using pretty near only high-level routines
  *
  * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
- * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 1998,2001-2003 Pavel Machek <pavel@suse.cz>
  *
  * I'd like to thank the following people for their work:
  * 
@@ 1,-1 1,-1 @@
 
+int prepare_suspend_console(void)
+{
+	orig_loglevel = console_loglevel;
+	console_loglevel = new_loglevel;
+
+#ifdef CONFIG_VT
+	orig_fgconsole = fg_console;
+#ifdef SUSPEND_CONSOLE
+	if(vc_allocate(SUSPEND_CONSOLE))
+	  /* we can't have a free VC for now. Too bad,
+	   * we don't want to mess the screen for now. */
+		return 1;
+
+	set_console (SUSPEND_CONSOLE);
+	if (vt_waitactive(SUSPEND_CONSOLE)) {
+		printk(KERN_ERR "Bummer. Can't switch VCs.\n");
+		return 1;
+	}
+	orig_kmsg = kmsg_redirect;
+	kmsg_redirect = SUSPEND_CONSOLE;
+#endif
+#endif
+	return 0;
+}
+
+void restore_console(void)
+{
+	console_loglevel = orig_loglevel;
+#ifdef SUSPEND_CONSOLE
+	set_console (orig_fgconsole);
+#endif
+	return;
+}
+
+#ifdef CONFIG_SOFTWARE_SUSPEND
 /*
  * Saving part...
  */

@@ -569,39 +603,6 @@
 	return pagedir;
 }
 
-static int prepare_suspend_console(void)
-{
-	orig_loglevel = console_loglevel;
-	console_loglevel = new_loglevel;
-
-#ifdef CONFIG_VT
-	orig_fgconsole = fg_console;
-#ifdef SUSPEND_CONSOLE
-	if(vc_allocate(SUSPEND_CONSOLE))
-	  /* we can't have a free VC for now. Too bad,
-	   * we don't want to mess the screen for now. */
-		return 1;
-
-	set_console (SUSPEND_CONSOLE);
-	if(vt_waitactive(SUSPEND_CONSOLE)) {
-		PRINTK("Bummer. Can't switch VCs.");
-		return 1;
-	}
-	orig_kmsg = kmsg_redirect;
-	kmsg_redirect = SUSPEND_CONSOLE;
-#endif
-#endif
-	return 0;
-}
-
-static void restore_console(void)
-{
-	console_loglevel = orig_loglevel;
-#ifdef SUSPEND_CONSOLE
-	set_console (orig_fgconsole);
-#endif
-	return;
-}
 
 static int prepare_suspend_processes(void)
 {

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
