Return-Path: <linux-kernel-owner+w=401wt.eu-S1161056AbXAELQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161056AbXAELQI (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 06:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161062AbXAELQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 06:16:07 -0500
Received: from v813.rev.tld.pl ([195.149.226.213]:57006 "EHLO
	smtp.host4.kei.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161056AbXAELQG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 06:16:06 -0500
X-clamdmail: clamdmail 0.18a
From: Marcin Juszkiewicz <openembedded@hrw.one.pl>
Organization: OpenEmbedded
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight control for Frontpath ProGear HX1050+
Date: Fri, 5 Jan 2007 12:15:53 +0100
User-Agent: KMail/1.9.5
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Richard Purdie <rpurdie@rpsys.net>
References: <200701050903.31859.openembedded@hrw.one.pl> <20070105093901.7f2ef1f8@localhost.localdomain>
In-Reply-To: <20070105093901.7f2ef1f8@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200701051215.54243.openembedded@hrw.one.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia pi±tek, 5 stycznia 2007 10:39, Alan napisa³:
> > +struct pci_dev *pmu_dev = NULL;
> > +struct pci_dev *sb_dev  = NULL;
>
> static ?

static

> > +	pmu_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101,
> > 0);
>
> pci_find_device is going away, please use pci_get_device and the get/put
> functions to refcount it. This makes the system hotplug safe.

I hope that I got it right. Did not tested it on device yet.



From: Marcin Juszkiewicz <openembedded@hrw.one.pl>

Add control of LCD backlight for Frontpath ProGear HX1050+.
Patch is based on http://downloads.sf.net/progear/progear-lcd-0.2.tar.gz
driver by M Schacht.

Signed-Off-By: Marcin Juszkiewicz <openembedded@hrw.one.pl>

---
Patch follow kernel version 2.6.19-rc6

 Kconfig      |    8 +++
 Makefile     |    1
 progear_bl.c |  155 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 164 insertions(+)


Index: linux/drivers/video/backlight/Kconfig
===================================================================
--- linux.orig/drivers/video/backlight/Kconfig	2006-08-30 10:55:44.000000000 +0200
+++ linux/drivers/video/backlight/Kconfig	2007-01-05 11:17:16.000000000 +0100
@@ -66,3 +66,11 @@
 	  If you have a HP Jornada 680, say y to enable the
 	  backlight driver.
 
+config BACKLIGHT_PROGEAR
+       tristate "Frontpath ProGear Backlight Driver"
+       depends on BACKLIGHT_DEVICE && PCI
+       default y
+       help
+         If you have a Frontpath ProGear say Y to enable the
+         backlight driver.
+
Index: linux/drivers/video/backlight/Makefile
===================================================================
--- linux.orig/drivers/video/backlight/Makefile	2006-08-30 10:55:44.000000000 +0200
+++ linux/drivers/video/backlight/Makefile	2007-01-05 11:17:56.000000000 +0100
@@ -5,3 +5,4 @@
 obj-$(CONFIG_BACKLIGHT_CORGI)	+= corgi_bl.o
 obj-$(CONFIG_BACKLIGHT_HP680)	+= hp680_bl.o
 obj-$(CONFIG_BACKLIGHT_LOCOMO)	+= locomolcd.o
+obj-$(CONFIG_BACKLIGHT_PROGEAR) += progear_bl.o
Index: linux/drivers/video/backlight/progear_bl.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/drivers/video/backlight/progear_bl.c	2007-01-05 12:05:37.000000000 +0100
@@ -0,0 +1,161 @@
+/*
+ *  Backlight Driver for Frontpath ProGear HX1050+
+ *
+ *  Copyright (c) 2006 Marcin Juszkiewicz
+ *
+ *  Based on Progear LCD driver by M Schacht
+ *  <mschacht at alumni dot washington dot edu>
+ *
+ *  Based on Sharp's Corgi Backlight Driver
+ *  Based on Backlight Driver for HP Jornada 680
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
+#include <linux/mutex.h>
+#include <linux/fb.h>
+#include <linux/backlight.h>
+#include <linux/pci.h>
+#include <asm/uaccess.h>
+
+#define PMU_LPCR               0xB0
+#define SB_MPS1                0x61
+#define HW_LEVEL_MAX           0x77
+#define HW_LEVEL_MIN           0x4f
+
+static int progearbl_intensity;
+static struct backlight_properties progearbl_data;
+static struct backlight_device *progear_backlight_device;
+
+static struct pci_dev *pmu_dev = NULL;
+static struct pci_dev *sb_dev = NULL;
+
+static int progearbl_send_intensity(struct backlight_device *bd)
+{
+	int intensity = bd->props->brightness;
+
+	if (bd->props->power != FB_BLANK_UNBLANK)
+		intensity = 0;
+	if (bd->props->fb_blank != FB_BLANK_UNBLANK)
+		intensity = 0;
+
+	pci_write_config_byte(pmu_dev, PMU_LPCR, intensity + HW_LEVEL_MIN);
+
+	progearbl_intensity = intensity;
+
+	return 0;
+}
+
+static int progearbl_get_intensity(struct backlight_device *bd)
+{
+	return progearbl_intensity;
+}
+
+static int progearbl_set_intensity(struct backlight_device *bd)
+{
+	progearbl_send_intensity(progear_backlight_device);
+
+	return 0;
+}
+
+static struct backlight_properties progearbl_data = {
+	.owner = THIS_MODULE,
+	.get_brightness = progearbl_get_intensity,
+	.update_status = progearbl_set_intensity,
+};
+
+static int progearbl_probe(struct platform_device *pdev)
+{
+	u8 temp;
+
+	pmu_dev = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101, 0);
+	if (!pmu_dev) {
+		printk("ALI M7101 PMU not found.\n");
+		return -ENODEV;
+	}
+
+	sb_dev = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, 0);
+	if (!sb_dev) {
+		printk("ALI 1533 SB not found.\n");
+		pci_dev_put(pmu_dev);
+		return -ENODEV;
+	}
+
+	/*     Set SB_MPS1 to enable brightness control. */
+	pci_read_config_byte(sb_dev, SB_MPS1, &temp);
+	pci_write_config_byte(sb_dev, SB_MPS1, temp | 0x20);
+
+	progear_backlight_device = backlight_device_register("progear-bl",
+							     NULL,
+							     &progearbl_data);
+	if (IS_ERR(progear_backlight_device))
+		return PTR_ERR(progear_backlight_device);
+
+	progearbl_data.power = FB_BLANK_UNBLANK;
+	progearbl_data.brightness = HW_LEVEL_MAX - HW_LEVEL_MIN;
+	progearbl_data.max_brightness = HW_LEVEL_MAX - HW_LEVEL_MIN;
+	progearbl_send_intensity(progear_backlight_device);
+
+	return 0;
+}
+
+static int progearbl_remove(struct platform_device *dev)
+{
+	backlight_device_unregister(progear_backlight_device);
+
+	return 0;
+}
+
+static struct platform_driver progearbl_driver = {
+	.probe = progearbl_probe,
+	.remove = progearbl_remove,
+	.driver = {
+		   .name = "progear-bl",
+		   },
+};
+
+static struct platform_device *progearbl_device;
+
+static int __init progearbl_init(void)
+{
+	int ret = platform_driver_register(&progearbl_driver);
+	if (!ret) {
+		progearbl_device = platform_device_alloc("progear-bl", -1);
+		if (!progearbl_device)
+			return -ENOMEM;
+
+		ret = platform_device_add(progearbl_device);
+
+		if (ret) {
+			platform_device_put(progearbl_device);
+			platform_driver_unregister(&progearbl_driver);
+		}
+	}
+	return ret;
+}
+
+static void __exit progearbl_exit(void)
+{
+	if (pmu_dev)
+		pci_dev_put(pmu_dev);
+
+	if (sb_dev)
+		pci_dev_put(sb_dev);
+
+	platform_device_unregister(progearbl_device);
+	platform_driver_unregister(&progearbl_driver);
+}
+
+module_init(progearbl_init);
+module_exit(progearbl_exit);
+
+MODULE_AUTHOR("Marcin Juszkiewicz <linux@hrw.one.pl>");
+MODULE_DESCRIPTION("ProGear Backlight Driver");
+MODULE_LICENSE("GPL");

-- 
JID: hrw-jabber.org
OpenEmbedded developer/consultant

                    Sometimes a cigar is just a cigar.
                    		-- Sigmund Freud


