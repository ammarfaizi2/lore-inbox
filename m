Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbTLNW33 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 17:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbTLNW33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 17:29:29 -0500
Received: from mx2.elte.hu ([157.181.151.9]:40668 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262730AbTLNW31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 17:29:27 -0500
Date: Sun, 14 Dec 2003 23:28:47 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Roland McGrath <roland@redhat.com>
Subject: Re: [patch] Re: Problem with exiting threads under NPTL
In-Reply-To: <Pine.LNX.4.58.0312141353220.1586@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0312142324250.15172@earth>
References: <20031214052516.GA313@vana.vc.cvut.cz> <Pine.LNX.4.58.0312142032310.9900@earth>
 <Pine.LNX.4.58.0312141228170.1478@home.osdl.org> <Pine.LNX.4.58.0312142205050.13533@earth>
 <Pine.LNX.4.58.0312141353220.1586@home.osdl.org>
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


here's yet another variant of the patch. Changes relative to yours:

- it sets zap_leader to 0 outside the critical section.

- it doesnt set leader to TASK_DEAD, exit_signal == -1 should really 
  protect it from sys_wait4() i believe.

- it sets 'p = leader' within the unlikely branch - slightly faster common
  case.

the patch testbooted fine here.

	Ingo

--- linux/kernel/exit.c.orig	
+++ linux/kernel/exit.c	
@@ -50,8 +50,11 @@ static void __unhash_process(struct task
 void release_task(struct task_struct * p)
 {
 	task_t *leader;
+	int zap_leader;
 	struct dentry *proc_dentry;
- 
+
+repeat:
+	zap_leader = 0;
 	BUG_ON(p->state < TASK_ZOMBIE);
  
 	atomic_dec(&p->user->processes);
@@ -72,8 +75,16 @@ void release_task(struct task_struct * p
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
+		 */
+		if (leader->exit_signal == -1)
+			zap_leader = 1;
+	}
 
 	p->parent->cutime += p->utime + p->cutime;
 	p->parent->cstime += p->stime + p->cstime;
@@ -88,6 +99,16 @@ void release_task(struct task_struct * p
 	proc_pid_flush(proc_dentry);
 	release_thread(p);
 	put_task_struct(p);
+
+	/*
+	 * Do this outside the tasklist lock. The reference to the
+	 * leader is safe. There's no recursion possible, since
+	 * the leader of the leader is itself:
+	 */
+	if (unlikely(zap_leader)) {
+		p = leader;
+		goto repeat;
+	}
 }
 
 /* we are using it only for SMP init */
