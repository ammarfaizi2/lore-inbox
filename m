Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131706AbQLZRWy>; Tue, 26 Dec 2000 12:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131795AbQLZRWn>; Tue, 26 Dec 2000 12:22:43 -0500
Received: from colorfullife.com ([216.156.138.34]:32527 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131706AbQLZRW2>;
	Tue, 26 Dec 2000 12:22:28 -0500
Message-ID: <3A48CDC2.F6A146B8@colorfullife.com>
Date: Tue, 26 Dec 2000 17:56:34 +0100
From: Manfred <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] winbond-840.c update
Content-Type: multipart/mixed;
 boundary="------------B16ECE97F30D4B786E83D763"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B16ECE97F30D4B786E83D763
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Here is a third update for the winbond driver:

* tx_timeout implemented, the driver now actually recovers from timeouts
;-)
* tx fifo underrun code modified
* further cleanups

The driver is stable under high load, please give it a try.

I'll submit it to Linus in a few days if I get some positive reports.

--
	Manfred
--------------B16ECE97F30D4B786E83D763
Content-Type: text/plain; charset=us-ascii;
 name="patch-winbond"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-winbond"

--- 2.4/drivers/net/winbond-840.c	Sun Dec 17 18:03:56 2000
+++ build-2.4/drivers/net/winbond-840.c	Tue Dec 26 17:17:21 2000
@@ -21,11 +21,25 @@
 	Do not change the version information unless an improvement has been made.
 	Merely removing my name, as Compex has done in the past, does not count
 	as an improvement.
+
+	Changelog:
+	* ported to 2.4
+		???
+	* spin lock update, memory barriers, new style dma mappings
+		limit each tx buffer to < 1024 bytes
+		remove bogus DescIntr from Rx descriptors
+		remove bogus next pointer from Tx descriptors
+		software reset in tx_timeout
+			Manfred Spraul
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
 
@@ -81,6 +95,8 @@
 #define TX_FIFO_SIZE (2048)
 #define TX_BUG_FIFO_LIMIT (TX_FIFO_SIZE-1514-16)
 
+#define TX_BUFLIMIT	(1024-128)
+
 /* Operational parameters that usually are not changed. */
 /* Time in jiffies before concluding the transmitter is hung. */
 #define TX_TIMEOUT  (2*HZ)
@@ -113,12 +129,7 @@
 #include <asm/processor.h>		/* Processor type for cache alignment. */
 #include <asm/bitops.h>
 #include <asm/io.h>
-
-/* Condensed operations for readability.
-   The compatibility defines are in kern_compat.h */
-
-#define virt_to_le32desc(addr)  cpu_to_le32(virt_to_bus(addr))
-#define le32desc_to_virt(addr)  bus_to_virt(le32_to_cpu(addr))
+#include <asm/delay.h>
 
 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
 MODULE_DESCRIPTION("Winbond W89c840 Ethernet driver");
@@ -280,7 +291,7 @@
 	s32 status;
 	s32 length;
 	u32 buffer1;
