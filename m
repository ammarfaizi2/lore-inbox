Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbUACJEg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 04:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbUACJEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 04:04:36 -0500
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:41823 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263101AbUACJEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 04:04:07 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 1/7] i8042 suspend
Date: Sat, 3 Jan 2004 03:56:45 -0500
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200401030350.43437.dtor_core@ameritech.net>
In-Reply-To: <200401030350.43437.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401030356.48071.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================


ChangeSet@1.1571, 2004-01-02 00:22:32-05:00, dtor_core@ameritech.net
  Input: Add suspend methods to restore original controller state
         on suspend as some BIOS don't like the state we leave it in.
         Also synchroniously delete the polling timer on module exit.


 i8042.c |   76 +++++++++++++++++++++++++++++++++++++++++++++-------------------
 1 files changed, 54 insertions(+), 22 deletions(-)


===================================================================



diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Sat Jan  3 03:07:29 2004
+++ b/drivers/input/serio/i8042.c	Sat Jan  3 03:07:29 2004
@@ -746,6 +746,29 @@
 
 
 /*
+ * Reset the controller.
+ */
+void i8042_controller_reset(void)
+{
+	if (i8042_reset) {
+		unsigned char param;
+
+		if (i8042_command(&param, I8042_CMD_CTL_TEST))
+			printk(KERN_ERR "i8042.c: i8042 controller reset timeout.\n");
+	}
+
+/*
+ * Restore the original control register setting.
+ */
+
+	i8042_ctr = i8042_initial_ctr;
+
+	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR))
+		printk(KERN_WARNING "i8042.c: Can't restore CTR.\n");
+}
+
+
+/*
  * Here we try to reset everything back to a state in which the BIOS will be
  * able to talk to the hardware when rebooting.
  */
@@ -770,26 +793,20 @@
 		if (i8042_mux_values[i].exists)
 			serio_cleanup(i8042_mux_port + i);
 
-/*
- * Reset the controller.
- */
-
-	if (i8042_reset) {
-		unsigned char param;
+	i8042_controller_reset();
+}
 
-		if (i8042_command(&param, I8042_CMD_CTL_TEST))
-			printk(KERN_ERR "i8042.c: i8042 controller reset timeout.\n");
-	}
 
 /*
- * Restore the original control register setting.
+ * Here we try to restore the original BIOS settings
  */
 
-	i8042_ctr = i8042_initial_ctr;
-
-	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR))
-		printk(KERN_WARNING "i8042.c: Can't restore CTR.\n");
+static int i8042_controller_suspend(void)
+{
+	del_timer_sync(&i8042_timer);
+	i8042_controller_reset();
 
+	return 0;
 }
 
 
@@ -809,7 +826,7 @@
 	if (i8042_mux_present)
 		if (i8042_enable_mux_mode(&i8042_aux_values, NULL) ||
 		    i8042_enable_mux_ports(&i8042_aux_values)) {
-			printk(KERN_WARNING "i8042: failed to resume active multiplexor, mouse won't wotk.\n");
+			printk(KERN_WARNING "i8042: failed to resume active multiplexor, mouse won't work.\n");
 		}
 
 /*
@@ -825,6 +842,10 @@
 	for (i = 0; i < 4; i++)
 		if (i8042_mux_values[i].exists && i8042_activate_port(i8042_mux_port + i) == 0)
 			serio_reconnect(i8042_mux_port + i);
+/*
+ * Restart timer (for polling "stuck" data)
+ */ 
+	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
 
 	return 0;
 }
@@ -851,16 +872,22 @@
 };
 
 /*
- * Resume handler for the new PM scheme (driver model)
+ * Suspend/resume handlers for the new PM scheme (driver model)
  */
+static int i8042_suspend(struct sys_device *dev, u32 state)
+{
+	return i8042_controller_suspend();
+}
+
 static int i8042_resume(struct sys_device *dev)
 {
 	return i8042_controller_resume();
 }
 
 static struct sysdev_class kbc_sysclass = {
-       set_kset_name("i8042"),
-       .resume = i8042_resume,
+	set_kset_name("i8042"),
+	.suspend = i8042_suspend,
+	.resume = i8042_resume,
 };
 
 static struct sys_device device_i8042 = {
@@ -869,12 +896,17 @@
 };
 
 /*
- * Resume handler for the old PM scheme (APM)
+ * Suspend/resume handler for the old PM scheme (APM)
  */
 static int i8042_pm_callback(struct pm_dev *dev, pm_request_t request, void *dummy)
 {
-	if (request == PM_RESUME)
-		return i8042_controller_resume();
+	switch (request) {
+		case PM_SUSPEND:
+			return i8042_controller_suspend();
+
+		case PM_RESUME:
+			return i8042_controller_resume();
+	}
 
 	return 0;
 }
@@ -955,7 +987,7 @@
 		sysdev_class_unregister(&kbc_sysclass);
 	}
 
-	del_timer(&i8042_timer);
+	del_timer_sync(&i8042_timer);
 
 	i8042_controller_cleanup();
 	
