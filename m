Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267333AbUIEWxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267333AbUIEWxn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 18:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267306AbUIEWvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 18:51:36 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:21402 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S267333AbUIEWra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 18:47:30 -0400
Date: Sun, 5 Sep 2004 23:47:11 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Suparna Bhattacharya <suparan@in.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] lighten mmlist_lock
Message-ID: <Pine.LNX.4.44.0409052344350.3218-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let's lighten the global spinlock mmlist_lock.

What's it for?
1. Its original role is to guard mmlist.
2. It later got a second role, to prevent get_task_mm from raising
   mm_users from the dead, just after it went down to 0.

Firstly consider the second: __exit_mm sets tsk->mm NULL while holding
task_lock before calling mmput; so mmlist_lock only guards against the
exceptional case, of get_task_mm on a kernel workthread which did AIO's
use_mm (which transiently sets its tsk->mm without raising mm_users)
on an mm now exiting.

Well, I don't think get_task_mm should succeed at all on use_mm tasks.
It's mainly used by /proc/pid and ptrace, seems at best confusing for
those to present the kernel thread as having a user mm, which it won't
have a moment later.  Define PF_BORROWED_MM, set in use_mm, clear in
unuse_mm (though we could just leave it), get_task_mm give NULL if set.

Secondly consider the first: and what's mmlist for?
1. Its original role was for swap_out to scan: rmap ended that in 2.5.27.
2. In 2.4.10 it got a second role, for try_to_unuse to scan for swapoff.

So, make mmlist a list of mms which maybe have pages on swap: add mm to
mmlist when first swap entry is assigned in try_to_unmap_one (pageout),
or in copy_page_range (fork); and mmput remove it from mmlist as before,
except usually list_empty and there's no need to lock.  drain_mmlist
added to swapoff, to empty out the mmlist if no swap is then in use.

try_to_unmap_one and try_to_unuse do have to be careful about the little
window in mmput, when mm_users goes to 0 before mmlist_lock is taken.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/i386/mm/pgtable.c |    6 ++----
 fs/aio.c               |    2 ++
 fs/exec.c              |    6 ------
 include/linux/sched.h  |    5 ++---
 kernel/fork.c          |   37 +++++++++++--------------------------
 mm/memory.c            |    9 ++++++++-
 mm/rmap.c              |    7 +++++++
 mm/swapfile.c          |   34 +++++++++++++++++++++++++++++-----
 8 files changed, 61 insertions(+), 45 deletions(-)

