Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132471AbREBEI2>; Wed, 2 May 2001 00:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132607AbREBEIJ>; Wed, 2 May 2001 00:08:09 -0400
Received: from patan.Sun.COM ([192.18.98.43]:54960 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S132471AbREBEH6>;
	Wed, 2 May 2001 00:07:58 -0400
Message-ID: <3AEF8941.1D286552@sun.com>
Date: Tue, 01 May 2001 21:12:49 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: alan@redhat.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix mxser driver for MOXA C104/PCI
Content-Type: multipart/mixed;
 boundary="------------9D185C034CF4BA49F6BC366B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9D185C034CF4BA49F6BC366B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The attached patch fixes the MOXA driver properly.  Indexing is 0 based, so
rather than adjust the enum, don't subtract 1 from each index.  Also use a
for loop for the PCI devices, and up the version number.


-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------9D185C034CF4BA49F6BC366B
Content-Type: text/plain; charset=us-ascii;
 name="mxser.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mxser.c.diff"

--- drivers/char/mxser.c.orig	Tue May  1 21:00:50 2001
+++ drivers/char/mxser.c	Tue May  1 21:01:06 2001
@@ -27,10 +27,11 @@
  *
  *      Copyright (C) 1999,2000  Moxa Technologies Co., LTD.
  *
- *      for             : LINUX 2.0.X, 2.2.X
- *      date            : 1999/07/22
- *      version         : 1.1 
+ *      for             : LINUX 2.0.X, 2.2.X, 2.4.X
+ *      date            : 2001/05/01
+ *      version         : 1.2 
  *      
+ *    Fixes for C104H/PCI by Tim Hockin <thockin@sun.com>
  */
 
 #include <linux/config.h>
@@ -61,7 +62,7 @@
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
 
-#define		MXSER_VERSION			"1.1kern"
+#define		MXSER_VERSION			"1.2"
 
 #define		MXSERMAJOR	 	174
 #define		MXSERCUMAJOR		175
@@ -120,7 +121,7 @@
 #define CI104J_ASIC_ID  5
 
 enum {
-	MXSER_BOARD_C168_ISA = 1,
+	MXSER_BOARD_C168_ISA = 0,
 	MXSER_BOARD_C104_ISA,
 	MXSER_BOARD_CI104J,
 	MXSER_BOARD_C168_PCI,
@@ -434,7 +425,7 @@
 			     "mxser", info);
 	if (retval) {
 		restore_flags(flags);
-		printk("Board %d: %s", board, mxser_brdname[hwconf->board_type - 1]);
+		printk("Board %d: %s", board, mxser_brdname[hwconf->board_type]);
 		printk("  Request irq fail,IRQ (%d) may be conflit with another device.\n", info->irq);
 		return (retval);
 	}
@@ -455,7 +446,7 @@
 	unsigned int ioaddress;
 
 	hwconf->board_type = board_type;
-	hwconf->ports = mxser_numports[board_type - 1];
+	hwconf->ports = mxser_numports[board_type];
 	ioaddress = pci_resource_start (pdev, 2);
 	for (i = 0; i < hwconf->ports; i++)
 		hwconf->ioaddr[i] = ioaddress + 8 * i;
@@ -544,7 +535,7 @@
 
 		if (retval != 0)
 			printk("Found MOXA %s board (CAP=0x%x)\n",
-			       mxser_brdname[hwconf.board_type - 1],
+			       mxser_brdname[hwconf.board_type],
 			       ioaddr[b]);
 
 		if (retval <= 0) {
@@ -579,7 +570,7 @@
 
 		if (retval != 0)
 			printk("Found MOXA %s board (CAP=0x%x)\n",
-			       mxser_brdname[hwconf.board_type - 1],
+			       mxser_brdname[hwconf.board_type],
 			       ioaddr[b]);
 
 		if (retval <= 0) {
@@ -612,21 +603,15 @@
 
 		n = sizeof(mxser_pcibrds) / sizeof(mxser_pciinfo);
 		index = 0;
-		b = 0;
-		while (b < n) {
+		for (b = 0; b < n; b++) {
 			pdev = pci_find_device(mxser_pcibrds[b].vendor_id,
 					       mxser_pcibrds[b].device_id, pdev);
-			if (!pdev)
-			{
-				b++;
-				continue;
-			}
-			if (pci_enable_device(pdev))
+			if (!pdev || pci_enable_device(pdev))
 				continue;
 			hwconf.pdev = pdev;
 			printk("Found MOXA %s board(BusNo=%d,DevNo=%d)\n",
-				mxser_brdname[mxser_pcibrds[b].board_type - 1],
-				pdev->bus->number, PCI_SLOT(pdev->devfn >> 3));
+				mxser_brdname[mxser_pcibrds[b].board_type],
+				pdev->bus->number, PCI_SLOT(pdev->devfn));
 			if (m >= MXSER_BOARDS) {
 				printk("Too many Smartio family boards found (maximum %d),board not configured\n", MXSER_BOARDS);
 			} else {
@@ -1352,7 +1337,7 @@
 		return;
 	if (port == 0)
 		return;
-	max = mxser_numports[mxsercfg[i].board_type - 1];
+	max = mxser_numports[mxsercfg[i].board_type];
 
 	while (1) {
 		irqbits = inb(port->vector) & port->vectormask;

--------------9D185C034CF4BA49F6BC366B--

