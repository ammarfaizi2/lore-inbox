Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbULBNvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbULBNvY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 08:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbULBNvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 08:51:24 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:11648
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261623AbULBNuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 08:50:23 -0500
Subject: Re: [PATCH] oom killer (Core)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       LKML <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <1101985759.13353.102.camel@tglx.tec.linutronix.de>
References: <20041201104820.1.patchmail@tglx>
	 <20041201211638.GB4530@dualathlon.random>
	 <1101938767.13353.62.camel@tglx.tec.linutronix.de>
	 <20041202033619.GA32635@dualathlon.random>
	 <1101985759.13353.102.camel@tglx.tec.linutronix.de>
Content-Type: multipart/mixed; boundary="=-3f1+9MS+IK0l/xTrgtF9"
Date: Thu, 02 Dec 2004 14:48:00 +0100
Message-Id: <1101995280.13353.124.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3f1+9MS+IK0l/xTrgtF9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2004-12-02 at 12:09 +0100, Thomas Gleixner wrote:
> I agree, that the timed hack stuff in out_of_memory is ugly, but we need
> some mechanism to avoid 
> 
> 	1. reentrancy into oom_kill
> 	2. invocation of oom_kill until the already killed process
> 	   has finally released memory.
> 
> Further we need a better selection of whom to kill. 

Attached patch solves this problems more elegant than the previous
attempts and removes the ugly time, count, threshold stuff.

Reentrancy and follow up calls of oom_kill() are blocked until the task
which was killed by the first oom_kill() has actually released the
resources. I added a callback which is called from do_exit() when the
PF_MEMDIE flag is set. The reentrancy blocking is released inside the
callback.

The whom to select modification is still neccecary to prevent that
innocent processes are killed.

It now kills exactly one process and comes back to the terminal without
further damages. Also other scenarios which I used to test the oom-
killer are not showing any strange side effects.

>From the first call to out_of_memory, which activates the reentrancy
blocking until the blocking is released in the callback, out_of_memory
is called more than 300 times.

Interesting is that the patch applied to the current code in 2.6.10-rc2-
mm4, where the call to out_of_memory is still in vmscan.c, has the same
effect. 

So it's up to you VM guys to fight out from which place you want call
out_of_memory(). I don't care as both places have exactly the same bad
side effects.

My concern is to make it reliable when it is finally invoked.

tglx


--=-3f1+9MS+IK0l/xTrgtF9
Content-Disposition: attachment; filename=2.6.10-rc2.oom.diff
Content-Type: text/x-patch; name=2.6.10-rc2.oom.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -urN 2.6.10-rc2.orig/include/linux/swap.h 2.6.10-rc2.oom/include/linux/swap.h
--- 2.6.10-rc2.orig/include/linux/swap.h	2004-12-02 13:45:55.000000000 +0100
+++ 2.6.10-rc2.oom/include/linux/swap.h	2004-12-02 14:13:16.000000000 +0100
@@ -149,6 +149,7 @@
 
 /* linux/mm/oom_kill.c */
 extern void out_of_memory(int gfp_mask);
+extern void oom_task_killed(void);
 
 /* linux/mm/memory.c */
 extern void swapin_readahead(swp_entry_t, unsigned long, struct vm_area_struct *);
diff -urN 2.6.10-rc2.orig/kernel/exit.c 2.6.10-rc2.oom/kernel/exit.c
--- 2.6.10-rc2.orig/kernel/exit.c	2004-12-02 13:45:55.000000000 +0100
+++ 2.6.10-rc2.oom/kernel/exit.c	2004-12-02 12:13:50.000000000 +0100
@@ -820,6 +820,9 @@
 	exit_thread();
 	exit_keys(tsk);
 
+	if (current->flags & PF_MEMDIE)
+		oom_task_killed();
+
 	if (group_dead && tsk->signal->leader)
 		disassociate_ctty(1);
 
diff -urN 2.6.10-rc2.orig/mm/oom_kill.c 2.6.10-rc2.oom/mm/oom_kill.c
--- 2.6.10-rc2.orig/mm/oom_kill.c	2004-12-02 13:45:55.000000000 +0100
+++ 2.6.10-rc2.oom/mm/oom_kill.c	2004-12-02 14:22:21.000000000 +0100
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
@@ -175,6 +190,27 @@
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
@@ -184,10 +220,11 @@
  * OR try to be smart about which process to kill. Note that we
  * don't have to be perfect here, we just have to be good.
  */
-static void oom_kill(void)
+void oom_kill(void)
 {
 	struct mm_struct *mm;
-	struct task_struct *g, *p, *q;
+	struct task_struct *c, *p;
+	struct list_head *tsk;
 	
 	read_lock(&tasklist_lock);
 retry:
@@ -199,102 +236,57 @@
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
-	read_unlock(&tasklist_lock);
-	mmput(mm);
+	list_for_each(tsk, &p->children) {
+		c = list_entry(tsk, struct task_struct, sibling);
+		/* Do not touch threads, as they get killed later */
+		if (c->mm == p->mm)
+			continue;
+		mm = oom_kill_process(c);
+		if (mm) {
+			mmput(mm);
+			goto out;
+		}
+	}
 
 	/*
-	 * Make kswapd go out of the way, so "p" has a good chance of
-	 * killing itself before someone else gets the chance to ask
-	 * for more memory.
+	 * If we managed to kill one or more child processes
+	 * then let the parent live for now
 	 */
-	yield();
+	mm = oom_kill_process(p);
+	if (!mm)
+		goto retry;
+	mmput(mm);
+out:
+	read_unlock(&tasklist_lock);
 	return;
 }
 
+static unsigned long kill_inprogress;
+
 /**
  * out_of_memory - is the system out of memory?
  */
 void out_of_memory(int gfp_mask)
 {
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
+ 	if (test_and_set_bit(0, &kill_inprogress))
+ 		return;
+		
 	printk("oom-killer: gfp_mask=0x%x\n", gfp_mask);
 	show_free_areas();
-
-	/* oom_kill() sleeps */
-	spin_unlock(&oom_lock);
+	dump_stack();
 	oom_kill();
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
 }
+
+/**
+ * oom_task_killed - the killed task has released the resources
+ *
+ * So we actually have freed memory. Now it's safe to reenable
+ * the oom killer.
+ */
+void oom_task_killed(void)
+{
+	clear_bit(0, &kill_inprogress);
+} 

--=-3f1+9MS+IK0l/xTrgtF9--

