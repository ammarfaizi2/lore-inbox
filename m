Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263139AbRFECpQ>; Mon, 4 Jun 2001 22:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263124AbRFECpH>; Mon, 4 Jun 2001 22:45:07 -0400
Received: from age.cs.columbia.edu ([128.59.22.100]:19726 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S263139AbRFECox>; Mon, 4 Jun 2001 22:44:53 -0400
Date: Mon, 4 Jun 2001 19:44:40 -0700 (PDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Starfire driver updates
Message-ID: <Pine.LNX.4.33.0106041936280.20333-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

The patch below updates the starfire driver to support zerocopy operations
and adds full ethtool support. It also adds a small perl utility (already
present in the -ac tree) people can use to generate the firmware header
file from Adaptec's own Netware drivers.

Please apply..

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-----------------------
--- /src/vanilla/linux-2.4-jg/drivers/net/starfire.c	Thu May 31 23:38:19 2001
+++ linux-2.4/drivers/net/starfire.c	Mon Jun  4 19:12:05 2001
@@ -2,6 +2,10 @@
 /*
 	Written 1998-2000 by Donald Becker.
 
+	Current maintainer is Ion Badulescu <ionut@cs.columbia.edu>. Please
+	send all bug reports to me, and not to Donald Becker, as this code
+	has been modified quite a bit from Donald's original version.
+
 	This software may be used and distributed according to the terms of
 	the GNU General Public License (GPL), incorporated herein by reference.
 	Drivers based on or derived from this code fall under the GPL and must
@@ -70,15 +74,20 @@
 	LK1.2.9a (Ion Badulescu)
 	- More updates from Jeff Garzik
 
+	LK1.3.0 (Ion Badulescu)
+	- Merged zerocopy support
+
+	LK1.3.1 (Ion Badulescu)
+	- Added ethtool support
+	- Added GPIO (media change) interrupt support
+
 TODO:
 	- implement tx_timeout() properly
-	- support ethtool
 */
 
 #define DRV_NAME	"starfire"
-#define DRV_VERSION	"1.03+LK1.2.9"
-#define DRV_RELDATE	"April 19, 2001"
-
+#define DRV_VERSION	"1.03+LK1.3.1"
+#define DRV_RELDATE	"June 04, 2001"
 
 /*
  * Adaptec's license for their Novell drivers (which is where I got the
@@ -87,7 +96,7 @@
  *
  * However, an end-user is allowed to download and use it, after
  * converting it to C header files using starfire_firmware.pl.
- * Once that's done, the #undef must be changed into a #define
+ * Once that's done, the #undef below must be changed into a #define
  * for this driver to really use the firmware. Note that Rx/Tx
  * hardware TCP checksumming is not possible without the firmware.
  *
@@ -100,6 +109,12 @@
  * of length 1. If and when this is fixed, the #define below can be removed.
  */
 #define HAS_BROKEN_FIRMWARE
+/*
+ * Define this if using the driver with the zero-copy patch
+ */
+#if defined(HAS_FIRMWARE) && defined(MAX_SKB_FRAGS)
+#define ZEROCOPY
+#endif
 
 /* The user-configurable values.
    These may be modified when a driver module is loaded.*/
@@ -138,8 +153,8 @@
    The media type is usually passed in 'options[]'.
 */
 #define MAX_UNITS 8		/* More are supported, limit only on options */
-static int options[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
-static int full_duplex[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
+static int options[MAX_UNITS] = {0, };
+static int full_duplex[MAX_UNITS] = {0, };
 
 /* Operational parameters that are set at compile time. */
 
@@ -155,9 +170,23 @@
 
 /* Operational parameters that usually are not changed. */
 /* Time in jiffies before concluding the transmitter is hung. */
-#define TX_TIMEOUT	(2*HZ)
+#define TX_TIMEOUT	(2 * HZ)
 
+#ifdef ZEROCOPY
+#if MAX_SKB_FRAGS <= 6
+#define MAX_STARFIRE_FRAGS 6
+#else  /* MAX_STARFIRE_FRAGS > 6 */
+#warning This driver will not work with more than 6 skb fragments.
+#warning Turning off zerocopy support.
+#undef ZEROCOPY
+#endif /* MAX_STARFIRE_FRAGS > 6 */
+#endif /* ZEROCOPY */
+
+#ifdef ZEROCOPY
+#define skb_first_frag_len(skb)	skb_headlen(skb)
+#else  /* not ZEROCOPY */
 #define skb_first_frag_len(skb)	(skb->len)
+#endif /* not ZEROCOPY */
 
 #if !defined(__OPTIMIZE__)
 #warning  You must compile this file with the correct options!
@@ -180,22 +209,25 @@
 #include <linux/skbuff.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-#include <linux/ethtool.h>
-#include <asm/uaccess.h>
 #include <asm/processor.h>		/* Processor type for cache alignment. */
 #include <asm/bitops.h>
 #include <asm/io.h>
+#include <asm/uaccess.h>
 
-/* These identify the driver base version and may not be removed. */
-static char version[] __devinitdata =
-KERN_INFO DRV_NAME ".c:v1.03 7/26/2000  Written by Donald Becker <becker@scyld.com>\n"
-KERN_INFO " Updates and info at http://www.scyld.com/network/starfire.html\n"
-KERN_INFO " (unofficial 2.4.x kernel port, version " DRV_VERSION ", " DRV_RELDATE ")\n";
+#ifdef SIOCETHTOOL
+#include <linux/ethtool.h>
+#endif
 
 #ifdef HAS_FIRMWARE
 #include "starfire_firmware.h"
 #endif /* HAS_FIRMWARE */
 
+/* These identify the driver base version and may not be removed. */
+static char version[] __devinitdata =
+KERN_INFO "starfire.c:v1.03 7/26/2000  Written by Donald Becker <becker@scyld.com>\n"
+KERN_INFO " Updates and info at http://www.scyld.com/network/starfire.html\n"
+KERN_INFO " (unofficial 2.4.x kernel port, version " DRV_VERSION ", " DRV_RELDATE ")\n";
+
 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
 MODULE_DESCRIPTION("Adaptec Starfire Ethernet driver");
 MODULE_PARM(max_interrupt_work, "i");
@@ -242,7 +274,7 @@
 each structure.  There are far too many to document here.
 
 For transmit this driver uses type 0/1 transmit descriptors (depending
-on the presence of the zerocopy patches), and relies on automatic
+on the presence of the zerocopy infrastructure), and relies on automatic
 minimum-length padding.  It does not use the completion queue
 consumer index, but instead checks for non-zero status entries.
 
@@ -258,7 +290,7 @@
 phase of receive.
 
 A notable aspect of operation is that unaligned buffers are not permitted by
-the Starfire hardware.  The IP header at offset 14 in an ethernet frame thus
+the Starfire hardware.  Thus the IP header at offset 14 in an ethernet frame
 isn't longword aligned, which may cause problems on some machine
 e.g. Alphas and IA64. For these architectures, the driver is forced to copy
 the frame into a new skbuff unconditionally. Copied frames are put into the
@@ -357,7 +389,7 @@
 	PCIDeviceConfig=0x50040, GenCtrl=0x50070, IntrTimerCtrl=0x50074,
 	IntrClear=0x50080, IntrStatus=0x50084, IntrEnable=0x50088,
 	MIICtrl=0x52000, StationAddr=0x50120, EEPROMCtrl=0x51000,
-	TxDescCtrl=0x50090,
+	GPIOCtrl=0x5008C, TxDescCtrl=0x50090,
 	TxRingPtr=0x50098, HiPriTxRingPtr=0x50094, /* Low and High priority. */
 	TxRingHiAddr=0x5009C,		/* 64 bit address extension. */
 	TxProducerIdx=0x500A0, TxConsumerIdx=0x500A4,
@@ -459,11 +491,28 @@
 	RxOK=0x20000000, RxFIFOErr=0x10000000, RxBufQ2=0x08000000,
 };
 
+#ifdef ZEROCOPY
+/* Type 0 Tx descriptor. */
+/* If more fragments are needed, don't forget to change the
+   descriptor spacing as well! */
+struct starfire_tx_desc {
+	u32 status;
+	u32 nbufs;
+	u32 first_addr;
+	u16 first_len;
+	u16 total_len;
+	struct {
+		u32 addr;
+		u32 len;
+	} frag[MAX_STARFIRE_FRAGS];
+};
+#else  /* not ZEROCOPY */
 /* Type 1 Tx descriptor. */
 struct starfire_tx_desc {
 	u32 status;			/* Upper bits are status, lower 16 length. */
 	u32 first_addr;
 };
+#endif /* not ZEROCOPY */
 enum tx_desc_bits {
 	TxDescID=0xB0000000,
 	TxCRCEn=0x01000000, TxDescIntr=0x08000000,
@@ -483,6 +532,9 @@
 struct tx_ring_info {
 	struct sk_buff *skb;
 	dma_addr_t first_mapping;
+#ifdef ZEROCOPY
+	dma_addr_t frag_mapping[MAX_STARFIRE_FRAGS];
+#endif /* ZEROCOPY */
 };
 
 #define MII_CNT		2
@@ -495,41 +547,37 @@
 	/* The addresses of rx/tx-in-place skbuffs. */
 	struct rx_ring_info rx_info[RX_RING_SIZE];
 	struct tx_ring_info tx_info[TX_RING_SIZE];
-	/* Pointers to completion queues (full pages).  I should cache line pad..*/
-	u8 pad0[100];
+	/* Pointers to completion queues (full pages). */
 	struct rx_done_desc *rx_done_q;
 	dma_addr_t rx_done_q_dma;
 	unsigned int rx_done;
 	struct tx_done_report *tx_done_q;
-	unsigned int tx_done;
 	dma_addr_t tx_done_q_dma;
+	unsigned int tx_done;
 	struct net_device_stats stats;
-	struct timer_list timer;	/* Media monitoring timer. */
 	struct pci_dev *pci_dev;
 	/* Frequently used values: keep some adjacent for cache effect. */
 	unsigned int cur_rx, dirty_rx;	/* Producer/consumer ring indices */
 	unsigned int cur_tx, dirty_tx;
 	unsigned int rx_buf_sz;		/* Based on MTU+slack. */
-	unsigned int tx_full:1;		/* The Tx queue is full. */
+	unsigned int tx_full:1,		/* The Tx queue is full. */
 	/* These values are keep track of the transceiver/media in use. */
-	unsigned int full_duplex:1,	/* Full-duplex operation requested. */
-		medialock:1,		/* Xcvr set to fixed speed/duplex. */
-		rx_flowctrl:1,
-		tx_flowctrl:1;		/* Use 802.3x flow control. */
-	unsigned int default_port:4;	/* Last dev->if_port value. */
+		autoneg:1,		/* Autonegotiation allowed. */
+		full_duplex:1,		/* Full-duplex operation. */
+		speed100:1;		/* Set if speed == 100MBit. */
+	unsigned int intr_mitigation;
 	u32 tx_mode;
 	u8 tx_threshold;
 	/* MII transceiver section. */
-	int mii_cnt;			/* MII device addresses. */
 	u16 advertising;		/* NWay media advertisement */
+	int mii_cnt;			/* MII device addresses. */
 	unsigned char phys[MII_CNT];	/* MII device addresses. */
 };
 
 static int	mdio_read(struct net_device *dev, int phy_id, int location);
 static void	mdio_write(struct net_device *dev, int phy_id, int location, int value);
 static int	netdev_open(struct net_device *dev);
-static void	check_duplex(struct net_device *dev, int startup);
-static void	netdev_timer(unsigned long data);
+static void	check_duplex(struct net_device *dev);
 static void	tx_timeout(struct net_device *dev);
 static void	init_ring(struct net_device *dev);
 static int	start_tx(struct sk_buff *skb, struct net_device *dev);
@@ -541,6 +589,7 @@
 static struct net_device_stats *get_stats(struct net_device *dev);
 static int	netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static int	netdev_close(struct net_device *dev);
+static void	netdev_media_change(struct net_device *dev);
 
 
 
@@ -554,6 +603,7 @@
 	long ioaddr;
 	int drv_flags, io_size;
 	int boguscnt;
+	u8 cache;
 
 /* when built into the kernel, we only print version if device is found */
 #ifndef MODULE
@@ -563,7 +613,6 @@
 #endif
 
 	card_idx++;
-	option = card_idx < MAX_UNITS ? options[card_idx] : 0;
 
 	if (pci_enable_device (pdev))
 		return -EIO;
@@ -598,6 +647,24 @@
 
 	pci_set_master (pdev);
 
+	/* set PCI cache size */
+	pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &cache);
+	if ((cache << 2) != SMP_CACHE_BYTES) {
+		printk(KERN_INFO "  PCI cache line size set incorrectly "
+		       "(%i bytes) by BIOS/FW, correcting to %i\n",
+		       (cache << 2), SMP_CACHE_BYTES);
+		pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE,
+				      SMP_CACHE_BYTES >> 2);
+	}
+
+#ifdef ZEROCOPY
+	/* Starfire can do SG and TCP/UDP checksumming */
+	dev->features |= NETIF_F_SG;
+#ifdef HAS_FIRMWARE
+	dev->features |= NETIF_F_IP_CSUM;
+#endif /* HAS_FIRMWARE */
+#endif /* ZEROCOPY */
+
 	/* Serial EEPROM reads are hidden by the hardware. */
 	for (i = 0; i < 6; i++)
 		dev->dev_addr[i] = readb(ioaddr + EEPROMCtrl + 20-i);
