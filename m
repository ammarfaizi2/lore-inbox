Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261216AbRELKCf>; Sat, 12 May 2001 06:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261217AbRELKCQ>; Sat, 12 May 2001 06:02:16 -0400
Received: from colorfullife.com ([216.156.138.34]:51468 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S261216AbRELKCH>;
	Sat, 12 May 2001 06:02:07 -0400
Message-ID: <3AFD0A27.49C11072@colorfullife.com>
Date: Sat, 12 May 2001 12:02:15 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-ac8 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] winbond-840 update
Content-Type: multipart/mixed;
 boundary="------------B0803BF0251440E60BC0E544"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B0803BF0251440E60BC0E544
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Minor update for the winbond-840 driver:

* fix for memory leak in netdev_close()
* SMP locking fixes (csr6, mdio)

I still try to figure out why freebsd doesn't need the fifo bug
workaround.

--
	Manfred
--------------B0803BF0251440E60BC0E544
Content-Type: text/plain; charset=us-ascii;
 name="patch-winbond"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-winbond"

--- 2.4/drivers/net/winbond-840.c	Thu May 10 22:13:49 2001
+++ build-2.4/drivers/net/winbond-840.c	Sat May 12 11:59:43 2001
@@ -32,10 +32,13 @@
 		synchronize tx_q_bytes
 		software reset in tx_timeout
 			Copyright (C) 2000 Manfred Spraul
+	* further cleanups
+			Copyright (c) 2001 Manfred Spraul
 
 	TODO:
 	* according to the documentation, the chip supports big endian
 		descriptors. Remove cpu_to_le32, enable BE descriptors.
+	* figure out why FreeBSD doesn't need the FIFO workaround
 */
 
 /* Automatically extracted configuration info:
@@ -128,7 +131,7 @@
 
 /* These identify the driver base version and may not be removed. */
 static char version[] __devinitdata =
-KERN_INFO "winbond-840.c:v1.01 (2.4 port) 5/15/2000  Donald Becker <becker@scyld.com>\n"
+KERN_INFO "winbond-840.c:v1.01.m2 5/15/2000  Donald Becker <becker@scyld.com>\n"
 KERN_INFO "  http://www.scyld.com/network/drivers.html\n";
 
 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
@@ -302,7 +305,7 @@
 struct w840_tx_desc {
 	s32 status;
 	s32 length;
-	u32 buffer1, buffer2;				/* We use only buffer 1.  */
+	u32 buffer1, buffer2;
 };
 
 /* Bits in network_desc.status */
@@ -340,8 +343,6 @@
 	/* These values are keep track of the transceiver/media in use. */
 	unsigned int full_duplex:1;			/* Full-duplex operation requested. */
 	unsigned int duplex_lock:1;
-	unsigned int medialock:1;			/* Do not sense media. */
-	unsigned int default_port:4;		/* Last dev->if_port value. */
 	/* MII transceiver section. */
 	int mii_cnt;						/* MII device addresses. */
 	u16 advertising;					/* NWay media advertisement */
@@ -352,13 +353,14 @@
 static int  mdio_read(struct net_device *dev, int phy_id, int location);
 static void mdio_write(struct net_device *dev, int phy_id, int location, int value);
 static int  netdev_open(struct net_device *dev);
-static void check_duplex(struct net_device *dev);
+static int  update_link(struct net_device *dev);
 static void netdev_timer(unsigned long data);
 static void init_rxtx_rings(struct net_device *dev);
 static void free_rxtx_rings(struct netdev_private *np);
 static void init_registers(struct net_device *dev);
 static void tx_timeout(struct net_device *dev);
-static int alloc_ring(struct net_device *dev);
+static int alloc_ringdesc(struct net_device *dev);
+static void free_ringdesc(struct netdev_private *np);
 static int  start_tx(struct sk_buff *skb, struct net_device *dev);
 static void intr_handler(int irq, void *dev_instance, struct pt_regs *regs);
 static void netdev_error(struct net_device *dev, int intr_status);
