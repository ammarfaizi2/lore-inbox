Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262659AbRFBSoo>; Sat, 2 Jun 2001 14:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262660AbRFBSof>; Sat, 2 Jun 2001 14:44:35 -0400
Received: from [216.156.138.34] ([216.156.138.34]:26891 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S262659AbRFBSoW>;
	Sat, 2 Jun 2001 14:44:22 -0400
Message-ID: <3B1933D6.42E479E0@colorfullife.com>
Date: Sat, 02 Jun 2001 20:43:34 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-ac6 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com
Subject: [PATCH] natsemi update
Content-Type: multipart/mixed;
 boundary="------------E50F853014C20DA8159BB4F1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E50F853014C20DA8159BB4F1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

A few bugfixes for the natsemi driver:

* multicast hashing used the wrong polynomial
* converted to pci_dma mappings
* SMP locking updates
* added full reset into tx_timeout.

If you had problems with multicast support, please try this patch
[against 2.4.5-ac6, but it should also apply to 2.4.5]

--
	Manfred
--------------E50F853014C20DA8159BB4F1
Content-Type: text/plain; charset=us-ascii;
 name="patch-natsemi"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-natsemi"

--- 2.4/drivers/net/natsemi.c	Sat Jun  2 14:19:44 2001
+++ build-2.4/drivers/net/natsemi.c	Sat Jun  2 20:21:15 2001
@@ -51,10 +51,21 @@
 		* One-liner removal of a duplicate declaration of
 		netdev_error(). (uzi)
 
+	Version 1.0.7: (Manfred Spraul)
+		* pci dma
+		* SMP locking update
+		* full reset added into tx_timeout
+		* correct multicast hash generation
+			[copied from a natsemi driver version
+			 from Myrio Corporation, Greg Smith]
+
+	TODO:
+	* big endian support
+	* suspend/resume
 */
 
 #define DRV_NAME	"natsemi"
-#define DRV_VERSION	"1.07+LK1.0.6"
+#define DRV_VERSION	"1.07+LK1.0.7"
 #define DRV_RELDATE	"May 18, 2001"
 
 
@@ -111,6 +122,8 @@
 /* Time in jiffies before concluding the transmitter is hung. */
 #define TX_TIMEOUT  (2*HZ)
 
+#define NATSEMI_RESET_TIMEOUT	200
+
 #define PKT_BUF_SZ		1536			/* Size of each temporary Rx buffer.*/
 
 #if !defined(__OPTIMIZE__)
@@ -134,6 +147,7 @@
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/ethtool.h>
+#include <linux/delay.h>
 #include <asm/processor.h>		/* Processor type for cache alignment. */
 #include <asm/bitops.h>
 #include <asm/io.h>
@@ -145,10 +159,6 @@
 KERN_INFO "  http://www.scyld.com/network/natsemi.html\n"
 KERN_INFO "  (unofficial 2.4.x kernel port, version " DRV_VERSION ", " DRV_RELDATE "  Jeff Garzik, Tjeerd Mulder)\n";
 
-/* Condensed operations for readability. */
-#define virt_to_le32desc(addr)  cpu_to_le32(virt_to_bus(addr))
-#define le32desc_to_virt(addr)  bus_to_virt(le32_to_cpu(addr))
-
 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
 MODULE_DESCRIPTION("National Semiconductor DP8381x series PCI Ethernet driver");
 MODULE_PARM(max_interrupt_work, "i");
@@ -330,15 +340,17 @@
 	DescPktOK=0x08000000, RxTooLong=0x00400000,
 };
 
-#define PRIV_ALIGN	15 	/* Required alignment mask */
 struct netdev_private {
 	/* Descriptor rings first for alignment. */
-	struct netdev_desc rx_ring[RX_RING_SIZE];
-	struct netdev_desc tx_ring[TX_RING_SIZE];
+	dma_addr_t ring_dma;
+	struct netdev_desc* rx_ring;
+	struct netdev_desc* tx_ring;
 	/* The addresses of receive-in-place skbuffs. */
 	struct sk_buff* rx_skbuff[RX_RING_SIZE];
+	dma_addr_t rx_dma[RX_RING_SIZE];
 	/* The saved address of a sent-in-place packet/buffer, for later free(). */
 	struct sk_buff* tx_skbuff[TX_RING_SIZE];
+	dma_addr_t tx_dma[TX_RING_SIZE];
 	struct net_device_stats stats;
 	struct timer_list timer;	/* Media monitoring timer. */
 	/* Frequently used values: keep some adjacent for cache effect. */
@@ -348,10 +360,7 @@
 	unsigned int cur_tx, dirty_tx;
 	unsigned int rx_buf_sz;				/* Based on MTU+slack. */
 	/* These values are keep track of the transceiver/media in use. */
-	unsigned int full_duplex:1;			/* Full-duplex operation requested. */
-	unsigned int duplex_lock:1;
-	unsigned int medialock:1;			/* Do not sense media. */
-	unsigned int default_port:4;		/* Last dev->if_port value. */
+	unsigned int full_duplex;
 	/* Rx filter. */
 	u32 cur_rx_mode;
 	u32 rx_filter[16];
@@ -360,23 +369,29 @@
 	/* original contents of ClkRun register */
 	u32 SavedClkRun;
 	/* MII transceiver section. */
-	u16 advertising;					/* NWay media advertisement */
-	
+	u16 advertising;			/* NWay media advertisement */
 	unsigned int iosize;
 	spinlock_t lock;
 };
 
 static int  eeprom_read(long ioaddr, int location);
 static int  mdio_read(struct net_device *dev, int phy_id, int location);
