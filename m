Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWINOff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWINOff (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 10:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWINOfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 10:35:30 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:28402 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1750817AbWINOfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 10:35:10 -0400
Date: Thu, 14 Sep 2006 16:32:59 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [-mm patch 3/4] AVR32 MTD: Mapping driver for the ATSTK1000 board
Message-ID: <20060914163259.068abe6d@cad-250-152.norway.atmel.com>
In-Reply-To: <20060914163121.241dec3e@cad-250-152.norway.atmel.com>
References: <20060914162926.6c117b36@cad-250-152.norway.atmel.com>
	<20060914163026.49766346@cad-250-152.norway.atmel.com>
	<20060914163121.241dec3e@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.0-rc2 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add mapping driver for the AT49BV6416 NOR flash chip on the ATSTK1000
development board.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 drivers/mtd/maps/Kconfig     |   10 ++
 drivers/mtd/maps/Makefile    |    1 
 drivers/mtd/maps/atstk1000.c |  179 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+)

Index: linux-2.6.18-rc5-mm1/drivers/mtd/maps/Kconfig
===================================================================
--- linux-2.6.18-rc5-mm1.orig/drivers/mtd/maps/Kconfig	2006-09-07 15:56:47.000000000 +0200
+++ linux-2.6.18-rc5-mm1/drivers/mtd/maps/Kconfig	2006-09-07 16:18:47.000000000 +0200
@@ -630,5 +630,15 @@ config MTD_PLATRAM
 
 	  This selection automatically selects the map_ram driver.
 
+config MTD_ATSTK1000
+	tristate "Map driver for NOR flash on Atmel ATSTK1000"
+	depends on MTD && AVR32 && BOARD_ATSTK1000
+	select MTD_CFI
+	select MTD_CFI_AMDSTD
+	select MTD_PARTITIONS
+	help
+	  Map driver for NOR flash on the Atmel ATSTK1000 development
+	  board.
+
 endmenu
 
Index: linux-2.6.18-rc5-mm1/drivers/mtd/maps/Makefile
===================================================================
--- linux-2.6.18-rc5-mm1.orig/drivers/mtd/maps/Makefile	2006-09-07 15:56:47.000000000 +0200
+++ linux-2.6.18-rc5-mm1/drivers/mtd/maps/Makefile	2006-09-07 16:16:03.000000000 +0200
@@ -71,3 +71,4 @@ obj-$(CONFIG_MTD_PLATRAM)	+= plat-ram.o
 obj-$(CONFIG_MTD_OMAP_NOR)	+= omap_nor.o
 obj-$(CONFIG_MTD_MTX1)		+= mtx-1_flash.o
 obj-$(CONFIG_MTD_TQM834x)	+= tqm834x.o
