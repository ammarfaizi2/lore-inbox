Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132503AbQKZSxM>; Sun, 26 Nov 2000 13:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132551AbQKZSxC>; Sun, 26 Nov 2000 13:53:02 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:38408 "EHLO se1.cogenit.fr")
        by vger.kernel.org with ESMTP id <S132503AbQKZSwu>;
        Sun, 26 Nov 2000 13:52:50 -0500
Date: Sun, 26 Nov 2000 19:22:23 +0100
From: Francois ROMIEU <romieu@cogenit.fr>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.0-test11 - drivers/net/epic100.c - use of DMA mapping
Message-ID: <20001126192223.A28844@se1.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
X-Organisation: Marie's fan club
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  the following updates the epic100.c driver to the DMA mapping api.
It compiles. It survives ping flood (small/big sizes), insmod/rmmod and seems
to work as it should on an intel machine. Big-endian testers welcome.

--- linux-2.4.0-test11.orig/drivers/net/epic100.c	Sun Nov 26 11:41:47 2000
+++ linux-2.4.0-test11/drivers/net/epic100.c	Sun Nov 26 13:57:01 2000
@@ -73,6 +73,8 @@
 #define TX_RING_SIZE	16
 #define TX_QUEUE_LEN	10		/* Limit ring entries actually used.  */
 #define RX_RING_SIZE	32
+#define TX_TOTAL_SIZE	TX_RING_SIZE*sizeof(struct epic_tx_desc)
+#define RX_TOTAL_SIZE	RX_RING_SIZE*sizeof(struct epic_rx_desc)
 
 /* Operational parameters that usually are not changed. */
 /* Time in jiffies before concluding the transmitter is hung. */
@@ -172,8 +174,6 @@
 #define EPIC_IOTYPE PCI_USES_MASTER|PCI_USES_MEM|PCI_ADDR1
 #endif
 
-#define virt_to_le32desc(addr)  cpu_to_le32(virt_to_bus(addr))
-
 typedef enum {
 	SMSC_83C170_0,
 	SMSC_83C170,
@@ -276,14 +276,16 @@
 
 
 struct epic_private {
-	/* Tx and Rx rings first so that they remain paragraph aligned. */
-	struct epic_rx_desc rx_ring[RX_RING_SIZE];
-	struct epic_tx_desc tx_ring[TX_RING_SIZE];
+	struct epic_rx_desc *rx_ring;
+	struct epic_tx_desc *tx_ring;
 	/* The saved address of a sent-in-place packet/buffer, for skfree(). */
 	struct sk_buff* tx_skbuff[TX_RING_SIZE];
 	/* The addresses of receive-in-place skbuffs. */
 	struct sk_buff* rx_skbuff[RX_RING_SIZE];
 
+	dma_addr_t tx_ring_dma;
+	dma_addr_t rx_ring_dma;
+
 	/* Ring pointers. */
 	spinlock_t lock;				/* Group with Tx control cache line. */
 	unsigned int cur_tx, dirty_tx;
@@ -342,6 +344,8 @@
 	struct epic_chip_info *ci = &epic_chip_info[ent->driver_data];
 	long ioaddr;
 	int chip_idx = (int) ent->driver_data;
+	void *ring_space;
+	dma_addr_t ring_dma;
 
 	card_idx++;
 	
@@ -392,6 +396,21 @@
 	}
 #endif
 
+	pdev->driver_data = dev;
+	ep = dev->priv;
+
+	ring_space = pci_alloc_consistent(pdev, TX_TOTAL_SIZE, &ring_dma);
+	if (!ring_space)
+		goto err_out_iounmap;
+	ep->tx_ring = (struct epic_tx_desc *)ring_space;
+	ep->tx_ring_dma = ring_dma;
+
+	ring_space = pci_alloc_consistent(pdev, RX_TOTAL_SIZE, &ring_dma);
+	if (!ring_space)
+		goto err_out_unmap_tx;
+	ep->rx_ring = (struct epic_rx_desc *)ring_space;
+	ep->rx_ring_dma = ring_dma;
+
 	if (dev->mem_start) {
 		option = dev->mem_start;
 		duplex = (dev->mem_start & 16) ? 1 : 0;
@@ -402,12 +421,10 @@
 			duplex = full_duplex[card_idx];
 	}
 
-	pdev->driver_data = dev;
 
 	dev->base_addr = ioaddr;
 	dev->irq = pdev->irq;
 
-	ep = dev->priv;
 	ep->pci_dev = pdev;
 	ep->chip_flags = ci->drv_flags;
 	spin_lock_init (&ep->lock);
@@ -493,14 +510,18 @@
 
 	return 0;
 
-#ifndef USE_IO_OPS
-err_out_free_mmio:
-	release_mem_region (pci_resource_start (pdev, 1),
-			    pci_resource_len (pdev, 1));
+err_out_unmap_tx:
+	pci_free_consistent(pdev, TX_TOTAL_SIZE, ep->tx_ring, ep->tx_ring_dma);
+err_out_iounmap:
+#ifdef USE_IO_OPS
+	iounmap(ioaddr);
 #endif
+err_out_free_mmio:
+	release_mem_region(pci_resource_start(pdev, 1),
+			   pci_resource_len(pdev, 1));
 err_out_free_pio:
-	release_region (pci_resource_start (pdev, 0),
-			pci_resource_len (pdev, 0));
+	release_region(pci_resource_start(pdev, 0),
+		       pci_resource_len(pdev, 0));
 err_out_free_netdev:
 	unregister_netdev(dev);
 	kfree(dev);
@@ -668,8 +689,8 @@
 	}
 
 	outl(ep->full_duplex ? 0x7F : 0x79, ioaddr + TxCtrl);
