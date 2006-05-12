Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWELKcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWELKcI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 06:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWELKb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 06:31:57 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:57806
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751152AbWELKbr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 06:31:47 -0400
X-Mailbox-Line: From mb@bu3sch.de Fri May 12 12:36:48 2006
Message-Id: <20060512103648.637733000@bu3sch.de>
References: <20060512103522.898597000@bu3sch.de>
User-Agent: quilt/0.45-1
Date: Fri, 12 May 2006 12:35:29 +0200
From: mb@bu3sch.de
To: akpm@osdl.org
Cc: Deepak Saxena <dsaxena@plexity.net>, bcm43xx-dev@lists.berlios.de,
       linux-kernel@vger.kernel.org, Sergey Vlasov <vsu@altlinux.ru>
Subject: [patch 7/9] Add ixp4xx HW RNG driver
Content-Disposition: inline; filename=add-ixp4xx-hw-random.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael Buesch <mb@bu3sch.de>
Index: hwrng/drivers/char/hw_random/Kconfig
===================================================================
--- hwrng.orig/drivers/char/hw_random/Kconfig	2006-05-08 00:12:20.000000000 +0200
+++ hwrng/drivers/char/hw_random/Kconfig	2006-05-08 00:15:58.000000000 +0200
@@ -61,3 +61,16 @@
 	  module will be called via-rng.
 
 	  If unsure, say Y.
+
+config HW_RANDOM_IXP4XX
+	tristate "Intel IXP4xx NPU HW Random Number Generator support"
+	depends on HW_RANDOM && ARCH_IXP4XX
+	default y
+	---help---
+	  This driver provides kernel-side support for the Random
+	  Number Generator hardware found on the Intel IXP4xx NPU.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ixp4xx-rng.
+
+	  If unsure, say Y.
Index: hwrng/drivers/char/hw_random/Makefile
===================================================================
--- hwrng.orig/drivers/char/hw_random/Makefile	2006-05-08 00:12:12.000000000 +0200
+++ hwrng/drivers/char/hw_random/Makefile	2006-05-08 00:15:42.000000000 +0200
@@ -7,3 +7,4 @@
 obj-$(CONFIG_HW_RANDOM_AMD) += amd-rng.o
 obj-$(CONFIG_HW_RANDOM_GEODE) += geode-rng.o
 obj-$(CONFIG_HW_RANDOM_VIA) += via-rng.o
+obj-$(CONFIG_HW_RANDOM_IXP4XX) += ixp4xx-rng.o
Index: hwrng/drivers/char/hw_random/ixp4xx-rng.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ hwrng/drivers/char/hw_random/ixp4xx-rng.c	2006-05-08 00:12:34.000000000 +0200
@@ -0,0 +1,73 @@
+/*
+ * drivers/char/rng/ixp4xx-rng.c
+ *
+ * RNG driver for Intel IXP4xx family of NPUs
+ *
+ * Author: Deepak Saxena <dsaxena@plexity.net>
+ *
+ * Copyright 2005 (c) MontaVista Software, Inc.
+ *
+ * Fixes by Michael Buesch
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/bitops.h>
+#include <linux/hw_random.h>
+
+#include <asm/io.h>
+#include <asm/hardware.h>
+
+
+static int ixp4xx_rng_data_read(struct hwrng *rng, u32 *buffer)
+{
+	void __iomem * rng_base = (void __iomem *)rng->priv;
+
+	*buffer = __raw_readl(rng_base);
+
+	return 4;
+}
+
+static struct hwrng ixp4xx_rng_ops = {
+	.name		= "ixp4xx",
+	.data_read	= ixp4xx_rng_data_read,
+};
+
+static int __init ixp4xx_rng_init(void)
+{
+	void __iomem * rng_base;
+	int err;
+
+	rng_base = ioremap(0x70002100, 4);
+	if (!rng_base)
+		return -ENOMEM;
+	ixp4xx_rng_ops.priv = (unsigned long)rng_base;
+	err = hwrng_register(&ixp4xx_rng_ops);
+	if (err)
+		iounmap(rng_base);
+
+	return err;
+}
+
+static void __exit ixp4xx_rng_exit(void)
+{
+	void __iomem * rng_base = (void __iomem *)ixp4xx_rng_ops.priv;
+
+	hwrng_unregister(&ixp4xx_rng_ops);
+	iounmap(rng_base);
+}
+
+subsys_initcall(ixp4xx_rng_init);
+module_exit(ixp4xx_rng_exit);
+
+MODULE_AUTHOR("Deepak Saxena <dsaxena@plexity.net>");
+MODULE_DESCRIPTION("H/W Random Number Generator (RNG) driver for IXP4xx");
+MODULE_LICENSE("GPL");

--

