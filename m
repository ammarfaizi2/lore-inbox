Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261942AbREYVpz>; Fri, 25 May 2001 17:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261950AbREYVpq>; Fri, 25 May 2001 17:45:46 -0400
Received: from colorfullife.com ([216.156.138.34]:55818 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S261942AbREYVp3>;
	Fri, 25 May 2001 17:45:29 -0400
Message-ID: <3B0ED21A.4602B81F@colorfullife.com>
Date: Fri, 25 May 2001 23:43:54 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-ac11 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] winbond update
Content-Type: multipart/mixed;
 boundary="------------3F05165498BC30925C0DE839"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------3F05165498BC30925C0DE839
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I'll send the attached patch to Alan soon, please test it.

Main changes:
* powerpc support added. Tested with ppc 603e.
* memory leak in _close fixed.
* initial power management support
* ethtool support merged
* SMP synchronization updated.
* improved link detection. This change could cause problems, but it's
required for proper switching between nway and pre-nway link partners,
at least with my PHY.

Tested with -ac11, patch also applies against 2.4.4 and 2.4.4-ac17.

--
	Manfred
--------------3F05165498BC30925C0DE839
Content-Type: text/plain; charset=us-ascii;
 name="patch-winbond"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-winbond"

--- 2.4/drivers/net/winbond-840.c	Fri May 25 22:36:10 2001
+++ build-2.4/drivers/net/winbond-840.c	Fri May 25 23:23:07 2001
@@ -32,12 +32,22 @@
 		synchronize tx_q_bytes
 		software reset in tx_timeout
 			Copyright (C) 2000 Manfred Spraul
+	* further cleanups
+		power management.
+		support for big endian descriptors
+		ethtool ioctl merged from gkernel.
+			Copyright (c) 2001 Manfred Spraul
 
 	TODO:
-	* according to the documentation, the chip supports big endian
-		descriptors. Remove cpu_to_le32, enable BE descriptors.
+	* enable pci_power_off
+	* Wake-On-LAN
 */
 
+#define DRV_NAME	"winbond-840"
+#define DRV_VERSION	"1.01-b"
+#define DRV_RELDATE	"5/15/2000"
+
+
 /* Automatically extracted configuration info:
 probe-func: winbond840_probe
 config-in: tristate 'Winbond W89c840 Ethernet support' CONFIG_WINBOND_840
@@ -79,10 +89,13 @@
    Making the Tx ring too large decreases the effectiveness of channel
    bonding and packet priority.
    There are no ill effects from too-large receive rings. */
-#define TX_RING_SIZE	16
+#define TX_RING_SIZE	16	
 #define TX_QUEUE_LEN	10		/* Limit ring entries actually used.  */
+#define TX_QUEUE_LEN_RESTART	5
 #define RX_RING_SIZE	32
 
+#define TX_BUFLIMIT	(1024-128)
+
 /* The presumed FIFO size for working around the Tx-FIFO-overflow bug.
    To avoid overflowing we don't queue again until we have room for a
    full-size packet.
@@ -90,7 +103,6 @@
 #define TX_FIFO_SIZE (2048)
 #define TX_BUG_FIFO_LIMIT (TX_FIFO_SIZE-1514-16)
 
-#define TX_BUFLIMIT	(1024-128)
 
 /* Operational parameters that usually are not changed. */
 /* Time in jiffies before concluding the transmitter is hung. */
@@ -122,13 +134,17 @@
 #include <linux/skbuff.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/rtnetlink.h>
+#include <linux/ethtool.h>
+#include <asm/uaccess.h>
 #include <asm/processor.h>		/* Processor type for cache alignment. */
 #include <asm/bitops.h>
 #include <asm/io.h>
+#include <asm/irq.h>
 
 /* These identify the driver base version and may not be removed. */
 static char version[] __devinitdata =
-KERN_INFO "winbond-840.c:v1.01 (2.4 port) 5/15/2000  Donald Becker <becker@scyld.com>\n"
+KERN_INFO DRV_NAME ".c:v" DRV_VERSION DRV_RELDATE "  Donald Becker <becker@scyld.com>\n"
 KERN_INFO "  http://www.scyld.com/network/drivers.html\n";
 
 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
@@ -183,6 +199,8 @@
 correctly detect a full FIFO, and queuing more than 2048 bytes may result in
 silent data corruption.
 