+static void natsemi_reset(struct net_device *dev);
 static int  netdev_open(struct net_device *dev);
-static void check_duplex(struct net_device *dev);
+static void check_link(struct net_device *dev);
 static void netdev_timer(unsigned long data);
 static void tx_timeout(struct net_device *dev);
+static int alloc_ring(struct net_device *dev);
 static void init_ring(struct net_device *dev);
+static void drain_ring(struct net_device *dev);
+static void free_ring(struct net_device *dev);
+static void init_registers(struct net_device *dev);
 static int  start_tx(struct sk_buff *skb, struct net_device *dev);
 static void intr_handler(int irq, void *dev_instance, struct pt_regs *regs);
 static void netdev_error(struct net_device *dev, int intr_status);
-static int  netdev_rx(struct net_device *dev);
+static void netdev_rx(struct net_device *dev);
+static void netdev_tx_done(struct net_device *dev);
+static void __set_rx_mode(struct net_device *dev);
 static void set_rx_mode(struct net_device *dev);
 static struct net_device_stats *get_stats(struct net_device *dev);
 static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
@@ -417,7 +432,6 @@
 	}
 
 	find_cnt++;
-	option = find_cnt < MAX_UNITS ? options[find_cnt] : 0;
 	ioaddr = pci_resource_start(pdev, pcibar);
 	iosize = pci_resource_len(pdev, pcibar);
 	irq = pdev->irq;
@@ -455,9 +469,6 @@
 		prev_eedata = eedata;
 	}
 
-	/* Reset the chip to erase previous misconfiguration. */
-	writel(ChipReset, ioaddr + ChipCmd);
-
 	dev->base_addr = ioaddr;
 	dev->irq = irq;
 
@@ -468,6 +479,9 @@
 	np->iosize = iosize;
 	spin_lock_init(&np->lock);
 
+	/* Reset the chip to erase previous misconfiguration. */
+	natsemi_reset(dev);
+	option = find_cnt < MAX_UNITS ? options[find_cnt] : 0;
 	if (dev->mem_start)
 		option = dev->mem_start;
 
@@ -475,16 +489,13 @@
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
 
-	if (np->full_duplex)
-		np->duplex_lock = 1;
-
 	/* The chip-specific entries in the device structure. */
 	dev->open = &netdev_open;
 	dev->hard_start_xmit = &start_tx;
@@ -598,6 +609,27 @@
 		return 0xffff;
 }
 
