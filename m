Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbWINC6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWINC6N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 22:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbWINC6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 22:58:13 -0400
Received: from msr47.hinet.net ([168.95.4.147]:148 "EHLO msr47.hinet.net")
	by vger.kernel.org with ESMTP id S1750960AbWINC6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 22:58:12 -0400
Subject: [PATCH 1/4] IP100A: Fix TX Pause bug (reset_tx, intr_handler)
	2006-08-24
From: Jesse Huang <jesse@icplus.com.tw>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org,
       jgarzik@pobox.com, jesse@icplus.com.tw
Content-Type: text/plain
Date: Thu, 14 Sep 2006 10:44:22 -0400
Message-Id: <1158245062.2184.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Huang <jesse@icplus.com.tw>

Change Logs:
   - Fix TX Pause bug (reset_tx, intr_handler)

Signed-off-by: Jesse Huang <jesse@icplus.com.tw>

---

 drivers/net/sundance.c |   53 +++++++++++++++++++++++++++---------------------
 1 files changed, 30 insertions(+), 23 deletions(-)

fb301c44641884efd60918054080f1ebc1d4f307
diff --git a/drivers/net/sundance.c b/drivers/net/sundance.c
index ac17377..0b6028b 100755
--- a/drivers/net/sundance.c
+++ b/drivers/net/sundance.c
@@ -21,8 +21,8 @@
 */
 
 #define DRV_NAME	"sundance"
-#define DRV_VERSION	"1.1"
-#define DRV_RELDATE	"27-Jun-2006"
+#define DRV_VERSION	"1.2"
+#define DRV_RELDATE	"03-Aug-2006"
 
 
 /* The user-configurable values.
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
+	np->last_tx = 0;
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
+							iowrite16(ioread16(ioaddr + MACCtrl1) | TxEnable, ioaddr + MACCtrl1);
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



