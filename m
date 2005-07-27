Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262299AbVG0RiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbVG0RiF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 13:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbVG0Rfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 13:35:44 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:28105 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S262117AbVG0ReY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 13:34:24 -0400
Cc: wfarnsworth@mvista.com, linuxppc-embedded@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH][1/3] ppc32: add 440ep support
In-Reply-To: mporter@kernel.crashing.org
X-Mailer: gregkh_patchbomb
Date: Wed, 27 Jul 2005 10:34:22 -0700
Message-Id: <11224856623638@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Matt Porter <mporter@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add PPC440EP core support.  PPC440EP is a PPC440-based SoC with
a classic PPC FPU and another set of peripherals.

Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>
Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff --git a/arch/ppc/boot/simple/Makefile b/arch/ppc/boot/simple/Makefile
--- a/arch/ppc/boot/simple/Makefile
+++ b/arch/ppc/boot/simple/Makefile
@@ -61,6 +61,12 @@ zimageinitrd-$(CONFIG_IBM_OPENBIOS)	:= z
          end-$(CONFIG_EMBEDDEDBOOT)	:= embedded
         misc-$(CONFIG_EMBEDDEDBOOT)	:= misc-embedded.o
 
+      zimage-$(CONFIG_BAMBOO)		:= zImage-TREE
+zimageinitrd-$(CONFIG_BAMBOO)		:= zImage.initrd-TREE
+         end-$(CONFIG_BAMBOO)		:= bamboo
+  entrypoint-$(CONFIG_BAMBOO)		:= 0x01000000
+     extra.o-$(CONFIG_BAMBOO)		:= pibs.o
+
       zimage-$(CONFIG_EBONY)		:= zImage-TREE
 zimageinitrd-$(CONFIG_EBONY)		:= zImage.initrd-TREE
          end-$(CONFIG_EBONY)		:= ebony
