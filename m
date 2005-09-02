Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161113AbVIBXKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161113AbVIBXKp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 19:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161122AbVIBXKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 19:10:45 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:52360 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1161113AbVIBXKo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 19:10:44 -0400
Date: Sat, 3 Sep 2005 00:55:27 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: netdev@vger.kernel.org
Cc: pascal.chapperon@wanadoo.fr, lars.vahlenberg@mandator.com,
       Alexey Dobriyan <adobriyan@gmail.com>, apatard@mandriva.com,
       jgarzik@pobox.com, akpm@osdl.org
Subject: [patch 2.6.13-git3 2/5] sis190: recent chipsets from SiS include a RGMII
Message-ID: <20050902225527.GC25687@electric-eye.fr.zoreil.com>
References: <20050902225224.GA25687@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050902225224.GA25687@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Extracted from SiS's GPLed driver. From the few pdf available at SiS's,
it seems that the 965 and the 966 south bridge include this interface
whereas the 965L (and anything below) does not. It is expected to be a
sis191 related feature and should not hurt the existing sis190 driver.

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

diff -puN a/drivers/net/sis190.c~sis190-180 b/drivers/net/sis190.c
--- a/drivers/net/sis190.c~sis190-180	2005-09-02 23:27:35.912352373 +0200
+++ b/drivers/net/sis190.c	2005-09-02 23:27:35.917351565 +0200
@@ -279,6 +279,11 @@ enum sis190_eeprom_address {
 	EEPROMMACAddr	= 0x03
 };
 
+enum sis190_feature {
+	F_HAS_RGMII	= 1,
+	F_PHY_88E1111	= 2
+};
+
 struct sis190_private {
 	void __iomem *mmio_addr;
 	struct pci_dev *pci_dev;
@@ -300,6 +305,7 @@ struct sis190_private {
 	u32 msg_enable;
 	struct mii_if_info mii_if;
 	struct list_head first_phy;
+	u32 features;
 };
 
 struct sis190_phy {
@@ -321,11 +327,12 @@ static struct mii_chip_info {
         const char *name;
         u16 id[2];
         unsigned int type;
+	u32 feature;
 } mii_chip_table[] = {
-	{ "Broadcom PHY BCM5461", { 0x0020, 0x60c0 }, LAN },
-	{ "Agere PHY ET1101B",    { 0x0282, 0xf010 }, LAN },
-	{ "Marvell PHY 88E1111",  { 0x0141, 0x0cc0 }, LAN },
-	{ "Realtek PHY RTL8201",  { 0x0000, 0x8200 }, LAN },
+	{ "Broadcom PHY BCM5461", { 0x0020, 0x60c0 }, LAN, 0 },
+	{ "Agere PHY ET1101B",    { 0x0282, 0xf010 }, LAN, 0 },
+	{ "Marvell PHY 88E1111",  { 0x0141, 0x0cc0 }, LAN, F_PHY_88E1111 },
+	{ "Realtek PHY RTL8201",  { 0x0000, 0x8200 }, LAN, 0 },
 	{ NULL, }
 };
 
@@ -1309,6 +1316,7 @@ static void sis190_init_phy(struct net_d
 		phy->type = (p->type == MIX) ?
 			((mii_status & (BMSR_100FULL | BMSR_100HALF)) ?
 				LAN : HOME) : p->type;
+		tp->features |= p->feature;
 	} else
 		phy->type = UNKNOWN;
 
@@ -1317,6 +1325,25 @@ static void sis190_init_phy(struct net_d
 		  (phy->type == UNKNOWN) ? "Unknown PHY" : p->name, phy_id);
 }
 
+static void sis190_mii_probe_88e1111_fixup(struct sis190_private *tp)
+{
+	if (tp->features & F_PHY_88E1111) {
+		void __iomem *ioaddr = tp->mmio_addr;
+		int phy_id = tp->mii_if.phy_id;
+		u16 reg[2][2] = {
+			{ 0x808b, 0x0ce1 },
+			{ 0x808f, 0x0c60 }
+		}, *p;
+
+		p = (tp->features & F_HAS_RGMII) ? reg[0] : reg[1];
+
+		mdio_write(ioaddr, phy_id, 0x1b, p[0]);
+		udelay(200);
+		mdio_write(ioaddr, phy_id, 0x14, p[1]);
+		udelay(200);
+	}
+}
+
 /**
  *	sis190_mii_probe - Probe MII PHY for sis190
  *	@dev: the net device to probe for
@@ -1367,6 +1394,8 @@ static int __devinit sis190_mii_probe(st
 	/* Select default PHY for mac */
 	sis190_default_phy(dev);
 
+	sis190_mii_probe_88e1111_fixup(tp);
+
 	mii_if->dev = dev;
 	mii_if->mdio_read = __mdio_read;
 	mii_if->mdio_write = __mdio_write;
@@ -1506,6 +1535,11 @@ static void sis190_tx_timeout(struct net
 	netif_wake_queue(dev);
 }
 
+static void sis190_set_rgmii(struct sis190_private *tp, u8 reg)
+{
+	tp->features |= (reg & 0x80) ? F_HAS_RGMII : 0;
+}
+
 static int __devinit sis190_get_mac_addr_from_eeprom(struct pci_dev *pdev,
 						     struct net_device *dev)
 {
@@ -1533,6 +1567,8 @@ static int __devinit sis190_get_mac_addr
 		((u16 *)dev->dev_addr)[0] = le16_to_cpu(w);
 	}
 
+	sis190_set_rgmii(tp, sis190_read_eeprom(ioaddr, EEPROMInfo));
+
 	return 0;
 }
 
@@ -1578,6 +1614,8 @@ static int __devinit sis190_get_mac_addr
 	outb(0x12, 0x78);
 	reg = inb(0x79);
 
+	sis190_set_rgmii(tp, reg);
+
 	/* Restore the value to ISA Bridge */
 	pci_write_config_byte(isa_bridge, 0x48, tmp8);
 	pci_dev_put(isa_bridge);
@@ -1800,6 +1838,9 @@ static int __devinit sis190_init_one(str
 	       dev->dev_addr[2], dev->dev_addr[3],
 	       dev->dev_addr[4], dev->dev_addr[5]);
 
+	net_probe(tp, KERN_INFO "%s: %s mode.\n", dev->name,
+		  (tp->features & F_HAS_RGMII) ? "RGMII" : "GMII");
+
 	netif_carrier_off(dev);
 
 	sis190_set_speed_auto(dev);

_
