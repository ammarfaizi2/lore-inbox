Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316250AbSFUF2I>; Fri, 21 Jun 2002 01:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316258AbSFUF2H>; Fri, 21 Jun 2002 01:28:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50450 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316250AbSFUF16>;
	Fri, 21 Jun 2002 01:27:58 -0400
Message-ID: <3D12B956.6020808@mandrakesoft.com>
Date: Fri, 21 Jun 2002 01:27:50 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Hall <matt@ecsc.co.uk>
CC: Donald Becker <becker@scyld.com>, Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PROBLEM] sundance on d-link dfe-580tx
References: <Pine.LNX.4.33.0206112336340.2253-100000@presario> <1023980246.1090.25.camel@smelly.dark.lan>
Content-Type: multipart/mixed;
 boundary="------------060905050703030505010405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060905050703030505010405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Matthew,

This patch just arrived from D-Link.  It includes fixes specifically for 
DFX-580TX.  Does this fix your problem?

--------------060905050703030505010405
Content-Type: text/plain;
 name="patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.txt"

--- /tmp/sundance.c	Fri Jun 21 00:48:54 2002
+++ sundance.c	Fri Jun 21 17:57:27 2002
@@ -24,19 +24,23 @@
 	Version 1.02 (D-Link):
 	- Add new board to PCI ID list
 	- Fix multicast bug
+	
+	Version 1.03 (D-Link):
+	- New Rx scheme, reduce Rx congestion
+	- Option to disable flow control
 
 */
 
 #define DRV_NAME	"sundance"
-#define DRV_VERSION	"1.02"
-#define DRV_RELDATE	"17-Jan-2002"
+#define DRV_VERSION	"1.03"
+#define DRV_RELDATE	"21-Jun-2002"
 
 
 /* The user-configurable values.
    These may be modified when a driver module is loaded.*/
 static int debug = 1;			/* 1 normal messages, 0 quiet .. 7 verbose. */
 /* Maximum events (Rx packets, etc.) to handle at each interrupt. */
-static int max_interrupt_work = 30;
+static int max_interrupt_work = 0;
 static int mtu;
 /* Maximum number of multicast addresses to filter (vs. rx-all-multicast).
    Typical is a 64 element hash table based on the Ethernet CRC.  */
@@ -47,6 +51,8 @@
    This chip can receive into offset buffers, so the Alpha does not
    need a copy-align. */
 static int rx_copybreak;
+static int tx_coalesce=1;
+static int flowctrl=1;
 
 /* media[] specifies the media type the NIC operates at.
 		 autosense	Autosensing active media.
@@ -70,9 +76,10 @@
    bonding and packet priority, and more than 128 requires modifying the
    Tx error recovery.
    Large receive rings merely waste memory. */
-#define TX_RING_SIZE	16
-#define TX_QUEUE_LEN	10		/* Limit ring entries actually used.  */
-#define RX_RING_SIZE	32
+#define TX_RING_SIZE	64
+#define TX_QUEUE_LEN	(TX_RING_SIZE - 1) /* Limit ring entries actually used.  */
+#define RX_RING_SIZE	64
+#define RX_BUDGET	32
 #define TX_TOTAL_SIZE	TX_RING_SIZE*sizeof(struct netdev_desc)
 #define RX_TOTAL_SIZE	RX_RING_SIZE*sizeof(struct netdev_desc)
 
@@ -129,10 +136,12 @@
 MODULE_PARM(debug, "i");
 MODULE_PARM(rx_copybreak, "i");
 MODULE_PARM(media, "1-" __MODULE_STRING(MAX_UNITS) "s");
+MODULE_PARM(flowctrl, "i");
 MODULE_PARM_DESC(max_interrupt_work, "Sundance Alta maximum events handled per interrupt");
 MODULE_PARM_DESC(mtu, "Sundance Alta MTU (all boards)");
 MODULE_PARM_DESC(debug, "Sundance Alta debug level (0-5)");
 MODULE_PARM_DESC(rx_copybreak, "Sundance Alta copy breakpoint for copy-only-tiny-frames");
