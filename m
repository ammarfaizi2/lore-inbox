Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWHQHWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWHQHWo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 03:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWHQHWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 03:22:33 -0400
Received: from msr38.hinet.net ([168.95.4.138]:44770 "EHLO msr38.hinet.net")
	by vger.kernel.org with ESMTP id S932171AbWHQHWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 03:22:14 -0400
Subject: [PATCH 6/6] IP100A Solve host error problem when in low
	performance embedded
From: Jesse Huang <jesse@icplus.com.tw>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org,
       jgarzik@pobox.com, jesse@icplus.com.tw
Content-Type: text/plain
Date: Thu, 17 Aug 2006 15:09:40 -0400
Message-Id: <1155841780.4532.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Huang <jesse@icplus.com.tw>

Solve host error problem when in low performance embedded

Change Logs:
    Solve host error problem when in low performance embedded

---

 drivers/net/sundance.c |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)

78ff57ea887c19b7552342e990375f5e2bb10af9
diff --git a/drivers/net/sundance.c b/drivers/net/sundance.c
index c7c22f0..94ba6ca 100755
--- a/drivers/net/sundance.c
+++ b/drivers/net/sundance.c
@@ -1075,7 +1075,7 @@ reset_tx (struct net_device *dev)
 	struct sk_buff *skb;
 	int i;
 	int irq = in_interrupt();
-	
+	tasklet_kill(&np->tx_tasklet);
 	/* Reset tx logic, TxListPtr will be cleaned */
 	iowrite16 (TxDisable, ioaddr + MACCtrl1);
 	iowrite16 (TxReset | DMAReset | FIFOReset | NetworkReset,
@@ -1646,6 +1646,13 @@ static int netdev_close(struct net_devic
 	struct sk_buff *skb;
 	int i;
 
+	/* Wait and kill tasklet */
+	tasklet_kill(&np->rx_tasklet);
+	tasklet_kill(&np->tx_tasklet);
+   np->cur_tx = np->dirty_tx = 0;
+	np->cur_task = 0;
+	np->last_tx=0;
+
 	netif_stop_queue(dev);
 
 	if (netif_msg_ifdown(np)) {
@@ -1666,9 +1673,19 @@ static int netdev_close(struct net_devic
 	/* Stop the chip's Tx and Rx processes. */
 	iowrite16(TxDisable | RxDisable | StatsDisable, ioaddr + MACCtrl1);
 
-	/* Wait and kill tasklet */
-	tasklet_kill(&np->rx_tasklet);
-	tasklet_kill(&np->tx_tasklet);
+    for(i=2000;i> 0;i--) {
+		if((readl(ioaddr + DMACtrl)&0xC000) == 0)break;
+		mdelay(1);
+    }	
+
+    writew(GlobalReset | DMAReset | FIFOReset |NetworkReset, ioaddr +ASICCtrl + 2);
+    
+    for(i=2000;i >0;i--)
+    {
+		if((readw(ioaddr + ASICCtrl +2)&ResetBusy) == 0)
+	    	break;
+		mdelay(1);
+    }
 
 #ifdef __i386__
 	if (netif_msg_hw(np)) {
@@ -1706,6 +1723,7 @@ #endif /* __i386__ debugging only */
 		}
 	}
 	for (i = 0; i < TX_RING_SIZE; i++) {
+		np->tx_ring[i].next_desc=0;		
 		skb = np->tx_skbuff[i];
 		if (skb) {
 			pci_unmap_single(np->pci_dev,
-- 
1.3.GIT




