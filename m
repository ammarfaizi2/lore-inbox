Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbVI3CZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbVI3CZh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 22:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbVI3CZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 22:25:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12202 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932419AbVI3CXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 22:23:36 -0400
Message-Id: <20050930022242.010635000@localhost.localdomain>
References: <20050930022016.640197000@localhost.localdomain>
Date: Thu, 29 Sep 2005 19:20:24 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Krzysztof Oledzki <olel@ans.pl>, Chris Wright <chrisw@osdl.org>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Stephen Hemminger <shemminger@osdl.org>
Subject: [PATCH 08/10] [PATCH] skge: set mac address oops with bonding
Content-Disposition: inline; filename=skge-set-mac-address-oops-with-bonding.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Here is the patch (fuzz removed) for 2.6.13.2 that fixes
OOPs when using bonding with skge.

Skge driver was bringing link up/down when changing mac
address.  This doesn't work in the bonding environment, and is
more effort than needed.

Fixes-bug: http://bugzilla.kernel.org/show_bug.cgi?id=5271
Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Sigend-off-by: Chris Wright <chrisw@osdl.org>
---
 drivers/net/skge.c |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

Index: linux-2.6.13.y/drivers/net/skge.c
===================================================================
--- linux-2.6.13.y.orig/drivers/net/skge.c
+++ linux-2.6.13.y/drivers/net/skge.c
@@ -2828,21 +2828,29 @@ static void skge_netpoll(struct net_devi
 static int skge_set_mac_address(struct net_device *dev, void *p)
 {
 	struct skge_port *skge = netdev_priv(dev);
-	struct sockaddr *addr = p;
-	int err = 0;
+	struct skge_hw *hw = skge->hw;
+	unsigned port = skge->port;
+	const struct sockaddr *addr = p;
 
 	if (!is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
 
-	skge_down(dev);
+	spin_lock_bh(&hw->phy_lock);
 	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
-	memcpy_toio(skge->hw->regs + B2_MAC_1 + skge->port*8,
+	memcpy_toio(hw->regs + B2_MAC_1 + port*8,
 		    dev->dev_addr, ETH_ALEN);
-	memcpy_toio(skge->hw->regs + B2_MAC_2 + skge->port*8,
+	memcpy_toio(hw->regs + B2_MAC_2 + port*8,
 		    dev->dev_addr, ETH_ALEN);
-	if (dev->flags & IFF_UP)
-		err = skge_up(dev);
-	return err;
+
+	if (hw->chip_id == CHIP_ID_GENESIS)
+		xm_outaddr(hw, port, XM_SA, dev->dev_addr);
+	else {
+		gma_set_addr(hw, port, GM_SRC_ADDR_1L, dev->dev_addr);
+		gma_set_addr(hw, port, GM_SRC_ADDR_2L, dev->dev_addr);
+	}
+	spin_unlock_bh(&hw->phy_lock);
+
+	return 0;
 }
 
 static const struct {

--
