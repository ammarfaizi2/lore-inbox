Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265181AbUELTUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265181AbUELTUZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 15:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265177AbUELTUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 15:20:24 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:14260 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S265181AbUELS5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 14:57:14 -0400
From: mporter@kernel.crashing.org
Message-Id: <200405121856.LAA13885@liberty.homelinux.org>
Subject: [PATCH 8/8] PPC32: PPC44x ports for new OCP
To: akpm@osdl.org
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Date: Wed, 12 May 2004 11:56:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Merge all current PPC44x ports against new OCP.
Please apply.

diff -Nru a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
--- a/arch/ppc/platforms/4xx/Kconfig	Wed May 12 09:25:20 2004
+++ b/arch/ppc/platforms/4xx/Kconfig	Wed May 12 09:25:20 2004
@@ -16,6 +16,11 @@
 	help
 	  This option enables support for the IBM NP405H evaluation board.
 
+config BUBINGA
+	bool "Bubinga"
+	help
+	  This option enables support for the IBM 405EP evaluation board.
+
 config CPCI405
 	bool "CPCI405"
 	help
@@ -122,7 +127,7 @@
 
 config IBM_OCP
 	bool
-	depends on ASH || CPCI405 || EBONY || EP405 || OCOTEA || REDWOOD_5 || REDWOOD_6 || SYCAMORE || WALNUT
+	depends on ASH || BUBINGA || CPCI405 || EBONY || EP405 || OCOTEA || REDWOOD_5 || REDWOOD_6 || SYCAMORE || WALNUT
 	default y
 
 config IBM_EMAC4
@@ -132,7 +137,7 @@
 
 config BIOS_FIXUP
 	bool
-	depends on EP405 || SYCAMORE || WALNUT
+	depends on BUBINGA || EP405 || SYCAMORE || WALNUT
 	default y
 
 config 403GCX
@@ -140,6 +145,11 @@
 	depends OAK
 	default y
 
+config 405EP
+	bool
+	depends on BUBINGA
+	default y
+
 config 405GP
 	bool
 	depends on CPCI405 || EP405 || WALNUT
@@ -148,6 +158,7 @@
 config 405GPR
 	bool
 	depends on SYCAMORE
+	default y
 
 config STB03xxx
 	bool
@@ -161,7 +172,7 @@
 
 config IBM_OPENBIOS
 	bool
-	depends on ASH || REDWOOD_5 || REDWOOD_6 || SYCAMORE || WALNUT
+	depends on ASH || BUBINGA || REDWOOD_5 || REDWOOD_6 || SYCAMORE || WALNUT
 	default y
 
 config PM
diff -Nru a/arch/ppc/platforms/4xx/Makefile b/arch/ppc/platforms/4xx/Makefile
--- a/arch/ppc/platforms/4xx/Makefile	Wed May 12 09:25:20 2004
+++ b/arch/ppc/platforms/4xx/Makefile	Wed May 12 09:25:20 2004
@@ -5,6 +5,7 @@
 obj-$(CONFIG_CPCI405)		+= cpci405.o
 obj-$(CONFIG_EBONY)		+= ebony.o
 obj-$(CONFIG_EP405)		+= ep405.o
+obj-$(CONFIG_BUBINGA)		+= bubinga.o
 obj-$(CONFIG_OAK)		+= oak.o
 obj-$(CONFIG_OCOTEA)		+= ocotea.o
 obj-$(CONFIG_REDWOOD_5)		+= redwood5.o
@@ -16,6 +17,7 @@
 obj-$(CONFIG_REDWOOD_5)		+= ibmstb4.o
 obj-$(CONFIG_NP405H)		+= ibmnp405h.o
 obj-$(CONFIG_REDWOOD_6)		+= ibmstbx25.o
-obj-$(CONFIG_EBONY)		+= ibm440gp.o
-obj-$(CONFIG_OCOTEA)		+= ibm440gx.o
+obj-$(CONFIG_440GP)		+= ibm440gp.o
+obj-$(CONFIG_440GX)		+= ibm440gx.o
+obj-$(CONFIG_405EP)		+= ibm405ep.o
 obj-$(CONFIG_405GPR)		+= ibm405gpr.o
diff -Nru a/arch/ppc/platforms/4xx/ash.c b/arch/ppc/platforms/4xx/ash.c
--- a/arch/ppc/platforms/4xx/ash.c	Wed May 12 09:25:20 2004
+++ b/arch/ppc/platforms/4xx/ash.c	Wed May 12 09:25:20 2004
@@ -18,6 +18,8 @@
 #include <asm/machdep.h>
 #include <asm/pci-bridge.h>
 #include <asm/io.h>
+#include <asm/ocp.h>
+#include <asm/ibm_ocp_pci.h>
 #include <asm/todc.h>
 
 #ifdef DEBUG
