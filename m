Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751820AbWCLVVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbWCLVVx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 16:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWCLVVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 16:21:53 -0500
Received: from cassiel.sirena.org.uk ([80.68.93.111]:29962 "EHLO
	cassiel.sirena.org.uk") by vger.kernel.org with ESMTP
	id S1751770AbWCLVVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 16:21:49 -0500
Message-Id: <20060312205305.629183000@mercator.sirena.org.uk>
References: <20060312192259.929734000@mercator.sirena.org.uk>
Date: Sun, 12 Mar 2006 19:23:03 +0000
From: Mark Brown <broonie@sirena.org.uk>
To: Tim Hockin <thockin@hockin.org>, Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 4/4] natsemi: Add quirks for Aculab E1/T1 PMXc cPCI carrier cards
Content-Disposition: inline; filename=natsemi-aculab-cpci-carrier.patch
X-Spam-Score: -2.4 (--)
X-Spam-Report: Spam detection software, running on the system "cassiel.sirena.org.uk", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Aculab E1/T1 PMXc cPCI carrier card cards present a
	natsemi on the cPCI bus wired up in a non-standard fashion. This patch
	provides support in the natsemi driver for these cards by implementing
	a quirk mechanism and using that to configure appropriate settings for
	the card: forcing 100M full duplex, having a large EEPROM and using the
	MII port while ignoring PHYs. [...] 
	Content analysis details:   (-2.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.0 UPPERCASE_25_50        message body is 25-50% uppercase
	0.1 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aculab E1/T1 PMXc cPCI carrier card cards present a natsemi on the cPCI
bus wired up in a non-standard fashion.  This patch provides support in
the natsemi driver for these cards by implementing a quirk mechanism and
using that to configure appropriate settings for the card: forcing 100M
full duplex, having a large EEPROM and using the MII port while ignoring
PHYs.

Signed-off-by: Mark Brown <broonie@sirena.org.uk>

Index: natsemi-queue/drivers/net/natsemi.c
===================================================================
--- natsemi-queue.orig/drivers/net/natsemi.c	2006-02-25 17:41:59.000000000 +0000
+++ natsemi-queue/drivers/net/natsemi.c	2006-03-08 21:44:12.000000000 +0000
@@ -226,7 +226,6 @@ static int full_duplex[MAX_UNITS];
 				 NATSEMI_PG1_NREGS)
 #define NATSEMI_REGS_VER	1 /* v1 added RFDR registers */
 #define NATSEMI_REGS_SIZE	(NATSEMI_NREGS * sizeof(u32))
-#define NATSEMI_DEF_EEPROM_SIZE	24 /* 12 16-bit values */
 
 /* Buffer sizes:
  * The nic writes 32-bit values, even if the upper bytes of
@@ -344,12 +343,14 @@ None characterised.
 
 
 
-enum pcistuff {
+enum natsemi_quirks {
 	PCI_USES_IO = 0x01,
 	PCI_USES_MEM = 0x02,
 	PCI_USES_MASTER = 0x04,
 	PCI_ADDR0 = 0x08,
 	PCI_ADDR1 = 0x10,
+	MEDIA_FORCE_100FD = 0x20,
+	MEDIA_IGNORE_PHY = 0x40,
 };
 
 /* MMIO operations required */
@@ -367,17 +368,21 @@ enum pcistuff {
 #define MII_FX_SEL	0x0001	/* 100BASE-FX (fiber) */
 #define MII_EN_SCRM	0x0004	/* enable scrambler (tp) */
 
- 
 /* array of board data directly indexed by pci_tbl[x].driver_data */
 static const struct {
 	const char *name;
 	unsigned long flags;
+	int quirks;
+	int eeprom_size;
 } natsemi_pci_info[] __devinitdata = {
-	{ "NatSemi DP8381[56]", PCI_IOTYPE },
+	{ "NatSemi DP8381[56]", PCI_IOTYPE, 0, 24 },
+	{ "Aculab E1/T1 PMXc cPCI carrier card", PCI_IOTYPE,
+	                          MEDIA_FORCE_100FD | MEDIA_IGNORE_PHY, 128 },
 };
 
 static struct pci_device_id natsemi_pci_tbl[] = {
-	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_83815, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_83815, PCI_VENDOR_ID_ACULAB, PCI_SUBDEVICE_ID_ACULAB_174, 0, 0, 1 },
+	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_83815, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, natsemi_pci_tbl);
@@ -815,6 +820,39 @@ static void move_int_phy(struct net_devi
 	udelay(1);
 }
 