+Test with 'ping -s 10000' on a fast computer.
+
 */
 
 
@@ -198,7 +216,7 @@
         PCI_ADDR_64BITS=0x100, PCI_NO_ACPI_WAKE=0x200, PCI_NO_MIN_LATENCY=0x400,
 };
 enum chip_capability_flags {
-	CanHaveMII=1, HasBrokenTx=2, AlwaysFDX=4, FDXOnNoMII=8,};
+	CanHaveMII=1, AlwaysFDX=2, FDXOnNoMII=4};
 #ifdef USE_IO_OPS
 #define W840_FLAGS (PCI_USES_IO | PCI_ADDR0 | PCI_USES_MASTER)
 #else
@@ -226,11 +244,11 @@
 static struct pci_id_info pci_id_tbl[] = {
 	{"Winbond W89c840",			/* Sometime a Level-One switch card. */
 	 { 0x08401050, 0xffffffff, 0x81530000, 0xffff0000 },
-	 W840_FLAGS, 128, CanHaveMII | HasBrokenTx | FDXOnNoMII},
+	 W840_FLAGS, 128, CanHaveMII | FDXOnNoMII},
 	{"Winbond W89c840", { 0x08401050, 0xffffffff, },
-	 W840_FLAGS, 128, CanHaveMII | HasBrokenTx},
+	 W840_FLAGS, 128, CanHaveMII },
 	{"Compex RL100-ATX", { 0x201111F6, 0xffffffff,},
-	 W840_FLAGS, 128, CanHaveMII | HasBrokenTx},
+	 W840_FLAGS, 128, CanHaveMII },
 	{0,},						/* 0 terminated list. */
 };
 
@@ -302,7 +320,7 @@
 struct w840_tx_desc {
 	s32 status;
 	s32 length;
-	u32 buffer1, buffer2;				/* We use only buffer 1.  */
+	u32 buffer1, buffer2;
 };
 
 /* Bits in network_desc.status */
@@ -335,30 +353,31 @@
 	unsigned int cur_rx, dirty_rx;		/* Producer/consumer ring indices */
 	unsigned int rx_buf_sz;				/* Based on MTU+slack. */
 	unsigned int cur_tx, dirty_tx;
-	int tx_q_bytes;
-	unsigned int tx_full:1;				/* The Tx queue is full. */
+	unsigned int tx_q_bytes;
+	unsigned int tx_full;				/* The Tx queue is full. */
 	/* These values are keep track of the transceiver/media in use. */
 	unsigned int full_duplex:1;			/* Full-duplex operation requested. */
 	unsigned int duplex_lock:1;
-	unsigned int medialock:1;			/* Do not sense media. */
-	unsigned int default_port:4;		/* Last dev->if_port value. */
+	int dev_suspended;
 	/* MII transceiver section. */
 	int mii_cnt;						/* MII device addresses. */
 	u16 advertising;					/* NWay media advertisement */
 	unsigned char phys[MII_CNT];		/* MII device addresses, but only the first is used */
+	u32 mii;
 };
 
 static int  eeprom_read(long ioaddr, int location);
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
@@ -366,7 +385,7 @@
 static inline unsigned ether_crc(int length, unsigned char *data);
 static void set_rx_mode(struct net_device *dev);
 static struct net_device_stats *get_stats(struct net_device *dev);
-static int mii_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
+static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static int  netdev_close(struct net_device *dev);
 
 
@@ -399,7 +418,7 @@
 		return -ENOMEM;
 	SET_MODULE_OWNER(dev);
 
-	if (pci_request_regions(pdev, "winbond-840"))
+	if (pci_request_regions(pdev, DRV_NAME))
 		goto err_out_netdev;
 
 #ifdef USE_IO_OPS
@@ -411,7 +430,6 @@
 		goto err_out_free_res;
 #endif
 
-	/* Warning: broken for big-endian machines. */
 	for (i = 0; i < 3; i++)
 		((u16 *)dev->dev_addr)[i] = le16_to_cpu(eeprom_read(ioaddr, i));
 
@@ -427,6 +445,7 @@
 	np->chip_id = chip_idx;
 	np->drv_flags = pci_id_tbl[chip_idx].drv_flags;
 	spin_lock_init(&np->lock);
