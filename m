Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVARPj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVARPj6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 10:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVARPj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 10:39:57 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:59623 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261325AbVARPfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 10:35:22 -0500
Date: Tue, 18 Jan 2005 09:35:13 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@blarg.somerset.sps.mot.com
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH 3/4] ppc32: platform_device conversion from OCP
Message-ID: <Pine.LNX.4.61.0501180932140.11311@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert MPC8540 ADS, MPC8560 ADS, MPC8555 CDS and SBC8560 reference boards 
from using OCP to platform_device.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
diff -Nru a/arch/ppc/platforms/85xx/mpc8540_ads.c b/arch/ppc/platforms/85xx/mpc8540_ads.c
--- a/arch/ppc/platforms/85xx/mpc8540_ads.c	2005-01-17 22:31:44 -06:00
+++ b/arch/ppc/platforms/85xx/mpc8540_ads.c	2005-01-17 22:31:44 -06:00
@@ -32,6 +32,7 @@
 #include <linux/serial_core.h>
 #include <linux/initrd.h>
 #include <linux/module.h>
+#include <linux/fsl_devices.h>
 
 #include <asm/system.h>
 #include <asm/pgtable.h>
@@ -48,50 +49,11 @@
 #include <asm/irq.h>
 #include <asm/immap_85xx.h>
 #include <asm/kgdb.h>
-#include <asm/ocp.h>
+#include <asm/ppc_sys.h>
 #include <mm/mmu_decl.h>
 
-#include <syslib/ppc85xx_common.h>
 #include <syslib/ppc85xx_setup.h>
 
-struct ocp_gfar_data mpc85xx_tsec1_def = {
-	.interruptTransmit = MPC85xx_IRQ_TSEC1_TX,
-	.interruptError = MPC85xx_IRQ_TSEC1_ERROR,
-	.interruptReceive = MPC85xx_IRQ_TSEC1_RX,
-	.interruptPHY = MPC85xx_IRQ_EXT5,
-	.flags = (GFAR_HAS_GIGABIT | GFAR_HAS_MULTI_INTR
-			| GFAR_HAS_RMON
-			| GFAR_HAS_PHY_INTR | GFAR_HAS_COALESCE),
-	.phyid = 0,
-	.phyregidx = 0,
-};
-
-struct ocp_gfar_data mpc85xx_tsec2_def = {
-	.interruptTransmit = MPC85xx_IRQ_TSEC2_TX,
-	.interruptError = MPC85xx_IRQ_TSEC2_ERROR,
-	.interruptReceive = MPC85xx_IRQ_TSEC2_RX,
-	.interruptPHY = MPC85xx_IRQ_EXT5,
-	.flags = (GFAR_HAS_GIGABIT | GFAR_HAS_MULTI_INTR
-			| GFAR_HAS_RMON
-			| GFAR_HAS_PHY_INTR | GFAR_HAS_COALESCE),
-	.phyid = 1,
-	.phyregidx = 0,
-};
-
-struct ocp_gfar_data mpc85xx_fec_def = {
-	.interruptTransmit = MPC85xx_IRQ_FEC,
-	.interruptError = MPC85xx_IRQ_FEC,
-	.interruptReceive = MPC85xx_IRQ_FEC,
-	.interruptPHY = MPC85xx_IRQ_EXT5,
-	.flags = 0,
-	.phyid = 3,
-	.phyregidx = 0,
-};
-
-struct ocp_fs_i2c_data mpc85xx_i2c1_def = {
-	.flags = FS_I2C_SEPARATE_DFSRR,
-};
-
 /* ************************************************************************
  *
  * Setup the architecture
@@ -100,10 +62,9 @@
 static void __init
 mpc8540ads_setup_arch(void)
 {
-	struct ocp_def *def;
-	struct ocp_gfar_data *einfo;
 	bd_t *binfo = (bd_t *) __res;
 	unsigned int freq;
+	struct gianfar_platform_data *pdata;
 
 	/* get the core frequency */
 	freq = binfo->bi_intfreq;