@@ -53,10 +55,10 @@
 void __init
 ash_setup_arch(void)
 {
-	bd_t *bip = &__res;
-
 	ppc4xx_setup_arch();
 
+	ibm_ocp_set_emac(0, 3);
+
 #ifdef CONFIG_DEBUG_BRINGUP
 	int i;
 	printk("\n");
@@ -96,8 +98,6 @@
 void __init
 bios_fixup(struct pci_controller *hose, struct pcil0_regs *pcip)
 {
-
-	unsigned int bar_response, bar;
 	/*
 	 * Expected PCI mapping:
 	 *
diff -Nru a/arch/ppc/platforms/4xx/ebony.c b/arch/ppc/platforms/4xx/ebony.c
--- a/arch/ppc/platforms/4xx/ebony.c	Wed May 12 09:25:20 2004
+++ b/arch/ppc/platforms/4xx/ebony.c	Wed May 12 09:25:20 2004
@@ -41,6 +41,7 @@
 #include <asm/dma.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
+#include <asm/ocp.h>
 #include <asm/pci-bridge.h>
 #include <asm/time.h>
 #include <asm/todc.h>
@@ -119,9 +120,6 @@
 
 extern void abort(void);
 
-/* Global Variables */
-bd_t __res;
-
 static void __init
 ebony_calibrate_decr(void)
 {
@@ -308,7 +306,9 @@
 ebony_setup_arch(void)
 {
 	unsigned char * vpd_base;
-	struct ibm440gp_clocks clocks;
+	struct ibm44x_clocks clocks;
+	struct ocp_def *def;
+	struct ocp_func_emac_data *emacdata;
 
 #if !defined(CONFIG_BDI_SWITCH)
 	/*
@@ -318,10 +318,15 @@
         mtspr(SPRN_DBCR0, (DBCR0_TDE | DBCR0_IDM));
 #endif
 
-	/* Retrieve MAC addresses */
+	/* Set mac_addr for each EMAC */
 	vpd_base = ioremap64(EBONY_VPD_BASE, EBONY_VPD_SIZE);
-	memcpy(__res.bi_enetaddr[0],EBONY_NA0_ADDR(vpd_base),6);
-	memcpy(__res.bi_enetaddr[1],EBONY_NA1_ADDR(vpd_base),6);
+	def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 0);
+	emacdata = def->additions;
+	memcpy(emacdata->mac_addr, EBONY_NA0_ADDR(vpd_base), 6);
+	def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 1);
+	emacdata = def->additions;
+	memcpy(emacdata->mac_addr, EBONY_NA1_ADDR(vpd_base), 6);
+	iounmap(vpd_base);
 
 	/*
 	 * Determine various clocks.
@@ -330,10 +335,7 @@
 	 * --ebs
 	 */
 	ibm440gp_get_clocks(&clocks, 33333333, 6 * 1843200);
-	__res.bi_opb_busfreq = clocks.opb;
-
-	/* Use IIC in standard (100 kHz) mode */
-	__res.bi_iic_fast[0] = __res.bi_iic_fast[1] = 0;
+	ocp_sys_info.opb_bus_freq = clocks.opb;
 
 	/* Setup TODC access */
 	TODC_INIT(TODC_TYPE_DS1743,
diff -Nru a/arch/ppc/platforms/4xx/ebony.h b/arch/ppc/platforms/4xx/ebony.h
--- a/arch/ppc/platforms/4xx/ebony.h	Wed May 12 09:25:20 2004
+++ b/arch/ppc/platforms/4xx/ebony.h	Wed May 12 09:25:20 2004
@@ -65,8 +65,6 @@
 #define UART1_IO_BASE	(u8 *) 0xE0000300
 
 #define BASE_BAUD	33000000/3/16
-#define UART0_INT	0
-#define UART1_INT	1
 
 #define STD_UART_OP(num)					\
 	{ 0, BASE_BAUD, 0, UART##num##_INT,			\
diff -Nru a/arch/ppc/platforms/4xx/ibm440gp.c b/arch/ppc/platforms/4xx/ibm440gp.c
--- a/arch/ppc/platforms/4xx/ibm440gp.c	Wed May 12 09:25:20 2004
+++ b/arch/ppc/platforms/4xx/ibm440gp.c	Wed May 12 09:25:20 2004
@@ -4,8 +4,10 @@
  * PPC440GP I/O descriptions
  *
  * Matt Porter <mporter@mvista.com>
+ * Copyright 2002-2004 MontaVista Software Inc.
  *
- * Copyright 2002 MontaVista Software Inc.
+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ * Copyright (c) 2003, 2004 Zultys Technologies
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -13,19 +15,137 @@
  * option) any later version.
  *
  */
+#include <linux/init.h>
+#include <linux/module.h>
 #include <platforms/4xx/ibm440gp.h>
 #include <asm/ocp.h>
-#include <linux/init.h>
 
-struct ocp_def core_ocp[] __initdata = {
-	{OCP_VENDOR_IBM, OCP_FUNC_OPB, PPC440GP_OPB_BASE_START, OCP_IRQ_NA, OCP_CPM_NA},
-	{OCP_VENDOR_IBM, OCP_FUNC_16550, PPC440GP_UART0_ADDR, UART0_INT, IBM_CPM_UART0},
-	{OCP_VENDOR_IBM, OCP_FUNC_16550, PPC440GP_UART1_ADDR, UART1_INT, IBM_CPM_UART1},
-	{OCP_VENDOR_IBM, OCP_FUNC_IIC, PPC440GP_IIC0_ADDR, IIC0_IRQ, IBM_CPM_IIC0},
-	{OCP_VENDOR_IBM, OCP_FUNC_IIC, PPC440GP_IIC1_ADDR, IIC1_IRQ, IBM_CPM_IIC1},
-	{OCP_VENDOR_IBM, OCP_FUNC_GPIO, PPC440GP_GPIO0_ADDR, OCP_IRQ_NA, IBM_CPM_GPIO0},
-	{OCP_VENDOR_IBM, OCP_FUNC_EMAC, PPC440GP_EMAC0_ADDR, BL_MAC_ETH0, OCP_CPM_NA},
-	{OCP_VENDOR_IBM, OCP_FUNC_EMAC, PPC440GP_EMAC1_ADDR, BL_MAC_ETH1, OCP_CPM_NA},
-	{OCP_VENDOR_IBM, OCP_FUNC_ZMII, PPC440GP_ZMII_ADDR, OCP_IRQ_NA, OCP_CPM_NA},
-	{OCP_VENDOR_INVALID, OCP_FUNC_INVALID, 0x0, OCP_IRQ_NA, OCP_CPM_NA},
+static struct ocp_func_emac_data ibm440gp_emac0_def = {
+	.rgmii_idx	= -1,           /* No RGMII */
+	.rgmii_mux	= -1,           /* No RGMII */
+	.zmii_idx       = 0,            /* ZMII device index */
+	.zmii_mux       = 0,            /* ZMII input of this EMAC */
+	.mal_idx        = 0,            /* MAL device index */
+	.mal_rx_chan    = 0,            /* MAL rx channel number */
+	.mal_tx_chan    = 0,            /* MAL tx channel number */
+	.wol_irq        = 61,		/* WOL interrupt number */
+	.mdio_idx       = -1,           /* No shared MDIO */
+	.tah_idx	= -1,           /* No TAH */
+};
+
+static struct ocp_func_emac_data ibm440gp_emac1_def = {
+	.rgmii_idx	= -1,           /* No RGMII */
+	.rgmii_mux	= -1,           /* No RGMII */
+	.zmii_idx       = 0,            /* ZMII device index */
+	.zmii_mux       = 1,            /* ZMII input of this EMAC */
+	.mal_idx        = 0,            /* MAL device index */
+	.mal_rx_chan    = 1,            /* MAL rx channel number */
+	.mal_tx_chan    = 2,            /* MAL tx channel number */
+	.wol_irq        = 63,  		/* WOL interrupt number */
+	.mdio_idx       = -1,           /* No shared MDIO */
+	.tah_idx	= -1,           /* No TAH */
+};
+OCP_SYSFS_EMAC_DATA()
+
+static struct ocp_func_mal_data ibm440gp_mal0_def = {
+	.num_tx_chans   = 4,  		/* Number of TX channels */
+	.num_rx_chans   = 2,    	/* Number of RX channels */
+	.txeob_irq	= 10,		/* TX End Of Buffer IRQ  */	
+	.rxeob_irq	= 11,		/* RX End Of Buffer IRQ  */
+	.txde_irq	= 33,		/* TX Descriptor Error IRQ */
+	.rxde_irq	= 34,		/* RX Descriptor Error IRQ */
+	.serr_irq	= 32,		/* MAL System Error IRQ    */
+};
+OCP_SYSFS_MAL_DATA()
+
+static struct ocp_func_iic_data ibm440gp_iic0_def = {
+	.fast_mode	= 0,		/* Use standad mode (100Khz) */
+};
+
+static struct ocp_func_iic_data ibm440gp_iic1_def = {
+	.fast_mode	= 0,		/* Use standad mode (100Khz) */
+};
+OCP_SYSFS_IIC_DATA()
+
+struct ocp_def core_ocp[] = {
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_OPB,
+	  .index	= 0,
+	  .paddr	= 0x0000000140000000ULL,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 0,
+	  .paddr	= PPC440GP_UART0_ADDR,
+	  .irq		= UART0_INT,
+	  .pm		= IBM_CPM_UART0,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 1,
+	  .paddr	= PPC440GP_UART1_ADDR,
+	  .irq		= UART1_INT,
+	  .pm		= IBM_CPM_UART1,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_IIC,
+	  .index	= 0,
+	  .paddr	= 0x0000000140000400ULL,
+	  .irq		= 2,
+	  .pm		= IBM_CPM_IIC0,
+	  .additions	= &ibm440gp_iic0_def,
+	  .show		= &ocp_show_iic_data
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_IIC,
+	  .index	= 1,
+	  .paddr	= 0x0000000140000500ULL,
+	  .irq		= 3,
+	  .pm		= IBM_CPM_IIC1,
+	  .additions	= &ibm440gp_iic1_def,
+	  .show		= &ocp_show_iic_data
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_GPIO,
+	  .index	= 0,
+	  .paddr	= 0x0000000140000700ULL,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= IBM_CPM_GPIO0,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_MAL,
+	  .paddr	= OCP_PADDR_NA,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	  .additions	= &ibm440gp_mal0_def,
+	  .show		= &ocp_show_mal_data,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_EMAC,
+	  .index	= 0,
+	  .paddr	= 0x0000000140000800UL,
+	  .irq		= 60,
+	  .pm		= OCP_CPM_NA,
+	  .additions	= &ibm440gp_emac0_def,
+	  .show		= &ocp_show_emac_data,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_EMAC,
+	  .index	= 1,
+	  .paddr	= 0x0000000140000900ULL,
+	  .irq		= 62,
+	  .pm		= OCP_CPM_NA,
+	  .additions	= &ibm440gp_emac1_def,
+	  .show		= &ocp_show_emac_data,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_ZMII,
+	  .paddr	= 0x0000000140000780ULL,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	},
+	{ .vendor	= OCP_VENDOR_INVALID
+	}
 };
diff -Nru a/arch/ppc/platforms/4xx/ibm440gp.h b/arch/ppc/platforms/4xx/ibm440gp.h
--- a/arch/ppc/platforms/4xx/ibm440gp.h	Wed May 12 09:25:20 2004
+++ b/arch/ppc/platforms/4xx/ibm440gp.h	Wed May 12 09:25:20 2004
@@ -22,44 +22,11 @@
 
 #include <linux/config.h>
 
-#define EMAC_NUMS		2
-#define UART_NUMS		2
-#define ZMII_NUMS		1
-#define IIC_NUMS		2
-#define IIC0_IRQ		2
-#define IIC1_IRQ		3
-#define GPIO_NUMS		1
-
-/* UART location */
+/* UART */
 #define PPC440GP_UART0_ADDR	0x0000000140000200ULL
 #define PPC440GP_UART1_ADDR	0x0000000140000300ULL
-
-/* EMAC location */
-#define PPC440GP_EMAC0_ADDR	0x0000000140000800ULL
-#define PPC440GP_EMAC1_ADDR	0x0000000140000900ULL
-#define PPC440GP_EMAC_SIZE	0x70
-
-/* EMAC IRQ's */
-#define BL_MAC_WOL	61	/* WOL */
-#define BL_MAC_WOL1	63	/* WOL */
-#define BL_MAL_SERR	32	/* MAL SERR */
-#define BL_MAL_TXDE	33	/* MAL TXDE */
-#define BL_MAL_RXDE	34	/* MAL RXDE */
-#define BL_MAL_TXEOB	10	/* MAL TX EOB */
-#define BL_MAL_RXEOB	11	/* MAL RX EOB */
-#define BL_MAC_ETH0	60	/* MAC */
-#define BL_MAC_ETH1	62	/* MAC */
-
-/* ZMII location */
-#define PPC440GP_ZMII_ADDR	0x0000000140000780ULL
-#define PPC440GP_ZMII_SIZE	0x0c
-
-/* I2C location */
-#define PPC440GP_IIC0_ADDR	0x40000400
-#define PPC440GP_IIC1_ADDR	0x40000500
-
-/* GPIO location */
-#define PPC440GP_GPIO0_ADDR	0x0000000140000700ULL
+#define UART0_INT		0
+#define UART1_INT		1
 
 /* Clock and Power Management */
 #define IBM_CPM_IIC0		0x80000000	/* IIC interface */
@@ -87,9 +54,6 @@
 				| IBM_CPM_EBC | IBM_CPM_SRAM | IBM_CPM_BGO \
 				| IBM_CPM_EBM | IBM_CPM_PLB | IBM_CPM_OPB \
 				| IBM_CPM_TMRCLK | IBM_CPM_DMA | IBM_CPM_PCI)
-
-#define PPC440GP_OPB_BASE_START	0x0000000140000000ULL
-
 /*
  * Serial port defines
  */
diff -Nru a/arch/ppc/platforms/4xx/ibm440gx.c b/arch/ppc/platforms/4xx/ibm440gx.c
--- a/arch/ppc/platforms/4xx/ibm440gx.c	Wed May 12 09:25:20 2004
+++ b/arch/ppc/platforms/4xx/ibm440gx.c	Wed May 12 09:25:20 2004
@@ -1,11 +1,13 @@
 /*
- * arch/ppc/platforms/ibm440gx.c
+ * arch/ppc/platforms/4xx/ibm440gx.c
  *
  * PPC440GX I/O descriptions
  *
  * Matt Porter <mporter@mvista.com>
+ * Copyright 2002-2004 MontaVista Software Inc.
  *
- * Copyright 2002-2003 MontaVista Software Inc.
+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ * Copyright (c) 2003, 2004 Zultys Technologies
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -13,25 +15,203 @@
  * option) any later version.
  *
  */
-
-#include <linux/config.h>
 #include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/threads.h>
-#include <linux/param.h>
-#include <linux/string.h>
-#include <asm/ocp.h>
+#include <linux/module.h>
 #include <platforms/4xx/ibm440gx.h>
+#include <asm/ocp.h>
+
+static struct ocp_func_emac_data ibm440gx_emac0_def = {
+	.rgmii_idx	= -1,		/* No RGMII */
+	.rgmii_mux	= -1,		/* No RGMII */
+	.zmii_idx       = 0,            /* ZMII device index */
+	.zmii_mux       = 0,            /* ZMII input of this EMAC */
+	.mal_idx        = 0,            /* MAL device index */
+	.mal_rx_chan    = 0,            /* MAL rx channel number */
+	.mal_tx_chan    = 0,            /* MAL tx channel number */
+	.wol_irq        = 61,   	/* WOL interrupt number */
+	.mdio_idx       = -1,           /* No shared MDIO */
+	.tah_idx	= -1,		/* No TAH */
+};
+
+static struct ocp_func_emac_data ibm440gx_emac1_def = {
+	.rgmii_idx	= -1,		/* No RGMII */
+	.rgmii_mux	= -1,		/* No RGMII */
+	.zmii_idx       = 0,            /* ZMII device index */
+	.zmii_mux       = 1,            /* ZMII input of this EMAC */
+	.mal_idx        = 0,            /* MAL device index */
+	.mal_rx_chan    = 1,            /* MAL rx channel number */
+	.mal_tx_chan    = 1,            /* MAL tx channel number */
+	.wol_irq        = 63,  		/* WOL interrupt number */
+	.mdio_idx       = -1,           /* No shared MDIO */
+	.tah_idx	= -1,		/* No TAH */
+};
+
+static struct ocp_func_emac_data ibm440gx_emac2_def = {
+	.rgmii_idx	= 0,		/* RGMII device index */
+	.rgmii_mux	= 0,		/* RGMII input of this EMAC */
+	.zmii_idx       = 0,            /* ZMII device index */
+	.zmii_mux       = 2,            /* ZMII input of this EMAC */
+	.mal_idx        = 0,            /* MAL device index */
+	.mal_rx_chan    = 2,            /* MAL rx channel number */
+	.mal_tx_chan    = 2,            /* MAL tx channel number */
+	.wol_irq        = 65,  		/* WOL interrupt number */
+	.mdio_idx       = -1,           /* No shared MDIO */
+	.tah_idx	= 0,		/* TAH device index */
+	.jumbo		= 1,		/* Jumbo frames supported */
+};
+
+static struct ocp_func_emac_data ibm440gx_emac3_def = {
+	.rgmii_idx	= 0,		/* RGMII device index */
+	.rgmii_mux	= 1,		/* RGMII input of this EMAC */
+	.zmii_idx       = 0,            /* ZMII device index */
+	.zmii_mux       = 3,            /* ZMII input of this EMAC */
+	.mal_idx        = 0,            /* MAL device index */
+	.mal_rx_chan    = 3,            /* MAL rx channel number */
+	.mal_tx_chan    = 3,            /* MAL tx channel number */
+	.wol_irq        = 67,  		/* WOL interrupt number */
+	.mdio_idx       = -1,           /* No shared MDIO */
+	.tah_idx	= 1,		/* TAH device index */
+	.jumbo		= 1,		/* Jumbo frames supported */
+};
+OCP_SYSFS_EMAC_DATA()
+
+static struct ocp_func_mal_data ibm440gx_mal0_def = {
+	.num_tx_chans   = 4,    	/* Number of TX channels */
+	.num_rx_chans   = 4,    	/* Number of RX channels */
+	.txeob_irq	= 10,		/* TX End Of Buffer IRQ  */	
+	.rxeob_irq	= 11,		/* RX End Of Buffer IRQ  */
+	.txde_irq	= 33,		/* TX Descriptor Error IRQ */
+	.rxde_irq	= 34,		/* RX Descriptor Error IRQ */
+	.serr_irq	= 32,		/* MAL System Error IRQ    */
+};
+OCP_SYSFS_MAL_DATA()
+
+static struct ocp_func_iic_data ibm440gx_iic0_def = {
+	.fast_mode	= 0,		/* Use standad mode (100Khz) */
+};
+
+static struct ocp_func_iic_data ibm440gx_iic1_def = {
+	.fast_mode	= 0,		/* Use standad mode (100Khz) */
+};
+OCP_SYSFS_IIC_DATA()
 
-struct ocp_def core_ocp[] __initdata = {
-	{OCP_VENDOR_IBM, OCP_FUNC_OPB, PPC440GX_OPB_BASE_START, OCP_IRQ_NA, OCP_CPM_NA},
-	{OCP_VENDOR_IBM, OCP_FUNC_16550, PPC440GX_UART0_ADDR, UART0_IRQ, IBM_CPM_UART0},
-	{OCP_VENDOR_IBM, OCP_FUNC_16550, PPC440GX_UART1_ADDR, UART1_IRQ, IBM_CPM_UART1},
-	{OCP_VENDOR_IBM, OCP_FUNC_IIC, PPC440GX_IIC0_ADDR, IIC0_IRQ, IBM_CPM_IIC0},
-	{OCP_VENDOR_IBM, OCP_FUNC_IIC, PPC440GX_IIC1_ADDR, IIC1_IRQ, IBM_CPM_IIC1},
-	{OCP_VENDOR_IBM, OCP_FUNC_GPIO, PPC440GX_GPIO0_ADDR, OCP_IRQ_NA, IBM_CPM_GPIO0},
-	{OCP_VENDOR_IBM, OCP_FUNC_EMAC, PPC440GX_EMAC0_ADDR, BL_MAC_ETH0, OCP_CPM_NA},
-	{OCP_VENDOR_IBM, OCP_FUNC_EMAC, PPC440GX_EMAC1_ADDR, BL_MAC_ETH1, OCP_CPM_NA},
-	{OCP_VENDOR_IBM, OCP_FUNC_ZMII, PPC440GX_ZMII_ADDR, OCP_IRQ_NA, OCP_CPM_NA},
-	{OCP_VENDOR_INVALID, OCP_FUNC_INVALID, 0x0, OCP_IRQ_NA, OCP_CPM_NA},
+struct ocp_def core_ocp[] = {
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_OPB,
+	  .index	= 0,
+	  .paddr	= 0x0000000140000000ULL,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 0,
+	  .paddr	= PPC440GX_UART0_ADDR,
+	  .irq		= UART0_INT,
+	  .pm		= IBM_CPM_UART0,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 1,
+	  .paddr	= PPC440GX_UART1_ADDR,
+	  .irq		= UART1_INT,
+	  .pm		= IBM_CPM_UART1,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_IIC,
+	  .index	= 0,
+	  .paddr	= 0x0000000140000400ULL,
+	  .irq		= 2,
+	  .pm		= IBM_CPM_IIC0,
+	  .additions	= &ibm440gx_iic0_def,
+	  .show		= &ocp_show_iic_data
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_IIC,
+	  .index	= 1,
+	  .paddr	= 0x0000000140000500ULL,
+	  .irq		= 3,
+	  .pm		= IBM_CPM_IIC1,
+	  .additions	= &ibm440gx_iic1_def,
+	  .show		= &ocp_show_iic_data
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_GPIO,
+	  .index	= 0,
+	  .paddr	= 0x0000000140000700ULL,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= IBM_CPM_GPIO0,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_MAL,
+	  .paddr	= OCP_PADDR_NA,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	  .additions	= &ibm440gx_mal0_def,
+	  .show		= &ocp_show_mal_data,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_EMAC,
+	  .index	= 0,
+	  .paddr	= 0x0000000140000800ULL,
+	  .irq		= 60,
+	  .pm		= OCP_CPM_NA,
+	  .additions	= &ibm440gx_emac0_def,
+	  .show		= &ocp_show_emac_data,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_EMAC,
+	  .index	= 1,
+	  .paddr	= 0x0000000140000900ULL,
+	  .irq		= 62,
+	  .pm		= OCP_CPM_NA,
+	  .additions	= &ibm440gx_emac1_def,
+	  .show		= &ocp_show_emac_data,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_EMAC,
+	  .index	= 2,
+	  .paddr	= 0x0000000140000C00ULL,
+	  .irq		= 64,
+	  .pm		= OCP_CPM_NA,
+	  .additions	= &ibm440gx_emac2_def,
+	  .show		= &ocp_show_emac_data,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_EMAC,
+	  .index	= 3,
+	  .paddr	= 0x0000000140000E00ULL,
+	  .irq		= 66,
+	  .pm		= OCP_CPM_NA,
+	  .additions	= &ibm440gx_emac3_def,
+	  .show		= &ocp_show_emac_data,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_RGMII,
+	  .paddr	= 0x0000000140000790ULL,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_ZMII,
+	  .paddr	= 0x0000000140000780ULL,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_TAH,
+	  .index	= 0,
+	  .paddr	= 0x0000000140000b50ULL,
+	  .irq		= 68,
+	  .pm		= OCP_CPM_NA,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_TAH,
+	  .index	= 1,
+	  .paddr	= 0x0000000140000d50ULL,
+	  .irq		= 69,
+	  .pm		= OCP_CPM_NA,
+	},
+	{ .vendor	= OCP_VENDOR_INVALID
+	}
 };
diff -Nru a/arch/ppc/platforms/4xx/ibm440gx.h b/arch/ppc/platforms/4xx/ibm440gx.h
--- a/arch/ppc/platforms/4xx/ibm440gx.h	Wed May 12 09:25:20 2004
+++ b/arch/ppc/platforms/4xx/ibm440gx.h	Wed May 12 09:25:20 2004
@@ -26,53 +26,8 @@
 /* UART */
 #define PPC440GX_UART0_ADDR	0x0000000140000200ULL
 #define PPC440GX_UART1_ADDR	0x0000000140000300ULL
-#define UART0_IRQ		0
-#define UART1_IRQ		1
-
-/* EMAC */
-#define PPC440GX_EMAC0_ADDR	0x0000000140000800ULL
-#define PPC440GX_EMAC1_ADDR	0x0000000140000900ULL
-#define PPC440GX_EMAC2_ADDR	0x0000000140000C00ULL
-#define PPC440GX_EMAC3_ADDR	0x0000000140000E00ULL
-#define PPC440GX_EMAC_SIZE	0xFC
-#define EMAC_NUMS               2
-#define BL_MAC_WOL	61	/* WOL */
-#define BL_MAC_WOL1	63	/* WOL */
-#define BL_MAC_WOL2	65	/* WOL */
-#define BL_MAC_WOL3	67	/* WOL */
-#define BL_MAL_SERR	32	/* MAL SERR */
-#define BL_MAL_TXDE	33	/* MAL TXDE */
-#define BL_MAL_RXDE	34	/* MAL RXDE */
-#define BL_MAL_TXEOB	10	/* MAL TX EOB */
-#define BL_MAL_RXEOB	11	/* MAL RX EOB */
-#define BL_MAC_ETH0	60	/* MAC */
-#define BL_MAC_ETH1	62	/* MAC */
-#define BL_MAC_ETH2	64	/* MAC */
-#define BL_MAC_ETH3	66	/* MAC */
-#define BL_TAH0		68	/* TAH 0 */
-#define BL_TAH1		69	/* TAH 1 */
-
-/* TAH */
-#define PPC440GX_TAH0_ADDR	0x0000000140000B00ULL
-#define PPC440GX_TAH1_ADDR	0x0000000140000D00ULL
-#define PPC440GX_TAH_SIZE	0xFC
-
-/* ZMII */
-#define PPC440GX_ZMII_ADDR	0x0000000140000780ULL
-#define PPC440GX_ZMII_SIZE	0x0c
-
-/* RGMII */
-#define PPC440GX_RGMII_ADDR	0x0000000140000790ULL
-#define PPC440GX_RGMII_SIZE	0x0c
-
-/* IIC  */
-#define PPC440GX_IIC0_ADDR	0x40000400
-#define PPC440GX_IIC1_ADDR	0x40000500
-#define IIC0_IRQ		2
-#define IIC1_IRQ		3
-
-/* GPIO */
-#define PPC440GX_GPIO0_ADDR	0x0000000140000700ULL
+#define UART0_INT		0
+#define UART1_INT		1
 
 /* Clock and Power Management */
 #define IBM_CPM_IIC0		0x80000000	/* IIC interface */
@@ -110,10 +65,6 @@
 				| IBM_CPM_TAHOE0 | IBM_CPM_TAHOE1 \
 				| IBM_CPM_EMAC0 | IBM_CPM_EMAC1 \
 			  	| IBM_CPM_EMAC2 | IBM_CPM_EMAC3 )
-
-/* OPB */
-#define PPC440GX_OPB_BASE_START	0x0000000140000000ULL
-
 /*
  * Serial port defines
  */
diff -Nru a/arch/ppc/platforms/4xx/ocotea.c b/arch/ppc/platforms/4xx/ocotea.c
--- a/arch/ppc/platforms/4xx/ocotea.c	Wed May 12 09:25:20 2004
+++ b/arch/ppc/platforms/4xx/ocotea.c	Wed May 12 09:25:20 2004
@@ -41,16 +41,23 @@
 #include <asm/dma.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
+#include <asm/ocp.h>
 #include <asm/pci-bridge.h>
 #include <asm/time.h>
 #include <asm/todc.h>
 #include <asm/bootinfo.h>
 #include <asm/ppc4xx_pic.h>
 
-extern void abort(void);
+#include <syslib/ibm440gx_common.h>
 
-/* Global Variables */
-bd_t __res;
+/*
+ * This is a horrible kludge, we eventually need to abstract this
+ * generic PHY stuff, so the  standard phy mode defines can be
+ * easily used from arch code.
+ */
+#include "../../../../drivers/net/ibm_emac/ibm_emac_phy.h"
+
+extern void abort(void);
 
 static void __init
 ocotea_calibrate_decr(void)
@@ -202,15 +209,15 @@
 TODC_ALLOC();
 
 static void __init
-ocotea_early_serial_map(void)
+ocotea_early_serial_map(const struct ibm44x_clocks *clks)
 {
 	struct uart_port port;
 
 	/* Setup ioremapped serial port access */
 	memset(&port, 0, sizeof(port));
 	port.membase = ioremap64(PPC440GX_UART0_ADDR, 8);
-	port.irq = 0;
-	port.uartclk = BASE_BAUD * 16;
+	port.irq = UART0_INT;
+	port.uartclk = clks->uart0;
 	port.regshift = 0;
 	port.iotype = SERIAL_IO_MEM;
 	port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
@@ -221,7 +228,8 @@
 	}
 
 	port.membase = ioremap64(PPC440GX_UART1_ADDR, 8);
-	port.irq = 1;
+	port.irq = UART1_INT;
+	port.uartclk = clks->uart1;
 	port.line = 1;
 
 	if (early_serial_setup(&port) != 0) {
@@ -234,15 +242,42 @@
 {
 	unsigned char *addr;
 	unsigned long long mac64;
+	struct ocp_def *def;
+	struct ocp_func_emac_data *emacdata;
+	int i;
+	struct ibm44x_clocks clocks;
 
-	/* Retrieve MAC addresses from flash */
+	/*
+	 * Note: Current rev. board only operates in Group 4a
+	 * mode, so we always set EMAC0-1 for SMII and EMAC2-3
+	 * for RGMII (though these could run in RTBI just the same).
+	 *
+	 * The FPGA reg 3 information isn't even suitable for
+	 * determining the phy_mode, so if the board becomes
+	 * usable in !4a, it will be necessary to parse an environment
+	 * variable from the firmware or similar to properly configure
+	 * the phy_map/phy_mode.
+	 */
+	/* Set phy_map, phy_mode, and mac_addr for each EMAC */
 	addr = ioremap64(OCOTEA_MAC_BASE, OCOTEA_MAC_SIZE);
-	mac64 = simple_strtoull(addr, 0, 16);
-	memcpy(__res.bi_enetaddr[0], (char *)&mac64+2, 6);
-	mac64 = simple_strtoull(addr+OCOTEA_MAC1_OFFSET, 0, 16);
-	memcpy(__res.bi_enetaddr[1], (char *)&mac64+2, 6);
+	for (i=0; i<4; i++) {
+		mac64 = simple_strtoull(addr+OCOTEA_MAC_OFFSET*i, 0, 16);
+		def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, i);
+		emacdata = def->additions;
+		if (i < 2) {
+			emacdata->phy_map = 0x00000001;	/* Skip 0x00 */
+			emacdata->phy_mode = PHY_MODE_SMII;
+		}
+		else {
+			emacdata->phy_map = 0x0000ffff; /* Skip 0x00-0x0f */
+			emacdata->phy_mode = PHY_MODE_RGMII;
+		}
+		memcpy(emacdata->mac_addr, (char *)&mac64+2, 6);
+	}
 	iounmap(addr);
 
+	ibm440gx_tah_enable();
+
 #if !defined(CONFIG_BDI_SWITCH)
 	/*
 	 * The Abatron BDI JTAG debugger does not tolerate others
@@ -251,6 +286,15 @@
         mtspr(SPRN_DBCR0, (DBCR0_TDE | DBCR0_IDM));
 #endif
 
+	/*
+	 * Determine various clocks.
+	 * To be completely correct we should get SysClk
+	 * from FPGA, because it can be changed by on-board switches
+	 * --ebs
+	 */
+	ibm440gx_get_clocks(&clocks, 33333333, 6 * 1843200);
+	ocp_sys_info.opb_bus_freq = clocks.opb;
+
 	/* Setup TODC access */
 	TODC_INIT(TODC_TYPE_DS1743,
 			0,
@@ -279,7 +323,7 @@
 	conswitchp = &dummy_con;
 #endif
 
-	ocotea_early_serial_map();
+	ocotea_early_serial_map(&clocks);
 
 	/* Identify the system */
 	printk("IBM Ocotea port (MontaVista Software, Inc. <source@mvista.com>)\n");
@@ -370,9 +414,6 @@
 {
 	int i;
 
-	/* Enable PPC440GP interrupt compatibility mode */
-	SDR_WRITE(DCRN_SDR_MFR,SDR_READ(DCRN_SDR_MFR) | DCRN_SDR_MFR_PCM);
-
 	ppc4xx_pic_init();
 
 	for (i = 0; i < NR_IRQS; i++)
@@ -430,6 +471,9 @@
 		unsigned long r5, unsigned long r6, unsigned long r7)
 {
 	parse_bootinfo((struct bi_record *) (r3 + KERNELBASE));
+
+	/* Disable L2-Cache due to hardware issues */
+	ibm440gx_l2c_disable();
 
 	ppc_md.setup_arch = ocotea_setup_arch;
 	ppc_md.show_cpuinfo = ocotea_show_cpuinfo;
diff -Nru a/arch/ppc/platforms/4xx/ocotea.h b/arch/ppc/platforms/4xx/ocotea.h
--- a/arch/ppc/platforms/4xx/ocotea.h	Wed May 12 09:25:20 2004
+++ b/arch/ppc/platforms/4xx/ocotea.h	Wed May 12 09:25:20 2004
@@ -25,9 +25,9 @@
 #define PPC44x_EMAC0_MR0	0xE0000800
 
 /* Location of MAC addresses in firmware */
-#define OCOTEA_MAC_BASE		(OCOTEA_SMALL_FLASH_HIGH+0xc0500)
+#define OCOTEA_MAC_BASE		(OCOTEA_SMALL_FLASH_HIGH+0xb0500)
 #define OCOTEA_MAC_SIZE		0x200
-#define OCOTEA_MAC1_OFFSET	0x100
+#define OCOTEA_MAC_OFFSET	0x100
 
 /* Default clock rate */
 #define OCOTEA_SYSCLK		25000000
@@ -37,7 +37,7 @@
 #define OCOTEA_RTC_SIZE		0x2000
 
 /* Flash */
-#define OCOTEA_FPGA_ADDR		0x0000000148300000ULL
+#define OCOTEA_FPGA_REG_0		0x0000000148300000ULL
 #define OCOTEA_BOOT_LARGE_FLASH(x)	(x & 0x40)
 #define OCOTEA_SMALL_FLASH_LOW		0x00000001ff900000ULL
 #define OCOTEA_SMALL_FLASH_HIGH		0x00000001fff00000ULL
@@ -46,6 +46,9 @@
 #define OCOTEA_LARGE_FLASH_HIGH		0x00000001ffc00000ULL
 #define OCOTEA_LARGE_FLASH_SIZE		0x400000
 
+/* FPGA_REG_3 (Ethernet Groups) */
+#define OCOTEA_FPGA_REG_3		0x0000000148300003ULL
+
 /*
  * Serial port defines
  */
@@ -57,7 +60,7 @@
 
 #define BASE_BAUD	11059200/16
 #define STD_UART_OP(num)					\
-	{ 0, BASE_BAUD, 0, UART##num##_IRQ,			\
+	{ 0, BASE_BAUD, 0, UART##num##_INT,			\
 		(ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST),	\
 		iomem_base: UART##num##_IO_BASE,		\
 		io_type: SERIAL_IO_MEM},
