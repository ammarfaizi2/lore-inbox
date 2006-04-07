Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbWDGKPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWDGKPd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 06:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWDGKPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 06:15:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38091 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932410AbWDGKPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 06:15:32 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Gerd Knorr <kraxel@suse.de>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Wu Zhou <woodzltc@cn.ibm.com>
Subject: Re: [PATCH] ptrace/coredump/exit_group deadlock
In-Reply-To: Andrea Arcangeli's message of  Monday, 3 October 2005 13:29:31 +0200 <20051003112931.GA5209@opteron.random>
Emacs: if SIGINT doesn't work, try a tranquilizer.
Message-Id: <20060407101519.7BA861809D1@magilla.sf.frob.com>
Date: Fri,  7 Apr 2006 03:15:19 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I have been absent from the discussion for such a long time.
I'm trying to catch up on old issues that I should have reviewed earlier.

This is about Andrea's change:

	commit 30e0fca6c1d7d26f3f2daa4dd2b12c51dadc778a
	Author: Andrea Arcangeli <andrea@suse.de>
	Date:   Sun Oct 30 15:02:38 2005 -0800

	    [PATCH] ptrace/coredump/exit_group deadlock

I am quite dubious about this change, and a little confused about the bug
it's addressing.  The change broke the non-leader MT exec case when
ptraced, and this is still broken in 2.6.16.1; the execing thread does
ptrace_unlink in de_thread and winds up SIGKILL'ing itself so it dies as
soon as it finishes the exec.  (Wu Zhou posted about this problem, but I
didn't see that he got any response.  To reproduce the problem, see
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=177240.)  With the
aforementioned commit reverted, the exec problem goes away.  (2.6.17-rc1
no longer suffers this symptom because of other cleanups in de_thread.
But that only further masks the real issues.)

Do you have a self-contained test program to exercise the original bug
you were dealing with?  It looks like maybe you had one, but I didn't see
where you posted it.  I was not really able to follow the description of
the scenario precisely enough to understand the situation.  (I think you
are saying that all the threads you mention are in the same thread group,
with PTRACE_ATTACH from one thread to another in the group, but I am not
entirely sure.)

> I could seldom reproduce a deadlock with a task not killable in T state
> (TASK_STOPPED, not TASK_TRACED) by attaching a NPTL threaded program to
> gdb, by segfaulting the task and triggering a core dump while some other
> task is executing exit_group and while one task is in ptrace_attached
> TASK_STOPPED state (not TASK_TRACED yet). 

I don't understand this part: "TASK_STOPPED state (not TASK_TRACED yet)".
What does that mean?  The only threads that should have a chance to enter
TASK_STOPPED are those that are not ptrace'd, but "not TASK_TRACED yet"
would obviously not apply to those, so I am confused as to what you mean.

> Most threads hangs in exit_mm because the core_dumping is still going,
> the core dumping hangs because the stopped task doesn't exit, the
> stopped task can't wakeup because it has SIGNAL_GROUP_EXIT set, hence
> the deadlock.

I also don't understand this: "the stopped task can't wakeup because it
has SIGNAL_GROUP_EXIT set".  

> To me it seems that the problem is that the force_sig_specific(SIGKILL)
> in zap_threads is a noop if the task has PF_PTRACED set (like in this
> case because gdb is attached). 

This should not be so.  I agree that this is a problem if it's happening.
The SIGKILL ought to wake up any thread that is stopped in whichever
state.  I suspect that what you saw is the scenario that Oleg described
(and fixed), in which a SIGKILL is left pending before the thread stops.
Later SIGKILLs are then no-ops because there is already one pending, but
that is not because of PT_PTRACED (and indeed it need not have it set for
this failure mode, and it's more likely if it doesn't).

> The __ptrace_unlink does nothing because the signal->flags is set to
> SIGNAL_GROUP_EXIT|SIGNAL_STOP_DEQUEUED (verified).

I think here you must be talking about the "if (unlikely(traced))" case
in zap_threads.  Is that right?  Sorry, I'm really having a hard time
understanding your description of the situation.  I'm sure I'm being dense.

This combination of bits should never be possible.  Since you verified
it, I wonder if that might have been on a kernel before this change,
which fixes a clearly related bug:

	commit 788e05a67c343fa22f2ae1d3ca264e7f15c25eaf
	Author: Oleg Nesterov <oleg@tv-sign.ru>
	Date:   Fri Oct 7 17:46:19 2005 +0400

	    [PATCH] fix do_coredump() vs SIGSTOP race

	diff --git a/kernel/signal.c b/kernel/signal.c
	index 619b027..c135f5a 100644
	--- a/kernel/signal.c
	+++ b/kernel/signal.c
	@@ -578,7 +578,8 @@ int dequeue_signal(struct task_struct *t
			 * is to alert stop-signal processing code when another
			 * processor has come along and cleared the flag.
			 */
	- 		tsk->signal->flags |= SIGNAL_STOP_DEQUEUED;
	+ 		if (!(tsk->signal->flags & SIGNAL_GROUP_EXIT))
	+ 			tsk->signal->flags |= SIGNAL_STOP_DEQUEUED;
		}
		if ( signr &&
		     ((info->si_code & __SI_MASK) == __SI_TIMER) &&

> The above info also shows that the stopped task hit a race and got the
> stop signal (presumably by the ptrace_attach, only the attach, state is
> still TASK_STOPPED and gdb hangs waiting the core before it can set it
> to TASK_TRACED) after one of the thread invoked the core dump (it's the
> core dump that sets signal->flags to SIGNAL_GROUP_EXIT).

Sorry again, I'm having a lot of trouble understanding some of this
paragraph, mostly the first parenthetical part.  Could you restate what
you think is going on here?

> So beside the fact nobody would wakeup the task in __ptrace_unlink (the
> state is _not_ TASK_TRACED), there's a secondary problem in the signal
> handling code, where a task should ignore the ptrace-sigstops as long as
> SIGNAL_GROUP_EXIT is set (or the wakeup in __ptrace_unlink path wouldn't
> be enough).

I don't think this is actually a problem.  After Oleg's fix, I believe it
is impossible to get a SIGNAL_GROUP_EXIT|SIGNAL_STOP_DEQUEUED combination.
That being the case, the check in do_signal_stop should prevent the thread
that dequeued a SIGSTOP from acting on it.  In the case of some other
signal passed through by ptrace, it will have its normal action before
getting the the group exit, which is fine.  The thread should not stop for
any reason here and will then go back and see the SIGKILL next.  I don't
think your change in get_signal_to_deliver does any real harm, but I don't
see any reason to put an extra check here just to short-circuit the code
path in this rare race condition.

> So I attempted to make this patch that seems to fix the problem. There
> were various ways to fix it, perhaps you prefer a different one, I just
> opted to the one that looked safer to me.

I am still sufficiently unclear on what your analysis of the situation is
that I cannot be sure I am addressing all of the problems.  I do
understand the scenario Oleg described (see the full log message for his
change).  If what you observed was not different from that, then I think
that your changes to ptrace_untrace and get_signal_to_deliver should be
reverted.  If there is more going on in your case than what I understand,
then please help me understand it.

> I also removed the clearing of the stopped bits from the
> zap_other_threads (zap_other_threads was safe unlike zap_threads). 

This change in zap_other_threads seems fine.  I think that it was just
written trying to be safe without the assumption that SIGKILL will always
be selected from the queue in preference to any stop signals.


Thanks,
Roland
