Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129144AbRBHSJr>; Thu, 8 Feb 2001 13:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129393AbRBHSJi>; Thu, 8 Feb 2001 13:09:38 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:52228 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129144AbRBHSJ0>; Thu, 8 Feb 2001 13:09:26 -0500
Date: Thu, 8 Feb 2001 10:09:05 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: "Stephen C. Tweedie" <sct@redhat.com>, Pavel Machek <pavel@suse.cz>,
        Jens Axboe <axboe@suse.de>, Manfred Spraul <manfred@colorfullife.com>,
        Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.21.0102081000450.25219-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.10.10102081000220.6741-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Feb 2001, Marcelo Tosatti wrote:
> 
> On Thu, 8 Feb 2001, Stephen C. Tweedie wrote:
> 
> <snip>
> 
> > > How do you write high-performance ftp server without threads if select
> > > on regular file always returns "ready"?
> > 
> > Select can work if the access is sequential, but async IO is a more
> > general solution.
> 
> Even async IO (ie aio_read/aio_write) should block on the request queue if
> its full in Linus mind.

Not necessarily. I said that "READA/WRITEA" are only worth exporting
inside the kernel - because the latencies and complexities are low-level
enough that it should not be exported to user space as such.

But I could imagine a kernel aio package that does the equivalent of

	bh->b_end_io = completion_handler;
	generic_make_request(WRITE, bh);	/* this may block */
	bh= bh->b_next;

	/* Now, fill it up as much as we can.. */
	current->state = TASK_INTERRUPTIBLE;
	while (more data to be written) {
		if (generic_make_request(WRITEA, bh) < 0)
			break;
		bh = bh->b_next;
	}

	return;

and then you make the _completion handler_ thing continue to feed more
requests. Yes, you may block at some points (because you need to always
have at least _one_ request in-flight in order to have the state machine
active, but you can basically try to avoid blocking more than necessary.

But do you see why the above can't be done from user space? It requires
that the completion handler (which runs in an interrupt context) be able
to continue to feed requests and keep the queue filled. If you don't do
that, you'll never have good throughput, because it takes too long to send
signals, re-schedule or whatever to user mode.

And do you see how it has to block _sometimes_? If people do hundreds of
AIO requests, we can't let memory just fill up with pending writes..

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
