Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266297AbSKLIZ4>; Tue, 12 Nov 2002 03:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266298AbSKLIZJ>; Tue, 12 Nov 2002 03:25:09 -0500
Received: from holomorphy.com ([66.224.33.161]:40633 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266314AbSKLIYf>;
	Tue, 12 Nov 2002 03:24:35 -0500
To: linux-kernel@vger.kernel.org
Subject: [1/11] hugetlb: revert doublefreeing patch
Message-Id: <E18BWPl-0005K6-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 12 Nov 2002 00:28:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This change introduced doublefree races on both inodes and hugepages.

 hugetlbpage.c |   33 ---------------------------------
 1 files changed, 33 deletions(-)


diff -urpN numaq-2.5.47/arch/i386/mm/hugetlbpage.c htlb-2.5.47-1/arch/i386/mm/hugetlbpage.c
--- numaq-2.5.47/arch/i386/mm/hugetlbpage.c	2002-11-10 19:28:30.000000000 -0800
+++ htlb-2.5.47-1/arch/i386/mm/hugetlbpage.c	2002-11-11 19:44:26.000000000 -0800
@@ -236,55 +236,22 @@ void huge_page_release(struct page *page
 	free_huge_page(page);
 }
 
-static void
-free_rsrc(struct inode * inode)
-{
-	int i;
-	spin_lock(&htlbpage_lock);
-	for (i=0;i<MAX_ID;i++) 
-		if (htlbpagek[i].key == inode->i_ino) {
-			htlbpagek[i].key = 0;
-			htlbpagek[i].in = NULL;
-			break;
-		}
-	spin_unlock(&htlbpage_lock);
-	kfree(inode);
-}
-
 void unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start, unsigned long end)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
 	pte_t *pte;
 	struct page *page;
-	int free_more = 0;
-	struct inode *inode = NULL;
 
 	BUG_ON(start & (HPAGE_SIZE - 1));
 	BUG_ON(end & (HPAGE_SIZE - 1));
 
-	if (start < end) {
-		pte = huge_pte_offset(mm, start);
-		page = pte_page(*pte);
-		if ((page->mapping != NULL) && (page_count(page) == 2) &&
-			((inode=page->mapping->host)->i_mapping->a_ops == NULL)) 
-			free_more = 1;
-	}
 	for (address = start; address < end; address += HPAGE_SIZE) {
 		pte = huge_pte_offset(mm, address);
 		page = pte_page(*pte);
-		if (free_more) {
-			ClearPageDirty(page);
-			SetPageLocked(page);
-			remove_from_page_cache(page);
-			ClearPageLocked(page);
-			set_page_count(page, 1);
-		}
 		huge_page_release(page);
 		pte_clear(pte);
 	}
-	if (free_more)
-		free_rsrc(inode);
 	mm->rss -= (end - start) >> PAGE_SHIFT;
 	flush_tlb_range(vma, start, end);
 }
