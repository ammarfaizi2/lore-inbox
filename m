Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbVF0Bn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVF0Bn0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 21:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbVF0BnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 21:43:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:2179 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261698AbVF0Bm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 21:42:56 -0400
Subject: [PATCH] ppc64: Add new PHY to sungem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 27 Jun 2005 11:38:09 +1000
Message-Id: <1119836289.5133.61.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch adds support for some new PHY models to sungem as used on
some recent Apple iMac G5 models.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/net/sungem.c
===================================================================
--- linux-work.orig/drivers/net/sungem.c	2005-05-02 10:48:28.000000000 +1000
+++ linux-work/drivers/net/sungem.c	2005-06-14 10:17:38.000000000 +1000
@@ -3078,7 +3078,9 @@
 	gp->phy_mii.dev = dev;
 	gp->phy_mii.mdio_read = _phy_read;
 	gp->phy_mii.mdio_write = _phy_write;
-
+#ifdef CONFIG_PPC_PMAC
+	gp->phy_mii.platform_data = gp->of_node;
+#endif
 	/* By default, we start with autoneg */
 	gp->want_autoneg = 1;
 
Index: linux-work/drivers/net/sungem_phy.c
===================================================================
--- linux-work.orig/drivers/net/sungem_phy.c	2005-05-02 10:48:28.000000000 +1000
+++ linux-work/drivers/net/sungem_phy.c	2005-06-16 07:38:37.000000000 +1000
@@ -32,6 +32,10 @@
 #include <linux/ethtool.h>
 #include <linux/delay.h>
 
+#ifdef CONFIG_PPC_PMAC
+#include <asm/prom.h>
+#endif
+
 #include "sungem_phy.h"
 
 /* Link modes of the BCM5400 PHY */
@@ -281,10 +285,12 @@
 static int bcm5421_init(struct mii_phy* phy)
 {
 	u16 data;
-	int rev;
+	unsigned int id;
 
-	rev = phy_read(phy, MII_PHYSID2) & 0x000f;
-	if (rev == 0) {
+	id = (phy_read(phy, MII_PHYSID1) << 16 | phy_read(phy, MII_PHYSID2));
+
+	/* Revision 0 of 5421 needs some fixups */
+	if (id == 0x002060e0) {
 		/* This is borrowed from MacOS
 		 */
 		phy_write(phy, 0x18, 0x1007);
@@ -297,21 +303,28 @@
 		data = phy_read(phy, 0x15);
 		phy_write(phy, 0x15, data | 0x0200);
 	}
-#if 0
-	/* This has to be verified before I enable it */
-	/* Enable automatic low-power */
-	phy_write(phy, 0x1c, 0x9002);
-	phy_write(phy, 0x1c, 0xa821);
-	phy_write(phy, 0x1c, 0x941d);
-#endif
-	return 0;
-}
 
-static int bcm5421k2_init(struct mii_phy* phy)
-{
-	/* Init code borrowed from OF */
-	phy_write(phy, 4, 0x01e1);
-	phy_write(phy, 9, 0x0300);
+	/* Pick up some init code from OF for K2 version */
+	if ((id & 0xfffffff0) == 0x002062e0) {
+		phy_write(phy, 4, 0x01e1);
+		phy_write(phy, 9, 0x0300);
+	}
+
+	/* Check if we can enable automatic low power */
+#ifdef CONFIG_PPC_PMAC
+	if (phy->platform_data) {
+		struct device_node *np = of_get_parent(phy->platform_data);
+		int can_low_power = 1;
+		if (np == NULL || get_property(np, "no-autolowpower", NULL))
+			can_low_power = 0;
+		if (can_low_power) {
+			/* Enable automatic low-power */
+			phy_write(phy, 0x1c, 0x9002);
+			phy_write(phy, 0x1c, 0xa821);
+			phy_write(phy, 0x1c, 0x941d);
+		}
+	}
+#endif /* CONFIG_PPC_PMAC */
 
 	return 0;
 }
@@ -762,7 +775,7 @@
 
 /* Broadcom BCM 5421 built-in K2 */
 static struct mii_phy_ops bcm5421k2_phy_ops = {
-	.init		= bcm5421k2_init,
+	.init		= bcm5421_init,
 	.suspend	= bcm5411_suspend,
 	.setup_aneg	= bcm54xx_setup_aneg,
 	.setup_forced	= bcm54xx_setup_forced,
@@ -779,6 +792,25 @@
 	.ops		= &bcm5421k2_phy_ops
 };
 
+/* Broadcom BCM 5462 built-in Vesta */
+static struct mii_phy_ops bcm5462V_phy_ops = {
+	.init		= bcm5421_init,
+	.suspend	= bcm5411_suspend,
+	.setup_aneg	= bcm54xx_setup_aneg,
+	.setup_forced	= bcm54xx_setup_forced,
+	.poll_link	= genmii_poll_link,
+	.read_link	= bcm54xx_read_link,
+};
+
+static struct mii_phy_def bcm5462V_phy_def = {
+	.phy_id		= 0x002060d0,
+	.phy_id_mask	= 0xfffffff0,
+	.name		= "BCM5462-Vesta",
+	.features	= MII_GBIT_FEATURES,
+	.magic_aneg	= 1,
+	.ops		= &bcm5462V_phy_ops
+};
+
 /* Marvell 88E1101 (Apple seem to deal with 2 different revs,
  * I masked out the 8 last bits to get both, but some specs
  * would be useful here) --BenH.
@@ -824,6 +856,7 @@
 	&bcm5411_phy_def,
 	&bcm5421_phy_def,
 	&bcm5421k2_phy_def,
+	&bcm5462V_phy_def,
 	&marvell_phy_def,
 	&genmii_phy_def,
 	NULL
Index: linux-work/drivers/net/sungem_phy.h
===================================================================
--- linux-work.orig/drivers/net/sungem_phy.h	2005-05-02 10:48:28.000000000 +1000
+++ linux-work/drivers/net/sungem_phy.h	2005-06-14 10:16:14.000000000 +1000
@@ -43,9 +43,10 @@
 	int			pause;
 
 	/* Provided by host chip */
-	struct net_device*	dev;
+	struct net_device	*dev;
 	int (*mdio_read) (struct net_device *dev, int mii_id, int reg);
 	void (*mdio_write) (struct net_device *dev, int mii_id, int reg, int val);
+	void			*platform_data;
 };
 
 /* Pass in a struct mii_phy with dev, mdio_read and mdio_write


