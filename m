Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269206AbUIYDYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269206AbUIYDYj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 23:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269207AbUIYDYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 23:24:39 -0400
Received: from holomorphy.com ([207.189.100.168]:52708 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269206AbUIYDYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 23:24:24 -0400
Date: Fri, 24 Sep 2004 20:24:19 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [sched.h 5/8] move struct mm_struct to mm.h
Message-ID: <20040925032419.GQ9106@holomorphy.com>
References: <20040925024513.GL9106@holomorphy.com> <20040925024917.GM9106@holomorphy.com> <20040925025304.GN9106@holomorphy.com> <20040925030802.GO9106@holomorphy.com> <20040925031912.GP9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040925031912.GP9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 08:19:12PM -0700, William Lee Irwin III wrote:
> struct k_itimer is used nowhere but posix-timers.h; this patch moves it
> there.

This patch moves mm_struct and the helpers to handle it into mm.h

Index: mm3-2.6.9-rc2/include/linux/mm.h
===================================================================
--- mm3-2.6.9-rc2.orig/include/linux/mm.h	2004-09-24 17:37:11.000000000 -0700
+++ mm3-2.6.9-rc2/include/linux/mm.h	2004-09-24 19:08:34.310696120 -0700
@@ -56,6 +56,7 @@
  * space that has a special rule for the page-fault handlers (ie a shared
  * library, the executable area etc).
  */
+struct mm_struct;
 struct vm_area_struct {
 	struct mm_struct * vm_mm;	/* The address space we belong to. */
 	unsigned long vm_start;		/* Our start address within vm_mm. */
@@ -109,6 +110,77 @@
 #endif
 };
 
+struct mm_struct {
+	struct vm_area_struct * mmap;		/* list of VMAs */
+	struct rb_root mm_rb;
+	struct vm_area_struct * mmap_cache;	/* last find_vma result */
+	unsigned long (*get_unmapped_area) (struct file *filp,
+				unsigned long addr, unsigned long len,
+				unsigned long pgoff, unsigned long flags);
+	void (*unmap_area) (struct vm_area_struct *area);
+	unsigned long mmap_base;		/* base of mmap area */
+	unsigned long free_area_cache;		/* first hole */
+	pgd_t * pgd;
+	atomic_t mm_users;			/* How many users with user space? */
+	atomic_t mm_count;			/* How many references to "struct mm_struct" (users count as 1) */
+	int map_count;				/* number of VMAs */
+	struct rw_semaphore mmap_sem;
+	spinlock_t page_table_lock;		/* Protects task page tables and mm->rss */
+
+	struct list_head mmlist;		/* List of maybe swapped mm's.  These are globally strung
+						 * together off init_mm.mmlist, and are protected
+						 * by mmlist_lock
+						 */
+
+	unsigned long start_code, end_code, start_data, end_data;
+	unsigned long start_brk, brk, start_stack;
+	unsigned long arg_start, arg_end, env_start, env_end;
+	unsigned long rss, total_vm, locked_vm, shared_vm;
+	unsigned long exec_vm, stack_vm, reserved_vm, def_flags, nr_ptes;
+
+	unsigned long saved_auxv[42]; /* for /proc/PID/auxv */
+
+	unsigned dumpable:1;
+	cpumask_t cpu_vm_mask;
+
+	/* Architecture-specific MM context */
+	mm_context_t context;
+
+	/* Token based thrashing protection. */
+	unsigned long swap_token_time;
+	char recent_pagein;
+
+	/* coredumping support */
+	int core_waiters;
+	struct completion *core_startup_done, core_done;
+
+	/* aio bits */
+	rwlock_t		ioctx_list_lock;
+	struct kioctx		*ioctx_list;
+
+	struct kioctx		default_kioctx;
+};
+
+extern struct mm_struct init_mm;
+
+/*
+ * Routines for handling mm_structs
+ */
+struct mm_struct *mm_alloc(void);
+/* mmput gets rid of the mappings and all user-space */
+void mmput(struct mm_struct *);
+/* Grab a reference to a task's mm, if it is not already going away */
+struct mm_struct *get_task_mm(struct task_struct *);
+/* Remove the current tasks stale references to the old mm_struct */
+void mm_release(struct task_struct *, struct mm_struct *);
+/* mmdrop drops the mm and the page tables */
+void FASTCALL(__mmdrop(struct mm_struct *));
+static inline void mmdrop(struct mm_struct *mm)
+{
+	if (atomic_dec_and_test(&mm->mm_count))
+		__mmdrop(mm);
+}
+
 /*
  * vm_flags..
  */
@@ -562,6 +634,25 @@
 	int atomic;				/* May not schedule() */
 };
 
