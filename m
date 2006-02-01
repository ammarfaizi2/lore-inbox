Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWBAH1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWBAH1V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 02:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWBAH1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 02:27:20 -0500
Received: from gate.crashing.org ([63.228.1.57]:4017 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751407AbWBAH1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 02:27:06 -0500
Date: Wed, 1 Feb 2006 01:19:15 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
cc: linux-ide@vger.kernel.org, <linux-kernel@vger.kernel.org>
Subject: RFC: Compact Flash True IDE Mode Driver
Message-ID: <Pine.LNX.4.44.0602010113210.5670-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was hoping to get some comments on this work in progress driver for
using a compact flash device running in True IDE Mode connect via a MMIO
interface.  The driver is working, however the embedded system I'm running
on need some HW fixes to address the fact that the byte lanes for the data
are swapped.  I figured now was a good time to incorporate any changes
while I wait for the HW fixes (which will allow me to remove the 
cfide_outsw & cfide_insw).

- kumar


diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index 1c81174..8334baf 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -930,6 +930,12 @@ config BLK_DEV_Q40IDE
 	  normally be on; disable it only if you are running a custom hard
 	  drive subsystem through an expansion card.
 
+config BLK_DEV_CFIDE
+	tristate "Compact Flash in True IDE mode"
+	help
+	  This is the IDE driver for a Memory Mapped Compact Flash Device
+	  running in True IDE mode.
+
 config BLK_DEV_MPC8xx_IDE
 	bool "MPC8xx IDE support"
 	depends on 8xx && IDE=y && BLK_DEV_IDE=y
diff --git a/drivers/ide/Makefile b/drivers/ide/Makefile
index 569fae7..09ed3aa 100644
--- a/drivers/ide/Makefile
+++ b/drivers/ide/Makefile
@@ -32,6 +32,7 @@ ide-core-$(CONFIG_BLK_DEV_FALCON_IDE)	+=
 ide-core-$(CONFIG_BLK_DEV_GAYLE)	+= legacy/gayle.o
 ide-core-$(CONFIG_BLK_DEV_MAC_IDE)	+= legacy/macide.o
 ide-core-$(CONFIG_BLK_DEV_Q40IDE)	+= legacy/q40ide.o
+ide-core-$(CONFIG_BLK_DEV_CFIDE)	+= legacy/cfide.o
 
 # built-in only drivers from ppc/
 ide-core-$(CONFIG_BLK_DEV_MPC8xx_IDE)	+= ppc/mpc8xx.o
diff --git a/drivers/ide/legacy/cfide.c b/drivers/ide/legacy/cfide.c
new file mode 100644
index 0000000..4444005
--- /dev/null
+++ b/drivers/ide/legacy/cfide.c
@@ -0,0 +1,222 @@
+/*
+ * Compact Flash Memory Mapped True IDE mode driver
+ *
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/ide.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <asm/io.h>
+#include <asm/byteorder.h>
+
+static void __iomem *cfide_mapbase;
+static void __iomem *cfide_alt_mapbase;
+
+/* xxx: use standard outsw, insw when byte lanes swapped */
+static void cfide_outsw(unsigned long port, void *addr, u32 count)
+{
+	_outsw((volatile u16 __iomem *)port, addr, count);
+}
+
+static void cfide_insw(unsigned long port, void *addr, u32 count)
+{
+	_insw((volatile u16 __iomem *)port, addr, count);
+}
+
+static void cfide_outl(u32 addr, unsigned long port)
+{
+	panic("outl unsupported");
+}
+
+static void cfide_outsl(unsigned long port, void *addr, u32 count)
+{
+	panic("outsl unsupported");
+}
+
+static u32 cfide_inl(unsigned long port)
+{
+	panic("inl unsupported");
+	return 0;
+}
+
+static void cfide_insl(unsigned long port, void *addr, u32 count)
+{
+	panic("insl unsupported");
+}
+
+static ide_hwif_t *cfide_locate_hwif(void __iomem * base, void __iomem * ctrl,
+				     unsigned int sz, int irq)
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
+
+	/* xxx: fix when byte lanes are swapped */
+	hwif->hw.io_ports[IDE_DATA_OFFSET] = port;
+	port += 3;
+	for (i = IDE_ERROR_OFFSET; i <= IDE_STATUS_OFFSET; i++, port += sz)
+		hwif->hw.io_ports[i] = port;
+
+	hwif->hw.io_ports[IDE_CONTROL_OFFSET] = (unsigned long)ctrl + 13;
+
+	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->hw.io_ports));
+	hwif->hw.irq = hwif->irq = irq;
+
+	hwif->hw.dma = NO_DMA;
+	hwif->hw.chipset = ide_unknown;
+
+	hwif->mmio = 2;
+	default_hwif_mmiops(hwif);
+	hwif->OUTL = cfide_outl;
+	hwif->OUTSW = cfide_outsw;
+	hwif->OUTSL = cfide_outsl;
+	hwif->INL = cfide_inl;
+	hwif->INSW = cfide_insw;
+	hwif->INSL = cfide_insl;
+
+	return hwif;
+}
+
+static int __devinit cfide_lbus_probe(struct platform_device *dev)
+{
+	struct resource *res_base, *res_alt, *res_irq;
+	ide_hwif_t *hwif;
+	int ret = 0;
+
+	/* get a pointer to the register memory */
+	res_base = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	res_alt = platform_get_resource(dev, IORESOURCE_MEM, 1);
+	res_irq = platform_get_resource(dev, IORESOURCE_IRQ, 0);
+
+	if ((!res_base) || (!res_alt) || (!res_irq)) {
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
+	if (!request_mem_region
+	    (res_alt->start, res_alt->end - res_alt->start + 1, dev->name)) {
+		pr_debug("%s: request_mem_region of alt failed\n", dev->name);
+		ret = -EBUSY;
+		goto out;
+	}
+
+	cfide_mapbase =
+	    ioremap(res_base->start, res_base->end - res_base->start + 1);
+	if (!cfide_mapbase) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cfide_alt_mapbase =
+	    ioremap(res_alt->start, res_alt->end - res_alt->start + 1);
+
+	if (!cfide_alt_mapbase) {
+		ret = -ENOMEM;
+		goto unmap_base;
+	}
+
+	hwif = cfide_locate_hwif(cfide_mapbase, cfide_alt_mapbase, 2,
+			      res_irq->start);
+
+	if (!hwif) {
+		ret = -ENODEV;
+		goto unmap_alt;
+	}
+
+	hwif->gendev.parent = &dev->dev;
+	hwif->noprobe = 0;
+
+	probe_hwif_init(hwif);
+
+	platform_set_drvdata(dev, hwif);
+
+	return 0;
+
+ unmap_alt:
+	iounmap(cfide_alt_mapbase);
+ unmap_base:
+	iounmap(cfide_mapbase);
+ out:
+	return ret;
+}
+
+static int __devexit cfide_lbus_remove(struct platform_device *dev)
+{
+	ide_hwif_t *hwif = platform_get_drvdata(dev);
+	struct resource *res_base, *res_alt;
+
+	/* get a pointer to the register memory */
+	res_base = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	res_alt = platform_get_resource(dev, IORESOURCE_MEM, 1);
+
+	release_mem_region(res_base->start, res_base->end - res_base->start + 1);
+	release_mem_region(res_alt->start, res_alt->end - res_alt->start + 1);
+
+	platform_set_drvdata(dev, NULL);
+
+	/* there must be a better way */
+	ide_unregister(hwif - ide_hwifs);
+
+	iounmap(cfide_mapbase);
+	iounmap(cfide_alt_mapbase);
+
+	return 0;
+}
+
+static struct platform_driver cfide_driver = {
+	.probe = cfide_lbus_probe,
+	.remove = __devexit_p(cfide_lbus_remove),
+	.driver = {
+		   .name = "mmio-cfide",
+		   },
+};
+
+static int __init cfide_lbus_init(void)
+{
+	return platform_driver_register(&cfide_driver);
+}
+
+static void __exit cfide_lbus_exit(void)
+{
+	platform_driver_unregister(&cfide_driver);
+}
+
+MODULE_DESCRIPTION("MMIO based True IDE Mode Compact Flash Driver");
+MODULE_LICENSE("GPL");
+
+module_init(cfide_lbus_init);
+module_exit(cfide_lbus_exit);

