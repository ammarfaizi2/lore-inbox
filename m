Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129906AbRBGShn>; Wed, 7 Feb 2001 13:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129890AbRBGShe>; Wed, 7 Feb 2001 13:37:34 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:47365 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129879AbRBGShY>; Wed, 7 Feb 2001 13:37:24 -0500
Date: Wed, 7 Feb 2001 10:36:47 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@ns.caldera.de>
cc: Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <20010207192622.A23859@caldera.de>
Message-ID: <Pine.LNX.4.10.10102071032390.4623-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Feb 2001, Christoph Hellwig wrote:

> On Tue, Feb 06, 2001 at 12:59:02PM -0800, Linus Torvalds wrote:
> > 
> > Actually, they really aren't.
> > 
> > They kind of _used_ to be, but more and more they've moved away from that
> > historical use. Check in particular the page cache, and as a really
> > extreme case the swap cache version of the page cache.
> 
> Yes.  And that exactly why I think it's ugly to have the left-over
> caching stuff in the same data sctruture as the IO buffer.

I do agree.

I would not be opposed to factoring out the "pure block IO" part from the
bh struct. It should not even be very hard. You'd do something like

	struct block_io {
		.. here is the stuff needed for block IO ..
	};

	struct buffer_head {
		struct block_io io;
		.. here is the stuff needed for hashing etc ..
	}

and then you make "generic_make_request()" and everything lower down take
just the "struct block_io".

You'd still leave "ll_rw_block()" and "submit_bh()" operating on bh's,
because they knoa about bh semantics (ie things like scaling the sector
number to the bh size etc). Which means that pretty much all the code
outside the block layer wouldn't even _notice_. Which is a sign of good
layering.

If you want to do this, please do go ahead.

But do realize that this is not exactly a 2.4.x thing ;)

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
