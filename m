Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269908AbSISEUq>; Thu, 19 Sep 2002 00:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269911AbSISEUq>; Thu, 19 Sep 2002 00:20:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40456 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S269908AbSISEUe>;
	Thu, 19 Sep 2002 00:20:34 -0400
Message-ID: <3D89519C.1020809@mandrakesoft.com>
Date: Thu, 19 Sep 2002 00:25:00 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@oss.sgi.com
CC: Jason Lunz <lunz@falooley.org>, Richard Gooch <rgooch@ras.ucalgary.ca>,
       becker@scyld.com, "Patrick R. McManus" <mcmanus@ducksong.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.20-pre sundance.c update
References: <20020828185612.GA14342@reflexsecurity.com> <20020828231333.GA15183@reflexsecurity.com> <200209190353.g8J3r5q28456@vindaloo.ras.ucalgary.ca> <20020919041403.GA10527@orr.falooley.org>
Content-Type: multipart/mixed;
 boundary="------------010306010007070509070106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010306010007070509070106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Attached is the patch I have against 2.4.20-pre-latest, to start fixing 
from as a baseline.

It still has several flaws that were pointed out, but this is the base 
from which I would like testing and patching to proceed.  (also 
hopefully the flaws are minor in terms of general operation)

	Jeff



--------------010306010007070509070106
Content-Type: text/plain;
 name="sundance-2.4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sundance-2.4.patch"

diff -Nru a/drivers/net/sundance.c b/drivers/net/sundance.c
--- a/drivers/net/sundance.c	Thu Sep 19 00:22:26 2002
+++ b/drivers/net/sundance.c	Thu Sep 19 00:22:26 2002
@@ -21,22 +21,30 @@
 	Version 1.01a (jgarzik):
 	- Replace some MII-related magic numbers with constants
 
-	Version 1.01b (D-Link):
+	Version 1.02 (D-Link):
 	- Add new board to PCI ID list
+	- Fix multicast bug
 	
+	Version 1.03 (D-Link):
+	- New Rx scheme, reduce Rx congestion
+	- Option to disable flow control
+	
+	Version 1.04 (D-Link):
+	- Tx timeout recovery
+	- More support for ethtool.
 
 */
 
 #define DRV_NAME	"sundance"
-#define DRV_VERSION	"1.01b"
-#define DRV_RELDATE	"17-Jan-2002"
+#define DRV_VERSION	"1.04"
+#define DRV_RELDATE	"19-Aug-2002"
 
 
 /* The user-configurable values.
    These may be modified when a driver module is loaded.*/
 static int debug = 1;			/* 1 normal messages, 0 quiet .. 7 verbose. */
 /* Maximum events (Rx packets, etc.) to handle at each interrupt. */
-static int max_interrupt_work = 30;
+static int max_interrupt_work = 0;
 static int mtu;
 /* Maximum number of multicast addresses to filter (vs. rx-all-multicast).
    Typical is a 64 element hash table based on the Ethernet CRC.  */
@@ -47,6 +55,8 @@
    This chip can receive into offset buffers, so the Alpha does not
    need a copy-align. */
 static int rx_copybreak;
+static int tx_coalesce=1;
+static int flowctrl=1;
 
 /* media[] specifies the media type the NIC operates at.
 		 autosense	Autosensing active media.
@@ -70,9 +80,10 @@
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
 
@@ -107,13 +118,17 @@
 #include <linux/init.h>
 #include <linux/ethtool.h>
 #include <linux/mii.h>
-#include <linux/crc32.h>
 #include <asm/uaccess.h>
 #include <asm/processor.h>		/* Processor type for cache alignment. */
 #include <asm/bitops.h>
 #include <asm/io.h>
 #include <linux/delay.h>
 #include <linux/spinlock.h>
+#ifndef _LOCAL_CRC32
+#include <linux/crc32.h>
+#else
+#include "crc32.h"
+#endif
 
 /* These identify the driver base version and may not be removed. */
 static char version[] __devinitdata =
