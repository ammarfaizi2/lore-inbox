Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbVCRXYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbVCRXYg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 18:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbVCRXYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 18:24:36 -0500
Received: from de01egw02.freescale.net ([192.88.165.103]:55448 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S262108AbVCRXTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 18:19:52 -0500
Date: Fri, 18 Mar 2005 17:19:21 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@blarg.somerset.sps.mot.com
To: Andrew Morton <akpm@osdl.org>
cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ppc32: Move 83xx & 85xx device and system description files
Message-ID: <Pine.LNX.4.61.0503181716020.26300@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch moves the 83xx & 85xx device and system description files out 
of the platform directory (used for board code) and into the syslib 
directory (used for common system code).

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---

diff -Nru a/arch/ppc/platforms/83xx/Makefile b/arch/ppc/platforms/83xx/Makefile
--- a/arch/ppc/platforms/83xx/Makefile	2005-03-17 23:29:42 -06:00
+++ b/arch/ppc/platforms/83xx/Makefile	2005-03-17 23:29:42 -06:00
@@ -1,6 +1,4 @@
 #
 # Makefile for the PowerPC 83xx linux kernel.
 #
-obj-$(CONFIG_83xx)		+= mpc83xx_sys.o mpc83xx_devices.o
-
 obj-$(CONFIG_MPC834x_SYS)	+= mpc834x_sys.o
diff -Nru a/arch/ppc/platforms/83xx/mpc83xx_devices.c b/arch/ppc/platforms/83xx/mpc83xx_devices.c
--- a/arch/ppc/platforms/83xx/mpc83xx_devices.c	2005-03-17 23:29:42 -06:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,237 +0,0 @@
-/*
- * arch/ppc/platforms/83xx/mpc83xx_devices.c
- *
- * MPC83xx Device descriptions
- *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
- *
- * Copyright 2005 Freescale Semiconductor Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <linux/serial_8250.h>
-#include <linux/fsl_devices.h>
-#include <asm/mpc83xx.h>
-#include <asm/irq.h>
-#include <asm/ppc_sys.h>
-
-/* We use offsets for IORESOURCE_MEM since we do not know at compile time
- * what IMMRBAR is, will get fixed up by mach_mpc83xx_fixup
- */
-
-static struct gianfar_platform_data mpc83xx_tsec1_pdata = {
-	.device_flags = FSL_GIANFAR_DEV_HAS_GIGABIT |
-	    FSL_GIANFAR_DEV_HAS_COALESCE | FSL_GIANFAR_DEV_HAS_RMON |
-	    FSL_GIANFAR_DEV_HAS_MULTI_INTR,
-	.phy_reg_addr = 0x24000,
-};
-
-static struct gianfar_platform_data mpc83xx_tsec2_pdata = {
-	.device_flags = FSL_GIANFAR_DEV_HAS_GIGABIT |
-	    FSL_GIANFAR_DEV_HAS_COALESCE | FSL_GIANFAR_DEV_HAS_RMON |
-	    FSL_GIANFAR_DEV_HAS_MULTI_INTR,
-	.phy_reg_addr = 0x24000,
-};
-
-static struct fsl_i2c_platform_data mpc83xx_fsl_i2c1_pdata = {
-	.device_flags = FSL_I2C_DEV_SEPARATE_DFSRR,
-};
-
-static struct fsl_i2c_platform_data mpc83xx_fsl_i2c2_pdata = {
-	.device_flags = FSL_I2C_DEV_SEPARATE_DFSRR,
-};
-
-static struct plat_serial8250_port serial_platform_data[] = {
-	[0] = {
-		.mapbase	= 0x4500,
-		.irq		= MPC83xx_IRQ_UART1,
-		.iotype		= UPIO_MEM,
-		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
-	},
-	[1] = {
-		.mapbase	= 0x4600,
-		.irq		= MPC83xx_IRQ_UART2,
-		.iotype		= UPIO_MEM,
-		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
-	},
-};
-
-struct platform_device ppc_sys_platform_devices[] = {
-	[MPC83xx_TSEC1] = {
-		.name = "fsl-gianfar",
-		.id	= 1,
-		.dev.platform_data = &mpc83xx_tsec1_pdata,
-		.num_resources	 = 4,
-		.resource = (struct resource[]) {
-			{
-				.start	= 0x24000,
-				.end	= 0x24fff,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.name	= "tx",
-				.start	= MPC83xx_IRQ_TSEC1_TX,
-				.end	= MPC83xx_IRQ_TSEC1_TX,
-				.flags	= IORESOURCE_IRQ,
-			},
-			{
-				.name	= "rx",
-				.start	= MPC83xx_IRQ_TSEC1_RX,
-				.end	= MPC83xx_IRQ_TSEC1_RX,
-				.flags	= IORESOURCE_IRQ,
-			},
-			{
-				.name	= "error",
-				.start	= MPC83xx_IRQ_TSEC1_ERROR,
-				.end	= MPC83xx_IRQ_TSEC1_ERROR,
-				.flags	= IORESOURCE_IRQ,
-			},
-		},
-	},
-	[MPC83xx_TSEC2] = {
-		.name = "fsl-gianfar",
-		.id	= 2,
-		.dev.platform_data = &mpc83xx_tsec2_pdata,
-		.num_resources	 = 4,
-		.resource = (struct resource[]) {
-			{
-				.start	= 0x25000,
-				.end	= 0x25fff,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.name	= "tx",
-				.start	= MPC83xx_IRQ_TSEC2_TX,
-				.end	= MPC83xx_IRQ_TSEC2_TX,
-				.flags	= IORESOURCE_IRQ,
-			},
-			{
-				.name	= "rx",
-				.start	= MPC83xx_IRQ_TSEC2_RX,
-				.end	= MPC83xx_IRQ_TSEC2_RX,
-				.flags	= IORESOURCE_IRQ,
-			},
-			{
-				.name	= "error",
-				.start	= MPC83xx_IRQ_TSEC2_ERROR,
-				.end	= MPC83xx_IRQ_TSEC2_ERROR,
-				.flags	= IORESOURCE_IRQ,
-			},
-		},
-	},
-	[MPC83xx_IIC1] = {
-		.name = "fsl-i2c",
-		.id	= 1,
-		.dev.platform_data = &mpc83xx_fsl_i2c1_pdata,
-		.num_resources	 = 2,
-		.resource = (struct resource[]) {
-			{
-				.start	= 0x3000,
-				.end	= 0x30ff,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.start	= MPC83xx_IRQ_IIC1,
-				.end	= MPC83xx_IRQ_IIC1,
-				.flags	= IORESOURCE_IRQ,
-			},
-		},
-	},
-	[MPC83xx_IIC2] = {
-		.name = "fsl-i2c",
-		.id	= 2,
-		.dev.platform_data = &mpc83xx_fsl_i2c2_pdata,
-		.num_resources	 = 2,
-		.resource = (struct resource[]) {
-			{
-				.start	= 0x3100,
-				.end	= 0x31ff,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.start	= MPC83xx_IRQ_IIC2,
-				.end	= MPC83xx_IRQ_IIC2,
-				.flags	= IORESOURCE_IRQ,
-			},
-		},
-	},
-	[MPC83xx_DUART] = {
-		.name = "serial8250",
-		.id	= 0,
-		.dev.platform_data = serial_platform_data,
-	},
-	[MPC83xx_SEC2] = {
-		.name = "fsl-sec2",
-		.id	= 1,
-		.num_resources	 = 2,
-		.resource = (struct resource[]) {
-			{
-				.start	= 0x30000,
-				.end	= 0x3ffff,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.start	= MPC83xx_IRQ_SEC2,
-				.end	= MPC83xx_IRQ_SEC2,
-				.flags	= IORESOURCE_IRQ,
-			},
-		},
-	},
-	[MPC83xx_USB2_DR] = {
-		.name = "fsl-usb2-dr",
-		.id	= 1,
-		.num_resources	 = 2,
-		.resource = (struct resource[]) {
-			{
-				.start	= 0x22000,
-				.end	= 0x22fff,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.start	= MPC83xx_IRQ_USB2_DR,
-				.end	= MPC83xx_IRQ_USB2_DR,
-				.flags	= IORESOURCE_IRQ,
-			},
-		},
-	},
-	[MPC83xx_USB2_MPH] = {
-		.name = "fsl-usb2-mph",
-		.id	= 1,
-		.num_resources	 = 2,
-		.resource = (struct resource[]) {
-			{
-				.start	= 0x23000,
-				.end	= 0x23fff,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.start	= MPC83xx_IRQ_USB2_MPH,
-				.end	= MPC83xx_IRQ_USB2_MPH,
-				.flags	= IORESOURCE_IRQ,
-			},
-		},
-	},
-};
-
-static int __init mach_mpc83xx_fixup(struct platform_device *pdev)
-{
-	ppc_sys_fixup_mem_resource(pdev, immrbar);
-	return 0;
-}
-
-static int __init mach_mpc83xx_init(void)
-{
-	if (ppc_md.progress)
-		ppc_md.progress("mach_mpc83xx_init:enter", 0);
-	ppc_sys_device_fixup = mach_mpc83xx_fixup;
-	return 0;
-}
-
-postcore_initcall(mach_mpc83xx_init);
diff -Nru a/arch/ppc/platforms/83xx/mpc83xx_sys.c b/arch/ppc/platforms/83xx/mpc83xx_sys.c
--- a/arch/ppc/platforms/83xx/mpc83xx_sys.c	2005-03-17 23:29:42 -06:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,100 +0,0 @@
-/*
- * arch/ppc/platforms/83xx/mpc83xx_sys.c
- *
- * MPC83xx System descriptions
- *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
- *
- * Copyright 2005 Freescale Semiconductor Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <asm/ppc_sys.h>
-
-struct ppc_sys_spec *cur_ppc_sys_spec;
-struct ppc_sys_spec ppc_sys_specs[] = {
-	{
-		.ppc_sys_name	= "8349E",
-		.mask 		= 0xFFFF0000,
-		.value 		= 0x80500000,
-		.num_devices	= 8,
-		.device_list	= (enum ppc_sys_devices[])
-		{
-			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
-			MPC83xx_IIC2, MPC83xx_DUART, MPC83xx_SEC2,
-			MPC83xx_USB2_DR, MPC83xx_USB2_MPH
-		},
-	},
-	{
-		.ppc_sys_name	= "8349",
-		.mask 		= 0xFFFF0000,
-		.value 		= 0x80510000,
-		.num_devices	= 7,
-		.device_list	= (enum ppc_sys_devices[])
-		{
-			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
-			MPC83xx_IIC2, MPC83xx_DUART,
-			MPC83xx_USB2_DR, MPC83xx_USB2_MPH
-		},
-	},
-	{
-		.ppc_sys_name	= "8347E",
-		.mask 		= 0xFFFF0000,
-		.value 		= 0x80520000,
-		.num_devices	= 8,
-		.device_list	= (enum ppc_sys_devices[])
-		{
-			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
-			MPC83xx_IIC2, MPC83xx_DUART, MPC83xx_SEC2,
-			MPC83xx_USB2_DR, MPC83xx_USB2_MPH
-		},
-	},
-	{
-		.ppc_sys_name	= "8347",
-		.mask 		= 0xFFFF0000,
-		.value 		= 0x80530000,
-		.num_devices	= 7,
-		.device_list	= (enum ppc_sys_devices[])
-		{
-			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
-			MPC83xx_IIC2, MPC83xx_DUART,
-			MPC83xx_USB2_DR, MPC83xx_USB2_MPH
-		},
-	},
-	{
-		.ppc_sys_name	= "8343E",
-		.mask 		= 0xFFFF0000,
-		.value 		= 0x80540000,
-		.num_devices	= 7,
-		.device_list	= (enum ppc_sys_devices[])
-		{
-			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
-			MPC83xx_IIC2, MPC83xx_DUART, MPC83xx_SEC2,
-			MPC83xx_USB2_DR,
-		},
-	},
-	{
-		.ppc_sys_name	= "8343",
-		.mask 		= 0xFFFF0000,
-		.value 		= 0x80550000,
-		.num_devices	= 6,
-		.device_list	= (enum ppc_sys_devices[])
-		{
-			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
-			MPC83xx_IIC2, MPC83xx_DUART,
-			MPC83xx_USB2_DR,
-		},
-	},
-	{	/* default match */
-		.ppc_sys_name	= "",
-		.mask 		= 0x00000000,
-		.value 		= 0x00000000,
-	},
-};
diff -Nru a/arch/ppc/platforms/85xx/Makefile b/arch/ppc/platforms/85xx/Makefile
--- a/arch/ppc/platforms/85xx/Makefile	2005-03-17 23:29:42 -06:00
+++ b/arch/ppc/platforms/85xx/Makefile	2005-03-17 23:29:42 -06:00
@@ -1,8 +1,6 @@
 #
 # Makefile for the PowerPC 85xx linux kernel.
 #
