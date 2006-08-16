Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWHPLKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWHPLKm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 07:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWHPLKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 07:10:42 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:39597 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750954AbWHPLKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 07:10:41 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: [RFC][PATCH 1/3] swsusp: Use suspend_console
Date: Wed, 16 Aug 2006 13:06:26 +0200
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>
References: <200608151509.06087.rjw@sisk.pl> <20060816104143.GC9497@elf.ucw.cz> <200608161304.51758.rjw@sisk.pl>
In-Reply-To: <200608161304.51758.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608161306.26450.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add suspend_console() and resume_console() to the suspend-to-disk code paths
so that the users of netconsole can use swsusp with it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/disk.c |    8 ++++++++
 kernel/power/user.c |    8 +++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

Index: linux-2.6.18-rc4-mm1/kernel/power/disk.c
===================================================================
--- linux-2.6.18-rc4-mm1.orig/kernel/power/disk.c	2006-08-16 11:51:35.000000000 +0200
+++ linux-2.6.18-rc4-mm1/kernel/power/disk.c	2006-08-16 11:58:01.000000000 +0200
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
--- linux-2.6.18-rc4-mm1.orig/kernel/power/user.c	2006-08-16 11:51:35.000000000 +0200
+++ linux-2.6.18-rc4-mm1/kernel/power/user.c	2006-08-16 11:58:01.000000000 +0200
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
 