@@ -130,23 +91,30 @@
 	invalidate_tlbcam_entry(NUM_TLBCAMS - 1);
 #endif
 
-	def = ocp_get_one_device(OCP_VENDOR_FREESCALE, OCP_FUNC_GFAR, 0);
-	if (def) {
-		einfo = (struct ocp_gfar_data *) def->additions;
-		memcpy(einfo->mac_addr, binfo->bi_enetaddr, 6);
-	}
-
-	def = ocp_get_one_device(OCP_VENDOR_FREESCALE, OCP_FUNC_GFAR, 1);
-	if (def) {
-		einfo = (struct ocp_gfar_data *) def->additions;
-		memcpy(einfo->mac_addr, binfo->bi_enet1addr, 6);
-	}
-
-	def = ocp_get_one_device(OCP_VENDOR_FREESCALE, OCP_FUNC_GFAR, 2);
-	if (def) {
-		einfo = (struct ocp_gfar_data *) def->additions;
-		memcpy(einfo->mac_addr, binfo->bi_enet2addr, 6);
-	}
+	/* setup the board related information for the enet controllers */
+	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
+	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
+	pdata->interruptPHY = MPC85xx_IRQ_EXT5;
+	pdata->phyid = 0;
+	/* fixup phy address */
+	pdata->phy_reg_addr += binfo->bi_immr_base;
+	memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
+
+	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC2);
+	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
+	pdata->interruptPHY = MPC85xx_IRQ_EXT5;
+	pdata->phyid = 1;
+	/* fixup phy address */
+	pdata->phy_reg_addr += binfo->bi_immr_base;
+	memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
+
+	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_FEC);
+	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
+	pdata->interruptPHY = MPC85xx_IRQ_EXT5;
+	pdata->phyid = 3;
+	/* fixup phy address */
+	pdata->phy_reg_addr += binfo->bi_immr_base;
+	memcpy(pdata->mac_addr, binfo->bi_enet2addr, 6);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start)
@@ -158,8 +126,6 @@
 #else
 		ROOT_DEV = Root_HDA1;
 #endif
-
-	ocp_for_each_device(mpc85xx_update_paddr_ocp, &(binfo->bi_immr_base));
 }
 
 /* ************************************************************************ */
@@ -205,6 +171,8 @@
 		*(char *) (r7 + KERNELBASE) = 0;
 		strcpy(cmd_line, (char *) (r6 + KERNELBASE));
 	}
+
+	identify_ppc_sys_by_id(mfspr(SVR));
 
 	/* setup the PowerPC module struct */
 	ppc_md.setup_arch = mpc8540ads_setup_arch;
diff -Nru a/arch/ppc/platforms/85xx/mpc8555_cds.h b/arch/ppc/platforms/85xx/mpc8555_cds.h
--- a/arch/ppc/platforms/85xx/mpc8555_cds.h	2005-01-17 22:31:44 -06:00
+++ b/arch/ppc/platforms/85xx/mpc8555_cds.h	2005-01-17 22:31:44 -06:00
@@ -18,7 +18,7 @@
 #define __MACH_MPC8555CDS_H__
 
 #include <linux/config.h>
-#include <linux/serial.h>
+#include <syslib/ppc85xx_setup.h>
 #include <platforms/85xx/mpc85xx_cds_common.h>
 
 #define CPM_MAP_ADDR	(CCSRBAR + MPC85xx_CPM_OFFSET)
diff -Nru a/arch/ppc/platforms/85xx/mpc8560_ads.c b/arch/ppc/platforms/85xx/mpc8560_ads.c
--- a/arch/ppc/platforms/85xx/mpc8560_ads.c	2005-01-17 22:31:44 -06:00
+++ b/arch/ppc/platforms/85xx/mpc8560_ads.c	2005-01-17 22:31:44 -06:00
@@ -32,6 +32,7 @@
 #include <linux/serial_core.h>
 #include <linux/initrd.h>
 #include <linux/module.h>
