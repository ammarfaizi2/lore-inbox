Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbVIYPxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbVIYPxi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 11:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbVIYPxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 11:53:38 -0400
Received: from gold.veritas.com ([143.127.12.110]:31659 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932231AbVIYPxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 11:53:37 -0400
Date: Sun, 25 Sep 2005 16:53:11 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 07/21] mm: remove_vma_list consolidation
In-Reply-To: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0509251652280.3490@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 25 Sep 2005 15:53:37.0212 (UTC) FILETIME=[4A8B6FC0:01C5C1E9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

unmap_vma doesn't amount to much, let's put it inside unmap_vma_list.
Except it doesn't unmap anything, unmap_region just did the unmapping:
rename it to remove_vma_list.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/mmap.c |   36 ++++++++++++------------------------
 1 files changed, 12 insertions(+), 24 deletions(-)

--- mm06/mm/mmap.c	2005-09-24 19:27:33.000000000 +0100
+++ mm07/mm/mmap.c	2005-09-24 19:27:47.000000000 +0100
@@ -1599,35 +1599,23 @@ find_extend_vma(struct mm_struct * mm, u
 }
 #endif
 
-/* Normal function to fix up a mapping
- * This function is the default for when an area has no specific
- * function.  This may be used as part of a more specific routine.
- *
- * By the time this function is called, the area struct has been
- * removed from the process mapping list.
- */
-static void unmap_vma(struct mm_struct *mm, struct vm_area_struct *vma)
-{
-	long nrpages = vma_pages(vma);
-
-	mm->total_vm -= nrpages;
-	if (vma->vm_flags & VM_LOCKED)
-		mm->locked_vm -= nrpages;
-	vm_stat_account(mm, vma->vm_flags, vma->vm_file, -nrpages);
-	remove_vm_struct(vma);
-}
-
 /*
- * Update the VMA and inode share lists.
- *
- * Ok - we have the memory areas we should free on the 'free' list,
+ * Ok - we have the memory areas we should free on the vma list,
  * so release them, and do the vma updates.
+ *
+ * Called with the mm semaphore held.
  */
-static void unmap_vma_list(struct mm_struct *mm, struct vm_area_struct *vma)
+static void remove_vma_list(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	do {
 		struct vm_area_struct *next = vma->vm_next;
-		unmap_vma(mm, vma);
+		long nrpages = vma_pages(vma);
+
+		mm->total_vm -= nrpages;
+		if (vma->vm_flags & VM_LOCKED)
+			mm->locked_vm -= nrpages;
+		vm_stat_account(mm, vma->vm_flags, vma->vm_file, -nrpages);
+		remove_vm_struct(vma);
 		vma = next;
 	} while (vma);
 	validate_mm(mm);
@@ -1795,7 +1783,7 @@ int do_munmap(struct mm_struct *mm, unsi
 	unmap_region(mm, vma, prev, start, end);
 
 	/* Fix up all other VM information */
-	unmap_vma_list(mm, vma);
+	remove_vma_list(mm, vma);
 
 	return 0;
 }
