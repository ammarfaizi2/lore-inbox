Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbWESWUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWESWUr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 18:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWESWUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 18:20:47 -0400
Received: from the.earth.li ([193.201.200.66]:20698 "EHLO the.earth.li")
	by vger.kernel.org with ESMTP id S1751237AbWESWUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 18:20:46 -0400
Date: Fri, 19 May 2006 23:20:45 +0100
From: Jonathan McDowell <noodles@earth.li>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Add Amstrad Delta NAND support.
Message-ID: <20060519222045.GH7570@earth.li>
References: <20060518160940.GS7570@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060518160940.GS7570@earth.li>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2006 at 05:09:40PM +0100, Jonathan McDowell wrote:
> The patch below adds support for the NAND device on the Amstrad Delta.
> This is a 32MB 8bit Toshiba device, with the data bus connected to the
> OMAP MPUIO pins and ALE, CLE, NCE, NRE, NWE and NWP all connected to the
> Delta's latch2 16bit latch.
> 
> This is the same patch as submitted to linux-mtd for comments a month
> ago, with 3 changes:
> 
>  * Set ams_delta_mtd->owner = THIS_MODULE; before calling nand_scan()
>  * Remove spurious comment.
>  * Lower udelay length.

Ok, taking the comments on board let's try again.

 * Use ndelay(40) instead of udelay(0.04). This will involve a longer
   delay, but works fine and will take advantage of ndelay once ARM
   stops using the generic fallback.
 * Fixup errant spacing.
 * Make ams_delta_init static.

Signed-Off-By: Jonathan McDowell <noodles@earth.li>