@@ -129,10 +144,12 @@
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
 
@@ -207,7 +224,6 @@
 
 */
 
-
 
 enum pci_id_flags_bits {
         /* Set PCI command register bits before calling probe1(). */
@@ -290,20 +306,24 @@
 enum alta_offsets {
 	DMACtrl = 0x00,
 	TxListPtr = 0x04,
-	TxDMACtrl = 0x08,
-	TxDescPoll = 0x0a,
+	TxDMABurstThresh = 0x08,
+	TxDMAUrgentThresh = 0x09,
+	TxDMAPollPeriod = 0x0a,
 	RxDMAStatus = 0x0c,
 	RxListPtr = 0x10,
-	RxDMACtrl = 0x14,
-	RxDescPoll = 0x16,
+	RxDMABurstThresh = 0x14,
+	RxDMAUrgentThresh = 0x15,
+	RxDMAPollPeriod = 0x16,
 	LEDCtrl = 0x1a,
 	ASICCtrl = 0x30,
 	EEData = 0x34,
 	EECtrl = 0x36,
-	TxThreshold = 0x3c,
+	TxStartThresh = 0x3c,
+	RxEarlyThresh = 0x3e,
 	FlashAddr = 0x40,
 	FlashData = 0x44,
 	TxStatus = 0x46,
+	TxFrameId = 0x47,
 	DownCounter = 0x18,
 	IntrClear = 0x4a,
 	IntrEnable = 0x4c,
@@ -337,6 +357,16 @@
 	/* Aliased and bogus values! */
 	RxStatus = 0x0c,
 };
+enum ASICCtrl_HiWord_bit {
+	GlobalReset = 0x0001,
+	RxReset = 0x0002,
+	TxReset = 0x0004, 
+	DMAReset = 0x0008,
+	FIFOReset = 0x0010,
+	NetworkReset = 0x0020,
+	HostReset = 0x0040,
+	ResetBusy = 0x0400,
+};
 
 /* Bits in the interrupt status/mask registers. */
 enum intr_status_bits {
@@ -399,19 +429,20 @@
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
@@ -424,6 +455,9 @@
 
 /* The station address location in the EEPROM. */
 #define EEPROM_SA_OFFSET	0x10
+#define DEFAULT_INTR (IntrRxDMADone | IntrPCIErr | \
+			IntrDrvRqst | IntrTxDone | StatsMax | \
+			LinkChange)
 
 static int  eeprom_read(long ioaddr, int location);
 static int  mdio_read(struct net_device *dev, int phy_id, int location);
@@ -434,9 +468,11 @@
 static void tx_timeout(struct net_device *dev);
 static void init_ring(struct net_device *dev);
 static int  start_tx(struct sk_buff *skb, struct net_device *dev);
+static int reset_tx (struct net_device *dev, int irq);
 static void intr_handler(int irq, void *dev_instance, struct pt_regs *regs);
+static void rx_poll(unsigned long data);
+static void refill_rx (struct net_device *dev);
 static void netdev_error(struct net_device *dev, int intr_status);
-static int  netdev_rx(struct net_device *dev);
 static void netdev_error(struct net_device *dev, int intr_status);
 static void set_rx_mode(struct net_device *dev);
 static struct net_device_stats *get_stats(struct net_device *dev);
@@ -502,6 +538,7 @@
 	np->drv_flags = pci_id_tbl[chip_idx].drv_flags;
 	np->pci_dev = pdev;
 	spin_lock_init(&np->lock);
+	tasklet_init(&np->rx_tasklet, rx_poll, (unsigned long)dev);
 
 	ring_space = pci_alloc_consistent(pdev, TX_TOTAL_SIZE, &ring_dma);
 	if (!ring_space)
@@ -582,6 +619,12 @@
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
@@ -742,7 +785,6 @@
 	return;
 }
 