+	np->dev_suspended = 0;
 	
 	pci_set_drvdata(pdev, dev);
 
@@ -437,9 +456,9 @@
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
@@ -453,7 +472,7 @@
 	dev->stop = &netdev_close;
 	dev->get_stats = &get_stats;
 	dev->set_multicast_list = &set_rx_mode;
-	dev->do_ioctl = &mii_ioctl;
+	dev->do_ioctl = &netdev_ioctl;
 	dev->tx_timeout = &tx_timeout;
 	dev->watchdog_timeo = TX_TIMEOUT;
 
@@ -474,9 +493,11 @@
 			if (mii_status != 0xffff  &&  mii_status != 0x0000) {
 				np->phys[phy_idx++] = phy;
 				np->advertising = mdio_read(dev, phy, 4);
-				printk(KERN_INFO "%s: MII PHY found at address %d, status "
+				np->mii = (mdio_read(dev, phy, 2) << 16)+
+						mdio_read(dev, phy, 3);
+				printk(KERN_INFO "%s: MII PHY %8.8xh found at address %d, status "
 					   "0x%4.4x advertising %4.4x.\n",
-					   dev->name, phy, mii_status, np->advertising);
+					   dev->name, np->mii, phy, mii_status, np->advertising);
 			}
 		}
 		np->mii_cnt = phy_idx;
@@ -667,7 +688,7 @@
 		printk(KERN_DEBUG "%s: w89c840_open() irq %d.\n",
 			   dev->name, dev->irq);
 
-	if((i=alloc_ring(dev)))
+	if((i=alloc_ringdesc(dev)))
 		return i;
 
 	init_registers(dev);
@@ -678,7 +699,7 @@
 
 	/* Set the timer to check for link beat. */
 	init_timer(&np->timer);
-	np->timer.expires = jiffies + 3*HZ;
+	np->timer.expires = jiffies + 1*HZ;
 	np->timer.data = (unsigned long)dev;
 	np->timer.function = &netdev_timer;				/* timer handler */
 	add_timer(&np->timer);
@@ -686,25 +707,107 @@
 	return 0;
 }
 
-static void check_duplex(struct net_device *dev)
+#define MII_DAVICOM_DM9101	0x0181b800
+
+static int update_link(struct net_device *dev)
 {
 	struct netdev_private *np = dev->priv;
-	int mii_reg5 = mdio_read(dev, np->phys[0], 5);
-	int negotiated =  mii_reg5 & np->advertising;
-	int duplex;
+	int duplex, fasteth, result, mii_reg;
 
-	if (np->duplex_lock  ||  mii_reg5 == 0xffff)
-		return;
-	duplex = (negotiated & 0x0100) || (negotiated & 0x01C0) == 0x0040;
-	if (np->full_duplex != duplex) {
-		np->full_duplex = duplex;
+	/* BSMR */
+	mii_reg = mdio_read(dev, np->phys[0], 1);
+
+	if (mii_reg == 0xffff)
+		return np->csr6;
+	/* reread: the link status bit is sticky */
+	mii_reg = mdio_read(dev, np->phys[0], 1);
+	if (!(mii_reg & 0x4)) {
+		if (netif_carrier_ok(dev)) {
+			if (debug)
+				printk(KERN_INFO "%s: MII #%d reports no link. Disabling watchdog.\n",
+					dev->name, np->phys[0]);
+			netif_carrier_off(dev);
+		}
+		return np->csr6;
+	}
+	if (!netif_carrier_ok(dev)) {
 		if (debug)
-			printk(KERN_INFO "%s: Setting %s-duplex based on MII #%d "
-				   "negotiated capability %4.4x.\n", dev->name,
-				   duplex ? "full" : "half", np->phys[0], negotiated);
-		np->csr6 &= ~0x200;
-		np->csr6 |= duplex ? 0x200 : 0;
+			printk(KERN_INFO "%s: MII #%d link is back. Enabling watchdog.\n",
+				dev->name, np->phys[0]);
+		netif_carrier_on(dev);
 	}
+	
+	if ((np->mii & ~0xf) == MII_DAVICOM_DM9101) {
+		/* If the link partner doesn't support autonegotiation
+		 * the MII detects it's abilities with the "parallel detection".
+		 * Some MIIs update the LPA register to the result of the parallel
+		 * detection, some don't.
+		 * The Davicom PHY [at least 0181b800] doesn't.
+		 * Instead bit 9 and 13 of the BMCR are updated to the result
+		 * of the negotiation..
+		 */
+		mii_reg = mdio_read(dev, np->phys[0], 0);
+		duplex = mii_reg & 0x100;
+		fasteth = mii_reg & 0x2000;
+	} else {
+		int negotiated;
+		mii_reg	= mdio_read(dev, np->phys[0], 5);
+		negotiated = mii_reg & np->advertising;
+
+		duplex = (negotiated & 0x0100) || ((negotiated & 0x02C0) == 0x0040);
+		fasteth = negotiated & 0x380;
+	}
+	duplex |= np->duplex_lock;
+	/* remove fastether and fullduplex */
+	result = np->csr6 & ~0x20000200;
+	if (duplex)
+		result |= 0x200;
+	if (fasteth)
+		result |= 0x20000000;
+	if (result != np->csr6 && debug)
+		printk(KERN_INFO "%s: Setting %dMBit-%s-duplex based on MII#%d\n",
+				 dev->name, fasteth ? 100 : 10, 
+			   	duplex ? "full" : "half", np->phys[0]);
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
+		return;
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
+	}
+	np->csr6 = new;
+	/* and restart them with the new configuration */
+	writel(np->csr6, ioaddr + NetworkConfig);
+	if (new & 0x200)
+		np->full_duplex = 1;
 }
 
 static void netdev_timer(unsigned long data)
