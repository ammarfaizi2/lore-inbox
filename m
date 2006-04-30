Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWD3Rch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWD3Rch (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 13:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWD3Rch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 13:32:37 -0400
Received: from host157-96.pool873.interbusiness.it ([87.3.96.157]:44242 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1751191AbWD3Rcg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 13:32:36 -0400
Message-Id: <20060430173023.788285000@zion.home.lan>
References: <20060430172953.409399000@zion.home.lan>
User-Agent: quilt/0.44-1
Date: Sun, 30 Apr 2006 19:29:59 +0200
From: blaisorblade@yahoo.it
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 06/14] remap_file_pages protection support: enhance syscall interface
Content-Disposition: inline; filename=rfp/06-rfp-enhance-syscall.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Enable the 'prot' parameter for shared-writable mappings (the ones which are
the primary target for remap_file_pages), without breaking up the vma.

This contains simply the changes to the syscall code, based on Ingo's patch.
Differently from his one, I've *not* added a new syscall, choosing to add a
new flag (MAP_CHGPROT) which the application must specify to get the new
behavior (prot != 0 is accepted and prot == 0 means PROT_NONE).

Upon Hugh's suggestion, simplify the permission checking on the VMA, reusing
mprotect()'s trick.

Index: linux-2.6.git/mm/fremap.c
===================================================================
--- linux-2.6.git.orig/mm/fremap.c
+++ linux-2.6.git/mm/fremap.c
@@ -4,6 +4,10 @@
  * Explicit pagetable population and nonlinear (random) mappings support.
  *
  * started by Ingo Molnar, Copyright (C) 2002, 2003
+ *
+ * support of nonuniform remappings:
+ * Copyright (C) 2004 Ingo Molnar
+ * Copyright (C) 2005 Paolo 'Blaisorblade' Giarrusso
  */
 
 #include <linux/mm.h>
@@ -126,18 +130,14 @@ out:
  *                        file within an existing vma.
  * @start: start of the remapped virtual memory range
  * @size: size of the remapped virtual memory range
- * @prot: new protection bits of the range
+ * @prot: new protection bits of the range, must be 0 if not using MAP_CHGPROT
  * @pgoff: to be mapped page of the backing store file
- * @flags: 0 or MAP_NONBLOCKED - the later will cause no IO.
+ * @flags: bits MAP_CHGPROT or MAP_NONBLOCKED - the later will cause no IO.
  *
  * this syscall works purely via pagetables, so it's the most efficient
  * way to map the same (large) file into a given virtual window. Unlike
  * mmap()/mremap() it does not create any new vmas. The new mappings are
  * also safe across swapout.
- *
- * NOTE: the 'prot' parameter right now is ignored, and the vma's default
- * protection is used. Arbitrary protections might be implemented in the
- * future.
  */
 asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
 	unsigned long prot, unsigned long pgoff, unsigned long flags)
@@ -150,7 +150,7 @@ asmlinkage long sys_remap_file_pages(uns
 	int has_write_lock = 0;
 	pgprot_t pgprot;
 
-	if (prot)
+	if (prot && !(flags & MAP_CHGPROT))
 		goto out;
 	/*
 	 * Sanitize the syscall parameters:
@@ -193,7 +193,19 @@ retry:
 	if (end <= start || start < vma->vm_start || end > vma->vm_end)
 		goto out_unlock;
 
-	pgprot = vma->vm_page_prot;
+	if (flags & MAP_CHGPROT) {
+		unsigned long vm_prots = calc_vm_prot_bits(prot);
+
+		/* vma->vm_flags >> 4 shifts VM_MAY% in place of VM_% */
+		if ((vm_prots & ~(vma->vm_flags >> 4)) &
+				(VM_READ | VM_WRITE | VM_EXEC)) {
+			err = -EPERM;
+			goto out_unlock;
+		}
+
+		pgprot = protection_map[vm_prots | VM_SHARED];
+	} else
+		pgprot = vma->vm_page_prot;
 
 	if (!vma->vm_private_data || (vma->vm_flags & VM_NONLINEAR)) {
 		/* Must set VM_NONLINEAR before any pages are populated. */
@@ -215,6 +227,17 @@ retry:
 			spin_unlock(&mapping->i_mmap_lock);
 		}
 
+		if (pgprot_val(pgprot) != pgprot_val(vma->vm_page_prot) &&
+				!(vma->vm_flags & VM_MANYPROTS)) {
+			if (!has_write_lock) {
+				up_read(&mm->mmap_sem);
+				down_write(&mm->mmap_sem);
+				has_write_lock = 1;
+				goto retry;
+			}
+			vma->vm_flags |= VM_MANYPROTS;
+		}
+
 		err = vma->vm_ops->populate(vma, start, size, pgprot, pgoff,
 				flags & MAP_NONBLOCK);
 

--
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
