Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWCSLVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWCSLVK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 06:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbWCSLUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 06:20:48 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:44766 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751486AbWCSLUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 06:20:47 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 2/3] pm: check console before suspending devices
Date: Sun, 19 Mar 2006 12:05:31 +0100
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
References: <200603191158.26275.rjw@sisk.pl>
In-Reply-To: <200603191158.26275.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200603191205.32346.rjw@sisk.pl>
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Rafael J. Wysocki" <rjw@sisk.pl>

It is unsafe to suspend devices if the hardware is controlled by X. 
Add an extra check to prevent this from happening.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/suspend.c |    5 ++++-
 drivers/char/vt.c            |    8 ++++++++
 include/linux/vt_kern.h      |    5 +++++
 3 files changed, 17 insertions(+), 1 deletion(-)

Index: linux-2.6.16-rc6-mm2/drivers/base/power/suspend.c
===================================================================
--- linux-2.6.16-rc6-mm2.orig/drivers/base/power/suspend.c
+++ linux-2.6.16-rc6-mm2/drivers/base/power/suspend.c
@@ -8,6 +8,7 @@
  *
  */
 
+#include <linux/vt_kern.h>
 #include <linux/device.h>
 #include <linux/kallsyms.h>
 #include <linux/pm.h>
@@ -65,7 +66,6 @@ int suspend_device(struct device * dev, 
 	return error;
 }
 
-
 /**
  *	device_suspend - Save state and stop all devices in system.
  *	@state:		Power state to put each device in.
@@ -85,6 +85,9 @@ int device_suspend(pm_message_t state)
 {
 	int error = 0;
 
+	if (!is_console_suspend_safe())
+		return -EINVAL;
+
 	down(&dpm_sem);
 	down(&dpm_list_sem);
 	while (!list_empty(&dpm_active) && error == 0) {
Index: linux-2.6.16-rc6-mm2/drivers/char/vt.c
===================================================================
--- linux-2.6.16-rc6-mm2.orig/drivers/char/vt.c
+++ linux-2.6.16-rc6-mm2/drivers/char/vt.c
@@ -3234,6 +3234,14 @@ void vcs_scr_writew(struct vc_data *vc, 
 	}
 }
 
+/* It is unsafe to suspend devices while X has control of the
+ * hardware. Check if we are running on a kernel-controlled console.
+ */
+int is_console_suspend_safe(void)
+{
+	return vc_cons[fg_console].d->vc_mode == KD_TEXT;
+}
+
 /*
  *	Visible symbols for modules
  */
Index: linux-2.6.16-rc6-mm2/include/linux/vt_kern.h
===================================================================
--- linux-2.6.16-rc6-mm2.orig/include/linux/vt_kern.h
+++ linux-2.6.16-rc6-mm2/include/linux/vt_kern.h
@@ -73,6 +73,11 @@ int con_copy_unimap(struct vc_data *dst_
 int vt_waitactive(int vt);
 void change_console(struct vc_data *new_vc);
 void reset_vc(struct vc_data *vc);
+#ifdef CONFIG_VT
+int is_console_suspend_safe(void);
+#else
+static inline int is_console_suspend_safe(void) { return 1; }
+#endif
 
 /*
  * vc_screen.c shares this temporary buffer with the console write code so that