+static void natsemi_reset(struct net_device *dev)
+{
+	int i;
+	writel(ChipReset, dev->base_addr + ChipCmd);
+	for (i=0;i<NATSEMI_RESET_TIMEOUT;i++)
+	{
+		if (!(readl(dev->base_addr + ChipCmd) & ChipReset))
+			break;
+		udelay(5);
+	}
+	if (i==NATSEMI_RESET_TIMEOUT) {
+		if (debug)
+			printk(KERN_INFO "%s: reset did not complet in %d usec.\n",
+			   dev->name, i*5);
+	} else {
+		if (debug > 2)
+			printk(KERN_DEBUG "%s: reset completed in %d usec.\n",
+			   dev->name, i*5);
+	}
+}
+
 
 static int netdev_open(struct net_device *dev)
 {
@@ -606,12 +638,81 @@
 	int i;
 
 	/* Reset the chip, just in case. */
-	writel(ChipReset, ioaddr + ChipCmd);
+	natsemi_reset(dev);
 
+	i = request_irq(dev->irq, &intr_handler, SA_SHIRQ, dev->name, dev);
+	if (i) return i;
+
+	if (debug > 1)
+		printk(KERN_DEBUG "%s: netdev_open() irq %d.\n",
+			   dev->name, dev->irq);
+	i = alloc_ring(dev);
+	if (i < 0) {
+		free_irq(dev->irq, dev);
+		return i;
+	}
+	init_ring(dev);
+	init_registers(dev);
+
+	netif_start_queue(dev);
+
+	if (debug > 2)
+		printk(KERN_DEBUG "%s: Done netdev_open(), status: %x.\n",
+			   dev->name, (int)readl(ioaddr + ChipCmd));
+
+	/* Set the timer to check for link beat. */
+	init_timer(&np->timer);
+	np->timer.expires = jiffies + 3*HZ;
+	np->timer.data = (unsigned long)dev;
+	np->timer.function = &netdev_timer;				/* timer handler */
+	add_timer(&np->timer);
+
+	return 0;
+}
+
+static void check_link(struct net_device *dev)
+{
+	struct netdev_private *np = dev->priv;
+	long ioaddr = dev->base_addr;
+	int duplex;
+
+	duplex = np->full_duplex || readl(ioaddr + ChipConfig) & 0x20000000 ? 1 : 0;
+
+	/* if duplex is set then bit 28 must be set, too */
+	if (duplex ^ !!(np->rx_config & 0x10000000)) {
+		if (debug)
+			printk(KERN_INFO "%s: Setting %s-duplex based on negotiated link"
+				   " capability.\n", dev->name,
+				   duplex ? "full" : "half");
+		if (duplex) {
+			np->rx_config |= 0x10000000;
+			np->tx_config |= 0xC0000000;
+		} else {
+			np->rx_config &= ~0x10000000;
+			np->tx_config &= ~0xC0000000;
+		}
+		writel(np->tx_config, ioaddr + TxConfig);
+		writel(np->rx_config, ioaddr + RxConfig);
+	}
+}
+
+static void init_registers(struct net_device *dev)
+{
+	struct netdev_private *np = dev->priv;
+	long ioaddr = dev->base_addr;
+	int i;
+
+	if (debug > 4)
+		printk(KERN_DEBUG "%s: found silicon revision %xh.\n",
+				dev->name, readl(ioaddr + SiliconRev));
 	/* On page 78 of the spec, they recommend some settings for "optimum
 	   performance" to be done in sequence.  These settings optimize some
 	   of the 100Mbit autodetection circuitry.  Also, we only want to do
 	   this for rev C of the chip.
+
+	   There seems to be a typo on page 78: the fixup should be performed
+	   for "DP83815CVNG (SRR = 203h)", but the description of the
+	   SiliconRev regsiters says "DP83815CVNG: 00000302h"
 	*/
 	if (readl(ioaddr + SiliconRev) == 0x302) {
 		writew(0x0001, ioaddr + PGSEL);
@@ -626,17 +727,8 @@
 	*/
 	writew(0x0002, ioaddr + MIntrCtrl);
 
-	i = request_irq(dev->irq, &intr_handler, SA_SHIRQ, dev->name, dev);
-	if (i) return i;
-
-	if (debug > 1)
-		printk(KERN_DEBUG "%s: netdev_open() irq %d.\n",
-			   dev->name, dev->irq);
-
-	init_ring(dev);
-
-	writel(virt_to_bus(np->rx_ring), ioaddr + RxRingPtr);
-	writel(virt_to_bus(np->tx_ring), ioaddr + TxRingPtr);
+	writel(np->ring_dma, ioaddr + RxRingPtr);
+	writel(np->ring_dma + RX_RING_SIZE * sizeof(struct netdev_desc), ioaddr + TxRingPtr);
 
 	for (i = 0; i < ETH_ALEN; i += 2) {
 		writel(i, ioaddr + RxFilterAddr);
@@ -644,23 +736,28 @@
 			   ioaddr + RxFilterData);
 	}
 
-	/* Initialize other registers. */
-	/* Configure the PCI bus bursts and FIFO thresholds. */
-	/* Configure for standard, in-spec Ethernet. */
-
-	if (readl(ioaddr + ChipConfig) & 0x20000000) {	/* Full duplex */
-		np->tx_config = 0xD0801002;
-		np->rx_config = 0x10000020;
-	} else {
-		np->tx_config = 0x10801002;
-		np->rx_config = 0x0020;
-	}
+	/* Initialize other registers.
+	 * Configure the PCI bus bursts and FIFO thresholds.
+	 * Configure for standard, in-spec Ethernet.
+	 * Start with half-duplex. check_link will update
+	 * to the correct settings. 
+	 */
+
+	/* DRTH: 2: start tx if 64 bytes are in the fifo
+	 * FLTH: 0x10: refill with next packet if 512 bytes are free
+	 * MXDMA: 0: up to 512 byte bursts.
+	 * 	MXDMA must be <= FLTH
+	 * ECRETRY=1
+	 * ATP=1
+	 */
+	np->tx_config = 0x10801002;
+	/* DRTH 0x10: start copying to memory if 128 bytes are in the fifo
+	 * MXDMA 0: up to 512 byte bursts
+	 */
+	np->rx_config = 0x0020;
 	writel(np->tx_config, ioaddr + TxConfig);
 	writel(np->rx_config, ioaddr + RxConfig);
 
-	if (dev->if_port == 0)
-		dev->if_port = np->default_port;
-
 	/* Disable PME:
 	 * The PME bit is initialized from the EEPROM contents.
 	 * PCI cards probably have PME disabled, but motherboard
@@ -670,10 +767,8 @@
 	np->SavedClkRun = readl(ioaddr + ClkRun);
 	writel(np->SavedClkRun & ~0x100, ioaddr + ClkRun);
 
-	netif_start_queue(dev);
-
-	check_duplex(dev);
-	set_rx_mode(dev);
+	check_link(dev);
+	__set_rx_mode(dev);
 
 	/* Enable interrupts by setting the interrupt mask. */
 	writel(IntrNormalSummary | IntrAbnormalSummary | 0x1f, ioaddr + IntrMask);
@@ -681,46 +776,6 @@
 
 	writel(RxOn | TxOn, ioaddr + ChipCmd);
 	writel(4, ioaddr + StatsCtrl); 					/* Clear Stats */
-
-	if (debug > 2)
-		printk(KERN_DEBUG "%s: Done netdev_open(), status: %x.\n",
-			   dev->name, (int)readl(ioaddr + ChipCmd));
-
-	/* Set the timer to check for link beat. */
-	init_timer(&np->timer);
-	np->timer.expires = jiffies + 3*HZ;
-	np->timer.data = (unsigned long)dev;
-	np->timer.function = &netdev_timer;				/* timer handler */
-	add_timer(&np->timer);
-
-	return 0;
-}
-
-static void check_duplex(struct net_device *dev)
-{
-	struct netdev_private *np = dev->priv;
-	long ioaddr = dev->base_addr;
-	int duplex;
-
-	if (np->duplex_lock)
-		return;
-	duplex = readl(ioaddr + ChipConfig) & 0x20000000 ? 1 : 0;
-	if (np->full_duplex != duplex) {
-		np->full_duplex = duplex;
-		if (debug)
-			printk(KERN_INFO "%s: Setting %s-duplex based on negotiated link"
-				   " capability.\n", dev->name,
-				   duplex ? "full" : "half");
-		if (duplex) {
-			np->rx_config |= 0x10000000;
-			np->tx_config |= 0xC0000000;
-		} else {
-			np->rx_config &= ~0x10000000;
-			np->tx_config &= ~0xC0000000;
-		}
-		writel(np->tx_config, ioaddr + TxConfig);
-		writel(np->rx_config, ioaddr + RxConfig);
-	}
 }
 
 static void netdev_timer(unsigned long data)