@@ -712,8 +815,6 @@
 	struct net_device *dev = (struct net_device *)data;
 	struct netdev_private *np = dev->priv;
 	long ioaddr = dev->base_addr;
-	int next_tick = 10*HZ;
-	int old_csr6 = np->csr6;
 
 	if (debug > 2)
 		printk(KERN_DEBUG "%s: Media selection timer tick, status %8.8x "
@@ -721,13 +822,9 @@
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
 
@@ -741,12 +838,12 @@
 
 	/* Initial all Rx descriptors. */
 	for (i = 0; i < RX_RING_SIZE; i++) {
-		np->rx_ring[i].length = cpu_to_le32(np->rx_buf_sz);
+		np->rx_ring[i].length = np->rx_buf_sz;
 		np->rx_ring[i].status = 0;
 		np->rx_skbuff[i] = 0;
 	}
 	/* Mark the last entry as wrapping the ring. */
-	np->rx_ring[i-1].length |= cpu_to_le32(DescEndRing);
+	np->rx_ring[i-1].length |= DescEndRing;
 
 	/* Fill in the Rx buffers.  Handle allocation failure gracefully. */
 	for (i = 0; i < RX_RING_SIZE; i++) {
@@ -758,8 +855,8 @@
 		np->rx_addr[i] = pci_map_single(np->pci_dev,skb->tail,
 					skb->len,PCI_DMA_FROMDEVICE);
 
-		np->rx_ring[i].buffer1 = cpu_to_le32(np->rx_addr[i]);
-		np->rx_ring[i].status = cpu_to_le32(DescOwn);
+		np->rx_ring[i].buffer1 = np->rx_addr[i];
+		np->rx_ring[i].status = DescOwn;
 	}
 
 	np->cur_rx = 0;
@@ -816,6 +913,14 @@
 		writeb(dev->dev_addr[i], ioaddr + StationAddr + i);
 
 	/* Initialize other registers. */
+#ifdef __BIG_ENDIAN
+	i = (1<<20);	/* Big-endian descriptors */
+#else
+	i = 0;
+#endif
+	i |= (0x04<<2);		/* skip length 4 u32 */
+	i |= 0x02;		/* give Rx priority */
+
 	/* Configure the PCI bus bursts and FIFO thresholds.
 	   486: Set 8 longword cache alignment, 8 longword burst.
 	   586: Set 16 longword cache alignment, no burst limit.
@@ -823,43 +928,46 @@
 		0000	<not allowed> 		0000 align to cache	0800 8 longwords
 		4000	8  longwords		0100 1 longword		1000 16 longwords
 		8000	16 longwords		0200 2 longwords	2000 32 longwords
-		C000	32  longwords		0400 4 longwords
-	   Wait the specified 50 PCI cycles after a reset by initializing
-	   Tx and Rx queues and the address filter list. */
-#if defined(__powerpc__)		/* Big-endian */
-	writel(0x00100080 | 0xE010, ioaddr + PCIBusCfg);
-#elif defined(__alpha__)
-	writel(0xE010, ioaddr + PCIBusCfg);
-#elif defined(__i386__)
-#if defined(MODULE)
-	writel(0xE010, ioaddr + PCIBusCfg);
+		C000	32  longwords		0400 4 longwords */
+
+#if 1
+	/* certain burst/cache alignment settings cause
+	 * data corruptions.
+	 */
+	i |= 0x1000;
 #else
+#if defined (__i386__) && !defined(MODULE)
 	/* When not a module we can work around broken '486 PCI boards. */
-#define x86 boot_cpu_data.x86
-	writel((x86 <= 4 ? 0x4810 : 0xE010), ioaddr + PCIBusCfg);
-	if (x86 <= 4)
+	if (boot_cpu_data.x86 <= 4) {
+		i |= 0x4800;
 		printk(KERN_INFO "%s: This is a 386/486 PCI system, setting cache "
-			   "alignment to %x.\n", dev->name,
-			   (x86 <= 4 ? 0x4810 : 0xE010));
-#endif
+			   "alignment to 8 longwords.\n", dev->name);
+	} else {
+		i |= 0xE000;
+	}
+#elif defined(__powerpc__) || defined(__i386__) || defined(__alpha) || defined(__ia64__)
+	i |= 0xE000;
 #else
