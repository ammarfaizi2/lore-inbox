Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbUKWQRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbUKWQRc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 11:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbUKWQRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 11:17:32 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:45729 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261329AbUKWQN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 11:13:59 -0500
Date: Tue, 23 Nov 2004 09:13:56 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Cc: linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] PPC4xx PIC rewrite/cleanup
Message-ID: <20041123091356.A24513@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch from Eugene to do some cleanup of the PPC4xx PIC code.
Separates the interrupts that can have polarity/triggering
modified for platform modification if necessary. Between
the two of us, it's tested on most of the affected platforms.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff -Nru a/arch/ppc/platforms/4xx/ebony.c b/arch/ppc/platforms/4xx/ebony.c
--- a/arch/ppc/platforms/4xx/ebony.c	2004-11-10 23:39:19 -08:00
+++ b/arch/ppc/platforms/4xx/ebony.c	2004-11-10 23:39:19 -08:00
@@ -55,73 +55,22 @@
 static struct ibm44x_clocks clocks __initdata;
 
 /*
- * Ebony IRQ triggering/polarity settings
+ * Ebony external IRQ triggering/polarity settings
  */
-static u_char ebony_IRQ_initsenses[] __initdata = {
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 0: UART 0 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 1: UART 1 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 2: IIC 0 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 3: IIC 1 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 4: PCI Inb Mess */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 5: PCI Cmd Wrt */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 6: PCI PM */
-	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* 7: PCI MSI 0 */
-	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* 8: PCI MSI 1 */
-	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* 9: PCI MSI 2 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 10: MAL TX EOB */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 11: MAL RX EOB */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 12: DMA Chan 0 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 13: DMA Chan 1 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 14: DMA Chan 2 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 15: DMA Chan 3 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 16: Reserved */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 17: Reserved */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 18: GPT Timer 0 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 19: GPT Timer 1 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 20: GPT Timer 2 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 21: GPT Timer 3 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 22: GPT Timer 4 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 23: Ext Int 0 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 24: Ext Int 1 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 25: Ext Int 2 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 26: Ext Int 3 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 27: Ext Int 4 */
-	(IRQ_SENSE_EDGE  | IRQ_POLARITY_NEGATIVE),	/* 28: Ext Int 5 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 29: Ext Int 6 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 30: UIC1 NC Int */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 31: UIC1 Crit Int */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 32: MAL SERR */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 33: MAL TXDE */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 34: MAL RXDE */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 35: ECC Unc Err */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 36: ECC Corr Err */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 37: Ext Bus Ctrl */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 38: Ext Bus Mstr */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 39: OPB->PLB */
-	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* 40: PCI MSI 3 */
-	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* 41: PCI MSI 4 */
-	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* 42: PCI MSI 5 */
-	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* 43: PCI MSI 6 */
-	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* 44: PCI MSI 7 */
-	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* 45: PCI MSI 8 */
-	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* 46: PCI MSI 9 */
-	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* 47: PCI MSI 10 */
-	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* 48: PCI MSI 11 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 49: PLB Perf Mon */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 50: Ext Int 7 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 51: Ext Int 8 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 52: Ext Int 9 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 53: Ext Int 10 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 54: Ext Int 11 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 55: Ext Int 12 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 56: Ser ROM Err */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 57: Reserved */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 58: Reserved */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 59: PCI Async Err */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 60: EMAC 0 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 61: EMAC 0 WOL */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 62: EMAC 1 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 63: EMAC 1 WOL */
+unsigned char ppc4xx_uic_ext_irq_cfg[] __initdata = {
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ0: PCI slot 0 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ1: PCI slot 1 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ2: PCI slot 2 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ3: PCI slot 3 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* IRQ4: IRDA */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_NEGATIVE),	/* IRQ5: SMI pushbutton */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ6: PHYs */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* IRQ7: AUX */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ8: EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ9: EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ10: EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ11: EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* IRQ12: EXT */
 };
 
 static void __init
@@ -357,9 +306,6 @@
 #endif
 
 	ebony_early_serial_map();
-
-	ibm4xxPIC_InitSenses = ebony_IRQ_initsenses;
-	ibm4xxPIC_NumInitSenses = sizeof(ebony_IRQ_initsenses);
 
 	/* Identify the system */
 	printk("IBM Ebony port (MontaVista Software, Inc. (source@mvista.com))\n");
diff -Nru a/arch/ppc/platforms/4xx/ibm405ep.c b/arch/ppc/platforms/4xx/ibm405ep.c
--- a/arch/ppc/platforms/4xx/ibm405ep.c	2004-11-10 23:39:19 -08:00
+++ b/arch/ppc/platforms/4xx/ibm405ep.c	2004-11-10 23:39:19 -08:00
@@ -21,6 +21,7 @@
 
 #include <asm/ibm4xx.h>
 #include <asm/ocp.h>
+#include <asm/ppc4xx_pic.h>
 
 #include <platforms/4xx/ibm405ep.h>
 
@@ -130,5 +131,13 @@
 	  .show		= &ocp_show_emac_data
 	},
 	{ .vendor	= OCP_VENDOR_INVALID
+	}
+};
+
+/* Polarity and triggering settings for internal interrupt sources */
+struct ppc4xx_uic_settings ppc4xx_core_uic_cfg[] __initdata = {
+	{ .polarity 	= 0xffff7f80,
+	  .triggering	= 0x00000000,
+	  .ext_irq_mask	= 0x0000007f,	/* IRQ0 - IRQ6 */
 	}
 };
diff -Nru a/arch/ppc/platforms/4xx/ibm405gp.c b/arch/ppc/platforms/4xx/ibm405gp.c
--- a/arch/ppc/platforms/4xx/ibm405gp.c	2004-11-10 23:39:19 -08:00
+++ b/arch/ppc/platforms/4xx/ibm405gp.c	2004-11-10 23:39:19 -08:00
@@ -22,6 +22,7 @@
 #include <platforms/4xx/ibm405gp.h>
 #include <asm/ibm4xx.h>
 #include <asm/ocp.h>
+#include <asm/ppc4xx_pic.h>
 
 static struct ocp_func_emac_data ibm405gp_emac0_def = {
 	.rgmii_idx	= -1,		/* No RGMII */
@@ -107,5 +108,13 @@
 	  .show		= &ocp_show_emac_data,
 	},
 	{ .vendor	= OCP_VENDOR_INVALID
+	}
+};
+
+/* Polarity and triggering settings for internal interrupt sources */
+struct ppc4xx_uic_settings ppc4xx_core_uic_cfg[] __initdata = {
+	{ .polarity 	= 0xffffff80,
+	  .triggering	= 0x10000000,
+	  .ext_irq_mask	= 0x0000007f,	/* IRQ0 - IRQ6 */
 	}
 };
diff -Nru a/arch/ppc/platforms/4xx/ibm405gpr.c b/arch/ppc/platforms/4xx/ibm405gpr.c
--- a/arch/ppc/platforms/4xx/ibm405gpr.c	2004-11-10 23:39:19 -08:00
+++ b/arch/ppc/platforms/4xx/ibm405gpr.c	2004-11-10 23:39:19 -08:00
@@ -18,6 +18,7 @@
 #include <platforms/4xx/ibm405gpr.h>
 #include <asm/ibm4xx.h>
 #include <asm/ocp.h>
+#include <asm/ppc4xx_pic.h>
 
 static struct ocp_func_emac_data ibm405gpr_emac0_def = {
 	.rgmii_idx	= -1,		/* No RGMII */
@@ -104,5 +105,13 @@
 	  .show		= &ocp_show_emac_data,
 	},
 	{ .vendor	= OCP_VENDOR_INVALID
+	}
+};
+
+/* Polarity and triggering settings for internal interrupt sources */
+struct ppc4xx_uic_settings ppc4xx_core_uic_cfg[] __initdata = {
+	{ .polarity 	= 0xffffe000,
+	  .triggering	= 0x10000000,
+	  .ext_irq_mask	= 0x00001fff,	/* IRQ7 - IRQ12, IRQ0 - IRQ6 */
 	}
 };
