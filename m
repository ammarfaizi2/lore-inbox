Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272339AbTHEA7D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 20:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272331AbTHEA6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 20:58:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:5345 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272318AbTHEA6S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 20:58:18 -0400
Date: Mon, 4 Aug 2003 18:03:07 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] save/restore screen support for ACPI S3 sleep
In-Reply-To: <20030726225646.GA519@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0308041800461.23977-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This way console should be correctly restored after S3...
> 
> [Prototype should be added to include/linux/suspend.h].
> 
> kernel/suspend.c part only moves code out of "SWSUSP_ONLY"
> section.

I moved this code to kernel/power/console.c and made it dependent on 
CONFIG_PM only. I also fixed up the breakage Andrew reported earlier and 
added prototypes to include/linux/suspend.h. Patch below for review (not 
directly applicable, as it's relative to the series).

	-pat

ChangeSet 1.1518, 2003/08/04 17:35:30-07:00, mochel@osdl.org

[power] Divorce suspend console code from swsusp.

- Create kernel/power/console.c
- Rename prepare_suspend_console() to pm_prepare_console() and 
  restore_console() to pm_restore_console().
- Add prototypes to include/linux/suspend.h.
- Make kernel/power/console.o dependent only on CONFIG_PM
- Simplify logic for SUSPEND_CONSOLE define
- Make software_resume() prepare console much earlier, so we can localize
  the loglevel variables in console.c. 
- Remove #ifdef CONFIG_VT from console.c, and just check for SUSPEND_CONSOLE.
  (Perhaps we should make entire file dependent on CONFIG_VT_CONSOLE?)
- Add kernel/power/power.h to share things across local files.


 include/linux/suspend.h |    4 +++
 kernel/power/Makefile   |    2 -
 kernel/power/console.c  |   40 ++++++++++++++++++++++++++++++
 kernel/power/power.h    |    9 ++++++
 kernel/power/swsusp.c   |   62 ++++++------------------------------------------
 5 files changed, 62 insertions(+), 55 deletions(-)


diff -Nru a/include/linux/suspend.h b/include/linux/suspend.h
--- a/include/linux/suspend.h	Mon Aug  4 17:44:57 2003
+++ b/include/linux/suspend.h	Mon Aug  4 17:44:57 2003
@@ -85,6 +85,10 @@
 extern void refrigerator(unsigned long);
 extern int freeze_processes(void);
 extern void thaw_processes(void);
+
+extern int pm_prepare_console(void);
+extern void pm_restore_console(void);
+
 #else
 static inline void refrigerator(unsigned long)
 {
diff -Nru a/kernel/power/Makefile b/kernel/power/Makefile
--- a/kernel/power/Makefile	Mon Aug  4 17:44:57 2003
+++ b/kernel/power/Makefile	Mon Aug  4 17:44:57 2003
@@ -1,2 +1,2 @@
-obj-y				:= process.o
+obj-y				:= process.o console.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o
diff -Nru a/kernel/power/console.c b/kernel/power/console.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/kernel/power/console.c	Mon Aug  4 17:44:57 2003
@@ -0,0 +1,40 @@
+#include <linux/vt_kern.h>
+#include <linux/kbd_kern.h>
+#include "power.h"
+
+static int new_loglevel = 7;
+static int orig_loglevel;
+static int orig_fgconsole, orig_kmsg;
+
+int pm_prepare_console(void)
+{
+	orig_loglevel = console_loglevel;
+	console_loglevel = new_loglevel;
+
+#ifdef SUSPEND_CONSOLE
+	orig_fgconsole = fg_console;
+
+	if(vc_allocate(SUSPEND_CONSOLE))
+	  /* we can't have a free VC for now. Too bad,
+	   * we don't want to mess the screen for now. */
+		return 1;
+
+	set_console (SUSPEND_CONSOLE);
+	if(vt_waitactive(SUSPEND_CONSOLE)) {
+		pr_debug("Suspend: Can't switch VCs.");
+		return 1;
+	}
+	orig_kmsg = kmsg_redirect;
+	kmsg_redirect = SUSPEND_CONSOLE;
+#endif
+	return 0;
+}
+
+void pm_restore_console(void)
+{
+	console_loglevel = orig_loglevel;
+#ifdef SUSPEND_CONSOLE
+	set_console (orig_fgconsole);
+#endif
+	return;
+}
diff -Nru a/kernel/power/power.h b/kernel/power/power.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/kernel/power/power.h	Mon Aug  4 17:44:57 2003
@@ -0,0 +1,9 @@
+
+
+/* With SUSPEND_CONSOLE defined, it suspend looks *really* cool, but
+   we probably do not take enough locks for switching consoles, etc,
+   so bad things might happen.
+*/
+#if defined(CONFIG_VT) && defined(CONFIG_VT_CONSOLE)
+#define SUSPEND_CONSOLE	(MAX_NR_CONSOLES-1)
+#endif
diff -Nru a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c	Mon Aug  4 17:44:57 2003
+++ b/kernel/power/swsusp.c	Mon Aug  4 17:44:57 2003
@@ -43,8 +43,8 @@
 #include <linux/version.h>
 #include <linux/delay.h>
 #include <linux/reboot.h>
-#include <linux/vt_kern.h>
 #include <linux/bitops.h>
+#include <linux/vt_kern.h>
 #include <linux/kbd_kern.h>
 #include <linux/keyboard.h>
 #include <linux/spinlock.h>
@@ -63,19 +63,12 @@
 #include <asm/pgtable.h>
 #include <asm/io.h>
 
+#include "power.h"
+
 extern long sys_sync(void);
 
 unsigned char software_suspend_enabled = 0;
 
-#define SUSPEND_CONSOLE	(MAX_NR_CONSOLES-1)
-/* With SUSPEND_CONSOLE defined, it suspend looks *really* cool, but
-   we probably do not take enough locks for switching consoles, etc,
-   so bad things might happen.
-*/
-#if !defined(CONFIG_VT) || !defined(CONFIG_VT_CONSOLE)
-#undef SUSPEND_CONSOLE
-#endif
-
 #define __ADDRESS(x)  ((unsigned long) phys_to_virt(x))
 #define ADDRESS(x) __ADDRESS((x) << PAGE_SHIFT)
 #define ADDRESS2(x) __ADDRESS(__pa(x))		/* Needed for x86-64 where some pages are in memory twice */
@@ -89,9 +82,6 @@
 spinlock_t suspend_pagedir_lock __nosavedata = SPIN_LOCK_UNLOCKED;
 
 /* Variables to be preserved over suspend */
-static int new_loglevel = 7;
-static int orig_loglevel;
-static int orig_fgconsole, orig_kmsg;
 static int pagedir_order_check;
 static int nr_copy_pages_check;
 
@@ -455,40 +445,6 @@
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
-
 static int prepare_suspend_processes(void)
 {
 	sys_sync();	/* Syncing needs pdflushd, so do it before stopping processes */
@@ -743,7 +699,7 @@
 static void do_software_suspend(void)
 {
 	arch_prepare_suspend();
-	if (prepare_suspend_console())
+	if (pm_prepare_console())
 		printk( "%sCan't allocate a console... proceeding\n", name_suspend);
 	if (!prepare_suspend_processes()) {
 
@@ -774,7 +730,7 @@
 	}
 	software_suspend_enabled = 1;
 	MDELAY(1000);
-	restore_console();
+	pm_restore_console();
 }
 
 /*
@@ -997,8 +953,6 @@
 		bdev_write_page(bdev, 0, cur);
 	}
 
-	if (prepare_suspend_console())
-		printk("%sCan't allocate a console... proceeding\n", name_resume);
 	printk( "%sSignature found, resuming\n", name_resume );
 	MDELAY(1000);
 
@@ -1119,8 +1073,8 @@
 	}
 	MDELAY(1000);
 
-	orig_loglevel = console_loglevel;
-	console_loglevel = new_loglevel;
+	if (pm_prepare_console())
+		printk("swsusp: Can't allocate a console... proceeding\n");
 
 	if (!resume_file[0] && resume_status == RESUME_SPECIFIED) {
 		printk( "suspension device unspecified\n" );
@@ -1134,7 +1088,7 @@
 	panic("This never returns");
 
 read_failure:
-	console_loglevel = orig_loglevel;
+	pm_restore_console();
 	return;
 }
 

