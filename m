Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030391AbWJ2Wim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbWJ2Wim (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 17:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030397AbWJ2Wim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 17:38:42 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:45770 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1030391AbWJ2Wil
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 17:38:41 -0500
Date: Sun, 29 Oct 2006 23:34:10 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tmattox@gmail.com, spiky.kiwi@gmail.com, r.bhatia@ipax.at
Subject: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known regressions)
Message-ID: <20061029223410.GA15413@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610291211160.25218@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> :
[regression related to r8169 MAC address change]
> Francois ? Jeff ?

Go revert it.

Despite what I claimed, I can not find a third-party confirmation by email
that it works elsewhere.

It would probably be enough to remove the call to __rtl8169_set_mac_addr()
in rtl8169_hw_start() though.

In place of the test suggested in bugzilla, I'd rather see Guennadi test
the thing below (acked on netdev by the initial victim if someone wonders
why it has not changed the status of bugzilla so far):

>From f092d907f78e81846dfaf1008a6409c3c4b58f27 Mon Sep 17 00:00:00 2001
From: Francois Romieu <romieu@fr.zoreil.com>
Date: Sat, 21 Oct 2006 21:07:36 +0200
Subject: [PATCH] r8169: perform a PHY reset before any other operation at boot time

Realtek's 8139/810x (0x8136) PCI-E comes with a touchy PHY.
A big heavy reset seems to calm it down.

Fix for http://bugzilla.kernel.org/show_bug.cgi?id=7378.

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>
Signed-off-by: Darren Salt <linux@youmustbejoking.demon.co.uk>
---
 drivers/net/r8169.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/net/r8169.c b/drivers/net/r8169.c
index f1c7575..927fc17 100644
--- a/drivers/net/r8169.c
+++ b/drivers/net/r8169.c
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
-- 
1.4.2.4
