Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132366AbRCZHJv>; Mon, 26 Mar 2001 02:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132367AbRCZHJp>; Mon, 26 Mar 2001 02:09:45 -0500
Received: from colorfullife.com ([216.156.138.34]:45320 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S132366AbRCZHJ3>;
	Mon, 26 Mar 2001 02:09:29 -0500
Message-ID: <3ABEEAFE.81CA76A3@colorfullife.com>
Date: Mon, 26 Mar 2001 09:08:46 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac20 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: tg@skynet.be, linux-kernel@vger.kernel.org
Subject: Re: via-rhine driver: wicked 2005 problem
Content-Type: multipart/mixed;
 boundary="------------DAB2B8E26064555CAC9F312F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DAB2B8E26064555CAC9F312F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> [Kernel 2.4.2,

the -ac kernels contain a patch that automatically resets the nic if it
dies. I've attached my old patch, it applies to 2.4.2.

> 
> I tried the diagnostic utilities from Donald Becker at Scyld.com,
> but I don't  know what I should be looking for. The text output
> seems ok to me. 
>
Could you post the output?
And a few more lines from your kernel log.

--
	Manfred
--------------DAB2B8E26064555CAC9F312F
Content-Type: text/plain; charset=us-ascii;
 name="patch-via-rhine"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-via-rhine"

--- 2.4/drivers/net/via-rhine.c	Mon Feb  5 16:44:59 2001
+++ build-2.4/drivers/net/via-rhine.c	Mon Feb  5 19:46:23 2001
@@ -55,6 +55,9 @@
 	LK1.1.6:
 	- Urban Widmark: merges from Beckers 1.08b version (VT6102 + mdio)
 	                 set netif_running_on/off on startup, del_timer_sync
+	
+	LK1.1.7:
+	- Manfred Spraul: added reset into tx_timeout
 */
 
 
@@ -121,13 +124,14 @@
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 #include <asm/processor.h>		/* Processor type for cache alignment. */
 #include <asm/bitops.h>
 #include <asm/io.h>
 
 /* These identify the driver base version and may not be removed. */
 static char version1[] __devinitdata =
-"via-rhine.c:v1.08b-LK1.1.6  8/9/2000  Written by Donald Becker\n";
+"via-rhine.c:v1.08b-LK1.1.7  8/9/2000  Written by Donald Becker\n";
 static char version2[] __devinitdata =
 "  http://www.scyld.com/network/via-rhine.html\n";
 
@@ -380,6 +384,7 @@
 	CmdNoTxPoll=0x0800, CmdReset=0x8000,
 };
 
+#define MAX_MII_CNT	4
 struct netdev_private {
 	/* Descriptor rings */
 	struct rx_desc *rx_ring;
@@ -421,7 +426,8 @@
 
 	/* MII transceiver section. */
 	u16 advertising;					/* NWay media advertisement */
-	unsigned char phys[2];				/* MII device addresses. */
+	unsigned char phys[MAX_MII_CNT];			/* MII device addresses. */
+	unsigned int mii_cnt;			/* number of MIIs found, but only the first one is used */
 	u16 mii_status;						/* last read MII status */
 };
 
@@ -431,7 +437,6 @@
 static void via_rhine_check_duplex(struct net_device *dev);
 static void via_rhine_timer(unsigned long data);
 static void via_rhine_tx_timeout(struct net_device *dev);
-static void via_rhine_init_ring(struct net_device *dev);
 static int  via_rhine_start_tx(struct sk_buff *skb, struct net_device *dev);
 static void via_rhine_interrupt(int irq, void *dev_instance, struct pt_regs *regs);
 static void via_rhine_tx(struct net_device *dev);
@@ -443,6 +448,25 @@
 static int  via_rhine_close(struct net_device *dev);
 static inline void clear_tally_counters(long ioaddr);
 
