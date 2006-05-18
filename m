Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWERR37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWERR37 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 13:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWERR37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 13:29:59 -0400
Received: from smtp-4.llnl.gov ([128.115.41.84]:28091 "EHLO smtp-4.llnl.gov")
	by vger.kernel.org with ESMTP id S932095AbWERR36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 13:29:58 -0400
Date: Thu, 18 May 2006 10:29:50 -0700 (PDT)
Message-Id: <200605181729.k4IHToRU025597@calaveras.llnl.gov>
From: Dave Peterson <dsp@llnl.gov>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, pj@sgi.com, ak@suse.de,
       linux-mm@kvack.org, garlick@llnl.gov, mgrondona@llnl.gov
Subject: [PATCH] mm: avoid unnecessary OOM kills
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a 2.6.17-rc4-mm1 patch that fixes a problem where the OOM killer was
unnecessarily killing system daemons in addition to memory-hogging user
processes.  The patch fixes things so that the following assertion is
satisfied:

    If a failed attempt to allocate memory triggers the OOM killer, then the
    failed attempt must have occurred _after_ any process previously shot by
    the OOM killer has cleaned out its mm_struct.

Thus we avoid situations where concurrent invocations of the OOM killer cause
more processes to be shot than necessary to resolve the OOM condition.

Signed-Off-By: David S. Peterson <dsp@llnl.gov>
---

This is a repost of a patch discussed a few weeks ago.  I got sidetracked for
a while, and am just now getting back to this.  The patch below incorporates
feedback from previous discussion and fixes a minor race condition in my
previous code.


Index: linux-2.6.17-rc4-mm1/include/linux/sched.h
===================================================================
--- linux-2.6.17-rc4-mm1.orig/include/linux/sched.h	2006-05-17 22:31:38.000000000 -0700
+++ linux-2.6.17-rc4-mm1/include/linux/sched.h	2006-05-17 22:33:54.000000000 -0700
@@ -296,6 +296,9 @@
 		(mm)->hiwater_vm = (mm)->total_vm;	\
 } while (0)
 
+/* bit #s for flags in mm_struct->flags... */
+#define MM_FLAG_OOM_NOTIFY 0
+
 struct mm_struct {
 	struct vm_area_struct * mmap;		/* list of VMAs */
 	struct rb_root mm_rb;
@@ -354,6 +357,8 @@
 	/* aio bits */
 	rwlock_t		ioctx_list_lock;
 	struct kioctx		*ioctx_list;
+
+	unsigned long flags;
 };
 
 struct sighand_struct {
Index: linux-2.6.17-rc4-mm1/include/linux/swap.h
===================================================================
--- linux-2.6.17-rc4-mm1.orig/include/linux/swap.h	2006-05-17 22:31:38.000000000 -0700
+++ linux-2.6.17-rc4-mm1/include/linux/swap.h	2006-05-17 22:33:54.000000000 -0700
@@ -6,6 +6,7 @@
 #include <linux/mmzone.h>
 #include <linux/list.h>
 #include <linux/sched.h>
+#include <linux/bitops.h>
 
 #include <asm/atomic.h>
 #include <asm/page.h>
@@ -155,6 +156,29 @@
 #define vm_swap_full() (nr_swap_pages*2 < total_swap_pages)
 
 /* linux/mm/oom_kill.c */
+extern volatile unsigned long oom_kill_in_progress;
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
+ * When the OOM killer chooses a victim, it sets a flag in the victim's
+ * mm_struct.  mmput() then calls this function when the mm_users count has
+ * reached 0 and the contents of the mm_struct have been cleaned out.
+ */
+static inline void oom_kill_finish(void)
+{
+	clear_bit(0, &oom_kill_in_progress);
+}
+
 extern void out_of_memory(struct zonelist *zonelist, gfp_t gfp_mask, int order);
 
 /* linux/mm/memory.c */
Index: linux-2.6.17-rc4-mm1/kernel/fork.c
===================================================================
--- linux-2.6.17-rc4-mm1.orig/kernel/fork.c	2006-05-17 22:31:38.000000000 -0700
+++ linux-2.6.17-rc4-mm1/kernel/fork.c	2006-05-17 22:33:54.000000000 -0700
@@ -328,6 +328,7 @@
 	mm->ioctx_list = NULL;
 	mm->free_area_cache = TASK_UNMAPPED_BASE;
 	mm->cached_hole_size = ~0UL;
+	mm->flags = 0;
 
 	if (likely(!mm_alloc_pgd(mm))) {
 		mm->def_flags = 0;
@@ -381,6 +382,8 @@
 			spin_unlock(&mmlist_lock);
 		}
 		put_swap_token(mm);
+		if (unlikely(test_bit(MM_FLAG_OOM_NOTIFY, &mm->flags)))
+			oom_kill_finish();  /* terminate pending OOM kill */
 		mmdrop(mm);
 	}
 }
