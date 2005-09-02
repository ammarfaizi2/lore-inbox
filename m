Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161111AbVIBW7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161111AbVIBW7I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 18:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161115AbVIBW7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 18:59:07 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:14216 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1161111AbVIBW7E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 18:59:04 -0400
Date: Sat, 3 Sep 2005 00:56:57 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pascal.chapperon@wanadoo.fr,
       lars.vahlenberg@mandator.com, Alexey Dobriyan <adobriyan@gmail.com>,
       apatard@mandriva.com, jgarzik@pobox.com, akpm@osdl.org
Subject: [patch 2.6.13-git3 4/5] sis190: RGMII Tx internal delay fiddling
Message-ID: <20050902225657.GE25687@electric-eye.fr.zoreil.com>
References: <20050902225224.GA25687@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050902225224.GA25687@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't ask.
The patch is based on SiS's GPLed driver.

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

diff -puN a/drivers/net/sis190.c~sis190-200 b/drivers/net/sis190.c
--- a/drivers/net/sis190.c~sis190-200	2005-09-02 23:27:58.126761637 +0200
+++ b/drivers/net/sis190.c	2005-09-02 23:27:58.130760990 +0200
@@ -273,7 +273,8 @@ enum sis190_eeprom_address {
 
 enum sis190_feature {
 	F_HAS_RGMII	= 1,
-	F_PHY_88E1111	= 2
+	F_PHY_88E1111	= 2,
+	F_PHY_BCM5461	= 4
 };
 
 struct sis190_private {
@@ -321,7 +322,7 @@ static struct mii_chip_info {
         unsigned int type;
 	u32 feature;
 } mii_chip_table[] = {
-	{ "Broadcom PHY BCM5461", { 0x0020, 0x60c0 }, LAN, 0 },
+	{ "Broadcom PHY BCM5461", { 0x0020, 0x60c0 }, LAN, F_PHY_BCM5461 },
 	{ "Agere PHY ET1101B",    { 0x0282, 0xf010 }, LAN, 0 },
 	{ "Marvell PHY 88E1111",  { 0x0141, 0x0cc0 }, LAN, F_PHY_88E1111 },
 	{ "Realtek PHY RTL8201",  { 0x0000, 0x8200 }, LAN, 0 },
@@ -960,8 +961,22 @@ static void sis190_phy_task(void * data)
 
 		p->ctl |= SIS_R32(StationControl) & ~0x0f001c00;
 
+		if ((tp->features & F_HAS_RGMII) &&
+		    (tp->features & F_PHY_BCM5461)) {
+			// Set Tx Delay in RGMII mode.
+			mdio_write(ioaddr, phy_id, 0x18, 0xf1c7);
+			udelay(200);
+			mdio_write(ioaddr, phy_id, 0x1c, 0x8c00);
+			p->ctl |= 0x03000000;
+		}
+
 		SIS_W32(StationControl, p->ctl);
 
+		if (tp->features & F_HAS_RGMII) {
+			SIS_W32(RGDelay, 0x0441);
+			SIS_W32(RGDelay, 0x0440);
+		}
+
 		net_link(tp, KERN_INFO "%s: link on %s mode.\n", dev->name,
 			 p->msg);
 		netif_carrier_on(dev);

_