-	outl(virt_to_bus(ep->rx_ring), ioaddr + PRxCDAR);
-	outl(virt_to_bus(ep->tx_ring), ioaddr + PTxCDAR);
+	outl(ep->rx_ring_dma, ioaddr + PRxCDAR);
+	outl(ep->tx_ring_dma, ioaddr + PTxCDAR);
 
 	/* Start the chip's Rx process. */
 	set_rx_mode(dev);
@@ -755,9 +776,10 @@
 	ep->tx_threshold = TX_FIFO_THRESH;
 	outl(ep->tx_threshold, ioaddr + TxThresh);
 	outl(ep->full_duplex ? 0x7F : 0x79, ioaddr + TxCtrl);
-	outl(virt_to_bus(&ep->rx_ring[ep->cur_rx%RX_RING_SIZE]), ioaddr + PRxCDAR);
-	outl(virt_to_bus(&ep->tx_ring[ep->dirty_tx%TX_RING_SIZE]),
-		 ioaddr + PTxCDAR);
+	outl(ep->rx_ring_dma + (ep->cur_rx%RX_RING_SIZE)*
+		sizeof(struct epic_rx_desc), ioaddr + PRxCDAR);
+	outl(ep->tx_ring_dma + (ep->dirty_tx%TX_RING_SIZE)*
+		 sizeof(struct epic_tx_desc), ioaddr + PTxCDAR);
 
 	/* Start the chip's Rx process. */
 	set_rx_mode(dev);
@@ -852,11 +874,12 @@
 	for (i = 0; i < RX_RING_SIZE; i++) {
 		ep->rx_ring[i].rxstatus = 0;
 		ep->rx_ring[i].buflength = cpu_to_le32(ep->rx_buf_sz);
-		ep->rx_ring[i].next = virt_to_le32desc(&ep->rx_ring[i+1]);
+		ep->rx_ring[i].next = ep->rx_ring_dma + 
+				      (i+1)*sizeof(struct epic_rx_desc);
 		ep->rx_skbuff[i] = 0;
 	}
 	/* Mark the last entry as wrapping the ring. */
-	ep->rx_ring[i-1].next = virt_to_le32desc(&ep->rx_ring[0]);
+	ep->rx_ring[i-1].next = ep->rx_ring_dma;
 
 	/* Fill in the Rx buffers.  Handle allocation failure gracefully. */
 	for (i = 0; i < RX_RING_SIZE; i++) {
@@ -866,7 +889,8 @@
 			break;
 		skb->dev = dev;			/* Mark as being used by this device. */
 		skb_reserve(skb, 2);	/* 16 byte align the IP header. */
-		ep->rx_ring[i].bufaddr = virt_to_le32desc(skb->tail);
+		ep->rx_ring[i].bufaddr = pci_map_single(ep->pci_dev, 
+			skb->tail, ep->rx_buf_sz, PCI_DMA_FROMDEVICE);
 		ep->rx_ring[i].rxstatus = cpu_to_le32(DescOwn);
 	}
 	ep->dirty_rx = (unsigned int)(i - RX_RING_SIZE);
@@ -876,9 +900,10 @@
 	for (i = 0; i < TX_RING_SIZE; i++) {
 		ep->tx_skbuff[i] = 0;
 		ep->tx_ring[i].txstatus = 0x0000;
-		ep->tx_ring[i].next = virt_to_le32desc(&ep->tx_ring[i+1]);
+		ep->tx_ring[i].next = ep->tx_ring_dma + 
+			(i+1)*sizeof(struct epic_tx_desc);
 	}
-	ep->tx_ring[i-1].next = virt_to_le32desc(&ep->tx_ring[0]);
+	ep->tx_ring[i-1].next = ep->tx_ring_dma;
 	return;
 }
 
@@ -897,8 +922,8 @@
 	entry = ep->cur_tx % TX_RING_SIZE;
 
 	ep->tx_skbuff[entry] = skb;
