Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274681AbRIYW62>; Tue, 25 Sep 2001 18:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274683AbRIYW6T>; Tue, 25 Sep 2001 18:58:19 -0400
Received: from green.csi.cam.ac.uk ([131.111.8.57]:44961 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S274681AbRIYW6F>; Tue, 25 Sep 2001 18:58:05 -0400
Message-Id: <5.1.0.14.2.20010925231124.0309ac70@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 25 Sep 2001 23:59:46 +0100
To: Linus Torvalds <torvalds@transmeta.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH] invalidate buffers on blkdev_put
Cc: Alexander Viro <viro@math.psu.edu>, Chris Mason <mason@suse.com>,
        <linux-kernel@vger.kernel.org>, <andrea@suse.de>
In-Reply-To: <Pine.LNX.4.33.0109242118540.29038-100000@penguin.transmeta
 .com>
In-Reply-To: <Pine.GSO.4.21.0109242333240.21827-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:21 25/09/01, Linus Torvalds wrote:
>On Mon, 24 Sep 2001, Alexander Viro wrote:
> > OK, not exactly nay, but...  What you are trying to do is a workaround
> > for problem that can be solved in somewhat saner way.  Namely, we can
> > make getblk() return buffres backed by pages from device page cache.
>
>I now have the patches for this, but I have to fix up fs/block_dev.c to
>also honour the block size thing because otherwise the two are still not
>in sync.
>
>I'll send out a test-patch later this evening, I hope.
>
> > It's solvable, but not obvious.  It _does_ solve coherency problems between
> > device page cache and buffer cache (thus killing update_buffers() and its
> > ilk), but the last issue (new access path to page-private buffer_heads)
> > may be rather nasty.
>
>It's certainly solvable, but it is also certainly very fraught with tons
>of small details. I'll be very happy if people end up looking through the
>patches _very_ critically (and don't even bother testing them if you don't
>have a machine where you can lose a filesystem or two).
>
>Hopefully in another hour or two (but the first version is going to have
>some ugly stuff in it still).

Looking at the patch, you introduce a static inline blksize_bits. Wouldn't 
it be a lot more efficient to change the function to say:

static inline unsigned int blksize_bits(unsigned int size)
{
         return ffs(size) - 1;
}

and optionally, throw in a power of two assertion a-la:

static inline unsigned int blksize_bits(unsigned int size)
{
         if (!(size & size - 1))
                 return ffs(size) - 1;
         BUG();
}

Or am I barking mad and block sizes which are not a power of two are valid? (-;

Your version is not too happy with such beasts either but it does round 
down rather than do god knows what in arch specific ffs() implementation... 
Haven't looked at non-ia32 code but at least ia32's implementation fails 
miserably for non-powers of two by it's design. But it should be a lot 
faster than doing the while loop considering ffs() just uses a single CPU 
instruction instead of the loop (on ia32 anyway).

Best regards,

         Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

