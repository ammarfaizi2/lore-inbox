Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132571AbREFDwU>; Sat, 5 May 2001 23:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132636AbREFDwL>; Sat, 5 May 2001 23:52:11 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:772 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132571AbREFDvw>; Sat, 5 May 2001 23:51:52 -0400
Date: Sun, 6 May 2001 05:51:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: Jens Axboe <axboe@suse.de>, Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, volodya@mindspring.com,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Message-ID: <20010506055117.D22850@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0105031017460.30346-100000@penguin.transmeta.com> <200105041140.NAA03391@cave.bitwizard.nl> <20010504135614.S16507@suse.de> <20010504172940.U3762@athlon.random> <20010505151808.A29451@metastasis.f00f.org> <20010506023723.A22850@athlon.random> <20010506141437.A31269@metastasis.f00f.org> <20010506045001.C22850@athlon.random> <20010506150058.A31393@metastasis.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010506150058.A31393@metastasis.f00f.org>; from cw@f00f.org on Sun, May 06, 2001 at 03:00:58PM +1200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2001 at 03:00:58PM +1200, Chris Wedgwood wrote:
> On Sun, May 06, 2001 at 04:50:01AM +0200, Andrea Arcangeli wrote:
> 
>     Moving e2fsck into the kernel is a completly different matter
>     than caching the blockdevice accesses with pagecache instead of
>     buffercache.
> 
> No, I was takling about user space fsck using character devices.

I misread your previous email sorry, I think you meant to fsck using
rawio (not to move fsck into the kernel). You can do that just now but
to get decent performance then fsck should do self caching, changing
fsck to do self caching doesn't sound worthwhile either. Note also that
rawio has nothing to do with the pagecache.  Infact both rawio and
O_DIRECT bypasses all the pagecache and its smp locks for example.

> I'm not claiming it is... what I'm asking is _why_ do we need block
> devices once 'everything' lives in the page cache?

Where the cache of the blockdevice lives is a completly orthogonal
problem with "why cached blockdevices are useful" which I addressed in
the previous email.

>     It's just that by doing it in pagecache you can mmap it as well
>     and it will provide overall better performance and it's probably
>     cleaner design. The only visible change is that you will be able
>     to mmap a blockdevice as well.
> 
> Why? What needs to mmap a block device? Since these are typically
> larger than that you can mmap into a 32-bit address space (yes, I'm
> ignoring the 5% or so of cases where this isn't true) I'm not aware
> on many applications that do it.

Last time I talked with the parted maintainer he was asking for that
feature so that parted won't need to do its own anti-oom management in
userspace, so he can simple mmap(MAP_SHARED) a quite large region of
metadata of the blockdevice, read/write to the mmaped region and the
kernel will take care of doing paging when it runs low on memory. right
now it allocates the metadata in anonymous memory and loads it via
read(). This memory will need to be swapped out if the working set
doesn't fit in ram (and swap may not be available ;).

> As I said, I'm not takling about kernel based fsck, although for
> _VERY_ large filesystems even with journalling I suspect it will be
> required one day (so it can run in the background and do consistency
> checking when the machine is idle).

Being able to fsck a live filesystem is yet another exotic feature and
yes for that you would certainly need some additional kernel support.

Andrea
