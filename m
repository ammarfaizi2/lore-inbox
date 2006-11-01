Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946834AbWKAMH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946834AbWKAMH2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 07:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946724AbWKAMH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 07:07:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63113 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1423975AbWKAMH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 07:07:27 -0500
Message-Id: <20061101120334.714327327@chello.nl>
References: <20061101114435.234474405@chello.nl>
User-Agent: quilt/0.45-1
Date: Wed, 01 Nov 2006 12:44:38 +0100
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <npiggin@suse.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 3/3] mm: k{,um}map_atomic() vs in_atomic()
Content-Disposition: inline; filename=kmap_atomic_generic.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make kmap_atomic/kunmap_atomic denote a pagefault disabled scope. All
non trivial implementations already do this anyway.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Acked-by: Nick Piggin <npiggin@suse.de>
---
 include/asm-mips/highmem.h |   10 ++++++++--
 include/linux/highmem.h    |    8 +++++---
 2 files changed, 13 insertions(+), 5 deletions(-)

Index: linux-2.6/include/asm-mips/highmem.h
===================================================================
--- linux-2.6.orig/include/asm-mips/highmem.h
+++ linux-2.6/include/asm-mips/highmem.h
@@ -21,6 +21,7 @@
 
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/uaccess.h>
 #include <asm/kmap_types.h>
 
 /* undef for production */
@@ -70,11 +71,16 @@ static inline void *kmap(struct page *pa
 
 static inline void *kmap_atomic(struct page *page, enum km_type type)
 {
+	pagefault_disable();
 	return page_address(page);
 }
 
-static inline void kunmap_atomic(void *kvaddr, enum km_type type) { }
-#define kmap_atomic_pfn(pfn, idx)	page_address(pfn_to_page(pfn))
+static inline void kunmap_atomic(void *kvaddr, enum km_type type)
+{
+	pagefault_enable();
+}
+
+#define kmap_atomic_pfn(pfn, idx) kmap_atomic(pfn_to_page(pfn), (idx))
 
 #define kmap_atomic_to_page(ptr) virt_to_page(ptr)
 
Index: linux-2.6/include/linux/highmem.h
===================================================================
--- linux-2.6.orig/include/linux/highmem.h
+++ linux-2.6/include/linux/highmem.h
@@ -3,6 +3,7 @@
 
 #include <linux/fs.h>
 #include <linux/mm.h>
+#include <linux/uaccess.h>
 
 #include <asm/cacheflush.h>
 
@@ -41,9 +42,10 @@ static inline void *kmap(struct page *pa
 
 #define kunmap(page) do { (void) (page); } while (0)
 
-#define kmap_atomic(page, idx)		page_address(page)
-#define kunmap_atomic(addr, idx)	do { } while (0)
-#define kmap_atomic_pfn(pfn, idx)	page_address(pfn_to_page(pfn))
+#define kmap_atomic(page, idx) \
+	({ pagefault_disable(); page_address(page); })
+#define kunmap_atomic(addr, idx)	do { pagefault_enable(); } while (0)
+#define kmap_atomic_pfn(pfn, idx)	kmap_atomic(pfn_to_page(pfn), (idx))
 #define kmap_atomic_to_page(ptr)	virt_to_page(ptr)
 #endif
 

--

