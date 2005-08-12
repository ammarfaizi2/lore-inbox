Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbVHLSTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbVHLSTo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbVHLSPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:15:44 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:8326 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S1750829AbVHLSPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:15:24 -0400
Subject: [patch 14/39] remap_file_pages protection support: assume VM_SHARED never disappears
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 20:21:32 +0200
Message-Id: <20050812182132.E0D7024E7E4@zion.home.lan>
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
