Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287596AbSAMS06>; Sun, 13 Jan 2002 13:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287488AbSAMS0w>; Sun, 13 Jan 2002 13:26:52 -0500
Received: from colorfullife.com ([216.156.138.34]:33799 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S287596AbSAMS0f>;
	Sun, 13 Jan 2002 13:26:35 -0500
Message-ID: <3C41D12E.BCEAB938@colorfullife.com>
Date: Sun, 13 Jan 2002 19:25:50 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.2-pre11 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com
Subject: [PATCH] oom handling for winbond-840
Content-Type: multipart/mixed;
 boundary="------------F81AE2453B592209FBC7FA27"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F81AE2453B592209FBC7FA27
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

oom handling added into winbond-840.c

data members in netdev_private reordered for better readability (and
perhaps better cache line independace of TX and RX codepaths).

Tested on i386 SMP.

--
	Manfred
--------------F81AE2453B592209FBC7FA27
Content-Type: text/plain; charset=us-ascii;
 name="patch-winbond-oom"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-winbond-oom"

--- 2.5/drivers/net/winbond-840.c	Thu Oct 11 15:19:59 2001
+++ build-2.5/drivers/net/winbond-840.c	Sun Jan 13 18:57:26 2002
@@ -36,6 +36,8 @@
 		power management.
 		support for big endian descriptors
 			Copyright (C) 2001 Manfred Spraul
+	* OOM handling
+			Copyright (C) 2002 Manfred Spraul
   
 	TODO:
 	* enable pci_power_off
@@ -338,39 +340,52 @@
 	DescIntr=0x80000000,
 };
 
-#define PRIV_ALIGN	15 	/* Required alignment mask */
 #define MII_CNT		1 /* winbond only supports one MII */
 struct netdev_private {
+	/* 1) RX data - accessed only by the hw irq handler,
+	 * 	by the timer after disable_irq(),
+	 * 	by the resume & shutdown code, after del_timer_sync()
+	 * 	and disable_irq().
+	 */
 	struct w840_rx_desc *rx_ring;
-	dma_addr_t	rx_addr[RX_RING_SIZE];
-	struct w840_tx_desc *tx_ring;
-	dma_addr_t	tx_addr[RX_RING_SIZE];
-	dma_addr_t ring_dma_addr;
+	struct w840_rx_desc *rx_head_desc;
+	unsigned int rx_buf_sz;				/* Based on MTU+slack. */
+	unsigned int cur_rx, dirty_rx;		/* Producer/consumer ring indices */
+	int oom;
 	/* The addresses of receive-in-place skbuffs. */
 	struct sk_buff* rx_skbuff[RX_RING_SIZE];
-	/* The saved address of a sent-in-place packet/buffer, for later free(). */
-	struct sk_buff* tx_skbuff[TX_RING_SIZE];
+	dma_addr_t	rx_addr[RX_RING_SIZE];
+
+	/* 2) misc members, most for media setup */
+	dma_addr_t ring_dma_addr;
 	struct net_device_stats stats;
 	struct timer_list timer;	/* Media monitoring timer. */
-	/* Frequently used values: keep some adjacent for cache effect. */
-	spinlock_t lock;
 	int chip_id, drv_flags;
 	struct pci_dev *pci_dev;
 	int csr6;
-	struct w840_rx_desc *rx_head_desc;
-	unsigned int cur_rx, dirty_rx;		/* Producer/consumer ring indices */
-	unsigned int rx_buf_sz;				/* Based on MTU+slack. */
-	unsigned int cur_tx, dirty_tx;
-	unsigned int tx_q_bytes;
-	unsigned int tx_full;				/* The Tx queue is full. */
 	/* These values are keep track of the transceiver/media in use. */
 	unsigned int full_duplex:1;			/* Full-duplex operation requested. */
 	unsigned int duplex_lock:1;
 	/* MII transceiver section. */
-	int mii_cnt;						/* MII device addresses. */
-	u16 advertising;					/* NWay media advertisement */
-	unsigned char phys[MII_CNT];		/* MII device addresses, but only the first is used */
+	int mii_cnt;					/* MII device addresses. */
+	u16 advertising;				/* NWay media advertisement */
+	unsigned char phys[MII_CNT];	
 	u32 mii;
+
+	/* 3) TX data - accessed under spin_lock_irq(np->lock);.
+	 * Exception: start_tx (protected by dev_xmit_lock) reads
+	 * 	cur_tx
+	 * 	The spinlock is part of TX data, since packet TX
+	 * 	is the only common codepath that needs the lock.
+	 */
+	spinlock_t lock;
+	struct w840_tx_desc *tx_ring;
+	unsigned int cur_tx, dirty_tx;
+	/* The saved address of a sent-in-place packet/buffer, for later free(). */
+	unsigned int tx_q_bytes;
+	unsigned int tx_full;				/* The Tx queue is full. */
+	struct sk_buff* tx_skbuff[TX_RING_SIZE];
+	dma_addr_t	tx_addr[TX_RING_SIZE];
 };
 
 static int  eeprom_read(long ioaddr, int location);
