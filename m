Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271964AbRIINSq>; Sun, 9 Sep 2001 09:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271961AbRIINSg>; Sun, 9 Sep 2001 09:18:36 -0400
Received: from red.csi.cam.ac.uk ([131.111.8.70]:49814 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S271257AbRIINSU>;
	Sun, 9 Sep 2001 09:18:20 -0400
Message-Id: <5.1.0.14.2.20010909135727.00aa8be0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 09 Sep 2001 14:14:54 +0100
To: Linus Torvalds <torvalds@transmeta.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: linux-2.4.10-pre5
Cc: Andreas Dilger <adilger@turbolabs.com>, Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0109082137060.1161-100000@penguin.transmeta.
 com>
In-Reply-To: <20010908222923.H32553@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:54 09/09/2001, Linus Torvalds wrote:
>On Sat, 8 Sep 2001, Andreas Dilger wrote:
> > So basically - when we move block devices to the page cache, get rid of
> > buffer cache usage in the filesystems as well?  Ext2 is nearly there at
> > least.  One alternative is as Daniel Phillips did in the indexed-ext2-
> > directory patch, where he kept the "bread" interface, but backed it
> > with the page cache, so it required relatively little change to the
> > filesystem.
>
>This might be a really easy solution. We might just make sure that the
>buffer manipulation interfaces we export to filesystems (and there aren't
>actually all that many of them - it's mainly bread and getblk) always end
>up using the page cache, and just return the buffer head that is embedded
>inside the page cache.
>
>That way we don't have any new aliasing issues _at_all_. The user-mode
>accesses to the block devices would always end up using the same buffers
>that the low-level filesystem does.
>
>Hmm.. That actually would have another major advantage too: the whole
>notion of a "anonymous buffer page" would just disappear. Because there
>would be no interfaces to even create them - buffer pages would always be
>associated with a mapping.
>
>Andrea(s) - interested in pursuing this particular approach? In fact,
>since "bread()" uses "getblk()", it is almost sufficient to just make
>getblk()  use the page cache, and the rest will follow... You can even get
>rid of the buffer hash etc, and make the buffer head noticeably smaller.
>
>[ Yeah, I'm being a bit optimistic - you also end up having to re-write
>   "get_hash_table()" to use a page cache lookup etc. So it's definitely
>   some major surgery in fs/buffer.c, but "major" might actually be just a
>   couple of hundred lines ]
>
>The good news here is that once it works (and you've destroyed your
>filesystem about fifty times debugging it :), it's pretty much guaranteed
>not to introduce any new and "interesting" interactions between
>filesystems and user-level programs accessing the device.
>
>And no filesystem should ever notice. They can still access the buffer
>head as if it was just a buffer head, and wouldn't care about the fact
>that it happens to be part of a mapping.
>
>Any pitfalls?

Not a pitfall, but a question: what happens with the get_block() callback 
passed to block_read_full_page() by the readpage() address space method of 
individual filesystems with respect to reading sparse files?

The problem I see is as follows: reading a sparse region from a sparse 
file, get_block() callback will return with just setting bh->b_blocknr = 
-1UL; but _not_ setting BH_Mapped on the buffer. (That is what NTFS TNG 
does anyway, probably not ideal, but I wasn't sure what to do in this case 
as bh->b_blocknr = 0UL is quite valid and returns the first data block of 
the $Boot system file...)

Will this continue to work as expected? Or is it fundamentally broken and I 
shouldn't be using block_read_full_page() for NTFS at all and having my own 
replacement? - I only use block_read_full_page() for non-resident files 
already as resident files are not stored in disk blocks so the concept of a 
get_block() or using buffer heads for final i/o is not applicable to them 
at all... - But I still need to have buffer heads without a disk mapping 
for sparse files. At least I would like to allocate the actual on disk 
storage only when someone actually writes to a hole, but not reads from it.

Best regards,

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

