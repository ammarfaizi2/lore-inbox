Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269476AbUINSDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269476AbUINSDw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269640AbUINSA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:00:58 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:2255 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S269495AbUINRt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 13:49:59 -0400
Date: Tue, 14 Sep 2004 10:49:57 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       dwmw2@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Add MTD map driver for Intel IXP2000 NPU
Message-ID: <20040914174957.GB12350@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, Andrew,

The following patch adds the MTD map driver for Intel's IXP2000 NPU. 
The driver is already in MTD CVS and I've gotten the OK from David 
to push it upstream.

Please apply,
~Deepak

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

diff -uNr -X dontdiff linux-2.6-rmk/drivers/mtd/maps/Makefile linux-2.5-bk/drivers/mtd/maps/Makefile
--- linux-2.6-rmk/drivers/mtd/maps/Makefile	2004-09-13 16:55:03.000000000 -0700
+++ linux-2.5-bk/drivers/mtd/maps/Makefile	2004-09-14 10:26:25.000000000 -0700
@@ -62,5 +62,6 @@
 obj-$(CONFIG_MTD_NOR_TOTO)	+= omap-toto-flash.o
 obj-$(CONFIG_MTD_MPC1211)	+= mpc1211.o
 obj-$(CONFIG_MTD_IXP4XX)	+= ixp4xx.o
+obj-$(CONFIG_MTD_IXP2000)	+= ixp2000.o
 obj-$(CONFIG_MTD_WRSBC8260)	+= wr_sbc82xx_flash.o
 obj-$(CONFIG_MTD_DMV182)	+= dmv182.o
