Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWHGXb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWHGXb6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 19:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWHGXbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 19:31:43 -0400
Received: from cdma-45-249.msk.skylink.ru ([83.217.45.249]:38364 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932405AbWHGXbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 19:31:37 -0400
To: Jeff Garzik <jeff@garzik.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 3/3] ppc32: board-specific part of fs_enet update
Date: Tue, 08 Aug 2006 03:31:02 +0400
Message-Id: <20060807233102.13951.92448.stgit@localhost.localdomain>
In-Reply-To: <20060807232913.13951.54542.stgit@localhost.localdomain>
References: <20060807232913.13951.54542.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This contains board-specific portion to respect driver changes (for 8272ads
, 885ads and 866ads). Altered platform_data structures as well as initial
setup routines relevant to fs_enet.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 arch/ppc/platforms/85xx/mpc8560_ads.c        |   89 ++++++++++++
 arch/ppc/platforms/85xx/mpc85xx_ads_common.h |   19 +++
 arch/ppc/platforms/mpc8272ads_setup.c        |  154 ++++++++++++---------
 arch/ppc/platforms/mpc866ads_setup.c         |  192 +++++++++++++-------------
 arch/ppc/platforms/mpc885ads_setup.c         |  175 +++++++++---------------
 arch/ppc/platforms/pq2ads_pd.h               |   82 -----------
 arch/ppc/syslib/mpc85xx_devices.c            |   89 ++++++++++++
 arch/ppc/syslib/mpc8xx_devices.c             |    8 +
 arch/ppc/syslib/mpc8xx_sys.c                 |    6 +
 arch/ppc/syslib/pq2_devices.c                |    5 +
 arch/ppc/syslib/pq2_sys.c                    |    3 
 include/asm-ppc/cpm2.h                       |   95 +++++++++++++
 include/asm-ppc/mpc8260.h                    |    1 
 include/asm-ppc/mpc8xx.h                     |    1 
 include/linux/fs_enet_pd.h                   |   50 +++----
 15 files changed, 578 insertions(+), 391 deletions(-)

diff --git a/arch/ppc/platforms/85xx/mpc8560_ads.c b/arch/ppc/platforms/85xx/mpc8560_ads.c
index d90cd24..94badaf 100644
--- a/arch/ppc/platforms/85xx/mpc8560_ads.c
+++ b/arch/ppc/platforms/85xx/mpc8560_ads.c
@@ -29,6 +29,7 @@ #include <linux/serial_core.h>
 #include <linux/initrd.h>
 #include <linux/module.h>
 #include <linux/fsl_devices.h>
+#include <linux/fs_enet_pd.h>
 
 #include <asm/system.h>
 #include <asm/pgtable.h>
@@ -58,6 +59,71 @@ #include <syslib/ppc85xx_setup.h>
  * Setup the architecture
  *
  */
+static void init_fcc_ioports(void)
+{
+	struct immap *immap;
+	struct io_port *io;
+	u32 tempval;
+
+	immap = cpm2_immr;
+
+	io = &immap->im_ioport;
+	/* FCC2/3 are on the ports B/C. */
+	tempval = in_be32(&io->iop_pdirb);
+	tempval &= ~PB2_DIRB0;
+	tempval |= PB2_DIRB1;
+	out_be32(&io->iop_pdirb, tempval);
+
+	tempval = in_be32(&io->iop_psorb);
+	tempval &= ~PB2_PSORB0;
+	tempval |= PB2_PSORB1;
+	out_be32(&io->iop_psorb, tempval);
+
+	tempval = in_be32(&io->iop_pparb);
+	tempval |= (PB2_DIRB0 | PB2_DIRB1);
+	out_be32(&io->iop_pparb, tempval);
+
+	tempval = in_be32(&io->iop_pdirb);
+	tempval &= ~PB3_DIRB0;
+	tempval |= PB3_DIRB1;
+	out_be32(&io->iop_pdirb, tempval);
+
+	tempval = in_be32(&io->iop_psorb);
+	tempval &= ~PB3_PSORB0;
+	tempval |= PB3_PSORB1;
+	out_be32(&io->iop_psorb, tempval);
+
+	tempval = in_be32(&io->iop_pparb);
+	tempval |= (PB3_DIRB0 | PB3_DIRB1);
+	out_be32(&io->iop_pparb, tempval);
+
+        tempval = in_be32(&io->iop_pdirc);
+        tempval |= PC3_DIRC1;
+        out_be32(&io->iop_pdirc, tempval);
+
+        tempval = in_be32(&io->iop_pparc);
+        tempval |= PC3_DIRC1;
+        out_be32(&io->iop_pparc, tempval);
+
+	/* Port C has clocks......  */
+	tempval = in_be32(&io->iop_psorc);
+	tempval &= ~(CLK_TRX);
+	out_be32(&io->iop_psorc, tempval);
+
+	tempval = in_be32(&io->iop_pdirc);
+	tempval &= ~(CLK_TRX);
+	out_be32(&io->iop_pdirc, tempval);
+	tempval = in_be32(&io->iop_pparc);
+	tempval |= (CLK_TRX);
+	out_be32(&io->iop_pparc, tempval);
+
+	/* Configure Serial Interface clock routing.
+	 * First,  clear all FCC bits to zero,
+	 * then set the ones we want.
+	 */
+	immap->im_cpmux.cmx_fcr &= ~(CPMUX_CLK_MASK);
+	immap->im_cpmux.cmx_fcr |= CPMUX_CLK_ROUTE;
+}
 
 static void __init
 mpc8560ads_setup_arch(void)
@@ -66,6 +132,7 @@ mpc8560ads_setup_arch(void)
 	unsigned int freq;
 	struct gianfar_platform_data *pdata;
 	struct gianfar_mdio_data *mdata;
+	struct fs_platform_info *fpi;
 
 	cpm2_reset();
 
@@ -110,6 +177,28 @@ #endif
 		memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
 	}
 
+	init_fcc_ioports();
+	ppc_sys_device_remove(MPC85xx_CPM_FCC1);
+
+	fpi = (struct fs_platform_info *) ppc_sys_get_pdata(MPC85xx_CPM_FCC2);
+	if (fpi) {
+		memcpy(fpi->macaddr, binfo->bi_enet2addr, 6);
+		fpi->bus_id = "0:02";
+		fpi->phy_addr = 2;
+		fpi->dpram_offset = (u32)cpm2_immr->im_dprambase;
+		fpi->fcc_regs_c = (u32)&cpm2_immr->im_fcc_c[1];
+	}
+
+	fpi = (struct fs_platform_info *) ppc_sys_get_pdata(MPC85xx_CPM_FCC3);
+	if (fpi) {
+		memcpy(fpi->macaddr, binfo->bi_enet2addr, 6);
+		fpi->macaddr[5] += 1;
+		fpi->bus_id = "0:03";
+		fpi->phy_addr = 3;
+		fpi->dpram_offset = (u32)cpm2_immr->im_dprambase;
+		fpi->fcc_regs_c = (u32)&cpm2_immr->im_fcc_c[2];
+	}
+
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start)
 		ROOT_DEV = Root_RAM0;
diff --git a/arch/ppc/platforms/85xx/mpc85xx_ads_common.h b/arch/ppc/platforms/85xx/mpc85xx_ads_common.h
index abf3228..c8c322f 100644
--- a/arch/ppc/platforms/85xx/mpc85xx_ads_common.h
+++ b/arch/ppc/platforms/85xx/mpc85xx_ads_common.h
@@ -45,4 +45,23 @@ #define MPC85XX_PCI1_MEM_OFFSET	0x000000
 
 #define MPC85XX_PCI1_IO_SIZE	0x01000000
 
+/* FCC1 Clock Source Configuration.  These can be
+ * redefined in the board specific file.
+ *    Can only choose from CLK9-12 */
+#define F1_RXCLK       12
+#define F1_TXCLK       11
+
+/* FCC2 Clock Source Configuration.  These can be
+ * redefined in the board specific file.
+ *    Can only choose from CLK13-16 */
+#define F2_RXCLK       13
+#define F2_TXCLK       14
+
+/* FCC3 Clock Source Configuration.  These can be
+ * redefined in the board specific file.
+ *    Can only choose from CLK13-16 */
+#define F3_RXCLK       15
+#define F3_TXCLK       16
+
+
 #endif				/* __MACH_MPC85XX_ADS_H__ */
