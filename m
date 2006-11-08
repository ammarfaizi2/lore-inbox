Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422638AbWKHTjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422638AbWKHTjD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 14:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422650AbWKHTjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 14:39:01 -0500
Received: from nat-132.atmel.no ([80.232.32.132]:63472 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1422633AbWKHTjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 14:39:00 -0500
Date: Wed, 8 Nov 2006 20:36:43 +0100
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrew Victor <andrew@sanpeople.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [-mm patch 1/2] [MACB] Don't depend on platform_data for mac
 address and mii phy id
Message-ID: <20061108203643.470c2231@cad-250-152.norway.atmel.com>
In-Reply-To: <20061108203358.558c28d3@cad-250-152.norway.atmel.com>
References: <20061108203358.558c28d3@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize the mac address and mii phy id like at91_ether does. This
means that we read the initial mac address from the MACB SA1B/SA1T
registers and refuse to open() if the address hasn't been set. Also,
instead of getting the mii phy id from platform_data, we probe all
possible phy addresses until we get something that looks like a sane
response.

While we're at it, initialize the MII bit according to the is_rmii
flag in platform_data (it was misnamed and hardcoded on before.)
If no platform_data is available, default to MII mode.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 drivers/net/macb.c |  109 ++++++++++++++++++++++++++++++++++++++---------------
 drivers/net/macb.h |    4 -
 2 files changed, 82 insertions(+), 31 deletions(-)

Index: linux-2.6.19-rc5-mm1/drivers/net/macb.c
===================================================================
--- linux-2.6.19-rc5-mm1.orig/drivers/net/macb.c	2006-11-08 18:11:06.000000000 +0100
+++ linux-2.6.19-rc5-mm1/drivers/net/macb.c	2006-11-08 20:12:44.000000000 +0100
@@ -65,6 +65,26 @@ static void __macb_set_hwaddr(struct mac
 	macb_writel(bp, SA1T, top);
 }
 
+static void __init macb_get_hwaddr(struct macb *bp)
+{
+	u32 bottom;
+	u16 top;
+	u8 addr[6];
+
+	bottom = macb_readl(bp, SA1B);
+	top = macb_readl(bp, SA1T);
+
+	addr[0] = bottom & 0xff;
+	addr[1] = (bottom >> 8) & 0xff;
+	addr[2] = (bottom >> 16) & 0xff;
+	addr[3] = (bottom >> 24) & 0xff;
+	addr[4] = top & 0xff;
+	addr[5] = (top >> 8) & 0xff;
+
+	if (is_valid_ether_addr(addr))
+		memcpy(bp->dev->dev_addr, addr, sizeof(addr));
+}
+
 static void macb_enable_mdio(struct macb *bp)
 {
 	unsigned long flags;
@@ -138,6 +158,31 @@ static void macb_mdio_write(struct net_d
 	mutex_unlock(&bp->mdio_mutex);
 }
 
+static int macb_phy_probe(struct macb *bp)
+{
+	int phy_address;
+	u16 phyid1, phyid2;
+
+	for (phy_address = 0; phy_address < 32; phy_address++) {
+		phyid1 = macb_mdio_read(bp->dev, phy_address, MII_PHYSID1);
+		phyid2 = macb_mdio_read(bp->dev, phy_address, MII_PHYSID2);
+
+		if (phyid1 != 0xffff && phyid1 != 0x0000
+		    && phyid2 != 0xffff && phyid2 != 0x0000)
+			break;
+	}
+
+	if (phy_address == 32)
+		return -ENODEV;
+
+	dev_info(&bp->pdev->dev,
+		 "detected PHY at address %d (ID %04x:%04x)\n",
+		 phy_address, phyid1, phyid2);
+
+	bp->mii.phy_id = phy_address;
+	return 0;
+}
+
 static void macb_set_media(struct macb *bp, int media)
 {
 	u32 reg;
@@ -473,17 +518,16 @@ static irqreturn_t macb_interrupt(int ir
 
 	spin_lock(&bp->lock);
 
-	/* close possible race with dev_close */
-	if (unlikely(!netif_running(dev))) {
-		macb_writel(bp, IDR, ~0UL);
-		spin_unlock(&bp->lock);
-		return IRQ_HANDLED;
-	}
-
 	while (status) {
 		if (status & MACB_BIT(MFD))
 			complete(&bp->mdio_complete);
 
+		/* close possible race with dev_close */
+		if (unlikely(!netif_running(dev))) {
+			macb_writel(bp, IDR, ~0UL);
+			break;
+		}
+
 		if (status & MACB_RX_INT_FLAGS) {
 			if (netif_rx_schedule_prep(dev)) {
 				/*
@@ -701,26 +745,12 @@ static void macb_reset_hw(struct macb *b
 
 static void macb_init_hw(struct macb *bp)
 {
-	unsigned long pclk_hz;
 	u32 config;
 
 	macb_reset_hw(bp);
 	__macb_set_hwaddr(bp);
 
-	/* Set RMII mode */
-	macb_writel(bp, USRIO, MACB_BIT(RMII));
-
-	/* Initialize Network Configuration Register */
-	pclk_hz = clk_get_rate(bp->pclk);
-	if (pclk_hz <= 20000000)
-		config = MACB_BF(CLK, MACB_CLK_DIV8);
-	else if (pclk_hz <= 40000000)
-		config = MACB_BF(CLK, MACB_CLK_DIV16);
-	else if (pclk_hz <= 80000000)
-		config = MACB_BF(CLK, MACB_CLK_DIV32);
-	else
-		config = MACB_BF(CLK, MACB_CLK_DIV64);
-
+	config = macb_readl(bp, NCFGR) & MACB_BF(CLK, -1L);
 	config |= MACB_BIT(PAE);		/* PAuse Enable */
 	config |= MACB_BIT(DRFCS);		/* Discard Rx FCS */
 	if (bp->dev->flags & IFF_PROMISC)
@@ -766,6 +796,9 @@ static int macb_open(struct net_device *
 
 	dev_dbg(&bp->pdev->dev, "open\n");
 
+	if (!is_valid_ether_addr(dev->dev_addr))
+		return -EADDRNOTAVAIL;
+
 	err = macb_alloc_consistent(bp);
 	if (err) {
 		printk(KERN_ERR
@@ -984,6 +1017,8 @@ static int __devinit macb_probe(struct p
 	struct resource *regs;
 	struct net_device *dev;
 	struct macb *bp;
+	unsigned long pclk_hz;
+	u32 config;
 	int err = -ENXIO;
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1057,20 +1092,36 @@ static int __devinit macb_probe(struct p
 	mutex_init(&bp->mdio_mutex);
 	init_completion(&bp->mdio_complete);
 
+	/* Set MII management clock divider */
+	pclk_hz = clk_get_rate(bp->pclk);
+	if (pclk_hz <= 20000000)
+		config = MACB_BF(CLK, MACB_CLK_DIV8);
+	else if (pclk_hz <= 40000000)
+		config = MACB_BF(CLK, MACB_CLK_DIV16);
+	else if (pclk_hz <= 80000000)
+		config = MACB_BF(CLK, MACB_CLK_DIV32);
+	else
+		config = MACB_BF(CLK, MACB_CLK_DIV64);
+	macb_writel(bp, NCFGR, config);
+
 	bp->mii.dev = dev;
 	bp->mii.mdio_read = macb_mdio_read;
 	bp->mii.mdio_write = macb_mdio_write;
+	bp->mii.phy_id_mask = 0x1f;
+	bp->mii.reg_num_mask = 0x1f;
 
-	pdata = pdev->dev.platform_data;
-	if (!pdata) {
-		dev_err(&pdev->dev, "Cannot determine hw address\n");
+	macb_get_hwaddr(bp);
+	err = macb_phy_probe(bp);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to detect PHY, aborting.\n");
 		goto err_out_free_irq;
 	}
 
-	memcpy(dev->dev_addr, pdata->hw_addr, dev->addr_len);
-	bp->mii.phy_id = pdata->mii_phy_addr;
-	bp->mii.phy_id_mask = 0x1f;
-	bp->mii.reg_num_mask = 0x1f;
+	pdata = pdev->dev.platform_data;
+	if (pdata && pdata->is_rmii)
+		macb_writel(bp, USRIO, 0);
+	else
+		macb_writel(bp, USRIO, MACB_BIT(MII));
 
 	bp->tx_pending = DEF_TX_RING_PENDING;
 
Index: linux-2.6.19-rc5-mm1/drivers/net/macb.h
===================================================================
--- linux-2.6.19-rc5-mm1.orig/drivers/net/macb.h	2006-11-08 18:11:06.000000000 +0100
+++ linux-2.6.19-rc5-mm1/drivers/net/macb.h	2006-11-08 20:12:44.000000000 +0100
@@ -201,8 +201,8 @@
 #define MACB_SOF_SIZE				2
 
 /* Bitfields in USRIO */
-#define MACB_RMII_OFFSET			0
-#define MACB_RMII_SIZE				1
+#define MACB_MII_OFFSET				0
+#define MACB_MII_SIZE				1
 #define MACB_EAM_OFFSET				1
 #define MACB_EAM_SIZE				1
 #define MACB_TX_PAUSE_OFFSET			2
