Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbUL3AMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbUL3AMH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 19:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbUL3AJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 19:09:53 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:62341 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261457AbUL3AIx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 19:08:53 -0500
Date: Thu, 30 Dec 2004 01:07:52 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.10-bk1 4/5] pci-ide: fix the incorrect returns for the generic driver
Message-ID: <20041230000752.GC2217@electric-eye.fr.zoreil.com>
References: <1104158258.20952.44.camel@localhost.localdomain> <20041228205553.GA18525@electric-eye.fr.zoreil.com> <58cb370e04122813152759d94f@mail.gmail.com> <20041230000302.GA4267@electric-eye.fr.zoreil.com> <20041230000455.GA2217@electric-eye.fr.zoreil.com> <20041230000622.GB2217@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041230000622.GB2217@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates ide/pci/generic.c to fix the incorrect returns
causing PCI devices to be left reserved wrongly by the driver. It
doesn't contain the other -ac improvements for pci/generic just these
fixes.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -puN drivers/ide/pci/generic.c~ata-035 drivers/ide/pci/generic.c
--- linux-2.6.10-bk1/drivers/ide/pci/generic.c~ata-035	2004-12-29 23:58:27.261699983 +0100
+++ linux-2.6.10-bk1-romieu/drivers/ide/pci/generic.c	2004-12-29 23:58:27.264699493 +0100
@@ -100,18 +100,18 @@ static int __devinit generic_init_one(st
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

_
