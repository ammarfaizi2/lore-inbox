Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262462AbVAJUYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbVAJUYR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 15:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbVAJUWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 15:22:20 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:62600 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262462AbVAJURw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 15:17:52 -0500
Date: Mon, 10 Jan 2005 12:17:35 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, linux-ia64@vger.kernel.org,
       linux-mm@kvack.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Prezeroing V3 [1/4]: Allow request for zeroed memory
In-Reply-To: <Pine.LNX.4.58.0501101004230.2373@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0501101213400.23657@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0501082103120.5207-100000@localhost.localdomain>
 <Pine.LNX.4.58.0501100915200.19135@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0501101004230.2373@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2005, Linus Torvalds wrote:

> Currently the BK tree
>  - doesn't use __GFP_ZERO with anonymous user-mapped pages (which is what
>    you wrote this whole thing for ;)
>
>    Potential fix: declare a per-architecture "alloc_user_highpage(vaddr)"
>    that does the proper magic on virtually indexed machines, and on others
>    it just does a "alloc_page(GFP_HIGHUSER | __GFP_ZERO)".

The following patch adds an alloc_zeroed_user_highpage(vma, vaddr). It
also uses zeroed pages on COW. clear_user_highpage is now only used by
that function. Fold it into alloc_zeroed_user_highpage?

This is against last hours bitkeeper tree. mm/memory.o compiles fine but
I was not able to build a ia64 kernel due to some pieces that seem to be
missing in last hours tree.

Index: linus/include/asm-ia64/page.h
===================================================================
--- linus.orig/include/asm-ia64/page.h	2004-10-20 12:04:58.000000000 -0700
+++ linus/include/asm-ia64/page.h	2005-01-10 12:05:55.000000000 -0800
@@ -75,6 +75,16 @@
 	flush_dcache_page(page);		\
 } while (0)

+
+#define alloc_zeroed_user_highpage(vma, vaddr) \
+({						\
+	struct page *page = alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr); \
+	flush_dcache_page(page);		\
+	 page;					\
+})
+
+#define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
+
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)

 #ifdef CONFIG_VIRTUAL_MEM_MAP
Index: linus/include/asm-h8300/page.h
===================================================================
--- linus.orig/include/asm-h8300/page.h	2004-10-20 12:04:58.000000000 -0700
+++ linus/include/asm-h8300/page.h	2005-01-10 11:53:17.000000000 -0800
@@ -30,6 +30,9 @@
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)

+#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
+
 /*
  * These are used to make use of C type-checking..
  */
Index: linus/mm/memory.c
===================================================================
--- linus.orig/mm/memory.c	2005-01-10 11:44:39.000000000 -0800
+++ linus/mm/memory.c	2005-01-10 12:05:21.000000000 -0800
@@ -84,20 +84,6 @@
 EXPORT_SYMBOL(vmalloc_earlyreserve);

 /*
- * We special-case the C-O-W ZERO_PAGE, because it's such
- * a common occurrence (no need to read the page to know
- * that it's zero - better for the cache and memory subsystem).
- */
-static inline void copy_cow_page(struct page * from, struct page * to, unsigned long address)
-{
-	if (from == ZERO_PAGE(address)) {
-		clear_user_highpage(to, address);
-		return;
-	}
-	copy_user_highpage(to, from, address);
-}
-
-/*
  * Note: this doesn't free the actual pages themselves. That
  * has been handled earlier when unmapping all the memory regions.
  */
@@ -1329,11 +1315,16 @@

 	if (unlikely(anon_vma_prepare(vma)))
 		goto no_new_page;
-	new_page = alloc_page_vma(GFP_HIGHUSER, vma, address);
-	if (!new_page)
-		goto no_new_page;
-	copy_cow_page(old_page,new_page,address);
-
+	if (old_page == ZERO_PAGE(address)) {
+		new_page = alloc_zeroed_user_highpage(vma, address);
+		if (!new_page)
+			goto no_new_page;
+	} else {
+		new_page = alloc_page_vma(GFP_HIGHUSER, vma, address);
+		if (!new_page)
+			goto no_new_page;
+		copy_user_highpage(new_page, old_page, address);
+	}
 	/*
 	 * Re-check the pte - we dropped the lock
 	 */
