Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbVIYVfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbVIYVfg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 17:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbVIYVfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 17:35:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33226 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932301AbVIYVff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 17:35:35 -0400
Message-ID: <43371811.5020202@volny.cz>
Date: Sun, 25 Sep 2005 23:35:13 +0200
From: Miloslav Trmac <mitr@volny.cz>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vojtech@suse.cz
CC: linux-kernel@vger.kernel.org, dtor_core@ameritech.net
Subject: Re: [PATCH] Wistron laptop button driver
References: <431E4E28.5020604@volny.cz>
In-Reply-To: <431E4E28.5020604@volny.cz>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/mixed;
 boundary="------------040806000101090100010406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040806000101090100010406
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,
I'm not quite sure what has happened to the original patch, I hope it is
in someone's input tree.

Nevertheless, attached is a patch to add support for Thorsten's hardware.

Thanks,
	Mirek

--------------040806000101090100010406
Content-Type: text/x-patch;
 name="wistron_btns-ms2141.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wistron_btns-ms2141.patch"

Add buttons for AOpen/Wistron 1557/MS2141, as reported by Thorsten
Leemhuis.  The hardware has no usable DMI info, so add a module parameter.

Signed-off-by: Miloslav Trmac <mitr@volny.cz>

--- a/drivers/input/misc/wistron_btns.c	Tue Sep 20 11:08:45 2005
+++ b/drivers/input/misc/wistron_btns.c	Sun Sep 25 23:23:29 2005
@@ -44,6 +44,10 @@
 module_param(force, bool, 0);
 MODULE_PARM_DESC(force, "Load even if computer is not in database");
 
+static char *keymap_name; /* = NULL; */
+module_param_named(keymap, keymap_name, charp, 0);
+MODULE_PARM_DESC(keymap, "Keymap name, if it can't be autodetected");
+
  /* BIOS interface implementation */
 
 static void __iomem *bios_entry_point; /* BIOS routine entry point */
@@ -238,6 +242,19 @@
 	{ KE_END, 0 }
 };
 
+static struct key_entry keymap_wistron_ms2141[] = {
+	{ KE_KEY,  0x11, KEY_PROG1 },
+	{ KE_KEY,  0x12, KEY_PROG2 },
+	{ KE_WIFI, 0x30, 0 },
+	{ KE_KEY,  0x22, KEY_REWIND },
+	{ KE_KEY,  0x23, KEY_FORWARD },
+	{ KE_KEY,  0x24, KEY_PLAYPAUSE },
+	{ KE_KEY,  0x25, KEY_STOPCD },
+	{ KE_KEY,  0x31, KEY_MAIL },
+	{ KE_KEY,  0x36, KEY_WWW },
+	{ KE_END, 0 }
+};
+
 /* If your machine is not here (which is currently rather likely), please send
    a list of buttons and their key codes (reported when loading this module
    with force=1) and the output of dmidecode to $MODULE_AUTHOR. */
@@ -254,6 +271,27 @@
 	{ 0, }
 };
 
+static int __init select_keymap(void)
+{
+	if (keymap_name != NULL) {
+		if (strcmp (keymap_name, "1557/MS2141") == 0)
+			keymap = keymap_wistron_ms2141;
+		else {
+			printk(KERN_WARNING "wistron_btns: Keymap unknown\n");
+			return -EINVAL;
+		}
+	}
+	dmi_check_system(dmi_ids);
+	if (keymap == NULL) {
+		if (force == 0) {
+			printk(KERN_WARNING "wistron_btns: System unknown\n");
+			return -ENODEV;
+		}
+		keymap = keymap_empty;
+	}
+	return 0;
+}
+
  /* Input layer interface */
 
 static struct input_dev input_dev = {
@@ -337,14 +375,9 @@
 {
 	int err;
 
-	dmi_check_system(dmi_ids);
-	if (keymap == NULL) {
-		if (force == 0) {
-			printk(KERN_WARNING "wistron_btns: System unknown\n");
-			return -ENODEV;
-		}
-		keymap = keymap_empty;
-	}
+	err = select_keymap ();
+	if (err != 0)
+		return err;
 	err = map_bios();
 	if (err != 0)
 		return err;

--------------040806000101090100010406--
