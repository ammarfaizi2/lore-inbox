Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131626AbREFCux>; Sat, 5 May 2001 22:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132318AbREFCun>; Sat, 5 May 2001 22:50:43 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:20860 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131626AbREFCu3>; Sat, 5 May 2001 22:50:29 -0400
Date: Sun, 6 May 2001 04:50:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: Jens Axboe <axboe@suse.de>, Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, volodya@mindspring.com,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Message-ID: <20010506045001.C22850@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0105031017460.30346-100000@penguin.transmeta.com> <200105041140.NAA03391@cave.bitwizard.nl> <20010504135614.S16507@suse.de> <20010504172940.U3762@athlon.random> <20010505151808.A29451@metastasis.f00f.org> <20010506023723.A22850@athlon.random> <20010506141437.A31269@metastasis.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010506141437.A31269@metastasis.f00f.org>; from cw@f00f.org on Sun, May 06, 2001 at 02:14:37PM +1200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2001 at 02:14:37PM +1200, Chris Wedgwood wrote:
> You don't need block device for fsck, in fact some OS require you use
> character devices (e.g. Solaris).

Moving e2fsck into the kernel is a completly different matter than
caching the blockdevice accesses with pagecache instead of buffercache.

And even if you move e2fsck or reiserfsck into the kernel (you could
technically do that just now regardless of where the block_dev cache
lives) there will still be partd that wants to mmap the blockdevice to
get rid of part of the fat32 partition (right now it uses read/write of
course because buffer cache cannot be mapped in userspace), there will
still be mtools, not self caching dbms, od </dev/hda, dd of=/dev/hda
etc..etc..etc..  that makes block_dev still *very* useful.

> I'm not saying we don't need block devices, but I really don't see
> much of a use for them once everything in in the page cache... I
> assume this is why others have got rid of them completely.

I have no idea why/if other got rid of it completly, but the fact block_dev
is useful has nothing to do if it's in pagecache or in buffercache,
really. It's just that by doing it in pagecache you can mmap it as well
and it will provide overall better performance and it's probably cleaner
design. The only visible change is that you will be able to mmap a
blockdevice as well.

About a kernel based fsck Alexander told me he likes it, I personally
don't care about it that much because I believe there's not that much to
share at the source level, fsck and real fs are quite different
problems, and what can be shared can be copied and by not sharing we get
the flexibility of not breaking fsck every time we change the kernel and
more in general the flexibility of doing it in userspace, sharing such
bytecode at runtime definitely doesn't matter.  It also partly depends
from the fs but current ext2 situation is really fine to me and I
wouldn't consier a wortwhile project to move e2fsck into the kernel. 

Andrea
