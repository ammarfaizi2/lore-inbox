Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268329AbUJOTFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268329AbUJOTFe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 15:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268328AbUJOTFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 15:05:33 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:30153 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268329AbUJOTEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 15:04:11 -0400
Date: Fri, 15 Oct 2004 12:03:43 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: page fault scalability patch V10: [1/7] make rss atomic
In-Reply-To: <Pine.LNX.4.58.0410151201020.26697@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0410151202520.26697@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0409201348070.4628@schroedinger.engr.sgi.com>
 <20040920205752.GH4242@wotan.suse.de> <200409211841.25507.vda@port.imtp.ilyichevsk.odessa.ua>
 <20040921154542.GB12132@wotan.suse.de> <41527885.8020402@myrealbox.com>
 <20040923090345.GA6146@wotan.suse.de> <Pine.LNX.4.58.0409271204180.31769@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0410151201020.26697@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
	* Make mm->rss atomic, so that rss may be incremented or decremented
	  without holding the page table lock.
	* Prerequisite for page table scalability patch

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.9-rc4/kernel/fork.c
===================================================================
--- linux-2.6.9-rc4.orig/kernel/fork.c	2004-10-10 19:57:03.000000000 -0700
+++ linux-2.6.9-rc4/kernel/fork.c	2004-10-14 12:22:14.000000000 -0700
@@ -296,7 +296,7 @@
 	mm->mmap_cache = NULL;
 	mm->free_area_cache = oldmm->mmap_base;
 	mm->map_count = 0;
-	mm->rss = 0;
+	atomic_set(&mm->mm_rss, 0);
 	cpus_clear(mm->cpu_vm_mask);
 	mm->mm_rb = RB_ROOT;
 	rb_link = &mm->mm_rb.rb_node;
Index: linux-2.6.9-rc4/include/linux/sched.h
===================================================================
--- linux-2.6.9-rc4.orig/include/linux/sched.h	2004-10-10 19:57:03.000000000 -0700
+++ linux-2.6.9-rc4/include/linux/sched.h	2004-10-14 12:22:14.000000000 -0700
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
Index: linux-2.6.9-rc4/fs/proc/task_mmu.c
===================================================================
--- linux-2.6.9-rc4.orig/fs/proc/task_mmu.c	2004-10-10 19:57:06.000000000 -0700
+++ linux-2.6.9-rc4/fs/proc/task_mmu.c	2004-10-14 12:22:14.000000000 -0700
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

Index: linux-2.6.9-rc4/mm/mmap.c
===================================================================
--- linux-2.6.9-rc4.orig/mm/mmap.c	2004-10-10 19:58:06.000000000 -0700
+++ linux-2.6.9-rc4/mm/mmap.c	2004-10-14 12:22:14.000000000 -0700
@@ -1847,7 +1847,7 @@
 	vma = mm->mmap;
 	mm->mmap = mm->mmap_cache = NULL;
 	mm->mm_rb = RB_ROOT;
-	mm->rss = 0;
+	atomic_set(&mm->mm_rss, 0);
 	mm->total_vm = 0;
 	mm->locked_vm = 0;

Index: linux-2.6.9-rc4/include/asm-generic/tlb.h
===================================================================
--- linux-2.6.9-rc4.orig/include/asm-generic/tlb.h	2004-10-10 19:56:36.000000000 -0700
+++ linux-2.6.9-rc4/include/asm-generic/tlb.h	2004-10-14 12:22:14.000000000 -0700
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
Index: linux-2.6.9-rc4/fs/binfmt_flat.c
===================================================================
--- linux-2.6.9-rc4.orig/fs/binfmt_flat.c	2004-10-10 19:56:36.000000000 -0700
+++ linux-2.6.9-rc4/fs/binfmt_flat.c	2004-10-14 12:22:14.000000000 -0700
@@ -650,7 +650,7 @@
 		current->mm->start_brk = datapos + data_len + bss_len;
 		current->mm->brk = (current->mm->start_brk + 3) & ~3;
 		current->mm->context.end_brk = memp + ksize((void *) memp) - stack_len;
-		current->mm->rss = 0;
+		atomic_set(current->mm->mm_rss, 0);
 	}

 	if (flags & FLAT_FLAG_KTRACE)
Index: linux-2.6.9-rc4/fs/exec.c
===================================================================
--- linux-2.6.9-rc4.orig/fs/exec.c	2004-10-10 19:57:30.000000000 -0700
+++ linux-2.6.9-rc4/fs/exec.c	2004-10-14 12:22:14.000000000 -0700
@@ -319,7 +319,7 @@
 		pte_unmap(pte);
 		goto out;
 	}