+
+unsigned long arch_get_unmapped_area(struct file *, unsigned long,
+				unsigned long, unsigned long, unsigned long);
+unsigned long arch_get_unmapped_area_topdown(struct file *, unsigned long,
+				unsigned long, unsigned long, unsigned long);
+void arch_unmap_area(struct vm_area_struct *);
+void arch_unmap_area_topdown(struct vm_area_struct *);
+
+#ifdef HAVE_ARCH_PICK_MMAP_LAYOUT
+void arch_pick_mmap_layout(struct mm_struct *);
+#else
+static inline void arch_pick_mmap_layout(struct mm_struct *mm)
+{
+	mm->mmap_base = TASK_UNMAPPED_BASE;
+	mm->get_unmapped_area = arch_get_unmapped_area;
+	mm->unmap_area = arch_unmap_area;
+}
+#endif
+
 void zap_page_range(struct vm_area_struct *vma, unsigned long address,
 		unsigned long size, struct zap_details *);
 int unmap_vmas(struct mmu_gather **tlbp, struct mm_struct *mm,
Index: mm3-2.6.9-rc2/include/linux/sched.h
===================================================================
--- mm3-2.6.9-rc2.orig/include/linux/sched.h	2004-09-24 18:58:25.125306376 -0700
+++ mm3-2.6.9-rc2/include/linux/sched.h	2004-09-24 19:07:27.493853824 -0700
@@ -178,68 +178,6 @@
 
 #include <linux/aio.h>
 
-extern unsigned long
-arch_get_unmapped_area(struct file *, unsigned long, unsigned long,
-		       unsigned long, unsigned long);
-extern unsigned long
-arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
-			  unsigned long len, unsigned long pgoff,
-			  unsigned long flags);
-extern void arch_unmap_area(struct vm_area_struct *area);
-extern void arch_unmap_area_topdown(struct vm_area_struct *area);
-
-
-struct mm_struct {
-	struct vm_area_struct * mmap;		/* list of VMAs */
-	struct rb_root mm_rb;
-	struct vm_area_struct * mmap_cache;	/* last find_vma result */
-	unsigned long (*get_unmapped_area) (struct file *filp,
-				unsigned long addr, unsigned long len,
-				unsigned long pgoff, unsigned long flags);
-	void (*unmap_area) (struct vm_area_struct *area);
-	unsigned long mmap_base;		/* base of mmap area */
-	unsigned long free_area_cache;		/* first hole */
-	pgd_t * pgd;
-	atomic_t mm_users;			/* How many users with user space? */
-	atomic_t mm_count;			/* How many references to "struct mm_struct" (users count as 1) */
-	int map_count;				/* number of VMAs */
-	struct rw_semaphore mmap_sem;
-	spinlock_t page_table_lock;		/* Protects task page tables and mm->rss */
-
-	struct list_head mmlist;		/* List of maybe swapped mm's.  These are globally strung
-						 * together off init_mm.mmlist, and are protected
-						 * by mmlist_lock
-						 */
-
-	unsigned long start_code, end_code, start_data, end_data;
-	unsigned long start_brk, brk, start_stack;
-	unsigned long arg_start, arg_end, env_start, env_end;
-	unsigned long rss, total_vm, locked_vm, shared_vm;
-	unsigned long exec_vm, stack_vm, reserved_vm, def_flags, nr_ptes;
-
-	unsigned long saved_auxv[42]; /* for /proc/PID/auxv */
-
-	unsigned dumpable:1;
-	cpumask_t cpu_vm_mask;
-
-	/* Architecture-specific MM context */
-	mm_context_t context;
-
-	/* Token based thrashing protection. */
-	unsigned long swap_token_time;
-	char recent_pagein;
-
-	/* coredumping support */
-	int core_waiters;
-	struct completion *core_startup_done, core_done;
-
-	/* aio bits */
-	rwlock_t		ioctx_list_lock;
-	struct kioctx		*ioctx_list;
-
-	struct kioctx		default_kioctx;
-};
-
 struct sighand_struct {
 	atomic_t		count;
 	struct k_sigaction	action[_NSIG];
@@ -557,6 +495,7 @@
 
 struct audit_context;		/* See audit.c */
 struct mempolicy;
+struct mm_struct;
 
 /*
  * For entitlemnet based scheduling a task's shares will be determined from
@@ -888,8 +827,6 @@
 extern union thread_union init_thread_union;
 extern struct task_struct init_task;
 
-extern struct   mm_struct init_mm;
-
 #define find_task_by_pid(nr)	find_task_by_pid_type(PIDTYPE_PID, nr)
 extern struct task_struct *find_task_by_pid_type(int type, int pid);
 extern void set_special_pids(pid_t session, pid_t pgrp);
@@ -1000,26 +937,6 @@
 }
 #endif
 
-/*
- * Routines for handling mm_structs
- */
-extern struct mm_struct * mm_alloc(void);
-
-/* mmdrop drops the mm and the page tables */
-extern void FASTCALL(__mmdrop(struct mm_struct *));
-static inline void mmdrop(struct mm_struct * mm)
-{
-	if (atomic_dec_and_test(&mm->mm_count))
-		__mmdrop(mm);
-}
-
-/* mmput gets rid of the mappings and all user-space */
-extern void mmput(struct mm_struct *);
-/* Grab a reference to a task's mm, if it is not already going away */
-extern struct mm_struct *get_task_mm(struct task_struct *task);
-/* Remove the current tasks stale references to the old mm_struct */
-extern void mm_release(struct task_struct *, struct mm_struct *);
-
 extern int  copy_thread(int, unsigned long, unsigned long, unsigned long, struct task_struct *, struct pt_regs *);
 extern void flush_thread(void);
 extern void exit_thread(void);
@@ -1233,17 +1150,6 @@
 
 #endif /* CONFIG_SMP */
 
-#ifdef HAVE_ARCH_PICK_MMAP_LAYOUT
-extern void arch_pick_mmap_layout(struct mm_struct *mm);
-#else
-static inline void arch_pick_mmap_layout(struct mm_struct *mm)
-{
-	mm->mmap_base = TASK_UNMAPPED_BASE;
-	mm->get_unmapped_area = arch_get_unmapped_area;
-	mm->unmap_area = arch_unmap_area;
-}
-#endif
-
 extern long sched_setaffinity(pid_t pid, cpumask_t new_mask);
 extern long sched_getaffinity(pid_t pid, cpumask_t *mask);
 
