Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269670AbUIRX1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269670AbUIRX1Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 19:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269671AbUIRX0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 19:26:34 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:6353 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S269670AbUIRXZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 19:25:28 -0400
Date: Sat, 18 Sep 2004 16:24:54 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: akpm@osdl.org
cc: "David S. Miller" <davem@davemloft.net>, benh@kernel.crashing.org,
       wli@holomorphy.com, davem@redhat.com, raybry@sgi.com, ak@muc.de,
       manfred@colorfullife.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, vrajesh@umich.edu, hugh@veritas.com
Subject: page fault scalability patch V8: [1/7] make mm->rss atomic
In-Reply-To: <B6E8046E1E28D34EB815A11AC8CA312902CD3243@mtv-atc-605e--n.corp.sgi.com>
Message-ID: <Pine.LNX.4.58.0409181623550.24054@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0408151924250.4480@schroedinger.engr.sgi.com>
 <20040816143903.GY11200@holomorphy.com>
 <B6E8046E1E28D34EB815A11AC8CA3129027B679F@mtv-atc-605e--n.corp.sgi.com>
 <B6E8046E1E28D34EB815A11AC8CA3129027B67A9@mtv-atc-605e--n.corp.sgi.com>
 <B6E8046E1E28D34EB815A11AC8CA3129027B67B4@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0408271616001.14712@schroedinger.engr.sgi.com>
 <1094012689.6538.330.camel@gaston> <Pine.LNX.4.58.0409010938200.9907@schroedinger.engr.sgi.com>
 <1094080164.4025.17.camel@gaston> <Pine.LNX.4.58.0409012140440.23186@schroedinger.engr.sgi.com>
 <20040901215741.3538bbf4.davem@davemloft.net>
 <Pine.LNX.4.58.0409020920570.26893@schroedinger.engr.sgi.com>
 <20040902131057.0341e337.davem@davemloft.net>
 <Pine.LNX.4.58.0409021358540.28182@schroedinger.engr.sgi.com>
 <20040902140759.5f1003d5.davem@davemloft.net>
 <B6E8046E1E28D34EB815A11AC8CA312902CD3243@mtv-atc-605e--n.corp.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
	* Make mm->rss atomic, so that rss may be incremented or decremented
	  without holding the page table lock.
	* Prerequisite for page table scalability patch

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linus/kernel/fork.c
===================================================================
--- linus.orig/kernel/fork.c	2004-09-18 14:25:22.000000000 -0700
+++ linus/kernel/fork.c	2004-09-18 14:56:47.000000000 -0700
@@ -296,7 +296,7 @@
 	mm->mmap_cache = NULL;
 	mm->free_area_cache = oldmm->mmap_base;
 	mm->map_count = 0;
-	mm->rss = 0;
+	atomic_set(&mm->mm_rss, 0);
 	cpus_clear(mm->cpu_vm_mask);
 	mm->mm_rb = RB_ROOT;
 	rb_link = &mm->mm_rb.rb_node;
Index: linus/include/linux/sched.h
===================================================================
--- linus.orig/include/linux/sched.h	2004-09-18 14:25:22.000000000 -0700
+++ linus/include/linux/sched.h	2004-09-18 14:56:47.000000000 -0700
@@ -213,9 +213,10 @@
 	pgd_t * pgd;
 	atomic_t mm_users;			/* How many users with user space? */
 	atomic_t mm_count;			/* How many references to "struct mm_struct" (users count as 1) */
+	atomic_t mm_rss;			/* Number of pages used by this mm struct */
 	int map_count;				/* number of VMAs */
 	struct rw_semaphore mmap_sem;
-	spinlock_t page_table_lock;		/* Protects task page tables and mm->rss */
+	spinlock_t page_table_lock;		/* Protects task page tables */

 	struct list_head mmlist;		/* List of all active mm's.  These are globally strung
 						 * together off init_mm.mmlist, and are protected
@@ -225,7 +226,7 @@
 	unsigned long start_code, end_code, start_data, end_data;
 	unsigned long start_brk, brk, start_stack;
 	unsigned long arg_start, arg_end, env_start, env_end;
-	unsigned long rss, total_vm, locked_vm, shared_vm;
+	unsigned long total_vm, locked_vm, shared_vm;
 	unsigned long exec_vm, stack_vm, reserved_vm, def_flags;

 	unsigned long saved_auxv[42]; /* for /proc/PID/auxv */
