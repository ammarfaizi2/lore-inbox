Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbUD0Eke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbUD0Eke (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 00:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbUD0Eke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 00:40:34 -0400
Received: from ozlabs.org ([203.10.76.45]:1248 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262339AbUD0Ek1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 00:40:27 -0400
Date: Tue, 27 Apr 2004 14:36:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: apw@shadowen.org, agl@us.ibm.com, mbligh@us.ibm.com,
       linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: put_page() tries to handle hugepages but fails
Message-ID: <20040427043652.GF514@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, apw@shadowen.org, agl@us.ibm.com,
	mbligh@us.ibm.com, linux-kernel@vger.kernel.org,
	linuxppc64-dev@lists.linuxppc.org
References: <20040423081856.GJ9243@zax> <20040423013437.1f2b8fc6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040423013437.1f2b8fc6.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2004 at 01:34:37AM -0700, Andrew Morton wrote:
> David Gibson <david@gibson.dropbear.id.au> wrote:
> >
> > Andrew, please apply.
> > 
> > The code of put_page() is misleading, in that it appears to have code
> > handling PageCompound pages (i.e. hugepages).  However it won't
> > actually handle them correctly - __page_cache_release() will not work
> > properly on a compound.  Instead, hugepages should be and are released
> > with huge_page_release() from mm/hugetlb.c.  This patch removes the
> > broken PageCompound path from put_page(), replacing it with a
> > BUG_ON().  This also removes the initialization of page[1].mapping
> > from compoound pages, which was only ever used in this broken code
> > path.
> 
> We could certainly remove the test for a null destructor in there and
> require that compound pages have a destructor installed.

We could, but there seems little point, given that we have to test for
PageCompound anyway, and the destructor is always the same for
hugepages.

> But the main reason why that code is in there is for transparently handling
> direct-io into hugepage regions.  That code does perform put_page against
> 4k pageframes within the huge page and it does follow the pointer to the
> head page.

Ah.  This I did not know.

> With your patch applied get_user_pages() and bio_release_pages() will
> manipulate the refcounts of the inner 4k pages rather than the head pages
> and things will explode.

Actually, no - bio_release_pages() will instantly BUG() with my patch.

> We could change follow_hugetlb_page() to always take a ref against the head
> page and we could teach bio_release_pages() to perform appropriate pfn
> masking to locate the head page, and perform similar tricks for
> futexes-in-large-pages.  But with the code as-is the refcounting works
> transparently.
> 
> If it's "broken" I wanna know why.

It's broken if put_page() ever actually reduces a hugepage's count to
zero, because it will call __page_cache_release() which will do the
wrong thing on hugepages.  We could bypass that by requiring that a
hugepage always has a destructor (and actually setting it in the
correct place, which hugetlb.c currently doesn't as wli pointed out).
But since we only have one destructor, why bother.

Patch below makes put_page() work correctly on hugepages, and uses it
(via page_cache_release()) in place of huge_page_release().  It also
abolishes the destructor pointer - free_huge_page() is always used.
Please apply.

Index: working-2.6/mm/swap.c
===================================================================
--- working-2.6.orig/mm/swap.c	2004-04-14 12:22:49.000000000 +1000
+++ working-2.6/mm/swap.c	2004-04-27 14:19:10.184343216 +1000
@@ -40,13 +40,8 @@
 {
 	if (unlikely(PageCompound(page))) {
 		page = (struct page *)page->private;
-		if (put_page_testzero(page)) {
-			if (page[1].mapping) {	/* destructor? */
-				(*(void (*)(struct page *))page[1].mapping)(page);
-			} else {
-				__page_cache_release(page);
-			}
-		}
+		if (put_page_testzero(page))
+			free_huge_page(page);
 		return;
 	}
 	if (!PageReserved(page) && put_page_testzero(page))
Index: working-2.6/mm/hugetlb.c
===================================================================
--- working-2.6.orig/mm/hugetlb.c	2004-04-14 12:22:49.000000000 +1000
+++ working-2.6/mm/hugetlb.c	2004-04-27 14:24:14.155325888 +1000
@@ -78,20 +78,11 @@
 	free_huge_pages--;
 	spin_unlock(&hugetlb_lock);
 	set_page_count(page, 1);
-	page->lru.prev = (void *)free_huge_page;
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
Index: working-2.6/arch/i386/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/i386/mm/hugetlbpage.c	2004-04-22 09:09:11.000000000 +1000
+++ working-2.6/arch/i386/mm/hugetlbpage.c	2004-04-27 14:21:30.874387904 +1000
@@ -221,7 +221,7 @@
 		if (pte_none(pte))
 			continue;
 		page = pte_page(pte);
-		huge_page_release(page);
+		page_cache_release(page);
 	}
 	mm->rss -= (end - start) >> PAGE_SHIFT;
 	flush_tlb_range(vma, start, end);
Index: working-2.6/arch/ppc64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hugetlbpage.c	2004-04-20 10:50:06.000000000 +1000
+++ working-2.6/arch/ppc64/mm/hugetlbpage.c	2004-04-27 14:21:18.225313880 +1000
@@ -395,7 +395,7 @@
 			flush_hash_hugepage(mm->context, addr,
 					    pte, local);
 
-		huge_page_release(page);
+		page_cache_release(page);
 	}
 
 	mm->rss -= (end - start) >> PAGE_SHIFT;
Index: working-2.6/arch/sh/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/sh/mm/hugetlbpage.c	2004-04-20 10:50:06.000000000 +1000
+++ working-2.6/arch/sh/mm/hugetlbpage.c	2004-04-27 14:22:19.234357656 +1000
@@ -200,7 +200,7 @@
 		if (pte_none(*pte))
 			continue;
 		page = pte_page(*pte);
-		huge_page_release(page);
+		page_cache_release(page);
 		for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
 			pte_clear(pte);
 			pte++;
Index: working-2.6/arch/sparc64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/sparc64/mm/hugetlbpage.c	2004-04-20 10:50:06.000000000 +1000
+++ working-2.6/arch/sparc64/mm/hugetlbpage.c	2004-04-27 14:22:34.274333944 +1000
@@ -198,7 +198,7 @@
 		if (pte_none(*pte))
 			continue;
 		page = pte_page(*pte);
-		huge_page_release(page);
+		page_cache_release(page);
 		for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
 			pte_clear(pte);
 			pte++;
Index: working-2.6/fs/hugetlbfs/inode.c
===================================================================
--- working-2.6.orig/fs/hugetlbfs/inode.c	2004-04-13 11:42:38.000000000 +1000
+++ working-2.6/fs/hugetlbfs/inode.c	2004-04-27 14:23:17.963348384 +1000
@@ -142,7 +142,7 @@
 	int i;
 
 	for (i = 0; i < pagevec_count(pvec); ++i)
-		huge_page_release(pvec->pages[i]);
+		page_cache_release(pvec->pages[i]);
 
 	pagevec_reinit(pvec);
 }
@@ -152,7 +152,7 @@
 	clear_page_dirty(page);
 	ClearPageUptodate(page);
 	remove_from_page_cache(page);
-	huge_page_release(page);
+	page_cache_release(page);
 }
 
 void truncate_hugepages(struct address_space *mapping, loff_t lstart)
Index: working-2.6/include/linux/hugetlb.h
===================================================================
--- working-2.6.orig/include/linux/hugetlb.h	2004-04-20 10:50:08.000000000 +1000
+++ working-2.6/include/linux/hugetlb.h	2004-04-27 14:23:59.443298984 +1000
@@ -16,7 +16,6 @@
 void zap_hugepage_range(struct vm_area_struct *, unsigned long, unsigned long);
 void unmap_hugepage_range(struct vm_area_struct *, unsigned long, unsigned long);
 int hugetlb_prefault(struct address_space *, struct vm_area_struct *);
-void huge_page_release(struct page *);
 int hugetlb_report_meminfo(char *);
 int is_hugepage_mem_enough(size_t);
 unsigned long hugetlb_total_pages(void);
@@ -68,7 +67,6 @@
 #define hugetlb_prefault(mapping, vma)		({ BUG(); 0; })
 #define zap_hugepage_range(vma, start, len)	BUG()
 #define unmap_hugepage_range(vma, start, end)	BUG()
-#define huge_page_release(page)			BUG()
 #define is_hugepage_mem_enough(size)		0
 #define hugetlb_report_meminfo(buf)		0
 #define mark_mm_hugetlb(mm, vma)		do { } while (0)


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