@@ -637,22 +704,22 @@
 	np->pci_dev = pdev;
 	drv_flags = netdrv_tbl[chip_idx].drv_flags;
 
+	option = card_idx < MAX_UNITS ? options[card_idx] : 0;
 	if (dev->mem_start)
 		option = dev->mem_start;
 
 	/* The lower four bits are the media type. */
-	if (option > 0) {
-		if (option & 0x200)
-			np->full_duplex = 1;
-		np->default_port = option & 15;
-		if (np->default_port)
-			np->medialock = 1;
-	}
+	if (option & 0x200)
+		np->full_duplex = 1;
+
 	if (card_idx < MAX_UNITS && full_duplex[card_idx] > 0)
 		np->full_duplex = 1;
 
 	if (np->full_duplex)
-		np->medialock = 1;
+		np->autoneg = 0;
+	else
+		np->autoneg = 1;
+	np->speed100 = 1;
 
 	/* The chip-specific entries in the device structure. */
 	dev->open = &netdev_open;
@@ -801,12 +868,21 @@
 	       RxDescSpace4,
 	       ioaddr + RxDescQCtrl);
 
+#ifdef ZEROCOPY
+	/* Set Tx descriptor to type 0 and spacing to 64 bytes. */
+	writel((2 << TxHiPriFIFOThreshShift) |
+	       (0 << TxPadLenShift) |
+	       (4 << TxDMABurstSizeShift) |
+	       TxDescSpace64 | TxDescType0,
+	       ioaddr + TxDescCtrl);
+#else  /* not ZEROCOPY */
 	/* Set Tx descriptor to type 1 and padding to 0 bytes. */
 	writel((2 << TxHiPriFIFOThreshShift) |
 	       (0 << TxPadLenShift) |
 	       (4 << TxDMABurstSizeShift) |
 	       TxDescSpaceUnlim | TxDescType1,
 	       ioaddr + TxDescCtrl);
