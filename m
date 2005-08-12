Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbVHLSPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbVHLSPt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVHLSPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:15:48 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:58061 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S1750808AbVHLSPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:15:20 -0400
Subject: [patch 13/39] remap_file_pages protection support: support private vma for MAP_POPULATE
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       mingo@elte.hu
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 20:21:30 +0200
Message-Id: <20050812182130.5BAE824E7E2@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Ingo Molnar <mingo@elte.hu>

If we're not rearranging pages, support even PRIVATE vma.

This is needed to make MAP_POPULATE|MAP_PRIVATE to work, since it calls
remap_file_pages.

Notes from: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

We don't support private VMA because when they're swapped out we need to store
the swap entry in the PTE, not the file offset and protections; so, I suppose
that with remap-file-pages-prot, we must punt on private VMA even when we're
just changing protections. This change is in a separate patch.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/fremap.c |   55 ++++++++++++++++++++++++----------------
 linux-2.6.git-paolo/mm/mmap.c   |    4 ++
 2 files changed, 38 insertions(+), 21 deletions(-)

diff -puN mm/fremap.c~rfp-private-vma mm/fremap.c
--- linux-2.6.git/mm/fremap.c~rfp-private-vma	2005-08-11 23:02:45.000000000 +0200
+++ linux-2.6.git-paolo/mm/fremap.c	2005-08-11 23:02:45.000000000 +0200
@@ -218,34 +218,47 @@ retry:
 			goto out_unlock;
 		if (((prot & PROT_EXEC) && !(vma->vm_flags & VM_MAYEXEC)))
 			goto out_unlock;
+		err = -EINVAL;
 		pgprot = protection_map[calc_vm_prot_bits(prot) | VM_SHARED];
 	} else 
 		pgprot = vma->vm_page_prot;
 
-	if ((vma->vm_flags & VM_SHARED) &&
-		(!vma->vm_private_data ||
-			(vma->vm_flags & (VM_NONLINEAR|VM_RESERVED))) &&
-		vma->vm_ops && vma->vm_ops->populate &&
-			end > start && start >= vma->vm_start &&
-				end <= vma->vm_end) {
+	if (!vma->vm_ops || !vma->vm_ops->populate || end <= start || start <
+			vma->vm_start || end > vma->vm_end)
+		goto out_unlock;
+
+	if (!vma->vm_private_data ||
+			(vma->vm_flags & (VM_NONLINEAR|VM_RESERVED))) {
 
 		/* Must set VM_NONLINEAR before any pages are populated. */
-		if (pgoff != linear_page_index(vma, start) &&
-		    !(vma->vm_flags & VM_NONLINEAR)) {
-			if (!has_write_lock) {
-				up_read(&mm->mmap_sem);
-				down_write(&mm->mmap_sem);
-				has_write_lock = 1;
-				goto retry;
+		if (pgoff != linear_page_index(vma, start)) {
+			if (!(vma->vm_flags & VM_NONLINEAR)) {
+				if (!has_write_lock) {
+					up_read(&mm->mmap_sem);
+					down_write(&mm->mmap_sem);
+					has_write_lock = 1;
+					goto retry;
+				}
+				/* XXX: we check VM_SHARED after re-getting the
+				 * (write) semaphore but I guess that we could
+				 * check it earlier as we're not allowed to turn
+				 * a VM_PRIVATE vma into a VM_SHARED one! */
+				if (!(vma->vm_flags & VM_SHARED))
+					goto out_unlock;
+
+				mapping = vma->vm_file->f_mapping;
+				spin_lock(&mapping->i_mmap_lock);
+				flush_dcache_mmap_lock(mapping);
+				vma->vm_flags |= VM_NONLINEAR;
+				vma_prio_tree_remove(vma, &mapping->i_mmap);
+				vma_nonlinear_insert(vma, &mapping->i_mmap_nonlinear);
+				flush_dcache_mmap_unlock(mapping);
+				spin_unlock(&mapping->i_mmap_lock);
+			} else {
+				/* Won't drop the lock, check it here.*/
+				if (!(vma->vm_flags & VM_SHARED))
+					goto out_unlock;
 			}
-			mapping = vma->vm_file->f_mapping;
-			spin_lock(&mapping->i_mmap_lock);
-			flush_dcache_mmap_lock(mapping);
-			vma->vm_flags |= VM_NONLINEAR;
-			vma_prio_tree_remove(vma, &mapping->i_mmap);
-			vma_nonlinear_insert(vma, &mapping->i_mmap_nonlinear);
-			flush_dcache_mmap_unlock(mapping);
-			spin_unlock(&mapping->i_mmap_lock);
 		}
 
 		err = vma->vm_ops->populate(vma, start, size, pgprot, pgoff,
diff -puN mm/mmap.c~rfp-private-vma mm/mmap.c
--- linux-2.6.git/mm/mmap.c~rfp-private-vma	2005-08-11 23:02:45.000000000 +0200
+++ linux-2.6.git-paolo/mm/mmap.c	2005-08-11 23:02:45.000000000 +0200
@@ -1120,6 +1120,10 @@ out:	
 	}
 	if (flags & MAP_POPULATE) {
 		up_write(&mm->mmap_sem);
+		/*
+		 * remap_file_pages() works even if the mapping is private,
+		 * in the linearly-mapped case:
+		 */
 		sys_remap_file_pages(addr, len, 0,
 					pgoff, flags & MAP_NONBLOCK);
 		down_write(&mm->mmap_sem);
_