@@ -733,7 +788,9 @@
 	if (debug > 3)
 		printk(KERN_DEBUG "%s: Media selection timer tick, status %8.8x.\n",
 			   dev->name, (int)readl(ioaddr + IntrStatus));
-	check_duplex(dev);
+	spin_lock_irq(&np->lock);
+	check_link(dev);
+	spin_unlock_irq(&np->lock);
 	np->timer.expires = jiffies + next_tick;
 	add_timer(&np->timer);
 }
@@ -758,18 +815,29 @@
 		printk("\n");
 	}
 #endif
-
-	/* Perhaps we should reinitialize the hardware here. */
-	dev->if_port = 0;
-	/* Stop and restart the chip's Tx processes . */
-
-	/* Trigger an immediate transmit demand. */
+	spin_lock_irq(&np->lock);
+	natsemi_reset(dev);
+	drain_ring(dev);
+	init_ring(dev);
+	init_registers(dev);
+	spin_unlock_irq(&np->lock);
 
 	dev->trans_start = jiffies;
 	np->stats.tx_errors++;
 	netif_wake_queue(dev);
 }
 
+static int alloc_ring(struct net_device *dev)
+{
+	struct netdev_private *np = dev->priv;
+	np->rx_ring = pci_alloc_consistent(np->pci_dev,
+				sizeof(struct netdev_desc) * (RX_RING_SIZE+TX_RING_SIZE),
+				&np->ring_dma);
+	if (!np->rx_ring)
+		return -ENOMEM;
+	np->tx_ring = &np->rx_ring[RX_RING_SIZE];
+	return 0;
+}
 
 /* Initialize the Rx and Tx rings, along with various 'dev' bits. */
 static void init_ring(struct net_device *dev)
