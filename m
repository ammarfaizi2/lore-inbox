Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268045AbUJCS0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268045AbUJCS0J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 14:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268048AbUJCS0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 14:26:09 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:42524 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S268045AbUJCSZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 14:25:49 -0400
Date: Sun, 3 Oct 2004 19:25:32 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/6] vmtrunc: unmap_mapping_range_tree
In-Reply-To: <Pine.LNX.4.44.0410031914480.2739-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0410031924440.2755-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move unmap_mapping_range's nonlinear vma handling out to its own inline,
parallel to the prio_tree handling; unmap_mapping_range_list is a better
name for the nonlinear list, rename the other unmap_mapping_range_tree.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/memory.c |   42 +++++++++++++++++++++++-------------------
 1 files changed, 23 insertions(+), 19 deletions(-)

--- trunc2/mm/memory.c	2004-10-03 01:07:12.957255752 +0100
+++ trunc3/mm/memory.c	2004-10-03 01:07:24.510499392 +0100
@@ -1189,9 +1189,9 @@ no_new_page:
 }
 
 /*
- * Helper function for unmap_mapping_range().
+ * Helper functions for unmap_mapping_range().
  */
-static inline void unmap_mapping_range_list(struct prio_tree_root *root,
+static inline void unmap_mapping_range_tree(struct prio_tree_root *root,
 					    struct zap_details *details)
 {
 	struct vm_area_struct *vma;
@@ -1215,6 +1215,24 @@ static inline void unmap_mapping_range_l
 	}
 }
 
+static inline void unmap_mapping_range_list(struct list_head *head,
+					    struct zap_details *details)
+{
+	struct vm_area_struct *vma;
+
+	/*
+	 * In nonlinear VMAs there is no correspondence between virtual address
+	 * offset and file offset.  So we must perform an exhaustive search
+	 * across *all* the pages in each nonlinear VMA, not just the pages
+	 * whose virtual address lies outside the file truncation point.
+	 */
+	list_for_each_entry(vma, head, shared.vm_set.list) {
+		details->nonlinear_vma = vma;
+		zap_page_range(vma, vma->vm_start,
+				vma->vm_end - vma->vm_start, details);
+	}
+}
+
 /**
  * unmap_mapping_range - unmap the portion of all mmaps
  * in the specified address_space corresponding to the specified
@@ -1259,23 +1277,9 @@ void unmap_mapping_range(struct address_
 	mapping->truncate_count++;
 
 	if (unlikely(!prio_tree_empty(&mapping->i_mmap)))
-		unmap_mapping_range_list(&mapping->i_mmap, &details);
-
-	/*
-	 * In nonlinear VMAs there is no correspondence between virtual address
-	 * offset and file offset.  So we must perform an exhaustive search
-	 * across *all* the pages in each nonlinear VMA, not just the pages
-	 * whose virtual address lies outside the file truncation point.
-	 */
-	if (unlikely(!list_empty(&mapping->i_mmap_nonlinear))) {
-		struct vm_area_struct *vma;
-		list_for_each_entry(vma, &mapping->i_mmap_nonlinear,
-						shared.vm_set.list) {
-			details.nonlinear_vma = vma;
-			zap_page_range(vma, vma->vm_start,
-				vma->vm_end - vma->vm_start, &details);
-		}
-	}
+		unmap_mapping_range_tree(&mapping->i_mmap, &details);
+	if (unlikely(!list_empty(&mapping->i_mmap_nonlinear)))
+		unmap_mapping_range_list(&mapping->i_mmap_nonlinear, &details);
 	spin_unlock(&mapping->i_mmap_lock);
 }
 EXPORT_SYMBOL(unmap_mapping_range);

