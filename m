Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbUKSQbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbUKSQbZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 11:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbUKSQbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 11:31:25 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:27307
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261467AbUKSQ0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 11:26:02 -0500
Subject: Re: [PATCH] fix spurious OOM kills
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Martin MOKREJ__ <mmokrejs@ribosome.natur.cuni.cz>,
       piggin@cyberone.com.au, chris@tebibyte.org, andrea@novell.com,
       LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Rik van Riel <riel@redhat.com>
In-Reply-To: <20041119080946.GA30845@logos.cnet>
References: <20041114202155.GB2764@logos.cnet> <419A2B3A.80702@tebibyte.org>
	 <419B14F9.7080204@tebibyte.org> <20041117012346.5bfdf7bc.akpm@osdl.org>
	 <419CD8C1.4030506@ribosome.natur.cuni.cz>
	 <20041118131655.6782108e.akpm@osdl.org>
	 <419D25B5.1060504@ribosome.natur.cuni.cz>
	 <419D2987.8010305@cyberone.com.au>
	 <419D383D.4000901@ribosome.natur.cuni.cz>
	 <20041118160824.3bfc961c.akpm@osdl.org> <20041119080946.GA30845@logos.cnet>
Content-Type: multipart/mixed; boundary="=-6BtNG+0wWdYTYeYfVJKf"
Organization: linutronix
Date: Fri, 19 Nov 2004 17:17:22 +0100
Message-Id: <1100881042.2635.140.camel@thomas>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6BtNG+0wWdYTYeYfVJKf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2004-11-19 at 06:09 -0200, Marcelo Tosatti wrote:
> As Thomas Gleixner has investigated, the OOM killer selection is problematic.
> 
> When testing your ignore-page-referenced patch it first killed the memory hog
> then shortly afterwards the shell I was running it on.
> 
> You've seen Thomas emails, he has nice description there.

I had another go on 2.6.10-rc2-mm2. 

The reentrancy blocking and the additional test of freepages in
out_of_memory() make all the ugly time and counter checks superfluid. 

I think they were neccecary to make the spurious kill triggering less
obvious. :)

Can somebody else check with his test cases, if the behaviour is
correct ?

tglx



--=-6BtNG+0wWdYTYeYfVJKf
Content-Disposition: attachment; filename=2.6.10-rc2-mm2-oom.diff
Content-Type: text/x-patch; name=2.6.10-rc2-mm2-oom.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

diff -urN 2.6.10-rc2-mm2.orig/mm/oom_kill.c 2.6.10-rc2-mm2/mm/oom_kill.c
--- 2.6.10-rc2-mm2.orig/mm/oom_kill.c	2004-11-19 14:52:16.000000000 +0100
+++ 2.6.10-rc2-mm2/mm/oom_kill.c	2004-11-19 17:12:40.000000000 +0100
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
 
@@ -224,59 +266,23 @@
 void out_of_memory(int gfp_mask)
 {
 	/*
-	 * oom_lock protects out_of_memory()'s static variables.
-	 * It's a global lock; this is not performance-critical.
-	 */
-	static DEFINE_SPINLOCK(oom_lock);
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
+ 	 * inprogress protects out_of_memory()'s static variables
+	 * and prevents reentrancy
+  	 */
+ 	static unsigned long inprogress;
+ 	static unsigned int  freepages = 1000000;
+
+ 	if (test_and_set_bit(0, &inprogress))
+ 		return;
+ 	
+ 	/* Check, if memory was freed since the last oom kill */
+ 	if (freepages < nr_free_pages())
+ 		goto out_unlock;
 
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
@@ -284,17 +290,7 @@
 	 * for more memory.
 	 */
 	yield();
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
+	
 out_unlock:
-	spin_unlock(&oom_lock);
+	clear_bit(0, &inprogress);
 }

--=-6BtNG+0wWdYTYeYfVJKf--

