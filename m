Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278282AbRJSDEC>; Thu, 18 Oct 2001 23:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278280AbRJSDDw>; Thu, 18 Oct 2001 23:03:52 -0400
Received: from mailhost.nmt.edu ([129.138.4.52]:19973 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S278284AbRJSDDp>;
	Thu, 18 Oct 2001 23:03:45 -0400
Date: Thu, 18 Oct 2001 21:04:16 -0600
From: Val Henson <val@nmt.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Yellowfin bug fix for Symbios cards
Message-ID: <20011018210416.D17208@boardwalk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Short version: My last patch to the yellowfin driver forced
full-duplex on for Symbios 10/100 cards, causing severe packet loss on
hubs and some switches.

Long version: Reading the MAC address from the EEPROM didn't work on
the Symbios card, so I turned on the IsGigabit flag to read it
correctly.  This also forces full-duplex on, which is wrong.  So I
added a flag controlling only the MAC address reading behavior and
turned off the IsGigabit flag for Symbios cards.

Patch (against latest 2.4) is at the end of this mail.

Thanks to Tim Moloney for reporting this bug.

-VAL

diff -Nru a/drivers/net/yellowfin.c b/drivers/net/yellowfin.c
--- a/drivers/net/yellowfin.c	Thu Oct 18 20:59:43 2001
+++ b/drivers/net/yellowfin.c	Thu Oct 18 20:59:43 2001
@@ -38,10 +38,13 @@
 	* Fix three endian-ness bugs
 	* Support dual function SYM53C885E ethernet chip
 	
+	LK1.1.5 (val@nmt.edu):
+	* Fix forced full-duplex bug I introduced
+	
 */
 
 #define DRV_NAME	"yellowfin"
-#define DRV_VERSION	"1.05+LK1.1.3"
+#define DRV_VERSION	"1.05+LK1.1.5"
 #define DRV_RELDATE	"May 10, 2001"
 
 #define PFX DRV_NAME ": "
@@ -256,7 +259,7 @@
 };
 enum capability_flags {
 	HasMII=1, FullTxStatus=2, IsGigabit=4, HasMulticastBug=8, FullRxStatus=16,
-	HasMACAddrBug=32,			/* Only on early revs.  */
+	HasMACAddrBug=32, DontUseEeprom=64, /* Only on early revs.  */
 };
 /* The PCI I/O space extent. */
 #define YELLOWFIN_SIZE 0x100
@@ -282,7 +285,7 @@
 	 PCI_IOTYPE, YELLOWFIN_SIZE,
 	 FullTxStatus | IsGigabit | HasMulticastBug | HasMACAddrBug},
 	{"Symbios SYM83C885", { 0x07011000, 0xffffffff},
-	 PCI_IOTYPE, YELLOWFIN_SIZE, HasMII | IsGigabit | FullTxStatus },
+	 PCI_IOTYPE, YELLOWFIN_SIZE, HasMII | DontUseEeprom },
 	{0,},
 };
 
@@ -453,7 +456,7 @@
 #endif
 	irq = pdev->irq;
 
-	if (drv_flags & IsGigabit)
+	if (drv_flags & DontUseEeprom)
 		for (i = 0; i < 6; i++)
 			dev->dev_addr[i] = inb(ioaddr + StnAddr + i);
 	else {