-	u32 next_desc;
+	u32 buffer2;
 };
 
 struct w840_tx_desc {
@@ -293,14 +304,21 @@
 enum desc_status_bits {
 	DescOwn=0x80000000, DescEndRing=0x02000000, DescUseLink=0x01000000,
 	DescWholePkt=0x60000000, DescStartPkt=0x20000000, DescEndPkt=0x40000000,
+};
+
+/* Bits in w840_tx_desc.length */
+enum desc_length_bits {
 	DescIntr=0x80000000,
 };
 
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
@@ -334,13 +352,15 @@
 static int  netdev_open(struct net_device *dev);
 static void check_duplex(struct net_device *dev);
 static void netdev_timer(unsigned long data);
+static void init_rxtx_rings(struct net_device *dev);
+static void free_rxtx_rings(struct netdev_private *np);
+static void init_registers(struct net_device *dev);
 static void tx_timeout(struct net_device *dev);
-static void init_ring(struct net_device *dev);
+static int alloc_ring(struct net_device *dev);
 static int  start_tx(struct sk_buff *skb, struct net_device *dev);
 static void intr_handler(int irq, void *dev_instance, struct pt_regs *regs);
 static void netdev_error(struct net_device *dev, int intr_status);
 static int  netdev_rx(struct net_device *dev);
-static void netdev_error(struct net_device *dev, int intr_status);
 static inline unsigned ether_crc(int length, unsigned char *data);
 static void set_rx_mode(struct net_device *dev);
 static struct net_device_stats *get_stats(struct net_device *dev);
@@ -364,6 +384,11 @@
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
@@ -403,6 +428,7 @@
 	np = dev->priv;
 	np->chip_id = chip_idx;
 	np->drv_flags = pci_id_tbl[chip_idx].drv_flags;
+	np->pdev = pdev;
 	spin_lock_init(&np->lock);
 	
 	pdev->driver_data = dev;
@@ -632,60 +658,12 @@
 		printk(KERN_DEBUG "%s: w89c840_open() irq %d.\n",
 			   dev->name, dev->irq);
 
-	init_ring(dev);
-
-	writel(virt_to_bus(np->rx_ring), ioaddr + RxRingPtr);
-	writel(virt_to_bus(np->tx_ring), ioaddr + TxRingPtr);
-
-	for (i = 0; i < 6; i++)
-		writeb(dev->dev_addr[i], ioaddr + StationAddr + i);
-
-	/* Initialize other registers. */
-	/* Configure the PCI bus bursts and FIFO thresholds.
-	   486: Set 8 longword cache alignment, 8 longword burst.
-	   586: Set 16 longword cache alignment, no burst limit.
-	   Cache alignment bits 15:14	     Burst length 13:8
-		0000	<not allowed> 		0000 align to cache	0800 8 longwords
-		4000	8  longwords		0100 1 longword		1000 16 longwords
-		8000	16 longwords		0200 2 longwords	2000 32 longwords
-		C000	32  longwords		0400 4 longwords
-	   Wait the specified 50 PCI cycles after a reset by initializing
-	   Tx and Rx queues and the address filter list. */
-#if defined(__powerpc__)		/* Big-endian */
-	writel(0x00100080 | 0xE010, ioaddr + PCIBusCfg);
-#elif defined(__alpha__)
-	writel(0xE010, ioaddr + PCIBusCfg);
-#elif defined(__i386__)
-#if defined(MODULE)
-	writel(0xE010, ioaddr + PCIBusCfg);
-#else
-	/* When not a module we can work around broken '486 PCI boards. */
-#define x86 boot_cpu_data.x86
-	writel((x86 <= 4 ? 0x4810 : 0xE010), ioaddr + PCIBusCfg);
-	if (x86 <= 4)
-		printk(KERN_INFO "%s: This is a 386/486 PCI system, setting cache "
-			   "alignment to %x.\n", dev->name,
-			   (x86 <= 4 ? 0x4810 : 0x8010));
-#endif
-#else
-	writel(0xE010, ioaddr + PCIBusCfg);
-#warning Processor architecture undefined!
-#endif
-
-	if (dev->if_port == 0)
-		dev->if_port = np->default_port;
+	if((i=alloc_ring(dev)))
+		return i;
 
-	writel(0, ioaddr + RxStartDemand);
-	np->csr6 = 0x20022002;
-	check_duplex(dev);
-	set_rx_mode(dev);
+	init_registers(dev);
 
 	netif_start_queue(dev);
-
-	/* Clear and Enable interrupts by setting the interrupt mask. */
-	writel(0x1A0F5, ioaddr + IntrStatus);
-	writel(0x1A0F5, ioaddr + IntrEnable);
-
 	if (debug > 2)
 		printk(KERN_DEBUG "%s: Done netdev_open().\n", dev->name);
 
@@ -733,15 +711,149 @@
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
 
+static void init_rxtx_rings(struct net_device *dev)
+{
+	struct netdev_private *np = (struct netdev_private *)dev->priv;
+	int i;
+
+	np->rx_head_desc = &np->rx_ring[0];
+	np->tx_ring = (struct w840_tx_desc*)&np->rx_ring[RX_RING_SIZE];
+
+	/* Initial all Rx descriptors. */
+	for (i = 0; i < RX_RING_SIZE; i++) {
+		np->rx_ring[i].length = cpu_to_le32(np->rx_buf_sz);
+		np->rx_ring[i].status = 0;
+		np->rx_skbuff[i] = 0;
+	}
+	/* Mark the last entry as wrapping the ring. */
+	np->rx_ring[i-1].length |= cpu_to_le32(DescEndRing);
+
+	/* Fill in the Rx buffers.  Handle allocation failure gracefully. */
+	for (i = 0; i < RX_RING_SIZE; i++) {
+		struct sk_buff *skb = dev_alloc_skb(np->rx_buf_sz);
+		np->rx_skbuff[i] = skb;
+		if (skb == NULL)
+			break;
+		skb->dev = dev;			/* Mark as being used by this device. */
+		np->rx_addr[i] = pci_map_single(np->pdev,skb->tail,
+					skb->len,PCI_DMA_FROMDEVICE);
+
+		np->rx_ring[i].buffer1 = cpu_to_le32(np->rx_addr[i]);
+		np->rx_ring[i].status = cpu_to_le32(DescOwn);
+	}
+
+	np->cur_rx = 0;
+	np->dirty_rx = (unsigned int)(i - RX_RING_SIZE);
+
+	/* Initialize the Tx descriptors */
+	for (i = 0; i < TX_RING_SIZE; i++) {
+		np->tx_skbuff[i] = 0;
+		np->tx_ring[i].status = 0;
+	}
+	np->tx_full = 0;
+	np->tx_q_bytes = np->dirty_tx = np->cur_tx = 0;
+
+	writel(np->ring_dma_addr, dev->base_addr + RxRingPtr);
+	writel(np->ring_dma_addr+sizeof(struct w840_rx_desc)*RX_RING_SIZE,
+		dev->base_addr + TxRingPtr);
+
+}
+
+static void free_rxtx_rings(struct netdev_private* np)
+{
+	int i;
+	/* Free all the skbuffs in the Rx queue. */
+	for (i = 0; i < RX_RING_SIZE; i++) {
+		np->rx_ring[i].status = 0;
+		if (np->rx_skbuff[i]) {
+			pci_unmap_single(np->pdev,
+						np->rx_addr[i],
+						np->rx_skbuff[i]->len,
+						PCI_DMA_FROMDEVICE);
+			dev_kfree_skb(np->rx_skbuff[i]);
+		}
+		np->rx_skbuff[i] = 0;
+	}
+	for (i = 0; i < TX_RING_SIZE; i++) {
+		if (np->tx_skbuff[i]) {
+			pci_unmap_single(np->pdev,
+						np->tx_addr[i],
+						np->tx_skbuff[i]->len,
+						PCI_DMA_TODEVICE);
+			dev_kfree_skb(np->tx_skbuff[i]);
+		}
+		np->tx_skbuff[i] = 0;
+	}
+}
+
+static void init_registers(struct net_device *dev)
+{
+	struct netdev_private *np = (struct netdev_private *)dev->priv;
+	long ioaddr = dev->base_addr;
+	int i;
+
+	for (i = 0; i < 6; i++)
+		writeb(dev->dev_addr[i], ioaddr + StationAddr + i);
+
+	/* Initialize other registers. */
+	/* Configure the PCI bus bursts and FIFO thresholds.
+	   486: Set 8 longword cache alignment, 8 longword burst.
+	   586: Set 16 longword cache alignment, no burst limit.
+	   Cache alignment bits 15:14	     Burst length 13:8
+		0000	<not allowed> 		0000 align to cache	0800 8 longwords
+		4000	8  longwords		0100 1 longword		1000 16 longwords
+		8000	16 longwords		0200 2 longwords	2000 32 longwords
+		C000	32  longwords		0400 4 longwords
+	   Wait the specified 50 PCI cycles after a reset by initializing
+	   Tx and Rx queues and the address filter list. */
+#if defined(__powerpc__)		/* Big-endian */
+	writel(0x00100080 | 0xE010, ioaddr + PCIBusCfg);
+#elif defined(__alpha__)
+	writel(0xE010, ioaddr + PCIBusCfg);
+#elif defined(__i386__)
+#if defined(MODULE)
+	writel(0xE010, ioaddr + PCIBusCfg);
+#else
+	/* When not a module we can work around broken '486 PCI boards. */
+#define x86 boot_cpu_data.x86
+	writel((x86 <= 4 ? 0x4810 : 0xE010), ioaddr + PCIBusCfg);
+	if (x86 <= 4)
+		printk(KERN_INFO "%s: This is a 386/486 PCI system, setting cache "
+			   "alignment to %x.\n", dev->name,
+			   (x86 <= 4 ? 0x4810 : 0x8010));
+#endif
+#else
+	writel(0xE010, ioaddr + PCIBusCfg);
+#warning Processor architecture undefined!
+#endif
+
+	if (dev->if_port == 0)
+		dev->if_port = np->default_port;
+
+	/* Fast Ethernet; 128 byte Tx threshold; 
+		Transmit on; Receive on; */
+	np->csr6 = 0x20022002;
+	check_duplex(dev);
+	set_rx_mode(dev);
+	writel(0, ioaddr + RxStartDemand);
+
+	/* Clear and Enable interrupts by setting the interrupt mask. */
+	writel(0x1A0F5, ioaddr + IntrStatus);
+	writel(0x1A0F5, ioaddr + IntrEnable);
+
+}
+
 static void tx_timeout(struct net_device *dev)
 {
 	struct netdev_private *np = (struct netdev_private *)dev->priv;
@@ -758,70 +870,61 @@
 			printk(" %8.8x", (unsigned int)np->rx_ring[i].status);
 		printk("\n"KERN_DEBUG"  Tx ring %8.8x: ", (int)np->tx_ring);
 		for (i = 0; i < TX_RING_SIZE; i++)
-			printk(" %4.4x", np->tx_ring[i].status);
+			printk(" %8.8x", np->tx_ring[i].status);
 		printk("\n");
 	}
+	printk(KERN_DEBUG "Tx cur %d Tx dirty %d Tx Full %d, q bytes %d.\n",
+				np->cur_tx, np->dirty_tx, np->tx_full,np->tx_q_bytes);
+	printk(KERN_DEBUG "Tx Descriptor addr %lxh.\n",readl(ioaddr+0x4C));
+
 #endif
+	spin_lock_irq(&np->lock);
+	/*
+	 * Under high load dirty_tx and the internal tx descriptor pointer
+	 * come out of sync, thus perform a software reset and reinitialize
+	 * everything.
+	 */
+
+	writel(1, dev->base_addr+PCIBusCfg);
+	udelay(10);
+
+	free_rxtx_rings(np);
 
-	/* Perhaps we should reinitialize the hardware here.  Just trigger a
-	   Tx demand for now. */
-	writel(0, ioaddr + TxStartDemand);
-	dev->if_port = 0;
-	/* Stop and restart the chip's Tx processes . */
+	init_rxtx_rings(dev);
+
+	init_registers(dev);
+
+	netif_wake_queue(dev);
+	spin_unlock_irq(&np->lock);
 
 	dev->trans_start = jiffies;
 	np->stats.tx_errors++;
 	return;
 }
 