+obj-$(CONFIG_MTD_ATSTK1000)	+= atstk1000.o
Index: linux-2.6.18-rc5-mm1/drivers/mtd/maps/atstk1000.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc5-mm1/drivers/mtd/maps/atstk1000.c	2006-09-07 16:16:03.000000000 +0200
@@ -0,0 +1,179 @@
+/*
+ * Flash memory support for the ATSTK1000 development board
+ *
+ * Copyright (C) 2006 Atmel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/map.h>
+#include <linux/mtd/partitions.h>
+
+#include <asm/io.h>
+#include <asm/arch/board.h>
+#include <asm/arch/smc.h>
+
+static struct smc_config flash_config = {
+	.ncs_read_setup		= 0,
+	.nrd_setup		= 40,
+	.ncs_write_setup	= 0,
+	.nwe_setup		= 10,
+
+	.ncs_read_pulse		= 80,
+	.nrd_pulse		= 40,
+	.ncs_write_pulse	= 65,
+	.nwe_pulse		= 55,
+
+	.read_cycle		= 120,
+	.write_cycle		= 120,
+
+	.bus_width		= 2,
+	.nrd_controlled		= 1,
+	.nwe_controlled		= 1,
+	.byte_write		= 1,
+};
+
+struct atstk1000_flash {
+	struct mtd_info		*mtd;
+	struct map_info		map;
+	unsigned int		nr_parts;
+	struct mtd_partition	*parts;
+};
+
+static const char *part_probes[] = { "cmdlinepart", NULL };
+
+static int __devinit atstk1000_flash_probe(struct platform_device *pdev)
+{
+	struct flash_platform_data *plat = pdev->dev.platform_data;
+	struct atstk1000_flash *flash;
+	struct resource *mem;
+	struct mtd_partition *parts;
+	unsigned long size;
+	int nr_parts;
+	int ret;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem)
+		return -ENXIO;
+
+	flash = kzalloc(sizeof(struct atstk1000_flash), GFP_KERNEL);
+	if (!flash)
+		return -ENOMEM;
+
+	size = mem->end - mem->start + 1;
+
+	ret = smc_set_configuration(0, &flash_config);
+	if (ret < 0)
+		goto out_free_flash;
+
+	ret = -ENOMEM;
+	flash->map.virt = ioremap(mem->start, size);
+	if (!flash->map.virt)
+		goto out_free_flash;
+	flash->map.name = pdev->dev.bus_id;
+	flash->map.phys = mem->start;
+	flash->map.size = size;
+	flash->map.bankwidth = 2;
+
+	simple_map_init(&flash->map);
+
+	ret = -ENXIO;
+	flash->mtd = do_map_probe("cfi_probe", &flash->map);
+	if (!flash->mtd)
+		goto out_unmap_mem;
+	flash->mtd->owner = THIS_MODULE;
+
+	if (flash->mtd->unlock) {
+		printk("ATSTK1000 flash: unlocking area 0x%08lx-0x%08lx\n",
+		       (unsigned long)mem->start, (unsigned long)mem->end);
+		ret = flash->mtd->unlock(flash->mtd, mem->start, size);
+		if (ret < 0)
+			goto out_destroy_map;
+	}
+
+	nr_parts = parse_mtd_partitions(flash->mtd, part_probes, &parts, 0);
+	if (nr_parts > 0) {
+		flash->parts = parts;
+	} else if (plat) {
+		parts = plat->parts;
+		nr_parts = plat->nr_parts;
+	}
+	if (nr_parts <= 0) {
+		printk(KERN_NOTICE "ATSTK1000 flash: no partition info "
+		       "available, registering whole flash\n");
+		add_mtd_device(flash->mtd);
+	} else {
+		ret = add_mtd_partitions(flash->mtd, parts, nr_parts);
+		if (ret < 0)
+			goto out_free_parts;
+	}
+
+	flash->nr_parts = nr_parts;
+
+	platform_set_drvdata(pdev, flash);
+	return 0;
+
+out_free_parts:
+	kfree(flash->parts);
+out_destroy_map:
+	map_destroy(flash->mtd);
+out_unmap_mem:
+	iounmap(flash->map.virt);
+out_free_flash:
+	kfree(flash);
+	return ret;
+}
+
+static int __devexit atstk1000_flash_remove(struct platform_device *pdev)
+{
+	struct atstk1000_flash *flash = platform_get_drvdata(pdev);
+
+	if (flash->mtd) {
+		if (flash->nr_parts > 0)
+			del_mtd_partitions(flash->mtd);
+		else
+			del_mtd_device(flash->mtd);
+
+		kfree(flash->parts);
+
+		map_destroy(flash->mtd);
+		iounmap(flash->map.virt);
+		kfree(flash);
+	}
+
+	platform_set_drvdata(pdev, NULL);
+	return 0;
+}
+
+static struct platform_driver atstk1000_flash_driver = {
+	.probe	= atstk1000_flash_probe,
+	.remove	= __devexit_p(atstk1000_flash_remove),
+	.driver	= {
+		.name	= "atstk1000-flash",
+	},
+};
+
+static int __init atstk1000_flash_init(void)
+{
+	return platform_driver_register(&atstk1000_flash_driver);
+}
+
+static void __exit atstk1000_flash_exit(void)
+{
+	platform_driver_unregister(&atstk1000_flash_driver);
+}
+
+module_init(atstk1000_flash_init);
+module_exit(atstk1000_flash_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MTD NOR map driver for the ATSTK1000 board");
+MODULE_AUTHOR("Haavard Skinnemoen <hskinnemoen@atmel.com>");
