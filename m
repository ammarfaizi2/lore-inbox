Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287484AbSALVOD>; Sat, 12 Jan 2002 16:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287488AbSALVNz>; Sat, 12 Jan 2002 16:13:55 -0500
Received: from colorfullife.com ([216.156.138.34]:20753 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S287484AbSALVNf>;
	Sat, 12 Jan 2002 16:13:35 -0500
Message-ID: <3C40A6F2.18A8C3E6@colorfullife.com>
Date: Sat, 12 Jan 2002 22:13:22 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.2-pre11 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Tim Hockin <thockin@sun.com>, linux-kernel@vger.kernel.org,
        jgarzik@mandrakesoft.com
Subject: [PATCH] Rx FIFO Overrun error found
Content-Type: multipart/mixed;
 boundary="------------912444018D9767D36E609D9E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------912444018D9767D36E609D9E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi all,

I think I found the reason for the Rx status FIFO overrun nic hang:
If the Rx fifo overflows, the nic sets RxStatusFIFOOver _instead_ of
IntrRxIntr.
Thus netdev_rx is never called, the rx ring is never refilled, nic
hangs.

The attached patch adds proper OOM handling to natsemi.c.
I've also copied the simpler netdev_close locking from ns83820.c.

--
	Manfred
--------------912444018D9767D36E609D9E
Content-Type: text/plain; charset=us-ascii;
 name="patch-natsemi"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-natsemi"

--- 2.5/drivers/net/natsemi.c	Fri Nov 23 20:35:23 2001
+++ build-2.5/drivers/net/natsemi.c	Sat Jan 12 20:59:24 2002
@@ -101,6 +101,12 @@
 
 	version 1.0.13:
 		* ETHTOOL_[GS]EEPROM support (Tim Hockin)
+	version 1.0.14:
+		* OOM error handling.
+		* reinit_ring() instead of {drain,init}_ring().
+		* Rx status FIFO overrun bug fixed:
+			The nic sets that bit instead of IntrRxDone, 
+			just call netdev_rx and hang is gone.
 
 	TODO:
 	* big endian support with CFG:BEM instead of cpu_to_le32
@@ -161,7 +167,7 @@
    There are no ill effects from too-large receive rings. */
 #define TX_RING_SIZE	16
 #define TX_QUEUE_LEN	10 /* Limit ring entries actually used, min 4. */
-#define RX_RING_SIZE	64
+#define RX_RING_SIZE	32
 
 /* Operational parameters that usually are not changed. */
 /* Time in jiffies before concluding the transmitter is hung. */
@@ -612,6 +618,7 @@
 	unsigned int cur_rx, dirty_rx;		/* Producer/consumer ring indices */
 	unsigned int cur_tx, dirty_tx;
 	unsigned int rx_buf_sz;				/* Based on MTU+slack. */
+	unsigned int oom;
 	/* These values are keep track of the transceiver/media in use. */
 	unsigned int full_duplex;
 	/* Rx filter. */
@@ -640,9 +647,12 @@
 static void netdev_timer(unsigned long data);
 static void tx_timeout(struct net_device *dev);
 static int alloc_ring(struct net_device *dev);
+static void refill_rx(struct net_device *dev);
 static void init_ring(struct net_device *dev);
+static void drain_tx(struct net_device *dev);
 static void drain_ring(struct net_device *dev);
 static void free_ring(struct net_device *dev);
+static void reinit_ring(struct net_device *dev);
 static void init_registers(struct net_device *dev);
 static int start_tx(struct sk_buff *skb, struct net_device *dev);
 static void intr_handler(int irq, void *dev_instance, struct pt_regs *regs);
@@ -1191,11 +1201,15 @@
 }
 
 /* 
- * The frequency on this has been increased because of a nasty little problem.
+ * netdev_timer:
+ * Purpose:
+ * 1) check for link changes. Usually they are handled by the MII interrupt
+ * 2) check for sudden death of the NIC:
  * It seems that a reference set for this chip went out with incorrect info,
  * and there exist boards that aren't quite right.  An unexpected voltage drop
  * can cause the PHY to get itself in a weird state (basically reset..).
  * NOTE: this only seems to affect revC chips.
+ * 3) check of death of the RX path due to OOM.
  */
 static void netdev_timer(unsigned long data)
 {
@@ -1213,17 +1227,22 @@
 			   dev->name);
 	}
 
