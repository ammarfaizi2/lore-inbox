Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129325AbQLOAy6>; Thu, 14 Dec 2000 19:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132828AbQLOAys>; Thu, 14 Dec 2000 19:54:48 -0500
Received: from [212.32.186.211] ([212.32.186.211]:10896 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S129325AbQLOAyo>; Thu, 14 Dec 2000 19:54:44 -0500
Date: Fri, 15 Dec 2000 01:23:53 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Simon Huggins <huggie@earth.li>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: D-LINK DFE-530-TX [patch]
In-Reply-To: <E146DCA-0002qm-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0012150028560.5470-100000@cola.svenskatest.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2000, Alan Cox wrote:

> > > > Becker's site http://www.scyld.com/network.
> > > 2.4.x-test has some fixes for via-rhine which don't appear to have made
> > > it into the Becker driver yet...
> > 
> > Is either of these likely to make it into the stock 2.2 via-rhine?
> 
> If someone ports them over for an earlyish 2.2.19pre

Your wish ...

Below a patch that updates the 2.2 via-rhine driver from Becker's 1.08b,
except for the pci probing that is unchanged, compatibility macros and
dead code that are not needed in 2.2 removed (removing ifdef CARDBUS is
from 1.08b) and "clear_tally_counters" from 2.4.

It would be nice if people using 2.2 and one of these cards could test
this too.

Patch includes:
+ new VT6102 pci id & supporting non-aligned data buffers for that chip
+ completely untested (by me, that is) big<->little endian stuff
+ free allocated memory on driver unload
+ no more writel to 0x7c.
+ 2 16bit values accessed as one 32bit (why? not sure, pci optimization?)
+ change transmit ring size
and some other more or less minor changes/cleanups.

This is mostly a copy&paste operation. If you'd rather get a smaller
change for just supporting the VT6102 that is easy to do.

However, this is very similar to the 2.4 driver (locking is a major diff)
so I hope it is ok. Also, if I don't include most of the 1.08b driver I'm
not sure what version name to give it ... :)

/Urban


diff -ur -X exclude linux-2.2.18-orig/drivers/net/via-rhine.c linux/drivers/net/via-rhine.c
--- linux-2.2.18-orig/drivers/net/via-rhine.c	Wed Dec 13 21:27:37 2000
+++ linux/drivers/net/via-rhine.c	Fri Dec 15 00:03:59 2000
@@ -1,35 +1,44 @@
 /* via-rhine.c: A Linux Ethernet device driver for VIA Rhine family chips. */
 /*
-	Written 1998-1999 by Donald Becker.
+	Written 1998-2000 by Donald Becker.
 
-	This software may be used and distributed according to the terms
-	of the GNU Public License (GPL), incorporated herein by reference.
-	Drivers derived from this code also fall under the GPL and must retain
-	this authorship and copyright notice.
+	This software may be used and distributed according to the terms of
+	the GNU General Public License (GPL), incorporated herein by reference.
+	Drivers based on or derived from this code fall under the GPL and must
+	retain the authorship, copyright and license notice.  This file is not
+	a complete program and may only be used when the entire operating
+	system is licensed under the GPL.
 
 	This driver is designed for the VIA VT86c100A Rhine-II PCI Fast Ethernet
 	controller.  It also works with the older 3043 Rhine-I chip.
 
-	The author may be reached as becker@cesdis.edu, or
-	Donald Becker
-	312 Severn Ave. #W302
+	The author may be reached as becker@scyld.com, or C/O
+	Scyld Computing Corporation
+	410 Severn Ave., Suite 210
 	Annapolis MD 21403
 
 	Support and updates available at
-	http://cesdis.gsfc.nasa.gov/linux/drivers/via-rhine.html
+	http://www.scyld.com/network/via-rhine.html
+
+
+	Linux kernel version history:
+
+	LK1.0.0:
+	- Urban Widmark: merges from Beckers 1.08b version and 2.4.0 (VT6102)
 */
 
-static const char *versionA =
-"via-rhine.c:v1.01 2/27/99  Written by Donald Becker\n";
-static const char *versionB =
-"  http://cesdis.gsfc.nasa.gov/linux/drivers/via-rhine.html\n";
+/* These identify the driver base version and may not be removed. */
+static const char version1[] =
+"via-rhine.c:v1.08b-LK1.0.0 12/14/2000  Written by Donald Becker\n";
+static const char version2[] =
+"  http://www.scyld.com/network/via-rhine.html\n";
 
-/* A few user-configurable values.   These may be modified when a driver
-   module is loaded.*/
+/* The user-configurable values.
+   These may be modified when a driver module is loaded.*/
 
 static int debug = 1;			/* 1 normal messages, 0 quiet .. 7 verbose. */
 static int max_interrupt_work = 20;
-static int min_pci_latency = 64;
+static int min_pci_latency = 32;
 
 /* Set the copy breakpoint for the copy-only-tiny-frames scheme.
    Setting to > 1518 effectively disables this feature. */
@@ -55,7 +64,8 @@
    Making the Tx ring too large decreases the effectiveness of channel
    bonding and packet priority.
    There are no ill effects from too-large receive rings. */
-#define TX_RING_SIZE	8
+#define TX_RING_SIZE	16
+#define TX_QUEUE_LEN	10		/* Limit ring entries actually used.  */
 #define RX_RING_SIZE	16
 
 /* Operational parameters that usually are not changed. */
@@ -64,9 +74,15 @@
 
 #define PKT_BUF_SZ		1536			/* Size of each temporary Rx buffer.*/
 
+
+#if !defined(__OPTIMIZE__)
+#warning  You must compile this file with the correct options!
+#warning  See the last lines of the source file.
+#error  You must compile this driver with "-O".
+#endif
+
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/version.h>
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/errno.h>
@@ -82,15 +98,17 @@
 #include <asm/bitops.h>
 #include <asm/io.h>
 
