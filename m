Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263811AbRFLXKg>; Tue, 12 Jun 2001 19:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263814AbRFLXK0>; Tue, 12 Jun 2001 19:10:26 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:61849 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263811AbRFLXKM>;
	Tue, 12 Jun 2001 19:10:12 -0400
Message-ID: <3B26A133.CE80A115@mandrakesoft.com>
Date: Tue, 12 Jun 2001 19:09:39 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bjorn Wesen <bjorn@sparta.lu.se>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: Via-rhine in 2.4.5 still requires cold-boot
In-Reply-To: <Pine.LNX.3.96.1010612234709.31447A-100000@medusa.sparta.lu.se>
Content-Type: multipart/mixed;
 boundary="------------EAF7B243B5BA9E026099E08D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------EAF7B243B5BA9E026099E08D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Bjorn Wesen wrote:
> Just for the record, the via-rhine.c in 2.4.5 still does not work if you
> soft-boot the computer (at least one a machine here), MAC address shows up
> as 00:00:00:00:00:00 and it fails - but a cold boot (power cable off, no
> standby power) makes it work.

This patch in gkernel cvs, against 2.4.5, should fix things.  It is
going to Linus as soon as pre3 appears and I can start syncing up with
him again.

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
--------------EAF7B243B5BA9E026099E08D
Content-Type: text/plain; charset=us-ascii;
 name="via-rhine.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="via-rhine.patch"

Index: linux_2_4/drivers/net/via-rhine.c
diff -u linux_2_4/drivers/net/via-rhine.c:1.1.1.27 linux_2_4/drivers/net/via-rhine.c:1.1.1.27.74.2
--- linux_2_4/drivers/net/via-rhine.c:1.1.1.27	Sun Apr 22 18:24:17 2001
+++ linux_2_4/drivers/net/via-rhine.c	Sun Jun 10 12:07:42 2001
@@ -1,6 +1,6 @@
 /* via-rhine.c: A Linux Ethernet device driver for VIA Rhine family chips. */
 /*
-	Written 1998-2000 by Donald Becker.
+	Written 1998-2001 by Donald Becker.
 
 	This software may be used and distributed according to the terms of
 	the GNU General Public License (GPL), incorporated herein by reference.
@@ -58,6 +58,12 @@
 	
 	LK1.1.7:
 	- Manfred Spraul: added reset into tx_timeout
+
+	LK1.1.9:
+	- Urban Widmark: merges from Beckers 1.10 version
+	                 (media selection + eeprom reload)
+	- David Vrabel:  merges from D-Link "1.11" version
+	                 (disable WOL and PME on startup)
 */
 
 
@@ -75,6 +81,11 @@
    Both 'options[]' and 'full_duplex[]' should exist for driver
    interoperability.
    The media type is usually passed in 'options[]'.
