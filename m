Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266479AbUFRTIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266479AbUFRTIi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 15:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266552AbUFRTD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 15:03:57 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:51355 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S266479AbUFRS7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 14:59:54 -0400
Date: Fri, 18 Jun 2004 19:59:40 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mprotect propagate anon_vma
Message-ID: <Pine.LNX.4.44.0406181956000.26377-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When mprotect shifts the boundary between vmas (merging the reprotected
area into the vma before or the vma after), make sure that the expanding
vma has anon_vma if the shrinking vma had, to cover anon pages imported.
Thanks to Andrea for alerting us to this oversight.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.7/mm/mmap.c	2004-06-16 06:20:42.000000000 +0100
+++ linux/mm/mmap.c	2004-06-18 17:58:24.190765248 +0100
@@ -363,6 +363,7 @@ void vma_adjust(struct vm_area_struct *v
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct vm_area_struct *next = vma->vm_next;
+	struct vm_area_struct *importer = NULL;
 	struct address_space *mapping = NULL;
 	struct prio_tree_root *root = NULL;
 	struct file *file = vma->vm_file;
@@ -386,6 +387,7 @@ again:			remove_next = 1 + (end > next->
 			 */
 			adjust_next = (end - next->vm_start) >> PAGE_SHIFT;
 			anon_vma = next->anon_vma;
+			importer = vma;
 		} else if (end < vma->vm_end) {
 			/*
 			 * vma shrinks, and !insert tells it's not
@@ -394,6 +396,7 @@ again:			remove_next = 1 + (end > next->
 			 */
 			adjust_next = - ((vma->vm_end - end) >> PAGE_SHIFT);
 			anon_vma = next->anon_vma;
+			importer = next;
 		}
 	}
 
@@ -419,8 +422,18 @@ again:			remove_next = 1 + (end > next->
 	 */
 	if (vma->anon_vma)
 		anon_vma = vma->anon_vma;
-	if (anon_vma)
+	if (anon_vma) {
 		spin_lock(&anon_vma->lock);
+		/*
+		 * Easily overlooked: when mprotect shifts the boundary,
+		 * make sure the expanding vma has anon_vma set if the
+		 * shrinking vma had, to cover any anon pages imported.
+		 */
+		if (importer && !importer->anon_vma) {
+			importer->anon_vma = anon_vma;
+			__anon_vma_link(importer);
+		}
+	}
 
 	if (root) {
 		flush_dcache_mmap_lock(mapping);

