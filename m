Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbUKWK1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbUKWK1r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 05:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbUKWK1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 05:27:47 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:24236
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262130AbUKWK1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 05:27:32 -0500
Subject: Re: [PATCH] fix spurious OOM kills
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Martin =?iso-8859-2?Q?MOKREJ=A9?= 
	<mmokrejs@ribosome.natur.cuni.cz>
Cc: Andrew Morton <akpm@osdl.org>, piggin@cyberone.com.au, chris@tebibyte.org,
       marcelo.tosatti@cyclades.com, andrea@novell.com,
       LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Rik van Riel <riel@redhat.com>
In-Reply-To: <41A2E98E.7090109@ribosome.natur.cuni.cz>
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
	 <1101120922.19380.17.camel@tglx.tec.linutronix.de>
	 <41A2E98E.7090109@ribosome.natur.cuni.cz>
Content-Type: multipart/mixed; boundary="=-8/zwMcl9L+LARAv/YmFZ"
Date: Tue, 23 Nov 2004 11:27:29 +0100
Message-Id: <1101205649.3888.6.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8/zwMcl9L+LARAv/YmFZ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Tue, 2004-11-23 at 08:41 +0100, Martin MOKREJŠ wrote: 
> > One big problem when killing the requesting process or just sending
> > ENOMEM to the requesting process is, that exactly this process might be
> > a ssh login, when you try to log into to machine after some application
> > went crazy and ate up most of the memory. The result is that you
> > _cannot_ log into the machine, because the login is either killed or
> > cannot start because it receives ENOMEM.
> 
> I believe the application is _first_ who will get ENOMEM. It must be
> terrible luck that it would ask exactly for the size of remaining free
> memory. Most probably, it will ask for less or more. "Less" in not
> a problem in this case, so consider it asks for more. Then, OOM killer
> might well expect the application asking for memory is most probably
> exactly the application which caused the trouble.

For one application, which eats up all memory the 2.4 ENOMEM bahviour
works.

The scenario which made one of my boxes unusable under 2.4 is a forking
server, which gets out of control. The last fork gets ENOMEM and does
not happen, but the other forked processes are still there and consuming
memory. The server application does the correct thing. It receives
ENOMEM on fork() and cancels the connection request. On the next request
the game starts again. Somebody notices that the box is not repsonding
anymore and tries to login via ssh. Guess what happens. ssh login cannot
fork due to ENOMEM. The same will happen on 2.6 if we make it behave
like 2.4. 

We have TWO problems in oom handling:

1. When do we trigger the out of memory killer

As far as my test cases go, 2.6.10-rc2-mm3 does not longer trigger the
oom without reason.

2. Which process do we select to kill

The decision is screwed since the oom killer was introduced. Also the
reentrancy problem and some of the mechanisms in the out_of_memory
function have to be modified to make it work.
That's what my patch is addressing.

> > 
> > Putting hard coded decisions like "prefer sshd, xyz,...", " don't kill
> > a, b, c" are out of discussion.
> 
> I'd go for it at least nowadays.

Sure, you can do so on your box, but can you accept, that we _CANNOT_
hard code a list of do not kill apps, except init, into the kernel. I
don't want to see the mail thread on LKML, where the list of precious
application is discussed.

> >  
> > The ideas which were proposed to have a possibility to set a "don't kill
> > me" or "yes, I'm a candidate" flag are likely to be a future way to go.
> > But at the moment we have no way to make this work in current userlands.
> 
> Do you think login or sshd will ever use flag "yes, I'm a candidate"?
> I think exactly same bahaviour we get right now with those hard coded decisions
> you mention above. Otherwise the hard coded decision is programmed into
> every sshd, init instance anyway. I think it's not necessary to put
> login and shells on thsi ban list, user will re-login again. ;)

Having a generic interface to make this configurable is the only way to
go. So users can decide what is important in their environment. There is
more than a desktop PC environment and a lot of embedded boxes need to
protect special applications.

> > 
> > I refined the decision, so it does not longer kill the parent, if there
> > were forked child processes available to kill. So it now should keep
> > your bash alive.
> 
> Yes, it doesn't kill parent bash. I don't understand the _doubled_ output
> in syslog, but maybe you do. Is that related to hyperthreading? ;)
> Tested on 2.6.10-rc2-mm2.

> oom-killer: gfp_mask=0xd2
> Free pages:        3924kB (112kB HighMem)

> oom-killer: gfp_mask=0x1d2
> Free pages:        3924kB (112kB HighMem)

No, it's not related to hyperthreading. It's on the way out. 

I put an additional check into the page allocator. Does this help ?

tglx


--=-8/zwMcl9L+LARAv/YmFZ
Content-Disposition: attachment; filename=2.6.10-rc2-mm3-oom.diff
Content-Type: text/x-patch; name=2.6.10-rc2-mm3-oom.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff --exclude='*~' -urN 2.6.10-rc2-mm3.orig/mm/oom_kill.c 2.6.10-rc2-mm3/mm/oom_kill.c
--- 2.6.10-rc2-mm3.orig/mm/oom_kill.c	2004-11-22 21:48:58.000000000 +0100
+++ 2.6.10-rc2-mm3/mm/oom_kill.c	2004-11-23 10:08:23.000000000 +0100
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
@@ -271,12 +328,11 @@
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
@@ -284,17 +340,11 @@
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
diff --exclude='*~' -urN 2.6.10-rc2-mm3.orig/mm/page_alloc.c 2.6.10-rc2-mm3/mm/page_alloc.c
--- 2.6.10-rc2-mm3.orig/mm/page_alloc.c	2004-11-22 21:48:58.000000000 +0100
+++ 2.6.10-rc2-mm3/mm/page_alloc.c	2004-11-23 10:48:15.000000000 +0100
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

--=-8/zwMcl9L+LARAv/YmFZ--

