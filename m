Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131563AbQL3WRg>; Sat, 30 Dec 2000 17:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131568AbQL3WR0>; Sat, 30 Dec 2000 17:17:26 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:29603 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131563AbQL3WRL>;
	Sat, 30 Dec 2000 17:17:11 -0500
Date: Sat, 30 Dec 2000 16:46:32 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
In-Reply-To: <Pine.LNX.4.10.10012301214210.1017-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0012301628120.4082-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Dec 2000, Linus Torvalds wrote:

> 
> 
> On Sat, 30 Dec 2000, Alexander Viro wrote:
> > 
> > Except that we've got file-expanding writes outside of ->i_sem. Thanks, but
> > no thanks.
> 
> No, Al, the file size is still updated inside i_sem.

Then we are screwed. Look: we call write(). Twice. The second call happens
to overflow the quota. Getting the second chunk of data written and the
first one ending up as a hole is the last thing you would expect, isn't it?

> In short, I don't see _those_ kinds of issues. I do see error reporting as
> a major issue, though. If we need to do proper low-level block allocation
> in order to get correct ENOSPC handling, then the win from doing deferred
> writes is not very big.

Well, see above. I'm pretty nervous about breaking the ordering of metadata
allocation. For pageout() we don't have such ordering. For write() we
certainly do. Notice that reserving disk space upon write() and eating it
later is _very_ messy job - you'll have to take care of situations when
we reserve the space upon write() and get pageout do the real allocation.
Not nice, since pageout has no way in hell to tell whether it is eating
from a reserved area or just flushing the mmaped one. We could keep the
per-bh "reserved" flag to fold that information into the pagecache, but
IMO it's simply not worth the trouble. If some filesystems wants that -
hey, it can do that right now. Just make ->prepare_write() do reservations
and let ->commit_write() mark the page dirty. Then ->writepage() will
eventually flush it.

Again, if one is willing to implement reservation on block level - fine,
there is no need to change anything in VFS or VM. I certainly don't want
to mess with that, but hey, if somebody is into masochism - let them.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
