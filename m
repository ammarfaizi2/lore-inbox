Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276743AbRKFB25>; Mon, 5 Nov 2001 20:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276832AbRKFB2r>; Mon, 5 Nov 2001 20:28:47 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:44231 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S276743AbRKFB2e>;
	Mon, 5 Nov 2001 20:28:34 -0500
Date: Mon, 5 Nov 2001 20:28:32 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] disk throughput
In-Reply-To: <Pine.LNX.4.33.0111051543440.15533-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0111052006040.27086-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Nov 2001, Linus Torvalds wrote:

> Fast-growth is what we should care about from a performance standpoint -
> slow growth can be sanely handled with slower-paced maintenance issues
> (including approaches like "defragment the disk once a month").

Ehh...  Slow growth can involve a _lot_ of IO and file creation/removal,
just no directory tree changes.
 
> By definition, "slow growth" is amenable to defragmentation. And by
> definition, fast growth isn't. And if we're talking about speedups on the
> order of _five times_ for something as simple as a "cvs co", I don't see
> where your "pure hell" comes in.

Take a look at the allocator for non-directory inodes.

> A five-time slowdown on real work _is_ pure hell. You've not shown a
> credible argument that the slow-growth behaviour would ever result in a
> five-time slowdown for _anything_.

find(1).  Stuff that runs every damn night.  We end up doing getdents() +
bunch of lstat() on the entries we had found.  And that means access to
inodes refered from them.  Try that on a large directory with child
inodes spread all over the disk.

Linus, I'm not saying that fast-growth scenario doesn't need to be handled
or that 5 times slowdown on cvs co is OK.  We need a decent heuristics to
distinguish between the slow and fast variants.  BTW, the problem is not
new or Linux-specific.  IIRC, there was a couple of papers by folks who
gathered real-life traces of allocations/freeing of objects on different
boxen and had ran them through several allocators.  I'll try to locate that
stuff and see if we can get to their raw data.  OK?  I'd really like to
have something beyond "current allocator sucks for fast-growth" to deal
with - especially if we start inventing heuristics for switching between
the fast and slow modes.

