Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316080AbSFPKd7>; Sun, 16 Jun 2002 06:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316088AbSFPKd6>; Sun, 16 Jun 2002 06:33:58 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:60863 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316080AbSFPKd5>;
	Sun, 16 Jun 2002 06:33:57 -0400
Date: Sun, 16 Jun 2002 06:33:58 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
In-Reply-To: <UTC200206160959.g5G9xtM29126.aeb@smtp.cwi.nl>
Message-ID: <Pine.GSO.4.21.0206160612160.3507-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 16 Jun 2002 Andries.Brouwer@cwi.nl wrote:

>     On Sun, 16 Jun 2002 Andries.Brouwer@cwi.nl wrote:
> 
>     > > Wrong.  That breaks for anything with ->follow_link() that
>     > > can't be expressed as a single lookup on some path.
>     > 
>     > I don't know what interesting out-of-tree filesystems you
>     > have in mind, but it looks like this would work for all
>     > systems in the current tree.
> 
>     Trivial counterexample: procfs.
> 
> That is trivially handled:
 
I've said "trivial counterexample" ;-)

> 	err = dentry->d_inode->i_op->prepare_follow_link(dentry, nd, &link, &page);
> 	if (nd->flags & FOLLOW_DONE)
> 		nd->flags &= ~FOLLOW_DONE;
> 	else if (err = 0)
> 		err = __vfs_follow_link(nd, link);
> 	if (page) {
> 		kunmap(page);
> 		page_cache_release(page);
> 	}
> 	...
> 	return err;
> }
> 
> You must come with more serious objections before I believe your
> claim that this doesn't work.

First of all, _that_ is still recursive.  And it's not easy to deal with -
you need to release the object holding the link body (BTW, that can
be almost anything - page, inode, kmalloc'ed area, vmalloc'ed area, etc.)
after __vfs_follow_link() is done.  And that means (at the very least)
a stack of such objects, along with the information about their nature.
Which exposes a lot of information about the filesystem guts - so much
that we are basically introducing a cookie created by your ->prepare_...()
and having a destructor of its own.

I'd implemented that variant about 3 years ago.  And it got vetoed by Linus -
for a very good reason.  It was too damn ugly, with more ugliness to come
as we add more filesystems.


>     Notice that your "permanent" data is not quite permanent - e.g.
>     information about partitioning can be lost (in all kernels since
>     2.0, if not earlier) at any moment when nobody has devices opened.
>     rmmod -a and there you go...
> 
>     IMO correct approach to such data is that it's generated on demand
>     (as it is right now - again, consider modular driver; then we don't
>     see _anything_ about devices until somebody attempts to open one
>     of them and triggers module loading)
> 
> Yes, when the disk is removed, or when the driver is removed
> it does not matter that information is lost.
> But it is very bad to generate a partition table on each open.
> Indeed, it is wrong.

D'oh.  Indeed it is wrong - not to mention anything else, if we keep it
over the lifetime of struct block_device, there is no possible reason
to recalculate it.  Sure thing, it's cached.  And stays cached until
we are either told that it needs to be reread (BLKRRPART or your ioctls)
or that device itself is gone or that we didn't have that device (or
any of its partitions) for a long time, all their page caches are evicted
from memory and memory pressure is so bad that we want to start dropping
ancient and long-unused struct block_device.

Normal case is that we read partition table once - on the first open().
Then it stays cached.
 
> User space can tell the kernel what the partitions are.

... And that's also cached.

> Opening a disk device must not destroy that information.

Sure - why would it?  If we already know where partition is - why would
we bother rereading that stuff?

> So some permanent info of the gendisk type is needed.

FSVO "permanent".  Basically, struct block_device of entire disk is
going to be a lot more long-living beast than it is right now...