-/* This driver was written to use PCI memory space, however some x86
-   motherboards only configure I/O space accesses correctly. */
-#if defined(__i386__)  &&  !defined(VIA_USE_MEMORY)
-#define VIA_USE_IO
-#endif
-#if defined(__alpha__)
-#define VIA_USE_IO
-#endif
-#ifdef VIA_USE_IO
+/* Condensed bus+endian portability operations. */
+#define virt_to_le32desc(addr) cpu_to_le32(virt_to_bus(addr))
+#define le32desc_to_virt(addr) bus_to_virt(le32_to_cpu(addr))
+
+/* This driver was written to use PCI memory space, however most versions
+   of the Rhine only work correctly with I/O space accesses. */
+#if defined(VIA_USE_MEMORY)
+#warning Many adapters using the VIA Rhine chip are not configured to work
+#warning with PCI memory space accesses.
+#else
+#define USE_IO_OPS
 #undef readb
 #undef readw
 #undef readl
@@ -105,21 +123,7 @@
 #define writel outl
 #endif
 
-/* Kernel compatibility defines, some common to David Hind's PCMCIA package.
-   This is only in the support-all-kernels source code. */
-
-#define RUN_AT(x) (jiffies + (x))
-
-#if (LINUX_VERSION_CODE >= 0x20100)
-static char kernel_version[] = UTS_RELEASE;
-#else
-#ifndef __alpha__
-#define ioremap vremap
-#define iounmap vfree
-#endif
-#endif
-#if defined(MODULE) && LINUX_VERSION_CODE > 0x20115
-MODULE_AUTHOR("Donald Becker <becker@cesdis.gsfc.nasa.gov>");
+MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
 MODULE_DESCRIPTION("VIA Rhine PCI Fast Ethernet driver");
 MODULE_PARM(max_interrupt_work, "i");
 MODULE_PARM(min_pci_latency, "i");
@@ -127,28 +131,6 @@
 MODULE_PARM(rx_copybreak, "i");
 MODULE_PARM(options, "1-" __MODULE_STRING(MAX_UNITS) "i");
 MODULE_PARM(full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
-#endif
-#if LINUX_VERSION_CODE < 0x20123
-#define test_and_set_bit(val, addr) set_bit(val, addr)
-#endif
-#if LINUX_VERSION_CODE <= 0x20139
-#define	net_device_stats enet_statistics
-#else
-#define NETSTATS_VER2
-#endif
-#if LINUX_VERSION_CODE < 0x20155  ||  defined(CARDBUS)
-/* Grrrr, the PCI code changed, but did not consider CardBus... */
-#include <linux/bios32.h>
-#define PCI_SUPPORT_VER1
-#else
-#define PCI_SUPPORT_VER2
-#endif
-#if LINUX_VERSION_CODE < 0x20159
-#define dev_free_skb(skb) dev_kfree_skb(skb, FREE_WRITE);
-#else
-#define dev_free_skb(skb) dev_kfree_skb(skb);
-#endif
-
 
 /*
 				Theory of Operation
@@ -226,13 +208,13 @@
 IVb. References
 
 Preliminary VT86C100A manual from http://www.via.com.tw/
-http://cesdis.gsfc.nasa.gov/linux/misc/100mbps.html
-http://cesdis.gsfc.nasa.gov/linux/misc/NWay.html
+http://www.scyld.com/expert/100mbps.html
+http://www.scyld.com/expert/NWay.html
 
 IVc. Errata
 
 The VT86C100A manual is not reliable information.
-The chip does not handle unaligned transmit or receive buffers, resulting
+The 3043 chip does not handle unaligned transmit or receive buffers, resulting
 in significant performance degradation for bounce buffer copies on transmit
 and unaligned IP headers on receive.
 The chip does not pad to minimum transmit length.
@@ -250,6 +232,15 @@
 	PCI_USES_IO=1, PCI_USES_MEM=2, PCI_USES_MASTER=4,
 	PCI_ADDR0=0x10<<0, PCI_ADDR1=0x10<<1, PCI_ADDR2=0x10<<2, PCI_ADDR3=0x10<<3,
 };
+
+#if defined(VIA_USE_MEMORY)
+#define RHINE_IOTYPE (PCI_USES_MEM | PCI_USES_MASTER | PCI_ADDR0)
+#define RHINEII_IOSIZE 4096
+#else
+#define RHINE_IOTYPE (PCI_USES_IO  | PCI_USES_MASTER | PCI_ADDR1)
+#define RHINEII_IOSIZE 256
+#endif
+
 struct pci_id_info {
 	const char *name;
 	u16	vendor_id, device_id, device_id_mask, flags;
@@ -264,34 +255,41 @@
 
 static struct pci_id_info pci_tbl[] __initdata = {
 	{ "VIA VT86C100A Rhine-II", 0x1106, 0x6100, 0xffff,
-	  PCI_USES_MEM|PCI_USES_IO|PCI_USES_MEM|PCI_USES_MASTER, 128, via_probe1},
+	  RHINE_IOTYPE, 128, via_probe1},
+	{ "VIA VT6102 Rhine-II", 0x1106, 0x3065, 0xffff,
+	  RHINE_IOTYPE, RHINEII_IOSIZE, via_probe1},
 	{ "VIA VT3043 Rhine", 0x1106, 0x3043, 0xffff,
-	  PCI_USES_IO|PCI_USES_MEM|PCI_USES_MASTER, 128, via_probe1},
+	  RHINE_IOTYPE, 128, via_probe1},
 	{0,},						/* 0 terminated list. */
 };
 
 
 /* A chip capabilities table, matching the entries in pci_tbl[] above. */