@@ -437,9 +439,9 @@
 	if (option > 0) {
 		if (option & 0x200)
 			np->full_duplex = 1;
-		np->default_port = option & 15;
-		if (np->default_port)
-			np->medialock = 1;
+		if (option & 15)
+			printk(KERN_INFO "%s: ignoring user supplied media type %d",
+				dev->name, option & 15);
 	}
 	if (find_cnt < MAX_UNITS  &&  full_duplex[find_cnt] > 0)
 		np->full_duplex = 1;
@@ -667,7 +669,7 @@
 		printk(KERN_DEBUG "%s: w89c840_open() irq %d.\n",
 			   dev->name, dev->irq);
 
-	if((i=alloc_ring(dev)))
+	if((i=alloc_ringdesc(dev)))
 		return i;
 
 	init_registers(dev);
@@ -678,7 +680,7 @@
 
 	/* Set the timer to check for link beat. */
 	init_timer(&np->timer);
-	np->timer.expires = jiffies + 3*HZ;
+	np->timer.expires = jiffies + 1*HZ;
 	np->timer.data = (unsigned long)dev;
 	np->timer.function = &netdev_timer;				/* timer handler */
 	add_timer(&np->timer);
@@ -686,25 +688,89 @@
 	return 0;
 }
 
-static void check_duplex(struct net_device *dev)
+static int update_link(struct net_device *dev)
 {
 	struct netdev_private *np = dev->priv;
-	int mii_reg5 = mdio_read(dev, np->phys[0], 5);
-	int negotiated =  mii_reg5 & np->advertising;
-	int duplex;
+	int negotiated, duplex, fasteth, result, mii_reg;
 
-	if (np->duplex_lock  ||  mii_reg5 == 0xffff)
+	/* BSMR */
+	mii_reg = mdio_read(dev, np->phys[0], 1);
+
+	if (mii_reg == 0xffff)
+		return np->csr6;
+	/* reread: the link status bit is sticky */
+	mii_reg = mdio_read(dev, np->phys[0], 1);
+
+	if (!mii_reg & 0x4) {
+		if (netif_carrier_ok(dev)) {
+			printk(KERN_INFO "%s: MII #%d reports no link. Disabling watchdog.\n",
+				dev->name, np->phys[0]);
+			netif_carrier_off(dev);
+		}
+		return np->csr6;
+	}
+	if (!netif_carrier_ok(dev)) {
+		printk(KERN_INFO "%s: MII #%d link is back. Enabling watchdog.\n",
+			dev->name, np->phys[0]);
+		netif_carrier_on(dev);
+	}
+
+	mii_reg	= mdio_read(dev, np->phys[0], 5);
+	negotiated = mii_reg & np->advertising;
+
+	/* remove fastether and fullduplex */
+	result = np->csr6 & ~0x20000200;
+
+	duplex = np->duplex_lock || (negotiated & 0x0100) || ((negotiated & 0x02C0) == 0x0040);
+	if (duplex)
+		result |= 0x200;
+
+	fasteth = negotiated & 0x380;
+	if (fasteth)
+		result |= 0x20000000;
+	if (result != np->csr6 && debug)
+		printk(KERN_INFO "%s: Setting %s-duplex based on MII #%d "
+			   "negotiated capability %4.4x.\n", dev->name,
+			   duplex ? "full" : "half", np->phys[0], negotiated);
+	return result;
+}
+
+#define RXTX_TIMEOUT	2000
+static inline void update_csr6(struct net_device *dev, int new)
+{
+	struct netdev_private *np = dev->priv;
+	long ioaddr = dev->base_addr;
+	int limit = RXTX_TIMEOUT;
+
+	if (new==np->csr6)
 		return;
-	duplex = (negotiated & 0x0100) || (negotiated & 0x01C0) == 0x0040;
-	if (np->full_duplex != duplex) {
-		np->full_duplex = duplex;
-		if (debug)
-			printk(KERN_INFO "%s: Setting %s-duplex based on MII #%d "
-				   "negotiated capability %4.4x.\n", dev->name,
-				   duplex ? "full" : "half", np->phys[0], negotiated);
-		np->csr6 &= ~0x200;
-		np->csr6 |= duplex ? 0x200 : 0;
+	/* stop both Tx and Rx processes */
+	writel(np->csr6 & ~0x2002, ioaddr + NetworkConfig);
+	/* wait until they have really stopped */
+	for (;;) {
+		int csr5 = readl(ioaddr + IntrStatus);
+		int t;
+
+		t = (csr5 >> 17) & 0x07;
+		if (t==0||t==1) {
+			/* rx stopped */
+			t = (csr5 >> 20) & 0x07;
+			if (t==0||t==1)
+				break;
+		}
+
+		limit--;
+		if(!limit) {
+			printk(KERN_INFO "%s: couldn't stop rxtx, IntrStatus %xh.\n",
+					dev->name, csr5);
+			break;
+		}
+		udelay(1);
+
 	}
+	np->csr6 = new;
+	/* and restart them with the new configuration */
+	writel(np->csr6, ioaddr + NetworkConfig);
 }
 
 static void netdev_timer(unsigned long data)
@@ -712,8 +778,6 @@
 	struct net_device *dev = (struct net_device *)data;
 	struct netdev_private *np = dev->priv;
 	long ioaddr = dev->base_addr;
-	int next_tick = 10*HZ;
-	int old_csr6 = np->csr6;
 
 	if (debug > 2)
 		printk(KERN_DEBUG "%s: Media selection timer tick, status %8.8x "
@@ -721,13 +785,9 @@
 			   dev->name, (int)readl(ioaddr + IntrStatus),
 			   (int)readl(ioaddr + NetworkConfig));
 	spin_lock_irq(&np->lock);
-	check_duplex(dev);
-	if (np->csr6 != old_csr6) {
-		writel(np->csr6 & ~0x0002, ioaddr + NetworkConfig);
-		writel(np->csr6 | 0x2002, ioaddr + NetworkConfig);
-	}
+	update_csr6(dev, update_link(dev));
 	spin_unlock_irq(&np->lock);
-	np->timer.expires = jiffies + next_tick;
+	np->timer.expires = jiffies + 10*HZ;
 	add_timer(&np->timer);
 }
 
