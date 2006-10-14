Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161044AbWJNIMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161044AbWJNIMu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 04:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161038AbWJNIMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 04:12:50 -0400
Received: from msr23.hinet.net ([168.95.4.123]:10369 "EHLO msr23.hinet.net")
	by vger.kernel.org with ESMTP id S1161023AbWJNIMs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 04:12:48 -0400
Subject: [PATCH 4/5] Correct initial and close hardware step.
From: Jesse Huang <jesse@icplus.com.tw>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org,
       jgarzik@pobox.com, jesse@icplus.com.tw
Content-Type: text/plain
Date: Sat, 14 Oct 2006 15:57:08 -0400
Message-Id: <1160855828.2266.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Huang <jesse@icplus.com.tw>

Change Logs:
Correct initial and close hardware step. In some embedded system down and up
IP100A will cause DMA crash. We add some for safe down and up IP100A.

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



