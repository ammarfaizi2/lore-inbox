Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272511AbSIST02>; Thu, 19 Sep 2002 15:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272522AbSIST02>; Thu, 19 Sep 2002 15:26:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13578 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S272511AbSISTZ4>;
	Thu, 19 Sep 2002 15:25:56 -0400
Message-ID: <3D8A25D1.3060300@mandrakesoft.com>
Date: Thu, 19 Sep 2002 15:30:25 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Donald Becker <becker@scyld.com>, Jason Lunz <lunz@falooley.org>,
       Richard Gooch <rgooch@ras.ucalgary.ca>,
       "Patrick R. McManus" <mcmanus@ducksong.com>, edward_peng@dlink.com.tw
Subject: PATCH: sundance #4
References: <Pine.LNX.4.44.0209190903050.29420-100000@beohost.scyld.com>
Content-Type: multipart/mixed;
 boundary="------------050701000103070306000102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050701000103070306000102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

while I was in there, and because it was easy, I ripped out the 
hand-coded ethtool stuff, and modernized a bit.  note that the lines 
that don't appear to have changes are lines which have been stripped of 
trailing whitespace.

Next, the issues that Jason pointed out with the hand-rolled RX polling, 
and the stuff Donald pointed out in his first message.

--------------050701000103070306000102
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/drivers/net/Makefile b/drivers/net/Makefile
--- a/drivers/net/Makefile	Thu Sep 19 15:17:05 2002
+++ b/drivers/net/Makefile	Thu Sep 19 15:17:05 2002
@@ -70,7 +70,7 @@
 obj-$(CONFIG_AIRONET4500_CS)	+= aironet4500_proc.o
 
 obj-$(CONFIG_WINBOND_840) += mii.o
-obj-$(CONFIG_SUNDANCE) += sundance.o
+obj-$(CONFIG_SUNDANCE) += sundance.o mii.o
 obj-$(CONFIG_HAMACHI) += hamachi.o
 obj-$(CONFIG_NET) += Space.o setup.o net_init.o loopback.o
 obj-$(CONFIG_SEEQ8005) += seeq8005.o
diff -Nru a/drivers/net/sundance.c b/drivers/net/sundance.c
--- a/drivers/net/sundance.c	Thu Sep 19 15:17:05 2002
+++ b/drivers/net/sundance.c	Thu Sep 19 15:17:05 2002
@@ -24,11 +24,11 @@
 	Version LK1.02 (D-Link):
 	- Add new board to PCI ID list
 	- Fix multicast bug
-	
+
 	Version LK1.03 (D-Link):
 	- New Rx scheme, reduce Rx congestion
 	- Option to disable flow control
-	
+
 	Version LK1.04 (D-Link):
 	- Tx timeout recovery
 	- More support for ethtool.
@@ -48,10 +48,15 @@
 	- Remove unnecessary cast from void pointer
 	- Re-align comments in private struct
 
+	Version LK1.04c:
+	- Support bitmapped message levels (NETIF_MSG_xxx), and the
+	  two ethtool ioctls that get/set them
+	- Don't hand-code MII ethtool support, use standard API/lib
+
 */
 
 #define DRV_NAME	"sundance"
-#define DRV_VERSION	"1.01+LK1.04b"
+#define DRV_VERSION	"1.01+LK1.04c"
 #define DRV_RELDATE	"19-Sep-2002"
 
 
@@ -85,7 +90,7 @@
 		 3	 	100Mbps half duplex.
 		 4	 	100Mbps full duplex.
 */
-#define MAX_UNITS 8	
+#define MAX_UNITS 8
 static char *media[MAX_UNITS];
 
 