diff --git a/arch/ppc/platforms/mpc8272ads_setup.c b/arch/ppc/platforms/mpc8272ads_setup.c
index abb7154..2a35fe2 100644
--- a/arch/ppc/platforms/mpc8272ads_setup.c
+++ b/arch/ppc/platforms/mpc8272ads_setup.c
@@ -56,64 +56,51 @@ static struct fs_uart_platform_info mpc8
 	},
 };
 
-static struct fs_mii_bus_info mii_bus_info = {
-	.method                 = fsmii_bitbang,
-	.id                     = 0,
-	.i.bitbang = {
-		.mdio_port	= fsiop_portc,
-		.mdio_bit	= 18,
-		.mdc_port	= fsiop_portc,
-		.mdc_bit	= 19,
-		.delay		= 1,
-	},
-};
-
-static struct fs_platform_info mpc82xx_fcc1_pdata = {
-	.fs_no		= fsid_fcc1,
-	.cp_page	= CPM_CR_FCC1_PAGE,
-	.cp_block 	= CPM_CR_FCC1_SBLOCK,
-	.clk_trx 	= (PC_F1RXCLK | PC_F1TXCLK),
-	.clk_route	= CMX1_CLK_ROUTE,
-	.clk_mask	= CMX1_CLK_MASK,
-	.init_ioports 	= init_fcc1_ioports,
-
-	.phy_addr	= 0,
-#ifdef PHY_INTERRUPT
-	.phy_irq	= PHY_INTERRUPT,
-#else
-	.phy_irq	= -1;
-#endif
-	.mem_offset	= FCC1_MEM_OFFSET,
-	.bus_info	= &mii_bus_info,
-	.rx_ring	= 32,
-	.tx_ring	= 32,
-	.rx_copybreak	= 240,
-	.use_napi	= 0,
-	.napi_weight	= 17,
+static struct fs_mii_bb_platform_info m82xx_mii_bb_pdata = {
+	.mdio_dat.bit	= 18,
+	.mdio_dir.bit	= 18,
+	.mdc_dat.bit	= 19,
+	.delay		= 1,
 };
 
-static struct fs_platform_info mpc82xx_fcc2_pdata = {
-	.fs_no		= fsid_fcc2,
-	.cp_page	= CPM_CR_FCC2_PAGE,
-	.cp_block 	= CPM_CR_FCC2_SBLOCK,
-	.clk_trx 	= (PC_F2RXCLK | PC_F2TXCLK),
-	.clk_route	= CMX2_CLK_ROUTE,
-	.clk_mask	= CMX2_CLK_MASK,
-	.init_ioports	= init_fcc2_ioports,
-
-	.phy_addr	= 3,
-#ifdef PHY_INTERRUPT
-	.phy_irq	= PHY_INTERRUPT,
-#else
-	.phy_irq	= -1;
-#endif
-	.mem_offset	= FCC2_MEM_OFFSET,
-	.bus_info	= &mii_bus_info,
-	.rx_ring	= 32,
-	.tx_ring	= 32,
-	.rx_copybreak	= 240,
-	.use_napi	= 0,
-	.napi_weight	= 17,
+static struct fs_platform_info mpc82xx_enet_pdata[] = {
+	[fsid_fcc1] = {
+		.fs_no		= fsid_fcc1,
+		.cp_page	= CPM_CR_FCC1_PAGE,
+		.cp_block 	= CPM_CR_FCC1_SBLOCK,
+
+		.clk_trx 	= (PC_F1RXCLK | PC_F1TXCLK),
+		.clk_route	= CMX1_CLK_ROUTE,
+		.clk_mask	= CMX1_CLK_MASK,
+		.init_ioports 	= init_fcc1_ioports,
+
+		.mem_offset	= FCC1_MEM_OFFSET,
+
+		.rx_ring	= 32,
+		.tx_ring	= 32,
+		.rx_copybreak	= 240,
+		.use_napi	= 0,
+		.napi_weight	= 17,
+		.bus_id		= "0:00",
+	},
+	[fsid_fcc2] = {
+		.fs_no		= fsid_fcc2,
+		.cp_page	= CPM_CR_FCC2_PAGE,
+		.cp_block 	= CPM_CR_FCC2_SBLOCK,
+		.clk_trx 	= (PC_F2RXCLK | PC_F2TXCLK),
+		.clk_route	= CMX2_CLK_ROUTE,
+		.clk_mask	= CMX2_CLK_MASK,
+		.init_ioports	= init_fcc2_ioports,
+
+		.mem_offset	= FCC2_MEM_OFFSET,
+
+		.rx_ring	= 32,
+		.tx_ring	= 32,
+		.rx_copybreak	= 240,
+		.use_napi	= 0,
+		.napi_weight	= 17,
+		.bus_id		= "0:03",
+	},
 };
 
 static void init_fcc1_ioports(void)
@@ -209,20 +196,21 @@ static void __init mpc8272ads_fixup_enet
 	bd_t* bi = (void*)__res;
 	int fs_no = fsid_fcc1+pdev->id-1;
 
-	mpc82xx_fcc1_pdata.dpram_offset = mpc82xx_fcc2_pdata.dpram_offset = (u32)cpm2_immr->im_dprambase;
-	mpc82xx_fcc1_pdata.fcc_regs_c = mpc82xx_fcc2_pdata.fcc_regs_c = (u32)cpm2_immr->im_fcc_c;
-
-	switch(fs_no) {
-		case fsid_fcc1:
-			memcpy(&mpc82xx_fcc1_pdata.macaddr,bi->bi_enetaddr,6);
-			pdev->dev.platform_data = &mpc82xx_fcc1_pdata;
-		break;
-		case fsid_fcc2:
-			memcpy(&mpc82xx_fcc2_pdata.macaddr,bi->bi_enetaddr,6);
-			mpc82xx_fcc2_pdata.macaddr[5] ^= 1;
-			pdev->dev.platform_data = &mpc82xx_fcc2_pdata;
-		break;
+	if(fs_no > ARRAY_SIZE(mpc82xx_enet_pdata)) {
+		return;
 	}
+
+	mpc82xx_enet_pdata[fs_no].dpram_offset=
+			(u32)cpm2_immr->im_dprambase;
+	mpc82xx_enet_pdata[fs_no].fcc_regs_c =
+			(u32)cpm2_immr->im_fcc_c;
+	memcpy(&mpc82xx_enet_pdata[fs_no].macaddr,bi->bi_enetaddr,6);
+
+	/* prevent dup mac */
+	if(fs_no == fsid_fcc2)
+		mpc82xx_enet_pdata[fs_no].macaddr[5] ^= 1;
+
+	pdev->dev.platform_data = &mpc82xx_enet_pdata[fs_no];
 }
 
 static void mpc8272ads_fixup_uart_pdata(struct platform_device *pdev,
@@ -274,6 +262,29 @@ static void init_scc4_uart_ioports(void)
 	iounmap(immap);
 }
 
+static void __init mpc8272ads_fixup_mdio_pdata(struct platform_device *pdev,
+					      int idx)
+{
+	m82xx_mii_bb_pdata.irq[0] = PHY_INTERRUPT;
+	m82xx_mii_bb_pdata.irq[1] = -1;
+	m82xx_mii_bb_pdata.irq[2] = -1;
+	m82xx_mii_bb_pdata.irq[3] = PHY_INTERRUPT;
+	m82xx_mii_bb_pdata.irq[31] = -1;
+
+
+	m82xx_mii_bb_pdata.mdio_dat.offset =
+				(u32)&cpm2_immr->im_ioport.iop_pdatc;
+
+	m82xx_mii_bb_pdata.mdio_dir.offset =
+				(u32)&cpm2_immr->im_ioport.iop_pdirc;
+
+	m82xx_mii_bb_pdata.mdc_dat.offset =
+				(u32)&cpm2_immr->im_ioport.iop_pdatc;
+
+
+	pdev->dev.platform_data = &m82xx_mii_bb_pdata;
+}
+
 static int mpc8272ads_platform_notify(struct device *dev)
 {
 	static const struct platform_notify_dev_map dev_map[] = {
@@ -286,6 +297,10 @@ static int mpc8272ads_platform_notify(st
 			.rtn = mpc8272ads_fixup_uart_pdata,
 		},
 		{
+			.bus_id = "fsl-bb-mdio",
+			.rtn = mpc8272ads_fixup_mdio_pdata,
+		},
+		{
 			.bus_id = NULL
 		}
 	};
@@ -319,6 +334,7 @@ #ifdef CONFIG_SERIAL_CPM_SCC4
 	ppc_sys_device_enable(MPC82xx_CPM_SCC4);
 #endif
 
+	ppc_sys_device_enable(MPC82xx_MDIO_BB);
 
 	return 0;
 }
diff --git a/arch/ppc/platforms/mpc866ads_setup.c b/arch/ppc/platforms/mpc866ads_setup.c
index f19b616..e12cece 100644
--- a/arch/ppc/platforms/mpc866ads_setup.c
+++ b/arch/ppc/platforms/mpc866ads_setup.c
@@ -1,10 +1,10 @@
-/*arch/ppc/platforms/mpc885ads-setup.c
+/*arch/ppc/platforms/mpc866ads-setup.c
  *
- * Platform setup for the Freescale mpc885ads board
+ * Platform setup for the Freescale mpc866ads board
  *
  * Vitaly Bordug <vbordug@ru.mvista.com>
  *
- * Copyright 2005 MontaVista Software Inc.
+ * Copyright 2005-2006 MontaVista Software Inc.
  *
  * This file is licensed under the terms of the GNU General Public License
  * version 2. This program is licensed "as is" without any warranty of any
@@ -42,49 +42,36 @@ static void setup_scc1_ioports(void);
 static void setup_smc1_ioports(void);
 static void setup_smc2_ioports(void);
 
-static struct fs_mii_bus_info fec_mii_bus_info = {
-	.method = fsmii_fec,
-	.id = 0,
-};
-
-static struct fs_mii_bus_info scc_mii_bus_info = {
-	.method = fsmii_fixed,
-	.id = 0,
-	.i.fixed.speed = 10,
-	.i.fixed.duplex = 0,
-};
+static struct fs_mii_fec_platform_info	mpc8xx_mdio_fec_pdata;
 
-static struct fs_platform_info mpc8xx_fec_pdata[] = {
-	{
-	 .rx_ring = 128,
-	 .tx_ring = 16,
-	 .rx_copybreak = 240,
+static struct fs_mii_fec_platform_info mpc8xx_mdio_fec_pdata;
 
-	 .use_napi = 1,
-	 .napi_weight = 17,
+static struct fs_platform_info mpc8xx_enet_pdata[] = {
+	[fsid_fec1] = {
+		.rx_ring = 128,
+		.tx_ring = 16,
+		.rx_copybreak = 240,
 
-	 .phy_addr = 15,
-	 .phy_irq = -1,
+		.use_napi = 1,
+		.napi_weight = 17,
 
-	 .use_rmii = 0,
+		.init_ioports = setup_fec1_ioports,
 
-	 .bus_info = &fec_mii_bus_info,
-	 }
-};
+		.bus_id = "0:0f",
+		.has_phy = 1,
+	},
+	[fsid_scc1] = {
+		.rx_ring = 64,
+		.tx_ring = 8,
+		.rx_copybreak = 240,
+		.use_napi = 1,
+		.napi_weight = 17,
 
-static struct fs_platform_info mpc8xx_scc_pdata = {
-	.rx_ring = 64,
-	.tx_ring = 8,
-	.rx_copybreak = 240,
 
-	.use_napi = 1,
-	.napi_weight = 17,
-
-	.phy_addr = -1,
-	.phy_irq = -1,
-
-	.bus_info = &scc_mii_bus_info,
+		.init_ioports = setup_scc1_ioports,
 
+		.bus_id = "fixed@100:1",
+	},
 };
 
 static struct fs_uart_platform_info mpc866_uart_pdata[] = {
@@ -207,63 +194,6 @@ static void setup_scc1_ioports(void)
 
 }
 
-static void mpc866ads_fixup_enet_pdata(struct platform_device *pdev, int fs_no)
-{
-	struct fs_platform_info *fpi = pdev->dev.platform_data;
-
-	volatile cpm8xx_t *cp;
-	bd_t *bd = (bd_t *) __res;
-	char *e;
-	int i;
-
-	/* Get pointer to Communication Processor */
-	cp = cpmp;
-	switch (fs_no) {
-	case fsid_fec1:
-		fpi = &mpc8xx_fec_pdata[0];
-		fpi->init_ioports = &setup_fec1_ioports;
-
-		break;
-	case fsid_scc1:
-		fpi = &mpc8xx_scc_pdata;
-		fpi->init_ioports = &setup_scc1_ioports;
-
-		break;
-	default:
-		printk(KERN_WARNING"Device %s is not supported!\n", pdev->name);
-		return;
-	}
-
-	pdev->dev.platform_data = fpi;
-	fpi->fs_no = fs_no;
-
-	e = (unsigned char *)&bd->bi_enetaddr;
-	for (i = 0; i < 6; i++)
-		fpi->macaddr[i] = *e++;
-
-	fpi->macaddr[5 - pdev->id]++;
-
-}
-
-static void mpc866ads_fixup_fec_enet_pdata(struct platform_device *pdev,
-					   int idx)
-{
-	/* This is for FEC devices only */
-	if (!pdev || !pdev->name || (!strstr(pdev->name, "fsl-cpm-fec")))
-		return;
-	mpc866ads_fixup_enet_pdata(pdev, fsid_fec1 + pdev->id - 1);
-}
-
-static void mpc866ads_fixup_scc_enet_pdata(struct platform_device *pdev,
-					   int idx)
-{
-	/* This is for SCC devices only */
-	if (!pdev || !pdev->name || (!strstr(pdev->name, "fsl-cpm-scc")))
-		return;
-
-	mpc866ads_fixup_enet_pdata(pdev, fsid_scc1 + pdev->id - 1);
-}
-
 static void setup_smc1_ioports(void)
 {
 	immap_t *immap = (immap_t *) IMAP_ADDR;
@@ -315,6 +245,56 @@ #endif
 
 }
 
+static int ma_count = 0;
+
+static void mpc866ads_fixup_enet_pdata(struct platform_device *pdev, int fs_no)
+{
+	struct fs_platform_info *fpi;
+
+	volatile cpm8xx_t *cp;
+	bd_t *bd = (bd_t *) __res;
+	char *e;
+	int i;
+
+	/* Get pointer to Communication Processor */
+	cp = cpmp;
+
+	if(fs_no > ARRAY_SIZE(mpc8xx_enet_pdata)) {
+		printk(KERN_ERR"No network-suitable #%d device on bus", fs_no);
+		return;
+	}
+
+
+	fpi = &mpc8xx_enet_pdata[fs_no];
+	fpi->fs_no = fs_no;
+	pdev->dev.platform_data = fpi;
+
+	e = (unsigned char *)&bd->bi_enetaddr;
+	for (i = 0; i < 6; i++)
+		fpi->macaddr[i] = *e++;
+
+	fpi->macaddr[5] += ma_count++;
+}
+
+static void mpc866ads_fixup_fec_enet_pdata(struct platform_device *pdev,
+					   int idx)
+{
+	/* This is for FEC devices only */
+	if (!pdev || !pdev->name || (!strstr(pdev->name, "fsl-cpm-fec")))
+		return;
+	mpc866ads_fixup_enet_pdata(pdev, fsid_fec1 + pdev->id - 1);
+}
+
+static void mpc866ads_fixup_scc_enet_pdata(struct platform_device *pdev,
+					   int idx)
+{
+	/* This is for SCC devices only */
+	if (!pdev || !pdev->name || (!strstr(pdev->name, "fsl-cpm-scc")))
+		return;
+
+	mpc866ads_fixup_enet_pdata(pdev, fsid_scc1 + pdev->id - 1);
+}
+
 static void __init mpc866ads_fixup_uart_pdata(struct platform_device *pdev,
                                               int idx)
 {
@@ -359,6 +339,9 @@ static int mpc866ads_platform_notify(str
 
 int __init mpc866ads_init(void)
 {
+	bd_t *bd = (bd_t *) __res;
+	struct fs_mii_fec_platform_info* fmpi;
+
 	printk(KERN_NOTICE "mpc866ads: Init\n");
 
 	platform_notify = mpc866ads_platform_notify;
@@ -366,11 +349,20 @@ int __init mpc866ads_init(void)
 	ppc_sys_device_initfunc();
 	ppc_sys_device_disable_all();
 
-#ifdef MPC8xx_SECOND_ETH_SCC1
+#ifdef CONFIG_MPC8xx_SECOND_ETH_SCC1
 	ppc_sys_device_enable(MPC8xx_CPM_SCC1);
 #endif
 	ppc_sys_device_enable(MPC8xx_CPM_FEC1);
 
+	ppc_sys_device_enable(MPC8xx_MDIO_FEC);
+
+	fmpi = ppc_sys_platform_devices[MPC8xx_MDIO_FEC].dev.platform_data =
+		&mpc8xx_mdio_fec_pdata;
+
+	fmpi->mii_speed = ((((bd->bi_intfreq + 4999999) / 2500000) / 2) & 0x3F) << 1;
+	/* No PHY interrupt line here */
+	fmpi->irq[0xf] = -1;
+
 /* Since either of the uarts could be used as console, they need to ready */
 #ifdef CONFIG_SERIAL_CPM_SMC1
 	ppc_sys_device_enable(MPC8xx_CPM_SMC1);
@@ -381,6 +373,14 @@ #ifdef CONFIG_SERIAL_CPM_SMC
 	ppc_sys_device_enable(MPC8xx_CPM_SMC2);
 	ppc_sys_device_setfunc(MPC8xx_CPM_SMC2, PPC_SYS_FUNC_UART);
 #endif
+	ppc_sys_device_enable(MPC8xx_MDIO_FEC);
+
+	fmpi = ppc_sys_platform_devices[MPC8xx_MDIO_FEC].dev.platform_data =
+		&mpc8xx_mdio_fec_pdata;
+
+	fmpi->mii_speed = ((((bd->bi_intfreq + 4999999) / 2500000) / 2) & 0x3F) << 1;
+	/* No PHY interrupt line here */
+	fmpi->irq[0xf] = -1;
 
 	return 0;
 }
diff --git a/arch/ppc/platforms/mpc885ads_setup.c b/arch/ppc/platforms/mpc885ads_setup.c
index c1fc4a1..5dfa4e6 100644
--- a/arch/ppc/platforms/mpc885ads_setup.c
+++ b/arch/ppc/platforms/mpc885ads_setup.c
@@ -38,7 +38,10 @@ extern unsigned char __res[];
 static void setup_smc1_ioports(void);
 static void setup_smc2_ioports(void);
 
-static void __init mpc885ads_scc_phy_init(char);
+static struct fs_mii_fec_platform_info	mpc8xx_mdio_fec_pdata;
+static void setup_fec1_ioports(void);
+static void setup_fec2_ioports(void);
+static void setup_scc3_ioports(void);
 
 static struct fs_uart_platform_info mpc885_uart_pdata[] = {
 	[fsid_smc1_uart] = {
@@ -61,23 +64,8 @@ static struct fs_uart_platform_info mpc8
  	},
 };
 
-static struct fs_mii_bus_info fec_mii_bus_info = {
-	.method = fsmii_fec,
-	.id = 0,
-};
-
-static struct fs_mii_bus_info scc_mii_bus_info = {
-#ifdef CONFIG_SCC_ENET_8xx_FIXED
-	.method = fsmii_fixed,
-#else
-	.method = fsmii_fec,
-#endif
-
-	.id = 0,
-};
-
-static struct fs_platform_info mpc8xx_fec_pdata[] = {
-	{
+static struct fs_platform_info mpc8xx_enet_pdata[] = {
+	[fsid_fec1] = {
 	 .rx_ring = 128,
 	 .tx_ring = 16,
 	 .rx_copybreak = 240,
@@ -85,11 +73,12 @@ static struct fs_platform_info mpc8xx_fe
 	 .use_napi = 1,
 	 .napi_weight = 17,
 
-	 .phy_addr = 0,
-	 .phy_irq = SIU_IRQ7,
+	 .init_ioports = setup_fec1_ioports,
 
-	 .bus_info = &fec_mii_bus_info,
-	 }, {
+          .bus_id = "0:00",
+          .has_phy = 1,
+	 },
+	[fsid_fec2] = {
 	     .rx_ring = 128,
 	     .tx_ring = 16,
 	     .rx_copybreak = 240,
@@ -97,35 +86,32 @@ static struct fs_platform_info mpc8xx_fe
 	     .use_napi = 1,
 	     .napi_weight = 17,
 
-	     .phy_addr = 1,
-	     .phy_irq = SIU_IRQ7,
-
-	     .bus_info = &fec_mii_bus_info,
-	     }
-};
+	     .init_ioports = setup_fec2_ioports,
 
-static struct fs_platform_info mpc8xx_scc_pdata = {
-	.rx_ring = 64,
-	.tx_ring = 8,
-	.rx_copybreak = 240,
+ 	     .bus_id = "0:01",
+ 	     .has_phy = 1,
+	     },
+	[fsid_scc3] = {
+		.rx_ring = 64,
+		.tx_ring = 8,
+		.rx_copybreak = 240,
 
-	.use_napi = 1,
-	.napi_weight = 17,
+		.use_napi = 1,
+		.napi_weight = 17,
 
-	.phy_addr = 2,
-#ifdef CONFIG_MPC8xx_SCC_ENET_FIXED
-	.phy_irq = -1,
+		.init_ioports = setup_scc3_ioports,
+#ifdef CONFIG_FIXED_MII_10_FDX
+		.bus_id = "fixed@100:1",
 #else
-	.phy_irq = SIU_IRQ7,
-#endif
-
-	.bus_info = &scc_mii_bus_info,
+		.bus_id = "0:02",
+ #endif
+	},
 };
 
 void __init board_init(void)
 {
-	volatile cpm8xx_t *cp = cpmp;
-	unsigned int *bcsr_io;
+	cpm8xx_t *cp = cpmp;
+ 	unsigned int *bcsr_io;
 
 #ifdef CONFIG_FS_ENET
 	immap_t *immap = (immap_t *) IMAP_ADDR;
@@ -164,6 +150,14 @@ #ifdef CONFIG_FS_ENET
 	/* use MDC for MII (common) */
 	setbits16(&immap->im_ioport.iop_pdpar, 0x0080);
 	clrbits16(&immap->im_ioport.iop_pddir, 0x0080);
+	bcsr_io = ioremap(BCSR5, sizeof(unsigned long));
+	clrbits32(bcsr_io,BCSR5_MII1_EN);
+	clrbits32(bcsr_io,BCSR5_MII1_RST);
+#ifdef CONFIG_MPC8xx_SECOND_ETH_FEC2
+	clrbits32(bcsr_io,BCSR5_MII2_EN);
+	clrbits32(bcsr_io,BCSR5_MII2_RST);
+#endif
+	iounmap(bcsr_io);
 #endif
 }
 
@@ -194,8 +188,8 @@ static void setup_fec2_ioports(void)
 	/* configure FEC2 pins */
 	setbits32(&immap->im_cpm.cp_pepar, 0x0003fffc);
 	setbits32(&immap->im_cpm.cp_pedir, 0x0003fffc);
-	setbits32(&immap->im_cpm.cp_peso, 0x00037800);
 	clrbits32(&immap->im_cpm.cp_peso, 0x000087fc);
+	setbits32(&immap->im_cpm.cp_peso, 0x00037800);
 	clrbits32(&immap->im_cpm.cp_cptr, 0x00000080);
 }
 
@@ -213,6 +207,8 @@ static void setup_scc3_ioports(void)
 
 	/* Enable the PHY.
 	 */
+	clrbits32(bcsr_io+4, BCSR4_ETH10_RST);
+	udelay(1000);
 	setbits32(bcsr_io+4, BCSR4_ETH10_RST);
 	/* Configure port A pins for Txd and Rxd.
 	 */
@@ -254,37 +250,38 @@ static void setup_scc3_ioports(void)
 	clrbits32(&immap->im_cpm.cp_pedir, PE_ENET_TENA);
 	setbits32(&immap->im_cpm.cp_peso, PE_ENET_TENA);
 
-	setbits32(bcsr_io+1, BCSR1_ETHEN);
+	setbits32(bcsr_io+4, BCSR1_ETHEN);
 	iounmap(bcsr_io);
 }
 
+static int mac_count = 0;
+
 static void mpc885ads_fixup_enet_pdata(struct platform_device *pdev, int fs_no)
 {
-	struct fs_platform_info *fpi = pdev->dev.platform_data;
-
-	volatile cpm8xx_t *cp;
+ 	struct fs_platform_info *fpi;
 	bd_t *bd = (bd_t *) __res;
 	char *e;
 	int i;
 
-	/* Get pointer to Communication Processor */
-	cp = cpmp;
+	if(fs_no > ARRAY_SIZE(mpc8xx_enet_pdata)) {
+		printk(KERN_ERR"No network-suitable #%d device on bus", fs_no);
+		return;
+	}
+
+	fpi = &mpc8xx_enet_pdata[fs_no];
+
 	switch (fs_no) {
 	case fsid_fec1:
-		fpi = &mpc8xx_fec_pdata[0];
 		fpi->init_ioports = &setup_fec1_ioports;
 		break;
 	case fsid_fec2:
-		fpi = &mpc8xx_fec_pdata[1];
 		fpi->init_ioports = &setup_fec2_ioports;
 		break;
 	case fsid_scc3:
-		fpi = &mpc8xx_scc_pdata;
 		fpi->init_ioports = &setup_scc3_ioports;
-		mpc885ads_scc_phy_init(fpi->phy_addr);
 		break;
 	default:
-    	        printk(KERN_WARNING"Device %s is not supported!\n", pdev->name);
+    	        printk(KERN_WARNING "Device %s is not supported!\n", pdev->name);
 	        return;
 	}
 
@@ -295,7 +292,7 @@ static void mpc885ads_fixup_enet_pdata(s
 	for (i = 0; i < 6; i++)
 		fpi->macaddr[i] = *e++;
 
-	fpi->macaddr[5 - pdev->id]++;
+	fpi->macaddr[5] += mac_count++;
 
 }
 
@@ -318,58 +315,6 @@ static void __init mpc885ads_fixup_scc_e
 	mpc885ads_fixup_enet_pdata(pdev, fsid_scc1 + pdev->id - 1);
 }
 
-/* SCC ethernet controller does not have MII management channel. FEC1 MII
- * channel is used to communicate with the 10Mbit PHY.
- */
-
-#define MII_ECNTRL_PINMUX        0x4
-#define FEC_ECNTRL_PINMUX        0x00000004
-#define FEC_RCNTRL_MII_MODE        0x00000004
-
-/* Make MII read/write commands.
- */
-#define mk_mii_write(REG, VAL, PHY_ADDR)    (0x50020000 | (((REG) & 0x1f) << 18) | \
-                ((VAL) & 0xffff) | ((PHY_ADDR) << 23))
-
-static void mpc885ads_scc_phy_init(char phy_addr)
-{
-	volatile immap_t *immap;
-	volatile fec_t *fecp;
-	bd_t *bd;
-
-	bd = (bd_t *) __res;
-	immap = (immap_t *) IMAP_ADDR;	/* pointer to internal registers */
-	fecp = &(immap->im_cpm.cp_fec);
-
-	/* Enable MII pins of the FEC1
-	 */
-	setbits16(&immap->im_ioport.iop_pdpar, 0x0080);
-	clrbits16(&immap->im_ioport.iop_pddir, 0x0080);
-	/* Set MII speed to 2.5 MHz
-	 */
-	out_be32(&fecp->fec_mii_speed,
-		 ((((bd->bi_intfreq + 4999999) / 2500000) / 2) & 0x3F) << 1);
-
-	/* Enable FEC pin MUX
-	 */
-	setbits32(&fecp->fec_ecntrl, MII_ECNTRL_PINMUX);
-	setbits32(&fecp->fec_r_cntrl, FEC_RCNTRL_MII_MODE);
-
-	out_be32(&fecp->fec_mii_data,
-		 mk_mii_write(MII_BMCR, BMCR_ISOLATE, phy_addr));
-	udelay(100);
-	out_be32(&fecp->fec_mii_data,
-		 mk_mii_write(MII_ADVERTISE,
-			      ADVERTISE_10HALF | ADVERTISE_CSMA, phy_addr));
-	udelay(100);
-
-	/* Disable FEC MII settings
-	 */
-	clrbits32(&fecp->fec_ecntrl, MII_ECNTRL_PINMUX);
-	clrbits32(&fecp->fec_r_cntrl, FEC_RCNTRL_MII_MODE);
-	out_be32(&fecp->fec_mii_speed, 0);
-}
-
 static void setup_smc1_ioports(void)
 {
         immap_t *immap = (immap_t *) IMAP_ADDR;
@@ -462,6 +407,9 @@ static int mpc885ads_platform_notify(str
 
 int __init mpc885ads_init(void)
 {
+	struct fs_mii_fec_platform_info* fmpi;
+	bd_t *bd = (bd_t *) __res;
+
 	printk(KERN_NOTICE "mpc885ads: Init\n");
 
 	platform_notify = mpc885ads_platform_notify;
@@ -471,8 +419,17 @@ int __init mpc885ads_init(void)
 
 	ppc_sys_device_enable(MPC8xx_CPM_FEC1);
 
+	ppc_sys_device_enable(MPC8xx_MDIO_FEC);
+	fmpi = ppc_sys_platform_devices[MPC8xx_MDIO_FEC].dev.platform_data =
+		&mpc8xx_mdio_fec_pdata;
+
+	fmpi->mii_speed = ((((bd->bi_intfreq + 4999999) / 2500000) / 2) & 0x3F) << 1;
+
+	/* No PHY interrupt line here */
+	fmpi->irq[0xf] = SIU_IRQ7;
+
 #ifdef CONFIG_MPC8xx_SECOND_ETH_SCC3
-	ppc_sys_device_enable(MPC8xx_CPM_SCC1);
+	ppc_sys_device_enable(MPC8xx_CPM_SCC3);
 
 #endif
 #ifdef CONFIG_MPC8xx_SECOND_ETH_FEC2
diff --git a/arch/ppc/platforms/pq2ads_pd.h b/arch/ppc/platforms/pq2ads_pd.h
index 8f14a43..672483d 100644
--- a/arch/ppc/platforms/pq2ads_pd.h
+++ b/arch/ppc/platforms/pq2ads_pd.h
@@ -29,86 +29,4 @@ #define F2_TXCLK	16
 #define F3_RXCLK	13
 #define F3_TXCLK	14
 
-/* Automatically generates register configurations */
-#define PC_CLK(x)	((uint)(1<<(x-1)))	/* FCC CLK I/O ports */
-
-#define CMXFCR_RF1CS(x)	((uint)((x-5)<<27))	/* FCC1 Receive Clock Source */
-#define CMXFCR_TF1CS(x)	((uint)((x-5)<<24))	/* FCC1 Transmit Clock Source */
-#define CMXFCR_RF2CS(x)	((uint)((x-9)<<19))	/* FCC2 Receive Clock Source */
-#define CMXFCR_TF2CS(x) ((uint)((x-9)<<16))	/* FCC2 Transmit Clock Source */
-#define CMXFCR_RF3CS(x)	((uint)((x-9)<<11))	/* FCC3 Receive Clock Source */
-#define CMXFCR_TF3CS(x) ((uint)((x-9)<<8))	/* FCC3 Transmit Clock Source */
-
-#define PC_F1RXCLK	PC_CLK(F1_RXCLK)
-#define PC_F1TXCLK	PC_CLK(F1_TXCLK)
-#define CMX1_CLK_ROUTE	(CMXFCR_RF1CS(F1_RXCLK) | CMXFCR_TF1CS(F1_TXCLK))
-#define CMX1_CLK_MASK	((uint)0xff000000)
-
-#define PC_F2RXCLK	PC_CLK(F2_RXCLK)
-#define PC_F2TXCLK	PC_CLK(F2_TXCLK)
-#define CMX2_CLK_ROUTE	(CMXFCR_RF2CS(F2_RXCLK) | CMXFCR_TF2CS(F2_TXCLK))
-#define CMX2_CLK_MASK	((uint)0x00ff0000)
-
-#define PC_F3RXCLK	PC_CLK(F3_RXCLK)
-#define PC_F3TXCLK	PC_CLK(F3_TXCLK)
-#define CMX3_CLK_ROUTE	(CMXFCR_RF3CS(F3_RXCLK) | CMXFCR_TF3CS(F3_TXCLK))
-#define CMX3_CLK_MASK	((uint)0x0000ff00)
-
-/* I/O Pin assignment for FCC1.  I don't yet know the best way to do this,
- * but there is little variation among the choices.
- */
-#define PA1_COL		0x00000001U
-#define PA1_CRS		0x00000002U
-#define PA1_TXER	0x00000004U
-#define PA1_TXEN	0x00000008U
-#define PA1_RXDV	0x00000010U
-#define PA1_RXER	0x00000020U
-#define PA1_TXDAT	0x00003c00U
-#define PA1_RXDAT	0x0003c000U
-#define PA1_PSORA0	(PA1_RXDAT | PA1_TXDAT)
-#define PA1_PSORA1	(PA1_COL | PA1_CRS | PA1_TXER | PA1_TXEN | \
-		PA1_RXDV | PA1_RXER)
-#define PA1_DIRA0	(PA1_RXDAT | PA1_CRS | PA1_COL | PA1_RXER | PA1_RXDV)
-#define PA1_DIRA1	(PA1_TXDAT | PA1_TXEN | PA1_TXER)
-
-
-/* I/O Pin assignment for FCC2.  I don't yet know the best way to do this,
- * but there is little variation among the choices.
- */
-#define PB2_TXER	0x00000001U
-#define PB2_RXDV	0x00000002U
-#define PB2_TXEN	0x00000004U
-#define PB2_RXER	0x00000008U
-#define PB2_COL		0x00000010U
-#define PB2_CRS		0x00000020U
-#define PB2_TXDAT	0x000003c0U
-#define PB2_RXDAT	0x00003c00U
-#define PB2_PSORB0	(PB2_RXDAT | PB2_TXDAT | PB2_CRS | PB2_COL | \
-		PB2_RXER | PB2_RXDV | PB2_TXER)
-#define PB2_PSORB1	(PB2_TXEN)
-#define PB2_DIRB0	(PB2_RXDAT | PB2_CRS | PB2_COL | PB2_RXER | PB2_RXDV)
-#define PB2_DIRB1	(PB2_TXDAT | PB2_TXEN | PB2_TXER)
-
-
-/* I/O Pin assignment for FCC3.  I don't yet know the best way to do this,
- * but there is little variation among the choices.
- */
-#define PB3_RXDV	0x00004000U
-#define PB3_RXER	0x00008000U
-#define PB3_TXER	0x00010000U
-#define PB3_TXEN	0x00020000U
-#define PB3_COL		0x00040000U
-#define PB3_CRS		0x00080000U
-#define PB3_TXDAT	0x0f000000U
-#define PB3_RXDAT	0x00f00000U
-#define PB3_PSORB0	(PB3_RXDAT | PB3_TXDAT | PB3_CRS | PB3_COL | \
-		PB3_RXER | PB3_RXDV | PB3_TXER | PB3_TXEN)
-#define PB3_PSORB1	0
-#define PB3_DIRB0	(PB3_RXDAT | PB3_CRS | PB3_COL | PB3_RXER | PB3_RXDV)
-#define PB3_DIRB1	(PB3_TXDAT | PB3_TXEN | PB3_TXER)
-
-#define FCC_MEM_OFFSET(x) (CPM_FCC_SPECIAL_BASE + (x*128))
-#define FCC1_MEM_OFFSET FCC_MEM_OFFSET(0)
-#define FCC2_MEM_OFFSET FCC_MEM_OFFSET(1)
-
 #endif
diff --git a/arch/ppc/syslib/mpc85xx_devices.c b/arch/ppc/syslib/mpc85xx_devices.c
index 7735336..325136e 100644
--- a/arch/ppc/syslib/mpc85xx_devices.c
+++ b/arch/ppc/syslib/mpc85xx_devices.c
@@ -16,9 +16,11 @@ #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/serial_8250.h>
 #include <linux/fsl_devices.h>
+#include <linux/fs_enet_pd.h>
 #include <asm/mpc85xx.h>
 #include <asm/irq.h>
 #include <asm/ppc_sys.h>
+#include <asm/cpm2.h>
 
 /* We use offsets for IORESOURCE_MEM since we do not know at compile time
  * what CCSRBAR is, will get fixed up by mach_mpc85xx_fixup
@@ -82,6 +84,60 @@ static struct fsl_i2c_platform_data mpc8
 	.device_flags = FSL_I2C_DEV_SEPARATE_DFSRR,
 };
 
+static struct fs_platform_info mpc85xx_fcc1_pdata = {
+	.fs_no          = fsid_fcc1,
+	.cp_page        = CPM_CR_FCC1_PAGE,
+	.cp_block       = CPM_CR_FCC1_SBLOCK,
+
+	.rx_ring        = 32,
+	.tx_ring        = 32,
+	.rx_copybreak   = 240,
+	.use_napi       = 0,
+	.napi_weight    = 17,
+
+	.clk_mask	= CMX1_CLK_MASK,
+	.clk_route	= CMX1_CLK_ROUTE,
+	.clk_trx	= (PC_F1RXCLK | PC_F1TXCLK),
+
+	.mem_offset     = FCC1_MEM_OFFSET,
+};
+
+static struct fs_platform_info mpc85xx_fcc2_pdata = {
+	.fs_no          = fsid_fcc2,
+	.cp_page        = CPM_CR_FCC2_PAGE,
+	.cp_block       = CPM_CR_FCC2_SBLOCK,
+
+	.rx_ring        = 32,
+	.tx_ring        = 32,
+	.rx_copybreak   = 240,
+	.use_napi       = 0,
+	.napi_weight    = 17,
+
+	.clk_mask	= CMX2_CLK_MASK,
+	.clk_route	= CMX2_CLK_ROUTE,
+	.clk_trx	= (PC_F2RXCLK | PC_F2TXCLK),
+
+	.mem_offset     = FCC2_MEM_OFFSET,
+};
+
+static struct fs_platform_info mpc85xx_fcc3_pdata = {
+	.fs_no          = fsid_fcc3,
+	.cp_page        = CPM_CR_FCC3_PAGE,
+	.cp_block       = CPM_CR_FCC3_SBLOCK,
+
+	.rx_ring        = 32,
+	.tx_ring        = 32,
+	.rx_copybreak   = 240,
+	.use_napi       = 0,
+	.napi_weight    = 17,
+
+	.clk_mask	= CMX3_CLK_MASK,
+	.clk_route	= CMX3_CLK_ROUTE,
+	.clk_trx	= (PC_F3RXCLK | PC_F3TXCLK),
+
+	.mem_offset     = FCC3_MEM_OFFSET,
+};
+
 static struct plat_serial8250_port serial_platform_data[] = {
 	[0] = {
 		.mapbase	= 0x4500,
@@ -318,19 +374,28 @@ struct platform_device ppc_sys_platform_
 	[MPC85xx_CPM_FCC1] = {
 		.name = "fsl-cpm-fcc",
 		.id	= 1,
-		.num_resources	 = 3,
+		.num_resources	 = 4,
+		.dev.platform_data = &mpc85xx_fcc1_pdata,
 		.resource = (struct resource[]) {
 			{
+				.name	= "fcc_regs",
 				.start	= 0x91300,
 				.end	= 0x9131F,
 				.flags	= IORESOURCE_MEM,
 			},
 			{
+				.name   = "fcc_regs_c",
 				.start	= 0x91380,
 				.end	= 0x9139F,
 				.flags	= IORESOURCE_MEM,
 			},
 			{
+				.name	= "fcc_pram",
+				.start	= 0x88400,
+				.end	= 0x884ff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
 				.start	= SIU_INT_FCC1,
 				.end	= SIU_INT_FCC1,
 				.flags	= IORESOURCE_IRQ,
@@ -340,19 +405,28 @@ struct platform_device ppc_sys_platform_
 	[MPC85xx_CPM_FCC2] = {
 		.name = "fsl-cpm-fcc",
 		.id	= 2,
-		.num_resources	 = 3,
+		.num_resources	 = 4,
+		.dev.platform_data = &mpc85xx_fcc2_pdata,
 		.resource = (struct resource[]) {
 			{
+				.name	= "fcc_regs",
 				.start	= 0x91320,
 				.end	= 0x9133F,
 				.flags	= IORESOURCE_MEM,
 			},
 			{
+				.name   = "fcc_regs_c",
 				.start	= 0x913A0,
 				.end	= 0x913CF,
 				.flags	= IORESOURCE_MEM,
 			},
 			{
+				.name	= "fcc_pram",
+				.start	= 0x88500,
+				.end	= 0x885ff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
 				.start	= SIU_INT_FCC2,
 				.end	= SIU_INT_FCC2,
 				.flags	= IORESOURCE_IRQ,
@@ -362,19 +436,28 @@ struct platform_device ppc_sys_platform_
 	[MPC85xx_CPM_FCC3] = {
 		.name = "fsl-cpm-fcc",
 		.id	= 3,
-		.num_resources	 = 3,
+		.num_resources	 = 4,
+		.dev.platform_data = &mpc85xx_fcc3_pdata,
 		.resource = (struct resource[]) {
 			{
+				.name	= "fcc_regs",
 				.start	= 0x91340,
 				.end	= 0x9135F,
 				.flags	= IORESOURCE_MEM,
 			},
 			{
+				.name   = "fcc_regs_c",
 				.start	= 0x913D0,
 				.end	= 0x913FF,
 				.flags	= IORESOURCE_MEM,
 			},
 			{
+				.name	= "fcc_pram",
+				.start	= 0x88600,
+				.end	= 0x886ff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
 				.start	= SIU_INT_FCC3,
 				.end	= SIU_INT_FCC3,
 				.flags	= IORESOURCE_IRQ,
diff --git a/arch/ppc/syslib/mpc8xx_devices.c b/arch/ppc/syslib/mpc8xx_devices.c
index 6f53638..cf5ab47 100644
--- a/arch/ppc/syslib/mpc8xx_devices.c
+++ b/arch/ppc/syslib/mpc8xx_devices.c
@@ -218,6 +218,14 @@ struct platform_device ppc_sys_platform_
 			},
 		},
 	},
+
+        [MPC8xx_MDIO_FEC] = {
+                .name = "fsl-cpm-fec-mdio",
+                .id = 0,
+                .num_resources = 0,
+
+        },
+
 };
 
 static int __init mach_mpc8xx_fixup(struct platform_device *pdev)
diff --git a/arch/ppc/syslib/mpc8xx_sys.c b/arch/ppc/syslib/mpc8xx_sys.c
index eee2132..18ba1d7 100644
--- a/arch/ppc/syslib/mpc8xx_sys.c
+++ b/arch/ppc/syslib/mpc8xx_sys.c
@@ -22,7 +22,7 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 		.ppc_sys_name	= "MPC86X",
 		.mask 		= 0xFFFFFFFF,
 		.value 		= 0x00000000,
-		.num_devices	= 7,
+		.num_devices	= 8,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC8xx_CPM_FEC1,
@@ -32,13 +32,14 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 			MPC8xx_CPM_SCC4,
 			MPC8xx_CPM_SMC1,
 			MPC8xx_CPM_SMC2,
+			MPC8xx_MDIO_FEC,
 		},
 	},
 	{
 		.ppc_sys_name	= "MPC885",
 		.mask 		= 0xFFFFFFFF,
 		.value 		= 0x00000000,
-		.num_devices	= 8,
+		.num_devices	= 9,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC8xx_CPM_FEC1,
@@ -49,6 +50,7 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 			MPC8xx_CPM_SCC4,
 			MPC8xx_CPM_SMC1,
 			MPC8xx_CPM_SMC2,
+			MPC8xx_MDIO_FEC,
 		},
 	},
 	{	/* default match */
diff --git a/arch/ppc/syslib/pq2_devices.c b/arch/ppc/syslib/pq2_devices.c
index 8692d00..fefbc21 100644
--- a/arch/ppc/syslib/pq2_devices.c
+++ b/arch/ppc/syslib/pq2_devices.c
@@ -369,6 +369,11 @@ struct platform_device ppc_sys_platform_
 			},
 		},
 	},