+#endif /* not ZEROCOPY */
 
 #if defined(ADDR_64BITS) && defined(__alpha__)
 	/* XXX We really need a 64-bit PCI dma interfaces too... -DaveM */
@@ -856,13 +932,13 @@
 
 	/* Initialize other registers. */
 	/* Configure the PCI bus bursts and FIFO thresholds. */
-	np->tx_mode = 0;			/* Initialized when TxMode set. */
+	np->tx_mode = 0x0C04;		/* modified when link is up. */
 	np->tx_threshold = 4;
 	writel(np->tx_threshold, ioaddr + TxThreshold);
-	writel(interrupt_mitigation, ioaddr + IntrTimerCtrl);
 
-	if (dev->if_port == 0)
-		dev->if_port = np->default_port;
+	interrupt_mitigation &= 0x1f;
+	np->intr_mitigation = interrupt_mitigation;
+	writel(np->intr_mitigation, ioaddr + IntrTimerCtrl);
 
 	netif_start_if(dev);
 	netif_start_queue(dev);
@@ -872,7 +948,10 @@
 	set_rx_mode(dev);
 
 	np->advertising = mdio_read(dev, np->phys[0], 4);
-	check_duplex(dev, 1);
+	check_duplex(dev);
+
+	/* Enable GPIO interrupts on link change */
+	writel(0x0f00ff00, ioaddr + GPIOCtrl);
 
 	/* Set the interrupt mask and enable PCI interrupts. */
 	writel(IntrRxDone | IntrRxEmpty | IntrDMAErr |
@@ -900,77 +979,39 @@
 		printk(KERN_DEBUG "%s: Done netdev_open().\n",
 		       dev->name);
 
-	/* Set the timer to check for link beat. */
-	init_timer(&np->timer);
-	np->timer.expires = jiffies + 3*HZ;
-	np->timer.data = (unsigned long)dev;
-	np->timer.function = &netdev_timer;				/* timer handler */
-	add_timer(&np->timer);
-
 	return 0;
 }
 