-
 /* Initialize the Rx and Tx rings, along with various 'dev' bits. */
-static void init_ring(struct net_device *dev)
+static int alloc_ring(struct net_device *dev)
 {
 	struct netdev_private *np = (struct netdev_private *)dev->priv;
-	int i;
-
-	np->tx_full = 0;
-	np->tx_q_bytes = np->cur_rx = np->cur_tx = 0;
-	np->dirty_rx = np->dirty_tx = 0;
 
 	np->rx_buf_sz = (dev->mtu <= 1500 ? PKT_BUF_SZ : dev->mtu + 32);
-	np->rx_head_desc = &np->rx_ring[0];
-
-	/* Initial all Rx descriptors. */
-	for (i = 0; i < RX_RING_SIZE; i++) {
-		np->rx_ring[i].length = cpu_to_le32(np->rx_buf_sz);
-		np->rx_ring[i].status = 0;
-		np->rx_ring[i].next_desc = virt_to_le32desc(&np->rx_ring[i+1]);
-		np->rx_skbuff[i] = 0;
-	}
-	/* Mark the last entry as wrapping the ring. */
-	np->rx_ring[i-1].length |= cpu_to_le32(DescEndRing);
-	np->rx_ring[i-1].next_desc = virt_to_le32desc(&np->rx_ring[0]);
-
-	/* Fill in the Rx buffers.  Handle allocation failure gracefully. */
-	for (i = 0; i < RX_RING_SIZE; i++) {
-		struct sk_buff *skb = dev_alloc_skb(np->rx_buf_sz);
-		np->rx_skbuff[i] = skb;
-		if (skb == NULL)
-			break;
-		skb->dev = dev;			/* Mark as being used by this device. */
-		np->rx_ring[i].buffer1 = virt_to_le32desc(skb->tail);
-		np->rx_ring[i].status = cpu_to_le32(DescOwn | DescIntr);
-	}
-	np->dirty_rx = (unsigned int)(i - RX_RING_SIZE);
 
-	for (i = 0; i < TX_RING_SIZE; i++) {
-		np->tx_skbuff[i] = 0;
-		np->tx_ring[i].status = 0;
-	}
-	return;
+	np->rx_ring = pci_alloc_consistent(np->pdev,
+			sizeof(struct w840_rx_desc)*RX_RING_SIZE +
+			sizeof(struct w840_tx_desc)*TX_RING_SIZE,
+			&np->ring_dma_addr);
+	if(!np->rx_ring)
+		return -ENOMEM;
+	init_rxtx_rings(dev);
+	return 0;
 }
 
