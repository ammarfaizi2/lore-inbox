Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263296AbREWWcz>; Wed, 23 May 2001 18:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263298AbREWWcf>; Wed, 23 May 2001 18:32:35 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:3353 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S263296AbREWWcd>; Wed, 23 May 2001 18:32:33 -0400
Date: Thu, 24 May 2001 00:32:20 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: DVD blockdevice buffers
Message-ID: <20010524003220.C764@athlon.random>
In-Reply-To: <Pine.LNX.4.31.0105231258420.6642-100000@penguin.transmeta.com> <3B0C202E.AA9962AD@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B0C202E.AA9962AD@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, May 23, 2001 at 04:40:14PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2001 at 04:40:14PM -0400, Jeff Garzik wrote:
> Linus Torvalds wrote:
> > Now, it may be that the preliminary patches from Andrea do not work this
> > way. I didn't look at them too closely, and I assume that Andrea basically
> > made the block-size be the same as the page size. That's how I would have
> > done it (and then waited for people to find real life cases where we want
> > to allow sector writes).
> 
> Due to limitations in low-level drivers, Andrea was forced to hardcode
> 4096 for the block size, instead of using PAGE_SIZE or PAGE_CACHE_SIZE.

Yes, actually to trigger the read-modify-write logic not more than with
the current buffercache I could simply decrease the softblocksize of the
blkdev pagecache to 1k, like the default granularity of the current
buffercache before any filesystem is mounted, but that would impose a
_very_ significant performance hit to the non-cached case which is quite
important as well mainly for a blkdev I think.

I measured on high end disks reading (out of cache) with 4k buffercache
blocksize instead of with 1k buffercache blocksize is an exact x2
improvement because at that speed the bottleneck become the work that
has to be done by the cpu.

Infact rawio /dev/raw* is as well 2 times slower than the 2.4 4k
bufferecache on blkdev in those environment (of course with rawio the
cpu is not used much comared to the buffered I/O) and that's one of the
reasons I also imposed a 4k granularity on the direct I/O from
open("/dev/hda", O_DIRECT|O_RDRW)  I didn't benchmarked yet but I
suspect that doing rawio with forced 4k bh (as opposed to 512bytes bh of
/dev/raw*) will make O_DIRECT on the blkdev much faster than the
buffered I/O on the blkdev through pagecache just like O_DIRECT scored
the 170MByte/sec of very scalable I/O recently I think also because it
was done through ext2 that imposed a 4k softblocksize:

        http://boudicca.tux.org/hypermail/linux-kernel/2001week17/1175.html
        http://boudicca.tux.org/hypermail/linux-kernel/2001week17/att-1175/01-directio.png

(boudicca.tux.org is not online at the moment but I assume it will
return online soon)

However this is still flexible, right now my first object is to solve
the showstoppers (so for example I can run my machine with that patch
applied) and then we can think how to solve the 4k/1k/512byte
softblocksize issues. Possibly automatically or selectable from
userspace. I will try to work on the blkdev patch tomorrow to bring it
in an usable state.

Andrea
