Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbULJQxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbULJQxx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 11:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbULJQxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 11:53:52 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:61060
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261757AbULJQwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 11:52:36 -0500
Subject: Re: [PATCH] oom killer (Core)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, andrea@suse.de,
       marcelo.tosatti@cyclades.com, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041210163247.GM2714@holomorphy.com>
References: <20041201104820.1.patchmail@tglx>
	 <20041210163247.GM2714@holomorphy.com>
Content-Type: multipart/mixed; boundary="=-+Mv7FBB7JXD4yP0oIpxU"
Date: Fri, 10 Dec 2004 17:52:33 +0100
Message-Id: <1102697553.3306.91.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-6) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+Mv7FBB7JXD4yP0oIpxU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2004-12-10 at 08:32 -0800, William Lee Irwin III wrote:
> On Wed, Dec 01, 2004 at 10:49:03AM +0100, tglx@linutronix.de wrote:
> > The oom killer has currently some strange effects when triggered.
> > It gets invoked multiple times and the selection of the task to kill
> > does not take processes into account which fork a lot of child processes.
> > The patch solves this by
> > - Preventing reentrancy
> > - Checking for memory threshold before selection and kill.
> > - Taking child processes into account when selecting the process to kill
> 
> It appears the net functional change here is the reentrancy prevention;
> the choice of tasks is policy. The functional change may be accomplished
> with the following:

Your patch would call yield() with the lock held. On an UP machine you
end up in the same code, as spin_locks are NOPs except for the preempt
part.

It's now obsolete by the fixes which were done by Andrea. 

I'm wondering why he did not post the final version. Andrea ???

Attached is the latest working and tested patch. It contains Andrea's
fixes to the oom invocation and my modifications to the selection whom
to kill.

This should really go into mainline.

tglx


