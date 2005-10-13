Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbVJMAsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbVJMAsf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 20:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbVJMAse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 20:48:34 -0400
Received: from gold.veritas.com ([143.127.12.110]:59409 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932384AbVJMAsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 20:48:33 -0400
Date: Thu, 13 Oct 2005 01:47:49 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 04/21] mm: do_mremap current mm
In-Reply-To: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0510130147080.4060@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Oct 2005 00:48:33.0667 (UTC) FILETIME=[D68B8D30:01C5CF8F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup: relieve do_mremap from its surfeit of current->mms.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/mremap.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

--- mm03/mm/mremap.c	2005-09-30 11:59:12.000000000 +0100
+++ mm04/mm/mremap.c	2005-10-11 23:53:55.000000000 +0100
@@ -245,6 +245,7 @@ unsigned long do_mremap(unsigned long ad
 	unsigned long old_len, unsigned long new_len,
 	unsigned long flags, unsigned long new_addr)
 {
+	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	unsigned long ret = -EINVAL;
 	unsigned long charged = 0;
@@ -285,7 +286,7 @@ unsigned long do_mremap(unsigned long ad
 		if ((addr <= new_addr) && (addr+old_len) > new_addr)
 			goto out;
 
-		ret = do_munmap(current->mm, new_addr, new_len);
+		ret = do_munmap(mm, new_addr, new_len);
 		if (ret)
 			goto out;
 	}
@@ -296,7 +297,7 @@ unsigned long do_mremap(unsigned long ad
 	 * do_munmap does all the needed commit accounting
 	 */
 	if (old_len >= new_len) {
-		ret = do_munmap(current->mm, addr+new_len, old_len - new_len);
+		ret = do_munmap(mm, addr+new_len, old_len - new_len);
 		if (ret && old_len != new_len)
 			goto out;
 		ret = addr;
@@ -309,7 +310,7 @@ unsigned long do_mremap(unsigned long ad
 	 * Ok, we need to grow..  or relocate.
 	 */
 	ret = -EFAULT;
-	vma = find_vma(current->mm, addr);
+	vma = find_vma(mm, addr);
 	if (!vma || vma->vm_start > addr)
 		goto out;
 	if (is_vm_hugetlb_page(vma)) {
@@ -325,14 +326,14 @@ unsigned long do_mremap(unsigned long ad
 	}
 	if (vma->vm_flags & VM_LOCKED) {
 		unsigned long locked, lock_limit;
-		locked = current->mm->locked_vm << PAGE_SHIFT;
+		locked = mm->locked_vm << PAGE_SHIFT;
 		lock_limit = current->signal->rlim[RLIMIT_MEMLOCK].rlim_cur;
 		locked += new_len - old_len;
 		ret = -EAGAIN;
 		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
 			goto out;
 	}
-	if (!may_expand_vm(current->mm, (new_len - old_len) >> PAGE_SHIFT)) {
+	if (!may_expand_vm(mm, (new_len - old_len) >> PAGE_SHIFT)) {
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -359,11 +360,10 @@ unsigned long do_mremap(unsigned long ad
 			vma_adjust(vma, vma->vm_start,
 				addr + new_len, vma->vm_pgoff, NULL);
 
-			current->mm->total_vm += pages;
-			vm_stat_account(vma->vm_mm, vma->vm_flags,
-							vma->vm_file, pages);
+			mm->total_vm += pages;
+			vm_stat_account(mm, vma->vm_flags, vma->vm_file, pages);
 			if (vma->vm_flags & VM_LOCKED) {
-				current->mm->locked_vm += pages;
+				mm->locked_vm += pages;
 				make_pages_present(addr + old_len,
 						   addr + new_len);
 			}
