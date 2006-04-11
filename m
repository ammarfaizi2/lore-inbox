Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWDKIBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWDKIBi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 04:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWDKIBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 04:01:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27777 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932336AbWDKIBh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 04:01:37 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Michael Kerrisk <mtk-lkml@gmx.net>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix de_thread() vs do_coredump() deadlock
In-Reply-To: Oleg Nesterov's message of  Tuesday, 11 April 2006 01:40:18 +0400 <20060410214018.GA635@oleg>
X-Shopping-List: (1) Insignificant lips
   (2) Cylindrical exhibitions
   (3) Hilarious excitements
   (4) Atomic suction infestations
   (5) Irritating scorpions
Message-Id: <20060411080119.2BBF42204D9@magilla.sf.frob.com>
Date: Tue, 11 Apr 2006 01:01:19 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A fatal signal is placed to ->shared_pending in any (non tkill) case, so I
> think it is not lost (but may be unnoticed for a while).
>
> sig_kernel_coredump() is different. It could be stealed by one of sub-threads
> while another one does de_thread(), that is why it could be lost.

I am not talking about the case where it's still pending on either queue.
Those are fine as they are.  What matters is when it's been dequeued, in
the race window afer releasing the siglock in get_signal_to_deliver.
There are two windows of race here.  

The first one is only when ptrace'd, and doesn't even require a race that
takes good timing to create.  The window is in ptrace_stop when the siglock
is released, including all the time stopped in TASK_TRACED.  Say another
thread does an exec (and de_thread) while we're in TASK_TRACED after
reporting a death signal to the debugger.  The SIGKILL wakes us out of
ptrace_stop.  Assuming the debugger wasn't racing with a PTRACE_CONT too,
then the signal remains in ->exit_code and (assuming the SIGNAL_GROUP_EXIT
check there reverted, as I mentioned before), we just come out of the
ptrace path with the siglock held as if we'd dequeued the signal without ptrace.

Then comes the second window.  With no ptrace, or after ptrace, we've
dequeued the signal and if it's a SIG_DFL fatal signal, we release the
siglock.  Here a non-coredump signal just calls do_group_exit.  Meanwhile,
a racing exec comes along and sets SIGNAL_GROUP_EXIT (or it already did
earlier while we were in ptrace_stop).  In do_group_exit, we will see that
SIGNAL_GROUP_EXIT is set, and just do_exit ourselves with the group_exit_code.
When it's an exec rather than a real exit, we've swallowed the signal.
This is no different than the coredump case.  (When do_coredump bails out,
then it joins this very same code path.)

> What do you think about something like this untested patch instead?
> I am far from sure it is correct, I need a sleep ...

For one thing, it only handles the coredump case.  Moreover, I think there
are too many problems with any plan to stuff a signal back on the queue.
1. This might be moving a signal from some thread's per-thread queue to the
   shared_pending queue.  If the signal was going to be fatal to the group,
   that is fine before the exec but not after it--the new program shouldn't
   get a fatal signal generated for some thread it never had.
2. siginfo_t is lost.
These are just what I could think of off hand.  Pushing a signal
back on the queue is a whole can of worms that I really want to avoid.


Thanks,
Roland
