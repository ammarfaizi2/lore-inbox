Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271020AbUJVBNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271020AbUJVBNf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 21:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271169AbUJVBGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 21:06:21 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:36869 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S271157AbUJVBBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 21:01:30 -0400
Date: Thu, 21 Oct 2004 21:02:31 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       romieu@fr.zoreil.com
Subject: [patch netdev-2.6 2/2] r8169: fix RxVlan bit manipulation
Message-ID: <20041022010231.GC1945@tuxdriver.com>
Mail-Followup-To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
	jgarzik@pobox.com, romieu@fr.zoreil.com
References: <20041022005737.GA1945@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022005737.GA1945@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix manipulation of RxVlan bit in rtl8169_vlan_rx_register(), and
remove it from rtl8169_vlan_rx_kill_vid().

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/r8169.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

--- netdev-2.6/drivers/net/r8169.c.netdev	2004-10-21 14:38:16.000000000 -0400
+++ netdev-2.6/drivers/net/r8169.c	2004-10-21 14:44:22.968783027 -0400
@@ -705,8 +705,10 @@ static void rtl8169_vlan_rx_register(str
 	unsigned long flags;
 
 	spin_lock_irqsave(&tp->lock, flags);
-	tp->vlgrp = grp;
-	tp->cp_cmd |= RxVlan;
+	if ((tp->vlgrp = grp))
+		tp->cp_cmd |= RxVlan;
+	else
+		tp->cp_cmd &= ~RxVlan;
 	RTL_W16(CPlusCmd, tp->cp_cmd);
 	RTL_R16(CPlusCmd);
 	spin_unlock_irqrestore(&tp->lock, flags);
@@ -715,13 +717,9 @@ static void rtl8169_vlan_rx_register(str
 static void rtl8169_vlan_rx_kill_vid(struct net_device *dev, unsigned short vid)
 {
 	struct rtl8169_private *tp = netdev_priv(dev);
-	void __iomem *ioaddr = tp->mmio_addr;
 	unsigned long flags;
 
 	spin_lock_irqsave(&tp->lock, flags);
-	tp->cp_cmd &= ~RxVlan;
-	RTL_W16(CPlusCmd, tp->cp_cmd);
-	RTL_R16(CPlusCmd);
 	if (tp->vlgrp)
 		tp->vlgrp->vlan_devices[vid] = NULL;
 	spin_unlock_irqrestore(&tp->lock, flags);
