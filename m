Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932664AbWJBGkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664AbWJBGkp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 02:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932659AbWJBGkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 02:40:45 -0400
Received: from msr20.hinet.net ([168.95.4.120]:61381 "EHLO msr20.hinet.net")
	by vger.kernel.org with ESMTP id S932666AbWJBGko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 02:40:44 -0400
Subject: [PATCH 4/5] Correct initial and close hardware step.
From: Jesse Huang <jesse@icplus.com.tw>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org,
       jgarzik@pobox.com, jesse@icplus.com.tw
Content-Type: text/plain
Date: Mon, 02 Oct 2006 14:26:00 -0400
Message-Id: <1159813560.2576.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Huang <jesse@icplus.com.tw>

Change Logs:
Correct initial and close hardware step.

Signed-off-by: Jesse Huang <jesse@icplus.com.tw>
---

 drivers/net/sundance.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

1bbb3f6231fa1f52a9f61e299f22610d357f6041
diff --git a/drivers/net/sundance.c b/drivers/net/sundance.c
index 679eda4..14b4933 100755
--- a/drivers/net/sundance.c
+++ b/drivers/net/sundance.c
@@ -789,6 +789,7 @@ static int netdev_open(struct net_device
 {
 	struct netdev_private *np = netdev_priv(dev);
 	void __iomem *ioaddr = np->base;
+	unsigned long flags;
 	int i;
 
 	/* Do we need to reset the chip??? */
@@ -833,6 +834,10 @@ #endif
 		iowrite8(0x01, ioaddr + DebugCtrl1);
 	netif_start_queue(dev);
 
+	spin_lock_irqsave(&np->lock, flags);
+	reset_tx(dev);
+	spin_unlock_irqrestore(&np->lock, flags);
+
 	iowrite16 (StatsEnable | RxEnable | TxEnable, ioaddr + MACCtrl1);
 
 	if (netif_msg_ifup(np))
@@ -1652,6 +1657,9 @@ static int netdev_close(struct net_devic
 	/* Disable interrupts by clearing the interrupt mask. */
 	iowrite16(0x0000, ioaddr + IntrEnable);
 
+	/* Disable Rx and Tx DMA for safely release resource */
+	iowrite32(0x500, ioaddr + DMACtrl);
+
 	/* Stop the chip's Tx and Rx processes. */
 	iowrite16(TxDisable | RxDisable | StatsDisable, ioaddr + MACCtrl1);
 
-- 
1.3.GIT



