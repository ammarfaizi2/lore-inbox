Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272652AbRIGN2q>; Fri, 7 Sep 2001 09:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272653AbRIGN2k>; Fri, 7 Sep 2001 09:28:40 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:51577 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S272652AbRIGN2X>; Fri, 7 Sep 2001 09:28:23 -0400
Date: Fri, 7 Sep 2001 15:28:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: David Mosberger <davidm@hpl.hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] proposed fix for ptrace() SMP race
Message-ID: <20010907152858.O11329@athlon.random>
In-Reply-To: <200109062300.QAA27430@napali.hpl.hp.com> <20010907021900.L11329@athlon.random> <15256.6038.599811.557582@napali.hpl.hp.com> <20010907032801.N11329@athlon.random> <15256.22858.57091.769101@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15256.22858.57091.769101@napali.hpl.hp.com>; from davidm@hpl.hp.com on Thu, Sep 06, 2001 at 10:21:14PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2001 at 10:21:14PM -0700, David Mosberger wrote:
> >>>>> On Fri, 7 Sep 2001 03:28:01 +0200, Andrea Arcangeli <andrea@suse.de> said:
> 
>   Andrea> For making sure the task isn't wakenup while it's under
>   Andrea> ptrace we should just do that in
>   Andrea> kernel/signal.c::ignored_signal() as far I can tell.
> 
> This doesn't make sense: ignored_signal() is too late as
> handle_stop_signal() will already have woken up the task in response
> to a SIGCONT.  Also, if you're suggesting to ignore SIGCONT while a
> PT_PTRACED is set, that certainly wouldn't be right.  We only want to

correct, I suggest to ignore SIGCONT as well while PT_PTRACED is set.

> *delay* the wakeup while the ptrace() system call is running (which is
> much shorter than the period of time PT_PTRACED is set).  So, as far
> as I can tell, you'd have to add more locking to the signal path,

Not more locking, just an additional check:

--- 2.4.10pre4aa1/kernel/signal.c.~1~	Sun Sep  2 20:04:01 2001
+++ 2.4.10pre4aa1/kernel/signal.c	Fri Sep  7 15:22:23 2001
@@ -382,7 +382,7 @@
 	switch (sig) {
 	case SIGKILL: case SIGCONT:
 		/* Wake up the process if stopped.  */
-		if (t->state == TASK_STOPPED)
+		if (t->state == TASK_STOPPED && !(t->ptrace & PT_PTRACED))
 			wake_up_process(t);
 		t->exit_code = 0;
 		rm_sig_from_queue(SIGSTOP, t);

> So, I still think cpus_allowed is a safer and better approach at least

forget that.  Also when you restore the cpus_allowed you won't
effectively wakup the task, it will just keep floating in the runqueue
but we won't try to reschedule the other idle cpus it so it's broken.

> Hmmh, looking at ptrace() more closely, the entire locking situation
> seems to be a bit confused.  For example, what's stopping wait4() from
> releasing the task structure just after ptrace() released the
> tasklist_lock and before it checked child->state?

the get_task_struct()

Andrea
