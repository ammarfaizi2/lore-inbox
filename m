Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265446AbUFXPSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265446AbUFXPSo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 11:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265483AbUFXPSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 11:18:44 -0400
Received: from holomorphy.com ([207.189.100.168]:18826 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265446AbUFXPSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 11:18:38 -0400
Date: Thu, 24 Jun 2004 08:18:33 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [oom]: [0/4] fix OOM deadlock running OAST
Message-ID: <20040624151833.GA21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <0406231407.HbLbJbXaHbKbWa5aJb1a4aKb0a3aKb1a0a2aMbMbYa3aLbMb3aJbWaJbXaMbLb1a342@holomorphy.com> <20040623151659.70333c6d.akpm@osdl.org> <20040623223146.GG1552@holomorphy.com> <20040623153758.40e3a865.akpm@osdl.org> <20040623230730.GJ1552@holomorphy.com> <20040623163819.013c8585.akpm@osdl.org> <20040624000308.GK1552@holomorphy.com> <20040623171818.39b73d52.akpm@osdl.org> <20040624002651.GL1552@holomorphy.com> <20040624141637.GA20702@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624141637.GA20702@logos.cnet>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 05:26:51PM -0700, William Lee Irwin III wrote:
>> During stress testing at Oracle to determine the maximum number of
>> clients 2.6 can service, it was discovered that the failure mode of
>> excessive numbers of clients was kernel deadlock. The following patch
>> removes the check if (nr_swap_pages > 0) from out_of_memory() as this
>> heuristic fails to detect memory exhaustion due to pinned allocations,
>> directly causing the aforementioned deadlock.

On Thu, Jun 24, 2004 at 11:16:37AM -0300, Marcelo Tosatti wrote:
> Removing the check on v2.4 based kernels will trigger the OOM killer
> too soon for a lot of cases, I'm pretty sure.

Hmm. 2.4 appears to still be lacking some of the fixes (unrelated to
the nr_swap_pages check causing deadlocks) for functional issues.


-- wli

This patch by nature corrects two apparent bugs which are really one
bug. p->mm can become NULL while traversing the tasklist. The two
effects are first that kernel threads appear to be killed. The second
is that the OOM killing process fails to actually shoot down all threads
of the chosen process, and so fails to reclaim the memory it intended to.
oom_kill_task() consists primarily of the expansion of the 2.6 inline
function get_task_mm().

Index: linux-2.4/mm/oom_kill.c
===================================================================
--- linux-2.4.orig/mm/oom_kill.c	2004-06-23 19:30:21.000000000 -0700
+++ linux-2.4/mm/oom_kill.c	2004-06-23 19:52:25.000000000 -0700
@@ -141,7 +141,7 @@
  * CAP_SYS_RAW_IO set, send SIGTERM instead (but it's unlikely that
  * we select a process with CAP_SYS_RAW_IO set).
  */
-void oom_kill_task(struct task_struct *p)
+static void __oom_kill_task(struct task_struct *p)
 {
 	printk(KERN_ERR "Out of Memory: Killed process %d (%s).\n", p->pid, p->comm);
 
@@ -161,6 +161,26 @@
 	}
 }
 
+static struct mm_struct *oom_kill_task(struct task_struct *p)
+{
+	struct mm_struct *mm;
+
+	task_lock(p);
+	mm = p->mm;
+	if (mm) {
+		spin_lock(&mmlist_lock);
+		if (atomic_read(&mm->mm_users))
+			atomic_inc(&mm->mm_users);
+		else
+			mm = NULL;
+		spin_unlock(&mmlist_lock);
+	}
+	task_unlock(p);
+	if (mm)
+		__oom_kill_task(p);
+	return mm;
+}
+
 /**
  * oom_kill - kill the "best" process when we run out of memory
  *
@@ -172,21 +192,27 @@
 static void oom_kill(void)
 {
 	struct task_struct *p, *q;
+	struct mm_struct *mm;
 
+retry:
 	read_lock(&tasklist_lock);
 	p = select_bad_process();
 
 	/* Found nothing?!?! Either we hang forever, or we panic. */
 	if (p == NULL)
 		panic("Out of memory and no killable processes...\n");
-
+	mm = oom_kill_task(p);
+	if (!mm) {
+		read_unlock(&tasklist_lock);
+		goto retry;
+	}
 	/* kill all processes that share the ->mm (i.e. all threads) */
 	for_each_task(q) {
-		if (q->mm == p->mm)
-			oom_kill_task(q);
+		if (q->mm == mm)
+			__oom_kill_task(q);
 	}
 	read_unlock(&tasklist_lock);
-
+	mmput(mm);
 	/*
 	 * Make kswapd go out of the way, so "p" has a good chance of
 	 * killing itself before someone else gets the chance to ask
