Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262209AbSIYXHU>; Wed, 25 Sep 2002 19:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262213AbSIYXHU>; Wed, 25 Sep 2002 19:07:20 -0400
Received: from westholme.seas.ucla.edu ([164.67.100.27]:64401 "EHLO
	westholme.seas.ucla.edu") by vger.kernel.org with ESMTP
	id <S262209AbSIYXHT>; Wed, 25 Sep 2002 19:07:19 -0400
Date: Wed, 25 Sep 2002 16:12:35 -0700 (PDT)
From: Xiao Feng Shi <xiaos@seas.ucla.edu>
Message-Id: <200209252312.QAA29840@westholme.seas.ucla.edu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] RLIMIT_RSS killer for embedded systems
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is for embedded systems with no swap where you want
to kill processes that are using too much physical memory.
It's not suitable for most systems.
It should be a configure option, but I didn't have time to do that yet.

This is my first kernel patch... does anyone see an obvious problem?

--- linux-2.4.19.orig/mm/memory.c	2002-08-02 17:39:46.000000000 -0700
+++ linux-2.4.19/mm/memory.c	2002-09-25 15:41:03.000000000 -0700
@@ -1359,6 +1359,62 @@
 	return 1;
 }
 
+#define RSS_OOM_KILLER
+
+#ifdef RSS_OOM_KILLER
+/* Kill a single task which is using too much memory.
+ * Stolen from oom_kill.c::oom_kill_task()
+ * FIXME: tailor more closely for embedded systems with no swap device
+ */
+static void rss_oom_kill_task(struct task_struct *p)
+{
+	printk(KERN_ERR "Out of RSS: Killed process %d (%s).\n", p->pid, p->comm);
+
+	/*
+	 * Give the offending process high priority and access to
+	 * all the memory it needs. That way it should be able to
+	 * exit() and clear out its resources quickly...
+	 */
+	p->counter = 5 * HZ;
+	p->flags |= PF_MEMALLOC | PF_MEMDIE;
+
+	/* This process has hardware access, be more careful. */
+	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)) {
+		force_sig(SIGTERM, p);
+	} else {
+		force_sig(SIGKILL, p);
+	}
+}
+
+/**
+ * rss_oom_kill - kill all processes that share mm
+ * Stolen from oom_kill.c::oom_kill()
+ * FIXME: tailor more closely for embedded systems with no swap device
+ */
+static void rss_oom_kill(struct mm_struct *mm)
+{
+	struct task_struct *q;
+
+	read_lock(&tasklist_lock);
+
+	/* kill all processes that share the ->mm (i.e. all threads) */
+	for_each_task(q) {
+		if (q->mm == mm)
+			rss_oom_kill_task(q);
+	}
+	read_unlock(&tasklist_lock);
+
+	/*
+	 * Make kswapd go out of the way, so "p" has a good chance of
+	 * killing itself before someone else gets the chance to ask
+	 * for more memory.
+	 */
+	current->policy |= SCHED_YIELD;
+	schedule();
+	return;
+}
+#endif
+
 /*
  * By the time we get here, we already hold the mm semaphore
  */
@@ -1378,6 +1434,12 @@
 	spin_lock(&mm->page_table_lock);
 	pmd = pmd_alloc(mm, pgd, address);
 
+#ifdef RSS_OOM_KILLER
+	/* Enforce limit on RSS. */
+	if (mm->rss >= (current->rlim[RLIMIT_RSS].rlim_max >> PAGE_SHIFT)) 
+		rss_oom_kill(mm);
+#endif
+
 	if (pmd) {
 		pte_t * pte = pte_alloc(mm, pmd, address);
 		if (pte)

p.s.
I did this in cahoots with dank@kegel.com, who needed it for his
job at Ixia Communications.