+
 static int start_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct netdev_private *np = (struct netdev_private *)dev->priv;
 	unsigned entry;
+	int len1, len2;
 
 	/* Caution: the write order is important here, set the field
 	   with the "ownership" bits last. */
@@ -830,76 +933,27 @@
 	entry = np->cur_tx % TX_RING_SIZE;
 
 	np->tx_skbuff[entry] = skb;
-	np->tx_ring[entry].buffer1 = virt_to_le32desc(skb->data);
-
-#define one_buffer
-#define BPT 1022
-#if defined(one_buffer)
-	np->tx_ring[entry].length = cpu_to_le32(DescWholePkt | skb->len);
+	np->tx_addr[entry] = pci_map_single(np->pdev,
+				skb->data,skb->len, PCI_DMA_TODEVICE);
+	np->tx_ring[entry].buffer1 = cpu_to_le32(np->tx_addr[entry]);
+	len2 = 0;
+	len1 = skb->len;
+	if(len1 > TX_BUFLIMIT) {
+		len1 = TX_BUFLIMIT;
+		len2 = skb->len-len1;
+		np->tx_ring[entry].buffer2 = cpu_to_le32(np->tx_addr[entry]+TX_BUFLIMIT);
+	}
+	np->tx_ring[entry].length = cpu_to_le32(DescWholePkt | (len2 << 11) | len1);
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
@@ -911,6 +965,7 @@
 		netif_stop_queue(dev);
 
 	dev->trans_start = jiffies;
