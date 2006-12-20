Return-Path: <linux-kernel-owner+w=401wt.eu-S1161108AbWLUBIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161108AbWLUBIP (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 20:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161109AbWLUBIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 20:08:15 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:55065 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161108AbWLUBIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 20:08:13 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 3/4] swsusp: Change code ordering in user.c
Date: Wed, 20 Dec 2006 22:45:27 +0100
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <200612202237.07295.rjw@sisk.pl>
In-Reply-To: <200612202237.07295.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200612202245.27699.rjw@sisk.pl>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change the ordering of code in kernel/power/user.c so that device_suspend()
is called before disable_nonboot_cpus() and device_resume() is called after
enable_nonboot_cpus().  This is needed to make the userland suspend call
pm_ops->finish() after enable_nonboot_cpus() and before device_resume(),
as indicated by the recent discussion on Linux-PM
(cf. http://lists.osdl.org/pipermail/linux-pm/2006-November/004164.html).

The changes here only affect the userland interface of swsusp.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 kernel/power/user.c |   92 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 58 insertions(+), 34 deletions(-)

Index: linux-2.6.20-rc1-mm1/kernel/power/user.c
===================================================================
--- linux-2.6.20-rc1-mm1.orig/kernel/power/user.c
+++ linux-2.6.20-rc1-mm1/kernel/power/user.c
@@ -122,6 +122,59 @@ static ssize_t snapshot_write(struct fil
 	return res;
 }
 
+static inline int snapshot_suspend(void)
+{
+	int error;
+
+	mutex_lock(&pm_mutex);
+	/* Free memory before shutting down devices. */
+	error = swsusp_shrink_memory();
+	if (error)
+		goto Finish;
+
+	suspend_console();
+	error = device_suspend(PMSG_FREEZE);
+	if (error)
+		goto Resume_devices;
+
+	error = disable_nonboot_cpus();
+	if (!error) {
+		in_suspend = 1;
+		error = swsusp_suspend();
+	}
+	enable_nonboot_cpus();
+ Resume_devices:
+	device_resume();
+	resume_console();
+ Finish:
+	mutex_unlock(&pm_mutex);
+	return error;
+}
+
+static inline int snapshot_restore(void)
+{
+	int error;
+
+	mutex_lock(&pm_mutex);
+	pm_prepare_console();
+	suspend_console();
+	error = device_suspend(PMSG_PRETHAW);
+	if (error)
+		goto Resume_devices;
+
+	error = disable_nonboot_cpus();
+	if (!error)
+		error = swsusp_resume();
+
+	enable_nonboot_cpus();
+ Resume_devices:
+	device_resume();
+	resume_console();
+	pm_restore_console();
+	mutex_unlock(&pm_mutex);
+	return error;
+}
+
 static int snapshot_ioctl(struct inode *inode, struct file *filp,
                           unsigned int cmd, unsigned long arg)
 {
@@ -145,14 +198,9 @@ static int snapshot_ioctl(struct inode *
 		if (data->frozen)
 			break;
 		mutex_lock(&pm_mutex);
-		error = disable_nonboot_cpus();
-		if (!error) {
-			error = freeze_processes();
-			if (error) {
-				thaw_processes();
-				enable_nonboot_cpus();
-				error = -EBUSY;
-			}
+		if (freeze_processes()) {
+			thaw_processes();
+			error = -EBUSY;
 		}
 		mutex_unlock(&pm_mutex);
 		if (!error)
@@ -164,7 +212,6 @@ static int snapshot_ioctl(struct inode *
 			break;
 		mutex_lock(&pm_mutex);
 		thaw_processes();
-		enable_nonboot_cpus();
 		mutex_unlock(&pm_mutex);
 		data->frozen = 0;
 		break;
@@ -174,20 +221,7 @@ static int snapshot_ioctl(struct inode *
 			error = -EPERM;
 			break;
 		}
-		mutex_lock(&pm_mutex);
-		/* Free memory before shutting down devices. */
-		error = swsusp_shrink_memory();
-		if (!error) {
-			suspend_console();
-			error = device_suspend(PMSG_FREEZE);
-			if (!error) {
-				in_suspend = 1;
-				error = swsusp_suspend();
-				device_resume();
-			}
-			resume_console();
-		}
-		mutex_unlock(&pm_mutex);
+		error = snapshot_suspend();
 		if (!error)
 			error = put_user(in_suspend, (unsigned int __user *)arg);
 		if (!error)
@@ -201,17 +235,7 @@ static int snapshot_ioctl(struct inode *
 			error = -EPERM;
 			break;
 		}
-		mutex_lock(&pm_mutex);
-		pm_prepare_console();
-		suspend_console();
-		error = device_suspend(PMSG_PRETHAW);
-		if (!error) {
-			error = swsusp_resume();
-			device_resume();
-		}
-		resume_console();
-		pm_restore_console();
-		mutex_unlock(&pm_mutex);
+		error = snapshot_restore();
 		break;
 
 	case SNAPSHOT_FREE:

