Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbVAKSH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVAKSH2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 13:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVAKSCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 13:02:24 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:29642 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261501AbVAKRob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 12:44:31 -0500
Date: Tue, 11 Jan 2005 09:44:18 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: torvalds@osdl.org, Andi Kleen <ak@muc.de>
cc: Hugh Dickins <hugh@veritas.com>, akpm@osdl.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: page table lock patch V15 [7/7]: Split RSS counter
In-Reply-To: <Pine.LNX.4.58.0501110937450.32744@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0501110943330.32744@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
 <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412011545060.5721@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0501041129030.805@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0501041137410.805@schroedinger.engr.sgi.com> <m1652ddljp.fsf@muc.de>
 <Pine.LNX.4.58.0501110937450.32744@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
	* Split rss counter into the task structure
	* remove 3 checks of rss in mm/rmap.c
	* increment current->rss instead of mm->rss in the page fault handler
	* move incrementing of anon_rss out of page_add_anon_rmap to group
	  the increments more tightly and allow a better cache utilization

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.10/include/linux/sched.h
===================================================================
--- linux-2.6.10.orig/include/linux/sched.h	2005-01-11 08:46:16.000000000 -0800
+++ linux-2.6.10/include/linux/sched.h	2005-01-11 08:56:45.000000000 -0800
@@ -31,6 +31,7 @@
 #include <linux/pid.h>
 #include <linux/percpu.h>
 #include <linux/topology.h>
+#include <linux/rcupdate.h>

 struct exec_domain;

@@ -216,6 +217,7 @@
 	int map_count;				/* number of VMAs */
 	struct rw_semaphore mmap_sem;
 	spinlock_t page_table_lock;		/* Protects page tables, mm->rss, mm->anon_rss */
+	long rss, anon_rss;

 	struct list_head mmlist;		/* List of maybe swapped mm's.  These are globally strung
 						 * together off init_mm.mmlist, and are protected
@@ -225,7 +227,7 @@
 	unsigned long start_code, end_code, start_data, end_data;
 	unsigned long start_brk, brk, start_stack;
 	unsigned long arg_start, arg_end, env_start, env_end;
-	unsigned long rss, anon_rss, total_vm, locked_vm, shared_vm;
+	unsigned long total_vm, locked_vm, shared_vm;
 	unsigned long exec_vm, stack_vm, reserved_vm, def_flags, nr_ptes;

 	unsigned long saved_auxv[42]; /* for /proc/PID/auxv */
@@ -235,6 +237,7 @@

 	/* Architecture-specific MM context */
 	mm_context_t context;
+	struct list_head task_list;             /* Tasks using this mm */

 	/* Token based thrashing protection. */
 	unsigned long swap_token_time;
@@ -555,6 +558,9 @@
 	struct list_head ptrace_list;

 	struct mm_struct *mm, *active_mm;
+	/* Split counters from mm */
+	long rss;
+	long anon_rss;

 /* task state */
 	struct linux_binfmt *binfmt;
@@ -587,6 +593,10 @@
 	struct completion *vfork_done;		/* for vfork() */
 	int __user *set_child_tid;		/* CLONE_CHILD_SETTID */
 	int __user *clear_child_tid;		/* CLONE_CHILD_CLEARTID */
+
+	/* List of other tasks using the same mm */
+	struct list_head mm_tasks;
+	struct rcu_head rcu_head;               /* For freeing the task via rcu */

 	unsigned long rt_priority;
 	unsigned long it_real_value, it_prof_value, it_virt_value;
@@ -1184,6 +1194,11 @@
 	return 0;
 }
 #endif /* CONFIG_PM */
+
+void get_rss(struct mm_struct *mm, unsigned long *rss, unsigned long *anon_rss);
+void mm_remove_thread(struct mm_struct *mm, struct task_struct *tsk);
+void mm_add_thread(struct mm_struct *mm, struct task_struct *tsk);
+
 #endif /* __KERNEL__ */

 #endif
