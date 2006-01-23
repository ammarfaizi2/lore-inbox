Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWAWX32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWAWX32 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 18:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWAWX32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 18:29:28 -0500
Received: from s0003.shadowconnect.net ([213.239.201.226]:63363 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S964845AbWAWX32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 18:29:28 -0500
Message-ID: <43D566DB.2010103@shadowconnect.com>
Date: Tue, 24 Jan 2006 00:29:31 +0100
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] I2O: don't disable PCI device if it is enabled before
 probing
Content-Type: multipart/mixed;
 boundary="------------080300060106070602080505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080300060106070602080505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Changes:
--------
- If PCI device is enabled before probing, it will not be disabled at
   exit.

Signed-off-by: Markus Lidel <Markus.Lidel@shadowconnect.com>

--------------080300060106070602080505
Content-Type: text/x-patch;
 name="i2o-pci-fix-disable-device.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2o-pci-fix-disable-device.patch"

--- a/drivers/message/i2o/pci.c	2006-01-23 23:41:42.031509195 +0100
+++ b/drivers/message/i2o/pci.c	2006-01-23 01:03:51.236440918 +0100
@@ -88,6 +88,11 @@
 	struct device *dev = &pdev->dev;
 	int i;
 
+	if (pci_request_regions(pdev, OSM_DESCRIPTION)) {
+		printk(KERN_ERR "%s: device already claimed\n", c->name);
+		return -ENODEV;
+	}
+
 	for (i = 0; i < 6; i++) {
 		/* Skip I/O spaces */
 		if (!(pci_resource_flags(pdev, i) & IORESOURCE_IO)) {
@@ -298,7 +321,7 @@
 	struct i2o_controller *c;
 	int rc;
 	struct pci_dev *i960 = NULL;
-	int pci_dev_busy = 0;
+	int enabled = pdev->is_enabled;
 
 	printk(KERN_INFO "i2o: Checking for PCI I2O controllers...\n");
 
@@ -308,16 +331,12 @@
 		return -ENODEV;
 	}
 
-	if ((rc = pci_enable_device(pdev))) {
-		printk(KERN_WARNING "i2o: couldn't enable device %s\n",
-		       pci_name(pdev));
-		return rc;
-	}
-
-	if (pci_request_regions(pdev, OSM_DESCRIPTION)) {
-		printk(KERN_ERR "i2o: device already claimed\n");
-		return -ENODEV;
-	}
+	if (!enabled)
+		if ((rc = pci_enable_device(pdev))) {
+			printk(KERN_WARNING "i2o: couldn't enable device %s\n",
+			       pci_name(pdev));
+			return rc;
+		}
 
 	if (pci_set_dma_mask(pdev, DMA_32BIT_MASK)) {
 		printk(KERN_WARNING "i2o: no suitable DMA found for %s\n",
@@ -395,9 +414,7 @@
 
 	if ((rc = i2o_pci_alloc(c))) {
 		printk(KERN_ERR "%s: DMA / IO allocation for I2O controller "
-		       " failed\n", c->name);
-		if (rc == -ENODEV)
-			pci_dev_busy = 1;
+		       "failed\n", c->name);
 		goto free_controller;
 	}
 
@@ -425,7 +442,7 @@
 	i2o_iop_free(c);
 
       disable:
-	if (!pci_dev_busy)
+	if (!enabled)
 		pci_disable_device(pdev);
 
 	return rc;

--------------080300060106070602080505--
