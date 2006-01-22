Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWAVDGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWAVDGS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 22:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWAVDGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 22:06:18 -0500
Received: from gate.crashing.org ([63.228.1.57]:51344 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751261AbWAVDGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 22:06:17 -0500
Subject: [PATCH] sungem: Make PM of PHYs more reliable (#2)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 22 Jan 2006 14:06:10 +1100
Message-Id: <1137899170.24244.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my latest laptop, I've had occasional PHY dead on wakeup from
sleep... the PHY would be totally unresponsive even to toggling the hard
reset line until the machine is powered down... Looking closely at the
code, I found some possible issues in the way we setup the MDIO lines
during suspend along with slight divergences from what Darwin does when
resetting it that may explain the problem. That patch change these and
the problem appear to be gone for me at least... I also fixed an mdelay
-> msleep while I was at it to the pmac feature code that is called
when toggling the PHY reset line since sungem doesn't call it in an
atomic context anymore.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Ok, this is the right one this time, sorry about that.

Index: linux-work/arch/powerpc/platforms/powermac/feature.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/feature.c	2006-01-11 14:10:47.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/feature.c	2006-01-22 14:02:28.000000000 +1100
@@ -910,16 +910,18 @@
 	    macio->type != macio_intrepid)
 		return -ENODEV;
 
+	printk(KERN_DEBUG "Hard reset of PHY chip ...\n");
+
 	LOCK(flags);
 	MACIO_OUT8(KL_GPIO_ETH_PHY_RESET, KEYLARGO_GPIO_OUTPUT_ENABLE);
 	(void)MACIO_IN8(KL_GPIO_ETH_PHY_RESET);
 	UNLOCK(flags);
-	mdelay(10);
+	msleep(10);
 	LOCK(flags);
 	MACIO_OUT8(KL_GPIO_ETH_PHY_RESET, /*KEYLARGO_GPIO_OUTPUT_ENABLE | */
 		KEYLARGO_GPIO_OUTOUT_DATA);
 	UNLOCK(flags);
-	mdelay(10);
+	msleep(10);
 
 	return 0;
 }
Index: linux-work/drivers/net/sungem.c
===================================================================
--- linux-work.orig/drivers/net/sungem.c	2006-01-11 14:10:47.000000000 +1100
+++ linux-work/drivers/net/sungem.c	2006-01-22 14:02:28.000000000 +1100
@@ -1653,36 +1653,40 @@
 /* Init PHY interface and start link poll state machine */
 static void gem_init_phy(struct gem *gp)
 {
-	u32 mifcfg;
+	u32 mif_cfg;
 
 	/* Revert MIF CFG setting done on stop_phy */
-	mifcfg = readl(gp->regs + MIF_CFG);
-	mifcfg &= ~MIF_CFG_BBMODE;
-	writel(mifcfg, gp->regs + MIF_CFG);
+	mif_cfg = readl(gp->regs + MIF_CFG);
+	mif_cfg &= ~(MIF_CFG_PSELECT|MIF_CFG_POLL|MIF_CFG_BBMODE|MIF_CFG_MDI1);
+	mif_cfg |= MIF_CFG_MDI0;
+	writel(mif_cfg, gp->regs + MIF_CFG);
+	writel(PCS_DMODE_MGM, gp->regs + PCS_DMODE);
+	writel(MAC_XIFCFG_OE, gp->regs + MAC_XIFCFG);
 	
 	if (gp->pdev->vendor == PCI_VENDOR_ID_APPLE) {
 		int i;
+		u16 ctrl;
 
-		/* Those delay sucks, the HW seem to love them though, I'll
-		 * serisouly consider breaking some locks here to be able
-		 * to schedule instead
-		 */
-		for (i = 0; i < 3; i++) {
 #ifdef CONFIG_PPC_PMAC
-			pmac_call_feature(PMAC_FTR_GMAC_PHY_RESET, gp->of_node, 0, 0);
-			msleep(20);
+		pmac_call_feature(PMAC_FTR_GMAC_PHY_RESET, gp->of_node, 0, 0);
 #endif
-			/* Some PHYs used by apple have problem getting back to us,
-			 * we do an additional reset here
-			 */
-			phy_write(gp, MII_BMCR, BMCR_RESET);
-			msleep(20);
-			if (phy_read(gp, MII_BMCR) != 0xffff)
+
+		/* Some PHYs used by apple have problem getting back
+		 * to us, we do an additional reset here
+		 */
+		phy_write(gp, MII_BMCR, BMCR_RESET);
+		for (i = 0; i < 50; i++) {
+			if ((phy_read(gp, MII_BMCR) & BMCR_RESET) == 0)
 				break;
-			if (i == 2)
-				printk(KERN_WARNING "%s: GMAC PHY not responding !\n",
-				       gp->dev->name);
+			msleep(10);
 		}
+		if (i == 50)
+			printk(KERN_WARNING "%s: GMAC PHY not responding !\n",
+			       gp->dev->name);
+		/* Make sure isolate is off */
+		ctrl = phy_read(gp, MII_BMCR);
+		if (ctrl & BMCR_ISOLATE)
+			phy_write(gp, MII_BMCR, ctrl & ~BMCR_ISOLATE);
 	}
 
 	if (gp->pdev->vendor == PCI_VENDOR_ID_SUN &&
@@ -2119,7 +2123,7 @@
 /* Must be invoked with no lock held. */
 static void gem_stop_phy(struct gem *gp, int wol)
 {
-	u32 mifcfg;
+	u32 mif_cfg;
 	unsigned long flags;
 
 	/* Let the chip settle down a bit, it seems that helps
@@ -2130,9 +2134,9 @@
 	/* Make sure we aren't polling PHY status change. We
 	 * don't currently use that feature though
 	 */
-	mifcfg = readl(gp->regs + MIF_CFG);
-	mifcfg &= ~MIF_CFG_POLL;
-	writel(mifcfg, gp->regs + MIF_CFG);
+	mif_cfg = readl(gp->regs + MIF_CFG);
+	mif_cfg &= ~MIF_CFG_POLL;
+	writel(mif_cfg, gp->regs + MIF_CFG);
 
 	if (wol && gp->has_wol) {
 		unsigned char *e = &gp->dev->dev_addr[0];
@@ -2182,7 +2186,8 @@
 		/* According to Apple, we must set the MDIO pins to this begnign
 		 * state or we may 1) eat more current, 2) damage some PHYs
 		 */
-		writel(mifcfg | MIF_CFG_BBMODE, gp->regs + MIF_CFG);
+		mif_cfg = 0;
+		writel(mif_cfg | MIF_CFG_BBMODE, gp->regs + MIF_CFG);
 		writel(0, gp->regs + MIF_BBCLK);
 		writel(0, gp->regs + MIF_BBDATA);
 		writel(0, gp->regs + MIF_BBOENAB);


