Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271791AbRIHR44>; Sat, 8 Sep 2001 13:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271792AbRIHR4q>; Sat, 8 Sep 2001 13:56:46 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:11857 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271791AbRIHR4j>; Sat, 8 Sep 2001 13:56:39 -0400
Date: Sat, 8 Sep 2001 19:57:30 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: linux-2.4.10-pre5
Message-ID: <20010908195730.D11329@athlon.random>
In-Reply-To: <20010908191954.C11329@athlon.random> <Pine.LNX.4.33.0109081028390.936-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109081028390.936-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Sep 08, 2001 at 10:30:30AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 08, 2001 at 10:30:30AM -0700, Linus Torvalds wrote:
> That said, if you'll give a description of how you fixed the aliasing
> issues etc, maybe I'd be less nervous. Putting it in the page cache is

First of all I just __block_fsync + truncate_inode_pages(inode->i_mapping, 0) so
all pagecache updates are commited to disk after that, so the latest uptodate
data is on disk and nothing uptodate is in memory. 

If we have the fs mounted under us that seems mounted read only [I don't
even try to synchronize if the fs was mounted rw] I invalidate_device to
possibly shrink its higher level caches as well (this call is non
destructive so it's safe, it's just for sanity), then I lock_super [to
synchronize against the ->remount that could otherwise remount the
device rw under me], I recheck the fs is still read only with the super
lock acquired and if it still is I do the real work (aka
update_buffers).

Let's see the update_buffers in detail:

[..]
#define update_buffers(dev)			\
do {						\
	__invalidate_buffers((dev), 0, 1);	\
	__invalidate_buffers((dev), 0, 2);	\
} while (0)
[..]
   For handling cache coherency with the blkdev pagecache the 'update' case
   is been introduced. It is needed to re-read from disk any pinned
   buffer. NOTE: re-reading from disk is destructive so we can do it only
   when we assume nobody is changing the buffercache under our I/O and when
   we think the disk contains more recent information than the buffercache.
   The update == 1 pass marks the buffers we need to update, the update == 2
   pass does the actual I/O. */
void __invalidate_buffers(kdev_t dev, int destroy_dirty_buffers, int update)
[..]

What update_buffers does is to identify the pinned buffers in the buffercache
and to re-read them from disk under the filesystem (we know the filesystem is
mounted readonly so we can [modulo that the fs gets confused if it sees non
coherent information while we do the update, but with the user app writing to
the buffercache directly things were even worse due the potentially larger
window of time for the race to trigger so it's certainly acceptable as far as
current code is acceptable too]).

another quite brainer part of the patch [non described here] is the cache
pagecache sharing from different inodes:

	mknod hda .. A B ..
	mknod hda.new .. A B ..

then start using hda and hda.new at the same time and have them share the same
pagecache, and that case is been take care of too.

Andrea
