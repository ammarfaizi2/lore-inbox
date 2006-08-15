Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbWHONFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbWHONFP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 09:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965093AbWHONFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 09:05:15 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:49316 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965090AbWHONFN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 09:05:13 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] PM: Use suspend_console in swsusp and make it configureable
Date: Tue, 15 Aug 2006 15:09:05 +0200
User-Agent: KMail/1.9.3
Cc: Linux PM <linux-pm@osdl.org>, Pavel Machek <pavel@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608151509.06087.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The appended patch does the following:

1) Adds suspend_console() and resume_console() to the suspend-to-disk code
paths so that people using netconsole are safe with swsusp.

2) Adds a Kconfig option allowing us to disable suspend_/resume_console()
if need be.

3) Marks CONFIG_PM_TRACE as dangerous.

Comments welcome.

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/console.h |    5 +++++
 kernel/power/Kconfig    |   13 ++++++++++++-
 kernel/power/disk.c     |    8 ++++++++
 kernel/power/user.c     |    8 +++++++-
 kernel/printk.c         |    2 ++
 5 files changed, 34 insertions(+), 2 deletions(-)

Index: linux-2.6.18-rc4-mm1/kernel/power/disk.c
===================================================================
--- linux-2.6.18-rc4-mm1.orig/kernel/power/disk.c
+++ linux-2.6.18-rc4-mm1/kernel/power/disk.c
@@ -18,6 +18,7 @@
 #include <linux/fs.h>
 #include <linux/mount.h>
 #include <linux/pm.h>
+#include <linux/console.h>
 #include <linux/cpu.h>
 
 #include "power.h"
@@ -119,8 +120,10 @@ int pm_suspend_disk(void)
 	if (error)
 		return error;
 