Index: linus/fs/proc/task_mmu.c
===================================================================
--- linus.orig/fs/proc/task_mmu.c	2004-09-18 14:25:22.000000000 -0700
+++ linus/fs/proc/task_mmu.c	2004-09-18 14:56:47.000000000 -0700
@@ -21,7 +21,7 @@
 		"VmLib:\t%8lu kB\n",
 		(mm->total_vm - mm->reserved_vm) << (PAGE_SHIFT-10),
 		mm->locked_vm << (PAGE_SHIFT-10),
-		mm->rss << (PAGE_SHIFT-10),
+		(unsigned long)atomic_read(&mm->mm_rss) << (PAGE_SHIFT-10),
 		data << (PAGE_SHIFT-10),
 		mm->stack_vm << (PAGE_SHIFT-10), text, lib);
 	return buffer;
@@ -38,7 +38,7 @@
 	*shared = mm->shared_vm;
 	*text = (mm->end_code - mm->start_code) >> PAGE_SHIFT;
 	*data = mm->total_vm - mm->shared_vm - *text;
-	*resident = mm->rss;
+	*resident = atomic_read(&mm->mm_rss);
 	return mm->total_vm;
 }

Index: linus/mm/mmap.c
===================================================================
--- linus.orig/mm/mmap.c	2004-09-18 14:25:22.000000000 -0700
+++ linus/mm/mmap.c	2004-09-18 14:56:47.000000000 -0700
@@ -1845,7 +1845,7 @@
 	vma = mm->mmap;
 	mm->mmap = mm->mmap_cache = NULL;
 	mm->mm_rb = RB_ROOT;
-	mm->rss = 0;
+	atomic_set(&mm->mm_rss, 0);
 	mm->total_vm = 0;
 	mm->locked_vm = 0;

Index: linus/include/asm-generic/tlb.h
===================================================================
--- linus.orig/include/asm-generic/tlb.h	2004-09-18 14:25:22.000000000 -0700
+++ linus/include/asm-generic/tlb.h	2004-09-18 14:56:47.000000000 -0700
@@ -88,11 +88,11 @@
 {
 	int freed = tlb->freed;
 	struct mm_struct *mm = tlb->mm;
-	int rss = mm->rss;
+	int rss = atomic_read(&mm->mm_rss);

 	if (rss < freed)
 		freed = rss;
-	mm->rss = rss - freed;
+	atomic_set(&mm->mm_rss, rss - freed);
 	tlb_flush_mmu(tlb, start, end);

 	/* keep the page table cache within bounds */
Index: linus/fs/binfmt_flat.c
===================================================================
--- linus.orig/fs/binfmt_flat.c	2004-09-18 14:25:22.000000000 -0700
+++ linus/fs/binfmt_flat.c	2004-09-18 14:56:47.000000000 -0700
@@ -650,7 +650,7 @@
 		current->mm->start_brk = datapos + data_len + bss_len;
 		current->mm->brk = (current->mm->start_brk + 3) & ~3;
 		current->mm->context.end_brk = memp + ksize((void *) memp) - stack_len;
-		current->mm->rss = 0;
+		atomic_set(current->mm->mm_rss, 0);
 	}

 	if (flags & FLAT_FLAG_KTRACE)
Index: linus/fs/exec.c
===================================================================
--- linus.orig/fs/exec.c	2004-09-18 14:25:22.000000000 -0700
+++ linus/fs/exec.c	2004-09-18 14:56:47.000000000 -0700
@@ -319,7 +319,7 @@
 		pte_unmap(pte);
 		goto out;
 	}
-	mm->rss++;
+	atomic_inc(&mm->mm_rss);
 	lru_cache_add_active(page);
 	set_pte(pte, pte_mkdirty(pte_mkwrite(mk_pte(
 					page, vma->vm_page_prot))));
Index: linus/mm/memory.c
===================================================================
--- linus.orig/mm/memory.c	2004-09-18 14:25:23.000000000 -0700
+++ linus/mm/memory.c	2004-09-18 15:01:05.000000000 -0700
@@ -325,7 +325,7 @@
 					pte = pte_mkclean(pte);
 				pte = pte_mkold(pte);
 				get_page(page);
-				dst->rss++;
+				atomic_inc(&dst->mm_rss);
 				set_pte(dst_pte, pte);
 				page_dup_rmap(page);
 cont_copy_pte_range_noset:
