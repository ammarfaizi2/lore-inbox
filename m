Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269192AbUJUHrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269192AbUJUHrx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 03:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270333AbUJUHj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 03:39:26 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:52379 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S270399AbUJUHaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 03:30:14 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 5/7] Input: i8042 remove old-style PM handling
Date: Thu, 21 Oct 2004 02:28:55 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200410210223.45498.dtor_core@ameritech.net> <200410210226.12239.dtor_core@ameritech.net> <200410210228.03038.dtor_core@ameritech.net>
In-Reply-To: <200410210228.03038.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410210228.57067.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1968, 2004-10-20 00:40:19-05:00, dtor_core@ameritech.net
  Input: i8042 - get rid of old-style power management handler since
         AMP calls both pm_send and device_suspend.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 i8042.c |   89 +++++++++++++++++++++-------------------------------------------
 1 files changed, 30 insertions(+), 59 deletions(-)


===================================================================



diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	2004-10-21 02:13:12 -05:00
+++ b/drivers/input/serio/i8042.c	2004-10-21 02:13:12 -05:00
@@ -113,7 +113,6 @@
 static unsigned char i8042_ctr;
 static unsigned char i8042_mux_open;
 static unsigned char i8042_mux_present;
-static struct pm_dev *i8042_pm_dev;
 static struct timer_list i8042_timer;
 static struct platform_device *i8042_platform_device;
 
@@ -826,13 +825,36 @@
 
 
 /*
+ * We need to reset the 8042 back to original mode on system shutdown,
+ * because otherwise BIOSes will be confused.
+ */
+
+static int i8042_notify_sys(struct notifier_block *this, unsigned long code,
+        		    void *unused)
+{
+        if (code == SYS_DOWN || code == SYS_HALT)
+        	i8042_controller_cleanup();
+        return NOTIFY_DONE;
+}
+
+static struct notifier_block i8042_notifier =
+{
+        i8042_notify_sys,
+        NULL,
+        0
+};
+
+
+/*
  * Here we try to restore the original BIOS settings
  */
 
-static int i8042_controller_suspend(void)
+static int i8042_suspend(struct device *dev, u32 state, u32 level)
 {
-	del_timer_sync(&i8042_timer);
-	i8042_controller_reset();
+	if (level == SUSPEND_DISABLE) {
+		del_timer_sync(&i8042_timer);
+		i8042_controller_reset();
+	}
 
 	return 0;
 }
@@ -842,10 +864,13 @@
  * Here we try to reset everything back to a state in which suspended
  */
 
-static int i8042_controller_resume(void)
+static int i8042_resume(struct device *dev, u32 level)
 {
 	int i;
 
+	if (level != RESUME_ENABLE)
+		return 0;
+
 	if (i8042_controller_init()) {
 		printk(KERN_ERR "i8042: resume failed\n");
 		return -1;
@@ -876,40 +901,7 @@
 	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
 
 	return 0;
-}
-
-
-/*
- * We need to reset the 8042 back to original mode on system shutdown,
- * because otherwise BIOSes will be confused.
- */
 
-static int i8042_notify_sys(struct notifier_block *this, unsigned long code,
-        		    void *unused)
-{
-        if (code == SYS_DOWN || code == SYS_HALT)
-        	i8042_controller_cleanup();
-        return NOTIFY_DONE;
-}
-
-static struct notifier_block i8042_notifier =
-{
-        i8042_notify_sys,
-        NULL,
-        0
-};
-
-/*
- * Suspend/resume handlers for the new PM scheme (driver model)
- */
-static int i8042_suspend(struct device *dev, u32 state, u32 level)
-{
-	return level == SUSPEND_DISABLE ? i8042_controller_suspend() : 0;
-}
-
-static int i8042_resume(struct device *dev, u32 level)
-{
-	return level == RESUME_ENABLE ? i8042_controller_resume() : 0;
 }
 
 static void i8042_shutdown(struct device *dev)
@@ -925,22 +917,6 @@
 	.shutdown	= i8042_shutdown,
 };
 
-/*
- * Suspend/resume handler for the old PM scheme (APM)
- */
-static int i8042_pm_callback(struct pm_dev *dev, pm_request_t request, void *dummy)
-{
-	switch (request) {
-		case PM_SUSPEND:
-			return i8042_controller_suspend();
-
-		case PM_RESUME:
-			return i8042_controller_resume();
-	}
-
-	return 0;
-}
-
 static struct serio * __init i8042_allocate_kbd_port(void)
 {
 	struct serio *serio;
@@ -1055,8 +1031,6 @@
 
 	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
 
-	i8042_pm_dev = pm_register(PM_SYS_DEV, PM_SYS_UNKNOWN, i8042_pm_callback);
-
 	register_reboot_notifier(&i8042_notifier);
 
 	return 0;
@@ -1067,9 +1041,6 @@
 	int i;
 
 	unregister_reboot_notifier(&i8042_notifier);
-
-	if (i8042_pm_dev)
-		pm_unregister(i8042_pm_dev);
 
 	i8042_controller_cleanup();
 