+	[MPC82xx_MDIO_BB] = {
+		.name = "fsl-bb-mdio",
+		.id = 0,
+		.num_resources = 0,
+	},
 };
 
 static int __init mach_mpc82xx_fixup(struct platform_device *pdev)
diff --git a/arch/ppc/syslib/pq2_sys.c b/arch/ppc/syslib/pq2_sys.c
index fee8948..f52600c 100644
--- a/arch/ppc/syslib/pq2_sys.c
+++ b/arch/ppc/syslib/pq2_sys.c
@@ -139,13 +139,14 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 		.ppc_sys_name	= "8272",
 		.mask		= 0x0000ff00,
 		.value		= 0x00000c00,
-		.num_devices	= 12,
+		.num_devices	= 13,
 		.device_list = (enum ppc_sys_devices[])
 		{
 			MPC82xx_CPM_FCC1, MPC82xx_CPM_FCC2, MPC82xx_CPM_SCC1,
 			MPC82xx_CPM_SCC2, MPC82xx_CPM_SCC3, MPC82xx_CPM_SCC4,
 			MPC82xx_CPM_SMC1, MPC82xx_CPM_SMC2, MPC82xx_CPM_SPI,
 			MPC82xx_CPM_I2C, MPC82xx_CPM_USB, MPC82xx_SEC1,
+			MPC82xx_MDIO_BB,
 		},
 	},
 	/* below is a list of the 8280 family of processors */
