Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264769AbUDWKr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264769AbUDWKr4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 06:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264780AbUDWKr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 06:47:56 -0400
Received: from holomorphy.com ([207.189.100.168]:29352 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264769AbUDWKrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 06:47:49 -0400
Date: Fri, 23 Apr 2004 03:47:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
       linuxppc64-dev@lists.linuxppc.org
Subject: Re: put_page() tries to handle hugepages but fails
Message-ID: <20040423104744.GG743@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, david@gibson.dropbear.id.au,
	linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
References: <20040423081856.GJ9243@zax> <20040423013437.1f2b8fc6.akpm@osdl.org> <20040423102824.GF743@holomorphy.com> <20040423033522.03ab14fc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040423033522.03ab14fc.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2004 at 03:35:22AM -0700, Andrew Morton wrote:
> Sure.
> This of course duplicates huge_page_release(), which can be killed off.

Ah, but mm/hugetlb.c is putting the destructor in head->lru.prev not
head[1].mapping; fix below along with nuking  huge_page_release().


-- wli


Index: wli-2.6.6-rc2-mm1/include/linux/hugetlb.h
===================================================================
--- wli-2.6.6-rc2-mm1.orig/include/linux/hugetlb.h	2004-04-21 05:20:33.000000000 -0700
+++ wli-2.6.6-rc2-mm1/include/linux/hugetlb.h	2004-04-23 03:40:24.000000000 -0700
@@ -18,7 +18,6 @@
 void zap_hugepage_range(struct vm_area_struct *, unsigned long, unsigned long);
 void unmap_hugepage_range(struct vm_area_struct *, unsigned long, unsigned long);
 int hugetlb_prefault(struct address_space *, struct vm_area_struct *);
-void huge_page_release(struct page *);
 int hugetlb_report_meminfo(char *);
 int is_hugepage_mem_enough(size_t);
 unsigned long hugetlb_total_pages(void);
@@ -70,7 +69,6 @@
 #define hugetlb_prefault(mapping, vma)		({ BUG(); 0; })
 #define zap_hugepage_range(vma, start, len)	BUG()
 #define unmap_hugepage_range(vma, start, end)	BUG()
-#define huge_page_release(page)			BUG()
 #define is_hugepage_mem_enough(size)		0
 #define hugetlb_report_meminfo(buf)		0
 #define mark_mm_hugetlb(mm, vma)		do { } while (0)
Index: wli-2.6.6-rc2-mm1/mm/swap.c
===================================================================
--- wli-2.6.6-rc2-mm1.orig/mm/swap.c	2004-04-21 05:19:58.000000000 -0700
+++ wli-2.6.6-rc2-mm1/mm/swap.c	2004-04-23 03:21:22.000000000 -0700
@@ -41,15 +41,12 @@
 	if (unlikely(PageCompound(page))) {
 		page = (struct page *)page->private;
 		if (put_page_testzero(page)) {
-			if (page[1].mapping) {	/* destructor? */
-				(*(void (*)(struct page *))page[1].mapping)(page);
-			} else {
-				__page_cache_release(page);
-			}
+			void (*destructor)(struct page *);
+			destructor = (void (*)(struct page *))page[1].mapping;
+			BUG_ON(!destructor);
+			(*destructor)(page);
 		}
-		return;
-	}
-	if (!PageReserved(page) && put_page_testzero(page))
+	} else if (!PageReserved(page) && put_page_testzero(page))
 		__page_cache_release(page);
 }
 EXPORT_SYMBOL(put_page);
Index: wli-2.6.6-rc2-mm1/mm/hugetlb.c
===================================================================
--- wli-2.6.6-rc2-mm1.orig/mm/hugetlb.c	2004-04-21 05:19:58.000000000 -0700
+++ wli-2.6.6-rc2-mm1/mm/hugetlb.c	2004-04-23 03:45:41.000000000 -0700
@@ -78,20 +78,12 @@
 	free_huge_pages--;
 	spin_unlock(&hugetlb_lock);
 	set_page_count(page, 1);
