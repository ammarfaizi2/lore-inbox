Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130298AbRBFW1V>; Tue, 6 Feb 2001 17:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129416AbRBFW1L>; Tue, 6 Feb 2001 17:27:11 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:40718 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129640AbRBFW1D>; Tue, 6 Feb 2001 17:27:03 -0500
Date: Tue, 6 Feb 2001 14:26:38 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jens Axboe <axboe@suse.de>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Manfred Spraul <manfred@colorfullife.com>,
        Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <20010206230929.K2975@suse.de>
Message-ID: <Pine.LNX.4.10.10102061421490.1825-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Feb 2001, Jens Axboe wrote:

> On Tue, Feb 06 2001, Marcelo Tosatti wrote:
> > 
> > Reading write(2): 
> > 
> >        EAGAIN Non-blocking  I/O has been selected using O_NONBLOCK and there was
> >               no room in the pipe or socket connected to fd to  write  the data
> >               immediately.
> > 
> > I see no reason why "aio function have to block waiting for requests". 
> 
> That was my reasoning too with READA etc, but Linus seems to want that we
> can block while submitting the I/O (as throttling, Linus?) just not
> until completion.

Note the "in the pipe or socket" part.
                 ^^^^    ^^^^^^

EAGAIN is _not_ a valid return value for block devices or for regular
files. And in fact it _cannot_ be, because select() is defined to always
return 1 on them - so if a write() were to return EAGAIN, user space would
have nothing to wait on. Busy waiting is evil.

So READA/WRITEA are only useful inside the kernel, and when the caller has
some data structures of its own that it can use to gracefully handle the
case of a failure - it will try to do the IO later for some reasons, maybe
deciding to do it with blocking because it has nothing better to do at the
later date, or because it decides that it can have only so many
outstanding requests.

Remember: in the end you HAVE to wait somewhere. You're always going to be
able to generate data faster than the disk can take it. SOMETHING has to
throttle - if you don't allow generic_make_request() to throttle, you have
to do it on your own at some point. It is stupid and counter-productive to
argue against throttling. The only argument can be _where_ that throttling
is done, and READA/WRITEA leaves the possibility open of doing it
somewhere else (or just delaying it and letting a future call with
READ/WRITE do the throttling).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
