Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWFUQME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWFUQME (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 12:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWFUQMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 12:12:03 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:437 "EHLO vitb.dev.rtsoft.ru")
	by vger.kernel.org with ESMTP id S1750786AbWFUQL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 12:11:57 -0400
To: Jeff Garzik <jeff@garzik.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-embedded@ozlabs.org
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 2/3] FS_ENET: use PAL for mii management
Date: Wed, 21 Jun 2006 20:10:02 +0400
Message-Id: <20060621161002.4860.29042.stgit@vitb.ru.mvista.com>
In-Reply-To: <20060621160950.4860.92979.stgit@vitb.ru.mvista.com>
References: <20060621160950.4860.92979.stgit@vitb.ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch should update the fs_enet infrastructure to utilize
Phy Abstraction Layer subsystem. Inside there are generic driver rehaul,
board-specific portion to respect driver changes (for 8272ads and 866ads).

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 arch/ppc/platforms/mpc8272ads_setup.c |  154 ++++++----
 arch/ppc/platforms/mpc866ads_setup.c  |  192 ++++++------
 arch/ppc/platforms/mpc885ads_setup.c  |  179 ++++--------
 arch/ppc/syslib/mpc8xx_devices.c      |    8 +
 arch/ppc/syslib/mpc8xx_sys.c          |    6 
 arch/ppc/syslib/pq2_devices.c         |    5 
 arch/ppc/syslib/pq2_sys.c             |    3 
 drivers/net/fs_enet/Makefile          |    6 
 drivers/net/fs_enet/fec.h             |   42 +++
 drivers/net/fs_enet/fs_enet-main.c    |  207 ++++++++-----
 drivers/net/fs_enet/fs_enet-mii.c     |  507 ---------------------------------
 drivers/net/fs_enet/fs_enet.h         |   40 ++-
 drivers/net/fs_enet/mac-fcc.c         |   10 -
 drivers/net/fs_enet/mac-fec.c         |  132 +--------
 drivers/net/fs_enet/mac-scc.c         |    4 
 drivers/net/fs_enet/mii-bitbang.c     |  448 +++++++++++++++--------------
 drivers/net/fs_enet/mii-fec.c         |  243 ++++++++++++++++
 drivers/net/fs_enet/mii-fixed.c       |   92 ------
 include/asm-ppc/mpc8260.h             |    1 
 include/asm-ppc/mpc8xx.h              |    1 
 include/linux/fs_enet_pd.h            |   50 +--
 21 files changed, 982 insertions(+), 1348 deletions(-)

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
@@ -319,6 +334,7 @@ int __init mpc8272ads_init(void)
 	ppc_sys_device_enable(MPC82xx_CPM_SCC4);
 #endif
 
+	ppc_sys_device_enable(MPC82xx_MDIO_BB);
 
 	return 0;
 }
diff --git a/arch/ppc/platforms/mpc866ads_setup.c b/arch/ppc/platforms/mpc866ads_setup.c
index d919dab..ed71dd9 100644
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
@@ -43,49 +43,36 @@ static void setup_scc1_ioports(void);
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
-
-	 .use_napi = 1,
-	 .napi_weight = 17,
+static struct fs_mii_fec_platform_info mpc8xx_mdio_fec_pdata;
 
-	 .phy_addr = 15,
-	 .phy_irq = -1,
+static struct fs_platform_info mpc8xx_enet_pdata[] = {
+	[fsid_fec1] = {
+		.rx_ring = 128,
+		.tx_ring = 16,
+		.rx_copybreak = 240,
 
-	 .use_rmii = 0,
+		.use_napi = 1,
+		.napi_weight = 17,
 
-	 .bus_info = &fec_mii_bus_info,
-	 }
-};
+		.init_ioports = setup_fec1_ioports,
 
