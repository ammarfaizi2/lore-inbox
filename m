Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264685AbUF1FfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264685AbUF1FfF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 01:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264692AbUF1FcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 01:32:18 -0400
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:42634 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264685AbUF1FUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 01:20:02 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 12/19] convert i8042 into a platform device
Date: Mon, 28 Jun 2004 00:19:58 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200406280008.21465.dtor_core@ameritech.net> <200406280017.56654.dtor_core@ameritech.net> <200406280019.04030.dtor_core@ameritech.net>
In-Reply-To: <200406280019.04030.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406280020.01085.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1786, 2004-06-27 15:58:25-05:00, dtor_core@ameritech.net
  Input: make i8042 a platform device instead of system device so
         its serio ports have proper parent
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 i8042.c |   60 ++++++++++++++++++++++++++++++++++--------------------------
 1 files changed, 34 insertions(+), 26 deletions(-)


===================================================================



diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	2004-06-27 17:50:42 -05:00
+++ b/drivers/input/serio/i8042.c	2004-06-27 17:50:42 -05:00
@@ -21,6 +21,7 @@
 #include <linux/sysdev.h>
 #include <linux/pm.h>
 #include <linux/serio.h>
+#include <linux/err.h>
 
 #include <asm/io.h>
 
@@ -101,9 +102,9 @@
 static unsigned char i8042_ctr;
 static unsigned char i8042_mux_open;
 static unsigned char i8042_mux_present;
-static unsigned char i8042_sysdev_initialized;
 static struct pm_dev *i8042_pm_dev;
 static struct timer_list i8042_timer;
+static struct platform_device *i8042_platform_device;
 
 /*
  * Shared IRQ's require a device pointer, but this driver doesn't support
@@ -855,7 +856,7 @@
         return NOTIFY_DONE;
 }
 
-static struct notifier_block i8042_notifier=
+static struct notifier_block i8042_notifier =
 {
         i8042_notify_sys,
         NULL,
@@ -865,25 +866,27 @@
 /*
  * Suspend/resume handlers for the new PM scheme (driver model)
  */
-static int i8042_suspend(struct sys_device *dev, u32 state)
+static int i8042_suspend(struct device *dev, u32 state, u32 level)
 {
-	return i8042_controller_suspend();
+	return level == SUSPEND_DISABLE ? i8042_controller_suspend() : 0;
 }
 
-static int i8042_resume(struct sys_device *dev)
+static int i8042_resume(struct device *dev, u32 level)
 {
-	return i8042_controller_resume();
+	return level == RESUME_ENABLE ? i8042_controller_resume() : 0;
 }
 
-static struct sysdev_class kbc_sysclass = {
-	set_kset_name("i8042"),
-	.suspend = i8042_suspend,
-	.resume = i8042_resume,
-};
+static void i8042_shutdown(struct device *dev)
+{
+	i8042_controller_cleanup();
+}
 
-static struct sys_device device_i8042 = {
-       .id     = 0,
-       .cls    = &kbc_sysclass,
+static struct device_driver i8042_driver = {
+	.name		= "i8042",
+	.bus		= &platform_bus_type,
+	.suspend	= i8042_suspend,
+	.resume		= i8042_resume,
+	.shutdown	= i8042_shutdown,
 };
 
 /*
@@ -914,6 +917,7 @@
 		serio->open		= i8042_open,
 		serio->close		= i8042_close,
 		serio->port_data	= &i8042_kbd_values,
+		serio->dev.parent	= &i8042_platform_device->dev;
 		strlcpy(serio->name, "i8042 Kbd Port", sizeof(serio->name));
 		strlcpy(serio->phys, I8042_KBD_PHYS_DESC, sizeof(serio->phys));
 	}
@@ -933,6 +937,7 @@
 		serio->open		= i8042_open;
 		serio->close		= i8042_close;
 		serio->port_data	= &i8042_aux_values,
+		serio->dev.parent	= &i8042_platform_device->dev;
 		strlcpy(serio->name, "i8042 Aux Port", sizeof(serio->name));
 		strlcpy(serio->phys, I8042_AUX_PHYS_DESC, sizeof(serio->phys));
 	}
@@ -957,6 +962,7 @@
 		serio->open		= i8042_open;
 		serio->close		= i8042_close;
 		serio->port_data	= values;
+		serio->dev.parent	= &i8042_platform_device->dev;
 		snprintf(serio->name, sizeof(serio->name), "i8042 Aux-%d Port", index);
 		snprintf(serio->phys, sizeof(serio->phys), I8042_MUX_PHYS_DESC, index + 1);
 	}
@@ -967,6 +973,7 @@
 int __init i8042_init(void)
 {
 	int i;
+	int err;
 
 	dbg_init();
 
@@ -989,6 +996,16 @@
 	}
 #endif
 
+	err = driver_register(&i8042_driver);
+	if (err)
+		return err;
+
+	i8042_platform_device = platform_device_register_simple("i8042", -1, NULL, 0);
+	if (IS_ERR(i8042_platform_device)) {
+		driver_unregister(&i8042_driver);
+		return PTR_ERR(i8042_platform_device);
+	}
+
 	if (!i8042_noaux && !i8042_check_aux(&i8042_aux_values)) {
 		if (!i8042_nomux && !i8042_check_mux(&i8042_aux_values))
 			for (i = 0; i < I8042_NUM_MUX_PORTS; i++) {
@@ -1009,13 +1026,6 @@
 
 	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
 
-        if (sysdev_class_register(&kbc_sysclass) == 0) {
-                if (sysdev_register(&device_i8042) == 0)
-			i8042_sysdev_initialized = 1;
-		else
-			sysdev_class_unregister(&kbc_sysclass);
-        }
-
 	i8042_pm_dev = pm_register(PM_SYS_DEV, PM_SYS_UNKNOWN, i8042_pm_callback);
 
 	register_reboot_notifier(&i8042_notifier);
@@ -1032,11 +1042,6 @@
 	if (i8042_pm_dev)
 		pm_unregister(i8042_pm_dev);
 
-	if (i8042_sysdev_initialized) {
-		sysdev_unregister(&device_i8042);
-		sysdev_class_unregister(&kbc_sysclass);
-	}
-
 	i8042_controller_cleanup();
 
 	if (i8042_kbd_values.exists)
@@ -1050,6 +1055,9 @@
 			serio_unregister_port(i8042_mux_port[i]);
 
 	del_timer_sync(&i8042_timer);
+
+	platform_device_unregister(i8042_platform_device);
+	driver_unregister(&i8042_driver);
 
 	i8042_platform_exit();
 }
