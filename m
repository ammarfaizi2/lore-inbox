Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289891AbSAWPzF>; Wed, 23 Jan 2002 10:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289886AbSAWPyx>; Wed, 23 Jan 2002 10:54:53 -0500
Received: from ida.rowland.org ([192.131.102.52]:4356 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id <S289885AbSAWPyr>;
	Wed, 23 Jan 2002 10:54:47 -0500
Date: Wed, 23 Jan 2002 10:54:44 -0500 (EST)
From: Alan Stern <stern@rowland.org>
To: <linux-kernel@vger.kernel.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Daemonize() should re-parent its caller
Message-ID: <Pine.LNX.4.33L2.0201231050440.687-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Consider the question: what happens when a kernel thread dies?  For
the most part this doesn't come up, since most kernel threads stay
alive as long as the system is up.  But when a kernel thread dies, the
same thing happens as with any other thread: it becomes a zombie, and
its exit_signal (if any) is posted to its parent.

If the parent is init or another user process, we can reasonably
expect that the zombie will be reaped eventually.  But what if the
parent is another kernel thread?  This situation arises in the USB
mass-storage device driver, where the device manager and scsi
error-handler threads are spawned (indirectly) by the khubd kernel
thread.

In practice, two problems arise here.  First, when the thread is
originally spawned, it typically is not given an exit signal.  The
exit_signal value is part of the flags mentioned in the call to
kernel_thread(); the flags argument ought to be something like
CLONE_VM | SIGCHLD.  However, people often either don't know to add
the SIGCHLD, or don't consider that the thread might terminate, or are
just lazy, so the SIGCHLD is left out.  This can reasonably be
considered an error.

Second, the SIGCHLD is quite likely never to be acted on.  Signals
posted to a process get acted on when the flow of control for that
process passes from kernel mode back to user mode.  With kernel
threads, this never happens.  So even if the parent thread has set its
sigaction for SIGCHLD to be SIG_IGN (so that children are reaped
automatically), the reaping action will not take place.

As a result of these two problems, when such a kernel threads dies, it
hangs around forever as an inaccessible zombie.

The straightforward way for a parent thread to try to solve these
problems is for it to execute

	sys_wait4(-1, NULL, WNOHANG | __WALL, NULL);

during its main loop.  Even that isn't ideal, because if the child
thread's exit_signal is not set then no signal will be posted, and the
parent won't wake up to execute its main loop.  Also, doing this would
mean changing existing drivers, in situations where the original
authors probably never even anticipated that a client routine would
spawn a thread that would need to be reaped.  I imagine there aren't
too many places in the kernel where this situation comes up, so this
could be done.

But a more elegant and economical solution is to have the daemonize()
routine automatically re-parent its caller to be a child of init
(assuming the caller's parent isn't init already).  At the same time,
the caller's exit_signal should be set to SIGCHLD.  This would
definitely solve the problem, and it is unlikely to introduce any
incompatibilities with existing code.

After all, when a user process becomes a daemon, it normally goes
through the whole procedure of forking, letting the parent die, having
the child move to a new session and lose its controlling terminal,
etc.  Daemonize() should take care of all this on behalf of its caller
-- that's what it was created for in the first place.  Changing
sessions and process groups is already in there; becoming a child of
init should be added.

Here is some example (i.e., untested) code to be added in to
daemonize() to accomplish this:

	if (current->c_pptr->pid > 1) {

		/* Become a child of init */

		write_lock_irq(&tasklist_lock);
		if (current->p_ysptr)
			current->p_ysptr->p_osptr = current->p_osptr;
		else
			current->p_pptr->p_cptr = current->p_osptr;
		if (current->p_osptr)
			current->p_osptr->p_ysptr = current->p_ysptr;

		current->p_ysptr = NULL;
		current->p_pptr = child_reaper;
		current->p_osptr = current->p_pptr->p_cptr;
		current->p_pptr->p_cptr = current;
		if (current->p_osptr)
			current->p_osptr->p_ysptr = current;
		write_unlock_irq(&tasklist_lock);
	}
	current->ptrace = 0;
	current->exit_signal = SIGCHLD;

Somebody who understands the details of process management better than
I do might want to make a few adjustments.


Alan Stern

P.S.: I don't subscribe to lkml, so please CC: any replies to me at
<stern@rowland.org>.


