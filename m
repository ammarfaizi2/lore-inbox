Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130077AbRBFTdZ>; Tue, 6 Feb 2001 14:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129840AbRBFTdP>; Tue, 6 Feb 2001 14:33:15 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:18181 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130077AbRBFTdH>; Tue, 6 Feb 2001 14:33:07 -0500
Date: Tue, 6 Feb 2001 11:32:43 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ben LaHaise <bcrl@redhat.com>
cc: Ingo Molnar <mingo@elte.hu>, "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.30.0102061402200.15204-100000@today.toronto.redhat.com>
Message-ID: <Pine.LNX.4.10.10102061121530.1474-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Feb 2001, Ben LaHaise wrote:
> 
> s/impossible/unpleasant/.  ll_rw_blk blocks; it should be possible to have
> a non blocking variant that does all of the setup in the caller's context.
> Yes, I know that we can do it with a kernel thread, but that isn't as
> clean and it significantly penalises small ios (hint: databases issue
> *lots* of small random ios and a good chunk of large ios).

Ehh.. submit_bh() does everything you want. And, btw, ll_rw_block() does
NOT block. Never has. Never will.

(Small correction: it doesn't block on anything else than allocating a
request structure if needed, and quite frankly, you have to block
SOMETIME. You can't just try to throw stuff at the device faster than it
can take it. Think of it as a "there can only be this many IO's in
flight")

If you want to use kiobuf's because you think they are asycnrhonous and
bh's aren't, then somebody has been feeding you a lot of crap. The kiobuf
PR department seems to have been working overtime on some FUD strategy.

The fact is that bh's can do MORE than kiobuf's. They have all the
callbacks in place etc. They merge and sort correctly. Oh, they have
limitations: one "bh" always describes just one memory area with a
"start,len" kind of thing. That's fine - scatter-gather is pushed
downwards, and the upper layers do not even need to know about it. Which
is what layering is all about, after all.

Traditionally, a "bh" is only _used_ for small areas, but that's not a
"bh" issue, that's a memory management issue. The code should pretty much
handle the issue of a single 64kB bh pretty much as-is, but nothing
creates them: the VM layer only creates bh's in sizes ranging from 512
bytes to a single page.

The IO layer could do more, but there has yet to be anybody who needed
more (becase once you hit a page-size, you tend to get into
scatter-gather, so you want to have one bh per area - and let the
low-level IO level handle the actual merging etc).

Right now, on many normal setups, the thing that limits our ability to do
big IO requests is actually the fact that IDE cannot do more than 128kB
per request, for example (256 sectors). It's not the bh's or the VM layer.

If you want to make a "raw disk device", you can do so TODAY with bh's.
How? Don't use "bread()" (which allocates the backing store and creates
the cache). Allocate a separate anonymous bh (or multiple), and set them
up to point to whatever data source/sink you have, and let it rip. All
asynchronous. All with nice completion callbacks. All with existing code,
no kiobuf's in sight.

What more do you think your kiobuf's should be able to do?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