+static void __devinit natsemi_init_media (struct net_device *dev)
+{
+	struct netdev_private *np = netdev_priv(dev);
+	u32 tmp;
+
+	tmp            = mdio_read(dev, MII_BMCR);
+	np->speed      = (tmp & BMCR_SPEED100)? SPEED_100     : SPEED_10;
+	np->duplex     = (tmp & BMCR_FULLDPLX)? DUPLEX_FULL   : DUPLEX_HALF;
+	np->autoneg    = (tmp & BMCR_ANENABLE)? AUTONEG_ENABLE: AUTONEG_DISABLE;
+	np->advertising= mdio_read(dev, MII_ADVERTISE);
+
+	if ((np->advertising & ADVERTISE_ALL) != ADVERTISE_ALL
+	 && netif_msg_probe(np)) {
+		printk(KERN_INFO "natsemi %s: Transceiver default autonegotiation %s "
+			"10%s %s duplex.\n",
+			pci_name(np->pci_dev),
+			(mdio_read(dev, MII_BMCR) & BMCR_ANENABLE)?
+			  "enabled, advertise" : "disabled, force",
+			(np->advertising &
+			  (ADVERTISE_100FULL|ADVERTISE_100HALF))?
+			    "0" : "",
+			(np->advertising &
+			  (ADVERTISE_100FULL|ADVERTISE_10FULL))?
+			    "full" : "half");
+	}
+	if (netif_msg_probe(np))
+		printk(KERN_INFO
+			"natsemi %s: Transceiver status %#04x advertising %#04x.\n",
+			pci_name(np->pci_dev), mdio_read(dev, MII_BMSR),
+			np->advertising);
+
+}
+
 static int __devinit natsemi_probe1 (struct pci_dev *pdev,
 	const struct pci_device_id *ent)
 {
@@ -894,17 +932,21 @@ static int __devinit natsemi_probe1 (str
 	np->msg_enable = (debug >= 0) ? (1<<debug)-1 : NATSEMI_DEF_MSG;
 	np->hands_off = 0;
 	np->intr_status = 0;
-	np->eeprom_size = NATSEMI_DEF_EEPROM_SIZE;
+	np->eeprom_size = natsemi_pci_info[chip_idx].eeprom_size;
 
 	option = find_cnt < MAX_UNITS ? options[find_cnt] : 0;
 	if (dev->mem_start)
 		option = dev->mem_start;
 
 	/* Ignore the PHY status? */
-	if (option & 0x400) {
+	if (natsemi_pci_info[chip_idx].quirks & MEDIA_IGNORE_PHY) {
 		np->ignore_phy = 1;
 	} else {
-		np->ignore_phy = 0;
+		if (option & 0x400) {
+			np->ignore_phy = 1;
+		} else {
+			np->ignore_phy = 0;
+		}
 	}
 
 	/* Initial port:
@@ -936,6 +978,12 @@ static int __devinit natsemi_probe1 (str
 		np->phy_addr_external = PHY_ADDR_INTERNAL;
 	}
 
+	/* Apply any speed quirks. */
+	if (natsemi_pci_info[chip_idx].quirks & MEDIA_FORCE_100FD) {
+		np->speed = 100;
+		np->duplex = 1;
+	}
+
 	/* The lower four bits are the media type. */
 	if (option) {
 		if (option & 0x200)
@@ -974,32 +1022,10 @@ static int __devinit natsemi_probe1 (str
 	else
 		netif_carrier_off(dev);
 
-	/* get the initial settings from hardware */
-	tmp            = mdio_read(dev, MII_BMCR);
-	np->speed      = (tmp & BMCR_SPEED100)? SPEED_100     : SPEED_10;
-	np->duplex     = (tmp & BMCR_FULLDPLX)? DUPLEX_FULL   : DUPLEX_HALF;
-	np->autoneg    = (tmp & BMCR_ANENABLE)? AUTONEG_ENABLE: AUTONEG_DISABLE;
-	np->advertising= mdio_read(dev, MII_ADVERTISE);
-
-	if ((np->advertising & ADVERTISE_ALL) != ADVERTISE_ALL
-	 && netif_msg_probe(np)) {
-		printk(KERN_INFO "natsemi %s: Transceiver default autonegotiation %s "
-			"10%s %s duplex.\n",
-			pci_name(np->pci_dev),
-			(mdio_read(dev, MII_BMCR) & BMCR_ANENABLE)?
-			  "enabled, advertise" : "disabled, force",
-			(np->advertising &
-			  (ADVERTISE_100FULL|ADVERTISE_100HALF))?
-			    "0" : "",
-			(np->advertising &
-			  (ADVERTISE_100FULL|ADVERTISE_10FULL))?
-			    "full" : "half");
-	}
-	if (netif_msg_probe(np))
-		printk(KERN_INFO
-			"natsemi %s: Transceiver status %#04x advertising %#04x.\n",
-			pci_name(np->pci_dev), mdio_read(dev, MII_BMSR),
-			np->advertising);
+	/* get the initial settings from hardware if we don't have any
+ 	 * already */
+	if (!np->speed)
+		natsemi_init_media(dev);
 
 	/* save the silicon revision for later querying */
 	np->srr = readl(ioaddr + SiliconRev);
Index: natsemi-queue/include/linux/pci_ids.h
===================================================================
--- natsemi-queue.orig/include/linux/pci_ids.h	2006-02-25 19:19:55.000000000 +0000
+++ natsemi-queue/include/linux/pci_ids.h	2006-02-25 19:21:28.000000000 +0000
@@ -1573,6 +1573,7 @@
 #define PCI_DEVICE_ID_NVIDIA_SGS_RIVA128 0x0018
 
 #define PCI_VENDOR_ID_ACULAB 0x12d9
+#define PCI_SUBDEVICE_ID_ACULAB_174      0x000c
 
 #define PCI_SUBVENDOR_ID_CHASE_PCIFAST		0x12E0
 #define PCI_SUBDEVICE_ID_CHASE_PCIFAST4		0x0031

--
"You grabbed my hand and we fell into it, like a daydream - or a fever."