-enum chip_capability_flags {CanHaveMII=1, };
+enum chip_capability_flags {
+	CanHaveMII=1, HasESIPhy=2, HasDavicomPhy=4,
+	ReqTxAlign=0x10, HasWOL=0x20,
+};
+
 struct chip_info {
 	int io_size;
 	int flags;
 } static cap_tbl[] __initdata = {
-	{128, CanHaveMII, },
-	{128, CanHaveMII, },
+	{128, CanHaveMII | ReqTxAlign, },
+	{128, CanHaveMII | HasWOL, },
+	{128, CanHaveMII | ReqTxAlign, },
 };
 
 
-/* Offsets to the device registers.
-*/
+/* Offsets to the device registers. */
 enum register_offsets {
 	StationAddr=0x00, RxConfig=0x06, TxConfig=0x07, ChipCmd=0x08,
 	IntrStatus=0x0C, IntrEnable=0x0E,
 	MulticastFilter0=0x10, MulticastFilter1=0x14,
 	RxRingPtr=0x18, TxRingPtr=0x1C,
-	MIIPhyAddr=0x6C, MIIStatus=0x6D, PCIConfig=0x6E,
+	MIIPhyAddr=0x6C, MIIStatus=0x6D, PCIBusConfig=0x6E,
 	MIICmd=0x70, MIIRegAddr=0x71, MIIData=0x72,
-	Config=0x78, RxMissed=0x7C, RxCRCErrs=0x7E,
+	Config=0x78, ConfigA=0x7A, RxMissed=0x7C, RxCRCErrs=0x7E,
+	StickyHW=0x83, WOLcrClr=0xA4, WOLcgClr=0xA7, PwrcsrClr=0xAC,
 };
 
 /* Bits in the interrupt status/mask registers. */
@@ -303,21 +301,18 @@
 	IntrRxOverflow=0x0400, IntrRxDropped=0x0800, IntrRxNoBuf=0x1000,
 	IntrTxAborted=0x2000, IntrLinkChange=0x4000,
 	IntrRxWakeUp=0x8000,
-	IntrNormalSummary=0x0003, IntrAbnormalSummary=0x8260,
+	IntrNormalSummary=0x0003, IntrAbnormalSummary=0xC260,
 };
 
-
 /* The Rx and Tx buffer descriptors. */
 struct rx_desc {
-	u16 rx_status;
-	u16 rx_length;
+	s32 rx_status;
 	u32 desc_length;
 	u32 addr;
 	u32 next_desc;
 };
 struct tx_desc {
-	u16 tx_status;
-	u16 tx_own;
+	s32 tx_status;
 	u32 desc_length;
 	u32 addr;
 	u32 next_desc;
@@ -325,9 +320,10 @@
 
 /* Bits in *_desc.status */
 enum rx_status_bits {
-	RxDescOwn=0x80000000, RxOK=0x8000, RxWholePkt=0x0300, RxErr=0x008F};
+	RxOK=0x8000, RxWholePkt=0x0300, RxErr=0x008F
+};
 enum desc_status_bits {
-	DescOwn=0x8000, DescEndPacket=0x4000, DescIntr=0x1000,
+	DescOwn=0x80000000, DescEndPacket=0x4000, DescIntr=0x1000,
 };
 
 /* Bits in ChipCmd. */
@@ -338,6 +334,7 @@
 	CmdNoTxPoll=0x0800, CmdReset=0x8000,
 };
 
