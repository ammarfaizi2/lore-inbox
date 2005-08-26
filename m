Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965134AbVHZRDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbVHZRDK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965127AbVHZRCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:02:55 -0400
Received: from ppp-62-11-73-212.dialup.tiscali.it ([62.11.73.212]:37013 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965132AbVHZRCl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:02:41 -0400
Subject: [patch 05/18] remap_file_pages protection support: enhance syscall interface
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 26 Aug 2005 18:53:14 +0200
Message-Id: <20050826165314.A7A422232B9@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Ingo Molnar <mingo@elte.hu>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

This contains simply the changes to the syscall code, based on Ingo's patch.
Differently from his one, I've *not* added a new syscall, choosing to add a
new flag (MAP_NOINHERIT) which the application must specify to get the new
behavior (prot != 0 is accepted and prot == 0 means PROT_NONE).

Enable the 'prot' parameter for shared-writable mappings (the ones which are
the primary target for remap_file_pages), without breaking up the vma.

*** remap_file_pages protection support: use EOVERFLOW ret code

Use -EOVERFLOW ("Value too large for defined data type") rather than -EINVAL
when we cannot store the file offset in the PTE.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/fremap.c |   40 +++++++++++++++++++++++++++++++---------
 1 files changed, 31 insertions(+), 9 deletions(-)

diff -puN mm/fremap.c~rfp-enhance-syscall mm/fremap.c
--- linux-2.6.git/mm/fremap.c~rfp-enhance-syscall	2005-08-24 20:55:35.000000000 +0200
+++ linux-2.6.git-paolo/mm/fremap.c	2005-08-24 20:56:49.000000000 +0200
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
@@ -164,18 +168,14 @@ err_unlock:
  *                        file within an existing vma.
  * @start: start of the remapped virtual memory range
  * @size: size of the remapped virtual memory range
- * @prot: new protection bits of the range
+ * @prot: new protection bits of the range, must be 0 if not using MAP_NOINHERIT
  * @pgoff: to be mapped page of the backing store file
- * @flags: 0 or MAP_NONBLOCKED - the later will cause no IO.
+ * @flags: bits MAP_NOINHERIT or MAP_NONBLOCKED - the later will cause no IO.
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
@@ -188,7 +188,7 @@ asmlinkage long sys_remap_file_pages(uns
 	int has_write_lock = 0;
 	pgprot_t pgprot;
 
-	if (prot)
+	if (prot && !(flags & MAP_NOINHERIT))
 		goto out;
 	/*
 	 * Sanitize the syscall parameters:
@@ -203,7 +203,7 @@ asmlinkage long sys_remap_file_pages(uns
 	/* Can we represent this offset inside this architecture's pte's? */
 #if PTE_FILE_MAX_BITS < BITS_PER_LONG
 	if (pgoff + (size >> PAGE_SHIFT) >= (1UL << PTE_FILE_MAX_BITS))
-		return err;
+		return -EOVERFLOW;
 #endif
 
 	/* We need down_write() to change vma->vm_flags. */
@@ -228,7 +228,18 @@ retry:
 			vma->vm_start || end > vma->vm_end)
 		goto out_unlock;
 
-	pgprot = vma->vm_page_prot;
+	if (flags & MAP_NOINHERIT) {
+		err = -EPERM;
+		if (((prot & PROT_READ) && !(vma->vm_flags & VM_MAYREAD)))
+			goto out_unlock;
+		if (((prot & PROT_WRITE) && !(vma->vm_flags & VM_MAYWRITE)))
+			goto out_unlock;
+		if (((prot & PROT_EXEC) && !(vma->vm_flags & VM_MAYEXEC)))
+			goto out_unlock;
+		err = -EINVAL;
+		pgprot = protection_map[calc_vm_prot_bits(prot) | VM_SHARED];
+	} else 
+		pgprot = vma->vm_page_prot;
 
 	if (!vma->vm_private_data ||
 			(vma->vm_flags & (VM_NONLINEAR|VM_RESERVED))) {
@@ -251,6 +262,17 @@ retry:
 			spin_unlock(&mapping->i_mmap_lock);
 		}
 
+		if (pgprot_val(pgprot) != pgprot_val(vma->vm_page_prot) &&
+				!(vma->vm_flags & VM_NONUNIFORM)) {
+			if (!has_write_lock) {
+				up_read(&mm->mmap_sem);
+				down_write(&mm->mmap_sem);
+				has_write_lock = 1;
+				goto retry;
+			}
+			vma->vm_flags |= VM_NONUNIFORM;
+		}
+
 		/* Do NOT hold the write lock while doing any I/O, nor when
 		 * iterating over too many PTEs. Values might need tuning. */
 		if (has_write_lock && (!(flags & MAP_NONBLOCK) || size > INSTALL_SIZE)) {
_
