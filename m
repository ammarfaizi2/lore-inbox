Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbVJMAvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbVJMAvh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 20:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbVJMAvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 20:51:37 -0400
Received: from gold.veritas.com ([143.127.12.110]:11538 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932458AbVJMAvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 20:51:36 -0400
Date: Thu, 13 Oct 2005 01:50:45 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Christoph Lameter <clameter@engr.sgi.com>,
       Frank van Maarseveen <frankvm@frankvm.com>, Jay Lan <jlan@engr.sgi.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 06/21] mm: update_hiwaters just in time
In-Reply-To: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0510130148350.4060@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Oct 2005 00:51:36.0149 (UTC) FILETIME=[43501850:01C5CF90]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

update_mem_hiwater has attracted various criticisms, in particular from
those concerned with mm scalability.  Originally it was called whenever
rss or total_vm got raised.  Then many of those callsites were replaced
by a timer tick call from account_system_time.  Now Frank van Maarseveen
reports that to be found inadequate.  How about this?  Works for Frank.

Replace update_mem_hiwater, a poor combination of two unrelated ops, by
macros update_hiwater_rss and update_hiwater_vm.  Don't attempt to keep
mm->hiwater_rss up to date at timer tick, nor every time we raise rss
(usually by 1): those are hot paths.  Do the opposite, update only when
about to lower rss (usually by many), or just before final accounting in
do_exit.  Handle mm->hiwater_vm in the same way, though it's much less
of an issue.  Demand that whoever collects these hiwater statistics do
the work of taking the maximum with rss or total_vm.

And there has been no collector of these hiwater statistics in the tree.
The new convention needs an example, so match Frank's usage by adding a
VmPeak line above VmSize to /proc/<pid>/status, and also a VmHWM line
above VmRSS (High-Water-Mark or High-Water-Memory).

There was a particular anomaly during mremap move, that hiwater_vm might
be captured too high.  A fleeting such anomaly remains, but it's quickly
corrected now, whereas before it would stick.

What locking?  None: if the app is racy then these statistics will be
racy, it's not worth any overhead to make them exact.  But whenever it
suits, hiwater_vm is updated under exclusive mmap_sem, and hiwater_rss
under page_table_lock (for now) or with preemption disabled (later on):
without going to any trouble, minimize the time between reading current
values and updating, to minimize those occasions when a racing thread
bumps a count up and back down in between.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 fs/compat.c           |    1 -
 fs/exec.c             |    1 -
 fs/proc/task_mmu.c    |   23 +++++++++++++++++++++--
 include/linux/mm.h    |    3 ---
 include/linux/sched.h |   10 ++++++++++
 kernel/exit.c         |    5 ++++-
 kernel/sched.c        |    2 --
 mm/fremap.c           |    4 +++-
 mm/hugetlb.c          |    3 +++
 mm/memory.c           |   17 +----------------
 mm/mmap.c             |    4 ++++
 mm/mremap.c           |   12 ++++++++++--
 mm/nommu.c            |   15 ++-------------
 mm/rmap.c             |    6 ++++++
 14 files changed, 64 insertions(+), 42 deletions(-)

--- mm05/fs/compat.c	2005-09-21 12:16:40.000000000 +0100
+++ mm06/fs/compat.c	2005-10-11 23:54:32.000000000 +0100
@@ -1490,7 +1490,6 @@ int compat_do_execve(char * filename,
 		/* execve success */
 		security_bprm_free(bprm);
 		acct_update_integrals(current);
-		update_mem_hiwater(current);
 		kfree(bprm);
 		return retval;
 	}
--- mm05/fs/exec.c	2005-09-30 11:59:08.000000000 +0100
+++ mm06/fs/exec.c	2005-10-11 23:54:33.000000000 +0100
@@ -1207,7 +1207,6 @@ int do_execve(char * filename,
 		/* execve success */
 		security_bprm_free(bprm);
 		acct_update_integrals(current);
-		update_mem_hiwater(current);
 		kfree(bprm);
 		return retval;
 	}
