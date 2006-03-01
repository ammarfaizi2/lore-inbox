Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWCAXoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWCAXoL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 18:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbWCAXoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 18:44:11 -0500
Received: from gate.crashing.org ([63.228.1.57]:61830 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750818AbWCAXoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 18:44:10 -0500
Date: Wed, 1 Mar 2006 17:34:10 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ide: Simple platform IDE driver
Message-ID: <Pine.LNX.4.44.0603011733340.10931-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A simple non-DMA platform IDE driver that can be used by embedded systems
that directly connect an IDE interface.  For example a Compact Flash card
in True IDE mode connect on a system bus.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 204d9fb4c7806224c027cb9eed9eea7e6bb9edad
tree 35683cdb4bdbaf71c7be17cf7c24bb1c3f78ae67
parent fc7dbbb29a113cb5bc859444c2ea76972d30a4f8
author Kumar Gala <galak@kernel.crashing.org> Wed, 01 Mar 2006 17:35:21 -0600
committer Kumar Gala <galak@kernel.crashing.org> Wed, 01 Mar 2006 17:35:21 -0600

 drivers/ide/Kconfig          |    9 ++
 drivers/ide/legacy/Makefile  |    1 
 drivers/ide/legacy/platide.c |  227 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/ide.h          |    9 ++
 4 files changed, 246 insertions(+), 0 deletions(-)

diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index d633081..295c417 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -923,6 +923,15 @@ config BLK_DEV_Q40IDE
 	  normally be on; disable it only if you are running a custom hard
 	  drive subsystem through an expansion card.
 
+config BLK_DEV_PLATIDE
+	bool "Simple Platform IDE support"
+	help
+	  Enable support for simple non-DMA platform device IDE driver.
+	  This driver can be used for embedded systems that connect
+	  an IDE interface directly to the system bus.  One example
+	  of this would be a Compact Flash device running in True IDE
+	  Mode on the system bus.
+
 config BLK_DEV_MPC8xx_IDE
 	bool "MPC8xx IDE support"
 	depends on 8xx && IDE=y && BLK_DEV_IDE=y
diff --git a/drivers/ide/legacy/Makefile b/drivers/ide/legacy/Makefile
index c797106..e48d2f8 100644
--- a/drivers/ide/legacy/Makefile
+++ b/drivers/ide/legacy/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_BLK_DEV_DTC2278)		+= dtc227
 obj-$(CONFIG_BLK_DEV_HT6560B)		+= ht6560b.o
 obj-$(CONFIG_BLK_DEV_QD65XX)		+= qd65xx.o
 obj-$(CONFIG_BLK_DEV_UMC8672)		+= umc8672.o
+obj-$(CONFIG_BLK_DEV_PLATIDE)		+= platide.o
 
 obj-$(CONFIG_BLK_DEV_IDECS)		+= ide-cs.o
 
