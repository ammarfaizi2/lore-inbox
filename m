Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135667AbRBET3J>; Mon, 5 Feb 2001 14:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135668AbRBET27>; Mon, 5 Feb 2001 14:28:59 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:54801 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135667AbRBET2r>; Mon, 5 Feb 2001 14:28:47 -0500
Date: Mon, 5 Feb 2001 11:28:17 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Christoph Hellwig <hch@caldera.de>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <E14Pr8G-0003zV-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10102051118210.31206-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Feb 2001, Alan Cox wrote:

> > Stop this idiocy, Stephen. You're _this_ close to be the first person I
> > ever blacklist from my mailbox. 
> 
> I think I've just figured out what the miscommunication is around here
> 
> kiovecs can describe arbitary scatter gather

I know. But they are entirely useless for anything that requires low
latency handling. They are big, bloated, and slow. 

It is also an example of layering gone horribly horribly wrong.

The _vectors_ are needed at the very lowest levels: the levels that do not
necessarily have to worry at all about completion notification etc. You
want the arbitrary scatter-gather vectors passed down to the stuff that
sets up the SG arrays etc, the stuff that doesn't care AT ALL about the
high-level semantics.

This all proves that the lowest level of layering should be pretty much
noting but the vectors. No callbacks, no crap like that. That's already a
level of abstraction away, and should not get tacked on. Your lowest level
of abstraction should be just the "area". Something like

	struct buffer {
		struct page *page;
		u16 offset, length;
	};

	int nr_buffers:
	struct buffer *array;

should be the low-level abstraction. 

And on top of _that_ you build a more complex entity (so a "kiobuf" would
be defined not just by the memory area, but by the operation you want to
do on it, adn the callback on completion etc).

Currently kiobufs do it the other way around: you can build up an array,
but only by having the overhead of passing kiovec's around - ie you have
to pass the _highest_ level of abstraction around just to get the lowest
level of details. That's wrong.

And that wrongness comes _exactly_ from Stephens opinion that the
fundamental IO entity is an array of contiguous pages. 

And, btw, this is why the networking layer will never be able to use
kiobufs.

Which makes kiobufs as they stand now basically useless for anything but
some direct disk stuff. And I'd rather work on making the low-level disk
drivers use something saner.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
