Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283054AbRLIFuC>; Sun, 9 Dec 2001 00:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283055AbRLIFtw>; Sun, 9 Dec 2001 00:49:52 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:2015 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S283054AbRLIFts>;
	Sun, 9 Dec 2001 00:49:48 -0500
Date: Sun, 9 Dec 2001 00:49:45 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: Linux/Pro  -- clusters
In-Reply-To: <Pine.LNX.4.33.0112082021190.1457-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0112090020460.9091-100000@binet.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 8 Dec 2001, Linus Torvalds wrote:

> > I am sure also Al will tell you that there is no problem.

<raised brows>  What gave you such impression?  IIRC, I've described
the problems several months ago.  Three words: object freeing policy.

> To me, touching a few hundred files, even if it's almost a
> search-and-replace operation is always painful. Much more painful than
> touching just one subsystem..

Less painful, in that case.

kdev_t will have to stay what it is right now.  We _still_ don't have
clear lifetime logics for char_device (BTW, patches for long-living
cache on bdev side might be worth resurrecting them).

We can switch to _use_ of pointers to block_device and char_device, but
we can't turn kdev_t into such pointer and expect it to work correctly.

So this "touching just one subsystem" would involve a shitload of very
tricky audits of said few hundred files.   I'll take straightforward
search-and-replace job over that any day, thank you very much.

As for kdev_t...  Eventually it will die out.  Arguments about code
duplication on maintaining caches are BS - especially since we will
end up with different allocation/freeing rules and thus almost definitely
different locking.

IOW, for what I care the strategy for 2.5 should be:
	* reduce amount of places where we pass kdev_t around while there
is better alternative.   E.g. for bread() and friends in filesystems it's
definitely struct superblock.
	* supply struct block_device * to the rest of places where we
are passing block devices around.
	* switch i_rdev to dev_t.
	* kill uses of kdev_t for block devices completely.

Character devices are both simpler and harder - we have fewer places using
them, but we have no clean release point due to the games played by
subsystems that replace ->f_op on a live struct file.

Andries, believe me, I understand the attractiveness of "let's use sma
t macros to hide the complexity of chage", but that will do us no good since
the real complexity will bite us anyway when we start chasing dangling pointers
and having fun with races.

The fundamental reason why we can't replace kdev_t with pointer and hope
to survive is that YOU DON'T FREE NUMBERS.  Integer is an integer - it's
always valid.  We will need to free the structures and _that_ is where the
problems will start.

Witness the fun with iput() changes around 2.4.15 - they were needed exactly
because we used to be sloppy and left inodes in cache for too long; after
the ->i_sb was garbage.  That had been fixed - we finally have sane rules
for inode lifetime and these rules guarantee that we won't have junk floating
around.

For kdev_t situation is much more complex than for superblocks.  More
objects refering to them, different locking situation for these objects,
etc.

Blind turning kdev_t into a pointer to dynamically allocated structure
is a recipe for a huge fuckup.  Sorry, but we'll have to do honest work.

