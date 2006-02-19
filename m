Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWBSW0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWBSW0c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 17:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWBSW0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 17:26:32 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:41867 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751103AbWBSW0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 17:26:31 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm] swsusp/pm: refuse to suspend devices if wrong console is active
Date: Sun, 19 Feb 2006 23:26:35 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602192326.37265.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1) Remove the console-switching code from the suspend part of the swsusp
userland interface and let the userland tools switch the console.

2) It is unsafe to suspend devices if the hardware is controlled by X.  Add
an extra check to prevent this from happening.


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@suse.cz>
---
 drivers/base/power/suspend.c |    9 +++++++++
 kernel/power/user.c          |    3 ---
 2 files changed, 9 insertions(+), 3 deletions(-)

Index: linux-2.6.16-rc3-mm1/kernel/power/user.c
===================================================================
--- linux-2.6.16-rc3-mm1.orig/kernel/power/user.c
+++ linux-2.6.16-rc3-mm1/kernel/power/user.c
@@ -138,12 +138,10 @@ static int snapshot_ioctl(struct inode *
 		if (data->frozen)
 			break;
 		down(&pm_sem);
-		pm_prepare_console();
 		disable_nonboot_cpus();
 		if (freeze_processes()) {
 			thaw_processes();
 			enable_nonboot_cpus();
-			pm_restore_console();
 			error = -EBUSY;
 		}
 		up(&pm_sem);
@@ -157,7 +155,6 @@ static int snapshot_ioctl(struct inode *
 		down(&pm_sem);
 		thaw_processes();
 		enable_nonboot_cpus();
-		pm_restore_console();
 		up(&pm_sem);
 		data->frozen = 0;
 		break;
Index: linux-2.6.16-rc3-mm1/drivers/base/power/suspend.c
===================================================================
--- linux-2.6.16-rc3-mm1.orig/drivers/base/power/suspend.c
+++ linux-2.6.16-rc3-mm1/drivers/base/power/suspend.c
@@ -8,6 +8,9 @@
  *
  */
 
+#include <linux/vt_kern.h>
+#include <linux/kbd_kern.h>
+#include <linux/console.h>
 #include <linux/device.h>
 #include "../base.h"
 #include "power.h"
@@ -82,6 +85,12 @@ int device_suspend(pm_message_t state)
 {
 	int error = 0;
 
+	/* It is unsafe to suspend devices while X has control of the
+	 * hardware. Make sure we are running on a kernel-controlled console.
+	 */
+	if (vc_cons[fg_console].d->vc_mode != KD_TEXT)
+		return -EINVAL;
+
 	down(&dpm_sem);
 	down(&dpm_list_sem);
 	while (!list_empty(&dpm_active) && error == 0) {
