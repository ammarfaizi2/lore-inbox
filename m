Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129880AbQLYOrV>; Mon, 25 Dec 2000 09:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130427AbQLYOrL>; Mon, 25 Dec 2000 09:47:11 -0500
Received: from colorfullife.com ([216.156.138.34]:27406 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130329AbQLYOrB>;
	Mon, 25 Dec 2000 09:47:01 -0500
Message-ID: <3A475713.41E95C06@colorfullife.com>
Date: Mon, 25 Dec 2000 15:17:55 +0100
From: Manfred <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <andrewm@uow.edu.au>
Subject: [PATCH] winbond-840 updates, tester needed!
Content-Type: multipart/mixed;
 boundary="------------A161206C53EE77CF47BA3026"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A161206C53EE77CF47BA3026
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I found a few minor problems in the current winbond driver:

* the current driver hangs/crashes during module unload.
* it doesn't use the new pci dma mapping interface
* it assumed strong memory ordering without explicit wmb()'s.
* it contains the tx_full race that Andrew Morton found.

The patch fixes these bugs. I've tested it on i386 SMP.

I need a tester with a winbond card on a computer with a big endian cpu,
any volunteers?

There are at least 2 outstanding problems with big endian cpus:

* a warning from Donald Becker that one eeprom read is broken for
big-endian machines.

* the driver doesn't use the "Descriptor Big Endian" (bit 20 of register
0) mode, instead it uses cpu_to_le32.

--
  Manfred
--------------A161206C53EE77CF47BA3026
Content-Type: text/plain; charset=us-ascii;
 name="patch-winbond"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-winbond"

--- 2.4/drivers/net/winbond-840.c	Sun Dec 17 18:03:56 2000
+++ build-2.4/drivers/net/winbond-840.c	Mon Dec 25 12:49:36 2000
@@ -21,11 +21,21 @@
 	Do not change the version information unless an improvement has been made.
 	Merely removing my name, as Compex has done in the past, does not count
 	as an improvement.
+
+	Changelog:
+	* ported to 2.4
+		???
+	* spin lock update, memory barriers, new style dma mappings
+		Manfred Spraul
+
+	TODO:
+	* according to the documentation, the chip supports big endian
+		internally. Replace the cpu_to_le32 with that bit.
 */
 
 /* These identify the driver base version and may not be removed. */
 static const char version1[] =
-"winbond-840.c:v1.01 5/15/2000  Donald Becker <becker@scyld.com>\n";
+"winbond-840.c:v1.01 (2.4 port) 5/15/2000  Donald Becker <becker@scyld.com>\n";
 static const char version2[] =
 "  http://www.scyld.com/network/drivers.html\n";
 
@@ -114,12 +124,6 @@
 #include <asm/bitops.h>
 #include <asm/io.h>
 
-/* Condensed operations for readability.
-   The compatibility defines are in kern_compat.h */
-
-#define virt_to_le32desc(addr)  cpu_to_le32(virt_to_bus(addr))
-#define le32desc_to_virt(addr)  bus_to_virt(le32_to_cpu(addr))
-
 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
 MODULE_DESCRIPTION("Winbond W89c840 Ethernet driver");
 MODULE_PARM(max_interrupt_work, "i");
