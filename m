Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265831AbTGEVrp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 17:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266419AbTGEVrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 17:47:45 -0400
Received: from holomorphy.com ([66.224.33.161]:29324 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265831AbTGEVrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 17:47:42 -0400
Date: Sat, 5 Jul 2003 15:03:33 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: anton@samba.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm1
Message-ID: <20030705220333.GB15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, anton@samba.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030703023714.55d13934.akpm@osdl.org> <20030704210737.GI955@holomorphy.com> <20030704181539.2be0762a.akpm@osdl.org> <20030705104433.GK955@holomorphy.com> <20030705114308.6dacb5a2.akpm@osdl.org> <20030705211740.GA15452@holomorphy.com> <20030705142752.37a3566a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030705142752.37a3566a.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> Sorry, that was one hell of an oversight wrt. the initival value.

On Sat, Jul 05, 2003 at 02:27:52PM -0700, Andrew Morton wrote:
> You made me read that code about 20 times ;)
> Still.  Do we think we know what the actual bug is?  That tasklist_lock
> doesn't pin tsk->mm?
> If so then let's get that patch of yours happening, but please enhance it to
> a) detect the situation where the mm went away, and tell us that it was
>    fixed up.  Sufficient to confirm your theory.
> b) put in an explicit check for a kill of an mm-less process.  print a
>    warning, skip the process.

exit_mm() is excluded by the task_lock(), so p->mm (or any of the
others) can vanish at any time (the callers don't hold the tasklist_lock
either). So did you have in mind something like this?


-- wli


===== mm/oom_kill.c 1.23 vs edited =====
--- 1.23/mm/oom_kill.c	Wed Apr 23 03:15:53 2003
+++ edited/mm/oom_kill.c	Sat Jul  5 15:00:15 2003
@@ -141,8 +141,16 @@
  * CAP_SYS_RAW_IO set, send SIGTERM instead (but it's unlikely that
  * we select a process with CAP_SYS_RAW_IO set).
  */
-void oom_kill_task(struct task_struct *p)
+static void __oom_kill_task(task_t *p)
 {
+	task_lock(p);
+	if (!p->mm || p->mm == &init_mm) {
+		WARN_ON(1);
+		printk(KERN_WARNING "tried to kill an mm-less task!\n");
+		task_unlock(p);
+		return;
+	}
+	task_unlock(p);
 	printk(KERN_ERR "Out of Memory: Killed process %d (%s).\n", p->pid, p->comm);
 
 	/*
@@ -161,6 +169,16 @@
 	}
 }
 
+static struct mm_struct *oom_kill_task(task_t *p)
+{
+	struct mm_struct *mm = get_task_mm(p);
+	if (!mm || mm == &init_mm)
+		return NULL;
+	__oom_kill_task(p);
+	return mm;
+}
+
+
 /**
  * oom_kill - kill the "best" process when we run out of memory
  *
@@ -171,9 +189,11 @@
  */
 static void oom_kill(void)
 {
+	struct mm_struct *mm;
 	struct task_struct *g, *p, *q;
 	
 	read_lock(&tasklist_lock);
+retry:
 	p = select_bad_process();
 
 	/* Found nothing?!?! Either we hang forever, or we panic. */
@@ -182,17 +202,21 @@
 		panic("Out of memory and no killable processes...\n");
 	}
 
-	oom_kill_task(p);
+	mm = oom_kill_task(p);
+	if (!mm)
+		goto retry;
 	/*
 	 * kill all processes that share the ->mm (i.e. all threads),
 	 * but are in a different thread group
 	 */
 	do_each_thread(g, q)
-		if (q->mm == p->mm && q->tgid != p->tgid)
-			oom_kill_task(q);
+		if (q->mm == mm && q->tgid != p->tgid)
+			__oom_kill_task(q);
 	while_each_thread(g, q);
-
+	if (!p->mm)
+		printk(KERN_INFO "Fixed up OOM kill of mm-less task\n");
 	read_unlock(&tasklist_lock);
+	mmput(mm);
 
 	/*
 	 * Make kswapd go out of the way, so "p" has a good chance of