-	ep->tx_ring[entry].bufaddr = virt_to_le32desc(skb->data);
-
+	ep->tx_ring[entry].bufaddr = pci_map_single(ep->pci_dev, skb->data, 
+		 			            skb->len, PCI_DMA_TODEVICE);
 	if (free_count < TX_QUEUE_LEN/2) {/* Typical path */
 		ctrl_word = cpu_to_le32(0x100000); /* No interrupt */
 	} else if (free_count == TX_QUEUE_LEN/2) {
@@ -970,6 +995,7 @@
 			cur_tx = ep->cur_tx;
 			dirty_tx = ep->dirty_tx;
 			for (; cur_tx - dirty_tx > 0; dirty_tx++) {
+				struct sk_buff *skb;
 				int entry = dirty_tx % TX_RING_SIZE;
 				int txstatus = le32_to_cpu(ep->tx_ring[entry].txstatus);
 
@@ -1001,7 +1027,10 @@
 				}
 
 				/* Free the original skb. */
-				dev_kfree_skb_irq(ep->tx_skbuff[entry]);
+				skb = ep->tx_skbuff[entry];
+				pci_unmap_single(ep->pci_dev, ep->tx_ring[entry].bufaddr, 
+						 skb->len, PCI_DMA_TODEVICE);
+				dev_kfree_skb_irq(skb);
 				ep->tx_skbuff[entry] = 0;
 			}
 
@@ -1103,6 +1132,10 @@
 			short pkt_len = (status >> 16) - 4;
 			struct sk_buff *skb;
 
+			pci_dma_sync_single(ep->pci_dev, ep->rx_ring[entry].bufaddr, 
+					    ep->rx_buf_sz, PCI_DMA_FROMDEVICE);
+			pci_unmap_single(ep->pci_dev, ep->rx_ring[entry].bufaddr, 
+					 ep->rx_buf_sz, PCI_DMA_FROMDEVICE);
 			if (pkt_len > PKT_BUF_SZ - 4) {
 				printk(KERN_ERR "%s: Oversized Ethernet frame, status %x "
 					   "%d bytes.\n",
@@ -1145,7 +1178,8 @@
 				break;
 			skb->dev = dev;			/* Mark as being used by this device. */
 			skb_reserve(skb, 2);	/* Align IP on 16 byte boundaries */
-			ep->rx_ring[entry].bufaddr = virt_to_le32desc(skb->tail);
+			ep->rx_ring[entry].bufaddr = pci_map_single(ep->pci_dev, 
+				skb->tail, ep->rx_buf_sz, PCI_DMA_FROMDEVICE);
 			work_done++;
 		}
 		ep->rx_ring[entry].rxstatus = cpu_to_le32(DescOwn);
@@ -1157,6 +1191,7 @@
 {
 	long ioaddr = dev->base_addr;
 	struct epic_private *ep = (struct epic_private *)dev->priv;
+	struct sk_buff *skb;
 	int i;
 
 	netif_stop_queue(dev);
@@ -1171,19 +1206,25 @@
 
 	/* Free all the skbuffs in the Rx queue. */
 	for (i = 0; i < RX_RING_SIZE; i++) {
-		struct sk_buff *skb = ep->rx_skbuff[i];
+		skb = ep->rx_skbuff[i];
 		ep->rx_skbuff[i] = 0;
 		ep->rx_ring[i].rxstatus = 0;		/* Not owned by Epic chip. */
 		ep->rx_ring[i].buflength = 0;
-		ep->rx_ring[i].bufaddr = 0xBADF00D0; /* An invalid address. */
 		if (skb) {
+			pci_unmap_single(ep->pci_dev, ep->rx_ring[i].bufaddr, 
+				 	 ep->rx_buf_sz, PCI_DMA_FROMDEVICE);
 			dev_kfree_skb(skb);
 		}
+		ep->rx_ring[i].bufaddr = 0xBADF00D0; /* An invalid address. */
 	}
 	for (i = 0; i < TX_RING_SIZE; i++) {
-		if (ep->tx_skbuff[i])
-			dev_kfree_skb(ep->tx_skbuff[i]);
+		skb = ep->tx_skbuff[i];
 		ep->tx_skbuff[i] = 0;
+		if (!skb)
+			continue;
+		pci_unmap_single(ep->pci_dev, ep->tx_ring[i].bufaddr, 
+				 skb->len, PCI_DMA_TODEVICE);
+		dev_kfree_skb(skb);
 	}
 
 	/* Green! Leave the chip in low-power mode. */
@@ -1319,15 +1360,18 @@
 static void __devexit epic_remove_one (struct pci_dev *pdev)
 {
 	struct net_device *dev = pdev->driver_data;
+	struct epic_private *ep = dev->priv;
 	
+	pci_free_consistent(pdev, TX_TOTAL_SIZE, ep->tx_ring, ep->tx_ring_dma);
+	pci_free_consistent(pdev, RX_TOTAL_SIZE, ep->rx_ring, ep->rx_ring_dma);
 	unregister_netdev(dev);
 #ifndef USE_IO_OPS
-	iounmap ((void*) dev->base_addr);
+	iounmap((void*) dev->base_addr);
 #endif
-	release_mem_region (pci_resource_start (pdev, 1),
-			    pci_resource_len (pdev, 1));
-	release_region (pci_resource_start (pdev, 0),
-			pci_resource_len (pdev, 0));
+	release_mem_region(pci_resource_start(pdev, 1), 
+			   pci_resource_len(pdev, 1));
+	release_region(pci_resource_start(pdev, 0),
+		       pci_resource_len(pdev, 0));
 	kfree(dev);
 }
 
-- 
Ueimor
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