+	suspend_console();
 	error = device_suspend(PMSG_FREEZE);
 	if (error) {
+		resume_console();
 		printk("Some devices failed to suspend\n");
 		unprepare_processes();
 		return error;
@@ -133,6 +136,7 @@ int pm_suspend_disk(void)
 
 	if (in_suspend) {
 		device_resume();
+		resume_console();
 		pr_debug("PM: writing image.\n");
 		error = swsusp_write();
 		if (!error)
@@ -148,6 +152,7 @@ int pm_suspend_disk(void)
 	swsusp_free();
  Done:
 	device_resume();
+	resume_console();
 	unprepare_processes();
 	return error;
 }
@@ -212,7 +217,9 @@ static int software_resume(void)
 
 	pr_debug("PM: Preparing devices for restore.\n");
 
+	suspend_console();
 	if ((error = device_suspend(PMSG_PRETHAW))) {
+		resume_console();
 		printk("Some devices failed to suspend\n");
 		swsusp_free();
 		goto Thaw;
@@ -224,6 +231,7 @@ static int software_resume(void)
 	swsusp_resume();
 	pr_debug("PM: Restore failed, recovering.n");
 	device_resume();
+	resume_console();
  Thaw:
 	unprepare_processes();
  Done:
Index: linux-2.6.18-rc4-mm1/kernel/power/user.c
===================================================================
--- linux-2.6.18-rc4-mm1.orig/kernel/power/user.c
+++ linux-2.6.18-rc4-mm1/kernel/power/user.c
@@ -19,6 +19,7 @@
 #include <linux/swapops.h>
 #include <linux/pm.h>
 #include <linux/fs.h>
+#include <linux/console.h>
 #include <linux/cpu.h>
 
 #include <asm/uaccess.h>
@@ -173,12 +174,14 @@ static int snapshot_ioctl(struct inode *
 		/* Free memory before shutting down devices. */
 		error = swsusp_shrink_memory();
 		if (!error) {
+			suspend_console();
 			error = device_suspend(PMSG_FREEZE);
 			if (!error) {
 				in_suspend = 1;
 				error = swsusp_suspend();
 				device_resume();
 			}
+			resume_console();
 		}
 		up(&pm_sem);
 		if (!error)
@@ -196,11 +199,13 @@ static int snapshot_ioctl(struct inode *
 		}
 		down(&pm_sem);
 		pm_prepare_console();
+		suspend_console();
 		error = device_suspend(PMSG_PRETHAW);
 		if (!error) {
 			error = swsusp_resume();
 			device_resume();
 		}
+		resume_console();
 		pm_restore_console();
 		up(&pm_sem);
 		break;
@@ -289,6 +294,7 @@ static int snapshot_ioctl(struct inode *
 		}
 
 		/* Put devices to sleep */
+		suspend_console();
 		error = device_suspend(PMSG_SUSPEND);
 		if (error) {
 			printk(KERN_ERR "Failed to suspend some devices.\n");
@@ -299,7 +305,7 @@ static int snapshot_ioctl(struct inode *
 			/* Wake up devices */
 			device_resume();
 		}
-
+		resume_console();
 		if (pm_ops->finish)
 			pm_ops->finish(PM_SUSPEND_MEM);
 
Index: linux-2.6.18-rc4-mm1/include/linux/console.h
===================================================================
--- linux-2.6.18-rc4-mm1.orig/include/linux/console.h
+++ linux-2.6.18-rc4-mm1/include/linux/console.h
@@ -120,9 +120,14 @@ extern void console_stop(struct console 
 extern void console_start(struct console *);
 extern int is_console_locked(void);
 
+#ifndef CONFIG_PM_DISABLE_CONSOLE_SUSPEND
 /* Suspend and resume console messages over PM events */
 extern void suspend_console(void);
 extern void resume_console(void);
+#else
+static inline void suspend_console(void) {}
+static inline void resume_console(void) {}
+#endif /* CONFIG_PM_DISABLE_CONSOLE_SUSPEND */
 
 /* Some debug stub to catch some of the obvious races in the VT code */
 #if 1
Index: linux-2.6.18-rc4-mm1/kernel/power/Kconfig
===================================================================
--- linux-2.6.18-rc4-mm1.orig/kernel/power/Kconfig
+++ linux-2.6.18-rc4-mm1/kernel/power/Kconfig
@@ -36,8 +36,19 @@ config PM_DEBUG
 	code. This is helpful when debugging and reporting various PM bugs, 
 	like suspend support.
 
+config PM_DISABLE_CONSOLE_SUSPEND
+	bool "Keep console(s) enabled during suspend/resume (DANGEROUS)"
+	depends on PM && PM_DEBUG
+	default n
+	---help---
+	This option turns off the console suspend mechanism that prevents
+	debug messages from reaching the console during the suspend/resume
+	operations.  This may be helpful when debugging device drivers'
+	suspend/resume routines, but may itself lead to problems, for example
+	if netconsole is used.
+
 config PM_TRACE
-	bool "Suspend/resume event tracing"
+	bool "Suspend/resume event tracing (DANGEROUS)"
 	depends on PM && PM_DEBUG && X86_32 && EXPERIMENTAL
 	default n
 	---help---
Index: linux-2.6.18-rc4-mm1/kernel/printk.c
===================================================================
--- linux-2.6.18-rc4-mm1.orig/kernel/printk.c
+++ linux-2.6.18-rc4-mm1/kernel/printk.c
@@ -702,6 +702,7 @@ int __init add_preferred_console(char *n
 	return 0;
 }
 
+#ifndef CONFIG_PM_DISABLE_CONSOLE_SUSPEND
 /**
  * suspend_console - suspend the console subsystem
  *
@@ -718,6 +719,7 @@ void resume_console(void)
 	console_suspended = 0;
 	release_console_sem();
 }
+#endif /* CONFIG_PM_DISABLE_CONSOLE_SUSPEND */
 
 /**
  * acquire_console_sem - lock the console system for exclusive use.
