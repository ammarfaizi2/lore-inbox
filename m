Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbULXRor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbULXRor (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 12:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbULXRor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 12:44:47 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:22693 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261410AbULXRmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 12:42:11 -0500
Date: Fri, 24 Dec 2004 18:41:56 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>
Subject: VM fixes [4/4]
Message-ID: <20041224174156.GE13747@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the core of the oom-killer fixes I developed partly taking the
idea from Thomas's patches of getting feedback from the exit path, plus
I moved the oom killer into page_alloc.c as it should to be able to
check the watermarks before killing more stuff. This also tweaks the
badness to take thread bombs more into account (that change to badness
is from Thomas, from my part I'd rather rewrite badness from scratch
instead, but that's an orthgonal issue ;). This also merges your write
throttling fix. With this applied the oom killer is very sane, no more 5
sec waits and suprious oom kills.

Write throttling works perfectly here with these 4 patches applied to
2.6.10-rc3, no idea what other breakage Rik has in his kernel that kills
tasks with a cp /dev/zero /tmp. I doubt it's related to the harddisk
timings, my hd is fast, but the deviation between HD speed and ram speed
is so huge that it shouldn't matter.

Rik I'd recommend to try with 2.6.10-rc3 mainline with only these 4
patches applied and see if you can reproduce. If you can really still
reproduce (i mean without tweaking the sysclt default values) this will
still make it a good base to start working on to fix more bugs.

Please apply all 4 patches to mainline, thanks! They're all against
2.6.10-rc3 (bkcvs is broken and I'm not yet adapted the bk snapshots,
I still have the hope that bkcvs will be eventually fixed)

From: Andrea Arcangeli <andrea@suse.de>
Subject: fix several oom killer bugs, most important avoid spurious oom kills
 badness algorithm tweaked by Thomas Gleixner and throttling fix from
 Andrew

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

From: Andrea Arcangeli <andrea@suse.de>
Subject: fix several oom killer bugs, most important avoid spurious oom
 kills, badness algorithm tweaked by Thomas Gleixner and write throttling 
 from Andrew

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

--- x/include/linux/sched.h.orig	2004-12-24 17:53:50.806536304 +0100
+++ x/include/linux/sched.h	2004-12-24 18:00:58.267552352 +0100
@@ -601,6 +601,11 @@ struct task_struct {
 	struct key *thread_keyring;	/* keyring private to this thread */
 #endif
 /*
+ * All archs should support atomic ops with
+ * 1 byte granularity.
+ */
+	unsigned char memdie;
+/*
  * Must be changed atomically so it shouldn't be
  * be a shareable bitflag.
  */
@@ -715,8 +720,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_DUMPCORE	0x00000200	/* dumped core */
 #define PF_SIGNALED	0x00000400	/* killed by a signal */
 #define PF_MEMALLOC	0x00000800	/* Allocating memory */
-#define PF_MEMDIE	0x00001000	/* Killed for out-of-memory */
-#define PF_FLUSHER	0x00002000	/* responsible for disk writeback */
+#define PF_FLUSHER	0x00001000	/* responsible for disk writeback */
 
 #define PF_FREEZE	0x00004000	/* this task should be frozen for suspend */
 #define PF_NOFREEZE	0x00008000	/* this thread should not be frozen */
--- x/kernel/exit.c.orig	2004-12-04 08:56:33.000000000 +0100
+++ x/kernel/exit.c	2004-12-24 18:00:58.270551896 +0100
@@ -242,9 +242,8 @@ void reparent_to_init(void)
 	memcpy(current->signal->rlim, init_task.signal->rlim,
 	       sizeof(current->signal->rlim));
 	atomic_inc(&(INIT_USER->__count));
-	switch_uid(INIT_USER);
-
 	write_unlock_irq(&tasklist_lock);
+	switch_uid(INIT_USER);
 }
 
 void __set_special_pids(pid_t session, pid_t pgrp)
--- x/mm/oom_kill.c.orig	2004-12-24 17:53:50.807536152 +0100
+++ x/mm/oom_kill.c	2004-12-24 18:01:19.903263224 +0100
@@ -45,18 +45,30 @@
 unsigned long badness(struct task_struct *p, unsigned long uptime)
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
@@ -131,14 +143,24 @@ static struct task_struct * select_bad_p
 
 	do_posix_clock_monotonic_gettime(&uptime);
 	do_each_thread(g, p)
-		if (p->pid) {
-			unsigned long points = badness(p, uptime.tv_sec);
-			if (points > maxpoints) {
+		/* skip the init task with pid == 1 */
+		if (p->pid > 1) {
+			unsigned long points;
+
+			/*
+			 * This is in the process of releasing memory so wait it
+			 * to finish before killing some other task by mistake.
+			 */
+			if ((p->memdie || (p->flags & PF_EXITING)) && !(p->flags & PF_DEAD))
+				return ERR_PTR(-1UL);
+			if (p->flags & PF_SWAPOFF)
+				return p;
+
+			points = badness(p, uptime.tv_sec);
+			if (points > maxpoints || !chosen) {
 				chosen = p;
 				maxpoints = points;
 			}
-			if (p->flags & PF_SWAPOFF)
-				return p;
 		}
 	while_each_thread(g, p);
 	return chosen;
@@ -151,6 +173,12 @@ static struct task_struct * select_bad_p
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
@@ -167,7 +195,7 @@ static void __oom_kill_task(task_t *p)
 	 * exit() and clear out its resources quickly...
 	 */
 	p->time_slice = HZ;
-	p->flags |= PF_MEMALLOC | PF_MEMDIE;
+	p->memdie = 1;
 
 	/* This process has hardware access, be more careful. */
 	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)) {
@@ -180,12 +208,45 @@ static void __oom_kill_task(task_t *p)
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
@@ -195,117 +256,40 @@ static struct mm_struct *oom_kill_task(t
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
--- x/mm/page_alloc.c.orig	2004-12-24 17:59:36.182031248 +0100
+++ x/mm/page_alloc.c	2004-12-24 18:00:58.276550984 +0100
@@ -606,6 +606,7 @@ __alloc_pages(unsigned int gfp_mask, uns
 	int classzone_idx;
 	int do_retry;
 	int can_try_harder;
+	int did_some_progress;
 
 	might_sleep_if(wait);
 
@@ -625,6 +626,7 @@ __alloc_pages(unsigned int gfp_mask, uns
 
 	classzone_idx = zone_idx(zones[0]);
 
+ restart:
 	/* Go through the zonelist once, looking for a zone with enough free */
 	for (i = 0; (z = zones[i]) != NULL; i++) {
 		min = z->pages_low + (1<<order) + z->lowmem_reserve[classzone_idx];
@@ -661,7 +663,7 @@ __alloc_pages(unsigned int gfp_mask, uns
 	}
 
 	/* This allocation should allow future memory freeing. */
-	if ((p->flags & (PF_MEMALLOC | PF_MEMDIE)) && !in_interrupt()) {
+	if (((p->flags & PF_MEMALLOC) || p->memdie) && !in_interrupt()) {
 		/* go through the zonelist yet again, ignoring mins */
 		for (i = 0; (z = zones[i]) != NULL; i++) {
 			page = buffered_rmqueue(z, order, gfp_mask);
@@ -676,31 +678,58 @@ __alloc_pages(unsigned int gfp_mask, uns
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
-		min += (1<<order) + z->lowmem_reserve[classzone_idx];
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
+			min += (1<<order) + z->lowmem_reserve[classzone_idx];
 
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
+			min += (1<<order) + z->lowmem_reserve[classzone_idx];
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
--- x/mm/swap_state.c.orig	2004-12-04 08:56:33.000000000 +0100
+++ x/mm/swap_state.c	2004-12-24 18:00:58.277550832 +0100
@@ -59,6 +59,8 @@ void show_swap_cache_info(void)
 		swap_cache_info.add_total, swap_cache_info.del_total,
 		swap_cache_info.find_success, swap_cache_info.find_total,
 		swap_cache_info.noent_race, swap_cache_info.exist_race);
+	printk("Free swap  = %lukB\n", nr_swap_pages << (PAGE_SHIFT - 10));
+	printk("Total swap = %lukB\n", total_swap_pages << (PAGE_SHIFT - 10));
 }
 
 /*
--- x/mm/vmscan.c.orig	2004-12-04 08:56:33.000000000 +0100
+++ x/mm/vmscan.c	2004-12-24 18:00:58.280550376 +0100
@@ -935,8 +935,6 @@ int try_to_free_pages(struct zone **zone
 		if (sc.nr_scanned && priority < DEF_PRIORITY - 2)
 			blk_congestion_wait(WRITE, HZ/10);
 	}
-	if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY))
-		out_of_memory(gfp_mask);
 out:
 	for (i = 0; zones[i] != 0; i++)
 		zones[i]->prev_priority = zones[i]->temp_priority;
@@ -1063,6 +1061,7 @@ scan:
 			shrink_slab(sc.nr_scanned, GFP_KERNEL, lru_pages);
 			sc.nr_reclaimed += reclaim_state->reclaimed_slab;
 			total_reclaimed += sc.nr_reclaimed;
+			total_scanned += sc.nr_scanned;
 			if (zone->all_unreclaimable)
 				continue;
 			if (zone->pages_scanned >= (zone->nr_active +
