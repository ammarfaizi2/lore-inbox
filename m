Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316300AbSFJVWq>; Mon, 10 Jun 2002 17:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316309AbSFJVWq>; Mon, 10 Jun 2002 17:22:46 -0400
Received: from [195.39.17.254] ([195.39.17.254]:32930 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316300AbSFJVWo>;
	Mon, 10 Jun 2002 17:22:44 -0400
Date: Mon, 10 Jun 2002 23:22:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: suspend-to-{ram/disk} cleanups/fixes for 2.5.21
Message-ID: <20020610212230.GA15070@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This kills Sysrq-D support (did not work anyway, and complicated
code).

Adds resume support to i8259A (otherwise interrupts will not work
after S3).

HAVE_NEW_DEVICE_MODEL is always true in 2.5, so we should define
it. S3 can't work properly without that. Also limit toshiba workaround
to S1. (This hide lack of i8259A support for me).

Fixes compilation, and kills <asm/suspend.h> being included
twice with ugly hacks around.

Please apply,
								Pavel

--- clean.2.5/arch/i386/Config.help	Sun May 26 19:31:43 2002
+++ linux-swsusp/arch/i386/Config.help	Mon Jun 10 23:03:24 2002
@@ -944,10 +944,12 @@
 Software Suspend
 CONFIG_SOFTWARE_SUSPEND
   Enable the possibilty of suspendig machine. It doesn't need APM.
-  You may suspend your machine by either pressing Sysrq-d or with
-  'swsusp' or 'shutdown -z <time>' (patch for sysvinit needed). It
-  creates an image which is saved in your active swaps. By the next
-  booting the kernel detects the saved image, restores the memory from
+  You may suspend your machine by 'swsusp' or 'shutdown -z <time>' 
+  (patch for sysvinit needed). 
+
+  It creates an image which is saved in your active swaps. By the next
+  booting the, pass 'resume=/path/to/your/swap/file' and kernel will 
+  detect the saved image, restore the memory from
   it and then it continues to run as before you've suspended.
   If you don't want the previous state to continue use the 'noresume'
   kernel option. However note that your partitions will be fsck'd and
--- clean.2.5/arch/i386/kernel/i8259.c	Thu May 30 12:21:00 2002
+++ linux-swsusp/arch/i386/kernel/i8259.c	Mon Jun 10 23:03:24 2002
@@ -238,9 +238,21 @@
 	}
 }
 
+static int i8259A_resume(struct device *dev, u32 level)
+{
+	if (level == RESUME_POWER_ON)
+		init_8259A(0);
+	return 0;
+}
+
+static struct device_driver driver_i8259A = {
+	resume:		i8259A_resume,
+};
+
 static struct device device_i8259A = {
 	name:	       	"i8259A",
 	bus_id:		"0020",
+	driver:		&driver_i8259A,
 };
 
 static int __init init_8259A_devicefs(void)
--- clean.2.5/arch/i386/kernel/suspend.c	Mon Jun 10 17:17:39 2002
+++ linux-swsusp/arch/i386/kernel/suspend.c	Mon Jun 10 23:03:25 2002
@@ -4,9 +4,9 @@
  * Distribute under GPLv2
  *
  * Copyright (c) 2002 Pavel Machek <pavel@suse.cz>
+ * Copyright (c) 2001 Patrick Mochel <mochel@osdl.org>
  */
 
-#define ACPI_C
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -26,7 +26,6 @@
 #include <asm/acpi.h>
 #include <asm/tlbflush.h>
 
-
 static struct saved_context saved_context;
 
 /*
@@ -229,6 +228,7 @@
         kernel_fpu_end();
 }
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
 /* Local variables for do_magic */
 static int loop __nosavedata = 0;
 static int loop2 __nosavedata = 0;
@@ -300,3 +300,4 @@
 
 	do_magic_resume_2();
 }
+#endif
--- clean.2.5/drivers/acpi/system.c	Mon Jun 10 17:17:41 2002
+++ linux-swsusp/drivers/acpi/system.c	Mon Jun 10 23:03:25 2002
@@ -24,6 +24,7 @@
  */
 
 #define ACPI_C
+#define HAVE_NEW_DEVICE_MODEL
 
 #include <linux/config.h>
 #include <linux/kernel.h>
@@ -134,9 +135,11 @@
 
 	/* restore device context */
 	device_resume(RESUME_RESTORE_STATE);
+#else
+#error Resume cant work without driver model
 #endif
 
-	if (dmi_broken & BROKEN_INIT_AFTER_S1) {
+	if ((state == ACPI_STATE_S1) && (dmi_broken & BROKEN_INIT_AFTER_S1)) {
 		printk("Broken toshiba laptop -> kicking interrupts\n");
 		init_8259A(0);
 	}
--- clean.2.5/drivers/char/sysrq.c	Sun May 26 19:31:51 2002
+++ linux-swsusp/drivers/char/sysrq.c	Mon Jun 10 23:03:25 2002
@@ -319,22 +319,6 @@
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
 
 
@@ -357,11 +341,7 @@
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
--- clean.2.5/include/linux/suspend.h	Mon Jun 10 17:17:50 2002
+++ linux-swsusp/include/linux/suspend.h	Mon Jun 10 23:14:10 2002
@@ -1,12 +1,13 @@
 #ifndef _LINUX_SWSUSP_H
 #define _LINUX_SWSUSP_H
 
-#if defined(SUSPEND_C) || defined(ACPI_C)
+#ifdef CONFIG_X86
 #include <asm/suspend.h>
 #endif
 #include <linux/swap.h>
 #include <linux/notifier.h>
 #include <linux/config.h>
+#include <linux/init.h>
 
 extern unsigned char software_suspend_enabled;
 
--- clean.2.5/kernel/suspend.c	Mon Jun 10 17:17:50 2002
+++ linux-swsusp/kernel/suspend.c	Mon Jun 10 23:03:25 2002
@@ -44,7 +44,6 @@
 #include <linux/version.h>
 #include <linux/delay.h>
 #include <linux/reboot.h>
-#include <linux/init.h>
 #include <linux/vt_kern.h>
 #include <linux/bitops.h>
 #include <linux/interrupt.h>
@@ -845,9 +844,6 @@
 	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
 	printk(KERN_WARNING "%sLeaving do_magic_suspend_2...\n", name_suspend);	
 }
-
-#define SUSPEND_C
-#include <asm/suspend.h>
 
 /*
  * We try to swap out as much as we can then make a copy of the

									
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