-	mm->rss++;
+	atomic_inc(&mm->mm_rss);
 	lru_cache_add_active(page);
 	set_pte(pte, pte_mkdirty(pte_mkwrite(mk_pte(
 					page, vma->vm_page_prot))));
Index: linux-2.6.9-rc4/mm/memory.c
===================================================================
--- linux-2.6.9-rc4.orig/mm/memory.c	2004-10-10 19:57:50.000000000 -0700
+++ linux-2.6.9-rc4/mm/memory.c	2004-10-14 12:22:14.000000000 -0700
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
Index: linux-2.6.9-rc4/fs/binfmt_som.c
===================================================================
--- linux-2.6.9-rc4.orig/fs/binfmt_som.c	2004-10-10 19:57:30.000000000 -0700
+++ linux-2.6.9-rc4/fs/binfmt_som.c	2004-10-14 12:22:14.000000000 -0700
@@ -259,7 +259,7 @@
 	create_som_tables(bprm);

 	current->mm->start_stack = bprm->p;
-	current->mm->rss = 0;
+	atomic_set(current->mm->mm_rss, 0);

 #if 0
 	printk("(start_brk) %08lx\n" , (unsigned long) current->mm->start_brk);
Index: linux-2.6.9-rc4/mm/fremap.c
===================================================================
--- linux-2.6.9-rc4.orig/mm/fremap.c	2004-10-10 19:56:40.000000000 -0700
+++ linux-2.6.9-rc4/mm/fremap.c	2004-10-14 12:22:14.000000000 -0700
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
Index: linux-2.6.9-rc4/mm/swapfile.c
===================================================================
--- linux-2.6.9-rc4.orig/mm/swapfile.c	2004-10-10 19:57:07.000000000 -0700
+++ linux-2.6.9-rc4/mm/swapfile.c	2004-10-14 12:22:14.000000000 -0700
@@ -430,7 +430,7 @@
 unuse_pte(struct vm_area_struct *vma, unsigned long address, pte_t *dir,
 	swp_entry_t entry, struct page *page)
 {
-	vma->vm_mm->rss++;
+	atomic_inc(&vma->vm_mm->mm_rss);
 	get_page(page);
 	set_pte(dir, pte_mkold(mk_pte(page, vma->vm_page_prot)));
 	page_add_anon_rmap(page, vma, address);
Index: linux-2.6.9-rc4/fs/binfmt_aout.c
===================================================================
--- linux-2.6.9-rc4.orig/fs/binfmt_aout.c	2004-10-10 19:57:06.000000000 -0700
+++ linux-2.6.9-rc4/fs/binfmt_aout.c	2004-10-14 12:22:14.000000000 -0700
@@ -309,7 +309,7 @@
 		(current->mm->start_brk = N_BSSADDR(ex));
 	current->mm->free_area_cache = current->mm->mmap_base;

-	current->mm->rss = 0;
+	atomic_set(&current->mm->mm_rss, 0);
 	current->mm->mmap = NULL;
 	compute_creds(bprm);
  	current->flags &= ~PF_FORKNOEXEC;
Index: linux-2.6.9-rc4/arch/ia64/mm/hugetlbpage.c
===================================================================
--- linux-2.6.9-rc4.orig/arch/ia64/mm/hugetlbpage.c	2004-10-10 19:57:59.000000000 -0700
+++ linux-2.6.9-rc4/arch/ia64/mm/hugetlbpage.c	2004-10-14 12:22:14.000000000 -0700
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

Index: linux-2.6.9-rc4/fs/proc/array.c
===================================================================
--- linux-2.6.9-rc4.orig/fs/proc/array.c	2004-10-10 19:58:06.000000000 -0700
+++ linux-2.6.9-rc4/fs/proc/array.c	2004-10-14 12:22:14.000000000 -0700
@@ -388,7 +388,7 @@
 		jiffies_to_clock_t(task->it_real_value),
 		start_time,
 		vsize,
-		mm ? mm->rss : 0, /* you might want to shift this left 3 */
+		mm ? (unsigned long)atomic_read(&mm->mm_rss) : 0, /* you might want to shift this left 3 */
 		task->rlim[RLIMIT_RSS].rlim_cur,
 		mm ? mm->start_code : 0,
 		mm ? mm->end_code : 0,
Index: linux-2.6.9-rc4/fs/binfmt_elf.c
===================================================================
--- linux-2.6.9-rc4.orig/fs/binfmt_elf.c	2004-10-10 19:57:50.000000000 -0700
+++ linux-2.6.9-rc4/fs/binfmt_elf.c	2004-10-14 12:22:14.000000000 -0700
@@ -716,7 +716,7 @@

 	/* Do this so that we can load the interpreter, if need be.  We will
 	   change some of these later */
-	current->mm->rss = 0;
+	atomic_set(&current->mm->mm_rss, 0);
 	current->mm->free_area_cache = current->mm->mmap_base;
 	retval = setup_arg_pages(bprm, executable_stack);
 	if (retval < 0) {
Index: linux-2.6.9-rc4/mm/rmap.c
===================================================================
--- linux-2.6.9-rc4.orig/mm/rmap.c	2004-10-10 19:58:49.000000000 -0700
+++ linux-2.6.9-rc4/mm/rmap.c	2004-10-14 12:22:14.000000000 -0700
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
Index: linux-2.6.9-rc4/include/asm-ia64/tlb.h
===================================================================
--- linux-2.6.9-rc4.orig/include/asm-ia64/tlb.h	2004-10-10 19:57:44.000000000 -0700
+++ linux-2.6.9-rc4/include/asm-ia64/tlb.h	2004-10-14 12:22:14.000000000 -0700
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
Index: linux-2.6.9-rc4/include/asm-arm/tlb.h
===================================================================
--- linux-2.6.9-rc4.orig/include/asm-arm/tlb.h	2004-10-10 19:56:40.000000000 -0700
+++ linux-2.6.9-rc4/include/asm-arm/tlb.h	2004-10-14 12:22:14.000000000 -0700
@@ -54,11 +54,11 @@
 {
 	struct mm_struct *mm = tlb->mm;
 	unsigned long freed = tlb->freed;
-	int rss = mm->rss;
+	int rss = atomic_read(&mm->mm_rss);

 	if (rss < freed)
 		freed = rss;
-	mm->rss = rss - freed;
+	atomic_sub(freed, &mm->mm_rss);

 	if (freed) {
 		flush_tlb_mm(mm);
Index: linux-2.6.9-rc4/include/asm-arm26/tlb.h
===================================================================
--- linux-2.6.9-rc4.orig/include/asm-arm26/tlb.h	2004-10-10 19:58:56.000000000 -0700
+++ linux-2.6.9-rc4/include/asm-arm26/tlb.h	2004-10-14 12:22:14.000000000 -0700
@@ -35,11 +35,11 @@
 {
         struct mm_struct *mm = tlb->mm;
         unsigned long freed = tlb->freed;
-        int rss = mm->rss;
+        int rss = atomic_read(&mm->mm_rss);

         if (rss < freed)
                 freed = rss;
-        mm->rss = rss - freed;
+        atomic_sub(freed, &mm->mm_rss);

         if (freed) {
                 flush_tlb_mm(mm);
Index: linux-2.6.9-rc4/include/asm-sparc64/tlb.h
===================================================================
--- linux-2.6.9-rc4.orig/include/asm-sparc64/tlb.h	2004-10-10 19:58:24.000000000 -0700
+++ linux-2.6.9-rc4/include/asm-sparc64/tlb.h	2004-10-14 12:22:14.000000000 -0700
@@ -80,11 +80,11 @@
 {
 	unsigned long freed = mp->freed;
 	struct mm_struct *mm = mp->mm;
-	unsigned long rss = mm->rss;
+	unsigned long rss = atomic_read(&mm->mm_rss);

 	if (rss < freed)
 		freed = rss;
-	mm->rss = rss - freed;
+	atomic_sub(freed, &mm->mm_rss);

 	tlb_flush_mmu(mp);

Index: linux-2.6.9-rc4/arch/sh/mm/hugetlbpage.c
===================================================================
--- linux-2.6.9-rc4.orig/arch/sh/mm/hugetlbpage.c	2004-10-10 19:58:06.000000000 -0700
+++ linux-2.6.9-rc4/arch/sh/mm/hugetlbpage.c	2004-10-14 12:22:14.000000000 -0700
@@ -62,7 +62,7 @@
 	unsigned long i;
 	pte_t entry;

-	mm->rss += (HPAGE_SIZE / PAGE_SIZE);
+	atomic_add(HPAGE_SIZE / PAGE_SIZE, &mm->mm_rss);

 	if (write_access)
 		entry = pte_mkwrite(pte_mkdirty(mk_pte(page,
@@ -115,7 +115,7 @@
 			pte_val(entry) += PAGE_SIZE;
 			dst_pte++;
 		}
-		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
+		atomic_add(HPAGE_SIZE / PAGE_SIZE, &dst->mm_rss);
 		addr += HPAGE_SIZE;
 	}
 	return 0;
@@ -206,7 +206,7 @@
 			pte++;
 		}
 	}
-	mm->rss -= (end - start) >> PAGE_SHIFT;
+	atomic_sub((end - start) >> PAGE_SHIFT, &mm->mm_rss);
 	flush_tlb_range(vma, start, end);
 }

Index: linux-2.6.9-rc4/arch/x86_64/ia32/ia32_aout.c
===================================================================
--- linux-2.6.9-rc4.orig/arch/x86_64/ia32/ia32_aout.c	2004-10-10 19:58:56.000000000 -0700
+++ linux-2.6.9-rc4/arch/x86_64/ia32/ia32_aout.c	2004-10-14 12:22:14.000000000 -0700
@@ -309,7 +309,7 @@
 		(current->mm->start_brk = N_BSSADDR(ex));
 	current->mm->free_area_cache = TASK_UNMAPPED_BASE;

-	current->mm->rss = 0;
+	atomic_set(&current->mm->mm_rss. 0);
 	current->mm->mmap = NULL;
 	compute_creds(bprm);
  	current->flags &= ~PF_FORKNOEXEC;
Index: linux-2.6.9-rc4/arch/ppc64/mm/hugetlbpage.c
===================================================================
--- linux-2.6.9-rc4.orig/arch/ppc64/mm/hugetlbpage.c	2004-10-10 19:57:59.000000000 -0700
+++ linux-2.6.9-rc4/arch/ppc64/mm/hugetlbpage.c	2004-10-14 12:22:14.000000000 -0700
@@ -125,7 +125,7 @@
 	hugepte_t entry;
 	int i;

-	mm->rss += (HPAGE_SIZE / PAGE_SIZE);
+	atomic_add(HPAGE_SIZE / PAGE_SIZE, &mm->mm_rss);
 	entry = mk_hugepte(page, write_access);
 	for (i = 0; i < HUGEPTE_BATCH_SIZE; i++)
 		set_hugepte(ptep+i, entry);
@@ -287,7 +287,7 @@
 			/* This is the first hugepte in a batch */
 			ptepage = hugepte_page(entry);
 			get_page(ptepage);
-			dst->rss += (HPAGE_SIZE / PAGE_SIZE);
+			atomic_add(HPAGE_SIZE / PAGE_SIZE, &dst->mm_rss);
 		}
 		set_hugepte(dst_pte, entry);

@@ -410,7 +410,7 @@
 	}
 	put_cpu();

-	mm->rss -= (end - start) >> PAGE_SHIFT;
+	atomic_sub((end - start) >> PAGE_SHIFT, &mm->mm_rss);
 }

 int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
Index: linux-2.6.9-rc4/arch/sh64/mm/hugetlbpage.c
===================================================================
--- linux-2.6.9-rc4.orig/arch/sh64/mm/hugetlbpage.c	2004-10-10 19:57:30.000000000 -0700
+++ linux-2.6.9-rc4/arch/sh64/mm/hugetlbpage.c	2004-10-14 12:22:14.000000000 -0700
@@ -62,7 +62,7 @@
 	unsigned long i;
 	pte_t entry;

-	mm->rss += (HPAGE_SIZE / PAGE_SIZE);
+	atomic_add(HPAGE_SIZE / PAGE_SIZE, &mm->mm_rss);

 	if (write_access)
 		entry = pte_mkwrite(pte_mkdirty(mk_pte(page,
@@ -115,7 +115,7 @@
 			pte_val(entry) += PAGE_SIZE;
 			dst_pte++;
 		}
-		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
+		atomic_add(HPAGE_SIZE / PAGE_SIZE, &dst->mm_rss);
 		addr += HPAGE_SIZE;
 	}
 	return 0;
@@ -206,7 +206,7 @@
 			pte++;
 		}
 	}
-	mm->rss -= (end - start) >> PAGE_SHIFT;
+	atomic_sub((end - start) >> PAGE_SHIFT, &mm->mm_rss);
 	flush_tlb_range(vma, start, end);
 }