-----
diff -ruN linux-2.6.17-rc4/drivers/mtd/nand/ams-delta.c linux-2.6.17-rc4-e3-nand/drivers/mtd/nand/ams-delta.c
--- linux-2.6.17-rc4/drivers/mtd/nand/ams-delta.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc4-e3-nand/drivers/mtd/nand/ams-delta.c	2006-05-19 23:08:42.000000000 +0100
@@ -0,0 +1,239 @@
+/*
+ *  drivers/mtd/nand/ams-delta.c
+ *
+ *  Copyright (C) 2006 Jonathan McDowell <noodles@earth.li>
+ *
+ *  Derived from drivers/mtd/toto.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ *  Overview:
+ *   This is a device driver for the NAND flash device found on the
+ *   Amstrad E3 (Delta).
+ */
+
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/partitions.h>
+#include <asm/io.h>
+#include <asm/arch/hardware.h>
+#include <asm/sizes.h>
+#include <asm/arch/gpio.h>
+#include <asm/arch/board-ams-delta.h>
+
+/*
+ * MTD structure for E3 (Delta)
+ */
+static struct mtd_info *ams_delta_mtd = NULL;
+
+#define NAND_MASK (AMS_DELTA_LATCH2_NAND_NRE | AMS_DELTA_LATCH2_NAND_NWE | AMS_DELTA_LATCH2_NAND_CLE | AMS_DELTA_LATCH2_NAND_ALE | AMS_DELTA_LATCH2_NAND_NCE | AMS_DELTA_LATCH2_NAND_NWP)
+
+#define T_NAND_CTL_CLRALE(iob) ams_delta_latch2_write(AMS_DELTA_LATCH2_NAND_ALE, 0)
+#define T_NAND_CTL_SETALE(iob) ams_delta_latch2_write(AMS_DELTA_LATCH2_NAND_ALE, AMS_DELTA_LATCH2_NAND_ALE)
+#define T_NAND_CTL_CLRCLE(iob) ams_delta_latch2_write(AMS_DELTA_LATCH2_NAND_CLE, 0)
+#define T_NAND_CTL_SETCLE(iob) ams_delta_latch2_write(AMS_DELTA_LATCH2_NAND_CLE, AMS_DELTA_LATCH2_NAND_CLE)
+#define T_NAND_CTL_SETNCE(iob) ams_delta_latch2_write(AMS_DELTA_LATCH2_NAND_NCE, 0)
+#define T_NAND_CTL_CLRNCE(iob) ams_delta_latch2_write(AMS_DELTA_LATCH2_NAND_NCE, AMS_DELTA_LATCH2_NAND_NCE)
+
+/*
+ * Define partitions for flash devices
+ */
+
+static struct mtd_partition partition_info[] = {
+	{ .name		= "Kernel",
+	  .offset	= 0,
+	  .size		= 3 * SZ_1M + SZ_512K },
+	{ .name		= "u-boot",
+	  .offset	= 3 * SZ_1M + SZ_512K,
+	  .size		= SZ_256K },
+	{ .name		= "u-boot params",
+	  .offset	= 3 * SZ_1M + SZ_512K + SZ_256K,
+	  .size		= SZ_256K },
+	{ .name		= "Amstrad LDR",
+	  .offset	= 4 * SZ_1M,
+	  .size		= SZ_256K },
+	{ .name		= "File system",
+	  .offset	= 4 * SZ_1M + 1 * SZ_256K,
+	  .size		= 27 * SZ_1M },
+	{ .name		= "PBL reserved",
+	  .offset	= 32 * SZ_1M - 3 * SZ_256K,
+	  .size		=  3 * SZ_256K },
+};
+
+/*
+ *	hardware specific access to control-lines
+*/
+
+static void ams_delta_hwcontrol(struct mtd_info *mtd, int cmd)
+{
+	switch (cmd) {
+
+		case NAND_CTL_SETCLE: T_NAND_CTL_SETCLE(cmd); break;
+		case NAND_CTL_CLRCLE: T_NAND_CTL_CLRCLE(cmd); break;
+
+		case NAND_CTL_SETALE: T_NAND_CTL_SETALE(cmd); break;
+		case NAND_CTL_CLRALE: T_NAND_CTL_CLRALE(cmd); break;
+
+		case NAND_CTL_SETNCE: T_NAND_CTL_SETNCE(cmd); break;
+		case NAND_CTL_CLRNCE: T_NAND_CTL_CLRNCE(cmd); break;
+	}
+}
+
+static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
+{
+	struct nand_chip *this = mtd->priv;
+
+	omap_writew(0, (OMAP_MPUIO_BASE + OMAP_MPUIO_IO_CNTL));
+	omap_writew(byte, this->IO_ADDR_W);
+	ams_delta_latch2_write(AMS_DELTA_LATCH2_NAND_NWE, 0);
+	ndelay(40);
+	ams_delta_latch2_write(AMS_DELTA_LATCH2_NAND_NWE,
+			AMS_DELTA_LATCH2_NAND_NWE);
+}
+
+static u_char ams_delta_read_byte(struct mtd_info *mtd)
+{
+	u_char res;
+	struct nand_chip *this = mtd->priv;
+
+	ams_delta_latch2_write(AMS_DELTA_LATCH2_NAND_NRE, 0);
+	ndelay(40);
+	omap_writew(~0, (OMAP_MPUIO_BASE + OMAP_MPUIO_IO_CNTL));
+	res = omap_readw(this->IO_ADDR_R);
+	ams_delta_latch2_write(AMS_DELTA_LATCH2_NAND_NRE,
+			AMS_DELTA_LATCH2_NAND_NRE);
+
+	return res;
+}
+
+static void ams_delta_write_buf(struct mtd_info *mtd, const u_char *buf,
+		int len)
+{
+	int i;
+
+	for (i=0; i<len; i++)
+		ams_delta_write_byte(mtd, buf[i]);
+}
+
+static void ams_delta_read_buf(struct mtd_info *mtd, u_char *buf, int len)
+{
+	int i;
+
+	for (i=0; i<len; i++)
+		buf[i] = ams_delta_read_byte(mtd);
+}
+
+static int ams_delta_verify_buf(struct mtd_info *mtd, const u_char *buf,
+		int len)
+{
+	int i;
+
+	for (i=0; i<len; i++)
+		if (buf[i] != ams_delta_read_byte(mtd))
+			return -EFAULT;
+
+	return 0;
+}
+
+static int ams_delta_nand_ready(struct mtd_info *mtd)
+{
+	return omap_get_gpio_datain(AMS_DELTA_GPIO_PIN_NAND_RB);
+}
+
+/*
+ * Main initialization routine
+ */
+static int __init ams_delta_init(void)
+{
+	struct nand_chip *this;
+	int err = 0;
+
+	/* Allocate memory for MTD device structure and private data */
+	ams_delta_mtd = kmalloc(sizeof(struct mtd_info) +
+					sizeof (struct nand_chip), GFP_KERNEL);
+	if (!ams_delta_mtd) {
+		printk (KERN_WARNING
+			"Unable to allocate E3 NAND MTD device structure.\n");
+		err = -ENOMEM;
+		goto out;
+	}
+
+	ams_delta_mtd->owner = THIS_MODULE;
+
+	/* Get pointer to private data */
+	this = (struct nand_chip *) (&ams_delta_mtd[1]);
+
+	/* Initialize structures */
+	memset((char *) ams_delta_mtd, 0, sizeof(struct mtd_info));
+	memset((char *) this, 0, sizeof(struct nand_chip));
+
+	/* Link the private data with the MTD structure */
+	ams_delta_mtd->priv = this;
+
+	/* Set address of NAND IO lines */
+	this->IO_ADDR_R = (OMAP_MPUIO_BASE + OMAP_MPUIO_INPUT_LATCH);
+	this->IO_ADDR_W = (OMAP_MPUIO_BASE + OMAP_MPUIO_OUTPUT);
+	this->read_byte = ams_delta_read_byte;
+	this->write_byte = ams_delta_write_byte;
+	this->write_buf = ams_delta_write_buf;
+	this->read_buf = ams_delta_read_buf;
+	this->verify_buf = ams_delta_verify_buf;
+	this->hwcontrol = ams_delta_hwcontrol;
+	if (!omap_request_gpio(AMS_DELTA_GPIO_PIN_NAND_RB)) {
+		this->dev_ready = ams_delta_nand_ready;
+	} else {
+		this->dev_ready = NULL;
+		printk(KERN_NOTICE
+			"Couldn't request gpio for Delta NAND ready.\n");
+	}
+	/* 25 us command delay time */
+	this->chip_delay = 30;
+	this->eccmode = NAND_ECC_SOFT;
+
+	/* Set chip enabled, but  */
+	ams_delta_latch2_write(NAND_MASK, AMS_DELTA_LATCH2_NAND_NRE | \
+			AMS_DELTA_LATCH2_NAND_NWE | \
+			AMS_DELTA_LATCH2_NAND_NCE | AMS_DELTA_LATCH2_NAND_NWP);
+
+        /* Scan to find existance of the device */
+	if (nand_scan(ams_delta_mtd, 1)) {
+		err = -ENXIO;
+		goto out_mtd;
+	}
+
+	/* Register the partitions */
+	add_mtd_partitions(ams_delta_mtd, partition_info,
+			ARRAY_SIZE(partition_info));
+
+	goto out;
+
+out_mtd:
+	kfree(ams_delta_mtd);
+out:
+	return err;
+}
+
+module_init(ams_delta_init);
+
+/*
+ * Clean up routine
+ */
+static void __exit ams_delta_cleanup(void)
+{
+	/* Release resources, unregister device */
+	nand_release(ams_delta_mtd);
+
+	/* Free the MTD device structure */
+	kfree(ams_delta_mtd);
+}
+module_exit(ams_delta_cleanup);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jonathan McDowell <noodles@earth.li>");
+MODULE_DESCRIPTION("Glue layer for NAND flash on Amstrad E3 (Delta)");
diff -ruN linux-2.6.17-rc4/drivers/mtd/nand/Kconfig linux-2.6.17-rc4-e3-nand/drivers/mtd/nand/Kconfig
--- linux-2.6.17-rc4/drivers/mtd/nand/Kconfig	2006-05-18 16:56:39.000000000 +0100
+++ linux-2.6.17-rc4-e3-nand/drivers/mtd/nand/Kconfig	2006-05-18 17:03:29.000000000 +0100
@@ -49,6 +49,12 @@
 	help
 	  If you had to ask, you don't have one. Say 'N'.
 
