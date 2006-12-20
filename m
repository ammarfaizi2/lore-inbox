Return-Path: <linux-kernel-owner+w=401wt.eu-S1161117AbWLUBIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161117AbWLUBIh (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 20:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161109AbWLUBIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 20:08:16 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:55066 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161110AbWLUBIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 20:08:14 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 4/4] swsusp: Change pm_ops handling by userland interface
Date: Wed, 20 Dec 2006 22:47:34 +0100
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <200612202237.07295.rjw@sisk.pl>
In-Reply-To: <200612202237.07295.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612202247.34536.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the userland interface of swsusp call pm_ops->finish() after
enable_nonboot_cpus() and before resume_device(),
as indicated by the recent discussion on Linux-PM
(cf. http://lists.osdl.org/pipermail/linux-pm/2006-November/004164.html).

This patch changes the SNAPSHOT_PMOPS ioctl so that its first function,
PMOPS_PREPARE, only sets a switch turning the platform suspend mode on, and
its last function, PMOPS_FINISH, only checks if the platform mode is enabled.
This should allow the older userland tools to work with new kernels without
any modifications.

The changes here only affect the userland interface of swsusp.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 kernel/power/user.c |   64 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 13 deletions(-)

Index: linux-2.6.20-rc1-mm1/kernel/power/user.c
===================================================================
--- linux-2.6.20-rc1-mm1.orig/kernel/power/user.c
+++ linux-2.6.20-rc1-mm1/kernel/power/user.c
@@ -37,6 +37,7 @@ static struct snapshot_data {
 	int mode;
 	char frozen;
 	char ready;
+	char platform_suspend;
 } snapshot_state;
 
 static atomic_t device_available = ATOMIC_INIT(1);
@@ -66,6 +67,7 @@ static int snapshot_open(struct inode *i
 	data->bitmap = NULL;
 	data->frozen = 0;
 	data->ready = 0;
+	data->platform_suspend = 0;
 
 	return 0;
 }
@@ -122,7 +124,23 @@ static ssize_t snapshot_write(struct fil
 	return res;
 }
 
-static inline int snapshot_suspend(void)
+static inline int platform_prepare(void)
+{
+	int error = 0;
+
+	if (pm_ops && pm_ops->prepare)
+		error = pm_ops->prepare(PM_SUSPEND_DISK);
+
+	return error;
+}
+
+static inline void platform_finish(void)
+{
+	if (pm_ops && pm_ops->finish)
+		pm_ops->finish(PM_SUSPEND_DISK);
+}
+
+static inline int snapshot_suspend(int platform_suspend)
 {
 	int error;
 
@@ -132,6 +150,11 @@ static inline int snapshot_suspend(void)
 	if (error)
 		goto Finish;
 
+	if (platform_suspend) {
+		error = platform_prepare();
+		if (error)
+			goto Finish;
+	}
 	suspend_console();
 	error = device_suspend(PMSG_FREEZE);
 	if (error)
@@ -144,6 +167,9 @@ static inline int snapshot_suspend(void)
 	}
 	enable_nonboot_cpus();
  Resume_devices:
+	if (platform_suspend)
+		platform_finish();
+
 	device_resume();
 	resume_console();
  Finish:
@@ -151,12 +177,17 @@ static inline int snapshot_suspend(void)
 	return error;
 }
 
-static inline int snapshot_restore(void)
+static inline int snapshot_restore(int platform_suspend)
 {
 	int error;
 
 	mutex_lock(&pm_mutex);
 	pm_prepare_console();
+	if (platform_suspend) {
+		error = platform_prepare();
+		if (error)
+			goto Finish;
+	}
 	suspend_console();
 	error = device_suspend(PMSG_PRETHAW);
 	if (error)
@@ -168,8 +199,12 @@ static inline int snapshot_restore(void)
 
 	enable_nonboot_cpus();
  Resume_devices:
+	if (platform_suspend)
+		platform_finish();
+
 	device_resume();
 	resume_console();
+ Finish:
 	pm_restore_console();
 	mutex_unlock(&pm_mutex);
 	return error;
@@ -221,7 +256,7 @@ static int snapshot_ioctl(struct inode *
 			error = -EPERM;
 			break;
 		}
-		error = snapshot_suspend();
+		error = snapshot_suspend(data->platform_suspend);
 		if (!error)
 			error = put_user(in_suspend, (unsigned int __user *)arg);
 		if (!error)
@@ -235,7 +270,7 @@ static int snapshot_ioctl(struct inode *
 			error = -EPERM;
 			break;
 		}
-		error = snapshot_restore();
+		error = snapshot_restore(data->platform_suspend);
 		break;
 
 	case SNAPSHOT_FREE:
@@ -342,28 +377,31 @@ static int snapshot_ioctl(struct inode *
 		break;
 
 	case SNAPSHOT_PMOPS:
+		error = -EINVAL;
+
 		switch (arg) {
 
 		case PMOPS_PREPARE:
-			if (pm_ops->prepare) {
-				error = pm_ops->prepare(PM_SUSPEND_DISK);
-			}
+			data->platform_suspend = 1;
+			error = 0;
 			break;
 
 		case PMOPS_ENTER:
-			kernel_shutdown_prepare(SYSTEM_SUSPEND_DISK);
-			error = pm_ops->enter(PM_SUSPEND_DISK);
+			if (data->platform_suspend) {
+				kernel_shutdown_prepare(SYSTEM_SUSPEND_DISK);
+				error = pm_ops->enter(PM_SUSPEND_DISK);
+				error = 0;
+			}
 			break;
 
 		case PMOPS_FINISH:
-			if (pm_ops && pm_ops->finish) {
-				pm_ops->finish(PM_SUSPEND_DISK);
-			}
+			if (data->platform_suspend)
+				error = 0;
+
 			break;
 
 		default:
 			printk(KERN_ERR "SNAPSHOT_PMOPS: invalid argument %ld\n", arg);
-			error = -EINVAL;
 
 		}
 		break;
