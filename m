Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbUL1XrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbUL1XrK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 18:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbUL1XrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 18:47:10 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:25503 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261173AbUL1Xq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 18:46:59 -0500
Subject: PATCH: 2.6.10 - generic IDE return codes and a wrong ifdef
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104273777.26131.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 28 Dec 2004 22:42:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates ide/pci/generic.c to fix the incorrect returns
causing PCI devices to be left reserved wrongly by the driver. It
doesn't contain the other -ac improvements for pci/generic just these
fixes.

Signed-off-by: Alan Cox <alan@redhat.com>

--- ../linux.vanilla-2.6.10/drivers/ide/pci/generic.c	2004-12-25 21:15:34.000000000 +0000
+++ drivers/ide/pci/generic.c	2004-12-28 23:40:35.664503856 +0000
@@ -100,18 +100,18 @@
 	if (dev->vendor == PCI_VENDOR_ID_UMC &&
 	    dev->device == PCI_DEVICE_ID_UMC_UM8886A &&
 	    (!(PCI_FUNC(dev->devfn) & 1)))
-		return 1; /* UM8886A/BF pair */
+		return -ENODEV; /* UM8886A/BF pair */
 
 	if (dev->vendor == PCI_VENDOR_ID_OPTI &&
 	    dev->device == PCI_DEVICE_ID_OPTI_82C558 &&
 	    (!(PCI_FUNC(dev->devfn) & 1)))
-		return 1;
+		return -EAGAIN;
 
 	pci_read_config_word(dev, PCI_COMMAND, &command);
 	if(!(command & PCI_COMMAND_IO))
 	{
 		printk(KERN_INFO "Skipping disabled %s IDE controller.\n", d->name);
-		return 1; 
+		return -EAGAIN; 
 	}
 	ide_setup_pci_device(dev, d);
 	return 0;
 
