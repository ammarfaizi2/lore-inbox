Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276997AbRJCVnS>; Wed, 3 Oct 2001 17:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276998AbRJCVnJ>; Wed, 3 Oct 2001 17:43:09 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:7324 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S276997AbRJCVmx>;
	Wed, 3 Oct 2001 17:42:53 -0400
Date: Wed, 3 Oct 2001 17:43:18 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Vladimir V. Saveliev" <vs@namesys.com>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com
Subject: Re: [PATCH] Re: bug? in using generic read/write functions to
 read/write block devices  in 2.4.11-pre2
In-Reply-To: <Pine.LNX.4.33.0110030916530.9427-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0110031643130.23558-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Oct 2001, Linus Torvalds wrote:

> 
> On Wed, 3 Oct 2001, Alexander Viro wrote:
> >
> > Ehh... Linus, both blkdev_get() and blkdev_open() should set ->i_blkbits.
> 
> Duh. I couldn't even _imagine_ that we'd be so stupid to have duplicated
> that code twice instead of just having blkdev_open() call blkdev_get().

Notice that (inode, file) is bogus API for block_device ->open().
I've checked all instances of that method in 2.4.11-pre2.  Results:
The _only_ part of inode they are using is ->i_rdev.  Read-only.
They use file->f_flags and file->f_mode (also read-only).

There are 3 exceptions:
	1) initrd sets file->f_op.  The whole thing is a dirty hack - it
should become a character device in 2.5.
	2) drivers/s390/char/tapeblock.c does bogus (and useless) stuff with
file, including putting pointer to it into global structures. Since file can
be fake (allocated on stack of caller) it's hardly a good idea. Fortunately,
driver doesn't ever look at that pointer.  Ditto for the rest of bogus
stuff done there - it's a dead code.
	3) drivers/block/floppy.c calls permission(inode) and caches result
in file->private_data.

Summary on the floppy case:  Alain uses "we have write permissions on
/dev/fd<n>" as a security check in several ioctls.  The reason why
we can't just check that file had been opened for write is that floppy_open()
will refuse to open the thing for write if it's write-protected.

Notice that we could trivially move the check into fd_ioctl() itself -
permission() is fast in all relevant cases and it's definitely much faster
than operations themselves (we are talking about honest-to-$DEITY
PC floppy controller here).  That wouldn't require any userland changes.

In other words, for all we care it's (block_device, flags, mode).  And
that makes a lot of sense, since we don't _have_ file in quite a few
cases.  Moreover, we don't care what inode is used for open - access control
is done in generic code, same way as for _any_ open().  Notice that even
floppy_open() extra checks do not affect the success of open() - we just
cache them for future calls of ioctl().

Moreover, ->release() for block_device also doesn't care for the junk
we pass - it only uses inode->i_rdev.  In all cases.  And I'd rather
see it them as
	int (*open)(struct block_device *bdev, int flags, int mode);
	int (*release)(struct block_device *bdev);
	int (*check_media_change)(struct block_device *bdev);
	int (*revalidate)(struct block_device *bdev);
- that would make more sense than the current variant.  They are block_device
methods, not file or inode ones, after all.

