Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQKOVEu>; Wed, 15 Nov 2000 16:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129256AbQKOVEj>; Wed, 15 Nov 2000 16:04:39 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:53764 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S129228AbQKOVEc> convert rfc822-to-8bit;
	Wed, 15 Nov 2000 16:04:32 -0500
Date: Wed, 15 Nov 2000 21:34:30 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [CFT] dmfe.c network driver update for 2.4
Message-ID: <Pine.LNX.4.21.0011152118540.22362-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have updated the dmfe.c network driver for 2.4.0-test by adding proper
locking (I hope), and also made transmission much efficient.

I would appreciate any feedback from people using this driver, to confirm
that I did not break it.

It would also be great if someone could take a look at the lock handling,
to confirm that is is correct and sufficient.

/Tobias


--- dmfe.c.orig	Wed Nov 15 19:53:48 2000
+++ dmfe.c	Wed Nov 15 21:35:24 2000
@@ -57,6 +57,11 @@
    Resource usage cleanups.
    Report driver version to user.
 
+   Tobias Ringström <zajbot@goteborg.utfors.se> :
+   Added proper locking.
+   Rewrote the transmit code to actually use the ring buffer,
+   and to generate a lot fewer interrupts.
+
    TODO
 
    Implement pci_driver::suspend() and pci_driver::resume()
@@ -108,6 +113,7 @@
 #define TX_MAX_SEND_CNT 0x1	/* Maximum tx packet per time */
 #define TX_DESC_CNT     0x10	/* Allocated Tx descriptors */
 #define RX_DESC_CNT     0x10	/* Allocated Rx descriptors */
+#define TX_IRQ_THR      12
 #define DESC_ALL_CNT    TX_DESC_CNT+RX_DESC_CNT
 #define TX_BUF_ALLOC    0x600
 #define RX_ALLOC_SIZE   0x620
@@ -188,6 +194,8 @@
 	u32 cr7_data;
 	u32 cr15_data;
 	
+	spinlock_t lock;
+
 	/* descriptor pointer */
 	unsigned char *buf_pool_ptr;	/* Tx buffer pool memory */
 	unsigned char *buf_pool_start;	/* Tx buffer pool align dword */
@@ -198,8 +206,7 @@
 	struct rx_desc *first_rx_desc;
 	struct rx_desc *rx_insert_ptr;
 	struct rx_desc *rx_ready_ptr;	/* packet come pointer */
-	u32 tx_packet_cnt;	/* transmitted packet count */
-	u32 tx_queue_cnt;	/* wait to send packet count */
+	u32 tx_live_cnt;	/* number of used/live tx slots */
 	u32 rx_avail_cnt;	/* available rx descriptor count */
 	u32 interval_rx_cnt;	/* rx packet count a callback time */
 
@@ -490,8 +497,6 @@
 
 	/* system variable init */
 	db->cr6_data = CR6_DEFAULT | dmfe_cr6_user_set;
-	db->tx_packet_cnt = 0;
-	db->tx_queue_cnt = 0;
 	db->rx_avail_cnt = 0;
 	db->link_failed = 0;
 	db->wait_reset = 0;
