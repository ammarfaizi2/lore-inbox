Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316430AbSHJAzS>; Fri, 9 Aug 2002 20:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316434AbSHJAzS>; Fri, 9 Aug 2002 20:55:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18706 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316430AbSHJAzP>;
	Fri, 9 Aug 2002 20:55:15 -0400
Message-ID: <3D5464CA.EABF5F8B@zip.com.au>
Date: Fri, 09 Aug 2002 17:56:42 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [patch 3/12] 3c905B fix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patch from Zwane which fixes a transceiver problem on his 3c905B.

Apparently the 905B's MII status register is saying that it doesn't
need preamble, but the datasheet says that it does.  So add a 905B
override for that in the device table.

This could break other 3c905B's.  I don't know.  There's only one way
to find out.


 3c59x.c |   11 +++++++----
 1 files changed, 7 insertions, 4 deletions

--- 2.5.30/drivers/net/3c59x.c~zwane-3c59x	Fri Aug  9 17:36:40 2002
+++ 2.5.30-akpm/drivers/net/3c59x.c	Fri Aug  9 17:36:40 2002
@@ -418,7 +418,8 @@ enum {	IS_VORTEX=1, IS_BOOMERANG=2, IS_C
 	EEPROM_8BIT=0x10,	/* AKPM: Uses 0x230 as the base bitmaps for EEPROM reads */
 	HAS_PWR_CTRL=0x20, HAS_MII=0x40, HAS_NWAY=0x80, HAS_CB_FNS=0x100,
 	INVERT_MII_PWR=0x200, INVERT_LED_PWR=0x400, MAX_COLLISION_RESET=0x800,
-	EEPROM_OFFSET=0x1000, HAS_HWCKSM=0x2000, WNO_XCVR_PWR=0x4000 };
+	EEPROM_OFFSET=0x1000, HAS_HWCKSM=0x2000, WNO_XCVR_PWR=0x4000,
+	EXTRA_PREAMBLE=0x8000, };
 
 enum vortex_chips {
 	CH_3C590 = 0,
@@ -504,7 +505,7 @@ static struct vortex_chip_info {
 	{"3c905 Boomerang 100baseT4",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_BOOMERANG|HAS_MII, 64, },
 	{"3c905B Cyclone 100baseTx",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM, 128, },
+	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM|EXTRA_PREAMBLE, 128, },
 
 	{"3c905B Cyclone 10/100/BNC",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM, 128, },
@@ -1281,6 +1282,8 @@ static int __devinit vortex_probe1(struc
 		int phy, phy_idx = 0;
 		EL3WINDOW(4);
 		mii_preamble_required++;
+		if (vp->drv_flags & EXTRA_PREAMBLE)
+			mii_preamble_required++;
 		mdio_sync(ioaddr, 32);
 		mdio_read(dev, 24, 1);
 		for (phy = 0; phy < 32 && phy_idx < 1; phy++) {
@@ -1297,8 +1300,8 @@ static int __devinit vortex_probe1(struc
 			else
 				phyx = phy;
 			mii_status = mdio_read(dev, phyx, 1);
-		printk("phy=%d, phyx=%d, mii_status=0x%04x\n",
-			phy, phyx, mii_status);
+			printk("phy=%d, phyx=%d, mii_status=0x%04x\n",
+				phy, phyx, mii_status);
 			if (mii_status  &&  mii_status != 0xffff) {
 				vp->phys[phy_idx++] = phyx;
 				if (print_info) {

.
