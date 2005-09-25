Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751520AbVIYPsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbVIYPsE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 11:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbVIYPsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 11:48:04 -0400
Received: from silver.veritas.com ([143.127.12.111]:10678 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751520AbVIYPsC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 11:48:02 -0400
Date: Sun, 25 Sep 2005 16:47:33 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 01/21] mm: hugetlb truncation fixes
In-Reply-To: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0509251646380.3490@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 25 Sep 2005 15:48:00.0078 (UTC) FILETIME=[8198DEE0:01C5C1E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hugetlbfs allows truncation of its files (should it?), but hugetlb.c
often forgets that: crashes and misaccounting ensue.

copy_hugetlb_page_range better grab the src page_table_lock since we
don't want to guess what happens if concurrently truncated.
unmap_hugepage_range rss accounting must not assume the full range was
mapped.  follow_hugetlb_page must guard with page_table_lock and be
prepared to exit early.

Restyle copy_hugetlb_page_range with a for loop like the others there.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/hugetlb.c |   35 +++++++++++++++++++++--------------
 1 files changed, 21 insertions(+), 14 deletions(-)

--- 2.6.14-rc2/mm/hugetlb.c	2005-09-22 12:32:03.000000000 +0100
+++ mm01/mm/hugetlb.c	2005-09-24 19:26:24.000000000 +0100
@@ -273,21 +273,22 @@ int copy_hugetlb_page_range(struct mm_st
 {
 	pte_t *src_pte, *dst_pte, entry;
 	struct page *ptepage;
-	unsigned long addr = vma->vm_start;
-	unsigned long end = vma->vm_end;
+	unsigned long addr;
 
-	while (addr < end) {
+	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
 		dst_pte = huge_pte_alloc(dst, addr);
 		if (!dst_pte)
 			goto nomem;
+		spin_lock(&src->page_table_lock);
 		src_pte = huge_pte_offset(src, addr);
-		BUG_ON(!src_pte || pte_none(*src_pte)); /* prefaulted */
-		entry = *src_pte;
-		ptepage = pte_page(entry);
-		get_page(ptepage);
-		add_mm_counter(dst, rss, HPAGE_SIZE / PAGE_SIZE);
-		set_huge_pte_at(dst, addr, dst_pte, entry);
-		addr += HPAGE_SIZE;
+		if (src_pte && !pte_none(*src_pte)) {
+			entry = *src_pte;
+			ptepage = pte_page(entry);
+			get_page(ptepage);
+			add_mm_counter(dst, rss, HPAGE_SIZE / PAGE_SIZE);
+			set_huge_pte_at(dst, addr, dst_pte, entry);
+		}
+		spin_unlock(&src->page_table_lock);
 	}
 	return 0;
 
@@ -322,8 +323,8 @@ void unmap_hugepage_range(struct vm_area
 
 		page = pte_page(pte);
 		put_page(page);
+		add_mm_counter(mm, rss,  - (HPAGE_SIZE / PAGE_SIZE));
 	}
-	add_mm_counter(mm, rss,  -((end - start) >> PAGE_SHIFT));
 	flush_tlb_range(vma, start, end);
 }
 
@@ -402,6 +403,7 @@ int follow_hugetlb_page(struct mm_struct
 	BUG_ON(!is_vm_hugetlb_page(vma));
 
 	vpfn = vaddr/PAGE_SIZE;
+	spin_lock(&mm->page_table_lock);
 	while (vaddr < vma->vm_end && remainder) {
 
 		if (pages) {
@@ -414,8 +416,13 @@ int follow_hugetlb_page(struct mm_struct
 			 * indexing below to work. */
 			pte = huge_pte_offset(mm, vaddr & HPAGE_MASK);
 
-			/* hugetlb should be locked, and hence, prefaulted */
-			WARN_ON(!pte || pte_none(*pte));
+			/* the hugetlb file might have been truncated */
+			if (!pte || pte_none(*pte)) {
+				remainder = 0;
+				if (!i)
+					i = -EFAULT;
+				break;
+			}
 
 			page = &pte_page(*pte)[vpfn % (HPAGE_SIZE/PAGE_SIZE)];
 
@@ -433,7 +440,7 @@ int follow_hugetlb_page(struct mm_struct
 		--remainder;
 		++i;
 	}
-
+	spin_unlock(&mm->page_table_lock);
 	*length = remainder;
 	*position = vaddr;
 