Index: linux-2.6.17-rc4-mm1/mm/oom_kill.c
===================================================================
--- linux-2.6.17-rc4-mm1.orig/mm/oom_kill.c	2006-05-17 22:31:38.000000000 -0700
+++ linux-2.6.17-rc4-mm1/mm/oom_kill.c	2006-05-17 22:33:54.000000000 -0700
@@ -25,6 +25,8 @@
 int sysctl_panic_on_oom;
 /* #define DEBUG */
 
+volatile unsigned long oom_kill_in_progress = 0;
+
 /**
  * badness - calculate a numeric value for how bad this task has been
  * @p: task struct of which task we should calculate
@@ -260,27 +262,31 @@
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
 
@@ -313,19 +319,20 @@
  * killing a random task (bad), letting the system crash (worse)
  * OR try to be smart about which process to kill. Note that we
  * don't have to be perfect here, we just have to be good.
+ *
+ * Note: Caller must have obtained a value of 0 from oom_kill_start().
+ * However, by calling this function the caller absolves itself of
+ * responsibility for calling oom_kill_finish().
  */
 void out_of_memory(struct zonelist *zonelist, gfp_t gfp_mask, int order)
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
-
+	printk("oom-killer: gfp_mask=0x%x, order=%d\n", gfp_mask, order);
+	dump_stack();
+	show_mem();
 	cpuset_lock();
 	read_lock(&tasklist_lock);
 
@@ -335,12 +342,12 @@
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
 
@@ -354,8 +361,10 @@
 		 */
 		p = select_bad_process(&points);
 
-		if (PTR_ERR(p) == -1UL)
+		if (PTR_ERR(p) == -1UL) {
+			cancel = 1;
 			goto out;
+		}
 
 		/* Found nothing?!?! Either we hang forever, or we panic. */
 		if (!p) {
@@ -374,6 +383,9 @@
 	read_unlock(&tasklist_lock);
 	cpuset_unlock();
 
+	if (cancel)
+		oom_kill_finish();  /* cancel OOM kill operation */
+
 	/*
 	 * Give "p" a good chance of killing itself before we
 	 * retry to allocate memory unless "p" is current
Index: linux-2.6.17-rc4-mm1/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc4-mm1.orig/mm/page_alloc.c	2006-05-17 22:31:38.000000000 -0700
+++ linux-2.6.17-rc4-mm1/mm/page_alloc.c	2006-05-17 22:33:54.000000000 -0700
@@ -910,6 +910,36 @@
 	return 1;
 }
 
+/* Try to allocate one more time before invoking the OOM killer. */
+static struct page * oom_alloc(gfp_t gfp_mask, unsigned int order,
+		struct zonelist *zonelist)
+{
+	struct page *page;
+
+	/* The use of oom_kill_start() below prevents parallel OOM kill
+	 * operations.  This fixes a problem where the OOM killer was observed
+	 * shooting system daemons in addition to memory-hogging user
+	 * processes.
+	 */
+	if (oom_kill_start())
+		return NULL;  /* previous OOM kill still in progress */
+
+	/* If we get this far, we _know_ that any previous OOM killer victim
+	 * has cleaned out its mm_struct.  Therefore we should pick a victim
+	 * to shoot if the allocation below fails.
+	 */
+	page = get_page_from_freelist(gfp_mask | __GFP_HARDWALL, order,
+			zonelist, ALLOC_WMARK_HIGH | ALLOC_CPUSET);
+
+	if (page) {
+		oom_kill_finish();  /* cancel OOM kill operation */
+		return page;
+	}
+
+	out_of_memory(zonelist, gfp_mask, order);
+	return NULL;
+}
+
 /*
  * get_page_from_freeliest goes through the zonelist trying to allocate
  * a page.
@@ -1116,18 +1146,8 @@
 		if (page)
 			goto got_pg;
 	} else if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY)) {
-		/*
-		 * Go through the zonelist yet one more time, keep
-		 * very high watermark here, this is only to catch
-		 * a parallel oom killing, we must fail if we're still
-		 * under heavy pressure.
-		 */
-		page = get_page_from_freelist(gfp_mask|__GFP_HARDWALL, order,
-				zonelist, ALLOC_WMARK_HIGH|ALLOC_CPUSET);
-		if (page)
+		if ((page = oom_alloc(gfp_mask, order, zonelist)) != NULL)
 			goto got_pg;
-
-		out_of_memory(zonelist, gfp_mask, order);
 		goto restart;
 	}
 
