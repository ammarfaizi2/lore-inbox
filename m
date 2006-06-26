Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWFZQUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWFZQUm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWFZQUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:20:42 -0400
Received: from ns2.suse.de ([195.135.220.15]:35248 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750750AbWFZQUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:20:41 -0400
Date: Mon, 26 Jun 2006 18:20:38 +0200
From: Nick Piggin <npiggin@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>, "David S. Peterson" <dsp@llnl.gov>,
       Paul Jackson <pj@sgi.com>
Subject: [rfc][patch] fixes for several oom killer problems
Message-ID: <20060626162038.GB7573@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We have reports of OOM killer panicing the system even if there are
tasks currently exiting and/or plenty able to be freed.

The main problem is the cpuset_excl_nodes_overlap causing an immediate
panic if current is exiting; I haven't got confirmation of whether
or not a minimal patch for that is effective.

The minimal patch basically involved ripping out the test completely.
I'd rather something more comprehensive in mainline, and I spotted
several other issues as well.

---

Fix several OOM killer problems.

Big ones:
- cpuset_excl_nodes_overlap always returns 0 if current is exiting. This
  caused customer's systems to panic in the OOM killer when processes were
  having trouble getting memory for the final put_user in mm_release. Even
  though there were lots of processes to kill. Fix this by just causing
  cpuset_excl_nodes_overlap to reduce the badness rather than disallow it
  (it may still be pinning memory somehow on this node or that this task
  may use).

- If current *is* exiting, it should actually be allowed to access reserved
  memory rather than OOM kill something else. Can't do this via a straight
  check in page_alloc.c because that would allow multiple tasks to use up
  reserves. Instead cause current to wind up marking itself as TIF_MEMDIE.

- In cpuset_excl_nodes_overlap, return 1 for PF_EXITING tasks. This retains
  parity with !CONFIG_CPUSETS case.

Little ones:
- PF_SWAPOFF processes cause select_bad_process to return straight away.
  Instead, give them high priority and ensure no parallel OOM kills are
  happening at the same time.

- cpuset_exlc_nodes_overlap may still free up some memory we're allowed to
  use. Kernel allocated memory, memory touched first by other processes or
  when we were in a different group. Cause this just to minimise the
  badness of a process.

- Skip kernel threads, rather than having them return 0 from badness.
  Theoretically, badness might truncate all results to 0, thus a kernel
  thread might be picked first, causing an infinite loop.

- Skip PF_DEAD tasks, for similar reasons.

- Print the name of the task that invoked the OOM killer. Could make
  debugging easier.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/oom_kill.c
===================================================================
--- linux-2.6.orig/mm/oom_kill.c
+++ linux-2.6/mm/oom_kill.c
@@ -57,6 +57,12 @@ unsigned long badness(struct task_struct
 	}
 
 	/*
+	 * swapoff can easily use up all memory, so kill those first.
+	 */
+	if (p->flags & PF_SWAPOFF)
+		return ULONG_MAX;
+
+	/*
 	 * The memory size of the process is the basis for the badness.
 	 */
 	points = mm->total_vm;
@@ -125,6 +131,15 @@ unsigned long badness(struct task_struct
 	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO))
 		points /= 4;
 
+
+	/*
+	 * If p's nodes don't overlap ours, it may still help to kill p
+	 * because p may have allocated or otherwise mapped memory on
+	 * this node before. However it will be less likely.
+	 */
+	if (!cpuset_excl_nodes_overlap(p))
+		points /= 4;
+
 	/*
 	 * Adjust the score by oomkilladj.
 	 */
@@ -190,25 +205,35 @@ static struct task_struct *select_bad_pr
 		unsigned long points;
 		int releasing;
 
+		/* skip kernel threads */
+		if (!p->mm)
+			continue;
 		/* skip the init task with pid == 1 */
 		if (p->pid == 1)
 			continue;
-		if (p->oomkilladj == OOM_DISABLE)
-			continue;
-		/* If p's nodes don't overlap ours, it won't help to kill p. */
-		if (!cpuset_excl_nodes_overlap(p))
-			continue;
 
 		/*
 		 * This is in the process of releasing memory so for wait it
 		 * to finish before killing some other task by mistake.
+		 *
+		 * However, if p is the current task, we allow the 'kill' to
+		 * go ahead if it is exiting: this will simply set TIF_MEMDIE,
+		 * which will allow it to gain access to memory reserves in
+		 * the process of exiting and releasing its resources.
 		 */
 		releasing = test_tsk_thread_flag(p, TIF_MEMDIE) ||
 						p->flags & PF_EXITING;
-		if (releasing && !(p->flags & PF_DEAD))
+		if (releasing) {
+			/* PF_DEAD tasks have already released their mm */
+			if (p->flags & PF_DEAD)
+				continue;
+			if (p == current) {
+				chosen = p;
+				*ppoints = ULONG_MAX;
+				continue;
+			}
 			return ERR_PTR(-1UL);
-		if (p->flags & PF_SWAPOFF)
-			return p;
+		}
 
 		points = badness(p, uptime.tv_sec);
 		if (points > *ppoints || !chosen) {
@@ -216,6 +241,7 @@ static struct task_struct *select_bad_pr
 			*ppoints = points;
 		}
 	} while_each_thread(g, p);
+
 	return chosen;
 }
 
@@ -319,8 +345,8 @@ void out_of_memory(struct zonelist *zone
 	unsigned long points = 0;
 
 	if (printk_ratelimit()) {
-		printk("oom-killer: gfp_mask=0x%x, order=%d\n",
-			gfp_mask, order);
+		printk(KERN_WARNING "%s invoked oom-killer: "
+			"gfp_mask=0x%x, order=%d, oomkilladj=%d\n", current->comm, gfp_mask, order, current->oomkilladj);
 		dump_stack();
 		show_mem();
 	}
Index: linux-2.6/kernel/cpuset.c
===================================================================
--- linux-2.6.orig/kernel/cpuset.c
+++ linux-2.6/kernel/cpuset.c
@@ -2362,7 +2362,7 @@ EXPORT_SYMBOL_GPL(cpuset_mem_spread_node
 int cpuset_excl_nodes_overlap(const struct task_struct *p)
 {
 	const struct cpuset *cs1, *cs2;	/* my and p's cpuset ancestors */
-	int overlap = 0;		/* do cpusets overlap? */
+	int overlap = 1;		/* do cpusets overlap? */
 
 	task_lock(current);
 	if (current->flags & PF_EXITING) {