+   The default is autonegotation for speed and duplex.
+     This should rarely be overridden.
+   Use option values 0x10/0x20 for 10Mbps, 0x100,0x200 for 100Mbps.
+   Use option values 0x10 and 0x100 for forcing half duplex fixed speed.
+   Use option values 0x20 and 0x200 for forcing full duplex operation.
 */
 #define MAX_UNITS 8		/* More are supported, limit only on options */
 static int options[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
@@ -104,6 +115,9 @@
 
 #define PKT_BUF_SZ		1536			/* Size of each temporary Rx buffer.*/
 
+/* max time out delay time */
+#define W_MAX_TIMEOUT	0x0FFFU
+
 
 #if !defined(__OPTIMIZE__)  ||  !defined(__KERNEL__)
 #warning  You must compile this file with the correct options!
@@ -132,9 +146,10 @@
 
 /* These identify the driver base version and may not be removed. */
 static char version[] __devinitdata =
-KERN_INFO "via-rhine.c:v1.08b-LK1.1.8  4/17/2000  Written by Donald Becker\n"
+KERN_INFO "via-rhine.c:v1.10-LK1.1.9  05/31/2001  Written by Donald Becker\n"
 KERN_INFO "  http://www.scyld.com/network/via-rhine.html\n";
 
+static char shortname[] __devinitdata = "via-rhine";
 
 
 /* This driver was written to use PCI memory space, however most versions
@@ -165,8 +180,12 @@
 MODULE_PARM(rx_copybreak, "i");
 MODULE_PARM(options, "1-" __MODULE_STRING(MAX_UNITS) "i");
 MODULE_PARM(full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
+MODULE_PARM_DESC(max_interrupt_work, "VIA Rhine maximum events handled per interrupt");
+MODULE_PARM_DESC(debug, "VIA Rhine debug level (0-7)");
+MODULE_PARM_DESC(rx_copybreak, "VIA Rhine copy breakpoint for copy-only-tiny-frames");
+MODULE_PARM_DESC(options, "VIA Rhine: Bits 0-3: media type, bit 17: full duplex");
+MODULE_PARM_DESC(full_duplex, "VIA Rhine full duplex setting(s) (1)");
 
-
 /*
 				Theory of Operation
 
@@ -244,6 +263,9 @@
 Preliminary VT86C100A manual from http://www.via.com.tw/
 http://www.scyld.com/expert/100mbps.html
 http://www.scyld.com/expert/NWay.html
+ftp://ftp.via.com.tw/public/lan/Products/NIC/VT86C100A/Datasheet/VT86C100A03.pdf
+ftp://ftp.via.com.tw/public/lan/Products/NIC/VT6102/Datasheet/VT6102_021.PDF
+
 
 IVc. Errata
 
@@ -256,7 +278,6 @@
 */
 
 
-
 /* This table drives the PCI probe routines.  It's mostly boilerplate in all
    of the drivers, and will likely be provided by some future kernel.
    Note the matching code -- the first table entry matchs all 56** cards but
@@ -320,9 +341,9 @@
 	StationAddr=0x00, RxConfig=0x06, TxConfig=0x07, ChipCmd=0x08,
 	IntrStatus=0x0C, IntrEnable=0x0E,
 	MulticastFilter0=0x10, MulticastFilter1=0x14,
-	RxRingPtr=0x18, TxRingPtr=0x1C,
+	RxRingPtr=0x18, TxRingPtr=0x1C, GFIFOTest=0x54,
 	MIIPhyAddr=0x6C, MIIStatus=0x6D, PCIBusConfig=0x6E,
-	MIICmd=0x70, MIIRegAddr=0x71, MIIData=0x72,
+	MIICmd=0x70, MIIRegAddr=0x71, MIIData=0x72, MACRegEEcsr=0x74,
 	Config=0x78, ConfigA=0x7A, RxMissed=0x7C, RxCRCErrs=0x7E,
 	StickyHW=0x83, WOLcrClr=0xA4, WOLcgClr=0xA7, PwrcsrClr=0xAC,
 };
@@ -448,24 +469,29 @@
 static int  via_rhine_close(struct net_device *dev);
 static inline void clear_tally_counters(long ioaddr);
 
-static void wait_for_reset(struct net_device *dev)
+static void wait_for_reset(struct net_device *dev, char *name)
 {
+	struct netdev_private *np = dev->priv;
 	long ioaddr = dev->base_addr;
+	int chip_id = np->chip_id;
 	int i;
 
+	/* 3043 may need long delay after reset (dlink) */
+	if (chip_id == VT3043 || chip_id == VT86C100A)
+		udelay(100);
+
 	i = 0;
 	do {
 		udelay(5);
 		i++;
 		if(i > 2000) {
-			printk(KERN_ERR "%s: reset did not complete in 10 ms.\n",
-					dev->name);
+			printk(KERN_ERR "%s: reset did not complete in 10 ms.\n", name);
 			break;
 		}
 	} while(readw(ioaddr + ChipCmd) & CmdReset);
 	if (debug > 1)
 		printk(KERN_INFO "%s: reset finished after %d microseconds.\n",
-				dev->name, 5*i);
+			   name, 5*i);
 }
 
 static int __devinit via_rhine_init_one (struct pci_dev *pdev,
@@ -515,13 +541,12 @@
 
 	dev = alloc_etherdev(sizeof(*np));
 	if (dev == NULL) {
-		printk (KERN_ERR "init_ethernet failed for card #%d\n",
-			card_idx);
+		printk (KERN_ERR "init_ethernet failed for card #%d\n", card_idx);
 		goto err_out;
 	}
 	SET_MODULE_OWNER(dev);
 	
-	if (pci_request_regions(pdev, "via-rhine"))
+	if (pci_request_regions(pdev, shortname))
 		goto err_out_free_netdev;
 
 #ifndef USE_IO
@@ -534,14 +559,51 @@
 	}
 #endif
 
