Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVARPpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVARPpF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 10:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVARPpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 10:45:04 -0500
Received: from de01egw02.freescale.net ([192.88.165.103]:17048 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261326AbVARPfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 10:35:25 -0500
Date: Tue, 18 Jan 2005 09:35:07 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@blarg.somerset.sps.mot.com
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH 2/4] ppc32: platform_device conversion from OCP
Message-ID: <Pine.LNX.4.61.0501180929160.11311@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Infrastructure changes to MPC85xx sub-arch from OCP to platform_device:

* Described all devices available on current MPC85xx CPUs (mem & irq) 
* Added cpu descriptions for the MPC8540, MPC8541, MPC8541, MPC8555, 
MPC8555E, and MPC8560. 
* Removed OCP usage from MPC85xx sub-arch

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	2005-01-17 22:31:44 -06:00
+++ b/arch/ppc/Kconfig	2005-01-17 22:31:44 -06:00
@@ -678,7 +678,7 @@
 
 config CPM2
 	bool
-	depends on 8260 || MPC8560
+	depends on 8260 || MPC8560 || MPC8555
 	default y
 	help
 	  The CPM2 (Communications Processor Module) is a coprocessor on
diff -Nru a/arch/ppc/platforms/85xx/Kconfig b/arch/ppc/platforms/85xx/Kconfig
--- a/arch/ppc/platforms/85xx/Kconfig	2005-01-17 22:31:44 -06:00
+++ b/arch/ppc/platforms/85xx/Kconfig	2005-01-17 22:31:44 -06:00
@@ -62,11 +62,6 @@
 	depends on MPC8555_CDS
 	default y
 
-config FSL_OCP
-	bool
-	depends on 85xx
-	default y
-
 config PPC_GEN550
 	bool
 	depends on MPC8540 || SBC8560 || MPC8555
diff -Nru a/arch/ppc/platforms/85xx/Makefile b/arch/ppc/platforms/85xx/Makefile
--- a/arch/ppc/platforms/85xx/Makefile	2005-01-17 22:31:44 -06:00
+++ b/arch/ppc/platforms/85xx/Makefile	2005-01-17 22:31:44 -06:00
@@ -1,12 +1,9 @@
 #
 # Makefile for the PowerPC 85xx linux kernel.
 #
+obj-$(CONFIG_85xx)		+= mpc85xx_sys.o mpc85xx_devices.o
 
 obj-$(CONFIG_MPC8540_ADS)	+= mpc85xx_ads_common.o mpc8540_ads.o
 obj-$(CONFIG_MPC8555_CDS)	+= mpc85xx_cds_common.o
 obj-$(CONFIG_MPC8560_ADS)	+= mpc85xx_ads_common.o mpc8560_ads.o
 obj-$(CONFIG_SBC8560)		+= sbc85xx.o sbc8560.o
