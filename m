Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbUL3AMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbUL3AMF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 19:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbUL3AKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 19:10:36 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:62853 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261455AbUL3AIy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 19:08:54 -0500
Date: Thu, 30 Dec 2004 01:06:22 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.10-bk1 3/5] pci-ide: propagate the error status in ide_pci_enable/ide_setup_pci_controller
Message-ID: <20041230000622.GB2217@electric-eye.fr.zoreil.com>
References: <1104158258.20952.44.camel@localhost.localdomain> <20041228205553.GA18525@electric-eye.fr.zoreil.com> <58cb370e04122813152759d94f@mail.gmail.com> <20041230000302.GA4267@electric-eye.fr.zoreil.com> <20041230000455.GA2217@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041230000455.GA2217@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- no need to overwrite the status code returned by the pci_xyz() functions;
- jump into the new century and use DMA_32BIT_MASK;
- misc cleanup in the error paths. It should not add a huge value in
  ide_pci_enable due to the FIXME comment but it should not bite too hard
  either.

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

diff -puN drivers/ide/setup-pci.c~ata-030 drivers/ide/setup-pci.c
--- linux-2.6.10-bk1/drivers/ide/setup-pci.c~ata-030	2004-12-29 23:49:36.625203685 +0100
+++ linux-2.6.10-bk1-romieu/drivers/ide/setup-pci.c	2004-12-29 23:49:36.628203197 +0100
@@ -290,14 +290,16 @@ EXPORT_SYMBOL_GPL(ide_setup_pci_noise);
  
 static int ide_pci_enable(struct pci_dev *dev, ide_pci_device_t *d)
 {
+	int ret;
 	
 	if (pci_enable_device(dev)) {
-		if (pci_enable_device_bars(dev, 1 << 4)) {
+		ret = pci_enable_device_bars(dev, 1 << 4);
+		if (ret < 0) {
 			printk(KERN_WARNING "%s: (ide_setup_pci_device:) "
 				"Could not enable device.\n", d->name);
-			return -EBUSY;
-		} else
-			printk(KERN_WARNING "%s: BIOS configuration fixed.\n", d->name);
+			goto out;
+		}
+		printk(KERN_WARNING "%s: BIOS configuration fixed.\n", d->name);
 	}
 
 	/*
@@ -305,18 +307,23 @@ static int ide_pci_enable(struct pci_dev
 	 * dma mask field to the ide_pci_device_t if we need it (or let
 	 * lower level driver set the dma mask)
 	 */
-	if (pci_set_dma_mask(dev, 0xffffffff)) {
+	ret = pci_set_dma_mask(dev, DMA_32BIT_MASK);
+	if (ret < 0) {
 		printk(KERN_ERR "%s: can't set dma mask\n", d->name);
-		return -EBUSY;
+		pci_disable_device(dev);
+		goto out;
 	}
 	 
 	/* FIXME: Temporary - until we put in the hotplug interface logic
-	   Check that the bits we want are not in use by someone else */
-	if (pci_request_region(dev, 4, "ide_tmp"))
-		return -EBUSY;
+	   Check that the bits we want are not in use by someone else.
+	   As someone else uses it, we do not (yuck) disable the device */
+	ret = pci_request_region(dev, 4, "ide_tmp");
+	if (ret < 0)
+		goto out;
+
 	pci_release_region(dev, 4);
-	
-	return 0;	
+out:	
+	return ret;
 }
 
 /**
@@ -516,21 +523,25 @@ static void ide_hwif_setup_dma(struct pc
 static int ide_setup_pci_controller(struct pci_dev *dev, ide_pci_device_t *d, int noisy, int *config)
 {
 	u32 class_rev;
+	int ret;
 	u16 pcicmd;
 
 	if (noisy)
 		ide_setup_pci_noise(dev, d);
 
-	if (ide_pci_enable(dev, d))
-		return -EBUSY;
+	ret = ide_pci_enable(dev, d);
+	if (ret < 0)
+		goto out;
 		
-	if (pci_read_config_word(dev, PCI_COMMAND, &pcicmd)) {
+	ret = pci_read_config_word(dev, PCI_COMMAND, &pcicmd);
+	if (ret < 0) {
 		printk(KERN_ERR "%s: error accessing PCI regs\n", d->name);
-		return -EIO;
+		goto err_disable;
 	}
 	if (!(pcicmd & PCI_COMMAND_IO)) {	/* is device disabled? */
-		if (ide_pci_configure(dev, d))
-			return -ENODEV;
+		ret = ide_pci_configure(dev, d);
+		if (ret < 0)
+			goto err_disable;
 		*config = 1;
 		printk(KERN_INFO "%s: device enabled (Linux)\n", d->name);
 	}
@@ -539,7 +550,12 @@ static int ide_setup_pci_controller(stru
 	class_rev &= 0xff;
 	if (noisy)
 		printk(KERN_INFO "%s: chipset revision %d\n", d->name, class_rev);
-	return 0;
+out:
+	return ret;
+
+err_disable:
+	pci_disable_device(dev);
+	goto out;
 }
 
 static void ide_release_pci_controller(struct pci_dev *dev, ide_pci_device_t *d,

_