@@ -847,19 +907,20 @@
 #warning Processor architecture undefined!
 #endif
 
-	if (dev->if_port == 0)
-		dev->if_port = np->default_port;
-
-	/* Fast Ethernet; 128 byte Tx threshold; 
+	/* 128 byte Tx threshold; 
 		Transmit on; Receive on; */
-	np->csr6 = 0x20022002;
-	check_duplex(dev);
-	set_rx_mode(dev);
-	writel(0, ioaddr + RxStartDemand);
+	np->csr6 = 0x00022002;
+	update_link(dev);
 
 	/* Clear and Enable interrupts by setting the interrupt mask. */
+	/* But defer interrupt processing until everything is set up */
+	disable_irq(dev->irq);
 	writel(0x1A0F5, ioaddr + IntrStatus);
 	writel(0x1A0F5, ioaddr + IntrEnable);
+	set_rx_mode(dev);
+
+	enable_irq(dev->irq);
+	writel(0, ioaddr + RxStartDemand);
 
 }
 
@@ -887,12 +948,14 @@
 	printk(KERN_DEBUG "Tx Descriptor addr %xh.\n",readl(ioaddr+0x4C));
 
 #endif
-	spin_lock_irq(&np->lock);
 	/*
 	 * Under high load dirty_tx and the internal tx descriptor pointer
 	 * come out of sync, thus perform a software reset and reinitialize
 	 * everything.
 	 */
+	disable_irq(dev->irq);
+	del_timer_sync(&np->timer);
+	spin_lock(&np->lock);
 
 	writel(1, dev->base_addr+PCIBusCfg);
 	udelay(1);
