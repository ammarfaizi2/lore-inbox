Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290790AbSBLGFS>; Tue, 12 Feb 2002 01:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290789AbSBLGFJ>; Tue, 12 Feb 2002 01:05:09 -0500
Received: from mailhost.nmt.edu ([129.138.4.52]:39953 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S290771AbSBLGFD>;
	Tue, 12 Feb 2002 01:05:03 -0500
Date: Mon, 11 Feb 2002 23:04:57 -0700
From: Val Henson <val@nmt.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] yellowfin.c
Message-ID: <20020211230457.H14265@boardwalk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch to drivers/net/yellowfin.c, against Linux 2.4.18-pre7.
I'd send you the bk style patches, but I'm using the linuxppc tree at
the moment.  Here's the next best thing, a bk generated diff.

Note: If you have a yellowfin, PLEASE test this driver and let me know
if it still works for you.  I can only test it on the Symbios card.

ChangeSet comments extracted below:

Check for a truly oversized ethernet frame before complaining about
it.  Also, fix a theoretical bug on the gigabit card by adding
DontUseEeprom to its flags (returns the driver to LK1.1.3 behavior).

-VAL

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux 2.4 for PowerPC development tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.202   -> 1.203  
#	drivers/net/yellowfin.c	1.18    -> 1.19   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/02/11	val@evilcat.fsmlabs.com	1.203
# Check for a truly oversized ethernet frame before complaining about it.  
# Also, fix a theoretical bug on the gigabit card by adding DontUseEeprom to 
# its flags (returns the driver to LK1.1.3 behavior).
# --------------------------------------------
#
diff -Nru a/drivers/net/yellowfin.c b/drivers/net/yellowfin.c
--- a/drivers/net/yellowfin.c	Mon Feb 11 22:56:50 2002
+++ b/drivers/net/yellowfin.c	Mon Feb 11 22:56:50 2002
@@ -40,12 +40,16 @@
 	
 	LK1.1.5 (val@nmt.edu):
 	* Fix forced full-duplex bug I introduced
+
+	LK1.1.6 (val@nmt.edu):
+	* Only print warning on truly "oversized" packets
+	* Fix theoretical bug on gigabit cards - return to 1.1.3 behavior
 	
 */
 
 #define DRV_NAME	"yellowfin"
-#define DRV_VERSION	"1.05+LK1.1.5"
-#define DRV_RELDATE	"May 10, 2001"
+#define DRV_VERSION	"1.05+LK1.1.6"
+#define DRV_RELDATE	"Feb 11, 2002"
 
 #define PFX DRV_NAME ": "
 
@@ -176,8 +180,8 @@
 I. Board Compatibility
 
 This device driver is designed for the Packet Engines "Yellowfin" Gigabit
-Ethernet adapter.  The only PCA currently supported is the G-NIC 64-bit
-PCI card.
+Ethernet adapter.  The G-NIC 64-bit PCI card is supported, as well as the 
+Symbios 53C885E dual function chip.
 
 II. Board-specific settings
 
@@ -259,7 +263,8 @@
 };
 enum capability_flags {
 	HasMII=1, FullTxStatus=2, IsGigabit=4, HasMulticastBug=8, FullRxStatus=16,
-	HasMACAddrBug=32, DontUseEeprom=64, /* Only on early revs.  */
+	HasMACAddrBug=32, /* Only on early revs.  */
+	DontUseEeprom=64, /* Don't read the MAC from the EEPROm. */
 };
 /* The PCI I/O space extent. */
 #define YELLOWFIN_SIZE 0x100
@@ -283,7 +288,7 @@
 static struct pci_id_info pci_id_tbl[] = {
 	{"Yellowfin G-NIC Gigabit Ethernet", { 0x07021000, 0xffffffff},
 	 PCI_IOTYPE, YELLOWFIN_SIZE,
-	 FullTxStatus | IsGigabit | HasMulticastBug | HasMACAddrBug},
+	 FullTxStatus | IsGigabit | HasMulticastBug | HasMACAddrBug | DontUseEeprom},
 	{"Symbios SYM83C885", { 0x07011000, 0xffffffff},
 	 PCI_IOTYPE, YELLOWFIN_SIZE, HasMII | DontUseEeprom },
 	{0,},
@@ -1125,8 +1130,9 @@
 		if (--boguscnt < 0)
 			break;
 		if ( ! (desc_status & RX_EOP)) {
-			printk(KERN_WARNING "%s: Oversized Ethernet frame spanned multiple buffers,"
-				   " status %4.4x!\n", dev->name, desc_status);
+			if (data_size != 0)
+				printk(KERN_WARNING "%s: Oversized Ethernet frame spanned multiple buffers,"
+					   " status %4.4x, data_size %d!\n", dev->name, desc_status, data_size);
 			yp->stats.rx_length_errors++;
 		} else if ((yp->drv_flags & IsGigabit)  &&  (frame_status & 0x0038)) {
 			/* There was a error. */