--=-+Mv7FBB7JXD4yP0oIpxU
Content-Disposition: attachment; filename=oom-final.diff
Content-Type: text/x-patch; name=oom-final.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -urN 2.6.10-rc2.orig/mm/oom_kill.c 2.6.10-rc2.oom/mm/oom_kill.c
--- 2.6.10-rc2.orig/mm/oom_kill.c	2004-12-10 17:39:07.000000000 +0100
+++ 2.6.10-rc2.oom/mm/oom_kill.c	2004-12-05 16:46:42.000000000 +0100
@@ -45,18 +45,30 @@
 static unsigned long badness(struct task_struct *p, unsigned long uptime)
 {
 	unsigned long points, cpu_time, run_time, s;
+	struct list_head *tsk;
 
 	if (!p->mm)
 		return 0;
 
-	if (p->flags & PF_MEMDIE)
-		return 0;
 	/*
 	 * The memory size of the process is the basis for the badness.
 	 */
 	points = p->mm->total_vm;
 
 	/*
+	 * Processes which fork a lot of child processes are likely 
+	 * a good choice. We add the vmsize of the childs if they
+	 * have an own mm. This prevents forking servers to flood the
+	 * machine with an endless amount of childs
+	 */
+	list_for_each(tsk, &p->children) {
+		struct task_struct *chld;
+		chld = list_entry(tsk, struct task_struct, sibling);
+		if (chld->mm != p->mm && chld->mm)
+			points += chld->mm->total_vm;
+	}
+
+	/*
 	 * CPU time is in tens of seconds and run time is in thousands
          * of seconds. There is no particular reason for this other than
          * that it turned out to work very well in practice.
@@ -120,14 +132,25 @@
 
 	do_posix_clock_monotonic_gettime(&uptime);
 	do_each_thread(g, p)
-		if (p->pid) {
-			unsigned long points = badness(p, uptime.tv_sec);
+		/* skip the init task with pid == 1 */
+		if (p->pid > 1) {
+			unsigned long points;
+
+			/*
+			 * This is in the process of releasing memory so wait it
+			 * to finish before killing some other task by mistake.
+			 */
+			if ((p->flags & PF_MEMDIE) ||
+			    ((p->flags & PF_EXITING) && !(p->flags & PF_DEAD)))
+				return ERR_PTR(-1UL);
+			if (p->flags & PF_SWAPOFF)
+				return p;
+
+			points = badness(p, uptime.tv_sec);
 			if (points > maxpoints) {
 				chosen = p;
 				maxpoints = points;
 			}
-			if (p->flags & PF_SWAPOFF)
-				return p;
 		}
 	while_each_thread(g, p);
 	return chosen;
@@ -140,6 +163,12 @@
  */
 static void __oom_kill_task(task_t *p)
 {
+	if (p->pid == 1) {
+		WARN_ON(1);
+		printk(KERN_WARNING "tried to kill init!\n");
+		return;
+	}
+
 	task_lock(p);
 	if (!p->mm || p->mm == &init_mm) {
 		WARN_ON(1);
@@ -169,12 +198,45 @@
 static struct mm_struct *oom_kill_task(task_t *p)
 {
 	struct mm_struct *mm = get_task_mm(p);
-	if (!mm || mm == &init_mm)
+	task_t * g, * q;
+
+	if (!mm)
 		return NULL;
+	if (mm == &init_mm) {
+		mmput(mm);
+		return NULL;
+	}
+
 	__oom_kill_task(p);
+	/*
+	 * kill all processes that share the ->mm (i.e. all threads),
+	 * but are in a different thread group
+	 */
+	do_each_thread(g, q)
+		if (q->mm == mm && q->tgid != p->tgid)
+			__oom_kill_task(q);
+	while_each_thread(g, q);
+
 	return mm;
 }
 
+static struct mm_struct *oom_kill_process(task_t *p)
+{
+ 	struct mm_struct *mm;
+	struct task_struct *c;
+	struct list_head *tsk;
+
+	/* Try to kill a child first */
+	list_for_each(tsk, &p->children) {
+		c = list_entry(tsk, struct task_struct, sibling);
+		if (c->mm == p->mm)
+			continue;
+		mm = oom_kill_task(c);
+		if (mm)
+			return mm;
+	}
+	return oom_kill_task(p);
+}
 
 /**
  * oom_kill - kill the "best" process when we run out of memory
@@ -184,117 +246,40 @@
  * OR try to be smart about which process to kill. Note that we
  * don't have to be perfect here, we just have to be good.
  */
-static void oom_kill(void)
+void out_of_memory(int gfp_mask)
 {
-	struct mm_struct *mm;
-	struct task_struct *g, *p, *q;
-	
+	struct mm_struct *mm = NULL;
+	task_t * p;
+
 	read_lock(&tasklist_lock);
 retry:
 	p = select_bad_process();
 
+	if (PTR_ERR(p) == -1UL)
+		goto out;
+
 	/* Found nothing?!?! Either we hang forever, or we panic. */
 	if (!p) {
+		read_unlock(&tasklist_lock);
 		show_free_areas();
 		panic("Out of memory and no killable processes...\n");
 	}
 
-	mm = oom_kill_task(p);
-	if (!mm)
-		goto retry;
-	/*
-	 * kill all processes that share the ->mm (i.e. all threads),
-	 * but are in a different thread group
-	 */
-	do_each_thread(g, q)
-		if (q->mm == mm && q->tgid != p->tgid)
-			__oom_kill_task(q);
-	while_each_thread(g, q);
-	if (!p->mm)
-		printk(KERN_INFO "Fixed up OOM kill of mm-less task\n");
-	read_unlock(&tasklist_lock);
-	mmput(mm);
-
-	/*
-	 * Make kswapd go out of the way, so "p" has a good chance of
-	 * killing itself before someone else gets the chance to ask
-	 * for more memory.
-	 */
-	yield();
-	return;
-}
-
-/**
- * out_of_memory - is the system out of memory?
- */
-void out_of_memory(int gfp_mask)
-{
-	/*
-	 * oom_lock protects out_of_memory()'s static variables.
-	 * It's a global lock; this is not performance-critical.
-	 */
-	static spinlock_t oom_lock = SPIN_LOCK_UNLOCKED;
-	static unsigned long first, last, count, lastkill;
-	unsigned long now, since;
-
-	spin_lock(&oom_lock);
-	now = jiffies;
-	since = now - last;
-	last = now;
-
-	/*
-	 * If it's been a long time since last failure,
-	 * we're not oom.
-	 */
-	if (since > 5*HZ)
-		goto reset;
-
-	/*
-	 * If we haven't tried for at least one second,
-	 * we're not really oom.
-	 */
-	since = now - first;
-	if (since < HZ)
-		goto out_unlock;
-
-	/*
-	 * If we have gotten only a few failures,
-	 * we're not really oom. 
-	 */
-	if (++count < 10)
-		goto out_unlock;
-
-	/*
-	 * If we just killed a process, wait a while
-	 * to give that task a chance to exit. This
-	 * avoids killing multiple processes needlessly.
-	 */
-	since = now - lastkill;
-	if (since < HZ*5)
-		goto out_unlock;
-
-	/*
-	 * Ok, really out of memory. Kill something.
-	 */
-	lastkill = now;
-
 	printk("oom-killer: gfp_mask=0x%x\n", gfp_mask);
 	show_free_areas();
+	mm = oom_kill_process(p);
+	if (!mm)
+		goto retry;
 
-	/* oom_kill() sleeps */
-	spin_unlock(&oom_lock);
-	oom_kill();
-	spin_lock(&oom_lock);
+ out:
+	read_unlock(&tasklist_lock);
+	if (mm)
+		mmput(mm);
 
-reset:
 	/*
-	 * We dropped the lock above, so check to be sure the variable
-	 * first only ever increases to prevent false OOM's.
+	 * Give "p" a good chance of killing itself before we
+	 * retry to allocate memory.
 	 */
-	if (time_after(now, first))
-		first = now;
-	count = 0;
-
-out_unlock:
-	spin_unlock(&oom_lock);
+	__set_current_state(TASK_INTERRUPTIBLE);
+	schedule_timeout(1);
 }
diff -urN 2.6.10-rc2.orig/mm/page_alloc.c 2.6.10-rc2.oom/mm/page_alloc.c
--- 2.6.10-rc2.orig/mm/page_alloc.c	2004-12-10 17:39:07.000000000 +0100
+++ 2.6.10-rc2.oom/mm/page_alloc.c	2004-12-05 16:42:38.000000000 +0100
@@ -611,9 +611,10 @@
 	int alloc_type;
 	int do_retry;
 	int can_try_harder;
+	int did_some_progress;
 
 	might_sleep_if(wait);
-
+	
 	/*
 	 * The caller may dip into page reserves a bit more if the caller
 	 * cannot run direct reclaim, or is the caller has realtime scheduling
@@ -638,13 +639,15 @@
 			continue;
 
 		page = buffered_rmqueue(z, order, gfp_mask);
-		if (page)
+		if (page) {
 			goto got_pg;
+		}
 	}
 
 	for (i = 0; (z = zones[i]) != NULL; i++)
 		wakeup_kswapd(z);
 
+ restart:
 	/*
 	 * Go through the zonelist again. Let __GFP_HIGH and allocations
 	 * coming from realtime tasks to go deeper into reserves
@@ -681,31 +684,58 @@
 		goto nopage;
 
 rebalance:
+	cond_resched();
+
 	/* We now go into synchronous reclaim */
 	p->flags |= PF_MEMALLOC;
 	reclaim_state.reclaimed_slab = 0;
 	p->reclaim_state = &reclaim_state;
 
-	try_to_free_pages(zones, gfp_mask, order);
+	did_some_progress = try_to_free_pages(zones, gfp_mask, order);
 
 	p->reclaim_state = NULL;
 	p->flags &= ~PF_MEMALLOC;
 
-	/* go through the zonelist yet one more time */
-	for (i = 0; (z = zones[i]) != NULL; i++) {
-		min = z->pages_min;
-		if (gfp_mask & __GFP_HIGH)
-			min /= 2;
-		if (can_try_harder)
-			min -= min / 4;
-		min += (1<<order) + z->protection[alloc_type];
+	cond_resched();
 
-		if (z->free_pages < min)
-			continue;
+	if (likely(did_some_progress)) {
+		/* go through the zonelist yet one more time */
+		for (i = 0; (z = zones[i]) != NULL; i++) {
+			min = z->pages_min;
+			if (gfp_mask & __GFP_HIGH)
+				min /= 2;
+			if (can_try_harder)
+				min -= min / 4;
+			min += (1<<order) + z->protection[alloc_type];
 
-		page = buffered_rmqueue(z, order, gfp_mask);
-		if (page)
-			goto got_pg;
+			if (z->free_pages < min)
+				continue;
+
+			page = buffered_rmqueue(z, order, gfp_mask);
+			if (page)
+				goto got_pg;
+		}
+	} else if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY)) {
+		/*
+		 * Go through the zonelist yet one more time, keep
+		 * very high watermark here, this is only to catch
+		 * a parallel oom killing, we must fail if we're still
+		 * under heavy pressure.
+		 */
+		for (i = 0; (z = zones[i]) != NULL; i++) {
+			min = z->pages_high;
+			min += (1<<order) + z->protection[alloc_type];
+
+			if (z->free_pages < min)
+				continue;
+
+			page = buffered_rmqueue(z, order, gfp_mask);
+			if (page)
+				goto got_pg;
+		}
+
+		out_of_memory(gfp_mask);
+		goto restart;
 	}
 
 	/*
diff -urN 2.6.10-rc2.orig/mm/swap_state.c 2.6.10-rc2.oom/mm/swap_state.c
--- 2.6.10-rc2.orig/mm/swap_state.c	2004-12-10 17:39:07.000000000 +0100
+++ 2.6.10-rc2.oom/mm/swap_state.c	2004-12-04 18:52:38.000000000 +0100
@@ -59,6 +59,8 @@
 		swap_cache_info.add_total, swap_cache_info.del_total,
 		swap_cache_info.find_success, swap_cache_info.find_total,
 		swap_cache_info.noent_race, swap_cache_info.exist_race);
+	printk("Free swap  = %lukB\n", nr_swap_pages << (PAGE_SHIFT - 10));
+	printk("Total swap = %lukB\n", total_swap_pages << (PAGE_SHIFT - 10));
 }
 
 /*
diff -urN 2.6.10-rc2.orig/mm/vmscan.c 2.6.10-rc2.oom/mm/vmscan.c
--- 2.6.10-rc2.orig/mm/vmscan.c	2004-12-10 17:39:07.000000000 +0100
+++ 2.6.10-rc2.oom/mm/vmscan.c	2004-12-04 18:52:38.000000000 +0100
@@ -935,8 +935,6 @@
 		if (sc.nr_scanned && priority < DEF_PRIORITY - 2)
 			blk_congestion_wait(WRITE, HZ/10);
 	}
-	if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY))
-		out_of_memory(gfp_mask);
 out:
 	for (i = 0; zones[i] != 0; i++)
 		zones[i]->prev_priority = zones[i]->temp_priority;

--=-+Mv7FBB7JXD4yP0oIpxU--