-obj-$(CONFIG_85xx)		+= mpc85xx_sys.o mpc85xx_devices.o
-
 obj-$(CONFIG_MPC8540_ADS)	+= mpc85xx_ads_common.o mpc8540_ads.o
 obj-$(CONFIG_MPC8555_CDS)	+= mpc85xx_cds_common.o
 obj-$(CONFIG_MPC8560_ADS)	+= mpc85xx_ads_common.o mpc8560_ads.o
diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_devices.c b/arch/ppc/platforms/85xx/mpc85xx_devices.c
--- a/arch/ppc/platforms/85xx/mpc85xx_devices.c	2005-03-17 23:29:42 -06:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,552 +0,0 @@
-/*
- * arch/ppc/platforms/85xx/mpc85xx_devices.c
- *
- * MPC85xx Device descriptions
- *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
- *
- * Copyright 2005 Freescale Semiconductor Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <linux/serial_8250.h>
-#include <linux/fsl_devices.h>
-#include <asm/mpc85xx.h>
-#include <asm/irq.h>
-#include <asm/ppc_sys.h>
-
-/* We use offsets for IORESOURCE_MEM since we do not know at compile time
- * what CCSRBAR is, will get fixed up by mach_mpc85xx_fixup
- */
-
-static struct gianfar_platform_data mpc85xx_tsec1_pdata = {
-	.device_flags = FSL_GIANFAR_DEV_HAS_GIGABIT |
-	    FSL_GIANFAR_DEV_HAS_COALESCE | FSL_GIANFAR_DEV_HAS_RMON |
-	    FSL_GIANFAR_DEV_HAS_MULTI_INTR,
-	.phy_reg_addr = MPC85xx_ENET1_OFFSET,
-};
-
-static struct gianfar_platform_data mpc85xx_tsec2_pdata = {
-	.device_flags = FSL_GIANFAR_DEV_HAS_GIGABIT |
-	    FSL_GIANFAR_DEV_HAS_COALESCE | FSL_GIANFAR_DEV_HAS_RMON |
-	    FSL_GIANFAR_DEV_HAS_MULTI_INTR,
-	.phy_reg_addr = MPC85xx_ENET1_OFFSET,
-};
-
-static struct gianfar_platform_data mpc85xx_fec_pdata = {
-	.phy_reg_addr = MPC85xx_ENET1_OFFSET,
-};
-
-static struct fsl_i2c_platform_data mpc85xx_fsl_i2c_pdata = {
-	.device_flags = FSL_I2C_DEV_SEPARATE_DFSRR,
-};
-
-static struct plat_serial8250_port serial_platform_data[] = {
-	[0] = {
-		.mapbase	= 0x4500,
-		.irq		= MPC85xx_IRQ_DUART,
-		.iotype		= UPIO_MEM,
-		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_SHARE_IRQ,
-	},
-	[1] = {
-		.mapbase	= 0x4600,
-		.irq		= MPC85xx_IRQ_DUART,
-		.iotype		= UPIO_MEM,
-		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_SHARE_IRQ,
-	},
-};
-
-struct platform_device ppc_sys_platform_devices[] = {
-	[MPC85xx_TSEC1] = {
-		.name = "fsl-gianfar",
-		.id	= 1,
-		.dev.platform_data = &mpc85xx_tsec1_pdata,
-		.num_resources	 = 4,
-		.resource = (struct resource[]) {
-			{
-				.start	= MPC85xx_ENET1_OFFSET,
-				.end	= MPC85xx_ENET1_OFFSET +
-						MPC85xx_ENET1_SIZE - 1,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.name	= "tx",
-				.start	= MPC85xx_IRQ_TSEC1_TX,
-				.end	= MPC85xx_IRQ_TSEC1_TX,
-				.flags	= IORESOURCE_IRQ,
-			},
-			{
-				.name	= "rx",
-				.start	= MPC85xx_IRQ_TSEC1_RX,
-				.end	= MPC85xx_IRQ_TSEC1_RX,
-				.flags	= IORESOURCE_IRQ,
-			},
-			{
-				.name	= "error",
-				.start	= MPC85xx_IRQ_TSEC1_ERROR,
-				.end	= MPC85xx_IRQ_TSEC1_ERROR,
-				.flags	= IORESOURCE_IRQ,
-			},
-		},
-	},
-	[MPC85xx_TSEC2] = {
-		.name = "fsl-gianfar",
-		.id	= 2,
-		.dev.platform_data = &mpc85xx_tsec2_pdata,
-		.num_resources	 = 4,
-		.resource = (struct resource[]) {
-			{
-				.start	= MPC85xx_ENET2_OFFSET,
-				.end	= MPC85xx_ENET2_OFFSET +
-						MPC85xx_ENET2_SIZE - 1,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.name	= "tx",
-				.start	= MPC85xx_IRQ_TSEC2_TX,
-				.end	= MPC85xx_IRQ_TSEC2_TX,
-				.flags	= IORESOURCE_IRQ,
-			},
-			{
-				.name	= "rx",
-				.start	= MPC85xx_IRQ_TSEC2_RX,
-				.end	= MPC85xx_IRQ_TSEC2_RX,
-				.flags	= IORESOURCE_IRQ,
-			},
-			{
-				.name	= "error",
-				.start	= MPC85xx_IRQ_TSEC2_ERROR,
-				.end	= MPC85xx_IRQ_TSEC2_ERROR,
-				.flags	= IORESOURCE_IRQ,
-			},
-		},
-	},
-	[MPC85xx_FEC] =	{
-		.name = "fsl-gianfar",
-		.id	= 3,
-		.dev.platform_data = &mpc85xx_fec_pdata,
-		.num_resources	 = 2,
-		.resource = (struct resource[]) {
-			{
-				.start	= MPC85xx_ENET3_OFFSET,
-				.end	= MPC85xx_ENET3_OFFSET +
-						MPC85xx_ENET3_SIZE - 1,
-				.flags	= IORESOURCE_MEM,
-
-			},
-			{
-				.start	= MPC85xx_IRQ_FEC,
-				.end	= MPC85xx_IRQ_FEC,
-				.flags	= IORESOURCE_IRQ,
-			},
-		},
-	},
-	[MPC85xx_IIC1] = {
-		.name = "fsl-i2c",
-		.id	= 1,
-		.dev.platform_data = &mpc85xx_fsl_i2c_pdata,
-		.num_resources	 = 2,
-		.resource = (struct resource[]) {
-			{
-				.start	= MPC85xx_IIC1_OFFSET,
-				.end	= MPC85xx_IIC1_OFFSET +
-						MPC85xx_IIC1_SIZE - 1,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.start	= MPC85xx_IRQ_IIC1,
-				.end	= MPC85xx_IRQ_IIC1,
-				.flags	= IORESOURCE_IRQ,
-			},
-		},
-	},
-	[MPC85xx_DMA0] = {
-		.name = "fsl-dma",
-		.id	= 0,
-		.num_resources	 = 2,
-		.resource = (struct resource[]) {
-			{
-				.start	= MPC85xx_DMA0_OFFSET,
-				.end	= MPC85xx_DMA0_OFFSET +
-						MPC85xx_DMA0_SIZE - 1,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.start	= MPC85xx_IRQ_DMA0,
-				.end	= MPC85xx_IRQ_DMA0,
-				.flags	= IORESOURCE_IRQ,
-			},
-		},
-	},
-	[MPC85xx_DMA1] = {
-		.name = "fsl-dma",
-		.id	= 1,
-		.num_resources	 = 2,
-		.resource = (struct resource[]) {
-			{
-				.start	= MPC85xx_DMA1_OFFSET,
-				.end	= MPC85xx_DMA1_OFFSET +
-						MPC85xx_DMA1_SIZE - 1,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.start	= MPC85xx_IRQ_DMA1,
-				.end	= MPC85xx_IRQ_DMA1,
-				.flags	= IORESOURCE_IRQ,
-			},
-		},
-	},
-	[MPC85xx_DMA2] = {
-		.name = "fsl-dma",
-		.id	= 2,
-		.num_resources	 = 2,
-		.resource = (struct resource[]) {
-			{
-				.start	= MPC85xx_DMA2_OFFSET,
-				.end	= MPC85xx_DMA2_OFFSET +
-						MPC85xx_DMA2_SIZE - 1,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.start	= MPC85xx_IRQ_DMA2,
-				.end	= MPC85xx_IRQ_DMA2,
-				.flags	= IORESOURCE_IRQ,
-			},
-		},
-	},
-	[MPC85xx_DMA3] = {
-		.name = "fsl-dma",
-		.id	= 3,
-		.num_resources	 = 2,
-		.resource = (struct resource[]) {
-			{
-				.start	= MPC85xx_DMA3_OFFSET,
-				.end	= MPC85xx_DMA3_OFFSET +
-						MPC85xx_DMA3_SIZE - 1,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.start	= MPC85xx_IRQ_DMA3,
-				.end	= MPC85xx_IRQ_DMA3,
-				.flags	= IORESOURCE_IRQ,
-			},
-		},
-	},
-	[MPC85xx_DUART] = {
-		.name = "serial8250",
-		.id	= 0,
-		.dev.platform_data = serial_platform_data,
-	},
-	[MPC85xx_PERFMON] = {
-		.name = "fsl-perfmon",
-		.id	= 1,
-		.num_resources	 = 2,
-		.resource = (struct resource[]) {
-			{
-				.start	= MPC85xx_PERFMON_OFFSET,
-				.end	= MPC85xx_PERFMON_OFFSET +
-						MPC85xx_PERFMON_SIZE - 1,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.start	= MPC85xx_IRQ_PERFMON,
-				.end	= MPC85xx_IRQ_PERFMON,
-				.flags	= IORESOURCE_IRQ,
-			},
-		},
-	},
-	[MPC85xx_SEC2] = {
-		.name = "fsl-sec2",
-		.id	= 1,
-		.num_resources	 = 2,
-		.resource = (struct resource[]) {
-			{
-				.start	= MPC85xx_SEC2_OFFSET,
-				.end	= MPC85xx_SEC2_OFFSET +
-						MPC85xx_SEC2_SIZE - 1,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.start	= MPC85xx_IRQ_SEC2,
-				.end	= MPC85xx_IRQ_SEC2,
-				.flags	= IORESOURCE_IRQ,
-			},
-		},
-	},
-#ifdef CONFIG_CPM2
-	[MPC85xx_CPM_FCC1] = {
-		.name = "fsl-cpm-fcc",
-		.id	= 1,
-		.num_resources	 = 3,
-		.resource = (struct resource[]) {
-			{
-				.start	= 0x91300,
-				.end	= 0x9131F,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.start	= 0x91380,
-				.end	= 0x9139F,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.start	= SIU_INT_FCC1,
-				.end	= SIU_INT_FCC1,
-				.flags	= IORESOURCE_IRQ,
-			},
-		},
-	},
-	[MPC85xx_CPM_FCC2] = {
-		.name = "fsl-cpm-fcc",
-		.id	= 2,
-		.num_resources	 = 3,
-		.resource = (struct resource[]) {
-			{
-				.start	= 0x91320,
-				.end	= 0x9133F,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.start	= 0x913A0,
-				.end	= 0x913CF,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.start	= SIU_INT_FCC2,
-				.end	= SIU_INT_FCC2,
-				.flags	= IORESOURCE_IRQ,
-			},
-		},
-	},
-	[MPC85xx_CPM_FCC3] = {
-		.name = "fsl-cpm-fcc",
-		.id	= 3,
-		.num_resources	 = 3,
-		.resource = (struct resource[]) {
-			{
-				.start	= 0x91340,
-				.end	= 0x9135F,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.start	= 0x913D0,
-				.end	= 0x913FF,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.start	= SIU_INT_FCC3,
-				.end	= SIU_INT_FCC3,
-				.flags	= IORESOURCE_IRQ,
-			},
-		},
-	},
-	[MPC85xx_CPM_I2C] = {
-		.name = "fsl-cpm-i2c",
-		.id	= 1,
-		.num_resources	 = 2,
-		.resource = (struct resource[]) {
-			{
-				.start	= 0x91860,
-				.end	= 0x918BF,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.start	= SIU_INT_I2C,
-				.end	= SIU_INT_I2C,
-				.flags	= IORESOURCE_IRQ,
-			},
-		},
-	},
-	[MPC85xx_CPM_SCC1] = {
-		.name = "fsl-cpm-scc",
-		.id	= 1,
-		.num_resources	 = 2,
-		.resource = (struct resource[]) {
-			{
-				.start	= 0x91A00,
-				.end	= 0x91A1F,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.start	= SIU_INT_SCC1,
-				.end	= SIU_INT_SCC1,
-				.flags	= IORESOURCE_IRQ,
-			},
-		},
-	},
-	[MPC85xx_CPM_SCC2] = {
-		.name = "fsl-cpm-scc",
-		.id	= 2,
-		.num_resources	 = 2,
-		.resource = (struct resource[]) {
-			{
-				.start	= 0x91A20,
-				.end	= 0x91A3F,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.start	= SIU_INT_SCC2,
-				.end	= SIU_INT_SCC2,
-				.flags	= IORESOURCE_IRQ,
-			},
-		},
-	},
-	[MPC85xx_CPM_SCC3] = {
-		.name = "fsl-cpm-scc",
-		.id	= 3,
-		.num_resources	 = 2,
-		.resource = (struct resource[]) {
-			{
-				.start	= 0x91A40,
-				.end	= 0x91A5F,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.start	= SIU_INT_SCC3,
-				.end	= SIU_INT_SCC3,
-				.flags	= IORESOURCE_IRQ,
-			},
-		},
-	},
-	[MPC85xx_CPM_SCC4] = {
-		.name = "fsl-cpm-scc",
-		.id	= 4,
-		.num_resources	 = 2,
-		.resource = (struct resource[]) {
-			{
-				.start	= 0x91A60,
-				.end	= 0x91A7F,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.start	= SIU_INT_SCC4,
-				.end	= SIU_INT_SCC4,
-				.flags	= IORESOURCE_IRQ,
-			},
-		},
-	},
-	[MPC85xx_CPM_SPI] = {
-		.name = "fsl-cpm-spi",
-		.id	= 1,
-		.num_resources	 = 2,
-		.resource = (struct resource[]) {
-			{
-				.start	= 0x91AA0,
-				.end	= 0x91AFF,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.start	= SIU_INT_SPI,
-				.end	= SIU_INT_SPI,
-				.flags	= IORESOURCE_IRQ,
-			},
-		},
-	},
-	[MPC85xx_CPM_MCC1] = {
-		.name = "fsl-cpm-mcc",
-		.id	= 1,
-		.num_resources	 = 2,
-		.resource = (struct resource[]) {
-			{
-				.start	= 0x91B30,
-				.end	= 0x91B3F,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.start	= SIU_INT_MCC1,
-				.end	= SIU_INT_MCC1,
-				.flags	= IORESOURCE_IRQ,
-			},
-		},
-	},
-	[MPC85xx_CPM_MCC2] = {
-		.name = "fsl-cpm-mcc",
-		.id	= 2,
-		.num_resources	 = 2,
-		.resource = (struct resource[]) {
-			{
-				.start	= 0x91B50,
-				.end	= 0x91B5F,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.start	= SIU_INT_MCC2,
-				.end	= SIU_INT_MCC2,
-				.flags	= IORESOURCE_IRQ,
-			},
-		},
-	},
-	[MPC85xx_CPM_SMC1] = {
-		.name = "fsl-cpm-smc",
-		.id	= 1,
-		.num_resources	 = 2,
-		.resource = (struct resource[]) {
-			{
-				.start	= 0x91A80,
-				.end	= 0x91A8F,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.start	= SIU_INT_SMC1,
-				.end	= SIU_INT_SMC1,
-				.flags	= IORESOURCE_IRQ,
-			},
-		},
-	},
-	[MPC85xx_CPM_SMC2] = {
-		.name = "fsl-cpm-smc",
-		.id	= 2,
-		.num_resources	 = 2,
-		.resource = (struct resource[]) {
-			{
-				.start	= 0x91A90,
-				.end	= 0x91A9F,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.start	= SIU_INT_SMC2,
-				.end	= SIU_INT_SMC2,
-				.flags	= IORESOURCE_IRQ,
-			},
-		},
-	},
-	[MPC85xx_CPM_USB] = {
-		.name = "fsl-cpm-usb",
-		.id	= 2,
-		.num_resources	 = 2,
-		.resource = (struct resource[]) {
-			{
-				.start	= 0x91B60,
-				.end	= 0x91B7F,
-				.flags	= IORESOURCE_MEM,
-			},
-			{
-				.start	= SIU_INT_USB,
-				.end	= SIU_INT_USB,
-				.flags	= IORESOURCE_IRQ,
-			},
-		},
-	},
-#endif /* CONFIG_CPM2 */
-};
-
-static int __init mach_mpc85xx_fixup(struct platform_device *pdev)
-{
-	ppc_sys_fixup_mem_resource(pdev, CCSRBAR);
-	return 0;
-}
-
-static int __init mach_mpc85xx_init(void)
-{
-	ppc_sys_device_fixup = mach_mpc85xx_fixup;
-	return 0;
-}
-
-postcore_initcall(mach_mpc85xx_init);
diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_sys.c b/arch/ppc/platforms/85xx/mpc85xx_sys.c
--- a/arch/ppc/platforms/85xx/mpc85xx_sys.c	2005-03-17 23:29:42 -06:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,118 +0,0 @@
-/*
- * arch/ppc/platforms/85xx/mpc85xx_sys.c
- *
- * MPC85xx System descriptions
- *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
- *
- * Copyright 2005 Freescale Semiconductor Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <asm/ppc_sys.h>
-
-struct ppc_sys_spec *cur_ppc_sys_spec;
-struct ppc_sys_spec ppc_sys_specs[] = {
-	{
-		.ppc_sys_name	= "8540",
-		.mask 		= 0xFFFF0000,
-		.value 		= 0x80300000,
-		.num_devices	= 10,
-		.device_list	= (enum ppc_sys_devices[])
-		{
-			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_FEC, MPC85xx_IIC1,
-			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
-			MPC85xx_PERFMON, MPC85xx_DUART,
-		},
-	},
-	{
-		.ppc_sys_name	= "8560",
-		.mask 		= 0xFFFF0000,
-		.value 		= 0x80700000,
-		.num_devices	= 19,
-		.device_list	= (enum ppc_sys_devices[])
-		{
-			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_IIC1,
-			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
-			MPC85xx_PERFMON,
-			MPC85xx_CPM_SPI, MPC85xx_CPM_I2C, MPC85xx_CPM_SCC1,
-			MPC85xx_CPM_SCC2, MPC85xx_CPM_SCC3, MPC85xx_CPM_SCC4,
-			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2, MPC85xx_CPM_FCC3,
-			MPC85xx_CPM_MCC1, MPC85xx_CPM_MCC2,
-		},
-	},
-	{
-		.ppc_sys_name	= "8541",
-		.mask 		= 0xFFFF0000,
-		.value 		= 0x80720000,
-		.num_devices	= 13,
-		.device_list	= (enum ppc_sys_devices[])
-		{
-			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_IIC1,
-			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
-			MPC85xx_PERFMON, MPC85xx_DUART,
-			MPC85xx_CPM_SPI, MPC85xx_CPM_I2C,
-			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2,
-		},
-	},
-	{
-		.ppc_sys_name	= "8541E",
-		.mask 		= 0xFFFF0000,
-		.value 		= 0x807A0000,
-		.num_devices	= 14,
-		.device_list	= (enum ppc_sys_devices[])
-		{
-			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_IIC1,
-			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
-			MPC85xx_PERFMON, MPC85xx_DUART, MPC85xx_SEC2,
-			MPC85xx_CPM_SPI, MPC85xx_CPM_I2C,
-			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2,
-		},
-	},
-	{
-		.ppc_sys_name	= "8555",
-		.mask 		= 0xFFFF0000,
-		.value 		= 0x80710000,
-		.num_devices	= 20,
-		.device_list	= (enum ppc_sys_devices[])
-		{
-			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_IIC1,
-			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
-			MPC85xx_PERFMON, MPC85xx_DUART,
-			MPC85xx_CPM_SPI, MPC85xx_CPM_I2C, MPC85xx_CPM_SCC1,
-			MPC85xx_CPM_SCC2, MPC85xx_CPM_SCC3,
-			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2, MPC85xx_CPM_FCC3,
-			MPC85xx_CPM_SMC1, MPC85xx_CPM_SMC2,
-			MPC85xx_CPM_USB,
-		},
-	},
-	{
-		.ppc_sys_name	= "8555E",
-		.mask 		= 0xFFFF0000,
-		.value 		= 0x80790000,
-		.num_devices	= 21,
-		.device_list	= (enum ppc_sys_devices[])
-		{
-			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_IIC1,
-			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
-			MPC85xx_PERFMON, MPC85xx_DUART, MPC85xx_SEC2,
-			MPC85xx_CPM_SPI, MPC85xx_CPM_I2C, MPC85xx_CPM_SCC1,
-			MPC85xx_CPM_SCC2, MPC85xx_CPM_SCC3,
-			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2, MPC85xx_CPM_FCC3,
-			MPC85xx_CPM_SMC1, MPC85xx_CPM_SMC2,
-			MPC85xx_CPM_USB,
-		},
-	},
-	{	/* default match */
-		.ppc_sys_name	= "",
-		.mask 		= 0x00000000,
-		.value 		= 0x00000000,
-	},
-};
diff -Nru a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile	2005-03-17 23:29:42 -06:00
+++ b/arch/ppc/syslib/Makefile	2005-03-17 23:29:42 -06:00
@@ -96,11 +96,13 @@
 obj-$(CONFIG_40x)		+= dcr.o
 obj-$(CONFIG_BOOKE)		+= dcr.o
 obj-$(CONFIG_85xx)		+= open_pic.o ppc85xx_common.o ppc85xx_setup.o \
