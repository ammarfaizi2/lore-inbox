Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271910AbRIIGTn>; Sun, 9 Sep 2001 02:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271911AbRIIGTd>; Sun, 9 Sep 2001 02:19:33 -0400
Received: from [209.10.41.242] ([209.10.41.242]:52640 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S271910AbRIIGTX>;
	Sun, 9 Sep 2001 02:19:23 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Sun, 9 Sep 2001 00:17:15 -0600
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: linux-2.4.10-pre5
Message-ID: <20010909001715.B27237@turbolinux.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Daniel Phillips <phillips@bonn-fries.net>
In-Reply-To: <20010908222923.H32553@turbolinux.com> <Pine.LNX.4.33.0109082137060.1161-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109082137060.1161-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 08, 2001  21:54 -0700, Linus Torvalds wrote:
> On Sat, 8 Sep 2001, Andreas Dilger wrote:
> > So basically - when we move block devices to the page cache, get rid of
> > buffer cache usage in the filesystems as well?  Ext2 is nearly there at
> > least.  One alternative is as Daniel Phillips did in the indexed-ext2-
> > directory patch, where he kept the "bread" interface, but backed it
> > with the page cache, so it required relatively little change to the
> > filesystem.
> 
> This might be a really easy solution. We might just make sure that the
> buffer manipulation interfaces we export to filesystems (and there aren't
> actually all that many of them - it's mainly bread and getblk) always end
> up using the page cache, and just return the buffer head that is embedded
> inside the page cache.
> 
> That way we don't have any new aliasing issues _at_all_. The user-mode
> accesses to the block devices would always end up using the same buffers
> that the low-level filesystem does.

> Andrea(s) - interested in pursuing this particular approach? In fact,
> since "bread()" uses "getblk()", it is almost sufficient to just make
> getblk()  use the page cache, and the rest will follow... You can even get
> rid of the buffer hash etc, and make the buffer head noticeably smaller.
> 
> [ Yeah, I'm being a bit optimistic - you also end up having to re-write
>   "get_hash_table()" to use a page cache lookup etc. So it's definitely
>   some major surgery in fs/buffer.c, but "major" might actually be just a
>   couple of hundred lines ]

Well, Daniel probably has the best handle on the state of this code (it
may be that he has already done 90% of the work).  I've CC'd him on this
to get him in the loop.

> And no filesystem should ever notice. They can still access the buffer
> head as if it was just a buffer head, and wouldn't care about the fact
> that it happens to be part of a mapping.
> 
> Any pitfalls?
> 
> [ I can see at least one already: __invalidate_buffers() and
>   set_blocksize() would both have to be re-done, probably along the lines
>   of "invalidate_inode_pages()" and "fsync+truncate_inode_pages()"
>   respectively. ]
> 
> Comments?

I think this fits in with your overall strategy as well - remove the buffer
as a "cache" object, and only use it as an I/O object, right?  With this
change, all of the cache functionality is in the page cache, and the buffers
are only used as handles for I/O.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

