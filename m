Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWGVPhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWGVPhz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 11:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWGVPhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 11:37:33 -0400
Received: from wm402rot.66.ADSL.NetSurf.Net ([66.135.97.66]:33922 "EHLO
	png3r11.pngxnet.com") by vger.kernel.org with ESMTP
	id S1750811AbWGVPh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 11:37:28 -0400
From: Dave Airlie <airlied@linux.ie>
To: linux-kernel@vger.kernel.org
Cc: Dave Airlie <airlied@linux.ie>
Subject: [PATCH] gpu/radeon: add a radeon lowlevel GPU driver (04/07)
Date: Sun, 23 Jul 2006 01:38:30 +1000
Message-Id: <11535827141780-git-send-email-airlied@linux.ie>
X-Mailer: git-send-email 1.4.1.ga3e6
In-Reply-To: <11535827132905-git-send-email-airlied@linux.ie>
References: <11535827134076-git-send-email-airlied@linux.ie> <11535827133352-git-send-email-airlied@linux.ie> <11535827131612-git-send-email-airlied@linux.ie> <11535827132905-git-send-email-airlied@linux.ie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This creates a lowlevel radeon driver which detects the card and
sets up the GPU layer to use it.

Signed-off-by: Dave Airlie <airlied@linux.ie>
---
 drivers/video/Kconfig      |    5 +
 drivers/video/Makefile     |    2 
 drivers/video/radeon_gpu.c |  343 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/radeon_gpu.h |   92 ++++++++++++
 4 files changed, 442 insertions(+), 0 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 8512aa8..6602752 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -8,6 +8,11 @@ config GPU
 	bool
 	default n
 
+config GPU_RADEON
+	tristate "ATI Radeon gpu driver"
+	select GPU
+	default n
+
 config FIRMWARE_EDID
        bool "Enable firmware EDID"
        default y
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index a882fdd..2650f02 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -6,6 +6,8 @@ # Each configuration option enables a li
 
 obj-$(CONFIG_GPU)		  += gpu_layer.o
 
+obj-$(CONFIG_GPU_RADEON)          += radeon_gpu.o
+
 obj-$(CONFIG_FB)                  += fb.o
 fb-y                              := fbmem.o fbmon.o fbcmap.o fbsysfs.o \
                                      modedb.o fbcvt.o
diff --git a/drivers/video/radeon_gpu.c b/drivers/video/radeon_gpu.c
new file mode 100644
index 0000000..2eecf3b
--- /dev/null
+++ b/drivers/video/radeon_gpu.c
@@ -0,0 +1,343 @@
+/*
+ * drivers/video/radeon_gpu.c
+ *
+ * Copyright (C) 2006 Dave Airlie
+ *
+ * some of this code is derived from the radeon framebuffer code
+ *      Copyright 2003  Ben. Herrenschmidt <benh@kernel.crashing.org>
+ *      Copyright 2000  Ani Joshi <ajoshi@kernel.crashing.org>
+ */
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/pci.h>
+#include <linux/device.h>
+
+#include <linux/gpu_layer.h>
+#include <linux/radeon_gpu.h>
+
+#include <video/radeon.h>
+#include "aty/ati_ids.h"
+
+
+#define CHIP_DEF(id, family, flags)					\
+	{ PCI_VENDOR_ID_ATI, id, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (flags) | (CHIP_FAMILY_##family) }
+
+static struct pci_device_id radeon_gpu_pci_table[] = {
+	/* Mobility M6 */
+	CHIP_DEF(PCI_CHIP_RADEON_LY, 	RV100,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RADEON_LZ,	RV100,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	/* Radeon VE/7000 */
+	CHIP_DEF(PCI_CHIP_RV100_QY, 	RV100,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV100_QZ, 	RV100,	CHIP_HAS_CRTC2),
+	/* Radeon IGP320M (U1) */
+	CHIP_DEF(PCI_CHIP_RS100_4336,	RS100,	CHIP_HAS_CRTC2 | CHIP_IS_IGP | CHIP_IS_MOBILITY),
+	/* Radeon IGP320 (A3) */
+	CHIP_DEF(PCI_CHIP_RS100_4136,	RS100,	CHIP_HAS_CRTC2 | CHIP_IS_IGP),
+	/* IGP330M/340M/350M (U2) */
+	CHIP_DEF(PCI_CHIP_RS200_4337,	RS200,	CHIP_HAS_CRTC2 | CHIP_IS_IGP | CHIP_IS_MOBILITY),
+	/* IGP330/340/350 (A4) */
+	CHIP_DEF(PCI_CHIP_RS200_4137,	RS200,	CHIP_HAS_CRTC2 | CHIP_IS_IGP),
+	/* Mobility 7000 IGP */
+	CHIP_DEF(PCI_CHIP_RS250_4437,	RS200,	CHIP_HAS_CRTC2 | CHIP_IS_IGP | CHIP_IS_MOBILITY),
+	/* 7000 IGP (A4+) */
+	CHIP_DEF(PCI_CHIP_RS250_4237,	RS200,	CHIP_HAS_CRTC2 | CHIP_IS_IGP),
+	/* 8500 AIW */
+	CHIP_DEF(PCI_CHIP_R200_BB,	R200,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R200_BC,	R200,	CHIP_HAS_CRTC2),
+	/* 8700/8800 */
+	CHIP_DEF(PCI_CHIP_R200_QH,	R200,	CHIP_HAS_CRTC2),
+	/* 8500 */
+	CHIP_DEF(PCI_CHIP_R200_QL,	R200,	CHIP_HAS_CRTC2),
+	/* 9100 */
+	CHIP_DEF(PCI_CHIP_R200_QM,	R200,	CHIP_HAS_CRTC2),
+	/* Mobility M7 */
+	CHIP_DEF(PCI_CHIP_RADEON_LW,	RV200,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RADEON_LX,	RV200,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	/* 7500 */
+	CHIP_DEF(PCI_CHIP_RV200_QW,	RV200,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV200_QX,	RV200,	CHIP_HAS_CRTC2),
+	/* Mobility M9 */
+	CHIP_DEF(PCI_CHIP_RV250_Ld,	RV250,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV250_Le,	RV250,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV250_Lf,	RV250,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV250_Lg,	RV250,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	/* 9000/Pro */
+	CHIP_DEF(PCI_CHIP_RV250_If,	RV250,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV250_Ig,	RV250,	CHIP_HAS_CRTC2),
+	/* Mobility 9100 IGP (U3) */
+	CHIP_DEF(PCI_CHIP_RS300_5835,	RS300,	CHIP_HAS_CRTC2 | CHIP_IS_IGP | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RS350_7835,	RS300,	CHIP_HAS_CRTC2 | CHIP_IS_IGP | CHIP_IS_MOBILITY),
+	/* 9100 IGP (A5) */
+	CHIP_DEF(PCI_CHIP_RS300_5834,	RS300,	CHIP_HAS_CRTC2 | CHIP_IS_IGP),
+	CHIP_DEF(PCI_CHIP_RS350_7834,	RS300,	CHIP_HAS_CRTC2 | CHIP_IS_IGP),
+	/* Mobility 9200 (M9+) */
+	CHIP_DEF(PCI_CHIP_RV280_5C61,	RV280,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV280_5C63,	RV280,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	/* 9200 */
+	CHIP_DEF(PCI_CHIP_RV280_5960,	RV280,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV280_5961,	RV280,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV280_5962,	RV280,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV280_5964,	RV280,	CHIP_HAS_CRTC2),
+	/* 9500 */
+	CHIP_DEF(PCI_CHIP_R300_AD,	R300,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R300_AE,	R300,	CHIP_HAS_CRTC2),
+	/* 9600TX / FireGL Z1 */
+	CHIP_DEF(PCI_CHIP_R300_AF,	R300,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R300_AG,	R300,	CHIP_HAS_CRTC2),
+	/* 9700/9500/Pro/FireGL X1 */
+	CHIP_DEF(PCI_CHIP_R300_ND,	R300,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R300_NE,	R300,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R300_NF,	R300,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R300_NG,	R300,	CHIP_HAS_CRTC2),
+	/* Mobility M10/M11 */
+	CHIP_DEF(PCI_CHIP_RV350_NP,	RV350,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV350_NQ,	RV350,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV350_NR,	RV350,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV350_NS,	RV350,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV350_NT,	RV350,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV350_NV,	RV350,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	/* 9600/FireGL T2 */
+	CHIP_DEF(PCI_CHIP_RV350_AP,	RV350,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV350_AQ,	RV350,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV360_AR,	RV350,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV350_AS,	RV350,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV350_AT,	RV350,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV350_AV,	RV350,	CHIP_HAS_CRTC2),
+	/* 9800/Pro/FileGL X2 */
+	CHIP_DEF(PCI_CHIP_R350_AH,	R350,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R350_AI,	R350,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R350_AJ,	R350,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R350_AK,	R350,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R350_NH,	R350,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R350_NI,	R350,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R360_NJ,	R350,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R350_NK,	R350,	CHIP_HAS_CRTC2),
+	/* Newer stuff */
+	CHIP_DEF(PCI_CHIP_RV380_3E50,	RV380,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV380_3E54,	RV380,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV380_3150,	RV380,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV380_3154,	RV380,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV370_5B60,	RV380,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV370_5B62,	RV380,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV370_5B64,	RV380,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV370_5B65,	RV380,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV370_5460,	RV380,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV370_5464,	RV380,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_R420_JH,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R420_JI,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R420_JJ,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R420_JK,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R420_JL,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R420_JM,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R420_JN,	R420,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_R420_JP,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UH,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UI,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UJ,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UK,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UQ,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UR,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UT,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_5D57,	R420,	CHIP_HAS_CRTC2),
+	/* Original Radeon/7200 */
+	CHIP_DEF(PCI_CHIP_RADEON_QD,	RADEON,	0),
+	CHIP_DEF(PCI_CHIP_RADEON_QE,	RADEON,	0),
+	CHIP_DEF(PCI_CHIP_RADEON_QF,	RADEON,	0),
+	CHIP_DEF(PCI_CHIP_RADEON_QG,	RADEON,	0),
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, radeon_gpu_pci_table);
+
+MODULE_AUTHOR("Dave Airlie");
+MODULE_DESCRIPTION("GPU layer driver for Radeon Chipset");
+MODULE_LICENSE("GPL");
+
+struct gpu_driver radeon_lowlevel_driver = {
+	.name =	"radeon_gpu",
+	.card_type = GPU_PCI,
+	.drv_type = GPU_LL,
+};
+
+/**
+ * radeon_gpu_pci_probe
+ */
+int radeon_gpu_pci_probe(struct pci_dev *dev, const struct pci_device_id *ent)
+{
+	struct radeon_gpu_info *rinfo;
+	int ret;
+
+	if (pci_enable_device(dev) < 0)
+		return -EINVAL;
+
+	rinfo = kzalloc(sizeof(*rinfo), GFP_KERNEL);
+	if (!rinfo) {
+		dev_dbg(dev->dev, "radeon info alloc failed\n");
+		return -ENOMEM;
+	}
+	dev_set_drvdata(&dev->dev, rinfo);
+
+	rinfo->family = ent->driver_data & CHIP_FAMILY_MASK;
+	rinfo->chipset = dev->device;
+	rinfo->has_CRTC2 = (ent->driver_data & CHIP_HAS_CRTC2) != 0;
+	rinfo->is_mobility = (ent->driver_data & CHIP_IS_MOBILITY) != 0;
+	rinfo->is_IGP = (ent->driver_data & CHIP_IS_IGP) != 0;
+
+	/* Set base addrs */
+	rinfo->fb_base_phys = pci_resource_start(dev, 0);
+	rinfo->mmio_base_phys = pci_resource_start(dev, 2);
+
+	rinfo->ati_name[0] = ent->device >> 8;
+	rinfo->ati_name[1] = ent->device & 0xff;
+
+	rinfo->pdev = dev;
+	/*
+	 * Check for errata
+	 */
+	rinfo->errata = 0;
+
+	if (rinfo->family == CHIP_FAMILY_RV200 ||
+	    rinfo->family == CHIP_FAMILY_RS200)
+		rinfo->errata |= CHIP_ERRATA_PLL_DUMMYREADS;
+
+	if (rinfo->family == CHIP_FAMILY_RV100 ||
+	    rinfo->family == CHIP_FAMILY_RS100 ||
+	    rinfo->family == CHIP_FAMILY_RS200)
+		rinfo->errata |= CHIP_ERRATA_PLL_DELAY;
+
+	gpu_bus_init(&rinfo->info.self);
+	rinfo->info.self.bus_name = pci_name(dev);
+	rinfo->info.self.gpu = &dev->dev;
+	rinfo->info.self.card_type = GPU_PCI;
+	rinfo->info.self.num_subdev = GPU_LAST;
+
+	if ((ret = gpu_register_bus(&rinfo->info.self)) < 0)
+		goto err_register_bus;
+
+	if ((ret = gpu_alloc_devices(&rinfo->info.self)) < 0) {
+		dev_err(rinfo->info.self.gpu, "unable to alloc lowlayer device\n");
+		ret = -ENOMEM;
+		goto err_allocate_low_layer;
+	}
+
+	/* the first device driver is always the lowlevel driver */
+	rinfo->info.self.devices[0]->dev.driver = &radeon_lowlevel_driver.driver;
+
+	ret = gpu_register_devices(&rinfo->info.self);
+
+	return ret;
+
+err_allocate_low_layer:
+	gpu_unregister_bus(&rinfo->info.self);
+err_register_bus:
+	dev_set_drvdata(&dev->dev, NULL);
+	kfree(rinfo);
+	return ret;
+}
+
+/**
+ * radeon_gpu_pci_remove
+ */
+void radeon_gpu_pci_remove(struct pci_dev *dev)
+{
+	struct radeon_gpu_info *rinfo;
+
+	rinfo = dev_get_drvdata(&dev->dev);
+
+	gpu_unregister_devices(&rinfo->info.self);
+
+	gpu_unregister_bus(&rinfo->info.self);
+	dev_set_drvdata(&dev->dev, NULL);
+
+	kfree(rinfo);
+}
+
+/**
+ * radeon_gpu_pci_suspend
+ *
+ * These are null methods so
+ * we don't get defaults,
+ * do not use them use the lowlevel driver
+ */
+int radeon_gpu_pci_suspend(struct pci_dev  *dev, pm_message_t message)
+{
+	return 0;
+}
+
+/**
+ * radeon_gpu_pci_resume
+ *
+ * These are null methods so
+ * we don't get defaults,
+ * do not use them use the lowlevel driver
+ */
+int radeon_gpu_pci_resume(struct pci_dev *dev)
+{
+	return 0;
+}
+
+static struct pci_driver radeon_gpu_driver = {
+	.name		= "radeon_gpu",
+	.id_table	= radeon_gpu_pci_table,
+	.probe		= radeon_gpu_pci_probe,
+	.remove		= __devexit_p(radeon_gpu_pci_remove),
+#ifdef CONFIG_PM
+	.suspend       	= radeon_gpu_pci_suspend,
+	.resume		= radeon_gpu_pci_resume,
+#endif /* CONFIG_PM */
+};
+
+/**
+ * radeon_gpu_register_driver
+ *
+ * This wraps the GPU register function
+ * It is needed so that loading a higher layer module
+ * will force this module to load.
+ */
+int radeon_gpu_register_driver(struct gpu_driver *new_driver, struct module *owner)
+{
+	return gpu_register_driver(new_driver, owner);
+}
+EXPORT_SYMBOL(radeon_gpu_register_driver);
+
+/**
+ * radeon_gpu_unregister_driver
+ */
+void radeon_gpu_unregister_driver(struct gpu_driver *driver)
+{
+	gpu_unregister_driver(driver);
+}
+EXPORT_SYMBOL(radeon_gpu_unregister_driver);
+
+/**
+ * radeon_gpu_init
+ *
+ * Register the GPU driver and PCI driver
+ */
+static int __init radeon_gpu_init(void)
+{
+	int retval;
+
+	retval = gpu_register(&radeon_lowlevel_driver);
+	if (retval)
+		return retval;
+
+	return pci_register_driver (&radeon_gpu_driver);
+}
+
+/**
+ * radeon_gpu_exit
+ *
+ * Unregister the drivers.
+ */
+static void __exit radeon_gpu_exit(void)
+{
+	pci_unregister_driver (&radeon_gpu_driver);
+
+	gpu_unregister_driver(&radeon_lowlevel_driver);
+
+}
+
+module_init(radeon_gpu_init);
+module_exit(radeon_gpu_exit);
diff --git a/include/linux/radeon_gpu.h b/include/linux/radeon_gpu.h
new file mode 100644
index 0000000..defea65
--- /dev/null
+++ b/include/linux/radeon_gpu.h
@@ -0,0 +1,92 @@
+/*
+ * include/linux/radeon_gpu.h
+ */
+#ifndef _LINUX_RADEON_GPU_H
+#define _LINUX_RADEON_GPU_H
+
+/*
+ * Chip families. Must fit in the low 16 bits of a long word
+ */
+enum radeon_family {
+	CHIP_FAMILY_UNKNOW,
+	CHIP_FAMILY_LEGACY,
+	CHIP_FAMILY_RADEON,
+	CHIP_FAMILY_RV100,
+	CHIP_FAMILY_RS100,    /* U1 (IGP320M) or A3 (IGP320)*/
+	CHIP_FAMILY_RV200,
+	CHIP_FAMILY_RS200,    /* U2 (IGP330M/340M/350M) or A4 (IGP330/340/345/350),
+				 RS250 (IGP 7000) */
+	CHIP_FAMILY_R200,
+	CHIP_FAMILY_RV250,
+	CHIP_FAMILY_RS300,    /* Radeon 9000 IGP */
+	CHIP_FAMILY_RV280,
+	CHIP_FAMILY_R300,
+	CHIP_FAMILY_R350,
+	CHIP_FAMILY_RV350,
+	CHIP_FAMILY_RV380,    /* RV370/RV380/M22/M24 */
+	CHIP_FAMILY_R420,     /* R420/R423/M18 */
+	CHIP_FAMILY_LAST,
+};
+
+
+/*
+ * Chip flags
+ */
+enum radeon_chip_flags {
+	CHIP_FAMILY_MASK	= 0x0000ffffUL,
+	CHIP_FLAGS_MASK		= 0xffff0000UL,
+	CHIP_IS_MOBILITY	= 0x00010000UL,
+	CHIP_IS_IGP		= 0x00020000UL,
+	CHIP_HAS_CRTC2		= 0x00040000UL,
+};
+
+/*
+ * Errata workarounds
+ */
+enum radeon_errata {
+	CHIP_ERRATA_R300_CG		= 0x00000001,
+	CHIP_ERRATA_PLL_DUMMYREADS	= 0x00000002,
+	CHIP_ERRATA_PLL_DELAY		= 0x00000004,
+};
+
+#define IS_RV100_VARIANT(rinfo) (((rinfo)->family == CHIP_FAMILY_RV100)  || \
+				 ((rinfo)->family == CHIP_FAMILY_RV200)  || \
+				 ((rinfo)->family == CHIP_FAMILY_RS100)  || \
+				 ((rinfo)->family == CHIP_FAMILY_RS200)  || \
+				 ((rinfo)->family == CHIP_FAMILY_RV250)  || \
+				 ((rinfo)->family == CHIP_FAMILY_RV280)  || \
+				 ((rinfo)->family == CHIP_FAMILY_RS300))
+
+
+#define IS_R300_VARIANT(rinfo) (((rinfo)->family == CHIP_FAMILY_R300)  || \
+				((rinfo)->family == CHIP_FAMILY_RV350) || \
+				((rinfo)->family == CHIP_FAMILY_R350)  || \
+				((rinfo)->family == CHIP_FAMILY_RV380) || \
+				((rinfo)->family == CHIP_FAMILY_R420))
+
+
+
+struct radeon_gpu_info {
+	struct gpu_info info;
+
+	struct pci_dev		*pdev;
+
+	int			chipset;
+	u8			family;
+	u8			rev;
+	unsigned int		errata;
+
+	unsigned long		mmio_base_phys;
+	unsigned long		fb_base_phys;
+
+	int			has_CRTC2;
+	int			is_mobility;
+	int			is_IGP;
+
+	char ati_name[2];
+
+};
+
+extern int radeon_gpu_register_driver(struct gpu_driver *new_driver, struct module *owner);
+extern void radeon_gpu_unregister_driver(struct gpu_driver *driver);
+#endif
-- 
1.4.1.ga3e6

