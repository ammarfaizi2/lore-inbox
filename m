Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751803AbWCLVaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbWCLVaV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 16:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWCLVaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 16:30:21 -0500
Received: from cassiel.sirena.org.uk ([80.68.93.111]:41745 "EHLO
	cassiel.sirena.org.uk") by vger.kernel.org with ESMTP
	id S1750939AbWCLVaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 16:30:19 -0500
Message-Id: <20060312205303.869316000@mercator.sirena.org.uk>
References: <20060312192259.929734000@mercator.sirena.org.uk>
Date: Sun, 12 Mar 2006 19:23:00 +0000
From: Mark Brown <broonie@sirena.org.uk>
To: Tim Hockin <thockin@hockin.org>, Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 1/4] natsemi: Add support for using MII port with no PHY
Content-Disposition: inline; filename=natsemi-ignore-phy.patch
X-Spam-Score: -2.5 (--)
X-Spam-Report: Spam detection software, running on the system "cassiel.sirena.org.uk", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  This patch provides a module option which configures
	the natsemi driver to use the external MII port on the chip but ignore
	any PHYs that may be attached to it. The link state will be left as it
	was when the driver started and can be configured via ethtool. Any PHYs
	that are present can be accessed via the MII ioctl()s. [...] 
	Content analysis details:   (-2.5 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.1 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides a module option which configures the natsemi driver
to use the external MII port on the chip but ignore any PHYs that may be
attached to it.  The link state will be left as it was when the driver
started and can be configured via ethtool.  Any PHYs that are present
can be accessed via the MII ioctl()s.

This is useful for systems where the device is connected without a PHY
or where either information or actions outside the scope of the driver
are required in order to use the PHYs.

Signed-Off-By: Mark Brown <broonie@sirena.org.uk>

Index: natsemi-queue/drivers/net/natsemi.c
===================================================================
--- natsemi-queue.orig/drivers/net/natsemi.c	2006-02-25 13:38:34.000000000 +0000
+++ natsemi-queue/drivers/net/natsemi.c	2006-02-25 13:50:51.000000000 +0000
@@ -259,7 +259,7 @@ MODULE_PARM_DESC(debug, "DP8381x default
 MODULE_PARM_DESC(rx_copybreak, 
 	"DP8381x copy breakpoint for copy-only-tiny-frames");
 MODULE_PARM_DESC(options, 
-	"DP8381x: Bits 0-3: media type, bit 17: full duplex");
+	"DP8381x: Bits 0-3: media type, bit 17: full duplex, bit 18: ignore PHY");
 MODULE_PARM_DESC(full_duplex, "DP8381x full duplex setting(s) (1)");
 
 /*
@@ -690,6 +690,8 @@ struct netdev_private {
 	u32 intr_status;
 	/* Do not touch the nic registers */
 	int hands_off;
+	/* Don't pay attention to the reported link state. */
+	int ignore_phy;
 	/* external phy that is used: only valid if dev->if_port != PORT_TP */
 	int mii;
 	int phy_addr_external;
@@ -891,7 +893,19 @@ static int __devinit natsemi_probe1 (str
 	np->hands_off = 0;
 	np->intr_status = 0;
 
+	option = find_cnt < MAX_UNITS ? options[find_cnt] : 0;
+	if (dev->mem_start)
+		option = dev->mem_start;
+
+	/* Ignore the PHY status? */
+	if (option & 0x400) {
+		np->ignore_phy = 1;
+	} else {
+		np->ignore_phy = 0;
+	}
+
 	/* Initial port:
+	 * - If configured to ignore the PHY set up for external.
 	 * - If the nic was configured to use an external phy and if find_mii
 	 *   finds a phy: use external port, first phy that replies.
 	 * - Otherwise: internal port.
@@ -899,7 +913,7 @@ static int __devinit natsemi_probe1 (str
 	 * The address would be used to access a phy over the mii bus, but
 	 * the internal phy is accessed through mapped registers.
 	 */
-	if (readl(ioaddr + ChipConfig) & CfgExtPhy)
+	if (np->ignore_phy || readl(ioaddr + ChipConfig) & CfgExtPhy)
 		dev->if_port = PORT_MII;
 	else
 		dev->if_port = PORT_TP;
@@ -909,7 +923,9 @@ static int __devinit natsemi_probe1 (str
 
 	if (dev->if_port != PORT_TP) {
 		np->phy_addr_external = find_mii(dev);
-		if (np->phy_addr_external == PHY_ADDR_NONE) {
+		/* If we're ignoring the PHY it doesn't matter if we can't
+		 * find one. */
+		if (!np->ignore_phy && np->phy_addr_external == PHY_ADDR_NONE) {
 			dev->if_port = PORT_TP;
 			np->phy_addr_external = PHY_ADDR_INTERNAL;
 		}
@@ -917,10 +933,6 @@ static int __devinit natsemi_probe1 (str
 		np->phy_addr_external = PHY_ADDR_INTERNAL;
 	}
 
-	option = find_cnt < MAX_UNITS ? options[find_cnt] : 0;
-	if (dev->mem_start)
-		option = dev->mem_start;
-
 	/* The lower four bits are the media type. */
 	if (option) {
 		if (option & 0x200)
@@ -954,7 +966,10 @@ static int __devinit natsemi_probe1 (str
 	if (mtu)
 		dev->mtu = mtu;
 
-	netif_carrier_off(dev);
+	if (np->ignore_phy)
+		netif_carrier_on(dev);
+	else
+		netif_carrier_off(dev);
 
 	/* get the initial settings from hardware */
 	tmp            = mdio_read(dev, MII_BMCR);
@@ -1002,6 +1017,8 @@ static int __devinit natsemi_probe1 (str
 		printk("%02x, IRQ %d", dev->dev_addr[i], irq);
 		if (dev->if_port == PORT_TP)
 			printk(", port TP.\n");
+		else if (np->ignore_phy)
+			printk(", port MII, ignoring PHY\n");
 		else
 			printk(", port MII, phy ad %d.\n", np->phy_addr_external);
 	}
@@ -1682,42 +1699,44 @@ static void check_link(struct net_device
 {
 	struct netdev_private *np = netdev_priv(dev);
 	void __iomem * ioaddr = ns_ioaddr(dev);
-	int duplex;
+	int duplex = np->full_duplex;
 	u16 bmsr;
-       
-	/* The link status field is latched: it remains low after a temporary
-	 * link failure until it's read. We need the current link status,
-	 * thus read twice.
-	 */
-	mdio_read(dev, MII_BMSR);
-	bmsr = mdio_read(dev, MII_BMSR);
 
-	if (!(bmsr & BMSR_LSTATUS)) {
-		if (netif_carrier_ok(dev)) {
+	/* If we're not paying attention to the PHY status then don't check. */
+	if (!np->ignore_phy) {
+		/* The link status field is latched: it remains low
+		 * after a temporary link failure until it's read. We
+		 * need the current link status, thus read twice.
+		 */
+		mdio_read(dev, MII_BMSR);
+		bmsr = mdio_read(dev, MII_BMSR);
+
+		if (!(bmsr & BMSR_LSTATUS)) {
+			if (netif_carrier_ok(dev)) {
+				if (netif_msg_link(np))
+					printk(KERN_NOTICE "%s: link down.\n",
+					       dev->name);
+				netif_carrier_off(dev);
+				undo_cable_magic(dev);
+			}
+			return;
+		}
+		if (!netif_carrier_ok(dev)) {
 			if (netif_msg_link(np))
-				printk(KERN_NOTICE "%s: link down.\n",
-					dev->name);
-			netif_carrier_off(dev);
-			undo_cable_magic(dev);
+				printk(KERN_NOTICE "%s: link up.\n", dev->name);
+			netif_carrier_on(dev);
+			do_cable_magic(dev);
 		}
-		return;
-	}
-	if (!netif_carrier_ok(dev)) {
-		if (netif_msg_link(np))
-			printk(KERN_NOTICE "%s: link up.\n", dev->name);
-		netif_carrier_on(dev);
-		do_cable_magic(dev);
-	}
 
-	duplex = np->full_duplex;
-	if (!duplex) {
-		if (bmsr & BMSR_ANEGCOMPLETE) {
-			int tmp = mii_nway_result(
-				np->advertising & mdio_read(dev, MII_LPA));
-			if (tmp == LPA_100FULL || tmp == LPA_10FULL)
+		if (!duplex) {
+			if (bmsr & BMSR_ANEGCOMPLETE) {
+				int tmp = mii_nway_result(
+					np->advertising & mdio_read(dev, MII_LPA));
+				if (tmp == LPA_100FULL || tmp == LPA_10FULL)
+					duplex = 1;
+			} else if (mdio_read(dev, MII_BMCR) & BMCR_FULLDPLX)
 				duplex = 1;
-		} else if (mdio_read(dev, MII_BMCR) & BMCR_FULLDPLX)
-			duplex = 1;
+		}
 	}
 
 	/* if duplex is set then bit 28 must be set, too */
@@ -2927,6 +2946,16 @@ static int netdev_set_ecmd(struct net_de
 	}
 
 	/*
+	 * If we're ignoring the PHY then autoneg and the internal
+	 * transciever are really not going to work so don't let the
+	 * user select them.
+	 */
+	if (np->ignore_phy && (ecmd->autoneg == AUTONEG_ENABLE ||
+			       ecmd->port == PORT_INTERNAL)) {
+		return -EINVAL;
+	}
+
+	/*
 	 * maxtxpkt, maxrxpkt: ignored for now.
 	 *
 	 * transceiver:

--
"You grabbed my hand and we fell into it, like a daydream - or a fever."
