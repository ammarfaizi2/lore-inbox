Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130400AbQKNBBW>; Mon, 13 Nov 2000 20:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130471AbQKNBBM>; Mon, 13 Nov 2000 20:01:12 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:48132 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S130400AbQKNBBB>;
	Mon, 13 Nov 2000 20:01:01 -0500
Date: Tue, 14 Nov 2000 01:30:58 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Davicom support in the tulip driver
Message-ID: <Pine.LNX.4.21.0011140122470.20014-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As you suggested, I added/improved support for the Davicom chip to the
tulip driver. I'm going to fix the dmfe driver when I have more time.

This patch works-for-me(TM) using a Cnet card, but it would be very
interesting to see what happens with other Davicom based cards. I think it
should work, but you never know.

/Tobias Ringstrom


diff -ru tulip.orig/eeprom.c tulip/eeprom.c
--- tulip.orig/eeprom.c	Mon Jun 19 22:42:39 2000
+++ tulip/eeprom.c	Tue Nov 14 01:25:29 2000
@@ -198,12 +198,23 @@
 				if (p[1] == 0x05) {
 					mtable->has_reset = i;
 					leaf->media = p[2] & 0x0f;
+				} else if (tp->chip_id == DM910X && p[1] == 0x80) {
+					/* Hack to ignore Davicom delay period block */
+					mtable->leafcount--;
+					count--;
+					i--;
+					leaf->leafdata = p + 2;
+					p += (p[0] & 0x3f) + 1;
+					continue;
 				} else if (p[1] & 1) {
 					mtable->has_mii = 1;
 					leaf->media = 11;
 				} else {
 					mtable->has_nonmii = 1;
 					leaf->media = p[2] & 0x0f;
+					/* Davicom's media number for 100BaseTX is strange */
+					if (tp->chip_id == DM910X && leaf->media == 1)
+						leaf->media = 3;
 					switch (leaf->media) {
 					case 0: new_advertise |= 0x0020; break;
 					case 4: new_advertise |= 0x0040; break;
diff -ru tulip.orig/timer.c tulip/timer.c
--- tulip.orig/timer.c	Mon Jun 19 22:42:39 2000
+++ tulip/timer.c	Tue Nov 14 00:52:18 2000
@@ -90,6 +90,7 @@
 	case DC21142:
 	case MX98713:
 	case COMPEX9881:
+	case DM910X:
 	default: {
 		struct medialeaf *mleaf;
 		unsigned char *p;
diff -ru tulip.orig/tulip.h tulip/tulip.h
--- tulip.orig/tulip.h	Mon Jun 19 22:42:39 2000
+++ tulip/tulip.h	Mon Nov 13 23:40:06 2000
@@ -76,6 +76,7 @@
 	COMET,
 	COMPEX9881,
 	I21145,
+	DM910X,
 };
 
 
diff -ru tulip.orig/tulip_core.c tulip/tulip_core.c
--- tulip.orig/tulip_core.c	Mon Oct 16 22:36:08 2000
+++ tulip/tulip_core.c	Tue Nov 14 00:51:51 2000
@@ -147,6 +147,9 @@
   { "Intel DS21145 Tulip", 128, 0x0801fbff,
 	HAS_MII | HAS_MEDIA_TABLE | ALWAYS_CHECK_MII | HAS_ACPI | HAS_NWAY,
 	t21142_timer },
+  { "Davicom DM9102/DM9102A", 128, 0x0001ebef,
+	HAS_MII | HAS_MEDIA_TABLE | CSR12_IN_SROM | HAS_ACPI,
+	tulip_timer },
   {0},
 };
 
@@ -171,8 +174,8 @@
 	{ 0x104A, 0x2774, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
 	{ 0x11F6, 0x9881, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMPEX9881 },
 	{ 0x8086, 0x0039, PCI_ANY_ID, PCI_ANY_ID, 0, 0, I21145 },
-	{ 0x1282, 0x9100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DC21140 },
-	{ 0x1282, 0x9102, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DC21140 },
+	{ 0x1282, 0x9100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DM910X },
+	{ 0x1282, 0x9102, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DM910X },
 	{ 0x1113, 0x1217, PCI_ANY_ID, PCI_ANY_ID, 0, 0, MX98715 },
 	{0, }
 };
@@ -467,7 +470,8 @@
 			tulip_select_media(dev, 0);
 		}
 	} else if (tp->chip_id == DC21140 || tp->chip_id == DC21142
-			   || tp->chip_id == MX98713 || tp->chip_id == COMPEX9881) {
+			   || tp->chip_id == MX98713 || tp->chip_id == COMPEX9881
+			   || tp->chip_id == DM910X) {
 		printk(KERN_WARNING "%s: 21140 transmit timed out, status %8.8x, "
 			   "SIA %8.8x %8.8x %8.8x %8.8x, resetting...\n",
 			   dev->name, inl(ioaddr + CSR5), inl(ioaddr + CSR12),
@@ -1333,6 +1337,7 @@
 		outl(0x00000004, ioaddr + CSR13);
 		break;
 	case DC21140:
+	case DM910X:
 	default:
 		if (tp->mtable)
 			outl(tp->mtable->csr12dir | 0x100, ioaddr + CSR12);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
