Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271978AbRIIOrF>; Sun, 9 Sep 2001 10:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271977AbRIIOq4>; Sun, 9 Sep 2001 10:46:56 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:30002 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271978AbRIIOqv>; Sun, 9 Sep 2001 10:46:51 -0400
Date: Sun, 9 Sep 2001 16:47:38 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: linux-2.4.10-pre5
Message-ID: <20010909164738.T11329@athlon.random>
In-Reply-To: <20010909061620.O11329@athlon.random> <Pine.LNX.4.33.0109082115270.1161-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109082115270.1161-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Sep 08, 2001 at 09:28:43PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 08, 2001 at 09:28:43PM -0700, Linus Torvalds wrote:
> 
> On Sun, 9 Sep 2001, Andrea Arcangeli wrote:
> 
> > On Sat, Sep 08, 2001 at 08:58:26PM -0700, Linus Torvalds wrote:
> > > I'd rather fix that, then.
> >
> > we'd just need to define a new kind of communication API between a ro
> > mounted fs and the blkdev layer to avoid the special cases.
> 
> No, notice how the simple code _should_ work for ro-mounted filesystems
> as-is. AND it should work for read-only opens of disks with rw-mounted

correct.

> filesystems. The only case it doesn't like is the "rw-open of a device
> that is rw-mounted".

it also doesn't work for ro-open of a device that is rw-mounted, hdparm
-t as said a million of times now.

> It's only filesystems that have modified buffers without marking them
> dirty (by virtue of having pointers to buffers and delaying the dirtying
> until later) that are broken by the "try to make sure all buffers are
> up-to-date by reading them in" approach.

All filesystems marks the buffers dirty after modifying them. The
problem is that they don't always lock_buffer(); modify ; mark_dirty();
unlock_buffer(), so we cannot safely do the update-I/O from disk to
buffer cache on the pinned buffers or we risk to screwup the
filesystem while it's in the "modify; mark_dirty()" part.

> And as I don't think the concurrent "rw-open + rw-mount" case makes any
> sense, I think the sane solution is simply to disallow it completely.

I don't disallow it, I just don't guarantee coherency after that, the fs
could be screwedup if you rw-open + rw-mount and that's ok.

the case where it is not ok is hdparm: ro-open + rw-mounted.

> So if we simply disallow that case, then we do not have any problem:
> either the device was opened read-only (in which case it obviously doesn't
> need to flush anything to disk, or invalidate/revalidate existing disk

Then you are making a special case "the device was opened read-only in
which case it obviously doesn't need to flush anything to disk" means
you are not running the update_buffers() if the open was O_RDONLY (if
you make this special case you would be safe on that side).  But also
the user may do O_RDWR open and not modify the device, and still we must
not screwup a rw-mountd fs under it.

as far I can tell my synchronization code is the simpler possible and
it's completly safe, without changing the synchronization API with the
pinned buffers, or without making getblk to be backed on the blkdev
pagecache enterely that has larger impact on the kernel.

Making getblk to be blkdev pagecache backed seems the cleaner way to get
rid of those aliasing issues to be allowed to just limit the very latest
close to a __block_fsync + truncate_inode_pages() [which is a 5 lines
cleanup compared to my current state of the patch], with it not even the
last blkdev release will run the block_fsync since the fs still holds a
reference on the same side, the fs will be just another blkdev user like
if it came from userspace. However this logic is potentially more
invasive than the blkdev-pagecache code that matters and it doesn't
provide a single advantage to the user, so this isn't in my top list at
the moment, sounds 2.5 cleanup material.

Andrea