diff --git a/drivers/ide/legacy/platide.c b/drivers/ide/legacy/platide.c
new file mode 100644
index 0000000..e0fb53d
--- /dev/null
+++ b/drivers/ide/legacy/platide.c
@@ -0,0 +1,227 @@
+/*
+ * Simple Platform IDE driver.
+ *
+ * Can be used on embedded systems for things like Compact Flash
+ * in True IDE mode
+ *
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/ide.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <asm/io.h>
+
+static void __iomem *platide_mapbase;
+static void __iomem *platide_alt_mapbase;
+
+static ide_hwif_t *__devinit platide_locate_hwif(void __iomem * base,
+						 void __iomem * ctrl,
+						 unsigned int data_offset,
+						 unsigned int reg_offset,
+						 unsigned int ctrl_offset,
+						 unsigned int stride, int irq)
+{
+	unsigned long port = (unsigned long)base;
+	ide_hwif_t *hwif;
+	int index, i;
+
+	for (index = 0; index < MAX_HWIFS; ++index) {
+		hwif = ide_hwifs + index;
+		if (hwif->io_ports[IDE_DATA_OFFSET] == port)
+			goto found;
+	}
+
+	for (index = 0; index < MAX_HWIFS; ++index) {
+		hwif = ide_hwifs + index;
+		if (hwif->io_ports[IDE_DATA_OFFSET] == 0)
+			goto found;
+	}
+
+	return NULL;
+
+ found:
+	hwif->hw.io_ports[IDE_DATA_OFFSET] = port + data_offset;
+	port += reg_offset;
+	for (i = IDE_ERROR_OFFSET; i <= IDE_STATUS_OFFSET; i++, port += stride)
+		hwif->hw.io_ports[i] = port;
+
+	hwif->hw.io_ports[IDE_CONTROL_OFFSET] =
+	    (unsigned long)ctrl + ctrl_offset;
+
+	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->hw.io_ports));
+	hwif->hw.irq = hwif->irq = irq;
+
+	hwif->hw.dma = NO_DMA;
+	hwif->hw.chipset = ide_generic;
+	hwif->no_io_32bit = 1;
+
+	hwif->mmio = 2;
+	default_hwif_mmiops(hwif);
+
+	return hwif;
+}
+
+static int __devinit platide_lbus_probe(struct platform_device *dev)
+{
+	struct resource *res_base, *res_irq, *res_alt = NULL;
+	ide_hwif_t *hwif;
+	struct ide_platform_data *pdata;
+	int ret = 0;
+
+	/* get a pointer to the register memory */
+	res_base = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	res_irq = platform_get_resource(dev, IORESOURCE_IRQ, 0);
+
+	pdata = dev->dev.platform_data;
+
+	if ((!res_base) || (!res_irq) || (!pdata)) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if (!request_mem_region
+	    (res_base->start, res_base->end - res_base->start + 1, dev->name)) {
+		pr_debug("%s: request_mem_region of base failed\n", dev->name);
+		ret = -EBUSY;
+		goto out;
+	}
+
+	platide_mapbase =
+	    ioremap(res_base->start, res_base->end - res_base->start + 1);
+	if (!platide_mapbase) {
+		ret = -ENOMEM;
+		goto rel_base;
+	}
+
+	if (pdata->flags & PLATIDE_SEPERATE_CONTROL_REGION) {
+		res_alt = platform_get_resource(dev, IORESOURCE_MEM, 1);
+
+		if (!res_alt) {
+			ret = -ENODEV;
+			goto unmap_base;
+		}
+
+		if (!request_mem_region
+		    (res_alt->start, res_alt->end - res_alt->start + 1,
+		     dev->name)) {
+			pr_debug("%s: request_mem_region of alt failed\n",
+				 dev->name);
+			ret = -EBUSY;
+			goto unmap_base;
+		}
+
+		platide_alt_mapbase =
+		    ioremap(res_alt->start, res_alt->end - res_alt->start + 1);
+
+		if (!platide_alt_mapbase) {
+			ret = -ENOMEM;
+			goto rel_alt;
+		}
+		hwif = platide_locate_hwif(platide_mapbase, platide_alt_mapbase,
+					   pdata->data_reg_offset,
+					   pdata->reg_offset,
+					   pdata->ctrl_reg_offset,
+					   pdata->stride, res_irq->start);
+		if (!hwif) {
+			ret = -ENODEV;
+			goto unmap_alt;
+		}
+	} else {
+		hwif = platide_locate_hwif(platide_mapbase, platide_mapbase,
+					   pdata->data_reg_offset,
+					   pdata->reg_offset,
+					   pdata->ctrl_reg_offset,
+					   pdata->stride, res_irq->start);
+		if (!hwif) {
+			ret = -ENODEV;
+			goto unmap_base;
+		}
+	}
+
+	hwif->gendev.parent = &dev->dev;
+	hwif->noprobe = 0;
+
+	probe_hwif_init(hwif);
+	create_proc_ide_interfaces();
+
+	platform_set_drvdata(dev, hwif);
+
+	return 0;
+
+ unmap_alt:
+	iounmap(platide_alt_mapbase);
+ rel_alt:
+	release_mem_region(res_alt->start, res_alt->end - res_alt->start + 1);
+ unmap_base:
+	iounmap(platide_mapbase);
+ rel_base:
+	release_mem_region(res_base->start,
+			   res_base->end - res_base->start + 1);
+ out:
+	return ret;
+}
+
+static int __devexit platide_lbus_remove(struct platform_device *dev)
+{
+	ide_hwif_t *hwif = platform_get_drvdata(dev);
+	struct resource *res_base, *res_alt;
+	struct ide_platform_data *pdata;
+
+	/* get a pointer to the register memory */
+	res_base = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	pdata = dev->dev.platform_data;
+
+	release_mem_region(res_base->start,
+			   res_base->end - res_base->start + 1);
+
+	if (pdata->flags & PLATIDE_SEPERATE_CONTROL_REGION) {
+		res_alt = platform_get_resource(dev, IORESOURCE_MEM, 1);
+		release_mem_region(res_alt->start,
+				   res_alt->end - res_alt->start + 1);
+	}
+
+	platform_set_drvdata(dev, NULL);
+
+	/* there must be a better way */
+	ide_unregister(hwif - ide_hwifs);
+
+	iounmap(platide_mapbase);
+	iounmap(platide_alt_mapbase);
+
+	return 0;
+}
+
+static struct platform_driver platide_driver = {
+	.probe = platide_lbus_probe,
+	.remove = __devexit_p(platide_lbus_remove),
+	.driver = {
+		   .name = "platide",
+		   },
+};
+
+static int __init platide_lbus_init(void)
+{
+	return platform_driver_register(&platide_driver);
+}
+
+static void __exit platide_lbus_exit(void)
+{
+	platform_driver_unregister(&platide_driver);
+}
+
+MODULE_AUTHOR("Kumar Gala");
+MODULE_DESCRIPTION("Simple Platform IDE Driver");
+MODULE_LICENSE("GPL");
+
+module_init(platide_lbus_init);
+module_exit(platide_lbus_exit);
diff --git a/include/linux/ide.h b/include/linux/ide.h
index 8d2db41..893e584 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1375,4 +1375,13 @@ static inline int hwif_to_node(ide_hwif_
 	return dev ? pcibus_to_node(dev->bus) : -1;
 }
 
+struct ide_platform_data {
+	u32 flags;
+#define PLATIDE_SEPERATE_CONTROL_REGION	0x00000001
+	u32 data_reg_offset;
+	u32 reg_offset;
+	u32 ctrl_reg_offset;
+	u32 stride;
+};
+
 #endif /* _IDE_H */

