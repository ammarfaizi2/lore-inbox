Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030558AbWAGTNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030558AbWAGTNH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030548AbWAGTMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:12:43 -0500
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:62063 "HELO
	smtp106.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030559AbWAGTIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:08:23 -0500
Message-Id: <20060107172101.864646000.dtor_core@ameritech.net>
References: <20060107171559.593824000.dtor_core@ameritech.net>
Date: Sat, 07 Jan 2006 12:16:19 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 20/24] Wistron: switch to the new platform device interface
Content-Disposition: inline; filename=wistron-new-platform-code.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: wistron - convert to the new platform device interface

Do not use platform_device_register_simple() as it is going away,
implement ->probe() and ->remove() functions so manual binding and
unbinding would work.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/misc/wistron_btns.c |  114 ++++++++++++++++++++++----------------
 1 files changed, 68 insertions(+), 46 deletions(-)

Index: work/drivers/input/misc/wistron_btns.c
===================================================================
--- work.orig/drivers/input/misc/wistron_btns.c
+++ work/drivers/input/misc/wistron_btns.c
@@ -174,7 +174,7 @@ static u16 bios_pop_queue(void)
 	return regs.eax;
 }
 
-static void __init bios_attach(void)
+static void __devinit bios_attach(void)
 {
 	struct regs regs;
 
@@ -194,7 +194,7 @@ static void bios_detach(void)
 	call_bios(&regs);
 }
 
-static u8 __init bios_get_cmos_address(void)
+static u8 __devinit bios_get_cmos_address(void)
 {
 	struct regs regs;
 
@@ -206,7 +206,7 @@ static u8 __init bios_get_cmos_address(v
 	return regs.ecx;
 }
 
-static u16 __init bios_get_default_setting(u8 subsys)
+static u16 __devinit bios_get_default_setting(u8 subsys)
 {
 	struct regs regs;
 
@@ -367,7 +367,7 @@ static int __init select_keymap(void)
 
 static struct input_dev *input_dev;
 
-static int __init setup_input_dev(void)
+static int __devinit setup_input_dev(void)
 {
 	const struct key_entry *key;
 	int error;
@@ -466,6 +466,52 @@ static void poll_bios(unsigned long disc
 	mod_timer(&poll_timer, jiffies + HZ / POLL_FREQUENCY);
 }
 
+static int __devinit wistron_probe(struct platform_device *dev)
+{
+	int err = setup_input_dev();
+	if (err)
+		return err;
+
+	bios_attach();
+	cmos_address = bios_get_cmos_address();
+
+	if (have_wifi) {
+		u16 wifi = bios_get_default_setting(WIFI);
+		if (wifi & 1)
+			wifi_enabled = (wifi & 2) ? 1 : 0;
+		else
+			have_wifi = 0;
+
+		if (have_wifi)
+			bios_set_state(WIFI, wifi_enabled);
+	}
+
+	if (have_bluetooth) {
+		u16 bt = bios_get_default_setting(BLUETOOTH);
+		if (bt & 1)
+			bluetooth_enabled = (bt & 2) ? 1 : 0;
+		else
+			have_bluetooth = 0;
+
+		if (have_bluetooth)
+			bios_set_state(BLUETOOTH, bluetooth_enabled);
+	}
+
+	poll_bios(1); /* Flush stale event queue and arm timer */
+
+	return 0;
+}
+
+static int __devexit wistron_remove(struct platform_device *dev)
+{
+	del_timer_sync(&poll_timer);
+	input_unregister_device(input_dev);
+	bios_detach();
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
 static int wistron_suspend(struct platform_device *dev, pm_message_t state)
 {
 	del_timer_sync(&poll_timer);
@@ -491,13 +537,20 @@ static int wistron_resume(struct platfor
 
 	return 0;
 }
+#else
+#define wistron_suspend		NULL
+#define wistron_resume		NULL
+#endif
 
 static struct platform_driver wistron_driver = {
-	.suspend	= wistron_suspend,
-	.resume		= wistron_resume,
 	.driver		= {
 		.name	= "wistron-bios",
+		.owner	= THIS_MODULE,
 	},
+	.probe		= wistron_probe,
+	.remove		= __devexit_p(wistron_remove),
+	.suspend	= wistron_suspend,
+	.resume		= wistron_resume,
 };
 
 static int __init wb_module_init(void)
@@ -512,55 +565,27 @@ static int __init wb_module_init(void)
 	if (err)
 		return err;
 
-	bios_attach();
-	cmos_address = bios_get_cmos_address();
-
 	err = platform_driver_register(&wistron_driver);
 	if (err)
-		goto err_detach_bios;
+		goto err_unmap_bios;
 
-	wistron_device = platform_device_register_simple("wistron-bios", -1, NULL, 0);
-	if (IS_ERR(wistron_device)) {
-		err = PTR_ERR(wistron_device);
+	wistron_device = platform_device_alloc("wistron-bios", -1);
+	if (!wistron_device) {
+		err = -ENOMEM;
 		goto err_unregister_driver;
 	}
 
-	if (have_wifi) {
-		u16 wifi = bios_get_default_setting(WIFI);
-		if (wifi & 1)
-			wifi_enabled = (wifi & 2) ? 1 : 0;
-		else
-			have_wifi = 0;
-
-		if (have_wifi)
-			bios_set_state(WIFI, wifi_enabled);
-	}
-
-	if (have_bluetooth) {
-		u16 bt = bios_get_default_setting(BLUETOOTH);
-		if (bt & 1)
-			bluetooth_enabled = (bt & 2) ? 1 : 0;
-		else
-			have_bluetooth = 0;
-
-		if (have_bluetooth)
-			bios_set_state(BLUETOOTH, bluetooth_enabled);
-	}
-
-	err = setup_input_dev();
+	err = platform_device_add(wistron_device);
 	if (err)
-		goto err_unregister_device;
-
-	poll_bios(1); /* Flush stale event queue and arm timer */
+		goto err_free_device;
 
 	return 0;
 
- err_unregister_device:
-	platform_device_unregister(wistron_device);
+ err_free_device:
+	platform_device_put(wistron_device);
  err_unregister_driver:
 	platform_driver_unregister(&wistron_driver);
- err_detach_bios:
-	bios_detach();
+ err_unmap_bios:
 	unmap_bios();
 
 	return err;
@@ -568,11 +593,8 @@ static int __init wb_module_init(void)
 
 static void __exit wb_module_exit(void)
 {
-	del_timer_sync(&poll_timer);
-	input_unregister_device(input_dev);
 	platform_device_unregister(wistron_device);
 	platform_driver_unregister(&wistron_driver);
-	bios_detach();
 	unmap_bios();
 }
 

