Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965128AbVHZRCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128AbVHZRCw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965124AbVHZRCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:02:40 -0400
Received: from ppp-62-11-73-212.dialup.tiscali.it ([62.11.73.212]:34709 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965128AbVHZRCW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:02:22 -0400
Subject: [patch 11/18] remap_file_pages protection support: also set VM_NONLINEAR on nonuniform VMAs
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 26 Aug 2005 18:53:42 +0200
Message-Id: <20050826165342.AA0D0254627@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

To simplify the VM code, and to reflect expected application usage, we decide
to also set VM_NONLINEAR when setting VM_NONUNIFORM. Otherwise, we'd have to
possibly save nonlinear PTEs even on paths which cope with linear VMAs. It's
possible, but intrusive (it's done in one of the next patches).

Obviously, this has a performance cost, since we potentially have to handle a
linear VMA with nonlinear handling code. But I don't know of any application
which might have this usage.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/fremap.c |   27 ++++++++++++++-------------
 1 files changed, 14 insertions(+), 13 deletions(-)

diff -puN mm/fremap.c~rfp-nonuniform-implies-nonlinear mm/fremap.c
--- linux-2.6.git/mm/fremap.c~rfp-nonuniform-implies-nonlinear	2005-08-25 12:50:00.000000000 +0200
+++ linux-2.6.git-paolo/mm/fremap.c	2005-08-25 12:50:00.000000000 +0200
@@ -246,8 +246,9 @@ retry:
 	if (!vma->vm_private_data ||
 			(vma->vm_flags & (VM_NONLINEAR|VM_RESERVED))) {
 		/* Must set VM_NONLINEAR before any pages are populated. */
-		if (pgoff != linear_page_index(vma, start) &&
-		    !(vma->vm_flags & VM_NONLINEAR)) {
+		if (!(vma->vm_flags & VM_NONLINEAR) &&
+			(pgoff != linear_page_index(vma, start) ||
+			pgprot_val(pgprot) != pgprot_val(vma->vm_page_prot))) {
 			if (!(vma->vm_flags & VM_SHARED))
 				goto out_unlock;
 			if (!has_write_lock) {
@@ -264,19 +265,19 @@ retry:
 			vma_nonlinear_insert(vma, &mapping->i_mmap_nonlinear);
 			flush_dcache_mmap_unlock(mapping);
 			spin_unlock(&mapping->i_mmap_lock);
-		}
 
-		if (pgprot_val(pgprot) != pgprot_val(vma->vm_page_prot) &&
-				!(vma->vm_flags & VM_NONUNIFORM)) {
-			if (!(vma->vm_flags & VM_SHARED))
-				goto out_unlock;
-			if (!has_write_lock) {
-				up_read(&mm->mmap_sem);
-				down_write(&mm->mmap_sem);
-				has_write_lock = 1;
-				goto retry;
+			if (!(vma->vm_flags & VM_NONUNIFORM) &&
+				pgprot_val(pgprot) != pgprot_val(vma->vm_page_prot)) {
+				if (!(vma->vm_flags & VM_SHARED))
+					goto out_unlock;
+				if (!has_write_lock) {
+					up_read(&mm->mmap_sem);
+					down_write(&mm->mmap_sem);
+					has_write_lock = 1;
+					goto retry;
+				}
+				vma->vm_flags |= VM_NONUNIFORM;
 			}
-			vma->vm_flags |= VM_NONUNIFORM;
 		}
 
 		/* Do NOT hold the write lock while doing any I/O, nor when
_