diff --git a/arch/ppc/boot/simple/pibs.c b/arch/ppc/boot/simple/pibs.c
--- a/arch/ppc/boot/simple/pibs.c
+++ b/arch/ppc/boot/simple/pibs.c
@@ -91,9 +91,11 @@ load_kernel(unsigned long load_addr, int
 
 	mac64 = simple_strtoull((char *)PIBS_MAC_BASE, 0, 16);
 	memcpy(hold_residual->bi_enetaddr, (char *)&mac64+2, 6);
-#ifdef CONFIG_440GX
+#if defined(CONFIG_440GX) || defined(CONFIG_440EP)
 	mac64 = simple_strtoull((char *)(PIBS_MAC_BASE+PIBS_MAC_OFFSET), 0, 16);
 	memcpy(hold_residual->bi_enet1addr, (char *)&mac64+2, 6);
+#endif
+#ifdef CONFIG_440GX
 	mac64 = simple_strtoull((char *)(PIBS_MAC_BASE+PIBS_MAC_OFFSET*2), 0, 16);
 	memcpy(hold_residual->bi_enet2addr, (char *)&mac64+2, 6);
 	mac64 = simple_strtoull((char *)(PIBS_MAC_BASE+PIBS_MAC_OFFSET*3), 0, 16);
diff --git a/arch/ppc/kernel/cputable.c b/arch/ppc/kernel/cputable.c
--- a/arch/ppc/kernel/cputable.c
+++ b/arch/ppc/kernel/cputable.c
@@ -852,6 +852,26 @@ struct cpu_spec	cpu_specs[] = {
 
 #endif /* CONFIG_40x */
 #ifdef CONFIG_44x
+	{
+		.pvr_mask		= 0xf0000fff,
+		.pvr_value		= 0x40000850,
+		.cpu_name		= "440EP Rev. A",
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features	= COMMON_PPC, /* 440EP has an FPU */
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+	},
+	{
+		.pvr_mask		= 0xf0000fff,
+		.pvr_value		= 0x400008d3,
+		.cpu_name		= "440EP Rev. B",
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features	= COMMON_PPC, /* 440EP has an FPU */
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+	},
 	{ 	/* 440GP Rev. B */
 		.pvr_mask		= 0xf0000fff,
 		.pvr_value		= 0x40000440,
diff --git a/arch/ppc/kernel/entry.S b/arch/ppc/kernel/entry.S
--- a/arch/ppc/kernel/entry.S
+++ b/arch/ppc/kernel/entry.S
@@ -215,6 +215,7 @@ syscall_dotrace_cont:
 	lwzx	r10,r10,r0	/* Fetch system call handler [ptr] */
 	mtlr	r10
 	addi	r9,r1,STACK_FRAME_OVERHEAD
+	PPC440EP_ERR42
 	blrl			/* Call handler */
 	.globl	ret_from_syscall
 ret_from_syscall:
diff --git a/arch/ppc/kernel/head_44x.S b/arch/ppc/kernel/head_44x.S
--- a/arch/ppc/kernel/head_44x.S
+++ b/arch/ppc/kernel/head_44x.S
@@ -190,7 +190,9 @@ skpinv:	addi	r4,r4,1				/* Increment */
 
 	/* xlat fields */
 	lis	r4,UART0_PHYS_IO_BASE@h		/* RPN depends on SoC */
+#ifndef CONFIG_440EP
 	ori	r4,r4,0x0001		/* ERPN is 1 for second 4GB page */
+#endif
 
 	/* attrib fields */
 	li	r5,0
@@ -228,6 +230,16 @@ skpinv:	addi	r4,r4,1				/* Increment */
 	lis	r4,interrupt_base@h	/* IVPR only uses the high 16-bits */
 	mtspr	SPRN_IVPR,r4
 
+#ifdef CONFIG_440EP
+	/* Clear DAPUIB flag in CCR0 (enable APU between CPU and FPU) */
+	mfspr	r2,SPRN_CCR0
+	lis	r3,0xffef
+	ori	r3,r3,0xffff
+	and	r2,r2,r3
+	mtspr	SPRN_CCR0,r2
+	isync
+#endif
+
 	/*
 	 * This is where the main kernel code starts.
 	 */
diff --git a/arch/ppc/kernel/misc.S b/arch/ppc/kernel/misc.S
--- a/arch/ppc/kernel/misc.S
+++ b/arch/ppc/kernel/misc.S
@@ -1145,6 +1145,7 @@ _GLOBAL(kernel_thread)
 	stwu	r0,-16(r1)
 	mtlr	r30		/* fn addr in lr */
 	mr	r3,r31		/* load arg and call fn */
+	PPC440EP_ERR42
 	blrl
 	li	r0,__NR_exit	/* exit if function returns */
 	li	r3,0
diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
--- a/arch/ppc/platforms/4xx/Kconfig
+++ b/arch/ppc/platforms/4xx/Kconfig
@@ -68,6 +68,11 @@ choice
 	depends on 44x
 	default EBONY
 
+config BAMBOO
+	bool "Bamboo"
+	help
+	  This option enables support for the IBM PPC440EP evaluation board.
+
 config EBONY
 	bool "Ebony"
 	help
@@ -98,6 +103,12 @@ config NP405H
 	depends on ASH
 	default y
 
+config 440EP
+	bool
+	depends on BAMBOO
+	select PPC_FPU
+	default y
+
 config 440GP
 	bool
 	depends on EBONY
@@ -115,7 +126,7 @@ config 440SP
 
 config 440
 	bool
-	depends on 440GP || 440SP
+	depends on 440GP || 440SP || 440EP
 	default y
 
 config 440A
@@ -123,6 +134,11 @@ config 440A
 	depends on 440GX
 	default y
 
+config IBM440EP_ERR42
+	bool
+	depends on 440EP
+	default y
+
 # All 405-based cores up until the 405GPR and 405EP have this errata.
 config IBM405_ERR77
 	bool
@@ -142,7 +158,7 @@ config BOOKE
 
 config IBM_OCP
 	bool
-	depends on ASH || BUBINGA || CPCI405 || EBONY || EP405 || LUAN || OCOTEA || REDWOOD_5 || REDWOOD_6 || SYCAMORE || WALNUT
+	depends on ASH || BAMBOO || BUBINGA || CPCI405 || EBONY || EP405 || LUAN || OCOTEA || REDWOOD_5 || REDWOOD_6 || SYCAMORE || WALNUT
 	default y
 
 config XILINX_OCP
diff --git a/arch/ppc/platforms/4xx/Makefile b/arch/ppc/platforms/4xx/Makefile
--- a/arch/ppc/platforms/4xx/Makefile
+++ b/arch/ppc/platforms/4xx/Makefile
@@ -2,6 +2,7 @@
 # Makefile for the PowerPC 4xx linux kernel.
 
 obj-$(CONFIG_ASH)		+= ash.o
+obj-$(CONFIG_BAMBOO)		+= bamboo.o
 obj-$(CONFIG_CPCI405)		+= cpci405.o
 obj-$(CONFIG_EBONY)		+= ebony.o
 obj-$(CONFIG_EP405)		+= ep405.o
@@ -19,6 +20,7 @@ obj-$(CONFIG_405GP)		+= ibm405gp.o
 obj-$(CONFIG_REDWOOD_5)		+= ibmstb4.o
 obj-$(CONFIG_NP405H)		+= ibmnp405h.o
 obj-$(CONFIG_REDWOOD_6)		+= ibmstbx25.o
+obj-$(CONFIG_440EP)		+= ibm440ep.o
 obj-$(CONFIG_440GP)		+= ibm440gp.o
 obj-$(CONFIG_440GX)		+= ibm440gx.o
 obj-$(CONFIG_440SP)		+= ibm440sp.o
diff --git a/arch/ppc/platforms/4xx/ibm440ep.c b/arch/ppc/platforms/4xx/ibm440ep.c
new file mode 100644
--- /dev/null
+++ b/arch/ppc/platforms/4xx/ibm440ep.c
@@ -0,0 +1,220 @@
+/*
+ * arch/ppc/platforms/4xx/ibm440ep.c
+ *
+ * PPC440EP I/O descriptions
+ *
+ * Wade Farnsworth <wfarnsworth@mvista.com>
+ * Copyright 2004 MontaVista Software Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <platforms/4xx/ibm440ep.h>
+#include <asm/ocp.h>
+#include <asm/ppc4xx_pic.h>
+
+static struct ocp_func_emac_data ibm440ep_emac0_def = {
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
+static struct ocp_func_emac_data ibm440ep_emac1_def = {
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
+static struct ocp_func_mal_data ibm440ep_mal0_def = {
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
+static struct ocp_func_iic_data ibm440ep_iic0_def = {
+	.fast_mode	= 0,		/* Use standad mode (100Khz) */
+};
+
+static struct ocp_func_iic_data ibm440ep_iic1_def = {
+	.fast_mode	= 0,		/* Use standad mode (100Khz) */
+};
+OCP_SYSFS_IIC_DATA()
+
+struct ocp_def core_ocp[] = {
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_OPB,
+	  .index	= 0,
+	  .paddr	= 0x0EF600000ULL,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 0,
+	  .paddr	= PPC440EP_UART0_ADDR,
+	  .irq		= UART0_INT,
+	  .pm		= IBM_CPM_UART0,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 1,
+	  .paddr	= PPC440EP_UART1_ADDR,
+	  .irq		= UART1_INT,
+	  .pm		= IBM_CPM_UART1,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 2,
+	  .paddr	= PPC440EP_UART2_ADDR,
+	  .irq		= UART2_INT,
+	  .pm		= IBM_CPM_UART2,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 3,
+	  .paddr	= PPC440EP_UART3_ADDR,
+	  .irq		= UART3_INT,
+	  .pm		= IBM_CPM_UART3,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_IIC,
+	  .index	= 0,
+	  .paddr	= 0x0EF600700ULL,
+	  .irq		= 2,
+	  .pm		= IBM_CPM_IIC0,
+	  .additions	= &ibm440ep_iic0_def,
+	  .show		= &ocp_show_iic_data
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_IIC,
+	  .index	= 1,
+	  .paddr	= 0x0EF600800ULL,
+	  .irq		= 7,
+	  .pm		= IBM_CPM_IIC1,
+	  .additions	= &ibm440ep_iic1_def,
+	  .show		= &ocp_show_iic_data
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_GPIO,
+	  .index	= 0,
+	  .paddr	= 0x0EF600B00ULL,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= IBM_CPM_GPIO0,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_GPIO,
+	  .index	= 1,
+	  .paddr	= 0x0EF600C00ULL,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_MAL,
+	  .paddr	= OCP_PADDR_NA,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	  .additions	= &ibm440ep_mal0_def,
+	  .show		= &ocp_show_mal_data,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_EMAC,
+	  .index	= 0,
+	  .paddr	= 0x0EF600E00ULL,
+	  .irq		= 60,
+	  .pm		= OCP_CPM_NA,
+	  .additions	= &ibm440ep_emac0_def,
+	  .show		= &ocp_show_emac_data,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_EMAC,
+	  .index	= 1,
+	  .paddr	= 0x0EF600F00ULL,
+	  .irq		= 62,
+	  .pm		= OCP_CPM_NA,
+	  .additions	= &ibm440ep_emac1_def,
+	  .show		= &ocp_show_emac_data,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_ZMII,
+	  .paddr	= 0x0EF600D00ULL,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	},
+	{ .vendor	= OCP_VENDOR_INVALID
+	}
+};
+
+/* Polarity and triggering settings for internal interrupt sources */
+struct ppc4xx_uic_settings ppc4xx_core_uic_cfg[] __initdata = {
+	{ .polarity	= 0xffbffe03,
+	  .triggering   = 0xfffffe00,
+	  .ext_irq_mask = 0x000001fc,	/* IRQ0 - IRQ6 */
+	},
+	{ .polarity	= 0xffffc6ef,
+	  .triggering	= 0xffffc7ff,
+	  .ext_irq_mask = 0x00003800,	/* IRQ7 - IRQ9 */
+	},
+};
+
+static struct resource usb_gadget_resources[] = {
+	[0] = {
+		.start	= 0x050000100ULL,
+		.end 	= 0x05000017FULL,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 55,
+		.end	= 55,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static u64 dma_mask = 0xffffffffULL;
+
+static struct platform_device usb_gadget_device = {
+	.name		= "musbhsfc",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(usb_gadget_resources),
+	.resource       = usb_gadget_resources,
+	.dev		= {
+		.dma_mask = &dma_mask,
+		.coherent_dma_mask = 0xffffffffULL,
+	}
+};
+
+static struct platform_device *ibm440ep_devs[] __initdata = {
+	&usb_gadget_device,
+};
+
+static int __init
+ibm440ep_platform_add_devices(void)
+{
+	return platform_add_devices(ibm440ep_devs, ARRAY_SIZE(ibm440ep_devs));
+}
+arch_initcall(ibm440ep_platform_add_devices);
+
diff --git a/arch/ppc/platforms/4xx/ibm440ep.h b/arch/ppc/platforms/4xx/ibm440ep.h
new file mode 100644
--- /dev/null
+++ b/arch/ppc/platforms/4xx/ibm440ep.h
@@ -0,0 +1,76 @@
+/*
+ * arch/ppc/platforms/4xx/ibm440ep.h
+ *
+ * PPC440EP definitions
+ *
+ * Wade Farnsworth <wfarnsworth@mvista.com>
+ *
+ * Copyright 2002 Roland Dreier
+ * Copyright 2004 MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#ifdef __KERNEL__
+#ifndef __PPC_PLATFORMS_IBM440EP_H
+#define __PPC_PLATFORMS_IBM440EP_H
+
+#include <linux/config.h>
+#include <asm/ibm44x.h>
+
+/* UART */
+#define PPC440EP_UART0_ADDR		0x0EF600300
+#define PPC440EP_UART1_ADDR		0x0EF600400
+#define PPC440EP_UART2_ADDR		0x0EF600500
+#define PPC440EP_UART3_ADDR		0x0EF600600
+#define UART0_INT			0
+#define UART1_INT			1
+#define UART2_INT			3
+#define UART3_INT			4
+
+/* Clock and Power Management */
+#define IBM_CPM_IIC0		0x80000000	/* IIC interface */
+#define IBM_CPM_IIC1		0x40000000	/* IIC interface */
+#define IBM_CPM_PCI		0x20000000	/* PCI bridge */
+#define IBM_CPM_USB1H		0x08000000	/* USB 1.1 Host */
+#define IBM_CPM_FPU		0x04000000	/* floating point unit */
+#define IBM_CPM_CPU		0x02000000	/* processor core */
+#define IBM_CPM_DMA		0x01000000	/* DMA controller */
+#define IBM_CPM_BGO		0x00800000	/* PLB to OPB bus arbiter */
+#define IBM_CPM_BGI		0x00400000	/* OPB to PLB bridge */
+#define IBM_CPM_EBC		0x00200000	/* External Bus Controller */
+#define IBM_CPM_EBM		0x00100000	/* Ext Bus Master Interface */
+#define IBM_CPM_DMC		0x00080000	/* SDRAM peripheral controller */
+#define IBM_CPM_PLB4		0x00040000	/* PLB4 bus arbiter */
+#define IBM_CPM_PLB4x3		0x00020000	/* PLB4 to PLB3 bridge controller */
+#define IBM_CPM_PLB3x4		0x00010000	/* PLB3 to PLB4 bridge controller */
+#define IBM_CPM_PLB3		0x00008000	/* PLB3 bus arbiter */
+#define IBM_CPM_PPM		0x00002000	/* PLB Performance Monitor */
+#define IBM_CPM_UIC1		0x00001000	/* Universal Interrupt Controller */
+#define IBM_CPM_GPIO0		0x00000800	/* General Purpose IO (??) */
+#define IBM_CPM_GPT		0x00000400	/* General Purpose Timers  */
+#define IBM_CPM_UART0		0x00000200	/* serial port 0 */
+#define IBM_CPM_UART1		0x00000100	/* serial port 1 */
+#define IBM_CPM_UIC0		0x00000080	/* Universal Interrupt Controller */
+#define IBM_CPM_TMRCLK		0x00000040	/* CPU timers */
+#define IBM_CPM_EMAC0		0x00000020	/* ethernet port 0 */
+#define IBM_CPM_EMAC1		0x00000010	/* ethernet port 1 */
+#define IBM_CPM_UART2		0x00000008	/* serial port 2 */
+#define IBM_CPM_UART3		0x00000004	/* serial port 3 */
+#define IBM_CPM_USB2D		0x00000002	/* USB 2.0 Device */
+#define IBM_CPM_USB2H		0x00000001	/* USB 2.0 Host */
+
+#define DFLT_IBM4xx_PM		~(IBM_CPM_UIC0 | IBM_CPM_UIC1 | IBM_CPM_CPU \
+				| IBM_CPM_EBC | IBM_CPM_BGO | IBM_CPM_FPU \
+				| IBM_CPM_EBM | IBM_CPM_PLB4 | IBM_CPM_3x4 \
+				| IBM_CPM_PLB3 | IBM_CPM_PLB4x3 \
+				| IBM_CPM_EMAC0 | IBM_CPM_TMRCLK \
+				| IBM_CPM_DMA | IBM_CPM_PCI | IBM_CPM_EMAC1)
+
+
+#endif /* __PPC_PLATFORMS_IBM440EP_H */
+#endif /* __KERNEL__ */
diff --git a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile
+++ b/arch/ppc/syslib/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_PPCBUG_NVRAM)	+= prep_nvram
 obj-$(CONFIG_PPC_OCP)		+= ocp.o
 obj-$(CONFIG_IBM_OCP)		+= ibm_ocp.o
 obj-$(CONFIG_44x)		+= ibm44x_common.o
+obj-$(CONFIG_440EP)		+= ibm440gx_common.o
 obj-$(CONFIG_440GP)		+= ibm440gp_common.o
 obj-$(CONFIG_440GX)		+= ibm440gx_common.o
 obj-$(CONFIG_440SP)		+= ibm440gx_common.o ibm440sp_common.o
@@ -44,6 +45,7 @@ obj-$(CONFIG_PPC_CHRP)		+= open_pic.o in
 obj-$(CONFIG_PPC_PREP)		+= open_pic.o indirect_pci.o i8259.o todc_time.o
 obj-$(CONFIG_ADIR)		+= i8259.o indirect_pci.o pci_auto.o \
 					todc_time.o
+obj-$(CONFIG_BAMBOO)		+= indirect_pci.o pci_auto.o todc_time.o
 obj-$(CONFIG_CPCI690)		+= todc_time.o pci_auto.o
 obj-$(CONFIG_EBONY)		+= indirect_pci.o pci_auto.o todc_time.o
 obj-$(CONFIG_EV64260)		+= todc_time.o pci_auto.o
diff --git a/arch/ppc/syslib/ibm440gx_common.c b/arch/ppc/syslib/ibm440gx_common.c
--- a/arch/ppc/syslib/ibm440gx_common.c
+++ b/arch/ppc/syslib/ibm440gx_common.c
@@ -34,6 +34,10 @@ void __init ibm440gx_get_clocks(struct i
 	u32 plld  = CPR_READ(DCRN_CPR_PLLD);
 	u32 uart0 = SDR_READ(DCRN_SDR_UART0);
 	u32 uart1 = SDR_READ(DCRN_SDR_UART1);
+#ifdef CONFIG_440EP
+	u32 uart2 = SDR_READ(DCRN_SDR_UART2);
+	u32 uart3 = SDR_READ(DCRN_SDR_UART3);
+#endif
 
 	/* Dividers */
 	u32 fbdv   = __fix_zero((plld >> 24) & 0x1f, 32);
@@ -96,6 +100,17 @@ bypass:
 		p->uart1 = ser_clk;
 	else
 		p->uart1 = p->plb / __fix_zero(uart1 & 0xff, 256);
+#ifdef CONFIG_440EP
+	if (uart2 & 0x00800000)
+		p->uart2 = ser_clk;
+	else
+		p->uart2 = p->plb / __fix_zero(uart2 & 0xff, 256);
+	
+	if (uart3 & 0x00800000)
+		p->uart3 = ser_clk;
+	else
+		p->uart3 = p->plb / __fix_zero(uart3 & 0xff, 256);
+#endif
 }
 
 /* Issue L2C diagnostic command */
diff --git a/arch/ppc/syslib/ibm44x_common.h b/arch/ppc/syslib/ibm44x_common.h
--- a/arch/ppc/syslib/ibm44x_common.h
+++ b/arch/ppc/syslib/ibm44x_common.h
@@ -29,6 +29,10 @@ struct ibm44x_clocks {
 	unsigned int ebc;	/* PerClk */
 	unsigned int uart0;
 	unsigned int uart1;
+#ifdef CONFIG_440EP
+	unsigned int uart2;
+	unsigned int uart3;
+#endif
 };
 
 /* common 44x platform init */
diff --git a/include/asm-ppc/ibm44x.h b/include/asm-ppc/ibm44x.h
--- a/include/asm-ppc/ibm44x.h
+++ b/include/asm-ppc/ibm44x.h
@@ -35,8 +35,10 @@
 #define PPC44x_LOW_SLOT		63
 
 /* LS 32-bits of UART0 physical address location for early serial text debug */
-#ifdef CONFIG_440SP
+#if defined(CONFIG_440SP)
 #define UART0_PHYS_IO_BASE	0xf0000200
+#elif defined(CONFIG_440EP)
+#define UART0_PHYS_IO_BASE	0xe0000000
 #else
 #define UART0_PHYS_IO_BASE	0x40000200
 #endif
@@ -49,11 +51,16 @@
 /*
  * Standard 4GB "page" definitions
  */
-#ifdef CONFIG_440SP
+#if defined(CONFIG_440SP)
 #define	PPC44x_IO_PAGE		0x0000000100000000ULL
 #define	PPC44x_PCICFG_PAGE	0x0000000900000000ULL
 #define	PPC44x_PCIIO_PAGE	PPC44x_PCICFG_PAGE
 #define	PPC44x_PCIMEM_PAGE	0x0000000a00000000ULL
+#elif defined(CONFIG_440EP)
+#define PPC44x_IO_PAGE		0x0000000000000000ULL
+#define PPC44x_PCICFG_PAGE	0x0000000000000000ULL
+#define PPC44x_PCIIO_PAGE	PPC44x_PCICFG_PAGE
+#define PPC44x_PCIMEM_PAGE	0x0000000000000000ULL
 #else
 #define	PPC44x_IO_PAGE		0x0000000100000000ULL
 #define	PPC44x_PCICFG_PAGE	0x0000000200000000ULL
@@ -64,7 +71,7 @@
 /*
  * 36-bit trap ranges
  */
-#ifdef CONFIG_440SP
+#if defined(CONFIG_440SP)
 #define PPC44x_IO_LO		0xf0000000UL
 #define PPC44x_IO_HI		0xf0000fffUL
 #define PPC44x_PCI0CFG_LO	0x0ec00000UL
@@ -75,6 +82,13 @@
 #define PPC44x_PCI2CFG_HI	0x2ec00007UL
 #define PPC44x_PCIMEM_LO	0x80000000UL
 #define PPC44x_PCIMEM_HI	0xdfffffffUL
+#elif defined(CONFIG_440EP)
+#define PPC44x_IO_LO		0xef500000UL
+#define PPC44x_IO_HI		0xefffffffUL
+#define PPC44x_PCI0CFG_LO	0xeec00000UL
+#define PPC44x_PCI0CFG_HI	0xeecfffffUL
+#define PPC44x_PCIMEM_LO	0xa0000000UL
+#define PPC44x_PCIMEM_HI	0xdfffffffUL
 #else
 #define PPC44x_IO_LO		0x40000000UL
 #define PPC44x_IO_HI		0x40000fffUL
@@ -152,6 +166,12 @@
 #define DCRN_SDR_UART0		0x0120
 #define DCRN_SDR_UART1		0x0121
 
+#ifdef CONFIG_440EP
+#define DCRN_SDR_UART2		0x0122
+#define DCRN_SDR_UART3		0x0123
+#define DCRN_SDR_CUST0		0x4000
+#endif
+
 /* SDR read/write helper macros */
 #define SDR_READ(offset) ({\
 	mtdcr(DCRN_SDR_CONFIG_ADDR, offset); \
@@ -169,6 +189,14 @@
 #define DCRNCAP_DMA_SG		1	/* have DMA scatter/gather capability */
 #define DCRN_MAL_BASE		0x180
 
+#ifdef CONFIG_440EP
+#define DCRN_DMA2P40_BASE	0x300
+#define DCRN_DMA2P41_BASE	0x308
+#define DCRN_DMA2P42_BASE	0x310
+#define DCRN_DMA2P43_BASE	0x318
+#define DCRN_DMA2P4SR_BASE	0x320
+#endif
+
 /* UIC */
 #define DCRN_UIC0_BASE	0xc0
 #define DCRN_UIC1_BASE	0xd0
diff --git a/include/asm-ppc/ibm4xx.h b/include/asm-ppc/ibm4xx.h
--- a/include/asm-ppc/ibm4xx.h
+++ b/include/asm-ppc/ibm4xx.h
@@ -97,6 +97,10 @@ void ppc4xx_init(unsigned long r3, unsig
 
 #elif CONFIG_44x
 
+#if defined(CONFIG_BAMBOO)
+#include <platforms/4xx/bamboo.h>
+#endif
+
 #if defined(CONFIG_EBONY)
 #include <platforms/4xx/ebony.h>
 #endif
diff --git a/include/asm-ppc/ppc_asm.h b/include/asm-ppc/ppc_asm.h
--- a/include/asm-ppc/ppc_asm.h
+++ b/include/asm-ppc/ppc_asm.h
@@ -186,6 +186,12 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 #define PPC405_ERR77_SYNC
 #endif
 
+#ifdef CONFIG_IBM440EP_ERR42
+#define PPC440EP_ERR42 isync
+#else
+#define PPC440EP_ERR42
+#endif
+
 /* The boring bits... */
 
 /* Condition Register Bit Fields */