+#include <linux/fsl_devices.h>
 
 #include <asm/system.h>
 #include <asm/pgtable.h>
@@ -48,7 +49,7 @@
 #include <asm/irq.h>
 #include <asm/immap_85xx.h>
 #include <asm/kgdb.h>
-#include <asm/ocp.h>
+#include <asm/ppc_sys.h>
 #include <asm/cpm2.h>
 #include <mm/mmu_decl.h>
 
@@ -58,34 +59,6 @@
 
 extern void cpm2_reset(void);
 
-struct ocp_gfar_data mpc85xx_tsec1_def = {
-        .interruptTransmit = MPC85xx_IRQ_TSEC1_TX,
-        .interruptError = MPC85xx_IRQ_TSEC1_ERROR,
-        .interruptReceive = MPC85xx_IRQ_TSEC1_RX,
-        .interruptPHY = MPC85xx_IRQ_EXT5,
-        .flags = (GFAR_HAS_GIGABIT | GFAR_HAS_MULTI_INTR
-			| GFAR_HAS_RMON | GFAR_HAS_COALESCE
-                        | GFAR_HAS_PHY_INTR),
-        .phyid = 0,
-        .phyregidx = 0,
-};
-
-struct ocp_gfar_data mpc85xx_tsec2_def = {
-        .interruptTransmit = MPC85xx_IRQ_TSEC2_TX,
-        .interruptError = MPC85xx_IRQ_TSEC2_ERROR,
-        .interruptReceive = MPC85xx_IRQ_TSEC2_RX,
-        .interruptPHY = MPC85xx_IRQ_EXT5,
-        .flags = (GFAR_HAS_GIGABIT | GFAR_HAS_MULTI_INTR
-			| GFAR_HAS_RMON | GFAR_HAS_COALESCE
-                        | GFAR_HAS_PHY_INTR),
-        .phyid = 1,
-        .phyregidx = 0,
-};
-
-struct ocp_fs_i2c_data mpc85xx_i2c1_def = {
-	.flags = FS_I2C_SEPARATE_DFSRR,
-};
-
 /* ************************************************************************
  *
  * Setup the architecture
@@ -95,11 +68,10 @@
 static void __init
 mpc8560ads_setup_arch(void)
 {
-	struct ocp_def *def;
-	struct ocp_gfar_data *einfo;
 	bd_t *binfo = (bd_t *) __res;
 	unsigned int freq;
-
+	struct gianfar_platform_data *pdata;
+	
 	cpm2_reset();
 
 	/* get the core frequency */
@@ -117,17 +89,22 @@
 	mpc85xx_setup_hose();
 #endif
 
-	def = ocp_get_one_device(OCP_VENDOR_FREESCALE, OCP_FUNC_GFAR, 0);
-	if (def) {
-		einfo = (struct ocp_gfar_data *) def->additions;
-		memcpy(einfo->mac_addr, binfo->bi_enetaddr, 6);
-	}
-
-	def = ocp_get_one_device(OCP_VENDOR_FREESCALE, OCP_FUNC_GFAR, 1);
-	if (def) {
-		einfo = (struct ocp_gfar_data *) def->additions;
-		memcpy(einfo->mac_addr, binfo->bi_enet1addr, 6);
-	}
+	/* setup the board related information for the enet controllers */
+	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
+	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
+	pdata->interruptPHY = MPC85xx_IRQ_EXT5;
+	pdata->phyid = 0;
+	/* fixup phy address */
+	pdata->phy_reg_addr += binfo->bi_immr_base;
+	memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
+
+	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC2);
+	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
+	pdata->interruptPHY = MPC85xx_IRQ_EXT5;
+	pdata->phyid = 1;
+	/* fixup phy address */
+	pdata->phy_reg_addr += binfo->bi_immr_base;
+	memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start)
@@ -139,8 +116,6 @@
 #else
 		ROOT_DEV = Root_HDA1;
 #endif