@@ -298,9 +302,12 @@
 
 #define PRIV_ALIGN	15 	/* Required alignment mask */
 struct netdev_private {
-	/* Descriptor rings first for alignment. */
-	struct w840_rx_desc rx_ring[RX_RING_SIZE];
-	struct w840_tx_desc tx_ring[TX_RING_SIZE];
+	struct w840_rx_desc *rx_ring;
+	dma_addr_t	rx_addr[RX_RING_SIZE];
+	struct w840_tx_desc *tx_ring;
+	dma_addr_t	tx_addr[RX_RING_SIZE];
+	dma_addr_t ring_dma_addr;
+	struct pci_dev *pdev;
 	/* The addresses of receive-in-place skbuffs. */
 	struct sk_buff* rx_skbuff[RX_RING_SIZE];
 	/* The saved address of a sent-in-place packet/buffer, for later free(). */
@@ -335,7 +342,7 @@
 static void check_duplex(struct net_device *dev);
 static void netdev_timer(unsigned long data);
 static void tx_timeout(struct net_device *dev);
-static void init_ring(struct net_device *dev);
+static int init_ring(struct net_device *dev);
 static int  start_tx(struct sk_buff *skb, struct net_device *dev);
 static void intr_handler(int irq, void *dev_instance, struct pt_regs *regs);
 static void netdev_error(struct net_device *dev, int intr_status);
@@ -364,6 +371,11 @@
 		return -EIO;
 	pci_set_master(pdev);
 
+	if(!pci_dma_supported(pdev,0xFFFFffff)) {
+		printk(KERN_WARNING "Winbond-840: Device %s disabled due to DMA limitations.\n",
+				pdev->name);
+		return -EIO;
+	}
 	dev = init_etherdev(NULL, sizeof(*np));
 	if (!dev)
 		return -ENOMEM;
@@ -403,6 +415,7 @@
 	np = dev->priv;
 	np->chip_id = chip_idx;
 	np->drv_flags = pci_id_tbl[chip_idx].drv_flags;
+	np->pdev = pdev;
 	spin_lock_init(&np->lock);
 	
 	pdev->driver_data = dev;
@@ -632,10 +645,12 @@
 		printk(KERN_DEBUG "%s: w89c840_open() irq %d.\n",
 			   dev->name, dev->irq);
 
-	init_ring(dev);
+	if((i=init_ring(dev)))
+		return i;
 
-	writel(virt_to_bus(np->rx_ring), ioaddr + RxRingPtr);
-	writel(virt_to_bus(np->tx_ring), ioaddr + TxRingPtr);
+	writel(np->ring_dma_addr, ioaddr + RxRingPtr);
+	writel(np->ring_dma_addr+sizeof(struct w840_rx_desc)*RX_RING_SIZE,
+		ioaddr + TxRingPtr);
 
 	for (i = 0; i < 6; i++)
 		writeb(dev->dev_addr[i], ioaddr + StationAddr + i);
@@ -733,11 +748,13 @@
 			   "config %8.8x.\n",
 			   dev->name, (int)readl(ioaddr + IntrStatus),
 			   (int)readl(ioaddr + NetworkConfig));
+	spin_lock_irq(&np->lock);
 	check_duplex(dev);
 	if (np->csr6 != old_csr6) {
 		writel(np->csr6 & ~0x0002, ioaddr + NetworkConfig);
 		writel(np->csr6 | 0x2002, ioaddr + NetworkConfig);
 	}
+	spin_unlock_irq(&np->lock);
 	np->timer.expires = jiffies + next_tick;
 	add_timer(&np->timer);
 }
@@ -776,7 +793,7 @@
 
 
 /* Initialize the Rx and Tx rings, along with various 'dev' bits. */
