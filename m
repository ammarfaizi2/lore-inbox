Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131005AbQLEEdc>; Mon, 4 Dec 2000 23:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131030AbQLEEdW>; Mon, 4 Dec 2000 23:33:22 -0500
Received: from SMTP1.ANDREW.CMU.EDU ([128.2.10.81]:33219 "EHLO
	smtp1.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S131005AbQLEEdO>; Mon, 4 Dec 2000 23:33:14 -0500
Date: Mon, 4 Dec 2000 23:02:46 -0500 (EST)
From: Frank Davis <fdavis@andrew.cmu.edu>
To: linux-kernel@vger.kernel.org
cc: fdavis112@juno.com, tytso@mit.edu
Subject: dmfe patch
Message-ID: <Pine.SOL.3.96L.1001204225225.2071A-100000@unix13.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
   The following patch is a combo patch between a revised locking patch
and a transmission patch for drivers/net/dmfe . Please review this before
it goes to Linus for a final blessing. Please apply to
2.4.0-test12-pre5 . [For some reason, my juno account
truncates the following, but my CMU account doesn't.]
Regards,
Frank

--- drivers/net/dmfe.c.org	Sat Dec  2 15:50:28 2000
+++ drivers/net/dmfe.c	Sat Dec  2 17:02:03 2000
@@ -57,6 +57,13 @@
    Resource usage cleanups.
    Report driver version to user.
 
+   Tobias Ringstrm <zajbot@goteborg.utfors.se> :
+   Rewrote the transmit code to actually use the ring buffer,
+   and to generate a lot fewer interrupts.
+
+   Frank Davis <fdavis112@juno.com>
+   Added SMP-safe locking mechanisms	
+
    TODO
 
    Implement pci_driver::suspend() and pci_driver::resume()
@@ -68,7 +75,7 @@
 
  */
 
-#define DMFE_VERSION "1.30 (June 11, 2000)"
+#define DMFE_VERSION "1.30p2 (November 30, 2000)"
 
 #include <linux/module.h>
 
@@ -88,6 +95,7 @@
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/delay.h>
+#include <linux/spinlock.h>
 
 #include <asm/processor.h>
 #include <asm/bitops.h>
@@ -108,6 +116,7 @@
 #define TX_MAX_SEND_CNT 0x1	/* Maximum tx packet per time */
 #define TX_DESC_CNT     0x10	/* Allocated Tx descriptors */
 #define RX_DESC_CNT     0x10	/* Allocated Rx descriptors */
+#define TX_IRQ_THR      12
 #define DESC_ALL_CNT    TX_DESC_CNT+RX_DESC_CNT
 #define TX_BUF_ALLOC    0x600
 #define RX_ALLOC_SIZE   0x620
@@ -178,7 +187,7 @@
 	u32 chip_id;		/* Chip vendor/Device ID */
 	u32 chip_revision;	/* Chip revision */
 	struct net_device *next_dev;	/* next device */
-
+	spinlock_t lock; /* Spinlock */
 	struct pci_dev *net_dev;	/* PCI device */
 
 	unsigned long ioaddr;		/* I/O base address */
@@ -198,8 +207,7 @@
 	struct rx_desc *first_rx_desc;
 	struct rx_desc *rx_insert_ptr;
 	struct rx_desc *rx_ready_ptr;	/* packet come pointer */
-	u32 tx_packet_cnt;	/* transmitted packet count */
-	u32 tx_queue_cnt;	/* wait to send packet count */
+	u32 tx_live_cnt;	/* number of used/live tx slots */
 	u32 rx_avail_cnt;	/* available rx descriptor count */
 	u32 interval_rx_cnt;	/* rx packet count a callback time */
 
@@ -423,9 +431,17 @@
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
 
@@ -490,8 +506,6 @@
 
 	/* system variable init */
 	db->cr6_data = CR6_DEFAULT | dmfe_cr6_user_set;
-	db->tx_packet_cnt = 0;
-	db->tx_queue_cnt = 0;
 	db->rx_avail_cnt = 0;
 	db->link_failed = 0;
 	db->wait_reset = 0;
@@ -536,10 +550,12 @@
 {
 	struct dmfe_board_info *db = dev->priv;
 	u32 ioaddr = db->ioaddr;
-
+	unsigned long flags;
+	
 	DMFE_DBUG(0, "dmfe_init_dm910x()", 0);
 
 	/* Reset DM910x board : need 32 PCI clock to complete */
+	spin_lock_irqsave(&db->lock,flags);
 	outl(DM910X_RESET, ioaddr + DCR0);	/* RESET MAC */
 	DELAY_5US;
 	outl(db->cr0_data, ioaddr + DCR0);
@@ -547,6 +563,7 @@
 	outl(0x180, ioaddr + DCR12);	/* Let bit 7 output port */
 	outl(0x80, ioaddr + DCR12);	/* RESET DM9102 phyxcer */
 	outl(0x0, ioaddr + DCR12);	/* Clear RESET signal */
+	spin_unlock_irqrestore(&db->lock,flags);
 
 	/* Phy addr : DM910(A)2/DM9132/9801, phy address = 1 */
 	db->phy_addr = 1;
@@ -595,46 +612,38 @@
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
-		printk(KERN_ERR "%s: oversized frame (%d bytes) for
transmit.\n", dev->name, (u16) skb->len);
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
+	outl(0x1, dev->base_addr + DCR1);	/* Issue Tx polling comand
*/
+	dev->trans_start = jiffies;     /* saved the time stamp */
 
 	/* Point to next transmit free descriptor */
-	db->tx_insert_ptr = (struct tx_desc *) txptr->next_tx_desc;
+	txptr = (struct tx_desc *)txptr->next_tx_desc;
 
-	/* Transmit Packet Process */
-	if (db->tx_packet_cnt < TX_MAX_SEND_CNT) {
-		txptr->tdes0 = 0x80000000;	/* set owner bit to DM910X
*/
-		db->tx_packet_cnt++;	/* Ready to send count */
-		outl(0x1, dev->base_addr + DCR1);	/* Issue Tx
polling comand */
-	} else {
-		db->tx_queue_cnt++;	/* queue the tx packet */
-		outl(0x1, dev->base_addr + DCR1);	/* Issue Tx
polling comand */
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
 
@@ -647,18 +656,22 @@
 {
 	struct dmfe_board_info *db = dev->priv;
 	u32 ioaddr = dev->base_addr;
+	unsigned long flags;
 
 	DMFE_DBUG(0, "dmfe_stop", 0);
 
 	netif_stop_queue(dev);
 
 	/* Reset & stop DM910X board */
+	spin_lock_irqsave9&db->lock,flags);
 	outl(DM910X_RESET, ioaddr + DCR0);
 	DELAY_5US;
 
 	/* deleted timer */
 	del_timer(&db->timer);
 
+	spin_unlock_irqrestore(&db->lock,flags);
+	
 	/* free interrupt */
 	free_irq(dev->irq, dev);
 
@@ -713,12 +726,12 @@
 		outl(0, ioaddr + DCR7);		/* disable all interrupt
*/
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
 		
 		if ((txptr->tdes0 & TDES0_ERR_MASK) && (txptr->tdes0 !=
0x7fffffff)) {
@@ -734,21 +747,12 @@
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
-		txptr->tdes0 = 0x80000000;	/* set owner bit to DM910X
*/
-		db->tx_packet_cnt++;	/* Ready to send count */
-		outl(0x1, ioaddr + DCR1);	/* Issue Tx polling
command */
-		dev->trans_start = jiffies;	/* saved the time stamp */
-		db->tx_queue_cnt--;
- 	}
-	/* Resource available check */
-	if (db->tx_packet_cnt < TX_FREE_DESC_CNT)
+	if ((db->tx_insert_ptr->tdes0 & 0x80000000) == 0)
 		netif_wake_queue(dev);
 
 	/* Received the coming packet */
@@ -888,6 +892,11 @@
 /*
    Process the upper socket ioctl command
  */
+
+/* 
+ * The following function just returns 0. Shouldn't it do more? 
+ */
+
 static int dmfe_do_ioctl(struct net_device *dev, struct ifreq *ifr, int
cmd)
 {
 	DMFE_DBUG(0, "dmfe_do_ioctl()", 0);
@@ -930,12 +939,14 @@
 
 	db->interval_rx_cnt = 0;
 
-	if (db->wait_reset | (db->tx_packet_cnt &&
-			      ((jiffies - dev->trans_start) >
DMFE_TX_TIMEOUT)) | (db->rx_error_cnt > 3)) {
+	if (db->wait_reset ||
+	    (db->tx_live_cnt > 0 &&
+	     ((jiffies - dev->trans_start) > DMFE_TX_TIMEOUT)) ||
+	    (db->rx_error_cnt > 3)) {
 		/*
 		   printk("wait_reset %x, tx cnt %x, rx err %x, time
%x\n", db->wait_reset, db->tx_packet_cnt, db->rx_error_cnt,
jiffies-dev->trans_start);
 		 */
-		DMFE_DBUG(0, "Warn!! Warn!! Tx/Rx moniotr step1",
db->tx_packet_cnt);
+		DMFE_DBUG(0, "Warn!! Warn!! Tx/Rx monitor step1", 0);
 		dmfe_dynamic_reset(dev);
 		db->timer.expires = DMFE_TIMER_WUT;
 		add_timer(&db->timer);
@@ -1022,8 +1033,7 @@
 	dmfe_free_rxbuffer(db);
 
 	/* system variable init */
-	db->tx_packet_cnt = 0;
-	db->tx_queue_cnt = 0;
+	db->tx_live_cnt = 0;
 	db->rx_avail_cnt = 0;
 	db->link_failed = 0;
 	db->wait_reset = 0;
@@ -1131,12 +1141,14 @@
 static void update_cr6(u32 cr6_data, u32 ioaddr)
 {
 	u32 cr6_tmp;
-
+	unsigned long flags;
+	spin_lock_irqsave(&db->lock,flags);
 	cr6_tmp = cr6_data & ~0x2002;	/* stop Tx/Rx */
 	outl(cr6_tmp, ioaddr + DCR6);
 	DELAY_5US;
 	outl(cr6_data, ioaddr + DCR6);
 	cr6_tmp = inl(ioaddr + DCR6);
+	spin_unlock_restore(&db->lock,flags);
 	/* printk("CR6 update %x ", cr6_tmp); */
 }
 
@@ -1182,7 +1194,7 @@
 }
 
 /* Send a setup frame for DM9102/DM9102A
-   This setup frame initilize DM910X addres filter mode
+   This setup frame initilize DM910X address filter mode
  */
 static void send_filter_frame(struct net_device *dev, int mc_cnt)
 {
@@ -1198,6 +1210,12 @@
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
@@ -1217,26 +1235,20 @@
 		*suptr++ = addrptr[2];
 	}
 
-	for (; i < 14; i++) {
+	for (i=0; i < 14; i++) {
 		*suptr++ = 0xffff;
 		*suptr++ = 0xffff;
 		*suptr++ = 0xffff;
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
-		outl(0x1, dev->base_addr + DCR1);	/* Issue Tx
polling command */
-		update_cr6(db->cr6_data, dev->base_addr);
-	} else {
-		/* Put into TX queue */
-		db->tx_queue_cnt++;
-	}
+	/* Send the setup packet */
+	txptr->tdes0 = 0x80000000;
+	update_cr6(db->cr6_data | 0x2000, dev->base_addr);
+	outl(0x1, dev->base_addr + DCR1);	/* Issue Tx polling
command */
+	update_cr6(db->cr6_data, dev->base_addr);
 }
 
 /*
@@ -1598,14 +1610,14 @@
 		break;
 	}
 
+	printk (KERN_INFO
+		"Davicom DM91xx net driver, version " DMFE_VERSION "\n");
+
 	rc = pci_register_driver(&dmfe_driver);
 	if (rc < 0)
 		return rc;
-	if (rc > 0) {
-		printk (KERN_INFO "Davicom DM91xx net driver loaded,
version "
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