Index: linux-2.6.9-rc4/arch/sparc64/mm/hugetlbpage.c
===================================================================
--- linux-2.6.9-rc4.orig/arch/sparc64/mm/hugetlbpage.c	2004-10-10 19:58:07.000000000 -0700
+++ linux-2.6.9-rc4/arch/sparc64/mm/hugetlbpage.c	2004-10-14 12:22:14.000000000 -0700
@@ -59,7 +59,7 @@
 	unsigned long i;
 	pte_t entry;

-	mm->rss += (HPAGE_SIZE / PAGE_SIZE);
+	atomic_add(HPAGE_SIZE / PAGE_SIZE, &mm->mm_rss);

 	if (write_access)
 		entry = pte_mkwrite(pte_mkdirty(mk_pte(page,
@@ -112,7 +112,7 @@
 			pte_val(entry) += PAGE_SIZE;
 			dst_pte++;
 		}
-		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
+		atomic_add(HPAGE_SIZE / PAGE_SIZE, &dst->mm_rss);
 		addr += HPAGE_SIZE;
 	}
 	return 0;
@@ -203,7 +203,7 @@
 			pte++;
 		}
 	}
-	mm->rss -= (end - start) >> PAGE_SHIFT;
+	atomic_sub((end - start) >> PAGE_SHIFT, &mm->mm_rss);
 	flush_tlb_range(vma, start, end);
 }

