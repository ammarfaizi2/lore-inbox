Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262926AbUKTNmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262926AbUKTNmy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 08:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbUKTNlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 08:41:32 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:41899
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262926AbUKTNhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 08:37:50 -0500
Subject: Re: [PATCH] fix spurious OOM kills
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Martin =?iso-8859-2?Q?MOKREJ=A9?= 
	<mmokrejs@ribosome.natur.cuni.cz>
Cc: Andrew Morton <akpm@osdl.org>, piggin@cyberone.com.au, chris@tebibyte.org,
       marcelo.tosatti@cyclades.com, andrea@novell.com,
       LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Rik van Riel <riel@redhat.com>
In-Reply-To: <419F2AB4.30401@ribosome.natur.cuni.cz>
References: <20041111112922.GA15948@logos.cnet>
	 <4193E056.6070100@tebibyte.org>	<4194EA45.90800@tebibyte.org>
	 <20041113233740.GA4121@x30.random>	<20041114094417.GC29267@logos.cnet>
	 <20041114170339.GB13733@dualathlon.random>
	 <20041114202155.GB2764@logos.cnet>	<419A2B3A.80702@tebibyte.org>
	 <419B14F9.7080204@tebibyte.org>	<20041117012346.5bfdf7bc.akpm@osdl.org>
	 <419CD8C1.4030506@ribosome.natur.cuni.cz>
	 <20041118131655.6782108e.akpm@osdl.org>
	 <419D25B5.1060504@ribosome.natur.cuni.cz>
	 <419D2987.8010305@cyberone.com.au>
	 <419D383D.4000901@ribosome.natur.cuni.cz>
	 <20041118160824.3bfc961c.akpm@osdl.org>
	 <419E821F.7010601@ribosome.natur.cuni.cz>
	 <1100946207.2635.202.camel@thomas>  <419F2AB4.30401@ribosome.natur.cuni.cz>
Content-Type: multipart/mixed; boundary="=-9Ax1/FnRvQWNpEt5V00L"
Organization: linutronix
Date: Sat, 20 Nov 2004 14:29:09 +0100
Message-Id: <1100957349.2635.213.camel@thomas>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9Ax1/FnRvQWNpEt5V00L
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit

On Sat, 2004-11-20 at 12:29 +0100, Martin MOKREJ© wrote:
> > Can you please try 2.6.10-rc2-mm2 + the patch I posted yesterday night ?
> > It will still kill RNAsubopt, but it should not longer touch the xterm,
> > which runs vmstat.
> 
> No, it doesn't help at all! See attached file.

Strange. I have no idea what's going on there.  

> oom-killer: gfp_mask=0xd2
> Free pages:        3916kB (112kB HighMem)
> Out of Memory: Killed process 6612 (RNAsubopt).
> Out of Memory: Killed process 6603 (bash).

This one is expected, but the next one is complete nonsense. After
killing RNAsubopt and bash the number of free pages must be greater than
before. 

> oom-killer: gfp_mask=0x1d2
> Free pages:        3916kB (112kB HighMem)
> Out of Memory: Killed process 6598 (FvwmPager).
> Out of Memory: Killed process 6599 (xterm).
> Out of Memory: Killed process 6606 (xterm).
> Out of Memory: Killed process 6564 (fvwm2).

Damn, removing the timer/counter stuff in there was not the brightest
idea. The process needs some time to be recycled.

I moved the ugly timer counter check back in. Could you please try
again ?

It should only kill RNAsubopt and bash and touch nothing else.

tglx


--=-9Ax1/FnRvQWNpEt5V00L
Content-Disposition: attachment; filename=2.6.10-rc2-mm2-oom2.diff
Content-Type: text/x-patch; name=2.6.10-rc2-mm2-oom2.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

diff -urN 2.6.10-rc2-mm2.orig/mm/oom_kill.c 2.6.10-rc2-mm2/mm/oom_kill.c
--- 2.6.10-rc2-mm2.orig/mm/oom_kill.c	2004-11-19 14:52:16.000000000 +0100
+++ 2.6.10-rc2-mm2/mm/oom_kill.c	2004-11-20 14:21:49.000000000 +0100
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
-	 */
-	static DEFINE_SPINLOCK(oom_lock);
+ 	 * inprogress protects out_of_memory()'s static variables.
+ 	 * We don't use a spin_lock here, as spinlocks are
+ 	 * nops on UP systems.
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
@@ -271,12 +321,10 @@
 	 * Ok, really out of memory. Kill something.
 	 */
 	lastkill = now;
-
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
@@ -284,7 +332,6 @@
 	 * for more memory.
 	 */
 	yield();
-	spin_lock(&oom_lock);
 
 reset:
 	/*
@@ -294,7 +341,7 @@
 	if (time_after(now, first))
 		first = now;
 	count = 0;
-
+	
 out_unlock:
-	spin_unlock(&oom_lock);
+	clear_bit(0, &inprogress);
 }

--=-9Ax1/FnRvQWNpEt5V00L--

