Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129404AbRBFU1b>; Tue, 6 Feb 2001 15:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129219AbRBFU1V>; Tue, 6 Feb 2001 15:27:21 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:23048 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129486AbRBFU1I>; Tue, 6 Feb 2001 15:27:08 -0500
Date: Tue, 6 Feb 2001 12:26:50 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ben LaHaise <bcrl@redhat.com>
cc: Ingo Molnar <mingo@elte.hu>, "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.30.0102061437250.15204-100000@today.toronto.redhat.com>
Message-ID: <Pine.LNX.4.10.10102061210130.1474-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Feb 2001, Ben LaHaise wrote:
> 
> This small correction is the crux of the problem: if it blocks, it takes
> away from the ability of the process to continue doing useful work.  If it
> returns -EAGAIN, then that's okay, the io will be resubmitted later when
> other disk io has completed.  But, it should be possible to continue
> servicing network requests or user io while disk io is underway.

Ehh..  The supprot for this is actually all there already. It's just not
used, because nobody asked for it.

Check the "rw_ahead" variable in __make_request(). Notice how it does
everything you ask for.

So remind me again why we should need a whole new interface for something
that already exists but isn't exported because nobody needed it? It got
created for READA, but that isn't used any more.

You could absolutely _trivially_ re-introduce it (along with WRITEA), but
you should probably change the semantics of what happens when it doesn't
get a request. Something like making "submit_bh()" return an error value
for the case, instead of doing "bh->b_end_io(0..)" which is what I think
it does right now. That would make it easier for the submitter to say "oh,
the queue is full".

This is probably all of 5 lines of code.

I really think that people don't give the block device layer enough
credit. Some of it is quite ugly due to 10 years of history, and there is
certainly a lack of some interesting capabilities (there is no "barrier"
operation right now to enforce ordering, for example, and it really would
be sensible to support a wider operation of ops than just read/write and
let the ioctl's use it to pass commands too).

These issues are things that I've been discussing with Jens for the last
few months, and are things that he already to some degree has been toying
with, and we already decided to try to do this during 2.5.x.

It's already been a _lot_ of clean-up with the per-queue request lists
etc, and there's more to be done in the cleanup section too. But the fact
is that too many people seem to have ignored the support that IS there,
and that actually works very well indeed - and is very generic.

> > What more do you think your kiobuf's should be able to do?
> 
> That's what my code is doing today.  There are a ton of bh's setup for a
> single kiobuf request that is issued.  For something like a single 256kb
> io, this is the difference between the batched io requests being passed
> into submit_bh fitting in L1 cache and overflowing it.  Resizable bh's
> would certainly improve this.

bh's _are_ resizeable. You just change bh->b_size, and you're done.

Of course, you'll need to do your own memory management for the backing
store. The generic bread() etc layer makes memory management simpler by
having just one size per page and making "struct page" their native mm
etity, but that's not really a bh issue - it's a MM issue and stems from
the fact that this is how all traditional block filesystems tend to want
to work.

NOTE! If you do start to resize the buffer heads, please give me a ping.
The code has never actually been _tested_ with anything but 512. 1024,
2048, 4096 and 8192-byte blocks. I would not be surprised at all if some
low-level drivers actually have asserts that the sizes are ones they
"recognize". The generic layer should be happy with anything that is a
multiple of 512, but as with all things, you'll probably find some gotchas
when you actually try something new.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
