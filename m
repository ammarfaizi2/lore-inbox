Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264199AbUEHWDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264199AbUEHWDY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 18:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264195AbUEHWCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 18:02:30 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:48280 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264194AbUEHWBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 18:01:20 -0400
Date: Sat, 8 May 2004 23:01:08 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] rmap 28 remove_vm_struct
In-Reply-To: <Pine.LNX.4.44.0405082250570.26569-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0405082300270.26569-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The callers of remove_shared_vm_struct then proceed to do several
more identical things: gather them together in remove_vm_struct.

 mmap.c |   31 +++++++++++--------------------
 1 files changed, 11 insertions(+), 20 deletions(-)

--- rmap27/mm/mmap.c	2004-05-08 20:55:05.460548328 +0100
+++ rmap28/mm/mmap.c	2004-05-08 20:55:16.547862800 +0100
@@ -66,7 +66,7 @@ EXPORT_SYMBOL(vm_committed_space);
 /*
  * Requires inode->i_mapping->i_shared_lock
  */
-static inline void __remove_shared_vm_struct(struct vm_area_struct *vma,
+static void __remove_shared_vm_struct(struct vm_area_struct *vma,
 		struct file *file, struct address_space *mapping)
 {
 	if (vma->vm_flags & VM_DENYWRITE)
@@ -83,9 +83,9 @@ static inline void __remove_shared_vm_st
 }
 
 /*
- * Remove one vm structure from the inode's i_mapping address space.
+ * Remove one vm structure and free it.
  */
-static void remove_shared_vm_struct(struct vm_area_struct *vma)
+static void remove_vm_struct(struct vm_area_struct *vma)
 {
 	struct file *file = vma->vm_file;
 
@@ -95,6 +95,12 @@ static void remove_shared_vm_struct(stru
 		__remove_shared_vm_struct(vma, file, mapping);
 		spin_unlock(&mapping->i_shared_lock);
 	}
+	if (vma->vm_ops && vma->vm_ops->close)
+		vma->vm_ops->close(vma);
+	if (file)
+		fput(file);
+	mpol_free(vma_policy(vma));
+	kmem_cache_free(vm_area_cachep, vma);
 }
 
 /*
@@ -1164,14 +1170,7 @@ static void unmap_vma(struct mm_struct *
 				area->vm_start < area->vm_mm->free_area_cache)
 	      area->vm_mm->free_area_cache = area->vm_start;
 
-	remove_shared_vm_struct(area);
-
-	mpol_free(vma_policy(area));
-	if (area->vm_ops && area->vm_ops->close)
-		area->vm_ops->close(area);
-	if (area->vm_file)
-		fput(area->vm_file);
-	kmem_cache_free(vm_area_cachep, area);
+	remove_vm_struct(area);
 }
 
 /*
@@ -1500,15 +1499,7 @@ void exit_mmap(struct mm_struct *mm)
 	 */
 	while (vma) {
 		struct vm_area_struct *next = vma->vm_next;
-		remove_shared_vm_struct(vma);
-		if (vma->vm_ops) {
-			if (vma->vm_ops->close)
-				vma->vm_ops->close(vma);
-		}
-		if (vma->vm_file)
-			fput(vma->vm_file);
-		mpol_free(vma_policy(vma));
-		kmem_cache_free(vm_area_cachep, vma);
+		remove_vm_struct(vma);
 		vma = next;
 	}
 }