+static void wait_for_reset(struct net_device *dev)
+{
+	long ioaddr = dev->base_addr;
+	int i;
+
+	i = 0;
+	do {
+		udelay(5);
+		i++;
+		if(i > 2000) {
+			printk(KERN_ERR "%s: reset did not complete in 10 ms.\n",
+					dev->name);
+			break;
+		}
+	} while(readw(ioaddr + ChipCmd) & CmdReset);
+	if (debug > 1)
+		printk(KERN_INFO "%s: reset finished after %d microseconds.\n",
+				dev->name, 5*i);
+}
 
 static int __devinit via_rhine_init_one (struct pci_dev *pdev,
 					 const struct pci_device_id *ent)
@@ -451,14 +475,11 @@
 	struct netdev_private *np;
 	int i, option;
 	int chip_id = (int) ent->driver_data;
-	int irq = pdev->irq;
 	static int card_idx = -1;
 	static int did_version = 0;
 	long ioaddr;
 	int io_size;
 	int pci_flags;
-	void *ring;
-	dma_addr_t ring_dma;
 	
 	/* print version once and once only */
 	if (! did_version++) {
@@ -471,6 +492,10 @@
 	io_size = via_rhine_chip_info[chip_id].io_size;
 	pci_flags = via_rhine_chip_info[chip_id].pci_flags;
 
+	if (pci_enable_device (pdev))
+		goto err_out;
+
+
 	/* this should always be supported */
 	if (!pci_dma_supported(pdev, 0xffffffff)) {
 		printk(KERN_ERR "32-bit PCI DMA addresses not supported by the card!?\n");
@@ -484,20 +509,7 @@
 		goto err_out;
 	}
 
-	/* allocate pci dma space for rx and tx descriptor rings */
-	ring = pci_alloc_consistent(pdev, 
-				    RX_RING_SIZE * sizeof(struct rx_desc) +
-				    TX_RING_SIZE * sizeof(struct tx_desc),
-				    &ring_dma);
-	if (!ring) {
-		printk(KERN_ERR "Could not allocate DMA memory.\n");
-		goto err_out;
-	}
-
 	ioaddr = pci_resource_start (pdev, pci_flags & PCI_ADDR0 ? 0 : 1);
-
-	if (pci_enable_device (pdev))
-		goto err_out_free_dma;
 	
 	if (pci_flags & PCI_USES_MASTER)
 		pci_set_master (pdev);
@@ -506,7 +518,7 @@
 	if (dev == NULL) {
 		printk (KERN_ERR "init_ethernet failed for card #%d\n",
 			card_idx);
-		goto err_out_free_dma;
+		goto err_out;
 	}
 	SET_MODULE_OWNER(dev);
 	
@@ -545,23 +557,19 @@
 		dev->dev_addr[i] = readb(ioaddr + StationAddr + i);
 	for (i = 0; i < 5; i++)
 			printk("%2.2x:", dev->dev_addr[i]);
-	printk("%2.2x, IRQ %d.\n", dev->dev_addr[i], irq);
+	printk("%2.2x, IRQ %d.\n", dev->dev_addr[i], pdev->irq);
 
 	/* Reset the chip to erase previous misconfiguration. */
 	writew(CmdReset, ioaddr + ChipCmd);
+	wait_for_reset(dev);
 
 	dev->base_addr = ioaddr;
-	dev->irq = irq;
 
 	np = dev->priv;
 	spin_lock_init (&np->lock);
 	np->chip_id = chip_id;
 	np->drv_flags = via_rhine_chip_info[chip_id].drv_flags;
 	np->pdev = pdev;
-	np->rx_ring = ring;
-	np->tx_ring = ring + RX_RING_SIZE * sizeof(struct rx_desc);
-	np->rx_ring_dma = ring_dma;
-	np->tx_ring_dma = ring_dma + RX_RING_SIZE * sizeof(struct rx_desc);
 
 	if (dev->mem_start)
 		option = dev->mem_start;
@@ -593,7 +601,7 @@
 	if (np->drv_flags & CanHaveMII) {
 		int phy, phy_idx = 0;
 		np->phys[0] = 1;		/* Standard for this chip. */
-		for (phy = 1; phy < 32 && phy_idx < 4; phy++) {
+		for (phy = 1; phy < 32 && phy_idx < MAX_MII_CNT; phy++) {
 			int mii_status = mdio_read(dev, phy, 1);
 			if (mii_status != 0xffff  &&  mii_status != 0x0000) {
 				np->phys[phy_idx++] = phy;
@@ -610,6 +618,7 @@
 					netif_carrier_off(dev);
 			}
 		}
+		np->mii_cnt = phy_idx;
 	}
 
 	return 0;
@@ -628,16 +637,202 @@
 err_out_free_netdev:
 	unregister_netdev (dev);
 	kfree (dev);
-err_out_free_dma:
-	pci_free_consistent(pdev, 
+err_out:
+	return -ENODEV;
+}
+
+static int alloc_ring(struct net_device* dev)
+{
+	struct netdev_private *np = (struct netdev_private *)dev->priv;
+	void *ring;
+	dma_addr_t ring_dma;
+
+	ring = pci_alloc_consistent(np->pdev, 
+				    RX_RING_SIZE * sizeof(struct rx_desc) +
+				    TX_RING_SIZE * sizeof(struct tx_desc),
+				    &ring_dma);
+	if (!ring) {
+		printk(KERN_ERR "Could not allocate DMA memory.\n");
+		return -ENOMEM;
+	}
+	np->tx_bufs = pci_alloc_consistent(np->pdev, PKT_BUF_SZ * TX_RING_SIZE,
+								   &np->tx_bufs_dma);
+	if (np->tx_bufs == NULL) {
+		pci_free_consistent(np->pdev, 
 			    RX_RING_SIZE * sizeof(struct rx_desc) +
 			    TX_RING_SIZE * sizeof(struct tx_desc),
 			    ring, ring_dma);
-err_out:
-	return -ENODEV;
+		return -ENOMEM;
+	}
+
+	np->rx_ring = ring;
+	np->tx_ring = ring + RX_RING_SIZE * sizeof(struct rx_desc);
+	np->rx_ring_dma = ring_dma;
+	np->tx_ring_dma = ring_dma + RX_RING_SIZE * sizeof(struct rx_desc);
+
+
+	return 0;
+}
+
+void free_ring(struct net_device* dev)
+{
+	struct netdev_private *np = (struct netdev_private *)dev->priv;
+
+	pci_free_consistent(np->pdev, 
+			    RX_RING_SIZE * sizeof(struct rx_desc) +
+			    TX_RING_SIZE * sizeof(struct tx_desc),
+			    np->rx_ring, np->rx_ring_dma);
+
+	pci_free_consistent(np->pdev, PKT_BUF_SZ * TX_RING_SIZE,
+						np->tx_bufs, np->tx_bufs_dma);
+
 }
 
+static void alloc_rbufs(struct net_device *dev)
+{
+	struct netdev_private *np = (struct netdev_private *)dev->priv;
+	dma_addr_t next;
+	int i;
+
+	np->dirty_rx = np->cur_rx = 0;
+
+	np->rx_buf_sz = (dev->mtu <= 1500 ? PKT_BUF_SZ : dev->mtu + 32);
+	np->rx_head_desc = &np->rx_ring[0];
+	next = np->rx_ring_dma;
+	
+	/* Init the ring entries */
+	for (i = 0; i < RX_RING_SIZE; i++) {
+		np->rx_ring[i].rx_status = 0;
+		np->rx_ring[i].desc_length = cpu_to_le32(np->rx_buf_sz);
+		next += sizeof(struct rx_desc);
+		np->rx_ring[i].next_desc = cpu_to_le32(next);
+		np->rx_skbuff[i] = 0;
+	}
+	/* Mark the last entry as wrapping the ring. */
+	np->rx_ring[i-1].next_desc = cpu_to_le32(np->rx_ring_dma);
+
+	/* Fill in the Rx buffers.  Handle allocation failure gracefully. */
+	for (i = 0; i < RX_RING_SIZE; i++) {
+		struct sk_buff *skb = dev_alloc_skb(np->rx_buf_sz);
+		np->rx_skbuff[i] = skb;
+		if (skb == NULL)
+			break;
+		skb->dev = dev;                 /* Mark as being used by this device. */
+
+		np->rx_skbuff_dma[i] =
+			pci_map_single(np->pdev, skb->tail, np->rx_buf_sz,
+						   PCI_DMA_FROMDEVICE);
+
+		np->rx_ring[i].addr = cpu_to_le32(np->rx_skbuff_dma[i]);
+		np->rx_ring[i].rx_status = cpu_to_le32(DescOwn);
+	}
+	np->dirty_rx = (unsigned int)(i - RX_RING_SIZE);
+}
+
+static void free_rbufs(struct net_device* dev)
+{
+	struct netdev_private *np = (struct netdev_private *)dev->priv;
+	int i;
+
+	/* Free all the skbuffs in the Rx queue. */
+	for (i = 0; i < RX_RING_SIZE; i++) {
+		np->rx_ring[i].rx_status = 0;
+		np->rx_ring[i].addr = cpu_to_le32(0xBADF00D0); /* An invalid address. */
+		if (np->rx_skbuff[i]) {
+			pci_unmap_single(np->pdev,
+							 np->rx_skbuff_dma[i],
+							 np->rx_buf_sz, PCI_DMA_FROMDEVICE);
+			dev_kfree_skb(np->rx_skbuff[i]);
+		}
+		np->rx_skbuff[i] = 0;
+	}
+}
+
+static void alloc_tbufs(struct net_device* dev)
+{
+	struct netdev_private *np = (struct netdev_private *)dev->priv;
+	dma_addr_t next;
+	int i;
+
+	np->dirty_tx = np->cur_tx = 0;
+	next = np->tx_ring_dma;
+	for (i = 0; i < TX_RING_SIZE; i++) {
+		np->tx_skbuff[i] = 0;
+		np->tx_ring[i].tx_status = 0;
+		np->tx_ring[i].desc_length = cpu_to_le32(0x00e08000);
+		next += sizeof(struct tx_desc);
+		np->tx_ring[i].next_desc = cpu_to_le32(next);
+		np->tx_buf[i] = &np->tx_bufs[i * PKT_BUF_SZ];
+	}
+	np->tx_ring[i-1].next_desc = cpu_to_le32(np->tx_ring_dma);
+
+}
+
+static void free_tbufs(struct net_device* dev)
+{
+	struct netdev_private *np = (struct netdev_private *)dev->priv;
+	int i;
+
+	for (i = 0; i < TX_RING_SIZE; i++) {
+		np->tx_ring[i].tx_status = 0;
+		np->tx_ring[i].desc_length = cpu_to_le32(0x00e08000);
+		np->tx_ring[i].addr = cpu_to_le32(0xBADF00D0); /* An invalid address. */
+		if (np->tx_skbuff[i]) {
+			if (np->tx_skbuff_dma[i]) {
+				pci_unmap_single(np->pdev,
+								 np->tx_skbuff_dma[i],
+								 np->tx_skbuff[i]->len, PCI_DMA_TODEVICE);
+			}
+			dev_kfree_skb(np->tx_skbuff[i]);
+		}
+		np->tx_skbuff[i] = 0;
+		np->tx_buf[i] = 0;
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
+	writew(0x0006, ioaddr + PCIBusConfig);	/* Tune configuration??? */
+	/* Configure the FIFO thresholds. */
+	writeb(0x20, ioaddr + TxConfig);	/* Initial threshold 32 bytes */
+	np->tx_thresh = 0x20;
+	np->rx_thresh = 0x60;			/* Written in via_rhine_set_rx_mode(). */
+
+	if (dev->if_port == 0)
+		dev->if_port = np->default_port;
+
+	writel(np->rx_ring_dma, ioaddr + RxRingPtr);
+	writel(np->tx_ring_dma, ioaddr + TxRingPtr);
+
+	via_rhine_set_rx_mode(dev);
+
+	/* Enable interrupts by setting the interrupt mask. */
+	writew(IntrRxDone | IntrRxErr | IntrRxEmpty| IntrRxOverflow| IntrRxDropped|
+		   IntrTxDone | IntrTxAbort | IntrTxUnderrun |
+		   IntrPCIErr | IntrStatsMax | IntrLinkChange | IntrMIIChange,
+		   ioaddr + IntrEnable);
+
+	np->chip_cmd = CmdStart|CmdTxOn|CmdRxOn|CmdNoTxPoll;
+	if (np->duplex_lock)
+		np->chip_cmd |= CmdFDuplex;
+	writew(np->chip_cmd, ioaddr + ChipCmd);
+
+	via_rhine_check_duplex(dev);
 
+	/* The LED outputs of various MII xcvrs should be configured.  */
+	/* For NS or Mison phys, turn on bit 1 in register 0x17 */
+	/* For ESI phys, turn on bit 7 in register 0x17. */
+	mdio_write(dev, np->phys[0], 0x17, mdio_read(dev, np->phys[0], 0x17) |
+			   (np->drv_flags & HasESIPhy) ? 0x0080 : 0x0001);
+}
 /* Read and write over the MII Management Data I/O (MDIO) interface. */
 
 static int mdio_read(struct net_device *dev, int phy_id, int regnum)
@@ -698,68 +893,29 @@
 	/* Reset the chip. */
 	writew(CmdReset, ioaddr + ChipCmd);
 
-	i = request_irq(dev->irq, &via_rhine_interrupt, SA_SHIRQ, dev->name, dev);
+	i = request_irq(np->pdev->irq, &via_rhine_interrupt, SA_SHIRQ, dev->name, dev);
 	if (i)
 		return i;
 
 	if (debug > 1)
 		printk(KERN_DEBUG "%s: via_rhine_open() irq %d.\n",
-			   dev->name, dev->irq);
-
-	np->tx_bufs = pci_alloc_consistent(np->pdev, PKT_BUF_SZ * TX_RING_SIZE,
-									   &np->tx_bufs_dma);
-	if (np->tx_bufs == NULL) {
-		free_irq(dev->irq, dev);
-		return -ENOMEM;
-	}
-
-	via_rhine_init_ring(dev);
-
-	writel(np->rx_ring_dma, ioaddr + RxRingPtr);
-	writel(np->tx_ring_dma, ioaddr + TxRingPtr);
-
-	for (i = 0; i < 6; i++)
-		writeb(dev->dev_addr[i], ioaddr + StationAddr + i);
-
-	/* Initialize other registers. */
-	writew(0x0006, ioaddr + PCIBusConfig);	/* Tune configuration??? */
-	/* Configure the FIFO thresholds. */
-	writeb(0x20, ioaddr + TxConfig);	/* Initial threshold 32 bytes */
-	np->tx_thresh = 0x20;
-	np->rx_thresh = 0x60;			/* Written in via_rhine_set_rx_mode(). */
-
-	if (dev->if_port == 0)
-		dev->if_port = np->default_port;
-
-	netif_start_queue(dev);
-
-	via_rhine_set_rx_mode(dev);
-
-	/* Enable interrupts by setting the interrupt mask. */
-	writew(IntrRxDone | IntrRxErr | IntrRxEmpty| IntrRxOverflow| IntrRxDropped|
-		   IntrTxDone | IntrTxAbort | IntrTxUnderrun |
-		   IntrPCIErr | IntrStatsMax | IntrLinkChange | IntrMIIChange,
-		   ioaddr + IntrEnable);
-
-	np->chip_cmd = CmdStart|CmdTxOn|CmdRxOn|CmdNoTxPoll;
-	if (np->duplex_lock)
-		np->chip_cmd |= CmdFDuplex;
-	writew(np->chip_cmd, ioaddr + ChipCmd);
-
-	via_rhine_check_duplex(dev);
-
-	/* The LED outputs of various MII xcvrs should be configured.  */
-	/* For NS or Mison phys, turn on bit 1 in register 0x17 */
-	/* For ESI phys, turn on bit 7 in register 0x17. */
-	mdio_write(dev, np->phys[0], 0x17, mdio_read(dev, np->phys[0], 0x17) |
-			   (np->drv_flags & HasESIPhy) ? 0x0080 : 0x0001);
-
+			   dev->name, np->pdev->irq);
+	
+	i = alloc_ring(dev);
+	if (i)
+		return i;
+	alloc_rbufs(dev);
+	alloc_tbufs(dev);
+	wait_for_reset(dev);
+	init_registers(dev);
 	if (debug > 2)
 		printk(KERN_DEBUG "%s: Done via_rhine_open(), status %4.4x "
 			   "MII status: %4.4x.\n",
 			   dev->name, readw(ioaddr + ChipCmd),
 			   mdio_read(dev, np->phys[0], 1));
 
+	netif_start_queue(dev);
+
 	/* Set the timer to check for link beat. */
 	init_timer(&np->timer);
 	np->timer.expires = jiffies + 2;
@@ -835,84 +991,37 @@
 	struct netdev_private *np = (struct netdev_private *) dev->priv;
 	long ioaddr = dev->base_addr;
 
-	/* Lock to protect mdio_read and access to stats. A friendly
-       advice to the implementor of the XXXs in this function is to be
-       sure not to spin too long (whatever that means :) */
-	spin_lock_irq (&np->lock);
-
 	printk (KERN_WARNING "%s: Transmit timed out, status %4.4x, PHY status "
 		"%4.4x, resetting...\n",
 		dev->name, readw (ioaddr + IntrStatus),
 		mdio_read (dev, np->phys[0], 1));
 
-	/* XXX Perhaps we should reinitialize the hardware here. */
 	dev->if_port = 0;
 
-	/* Stop and restart the chip's Tx processes . */
-	/* XXX to do */
-
-	/* Trigger an immediate transmit demand. */
-	/* XXX to do */
+	/* protect against concurrent rx interrupts */
+	disable_irq(np->pdev->irq);
 
-	dev->trans_start = jiffies;
-	np->stats.tx_errors++;
-
-	spin_unlock_irq (&np->lock);
-}
+	spin_lock(&np->lock);
 
+	/* Reset the chip. */
+	writew(CmdReset, ioaddr + ChipCmd);
 
-/* Initialize the Rx and Tx rings, along with various 'dev' bits. */
-static void via_rhine_init_ring(struct net_device *dev)
-{
-	struct netdev_private *np = (struct netdev_private *)dev->priv;
-	int i;
-	dma_addr_t next = np->rx_ring_dma;
-
-	np->cur_rx = np->cur_tx = 0;
-	np->dirty_rx = np->dirty_tx = 0;
-
-	np->rx_buf_sz = (dev->mtu <= 1500 ? PKT_BUF_SZ : dev->mtu + 32);
-	np->rx_head_desc = &np->rx_ring[0];
-
-	for (i = 0; i < RX_RING_SIZE; i++) {
-		np->rx_ring[i].rx_status = 0;
-		np->rx_ring[i].desc_length = cpu_to_le32(np->rx_buf_sz);
-		next += sizeof(struct rx_desc);
-		np->rx_ring[i].next_desc = cpu_to_le32(next);
-		np->rx_skbuff[i] = 0;
-	}
-	/* Mark the last entry as wrapping the ring. */
-	np->rx_ring[i-1].next_desc = cpu_to_le32(np->rx_ring_dma);
-
-	/* Fill in the Rx buffers.  Handle allocation failure gracefully. */
-	for (i = 0; i < RX_RING_SIZE; i++) {
-		struct sk_buff *skb = dev_alloc_skb(np->rx_buf_sz);
-		np->rx_skbuff[i] = skb;
-		if (skb == NULL)
-			break;
-		skb->dev = dev;                 /* Mark as being used by this device. */
-
-		np->rx_skbuff_dma[i] =
-			pci_map_single(np->pdev, skb->tail, np->rx_buf_sz,
-						   PCI_DMA_FROMDEVICE);
-
-		np->rx_ring[i].addr = cpu_to_le32(np->rx_skbuff_dma[i]);
-		np->rx_ring[i].rx_status = cpu_to_le32(DescOwn);
-	}
-	np->dirty_rx = (unsigned int)(i - RX_RING_SIZE);
-
-	next = np->tx_ring_dma;
-	for (i = 0; i < TX_RING_SIZE; i++) {
-		np->tx_skbuff[i] = 0;
-		np->tx_ring[i].tx_status = 0;
-		np->tx_ring[i].desc_length = cpu_to_le32(0x00e08000);
-		next += sizeof(struct tx_desc);
-		np->tx_ring[i].next_desc = cpu_to_le32(next);
-		np->tx_buf[i] = &np->tx_bufs[i * PKT_BUF_SZ];
-	}
-	np->tx_ring[i-1].next_desc = cpu_to_le32(np->tx_ring_dma);
+	/* clear all descriptors */
+	free_tbufs(dev);
+	free_rbufs(dev);
+	alloc_tbufs(dev);
+	alloc_rbufs(dev);
+
+	/* Reinitialize the hardware. */
+	wait_for_reset(dev);
+	init_registers(dev);
+	
+	spin_unlock(&np->lock);
+	enable_irq(np->pdev->irq);
 
-	return;
+	dev->trans_start = jiffies;
+	np->stats.tx_errors++;
+	netif_wake_queue(dev);
 }
 
 static int via_rhine_start_tx(struct sk_buff *skb, struct net_device *dev)
@@ -1215,8 +1324,9 @@
 				   "threshold setting to %2.2x.\n", dev->name, np->tx_thresh);
 	}
 	if ((intr_status & ~( IntrLinkChange | IntrStatsMax |
-						  IntrTxAbort | IntrTxAborted)) && debug > 1) {
-		printk(KERN_ERR "%s: Something Wicked happened! %4.4x.\n",
+						  IntrTxAbort | IntrTxAborted))) {
+		if (debug > 1)
+			printk(KERN_ERR "%s: Something Wicked happened! %4.4x.\n",
 			   dev->name, intr_status);
 		/* Recovery for other fault sources not known. */
 		writew(CmdTxDemand | np->chip_cmd, dev->base_addr + ChipCmd);
@@ -1339,12 +1449,10 @@
 {
 	long ioaddr = dev->base_addr;
 	struct netdev_private *np = (struct netdev_private *)dev->priv;
-	int i;
-	unsigned long flags;
 
 	del_timer_sync(&np->timer);
 
-	spin_lock_irqsave(&np->lock, flags);
+	spin_lock_irq(&np->lock);
 
 	netif_stop_queue(dev);
 
@@ -1361,44 +1469,12 @@
 	/* Stop the chip's Tx and Rx processes. */
 	writew(CmdStop, ioaddr + ChipCmd);
 
-	spin_unlock_irqrestore(&np->lock, flags);
-
-	/* Make sure there is no irq-handler running on a different CPU. */
-	synchronize_irq();
-
-	free_irq(dev->irq, dev);
+	spin_unlock_irq(&np->lock);
 
-	/* Free all the skbuffs in the Rx queue. */
-	for (i = 0; i < RX_RING_SIZE; i++) {
-		np->rx_ring[i].rx_status = 0;
-		np->rx_ring[i].addr = cpu_to_le32(0xBADF00D0); /* An invalid address. */
-		if (np->rx_skbuff[i]) {
-			pci_unmap_single(np->pdev,
-							 np->rx_skbuff_dma[i],
-							 np->rx_buf_sz, PCI_DMA_FROMDEVICE);
-			dev_kfree_skb(np->rx_skbuff[i]);
-		}
-		np->rx_skbuff[i] = 0;
-	}
-
-	/* Free all the skbuffs in the Tx queue, and also any bounce buffers. */
-	for (i = 0; i < TX_RING_SIZE; i++) {
-		np->tx_ring[i].tx_status = 0;
-		np->tx_ring[i].desc_length = cpu_to_le32(0x00e08000);
-		np->tx_ring[i].addr = cpu_to_le32(0xBADF00D0); /* An invalid address. */
-		if (np->tx_skbuff[i]) {
-			if (np->tx_skbuff_dma[i]) {
-				pci_unmap_single(np->pdev,
-								 np->tx_skbuff_dma[i],
-								 np->tx_skbuff[i]->len, PCI_DMA_TODEVICE);
-			}
-			dev_kfree_skb(np->tx_skbuff[i]);
-		}
-		np->tx_skbuff[i] = 0;
-		np->tx_buf[i] = 0;
-	}
-	pci_free_consistent(np->pdev, PKT_BUF_SZ * TX_RING_SIZE,
-						np->tx_bufs, np->tx_bufs_dma);
+	free_irq(np->pdev->irq, dev);
+	free_rbufs(dev);
+	free_tbufs(dev);
+	free_ring(dev);
 
 	return 0;
 }

--------------DAB2B8E26064555CAC9F312F--