-	writel(0xE010, ioaddr + PCIBusCfg);
-#warning Processor architecture undefined!
+#warning Processor architecture undefined
+	i |= 0x4800;
 #endif
+#endif
+	writel(i, ioaddr + PCIBusCfg);
 
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
+	np->csr6 = 0x00002002;
+	np->csr6 = update_link(dev);
 
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
 
@@ -883,35 +991,40 @@
 		printk("\n");
 	}
 	printk(KERN_DEBUG "Tx cur %d Tx dirty %d Tx Full %d, q bytes %d.\n",
-				np->cur_tx, np->dirty_tx, np->tx_full,np->tx_q_bytes);
+				np->cur_tx, np->dirty_tx, np->tx_full, np->tx_q_bytes);
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
+	readl(dev->base_addr+PCIBusCfg);
 	udelay(1);
 
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
 
@@ -927,12 +1040,19 @@
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
 	struct netdev_private *np = dev->priv;
 	unsigned entry;
-	int len1, len2;
 
 	/* Caution: the write order is important here, set the field
 	   with the "ownership" bits last. */
@@ -940,48 +1060,49 @@
 	/* Calculate the next Tx descriptor entry. */
 	entry = np->cur_tx % TX_RING_SIZE;
 
-	np->tx_skbuff[entry] = skb;
 	np->tx_addr[entry] = pci_map_single(np->pci_dev,
 				skb->data,skb->len, PCI_DMA_TODEVICE);
-	np->tx_ring[entry].buffer1 = cpu_to_le32(np->tx_addr[entry]);
-	len2 = 0;
-	len1 = skb->len;
-	if(len1 > TX_BUFLIMIT) {
-		len1 = TX_BUFLIMIT;
-		len2 = skb->len-len1;
-		np->tx_ring[entry].buffer2 = cpu_to_le32(np->tx_addr[entry]+TX_BUFLIMIT);
-	}
-	np->tx_ring[entry].length = cpu_to_le32(DescWholePkt | (len2 << 11) | len1);
-	if (entry >= TX_RING_SIZE-1)		 /* Wrap ring */
-		np->tx_ring[entry].length |= cpu_to_le32(DescIntr | DescEndRing);
-	np->cur_tx++;
+	np->tx_skbuff[entry] = skb;
+
+	np->tx_ring[entry].buffer1 = np->tx_addr[entry];
+	if (skb->len < TX_BUFLIMIT) {
+		np->tx_ring[entry].length = DescWholePkt | skb->len;
+	} else {
+		int len = skb->len - TX_BUFLIMIT;
+
+		np->tx_ring[entry].buffer2 = np->tx_addr[entry]+TX_BUFLIMIT;
+		np->tx_ring[entry].length = DescWholePkt | (len << 11) | TX_BUFLIMIT;
+	}
+	if(entry == TX_RING_SIZE-1)
+		np->tx_ring[entry].length |= DescEndRing;
 
