Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbULAXyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbULAXyM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 18:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbULAXyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 18:54:11 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:44247 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261498AbULAXp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 18:45:58 -0500
Date: Wed, 1 Dec 2004 15:45:51 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Hugh Dickins <hugh@veritas.com>, akpm@osdl.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: page fault scalability patch V12 [7/7]: Split counter for rss
In-Reply-To: <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0412011545060.5721@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
 <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
	* Split rss counter into the task structure
	* remove 3 checks of rss in mm/rmap.c
	* Prerequisite for page table scalability patch

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.9/include/linux/sched.h
===================================================================
--- linux-2.6.9.orig/include/linux/sched.h	2004-11-30 20:33:31.000000000 -0800
+++ linux-2.6.9/include/linux/sched.h	2004-11-30 20:33:50.000000000 -0800
@@ -30,6 +30,7 @@
 #include <linux/pid.h>
 #include <linux/percpu.h>
 #include <linux/topology.h>
+#include <linux/rcupdate.h>

 struct exec_domain;

@@ -217,6 +218,7 @@
 	int map_count;				/* number of VMAs */
 	struct rw_semaphore mmap_sem;
 	spinlock_t page_table_lock;		/* Protects page tables, mm->rss, mm->anon_rss */
+	long rss, anon_rss;

 	struct list_head mmlist;		/* List of maybe swapped mm's.  These are globally strung
 						 * together off init_mm.mmlist, and are protected
@@ -226,7 +228,7 @@
 	unsigned long start_code, end_code, start_data, end_data;
 	unsigned long start_brk, brk, start_stack;
 	unsigned long arg_start, arg_end, env_start, env_end;
-	unsigned long rss, anon_rss, total_vm, locked_vm, shared_vm;
+	unsigned long total_vm, locked_vm, shared_vm;
 	unsigned long exec_vm, stack_vm, reserved_vm, def_flags, nr_ptes;

 	unsigned long saved_auxv[42]; /* for /proc/PID/auxv */
@@ -236,6 +238,8 @@

 	/* Architecture-specific MM context */
 	mm_context_t context;
+	struct list_head task_list;		/* Tasks using this mm */
+	struct rcu_head rcu_head;		/* For freeing mm via rcu */

 	/* Token based thrashing protection. */
 	unsigned long swap_token_time;
@@ -545,6 +549,9 @@
 	struct list_head ptrace_list;

 	struct mm_struct *mm, *active_mm;
+	/* Split counters from mm */
+	long rss;
+	long anon_rss;

 /* task state */
 	struct linux_binfmt *binfmt;
@@ -578,6 +585,9 @@
 	struct completion *vfork_done;		/* for vfork() */
 	int __user *set_child_tid;		/* CLONE_CHILD_SETTID */
 	int __user *clear_child_tid;		/* CLONE_CHILD_CLEARTID */
+
+	/* List of other tasks using the same mm */
+	struct list_head mm_tasks;

 	unsigned long rt_priority;
 	unsigned long it_real_value, it_prof_value, it_virt_value;
@@ -1111,6 +1121,14 @@

 #endif

+unsigned long get_rss(struct mm_struct *mm);
+unsigned long get_anon_rss(struct mm_struct *mm);
+unsigned long get_shared(struct mm_struct *mm);
+
+void mm_remove_thread(struct mm_struct *mm, struct task_struct *tsk);
+void mm_add_thread(struct mm_struct *mm, struct task_struct *tsk);
+
 #endif /* __KERNEL__ */

 #endif
+
Index: linux-2.6.9/fs/proc/task_mmu.c
===================================================================
--- linux-2.6.9.orig/fs/proc/task_mmu.c	2004-11-30 20:33:26.000000000 -0800
+++ linux-2.6.9/fs/proc/task_mmu.c	2004-11-30 20:33:50.000000000 -0800
@@ -22,7 +22,7 @@
 		"VmPTE:\t%8lu kB\n",
 		(mm->total_vm - mm->reserved_vm) << (PAGE_SHIFT-10),
 		mm->locked_vm << (PAGE_SHIFT-10),
-		mm->rss << (PAGE_SHIFT-10),
+		get_rss(mm) << (PAGE_SHIFT-10),
 		data << (PAGE_SHIFT-10),
 		mm->stack_vm << (PAGE_SHIFT-10), text, lib,
 		(PTRS_PER_PTE*sizeof(pte_t)*mm->nr_ptes) >> 10);