@@ -900,18 +963,20 @@
 	free_rxtx_rings(np);
 	init_rxtx_rings(dev);
 	init_registers(dev);
-	set_rx_mode(dev);
 
-	spin_unlock_irq(&np->lock);
+	spin_unlock(&np->lock);
+	enable_irq(dev->irq);
 
 	netif_wake_queue(dev);
 	dev->trans_start = jiffies;
 	np->stats.tx_errors++;
-	return;
+
+	np->timer.expires = jiffies + 1*HZ;
+	add_timer(&np->timer);
 }
 
 /* Initialize the Rx and Tx rings, along with various 'dev' bits. */
-static int alloc_ring(struct net_device *dev)
+static int alloc_ringdesc(struct net_device *dev)
 {
 	struct netdev_private *np = dev->priv;
 
@@ -927,6 +992,14 @@
 	return 0;
 }
 
+static void free_ringdesc(struct netdev_private *np)
+{
+	pci_free_consistent(np->pci_dev,
+			sizeof(struct w840_rx_desc)*RX_RING_SIZE +
+			sizeof(struct w840_tx_desc)*TX_RING_SIZE,
+			np->rx_ring, np->ring_dma_addr);
+
+}
 
 static int start_tx(struct sk_buff *skb, struct net_device *dev)
 {
@@ -958,9 +1031,9 @@
 
 	/* The spinlock protects against 2 races:
 	 * - tx_q_bytes is updated by this function and intr_handler
-	 * - our hardware is extremely fast and finishes the packet between
-	 *	our check for "queue full" and netif_stop_queue.
-	 *	Thus setting DescOwn and netif_stop_queue must be atomic.
+	 * - netdev_tx_done() could run immediately after setting DescOwn.
+	 *   If setting DescOwn and netif_stop_queue() is not atomic, we can
+	 *   lock up.
 	 */
 	spin_lock_irq(&np->lock);
 
@@ -990,6 +1063,56 @@
 	return 0;
 }
 
+static void netdev_tx_done(struct net_device *dev)
+{
+	struct netdev_private *np = dev->priv;
+	for (; np->cur_tx - np->dirty_tx > 0; np->dirty_tx++) {
+		int entry = np->dirty_tx % TX_RING_SIZE;
+		int tx_status = le32_to_cpu(np->tx_ring[entry].status);
+
+		if (tx_status < 0)
+			break;
+		if (tx_status & 0x8000) { 	/* There was an error, log it. */
+#ifndef final_version
+			if (debug > 1)
+				printk(KERN_DEBUG "%s: Transmit error, Tx status %8.8x.\n",
+					   dev->name, tx_status);
+#endif
+			np->stats.tx_errors++;
+			if (tx_status & 0x0104) np->stats.tx_aborted_errors++;
+			if (tx_status & 0x0C80) np->stats.tx_carrier_errors++;
+			if (tx_status & 0x0200) np->stats.tx_window_errors++;
+			if (tx_status & 0x0002) np->stats.tx_fifo_errors++;
+			if ((tx_status & 0x0080) && np->full_duplex == 0)
+				np->stats.tx_heartbeat_errors++;
+#ifdef ETHER_STATS
+			if (tx_status & 0x0100) np->stats.collisions16++;
+#endif
+		} else {
+#ifdef ETHER_STATS
+			if (tx_status & 0x0001) np->stats.tx_deferred++;
+#endif
+			np->stats.tx_bytes += np->tx_skbuff[entry]->len;
+			np->stats.collisions += (tx_status >> 3) & 15;
+			np->stats.tx_packets++;
+		}
+		/* Free the original skb. */
+		pci_unmap_single(np->pci_dev,np->tx_addr[entry],
+					np->tx_skbuff[entry]->len,
+					PCI_DMA_TODEVICE);
+		np->tx_q_bytes -= np->tx_skbuff[entry]->len;
+		dev_kfree_skb_irq(np->tx_skbuff[entry]);
+		np->tx_skbuff[entry] = 0;
+	}
+	if (np->tx_full &&
+		np->cur_tx - np->dirty_tx < TX_QUEUE_LEN - 4
+		&&  np->tx_q_bytes < TX_BUG_FIFO_LIMIT) {
+		/* The ring is no longer full, clear tbusy. */
+		np->tx_full = 0;
+		netif_wake_queue(dev);
+	}
+}
+
 /* The interrupt handler does all of the Rx thread work and cleans up
    after the Tx thread. */
 static void intr_handler(int irq, void *dev_instance, struct pt_regs *rgs)