diff -Nru a/arch/ppc/platforms/4xx/ibm440gp.c b/arch/ppc/platforms/4xx/ibm440gp.c
--- a/arch/ppc/platforms/4xx/ibm440gp.c	2004-11-10 23:39:19 -08:00
+++ b/arch/ppc/platforms/4xx/ibm440gp.c	2004-11-10 23:39:19 -08:00
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <platforms/4xx/ibm440gp.h>
 #include <asm/ocp.h>
+#include <asm/ppc4xx_pic.h>
 
 static struct ocp_func_emac_data ibm440gp_emac0_def = {
 	.rgmii_idx	= -1,           /* No RGMII */
@@ -148,4 +149,16 @@
 	},
 	{ .vendor	= OCP_VENDOR_INVALID
 	}
+};
+
+/* Polarity and triggering settings for internal interrupt sources */
+struct ppc4xx_uic_settings ppc4xx_core_uic_cfg[] __initdata = {
+	{ .polarity 	= 0xfffffe03,
+	  .triggering	= 0x01c00000,
+	  .ext_irq_mask	= 0x000001fc,	/* IRQ0 - IRQ6 */
+	},
+	{ .polarity 	= 0xffffc0ff,
+	  .triggering	= 0x00ff8000,
+	  .ext_irq_mask	= 0x00003f00,	/* IRQ7 - IRQ12 */
+	},
 };
diff -Nru a/arch/ppc/platforms/4xx/ibm440gx.c b/arch/ppc/platforms/4xx/ibm440gx.c
--- a/arch/ppc/platforms/4xx/ibm440gx.c	2004-11-10 23:39:19 -08:00
+++ b/arch/ppc/platforms/4xx/ibm440gx.c	2004-11-10 23:39:19 -08:00
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <platforms/4xx/ibm440gx.h>
 #include <asm/ocp.h>
+#include <asm/ppc4xx_pic.h>
 
 static struct ocp_func_emac_data ibm440gx_emac0_def = {
 	.rgmii_idx	= -1,		/* No RGMII */
@@ -214,4 +215,20 @@
 	},
 	{ .vendor	= OCP_VENDOR_INVALID
 	}
+};
+
+/* Polarity and triggering settings for internal interrupt sources */
+struct ppc4xx_uic_settings ppc4xx_core_uic_cfg[] __initdata = {
+	{ .polarity 	= 0xfffffe03,
+	  .triggering	= 0x01c00000,
+	  .ext_irq_mask	= 0x000001fc,	/* IRQ0 - IRQ6 */
+	},
+	{ .polarity 	= 0xffffc0ff,
+	  .triggering	= 0x00ff8000,
+	  .ext_irq_mask	= 0x00003f00,	/* IRQ7 - IRQ12 */
+	},
+	{ .polarity 	= 0xffff83ff,
+	  .triggering	= 0x000f83c0,
+	  .ext_irq_mask	= 0x00007c00,	/* IRQ13 - IRQ17 */
+	},
 };
diff -Nru a/arch/ppc/platforms/4xx/ibmnp405h.h b/arch/ppc/platforms/4xx/ibmnp405h.h
--- a/arch/ppc/platforms/4xx/ibmnp405h.h	2004-11-10 23:39:19 -08:00
+++ b/arch/ppc/platforms/4xx/ibmnp405h.h	2004-11-10 23:39:19 -08:00
@@ -132,8 +132,7 @@
 #define DCRN_UIC1_BASE	0x0D0
 #define DCRN_CPC0_EPRCSR 0x0F3
 
-#define UIC0_UIC1NC      30	/* UIC1 non-critical interrupt */
-#define UIC0_UIC1CR      31	/* UIC1 critical interrupt */
+#define UIC0_UIC1NC	0x00000002
 
 #define CHR1_CETE	0x00000004	/* CPU external timer enable */
 #define UIC0	DCRN_UIC0_BASE
@@ -141,7 +140,6 @@
 
 #undef NR_UICS
 #define NR_UICS	2
-#define UIC_CASCADE_MASK 0x0003	/* bits 30 & 31 */
 
 /* EMAC DCRN's FIXME: armin */
 #define DCRN_MALRXCTP2R(base)	((base) + 0x42)	/* Channel Rx 2 Channel Table Pointer */
diff -Nru a/arch/ppc/platforms/4xx/ibmstbx25.c b/arch/ppc/platforms/4xx/ibmstbx25.c
--- a/arch/ppc/platforms/4xx/ibmstbx25.c	2004-11-10 23:39:19 -08:00
+++ b/arch/ppc/platforms/4xx/ibmstbx25.c	2004-11-10 23:39:19 -08:00
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <asm/ocp.h>
 #include <platforms/4xx/ibmstbx25.h>
+#include <asm/ppc4xx_pic.h>
 
 static struct ocp_func_iic_data ibmstbx25_iic0_def = {
 	.fast_mode	= 0,		/* Use standad mode (100Khz) */
@@ -55,5 +56,13 @@
 	  .pm		= IBM_CPM_GPIO0,
 	},
 	{ .vendor	= OCP_VENDOR_INVALID
+	}
+};
+
+/* Polarity and triggering settings for internal interrupt sources */
+struct ppc4xx_uic_settings ppc4xx_core_uic_cfg[] __initdata = {
+	{ .polarity 	= 0xffff8f80,
+	  .triggering	= 0x00000000,
+	  .ext_irq_mask	= 0x0000707f,	/* IRQ7 - IRQ9, IRQ0 - IRQ6 */
 	}
 };
diff -Nru a/arch/ppc/platforms/4xx/oak.c b/arch/ppc/platforms/4xx/oak.c
--- a/arch/ppc/platforms/4xx/oak.c	2004-11-10 23:39:19 -08:00
+++ b/arch/ppc/platforms/4xx/oak.c	2004-11-10 23:39:19 -08:00
@@ -101,8 +101,8 @@
 	ppc_md.setup_arch	 	= oak_setup_arch;
 	ppc_md.show_percpuinfo	 	= oak_show_percpuinfo;
 	ppc_md.irq_canonicalize 	= NULL;
-	ppc_md.init_IRQ		 	= oak_init_IRQ;
-	ppc_md.get_irq		 	= oak_get_irq;
+	ppc_md.init_IRQ		 	= ppc4xx_pic_init;
+	ppc_md.get_irq		 	= NULL;  /* Set in ppc4xx_pic_init() */
 	ppc_md.init		 	= NULL;
 
 	ppc_md.restart		 	= oak_restart;
@@ -153,32 +153,6 @@
 		   bp->bi_busfreq / 1000000);
 
 	return 0;
-}
-
-/*
- * Document me.
- */
-void __init
-oak_init_IRQ(void)
-{
-	int i;
-
-	ppc4xx_pic_init();
-
-	for (i = 0; i < NR_IRQS; i++) {
-		irq_desc[i].handler = ppc4xx_pic;
-	}
-
-	return;
-}
-
-/*
- * Document me.
- */
-int
-oak_get_irq(struct pt_regs *regs)
-{
-	return (ppc4xx_pic_get_irq(regs));
 }
 
 /*
diff -Nru a/arch/ppc/platforms/4xx/ocotea.c b/arch/ppc/platforms/4xx/ocotea.c
--- a/arch/ppc/platforms/4xx/ocotea.c	2004-11-10 23:39:19 -08:00
+++ b/arch/ppc/platforms/4xx/ocotea.c	2004-11-10 23:39:19 -08:00
@@ -347,12 +347,6 @@
 	ibm440gx_get_clocks(&clocks, 33333333, 6 * 1843200);
 	ocp_sys_info.opb_bus_freq = clocks.opb;
 
-	/* XXX Fix L2C IRQ triggerring setting (edge-sensitive).
-	 * Firmware (at least PIBS v1.72 OCT/28/2003) sets it incorrectly
-	 * --ebs
-	 */
-	mtdcr(DCRN_UIC_TR(UIC2), mfdcr(DCRN_UIC_TR(UIC2)) | 0x00000100);
-
 	ibm44x_platform_init();
 
 	ppc_md.setup_arch = ocotea_setup_arch;
