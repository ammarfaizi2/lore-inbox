Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWAVC71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWAVC71 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 21:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWAVC71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 21:59:27 -0500
Received: from gate.crashing.org ([63.228.1.57]:44944 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751259AbWAVC71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 21:59:27 -0500
Subject: [PATCH] sungem: Make PM of PHYs more reliable
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 22 Jan 2006 13:59:07 +1100
Message-Id: <1137898747.12998.93.camel@localhost.localdomain>
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

Dave, please send to Linus if you are ok with it.

Index: linux-work/arch/powerpc/platforms/powermac/feature.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/feature.c	2006-01-11 12:56:21.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/feature.c	2006-01-11 13:42:24.000000000 +1100
@@ -914,12 +914,12 @@
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
--- linux-work.orig/drivers/net/sungem.c	2005-12-29 10:24:58.000000000 +1100
+++ linux-work/drivers/net/sungem.c	2006-01-11 13:50:06.000000000 +1100
@@ -1662,27 +1662,28 @@
 	
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
+		for (i = 0; i < 10; i++) {
+			if ((phy_read(gp, MII_BMCR) & BMCR_RESET) == 0)
 				break;
-			if (i == 2)
-				printk(KERN_WARNING "%s: GMAC PHY not responding !\n",
-				       gp->dev->name);
+			msleep(10);
 		}
+		if (i == 10)
+			printk(KERN_WARNING "%s: GMAC PHY not responding !\n",
+			       gp->dev->name);
+		/* Make sure isolate is off */
+		ctrl = phy_read(gp, MII_BMCR);
+		if (ctrl & BMCR_ISOLATE)
+			phy_write(gp, MII_BMCR, ctrl & ~BMCR_ISOLATE);
 	}
 
 	if (gp->pdev->vendor == PCI_VENDOR_ID_SUN &&