-static struct fs_platform_info mpc8xx_scc_pdata = {
-	.rx_ring = 64,
-	.tx_ring = 8,
-	.rx_copybreak = 240,
+		.bus_id = "0:0f",
+		.has_phy = 1,
+	},
+	[fsid_scc1] = {
+		.rx_ring = 64,
+		.tx_ring = 8,
+		.rx_copybreak = 240,
+		.use_napi = 1,
+		.napi_weight = 17,
 
-	.use_napi = 1,
-	.napi_weight = 17,
 
-	.phy_addr = -1,
-	.phy_irq = -1,
-
-	.bus_info = &scc_mii_bus_info,
+		.init_ioports = setup_scc1_ioports,
 
+		.bus_id = "fixed@100:1",
+	},
 };
 
 static struct fs_uart_platform_info mpc866_uart_pdata[] = {
@@ -208,63 +195,6 @@ static void setup_scc1_ioports(void)
 
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
@@ -316,6 +246,56 @@ static void setup_smc2_ioports(void)
 
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
@@ -360,6 +340,9 @@ static int mpc866ads_platform_notify(str
 
 int __init mpc866ads_init(void)
 {
+	bd_t *bd = (bd_t *) __res;
+	struct fs_mii_fec_platform_info* fmpi;
+
 	printk(KERN_NOTICE "mpc866ads: Init\n");
 
 	platform_notify = mpc866ads_platform_notify;
@@ -367,11 +350,20 @@ int __init mpc866ads_init(void)
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
@@ -382,6 +374,14 @@ int __init mpc866ads_init(void)
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
index 4b88679..97b3002 100644
--- a/arch/ppc/platforms/mpc885ads_setup.c
+++ b/arch/ppc/platforms/mpc885ads_setup.c
@@ -39,7 +39,10 @@ extern unsigned char __res[];
 static void setup_smc1_ioports(void);
 static void setup_smc2_ioports(void);
 
-static void __init mpc885ads_scc_phy_init(char);
+static struct fs_mii_fec_platform_info	mpc8xx_mdio_fec_pdata;
+static void setup_fec1_ioports(void);
+static void setup_fec2_ioports(void);
+static void setup_scc3_ioports(void);
 
 static struct fs_uart_platform_info mpc885_uart_pdata[] = {
 	[fsid_smc1_uart] = {
@@ -62,23 +65,8 @@ static struct fs_uart_platform_info mpc8
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
@@ -86,11 +74,12 @@ static struct fs_platform_info mpc8xx_fe
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
@@ -98,35 +87,32 @@ static struct fs_platform_info mpc8xx_fe
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
-
-	.use_napi = 1,
-	.napi_weight = 17,
-
-	.phy_addr = 2,
-#ifdef CONFIG_MPC8xx_SCC_ENET_FIXED
-	.phy_irq = -1,
+ 	     .bus_id = "0:01",
+ 	     .has_phy = 1,
+	     },
+	[fsid_scc3] = {
+		.rx_ring = 64,
+		.tx_ring = 8,
+		.rx_copybreak = 240,
+
+		.use_napi = 1,
+		.napi_weight = 17,
+
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
@@ -165,6 +151,14 @@ void __init board_init(void)
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
 
@@ -195,8 +189,8 @@ static void setup_fec2_ioports(void)
 	/* configure FEC2 pins */
 	setbits32(&immap->im_cpm.cp_pepar, 0x0003fffc);
 	setbits32(&immap->im_cpm.cp_pedir, 0x0003fffc);
-	setbits32(&immap->im_cpm.cp_peso, 0x00037800);
 	clrbits32(&immap->im_cpm.cp_peso, 0x000087fc);
+	setbits32(&immap->im_cpm.cp_peso, 0x00037800);
 	clrbits32(&immap->im_cpm.cp_cptr, 0x00000080);
 }
 
@@ -214,6 +208,8 @@ static void setup_scc3_ioports(void)
 
 	/* Enable the PHY.
 	 */
+	clrbits32(bcsr_io+4, BCSR4_ETH10_RST);
+	udelay(1000);
 	setbits32(bcsr_io+4, BCSR4_ETH10_RST);
 	/* Configure port A pins for Txd and Rxd.
 	 */
@@ -255,37 +251,38 @@ static void setup_scc3_ioports(void)
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
 
@@ -296,7 +293,7 @@ static void mpc885ads_fixup_enet_pdata(s
 	for (i = 0; i < 6; i++)
 		fpi->macaddr[i] = *e++;
 
-	fpi->macaddr[5 - pdev->id]++;
+	fpi->macaddr[5] += mac_count++;
 
 }
 
@@ -319,58 +316,6 @@ static void __init mpc885ads_fixup_scc_e
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
@@ -463,6 +408,9 @@ static int mpc885ads_platform_notify(str
 
 int __init mpc885ads_init(void)
 {
+	struct fs_mii_fec_platform_info* fmpi;
+	bd_t *bd = (bd_t *) __res;
+
 	printk(KERN_NOTICE "mpc885ads: Init\n");
 
 	platform_notify = mpc885ads_platform_notify;
@@ -472,8 +420,17 @@ int __init mpc885ads_init(void)
 
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
diff --git a/drivers/net/fs_enet/Makefile b/drivers/net/fs_enet/Makefile
index d6dd3f2..02d4dc1 100644
--- a/drivers/net/fs_enet/Makefile
+++ b/drivers/net/fs_enet/Makefile
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_FS_ENET) += fs_enet.o
 
-obj-$(CONFIG_8xx) += mac-fec.o mac-scc.o
-obj-$(CONFIG_8260) += mac-fcc.o
+obj-$(CONFIG_8xx) += mac-fec.o mac-scc.o mii-fec.o
+obj-$(CONFIG_CPM2) += mac-fcc.o mii-bitbang.o
 
-fs_enet-objs := fs_enet-main.o fs_enet-mii.o mii-bitbang.o mii-fixed.o
+fs_enet-objs := fs_enet-main.o
diff --git a/drivers/net/fs_enet/fec.h b/drivers/net/fs_enet/fec.h
new file mode 100644
index 0000000..e980527
--- /dev/null
+++ b/drivers/net/fs_enet/fec.h
@@ -0,0 +1,42 @@
+#ifndef FS_ENET_FEC_H
+#define FS_ENET_FEC_H
+
+/* CRC polynomium used by the FEC for the multicast group filtering */
+#define FEC_CRC_POLY   0x04C11DB7
+
+#define FEC_MAX_MULTICAST_ADDRS	64
+
+/* Interrupt events/masks.
+*/
+#define FEC_ENET_HBERR	0x80000000U	/* Heartbeat error          */
+#define FEC_ENET_BABR	0x40000000U	/* Babbling receiver        */
+#define FEC_ENET_BABT	0x20000000U	/* Babbling transmitter     */
+#define FEC_ENET_GRA	0x10000000U	/* Graceful stop complete   */
+#define FEC_ENET_TXF	0x08000000U	/* Full frame transmitted   */
+#define FEC_ENET_TXB	0x04000000U	/* A buffer was transmitted */
+#define FEC_ENET_RXF	0x02000000U	/* Full frame received      */
+#define FEC_ENET_RXB	0x01000000U	/* A buffer was received    */
+#define FEC_ENET_MII	0x00800000U	/* MII interrupt            */
+#define FEC_ENET_EBERR	0x00400000U	/* SDMA bus error           */
+
+#define FEC_ECNTRL_PINMUX	0x00000004
+#define FEC_ECNTRL_ETHER_EN	0x00000002
+#define FEC_ECNTRL_RESET	0x00000001
+
+#define FEC_RCNTRL_BC_REJ	0x00000010
+#define FEC_RCNTRL_PROM		0x00000008
+#define FEC_RCNTRL_MII_MODE	0x00000004
+#define FEC_RCNTRL_DRT		0x00000002
+#define FEC_RCNTRL_LOOP		0x00000001
+
+#define FEC_TCNTRL_FDEN		0x00000004
+#define FEC_TCNTRL_HBC		0x00000002
+#define FEC_TCNTRL_GTS		0x00000001
+
+
+
+/*
+ * Delay to wait for FEC reset command to complete (in us)
+ */
+#define FEC_RESET_DELAY		50
+#endif
diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
index 196298f..302ecaa 100644
--- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -38,6 +38,7 @@
 #include <linux/bitops.h>
 #include <linux/fs.h>
 #include <linux/platform_device.h>
+#include <linux/phy.h>
 
 #include <linux/vmalloc.h>
 #include <asm/pgtable.h>
@@ -683,35 +684,6 @@ static void fs_free_irq(struct net_devic
 	(*fep->ops->post_free_irq)(dev, irq);
 }
 
-/**********************************************************************************/
-
-/* This interrupt occurs when the PHY detects a link change. */
-static irqreturn_t
-fs_mii_link_interrupt(int irq, void *dev_id, struct pt_regs *regs)
-{
-	struct net_device *dev = dev_id;
-	struct fs_enet_private *fep;
-	const struct fs_platform_info *fpi;
-
-	fep = netdev_priv(dev);
-	fpi = fep->fpi;
-
-	/*
-	 * Acknowledge the interrupt if possible. If we have not
-	 * found the PHY yet we can't process or acknowledge the
-	 * interrupt now. Instead we ignore this interrupt for now,
-	 * which we can do since it is edge triggered. It will be
-	 * acknowledged later by fs_enet_open().
-	 */
-	if (!fep->phy)
-		return IRQ_NONE;
-
-	fs_mii_ack_int(dev);
-	fs_mii_link_status_change_check(dev, 0);
-
-	return IRQ_HANDLED;
-}
-
 static void fs_timeout(struct net_device *dev)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
@@ -723,10 +695,13 @@ static void fs_timeout(struct net_device
 	spin_lock_irqsave(&fep->lock, flags);
 
 	if (dev->flags & IFF_UP) {
+		phy_stop(fep->phydev);
 		(*fep->ops->stop)(dev);
 		(*fep->ops->restart)(dev);
+		phy_start(fep->phydev);
 	}
 
+	phy_start(fep->phydev);
 	wake = fep->tx_free && !(CBDR_SC(fep->cur_tx) & BD_ENET_TX_READY);
 	spin_unlock_irqrestore(&fep->lock, flags);
 
@@ -734,35 +709,112 @@ static void fs_timeout(struct net_device
 		netif_wake_queue(dev);
 }
 
+/*-----------------------------------------------------------------------------
+ *  generic link-change handler - should be sufficient for most cases
+ *-----------------------------------------------------------------------------*/
+static void generic_adjust_link(struct  net_device *dev)
+{
+       struct fs_enet_private *fep = netdev_priv(dev);
+       struct phy_device *phydev = fep->phydev;
+       int new_state = 0;
+
+       if (phydev->link) {
+
+               /* adjust to duplex mode */
+               if (phydev->duplex != fep->oldduplex){
+                       new_state = 1;
+                       fep->oldduplex = phydev->duplex;
+               }
+
+               if (phydev->speed != fep->oldspeed) {
+                       new_state = 1;
+                       fep->oldspeed = phydev->speed;
+               }
+
+               if (!fep->oldlink) {
+                       new_state = 1;
+                       fep->oldlink = 1;
+                       netif_schedule(dev);
+                       netif_carrier_on(dev);
+                       netif_start_queue(dev);
+               }
+
+               if (new_state)
+                       fep->ops->restart(dev);
+
+       } else if (fep->oldlink) {
+               new_state = 1;
+               fep->oldlink = 0;
+               fep->oldspeed = 0;
+               fep->oldduplex = -1;
+               netif_carrier_off(dev);
+               netif_stop_queue(dev);
+       }
+
+       if (new_state && netif_msg_link(fep))
+               phy_print_status(phydev);
+}
+
+
+static void fs_adjust_link(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&fep->lock, flags);
+
+	if(fep->ops->adjust_link)
+		fep->ops->adjust_link(dev);
+	else
+		generic_adjust_link(dev);
+
+	spin_unlock_irqrestore(&fep->lock, flags);
+}
+
+static int fs_init_phy(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	struct phy_device *phydev;
+
+	fep->oldlink = 0;
+	fep->oldspeed = 0;
+	fep->oldduplex = -1;
+	if(fep->fpi->bus_id)
+		phydev = phy_connect(dev, fep->fpi->bus_id, &fs_adjust_link, 0);
+	else {
+		printk("No phy bus ID specified in BSP code\n");
+		return -EINVAL;
+	}
+	if (IS_ERR(phydev)) {
+		printk(KERN_ERR "%s: Could not attach to PHY\n", dev->name);
+		return PTR_ERR(phydev);
+	}
+
+	fep->phydev = phydev;
+
+	return 0;
+}
+
+
 static int fs_enet_open(struct net_device *dev)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
-	const struct fs_platform_info *fpi = fep->fpi;
 	int r;
+	int err;
 
 	/* Install our interrupt handler. */
 	r = fs_request_irq(dev, fep->interrupt, "fs_enet-mac", fs_enet_interrupt);
 	if (r != 0) {
 		printk(KERN_ERR DRV_MODULE_NAME
-		       ": %s Could not allocate FEC IRQ!", dev->name);
+		       ": %s Could not allocate FS_ENET IRQ!", dev->name);
 		return -EINVAL;
 	}
 
-	/* Install our phy interrupt handler */
-	if (fpi->phy_irq != -1) {
+	err = fs_init_phy(dev);
+	if(err)
+		return err;
 
-		r = fs_request_irq(dev, fpi->phy_irq, "fs_enet-phy", fs_mii_link_interrupt);
-		if (r != 0) {
-			printk(KERN_ERR DRV_MODULE_NAME
-			       ": %s Could not allocate PHY IRQ!", dev->name);
-			fs_free_irq(dev, fep->interrupt);
-			return -EINVAL;
-		}
-	}
-
-	fs_mii_startup(dev);
-	netif_carrier_off(dev);
-	fs_mii_link_status_change_check(dev, 1);
+	phy_start(fep->phydev);
 
 	return 0;
 }
@@ -770,20 +822,19 @@ static int fs_enet_open(struct net_devic
 static int fs_enet_close(struct net_device *dev)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
-	const struct fs_platform_info *fpi = fep->fpi;
 	unsigned long flags;
 
 	netif_stop_queue(dev);
 	netif_carrier_off(dev);
-	fs_mii_shutdown(dev);
+	phy_stop(fep->phydev);
 
 	spin_lock_irqsave(&fep->lock, flags);
 	(*fep->ops->stop)(dev);
 	spin_unlock_irqrestore(&fep->lock, flags);
 
 	/* release any irqs */
-	if (fpi->phy_irq != -1)
-		fs_free_irq(dev, fpi->phy_irq);
+	phy_disconnect(fep->phydev);
+	fep->phydev = NULL;
 	fs_free_irq(dev, fep->interrupt);
 
 	return 0;
@@ -831,33 +882,19 @@ static void fs_get_regs(struct net_devic
 static int fs_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
-	unsigned long flags;
-	int rc;
-
-	spin_lock_irqsave(&fep->lock, flags);
-	rc = mii_ethtool_gset(&fep->mii_if, cmd);
-	spin_unlock_irqrestore(&fep->lock, flags);
-
-	return rc;
+	return phy_ethtool_gset(fep->phydev, cmd);
 }
 
 static int fs_set_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
-	unsigned long flags;
-	int rc;
-
-	spin_lock_irqsave(&fep->lock, flags);
-	rc = mii_ethtool_sset(&fep->mii_if, cmd);
-	spin_unlock_irqrestore(&fep->lock, flags);
-
-	return rc;
+	phy_ethtool_sset(fep->phydev, cmd);
+	return 0;
 }
 
 static int fs_nway_reset(struct net_device *dev)
 {
-	struct fs_enet_private *fep = netdev_priv(dev);
-	return mii_nway_restart(&fep->mii_if);
+	return 0;
 }
 
 static u32 fs_get_msglevel(struct net_device *dev)
@@ -899,7 +936,7 @@ static int fs_ioctl(struct net_device *d
 		return -EINVAL;
 
 	spin_lock_irqsave(&fep->lock, flags);
-	rc = generic_mii_ioctl(&fep->mii_if, mii, cmd, NULL);
+	rc = phy_mii_ioctl(fep->phydev, mii, cmd);
 	spin_unlock_irqrestore(&fep->lock, flags);
 	return rc;
 }
@@ -1031,12 +1068,6 @@ static struct net_device *fs_init_instan
 	}
 	registered = 1;
 
-	err = fs_mii_connect(ndev);
-	if (err != 0) {
-		printk(KERN_ERR DRV_MODULE_NAME
-		       ": %s fs_mii_connect failed.\n", ndev->name);
-		goto err;
-	}
 
 	return ndev;
 
@@ -1074,8 +1105,6 @@ static int fs_cleanup_instance(struct ne
 
 	fpi = fep->fpi;
 
-	fs_mii_disconnect(ndev);
-
 	unregister_netdev(ndev);
 
 	dma_free_coherent(fep->dev, (fpi->tx_ring + fpi->rx_ring) * sizeof(cbd_t),
@@ -1197,17 +1226,39 @@ static int __init fs_init(void)
 	r = setup_immap();
 	if (r != 0)
 		return r;
-	r = driver_register(&fs_enet_fec_driver);
+
+#ifdef CONFIG_FS_ENET_HAS_FCC
+	/* let's insert mii stuff */
+	r = fs_enet_mdio_bb_init();
+
+	if (r != 0) {
+		printk(KERN_ERR DRV_MODULE_NAME
+			"BB PHY init failed.\n");
+		return r;
+	}
+	r = driver_register(&fs_enet_fcc_driver);
 	if (r != 0)
 		goto err;
+#endif
 
-	r = driver_register(&fs_enet_fcc_driver);
+#ifdef CONFIG_FS_ENET_HAS_FEC
+	r =  fs_enet_mdio_fec_init();
+	if (r != 0) {
+		printk(KERN_ERR DRV_MODULE_NAME
+			"FEC PHY init failed.\n");
+		return r;
+	}
+
+	r = driver_register(&fs_enet_fec_driver);
 	if (r != 0)
 		goto err;
+#endif
 
+#ifdef CONFIG_FS_ENET_HAS_SCC
 	r = driver_register(&fs_enet_scc_driver);
 	if (r != 0)
 		goto err;
+#endif
 
 	return 0;
 err:
diff --git a/drivers/net/fs_enet/fs_enet-mii.c b/drivers/net/fs_enet/fs_enet-mii.c
deleted file mode 100644
index c677037..0000000
--- a/drivers/net/fs_enet/fs_enet-mii.c
+++ /dev/null
@@ -1,507 +0,0 @@
-/*
- * Combined Ethernet driver for Motorola MPC8xx and MPC82xx.
- *
- * Copyright (c) 2003 Intracom S.A. 
- *  by Pantelis Antoniou <panto@intracom.gr>
- * 
- * 2005 (c) MontaVista Software, Inc. 
- * Vitaly Bordug <vbordug@ru.mvista.com>
- *
- * Heavily based on original FEC driver by Dan Malek <dan@embeddededge.com>
- * and modifications by Joakim Tjernlund <joakim.tjernlund@lumentis.se>
- *
- * This file is licensed under the terms of the GNU General Public License 
- * version 2. This program is licensed "as is" without any warranty of any 
- * kind, whether express or implied.
- */
-
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/string.h>
-#include <linux/ptrace.h>
-#include <linux/errno.h>
-#include <linux/ioport.h>
-#include <linux/slab.h>
-#include <linux/interrupt.h>
-#include <linux/pci.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/skbuff.h>
-#include <linux/spinlock.h>
-#include <linux/mii.h>
-#include <linux/ethtool.h>
-#include <linux/bitops.h>
-
-#include <asm/pgtable.h>
-#include <asm/irq.h>
-#include <asm/uaccess.h>
-
-#include "fs_enet.h"
-
-/*************************************************/
-
-/*
- * Generic PHY support.
- * Should work for all PHYs, but link change is detected by polling
- */
-
-static void generic_timer_callback(unsigned long data)
-{
-	struct net_device *dev = (struct net_device *)data;
-	struct fs_enet_private *fep = netdev_priv(dev);
-
-	fep->phy_timer_list.expires = jiffies + HZ / 2;
-
-	add_timer(&fep->phy_timer_list);
-
-	fs_mii_link_status_change_check(dev, 0);
-}
-
-static void generic_startup(struct net_device *dev)
-{
-	struct fs_enet_private *fep = netdev_priv(dev);
-
-	fep->phy_timer_list.expires = jiffies + HZ / 2;	/* every 500ms */
-	fep->phy_timer_list.data = (unsigned long)dev;
-	fep->phy_timer_list.function = generic_timer_callback;
-	add_timer(&fep->phy_timer_list);
-}
-
-static void generic_shutdown(struct net_device *dev)
-{
-	struct fs_enet_private *fep = netdev_priv(dev);
-
-	del_timer_sync(&fep->phy_timer_list);
-}
-
-/* ------------------------------------------------------------------------- */
-/* The Davicom DM9161 is used on the NETTA board			     */
-
-/* register definitions */
-
-#define MII_DM9161_ANAR		4	/* Aux. Config Register         */
-#define MII_DM9161_ACR		16	/* Aux. Config Register         */
-#define MII_DM9161_ACSR		17	/* Aux. Config/Status Register  */
-#define MII_DM9161_10TCSR	18	/* 10BaseT Config/Status Reg.   */
-#define MII_DM9161_INTR		21	/* Interrupt Register           */
-#define MII_DM9161_RECR		22	/* Receive Error Counter Reg.   */
-#define MII_DM9161_DISCR	23	/* Disconnect Counter Register  */
-
-static void dm9161_startup(struct net_device *dev)
-{
-	struct fs_enet_private *fep = netdev_priv(dev);
-
-	fs_mii_write(dev, fep->mii_if.phy_id, MII_DM9161_INTR, 0x0000);
-	/* Start autonegotiation */
-	fs_mii_write(dev, fep->mii_if.phy_id, MII_BMCR, 0x1200);
-
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(HZ*8);
-}
-
-static void dm9161_ack_int(struct net_device *dev)
-{
-	struct fs_enet_private *fep = netdev_priv(dev);
-
-	fs_mii_read(dev, fep->mii_if.phy_id, MII_DM9161_INTR);
-}
-
-static void dm9161_shutdown(struct net_device *dev)
-{
-	struct fs_enet_private *fep = netdev_priv(dev);
-
-	fs_mii_write(dev, fep->mii_if.phy_id, MII_DM9161_INTR, 0x0f00);
-}
-
-/**********************************************************************************/
-
-static const struct phy_info phy_info[] = {
-	{
-		.id = 0x00181b88,
-		.name = "DM9161",
-		.startup = dm9161_startup,
-		.ack_int = dm9161_ack_int,
-		.shutdown = dm9161_shutdown,
-	}, {
-		.id = 0,
-		.name = "GENERIC",
-		.startup = generic_startup,
-		.shutdown = generic_shutdown,
-	},
-};
-
-/**********************************************************************************/
-
-static int phy_id_detect(struct net_device *dev)
-{
-	struct fs_enet_private *fep = netdev_priv(dev);
-	const struct fs_platform_info *fpi = fep->fpi;
-	struct fs_enet_mii_bus *bus = fep->mii_bus;
-	int i, r, start, end, phytype, physubtype;
-	const struct phy_info *phy;
-	int phy_hwid, phy_id;
-
-	phy_hwid = -1;
-	fep->phy = NULL;
-
-	/* auto-detect? */
-	if (fpi->phy_addr == -1) {
-		start = 1;
-		end = 32;
-	} else {		/* direct */
-		start = fpi->phy_addr;
-		end = start + 1;
-	}
-
-	for (phy_id = start; phy_id < end; phy_id++) {
-		/* skip already used phy addresses on this bus */ 
-		if (bus->usage_map & (1 << phy_id))
-			continue;
-		r = fs_mii_read(dev, phy_id, MII_PHYSID1);
-		if (r == -1 || (phytype = (r & 0xffff)) == 0xffff)
-			continue;
-		r = fs_mii_read(dev, phy_id, MII_PHYSID2);
-		if (r == -1 || (physubtype = (r & 0xffff)) == 0xffff)
-			continue;
-		phy_hwid = (phytype << 16) | physubtype;
-		if (phy_hwid != -1)
-			break;
-	}
-
-	if (phy_hwid == -1) {
-		printk(KERN_ERR DRV_MODULE_NAME
-		       ": %s No PHY detected! range=0x%02x-0x%02x\n",
-			dev->name, start, end);
-		return -1;
-	}
-
-	for (i = 0, phy = phy_info; i < ARRAY_SIZE(phy_info); i++, phy++)
-		if (phy->id == (phy_hwid >> 4) || phy->id == 0)
-			break;
-
-	if (i >= ARRAY_SIZE(phy_info)) {
-		printk(KERN_ERR DRV_MODULE_NAME
-		       ": %s PHY id 0x%08x is not supported!\n",
-		       dev->name, phy_hwid);
-		return -1;
-	}
-
-	fep->phy = phy;
-
-	/* mark this address as used */
-	bus->usage_map |= (1 << phy_id);
-
-	printk(KERN_INFO DRV_MODULE_NAME
-	       ": %s Phy @ 0x%x, type %s (0x%08x)%s\n",
-	       dev->name, phy_id, fep->phy->name, phy_hwid,
-	       fpi->phy_addr == -1 ? " (auto-detected)" : "");
-
-	return phy_id;
-}
-
-void fs_mii_startup(struct net_device *dev)
-{
-	struct fs_enet_private *fep = netdev_priv(dev);
-
-	if (fep->phy->startup)
-		(*fep->phy->startup) (dev);
-}
-
-void fs_mii_shutdown(struct net_device *dev)
-{
-	struct fs_enet_private *fep = netdev_priv(dev);
-
-	if (fep->phy->shutdown)
-		(*fep->phy->shutdown) (dev);
-}
-
-void fs_mii_ack_int(struct net_device *dev)
-{
-	struct fs_enet_private *fep = netdev_priv(dev);
-
-	if (fep->phy->ack_int)
-		(*fep->phy->ack_int) (dev);
-}
-
-#define MII_LINK	0x0001
-#define MII_HALF	0x0002
-#define MII_FULL	0x0004
-#define MII_BASE4	0x0008
-#define MII_10M		0x0010
-#define MII_100M	0x0020
-#define MII_1G		0x0040
-#define MII_10G		0x0080
-
-/* return full mii info at one gulp, with a usable form */
-static unsigned int mii_full_status(struct mii_if_info *mii)
-{
-	unsigned int status;
-	int bmsr, adv, lpa, neg;
-	struct fs_enet_private* fep = netdev_priv(mii->dev);
-	
-	/* first, a dummy read, needed to latch some MII phys */
-	(void)mii->mdio_read(mii->dev, mii->phy_id, MII_BMSR);
-	bmsr = mii->mdio_read(mii->dev, mii->phy_id, MII_BMSR);
-
-	/* no link */
-	if ((bmsr & BMSR_LSTATUS) == 0)
-		return 0;
-
-	status = MII_LINK;
-	
-	/* Lets look what ANEG says if it's supported - otherwize we shall
-	   take the right values from the platform info*/
-	if(!mii->force_media) {
-		/* autoneg not completed; don't bother */
-		if ((bmsr & BMSR_ANEGCOMPLETE) == 0)
-			return 0;
-
-		adv = (*mii->mdio_read)(mii->dev, mii->phy_id, MII_ADVERTISE);
-		lpa = (*mii->mdio_read)(mii->dev, mii->phy_id, MII_LPA);
-
-		neg = lpa & adv;
-	} else {
-		neg = fep->fpi->bus_info->lpa;
-	}
-
-	if (neg & LPA_100FULL)
-		status |= MII_FULL | MII_100M;
-	else if (neg & LPA_100BASE4)
-		status |= MII_FULL | MII_BASE4 | MII_100M;
-	else if (neg & LPA_100HALF)
-		status |= MII_HALF | MII_100M;
-	else if (neg & LPA_10FULL)
-		status |= MII_FULL | MII_10M;
-	else
-		status |= MII_HALF | MII_10M;
-	
-	return status;
-}
-
-void fs_mii_link_status_change_check(struct net_device *dev, int init_media)
-{
-	struct fs_enet_private *fep = netdev_priv(dev);
-	struct mii_if_info *mii = &fep->mii_if;
-	unsigned int mii_status;
-	int ok_to_print, link, duplex, speed;
-	unsigned long flags;
-
-	ok_to_print = netif_msg_link(fep);
-
-	mii_status = mii_full_status(mii);
-
-	if (!init_media && mii_status == fep->last_mii_status)
-		return;
-
-	fep->last_mii_status = mii_status;
-
-	link = !!(mii_status & MII_LINK);
-	duplex = !!(mii_status & MII_FULL);
-	speed = (mii_status & MII_100M) ? 100 : 10;
-
-	if (link == 0) {
-		netif_carrier_off(mii->dev);
-		netif_stop_queue(dev);
-		if (!init_media) {
-			spin_lock_irqsave(&fep->lock, flags);
-			(*fep->ops->stop)(dev);
-			spin_unlock_irqrestore(&fep->lock, flags);
-		}
-
-		if (ok_to_print)
-			printk(KERN_INFO "%s: link down\n", mii->dev->name);
-
-	} else {
-
-		mii->full_duplex = duplex;
-
-		netif_carrier_on(mii->dev);
-
-		spin_lock_irqsave(&fep->lock, flags);
-		fep->duplex = duplex;
-		fep->speed = speed;
-		(*fep->ops->restart)(dev);
-		spin_unlock_irqrestore(&fep->lock, flags);
-
-		netif_start_queue(dev);
-
-		if (ok_to_print)
-			printk(KERN_INFO "%s: link up, %dMbps, %s-duplex\n",
-			       dev->name, speed, duplex ? "full" : "half");
-	}
-}
-
-/**********************************************************************************/
-
-int fs_mii_read(struct net_device *dev, int phy_id, int location)
-{
-	struct fs_enet_private *fep = netdev_priv(dev);
-	struct fs_enet_mii_bus *bus = fep->mii_bus;
-
-	unsigned long flags;
-	int ret;
-
-	spin_lock_irqsave(&bus->mii_lock, flags);
-	ret = (*bus->mii_read)(bus, phy_id, location);
-	spin_unlock_irqrestore(&bus->mii_lock, flags);
-
-	return ret;
-}
-
-void fs_mii_write(struct net_device *dev, int phy_id, int location, int value)
-{
-	struct fs_enet_private *fep = netdev_priv(dev);
-	struct fs_enet_mii_bus *bus = fep->mii_bus;
-	unsigned long flags;
-
-	spin_lock_irqsave(&bus->mii_lock, flags);
-	(*bus->mii_write)(bus, phy_id, location, value);
-	spin_unlock_irqrestore(&bus->mii_lock, flags);
-}
-
-/*****************************************************************************/
-
-/* list of all registered mii buses */
-static LIST_HEAD(fs_mii_bus_list);
-
-static struct fs_enet_mii_bus *lookup_bus(int method, int id)
-{
-	struct list_head *ptr;
-	struct fs_enet_mii_bus *bus;
-
-	list_for_each(ptr, &fs_mii_bus_list) {
-		bus = list_entry(ptr, struct fs_enet_mii_bus, list);
-		if (bus->bus_info->method == method &&
-			bus->bus_info->id == id)
-			return bus;
-	}
-	return NULL;
-}
-
-static struct fs_enet_mii_bus *create_bus(const struct fs_mii_bus_info *bi)
-{
-	struct fs_enet_mii_bus *bus;
-	int ret = 0;
-
-	bus = kmalloc(sizeof(*bus), GFP_KERNEL);
-	if (bus == NULL) {
-		ret = -ENOMEM;
-		goto err;
-	}
-	memset(bus, 0, sizeof(*bus));
-	spin_lock_init(&bus->mii_lock);
-	bus->bus_info = bi;
-	bus->refs = 0;
-	bus->usage_map = 0;
-
-	/* perform initialization */
-	switch (bi->method) {
-
-		case fsmii_fixed:
-			ret = fs_mii_fixed_init(bus);
-			if (ret != 0)
-				goto err;
-			break;
-
-		case fsmii_bitbang:
-			ret = fs_mii_bitbang_init(bus);
-			if (ret != 0)
-				goto err;
-			break;
-#ifdef CONFIG_FS_ENET_HAS_FEC
-		case fsmii_fec:
-			ret = fs_mii_fec_init(bus);
-			if (ret != 0)
-				goto err;
-			break;
-#endif
-		default:
-			ret = -EINVAL;
-			goto err;
-	}
-
-	list_add(&bus->list, &fs_mii_bus_list);
-
-	return bus;
-
-err:
-	if (bus)
-		kfree(bus);
-	return ERR_PTR(ret);
-}
-
-static void destroy_bus(struct fs_enet_mii_bus *bus)
-{
-	/* remove from bus list */
-	list_del(&bus->list);
-
-	/* nothing more needed */
-	kfree(bus);
-}
-
-int fs_mii_connect(struct net_device *dev)
-{
-	struct fs_enet_private *fep = netdev_priv(dev);
-	const struct fs_platform_info *fpi = fep->fpi;
-	struct fs_enet_mii_bus *bus = NULL;
-
-	/* check method validity */
-	switch (fpi->bus_info->method) {
-		case fsmii_fixed:
-		case fsmii_bitbang:
-			break;
-#ifdef CONFIG_FS_ENET_HAS_FEC
-		case fsmii_fec:
-			break;
-#endif
-		default:
-			printk(KERN_ERR DRV_MODULE_NAME
-			       ": %s Unknown MII bus method (%d)!\n",
-			       dev->name, fpi->bus_info->method);
-			return -EINVAL; 
-	}
-
-	bus = lookup_bus(fpi->bus_info->method, fpi->bus_info->id);
-
-	/* if not found create new bus */
-	if (bus == NULL) {
-		bus = create_bus(fpi->bus_info);
-		if (IS_ERR(bus)) {
-			printk(KERN_ERR DRV_MODULE_NAME
-			       ": %s MII bus creation failure!\n", dev->name);
-			return PTR_ERR(bus);
-		}
-	}
-
-	bus->refs++;
-
-	fep->mii_bus = bus;
-
-	fep->mii_if.dev = dev;
-	fep->mii_if.phy_id_mask = 0x1f;
-	fep->mii_if.reg_num_mask = 0x1f;
-	fep->mii_if.mdio_read = fs_mii_read;
-	fep->mii_if.mdio_write = fs_mii_write;
-	fep->mii_if.force_media = fpi->bus_info->disable_aneg;
-	fep->mii_if.phy_id = phy_id_detect(dev);
-
-	return 0;
-}
-
-void fs_mii_disconnect(struct net_device *dev)
-{
-	struct fs_enet_private *fep = netdev_priv(dev);
-	struct fs_enet_mii_bus *bus = NULL;
-
-	bus = fep->mii_bus;
-	fep->mii_bus = NULL;
-
-	if (--bus->refs <= 0)
-		destroy_bus(bus);
-}
diff --git a/drivers/net/fs_enet/fs_enet.h b/drivers/net/fs_enet/fs_enet.h
index e7ec96c..95022c0 100644
--- a/drivers/net/fs_enet/fs_enet.h
+++ b/drivers/net/fs_enet/fs_enet.h
@@ -5,6 +5,7 @@
 #include <linux/netdevice.h>
 #include <linux/types.h>
 #include <linux/list.h>
+#include <linux/phy.h>
 
 #include <linux/fs_enet_pd.h>
 
@@ -12,12 +13,30 @@
 
 #ifdef CONFIG_CPM1
 #include <asm/commproc.h>
+
+struct fec_info {
+        fec_t*  fecp;
+	u32     mii_speed;
+};
 #endif
 
 #ifdef CONFIG_CPM2
 #include <asm/cpm2.h>
 #endif
 
+/* This is used to operate with pins.
+  Note that the actual port size may
+    be different; cpm(s) handle it OK  */
+struct bb_info {
+	u8 mdio_dat_msk;
+	u8 mdio_dir_msk;
+	u8 *mdio_dir;
+	u8 *mdio_dat;
+	u8 mdc_msk;
+	u8 *mdc_dat;
+	int delay;
+};
+
 /* hw driver ops */
 struct fs_ops {
 	int (*setup_data)(struct net_device *dev);
@@ -25,6 +44,7 @@ struct fs_ops {
 	void (*free_bd)(struct net_device *dev);
 	void (*cleanup_data)(struct net_device *dev);
 	void (*set_multicast_list)(struct net_device *dev);
+	void (*adjust_link)(struct net_device *dev);
 	void (*restart)(struct net_device *dev);
 	void (*stop)(struct net_device *dev);
 	void (*pre_request_irq)(struct net_device *dev, int irq);
@@ -100,10 +120,6 @@ struct fs_enet_mii_bus {
 	};
 };
 
-int fs_mii_bitbang_init(struct fs_enet_mii_bus *bus);
-int fs_mii_fixed_init(struct fs_enet_mii_bus *bus);
-int fs_mii_fec_init(struct fs_enet_mii_bus *bus);
-
 struct fs_enet_private {
 	struct device *dev;	/* pointer back to the device (must be initialized first) */
 	spinlock_t lock;	/* during all ops except TX pckt processing */
@@ -130,7 +146,8 @@ struct fs_enet_private {
 	struct fs_enet_mii_bus *mii_bus;
 	int interrupt;
 
-	int duplex, speed;	/* current settings */
+	struct phy_device *phydev;
+	int oldduplex, oldspeed, oldlink;	/* current settings */
 
 	/* event masks */
 	u32 ev_napi_rx;		/* mask of NAPI rx events */
@@ -168,15 +185,9 @@ struct fs_enet_private {
 };
 
 /***************************************************************************/
-
-int fs_mii_read(struct net_device *dev, int phy_id, int location);
-void fs_mii_write(struct net_device *dev, int phy_id, int location, int value);
-
-void fs_mii_startup(struct net_device *dev);
-void fs_mii_shutdown(struct net_device *dev);
-void fs_mii_ack_int(struct net_device *dev);
-
-void fs_mii_link_status_change_check(struct net_device *dev, int init_media);
+int fs_enet_mdio_bb_init(void);
+int fs_mii_fixed_init(struct fs_enet_mii_bus *bus);
+int fs_enet_mdio_fec_init(void);
 
 void fs_init_bds(struct net_device *dev);
 void fs_cleanup_bds(struct net_device *dev);
@@ -194,7 +205,6 @@ int fs_enet_platform_init(void);
 void fs_enet_platform_cleanup(void);
 
 /***************************************************************************/
-
 /* buffer descriptor access macros */
 
 /* access macros */
diff --git a/drivers/net/fs_enet/mac-fcc.c b/drivers/net/fs_enet/mac-fcc.c
index 95e2bb8..ce40cf9 100644
--- a/drivers/net/fs_enet/mac-fcc.c
+++ b/drivers/net/fs_enet/mac-fcc.c
@@ -35,6 +35,7 @@
 #include <linux/bitops.h>
 #include <linux/fs.h>
 #include <linux/platform_device.h>
+#include <linux/phy.h>
 
 #include <asm/immap_cpm2.h>
 #include <asm/mpc8260.h>
@@ -395,7 +396,7 @@ static void restart(struct net_device *d
 
 	/* adjust to speed (for RMII mode) */
 	if (fpi->use_rmii) {
-		if (fep->speed == 100)
+		if (fep->phydev->speed == 100)
 			C8(fcccp, fcc_gfemr, 0x20);
 		else
 			S8(fcccp, fcc_gfemr, 0x20);
@@ -421,7 +422,7 @@ static void restart(struct net_device *d
 		S32(fccp, fcc_fpsmr, FCC_PSMR_RMII);
 
 	/* adjust to duplex mode */
-	if (fep->duplex)
+	if (fep->phydev->duplex)
 		S32(fccp, fcc_fpsmr, FCC_PSMR_FDE | FCC_PSMR_LPB);
 	else
 		C32(fccp, fcc_fpsmr, FCC_PSMR_FDE | FCC_PSMR_LPB);
@@ -487,7 +488,10 @@ static void rx_bd_done(struct net_device
 
 static void tx_kickstart(struct net_device *dev)
 {
-	/* nothing */
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fcc_t *fccp = fep->fcc.fccp;
+
+	S32(fccp, fcc_ftodr, 0x80);
 }
 
 static u32 get_int_events(struct net_device *dev)
diff --git a/drivers/net/fs_enet/mac-fec.c b/drivers/net/fs_enet/mac-fec.c
index 3dad69d..99678c3 100644
--- a/drivers/net/fs_enet/mac-fec.c
+++ b/drivers/net/fs_enet/mac-fec.c
@@ -47,6 +47,7 @@
 #endif
 
 #include "fs_enet.h"
+#include "fec.h"
 
 /*************************************************/
 
@@ -76,48 +77,6 @@
 /* clear bits */
 #define FC(_fecp, _reg, _v) FW(_fecp, _reg, FR(_fecp, _reg) & ~(_v))
 
-
-/* CRC polynomium used by the FEC for the multicast group filtering */
-#define FEC_CRC_POLY   0x04C11DB7
-
-#define FEC_MAX_MULTICAST_ADDRS	64
-
-/* Interrupt events/masks.
-*/
-#define FEC_ENET_HBERR	0x80000000U	/* Heartbeat error          */
-#define FEC_ENET_BABR	0x40000000U	/* Babbling receiver        */
-#define FEC_ENET_BABT	0x20000000U	/* Babbling transmitter     */
-#define FEC_ENET_GRA	0x10000000U	/* Graceful stop complete   */
-#define FEC_ENET_TXF	0x08000000U	/* Full frame transmitted   */
-#define FEC_ENET_TXB	0x04000000U	/* A buffer was transmitted */
-#define FEC_ENET_RXF	0x02000000U	/* Full frame received      */
-#define FEC_ENET_RXB	0x01000000U	/* A buffer was received    */
-#define FEC_ENET_MII	0x00800000U	/* MII interrupt            */
-#define FEC_ENET_EBERR	0x00400000U	/* SDMA bus error           */
-
-#define FEC_ECNTRL_PINMUX	0x00000004
-#define FEC_ECNTRL_ETHER_EN	0x00000002
-#define FEC_ECNTRL_RESET	0x00000001
-
-#define FEC_RCNTRL_BC_REJ	0x00000010
-#define FEC_RCNTRL_PROM		0x00000008
-#define FEC_RCNTRL_MII_MODE	0x00000004
-#define FEC_RCNTRL_DRT		0x00000002
-#define FEC_RCNTRL_LOOP		0x00000001
-
-#define FEC_TCNTRL_FDEN		0x00000004
-#define FEC_TCNTRL_HBC		0x00000002
-#define FEC_TCNTRL_GTS		0x00000001
-
-
-/* Make MII read/write commands for the FEC.
-*/
-#define mk_mii_read(REG)	(0x60020000 | ((REG & 0x1f) << 18))
-#define mk_mii_write(REG, VAL)	(0x50020000 | ((REG & 0x1f) << 18) | (VAL & 0xffff))
-#define mk_mii_end		0
-
-#define FEC_MII_LOOPS	10000
-
 /*
  * Delay to wait for FEC reset command to complete (in us) 
  */
@@ -304,11 +263,13 @@ static void restart(struct net_device *d
 	int r;
 	u32 addrhi, addrlo;
 
+	struct mii_bus* mii = fep->phydev->bus;
+	struct fec_info* fec_inf = mii->priv;
+
 	r = whack_reset(fep->fec.fecp);
 	if (r != 0)
 		printk(KERN_ERR DRV_MODULE_NAME
 				": %s FEC Reset FAILED!\n", dev->name);
-
 	/*
 	 * Set station address. 
 	 */
@@ -353,7 +314,7 @@ static void restart(struct net_device *d
 	/*
 	 * Set MII speed. 
 	 */
-	FW(fecp, mii_speed, fep->mii_bus->fec.mii_speed);
+	FW(fecp, mii_speed, fec_inf->mii_speed);
 
 	/*
 	 * Clear any outstanding interrupt. 
@@ -391,11 +352,12 @@ static void restart(struct net_device *d
 	}
 #endif
 
+
 	FW(fecp, r_cntrl, FEC_RCNTRL_MII_MODE);	/* MII enable */
 	/*
 	 * adjust to duplex mode 
 	 */
-	if (fep->duplex) {
+	if (fep->phydev->duplex) {
 		FC(fecp, r_cntrl, FEC_RCNTRL_DRT);
 		FS(fecp, x_cntrl, FEC_TCNTRL_FDEN);	/* FD enable */
 	} else {
@@ -419,9 +381,11 @@ static void restart(struct net_device *d
 static void stop(struct net_device *dev)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
+	const struct fs_platform_info *fpi = fep->fpi;
 	fec_t *fecp = fep->fec.fecp;
-	struct fs_enet_mii_bus *bus = fep->mii_bus;
-	const struct fs_mii_bus_info *bi = bus->bus_info;
+
+	struct fec_info* feci= fep->phydev->bus->priv;
+
 	int i;
 
 	if ((FR(fecp, ecntrl) & FEC_ECNTRL_ETHER_EN) == 0)
@@ -445,11 +409,11 @@ static void stop(struct net_device *dev)
 	fs_cleanup_bds(dev);
 
 	/* shut down FEC1? that's where the mii bus is */
-	if (fep->fec.idx == 0 && bus->refs > 1 && bi->method == fsmii_fec) {
+	if (fpi->has_phy) {
 		FS(fecp, r_cntrl, FEC_RCNTRL_MII_MODE);	/* MII enable */
 		FS(fecp, ecntrl, FEC_ECNTRL_PINMUX | FEC_ECNTRL_ETHER_EN);
 		FW(fecp, ievent, FEC_ENET_MII);
-		FW(fecp, mii_speed, bus->fec.mii_speed);
+		FW(fecp, mii_speed, feci->mii_speed);
 	}
 }
 
@@ -584,73 +548,3 @@ const struct fs_ops fs_fec_ops = {
 	.free_bd		= free_bd,
 };
 
-/***********************************************************************/
-
-static int mii_read(struct fs_enet_mii_bus *bus, int phy_id, int location)
-{
-	fec_t *fecp = bus->fec.fecp;
-	int i, ret = -1;
-
-	if ((FR(fecp, r_cntrl) & FEC_RCNTRL_MII_MODE) == 0)
-		BUG();
-
-	/* Add PHY address to register command.  */
-	FW(fecp, mii_data, (phy_id << 23) | mk_mii_read(location));
-
-	for (i = 0; i < FEC_MII_LOOPS; i++)
-		if ((FR(fecp, ievent) & FEC_ENET_MII) != 0)
-			break;
-
-	if (i < FEC_MII_LOOPS) {
-		FW(fecp, ievent, FEC_ENET_MII);
-		ret = FR(fecp, mii_data) & 0xffff;
-	}
-
-	return ret;
-}
-
-static void mii_write(struct fs_enet_mii_bus *bus, int phy_id, int location, int value)
-{
-	fec_t *fecp = bus->fec.fecp;
-	int i;
-
-	/* this must never happen */
-	if ((FR(fecp, r_cntrl) & FEC_RCNTRL_MII_MODE) == 0)
-		BUG();
-
-	/* Add PHY address to register command.  */
-	FW(fecp, mii_data, (phy_id << 23) | mk_mii_write(location, value));
-
-	for (i = 0; i < FEC_MII_LOOPS; i++)
-		if ((FR(fecp, ievent) & FEC_ENET_MII) != 0)
-			break;
-
-	if (i < FEC_MII_LOOPS)
-		FW(fecp, ievent, FEC_ENET_MII);
-}
-
-int fs_mii_fec_init(struct fs_enet_mii_bus *bus)
-{
-	bd_t *bd = (bd_t *)__res;
-	const struct fs_mii_bus_info *bi = bus->bus_info;
-	fec_t *fecp;
-
-	if (bi->id != 0)
-		return -1;
-
-	bus->fec.fecp = &((immap_t *)fs_enet_immap)->im_cpm.cp_fec;
-	bus->fec.mii_speed = ((((bd->bi_intfreq + 4999999) / 2500000) / 2)
-				& 0x3F) << 1;
-
-	fecp = bus->fec.fecp;
-
-	FS(fecp, r_cntrl, FEC_RCNTRL_MII_MODE);	/* MII enable */
-	FS(fecp, ecntrl, FEC_ECNTRL_PINMUX | FEC_ECNTRL_ETHER_EN);
-	FW(fecp, ievent, FEC_ENET_MII);
-	FW(fecp, mii_speed, bus->fec.mii_speed);
-
-	bus->mii_read = mii_read;
-	bus->mii_write = mii_write;
-
-	return 0;
-}
diff --git a/drivers/net/fs_enet/mac-scc.c b/drivers/net/fs_enet/mac-scc.c
index a772b28..d829120 100644
--- a/drivers/net/fs_enet/mac-scc.c
+++ b/drivers/net/fs_enet/mac-scc.c
@@ -370,7 +370,7 @@ static void restart(struct net_device *d
 	W16(sccp, scc_psmr, SCC_PSMR_ENCRC | SCC_PSMR_NIB22);
 
 	/* Set full duplex mode if needed */
-	if (fep->duplex)
+	if (fep->phydev->duplex)
 		S16(sccp, scc_psmr, SCC_PSMR_LPB | SCC_PSMR_FDE);
 
 	S32(sccp, scc_gsmrl, SCC_GSMRL_ENR | SCC_GSMRL_ENT);
@@ -501,6 +501,8 @@ static void tx_restart(struct net_device
 	scc_cr_cmd(fep, CPM_CR_RESTART_TX);
 }
 
+
+
 /*************************************************************************/
 
 const struct fs_ops fs_scc_ops = {
diff --git a/drivers/net/fs_enet/mii-bitbang.c b/drivers/net/fs_enet/mii-bitbang.c
index 24a5e2e..cf2955f 100644
--- a/drivers/net/fs_enet/mii-bitbang.c
+++ b/drivers/net/fs_enet/mii-bitbang.c
@@ -34,6 +34,7 @@
 #include <linux/mii.h>
 #include <linux/ethtool.h>
 #include <linux/bitops.h>
+#include <linux/platform_device.h>
 
 #include <asm/pgtable.h>
 #include <asm/irq.h>
@@ -41,129 +42,25 @@
 
 #include "fs_enet.h"
 
-#ifdef CONFIG_8xx
-static int bitbang_prep_bit(u8 **dirp, u8 **datp, u8 *mskp, int port, int bit)
+static int bitbang_prep_bit(u8 **datp, u8 *mskp,
+		struct fs_mii_bit *mii_bit)
 {
-	immap_t *im = (immap_t *)fs_enet_immap;
-	void *dir, *dat, *ppar;
+	void *dat;
 	int adv;
 	u8 msk;
 
-	switch (port) {
-		case fsiop_porta:
-			dir = &im->im_ioport.iop_padir;
-			dat = &im->im_ioport.iop_padat;
-			ppar = &im->im_ioport.iop_papar;
-			break;
-
-		case fsiop_portb:
-			dir = &im->im_cpm.cp_pbdir;
-			dat = &im->im_cpm.cp_pbdat;
-			ppar = &im->im_cpm.cp_pbpar;
-			break;
-
-		case fsiop_portc:
-			dir = &im->im_ioport.iop_pcdir;
-			dat = &im->im_ioport.iop_pcdat;
-			ppar = &im->im_ioport.iop_pcpar;
-			break;
-
-		case fsiop_portd:
-			dir = &im->im_ioport.iop_pddir;
-			dat = &im->im_ioport.iop_pddat;
-			ppar = &im->im_ioport.iop_pdpar;
-			break;
-
-		case fsiop_porte:
-			dir = &im->im_cpm.cp_pedir;
-			dat = &im->im_cpm.cp_pedat;
-			ppar = &im->im_cpm.cp_pepar;
-			break;
-
-		default:
-			printk(KERN_ERR DRV_MODULE_NAME
-			       "Illegal port value %d!\n", port);
-			return -EINVAL;
-	}
-
-	adv = bit >> 3;
-	dir = (char *)dir + adv;
-	dat = (char *)dat + adv;
-	ppar = (char *)ppar + adv;
-
-	msk = 1 << (7 - (bit & 7));
-	if ((in_8(ppar) & msk) != 0) {
-		printk(KERN_ERR DRV_MODULE_NAME
-		       "pin %d on port %d is not general purpose!\n", bit, port);
-		return -EINVAL;
-	}
-
-	*dirp = dir;
-	*datp = dat;
-	*mskp = msk;
-
-	return 0;
-}
-#endif
-
-#ifdef CONFIG_8260
-static int bitbang_prep_bit(u8 **dirp, u8 **datp, u8 *mskp, int port, int bit)
-{
-	iop_cpm2_t *io = &((cpm2_map_t *)fs_enet_immap)->im_ioport;
-	void *dir, *dat, *ppar;
-	int adv;
-	u8 msk;
-
-	switch (port) {
-		case fsiop_porta:
-			dir = &io->iop_pdira;
-			dat = &io->iop_pdata;
-			ppar = &io->iop_ppara;
-			break;
-
-		case fsiop_portb:
-			dir = &io->iop_pdirb;
-			dat = &io->iop_pdatb;
-			ppar = &io->iop_pparb;
-			break;
-
-		case fsiop_portc:
-			dir = &io->iop_pdirc;
-			dat = &io->iop_pdatc;
-			ppar = &io->iop_pparc;
-			break;
-
-		case fsiop_portd:
-			dir = &io->iop_pdird;
-			dat = &io->iop_pdatd;
-			ppar = &io->iop_ppard;
-			break;
-
-		default:
-			printk(KERN_ERR DRV_MODULE_NAME
-			       "Illegal port value %d!\n", port);
-			return -EINVAL;
-	}
+	dat = (void*) mii_bit->offset;
 
-	adv = bit >> 3;
-	dir = (char *)dir + adv;
+	adv = mii_bit->bit >> 3;
 	dat = (char *)dat + adv;
-	ppar = (char *)ppar + adv;
 
-	msk = 1 << (7 - (bit & 7));
-	if ((in_8(ppar) & msk) != 0) {
-		printk(KERN_ERR DRV_MODULE_NAME
-		       "pin %d on port %d is not general purpose!\n", bit, port);
-		return -EINVAL;
-	}
+	msk = 1 << (7 - (mii_bit->bit & 7));
 
-	*dirp = dir;
 	*datp = dat;
 	*mskp = msk;
 
 	return 0;
 }
-#endif
 
 static inline void bb_set(u8 *p, u8 m)
 {
@@ -180,44 +77,44 @@ static inline int bb_read(u8 *p, u8 m)
 	return (in_8(p) & m) != 0;
 }
 
-static inline void mdio_active(struct fs_enet_mii_bus *bus)
+static inline void mdio_active(struct bb_info *bitbang)
 {
-	bb_set(bus->bitbang.mdio_dir, bus->bitbang.mdio_msk);
+	bb_set(bitbang->mdio_dir, bitbang->mdio_dir_msk);
 }
 
-static inline void mdio_tristate(struct fs_enet_mii_bus *bus)
+static inline void mdio_tristate(struct bb_info *bitbang )
 {
-	bb_clr(bus->bitbang.mdio_dir, bus->bitbang.mdio_msk);
+	bb_clr(bitbang->mdio_dir, bitbang->mdio_dir_msk);
 }
 
-static inline int mdio_read(struct fs_enet_mii_bus *bus)
+static inline int mdio_read(struct bb_info *bitbang )
 {
-	return bb_read(bus->bitbang.mdio_dat, bus->bitbang.mdio_msk);
+	return bb_read(bitbang->mdio_dat, bitbang->mdio_dat_msk);
 }
 
-static inline void mdio(struct fs_enet_mii_bus *bus, int what)
+static inline void mdio(struct bb_info *bitbang , int what)
 {
 	if (what)
-		bb_set(bus->bitbang.mdio_dat, bus->bitbang.mdio_msk);
+		bb_set(bitbang->mdio_dat, bitbang->mdio_dat_msk);
 	else
-		bb_clr(bus->bitbang.mdio_dat, bus->bitbang.mdio_msk);
+		bb_clr(bitbang->mdio_dat, bitbang->mdio_dat_msk);
 }
 
-static inline void mdc(struct fs_enet_mii_bus *bus, int what)
+static inline void mdc(struct bb_info *bitbang , int what)
 {
 	if (what)
-		bb_set(bus->bitbang.mdc_dat, bus->bitbang.mdc_msk);
+		bb_set(bitbang->mdc_dat, bitbang->mdc_msk);
 	else
-		bb_clr(bus->bitbang.mdc_dat, bus->bitbang.mdc_msk);
+		bb_clr(bitbang->mdc_dat, bitbang->mdc_msk);
 }
 
-static inline void mii_delay(struct fs_enet_mii_bus *bus)
+static inline void mii_delay(struct bb_info *bitbang )
 {
-	udelay(bus->bus_info->i.bitbang.delay);
+	udelay(bitbang->delay);
 }
 
 /* Utility to send the preamble, address, and register (common to read and write). */
-static void bitbang_pre(struct fs_enet_mii_bus *bus, int read, u8 addr, u8 reg)
+static void bitbang_pre(struct bb_info *bitbang , int read, u8 addr, u8 reg)
 {
 	int j;
 
@@ -229,177 +126,284 @@ static void bitbang_pre(struct fs_enet_m
 	 * but it is safer and will be much more robust.
 	 */
 
-	mdio_active(bus);
-	mdio(bus, 1);
+	mdio_active(bitbang);
+	mdio(bitbang, 1);
 	for (j = 0; j < 32; j++) {
-		mdc(bus, 0);
-		mii_delay(bus);
-		mdc(bus, 1);
-		mii_delay(bus);
+		mdc(bitbang, 0);
+		mii_delay(bitbang);
+		mdc(bitbang, 1);
+		mii_delay(bitbang);
 	}
 
 	/* send the start bit (01) and the read opcode (10) or write (10) */
-	mdc(bus, 0);
-	mdio(bus, 0);
-	mii_delay(bus);
-	mdc(bus, 1);
-	mii_delay(bus);
-	mdc(bus, 0);
-	mdio(bus, 1);
-	mii_delay(bus);
-	mdc(bus, 1);
-	mii_delay(bus);
-	mdc(bus, 0);
-	mdio(bus, read);
-	mii_delay(bus);
-	mdc(bus, 1);
-	mii_delay(bus);
-	mdc(bus, 0);
-	mdio(bus, !read);
-	mii_delay(bus);
-	mdc(bus, 1);
-	mii_delay(bus);
+	mdc(bitbang, 0);
+	mdio(bitbang, 0);
+	mii_delay(bitbang);
+	mdc(bitbang, 1);
+	mii_delay(bitbang);
+	mdc(bitbang, 0);
+	mdio(bitbang, 1);
+	mii_delay(bitbang);
+	mdc(bitbang, 1);
+	mii_delay(bitbang);
+	mdc(bitbang, 0);
+	mdio(bitbang, read);
+	mii_delay(bitbang);
+	mdc(bitbang, 1);
+	mii_delay(bitbang);
+	mdc(bitbang, 0);
+	mdio(bitbang, !read);
+	mii_delay(bitbang);
+	mdc(bitbang, 1);
+	mii_delay(bitbang);
 
 	/* send the PHY address */
 	for (j = 0; j < 5; j++) {
-		mdc(bus, 0);
-		mdio(bus, (addr & 0x10) != 0);
-		mii_delay(bus);
-		mdc(bus, 1);
-		mii_delay(bus);
+		mdc(bitbang, 0);
+		mdio(bitbang, (addr & 0x10) != 0);
+		mii_delay(bitbang);
+		mdc(bitbang, 1);
+		mii_delay(bitbang);
 		addr <<= 1;
 	}
 
 	/* send the register address */
 	for (j = 0; j < 5; j++) {
-		mdc(bus, 0);
-		mdio(bus, (reg & 0x10) != 0);
-		mii_delay(bus);
-		mdc(bus, 1);
-		mii_delay(bus);
+		mdc(bitbang, 0);
+		mdio(bitbang, (reg & 0x10) != 0);
+		mii_delay(bitbang);
+		mdc(bitbang, 1);
+		mii_delay(bitbang);
 		reg <<= 1;
 	}
 }
 
-static int mii_read(struct fs_enet_mii_bus *bus, int phy_id, int location)
+static int fs_enet_mii_bb_read(struct mii_bus *bus , int phy_id, int location)
 {
 	u16 rdreg;
 	int ret, j;
 	u8 addr = phy_id & 0xff;
 	u8 reg = location & 0xff;
+	struct bb_info* bitbang = bus->priv;
 
-	bitbang_pre(bus, 1, addr, reg);
+	bitbang_pre(bitbang, 1, addr, reg);
 
 	/* tri-state our MDIO I/O pin so we can read */
-	mdc(bus, 0);
-	mdio_tristate(bus);
-	mii_delay(bus);
-	mdc(bus, 1);
-	mii_delay(bus);
+	mdc(bitbang, 0);
+	mdio_tristate(bitbang);
+	mii_delay(bitbang);
+	mdc(bitbang, 1);
+	mii_delay(bitbang);
 
 	/* check the turnaround bit: the PHY should be driving it to zero */
-	if (mdio_read(bus) != 0) {
+	if (mdio_read(bitbang) != 0) {
 		/* PHY didn't drive TA low */
 		for (j = 0; j < 32; j++) {
-			mdc(bus, 0);
-			mii_delay(bus);
-			mdc(bus, 1);
-			mii_delay(bus);
+			mdc(bitbang, 0);
+			mii_delay(bitbang);
+			mdc(bitbang, 1);
+			mii_delay(bitbang);
 		}
 		ret = -1;
 		goto out;
 	}
 
-	mdc(bus, 0);
-	mii_delay(bus);
+	mdc(bitbang, 0);
+	mii_delay(bitbang);
 
 	/* read 16 bits of register data, MSB first */
 	rdreg = 0;
 	for (j = 0; j < 16; j++) {
-		mdc(bus, 1);
-		mii_delay(bus);
+		mdc(bitbang, 1);
+		mii_delay(bitbang);
 		rdreg <<= 1;
-		rdreg |= mdio_read(bus);
-		mdc(bus, 0);
-		mii_delay(bus);
+		rdreg |= mdio_read(bitbang);
+		mdc(bitbang, 0);
+		mii_delay(bitbang);
 	}
 
-	mdc(bus, 1);
-	mii_delay(bus);
-	mdc(bus, 0);
-	mii_delay(bus);
-	mdc(bus, 1);
-	mii_delay(bus);
+	mdc(bitbang, 1);
+	mii_delay(bitbang);
+	mdc(bitbang, 0);
+	mii_delay(bitbang);
+	mdc(bitbang, 1);
+	mii_delay(bitbang);
 
 	ret = rdreg;
 out:
 	return ret;
 }
 
-static void mii_write(struct fs_enet_mii_bus *bus, int phy_id, int location, int val)
+static int fs_enet_mii_bb_write(struct mii_bus *bus, int phy_id, int location, u16 val)
 {
 	int j;
+	struct bb_info* bitbang = bus->priv;
+
 	u8 addr = phy_id & 0xff;
 	u8 reg = location & 0xff;
 	u16 value = val & 0xffff;
 
-	bitbang_pre(bus, 0, addr, reg);
+	bitbang_pre(bitbang, 0, addr, reg);
 
 	/* send the turnaround (10) */
-	mdc(bus, 0);
-	mdio(bus, 1);
-	mii_delay(bus);
-	mdc(bus, 1);
-	mii_delay(bus);
-	mdc(bus, 0);
-	mdio(bus, 0);
-	mii_delay(bus);
-	mdc(bus, 1);
-	mii_delay(bus);
+	mdc(bitbang, 0);
+	mdio(bitbang, 1);
+	mii_delay(bitbang);
+	mdc(bitbang, 1);
+	mii_delay(bitbang);
+	mdc(bitbang, 0);
+	mdio(bitbang, 0);
+	mii_delay(bitbang);
+	mdc(bitbang, 1);
+	mii_delay(bitbang);
 
 	/* write 16 bits of register data, MSB first */
 	for (j = 0; j < 16; j++) {
-		mdc(bus, 0);
-		mdio(bus, (value & 0x8000) != 0);
-		mii_delay(bus);
-		mdc(bus, 1);
-		mii_delay(bus);
+		mdc(bitbang, 0);
+		mdio(bitbang, (value & 0x8000) != 0);
+		mii_delay(bitbang);
+		mdc(bitbang, 1);
+		mii_delay(bitbang);
 		value <<= 1;
 	}
 
 	/*
 	 * Tri-state the MDIO line.
 	 */
-	mdio_tristate(bus);
-	mdc(bus, 0);
-	mii_delay(bus);
-	mdc(bus, 1);
-	mii_delay(bus);
+	mdio_tristate(bitbang);
+	mdc(bitbang, 0);
+	mii_delay(bitbang);
+	mdc(bitbang, 1);
+	mii_delay(bitbang);
+	return 0;
 }
 
-int fs_mii_bitbang_init(struct fs_enet_mii_bus *bus)
+static int fs_enet_mii_bb_reset(struct mii_bus *bus)
+{
+	/*nothing here - dunno how to reset it*/
+	return 0;
+}
+
+static int fs_mii_bitbang_init(struct bb_info *bitbang, struct fs_mii_bb_platform_info* fmpi)
 {
-	const struct fs_mii_bus_info *bi = bus->bus_info;
 	int r;
 
-	r = bitbang_prep_bit(&bus->bitbang.mdio_dir,
-			 &bus->bitbang.mdio_dat,
-			 &bus->bitbang.mdio_msk,
-			 bi->i.bitbang.mdio_port,
-			 bi->i.bitbang.mdio_bit);
+	bitbang->delay = fmpi->delay;
+
+	r = bitbang_prep_bit(&bitbang->mdio_dir,
+			 &bitbang->mdio_dir_msk,
+			 &fmpi->mdio_dir);
 	if (r != 0)
 		return r;
 
-	r = bitbang_prep_bit(&bus->bitbang.mdc_dir,
-			 &bus->bitbang.mdc_dat,
-			 &bus->bitbang.mdc_msk,
-			 bi->i.bitbang.mdc_port,
-			 bi->i.bitbang.mdc_bit);
+	r = bitbang_prep_bit(&bitbang->mdio_dat,
+			 &bitbang->mdio_dat_msk,
+			 &fmpi->mdio_dat);
 	if (r != 0)
 		return r;
 
-	bus->mii_read = mii_read;
-	bus->mii_write = mii_write;
+	r = bitbang_prep_bit(&bitbang->mdc_dat,
+			 &bitbang->mdc_msk,
+			 &fmpi->mdc_dat);
+	if (r != 0)
+		return r;
 
 	return 0;
 }
+
+
+static int __devinit fs_enet_mdio_probe(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct fs_mii_bb_platform_info *pdata;
+	struct mii_bus *new_bus;
+	struct bb_info *bitbang;
+	int err = 0;
+
+	if (NULL == dev)
+		return -EINVAL;
+
+	new_bus = kzalloc(sizeof(struct mii_bus), GFP_KERNEL);
+
+	if (NULL == new_bus)
+		return -ENOMEM;
+
+	bitbang = kzalloc(sizeof(struct bb_info), GFP_KERNEL);
+
+	if (NULL == bitbang)
+		return -ENOMEM;
+
+	new_bus->name = "BB MII Bus",
+	new_bus->read = &fs_enet_mii_bb_read,
+	new_bus->write = &fs_enet_mii_bb_write,
+	new_bus->reset = &fs_enet_mii_bb_reset,
+	new_bus->id = pdev->id;
+
+	new_bus->phy_mask = ~0x9;
+	pdata = (struct fs_mii_bb_platform_info *)pdev->dev.platform_data;
+
+	if (NULL == pdata) {
+		printk(KERN_ERR "gfar mdio %d: Missing platform data!\n", pdev->id);
+		return -ENODEV;
+	}
+
+	/*set up workspace*/
+	fs_mii_bitbang_init(bitbang, pdata);
+
+	new_bus->priv = bitbang;
+
+	new_bus->irq = pdata->irq;
+
+	new_bus->dev = dev;
+	dev_set_drvdata(dev, new_bus);
+
+	err = mdiobus_register(new_bus);
+
+	if (0 != err) {
+		printk (KERN_ERR "%s: Cannot register as MDIO bus\n",
+				new_bus->name);
+		goto bus_register_fail;
+	}
+
+	return 0;
+
+bus_register_fail:
+	kfree(bitbang);
+	kfree(new_bus);
+
+	return err;
+}
+
+
+static int fs_enet_mdio_remove(struct device *dev)
+{
+	struct mii_bus *bus = dev_get_drvdata(dev);
+
+	mdiobus_unregister(bus);
+
+	dev_set_drvdata(dev, NULL);
+
+	iounmap((void *) (&bus->priv));
+	bus->priv = NULL;
+	kfree(bus);
+
+	return 0;
+}
+
+static struct device_driver fs_enet_bb_mdio_driver = {
+	.name = "fsl-bb-mdio",
+	.bus = &platform_bus_type,
+	.probe = fs_enet_mdio_probe,
+	.remove = fs_enet_mdio_remove,
+};
+
+int fs_enet_mdio_bb_init(void)
+{
+	return driver_register(&fs_enet_bb_mdio_driver);
+}
+
+void fs_enet_mdio_bb_exit(void)
+{
+	driver_unregister(&fs_enet_bb_mdio_driver);
+}
+
diff --git a/drivers/net/fs_enet/mii-fec.c b/drivers/net/fs_enet/mii-fec.c
new file mode 100644
index 0000000..1328e10
--- /dev/null
+++ b/drivers/net/fs_enet/mii-fec.c
@@ -0,0 +1,243 @@
+/*
+ * Combined Ethernet driver for Motorola MPC8xx and MPC82xx.
+ *
+ * Copyright (c) 2003 Intracom S.A.
+ *  by Pantelis Antoniou <panto@intracom.gr>
+ *
+ * 2005 (c) MontaVista Software, Inc.
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/ptrace.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/mii.h>
+#include <linux/ethtool.h>
+#include <linux/bitops.h>
+#include <linux/platform_device.h>
+
+#include <asm/pgtable.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+
+#include "fs_enet.h"
+#include "fec.h"
+
+/* Make MII read/write commands for the FEC.
+*/
+#define mk_mii_read(REG)	(0x60020000 | ((REG & 0x1f) << 18))
+#define mk_mii_write(REG, VAL)	(0x50020000 | ((REG & 0x1f) << 18) | (VAL & 0xffff))
+#define mk_mii_end		0
+
+#define FEC_MII_LOOPS	10000
+
+static int match_has_phy (struct device *dev, void* data)
+{
+	struct platform_device* pdev = container_of(dev, struct platform_device, dev);
+	struct fs_platform_info* fpi;
+	if(strcmp(pdev->name, (char*)data))
+	{
+	    return 0;
+	}
+
+	fpi = pdev->dev.platform_data;
+	if((fpi)&&(fpi->has_phy))
+		return 1;
+	return 0;
+}
+
+static int fs_mii_fec_init(struct fec_info* fec, struct fs_mii_fec_platform_info *fmpi)
+{
+	struct resource *r;
+	fec_t *fecp;
+	char* name = "fsl-cpm-fec";
+
+	/* we need fec in order to be useful */
+	struct platform_device *fec_pdev =
+		container_of(bus_find_device(&platform_bus_type, NULL, name, match_has_phy),
+				struct platform_device, dev);
+
+	if(fec_pdev == NULL) {
+		printk(KERN_ERR"Unable to find PHY for %s", name);
+		return -ENODEV;
+	}
+
+	r = platform_get_resource_byname(fec_pdev, IORESOURCE_MEM, "regs");
+
+	fec->fecp = fecp = (fec_t*)ioremap(r->start,sizeof(fec_t));
+	fec->mii_speed = fmpi->mii_speed;
+
+	setbits32(&fecp->fec_r_cntrl, FEC_RCNTRL_MII_MODE);	/* MII enable */
+	setbits32(&fecp->fec_ecntrl, FEC_ECNTRL_PINMUX | FEC_ECNTRL_ETHER_EN);
+	out_be32(&fecp->fec_ievent, FEC_ENET_MII);
+	out_be32(&fecp->fec_mii_speed, fec->mii_speed);
+
+	return 0;
+}
+
+static int fs_enet_fec_mii_read(struct mii_bus *bus , int phy_id, int location)
+{
+	struct fec_info* fec = bus->priv;
+	fec_t *fecp = fec->fecp;
+	int i, ret = -1;
+
+	if ((in_be32(&fecp->fec_r_cntrl) & FEC_RCNTRL_MII_MODE) == 0)
+		BUG();
+
+	/* Add PHY address to register command.  */
+	out_be32(&fecp->fec_mii_data, (phy_id << 23) | mk_mii_read(location));
+
+	for (i = 0; i < FEC_MII_LOOPS; i++)
+		if ((in_be32(&fecp->fec_ievent) & FEC_ENET_MII) != 0)
+			break;
+
+	if (i < FEC_MII_LOOPS) {
+		out_be32(&fecp->fec_ievent, FEC_ENET_MII);
+		ret = in_be32(&fecp->fec_mii_data) & 0xffff;
+	}
+
+	return ret;
+
+}
+
+static int fs_enet_fec_mii_write(struct mii_bus *bus, int phy_id, int location, u16 val)
+{
+	struct fec_info* fec = bus->priv;
+	fec_t *fecp = fec->fecp;
+	int i;
+
+	/* this must never happen */
+	if ((in_be32(&fecp->fec_r_cntrl) & FEC_RCNTRL_MII_MODE) == 0)
+		BUG();
+
+	/* Add PHY address to register command.  */
+	out_be32(&fecp->fec_mii_data, (phy_id << 23) | mk_mii_write(location, val));
+
+	for (i = 0; i < FEC_MII_LOOPS; i++)
+		if ((in_be32(&fecp->fec_ievent) & FEC_ENET_MII) != 0)
+			break;
+
+	if (i < FEC_MII_LOOPS)
+		out_be32(&fecp->fec_ievent, FEC_ENET_MII);
+
+	return 0;
+
+}
+
+static int fs_enet_fec_mii_reset(struct mii_bus *bus)
+{
+	/* nothing here - for now */
+	return 0;
+}
+
+static int __devinit fs_enet_fec_mdio_probe(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct fs_mii_fec_platform_info *pdata;
+	struct mii_bus *new_bus;
+	struct fec_info *fec;
+	int err = 0;
+	if (NULL == dev)
+		return -EINVAL;
+	new_bus = kzalloc(sizeof(struct mii_bus), GFP_KERNEL);
+
+	if (NULL == new_bus)
+		return -ENOMEM;
+
+	fec = kzalloc(sizeof(struct fec_info), GFP_KERNEL);
+
+	if (NULL == fec)
+		return -ENOMEM;
+
+	new_bus->name = "FEC MII Bus",
+	new_bus->read = &fs_enet_fec_mii_read,
+	new_bus->write = &fs_enet_fec_mii_write,
+	new_bus->reset = &fs_enet_fec_mii_reset,
+	new_bus->id = pdev->id;
+
+	pdata = (struct fs_mii_fec_platform_info *)pdev->dev.platform_data;
+
+	if (NULL == pdata) {
+		printk(KERN_ERR "fs_enet FEC mdio %d: Missing platform data!\n", pdev->id);
+		return -ENODEV;
+	}
+
+	/*set up workspace*/
+
+	fs_mii_fec_init(fec, pdata);
+	new_bus->priv = fec;
+
+	new_bus->irq = pdata->irq;
+
+	new_bus->dev = dev;
+	dev_set_drvdata(dev, new_bus);
+
+	err = mdiobus_register(new_bus);
+
+	if (0 != err) {
+		printk (KERN_ERR "%s: Cannot register as MDIO bus\n",
+				new_bus->name);
+		goto bus_register_fail;
+	}
+
+	return 0;
+
+bus_register_fail:
+	kfree(new_bus);
+
+	return err;
+}
+
+
+static int fs_enet_fec_mdio_remove(struct device *dev)
+{
+	struct mii_bus *bus = dev_get_drvdata(dev);
+
+	mdiobus_unregister(bus);
+
+	dev_set_drvdata(dev, NULL);
+	kfree(bus->priv);
+
+	bus->priv = NULL;
+	kfree(bus);
+
+	return 0;
+}
+
+static struct device_driver fs_enet_fec_mdio_driver = {
+	.name = "fsl-cpm-fec-mdio",
+	.bus = &platform_bus_type,
+	.probe = fs_enet_fec_mdio_probe,
+	.remove = fs_enet_fec_mdio_remove,
+};
+
+int fs_enet_mdio_fec_init(void)
+{
+	return driver_register(&fs_enet_fec_mdio_driver);
+}
+
+void fs_enet_mdio_fec_exit(void)
+{
+	driver_unregister(&fs_enet_fec_mdio_driver);
+}
+
diff --git a/drivers/net/fs_enet/mii-fixed.c b/drivers/net/fs_enet/mii-fixed.c
deleted file mode 100644
index b3e192d..0000000
--- a/drivers/net/fs_enet/mii-fixed.c
+++ /dev/null
@@ -1,92 +0,0 @@
-/*
- * Combined Ethernet driver for Motorola MPC8xx and MPC82xx.
- *
- * Copyright (c) 2003 Intracom S.A. 
- *  by Pantelis Antoniou <panto@intracom.gr>
- * 
- * 2005 (c) MontaVista Software, Inc. 
- * Vitaly Bordug <vbordug@ru.mvista.com>
- *
- * This file is licensed under the terms of the GNU General Public License 
- * version 2. This program is licensed "as is" without any warranty of any 
- * kind, whether express or implied.
- */
-
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/string.h>
-#include <linux/ptrace.h>
-#include <linux/errno.h>
-#include <linux/ioport.h>
-#include <linux/slab.h>
-#include <linux/interrupt.h>
-#include <linux/pci.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/skbuff.h>
-#include <linux/spinlock.h>
-#include <linux/mii.h>
-#include <linux/ethtool.h>
-#include <linux/bitops.h>
-
-#include <asm/pgtable.h>
-#include <asm/irq.h>
-#include <asm/uaccess.h>
-
-#include "fs_enet.h"
-
-static const u16 mii_regs[7] = {
-	0x3100,
-	0x786d,
-	0x0fff,
-	0x0fff,
-	0x01e1,
-	0x45e1,
-	0x0003,
-};
-
-static int mii_read(struct fs_enet_mii_bus *bus, int phy_id, int location)
-{
-	int ret = 0;
-
-	if ((unsigned int)location >= ARRAY_SIZE(mii_regs))
-		return -1;
-
-	if (location != 5)
-		ret = mii_regs[location];
-	else
-		ret = bus->fixed.lpa;
-
-	return ret;
-}
-
-static void mii_write(struct fs_enet_mii_bus *bus, int phy_id, int location, int val)
-{
-	/* do nothing */
-}
-
-int fs_mii_fixed_init(struct fs_enet_mii_bus *bus)
-{
-	const struct fs_mii_bus_info *bi = bus->bus_info;
-
-	bus->fixed.lpa = 0x45e1;	/* default 100Mb, full duplex */
-
-	/* if speed is fixed at 10Mb, remove 100Mb modes */
-	if (bi->i.fixed.speed == 10)
-		bus->fixed.lpa &= ~LPA_100;
-
-	/* if duplex is half, remove full duplex modes */
-	if (bi->i.fixed.duplex == 0)
-		bus->fixed.lpa &= ~LPA_DUPLEX;
-
-	bus->mii_read = mii_read;
-	bus->mii_write = mii_write;
-
-	return 0;
-}
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

