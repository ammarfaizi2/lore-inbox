Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVCKTUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVCKTUD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 14:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVCKTSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 14:18:23 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:38613 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261253AbVCKTEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 14:04:48 -0500
Date: Fri, 11 Mar 2005 11:04:23 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Dave Jones <davej@redhat.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@osdl.org
Subject: Re: [PATCH] mm counter operations through macros
In-Reply-To: <20050311182500.GA4185@redhat.com>
Message-ID: <Pine.LNX.4.58.0503111103200.22240@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503110422150.19280@schroedinger.engr.sgi.com>
 <20050311182500.GA4185@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2005, Dave Jones wrote:

> Splitting this last one into inc_mm_counter() and dec_mm_counter()
> means you can kill off the last argument, and get some of the
> readability back. As it stands, I think this patch adds a bunch
> of obfuscation for no clear benefit.

Ok.
-----------------------------------------------------------------
This patch extracts all the operations on counters protected by the
page table lock (currently rss and anon_rss) into definitions in
include/linux/sched.h. All rss operations are performed through
the following macros:

get_mm_counter(mm, member)		-> Obtain the value of a counter
set_mm_counter(mm, member, value)	-> Set the value of a counter
update_mm_counter(mm, member, value)	-> Add to a counter
inc_mm_counter(mm, member)		-> Increment a counter
dec_mm_counter(mm, member)		-> Decrement a counter

With this patch it becomes easier to add new counters and it is possible
to redefine the method of counter handling. The counters are an
issue for scalability since they are used in frequently used code paths and
may cause cache line bouncing.

