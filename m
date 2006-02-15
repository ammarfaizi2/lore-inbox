Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945906AbWBOMsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945906AbWBOMsN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 07:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945925AbWBOMsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 07:48:13 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:23753 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1945906AbWBOMsM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 07:48:12 -0500
Message-ID: <43F3352C.E2D8F998@tv-sign.ru>
Date: Wed, 15 Feb 2006 17:05:32 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix kill_proc_info() vs copy_process() race
References: <43E77D3C.C967A275@tv-sign.ru> <20060214223214.GG1400@us.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney wrote:
> 
> On Mon, Feb 06, 2006 at 07:45:48PM +0300, Oleg Nesterov wrote:
> > The first race is simple, copy_process:
> > 
> > 	/*
> > 	 * Check for pending SIGKILL! The new thread should not be allowed
> > 	 * to slip out of an OOM kill. (or normal SIGKILL.)
> > 	 */
> > 	if (sigismember(&current->pending.signal, SIGKILL))
> > 		return EINTR;
> > 
> > This relies on tasklist_lock and is racy now.
> 
> Agreed, but is the race any worse than it was before?  Since SIGKILL is
> fatal, the bit can be set but never cleared.  My belief, quite possibly
> mistaken, is that this is a performance issue rather than a correctness
> issue -- we would like to avoid the overhead of a fork() for a "walking
> dead" process.

My apologies, I was very unclear. I talked about this check because I tried
to unify it with 'if (SIGNAL_GROUP_EXIT)' below. Let me try again.

copy_process(CLONE_THREAD)					__group_complete_signal(SIGKILL)

	lock(->sighand);
	if (->signal->flags & SIGNAL_GROUP_EXIT) // NO
		...abort forking...
	unlock(->sighand)

								->signal->flags = SIGNAL_GROUP_EXIT;
								// does not see the new thread yet
								for_each_thread_in_thread_group(t) {
									sigaddset(t->pending, SIGKILL);
									signal_wake_up(t);
								}

	... finish clone ...


The new thread starts without TIF_SIGPENDING. When any of other threads calls
get_signal_to_deliver() it will notice SIGKILL and call do_group_exit(), which
does:

	if (SIGNAL_GROUP_EXIT) // Yes, was set in group_complete_signal()
		// don't call zap_other_threads()
	do_exit();

So, thread group missed SIGKILL. The new thread runs with SIGNAL_GROUP_EXIT set
and has SIGKILL in ->shared_pending, so it can't be killed via sys_kill(SIGKILL),
and it can't be stopped.

This is not fatal, we can kill this thread via tkill(), even if it blocked other
signals, but still this is a bug (if I am right).

> > The second race is more tricky, copy_process:
> > 
> > 	attach_pid(p, PIDTYPE_PID, p->pid);
> > 	attach_pid(p, PIDTYPE_TGID, p->tgid);
> > 
> > This means that we can find a task in kill_proc_info()->find_task_by_pid()
> > which is not registered as part of thread group yet. Various bad things can
> > happen, note that handle_stop_signal(SIGCONT) and __group_complete_signal()
> > iterate over threads list. But p->pids[PIDTYPE_TGID] is a copy of current's
> > 'struct pid' from dup_task_struct(), and if we don't have CLONE_THREAD here
> > we will use completely unreleated (parent's) thread list.
> 
> But I could easily be missing something, still a bit jetlagged.  Could
> you please lay out the exact sequence of events in the scenario that you
> are thinking of?

Let's suppose that process with pid == 1000 does fork (no CLONE_THREAD bit),
and a bad boy does sys_kill(1001, SIGXXX)

copy_process:

	// it is possible that p->pid == 1001
	attach_pid(p, PIDTYPE_PID, p->pid);


						kill_proc_info:

						    p = find_task_by_pid(1001); // Found!

						    __group_complete_signal(p):

						        // iterate over thread group
						        do {
						        	...
						        } while (next_thread(t) != p)

The (one of) problem is that this loop never stops: next_thread() will iterate
over parent's threads list, because p have a copy of the parent's pids[PIDTYPE_TGID],
and p is not a member of this thread group. Unless I missed something, we have
an endless loop with interrupts disabled.

> And if there is a real problem, is it possible to fix it by changing
> the order of the attach_pid() calls?

I think yes, and I did exactly that in my next attempt to fix this problem.

Oleg.
