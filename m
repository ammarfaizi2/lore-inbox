Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWBFTTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWBFTTW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWBFTTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:19:22 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:38362 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932288AbWBFTTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:19:21 -0500
Date: Mon, 6 Feb 2006 19:19:17 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Add Dell laptop backlight brightness display
Message-ID: <20060206191916.GB17460@srcf.ucam.org>
References: <20060206191506.GA17395@srcf.ucam.org> <20060206191810.GA17460@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060206191810.GA17460@srcf.ucam.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch hooks into the generic backlight framework and allows the
brightness of Dell laptop displays to be read. The AC and DC values are
separate, but the framework currently provides no mechanism for them to
be provided separately and there's no straightforward way for the driver
to know if the system is on battery or not. As a result, I've put the AC
brightness in the top 16 bits of the returned value, with the DC
brightness in the bottom 16.

This patch requires my earlier patch to allow checking against the DMI
chassis type and should be applied after the HP backlight patch.

Signed-Off-By: Matthew Garrett <mjg59@srcf.ucam.org>

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 996d543..e4f84eb 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -50,3 +50,10 @@ config BACKLIGHT_CORGI
 	  If you have a Sharp Zaurus SL-C7xx, say y to enable the
 	  backlight driver.
 
+config BACKLIGHT_HP
+	tristate "HP Laptop Backlight Driver"
+	depends on BACKLIGHT_DEVICE && X86
+	default n
+	help
+	  Allows userspace applications to read the current screen brightness
+	  on HP laptops
\ No newline at end of file
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index 4af321f..93ac108 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_LCD_CLASS_DEVICE)     += lc
 obj-$(CONFIG_BACKLIGHT_CLASS_DEVICE) += backlight.o
 obj-$(CONFIG_BACKLIGHT_CORGI)	+= corgi_bl.o
 obj-$(CONFIG_SHARP_LOCOMO)	+= locomolcd.o
+obj-$(CONFIG_BACKLIGHT_HP) 	+= hp_bl.o
\ No newline at end of file
diff --git a/drivers/video/backlight/hp_bl.c b/drivers/video/backlight/hp_bl.c
new file mode 100644
index 0000000..945c242
--- /dev/null
+++ b/drivers/video/backlight/hp_bl.c
@@ -0,0 +1,98 @@
+/*
+ *  Backlight Driver for HP laptops
+ *
+ *  Copyright (c) 2006 Matthew Garrett
+ *
+ *  Based on corgi_bl.c, Copyright (c) 2004-2005 Richard Purdie
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/fb.h>
+#include <linux/backlight.h>
+#include <linux/dmi.h>
+
+static struct backlight_properties hpbl_data;
+
+static spinlock_t bl_lock = SPIN_LOCK_UNLOCKED;
+
+static struct dmi_system_id __initdata hplcd_device_table[] = {
+	{
+		.ident = "HP",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "Notebook"),
+		},
+	},
+	{ }
+};
+
+
+static int hpbl_get_intensity(struct backlight_device *bd)
+{
+	/* The backlight interface doesn't give us a means of providing
+	   more than one brightness value, so we put the AC value in the
+	   top bits of the brightness and the DC value in the bottom bits */
+
+	int value;
+	int combined;
+
+	spin_lock(&bl_lock);
+
+	outb(0x97, 0x72);
+	value = inb(0x73);
+
+	value &= 0x1f; // Brightness is in the lower 5 bits
+	combined = value << 16;
+
+	outb(0x99, 0x72);
+	value = inb(0x73);
+
+	spin_unlock(&bl_lock);
+
+	value &= 0x1f; // Brightness is in the lower 5 bits
+	combined |= value;
+
+	return combined;
+}
+
+static struct backlight_properties hpbl_data = {
+	.owner		= THIS_MODULE,
+	.get_brightness = hpbl_get_intensity,
+	.max_brightness = 10,
+};
+
+static struct backlight_device *hp_backlight_device;
+
+static int __init hpbl_init(void)
+{
+	if (!dmi_check_system(hplcd_device_table))
+		return -ENODEV;	
+
+	hp_backlight_device = backlight_device_register ("hp-bl",
+		NULL, &hpbl_data);
+	if (IS_ERR (hp_backlight_device))
+		return PTR_ERR (hp_backlight_device);
+
+	return 0;
+}
+
+static void __exit hpbl_exit(void)
+{
+	backlight_device_unregister(hp_backlight_device);
+}
+
+module_init(hpbl_init);
+module_exit(hpbl_exit);
+
+MODULE_AUTHOR("Matthew Garrett <mjg59@srcf.ucam.org>");
+MODULE_DESCRIPTION("HP Backlight Driver");
+MODULE_LICENSE("GPL");

-- 
Matthew Garrett | mjg59@srcf.ucam.org