-
 static int netdev_open(struct net_device *dev)
 {
 	struct netdev_private *np = dev->priv;
@@ -779,14 +821,10 @@
 	writew(0, ioaddr + IntrEnable);
 	writew(0, ioaddr + DownCounter);
 	/* Set the chip to poll every N*320nsec. */
-	writeb(100, ioaddr + RxDescPoll);
-	writeb(127, ioaddr + TxDescPoll);
+	writeb(100, ioaddr + RxDMAPollPeriod);
+	writeb(127, ioaddr + TxDMAPollPeriod);
 	netif_start_queue(dev);
 
-	/* Enable interrupts by setting the interrupt mask. */
-	writew(IntrRxDone | IntrRxDMADone | IntrPCIErr | IntrDrvRqst | IntrTxDone
-		   | StatsMax | LinkChange, ioaddr + IntrEnable);
-
 	writew(StatsEnable | RxEnable | TxEnable, ioaddr + MACCtrl1);
 
 	if (debug > 2)
@@ -802,6 +840,9 @@
 	np->timer.data = (unsigned long)dev;
 	np->timer.function = &netdev_timer;				/* timer handler */
 	add_timer(&np->timer);
+	
+	/* Enable interrupts by setting the interrupt mask. */
+	writew(DEFAULT_INTR, ioaddr + IntrEnable);
 
 	return 0;
 }
@@ -855,9 +896,12 @@
 {
 	struct netdev_private *np = dev->priv;
 	long ioaddr = dev->base_addr;
+	long flag;
 
-	printk(KERN_WARNING "%s: Transmit timed out, status %2.2x,"
-		   " resetting...\n", dev->name, readb(ioaddr + TxStatus));
+	printk(KERN_WARNING "%s: Transmit timed out, TxStatus %2.2x "
+		   "TxFrameId %2.2x,"
+		   " resetting...\n", dev->name, readb(ioaddr + TxStatus),
+		   readb(ioaddr + TxFrameId));
 
 	{
 		int i;
@@ -866,22 +910,24 @@
 			printk(" %8.8x", (unsigned int)np->rx_ring[i].status);
 		printk("\n"KERN_DEBUG"  Tx ring %p: ", np->tx_ring);
 		for (i = 0; i < TX_RING_SIZE; i++)
-			printk(" %4.4x", np->tx_ring[i].status);
+			printk(" %8.8x", np->tx_ring[i].status);
 		printk("\n");
 	}
+	spin_lock_irqsave(&np->lock, flag);
+	reset_tx(dev, 0);
+	spin_unlock_irqrestore(&np->lock, flag);
 
 	/* Perhaps we should reinitialize the hardware here. */
 	dev->if_port = 0;
 	/* Stop and restart the chip's Tx processes . */
 
 	/* Trigger an immediate transmit demand. */
-	writew(IntrRxDone | IntrRxDMADone | IntrPCIErr | IntrDrvRqst | IntrTxDone
-		   | StatsMax | LinkChange, ioaddr + IntrEnable);
+	writew(DEFAULT_INTR, ioaddr + IntrEnable);
 
 	dev->trans_start = jiffies;
 	np->stats.tx_errors++;
 
-	if (!np->tx_full)
+	if (!netif_queue_stopped(dev))
 		netif_wake_queue(dev);
 }
 
@@ -892,7 +938,6 @@
 	struct netdev_private *np = dev->priv;
 	int i;
 
-	np->tx_full = 0;
 	np->cur_rx = np->cur_tx = 0;
 	np->dirty_rx = np->dirty_tx = 0;
 