+MODULE_PARM_DESC(flowctrl, "Sundance Alta flow control [0|1]");
 /*
 				Theory of Operation
 
@@ -207,7 +216,6 @@
 
 */
 
-
 
 enum pci_id_flags_bits {
         /* Set PCI command register bits before calling probe1(). */
@@ -399,19 +407,20 @@
 	struct timer_list timer;	/* Media monitoring timer. */
 	/* Frequently used values: keep some adjacent for cache effect. */
 	spinlock_t lock;
+	spinlock_t rx_lock;					/* Group with Tx control cache line. */
 	int chip_id, drv_flags;
 	unsigned int cur_rx, dirty_rx;		/* Producer/consumer ring indices */
 	unsigned int rx_buf_sz;				/* Based on MTU+slack. */
-	spinlock_t txlock;					/* Group with Tx control cache line. */
 	struct netdev_desc *last_tx;		/* Last Tx descriptor used. */
 	unsigned int cur_tx, dirty_tx;
-	unsigned int tx_full:1;				/* The Tx queue is full. */
 	/* These values are keep track of the transceiver/media in use. */
 	unsigned int full_duplex:1;			/* Full-duplex operation requested. */
-	unsigned int medialock:1;			/* Do not sense media. */
+	unsigned int flowctrl:1;
 	unsigned int default_port:4;		/* Last dev->if_port value. */
 	unsigned int an_enable:1;
 	unsigned int speed;
+	struct tasklet_struct rx_tasklet;
+	int budget;
 	/* Multicast and receive mode. */
 	spinlock_t mcastlock;				/* SMP lock multicast updates. */
 	u16 mcast_filter[4];
@@ -424,6 +433,9 @@
 
 /* The station address location in the EEPROM. */
 #define EEPROM_SA_OFFSET	0x10
+#define DEFAULT_INTR (IntrRxDMADone | IntrPCIErr | \
+			IntrDrvRqst | IntrTxDone | StatsMax | \
+			LinkChange)
 
 static int  eeprom_read(long ioaddr, int location);
 static int  mdio_read(struct net_device *dev, int phy_id, int location);
@@ -435,8 +447,9 @@
 static void init_ring(struct net_device *dev);
 static int  start_tx(struct sk_buff *skb, struct net_device *dev);
 static void intr_handler(int irq, void *dev_instance, struct pt_regs *regs);
+static void rx_poll(unsigned long data);
+static void refill_rx (struct net_device *dev);
 static void netdev_error(struct net_device *dev, int intr_status);
-static int  netdev_rx(struct net_device *dev);
 static void netdev_error(struct net_device *dev, int intr_status);
 static void set_rx_mode(struct net_device *dev);
 static struct net_device_stats *get_stats(struct net_device *dev);
@@ -502,6 +515,7 @@
 	np->drv_flags = pci_id_tbl[chip_idx].drv_flags;
 	np->pci_dev = pdev;
 	spin_lock_init(&np->lock);
+	tasklet_init(&np->rx_tasklet, rx_poll, (unsigned long)dev);
 
 	ring_space = pci_alloc_consistent(pdev, TX_TOTAL_SIZE, &ring_dma);
 	if (!ring_space)
@@ -582,6 +596,12 @@
 				np->an_enable = 1;
 			}
 		}
+		if (tx_coalesce < 1) 
+			tx_coalesce = 1;
+		else if (tx_coalesce > TX_QUEUE_LEN - 1)
+			tx_coalesce = TX_QUEUE_LEN - 1;
+		if (flowctrl == 0)
+			np->flowctrl = 0;
 	}
 
 	/* Fibre PHY? */
@@ -742,7 +762,6 @@
 	return;
 }
 