Index: linux-2.6.10/fs/proc/task_mmu.c
===================================================================
--- linux-2.6.10.orig/fs/proc/task_mmu.c	2005-01-11 08:46:15.000000000 -0800
+++ linux-2.6.10/fs/proc/task_mmu.c	2005-01-11 08:56:45.000000000 -0800
@@ -8,8 +8,9 @@

 char *task_mem(struct mm_struct *mm, char *buffer)
 {
-	unsigned long data, text, lib;
+	unsigned long data, text, lib, rss, anon_rss;

+	get_rss(mm, &rss, &anon_rss);
 	data = mm->total_vm - mm->shared_vm - mm->stack_vm;
 	text = (PAGE_ALIGN(mm->end_code) - (mm->start_code & PAGE_MASK)) >> 10;
 	lib = (mm->exec_vm << (PAGE_SHIFT-10)) - text;
@@ -24,7 +25,7 @@
 		"VmPTE:\t%8lu kB\n",
 		(mm->total_vm - mm->reserved_vm) << (PAGE_SHIFT-10),
 		mm->locked_vm << (PAGE_SHIFT-10),
-		mm->rss << (PAGE_SHIFT-10),
+		rss << (PAGE_SHIFT-10),
 		data << (PAGE_SHIFT-10),
 		mm->stack_vm << (PAGE_SHIFT-10), text, lib,
 		(PTRS_PER_PTE*sizeof(pte_t)*mm->nr_ptes) >> 10);
@@ -39,11 +40,14 @@
 int task_statm(struct mm_struct *mm, int *shared, int *text,
 	       int *data, int *resident)
 {
-	*shared = mm->rss - mm->anon_rss;
+	unsigned long rss, anon_rss;
+
+	get_rss(mm, &rss, &anon_rss);
+	*shared = rss - anon_rss;
 	*text = (PAGE_ALIGN(mm->end_code) - (mm->start_code & PAGE_MASK))
 								>> PAGE_SHIFT;
 	*data = mm->total_vm - mm->shared_vm;
-	*resident = mm->rss;
+	*resident = rss;
 	return mm->total_vm;
 }

Index: linux-2.6.10/fs/proc/array.c
===================================================================
--- linux-2.6.10.orig/fs/proc/array.c	2005-01-11 08:46:15.000000000 -0800
+++ linux-2.6.10/fs/proc/array.c	2005-01-11 08:56:45.000000000 -0800
@@ -303,7 +303,7 @@

 static int do_task_stat(struct task_struct *task, char * buffer, int whole)
 {
-	unsigned long vsize, eip, esp, wchan = ~0UL;
+	unsigned long rss, anon_rss, vsize, eip, esp, wchan = ~0UL;
 	long priority, nice;
 	int tty_pgrp = -1, tty_nr = 0;
 	sigset_t sigign, sigcatch;
@@ -326,6 +326,7 @@
 		vsize = task_vsize(mm);
 		eip = KSTK_EIP(task);
 		esp = KSTK_ESP(task);
+		get_rss(mm, &rss, &anon_rss);
 	}

 	get_task_comm(tcomm, task);
@@ -421,7 +422,7 @@
 		jiffies_to_clock_t(task->it_real_value),
 		start_time,
 		vsize,
-		mm ? mm->rss : 0, /* you might want to shift this left 3 */
+		mm ? rss : 0, /* you might want to shift this left 3 */
 	        rsslim,
 		mm ? mm->start_code : 0,
 		mm ? mm->end_code : 0,
Index: linux-2.6.10/mm/rmap.c
===================================================================
--- linux-2.6.10.orig/mm/rmap.c	2005-01-11 08:48:30.000000000 -0800
+++ linux-2.6.10/mm/rmap.c	2005-01-11 08:56:45.000000000 -0800
@@ -258,8 +258,6 @@
 	pte_t *pte;
 	int referenced = 0;

