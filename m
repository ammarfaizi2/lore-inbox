Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265424AbTBLB5R>; Tue, 11 Feb 2003 20:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265457AbTBLB5R>; Tue, 11 Feb 2003 20:57:17 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:2914 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S265424AbTBLB5P>; Tue, 11 Feb 2003 20:57:15 -0500
Date: Tue, 11 Feb 2003 18:06:54 -0800
Message-Id: <200302120206.h1C26sI19476@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
X-Fcc: ~/Mail/linus
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: another subtle signals issue
In-Reply-To: Linus Torvalds's message of  Tuesday, 11 February 2003 14:01:32 -0800 <Pine.LNX.4.44.0302111356550.1405-100000@penguin.transmeta.com>
X-Fcc: ~/Mail/linus
Emacs: resistance is futile; you will be assimilated and byte-compiled.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have run across another issue brought up my signals changes.  As it
stands now, a SIG_DFL signal whose default action is to do nothing will
deliver the signal and only inside get_signal_to_deliver decide to ignore
it.  So there can be a TIF_SIGPENDING wakeup that results in no signal
being delivered and is intended to have no visible effect, in particular
POSIX semantics are that it won't cause an EINTR result from some random
blocking call.  It had been my assumption that this would be ok, though it
really ought to be optimized away.

However, it's clearly not ok for sys_semop.  It's plain from reading the
code that it will always return EINTR if it gets a signal wakeup, and that
indeed explains some failures we're seeing in the LSB testsuite on current
kernels.  

We are testing the patch below.  Please do not put this patch in.  The
optimization should go in eventually, but this patch needs to be cleaned up
so we don't bother queuing and dequeuing the ignored signal, and to have
some comments.  Moreover, I want to better understand what is going on
before we put the question to bed.

I think sys_semop would be closer to right if it used ERESTARTSYS instead
of EINTR.  However, using this patch fixes some other LSB test problems I
hadn't yet figured out, as well as semop.  The other affected tests involve
wait4 and read (n_tty), which do appear to use ERESTARTSYS in the
appropriate fashion.  Thus I am confused as to why this should matter to
those cases at all, and suspect there is some other problem lurking.

The reason I am concerned about this is that I think any case that is
broken by the lack of the optimization in the patch below must also be
broken vis a vis the semantics of stop signals and SIGCONT (when SIG_DFL,
SIG_IGN, or blocked).  POSIX says that when a process is stopped by
e.g. SIGSTOP, and then continued by SIGCONT, any functions that were in
progress at the time of stop are unaffected unless SIGCONT runs a handler.
That is, nobody returns EINTR because of the stop/continue.

In the semop tests, a SIGCHLD signal (when set to SIG_DFL, which means do
nothing) was what made semop return EINTR when it should have kept
blocking.  I haven't fully investigated the other cases whose behavior was
affected, but the same thing seems reasonably likely.  It seems to me that,
anything whose behavior is perturbed by waking up, dequeueing a SIGCHLD and
doing nothing about it in get_signal_to_deliver, and resuming, would also
be perturbed by waking up, dequeuing a SIGSTOP, stopping, be continued by
someone sending SIGCONT, dequeuing a SIGCONT, do nothing about it, and
resuming.  So if the patch below fixes it, it's already a bug.

As I said, sys_semop is clearly wrong in its use of EINTR.  Any use of
EINTR is suspect and perhaps ought to be ERESTARTSYS (which gets morphed
into EINTR when it's appropriate to return EINTR).  But that does not
explain the other behaviors I saw change, so I wonder what I am missing.
I would appreciate any thoughts you have on this.

That mystery is my primary concern.  But that aside, it further seems wrong
to use ERESTARTSYS in semop when there is a timeout involved.  Functions
such as semop and nanosleep are specified to forget their timed blocks when
the run a signal handler.  But I haven't seen anything in POSIX that allows
unexpired timeouts to be perturbing by stopping and continuing.  Say you
have some program that blocks in semop with a timeout of a minute, you wait
30 seconds and then hit C-z and then fg, all in under 5 seconds--it should
be more than 25 seconds before semop returns EAGAIN, but less than 30, and
it should never return EINTR in this case.  Right now, I think semop will
return EINTR as soon as you fg, which is wrong.  But changing it to
ERESTARTSYS would make it start the timer at 60 seconds again after more
than 30 seconds had already ticked off.  Any place that uses a timeout
probably needs to do an intelligent restart like nanosleep does, or else
do something highly questionable like call do_signal itself (since it wants
to bail in the handling case and can stay inside its loop otherwise).


Thanks,
Roland



--- /home/roland/redhat/linux-2.5.59-1.1007/kernel/signal.c.~2~	Sun Feb  9 03:58:57 2003
+++ /home/roland/redhat/linux-2.5.59-1.1007/kernel/signal.c	Tue Feb 11 13:45:25 2003
@@ -730,6 +732,11 @@ specific_send_sig_info(int sig, struct s
 	if (LEGACY_QUEUE(&t->pending, sig))
 		return 0;
 
+	if (sig_kernel_ignore(sig) &&
+	    t->sighand->action[sig-1].sa.sa_handler == SIG_DFL &&
+	    !sigismember(&t->blocked, sig))
+		return 0;
+
 	ret = send_signal(sig, info, &t->pending);
 	if (!ret && !sigismember(&t->blocked, sig))
 		signal_wake_up(t, sig == SIGKILL);
@@ -862,6 +869,12 @@ __group_send_sig_info(int sig, struct si
 		p->signal->curr_target = t;
 	}
 
+	if (sig_kernel_ignore(sig) &&
+	    p->sighand->action[sig-1].sa.sa_handler == SIG_DFL) {
+		rm_from_queue(sigmask(sig), &p->signal->shared_pending);
+		return 0;
+	}
+
 	/*
 	 * Found a killable thread.  If the signal will be fatal,
 	 * then start taking the whole group down immediately.
