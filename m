Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWDZACX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWDZACX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 20:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWDZACX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 20:02:23 -0400
Received: from smtp-2.llnl.gov ([128.115.3.82]:31680 "EHLO smtp-2.llnl.gov")
	by vger.kernel.org with ESMTP id S932313AbWDZACX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 20:02:23 -0400
From: Dave Peterson <dsp@llnl.gov>
To: linux-mm@kvack.org
Subject: [PATCH 1/2] mm: serialize OOM kill operations
Date: Tue, 25 Apr 2006 17:01:31 -0700
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, riel@surriel.com, akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604251701.31899.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below modifies the behavior of the OOM killer so that only
one OOM kill operation can be in progress at a time.  When running a
test program that eats lots of memory, I was observing behavior where
the OOM killer gets impatient and shoots one or more system daemons
in addition to the program that is eating lots of memory.  This fixes
the problematic behavior.

Signed-Off-By: David S. Peterson <dsp@llnl.gov>
---
This patch applies to kernel 2.6.17-rc2-git7.

Index: git7-oom/include/linux/sched.h
===================================================================
--- git7-oom.orig/include/linux/sched.h	2006-04-25 16:19:40.000000000 -0700
+++ git7-oom/include/linux/sched.h	2006-04-25 16:21:48.000000000 -0700
@@ -350,6 +350,8 @@ struct mm_struct {
 	/* aio bits */
 	rwlock_t		ioctx_list_lock;
 	struct kioctx		*ioctx_list;
+
+	int oom_notify;
 };
 
 struct sighand_struct {
Index: git7-oom/include/linux/swap.h
===================================================================
--- git7-oom.orig/include/linux/swap.h	2006-04-25 16:18:06.000000000 -0700
+++ git7-oom/include/linux/swap.h	2006-04-25 16:21:48.000000000 -0700
@@ -147,6 +147,7 @@ struct swap_list_t {
 #define vm_swap_full() (nr_swap_pages*2 < total_swap_pages)
 
 /* linux/mm/oom_kill.c */
+extern void oom_kill_finish(void);
 extern void out_of_memory(struct zonelist *zonelist, gfp_t gfp_mask, int order);
 
 /* linux/mm/memory.c */
Index: git7-oom/kernel/fork.c
===================================================================
--- git7-oom.orig/kernel/fork.c	2006-04-25 16:19:40.000000000 -0700
+++ git7-oom/kernel/fork.c	2006-04-25 16:21:48.000000000 -0700
@@ -328,6 +328,7 @@ static struct mm_struct * mm_init(struct
 	mm->ioctx_list = NULL;
 	mm->free_area_cache = TASK_UNMAPPED_BASE;
 	mm->cached_hole_size = ~0UL;
+	mm->oom_notify = 0;
 
 	if (likely(!mm_alloc_pgd(mm))) {
 		mm->def_flags = 0;
@@ -379,6 +380,10 @@ void mmput(struct mm_struct *mm)
 			spin_unlock(&mmlist_lock);
 		}
 		put_swap_token(mm);
+
+		if (unlikely(mm->oom_notify))
+			oom_kill_finish();
+
 		mmdrop(mm);
 	}
 }
Index: git7-oom/mm/oom_kill.c
===================================================================
--- git7-oom.orig/mm/oom_kill.c	2006-04-25 16:19:40.000000000 -0700
+++ git7-oom/mm/oom_kill.c	2006-04-25 16:21:48.000000000 -0700
@@ -21,9 +21,34 @@
 #include <linux/timex.h>
 #include <linux/jiffies.h>
 #include <linux/cpuset.h>
+#include <asm/bitops.h>
 
 /* #define DEBUG */
 
+volatile unsigned long oom_kill_in_progress = 0;
+
+/*
+ * Attempt to start an OOM kill operation.  Return 0 on success, or 1 if an
+ * OOM kill is already in progress.
+ */
+static inline int oom_kill_start(void)
+{
+	return test_and_set_bit(0, &oom_kill_in_progress);
+}
+
+/*
+ * Terminate an OOM kill operation.
+ *
+ * When the OOM killer chooses a victim, it sets the oom_notify flag of the
+ * victim's mm_struct.  mmput() then calls this function when the mm_users
+ * count has reached 0 and the contents of the mm_struct have been cleaned
+ * out.
+ */
+void oom_kill_finish(void)
+{
+	clear_bit(0, &oom_kill_in_progress);
+}
+
 /**
  * oom_badness - calculate a numeric value for how bad this task has been
  * @p: task struct of which task we should calculate
@@ -259,27 +284,31 @@ static int oom_kill_task(task_t *p, cons
 	struct mm_struct *mm;
 	task_t * g, * q;
 
+	task_lock(p);
 	mm = p->mm;
 
-	/* WARNING: mm may not be dereferenced since we did not obtain its
-	 * value from get_task_mm(p).  This is OK since all we need to do is
-	 * compare mm to q->mm below.
+	if (mm == NULL || mm == &init_mm) {
+		task_unlock(p);
+		return 1;
+	}
+
+	mm->oom_notify = 1;
+	task_unlock(p);
+
+	/* WARNING: mm may no longer be dereferenced since we did not obtain
+	 * its value from get_task_mm(p).  This is OK since all we need to do
+	 * is compare mm to q->mm below.
 	 *
 	 * Furthermore, even if mm contains a non-NULL value, p->mm may
-	 * change to NULL at any time since we do not hold task_lock(p).
+	 * change to NULL at any time since we no longer hold task_lock(p).
 	 * However, this is of no concern to us.
 	 */
 
-	if (mm == NULL || mm == &init_mm)
-		return 1;
-
-	__oom_kill_task(p, message);
 	/*
-	 * kill all processes that share the ->mm (i.e. all threads),
-	 * but are in a different thread group
+	 * kill all processes that share the ->mm (i.e. all threads)
 	 */
 	do_each_thread(g, q)
-		if (q->mm == mm && q->tgid != p->tgid)
+		if (q->mm == mm)
 			__oom_kill_task(q, message);
 	while_each_thread(g, q);
 
@@ -317,13 +346,14 @@ void out_of_memory(struct zonelist *zone
 {
 	task_t *p;
 	unsigned long points = 0;
+	int cancel = 0;
 
-	if (printk_ratelimit()) {
-		printk("oom-killer: gfp_mask=0x%x, order=%d\n",
-			gfp_mask, order);
-		dump_stack();
-		show_mem();
-	}
+	if (oom_kill_start())
+		return;  /* OOM kill already in progress */
+
+	printk("oom-killer: gfp_mask=0x%x, order=%d\n", gfp_mask, order);
+	dump_stack();
+	show_mem();
 
 	cpuset_lock();
 	read_lock(&tasklist_lock);
@@ -334,12 +364,12 @@ void out_of_memory(struct zonelist *zone
 	 */
 	switch (constrained_alloc(zonelist, gfp_mask)) {
 	case CONSTRAINT_MEMORY_POLICY:
-		oom_kill_process(current, points,
+		cancel = oom_kill_process(current, points,
 				"No available memory (MPOL_BIND)");
 		break;
 
 	case CONSTRAINT_CPUSET:
-		oom_kill_process(current, points,
+		cancel = oom_kill_process(current, points,
 				"No available memory in cpuset");
 		break;
 
@@ -351,8 +381,10 @@ retry:
 		 */
 		p = select_bad_process(&points);
 
-		if (PTR_ERR(p) == -1UL)
+		if (PTR_ERR(p) == -1UL) {
+			cancel = 1;
 			goto out;
+		}
 
 		/* Found nothing?!?! Either we hang forever, or we panic. */
 		if (!p) {
@@ -371,6 +403,9 @@ out:
 	read_unlock(&tasklist_lock);
 	cpuset_unlock();
 
+	if (cancel)
+		oom_kill_finish();  /* cancel OOM kill operation */
+
 	/*
 	 * Give "p" a good chance of killing itself before we
 	 * retry to allocate memory unless "p" is current
