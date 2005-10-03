Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932680AbVJCTxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932680AbVJCTxq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 15:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932665AbVJCTxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 15:53:45 -0400
Received: from silver.veritas.com ([143.127.12.111]:28788 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932663AbVJCTxo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 15:53:44 -0400
Date: Mon, 3 Oct 2005 20:53:09 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Jay Lan <jlan@engr.sgi.com>
cc: Frank van Maarseveen <frankvm@frankvm.com>,
       Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
In-Reply-To: <433AD359.8070509@engr.sgi.com>
Message-ID: <Pine.LNX.4.61.0510032030320.13179@goblin.wat.veritas.com>
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com>
 <43319111.1050803@engr.sgi.com> <Pine.LNX.4.61.0509211802150.8880@goblin.wat.veritas.com>
 <4331990A.80904@engr.sgi.com> <Pine.LNX.4.61.0509211835190.9340@goblin.wat.veritas.com>
 <4331A0DA.5030801@engr.sgi.com> <20050921182627.GB17272@janus>
 <Pine.LNX.4.61.0509211958410.10449@goblin.wat.veritas.com>
 <4339AED4.8030108@engr.sgi.com> <Pine.LNX.4.61.0509281337420.6830@goblin.wat.veritas.com>
 <433AD359.8070509@engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 03 Oct 2005 19:53:44.0247 (UTC) FILETIME=[291C8470:01C5C854]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2005, Jay Lan wrote:
> 
> I am not concerned about do_munmap any more from updating
> hiwater_vm's concern since the total_vm gets decreased, not increased.

Many thanks for that remark, it inspired me to do the exact opposite!

> In case you are going to turn hiwater_vm update into a macro and hide it
> in a config flag, here is what i have that might be useful.

And thanks for your patch, which I've factored in with Frank's, and come
come up with the one below, against 2.6.14-rc2-mm2.  Which uses no CONFIG
flag: I think we're enough out of the fast paths that it's not needed.

See comment in fs/proc/task_mmu.c for the principle.  Could maintain
hiwater_vm straightforwardly, but I think it's easier to remember if
we handle them both in the same way.

I did look into doing the total_vm increment and calling vm_stat_account
in insert_vm_struct, but concluded it solved no particular problem, and
raised some questions (where architectures, notably ia64, have special
vmas which they may have good reason to leave out of total_vm).

I haven't cross-checked the mm_struct cacheline rearrangement yet,
it looks plausible, but could easily turn out to straddle boundaries.

Christoph, Frank, Jay: does this patch look like it fits your needs?

Hugh

--- 2.6.14-rc2-mm2/fs/compat.c	2005-09-21 12:16:40.000000000 +0100
+++ linux/fs/compat.c	2005-10-03 19:42:49.000000000 +0100
@@ -1490,7 +1490,6 @@ int compat_do_execve(char * filename,
 		/* execve success */
 		security_bprm_free(bprm);
 		acct_update_integrals(current);
-		update_mem_hiwater(current);
 		kfree(bprm);
 		return retval;
 	}
--- 2.6.14-rc2-mm2/fs/exec.c	2005-09-30 11:59:08.000000000 +0100
+++ linux/fs/exec.c	2005-10-03 19:42:49.000000000 +0100
@@ -1207,7 +1207,6 @@ int do_execve(char * filename,
 		/* execve success */
 		security_bprm_free(bprm);
 		acct_update_integrals(current);
-		update_mem_hiwater(current);
 		kfree(bprm);
 		return retval;
 	}
--- 2.6.14-rc2-mm2/fs/proc/task_mmu.c	2005-09-30 11:59:09.000000000 +0100
+++ linux/fs/proc/task_mmu.c	2005-10-03 19:42:49.000000000 +0100
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
--- 2.6.14-rc2-mm2/include/linux/mm.h	2005-09-30 11:59:11.000000000 +0100
+++ linux/include/linux/mm.h	2005-10-03 19:42:49.000000000 +0100
@@ -945,9 +945,6 @@ static inline void vm_stat_account(struc
 }
 #endif /* CONFIG_PROC_FS */
 
-/* update per process rss and vm hiwater data */
-extern void update_mem_hiwater(struct task_struct *tsk);
-
 #ifndef CONFIG_DEBUG_PAGEALLOC
 static inline void
 kernel_map_pages(struct page *page, int numpages, int enable)
--- 2.6.14-rc2-mm2/include/linux/sched.h	2005-09-30 11:59:11.000000000 +0100
+++ linux/include/linux/sched.h	2005-10-03 19:42:49.000000000 +0100
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
@@ -270,16 +280,19 @@ struct mm_struct {
 						 * by mmlist_lock
 						 */
 
-	unsigned long start_code, end_code, start_data, end_data;
-	unsigned long start_brk, brk, start_stack;
-	unsigned long arg_start, arg_end, env_start, env_end;
-	unsigned long total_vm, locked_vm, shared_vm;
-	unsigned long exec_vm, stack_vm, reserved_vm, def_flags, nr_ptes;
-
 	/* Special counters protected by the page_table_lock */
 	mm_counter_t _file_rss;
 	mm_counter_t _anon_rss;
 
+	unsigned long hiwater_rss;	/* High-watermark of RSS usage */
+	unsigned long hiwater_vm;	/* High-water virtual memory usage */
+
+	unsigned long total_vm, locked_vm, shared_vm, exec_vm;
+	unsigned long stack_vm, reserved_vm, def_flags, nr_ptes;
+	unsigned long start_code, end_code, start_data, end_data;
+	unsigned long start_brk, brk, start_stack;
+	unsigned long arg_start, arg_end, env_start, env_end;
+
 	unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */
 
 	unsigned dumpable:2;
@@ -299,11 +312,7 @@ struct mm_struct {
 	/* aio bits */
 	rwlock_t		ioctx_list_lock;
 	struct kioctx		*ioctx_list;
-
 	struct kioctx		default_kioctx;
-
-	unsigned long hiwater_rss;	/* High-water RSS usage */
-	unsigned long hiwater_vm;	/* High-water virtual memory usage */
 };
 
 struct sighand_struct {
--- 2.6.14-rc2-mm2/kernel/exit.c	2005-09-30 11:59:12.000000000 +0100
+++ linux/kernel/exit.c	2005-10-03 19:42:49.000000000 +0100
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
--- 2.6.14-rc2-mm2/kernel/sched.c	2005-09-30 11:59:12.000000000 +0100
+++ linux/kernel/sched.c	2005-10-03 19:42:49.000000000 +0100
@@ -2603,8 +2603,6 @@ void account_system_time(struct task_str
 		cpustat->idle = cputime64_add(cpustat->idle, tmp);
 	/* Account for system time used */
 	acct_update_integrals(p);
-	/* Update rss highwater mark */
-	update_mem_hiwater(p);
 }
 
 /*
--- 2.6.14-rc2-mm2/mm/fremap.c	2005-09-30 11:59:12.000000000 +0100
+++ linux/mm/fremap.c	2005-10-03 19:42:49.000000000 +0100
@@ -20,13 +20,12 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
-static inline void zap_pte(struct mm_struct *mm, struct vm_area_struct *vma,
+static int zap_pte(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, pte_t *ptep)
 {
 	pte_t pte = *ptep;
+	int did_zap_file_pte = 0;
 
-	if (pte_none(pte))
-		return;
 	if (pte_present(pte)) {
 		unsigned long pfn = pte_pfn(pte);
 
@@ -39,7 +38,7 @@ static inline void zap_pte(struct mm_str
 					set_page_dirty(page);
 				page_remove_rmap(page);
 				page_cache_release(page);
-				dec_mm_counter(mm, file_rss);
+				did_zap_file_pte = 1;
 			}
 		}
 	} else {
@@ -47,6 +46,8 @@ static inline void zap_pte(struct mm_str
 			free_swap_and_cache(pte_to_swp_entry(pte));
 		pte_clear(mm, addr, ptep);
 	}
+
+	return did_zap_file_pte;
 }
 
 /*
@@ -90,9 +91,9 @@ int install_page(struct mm_struct *mm, s
 	if (!page->mapping || page->index >= size)
 		goto err_unlock;
 
-	zap_pte(mm, vma, addr, pte);
+	if (pte_none(*pte) || !zap_pte(mm, vma, addr, pte))
+		inc_mm_counter(mm, file_rss);
 
-	inc_mm_counter(mm, file_rss);
 	flush_icache_page(vma, page);
 	set_pte_at(mm, addr, pte, mk_pte(page, prot));
 	page_add_file_rmap(page);
@@ -137,7 +138,10 @@ int install_file_pte(struct mm_struct *m
 	if (!pte)
 		goto err_unlock;
 
-	zap_pte(mm, vma, addr, pte);
+	if (!pte_none(*pte) && zap_pte(mm, vma, addr, pte)) {
+		update_hiwater_rss(mm);
+		dec_mm_counter(mm, file_rss);
+	}
 
 	set_pte_at(mm, addr, pte, pgoff_to_pte(pgoff));
 	pte_val = *pte;
--- 2.6.14-rc2-mm2/mm/hugetlb.c	2005-09-30 11:59:12.000000000 +0100
+++ linux/mm/hugetlb.c	2005-10-03 19:42:49.000000000 +0100
@@ -309,6 +309,9 @@ void unmap_hugepage_range(struct vm_area
 	BUG_ON(start & ~HPAGE_MASK);
 	BUG_ON(end & ~HPAGE_MASK);
 
+	/* Update high watermark before we lower rss */
+	update_hiwater_rss(mm);
+
 	for (address = start; address < end; address += HPAGE_SIZE) {
 		ptep = huge_pte_offset(mm, address);
 		if (! ptep)
--- 2.6.14-rc2-mm2/mm/memory.c	2005-09-30 11:59:12.000000000 +0100
+++ linux/mm/memory.c	2005-10-03 19:42:49.000000000 +0100
@@ -800,6 +800,7 @@ unsigned long zap_page_range(struct vm_a
 	lru_add_drain();
 	spin_lock(&mm->page_table_lock);
 	tlb = tlb_gather_mmu(mm, 0);
+	update_hiwater_rss(mm);
 	end = unmap_vmas(&tlb, mm, vma, address, end, &nr_accounted, details);
 	tlb_finish_mmu(tlb, address, end);
 	spin_unlock(&mm->page_table_lock);
@@ -2205,22 +2206,6 @@ unsigned long vmalloc_to_pfn(void * vmal
 
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
--- 2.6.14-rc2-mm2/mm/mmap.c	2005-09-30 11:59:12.000000000 +0100
+++ linux/mm/mmap.c	2005-10-03 19:42:49.000000000 +0100
@@ -1625,6 +1625,8 @@ find_extend_vma(struct mm_struct * mm, u
  */
 static void remove_vma_list(struct mm_struct *mm, struct vm_area_struct *vma)
 {
+	/* Update high watermark before we lower total_vm */
+	update_hiwater_vm(mm);
 	do {
 		long nrpages = vma_pages(vma);
 
@@ -1653,6 +1655,7 @@ static void unmap_region(struct mm_struc
 	lru_add_drain();
 	spin_lock(&mm->page_table_lock);
 	tlb = tlb_gather_mmu(mm, 0);
+	update_hiwater_rss(mm);
 	unmap_vmas(&tlb, mm, vma, start, end, &nr_accounted, NULL);
 	vm_unacct_memory(nr_accounted);
 	free_pgtables(&tlb, vma, prev? prev->vm_end: FIRST_USER_ADDRESS,
@@ -1938,6 +1941,7 @@ void exit_mmap(struct mm_struct *mm)
 
 	flush_cache_mm(mm);
 	tlb = tlb_gather_mmu(mm, 1);
+	/* Don't update_hiwater_rss(mm) here, do_exit already did */
 	/* Use -1 here to ensure all VMAs in the mm are unmapped */
 	end = unmap_vmas(&tlb, mm, vma, 0, -1, &nr_accounted, NULL);
 	vm_unacct_memory(nr_accounted);
--- 2.6.14-rc2-mm2/mm/mremap.c	2005-09-30 11:59:12.000000000 +0100
+++ linux/mm/mremap.c	2005-10-03 19:42:49.000000000 +0100
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
--- 2.6.14-rc2-mm2/mm/nommu.c	2005-09-30 11:59:12.000000000 +0100
+++ linux/mm/nommu.c	2005-10-03 19:42:49.000000000 +0100
@@ -239,6 +239,7 @@ void vunmap(void *addr)
 asmlinkage unsigned long sys_brk(unsigned long brk)
 {
 	struct mm_struct *mm = current->mm;
+	long grow;
 
 	if (brk < mm->start_brk || brk > mm->context.end_brk)
 		return mm->brk;
@@ -246,6 +247,12 @@ asmlinkage unsigned long sys_brk(unsigne
 	if (mm->brk == brk)
 		return mm->brk;
 
+	/* Update high watermark before we may lower total_vm */
+	update_hiwater_vm(mm);
+
+	grow = PAGE_ALIGN(brk) - PAGE_ALIGN(mm->brk);
+	mm->total_vm += grow / PAGE_SIZE;
+
 	/*
 	 * Always allow shrinking brk
 	 */
@@ -679,6 +686,7 @@ unsigned long do_mmap_pgoff(struct file 
 			    unsigned long flags,
 			    unsigned long pgoff)
 {
+	struct mm_struct *mm = current->mm;
 	struct vm_list_struct *vml = NULL;
 	struct vm_area_struct *vma = NULL;
 	struct rb_node *rb;
@@ -813,7 +821,7 @@ unsigned long do_mmap_pgoff(struct file 
 	realalloc += kobjsize(vma);
 	askedalloc += sizeof(*vma);
 
-	current->mm->total_vm += len >> PAGE_SHIFT;
+	mm->total_vm += len >> PAGE_SHIFT;
 
 	add_nommu_vma(vma);
 
@@ -821,8 +829,8 @@ unsigned long do_mmap_pgoff(struct file 
 	realalloc += kobjsize(vml);
 	askedalloc += sizeof(*vml);
 
-	vml->next = current->mm->context.vmlist;
-	current->mm->context.vmlist = vml;
+	vml->next = mm->context.vmlist;
+	mm->context.vmlist = vml;
 
 	up_write(&nommu_vma_sem);
 
@@ -1075,19 +1083,6 @@ void arch_unmap_area(struct mm_struct *m
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
--- 2.6.14-rc2-mm2/mm/rmap.c	2005-09-30 11:59:12.000000000 +0100
+++ linux/mm/rmap.c	2005-10-03 19:42:49.000000000 +0100
@@ -543,6 +543,9 @@ static int try_to_unmap_one(struct page 
 	if (pte_dirty(pteval))
 		set_page_dirty(page);
 
+	/* Update high watermark before we lower rss */
+	update_hiwater_rss(mm);
+
 	if (PageAnon(page)) {
 		swp_entry_t entry = { .val = page->private };
 		/*
@@ -633,6 +636,9 @@ static void try_to_unmap_cluster(unsigne
 	if (!pmd_present(*pmd))
 		goto out_unlock;
 
+	/* Update high watermark before we lower rss */
+	update_hiwater_rss(mm);
+
 	for (original_pte = pte = pte_offset_map(pmd, address);
 			address < end; pte++, address += PAGE_SIZE) {
 
