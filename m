Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbUC3XBz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 18:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbUC3Wsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 17:48:52 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:12315 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261648AbUC3WrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 17:47:05 -0500
Date: Tue, 30 Mar 2004 23:47:02 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/6] mremap vma_relink_file
In-Reply-To: <Pine.LNX.4.44.0403302340220.24019-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0403302346130.24019-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subtle point from Rajesh Venkatasubramanian: when mremap's move_vma
fails and so rewinds, before moving the file-based ptes back, we must
move new_vma before old vma in the i_mmap or i_mmap_shared list,
so that when racing against vmtruncate we cannot propagate pages
to be truncated back from new_vma into the just cleaned old_vma.

--- mremap3/include/linux/mm.h	2004-03-30 21:24:48.666410384 +0100
+++ mremap4/include/linux/mm.h	2004-03-30 21:25:00.131667400 +0100
@@ -540,6 +540,7 @@ extern void __vma_link_rb(struct mm_stru
 	struct rb_node **, struct rb_node *);
 extern struct vm_area_struct *copy_vma(struct vm_area_struct *,
 	unsigned long addr, unsigned long len, unsigned long pgoff);
+extern void vma_relink_file(struct vm_area_struct *, struct vm_area_struct *);
 extern void exit_mmap(struct mm_struct *);
 
 extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
--- mremap3/mm/mmap.c	2004-03-30 21:24:48.668410080 +0100
+++ mremap4/mm/mmap.c	2004-03-30 21:25:00.133667096 +0100
@@ -1517,3 +1517,24 @@ struct vm_area_struct *copy_vma(struct v
 	}
 	return new_vma;
 }
+
+/*
+ * Position vma after prev in shared file list:
+ * for mremap move error recovery racing against vmtruncate.
+ */
+void vma_relink_file(struct vm_area_struct *vma, struct vm_area_struct *prev)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct address_space *mapping;
+
+	if (vma->vm_file) {
+		mapping = vma->vm_file->f_mapping;
+		if (mapping) {
+			down(&mapping->i_shared_sem);
+			spin_lock(&mm->page_table_lock);
+			list_move(&vma->shared, &prev->shared);
+			spin_unlock(&mm->page_table_lock);
+			up(&mapping->i_shared_sem);
+		}
+	}
+}
--- mremap3/mm/mremap.c	2004-03-30 21:24:48.671409624 +0100
+++ mremap4/mm/mremap.c	2004-03-30 21:25:00.136666640 +0100
@@ -187,7 +187,14 @@ static unsigned long move_vma(struct vm_
 		 * On error, move entries back from new area to old,
 		 * which will succeed since page tables still there,
 		 * and then proceed to unmap new area instead of old.
+		 *
+		 * Subtle point from Rajesh Venkatasubramanian: before
+		 * moving file-based ptes, move new_vma before old vma
+		 * in the i_mmap or i_mmap_shared list, so when racing
+		 * against vmtruncate we cannot propagate pages to be
+		 * truncated back from new_vma into just cleaned old.
 		 */
+		vma_relink_file(vma, new_vma);
 		move_page_tables(new_vma, old_addr, new_addr, moved_len);
 		vma = new_vma;
 		old_len = new_len;

