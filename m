Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262471AbRENURc>; Mon, 14 May 2001 16:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262472AbRENURM>; Mon, 14 May 2001 16:17:12 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:21779 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262471AbRENURE>; Mon, 14 May 2001 16:17:04 -0400
Date: Mon, 14 May 2001 13:16:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
In-Reply-To: <200105140515.f4E5FwP10245@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.31.0105141301120.22874-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 13 May 2001, Richard Gooch wrote:
>
> OK, provided the prefetch will queue up a large number of requests
> before starting the I/O. If there was a way of controlling when the
> I/O actually starts (say by having a START flag), that would be ideal,
> I think.

Ehh. The "start" flag is when you actually start reading, or when you've
prefetched so much that the queue has filled up. That's the behaviour
you'd get naturally, and it's the behaviour you want.

> So, why can't the page cache check if a block is in the buffer cache?

Because it would make the damn thing slower.

The whole point of the page cache is to be FAST FAST FAST. The reason we
_have_ a page cache is that the buffer cache is slow and inefficient, and
it will always remain so.

We want to get _away_ from the buffer cache, not add support for a legacy
cache into the new and more efficient one.

And remember: when raw devices are in the page cache, you simply WILL NOT
HAVE a buffer cache at all.

Just stop this line of thought. It's not going anywhere.

> That opens up a nasty race: if the dentry is released before the
> pointer is harvested, you get a bogus pointer.

..which is why you increment the dentry count when you profile it, and
decrement it when you have output the path...

> > Try it. You won't be able to. "read()" is an inherently
> > synchronizing operation, and you cannot get _any_ overlap with
> > multiple reads, except for the pre-fetching that the kernel will do
> > for you anyway.
>
> How's that? It won't matter if read(2) synchronises, because I'll be
> issuing the requests in device bnum order.

Ehh.. You don't seem to know how disks work.

By the time you follow up with the next "read", the platter will probably
have rotated past the point you want to read. You need to have multiple
outstanding requests (or _biiig_ requests) to get close to platter speed.

[ Aside: with most IDE stuff doing extensive track buffering, you won't
  see this as much. It depends on the disk, the cache size, and the
  buffering characteristics. ]

		Linus

