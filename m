Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbQLaNgq>; Sun, 31 Dec 2000 08:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbQLaNgg>; Sun, 31 Dec 2000 08:36:36 -0500
Received: from baldur.fh-brandenburg.de ([195.37.0.5]:26859 "HELO
	baldur.fh-brandenburg.de") by vger.kernel.org with SMTP
	id <S129324AbQLaNg2>; Sun, 31 Dec 2000 08:36:28 -0500
Date: Sun, 31 Dec 2000 13:58:33 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrea Arcangeli <andrea@suse.de>,
        "Eric W. Biederman" <ebiederman@uswest.net>,
        Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
In-Reply-To: <Pine.LNX.4.10.10012301816410.1743-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.10.10012311256180.19210-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 30 Dec 2000, Linus Torvalds wrote:

> In fact, in a properly designed filesystem just a bit of low-level caching
> would easily make the average "get_block()" be very fast indeed. The fact
> that right now ext2 has not been optimized for this is _not_ a reason to
> design the VFS layer around a slow get_block() operation.
> [..]
> The second point is completely different, and THIS is where I think there
> are potentially real advantages. However, I also think that this is not
> actually about deferred writes at all: it's really a question of the
> filesystem having access to the page when the physical write is actually
> started so that the filesystem might choose to _change_ the allocation it
> did - it might have allocated a backing store block at "get_block()" time,
> but by the time it actually writes the stuff out to disk it may have
> allocated a bigger contiguous area somewhere else for the data..
> 
> I really think that the #2 thing is the more interesting one, and that
> anybody looking at ext2 should look at just improving the locking and
> making the block allocation functions run faster. Which should not be all
> that difficult - the last time I looked at the thing it was quite
> horrible.

What makes get_block business complicated now, is that can be called
recursively: get_block needs to allocate something, what might start new
i/o which calls again get_block.
Writing dirty pages should be a real asynchronous process, but it isn't
right now, as get_block is synchronous. Making get_block asynchronous is
almost impossible, so one usually does it in a separate thread.
So IMO something like this should happen: dirty pages should be put on a
separate list and a thread takes these pages and allocates the buffers for
them and starts the i/o. This had another advantage: get_block wouldn't
really need to do preallocation anymore, the get_block function could work
instead on a number of pages (preallocation would instead happen in the
page cache).
This could make the get_block function and the needed locking very simple, 
e.g. one could use a simple semaphore instead of kernel_lock to protect
getting of multiple blocks instead of only one. Also splitting it into
several tasks can make it faster, so in one step we just do the resource
allocation to guarantee the write, in a separate step we do the real
allocation. If this is done for several pages at once, it can be very 
fast and simple.

bye, Roman

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