@@ -1096,7 +1096,7 @@
 	page_table = pte_offset_map(pmd, address);
 	if (likely(pte_same(*page_table, pte))) {
 		if (PageReserved(old_page))
-			++mm->rss;
+			atomic_inc(&mm->mm_rss);
 		else
 			page_remove_rmap(old_page);
 		break_cow(vma, new_page, address, page_table);
@@ -1378,7 +1378,7 @@
 	if (vm_swap_full())
 		remove_exclusive_swap_page(page);

-	mm->rss++;
+	atomic_inc(&mm->mm_rss);
 	pte = mk_pte(page, vma->vm_page_prot);
 	if (write_access && can_share_swap_page(page)) {
 		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
@@ -1443,7 +1443,7 @@
 			spin_unlock(&mm->page_table_lock);
 			goto out;
 		}
-		mm->rss++;
+		atomic_inc(&mm->mm_rss);
 		entry = maybe_mkwrite(pte_mkdirty(mk_pte(page,
 							 vma->vm_page_prot)),
 				      vma);
@@ -1552,7 +1552,7 @@
 	/* Only go through if we didn't race with anybody else... */
 	if (pte_none(*page_table)) {
 		if (!PageReserved(new_page))
-			++mm->rss;
+			atomic_inc(&mm->mm_rss);
 		flush_icache_page(vma, new_page);
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		if (write_access)
Index: linus/fs/binfmt_som.c
===================================================================
--- linus.orig/fs/binfmt_som.c	2004-09-18 14:25:23.000000000 -0700
+++ linus/fs/binfmt_som.c	2004-09-18 14:56:47.000000000 -0700
@@ -259,7 +259,7 @@
 	create_som_tables(bprm);

 	current->mm->start_stack = bprm->p;
-	current->mm->rss = 0;
+	atomic_set(current->mm->mm_rss, 0);

 #if 0
 	printk("(start_brk) %08lx\n" , (unsigned long) current->mm->start_brk);
Index: linus/mm/fremap.c
===================================================================
--- linus.orig/mm/fremap.c	2004-09-18 14:25:23.000000000 -0700
+++ linus/mm/fremap.c	2004-09-18 14:56:47.000000000 -0700
@@ -38,7 +38,7 @@
 					set_page_dirty(page);
 				page_remove_rmap(page);
 				page_cache_release(page);
-				mm->rss--;
+				atomic_dec(&mm->mm_rss);
 			}
 		}
 	} else {
@@ -86,7 +86,7 @@

 	zap_pte(mm, vma, addr, pte);

-	mm->rss++;
+	atomic_inc(&mm->mm_rss);
 	flush_icache_page(vma, page);
 	set_pte(pte, mk_pte(page, prot));
 	page_add_file_rmap(page);
Index: linus/mm/swapfile.c
===================================================================
--- linus.orig/mm/swapfile.c	2004-09-18 14:25:23.000000000 -0700
+++ linus/mm/swapfile.c	2004-09-18 14:56:47.000000000 -0700
@@ -430,7 +430,7 @@
 unuse_pte(struct vm_area_struct *vma, unsigned long address, pte_t *dir,
 	swp_entry_t entry, struct page *page)
 {
-	vma->vm_mm->rss++;
+	atomic_inc(&vma->vm_mm->mm_rss);
 	get_page(page);
 	set_pte(dir, pte_mkold(mk_pte(page, vma->vm_page_prot)));
 	page_add_anon_rmap(page, vma, address);
Index: linus/fs/binfmt_aout.c
===================================================================
--- linus.orig/fs/binfmt_aout.c	2004-09-18 14:25:23.000000000 -0700
+++ linus/fs/binfmt_aout.c	2004-09-18 14:56:47.000000000 -0700
@@ -309,7 +309,7 @@
 		(current->mm->start_brk = N_BSSADDR(ex));
 	current->mm->free_area_cache = current->mm->mmap_base;

-	current->mm->rss = 0;
+	atomic_set(&current->mm->mm_rss, 0);
 	current->mm->mmap = NULL;
 	compute_creds(bprm);
  	current->flags &= ~PF_FORKNOEXEC;
Index: linus/arch/ia64/mm/hugetlbpage.c
===================================================================
--- linus.orig/arch/ia64/mm/hugetlbpage.c	2004-09-18 14:25:23.000000000 -0700
+++ linus/arch/ia64/mm/hugetlbpage.c	2004-09-18 14:56:47.000000000 -0700
@@ -65,7 +65,7 @@
 {
 	pte_t entry;

-	mm->rss += (HPAGE_SIZE / PAGE_SIZE);
+	atomic_add(HPAGE_SIZE / PAGE_SIZE, &mm->mm_rss);
 	if (write_access) {
 		entry =
 		    pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
@@ -108,7 +108,7 @@
 		ptepage = pte_page(entry);
 		get_page(ptepage);
 		set_pte(dst_pte, entry);
-		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
+		atomic_add(HPAGE_SIZE / PAGE_SIZE, &dst->mm_rss);
 		addr += HPAGE_SIZE;
 	}
 	return 0;
@@ -249,7 +249,7 @@
 		put_page(page);
 		pte_clear(pte);
 	}
-	mm->rss -= (end - start) >> PAGE_SHIFT;
+	atomic_sub((end - start) >> PAGE_SHIFT, &mm->mm_rss);
 	flush_tlb_range(vma, start, end);
 }

Index: linus/fs/proc/array.c
===================================================================
--- linus.orig/fs/proc/array.c	2004-09-18 14:25:23.000000000 -0700
+++ linus/fs/proc/array.c	2004-09-18 14:56:47.000000000 -0700
@@ -388,7 +388,7 @@
 		jiffies_to_clock_t(task->it_real_value),
 		start_time,
 		vsize,
-		mm ? mm->rss : 0, /* you might want to shift this left 3 */
+		mm ? (unsigned long)atomic_read(&mm->mm_rss) : 0, /* you might want to shift this left 3 */
 		task->rlim[RLIMIT_RSS].rlim_cur,
 		mm ? mm->start_code : 0,
 		mm ? mm->end_code : 0,
Index: linus/fs/binfmt_elf.c
===================================================================
--- linus.orig/fs/binfmt_elf.c	2004-09-18 14:25:23.000000000 -0700
+++ linus/fs/binfmt_elf.c	2004-09-18 14:56:47.000000000 -0700
@@ -708,7 +708,7 @@

 	/* Do this so that we can load the interpreter, if need be.  We will
 	   change some of these later */
-	current->mm->rss = 0;
+	atomic_set(&current->mm->mm_rss, 0);
 	current->mm->free_area_cache = current->mm->mmap_base;
 	retval = setup_arg_pages(bprm, executable_stack);
 	if (retval < 0) {
Index: linus/mm/rmap.c
===================================================================
--- linus.orig/mm/rmap.c	2004-09-18 14:25:23.000000000 -0700
+++ linus/mm/rmap.c	2004-09-18 15:13:05.000000000 -0700
@@ -262,7 +262,7 @@
 	pte_t *pte;
 	int referenced = 0;

-	if (!mm->rss)
+	if (!atomic_read(&mm->mm_rss))
 		goto out;
 	address = vma_address(page, vma);
 	if (address == -EFAULT)
@@ -501,7 +501,7 @@
 	pte_t pteval;
 	int ret = SWAP_AGAIN;

-	if (!mm->rss)
+	if (!atomic_read(&mm->mm_rss))
 		goto out;
 	address = vma_address(page, vma);
 	if (address == -EFAULT)
@@ -580,7 +580,7 @@
 		BUG_ON(pte_file(*pte));
 	}

-	mm->rss--;
+	atomic_dec(&mm->mm_rss);
 	page_remove_rmap(page);
 	page_cache_release(page);

@@ -680,7 +680,7 @@

 		page_remove_rmap(page);
 		page_cache_release(page);
-		mm->rss--;
+		atomic_dec(&mm->mm_rss);
 		(*mapcount)--;
 	}