--- mm05/fs/proc/task_mmu.c	2005-09-30 11:59:09.000000000 +0100
+++ mm06/fs/proc/task_mmu.c	2005-10-11 23:54:33.000000000 +0100
@@ -14,22 +14,41 @@
 char *task_mem(struct mm_struct *mm, char *buffer)
 {
 	unsigned long data, text, lib;
+	unsigned long hiwater_vm, total_vm, hiwater_rss, total_rss;
 
+	/*
+	 * Note: to minimize their overhead, mm maintains hiwater_vm and
+	 * hiwater_rss only when about to *lower* total_vm or rss.  Any
+	 * collector of these hiwater stats must therefore get total_vm
+	 * and rss too, which will usually be the higher.  Barriers? not
+	 * worth the effort, such snapshots can always be inconsistent.
+	 */
+	hiwater_vm = total_vm = mm->total_vm;
+	if (hiwater_vm < mm->hiwater_vm)
+		hiwater_vm = mm->hiwater_vm;
+	hiwater_rss = total_rss = get_mm_rss(mm);
+	if (hiwater_rss < mm->hiwater_rss)
+		hiwater_rss = mm->hiwater_rss;
+	
 	data = mm->total_vm - mm->shared_vm - mm->stack_vm;
 	text = (PAGE_ALIGN(mm->end_code) - (mm->start_code & PAGE_MASK)) >> 10;
 	lib = (mm->exec_vm << (PAGE_SHIFT-10)) - text;
 	buffer += sprintf(buffer,
+		"VmPeak:\t%8lu kB\n"
 		"VmSize:\t%8lu kB\n"
 		"VmLck:\t%8lu kB\n"
+		"VmHWM:\t%8lu kB\n"
 		"VmRSS:\t%8lu kB\n"
 		"VmData:\t%8lu kB\n"
 		"VmStk:\t%8lu kB\n"
 		"VmExe:\t%8lu kB\n"
 		"VmLib:\t%8lu kB\n"
 		"VmPTE:\t%8lu kB\n",
-		(mm->total_vm - mm->reserved_vm) << (PAGE_SHIFT-10),
+		hiwater_vm << (PAGE_SHIFT-10),
+		(total_vm - mm->reserved_vm) << (PAGE_SHIFT-10),
 		mm->locked_vm << (PAGE_SHIFT-10),
-		get_mm_rss(mm) << (PAGE_SHIFT-10),
+		hiwater_rss << (PAGE_SHIFT-10),
+		total_rss << (PAGE_SHIFT-10),
 		data << (PAGE_SHIFT-10),
 		mm->stack_vm << (PAGE_SHIFT-10), text, lib,
 		(PTRS_PER_PTE*sizeof(pte_t)*mm->nr_ptes) >> 10);
--- mm05/include/linux/mm.h	2005-10-11 12:16:50.000000000 +0100
+++ mm06/include/linux/mm.h	2005-10-11 23:54:33.000000000 +0100
@@ -946,9 +946,6 @@ static inline void vm_stat_account(struc
 }
 #endif /* CONFIG_PROC_FS */
 
-/* update per process rss and vm hiwater data */
-extern void update_mem_hiwater(struct task_struct *tsk);
-
 #ifndef CONFIG_DEBUG_PAGEALLOC
 static inline void
 kernel_map_pages(struct page *page, int numpages, int enable)
--- mm05/include/linux/sched.h	2005-09-30 11:59:11.000000000 +0100
+++ mm06/include/linux/sched.h	2005-10-11 23:54:33.000000000 +0100
@@ -245,6 +245,16 @@ extern void arch_unmap_area_topdown(stru
 #define dec_mm_counter(mm, member) (mm)->_##member--
 #define get_mm_rss(mm) ((mm)->_file_rss + (mm)->_anon_rss)
 
+#define update_hiwater_rss(mm)	do {			\
+	unsigned long _rss = get_mm_rss(mm);		\
+	if ((mm)->hiwater_rss < _rss)			\
+		(mm)->hiwater_rss = _rss;		\
+} while (0)
+#define update_hiwater_vm(mm)	do {			\
+	if ((mm)->hiwater_vm < (mm)->total_vm)		\
+		(mm)->hiwater_vm = (mm)->total_vm;	\
+} while (0)
+
 typedef unsigned long mm_counter_t;
 
 struct mm_struct {
--- mm05/kernel/exit.c	2005-09-30 11:59:12.000000000 +0100
+++ mm06/kernel/exit.c	2005-10-11 23:54:33.000000000 +0100
@@ -839,7 +839,10 @@ fastcall NORET_TYPE void do_exit(long co
 				preempt_count());
 
 	acct_update_integrals(tsk);
-	update_mem_hiwater(tsk);
+	if (tsk->mm) {
+		update_hiwater_rss(tsk->mm);
+		update_hiwater_vm(tsk->mm);
+	}
 	group_dead = atomic_dec_and_test(&tsk->signal->live);
 	if (group_dead) {
  		del_timer_sync(&tsk->signal->real_timer);
--- mm05/kernel/sched.c	2005-09-30 11:59:12.000000000 +0100
+++ mm06/kernel/sched.c	2005-10-11 23:54:33.000000000 +0100
@@ -2603,8 +2603,6 @@ void account_system_time(struct task_str
 		cpustat->idle = cputime64_add(cpustat->idle, tmp);
 	/* Account for system time used */
 	acct_update_integrals(p);
-	/* Update rss highwater mark */
-	update_mem_hiwater(p);
 }
 
 /*
--- mm05/mm/fremap.c	2005-10-11 23:54:15.000000000 +0100
+++ mm06/mm/fremap.c	2005-10-11 23:54:33.000000000 +0100
@@ -140,8 +140,10 @@ int install_file_pte(struct mm_struct *m
 	if (!pte)
 		goto err_unlock;
 
-	if (!pte_none(*pte) && zap_pte(mm, vma, addr, pte))
+	if (!pte_none(*pte) && zap_pte(mm, vma, addr, pte)) {
+		update_hiwater_rss(mm);
 		dec_mm_counter(mm, file_rss);
+	}
 
 	set_pte_at(mm, addr, pte, pgoff_to_pte(pgoff));
 	pte_val = *pte;
--- mm05/mm/hugetlb.c	2005-09-30 11:59:12.000000000 +0100
+++ mm06/mm/hugetlb.c	2005-10-11 23:54:33.000000000 +0100
@@ -309,6 +309,9 @@ void unmap_hugepage_range(struct vm_area
 	BUG_ON(start & ~HPAGE_MASK);
 	BUG_ON(end & ~HPAGE_MASK);
 
+	/* Update high watermark before we lower rss */
+	update_hiwater_rss(mm);
+
 	for (address = start; address < end; address += HPAGE_SIZE) {
 		ptep = huge_pte_offset(mm, address);
 		if (! ptep)
--- mm05/mm/memory.c	2005-10-11 23:53:35.000000000 +0100
+++ mm06/mm/memory.c	2005-10-11 23:54:33.000000000 +0100
@@ -820,6 +820,7 @@ unsigned long zap_page_range(struct vm_a
 	lru_add_drain();
 	spin_lock(&mm->page_table_lock);
 	tlb = tlb_gather_mmu(mm, 0);
+	update_hiwater_rss(mm);
 	end = unmap_vmas(&tlb, mm, vma, address, end, &nr_accounted, details);
 	tlb_finish_mmu(tlb, address, end);
 	spin_unlock(&mm->page_table_lock);
@@ -2225,22 +2226,6 @@ unsigned long vmalloc_to_pfn(void * vmal
 
 EXPORT_SYMBOL(vmalloc_to_pfn);
 
-/*
- * update_mem_hiwater
- *	- update per process rss and vm high water data
- */
-void update_mem_hiwater(struct task_struct *tsk)
-{
-	if (tsk->mm) {
-		unsigned long rss = get_mm_rss(tsk->mm);
-
-		if (tsk->mm->hiwater_rss < rss)
-			tsk->mm->hiwater_rss = rss;
-		if (tsk->mm->hiwater_vm < tsk->mm->total_vm)
-			tsk->mm->hiwater_vm = tsk->mm->total_vm;
-	}
-}
-
 #if !defined(__HAVE_ARCH_GATE_AREA)
 
 #if defined(AT_SYSINFO_EHDR)
--- mm05/mm/mmap.c	2005-10-11 12:16:50.000000000 +0100
+++ mm06/mm/mmap.c	2005-10-11 23:54:33.000000000 +0100
@@ -1636,6 +1636,8 @@ find_extend_vma(struct mm_struct * mm, u
  */
 static void remove_vma_list(struct mm_struct *mm, struct vm_area_struct *vma)
 {
+	/* Update high watermark before we lower total_vm */
+	update_hiwater_vm(mm);
 	do {
 		long nrpages = vma_pages(vma);
 
@@ -1664,6 +1666,7 @@ static void unmap_region(struct mm_struc
 	lru_add_drain();
 	spin_lock(&mm->page_table_lock);
 	tlb = tlb_gather_mmu(mm, 0);
+	update_hiwater_rss(mm);
 	unmap_vmas(&tlb, mm, vma, start, end, &nr_accounted, NULL);
 	vm_unacct_memory(nr_accounted);
 	free_pgtables(&tlb, vma, prev? prev->vm_end: FIRST_USER_ADDRESS,
@@ -1949,6 +1952,7 @@ void exit_mmap(struct mm_struct *mm)
 
 	flush_cache_mm(mm);
 	tlb = tlb_gather_mmu(mm, 1);
+	/* Don't update_hiwater_rss(mm) here, do_exit already did */
 	/* Use -1 here to ensure all VMAs in the mm are unmapped */
 	end = unmap_vmas(&tlb, mm, vma, 0, -1, &nr_accounted, NULL);
 	vm_unacct_memory(nr_accounted);
--- mm05/mm/mremap.c	2005-10-11 23:53:55.000000000 +0100
+++ mm06/mm/mremap.c	2005-10-11 23:54:33.000000000 +0100
@@ -167,6 +167,7 @@ static unsigned long move_vma(struct vm_
 	unsigned long new_pgoff;
 	unsigned long moved_len;
 	unsigned long excess = 0;
+	unsigned long hiwater_vm;
 	int split = 0;
 
 	/*
@@ -205,9 +206,15 @@ static unsigned long move_vma(struct vm_
 	}
 
 	/*
-	 * if we failed to move page tables we still do total_vm increment
-	 * since do_munmap() will decrement it by old_len == new_len
+	 * If we failed to move page tables we still do total_vm increment
+	 * since do_munmap() will decrement it by old_len == new_len.
+	 *
+	 * Since total_vm is about to be raised artificially high for a
+	 * moment, we need to restore high watermark afterwards: if stats
+	 * are taken meanwhile, total_vm and hiwater_vm appear too high.
+	 * If this were a serious issue, we'd add a flag to do_munmap().
 	 */
+	hiwater_vm = mm->hiwater_vm;
 	mm->total_vm += new_len >> PAGE_SHIFT;
 	vm_stat_account(mm, vma->vm_flags, vma->vm_file, new_len>>PAGE_SHIFT);
 
@@ -216,6 +223,7 @@ static unsigned long move_vma(struct vm_
 		vm_unacct_memory(excess >> PAGE_SHIFT);
 		excess = 0;
 	}
+	mm->hiwater_vm = hiwater_vm;
 
 	/* Restore VM_ACCOUNT if one or two pieces of vma left */
 	if (excess) {
--- mm05/mm/nommu.c	2005-09-30 11:59:12.000000000 +0100
+++ mm06/mm/nommu.c	2005-10-11 23:54:33.000000000 +0100
@@ -928,6 +928,8 @@ int do_munmap(struct mm_struct *mm, unsi
 	realalloc -= kobjsize(vml);
 	askedalloc -= sizeof(*vml);
 	kfree(vml);
+
+	update_hiwater_vm(mm);
 	mm->total_vm -= len >> PAGE_SHIFT;
 
 #ifdef DEBUG
@@ -1075,19 +1077,6 @@ void arch_unmap_area(struct mm_struct *m
 {
 }
 
-void update_mem_hiwater(struct task_struct *tsk)
-{
-	unsigned long rss;
-
-	if (likely(tsk->mm)) {
-		rss = get_mm_rss(tsk->mm);
-		if (tsk->mm->hiwater_rss < rss)
-			tsk->mm->hiwater_rss = rss;
-		if (tsk->mm->hiwater_vm < tsk->mm->total_vm)
-			tsk->mm->hiwater_vm = tsk->mm->total_vm;
-	}
-}
-
 void unmap_mapping_range(struct address_space *mapping,
 			 loff_t const holebegin, loff_t const holelen,
 			 int even_cows)
--- mm05/mm/rmap.c	2005-10-11 12:16:50.000000000 +0100
+++ mm06/mm/rmap.c	2005-10-11 23:54:33.000000000 +0100
@@ -538,6 +538,9 @@ static int try_to_unmap_one(struct page 
 	if (pte_dirty(pteval))
 		set_page_dirty(page);
 
+	/* Update high watermark before we lower rss */
+	update_hiwater_rss(mm);
+
 	if (PageAnon(page)) {
 		swp_entry_t entry = { .val = page->private };
 		/*
@@ -628,6 +631,9 @@ static void try_to_unmap_cluster(unsigne
 	if (!pmd_present(*pmd))
 		goto out_unlock;
 
+	/* Update high watermark before we lower rss */
+	update_hiwater_rss(mm);
+
 	for (original_pte = pte = pte_offset_map(pmd, address);
 			address < end; pte++, address += PAGE_SIZE) {
 
