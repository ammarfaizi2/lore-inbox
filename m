Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269621AbTGJVvf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 17:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266499AbTGJVtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 17:49:08 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:24068 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S266501AbTGJVqZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 17:46:25 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: FW: cciss updates for 2.4.22-pre3  [6 of 6]
Date: Thu, 10 Jul 2003 17:01:05 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF104052A68@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cciss updates for 2.4.22-pre3  [6 of 6]
Thread-Index: AcNHLepFDln84VkzTJGsJaWNqaodpAAAM4BA
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Jul 2003 22:01:05.0483 (UTC) FILETIME=[C29099B0:01C3472E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Miller, Mike (OS Dev) 
Sent: Thursday, July 10, 2003 4:55 PM
To: 'axboe@suse.de'; 'marcelo@conectiva.com.br'
Cc: 'alan@lxorguk.ukuu.org.uk'; 'linuxkernel@vger.kernel.org'
Subject: cciss updates for 2.4.22-pre3 [6 of 6]


This is the 6th of 6 updates for cciss. Apply this patch AFTER applying the 5th of 6.

This patch was built & tested using kernel 2.4.21 with the 2.4.22pre3 patch
applied. It is intended for inclusion in the 2.4.22 kernel. Note the caveat 
below.
Patch name: p2_cciss_2447_pci_read_fixes_for_lx2422p3.patch
Changes:
        1. Reduces reading directly from PCI config space. Most of the
	   info we require is already in the pci_dev struct (except the
	   command register). Request from Redhat. 
	2. Miscellaneous code cleanup, remove some debug printk()'s, etc.
Caveats:
        This patch and p1_cciss_2448_pci_enable_fix_for_lx2422p3.patch
        both touch code very close to each other. Apply
        p1_cciss_2448_pci_enable_fix_for_lx2422p3.patch first, then apply 
	this patch. Otherwise, they may not patch cleanly.
--------------------------------------------------------------------------------------------------------------------
diff -burN lx2422p3.test/drivers/block/cciss.c lx2422p3/drivers/block/cciss.c
--- lx2422p3.test/drivers/block/cciss.c	2003-07-07 16:25:53.000000000 -0500
+++ lx2422p3/drivers/block/cciss.c	2003-07-07 16:35:35.000000000 -0500
@@ -2474,19 +2474,14 @@
 			
 static int cciss_pci_init(ctlr_info_t *c, struct pci_dev *pdev)
 {
-	ushort vendor_id, device_id, command;
-	unchar cache_line_size, latency_timer;
-	unchar irq, revision;
+	ushort subsystem_vendor_id, subsystem_device_id, command;
+	unchar irq = pdev->irq;
 	__u32 board_id;
 	__u64 cfg_offset;
 	__u32 cfg_base_addr;
 	__u64 cfg_base_addr_index;
 	int i;
 
-	vendor_id = pdev->vendor;
-	device_id = pdev->device;
-	irq = pdev->irq;
-
 	/* check to see if controller has been disabled */
 	/* BEFORE we try to enable it */
 	(void) pci_read_config_word(pdev, PCI_COMMAND,&command);
@@ -2503,14 +2498,11 @@
 		return -1;
 	}
 	
-	(void) pci_read_config_byte(pdev, PCI_CLASS_REVISION, &revision);
-	(void) pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE,
-						&cache_line_size);
-	(void) pci_read_config_byte(pdev, PCI_LATENCY_TIMER,
-						&latency_timer);
+	subsystem_vendor_id = pdev->subsystem_vendor;
+	subsystem_device_id = pdev->subsystem_device;
+	board_id = (((__u32) (subsystem_device_id << 16) & 0xffff0000) |
+					subsystem_vendor_id );
 
-	(void) pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, 
-						&board_id);
 
 	/* search for our IO range so we can protect it */
 	for (i=0; i<DEVICE_COUNT_RESOURCE; i++) {
@@ -2538,15 +2530,8 @@
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
