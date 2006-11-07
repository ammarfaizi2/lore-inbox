Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWKGLmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWKGLmL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 06:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWKGLmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 06:42:11 -0500
Received: from nat-132.atmel.no ([80.232.32.132]:25051 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1754201AbWKGLmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 06:42:07 -0500
Date: Tue, 7 Nov 2006 12:33:45 +0100
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, Andrew Victor <andrew@sanpeople.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [-mm patch 3/4] AVR32: Move spi device definitions into main board
 setup file
Message-ID: <20061107123345.2de13fed@cad-250-152.norway.atmel.com>
In-Reply-To: <20061107123106.69032174@cad-250-152.norway.atmel.com>
References: <20061107122507.6f1c6e81@cad-250-152.norway.atmel.com>
	<20061107122715.3022da2f@cad-250-152.norway.atmel.com>
	<20061107123106.69032174@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's no point in having a separate file just to set up the board-
specific data for spi. By moving it into the rest of the board-
specific setup code, we can also make sure that the data is
registered before we register the spi master controller.

This patch also records the GPIO pin to use as chip select in the
controller_data member of the spi_board_info data for each device.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/boards/atstk1000/Makefile    |    2 +-
 arch/avr32/boards/atstk1000/atstk1002.c |   15 +++++++++++++++
 arch/avr32/boards/atstk1000/spi.c       |   27 ---------------------------
 3 files changed, 16 insertions(+), 28 deletions(-)

Index: linux-2.6.19-rc4-mm2/arch/avr32/boards/atstk1000/Makefile
===================================================================
--- linux-2.6.19-rc4-mm2.orig/arch/avr32/boards/atstk1000/Makefile	2006-11-07 11:29:15.000000000 +0100
+++ linux-2.6.19-rc4-mm2/arch/avr32/boards/atstk1000/Makefile	2006-11-07 11:31:00.000000000 +0100
@@ -1,2 +1,2 @@
-obj-y				+= setup.o spi.o flash.o
+obj-y				+= setup.o flash.o
 obj-$(CONFIG_BOARD_ATSTK1002)	+= atstk1002.o
Index: linux-2.6.19-rc4-mm2/arch/avr32/boards/atstk1000/atstk1002.c
===================================================================
--- linux-2.6.19-rc4-mm2.orig/arch/avr32/boards/atstk1000/atstk1002.c	2006-11-07 11:29:15.000000000 +0100
+++ linux-2.6.19-rc4-mm2/arch/avr32/boards/atstk1000/atstk1002.c	2006-11-07 11:33:09.000000000 +0100
@@ -7,11 +7,24 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/device.h>
 #include <linux/init.h>
+#include <linux/spi/spi.h>
 
+#include <asm/arch/at32ap7000.h>
 #include <asm/arch/board.h>
 #include <asm/arch/init.h>
 
+static struct spi_board_info spi_board_info[] __initdata = {
+	{
+		.modalias       = "ltv350qv",
+		.controller_data = (void *)GPIO_PIN_PA4,
+		.max_speed_hz   = 16000000,
+		.bus_num        = 0,
+		.chip_select    = 1,
+	},
+};
+
 struct eth_platform_data __initdata eth0_data = {
 	.valid		= 1,
 	.mii_phy_addr	= 0x10,
@@ -39,6 +52,8 @@ static int __init atstk1002_init(void)
 	at32_add_device_usart(2);
 
 	at32_add_device_eth(0, &eth0_data);
+
+	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
 	at32_add_device_spi(0);
 	at32_add_device_lcdc(0, &atstk1000_fb0_data);
 
Index: linux-2.6.19-rc4-mm2/arch/avr32/boards/atstk1000/spi.c
===================================================================
--- linux-2.6.19-rc4-mm2.orig/arch/avr32/boards/atstk1000/spi.c	2006-11-07 11:29:15.000000000 +0100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,27 +0,0 @@
-/*
- * ATSTK1000 SPI devices
- *
- * Copyright (C) 2005 Atmel Norway
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/device.h>
-#include <linux/spi/spi.h>
-
-static struct spi_board_info spi_board_info[] __initdata = {
-	{
-		.modalias	= "ltv350qv",
-		.max_speed_hz	= 16000000,
-		.bus_num	= 0,
-		.chip_select	= 1,
-	},
-};
-
-static int board_init_spi(void)
-{
-	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
-	return 0;
-}
-arch_initcall(board_init_spi);
