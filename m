Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbTLNXI4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 18:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbTLNXI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 18:08:56 -0500
Received: from mx2.elte.hu ([157.181.151.9]:40929 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262695AbTLNXIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 18:08:52 -0500
Date: Mon, 15 Dec 2003 00:08:27 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Roland McGrath <roland@redhat.com>
Subject: Re: [patch] Re: Problem with exiting threads under NPTL
In-Reply-To: <Pine.LNX.4.58.0312141433520.1481@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0312142358210.16392@earth>
References: <20031214052516.GA313@vana.vc.cvut.cz> <Pine.LNX.4.58.0312142032310.9900@earth>
 <Pine.LNX.4.58.0312141228170.1478@home.osdl.org> <Pine.LNX.4.58.0312142205050.13533@earth>
 <Pine.LNX.4.58.0312141353220.1586@home.osdl.org> <Pine.LNX.4.58.0312142324250.15172@earth>
 <Pine.LNX.4.58.0312141433520.1481@home.osdl.org>
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

> Note that both of these micro-optimizations are equally likely to
> _hurt_.

agreed. Patch without these changes reverted is attached. (this is pretty
close to your last patch.)

just one nit wrt. the first micro-optimization:

> So setting variables earlier tends to actually pessimize code [...]

in this specific case the critical section only sets the variable, and the
lifetime of the variable necessiates a stackslot anyway, on x86. So moving
the initialization outside the lock shouldnt pessimise the generated code,
in fact it could even free up a register, due to the compiler being able
to do:

  movl $1, 0x12(%esp)

due to the clear register spill, instead of using up a register due to the
initialization being too close to the setting to 1.
 
But i agree, due to worse readability alone it is not worth having this
change. And on non-x86 it could even result in a spilled register.

(the nonlinear code at the end of the function was clearly a bad idea.)

	Ingo

--- kernel/exit.c.orig
+++ kernel/exit.c
@@ -50,8 +50,10 @@ static void __unhash_process(struct task
 void release_task(struct task_struct * p)
 {
 	task_t *leader;
+	int zap_leader;
 	struct dentry *proc_dentry;
- 
+
+repeat: 
 	BUG_ON(p->state < TASK_ZOMBIE);
  
 	atomic_dec(&p->user->processes);
@@ -70,10 +72,22 @@ void release_task(struct task_struct * p
 	 * group, and the leader is zombie, then notify the
 	 * group leader's parent process. (if it wants notification.)
 	 */
+	zap_leader = 0;
 	leader = p->group_leader;
-	if (leader != p && thread_group_empty(leader) &&
-		    leader->state == TASK_ZOMBIE && leader->exit_signal != -1)
+	if (leader != p && thread_group_empty(leader) && leader->state == TASK_ZOMBIE) {
+		BUG_ON(leader->exit_signal == -1);
 		do_notify_parent(leader, leader->exit_signal);
+		/*
+		 * If we were the last child thread and the leader has
+		 * exited already, and the leader's parent ignores SIGCHLD,
+		 * then we are the one who should release the leader.
+		 *
+		 * do_notify_parent() will have marked it self-reaping in
+		 * that case.
+		 */
+		if (leader->exit_signal == -1)
+			zap_leader = 1;
+	}
 
 	p->parent->cutime += p->utime + p->cutime;
 	p->parent->cstime += p->stime + p->cstime;
@@ -88,6 +102,15 @@ void release_task(struct task_struct * p
 	proc_pid_flush(proc_dentry);
 	release_thread(p);
 	put_task_struct(p);
+
+	/*
+	 * Do this outside the tasklist lock. The reference to the
+	 * leader is safe. There's no recursion possible, since
+	 * the leader of the leader is itself:
+	 */
+	p = leader;
+	if (zap_leader)
+		goto repeat;
 }
 
 /* we are using it only for SMP init */
