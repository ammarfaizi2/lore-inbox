Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315523AbSEMDUm>; Sun, 12 May 2002 23:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315525AbSEMDUl>; Sun, 12 May 2002 23:20:41 -0400
Received: from ruckus.brouhaha.com ([209.185.79.17]:11757 "HELO brouhaha.com")
	by vger.kernel.org with SMTP id <S315523AbSEMDUk>;
	Sun, 12 May 2002 23:20:40 -0400
Date: 13 May 2002 03:20:37 -0000
Message-ID: <20020513032037.10708.qmail@brouhaha.com>
From: eric@brouhaha.com
To: linux-kernel@vger.kernel.org
Subject: patch to acenic driver for Farallon PN9100-T Gigabit Ethernet (copper)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently got some Farallon Netline PN9100-T cards.  They appear to be
the copper equivalent of the fibre PN9000-SX, which Linux supports, and
use the same Alteon chipset.  These cards were quite pricey when new,
but are now obsolete and widely available inexpensively at clearance
sales.  Note that Farallon is now part of Proxim.  Their web page for
this card is:
    http://www.proxim.com/products/all/netlinecard/pn9100t/index.html

The acenic driver didn't claim the card because it uses the Alteon vendor
ID with the device ID 0x00fa.  After adding those IDs to the table and
switch statement, I was pleased to find that the card works.  (At 100 Mbps,
I don't yet have a gigabit switch so I can't test that.)

Below find a trivial patch against the 2.4.18 kernel to add support for
this card.  Since it only adds new vendor/device ID support, this patch
should work (with only minor alterations if any) on other kernel
versions.

Eric Smith


--- linux/drivers/net/acenic.c.orig	Fri May 10 14:47:26 2002
+++ linux/drivers/net/acenic.c	Sun May 12 13:56:04 2002
@@ -114,6 +114,10 @@
 #ifndef PCI_DEVICE_ID_FARALLON_PN9000SX
 #define PCI_DEVICE_ID_FARALLON_PN9000SX	0x1a
 #endif
+#ifndef PCI_DEVICE_ID_FARALLON_PN9100T
+#define PCI_DEVICE_ID_FARALLON_PN9100T  0xfa
+#endif
+
 #ifndef PCI_VENDOR_ID_SGI
 #define PCI_VENDOR_ID_SGI		0x10a9
 #endif
@@ -138,6 +142,9 @@
 	 */
 	{ PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_FARALLON_PN9000SX,
 	  PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_NETWORK_ETHERNET << 8, 0xffff00, },
+	{ PCI_VENDOR_ID_ALTEON, PCI_DEVICE_ID_FARALLON_PN9100T,
+	  PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_NETWORK_ETHERNET << 8, 0xffff00, },
+
 	{ PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_ACENIC,
 	  PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_NETWORK_ETHERNET << 8, 0xffff00, },
 	{ }
@@ -603,6 +610,8 @@
 		 */
 		    !((pdev->vendor == PCI_VENDOR_ID_DEC) &&
 		      (pdev->device == PCI_DEVICE_ID_FARALLON_PN9000SX)) &&
+		    !((pdev->vendor == PCI_VENDOR_ID_ALTEON) &&
+		      (pdev->device == PCI_DEVICE_ID_FARALLON_PN9100T)) &&
 		    !((pdev->vendor == PCI_VENDOR_ID_SGI) &&
 		      (pdev->device == PCI_DEVICE_ID_SGI_ACENIC)))
 			continue;
@@ -701,6 +710,13 @@
 
 		switch(pdev->vendor) {
 		case PCI_VENDOR_ID_ALTEON:
+			if (pdev->device == PCI_DEVICE_ID_FARALLON_PN9100T) {
+				strncpy(ap->name, "Farallon PN9100-T "
+					"Gigabit Ethernet", sizeof (ap->name));
+				printk(KERN_INFO "%s: Farallon PN9100-T ",
+				       dev->name);
+				break;
+			}
 			strncpy(ap->name, "AceNIC Gigabit Ethernet",
 				sizeof (ap->name));
 			printk(KERN_INFO "%s: Alteon AceNIC ", dev->name);