-static void init_ring(struct net_device *dev)
+static int init_ring(struct net_device *dev)
 {
 	struct netdev_private *np = (struct netdev_private *)dev->priv;
 	int i;
@@ -786,18 +803,27 @@
 	np->dirty_rx = np->dirty_tx = 0;
 
 	np->rx_buf_sz = (dev->mtu <= 1500 ? PKT_BUF_SZ : dev->mtu + 32);
+
+	np->rx_ring = pci_alloc_consistent(np->pdev,
+			sizeof(struct w840_rx_desc)*RX_RING_SIZE +
+			sizeof(struct w840_tx_desc)*TX_RING_SIZE,
+			&np->ring_dma_addr);
+	if(!np->rx_ring)
+		return -ENOMEM;
 	np->rx_head_desc = &np->rx_ring[0];
+	np->tx_ring = (struct w840_tx_desc*)&np->rx_ring[RX_RING_SIZE];
 
 	/* Initial all Rx descriptors. */
 	for (i = 0; i < RX_RING_SIZE; i++) {
 		np->rx_ring[i].length = cpu_to_le32(np->rx_buf_sz);
 		np->rx_ring[i].status = 0;
-		np->rx_ring[i].next_desc = virt_to_le32desc(&np->rx_ring[i+1]);
+		np->rx_ring[i].next_desc = cpu_to_le32(np->ring_dma_addr+
+						sizeof(struct w840_rx_desc)*(i+1));
 		np->rx_skbuff[i] = 0;
 	}
 	/* Mark the last entry as wrapping the ring. */
 	np->rx_ring[i-1].length |= cpu_to_le32(DescEndRing);
-	np->rx_ring[i-1].next_desc = virt_to_le32desc(&np->rx_ring[0]);
+	np->rx_ring[i-1].next_desc = cpu_to_le32(&np->ring_dma_addr);
 
 	/* Fill in the Rx buffers.  Handle allocation failure gracefully. */
 	for (i = 0; i < RX_RING_SIZE; i++) {
@@ -806,7 +832,10 @@
 		if (skb == NULL)
 			break;
 		skb->dev = dev;			/* Mark as being used by this device. */
-		np->rx_ring[i].buffer1 = virt_to_le32desc(skb->tail);
+		np->rx_addr[i] = pci_map_single(np->pdev,skb->tail,
+					skb->len,PCI_DMA_FROMDEVICE);
+
+		np->rx_ring[i].buffer1 = cpu_to_le32(np->rx_addr[i]);
 		np->rx_ring[i].status = cpu_to_le32(DescOwn | DescIntr);
 	}
 	np->dirty_rx = (unsigned int)(i - RX_RING_SIZE);
@@ -815,7 +844,7 @@
 		np->tx_skbuff[i] = 0;
 		np->tx_ring[i].status = 0;
 	}
-	return;
+	return 0;
 }
 
 static int start_tx(struct sk_buff *skb, struct net_device *dev)
@@ -830,76 +859,20 @@
 	entry = np->cur_tx % TX_RING_SIZE;
 
 	np->tx_skbuff[entry] = skb;
-	np->tx_ring[entry].buffer1 = virt_to_le32desc(skb->data);
-
-#define one_buffer
-#define BPT 1022
-#if defined(one_buffer)
+	np->tx_addr[entry] = pci_map_single(np->pdev,
+				skb->data,skb->len, PCI_DMA_TODEVICE);
+	np->tx_ring[entry].buffer1 = cpu_to_le32(np->tx_addr[entry]);
 	np->tx_ring[entry].length = cpu_to_le32(DescWholePkt | skb->len);
 	if (entry >= TX_RING_SIZE-1)		 /* Wrap ring */
 		np->tx_ring[entry].length |= cpu_to_le32(DescIntr | DescEndRing);
+	wmb();
 	np->tx_ring[entry].status = cpu_to_le32(DescOwn);
 	np->cur_tx++;
