Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266653AbRGJQhY>; Tue, 10 Jul 2001 12:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266654AbRGJQhQ>; Tue, 10 Jul 2001 12:37:16 -0400
Received: from age.cs.columbia.edu ([128.59.22.100]:59655 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S266653AbRGJQhD>; Tue, 10 Jul 2001 12:37:03 -0400
Date: Tue, 10 Jul 2001 09:36:40 -0700 (PDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] starfire net driver update
Message-ID: <Pine.LNX.4.33.0107100932230.13462-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch fixes two real problems: missing initialization of a register 
which broke 100mbit half-duplex, and dereferencing of freed memory. It 
also massages the whitespace a bit.

Please apply.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
---------------------------
--- ../linux-2.4/drivers/net/starfire.c	Fri Jul  6 00:32:24 2001
+++ linux-2.4/drivers/net/starfire.c	Fri Jul  6 00:46:26 2001
@@ -85,13 +85,18 @@
 	- Fixed 2.2.x compatibility issues introduced in 1.3.1
 	- Fixed ethtool ioctl returning uninitialized memory
 
+	LK1.3.3 (Ion Badulescu)
+	- Initialize the TxMode register properly
+	- Set the MII registers _after_ resetting it
+	- Don't dereference dev->priv after unregister_netdev() has freed it
+
 TODO:
 	- implement tx_timeout() properly
 */
 
 #define DRV_NAME	"starfire"
-#define DRV_VERSION	"1.03+LK1.3.2"
-#define DRV_RELDATE	"June 04, 2001"
+#define DRV_VERSION	"1.03+LK1.3.3"
+#define DRV_RELDATE	"July 05, 2001"
 
 /*
  * Adaptec's license for their Novell drivers (which is where I got the
@@ -192,12 +197,6 @@
 #define skb_first_frag_len(skb)	(skb->len)
 #endif /* not ZEROCOPY */
 
-#if !defined(__OPTIMIZE__)
-#warning  You must compile this file with the correct options!
-#warning  See the last lines of the source file.
-#error You must compile this driver with "-O".
-#endif
-
 #include <linux/version.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -208,7 +207,6 @@
 #include <linux/delay.h>
 #include <asm/processor.h>		/* Processor type for cache alignment. */
 #include <asm/uaccess.h>
-#include <asm/io.h>
 
 #ifdef HAS_FIRMWARE
 #include "starfire_firmware.h"
@@ -559,7 +557,7 @@
 	unsigned int cur_tx, dirty_tx;
 	unsigned int rx_buf_sz;		/* Based on MTU+slack. */
 	unsigned int tx_full:1,		/* The Tx queue is full. */
-	/* These values are keep track of the transceiver/media in use. */
+	/* These values keep track of the transceiver/media in use. */
 		autoneg:1,		/* Autonegotiation allowed. */
 		full_duplex:1,		/* Full-duplex operation. */
 		speed100:1;		/* Set if speed == 100MBit. */
@@ -572,6 +570,7 @@
 	unsigned char phys[PHY_CNT];	/* MII device addresses. */
 };
 
+
 static int	mdio_read(struct net_device *dev, int phy_id, int location);
 static void	mdio_write(struct net_device *dev, int phy_id, int location, int value);
 static int	netdev_open(struct net_device *dev);
@@ -589,7 +588,7 @@
 static int	netdev_close(struct net_device *dev);
 static void	netdev_media_change(struct net_device *dev);
 
-
+
 
 static int __devinit starfire_init_one(struct pci_dev *pdev,
 				       const struct pci_device_id *ent)
@@ -615,9 +614,9 @@
 	if (pci_enable_device (pdev))
 		return -EIO;
 
-	ioaddr = pci_resource_start (pdev, 0);
-	io_size = pci_resource_len (pdev, 0);
-	if (!ioaddr || ((pci_resource_flags (pdev, 0) & IORESOURCE_MEM) == 0)) {
+	ioaddr = pci_resource_start(pdev, 0);
+	io_size = pci_resource_len(pdev, 0);
+	if (!ioaddr || ((pci_resource_flags(pdev, 0) & IORESOURCE_MEM) == 0)) {
 		printk (KERN_ERR DRV_NAME " %d: no PCI MEM resources, aborting\n", card_idx);
 		return -ENODEV;
 	}
@@ -777,14 +776,13 @@
 err_out_free_res:
 	pci_release_regions (pdev);
 err_out_free_netdev:
-	unregister_netdev (dev);
-	kfree (dev);
+	unregister_netdev(dev);
+	kfree(dev);
 	return -ENODEV;
 }
 
-
-/* Read the MII Management Data I/O (MDIO) interfaces. */
 
+/* Read the MII Management Data I/O (MDIO) interfaces. */
 static int mdio_read(struct net_device *dev, int phy_id, int location)
 {
 	long mdio_addr = dev->base_addr + MIICtrl + (phy_id<<7) + (location<<2);
@@ -800,6 +798,7 @@
 	return result & 0xffff;
 }
 
+
 static void mdio_write(struct net_device *dev, int phy_id, int location, int value)
 {
 	long mdio_addr = dev->base_addr + MIICtrl + (phy_id<<7) + (location<<2);
@@ -808,7 +807,7 @@
 	return;
 }
 