+	spin_lock_irq(&np->lock);
+
 	/* check for a nasty random phy-reset - use dspcfg as a flag */
 	writew(1, ioaddr+PGSEL);
 	dspcfg = readw(ioaddr+DSPCFG);
 	writew(0, ioaddr+PGSEL);
 	if (dspcfg != DSPCFG_VAL) {
 		if (!netif_queue_stopped(dev)) {
+			spin_unlock_irq(&np->lock);
 			printk(KERN_INFO 
 				"%s: possible phy reset: re-initializing\n",
 				dev->name);
 			disable_irq(dev->irq);
 			spin_lock_irq(&np->lock);
+			natsemi_reset(dev);
+			reinit_ring(dev);
 			init_registers(dev);
 			spin_unlock_irq(&np->lock);
 			enable_irq(dev->irq);
@@ -1233,9 +1252,19 @@
 		}
 	} else {
 		/* init_registers() calls check_link() for the above case */
-		spin_lock_irq(&np->lock);
 		check_link(dev);
-		spin_unlock_irq(&np->lock);
+	}
+	spin_unlock_irq(&np->lock);
+	if (np->oom) {
+		disable_irq(dev->irq);
+		np->oom = 0;
+		refill_rx(dev);
+		enable_irq(dev->irq);
+		if (!np->oom) {
+			writel(RxOn, dev->base_addr + ChipCmd);
+		} else {
+			next_tick = 1;
+		}
 	}
 	mod_timer(&np->timer, jiffies + next_tick);
 }
@@ -1277,8 +1306,7 @@
 		dump_ring(dev);
 
 		natsemi_reset(dev);
-		drain_ring(dev);
-		init_ring(dev);
+		reinit_ring(dev);
 		init_registers(dev);
 	} else {
 		printk(KERN_WARNING 
@@ -1305,15 +1333,53 @@
 	return 0;
 }
 
+static void refill_rx(struct net_device *dev)
+{
+	struct netdev_private *np = dev->priv;
+
+	/* Refill the Rx ring buffers. */
+	for (; np->cur_rx - np->dirty_rx > 0; np->dirty_rx++) {
+		struct sk_buff *skb;
+		int entry = np->dirty_rx % RX_RING_SIZE;
+		if (np->rx_skbuff[entry] == NULL) {
+			skb = dev_alloc_skb(np->rx_buf_sz);
+			np->rx_skbuff[entry] = skb;
+			if (skb == NULL)
+				break;				/* Better luck next round. */
+			skb->dev = dev;			/* Mark as being used by this device. */
+			np->rx_dma[entry] = pci_map_single(np->pci_dev,
+							skb->data, skb->len, PCI_DMA_FROMDEVICE);
+			np->rx_ring[entry].addr = cpu_to_le32(np->rx_dma[entry]);
+		}
+		np->rx_ring[entry].cmd_status =
+			cpu_to_le32(np->rx_buf_sz);
+	}
+	if (np->cur_rx - np->dirty_tx == RX_RING_SIZE) {
+		if (debug > 2)
+			printk(KERN_INFO "%s: going OOM.\n", dev->name);
+		np->oom = 1;
+	}
+}
+
 /* Initialize the Rx and Tx rings, along with various 'dev' bits. */
 static void init_ring(struct net_device *dev)
 {
 	struct netdev_private *np = dev->priv;
 	int i;
 
-	np->cur_rx = np->cur_tx = 0;
-	np->dirty_rx = np->dirty_tx = 0;
+	/* 1) TX ring */
+	np->dirty_tx = np->cur_tx = 0;
+	for (i = 0; i < TX_RING_SIZE; i++) {
+		np->tx_skbuff[i] = NULL;
+		np->tx_ring[i].next_desc = cpu_to_le32(np->ring_dma
+					+sizeof(struct netdev_desc)
+					 *((i+1)%TX_RING_SIZE+RX_RING_SIZE));
+		np->tx_ring[i].cmd_status = 0;
+	}
 
+	/* 2) RX ring */
+	np->dirty_rx = 0;
+	np->cur_rx = RX_RING_SIZE;
 	np->rx_buf_sz = (dev->mtu <= 1500 ? PKT_BUF_SZ : dev->mtu + 32);
 	np->rx_head_desc = &np->rx_ring[0];
 
@@ -1328,29 +1394,25 @@
 		np->rx_ring[i].cmd_status = cpu_to_le32(DescOwn);
 		np->rx_skbuff[i] = NULL;
 	}
+	refill_rx(dev);
+	dump_ring(dev);
+}
 
