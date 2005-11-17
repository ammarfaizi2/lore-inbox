Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbVKQTjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbVKQTjX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 14:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbVKQTjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 14:39:23 -0500
Received: from gold.veritas.com ([143.127.12.110]:5433 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S964818AbVKQTjW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 14:39:22 -0500
Date: Thu, 17 Nov 2005 19:38:03 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] unpaged: anon in VM_UNPAGED
In-Reply-To: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511171937290.4563@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 17 Nov 2005 19:39:21.0877 (UTC) FILETIME=[9BB00C50:01C5EBAE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

copy_one_pte needs to copy the anonymous COWed pages in a VM_UNPAGED
area, zap_pte_range needs to free them, do_wp_page needs to COW them:
just like ordinary pages, not like the unpaged.

But recognizing them is a little subtle: because PageReserved is no
longer a condition for remap_pfn_range, we can now mmap all of /dev/mem
(whether the distro permits, and whether it's advisable on this or that
architecture, is another matter).  So if we can see a PageAnon, it may
not be ours to mess with (or may be ours from elsewhere in the address
space).  I suspect there's an entertaining insoluble self-referential
problem here, but the page_is_anon function does a good practical job,
and MAP_PRIVATE PROT_WRITE VM_UNPAGED will always be an odd choice.

In updating the comment on page_address_in_vma, noticed a potential
NULL dereference, in a path we don't actually take, but fixed it.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/memory.c |   63 +++++++++++++++++++++++++++++++++++++++---------------------
 mm/rmap.c   |    7 ++++--
 2 files changed, 46 insertions(+), 24 deletions(-)

--- unpaged07/mm/memory.c	2005-11-17 15:11:30.000000000 +0000
+++ unpaged08/mm/memory.c	2005-11-17 15:11:43.000000000 +0000
@@ -350,6 +350,22 @@ void print_bad_pte(struct vm_area_struct
 }
 
 /*
+ * page_is_anon applies strict checks for an anonymous page belonging to
+ * this vma at this address.  It is used on VM_UNPAGED vmas, which are
+ * usually populated with shared originals (which must not be counted),
+ * but occasionally contain private COWed copies (when !VM_SHARED, or
+ * perhaps via ptrace when VM_SHARED).  An mmap of /dev/mem might window
+ * free pages, pages from other processes, or from other parts of this:
+ * it's tricky, but try not to be deceived by foreign anonymous pages.
+ */
+static inline int page_is_anon(struct page *page,
+			struct vm_area_struct *vma, unsigned long addr)
+{
+	return page && PageAnon(page) && page_mapped(page) &&
+		page_address_in_vma(page, vma) == addr;
+}
+
+/*
  * copy one vm_area from one task to the other. Assumes the page tables
  * already present in the new task to be cleared in the whole range
  * covered by this vma.
@@ -381,23 +397,22 @@ copy_one_pte(struct mm_struct *dst_mm, s
 		goto out_set_pte;
 	}
 
-	/* If the region is VM_UNPAGED, the mapping is not
-	 * mapped via rmap - duplicate the pte as is.
-	 */
-	if (vm_flags & VM_UNPAGED)
-		goto out_set_pte;
-
 	pfn = pte_pfn(pte);
-	/* If the pte points outside of valid memory but
+	page = pfn_valid(pfn)? pfn_to_page(pfn): NULL;
+
+	if (unlikely(vm_flags & VM_UNPAGED))
+		if (!page_is_anon(page, vma, addr))
+			goto out_set_pte;
+
+	/*
+	 * If the pte points outside of valid memory but
 	 * the region is not VM_UNPAGED, we have a problem.
 	 */
-	if (unlikely(!pfn_valid(pfn))) {
+	if (unlikely(!page)) {
 		print_bad_pte(vma, pte, addr);
 		goto out_set_pte; /* try to do something sane */
 	}
 
-	page = pfn_to_page(pfn);
-
 	/*
 	 * If it's a COW mapping, write protect it both
 	 * in the parent and the child
@@ -568,17 +583,20 @@ static unsigned long zap_pte_range(struc
 			continue;
 		}
 		if (pte_present(ptent)) {
-			struct page *page = NULL;
+			struct page *page;
+			unsigned long pfn;
 
 			(*zap_work) -= PAGE_SIZE;
 
-			if (!(vma->vm_flags & VM_UNPAGED)) {
-				unsigned long pfn = pte_pfn(ptent);
-				if (unlikely(!pfn_valid(pfn)))
-					print_bad_pte(vma, ptent, addr);
-				else
-					page = pfn_to_page(pfn);
-			}
+			pfn = pte_pfn(ptent);
+			page = pfn_valid(pfn)? pfn_to_page(pfn): NULL;
+
+			if (unlikely(vma->vm_flags & VM_UNPAGED)) {
+				if (!page_is_anon(page, vma, addr))
+					page = NULL;
+			} else if (unlikely(!page))
+				print_bad_pte(vma, ptent, addr);
+
 			if (unlikely(details) && page) {
 				/*
 				 * unmap_shared_mapping_pages() wants to
@@ -1295,10 +1313,11 @@ static int do_wp_page(struct mm_struct *
 	old_page = pfn_to_page(pfn);
 	src_page = old_page;
 
-	if (unlikely(vma->vm_flags & VM_UNPAGED)) {
-		old_page = NULL;
-		goto gotten;
-	}
+	if (unlikely(vma->vm_flags & VM_UNPAGED))
+		if (!page_is_anon(old_page, vma, address)) {
+			old_page = NULL;
+			goto gotten;
+		}
 
 	if (PageAnon(old_page) && !TestSetPageLocked(old_page)) {
 		int reuse = can_share_swap_page(old_page);
--- unpaged07/mm/rmap.c	2005-11-17 15:11:16.000000000 +0000
+++ unpaged08/mm/rmap.c	2005-11-17 15:11:43.000000000 +0000
@@ -225,7 +225,9 @@ vma_address(struct page *page, struct vm
 
 /*
  * At what user virtual address is page expected in vma? checking that the
- * page matches the vma: currently only used by unuse_process, on anon pages.
+ * page matches the vma: currently only used on anon pages, by unuse_vma;
+ * and by extraordinary checks on anon pages in VM_UNPAGED vmas, taking
+ * care that an mmap of /dev/mem might window free and foreign pages.
  */
 unsigned long page_address_in_vma(struct page *page, struct vm_area_struct *vma)
 {
@@ -234,7 +236,8 @@ unsigned long page_address_in_vma(struct
 		    (void *)page->mapping - PAGE_MAPPING_ANON)
 			return -EFAULT;
 	} else if (page->mapping && !(vma->vm_flags & VM_NONLINEAR)) {
-		if (vma->vm_file->f_mapping != page->mapping)
+		if (!vma->vm_file ||
+		    vma->vm_file->f_mapping != page->mapping)
 			return -EFAULT;
 	} else
 		return -EFAULT;