@@ -353,7 +358,7 @@
 enum ASICCtrl_HiWord_bit {
 	GlobalReset = 0x0001,
 	RxReset = 0x0002,
-	TxReset = 0x0004, 
+	TxReset = 0x0004,
 	DMAReset = 0x0008,
 	FIFOReset = 0x0010,
 	NetworkReset = 0x0020,
@@ -423,13 +428,13 @@
 	/* Frequently used values: keep some adjacent for cache effect. */
 	spinlock_t lock;
 	spinlock_t rx_lock;			/* Group with Tx control cache line. */
+	int msg_enable;
 	int chip_id;
 	unsigned int cur_rx, dirty_rx;		/* Producer/consumer ring indices */
 	unsigned int rx_buf_sz;			/* Based on MTU+slack. */
 	struct netdev_desc *last_tx;		/* Last Tx descriptor used. */
 	unsigned int cur_tx, dirty_tx;
 	/* These values are keep track of the transceiver/media in use. */
-	unsigned int full_duplex:1;		/* Full-duplex operation requested. */
 	unsigned int flowctrl:1;
 	unsigned int default_port:4;		/* Last dev->if_port value. */
 	unsigned int an_enable:1;
@@ -440,8 +445,8 @@
 	spinlock_t mcastlock;			/* SMP lock multicast updates. */
 	u16 mcast_filter[4];
 	/* MII transceiver section. */
+	struct mii_if_info mii_if;
 	int mii_preamble_required;
-	u16 advertising;			/* NWay media advertisement */
 	unsigned char phys[MII_CNT];		/* MII device addresses, only first one used. */
 	struct pci_dev *pci_dev;
 };
@@ -472,7 +477,7 @@
 static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static int  netdev_close(struct net_device *dev);
 
-
+
 
 static int __devinit sundance_probe1 (struct pci_dev *pdev,
 				      const struct pci_device_id *ent)
@@ -527,8 +532,9 @@
 	dev->irq = irq;
 
 	np = dev->priv;
-	np->chip_id = chip_idx;
 	np->pci_dev = pdev;
+	np->chip_id = chip_idx;
+	np->msg_enable = (1 << debug) - 1;
 	spin_lock_init(&np->lock);
 	tasklet_init(&np->rx_tasklet, rx_poll, (unsigned long)dev);
 
@@ -544,6 +550,10 @@
 	np->rx_ring = (struct netdev_desc *)ring_space;
 	np->rx_ring_dma = ring_dma;
 
+	np->mii_if.dev = dev;
+	np->mii_if.mdio_read = mdio_read;
+	np->mii_if.mdio_write = mdio_write;
+
 	/* The chip-specific entries in the device structure. */
 	dev->open = &netdev_open;
 	dev->hard_start_xmit = &start_tx;
@@ -576,12 +586,12 @@
 			int mii_status = mdio_read(dev, phy, MII_BMSR);
 			if (mii_status != 0xffff  &&  mii_status != 0x0000) {
 				np->phys[phy_idx++] = phy;
-				np->advertising = mdio_read(dev, phy, MII_ADVERTISE);
+				np->mii_if.advertising = mdio_read(dev, phy, MII_ADVERTISE);
 				if ((mii_status & 0x0040) == 0)
 					np->mii_preamble_required++;
 				printk(KERN_INFO "%s: MII PHY found at address %d, status "
 					   "0x%4.4x advertising %4.4x.\n",
-					   dev->name, phy, mii_status, np->advertising);
+					   dev->name, phy, mii_status, np->mii_if.advertising);
 			}
 		}
 		np->mii_preamble_required--;
@@ -591,6 +601,8 @@
 				   dev->name, readl(ioaddr + ASICCtrl));
 			goto err_out_unmap_rx;
 		}
+
+		np->mii_if.phy_id = np->phys[0];
 	}
 
 	/* Parse override configuration */
@@ -601,24 +613,24 @@
 			if (strcmp (media[card_idx], "100mbps_fd") == 0 ||
 			    strcmp (media[card_idx], "4") == 0) {
 				np->speed = 100;
-				np->full_duplex = 1;
+				np->mii_if.full_duplex = 1;
 			} else if (strcmp (media[card_idx], "100mbps_hd") == 0
 				   || strcmp (media[card_idx], "3") == 0) {
 				np->speed = 100;
-				np->full_duplex = 0;
+				np->mii_if.full_duplex = 0;
 			} else if (strcmp (media[card_idx], "10mbps_fd") == 0 ||
 				   strcmp (media[card_idx], "2") == 0) {
 				np->speed = 10;
-				np->full_duplex = 1;
+				np->mii_if.full_duplex = 1;
 			} else if (strcmp (media[card_idx], "10mbps_hd") == 0 ||
 				   strcmp (media[card_idx], "1") == 0) {
 				np->speed = 10;
-				np->full_duplex = 0;
+				np->mii_if.full_duplex = 0;
 			} else {
 				np->an_enable = 1;
 			}
 		}