-	/* The spinlock protects against 2 races:
-	 * - tx_q_bytes is updated by this function and intr_handler
-	 * - our hardware is extremely fast and finishes the packet between
-	 *	our check for "queue full" and netif_stop_queue.
-	 *	Thus setting DescOwn and netif_stop_queue must be atomic.
+	/* Now acquire the irq spinlock.
+	 * The difficult race is the the ordering between
+	 * increasing np->cur_tx and setting DescOwn:
+	 * - if np->cur_tx is increased first the interrupt
+	 *   handler could consider the packet as transmitted
+	 *   since DescOwn is cleared.
+	 * - If DescOwn is set first the NIC could report the
+	 *   packet as sent, but the interrupt handler would ignore it
+	 *   since the np->cur_tx was not yet increased.
 	 */
 	spin_lock_irq(&np->lock);
+	np->cur_tx++;
 
 	wmb(); /* flush length, buffer1, buffer2 */
-	np->tx_ring[entry].status = cpu_to_le32(DescOwn);
+	np->tx_ring[entry].status = DescOwn;
 	wmb(); /* flush status and kick the hardware */
 	writel(0, dev->base_addr + TxStartDemand);
-
 	np->tx_q_bytes += skb->len;
-	/* Work around horrible bug in the chip by marking the queue as full
-	   when we do not have FIFO room for a maximum sized packet. */
-	if (np->cur_tx - np->dirty_tx > TX_QUEUE_LEN)
-		np->tx_full = 1;
-	else if ((np->drv_flags & HasBrokenTx)
-			 && np->tx_q_bytes > TX_BUG_FIFO_LIMIT)
-		np->tx_full = 1;
-	if (np->tx_full)
+	if (np->cur_tx - np->dirty_tx > TX_QUEUE_LEN ||
+		np->tx_q_bytes > TX_BUG_FIFO_LIMIT) {
 		netif_stop_queue(dev);
+		wmb();
+		np->tx_full = 1;
+	}
+	spin_unlock_irq(&np->lock);
 
 	dev->trans_start = jiffies;
-	spin_unlock_irq(&np->lock);
 
 	if (debug > 4) {
 		printk(KERN_DEBUG "%s: Transmit frame #%d queued in slot %d.\n",
@@ -990,6 +1111,62 @@
 	return 0;
 }
 
+static void netdev_tx_done(struct net_device *dev)
+{
+	struct netdev_private *np = dev->priv;
+	for (; np->cur_tx - np->dirty_tx > 0; np->dirty_tx++) {
+		int entry = np->dirty_tx % TX_RING_SIZE;
+		int tx_status = np->tx_ring[entry].status;
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
+#ifndef final_version
+			if (debug > 3)
+				printk(KERN_DEBUG "%s: Transmit slot %d ok, Tx status %8.8x.\n",
+					   dev->name, entry, tx_status);
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
+		np->cur_tx - np->dirty_tx < TX_QUEUE_LEN_RESTART &&
+		np->tx_q_bytes < TX_BUG_FIFO_LIMIT) {
+		/* The ring is no longer full, clear tbusy. */
+		np->tx_full = 0;
+		wmb();
+		netif_wake_queue(dev);
+	}
+}
+
 /* The interrupt handler does all of the Rx thread work and cleans up
    after the Tx thread. */
 static void intr_handler(int irq, void *dev_instance, struct pt_regs *rgs)
@@ -999,8 +1176,8 @@
 	long ioaddr = dev->base_addr;
 	int work_limit = max_interrupt_work;
 
-	spin_lock(&np->lock);
-
+	if (np->dev_suspended)
+		return;
 	do {
 		u32 intr_status = readl(ioaddr + IntrStatus);
 
@@ -1016,51 +1193,14 @@
 
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
@@ -1073,8 +1213,12 @@
 				   "status=0x%4.4x.\n", dev->name, intr_status);
 			/* Set the timer to re-enable the other interrupts after
 			   10*82usec ticks. */
-			writel(AbnormalIntr | TimerInt, ioaddr + IntrEnable);
-			writel(10, ioaddr + GPTimer);
+			spin_lock(&np->lock);
+			if (!np->dev_suspended) {
+				writel(AbnormalIntr | TimerInt, ioaddr + IntrEnable);
+				writel(10, ioaddr + GPTimer);
+			}
+			spin_unlock(&np->lock);
 			break;
 		}
 	} while (1);
