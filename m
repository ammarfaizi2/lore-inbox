Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVCWRY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVCWRY3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 12:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262741AbVCWRVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 12:21:55 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:50270 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261966AbVCWRQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 12:16:26 -0500
Date: Wed, 23 Mar 2005 17:15:19 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: akpm@osdl.org, davem@davemloft.net, tony.luck@intel.com,
       benh@kernel.crashing.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] freepgt: mpnt to vma cleanup
In-Reply-To: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0503231714360.15274@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While dabbling here in mmap.c, clean up mysterious "mpnt"s to "vma"s.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/mmap.c |   35 +++++++++++++++++------------------
 1 files changed, 17 insertions(+), 18 deletions(-)

--- freepgt4/mm/mmap.c	2005-03-21 19:06:48.000000000 +0000
+++ freepgt5/mm/mmap.c	2005-03-21 19:07:25.000000000 +0000
@@ -1602,14 +1602,13 @@ static void unmap_vma(struct mm_struct *
  * Ok - we have the memory areas we should free on the 'free' list,
  * so release them, and do the vma updates.
  */
-static void unmap_vma_list(struct mm_struct *mm,
-	struct vm_area_struct *mpnt)
+static void unmap_vma_list(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	do {
-		struct vm_area_struct *next = mpnt->vm_next;
-		unmap_vma(mm, mpnt);
-		mpnt = next;
-	} while (mpnt != NULL);
+		struct vm_area_struct *next = vma->vm_next;
+		unmap_vma(mm, vma);
+		vma = next;
+	} while (vma);
 	validate_mm(mm);
 }
 
@@ -1720,7 +1719,7 @@ int split_vma(struct mm_struct * mm, str
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len)
 {
 	unsigned long end;
-	struct vm_area_struct *mpnt, *prev, *last;
+	struct vm_area_struct *vma, *prev, *last;
 
 	if ((start & ~PAGE_MASK) || start > TASK_SIZE || len > TASK_SIZE-start)
 		return -EINVAL;
@@ -1729,14 +1728,14 @@ int do_munmap(struct mm_struct *mm, unsi
 		return -EINVAL;
 
 	/* Find the first overlapping VMA */
-	mpnt = find_vma_prev(mm, start, &prev);
-	if (!mpnt)
+	vma = find_vma_prev(mm, start, &prev);
+	if (!vma)
 		return 0;
-	/* we have  start < mpnt->vm_end  */
+	/* we have  start < vma->vm_end  */
 
 	/* if it doesn't overlap, we have nothing.. */
 	end = start + len;
-	if (mpnt->vm_start >= end)
+	if (vma->vm_start >= end)
 		return 0;
 
 	/*
@@ -1746,11 +1745,11 @@ int do_munmap(struct mm_struct *mm, unsi
 	 * unmapped vm_area_struct will remain in use: so lower split_vma
 	 * places tmp vma above, and higher split_vma places tmp vma below.
 	 */
-	if (start > mpnt->vm_start) {
-		int error = split_vma(mm, mpnt, start, 0);
+	if (start > vma->vm_start) {
+		int error = split_vma(mm, vma, start, 0);
 		if (error)
 			return error;
-		prev = mpnt;
+		prev = vma;
 	}
 
 	/* Does it split the last one? */
@@ -1760,16 +1759,16 @@ int do_munmap(struct mm_struct *mm, unsi
 		if (error)
 			return error;
 	}
-	mpnt = prev? prev->vm_next: mm->mmap;
+	vma = prev? prev->vm_next: mm->mmap;
 
 	/*
 	 * Remove the vma's, and unmap the actual pages
 	 */
-	detach_vmas_to_be_unmapped(mm, mpnt, prev, end);
-	unmap_region(mm, mpnt, prev, start, end);
+	detach_vmas_to_be_unmapped(mm, vma, prev, end);
+	unmap_region(mm, vma, prev, start, end);
 
 	/* Fix up all other VM information */
-	unmap_vma_list(mm, mpnt);
+	unmap_vma_list(mm, vma);
 
 	return 0;
 }
