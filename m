Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbTLNTjV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 14:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbTLNTjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 14:39:21 -0500
Received: from mx1.elte.hu ([157.181.1.137]:45799 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262323AbTLNTjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 14:39:19 -0500
Date: Sun, 14 Dec 2003 20:38:30 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@zip.com.au>, Roland McGrath <roland@redhat.com>
Subject: [patch] Re: Problem with exiting threads under NPTL
In-Reply-To: <20031214052516.GA313@vana.vc.cvut.cz>
Message-ID: <Pine.LNX.4.58.0312142032310.9900@earth>
References: <20031214052516.GA313@vana.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-ELTE-SpamVersion: SpamAssassin ELTE 1.0
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=0, required 5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 14 Dec 2003, Petr Vandrovec wrote:

>   several times one of our threads ended up as ZOMBIE and nobody wants
> to pick him up - even init ignores it. Inspection of kernel structures
> revealed that task's exit code is 0, exit_signal is -1, ptrace is 0 and
> state is 8 (ZOMBIE).

ok, we only recently started zapping SIGCHLD==ignore processes via the
detached-thread method. Your testcase shows one hole in this mechanism: if
a process that was created as a 'deatched process' itself creates a
detached thread (NPTL thread), and the thread exits before the thread
group leader, then nobody will release the leader. The patch below fixes
this bug, your testcase now works fine on my box. I've tested both UP and
SMP kernels.

the code is a bit ugly, but it's necessary - a parent can decide _after_
starting the child that it wants to detach it. (by setting SIGCHLD to
SIG_IGN. The testcase doesnt do this.) So the only place where we can
detect the detached-ness of a process is in do_notify_parent().

	Ingo

--- linux/kernel/exit.c.orig	
+++ linux/kernel/exit.c	
@@ -50,6 +50,7 @@ static void __unhash_process(struct task
 void release_task(struct task_struct * p)
 {
 	task_t *leader;
+	int zap_leader = 0;
 	struct dentry *proc_dentry;
  
 	BUG_ON(p->state < TASK_ZOMBIE);
@@ -72,8 +73,16 @@ void release_task(struct task_struct * p
 	 */
 	leader = p->group_leader;
 	if (leader != p && thread_group_empty(leader) &&
-		    leader->state == TASK_ZOMBIE && leader->exit_signal != -1)
+		    leader->state == TASK_ZOMBIE && leader->exit_signal != -1) {
 		do_notify_parent(leader, leader->exit_signal);
+		/*
+		 * If we were the last child thread and the leader has
+		 * exited already, and the leader's parent ignores SIGCHLD,
+		 * then we are the one who should release the leader:
+		 */
+		if (leader->exit_signal == -1)
+			zap_leader = 1;
+	}
 
 	p->parent->cutime += p->utime + p->cutime;
 	p->parent->cstime += p->stime + p->cstime;
@@ -88,6 +97,13 @@ void release_task(struct task_struct * p
 	proc_pid_flush(proc_dentry);
 	release_thread(p);
 	put_task_struct(p);
+
+	/*
+	 * Do this outside the tasklist lock. The reference to the
+	 * leader is safe:
+	 */
+	if (zap_leader)
+		release_task(leader);
 }
 
 /* we are using it only for SMP init */
