Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbTLNVDR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 16:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbTLNVDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 16:03:17 -0500
Received: from mx2.elte.hu ([157.181.151.9]:39375 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262558AbTLNVDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 16:03:14 -0500
Date: Sun, 14 Dec 2003 22:02:32 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Roland McGrath <roland@redhat.com>
Subject: Re: [patch] Re: Problem with exiting threads under NPTL
In-Reply-To: <Pine.LNX.4.58.0312141238460.1478@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0312142153400.12198@earth>
References: <20031214052516.GA313@vana.vc.cvut.cz> <Pine.LNX.4.58.0312142032310.9900@earth>
 <Pine.LNX.4.58.0312141228170.1478@home.osdl.org> <Pine.LNX.4.58.0312141238460.1478@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-ELTE-SpamVersion: SpamAssassin ELTE 1.0
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 14 Dec 2003, Linus Torvalds wrote:

> Btw, on another note: to avoid the appearance of recursion, I'd prefer a
> 
> 	p = leader;
> 	goto top;
> 
> instead of a "release_task(leader);".
> 
> I realize that the recursion should be just one deep (the leader of the
> leader is itself, and that will stop the thing from going further), but
> it looks trivial to avoid it, and any automated source checking tool
> would be confused by the apparent recursion.

yeah. New (SMP-testbooted) patch attached. I also got rid of the
zap_leader flag. (we can signal leader-zapping via the leader pointer.)

	Ingo

--- linux/kernel/exit.c.orig	
+++ linux/kernel/exit.c	
@@ -51,7 +51,8 @@ void release_task(struct task_struct * p
 {
 	task_t *leader;
 	struct dentry *proc_dentry;
- 
+
+restart:	
 	BUG_ON(p->state < TASK_ZOMBIE);
  
 	atomic_dec(&p->user->processes);
@@ -72,8 +73,20 @@ void release_task(struct task_struct * p
 	 */
 	leader = p->group_leader;
 	if (leader != p && thread_group_empty(leader) &&
-		    leader->state == TASK_ZOMBIE && leader->exit_signal != -1)
+		    leader->state == TASK_ZOMBIE && leader->exit_signal != -1) {
 		do_notify_parent(leader, leader->exit_signal);
+		/*
+		 * If we were the last child thread and the leader has
+		 * exited already, and the leader's parent ignores SIGCHLD,
+		 * then we are the one who should release the leader.
+		 *
+		 * (non-NULL leader triggers the zapping of the leader at
+		 * the end of this function.)
+		 */
+		if (leader->exit_signal != -1)
+			leader = NULL;
+	} else
+		leader = NULL;
 
 	p->parent->cutime += p->utime + p->cutime;
 	p->parent->cstime += p->stime + p->cstime;
@@ -88,6 +101,16 @@ void release_task(struct task_struct * p
 	proc_pid_flush(proc_dentry);
 	release_thread(p);
 	put_task_struct(p);
+
+	/*
+	 * Do this outside the tasklist lock. The reference to the
+	 * leader is safe. There's no recursion possible, since
+	 * the leader of the leader is itself:
+	 */
+	if (unlikely(leader)) {
+		p = leader;
+		goto restart;
+	}
 }
 
 /* we are using it only for SMP init */
