Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262574AbRENXU1>; Mon, 14 May 2001 19:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262573AbRENXUR>; Mon, 14 May 2001 19:20:17 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:61081 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262570AbRENXUC>; Mon, 14 May 2001 19:20:02 -0400
Date: Mon, 14 May 2001 17:19:51 -0600
Message-Id: <200105142319.f4ENJpf19203@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
In-Reply-To: <Pine.LNX.4.31.0105141301120.22874-100000@penguin.transmeta.com>
In-Reply-To: <200105140515.f4E5FwP10245@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.31.0105141301120.22874-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
> 
> 
> On Sun, 13 May 2001, Richard Gooch wrote:
> >
> > OK, provided the prefetch will queue up a large number of requests
> > before starting the I/O. If there was a way of controlling when the
> > I/O actually starts (say by having a START flag), that would be ideal,
> > I think.
> 
> Ehh. The "start" flag is when you actually start reading,

That would be OK.

> > So, why can't the page cache check if a block is in the buffer cache?
> 
> Because it would make the damn thing slower.
> 
> The whole point of the page cache is to be FAST FAST FAST. The
> reason we _have_ a page cache is that the buffer cache is slow and
> inefficient, and it will always remain so.

Is there some fundamental reason why a buffer cache can't ever be
fast?

> We want to get _away_ from the buffer cache, not add support for a legacy
> cache into the new and more efficient one.
> 
> And remember: when raw devices are in the page cache, you simply WILL NOT
> HAVE a buffer cache at all.
> 
> Just stop this line of thought. It's not going anywhere.

I'm just going back to it because I don't see how we can otherwise
handle this case:
- inode at block N
- indirect block at N+k+j
- data block at N+k

and have the prefetch read blocks N, N+k and N+k+j in that order.
Reading them via the FS will result in two seeks, because we need to
read N before we know to read N+k+j, and we need to read N+k+j before
we know to read N+k.

Doing the work at the block device layer makes this simple. However,
if there was a way of doing this at the page cache level, then I'd be
happy.

> > > Try it. You won't be able to. "read()" is an inherently
> > > synchronizing operation, and you cannot get _any_ overlap with
> > > multiple reads, except for the pre-fetching that the kernel will do
> > > for you anyway.
> >
> > How's that? It won't matter if read(2) synchronises, because I'll be
> > issuing the requests in device bnum order.
> 
> Ehh.. You don't seem to know how disks work.
> 
> By the time you follow up with the next "read", the platter will
> probably have rotated past the point you want to read. You need to
> have multiple outstanding requests (or _biiig_ requests) to get
> close to platter speed.

Sure, I know about rotational latency. I'm counting on read-ahead.

> [ Aside: with most IDE stuff doing extensive track buffering, you won't
>   see this as much. It depends on the disk, the cache size, and the
>   buffering characteristics. ]

These days, even IDE drives come with 2 MiB of cache or more.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
