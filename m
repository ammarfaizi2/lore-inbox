Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266315AbTGELC6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 07:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266319AbTGELC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 07:02:58 -0400
Received: from holomorphy.com ([66.224.33.161]:23689 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S266315AbTGELCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 07:02:55 -0400
Date: Sat, 5 Jul 2003 04:18:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Anton Blanchard <anton@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.74-mm1
Message-ID: <20030705111844.GL955@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030703023714.55d13934.akpm@osdl.org> <20030704210737.GI955@holomorphy.com> <20030704181539.2be0762a.akpm@osdl.org> <20030705052102.GB13308@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030705052102.GB13308@krispykreme>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, akpm wrote:
>> Look at select_bad_process(), and the ->mm test in badness().  pdflush
>> can never be chosen.
>> Nevertheless, there have been several report where kernel threads _are_ 
>> being hit my the oom killer.  Any idea why that is?

On Sat, Jul 05, 2003 at 03:21:02PM +1000, Anton Blanchard wrote:
> Milton and I were just looking at this and it seems there is no locking
> to prevent p->mm ending up NULL due to exit. And if p->mm does end up
> NULL, you go off and kill all your kernel threads :)

How about this, then? I think it's still racy against something doing
daemonize(), though (i.e. if q does daemonize() it shoots it regardless).


===== mm/oom_kill.c 1.23 vs edited =====
--- 1.23/mm/oom_kill.c	Wed Apr 23 03:15:53 2003
+++ edited/mm/oom_kill.c	Sat Jul  5 04:15:25 2003
@@ -123,7 +123,7 @@
 	struct task_struct *chosen = NULL;
 
 	do_each_thread(g, p)
-		if (p->pid) {
+		if (p->pid && p->mm) {
 			int points = badness(p);
 			if (points > maxpoints) {
 				chosen = p;
@@ -141,7 +141,7 @@
  * CAP_SYS_RAW_IO set, send SIGTERM instead (but it's unlikely that
  * we select a process with CAP_SYS_RAW_IO set).
  */
-void oom_kill_task(struct task_struct *p)
+static void __oom_kill_task(task_t *p)
 {
 	printk(KERN_ERR "Out of Memory: Killed process %d (%s).\n", p->pid, p->comm);
 
@@ -161,6 +161,15 @@
 	}
 }
 
+static struct mm_struct *oom_kill_task(task_t *p)
+{
+	struct mm_struct *mm = get_task_mm(p);
+	if (!mm || mm == &init_mm)
+		return NULL;
+	__oom_kill_task(p);
+}
+
+
 /**
  * oom_kill - kill the "best" process when we run out of memory
  *
@@ -171,9 +180,11 @@
  */
 static void oom_kill(void)
 {
+	struct mm_struct *mm;
 	struct task_struct *g, *p, *q;
 	
 	read_lock(&tasklist_lock);
+retry:
 	p = select_bad_process();
 
 	/* Found nothing?!?! Either we hang forever, or we panic. */
@@ -182,17 +193,20 @@
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
 
 	read_unlock(&tasklist_lock);
+	mmput(mm);
 
 	/*
 	 * Make kswapd go out of the way, so "p" has a good chance of
