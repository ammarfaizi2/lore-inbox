Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262202AbRETT6I>; Sun, 20 May 2001 15:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262204AbRETT56>; Sun, 20 May 2001 15:57:58 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:39698 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S262202AbRETT5y>;
	Sun, 20 May 2001 15:57:54 -0400
Date: Sun, 20 May 2001 21:57:23 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Cc: alan@redhat.com
Subject: [PATCH] 2.4.4-ac11 - dma mapping in drivers/net/fealnx.c
Message-ID: <20010520215723.A26470@se1.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch makes the driver use the dma mapping interface.
It compiles.
No adequate adapter for testing.

--- linux-2.4.4-ac11/drivers/net/fealnx.c	Sat May 19 14:36:37 2001
+++ linux-2.4.4-ac11/drivers/net/fealnx.c	Sun May 20 15:53:26 2001
@@ -46,6 +46,8 @@ static int full_duplex[MAX_UNITS] = { -1
 // #define RX_RING_SIZE    32
 #define TX_RING_SIZE    6
 #define RX_RING_SIZE    12
+#define TX_TOTAL_SIZE	TX_RING_SIZE*sizeof(struct fealnx_desc)
+#define RX_TOTAL_SIZE	RX_RING_SIZE*sizeof(struct fealnx_desc)
 
 /* Operational parameters that usually are not changed. */
 /* Time in jiffies before concluding the transmitter is hung. */
@@ -363,8 +365,11 @@ enum tx_desc_control_bits {
 
 struct netdev_private {
 	/* Descriptor rings first for alignment. */
-	struct fealnx_desc rx_ring[RX_RING_SIZE];
-	struct fealnx_desc tx_ring[TX_RING_SIZE];
+	struct fealnx_desc *rx_ring;
+	struct fealnx_desc *tx_ring;
+
+	dma_addr_t rx_ring_dma;
+	dma_addr_t tx_ring_dma;
 
 	struct net_device_stats stats;
 
@@ -461,6 +466,8 @@ static int __devinit fealnx_init_one(str
 	long ioaddr;
 	unsigned int chip_id = ent->driver_data;
 	struct net_device *dev;
+	void *ring_space;
+	dma_addr_t ring_dma;
 	
 /* when built into the kernel, we only print version if device is found */
 #ifndef MODULE
@@ -528,6 +535,22 @@ static int __devinit fealnx_init_one(str
 	np->flags = skel_netdrv_tbl[chip_id].flags;
 	pci_set_drvdata(pdev, dev);
 
+	ring_space = pci_alloc_consistent(pdev, RX_TOTAL_SIZE, &ring_dma);
+	if (!ring_space) {
+		err = -ENOMEM;
+		goto err_out_free_dev;
+	}
+	np->rx_ring = (struct fealnx_desc *)ring_space;
+	np->rx_ring_dma = ring_dma;
+
+	ring_space = pci_alloc_consistent(pdev, TX_TOTAL_SIZE, &ring_dma);
+	if (!ring_space) {
+		err = -ENOMEM;
+		goto err_out_free_rx;
+	}
+	np->tx_ring = (struct fealnx_desc *)ring_space;
+	np->tx_ring_dma = ring_dma;
+
 	/* find the connected MII xcvrs */
 	if (np->flags == HAS_MII_XCVR) {
 		int phy, phy_idx = 0;
@@ -623,7 +646,7 @@ static int __devinit fealnx_init_one(str
 	
 	err = register_netdev(dev);
 	if (err)
-		goto err_out_free;
+		goto err_out_free_tx;
 
 	printk(KERN_INFO "%s: %s at 0x%lx, ",
 	       dev->name, skel_netdrv_tbl[chip_id].chip_name, ioaddr);
@@ -633,7 +656,11 @@ static int __devinit fealnx_init_one(str
 
 	return 0;
 
-err_out_free:
+err_out_free_tx:
+	pci_free_consistent(pdev, TX_TOTAL_SIZE, np->tx_ring, np->tx_ring_dma);
+err_out_free_rx:
+	pci_free_consistent(pdev, RX_TOTAL_SIZE, np->rx_ring, np->rx_ring_dma);
+err_out_free_dev:
 	kfree(dev);
 err_out_unmap:
 #ifndef USE_IO_OPS
@@ -647,7 +674,14 @@ err_out_res:
 static void __devexit fealnx_remove_one(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
+
 	if (dev) {
+		struct netdev_private *np = dev->priv;
+
+		pci_free_consistent(pdev, TX_TOTAL_SIZE, np->tx_ring,
+			np->tx_ring_dma);
+		pci_free_consistent(pdev, RX_TOTAL_SIZE, np->rx_ring,
+			np->rx_ring_dma);
 		unregister_netdev(dev);
 #ifndef USE_IO_OPS
 		iounmap((void *)dev->base_addr);
@@ -828,8 +862,8 @@ static int netdev_open(struct net_device
 
 	init_ring(dev);
 
-	writel(virt_to_bus(np->rx_ring), ioaddr + RXLBA);
-	writel(virt_to_bus(np->tx_ring), ioaddr + TXLBA);
+	writel(np->rx_ring_dma, ioaddr + RXLBA);
+	writel(np->tx_ring_dma, ioaddr + TXLBA);
 
 	/* Initialize other registers. */
 	/* Configure the PCI bus bursts and FIFO thresholds.
@@ -1077,7 +1111,8 @@ static void allocate_rx_buffers(struct n
 			break;	/* Better luck next round. */
 
 		skb->dev = dev;	/* Mark as being used by this device. */
-		np->lack_rxbuf->buffer = virt_to_bus(skb->tail);
+		np->lack_rxbuf->buffer = pci_map_single(np->pci_dev, skb->tail,
+			np->rx_buf_sz, PCI_DMA_FROMDEVICE);
 		np->lack_rxbuf = np->lack_rxbuf->next_desc_logical;
 		++np->really_rx_count;
 	}
@@ -1168,14 +1203,15 @@ static void init_ring(struct net_device 
 	for (i = 0; i < RX_RING_SIZE; i++) {
 		np->rx_ring[i].status = 0;
 		np->rx_ring[i].control = np->rx_buf_sz << RBSShift;
-		np->rx_ring[i].next_desc = virt_to_bus(&np->rx_ring[i + 1]);
+		np->rx_ring[i].next_desc = np->rx_ring_dma +
+			(i + 1)*sizeof(struct fealnx_desc);
 		np->rx_ring[i].next_desc_logical = &np->rx_ring[i + 1];
 		np->rx_ring[i].skbuff = NULL;
 	}
 
 	/* for the last rx descriptor */
-	np->rx_ring[i - 1].next_desc = virt_to_bus(&np->rx_ring[0]);
-	np->rx_ring[i - 1].next_desc_logical = &np->rx_ring[0];
+	np->rx_ring[i - 1].next_desc = np->rx_ring_dma;
+	np->rx_ring[i - 1].next_desc_logical = np->rx_ring;
 
 	/* allocate skb for rx buffers */
 	for (i = 0; i < RX_RING_SIZE; i++) {
@@ -1189,7 +1225,8 @@ static void init_ring(struct net_device 
 		++np->really_rx_count;
 		np->rx_ring[i].skbuff = skb;
 		skb->dev = dev;	/* Mark as being used by this device. */
-		np->rx_ring[i].buffer = virt_to_bus(skb->tail);
+		np->rx_ring[i].buffer = pci_map_single(np->pci_dev, skb->tail,
+			np->rx_buf_sz, PCI_DMA_FROMDEVICE);
 		np->rx_ring[i].status = RXOWN;
 		np->rx_ring[i].control |= RXIC;
 	}
@@ -1202,13 +1239,14 @@ static void init_ring(struct net_device 
 
 	for (i = 0; i < TX_RING_SIZE; i++) {
 		np->tx_ring[i].status = 0;
-		np->tx_ring[i].next_desc = virt_to_bus(&np->tx_ring[i + 1]);
+		np->tx_ring[i].next_desc = np->tx_ring_dma +
+			(i + 1)*sizeof(struct fealnx_desc);
 		np->tx_ring[i].next_desc_logical = &np->tx_ring[i + 1];
 		np->tx_ring[i].skbuff = NULL;
 	}
 
 	/* for the last tx descriptor */
-	np->tx_ring[i - 1].next_desc = virt_to_bus(&np->tx_ring[0]);
+	np->tx_ring[i - 1].next_desc = np->tx_ring_dma;
 	np->tx_ring[i - 1].next_desc_logical = &np->tx_ring[0];
 
 	return;
@@ -1220,11 +1258,12 @@ static int start_tx(struct sk_buff *skb,
 	struct netdev_private *np = dev->priv;
 
 	np->cur_tx_copy->skbuff = skb;
-	np->cur_tx_copy->buffer = virt_to_bus(skb->data);
 
 #define one_buffer
 #define BPT 1022
 #if defined(one_buffer)
+	np->cur_tx_copy->buffer = pci_map_single(np->pci_dev, skb->data,
+		skb->len, PCI_DMA_TODEVICE);
 	np->cur_tx_copy->control = TXIC | TXLD | TXFD | CRCEnable | PADEnable;
 	np->cur_tx_copy->control |= (skb->len << PKTSShift);	/* pkt size */
 	np->cur_tx_copy->control |= (skb->len << TBSShift);	/* buffer size */
@@ -1239,6 +1278,8 @@ static int start_tx(struct sk_buff *skb,
 		struct fealnx_desc *next;
 
 		/* for the first descriptor */
+		np->cur_tx_copy->buffer = pci_map_single(np->pci_dev, skb->data,
+			BPT, PCI_DMA_TODEVICE);
 		np->cur_tx_copy->control = TXIC | TXFD | CRCEnable | PADEnable;
 		np->cur_tx_copy->control |= (skb->len << PKTSShift);	/* pkt size */
 		np->cur_tx_copy->control |= (BPT << TBSShift);	/* buffer size */
@@ -1252,7 +1293,8 @@ static int start_tx(struct sk_buff *skb,
 // 89/12/29 add,
 		if (np->pci_dev->device == 0x891)
 			np->cur_tx_copy->control |= ETIControl | RetryTxLC;
-		next->buffer = virt_to_bus(skb->data) + BPT;
+		next->buffer = pci_map_single(ep->pci_dev, skb->data + BPT,
+                                skb->len - BPT, PCI_DMA_TODEVICE);
 
 		next->status = TXOWN;
 		np->cur_tx_copy->status = TXOWN;
@@ -1260,6 +1302,8 @@ static int start_tx(struct sk_buff *skb,
 		np->cur_tx_copy = next->next_desc_logical;
 		np->free_tx_count -= 2;
 	} else {
+		np->cur_tx_copy->buffer = pci_map_single(np->pci_dev, skb->data,
+			skb->len, PCI_DMA_TODEVICE);
 		np->cur_tx_copy->control = TXIC | TXLD | TXFD | CRCEnable | PADEnable;
 		np->cur_tx_copy->control |= (skb->len << PKTSShift);	/* pkt size */
 		np->cur_tx_copy->control |= (skb->len << TBSShift);	/* buffer size */
@@ -1308,7 +1352,8 @@ void reset_rx_descriptors(struct net_dev
 
 	allocate_rx_buffers(dev);
 
-	writel(virt_to_bus(np->cur_rx), dev->base_addr + RXLBA);
+	writel(np->rx_ring_dma + (np->cur_rx - np->rx_ring),
+		dev->base_addr + RXLBA);
 	writel(np->crvalue, dev->base_addr + TCRRCR);
 }
 
@@ -1421,6 +1466,8 @@ static void intr_handler(int irq, void *
 			}
 
 			/* Free the original skb. */
+			pci_unmap_single(np->pci_dev, np->cur_tx->buffer,
+				np->cur_tx->skbuff->len, PCI_DMA_TODEVICE);
 			dev_kfree_skb_irq(np->cur_tx->skbuff);
 			np->cur_tx->skbuff = NULL;
 			--np->really_tx_count;
@@ -1554,6 +1601,10 @@ static int netdev_rx(struct net_device *
 				printk(KERN_DEBUG "  netdev_rx() normal Rx pkt length %d"
 				       " status %x.\n", pkt_len, rx_status);
 #endif
+			pci_dma_sync_single(np->pci_dev, np->cur_rx->buffer,
+				np->rx_buf_sz, PCI_DMA_FROMDEVICE);
+			pci_unmap_single(np->pci_dev, np->cur_rx->buffer,
+				np->rx_buf_sz, PCI_DMA_FROMDEVICE);
 
 			/* Check if the packet is long enough to accept without copying
 			   to a minimally-sized skbuff. */
@@ -1564,12 +1615,12 @@ static int netdev_rx(struct net_device *
 				/* Call copy + cksum if available. */
 
 #if ! defined(__alpha__)
-				eth_copy_and_sum(skb, bus_to_virt(np->cur_rx->buffer),
-						 pkt_len, 0);
+				eth_copy_and_sum(skb, 
+					np->cur_rx->skbuff->tail, pkt_len, 0);
 				skb_put(skb, pkt_len);
 #else
 				memcpy(skb_put(skb, pkt_len),
-				       bus_to_virt(np->cur_rx->buffer), pkt_len);
+					np->cur_rx->skbuff->tail, pkt_len);
 #endif
 			} else {
 				skb_put(skb = np->cur_rx->skbuff, pkt_len);
@@ -1592,7 +1643,8 @@ static int netdev_rx(struct net_device *
 
 			if (skb != NULL) {
 				skb->dev = dev;	/* Mark as being used by this device. */
-				np->cur_rx->buffer = virt_to_bus(skb->tail);
+				np->cur_rx->buffer = pci_map_single(np->pci_dev, skb->tail,
+					np->rx_buf_sz, PCI_DMA_FROMDEVICE);
 				np->cur_rx->skbuff = skb;
 				++np->really_rx_count;
 			}
@@ -1727,16 +1779,26 @@ static int netdev_close(struct net_devic
 
 	/* Free all the skbuffs in the Rx queue. */
 	for (i = 0; i < RX_RING_SIZE; i++) {
+		struct sk_buff *skb = np->rx_ring[i].skbuff;
+
 		np->rx_ring[i].status = 0;
-		if (np->rx_ring[i].skbuff)
-			dev_kfree_skb(np->rx_ring[i].skbuff);
-		np->rx_ring[i].skbuff = NULL;
+		if (skb) {
+			pci_unmap_single(np->pci_dev, np->rx_ring[i].buffer,
+				np->rx_buf_sz, PCI_DMA_FROMDEVICE);
+			dev_kfree_skb(skb);
+			np->rx_ring[i].skbuff = NULL;
+		}
 	}
 
 	for (i = 0; i < TX_RING_SIZE; i++) {
-		if (np->tx_ring[i].skbuff)
-			dev_kfree_skb(np->tx_ring[i].skbuff);
-		np->tx_ring[i].skbuff = NULL;
+		struct sk_buff *skb = np->tx_ring[i].skbuff;
+
+		if (skb) {
+			pci_unmap_single(np->pci_dev, np->tx_ring[i].buffer,
+				skb->len, PCI_DMA_TODEVICE);
+			dev_kfree_skb(skb);
+			np->tx_ring[i].skbuff = NULL;
+		}
 	}
 
 	return 0;

-- 
Ueimor
