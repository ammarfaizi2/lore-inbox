Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289385AbSBELC4>; Tue, 5 Feb 2002 06:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289380AbSBELCo>; Tue, 5 Feb 2002 06:02:44 -0500
Received: from coruscant.franken.de ([193.174.159.226]:36839 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S289379AbSBELC3>; Tue, 5 Feb 2002 06:02:29 -0500
Date: Tue, 5 Feb 2002 11:57:07 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] suport AFAVLAB serial multiport card
Message-ID: <20020205115707.I26676@sunbeam.de.gnumonks.org>
In-Reply-To: <Pine.LNX.4.33.0201312246430.2047-100000@callisto.local> <20020131222059.B29479@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20020131222059.B29479@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Thu, Jan 31, 2002 at 10:20:59PM +0000
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.17
X-Date: Today is Pungenday, the 28th day of Chaos in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 10:20:59PM +0000, Russell King wrote:
> On Thu, Jan 31, 2002 at 10:48:19PM +0100, Robert Schwebel wrote:
> > Who is the maintainer for the serial driver stuff? The MAINTAINERS file
> > lists tytso, but the website mentioned in the file is rather outdated and
> > tytso doesn't answer my emails.
> 
> I guess that'd be me, although I'm not specifically looking after the
> code in the existing 2.4 and 2.5 trees.

cool.  I'm trying to get support for the AFAVLAB cards into serial.c since
2.4.0 days, but tytso never answered...

here's the patch, which still applies cleanly against 2.4.18-pre8:


--- linux-2.4.17-pre8-plain/drivers/char/serial.c	Wed Dec 12 14:28:07 2001
+++ linux-2.4.17-pre8-nfpom/drivers/char/serial.c	Wed Dec 12 14:42:14 2001
@@ -3895,7 +3895,14 @@
 			case 6: /* BAR 4*/
 			case 7: base_idx=idx-2; /* BAR 5*/
 		}
-
+ 
+	/* AFAVLAB uses a different mixture of BARs and offsets */
+	/* Not that ugly ;) -- HW */ 
+	if (dev->vendor == PCI_VENDOR_ID_AFAVLAB && idx >= 4) {
+		base_idx = 4;
+		offset = (idx - 4) * 8;
+	}
+ 
 	/* Some Titan cards are also a little weird */
 	if (dev->vendor == PCI_VENDOR_ID_TITAN &&
 	    (dev->device == PCI_DEVICE_ID_TITAN_400L ||
@@ -4242,6 +4249,7 @@
 
 	pbn_b0_bt_1_115200,
 	pbn_b0_bt_2_115200,
+	pbn_b0_bt_8_115200,
 	pbn_b0_bt_1_460800,
 	pbn_b0_bt_2_460800,
 
@@ -4320,6 +4328,7 @@
 
 	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 }, /* pbn_b0_bt_1_115200 */
 	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 }, /* pbn_b0_bt_2_115200 */
+	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 8, 115200 }, /* pbn_b0_bt_8_115200 */
 	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 460800 }, /* pbn_b0_bt_1_460800 */
 	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 460800 }, /* pbn_b0_bt_2_460800 */
 
@@ -4841,6 +4850,11 @@
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b2_bt_2_115200 },
 
+	/* AFAVLAB serial card, from Harald Welte <laforge@gnumonks.org> */
+	{	PCI_VENDOR_ID_AFAVLAB, PCI_DEVICE_ID_AFAVLAB_P028,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_8_115200 },
+		
 	/* EKF addition for i960 Boards form EKF with serial port */
 	{	PCI_VENDOR_ID_INTEL, 0x1960,
 		0xE4BF, PCI_ANY_ID, 0, 0,
--- linux-2.4.17-pre8-plain/include/linux/pci_ids.h	Wed Dec 12 14:28:16 2001
+++ linux-2.4.17-pre8-nfpom/include/linux/pci_ids.h	Wed Dec 12 14:33:20 2001
@@ -1483,6 +1483,9 @@
 #define PCI_DEVICE_ID_PANACOM_QUADMODEM	0x0400
 #define PCI_DEVICE_ID_PANACOM_DUALMODEM	0x0402
 
+#define PCI_VENDOR_ID_AFAVLAB		0x14db
+#define PCI_DEVICE_ID_AFAVLAB_P028	0x2180
+
 #define PCI_VENDOR_ID_BROADCOM		0x14e4
 #define PCI_DEVICE_ID_TIGON3_5700	0x1644
 #define PCI_DEVICE_ID_TIGON3_5701	0x1645

> Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M+ 
V-- PS++ PE-- Y++ PGP++ t+ 5-- !X !R tv-- b+++ !DI !D G+ e* h--- r++ y+(*)
