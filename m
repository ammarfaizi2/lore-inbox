Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbUJaVpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbUJaVpb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 16:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbUJaVoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 16:44:38 -0500
Received: from gprs214-91.eurotel.cz ([160.218.214.91]:27269 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261664AbUJaVjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 16:39:15 -0500
Date: Sun, 31 Oct 2004 22:38:59 +0100
From: Pavel Machek <pavel@suse.cz>
To: vojtech@suse.cz, kernel list <linux-kernel@vger.kernel.org>
Subject: Map extra keys on compaq evo
Message-ID: <20041031213859.GA6742@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Compaq Evo notebooks seem to use non-standard keycodes for their extra
keys. I workaround that quirk with dmi hook.

I think that number of such workarounds neccessary should be
reasonably small (like one for each manufacturer), and therefore this
would be good thing...
								Pavel

--- clean/drivers/input/keyboard/atkbd.c	2004-10-01 00:30:13.000000000 +0200
+++ linux/drivers/input/keyboard/atkbd.c	2004-10-31 22:35:52.000000000 +0100
@@ -26,6 +26,7 @@
 #include <linux/input.h>
 #include <linux/serio.h>
 #include <linux/workqueue.h>
+#include <linux/dmi.h>
 
 #define DRIVER_DESC	"AT and PS/2 keyboard driver"
 
@@ -986,8 +987,31 @@
 	.cleanup	= atkbd_cleanup,
 };
 
+static int __init add_evo_keys(struct dmi_system_id *d)
+{
+	printk("Compaq Evo detected, mapping extra keys\n");
+	atkbd_set2_keycode[0x80 | atkbd_unxlate_table[0x23] ] = 150;
+	atkbd_set2_keycode[0x80 | atkbd_unxlate_table[0x1e] ] = 155;
+	atkbd_set2_keycode[0x80 | atkbd_unxlate_table[0x1a] ] = 217;
+	atkbd_set2_keycode[0x80 | atkbd_unxlate_table[0x1f] ] = 157;
+	return 0;
+}
+
+static struct dmi_system_id __initdata keyboard_dmi_table[] = {
+	{       /* Handle special keys on Compaq Evo */
+		.callback = add_evo_keys,
+		.ident = "Compaq Evo",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Evo N620c"),
+		},
+	}
+};
+
+
 int __init atkbd_init(void)
 {
+	dmi_check_system(keyboard_dmi_table);
 	serio_register_driver(&atkbd_drv);
 	return 0;
 }

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
