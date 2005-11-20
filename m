Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbVKTHGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbVKTHGY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 02:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbVKTHGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 02:06:00 -0500
Received: from smtp103.sbc.mail.re2.yahoo.com ([68.142.229.102]:33694 "HELO
	smtp103.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750861AbVKTHF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 02:05:59 -0500
Message-Id: <20051120064419.913647000.dtor_core@ameritech.net>
References: <20051120063611.269343000.dtor_core@ameritech.net>
Date: Sun, 20 Nov 2005 01:36:16 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [git pull 05/14] Wistron - convert to dynamic input_dev allocation
Content-Disposition: inline; filename=input-dynalloc-wistron.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: wistron - convert to dynamic input_dev allocation

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/misc/wistron_btns.c |   53 ++++++++++++++++++++++++++------------
 1 files changed, 37 insertions(+), 16 deletions(-)

Index: work/drivers/input/misc/wistron_btns.c
===================================================================
--- work.orig/drivers/input/misc/wistron_btns.c
+++ work/drivers/input/misc/wistron_btns.c
@@ -149,7 +149,7 @@ err:
 	return -ENOMEM;
 }
 
-static void __exit unmap_bios(void)
+static inline void unmap_bios(void)
 {
 	iounmap(bios_code_map_base);
 	iounmap(bios_data_map_base);
@@ -180,7 +180,7 @@ static void __init bios_attach(void)
 	call_bios(&regs);
 }
 
-static void __exit bios_detach(void)
+static void bios_detach(void)
 {
 	struct regs regs;
 
@@ -342,31 +342,43 @@ static int __init select_keymap(void)
 
  /* Input layer interface */
 
-static struct input_dev input_dev = {
-	.name = "Wistron laptop buttons",
-};
+static struct input_dev *input_dev;
 
-static void __init setup_input_dev(void)
+static int __init setup_input_dev(void)
 {
 	const struct key_entry *key;
+	int error;
+
+	input_dev = input_allocate_device();
+	if (!input_dev)
+		return -ENOMEM;
+
+	input_dev->name = "Wistron laptop buttons";
+	input_dev->phys = "wistron/input0";
+	input_dev->id.bustype = BUS_HOST;
 
 	for (key = keymap; key->type != KE_END; key++) {
 		if (key->type == KE_KEY) {
-			input_dev.evbit[LONG(EV_KEY)] = BIT(EV_KEY);
-			input_dev.keybit[LONG(key->keycode)]
-				|= BIT(key->keycode);
+			input_dev->evbit[LONG(EV_KEY)] = BIT(EV_KEY);
+			set_bit(key->keycode, input_dev->keybit);
 		}
 	}
 
-	input_register_device(&input_dev);
+	error = input_register_device(input_dev);
+	if (error) {
+		input_free_device(input_dev);
+		return error;
+	}
+
+	return 0;
 }
 
 static void report_key(unsigned keycode)
 {
-	input_report_key(&input_dev, keycode, 1);
-	input_sync(&input_dev);
-	input_report_key(&input_dev, keycode, 0);
-	input_sync(&input_dev);
+	input_report_key(input_dev, keycode, 1);
+	input_sync(input_dev);
+	input_report_key(input_dev, keycode, 0);
+	input_sync(input_dev);
 }
 
  /* Driver core */
@@ -437,11 +449,14 @@ static int __init wb_module_init(void)
 	err = select_keymap();
 	if (err)
 		return err;
+
 	err = map_bios();
 	if (err)
 		return err;
+
 	bios_attach();
 	cmos_address = bios_get_cmos_address();
+
 	if (have_wifi) {
 		u16 wifi = bios_get_default_setting(WIFI);
 		if (wifi & 1)
@@ -452,6 +467,7 @@ static int __init wb_module_init(void)
 		if (have_wifi)
 			bios_set_state(WIFI, wifi_enabled);
 	}
+
 	if (have_bluetooth) {
 		u16 bt = bios_get_default_setting(BLUETOOTH);
 		if (bt & 1)
@@ -463,7 +479,12 @@ static int __init wb_module_init(void)
 			bios_set_state(BLUETOOTH, bluetooth_enabled);
 	}
 
-	setup_input_dev();
+	err = setup_input_dev();
+	if (err) {
+		bios_detach();
+		unmap_bios();
+		return err;
+	}
 
 	poll_bios(1); /* Flush stale event queue and arm timer */
 
@@ -473,7 +494,7 @@ static int __init wb_module_init(void)
 static void __exit wb_module_exit(void)
 {
 	del_timer_sync(&poll_timer);
-	input_unregister_device(&input_dev);
+	input_unregister_device(input_dev);
 	bios_detach();
 	unmap_bios();
 }