-
-	ocp_for_each_device(mpc85xx_update_paddr_ocp, &(binfo->bi_immr_base));
 }
 
 static irqreturn_t cpm2_cascade(int irq, void *dev_id, struct pt_regs *regs)
@@ -221,6 +196,8 @@
 		*(char *) (r7 + KERNELBASE) = 0;
 		strcpy(cmd_line, (char *) (r6 + KERNELBASE));
 	}
+
+	identify_ppc_sys_by_id(mfspr(SVR));
 
 	/* setup the PowerPC module struct */
 	ppc_md.setup_arch = mpc8560ads_setup_arch;
diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_ads_common.c b/arch/ppc/platforms/85xx/mpc85xx_ads_common.c
--- a/arch/ppc/platforms/85xx/mpc85xx_ads_common.c	2005-01-17 22:31:44 -06:00
+++ b/arch/ppc/platforms/85xx/mpc85xx_ads_common.c	2005-01-17 22:31:44 -06:00
@@ -43,7 +43,6 @@
 #include <asm/mpc85xx.h>
 #include <asm/irq.h>
 #include <asm/immap_85xx.h>
-#include <asm/ocp.h>
 
 #include <mm/mmu_decl.h>
 
diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
--- a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2005-01-17 22:31:44 -06:00
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2005-01-17 22:31:44 -06:00
@@ -32,6 +32,7 @@
 #include <linux/initrd.h>
 #include <linux/tty.h>
 #include <linux/serial_core.h>
+#include <linux/fsl_devices.h>
 
 #include <asm/system.h>
 #include <asm/pgtable.h>
@@ -48,7 +49,7 @@
 #include <asm/irq.h>
 #include <asm/immap_85xx.h>
 #include <asm/immap_cpm2.h>
-#include <asm/ocp.h>
+#include <asm/ppc_sys.h>
 #include <asm/kgdb.h>
 
 #include <mm/mmu_decl.h>
@@ -129,32 +130,6 @@
 #endif
 };
 
-struct ocp_gfar_data mpc85xx_tsec1_def = {
-        .interruptTransmit = MPC85xx_IRQ_TSEC1_TX,
-        .interruptError = MPC85xx_IRQ_TSEC1_ERROR,
-        .interruptReceive = MPC85xx_IRQ_TSEC1_RX,
-        .interruptPHY = MPC85xx_IRQ_EXT5,
-        .flags = (GFAR_HAS_GIGABIT | GFAR_HAS_MULTI_INTR |
-                        GFAR_HAS_PHY_INTR),
-        .phyid = 0,
-        .phyregidx = 0,
-};
-
-struct ocp_gfar_data mpc85xx_tsec2_def = {
-        .interruptTransmit = MPC85xx_IRQ_TSEC2_TX,
-        .interruptError = MPC85xx_IRQ_TSEC2_ERROR,
-        .interruptReceive = MPC85xx_IRQ_TSEC2_RX,
-        .interruptPHY = MPC85xx_IRQ_EXT5,
-        .flags = (GFAR_HAS_GIGABIT | GFAR_HAS_MULTI_INTR |
-                        GFAR_HAS_PHY_INTR),
-        .phyid = 1,
-        .phyregidx = 0,
-};
-
-struct ocp_fs_i2c_data mpc85xx_i2c1_def = {
-	.flags = FS_I2C_SEPARATE_DFSRR,
-};
-
 /* ************************************************************************ */
 int
 mpc85xx_cds_show_cpuinfo(struct seq_file *m)