-static void check_duplex(struct net_device *dev, int startup)
+
+static void check_duplex(struct net_device *dev)
 {
 	struct netdev_private *np = dev->priv;
-	long ioaddr = dev->base_addr;
-	int new_tx_mode ;
+	u16 reg0;
 
-	new_tx_mode = 0x0C04 | (np->tx_flowctrl ? 0x0800:0)
-		| (np->rx_flowctrl ? 0x0400:0);
-	if (np->medialock) {
-		if (np->full_duplex)
-			new_tx_mode |= 2;
-	} else {
-		int mii_reg5 = mdio_read(dev, np->phys[0], 5);
-		int negotiated =  mii_reg5 & np->advertising;
-		int duplex = (negotiated & 0x0100) || (negotiated & 0x01C0) == 0x0040;
-		if (duplex)
-			new_tx_mode |= 2;
-		if (np->full_duplex != duplex) {
-			np->full_duplex = duplex;
-			if (debug > 1)
-				printk(KERN_INFO "%s: Setting %s-duplex based on MII #%d"
-				       " negotiated capability %4.4x.\n", dev->name,
-				       duplex ? "full" : "half", np->phys[0], negotiated);
-		}
-	}
-	if (new_tx_mode != np->tx_mode) {
-		np->tx_mode = new_tx_mode;
-		writel(np->tx_mode | 0x8000, ioaddr + TxMode);
-		writel(np->tx_mode, ioaddr + TxMode);
-	}
-}
+	mdio_write(dev, np->phys[0], 4, np->advertising);
+	mdio_write(dev, np->phys[0], 0, 0x8000);
+	udelay(500);
+	while (mdio_read(dev, np->phys[0], 0) & 0x8000);
 
