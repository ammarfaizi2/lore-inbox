Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262037AbUKVK72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbUKVK72 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 05:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbUKVK55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 05:57:57 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:7340
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262070AbUKVKzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 05:55:22 -0500
Subject: Re: [PATCH] fix spurious OOM kills
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Martin =?iso-8859-2?Q?MOKREJ=A9?= 
	<mmokrejs@ribosome.natur.cuni.cz>
Cc: Andrew Morton <akpm@osdl.org>, piggin@cyberone.com.au, chris@tebibyte.org,
       marcelo.tosatti@cyclades.com, andrea@novell.com,
       LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Rik van Riel <riel@redhat.com>
In-Reply-To: <1101045469.23692.16.camel@thomas>
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
	 <1100946207.2635.202.camel@thomas> <419F2AB4.30401@ribosome.natur.cuni.cz>
	 <1100957349.2635.213.camel@thomas>
	 <419FB4CD.7090601@ribosome.natur.cuni.cz> <1101037999.23692.5.camel@thomas>
	 <41A08765.7030402@ribosome.natur.cuni.cz>
	 <1101045469.23692.16.camel@thomas>
Content-Type: multipart/mixed; boundary="=-dp6F8ObQqRJHWCibYx+h"
Date: Mon, 22 Nov 2004 11:55:21 +0100
Message-Id: <1101120922.19380.17.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dp6F8ObQqRJHWCibYx+h
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Sun, 2004-11-21 at 14:57 +0100, Thomas Gleixner wrote:
> On Sun, 2004-11-21 at 13:17 +0100, Martin MOKREJŠ wrote:
> > Why can't the algorithm first find the asking for memory now.
> > When found, kernel should kill first it's children, wait some time,
> > then kill this process if still exists (it might exit itself when children
> > get closed).
> > You have said it's safer to kill that to send ENOMEM as happens
> > in 2.4, but I still don't undertand why kernel first doesn't send
> > ENOMEM, and only if that doesn't help it can start after those 5 seconds
> > OOM killer, and try to kill the very same application.
> > I don't get the idea why to kill immediately.
> 
> I see your concern. There are some more changes neccecary to make this
> reliably work. I'm not sure if it can be done without really big
> changes. I will look a bit deeper into this.

One big problem when killing the requesting process or just sending
ENOMEM to the requesting process is, that exactly this process might be
a ssh login, when you try to log into to machine after some application
went crazy and ate up most of the memory. The result is that you
_cannot_ log into the machine, because the login is either killed or
cannot start because it receives ENOMEM.

Putting hard coded decisions like "prefer sshd, xyz,...", " don't kill
a, b, c" are out of discussion.
 
The ideas which were proposed to have a possibility to set a "don't kill
me" or "yes, I'm a candidate" flag are likely to be a future way to go.
But at the moment we have no way to make this work in current userlands.

I refined the decision, so it does not longer kill the parent, if there
were forked child processes available to kill. So it now should keep
your bash alive.

tglx


--=-dp6F8ObQqRJHWCibYx+h
Content-Disposition: attachment; filename=2.6.10-rc2-mm-oom3.diff
Content-Type: text/x-patch; name=2.6.10-rc2-mm-oom3.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -urN --exclude='*~' --exclude='.#*' 2.6.10-rc2-mm2.orig/mm/oom_kill.c 2.6.10-rc2-mm/mm/oom_kill.c
--- 2.6.10-rc2-mm2.orig/mm/oom_kill.c	2004-11-19 14:52:16.000000000 +0100
+++ 2.6.10-rc2-mm/mm/oom_kill.c	2004-11-22 11:53:16.000000000 +0100
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
 
@@ -224,14 +273,22 @@
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
@@ -271,12 +328,10 @@
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

--=-dp6F8ObQqRJHWCibYx+h--

