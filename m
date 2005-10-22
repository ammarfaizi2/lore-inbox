Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbVJVQY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbVJVQY3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 12:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbVJVQY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 12:24:28 -0400
Received: from gold.veritas.com ([143.127.12.110]:24837 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932249AbVJVQY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 12:24:27 -0400
Date: Sat, 22 Oct 2005 17:23:27 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] mm: parisc pte atomicity
In-Reply-To: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0510221722260.18047@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 22 Oct 2005 16:24:27.0419 (UTC) FILETIME=[1281DEB0:01C5D725]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's a worrying function translation_exists in parisc cacheflush.h,
unaffected by split ptlock since flush_dcache_page is using it on some
other mm, without any relevant lock.  Oh well, make it a slightly more
robust by factoring the pfn check within it.  And it looked liable to
confuse a camouflaged swap or file entry with a good pte: fix that too.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/parisc/kernel/cache.c      |   24 +++++++++---------------
 include/asm-parisc/cacheflush.h |   35 +++++++++++++++++++----------------
 2 files changed, 28 insertions(+), 31 deletions(-)

--- mm2/arch/parisc/kernel/cache.c	2005-03-02 07:38:56.000000000 +0000
+++ mm3/arch/parisc/kernel/cache.c	2005-10-22 14:06:30.000000000 +0100
@@ -266,7 +266,6 @@ void flush_dcache_page(struct page *page
 	unsigned long offset;
 	unsigned long addr;
 	pgoff_t pgoff;
-	pte_t *pte;
 	unsigned long pfn = page_to_pfn(page);
 
 
@@ -297,21 +296,16 @@ void flush_dcache_page(struct page *page
 		 * taking a page fault if the pte doesn't exist.
 		 * This is just for speed.  If the page translation
 		 * isn't there, there's no point exciting the
-		 * nadtlb handler into a nullification frenzy */
-
-
-  		if(!(pte = translation_exists(mpnt, addr)))
-			continue;
-
-		/* make sure we really have this page: the private
+		 * nadtlb handler into a nullification frenzy.
+		 *
+		 * Make sure we really have this page: the private
 		 * mappings may cover this area but have COW'd this
-		 * particular page */
-		if(pte_pfn(*pte) != pfn)
-  			continue;
-
-		__flush_cache_page(mpnt, addr);
-
-		break;
+		 * particular page.
+		 */
+  		if (translation_exists(mpnt, addr, pfn)) {
+			__flush_cache_page(mpnt, addr);
+			break;
+		}
 	}
 	flush_dcache_mmap_unlock(mapping);
 }
--- mm2/include/asm-parisc/cacheflush.h	2005-10-11 12:07:49.000000000 +0100
+++ mm3/include/asm-parisc/cacheflush.h	2005-10-22 14:06:30.000000000 +0100
@@ -100,30 +100,34 @@ static inline void flush_cache_range(str
 
 /* Simple function to work out if we have an existing address translation
  * for a user space vma. */
-static inline pte_t *__translation_exists(struct mm_struct *mm,
-					  unsigned long addr)
+static inline int translation_exists(struct vm_area_struct *vma,
+				unsigned long addr, unsigned long pfn)
 {
-	pgd_t *pgd = pgd_offset(mm, addr);
+	pgd_t *pgd = pgd_offset(vma->vm_mm, addr);
 	pmd_t *pmd;
-	pte_t *pte;
+	pte_t pte;
 
 	if(pgd_none(*pgd))
-		return NULL;
+		return 0;
 
 	pmd = pmd_offset(pgd, addr);
 	if(pmd_none(*pmd) || pmd_bad(*pmd))
-		return NULL;
+		return 0;
 
-	pte = pte_offset_map(pmd, addr);
+	/* We cannot take the pte lock here: flush_cache_page is usually
+	 * called with pte lock already held.  Whereas flush_dcache_page
+	 * takes flush_dcache_mmap_lock, which is lower in the hierarchy:
+	 * the vma itself is secure, but the pte might come or go racily.
+	 */
+	pte = *pte_offset_map(pmd, addr);
+	/* But pte_unmap() does nothing on this architecture */
+
+	/* Filter out coincidental file entries and swap entries */
+	if (!(pte_val(pte) & (_PAGE_FLUSH|_PAGE_PRESENT)))
+		return 0;
 
-	/* The PA flush mappings show up as pte_none, but they're
-	 * valid none the less */
-	if(pte_none(*pte) && ((pte_val(*pte) & _PAGE_FLUSH) == 0))
-		return NULL;
-	return pte;
+	return pte_pfn(pte) == pfn;
 }
-#define	translation_exists(vma, addr)	__translation_exists((vma)->vm_mm, addr)
-
 
 /* Private function to flush a page from the cache of a non-current
  * process.  cr25 contains the Page Directory of the current user
@@ -175,9 +179,8 @@ flush_cache_page(struct vm_area_struct *
 {
 	BUG_ON(!vma->vm_mm->context);
 
-	if(likely(translation_exists(vma, vmaddr)))
+	if (likely(translation_exists(vma, vmaddr, pfn)))
 		__flush_cache_page(vma, vmaddr);
 
 }
 #endif
-