F.e. One may not use counters at all and count the pages when needed, switch
to atomic operations if the mm_struct locking changes or split the rss
into counters that can be locally incremented.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.11/include/linux/sched.h
===================================================================
--- linux-2.6.11.orig/include/linux/sched.h	2005-03-11 10:29:17.000000000 -0800
+++ linux-2.6.11/include/linux/sched.h	2005-03-11 10:57:59.000000000 -0800
@@ -205,6 +205,12 @@ arch_get_unmapped_area_topdown(struct fi
 extern void arch_unmap_area(struct vm_area_struct *area);
 extern void arch_unmap_area_topdown(struct vm_area_struct *area);

+#define set_mm_counter(mm, member, value) (mm)->member = (value)
+#define get_mm_counter(mm, member) ((mm)->member)
+#define update_mm_counter(mm, member, value) (mm)->member += (value)
+#define inc_mm_counter(mm, member) (mm)->member++
+#define dec_mm_counter(mm, member) (mm)->member--
+#define MM_COUNTER_T unsigned long

 struct mm_struct {
 	struct vm_area_struct * mmap;		/* list of VMAs */
@@ -221,7 +227,7 @@ struct mm_struct {
 	atomic_t mm_count;			/* How many references to "struct mm_struct" (users count as 1) */
 	int map_count;				/* number of VMAs */
 	struct rw_semaphore mmap_sem;
-	spinlock_t page_table_lock;		/* Protects page tables, mm->rss, mm->anon_rss */
+	spinlock_t page_table_lock;		/* Protects page tables and some counters */

 	struct list_head mmlist;		/* List of maybe swapped mm's.  These are globally strung
 						 * together off init_mm.mmlist, and are protected
@@ -231,9 +237,13 @@ struct mm_struct {
 	unsigned long start_code, end_code, start_data, end_data;
 	unsigned long start_brk, brk, start_stack;
 	unsigned long arg_start, arg_end, env_start, env_end;
-	unsigned long rss, anon_rss, total_vm, locked_vm, shared_vm;
+	unsigned long total_vm, locked_vm, shared_vm;
 	unsigned long exec_vm, stack_vm, reserved_vm, def_flags, nr_ptes;

+	/* Special counters protected by the page_table_lock */
+	MM_COUNTER_T rss;
+	MM_COUNTER_T anon_rss;
+
 	unsigned long saved_auxv[42]; /* for /proc/PID/auxv */

 	unsigned dumpable:1;
Index: linux-2.6.11/mm/memory.c
===================================================================
--- linux-2.6.11.orig/mm/memory.c	2005-03-11 10:29:17.000000000 -0800
+++ linux-2.6.11/mm/memory.c	2005-03-11 10:57:00.000000000 -0800
@@ -312,9 +312,9 @@ copy_one_pte(struct mm_struct *dst_mm,
 		pte = pte_mkclean(pte);
 	pte = pte_mkold(pte);
 	get_page(page);
-	dst_mm->rss++;
+	inc_mm_counter(dst_mm, rss);
 	if (PageAnon(page))
-		dst_mm->anon_rss++;
+		inc_mm_counter(dst_mm, anon_rss);
 	set_pte_at(dst_mm, addr, dst_pte, pte);
 	page_dup_rmap(page);
 }
@@ -525,7 +525,7 @@ static void zap_pte_range(struct mmu_gat
 			if (pte_dirty(pte))
 				set_page_dirty(page);
 			if (PageAnon(page))
-				tlb->mm->anon_rss--;
+				dec_mm_counter(tlb->mm, anon_rss);
 			else if (pte_young(pte))
 				mark_page_accessed(page);
 			tlb->freed++;
@@ -1351,9 +1351,9 @@ static int do_wp_page(struct mm_struct *
 	page_table = pte_offset_map(pmd, address);
 	if (likely(pte_same(*page_table, pte))) {
 		if (PageAnon(old_page))
-			mm->anon_rss--;
+			dec_mm_counter(mm, anon_rss);
 		if (PageReserved(old_page))
-			++mm->rss;
+			inc_mm_counter(mm, rss);
 		else
 			page_remove_rmap(old_page);
 		flush_cache_page(vma, address, pfn);
@@ -1759,7 +1759,7 @@ static int do_swap_page(struct mm_struct
 	if (vm_swap_full())
 		remove_exclusive_swap_page(page);

-	mm->rss++;
+	inc_mm_counter(mm, rss);
 	pte = mk_pte(page, vma->vm_page_prot);
 	if (write_access && can_share_swap_page(page)) {
 		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
@@ -1823,7 +1823,7 @@ do_anonymous_page(struct mm_struct *mm,
 			spin_unlock(&mm->page_table_lock);
 			goto out;
 		}
-		mm->rss++;
+		inc_mm_counter(mm, rss);
 		entry = maybe_mkwrite(pte_mkdirty(mk_pte(page,
 							 vma->vm_page_prot)),
 				      vma);
@@ -1939,7 +1939,7 @@ retry:
 	/* Only go through if we didn't race with anybody else... */
 	if (pte_none(*page_table)) {
 		if (!PageReserved(new_page))
-			++mm->rss;
+			inc_mm_counter(mm, rss);

 		flush_icache_page(vma, new_page);
 		entry = mk_pte(new_page, vma->vm_page_prot);
@@ -2262,8 +2262,10 @@ EXPORT_SYMBOL(vmalloc_to_pfn);
 void update_mem_hiwater(struct task_struct *tsk)
 {
 	if (tsk->mm) {
-		if (tsk->mm->hiwater_rss < tsk->mm->rss)
-			tsk->mm->hiwater_rss = tsk->mm->rss;
+		unsigned long rss = get_mm_counter(tsk->mm, rss);
+
+		if (tsk->mm->hiwater_rss < rss)
+			tsk->mm->hiwater_rss = rss;
 		if (tsk->mm->hiwater_vm < tsk->mm->total_vm)
 			tsk->mm->hiwater_vm = tsk->mm->total_vm;
 	}
Index: linux-2.6.11/mm/rmap.c
===================================================================
--- linux-2.6.11.orig/mm/rmap.c	2005-03-11 10:29:17.000000000 -0800
+++ linux-2.6.11/mm/rmap.c	2005-03-11 10:57:00.000000000 -0800
@@ -257,7 +257,7 @@ static int page_referenced_one(struct pa
 	pte_t *pte;
 	int referenced = 0;

-	if (!mm->rss)
+	if (!get_mm_counter(mm, rss))
 		goto out;
 	address = vma_address(page, vma);
 	if (address == -EFAULT)
@@ -436,7 +436,7 @@ void page_add_anon_rmap(struct page *pag
 	BUG_ON(PageReserved(page));
 	BUG_ON(!anon_vma);

-	vma->vm_mm->anon_rss++;
+	inc_mm_counter(vma->vm_mm, anon_rss);

 	anon_vma = (void *) anon_vma + PAGE_MAPPING_ANON;
 	index = (address - vma->vm_start) >> PAGE_SHIFT;
@@ -509,7 +509,7 @@ static int try_to_unmap_one(struct page
 	pte_t pteval;
 	int ret = SWAP_AGAIN;

-	if (!mm->rss)
+	if (!get_mm_counter(mm, rss))
 		goto out;
 	address = vma_address(page, vma);
 	if (address == -EFAULT)
@@ -595,10 +595,10 @@ static int try_to_unmap_one(struct page
 		}
 		set_pte_at(mm, address, pte, swp_entry_to_pte(entry));
 		BUG_ON(pte_file(*pte));
-		mm->anon_rss--;
+		dec_mm_counter(mm, anon_rss);
 	}

-	mm->rss--;
+	inc_mm_counter(mm, rss);
 	page_remove_rmap(page);
 	page_cache_release(page);

@@ -703,7 +703,7 @@ static void try_to_unmap_cluster(unsigne

 		page_remove_rmap(page);
 		page_cache_release(page);
-		mm->rss--;
+		dec_mm_counter(mm, rss);
 		(*mapcount)--;
 	}

@@ -802,7 +802,7 @@ static int try_to_unmap_file(struct page
 			if (vma->vm_flags & (VM_LOCKED|VM_RESERVED))
 				continue;
 			cursor = (unsigned long) vma->vm_private_data;
-			while (vma->vm_mm->rss &&
+			while (get_mm_counter(vma->vm_mm, rss) &&
 				cursor < max_nl_cursor &&
 				cursor < vma->vm_end - vma->vm_start) {
 				try_to_unmap_cluster(cursor, &mapcount, vma);
Index: linux-2.6.11/fs/proc/task_mmu.c
===================================================================
--- linux-2.6.11.orig/fs/proc/task_mmu.c	2005-03-11 10:29:16.000000000 -0800
+++ linux-2.6.11/fs/proc/task_mmu.c	2005-03-11 10:57:00.000000000 -0800
@@ -24,7 +24,7 @@ char *task_mem(struct mm_struct *mm, cha
 		"VmPTE:\t%8lu kB\n",
 		(mm->total_vm - mm->reserved_vm) << (PAGE_SHIFT-10),
 		mm->locked_vm << (PAGE_SHIFT-10),
-		mm->rss << (PAGE_SHIFT-10),
+		get_mm_counter(mm, rss) << (PAGE_SHIFT-10),
 		data << (PAGE_SHIFT-10),
 		mm->stack_vm << (PAGE_SHIFT-10), text, lib,
 		(PTRS_PER_PTE*sizeof(pte_t)*mm->nr_ptes) >> 10);
@@ -39,11 +39,13 @@ unsigned long task_vsize(struct mm_struc
 int task_statm(struct mm_struct *mm, int *shared, int *text,
 	       int *data, int *resident)
 {
-	*shared = mm->rss - mm->anon_rss;
+	int rss = get_mm_counter(mm, rss);
+
+	*shared = rss - get_mm_counter(mm, anon_rss);
 	*text = (PAGE_ALIGN(mm->end_code) - (mm->start_code & PAGE_MASK))
 								>> PAGE_SHIFT;
 	*data = mm->total_vm - mm->shared_vm;
-	*resident = mm->rss;
+	*resident = rss;
 	return mm->total_vm;
 }

Index: linux-2.6.11/mm/mmap.c
===================================================================
--- linux-2.6.11.orig/mm/mmap.c	2005-03-11 10:29:17.000000000 -0800
+++ linux-2.6.11/mm/mmap.c	2005-03-11 10:57:00.000000000 -0800
@@ -1978,7 +1978,7 @@ void exit_mmap(struct mm_struct *mm)
 	vma = mm->mmap;
 	mm->mmap = mm->mmap_cache = NULL;
 	mm->mm_rb = RB_ROOT;
-	mm->rss = 0;
+	set_mm_counter(mm, rss, 0);
 	mm->total_vm = 0;
 	mm->locked_vm = 0;

Index: linux-2.6.11/kernel/fork.c
===================================================================
--- linux-2.6.11.orig/kernel/fork.c	2005-03-11 10:29:17.000000000 -0800
+++ linux-2.6.11/kernel/fork.c	2005-03-11 10:57:00.000000000 -0800
@@ -177,8 +177,8 @@ static inline int dup_mmap(struct mm_str
 	mm->mmap_cache = NULL;
 	mm->free_area_cache = oldmm->mmap_base;
 	mm->map_count = 0;
-	mm->rss = 0;
-	mm->anon_rss = 0;
+	set_mm_counter(mm, rss, 0);
+	set_mm_counter(mm, anon_rss, 0);
 	cpus_clear(mm->cpu_vm_mask);
 	mm->mm_rb = RB_ROOT;
 	rb_link = &mm->mm_rb.rb_node;
@@ -474,7 +474,7 @@ static int copy_mm(unsigned long clone_f
 	if (retval)
 		goto free_pt;

-	mm->hiwater_rss = mm->rss;
+	mm->hiwater_rss = get_mm_counter(mm,rss);
 	mm->hiwater_vm = mm->total_vm;

 good_mm:
Index: linux-2.6.11/include/asm-generic/tlb.h
===================================================================
--- linux-2.6.11.orig/include/asm-generic/tlb.h	2005-03-01 23:37:30.000000000 -0800
+++ linux-2.6.11/include/asm-generic/tlb.h	2005-03-11 10:57:00.000000000 -0800
@@ -88,11 +88,11 @@ tlb_finish_mmu(struct mmu_gather *tlb, u
 {
 	int freed = tlb->freed;
 	struct mm_struct *mm = tlb->mm;
-	int rss = mm->rss;
+	int rss = get_mm_counter(mm, rss);

 	if (rss < freed)
 		freed = rss;
-	mm->rss = rss - freed;
+	update_mm_counter(mm, rss, -freed);
 	tlb_flush_mmu(tlb, start, end);

 	/* keep the page table cache within bounds */
Index: linux-2.6.11/fs/binfmt_flat.c
===================================================================
--- linux-2.6.11.orig/fs/binfmt_flat.c	2005-03-01 23:37:30.000000000 -0800
+++ linux-2.6.11/fs/binfmt_flat.c	2005-03-11 10:57:00.000000000 -0800
@@ -650,7 +650,7 @@ static int load_flat_file(struct linux_b
 		current->mm->start_brk = datapos + data_len + bss_len;
 		current->mm->brk = (current->mm->start_brk + 3) & ~3;
 		current->mm->context.end_brk = memp + ksize((void *) memp) - stack_len;
-		current->mm->rss = 0;
+		set_mm_counter(current->mm, rss, 0);
 	}

 	if (flags & FLAT_FLAG_KTRACE)
Index: linux-2.6.11/fs/exec.c
===================================================================
--- linux-2.6.11.orig/fs/exec.c	2005-03-11 10:29:15.000000000 -0800
+++ linux-2.6.11/fs/exec.c	2005-03-11 10:57:00.000000000 -0800
@@ -326,7 +326,7 @@ void install_arg_page(struct vm_area_str
 		pte_unmap(pte);
 		goto out;
 	}
-	mm->rss++;
+	inc_mm_counter(mm, rss);
 	lru_cache_add_active(page);
 	set_pte_at(mm, address, pte, pte_mkdirty(pte_mkwrite(mk_pte(
 					page, vma->vm_page_prot))));
Index: linux-2.6.11/fs/binfmt_som.c
===================================================================
--- linux-2.6.11.orig/fs/binfmt_som.c	2005-03-01 23:38:06.000000000 -0800
+++ linux-2.6.11/fs/binfmt_som.c	2005-03-11 10:57:00.000000000 -0800
@@ -259,7 +259,7 @@ load_som_binary(struct linux_binprm * bp
 	create_som_tables(bprm);

 	current->mm->start_stack = bprm->p;
-	current->mm->rss = 0;
+	set_mm_counter(current->mm, rss, 0);

 #if 0
 	printk("(start_brk) %08lx\n" , (unsigned long) current->mm->start_brk);
Index: linux-2.6.11/mm/fremap.c
===================================================================
--- linux-2.6.11.orig/mm/fremap.c	2005-03-11 10:29:17.000000000 -0800
+++ linux-2.6.11/mm/fremap.c	2005-03-11 10:57:00.000000000 -0800
@@ -39,7 +39,7 @@ static inline void zap_pte(struct mm_str
 					set_page_dirty(page);
 				page_remove_rmap(page);
 				page_cache_release(page);
-				mm->rss--;
+				dec_mm_counter(mm, rss);
 			}
 		}
 	} else {
@@ -92,7 +92,7 @@ int install_page(struct mm_struct *mm, s

 	zap_pte(mm, vma, addr, pte);

-	mm->rss++;
+	inc_mm_counter(mm,rss);
 	flush_icache_page(vma, page);
 	set_pte_at(mm, addr, pte, mk_pte(page, prot));
 	page_add_file_rmap(page);
Index: linux-2.6.11/mm/swapfile.c
===================================================================
--- linux-2.6.11.orig/mm/swapfile.c	2005-03-11 10:29:17.000000000 -0800
+++ linux-2.6.11/mm/swapfile.c	2005-03-11 10:57:00.000000000 -0800
@@ -425,7 +425,7 @@ static void
 unuse_pte(struct vm_area_struct *vma, unsigned long address, pte_t *dir,
 	swp_entry_t entry, struct page *page)
 {
-	vma->vm_mm->rss++;
+	inc_mm_counter(vma->vm_mm, rss);
 	get_page(page);
 	set_pte_at(vma->vm_mm, address, dir,
 		   pte_mkold(mk_pte(page, vma->vm_page_prot)));
Index: linux-2.6.11/fs/binfmt_aout.c
===================================================================
--- linux-2.6.11.orig/fs/binfmt_aout.c	2005-03-01 23:38:37.000000000 -0800
+++ linux-2.6.11/fs/binfmt_aout.c	2005-03-11 10:57:00.000000000 -0800
@@ -317,7 +317,7 @@ static int load_aout_binary(struct linux
 		(current->mm->start_brk = N_BSSADDR(ex));
 	current->mm->free_area_cache = current->mm->mmap_base;

-	current->mm->rss = 0;
+	set_mm_counter(current->mm, rss, 0);
 	current->mm->mmap = NULL;
 	compute_creds(bprm);
  	current->flags &= ~PF_FORKNOEXEC;
Index: linux-2.6.11/arch/ia64/mm/hugetlbpage.c
===================================================================
--- linux-2.6.11.orig/arch/ia64/mm/hugetlbpage.c	2005-03-11 10:29:09.000000000 -0800
+++ linux-2.6.11/arch/ia64/mm/hugetlbpage.c	2005-03-11 10:57:00.000000000 -0800
@@ -73,7 +73,7 @@ set_huge_pte (struct mm_struct *mm, stru
 {
 	pte_t entry;

-	mm->rss += (HPAGE_SIZE / PAGE_SIZE);
+	update_mm_counter(mm, rss, HPAGE_SIZE / PAGE_SIZE);
 	if (write_access) {
 		entry =
 		    pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
@@ -116,7 +116,7 @@ int copy_hugetlb_page_range(struct mm_st
 		ptepage = pte_page(entry);
 		get_page(ptepage);
 		set_pte(dst_pte, entry);
-		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
+		update_mm_counter(dst, rss, HPAGE_SIZE / PAGE_SIZE);
 		addr += HPAGE_SIZE;
 	}
 	return 0;
@@ -246,7 +246,7 @@ void unmap_hugepage_range(struct vm_area
 		put_page(page);
 		pte_clear(mm, address, pte);
 	}
-	mm->rss -= (end - start) >> PAGE_SHIFT;
+	update_mm_counter(mm, rss, - ((end - start) >> PAGE_SHIFT));
 	flush_tlb_range(vma, start, end);
 }

Index: linux-2.6.11/fs/binfmt_elf.c
===================================================================
--- linux-2.6.11.orig/fs/binfmt_elf.c	2005-03-11 10:29:15.000000000 -0800
+++ linux-2.6.11/fs/binfmt_elf.c	2005-03-11 10:57:00.000000000 -0800
@@ -773,7 +773,7 @@ static int load_elf_binary(struct linux_

 	/* Do this so that we can load the interpreter, if need be.  We will
 	   change some of these later */
-	current->mm->rss = 0;
+	set_mm_counter(current->mm, rss, 0);
 	current->mm->free_area_cache = current->mm->mmap_base;
 	retval = setup_arg_pages(bprm, randomize_stack_top(STACK_TOP),
 				 executable_stack);
Index: linux-2.6.11/include/asm-ia64/tlb.h
===================================================================
--- linux-2.6.11.orig/include/asm-ia64/tlb.h	2005-03-01 23:38:07.000000000 -0800
+++ linux-2.6.11/include/asm-ia64/tlb.h	2005-03-11 10:57:00.000000000 -0800
@@ -161,11 +161,11 @@ tlb_finish_mmu (struct mmu_gather *tlb,
 {
 	unsigned long freed = tlb->freed;
 	struct mm_struct *mm = tlb->mm;
-	unsigned long rss = mm->rss;
+	unsigned long rss = get_mm_counter(mm, rss);

 	if (rss < freed)
 		freed = rss;
-	mm->rss = rss - freed;
+	update_mm_counter(mm, rss, -freed);
 	/*
 	 * Note: tlb->nr may be 0 at this point, so we can't rely on tlb->start_addr and
 	 * tlb->end_addr.
Index: linux-2.6.11/include/asm-arm/tlb.h
===================================================================
--- linux-2.6.11.orig/include/asm-arm/tlb.h	2005-03-01 23:37:45.000000000 -0800
+++ linux-2.6.11/include/asm-arm/tlb.h	2005-03-11 10:57:00.000000000 -0800
@@ -54,11 +54,11 @@ tlb_finish_mmu(struct mmu_gather *tlb, u
 {
 	struct mm_struct *mm = tlb->mm;
 	unsigned long freed = tlb->freed;
-	int rss = mm->rss;
+	int rss = get_mm_counter(mm, rss);

 	if (rss < freed)
 		freed = rss;
-	mm->rss = rss - freed;
+	update_mm_counter(mm, rss, -freed);

 	if (freed) {
 		flush_tlb_mm(mm);
Index: linux-2.6.11/include/asm-arm26/tlb.h
===================================================================
--- linux-2.6.11.orig/include/asm-arm26/tlb.h	2005-03-01 23:38:33.000000000 -0800
+++ linux-2.6.11/include/asm-arm26/tlb.h	2005-03-11 10:57:00.000000000 -0800
@@ -37,11 +37,11 @@ tlb_finish_mmu(struct mmu_gather *tlb, u
 {
         struct mm_struct *mm = tlb->mm;
         unsigned long freed = tlb->freed;
-        int rss = mm->rss;
+        int rss = get_mm_counter(mm, rss);

         if (rss < freed)
                 freed = rss;
-        mm->rss = rss - freed;
+        update_mm_counter(mm, rss, -freed);

         if (freed) {
                 flush_tlb_mm(mm);
Index: linux-2.6.11/include/asm-sparc64/tlb.h
===================================================================
--- linux-2.6.11.orig/include/asm-sparc64/tlb.h	2005-03-01 23:38:17.000000000 -0800
+++ linux-2.6.11/include/asm-sparc64/tlb.h	2005-03-11 10:57:00.000000000 -0800
@@ -80,11 +80,11 @@ static inline void tlb_finish_mmu(struct
 {
 	unsigned long freed = mp->freed;
 	struct mm_struct *mm = mp->mm;
-	unsigned long rss = mm->rss;
+	unsigned long rss = get_mm_counter(mm, rss);

 	if (rss < freed)
 		freed = rss;
-	mm->rss = rss - freed;
+	update_mm_counter(mm, rss, -freed);

 	tlb_flush_mmu(mp);

Index: linux-2.6.11/arch/sh/mm/hugetlbpage.c
===================================================================
--- linux-2.6.11.orig/arch/sh/mm/hugetlbpage.c	2005-03-11 10:29:10.000000000 -0800
+++ linux-2.6.11/arch/sh/mm/hugetlbpage.c	2005-03-11 10:57:00.000000000 -0800
@@ -62,7 +62,7 @@ static void set_huge_pte(struct mm_struc
 	unsigned long i;
 	pte_t entry;

-	mm->rss += (HPAGE_SIZE / PAGE_SIZE);
+	update_mm_counter(mm, rss, HPAGE_SIZE / PAGE_SIZE);

 	if (write_access)
 		entry = pte_mkwrite(pte_mkdirty(mk_pte(page,
@@ -115,7 +115,7 @@ int copy_hugetlb_page_range(struct mm_st
 			pte_val(entry) += PAGE_SIZE;
 			dst_pte++;
 		}
-		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
+		update_mm_counter(dst, rss, HPAGE_SIZE / PAGE_SIZE);
 		addr += HPAGE_SIZE;
 	}
 	return 0;
@@ -206,7 +206,7 @@ void unmap_hugepage_range(struct vm_area
 			pte++;
 		}
 	}
-	mm->rss -= (end - start) >> PAGE_SHIFT;
+	update_mm_counter(mm, rss, -((end - start) >> PAGE_SHIFT));
 	flush_tlb_range(vma, start, end);
 }

Index: linux-2.6.11/arch/x86_64/ia32/ia32_aout.c
===================================================================
--- linux-2.6.11.orig/arch/x86_64/ia32/ia32_aout.c	2005-03-01 23:38:33.000000000 -0800
+++ linux-2.6.11/arch/x86_64/ia32/ia32_aout.c	2005-03-11 10:57:00.000000000 -0800
@@ -313,7 +313,7 @@ static int load_aout_binary(struct linux
 		(current->mm->start_brk = N_BSSADDR(ex));
 	current->mm->free_area_cache = TASK_UNMAPPED_BASE;

-	current->mm->rss = 0;
+	set_mm_counter(current->mm, rss, 0);
 	current->mm->mmap = NULL;
 	compute_creds(bprm);
  	current->flags &= ~PF_FORKNOEXEC;
Index: linux-2.6.11/arch/ppc64/mm/hugetlbpage.c
===================================================================
--- linux-2.6.11.orig/arch/ppc64/mm/hugetlbpage.c	2005-03-11 10:29:10.000000000 -0800
+++ linux-2.6.11/arch/ppc64/mm/hugetlbpage.c	2005-03-11 10:57:00.000000000 -0800
@@ -154,7 +154,7 @@ static void set_huge_pte(struct mm_struc
 {
 	pte_t entry;

-	mm->rss += (HPAGE_SIZE / PAGE_SIZE);
+	update_mm_counter(mm, rss, HPAGE_SIZE / PAGE_SIZE);
 	if (write_access) {
 		entry =
 		    pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
@@ -316,7 +316,7 @@ int copy_hugetlb_page_range(struct mm_st

 		ptepage = pte_page(entry);
 		get_page(ptepage);
-		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
+		update_mm_counter(dst, rss, HPAGE_SIZE / PAGE_SIZE);
 		set_pte_at(dst, addr, dst_pte, entry);

 		addr += HPAGE_SIZE;
@@ -426,7 +426,7 @@ void unmap_hugepage_range(struct vm_area

 		put_page(page);
 	}
-	mm->rss -= (end - start) >> PAGE_SHIFT;
+	update_mm_counter(mm, rss, -((end - start) >> PAGE_SHIFT));
 	flush_tlb_pending();
 }

Index: linux-2.6.11/arch/sh64/mm/hugetlbpage.c
===================================================================
--- linux-2.6.11.orig/arch/sh64/mm/hugetlbpage.c	2005-03-11 10:29:10.000000000 -0800
+++ linux-2.6.11/arch/sh64/mm/hugetlbpage.c	2005-03-11 10:57:00.000000000 -0800
@@ -62,7 +62,7 @@ static void set_huge_pte(struct mm_struc
 	unsigned long i;
 	pte_t entry;

-	mm->rss += (HPAGE_SIZE / PAGE_SIZE);
+	update_mm_counter(mm, rss, HPAGE_SIZE / PAGE_SIZE);

 	if (write_access)
 		entry = pte_mkwrite(pte_mkdirty(mk_pte(page,
@@ -115,7 +115,7 @@ int copy_hugetlb_page_range(struct mm_st
 			pte_val(entry) += PAGE_SIZE;
 			dst_pte++;
 		}
-		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
+		update_mm_counter(dst, rss, HPAGE_SIZE / PAGE_SIZE);
 		addr += HPAGE_SIZE;
 	}
 	return 0;
@@ -206,7 +206,7 @@ void unmap_hugepage_range(struct vm_area
 			pte++;
 		}
 	}
-	mm->rss -= (end - start) >> PAGE_SHIFT;
+	update_mm_counter(mm, rss, -((end - start) >> PAGE_SHIFT));
 	flush_tlb_range(vma, start, end);
 }

Index: linux-2.6.11/arch/sparc64/mm/hugetlbpage.c
===================================================================
--- linux-2.6.11.orig/arch/sparc64/mm/hugetlbpage.c	2005-03-11 10:29:10.000000000 -0800
+++ linux-2.6.11/arch/sparc64/mm/hugetlbpage.c	2005-03-11 10:57:00.000000000 -0800
@@ -68,7 +68,7 @@ static void set_huge_pte(struct mm_struc
 	unsigned long i;
 	pte_t entry;

-	mm->rss += (HPAGE_SIZE / PAGE_SIZE);
+	update_mm_counter(mm, rss, HPAGE_SIZE / PAGE_SIZE);

 	if (write_access)
 		entry = pte_mkwrite(pte_mkdirty(mk_pte(page,
@@ -123,7 +123,7 @@ int copy_hugetlb_page_range(struct mm_st
 			dst_pte++;
 			addr += PAGE_SIZE;
 		}
-		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
+		update_mm_counter(dst, rss, HPAGE_SIZE / PAGE_SIZE);
 	}
 	return 0;

@@ -213,7 +213,7 @@ void unmap_hugepage_range(struct vm_area
 			pte++;
 		}
 	}
-	mm->rss -= (end - start) >> PAGE_SHIFT;
+	update_mm_counter(mm, rss, -((end - start) >> PAGE_SHIFT));
 	flush_tlb_range(vma, start, end);
 }

Index: linux-2.6.11/arch/mips/kernel/irixelf.c
===================================================================
--- linux-2.6.11.orig/arch/mips/kernel/irixelf.c	2005-03-01 23:38:34.000000000 -0800
+++ linux-2.6.11/arch/mips/kernel/irixelf.c	2005-03-11 10:57:00.000000000 -0800
@@ -692,7 +692,7 @@ static int load_irix_binary(struct linux
 	/* Do this so that we can load the interpreter, if need be.  We will
 	 * change some of these later.
 	 */
-	current->mm->rss = 0;
+	set_mm_counter(current->mm, rss, 0);
 	setup_arg_pages(bprm, STACK_TOP, EXSTACK_DEFAULT);
 	current->mm->start_stack = bprm->p;

Index: linux-2.6.11/arch/m68k/atari/stram.c
===================================================================
--- linux-2.6.11.orig/arch/m68k/atari/stram.c	2005-03-01 23:38:17.000000000 -0800
+++ linux-2.6.11/arch/m68k/atari/stram.c	2005-03-11 10:57:00.000000000 -0800
@@ -635,7 +635,7 @@ static inline void unswap_pte(struct vm_
 	set_pte(dir, pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
 	swap_free(entry);
 	get_page(page);
-	++vma->vm_mm->rss;
+	inc_mm_counter(vma->vm_mm, rss);
 }

 static inline void unswap_pmd(struct vm_area_struct * vma, pmd_t *dir,
Index: linux-2.6.11/arch/i386/mm/hugetlbpage.c
===================================================================
--- linux-2.6.11.orig/arch/i386/mm/hugetlbpage.c	2005-03-11 10:29:09.000000000 -0800
+++ linux-2.6.11/arch/i386/mm/hugetlbpage.c	2005-03-11 10:57:00.000000000 -0800
@@ -46,7 +46,7 @@ static void set_huge_pte(struct mm_struc
 {
 	pte_t entry;

-	mm->rss += (HPAGE_SIZE / PAGE_SIZE);
+	update_mm_counter(mm, rss, HPAGE_SIZE / PAGE_SIZE);
 	if (write_access) {
 		entry =
 		    pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
@@ -86,7 +86,7 @@ int copy_hugetlb_page_range(struct mm_st
 		ptepage = pte_page(entry);
 		get_page(ptepage);
 		set_pte(dst_pte, entry);
-		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
+		update_mm_counter(dst, rss, HPAGE_SIZE / PAGE_SIZE);
 		addr += HPAGE_SIZE;
 	}
 	return 0;
@@ -222,7 +222,7 @@ void unmap_hugepage_range(struct vm_area
 		page = pte_page(pte);
 		put_page(page);
 	}
-	mm->rss -= (end - start) >> PAGE_SHIFT;
+	update_mm_counter(mm ,rss, -((end - start) >> PAGE_SHIFT));
 	flush_tlb_range(vma, start, end);
 }

Index: linux-2.6.11/arch/sparc64/kernel/binfmt_aout32.c
===================================================================
--- linux-2.6.11.orig/arch/sparc64/kernel/binfmt_aout32.c	2005-03-01 23:38:09.000000000 -0800
+++ linux-2.6.11/arch/sparc64/kernel/binfmt_aout32.c	2005-03-11 10:57:00.000000000 -0800
@@ -241,7 +241,7 @@ static int load_aout32_binary(struct lin
 	current->mm->brk = ex.a_bss +
 		(current->mm->start_brk = N_BSSADDR(ex));

-	current->mm->rss = 0;
+	set_mm_counter(current->mm, rss, 0);
 	current->mm->mmap = NULL;
 	compute_creds(bprm);
  	current->flags &= ~PF_FORKNOEXEC;
Index: linux-2.6.11/fs/proc/array.c
===================================================================
--- linux-2.6.11.orig/fs/proc/array.c	2005-03-11 10:29:16.000000000 -0800
+++ linux-2.6.11/fs/proc/array.c	2005-03-11 10:57:00.000000000 -0800
@@ -432,7 +432,7 @@ static int do_task_stat(struct task_stru
 		jiffies_to_clock_t(it_real_value),
 		start_time,
 		vsize,
-		mm ? mm->rss : 0, /* you might want to shift this left 3 */
+		mm ? get_mm_counter(mm, rss) : 0, /* you might want to shift this left 3 */
 	        rsslim,
 		mm ? mm->start_code : 0,
 		mm ? mm->end_code : 0,
Index: linux-2.6.11/fs/binfmt_elf_fdpic.c
===================================================================
--- linux-2.6.11.orig/fs/binfmt_elf_fdpic.c	2005-03-01 23:37:58.000000000 -0800
+++ linux-2.6.11/fs/binfmt_elf_fdpic.c	2005-03-11 10:57:00.000000000 -0800
@@ -299,7 +299,7 @@ static int load_elf_fdpic_binary(struct
 	/* do this so that we can load the interpreter, if need be
 	 * - we will change some of these later
 	 */
-	current->mm->rss = 0;
+	set_mm_counter(current->mm, rss, 0);

 #ifdef CONFIG_MMU
 	retval = setup_arg_pages(bprm, current->mm->start_stack, executable_stack);
Index: linux-2.6.11/kernel/acct.c
===================================================================
--- linux-2.6.11.orig/kernel/acct.c	2005-03-11 10:29:17.000000000 -0800
+++ linux-2.6.11/kernel/acct.c	2005-03-11 10:57:00.000000000 -0800
@@ -542,7 +542,7 @@ void acct_update_integrals(struct task_s
 		if (delta == 0)
 			return;
 		tsk->acct_stimexpd = tsk->stime;
-		tsk->acct_rss_mem1 += delta * tsk->mm->rss;
+		tsk->acct_rss_mem1 += delta * get_mm_counter(tsk->mm, rss);
 		tsk->acct_vm_mem1 += delta * tsk->mm->total_vm;
 	}
 }
Index: linux-2.6.11/mm/nommu.c
===================================================================
--- linux-2.6.11.orig/mm/nommu.c	2005-03-11 10:29:17.000000000 -0800
+++ linux-2.6.11/mm/nommu.c	2005-03-11 10:57:00.000000000 -0800
@@ -961,9 +961,11 @@ void arch_unmap_area(struct vm_area_stru

 void update_mem_hiwater(struct task_struct *tsk)
 {
+	unsigned long rss = get_mm_counter(tsk->mm, rss);
+
 	if (likely(tsk->mm)) {
-		if (tsk->mm->hiwater_rss < tsk->mm->rss)
-			tsk->mm->hiwater_rss = tsk->mm->rss;
+		if (tsk->mm->hiwater_rss < rss)
+			tsk->mm->hiwater_rss = rss;
 		if (tsk->mm->hiwater_vm < tsk->mm->total_vm)
 			tsk->mm->hiwater_vm = tsk->mm->total_vm;
 	}
