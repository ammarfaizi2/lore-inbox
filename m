Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271009AbRHODNC>; Tue, 14 Aug 2001 23:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271008AbRHODMx>; Tue, 14 Aug 2001 23:12:53 -0400
Received: from age.cs.columbia.edu ([128.59.22.100]:27144 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S271011AbRHODMh>; Tue, 14 Aug 2001 23:12:37 -0400
Date: Tue, 14 Aug 2001 23:12:45 -0400 (EDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] starfire driver update for 2.2.20pre9
Message-ID: <Pine.LNX.4.33.0108142310420.26973-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is basically the same update as the one I sent moments ago for 
2.4.8+. It's just rediffed against a 2.2.20pre tree, due to a one-line 
difference.

Please apply.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
----------------------------------
--- ../linux-2.2.20pre/drivers/net/starfire.c	Tue Aug 14 22:47:13 2001
+++ linux-2.4/drivers/net/starfire.c	Tue Aug 14 22:58:26 2001
@@ -89,13 +89,29 @@
 	- Initialize the TxMode register properly
 	- Don't dereference dev->priv after freeing it
 
+	LK1.3.4 (Ion Badulescu)
+	- Fixed initialization timing problems
+	- Fixed interrupt mask definitions
+
 TODO:
 	- implement tx_timeout() properly
 */
 
 #define DRV_NAME	"starfire"
-#define DRV_VERSION	"1.03+LK1.3.3"
-#define DRV_RELDATE	"July 05, 2001"
+#define DRV_VERSION	"1.03+LK1.3.4"
+#define DRV_RELDATE	"August 14, 2001"
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <asm/processor.h>		/* Processor type for cache alignment. */
+#include <asm/uaccess.h>
+#include <asm/io.h>
 
 /*
  * Adaptec's license for their Novell drivers (which is where I got the
@@ -124,6 +140,10 @@
 #define ZEROCOPY
 #endif
 
+#ifdef HAS_FIRMWARE
+#include "starfire_firmware.h"
+#endif /* HAS_FIRMWARE */
+
 /* The user-configurable values.
    These may be modified when a driver module is loaded.*/
 
@@ -196,21 +216,6 @@
 #define skb_first_frag_len(skb)	(skb->len)
 #endif /* not ZEROCOPY */
 
-#include <linux/version.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <asm/processor.h>		/* Processor type for cache alignment. */
-#include <asm/uaccess.h>
-
-#ifdef HAS_FIRMWARE
-#include "starfire_firmware.h"
-#endif /* HAS_FIRMWARE */
-
 /* 2.2.x compatibility code */
 #if LINUX_VERSION_CODE < 0x20300
 
@@ -241,7 +246,6 @@
 /* These identify the driver base version and may not be removed. */
 static char version[] __devinitdata =
 KERN_INFO "starfire.c:v1.03 7/26/2000  Written by Donald Becker <becker@scyld.com>\n"
-KERN_INFO " Updates and info at http://www.scyld.com/network/starfire.html\n"
 KERN_INFO " (unofficial 2.2/2.4 kernel port, version " DRV_VERSION ", " DRV_RELDATE ")\n";
 
 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
@@ -416,7 +420,7 @@
 	/* not quite bits */
 	IntrRxDone=IntrRxQ2Done | IntrRxQ1Done,
 	IntrRxEmpty=IntrRxDescQ1Low | IntrRxDescQ2Low,
-	IntrNormalMask=0xf0, IntrAbnormalMask=0x3f0e,
+	IntrNormalMask=0xff00, IntrAbnormalMask=0x3ff00fe,
 };
 
 /* Bits in the RxFilterMode register. */
@@ -655,10 +659,7 @@
 
 #ifdef ZEROCOPY
 	/* Starfire can do SG and TCP/UDP checksumming */
-	dev->features |= NETIF_F_SG;
-#ifdef HAS_FIRMWARE
-	dev->features |= NETIF_F_IP_CSUM;
-#endif /* HAS_FIRMWARE */
+	dev->features |= NETIF_F_SG | NETIF_F_IP_CSUM;
 #endif /* ZEROCOPY */
 
 	/* Serial EEPROM reads are hidden by the hardware. */
@@ -744,7 +745,7 @@
 		int mii_status;
 		for (phy = 0; phy < 32 && phy_idx < PHY_CNT; phy++) {
 			mdio_write(dev, phy, MII_BMCR, BMCR_RESET);
-			udelay(500);
+			mdelay(100);
 			boguscnt = 1000;
 			while (--boguscnt > 0)
 				if ((mdio_read(dev, phy, MII_BMCR) & BMCR_RESET) == 0)
@@ -767,6 +768,14 @@
 		np->phy_cnt = phy_idx;
 	}
 
+#ifdef ZEROCOPY
+	printk(KERN_INFO "%s: scatter-gather and hardware TCP cksumming enabled.\n",
+	       dev->name,
+#else  /* not ZEROCOPY */
+	printk(KERN_INFO "%s: scatter-gather and hardware TCP cksumming disabled.\n",
+	       dev->name);
+#endif /* not ZEROCOPY */
+
 	return 0;
 
 err_out_cleardev:
@@ -930,6 +939,7 @@
 	/* Configure the PCI bus bursts and FIFO thresholds. */
 	np->tx_mode = 0x0C04;		/* modified when link is up. */
 	writel(0x8000 | np->tx_mode, ioaddr + TxMode);
+	udelay(1000);
 	writel(np->tx_mode, ioaddr + TxMode);
 	np->tx_threshold = 4;
 	writel(np->tx_threshold, ioaddr + TxThreshold);
@@ -1545,6 +1561,7 @@
 		if (np->tx_mode != new_tx_mode) {
 			np->tx_mode = new_tx_mode;
 			writel(np->tx_mode | 0x8000, ioaddr + TxMode);
+			udelay(1000);
 			writel(np->tx_mode, ioaddr + TxMode);
 		}
 	} else {