-	/* Ideally we would read the EEPROM but access may be locked. */
-	for (i = 0; i < 6; i++)
-		dev->dev_addr[i] = readb(ioaddr + StationAddr + i);
+	/* D-Link provided reset code (with comment additions) */
+	if (via_rhine_chip_info[chip_id].drv_flags & HasWOL) {
+		unsigned char byOrgValue;
+
+		/* clear sticky bit before reset & read ethernet address */
+		byOrgValue = readb(ioaddr + StickyHW);
+		byOrgValue = byOrgValue & 0xFC;
+		writeb(byOrgValue, ioaddr + StickyHW);
+
+		/* (bits written are cleared?) */
+		/* disable force PME-enable */
+		writeb(0x80, ioaddr + WOLcgClr);
+		/* disable power-event config bit */
+		writeb(0xFF, ioaddr + WOLcrClr);
+		/* clear power status (undocumented in vt6102 docs?) */
+		writeb(0xFF, ioaddr + PwrcsrClr);
+	}
 
 	/* Reset the chip to erase previous misconfiguration. */
 	writew(CmdReset, ioaddr + ChipCmd);
-	wait_for_reset(dev);
+	wait_for_reset(dev, shortname);
 
+	/* Reload the station address from the EEPROM. */
+	writeb(0x20, ioaddr + MACRegEEcsr);
+	/* Typically 2 cycles to reload. */
+	for (i = 0; i < 150; i++)
+		if (! (readb(ioaddr + MACRegEEcsr) & 0x20))
+			break;
+	for (i = 0; i < 6; i++)
+		dev->dev_addr[i] = readb(ioaddr + StationAddr + i);
+
+	if (!is_valid_ether_addr(dev->dev_addr)) {
+		printk(KERN_ERR "Invalid MAC address for card #%d\n", card_idx);
+		goto err_out_unmap;
+	}
+
+	if (chip_id == VT6102) {
+		/*
+		 * for 3065D, EEPROM reloaded will cause bit 0 in MAC_REG_CFGA
+		 * turned on.  it makes MAC receive magic packet
+		 * automatically. So, we turn it off. (D-Link)
+		 */
+		writeb(readb(ioaddr + ConfigA) & 0xFE, ioaddr + ConfigA);
+	}
+
 	dev->base_addr = ioaddr;
 	dev->irq = pdev->irq;
 
@@ -563,8 +625,11 @@
 	if (card_idx < MAX_UNITS  &&  full_duplex[card_idx] > 0)
 		np->full_duplex = 1;
 
-	if (np->full_duplex)
+	if (np->full_duplex) {
+		printk(KERN_INFO "%s: Set to forced full duplex, autonegotiation"
+			   " disabled.\n", dev->name);
 		np->duplex_lock = 1;
+	}
 
 	/* The chip-specific entries in the device structure. */
 	dev->open = via_rhine_open;
@@ -611,6 +676,24 @@
 		np->mii_cnt = phy_idx;
 	}
 
+	/* Allow forcing the media type. */
+	if (option > 0) {
+		if (option & 0x220)
+			np->full_duplex = 1;
+		np->default_port = option & 0x3ff;
+		if (np->default_port & 0x330) {
+			/* FIXME: shouldn't someone check this variable? */
+			/* np->medialock = 1; */
+			printk(KERN_INFO "  Forcing %dMbs %s-duplex operation.\n",
+				   (option & 0x300 ? 100 : 10),
+				   (option & 0x220 ? "full" : "half"));
+			if (np->mii_cnt)
+				mdio_write(dev, np->phys[0], 0,
+						   ((option & 0x300) ? 0x2000 : 0) |  /* 100mbps? */
+						   ((option & 0x220) ? 0x0100 : 0));  /* Full duplex? */
+		}
+	}
+
 	return 0;
 
 err_out_unmap:
@@ -890,7 +973,7 @@
 		return i;
 	alloc_rbufs(dev);
 	alloc_tbufs(dev);
-	wait_for_reset(dev);
+	wait_for_reset(dev, dev->name);
 	init_registers(dev);
 	if (debug > 2)
 		printk(KERN_DEBUG "%s: Done via_rhine_open(), status %4.4x "
@@ -997,7 +1080,7 @@
 	alloc_rbufs(dev);
 
 	/* Reinitialize the hardware. */
-	wait_for_reset(dev);
+	wait_for_reset(dev, dev->name);
 	init_registers(dev);
 	
 	spin_unlock(&np->lock);
@@ -1445,7 +1528,7 @@
 			   dev->name, readw(ioaddr + ChipCmd));
 
 	/* Switch to loopback mode to avoid hardware races. */
-	writeb(np->tx_thresh | 0x01, ioaddr + TxConfig);
+	writeb(np->tx_thresh | 0x02, ioaddr + TxConfig);
 
 	/* Disable interrupts by clearing the interrupt mask. */
 	writew(0x0000, ioaddr + IntrEnable);

--------------EAF7B243B5BA9E026099E08D--

