Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270066AbTHQRMm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 13:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270210AbTHQRMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 13:12:42 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:16256 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270066AbTHQRMk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 13:12:40 -0400
Date: Sun, 17 Aug 2003 18:12:24 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       gaxt <gaxt@rogers.com>
Subject: Re: Scheduler activations (IIRC) question
Message-ID: <20030817171224.GA2822@mail.jlokier.co.uk>
References: <5.2.1.1.2.20030817072115.0198f398@pop.gmx.net> <5.2.1.1.2.20030816080614.01a0e418@pop.gmx.net> <20030815235431.GT1027@matchmail.com> <200308160149.29834.kernel@kolivas.org> <20030815230312.GD19707@mail.jlokier.co.uk> <20030815235431.GT1027@matchmail.com> <5.2.1.1.2.20030816080614.01a0e418@pop.gmx.net> <5.2.1.1.2.20030817072115.0198f398@pop.gmx.net> <5.2.1.1.2.20030817100457.019d0c70@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.2.1.1.2.20030817100457.019d0c70@pop.gmx.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> >You may be wondering what happens when I do five stat() calls, all of
> >which should be asynchronous (topical: to get the best out of the
> >elevator).
> >
> >Nested?  Not quite.  At each stat() call that blocks for I/O, its
> >shadow task becomes active; that creates its own shadow task (pulling
> >a kernel task from userspace's cache of them), then continues to
> >perform the next item of work, which is the next stat().
> >
> >The result is five kernel threads, each blocked on I/O inside a stat()
> >call, exactly as desired.  A sixth kernel thread, the only one running
> >of my program, is continuing the work of the program.
> 
> Oh.  You just want to dispatch N syscalls from one entry to the kernel?

No, not at all.  I want to schedule cooperative state machines in
userspace, in the classical select-loop style, but without idling the
CPU when there's unpredictable blocking on disk I/O.

The modern way is to use a few of worker threads per CPU, but they
introduce latency problems and you still have to keep adapting the
number of threads to the type of workload.  (See my response to Nick
Piggin and Ingo Oeser).

> >Soon, each of the I/O bound threads unblocks, returns to userspace,
> >stores its result, queues the next work of this state machine, adds
> >this kernel task to userspace's cache, and goes to sleep.
> >
> >As you can see, this achieves asynchronous system calls which are too
> >complex for aio(*), best use of the I/O elevator, and 100% CPU
> >utilisation doing useful calculations.
> >
> >Other user/kernel scheduler couplings are possible, but what I'm
> >describing doesn't ask for much(**).  Just the right behaviour from
> >the kernel's scheduling heuristic: namely, waker not preempted by
> >wakee.  Seems to be the way it's going anyway.
> 
> If that's all you need, a SCHED_NOPREEMPT (synchronous wakeups) class 
> should do the trick.  I thought you wanted a huge truckload more than that.

Heh.  It looks like that may not be needed, with Con's latest "wakee
doesn't preempt waker" patch.  That's why this thread is a followup to
that one.

There are other efficiency concerns: sending SIGCONT and SIGSTOP
before and after each potentially-blocking syscall is not the fastest
thing in the world to do.  Also it doesn't help with blocking due to
vm paging, but that can be worked around in other ways.

SCHED_NOPREMPT is not right even in principle.  An active task wakes
its shadow task, and the shadow task should not run unless the active
task blocks before putting the shadow task back to sleep.  The wakeup
_is_ a synchronous wakeup, yet we don't want it to run shadow task to run.

-- Jamie
