Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbVHLR7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbVHLR7s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 13:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbVHLRyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 13:54:45 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:34194 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S1750794AbVHLRye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:54:34 -0400
Subject: [patch 14/39] remap_file_pages protection support: assume VM_SHARED never disappears
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 19:32:05 +0200
Message-Id: <20050812173205.6D8DD24E7E1@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Assume that even after dropping and reacquiring the lock, (vma->vm_flags &
VM_SHARED) won't change, thus moving a check earlier.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/fremap.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff -puN mm/fremap.c~rfp-assume-VM_PRIVATE-stays mm/fremap.c
--- linux-2.6.git/mm/fremap.c~rfp-assume-VM_PRIVATE-stays	2005-08-11 12:58:07.000000000 +0200
+++ linux-2.6.git-paolo/mm/fremap.c	2005-08-11 13:38:56.000000000 +0200
@@ -232,6 +232,8 @@ retry:
 
 		/* Must set VM_NONLINEAR before any pages are populated. */
 		if (pgoff != linear_page_index(vma, start)) {
+			if (!(vma->vm_flags & VM_SHARED))
+				goto out_unlock;
 			if (!(vma->vm_flags & VM_NONLINEAR)) {
 				if (!has_write_lock) {
 					up_read(&mm->mmap_sem);
@@ -239,12 +241,6 @@ retry:
 					has_write_lock = 1;
 					goto retry;
 				}
-				/* XXX: we check VM_SHARED after re-getting the
-				 * (write) semaphore but I guess that we could
-				 * check it earlier as we're not allowed to turn
-				 * a VM_PRIVATE vma into a VM_SHARED one! */
-				if (!(vma->vm_flags & VM_SHARED))
-					goto out_unlock;
 
 				mapping = vma->vm_file->f_mapping;
 				spin_lock(&mapping->i_mmap_lock);
@@ -254,10 +250,6 @@ retry:
 				vma_nonlinear_insert(vma, &mapping->i_mmap_nonlinear);
 				flush_dcache_mmap_unlock(mapping);
 				spin_unlock(&mapping->i_mmap_lock);
-			} else {
-				/* Won't drop the lock, check it here.*/
-				if (!(vma->vm_flags & VM_SHARED))
-					goto out_unlock;
 			}
 		}
 
_
