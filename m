Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbUBEAQV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 19:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbUBEAP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 19:15:58 -0500
Received: from zmamail05.zma.compaq.com ([161.114.64.105]:29457 "EHLO
	zmamail05.zma.compaq.com") by vger.kernel.org with ESMTP
	id S264419AbUBEALy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 19:11:54 -0500
Date: Wed, 4 Feb 2004 18:16:17 -0600 (CST)
From: mikem@beardog.cca.cpqcorp.net
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss updates for 2.6 [7 of 11]
Message-ID: <Pine.LNX.4.58.0402041814360.18320@beardog.cca.cpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 7 of 11. Please apply in order.
This patch replaces reading directly form PCI config space where possible.
Most of what we need is in the pdev struct.
This is in 2.4.
--------------------------------------------------------------------------------------
diff -burN lx261-p006/drivers/block/cciss.c lx261/drivers/block/cciss.c
--- lx261-p006/drivers/block/cciss.c	2004-01-22 15:20:16.000000000 -0600
+++ lx261/drivers/block/cciss.c	2004-01-22 15:36:17.000000000 -0600
@@ -2121,9 +2121,8 @@

 static int cciss_pci_init(ctlr_info_t *c, struct pci_dev *pdev)
 {
-	ushort vendor_id, device_id, command;
-	unchar cache_line_size, latency_timer;
-	unchar irq, revision;
+	ushort subsystem_vendor_id, subsystem_device_id, command;
+	unchar irq = pdev->irq;
 	__u32 board_id, scratchpad = 0;
 	__u64 cfg_offset;
 	__u32 cfg_base_addr;
@@ -2150,17 +2149,10 @@
 		return(-1);
 	}

-	vendor_id = pdev->vendor;
-	device_id = pdev->device;
-	irq = pdev->irq;
-
-	(void) pci_read_config_byte(pdev, PCI_CLASS_REVISION, &revision);
-	(void) pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE,
-						&cache_line_size);
-	(void) pci_read_config_byte(pdev, PCI_LATENCY_TIMER,
-						&latency_timer);
-	(void) pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID,
-						&board_id);
+	subsystem_vendor_id = pdev->subsystem_vendor;
+	subsystem_device_id = pdev->subsystem_device;
+	board_id = (((__u32) (subsystem_device_id << 16) & 0xffff0000) |
+					subsystem_vendor_id);

 	/* search for our IO range so we can protect it */
 	for(i=0; i<DEVICE_COUNT_RESOURCE; i++)
@@ -2188,15 +2180,8 @@
 	}

 #ifdef CCISS_DEBUG
-	printk("vendor_id = %x\n", vendor_id);
-	printk("device_id = %x\n", device_id);
 	printk("command = %x\n", command);
-	for(i=0; i<6; i++)
-		printk("addr[%d] = %x\n", i, pci_resource_start(pdev, i);
-	printk("revision = %x\n", revision);
 	printk("irq = %x\n", irq);
-	printk("cache_line_size = %x\n", cache_line_size);
-	printk("latency_timer = %x\n", latency_timer);
 	printk("board_id = %x\n", board_id);
 #endif /* CCISS_DEBUG */


Thanks,
mikem
mike.miller@hp.com

