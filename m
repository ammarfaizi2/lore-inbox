Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbUJaMmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUJaMmb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 07:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbUJaMma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 07:42:30 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:45991
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261605AbUJaMlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 07:41:21 -0500
Subject: Re: Mem issues in 2.6.9 (ever since 2.6.9-rc3) and possible cause
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Chris Ross <chris@tebibyte.org>, Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Rik van Riel <riel@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
       kernel@kolivas.org
In-Reply-To: <1099132966.22115.89.camel@thomas>
References: <Pine.LNX.4.44.0410251823230.21539-100000@chimarrao.boston.redhat.com>
	 <Pine.LNX.4.44.0410251833210.21539-100000@chimarrao.boston.redhat.com>
	 <20041028120650.GD5741@logos.cnet> <41824760.7010703@tebibyte.org>
	 <41834FE7.5060705@jp.fujitsu.com> <418354C0.3060207@tebibyte.org>
	 <418357C5.4070304@jp.fujitsu.com> <41835F4D.2060508@tebibyte.org>
	 <4183649C.7070601@jp.fujitsu.com>  <1099132966.22115.89.camel@thomas>
Content-Type: multipart/mixed; boundary="=-PoJO2ITiFZgSAuArIdN2"
Organization: linutronix
Date: Sun, 31 Oct 2004 13:33:03 +0100
Message-Id: <1099225984.6067.5.camel@thomas>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PoJO2ITiFZgSAuArIdN2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> But it still does not fix the random madness of oom-killer. Once it is
> triggered it keeps going even if there is 50MB free memory available.
> 

Additionally to Rik's and Kame's fixes, I changed the criterias in
oom_kill a bit to

- take processes which fork a lot of children into account instead of
killing stuff like portmap and sshd just because they haven't used a lot
of CPU time since they started.

- prevent oom-killer to continue to kill processes, even if memory is
available

I was facing the above problems on a small embedded system, where a
forking server started to flood the machine with child processes.
oom-killer killed portmap and sshd instead of the real culprit and took
away the opportunity to log into the machine remotely.

The problem can be simulated with hackbench on a small UP system.

I don't know, if these changes have any negative impacts on the
testcases which were used in the original design. Rik ??

tglx




--=-PoJO2ITiFZgSAuArIdN2
Content-Disposition: attachment; filename=oom_kill.c.diff
Content-Type: text/x-patch; name=oom_kill.c.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

--- 2.6.10-rc1-mm2.orig/mm/oom_kill.c	2004-10-31 11:13:32.000000000 +0100
+++ 2.6.10-rc1-mm2/mm/oom_kill.c	2004-10-31 13:00:06.000000000 +0100
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
@@ -200,21 +238,25 @@
 		panic("Out of memory and no killable processes...\n");
 	}
 
-	mm = oom_kill_task(p);
-	if (!mm)
-		goto retry;
 	/*
-	 * kill all processes that share the ->mm (i.e. all threads),
-	 * but are in a different thread group
+	 * Kill the child processes first
 	 */
-	do_each_thread(g, q)
-		if (q->mm == mm && q->tgid != p->tgid)
-			__oom_kill_task(q);
-	while_each_thread(g, q);
-	if (!p->mm)
-		printk(KERN_INFO "Fixed up OOM kill of mm-less task\n");
+	list_for_each(tsk, &p->children) {
+		c = list_entry(tsk, struct task_struct, sibling);
+		if (c->mm == p->mm)
+			continue;
+		mm = oom_kill_process(c);
+		if (mm) {
+			mmcnt ++;
+			mmput(mm);
+		}
+	}
+	mm = oom_kill_process(p);
+	if (!mmcnt && !mm)
+		goto retry;
+	if (mm)
+		mmput(mm);
 	read_unlock(&tasklist_lock);
-	mmput(mm);
 	return;
 }
 
@@ -224,14 +266,22 @@
 void out_of_memory(int gfp_mask)
 {
 	/*
-	 * oom_lock protects out_of_memory()'s static variables.
-	 * It's a global lock; this is not performance-critical.
+	 * inprogress protects out_of_memory()'s static variables.
+	 * We don't use a spin_lock here, as spinlocks are
+	 * nops on UP systems.
 	 */
-	static spinlock_t oom_lock = SPIN_LOCK_UNLOCKED;
+	static unsigned long inprogress;
 	static unsigned long first, last, count, lastkill;
+	static unsigned int  freepages = 1000000;
 	unsigned long now, since;
 
-	spin_lock(&oom_lock);
+	if (test_and_set_bit(0, &inprogress))
+		return;
+	
+	/* Check, if memory was freed since the last oom kill */
+	if (freepages < nr_free_pages())
+		goto out_unlock;
+
 	now = jiffies;
 	since = now - last;
 	last = now;
@@ -274,9 +324,8 @@
 
 	printk("oom-killer: gfp_mask=0x%x\n", gfp_mask);
 	show_free_areas();
-
-	/* oom_kill() sleeps */
-	spin_unlock(&oom_lock);
+	/* Store free pages  * 2 for the check above */
+	freepages = (nr_free_pages() << 1);
 	oom_kill();
 	/*
 	 * Make kswapd go out of the way, so "p" has a good chance of
@@ -284,7 +333,6 @@
 	 * for more memory.
 	 */
 	yield();
-	spin_lock(&oom_lock);
 
 reset:
 	/*
@@ -294,7 +342,7 @@
 	if (time_after(now, first))
 		first = now;
 	count = 0;
-
+	
 out_unlock:
-	spin_unlock(&oom_lock);
+	clear_bit(0, &inprogress);
 }

--=-PoJO2ITiFZgSAuArIdN2--

