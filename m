Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265179AbUELTWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265179AbUELTWg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 15:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265177AbUELTWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 15:22:36 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:20729 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S265173AbUELS4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 14:56:54 -0400
From: mporter@kernel.crashing.org
Message-Id: <200405121856.LAA13838@liberty.homelinux.org>
Subject: [PATCH 7/8] PPC32: PPC40x ports for new OCP
To: akpm@osdl.org
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Date: Wed, 12 May 2004 11:56:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Merge all current PPC40x ports against new OCP.
Please apply.

diff -Nru a/arch/ppc/platforms/4xx/ash.h b/arch/ppc/platforms/4xx/ash.h
--- a/arch/ppc/platforms/4xx/ash.h	Wed May 12 09:25:11 2004
+++ b/arch/ppc/platforms/4xx/ash.h	Wed May 12 09:25:11 2004
@@ -15,7 +15,6 @@
 #ifdef __KERNEL__
 #ifndef __ASM_ASH_H__
 #define __ASM_ASH_H__
-#include <asm/ibm_ocp.h>
 #include <platforms/4xx/ibmnp405h.h>
 
 #ifndef __ASSEMBLY__
diff -Nru a/arch/ppc/platforms/4xx/cpci405.c b/arch/ppc/platforms/4xx/cpci405.c
--- a/arch/ppc/platforms/4xx/cpci405.c	Wed May 12 09:25:11 2004
+++ b/arch/ppc/platforms/4xx/cpci405.c	Wed May 12 09:25:11 2004
@@ -22,6 +22,7 @@
 #include <asm/pci-bridge.h>
 #include <asm/machdep.h>
 #include <asm/todc.h>
+#include <asm/ocp.h>
 
 void *cpci405_nvram;
 
@@ -53,6 +54,9 @@
 cpci405_setup_arch(void)
 {
 	ppc4xx_setup_arch();
+
+	ibm_ocp_set_emac(0, 0);
+
 	TODC_INIT(TODC_TYPE_MK48T35, cpci405_nvram, cpci405_nvram, cpci405_nvram, 8);
 }
 
diff -Nru a/arch/ppc/platforms/4xx/ep405.c b/arch/ppc/platforms/4xx/ep405.c
--- a/arch/ppc/platforms/4xx/ep405.c	Wed May 12 09:25:11 2004
+++ b/arch/ppc/platforms/4xx/ep405.c	Wed May 12 09:25:11 2004
@@ -18,6 +18,7 @@
 #include <asm/pci-bridge.h>
 #include <asm/machdep.h>
 #include <asm/todc.h>
+#include <asm/ocp.h>
 #include <asm/ibm_ocp_pci.h>
 
 #undef DEBUG