diff --git a/include/asm-ppc/cpm2.h b/include/asm-ppc/cpm2.h
index c70344b..f6a7ff0 100644
--- a/include/asm-ppc/cpm2.h
+++ b/include/asm-ppc/cpm2.h
@@ -1093,5 +1093,100 @@ #endif
 
 #define FCC_PSMR_RMII	((uint)0x00020000)	/* Use RMII interface */
 
+/* FCC iop & clock configuration. BSP code is responsible to define Fx_RXCLK & Fx_TXCLK
+ * in order to use clock-computing stuff below for the FCC x
+ */
+
+/* Automatically generates register configurations */
+#define PC_CLK(x)	((uint)(1<<(x-1)))	/* FCC CLK I/O ports */
+
+#define CMXFCR_RF1CS(x)	((uint)((x-5)<<27))	/* FCC1 Receive Clock Source */
+#define CMXFCR_TF1CS(x)	((uint)((x-5)<<24))	/* FCC1 Transmit Clock Source */
+#define CMXFCR_RF2CS(x)	((uint)((x-9)<<19))	/* FCC2 Receive Clock Source */
+#define CMXFCR_TF2CS(x) ((uint)((x-9)<<16))	/* FCC2 Transmit Clock Source */
+#define CMXFCR_RF3CS(x)	((uint)((x-9)<<11))	/* FCC3 Receive Clock Source */
+#define CMXFCR_TF3CS(x) ((uint)((x-9)<<8))	/* FCC3 Transmit Clock Source */
+
+#define PC_F1RXCLK	PC_CLK(F1_RXCLK)
+#define PC_F1TXCLK	PC_CLK(F1_TXCLK)
+#define CMX1_CLK_ROUTE	(CMXFCR_RF1CS(F1_RXCLK) | CMXFCR_TF1CS(F1_TXCLK))
+#define CMX1_CLK_MASK	((uint)0xff000000)
+
+#define PC_F2RXCLK	PC_CLK(F2_RXCLK)
+#define PC_F2TXCLK	PC_CLK(F2_TXCLK)
+#define CMX2_CLK_ROUTE	(CMXFCR_RF2CS(F2_RXCLK) | CMXFCR_TF2CS(F2_TXCLK))
+#define CMX2_CLK_MASK	((uint)0x00ff0000)
+
+#define PC_F3RXCLK	PC_CLK(F3_RXCLK)
+#define PC_F3TXCLK	PC_CLK(F3_TXCLK)
+#define CMX3_CLK_ROUTE	(CMXFCR_RF3CS(F3_RXCLK) | CMXFCR_TF3CS(F3_TXCLK))
+#define CMX3_CLK_MASK	((uint)0x0000ff00)
+
+#define CPMUX_CLK_MASK (CMX3_CLK_MASK | CMX2_CLK_MASK)
+#define CPMUX_CLK_ROUTE (CMX3_CLK_ROUTE | CMX2_CLK_ROUTE)
+
+#define CLK_TRX (PC_F3TXCLK | PC_F3RXCLK | PC_F2TXCLK | PC_F2RXCLK)
+
+/* I/O Pin assignment for FCC1.  I don't yet know the best way to do this,
+ * but there is little variation among the choices.
+ */
+#define PA1_COL		0x00000001U
+#define PA1_CRS		0x00000002U
+#define PA1_TXER	0x00000004U
+#define PA1_TXEN	0x00000008U
+#define PA1_RXDV	0x00000010U
+#define PA1_RXER	0x00000020U
+#define PA1_TXDAT	0x00003c00U
+#define PA1_RXDAT	0x0003c000U
+#define PA1_PSORA0	(PA1_RXDAT | PA1_TXDAT)
+#define PA1_PSORA1	(PA1_COL | PA1_CRS | PA1_TXER | PA1_TXEN | \
+		PA1_RXDV | PA1_RXER)
+#define PA1_DIRA0	(PA1_RXDAT | PA1_CRS | PA1_COL | PA1_RXER | PA1_RXDV)
+#define PA1_DIRA1	(PA1_TXDAT | PA1_TXEN | PA1_TXER)
+
+
+/* I/O Pin assignment for FCC2.  I don't yet know the best way to do this,
+ * but there is little variation among the choices.
+ */
+#define PB2_TXER	0x00000001U
+#define PB2_RXDV	0x00000002U
+#define PB2_TXEN	0x00000004U
+#define PB2_RXER	0x00000008U
+#define PB2_COL		0x00000010U
+#define PB2_CRS		0x00000020U
+#define PB2_TXDAT	0x000003c0U
+#define PB2_RXDAT	0x00003c00U
+#define PB2_PSORB0	(PB2_RXDAT | PB2_TXDAT | PB2_CRS | PB2_COL | \
+		PB2_RXER | PB2_RXDV | PB2_TXER)
+#define PB2_PSORB1	(PB2_TXEN)
+#define PB2_DIRB0	(PB2_RXDAT | PB2_CRS | PB2_COL | PB2_RXER | PB2_RXDV)
+#define PB2_DIRB1	(PB2_TXDAT | PB2_TXEN | PB2_TXER)
+
+
+/* I/O Pin assignment for FCC3.  I don't yet know the best way to do this,
+ * but there is little variation among the choices.
+ */
+#define PB3_RXDV	0x00004000U
+#define PB3_RXER	0x00008000U
+#define PB3_TXER	0x00010000U
+#define PB3_TXEN	0x00020000U
+#define PB3_COL		0x00040000U
+#define PB3_CRS		0x00080000U
+#define PB3_TXDAT	0x0f000000U
+#define PC3_TXDAT	0x00000010U
+#define PB3_RXDAT	0x00f00000U
+#define PB3_PSORB0	(PB3_RXDAT | PB3_TXDAT | PB3_CRS | PB3_COL | \
+		PB3_RXER | PB3_RXDV | PB3_TXER | PB3_TXEN)
+#define PB3_PSORB1	0
+#define PB3_DIRB0	(PB3_RXDAT | PB3_CRS | PB3_COL | PB3_RXER | PB3_RXDV)
+#define PB3_DIRB1	(PB3_TXDAT | PB3_TXEN | PB3_TXER)
+#define PC3_DIRC1	(PC3_TXDAT)
+
+/* Handy macro to specify mem for FCCs*/
+#define FCC_MEM_OFFSET(x) (CPM_FCC_SPECIAL_BASE + (x*128))
+#define FCC1_MEM_OFFSET FCC_MEM_OFFSET(0)
+#define FCC2_MEM_OFFSET FCC_MEM_OFFSET(1)
+#define FCC2_MEM_OFFSET FCC_MEM_OFFSET(2)
+
 #endif /* __CPM2__ */
 #endif /* __KERNEL__ */