-static void netdev_timer(unsigned long data)
-{
-	struct net_device *dev = (struct net_device *)data;
-	struct netdev_private *np = dev->priv;
-	long ioaddr = dev->base_addr;
-	int next_tick = 60*HZ;		/* Check before driver release. */
+	reg0 = mdio_read(dev, np->phys[0], 0);
 
-	if (debug > 3) {
-		printk(KERN_DEBUG "%s: Media selection timer tick, status %8.8x.\n",
-		       dev->name, (int)readl(ioaddr + IntrStatus));
-	}
-	check_duplex(dev, 0);
-#if ! defined(final_version)
-	/* This is often falsely triggered. */
-	if (readl(ioaddr + IntrStatus) & 1) {
-		int new_status = readl(ioaddr + IntrStatus);
-		/* Bogus hardware IRQ: Fake an interrupt handler call. */
-		if (new_status & 1) {
-			printk(KERN_ERR "%s: Interrupt blocked, status %8.8x/%8.8x.\n",
-			       dev->name, new_status, (int)readl(ioaddr + IntrStatus));
-			intr_handler(dev->irq, dev, 0);
-		}
+	if (np->autoneg) {
+		reg0 |= 0x1200;
+	} else {
+		reg0 &= ~0x3300;
+		if (np->speed100)
+			reg0 |= 0x2000;
+		if (np->full_duplex)
+			reg0 |= 0x0100;
+		printk(KERN_DEBUG "%s: Link forced to %sMbit %s-duplex\n",
+		       dev->name,
+		       np->speed100 ? "100" : "10",
+		       np->full_duplex ? "full" : "half");
 	}
-#endif
-
-	np->timer.expires = jiffies + next_tick;
-	add_timer(&np->timer);
+	mdio_write(dev, np->phys[0], 0, reg0);
 }
 
+
 static void tx_timeout(struct net_device *dev)
 {
 	struct netdev_private *np = dev->priv;
@@ -993,7 +1034,6 @@
 #endif
 
 	/* Perhaps we should reinitialize the hardware here. */
-	dev->if_port = 0;
 	/* Stop and restart the chip's Tx processes . */
 
 	/* Trigger an immediate transmit demand. */
@@ -1048,6 +1088,13 @@
 	for (i = 0; i < TX_RING_SIZE; i++) {
 		np->tx_info[i].skb = NULL;
 		np->tx_info[i].first_mapping = 0;
+#ifdef ZEROCOPY
+		{
+			int j;
+			for (j = 0; j < MAX_STARFIRE_FRAGS; j++)
+				np->tx_info[i].frag_mapping[j] = 0;
+		}
+#endif /* ZEROCOPY */
 		np->tx_ring[i].status = 0;
 	}
 	return;
@@ -1057,6 +1104,9 @@
 {
 	struct netdev_private *np = dev->priv;
 	unsigned int entry;
+#ifdef ZEROCOPY
+	int i;
+#endif
 
 	kick_tx_timer(dev, tx_timeout, TX_TIMEOUT);
 
@@ -1066,22 +1116,81 @@
 	/* Calculate the next Tx descriptor entry. */
 	entry = np->cur_tx % TX_RING_SIZE;
 
+#if defined(ZEROCOPY) && defined(HAS_FIRMWARE) && defined(HAS_BROKEN_FIRMWARE)
+	{
+		int has_bad_length = 0;
+
+		if (skb_first_frag_len(skb) == 1)
+			has_bad_length = 1;
+		else {
+			for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
+				if (skb_shinfo(skb)->frags[i].size == 1) {
+					has_bad_length = 1;
+					break;
+				}
+		}
+
+		if (has_bad_length)
+			skb_checksum_help(skb);
+	}
+#endif /* ZEROCOPY && HAS_FIRMWARE && HAS_BROKEN_FIRMWARE */
+
 	np->tx_info[entry].skb = skb;
 	np->tx_info[entry].first_mapping =
 		pci_map_single(np->pci_dev, skb->data, skb_first_frag_len(skb), PCI_DMA_TODEVICE);
 
 	np->tx_ring[entry].first_addr = cpu_to_le32(np->tx_info[entry].first_mapping);
+#ifdef ZEROCOPY
+	np->tx_ring[entry].first_len = cpu_to_le32(skb_first_frag_len(skb));
+	np->tx_ring[entry].total_len = cpu_to_le32(skb->len);
+	/* Add "| TxDescIntr" to generate Tx-done interrupts. */
+	np->tx_ring[entry].status = cpu_to_le32(TxDescID | TxCRCEn);
+	np->tx_ring[entry].nbufs = cpu_to_le32(skb_shinfo(skb)->nr_frags + 1);
+#else  /* not ZEROCOPY */
 	/* Add "| TxDescIntr" to generate Tx-done interrupts. */
 	np->tx_ring[entry].status = cpu_to_le32(skb->len | TxDescID | TxCRCEn | 1 << 16);
+#endif /* not ZEROCOPY */
 
 	if (entry >= TX_RING_SIZE-1)		 /* Wrap ring */
 		np->tx_ring[entry].status |= cpu_to_le32(TxRingWrap | TxDescIntr);
 
+#ifdef ZEROCOPY
+	if (skb->ip_summed == CHECKSUM_HW)
+		np->tx_ring[entry].status |= cpu_to_le32(TxCalTCP);
+#endif /* ZEROCOPY */
+
 	if (debug > 5) {
+#ifdef ZEROCOPY
+		printk(KERN_DEBUG "%s: Tx #%d slot %d status %8.8x nbufs %d len %4.4x/%4.4x.\n",
+		       dev->name, np->cur_tx, entry,
+		       le32_to_cpu(np->tx_ring[entry].status),
+		       le32_to_cpu(np->tx_ring[entry].nbufs),
+		       le32_to_cpu(np->tx_ring[entry].first_len),
+		       le32_to_cpu(np->tx_ring[entry].total_len));
+#else  /* not ZEROCOPY */
 		printk(KERN_DEBUG "%s: Tx #%d slot %d status %8.8x.\n",
 		       dev->name, np->cur_tx, entry,
 		       le32_to_cpu(np->tx_ring[entry].status));
+#endif /* not ZEROCOPY */
+	}
+
+#ifdef ZEROCOPY
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		skb_frag_t *this_frag = &skb_shinfo(skb)->frags[i];
+
+		/* we already have the proper value in entry */
+		np->tx_info[entry].frag_mapping[i] =
+			pci_map_single(np->pci_dev, page_address(this_frag->page) + this_frag->page_offset, this_frag->size, PCI_DMA_TODEVICE);
+
+		np->tx_ring[entry].frag[i].addr = cpu_to_le32(np->tx_info[entry].frag_mapping[i]);
+		np->tx_ring[entry].frag[i].len = cpu_to_le32(this_frag->size);
+		if (debug > 5) {
+			printk(KERN_DEBUG "%s: Tx #%d frag %d len %4.4x.\n",
+			       dev->name, np->cur_tx, i,
+			       le32_to_cpu(np->tx_ring[entry].frag[i].len));
+		}
 	}
+#endif /* ZEROCOPY */
 
 	np->cur_tx++;
 
@@ -1165,6 +1274,9 @@
 				np->stats.tx_packets++;
 			} else if ((tx_status & 0xe0000000) == 0x80000000) {
 				struct sk_buff *skb;
+#ifdef ZEROCOPY
+				int i;
+#endif /* ZEROCOPY */
 				u16 entry = tx_status;		/* Implicit truncate */
 				entry /= sizeof(struct starfire_tx_desc);
 
@@ -1176,6 +1288,16 @@
 						 PCI_DMA_TODEVICE);
 				np->tx_info[entry].first_mapping = 0;
 
+#ifdef ZEROCOPY
+				for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+					pci_unmap_single(np->pci_dev,
+							 np->tx_info[entry].frag_mapping[i],
+							 skb_shinfo(skb)->frags[i].size,
+							 PCI_DMA_TODEVICE);
+					np->tx_info[entry].frag_mapping[i] = 0;
+				}
+#endif /* ZEROCOPY */
+
 				/* Scavenge the descriptor. */
 				dev_kfree_skb_irq(skb);
 