@@ -1082,8 +1226,6 @@
 	if (debug > 3)
 		printk(KERN_DEBUG "%s: exiting interrupt, status=%#4.4x.\n",
 			   dev->name, (int)readl(ioaddr + IntrStatus));
-
-	spin_unlock(&np->lock);
 }
 
 /* This routine is logically part of the interrupt handler, but separated
@@ -1102,7 +1244,7 @@
 	/* If EOP is set on the next entry, it's a new packet. Send it up. */
 	while (--work_limit >= 0) {
 		struct w840_rx_desc *desc = np->rx_head_desc;
-		s32 status = le32_to_cpu(desc->status);
+		s32 status = desc->status;
 
 		if (debug > 4)
 			printk(KERN_DEBUG "  netdev_rx() status was %8.8x.\n",
@@ -1198,10 +1340,10 @@
 			np->rx_addr[entry] = pci_map_single(np->pci_dev,
 							skb->tail,
 							skb->len, PCI_DMA_FROMDEVICE);
-			np->rx_ring[entry].buffer1 = cpu_to_le32(np->rx_addr[entry]);
+			np->rx_ring[entry].buffer1 = np->rx_addr[entry];
 		}
 		wmb();
-		np->rx_ring[entry].status = cpu_to_le32(DescOwn);
+		np->rx_ring[entry].status = DescOwn;
 	}
 
 	return 0;
@@ -1218,31 +1360,36 @@
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
 	}
 	if (intr_status & TimerInt) {
 		/* Re-enable other interrupts. */
-		writel(0x1A0F5, ioaddr + IntrEnable);
+		spin_lock(&np->lock);
+		if (!np->dev_suspended)
+			writel(0x1A0F5, ioaddr + IntrEnable);
+		spin_unlock(&np->lock);
 	}
 	np->stats.rx_missed_errors += readl(ioaddr + RxMissed) & 0xffff;
 	writel(0, ioaddr + RxStartDemand);
@@ -1307,26 +1454,57 @@
 	}
 	writel(mc_filter[0], ioaddr + MulticastFilter0);
 	writel(mc_filter[1], ioaddr + MulticastFilter1);
-	np->csr6 &= ~0x00F8;
-	np->csr6 |= rx_mode;
-	writel(np->csr6, ioaddr + NetworkConfig);
+	spin_lock_irq(&np->lock);
+	update_csr6(dev, (np->csr6 & ~0x00F8) | rx_mode);
+	spin_unlock_irq(&np->lock);
+}
+
+static int netdev_ethtool_ioctl(struct net_device *dev, void *useraddr)
+{
+	struct netdev_private *np = dev->priv;
+	u32 ethcmd;
+		
+	if (copy_from_user(&ethcmd, useraddr, sizeof(ethcmd)))
+		return -EFAULT;
+
+        switch (ethcmd) {
+        case ETHTOOL_GDRVINFO: {
+		struct ethtool_drvinfo info = {ETHTOOL_GDRVINFO};
+		strcpy(info.driver, DRV_NAME);
+		strcpy(info.version, DRV_VERSION);
+		strcpy(info.bus_info, np->pci_dev->slot_name);
+		if (copy_to_user(useraddr, &info, sizeof(info)))
+			return -EFAULT;
+		return 0;
+	}
+
+        }
+	
+	return -EOPNOTSUPP;
 }
 
