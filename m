Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283093AbRLDPg2>; Tue, 4 Dec 2001 10:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276759AbRLDPgD>; Tue, 4 Dec 2001 10:36:03 -0500
Received: from [203.117.131.12] ([203.117.131.12]:12739 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S283102AbRLDPfb>; Tue, 4 Dec 2001 10:35:31 -0500
Message-ID: <3C0CED3B.7030409@metaparadigm.com>
Date: Tue, 04 Dec 2001 23:35:23 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011127
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Cc: Benjamin LaHaise <bcrl@redhat.com>
Subject: [PATCH] - 2.4.16 ns83820 optical support (Netgear GA621)
Content-Type: multipart/mixed;
 boundary="------------010502050403080909080703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010502050403080909080703
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This patch adds Netgear GA621 support to the ns83820 driver
by adding code to configure the optical transceiver on
these boards. People currently using Netgear driver (gam)
may like to test this.

I decided to add support for GA621 to the ns83820 driver after
suffering an oops with the netgear supplied driver whose code
is rather convoluted on not very Linux like (appears to be a
port of a NDIS driver) ie. it won't probably ever make it into
the kernel without a lot of rework.

It would be good if someone could test this on copper
cards to make sure it still works okay.

~mc

--------------010502050403080909080703
Content-Type: text/plain;
 name="ns83820-optical.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ns83820-optical.patch"

--- linux/drivers/net/ns83820.c.orig	Tue Dec  4 20:27:10 2001
+++ linux/drivers/net/ns83820.c	Tue Dec  4 23:33:34 2001
@@ -43,10 +43,12 @@
  *			       otherwise fragments get lost
  *			     - fix >> 32 bugs
  *			0.12 - add statistics counters
  *			     - add allmulti/promisc support
  *	20011009	0.13 - hotplug support, other smaller pci api cleanups
+ *	20011204	0.13a - optical transceiver support added
+ *			        by Michael Clark <michael@metaparadigm.com>
  *
  * Driver Overview
  * ===============
  *
  * This driver was originally written for the National Semiconductor
@@ -63,10 +65,11 @@
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
@@ -210,10 +213,11 @@
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
@@ -314,10 +318,44 @@
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
+/* TBICR bit definitions */
+
+#define MR_AN_ENABLE 		0x00001000
+#define MR_RESTART_AN 		0x00000200
+
+/* TBISR bit definitions */
+
+#define MR_LINK_STATUS 		0x00000020
+#define MR_AN_COMPLETE 		0x00000004
+
+/* TANAR, TANALPAR bit definitions */
+
+#define PS2 			0x00000100
+#define PS1 			0x00000080
+#define HALF_DUP 		0x00000040
+#define FULL_DUP 		0x00000020
+
+/* GPIOR bit definitions */
+
+#define GP5_OE			0x00000200
+#define GP4_OE			0x00000100
+#define GP3_OE			0x00000080
+#define GP2_OE			0x00000040
+#define GP1_OE			0x00000020
+#define GP3_OUT			0x00000004
+#define GP1_OUT			0x00000001
+
 #define __kick_rx(dev)	writel(CR_RXE, dev->base + CR)
 
 #define kick_rx(dev) do { \
 	dprintk("kick_rx: maybe kicking\n"); \
 	if (test_and_clear_bit(0, &dev->rx_info.idle)) { \
@@ -543,28 +581,82 @@
 	build_rx_desc(dev, dev->rx_info.descs + (DESC_SIZE * i), 0, 0, CMDSTS_OWN, 0);
 }
 
 static void phy_intr(struct ns83820 *dev)
 {
-	static char *speeds[] = { "10", "100", "1000", "1000(?)" };
+	static char *speeds[] = { "10", "100", "1000", "1000(?)", "1000F" };
 	u32 cfg, new_cfg;
+	u32 tbisr, tanar, tanlpar;
+	int speed, fullduplex = 0;
 
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
+		if (!tanlpar && !tbisr) {
+			dprintk("%s: waiting for autoneg to complete\n",
+				dev->net_dev.name);
+			return;
+		}
+
+		if ( (fullduplex = (tanlpar & FULL_DUP)
+		      && (tanar & FULL_DUP)) ) {
 
-	dev->CFG_cache &= ~CFG_SPDSTS;
-	dev->CFG_cache |= cfg & CFG_SPDSTS;
+			/* both of us are full duplex */
+			writel(readl(dev->base + TXCFG)
+			       | TXCFG_CSI | TXCFG_HBI | TXCFG_ATP,
+			       dev->base + TXCFG);
+			writel(readl(dev->base + RXCFG) | RXCFG_RX_FD,
+			       dev->base + RXCFG);
+			/* Light up full duplex LED */
+			writel(readl(dev->base + GPIOR) | GP1_OUT,
+			       dev->base + GPIOR);
+
+		} else if(((tanlpar & HALF_DUP) && (tanar & HALF_DUP))
+			|| ((tanlpar & FULL_DUP) && (tanar & HALF_DUP))
+			|| ((tanlpar & HALF_DUP) && (tanar & FULL_DUP))) {
+
+			/* one or both of us are half duplex */
+			writel((readl(dev->base + TXCFG)
+				& ~(TXCFG_CSI | TXCFG_HBI)) | TXCFG_ATP,
+			       dev->base + TXCFG);
+			writel(readl(dev->base + RXCFG) & ~RXCFG_RX_FD,
+			       dev->base + RXCFG);
+			/* Turn off full duplex LED */
+			writel(readl(dev->base + GPIOR) & ~GP1_OUT,
+			       dev->base + GPIOR);
+		}
+
+		speed = 4; /* 1000F */
+
+	} else {
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
+	}
 
 	if (cfg & CFG_LNKSTS) {
 		netif_start_queue(&dev->net_dev);
 		netif_wake_queue(&dev->net_dev);
 	} else {
@@ -572,12 +664,12 @@
 	}
 
 	if (cfg & CFG_LNKSTS)
 		printk(KERN_INFO "%s: link now %s mbps, %s duplex and up.\n",
 			dev->net_dev.name,
-			speeds[((cfg / CFG_SPDSTS0) & 3)],
-			(cfg & CFG_DUPSTS) ? "full" : "half");
+			speeds[speed],
+			fullduplex ? "full" : "half");
 	else
 		printk(KERN_INFO "%s: link now down.\n", dev->net_dev.name);
 }
 
 static int ns83820_setup_rx(struct ns83820 *dev)
@@ -1341,10 +1433,27 @@
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
+		writel(readl(dev->base + TANAR) | HALF_DUP | FULL_DUP,
+		       dev->base + TANAR);
+
+		/* start auto negotiation */
+		writel(MR_AN_ENABLE | MR_RESTART_AN, dev->base + TBICR);
+		writel(MR_AN_ENABLE, dev->base + TBICR);
+
+		dev->CFG_cache |= CFG_MODE_1000;
+	}
+
 	writel(dev->CFG_cache, dev->base + CFG);
 	dprintk("CFG: %08x\n", dev->CFG_cache);
 
 	if (readl(dev->base + SRR))
 		writel(readl(dev->base+0x20c) | 0xfe00, dev->base + 0x20c);

--------------010502050403080909080703--