@@ -929,15 +974,16 @@
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
@@ -945,11 +991,17 @@
 
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
@@ -957,24 +1009,63 @@
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
+	return 0;
+}
+static int
+reset_tx (struct net_device *dev, int irq)
+{
+	struct netdev_private *np = (struct netdev_private*) dev->priv;
+	long ioaddr = dev->base_addr;
+	int i;
+	int frame_id;
+	
+	frame_id = readb(ioaddr + TxFrameId);
+	writew (TxReset | DMAReset | FIFOReset | NetworkReset,
+			ioaddr + ASICCtrl + 2);
+	for (i=50; i > 0; i--) {
+		if ((readw(ioaddr + ASICCtrl + 2) & ResetBusy) == 0)
+			break;
+		mdelay(1);
+	}
+	for (; np->cur_tx - np->dirty_tx > 0; np->dirty_tx++) {
+		int entry = np->dirty_tx % TX_RING_SIZE;
+		struct sk_buff *skb;
+		if (!(np->tx_ring[entry].status & 0x00010000))
+			break;
+		skb = np->tx_skbuff[entry];
+		/* Free the original skb. */
+		pci_unmap_single(np->pci_dev, 
+			np->tx_ring[entry].frag[0].addr, 
+			skb->len, PCI_DMA_TODEVICE);
+		if (irq)
+			dev_kfree_skb_irq (np->tx_skbuff[entry]);
+		else
+			dev_kfree_skb (np->tx_skbuff[entry]);
+
+		np->tx_skbuff[entry] = 0;
+	}
+	writel (np->tx_ring_dma + frame_id * sizeof(*np->tx_ring),
+			dev->base_addr + TxListPtr);
 	return 0;
 }
 
@@ -989,83 +1080,88 @@
 
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
+						np->stats.tx_fifo_errors++;
+						spin_lock(&np->lock);
+						reset_tx(dev, 1);
+						spin_unlock(&np->lock);
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
 		}
+		spin_lock(&np->lock);
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
+		spin_unlock(&np->lock);
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
@@ -1073,49 +1169,41 @@
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
 		