@@ -785,12 +853,12 @@
 
 	/* Initialize all Rx descriptors. */
 	for (i = 0; i < RX_RING_SIZE; i++) {
-		np->rx_ring[i].next_desc = virt_to_le32desc(&np->rx_ring[i+1]);
-		np->rx_ring[i].cmd_status = DescOwn;
-		np->rx_skbuff[i] = 0;
+		np->rx_ring[i].next_desc = cpu_to_le32(np->ring_dma+sizeof(struct netdev_desc)*(i+1));
+		np->rx_ring[i].cmd_status = cpu_to_le32(DescOwn);
+		np->rx_skbuff[i] = NULL;
 	}
 	/* Mark the last entry as wrapping the ring. */
-	np->rx_ring[i-1].next_desc = virt_to_le32desc(&np->rx_ring[0]);
+	np->rx_ring[i-1].next_desc = cpu_to_le32(np->ring_dma);
 
 	/* Fill in the Rx buffers.  Handle allocation failure gracefully. */
 	for (i = 0; i < RX_RING_SIZE; i++) {
@@ -799,19 +867,59 @@
 		if (skb == NULL)
 			break;
 		skb->dev = dev;			/* Mark as being used by this device. */
-		np->rx_ring[i].addr = virt_to_le32desc(skb->tail);
-		np->rx_ring[i].cmd_status =
-			cpu_to_le32(DescIntr | np->rx_buf_sz);
+		np->rx_dma[i] = pci_map_single(np->pci_dev,
+						skb->data, skb->len, PCI_DMA_FROMDEVICE);
+		np->rx_ring[i].addr = cpu_to_le32(np->rx_dma[i]);
+		np->rx_ring[i].cmd_status = cpu_to_le32(DescIntr | np->rx_buf_sz);
 	}
 	np->dirty_rx = (unsigned int)(i - RX_RING_SIZE);
 
 	for (i = 0; i < TX_RING_SIZE; i++) {
-		np->tx_skbuff[i] = 0;
-		np->tx_ring[i].next_desc = virt_to_le32desc(&np->tx_ring[i+1]);
+		np->tx_skbuff[i] = NULL;
+		np->tx_ring[i].next_desc = cpu_to_le32(np->ring_dma
+					+sizeof(struct netdev_desc)*(i+1+RX_RING_SIZE));
 		np->tx_ring[i].cmd_status = 0;
 	}
-	np->tx_ring[i-1].next_desc = virt_to_le32desc(&np->tx_ring[0]);
-	return;
+	np->tx_ring[i-1].next_desc = cpu_to_le32(np->ring_dma
+					+sizeof(struct netdev_desc)*(RX_RING_SIZE));
+}
+
+static void drain_ring(struct net_device *dev)
+{
+	struct netdev_private *np = dev->priv;
+	int i;
+
+	/* Free all the skbuffs in the Rx queue. */
+	for (i = 0; i < RX_RING_SIZE; i++) {
+		np->rx_ring[i].cmd_status = 0;
+		np->rx_ring[i].addr = 0xBADF00D0; /* An invalid address. */
+		if (np->rx_skbuff[i]) {
+			pci_unmap_single(np->pci_dev,
+						np->rx_dma[i],
+						np->rx_skbuff[i]->len,
+						PCI_DMA_FROMDEVICE);
+			dev_kfree_skb(np->rx_skbuff[i]);
+		}
+		np->rx_skbuff[i] = NULL;
+	}
+	for (i = 0; i < TX_RING_SIZE; i++) {
+		if (np->tx_skbuff[i]) {
+			pci_unmap_single(np->pci_dev,
+						np->rx_dma[i],
+						np->rx_skbuff[i]->len,
+						PCI_DMA_TODEVICE);
+			dev_kfree_skb(np->tx_skbuff[i]);
+		}
+		np->tx_skbuff[i] = NULL;
+	}
+}
+
+static void free_ring(struct net_device *dev)
+{
+	struct netdev_private *np = dev->priv;
+	pci_free_consistent(np->pci_dev,
+				sizeof(struct netdev_desc) * (RX_RING_SIZE+TX_RING_SIZE),
+				np->rx_ring, np->ring_dma);
 }
 
 static int start_tx(struct sk_buff *skb, struct net_device *dev)
@@ -826,17 +934,26 @@
 	entry = np->cur_tx % TX_RING_SIZE;
 
 	np->tx_skbuff[entry] = skb;
+	np->tx_dma[entry] = pci_map_single(np->pci_dev,
+				skb->data,skb->len, PCI_DMA_TODEVICE);
 
-	np->tx_ring[entry].addr = virt_to_le32desc(skb->data);
-	np->tx_ring[entry].cmd_status = cpu_to_le32(DescOwn|DescIntr | skb->len);
-	np->cur_tx++;
+	np->tx_ring[entry].addr = cpu_to_le32(np->tx_dma[entry]);
 
