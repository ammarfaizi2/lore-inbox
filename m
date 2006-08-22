Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWHVGnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWHVGnM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 02:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWHVGnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 02:43:12 -0400
Received: from msr53.hinet.net ([168.95.4.153]:52125 "EHLO msr53.hinet.net")
	by vger.kernel.org with ESMTP id S1751287AbWHVGnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 02:43:11 -0400
Subject: [PATCH 3/4] IP100A: Correct initial and close hardware step.
From: Jesse Huang <jesse@icplus.com.tw>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org,
       jgarzik@pobox.com, jesse@icplus.com.tw
Content-Type: text/plain
Date: Tue, 22 Aug 2006 14:30:26 -0400
Message-Id: <1156271426.4662.4.camel@localhost.localdomain>
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

 sundance.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

ddfaae9a0f4bd37c155f21fb4779093eef059bf6
diff --git a/sundance.c b/sundance.c
index 259c42f..424aebd 100755
--- a/sundance.c
+++ b/sundance.c
@@ -787,6 +787,7 @@ static int netdev_open(struct net_device
 {
 	struct netdev_private *np = netdev_priv(dev);
 	void __iomem *ioaddr = np->base;
+	unsigned long flags;
 	int i;
 
 	/* Do we need to reset the chip??? */
@@ -830,6 +831,10 @@ #endif
 	if (np->pci_rev_id >= 0x14)
 		iowrite8(0x01, ioaddr + DebugCtrl1);
 	netif_start_queue(dev);
+	
+	spin_lock_irqsave(&np->lock,flags);
+	reset_tx(dev);
+	spin_unlock_irqrestore(&np->lock,flags);
 
 	iowrite16 (StatsEnable | RxEnable | TxEnable, ioaddr + MACCtrl1);
 
@@ -1655,7 +1660,10 @@ static int netdev_close(struct net_devic
 
 	/* Disable interrupts by clearing the interrupt mask. */
 	iowrite16(0x0000, ioaddr + IntrEnable);
-
+	
+	/* Disable Rx and Tx DMA for safely release resource */
+	iowrite32(0x500, ioaddr + DMACtrl);
+	
 	/* Stop the chip's Tx and Rx processes. */
 	iowrite16(TxDisable | RxDisable | StatsDisable, ioaddr + MACCtrl1);
 
-- 
1.3.GIT