+#define PRIV_ALIGN	15	/* Required alignment mask */
 struct netdev_private {
 	/* Descriptor rings first for alignment. */
 	struct rx_desc rx_ring[RX_RING_SIZE];
@@ -349,12 +346,12 @@
 	unsigned char *tx_buf[TX_RING_SIZE];	/* Tx bounce buffers */
 	unsigned char *tx_bufs;				/* Tx bounce buffer region. */
 	struct device *next_module;			/* Link for devices of this type. */
+	void *priv_addr;					/* Unaligned address for kfree */
 	struct net_device_stats stats;
 	struct timer_list timer;	/* Media monitoring timer. */
 	unsigned char pci_bus, pci_devfn;
 	/* Frequently used values: keep some adjacent for cache effect. */
-	int chip_id;
-	long in_interrupt;			/* Word-long for SMP locks. */
+	int chip_id, drv_flags;
 	struct rx_desc *rx_head_desc;
 	unsigned int cur_rx, dirty_rx;		/* Producer/consumer ring indices */
 	unsigned int cur_tx, dirty_tx;
@@ -388,6 +385,7 @@
 static struct net_device_stats *get_stats(struct device *dev);
 static int mii_ioctl(struct device *dev, struct ifreq *rq, int cmd);
 static int  netdev_close(struct device *dev);
+static inline void clear_tally_counters(long ioaddr);
 
 
 
@@ -432,30 +430,13 @@
 			continue;
 
 		{
-#if defined(PCI_SUPPORT_VER2)
 			struct pci_dev *pdev = pci_find_slot(pci_bus, pci_device_fn);
-#ifdef VIA_USE_IO
+#ifdef USE_IO_OPS
 			pciaddr = pdev->base_address[0];
 #else
 			pciaddr = pdev->base_address[1];
 #endif
 			irq = pdev->irq;
-#else
-			u32 pci_memaddr;
-			u8 pci_irq_line;
-			pcibios_read_config_byte(pci_bus, pci_device_fn,
-									 PCI_INTERRUPT_LINE, &pci_irq_line);
-#ifdef VIA_USE_IO
-			pcibios_read_config_dword(pci_bus, pci_device_fn,
-									  PCI_BASE_ADDRESS_0, &pci_memaddr);
-			pciaddr = pci_memaddr;
-#else
-			pcibios_read_config_dword(pci_bus, pci_device_fn,
-									  PCI_BASE_ADDRESS_1, &pci_memaddr);
-			pciaddr = pci_memaddr;
-#endif
-			irq = pci_irq_line;
-#endif
 		}
 
 		if (debug > 2)
@@ -511,7 +492,7 @@
 {
 	static int did_version = 0;
 	if (!did_version++)
-		printk(KERN_INFO "%s" KERN_INFO "%s", versionA, versionB);
+		printk(KERN_INFO "%s" KERN_INFO "%s", version1, version2);
 	return pci_etherdev_probe(dev, pci_tbl);
 }
 #endif
@@ -521,6 +502,7 @@
 								 int chip_id, int card_idx)
 {
 	struct netdev_private *np;
+	void *priv_mem;
 	int i, option = card_idx < MAX_UNITS ? options[card_idx] : 0;
 
 	dev = init_etherdev(dev, 0);
@@ -528,14 +510,20 @@
 	printk(KERN_INFO "%s: %s at 0x%lx, ",
 		   dev->name, pci_tbl[chip_id].name, ioaddr);
 
-	/* Ideally we would be read the EEPROM but access may be locked. */
-	for (i = 0; i <6; i++)
+	/* We would prefer to read the EEPROM but access may be locked. */
+	for (i = 0; i < 6; i++)
 		dev->dev_addr[i] = readb(ioaddr + StationAddr + i);
 	for (i = 0; i < 5; i++)
 			printk("%2.2x:", dev->dev_addr[i]);
 	printk("%2.2x, IRQ %d.\n", dev->dev_addr[i], irq);
 
-#ifdef VIA_USE_IO
+	/* Allocate driver private memory for descriptor lists.
+	   Check for the very unlikely case of no memory. */
+	priv_mem = kmalloc(sizeof(*np) + PRIV_ALIGN, GFP_KERNEL);
+	if (priv_mem == NULL)
+		return NULL;
+
+#ifdef USE_IO_OPS
 	request_region(ioaddr, pci_tbl[chip_id].io_size, dev->name);
 #endif
 
@@ -546,9 +534,9 @@
 	dev->irq = irq;
 
 	/* Make certain the descriptor lists are cache-aligned. */
-	np = (void *)(((long)kmalloc(sizeof(*np), GFP_KERNEL) + 31) & ~31);
+	dev->priv = np = (void *)(((long)priv_mem + PRIV_ALIGN) & ~PRIV_ALIGN);
 	memset(np, 0, sizeof(*np));
-	dev->priv = np;
+	np->priv_addr = priv_mem;
 
 	np->next_module = root_net_dev;
 	root_net_dev = dev;
@@ -556,6 +544,7 @@
 	np->pci_bus = pci_bus;
 	np->pci_devfn = pci_devfn;
 	np->chip_id = chip_id;
+	np->drv_flags = cap_tbl[chip_id].flags;
 
 	if (dev->mem_start)
 		option = dev->mem_start;
@@ -582,7 +571,7 @@
 	dev->set_multicast_list = &set_rx_mode;
 	dev->do_ioctl = &mii_ioctl;
 
-	if (cap_tbl[np->chip_id].flags & CanHaveMII) {
+	if (np->drv_flags & CanHaveMII) {
 		int phy, phy_idx = 0;
 		np->phys[0] = 1;		/* Standard for this chip. */
 		for (phy = 1; phy < 32 && phy_idx < 4; phy++) {
@@ -625,9 +614,23 @@
 
 static void mdio_write(struct device *dev, int phy_id, int regnum, int value)
 {
+	struct netdev_private *np = (struct netdev_private *)dev->priv;
 	long ioaddr = dev->base_addr;
 	int boguscnt = 1024;
 
+	if (phy_id == np->phys[0]) {
+		switch (regnum) {
+		case 0:					/* Is user forcing speed/duplex? */
+			if (value & 0x9000)	/* Autonegotiation. */
+				np->duplex_lock = 0;
+			else
+				np->full_duplex = (value & 0x0100) ? 1 : 0;
+			break;
+		case 4:
+			np->advertising = value;
+			break;
+		}
+	}
 	/* Wait for a previous command to complete. */
 	while ((readb(ioaddr + MIICmd) & 0x60) && --boguscnt > 0)
 		;
@@ -649,15 +652,17 @@
 	/* Reset the chip. */
 	writew(CmdReset, ioaddr + ChipCmd);
 
-	if (request_irq(dev->irq, &intr_handler, SA_SHIRQ, dev->name, dev))
+	MOD_INC_USE_COUNT;
+
+	if (request_irq(dev->irq, &intr_handler, SA_SHIRQ, dev->name, dev)) {
+		MOD_DEC_USE_COUNT;
 		return -EAGAIN;
+	}
 
 	if (debug > 1)
 		printk(KERN_DEBUG "%s: netdev_open() irq %d.\n",
 			   dev->name, dev->irq);
 
-	MOD_INC_USE_COUNT;
-
 	init_ring(dev);
 
 	writel(virt_to_bus(np->rx_ring), ioaddr + RxRingPtr);
@@ -667,7 +672,7 @@
 		writeb(dev->dev_addr[i], ioaddr + StationAddr + i);
 
 	/* Initialize other registers. */
-	writew(0x0006, ioaddr + PCIConfig);	/* Tune configuration??? */
+	writew(0x0006, ioaddr + PCIBusConfig);	/* Tune configuration??? */
 	/* Configure the FIFO thresholds. */
 	writeb(0x20, ioaddr + TxConfig);	/* Initial threshold 32 bytes */
 	np->tx_thresh = 0x20;
@@ -678,7 +683,6 @@
 
 	dev->tbusy = 0;
 	dev->interrupt = 0;
-	np->in_interrupt = 0;
 
 	set_rx_mode(dev);
 
@@ -696,6 +700,11 @@
 	writew(np->chip_cmd, ioaddr + ChipCmd);
 
 	check_duplex(dev);
+	/* The LED outputs of various MII xcvrs should be configured.  */
+	/* For NS or Mison phys, turn on bit 1 in register 0x17 */
+	/* For ESI phys, turn on bit 7 in register 0x17. */
+	mdio_write(dev, np->phys[0], 0x17, mdio_read(dev, np->phys[0], 0x17) |
+			   (np->drv_flags & HasESIPhy) ? 0x0080 : 0x0001);
 
 	if (debug > 2)
 		printk(KERN_DEBUG "%s: Done netdev_open(), status %4.4x "
@@ -705,7 +714,7 @@
 
 	/* Set the timer to check for link beat. */
 	init_timer(&np->timer);
-	np->timer.expires = RUN_AT(1);
+	np->timer.expires = jiffies + 2;
 	np->timer.data = (unsigned long)dev;
 	np->timer.function = &netdev_timer;				/* timer handler */
 	add_timer(&np->timer);
@@ -718,11 +727,12 @@
 	struct netdev_private *np = (struct netdev_private *)dev->priv;
 	long ioaddr = dev->base_addr;
 	int mii_reg5 = mdio_read(dev, np->phys[0], 5);
+	int negotiated = mii_reg5 & np->advertising;
 	int duplex;
 
 	if (np->duplex_lock  ||  mii_reg5 == 0xffff)
 		return;
-	duplex = (mii_reg5 & 0x0100) || (mii_reg5 & 0x01C0) == 0x0040;
+	duplex = (negotiated & 0x0100) || (negotiated & 0x01C0) == 0x0040;
 	if (np->full_duplex != duplex) {
 		np->full_duplex = duplex;
 		if (debug)
@@ -748,9 +758,14 @@
 		printk(KERN_DEBUG "%s: VIA Rhine monitor tick, status %4.4x.\n",
 			   dev->name, readw(ioaddr + IntrStatus));
 	}
+	if (test_bit(0, (void*)&dev->tbusy) != 0
+		&& np->cur_tx - np->dirty_tx > 1
+		&& jiffies - dev->trans_start > TX_TIMEOUT)
+		tx_timeout(dev);
+
 	check_duplex(dev);
 
-	np->timer.expires = RUN_AT(next_tick);
+	np->timer.expires = jiffies + next_tick;
 	add_timer(&np->timer);
 }
 
@@ -764,15 +779,15 @@
 		   dev->name, readw(ioaddr + IntrStatus),
 		   mdio_read(dev, np->phys[0], 1));
 
-  /* Perhaps we should reinitialize the hardware here. */
-  dev->if_port = 0;
-  /* Stop and restart the chip's Tx processes . */
-
-  /* Trigger an immediate transmit demand. */
-
-  dev->trans_start = jiffies;
-  np->stats.tx_errors++;
-  return;
+	/* Perhaps we should reinitialize the hardware here. */
+	dev->if_port = 0;
+	/* Stop and restart the chip's Tx processes . */
+
+	/* Trigger an immediate transmit demand. */
+
+	dev->trans_start = jiffies;
+	np->stats.tx_errors++;
+	return;
 }
 
 
@@ -791,35 +806,33 @@
 
 	for (i = 0; i < RX_RING_SIZE; i++) {
 		np->rx_ring[i].rx_status = 0;
-		np->rx_ring[i].rx_length = 0;
-		np->rx_ring[i].desc_length = np->rx_buf_sz;
-		np->rx_ring[i].next_desc = virt_to_bus(&np->rx_ring[i+1]);
+		np->rx_ring[i].desc_length = cpu_to_le32(np->rx_buf_sz);
+		np->rx_ring[i].next_desc = virt_to_le32desc(&np->rx_ring[i+1]);
 		np->rx_skbuff[i] = 0;
 	}
 	/* Mark the last entry as wrapping the ring. */
-	np->rx_ring[i-1].next_desc = virt_to_bus(&np->rx_ring[0]);
+	np->rx_ring[i-1].next_desc = virt_to_le32desc(&np->rx_ring[0]);
 
-	/* Fill in the Rx buffers. */
+	/* Fill in the Rx buffers.  Handle allocation failure gracefully. */
 	for (i = 0; i < RX_RING_SIZE; i++) {
 		struct sk_buff *skb = dev_alloc_skb(np->rx_buf_sz);
 		np->rx_skbuff[i] = skb;
 		if (skb == NULL)
 			break;
 		skb->dev = dev;			/* Mark as being used by this device. */
-		np->rx_ring[i].addr = virt_to_bus(skb->tail);
-		np->rx_ring[i].rx_status = 0;
-		np->rx_ring[i].rx_length = DescOwn;
+		np->rx_ring[i].addr = virt_to_le32desc(skb->tail);
+		np->rx_ring[i].rx_status = cpu_to_le32(DescOwn);
 	}
 	np->dirty_rx = (unsigned int)(i - RX_RING_SIZE);
 
 	for (i = 0; i < TX_RING_SIZE; i++) {
 		np->tx_skbuff[i] = 0;
-		np->tx_ring[i].tx_own = 0;
-		np->tx_ring[i].desc_length = 0x00e08000;
-		np->tx_ring[i].next_desc = virt_to_bus(&np->tx_ring[i+1]);
+		np->tx_ring[i].tx_status = 0;
+		np->tx_ring[i].desc_length = cpu_to_le32(0x00e08000);
+		np->tx_ring[i].next_desc = virt_to_le32desc(&np->tx_ring[i+1]);
 		np->tx_buf[i] = kmalloc(PKT_BUF_SZ, GFP_KERNEL);
 	}
-	np->tx_ring[i-1].next_desc = virt_to_bus(&np->tx_ring[0]);
+	np->tx_ring[i-1].next_desc = virt_to_le32desc(&np->tx_ring[0]);
 
 	return;
 }
@@ -832,41 +845,45 @@
 	/* Block a timer-based transmit from overlapping.  This could better be
 	   done with atomic_swap(1, dev->tbusy), but set_bit() works as well. */
 	if (test_and_set_bit(0, (void*)&dev->tbusy) != 0) {
-		if (jiffies - dev->trans_start < TX_TIMEOUT)
-			return 1;
-		tx_timeout(dev);
+		/* This watchdog code is redundant with the media monitor timer. */
+		if (jiffies - dev->trans_start > TX_TIMEOUT)
+			tx_timeout(dev);
 		return 1;
 	}
 
-	/* Caution: the write order is important here, set the field
-	   with the "ownership" bits last. */
+	/* Explicitly flush packet data cache lines here. */
+
+	/* Caution: the write order is important here, set the descriptor word
+	   with the "ownership" bit last.  No SMP locking is needed if the
+	   cur_tx is incremented after the descriptor is consistent.  */
 
 	/* Calculate the next Tx descriptor entry. */
 	entry = np->cur_tx % TX_RING_SIZE;
 
 	np->tx_skbuff[entry] = skb;
 
-	if ((long)skb->data & 3) {			/* Must use alignment buffer. */
+	if ((np->drv_flags & ReqTxAlign)  && ((long)skb->data & 3)) {
+		/* Must use alignment buffer. */
 		if (np->tx_buf[entry] == NULL &&
 			(np->tx_buf[entry] = kmalloc(PKT_BUF_SZ, GFP_KERNEL)) == NULL)
 			return 1;
 		memcpy(np->tx_buf[entry], skb->data, skb->len);
-		np->tx_ring[entry].addr = virt_to_bus(np->tx_buf[entry]);
+		np->tx_ring[entry].addr = virt_to_le32desc(np->tx_buf[entry]);
 	} else
-		np->tx_ring[entry].addr = virt_to_bus(skb->data);
+		np->tx_ring[entry].addr = virt_to_le32desc(skb->data);
 
-	np->tx_ring[entry].desc_length = 0x00E08000 |
-		(skb->len >= ETH_ZLEN ? skb->len : ETH_ZLEN);
-	np->tx_ring[entry].tx_own = DescOwn;
+	np->tx_ring[entry].desc_length =
+		cpu_to_le32(0x00E08000 | (skb->len >= ETH_ZLEN ? skb->len : ETH_ZLEN));
+	np->tx_ring[entry].tx_status = cpu_to_le32(DescOwn);
 
 	np->cur_tx++;
 
-	/* Non-x86 Todo: explicitly flush cache lines here. */
+	/* Explicitly flush descriptor cache lines here. */
 
 	/* Wake the potentially-idle transmit channel. */
 	writew(CmdTxDemand | np->chip_cmd, dev->base_addr + ChipCmd);
 
-	if (np->cur_tx - np->dirty_tx < TX_RING_SIZE - 1)
+	if (np->cur_tx - np->dirty_tx < TX_QUEUE_LEN - 1)
 		clear_bit(0, (void*)&dev->tbusy);		/* Typical path */
 	else
 		np->tx_full = 1;
@@ -884,26 +901,9 @@
 static void intr_handler(int irq, void *dev_instance, struct pt_regs *rgs)
 {
 	struct device *dev = (struct device *)dev_instance;
-	struct netdev_private *np;
-	long ioaddr, boguscnt = max_interrupt_work;
-
-	ioaddr = dev->base_addr;
-	np = (struct netdev_private *)dev->priv;
-#if defined(__i386__)
-	/* A lock to prevent simultaneous entry bug on Intel SMP machines. */
-	if (test_and_set_bit(0, (void*)&dev->interrupt)) {
-		printk(KERN_ERR"%s: SMP simultaneous entry of an interrupt handler.\n",
-			   dev->name);
-		dev->interrupt = 0;	/* Avoid halting machine. */
-		return;
-	}
-#else
-	if (dev->interrupt) {
-		printk(KERN_ERR "%s: Re-entering the interrupt handler.\n", dev->name);
-		return;
-	}
-	dev->interrupt = 1;
-#endif
+	struct netdev_private *np = (void *)dev->priv;
+	long ioaddr = dev->base_addr;
+	int boguscnt = max_interrupt_work;
 
 	do {
 		u32 intr_status = readw(ioaddr + IntrStatus);
@@ -924,10 +924,9 @@
 
 		for (; np->cur_tx - np->dirty_tx > 0; np->dirty_tx++) {
 			int entry = np->dirty_tx % TX_RING_SIZE;
-			int txstatus;
-			if (np->tx_ring[entry].tx_own)
+			int txstatus = le32_to_cpu(np->tx_ring[entry].tx_status);
+			if (txstatus & DescOwn)
 				break;
-			txstatus = np->tx_ring[entry].tx_status;
 			if (debug > 6)
 				printk(KERN_DEBUG " Tx scavenge %d status %4.4x.\n",
 					   entry, txstatus);
@@ -951,16 +950,16 @@
 #endif
 				np->stats.collisions += (txstatus >> 3) & 15;
 #if defined(NETSTATS_VER2)
-				np->stats.tx_bytes += np->tx_ring[entry].desc_length & 0x7ff;
+				np->stats.tx_bytes += np->tx_skbuff[entry]->len;
 #endif
 				np->stats.tx_packets++;
 			}
 			/* Free the original skb. */
-			dev_free_skb(np->tx_skbuff[entry]);
+			dev_kfree_skb(np->tx_skbuff[entry]);
 			np->tx_skbuff[entry] = 0;
 		}
 		if (np->tx_full && dev->tbusy
-			&& np->cur_tx - np->dirty_tx < TX_RING_SIZE - 4) {
+			&& np->cur_tx - np->dirty_tx < TX_QUEUE_LEN - 4) {
 			/* The ring is no longer full, clear tbusy. */
 			np->tx_full = 0;
 			clear_bit(0, (void*)&dev->tbusy);
@@ -984,11 +983,6 @@
 		printk(KERN_DEBUG "%s: exiting interrupt, status=%#4.4x.\n",
 			   dev->name, readw(ioaddr + IntrStatus));
 
-#if defined(__i386__)
-	clear_bit(0, (void*)&dev->interrupt);
-#else
-	dev->interrupt = 0;
-#endif
 	return;
 }
 
@@ -1001,15 +995,15 @@
 	int boguscnt = np->dirty_rx + RX_RING_SIZE - np->cur_rx;
 
 	if (debug > 4) {
-		printk(KERN_DEBUG " In netdev_rx(), entry %d status %4.4x.\n",
-			   entry, np->rx_head_desc->rx_length);
+		printk(KERN_DEBUG " In netdev_rx(), entry %d status %8.8x.\n",
+			   entry, np->rx_head_desc->rx_status);
 	}
 
 	/* If EOP is set on the next entry, it's a new packet. Send it up. */
-	while ( ! (np->rx_head_desc->rx_length & DescOwn)) {
+	while ( ! (np->rx_head_desc->rx_status & cpu_to_le32(DescOwn))) {
 		struct rx_desc *desc = np->rx_head_desc;
-		int data_size = desc->rx_length;
-		u16 desc_status = desc->rx_status;
+		u32 desc_status = le32_to_cpu(desc->rx_status);
+		int data_size = desc_status >> 16;
 
 		if (debug > 4)
 			printk(KERN_DEBUG "  netdev_rx() status is %4.4x.\n",
@@ -1039,7 +1033,7 @@
 		} else {
 			struct sk_buff *skb;
 			/* Length should omit the CRC */
-			u16 pkt_len = data_size - 4;
+			int pkt_len = data_size - 4;
 
 			/* Check if the packet is long enough to accept without copying
 			   to a minimally-sized skbuff. */
@@ -1047,21 +1041,23 @@
 				&& (skb = dev_alloc_skb(pkt_len + 2)) != NULL) {
 				skb->dev = dev;
 				skb_reserve(skb, 2);	/* 16 byte align the IP header */
-#if ! defined(__alpha__) || USE_IP_COPYSUM		/* Avoid misaligned on Alpha */
-				eth_copy_and_sum(skb, bus_to_virt(desc->addr),
-								 pkt_len, 0);
+#if HAS_IP_COPYSUM			/* Call copy + cksum if available. */
+				eth_copy_and_sum(skb, np->rx_skbuff[entry]->tail, pkt_len, 0);
 				skb_put(skb, pkt_len);
 #else
-				memcpy(skb_put(skb,pkt_len), bus_to_virt(desc->addr), pkt_len);
+				memcpy(skb_put(skb, pkt_len), np->rx_skbuff[entry]->tail,
+					   pkt_len);
 #endif
 			} else {
 				skb_put(skb = np->rx_skbuff[entry], pkt_len);
 				np->rx_skbuff[entry] = NULL;
 			}
 			skb->protocol = eth_type_trans(skb, dev);
-			np->stats.rx_bytes+=skb->len;
 			netif_rx(skb);
 			dev->last_rx = jiffies;
+#if defined(NETSTATS_VER2)
+			np->stats.rx_bytes += skb->len;
+#endif
 			np->stats.rx_packets++;
 		}
 		entry = (++np->cur_rx) % RX_RING_SIZE;
@@ -1078,10 +1074,9 @@
 			if (skb == NULL)
 				break;			/* Better luck next round. */
 			skb->dev = dev;			/* Mark as being used by this device. */
-			np->rx_ring[entry].addr = virt_to_bus(skb->tail);
+			np->rx_ring[entry].addr = virt_to_le32desc(skb->tail);
 		}
-		np->rx_ring[entry].rx_status = 0;
-		np->rx_ring[entry].rx_length = DescOwn;
+		np->rx_ring[entry].rx_status = cpu_to_le32(DescOwn);
 	}
 
 	/* Pre-emptively restart Rx engine. */
@@ -1095,10 +1090,11 @@
 	long ioaddr = dev->base_addr;
 
 	if (intr_status & (IntrMIIChange | IntrLinkChange)) {
-		if (readb(ioaddr + MIIStatus) & 0x02)
+		if (readb(ioaddr + MIIStatus) & 0x02) {
 			/* Link failed, restart autonegotiation. */
-			mdio_write(dev, np->phys[0], 0, 0x3300);
-		else
+			if (np->drv_flags & HasDavicomPhy)
+				mdio_write(dev, np->phys[0], 0, 0x3300);
+		} else
 			check_duplex(dev);
 		if (debug)
 			printk(KERN_ERR "%s: MII status changed: Autonegotiation "
@@ -1109,7 +1105,7 @@
 	if (intr_status & IntrStatsMax) {
 		np->stats.rx_crc_errors	+= readw(ioaddr + RxCRCErrs);
 		np->stats.rx_missed_errors	+= readw(ioaddr + RxMissed);
-		writel(0, RxMissed);
+		clear_tally_counters(ioaddr);
 	}
 	if (intr_status & IntrTxAbort) {
 		/* Stats counted in Tx-done handler, just restart Tx. */
@@ -1122,7 +1118,8 @@
 			printk(KERN_INFO "%s: Transmitter underrun, increasing Tx "
 				   "threshold setting to %2.2x.\n", dev->name, np->tx_thresh);
 	}
-	if ((intr_status & ~(IntrLinkChange|IntrStatsMax|IntrTxAbort)) && debug) {
+	if ((intr_status & ~(IntrLinkChange | IntrStatsMax |
+						 IntrTxAbort|IntrTxAborted))  &&  debug) {
 		printk(KERN_ERR "%s: Something Wicked happened! %4.4x.\n",
 			   dev->name, intr_status);
 		/* Recovery for other fault sources not known. */
@@ -1140,28 +1137,39 @@
 	   non-critical. */
 	np->stats.rx_crc_errors	+= readw(ioaddr + RxCRCErrs);
 	np->stats.rx_missed_errors	+= readw(ioaddr + RxMissed);
-	writel(0, RxMissed);
+	clear_tally_counters(ioaddr);
 
 	return &np->stats;
 }
 
+/* Clears the "tally counters" for CRC errors and missed frames(?).
+   It has been reported that some chips need a write of 0 to clear
+   these, for others the counters are set to 1 when written to and
+   instead cleared when read. So we clear them both ways ... */
+static inline void clear_tally_counters(const long ioaddr)
+{
+	writel(0, ioaddr + RxMissed);
+	readw(ioaddr + RxCRCErrs);
+	readw(ioaddr + RxMissed);
+}
+
 /* The big-endian AUTODIN II ethernet CRC calculation.
    N.B. Do not use for bulk data, use a table-based routine instead.
    This is common code and should be moved to net/core/crc.c */
 static unsigned const ethernet_polynomial = 0x04c11db7U;
 static inline u32 ether_crc(int length, unsigned char *data)
 {
-    int crc = -1;
+	int crc = -1;
 
-    while(--length >= 0) {
+	while(--length >= 0) {
 		unsigned char current_octet = *data++;
 		int bit;
 		for (bit = 0; bit < 8; bit++, current_octet >>= 1) {
 			crc = (crc << 1) ^
 				((crc < 0) ^ (current_octet & 1) ? ethernet_polynomial : 0);
 		}
-    }
-    return crc;
+	}
+	return crc;
 }
 
 static void set_rx_mode(struct device *dev)
@@ -1178,6 +1186,8 @@
 	} else if ((dev->mc_count > multicast_filter_limit)
 			   ||  (dev->flags & IFF_ALLMULTI)) {
 		/* Too many to match, or accept all multicasts. */
+		writel(0xffffffff, ioaddr + MulticastFilter0);
+		writel(0xffffffff, ioaddr + MulticastFilter1);
 		rx_mode = 0x0C;
 	} else {
 		struct dev_mc_list *mclist;
@@ -1190,7 +1200,7 @@
 		}
 		writel(mc_filter[0], ioaddr + MulticastFilter0);
 		writel(mc_filter[1], ioaddr + MulticastFilter1);
-		rx_mode = 0x08;
+		rx_mode = 0x0C;
 	}
 	writeb(np->rx_thresh | rx_mode, ioaddr + RxConfig);
 }
@@ -1207,7 +1217,7 @@
 		data[3] = mdio_read(dev, data[0] & 0x1f, data[1] & 0x1f);
 		return 0;
 	case SIOCDEVPRIVATE+2:		/* Write the specified MII register */
-		if (!suser())
+		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
 		mdio_write(dev, data[0] & 0x1f, data[1] & 0x1f, data[2]);
 		return 0;
@@ -1229,32 +1239,39 @@
 		printk(KERN_DEBUG "%s: Shutting down ethercard, status was %4.4x.\n",
 			   dev->name, readw(ioaddr + ChipCmd));
 
+	del_timer(&np->timer);
+
+	/* Switch to loopback mode to avoid hardware races. */
+	writeb(np->tx_thresh | 0x01, ioaddr + TxConfig);
+
 	/* Disable interrupts by clearing the interrupt mask. */
 	writew(0x0000, ioaddr + IntrEnable);
 
 	/* Stop the chip's Tx and Rx processes. */
 	writew(CmdStop, ioaddr + ChipCmd);
 
-	del_timer(&np->timer);
-
 	free_irq(dev->irq, dev);
 
 	/* Free all the skbuffs in the Rx queue. */
 	for (i = 0; i < RX_RING_SIZE; i++) {
-		np->rx_ring[i].rx_length = 0;
+		np->rx_ring[i].rx_status = 0;
 		np->rx_ring[i].addr = 0xBADF00D0; /* An invalid address. */
 		if (np->rx_skbuff[i]) {
 #if LINUX_VERSION_CODE < 0x20100
 			np->rx_skbuff[i]->free = 1;
 #endif
-			dev_free_skb(np->rx_skbuff[i]);
+			dev_kfree_skb(np->rx_skbuff[i]);
 		}
 		np->rx_skbuff[i] = 0;
 	}
 	for (i = 0; i < TX_RING_SIZE; i++) {
 		if (np->tx_skbuff[i])
-			dev_free_skb(np->tx_skbuff[i]);
+			dev_kfree_skb(np->tx_skbuff[i]);
 		np->tx_skbuff[i] = 0;
+		if (np->tx_buf[i]) {
+			kfree(np->tx_buf[i]);
+			np->tx_buf[i] = 0;
+		}
 	}
 
 	MOD_DEC_USE_COUNT;
@@ -1267,37 +1284,28 @@
 int init_module(void)
 {
 	if (debug)					/* Emit version even if no cards detected. */
-		printk(KERN_INFO "%s" KERN_INFO "%s", versionA, versionB);
-#ifdef CARDBUS
-	register_driver(&etherdev_ops);
-	return 0;
-#else
+		printk(KERN_INFO "%s" KERN_INFO "%s", version1, version2);
 	return pci_etherdev_probe(NULL, pci_tbl);
-#endif
 }
 
 void cleanup_module(void)
 {
-
-#ifdef CARDBUS
-	unregister_driver(&etherdev_ops);
-#endif
+	struct device *next_dev;
 
 	/* No need to check MOD_IN_USE, as sys_delete_module() checks. */
 	while (root_net_dev) {
-		struct netdev_private *np =
-			(struct netdev_private *)(root_net_dev->priv);
+		struct netdev_private *np = (void *)(root_net_dev->priv);
 		unregister_netdev(root_net_dev);
-#ifdef VIA_USE_IO
+#ifdef USE_IO_OPS
 		release_region(root_net_dev->base_addr, pci_tbl[np->chip_id].io_size);
 #else
 		iounmap((char *)(root_net_dev->base_addr));
 #endif
+		next_dev = np->next_module;
+		if (np->priv_addr)
+			kfree(np->priv_addr);
 		kfree(root_net_dev);
-		root_net_dev = np->next_module;
-#if 0
-		kfree(np);				/* Assumption: no struct realignment. */
-#endif
+		root_net_dev = next_dev;
 	}
 }
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
