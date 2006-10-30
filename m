Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422757AbWJ3XuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422757AbWJ3XuF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 18:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422756AbWJ3XuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 18:50:05 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:33935 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S932280AbWJ3XuE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 18:50:04 -0500
Date: Tue, 31 Oct 2006 00:44:25 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tmattox@gmail.com, spiky.kiwi@gmail.com, r.bhatia@ipax.at
Subject: Re: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known regressions)
Message-ID: <20061030234425.GB6038@electric-eye.fr.zoreil.com>
References: <20061029223410.GA15413@electric-eye.fr.zoreil.com> <Pine.LNX.4.60.0610300032190.1435@poirot.grange> <20061030120158.GA28123@electric-eye.fr.zoreil.com> <Pine.LNX.4.60.0610302148560.9723@poirot.grange> <Pine.LNX.4.60.0610302214350.9723@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0610302214350.9723@poirot.grange>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guennadi Liakhovetski <g.liakhovetski@gmx.de> :
[...]
> The "seems" above was the key word. Once again I had a case, when after 
> re-compiling the kernel again with the disabled call to 
> __rtl8169_set_mac_addr only ping worked. And a power-off was required to 
> recover. So, that phy_reset doesn't seem to be very safe either.

Can you replace phy_reset by the patch below and try it twice ?

It's interesting to know if it does not always behave the same.

diff --git a/drivers/net/r8169.c b/drivers/net/r8169.c
index f1c7575..4b05dea 100644
--- a/drivers/net/r8169.c
+++ b/drivers/net/r8169.c
@@ -570,8 +570,8 @@ static void rtl8169_xmii_reset_enable(vo
 {
 	unsigned int val;
 
-	val = (mdio_read(ioaddr, MII_BMCR) | BMCR_RESET) & 0xffff;
-	mdio_write(ioaddr, MII_BMCR, val);
+	mdio_write(ioaddr, MII_BMCR, BMCR_RESET);
+	val = mdio_read(ioaddr, MII_BMCR);
 }
 
 static void rtl8169_check_link_status(struct net_device *dev,
@@ -1440,6 +1440,22 @@ static void rtl8169_release_board(struct
 	free_netdev(dev);
 }
 
+static void rtl8169_phy_reset(struct net_device *dev,
+			      struct rtl8169_private *tp)
+{
+	void __iomem *ioaddr = tp->mmio_addr;
+	int i;
+
+	tp->phy_reset_enable(ioaddr);
+	for (i = 0; i < 100; i++) {
+		if (!tp->phy_reset_pending(ioaddr))
+			return;
+		msleep(1);
+	}
+	if (netif_msg_link(tp))
+		printk(KERN_ERR "%s: PHY reset failed.\n", dev->name);
+}
+
 static void rtl8169_init_phy(struct net_device *dev, struct rtl8169_private *tp)
 {
 	void __iomem *ioaddr = tp->mmio_addr;
@@ -1468,6 +1484,8 @@ static void rtl8169_init_phy(struct net_
 
 	rtl8169_link_option(board_idx, &autoneg, &speed, &duplex);
 
+	rtl8169_phy_reset(dev, tp);
+
 	rtl8169_set_speed(dev, autoneg, speed, duplex);
 
 	if ((RTL_R8(PHYstatus) & TBI_Enable) && netif_msg_link(tp))
