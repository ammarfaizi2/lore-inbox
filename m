Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268868AbUJMP1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268868AbUJMP1i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 11:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269102AbUJMP1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 11:27:38 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:49865 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268868AbUJMP1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 11:27:22 -0400
Subject: PATCH: IDE generic tweak
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@linux.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097677476.4764.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 13 Oct 2004 15:24:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the user to force ide-generic to claim any remaining
IDE_STORAGE_CLASS devices. It isnt a good default to turn on because of
loadable driver modules and confusion with SATA however it is very
useful faced with a mainboard device that isn't supported any other way.
Note that the entry has to come last - if it looks OK I'll comment that
a bit more and update the option docs.

Comments ?

--- linux.vanilla-2.6.9rc3/drivers/ide/pci/generic.c	2004-09-30 16:13:08.000000000 +0100
+++ linux-2.6.9rc3/drivers/ide/pci/generic.c	2004-10-13 15:08:49.586093152 +0100
@@ -41,6 +41,17 @@
 
 #include "generic.h"
 
+static int ide_generic_all;		/* Set to claim all devices */
+
+static int __init ide_generic_all_on(char *unused)
+{
+	ide_generic_all = 1;
+	printk(KERN_INFO "IDE generic will claim all unknown PCI IDE storage controllers.\n");
+	return 1;
+}
+
+__setup("all-generic-ide", ide_generic_all_on);
+
 static unsigned int __init init_chipset_generic (struct pci_dev *dev, const char *name)
 {
 	return 0;
@@ -96,6 +107,11 @@
 {
 	ide_pci_device_t *d = &generic_chipsets[id->driver_data];
 	u16 command;
+	
+	/* Don't use the generic entry unless instructed to do so */
+	if (id->driver_data == 13)
+		if(ide_generic_all == 0)
+			return 1;
 
 	if (dev->vendor == PCI_VENDOR_ID_UMC &&
 	    dev->device == PCI_DEVICE_ID_UMC_UM8886A &&
@@ -108,8 +124,7 @@
 		return 1;
 
 	pci_read_config_word(dev, PCI_COMMAND, &command);
-	if(!(command & PCI_COMMAND_IO))
-	{
+	if(!(command & PCI_COMMAND_IO)) {
 		printk(KERN_INFO "Skipping disabled %s IDE controller.\n", d->name);
 		return 1; 
 	}
@@ -133,6 +148,8 @@
 	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO,     PCI_ANY_ID, PCI_ANY_ID, 0, 0, 10},
 	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_1,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 11},
 	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_2,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 12},
+
+	{ PCI_ANY_ID,		PCI_ANY_ID,			   PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_STORAGE_IDE << 8, 0xFFFFFF00UL, 13},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, generic_pci_tbl);
--- linux.vanilla-2.6.9rc3/drivers/ide/pci/generic.h	2004-09-30 15:35:49.000000000 +0100
+++ linux-2.6.9rc3/drivers/ide/pci/generic.h	2004-10-13 15:10:54.061170064 +0100
@@ -101,6 +101,13 @@
 		.channels	= 2,
 		.autodma	= NOAUTODMA,
 		.bootable	= ON_BOARD,
+	},{ /* 13 */
+		.name 		= "Unknown",
+		.init_chipset	= init_chipset_generic,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= NOAUTODMA,
+		.bootable	= ON_BOARD,
 	}
 };
 

