Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264983AbSKALrC>; Fri, 1 Nov 2002 06:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264984AbSKALrC>; Fri, 1 Nov 2002 06:47:02 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:2994 "EHLO
	crisis.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S264983AbSKALqy>; Fri, 1 Nov 2002 06:46:54 -0500
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, becker@scyld.com
Subject: [PATCH] More znet updates
Organization: Metropolis -- Nowhere
X-Attribution: maz
X-Baby-1: =?iso-8859-1?q?Lo=EBn?= 12 juin 1996 13:10
X-Baby-2: None
X-Love-1: Gone
X-Love-2: Crazy-Cat
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 01 Nov 2002 12:53:01 +0100
Message-ID: <wrpznstjyle.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi all,

Here is the latest round of my "znet 2.5 revival sessions" :

- Make sure transceiver is powered on after waking up from suspend.
- Fixed min_fr_len bug that I introduced.
- Fixed Don Becker contacts.
- Now survives unplugging/replugging cable.

Patch is against 2.5.45.

Linus, please apply.

Thanks,

        M.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=znet.diff2

===== drivers/net/znet.c 1.6 vs 1.10 =====
--- 1.6/drivers/net/znet.c	Fri Oct 25 12:28:39 2002
+++ 1.10/drivers/net/znet.c	Fri Nov  1 12:19:48 2002
@@ -72,7 +72,10 @@
    - Use proper resources management.
    - Use wireless/i82593.h as much as possible (structure, constants)
    - Compiles as module or build-in.
+   - Now survives unplugging/replugging cable.
 
+   Some code was taken from wavelan_cs.
+   
    Tested on a vintage Zenith Z-Note 433Lnp+. Probably broken on
    anything else. Testers (and detailed bug reports) are welcome :-).
 
@@ -105,7 +108,7 @@
 /* This include could be elsewhere, since it is not wireless specific */
 #include "wireless/i82593.h"
 
-static const char version[] __initdata = "znet.c:v1.02 9/23/94 becker@cesdis.gsfc.nasa.gov\n";
+static const char version[] __initdata = "znet.c:v1.02 9/23/94 becker@scyld.com\n";
 
 #ifndef ZNET_DEBUG
 #define ZNET_DEBUG 1
@@ -299,7 +302,7 @@
 	cfblk->cd_filter = 0;  	/* CD is recognized immediately */
 	
 	/* Byte 9 */
-	cfblk->min_fr_len = 64 >> 2; /* Minimum frame length 64 bytes */
+	cfblk->min_fr_len = ETH_ZLEN >> 2; /* Minimum frame length */
 	
 	/* Byte A */
 	cfblk->lng_typ = 1;	/* Type/length checks OFF */
@@ -544,10 +547,14 @@
 	
 	/* Check that the part hasn't reset itself, probably from suspend. */
 	outb(CR0_STATUS_0, ioaddr);
-	if (inw(ioaddr) == 0x0010
-		&& inw(ioaddr) == 0x0000
-		&& inw(ioaddr) == 0x0010)
-	  hardware_init(dev);
+	if (inw(ioaddr) == 0x0010 &&
+	    inw(ioaddr) == 0x0000 &&
+	    inw(ioaddr) == 0x0010) {
+		if (znet_debug > 1)
+			printk (KERN_WARNING "%s : waking up\n", dev->name);
+		hardware_init(dev);
+		znet_transceiver_power (dev, 1);
+	}
 
 	if (1) {
 		short length = ETH_ZLEN < skb->len ? skb->len : ETH_ZLEN;
@@ -624,7 +631,9 @@
 		if ((status & SR0_INTERRUPT) == 0)
 			break;
 
-		if ((status & 0x0F) == SR0_TRANSMIT_DONE) {
+		if ((status & SR0_EVENT_MASK) == SR0_TRANSMIT_DONE ||
+		    (status & SR0_EVENT_MASK) == SR0_RETRANSMIT_DONE ||
+		    (status & SR0_EVENT_MASK) == SR0_TRANSMIT_NO_CRC_DONE) {
 			int tx_status;
 			outb(CR0_STATUS_1, ioaddr);
 			tx_status = inw(ioaddr);
@@ -644,6 +653,15 @@
 				/* ...and the catch-all. */
 				if ((tx_status | (TX_LOST_CRS | TX_LOST_CTS | TX_UND_RUN | TX_HRT_BEAT | TX_MAX_COL)) != (TX_LOST_CRS | TX_LOST_CTS | TX_UND_RUN | TX_HRT_BEAT | TX_MAX_COL))
 					znet->stats.tx_errors++;
+
+				/* Transceiver may be stuck if cable
+				 * was removed while emiting a
+				 * packet. Flip it off, then on to
+				 * reset it. This is very empirical,
+				 * but it seems to work. */
+				
+				znet_transceiver_power (dev, 0);
+				znet_transceiver_power (dev, 1);
 			}
 			netif_wake_queue (dev);
 		}

--=-=-=


-- 
Places change, faces change. Life is so very strange.

--=-=-=--