-		if (tx_coalesce < 1) 
+		if (tx_coalesce < 1)
 			tx_coalesce = 1;
 		else if (tx_coalesce > TX_QUEUE_LEN - 1)
 			tx_coalesce = TX_QUEUE_LEN - 1;
@@ -631,7 +643,7 @@
 		/* Default 100Mbps Full */
 		if (np->an_enable) {
 			np->speed = 100;
-			np->full_duplex = 1;
+			np->mii_if.full_duplex = 1;
 			np->an_enable = 0;
 		}
 	}
@@ -643,19 +655,19 @@
 	if (!np->an_enable) {
 		mii_ctl = 0;
 		mii_ctl |= (np->speed == 100) ? BMCR_SPEED100 : 0;
-		mii_ctl |= (np->full_duplex) ? BMCR_FULLDPLX : 0;
+		mii_ctl |= (np->mii_if.full_duplex) ? BMCR_FULLDPLX : 0;
 		mdio_write (dev, np->phys[0], MII_BMCR, mii_ctl);
 		printk (KERN_INFO "Override speed=%d, %s duplex\n",
-			np->speed, np->full_duplex ? "Full" : "Half");
+			np->speed, np->mii_if.full_duplex ? "Full" : "Half");
 
 	}
 
 	/* Perhaps move the reset here? */
 	/* Reset the chip to erase previous misconfiguration. */
-	if (debug > 1)
+	if (netif_msg_hw(np))
 		printk("ASIC Control is %x.\n", readl(ioaddr + ASICCtrl));
 	writew(0x007f, ioaddr + ASICCtrl + 2);
-	if (debug > 1)
+	if (netif_msg_hw(np))
 		printk("ASIC Control is now %x.\n", readl(ioaddr + ASICCtrl));
 
 	card_idx++;
@@ -677,7 +689,7 @@
 	return -ENODEV;
 }
 