+	spin_lock_irq(&np->lock);
+
+#if 0
+	np->tx_ring[entry].cmd_status = cpu_to_le32(DescOwn | DescIntr | skb->len);
+#else
+	np->tx_ring[entry].cmd_status = cpu_to_le32(DescOwn | skb->len);
+#endif
 	/* StrongARM: Explicitly cache flush np->tx_ring and skb->data,skb->len. */
 	wmb();
-
-	spin_lock_irq(&np->lock);
-	if (np->cur_tx - np->dirty_tx >= TX_QUEUE_LEN - 1)
-		netif_stop_queue(dev);
+	np->cur_tx++;
+	if (np->cur_tx - np->dirty_tx >= TX_QUEUE_LEN - 1) {
+		netdev_tx_done(dev);
+		if (np->cur_tx - np->dirty_tx >= TX_QUEUE_LEN - 1)
+			netif_stop_queue(dev);
+	}
 	spin_unlock_irq(&np->lock);
 
 	/* Wake the potentially-idle transmit channel. */
@@ -851,6 +968,48 @@
 	return 0;
 }
 
+static void netdev_tx_done(struct net_device *dev)
+{
+	struct netdev_private *np = dev->priv;
+
+	for (; np->cur_tx - np->dirty_tx > 0; np->dirty_tx++) {
+		int entry = np->dirty_tx % TX_RING_SIZE;
+		if (np->tx_ring[entry].cmd_status & cpu_to_le32(DescOwn)) {
+			if (debug > 4)
+				printk(KERN_DEBUG "%s: tx frame #%d is busy.\n",
+						dev->name, np->dirty_tx);
+			break;
+		}
+		if (debug > 4)
+			printk(KERN_DEBUG "%s: tx frame #%d finished with status %8.8xh.\n",
+					dev->name, np->dirty_tx,
+					le32_to_cpu(np->tx_ring[entry].cmd_status));
+		if (np->tx_ring[entry].cmd_status & cpu_to_le32(0x08000000)) {
+			np->stats.tx_packets++;
+			np->stats.tx_bytes += np->tx_skbuff[entry]->len;
+		} else {			/* Various Tx errors */
+			int tx_status = le32_to_cpu(np->tx_ring[entry].cmd_status);
+			if (tx_status & 0x04010000) np->stats.tx_aborted_errors++;
+			if (tx_status & 0x02000000) np->stats.tx_fifo_errors++;
+			if (tx_status & 0x01000000) np->stats.tx_carrier_errors++;
+			if (tx_status & 0x00200000) np->stats.tx_window_errors++;
+			np->stats.tx_errors++;
+		}
+		pci_unmap_single(np->pci_dev,np->tx_dma[entry],
+					np->tx_skbuff[entry]->len,
+					PCI_DMA_TODEVICE);
+		/* Free the original skb. */
+		dev_kfree_skb_irq(np->tx_skbuff[entry]);
+		np->tx_skbuff[entry] = NULL;
+	}
+	if (netif_queue_stopped(dev)
+		&& np->cur_tx - np->dirty_tx < TX_QUEUE_LEN - 4) {
+		/* The ring is no longer full, wake queue. */
+		netif_wake_queue(dev);
+	}
+	spin_unlock(&np->lock);
+
+}
 /* The interrupt handler does all of the Rx thread work and cleans up
    after the Tx thread. */
 static void intr_handler(int irq, void *dev_instance, struct pt_regs *rgs)
@@ -879,34 +1038,11 @@
 		if (intr_status & (IntrRxDone | IntrRxIntr))
 			netdev_rx(dev);
 
