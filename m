Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbWD0UJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWD0UJR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 16:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbWD0UJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 16:09:16 -0400
Received: from smtp-2.llnl.gov ([128.115.3.82]:12494 "EHLO smtp-2.llnl.gov")
	by vger.kernel.org with ESMTP id S1030214AbWD0UJO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 16:09:14 -0400
From: Dave Peterson <dsp@llnl.gov>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2 (repost)] mm: serialize OOM kill operations
Date: Thu, 27 Apr 2006 13:08:10 -0700
User-Agent: KMail/1.5.3
Cc: linux-mm@kvack.org, riel@surriel.com, nickpiggin@yahoo.com.au, ak@suse.de,
       akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604271308.10080.dsp@llnl.gov>
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
This is a repost of a previous patch.  It applies to kernel
2.6.17-rc3.


Index: linux-2.6.17-rc3-oom/include/linux/sched.h
===================================================================
--- linux-2.6.17-rc3-oom.orig/include/linux/sched.h	2006-04-27 11:00:32.000000000 -0700
+++ linux-2.6.17-rc3-oom/include/linux/sched.h	2006-04-27 12:08:36.000000000 -0700
@@ -292,6 +292,9 @@ typedef unsigned long mm_counter_t;
 		(mm)->hiwater_vm = (mm)->total_vm;	\
 } while (0)
 
+/* bit #s for flags in mm_struct->flags... */
+#define MM_FLAG_OOM_NOTIFY 0
+
 struct mm_struct {
 	struct vm_area_struct * mmap;		/* list of VMAs */
 	struct rb_root mm_rb;
@@ -350,6 +353,8 @@ struct mm_struct {
 	/* aio bits */
 	rwlock_t		ioctx_list_lock;
 	struct kioctx		*ioctx_list;
+
+	unsigned long flags;
 };
 
 struct sighand_struct {
Index: linux-2.6.17-rc3-oom/include/linux/swap.h
===================================================================
--- linux-2.6.17-rc3-oom.orig/include/linux/swap.h	2006-04-27 11:00:32.000000000 -0700
+++ linux-2.6.17-rc3-oom/include/linux/swap.h	2006-04-27 12:08:36.000000000 -0700
@@ -147,6 +147,7 @@ struct swap_list_t {
 #define vm_swap_full() (nr_swap_pages*2 < total_swap_pages)
 
 /* linux/mm/oom_kill.c */
+extern spinlock_t oom_kill_lock;
 extern void out_of_memory(struct zonelist *zonelist, gfp_t gfp_mask, int order);
 
 /* linux/mm/memory.c */
Index: linux-2.6.17-rc3-oom/kernel/fork.c
===================================================================
--- linux-2.6.17-rc3-oom.orig/kernel/fork.c	2006-04-27 11:00:32.000000000 -0700
+++ linux-2.6.17-rc3-oom/kernel/fork.c	2006-04-27 12:08:36.000000000 -0700
@@ -328,6 +328,7 @@ static struct mm_struct * mm_init(struct
 	mm->ioctx_list = NULL;
 	mm->free_area_cache = TASK_UNMAPPED_BASE;
 	mm->cached_hole_size = ~0UL;
+	mm->flags = 0;
 
 	if (likely(!mm_alloc_pgd(mm))) {
 		mm->def_flags = 0;
@@ -379,6 +380,15 @@ void mmput(struct mm_struct *mm)
 			spin_unlock(&mmlist_lock);
 		}
 		put_swap_token(mm);
+
+		if (unlikely(test_bit(MM_FLAG_OOM_NOTIFY, &mm->flags)))
+			/* Terminate a pending OOM kill operation.  No tasks
+			 * actually spin on the lock.  Tasks only do
+			 * spin_trylock() (and abort OOM kill operation if
+			 * lock is already taken).
+			 */
+			spin_unlock(&oom_kill_lock);
+
 		mmdrop(mm);
 	}
 }
Index: linux-2.6.17-rc3-oom/mm/oom_kill.c
===================================================================
--- linux-2.6.17-rc3-oom.orig/mm/oom_kill.c	2006-04-27 11:00:32.000000000 -0700
+++ linux-2.6.17-rc3-oom/mm/oom_kill.c	2006-04-27 12:08:36.000000000 -0700
@@ -21,9 +21,13 @@
 #include <linux/timex.h>
 #include <linux/jiffies.h>
 #include <linux/cpuset.h>
+#include <linux/spinlock.h>
+#include <linux/bitops.h>
 
 /* #define DEBUG */
 
+spinlock_t oom_kill_lock = SPIN_LOCK_UNLOCKED;
+
 /**
  * oom_badness - calculate a numeric value for how bad this task has been
  * @p: task struct of which task we should calculate
@@ -259,27 +263,31 @@ static int oom_kill_task(task_t *p, cons
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
+	set_bit(MM_FLAG_OOM_NOTIFY, &mm->flags);
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
 
@@ -317,13 +325,27 @@ void out_of_memory(struct zonelist *zone
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
+	/* Return immediately if an OOM kill is already in progress.  We want
+	 * to avoid the following behavior:
+	 *
+	 *     1.  Two processes (A and B) race for oom_kill_lock.  Let's say
+	 *         A wins and B is delayed.
+	 *
+	 *     2.  Process A shoots some process and releases oom_kill_lock.
+	 *
+	 *     3.  Process B now acquires oom_kill_lock and shoots another
+	 *         process.  However this isn't really what we want to do if
+	 *         the OOM kill done by A above freed enough memory to resolve
+	 *         the OOM condition.
+	 */
+	if (!spin_trylock(&oom_kill_lock))
+		return;
+
+	printk("oom-killer: gfp_mask=0x%x, order=%d\n", gfp_mask, order);
+	dump_stack();
+	show_mem();
 
 	cpuset_lock();
 	read_lock(&tasklist_lock);
@@ -334,12 +356,12 @@ void out_of_memory(struct zonelist *zone
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
 
@@ -351,8 +373,10 @@ retry:
 		 */
 		p = select_bad_process(&points);
 
-		if (PTR_ERR(p) == -1UL)
+		if (PTR_ERR(p) == -1UL) {
+			cancel = 1;
 			goto out;
+		}
 
 		/* Found nothing?!?! Either we hang forever, or we panic. */
 		if (!p) {
@@ -371,6 +395,9 @@ out:
 	read_unlock(&tasklist_lock);
 	cpuset_unlock();
 
+	if (cancel)
+		spin_unlock(&oom_kill_lock);  /* cancel OOM kill operation */
+
 	/*
 	 * Give "p" a good chance of killing itself before we
 	 * retry to allocate memory unless "p" is current
