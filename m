Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131397AbRAAESI>; Sun, 31 Dec 2000 23:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131507AbRAAER7>; Sun, 31 Dec 2000 23:17:59 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:25075 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131397AbRAAERn>;
	Sun, 31 Dec 2000 23:17:43 -0500
Date: Sun, 31 Dec 2000 22:47:00 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Roman Zippel <zippel@fh-brandenburg.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
In-Reply-To: <Pine.GSO.4.10.10101010332330.1050-100000@zeus.fh-brandenburg.de>
Message-ID: <Pine.GSO.4.21.0012312220290.7648-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Jan 2001, Roman Zippel wrote:

> I just rechecked that, but I don't see no superblock lock here, it uses
> the kernel_lock instead. Although Al could give the definitive answer for
> this, he wrote it. :)

No superblock lock in get_block() proper. Tons of it in the dungheap called
balloc.c. _That's_ where the bottleneck is. BTW, even BKL is easily removable
from get_block() - check /* Reader: */ and /* Writer: */ comments, they mark
the places to put spinlock in.

> > The way the Linux MM works, if the lower levels need to do buffer
> > allocations, they will use GFP_BUFFER (which "bread()" does internally),
> > which will mean that the VM layer will _not_ call down recursively to
> > write stuff out while it's already trying to write something else. This is
> > exactly so that filesystems don't have to release and re-try if they don't
> > want to.
> > 
> > In short, I don't see any of your arguments.
> 
> Then I must have misunderstood Al. Al?
> If you were right here, I would see absolutely no reason for the current
> complexity. (Me is a bit confused here.)

Reread the original thread. GFP_BUFFER protects us from buffer cache
allocations triggering pageouts. It has nothing to the deadlock scenario
that would come from grabbing ->i_sem on pageout.

Sheesh... "Complexity" of ext2_get_block() (down to the ext2_new_block()
calls) is really, really not a problem. Normally it just gives you the
straightforward path. All unrolls are for contention cases and they
are precisely what we have to do there.

Again, scalability problems are in the block allocator, not in the
indirect blocks handling. It's completely independent from get_block().
We overlock. Big way. And the structures we are protecting excessively
are:
	* cylinder group descriptors
	* block bitmaps
	* (to less extent) inode bitmaps and inode table.
That's what needs to be fixed. It has nothing to VFS or VM - purely
internal ext2 business.

Another ext2 issue is reducing the buffer cache pressure - mostly by
moving the directories into page cache. I've posted such patches on
fsdevel and they are applied to the kernel I'm running here. Works
like a charm and allows the rest of metadata stay in cache longer.

GFP_BUFFER _may_ become an issue if we move bitmaps into pagecache.
Then we'll need a per-address_space gfp_mask. Again, patches exist
and had been tested (not right now - I didn't port them to current
tree yet). Bugger if I remember whether they were posted or not - they've
definitely had been mentioned on linux-mm, but IIRC I had sent the
modifications of VM code only to Jens. I can repost them.

Some pieces of balloc.c cleanup had been posted on fsdevel. Check the
archives. They prepare the ground for killing lock_super() contention
on ext2_new_inode(), but that part wasn't there back then.

I will start -bird (aka FS-CURRENT) branch as soon as Linus opens 2.4.
Hopefully by the time of 2.5 it will be tested well enough. Right now
it exists as a large patchset against more or less recent -test<n> and
I'm waiting for slowdown of the changes in main tree to put them all
together.
							Cheers,
								Al

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
