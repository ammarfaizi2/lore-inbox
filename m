Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271891AbRIIE7P>; Sun, 9 Sep 2001 00:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271898AbRIIE7E>; Sun, 9 Sep 2001 00:59:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39696 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271891AbRIIE66>; Sun, 9 Sep 2001 00:58:58 -0400
Date: Sat, 8 Sep 2001 21:54:54 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.10-pre5
In-Reply-To: <20010908222923.H32553@turbolinux.com>
Message-ID: <Pine.LNX.4.33.0109082137060.1161-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 8 Sep 2001, Andreas Dilger wrote:
>
> So basically - when we move block devices to the page cache, get rid of
> buffer cache usage in the filesystems as well?  Ext2 is nearly there at
> least.  One alternative is as Daniel Phillips did in the indexed-ext2-
> directory patch, where he kept the "bread" interface, but backed it
> with the page cache, so it required relatively little change to the
> filesystem.

This might be a really easy solution. We might just make sure that the
buffer manipulation interfaces we export to filesystems (and there aren't
actually all that many of them - it's mainly bread and getblk) always end
up using the page cache, and just return the buffer head that is embedded
inside the page cache.

That way we don't have any new aliasing issues _at_all_. The user-mode
accesses to the block devices would always end up using the same buffers
that the low-level filesystem does.

Hmm.. That actually would have another major advantage too: the whole
notion of a "anonymous buffer page" would just disappear. Because there
would be no interfaces to even create them - buffer pages would always be
associated with a mapping.

Andrea(s) - interested in pursuing this particular approach? In fact,
since "bread()" uses "getblk()", it is almost sufficient to just make
getblk()  use the page cache, and the rest will follow... You can even get
rid of the buffer hash etc, and make the buffer head noticeably smaller.

[ Yeah, I'm being a bit optimistic - you also end up having to re-write
  "get_hash_table()" to use a page cache lookup etc. So it's definitely
  some major surgery in fs/buffer.c, but "major" might actually be just a
  couple of hundred lines ]

The good news here is that once it works (and you've destroyed your
filesystem about fifty times debugging it :), it's pretty much guaranteed
not to introduce any new and "interesting" interactions between
filesystems and user-level programs accessing the device.

And no filesystem should ever notice. They can still access the buffer
head as if it was just a buffer head, and wouldn't care about the fact
that it happens to be part of a mapping.

Any pitfalls?

[ I can see at least one already: __invalidate_buffers() and
  set_blocksize() would both have to be re-done, probably along the lines
  of "invalidate_inode_pages()" and "fsync+truncate_inode_pages()"
  respectively. ]

Comments?

		Linus

