Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWD3RfC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWD3RfC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 13:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWD3RdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 13:33:17 -0400
Received: from host157-96.pool873.interbusiness.it ([87.3.96.157]:45010 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1751200AbWD3Rcl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 13:32:41 -0400
Message-Id: <20060430173026.132255000@zion.home.lan>
References: <20060430172953.409399000@zion.home.lan>
User-Agent: quilt/0.44-1
Date: Sun, 30 Apr 2006 19:30:05 +0200
From: blaisorblade@yahoo.it
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Paolo Blaisorblade Giarrusso <blaisorblade@yahoo.it>
Subject: [patch 12/14] remap_file_pages protection support: also set VM_NONLINEAR on nonuniform VMAs
Content-Disposition: inline; filename=rfp/12-rfp-nonuniform-implies-nonlinear.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

To simplify the VM code, and to reflect expected application usage, we decide
to also set VM_NONLINEAR when setting VM_MANYPROTS. Otherwise, we'd have to
possibly save nonlinear PTEs even on paths which cope with linear VMAs. It's
possible, but intrusive (it's done in one of the next patches).

Obviously, this has a performance cost, since we potentially have to handle a
linear VMA with nonlinear handling code. But I didn't know of any application
which might have this usage.

XXX: update: glibc wants to replace mprotect() with linear VM_MANYPROTS areas,
to handle guard pages and data mappings of shared objects.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.git/mm/fremap.c
===================================================================
--- linux-2.6.git.orig/mm/fremap.c
+++ linux-2.6.git/mm/fremap.c
@@ -206,8 +206,9 @@ retry:
 
 	if (!vma->vm_private_data || (vma->vm_flags & VM_NONLINEAR)) {
 		/* Must set VM_NONLINEAR before any pages are populated. */
-		if (pgoff != linear_page_index(vma, start) &&
-		    !(vma->vm_flags & VM_NONLINEAR)) {
+		if (!(vma->vm_flags & VM_NONLINEAR) &&
+			(pgoff != linear_page_index(vma, start) ||
+			pgprot_val(pgprot) != pgprot_val(vma->vm_page_prot))) {
 			if (!(vma->vm_flags & VM_SHARED))
 				goto out_unlock;
 			if (!has_write_lock) {
@@ -224,19 +225,19 @@ retry:
 			vma_nonlinear_insert(vma, &mapping->i_mmap_nonlinear);
 			flush_dcache_mmap_unlock(mapping);
 			spin_unlock(&mapping->i_mmap_lock);
-		}
 
-		if (pgprot_val(pgprot) != pgprot_val(vma->vm_page_prot) &&
-				!(vma->vm_flags & VM_MANYPROTS)) {
-			if (!(vma->vm_flags & VM_SHARED))
-				goto out_unlock;
-			if (!has_write_lock) {
-				up_read(&mm->mmap_sem);
-				down_write(&mm->mmap_sem);
-				has_write_lock = 1;
-				goto retry;
+			if (!(vma->vm_flags & VM_MANYPROTS) &&
+				pgprot_val(pgprot) != pgprot_val(vma->vm_page_prot)) {
+				if (!(vma->vm_flags & VM_SHARED))
+					goto out_unlock;
+				if (!has_write_lock) {
+					up_read(&mm->mmap_sem);
+					down_write(&mm->mmap_sem);
+					has_write_lock = 1;
+					goto retry;
+				}
+				vma->vm_flags |= VM_MANYPROTS;
 			}
-			vma->vm_flags |= VM_MANYPROTS;
 		}
 
 		err = vma->vm_ops->populate(vma, start, size, pgprot, pgoff,

--
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