-	if (!mm->rss)
-		goto out;
 	address = vma_address(page, vma);
 	if (address == -EFAULT)
 		goto out;
@@ -440,8 +438,6 @@
 	BUG_ON(PageReserved(page));
 	BUG_ON(!anon_vma);

-	vma->vm_mm->anon_rss++;
-
 	anon_vma = (void *) anon_vma + PAGE_MAPPING_ANON;
 	index = (address - vma->vm_start) >> PAGE_SHIFT;
 	index += vma->vm_pgoff;
@@ -513,8 +509,6 @@
 	pte_t pteval;
 	int ret = SWAP_AGAIN;

-	if (!mm->rss)
-		goto out;
 	address = vma_address(page, vma);
 	if (address == -EFAULT)
 		goto out;
@@ -813,8 +807,7 @@
 			if (vma->vm_flags & (VM_LOCKED|VM_RESERVED))
 				continue;
 			cursor = (unsigned long) vma->vm_private_data;
-			while (vma->vm_mm->rss &&
-				cursor < max_nl_cursor &&
+			while (cursor < max_nl_cursor &&
 				cursor < vma->vm_end - vma->vm_start) {
 				try_to_unmap_cluster(cursor, &mapcount, vma);
 				cursor += CLUSTER_SIZE;
Index: linux-2.6.10/kernel/fork.c
===================================================================
--- linux-2.6.10.orig/kernel/fork.c	2005-01-11 08:46:16.000000000 -0800
+++ linux-2.6.10/kernel/fork.c	2005-01-11 08:56:45.000000000 -0800
@@ -79,10 +79,16 @@
 static kmem_cache_t *task_struct_cachep;
 #endif

+static void rcu_free_task(struct rcu_head *head)
+{
+	struct task_struct *tsk = container_of(head ,struct task_struct, rcu_head);
+	free_task_struct(tsk);
+}
+
 void free_task(struct task_struct *tsk)
 {
 	free_thread_info(tsk->thread_info);
-	free_task_struct(tsk);
+	call_rcu(&tsk->rcu_head, rcu_free_task);
 }
 EXPORT_SYMBOL(free_task);

@@ -99,7 +105,7 @@
 	put_group_info(tsk->group_info);

 	if (!profile_handoff_task(tsk))
-		free_task(tsk);
+		call_rcu(&tsk->rcu_head, rcu_free_task);
 }

 void __init fork_init(unsigned long mempages)
@@ -152,6 +158,7 @@
 	*tsk = *orig;
 	tsk->thread_info = ti;
 	ti->task = tsk;
+	tsk->rss = 0;

 	/* One for us, one for whoever does the "release_task()" (usually parent) */
 	atomic_set(&tsk->usage,2);
@@ -294,6 +301,7 @@
 	atomic_set(&mm->mm_count, 1);
 	init_rwsem(&mm->mmap_sem);
 	INIT_LIST_HEAD(&mm->mmlist);
+	INIT_LIST_HEAD(&mm->task_list);
 	mm->core_waiters = 0;
 	mm->nr_ptes = 0;
 	spin_lock_init(&mm->page_table_lock);
@@ -402,6 +410,8 @@

 	/* Get rid of any cached register state */
 	deactivate_mm(tsk, mm);
+	if (mm)
+		mm_remove_thread(mm, tsk);

 	/* notify parent sleeping on vfork() */
 	if (vfork_done) {
@@ -449,8 +459,8 @@
 		 * new threads start up in user mode using an mm, which
 		 * allows optimizing out ipis; the tlb_gather_mmu code
 		 * is an example.
+		 * (mm_add_thread does use the ptl .... )
 		 */
-		spin_unlock_wait(&oldmm->page_table_lock);
 		goto good_mm;
 	}

@@ -475,6 +485,7 @@
 	mm->hiwater_vm = mm->total_vm;

 good_mm:
+	mm_add_thread(mm, tsk);
 	tsk->mm = mm;
 	tsk->active_mm = mm;
 	return 0;
@@ -1079,7 +1090,7 @@
 	atomic_dec(&p->user->processes);
 	free_uid(p->user);
 bad_fork_free:
-	free_task(p);
+	call_rcu(&p->rcu_head, rcu_free_task);
 	goto fork_out;
 }