@@ -595,46 +600,42 @@
 {
 	struct dmfe_board_info *db = dev->priv;
 	struct tx_desc *txptr;
+	static unsigned pkt_num = TX_IRQ_THR;
 
 	DMFE_DBUG(0, "dmfe_start_xmit", 0);
- 
-	netif_stop_queue(dev);
-	
-	/* Too large packet check */
-	if (skb->len > MAX_PACKET_SIZE) {
-		printk(KERN_ERR "%s: oversized frame (%d bytes) for transmit.\n", dev->name, (u16) skb->len);
-		dev_kfree_skb(skb);
-		return 0;
-	}
-	/* No Tx resource check, it never happen nromally */
-	if (db->tx_packet_cnt >= TX_FREE_DESC_CNT) {
-		return 1;
-	}
+
+	spin_lock_irq(&db->lock);
 
 	/* transmit this packet */
 	txptr = db->tx_insert_ptr;
 	memcpy((char *) txptr->tx_buf_ptr, (char *) skb->data, skb->len);
-	txptr->tdes1 = 0xe1000000 | skb->len;
+	if (--pkt_num == 0)
+	{
+		txptr->tdes1 = 0xe1000000 | skb->len;
+		pkt_num = TX_IRQ_THR;
+	}
+	else
+		txptr->tdes1 = 0x61000000 | skb->len;
+
+	/* Transmit Packet Process */
+	txptr->tdes0 = 0x80000000;	/* set owner bit to DM910X */
+	outl(0x1, dev->base_addr + DCR1);	/* Issue Tx polling comand */
+	dev->trans_start = jiffies;     /* saved the time stamp */
 
 	/* Point to next transmit free descriptor */
-	db->tx_insert_ptr = (struct tx_desc *) txptr->next_tx_desc;
+	txptr = (struct tx_desc *)txptr->next_tx_desc;
 
-	/* Transmit Packet Process */
-	if (db->tx_packet_cnt < TX_MAX_SEND_CNT) {
-		txptr->tdes0 = 0x80000000;	/* set owner bit to DM910X */
-		db->tx_packet_cnt++;	/* Ready to send count */
-		outl(0x1, dev->base_addr + DCR1);	/* Issue Tx polling comand */
-	} else {
-		db->tx_queue_cnt++;	/* queue the tx packet */
-		outl(0x1, dev->base_addr + DCR1);	/* Issue Tx polling comand */
-	}
+	if (txptr->tdes0 & 0x80000000)
+		netif_stop_queue(dev);
 
-	/* Tx resource check */
-	if (db->tx_packet_cnt < TX_FREE_DESC_CNT)
-		netif_wake_queue(dev);
+	db->tx_insert_ptr = txptr;
+	db->tx_live_cnt++;
+
+	spin_unlock_irq(&tp->lock);
 
 	/* free this SKB */
 	dev_kfree_skb(skb);
+
 	return 0;
 }
 
@@ -713,12 +714,14 @@
 		outl(0, ioaddr + DCR7);		/* disable all interrupt */
 		return;
 	}
+
+	spin_lock(&db->lock);
+
 	/* Free the transmitted descriptor */
 	txptr = db->tx_remove_ptr;