@@ -335,11 +310,10 @@
 static void __init
 mpc85xx_cds_setup_arch(void)
 {
-        struct ocp_def *def;
-        struct ocp_gfar_data *einfo;
         bd_t *binfo = (bd_t *) __res;
         unsigned int freq;
-
+	struct gianfar_platform_data *pdata;
+	
         /* get the core frequency */
         freq = binfo->bi_intfreq;
 
@@ -372,17 +346,23 @@
 	invalidate_tlbcam_entry(NUM_TLBCAMS - 1);
 #endif
 
-        def = ocp_get_one_device(OCP_VENDOR_FREESCALE, OCP_FUNC_GFAR, 0);
-        if (def) {
-                einfo = (struct ocp_gfar_data *) def->additions;
-                memcpy(einfo->mac_addr, binfo->bi_enetaddr, 6);
-        }
+	/* setup the board related information for the enet controllers */
+	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
+	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
+	pdata->interruptPHY = MPC85xx_IRQ_EXT5;
+	pdata->phyid = 0;
+	/* fixup phy address */
+	pdata->phy_reg_addr += binfo->bi_immr_base;
+	memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
+
+	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC2);
+	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
+	pdata->interruptPHY = MPC85xx_IRQ_EXT5;
+	pdata->phyid = 1;
+	/* fixup phy address */
+	pdata->phy_reg_addr += binfo->bi_immr_base;
+	memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
 
-        def = ocp_get_one_device(OCP_VENDOR_FREESCALE, OCP_FUNC_GFAR, 1);
-        if (def) {
-                einfo = (struct ocp_gfar_data *) def->additions;
-                memcpy(einfo->mac_addr, binfo->bi_enet1addr, 6);
-        }
 
 #ifdef CONFIG_BLK_DEV_INITRD
         if (initrd_start)
@@ -394,8 +374,6 @@
 #else
                 ROOT_DEV = Root_HDA1;
 #endif
-
-	ocp_for_each_device(mpc85xx_update_paddr_ocp, &(binfo->bi_immr_base));
 }
 
 /* ************************************************************************ */
@@ -443,6 +421,8 @@
                 *(char *) (r7 + KERNELBASE) = 0;
                 strcpy(cmd_line, (char *) (r6 + KERNELBASE));
         }
+
+	identify_ppc_sys_by_id(mfspr(SVR));
 
         /* setup the PowerPC module struct */
         ppc_md.setup_arch = mpc85xx_cds_setup_arch;
diff -Nru a/arch/ppc/platforms/85xx/sbc8560.c b/arch/ppc/platforms/85xx/sbc8560.c
--- a/arch/ppc/platforms/85xx/sbc8560.c	2005-01-17 22:31:44 -06:00
+++ b/arch/ppc/platforms/85xx/sbc8560.c	2005-01-17 22:31:44 -06:00
@@ -32,6 +32,7 @@
 #include <linux/serial_core.h>
 #include <linux/initrd.h>
 #include <linux/module.h>
+#include <linux/fsl_devices.h>
 
 #include <asm/system.h>
 #include <asm/pgtable.h>
@@ -48,37 +49,12 @@
 #include <asm/irq.h>
 #include <asm/immap_85xx.h>
 #include <asm/kgdb.h>
-#include <asm/ocp.h>
+#include <asm/ppc_sys.h>
 #include <mm/mmu_decl.h>
 
 #include <syslib/ppc85xx_common.h>
 #include <syslib/ppc85xx_setup.h>
 
