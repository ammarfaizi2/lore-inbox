Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264267AbUBEAN5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 19:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264428AbUBEAMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 19:12:06 -0500
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:39179 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S264353AbUBEAKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 19:10:16 -0500
Date: Wed, 4 Feb 2004 18:14:33 -0600 (CST)
From: mikem@beardog.cca.cpqcorp.net
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss updates for 2.6 [6 of 11]
Message-ID: <Pine.LNX.4.58.0402041813120.18320@beardog.cca.cpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 6 of 11.
This patch moves the check of the controller to before trying to enable
it. If a controller is disabled the system will Oops without this fix.
This in the 2.4 tree.
--------------------------------------------------------------------------------------
diff -burN lx261-p005/drivers/block/cciss.c lx261/drivers/block/cciss.c
--- lx261-p005/drivers/block/cciss.c	2004-01-22 14:10:20.000000000 -0600
+++ lx261/drivers/block/cciss.c	2004-01-22 15:20:16.000000000 -0600
@@ -2130,6 +2130,15 @@
 	__u64 cfg_base_addr_index;
 	int i;

+	/* check to see if controller has been disabled */
+	/* BEFORE trying to enable it */
+	(void) pci_read_config_word(pdev, PCI_COMMAND,&command);
+	if(!(command & 0x02))
+	{
+		printk(KERN_WARNING "cciss: controller appears to be disabled\n");
+		return(-1);
+	}
+
 	if (pci_enable_device(pdev))
 	{
 		printk(KERN_ERR "cciss: Unable to Enable PCI device\n");
@@ -2145,7 +2154,6 @@
 	device_id = pdev->device;
 	irq = pdev->irq;

-	(void) pci_read_config_word(pdev, PCI_COMMAND,&command);
 	(void) pci_read_config_byte(pdev, PCI_CLASS_REVISION, &revision);
 	(void) pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE,
 						&cache_line_size);
@@ -2154,13 +2162,6 @@
 	(void) pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID,
 						&board_id);

-	/* check to see if controller has been disabled */
-	if(!(command & 0x02))
-	{
-		printk(KERN_WARNING "cciss: controller appears to be disabled\n");
-		return(-1);
-	}
-
 	/* search for our IO range so we can protect it */
 	for(i=0; i<DEVICE_COUNT_RESOURCE; i++)
 	{

Thanks,
mikem
mike.miller@hp.com

