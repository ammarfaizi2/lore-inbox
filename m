Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWEGOjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWEGOjh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 10:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWEGOil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 10:38:41 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:28901
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S932077AbWEGOii
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 10:38:38 -0400
X-Mailbox-Line: From mb@pc1 Sun May  7 16:42:58 2006
Message-Id: <20060507144257.950598000@pc1>
References: <20060507143806.465264000@pc1>
Date: Sun, 07 May 2006 16:38:11 +0200
To: akpm@osdl.org
Cc: Deepak Saxena <dsaxena@plexity.net>, bcm43xx-dev@lists.berlios.de,
       linux-kernel@vger.kernel.org, Sergey Vlasov <vsu@altlinux.ru>
Subject: [patch 5/6] New Generic HW RNG (#2)
Content-Disposition: inline; filename=add-omap-hw-random.patch
From: Michael Buesch <mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add H/W RNG driver for TI OMAP CPU family.
Driver written by Deepak Saxena.

Signed-off-by: Michael Buesch <mb@bu3sch.de>
Index: hwrng/drivers/char/hw_random/Kconfig
===================================================================
--- hwrng.orig/drivers/char/hw_random/Kconfig	2006-05-07 15:50:25.000000000 +0200
+++ hwrng/drivers/char/hw_random/Kconfig	2006-05-07 15:50:29.000000000 +0200
@@ -34,3 +34,16 @@
 	  module will be called ixp4xx-rng.
 
 	  If unsure, say Y.
+
+config OMAP_RNG
+	tristate "OMAP Random Number Generator support"
+	depends on HW_RANDOM && (ARCH_OMAP16XX || ARCH_OMAP24XX)
+ 	---help---
+ 	  This driver provides kernel-side support for the Random Number
+	  Generator hardware found on OMAP16xx and OMAP24xx multimedia
+	  processors.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called omap-rng.
+
+ 	  If unsure, say Y.
Index: hwrng/drivers/char/hw_random/Makefile
===================================================================
--- hwrng.orig/drivers/char/hw_random/Makefile	2006-05-07 15:50:25.000000000 +0200
+++ hwrng/drivers/char/hw_random/Makefile	2006-05-07 15:50:29.000000000 +0200
@@ -5,3 +5,4 @@
 obj-$(CONFIG_HW_RANDOM) += core.o
 obj-$(CONFIG_X86_RNG) += x86-rng.o
 obj-$(CONFIG_IXP4XX_RNG) += ixp4xx-rng.o
+obj-$(CONFIG_OMAP_RNG) += omap-rng.o
Index: hwrng/drivers/char/hw_random/omap-rng.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ hwrng/drivers/char/hw_random/omap-rng.c	2006-05-07 15:50:29.000000000 +0200
@@ -0,0 +1,208 @@
+/*
+ * driver/char/hw_random/omap-rng.c
+ *
+ * RNG driver for TI OMAP CPU family
+ *
+ * Author: Deepak Saxena <dsaxena@plexity.net>
+ *
+ * Copyright 2005 (c) MontaVista Software, Inc.
+ *
+ * Mostly based on original driver:
+ *
+ * Copyright (C) 2005 Nokia Corporation
+ * Author: Juha Yrj��<juha.yrjola@nokia.com>
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * TODO:
+ *
+ * - Make status updated be interrupt driven so we don't poll
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/random.h>
+#include <linux/err.h>
+#include <linux/device.h>
+#include <linux/hw_random.h>
+
+#include <asm/io.h>
+#include <asm/hardware/clock.h>
+
+#define RNG_OUT_REG		0x00		/* Output register */
+#define RNG_STAT_REG		0x04		/* Status register
+							[0] = STAT_BUSY */
+#define RNG_ALARM_REG		0x24		/* Alarm register
+							[7:0] = ALARM_COUNTER */
+#define RNG_CONFIG_REG		0x28		/* Configuration register
+							[11:6] = RESET_COUNT
+							[5:3]  = RING2_DELAY
+							[2:0]  = RING1_DELAY */
+#define RNG_REV_REG		0x3c		/* Revision register
+							[7:0] = REV_NB */
+#define RNG_MASK_REG		0x40		/* Mask and reset register
+							[2] = IT_EN
+							[1] = SOFTRESET
+							[0] = AUTOIDLE */
+#define RNG_SYSSTATUS		0x44		/* System status
+							[0] = RESETDONE */
+
+static void __iomem *rng_base;
+static struct clk *rng_ick;
+static struct device *rng_dev;
+
+static u32 omap_rng_read_reg(int reg)
+{
+	return __raw_readl(rng_base + reg);
+}
+
+static void omap_rng_write_reg(int reg, u32 val)
+{
+	__raw_writel(val, rng_base + reg);
+}
+
+/* REVISIT: Does the status bit really work on 16xx? */
+static int omap_rng_data_present(struct hwrng *rng)
+{
+	return omap_rng_read_reg(RNG_STAT_REG) ? 0 : 1;
+}
+
+static int omap_rng_data_read(struct hwrng *rng, u32 *data)
+{
+	*data = omap_rng_read_reg(RNG_OUT_REG);
+
+	return 4;
+}
+
+static struct hwrng omap_rng_ops = {
+	.name		= "omap",
+	.data_present	= omap_rng_data_present,
+	.data_read	= omap_rng_data_read,
+};
+
+static int __init omap_rng_probe(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct resource *res, *mem;
+	int ret;
+
+	/*
+	 * A bit ugly, and it will never actually happen but there can
+	 * be only one RNG and this catches any bork
+	 */
+	BUG_ON(rng_dev);
+
+    	if (cpu_is_omap24xx()) {
+		rng_ick = clk_get(NULL, "rng_ick");
+		if (IS_ERR(rng_ick)) {
+			dev_err(dev, "Could not get rng_ick\n");
+			ret = PTR_ERR(rng_ick);
+			return ret;
+		}
+		else {
+			clk_use(rng_ick);
+		}
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	if (!res)
+		return -ENOENT;
+
+	mem = request_mem_region(res->start, res->end - res->start + 1,
+				 pdev->name);
+	if (mem == NULL)
+		return -EBUSY;
+
+	dev_set_drvdata(dev, mem);
+	rng_base = (u32 __iomem *)io_p2v(res->start);
+
+	ret = hwrng_register(&omap_rng_ops);
+	if (ret) {
+		release_resource(mem);
+		rng_base = NULL;
+		return ret;
+	}
+
+	dev_info(dev, "OMAP Random Number Generator ver. %02x\n",
+		omap_rng_read_reg(RNG_REV_REG));
+	omap_rng_write_reg(RNG_MASK_REG, 0x1);
+
+	rng_dev = dev;
+
+	return 0;
+}
+
+static int __exit omap_rng_remove(struct device *dev)
+{
+	struct resource *mem = dev_get_drvdata(dev);
+
+	hwrng_unregister(&omap_rng_ops);
+
+	omap_rng_write_reg(RNG_MASK_REG, 0x0);
+
+	if (cpu_is_omap24xx()) {
+		clk_unuse(rng_ick);
+		clk_put(rng_ick);
+	}
+
+	release_resource(mem);
+	rng_base = NULL;
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+
+static int omap_rng_suspend(struct device *dev, pm_message_t message, u32 level)
+{
+	omap_rng_write_reg(RNG_MASK_REG, 0x0);
+
+	return 0;
+}
+
+static int omap_rng_resume(struct device *dev, pm_message_t message, u32 level)
+{
+	omap_rng_write_reg(RNG_MASK_REG, 0x1);
+
+	return 1;
+}
+
+#else
+
+#define	omap_rng_suspend	NULL
+#define	omap_rng_resume		NULL
+
+#endif
+
+
+static struct device_driver omap_rng_driver = {
+	.name		= "omap_rng",
+	.bus		= &platform_bus_type,
+	.probe		= omap_rng_probe,
+	.remove		= __exit_p(omap_rng_remove),
+	.suspend	= omap_rng_suspend,
+	.resume		= omap_rng_resume
+};
+
+static int __init omap_rng_init(void)
+{
+	if (!cpu_is_omap16xx() && !cpu_is_omap24xx())
+		return -ENODEV;
+
+	return driver_register(&omap_rng_driver);
+}
+
+static void __exit omap_rng_exit(void)
+{
+	driver_unregister(&omap_rng_driver);
+}
+
+module_init(omap_rng_init);
+module_exit(omap_rng_exit);
+
+MODULE_AUTHOR("Deepak Saxena (and others)");
+MODULE_LICENSE("GPL");

--

