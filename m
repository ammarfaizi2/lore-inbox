Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262302AbUBXUhu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 15:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbUBXUgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 15:36:51 -0500
Received: from orcas.net ([66.92.223.130]:53725 "EHLO orcas.net")
	by vger.kernel.org with ESMTP id S262449AbUBXUfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 15:35:30 -0500
Date: Tue, 24 Feb 2004 12:35:25 -0800 (PST)
From: Terry Hardie <terryh@orcas.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
cc: "torvalds@osdl.org" <torvalds@osdl.org>
Subject: Patch for 8 port SIIG serial card support (2.4.25 patch)
Message-ID: <Pine.LNX.4.58.0402241049150.3318@orcas.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -ur linux-2.4.25/drivers/char/serial.c linux-2.4.25-mod1/drivers/char/serial.c
--- linux-2.4.25/drivers/char/serial.c	Wed Feb 18 05:36:31 2004
+++ linux-2.4.25-mod1/drivers/char/serial.c	Tue Feb 24 09:55:54 2004
@@ -62,10 +62,15 @@
  *        Robert Schwebel <robert@schwebel.de>,
  *        Juergen Beisert <jbeisert@eurodsn.de>,
  *        Theodore Ts'o <tytso@mit.edu>
+ *
+ * 02/03: Added support for SIIG's 8 port serial card. SIIG
+ *        were entirely unsupportive of this effort (not that it was
+ *        hard, but still)
+ *        Terry Hardie <terryh@orcas.net>
  */

-static char *serial_version = "5.05c";
-static char *serial_revdate = "2001-07-08";
+static char *serial_version = "5.05d";
+static char *serial_revdate = "2004-02-24";

 /*
  * Serial driver configuration section.  Here are the various options:
@@ -3936,6 +3941,16 @@
 		}

 	}
+
+	/* SIIG 8 port cards are off for the last 4 ports --- TMH */
+	if (dev->vendor == PCI_VENDOR_ID_SIIG &&
+		dev->device == PCI_DEVICE_ID_SIIG_8S_20x_650) {
+		if (idx > 3) {
+			offset = (idx - 4) * 8;
+			base_idx = 4;
+		}
+	}
+

 	/* HP's Diva chip puts the 4th/5th serial port further out, and
 	 * some serial ports are supposed to be hidden on certain models.
@@ -4379,6 +4394,7 @@
 	pbn_siig20x_0,
 	pbn_siig20x_2,
 	pbn_siig20x_4,
+	pbn_siig20x_8,

 	pbn_computone_4,
 	pbn_computone_6,
@@ -4478,11 +4494,13 @@
 		0, 0, pci_siig10x_fn },
 	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 4, 921600,   /* pbn_siig10x_4 */
 		0, 0, pci_siig10x_fn },
-	{ SPCI_FL_BASE0, 1, 921600,			   /* pbn_siix20x_0 */
+	{ SPCI_FL_BASE0, 1, 921600,			   /* pbn_siig20x_0 */
 		0, 0, pci_siig20x_fn },
-	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 921600,   /* pbn_siix20x_2 */
+	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 921600,   /* pbn_siig20x_2 */
 		0, 0, pci_siig20x_fn },
-	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 4, 921600,   /* pbn_siix20x_4 */
+	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 4, 921600,   /* pbn_siig20x_4 */
+		0, 0, pci_siig20x_fn },
+	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 8, 921600,   /* pbn_siig20x_8 */
 		0, 0, pci_siig20x_fn },

 	{ SPCI_FL_BASE0, 4, 921600, /* IOMEM */		   /* pbn_computone_4 */
@@ -4839,6 +4857,9 @@
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_4S_20x_850,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_siig20x_4 },
+	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_8S_20x_650,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig20x_8 },

 	/* Computone devices submitted by Doug McNash dmcnash@computone.com */
 	{	PCI_VENDOR_ID_COMPUTONE, PCI_DEVICE_ID_COMPUTONE_PG,
diff -ur linux-2.4.25/include/linux/pci_ids.h linux-2.4.25-mod1/include/linux/pci_ids.h
--- linux-2.4.25/include/linux/pci_ids.h	Wed Feb 18 05:36:32 2004
+++ linux-2.4.25-mod1/include/linux/pci_ids.h	Mon Feb 23 09:22:37 2004
@@ -1525,6 +1525,7 @@
 #define PCI_DEVICE_ID_SIIG_2S1P_20x_550	0x2060
 #define PCI_DEVICE_ID_SIIG_2S1P_20x_650	0x2061
 #define PCI_DEVICE_ID_SIIG_2S1P_20x_850	0x2062
+#define PCI_DEVICE_ID_SIIG_8S_20x_650	0x2081

 #define PCI_VENDOR_ID_DOMEX		0x134a
 #define PCI_DEVICE_ID_DOMEX_DMX3191D	0x0001