@@ -378,6 +393,7 @@
 static void mdio_write(struct net_device *dev, int phy_id, int location, int value);
 static int  netdev_open(struct net_device *dev);
 static int  update_link(struct net_device *dev);
+static void refill_rx(struct net_device *dev);
 static void netdev_timer(unsigned long data);
 static void init_rxtx_rings(struct net_device *dev);
 static void free_rxtx_rings(struct netdev_private *np);
@@ -825,11 +841,40 @@
 		np->full_duplex = 1;
 }
 
+static void refill_rx(struct net_device *dev)
+{
+	struct netdev_private *np = dev->priv;
+
+	/* Refill the Rx ring buffers. */
+	np->oom = 0;
+	for (; np->cur_rx - np->dirty_rx > 0; np->dirty_rx++) {
+		struct sk_buff *skb;
+		int entry;
+		entry = np->dirty_rx % RX_RING_SIZE;
+		if (np->rx_skbuff[entry] == NULL) {
+			skb = dev_alloc_skb(np->rx_buf_sz);
+			np->rx_skbuff[entry] = skb;
+			if (skb == NULL)
+				break;		/* Better luck next round. */
+			skb->dev = dev;		/* Mark as being used by this device. */
+			np->rx_addr[entry] = pci_map_single(np->pci_dev,
+							skb->tail,
+							skb->len, PCI_DMA_FROMDEVICE);
+			np->rx_ring[entry].buffer1 = np->rx_addr[entry];
+		}
+		wmb();
+		np->rx_ring[entry].status = DescOwn;
+	}
+	if (np->cur_rx-np->dirty_rx == RX_RING_SIZE)
+		np->oom = 1;
+}
+
 static void netdev_timer(unsigned long data)
 {
 	struct net_device *dev = (struct net_device *)data;
 	struct netdev_private *np = dev->priv;
 	long ioaddr = dev->base_addr;
+	long next = 10*HZ;
 
 	if (debug > 2)
 		printk(KERN_DEBUG "%s: Media selection timer tick, status %8.8x "
@@ -839,8 +884,16 @@
 	spin_lock_irq(&np->lock);
 	update_csr6(dev, update_link(dev));
 	spin_unlock_irq(&np->lock);
-	np->timer.expires = jiffies + 10*HZ;
-	add_timer(&np->timer);
+	if (np->oom) {
+		disable_irq(dev->irq);
+		refill_rx(dev);
+		if (np->oom)
+			next = 1;
+		else
+			writel(0, ioaddr + RxStartDemand);
+		enable_irq(dev->irq);
+	}
+	mod_timer(&np->timer, jiffies + next);
 }
 
 static void init_rxtx_rings(struct net_device *dev)
@@ -860,22 +913,9 @@
 	/* Mark the last entry as wrapping the ring. */
 	np->rx_ring[i-1].length |= DescEndRing;
 
-	/* Fill in the Rx buffers.  Handle allocation failure gracefully. */
-	for (i = 0; i < RX_RING_SIZE; i++) {
-		struct sk_buff *skb = dev_alloc_skb(np->rx_buf_sz);
-		np->rx_skbuff[i] = skb;
-		if (skb == NULL)
-			break;
-		skb->dev = dev;			/* Mark as being used by this device. */
-		np->rx_addr[i] = pci_map_single(np->pci_dev,skb->tail,
-					skb->len,PCI_DMA_FROMDEVICE);
-
-		np->rx_ring[i].buffer1 = np->rx_addr[i];
-		np->rx_ring[i].status = DescOwn;
-	}
-
-	np->cur_rx = 0;
-	np->dirty_rx = (unsigned int)(i - RX_RING_SIZE);
+	np->cur_rx = RX_RING_SIZE;
+	np->dirty_rx = 0;
+	refill_rx(dev);
 
 	/* Initialize the Tx descriptors */
 	for (i = 0; i < TX_RING_SIZE; i++) {
@@ -1193,8 +1233,9 @@
 
 		if (intr_status & (IntrRxDone | RxNoBuf))
 			netdev_rx(dev);
-		if (intr_status & RxNoBuf)
-			writel(0, ioaddr + RxStartDemand);
+		/* RxNoBuf is an error interrupt, we kick
+		 * RxStartDemand in netdev_error()
+		 */
 
 		if (intr_status & (TxIdle | IntrTxDone) &&
 			np->cur_tx != np->dirty_tx) {
@@ -1326,25 +1367,7 @@
 		entry = (++np->cur_rx) % RX_RING_SIZE;
 		np->rx_head_desc = &np->rx_ring[entry];
 	}
-
-	/* Refill the Rx ring buffers. */
-	for (; np->cur_rx - np->dirty_rx > 0; np->dirty_rx++) {
-		struct sk_buff *skb;
-		entry = np->dirty_rx % RX_RING_SIZE;
-		if (np->rx_skbuff[entry] == NULL) {
-			skb = dev_alloc_skb(np->rx_buf_sz);
-			np->rx_skbuff[entry] = skb;
-			if (skb == NULL)
-				break;			/* Better luck next round. */
-			skb->dev = dev;			/* Mark as being used by this device. */
-			np->rx_addr[entry] = pci_map_single(np->pci_dev,
-							skb->tail,
-							skb->len, PCI_DMA_FROMDEVICE);
-			np->rx_ring[entry].buffer1 = np->rx_addr[entry];
-		}
-		wmb();
-		np->rx_ring[entry].status = DescOwn;
-	}
+	refill_rx(dev);
 
 	return 0;
 }
@@ -1388,8 +1411,14 @@
 		if (netif_device_present(dev))
 			writel(0x1A0F5, ioaddr + IntrEnable);
 	}