-
 static int netdev_open(struct net_device *dev)
 {
 	struct netdev_private *np = dev->priv;
@@ -784,8 +803,7 @@
 	netif_start_queue(dev);
 
 	/* Enable interrupts by setting the interrupt mask. */
-	writew(IntrRxDone | IntrRxDMADone | IntrPCIErr | IntrDrvRqst | IntrTxDone
-		   | StatsMax | LinkChange, ioaddr + IntrEnable);
+	writew(DEFAULT_INTR, ioaddr + IntrEnable);
 
 	writew(StatsEnable | RxEnable | TxEnable, ioaddr + MACCtrl1);
 
@@ -881,7 +899,7 @@
 	dev->trans_start = jiffies;
 	np->stats.tx_errors++;
 
-	if (!np->tx_full)
+	if (!netif_queue_stopped(dev))
 		netif_wake_queue(dev);
 }
 
@@ -892,7 +910,6 @@
 	struct netdev_private *np = dev->priv;
 	int i;
 
-	np->tx_full = 0;
 	np->cur_rx = np->cur_tx = 0;
 	np->dirty_rx = np->dirty_tx = 0;
 
@@ -929,15 +946,16 @@
 	return;
 }
 
-static int start_tx(struct sk_buff *skb, struct net_device *dev)
+static int
+start_tx (struct sk_buff *skb, struct net_device *dev)
 {
-	struct netdev_private *np = dev->priv;
+	struct netdev_private *np = (struct netdev_private *) dev->priv;
 	struct netdev_desc *txdesc;
 	unsigned entry;
+	long ioaddr = dev->base_addr;
 
 	/* Note: Ordering is important here, set the field with the
 	   "ownership" bit last, and only then increment cur_tx. */
-
 	/* Calculate the next Tx descriptor entry. */
 	entry = np->cur_tx % TX_RING_SIZE;
 	np->tx_skbuff[entry] = skb;
@@ -945,11 +963,17 @@
 
 	txdesc->next_desc = 0;
 	/* Note: disable the interrupt generation here before releasing. */
-	txdesc->status =
-		cpu_to_le32((entry<<2) | DescIntrOnDMADone | DescIntrOnTx | DisableAlign);
-	txdesc->frag[0].addr = cpu_to_le32(pci_map_single(np->pci_dev, 
-		skb->data, skb->len, PCI_DMA_TODEVICE));
-	txdesc->frag[0].length = cpu_to_le32(skb->len | LastFrag);
+	if (entry % tx_coalesce == 0) {
+		txdesc->status = cpu_to_le32 ((entry << 2) | 
+				 DescIntrOnTx | DisableAlign);
+	
+	} else {
+		txdesc->status = cpu_to_le32 ((entry << 2) | DisableAlign);
+	}
+	txdesc->frag[0].addr = cpu_to_le32 (pci_map_single (np->pci_dev, skb->data,
+							skb->len,
+							PCI_DMA_TODEVICE));
+	txdesc->frag[0].length = cpu_to_le32 (skb->len | LastFrag);
 	if (np->last_tx)
 		np->last_tx->next_desc = cpu_to_le32(np->tx_ring_dma +
 			entry*sizeof(struct netdev_desc));
@@ -957,24 +981,26 @@
 	np->cur_tx++;
 
 	/* On some architectures: explicitly flush cache lines here. */
-
-	if (np->cur_tx - np->dirty_tx < TX_QUEUE_LEN - 1) {
+	if (np->cur_tx - np->dirty_tx < TX_QUEUE_LEN - 1 
+			&& !netif_queue_stopped(dev)) {
 		/* do nothing */
 	} else {
-		np->tx_full = 1;
-		netif_stop_queue(dev);
+		netif_stop_queue (dev);
 	}
 	/* Side effect: The read wakes the potentially-idle transmit channel. */
-	if (readl(dev->base_addr + TxListPtr) == 0)
-		writel(np->tx_ring_dma + entry*sizeof(*np->tx_ring),
+	if (readl (dev->base_addr + TxListPtr) == 0)
+		writel (np->tx_ring_dma + entry*sizeof(*np->tx_ring),
 			dev->base_addr + TxListPtr);
 
 	dev->trans_start = jiffies;
 
 	if (debug > 4) {
-		printk(KERN_DEBUG "%s: Transmit frame #%d queued in slot %d.\n",
-			   dev->name, np->cur_tx, entry);
+		printk (KERN_DEBUG
+			"%s: Transmit frame #%d queued in slot %d.\n",
+			dev->name, np->cur_tx, entry);
 	}
+	if (tx_coalesce > 1)
+		writel (1000, ioaddr + DownCounter);
 	return 0;
 }
 
@@ -989,56 +1015,61 @@
 
 	ioaddr = dev->base_addr;
 	np = dev->priv;
-	spin_lock(&np->lock);
 
 	do {
 		int intr_status = readw(ioaddr + IntrStatus);
-		writew(intr_status & (IntrRxDone | IntrRxDMADone | IntrPCIErr |
-			IntrDrvRqst | IntrTxDone | IntrTxDMADone | StatsMax | 
-			LinkChange), ioaddr + IntrStatus);
+		writew(intr_status, ioaddr + IntrStatus);
 
 		if (debug > 4)
 			printk(KERN_DEBUG "%s: Interrupt, status %4.4x.\n",
 				   dev->name, intr_status);
 
-		if (intr_status == 0)
+		if (!(intr_status & DEFAULT_INTR))
 			break;
 
-		if (intr_status & (IntrRxDone|IntrRxDMADone))
-			netdev_rx(dev);
+		if (intr_status & (IntrRxDMADone)) {
+			writew(DEFAULT_INTR & ~(IntrRxDone|IntrRxDMADone), 
+					ioaddr + IntrEnable);
+			if (np->budget < 0)
+				np->budget = RX_BUDGET;
+			tasklet_schedule(&np->rx_tasklet);
+		}
 
-		if (intr_status & IntrTxDone) {
+		if (intr_status & (IntrTxDone | IntrDrvRqst)) {
 			int boguscnt = 32;
-			int tx_status = readw(ioaddr + TxStatus);
+			int tx_status = readw (ioaddr + TxStatus);
 			while (tx_status & 0x80) {
 				if (debug > 4)
-					printk("%s: Transmit status is %2.2x.\n",
-						   dev->name, tx_status);
+					printk
+					    ("%s: Transmit status is %2.2x.\n",
+					     dev->name, tx_status);
 				if (tx_status & 0x1e) {
 					np->stats.tx_errors++;
-					if (tx_status & 0x10)  np->stats.tx_fifo_errors++;
+					if (tx_status & 0x10)
+						np->stats.tx_fifo_errors++;
 #ifdef ETHER_STATS
-					if (tx_status & 0x08)  np->stats.collisions16++;
+					if (tx_status & 0x08)
+						np->stats.collisions16++;
 #else
-					if (tx_status & 0x08)  np->stats.collisions++;
+					if (tx_status & 0x08)
+						np->stats.collisions++;
 #endif
-					if (tx_status & 0x04)  np->stats.tx_fifo_errors++;
-					if (tx_status & 0x02)  np->stats.tx_window_errors++;
+					if (tx_status & 0x04)
+						np->stats.tx_fifo_errors++;
+					if (tx_status & 0x02)
+						np->stats.tx_window_errors++;
 					/* This reset has not been verified!. */
-					if (tx_status & 0x10) {			/* Reset the Tx. */
-						writew(0x001c, ioaddr + ASICCtrl + 2);
-#if 0					/* Do we need to reset the Tx pointer here? */
-						writel(np->tx_ring_dma
-							+ np->dirty_tx*sizeof(*np->tx_ring),
-							dev->base_addr + TxListPtr);
-#endif
+					if (tx_status & 0x10) {	/* Reset the Tx. */
+						writew (0x001c,
+							ioaddr + ASICCtrl + 2);
 					}
-					if (tx_status & 0x1e) 		/* Restart the Tx. */
-						writew(TxEnable, ioaddr + MACCtrl1);
+					if (tx_status & 0x1e)	/* Restart the Tx. */
+						writew (TxEnable,
+							ioaddr + MACCtrl1);
 				}
 				/* Yup, this is a documentation bug.  It cost me *hours*. */
-				writew(0, ioaddr + TxStatus);
-				tx_status = readb(ioaddr + TxStatus);
+				writew (0, ioaddr + TxStatus);
+				tx_status = readw (ioaddr + TxStatus);
 				if (--boguscnt < 0)
 					break;
 			}
@@ -1046,26 +1077,24 @@
 		for (; np->cur_tx - np->dirty_tx > 0; np->dirty_tx++) {
 			int entry = np->dirty_tx % TX_RING_SIZE;
 			struct sk_buff *skb;
-
-			if ( ! (np->tx_ring[entry].status & 0x00010000))
+			if (!(np->tx_ring[entry].status & 0x00010000))
 				break;
 			skb = np->tx_skbuff[entry];
 			/* Free the original skb. */
 			pci_unmap_single(np->pci_dev, 
 				np->tx_ring[entry].frag[0].addr, 
 				skb->len, PCI_DMA_TODEVICE);
-			dev_kfree_skb_irq(skb);
+			dev_kfree_skb_irq (np->tx_skbuff[entry]);
 			np->tx_skbuff[entry] = 0;
 		}
-		if (np->tx_full
-			&& np->cur_tx - np->dirty_tx < TX_QUEUE_LEN - 4) {
+		if (netif_queue_stopped(dev) && 
+			np->cur_tx - np->dirty_tx < TX_QUEUE_LEN - 4) {
 			/* The ring is no longer full, clear tbusy. */
-			np->tx_full = 0;
-			netif_wake_queue(dev);
+			netif_wake_queue (dev);
 		}
 
 		/* Abnormal error summary/uncommon events handlers. */
-		if (intr_status & (IntrDrvRqst | IntrPCIErr | LinkChange | StatsMax))
+		if (intr_status & (IntrPCIErr | LinkChange | StatsMax))
 			netdev_error(dev, intr_status);
 		if (--boguscnt < 0) {
 			get_stats(dev);
@@ -1073,49 +1102,41 @@
 				printk(KERN_WARNING "%s: Too much work at interrupt, "
 				   "status=0x%4.4x / 0x%4.4x.\n",
 				   dev->name, intr_status, readw(ioaddr + IntrClear));
-			/* Re-enable us in 3.2msec. */
-			writew(0, ioaddr + IntrEnable);
-			writew(1000, ioaddr + DownCounter);
-			writew(IntrDrvRqst, ioaddr + IntrEnable);
 			break;
 		}
 	} while (1);
-
 	if (debug > 3)
 		printk(KERN_DEBUG "%s: exiting interrupt, status=%#4.4x.\n",
 			   dev->name, readw(ioaddr + IntrStatus));
+	if (np->cur_tx - np->dirty_tx > 0 && tx_coalesce > 1)
+		writel(100, ioaddr + DownCounter);
 
-	spin_unlock(&np->lock);
 }
 
-/* This routine is logically part of the interrupt handler, but separated
-   for clarity and better register allocation. */
-static int netdev_rx(struct net_device *dev)
+static void rx_poll(unsigned long data)
 {
+	struct net_device *dev = (struct net_device *)data;
 	struct netdev_private *np = dev->priv;
 	int entry = np->cur_rx % RX_RING_SIZE;
-	int boguscnt = np->dirty_rx + RX_RING_SIZE - np->cur_rx;
-
-	if (debug > 4) {
-		printk(KERN_DEBUG " In netdev_rx(), entry %d status %4.4x.\n",
-			   entry, np->rx_ring[entry].status);
-	}
+	int boguscnt = np->budget;
+	long ioaddr = dev->base_addr;
+	int received = 0;
 
 	/* If EOP is set on the next entry, it's a new packet. Send it up. */
 	while (1) {
 		struct netdev_desc *desc = &(np->rx_ring[entry]);
-		u32 frame_status;
+		u32 frame_status = le32_to_cpu(desc->status);
 		int pkt_len;
 
+		if (--boguscnt < 0) {
+			goto not_done;
+		}
 		if (!(desc->status & DescOwn))
 			break;
-		frame_status = le32_to_cpu(desc->status);
 		pkt_len = frame_status & 0x1fff;	/* Chip omits the CRC. */
 		if (debug > 4)
 			printk(KERN_DEBUG "  netdev_rx() status was %8.8x.\n",
 				   frame_status);
-		if (--boguscnt < 0)
-			break;
 		pci_dma_sync_single(np->pci_dev, desc->frag[0].addr,
 			np->rx_buf_sz, PCI_DMA_FROMDEVICE);
 		
@@ -1136,7 +1157,6 @@
 			}
 		} else {
 			struct sk_buff *skb;
-
 #ifndef final_version
 			if (debug > 4)
 				printk(KERN_DEBUG "  netdev_rx() normal Rx pkt length %d"
@@ -1164,11 +1184,36 @@
 			netif_rx(skb);
 			dev->last_rx = jiffies;
 		}
-		entry = (++np->cur_rx) % RX_RING_SIZE;
+		entry = (entry + 1) % RX_RING_SIZE;
+		received++;
 	}
+	np->cur_rx = entry;
+	refill_rx (dev);
+	np->budget -= received;
+	writew(DEFAULT_INTR, ioaddr + IntrEnable);
+	return;
+
+not_done:	
+	np->cur_rx = entry;
+	refill_rx (dev);
+	if (!received)
+		received = 1;
+	np->budget -= received;
+	if (np->budget <= 0)
+		np->budget = RX_BUDGET;
+	tasklet_schedule(&np->rx_tasklet);
+	return;
+}
+
+static void refill_rx (struct net_device *dev)
+{
+	struct netdev_private *np = dev->priv;
+	int entry;
+	int cnt = 0;
 
 	/* Refill the Rx ring buffers. */
-	for (; np->cur_rx - np->dirty_rx > 0; np->dirty_rx++) {
+	for (;(np->cur_rx - np->dirty_rx + RX_RING_SIZE) % RX_RING_SIZE > 0;
+		np->dirty_rx = (np->dirty_rx + 1) % RX_RING_SIZE) {
 		struct sk_buff *skb;
 		entry = np->dirty_rx % RX_RING_SIZE;
 		if (np->rx_skbuff[entry] == NULL) {
@@ -1186,30 +1231,17 @@
 		np->rx_ring[entry].frag[0].length =
 			cpu_to_le32(np->rx_buf_sz | LastFrag);
 		np->rx_ring[entry].status = 0;
+		cnt++;
 	}
-
-	/* No need to restart Rx engine, it will poll. */
-	return 0;
+	return;
 }
-
 static void netdev_error(struct net_device *dev, int intr_status)
 {
 	long ioaddr = dev->base_addr;
 	struct netdev_private *np = dev->priv;
 	u16 mii_ctl, mii_advertise, mii_lpa;
 	int speed;
-
-	if (intr_status & IntrDrvRqst) {
-		/* Stop the down counter and turn interrupts back on. */
-		if (debug > 1)
-			printk("%s: Turning interrupts back on.\n", dev->name);
-		writew(0, ioaddr + IntrEnable);
-		writew(0, ioaddr + DownCounter);
-		writew(IntrRxDone | IntrRxDMADone | IntrPCIErr | IntrDrvRqst |
-			   IntrTxDone | StatsMax | LinkChange, ioaddr + IntrEnable);
-		/* Ack buggy InRequest */
-		writew (IntrDrvRqst, ioaddr + IntrStatus);
-	}
+	
 	if (intr_status & LinkChange) {
 		if (np->an_enable) {
 			mii_advertise = mdio_read (dev, np->phys[0], MII_ADVERTISE);
@@ -1236,6 +1268,9 @@
 				"full" : "half");
 		}
 		check_duplex (dev);
+		if (np->flowctrl == 0)
+			writew(readw(ioaddr + MACCtrl0) & ~EnbFlowCtrl,
+				ioaddr + MACCtrl0);
 	}
 	if (intr_status & StatsMax) {
 		get_stats(dev);
@@ -1482,3 +1517,5 @@
 
 module_init(sundance_init);
 module_exit(sundance_exit);
+
+

--------------060905050703030505010405--