-struct ocp_gfar_data mpc85xx_tsec1_def = {
-	.interruptTransmit = MPC85xx_IRQ_TSEC1_TX,
-	.interruptError = MPC85xx_IRQ_TSEC1_ERROR,
-	.interruptReceive = MPC85xx_IRQ_TSEC1_RX,
-	.interruptPHY = MPC85xx_IRQ_EXT6,
-	.flags = (GFAR_HAS_GIGABIT | GFAR_HAS_MULTI_INTR | GFAR_HAS_PHY_INTR),
-	.phyid = 25,
-	.phyregidx = 0,
-};
-
-struct ocp_gfar_data mpc85xx_tsec2_def = {
-	.interruptTransmit = MPC85xx_IRQ_TSEC2_TX,
-	.interruptError = MPC85xx_IRQ_TSEC2_ERROR,
-	.interruptReceive = MPC85xx_IRQ_TSEC2_RX,
-	.interruptPHY = MPC85xx_IRQ_EXT7,
-	.flags = (GFAR_HAS_GIGABIT | GFAR_HAS_MULTI_INTR | GFAR_HAS_PHY_INTR),
-	.phyid = 26,
-	.phyregidx = 0,
-};
-
-struct ocp_fs_i2c_data mpc85xx_i2c1_def = {
-	.flags = FS_I2C_SEPARATE_DFSRR,
-};
-
-
 #ifdef CONFIG_SERIAL_8250
 static void __init
 sbc8560_early_serial_map(void)
@@ -125,10 +101,9 @@
 static void __init
 sbc8560_setup_arch(void)
 {
-	struct ocp_def *def;
-	struct ocp_gfar_data *einfo;
 	bd_t *binfo = (bd_t *) __res;
 	unsigned int freq;
+	struct gianfar_platform_data *pdata;
 
 	/* get the core frequency */
 	freq = binfo->bi_intfreq;
@@ -153,18 +128,22 @@
 	invalidate_tlbcam_entry(NUM_TLBCAMS - 1);
 #endif
 
-	/* Set up MAC addresses for the Ethernet devices */
-	def = ocp_get_one_device(OCP_VENDOR_FREESCALE, OCP_FUNC_GFAR, 0);
-	if (def) {
-		einfo = (struct ocp_gfar_data *) def->additions;
-		memcpy(einfo->mac_addr, binfo->bi_enetaddr, 6);
-	}
-
-	def = ocp_get_one_device(OCP_VENDOR_FREESCALE, OCP_FUNC_GFAR, 1);
-	if (def) {
-		einfo = (struct ocp_gfar_data *) def->additions;
-		memcpy(einfo->mac_addr, binfo->bi_enet1addr, 6);
-	}
+	/* setup the board related information for the enet controllers */
+	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
+	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
+	pdata->interruptPHY = MPC85xx_IRQ_EXT6;
+	pdata->phyid = 25;
+	/* fixup phy address */
+	pdata->phy_reg_addr += binfo->bi_immr_base;
+	memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
+
+	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC2);
+	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
+	pdata->interruptPHY = MPC85xx_IRQ_EXT7;
+	pdata->phyid = 26;
+	/* fixup phy address */
+	pdata->phy_reg_addr += binfo->bi_immr_base;
+	memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start)
@@ -176,8 +155,6 @@
 #else
 		ROOT_DEV = Root_HDA1;
 #endif
-
-	ocp_for_each_device(mpc85xx_update_paddr_ocp, &(binfo->bi_immr_base));
 }
 
 /* ************************************************************************ */
@@ -220,6 +197,8 @@
 		*(char *) (r7 + KERNELBASE) = 0;
 		strcpy(cmd_line, (char *) (r6 + KERNELBASE));
 	}
+
+	identify_ppc_sys_by_id(mfspr(SVR));
 
 	/* setup the PowerPC module struct */
 	ppc_md.setup_arch = sbc8560_setup_arch;
diff -Nru a/arch/ppc/platforms/85xx/sbc85xx.c b/arch/ppc/platforms/85xx/sbc85xx.c
--- a/arch/ppc/platforms/85xx/sbc85xx.c	2005-01-17 22:31:44 -06:00
+++ b/arch/ppc/platforms/85xx/sbc85xx.c	2005-01-17 22:31:44 -06:00
@@ -42,7 +42,6 @@
 #include <asm/mpc85xx.h>
 #include <asm/irq.h>
 #include <asm/immap_85xx.h>
-#include <asm/ocp.h>
 
 #include <mm/mmu_decl.h>
 