@@ -1136,7 +1224,6 @@
 			}
 		} else {
 			struct sk_buff *skb;
-
 #ifndef final_version
 			if (debug > 4)
 				printk(KERN_DEBUG "  netdev_rx() normal Rx pkt length %d"
@@ -1164,11 +1251,36 @@
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
@@ -1186,56 +1298,51 @@
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
 			mii_lpa= mdio_read (dev, np->phys[0], MII_LPA);
 			mii_advertise &= mii_lpa;
 			printk (KERN_INFO "%s: Link changed: ", dev->name);
-			if (mii_advertise & ADVERTISE_100FULL)
+			if (mii_advertise & ADVERTISE_100FULL) {
+				np->speed = 100;
 				printk ("100Mbps, full duplex\n");
-			else if (mii_advertise & ADVERTISE_100HALF)
+			} else if (mii_advertise & ADVERTISE_100HALF) {
+				np->speed = 100;
 				printk ("100Mbps, half duplex\n");
-			else if (mii_advertise & ADVERTISE_10FULL)
+			} else if (mii_advertise & ADVERTISE_10FULL) {
+				np->speed = 10;
 				printk ("10Mbps, full duplex\n");
-			else if (mii_advertise & ADVERTISE_10HALF)
+			} else if (mii_advertise & ADVERTISE_10HALF) {
+				np->speed = 10;
 				printk ("10Mbps, half duplex\n");
-			else
+			} else
 				printk ("\n");
 
 		} else {
 			mii_ctl = mdio_read (dev, np->phys[0], MII_BMCR);
 			speed = (mii_ctl & BMCR_SPEED100) ? 100 : 10;
+			np->speed = speed;
 			printk (KERN_INFO "%s: Link changed: %dMbps ,",
 				dev->name, speed);
 			printk ("%s duplex.\n", (mii_ctl & BMCR_FULLDPLX) ?
 				"full" : "half");
 		}
 		check_duplex (dev);
+		if (np->flowctrl == 0)
+			writew(readw(ioaddr + MACCtrl0) & ~EnbFlowCtrl,
+				ioaddr + MACCtrl0);
 	}
 	if (intr_status & StatsMax) {
 		get_stats(dev);
@@ -1294,11 +1401,16 @@
 		rx_mode = AcceptBroadcast | AcceptMulticast | AcceptMyPhys;
 	} else if (dev->mc_count) {
 		struct dev_mc_list *mclist;
-		memset(mc_filter, 0, sizeof(mc_filter));
+		int bit;
+		int index;
+		int crc;
+		memset (mc_filter, 0, sizeof (mc_filter));
 		for (i = 0, mclist = dev->mc_list; mclist && i < dev->mc_count;
-			 i++, mclist = mclist->next) {
-			set_bit(ether_crc_le(ETH_ALEN, mclist->dmi_addr) & 0x3f,
-					mc_filter);
+		     i++, mclist = mclist->next) {
+			crc = ether_crc_le (ETH_ALEN, mclist->dmi_addr);
+			for (index=0, bit=0; bit < 6; bit++, crc <<= 1)
+				if (crc & 0x80000000) index |= 1 << bit;
+			mc_filter[index/16] |= (1 << (index % 16));
 		}
 		rx_mode = AcceptBroadcast | AcceptMultiHash | AcceptMyPhys;
 	} else {
@@ -1314,24 +1426,136 @@
 {
 	struct netdev_private *np = dev->priv;
 	u32 ethcmd;
-		
+	long ioaddr = dev->base_addr;
+	
 	if (copy_from_user(&ethcmd, useraddr, sizeof(ethcmd)))
 		return -EFAULT;
 
         switch (ethcmd) {
-        case ETHTOOL_GDRVINFO: {
-		struct ethtool_drvinfo info = {ETHTOOL_GDRVINFO};
-		strcpy(info.driver, DRV_NAME);
-		strcpy(info.version, DRV_VERSION);
-		strcpy(info.bus_info, np->pci_dev->slot_name);
-		if (copy_to_user(useraddr, &info, sizeof(info)))
+        	case ETHTOOL_GDRVINFO: {
+			struct ethtool_drvinfo info = {ETHTOOL_GDRVINFO};
+			strcpy(info.driver, DRV_NAME);
+			strcpy(info.version, DRV_VERSION);
+			strcpy(info.bus_info, np->pci_dev->slot_name);
+			memset(&info.fw_version, 0, sizeof(info.fw_version));
+			if (copy_to_user(useraddr, &info, sizeof(info)))
+				return -EFAULT;
+			return 0;
+		}
+		case ETHTOOL_GSET: {
+			struct ethtool_cmd cmd = { ETHTOOL_GSET };
+			if (readl (ioaddr + ASICCtrl) & 0x80) {
+				/* fiber device */
+				cmd.supported = SUPPORTED_Autoneg | 
+							SUPPORTED_FIBRE;
+				cmd.advertising= ADVERTISED_Autoneg |
+							ADVERTISED_FIBRE;
+				cmd.port = PORT_FIBRE;
+				cmd.transceiver = XCVR_INTERNAL;	
+			} else {
+				/* copper device */
+				cmd.supported = SUPPORTED_10baseT_Half | 
+					SUPPORTED_10baseT_Full |
+				       	SUPPORTED_100baseT_Half	|
+				       	SUPPORTED_100baseT_Full | 
+					SUPPORTED_Autoneg | 
+					SUPPORTED_MII;
+				cmd.advertising = ADVERTISED_10baseT_Half |
+						ADVERTISED_10baseT_Full |
+				       		ADVERTISED_100baseT_Half |
+						ADVERTISED_100baseT_Full | 
+						ADVERTISED_Autoneg |
+				       		ADVERTISED_MII;
+				cmd.port = PORT_MII;
+				cmd.transceiver = XCVR_INTERNAL;
+			}
+			if (readb(ioaddr + MIICtrl) & 0x80) {
+				cmd.speed = np->speed;
+				cmd.duplex = np->full_duplex ? 
+						    DUPLEX_FULL : DUPLEX_HALF;
+			} else {
+				cmd.speed = -1;
+				cmd.duplex = -1;
+			}
+			if ( np->an_enable)
+				cmd.autoneg = AUTONEG_ENABLE;
+			else
+				cmd.autoneg = AUTONEG_DISABLE;
+			
+			cmd.phy_address = np->phys[0];
+
+			if (copy_to_user(useraddr, &cmd,
+					sizeof(cmd)))
+				return -EFAULT;
+			return 0;				   
+		}
+		case ETHTOOL_SSET: {
+			struct ethtool_cmd cmd;
+			if (copy_from_user(&cmd, useraddr, sizeof(cmd)))
+				return -EFAULT;
+			netif_carrier_off(dev);
+			if (cmd.autoneg == AUTONEG_ENABLE) {
+				if (np->an_enable)
+					return 0;
+				else {
+					np->an_enable = 1;
+					/* Reset PHY */
+					mdio_write (dev, np->phys[0], MII_BMCR,
+						       		BMCR_RESET);
+					mdelay (300);
+					/* Start auto negotiation */
+					mdio_write (dev, np->phys[0], MII_BMCR,
+					      	BMCR_ANENABLE|BMCR_ANRESTART);
+					return 0;	
+				}	
+			} else {
+				/* Reset PHY */
+				mdio_write (dev, np->phys[0], MII_BMCR, 
+								BMCR_RESET);
+				mdelay (300);
+				np->an_enable = 0;
+				switch(cmd.speed + cmd.duplex){
+				
+					case SPEED_10 + DUPLEX_HALF:
+						np->speed = 10;
+						np->full_duplex = 0;
+						break;
+					case SPEED_10 + DUPLEX_FULL:
+						np->speed = 10;
+						np->full_duplex = 1;
+						break;
+					case SPEED_100 + DUPLEX_HALF:
+						np->speed = 100;
+						np->full_duplex = 0;
+						break;
+					case SPEED_100 + DUPLEX_FULL:
+						np->speed = 100;
+						np->full_duplex = 1;
+						break;
+				
+				default:
+					return -EINVAL;	
+				}
+		mdio_write (dev, np->phys[0], MII_BMCR,
+				((np->speed == 100) ? BMCR_SPEED100 : 0) | 
+				((np->full_duplex) ? BMCR_FULLDPLX : 0) );
+
+			}
+		return 0;		   
+		}
+#ifdef	ETHTOOL_GLINK
+		case ETHTOOL_GLINK:{
+		struct ethtool_value link = { ETHTOOL_GLINK };
+		link.data = readb(ioaddr + MIICtrl) & 0x80;
+		if (copy_to_user(useraddr, &link, sizeof(link)))
 			return -EFAULT;
 		return 0;
-	}
+		}			   
+#endif
+		default:
+		return -EOPNOTSUPP;
 
         }
-	
-	return -EOPNOTSUPP;
 }
 
 static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
@@ -1342,17 +1566,14 @@
 	case SIOCETHTOOL:
 		return netdev_ethtool_ioctl(dev, (void *) rq->ifr_data);
 	case SIOCGMIIPHY:		/* Get address of MII PHY in use. */
-	case SIOCDEVPRIVATE:		/* for binary compat, remove in 2.5 */
 		data->phy_id = ((struct netdev_private *)dev->priv)->phys[0] & 0x1f;
 		/* Fall Through */
 
 	case SIOCGMIIREG:		/* Read MII PHY register. */
-	case SIOCDEVPRIVATE+1:		/* for binary compat, remove in 2.5 */
 		data->val_out = mdio_read(dev, data->phy_id & 0x1f, data->reg_num & 0x1f);
 		return 0;
 
 	case SIOCSMIIREG:		/* Write MII PHY register. */
-	case SIOCDEVPRIVATE+2:		/* for binary compat, remove in 2.5 */
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
 		mdio_write(dev, data->phy_id & 0x1f, data->reg_num & 0x1f, data->val_in);
@@ -1480,3 +1701,5 @@
 
 module_init(sundance_init);
 module_exit(sundance_exit);
+
+

--------------010306010007070509070106--

