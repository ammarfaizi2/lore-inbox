Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264085AbUJGRJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbUJGRJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 13:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266116AbUJGRJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 13:09:41 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:8480 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S267515AbUJGQuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 12:50:19 -0400
Date: Thu, 7 Oct 2004 17:50:03 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/6] vmtrunc: restart_addr in truncate_count
Message-ID: <Pine.LNX.4.44.0410071744001.2839-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Despite its restart_pgoff pretensions, unmap_mapping_range_vma was
fatally unable to distinguish a vma to be restarted from the case where
that vma has been freed, and its vm_area_struct reused for the top part
of a !new_below split of an isomorphic vma yet to be scanned.

The obvious answer is to note restart_vma in the struct address_space,
and cancel it when that vma is freed; but I'm reluctant to enlarge every
struct inode just for this.  Another answer is to flag valid restart in
the vm_area_struct; but vm_flags is protected by down_write of mmap_sem,
which we cannot take within down_write of i_sem.  If we're going to need
yet another field, better to record the restart_addr itself: restart_vma
only recorded the last restart, but a busy tree could well use more.

Actually, we don't need another field: we can neatly (though naughtily)
keep restart_addr in vm_truncate_count, provided mapping->truncate_count
leaps over those values which look like a page-aligned address.  Zero
remains good for forcing a scan (though now interpreted as restart_addr
0), and it turns out no change is needed to any of the vm_truncate_count
settings in dup_mmap, vma_link, vma_adjust, move_one_page.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 include/linux/mm.h |    7 +-----
 mm/memory.c        |   57 ++++++++++++++++++-----------------------------------
 2 files changed, 22 insertions(+), 42 deletions(-)

--- 2.6.9-rc3-mm3/include/linux/mm.h	2004-10-07 11:51:33.000000000 +0100
+++ linux/include/linux/mm.h	2004-10-07 11:58:10.000000000 +0100
@@ -103,7 +103,7 @@ struct vm_area_struct {
 					   units, *not* PAGE_CACHE_SIZE */
 	struct file * vm_file;		/* File we map to (can be NULL). */
 	void * vm_private_data;		/* was vm_pte (shared mem) */
-	unsigned int vm_truncate_count;	/* compare mapping->truncate_count */
+	unsigned long vm_truncate_count;/* truncate_count or restart_addr */
 
 #ifdef CONFIG_NUMA
 	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
@@ -561,11 +561,8 @@ struct zap_details {
 	pgoff_t	first_index;			/* Lowest page->index to unmap */
 	pgoff_t last_index;			/* Highest page->index to unmap */
 	spinlock_t *i_mmap_lock;		/* For unmap_mapping_range: */
-	struct vm_area_struct *restart_vma;	/* Where lock was dropped */
-	pgoff_t restart_pgoff;			/* File offset for restart */
-	unsigned long restart_addr;		/* Where we should restart */
 	unsigned long break_addr;		/* Where unmap_vmas stopped */
-	unsigned int truncate_count;		/* Compare vm_truncate_count */
+	unsigned long truncate_count;		/* Compare vm_truncate_count */
 };
 
 void zap_page_range(struct vm_area_struct *vma, unsigned long address,
--- 2.6.9-rc3-mm3/mm/memory.c	2004-10-07 11:51:34.000000000 +0100
+++ linux/mm/memory.c	2004-10-07 13:56:26.000000000 +0100
@@ -1227,20 +1227,13 @@ no_new_page:
  *
  * In order to make forward progress despite repeatedly restarting some
  * large vma, note the break_addr set by unmap_vmas when it breaks out:
- * and restart from that address when we reach that vma again (so long
- * as another such was not inserted earlier while the lock was dropped).
- *
- * There is no guarantee that the restart_vma will remain intact when
- * the lock is regained: but if it has been freed to some other use,
- * it cannot then appear in the tree or list of vmas, so no harm done;
- * if it has been reused for a new vma of the same mapping, nopage
- * checks on i_size and truncate_count ensure it cannot be mapping any
- * of the truncated pages, so the area below restart_addr is still safe
- * to skip - but we must check pgoff to prevent spurious unmapping; or
- * restart_vma may have been split or merged, shrunk or extended - but
- * never shifted, so restart_addr and restart_pgoff remain in synch
- * (even in the case of mremap move, which makes a copy of the vma).
+ * and restart from that address when we reach that vma again.  It might
+ * have been split or merged, shrunk or extended, but never shifted: so
+ * restart_addr remains valid so long as it remains in the vma's range.
+ * unmap_mapping_range forces truncate_count to leap over page-aligned
+ * values so we can save vma's restart_addr in its truncate_count field.
  */
+#define is_restart_addr(truncate_count) (!((truncate_count) & ~PAGE_MASK))
 
 static void reset_vma_truncate_counts(struct address_space *mapping)
 {
@@ -1257,26 +1250,20 @@ static int unmap_mapping_range_vma(struc
 		unsigned long start_addr, unsigned long end_addr,
 		struct zap_details *details)
 {
+	unsigned long restart_addr;
 	int need_break;
 
-	if (vma == details->restart_vma &&
-	    start_addr < details->restart_addr) {
-		/*
-		 * Be careful: this vm_area_struct may have been reused
-		 * meanwhile.  If pgoff matches up, it's probably the
-		 * same one (perhaps shrunk or extended), but no harm is
-		 * done if actually it's new.  If pgoff does not match,
-		 * it would likely be wrong to unmap from restart_addr,
-		 * but it must be new, so we can just mark it completed.
-		 */
-		start_addr = details->restart_addr;
-		if (linear_page_index(vma, start_addr) !=
-		    details->restart_pgoff || start_addr >= end_addr) {
+again:
+	restart_addr = vma->vm_truncate_count;
+	if (is_restart_addr(restart_addr) && start_addr < restart_addr) {
+		start_addr = restart_addr;
+		if (start_addr >= end_addr) {
+			/* Top of vma has been split off since last time */
 			vma->vm_truncate_count = details->truncate_count;
 			return 0;
 		}
 	}
-again:
+
 	details->break_addr = end_addr;
 	zap_page_range(vma, start_addr, end_addr - start_addr, details);
 
@@ -1295,14 +1282,10 @@ again:
 		if (!need_break)
 			return 0;
 	} else {
-		if (!need_break) {
-			start_addr = details->break_addr;
+		/* Note restart_addr in vma's truncate_count field */
+		vma->vm_truncate_count = details->break_addr;
+		if (!need_break)
 			goto again;
-		}
-		details->restart_vma = vma;
-		details->restart_pgoff =
-			linear_page_index(vma, details->break_addr);
-		details->restart_addr = details->break_addr;
 	}
 
 	spin_unlock(details->i_mmap_lock);
@@ -1404,15 +1387,15 @@ void unmap_mapping_range(struct address_
 	if (details.last_index < details.first_index)
 		details.last_index = ULONG_MAX;
 	details.i_mmap_lock = &mapping->i_mmap_lock;
-	details.restart_vma = NULL;
 
 	spin_lock(&mapping->i_mmap_lock);
 
 	/* Protect against page faults, and endless unmapping loops */
 	mapping->truncate_count++;
-	if (unlikely(mapping->truncate_count == 0)) {
+	if (unlikely(is_restart_addr(mapping->truncate_count))) {
+		if (mapping->truncate_count == 0)
+			reset_vma_truncate_counts(mapping);
 		mapping->truncate_count++;
-		reset_vma_truncate_counts(mapping);
 	}
 	details.truncate_count = mapping->truncate_count;
 

