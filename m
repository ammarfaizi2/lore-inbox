Return-Path: <linux-kernel-owner+w=401wt.eu-S1161119AbWLUBIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161119AbWLUBIl (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 20:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161109AbWLUBIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 20:08:40 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:55070 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161111AbWLUBIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 20:08:20 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 1/4] PM: Change code ordering in main.c
Date: Wed, 20 Dec 2006 22:42:01 +0100
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <200612202237.07295.rjw@sisk.pl>
In-Reply-To: <200612202237.07295.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612202242.01434.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change the ordering of code in kernel/power/main.c so that device_suspend()
is called before disable_nonboot_cpus() and pm_ops->finish() is called after
enable_nonboot_cpus() and before device_resume(), as indicated by recent
discussion on Linux-PM
(cf. http://lists.osdl.org/pipermail/linux-pm/2006-November/004164.html).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 kernel/power/main.c |   34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

Index: linux-2.6.20-rc1-mm1/kernel/power/main.c
===================================================================
--- linux-2.6.20-rc1-mm1.orig/kernel/power/main.c
+++ linux-2.6.20-rc1-mm1/kernel/power/main.c
@@ -43,6 +43,11 @@ void pm_set_ops(struct pm_ops * ops)
 	mutex_unlock(&pm_mutex);
 }
 
+static inline void pm_finish(suspend_state_t state)
+{
+	if (pm_ops->finish)
+		pm_ops->finish(state);
+}
 
 /**
  *	suspend_prepare - Do prep work before entering low-power state.
@@ -63,10 +68,6 @@ static int suspend_prepare(suspend_state
 
 	pm_prepare_console();
 
-	error = disable_nonboot_cpus();
-	if (error)
-		goto Enable_cpu;
-
 	if (freeze_processes()) {
 		error = -EAGAIN;
 		goto Thaw;
@@ -88,18 +89,22 @@ static int suspend_prepare(suspend_state
 	}
 
 	suspend_console();
-	if ((error = device_suspend(PMSG_SUSPEND))) {
+	error = device_suspend(PMSG_SUSPEND);
+	if (error) {
 		printk(KERN_ERR "Some devices failed to suspend\n");
-		goto Finish;
+		goto Resume_devices;
 	}
-	return 0;
- Finish:
-	if (pm_ops->finish)
-		pm_ops->finish(state);
+	error = disable_nonboot_cpus();
+	if (!error)
+		return 0;
+
+	enable_nonboot_cpus();
+ Resume_devices:
+	pm_finish(state);
+	device_resume();
+	resume_console();
  Thaw:
 	thaw_processes();
- Enable_cpu:
-	enable_nonboot_cpus();
 	pm_restore_console();
 	return error;
 }
@@ -134,12 +139,11 @@ int suspend_enter(suspend_state_t state)
 
 static void suspend_finish(suspend_state_t state)
 {
+	enable_nonboot_cpus();
+	pm_finish(state);
 	device_resume();
 	resume_console();
 	thaw_processes();
-	enable_nonboot_cpus();
-	if (pm_ops && pm_ops->finish)
-		pm_ops->finish(state);
 	pm_restore_console();
 }
 