-	/* Fill in the Rx buffers.  Handle allocation failure gracefully. */
-	for (i = 0; i < RX_RING_SIZE; i++) {
-		struct sk_buff *skb = dev_alloc_skb(np->rx_buf_sz);
-		np->rx_skbuff[i] = skb;
-		if (skb == NULL)
-			break;
-		skb->dev = dev;			/* Mark as being used by this device. */
-		np->rx_dma[i] = pci_map_single(np->pci_dev,
-						skb->data, skb->len, PCI_DMA_FROMDEVICE);
-		np->rx_ring[i].addr = cpu_to_le32(np->rx_dma[i]);
-		np->rx_ring[i].cmd_status = cpu_to_le32(np->rx_buf_sz);
-	}
-	np->dirty_rx = (unsigned int)(i - RX_RING_SIZE);
+static void drain_tx(struct net_device *dev)
+{
+	struct netdev_private *np = dev->priv;
+	int i;
 
 	for (i = 0; i < TX_RING_SIZE; i++) {
+		if (np->tx_skbuff[i]) {
+			pci_unmap_single(np->pci_dev,
+						np->rx_dma[i],
+						np->rx_skbuff[i]->len,
+						PCI_DMA_TODEVICE);
+			dev_kfree_skb(np->tx_skbuff[i]);
+		}
 		np->tx_skbuff[i] = NULL;
-		np->tx_ring[i].next_desc = cpu_to_le32(np->ring_dma
-					+sizeof(struct netdev_desc)
-					 *((i+1)%TX_RING_SIZE+RX_RING_SIZE));
-		np->tx_ring[i].cmd_status = 0;
 	}
-	dump_ring(dev);
 }
 
 static void drain_ring(struct net_device *dev)
@@ -1371,16 +1433,29 @@
 		}
 		np->rx_skbuff[i] = NULL;
 	}
-	for (i = 0; i < TX_RING_SIZE; i++) {
-		if (np->tx_skbuff[i]) {
-			pci_unmap_single(np->pci_dev,
-						np->rx_dma[i],
-						np->rx_skbuff[i]->len,
-						PCI_DMA_TODEVICE);
-			dev_kfree_skb(np->tx_skbuff[i]);
-		}
-		np->tx_skbuff[i] = NULL;
-	}
+	drain_tx(dev);
+}
+
+static void reinit_ring(struct net_device *dev)
+{
+	struct netdev_private *np = dev->priv;
+	int i;
+
+	/* drain TX ring */
+	drain_tx(dev);
+	np->dirty_tx = np->cur_tx = 0;
+	for (i=0;i<TX_RING_SIZE;i++)
+		np->tx_ring[i].cmd_status = 0;
+
+	/* RX Ring */
+	np->dirty_rx = 0;
+	np->cur_rx = RX_RING_SIZE;
+	np->rx_head_desc = &np->rx_ring[0];
+	/* Initialize all Rx descriptors. */
+	for (i = 0; i < RX_RING_SIZE; i++)
+		np->rx_ring[i].cmd_status = cpu_to_le32(DescOwn);
+
+	refill_rx(dev);
 }
 
 static void free_ring(struct net_device *dev)
@@ -1508,7 +1583,7 @@
 		if (intr_status == 0)
 			break;
 
-		if (intr_status & (IntrRxDone | IntrRxIntr))
+		if (intr_status & (IntrRxDone | IntrRxIntr |  RxStatusFIFOOver))
 			netdev_rx(dev);
 
 		if (intr_status & (IntrTxDone | IntrTxIntr | IntrTxIdle | IntrTxErr) ) {
@@ -1610,26 +1685,14 @@
 		desc_status = le32_to_cpu(np->rx_head_desc->cmd_status);
 	}
 