-static int mii_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
+	struct netdev_private *np = dev->priv;
 	u16 *data = (u16 *)&rq->ifr_data;
 
 	switch(cmd) {
+	case SIOCETHTOOL:
+		return netdev_ethtool_ioctl(dev, (void *) rq->ifr_data);
 	case SIOCDEVPRIVATE:		/* Get the address of the PHY in use. */
 		data[0] = ((struct netdev_private *)dev->priv)->phys[0] & 0x1f;
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
@@ -1337,7 +1515,6 @@
 {
 	long ioaddr = dev->base_addr;
 	struct netdev_private *np = dev->priv;
-	int i;
 
 	netif_stop_queue(dev);
 
@@ -1348,18 +1525,29 @@
 		printk(KERN_DEBUG "%s: Queue pointers were Tx %d / %d,  Rx %d / %d.\n",
 			   dev->name, np->cur_tx, np->dirty_tx, np->cur_rx, np->dirty_rx);
 	}
+	/* Stop the chip's Tx and Rx processes. */
+	spin_lock_irq(&np->lock);
+	update_csr6(dev, np->csr6 & ~0x20FA);
 
-	/* Disable interrupts by clearing the interrupt mask. */
+	/* and now disable the interrupt handler handler
+	 * dev_suspended is required to prevent a TimerInt
+	 * from reenabling the interrupts.
+	 * The rntl_lock prevents concurrent _suspend calls.
+	 */
+	np->dev_suspended = 1;
 	writel(0x0000, ioaddr + IntrEnable);
+	spin_unlock_irq(&np->lock);
 
-	/* Stop the chip's Tx and Rx processes. */
-	writel(np->csr6 &= ~0x20FA, ioaddr + NetworkConfig);
+	free_irq(dev->irq, dev);
+	wmb();
+	np->dev_suspended = 0;
 
 	if (readl(ioaddr + NetworkConfig) != 0xffffffff)
 		np->stats.rx_missed_errors += readl(ioaddr + RxMissed) & 0xffff;
 
 #ifdef __i386__
 	if (debug > 2) {
+		int i;
 		printk("\n"KERN_DEBUG"  Tx ring at %8.8x:\n",
 			   (int)np->tx_ring);
 		for (i = 0; i < TX_RING_SIZE; i++)
@@ -1376,11 +1564,10 @@
 	}
 #endif /* __i386__ debugging only */
 
-	free_irq(dev->irq, dev);
-
 	del_timer_sync(&np->timer);
 
 	free_rxtx_rings(np);
+	free_ringdesc(np);
 
 	return 0;
 }
@@ -1402,11 +1589,70 @@
 	pci_set_drvdata(pdev, NULL);
 }
 
+static void w840_suspend (struct pci_dev *pdev)
+{
+	struct net_device *dev = pci_get_drvdata (pdev);
+	struct netdev_private *np = dev->priv;
+	long ioaddr = dev->base_addr;
+
+	netif_device_detach(dev);
+	/* no more calls to tx_timeout, hard_start_xmit, set_rx_mode */
+	rtnl_lock();
+	rtnl_unlock();
+	/* noone within ->open */
+	if (netif_running (dev)) {
+		del_timer_sync(&np->timer);
+		/* no more link beat timer calls */
+		spin_lock_irq(&np->lock);
+		update_csr6(dev, np->csr6 & ~0x2002);
+		/* Tx and Rx processes stopped */
+
+		np->dev_suspended = 1;
+		writel(0, ioaddr + IntrEnable);
+		/* all irq events disabled. */
+		spin_unlock_irq(&np->lock);
+
+		synchronize_irq();
+
+		/* Update the error counts. */
+		np->stats.rx_missed_errors += readl(ioaddr + RxMissed) & 0xffff;
+
+		/* pci_power_off(pdev, -1); */
+
+		free_rxtx_rings(np);
+	}
+}
+
+
+static void w840_resume (struct pci_dev *pdev)
+{
+	struct net_device *dev = pci_get_drvdata (pdev);
+	struct netdev_private *np = dev->priv;
+
+	if (netif_running (dev)) {
+		pci_enable_device(pdev);
+	/*	pci_power_on(pdev); */
+		np->dev_suspended = 0;
+
+		writel(1, dev->base_addr+PCIBusCfg);
+		readl(dev->base_addr+PCIBusCfg);
+		udelay(1);
+		init_rxtx_rings(dev);
+		init_registers(dev);
+
+		np->timer.expires = jiffies + 1*HZ;
+		add_timer(&np->timer);
+	}
+	netif_device_attach(dev);
+}
+
 static struct pci_driver w840_driver = {
-	name:		"winbond-840",
+	name:		DRV_NAME,
 	id_table:	w840_pci_tbl,
 	probe:		w840_probe1,
 	remove:		w840_remove1,
+	suspend:	w840_suspend,
+	resume:		w840_resume,
 };
 
 static int __init w840_init(void)

--------------3F05165498BC30925C0DE839--


