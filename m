Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135927AbREIJOP>; Wed, 9 May 2001 05:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135941AbREIJOG>; Wed, 9 May 2001 05:14:06 -0400
Received: from [195.63.194.11] ([195.63.194.11]:59660 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S135927AbREIJN7>; Wed, 9 May 2001 05:13:59 -0400
Message-ID: <3AF90A3D.7DD7A605@evision-ventures.com>
Date: Wed, 09 May 2001 11:13:33 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org, "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>, Jens Axboe <axboe@suse.de>
Subject: Re: blkdev in pagecache
In-Reply-To: <20010509043456.A2506@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

> (btw, also the current rawio uses a 512byte bh->b_size granularity that is even
> worse than the 1024byte b_size of the blkdev, O_DIRECT is much smarter
> on this side as it uses the softblocksize of the fs that can be as well
> 4k if you created the fs with -b 4096)

Amen to this.... the differentation bitween blksize_size and
hardsect_size in
linux is:
a) not quite usefull, since blksize_size isn't in reality a property of
the
device but more a property of the actually mounted file system.
b) very confusing... see my last patch about the RaiserFS and please
have a look at the AS390 code, which basically got *very* confused about
the sematics of blksize_size()

> I'll describe here some of the details of the blkdev-pagecache-1 patch:
> 
> - /dev/raw* and drivers/char/raw.c gets obsoleted and replaced by

HURRA! Great stuff!

>   opening the blkdevice with O_DIRECT, it looks much saner and I
>   basically get it for free by just implementing 10 lines of the
>   blkdev_direct_IO callback, of course I didn't removed the /dev/raw*
>   API for compatibility.

PLEASE REMOVE IT AS SOON AS POSSIBLE! It's an really insane API just for
ORACLE tuning, and well most oracle deployers don't run on /dev/raw* at
least not under Linux, where it basically doesn't give you any reall
performance gains... Or at least one could amke /dev/raw* a configure
option and
a module
 
> - I force the virtual blocksize for all the blkdev I/O
>   (buffered and direct) to work with a 4096 bytes granularity instead of

You mean PAGE_SIZE :-).

>   the current 1024 softblocksize because we need that for getting higher
>   performance, 1024 is too low because it wastes too much ram and too
>   much cpu. So a DBMS won't be able anymore to write 512bytes to the

Exactly, please see my former explanation... BTW.> If you are gogin into
the range of PAGE_SIZE, it may be very well possible to remove the
whole page associated mechanisms of a buffer_head?

>   disk using rawio being sure it will be a single atomic block update.
>   If you use /dev/raw nothing changed of course, only opening blkdev
>   with O_DIRECT enforce a minimal granularity of 4096 bytes in the I/O.
>   I don't think this is a problem, and also O_DIRECT through the fs was
>   just using the fs softblocksize instead of the hardblocksize as unit
>   of the minimal direct-IO granularity.
> 
> - writes to the blockdevice won't end in the buffer cache, so it will
>   be impossible to update the superblock of an ext2 partition mounted ro
>   for example, it must not be mounted at all to update the superblock, I
>   will need to invent an hack to fix this problem or it will get too
>   annoying. One way could simply to change ext2 and have it checking
>   the buffer to be uptodate before marking it dirty again but maybe
>   we could also do it in a generic manner that fixes all the fs at once
>   (OTOH probably not that many fs needs to be fscked online...).
> 
> - mmap should be functional but it's totally untested.
> 
> - currently the last `harddisk_size & 4095' bytes (if any) won't be
>   accessible via the blkdev, to avoid sending to the hardware requests
>   beyond the end of the device. Not sure how/if to solve this. But this is
>   definitely not a new issue, the same thing happens today in 2.2 and
>   2.4 after you mount a 4k filesystem on a blockdevice. OTOH I'm scared
>   a mke2fs -b 1024 could get confused. But I really don't want to
>   decrease the b_size of the buffer header even if we fix this.

Basically this is something which should come down to the strategy
routine
of the corresponding device and be fixed there... And then we have this
gross 
blk_size check in ll_rw_block.c ....

Some notes about the code:

 	kdev_t dev = inode->i_rdev;
-	struct buffer_head * bh, *bufferlist[NBUF];
-	register char * p;
+	int err;
 
-	if (is_read_only(dev))
-		return -EPERM;
+	err = -EIO;
+	if (iblock >= (blk_size[MAJOR(dev)][MINOR(dev)] >>
(BUFFERED_BLOCKSIZE_BITS - BLOCK_SIZE_BITS)))
		     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

blk_size[MAJOR(dev)] can very well be equal NULL! In this case one is
supposed to assume blk_size[MAJOR(dev)][MINOR(dev)] to be INT_MAX.
Are you shure it's guaranteed here to be already preset?

Same question goes for calc_end_index and calc_rsize.


+		goto out;
 
-	written = write_error = buffercount = 0;
-	blocksize = BLOCK_SIZE;
-	if (blksize_size[MAJOR(dev)] && blksize_size[MAJOR(dev)][MINOR(dev)])
-		blocksize = blksize_size[MAJOR(dev)][MINOR(dev)];
