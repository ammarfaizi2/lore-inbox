Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267905AbTBRSb0>; Tue, 18 Feb 2003 13:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268014AbTBRSXS>; Tue, 18 Feb 2003 13:23:18 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56585 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268013AbTBRSXE>; Tue, 18 Feb 2003 13:23:04 -0500
Subject: PATCH: don't force enable generic IDE controllers
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:33:25 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lCYX-0006E5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes hangs on Micron Samurai boards

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/pci/generic.c linux-2.5.61-ac2/drivers/ide/pci/generic.c
--- linux-2.5.61/drivers/ide/pci/generic.c	2003-02-10 18:38:39.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/pci/generic.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,10 +1,26 @@
 /*
- *  linux/drivers/ide/generic.c		Version 0.10	Sept 11, 2002
+ *  linux/drivers/ide/pci/generic.c	Version 0.11	December 30, 2002
  *
  *  Copyright (C) 2001-2002	Andre Hedrick <andre@linux-ide.org>
+ *  Portions (C) Copyright 2002  Red Hat Inc <alan@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * For the avoidance of doubt the "preferred form" of this code is one which
+ * is in an open non patent encumbered format. Where cryptographic key signing
+ * forms part of the process of creating an executable the information
+ * including keys needed to generate an equivalently functional executable
+ * are deemed to be part of the source code.
  */
 
-
 #undef REALLY_SLOW_IO		/* most systems can safely undef this */
 
 #include <linux/config.h> /* for CONFIG_BLK_DEV_IDEPCI */
@@ -89,6 +105,7 @@
 static int __devinit generic_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	ide_pci_device_t *d = &generic_chipsets[id->driver_data];
+	u16 command;
 
 	if (dev->device != d->device)
 		BUG();
@@ -102,6 +119,12 @@
 	    (!(PCI_FUNC(dev->devfn) & 1)))
 		return 1;
 
+	pci_read_config_word(dev, PCI_COMMAND, &command);
+	if(!(command & PCI_COMMAND_IO))
+	{
+		printk(KERN_INFO "Skipping disabled %s IDE controller.\n", d->name);
+		return 1; 
+	}
 	ide_setup_pci_device(dev, d);
 	MOD_INC_USE_COUNT;
 	return 0;