diff --git a/include/asm-ppc/mpc8260.h b/include/asm-ppc/mpc8260.h
index 4b93481..23579d4 100644
--- a/include/asm-ppc/mpc8260.h
+++ b/include/asm-ppc/mpc8260.h
@@ -82,6 +82,7 @@ enum ppc_sys_devices {
 	MPC82xx_CPM_SMC2,
 	MPC82xx_CPM_USB,
 	MPC82xx_SEC1,
+	MPC82xx_MDIO_BB,
 	NUM_PPC_SYS_DEVS,
 };
 
diff --git a/include/asm-ppc/mpc8xx.h b/include/asm-ppc/mpc8xx.h
index adcce33..d3a2f2f 100644
--- a/include/asm-ppc/mpc8xx.h
+++ b/include/asm-ppc/mpc8xx.h
@@ -110,6 +110,7 @@ enum ppc_sys_devices {
 	MPC8xx_CPM_SMC1,
 	MPC8xx_CPM_SMC2,
 	MPC8xx_CPM_USB,
+	MPC8xx_MDIO_FEC,
 	NUM_PPC_SYS_DEVS,
 };
 
diff --git a/include/linux/fs_enet_pd.h b/include/linux/fs_enet_pd.h
index 783c476..74ed35a 100644
--- a/include/linux/fs_enet_pd.h
+++ b/include/linux/fs_enet_pd.h
@@ -69,34 +69,21 @@ enum fs_ioport {
 	fsiop_porte,
 };
 