Index: linux-2.6.10/mm/memory.c
===================================================================
--- linux-2.6.10.orig/mm/memory.c	2005-01-11 08:56:37.000000000 -0800
+++ linux-2.6.10/mm/memory.c	2005-01-11 08:56:45.000000000 -0800
@@ -935,6 +935,7 @@

 			cond_resched_lock(&mm->page_table_lock);
 			while (!(map = follow_page(mm, start, lookup_write))) {
+				unsigned long rss, anon_rss;
 				/*
 				 * Shortcut for anonymous pages. We don't want
 				 * to force the creation of pages tables for
@@ -947,6 +948,17 @@
 					map = ZERO_PAGE(start);
 					break;
 				}
+				if (mm != current->mm) {
+					/*
+					 * handle_mm_fault uses the current pointer
+					 * for a split rss counter. The current pointer
+					 * is not correct if we are using a different mm
+					 */
+					rss = current->rss;
+					anon_rss = current->anon_rss;
+					current->rss = 0;
+					current->anon_rss = 0;
+				}
 				spin_unlock(&mm->page_table_lock);
 				switch (handle_mm_fault(mm,vma,start,write)) {
 				case VM_FAULT_MINOR:
@@ -971,6 +983,12 @@
 				 */
 				lookup_write = write && !force;
 				spin_lock(&mm->page_table_lock);
+				if (mm != current->mm) {
+					mm->rss += current->rss;
+					mm->anon_rss += current->anon_rss;
+					current->rss = rss;
+					current->anon_rss = anon_rss;
+				}
 			}
 			if (pages) {
 				pages[i] = get_page_map(map);
@@ -1353,6 +1371,7 @@
 		break_cow(vma, new_page, address, page_table);
 		lru_cache_add_active(new_page);
 		page_add_anon_rmap(new_page, vma, address);
+		mm->anon_rss++;

 		/* Free the old page.. */
 		new_page = old_page;
@@ -1753,6 +1772,7 @@
 	flush_icache_page(vma, page);
 	set_pte(page_table, pte);
 	page_add_anon_rmap(page, vma, address);
+	mm->anon_rss++;

 	if (write_access) {
 		if (do_wp_page(mm, vma, address,
@@ -1815,6 +1835,7 @@
 		page_add_anon_rmap(page, vma, addr);
 		lru_cache_add_active(page);
 		mm->rss++;
+		mm->anon_rss++;
 		acct_update_integrals();
 		update_mem_hiwater();

@@ -1922,6 +1943,7 @@
 		if (anon) {
 			lru_cache_add_active(new_page);
 			page_add_anon_rmap(new_page, vma, address);
+			mm->anon_rss++;
 		} else
 			page_add_file_rmap(new_page);
 		pte_unmap(page_table);
@@ -2250,6 +2272,49 @@

 EXPORT_SYMBOL(vmalloc_to_pfn);

+void get_rss(struct mm_struct *mm, unsigned long *rss, unsigned long *anon_rss)
+{
+	struct list_head *y;
+	struct task_struct *t;
+	long rss_sum, anon_rss_sum;
+
+	rcu_read_lock();
+	rss_sum = mm->rss;
+	anon_rss_sum = mm->anon_rss;
+	list_for_each_rcu(y, &mm->task_list) {
+		t = list_entry(y, struct task_struct, mm_tasks);
+		rss_sum += t->rss;
+		anon_rss_sum += t->anon_rss;
+	}
+	if (rss_sum < 0)
+		rss_sum = 0;
+	if (anon_rss_sum < 0)
+		anon_rss_sum = 0;
+	rcu_read_unlock();
+	*rss = rss_sum;
+	*anon_rss = anon_rss_sum;
+}
+
+void mm_remove_thread(struct mm_struct *mm, struct task_struct *tsk)
+{
+	if (!mm)
+		return;
+
+	spin_lock(&mm->page_table_lock);
+	mm->rss += tsk->rss;
+	mm->anon_rss += tsk->anon_rss;
+	list_del_rcu(&tsk->mm_tasks);
+	spin_unlock(&mm->page_table_lock);
+}
+
+void mm_add_thread(struct mm_struct *mm, struct task_struct *tsk)
+{
+	spin_lock(&mm->page_table_lock);
+	tsk->rss = 0;
+	tsk->anon_rss = 0;
+	list_add_rcu(&tsk->mm_tasks, &mm->task_list);
+	spin_unlock(&mm->page_table_lock);
+}
 /*
  * update_mem_hiwater
  *	- update per process rss and vm high water data
Index: linux-2.6.10/include/linux/init_task.h
===================================================================
--- linux-2.6.10.orig/include/linux/init_task.h	2005-01-11 08:46:16.000000000 -0800
+++ linux-2.6.10/include/linux/init_task.h	2005-01-11 08:56:45.000000000 -0800
@@ -42,6 +42,7 @@
 	.mmlist		= LIST_HEAD_INIT(name.mmlist),		\
 	.cpu_vm_mask	= CPU_MASK_ALL,				\
 	.default_kioctx = INIT_KIOCTX(name.default_kioctx, name),	\
+	.task_list	= LIST_HEAD_INIT(name.task_list),	\
 }

 #define INIT_SIGNALS(sig) {	\
@@ -112,6 +113,7 @@
 	.proc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
+	.mm_tasks	= LIST_HEAD_INIT(tsk.mm_tasks),			\
 }


Index: linux-2.6.10/fs/exec.c
===================================================================
--- linux-2.6.10.orig/fs/exec.c	2005-01-11 08:46:15.000000000 -0800
+++ linux-2.6.10/fs/exec.c	2005-01-11 08:56:45.000000000 -0800
@@ -556,6 +556,7 @@
 	tsk->active_mm = mm;
 	activate_mm(active_mm, mm);
 	task_unlock(tsk);
+	mm_add_thread(mm, current);
 	arch_pick_mmap_layout(mm);
 	if (old_mm) {
 		if (active_mm != old_mm) BUG();
Index: linux-2.6.10/fs/aio.c
===================================================================
--- linux-2.6.10.orig/fs/aio.c	2004-12-24 13:34:44.000000000 -0800
+++ linux-2.6.10/fs/aio.c	2005-01-11 08:56:45.000000000 -0800
@@ -577,6 +577,7 @@
 	tsk->active_mm = mm;
 	activate_mm(active_mm, mm);
 	task_unlock(tsk);
+	mm_add_thread(mm, tsk);

 	mmdrop(active_mm);
 }
@@ -596,6 +597,7 @@
 {
 	struct task_struct *tsk = current;

+	mm_remove_thread(mm,tsk);
 	task_lock(tsk);
 	tsk->flags &= ~PF_BORROWED_MM;
 	tsk->mm = NULL;
Index: linux-2.6.10/mm/swapfile.c
===================================================================
--- linux-2.6.10.orig/mm/swapfile.c	2005-01-11 08:46:16.000000000 -0800
+++ linux-2.6.10/mm/swapfile.c	2005-01-11 08:56:45.000000000 -0800
@@ -433,6 +433,7 @@
 	swp_entry_t entry, struct page *page)
 {
 	vma->vm_mm->rss++;
+	vma->vm_mm->anon_rss++;
 	get_page(page);
 	set_pte(dir, pte_mkold(mk_pte(page, vma->vm_page_prot)));
 	page_add_anon_rmap(page, vma, address);

