Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318131AbSHDInQ>; Sun, 4 Aug 2002 04:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318133AbSHDInQ>; Sun, 4 Aug 2002 04:43:16 -0400
Received: from [196.26.86.1] ([196.26.86.1]:37076 "EHLO
	infosat-gw.realnet.co.sz") by vger.kernel.org with ESMTP
	id <S318131AbSHDInP>; Sun, 4 Aug 2002 04:43:15 -0400
Date: Sun, 4 Aug 2002 11:02:15 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5.30] 3c59x MII problems w/ 3c905B
Message-ID: <Pine.LNX.4.44.0208041101140.2454-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
	The sluggishness turned out to be a tranceiver problem. My 3c905B 
has the suppress preamble bit set but seems to be lying, although a 3c905 works.

3c905B: phy=0, phyx=24, mii_status=0x786d
3c905: phy=0, phyx=24, mii_status=0x786f

Cheers,
	Zwane

Index: linux-2.5.30/drivers/net/3c59x.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.30/drivers/net/3c59x.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 3c59x.c
--- linux-2.5.30/drivers/net/3c59x.c	2 Aug 2002 17:19:36 -0000	1.1.1.1
+++ linux-2.5.30/drivers/net/3c59x.c	3 Aug 2002 21:16:20 -0000
@@ -321,7 +321,7 @@
 #define VORTEX_TOTAL_SIZE 0x20
 #define BOOMERANG_TOTAL_SIZE 0x40
 
-/* Set iff a MII transceiver on any interface requires mdio preamble.
+/* Set if a MII transceiver on any interface requires mdio preamble.
    This only set with the original DP83840 on older 3c905 boards, so the extra
    code size of a per-interface flag is not worthwhile. */
 static char mii_preamble_required;
@@ -1280,6 +1280,15 @@
 		dev->if_port == XCVR_MII || dev->if_port == XCVR_NWAY) {
 		int phy, phy_idx = 0;
 		EL3WINDOW(4);
+
+		/* The following cards blatantly lie about the suppress preamble bit */		
+		switch (pdev->device) {
+			case PCI_DEVICE_ID_3COM_3C905B_TX:
+				mii_preamble_required++;
+			default:
+				break;
+		}
+
 		mii_preamble_required++;
 		mdio_sync(ioaddr, 32);
 		mdio_read(dev, 24, 1);
@@ -1297,8 +1306,8 @@
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
@@ -1421,7 +1430,7 @@
 		pci_set_power_state(vp->pdev, 0);	/* Go active */
 		pci_restore_state(vp->pdev, vp->power_state);
 	}
-
+	
 	/* Before initializing select the active media port. */
 	EL3WINDOW(3);
 	config = inl(ioaddr + Wn3_Config);

-- 
function.linuxpower.ca

