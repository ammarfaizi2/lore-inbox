Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbVKQTh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbVKQTh7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 14:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbVKQTh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 14:37:59 -0500
Received: from silver.veritas.com ([143.127.12.111]:29217 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S964819AbVKQTh6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 14:37:58 -0500
Date: Thu, 17 Nov 2005 19:36:40 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] unpaged: VM_NONLINEAR VM_RESERVED
In-Reply-To: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511171935030.4563@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 17 Nov 2005 19:37:58.0383 (UTC) FILETIME=[69EBDFF0:01C5EBAE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's one peculiar use of VM_RESERVED which the previous patch left
behind: because VM_NONLINEAR's try_to_unmap_cluster uses vm_private_data
as a swapout cursor, but should never meet VM_RESERVED vmas, it was a
way of extending VM_NONLINEAR to VM_RESERVED vmas using vm_private_data
for some other purpose.  But that's an empty set - they don't have the
populate function required.  So just throw away those VM_RESERVED tests.

But one more interesting in rmap.c has to go too: try_to_unmap_one will
want to swap out an anonymous page from VM_RESERVED or VM_UNPAGED area.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/fremap.c |    6 ++----
 mm/rmap.c   |   15 +++++----------
 2 files changed, 7 insertions(+), 14 deletions(-)

--- unpaged05/mm/fremap.c	2005-11-17 15:11:02.000000000 +0000
+++ unpaged06/mm/fremap.c	2005-11-17 15:11:16.000000000 +0000
@@ -204,12 +204,10 @@ asmlinkage long sys_remap_file_pages(uns
 	 * Make sure the vma is shared, that it supports prefaulting,
 	 * and that the remapped range is valid and fully within
 	 * the single existing vma.  vm_private_data is used as a
-	 * swapout cursor in a VM_NONLINEAR vma (unless VM_RESERVED
-	 * or VM_LOCKED, but VM_LOCKED could be revoked later on).
+	 * swapout cursor in a VM_NONLINEAR vma.
 	 */
 	if (vma && (vma->vm_flags & VM_SHARED) &&
-		(!vma->vm_private_data ||
-			(vma->vm_flags & (VM_NONLINEAR|VM_RESERVED))) &&
+		(!vma->vm_private_data || (vma->vm_flags & VM_NONLINEAR)) &&
 		vma->vm_ops && vma->vm_ops->populate &&
 			end > start && start >= vma->vm_start &&
 				end <= vma->vm_end) {
--- unpaged05/mm/rmap.c	2005-11-12 09:01:25.000000000 +0000
+++ unpaged06/mm/rmap.c	2005-11-17 15:11:16.000000000 +0000
@@ -529,10 +529,8 @@ static int try_to_unmap_one(struct page 
 	 * If the page is mlock()d, we cannot swap it out.
 	 * If it's recently referenced (perhaps page_referenced
 	 * skipped over this mm) then we should reactivate it.
-	 *
-	 * Pages belonging to VM_RESERVED regions should not happen here.
 	 */
-	if ((vma->vm_flags & (VM_LOCKED|VM_RESERVED)) ||
+	if ((vma->vm_flags & VM_LOCKED) ||
 			ptep_clear_flush_young(vma, address, pte)) {
 		ret = SWAP_FAIL;
 		goto out_unmap;
@@ -727,7 +725,7 @@ static int try_to_unmap_file(struct page
 
 	list_for_each_entry(vma, &mapping->i_mmap_nonlinear,
 						shared.vm_set.list) {
-		if (vma->vm_flags & (VM_LOCKED|VM_RESERVED))
+		if (vma->vm_flags & VM_LOCKED)
 			continue;
 		cursor = (unsigned long) vma->vm_private_data;
 		if (cursor > max_nl_cursor)
@@ -761,7 +759,7 @@ static int try_to_unmap_file(struct page
 	do {
 		list_for_each_entry(vma, &mapping->i_mmap_nonlinear,
 						shared.vm_set.list) {
-			if (vma->vm_flags & (VM_LOCKED|VM_RESERVED))
+			if (vma->vm_flags & VM_LOCKED)
 				continue;
 			cursor = (unsigned long) vma->vm_private_data;
 			while ( cursor < max_nl_cursor &&
@@ -783,11 +781,8 @@ static int try_to_unmap_file(struct page
 	 * in locked vmas).  Reset cursor on all unreserved nonlinear
 	 * vmas, now forgetting on which ones it had fallen behind.
 	 */
-	list_for_each_entry(vma, &mapping->i_mmap_nonlinear,
-						shared.vm_set.list) {
-		if (!(vma->vm_flags & VM_RESERVED))
-			vma->vm_private_data = NULL;
-	}
+	list_for_each_entry(vma, &mapping->i_mmap_nonlinear, shared.vm_set.list)
+		vma->vm_private_data = NULL;
 out:
 	spin_unlock(&mapping->i_mmap_lock);
 	return ret;
