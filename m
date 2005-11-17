Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbVKQTin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbVKQTin (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 14:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbVKQTin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 14:38:43 -0500
Received: from silver.veritas.com ([143.127.12.111]:38177 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S964813AbVKQTim
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 14:38:42 -0500
Date: Thu, 17 Nov 2005 19:37:23 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] unpaged: COW on VM_UNPAGED
In-Reply-To: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511171936440.4563@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 17 Nov 2005 19:38:41.0852 (UTC) FILETIME=[83D4B7C0:01C5EBAE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the BUG_ON(vma->vm_flags & VM_UNPAGED) from do_wp_page, and let
it do Copy-On-Write without touching the VM_UNPAGED's page counts - but
this is incomplete, because the anonymous page it inserts will itself
need to be handled, here and in other functions - next patch.

We still don't copy the page if the pfn is invalid, because the
copy_user_highpage interface does not allow it.  But that's not been
a problem in the past: can be added in later if the need arises.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/memory.c |   37 +++++++++++++++++++++++++------------
 1 files changed, 25 insertions(+), 12 deletions(-)

--- unpaged06/mm/memory.c	2005-11-17 15:11:02.000000000 +0000
+++ unpaged07/mm/memory.c	2005-11-17 15:11:30.000000000 +0000
@@ -1277,22 +1277,28 @@ static int do_wp_page(struct mm_struct *
 		unsigned long address, pte_t *page_table, pmd_t *pmd,
 		spinlock_t *ptl, pte_t orig_pte)
 {
-	struct page *old_page, *new_page;
+	struct page *old_page, *src_page, *new_page;
 	unsigned long pfn = pte_pfn(orig_pte);
 	pte_t entry;
 	int ret = VM_FAULT_MINOR;
 
-	BUG_ON(vma->vm_flags & VM_UNPAGED);
-
 	if (unlikely(!pfn_valid(pfn))) {
 		/*
 		 * Page table corrupted: show pte and kill process.
+		 * Or it's an attempt to COW an out-of-map VM_UNPAGED
+		 * entry, which copy_user_highpage does not support.
 		 */
 		print_bad_pte(vma, orig_pte, address);
 		ret = VM_FAULT_OOM;
 		goto unlock;
 	}
 	old_page = pfn_to_page(pfn);
+	src_page = old_page;
+
+	if (unlikely(vma->vm_flags & VM_UNPAGED)) {
+		old_page = NULL;
+		goto gotten;
+	}
 
 	if (PageAnon(old_page) && !TestSetPageLocked(old_page)) {
 		int reuse = can_share_swap_page(old_page);
@@ -1313,11 +1319,12 @@ static int do_wp_page(struct mm_struct *
 	 * Ok, we need to copy. Oh, well..
 	 */
 	page_cache_get(old_page);
+gotten:
 	pte_unmap_unlock(page_table, ptl);
 
 	if (unlikely(anon_vma_prepare(vma)))
 		goto oom;
-	if (old_page == ZERO_PAGE(address)) {
+	if (src_page == ZERO_PAGE(address)) {
 		new_page = alloc_zeroed_user_highpage(vma, address);
 		if (!new_page)
 			goto oom;
@@ -1325,7 +1332,7 @@ static int do_wp_page(struct mm_struct *
 		new_page = alloc_page_vma(GFP_HIGHUSER, vma, address);
 		if (!new_page)
 			goto oom;
-		copy_user_highpage(new_page, old_page, address);
+		copy_user_highpage(new_page, src_page, address);
 	}
 
 	/*
@@ -1333,11 +1340,14 @@ static int do_wp_page(struct mm_struct *
 	 */
 	page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
 	if (likely(pte_same(*page_table, orig_pte))) {
-		page_remove_rmap(old_page);
-		if (!PageAnon(old_page)) {
+		if (old_page) {
+			page_remove_rmap(old_page);
+			if (!PageAnon(old_page)) {
+				dec_mm_counter(mm, file_rss);
+				inc_mm_counter(mm, anon_rss);
+			}
+		} else
 			inc_mm_counter(mm, anon_rss);
-			dec_mm_counter(mm, file_rss);
-		}
 		flush_cache_page(vma, address, pfn);
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
@@ -1351,13 +1361,16 @@ static int do_wp_page(struct mm_struct *
 		new_page = old_page;
 		ret |= VM_FAULT_WRITE;
 	}
-	page_cache_release(new_page);
-	page_cache_release(old_page);
+	if (new_page)
+		page_cache_release(new_page);
+	if (old_page)
+		page_cache_release(old_page);
 unlock:
 	pte_unmap_unlock(page_table, ptl);
 	return ret;
 oom:
-	page_cache_release(old_page);
+	if (old_page)
+		page_cache_release(old_page);
 	return VM_FAULT_OOM;
 }
 
