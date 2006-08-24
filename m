Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWHXIBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWHXIBe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 04:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWHXIBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 04:01:33 -0400
Received: from msr27.hinet.net ([168.95.4.127]:21149 "EHLO msr27.hinet.net")
	by vger.kernel.org with ESMTP id S1750702AbWHXIBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 04:01:33 -0400
Subject: [PATCH 3/4] IP100A: Correct initial and close hardware step.
	2006-08-24
From: Jesse Huang <jesse@icplus.com.tw>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org,
       jgarzik@pobox.com, jesse@icplus.com.tw
Content-Type: text/plain
Date: Thu, 24 Aug 2006 15:48:37 -0400
Message-Id: <1156448917.20424.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Jesse Huang <jesse@icplus.com.tw>

Change Logs:
   - Correct initial and close hardware step.

Signed-off-by: Jesse Huang <jesse@icplus.com.tw>

---

 drivers/net/sundance.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

419599b10f1253ccd7224bbd369924307e1e5bb6
diff --git a/drivers/net/sundance.c b/drivers/net/sundance.c
index dd41ee2..04ad4d8 100755
--- a/drivers/net/sundance.c
+++ b/drivers/net/sundance.c
@@ -787,6 +787,7 @@ static int netdev_open(struct net_device
 {
 	struct netdev_private *np = netdev_priv(dev);
 	void __iomem *ioaddr = np->base;
+	unsigned long flags;
 	int i;
 
 	/* Do we need to reset the chip??? */
@@ -831,6 +832,10 @@ #endif
 		iowrite8(0x01, ioaddr + DebugCtrl1);
 	netif_start_queue(dev);
 
+	spin_lock_irqsave(&np->lock, flags);
+	reset_tx(dev);
+	spin_unlock_irqrestore(&np->lock, flags);
+
 	iowrite16 (StatsEnable | RxEnable | TxEnable, ioaddr + MACCtrl1);
 
 	if (netif_msg_ifup(np))
@@ -1656,6 +1661,9 @@ static int netdev_close(struct net_devic
 	/* Disable interrupts by clearing the interrupt mask. */
 	iowrite16(0x0000, ioaddr + IntrEnable);
 
+	/* Disable Rx and Tx DMA for safely release resource */
+	iowrite32(0x500, ioaddr + DMACtrl);
+
 	/* Stop the chip's Tx and Rx processes. */
 	iowrite16(TxDisable | RxDisable | StatsDisable, ioaddr + MACCtrl1);
 
-- 
1.3.GIT



