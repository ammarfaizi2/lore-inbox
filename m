Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965115AbVHZRBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965115AbVHZRBi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbVHZRBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:01:38 -0400
Received: from ppp-62-11-73-212.dialup.tiscali.it ([62.11.73.212]:25749 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965115AbVHZRBh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:01:37 -0400
Subject: [patch 04/18] remap_file_pages protection support: cleanup syscall checks
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 26 Aug 2005 18:53:09 +0200
Message-Id: <20050826165310.04BE92232B4@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

This patch reorganizes the code only, without differences in behaviour. It
makes the code more readable on its own, and is needed for next patches. I've
split this out to avoid cluttering real patches.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/fremap.c |   38 ++++++++++++++++++++++++--------------
 1 files changed, 24 insertions(+), 14 deletions(-)

diff -puN mm/fremap.c~rfp-cleanup-sc-check mm/fremap.c
--- linux-2.6.git/mm/fremap.c~rfp-cleanup-sc-check	2005-08-24 10:45:48.000000000 +0200
+++ linux-2.6.git-paolo/mm/fremap.c	2005-08-24 11:21:13.000000000 +0200
@@ -178,7 +178,7 @@ err_unlock:
  * future.
  */
 asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
-	unsigned long __prot, unsigned long pgoff, unsigned long flags)
+	unsigned long prot, unsigned long pgoff, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
 	struct address_space *mapping;
@@ -186,9 +186,10 @@ asmlinkage long sys_remap_file_pages(uns
 	struct vm_area_struct *vma;
 	int err = -EINVAL;
 	int has_write_lock = 0;
+	pgprot_t pgprot;
 
-	if (__prot)
-		return err;
+	if (prot)
+		goto out;
 	/*
 	 * Sanitize the syscall parameters:
 	 */
@@ -197,7 +198,7 @@ asmlinkage long sys_remap_file_pages(uns
 
 	/* Does the address range wrap, or is the span zero-sized? */
 	if (start + size <= start)
-		return err;
+		goto out;
 
 	/* Can we represent this offset inside this architecture's pte's? */
 #if PTE_FILE_MAX_BITS < BITS_PER_LONG
@@ -207,7 +208,7 @@ asmlinkage long sys_remap_file_pages(uns
 
 	/* We need down_write() to change vma->vm_flags. */
 	down_read(&mm->mmap_sem);
- retry:
+retry:
 	vma = find_vma(mm, start);
 
 	/*
@@ -217,13 +218,20 @@ asmlinkage long sys_remap_file_pages(uns
 	 * swapout cursor in a VM_NONLINEAR vma (unless VM_RESERVED
 	 * or VM_LOCKED, but VM_LOCKED could be revoked later on).
 	 */
-	if (vma && (vma->vm_flags & VM_SHARED) &&
-		(!vma->vm_private_data ||
-			(vma->vm_flags & (VM_NONLINEAR|VM_RESERVED))) &&
-		vma->vm_ops && vma->vm_ops->populate &&
-			end > start && start >= vma->vm_start &&
-				end <= vma->vm_end) {
+	if (!vma)
+		goto out_unlock;
+
+	if (!(vma->vm_flags & VM_SHARED))
+		goto out_unlock;
 
+	if (!vma->vm_ops || !vma->vm_ops->populate || end <= start || start <
+			vma->vm_start || end > vma->vm_end)
+		goto out_unlock;
+
+	pgprot = vma->vm_page_prot;
+
+	if (!vma->vm_private_data ||
+			(vma->vm_flags & (VM_NONLINEAR|VM_RESERVED))) {
 		/* Must set VM_NONLINEAR before any pages are populated. */
 		if (pgoff != linear_page_index(vma, start) &&
 		    !(vma->vm_flags & VM_NONLINEAR)) {
@@ -249,16 +257,18 @@ asmlinkage long sys_remap_file_pages(uns
 			downgrade_write(&mm->mmap_sem);
 			has_write_lock = 0;
 		}
-		err = vma->vm_ops->populate(vma, start, size,
-					    vma->vm_page_prot,
-					    pgoff, flags & MAP_NONBLOCK);
+		err = vma->vm_ops->populate(vma, start, size, pgprot, pgoff,
+				flags & MAP_NONBLOCK);
 
 	}
+
+out_unlock:
 	if (likely(!has_write_lock))
 		up_read(&mm->mmap_sem);
 	else
 		up_write(&mm->mmap_sem);
 
+out:
 	return err;
 }
 
_