--- 2.6.9-rc1-bk12/arch/i386/mm/pgtable.c	2004-08-14 06:39:29.000000000 +0100
+++ linux/arch/i386/mm/pgtable.c	2004-09-05 17:07:03.438766776 +0100
@@ -165,10 +165,8 @@ void pmd_ctor(void *pmd, kmem_cache_t *c
  * against pageattr.c; it is the unique case in which a valid change
  * of kernel pagetables can't be lazily synchronized by vmalloc faults.
  * vmalloc faults work because attached pagetables are never freed.
- * If the locking proves to be non-performant, a ticketing scheme with
- * checks at dup_mmap(), exec(), and other mmlist addition points
- * could be used. The locking scheme was chosen on the basis of
- * manfred's recommendations and having no core impact whatsoever.
+ * The locking scheme was chosen on the basis of manfred's
+ * recommendations and having no core impact whatsoever.
  * -- wli
  */
 spinlock_t pgd_lock = SPIN_LOCK_UNLOCKED;
--- 2.6.9-rc1-bk12/fs/aio.c	2004-09-05 12:58:33.000000000 +0100
+++ linux/fs/aio.c	2004-09-05 17:07:03.440766472 +0100
@@ -571,6 +571,7 @@ static void use_mm(struct mm_struct *mm)
 	struct task_struct *tsk = current;
 
 	task_lock(tsk);
+	tsk->flags |= PF_BORROWED_MM;
 	active_mm = tsk->active_mm;
 	atomic_inc(&mm->mm_count);
 	tsk->mm = mm;
@@ -597,6 +598,7 @@ void unuse_mm(struct mm_struct *mm)
 	struct task_struct *tsk = current;
 
 	task_lock(tsk);
+	tsk->flags &= ~PF_BORROWED_MM;
 	tsk->mm = NULL;
 	/* active_mm is still 'mm' */
 	enter_lazy_tlb(mm, tsk);
--- 2.6.9-rc1-bk12/fs/exec.c	2004-09-05 12:58:34.000000000 +0100
+++ linux/fs/exec.c	2004-09-05 17:07:03.442766168 +0100
@@ -529,12 +529,6 @@ static int exec_mmap(struct mm_struct *m
 	struct task_struct *tsk;
 	struct mm_struct * old_mm, *active_mm;
 
-	/* Add it to the list of mm's */
-	spin_lock(&mmlist_lock);
-	list_add(&mm->mmlist, &init_mm.mmlist);
-	mmlist_nr++;
-	spin_unlock(&mmlist_lock);
-
 	/* Notify parent that we're no longer interested in the old VM */
 	tsk = current;
 	old_mm = current->mm;
--- 2.6.9-rc1-bk12/include/linux/sched.h	2004-09-05 12:58:39.000000000 +0100
+++ linux/include/linux/sched.h	2004-09-05 17:07:03.444765864 +0100
@@ -216,7 +216,7 @@ struct mm_struct {
 	struct rw_semaphore mmap_sem;
 	spinlock_t page_table_lock;		/* Protects task page tables and mm->rss */
 
-	struct list_head mmlist;		/* List of all active mm's.  These are globally strung
+	struct list_head mmlist;		/* List of maybe swapped mm's.  These are globally strung
 						 * together off init_mm.mmlist, and are protected
 						 * by mmlist_lock
 						 */
@@ -250,8 +250,6 @@ struct mm_struct {
 	struct kioctx		default_kioctx;
 };
 
-extern int mmlist_nr;
-
 struct sighand_struct {
 	atomic_t		count;
 	struct k_sigaction	action[_NSIG];
@@ -620,6 +618,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_SWAPOFF	0x00080000	/* I am in swapoff */
 #define PF_LESS_THROTTLE 0x00100000	/* Throttle me less: I clean memory */
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
+#define PF_BORROWED_MM	0x00400000	/* I am a kthread doing use_mm */
 
 #ifdef CONFIG_SMP
 extern int set_cpus_allowed(task_t *p, cpumask_t new_mask);
--- 2.6.9-rc1-bk12/kernel/fork.c	2004-09-05 12:58:40.000000000 +0100
+++ linux/kernel/fork.c	2004-09-05 17:07:03.445765712 +0100
@@ -303,17 +303,6 @@ static inline int dup_mmap(struct mm_str
 	rb_parent = NULL;
 	pprev = &mm->mmap;
 
-	/*
-	 * Add it to the mmlist after the parent.
-	 * Doing it this way means that we can order the list,
-	 * and fork() won't mess up the ordering significantly.
-	 * Add it first so that swapoff can see any swap entries.
-	 */
-	spin_lock(&mmlist_lock);
-	list_add(&mm->mmlist, &current->mm->mmlist);
-	mmlist_nr++;
-	spin_unlock(&mmlist_lock);
-
 	for (mpnt = current->mm->mmap ; mpnt ; mpnt = mpnt->vm_next) {
 		struct file *file;
 
@@ -413,7 +402,6 @@ static inline void mm_free_pgd(struct mm
 #endif /* CONFIG_MMU */
 
 spinlock_t mmlist_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
-int mmlist_nr;
 
 #define allocate_mm()	(kmem_cache_alloc(mm_cachep, SLAB_KERNEL))
 #define free_mm(mm)	(kmem_cache_free(mm_cachep, (mm)))
@@ -425,6 +413,7 @@ static struct mm_struct * mm_init(struct
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);
 	init_rwsem(&mm->mmap_sem);
+	INIT_LIST_HEAD(&mm->mmlist);
 	mm->core_waiters = 0;
 	mm->page_table_lock = SPIN_LOCK_UNLOCKED;
 	mm->ioctx_list_lock = RW_LOCK_UNLOCKED;
@@ -473,10 +462,12 @@ void fastcall __mmdrop(struct mm_struct 
  */
 void mmput(struct mm_struct *mm)
 {
-	if (atomic_dec_and_lock(&mm->mm_users, &mmlist_lock)) {
-		list_del(&mm->mmlist);
-		mmlist_nr--;
-		spin_unlock(&mmlist_lock);
+	if (atomic_dec_and_test(&mm->mm_users)) {
+		if (!list_empty(&mm->mmlist)) {
+			spin_lock(&mmlist_lock);
+			list_del(&mm->mmlist);
+			spin_unlock(&mmlist_lock);
+		}
 		exit_aio(mm);
 		exit_mmap(mm);
 		put_swap_token(mm);
@@ -487,15 +478,11 @@ void mmput(struct mm_struct *mm)
 /**
  * get_task_mm - acquire a reference to the task's mm
  *
- * Returns %NULL if the task has no mm.  Checks if the use count
- * of the mm is non-zero and if so returns a reference to it, after
+ * Returns %NULL if the task has no mm.  Checks PF_BORROWED_MM (meaning
+ * this kernel workthread has transiently adopted a user mm with use_mm,
+ * to do its AIO) is not set and if so returns a reference to it, after
  * bumping up the use count.  User must release the mm via mmput()
  * after use.  Typically used by /proc and ptrace.
- *
- * If the use count is zero, it means that this mm is going away,
- * so return %NULL.  This only happens in the case of an AIO daemon
- * which has temporarily adopted an mm (see use_mm), in the course
- * of its final mmput, before exit_aio has completed.
  */
 struct mm_struct *get_task_mm(struct task_struct *task)
 {
@@ -504,12 +491,10 @@ struct mm_struct *get_task_mm(struct tas
 	task_lock(task);
 	mm = task->mm;
 	if (mm) {
-		spin_lock(&mmlist_lock);
-		if (!atomic_read(&mm->mm_users))
+		if (task->flags & PF_BORROWED_MM)
 			mm = NULL;
 		else
 			atomic_inc(&mm->mm_users);
-		spin_unlock(&mmlist_lock);
 	}
 	task_unlock(task);
 	return mm;
--- 2.6.9-rc1-bk12/mm/memory.c	2004-09-05 12:58:41.000000000 +0100
+++ linux/mm/memory.c	2004-09-05 17:07:03.447765408 +0100
@@ -288,8 +288,15 @@ skip_copy_pte_range:
 					goto cont_copy_pte_range_noset;
 				/* pte contains position in swap, so copy. */
 				if (!pte_present(pte)) {
-					if (!pte_file(pte))
+					if (!pte_file(pte)) {
 						swap_duplicate(pte_to_swp_entry(pte));
+						if (list_empty(&dst->mmlist)) {
+							spin_lock(&mmlist_lock);
+							list_add(&dst->mmlist,
+								 &src->mmlist);
+							spin_unlock(&mmlist_lock);
+						}
+					}
 					set_pte(dst_pte, pte);
 					goto cont_copy_pte_range_noset;
 				}
--- 2.6.9-rc1-bk12/mm/rmap.c	2004-09-05 12:58:41.000000000 +0100
+++ linux/mm/rmap.c	2004-09-05 17:07:03.449765104 +0100
@@ -35,6 +35,7 @@
  *         mm->page_table_lock
  *           zone->lru_lock (in mark_page_accessed)
  *           swap_list_lock (in swap_free etc's swap_info_get)
+ *             mmlist_lock (in mmput, drain_mmlist and others)
  *             swap_device_lock (in swap_duplicate, swap_info_get)
  *             mapping->private_lock (in __set_page_dirty_buffers)
  *             inode_lock (in set_page_dirty's __mark_inode_dirty)
@@ -575,6 +576,12 @@ static int try_to_unmap_one(struct page 
 		 */
 		BUG_ON(!PageSwapCache(page));
 		swap_duplicate(entry);
+		if (list_empty(&mm->mmlist)) {
+			spin_lock(&mmlist_lock);
+			if (atomic_read(&mm->mm_users))
+				list_add(&mm->mmlist, &init_mm.mmlist);
+			spin_unlock(&mmlist_lock);
+		}
 		set_pte(pte, swp_entry_to_pte(entry));
 		BUG_ON(pte_file(*pte));
 	}
--- 2.6.9-rc1-bk12/mm/swapfile.c	2004-09-05 12:58:41.000000000 +0100
+++ linux/mm/swapfile.c	2004-09-05 17:07:03.451764800 +0100
@@ -647,11 +647,12 @@ static int try_to_unuse(unsigned int typ
 	 *
 	 * A simpler strategy would be to start at the last mm we
 	 * freed the previous entry from; but that would take less
-	 * advantage of mmlist ordering (now preserved by swap_out()),
-	 * which clusters forked address spaces together, most recent
-	 * child immediately after parent.  If we race with dup_mmap(),
-	 * we very much want to resolve parent before child, otherwise
-	 * we may miss some entries: using last mm would invert that.
+	 * advantage of mmlist ordering, which clusters forked mms
+	 * together, child after parent.  If we race with dup_mmap(), we
+	 * prefer to resolve parent before child, lest we miss entries
+	 * duplicated after we scanned child: using last mm would invert
+	 * that.  Though it's only a serious concern when an overflowed
+	 * swap count is reset from SWAP_MAP_MAX, preventing a rescan.
 	 */
 	start_mm = &init_mm;
 	atomic_inc(&init_mm.mm_users);
@@ -744,6 +745,8 @@ static int try_to_unuse(unsigned int typ
 			while (*swap_map > 1 && !retval &&
 					(p = p->next) != &start_mm->mmlist) {
 				mm = list_entry(p, struct mm_struct, mmlist);
+				if (!atomic_read(&mm->mm_users))
+					continue;
 				atomic_inc(&mm->mm_users);
 				spin_unlock(&mmlist_lock);
 				mmput(prev_mm);
@@ -858,6 +861,26 @@ static int try_to_unuse(unsigned int typ
 }
 
 /*
+ * After a successful try_to_unuse, if no swap is now in use, we know we
+ * can empty the mmlist.  swap_list_lock must be held on entry and exit.
+ * Note that mmlist_lock nests inside swap_list_lock, and an mm must be
+ * added to the mmlist just after page_duplicate - before would be racy.
+ */
+static void drain_mmlist(void)
+{
+	struct list_head *p, *next;
+	unsigned int i;
+
+	for (i = 0; i < nr_swapfiles; i++)
+		if (swap_info[i].inuse_pages)
+			return;
+	spin_lock(&mmlist_lock);
+	list_for_each_safe(p, next, &init_mm.mmlist)
+		list_del_init(p);
+	spin_unlock(&mmlist_lock);
+}
+
+/*
  * Use this swapdev's extent info to locate the (PAGE_SIZE) block which
  * corresponds to page offset `offset'.
  */
@@ -1171,6 +1194,7 @@ asmlinkage long sys_swapoff(const char _
 	}
 	down(&swapon_sem);
 	swap_list_lock();
+	drain_mmlist();
 	swap_device_lock(p);
 	swap_file = p->swap_file;
 	p->swap_file = NULL;

