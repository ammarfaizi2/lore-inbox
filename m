Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261389AbRENEqm>; Mon, 14 May 2001 00:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261509AbRENEqd>; Mon, 14 May 2001 00:46:33 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:33807 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261389AbRENEqU>; Mon, 14 May 2001 00:46:20 -0400
Date: Sun, 13 May 2001 21:46:03 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
In-Reply-To: <200105140224.f4E2OiE08257@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.21.0105132139590.21224-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 13 May 2001, Richard Gooch wrote:
> 
> Think about it:-) You need to generate prefetch accesses in ascending
> device bnum order.

I seriously doubt it is worth it.

Th ekernel will do the ordering for you anyway: that's what the elevator
is, and that's why you have a "prefetch" system call (to avoid the
synchronization that kills the elevator). And you'll end up wanting to
pre-fetch on virtual addresses, which implies that you have to open the
files: I doubt you want to have tons of files open and try to get a
"global" order.

But sure, you can use bmap if you want. It would be interesting to hear
whether it makes much of a difference..

> > Why not just "path,pagenr" instead? You make your instrumentation save
> > away the whole pathname, by just using the dentry pointer. Many
> > filesystems don't even _have_ a "inum", so anything less doesn't work
> > anyway.
> 
> Sure, this would work too. I'm a bit worried about the increased
> amount of traffic this will generate.

No increased traffic. "path" is a pointer (to a dentry), ie 32
bits. "ino" is at least 128 bits on some filesystems. You make for _less_
data to save.

> So on every page fault or read(2) call, we have to generate the full
> path from the dentry? Isn't that going to add a fair bit of overhead?

You just save the dentry pointer. You do the path _later_, when somebody
reads it away from the /proc file.

> I don't see the advantage of the prefetch(2) system call. It seems to
> me I can get the same effect by just making read(2) calls in another
> task. Of course, I'd need to use bmap() to generate the sort key, but
> I don't see why that's a bad thing.

Try it. You won't be able to. "read()" is an inherently synchronizing
operation, and you cannot get _any_ overlap with multiple reads, except
for the pre-fetching that the kernel will do for you anyway.

And when it comes to IO and the elevator, overlap is where it
matters. Sending out several tagged commands to the disk in one go.

You'd have to have multiple processes doing the reads to get the same kind
of performance. Much easier to do "prefetch()", when that's really what
you want anyway.

Remember, you'r enot interested in the data. You're just populating the
cache.

			Linus

