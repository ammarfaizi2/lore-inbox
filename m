Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136547AbRA1CEd>; Sat, 27 Jan 2001 21:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136563AbRA1CEX>; Sat, 27 Jan 2001 21:04:23 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:45580 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136547AbRA1CEG>; Sat, 27 Jan 2001 21:04:06 -0500
Date: Sat, 27 Jan 2001 18:03:13 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jens Axboe <axboe@suse.de>
cc: Lorenzo Allegrucci <lenstra@tiscalinet.it>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1-pre10 deadlock (Re: ps hang in 241-pre10)
In-Reply-To: <20010128024635.C31648@suse.de>
Message-ID: <Pine.LNX.4.10.10101271756480.1427-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Jan 2001, Jens Axboe wrote:
> > 
> > So what happens is that somebody takes a page fault (and gets the mm
> > lock), tries to read something in, and never gets anything back, thus
> > leaving the MM locked.
> 
> What was the trace of this? Just curious, the below case outlined by
> Linus should be pretty generic, but I'd still like to know what
> can lead to this condition.

It was posted on linux-kernel - I don't save the dang things because I
have too much in my "archives" as is ;)

> > Lorenzo, does the problem go away for you if you remove the
> > 
> > 	if (!list_empty(&q->request_freelist[rw])) {
> > 		...
> > 	}
> > 
> > code from blkdev_release_request() in drivers/block/ll_rw_block.c?
> 
> Good spotting. Actually I see one more problem with it too. If
> we've started batching (under heavy I/O of course), we could
> splice the pending list and wake up X number of sleepers, but
> there's a) no guarentee that these sleepers will actually get
> the requests if new ones keep flooding in

(a) is ok. They'll go back to sleep - it's a loop waiting for requests..

>				 and b) no guarentee
> that X sleepers require X request slots.

Well, IF they are sleeping (and thus, if the wake_up_nr() will trigger on
them), they _will_ use a request. I don't think we have to worry about
that. At most we will wake up "too many" - we'll wake up processes even
though they end up not being able to get a request anyway because somebody
else got to it first. And that's ok. It's the "wake up too few" that
causes trouble, and I think that will be fixed by my suggestion.

Now, I'd worred if somebody wants several requests at the same time, and
doesn't feed them to the IO layer until it has gotten all of them. In that
case, you can get starvation with many people having "reserved" their
requests, and there not be enough free requests around to actually ever
wake anybody up again. But the regular IO paths do not do this: they will
all allocate a request and just submit it immediately, no "reservation".

(Obviously, _submitting_ the request doesn't mean that we'd actually start
processing it, but if somebody ends up waiting for requests they'll do the
unplug that does start it all going, so effectively we can think of it as
a logical "start this request now" thing even if it gets delayed in order
to coalesce IO).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
