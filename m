Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129538AbQLCXQy>; Sun, 3 Dec 2000 18:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbQLCXQp>; Sun, 3 Dec 2000 18:16:45 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:31190 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129595AbQLCXQ3>;
	Sun, 3 Dec 2000 18:16:29 -0500
Date: Sun, 3 Dec 2000 17:45:57 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrew Morton <andrewm@uow.edu.au>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
        Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Jonathan Hudson <jonathan@daria.co.uk>, linux-kernel@vger.kernel.org
Subject: [resync?] Re: corruption
In-Reply-To: <3A2ABEC5.97AF9C61@uow.edu.au>
Message-ID: <Pine.GSO.4.21.0012031730020.3601-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Dec 2000, Andrew Morton wrote:

> Sorry, it's still failing.  It took three hours.

Yes. For one thing, original was plain wrong wrt locking (lru_list_lock
should be held). For another, it does not take care of metadata. And
that's way more serious. What really happens:

ext2_truncate() got a buffer_head of indirect block that is going to
die. Fine, we release the blocks refered from it and... do bforget()
on our block. Notice that we are not guaranteed that bh will actually
die here. buffer.c code might bump its ->b_count for a while, it might
be written out right now, etc. As the result, bforget() leaves the
sucker alive. It's not a big deal, since we will do unmap_underlying_metadata()
before we write anything there (if it will be reused for data) or we'll
just pick the bh and zero the buffer out (if it will be reused for metadata).

Unfortunately, we also leave it on the per-inode dirty blocks list. Guess
what happens if inode is destroyed, page that used to hold it gets reused
and bh gets finally written? Exactly.

Suggested fix: void bforget_inode(struct buffer_head *bh) that would
be a copy of __bforget(), except that it would call remove_inode_queue(bh)
unconditionally. And replace bforget() with bforget_inode() in those places
of ext2/inode.c that are followed by freeing the block.

Comments? I'll do a patch, but I'ld really like to know what had already
gone into the main tree. Linus, could you put the 12-pre4-dont-use on
ftp.kernel.org?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
