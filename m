Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267348AbTBFQGk>; Thu, 6 Feb 2003 11:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267349AbTBFQGk>; Thu, 6 Feb 2003 11:06:40 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:25279 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267348AbTBFQGi>;
	Thu, 6 Feb 2003 11:06:38 -0500
Date: Thu, 6 Feb 2003 17:16:06 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [patch] Hopefully final fix for vt8235 problems
Message-ID: <20030206171606.A15024@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This should apply to both 2.5 and 2.4. It removes the previous attempt as well.


ChangeSet@1.975, 2003-02-06 17:15:01+01:00, vojtech@suse.cz
  Final vt8235 CD/DVD-ROM fix.


 ide-timing.h    |    8 --------
 pci/via82cxxx.c |   27 ++++++++++-----------------
 2 files changed, 10 insertions(+), 25 deletions(-)


diff -Nru a/drivers/ide/ide-timing.h b/drivers/ide/ide-timing.h
--- a/drivers/ide/ide-timing.h	Thu Feb  6 17:15:26 2003
+++ b/drivers/ide/ide-timing.h	Thu Feb  6 17:15:26 2003
@@ -245,14 +245,6 @@
 	}
 
 /*
- * If the drive is an ATAPI device it may need slower address setup timing,
- * so we stay on the safe side.
- */
-
-	if (drive->media != ide_disk)
-		p.setup = 120;
-
-/*
  * Convert the timing to bus clock counts.
  */
 
diff -Nru a/drivers/ide/pci/via82cxxx.c b/drivers/ide/pci/via82cxxx.c
--- a/drivers/ide/pci/via82cxxx.c	Thu Feb  6 17:15:26 2003
+++ b/drivers/ide/pci/via82cxxx.c	Thu Feb  6 17:15:26 2003
@@ -1,16 +1,6 @@
 /*
- * $Id: via82cxxx.c,v 3.35-ac2 2002/09/111 Alan Exp $
  *
- *  Copyright (c) 2000-2001 Vojtech Pavlik
- *
- *  Based on the work of:
- *	Michel Aubry
- *	Jeff Garzik
- *	Andre Hedrick
- */
-
-/*
- * Version 3.35
+ * Version 3.36
  *
  * VIA IDE driver for Linux. Supported southbridges:
  *
@@ -67,6 +57,7 @@
 #define VIA_SET_FIFO		0x040	/* Needs to have FIFO split set */
 #define VIA_NO_UNMASK		0x080	/* Doesn't work with IRQ unmasking on */
 #define VIA_BAD_ID		0x100	/* Has wrong vendor ID (0x1107) */
+#define VIA_BAD_AST		0x200	/* Don't touch Address Setup Timing */
 
 /*
  * VIA SouthBridge chips.
@@ -82,8 +73,8 @@
 #ifdef FUTURE_BRIDGES
 	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 },
 #endif
-	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 },
-	{ "vt8233a",	PCI_DEVICE_ID_VIA_8233A,    0x00, 0x2f, VIA_UDMA_133 },
+	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
+	{ "vt8233a",	PCI_DEVICE_ID_VIA_8233A,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8233c",	PCI_DEVICE_ID_VIA_8233C_0,  0x00, 0x2f, VIA_UDMA_100 },
 	{ "vt8233",	PCI_DEVICE_ID_VIA_8233_0,   0x00, 0x2f, VIA_UDMA_100 },
 	{ "vt8231",	PCI_DEVICE_ID_VIA_8231,     0x00, 0x2f, VIA_UDMA_100 },
@@ -152,7 +143,7 @@
 	via_print("----------VIA BusMastering IDE Configuration"
 		"----------------");
 
-	via_print("Driver Version:                     3.35-ac");
+	via_print("Driver Version:                     3.36");
 	via_print("South Bridge:                       VIA %s",
 		via_config->name);
 
@@ -292,9 +283,11 @@
 {
 	u8 t;
 
-	pci_read_config_byte(dev, VIA_ADDRESS_SETUP, &t);
-	t = (t & ~(3 << ((3 - dn) << 1))) | ((FIT(timing->setup, 1, 4) - 1) << ((3 - dn) << 1));
-	pci_write_config_byte(dev, VIA_ADDRESS_SETUP, t);
+	if (~via_config->flags & VIA_BAD_AST) {
+		pci_read_config_byte(dev, VIA_ADDRESS_SETUP, &t);
+		t = (t & ~(3 << ((3 - dn) << 1))) | ((FIT(timing->setup, 1, 4) - 1) << ((3 - dn) << 1));
+		pci_write_config_byte(dev, VIA_ADDRESS_SETUP, t);
+	}
 
 	pci_write_config_byte(dev, VIA_8BIT_TIMING + (1 - (dn >> 1)),
 		((FIT(timing->act8b, 1, 16) - 1) << 4) | (FIT(timing->rec8b, 1, 16) - 1));



-- 
Vojtech Pavlik
SuSE Labs
