Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751525AbVIYPtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbVIYPtb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 11:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbVIYPtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 11:49:31 -0400
Received: from silver.veritas.com ([143.127.12.111]:21430 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751523AbVIYPta
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 11:49:30 -0400
Date: Sun, 25 Sep 2005 16:49:04 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 03/21] mm: msync_pte_range progress
In-Reply-To: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0509251648240.3490@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 25 Sep 2005 15:49:30.0337 (UTC) FILETIME=[B7654D10:01C5C1E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use latency breaking in msync_pte_range like that in copy_pte_range,
instead of the ugly CONFIG_PREEMPT filemap_msync alternatives.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/msync.c |   38 ++++++++++++++------------------------
 1 files changed, 14 insertions(+), 24 deletions(-)

--- mm02/mm/msync.c	2005-09-24 16:59:50.000000000 +0100
+++ mm03/mm/msync.c	2005-09-24 19:26:52.000000000 +0100
@@ -26,12 +26,21 @@ static void msync_pte_range(struct vm_ar
 				unsigned long addr, unsigned long end)
 {
 	pte_t *pte;
+	int progress = 0;
 
+again:
 	pte = pte_offset_map(pmd, addr);
 	do {
 		unsigned long pfn;
 		struct page *page;
 
+		if (progress >= 64) {
+			progress = 0;
+			if (need_resched() ||
+			    need_lockbreak(&vma->vm_mm->page_table_lock))
+				break;
+		}
+		progress++;
 		if (!pte_present(*pte))
 			continue;
 		if (!pte_maybe_dirty(*pte))
@@ -46,8 +55,12 @@ static void msync_pte_range(struct vm_ar
 		if (ptep_clear_flush_dirty(vma, addr, pte) ||
 		    page_test_and_clear_dirty(page))
 			set_page_dirty(page);
+		progress += 3;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	pte_unmap(pte - 1);
+	cond_resched_lock(&vma->vm_mm->page_table_lock);
+	if (addr != end)
+		goto again;
 }
 
 static inline void msync_pmd_range(struct vm_area_struct *vma, pud_t *pud,
@@ -106,29 +119,6 @@ static void msync_page_range(struct vm_a
 	spin_unlock(&mm->page_table_lock);
 }
 
-#ifdef CONFIG_PREEMPT
-static inline void filemap_msync(struct vm_area_struct *vma,
-				 unsigned long addr, unsigned long end)
-{
-	const size_t chunk = 64 * 1024;	/* bytes */
-	unsigned long next;
-
-	do {
-		next = addr + chunk;
-		if (next > end || next < addr)
-			next = end;
-		msync_page_range(vma, addr, next);
-		cond_resched();
-	} while (addr = next, addr != end);
-}
-#else
-static inline void filemap_msync(struct vm_area_struct *vma,
-				 unsigned long addr, unsigned long end)
-{
-	msync_page_range(vma, addr, end);
-}
-#endif
-
 /*
  * MS_SYNC syncs the entire file - including mappings.
  *
@@ -150,7 +140,7 @@ static int msync_interval(struct vm_area
 		return -EBUSY;
 
 	if (file && (vma->vm_flags & VM_SHARED)) {
-		filemap_msync(vma, addr, end);
+		msync_page_range(vma, addr, end);
 
 		if (flags & MS_SYNC) {
 			struct address_space *mapping = file->f_mapping;