-					ppc_sys.o
+					ppc_sys.o mpc85xx_sys.o \
+					mpc85xx_devices.o
 ifeq ($(CONFIG_85xx),y)
 obj-$(CONFIG_PCI)		+= indirect_pci.o pci_auto.o
 endif
-obj-$(CONFIG_83xx)		+= ipic.o ppc83xx_setup.o ppc_sys.o
+obj-$(CONFIG_83xx)		+= ipic.o ppc83xx_setup.o ppc_sys.o \
+					mpc83xx_sys.o mpc83xx_devices.o
 ifeq ($(CONFIG_83xx),y)
 obj-$(CONFIG_PCI)		+= indirect_pci.o pci_auto.o
 endif
diff -Nru a/arch/ppc/syslib/mpc83xx_devices.c b/arch/ppc/syslib/mpc83xx_devices.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/syslib/mpc83xx_devices.c	2005-03-17 23:29:42 -06:00
@@ -0,0 +1,237 @@
+/*
+ * arch/ppc/platforms/83xx/mpc83xx_devices.c
+ *
+ * MPC83xx Device descriptions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2005 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/serial_8250.h>
+#include <linux/fsl_devices.h>
+#include <asm/mpc83xx.h>
+#include <asm/irq.h>
+#include <asm/ppc_sys.h>
+
+/* We use offsets for IORESOURCE_MEM since we do not know at compile time
+ * what IMMRBAR is, will get fixed up by mach_mpc83xx_fixup
+ */
+
+static struct gianfar_platform_data mpc83xx_tsec1_pdata = {
+	.device_flags = FSL_GIANFAR_DEV_HAS_GIGABIT |
+	    FSL_GIANFAR_DEV_HAS_COALESCE | FSL_GIANFAR_DEV_HAS_RMON |
+	    FSL_GIANFAR_DEV_HAS_MULTI_INTR,
+	.phy_reg_addr = 0x24000,
+};
+
+static struct gianfar_platform_data mpc83xx_tsec2_pdata = {
+	.device_flags = FSL_GIANFAR_DEV_HAS_GIGABIT |
+	    FSL_GIANFAR_DEV_HAS_COALESCE | FSL_GIANFAR_DEV_HAS_RMON |
+	    FSL_GIANFAR_DEV_HAS_MULTI_INTR,
+	.phy_reg_addr = 0x24000,
+};
+
+static struct fsl_i2c_platform_data mpc83xx_fsl_i2c1_pdata = {
+	.device_flags = FSL_I2C_DEV_SEPARATE_DFSRR,
+};
+
+static struct fsl_i2c_platform_data mpc83xx_fsl_i2c2_pdata = {
+	.device_flags = FSL_I2C_DEV_SEPARATE_DFSRR,
+};
+
+static struct plat_serial8250_port serial_platform_data[] = {
+	[0] = {
+		.mapbase	= 0x4500,
+		.irq		= MPC83xx_IRQ_UART1,
+		.iotype		= UPIO_MEM,
+		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
+	},
+	[1] = {
+		.mapbase	= 0x4600,
+		.irq		= MPC83xx_IRQ_UART2,
+		.iotype		= UPIO_MEM,
+		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
+	},
+};
+
+struct platform_device ppc_sys_platform_devices[] = {
+	[MPC83xx_TSEC1] = {
+		.name = "fsl-gianfar",
+		.id	= 1,
+		.dev.platform_data = &mpc83xx_tsec1_pdata,
+		.num_resources	 = 4,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x24000,
+				.end	= 0x24fff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "tx",
+				.start	= MPC83xx_IRQ_TSEC1_TX,
+				.end	= MPC83xx_IRQ_TSEC1_TX,
+				.flags	= IORESOURCE_IRQ,
+			},
+			{
+				.name	= "rx",
+				.start	= MPC83xx_IRQ_TSEC1_RX,
+				.end	= MPC83xx_IRQ_TSEC1_RX,
+				.flags	= IORESOURCE_IRQ,
+			},
+			{
+				.name	= "error",
+				.start	= MPC83xx_IRQ_TSEC1_ERROR,
+				.end	= MPC83xx_IRQ_TSEC1_ERROR,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC83xx_TSEC2] = {
+		.name = "fsl-gianfar",
+		.id	= 2,
+		.dev.platform_data = &mpc83xx_tsec2_pdata,
+		.num_resources	 = 4,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x25000,
+				.end	= 0x25fff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "tx",
+				.start	= MPC83xx_IRQ_TSEC2_TX,
+				.end	= MPC83xx_IRQ_TSEC2_TX,
+				.flags	= IORESOURCE_IRQ,
+			},
+			{
+				.name	= "rx",
+				.start	= MPC83xx_IRQ_TSEC2_RX,
+				.end	= MPC83xx_IRQ_TSEC2_RX,
+				.flags	= IORESOURCE_IRQ,
+			},
+			{
+				.name	= "error",
+				.start	= MPC83xx_IRQ_TSEC2_ERROR,
+				.end	= MPC83xx_IRQ_TSEC2_ERROR,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC83xx_IIC1] = {
+		.name = "fsl-i2c",
+		.id	= 1,
+		.dev.platform_data = &mpc83xx_fsl_i2c1_pdata,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x3000,
+				.end	= 0x30ff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC83xx_IRQ_IIC1,
+				.end	= MPC83xx_IRQ_IIC1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC83xx_IIC2] = {
+		.name = "fsl-i2c",
+		.id	= 2,
+		.dev.platform_data = &mpc83xx_fsl_i2c2_pdata,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x3100,
+				.end	= 0x31ff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC83xx_IRQ_IIC2,
+				.end	= MPC83xx_IRQ_IIC2,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC83xx_DUART] = {
+		.name = "serial8250",
+		.id	= 0,
+		.dev.platform_data = serial_platform_data,
+	},
+	[MPC83xx_SEC2] = {
+		.name = "fsl-sec2",
+		.id	= 1,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x30000,
+				.end	= 0x3ffff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC83xx_IRQ_SEC2,
+				.end	= MPC83xx_IRQ_SEC2,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC83xx_USB2_DR] = {
+		.name = "fsl-usb2-dr",
+		.id	= 1,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x22000,
+				.end	= 0x22fff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC83xx_IRQ_USB2_DR,
+				.end	= MPC83xx_IRQ_USB2_DR,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC83xx_USB2_MPH] = {
+		.name = "fsl-usb2-mph",
+		.id	= 1,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x23000,
+				.end	= 0x23fff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC83xx_IRQ_USB2_MPH,
+				.end	= MPC83xx_IRQ_USB2_MPH,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+};
+
+static int __init mach_mpc83xx_fixup(struct platform_device *pdev)
+{
+	ppc_sys_fixup_mem_resource(pdev, immrbar);
+	return 0;
+}
+
+static int __init mach_mpc83xx_init(void)
+{
+	if (ppc_md.progress)
+		ppc_md.progress("mach_mpc83xx_init:enter", 0);
+	ppc_sys_device_fixup = mach_mpc83xx_fixup;
+	return 0;
+}
+
+postcore_initcall(mach_mpc83xx_init);
diff -Nru a/arch/ppc/syslib/mpc83xx_sys.c b/arch/ppc/syslib/mpc83xx_sys.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/syslib/mpc83xx_sys.c	2005-03-17 23:29:42 -06:00
@@ -0,0 +1,100 @@
+/*
+ * arch/ppc/platforms/83xx/mpc83xx_sys.c
+ *
+ * MPC83xx System descriptions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2005 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <asm/ppc_sys.h>
+
+struct ppc_sys_spec *cur_ppc_sys_spec;
+struct ppc_sys_spec ppc_sys_specs[] = {
+	{
+		.ppc_sys_name	= "8349E",
+		.mask 		= 0xFFFF0000,
+		.value 		= 0x80500000,
+		.num_devices	= 8,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
+			MPC83xx_IIC2, MPC83xx_DUART, MPC83xx_SEC2,
+			MPC83xx_USB2_DR, MPC83xx_USB2_MPH
+		},
+	},
+	{
+		.ppc_sys_name	= "8349",
+		.mask 		= 0xFFFF0000,
+		.value 		= 0x80510000,
+		.num_devices	= 7,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
+			MPC83xx_IIC2, MPC83xx_DUART,
+			MPC83xx_USB2_DR, MPC83xx_USB2_MPH
+		},
+	},
+	{
+		.ppc_sys_name	= "8347E",
+		.mask 		= 0xFFFF0000,
+		.value 		= 0x80520000,
+		.num_devices	= 8,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
+			MPC83xx_IIC2, MPC83xx_DUART, MPC83xx_SEC2,
+			MPC83xx_USB2_DR, MPC83xx_USB2_MPH
+		},
+	},
+	{
+		.ppc_sys_name	= "8347",
+		.mask 		= 0xFFFF0000,
+		.value 		= 0x80530000,
+		.num_devices	= 7,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
+			MPC83xx_IIC2, MPC83xx_DUART,
+			MPC83xx_USB2_DR, MPC83xx_USB2_MPH
+		},
+	},
+	{
+		.ppc_sys_name	= "8343E",
+		.mask 		= 0xFFFF0000,
+		.value 		= 0x80540000,
+		.num_devices	= 7,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
+			MPC83xx_IIC2, MPC83xx_DUART, MPC83xx_SEC2,
+			MPC83xx_USB2_DR,
+		},
+	},
+	{
+		.ppc_sys_name	= "8343",
+		.mask 		= 0xFFFF0000,
+		.value 		= 0x80550000,
+		.num_devices	= 6,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
+			MPC83xx_IIC2, MPC83xx_DUART,
+			MPC83xx_USB2_DR,
+		},
+	},
+	{	/* default match */
+		.ppc_sys_name	= "",
+		.mask 		= 0x00000000,
+		.value 		= 0x00000000,
+	},
+};
diff -Nru a/arch/ppc/syslib/mpc85xx_devices.c b/arch/ppc/syslib/mpc85xx_devices.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/syslib/mpc85xx_devices.c	2005-03-17 23:29:42 -06:00
@@ -0,0 +1,552 @@
+/*
+ * arch/ppc/platforms/85xx/mpc85xx_devices.c
+ *
+ * MPC85xx Device descriptions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2005 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/serial_8250.h>
+#include <linux/fsl_devices.h>
+#include <asm/mpc85xx.h>
+#include <asm/irq.h>
+#include <asm/ppc_sys.h>
+
+/* We use offsets for IORESOURCE_MEM since we do not know at compile time
+ * what CCSRBAR is, will get fixed up by mach_mpc85xx_fixup
+ */
+
+static struct gianfar_platform_data mpc85xx_tsec1_pdata = {
+	.device_flags = FSL_GIANFAR_DEV_HAS_GIGABIT |
+	    FSL_GIANFAR_DEV_HAS_COALESCE | FSL_GIANFAR_DEV_HAS_RMON |
+	    FSL_GIANFAR_DEV_HAS_MULTI_INTR,
+	.phy_reg_addr = MPC85xx_ENET1_OFFSET,
+};
+
+static struct gianfar_platform_data mpc85xx_tsec2_pdata = {
+	.device_flags = FSL_GIANFAR_DEV_HAS_GIGABIT |
+	    FSL_GIANFAR_DEV_HAS_COALESCE | FSL_GIANFAR_DEV_HAS_RMON |
+	    FSL_GIANFAR_DEV_HAS_MULTI_INTR,
+	.phy_reg_addr = MPC85xx_ENET1_OFFSET,
+};
+
+static struct gianfar_platform_data mpc85xx_fec_pdata = {
+	.phy_reg_addr = MPC85xx_ENET1_OFFSET,
+};
+
+static struct fsl_i2c_platform_data mpc85xx_fsl_i2c_pdata = {
+	.device_flags = FSL_I2C_DEV_SEPARATE_DFSRR,
+};
+
+static struct plat_serial8250_port serial_platform_data[] = {
+	[0] = {
+		.mapbase	= 0x4500,
+		.irq		= MPC85xx_IRQ_DUART,
+		.iotype		= UPIO_MEM,
+		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_SHARE_IRQ,
+	},
+	[1] = {
+		.mapbase	= 0x4600,
+		.irq		= MPC85xx_IRQ_DUART,
+		.iotype		= UPIO_MEM,
+		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_SHARE_IRQ,
+	},
+};
+
+struct platform_device ppc_sys_platform_devices[] = {
+	[MPC85xx_TSEC1] = {
+		.name = "fsl-gianfar",
+		.id	= 1,
+		.dev.platform_data = &mpc85xx_tsec1_pdata,
+		.num_resources	 = 4,
+		.resource = (struct resource[]) {
+			{
+				.start	= MPC85xx_ENET1_OFFSET,
+				.end	= MPC85xx_ENET1_OFFSET +
+						MPC85xx_ENET1_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "tx",
+				.start	= MPC85xx_IRQ_TSEC1_TX,
+				.end	= MPC85xx_IRQ_TSEC1_TX,
+				.flags	= IORESOURCE_IRQ,
+			},
+			{
+				.name	= "rx",
+				.start	= MPC85xx_IRQ_TSEC1_RX,
+				.end	= MPC85xx_IRQ_TSEC1_RX,
+				.flags	= IORESOURCE_IRQ,
+			},
+			{
+				.name	= "error",
+				.start	= MPC85xx_IRQ_TSEC1_ERROR,
+				.end	= MPC85xx_IRQ_TSEC1_ERROR,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_TSEC2] = {
+		.name = "fsl-gianfar",
+		.id	= 2,
+		.dev.platform_data = &mpc85xx_tsec2_pdata,
+		.num_resources	 = 4,
+		.resource = (struct resource[]) {
+			{
+				.start	= MPC85xx_ENET2_OFFSET,
+				.end	= MPC85xx_ENET2_OFFSET +
+						MPC85xx_ENET2_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "tx",
+				.start	= MPC85xx_IRQ_TSEC2_TX,
+				.end	= MPC85xx_IRQ_TSEC2_TX,
+				.flags	= IORESOURCE_IRQ,
+			},
+			{
+				.name	= "rx",
+				.start	= MPC85xx_IRQ_TSEC2_RX,
+				.end	= MPC85xx_IRQ_TSEC2_RX,
+				.flags	= IORESOURCE_IRQ,
+			},
+			{
+				.name	= "error",
+				.start	= MPC85xx_IRQ_TSEC2_ERROR,
+				.end	= MPC85xx_IRQ_TSEC2_ERROR,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_FEC] =	{
+		.name = "fsl-gianfar",
+		.id	= 3,
+		.dev.platform_data = &mpc85xx_fec_pdata,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= MPC85xx_ENET3_OFFSET,
+				.end	= MPC85xx_ENET3_OFFSET +
+						MPC85xx_ENET3_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+
+			},
+			{
+				.start	= MPC85xx_IRQ_FEC,
+				.end	= MPC85xx_IRQ_FEC,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_IIC1] = {
+		.name = "fsl-i2c",
+		.id	= 1,
+		.dev.platform_data = &mpc85xx_fsl_i2c_pdata,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= MPC85xx_IIC1_OFFSET,
+				.end	= MPC85xx_IIC1_OFFSET +
+						MPC85xx_IIC1_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC85xx_IRQ_IIC1,
+				.end	= MPC85xx_IRQ_IIC1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_DMA0] = {
+		.name = "fsl-dma",
+		.id	= 0,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= MPC85xx_DMA0_OFFSET,
+				.end	= MPC85xx_DMA0_OFFSET +
+						MPC85xx_DMA0_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC85xx_IRQ_DMA0,
+				.end	= MPC85xx_IRQ_DMA0,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_DMA1] = {
+		.name = "fsl-dma",
+		.id	= 1,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= MPC85xx_DMA1_OFFSET,
+				.end	= MPC85xx_DMA1_OFFSET +
+						MPC85xx_DMA1_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC85xx_IRQ_DMA1,
+				.end	= MPC85xx_IRQ_DMA1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_DMA2] = {
+		.name = "fsl-dma",
+		.id	= 2,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= MPC85xx_DMA2_OFFSET,
+				.end	= MPC85xx_DMA2_OFFSET +
+						MPC85xx_DMA2_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC85xx_IRQ_DMA2,
+				.end	= MPC85xx_IRQ_DMA2,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_DMA3] = {
+		.name = "fsl-dma",
+		.id	= 3,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= MPC85xx_DMA3_OFFSET,
+				.end	= MPC85xx_DMA3_OFFSET +
+						MPC85xx_DMA3_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC85xx_IRQ_DMA3,
+				.end	= MPC85xx_IRQ_DMA3,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_DUART] = {
+		.name = "serial8250",
+		.id	= 0,
+		.dev.platform_data = serial_platform_data,
+	},
+	[MPC85xx_PERFMON] = {
+		.name = "fsl-perfmon",
+		.id	= 1,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= MPC85xx_PERFMON_OFFSET,
+				.end	= MPC85xx_PERFMON_OFFSET +
+						MPC85xx_PERFMON_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC85xx_IRQ_PERFMON,
+				.end	= MPC85xx_IRQ_PERFMON,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_SEC2] = {
+		.name = "fsl-sec2",
+		.id	= 1,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= MPC85xx_SEC2_OFFSET,
+				.end	= MPC85xx_SEC2_OFFSET +
+						MPC85xx_SEC2_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC85xx_IRQ_SEC2,
+				.end	= MPC85xx_IRQ_SEC2,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+#ifdef CONFIG_CPM2
+	[MPC85xx_CPM_FCC1] = {
+		.name = "fsl-cpm-fcc",
+		.id	= 1,
+		.num_resources	 = 3,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x91300,
+				.end	= 0x9131F,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= 0x91380,
+				.end	= 0x9139F,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= SIU_INT_FCC1,
+				.end	= SIU_INT_FCC1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_CPM_FCC2] = {
+		.name = "fsl-cpm-fcc",
+		.id	= 2,
+		.num_resources	 = 3,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x91320,
+				.end	= 0x9133F,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= 0x913A0,
+				.end	= 0x913CF,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= SIU_INT_FCC2,
+				.end	= SIU_INT_FCC2,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_CPM_FCC3] = {
+		.name = "fsl-cpm-fcc",
+		.id	= 3,
+		.num_resources	 = 3,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x91340,
+				.end	= 0x9135F,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= 0x913D0,
+				.end	= 0x913FF,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= SIU_INT_FCC3,
+				.end	= SIU_INT_FCC3,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_CPM_I2C] = {
+		.name = "fsl-cpm-i2c",
+		.id	= 1,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x91860,
+				.end	= 0x918BF,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= SIU_INT_I2C,
+				.end	= SIU_INT_I2C,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_CPM_SCC1] = {
+		.name = "fsl-cpm-scc",
+		.id	= 1,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x91A00,
+				.end	= 0x91A1F,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= SIU_INT_SCC1,
+				.end	= SIU_INT_SCC1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_CPM_SCC2] = {
+		.name = "fsl-cpm-scc",
+		.id	= 2,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x91A20,
+				.end	= 0x91A3F,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= SIU_INT_SCC2,
+				.end	= SIU_INT_SCC2,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_CPM_SCC3] = {
+		.name = "fsl-cpm-scc",
+		.id	= 3,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x91A40,
+				.end	= 0x91A5F,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= SIU_INT_SCC3,
+				.end	= SIU_INT_SCC3,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_CPM_SCC4] = {
+		.name = "fsl-cpm-scc",
+		.id	= 4,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x91A60,
+				.end	= 0x91A7F,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= SIU_INT_SCC4,
+				.end	= SIU_INT_SCC4,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_CPM_SPI] = {
+		.name = "fsl-cpm-spi",
+		.id	= 1,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x91AA0,
+				.end	= 0x91AFF,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= SIU_INT_SPI,
+				.end	= SIU_INT_SPI,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_CPM_MCC1] = {
+		.name = "fsl-cpm-mcc",
+		.id	= 1,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x91B30,
+				.end	= 0x91B3F,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= SIU_INT_MCC1,
+				.end	= SIU_INT_MCC1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_CPM_MCC2] = {
+		.name = "fsl-cpm-mcc",
+		.id	= 2,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x91B50,
+				.end	= 0x91B5F,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= SIU_INT_MCC2,
+				.end	= SIU_INT_MCC2,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_CPM_SMC1] = {
+		.name = "fsl-cpm-smc",
+		.id	= 1,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x91A80,
+				.end	= 0x91A8F,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= SIU_INT_SMC1,
+				.end	= SIU_INT_SMC1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_CPM_SMC2] = {
+		.name = "fsl-cpm-smc",
+		.id	= 2,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x91A90,
+				.end	= 0x91A9F,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= SIU_INT_SMC2,
+				.end	= SIU_INT_SMC2,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_CPM_USB] = {
+		.name = "fsl-cpm-usb",
+		.id	= 2,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x91B60,
+				.end	= 0x91B7F,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= SIU_INT_USB,
+				.end	= SIU_INT_USB,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+#endif /* CONFIG_CPM2 */
+};
+
+static int __init mach_mpc85xx_fixup(struct platform_device *pdev)
+{
+	ppc_sys_fixup_mem_resource(pdev, CCSRBAR);
+	return 0;
+}
+
+static int __init mach_mpc85xx_init(void)
+{
+	ppc_sys_device_fixup = mach_mpc85xx_fixup;
+	return 0;
+}
+
+postcore_initcall(mach_mpc85xx_init);
diff -Nru a/arch/ppc/syslib/mpc85xx_sys.c b/arch/ppc/syslib/mpc85xx_sys.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/syslib/mpc85xx_sys.c	2005-03-17 23:29:42 -06:00
@@ -0,0 +1,118 @@
+/*
+ * arch/ppc/platforms/85xx/mpc85xx_sys.c
+ *
+ * MPC85xx System descriptions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2005 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <asm/ppc_sys.h>
+
+struct ppc_sys_spec *cur_ppc_sys_spec;
+struct ppc_sys_spec ppc_sys_specs[] = {
+	{
+		.ppc_sys_name	= "8540",
+		.mask 		= 0xFFFF0000,
+		.value 		= 0x80300000,
+		.num_devices	= 10,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_FEC, MPC85xx_IIC1,
+			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
+			MPC85xx_PERFMON, MPC85xx_DUART,
+		},
+	},
+	{
+		.ppc_sys_name	= "8560",
+		.mask 		= 0xFFFF0000,
+		.value 		= 0x80700000,
+		.num_devices	= 19,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_IIC1,
+			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
+			MPC85xx_PERFMON,
+			MPC85xx_CPM_SPI, MPC85xx_CPM_I2C, MPC85xx_CPM_SCC1,
+			MPC85xx_CPM_SCC2, MPC85xx_CPM_SCC3, MPC85xx_CPM_SCC4,
+			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2, MPC85xx_CPM_FCC3,
+			MPC85xx_CPM_MCC1, MPC85xx_CPM_MCC2,
+		},
+	},
+	{
+		.ppc_sys_name	= "8541",
+		.mask 		= 0xFFFF0000,
+		.value 		= 0x80720000,
+		.num_devices	= 13,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_IIC1,
+			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
+			MPC85xx_PERFMON, MPC85xx_DUART,
+			MPC85xx_CPM_SPI, MPC85xx_CPM_I2C,
+			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2,
+		},
+	},
+	{
+		.ppc_sys_name	= "8541E",
+		.mask 		= 0xFFFF0000,
+		.value 		= 0x807A0000,
+		.num_devices	= 14,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_IIC1,
+			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
+			MPC85xx_PERFMON, MPC85xx_DUART, MPC85xx_SEC2,
+			MPC85xx_CPM_SPI, MPC85xx_CPM_I2C,
+			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2,
+		},
+	},
+	{
+		.ppc_sys_name	= "8555",
+		.mask 		= 0xFFFF0000,
+		.value 		= 0x80710000,
+		.num_devices	= 20,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_IIC1,
+			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
+			MPC85xx_PERFMON, MPC85xx_DUART,
+			MPC85xx_CPM_SPI, MPC85xx_CPM_I2C, MPC85xx_CPM_SCC1,
+			MPC85xx_CPM_SCC2, MPC85xx_CPM_SCC3,
+			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2, MPC85xx_CPM_FCC3,
+			MPC85xx_CPM_SMC1, MPC85xx_CPM_SMC2,
+			MPC85xx_CPM_USB,
+		},
+	},
+	{
+		.ppc_sys_name	= "8555E",
+		.mask 		= 0xFFFF0000,
+		.value 		= 0x80790000,
+		.num_devices	= 21,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_IIC1,
+			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
+			MPC85xx_PERFMON, MPC85xx_DUART, MPC85xx_SEC2,
+			MPC85xx_CPM_SPI, MPC85xx_CPM_I2C, MPC85xx_CPM_SCC1,
+			MPC85xx_CPM_SCC2, MPC85xx_CPM_SCC3,
+			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2, MPC85xx_CPM_FCC3,
+			MPC85xx_CPM_SMC1, MPC85xx_CPM_SMC2,
+			MPC85xx_CPM_USB,
+		},
+	},
+	{	/* default match */
+		.ppc_sys_name	= "",
+		.mask 		= 0x00000000,
+		.value 		= 0x00000000,
+	},
+};