diff -uNr -X dontdiff linux-2.6-rmk/drivers/mtd/maps/ixp2000.c linux-2.5-bk/drivers/mtd/maps/ixp2000.c
--- linux-2.6-rmk/drivers/mtd/maps/ixp2000.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.5-bk/drivers/mtd/maps/ixp2000.c	2004-09-14 10:26:31.000000000 -0700
@@ -0,0 +1,281 @@
+/*
+ * $Id: ixp2000.c,v 1.1 2004/09/02 00:13:41 dsaxena Exp $
+ *
+ * drivers/mtd/maps/ixp2000.c
+ *
+ * Mapping for the Intel XScale IXP2000 based systems
+ *
+ * Copyright (C) 2002 Intel Corp.
+ * Copyright (C) 2003-2004 MontaVista Software, Inc.
+ *
+ * Original Author: Naeem M Afzal <naeem.m.afzal@intel.com>
+ * Maintainer: Deepak Saxena <dsaxena@plexity.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ * 
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/map.h>
+#include <linux/mtd/partitions.h>
+#include <linux/ioport.h>
+#include <linux/device.h>
+
+#include <asm/io.h>
+#include <asm/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/mach/flash.h>
+
+#include <linux/reboot.h>
+
+struct ixp2000_flash_info {
+	struct		mtd_info *mtd;
+	struct		map_info map;
+	struct		mtd_partition *partitions;
+	struct		resource *res;
+	int		nr_banks;
+};
+
+static inline unsigned long flash_bank_setup(struct map_info *map, unsigned long ofs)
+{	
+	unsigned long (*set_bank)(unsigned long) = 
+		(unsigned long(*)(unsigned long))map->map_priv_2;
+
+	return (set_bank ? set_bank(ofs) : ofs);
+}
+
+#ifdef __ARMEB__
+/*
+ * Rev A0 and A1 of IXP2400 silicon have a broken addressing unit which 
+ * causes the lower address bits to be XORed with 0x11 on 8 bit accesses 
+ * and XORed with 0x10 on 16 bit accesses. See the spec update, erratta 44.
+ */
+static int errata44_workaround = 0;
+
+static inline unsigned long address_fix8_write(unsigned long addr)
+{
+	if (errata44_workaround) {
+		return (addr ^ 3);
+	}
+	return addr;
+}
+#else
+
+#define address_fix8_write(x)	(x)
+#endif
+
+static map_word ixp2000_flash_read8(struct map_info *map, unsigned long ofs)
+{
+	map_word val;
+
+	val.x[0] =  *((u8 *)(map->map_priv_1 + flash_bank_setup(map, ofs)));
+	return val;
+}
+
+/*
+ * We can't use the standard memcpy due to the broken SlowPort
+ * address translation on rev A0 and A1 silicon and the fact that
+ * we have banked flash.
+ */
+static void ixp2000_flash_copy_from(struct map_info *map, void *to,
+			      unsigned long from, ssize_t len)
+{
+	from = flash_bank_setup(map, from);
+	while(len--) 
+		*(__u8 *) to++ = *(__u8 *)(map->map_priv_1 + from++);
+}
+
+static void ixp2000_flash_write8(struct map_info *map, map_word d, unsigned long ofs)
+{
+	*(__u8 *) (address_fix8_write(map->map_priv_1 +
+				      flash_bank_setup(map, ofs))) = d.x[0];
+}
+
+static void ixp2000_flash_copy_to(struct map_info *map, unsigned long to,
+			    const void *from, ssize_t len)
+{
+	to = flash_bank_setup(map, to);
+	while(len--) {
+		unsigned long tmp = address_fix8_write(map->map_priv_1 + to++);
+		*(__u8 *)(tmp) = *(__u8 *)(from++);
+	}
+}
+
+
+static int ixp2000_flash_remove(struct device *_dev)
+{
+	struct platform_device *dev = to_platform_device(_dev);
+	struct flash_platform_data *plat = dev->dev.platform_data;
+	struct ixp2000_flash_info *info = dev_get_drvdata(&dev->dev);
+
+	dev_set_drvdata(&dev->dev, NULL);
+
+	if(!info)
+		return 0;
+
+	if (info->mtd) {
+		del_mtd_partitions(info->mtd);
+		map_destroy(info->mtd);
+	}
+	if (info->map.map_priv_1)
+		iounmap((void *) info->map.map_priv_1);
+
+	if (info->partitions) {
+		kfree(info->partitions); }
+
+	if (info->res) {
+		release_resource(info->res);
+		kfree(info->res);
+	}
+
+	if (plat->exit)
+		plat->exit();
+
+	return 0;
+}
+
+
+static int ixp2000_flash_probe(struct device *_dev)
+{
+	static const char *probes[] = { "RedBoot", "cmdlinepart", NULL };
+	struct platform_device *dev = to_platform_device(_dev);
+	struct ixp2000_flash_data *ixp_data = dev->dev.platform_data;
+	struct flash_platform_data *plat; 
+	struct ixp2000_flash_info *info;
+	unsigned long window_size;
+	int err = -1;
+	
+	if (!ixp_data)
+		return -ENODEV;
+
+	plat = ixp_data->platform_data;
+	if (!plat)
+		return -ENODEV;
+
+	window_size = dev->resource->end - dev->resource->start + 1;
+	dev_info(_dev, "Probe of IXP2000 flash(%d banks x %dM)\n", 
+			ixp_data->nr_banks, ((u32)window_size >> 20));
+
+	if (plat->width != 1) {
+		dev_err(_dev, "IXP2000 MTD map only supports 8-bit mode, asking for %d\n",
+				plat->width * 8);
+		return -EIO;
+	}
+
+	info = kmalloc(sizeof(struct ixp2000_flash_info), GFP_KERNEL);
+	if(!info) {
+		err = -ENOMEM;
+		goto Error;
+	}	
+	memzero(info, sizeof(struct ixp2000_flash_info));
+
+	dev_set_drvdata(&dev->dev, info);
+
+	/*
+	 * Tell the MTD layer we're not 1:1 mapped so that it does
+	 * not attempt to do a direct access on us.
+	 */
+	info->map.phys = NO_XIP;
+	
+	info->nr_banks = ixp_data->nr_banks;
+	info->map.size = ixp_data->nr_banks * window_size;
+	info->map.bankwidth = 1;
+
+	/*
+ 	 * map_priv_2 is used to store a ptr to to the bank_setup routine
+ 	 */
+	info->map.map_priv_2 = (u32) ixp_data->bank_setup;
+
+	info->map.name = dev->dev.bus_id;
+	info->map.read = ixp2000_flash_read8;
+	info->map.write = ixp2000_flash_write8;
+	info->map.copy_from = ixp2000_flash_copy_from;
+	info->map.copy_to = ixp2000_flash_copy_to;
+
+	info->res = request_mem_region(dev->resource->start, 
+			dev->resource->end - dev->resource->start + 1, 
+			dev->dev.bus_id);
+	if (!info->res) {
+		dev_err(_dev, "Could not reserve memory region\n");
+		err = -ENOMEM;
+		goto Error;
+	}
+
+	info->map.map_priv_1 =
+	    (unsigned long) ioremap(dev->resource->start, 
+				    dev->resource->end - dev->resource->start + 1);
+	if (!info->map.map_priv_1) {
+		dev_err(_dev, "Failed to ioremap flash region\n");
+		err = -EIO;
+		goto Error;
+	}
+
+	/*
+	 * Setup read mode for FLASH
+	 */
+	*IXP2000_SLOWPORT_FRM = 1;
+
+#if defined(__ARMEB__)
+	/*
+	 * Enable errata 44 workaround for NPUs with broken slowport
+	 */
+
+	errata44_workaround = ixp2000_has_broken_slowport();
+	dev_info(_dev, "Errata 44 workaround %s\n",
+	       errata44_workaround ? "enabled" : "disabled");
+#endif
+
+	info->mtd = do_map_probe(plat->map_name, &info->map);
+	if (!info->mtd) {
+		dev_err(_dev, "map_probe failed\n");
+		err = -ENXIO;
+		goto Error;
+	}
+	info->mtd->owner = THIS_MODULE;
+
+	err = parse_mtd_partitions(info->mtd, probes, &info->partitions, 0);
+	if (err > 0) {
+		err = add_mtd_partitions(info->mtd, info->partitions, err);
+		if(err)
+			dev_err(_dev, "Could not parse partitions\n");
+	}
+
+	if (err)
+		goto Error;
+
+	return 0;
+
+Error:
+	ixp2000_flash_remove(_dev);
+	return err;
+}
+
+static struct device_driver ixp2000_flash_driver = {
+	.name		= "IXP2000-Flash",
+	.bus		= &platform_bus_type,
+	.probe		= &ixp2000_flash_probe,
+	.remove		= &ixp2000_flash_remove
+};
+
+static int __init ixp2000_flash_init(void)
+{
+	return driver_register(&ixp2000_flash_driver);
+}
+
+static void __exit ixp2000_flash_exit(void)
+{
+	driver_unregister(&ixp2000_flash_driver);
+}
+
+module_init(ixp2000_flash_init);
+module_exit(ixp2000_flash_exit);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Deepak Saxena <dsaxena@plexity.net>");
+

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment
and will die here like rotten cabbages." - Number 6