-#elif defined(two_buffer)
-	if (skb->len > BPT) {
-		unsigned int entry1 = ++np->cur_tx % TX_RING_SIZE;
-		np->tx_ring[entry].length = cpu_to_le32(DescStartPkt | BPT);
-		np->tx_ring[entry1].length = cpu_to_le32(DescEndPkt | (skb->len - BPT));
-		np->tx_ring[entry1].buffer1 = virt_to_le32desc((skb->data) + BPT);
-		np->tx_ring[entry1].status = cpu_to_le32(DescOwn);
-		np->tx_ring[entry].status = cpu_to_le32(DescOwn);
-		if (entry >= TX_RING_SIZE-1)
-			np->tx_ring[entry].length |= cpu_to_le32(DescIntr|DescEndRing);
-		else if (entry1 >= TX_RING_SIZE-1)
-			np->tx_ring[entry1].length |= cpu_to_le32(DescIntr|DescEndRing);
-		np->cur_tx++;
-	} else {
-		np->tx_ring[entry].length = cpu_to_le32(DescWholePkt | skb->len);
-		if (entry >= TX_RING_SIZE-1)		 /* Wrap ring */
-			np->tx_ring[entry].length |= cpu_to_le32(DescIntr | DescEndRing);
-		np->tx_ring[entry].status = cpu_to_le32(DescOwn);
-		np->cur_tx++;
-	}
-#elif defined(split_buffer)
-	{
-		/* Work around the Tx-FIFO-full bug by splitting our transmit packet
-		   into two pieces, the first which may be loaded without overflowing
-		   the FIFO, and the second which contains the remainder of the
-		   packet.  When we get a Tx-done interrupt that frees enough room
-		   in the FIFO we mark the remainder of the packet as loadable.
-
-		   This has the problem that the Tx descriptors are written both
-		   here and in the interrupt handler.
-		*/
-
-		int buf1size = TX_FIFO_SIZE - np->tx_q_bytes;
-		int buf2size = skb->len - buf1size;
-
-		if (buf2size <= 0) {		/* We fit into one descriptor. */
-			np->tx_ring[entry].length = cpu_to_le32(DescWholePkt | skb->len);
-		} else {				/* We must use two descriptors. */
-			unsigned int entry2;
-			np->tx_ring[entry].length =
-				cpu_to_le32(DescIntr | DescStartPkt | buf1size);
-			if (entry >= TX_RING_SIZE-1) {		 /* Wrap ring */
-				np->tx_ring[entry].length |= cpu_to_le32(DescEndRing);
-				entry2 = 0;
-			} else
-				entry2 = entry + 1;
-			np->cur_tx++;
-			np->tx_ring[entry2].buffer1 =
-				virt_to_le32desc(skb->data + buf1size);
-			np->tx_ring[entry2].length = cpu_to_le32(DescEndPkt | buf2size);
-			if (entry2 >= TX_RING_SIZE-1)		 /* Wrap ring */
-				np->tx_ring[entry2].length |= cpu_to_le32(DescEndRing);
-		}
-		np->tx_ring[entry].status = cpu_to_le32(DescOwn);
-		np->cur_tx++;
-	}
-#endif
+
 	np->tx_q_bytes += skb->len;
 	writel(0, dev->base_addr + TxStartDemand);
 
+	spin_lock_irq(&np->lock);
 	/* Work around horrible bug in the chip by marking the queue as full
 	   when we do not have FIFO room for a maximum sized packet. */
 	if (np->cur_tx - np->dirty_tx > TX_QUEUE_LEN)
@@ -911,6 +884,7 @@
 		netif_stop_queue(dev);
 
 	dev->trans_start = jiffies;
+	spin_unlock_irq(&np->lock);
 
 	if (debug > 4) {
 		printk(KERN_DEBUG "%s: Transmit frame #%d queued in slot %d.\n",
@@ -977,6 +951,9 @@
 				np->stats.tx_packets++;
 			}
 			/* Free the original skb. */
+			pci_unmap_single(np->pdev,np->tx_addr[entry],
+						np->tx_skbuff[entry]->len,
+						PCI_DMA_TODEVICE);
 			np->tx_q_bytes -= np->tx_skbuff[entry]->len;
 			dev_kfree_skb_irq(np->tx_skbuff[entry]);
 			np->tx_skbuff[entry] = 0;
@@ -1070,6 +1047,9 @@
 				&& (skb = dev_alloc_skb(pkt_len + 2)) != NULL) {
 				skb->dev = dev;
 				skb_reserve(skb, 2);	/* 16 byte align the IP header */
+				pci_dma_sync_single(np->pdev,np->rx_addr[entry],
+							np->rx_skbuff[entry]->len,
+							PCI_DMA_FROMDEVICE);
 				/* Call copy + cksum if available. */
 #if HAS_IP_COPYSUM
 				eth_copy_and_sum(skb, np->rx_skbuff[entry]->tail, pkt_len, 0);
@@ -1079,15 +1059,11 @@
 					   pkt_len);
 #endif
 			} else {
-				char *temp = skb_put(skb = np->rx_skbuff[entry], pkt_len);
+				pci_unmap_single(np->pdev,np->rx_addr[entry],
+							np->rx_skbuff[entry]->len,
+							PCI_DMA_FROMDEVICE);
+				skb_put(skb = np->rx_skbuff[entry], pkt_len);
 				np->rx_skbuff[entry] = NULL;
-#ifndef final_version				/* Remove after testing. */
-				if (le32desc_to_virt(desc->buffer1) != temp)
-					printk(KERN_ERR "%s: Internal fault: The skbuff addresses "
-						   "do not match in netdev_rx: %p vs. %p / %p.\n",
-						   dev->name, le32desc_to_virt(desc->buffer1),
-						   skb->head, temp);
-#endif
 			}
 #ifndef final_version				/* Remove after testing. */
 			/* You will want this info for the initial debug. */