-
+
 static int netdev_open(struct net_device *dev)
 {
 	struct netdev_private *np = dev->priv;
@@ -931,6 +930,8 @@
 	/* Initialize other registers. */
 	/* Configure the PCI bus bursts and FIFO thresholds. */
 	np->tx_mode = 0x0C04;		/* modified when link is up. */
+	writel(0x8000 | np->tx_mode, ioaddr + TxMode);
+	writel(np->tx_mode, ioaddr + TxMode);
 	np->tx_threshold = 4;
 	writel(np->tx_threshold, ioaddr + TxThreshold);
 
@@ -986,12 +987,12 @@
 	struct netdev_private *np = dev->priv;
 	u16 reg0;
 
-	mdio_write(dev, np->phys[0], MII_ADVERTISE, np->advertising);
 	mdio_write(dev, np->phys[0], MII_BMCR, BMCR_RESET);
 	udelay(500);
 	while (mdio_read(dev, np->phys[0], MII_BMCR) & BMCR_RESET);
 
 	reg0 = mdio_read(dev, np->phys[0], MII_BMCR);
+	mdio_write(dev, np->phys[0], MII_ADVERTISE, np->advertising);
 
 	if (np->autoneg) {
 		reg0 |= BMCR_ANENABLE | BMCR_ANRESTART;
@@ -1098,6 +1099,7 @@
 	return;
 }
 
+
 static int start_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct netdev_private *np = dev->priv;
@@ -1214,6 +1216,7 @@
 	return 0;
 }
 
+
 /* The interrupt handler does all of the Rx thread work and cleans up
    after the Tx thread. */
 static void intr_handler(int irq, void *dev_instance, struct pt_regs *rgs)
@@ -1350,6 +1353,7 @@
 #endif
 }
 
+
 /* This routine is logically part of the interrupt handler, but separated
    for clarity and better register allocation. */
 static int netdev_rx(struct net_device *dev)
@@ -1407,11 +1411,9 @@
 			memcpy(skb_put(skb, pkt_len), np->rx_info[entry].skb->tail, pkt_len);
 #endif
 		} else {
-			char *temp;
-
 			pci_unmap_single(np->pci_dev, np->rx_info[entry].mapping, np->rx_buf_sz, PCI_DMA_FROMDEVICE);
 			skb = np->rx_info[entry].skb;
-			temp = skb_put(skb, pkt_len);
+			skb_put(skb, pkt_len);
 			np->rx_info[entry].skb = NULL;
 			np->rx_info[entry].mapping = 0;
 		}
@@ -1570,6 +1572,7 @@
 		np->stats.tx_fifo_errors++;
 }
 
+
 static struct net_device_stats *get_stats(struct net_device *dev)
 {
 	long ioaddr = dev->base_addr;
@@ -1596,6 +1599,7 @@
 	return &np->stats;
 }
 
+
 /* The little-endian AUTODIN II ethernet CRC calculations.
    A big-endian version is also available.
    This is slow but compact code.  Do not use this routine for bulk data,
@@ -1622,6 +1626,7 @@
 	return crc;
 }
 
+
 static void set_rx_mode(struct net_device *dev)
 {
 	long ioaddr = dev->base_addr;
@@ -1658,7 +1663,7 @@
 
 		memset(mc_filter, 0, sizeof(mc_filter));
 		for (i = 0, mclist = dev->mc_list; mclist && i < dev->mc_count;
-			 i++, mclist = mclist->next) {
+		     i++, mclist = mclist->next) {
 			int bit_nr = ether_crc_le(ETH_ALEN, mclist->dmi_addr) >> 23;
 			__u32 *fptr = (__u32 *) &mc_filter[(bit_nr >> 4) & ~1];
 
@@ -1679,7 +1684,6 @@
 }
 
 
-
 static int netdev_ethtool_ioctl(struct net_device *dev, void *useraddr)
 {
 	struct ethtool_cmd ecmd;
@@ -1779,7 +1783,6 @@
 }
 
 
-
 static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct netdev_private *np = dev->priv;
@@ -1808,10 +1811,11 @@
 			u16 value = data->val_in;
 			switch (data->reg_num) {
 			case 0:
-				if (value & 0x9000)	/* Autonegotiation. */
+				if (value & (BMCR_RESET | BMCR_ANENABLE))
+					/* Autonegotiation. */
 					np->autoneg = 1;
 				else {
-					np->full_duplex = (value & 0x0100) ? 1 : 0;
+					np->full_duplex = (value & BMCR_FULLDPLX) ? 1 : 0;
 					np->autoneg = 0;
 				}
 				break;
@@ -1921,27 +1925,26 @@
 		BUG();
 
 	np = dev->priv;
-
-	unregister_netdev(dev);
-	iounmap((char *)dev->base_addr);
-	pci_release_regions(pdev);
-
 	if (np->tx_done_q)
-		pci_free_consistent(np->pci_dev, PAGE_SIZE,
+		pci_free_consistent(pdev, PAGE_SIZE,
 				    np->tx_done_q, np->tx_done_q_dma);
 	if (np->rx_done_q)
-		pci_free_consistent(np->pci_dev, PAGE_SIZE,
+		pci_free_consistent(pdev,
+				    sizeof(struct rx_done_desc) * DONE_Q_SIZE,
 				    np->rx_done_q, np->rx_done_q_dma);
 	if (np->tx_ring)
-		pci_free_consistent(np->pci_dev, PAGE_SIZE,
+		pci_free_consistent(pdev, PAGE_SIZE,
 				    np->tx_ring, np->tx_ring_dma);
 	if (np->rx_ring)
-		pci_free_consistent(np->pci_dev, PAGE_SIZE,
+		pci_free_consistent(pdev, PAGE_SIZE,
 				    np->rx_ring, np->rx_ring_dma);
 
-	kfree(dev);
+	unregister_netdev(dev);			/* Will also free np!! */
+	iounmap((char *)dev->base_addr);
+	pci_release_regions(pdev);
 
 	pci_set_drvdata(pdev, NULL);
+	kfree(dev);
 }
 
 


