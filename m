Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBHPJU>; Thu, 8 Feb 2001 10:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129181AbRBHPJA>; Thu, 8 Feb 2001 10:09:00 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:1814 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129051AbRBHPIw>; Thu, 8 Feb 2001 10:08:52 -0500
Date: Thu, 8 Feb 2001 10:06:01 -0500 (EST)
From: Ben LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, Jens Axboe <axboe@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>, Ingo Molnar <mingo@elte.hu>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        <kiobuf-io-devel@lists.sourceforge.net>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.10.10102061516570.1972-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0102080927400.23469-100000@today.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2001, Linus Torvalds wrote:

> There are currently no other alternatives in user space. You'd have to
> create whole new interfaces for aio_read/write, and ways for the kernel to
> inform user space that "now you can re-try submitting your IO".
>
> Could be done. But that's a big thing.

Has been done.  Still needs some work, but it works pretty well.  As for
throttling io, having ios submitted does not have to correspond to them
being queued in the lower layers.  The main issue with async io is
limiting the amount of pinned memory for ios; if that's taken care of, I
don't think it matters how many ios are in flight.

> > An application which sets non blocking behavior and busy waits for a
> > request (which seems to be your argument) is just stupid, of course.
>
> Tell me what else it could do at some point? You need something like
> select() to wait on it. There are no such interfaces right now...
>
> (besides, latency would suck. I bet you're better off waiting for the
> requests if they are all used up. It takes too long to get deep into the
> kernel from user space, and you cannot use the exclusive waiters with its
> anti-herd behaviour etc).

Ah, but no.  In fact for some things, the wait queue extensions I'm using
will be more efficient as things like test_and_set_bit for obtaining a
lock gets executed without waking up a task.

> Simple rule: if you want to optimize concurrency and avoid waiting - use
> several processes or threads instead. At which point you can get real work
> done on multiple CPU's, instead of worrying about what happens when you
> have to wait on the disk.

There do exist plenty of cases where threads are not efficient enough.
Just the stack overhead alone with 8000 threads makes things really suck.
Event based io completion means that server processes don't need to have
the overhead of select/poll.  Add in NT style completion ports for waking
up the right number of worker threads off of the completion queue, and

That said, I don't expect all devices to support async io.  But given
support for files, raw and sockets all the important cases are covered.
The remainder can be supported via userspace helpers.

		-ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
