Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273023AbRIIToz>; Sun, 9 Sep 2001 15:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273024AbRIITop>; Sun, 9 Sep 2001 15:44:45 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:53521 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S273023AbRIITob>; Sun, 9 Sep 2001 15:44:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andreas Dilger <adilger@turbolabs.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: linux-2.4.10-pre5
Date: Sun, 9 Sep 2001 21:51:49 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010908222923.H32553@turbolinux.com> <Pine.LNX.4.33.0109082137060.1161-100000@penguin.transmeta.com> <20010909001715.B27237@turbolinux.com>
In-Reply-To: <20010909001715.B27237@turbolinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010909194441Z16142-26183+638@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 9, 2001 08:17 am, Andreas Dilger wrote:
> On Sep 08, 2001  21:54 -0700, Linus Torvalds wrote:
> > On Sat, 8 Sep 2001, Andreas Dilger wrote:
> > > So basically - when we move block devices to the page cache, get rid of
> > > buffer cache usage in the filesystems as well?  Ext2 is nearly there at
> > > least.  One alternative is as Daniel Phillips did in the indexed-ext2-
> > > directory patch, where he kept the "bread" interface, but backed it
> > > with the page cache, so it required relatively little change to the
> > > filesystem.
> > 
> > This might be a really easy solution. We might just make sure that the
> > buffer manipulation interfaces we export to filesystems (and there aren't
> > actually all that many of them - it's mainly bread and getblk) always end
> > up using the page cache, and just return the buffer head that is embedded
> > inside the page cache.
> > 
> > That way we don't have any new aliasing issues _at_all_. The user-mode
> > accesses to the block devices would always end up using the same buffers
> > that the low-level filesystem does.
> 
> > Andrea(s) - interested in pursuing this particular approach? In fact,
> > since "bread()" uses "getblk()", it is almost sufficient to just make
> > getblk()  use the page cache, and the rest will follow... You can even get
> > rid of the buffer hash etc, and make the buffer head noticeably smaller.
> > 
> > [ Yeah, I'm being a bit optimistic - you also end up having to re-write
> >   "get_hash_table()" to use a page cache lookup etc. So it's definitely
> >   some major surgery in fs/buffer.c, but "major" might actually be just a
> >   couple of hundred lines ]
> 
> Well, Daniel probably has the best handle on the state of this code (it
> may be that he has already done 90% of the work).  I've CC'd him on this
> to get him in the loop.

Hi, Andreas.  Yes, I've had some success with that approach and it's nice to
see this particular wheel being reinvented.  The original suggestion came
from SCT by the way.

> > And no filesystem should ever notice. They can still access the buffer
> > head as if it was just a buffer head, and wouldn't care about the fact
> > that it happens to be part of a mapping.
> > 
> > Any pitfalls?
> > 
> > [ I can see at least one already: __invalidate_buffers() and
> >   set_blocksize() would both have to be re-done, probably along the lines
> >   of "invalidate_inode_pages()" and "fsync+truncate_inode_pages()"
> >   respectively. ]

Set_blocksize looks like a malformed idea anyway.  I guess its purpose in life
is to get around the fact that we don't know the filesystem blocksize until
after reading the superblock.  So why doesn't the filesystem just fill in the
field in struct super_block and let the vfs worry about it?

If we are going to integrate buffers with the page cache then we have
buffer->page->mapping->inode->super->blocksize and we usually have most of
that chain dereferenced in all the interesting places.

> > Comments?
> 
> I think this fits in with your overall strategy as well - remove the buffer
> as a "cache" object, and only use it as an I/O object, right?  With this
> change, all of the cache functionality is in the page cache, and the buffers
> are only used as handles for I/O.

It's a step in that direction.  Because of the page vs block size mismatch I
find myself still using the buffer_head as a data object, typically because
of locking granularity problems.  If we are really headed towards variable
page size then this problem goes away, and the struct page can be the data
handle in every case.  This is looking more likely all the time, which is one
reason I took the side trip in mm hacking - to understand that code well
enough to know if there are any real stoppers.  At this point I don't think
there are any.  Looking through what little literature is available on this,
fragmentation is the only real problem mentioned, and we're already busily
chewing away at that one.  Rik's rmaps would help a lot there.

--
Daniel