@@ -1795,10 +1786,9 @@

 		if (unlikely(anon_vma_prepare(vma)))
 			goto no_mem;
-		page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
+		page = alloc_zeroed_user_highpage(vma, addr);
 		if (!page)
 			goto no_mem;
-		clear_user_highpage(page, addr);

 		spin_lock(&mm->page_table_lock);
 		page_table = pte_offset_map(pmd, addr);
Index: linus/include/asm-m32r/page.h
===================================================================
--- linus.orig/include/asm-m32r/page.h	2004-10-20 12:04:58.000000000 -0700
+++ linus/include/asm-m32r/page.h	2005-01-10 12:08:03.000000000 -0800
@@ -17,6 +17,9 @@
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)

+#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
+
 /*
  * These are used to make use of C type-checking..
  */
Index: linus/include/asm-alpha/page.h
===================================================================
--- linus.orig/include/asm-alpha/page.h	2004-10-20 12:04:57.000000000 -0700
+++ linus/include/asm-alpha/page.h	2005-01-10 11:54:37.000000000 -0800
@@ -18,6 +18,9 @@
 extern void clear_page(void *page);
 #define clear_user_page(page, vaddr, pg)	clear_page(page)

+#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vmaddr)
+#define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
+
 extern void copy_page(void * _to, void * _from);
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)

Index: linus/include/asm-m68knommu/page.h
===================================================================
--- linus.orig/include/asm-m68knommu/page.h	2005-01-10 09:53:05.000000000 -0800
+++ linus/include/asm-m68knommu/page.h	2005-01-10 11:54:27.000000000 -0800
@@ -30,6 +30,9 @@
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)

+#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
+
 /*
  * These are used to make use of C type-checking..
  */
Index: linus/include/asm-cris/page.h
===================================================================
--- linus.orig/include/asm-cris/page.h	2004-10-20 12:04:57.000000000 -0700
+++ linus/include/asm-cris/page.h	2005-01-10 11:55:06.000000000 -0800
@@ -21,6 +21,9 @@
 #define clear_user_page(page, vaddr, pg)    clear_page(page)
 #define copy_user_page(to, from, vaddr, pg) copy_page(to, from)

+#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
+
 /*
  * These are used to make use of C type-checking..
  */
Index: linus/include/linux/highmem.h
===================================================================
--- linus.orig/include/linux/highmem.h	2005-01-06 12:58:48.000000000 -0800
+++ linus/include/linux/highmem.h	2005-01-10 12:08:56.000000000 -0800
@@ -42,6 +42,17 @@
 	smp_wmb();
 }

+#ifndef __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
+static inline struct page* alloc_zeroed_user_highpage(struct vm_area_struct *vma,
+	 unsigned long vaddr)
+{
+	struct page *page = alloc_page_vma(GFP_HIGHUSER, vma, vaddr);
+
+	clear_user_highpage(page, vaddr);
+	return page;
+}
+#endif
+
 static inline void clear_highpage(struct page *page)
 {
 	void *kaddr = kmap_atomic(page, KM_USER0);
Index: linus/include/asm-i386/page.h
===================================================================
--- linus.orig/include/asm-i386/page.h	2005-01-06 12:58:47.000000000 -0800
+++ linus/include/asm-i386/page.h	2005-01-10 12:09:43.000000000 -0800
@@ -36,6 +36,9 @@
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)

+#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
+
 /*
  * These are used to make use of C type-checking..
  */
Index: linus/include/asm-x86_64/page.h
===================================================================
--- linus.orig/include/asm-x86_64/page.h	2005-01-06 12:58:48.000000000 -0800
+++ linus/include/asm-x86_64/page.h	2005-01-10 11:56:04.000000000 -0800
@@ -38,6 +38,8 @@
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)

+#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 /*
  * These are used to make use of C type-checking..
  */
Index: linus/include/asm-s390/page.h
===================================================================
--- linus.orig/include/asm-s390/page.h	2004-10-20 12:04:59.000000000 -0700
+++ linus/include/asm-s390/page.h	2005-01-10 11:56:33.000000000 -0800
@@ -106,6 +106,9 @@
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)

+#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
+
 /* Pure 2^n version of get_order */
 extern __inline__ int get_order(unsigned long size)
 {
