Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbVKTGrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbVKTGrf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 01:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbVKTGrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 01:47:14 -0500
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:43376 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750751AbVKTGrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 01:47:11 -0500
Message-Id: <20051120064419.796980000.dtor_core@ameritech.net>
References: <20051120063611.269343000.dtor_core@ameritech.net>
Date: Sun, 20 Nov 2005 01:36:15 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [git pull 04/14] Wistron - add support for Acer Aspire notebooks
Content-Disposition: inline; filename=wistron-buttons-acer-aspire-support.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bernhard Rosenkraenzer <bero@arklinux.org>

Input: wistron - add support for Acer Aspire 1500 notebooks

Also fix a potential issue with some notebooks:

The current code assumes the response to bios_wifi_get_default_setting is
either 1 (disabled) or 3 (enabled), or wifi isn't supported.  The BIOS
response appears to be a bit field w/ 0x1 indicating hardware presence, 0x2
indicating actiation status, and the other 6 bits being unknown/reserved --
with the patch, these 6 bits are ignored.

Signed-off-by: Bernhard Rosenkraenzer <bero@arklinux.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/misc/wistron_btns.c |   79 ++++++++++++++++++++++++++++----------
 1 files changed, 59 insertions(+), 20 deletions(-)

Index: work/drivers/input/misc/wistron_btns.c
===================================================================
--- work.orig/drivers/input/misc/wistron_btns.c
+++ work/drivers/input/misc/wistron_btns.c
@@ -1,6 +1,7 @@
 /*
  * Wistron laptop button driver
  * Copyright (C) 2005 Miloslav Trmac <mitr@volny.cz>
+ * Copyright (C) 2005 Bernhard Rosenkraenzer <bero@arklinux.org>
  *
  * You can redistribute and/or modify this program under the terms of the
  * GNU General Public License version 2 as published by the Free Software
@@ -40,6 +41,10 @@
 #error "POLL_FREQUENCY too high"
 #endif
 
+/* BIOS subsystem IDs */
+#define WIFI		0x35
+#define BLUETOOTH	0x34
+
 MODULE_AUTHOR("Miloslav Trmac <mitr@volny.cz>");
 MODULE_DESCRIPTION("Wistron laptop button driver");
 MODULE_LICENSE("GPL v2");
@@ -197,29 +202,29 @@ static u8 __init bios_get_cmos_address(v
 	return regs.ecx;
 }
 
-static u16 __init bios_wifi_get_default_setting(void)
+static u16 __init bios_get_default_setting(u8 subsys)
 {
 	struct regs regs;
 
 	memset(&regs, 0, sizeof (regs));
 	regs.eax = 0x9610;
-	regs.ebx = 0x0235;
+	regs.ebx = 0x0200 | subsys;
 	call_bios(&regs);
 
 	return regs.eax;
 }
 
-static void bios_wifi_set_state(int enable)
+static void bios_set_state(u8 subsys, int enable)
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
@@ -227,10 +232,11 @@ struct key_entry {
 	unsigned keycode;	/* For KE_KEY */
 };
 
-enum { KE_END, KE_KEY, KE_WIFI };
+enum { KE_END, KE_KEY, KE_WIFI, KE_BLUETOOTH };
 
 static const struct key_entry *keymap; /* = NULL; Current key map */
 static int have_wifi;
+static int have_bluetooth;
 
 static int __init dmi_matched(struct dmi_system_id *dmi)
 {
@@ -241,6 +247,9 @@ static int __init dmi_matched(struct dmi
 		if (key->type == KE_WIFI) {
 			have_wifi = 1;
 			break;
+		} else if (key->type == KE_BLUETOOTH) {
+			have_bluetooth = 1;
+			break;
 		}
 	}
 	return 1;
@@ -273,6 +282,16 @@ static struct key_entry keymap_wistron_m
 	{ KE_END,  0 }
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
 /*
  * If your machine is not here (which is currently rather likely), please send
  * a list of buttons and their key codes (reported when loading this module
@@ -288,6 +307,15 @@ static struct dmi_system_id dmi_ids[] = 
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
 
@@ -344,6 +372,7 @@ static void report_key(unsigned keycode)
  /* Driver core */
 
 static int wifi_enabled;
+static int bluetooth_enabled;
 
 static void poll_bios(unsigned long);
 
@@ -363,7 +392,14 @@ static void handle_key(u8 code)
 			case KE_WIFI:
 				if (have_wifi) {
 					wifi_enabled = !wifi_enabled;
-					bios_wifi_set_state(wifi_enabled);
+					bios_set_state(WIFI, wifi_enabled);
+				}
+				break;
+
+			case KE_BLUETOOTH:
+				if (have_bluetooth) {
+					bluetooth_enabled = !bluetooth_enabled;
+					bios_set_state(BLUETOOTH, bluetooth_enabled);
 				}
 				break;
 
@@ -407,21 +443,24 @@ static int __init wb_module_init(void)
 	bios_attach();
 	cmos_address = bios_get_cmos_address();
 	if (have_wifi) {
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
+		u16 wifi = bios_get_default_setting(WIFI);
+		if (wifi & 1)
+			wifi_enabled = (wifi & 2) ? 1 : 0;
+		else
 			have_wifi = 0;
-			break;
-		}
+
 		if (have_wifi)
-			bios_wifi_set_state(wifi_enabled);
+			bios_set_state(WIFI, wifi_enabled);
+	}
+	if (have_bluetooth) {
+		u16 bt = bios_get_default_setting(BLUETOOTH);
+		if (bt & 1)
+			bluetooth_enabled = (bt & 2) ? 1 : 0;
+		else
+			have_bluetooth = 0;
+
+		if (have_bluetooth)
+			bios_set_state(BLUETOOTH, bluetooth_enabled);
 	}
 
 	setup_input_dev();

