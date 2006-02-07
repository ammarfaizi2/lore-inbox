Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964896AbWBGAh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbWBGAh4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 19:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWBGAhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 19:37:55 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:30103 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S964896AbWBGAhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 19:37:54 -0500
Date: Tue, 7 Feb 2006 00:37:48 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] Add Dell laptop backlight brightness display
Message-ID: <20060207003748.GA22510@srcf.ucam.org>
References: <20060206191506.GA17395@srcf.ucam.org> <20060206191810.GA17460@srcf.ucam.org> <20060206191916.GB17460@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060206191916.GB17460@srcf.ucam.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resend: This time I've actually included the correct patch.

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
index e4f84eb..0f83183 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -56,4 +56,12 @@ config BACKLIGHT_HP
 	default n
 	help
 	  Allows userspace applications to read the current screen brightness
-	  on HP laptops
\ No newline at end of file
+	  on HP laptops
+
+config BACKLIGHT_DELL
+	tristate "Dell Laptop Backlight Driver"
+	depends on BACKLIGHT_DEVICE && X86
+	default n
+	help
+	  Allows userspace applications to read the current screen brightness
+	  on Dell laptops
\ No newline at end of file
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index 93ac108..f337f01 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -4,4 +4,5 @@ obj-$(CONFIG_LCD_CLASS_DEVICE)     += lc
 obj-$(CONFIG_BACKLIGHT_CLASS_DEVICE) += backlight.o
 obj-$(CONFIG_BACKLIGHT_CORGI)	+= corgi_bl.o
 obj-$(CONFIG_SHARP_LOCOMO)	+= locomolcd.o
-obj-$(CONFIG_BACKLIGHT_HP) 	+= hp_bl.o
\ No newline at end of file
+obj-$(CONFIG_BACKLIGHT_HP) 	+= hp_bl.o
+obj-$(CONFIG_BACKLIGHT_DELL) 	+= dell_bl.o
\ No newline at end of file
diff --git a/drivers/video/backlight/dell_bl.c b/drivers/video/backlight/dell_bl.c
new file mode 100644
index 0000000..a97a4b8
--- /dev/null
+++ b/drivers/video/backlight/dell_bl.c
@@ -0,0 +1,92 @@
+/*
+ *  Backlight Driver for Dell laptops
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
+#include <linux/fb.h>
+#include <linux/backlight.h>
+#include <linux/dmi.h>
+#include <linux/nvram.h>
+
+static struct backlight_properties dellbl_data;
+
+static struct dmi_system_id __initdata delllcd_device_table[] = {
+	{
+		.ident = "Dell",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "Portable"),
+		},		
+	},
+	{ }
+};
+
+
+static int dellbl_get_intensity(struct backlight_device *bd)
+{
+	/* The backlight interface doesn't give us a means of providing
+	   more than one brightness value, so we put the AC value in the
+	   top bits of the brightness and the DC value in the bottom bits */
+
+	int value;
+	int combined;
+
+	value = nvram_read_byte(0x53);
+
+	value &= 0xf0; // Brightness is in the upper 4 bits
+	combined = value << 12;
+
+	value = nvram_read_byte(0x16);
+	
+	outb(0x99, 0x72);
+	value = inb(0x73);
+
+	value &= 0x0f; // Brightness is in the lower 4 bits
+	combined |= value;
+
+	return combined;
+}
+
+static struct backlight_properties dellbl_data = {
+	.owner		= THIS_MODULE,
+	.get_brightness = dellbl_get_intensity,
+	.max_brightness = 0xe,
+};
+
+static struct backlight_device *dell_backlight_device;
+
+static int __init dellbl_init(void)
+{
+	if (!dmi_check_system(delllcd_device_table))
+		return -ENODEV;	
+
+	dell_backlight_device = backlight_device_register ("dell-bl",
+		NULL, &dellbl_data);
+	if (IS_ERR (dell_backlight_device))
+		return PTR_ERR (dell_backlight_device);
+
+	return 0;
+}
+
+static void __exit dellbl_exit(void)
+{
+	backlight_device_unregister(dell_backlight_device);
+}
+
+module_init(hpbl_init);
+module_exit(hpbl_exit);
+
+MODULE_AUTHOR("Matthew Garrett <mjg59@srcf.ucam.org>");
+MODULE_DESCRIPTION("Dell Backlight Driver");
+MODULE_LICENSE("GPL");

-- 
Matthew Garrett | mjg59@srcf.ucam.org