@@ -1122,8 +1098,12 @@
 			if (skb == NULL)
 				break;			/* Better luck next round. */
 			skb->dev = dev;			/* Mark as being used by this device. */
-			np->rx_ring[entry].buffer1 = virt_to_le32desc(skb->tail);
+			np->rx_addr[entry] = pci_map_single(np->pdev,
+							skb->tail,
+							skb->len, PCI_DMA_FROMDEVICE);
+			np->rx_ring[entry].buffer1 = cpu_to_le32(np->rx_addr[entry]);
 		}
+		wmb();
 		np->rx_ring[entry].status = cpu_to_le32(DescOwn);
 	}
 
@@ -1270,13 +1250,13 @@
 #ifdef __i386__
 	if (debug > 2) {
 		printk("\n"KERN_DEBUG"  Tx ring at %8.8x:\n",
-			   (int)virt_to_le32desc(np->tx_ring));
+			   (int)np->tx_ring);
 		for (i = 0; i < TX_RING_SIZE; i++)
 			printk(" #%d desc. %4.4x %4.4x %8.8x.\n",
 				   i, np->tx_ring[i].length,
 				   np->tx_ring[i].status, np->tx_ring[i].buffer1);
 		printk("\n"KERN_DEBUG "  Rx ring %8.8x:\n",
-			   (int)virt_to_le32desc(np->rx_ring));
+			   (int)np->rx_ring);
 		for (i = 0; i < RX_RING_SIZE; i++) {
 			printk(KERN_DEBUG " #%d desc. %4.4x %4.4x %8.8x\n",
 				   i, np->rx_ring[i].length,
@@ -1293,13 +1273,22 @@
 	for (i = 0; i < RX_RING_SIZE; i++) {
 		np->rx_ring[i].status = 0;
 		if (np->rx_skbuff[i]) {
+			pci_unmap_single(np->pdev,
+						np->rx_addr[i],
+						np->rx_skbuff[i]->len,
+						PCI_DMA_FROMDEVICE);
 			dev_kfree_skb(np->rx_skbuff[i]);
 		}
 		np->rx_skbuff[i] = 0;
 	}
 	for (i = 0; i < TX_RING_SIZE; i++) {
-		if (np->tx_skbuff[i])
+		if (np->tx_skbuff[i]) {
+			pci_unmap_single(np->pdev,
+						np->tx_addr[i],
+						np->tx_skbuff[i]->len,
+						PCI_DMA_TODEVICE);
 			dev_kfree_skb(np->tx_skbuff[i]);
+		}
 		np->tx_skbuff[i] = 0;
 	}
 
@@ -1311,7 +1300,7 @@
 	struct net_device *dev = pdev->driver_data;
 	
 	/* No need to check MOD_IN_USE, as sys_delete_module() checks. */
-	while (dev) {
+	if (dev) {
 		struct netdev_private *np = (void *)(dev->priv);
 		unregister_netdev(dev);
 #ifdef USE_IO_OPS

--------------A161206C53EE77CF47BA3026--


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