@@ -1192,6 +1314,15 @@
 			netif_wake_queue(dev);
 		}
 
+		/* Stats overflow */
+		if (intr_status & IntrStatsMax) {
+			get_stats(dev);
+		}
+
+		/* Media change interrupt. */
+		if (intr_status & IntrLinkChange)
+			netdev_media_change(dev);
+
 		/* Abnormal error summary/uncommon events handlers. */
 		if (intr_status & IntrAbnormalSummary)
 			netdev_error(dev, intr_status);
@@ -1351,30 +1482,82 @@
 		writew(entry, dev->base_addr + RxDescQIdx);
 	}
 
-	if (debug > 5
-	    || memcmp(np->pad0, np->pad0 + 1, sizeof(np->pad0) -1))
-		printk(KERN_DEBUG "  exiting netdev_rx() status of %d was %8.8x %d.\n",
-		       np->rx_done, desc_status,
-		       memcmp(np->pad0, np->pad0 + 1, sizeof(np->pad0) -1));
+	if (debug > 5)
+		printk(KERN_DEBUG "  exiting netdev_rx() status of %d was %8.8x.\n",
+		       np->rx_done, desc_status);
 
 	/* Restart Rx engine if stopped. */
 	return 0;
 }
 
-static void netdev_error(struct net_device *dev, int intr_status)
+
+static void netdev_media_change(struct net_device *dev)
 {
 	struct netdev_private *np = dev->priv;
+	long ioaddr = dev->base_addr;
+	u16 reg0, reg1, reg4, reg5;
+	u32 new_tx_mode;
 
-	if (intr_status & IntrLinkChange) {
-		printk(KERN_NOTICE "%s: Link changed: Autonegotiation advertising"
-		       " %4.4x, partner %4.4x.\n", dev->name,
-		       mdio_read(dev, np->phys[0], 4),
-		       mdio_read(dev, np->phys[0], 5));
-		check_duplex(dev, 0);
-	}
-	if (intr_status & IntrStatsMax) {
-		get_stats(dev);
+	/* reset status first */
+	mdio_read(dev, np->phys[0], 0);
+	mdio_read(dev, np->phys[0], 1);
+
+	reg0 = mdio_read(dev, np->phys[0], 0);
+	reg1 = mdio_read(dev, np->phys[0], 1);
+
+	if (reg1 & 0x04) {
+		/* link is up */
+		if (reg0 & 0x1000) {
+			/* autonegotiation is enabled */
+			reg4 = mdio_read(dev, np->phys[0], 4);
+			reg5 = mdio_read(dev, np->phys[0], 5);
+			if (reg4 & 0x0100 && reg5 & 0x0100) {
+				np->speed100 = 1;
+				np->full_duplex = 1;
+			} else if (reg4 & 0x0080 && reg5 & 0x0080) {
+				np->speed100 = 1;
+				np->full_duplex = 0;
+			} else if (reg4 & 0x0040 && reg5 & 0x0040) {
+				np->speed100 = 0;
+				np->full_duplex = 1;
+			} else {
+				np->speed100 = 0;
+				np->full_duplex = 0;
+			}
+		} else {
+			/* autonegotiation is disabled */
+			if (reg0 & 0x2000)
+				np->speed100 = 1;
+			else
+				np->speed100 = 0;
+			if (reg0 & 0x0100)
+				np->full_duplex = 1;
+			else
+				np->full_duplex = 0;
+		}
+		printk(KERN_DEBUG "%s: Link is up, running at %sMbit %s-duplex\n",
+		       dev->name,
+		       np->speed100 ? "100" : "10",
+		       np->full_duplex ? "full" : "half");
+
+		new_tx_mode = np->tx_mode & ~0x2;	/* duplex setting */
+		if (np->full_duplex)
+			new_tx_mode |= 2;
+		if (np->tx_mode != new_tx_mode) {
+			np->tx_mode = new_tx_mode;
+			writel(np->tx_mode | 0x8000, ioaddr + TxMode);
+			writel(np->tx_mode, ioaddr + TxMode);
+		}
+	} else {
+		printk(KERN_DEBUG "%s: Link is down\n", dev->name);
 	}
+}
+
+
+static void netdev_error(struct net_device *dev, int intr_status)
+{
+	struct netdev_private *np = dev->priv;
+
 	/* Came close to underrunning the Tx FIFO, increase threshold. */
 	if (intr_status & IntrTxDataLow) {
 		writel(++np->tx_threshold, dev->base_addr + TxThreshold);
@@ -1496,30 +1679,103 @@
 	writel(rx_mode, ioaddr + RxFilterMode);
 }
 
+
+
 static int netdev_ethtool_ioctl(struct net_device *dev, void *useraddr)
 {
+	struct ethtool_cmd ecmd;
 	struct netdev_private *np = dev->priv;
-	u32 ethcmd;
-		
-	if (copy_from_user(&ethcmd, useraddr, sizeof(ethcmd)))
+
+	if (copy_from_user(&ecmd, useraddr, sizeof(ecmd)))
 		return -EFAULT;
 
-        switch (ethcmd) {
-        case ETHTOOL_GDRVINFO: {
-		struct ethtool_drvinfo info = {ETHTOOL_GDRVINFO};
+	switch (ecmd.cmd) {
+	case ETHTOOL_GSET:
+		ecmd.supported =
+			SUPPORTED_10baseT_Half |
+			SUPPORTED_10baseT_Full |
+			SUPPORTED_100baseT_Half |
+			SUPPORTED_100baseT_Full |
+			SUPPORTED_Autoneg |
+			SUPPORTED_MII;
+
+		ecmd.advertising = ADVERTISED_MII;
+		if (np->advertising & 0x0020)
+			ecmd.advertising |= ADVERTISED_10baseT_Half;
+		if (np->advertising & 0x0040)
+			ecmd.advertising |= ADVERTISED_10baseT_Full;
+		if (np->advertising & 0x0080)
+			ecmd.advertising |= ADVERTISED_100baseT_Half;
+		if (np->advertising & 0x0100)
+			ecmd.advertising |= ADVERTISED_100baseT_Full;
+		if (np->autoneg) {
+			ecmd.advertising |= ADVERTISED_Autoneg;
+			ecmd.autoneg = AUTONEG_ENABLE;
+		} else
+			ecmd.autoneg = AUTONEG_DISABLE;
+
+		ecmd.port = PORT_MII;
+		ecmd.transceiver = XCVR_INTERNAL;
+		ecmd.phy_address = np->phys[0];
+		ecmd.speed = np->speed100 ? SPEED_100 : SPEED_10;
+		ecmd.duplex = np->full_duplex ? DUPLEX_FULL : DUPLEX_HALF;
+		ecmd.maxtxpkt = TX_RING_SIZE;
+		ecmd.maxrxpkt = np->intr_mitigation; /* not 100% accurate */
+
+
+		if (copy_to_user(useraddr, &ecmd, sizeof(ecmd)))
+			return -EFAULT;
+		return 0;
+
+	case ETHTOOL_SSET: {
+		u16 autoneg, speed100, full_duplex;
+
+		autoneg = (ecmd.autoneg == AUTONEG_ENABLE);
+		speed100 = (ecmd.speed == SPEED_100);
+		full_duplex = (ecmd.duplex == DUPLEX_FULL);
+
+		np->autoneg = autoneg;
+		if (speed100 != np->speed100 ||
+		    full_duplex != np->full_duplex) {
+			np->speed100 = speed100;
+			np->full_duplex = full_duplex;
+			/* change advertising bits */
+			np->advertising &= ~0x3e0;
+			if (speed100) {
+				if (full_duplex)
+					np->advertising |= 0x100;
+				else
+					np->advertising |= 0x80;
+			} else {
+				if (full_duplex)
+					np->advertising |= 0x40;
+				else
+					np->advertising |= 0x20;
+			}
+		}
+		check_duplex(dev);
+		return 0;
+	}
+
+	case ETHTOOL_GDRVINFO: {
+		struct ethtool_drvinfo info;
+		info.cmd = ecmd.cmd;
 		strcpy(info.driver, DRV_NAME);
 		strcpy(info.version, DRV_VERSION);
+		*info.fw_version = 0;
 		strcpy(info.bus_info, np->pci_dev->slot_name);
 		if (copy_to_user(useraddr, &info, sizeof(info)))
-			return -EFAULT;
+		       return -EFAULT;
 		return 0;
 	}
 
-        }
-	
-	return -EOPNOTSUPP;
+	default:
+		return -EOPNOTSUPP;
+	}
 }
 
+
+
 static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct netdev_private *np = dev->priv;
@@ -1528,6 +1784,8 @@
 	switch(cmd) {
 	case SIOCETHTOOL:
 		return netdev_ethtool_ioctl(dev, (void *) rq->ifr_data);
+
+	/* Legacy mii-diag interface */
 	case SIOCDEVPRIVATE:		/* Get the address of the PHY in use. */
 		data[0] = np->phys[0] & 0x1f;
 		/* Fall Through */
@@ -1542,15 +1800,17 @@
 			switch (data[1]) {
 			case 0:
 				if (value & 0x9000)	/* Autonegotiation. */
-					np->medialock = 0;
+					np->autoneg = 1;
 				else {
 					np->full_duplex = (value & 0x0100) ? 1 : 0;
-					np->medialock = 1;
+					np->autoneg = 0;
 				}
 				break;
-			case 4: np->advertising = value; break;
+			case 4:
+				np->advertising = value;
+				break;
 			}
-			check_duplex(dev, 0);
+			check_duplex(dev);
 		}
 		mdio_write(dev, data[0] & 0x1f, data[1] & 0x1f, data[2]);
 		return 0;
@@ -1568,8 +1828,6 @@
 	netif_stop_queue(dev);
 	netif_stop_if(dev);
 
-	del_timer_sync(&np->timer);
-
 	if (debug > 1) {
 		printk(KERN_DEBUG "%s: Shutting down ethercard, Intr status %4.4x.\n",
 			   dev->name, (int)readl(ioaddr + IntrStatus));
@@ -1615,6 +1873,9 @@
 	}
 	for (i = 0; i < TX_RING_SIZE; i++) {
 		struct sk_buff *skb = np->tx_info[i].skb;
+#ifdef ZEROCOPY
+		int j;
+#endif /* ZEROCOPY */
 		if (skb == NULL)
 			continue;
 		pci_unmap_single(np->pci_dev,
@@ -1623,6 +1884,17 @@
 		np->tx_info[i].first_mapping = 0;
 		dev_kfree_skb(skb);
 		np->tx_info[i].skb = NULL;
+#ifdef ZEROCOPY
+		for (j = 0; j < MAX_STARFIRE_FRAGS; j++)
+			if (np->tx_info[i].frag_mapping[j]) {
+				pci_unmap_single(np->pci_dev,
+						 np->tx_info[i].frag_mapping[j],
+						 skb_shinfo(skb)->frags[j].size,
+						 PCI_DMA_TODEVICE);
+				np->tx_info[i].frag_mapping[j] = 0;
+			} else
+				break;
+#endif /* ZEROCOPY */
 	}
 
 	COMPAT_MOD_DEC_USE_COUNT;
@@ -1694,8 +1966,8 @@
 
 /*
  * Local variables:
- *  compile-command: "gcc -DMODULE -Wall -Wstrict-prototypes -O6 -c starfire.c"
- *  simple-compile-command: "gcc -DMODULE -O6 -c starfire.c"
+ *  compile-command: "gcc -DMODULE -Wall -Wstrict-prototypes -O2 -c starfire.c"
+ *  simple-compile-command: "gcc -DMODULE -O2 -c starfire.c"
  *  c-basic-offset: 8
  *  tab-width: 8
  * End:
--- /dev/null	Tue May  5 13:32:27 1998
+++ linux-2.4/drivers/net/starfire_firmware.pl	Thu Feb 15 17:52:19 2001
@@ -0,0 +1,31 @@
+#!/usr/bin/perl
+
+# This script can be used to generate a new starfire_firmware.h
+# from GFP_RX.DAT and GFP_TX.DAT, files included with the DDK
+# and also with the Novell drivers.
+
+open FW, "GFP_RX.DAT" || die;
+open FWH, ">starfire_firmware.h" || die;
+
+printf(FWH "static u32 firmware_rx[] = {\n");
+$counter = 0;
+while ($foo = <FW>) {
+  chomp;
+  printf(FWH "  0x%s, 0x0000%s,\n", substr($foo, 4, 8), substr($foo, 0, 4));
+  $counter++;
+}
+
+close FW;
+open FW, "GFP_TX.DAT" || die;
+
+printf(FWH "};\t/* %d Rx instructions */\n#define FIRMWARE_RX_SIZE %d\n\nstatic u32 firmware_tx[] = {\n", $counter, $counter);
+$counter = 0;
+while ($foo = <FW>) {
+  chomp;
+  printf(FWH "  0x%s, 0x0000%s,\n", substr($foo, 4, 8), substr($foo, 0, 4));
+  $counter++;
+}
+
+close FW;
+printf(FWH "};\t/* %d Tx instructions */\n#define FIRMWARE_TX_SIZE %d\n", $counter, $counter);
+close(FWH);

