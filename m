Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbVKWSDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbVKWSDJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 13:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbVKWSDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 13:03:08 -0500
Received: from usbb-lacimss2.unisys.com ([192.63.108.52]:59917 "EHLO
	usbb-lacimss2.unisys.com") by vger.kernel.org with ESMTP
	id S932124AbVKWSDD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 13:03:03 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] 2.6.14.2  Support for 1K I/O space granularity on the Intel P64H2
Date: Wed, 23 Nov 2005 13:02:52 -0500
Message-ID: <94C8C9E8B25F564F95185BDA64AB05F6028E115E@USTR-EXCH5.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.6.14.2  Support for 1K I/O space granularity on the Intel P64H2
Thread-Index: AcXwWB+eWy2v83aySICvcdIoPbE3rQ==
From: "Yeisley, Dan P." <dan.yeisley@unisys.com>
To: <linux-kernel@vger.kernel.org>
Cc: <gregkh@suse.de>
X-OriginalArrivalTime: 23 Nov 2005 18:02:53.0781 (UTC) FILETIME=[20313050:01C5F058]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel P64H2 PCI bridge has the ability to allocate I/O space with
1KB granularity.  I've written a patch against 2.6.14.2 to take
advantage of this option.  I've tested it on the latest Unisys
ES7000-600.  

Any comments?

--Dan 



diff -Naur linux-2.6.14.2/drivers/pci/probe.c
linux-2.6.14.2-en1k/drivers/pci/probe.c
--- linux-2.6.14.2/drivers/pci/probe.c	2005-11-11 00:33:12.000000000
-0500
+++ linux-2.6.14.2-en1k/drivers/pci/probe.c	2005-11-21
08:52:01.000000000 -0500
@@ -251,8 +251,8 @@
 	res = child->resource[0];
 	pci_read_config_byte(dev, PCI_IO_BASE, &io_base_lo);
 	pci_read_config_byte(dev, PCI_IO_LIMIT, &io_limit_lo);
-	base = (io_base_lo & PCI_IO_RANGE_MASK) << 8;
-	limit = (io_limit_lo & PCI_IO_RANGE_MASK) << 8;
+	base = (io_base_lo & (PCI_IO_RANGE_MASK | 0x0c) ) << 8;
+	limit = (io_limit_lo & (PCI_IO_RANGE_MASK | 0x0c) ) << 8;
 
 	if ((io_base_lo & PCI_IO_RANGE_TYPE_MASK) ==
PCI_IO_RANGE_TYPE_32) {
 		u16 io_base_hi, io_limit_hi;
@@ -266,6 +266,19 @@
 		res->flags = (io_base_lo & PCI_IO_RANGE_TYPE_MASK) |
IORESOURCE_IO;
 		res->start = base;
 		res->end = limit + 0xfff;
+
+                /*
+                ** See if the 1k granularity option is enabled on the
Intel P64H2
+                */
+                if (dev->vendor == PCI_VENDOR_ID_INTEL && dev->device
== 0x1460) {
+                        u16 en1k;
+                        pci_read_config_word(dev, 0x40, &en1k);
+
+                        if(en1k & 0x200) {
+                                res->end = limit + 0x3ff;
+                                printk(KERN_INFO "PCI: Enable I/O Space
to 1 KB Granularity\n");
+                        }
+                }
 	}
 
 	res = child->resource[1];
