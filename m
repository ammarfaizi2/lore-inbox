Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbULCC3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbULCC3t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 21:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbULCC3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 21:29:49 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:3485 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261897AbULCC3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 21:29:09 -0500
Date: Fri, 3 Dec 2004 03:28:54 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       LKML <linux-kernel@vger.kernel.org>, nickpiggin@yahoo.com.au
Subject: Re: [PATCH] oom killer (Core)
Message-ID: <20041203022854.GL32635@dualathlon.random>
References: <20041201211638.GB4530@dualathlon.random> <1101938767.13353.62.camel@tglx.tec.linutronix.de> <20041202033619.GA32635@dualathlon.random> <1101985759.13353.102.camel@tglx.tec.linutronix.de> <1101995280.13353.124.camel@tglx.tec.linutronix.de> <20041202164725.GB32635@dualathlon.random> <20041202085518.58e0e8eb.akpm@osdl.org> <20041202180823.GD32635@dualathlon.random> <1102013716.13353.226.camel@tglx.tec.linutronix.de> <20041202233459.GF32635@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041202233459.GF32635@dualathlon.random>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2004 at 12:34:59AM +0100, Andrea Arcangeli wrote:
> I'll add to my last patch the removal of the PF_MEMDIE check in oom_kill
> plus I'll fix the remaining race with PF_EXITING/DEAD, and I'll add a
> cond_resched. Then you can try again with my simple way (w/ and w/o
> PREEMPT ;).

Ok, I expect this patch to fix the problem completely. The biggest
difference is that it doesn't affect the exit fast path and it doesn't need
notification. It's not even slower than your patch since you were
really polling too. This schedule properly, if you get any PREEMPT=n
problem I'd really like to know. This is on top of my previous patch so
it does the checks for the watermarks correctly (those are not obsoleted
by whatever thing we do in out_of_memory()). This still make use of the
PF_MEMDIE info but not in kernel/, only in mm/oom_kill.c where it born
and dies there, so the race is somewhat hidden in there. As you said
converting PF_MEMDIE to a set_tsk_thread_flag or some other non-racy
thing is a due change but I'm not doing it in the below patch.

With this thing, I doubt any wrong task will ever be killed again and
you won't risk to drive 150km again (or at least not for this problem ;).
Please test and apply to mainline if you agree.

 oom_kill.c   |  158 ++++++++++++++++++++---------------------------------------
 page_alloc.c |   60 ++++++++++++++++------
 swap_state.c |    2 
 vmscan.c     |    2 
 4 files changed, 103 insertions(+), 119 deletions(-)

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

Index: x/mm/oom_kill.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/mm/oom_kill.c,v
retrieving revision 1.31
diff -u -p -r1.31 oom_kill.c
--- x/mm/oom_kill.c	14 Oct 2004 04:27:49 -0000	1.31
+++ x/mm/oom_kill.c	3 Dec 2004 02:12:29 -0000
@@ -49,8 +49,6 @@ static unsigned long badness(struct task
 	if (!p->mm)
 		return 0;
 
-	if (p->flags & PF_MEMDIE)
-		return 0;
 	/*
 	 * The memory size of the process is the basis for the badness.
 	 */
@@ -120,14 +118,25 @@ static struct task_struct * select_bad_p
 
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
@@ -140,6 +149,12 @@ static struct task_struct * select_bad_p
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
@@ -169,9 +184,25 @@ static void __oom_kill_task(task_t *p)
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
 
@@ -184,117 +215,40 @@ static struct mm_struct *oom_kill_task(t
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
 
+	printk("oom-killer: gfp_mask=0x%x\n", gfp_mask);
+	show_free_areas();
 	mm = oom_kill_task(p);
 	if (!mm)
 		goto retry;
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
+ out:
+	read_unlock(&tasklist_lock);
+	if (mm)
+		mmput(mm);
 
 	/*
-	 * Ok, really out of memory. Kill something.
+	 * Give "p" a good chance of killing itself before we
+	 * retry to allocate memory.
 	 */
-	lastkill = now;
-
-	printk("oom-killer: gfp_mask=0x%x\n", gfp_mask);
-	show_free_areas();
-
-	/* oom_kill() sleeps */
-	spin_unlock(&oom_lock);
-	oom_kill();
-	spin_lock(&oom_lock);
-
-reset:
-	/*
-	 * We dropped the lock above, so check to be sure the variable
-	 * first only ever increases to prevent false OOM's.
-	 */
-	if (time_after(now, first))
-		first = now;
-	count = 0;
-
-out_unlock:
-	spin_unlock(&oom_lock);
+	__set_current_state(TASK_INTERRUPTIBLE);
+	schedule_timeout(1);
 }
Index: x/mm/page_alloc.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/mm/page_alloc.c,v
retrieving revision 1.236
diff -u -p -r1.236 page_alloc.c
--- x/mm/page_alloc.c	16 Nov 2004 03:53:53 -0000	1.236
+++ x/mm/page_alloc.c	3 Dec 2004 01:58:19 -0000
@@ -611,8 +611,10 @@ __alloc_pages(unsigned int gfp_mask, uns
 	int alloc_type;
 	int do_retry;
 	int can_try_harder;
+	int did_some_progress;
 
-	might_sleep_if(wait);
+	if (wait)
+		cond_resched();
 
 	/*
 	 * The caller may dip into page reserves a bit more if the caller
@@ -645,6 +647,7 @@ __alloc_pages(unsigned int gfp_mask, uns
 	for (i = 0; (z = zones[i]) != NULL; i++)
 		wakeup_kswapd(z);
 
+ restart:
 	/*
 	 * Go through the zonelist again. Let __GFP_HIGH and allocations
 	 * coming from realtime tasks to go deeper into reserves
@@ -681,31 +684,58 @@ __alloc_pages(unsigned int gfp_mask, uns
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
Index: x/mm/swap_state.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/mm/swap_state.c,v
retrieving revision 1.79
diff -u -p -r1.79 swap_state.c
--- x/mm/swap_state.c	29 Oct 2004 20:21:14 -0000	1.79
+++ x/mm/swap_state.c	3 Dec 2004 01:48:22 -0000
@@ -59,6 +59,8 @@ void show_swap_cache_info(void)
 		swap_cache_info.add_total, swap_cache_info.del_total,
 		swap_cache_info.find_success, swap_cache_info.find_total,
 		swap_cache_info.noent_race, swap_cache_info.exist_race);
+	printk("Free swap  = %lukB\n", nr_swap_pages << (PAGE_SHIFT - 10));
+	printk("Total swap = %lukB\n", total_swap_pages << (PAGE_SHIFT - 10));
 }
 
 /*
Index: x/mm/vmscan.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/mm/vmscan.c,v
retrieving revision 1.225
diff -u -p -r1.225 vmscan.c
--- x/mm/vmscan.c	19 Nov 2004 22:54:22 -0000	1.225
+++ x/mm/vmscan.c	2 Dec 2004 01:56:50 -0000
@@ -935,8 +935,6 @@ int try_to_free_pages(struct zone **zone
 		if (sc.nr_scanned && priority < DEF_PRIORITY - 2)
 			blk_congestion_wait(WRITE, HZ/10);
 	}
-	if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY))
-		out_of_memory(gfp_mask);
 out:
 	for (i = 0; zones[i] != 0; i++)
 		zones[i]->prev_priority = zones[i]->temp_priority;
