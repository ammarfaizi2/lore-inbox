Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129404AbQKSV3n>; Sun, 19 Nov 2000 16:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbQKSV3d>; Sun, 19 Nov 2000 16:29:33 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:2309 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S129404AbQKSV33> convert rfc822-to-8bit;
	Sun, 19 Nov 2000 16:29:29 -0500
Date: Sun, 19 Nov 2000 21:59:26 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Frank Davis <fdavis@andrew.cmu.edu>
Subject: [PATCH] dmfe.c transmission performance patch
Message-ID: <Pine.LNX.4.21.0011192150160.27770-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please help me test this patch (for linux-2.4.0-test10/11)!]

This is my tx performance patch for dmfe, excluding the locking fixes,
which will appear in a separate patch. I would like feedback from testing
and code inspection. New since the last patch is the line printed when a
new card is found. (device name, MAC address, IO, IRQ)

Possible future work:
* Zero-copy transmission
* Use "new" PCI support API

/Tobias


--- dmfe.c.orig	Sun Nov 19 21:43:33 2000
+++ dmfe.c	Sun Nov 19 21:44:57 2000
@@ -57,6 +57,10 @@
    Resource usage cleanups.
    Report driver version to user.
 
+   Tobias Ringström <zajbot@goteborg.utfors.se> :
+   Rewrote the transmit code to actually use the ring buffer,
+   and to generate a lot fewer interrupts.
+
    TODO
 
    Implement pci_driver::suspend() and pci_driver::resume()
@@ -68,7 +72,7 @@
 
  */
 
-#define DMFE_VERSION "1.30 (June 11, 2000)"
+#define DMFE_VERSION "1.30p1 (November 15, 2000)"
 
 #include <linux/module.h>
 
@@ -108,6 +112,7 @@
 #define TX_MAX_SEND_CNT 0x1	/* Maximum tx packet per time */
 #define TX_DESC_CNT     0x10	/* Allocated Tx descriptors */
 #define RX_DESC_CNT     0x10	/* Allocated Rx descriptors */
+#define TX_IRQ_THR      12
 #define DESC_ALL_CNT    TX_DESC_CNT+RX_DESC_CNT
 #define TX_BUF_ALLOC    0x600
 #define RX_ALLOC_SIZE   0x620
@@ -198,8 +203,7 @@
 	struct rx_desc *first_rx_desc;
 	struct rx_desc *rx_insert_ptr;
 	struct rx_desc *rx_ready_ptr;	/* packet come pointer */
-	u32 tx_packet_cnt;	/* transmitted packet count */
-	u32 tx_queue_cnt;	/* wait to send packet count */
+	u32 tx_live_cnt;	/* number of used/live tx slots */
 	u32 rx_avail_cnt;	/* available rx descriptor count */
 	u32 interval_rx_cnt;	/* rx packet count a callback time */
 
@@ -423,9 +427,17 @@
 	for (i = 0; i < 64; i++)
 		((u16 *) db->srom)[i] = read_srom_word(pci_iobase, i);
 
+	printk(KERN_INFO "%s: Davicom DM%04lx at 0x%lx,",
+	       dev->name,
+	       ent->driver_data >> 16,
+	       pci_iobase);
+
 	/* Set Node address */
-	for (i = 0; i < 6; i++)
+	for (i = 0; i < 6; i++) {
 		dev->dev_addr[i] = db->srom[20 + i];
+		printk("%c%02x", i ? ':' : ' ', dev->dev_addr[i]);
+	}
+	printk(", IRQ %d\n", pci_irqline);
 
 	return 0;
 
@@ -490,8 +502,6 @@
 
 	/* system variable init */
 	db->cr6_data = CR6_DEFAULT | dmfe_cr6_user_set;
-	db->tx_packet_cnt = 0;
-	db->tx_queue_cnt = 0;
 	db->rx_avail_cnt = 0;
 	db->link_failed = 0;
 	db->wait_reset = 0;
@@ -595,46 +605,38 @@
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
 
 	/* free this SKB */
 	dev_kfree_skb(skb);
+
 	return 0;
 }
 
@@ -713,12 +715,12 @@
 		outl(0, ioaddr + DCR7);		/* disable all interrupt */
 		return;
 	}
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
@@ -734,21 +736,12 @@
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
 
 	/* Received the coming packet */
@@ -930,12 +923,14 @@
 
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
@@ -1022,8 +1017,7 @@
 	dmfe_free_rxbuffer(db);
 
 	/* system variable init */
-	db->tx_packet_cnt = 0;
-	db->tx_queue_cnt = 0;
+	db->tx_live_cnt = 0;
 	db->rx_avail_cnt = 0;
 	db->link_failed = 0;
 	db->wait_reset = 0;
@@ -1182,7 +1176,7 @@
 }
 
 /* Send a setup frame for DM9102/DM9102A
-   This setup frame initilize DM910X addres filter mode
+   This setup frame initilize DM910X address filter mode
  */
 static void send_filter_frame(struct net_device *dev, int mc_cnt)
 {
@@ -1198,6 +1192,12 @@
 	txptr = db->tx_insert_ptr;
 	suptr = (u32 *) txptr->tx_buf_ptr;
 
+	if (txptr->tdes0 & 0x80000000) {
+		printk(KERN_WARNING "%s: Too busy to send filter frame\n",
+		       dev->name);
+		return;
+	}
+
 	/* Node address */
 	addrptr = (u16 *) dev->dev_addr;
 	*suptr++ = addrptr[0];
@@ -1224,19 +1224,13 @@
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
 }
 
 /*
@@ -1598,14 +1592,14 @@
 		break;
 	}
 
+	printk (KERN_INFO
+		"Davicom DM91xx net driver, version " DMFE_VERSION "\n");
+
 	rc = pci_register_driver(&dmfe_driver);
 	if (rc < 0)
 		return rc;
-	if (rc > 0) {
-		printk (KERN_INFO "Davicom DM91xx net driver loaded, version "
-			DMFE_VERSION "\n");
+	if (rc > 0)
 		return 0;
-	}
 	return -ENODEV;
 }
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
