Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbULEQ3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbULEQ3k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 11:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbULEQ3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 11:29:40 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:59520
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261311AbULEQ3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 11:29:33 -0500
Subject: Re: [PATCH] oom killer (Core)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrea Arcangeli <andrea@suse.de>
Cc: Voluspa <lista4@comhem.se>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041205153404.GC30536@dualathlon.random>
References: <200412041242.iB4CgsN07246@d1o408.telia.com>
	 <20041204164353.GE32635@dualathlon.random>
	 <1102185205.13353.309.camel@tglx.tec.linutronix.de>
	 <1102194124.13353.331.camel@tglx.tec.linutronix.de>
	 <20041205002736.GE13244@dualathlon.random>
	 <1102258507.13353.366.camel@tglx.tec.linutronix.de>
	 <20041205153404.GC30536@dualathlon.random>
Content-Type: multipart/mixed; boundary="=-uCMt3C7S3aWrmGiOC1eH"
Date: Sun, 05 Dec 2004 17:29:31 +0100
Message-Id: <1102264171.13353.389.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uCMt3C7S3aWrmGiOC1eH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2004-12-05 at 16:34 +0100, Andrea Arcangeli wrote:
> On Sun, Dec 05, 2004 at 03:55:07PM +0100, Thomas Gleixner wrote:
> > Yes, the modification are not interfering with your patch. They just add
> > the accounting of child processes to the selection.
> 
> Could you post your modifications on top of my patch so we can combine
> them easily?

The patch is against 2.6.10-rc2-your-latest-patch

It adds the VM size of the child processes and tries to kill a child of
the selected process first. It could be discussed, if we just kill the
parent, but it turned out that the kill child first approach has less
unexpected results.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

> > That makes sense, but it does not catch processes forking a lot of
> > childs, because the allocation rate is not accounted to the parent.
> 
> Not sure, the child could easily inherit the allocation rate of the parent.
> So if the fork bomb spreads the last leaf in the process tree would
> easily get accounted for every kernel stack/fds/etc.. and userspace
> allocation done from its previous parents too.

I think the current solution is just fine. I tested it thoroughly with
different scenarios and was not able to break it. The ugly time, count
hacks are gone and I have the impression that it tries harder to swap
out stuff now. I also tested with swap off and it works without hassle.
There may be some remaining "surprise" hidden in the selection, but I'm
not sure if it is worth the time to optimize it further or even rewrite
it with some other builtin surprises.

tglx



--=-uCMt3C7S3aWrmGiOC1eH
Content-Disposition: attachment; filename=oom-select.diff
Content-Type: text/x-patch; name=oom-select.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -urN 2.6.10-rc2.orig/mm/oom_kill.c 2.6.10-rc2.oom/mm/oom_kill.c
--- 2.6.10-rc2.orig/mm/oom_kill.c	2004-12-05 16:36:12.000000000 +0100
+++ 2.6.10-rc2.oom/mm/oom_kill.c	2004-12-05 16:46:42.000000000 +0100
@@ -45,6 +45,7 @@
 static unsigned long badness(struct task_struct *p, unsigned long uptime)
 {
 	unsigned long points, cpu_time, run_time, s;
+	struct list_head *tsk;
 
 	if (!p->mm)
 		return 0;
@@ -55,6 +56,19 @@
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
@@ -206,6 +220,23 @@
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
@@ -236,7 +267,7 @@
 
 	printk("oom-killer: gfp_mask=0x%x\n", gfp_mask);
 	show_free_areas();
-	mm = oom_kill_task(p);
+	mm = oom_kill_process(p);
 	if (!mm)
 		goto retry;
 
diff -urN 2.6.10-rc2.orig/mm/page_alloc.c 2.6.10-rc2.oom/mm/page_alloc.c
--- 2.6.10-rc2.orig/mm/page_alloc.c	2004-12-05 16:36:12.000000000 +0100
+++ 2.6.10-rc2.oom/mm/page_alloc.c	2004-12-05 16:42:38.000000000 +0100
@@ -613,9 +613,8 @@
 	int can_try_harder;
 	int did_some_progress;
 
-	if (wait)
-		cond_resched();
-
+	might_sleep_if(wait);
+	
 	/*
 	 * The caller may dip into page reserves a bit more if the caller
 	 * cannot run direct reclaim, or is the caller has realtime scheduling

--=-uCMt3C7S3aWrmGiOC1eH--

