Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbULAJuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbULAJuN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 04:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbULAJuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 04:50:13 -0500
Received: from pD9E41731.dip.t-dialin.net ([217.228.23.49]:42397 "EHLO
	tglx.tec.linutronix.de") by vger.kernel.org with ESMTP
	id S261348AbULAJty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 04:49:54 -0500
Date: Wed, 1 Dec 2004 10:49:03 +0100
From: tglx@linutronix.de
Message-ID: <20041201104820.1.patchmail@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
To: akpm@osdl.org
Cc: andrea@suse.de, marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: [PATCH] oom killer (Core)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The oom killer has currently some strange effects when triggered.
It gets invoked multiple times and the selection of the task to kill
does not take processes into account which fork a lot of child processes.

The patch solves this by
- Preventing reentrancy
- Checking for memory threshold before selection and kill.
- Taking child processes into account when selecting the process to kill

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 oom_kill.c   |  113 ++++++++++++++++++++++++++++++++++++++++++-----------------
 page_alloc.c |    5 ++
 2 files changed, 86 insertions(+), 32 deletions(-)
---
diff -urN 2.6.10-rc2-mm4.orig/mm/oom_kill.c 2.6.10-rc2-mm4/mm/oom_kill.c
--- 2.6.10-rc2-mm4.orig/mm/oom_kill.c	2004-12-01 09:33:44.000000000 +0100
+++ 2.6.10-rc2-mm4/mm/oom_kill.c	2004-12-01 09:37:41.628396951 +0100
@@ -45,8 +45,10 @@
 static unsigned long badness(struct task_struct *p, unsigned long uptime)
 {
 	unsigned long points, cpu_time, run_time, s;
+        struct list_head *tsk;
 
-	if (!p->mm)
+	/* Ignore mm-less tasks and init */
+	if (!p->mm || p->pid == 1)
 		return 0;
 
 	if (p->flags & PF_MEMDIE)
@@ -57,6 +59,19 @@
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
@@ -176,6 +191,27 @@
 	return mm;
 }
 
+static struct mm_struct *oom_kill_process(task_t *p)
+{
+	struct mm_struct *mm;
+	struct task_struct *g, *q;
+
+	mm = oom_kill_task(p);
+	if (!mm)
+		return NULL;
+	/*
+	 * kill all processes that share the ->mm (i.e. all threads),
+	 * but are in a different thread group
+	 */
+	do_each_thread(g, q)
+		if (q->mm == mm && q->tgid != p->tgid)
+			__oom_kill_task(q);
+
+	while_each_thread(g, q);
+	if (!p->mm)
+		printk(KERN_INFO "Fixed up OOM kill of mm-less task\n");
+	return mm;
+}
 
 /**
  * oom_kill - kill the "best" process when we run out of memory
@@ -188,7 +224,9 @@
 void oom_kill(void)
 {
 	struct mm_struct *mm;
-	struct task_struct *g, *p, *q;
+	struct task_struct *c, *p;
+	struct list_head *tsk;
+	int mmcnt = 0;
 	
 	read_lock(&tasklist_lock);
 retry:
@@ -200,21 +238,32 @@
 		panic("Out of memory and no killable processes...\n");
 	}
 
-	mm = oom_kill_task(p);
-	if (!mm)
-		goto retry;
 	/*
-	 * kill all processes that share the ->mm (i.e. all threads),
-	 * but are in a different thread group
+	 * Kill the forked child processes first
 	 */
-	do_each_thread(g, q)
-		if (q->mm == mm && q->tgid != p->tgid)
-			__oom_kill_task(q);
-	while_each_thread(g, q);
-	if (!p->mm)
-		printk(KERN_INFO "Fixed up OOM kill of mm-less task\n");
+	list_for_each(tsk, &p->children) {
+		c = list_entry(tsk, struct task_struct, sibling);
+		/* Do not touch threads, as they get killed later */
+		if (c->mm == p->mm)
+			continue;
+		mm = oom_kill_process(c);
+		if (mm) {
+			mmcnt ++;
+			mmput(mm);
+		}
+	}
+
+	/*
+	 * If we managed to kill one or more child processes
+	 * then let the parent live for now
+	 */
+	if (!mmcnt) {
+		mm = oom_kill_process(p);
+		if (!mm)
+			goto retry;
+		mmput(mm);
+	}
 	read_unlock(&tasklist_lock);
-	mmput(mm);
 	return;
 }
 
@@ -224,14 +273,21 @@
 void out_of_memory(int gfp_mask)
 {
 	/*
-	 * oom_lock protects out_of_memory()'s static variables.
-	 * It's a global lock; this is not performance-critical.
-	 */
-	static DEFINE_SPINLOCK(oom_lock);
+ 	 * inprogress protects out_of_memory()'s static variables
+	 * and prevents reentrancy.
+  	 */
+ 	static unsigned long inprogress;
+ 	static unsigned int  freepages = 1000000;
 	static unsigned long first, last, count, lastkill;
 	unsigned long now, since;
 
-	spin_lock(&oom_lock);
+ 	if (test_and_set_bit(0, &inprogress))
+ 		return;
+ 	
+ 	/* Check, if memory was freed since the last oom kill */
+ 	if (freepages < nr_free_pages())
+ 		goto out_unlock;
+
 	now = jiffies;
 	since = now - last;
 	last = now;
@@ -271,12 +327,11 @@
 	 * Ok, really out of memory. Kill something.
 	 */
 	lastkill = now;
-
-	printk("oom-killer: gfp_mask=0x%x\n", gfp_mask);
+	printk(KERN_ERR "oom-killer: gfp_mask=0x%x\n", gfp_mask);
 	show_free_areas();
-
-	/* oom_kill() sleeps */
-	spin_unlock(&oom_lock);
+	dump_stack();
+	/* Store free pages  * 2 for the check above */
+	freepages = (nr_free_pages() << 1);
 	oom_kill();
 	/*
 	 * Make kswapd go out of the way, so "p" has a good chance of
@@ -284,17 +339,11 @@
 	 * for more memory.
 	 */
 	yield();
-	spin_lock(&oom_lock);
 
 reset:
-	/*
-	 * We dropped the lock above, so check to be sure the variable
-	 * first only ever increases to prevent false OOM's.
-	 */
-	if (time_after(now, first))
-		first = now;
+	first = jiffies;
 	count = 0;
 
 out_unlock:
-	spin_unlock(&oom_lock);
+	clear_bit(0, &inprogress);
 }
diff -urN 2.6.10-rc2-mm4.orig/mm/page_alloc.c 2.6.10-rc2-mm4/mm/page_alloc.c
--- 2.6.10-rc2-mm4.orig/mm/page_alloc.c	2004-12-01 09:33:44.000000000 +0100
+++ 2.6.10-rc2-mm4/mm/page_alloc.c	2004-12-01 09:36:55.010034604 +0100
@@ -872,6 +872,11 @@
 	p->reclaim_state = NULL;
 	p->flags &= ~PF_MEMALLOC;
 
+	/* Check if try_to_free_pages called out_of_memory and
+	 * if the current task is the sacrifice  */
+	if ((p->flags & PF_MEMDIE) && !in_interrupt())
+		goto nopage;
+
 	/* go through the zonelist yet one more time */
 	for (i = 0; (z = zones[i]) != NULL; i++) {
 		if (!zone_watermark_ok(z, order, z->pages_min,
