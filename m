Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266766AbUFYPZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266766AbUFYPZh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 11:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266764AbUFYPZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 11:25:35 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:15549 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266765AbUFYPZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 11:25:30 -0400
Subject: [PATCH] dma_get_required_mask()
From: James Bottomley <James.Bottomley@steeleye.com>
To: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 25 Jun 2004 10:25:33 -0500
Message-Id: <1088177133.1940.26.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following the discussion, this is a patch implementing
dma_get_required_mask().  The default implementation simply works out
the largest mask covering all of memory and returns the and of that with
the current dma_mask.  If this looks OK, I'll send out another patch
including the documentation updates as well.

I've put the implementation in linux/dma-mapping.h with a
ARCH_HAS_DMA_GET_REQUIRED_MASK override for those architectures that
would like to do something different.

Any opinions on whether I should also make linux/dma-mapping.h include
linux/bitops.h now since it requires fls() from there?

James

===== include/linux/dma-mapping.h 1.3 vs edited =====
--- 1.3/include/linux/dma-mapping.h	2004-03-30 20:53:54 -05:00
+++ edited/include/linux/dma-mapping.h	2004-06-25 11:12:30 -04:00
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
 