@@ -58,6 +59,8 @@
 ep405_setup_arch(void)
 {
 	ppc4xx_setup_arch();
+
+	ibm_ocp_set_emac(0, 0);
 
 	if (__res.bi_nvramsize == 512*1024) {
 		/* FIXME: we should properly handle NVRTCs of different sizes */
diff -Nru a/arch/ppc/platforms/4xx/ibm405gp.c b/arch/ppc/platforms/4xx/ibm405gp.c
--- a/arch/ppc/platforms/4xx/ibm405gp.c	Wed May 12 09:25:11 2004
+++ b/arch/ppc/platforms/4xx/ibm405gp.c	Wed May 12 09:25:11 2004
@@ -1,26 +1,111 @@
 /*
- * arch/ppc/platforms/4xx/ibm405gp.c
  *
- * Author: Armin Kuster <akuster@mvista.com>
+ *    Copyright 2000-2001 MontaVista Software Inc.
+ *      Original author: Armin Kuster akuster@mvista.com
+ *
+ *    Module name: ibm405gp.c
+ *
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
  *
- * 2001 (c) MontaVista, Software, Inc.  This file is licensed under
- * the terms of the GNU General Public License version 2.  This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
  */
 
 #include <linux/config.h>
 #include <linux/init.h>
-#include <asm/ocp.h>
+#include <linux/smp.h>
+#include <linux/threads.h>
+#include <linux/param.h>
+#include <linux/string.h>
 #include <platforms/4xx/ibm405gp.h>
+#include <asm/ibm4xx.h>
+#include <asm/ocp.h>
+
+static struct ocp_func_emac_data ibm405gp_emac0_def = {
+	.rgmii_idx	= -1,		/* No RGMII */
+	.rgmii_mux	= -1,		/* No RGMII */
+	.zmii_idx	= -1,		/* ZMII device index */
+	.zmii_mux	= 0,		/* ZMII input of this EMAC */
+	.mal_idx	= 0,		/* MAL device index */
+	.mal_rx_chan	= 0,		/* MAL rx channel number */
+	.mal_tx_chan	= 0,		/* MAL tx channel number */
+	.wol_irq	= 9,		/* WOL interrupt number */
+	.mdio_idx	= -1,		/* No shared MDIO */
+	.tah_idx	= -1,		/* No TAH */
+};
+OCP_SYSFS_EMAC_DATA()
+
+static struct ocp_func_mal_data ibm405gp_mal0_def = {
+	.num_tx_chans	= 1,		/* Number of TX channels */
+	.num_rx_chans	= 1,		/* Number of RX channels */
+	.txeob_irq	= 11,		/* TX End Of Buffer IRQ  */	
+	.rxeob_irq	= 12,		/* RX End Of Buffer IRQ  */
+	.txde_irq	= 13,		/* TX Descriptor Error IRQ */
+	.rxde_irq	= 14,		/* RX Descriptor Error IRQ */
+	.serr_irq	= 10,		/* MAL System Error IRQ    */
+};
+OCP_SYSFS_MAL_DATA()
 
-struct ocp_def core_ocp[]  __initdata = {
-	{OCP_VENDOR_IBM, OCP_FUNC_OPB, OPB_BASE_START, OCP_IRQ_NA, OCP_CPM_NA},
-	{OCP_VENDOR_IBM, OCP_FUNC_16550, UART0_IO_BASE, UART0_INT,IBM_CPM_UART0},
-	{OCP_VENDOR_IBM, OCP_FUNC_16550, UART1_IO_BASE, UART1_INT, IBM_CPM_UART1},
-	{OCP_VENDOR_IBM, OCP_FUNC_IIC, IIC0_BASE, IIC0_IRQ, IBM_CPM_IIC0},
-	{OCP_VENDOR_IBM, OCP_FUNC_GPIO, GPIO0_BASE, OCP_IRQ_NA, IBM_CPM_GPIO0},
-	{OCP_VENDOR_IBM, OCP_FUNC_EMAC, EMAC0_BASE, BL_MAC_ETH0, IBM_CPM_EMAC0},
-	{OCP_VENDOR_INVALID, OCP_FUNC_INVALID, 0x0, OCP_IRQ_NA, OCP_CPM_NA},
+static struct ocp_func_iic_data ibm405gp_iic0_def = {
+	.fast_mode	= 0,		/* Use standad mode (100Khz) */
+};
+OCP_SYSFS_IIC_DATA()
 
+struct ocp_def core_ocp[] = {
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_OPB,
+	  .index	= 0,
+	  .paddr	= 0xEF600000,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 0,
+	  .paddr	= UART0_IO_BASE,
+	  .irq		= UART0_INT,
+	  .pm		= IBM_CPM_UART0
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 1,
+	  .paddr	= UART1_IO_BASE,
+	  .irq		= UART1_INT,
+	  .pm		= IBM_CPM_UART1
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_IIC,
+	  .paddr	= 0xEF600500,
+	  .irq		= 2,
+	  .pm		= IBM_CPM_IIC0,
+	  .additions	= &ibm405gp_iic0_def,
+	  .show		= &ocp_show_iic_data,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_GPIO,
+	  .paddr	= 0xEF600700,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= IBM_CPM_GPIO0
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_MAL,
+	  .paddr	= OCP_PADDR_NA,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	  .additions	= &ibm405gp_mal0_def,
+	  .show		= &ocp_show_mal_data,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_EMAC,
+	  .index	= 0,
+	  .paddr	= EMAC0_BASE,
+	  .irq		= 15,
+	  .pm		= IBM_CPM_EMAC0,
+	  .additions	= &ibm405gp_emac0_def,
+	  .show		= &ocp_show_emac_data,
+	},
+	{ .vendor	= OCP_VENDOR_INVALID
+	}
 };
diff -Nru a/arch/ppc/platforms/4xx/ibm405gp.h b/arch/ppc/platforms/4xx/ibm405gp.h
--- a/arch/ppc/platforms/4xx/ibm405gp.h	Wed May 12 09:25:11 2004
+++ b/arch/ppc/platforms/4xx/ibm405gp.h	Wed May 12 09:25:11 2004
@@ -51,9 +51,6 @@
 #define PPC4xx_ONB_IO_VADDR	PPC4xx_ONB_IO_PADDR
 #define PPC4xx_ONB_IO_SIZE	((uint)4*1024)
 
-#define OPB_BASE_START	0x40000000
-#define EBIU_BASE_START	0xF0100000
-
 /* serial port defines */
 #define RS_TABLE_SIZE	2
 
@@ -63,24 +60,8 @@
 #define PCIL0_BASE	0xEF400000
 #define UART0_IO_BASE	0xEF600300
 #define UART1_IO_BASE	0xEF600400
-#define IIC0_BASE	0xEF600500
-#define OPB0_BASE	0xEF600600
-#define GPIO0_BASE	0xEF600700
 #define EMAC0_BASE	0xEF600800
-#define BL_MAC_WOL	9	/* WOL */
-#define BL_MAL_SERR	10	/* MAL SERR */
-#define BL_MAL_TXDE	13	/* MAL TXDE */
-#define BL_MAL_RXDE	14	/* MAL RXDE */
-#define BL_MAL_TXEOB	11	/* MAL TX EOB */
-#define BL_MAL_RXEOB	12	/* MAL RX EOB */
-#define BL_MAC_ETH0	15	/* MAC */
-
-#define EMAC_NUMS	1
-#define IIC0_IRQ	2
-#define IIC1_IRQ	0
 
-#define IIC_OWN		0x55
-#define IIC_CLOCK	50
 #define BD_EMAC_ADDR(e,i) bi_enetaddr[i]
 
 #define STD_UART_OP(num)					\
diff -Nru a/arch/ppc/platforms/4xx/ibm405gpr.c b/arch/ppc/platforms/4xx/ibm405gpr.c
--- a/arch/ppc/platforms/4xx/ibm405gpr.c	Wed May 12 09:25:11 2004
+++ b/arch/ppc/platforms/4xx/ibm405gpr.c	Wed May 12 09:25:11 2004
@@ -11,17 +11,98 @@
 
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/threads.h>
+#include <linux/param.h>
+#include <linux/string.h>
+#include <platforms/4xx/ibm405gpr.h>
+#include <asm/ibm4xx.h>
 #include <asm/ocp.h>
 
-#include "ibm405gpr.h"
+static struct ocp_func_emac_data ibm405gpr_emac0_def = {
+	.rgmii_idx	= -1,		/* No RGMII */
+	.rgmii_mux	= -1,		/* No RGMII */
+	.zmii_idx	= -1,		/* ZMII device index */
+	.zmii_mux	= 0,		/* ZMII input of this EMAC */
+	.mal_idx	= 0,		/* MAL device index */
+	.mal_rx_chan	= 0,		/* MAL rx channel number */
+	.mal_tx_chan	= 0,		/* MAL tx channel number */
+	.wol_irq	= 9,		/* WOL interrupt number */
+	.mdio_idx	= -1,		/* No shared MDIO */
+	.tah_idx	= -1,		/* No TAH */
+};
+OCP_SYSFS_EMAC_DATA()
 
-struct ocp_def core_ocp[]  __initdata = {
-	{OCP_VENDOR_IBM, OCP_FUNC_OPB, OPB_BASE_START, OCP_IRQ_NA, OCP_CPM_NA},
-	{OCP_VENDOR_IBM, OCP_FUNC_16550, UART0_IO_BASE, UART0_INT,IBM_CPM_UART0},
-	{OCP_VENDOR_IBM, OCP_FUNC_16550, UART1_IO_BASE, UART1_INT, IBM_CPM_UART1},
-	{OCP_VENDOR_IBM, OCP_FUNC_IIC, IIC0_BASE, IIC0_IRQ, IBM_CPM_IIC0},
-	{OCP_VENDOR_IBM, OCP_FUNC_GPIO, GPIO0_BASE, OCP_IRQ_NA, IBM_CPM_GPIO0},
-	{OCP_VENDOR_IBM, OCP_FUNC_EMAC, EMAC0_BASE, BL_MAC_ETH0, IBM_CPM_EMAC0},
-	{OCP_VENDOR_INVALID, OCP_FUNC_INVALID, 0x0, OCP_IRQ_NA, OCP_CPM_NA},
+static struct ocp_func_mal_data ibm405gpr_mal0_def = {
+	.num_tx_chans	= 1,		/* Number of TX channels */
+	.num_rx_chans	= 1,		/* Number of RX channels */
+	.txeob_irq	= 11,		/* TX End Of Buffer IRQ  */	
+	.rxeob_irq	= 12,		/* RX End Of Buffer IRQ  */
+	.txde_irq	= 13,		/* TX Descriptor Error IRQ */
+	.rxde_irq	= 14,		/* RX Descriptor Error IRQ */
+	.serr_irq	= 10,		/* MAL System Error IRQ    */
+};
+OCP_SYSFS_MAL_DATA()
 
+static struct ocp_func_iic_data ibm405gpr_iic0_def = {
+	.fast_mode	= 0,		/* Use standad mode (100Khz) */
+};
+
+OCP_SYSFS_IIC_DATA()
+
+struct ocp_def core_ocp[] = {
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_OPB,
+	  .index	= 0,
+	  .paddr	= 0xEF600000,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 0,
+	  .paddr	= UART0_IO_BASE,
+	  .irq		= UART0_INT,
+	  .pm		= IBM_CPM_UART0
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 1,
+	  .paddr	= UART1_IO_BASE,
+	  .irq		= UART1_INT,
+	  .pm		= IBM_CPM_UART1
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_IIC,
+	  .paddr	= 0xEF600500,
+	  .irq		= 2,
+	  .pm		= IBM_CPM_IIC0,
+	  .additions	= &ibm405gpr_iic0_def,
+	  .show		= &ocp_show_iic_data,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_GPIO,
+	  .paddr	= 0xEF600700,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= IBM_CPM_GPIO0
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_MAL,
+	  .paddr	= OCP_PADDR_NA,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	  .additions	= &ibm405gpr_mal0_def,
+	  .show		= &ocp_show_mal_data,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_EMAC,
+	  .index	= 0,
+	  .paddr	= EMAC0_BASE,
+	  .irq		= 15,
+	  .pm		= IBM_CPM_EMAC0,
+	  .additions	= &ibm405gpr_emac0_def,
+	  .show		= &ocp_show_emac_data,
+	},
+	{ .vendor	= OCP_VENDOR_INVALID
+	}
 };
diff -Nru a/arch/ppc/platforms/4xx/ibm405gpr.h b/arch/ppc/platforms/4xx/ibm405gpr.h
--- a/arch/ppc/platforms/4xx/ibm405gpr.h	Wed May 12 09:25:11 2004
+++ b/arch/ppc/platforms/4xx/ibm405gpr.h	Wed May 12 09:25:11 2004
@@ -51,9 +51,6 @@
 #define PPC4xx_ONB_IO_VADDR	PPC4xx_ONB_IO_PADDR
 #define PPC4xx_ONB_IO_SIZE	((uint)4*1024)
 
-#define OPB_BASE_START	0x40000000
-#define EBIU_BASE_START	0xF0100000
-
 /* serial port defines */
 #define RS_TABLE_SIZE	2
 
@@ -63,20 +60,8 @@
 #define PCIL0_BASE	0xEF400000
 #define UART0_IO_BASE	0xEF600300
 #define UART1_IO_BASE	0xEF600400
-#define IIC0_BASE	0xEF600500
-#define OPB0_BASE	0xEF600600
-#define GPIO0_BASE	0xEF600700
 #define EMAC0_BASE	0xEF600800
-#define BL_MAC_WOL	9	/* WOL */
-#define BL_MAL_SERR	10	/* MAL SERR */
-#define BL_MAL_TXDE	13	/* MAL TXDE */
-#define BL_MAL_RXDE	14	/* MAL RXDE */
-#define BL_MAL_TXEOB	11	/* MAL TX EOB */
-#define BL_MAL_RXEOB	12	/* MAL RX EOB */
-#define BL_MAC_ETH0	15	/* MAC */
 
-#define IIC_OWN		0x55
-#define IIC_CLOCK	50
 #define BD_EMAC_ADDR(e,i) bi_enetaddr[i]
 
 #define STD_UART_OP(num)					\
diff -Nru a/arch/ppc/platforms/4xx/ibmnp405h.c b/arch/ppc/platforms/4xx/ibmnp405h.c
--- a/arch/ppc/platforms/4xx/ibmnp405h.c	Wed May 12 09:25:11 2004
+++ b/arch/ppc/platforms/4xx/ibmnp405h.c	Wed May 12 09:25:11 2004
@@ -14,21 +14,159 @@
 #include <asm/ocp.h>
 #include <platforms/4xx/ibmnp405h.h>
 
+static struct ocp_func_emac_data ibmnp405h_emac0_def = {
+	.rgmii_idx	= -1,		/* No RGMII */
+	.rgmii_mux	= -1,		/* No RGMII */
+	.zmii_idx	= 0,		/* ZMII device index */
+	.zmii_mux	= 0,		/* ZMII input of this EMAC */
+	.mal_idx	= 0,		/* MAL device index */
+	.mal_rx_chan	= 0,		/* MAL rx channel number */
+	.mal_tx_chan	= 0,		/* MAL tx channel number */
+	.wol_irq	= 41,		/* WOL interrupt number */
+	.mdio_idx	= -1,		/* No shared MDIO */
+	.tah_idx	= -1,		/* No TAH */
+};
 
+static struct ocp_func_emac_data ibmnp405h_emac1_def = {
+	.rgmii_idx	= -1,		/* No RGMII */
+	.rgmii_mux	= -1,		/* No RGMII */
+	.zmii_idx	= 0,		/* ZMII device index */
+	.zmii_mux	= 1,		/* ZMII input of this EMAC */
+	.mal_idx	= 0,		/* MAL device index */
+	.mal_rx_chan	= 1,		/* MAL rx channel number */
+	.mal_tx_chan	= 1,		/* MAL tx channel number */
+	.wol_irq	= 41,		/* WOL interrupt number */
+	.mdio_idx	= -1,		/* No shared MDIO */
+	.tah_idx	= -1,		/* No TAH */
+};
+static struct ocp_func_emac_data ibmnp405h_emac2_def = {
+	.rgmii_idx	= -1,		/* No RGMII */
+	.rgmii_mux	= -1,		/* No RGMII */
+	.zmii_idx	= 0,		/* ZMII device index */
+	.zmii_mux	= 2,		/* ZMII input of this EMAC */
+	.mal_idx	= 0,		/* MAL device index */
+	.mal_rx_chan	= 2,		/* MAL rx channel number */
+	.mal_tx_chan	= 2,		/* MAL tx channel number */
+	.wol_irq	= 41,		/* WOL interrupt number */
+	.mdio_idx	= -1,		/* No shared MDIO */
+	.tah_idx	= -1,		/* No TAH */
+};
+static struct ocp_func_emac_data ibmnp405h_emac3_def = {
+	.rgmii_idx	= -1,		/* No RGMII */
+	.rgmii_mux	= -1,		/* No RGMII */
+	.zmii_idx	= 0,		/* ZMII device index */
+	.zmii_mux	= 3,		/* ZMII input of this EMAC */
+	.mal_idx	= 0,		/* MAL device index */
+	.mal_rx_chan	= 3,		/* MAL rx channel number */
+	.mal_tx_chan	= 3,		/* MAL tx channel number */
+	.wol_irq	= 41,		/* WOL interrupt number */
+	.mdio_idx	= -1,		/* No shared MDIO */
+	.tah_idx	= -1,		/* No TAH */
+};
+OCP_SYSFS_EMAC_DATA()
+
+static struct ocp_func_mal_data ibmnp405h_mal0_def = {
+	.num_tx_chans	= 8,		/* Number of TX channels */
+	.num_rx_chans	= 4,		/* Number of RX channels */
+	.txeob_irq	= 17,		/* TX End Of Buffer IRQ  */	
+	.rxeob_irq	= 18,		/* RX End Of Buffer IRQ  */
+	.txde_irq	= 46,		/* TX Descriptor Error IRQ */
+	.rxde_irq	= 47,		/* RX Descriptor Error IRQ */
+	.serr_irq	= 45,		/* MAL System Error IRQ    */
+};
+OCP_SYSFS_MAL_DATA()
+
+static struct ocp_func_iic_data ibmnp405h_iic0_def = {
+	.fast_mode	= 0,		/* Use standad mode (100Khz) */
+};
+OCP_SYSFS_IIC_DATA()
+	
 struct ocp_def core_ocp[] = {
-//	{OCP_VENDOR_IBM, OCP_FUNC_PLB, 0x0, OCP_IRQ_NA, OCP_CPM_NA},
-	{OCP_VENDOR_IBM, OCP_FUNC_OPB, OPB_BASE_START, OCP_IRQ_NA, OCP_CPM_NA},
-	{OCP_VENDOR_IBM, OCP_FUNC_16550, UART0_IO_BASE, UART0_INT,IBM_CPM_UART0},
-	{OCP_VENDOR_IBM, OCP_FUNC_16550, UART1_IO_BASE, UART1_INT, IBM_CPM_UART1},
-	{OCP_VENDOR_IBM, OCP_FUNC_IIC, IIC0_BASE, IIC0_IRQ, IBM_CPM_IIC0},
-	{OCP_VENDOR_IBM, OCP_FUNC_GPIO, GPIO0_BASE, OCP_IRQ_NA, IBM_CPM_GPIO0},
-	{OCP_VENDOR_IBM, OCP_FUNC_EMAC, EMAC0_BASE, BL_MAC_ETH0, IBM_CPM_EMAC0},
-	{OCP_VENDOR_IBM, OCP_FUNC_EMAC, EMAC0_BASE, BL_MAC_ETH0, IBM_CPM_EMAC0},
-	{OCP_VENDOR_IBM, OCP_FUNC_EMAC, EMAC1_BASE, BL_MAC_ETH1, IBM_CPM_EMAC1},
-	{OCP_VENDOR_IBM, OCP_FUNC_EMAC, EMAC2_BASE, BL_MAC_ETH2, IBM_CPM_EMAC2},
-	{OCP_VENDOR_IBM, OCP_FUNC_EMAC, EMAC3_BASE, BL_MAC_ETH3, IBM_CPM_EMAC3},
-	{OCP_VENDOR_IBM, OCP_FUNC_PHY, ZMII0_BASE, OCP_IRQ_NA, OCP_CPM_NA},
-//	{OCP_VENDOR_IBM, OCP_FUNC_EXT, EBIU_BASE_START, OCP_IRQ_NA,IBM_CPM_EBC},
-//	{OCP_VENDOR_IBM, OCP_FUNC_PCI, PCIL0_BASE, OCP_IRQ_NA, IBM_CPM_PCI},
-	{OCP_VENDOR_INVALID, OCP_FUNC_INVALID, 0x0, OCP_IRQ_NA, OCP_CPM_NA},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_OPB,
+	  .index	= 0,
+	  .paddr	= 0xEF600000,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 0,
+	  .paddr	= UART0_IO_BASE,
+	  .irq		= UART0_INT,
+	  .pm		= IBM_CPM_UART0
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 1,
+	  .paddr	= UART1_IO_BASE,
+	  .irq		= UART1_INT,
+	  .pm		= IBM_CPM_UART1
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_IIC,
+	  .paddr	= 0xEF600500,
+	  .irq		= 2,
+	  .pm		= IBM_CPM_IIC0,
+	  .additions	= &ibmnp405h_iic0_def,
+	  .show		= &ocp_show_iic_data
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_GPIO,
+	  .paddr	= 0xEF600700,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= IBM_CPM_GPIO0
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_MAL,
+	  .paddr	= OCP_PADDR_NA,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	  .additions	= &ibmnp405h_mal0_def,
+	  .show		= &ocp_show_mal_data,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_EMAC,
+	  .index	= 0,
+	  .paddr	= EMAC0_BASE,
+	  .irq		= 37,
+	  .pm		= IBM_CPM_EMAC0,
+	  .additions	= &ibmnp405h_emac0_def,
+	  .show		= &ocp_show_emac_data,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_EMAC,
+	  .index	= 1,
+	  .paddr	= 0xEF600900,
+	  .irq		= 38,
+	  .pm		= IBM_CPM_EMAC1,
+	  .additions	= &ibmnp405h_emac1_def,
+	  .show		= &ocp_show_emac_data,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_EMAC,
+	  .index	= 2,
+	  .paddr	= 0xEF600a00,
+	  .irq		= 39,
+	  .pm		= IBM_CPM_EMAC2,
+	  .additions	= &ibmnp405h_emac2_def,
+	  .show		= &ocp_show_emac_data,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_EMAC,
+	  .index	= 3,
+	  .paddr	= 0xEF600b00,
+	  .irq		= 40,
+	  .pm		= IBM_CPM_EMAC3,
+	  .additions	= &ibmnp405h_emac3_def,
+	  .show		= &ocp_show_emac_data,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_ZMII,
+	  .paddr	= 0xEF600C10,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	},
+	{ .vendor	= OCP_VENDOR_INVALID
+	}
 };
diff -Nru a/arch/ppc/platforms/4xx/ibmnp405h.h b/arch/ppc/platforms/4xx/ibmnp405h.h
--- a/arch/ppc/platforms/4xx/ibmnp405h.h	Wed May 12 09:25:11 2004
+++ b/arch/ppc/platforms/4xx/ibmnp405h.h	Wed May 12 09:25:11 2004
@@ -14,7 +14,6 @@
 #define __ASM_IBMNP405H_H__
 
 #include <linux/config.h>
-#include <asm/ibm_ocp.h>
 
 /* ibm405.h at bottom of this file */
 
@@ -42,9 +41,6 @@
 #define PPC4xx_ONB_IO_ADDR	((uint)0xef600000)
 #define PPC4xx_ONB_IO_SIZE	((uint)4*1024)
 
-#define OPB_BASE_START	0x40000000
-#define EBIU_BASE_START	0xF0100000
-
 /* serial port defines */
 #define RS_TABLE_SIZE	4
 
@@ -53,27 +49,8 @@
 #define PCIL0_BASE	0xEF400000
 #define UART0_IO_BASE	0xEF600300
 #define UART1_IO_BASE	0xEF600400
-#define IIC0_BASE	0xEF600500
 #define OPB0_BASE	0xEF600600
-#define GPIO0_BASE	0xEF600700
 #define EMAC0_BASE	0xEF600800
-#define EMAC1_BASE	0xEF600900
-#define EMAC2_BASE	0xEF600a00
-#define EMAC3_BASE	0xEF600b00
-#define ZMII0_BASE	0xEF600C10
-#define BL_MAC_WOL	41 	/* WOL */
-#define BL_MAL_SERR	45	/* MAL SERR */
-#define BL_MAL_TXDE	46	/* MAL TXDE */
-#define BL_MAL_RXDE	47	/* MAL RXDE */
-#define BL_MAL_TXEOB	17	/* MAL TX EOB */
-#define BL_MAL_RXEOB	18	/* MAL RX EOB */
-#define BL_MAC_ETH0	37	/* MAC */
-#define BL_MAC_ETH1	38	/* MAC */
-#define BL_MAC_ETH2	39	/* MAC */
-#define BL_MAC_ETH3	40	/* MAC */
-
-#define EMAC_NUMS	4
-#define IIC0_IRQ	2
 
 #define BD_EMAC_ADDR(e,i) bi_enetaddr[e][i]
 
diff -Nru a/arch/ppc/platforms/4xx/ibmstb4.c b/arch/ppc/platforms/4xx/ibmstb4.c
--- a/arch/ppc/platforms/4xx/ibmstb4.c	Wed May 12 09:25:11 2004
+++ b/arch/ppc/platforms/4xx/ibmstb4.c	Wed May 12 09:25:11 2004
@@ -9,19 +9,75 @@
  * or implied.
  */
 
-#include <linux/config.h>
-#include <linux/module.h>
-#include "ibmstb4.h"
+#include <linux/init.h>
 #include <asm/ocp.h>
+#include <platforms/4xx/ibmstb4.h>
 
-struct ocp_def core_ocp[] = {
-	{UART, UART0_IO_BASE, UART0_INT,IBM_CPM_UART0},
-	{UART, UART1_IO_BASE, UART1_INT, IBM_CPM_UART1},
-	{UART, UART2_IO_BASE, UART2_INT, IBM_CPM_UART2},
-	{IIC, IIC0_BASE, IIC0_IRQ, IBM_CPM_IIC0},
-	{IIC, IIC1_BASE, IIC1_IRQ, IBM_CPM_IIC1},
-	{GPIO, GPIO0_BASE, OCP_IRQ_NA, IBM_CPM_GPIO0},
-	{IDE, IDE0_BASE, IDE0_IRQ, OCP_CPM_NA},
-	{USB, USB0_BASE, USB0_IRQ, IBM_CPM_USB0},
-	{OCP_NULL_TYPE, 0x0, OCP_IRQ_NA, OCP_CPM_NA},
+static struct ocp_func_iic_data ibmstb4_iic0_def = {
+	.fast_mode	= 0,		/* Use standad mode (100Khz) */
+};
+
+static struct ocp_func_iic_data ibmstb4_iic1_def = {
+	.fast_mode	= 0,		/* Use standad mode (100Khz) */
+};
+OCP_SYSFS_IIC_DATA()
+
+struct ocp_def core_ocp[] __initdata = {
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 0,
+	  .paddr	= UART0_IO_BASE,
+	  .irq		= UART0_INT,
+	  .pm		= IBM_CPM_UART0,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 1,
+	  .paddr	= UART1_IO_BASE,
+	  .irq		= UART1_INT,
+	  .pm		= IBM_CPM_UART1,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 2,
+	  .paddr	= UART2_IO_BASE,
+	  .irq		= UART2_INT,
+	  .pm		= IBM_CPM_UART2,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_IIC,
+	  .paddr	= IIC0_BASE,
+	  .irq		= IIC0_IRQ,
+	  .pm		= IBM_CPM_IIC0,
+	  .additions	= &ibmstb4_iic0_def,
+	  .show		= &ocp_show_iic_data
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_IIC,
+	  .paddr	= IIC1_BASE,
+	  .irq		= IIC1_IRQ,
+	  .pm		= IBM_CPM_IIC1,
+	  .additions	= &ibmstb4_iic1_def,
+	  .show		= &ocp_show_iic_data
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_GPIO,
+	  .paddr	= GPIO0_BASE,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= IBM_CPM_GPIO0,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_IDE,
+	  .paddr	= IDE0_BASE,
+	  .irq		= IDE0_IRQ,
+	  .pm		= OCP_CPM_NA,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_USB,
+	  .paddr	= USB0_BASE,
+	  .irq		= USB0_IRQ,
+	  .pm		= OCP_CPM_NA,
+	},
+	{ .vendor	= OCP_VENDOR_INVALID,
+	}
 };
diff -Nru a/arch/ppc/platforms/4xx/ibmstb4.h b/arch/ppc/platforms/4xx/ibmstb4.h
--- a/arch/ppc/platforms/4xx/ibmstb4.h	Wed May 12 09:25:11 2004
+++ b/arch/ppc/platforms/4xx/ibmstb4.h	Wed May 12 09:25:11 2004
@@ -14,7 +14,6 @@
 #define __ASM_IBMSTB4_H__
 
 #include <linux/config.h>
-#include <platforms/4xx/ibm_ocp.h>
 
 /* serial port defines */
 #define STB04xxx_IO_BASE	((uint)0xe0000000)
diff -Nru a/arch/ppc/platforms/4xx/ibmstbx25.c b/arch/ppc/platforms/4xx/ibmstbx25.c
--- a/arch/ppc/platforms/4xx/ibmstbx25.c	Wed May 12 09:25:11 2004
+++ b/arch/ppc/platforms/4xx/ibmstbx25.c	Wed May 12 09:25:11 2004
@@ -9,22 +9,51 @@
  * or implied.
  */
 
-#include <linux/config.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <asm/ocp.h>
-#include "ibmstbx25.h"
+#include <platforms/4xx/ibmstbx25.h>
 
-struct ocp_def core_ocp[]  __initdata = {
-	{OCP_VENDOR_IBM, OCP_FUNC_PLB, 0x0, OCP_IRQ_NA, OCP_CPM_NA},
-	{OCP_VENDOR_IBM, OCP_FUNC_OPB, OPB_BASE_START, OCP_IRQ_NA, OCP_CPM_NA},
-	{OCP_VENDOR_IBM, OCP_FUNC_16550, UART0_IO_BASE, UART0_INT,IBM_CPM_UART0},
-	{OCP_VENDOR_IBM, OCP_FUNC_16550, UART1_IO_BASE, UART1_INT, IBM_CPM_UART1},
-	{OCP_VENDOR_IBM, OCP_FUNC_16550, UART2_IO_BASE,UART2_INT, IBM_CPM_UART2},
-	{OCP_VENDOR_IBM, OCP_FUNC_IIC, IIC0_BASE, IIC0_IRQ, IBM_CPM_IIC0},
-	{OCP_VENDOR_IBM, OCP_FUNC_GPIO, GPIO0_BASE, OCP_IRQ_NA, IBM_CPM_GPIO0},
-	{OCP_VENDOR_IBM, OCP_FUNC_IDE, IDE0_BASE, IDE0_IRQ, OCP_CPM_NA},
-	{OCP_VENDOR_IBM, OCP_FUNC_EXT, EBIU_BASE_START, OCP_IRQ_NA,IBM_CPM_EBIU},
-	{OCP_VENDOR_INVALID, OCP_FUNC_INVALID, 0x0, OCP_IRQ_NA, OCP_CPM_NA},
+static struct ocp_func_iic_data ibmstbx25_iic0_def = {
+	.fast_mode	= 0,		/* Use standad mode (100Khz) */
+};
+OCP_SYSFS_IIC_DATA()
 
+struct ocp_def core_ocp[] __initdata = {
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index        = 0,
+	  .paddr	= UART0_IO_BASE,
+	  .irq		= UART0_INT,
+	  .pm		= IBM_CPM_UART0,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 1,
+	  .paddr	= UART1_IO_BASE,
+	  .irq		= UART1_INT,
+	  .pm		= IBM_CPM_UART1,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 2,
+	  .paddr	= UART2_IO_BASE,
+	  .irq		= UART2_INT,
+	  .pm		= IBM_CPM_UART2,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_IIC,
+	  .paddr	= IIC0_BASE,
+	  .irq		= IIC0_IRQ,
+	  .pm		= IBM_CPM_IIC0,
+	  .additions	= &ibmstbx25_iic0_def,
+	  .show		= &ocp_show_iic_data
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_GPIO,
+	  .paddr	= GPIO0_BASE,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= IBM_CPM_GPIO0,
+	},
+	{ .vendor	= OCP_VENDOR_INVALID
+	}
 };
diff -Nru a/arch/ppc/platforms/4xx/redwood5.c b/arch/ppc/platforms/4xx/redwood5.c
--- a/arch/ppc/platforms/4xx/redwood5.c	Wed May 12 09:25:11 2004
+++ b/arch/ppc/platforms/4xx/redwood5.c	Wed May 12 09:25:11 2004
@@ -20,8 +20,6 @@
 void __init
 redwood5_setup_arch(void)
 {
-	bd_t *bip = &__res;
-
 	ppc4xx_setup_arch();
 
 #ifdef CONFIG_DEBUG_BRINGUP
diff -Nru a/arch/ppc/platforms/4xx/sycamore.c b/arch/ppc/platforms/4xx/sycamore.c
--- a/arch/ppc/platforms/4xx/sycamore.c	Wed May 12 09:25:11 2004
+++ b/arch/ppc/platforms/4xx/sycamore.c	Wed May 12 09:25:11 2004
@@ -28,6 +28,7 @@
 #include <asm/page.h>
 #include <asm/time.h>
 #include <asm/io.h>
+#include <asm/ibm_ocp_pci.h>
 #include <asm/todc.h>
 
 #undef DEBUG
@@ -119,6 +120,8 @@
 
 	ppc4xx_setup_arch();
 
+	ibm_ocp_set_emac(0, 1);
+
 	kb_data = ioremap(SYCAMORE_PS2_BASE, 8);
 	if (!kb_data) {
 		printk(KERN_CRIT
@@ -218,21 +221,25 @@
 						(PPC405_PCI_UPPER_MEM -
 						 PPC405_PCI_MEM_BASE)) | 0x01));
 
-	/* Disable region one */
+	/* Enable inbound region one - 1GB size */
+	out_le32((void *) &(pcip->ptm1ms), 0xc0000001);
+
+	/* Disable outbound region one */
 	out_le32((void *) &(pcip->pmm[1].ma), 0x00000000);
 	out_le32((void *) &(pcip->pmm[1].la), 0x00000000);
 	out_le32((void *) &(pcip->pmm[1].pcila), 0x00000000);
 	out_le32((void *) &(pcip->pmm[1].pciha), 0x00000000);
 	out_le32((void *) &(pcip->pmm[1].ma), 0x00000000);
-	out_le32((void *) &(pcip->ptm1ms), 0x00000000);
 
-	/* Disable region two */
+	/* Disable inbound region two */
+	out_le32((void *) &(pcip->ptm2ms), 0x00000000);
+
+	/* Disable outbound region two */
 	out_le32((void *) &(pcip->pmm[2].ma), 0x00000000);
 	out_le32((void *) &(pcip->pmm[2].la), 0x00000000);
 	out_le32((void *) &(pcip->pmm[2].pcila), 0x00000000);
 	out_le32((void *) &(pcip->pmm[2].pciha), 0x00000000);
 	out_le32((void *) &(pcip->pmm[2].ma), 0x00000000);
-	out_le32((void *) &(pcip->ptm2ms), 0x00000000);
 
 	/* Zero config bars */
 	for (bar = PCI_BASE_ADDRESS_1; bar <= PCI_BASE_ADDRESS_2; bar += 4) {
@@ -283,9 +290,11 @@
 	ppc_md.setup_arch = sycamore_setup_arch;
 	ppc_md.setup_io_mappings = sycamore_map_io;
 
+#ifdef CONFIG_GEN_RTC
 	ppc_md.time_init = todc_time_init;
 	ppc_md.set_rtc_time = todc_set_rtc_time;
 	ppc_md.get_rtc_time = todc_get_rtc_time;
 	ppc_md.nvram_read_val = todc_direct_read_val;
 	ppc_md.nvram_write_val = todc_direct_write_val;
+#endif
 }
diff -Nru a/arch/ppc/platforms/4xx/walnut.c b/arch/ppc/platforms/4xx/walnut.c
--- a/arch/ppc/platforms/4xx/walnut.c	Wed May 12 09:25:11 2004
+++ b/arch/ppc/platforms/4xx/walnut.c	Wed May 12 09:25:11 2004
@@ -28,6 +28,7 @@
 #include <asm/page.h>
 #include <asm/time.h>
 #include <asm/io.h>
+#include <asm/ocp.h>
 #include <asm/ibm_ocp_pci.h>
 #include <asm/todc.h>
 
@@ -77,6 +78,8 @@
 	void *fpga_trigger;
 
 	ppc4xx_setup_arch();
+
+	ibm_ocp_set_emac(0, 0);
 
 	kb_data = ioremap(WALNUT_PS2_BASE, 8);
 	if (!kb_data) {