-		spin_lock(&np->lock);
-
-		for (; np->cur_tx - np->dirty_tx > 0; np->dirty_tx++) {
-			int entry = np->dirty_tx % TX_RING_SIZE;
-			if (np->tx_ring[entry].cmd_status & cpu_to_le32(DescOwn))
-				break;
-			if (np->tx_ring[entry].cmd_status & cpu_to_le32(0x08000000)) {
-				np->stats.tx_packets++;
-				np->stats.tx_bytes += np->tx_skbuff[entry]->len;
-			} else {			/* Various Tx errors */
-				int tx_status = le32_to_cpu(np->tx_ring[entry].cmd_status);
-				if (tx_status & 0x04010000) np->stats.tx_aborted_errors++;
-				if (tx_status & 0x02000000) np->stats.tx_fifo_errors++;
-				if (tx_status & 0x01000000) np->stats.tx_carrier_errors++;
-				if (tx_status & 0x00200000) np->stats.tx_window_errors++;
-				np->stats.tx_errors++;
-			}
-			/* Free the original skb. */
-			dev_kfree_skb_irq(np->tx_skbuff[entry]);
-			np->tx_skbuff[entry] = 0;
+		if (intr_status & (IntrTxDone | IntrTxIntr | IntrTxIdle | IntrTxErr) ) {
+			spin_lock(&np->lock);
+			netdev_tx_done(dev);
+			spin_unlock(&np->lock);
 		}
-		if (netif_queue_stopped(dev)
-			&& np->cur_tx - np->dirty_tx < TX_QUEUE_LEN - 4) {
-			/* The ring is no longer full, wake queue. */
-			netif_wake_queue(dev);
-		}
-
-		spin_unlock(&np->lock);
 
 		/* Abnormal error summary/uncommon events handlers. */
 		if (intr_status & IntrAbnormalSummary)
@@ -927,7 +1063,7 @@
 
 /* This routine is logically part of the interrupt handler, but separated
    for clarity and better register allocation. */
-static int netdev_rx(struct net_device *dev)
+static void netdev_rx(struct net_device *dev)
 {
 	struct netdev_private *np = dev->priv;
 	int entry = np->cur_rx % RX_RING_SIZE;
@@ -967,6 +1103,9 @@
 				&& (skb = dev_alloc_skb(pkt_len + 2)) != NULL) {
 				skb->dev = dev;
 				skb_reserve(skb, 2);	/* 16 byte align the IP header */
+				pci_dma_sync_single(np->pci_dev, np->rx_dma[entry],
+							np->rx_skbuff[entry]->len,
+							PCI_DMA_FROMDEVICE);
 #if HAS_IP_COPYSUM
 				eth_copy_and_sum(skb, np->rx_skbuff[entry]->tail, pkt_len, 0);
 				skb_put(skb, pkt_len);
@@ -975,16 +1114,11 @@
 					   pkt_len);
 #endif
 			} else {
-				char *temp = skb_put(skb = np->rx_skbuff[entry], pkt_len);
+				pci_unmap_single(np->pci_dev, np->rx_dma[entry],
+							np->rx_skbuff[entry]->len,
+							PCI_DMA_FROMDEVICE);
+				skb_put(skb = np->rx_skbuff[entry], pkt_len);
 				np->rx_skbuff[entry] = NULL;
-#ifndef final_version				/* Remove after testing. */
-				if (le32desc_to_virt(np->rx_ring[entry].addr) != temp)
-					printk(KERN_ERR "%s: Internal fault: The skbuff addresses "
-						   "do not match in netdev_rx: %p vs. %p / %p.\n",
-						   dev->name,
-						   le32desc_to_virt(np->rx_ring[entry].addr),
-						   skb->head, temp);
-#endif
 			}
 			skb->protocol = eth_type_trans(skb, dev);
 			/* W/ hardware checksum: skb->ip_summed = CHECKSUM_UNNECESSARY; */
@@ -1008,7 +1142,9 @@
 			if (skb == NULL)
 				break;				/* Better luck next round. */
 			skb->dev = dev;			/* Mark as being used by this device. */
-			np->rx_ring[entry].addr = virt_to_le32desc(skb->tail);
+			np->rx_dma[entry] = pci_map_single(np->pci_dev,
+							skb->data, skb->len, PCI_DMA_FROMDEVICE);
+			np->rx_ring[entry].addr = cpu_to_le32(np->rx_dma[entry]);
 		}
 		np->rx_ring[entry].cmd_status =
 			cpu_to_le32(DescIntr | np->rx_buf_sz);
@@ -1016,7 +1152,6 @@
 
 	/* Restart Rx engine if stopped. */
 	writel(RxOn, dev->base_addr + ChipCmd);
-	return 0;
 }
 
 static void netdev_error(struct net_device *dev, int intr_status)
@@ -1024,13 +1159,14 @@
 	struct netdev_private *np = dev->priv;
 	long ioaddr = dev->base_addr;
 
+	spin_lock(&np->lock);
 	if (intr_status & LinkChange) {
 		printk(KERN_NOTICE "%s: Link changed: Autonegotiation advertising"
 			   " %4.4x  partner %4.4x.\n", dev->name,
 			   (int)readl(ioaddr + 0x90), (int)readl(ioaddr + 0x94));
 		/* read MII int status to clear the flag */
 		readw(ioaddr + MIntrStatus);
-		check_duplex(dev);
+		check_link(dev);
 	}
 	if (intr_status & StatsMax) {
 		get_stats(dev);
@@ -1038,6 +1174,9 @@
 	if (intr_status & IntrTxUnderrun) {
 		if ((np->tx_config & 0x3f) < 62)
 			np->tx_config += 2;
+		if (debug > 2)
+			printk(KERN_NOTICE "%s: increasing Tx theshold, new tx cfg %8.8xh.\n",
+					dev->name, np->tx_config);
 		writel(np->tx_config, ioaddr + TxConfig);
 	}
 	if (intr_status & WOLPkt) {
@@ -1054,6 +1193,7 @@
 		np->stats.tx_fifo_errors++;
 		np->stats.rx_fifo_errors++;
 	}
+	spin_unlock(&np->lock);
 }
 
 static struct net_device_stats *get_stats(struct net_device *dev)