-	while (db->tx_packet_cnt) {
+	while (db->tx_live_cnt > 0 && (txptr->tdes0 & 0x80000000) == 0)
+	{
 		/* printk("tdes0=%x\n", txptr->tdes0); */
-		if (txptr->tdes0 & 0x80000000)
-			break;
 		db->stats.tx_packets++;
 		
 		if ((txptr->tdes0 & TDES0_ERR_MASK) && (txptr->tdes0 != 0x7fffffff)) {
@@ -734,23 +737,16 @@
 				db->stats.tx_errors++;
 		}
 		txptr = (struct tx_desc *) txptr->next_tx_desc;
-		db->tx_packet_cnt--;
+		db->tx_live_cnt--;
 	}
 	/* Update TX remove pointer to next */
 	db->tx_remove_ptr = (struct tx_desc *) txptr;
 
-	/* Send the Tx packet in queue */
-	if ((db->tx_packet_cnt < TX_MAX_SEND_CNT) && db->tx_queue_cnt) {
-		txptr->tdes0 = 0x80000000;	/* set owner bit to DM910X */
-		db->tx_packet_cnt++;	/* Ready to send count */
-		outl(0x1, ioaddr + DCR1);	/* Issue Tx polling command */
-		dev->trans_start = jiffies;	/* saved the time stamp */
-		db->tx_queue_cnt--;
- 	}
-	/* Resource available check */
-	if (db->tx_packet_cnt < TX_FREE_DESC_CNT)
+	if ((db->tx_insert_ptr->tdes0 & 0x80000000) == 0)
 		netif_wake_queue(dev);
 
+	spin_unlock(&db->lock);
+
 	/* Received the coming packet */
 	if (db->rx_avail_cnt)
 		dmfe_rx_packet(dev, db);
@@ -930,12 +926,14 @@
 
 	db->interval_rx_cnt = 0;
 
-	if (db->wait_reset | (db->tx_packet_cnt &&
-			      ((jiffies - dev->trans_start) > DMFE_TX_TIMEOUT)) | (db->rx_error_cnt > 3)) {
+	if (db->wait_reset ||
+	    (db->tx_live_cnt > 0 &&
+	     ((jiffies - dev->trans_start) > DMFE_TX_TIMEOUT)) ||
+	    (db->rx_error_cnt > 3)) {
 		/*
 		   printk("wait_reset %x, tx cnt %x, rx err %x, time %x\n", db->wait_reset, db->tx_packet_cnt, db->rx_error_cnt, jiffies-dev->trans_start);
 		 */
-		DMFE_DBUG(0, "Warn!! Warn!! Tx/Rx moniotr step1", db->tx_packet_cnt);
+		DMFE_DBUG(0, "Warn!! Warn!! Tx/Rx monitor step1", 0);
 		dmfe_dynamic_reset(dev);
 		db->timer.expires = DMFE_TIMER_WUT;
 		add_timer(&db->timer);
@@ -1022,8 +1020,7 @@
 	dmfe_free_rxbuffer(db);
 
 	/* system variable init */
-	db->tx_packet_cnt = 0;
-	db->tx_queue_cnt = 0;
+	db->tx_live_cnt = 0;
 	db->rx_avail_cnt = 0;
 	db->link_failed = 0;
 	db->wait_reset = 0;
@@ -1182,22 +1179,32 @@
 }
 
 /* Send a setup frame for DM9102/DM9102A
-   This setup frame initilize DM910X addres filter mode
+   This setup frame initilize DM910X address filter mode
  */
 static void send_filter_frame(struct net_device *dev, int mc_cnt)
 {
 	struct dmfe_board_info *db = dev->priv;
 	struct dev_mc_list *mcptr;
 	struct tx_desc *txptr;
+	unsigned long flags;
 	u16 *addrptr;
 	u32 *suptr;
 	int i;
 
 	DMFE_DBUG(0, "send_filetr_frame()", 0);
 
+	spin_lock_irqsave(&db->lock, flags);
+
 	txptr = db->tx_insert_ptr;
 	suptr = (u32 *) txptr->tx_buf_ptr;
 
+	if (txptr->tdes0 & 0x80000000) {
+		spin_unlock_irq(&tp->lock);
+		printk(KERN_WARNING "%s: Too busy to send filter frame\n",
+		       dev->name);
+		return;
+	}
+
 	/* Node address */
 	addrptr = (u16 *) dev->dev_addr;
 	*suptr++ = addrptr[0];
@@ -1224,19 +1231,15 @@
 	}
 	/* prepare the setup frame */
 	db->tx_insert_ptr = (struct tx_desc *) txptr->next_tx_desc;
+	db->tx_live_cnt++;
 	txptr->tdes1 = 0x890000c0;
-	/* Resource Check and Send the setup packet */
-	if (!db->tx_packet_cnt) {
-		/* Resource Empty */
-		db->tx_packet_cnt++;
-		txptr->tdes0 = 0x80000000;
-		update_cr6(db->cr6_data | 0x2000, dev->base_addr);
-		outl(0x1, dev->base_addr + DCR1);	/* Issue Tx polling command */
-		update_cr6(db->cr6_data, dev->base_addr);
-	} else {
-		/* Put into TX queue */
-		db->tx_queue_cnt++;
-	}
+	/* Send the setup packet */
+	txptr->tdes0 = 0x80000000;
+	update_cr6(db->cr6_data | 0x2000, dev->base_addr);
+	outl(0x1, dev->base_addr + DCR1);	/* Issue Tx polling command */
+	update_cr6(db->cr6_data, dev->base_addr);
+
+	spin_unlock_irqrestore(&tp->lock, flags);
 }
 
 /*

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