+	/* strictly only needed with RxNoBuf, but
+	 * kicking too often probably doesn't hurt.
+	 */
+	if (np->oom)
+		mod_timer(&np->timer, jiffies+1);
+	else
+		writel(0, ioaddr + RxStartDemand);
 	np->stats.rx_missed_errors += readl(ioaddr + RxMissed) & 0xffff;
-	writel(0, ioaddr + RxStartDemand);
 	spin_unlock(&np->lock);
 }
 
@@ -1537,6 +1566,7 @@
 			   dev->name, np->cur_tx, np->dirty_tx, np->cur_rx, np->dirty_rx);
 	}
 
+	del_timer_sync(&np->timer);
  	/* Stop the chip's Tx and Rx processes. */
 	spin_lock_irq(&np->lock);
 	netif_device_detach(dev);
@@ -1555,10 +1585,10 @@
 	if (debug > 2) {
 		int i;
 
-		printk("\n"KERN_DEBUG"  Tx ring at %8.8x:\n",
+		printk(KERN_DEBUG"  Tx ring at %8.8x:\n",
 			   (int)np->tx_ring);
 		for (i = 0; i < TX_RING_SIZE; i++)
-			printk(" #%d desc. %4.4x %4.4x %8.8x.\n",
+			printk(KERN_DEBUG " #%d desc. %4.4x %4.4x %8.8x.\n",
 				   i, np->tx_ring[i].length,
 				   np->tx_ring[i].status, np->tx_ring[i].buffer1);
 		printk("\n"KERN_DEBUG "  Rx ring %8.8x:\n",
@@ -1571,8 +1601,6 @@
 	}
 #endif /* __i386__ debugging only */
 
-	del_timer_sync(&np->timer);
-
 	free_rxtx_rings(np);
 	free_ringdesc(np);
 
@@ -1658,7 +1686,6 @@
 	return 0;
 }
 
-
 static int w840_resume (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
@@ -1682,8 +1709,7 @@
 
 		netif_wake_queue(dev);
 
-		np->timer.expires = jiffies + 1*HZ;
-		add_timer(&np->timer);
+		mod_timer(&np->timer, jiffies + 1*HZ);
 	} else {
 		netif_device_attach(dev);
 	}

--------------F81AE2453B592209FBC7FA27--


