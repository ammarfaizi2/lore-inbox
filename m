Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbUJXP7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbUJXP7I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 11:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbUJXP5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 11:57:04 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:1328 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261534AbUJXPuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 11:50:25 -0400
Date: Sun, 24 Oct 2004 16:49:48 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@novell.com>, William Irwin <wli@holomorphy.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] statm: shared = rss - anon_rss
In-Reply-To: <Pine.LNX.4.44.0410241644000.12023-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0410241647080.12023-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The third "shared" field of /proc/$pid/statm in 2.4 was a count of pages
in the mm whose page_count is more than 1 (oddly, including pages shared
just with swapcache).  That's too costly to calculate each time, so 2.6
changed it to the total file-backed extent.  But Andrea knows apps and
users surprised when (rss - shared) goes negative: we need to provide
an rss-like statistic, close to the 2.4 interpretation.

Something that's quick and easy to maintain accurately is mm->anon_rss,
the count of anonymous pages in the mm.  Then shared = rss - anon_rss
gives a pretty good and meaningful approximation to 2.4's intention:
wli confirms that this will be useful to Oracle too.

Where to show it?  I think it's best to treat this as a bugfix and show
it in the third field of /proc/$pid/statm, after resident, as before -
there's no evidence that the total file-backed extent was found useful.

Albert would like other fields to revert to page counts, but that's a
lot harder: if mprotect can change the category of a page, then it can't
be accounted as simply as this.  Only go that route if real need shown.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---
 fs/proc/task_mmu.c    |    2 +-
 include/linux/sched.h |    4 ++--
 kernel/fork.c         |    1 +
 mm/memory.c           |    8 +++++++-
 mm/rmap.c             |    3 +++
 5 files changed, 14 insertions(+), 4 deletions(-)

--- 2.6.10-rc1/fs/proc/task_mmu.c	2004-10-23 12:44:06.000000000 +0100
+++ linux/fs/proc/task_mmu.c	2004-10-23 20:43:24.000000000 +0100
@@ -37,7 +37,7 @@ unsigned long task_vsize(struct mm_struc
 int task_statm(struct mm_struct *mm, int *shared, int *text,
 	       int *data, int *resident)
 {
-	*shared = mm->shared_vm;
+	*shared = mm->rss - mm->anon_rss;
 	*text = (PAGE_ALIGN(mm->end_code) - (mm->start_code & PAGE_MASK))
 								>> PAGE_SHIFT;
 	*data = mm->total_vm - mm->shared_vm;
--- 2.6.10-rc1/include/linux/sched.h	2004-10-23 12:44:11.000000000 +0100
+++ linux/include/linux/sched.h	2004-10-23 20:43:24.000000000 +0100
@@ -216,7 +216,7 @@ struct mm_struct {
 	atomic_t mm_count;			/* How many references to "struct mm_struct" (users count as 1) */
 	int map_count;				/* number of VMAs */
 	struct rw_semaphore mmap_sem;
-	spinlock_t page_table_lock;		/* Protects task page tables and mm->rss */
+	spinlock_t page_table_lock;		/* Protects page tables, mm->rss, mm->anon_rss */
 
 	struct list_head mmlist;		/* List of maybe swapped mm's.  These are globally strung
 						 * together off init_mm.mmlist, and are protected
@@ -226,7 +226,7 @@ struct mm_struct {
 	unsigned long start_code, end_code, start_data, end_data;
 	unsigned long start_brk, brk, start_stack;
 	unsigned long arg_start, arg_end, env_start, env_end;
-	unsigned long rss, total_vm, locked_vm, shared_vm;
+	unsigned long rss, anon_rss, total_vm, locked_vm, shared_vm;
 	unsigned long exec_vm, stack_vm, reserved_vm, def_flags, nr_ptes;
 
 	unsigned long saved_auxv[42]; /* for /proc/PID/auxv */
--- 2.6.10-rc1/kernel/fork.c	2004-10-23 12:44:12.000000000 +0100
+++ linux/kernel/fork.c	2004-10-23 20:43:24.000000000 +0100
@@ -173,6 +173,7 @@ static inline int dup_mmap(struct mm_str
 	mm->free_area_cache = oldmm->mmap_base;
 	mm->map_count = 0;
 	mm->rss = 0;
+	mm->anon_rss = 0;
 	cpus_clear(mm->cpu_vm_mask);
 	mm->mm_rb = RB_ROOT;
 	rb_link = &mm->mm_rb.rb_node;
--- 2.6.10-rc1/mm/memory.c	2004-10-23 12:44:13.000000000 +0100
+++ linux/mm/memory.c	2004-10-23 20:43:24.000000000 +0100
@@ -334,6 +334,8 @@ skip_copy_pte_range:
 				pte = pte_mkold(pte);
 				get_page(page);
 				dst->rss++;
+				if (PageAnon(page))
+					dst->anon_rss++;
 				set_pte(dst_pte, pte);
 				page_dup_rmap(page);
 cont_copy_pte_range_noset:
@@ -424,7 +426,9 @@ static void zap_pte_range(struct mmu_gat
 				set_pte(ptep, pgoff_to_pte(page->index));
 			if (pte_dirty(pte))
 				set_page_dirty(page);
-			if (pte_young(pte) && !PageAnon(page))
+			if (PageAnon(page))
+				tlb->mm->anon_rss--;
+			else if (pte_young(pte))
 				mark_page_accessed(page);
 			tlb->freed++;
 			page_remove_rmap(page);
@@ -1109,6 +1113,8 @@ static int do_wp_page(struct mm_struct *
 	spin_lock(&mm->page_table_lock);
 	page_table = pte_offset_map(pmd, address);
 	if (likely(pte_same(*page_table, pte))) {
+		if (PageAnon(old_page))
+			mm->anon_rss--;
 		if (PageReserved(old_page))
 			++mm->rss;
 		else
--- 2.6.10-rc1/mm/rmap.c	2004-10-23 12:44:13.000000000 +0100
+++ linux/mm/rmap.c	2004-10-23 20:43:24.000000000 +0100
@@ -432,6 +432,8 @@ void page_add_anon_rmap(struct page *pag
 	BUG_ON(PageReserved(page));
 	BUG_ON(!anon_vma);
 
+	vma->vm_mm->anon_rss++;
+
 	anon_vma = (void *) anon_vma + PAGE_MAPPING_ANON;
 	index = (address - vma->vm_start) >> PAGE_SHIFT;
 	index += vma->vm_pgoff;
@@ -584,6 +586,7 @@ static int try_to_unmap_one(struct page 
 		}
 		set_pte(pte, swp_entry_to_pte(entry));
 		BUG_ON(pte_file(*pte));
+		mm->anon_rss--;
 	}
 
 	mm->rss--;

