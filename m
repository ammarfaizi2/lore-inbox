Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbVJSJSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbVJSJSB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 05:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbVJSJRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 05:17:40 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:48003 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932486AbVJSJRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 05:17:15 -0400
Message-Id: <20051019091717.773678000@omelas>
References: <20051019081906.615365000@omelas>
Date: Wed, 19 Oct 2005 01:19:11 -0700
From: dsaxena@plexity.net
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.net, akpm@osdl.org, tony@atomide.com
Subject: [patch 5/5] TI OMAP driver
Content-Disposition: inline; filename=rng/rng_omap_driver.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the OMAP RNG driver. 

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

---

Builts but untested as I do not hardware. 

Index: linux-omap-2.6/drivers/char/rng/omap-rng.c
===================================================================
--- /dev/null
+++ linux-omap-2.6/drivers/char/rng/omap-rng.c
@@ -0,0 +1,208 @@
+/*
+ * driver/char/rng/omap-rng.c
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
+ * Author: Juha Yrj�l� <juha.yrjola@nokia.com>
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
+
+#include <asm/io.h>
+#include <asm/hardware/clock.h>
+
+#include "rng.h"
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
+static u32 __iomem *rng_base;
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
+static int omap_rng_data_present(void)
+{
+	return omap_rng_read_reg(RNG_STAT_REG);
+}
+
+static int omap_rng_data_read(u32 *data)
+{
+	*data = omap_rng_read_reg(RNG_OUT_REG);
+
+	return 4;
+}
+
+static struct rng_operations omap_rng_ops = {
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
+	if (rng_dev)
+		BUG();
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
+	ret = register_rng(&omap_rng_ops);
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
+	unregister_rng(&omap_rng_ops);
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
+static int omap_rng_suspend(struct device *dev, pm_message_t message, u32 level)
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
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
