Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932668AbWJBGlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932668AbWJBGlW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 02:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932667AbWJBGlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 02:41:21 -0400
Received: from msr44.hinet.net ([168.95.4.144]:10927 "EHLO msr44.hinet.net")
	by vger.kernel.org with ESMTP id S932663AbWJBGlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 02:41:20 -0400
Subject: [PATCH 5/5] Solve host error problem in low performance embedded
	system when continune down and up.
From: Jesse Huang <jesse@icplus.com.tw>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org,
       jgarzik@pobox.com, jesse@icplus.com.tw
Content-Type: text/plain
Date: Mon, 02 Oct 2006 14:26:36 -0400
Message-Id: <1159813596.2576.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Huang <jesse@icplus.com.tw>

Change Logs:
Solve host error problem in low performance embedded system when continune down and up.

Signed-off-by: Jesse Huang <jesse@icplus.com.tw>
---

 drivers/net/sundance.c |   26 +++++++++++++++++++++++---
 1 files changed, 23 insertions(+), 3 deletions(-)

c06c70e20a85facd640528ca66e0b579fc3ee745
diff --git a/drivers/net/sundance.c b/drivers/net/sundance.c
index 14b4933..b4a6010 100755
--- a/drivers/net/sundance.c
+++ b/drivers/net/sundance.c
@@ -1643,6 +1643,14 @@ static int netdev_close(struct net_devic
 	struct sk_buff *skb;
 	int i;
 
+	/* Wait and kill tasklet */
+	tasklet_kill(&np->rx_tasklet);
+	tasklet_kill(&np->tx_tasklet);
+	np->cur_tx = 0;
+	np->dirty_tx = 0;
+	np->cur_task = 0;
+	np->last_tx = 0;
+
 	netif_stop_queue(dev);
 
 	if (netif_msg_ifdown(np)) {
@@ -1663,9 +1671,20 @@ static int netdev_close(struct net_devic
 	/* Stop the chip's Tx and Rx processes. */
 	iowrite16(TxDisable | RxDisable | StatsDisable, ioaddr + MACCtrl1);
 
-	/* Wait and kill tasklet */
-	tasklet_kill(&np->rx_tasklet);
-	tasklet_kill(&np->tx_tasklet);
+    	for (i = 2000; i > 0; i--) {
+ 		if ((ioread32(ioaddr + DMACtrl) &0xC000) == 0)
+			break;
+		mdelay(1);
+    	}
+
+    	iowrite16(GlobalReset | DMAReset | FIFOReset | NetworkReset, ioaddr +ASICCtrl + 2);
+
+    	for (i = 2000; i > 0; i--)
+    	{
+ 		if ((ioread16(ioaddr + ASICCtrl +2) &ResetBusy) == 0)
+			break;
+		mdelay(1);
+    	}
 
 #ifdef __i386__
 	if (netif_msg_hw(np)) {
@@ -1703,6 +1722,7 @@ #endif /* __i386__ debugging only */
 		}
 	}
 	for (i = 0; i < TX_RING_SIZE; i++) {
+		np->tx_ring[i].next_desc = 0;
 		skb = np->tx_skbuff[i];
 		if (skb) {
 			pci_unmap_single(np->pci_dev,
-- 
1.3.GIT