-struct fs_mii_bus_info {
-	int method;		/* mii method                  */
-	int id;			/* the id of the mii_bus       */
-	int disable_aneg;	/* if the controller needs to negothiate speed & duplex */
-	int lpa; 		/* the default board-specific vallues will be applied otherwise */
-
-	union {
-		struct {
-			int duplex;
-			int speed;
-		} fixed;
-
-		struct {
-			/* nothing */
-		} fec;
-		
-		struct {
-			/* nothing */
-		} scc;
-
-		struct {
-			int mdio_port;	/* port & bit for MDIO */
-			int mdio_bit;
-			int mdc_port;	/* port & bit for MDC  */
-			int mdc_bit;
-			int delay;	/* delay in us         */
-		} bitbang;
-	} i;
+struct fs_mii_bit {
+	u32 offset;
+	u8 bit;
+	u8 polarity;
+};
+struct fs_mii_bb_platform_info {
+	struct fs_mii_bit 	mdio_dir;
+	struct fs_mii_bit 	mdio_dat;
+	struct fs_mii_bit	mdc_dat;
+	int mdio_port;	/* port & bit for MDIO */
+	int mdio_bit;
+	int mdc_port;	/* port & bit for MDC  */
+	int mdc_bit;
+	int delay;	/* delay in us         */
+	int irq[32]; 	/* irqs per phy's */
 };
 
 struct fs_platform_info {
@@ -119,6 +106,7 @@ struct fs_platform_info {
 	u32 device_flags;
 
 	int phy_addr;		/* the phy address (-1 no phy) */
+	const char*	bus_id;
 	int phy_irq;		/* the phy irq (if it exists)  */
 
 	const struct fs_mii_bus_info *bus_info;
@@ -130,6 +118,10 @@ struct fs_platform_info {
 	int napi_weight;	/* NAPI weight                 */
 
 	int use_rmii;		/* use RMII mode 	       */
+	int has_phy;            /* if the network is phy container as well...*/
+};
+struct fs_mii_fec_platform_info {
+	u32 irq[32];
+	u32 mii_speed;
 };
-
 #endif