-	page->lru.prev = (void *)free_huge_page;
+	page[1].mapping = (void *)free_huge_page;
 	for (i = 0; i < (HPAGE_SIZE/PAGE_SIZE); ++i)
 		clear_highpage(&page[i]);
 	return page;
 }
 
-void huge_page_release(struct page *page)
-{
-	if (!put_page_testzero(page))
-		return;
-
-	free_huge_page(page);
-}
-
 static int __init hugetlb_init(void)
 {
 	unsigned long i;
Index: wli-2.6.6-rc2-mm1/arch/i386/mm/hugetlbpage.c
===================================================================
--- wli-2.6.6-rc2-mm1.orig/arch/i386/mm/hugetlbpage.c	2004-04-21 05:20:29.000000000 -0700
+++ wli-2.6.6-rc2-mm1/arch/i386/mm/hugetlbpage.c	2004-04-23 03:40:04.000000000 -0700
@@ -220,7 +220,7 @@
 		if (pte_none(pte))
 			continue;
 		page = pte_page(pte);
-		huge_page_release(page);
+		put_page(page);
 	}
 	mm->rss -= (end - start) >> PAGE_SHIFT;
 	flush_tlb_range(vma, start, end);
Index: wli-2.6.6-rc2-mm1/arch/ia64/mm/hugetlbpage.c
===================================================================
--- wli-2.6.6-rc2-mm1.orig/arch/ia64/mm/hugetlbpage.c	2004-04-21 05:19:41.000000000 -0700
+++ wli-2.6.6-rc2-mm1/arch/ia64/mm/hugetlbpage.c	2004-04-23 03:40:07.000000000 -0700
@@ -249,7 +249,7 @@
 		if (pte_none(*pte))
 			continue;
 		page = pte_page(*pte);
-		huge_page_release(page);
+		put_page(page);
 		pte_clear(pte);
 	}
 	mm->rss -= (end - start) >> PAGE_SHIFT;
Index: wli-2.6.6-rc2-mm1/arch/ppc64/mm/hugetlbpage.c
===================================================================
--- wli-2.6.6-rc2-mm1.orig/arch/ppc64/mm/hugetlbpage.c	2004-04-21 05:20:29.000000000 -0700
+++ wli-2.6.6-rc2-mm1/arch/ppc64/mm/hugetlbpage.c	2004-04-23 03:40:10.000000000 -0700
@@ -394,7 +394,7 @@
 			flush_hash_hugepage(mm->context, addr,
 					    pte, local);
 
-		huge_page_release(page);
+		put_page(page);
 	}
 
 	mm->rss -= (end - start) >> PAGE_SHIFT;
Index: wli-2.6.6-rc2-mm1/arch/sh/mm/hugetlbpage.c
===================================================================
--- wli-2.6.6-rc2-mm1.orig/arch/sh/mm/hugetlbpage.c	2004-04-21 05:19:43.000000000 -0700
+++ wli-2.6.6-rc2-mm1/arch/sh/mm/hugetlbpage.c	2004-04-23 03:40:14.000000000 -0700
@@ -200,7 +200,7 @@
 		if (pte_none(*pte))
 			continue;
 		page = pte_page(*pte);
-		huge_page_release(page);
+		put_page(page);
 		for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
 			pte_clear(pte);
 			pte++;
Index: wli-2.6.6-rc2-mm1/arch/sparc64/mm/hugetlbpage.c
===================================================================
--- wli-2.6.6-rc2-mm1.orig/arch/sparc64/mm/hugetlbpage.c	2004-04-21 05:19:43.000000000 -0700
+++ wli-2.6.6-rc2-mm1/arch/sparc64/mm/hugetlbpage.c	2004-04-23 03:40:17.000000000 -0700
@@ -198,7 +198,7 @@
 		if (pte_none(*pte))
 			continue;
 		page = pte_page(*pte);
-		huge_page_release(page);
+		put_page(page);
 		for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
 			pte_clear(pte);
 			pte++;
