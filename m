Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129667AbRBFTws>; Tue, 6 Feb 2001 14:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130047AbRBFTw2>; Tue, 6 Feb 2001 14:52:28 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:9624 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129667AbRBFTwT>; Tue, 6 Feb 2001 14:52:19 -0500
Date: Tue, 6 Feb 2001 14:49:55 -0500 (EST)
From: Ben LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Ingo Molnar <mingo@elte.hu>, "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        <kiobuf-io-devel@lists.sourceforge.net>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.10.10102061121530.1474-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0102061437250.15204-100000@today.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2001, Linus Torvalds wrote:

>
>
> On Tue, 6 Feb 2001, Ben LaHaise wrote:
> >
> > s/impossible/unpleasant/.  ll_rw_blk blocks; it should be possible to have
> > a non blocking variant that does all of the setup in the caller's context.
> > Yes, I know that we can do it with a kernel thread, but that isn't as
> > clean and it significantly penalises small ios (hint: databases issue
> > *lots* of small random ios and a good chunk of large ios).
>
> Ehh.. submit_bh() does everything you want. And, btw, ll_rw_block() does
> NOT block. Never has. Never will.
>
> (Small correction: it doesn't block on anything else than allocating a
> request structure if needed, and quite frankly, you have to block
> SOMETIME. You can't just try to throw stuff at the device faster than it
> can take it. Think of it as a "there can only be this many IO's in
> flight")

This small correction is the crux of the problem: if it blocks, it takes
away from the ability of the process to continue doing useful work.  If it
returns -EAGAIN, then that's okay, the io will be resubmitted later when
other disk io has completed.  But, it should be possible to continue
servicing network requests or user io while disk io is underway.

> If you want to use kiobuf's because you think they are asycnrhonous and
> bh's aren't, then somebody has been feeding you a lot of crap. The kiobuf
> PR department seems to have been working overtime on some FUD strategy.

I'm using bh's to refer to what is currently being done, and kiobuf when
talking about what could be done.  It's probably the wrong thing to do,
and if bh's are extended to operate on arbitrary sized blocks then there
is no difference between the two.

> If you want to make a "raw disk device", you can do so TODAY with bh's.
> How? Don't use "bread()" (which allocates the backing store and creates
> the cache). Allocate a separate anonymous bh (or multiple), and set them
> up to point to whatever data source/sink you have, and let it rip. All
> asynchronous. All with nice completion callbacks. All with existing code,
> no kiobuf's in sight.

> What more do you think your kiobuf's should be able to do?

That's what my code is doing today.  There are a ton of bh's setup for a
single kiobuf request that is issued.  For something like a single 256kb
io, this is the difference between the batched io requests being passed
into submit_bh fitting in L1 cache and overflowing it.  Resizable bh's
would certainly improve this.

		-ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
