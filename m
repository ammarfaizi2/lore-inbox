Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWHQHQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWHQHQj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 03:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWHQHQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 03:16:39 -0400
Received: from msr3.hinet.net ([168.95.4.103]:55205 "EHLO msr3.hinet.net")
	by vger.kernel.org with ESMTP id S1751180AbWHQHQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 03:16:38 -0400
Subject: [PATCH 2/6] IP100A Fix Tx pause bug
From: Jesse Huang <jesse@icplus.com.tw>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org,
       jgarzik@pobox.com, jesse@icplus.com.tw
Content-Type: text/plain
Date: Thu, 17 Aug 2006 15:04:05 -0400
Message-Id: <1155841445.4532.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Huang <jesse@icplus.com.tw>

Fix Tx pause bug

Change Logs:
    Fix Tx pause bug

---

 drivers/net/sundance.c |   49 +++++++++++++++++++++++++++---------------------
 1 files changed, 28 insertions(+), 21 deletions(-)

7e6bffe518096d89a9e7ee9b80f246b3ff442f2e
diff --git a/drivers/net/sundance.c b/drivers/net/sundance.c
index eb81d91..910ea17 100755
--- a/drivers/net/sundance.c
+++ b/drivers/net/sundance.c
@@ -262,8 +262,6 @@ enum alta_offsets {
 	ASICCtrl = 0x30,
 	EEData = 0x34,
 	EECtrl = 0x36,
-	TxStartThresh = 0x3c,
-	RxEarlyThresh = 0x3e,
 	FlashAddr = 0x40,
 	FlashData = 0x44,
 	TxStatus = 0x46,
@@ -1084,6 +1082,8 @@ reset_tx (struct net_device *dev)
 	}
 	/* free all tx skbuff */
 	for (i = 0; i < TX_RING_SIZE; i++) {
+		np->tx_ring[i].next_desc = 0;
+		
 		skb = np->tx_skbuff[i];
 		if (skb) {
 			pci_unmap_single(np->pci_dev, 
@@ -1099,6 +1099,10 @@ reset_tx (struct net_device *dev)
 	}
 	np->cur_tx = np->dirty_tx = 0;
 	np->cur_task = 0;
+	
+	np->last_tx=0;
+	iowrite8(127, ioaddr + TxDMAPollPeriod);	
+	
 	iowrite16 (StatsEnable | RxEnable | TxEnable, ioaddr + MACCtrl1);
 	return 0;
 }
@@ -1156,29 +1160,29 @@ static irqreturn_t intr_handler(int irq,
 						np->stats.tx_fifo_errors++;
 					if (tx_status & 0x02)
 						np->stats.tx_window_errors++;
-					/*
-					** This reset has been verified on
-					** DFE-580TX boards ! phdm@macqel.be.
-					*/
-					if (tx_status & 0x10) {	/* TxUnderrun */
-						unsigned short txthreshold;
-
-						txthreshold = ioread16 (ioaddr + TxStartThresh);
-						/* Restart Tx FIFO and transmitter */
-						sundance_reset(dev, (NetworkReset|FIFOReset|TxReset) << 16);
-						iowrite16 (txthreshold, ioaddr + TxStartThresh);
-						/* No need to reset the Tx pointer here */
+
+					/* FIFO ERROR need to be reset tx */
+					if (tx_status & 0x10) {	/* Reset the Tx. */
+						spin_lock(&np->lock);
+						reset_tx(dev);
+						spin_unlock(&np->lock);
+					}
+					if (tx_status & 0x1e) {
+					/* need to make sure tx enabled */
+						int i = 10;
+						do {
+							iowrite16 (ioread16(ioaddr + MACCtrl1) | TxEnable, ioaddr + MACCtrl1);
+							if (ioread16(ioaddr + MACCtrl1) & TxEnabled)
+								break;
+							mdelay(1);
+						} while (--i);
 					}
-					/* Restart the Tx. */
-					iowrite16 (TxEnable, ioaddr + MACCtrl1);
 				}
-				/* Yup, this is a documentation bug.  It cost me *hours*. */
+				
 				iowrite16 (0, ioaddr + TxStatus);
-				if (tx_cnt < 0) {
-					iowrite32(5000, ioaddr + DownCounter);
-					break;
-				}
 				tx_status = ioread16 (ioaddr + TxStatus);
+				if (tx_cnt < 0)
+					break;
 			}
 			hw_frame_id = (tx_status >> 8) & 0xff;
 		} else 	{
@@ -1244,6 +1248,9 @@ static irqreturn_t intr_handler(int irq,
 	if (netif_msg_intr(np))
 		printk(KERN_DEBUG "%s: exiting interrupt, status=%#4.4x.\n",
 			   dev->name, ioread16(ioaddr + IntrStatus));
+			   
+	iowrite32(5000, ioaddr + DownCounter); 
+				   
 	return IRQ_RETVAL(handled);
 }
 
-- 
1.3.GIT



