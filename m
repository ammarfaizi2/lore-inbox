Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbWINC7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWINC7W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 22:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWINC7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 22:59:21 -0400
Received: from msr15.hinet.net ([168.95.4.115]:25571 "EHLO msr15.hinet.net")
	by vger.kernel.org with ESMTP id S1751047AbWINC7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 22:59:20 -0400
Subject: [PATCH 3/4] IP100A: Correct initial and close hardware step.
	2006-08-24
From: Jesse Huang <jesse@icplus.com.tw>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org,
       jgarzik@pobox.com, jesse@icplus.com.tw
Content-Type: text/plain
Date: Thu, 14 Sep 2006 10:45:33 -0400
Message-Id: <1158245133.2184.4.camel@localhost.localdomain>
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