@@ -1079,6 +1219,7 @@
    Chips may use the upper or lower CRC bits, and may reverse and/or invert
    them.  Select the endian-ness that results in minimal calculations.
 */
+#if 0
 static unsigned const ethernet_polynomial_le = 0xedb88320U;
 static inline unsigned ether_crc_le(int length, unsigned char *data)
 {
@@ -1096,8 +1237,37 @@
 	}
 	return crc;
 }
+#else
+#define DP_POLYNOMIAL			0x04C11DB7
+/* dp83815_crc - computer CRC for hash table entries */
+static unsigned ether_crc_le(int length, unsigned char *data)
+{
+    u32 crc;
+    u8 cur_byte;
+    u8 msb;
+    u8 byte, bit;
+
+    crc = ~0;
+    for (byte=0; byte<length; byte++) {
+        cur_byte = *data++;
+        for (bit=0; bit<8; bit++) {
+            msb = crc >> 31;
+            crc <<= 1;
+            if (msb ^ (cur_byte & 1)) {
+                crc ^= DP_POLYNOMIAL;
+                crc |= 1;
+            }
+            cur_byte >>= 1;
+        }
+    }
+    crc >>= 23;
 
-static void set_rx_mode(struct net_device *dev)
+    return (crc);
+}
+#endif
+
+#define HASH_TABLE	0x200
+static void __set_rx_mode(struct net_device *dev)
 {
 	long ioaddr = dev->base_addr;
 	struct netdev_private *np = dev->priv;
@@ -1123,12 +1293,20 @@
 		}
 		rx_mode = AcceptBroadcast | AcceptMulticast | AcceptMyPhys;
 		for (i = 0; i < 64; i += 2) {
-			writew(0x200 + i, ioaddr + RxFilterAddr);
+			writew(HASH_TABLE + i, ioaddr + RxFilterAddr);
 			writew((mc_filter[i+1]<<8) + mc_filter[i], ioaddr + RxFilterData);
 		}
 	}
 	writel(rx_mode, ioaddr + RxFilterAddr);
 	np->cur_rx_mode = rx_mode;
+	spin_unlock_irq(&np->lock);
+}
+static void set_rx_mode(struct net_device *dev)
+{
+	struct netdev_private *np = dev->priv;
+	spin_lock_irq(&np->lock);
+	__set_rx_mode(dev);
+	spin_unlock_irq(&np->lock);
 }
 
 static int netdev_ethtool_ioctl(struct net_device *dev, void *useraddr)
@@ -1177,12 +1355,6 @@
 			u16 value = data[2];
 			writew(value, dev->base_addr + 0x80 + (miireg << 2));
 			switch (miireg) {
-			case 0:
-				/* Check for autonegotiation on or reset. */
-				np->duplex_lock = (value & 0x9000) ? 0 : 1;
-				if (np->duplex_lock)
-					np->full_duplex = (value & 0x0100) ? 1 : 0;
-				break;
 			case 4: np->advertising = value; break;
 			}
 		}
@@ -1222,12 +1394,12 @@
 #ifdef __i386__
 	if (debug > 2) {
 		printk("\n"KERN_DEBUG"  Tx ring at %8.8x:\n",
-			   (int)virt_to_bus(np->tx_ring));
+			   (int)np->tx_ring);
 		for (i = 0; i < TX_RING_SIZE; i++)
 			printk(" #%d desc. %8.8x %8.8x.\n",
 				   i, np->tx_ring[i].cmd_status, np->tx_ring[i].addr);
 		printk("\n"KERN_DEBUG "  Rx ring %8.8x:\n",
-			   (int)virt_to_bus(np->rx_ring));
+			   (int)np->rx_ring);
 		for (i = 0; i < RX_RING_SIZE; i++) {
 			printk(KERN_DEBUG " #%d desc. %8.8x %8.8x\n",
 				   i, np->rx_ring[i].cmd_status, np->rx_ring[i].addr);
@@ -1236,21 +1408,9 @@
 #endif /* __i386__ debugging only */
 
 	free_irq(dev->irq, dev);
+	drain_ring(dev);
+	free_ring(dev);
 
-	/* Free all the skbuffs in the Rx queue. */
-	for (i = 0; i < RX_RING_SIZE; i++) {
-		np->rx_ring[i].cmd_status = 0;
-		np->rx_ring[i].addr = 0xBADF00D0; /* An invalid address. */
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
 	/* Restore PME enable bit */
 	writel(np->SavedClkRun, ioaddr + ClkRun);
 #if 0


--------------E50F853014C20DA8159BB4F1--