@@ -37,7 +37,7 @@
 int task_statm(struct mm_struct *mm, int *shared, int *text,
 	       int *data, int *resident)
 {
-	*shared = mm->rss - mm->anon_rss;
+	*shared = get_shared(mm);
 	*text = (PAGE_ALIGN(mm->end_code) - (mm->start_code & PAGE_MASK))
 								>> PAGE_SHIFT;
 	*data = mm->total_vm - mm->shared_vm;
Index: linux-2.6.9/fs/proc/array.c
===================================================================
--- linux-2.6.9.orig/fs/proc/array.c	2004-11-30 20:33:26.000000000 -0800
+++ linux-2.6.9/fs/proc/array.c	2004-11-30 20:33:50.000000000 -0800
@@ -420,7 +420,7 @@
 		jiffies_to_clock_t(task->it_real_value),
 		start_time,
 		vsize,
-		mm ? mm->rss : 0, /* you might want to shift this left 3 */
+		mm ? get_rss(mm) : 0, /* you might want to shift this left 3 */
 	        rsslim,
 		mm ? mm->start_code : 0,
 		mm ? mm->end_code : 0,
Index: linux-2.6.9/mm/rmap.c
===================================================================
--- linux-2.6.9.orig/mm/rmap.c	2004-11-30 20:33:46.000000000 -0800
+++ linux-2.6.9/mm/rmap.c	2004-11-30 20:33:50.000000000 -0800
@@ -263,8 +263,6 @@
 	pte_t *pte;
 	int referenced = 0;

-	if (!mm->rss)
-		goto out;
 	address = vma_address(page, vma);
 	if (address == -EFAULT)
 		goto out;
@@ -438,7 +436,7 @@
 	BUG_ON(PageReserved(page));
 	BUG_ON(!anon_vma);

-	vma->vm_mm->anon_rss++;
+	current->anon_rss++;

 	anon_vma = (void *) anon_vma + PAGE_MAPPING_ANON;
 	index = (address - vma->vm_start) >> PAGE_SHIFT;
@@ -510,8 +508,6 @@
 	pte_t pteval;
 	int ret = SWAP_AGAIN;

-	if (!mm->rss)
-		goto out;
 	address = vma_address(page, vma);
 	if (address == -EFAULT)
 		goto out;
@@ -799,8 +795,7 @@
 			if (vma->vm_flags & (VM_LOCKED|VM_RESERVED))
 				continue;
 			cursor = (unsigned long) vma->vm_private_data;
-			while (vma->vm_mm->rss &&
-				cursor < max_nl_cursor &&
+			while (cursor < max_nl_cursor &&
 				cursor < vma->vm_end - vma->vm_start) {
 				try_to_unmap_cluster(cursor, &mapcount, vma);
 				cursor += CLUSTER_SIZE;
Index: linux-2.6.9/kernel/fork.c
===================================================================
--- linux-2.6.9.orig/kernel/fork.c	2004-11-30 20:33:42.000000000 -0800
+++ linux-2.6.9/kernel/fork.c	2004-11-30 20:33:50.000000000 -0800
@@ -151,6 +151,7 @@
 	*tsk = *orig;
 	tsk->thread_info = ti;
 	ti->task = tsk;
+	tsk->rss = 0;

 	/* One for us, one for whoever does the "release_task()" (usually parent) */
 	atomic_set(&tsk->usage,2);
@@ -292,6 +293,7 @@
 	atomic_set(&mm->mm_count, 1);
 	init_rwsem(&mm->mmap_sem);
 	INIT_LIST_HEAD(&mm->mmlist);
+	INIT_LIST_HEAD(&mm->task_list);
 	mm->core_waiters = 0;
 	mm->nr_ptes = 0;
 	spin_lock_init(&mm->page_table_lock);
@@ -323,6 +325,13 @@
 	return mm;
 }

+static void rcu_free_mm(struct rcu_head *head)
+{
+	struct mm_struct *mm = container_of(head ,struct mm_struct, rcu_head);
+
+	free_mm(mm);
+}
+
 /*
  * Called when the last reference to the mm
  * is dropped: either by a lazy thread or by
@@ -333,7 +342,7 @@
 	BUG_ON(mm == &init_mm);
 	mm_free_pgd(mm);
 	destroy_context(mm);
-	free_mm(mm);
+	call_rcu(&mm->rcu_head, rcu_free_mm);
 }

 /*
@@ -400,6 +409,8 @@

 	/* Get rid of any cached register state */
 	deactivate_mm(tsk, mm);
+	if (mm)
+		mm_remove_thread(mm, tsk);

 	/* notify parent sleeping on vfork() */
 	if (vfork_done) {
@@ -447,8 +458,8 @@
 		 * new threads start up in user mode using an mm, which
 		 * allows optimizing out ipis; the tlb_gather_mmu code
 		 * is an example.
+		 * (mm_add_thread does use the ptl .... )
 		 */
-		spin_unlock_wait(&oldmm->page_table_lock);
 		goto good_mm;
 	}

@@ -470,6 +481,7 @@
 		goto free_pt;

 good_mm:
+	mm_add_thread(mm, tsk);
 	tsk->mm = mm;
 	tsk->active_mm = mm;
 	return 0;
Index: linux-2.6.9/mm/memory.c
===================================================================
--- linux-2.6.9.orig/mm/memory.c	2004-11-30 20:33:46.000000000 -0800
+++ linux-2.6.9/mm/memory.c	2004-11-30 20:33:50.000000000 -0800
@@ -1467,7 +1467,7 @@
 		 */
 		lru_cache_add_active(page);
 		page_add_anon_rmap(page, vma, addr);
-		mm->rss++;
+		current->rss++;

 	}
 	pte_unmap(page_table);
@@ -1859,3 +1859,87 @@
 }

 #endif
