Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279944AbRKFUfz>; Tue, 6 Nov 2001 15:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280524AbRKFUfs>; Tue, 6 Nov 2001 15:35:48 -0500
Received: from as2-1-8.va.g.bonet.se ([194.236.117.122]:2564 "EHLO
	boris.prodako.se") by vger.kernel.org with ESMTP id <S279944AbRKFUf3>;
	Tue, 6 Nov 2001 15:35:29 -0500
Date: Tue, 6 Nov 2001 21:33:45 +0100 (CET)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: <tori@boris.prodako.se>
To: Linus Torvalds <torvalds@transmeta.com>, Alan Cox <alan@redhat.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Driver update (drivers/net/dmfe.c)
Message-ID: <Pine.LNX.4.33.0111062126350.2245-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Alan,

Please include this update for dmfe.c in your next release(s).  It is 
a cleanup that takes it one big step further towards beeing 64-bit and big 
endian clean.  Entry level ethtool support is also added.

This patch includes the jiffies fix that was posted by Andreas Dilger a 
couple of days ago.

/Tobias


diff -ru linux-2.4.14.orig/drivers/net/dmfe.c linux-2.4.14/drivers/net/dmfe.c
--- linux-2.4.14.orig/drivers/net/dmfe.c	Tue Oct 23 21:28:21 2001
+++ linux-2.4.14/drivers/net/dmfe.c	Tue Nov  6 21:23:46 2001
@@ -1,6 +1,4 @@
 /*
-    dmfe.c: Version 1.36p1 2001-05-12 for Linux kernel 2.4.x
-
     A Davicom DM9102/DM9102A/DM9102A+DM9801/DM9102A+DM9802 NIC fast
     ethernet driver for Linux.
     Copyright (C) 1997  Sten Wang
@@ -38,19 +36,33 @@
 
     Tobias Ringstrom <tori@unhappy.mine.nu> :
     Cleaned up and added SMP safety.  Thanks go to Jeff Garzik,
-	Andrew Morton and Frank Davis for the SMP safety fixes.
+    Andrew Morton and Frank Davis for the SMP safety fixes.
+
+    Vojtech Pavlik <vojtech@suse.cz> :
+    Cleaned up pointer arithmetics.
+    Fixed a lot of 64bit issues.
+    Cleaned up printk()s a bit.
+    Fixed some obvious big endian problems.
+
+    Tobias Ringstrom <tori@unhappy.mine.nu> :
+    Use time_after for jiffies calculation.  Added ethtool
+    support.  Updated PCI resource allocation.  Do not
+    forget to unmap PCI mapped skbs.
 
     TODO
 
     Implement pci_driver::suspend() and pci_driver::resume()
     power management methods.
 
-    Check and fix on 64bit and big endian boxes.
+    Check on 64 bit boxes.
+    Check and fix on big endian boxes.
 
     Test and make sure PCI latency is now correct for all cases.
 */
 
-#define DMFE_VERSION "1.36p1 (May 12, 2001)"
+#define DRV_NAME	"dmfe"
+#define DRV_VERSION	"1.36.3"
+#define DRV_RELDATE	"2001-11-06"
 
 #include <linux/module.h>
 
@@ -68,6 +80,7 @@
 #include <linux/version.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
+#include <linux/ethtool.h>
 #include <linux/skbuff.h>
 #include <linux/delay.h>
 #include <linux/spinlock.h>
@@ -76,10 +89,7 @@
 #include <asm/bitops.h>
 #include <asm/io.h>
 #include <asm/dma.h>
-
-#if BITS_PER_LONG == 64
-#error FIXME: driver does not support 64-bit platforms
-#endif
+#include <asm/uaccess.h>
 
 
 /* Board/System/Debug information/definition ---------------- */
@@ -130,9 +140,9 @@
 #define DMFE_TX_TIMEOUT ((3*HZ)/2)	/* tx packet time-out time 1.5 s" */
 #define DMFE_TX_KICK 	(HZ/2)	/* tx packet Kick-out time 0.5 s" */
 
-#define DMFE_DBUG(dbug_now, msg, value) if (dmfe_debug || (dbug_now)) printk(KERN_ERR "<DMFE>: %s %lx\n", (msg), (long) (value))
+#define DMFE_DBUG(dbug_now, msg, value) if (dmfe_debug || (dbug_now)) printk(KERN_ERR DRV_NAME ": %s %lx\n", (msg), (long) (value))
 
-#define SHOW_MEDIA_TYPE(mode) printk(KERN_ERR "<DMFE>: Change Speed to %sMhz %s duplex\n",mode & 1 ?"100":"10", mode & 4 ? "full":"half");
+#define SHOW_MEDIA_TYPE(mode) printk(KERN_ERR DRV_NAME ": Change Speed to %sMhz %s duplex\n",mode & 1 ?"100":"10", mode & 4 ? "full":"half");
 
 
 /* CR9 definition: SROM/MII */
@@ -160,26 +170,22 @@
 
 /* Structure/enum declaration ------------------------------- */
 struct tx_desc {
-	u32 tdes0, tdes1, tdes2, tdes3;
-	u32 tx_skb_ptr;
-	u32 tx_buf_ptr;
-	u32 next_tx_desc;
-	u32 reserved;
-};
+        u32 tdes0, tdes1, tdes2, tdes3; /* Data for the card */
+        char *tx_buf_ptr;               /* Data for us */
+        struct tx_desc *next_tx_desc;
+} __attribute__(( aligned(32) ));
 
 struct rx_desc {
-	u32 rdes0, rdes1, rdes2, rdes3;
-	u32 rx_skb_ptr;
-	u32 rx_buf_ptr;
-	u32 next_rx_desc;
-	u32 reserved;
-};
+	u32 rdes0, rdes1, rdes2, rdes3; /* Data for the card */
+	struct sk_buff *rx_skb_ptr;	/* Data for us */
+	struct rx_desc *next_rx_desc;
+} __attribute__(( aligned(32) ));
 
 struct dmfe_board_info {
 	u32 chip_id;			/* Chip vendor/Device ID */
 	u32 chip_revision;		/* Chip revision */
 	struct DEVICE *next_dev;	/* next device */
-	struct pci_dev * net_dev;	/* PCI device */
+	struct pci_dev *pdev;		/* PCI device */
 	spinlock_t lock;
 
 	long ioaddr;			/* I/O base address */
@@ -206,10 +212,10 @@
 	struct rx_desc *first_rx_desc;
 	struct rx_desc *rx_insert_ptr;
 	struct rx_desc *rx_ready_ptr;	/* packet come pointer */
-	unsigned long tx_packet_cnt;		/* transmitted packet count */
-	unsigned long tx_queue_cnt;		/* wait to send packet count */
-	unsigned long rx_avail_cnt;		/* available rx descriptor count */
-	unsigned long interval_rx_cnt;		/* rx packet count a callback time */
+	unsigned long tx_packet_cnt;	/* transmitted packet count */
+	unsigned long tx_queue_cnt;	/* wait to send packet count */
+	unsigned long rx_avail_cnt;	/* available rx descriptor count */
+	unsigned long interval_rx_cnt;	/* rx packet count a callback time */
 
 	u16 HPNA_command;		/* For HPNA register 16 */
 	u16 HPNA_timer;			/* For HPNA remote device check */
@@ -263,7 +269,8 @@
 /* Global variable declaration ----------------------------- */
 static int __devinitdata printed_version;
 static char version[] __devinitdata =
-	KERN_INFO "Davicom DM9xxx net driver, version " DMFE_VERSION "\n";
+	KERN_INFO DRV_NAME ": Davicom DM9xxx net driver, version "
+	DRV_VERSION " (" DRV_RELDATE ")\n";
 
 static int dmfe_debug;
 static unsigned char dmfe_media_mode = DMFE_AUTO;
@@ -358,7 +365,7 @@
 static u16 read_srom_word(long ,int);
 static void dmfe_interrupt(int , void *, struct pt_regs *);
 static void dmfe_descriptor_init(struct dmfe_board_info *, unsigned long);
-static void allocated_rx_buffer(struct dmfe_board_info *);
+static void allocate_rx_buffer(struct dmfe_board_info *);
 static void update_cr6(u32, unsigned long);
 static void send_filter_frame(struct DEVICE * ,int);
 static void dm9132_id_table(struct DEVICE * ,int);
@@ -371,7 +378,7 @@
 static void dmfe_timer(unsigned long);
 static void dmfe_rx_packet(struct DEVICE *, struct dmfe_board_info *);
 static void dmfe_free_tx_pkt(struct DEVICE *, struct dmfe_board_info *);
-static void dmfe_reused_skb(struct dmfe_board_info *, struct sk_buff *);
+static void dmfe_reuse_skb(struct dmfe_board_info *, struct sk_buff *);
 static void dmfe_dynamic_reset(struct DEVICE *);
 static void dmfe_free_rxbuffer(struct dmfe_board_info *);
 static void dmfe_init_dm910x(struct DEVICE *);
@@ -391,31 +398,46 @@
 static int __devinit dmfe_init_one (struct pci_dev *pdev,
 				    const struct pci_device_id *ent)
 {
-	unsigned long pci_iobase;
-	u8 pci_irqline;
 	struct dmfe_board_info *db;	/* board information structure */
-	int i;
 	struct net_device *dev;
 	u32 dev_rev, pci_pmr;
+	int i, err;
+
+	DMFE_DBUG(0, "dmfe_init_one()", 0);
 
 	if (!printed_version++)
 		printk(version);
 
-	DMFE_DBUG(0, "dmfe_init_one()", 0);
+	/* Init network device */
+	dev = alloc_etherdev(sizeof(*db));
+	if (dev == NULL)
+		return -ENOMEM;
+	SET_MODULE_OWNER(dev);
+
+	if (pci_set_dma_mask(pdev, 0xffffffff)) {
+		printk(KERN_WARNING DRV_NAME ": 32-bit PCI DMA not available.\n");
+		err = -ENODEV;
+		goto err_out_free;
+	}
 
 	/* Enable Master/IO access, Disable memory access */
-	i = pci_enable_device(pdev);
-	if (i)
-		return i;
-	pci_set_master(pdev);
+	err = pci_enable_device(pdev);
+	if (err)
+		goto err_out_free;
+
+	if (!pci_resource_start(pdev, 0)) {
+		printk(KERN_ERR DRV_NAME ": I/O base is zero\n");
+		err = -ENODEV;
+		goto err_out_disable;
+	}
 
-	pci_iobase = pci_resource_start(pdev, 0);
-	pci_irqline = pdev->irq;
+	/* Read Chip revision */
+	pci_read_config_dword(pdev, PCI_REVISION_ID, &dev_rev);
 
-	/* iobase check */
-	if (pci_iobase == 0) {
-		printk(KERN_ERR "<DMFE>: I/O base is zero\n");
-		return -ENODEV;
+	if (pci_resource_len(pdev, 0) < (CHK_IO_SIZE(pdev, dev_rev)) ) {
+		printk(KERN_ERR DRV_NAME ": Allocated I/O size too small\n");
+		err = -ENODEV;
+		goto err_out_disable;
 	}
 
 #if 0	/* pci_{enable_device,set_master} sets minimum latency for us now */
@@ -427,37 +449,20 @@
 	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0x80);
 #endif
 
-	/* Read Chip revision */
-	pci_read_config_dword(pdev, PCI_REVISION_ID, &dev_rev);
-
-	/* Init network device */
-	dev = alloc_etherdev(sizeof(*db));
-	if (dev == NULL)
-		return -ENOMEM;
-	SET_MODULE_OWNER(dev);
-
-	/* IO range check */
-	if (pci_resource_len (pdev, 0) < (CHK_IO_SIZE(pdev, dev_rev)) ) {
-		printk(KERN_ERR "<DMFE>: Allocated I/O size too small\n");
-		goto err_out;
-	}
-
-	if (!request_region(pci_iobase,
-			    pci_resource_len (pdev, 0),
-			    dev->name)) {
-		printk(KERN_ERR "<DMFE>: I/O conflict : IO=%lx Range=%x\n",
-		       pci_iobase, CHK_IO_SIZE(pdev, dev_rev));
-		goto err_out;
+	if (pci_request_regions(pdev, DRV_NAME)) {
+		printk(KERN_ERR DRV_NAME ": Failed to request PCI regions\n");
+		err = -ENODEV;
+		goto err_out_disable;
 	}
 
 	/* Init system & device */
 	db = dev->priv;
 
-	/* Allocated Tx/Rx descriptor memory */
+	/* Allocate Tx/Rx descriptor memory */
 	db->desc_pool_ptr = pci_alloc_consistent(pdev, sizeof(struct tx_desc) * DESC_ALL_CNT + 0x20, &db->desc_pool_dma_ptr);
 	db->buf_pool_ptr = pci_alloc_consistent(pdev, TX_BUF_ALLOC * TX_DESC_CNT + 4, &db->buf_pool_dma_ptr);
 
-	db->first_tx_desc = (struct tx_desc *)db->desc_pool_ptr;
+	db->first_tx_desc = (struct tx_desc *) db->desc_pool_ptr;
 	db->first_tx_desc_dma = db->desc_pool_dma_ptr;
 	db->buf_pool_start = db->buf_pool_ptr;
 	db->buf_pool_dma_start = db->buf_pool_dma_ptr;
@@ -465,13 +470,13 @@
 	pdev->driver_data = dev;
 
 	db->chip_id = ent->driver_data;
-	db->ioaddr = pci_iobase;
+	db->ioaddr = pci_resource_start(pdev, 0);
 	db->chip_revision = dev_rev;
 
-	db->net_dev = pdev;
+	db->pdev = pdev;
 
-	dev->base_addr = pci_iobase;
-	dev->irq = pci_irqline;
+	dev->base_addr = db->ioaddr;
+	dev->irq = pdev->irq;
 	pci_set_drvdata(pdev, dev);
 	dev->open = &dmfe_open;
 	dev->hard_start_xmit = &dmfe_start_xmit;
@@ -490,29 +495,37 @@
 
 	/* read 64 word srom data */
 	for (i = 0; i < 64; i++)
-		((u16 *) db->srom)[i] = read_srom_word(pci_iobase, i);
+		((u16 *) db->srom)[i] = cpu_to_le16(read_srom_word(db->ioaddr, i));
 
 	/* Set Node address */
 	for (i = 0; i < 6; i++)
 		dev->dev_addr[i] = db->srom[20 + i];
 
-	i = register_netdev (dev);
-	if (i) goto err_out;
-
-	printk(KERN_INFO "%s: Davicom DM%04lx at 0x%lx,",
-	       dev->name,
-	       ent->driver_data >> 16,
-	       pci_iobase);
+	err = register_netdev (dev);
+	if (err)
+		goto err_out_res;
+
+	printk(KERN_INFO "%s: Davicom DM%04lx at pci%s,",
+		dev->name,
+		ent->driver_data >> 16,
+		pdev->slot_name);
 	for (i = 0; i < 6; i++)
 		printk("%c%02x", i ? ':' : ' ', dev->dev_addr[i]);
-	printk(", IRQ %d\n", pci_irqline);
+	printk(", irq %d.\n", dev->irq);
+
+	pci_set_master(pdev);
 
 	return 0;
 
-err_out:
+err_out_res:
+	pci_release_regions(pdev);
+err_out_disable:
+	pci_disable_device(pdev);
+err_out_free:
 	pci_set_drvdata(pdev, NULL);
 	kfree(dev);
-	return -ENODEV;
+
+	return err;
 }
 
 
@@ -524,14 +537,13 @@
 	DMFE_DBUG(0, "dmfe_remove_one()", 0);
 
  	if (dev) {
-		pci_free_consistent(db->net_dev, sizeof(struct tx_desc) *
+		pci_free_consistent(db->pdev, sizeof(struct tx_desc) *
 					DESC_ALL_CNT + 0x20, db->desc_pool_ptr,
  					db->desc_pool_dma_ptr);
-		pci_free_consistent(db->net_dev, TX_BUF_ALLOC * TX_DESC_CNT + 4,
+		pci_free_consistent(db->pdev, TX_BUF_ALLOC * TX_DESC_CNT + 4,
 					db->buf_pool_ptr, db->buf_pool_dma_ptr);
 		unregister_netdev(dev);
-		release_region(dev->base_addr,
-				CHK_IO_SIZE(pdev, db->chip_revision));
+		pci_release_regions(pdev);
 		kfree(dev);	/* free board information */
 		pci_set_drvdata(pdev, NULL);
 	}
@@ -552,7 +564,7 @@
 
 	DMFE_DBUG(0, "dmfe_open", 0);
 
-	ret =  request_irq(dev->irq, &dmfe_interrupt, SA_SHIRQ, dev->name, dev);
+	ret = request_irq(dev->irq, &dmfe_interrupt, SA_SHIRQ, dev->name, dev);
 	if (ret)
 		return ret;
 
@@ -683,7 +695,7 @@
 
 	/* Too large packet check */
 	if (skb->len > MAX_PACKET_SIZE) {
-		printk(KERN_ERR "<DMFE>: big packet = %d\n", (u16)skb->len);
+		printk(KERN_ERR DRV_NAME ": big packet = %d\n", (u16)skb->len);
 		dev_kfree_skb(skb);
 		return 0;
 	}
@@ -693,7 +705,7 @@
 	/* No Tx resource check, it never happen nromally */
 	if (db->tx_queue_cnt >= TX_FREE_DESC_CNT) {
 		spin_unlock_irqrestore(&db->lock, flags);
-		printk(KERN_ERR "<DMFE>: No Tx resource %ld\n", db->tx_queue_cnt);
+		printk(KERN_ERR DRV_NAME ": No Tx resource %ld\n", db->tx_queue_cnt);
 		return 1;
 	}
 
@@ -702,11 +714,11 @@
 
 	/* transmit this packet */
 	txptr = db->tx_insert_ptr;
-	memcpy( (char *) txptr->tx_buf_ptr, (char *) skb->data, skb->len);
+	memcpy(txptr->tx_buf_ptr, skb->data, skb->len);
 	txptr->tdes1 = cpu_to_le32(0xe1000000 | skb->len);
 
 	/* Point to next transmit free descriptor */
-	db->tx_insert_ptr = (struct tx_desc *) txptr->next_tx_desc;
+	db->tx_insert_ptr = txptr->next_tx_desc;
 
 	/* Transmit Packet Process */
 	if ( (!db->tx_queue_cnt) && (db->tx_packet_cnt < TX_MAX_SEND_CNT) ) {
@@ -765,7 +777,7 @@
 
 #if 0
 	/* show statistic counter */
-	printk("<DMFE>: FU:%lx EC:%lx LC:%lx NC:%lx LOC:%lx TXJT:%lx RESET:%lx RCR8:%lx FAL:%lx TT:%lx\n",
+	printk(DRV_NAME ": FU:%lx EC:%lx LC:%lx NC:%lx LOC:%lx TXJT:%lx RESET:%lx RCR8:%lx FAL:%lx TT:%lx\n",
 		db->tx_fifo_underrun, db->tx_excessive_collision,
 		db->tx_late_collision, db->tx_no_carrier, db->tx_loss_carrier,
 		db->tx_jabber_timeout, db->reset_count, db->reset_cr8,
@@ -822,9 +834,9 @@
 	if ( (db->cr5_data & 0x40) && db->rx_avail_cnt )
 		dmfe_rx_packet(dev, db);
 
-	/* reallocated rx descriptor buffer */
+	/* reallocate rx descriptor buffer */
 	if (db->rx_avail_cnt<RX_DESC_CNT)
-		allocated_rx_buffer(db);
+		allocate_rx_buffer(db);
 
 	/* Free the transmitted descriptor */
 	if ( db->cr5_data & 0x01)
@@ -852,11 +864,13 @@
 {
 	struct tx_desc *txptr;
 	unsigned long ioaddr = dev->base_addr;
+	u32 tdes0;
 
 	txptr = db->tx_remove_ptr;
 	while(db->tx_packet_cnt) {
-		/* printk("<DMFE>: tdes0=%x\n", txptr->tdes0); */
-		if (txptr->tdes0 & 0x80000000)
+		tdes0 = le32_to_cpu(txptr->tdes0);
+		/* printk(DRV_NAME ": tdes0=%x\n", tdes0); */
+		if (tdes0 & 0x80000000)
 			break;
 
 		/* A packet sent completed */
@@ -864,38 +878,38 @@
 		db->stats.tx_packets++;
 
 		/* Transmit statistic counter */
-		if ( txptr->tdes0 != 0x7fffffff ) {
-			/* printk("<DMFE>: tdes0=%x\n", txptr->tdes0); */
-			db->stats.collisions += (txptr->tdes0 >> 3) & 0xf;
-			db->stats.tx_bytes += txptr->tdes1 & 0x7ff;
-			if (txptr->tdes0 & TDES0_ERR_MASK) {
+		if ( tdes0 != 0x7fffffff ) {
+			/* printk(DRV_NAME ": tdes0=%x\n", tdes0); */
+			db->stats.collisions += (tdes0 >> 3) & 0xf;
+			db->stats.tx_bytes += le32_to_cpu(txptr->tdes1) & 0x7ff;
+			if (tdes0 & TDES0_ERR_MASK) {
 				db->stats.tx_errors++;
 
-				if (txptr->tdes0 & 0x0002) {	/* UnderRun */
+				if (tdes0 & 0x0002) {	/* UnderRun */
 					db->tx_fifo_underrun++;
 					if ( !(db->cr6_data & CR6_SFT) ) {
 						db->cr6_data = db->cr6_data | CR6_SFT;
 						update_cr6(db->cr6_data, db->ioaddr);
 					}
 				}
-				if (txptr->tdes0 & 0x0100)
+				if (tdes0 & 0x0100)
 					db->tx_excessive_collision++;
-				if (txptr->tdes0 & 0x0200)
+				if (tdes0 & 0x0200)
 					db->tx_late_collision++;
-				if (txptr->tdes0 & 0x0400)
+				if (tdes0 & 0x0400)
 					db->tx_no_carrier++;
-				if (txptr->tdes0 & 0x0800)
+				if (tdes0 & 0x0800)
 					db->tx_loss_carrier++;
-				if (txptr->tdes0 & 0x4000)
+				if (tdes0 & 0x4000)
 					db->tx_jabber_timeout++;
 			}
 		}
 
-    		txptr = (struct tx_desc *) txptr->next_tx_desc;
+    		txptr = txptr->next_tx_desc;
 	}/* End of while */
 
 	/* Update TX remove pointer to next */
-	db->tx_remove_ptr = (struct tx_desc *) txptr;
+	db->tx_remove_ptr = txptr;
 
 	/* Send the Tx packet in queue */
 	if ( (db->tx_packet_cnt < TX_MAX_SEND_CNT) && db->tx_queue_cnt ) {
@@ -921,49 +935,51 @@
 	struct rx_desc *rxptr;
 	struct sk_buff *skb;
 	int rxlen;
+	u32 rdes0;
 
 	rxptr = db->rx_ready_ptr;
 
 	while(db->rx_avail_cnt) {
-		if (rxptr->rdes0 & 0x80000000)	/* packet owner check */
+		rdes0 = le32_to_cpu(rxptr->rdes0);
+		if (rdes0 & 0x80000000)	/* packet owner check */
 			break;
 
 		db->rx_avail_cnt--;
 		db->interval_rx_cnt++;
 
-		if ( (rxptr->rdes0 & 0x300) != 0x300) {
+		pci_unmap_single(db->pdev, le32_to_cpu(rxptr->rdes2), RX_ALLOC_SIZE, PCI_DMA_FROMDEVICE);
+		if ( (rdes0 & 0x300) != 0x300) {
 			/* A packet without First/Last flag */
-			/* reused this SKB */
-			DMFE_DBUG(0, "Reused SK buffer, rdes0", rxptr->rdes0);
-			dmfe_reused_skb(db, (struct sk_buff *) rxptr->rx_skb_ptr);
+			/* reuse this SKB */
+			DMFE_DBUG(0, "Reuse SK buffer, rdes0", rdes0);
+			dmfe_reuse_skb(db, rxptr->rx_skb_ptr);
 		} else {
 			/* A packet with First/Last flag */
-			rxlen = ( (rxptr->rdes0 >> 16) & 0x3fff) - 4;
+			rxlen = ( (rdes0 >> 16) & 0x3fff) - 4;
 
 			/* error summary bit check */
-			if (rxptr->rdes0 & 0x8000) {
+			if (rdes0 & 0x8000) {
 				/* This is a error packet */
-				//printk("<DMFE>: rdes0: %lx\n", rxptr->rdes0);
+				//printk(DRV_NAME ": rdes0: %lx\n", rdes0);
 				db->stats.rx_errors++;
-				if (rxptr->rdes0 & 1)
+				if (rdes0 & 1)
 					db->stats.rx_fifo_errors++;
-				if (rxptr->rdes0 & 2)
+				if (rdes0 & 2)
 					db->stats.rx_crc_errors++;
-				if (rxptr->rdes0 & 0x80)
+				if (rdes0 & 0x80)
 					db->stats.rx_length_errors++;
 			}
 
-			if ( !(rxptr->rdes0 & 0x8000) ||
+			if ( !(rdes0 & 0x8000) ||
 				((db->cr6_data & CR6_PM) && (rxlen>6)) ) {
-				skb = (struct sk_buff *) rxptr->rx_skb_ptr;
+				skb = rxptr->rx_skb_ptr;
 
 				/* Received Packet CRC check need or not */
 				if ( (db->dm910x_chk_mode & 1) &&
 					(cal_CRC(skb->tail, rxlen, 1) !=
-					(*(unsigned long *) (skb->tail+rxlen) )
-					) ) {
+					(*(u32 *) (skb->tail+rxlen) ))) { /* FIXME (?) */
 					/* Found a error received packet */
-					dmfe_reused_skb(db, (struct sk_buff *) rxptr->rx_skb_ptr);
+					dmfe_reuse_skb(db, rxptr->rx_skb_ptr);
 					db->dm910x_chk_mode = 3;
 				} else {
 					/* Good packet, send to upper layer */
@@ -971,11 +987,11 @@
 					if ( (rxlen < RX_COPY_SIZE) &&
 						( (skb = dev_alloc_skb(rxlen + 2) )
 						!= NULL) ) {
-						/* size less than COPY_SIZE, allocated a rxlen SKB */
+						/* size less than COPY_SIZE, allocate a rxlen SKB */
 						skb->dev = dev;
 						skb_reserve(skb, 2); /* 16byte align */
-						memcpy(skb_put(skb, rxlen), ((struct sk_buff *) rxptr->rx_skb_ptr)->tail, rxlen);
-						dmfe_reused_skb(db, (struct sk_buff *) rxptr->rx_skb_ptr);
+						memcpy(skb_put(skb, rxlen), rxptr->rx_skb_ptr->tail, rxlen);
+						dmfe_reuse_skb(db, rxptr->rx_skb_ptr);
 					} else {
 						skb->dev = dev;
 						skb_put(skb, rxlen);
@@ -988,12 +1004,12 @@
 				}
 			} else {
 				/* Reuse SKB buffer when the packet is error */
-				DMFE_DBUG(0, "Reused SK buffer, rdes0", rxptr->rdes0);
-				dmfe_reused_skb(db, (struct sk_buff *) rxptr->rx_skb_ptr);
+				DMFE_DBUG(0, "Reuse SK buffer, rdes0", rdes0);
+				dmfe_reuse_skb(db, rxptr->rx_skb_ptr);
 			}
 		}
 
-		rxptr = (struct rx_desc *) rxptr->next_rx_desc;
+		rxptr = rxptr->next_rx_desc;
 	}
 
 	db->rx_ready_ptr = rxptr;
@@ -1051,19 +1067,57 @@
 
 
 /*
+ *	Process the ethtool ioctl command
+ */
+
+static int dmfe_ethtool_ioctl(struct net_device *dev, void *useraddr)
+{
+	struct dmfe_board_info *db = dev->priv;
+	struct ethtool_drvinfo info = { ETHTOOL_GDRVINFO };
+	u32 ethcmd;
+
+	if (copy_from_user(&ethcmd, useraddr, sizeof(ethcmd)))
+		return -EFAULT;
+
+        switch (ethcmd) {
+        case ETHTOOL_GDRVINFO:
+		strcpy(info.driver, DRV_NAME);
+		strcpy(info.version, DRV_VERSION);
+		if (db->pdev)
+			strcpy(info.bus_info, db->pdev->slot_name);
+		else
+			sprintf(info.bus_info, "EISA 0x%lx %d",
+				dev->base_addr, dev->irq);
+		if (copy_to_user(useraddr, &info, sizeof(info)))
+			return -EFAULT;
+		return 0;
+        }
+
+	return -EOPNOTSUPP;
+}
+
+
+/*
  *	Process the upper socket ioctl command
  */
 
 static int dmfe_do_ioctl(struct DEVICE *dev, struct ifreq *ifr, int cmd)
 {
+	int retval = -EOPNOTSUPP;
 	DMFE_DBUG(0, "dmfe_do_ioctl()", 0);
-	return 0;
+
+	switch(cmd) {
+	case SIOCETHTOOL:
+		return dmfe_ethtool_ioctl(dev, (void*)ifr->ifr_data);
+	}
+
+	return retval;
 }
 
 
 /*
  *	A periodic timer routine
- *	Dynamic media sense, allocated Rx buffer...
+ *	Dynamic media sense, allocate Rx buffer...
  */
 
 static void dmfe_timer(unsigned long data)
@@ -1109,11 +1163,11 @@
 
 	/* TX polling kick monitor */
 	if ( db->tx_packet_cnt &&
-		((jiffies - dev->trans_start) > DMFE_TX_KICK) ) {
+	     time_after(jiffies, dev->trans_start + DMFE_TX_KICK) ) {
 		outl(0x1, dev->base_addr + DCR1);   /* Tx polling again */
 
 		/* TX Timeout */
-		if ( (jiffies - dev->trans_start) > DMFE_TX_TIMEOUT ) {
+		if ( time_after(jiffies, dev->trans_start + DMFE_TX_TIMEOUT) ) {
 			db->reset_TXtimeout++;
 			db->wait_reset = 1;
 			printk(KERN_WARNING "%s: Tx timeout - resetting\n",
@@ -1244,35 +1298,36 @@
 
 	/* free allocated rx buffer */
 	while (db->rx_avail_cnt) {
-		dev_kfree_skb( (void *) (db->rx_ready_ptr->rx_skb_ptr) );
-		db->rx_ready_ptr = (struct rx_desc *) db->rx_ready_ptr->next_rx_desc;
+		dev_kfree_skb(db->rx_ready_ptr->rx_skb_ptr);
+		db->rx_ready_ptr = db->rx_ready_ptr->next_rx_desc;
 		db->rx_avail_cnt--;
 	}
 }
 
 
 /*
- *	Reused the SK buffer
+ *	Reuse the SK buffer
  */
 
-static void dmfe_reused_skb(struct dmfe_board_info *db, struct sk_buff * skb)
+static void dmfe_reuse_skb(struct dmfe_board_info *db, struct sk_buff * skb)
 {
 	struct rx_desc *rxptr = db->rx_insert_ptr;
 
-	if (!(rxptr->rdes0 & 0x80000000)) {
-		rxptr->rx_skb_ptr = (u32) skb;
-		rxptr->rdes2 = cpu_to_le32( pci_map_single(db->net_dev, skb->tail, RX_ALLOC_SIZE, PCI_DMA_FROMDEVICE) );
+	if (!(rxptr->rdes0 & cpu_to_le32(0x80000000))) {
+		rxptr->rx_skb_ptr = skb;
+		rxptr->rdes2 = cpu_to_le32( pci_map_single(db->pdev, skb->tail, RX_ALLOC_SIZE, PCI_DMA_FROMDEVICE) );
+		wmb();
 		rxptr->rdes0 = cpu_to_le32(0x80000000);
 		db->rx_avail_cnt++;
-		db->rx_insert_ptr = (struct rx_desc *) rxptr->next_rx_desc;
+		db->rx_insert_ptr = rxptr->next_rx_desc;
 	} else
-		DMFE_DBUG(0, "SK Buffer reused method error", db->rx_avail_cnt);
+		DMFE_DBUG(0, "SK Buffer reuse method error", db->rx_avail_cnt);
 }
 
 
 /*
  *	Initialize transmit/Receive descriptor
- *	Using Chain structure, and allocated Tx/Rx buffer
+ *	Using Chain structure, and allocate Tx/Rx buffer
  */
 
 static void dmfe_descriptor_init(struct dmfe_board_info *db, unsigned long ioaddr)
@@ -1292,8 +1347,8 @@
 	outl(db->first_tx_desc_dma, ioaddr + DCR4);     /* TX DESC address */
 
 	/* rx descriptor start pointer */
-	db->first_rx_desc = (struct rx_desc *) ( (u32) db->first_tx_desc + sizeof(struct rx_desc) * TX_DESC_CNT );
-	db->first_rx_desc_dma = ( db->first_tx_desc_dma + sizeof(struct rx_desc) * TX_DESC_CNT);
+	db->first_rx_desc = (void *)db->first_tx_desc + sizeof(struct tx_desc) * TX_DESC_CNT;
+	db->first_rx_desc_dma =  db->first_tx_desc_dma + sizeof(struct tx_desc) * TX_DESC_CNT;
 	db->rx_insert_ptr = db->first_rx_desc;
 	db->rx_ready_ptr = db->first_rx_desc;
 	outl(db->first_rx_desc_dma, ioaddr + DCR3);	/* RX DESC address */
@@ -1303,18 +1358,18 @@
 	tmp_buf_dma = db->buf_pool_dma_start;
 	tmp_tx_dma = db->first_tx_desc_dma;
 	for (tmp_tx = db->first_tx_desc, i = 0; i < TX_DESC_CNT; i++, tmp_tx++) {
-		tmp_tx->tx_buf_ptr = (u32) tmp_buf;
+		tmp_tx->tx_buf_ptr = tmp_buf;
 		tmp_tx->tdes0 = cpu_to_le32(0);
 		tmp_tx->tdes1 = cpu_to_le32(0x81000000);	/* IC, chain */
 		tmp_tx->tdes2 = cpu_to_le32(tmp_buf_dma);
 		tmp_tx_dma += sizeof(struct tx_desc);
 		tmp_tx->tdes3 = cpu_to_le32(tmp_tx_dma);
-		tmp_tx->next_tx_desc = (u32) ((u32) tmp_tx + sizeof(struct tx_desc));
-		tmp_buf = (unsigned char *) ((u32) tmp_buf + TX_BUF_ALLOC);
+		tmp_tx->next_tx_desc = tmp_tx + 1;
+		tmp_buf = tmp_buf + TX_BUF_ALLOC;
 		tmp_buf_dma = tmp_buf_dma + TX_BUF_ALLOC;
 	}
 	(--tmp_tx)->tdes3 = cpu_to_le32(db->first_tx_desc_dma);
-	tmp_tx->next_tx_desc = (u32) db->first_tx_desc;
+	tmp_tx->next_tx_desc = db->first_tx_desc;
 
 	 /* Init Receive descriptor chain */
 	tmp_rx_dma=db->first_rx_desc_dma;
@@ -1323,13 +1378,13 @@
 		tmp_rx->rdes1 = cpu_to_le32(0x01000600);
 		tmp_rx_dma += sizeof(struct rx_desc);
 		tmp_rx->rdes3 = cpu_to_le32(tmp_rx_dma);
-		tmp_rx->next_rx_desc = (u32) ((u32) tmp_rx + sizeof(struct rx_desc));
+		tmp_rx->next_rx_desc = tmp_rx + 1;
 	}
 	(--tmp_rx)->rdes3 = cpu_to_le32(db->first_rx_desc_dma);
-	tmp_rx->next_rx_desc = (u32) db->first_rx_desc;
+	tmp_rx->next_rx_desc = db->first_rx_desc;
 
-	/* pre-allocated Rx buffer */
-	allocated_rx_buffer(db);
+	/* pre-allocate Rx buffer */
+	allocate_rx_buffer(db);
 }
 
 
@@ -1438,7 +1493,7 @@
 	}
 
 	/* prepare the setup frame */
-	db->tx_insert_ptr = (struct tx_desc *) txptr->next_tx_desc;
+	db->tx_insert_ptr = txptr->next_tx_desc;
 	txptr->tdes1 = cpu_to_le32(0x890000c0);
 
 	/* Resource Check and Send the setup packet */
@@ -1457,10 +1512,10 @@
 
 /*
  *	Allocate rx buffer,
- *	As possible as allocated maxiumn Rx buffer
+ *	As possible as allocate maxiumn Rx buffer
  */
 
-static void allocated_rx_buffer(struct dmfe_board_info *db)
+static void allocate_rx_buffer(struct dmfe_board_info *db)
 {
 	struct rx_desc *rxptr;
 	struct sk_buff *skb;
@@ -1470,10 +1525,11 @@
 	while(db->rx_avail_cnt < RX_DESC_CNT) {
 		if ( ( skb = dev_alloc_skb(RX_ALLOC_SIZE) ) == NULL )
 			break;
-		rxptr->rx_skb_ptr = (u32) skb; /* FIXME */
-		rxptr->rdes2 = cpu_to_le32( pci_map_single(db->net_dev, skb->tail, RX_ALLOC_SIZE, PCI_DMA_FROMDEVICE) );
+		rxptr->rx_skb_ptr = skb; /* FIXME (?) */
+		rxptr->rdes2 = cpu_to_le32( pci_map_single(db->pdev, skb->tail, RX_ALLOC_SIZE, PCI_DMA_FROMDEVICE) );
+		wmb();
 		rxptr->rdes0 = cpu_to_le32(0x80000000);
-		rxptr = (struct rx_desc *) rxptr->next_rx_desc;
+		rxptr = rxptr->next_rx_desc;
 		db->rx_avail_cnt++;
 	}
 
@@ -1540,7 +1596,7 @@
 			phy_mode = phy_read(db->ioaddr, db->phy_addr, 7, db->chip_id) & 0xf000;
 		else 				/* DM9102/DM9102A */
 			phy_mode = phy_read(db->ioaddr, db->phy_addr, 17, db->chip_id) & 0xf000;
-		/* printk("<DMFE>: Phy_mode %x ",phy_mode); */
+		/* printk(DRV_NAME ": Phy_mode %x ",phy_mode); */
 		switch (phy_mode) {
 		case 0x1000: db->op_mode = DMFE_10MHF; break;
 		case 0x2000: db->op_mode = DMFE_10MFD; break;
@@ -1830,7 +1886,7 @@
 	if ( ( (int) srom[18] & 0xff) == SROM_V41_CODE) {
 		/* SROM V4.01 */
 		/* Get NIC support media mode */
-		db->NIC_capability = *(u16 *) (&srom[34]);
+		db->NIC_capability = le16_to_cpup(srom + 34);
 		db->PHY_reg4 = 0;
 		for (tmp_reg = 1; tmp_reg < 0x10; tmp_reg <<= 1) {
 			switch( db->NIC_capability & tmp_reg ) {
@@ -1842,7 +1898,7 @@
 		}
 
 		/* Media Mode Force or not check */
-		dmfe_mode = *( (int *) &srom[34]) & *( (int *) &srom[36] );
+		dmfe_mode = le32_to_cpup(srom + 34) & le32_to_cpup(srom + 36);
 		switch(dmfe_mode) {
 		case 0x4: dmfe_media_mode = DMFE_100MHF; break;	/* 100MHF */
 		case 0x2: dmfe_media_mode = DMFE_10MFD; break;	/* 10MFD */
@@ -2024,7 +2080,7 @@
 MODULE_PARM_DESC(debug, "Davicom DM9xxx enable debugging (0-1)");
 MODULE_PARM_DESC(mode, "Davicom DM9xxx: Bit 0: 10/100Mbps, bit 2: duplex, bit 8: HomePNA");
 MODULE_PARM_DESC(SF_mode, "Davicom DM9xxx special function (bit 0: VLAN, bit 1 Flow Control, bit 2: TX pause packet)");
-                                                                                                                                
+
 /*	Description:
  *	when user used insmod to add module, system invoked init_module()
  *	to initilize and register.


