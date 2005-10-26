Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbVJZPoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbVJZPoz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 11:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbVJZPoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 11:44:55 -0400
Received: from build.arklinux.osuosl.org ([140.211.166.26]:21156 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S964789AbVJZPoy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 11:44:54 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: mitr@volny.cz, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.14-rc5-mm1 wistron_btns Acer Aspire support + some fixes
Date: Wed, 26 Oct 2005 17:43:50 +0200
User-Agent: KMail/1.8.92
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510261743.50590.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
the patch below adds Acer Aspire 1500 support to wistron_btns and fixes a 
potential issue with some notebooks:
The current code assumes the response to bios_wifi_get_default_setting is 
either 1 (disabled) or 3 (enabled), or wifi isn't supported.
The BIOS response appears to be a bit field w/ 0x1 indicating hardware 
presence, 0x2 indicating actiation status, and the other 6 bits being 
unknown/reserved -- with the patch, these 6 bits are ignored.

Signed-off-by: Bernhard Rosenkraenzer <bero@arklinux.org>
---
--- linux-2.6.13/drivers/input/misc/wistron_btns.c.acer~	2005-10-26 
11:11:38.000000000 +0200
+++ linux-2.6.13/drivers/input/misc/wistron_btns.c	2005-10-26 
11:36:32.000000000 +0200
@@ -1,5 +1,6 @@
 /* Wistron laptop button driver
    Copyright (C) 2005 Miloslav Trmac <mitr@volny.cz>
+   Copyright (C) 2005 Bernhard Rosenkraenzer <bero@arklinux.org>
 
    You can redistribute and/or modify this program under the terms of the
    GNU General Public License version 2 as published by the Free Software
@@ -35,6 +36,10 @@
 #error "POLL_FREQUENCY too high"
 #endif
 
+/* BIOS subsystem IDs */
+#define WIFI	0x35
+#define BLUETOOTH	0x34
+
 MODULE_AUTHOR("Miloslav Trmac <mitr@volny.cz>");
 MODULE_DESCRIPTION("Wistron laptop button driver");
 MODULE_LICENSE("GPL v2");
@@ -179,28 +184,28 @@
 	return (uint8_t)regs.ecx;
 }
 
-static uint16_t __init bios_wifi_get_default_setting(void)
+static uint16_t __init bios_get_default_setting(uint8_t subsys)
 {
 	struct regs regs;
 
 	memset(&regs, 0, sizeof (regs));
 	regs.eax = 0x9610;
-	regs.ebx = 0x0235;
+	regs.ebx = 0x0200 | subsys;
 	call_bios(&regs);
 	return (uint16_t)regs.eax;
 }
 
-static void bios_wifi_set_state(int enable)
+static void bios_set_state(uint8_t subsys, int enable)
 {
 	struct regs regs;
 
 	memset(&regs, 0, sizeof (regs));
 	regs.eax = 0x9610;
-	regs.ebx = enable ? 0x0135 : 0x0035;
+	regs.ebx = (enable ? 0x0100 : 0x0000) | subsys;
 	call_bios(&regs);
 }
 
- /* Hardware database */
+/* Hardware database */
 
 struct key_entry {
 	char type;		/* See KE_* below */
@@ -208,10 +213,11 @@
 	unsigned keycode;	/* For KE_KEY */
 };
 
-enum { KE_END, KE_KEY, KE_WIFI };
+enum { KE_END, KE_KEY, KE_WIFI, KE_BLUETOOTH };
 
 static const struct key_entry *keymap; /* = NULL; Current key map */
 static int have_wifi;
+static int have_bluetooth;
 
 static int __init dmi_matched(struct dmi_system_id *dmi)
 {
@@ -222,6 +228,9 @@
 		if (key->type == KE_WIFI) {
 			have_wifi = 1;
 			break;
+		} else if(key->type == KE_BLUETOOTH) {
+			have_bluetooth = 1;
+			break;
 		}
 	}
 	return 1;
@@ -254,6 +263,16 @@
 	{ KE_END, 0 }
 };
 
+static struct key_entry keymap_acer_aspire_1500[] = {
+	{ KE_KEY, 0x11, KEY_PROG1 },
+	{ KE_KEY, 0x12, KEY_PROG2 },
+	{ KE_WIFI, 0x30, 0 },
+	{ KE_KEY, 0x31, KEY_MAIL },
+	{ KE_KEY, 0x36, KEY_WWW },
+	{ KE_BLUETOOTH, 0x44, 0 },
+	{ KE_END, 0 }
+};
+
 /* If your machine is not here (which is currently rather likely), please 
send
    a list of buttons and their key codes (reported when loading this module
    with force=1) and the output of dmidecode to $MODULE_AUTHOR. */
@@ -267,6 +286,15 @@
 		},
 		.driver_data = keymap_fs_amilo_pro_v2000
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "Acer Aspire 1500",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 1500"),
+		},
+		.driver_data = keymap_acer_aspire_1500
+	},
 	{ 0, }
 };
 
@@ -321,6 +349,7 @@
  /* Driver core */
 
 static int wifi_enabled;
+static int bluetooth_enabled;
 
 static void poll_bios(unsigned long);
 
@@ -341,7 +370,14 @@
 				if (have_wifi == 0)
 					break;
 				wifi_enabled = !wifi_enabled;
-				bios_wifi_set_state(wifi_enabled);
+				bios_set_state(WIFI, wifi_enabled);
+				break;
+
+			case KE_BLUETOOTH:
+				if (have_bluetooth == 0)
+					break;
+				bluetooth_enabled = !bluetooth_enabled;
+				bios_set_state(BLUETOOTH, bluetooth_enabled);
 				break;
 
 			case KE_END: default:
@@ -383,21 +419,23 @@
 	bios_attach();
 	cmos_address = bios_get_cmos_address();
 	if (have_wifi != 0) {
-		switch (bios_wifi_get_default_setting()) {
-		case 0x01:
-			wifi_enabled = 0;
-			break;
-
-		case 0x03:
-			wifi_enabled = 1;
-			break;
-
-		default:
-			have_wifi = 0;
-			break;
-		}
+		uint16_t wifi = bios_get_default_setting(WIFI);
+		if (wifi & 1)
+			wifi_enabled = (wifi & 2) ? 1 : 0;
+		else
+			have_wifi=0;
 		if (have_wifi != 0)
-			bios_wifi_set_state(wifi_enabled);
+			bios_set_state(WIFI, wifi_enabled);
+	}
+	if (have_bluetooth != 0) {
+		uint16_t bt = bios_get_default_setting(BLUETOOTH);
+		if (bt & 1)
+			bluetooth_enabled = (bt & 2) ? 1 : 0;
+		else
+			have_bluetooth = 0;
+
+		if (have_bluetooth)
+			bios_set_state(BLUETOOTH, bluetooth_enabled);
 	}
 	setup_input_dev();
 	input_register_device(&input_dev);
