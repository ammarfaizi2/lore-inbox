Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283741AbRLEFD3>; Wed, 5 Dec 2001 00:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283757AbRLEFDV>; Wed, 5 Dec 2001 00:03:21 -0500
Received: from [203.117.131.12] ([203.117.131.12]:2196 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S283741AbRLEFDI>; Wed, 5 Dec 2001 00:03:08 -0500
Message-ID: <3C0DAA80.3030601@metaparadigm.com>
Date: Wed, 05 Dec 2001 13:02:56 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011127
X-Accept-Language: en
MIME-Version: 1.0
To: Rob Myers <rob.myers@gtri.gatech.edu>, LKML <linux-kernel@vger.kernel.org>
Cc: Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: [PATCH] - 2.4.16 ns83820 optical support (Netgear GA621)
In-Reply-To: <3C0CED3B.7030409@metaparadigm.com> <1007501048.14051.28.camel@ransom> <3C0D7CEA.2050307@metaparadigm.com>
Content-Type: multipart/mixed;
 boundary="------------000304030801000306060103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000304030801000306060103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Michael Clark wrote:

> Rob Myers wrote:
> 
>> i did notice some odd dmesg output, however:
>>
>> eth%d: enabling 64 bit PCI.
>> eth%d: enabling optical transceiver
>> eth1: ns83820.c v0.13: DP83820 00:40:f4:29:ea:d7 pciaddr=0xe1000000
>> irq=12 rev 0x103
>> eth1: link now 1000F mbps, full duplex and up.
>> eth1: link now 1000F mbps, full duplex and up.


This patch resolves the duplicate link message and calls register_netdev
earlier (with another unregister added for correct handling of error
conditions). Here's the output on my machine:

eth0: disabling 64 bit PCI.
eth0: enabling optical transceiver
eth0: ns83820.c v0.13b: DP83820 00:40:f4:29:5c:ba pciaddr=0xfb102000 irq=26 rev 0x103
eth0: link now 1000F mbps, full duplex and up.

I've also cleaned up the new register defines to be consistent with
Benjamin's. This patch also updates Configure.help adding the GA621 to
the list of supported boards

~mc

--------------000304030801000306060103
Content-Type: text/plain;
 name="ns83820-optical-0.13b.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ns83820-optical-0.13b.patch"

--- linux/drivers/net/ns83820.c.orig	Tue Dec  4 20:27:10 2001
+++ linux/drivers/net/ns83820.c	Wed Dec  5 12:39:08 2001
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
@@ -1248,10 +1339,12 @@
 	dev->ee.lock = &dev->misc_lock;
 	dev->net_dev.owner = THIS_MODULE;
 
 	PREPARE_TQUEUE(&dev->tq_refill, queue_refill, dev);
 
+	if(register_netdev(&dev->net_dev)) goto out_reg;
+
 	err = pci_enable_device(pci_dev);
 	if (err) {
 		printk(KERN_INFO "ns83820: pci_enable_dev: %d\n", err);
 		goto out_free;
 	}
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
@@ -1415,10 +1526,12 @@
 out_disable:
 	pci_free_consistent(pci_dev, 4 * DESC_SIZE * NR_TX_DESC, dev->tx_descs, dev->tx_phy_descs);
 	pci_free_consistent(pci_dev, 4 * DESC_SIZE * NR_RX_DESC, dev->rx_info.descs, dev->rx_info.phy_descs);
 	pci_disable_device(pci_dev);
 out_free:
+	unregister_netdev(&dev->net_dev);
+out_reg:
 	kfree(dev);
 	pci_set_drvdata(pci_dev, NULL);
 out:
 	return err;
 }
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

--------------000304030801000306060103--

