Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129837AbRBHRxF>; Thu, 8 Feb 2001 12:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129843AbRBHRwz>; Thu, 8 Feb 2001 12:52:55 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:30483 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129837AbRBHRws>; Thu, 8 Feb 2001 12:52:48 -0500
Date: Thu, 8 Feb 2001 09:52:23 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@suse.cz>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, Jens Axboe <axboe@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>,
        Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: select() returning busy for regular files [was Re: [Kiobuf-io-devel]
 RFC: Kernel mechanism: Compound event wait]
In-Reply-To: <20010208001735.C189@bug.ucw.cz>
Message-ID: <Pine.LNX.4.10.10102080947470.6741-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Feb 2001, Pavel Machek wrote:
> > 
> > There are currently no other alternatives in user space. You'd have to
> > create whole new interfaces for aio_read/write, and ways for the kernel to
> > inform user space that "now you can re-try submitting your IO".
> 
> Why is current select() interface not good enough?

Ehh..

One major reason is rather simple: disk request wait times tend to be on
the order of sub-millisecond (remember: if we run out of requests, that
means that we have 256 of them already queued, which means that it's very
likely that several of them will be freed up in the very near future due
to completion).

The fact is, that if you start doing write/select loops, you're going to
waste a _large_ portion of your CPU speed on it.  Especially considering
that the select() call would have to go all the way down to the ll_rw_blk
layer to figure out whether there are more requests etc.

So there is (a) historical reasons that say that regular files can never
wait and EAGAIN is not an acceptable return value and (b) practical
reasons for why such an interface would be a bad one.

There are better ways to do it. Either using threads, or just having a
better aio-like interface.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
