Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263850AbUGAEJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbUGAEJE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 00:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbUGAEJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 00:09:04 -0400
Received: from mail-relay-2.tiscali.it ([212.123.84.92]:47825 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S263850AbUGAEIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 00:08:53 -0400
Date: Thu, 1 Jul 2004 06:08:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Roland McGrath <roland@redhat.com>
Cc: Andreas Schwab <schwab@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: zombie with CLONE_THREAD
Message-ID: <20040701040834.GC15086@dualathlon.random>
References: <je8ye5ct75.fsf@sykes.suse.de> <200407010322.i613MPDr016785@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407010322.i613MPDr016785@magilla.sf.frob.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2004 at 08:22:25PM -0700, Roland McGrath wrote:
> The reason strace hangs in that case is an strace bug.  strace is

As I wrote in my first email I suspected it needed a bug in strace to
trigger it (that's what exposes the kernel bug). But I only focused on
the clear kernel bug ;)

> The kernel bug is that when you kill strace, the non-leader zombie hangs
> around and that keeps the zombie leader around too (which is the one
> you'll see in ps).  The following patch fixes that for me.  I am not
> 100% confident that the locking dance required here doesn't create some
> weird issue (and it certainly seems inefficient how many times the lock
> is released and retaken in this sequence), but maybe 92% sure.

this looks much less obvious than my fix. Instead of fixing
TASK_DEAD like I did, you're actually working around the fact the child
didn't go away when exit_notify was called on it. The child is still
there and you now hack and try to release it by hand anyways. it looks
much less obvious and more risky, and it doesn't look the right fix to
me.

My patch sounds much simpler to me, can you tell me what's the point of
leaving ptrace enabled on a task that already executed do_exit? There's
no point IMHO, such a task will never run again ever and the address
space is long gone. So I believe my fix is prefereable, since it simply
make sure that the tasks that needs to be released with TASK_DEAD will
be actually released.

Infact maybe we should just call ptrace_unlink unconditionally there,
and remove it from release_task, but since the code was working fine for
the leader-thread and the normal processes, I only taken care of
releasing the clones (to keep the patch as simple as possible just in
case I was missing something about ptrace making any sense even after
do_exit has been called).

so maybe on the same lines of my yesterday fix, a cleaner approch could
be this. beware, patch completely untested, only to show you the idea.
Again I'm assuming ptrace makes no sense after do_exit, I don't see how
it could.

I believe the real bug is that we let tsk->ptrace mess with
release_task in the TASK_DEAD case with exit_signal == -1, and what I'm
changing make sure that the task is released when it has been set
TASK_DEAD with exit_signal == -1. There is no point that I can see that
would make sense to leave such tsk->ptrace checks there in exit_notify,
when ptrace cannot make a difference anymore.

--- sles/kernel/exit.c.~1~	2004-06-30 01:41:58.000000000 +0200
+++ sles/kernel/exit.c	2004-07-01 06:01:54.197527656 +0200
@@ -71,8 +71,7 @@ repeat: 
 	spin_lock(&p->proc_lock);
 	proc_dentry = proc_pid_unhash(p);
 	write_lock_irq(&tasklist_lock);
-	if (unlikely(p->ptrace))
-		__ptrace_unlink(p);
+	BUG_ON(p->ptrace);
 	BUG_ON(!list_empty(&p->ptrace_list) || !list_empty(&p->ptrace_children));
 	__exit_signal(p);
 	__exit_sighand(p);
@@ -734,8 +733,16 @@ static void exit_notify(struct task_stru
 		do_notify_parent(tsk, SIGCHLD);
 	}
 
+	/*
+	 * Give up ptrace here (task is gone and it will never run again),
+	 * this also make sure to release_task() any TASK_DEAD task with
+	 * exit_signal == -1.
+	 */
+	if (unlikely(tsk->ptrace))
+		__ptrace_unlink(tsk);
+
 	state = TASK_ZOMBIE;
-	if (tsk->exit_signal == -1 && tsk->ptrace == 0)
+	if (tsk->exit_signal == -1)
 		state = TASK_DEAD;
 	tsk->state = state;
 	tsk->flags |= PF_DEAD;
