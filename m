Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268051AbUJCSaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268051AbUJCSaA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 14:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268057AbUJCS37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 14:29:59 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:23075 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S268051AbUJCS0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 14:26:44 -0400
Date: Sun, 3 Oct 2004 19:26:27 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/6] vmtrunc: unmap_mapping dropping i_mmap_lock
In-Reply-To: <Pine.LNX.4.44.0410031914480.2739-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0410031925390.2755-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vmtruncate (or more generally, unmap_mapping_range) has been observed
responsible for very high latencies: the lockbreak work in unmap_vmas is
good for munmap or exit_mmap, but no use while mapping->i_mmap_lock is
held, to keep our place in the prio_tree (or list) of a file's vmas.

Extend the zap_details block with i_mmap_lock pointer, so unmap_vmas can
detect if that needs lockbreak, and break_addr so it can notify where it
left off.

Add unmap_mapping_range_vma, used from both prio_tree and nonlinear list
handlers.  This is what now calls zap_page_range (above unmap_vmas), but
handles the lockbreak and restart issues: letting unmap_mapping_range_
tree or list know when they need to start over because lock was dropped.

When restarting, of course there's a danger of never making progress.
Add vm_truncate_count field to vm_area_struct, update that to mapping->
truncate_count once fully scanned, skip up-to-date vmas without a scan
(and without dropping i_mmap_lock).

Further danger of never making progress if a vma is very large: when
breaking out, save restart_vma and restart_addr (and restart_pgoff to
confirm, in case vma gets reused), to help continue where we left off.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 include/linux/mm.h |    8 ++
 mm/memory.c        |  166 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 160 insertions(+), 14 deletions(-)

