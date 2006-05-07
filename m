Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWEGOik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWEGOik (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 10:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWEGOij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 10:38:39 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:24805
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S932132AbWEGOie
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 10:38:34 -0400
X-Mailbox-Line: From mb@pc1 Sun May  7 16:42:57 2006
Message-Id: <20060507144257.648667000@pc1>
References: <20060507143806.465264000@pc1>
Date: Sun, 07 May 2006 16:38:10 +0200
To: akpm@osdl.org
Cc: Deepak Saxena <dsaxena@plexity.net>, bcm43xx-dev@lists.berlios.de,
       linux-kernel@vger.kernel.org, Sergey Vlasov <vsu@altlinux.ru>
Subject: [patch 4/6] New Generic HW RNG (#2)
Content-Disposition: inline; filename=add-ixp4xx-hw-random.patch
From: Michael Buesch <mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add ixp4xx H/W RNG driver.
Driver written by Deepak Saxena.

Signed-off-by: Michael Buesch <mb@bu3sch.de>
Index: hwrng/drivers/char/hw_random/Kconfig
===================================================================
--- hwrng.orig/drivers/char/hw_random/Kconfig	2006-05-07 15:50:22.000000000 +0200
+++ hwrng/drivers/char/hw_random/Kconfig	2006-05-07 15:50:25.000000000 +0200
@@ -22,3 +22,15 @@
 	  module will be called x86-rng.
 
 	  If unsure, say Y.
+
+config IXP4XX_RNG
+	tristate "Intel IXP4xx NPU HW Random Number Generator support"
+	depends on HW_RANDOM && ARCH_IXP4XX
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
--- hwrng.orig/drivers/char/hw_random/Makefile	2006-05-07 15:50:22.000000000 +0200
+++ hwrng/drivers/char/hw_random/Makefile	2006-05-07 15:50:25.000000000 +0200
@@ -4,3 +4,4 @@
 
 obj-$(CONFIG_HW_RANDOM) += core.o
 obj-$(CONFIG_X86_RNG) += x86-rng.o
+obj-$(CONFIG_IXP4XX_RNG) += ixp4xx-rng.o
Index: hwrng/drivers/char/hw_random/ixp4xx-rng.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ hwrng/drivers/char/hw_random/ixp4xx-rng.c	2006-05-07 15:50:25.000000000 +0200
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