+
+unsigned long get_rss(struct mm_struct *mm)
+{
+	struct list_head *y;
+	struct task_struct *t;
+        long rss;
+
+	if (!mm)
+		return 0;
+
+	rcu_read_lock();
+	rss = mm->rss;
+	list_for_each_rcu(y, &mm->task_list) {
+		t = list_entry(y, struct task_struct, mm_tasks);
+		rss += t->rss;
+	}
+	if (rss < 0)
+		rss = 0;
+	rcu_read_unlock();
+	return rss;
+}
+
+unsigned long get_anon_rss(struct mm_struct *mm)
+{
+	struct list_head *y;
+	struct task_struct *t;
+        long rss;
+
+	if (!mm)
+		return 0;
+
+	rcu_read_lock();
+	rss = mm->anon_rss;
+	list_for_each_rcu(y, &mm->task_list) {
+		t = list_entry(y, struct task_struct, mm_tasks);
+		rss += t->anon_rss;
+	}
+	if (rss < 0)
+		rss = 0;
+	rcu_read_unlock();
+	return rss;
+}
+
+unsigned long get_shared(struct mm_struct *mm)
+{
+	struct list_head *y;
+	struct task_struct *t;
+        long rss;
+
+	if (!mm)
+		return 0;
+
+	rcu_read_lock();
+	rss = mm->rss - mm->anon_rss;
+	list_for_each_rcu(y, &mm->task_list) {
+		t = list_entry(y, struct task_struct, mm_tasks);
+		rss += t->rss - t->anon_rss;
+	}
+	if (rss < 0)
+		rss = 0;
+	rcu_read_unlock();
+	return rss;
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
+	list_add_rcu(&tsk->mm_tasks, &mm->task_list);
+	spin_unlock(&mm->page_table_lock);
+}
+
+
Index: linux-2.6.9/include/linux/init_task.h
===================================================================
--- linux-2.6.9.orig/include/linux/init_task.h	2004-11-30 20:33:30.000000000 -0800
+++ linux-2.6.9/include/linux/init_task.h	2004-11-30 20:33:50.000000000 -0800
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


Index: linux-2.6.9/fs/exec.c
===================================================================
--- linux-2.6.9.orig/fs/exec.c	2004-11-30 20:33:41.000000000 -0800
+++ linux-2.6.9/fs/exec.c	2004-11-30 20:33:50.000000000 -0800
@@ -543,6 +543,7 @@
 	active_mm = tsk->active_mm;
 	tsk->mm = mm;
 	tsk->active_mm = mm;
+	mm_add_thread(mm, current);
 	activate_mm(active_mm, mm);
 	task_unlock(tsk);
 	arch_pick_mmap_layout(mm);
