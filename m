Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWEVVpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWEVVpI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 17:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWEVVpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 17:45:07 -0400
Received: from smtp-1.llnl.gov ([128.115.3.81]:55168 "EHLO smtp-1.llnl.gov")
	by vger.kernel.org with ESMTP id S1751132AbWEVVpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 17:45:05 -0400
Date: Mon, 22 May 2006 14:43:54 -0700 (PDT)
Message-Id: <200605222143.k4MLhs2w021071@calaveras.llnl.gov>
From: Dave Peterson <dsp@llnl.gov>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, pj@sgi.com, ak@suse.de,
       linux-mm@kvack.org, garlick@llnl.gov, mgrondona@llnl.gov, dsp@llnl.gov
Subject: [PATCH (try #2)] mm: avoid unnecessary OOM kills
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a 2.6.17-rc4-mm3 patch that fixes a problem where the OOM killer was
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
This patch incorporates feedback from a previous posting (see
http://lkml.org/lkml/2006/5/18/181).  To address the issue of excessive
looping in __alloc_pages() I reworked the logic in oom_alloc() and moved a
call to schedule_timeout_interruptible() from out_of_memory() to oom_alloc().
Therefore this delay is not circumvented in the case where a task avoids
calling out_of_memory() because an OOM kill is already in progress.


diff -urNp -X dontdiff linux-2.6.17-rc4-mm3/include/linux/sched.h linux-2.6.17-rc4-mm3-oom/include/linux/sched.h
--- linux-2.6.17-rc4-mm3/include/linux/sched.h	2006-05-22 08:44:28.000000000 -0700
+++ linux-2.6.17-rc4-mm3-oom/include/linux/sched.h	2006-05-22 08:46:17.000000000 -0700
@@ -297,6 +297,9 @@ typedef unsigned long mm_counter_t;
 		(mm)->hiwater_vm = (mm)->total_vm;	\
 } while (0)
 
+/* bit #s for flags in mm_struct->flags... */
+#define MM_FLAG_OOM_NOTIFY 0
+
 struct mm_struct {
 	struct vm_area_struct * mmap;		/* list of VMAs */
 	struct rb_root mm_rb;
@@ -355,6 +358,8 @@ struct mm_struct {
 	/* aio bits */
 	rwlock_t		ioctx_list_lock;
 	struct kioctx		*ioctx_list;
+
+	unsigned long flags;
 };
 
 struct sighand_struct {
diff -urNp -X dontdiff linux-2.6.17-rc4-mm3/include/linux/swap.h linux-2.6.17-rc4-mm3-oom/include/linux/swap.h
--- linux-2.6.17-rc4-mm3/include/linux/swap.h	2006-05-22 08:44:28.000000000 -0700
+++ linux-2.6.17-rc4-mm3-oom/include/linux/swap.h	2006-05-22 08:46:17.000000000 -0700
@@ -155,7 +155,27 @@ struct swap_list_t {
 #define vm_swap_full() (nr_swap_pages*2 < total_swap_pages)
 
 /* linux/mm/oom_kill.c */
-extern void out_of_memory(struct zonelist *zonelist, gfp_t gfp_mask, int order);
+extern int oom_kill_in_progress;
+
+/* Return 1 if OOM kill in progress.  Else return 0. */
+static inline int oom_kill_active(void)
+{
+	return oom_kill_in_progress;
+}
+
+/* Start an OOM kill operation. */
+static inline void oom_kill_start(void)
+{
+	oom_kill_in_progress = 1;
+}
+
+/* Terminate an OOM kill operation. */
+static inline void oom_kill_finish(void)
+{
+	oom_kill_in_progress = 0;
+}
+
+extern int out_of_memory(struct zonelist *zonelist, gfp_t gfp_mask, int order);
 
 /* linux/mm/memory.c */
 extern void swapin_readahead(swp_entry_t, unsigned long, struct vm_area_struct *);
diff -urNp -X dontdiff linux-2.6.17-rc4-mm3/kernel/fork.c linux-2.6.17-rc4-mm3-oom/kernel/fork.c
--- linux-2.6.17-rc4-mm3/kernel/fork.c	2006-05-22 08:44:28.000000000 -0700
+++ linux-2.6.17-rc4-mm3-oom/kernel/fork.c	2006-05-22 08:46:17.000000000 -0700
@@ -329,6 +329,7 @@ static struct mm_struct * mm_init(struct
 	mm->ioctx_list = NULL;
 	mm->free_area_cache = TASK_UNMAPPED_BASE;
 	mm->cached_hole_size = ~0UL;
+	mm->flags = 0;
 
 	if (likely(!mm_alloc_pgd(mm))) {
 		mm->def_flags = 0;
@@ -382,6 +383,8 @@ void mmput(struct mm_struct *mm)
 			spin_unlock(&mmlist_lock);
 		}
 		put_swap_token(mm);
+		if (unlikely(test_bit(MM_FLAG_OOM_NOTIFY, &mm->flags)))
+			oom_kill_finish();  /* terminate pending OOM kill */
 		mmdrop(mm);
 	}
 }
diff -urNp -X dontdiff linux-2.6.17-rc4-mm3/mm/oom_kill.c linux-2.6.17-rc4-mm3-oom/mm/oom_kill.c
--- linux-2.6.17-rc4-mm3/mm/oom_kill.c	2006-05-22 08:44:28.000000000 -0700
+++ linux-2.6.17-rc4-mm3-oom/mm/oom_kill.c	2006-05-22 08:46:17.000000000 -0700
@@ -25,6 +25,8 @@
 int sysctl_panic_on_oom;
 /* #define DEBUG */
 
+int oom_kill_in_progress;
+
 /**
  * badness - calculate a numeric value for how bad this task has been
  * @p: task struct of which task we should calculate
@@ -260,27 +262,31 @@ static int oom_kill_task(task_t *p, cons
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
 
@@ -313,19 +319,19 @@ static int oom_kill_process(struct task_
  * killing a random task (bad), letting the system crash (worse)
  * OR try to be smart about which process to kill. Note that we
  * don't have to be perfect here, we just have to be good.
+ *
+ * Return 0 if we actually shot a process.  Else return 1.
  */
-void out_of_memory(struct zonelist *zonelist, gfp_t gfp_mask, int order)
+int out_of_memory(struct zonelist *zonelist, gfp_t gfp_mask, int order)
 {
 	task_t *p;
 	unsigned long points = 0;
+	const char *msg = NULL;
+	int ret = 1;
 
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
 
@@ -335,19 +341,19 @@ void out_of_memory(struct zonelist *zone
 	 */
 	switch (constrained_alloc(zonelist, gfp_mask)) {
 	case CONSTRAINT_MEMORY_POLICY:
-		oom_kill_process(current, points,
-				"No available memory (MPOL_BIND)");
+		p = current;
+		msg = "No available memory (MPOL_BIND)";
 		break;
 
 	case CONSTRAINT_CPUSET:
-		oom_kill_process(current, points,
-				"No available memory in cpuset");
+		p = current;
+		msg = "No available memory in cpuset";
 		break;
 
 	case CONSTRAINT_NONE:
 		if (sysctl_panic_on_oom)
 			panic("out of memory. panic_on_oom is selected\n");
-retry:
+
 		/*
 		 * Rambo mode: Shoot down a process and hope it solves whatever
 		 * issues we may have.
@@ -364,20 +370,17 @@ retry:
 			panic("Out of memory and no killable processes...\n");
 		}
 
-		if (oom_kill_process(p, points, "Out of memory"))
-			goto retry;
-
+		msg = "Out of memory";
 		break;
+
+	default:
+		BUG();
 	}
 
+	ret = oom_kill_process(p, points, msg);
+
 out:
 	read_unlock(&tasklist_lock);
 	cpuset_unlock();
-
-	/*
-	 * Give "p" a good chance of killing itself before we
-	 * retry to allocate memory unless "p" is current
-	 */
-	if (!test_thread_flag(TIF_MEMDIE))
-		schedule_timeout_uninterruptible(1);
+	return ret;
 }
diff -urNp -X dontdiff linux-2.6.17-rc4-mm3/mm/page_alloc.c linux-2.6.17-rc4-mm3-oom/mm/page_alloc.c
--- linux-2.6.17-rc4-mm3/mm/page_alloc.c	2006-05-22 08:44:28.000000000 -0700
+++ linux-2.6.17-rc4-mm3-oom/mm/page_alloc.c	2006-05-22 08:46:17.000000000 -0700
@@ -992,6 +992,60 @@ static inline void set_page_owner(struct
 }
 #endif /* CONFIG_PAGE_OWNER */
 
+/* Try to allocate one more time before invoking the OOM killer. */
+static struct page * oom_alloc(gfp_t gfp_mask, unsigned int order,
+		struct zonelist *zonelist)
+{
+	static DECLARE_MUTEX(sem);
+	struct page *page;
+
+	down(&sem);
+
+	/* Prevent parallel OOM kill operations.  This fixes a problem where
+	 * the OOM killer was observed shooting system daemons in addition to
+	 * memory-hogging user processes.
+	 */
+	if (oom_kill_active()) {
+		up(&sem);
+		goto out_sleep;
+	}
+
+	/* If we get here, we _know_ that any previous OOM killer victim has
+	 * cleaned out its mm_struct.  Therefore we should pick a victim to
+	 * shoot if this allocation fails.
+	 */
+	page = get_page_from_freelist(gfp_mask | __GFP_HARDWALL, order,
+				zonelist, ALLOC_WMARK_HIGH | ALLOC_CPUSET);
+
+	if (page) {
+		up(&sem);
+		return page;
+	}
+
+	oom_kill_start();
+	up(&sem);
+
+	/* Try to shoot a process.  Call oom_kill_finish() only if the OOM
+	 * killer did not shoot anything.  If the OOM killer shot something,
+	 * mmput() will call oom_kill_finish() once the mm_users count of the
+	 * victim's mm_struct has reached 0 and the mm_struct has been cleaned
+	 * out.
+	 */
+	if (out_of_memory(zonelist, gfp_mask, order))
+		oom_kill_finish();  /* cancel OOM kill */
+
+out_sleep:
+	/* Did we get shot by the OOM killer?  If not, sleep for a while to
+	 * avoid burning lots of CPU cycles looping in the memory allocator.
+	 * If the OOM killer shot a process, this gives the victim a good
+	 * chance to die before we retry allocation.
+	 */
+	if (!test_thread_flag(TIF_MEMDIE))
+		schedule_timeout_uninterruptible(1);
+
+	return NULL;
+}
+
 /*
  * This is the 'heart' of the zoned buddy allocator.
  */
@@ -1103,18 +1157,9 @@ rebalance:
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
+		page = oom_alloc(gfp_mask, order, zonelist);
 		if (page)
 			goto got_pg;
-
-		out_of_memory(zonelist, gfp_mask, order);
 		goto restart;
 	}
 
