Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262591AbVAJX53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbVAJX53 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 18:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbVAJX5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 18:57:22 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:16855 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262603AbVAJXyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 18:54:22 -0500
Date: Mon, 10 Jan 2005 15:54:08 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, linux-ia64@vger.kernel.org,
       linux-mm@kvack.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Prezeroing V4 [1/4]: Arch specific page zeroing during page fault
In-Reply-To: <Pine.LNX.4.58.0501101552100.25654@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0501101553140.25654@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0501082103120.5207-100000@localhost.localdomain>
 <Pine.LNX.4.58.0501100915200.19135@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0501101004230.2373@ppc970.osdl.org>
 <Pine.LNX.4.58.0501101552100.25654@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the __GFP_ZERO related code by adding a new function
alloc_zeroed_user_highpage that is then used in the anonymous page fault
handler and in the COW code to allocate pages. The function can be defined
per arch to setup special processing for user pages by defining
__HAVE_ARCH_ALLOC_ZEROED_USER_PAGE.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.10/include/asm-ia64/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-ia64/page.h	2004-12-24 13:34:00.000000000 -0800
+++ linux-2.6.10/include/asm-ia64/page.h	2005-01-10 13:53:59.000000000 -0800
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
Index: linux-2.6.10/include/asm-h8300/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-h8300/page.h	2004-12-24 13:35:25.000000000 -0800
+++ linux-2.6.10/include/asm-h8300/page.h	2005-01-10 13:53:59.000000000 -0800
@@ -30,6 +30,9 @@
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)

+#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
+
 /*
  * These are used to make use of C type-checking..
  */
Index: linux-2.6.10/mm/memory.c
===================================================================
--- linux-2.6.10.orig/mm/memory.c	2005-01-10 13:48:11.000000000 -0800
+++ linux-2.6.10/mm/memory.c	2005-01-10 13:54:30.000000000 -0800
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
@@ -1795,7 +1786,7 @@

 		if (unlikely(anon_vma_prepare(vma)))
 			goto no_mem;
-		page = alloc_page_vma(GFP_HIGHZERO, vma, addr);
+		page = alloc_zeroed_user_highpage(vma, addr);
 		if (!page)
 			goto no_mem;

Index: linux-2.6.10/include/asm-m32r/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-m32r/page.h	2004-12-24 13:34:29.000000000 -0800
+++ linux-2.6.10/include/asm-m32r/page.h	2005-01-10 13:53:59.000000000 -0800
@@ -17,6 +17,9 @@
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)

+#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
+
 /*
  * These are used to make use of C type-checking..
  */
Index: linux-2.6.10/include/asm-alpha/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-alpha/page.h	2004-12-24 13:35:24.000000000 -0800
+++ linux-2.6.10/include/asm-alpha/page.h	2005-01-10 13:53:59.000000000 -0800
@@ -18,6 +18,9 @@
 extern void clear_page(void *page);
 #define clear_user_page(page, vaddr, pg)	clear_page(page)

+#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vmaddr)
+#define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
+
 extern void copy_page(void * _to, void * _from);
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)

Index: linux-2.6.10/include/asm-m68knommu/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-m68knommu/page.h	2005-01-10 13:48:11.000000000 -0800
+++ linux-2.6.10/include/asm-m68knommu/page.h	2005-01-10 13:53:59.000000000 -0800
@@ -30,6 +30,9 @@
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)

+#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
+
 /*
  * These are used to make use of C type-checking..
  */
Index: linux-2.6.10/include/asm-cris/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-cris/page.h	2004-12-24 13:34:30.000000000 -0800
+++ linux-2.6.10/include/asm-cris/page.h	2005-01-10 13:53:59.000000000 -0800
@@ -21,6 +21,9 @@
 #define clear_user_page(page, vaddr, pg)    clear_page(page)
 #define copy_user_page(to, from, vaddr, pg) copy_page(to, from)

+#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
+
 /*
  * These are used to make use of C type-checking..
  */
Index: linux-2.6.10/include/linux/highmem.h
===================================================================
--- linux-2.6.10.orig/include/linux/highmem.h	2005-01-10 13:48:11.000000000 -0800
+++ linux-2.6.10/include/linux/highmem.h	2005-01-10 13:53:59.000000000 -0800
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
Index: linux-2.6.10/include/asm-i386/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-i386/page.h	2005-01-10 13:48:11.000000000 -0800
+++ linux-2.6.10/include/asm-i386/page.h	2005-01-10 13:53:59.000000000 -0800
@@ -36,6 +36,9 @@
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)

+#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
+
 /*
  * These are used to make use of C type-checking..
  */
Index: linux-2.6.10/include/asm-x86_64/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-x86_64/page.h	2005-01-10 13:48:11.000000000 -0800
+++ linux-2.6.10/include/asm-x86_64/page.h	2005-01-10 13:53:59.000000000 -0800
@@ -38,6 +38,8 @@
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)

+#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 /*
  * These are used to make use of C type-checking..
  */
Index: linux-2.6.10/include/asm-s390/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-s390/page.h	2004-12-24 13:34:01.000000000 -0800
+++ linux-2.6.10/include/asm-s390/page.h	2005-01-10 13:53:59.000000000 -0800
@@ -106,6 +106,9 @@
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)

+#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
+
 /* Pure 2^n version of get_order */
 extern __inline__ int get_order(unsigned long size)
 {