@@ -999,7 +1122,6 @@
 	long ioaddr = dev->base_addr;
 	int work_limit = max_interrupt_work;
 
-	spin_lock(&np->lock);
 
 	do {
 		u32 intr_status = readl(ioaddr + IntrStatus);
@@ -1016,51 +1138,14 @@
 
 		if (intr_status & (IntrRxDone | RxNoBuf))
 			netdev_rx(dev);
+		if (intr_status & RxNoBuf)
+			writel(0, ioaddr + RxStartDemand);
 
-		for (; np->cur_tx - np->dirty_tx > 0; np->dirty_tx++) {
-			int entry = np->dirty_tx % TX_RING_SIZE;
-			int tx_status = le32_to_cpu(np->tx_ring[entry].status);
-
-			if (tx_status < 0)
-				break;
-			if (tx_status & 0x8000) { 		/* There was an error, log it. */
-#ifndef final_version
-				if (debug > 1)
-					printk(KERN_DEBUG "%s: Transmit error, Tx status %8.8x.\n",
-						   dev->name, tx_status);
-#endif
-				np->stats.tx_errors++;
-				if (tx_status & 0x0104) np->stats.tx_aborted_errors++;
-				if (tx_status & 0x0C80) np->stats.tx_carrier_errors++;
-				if (tx_status & 0x0200) np->stats.tx_window_errors++;
-				if (tx_status & 0x0002) np->stats.tx_fifo_errors++;
-				if ((tx_status & 0x0080) && np->full_duplex == 0)
-					np->stats.tx_heartbeat_errors++;
-#ifdef ETHER_STATS
-				if (tx_status & 0x0100) np->stats.collisions16++;
-#endif
-			} else {
-#ifdef ETHER_STATS
-				if (tx_status & 0x0001) np->stats.tx_deferred++;
-#endif
-				np->stats.tx_bytes += np->tx_skbuff[entry]->len;
-				np->stats.collisions += (tx_status >> 3) & 15;
-				np->stats.tx_packets++;
-			}
-			/* Free the original skb. */
-			pci_unmap_single(np->pci_dev,np->tx_addr[entry],
-						np->tx_skbuff[entry]->len,
-						PCI_DMA_TODEVICE);
-			np->tx_q_bytes -= np->tx_skbuff[entry]->len;
-			dev_kfree_skb_irq(np->tx_skbuff[entry]);
-			np->tx_skbuff[entry] = 0;
-		}
-		if (np->tx_full &&
-			np->cur_tx - np->dirty_tx < TX_QUEUE_LEN - 4
-			&&  np->tx_q_bytes < TX_BUG_FIFO_LIMIT) {
-			/* The ring is no longer full, clear tbusy. */
-			np->tx_full = 0;
-			netif_wake_queue(dev);
+		if (intr_status & (TxIdle | IntrTxDone) &&
+			np->cur_tx != np->dirty_tx) {
+			spin_lock(&np->lock);
+			netdev_tx_done(dev);
+			spin_unlock(&np->lock);
 		}
 
 		/* Abnormal error summary/uncommon events handlers. */
@@ -1082,8 +1167,6 @@
 	if (debug > 3)
 		printk(KERN_DEBUG "%s: exiting interrupt, status=%#4.4x.\n",
 			   dev->name, (int)readl(ioaddr + IntrStatus));
-
-	spin_unlock(&np->lock);
 }
 
 /* This routine is logically part of the interrupt handler, but separated
@@ -1218,24 +1301,26 @@
 	if (intr_status == 0xffffffff)
 		return;
 	if (intr_status & TxFIFOUnderflow) {
+		int new;
 		/* Bump up the Tx threshold */
+		spin_lock(&np->lock);
 #if 0
 		/* This causes lots of dropped packets,
 		 * and under high load even tx_timeouts
 		 */
-		np->csr6 += 0x4000;
+		new = np->csr6 + 0x4000;
 #else
-		int cur = (np->csr6 >> 14)&0x7f;
-		if (cur < 64)
-			cur *= 2;
+		new = (np->csr6 >> 14)&0x7f;
+		if (new < 64)
+			new *= 2;
 		 else
-		 	cur = 0; /* load full packet before starting */
-		np->csr6 &= ~(0x7F << 14);
-		np->csr6 |= cur<<14;
+		 	new = 0; /* load full packet before starting */
+		new = (np->csr6 & ~(0x7F << 14)) | (new<<14);
 #endif
-		printk(KERN_DEBUG "%s: Tx underflow, increasing threshold to %8.8x.\n",
-			   dev->name, np->csr6);
-		writel(np->csr6, ioaddr + NetworkConfig);
+		printk(KERN_DEBUG "%s: Tx underflow, new csr6 %8.8x.\n",
+			   dev->name, new);
+		update_csr6(dev, new);
+		spin_unlock(&np->lock);
 	}
 	if (intr_status & IntrRxDied) {		/* Missed a Rx frame. */
 		np->stats.rx_errors++;
@@ -1307,26 +1392,33 @@
 	}
 	writel(mc_filter[0], ioaddr + MulticastFilter0);
 	writel(mc_filter[1], ioaddr + MulticastFilter1);
