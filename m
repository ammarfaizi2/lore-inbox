Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311837AbSCXIwX>; Sun, 24 Mar 2002 03:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311840AbSCXIwP>; Sun, 24 Mar 2002 03:52:15 -0500
Received: from as2-1-8.va.g.bonet.se ([194.236.117.122]:42168 "EHLO
	ringstrom.mine.nu") by vger.kernel.org with ESMTP
	id <S311837AbSCXIwB>; Sun, 24 Mar 2002 03:52:01 -0500
Date: Sun, 24 Mar 2002 09:51:32 +0100 (CET)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: tori@boris.prodako.se
To: David Eduardo Gomez Noguera <davidgn@servidor.unam.mx>
cc: alan@lxorguk.ukuu.org.uk, <linux-kernel@vger.kernel.org>
Subject: Re: CNet Fast Etherenet (Davicom DM9102AF)
In-Reply-To: <20020323191342.4c7d1fe6.davidgn@servidor.unam.mx>
Message-ID: <Pine.LNX.4.44.0203240930270.16934-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Mar 2002, David Eduardo Gomez Noguera wrote:

> Why would tulip perform better though?

The dmfe driver's packet transmission code is not very efficient.  I have
a patch that fixes it, but I do not know if it will break with older
Davicom chips, althouhg I see no reason why it should.  I have included
the patch at the end of this email.

It would be nice if you could try the patch and let me know if it works
for you.  I'd be very surprised if it does not work with your card (since
I have one of those).

/Tobias

--- /usr/src/linux-2.4.18.crypto/drivers/net/dmfe.c	Fri Mar  1 10:21:38 2002
+++ ./dmfe.c	Sun Mar 24 09:40:52 2002
@@ -61,7 +61,7 @@
 */
 
 #define DRV_NAME	"dmfe"
-#define DRV_VERSION	"1.36.4"
+#define DRV_VERSION	"1.36.4tx"
 #define DRV_RELDATE	"2002-01-17"
 
 #include <linux/module.h>
@@ -100,11 +100,9 @@
 
 #define DM9102_IO_SIZE  0x80
 #define DM9102A_IO_SIZE 0x100
-#define TX_MAX_SEND_CNT 0x1             /* Maximum tx packet per time */
 #define TX_DESC_CNT     0x10            /* Allocated Tx descriptors */
 #define RX_DESC_CNT     0x20            /* Allocated Rx descriptors */
-#define TX_FREE_DESC_CNT (TX_DESC_CNT - 2)	/* Max TX packet count */
-#define TX_WAKE_DESC_CNT (TX_DESC_CNT - 3)	/* TX wakeup count */
+#define TX_IRQ_THR      12
 #define DESC_ALL_CNT    (TX_DESC_CNT + RX_DESC_CNT)
 #define TX_BUF_ALLOC    0x600
 #define RX_ALLOC_SIZE   0x620
@@ -211,8 +209,9 @@
 	struct rx_desc *first_rx_desc;
 	struct rx_desc *rx_insert_ptr;
 	struct rx_desc *rx_ready_ptr;	/* packet come pointer */
-	unsigned long tx_packet_cnt;	/* transmitted packet count */
-	unsigned long tx_queue_cnt;	/* wait to send packet count */
+	int tx_int_pkt_num;		/* number of packets to transmit until
+					 * a transmit interrupt is requested */
+	u32 tx_live_cnt;		/* number of used/live tx slots */
 	unsigned long rx_avail_cnt;	/* available rx descriptor count */
 	unsigned long interval_rx_cnt;	/* rx packet count a callback time */
 
@@ -541,8 +540,9 @@
 					db->buf_pool_ptr, db->buf_pool_dma_ptr);
 		unregister_netdev(dev);
 		pci_release_regions(pdev);
-		kfree(dev);	/* free board information */
+		pci_disable_device(pdev);
 		pci_set_drvdata(pdev, NULL);
+		kfree(dev);	/* free board information */
 	}
 
 	DMFE_DBUG(0, "dmfe_remove_one() exit", 0);
@@ -567,8 +567,8 @@
 
 	/* system variable init */
 	db->cr6_data = CR6_DEFAULT | dmfe_cr6_user_set;
