Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265218AbUF1VL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265218AbUF1VL3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 17:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265214AbUF1VL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 17:11:29 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:45745 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265212AbUF1VLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 17:11:20 -0400
Subject: PATCH] dma_get_required_mask()
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 28 Jun 2004 16:10:43 -0500
Message-Id: <1088457050.2004.40.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements dma_get_required_mask() which may be used by
drivers to probe the optimal DMA descriptor type they should be
implementing on the platform.

I've also tested it this time with the sym_2 driver...making it chose
the correct descriptors for the platform.  (although I don't have a 64
bit platform with >4GB memory, so I only confirmed it selects the 32 bit
descriptors all the time...)

It should be ready for inclusion.

James

===== Documentation/DMA-API.txt 1.7 vs edited =====
--- 1.7/Documentation/DMA-API.txt	2004-03-23 12:12:38 -06:00
+++ edited/Documentation/DMA-API.txt	2004-06-28 10:12:19 -05:00
@@ -162,6 +162,20 @@
 
 Returns: 1 if successful and 0 if not
 
+u64
+dma_get_required_mask(struct device *dev)
+
+After setting the mask with dma_set_mask(), this API returns the
+actual mask (within that already set) that the platform actually
+requires to operate efficiently.  Usually this means the returned mask
+is the minimum required to cover all of memory.  Examining the
+required mask gives drivers with variable descriptor sizes the
+opportunity to use smaller descriptors as necessary.
+
+Requesting the required mask does not alter the current mask.  If you
+wish to take advantage of it, you should issue another dma_set_mask()
+call to lower the mask again.
+
 
 Part Id - Streaming DMA mappings
 --------------------------------
===== include/linux/dma-mapping.h 1.3 vs edited =====
--- 1.3/include/linux/dma-mapping.h	2004-03-30 19:53:54 -06:00
+++ edited/include/linux/dma-mapping.h	2004-06-28 10:07:55 -05:00
@@ -19,6 +19,29 @@
 #define dma_sync_single		dma_sync_single_for_cpu
 #define dma_sync_sg		dma_sync_sg_for_cpu
 
+#ifndef ARCH_HAS_DMA_GET_REQUIRED_MASK
+static inline u64 dma_get_required_mask(struct device *dev)
+{
+	extern unsigned long max_pfn; /* defined in bootmem.h but may
+					 not be included */
+	u32 low_totalram = ((max_pfn - 1) << PAGE_SHIFT);
+	u32 high_totalram = ((max_pfn - 1) >> (32 - PAGE_SHIFT));
+	u64 mask;
+
+	if (!high_totalram) {
+		/* convert to mask just covering totalram */
+		low_totalram = (1 << (fls(low_totalram) - 1));
+		low_totalram += low_totalram - 1;
+		mask = low_totalram;
+	} else {
+		high_totalram = (1 << (fls(high_totalram) - 1));
+		high_totalram += high_totalram - 1;
+		mask = (((u64)high_totalram) << 32) + 0xffffffff;
+	}
+	return mask & *dev->dma_mask;
+}
+#endif
+		
 #endif
 

===== mm/bootmem.c 1.26 vs edited =====
--- 1.26/mm/bootmem.c	2004-06-27 02:19:26 -05:00
+++ edited/mm/bootmem.c	2004-06-28 11:12:00 -05:00
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/bootmem.h>
 #include <linux/mmzone.h>
+#include <linux/module.h>
 #include <asm/dma.h>
 #include <asm/io.h>
 
@@ -26,6 +27,10 @@
 unsigned long max_low_pfn;
 unsigned long min_low_pfn;
 unsigned long max_pfn;
+
+EXPORT_SYMBOL(max_pfn);		/* This is exported so
+				 * dma_get_required_mask(), which uses
+				 * it, can be an inline function */
 
 /* return the number of _pages_ that will be allocated for the boot bitmap */
 unsigned long __init bootmem_bootmap_pages (unsigned long pages)

