Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbVKOVs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbVKOVs2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 16:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbVKOVs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 16:48:28 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:28124 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751161AbVKOVs1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 16:48:27 -0500
Date: Tue, 15 Nov 2005 13:47:16 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Adam Litke <agl@us.ibm.com>
cc: linux-mm@kvack.org, ak@suse.de, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com, wli@holomorphy.com, akpm@osdl.org
Subject: [PATCH] hugepages: fold find_or_alloc_pages into huge_no_page()
Message-ID: <Pine.LNX.4.62.0511151345470.11011@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The number of parameters for find_or_alloc_page increases significantly after
policy support is added to huge pages. Simplify the code by folding
find_or_alloc_huge_page() into hugetlb_no_page().

Adam Litke objected to this piece in an earlier patch but I think this is a
good simplification. Diffstat shows that we can get rid of almost half of the
lines of find_or_alloc_page(). If we can find no consensus then lets simply drop
this patch.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

----

 hugetlb.c |   67 +++++++++++++++++++++++---------------------------------------
 1 files changed, 25 insertions(+), 42 deletions(-)

Index: linux-2.6.14-mm2/mm/hugetlb.c
===================================================================
--- linux-2.6.14-mm2.orig/mm/hugetlb.c	2005-11-15 13:12:33.000000000 -0800
+++ linux-2.6.14-mm2/mm/hugetlb.c	2005-11-15 13:29:37.000000000 -0800
@@ -379,43 +379,6 @@ void unmap_hugepage_range(struct vm_area
 	flush_tlb_range(vma, start, end);
 }
 
-static struct page *find_or_alloc_huge_page(struct vm_area_struct *vma,
-			unsigned long addr, struct address_space *mapping,
-			unsigned long idx, int shared)
-{
-	struct page *page;
-	int err;
-
-retry:
-	page = find_lock_page(mapping, idx);
-	if (page)
-		goto out;
-
-	if (hugetlb_get_quota(mapping))
-		goto out;
-	page = alloc_huge_page(vma, addr);
-	if (!page) {
-		hugetlb_put_quota(mapping);
-		goto out;
-	}
-
-	if (shared) {
-		err = add_to_page_cache(page, mapping, idx, GFP_KERNEL);
-		if (err) {
-			put_page(page);
-			hugetlb_put_quota(mapping);
-			if (err == -EEXIST)
-				goto retry;
-			page = NULL;
-		}
-	} else {
-		/* Caller expects a locked page */
-		lock_page(page);
-	}
-out:
-	return page;
-}
-
 static int hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, pte_t *ptep, pte_t pte)
 {
@@ -482,12 +445,31 @@ int hugetlb_no_page(struct mm_struct *mm
 	 * Use page lock to guard against racing truncation
 	 * before we get page_table_lock.
 	 */
-	page = find_or_alloc_huge_page(vma, address, mapping, idx,
-			vma->vm_flags & VM_SHARED);
-	if (!page)
-		goto out;
+retry:
+	page = find_lock_page(mapping, idx);
+	if (!page) {
+		if (hugetlb_get_quota(mapping))
+			goto out;
+		page = alloc_huge_page(vma, address);
+		if (!page) {
+			hugetlb_put_quota(mapping);
+			goto out;
+		}
 
-	BUG_ON(!PageLocked(page));
+		if (vma->vm_flags & VM_SHARED) {
+			int err;
+
+			err = add_to_page_cache(page, mapping, idx, GFP_KERNEL);
+			if (err) {
+				put_page(page);
+				hugetlb_put_quota(mapping);
+				if (err == -EEXIST)
+					goto retry;
+				goto out;
+			}
+		} else
+			lock_page(page);
+	}
 
 	spin_lock(&mm->page_table_lock);
 	size = i_size_read(mapping->host) >> HPAGE_SHIFT;
