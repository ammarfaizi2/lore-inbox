Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272318AbTHOXDd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 19:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272319AbTHOXDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 19:03:33 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:62337 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S272318AbTHOXD3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 19:03:29 -0400
Date: Sat, 16 Aug 2003 00:03:12 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       gaxt <gaxt@rogers.com>, Mike Galbraith <efault@gmx.de>
Subject: Scheduler activations (IIRC) question
Message-ID: <20030815230312.GD19707@mail.jlokier.co.uk>
References: <200308160149.29834.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308160149.29834.kernel@kolivas.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> In O15 I mentioned that preventing parents from preempting their children 
> prevented starvation of applications where they would be busy on wait. Long 
> story to describe how, but I discovered the problem inducing starvation in 
> O15 was the same, but with wakers and their wakee. The wakee would preempt 
> the waker, and the waker could make no progress until it got rescheduled... 

I'm not clear on the effect of this.

There's a specific threading technique that I haven't programmed, but
would like to.  Whether it will work well depends on the kernel
scheduler.

The idea is that I run many cooperative tasks using user-space
switching (these are very light weight tasks, no stack, more like
state machines).  It is not so different from a classic poll() loop.

If one of these calls a system call, like read() or fsync(), I want
the program to make progress with its other state machines while the
first is blocked doing I/O.  For read(), I can use async I/O, but aio
doesn't provide async variants of all the system calls which can block,
such as open(), stat() and readdir() - and I use stat() more than read().

It isn't reasonable to make a kernel thread per userspace state
machine: I want less preemption than that implies, having more control
over locking contexts between the state machines than that.  And each
kernel thread uses a relatively large space, while the states are
quite small and it is reasonable to have a large number.

The usual solution is to spawn a few kernel threads, where that number
is determined empirically according to how much blocking the program
seems to do.  For example see nfsd.  I would do this anyway, to take
advantage of SMP/HT, but I dislike the fact that the optimal number of
kernel threads is impossible to plan, as it varies according to what
the program is doing.

Also, I do not like multiple kernel threads to end up on the same CPU,
with each one handling many state machines, as many of the machines
don't block in system calls, and so the kernel threads will appear to
be mostly CPU hogs, to the kernel scheduler.

That would mean when one kernel thread uses its timeslice, another
takes over and makes a state machine pause for the length of a CPU hog
timeslice, which isn't always appropriate.

One solution is for each kernel thread (one per CPU) to maintain a
shadow thread which normally sleeps.  Whenever I'm about to call a
system call which may block, I'd wake the shadow thread.  If the
system call doesn't block, it'll return without the shadow thread
running, and I can put it back to sleep again.  If a shadow thread
does manage to run, it will make itself an active thread and spawn a
shadow thread for itself.  When there's an excess of active threads,
they turn themselves into shadow threads and sleep, or kill
themselves.

Of course I would maintain a pool of sleeping shadow threads, with
watermaks, not creating and destroying them at high speed.

This way, I create and destroy active kernel threads according to
the number of userspace state machines which are really blocked in
system calls.  It seems like good idea to me.

I think it's been done before, under the name "scheduler activations",
on some other kernel.

There is but one little caveat. :)
(And this is before starting to code it :)

When a kernel thread wakes another, it's desirable that the first
thread continues running, and the woken thread does not run
immediately (not even on another CPU), so that if the waker doesn't
block in the system call, the wakee can be put back to sleep before it runs.

I'm wondering - this is my question - does the current scheduler have
predictable behaviour in this regard?

Cheers,
-- Jamie
