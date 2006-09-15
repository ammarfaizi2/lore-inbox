Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751577AbWIOOji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbWIOOji (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 10:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbWIOOji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 10:39:38 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:23765 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751577AbWIOOjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 10:39:21 -0400
Date: Fri, 15 Sep 2006 16:38:51 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>
Subject: [-mm patch 3/3] AVR32 MTD: AT49BV6416 platform device for ATSTK1000
 (try 2)
Message-ID: <20060915163851.78fb1105@cad-250-152.norway.atmel.com>
In-Reply-To: <20060915163711.10d19763@cad-250-152.norway.atmel.com>
References: <20060915163102.73bf171d@cad-250-152.norway.atmel.com>
	<20060915163554.4f326bf6@cad-250-152.norway.atmel.com>
	<20060915163711.10d19763@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.0-rc2 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FRegister a platform device for the AT49BV6416 NOR flash chip on the
ATSTK1000 development board for use by the physmap MTD driver.

The SMC timings are set up before the platform device is registered
so that no board-specific mapping driver is necessary.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/boards/atstk1000/Makefile |    2 
 arch/avr32/boards/atstk1000/flash.c  |   95 +++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+), 1 deletion(-)

Index: linux-2.6.18-rc6-mm2/arch/avr32/boards/atstk1000/Makefile
===================================================================
--- linux-2.6.18-rc6-mm2.orig/arch/avr32/boards/atstk1000/Makefile	2006-09-15 13:41:12.000000000 +0200
+++ linux-2.6.18-rc6-mm2/arch/avr32/boards/atstk1000/Makefile	2006-09-15 13:44:30.000000000 +0200
@@ -1,2 +1,2 @@
-obj-y				+= setup.o spi.o
+obj-y				+= setup.o spi.o flash.o
 obj-$(CONFIG_BOARD_ATSTK1002)	+= atstk1002.o
Index: linux-2.6.18-rc6-mm2/arch/avr32/boards/atstk1000/flash.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc6-mm2/arch/avr32/boards/atstk1000/flash.c	2006-09-15 13:45:21.000000000 +0200
@@ -0,0 +1,95 @@
+/*
+ * ATSTK1000 board-specific flash initialization
+ *
+ * Copyright (C) 2005-2006 Atmel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
+
+#include <asm/arch/smc.h>
+
+static struct smc_config flash_config __initdata = {
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
+static struct mtd_partition flash_parts[] = {
+	{
+		.name           = "u-boot",
+		.offset         = 0x00000000,
+		.size           = 0x00020000,           /* 128 KiB */
+		.mask_flags     = MTD_WRITEABLE,
+	},
+	{
+		.name           = "root",
+		.offset         = 0x00020000,
+		.size           = 0x007d0000,
+	},
+	{
+		.name           = "env",
+		.offset         = 0x007f0000,
+		.size           = 0x00010000,
+		.mask_flags     = MTD_WRITEABLE,
+	},
+};
+
+static struct physmap_flash_data flash_data = {
+	.width		= 2,
+	.nr_parts	= ARRAY_SIZE(flash_parts),
+	.parts		= flash_parts,
+};
+
+static struct resource flash_resource = {
+	.start		= 0x00000000,
+	.end		= 0x007fffff,
+	.flags		= IORESOURCE_MEM,
+};
+
+static struct platform_device flash_device = {
+	.name		= "physmap-flash",
+	.id		= 0,
+	.resource	= &flash_resource,
+	.num_resources	= 1,
+	.dev		= {
+		.platform_data = &flash_data,
+	},
+};
+
+/* This needs to be called after the SMC has been initialized */
+static int __init atstk1000_flash_init(void)
+{
+	int ret;
+
+	ret = smc_set_configuration(0, &flash_config);
+	if (ret < 0) {
+		printk(KERN_ERR "atstk1000: failed to set NOR flash timing\n");
+		return ret;
+	}
+
+	platform_device_register(&flash_device);
+
+	return 0;
+}
+device_initcall(atstk1000_flash_init);