-	db->tx_packet_cnt = 0;
-	db->tx_queue_cnt = 0;
+	db->tx_int_pkt_num = TX_IRQ_THR;
+	db->tx_live_cnt = 0;
 	db->rx_avail_cnt = 0;
 	db->link_failed = 1;
 	db->wait_reset = 0;
@@ -687,9 +687,6 @@
 
 	DMFE_DBUG(0, "dmfe_start_xmit", 0);
 
-	/* Resource flag check */
-	netif_stop_queue(dev);
-
 	/* Too large packet check */
 	if (skb->len > MAX_PACKET_SIZE) {
 		printk(KERN_ERR DRV_NAME ": big packet = %d\n", (u16)skb->len);
@@ -699,38 +696,33 @@
 
 	spin_lock_irqsave(&db->lock, flags);
 
-	/* No Tx resource check, it never happen nromally */
-	if (db->tx_queue_cnt >= TX_FREE_DESC_CNT) {
-		spin_unlock_irqrestore(&db->lock, flags);
-		printk(KERN_ERR DRV_NAME ": No Tx resource %ld\n", db->tx_queue_cnt);
-		return 1;
-	}
-
 	/* Disable NIC interrupt */
 	outl(0, dev->base_addr + DCR7);
 
 	/* transmit this packet */
 	txptr = db->tx_insert_ptr;
 	memcpy(txptr->tx_buf_ptr, skb->data, skb->len);
-	txptr->tdes1 = cpu_to_le32(0xe1000000 | skb->len);
+	if (--db->tx_int_pkt_num < 0)
+	{
+		txptr->tdes1 = cpu_to_le32(0xe1000000 | skb->len);
+		db->tx_int_pkt_num = TX_IRQ_THR;
+	}
+	else
+		txptr->tdes1 = cpu_to_le32(0x61000000 | skb->len);
+
+	/* Transmit Packet Process */
+	txptr->tdes0 = cpu_to_le32(0x80000000);	/* set owner bit to DM910X */
+	outl(0x1, dev->base_addr + DCR1);	/* Issue Tx polling command */
+	dev->trans_start = jiffies;		/* saved the time stamp */
 
 	/* Point to next transmit free descriptor */
-	db->tx_insert_ptr = txptr->next_tx_desc;
+	txptr = txptr->next_tx_desc;
 
-	/* Transmit Packet Process */
-	if ( (!db->tx_queue_cnt) && (db->tx_packet_cnt < TX_MAX_SEND_CNT) ) {
-		txptr->tdes0 = cpu_to_le32(0x80000000);	/* Set owner bit */
-		db->tx_packet_cnt++;			/* Ready to send */
-		outl(0x1, dev->base_addr + DCR1);	/* Issue Tx polling */
-		dev->trans_start = jiffies;		/* saved time stamp */
-	} else {
-		db->tx_queue_cnt++;			/* queue TX packet */
-		outl(0x1, dev->base_addr + DCR1);	/* Issue Tx polling */
-	}
+	if (txptr->tdes0 & cpu_to_le32(0x80000000))
+		netif_stop_queue(dev);
 
-	/* Tx resource check */
-	if ( db->tx_queue_cnt < TX_FREE_DESC_CNT )
-		netif_wake_queue(dev);
+	db->tx_insert_ptr = txptr;
+	db->tx_live_cnt++;
 
 	/* free this SKB */
 	dev_kfree_skb(skb);
@@ -860,18 +852,18 @@
 static void dmfe_free_tx_pkt(struct DEVICE *dev, struct dmfe_board_info * db)
 {
 	struct tx_desc *txptr;
-	unsigned long ioaddr = dev->base_addr;
 	u32 tdes0;
 
 	txptr = db->tx_remove_ptr;
-	while(db->tx_packet_cnt) {
+	while (db->tx_live_cnt > 0)
+	{
 		tdes0 = le32_to_cpu(txptr->tdes0);
 		/* printk(DRV_NAME ": tdes0=%x\n", tdes0); */
 		if (tdes0 & 0x80000000)
 			break;
 
 		/* A packet sent completed */
-		db->tx_packet_cnt--;
+		db->tx_live_cnt--;
 		db->stats.tx_packets++;
 
 		/* Transmit statistic counter */
@@ -908,17 +900,8 @@
 	/* Update TX remove pointer to next */
 	db->tx_remove_ptr = txptr;
 
-	/* Send the Tx packet in queue */
-	if ( (db->tx_packet_cnt < TX_MAX_SEND_CNT) && db->tx_queue_cnt ) {
-		txptr->tdes0 = cpu_to_le32(0x80000000);	/* Set owner bit */
-		db->tx_packet_cnt++;			/* Ready to send */
-		db->tx_queue_cnt--;
-		outl(0x1, ioaddr + DCR1);		/* Issue Tx polling */
-		dev->trans_start = jiffies;		/* saved time stamp */
-	}
-
 	/* Resource available check */
-	if ( db->tx_queue_cnt < TX_WAKE_DESC_CNT )
+	if ((db->tx_insert_ptr->tdes0 & (cpu_to_le32(0x80000000))) == 0)
 		netif_wake_queue(dev);	/* Active upper layer, send again */
 }
 
@@ -1159,7 +1142,7 @@
 	db->interval_rx_cnt = 0;
 
 	/* TX polling kick monitor */
-	if ( db->tx_packet_cnt &&
+	if ( db->tx_live_cnt > TX_IRQ_THR &&
 	     time_after(jiffies, dev->trans_start + DMFE_TX_KICK) ) {
 		outl(0x1, dev->base_addr + DCR1);   /* Tx polling again */
 
@@ -1167,13 +1150,13 @@
 		if ( time_after(jiffies, dev->trans_start + DMFE_TX_TIMEOUT) ) {
 			db->reset_TXtimeout++;
 			db->wait_reset = 1;
-			printk(KERN_WARNING "%s: Tx timeout - resetting\n",
-			       dev->name);
+			printk(KERN_WARNING "%s: Tx timeout - resetting (%d)\n",
+			       dev->name, db->tx_live_cnt);
 		}
 	}
 
 	if (db->wait_reset) {
-		DMFE_DBUG(0, "Dynamic Reset device", db->tx_packet_cnt);
+		DMFE_DBUG(0, "Dynamic Reset device", db->tx_live_cnt);
 		db->reset_count++;
 		dmfe_dynamic_reset(dev);
 		db->first_in_callback = 0;
@@ -1271,8 +1254,8 @@
 	dmfe_free_rxbuffer(db);
 
 	/* system variable init */
-	db->tx_packet_cnt = 0;
-	db->tx_queue_cnt = 0;
+	db->tx_int_pkt_num = TX_IRQ_THR;
+	db->tx_live_cnt = 0;
 	db->rx_avail_cnt = 0;
 	db->link_failed = 1;
 	db->wait_reset = 0;
@@ -1464,6 +1447,12 @@
 	txptr = db->tx_insert_ptr;
 	suptr = (u32 *) txptr->tx_buf_ptr;
 
+	if (txptr->tdes0 & cpu_to_le32(0x80000000)) {
+		printk(KERN_WARNING "%s: Too busy to send filter frame\n",
+		       dev->name);
+		return;
+	}
+
 	/* Node address */
 	addrptr = (u16 *) dev->dev_addr;
 	*suptr++ = addrptr[0];
@@ -1491,19 +1480,15 @@
 
 	/* prepare the setup frame */
 	db->tx_insert_ptr = txptr->next_tx_desc;
+	db->tx_live_cnt++;
 	txptr->tdes1 = cpu_to_le32(0x890000c0);
 
-	/* Resource Check and Send the setup packet */
-	if (!db->tx_packet_cnt) {
-		/* Resource Empty */
-		db->tx_packet_cnt++;
-		txptr->tdes0 = cpu_to_le32(0x80000000);
-		update_cr6(db->cr6_data | 0x2000, dev->base_addr);
-		outl(0x1, dev->base_addr + DCR1);	/* Issue Tx polling */
-		update_cr6(db->cr6_data, dev->base_addr);
-		dev->trans_start = jiffies;
-	} else
-		db->tx_queue_cnt++;	/* Put in TX queue */
+	/* Send the setup frame */
+	dev->trans_start = jiffies;		/* saved the time stamp */
+	txptr->tdes0 = cpu_to_le32(0x80000000);
+	update_cr6(db->cr6_data | 0x2000, dev->base_addr);
+	outl(0x1, dev->base_addr + DCR1);	/* Issue Tx polling command */
+	update_cr6(db->cr6_data, dev->base_addr);
 }
 
 

