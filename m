Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbVKTHG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbVKTHG0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 02:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbVKTHGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 02:06:01 -0500
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:10682 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750972AbVKTHF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 02:05:59 -0500
Message-Id: <20051120064420.028262000.dtor_core@ameritech.net>
References: <20051120063611.269343000.dtor_core@ameritech.net>
Date: Sun, 20 Nov 2005 01:36:17 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [git pull 06/14] Wistron - add PM support
Content-Disposition: inline; filename=wistron-platform-device.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: wistron - add PM support

Register wistron-bios as a platform device, restore WIFI and
Bluetooth state upon resume.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/misc/wistron_btns.c |   62 ++++++++++++++++++++++++++++++++++----
 1 files changed, 57 insertions(+), 5 deletions(-)

Index: work/drivers/input/misc/wistron_btns.c
===================================================================
--- work.orig/drivers/input/misc/wistron_btns.c
+++ work/drivers/input/misc/wistron_btns.c
@@ -2,6 +2,7 @@
  * Wistron laptop button driver
  * Copyright (C) 2005 Miloslav Trmac <mitr@volny.cz>
  * Copyright (C) 2005 Bernhard Rosenkraenzer <bero@arklinux.org>
+ * Copyright (C) 2005 Dmitry Torokhov <dtor@mail.ru>
  *
  * You can redistribute and/or modify this program under the terms of the
  * GNU General Public License version 2 as published by the Free Software
@@ -28,6 +29,7 @@
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/types.h>
+#include <linux/platform_device.h>
 
 /*
  * Number of attempts to read data from queue per poll;
@@ -58,6 +60,8 @@ static char *keymap_name; /* = NULL; */
 module_param_named(keymap, keymap_name, charp, 0);
 MODULE_PARM_DESC(keymap, "Keymap name, if it can't be autodetected");
 
+static struct platform_device *wistron_device;
+
  /* BIOS interface implementation */
 
 static void __iomem *bios_entry_point; /* BIOS routine entry point */
@@ -356,6 +360,7 @@ static int __init setup_input_dev(void)
 	input_dev->name = "Wistron laptop buttons";
 	input_dev->phys = "wistron/input0";
 	input_dev->id.bustype = BUS_HOST;
+	input_dev->cdev.dev = &wistron_device->dev;
 
 	for (key = keymap; key->type != KE_END; key++) {
 		if (key->type == KE_KEY) {
@@ -442,6 +447,34 @@ static void poll_bios(unsigned long disc
 	mod_timer(&poll_timer, jiffies + HZ / POLL_FREQUENCY);
 }
 
+static int wistron_suspend(struct platform_device *dev, pm_message_t state)
+{
+	del_timer_sync(&poll_timer);
+
+	return 0;
+}
+
+static int wistron_resume(struct platform_device *dev)
+{
+	if (have_wifi)
+		bios_set_state(WIFI, wifi_enabled);
+
+	if (have_bluetooth)
+		bios_set_state(BLUETOOTH, bluetooth_enabled);
+
+	poll_bios(1);
+
+	return 0;
+}
+
+static struct platform_driver wistron_driver = {
+	.suspend	= wistron_suspend,
+	.resume		= wistron_resume,
+	.driver		= {
+		.name	= "wistron-bios",
+	},
+};
+
 static int __init wb_module_init(void)
 {
 	int err;
@@ -457,6 +490,16 @@ static int __init wb_module_init(void)
 	bios_attach();
 	cmos_address = bios_get_cmos_address();
 
+	err = platform_driver_register(&wistron_driver);
+	if (err)
+		goto err_detach_bios;
+
+	wistron_device = platform_device_register_simple("wistron-bios", -1, NULL, 0);
+	if (IS_ERR(wistron_device)) {
+		err = PTR_ERR(wistron_device);
+		goto err_unregister_driver;
+	}
+
 	if (have_wifi) {
 		u16 wifi = bios_get_default_setting(WIFI);
 		if (wifi & 1)
@@ -480,21 +523,30 @@ static int __init wb_module_init(void)
 	}
 
 	err = setup_input_dev();
-	if (err) {
-		bios_detach();
-		unmap_bios();
-		return err;
-	}
+	if (err)
+		goto err_unregister_device;
 
 	poll_bios(1); /* Flush stale event queue and arm timer */
 
 	return 0;
+
+ err_unregister_device:
+	platform_device_unregister(wistron_device);
+ err_unregister_driver:
+	platform_driver_unregister(&wistron_driver);
+ err_detach_bios:
+	bios_detach();
+	unmap_bios();
+
+	return err;
 }
 
 static void __exit wb_module_exit(void)
 {
 	del_timer_sync(&poll_timer);
 	input_unregister_device(input_dev);
+	platform_device_unregister(wistron_device);
+	platform_driver_unregister(&wistron_driver);
 	bios_detach();
 	unmap_bios();
 }