-
-obj-$(CONFIG_MPC8540)		+= mpc8540.o
-obj-$(CONFIG_MPC8555)		+= mpc8555.o
-obj-$(CONFIG_MPC8560)		+= mpc8560.o
diff -Nru a/arch/ppc/platforms/85xx/mpc8540.c b/arch/ppc/platforms/85xx/mpc8540.c
--- a/arch/ppc/platforms/85xx/mpc8540.c	2005-01-17 22:31:44 -06:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,97 +0,0 @@
-/*
- * arch/ppc/platforms/85xx/mpc8540.c
- *
- * MPC8540 I/O descriptions
- *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
- *
- * Copyright 2004 Freescale Semiconductor Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <asm/mpc85xx.h>
-#include <asm/ocp.h>
-
-/* These should be defined in platform code */
-extern struct ocp_gfar_data mpc85xx_tsec1_def;
-extern struct ocp_gfar_data mpc85xx_tsec2_def;
-extern struct ocp_gfar_data mpc85xx_fec_def;
-extern struct ocp_mpc_i2c_data mpc85xx_i2c1_def;
-
-/* We use offsets for paddr since we do not know at compile time
- * what CCSRBAR is, platform code should fix this up in
- * setup_arch
- *
- * Only the first IRQ is given even if a device has
- * multiple lines associated with ita
- */
-struct ocp_def core_ocp[] = {
-        { .vendor       = OCP_VENDOR_FREESCALE,
-          .function     = OCP_FUNC_IIC,
-          .index        = 0,
-          .paddr        = MPC85xx_IIC1_OFFSET,
-          .irq          = MPC85xx_IRQ_IIC1,
-          .pm           = OCP_CPM_NA,
-          .additions    = &mpc85xx_i2c1_def,
-        },
-        { .vendor       = OCP_VENDOR_FREESCALE,
-          .function     = OCP_FUNC_16550,
-          .index        = 0,
-          .paddr        = MPC85xx_UART0_OFFSET,
-          .irq          = MPC85xx_IRQ_DUART,
-          .pm           = OCP_CPM_NA,
-        },
-        { .vendor       = OCP_VENDOR_FREESCALE,
-          .function     = OCP_FUNC_16550,
-          .index        = 1,
-          .paddr        = MPC85xx_UART1_OFFSET,
-          .irq          = MPC85xx_IRQ_DUART,
-          .pm           = OCP_CPM_NA,
-        },
-        { .vendor       = OCP_VENDOR_FREESCALE,
-          .function     = OCP_FUNC_GFAR,
-          .index        = 0,
-          .paddr        = MPC85xx_ENET1_OFFSET,
-          .irq          = MPC85xx_IRQ_TSEC1_TX,
-          .pm           = OCP_CPM_NA,
-          .additions    = &mpc85xx_tsec1_def,
-        },
-        { .vendor       = OCP_VENDOR_FREESCALE,
-          .function     = OCP_FUNC_GFAR,
-          .index        = 1,
-          .paddr        = MPC85xx_ENET2_OFFSET,
-          .irq          = MPC85xx_IRQ_TSEC2_TX,
-          .pm           = OCP_CPM_NA,
-          .additions    = &mpc85xx_tsec2_def,
-        },
-        { .vendor       = OCP_VENDOR_FREESCALE,
-          .function     = OCP_FUNC_GFAR,
-          .index        = 2,
-          .paddr        = MPC85xx_ENET3_OFFSET,
-          .irq          = MPC85xx_IRQ_FEC,
-          .pm           = OCP_CPM_NA,
-          .additions    = &mpc85xx_fec_def,
-        },
-        { .vendor       = OCP_VENDOR_FREESCALE,
-          .function     = OCP_FUNC_DMA,
-          .index        = 0,
-          .paddr        = MPC85xx_DMA_OFFSET,
-          .irq          = MPC85xx_IRQ_DMA0,
-          .pm           = OCP_CPM_NA,
-        },
-        { .vendor       = OCP_VENDOR_FREESCALE,
-          .function     = OCP_FUNC_PERFMON,
-          .index        = 0,
-          .paddr        = MPC85xx_PERFMON_OFFSET,
-          .irq          = MPC85xx_IRQ_PERFMON,
-          .pm           = OCP_CPM_NA,
-        },
-        { .vendor       = OCP_VENDOR_INVALID
-        }
-};
diff -Nru a/arch/ppc/platforms/85xx/mpc8555.c b/arch/ppc/platforms/85xx/mpc8555.c
--- a/arch/ppc/platforms/85xx/mpc8555.c	2005-01-17 22:31:44 -06:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,95 +0,0 @@
-/*
- * arch/ppc/platform/85xx/mpc8555.c
- *
- * MPC8555 I/O descriptions
- *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
- *
- * Copyright 2004 Freescale Semiconductor Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <asm/mpc85xx.h>
-#include <asm/ocp.h>
-
-/* These should be defined in platform code */
-extern struct ocp_gfar_data mpc85xx_tsec1_def;
-extern struct ocp_gfar_data mpc85xx_tsec2_def;
-extern struct ocp_mpc_i2c_data mpc85xx_i2c1_def;
-
-/* We use offsets for paddr since we do not know at compile time
- * what CCSRBAR is, platform code should fix this up in
- * setup_arch
- *
- * Only the first IRQ is given even if a device has
- * multiple lines associated with ita
- */
-struct ocp_def core_ocp[] = {
-        { .vendor       = OCP_VENDOR_FREESCALE,
-          .function     = OCP_FUNC_IIC,
-          .index        = 0,
-          .paddr        = MPC85xx_IIC1_OFFSET,
-          .irq          = MPC85xx_IRQ_IIC1,
-          .pm           = OCP_CPM_NA,
-	  .additions	= &mpc85xx_i2c1_def,
-        },
-        { .vendor       = OCP_VENDOR_FREESCALE,
-          .function     = OCP_FUNC_16550,
-          .index        = 0,
-          .paddr        = MPC85xx_UART0_OFFSET,
-          .irq          = MPC85xx_IRQ_DUART,
-          .pm           = OCP_CPM_NA,
-        },
-        { .vendor       = OCP_VENDOR_FREESCALE,
-          .function     = OCP_FUNC_16550,
-          .index        = 1,
-          .paddr        = MPC85xx_UART1_OFFSET,
-          .irq          = MPC85xx_IRQ_DUART,
-          .pm           = OCP_CPM_NA,
-        },
-        { .vendor       = OCP_VENDOR_FREESCALE,
-          .function     = OCP_FUNC_GFAR,
-          .index        = 0,
-          .paddr        = MPC85xx_ENET1_OFFSET,
-          .irq          = MPC85xx_IRQ_TSEC1_TX,
-          .pm           = OCP_CPM_NA,
-          .additions    = &mpc85xx_tsec1_def,
-        },
-        { .vendor       = OCP_VENDOR_FREESCALE,
-          .function     = OCP_FUNC_GFAR,
-          .index        = 1,
-          .paddr        = MPC85xx_ENET2_OFFSET,
-          .irq          = MPC85xx_IRQ_TSEC2_TX,
-          .pm           = OCP_CPM_NA,
-          .additions    = &mpc85xx_tsec2_def,
-        },
-        { .vendor       = OCP_VENDOR_FREESCALE,
-          .function     = OCP_FUNC_DMA,
-          .index        = 0,
-          .paddr        = MPC85xx_DMA_OFFSET,
-          .irq          = MPC85xx_IRQ_DMA0,
-          .pm           = OCP_CPM_NA,
-        },
-        { .vendor       = OCP_VENDOR_FREESCALE,
-          .function     = OCP_FUNC_SEC2,
-          .index        = 0,
-          .paddr        = MPC85xx_SEC2_OFFSET,
-          .irq          = MPC85xx_IRQ_SEC2,
-          .pm           = OCP_CPM_NA,
-	},
-	{ .vendor       = OCP_VENDOR_FREESCALE,
-          .function     = OCP_FUNC_PERFMON,
-          .index        = 0,
-          .paddr        = MPC85xx_PERFMON_OFFSET,
-          .irq          = MPC85xx_IRQ_PERFMON,
-          .pm           = OCP_CPM_NA,
-        },
-        { .vendor       = OCP_VENDOR_INVALID
-        }
-};
diff -Nru a/arch/ppc/platforms/85xx/mpc8560.c b/arch/ppc/platforms/85xx/mpc8560.c
--- a/arch/ppc/platforms/85xx/mpc8560.c	2005-01-17 22:31:44 -06:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,74 +0,0 @@
-/*
- * arch/ppc/platforms/85xx/mpc8560.c
- * 
- * MPC8560 I/O descriptions
- * 
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
- *
- * Copyright 2004 Freescale Semiconductor Inc.
- * 
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <asm/mpc85xx.h>
-#include <asm/ocp.h>
-
-/* These should be defined in platform code */
-extern struct ocp_gfar_data mpc85xx_tsec1_def;
-extern struct ocp_gfar_data mpc85xx_tsec2_def;
-extern struct ocp_mpc_i2c_data mpc85xx_i2c1_def;
-
-/* We use offsets for paddr since we do not know at compile time
- * what CCSRBAR is, platform code should fix this up in
- * setup_arch
- *
- * Only the first IRQ is given even if a device has
- * multiple lines associated with ita
- */
-struct ocp_def core_ocp[] = {
-        { .vendor       = OCP_VENDOR_FREESCALE,
-          .function     = OCP_FUNC_IIC,
-          .index        = 0,
-          .paddr        = MPC85xx_IIC1_OFFSET,
-          .irq          = MPC85xx_IRQ_IIC1,
-          .pm           = OCP_CPM_NA,
-          .additions    = &mpc85xx_i2c1_def,
-        },
-        { .vendor       = OCP_VENDOR_FREESCALE,
-          .function     = OCP_FUNC_GFAR,
-          .index        = 0,
-          .paddr        = MPC85xx_ENET1_OFFSET,
-          .irq          = MPC85xx_IRQ_TSEC1_TX,
-          .pm           = OCP_CPM_NA,
-          .additions    = &mpc85xx_tsec1_def,
-        },
-        { .vendor       = OCP_VENDOR_FREESCALE,
-          .function     = OCP_FUNC_GFAR,
-          .index        = 1,
-          .paddr        = MPC85xx_ENET2_OFFSET,
-          .irq          = MPC85xx_IRQ_TSEC2_TX,
-          .pm           = OCP_CPM_NA,
-          .additions    = &mpc85xx_tsec2_def,
-        },
-        { .vendor       = OCP_VENDOR_FREESCALE,
-          .function     = OCP_FUNC_DMA,
-          .index        = 0,
-          .paddr        = MPC85xx_DMA_OFFSET,
-          .irq          = MPC85xx_IRQ_DMA0,
-          .pm           = OCP_CPM_NA,
-        },
-        { .vendor       = OCP_VENDOR_FREESCALE,
-          .function     = OCP_FUNC_PERFMON,
-          .index        = 0,
-          .paddr        = MPC85xx_PERFMON_OFFSET,
-          .irq          = MPC85xx_IRQ_PERFMON,
-          .pm           = OCP_CPM_NA,
-        },
-        { .vendor       = OCP_VENDOR_INVALID
-        }
-};
diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_devices.c b/arch/ppc/platforms/85xx/mpc85xx_devices.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/platforms/85xx/mpc85xx_devices.c	2005-01-17 22:31:44 -06:00
@@ -0,0 +1,531 @@
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
diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_sys.c b/arch/ppc/platforms/85xx/mpc85xx_sys.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/platforms/85xx/mpc85xx_sys.c	2005-01-17 22:31:44 -06:00
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
+		.ppc_sys_name	= "MPC8540",
+		.mask 		= 0xFFFF0000,
+		.value 		= 0x80300000,
+		.num_devices	= 9,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_FEC, MPC85xx_IIC1,
+			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
+			MPC85xx_PERFMON,
+		},
+	},
+	{
+		.ppc_sys_name	= "MPC8560",
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
+		.ppc_sys_name	= "MPC8541",
+		.mask 		= 0xFFFF0000,
+		.value 		= 0x80720000,
+		.num_devices	= 12,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_IIC1,
+			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
+			MPC85xx_PERFMON,
+			MPC85xx_CPM_SPI, MPC85xx_CPM_I2C,
+			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2,
+		},
+	},
+	{
+		.ppc_sys_name	= "MPC8541E",
+		.mask 		= 0xFFFF0000,
+		.value 		= 0x807A0000,
+		.num_devices	= 13,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_IIC1,
+			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
+			MPC85xx_PERFMON, MPC85xx_SEC2,
+			MPC85xx_CPM_SPI, MPC85xx_CPM_I2C,
+			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2,
+		},
+	},
+	{
+		.ppc_sys_name	= "MPC8555",
+		.mask 		= 0xFFFF0000,
+		.value 		= 0x80710000,
+		.num_devices	= 19,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_IIC1,
+			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
+			MPC85xx_PERFMON,
+			MPC85xx_CPM_SPI, MPC85xx_CPM_I2C, MPC85xx_CPM_SCC1,
+			MPC85xx_CPM_SCC2, MPC85xx_CPM_SCC3,
+			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2, MPC85xx_CPM_FCC3,
+			MPC85xx_CPM_SMC1, MPC85xx_CPM_SMC2,
+			MPC85xx_CPM_USB,
+		},
+	},
+	{
+		.ppc_sys_name	= "MPC8555E",
+		.mask 		= 0xFFFF0000,
+		.value 		= 0x80790000,
+		.num_devices	= 20,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_IIC1,
+			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
+			MPC85xx_PERFMON, MPC85xx_SEC2,
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
diff -Nru a/arch/ppc/syslib/ppc85xx_common.c b/arch/ppc/syslib/ppc85xx_common.c
--- a/arch/ppc/syslib/ppc85xx_common.c	2005-01-17 22:31:44 -06:00
+++ b/arch/ppc/syslib/ppc85xx_common.c	2005-01-17 22:31:44 -06:00
@@ -20,7 +20,6 @@
 
 #include <asm/mpc85xx.h>
 #include <asm/mmu.h>
-#include <asm/ocp.h>
 
 /* ************************************************************************ */
 /* Return the value of CCSRBAR for the current board */
@@ -29,18 +28,6 @@
 get_ccsrbar(void)
 {
         return BOARD_CCSRBAR;
-}
-
-/* ************************************************************************ */
-/* Update the 85xx OCP tables paddr field */
-void
-mpc85xx_update_paddr_ocp(struct ocp_device *dev, void *arg)
-{
-	phys_addr_t ccsrbar;
-	if (arg) {
-		ccsrbar = *(phys_addr_t *)arg;
-		dev->def->paddr += ccsrbar;
-	}
 }
 
 EXPORT_SYMBOL(get_ccsrbar);
diff -Nru a/arch/ppc/syslib/ppc85xx_common.h b/arch/ppc/syslib/ppc85xx_common.h
--- a/arch/ppc/syslib/ppc85xx_common.h	2005-01-17 22:31:44 -06:00
+++ b/arch/ppc/syslib/ppc85xx_common.h	2005-01-17 22:31:44 -06:00
@@ -18,12 +18,8 @@
 
 #include <linux/config.h>
 #include <linux/init.h>
-#include <asm/ocp.h>
 
 /* Provide access to ccsrbar for any modules, etc */
 phys_addr_t get_ccsrbar(void);
-
-/* Update the 85xx OCP tables paddr field */
-void mpc85xx_update_paddr_ocp(struct ocp_device *dev, void *ccsrbar);
 
 #endif /* __PPC_SYSLIB_PPC85XX_COMMON_H */
diff -Nru a/arch/ppc/syslib/ppc85xx_setup.c b/arch/ppc/syslib/ppc85xx_setup.c
--- a/arch/ppc/syslib/ppc85xx_setup.c	2005-01-17 22:31:44 -06:00
+++ b/arch/ppc/syslib/ppc85xx_setup.c	2005-01-17 22:31:44 -06:00
@@ -27,7 +27,6 @@
 #include <asm/mpc85xx.h>
 #include <asm/immap_85xx.h>
 #include <asm/mmu.h>
-#include <asm/ocp.h>
 #include <asm/kgdb.h>
 
 #include <syslib/ppc85xx_setup.h>
diff -Nru a/include/asm-ppc/irq.h b/include/asm-ppc/irq.h
--- a/include/asm-ppc/irq.h	2005-01-17 22:31:44 -06:00
+++ b/include/asm-ppc/irq.h	2005-01-17 22:31:44 -06:00
@@ -199,6 +199,7 @@
 #define	SIU_INT_RISC		((uint)0x03+CPM_IRQ_OFFSET)
 #define	SIU_INT_SMC1		((uint)0x04+CPM_IRQ_OFFSET)
 #define	SIU_INT_SMC2		((uint)0x05+CPM_IRQ_OFFSET)
+#define	SIU_INT_USB		((uint)0x0b+CPM_IRQ_OFFSET)
 #define	SIU_INT_TIMER1		((uint)0x0c+CPM_IRQ_OFFSET)
 #define	SIU_INT_TIMER2		((uint)0x0d+CPM_IRQ_OFFSET)
 #define	SIU_INT_TIMER3		((uint)0x0e+CPM_IRQ_OFFSET)
diff -Nru a/include/asm-ppc/mpc85xx.h b/include/asm-ppc/mpc85xx.h
--- a/include/asm-ppc/mpc85xx.h	2005-01-17 22:31:44 -06:00
+++ b/include/asm-ppc/mpc85xx.h	2005-01-17 22:31:44 -06:00
@@ -103,6 +103,14 @@
 #define MPC85xx_CPM_SIZE	(0x40000)
 #define MPC85xx_DMA_OFFSET	(0x21000)
 #define MPC85xx_DMA_SIZE	(0x01000)
+#define MPC85xx_DMA0_OFFSET	(0x21100)
+#define MPC85xx_DMA0_SIZE	(0x00080)
+#define MPC85xx_DMA1_OFFSET	(0x21180)
+#define MPC85xx_DMA1_SIZE	(0x00080)
+#define MPC85xx_DMA2_OFFSET	(0x21200)
+#define MPC85xx_DMA2_SIZE	(0x00080)
+#define MPC85xx_DMA3_OFFSET	(0x21280)
+#define MPC85xx_DMA3_SIZE	(0x00080)
 #define MPC85xx_ENET1_OFFSET	(0x24000)
 #define MPC85xx_ENET1_SIZE	(0x01000)
 #define MPC85xx_ENET2_OFFSET	(0x25000)
@@ -138,6 +146,34 @@
 #else
 #define CCSRBAR BOARD_CCSRBAR
 #endif
+
+enum ppc_sys_devices {
+	MPC85xx_TSEC1,
+	MPC85xx_TSEC2,
+	MPC85xx_FEC,
+	MPC85xx_IIC1,
+	MPC85xx_DMA0,
+	MPC85xx_DMA1,
+	MPC85xx_DMA2,
+	MPC85xx_DMA3,
+	MPC85xx_DUART,
+	MPC85xx_PERFMON,
+	MPC85xx_SEC2,
+	MPC85xx_CPM_SPI,
+	MPC85xx_CPM_I2C,
+	MPC85xx_CPM_USB,
+	MPC85xx_CPM_SCC1,
+	MPC85xx_CPM_SCC2,
+	MPC85xx_CPM_SCC3,
+	MPC85xx_CPM_SCC4,
+	MPC85xx_CPM_FCC1,
+	MPC85xx_CPM_FCC2,
+	MPC85xx_CPM_FCC3,
+	MPC85xx_CPM_MCC1,
+	MPC85xx_CPM_MCC2,
+	MPC85xx_CPM_SMC1,
+	MPC85xx_CPM_SMC2,
+};
 
 #endif /* CONFIG_85xx */
 #endif /* __ASM_MPC85xx_H__ */

