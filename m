Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWHFPCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWHFPCF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 11:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWHFPCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 11:02:04 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:39881 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751242AbWHFPCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 11:02:03 -0400
Subject: [PATCH] Proposed update to the kernel kmap/kunmap API
From: James Bottomley <James.Bottomley@SteelEye.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 06 Aug 2006 10:01:55 -0500
Message-Id: <1154876516.3683.201.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The simple part of the proposal is to give non-highmem architectures
access to the kmap API for the purposes of overriding (this is what the
attached patch does).

The more controversial part of the proposal is that we should now
require all architectures with coherence issues to manage data coherence
via the kmap/kunmap API.  Thus driver writers never have to write code
like

kmap(page)
modify data in page
flush_kernel_dcache_page(page)
kunmap(page)

instead, kmap/kunmap will manage the coherence and driver (and
filesystem) writers don't need to worry about how to flush between kmap
and kunmap.   For most architectures, the page only needs to be flushed
if it was actually written to *and* there are user mappings of it, so
the best implementation looks to be:  clear the page dirty pte bit in
the kernel page tables on kmap and on kunmap, check page->mappings for
user maps, and then the dirty bit, and only flush if it both has user
mappings and is dirty.

James

Index: linux-2.6/include/linux/highmem.h
===================================================================
--- linux-2.6.orig/include/linux/highmem.h      2006-07-26 17:51:09.000000000 -0700
+++ linux-2.6/include/linux/highmem.h   2006-07-26 17:51:18.000000000 -0700
@@ -29,6 +29,7 @@
 
 static inline unsigned int nr_free_highpages(void) { return 0; }
 
+#ifndef ARCH_HAS_KMAP
 static inline void *kmap(struct page *page)
 {
        might_sleep();
@@ -41,6 +42,7 @@
 #define kunmap_atomic(addr, idx)       do { } while (0)
 #define kmap_atomic_pfn(pfn, idx)      page_address(pfn_to_page(pfn))
 #define kmap_atomic_to_page(ptr)       virt_to_page(ptr)
+#endif
 
 #endif /* CONFIG_HIGHMEM */
 



