Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932685AbVHSSdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685AbVHSSdf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 14:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932687AbVHSSdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 14:33:35 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:5299 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932685AbVHSSde (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 14:33:34 -0400
Date: Fri, 19 Aug 2005 11:34:08 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] Use RCU to protect tasklist for unicast signals
Message-ID: <20050819183408.GC1298@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <42FC6305.E7A00C0A@tv-sign.ru> <20050815174403.GE1562@us.ibm.com> <4301D455.AC721EB7@tv-sign.ru> <20050816170714.GA1319@us.ibm.com> <20050817014857.GA3192@us.ibm.com> <43034B17.3DEE0884@tv-sign.ru> <20050817211957.GN1300@us.ibm.com> <43047570.4089FCF1@tv-sign.ru> <20050819012918.GG1372@us.ibm.com> <4305DE3C.EC56B48C@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4305DE3C.EC56B48C@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 05:27:24PM +0400, Oleg Nesterov wrote:
> Paul E. McKenney wrote:
> >
> > I have indeed been thinking along these lines, but all of the devil plans
> > that I have come up thus far are quite intrusive, and might have some
> > performance problems in some situations.  So it seems best to remove
> > tasklist_lock in steps:
> >
> > 1.	Single-recipient catch and ignore cases.
> >
> > 2.	Single-recipient stop/continue cases.
> >
> > 3.	Single-recipient fatal cases.
> >
> > 4.	Single-process multi-threaded stop/continue cases.
> >
> > 5.	Single-process multi-threaded fatal cases.
> >
> > 6.	And on to process-group cases.
> 
> Paul, I am not an expert at all, but honestly I don't see how
> this could be achieved. This lock is heavily overloaded for
> quite different purposes. I think that may be it makes sense
> to try other steps, for example (random order):
> 
>   1. Tasklist protects ->sighand changing (de_thread) - rework
>      sighand access/locking.

We have a start on this, and this is the first area I am making tests
for.

>   2. Tasklist protects reparenting - fix this.

Good point...  Will require thought.  And tests that target this race.
The tests are what I am working now.

>   .......
> 
>   N. PTRACE!!! Well, I close my eyes immediately when I see this
>      word in the sources.

This one as well.  Hmmm....  The tests could be fun -- race gdb
grabbing a process with sending that process a signal.  Might
need to instead make a small program that pretends to be gdb,
will play with it.

Some others that come to mind:

N+1.	Process-group leader dies while process-group signal is being
	received.

N+2.	Process-group members are wildly creating new processes while
	a fatal signal is being received (which should result in -all-
	processes in the group dying).

N+3.	Threads are being wildly created in a multithreaded process while
	a fatal signal is being received...

N+4.	The tsk->signal->curr_target in a multithreaded process changes
	while a signal is being received.

N+5.	The handler state (default/ignored/caught) changes while a
	signal is being received.  But siglock should cover this.

N+6.	Different signal reception orders for different tasks in
	a given set of groups (e.g., fatal signal to process group
	at same time as fatal signal to multithreaded process within
	that group).  Don't believe that this one matters, but thought
	I should call it out anyway.

	o	SIGHUP/SIGCONT from tty going away vs. SIGSTOP
		from elsewhere.

	o	tty signal (ctrl-Z, ctrl-C, ...) vs. signal to
		specific process in the tty's process group.

And there are probably more, but this should keep me busy for a bit.

> Only then we can eliminate tasklist locking from signal sending
> path. But I don't see the easy way to solve any of these 1 - N
> problems.

If it was easy, someone would likely already have done it...

> Currently I don't see how your patch could be "fixed" for SIGCONT
> case, except very ugly:
> 
> 	kill_proc_info(sig)
> 	{
> 		p = find_task_by_pid(pid);
> 		if (sig == SIGCONT)
> 			read_lock(&tasklist_lock);
> 
> 		error = group_send_sig_info(...);
> 		...
> 	}

I was indeed thinking along these lines.

> But there are other problems too.
> 
> Look at __group_complete_signal(), it scans p->pids[PIDTYPE_TGID].pid_list
> list to find a a suitable thread. What if 'p' does clone(CLONE_THREAD) now?
> Let's look at copy_process(), it does attach_pid(p, PIDTYPE_TGID, p->tgid)
> under the lovely tasklist_lock again.

Another approach that I am considering for the class of problem is to
have the code paths that create or change tasks momentarily acquire
locks corresponding to the groups of tasks that can receive signals.
There are a number of problems with this, for example, the logical place
for the lock corresponding to a process group is the process-group leader.
There has to be a way to handling the case where the process-group leader
dies before the rest of the processes do.  And so on, for similar changes.

> So, I don't beleive we can solve even the simplest case (single-recipient,
> non fatal, non stop/cont) without significant locking rework.

Agreed, hence the "Not-signed-off-by:" on my original patch.

> I hope that your patch will stimulate this work.

Me too, will continue working it.  Your comments have been very helpful!

If nothing else, this thread has shown that there are some worthwhile
benefits from getting rid of tasklist_lock...

							Thanx, Paul