+config MTD_NAND_AMS_DELTA
+	tristate "NAND Flash device on Amstrad E3"
+	depends on MACH_AMS_DELTA && MTD_NAND
+	help
+	  Support for NAND flash on Amstrad E3 (Delta).
+
 config MTD_NAND_TOTO
 	tristate "NAND Flash device on TOTO board"
 	depends on ARCH_OMAP && MTD_NAND
diff -ruN linux-2.6.17-rc4/drivers/mtd/nand/Makefile linux-2.6.17-rc4-e3-nand/drivers/mtd/nand/Makefile
--- linux-2.6.17-rc4/drivers/mtd/nand/Makefile	2006-01-03 03:21:10.000000000 +0000
+++ linux-2.6.17-rc4-e3-nand/drivers/mtd/nand/Makefile	2006-05-18 17:03:47.000000000 +0100
@@ -7,6 +7,7 @@
 obj-$(CONFIG_MTD_NAND_IDS)		+= nand_ids.o
 
 obj-$(CONFIG_MTD_NAND_SPIA)		+= spia.o
+obj-$(CONFIG_MTD_NAND_AMS_DELTA)	+= ams-delta.o
 obj-$(CONFIG_MTD_NAND_TOTO)		+= toto.o
 obj-$(CONFIG_MTD_NAND_AUTCPU12)		+= autcpu12.o
 obj-$(CONFIG_MTD_NAND_EDB7312)		+= edb7312.o
-----

J.

-- 
"Scattered f***ing showers my ass." -- Noah
