Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130869AbRBEQhE>; Mon, 5 Feb 2001 11:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131004AbRBEQgy>; Mon, 5 Feb 2001 11:36:54 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:53001 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130869AbRBEQgi>; Mon, 5 Feb 2001 11:36:38 -0500
Date: Mon, 5 Feb 2001 08:36:31 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Christoph Hellwig <hch@caldera.de>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
 /notify + callback chains
In-Reply-To: <20010205110336.A1167@redhat.com>
Message-ID: <Pine.LNX.4.10.10102050826440.30798-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Feb 2001, Stephen C. Tweedie wrote:
> 
> On Sat, Feb 03, 2001 at 12:28:47PM -0800, Linus Torvalds wrote:
> > 
> > Neither the read nor the write are page-aligned. I don't know where you
> > got that idea. It's obviously not true even in the common case: it depends
> > _entirely_ on what the file offsets are, and expecting the offset to be
> > zero is just being stupid. It's often _not_ zero. With networking it is in
> > fact seldom zero, because the network packets are seldom aligned either in
> > size or in location.
> 
> The underlying buffer is.  The VFS (and the current kiobuf code) is
> already happy about IO happening at odd offsets within a page.

Stephen. 

Don't bother even talking about this. You're so damn hung up about the
page cache that it's not funny.

Have you ever thought about other things, like networking, special
devices, stuff like that? They can (and do) have packet boundaries that
have nothing to do with pages what-so-ever. They can have such notions as
packets that contain multiple streams in one packet, where it ends up
being split up into several pieces. Where neither the original packet
_nor_ the final pieces have _anything_ to do with "pages".

THERE IS NO PAGE ALIGNMENT.

So stop blathering about it.

Of _course_ the current kiobuf code has page-alignment assumptions. You
_designed_ it that way. So bringing it up as an example is a circular
argument. And a really stupid one at that, as that's the thing I've been
quoting as the single biggest design bug in all of kiobufs. It's the thing
that makes them entirely useless for things like describing "struct
msghdr" etc. 

We should get _away_ from this page-alignment fallacy. It's not true. It's
not necessarily even true for the page cache - which has no real
fundamental reasons any more for not being able to be a "variable-size"
cache some time in the future (ie it might be a per-address-space decision
on whether the granularity is 1, 2, 4 or more pages).

Anything that designs for "everything is a page" will automatically be
limited for cases where you might sometimes have 64kB chunks of data.

Instead, just face the realization that "everything is a bunch or ranges",
and leave it at that. It's true _already_ - thing about fragmented IP
packets. We may not handle it that way completely yet, but the zero-copy
networking is going in this direction.

And as long as you keep on harping about page alignment, you're not going
to play in this game. End of story. 

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