Index: linux-2.6.9-rc4/arch/mips/kernel/irixelf.c
===================================================================
--- linux-2.6.9-rc4.orig/arch/mips/kernel/irixelf.c	2004-10-10 19:58:56.000000000 -0700
+++ linux-2.6.9-rc4/arch/mips/kernel/irixelf.c	2004-10-14 12:22:14.000000000 -0700
@@ -686,7 +686,7 @@
 	/* Do this so that we can load the interpreter, if need be.  We will
 	 * change some of these later.
 	 */
-	current->mm->rss = 0;
+	atomic_set(&current->mm->mm_rss, 0);
 	setup_arg_pages(bprm, EXSTACK_DEFAULT);
 	current->mm->start_stack = bprm->p;

Index: linux-2.6.9-rc4/arch/m68k/atari/stram.c
===================================================================
--- linux-2.6.9-rc4.orig/arch/m68k/atari/stram.c	2004-10-10 19:58:24.000000000 -0700
+++ linux-2.6.9-rc4/arch/m68k/atari/stram.c	2004-10-14 12:22:14.000000000 -0700
@@ -635,7 +635,7 @@
 	set_pte(dir, pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
 	swap_free(entry);
 	get_page(page);
-	++vma->vm_mm->rss;
+	atomic_inc(&vma->vm_mm->mm_rss);
 }

 static inline void unswap_pmd(struct vm_area_struct * vma, pmd_t *dir,
Index: linux-2.6.9-rc4/arch/i386/mm/hugetlbpage.c
===================================================================
--- linux-2.6.9-rc4.orig/arch/i386/mm/hugetlbpage.c	2004-10-10 19:58:49.000000000 -0700
+++ linux-2.6.9-rc4/arch/i386/mm/hugetlbpage.c	2004-10-14 12:22:14.000000000 -0700
@@ -42,7 +42,7 @@
 {
 	pte_t entry;

-	mm->rss += (HPAGE_SIZE / PAGE_SIZE);
+	atomic_add(HPAGE_SIZE / PAGE_SIZE, &mm->mm_rss);
 	if (write_access) {
 		entry =
 		    pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
@@ -82,7 +82,7 @@
 		ptepage = pte_page(entry);
 		get_page(ptepage);
 		set_pte(dst_pte, entry);
-		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
+		atomic_add(HPAGE_SIZE / PAGE_SIZE, &dst->mm_rss);
 		addr += HPAGE_SIZE;
 	}
 	return 0;
@@ -218,7 +218,7 @@
 		page = pte_page(pte);
 		put_page(page);
 	}
-	mm->rss -= (end - start) >> PAGE_SHIFT;
+	atomic_sub((end - start) >> PAGE_SHIFT, &mm->mm_rss);
 	flush_tlb_range(vma, start, end);
 }

Index: linux-2.6.9-rc4/arch/sparc64/kernel/binfmt_aout32.c
===================================================================
--- linux-2.6.9-rc4.orig/arch/sparc64/kernel/binfmt_aout32.c	2004-10-10 19:57:59.000000000 -0700
+++ linux-2.6.9-rc4/arch/sparc64/kernel/binfmt_aout32.c	2004-10-14 12:22:14.000000000 -0700
@@ -239,7 +239,7 @@
 	current->mm->brk = ex.a_bss +
 		(current->mm->start_brk = N_BSSADDR(ex));

-	current->mm->rss = 0;
+	atomic_set(&current->mm->mm_rss, 0);
 	current->mm->mmap = NULL;
 	compute_creds(bprm);
  	current->flags &= ~PF_FORKNOEXEC;