-
+
 /* Read the EEPROM and MII Management Data I/O (MDIO) interfaces. */
 static int __devinit eeprom_read(long ioaddr, int location)
 {
@@ -793,7 +805,7 @@
 	if (i)
 		return i;
 
-	if (debug > 1)
+	if (netif_msg_ifup(np))
 		printk(KERN_DEBUG "%s: netdev_open() irq %d.\n",
 			   dev->name, dev->irq);
 
@@ -823,7 +835,7 @@
 
 	writew(StatsEnable | RxEnable | TxEnable, ioaddr + MACCtrl1);
 
-	if (debug > 2)
+	if (netif_msg_ifup(np))
 		printk(KERN_DEBUG "%s: Done netdev_open(), status: Rx %x Tx %x "
 			   "MAC Control %x, %4.4x %4.4x.\n",
 			   dev->name, readl(ioaddr + RxStatus), readb(ioaddr + TxStatus),
@@ -836,7 +848,7 @@
 	np->timer.data = (unsigned long)dev;
 	np->timer.function = &netdev_timer;				/* timer handler */
 	add_timer(&np->timer);
-	
+
 	/* Enable interrupts by setting the interrupt mask. */
 	writew(DEFAULT_INTR, ioaddr + IntrEnable);
 
@@ -848,21 +860,22 @@
 	struct netdev_private *np = dev->priv;
 	long ioaddr = dev->base_addr;
 	int mii_lpa = mdio_read(dev, np->phys[0], MII_LPA);
-	int negotiated = mii_lpa & np->advertising;
+	int negotiated = mii_lpa & np->mii_if.advertising;
 	int duplex;
-	
+
 	/* Force media */
 	if (!np->an_enable || mii_lpa == 0xffff) {
-		if (np->full_duplex)
+		if (np->mii_if.full_duplex)
 			writew (readw (ioaddr + MACCtrl0) | EnbFullDuplex,
 				ioaddr + MACCtrl0);
 		return;
 	}
+
 	/* Autonegotiation */
 	duplex = (negotiated & 0x0100) || (negotiated & 0x01C0) == 0x0040;
-	if (np->full_duplex != duplex) {
-		np->full_duplex = duplex;
-		if (debug)
+	if (np->mii_if.full_duplex != duplex) {
+		np->mii_if.full_duplex = duplex;
+		if (netif_msg_link(np))
 			printk(KERN_INFO "%s: Setting %s-duplex based on MII #%d "
 				   "negotiated capability %4.4x.\n", dev->name,
 				   duplex ? "full" : "half", np->phys[0], negotiated);
@@ -877,7 +890,7 @@
 	long ioaddr = dev->base_addr;
 	int next_tick = 10*HZ;
 
-	if (debug > 3) {
+	if (netif_msg_timer(np)) {
 		printk(KERN_DEBUG "%s: Media selection timer tick, intr status %4.4x, "
 			   "Tx %x Rx %x.\n",
 			   dev->name, readw(ioaddr + IntrEnable),
@@ -941,7 +954,7 @@
 
 	/* Initialize all Rx descriptors. */
 	for (i = 0; i < RX_RING_SIZE; i++) {
-		np->rx_ring[i].next_desc = cpu_to_le32(np->rx_ring_dma + 
+		np->rx_ring[i].next_desc = cpu_to_le32(np->rx_ring_dma +
 			((i+1)%RX_RING_SIZE)*sizeof(*np->rx_ring));
 		np->rx_ring[i].status = 0;
 		np->rx_ring[i].frag[0].length = 0;
@@ -957,7 +970,7 @@
 		skb->dev = dev;		/* Mark as being used by this device. */
 		skb_reserve(skb, 2);	/* 16 byte align the IP header. */
 		np->rx_ring[i].frag[0].addr = cpu_to_le32(
-			pci_map_single(np->pci_dev, skb->tail, np->rx_buf_sz, 
+			pci_map_single(np->pci_dev, skb->tail, np->rx_buf_sz,
 				PCI_DMA_FROMDEVICE));
 		np->rx_ring[i].frag[0].length = cpu_to_le32(np->rx_buf_sz | LastFrag);
 	}
@@ -988,9 +1001,9 @@
 	txdesc->next_desc = 0;
 	/* Note: disable the interrupt generation here before releasing. */
 	if (entry % tx_coalesce == 0) {
-		txdesc->status = cpu_to_le32 ((entry << 2) | 
+		txdesc->status = cpu_to_le32 ((entry << 2) |
 				 DescIntrOnTx | DisableAlign);
-	
+
 	} else {
 		txdesc->status = cpu_to_le32 ((entry << 2) | DisableAlign);
 	}
@@ -1005,7 +1018,7 @@
 	np->cur_tx++;
 
 	/* On some architectures: explicitly flush cache lines here. */
-	if (np->cur_tx - np->dirty_tx < TX_QUEUE_LEN - 1 
+	if (np->cur_tx - np->dirty_tx < TX_QUEUE_LEN - 1
 			&& !netif_queue_stopped(dev)) {
 		/* do nothing */
 	} else {
@@ -1018,7 +1031,7 @@
 
 	dev->trans_start = jiffies;
 
-	if (debug > 4) {
+	if (netif_msg_tx_queued(np)) {
 		printk (KERN_DEBUG
 			"%s: Transmit frame #%d queued in slot %d.\n",
 			dev->name, np->cur_tx, entry);
@@ -1034,7 +1047,7 @@
 	long ioaddr = dev->base_addr;
 	int i;
 	int frame_id;
-	
+
 	frame_id = readb(ioaddr + TxFrameId);
 	writew (TxReset | DMAReset | FIFOReset | NetworkReset,
 			ioaddr + ASICCtrl + 2);
@@ -1050,8 +1063,8 @@
 			break;
 		skb = np->tx_skbuff[entry];
 		/* Free the original skb. */
-		pci_unmap_single(np->pci_dev, 
-			np->tx_ring[entry].frag[0].addr, 
+		pci_unmap_single(np->pci_dev,
+			np->tx_ring[entry].frag[0].addr,
 			skb->len, PCI_DMA_TODEVICE);
 		if (irq)
 			dev_kfree_skb_irq (np->tx_skbuff[entry]);
@@ -1081,7 +1094,7 @@
 		int intr_status = readw(ioaddr + IntrStatus);
 		writew(intr_status, ioaddr + IntrStatus);
 
-		if (debug > 4)
+		if (netif_msg_intr(np))
 			printk(KERN_DEBUG "%s: Interrupt, status %4.4x.\n",
 				   dev->name, intr_status);
 
@@ -1089,7 +1102,7 @@
 			break;
 
 		if (intr_status & (IntrRxDMADone)) {
-			writew(DEFAULT_INTR & ~(IntrRxDone|IntrRxDMADone), 
+			writew(DEFAULT_INTR & ~(IntrRxDone|IntrRxDMADone),
 					ioaddr + IntrEnable);
 			if (np->budget < 0)
 				np->budget = RX_BUDGET;
@@ -1100,7 +1113,7 @@
 			int boguscnt = 32;
 			int tx_status = readw (ioaddr + TxStatus);
 			while (tx_status & 0x80) {
-				if (debug > 4)
+				if (netif_msg_tx_done(np))
 					printk
 					    ("%s: Transmit status is %2.2x.\n",
 					     dev->name, tx_status);
@@ -1138,14 +1151,14 @@
 				break;
 			skb = np->tx_skbuff[entry];
 			/* Free the original skb. */
-			pci_unmap_single(np->pci_dev, 
-				np->tx_ring[entry].frag[0].addr, 
+			pci_unmap_single(np->pci_dev,
+				np->tx_ring[entry].frag[0].addr,
 				skb->len, PCI_DMA_TODEVICE);
 			dev_kfree_skb_irq (np->tx_skbuff[entry]);
 			np->tx_skbuff[entry] = 0;
 		}
 		spin_unlock(&np->lock);
-		if (netif_queue_stopped(dev) && 
+		if (netif_queue_stopped(dev) &&
 			np->cur_tx - np->dirty_tx < TX_QUEUE_LEN - 4) {
 			/* The ring is no longer full, clear tbusy. */
 			netif_wake_queue (dev);
@@ -1156,14 +1169,14 @@
 			netdev_error(dev, intr_status);
 		if (--boguscnt < 0) {
 			get_stats(dev);
-			if (debug > 1) 
+			if (netif_msg_hw(np))
 				printk(KERN_WARNING "%s: Too much work at interrupt, "
 				   "status=0x%4.4x / 0x%4.4x.\n",
 				   dev->name, intr_status, readw(ioaddr + IntrClear));
 			break;
 		}
 	} while (1);
-	if (debug > 3)
+	if (netif_msg_intr(np))
 		printk(KERN_DEBUG "%s: exiting interrupt, status=%#4.4x.\n",
 			   dev->name, readw(ioaddr + IntrStatus));
 	if (np->cur_tx - np->dirty_tx > 0 && tx_coalesce > 1)
@@ -1192,15 +1205,15 @@
 		if (!(desc->status & DescOwn))
 			break;
 		pkt_len = frame_status & 0x1fff;	/* Chip omits the CRC. */
-		if (debug > 4)
+		if (netif_msg_rx_status(np))
 			printk(KERN_DEBUG "  netdev_rx() status was %8.8x.\n",
 				   frame_status);
 		pci_dma_sync_single(np->pci_dev, desc->frag[0].addr,
 			np->rx_buf_sz, PCI_DMA_FROMDEVICE);
-		
+
 		if (frame_status & 0x001f4000) {
 			/* There was a error. */
-			if (debug > 2)
+			if (netif_msg_rx_err(np))
 				printk(KERN_DEBUG "  netdev_rx() Rx error was %8.8x.\n",
 					   frame_status);
 			np->stats.rx_errors++;
@@ -1216,7 +1229,7 @@
 		} else {
 			struct sk_buff *skb;
 #ifndef final_version
-			if (debug > 4)
+			if (netif_msg_rx_status(np))
 				printk(KERN_DEBUG "  netdev_rx() normal Rx pkt length %d"
 					   ", bogus_cnt %d.\n",
 					   pkt_len, boguscnt);
@@ -1230,9 +1243,9 @@
 				eth_copy_and_sum(skb, np->rx_skbuff[entry]->tail, pkt_len, 0);
 				skb_put(skb, pkt_len);
 			} else {
-				pci_unmap_single(np->pci_dev, 
+				pci_unmap_single(np->pci_dev,
 					desc->frag[0].addr,
-					np->rx_buf_sz, 
+					np->rx_buf_sz,
 					PCI_DMA_FROMDEVICE);
 				skb_put(skb = np->rx_skbuff[entry], pkt_len);
 				np->rx_skbuff[entry] = NULL;
@@ -1251,7 +1264,7 @@
 	writew(DEFAULT_INTR, ioaddr + IntrEnable);
 	return;
 
-not_done:	
+not_done:
 	np->cur_rx = entry;
 	refill_rx (dev);
 	if (!received)
@@ -1282,7 +1295,7 @@
 			skb->dev = dev;		/* Mark as being used by this device. */
 			skb_reserve(skb, 2);	/* Align IP on 16 byte boundaries */
 			np->rx_ring[entry].frag[0].addr = cpu_to_le32(
-				pci_map_single(np->pci_dev, skb->tail, 
+				pci_map_single(np->pci_dev, skb->tail,
 					np->rx_buf_sz, PCI_DMA_FROMDEVICE));
 		}
 		/* Perhaps we need not reset this field. */
@@ -1299,7 +1312,7 @@
 	struct netdev_private *np = dev->priv;
 	u16 mii_ctl, mii_advertise, mii_lpa;
 	int speed;
-	
+
 	if (intr_status & LinkChange) {
 		if (np->an_enable) {
 			mii_advertise = mdio_read (dev, np->phys[0], MII_ADVERTISE);
@@ -1417,12 +1430,12 @@
 {
 	struct netdev_private *np = dev->priv;
 	u32 ethcmd;
-	long ioaddr = dev->base_addr;
-	
+
 	if (copy_from_user(&ethcmd, useraddr, sizeof(ethcmd)))
 		return -EFAULT;
 
         switch (ethcmd) {
+		/* get constant driver settings/info */
         	case ETHTOOL_GDRVINFO: {
 			struct ethtool_drvinfo info = {ETHTOOL_GDRVINFO};
 			strcpy(info.driver, DRV_NAME);
@@ -1433,116 +1446,60 @@
 				return -EFAULT;
 			return 0;
 		}
-		case ETHTOOL_GSET: {
-			struct ethtool_cmd cmd = { ETHTOOL_GSET };
-			if (readl (ioaddr + ASICCtrl) & 0x80) {
-				/* fiber device */
-				cmd.supported = SUPPORTED_Autoneg | 
-							SUPPORTED_FIBRE;
-				cmd.advertising= ADVERTISED_Autoneg |
-							ADVERTISED_FIBRE;
-				cmd.port = PORT_FIBRE;
-				cmd.transceiver = XCVR_INTERNAL;	
-			} else {
-				/* copper device */
-				cmd.supported = SUPPORTED_10baseT_Half | 
-					SUPPORTED_10baseT_Full |
-				       	SUPPORTED_100baseT_Half	|
-				       	SUPPORTED_100baseT_Full | 
-					SUPPORTED_Autoneg | 
-					SUPPORTED_MII;
-				cmd.advertising = ADVERTISED_10baseT_Half |
-						ADVERTISED_10baseT_Full |
-				       		ADVERTISED_100baseT_Half |
-						ADVERTISED_100baseT_Full | 
-						ADVERTISED_Autoneg |
-				       		ADVERTISED_MII;
-				cmd.port = PORT_MII;
-				cmd.transceiver = XCVR_INTERNAL;
-			}
-			if (readb(ioaddr + MIICtrl) & 0x80) {
-				cmd.speed = np->speed;
-				cmd.duplex = np->full_duplex ? 
-						    DUPLEX_FULL : DUPLEX_HALF;
-			} else {
-				cmd.speed = -1;
-				cmd.duplex = -1;
-			}
-			if ( np->an_enable)
-				cmd.autoneg = AUTONEG_ENABLE;
-			else
-				cmd.autoneg = AUTONEG_DISABLE;
-			
-			cmd.phy_address = np->phys[0];
 
-			if (copy_to_user(useraddr, &cmd,
-					sizeof(cmd)))
+		/* get media settings */
+		case ETHTOOL_GSET: {
+			struct ethtool_cmd ecmd = { ETHTOOL_GSET };
+			spin_lock_irq(&np->lock);
+			mii_ethtool_gset(&np->mii_if, &ecmd);
+			spin_unlock_irq(&np->lock);
+			if (copy_to_user(useraddr, &ecmd, sizeof(ecmd)))
 				return -EFAULT;
-			return 0;				   
+			return 0;
 		}
+		/* set media settings */
 		case ETHTOOL_SSET: {
-			struct ethtool_cmd cmd;
-			if (copy_from_user(&cmd, useraddr, sizeof(cmd)))
+			int r;
+			struct ethtool_cmd ecmd;
+			if (copy_from_user(&ecmd, useraddr, sizeof(ecmd)))
 				return -EFAULT;
-			netif_carrier_off(dev);
-			if (cmd.autoneg == AUTONEG_ENABLE) {
-				if (np->an_enable)
-					return 0;
-				else {
-					np->an_enable = 1;
-					/* Reset PHY */
-					mdio_write (dev, np->phys[0], MII_BMCR,
-						       		BMCR_RESET);
-					mdelay (300);
-					/* Start auto negotiation */
-					mdio_write (dev, np->phys[0], MII_BMCR,
-					      	BMCR_ANENABLE|BMCR_ANRESTART);
-					return 0;	
-				}	
-			} else {
-				/* Reset PHY */
-				mdio_write (dev, np->phys[0], MII_BMCR, 
-								BMCR_RESET);
-				mdelay (300);
-				np->an_enable = 0;
-				switch(cmd.speed + cmd.duplex){
-				
-					case SPEED_10 + DUPLEX_HALF:
-						np->speed = 10;
-						np->full_duplex = 0;
-						break;
-					case SPEED_10 + DUPLEX_FULL:
-						np->speed = 10;
-						np->full_duplex = 1;
-						break;
-					case SPEED_100 + DUPLEX_HALF:
-						np->speed = 100;
-						np->full_duplex = 0;
-						break;
-					case SPEED_100 + DUPLEX_FULL:
-						np->speed = 100;
-						np->full_duplex = 1;
-						break;
-				
-				default:
-					return -EINVAL;	
-				}
-		mdio_write (dev, np->phys[0], MII_BMCR,
-				((np->speed == 100) ? BMCR_SPEED100 : 0) | 
-				((np->full_duplex) ? BMCR_FULLDPLX : 0) );
+			spin_lock_irq(&np->lock);
+			r = mii_ethtool_sset(&np->mii_if, &ecmd);
+			spin_unlock_irq(&np->lock);
+			return r;
+		}
+
+		/* restart autonegotiation */
+		case ETHTOOL_NWAY_RST: {
+			return mii_nway_restart(&np->mii_if);
+		}
+
+		/* get link status */
+		case ETHTOOL_GLINK: {
+			struct ethtool_value edata = {ETHTOOL_GLINK};
+			edata.data = mii_link_ok(&np->mii_if);
+			if (copy_to_user(useraddr, &edata, sizeof(edata)))
+				return -EFAULT;
+			return 0;
+		}
 
-			}
-		return 0;		   
+		/* get message-level */
+		case ETHTOOL_GMSGLVL: {
+			struct ethtool_value edata = {ETHTOOL_GMSGLVL};
+			edata.data = np->msg_enable;
+			if (copy_to_user(useraddr, &edata, sizeof(edata)))
+				return -EFAULT;
+			return 0;
 		}
-#ifdef	ETHTOOL_GLINK
-		case ETHTOOL_GLINK:{
-		struct ethtool_value link = { ETHTOOL_GLINK };
-		link.data = readb(ioaddr + MIICtrl) & 0x80;
-		if (copy_to_user(useraddr, &link, sizeof(link)))
-			return -EFAULT;
-		return 0;
-		}			   
-#endif
+		/* set message-level */
+		case ETHTOOL_SMSGLVL: {
+			struct ethtool_value edata;
+			if (copy_from_user(&edata, useraddr, sizeof(edata)))
+				return -EFAULT;
+			np->msg_enable = edata.data;
+			return 0;
+		}
+
 		default:
 		return -EOPNOTSUPP;
 
@@ -1583,7 +1540,7 @@
 
 	netif_stop_queue(dev);
 
-	if (debug > 1) {
+	if (netif_msg_ifdown(np)) {
 		printk(KERN_DEBUG "%s: Shutting down ethercard, status was Tx %2.2x "
 			   "Rx %4.4x Int %2.2x.\n",
 			   dev->name, readb(ioaddr + TxStatus),
@@ -1599,7 +1556,7 @@
 	writew(TxDisable | RxDisable | StatsDisable, ioaddr + MACCtrl1);
 
 #ifdef __i386__
-	if (debug > 2) {
+	if (netif_msg_hw(np)) {
 		printk("\n"KERN_DEBUG"  Tx ring at %8.8x:\n",
 			   (int)(np->tx_ring_dma));
 		for (i = 0; i < TX_RING_SIZE; i++)
@@ -1626,8 +1583,8 @@
 		np->rx_ring[i].frag[0].addr = 0xBADF00D0; /* An invalid address. */
 		skb = np->rx_skbuff[i];
 		if (skb) {
-			pci_unmap_single(np->pci_dev, 
-				np->rx_ring[i].frag[0].addr, np->rx_buf_sz, 
+			pci_unmap_single(np->pci_dev,
+				np->rx_ring[i].frag[0].addr, np->rx_buf_sz,
 				PCI_DMA_FROMDEVICE);
 			dev_kfree_skb(skb);
 			np->rx_skbuff[i] = 0;
@@ -1636,7 +1593,7 @@
 	for (i = 0; i < TX_RING_SIZE; i++) {
 		skb = np->tx_skbuff[i];
 		if (skb) {
-			pci_unmap_single(np->pci_dev, 
+			pci_unmap_single(np->pci_dev,
 				np->tx_ring[i].frag[0].addr, skb->len,
 				PCI_DMA_TODEVICE);
 			dev_kfree_skb(skb);
@@ -1650,15 +1607,15 @@
 static void __devexit sundance_remove1 (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
-	
+
 	/* No need to check MOD_IN_USE, as sys_delete_module() checks. */
 	if (dev) {
 		struct netdev_private *np = dev->priv;
 
 		unregister_netdev(dev);
-        	pci_free_consistent(pdev, RX_TOTAL_SIZE, np->rx_ring, 
+        	pci_free_consistent(pdev, RX_TOTAL_SIZE, np->rx_ring,
 			np->rx_ring_dma);
-	        pci_free_consistent(pdev, TX_TOTAL_SIZE, np->tx_ring, 
+	        pci_free_consistent(pdev, TX_TOTAL_SIZE, np->tx_ring,
 			np->tx_ring_dma);
 		pci_release_regions(pdev);
 #ifndef USE_IO_OPS

--------------050701000103070306000102--