-	/* Refill the Rx ring buffers. */
-	for (; np->cur_rx - np->dirty_rx > 0; np->dirty_rx++) {
-		struct sk_buff *skb;
-		entry = np->dirty_rx % RX_RING_SIZE;
-		if (np->rx_skbuff[entry] == NULL) {
-			skb = dev_alloc_skb(np->rx_buf_sz);
-			np->rx_skbuff[entry] = skb;
-			if (skb == NULL)
-				break;				/* Better luck next round. */
-			skb->dev = dev;			/* Mark as being used by this device. */
-			np->rx_dma[entry] = pci_map_single(np->pci_dev,
-							skb->data, skb->len, PCI_DMA_FROMDEVICE);
-			np->rx_ring[entry].addr = cpu_to_le32(np->rx_dma[entry]);
-		}
-		np->rx_ring[entry].cmd_status =
-			cpu_to_le32(np->rx_buf_sz);
-	}
+	refill_rx(dev);
 
 	/* Restart Rx engine if stopped. */
-	writel(RxOn, dev->base_addr + ChipCmd);
+	if (np->oom)
+		mod_timer(&np->timer, jiffies + 1);
+	else
+		writel(RxOn, dev->base_addr + ChipCmd);
+
 }
 
 static void netdev_error(struct net_device *dev, int intr_status)
@@ -2331,7 +2394,8 @@
 		/* enable the WOL interrupt.
 		 * Could be used to send a netlink message.
 		 */
-		writel(readl(ioaddr + IntrMask) | WOLPkt, ioaddr + IntrMask);
+		writel(WOLPkt, ioaddr + IntrMask);
+		writel(1, ioaddr + IntrEnable);
 	}
 }
 
@@ -2341,7 +2405,6 @@
 	struct netdev_private *np = dev->priv;
 
 	netif_stop_queue(dev);
-	netif_carrier_off(dev);
 
 	if (debug > 1) {
 		printk(KERN_DEBUG "%s: Shutting down ethercard, status was %4.4x.\n",
@@ -2350,13 +2413,17 @@
 			   dev->name, np->cur_tx, np->dirty_tx, np->cur_rx, np->dirty_rx);
 	}
 
+	/* Disable interrupts, and flush posted writes */
+	writel(0, ioaddr + IntrEnable);
+	readl(ioaddr + IntrEnable);
+	free_irq(dev->irq, dev);
 	del_timer_sync(&np->timer);
-
-	disable_irq(dev->irq);
+	/* Interrupt disabled, interrupt handler released,
+	 * queue stopped, timer deleted. All async codepaths
+	 * that access the driver are disabled.
+	 */
 	spin_lock_irq(&np->lock);
 
-	/* Disable and clear interrupts */
-	writel(0, ioaddr + IntrEnable);
 	readl(ioaddr + IntrMask);
 	readw(ioaddr + MIntrStatus);
 
@@ -2369,17 +2436,6 @@
 	__get_stats(dev);
 	spin_unlock_irq(&np->lock);
 
-	/* race: shared irq and as most nics the DP83815
-	 * reports _all_ interrupt conditions in IntrStatus, even
-	 * disabled ones.
-	 * packet received after disable_irq, but before stop_rxtx
-	 * --> race. intr_handler would restart the rx process.
-	 * netif_device_{de,a}tach around {enable,free}_irq.
-	 */
-	netif_device_detach(dev);
-	enable_irq(dev->irq);
-	free_irq(dev->irq, dev);
-	netif_device_attach(dev);
 	/* clear the carrier last - an interrupt could reenable it otherwise */
 	netif_carrier_off(dev);
 
@@ -2387,7 +2443,7 @@
 	drain_ring(dev);
 	free_ring(dev);
 
-	 {
+	{
 		u32 wol = readl(ioaddr + WOLCmd) & WakeOptsSummary;
 		if (wol) {
 			/* restart the NIC in WOL mode.


--------------912444018D9767D36E609D9E--