@@ -779,7 +779,7 @@
 			if (vma->vm_flags & (VM_LOCKED|VM_RESERVED))
 				continue;
 			cursor = (unsigned long) vma->vm_private_data;
-			while (vma->vm_mm->rss &&
+			while (atomic_read(&vma->vm_mm->mm_rss) &&
 				cursor < max_nl_cursor &&
 				cursor < vma->vm_end - vma->vm_start) {
 				try_to_unmap_cluster(cursor, &mapcount, vma);
Index: linus/include/asm-ia64/tlb.h
===================================================================
--- linus.orig/include/asm-ia64/tlb.h	2004-09-18 14:25:23.000000000 -0700
+++ linus/include/asm-ia64/tlb.h	2004-09-18 15:07:23.000000000 -0700
@@ -161,11 +161,11 @@
 {
 	unsigned long freed = tlb->freed;
 	struct mm_struct *mm = tlb->mm;
-	unsigned long rss = mm->rss;
+	unsigned long rss = atomic_read(&mm->mm_rss);

 	if (rss < freed)
 		freed = rss;
-	mm->rss = rss - freed;
+	atomic_sub(freed, &mm->mm_rss);
 	/*
 	 * Note: tlb->nr may be 0 at this point, so we can't rely on tlb->start_addr and
 	 * tlb->end_addr.