-	np->csr6 &= ~0x00F8;
-	np->csr6 |= rx_mode;
-	writel(np->csr6, ioaddr + NetworkConfig);
+	spin_lock_irq(&np->lock);
+	update_csr6(dev, (np->csr6 & ~0x00F8) | rx_mode);
+	spin_unlock_irq(&np->lock);
 }
 
 static int mii_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
+	struct netdev_private *np = dev->priv;
 	u16 *data = (u16 *)&rq->ifr_data;
 
 	switch(cmd) {
 	case SIOCDEVPRIVATE:		/* Get the address of the PHY in use. */
+		spin_lock_irq(&np->lock);
 		data[0] = ((struct netdev_private *)dev->priv)->phys[0] & 0x1f;
+		spin_unlock_irq(&np->lock);
 		/* Fall Through */
 	case SIOCDEVPRIVATE+1:		/* Read the specified MII register. */
+		spin_lock_irq(&np->lock);
 		data[3] = mdio_read(dev, data[0] & 0x1f, data[1] & 0x1f);
+		spin_unlock_irq(&np->lock);
 		return 0;
 	case SIOCDEVPRIVATE+2:		/* Write the specified MII register */
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
+		spin_lock_irq(&np->lock);
 		mdio_write(dev, data[0] & 0x1f, data[1] & 0x1f, data[2]);
+		spin_unlock_irq(&np->lock);
 		return 0;
 	default:
 		return -EOPNOTSUPP;
@@ -1353,7 +1445,9 @@
 	writel(0x0000, ioaddr + IntrEnable);
 
 	/* Stop the chip's Tx and Rx processes. */
-	writel(np->csr6 &= ~0x20FA, ioaddr + NetworkConfig);
+	spin_lock_irq(&np->lock);
+	update_csr6(dev, np->csr6 & ~0x20FA);
+	spin_unlock_irq(&np->lock);
 
 	if (readl(ioaddr + NetworkConfig) != 0xffffffff)
 		np->stats.rx_missed_errors += readl(ioaddr + RxMissed) & 0xffff;
@@ -1381,6 +1475,7 @@
 	del_timer_sync(&np->timer);
 
 	free_rxtx_rings(np);
+	free_ringdesc(np);
 
 	return 0;
 }

--------------B0803BF0251440E60BC0E544--

