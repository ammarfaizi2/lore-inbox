Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284426AbRLEOiH>; Wed, 5 Dec 2001 09:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284425AbRLEOhu>; Wed, 5 Dec 2001 09:37:50 -0500
Received: from [203.117.131.12] ([203.117.131.12]:61632 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S284426AbRLEOha>; Wed, 5 Dec 2001 09:37:30 -0500
Message-ID: <3C0E3120.2000504@metaparadigm.com>
Date: Wed, 05 Dec 2001 22:37:20 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011127
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Rob Myers <rob.myers@gtri.gatech.edu>, LKML <linux-kernel@vger.kernel.org>,
        Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: [PATCH] - 2.4.16 ns83820 optical support (Netgear GA621)
In-Reply-To: <3C0CED3B.7030409@metaparadigm.com> <1007501048.14051.28.camel@ransom> <3C0D7CEA.2050307@metaparadigm.com> <3C0E194B.2BB7E289@mandrakesoft.com>
Content-Type: multipart/mixed;
 boundary="------------010601070500040605060506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010601070500040605060506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:

> Michael Clark wrote:
> 
>>Okay, so i'll move the register_netdev call earlier on in the
>>initialisation and add any necessary unregister call for failures.
>>
> 
> Not a solution but more of a problem... a user might see:
> 
> eth0: startup message
> eth0: startup message
> {failure, unregisters eth0}
> eth0: startup message
> eth0: startup message
> {failure, unregisters eth0}
> eth0: startup message
> eth0: startup message
> {failure, unregisters eth0}
> 
> That's particularly messy to diagnose when eth0 may not really be eth0. 
> Further in a hotplug multi-threaded world you are reserving an ethernet
> interface which may not be used.


Okay, I didn't really need to move the register_netdev call back so
early in the initialization function. In fact there are no failure
conditions after the first printk so i've moved it to just before
this so there are now no failure conditions after the register_netdev.

> I greatly prefer assigning board numbers (ns83820_0, ns83820_0, or ns0,
> ns1, ns2) temporarily until you are sure you can register the interface
> with the likelihood it will not be unregistered until module removal
> time, or never [if built into kernel].

Problem solved. New patch attached.

~mc


--------------010601070500040605060506
Content-Type: text/plain;
 name="ns83820-optical-0.13c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ns83820-optical-0.13c.patch"

--- linux/drivers/net/ns83820.c.orig	Wed Dec  5 22:17:34 2001
+++ linux/drivers/net/ns83820.c	Wed Dec  5 22:05:38 2001
@@ -1,6 +1,6 @@
-#define VERSION "0.13"
+#define VERSION "0.13b"
 /* ns83820.c by Benjamin LaHaise <bcrl@redhat.com>
  *
  * $Revision: 1.34.2.8 $
  *
  * Copyright 2001 Benjamin LaHaise.
@@ -43,10 +43,14 @@
  *			       otherwise fragments get lost
  *			     - fix >> 32 bugs
  *			0.12 - add statistics counters
  *			     - add allmulti/promisc support
  *	20011009	0.13 - hotplug support, other smaller pci api cleanups
+ *	20011204	0.13a - optical transceiver support added
+ *			        by Michael Clark <michael@metaparadigm.com>
+ *	20011205	0.13b - call register_netdev earlier in initialization
+ *			        suppress duplicate link status messages
  *
  * Driver Overview
  * ===============
  *
  * This driver was originally written for the National Semiconductor
@@ -63,10 +67,11 @@
  *
  *	Cameo		SOHO-GA2000T	SOHO-GA2500T
  *	D-Link		DGE-500T
  *	PureData	PDP8023Z-TG
  *	SMC		SMC9452TX	SMC9462TX
+ *	Netgear		GA621
  *
  * Special thanks to SMC for providing hardware to test this driver on.
  *
  * Reports of success or failure would be greatly appreciated.
  */
@@ -210,10 +215,11 @@
 #define CFG_SPDSTS	0x60000000
 #define CFG_SPDSTS1	0x40000000
 #define CFG_SPDSTS0	0x20000000
 #define CFG_DUPSTS	0x10000000
 #define CFG_TBI_EN	0x01000000
+#define CFG_AUTO_1000	0x00200000
 #define CFG_MODE_1000	0x00400000
 #define CFG_PINT_CTL	0x001c0000
 #define CFG_PINT_DUPSTS	0x00100000
 #define CFG_PINT_LNKSTS	0x00080000
 #define CFG_PINT_SPDSTS	0x00040000
@@ -314,10 +320,40 @@
 #define VRCR		0xbc
 #define VTCR		0xc0
 #define VDR		0xc4
 #define CCSR		0xcc
 
+#define TBICR		0xe0
+#define TBISR		0xe4
+#define TANAR		0xe8
+#define TANLPAR		0xec
+#define TANER		0xf0
+#define TESR		0xf4
+
+#define TBICR_MR_AN_ENABLE	0x00001000
+#define TBICR_MR_RESTART_AN	0x00000200
+
+#define TBISR_MR_LINK_STATUS	0x00000020
+#define TBISR_MR_AN_COMPLETE	0x00000004
+
+#define TANAR_PS2 		0x00000100
+#define TANAR_PS1 		0x00000080
+#define TANAR_HALF_DUP 		0x00000040
+#define TANAR_FULL_DUP 		0x00000020
+
+#define GPIOR_GP5_OE		0x00000200
+#define GPIOR_GP4_OE		0x00000100
+#define GPIOR_GP3_OE		0x00000080
+#define GPIOR_GP2_OE		0x00000040
+#define GPIOR_GP1_OE		0x00000020
+#define GPIOR_GP3_OUT		0x00000004
+#define GPIOR_GP1_OUT		0x00000001
+
+#define LINK_AUTONEGOTIATE	0x01
+#define LINK_DOWN		0x02
+#define LINK_UP			0x04
+
 #define __kick_rx(dev)	writel(CR_RXE, dev->base + CR)
 
 #define kick_rx(dev) do { \
 	dprintk("kick_rx: maybe kicking\n"); \
 	if (test_and_clear_bit(0, &dev->rx_info.idle)) { \
@@ -388,10 +424,11 @@
 
 	u32			MEAR_cache;
 	u32			IMR_cache;
 	struct eeprom		ee;
 
+	unsigned		linkstate;
 
 	spinlock_t	tx_lock;
 
 	long		tx_idle;
 	u32		tx_done_idx;
@@ -543,43 +580,97 @@
 	build_rx_desc(dev, dev->rx_info.descs + (DESC_SIZE * i), 0, 0, CMDSTS_OWN, 0);
 }
 
 static void phy_intr(struct ns83820 *dev)
 {
-	static char *speeds[] = { "10", "100", "1000", "1000(?)" };
+	static char *speeds[] = { "10", "100", "1000", "1000(?)", "1000F" };
 	u32 cfg, new_cfg;
+	u32 tbisr, tanar, tanlpar;
+	int speed, fullduplex, newlinkstate;
 
-	new_cfg = dev->CFG_cache & ~(CFG_SB | CFG_MODE_1000 | CFG_SPDSTS);
 	cfg = readl(dev->base + CFG) ^ SPDSTS_POLARITY;
 
-	if (cfg & CFG_SPDSTS1)
-		new_cfg |= CFG_MODE_1000 | CFG_SB;
-	else
-		new_cfg &= ~CFG_MODE_1000 | CFG_SB;
+	if (dev->CFG_cache & CFG_TBI_EN) {
 
-	if ((cfg & CFG_LNKSTS) && ((new_cfg ^ dev->CFG_cache) & CFG_MODE_1000)) {
-		writel(new_cfg, dev->base + CFG);
-		dev->CFG_cache = new_cfg;
-	}
+		/* we have an optical transceiver */
+		tbisr = readl(dev->base + TBISR);
+		tanar = readl(dev->base + TANAR);
+		tanlpar = readl(dev->base + TANLPAR);
+		dprintk("phy_intr: tbisr=%08x, tanar=%08x, tanlpar=%08x\n",
+			tbisr, tanar, tanlpar);
+
+		if ( (fullduplex = (tanlpar & TANAR_FULL_DUP)
+		      && (tanar & TANAR_FULL_DUP)) ) {
+
+			/* both of us are full duplex */
+			writel(readl(dev->base + TXCFG)
+			       | TXCFG_CSI | TXCFG_HBI | TXCFG_ATP,
+			       dev->base + TXCFG);
+			writel(readl(dev->base + RXCFG) | RXCFG_RX_FD,
+			       dev->base + RXCFG);
+			/* Light up full duplex LED */
+			writel(readl(dev->base + GPIOR) | GPIOR_GP1_OUT,
+			       dev->base + GPIOR);
+
+		} else if(((tanlpar & TANAR_HALF_DUP)
+			   && (tanar & TANAR_HALF_DUP))
+			|| ((tanlpar & TANAR_FULL_DUP)
+			    && (tanar & TANAR_HALF_DUP))
+			|| ((tanlpar & TANAR_HALF_DUP)
+			    && (tanar & TANAR_FULL_DUP))) {
+
+			/* one or both of us are half duplex */
+			writel((readl(dev->base + TXCFG)
+				& ~(TXCFG_CSI | TXCFG_HBI)) | TXCFG_ATP,
+			       dev->base + TXCFG);
+			writel(readl(dev->base + RXCFG) & ~RXCFG_RX_FD,
+			       dev->base + RXCFG);
+			/* Turn off full duplex LED */
+			writel(readl(dev->base + GPIOR) & ~GPIOR_GP1_OUT,
+			       dev->base + GPIOR);
+		}
 
-	dev->CFG_cache &= ~CFG_SPDSTS;
-	dev->CFG_cache |= cfg & CFG_SPDSTS;
+		speed = 4; /* 1000F */
 
-	if (cfg & CFG_LNKSTS) {
-		netif_start_queue(&dev->net_dev);
-		netif_wake_queue(&dev->net_dev);
 	} else {
-		netif_stop_queue(&dev->net_dev);
+		/* we have a copper transceiver */
+		new_cfg = dev->CFG_cache & ~(CFG_SB | CFG_MODE_1000 | CFG_SPDSTS);
+
+		if (cfg & CFG_SPDSTS1)
+			new_cfg |= CFG_MODE_1000 | CFG_SB;
+		else
+			new_cfg &= ~CFG_MODE_1000 | CFG_SB;
+
+		if ((cfg & CFG_LNKSTS) && ((new_cfg ^ dev->CFG_cache) & CFG_MODE_1000)) {
+			writel(new_cfg, dev->base + CFG);
+			dev->CFG_cache = new_cfg;
+		}
+
+		dev->CFG_cache &= ~CFG_SPDSTS;
+		dev->CFG_cache |= cfg & CFG_SPDSTS;
+
+		speed = ((cfg / CFG_SPDSTS0) & 3);
+		fullduplex = (cfg & CFG_DUPSTS);
 	}
 
-	if (cfg & CFG_LNKSTS)
+	newlinkstate = (cfg & CFG_LNKSTS) ? LINK_UP : LINK_DOWN;
+
+	if (newlinkstate & LINK_UP
+	    && dev->linkstate != newlinkstate) {
+		netif_start_queue(&dev->net_dev);
+		netif_wake_queue(&dev->net_dev);
 		printk(KERN_INFO "%s: link now %s mbps, %s duplex and up.\n",
 			dev->net_dev.name,
-			speeds[((cfg / CFG_SPDSTS0) & 3)],
-			(cfg & CFG_DUPSTS) ? "full" : "half");
-	else
+			speeds[speed],
+			fullduplex ? "full" : "half");
+	} else if (newlinkstate & LINK_DOWN
+		   && dev->linkstate != newlinkstate) {
+		netif_stop_queue(&dev->net_dev);
 		printk(KERN_INFO "%s: link now down.\n", dev->net_dev.name);
+	}
+
+	dev->linkstate = newlinkstate;
 }
 
 static int ns83820_setup_rx(struct ns83820 *dev)
 {
 	unsigned i;
@@ -1285,10 +1376,12 @@
 		printk(KERN_INFO "ns83820: unable to register irq %d\n",
 			pci_dev->irq);
 		goto out_unmap;
 	}
 
+	if(register_netdev(&dev->net_dev)) goto out_unmap;
+
 	dev->net_dev.open = ns83820_open;
 	dev->net_dev.stop = ns83820_stop;
 	dev->net_dev.hard_start_xmit = ns83820_hard_start_xmit;
 	dev->net_dev.change_mtu = ns83820_change_mtu;
 	dev->net_dev.get_stats = ns83820_get_stats;
@@ -1341,10 +1434,30 @@
 	dev->CFG_cache |= CFG_BEM;
 #else
 #error This driver only works for big or little endian!!!
 #endif
 
+	/* setup optical transceiver if we have one */
+	if(dev->CFG_cache & CFG_TBI_EN) {
+		printk("%s: enabling optical transceiver\n",
+		       dev->net_dev.name);
+		writel(readl(dev->base + GPIOR) | 0x3e8, dev->base + GPIOR);
+
+		/* setup auto negotiation feature advertisement */
+		writel(readl(dev->base + TANAR)
+		       | TANAR_HALF_DUP | TANAR_FULL_DUP,
+		       dev->base + TANAR);
+
+		/* start auto negotiation */
+		writel(TBICR_MR_AN_ENABLE | TBICR_MR_RESTART_AN,
+		       dev->base + TBICR);
+		writel(TBICR_MR_AN_ENABLE, dev->base + TBICR);
+		dev->linkstate = LINK_AUTONEGOTIATE;
+
+		dev->CFG_cache |= CFG_MODE_1000;
+	}
+
 	writel(dev->CFG_cache, dev->base + CFG);
 	dprintk("CFG: %08x\n", dev->CFG_cache);
 
 	if (readl(dev->base + SRR))
 		writel(readl(dev->base+0x20c) | 0xfe00, dev->base + 0x20c);
@@ -1395,12 +1508,10 @@
 	dev->net_dev.features |= NETIF_F_IP_CSUM;
 #if defined(USE_64BIT_ADDR) || defined(CONFIG_HIGHMEM4G)
 	dev->net_dev.features |= NETIF_F_HIGHDMA;
 #endif
 
-	register_netdev(&dev->net_dev);
-
 	printk(KERN_INFO "%s: ns83820.c v" VERSION ": DP83820 %02x:%02x:%02x:%02x:%02x:%02x pciaddr=0x%08lx irq=%d rev 0x%x\n",
 		dev->net_dev.name,
 		dev->net_dev.dev_addr[0], dev->net_dev.dev_addr[1],
 		dev->net_dev.dev_addr[2], dev->net_dev.dev_addr[3],
 		dev->net_dev.dev_addr[4], dev->net_dev.dev_addr[5],
--- linux/Documentation/Configure.help.orig	Fri Nov 23 17:09:30 2001
+++ linux/Documentation/Configure.help	Wed Dec  5 12:57:08 2001
@@ -22441,12 +22441,12 @@
 National Semiconductor DP83820 series driver
 CONFIG_NS83820
   This is a driver for the National Semiconductor DP83820 series
   of gigabit ethernet MACs.  Cards using this chipset include
   the D-Link DGE-500T, PureData's PDP8023Z-TG, SMC's SMC9462TX,
-  SOHO-GA2000T, SOHO-GA2500T.  The driver supports the use of
-  zero copy.
+  SOHO-GA2000T, SOHO-GA2500T and Netgear GA621.  The driver
+  supports the use of zero copy.
 
 Toshiba Type-O IR Port device driver
 CONFIG_TOSHIBA_FIR
   Say Y here if you want to build support for the Toshiba Type-O IR
   chipset.  This chipset is used by the Toshiba Libretto 100CT, and

--------------010601070500040605060506--

