Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261509AbRENFQY>; Mon, 14 May 2001 01:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262007AbRENFQO>; Mon, 14 May 2001 01:16:14 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:11928 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S261509AbRENFQC>; Mon, 14 May 2001 01:16:02 -0400
Date: Sun, 13 May 2001 23:15:58 -0600
Message-Id: <200105140515.f4E5FwP10245@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
In-Reply-To: <Pine.LNX.4.21.0105132139590.21224-100000@penguin.transmeta.com>
In-Reply-To: <200105140224.f4E2OiE08257@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.21.0105132139590.21224-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
> 
> On Sun, 13 May 2001, Richard Gooch wrote:
> > 
> > Think about it:-) You need to generate prefetch accesses in ascending
> > device bnum order.
> 
> I seriously doubt it is worth it.
> 
> Th ekernel will do the ordering for you anyway: that's what the
> elevator is, and that's why you have a "prefetch" system call (to
> avoid the synchronization that kills the elevator). And you'll end
> up wanting to pre-fetch on virtual addresses, which implies that you
> have to open the files: I doubt you want to have tons of files open
> and try to get a "global" order.

OK, provided the prefetch will queue up a large number of requests
before starting the I/O. If there was a way of controlling when the
I/O actually starts (say by having a START flag), that would be ideal,
I think.

> But sure, you can use bmap if you want. It would be interesting to
> hear whether it makes much of a difference..

I doubt bmap() would make any difference if there is a way of
controlling when the I/O starts.

However, this still doesn't address the issue of indirect blocks. If
the indirect block has a higher bnum than the data blocks it points
to, you've got a costly seek. This is why I'm still attracted to the
idea of doing this at the block device layer. It's easy to capture
*all* accesses and then warm the buffer cache.

So, why can't the page cache check if a block is in the buffer cache?

> > Sure, this would work too. I'm a bit worried about the increased
> > amount of traffic this will generate.
> 
> No increased traffic. "path" is a pointer (to a dentry), ie 32
> bits. "ino" is at least 128 bits on some filesystems. You make for _less_
> data to save.
> 
> > So on every page fault or read(2) call, we have to generate the full
> > path from the dentry? Isn't that going to add a fair bit of overhead?
> 
> You just save the dentry pointer. You do the path _later_, when
> somebody reads it away from the /proc file.

That opens up a nasty race: if the dentry is released before the
pointer is harvested, you get a bogus pointer.

> > I don't see the advantage of the prefetch(2) system call. It seems to
> > me I can get the same effect by just making read(2) calls in another
> > task. Of course, I'd need to use bmap() to generate the sort key, but
> > I don't see why that's a bad thing.
> 
> Try it. You won't be able to. "read()" is an inherently
> synchronizing operation, and you cannot get _any_ overlap with
> multiple reads, except for the pre-fetching that the kernel will do
> for you anyway.

How's that? It won't matter if read(2) synchronises, because I'll be
issuing the requests in device bnum order.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
