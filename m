Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275078AbTHQIau (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 04:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275079AbTHQIau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 04:30:50 -0400
Received: from imap.gmx.net ([213.165.64.20]:15272 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S275078AbTHQIat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 04:30:49 -0400
Message-Id: <5.2.1.1.2.20030817100457.019d0c70@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sun, 17 Aug 2003 10:34:55 +0200
To: Jamie Lokier <jamie@shareable.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: Scheduler activations (IIRC) question
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       gaxt <gaxt@rogers.com>
In-Reply-To: <20030817065501.GA1105@mail.jlokier.co.uk>
References: <5.2.1.1.2.20030817072115.0198f398@pop.gmx.net>
 <5.2.1.1.2.20030816080614.01a0e418@pop.gmx.net>
 <20030815235431.GT1027@matchmail.com>
 <200308160149.29834.kernel@kolivas.org>
 <20030815230312.GD19707@mail.jlokier.co.uk>
 <20030815235431.GT1027@matchmail.com>
 <5.2.1.1.2.20030816080614.01a0e418@pop.gmx.net>
 <5.2.1.1.2.20030817072115.0198f398@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:55 AM 8/17/2003 +0100, Jamie Lokier wrote:
>Mike Galbraith wrote:
> > >The point of the mechanism is to submit system calls in an
> > >asynchronous fashion, after all.  A proper task scheduling is
> > >inappropriate when all we'd like to do is initiate the syscall and
> > >continue processing, just as if it were an async I/O request.
> >
> > Ok, so you'd want a class where you could register an "exception handler"
> > prior to submitting a system call, and any subsequent schedule would be
> > treated as an exception?  (they'd have to be nestable exceptions too
> > right?... <imagines stack explosions> egad:)
>
>Well, apart from not resembling exceptions, and no they don't nest :)

(ok, I only misunderstood _almost_ everything:)

>You may be wondering what happens when I do five stat() calls, all of
>which should be asynchronous (topical: to get the best out of the
>elevator).
>
>Nested?  Not quite.  At each stat() call that blocks for I/O, its
>shadow task becomes active; that creates its own shadow task (pulling
>a kernel task from userspace's cache of them), then continues to
>perform the next item of work, which is the next stat().
>
>The result is five kernel threads, each blocked on I/O inside a stat()
>call, exactly as desired.  A sixth kernel thread, the only one running
>of my program, is continuing the work of the program.

Oh.  You just want to dispatch N syscalls from one entry to the kernel?

>Soon, each of the I/O bound threads unblocks, returns to userspace,
>stores its result, queues the next work of this state machine, adds
>this kernel task to userspace's cache, and goes to sleep.
>
>As you can see, this achieves asynchronous system calls which are too
>complex for aio(*), best use of the I/O elevator, and 100% CPU
>utilisation doing useful calculations.
>
>Other user/kernel scheduler couplings are possible, but what I'm
>describing doesn't ask for much(**).  Just the right behaviour from
>the kernel's scheduling heuristic: namely, waker not preempted by
>wakee.  Seems to be the way it's going anyway.

If that's all you need, a SCHED_NOPREEMPT (synchronous wakeups) class 
should do the trick.  I thought you wanted a huge truckload more than that.

         -Mike 

