Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbVJ2TYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbVJ2TYc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 15:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbVJ2TYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 15:24:30 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:48062 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932122AbVJ2TYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 15:24:00 -0400
Message-Id: <20051029192434.030073000@omelas>
References: <20051029191229.562454000@omelas>
Date: Sat, 29 Oct 2005 12:12:32 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, tony@atomide.com
Subject: [patch 3/5] Intel IXP4xx driver
Content-Disposition: inline; filename=rng/rng_ixp4xx_driver.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RNG driver for Intel IXP4xx NPU.

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>


Index: linux-2.6-rng/drivers/char/rng/ixp4xx-rng.c
===================================================================
--- /dev/null
+++ linux-2.6-rng/drivers/char/rng/ixp4xx-rng.c
@@ -0,0 +1,66 @@
+/*
+ * drivers/char/rng/ixp4xx-rng.c
+ *
+ * RNG driver for Intel IXP4xx family of NPUs
+ *
+ * Author: Deepak Saxena <dsaxena@plexity.net>
+ *
+ * Copyright 2005 (c) MontaVista Software, Inc.
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
+
+#include <asm/io.h>
+#include <asm/hardware.h>
+
+#include "rng.h"
+
+static u32* __iomem rng_base;
+
+static int ixp4xx_rng_data_present(void)
+{
+	return 1;
+}
+
+static int ixp4xx_rng_data_read(u32 *buffer)
+{
+	*buffer = __raw_readl(rng_base);
+
+	return 4;
+}
+
+struct rng_operations ixp4xx_rng_ops = {
+	.data_present	= ixp4xx_rng_data_present,
+	.data_read	= ixp4xx_rng_data_read,
+};
+
+static int __init ixp4xx_rng_init(void)
+{
+	rng_base = (u32* __iomem) ioremap(0x70002100, 4);
+	if (!rng_base) return -ENOMEM;
+
+	return register_rng(&ixp4xx_rng_ops);
+}
+
+static void __exit ixp4xx_rng_exit(void)
+{
+	unregister_rng(&ixp4xx_rng_ops);
+	iounmap(rng_base);
+}
+
+subsys_initcall(ixp4xx_rng_init);
+module_exit(ixp4xx_rng_exit);
+
+MODULE_AUTHOR("Deepak Saxena <dsaxena@plexity.net>");
+MODULE_DESCRIPTION("H/W Random Number Generator (RNG) driver for IXP4xx");
+MODULE_LICENSE("GPL");
Index: linux-2.6-rng/include/asm-arm/arch-ixp4xx/ixp4xx-regs.h
===================================================================
--- linux-2.6-rng.orig/include/asm-arm/arch-ixp4xx/ixp4xx-regs.h
+++ linux-2.6-rng/include/asm-arm/arch-ixp4xx/ixp4xx-regs.h
@@ -36,6 +36,8 @@
  *
  * 0x6000000	0x00004000	ioremap'd	QMgr
  *
+ * 0x7000000    0x00004000      ioremap'd       Public-Key Exchange Unit
+ *
  * 0xC0000000	0x00001000	0xffbfe000	PCI CFG 
  *
  * 0xC4000000	0x00001000	0xffbfd000	EXP CFG 

--
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