diff -Nru a/arch/ppc/platforms/4xx/redwood6.c b/arch/ppc/platforms/4xx/redwood6.c
--- a/arch/ppc/platforms/4xx/redwood6.c	2004-11-10 23:39:19 -08:00
+++ b/arch/ppc/platforms/4xx/redwood6.c	2004-11-10 23:39:19 -08:00
@@ -19,44 +19,20 @@
 #include <linux/delay.h>
 #include <asm/machdep.h>
 
-
 /*
- * Define all of the IRQ senses and polarities.
+ * Define external IRQ senses and polarities.
  */
-
-static u_char redwood6_IRQ_initsenses[] __initdata = {
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 0: RTC/FPC */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 1: Transport */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 2: Audio Dec */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 3: Video Dec */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 4: DMA Chan 0 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 5: DMA Chan 1 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 6: DMA Chan 2 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 7: DMA Chan 3 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 8: SmartCard 0 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 9: IIC0 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 10: IRR */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 11: Cap Timers */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 12: Cmp Timers */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 13: Serial Port */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 14: Soft Modem */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 15: Down Ctrs */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 16: SmartCard 1 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 17: Ext Int 7 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 18: Ext Int 8 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 19: Ext Int 9 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 20: Serial 0 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 21: Serial 1 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 22: Serial 2 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 23: XPT_DMA */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 24: DCR timeout */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 25: Ext Int 0 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 26: Ext Int 1 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 27: Ext Int 2 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 28: Ext Int 3 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 29: Ext Int 4 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 30: Ext Int 5 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 31: Ext Int 6 */
+unsigned char ppc4xx_uic_ext_irq_cfg[] __initdata = {
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext Int 7 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext Int 8 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext Int 9 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext Int 0 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext Int 1 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext Int 2 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext Int 3 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext Int 4 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext Int 5 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext Int 6 */
 };
 
 static struct resource smc91x_resources[] = {
@@ -144,8 +120,6 @@
 
 	printk("\n");
 #endif
-	ibm4xxPIC_InitSenses = redwood6_IRQ_initsenses;
-	ibm4xxPIC_NumInitSenses = sizeof(redwood6_IRQ_initsenses);
 
 	/* Identify the system */
 	printk(KERN_INFO "IBM Redwood6 (STBx25XX) Platform\n");
diff -Nru a/arch/ppc/platforms/4xx/sycamore.c b/arch/ppc/platforms/4xx/sycamore.c
--- a/arch/ppc/platforms/4xx/sycamore.c	2004-11-10 23:39:19 -08:00
+++ b/arch/ppc/platforms/4xx/sycamore.c	2004-11-10 23:39:19 -08:00
@@ -44,42 +44,22 @@
 void *sycamore_rtc_base;
 
 /*
- * Define all of the IRQ senses and polarities.
+ * Define external IRQ senses and polarities.
  */
-
-static u_char Sycamore_IRQ_initsenses[] __initdata = {
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 0: Uart 0*/
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 1: Uart 1*/
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 2: IIC */
-	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* 3: External Master */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 4: PCI ext cmd write*/
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 5: DMA Chan 0 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 6: DMA Chan 1 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 7: DMA Chan 2 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 8: DMA Chan 3 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 9: Ethernet wakeup (WOL)*/
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 10: Mal (SEER) */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 11: Mal TXEOB */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 12: Mal RXEOB */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 13: Mal TXDE*/
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 14: Mal RXDE*/
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 15: Ethernet */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 16: Ext PCI SERR */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 17: ECC */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 18: PCI PM*/
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 19: Ext Int 7 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 20: Ext Int 8 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 21: Ext Int 9 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 22: Ext Int 10 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 23: Ext Int 11 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 24: Ext Int 12 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 25: Ext Int 0 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 26: Ext Int 1 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 27: Ext Int 2 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 28: Ext Int 3 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 29: Ext Int 4 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 30: Ext Int 5 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 31: Ext Int 6 */
+unsigned char ppc4xx_uic_ext_irq_cfg[] __initdata = {
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext Int 7 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext Int 8 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext Int 9 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext Int 10 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext Int 11 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext Int 12 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext Int 0 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext Int 1 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext Int 2 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext Int 3 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext Int 4 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext Int 5 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext Int 6 */
 };
 
 
@@ -158,8 +138,6 @@
 	sycamore_rtc_base = (void *) SYCAMORE_RTC_VADDR;
 	TODC_INIT(TODC_TYPE_DS1743, sycamore_rtc_base, sycamore_rtc_base,
 		  sycamore_rtc_base, 8);
-	ibm4xxPIC_InitSenses = Sycamore_IRQ_initsenses;
-	ibm4xxPIC_NumInitSenses = sizeof(Sycamore_IRQ_initsenses);
 
 	/* Identify the system */
 	printk(KERN_INFO "IBM Sycamore (IBM405GPr) Platform\n");
diff -Nru a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile	2004-11-10 23:39:19 -08:00
+++ b/arch/ppc/syslib/Makefile	2004-11-10 23:39:19 -08:00
@@ -17,7 +17,11 @@
 ifeq ($(CONFIG_VIRTEX_II_PRO),y)
 obj-$(CONFIG_40x)		+= xilinx_pic.o
 else
+ifeq ($(CONFIG_403),y)
+obj-$(CONFIG_40x)		+= ppc403_pic.o
+else
 obj-$(CONFIG_40x)		+= ppc4xx_pic.o
+endif
 endif
 obj-$(CONFIG_44x)		+= ppc4xx_pic.o
 obj-$(CONFIG_40x)		+= ppc4xx_setup.o
diff -Nru a/arch/ppc/syslib/ibm44x_common.c b/arch/ppc/syslib/ibm44x_common.c
--- a/arch/ppc/syslib/ibm44x_common.c	2004-11-10 23:39:19 -08:00
+++ b/arch/ppc/syslib/ibm44x_common.c	2004-11-10 23:39:19 -08:00
@@ -142,19 +142,9 @@
 	return mem_size;
 }
 
-static void __init ibm44x_init_irq(void)
-{
-	int i;
-
-	ppc4xx_pic_init();
-
-	for (i = 0; i < NR_IRQS; i++)
-		irq_desc[i].handler = ppc4xx_pic;
-}
-
 void __init ibm44x_platform_init(void)
 {
-	ppc_md.init_IRQ = ibm44x_init_irq;
+	ppc_md.init_IRQ = ppc4xx_pic_init;
 	ppc_md.find_end_of_memory = ibm44x_find_end_of_memory;
 	ppc_md.restart = ibm44x_restart;
 	ppc_md.power_off = ibm44x_power_off;
diff -Nru a/arch/ppc/syslib/ppc403_pic.c b/arch/ppc/syslib/ppc403_pic.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/syslib/ppc403_pic.c	2004-11-10 23:39:19 -08:00
@@ -0,0 +1,127 @@
+/*
+ *
+ *    Copyright (c) 1999 Grant Erickson <grant@lcse.umn.edu>
+ *
+ *    Module name: ppc403_pic.c
+ *
+ *    Description:
+ *      Interrupt controller driver for PowerPC 403-based processors.
+ */
+
+/*
+ * The PowerPC 403 cores' Asynchronous Interrupt Controller (AIC) has
+ * 32 possible interrupts, a majority of which are not implemented on
+ * all cores. There are six configurable, external interrupt pins and
+ * there are eight internal interrupts for the on-chip serial port
+ * (SPU), DMA controller, and JTAG controller.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/stddef.h>
+
+#include <asm/processor.h>
+#include <asm/system.h>
+#include <asm/irq.h>
+#include <asm/ppc4xx_pic.h>
+
+/* Function Prototypes */
+
+static void ppc403_aic_enable(unsigned int irq);
+static void ppc403_aic_disable(unsigned int irq);
+static void ppc403_aic_disable_and_ack(unsigned int irq);
+
+static struct hw_interrupt_type ppc403_aic = {
+	"403GC AIC",
+	NULL,
+	NULL,
+	ppc403_aic_enable,
+	ppc403_aic_disable,
+	ppc403_aic_disable_and_ack,
+	0
+};
+
+int
+ppc403_pic_get_irq(struct pt_regs *regs)
+{
+	int irq;
+	unsigned long bits;
+
+	/*
+	 * Only report the status of those interrupts that are actually
+	 * enabled.
+	 */
+
+	bits = mfdcr(DCRN_EXISR) & mfdcr(DCRN_EXIER);
+
+	/*
+	 * Walk through the interrupts from highest priority to lowest, and
+	 * report the first pending interrupt found.
+	 * We want PPC, not C bit numbering, so just subtract the ffs()
+	 * result from 32.
+	 */
+	irq = 32 - ffs(bits);
+
+	if (irq == NR_AIC_IRQS)
+		irq = -1;
+
+	return (irq);
+}
+
+static void
+ppc403_aic_enable(unsigned int irq)
+{
+	int bit, word;
+
+	bit = irq & 0x1f;
+	word = irq >> 5;
+
+	ppc_cached_irq_mask[word] |= (1 << (31 - bit));
+	mtdcr(DCRN_EXIER, ppc_cached_irq_mask[word]);
+}
+
+static void
+ppc403_aic_disable(unsigned int irq)
+{
+	int bit, word;
+
+	bit = irq & 0x1f;
+	word = irq >> 5;
+
+	ppc_cached_irq_mask[word] &= ~(1 << (31 - bit));
+	mtdcr(DCRN_EXIER, ppc_cached_irq_mask[word]);
+}
+
+static void
+ppc403_aic_disable_and_ack(unsigned int irq)
+{
+	int bit, word;
+
+	bit = irq & 0x1f;
+	word = irq >> 5;
+
+	ppc_cached_irq_mask[word] &= ~(1 << (31 - bit));
+	mtdcr(DCRN_EXIER, ppc_cached_irq_mask[word]);
+	mtdcr(DCRN_EXISR, (1 << (31 - bit)));
+}
+
+void __init
+ppc4xx_pic_init(void)
+{
+	int i;
+
+	/*
+	 * Disable all external interrupts until they are
+	 * explicity requested.
+	 */
+	ppc_cached_irq_mask[0] = 0;
+
+	mtdcr(DCRN_EXIER, ppc_cached_irq_mask[0]);
+
+	ppc_md.get_irq = ppc403_pic_get_irq;
+	
+	for (i = 0; i < NR_IRQS; i++)
+		irq_desc[i].handler = &ppc403_aic;
+}
diff -Nru a/arch/ppc/syslib/ppc4xx_pic.c b/arch/ppc/syslib/ppc4xx_pic.c
--- a/arch/ppc/syslib/ppc4xx_pic.c	2004-11-10 23:39:19 -08:00
+++ b/arch/ppc/syslib/ppc4xx_pic.c	2004-11-10 23:39:19 -08:00
@@ -1,31 +1,21 @@
 /*
+ * arch/ppc/syslib/ppc4xx_pic.c
  *
- *    Copyright (c) 1999 Grant Erickson <grant@lcse.umn.edu>
- *
- *    Module name: ppc4xx_pic.c
- *
- *    Description:
- *      Interrupt controller driver for PowerPC 4xx-based processors.
- */
-
-/*
- * The PowerPC 403 cores' Asynchronous Interrupt Controller (AIC) has
- * 32 possible interrupts, a majority of which are not implemented on
- * all cores. There are six configurable, external interrupt pins and
- * there are eight internal interrupts for the on-chip serial port
- * (SPU), DMA controller, and JTAG controller.
+ * Interrupt controller driver for PowerPC 4xx-based processors.
  *
- * The PowerPC 405/440 cores' Universal Interrupt Controller (UIC) has
- * 32 possible interrupts as well.  Depending on the core and SoC
- * implementation, a portion of the interrrupts are used for on-chip
- * peripherals and a portion of the interrupts are available to be
- * configured for external devices generating interrupts.
+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ * Copyright (c) 2004 Zultys Technologies
  *
- * The PowerNP and 440GP (and most likely future implementations) have
- * cascaded UICs.
+ * Based on original code by
+ *    Copyright (c) 1999 Grant Erickson <grant@lcse.umn.edu>
+ *    Armin Custer <akuster@mvista.com>
  *
- */
-
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+*/
+#include <linux/config.h>
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/signal.h>
@@ -36,493 +26,212 @@
 #include <asm/irq.h>
 #include <asm/ppc4xx_pic.h>
 
-/* Global Variables */
-struct hw_interrupt_type *ppc4xx_pic;
-/*
- * We define 4xxIRQ_InitSenses table thusly:
- * bit 0x1: sense, 1 for edge and 0 for level.
- * bit 0x2: polarity, 0 for negative, 1 for positive.
+/* See comment in include/arch-ppc/ppc4xx_pic.h 
+ * for more info about these two variables
  */
-unsigned int ibm4xxPIC_NumInitSenses __initdata = 0;
-unsigned char *ibm4xxPIC_InitSenses __initdata = NULL;
-
-/* Six of one, half dozen of the other....#ifdefs, separate files,
- * other tricks.....
- *
- * There are basically two types of interrupt controllers, the 403 AIC
- * and the "others" with UIC.  I just kept them both here separated
- * with #ifdefs, but it seems to change depending upon how supporting
- * files (like ppc4xx.h) change.		-- Dan.
- */
-
-#ifdef CONFIG_403
-
-/* Function Prototypes */
-
-static void ppc403_aic_enable(unsigned int irq);
-static void ppc403_aic_disable(unsigned int irq);
-static void ppc403_aic_disable_and_ack(unsigned int irq);
-
-static struct hw_interrupt_type ppc403_aic = {
-	"403GC AIC",
-	NULL,
-	NULL,
-	ppc403_aic_enable,
-	ppc403_aic_disable,
-	ppc403_aic_disable_and_ack,
-	0
-};
+extern struct ppc4xx_uic_settings ppc4xx_core_uic_cfg[NR_UICS] __attribute__((weak));
+extern unsigned char ppc4xx_uic_ext_irq_cfg[] __attribute__((weak));
 
-int
-ppc403_pic_get_irq(struct pt_regs *regs)
-{
-	int irq;
-	unsigned long bits;
-
-	/*
-	 * Only report the status of those interrupts that are actually
-	 * enabled.
-	 */
-
-	bits = mfdcr(DCRN_EXISR) & mfdcr(DCRN_EXIER);
-
-	/*
-	 * Walk through the interrupts from highest priority to lowest, and
-	 * report the first pending interrupt found.
-	 * We want PPC, not C bit numbering, so just subtract the ffs()
-	 * result from 32.
-	 */
-	irq = 32 - ffs(bits);
-
-	if (irq == NR_AIC_IRQS)
-		irq = -1;
-
-	return (irq);
+#define IRQ_MASK_UIC0(irq)		(1 << (31 - (irq)))
+#define IRQ_MASK_UICx(irq)		(1 << (31 - ((irq) & 0x1f)))
+#define IRQ_MASK_UIC1(irq)		IRQ_MASK_UICx(irq)
+#define IRQ_MASK_UIC2(irq)		IRQ_MASK_UICx(irq)
+
+#define UIC_HANDLERS(n)							\
+static void ppc4xx_uic##n##_enable(unsigned int irq)			\
+{									\
+	ppc_cached_irq_mask[n] |= IRQ_MASK_UIC##n(irq);			\
+	mtdcr(DCRN_UIC_ER(UIC##n), ppc_cached_irq_mask[n]);		\
+}									\
+									\
+static void ppc4xx_uic##n##_disable(unsigned int irq)			\
+{									\
+	ppc_cached_irq_mask[n] &= ~IRQ_MASK_UIC##n(irq);		\
+	mtdcr(DCRN_UIC_ER(UIC##n), ppc_cached_irq_mask[n]);		\
+}									\
+									\
+static void ppc4xx_uic##n##_ack(unsigned int irq)			\
+{									\
+	u32 mask = IRQ_MASK_UIC##n(irq);				\
+	ppc_cached_irq_mask[n] &= ~mask;				\
+	mtdcr(DCRN_UIC_ER(UIC##n), ppc_cached_irq_mask[n]);		\
+	mtdcr(DCRN_UIC_SR(UIC##n), mask);				\
+	ACK_UIC##n##_PARENT						\
+}									\
+									\
+static void ppc4xx_uic##n##_end(unsigned int irq)			\
+{									\
+	unsigned int status = irq_desc[irq].status;			\
+	u32 mask = IRQ_MASK_UIC##n(irq);				\
+	if (status & IRQ_LEVEL){					\
+		mtdcr(DCRN_UIC_SR(UIC##n), mask);			\
+		ACK_UIC##n##_PARENT					\
+	}								\
+	if (!(status & (IRQ_DISABLED | IRQ_INPROGRESS))){		\
+		ppc_cached_irq_mask[n] |= mask;				\
+		mtdcr(DCRN_UIC_ER(UIC##n), ppc_cached_irq_mask[n]);	\
+	}								\
+}
+
+#define DECLARE_UIC(n)							\
+{									\
+	.typename 	= "UIC"#n,					\
+	.enable 	= ppc4xx_uic##n##_enable,			\
+	.disable 	= ppc4xx_uic##n##_disable,			\
+	.ack 		= ppc4xx_uic##n##_ack,				\
+	.end 		= ppc4xx_uic##n##_end,				\
+}									\
+
+#if NR_UICS == 3
+#define ACK_UIC0_PARENT	mtdcr(DCRN_UIC_SR(UICB), UICB_UIC0NC);
+#define ACK_UIC1_PARENT	mtdcr(DCRN_UIC_SR(UICB), UICB_UIC1NC);
+#define ACK_UIC2_PARENT	mtdcr(DCRN_UIC_SR(UICB), UICB_UIC2NC);
+UIC_HANDLERS(0); UIC_HANDLERS(1); UIC_HANDLERS(2);
+
+static int ppc4xx_pic_get_irq(struct pt_regs *regs)
+{
+	u32 uicb = mfdcr(DCRN_UIC_MSR(UICB));
+	if (uicb & UICB_UIC0NC)
+		return 32 - ffs(mfdcr(DCRN_UIC_MSR(UIC0)));
+	else if (uicb & UICB_UIC1NC)
+		return 64 - ffs(mfdcr(DCRN_UIC_MSR(UIC1)));
+	else if (uicb & UICB_UIC2NC)
+		return 96 - ffs(mfdcr(DCRN_UIC_MSR(UIC2)));
+	else
+		return -1;
 }
 
-static void
-ppc403_aic_enable(unsigned int irq)
+static void __init ppc4xx_pic_impl_init(void)
 {
-	int bit, word;
-
-	bit = irq & 0x1f;
-	word = irq >> 5;
-
-	ppc_cached_irq_mask[word] |= (1 << (31 - bit));
-	mtdcr(DCRN_EXIER, ppc_cached_irq_mask[word]);
+	/* Configure Base UIC */
+	mtdcr(DCRN_UIC_CR(UICB), 0);
+	mtdcr(DCRN_UIC_TR(UICB), 0);
+	mtdcr(DCRN_UIC_PR(UICB), 0xffffffff);
+	mtdcr(DCRN_UIC_SR(UICB), 0xffffffff);
+	mtdcr(DCRN_UIC_ER(UICB), UICB_UIC0NC | UICB_UIC1NC | UICB_UIC2NC);
 }
 
-static void
-ppc403_aic_disable(unsigned int irq)
-{
-	int bit, word;
-
-	bit = irq & 0x1f;
-	word = irq >> 5;
-
-	ppc_cached_irq_mask[word] &= ~(1 << (31 - bit));
-	mtdcr(DCRN_EXIER, ppc_cached_irq_mask[word]);
-}
+#elif NR_UICS == 2
+#define ACK_UIC0_PARENT
+#define ACK_UIC1_PARENT	mtdcr(DCRN_UIC_SR(UIC0), UIC0_UIC1NC);
+UIC_HANDLERS(0); UIC_HANDLERS(1);
 
-static void
-ppc403_aic_disable_and_ack(unsigned int irq)
+static int ppc4xx_pic_get_irq(struct pt_regs *regs)
 {
-	int bit, word;
-
-	bit = irq & 0x1f;
-	word = irq >> 5;
-
-	ppc_cached_irq_mask[word] &= ~(1 << (31 - bit));
-	mtdcr(DCRN_EXIER, ppc_cached_irq_mask[word]);
-	mtdcr(DCRN_EXISR, (1 << (31 - bit)));
+	u32 uic0 = mfdcr(DCRN_UIC_MSR(UIC0));
+	if (uic0 & UIC0_UIC1NC)
+		return 64 - ffs(mfdcr(DCRN_UIC_MSR(UIC1)));
+	else 
+		return uic0 ? 32 - ffs(uic0) : -1;
 }
 
-#else
-
-#ifndef UIC1
-#define UIC1 UIC0
-#endif
-#ifndef UIC2
-#define UIC2 UIC1
-#endif
-
-static void
-ppc4xx_uic_enable(unsigned int irq)
+static void __init ppc4xx_pic_impl_init(void)
 {
-	int bit, word;
-	irq_desc_t *desc = irq_desc + irq;
-
-	bit = irq & 0x1f;
-	word = irq >> 5;
-
-#ifdef UIC_DEBUG
-	printk("ppc4xx_uic_enable - irq %d word %d bit 0x%x\n", irq, word, bit);
-#endif
-	ppc_cached_irq_mask[word] |= 1 << (31 - bit);
-	switch (word) {
-	case 0:
-		mtdcr(DCRN_UIC_ER(UIC0), ppc_cached_irq_mask[word]);
-		if ((mfdcr(DCRN_UIC_TR(UIC0)) & (1 << (31 - bit))) == 0)
-			desc->status |= IRQ_LEVEL;
-		else
-			desc->status = desc->status & ~IRQ_LEVEL;
-		break;
-	case 1:
-		mtdcr(DCRN_UIC_ER(UIC1), ppc_cached_irq_mask[word]);
-		if ((mfdcr(DCRN_UIC_TR(UIC1)) & (1 << (31 - bit))) == 0)
-			desc->status |= IRQ_LEVEL;
-		else
-			desc->status = desc->status & ~IRQ_LEVEL;
-		break;
-	case 2:
-		mtdcr(DCRN_UIC_ER(UIC2), ppc_cached_irq_mask[word]);
-		if ((mfdcr(DCRN_UIC_TR(UIC2)) & (1 << (31 - bit))) == 0)
-			desc->status |= IRQ_LEVEL;
-		else
-			desc->status = desc->status & ~IRQ_LEVEL;
-		break;
-	}
-
+	/* Enable cascade interrupt in UIC0 */
+	ppc_cached_irq_mask[0] |= UIC0_UIC1NC;
+	mtdcr(DCRN_UIC_SR(UIC0), UIC0_UIC1NC);
+	mtdcr(DCRN_UIC_ER(UIC0), ppc_cached_irq_mask[0]);
 }
 
-static void
-ppc4xx_uic_disable(unsigned int irq)
-{
-	int bit, word;
+#elif NR_UICS == 1
+#define ACK_UIC0_PARENT
+UIC_HANDLERS(0);
 
-	bit = irq & 0x1f;
-	word = irq >> 5;
-#ifdef UIC_DEBUG
-	printk("ppc4xx_uic_disable - irq %d word %d bit 0x%x\n", irq, word,
-	       bit);
-#endif
-	ppc_cached_irq_mask[word] &= ~(1 << (31 - bit));
-	switch (word) {
-	case 0:
-		mtdcr(DCRN_UIC_ER(UIC0), ppc_cached_irq_mask[word]);
-		break;
-	case 1:
-		mtdcr(DCRN_UIC_ER(UIC1), ppc_cached_irq_mask[word]);
-		break;
-	case 2:
-		mtdcr(DCRN_UIC_ER(UIC2), ppc_cached_irq_mask[word]);
-		break;
-	}
-}
-
-static void
-ppc4xx_uic_disable_and_ack(unsigned int irq)
+static int ppc4xx_pic_get_irq(struct pt_regs *regs)
 {
-	int bit, word;
-
-	bit = irq & 0x1f;
-	word = irq >> 5;
-
-#ifdef UIC_DEBUG
-	printk("ppc4xx_uic_disable_and_ack - irq %d word %d bit 0x%x\n", irq,
-	       word, bit);
-#endif
-	ppc_cached_irq_mask[word] &= ~(1 << (31 - bit));
-	switch (word) {
-	case 0:
-		mtdcr(DCRN_UIC_ER(UIC0), ppc_cached_irq_mask[word]);
-		mtdcr(DCRN_UIC_SR(UIC0), (1 << (31 - bit)));
-#if (NR_UICS > 2)
-		mtdcr(DCRN_UIC_SR(UICB), UICB_UIC0NC);
-#endif
-		break;
-	case 1:
-		mtdcr(DCRN_UIC_ER(UIC1), ppc_cached_irq_mask[word]);
-		mtdcr(DCRN_UIC_SR(UIC1), (1 << (31 - bit)));
-#if (NR_UICS == 2)
-		mtdcr(DCRN_UIC_SR(UIC0), (1 << (31 - UIC0_UIC1NC)));
-#endif
-#if (NR_UICS > 2)
-		mtdcr(DCRN_UIC_SR(UICB), UICB_UIC1NC);
-#endif
-		break;
-	case 2:
-		mtdcr(DCRN_UIC_ER(UIC2), ppc_cached_irq_mask[word]);
-		mtdcr(DCRN_UIC_SR(UIC2), (1 << (31 - bit)));
-#if (NR_UICS > 2)
-		mtdcr(DCRN_UIC_SR(UICB), UICB_UIC2NC);
-#endif
-		break;
-	}
-
+	u32 uic0 = mfdcr(DCRN_UIC_MSR(UIC0));
+	return uic0 ? 32 - ffs(uic0) : -1;
 }
 
-static void
-ppc4xx_uic_end(unsigned int irq)
-{
-	int bit, word;
-	unsigned int tr_bits = 0;
-
-	bit = irq & 0x1f;
-	word = irq >> 5;
-
-#ifdef UIC_DEBUG
-	printk("ppc4xx_uic_end - irq %d word %d bit 0x%x\n", irq, word, bit);
+static inline void ppc4xx_pic_impl_init(void){}
 #endif
 
-	switch (word) {
-	case 0:
-		tr_bits = mfdcr(DCRN_UIC_TR(UIC0));
-		break;
-	case 1:
-		tr_bits = mfdcr(DCRN_UIC_TR(UIC1));
-		break;
-	case 2:
-		tr_bits = mfdcr(DCRN_UIC_TR(UIC2));
-		break;
-	}
-
-	if ((tr_bits & (1 << (31 - bit))) == 0) {
-		/* level trigger */
-		switch (word) {
-		case 0:
-			mtdcr(DCRN_UIC_SR(UIC0), 1 << (31 - bit));
-#if (NR_UICS > 2)
-			mtdcr(DCRN_UIC_SR(UICB),  UICB_UIC0NC);
-#endif
-			break;
-		case 1:
-			mtdcr(DCRN_UIC_SR(UIC1), 1 << (31 - bit));
-#if (NR_UICS == 2)
-			mtdcr(DCRN_UIC_SR(UIC0), (1 << (31 - UIC0_UIC1NC)));
-#endif
-#if (NR_UICS > 2)
-			mtdcr(DCRN_UIC_SR(UICB),  UICB_UIC1NC);
-#endif
-			break;
-		case 2:
-			mtdcr(DCRN_UIC_SR(UIC2), 1 << (31 - bit));
-#if (NR_UICS > 2)
-			mtdcr(DCRN_UIC_SR(UICB),  UICB_UIC2NC);
+static struct ppc4xx_uic_impl {
+	struct hw_interrupt_type decl;
+	int			 base;		/* Base DCR number */
+} __uic[] = {
+    { .decl = DECLARE_UIC(0), .base = UIC0 },
+#if NR_UICS > 1
+    { .decl = DECLARE_UIC(1), .base = UIC1 },
+#if NR_UICS > 2
+    { .decl = DECLARE_UIC(2), .base = UIC2 },
 #endif
-			break;
-		}
-	}
-
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
-		ppc_cached_irq_mask[word] |= 1 << (31 - bit);
-		switch (word) {
-		case 0:
-			mtdcr(DCRN_UIC_ER(UIC0), ppc_cached_irq_mask[word]);
-			break;
-		case 1:
-			mtdcr(DCRN_UIC_ER(UIC1), ppc_cached_irq_mask[word]);
-			break;
-		case 2:
-			mtdcr(DCRN_UIC_ER(UIC2), ppc_cached_irq_mask[word]);
-			break;
-		}
-	}
-}
-
-static struct hw_interrupt_type ppc4xx_uic = {
-#if (NR_UICS == 1)
-	"IBM UIC",
-#else
-	"IBM UIC Cascade",
 #endif
-	NULL,
-	NULL,
-	ppc4xx_uic_enable,
-	ppc4xx_uic_disable,
-	ppc4xx_uic_disable_and_ack,
-	ppc4xx_uic_end,
-	0
 };
 
-int
-ppc4xx_pic_get_irq(struct pt_regs *regs)
+static inline int is_level_sensitive(int irq)
 {
-	int irq, cas_irq;
-	unsigned long bits;
-	cas_irq = 0;
-	/*
-	 * Only report the status of those interrupts that are actually
-	 * enabled.
-	 */
-
-#if (NR_UICS > 2)
-	bits = mfdcr(DCRN_UIC_MSR(UICB));
-#else
-	bits = mfdcr(DCRN_UIC_MSR(UIC0));
-#endif
-#if (NR_UICS > 2)
-	if (bits & UICB_UIC0NC) {
-		bits = mfdcr(DCRN_UIC_MSR(UIC0));
-		irq = 32 - ffs(bits);
-	} else if (bits & UICB_UIC1NC) {
-		bits = mfdcr(DCRN_UIC_MSR(UIC1));
-		irq = 64 - ffs(bits);
-	} else if (bits & UICB_UIC2NC) {
-		bits = mfdcr(DCRN_UIC_MSR(UIC2));
-		irq = 96 - ffs(bits);
-	} else {
-		irq = -1;
-	}
-#elif (NR_UICS > 1)
-	if (bits & UIC_CASCADE_MASK) {
-		bits = mfdcr(DCRN_UIC_MSR(UIC1));
-		cas_irq = 32 - ffs(bits);
-		irq = 32 + cas_irq;
-	} else {
-		irq = 32 - ffs(bits);
-		if (irq == 32)
-			irq = -1;
-	}
-#else
-	/*
-	 * Walk through the interrupts from highest priority to lowest, and
-	 * report the first pending interrupt found.
-	 * We want PPC, not C bit numbering, so just subtract the ffs()
-	 * result from 32.
-	 */
-	irq = 32 - ffs(bits);
-#endif
-	if (irq == (NR_UIC_IRQS * NR_UICS))
-		irq = -1;
-
-#ifdef UIC_DEBUG
-	printk("ppc4xx_pic_get_irq - irq %d bit 0x%x\n", irq, bits);
-#endif
-
-	return (irq);
+	u32 tr = mfdcr(DCRN_UIC_TR(__uic[irq >> 5].base));
+	return (tr & IRQ_MASK_UICx(irq)) == 0;
 }
-#endif
 
-void __init
-ppc4xx_extpic_init(void)
+void __init ppc4xx_pic_init(void)
 {
-	/* set polarity
-	 * 1 = default/pos/rising  , 0= neg/falling internal
-	 * 1 = neg/falling , 0= pos/rising external
-	 * Sense
-	 * 0 = default level internal
-	 * 0 = level, 1 = edge external
-	 */
-
-	unsigned int sense, irq;
-	int bit, word;
-	unsigned long ppc_cached_sense_mask[NR_MASK_WORDS];
-	unsigned long ppc_cached_pol_mask[NR_MASK_WORDS];
-	ppc_cached_sense_mask[0] = 0;
-	ppc_cached_sense_mask[1] = 0;
-	ppc_cached_sense_mask[2] = 0;
-	ppc_cached_pol_mask[0] = 0;
-	ppc_cached_pol_mask[1] = 0;
-	ppc_cached_pol_mask[2] = 0;
-
-	for (irq = 0; irq < NR_IRQS; irq++) {
-
-		bit = irq & 0x1f;
-		word = irq >> 5;
-
-		sense =
-		    (irq <
-		     ibm4xxPIC_NumInitSenses) ? ibm4xxPIC_InitSenses[irq] : 3;
-#ifdef PPC4xx_PIC_DEBUG
-		printk("PPC4xx_picext %d word:%x bit:%x sense:%x", irq, word,
-		       bit, sense);
-#endif
-		ppc_cached_sense_mask[word] |=
-		    (~sense & IRQ_SENSE_MASK) << (31 - bit);
-		ppc_cached_pol_mask[word] |=
-		    ((sense & IRQ_POLARITY_MASK) >> 1) << (31 - bit);
-		switch (word) {
-		case 0:
-#ifdef PPC4xx_PIC_DEBUG
-			printk("Pol %x ", mfdcr(DCRN_UIC_PR(UIC0)));
-			printk("Level %x\n", mfdcr(DCRN_UIC_TR(UIC0)));
-#endif
-			/* polarity  setting */
-			mtdcr(DCRN_UIC_PR(UIC0), ppc_cached_pol_mask[word]);
-
-			/* Level setting */
-			mtdcr(DCRN_UIC_TR(UIC0), ppc_cached_sense_mask[word]);
-
-			break;
-		case 1:
-#ifdef PPC4xx_PIC_DEBUG
-			printk("Pol %x ", mfdcr(DCRN_UIC_PR(UIC1)));
-			printk("Level %x\n", mfdcr(DCRN_UIC_TR(UIC1)));
-#endif
-			/* polarity  setting */
-			mtdcr(DCRN_UIC_PR(UIC1), ppc_cached_pol_mask[word]);
-
-			/* Level setting */
-			mtdcr(DCRN_UIC_TR(UIC1), ppc_cached_sense_mask[word]);
-
-			break;
-		case 2:
-#ifdef PPC4xx_PIC_DEBUG
-			printk("Pol %x ", mfdcr(DCRN_UIC_PR(UIC2)));
-			printk("Level %x\n", mfdcr(DCRN_UIC_TR(UIC2)));
-#endif
-			/* polarity  setting */
-			mtdcr(DCRN_UIC_PR(UIC2), ppc_cached_pol_mask[word]);
-
-			/* Level setting */
-			mtdcr(DCRN_UIC_TR(UIC2), ppc_cached_sense_mask[word]);
-
-			break;
+	int i;
+	unsigned char* eirqs = ppc4xx_uic_ext_irq_cfg;
+	
+	for (i = 0; i < NR_UICS; ++i){
+		int base = __uic[i].base;
+
+		/* Disable everything by default */
+		ppc_cached_irq_mask[i] = 0;
+		mtdcr(DCRN_UIC_ER(base), 0);
+		
+		/* We don't use critical interrupts */
+		mtdcr(DCRN_UIC_CR(base), 0);
+		
+		/* Configure polarity and triggering */
+		if (ppc4xx_core_uic_cfg){
+			struct ppc4xx_uic_settings* p = ppc4xx_core_uic_cfg + i;
+			u32 mask = p->ext_irq_mask;
+			u32 pr = mfdcr(DCRN_UIC_PR(base)) & mask;
+			u32 tr = mfdcr(DCRN_UIC_TR(base)) & mask;
+			
+			/* "Fixed" interrupts (on-chip devices) */
+			pr |= p->polarity   & ~mask;
+			tr |= p->triggering & ~mask;
+			
+			/* Merge external IRQs settings if board port 
+			 * provided them 
+			 */
+			if (eirqs && mask){
+				pr &= ~mask;
+				tr &= ~mask;
+				while (mask){
+					/* Extract current external IRQ mask */
+					u32 eirq_mask = 1 << __ilog2(mask);
+					
+					if (!(*eirqs & IRQ_SENSE_LEVEL))
+						tr |= eirq_mask;
+
+					if (*eirqs & IRQ_POLARITY_POSITIVE)
+						pr |= eirq_mask;
+				
+					mask &= ~eirq_mask;
+					++eirqs;    
+				}
+			}
+			mtdcr(DCRN_UIC_PR(base), pr);
+			mtdcr(DCRN_UIC_TR(base), tr);
 		}
-	}
-
-}
-void __init
-ppc4xx_pic_init(void)
-{
-	/*
-	 * Disable all external interrupts until they are
-	 * explicity requested.
-	 */
-	ppc_cached_irq_mask[0] = 0;
-	ppc_cached_irq_mask[1] = 0;
-	ppc_cached_irq_mask[2] = 0;
-
-#if defined CONFIG_403
-	mtdcr(DCRN_EXIER, ppc_cached_irq_mask[0]);
-
-	ppc4xx_pic = &ppc403_aic;
-	ppc_md.get_irq = ppc403_pic_get_irq;
-#else
-#if  (NR_UICS > 2)
-	mtdcr(DCRN_UIC_ER(UICB), UICB_UIC0NC | UICB_UIC1NC | UICB_UIC2NC);
-	mtdcr(DCRN_UIC_CR(UICB), 0);
-
-	mtdcr(DCRN_UIC_ER(UIC2), ppc_cached_irq_mask[2]);
-	mtdcr(DCRN_UIC_CR(UIC2), 0);
-
-#endif
-#if  (NR_UICS > 1)
-#if  (NR_UICS == 2)
-	/* enable cascading interrupt */
-	ppc_cached_irq_mask[0] |= 1 << (31 - UIC0_UIC1NC);
-#endif
-	mtdcr(DCRN_UIC_ER(UIC1), ppc_cached_irq_mask[1]);
-	mtdcr(DCRN_UIC_CR(UIC1), 0);
-#endif
-	mtdcr(DCRN_UIC_ER(UIC0), ppc_cached_irq_mask[0]);
-	mtdcr(DCRN_UIC_CR(UIC0), 0);
-
-	if (ibm4xxPIC_InitSenses != NULL)
-		ppc4xx_extpic_init();
+		
+		/* ACK any pending interrupts to prevent false 
+		 * triggering after first enable 
+		 */
+		mtdcr(DCRN_UIC_SR(base), 0xffffffff);
+	}
+	
+	/* Perform optional implementation specific setup 
+	 * (e.g. enable cascade interrupts for multi-UIC configurations) 
+	 */
+	ppc4xx_pic_impl_init();
+	
+	/* Attach low-level handlers */
+	for (i = 0; i < (NR_UICS << 5); ++i){
+    		irq_desc[i].handler = &__uic[i >> 5].decl;
+		if (is_level_sensitive(i))
+			irq_desc[i].status |= IRQ_LEVEL;
+	}		
 
-	/* Clear any pending interrupts */
-#if (NR_UICS > 2)
-	mtdcr(DCRN_UIC_SR(UICB), 0xffffffff);
-	mtdcr(DCRN_UIC_SR(UIC2), 0xffffffff);
-#endif
-#if (NR_UICS > 1)
-	mtdcr(DCRN_UIC_SR(UIC1), 0xffffffff);
-#endif
-	mtdcr(DCRN_UIC_SR(UIC0), 0xffffffff);
-
-	ppc4xx_pic = &ppc4xx_uic;
 	ppc_md.get_irq = ppc4xx_pic_get_irq;
-#endif
 }
diff -Nru a/arch/ppc/syslib/ppc4xx_setup.c b/arch/ppc/syslib/ppc4xx_setup.c
--- a/arch/ppc/syslib/ppc4xx_setup.c	2004-11-10 23:39:19 -08:00
+++ b/arch/ppc/syslib/ppc4xx_setup.c	2004-11-10 23:39:19 -08:00
@@ -133,12 +133,7 @@
 void __init
 ppc4xx_init_IRQ(void)
 {
-	int i;
-
 	ppc4xx_pic_init();
-
-	for (i = 0; i < NR_IRQS; i++)
-		irq_desc[i].handler = ppc4xx_pic;
 }
 
 static void
diff -Nru a/arch/ppc/syslib/xilinx_pic.c b/arch/ppc/syslib/xilinx_pic.c
--- a/arch/ppc/syslib/xilinx_pic.c	2004-11-10 23:39:19 -08:00
+++ b/arch/ppc/syslib/xilinx_pic.c	2004-11-10 23:39:19 -08:00
@@ -38,9 +38,6 @@
 #define intc_in_be32(addr)            mfdcr((addr))
 #endif
 
-/* Global Variables */
-struct hw_interrupt_type *ppc4xx_pic;
-
 static void
 xilinx_intc_enable(unsigned int irq)
 {
@@ -115,6 +112,8 @@
 void __init
 ppc4xx_pic_init(void)
 {
+	int i;
+
 #if XPAR_XINTC_USE_DCR == 0
 	intc = ioremap(XPAR_INTC_0_BASEADDR, 32);
 
@@ -137,6 +136,8 @@
 	/* Turn on the Master Enable. */
 	intc_out_be32(intc + MER, 0x3UL);
 
-	ppc4xx_pic = &xilinx_intc;
 	ppc_md.get_irq = xilinx_pic_get_irq;
+	
+	for (i = 0; i < NR_IRQS; ++i)
+		irq_desc[i].handler = &xilinx_intc;
 }
diff -Nru a/include/asm-ppc/ibm44x.h b/include/asm-ppc/ibm44x.h
--- a/include/asm-ppc/ibm44x.h	2004-11-10 23:39:19 -08:00
+++ b/include/asm-ppc/ibm44x.h	2004-11-10 23:39:19 -08:00
@@ -162,8 +162,7 @@
 #define DCRN_UIC_VR(base)       (base + 0x7)
 #define DCRN_UIC_VCR(base)      (base + 0x8)
 
-#define UIC0_UIC1NC		30	/* UIC1 non-critical interrupt */
-#define UIC0_UIC1CR      	31	/* UIC1 critical interrupt */
+#define UIC0_UIC1NC      	0x00000002
 
 #define UICB_UIC0NC		0x40000000
 #define UICB_UIC1NC		0x10000000
@@ -518,7 +517,6 @@
 #else
 #define NR_UICS 2
 #endif
-#define UIC_CASCADE_MASK	0x0003		/* bits 30 & 31 */
 
 #define BD_EMAC_ADDR(e,i) bi_enetaddr[e][i]
 
diff -Nru a/include/asm-ppc/ppc4xx_pic.h b/include/asm-ppc/ppc4xx_pic.h
--- a/include/asm-ppc/ppc4xx_pic.h	2004-11-10 23:39:19 -08:00
+++ b/include/asm-ppc/ppc4xx_pic.h	2004-11-10 23:39:19 -08:00
@@ -1,28 +1,53 @@
 /*
+ * include/asm-ppc/ppc4xx_pic.h
  *
- *    Copyright (c) 1999 Grant Erickson <grant@lcse.umn.edu>
+ * Interrupt controller driver for PowerPC 4xx-based processors.
  *
- *    Module name: ppc4xx_pic.h
+ * Copyright (c) 1999 Grant Erickson <grant@lcse.umn.edu>
  *
- *    Description:
- *      Interrupt controller driver for PowerPC 4xx-based processors.
+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ * Copyright (c) 2004 Zultys Technologies
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
  */
 
 #ifndef	__PPC4XX_PIC_H__
 #define	__PPC4XX_PIC_H__
 
 #include <linux/config.h>
+#include <linux/types.h>
 #include <linux/irq.h>
 
-/* External Global Variables */
-
-extern struct hw_interrupt_type *ppc4xx_pic;
-extern unsigned int ibm4xxPIC_NumInitSenses;
-extern unsigned char *ibm4xxPIC_InitSenses;
-
-/* Function Prototypes */
+/* "Fixed" UIC settings (they are chip, not board specific), 
+ * e.g. polarity/triggerring for internal interrupt sources.
+ *
+ * Platform port should provide NR_UICS-sized array named ppc4xx_core_uic_cfg
+ * with these "fixed" settings: .polarity contains exact value which will
+ * be written (masked with "ext_irq_mask") into UICx_PR register, 
+ * .triggering - to UICx_TR.
+ *
+ * Settings for external IRQs can be specified separately by the
+ * board support code. In this case properly sized array of unsigned
+ * char named ppc4xx_uic_ext_irq_cfg should be filled with correct
+ * values using IRQ_SENSE_XXXXX and IRQ_POLARITY_XXXXXXX defines.
+ *
+ * If these arrays aren't provided, UIC initialization code keeps firmware 
+ * configuration. Also, ppc4xx_uic_ext_irq_cfg implies ppc4xx_core_uic_cfg
+ * is defined.
+ *
+ * Both ppc4xx_core_uic_cfg and ppc4xx_uic_ext_irq_cfg are declared as 
+ * "weak" symbols in ppc4xx_pic.c
+ * 
+ */
+struct ppc4xx_uic_settings {
+	u32 	polarity;
+	u32 	triggering;
+	u32	ext_irq_mask;
+};
 
 extern void ppc4xx_pic_init(void);
-extern int ppc4xx_pic_get_irq(struct pt_regs *regs);
 
-#endif				/* __PPC4XX_PIC_H__ */
+#endif	/* __PPC4XX_PIC_H__ */
