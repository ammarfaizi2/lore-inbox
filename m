Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314811AbSGDXpX>; Thu, 4 Jul 2002 19:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314829AbSGDXpX>; Thu, 4 Jul 2002 19:45:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28429 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314811AbSGDXpU>;
	Thu, 4 Jul 2002 19:45:20 -0400
Message-ID: <3D24E007.1AE74E05@zip.com.au>
Date: Thu, 04 Jul 2002 16:53:43 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 2/27] Fix 3c59x driver for some 3c566B's
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Fix from Rahul Karnik and Donald Becker - some new 3c566B mini-PCI NICs
refuse to power up the transceiver unless we tickle an undocumented bit
in an undocumented register.  They worked this out by before-and-after
diffing of the register contents when it was set up by the Windows
driver.




 3c59x.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

--- 2.5.24/drivers/net/3c59x.c~3c59x	Thu Jul  4 16:17:06 2002
+++ 2.5.24-akpm/drivers/net/3c59x.c	Thu Jul  4 16:17:06 2002
@@ -174,6 +174,10 @@
     - Add `global_options' as default for options[].  Ditto global_enable_wol,
       global_full_duplex.
 
+   LK1.1.18 01Jul02 akpm
+    - Fix for undocumented transceiver power-up bit on some 3c566B's
+      (Donald Becker, Rahul Karnik)
+
     - See http://www.zip.com.au/~akpm/linux/#3c59x-2.3 for more details.
     - Also see Documentation/networking/vortex.txt
 */
@@ -189,8 +193,8 @@
 
 
 #define DRV_NAME	"3c59x"
-#define DRV_VERSION	"LK1.1.17"
-#define DRV_RELDATE	"18 Dec 2001"
+#define DRV_VERSION	"LK1.1.18"
+#define DRV_RELDATE	"1 Jul 2002"
 
 
 
@@ -414,7 +418,7 @@ enum {	IS_VORTEX=1, IS_BOOMERANG=2, IS_C
 	EEPROM_8BIT=0x10,	/* AKPM: Uses 0x230 as the base bitmaps for EEPROM reads */
 	HAS_PWR_CTRL=0x20, HAS_MII=0x40, HAS_NWAY=0x80, HAS_CB_FNS=0x100,
 	INVERT_MII_PWR=0x200, INVERT_LED_PWR=0x400, MAX_COLLISION_RESET=0x800,
-	EEPROM_OFFSET=0x1000, HAS_HWCKSM=0x2000 };
+	EEPROM_OFFSET=0x1000, HAS_HWCKSM=0x2000, WNO_XCVR_PWR=0x4000 };
 
 enum vortex_chips {
 	CH_3C590 = 0,
@@ -522,7 +526,7 @@ static struct vortex_chip_info {
 									HAS_HWCKSM, 128, },
 	{"3c556B Laptop Hurricane",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|EEPROM_OFFSET|HAS_CB_FNS|INVERT_MII_PWR|
-									HAS_HWCKSM, 128, },
+	                                WNO_XCVR_PWR|HAS_HWCKSM, 128, },
 	{"3c575 [Megahertz] 10/100 LAN 	CardBus",
 	PCI_USES_IO|PCI_USES_MASTER, IS_BOOMERANG|HAS_MII|EEPROM_8BIT, 128, },
 
@@ -1222,6 +1226,10 @@ static int __devinit vortex_probe1(struc
 		if (vp->drv_flags & INVERT_MII_PWR)
 			n |= 0x4000;
 		outw(n, ioaddr + Wn2_ResetOptions);
+		if (vp->drv_flags & WNO_XCVR_PWR) {
+			EL3WINDOW(0);
+			outw(0x0800, ioaddr);
+		}
 	}
 
 	/* Extract our information from the EEPROM data. */

-