+	spin_unlock_irq(&np->lock);
 
 	if (debug > 4) {
 		printk(KERN_DEBUG "%s: Transmit frame #%d queued in slot %d.\n",
@@ -977,6 +1032,9 @@
 				np->stats.tx_packets++;
 			}
 			/* Free the original skb. */
+			pci_unmap_single(np->pdev,np->tx_addr[entry],
+						np->tx_skbuff[entry]->len,
+						PCI_DMA_TODEVICE);
 			np->tx_q_bytes -= np->tx_skbuff[entry]->len;
 			dev_kfree_skb_irq(np->tx_skbuff[entry]);
 			np->tx_skbuff[entry] = 0;
@@ -1070,6 +1128,9 @@
 				&& (skb = dev_alloc_skb(pkt_len + 2)) != NULL) {
 				skb->dev = dev;
 				skb_reserve(skb, 2);	/* 16 byte align the IP header */
+				pci_dma_sync_single(np->pdev,np->rx_addr[entry],
+							np->rx_skbuff[entry]->len,
+							PCI_DMA_FROMDEVICE);
 				/* Call copy + cksum if available. */
 #if HAS_IP_COPYSUM
 				eth_copy_and_sum(skb, np->rx_skbuff[entry]->tail, pkt_len, 0);
@@ -1079,15 +1140,11 @@
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
@@ -1122,8 +1179,12 @@
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
 
@@ -1141,7 +1202,21 @@
 	if (intr_status == 0xffffffff)
 		return;
 	if (intr_status & TxFIFOUnderflow) {
-		np->csr6 += 0x4000;	/* Bump up the Tx threshold */
+		/* Bump up the Tx threshold */
+#if 0
+		/* This causes lots of dropped packets,
+		 * and under high load even tx_timeouts
+		 */
+		np->csr6 += 0x4000;
+#else
+		int cur = (np->csr6 >> 14)&0x7f;
+		if (cur < 64)
+			cur *= 2;
+		 else
+		 	cur = 0; /* load full packet before starting */
+		np->csr6 &= ~(0x7F << 14);
+		np->csr6 |= cur<<14;
+#endif
 		printk(KERN_DEBUG "%s: Tx underflow, increasing threshold to %8.8x.\n",
 			   dev->name, np->csr6);
 		writel(np->csr6, ioaddr + NetworkConfig);
@@ -1270,13 +1345,13 @@
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
@@ -1289,19 +1364,7 @@
 
 	del_timer_sync(&np->timer);
 
-	/* Free all the skbuffs in the Rx queue. */
-	for (i = 0; i < RX_RING_SIZE; i++) {
-		np->rx_ring[i].status = 0;
-		if (np->rx_skbuff[i]) {
-			dev_kfree_skb(np->rx_skbuff[i]);
-		}
-		np->rx_skbuff[i] = 0;
-	}
-	for (i = 0; i < TX_RING_SIZE; i++) {
-		if (np->tx_skbuff[i])
-			dev_kfree_skb(np->tx_skbuff[i]);
-		np->tx_skbuff[i] = 0;
-	}
+	free_rxtx_rings(np);
 
 	return 0;
 }
@@ -1311,7 +1374,7 @@
 	struct net_device *dev = pdev->driver_data;
 	
 	/* No need to check MOD_IN_USE, as sys_delete_module() checks. */
-	while (dev) {
+	if (dev) {
 		struct netdev_private *np = (void *)(dev->priv);
 		unregister_netdev(dev);
 #ifdef USE_IO_OPS

--------------B16ECE97F30D4B786E83D763--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