--- trunc3/include/linux/mm.h	2004-10-02 18:22:28.114113072 +0100
+++ trunc4/include/linux/mm.h	2004-10-03 01:07:36.185724488 +0100
@@ -103,6 +103,7 @@ struct vm_area_struct {
 					   units, *not* PAGE_CACHE_SIZE */
 	struct file * vm_file;		/* File we map to (can be NULL). */
 	void * vm_private_data;		/* was vm_pte (shared mem) */
+	unsigned int vm_truncate_count;	/* compare mapping->truncate_count */
 
 #ifdef CONFIG_NUMA
 	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
@@ -559,7 +560,12 @@ struct zap_details {
 	struct address_space *check_mapping;	/* Check page->mapping if set */
 	pgoff_t	first_index;			/* Lowest page->index to unmap */
 	pgoff_t last_index;			/* Highest page->index to unmap */
-	int atomic;				/* May not schedule() */
+	spinlock_t *i_mmap_lock;		/* For unmap_mapping_range: */
+	struct vm_area_struct *restart_vma;	/* Where lock was dropped */
+	pgoff_t restart_pgoff;			/* File offset for restart */
+	unsigned long restart_addr;		/* Where we should restart */
+	unsigned long break_addr;		/* Where unmap_vmas stopped */
+	unsigned int truncate_count;		/* Compare vm_truncate_count */
 };
 
 void zap_page_range(struct vm_area_struct *vma, unsigned long address,
--- trunc3/mm/memory.c	2004-10-03 01:07:24.510499392 +0100
+++ trunc4/mm/memory.c	2004-10-03 01:07:36.189723880 +0100
@@ -548,7 +548,8 @@ int unmap_vmas(struct mmu_gather **tlbp,
 	unsigned long tlb_start = 0;	/* For tlb_finish_mmu */
 	int tlb_start_valid = 0;
 	int ret = 0;
-	int atomic = details && details->atomic;
+	spinlock_t *i_mmap_lock = details? details->i_mmap_lock: NULL;
+	int fullmm = tlb_is_full_mm(*tlbp);
 
 	for ( ; vma && vma->vm_start < end_addr; vma = vma->vm_next) {
 		unsigned long start;
@@ -587,16 +588,28 @@ int unmap_vmas(struct mmu_gather **tlbp,
 			if ((long)zap_bytes > 0)
 				continue;
 
-			if (!atomic) {
-				int fullmm = tlb_is_full_mm(*tlbp);
-				tlb_finish_mmu(*tlbp, tlb_start, start);
-				cond_resched_lock(&mm->page_table_lock);
-				*tlbp = tlb_gather_mmu(mm, fullmm);
-				tlb_start_valid = 0;
+			tlb_finish_mmu(*tlbp, tlb_start, start);
+
+			if (need_resched() ||
+				need_lockbreak(&mm->page_table_lock) ||
+				(i_mmap_lock && need_lockbreak(i_mmap_lock))) {
+				if (i_mmap_lock) {
+					/* must reset count of rss freed */
+					*tlbp = tlb_gather_mmu(mm, fullmm);
+					details->break_addr = start;
+					goto out;
+				}
+				spin_unlock(&mm->page_table_lock);
+				cond_resched();
+				spin_lock(&mm->page_table_lock);
 			}
+
+			*tlbp = tlb_gather_mmu(mm, fullmm);
+			tlb_start_valid = 0;
 			zap_bytes = ZAP_BLOCK_SIZE;
 		}
 	}
+out:
 	return ret;
 }
 
@@ -1190,7 +1203,114 @@ no_new_page:
 
 /*
  * Helper functions for unmap_mapping_range().
+ *
+ * __ Notes on dropping i_mmap_lock to reduce latency while unmapping __
+ *
+ * We have to restart searching the prio_tree whenever we drop the lock,
+ * since the iterator is only valid while the lock is held, and anyway
+ * a later vma might be split and reinserted earlier while lock dropped.
+ *
+ * The list of nonlinear vmas could be handled more efficiently, using
+ * a placeholder, but handle it in the same way until a need is shown.
+ * It is important to search the prio_tree before nonlinear list: a vma
+ * may become nonlinear and be shifted from prio_tree to nonlinear list
+ * while the lock is dropped; but never shifted from list to prio_tree.
+ *
+ * In order to make forward progress despite restarting the search,
+ * vm_truncate_count is used to mark a vma as now dealt with, so we can
+ * quickly skip it next time around.  Since the prio_tree search only
+ * shows us those vmas affected by unmapping the range in question, we
+ * can't efficiently keep all vmas in step with mapping->truncate_count:
+ * so instead reset them all whenever it wraps back to 0 (then go to 1).
+ * mapping->truncate_count and vma->vm_truncate_count are protected by
+ * i_mmap_lock.
+ *
+ * In order to make forward progress despite repeatedly restarting some
+ * large vma, note the break_addr set by unmap_vmas when it breaks out:
+ * and restart from that address when we reach that vma again (so long
+ * as another such was not inserted earlier while the lock was dropped).
+ *
+ * There is no guarantee that the restart_vma will remain intact when
+ * the lock is regained: but if it has been freed to some other use,
+ * it cannot then appear in the tree or list of vmas, so no harm done;
+ * if it has been reused for a new vma of the same mapping, nopage
+ * checks on i_size and truncate_count ensure it cannot be mapping any
+ * of the truncated pages, so the area below restart_addr is still safe
+ * to skip - but we must check pgoff to prevent spurious unmapping; or
+ * restart_vma may have been split or merged, shrunk or extended - but
+ * never shifted, so restart_addr and restart_pgoff remain in synch
+ * (even in the case of mremap move, which makes a copy of the vma).
  */
+
+static void reset_vma_truncate_counts(struct address_space *mapping)
+{
+	struct vm_area_struct *vma;
+	struct prio_tree_iter iter;
+
+	vma_prio_tree_foreach(vma, &iter, &mapping->i_mmap, 0, ULONG_MAX)
+		vma->vm_truncate_count = 0;
+	list_for_each_entry(vma, &mapping->i_mmap_nonlinear, shared.vm_set.list)
+		vma->vm_truncate_count = 0;
+}
+
+static int unmap_mapping_range_vma(struct vm_area_struct *vma,
+		unsigned long start_addr, unsigned long end_addr,
+		struct zap_details *details)
+{
+	int need_break;
+
+	if (vma == details->restart_vma &&
+	    start_addr < details->restart_addr) {
+		/*
+		 * Be careful: this vm_area_struct may have been reused
+		 * meanwhile.  If pgoff matches up, it's probably the
+		 * same one (perhaps shrunk or extended), but no harm is
+		 * done if actually it's new.  If pgoff does not match,
+		 * it would likely be wrong to unmap from restart_addr,
+		 * but it must be new, so we can just mark it completed.
+		 */
+		start_addr = details->restart_addr;
+		if (linear_page_index(vma, start_addr) !=
+		    details->restart_pgoff || start_addr >= end_addr) {
+			vma->vm_truncate_count = details->truncate_count;
+			return 0;
+		}
+	}
+again:
+	details->break_addr = end_addr;
+	zap_page_range(vma, start_addr, end_addr - start_addr, details);
+
+	/*
+	 * We cannot rely on the break test in unmap_vmas:
+	 * on the one hand, we don't want to restart our loop
+	 * just because that broke out for the page_table_lock;
+	 * on the other hand, it does no test when vma is small.
+	 */
+	need_break = need_resched() ||
+			need_lockbreak(details->i_mmap_lock);
+
+	if (details->break_addr >= end_addr) {
+		/* We have now completed this vma: mark it so */
+		vma->vm_truncate_count = details->truncate_count;
+		if (!need_break)
+			return 0;
+	} else {
+		if (!need_break) {
+			start_addr = details->break_addr;
+			goto again;
+		}
+		details->restart_vma = vma;
+		details->restart_pgoff =
+			linear_page_index(vma, details->break_addr);
+		details->restart_addr = details->break_addr;
+	}
+
+	spin_unlock(details->i_mmap_lock);
+	cond_resched();
+	spin_lock(details->i_mmap_lock);
+	return -EINTR;
+}
+
 static inline void unmap_mapping_range_tree(struct prio_tree_root *root,
 					    struct zap_details *details)
 {
@@ -1198,8 +1318,13 @@ static inline void unmap_mapping_range_t
 	struct prio_tree_iter iter;
 	pgoff_t vba, vea, zba, zea;
 
+restart:
 	vma_prio_tree_foreach(vma, &iter, root,
 			details->first_index, details->last_index) {
+		/* Skip quickly over those we have already dealt with */
+		if (vma->vm_truncate_count == details->truncate_count)
+			continue;
+
 		vba = vma->vm_pgoff;
 		vea = vba + ((vma->vm_end - vma->vm_start) >> PAGE_SHIFT) - 1;
 		/* Assume for now that PAGE_CACHE_SHIFT == PAGE_SHIFT */
@@ -1209,9 +1334,12 @@ static inline void unmap_mapping_range_t
 		zea = details->last_index;
 		if (zea > vea)
 			zea = vea;
-		zap_page_range(vma,
+
+		if (unmap_mapping_range_vma(vma,
 			((zba - vba) << PAGE_SHIFT) + vma->vm_start,
-			(zea - zba + 1) << PAGE_SHIFT, details);
+			((zea - vba + 1) << PAGE_SHIFT) + vma->vm_start,
+				details) < 0)
+			goto restart;
 	}
 }
 
@@ -1226,10 +1354,15 @@ static inline void unmap_mapping_range_l
 	 * across *all* the pages in each nonlinear VMA, not just the pages
 	 * whose virtual address lies outside the file truncation point.
 	 */
+restart:
 	list_for_each_entry(vma, head, shared.vm_set.list) {
+		/* Skip quickly over those we have already dealt with */
+		if (vma->vm_truncate_count == details->truncate_count)
+			continue;
 		details->nonlinear_vma = vma;
-		zap_page_range(vma, vma->vm_start,
-				vma->vm_end - vma->vm_start, details);
+		if (unmap_mapping_range_vma(vma, vma->vm_start,
+					vma->vm_end, details) < 0)
+			goto restart;
 	}
 }
 
@@ -1268,13 +1401,20 @@ void unmap_mapping_range(struct address_
 	details.nonlinear_vma = NULL;
 	details.first_index = hba;
 	details.last_index = hba + hlen - 1;
-	details.atomic = 1;	/* A spinlock is held */
 	if (details.last_index < details.first_index)
 		details.last_index = ULONG_MAX;
+	details.i_mmap_lock = &mapping->i_mmap_lock;
+	details.restart_vma = NULL;
 
 	spin_lock(&mapping->i_mmap_lock);
-	/* Protect against page fault */
+
+	/* Protect against page faults, and endless unmapping loops */
 	mapping->truncate_count++;
+	if (unlikely(mapping->truncate_count == 0)) {
+		mapping->truncate_count++;
+		reset_vma_truncate_counts(mapping);
+	}
+	details.truncate_count = mapping->truncate_count;
 
 	if (unlikely(!prio_tree_empty(&mapping->i_mmap)))
 		unmap_mapping_range_tree(&mapping->i_mmap, &details);

