Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266512AbTGJVsf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 17:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266499AbTGJVsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 17:48:35 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:22289 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S266512AbTGJVqG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 17:46:06 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: FW: cciss updates for 2.4.22-pre3  [5 of 6]
Date: Thu, 10 Jul 2003 17:00:40 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF104052A67@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cciss updates for 2.4.22-pre3  [5 of 6]
Thread-Index: AcNHLZLxW0pNlX0xRyytKjL6ByHGZwAARfEA
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Jul 2003 22:00:42.0046 (UTC) FILETIME=[B49865E0:01C3472E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Miller, Mike (OS Dev) 
Sent: Thursday, July 10, 2003 4:53 PM
To: 'axboe@suse.de'; 'marcelo@conectiva.com.br'
Cc: 'alan@lxorguk.ukuu.org.uk'; 'linuxkernel@vger.kernel.org'
Subject: cciss updates for 2.4.22-pre3 [5 of 6]


This is the 5th of 6 updates. Apply this patch before applying the 6th patch.

This patch was built & tested using kernel 2.4.21 with the 2.4.22pre3 patch
applied. It is intended for inclusion in the 2.4.22 kernel. Note the caveat
below.
Patch name: p1_cciss_2447_pci_enable_fix_for_lx2422p3.patch
Changes:
	1. Checks the command register BEFORE trying to enable the controller.
	   If the controller was disabled via the ROM Based Setup Utility or
	   the System Configuration Utility the driver may Oops while loading.
	   Bug fix.
Caveats:
	This patch and p2_cciss_2448_pci_read_fixes_for_lx2422p3.patch both 
	touch code very close to each other. Apply this patch first, then apply 
	p2_cciss_2448_pci_read_fixes_lx2422p3.patch. Otherwise, they may not 
	patch cleanly.
--------------------------------------------------------------------------------------------------------------------
diff -burN lx2422p3.test/drivers/block/cciss.c lx2422p3/drivers/block/cciss.c
--- lx2422p3.test/drivers/block/cciss.c	2003-07-07 14:51:32.000000000 -0500
+++ lx2422p3/drivers/block/cciss.c	2003-07-07 16:14:36.000000000 -0500
@@ -2487,6 +2487,13 @@
 	device_id = pdev->device;
 	irq = pdev->irq;
 
+	/* check to see if controller has been disabled */
+	/* BEFORE we try to enable it */
+	(void) pci_read_config_word(pdev, PCI_COMMAND,&command);
+	if (!(command & 0x02)) {
+		printk(KERN_WARNING "cciss: controller appears to be disabled\n");
+		return -1;
+	}
 	if (pci_enable_device(pdev)) {
 		printk(KERN_ERR "cciss: Unable to Enable PCI device\n");
 		return -1;
@@ -2496,7 +2503,6 @@
 		return -1;
 	}
 	
-	(void) pci_read_config_word(pdev, PCI_COMMAND,&command);
 	(void) pci_read_config_byte(pdev, PCI_CLASS_REVISION, &revision);
 	(void) pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE,
 						&cache_line_size);
@@ -2506,11 +2512,6 @@
 	(void) pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, 
 						&board_id);
 
-	/* check to see if controller has been disabled */
-	if (!(command & 0x02)) {
-		printk(KERN_WARNING "cciss: controller appears to be disabled\n");
-		return -1;
-	}
 	/* search for our IO range so we can protect it */
 	for (i=0; i<DEVICE_COUNT_RESOURCE; i++) {
 		/* is this an IO range */
