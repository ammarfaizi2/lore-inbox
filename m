Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129414AbQLDAbZ>; Sun, 3 Dec 2000 19:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129700AbQLDAbP>; Sun, 3 Dec 2000 19:31:15 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:44551 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129414AbQLDAa5>; Sun, 3 Dec 2000 19:30:57 -0500
Date: Sun, 3 Dec 2000 17:56:10 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Andrew Morton <andrewm@uow.edu.au>, Petr Vandrovec <vandrove@vc.cvut.cz>,
        Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Jonathan Hudson <jonathan@daria.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: [resync?] Re: corruption
Message-ID: <20001203175610.A24729@vger.timpanogas.org>
In-Reply-To: <3A2ABEC5.97AF9C61@uow.edu.au> <Pine.GSO.4.21.0012031730020.3601-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.4.21.0012031730020.3601-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, Dec 03, 2000 at 05:45:57PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2000 at 05:45:57PM -0500, Alexander Viro wrote:
> 
> 
> On Mon, 4 Dec 2000, Andrew Morton wrote:
> 
> > Sorry, it's still failing.  It took three hours.
> 
> Yes. For one thing, original was plain wrong wrt locking (lru_list_lock
> should be held). For another, it does not take care of metadata. And
> that's way more serious. What really happens:
> 
> ext2_truncate() got a buffer_head of indirect block that is going to
> die. Fine, we release the blocks refered from it and... do bforget()
> on our block. Notice that we are not guaranteed that bh will actually
> die here. buffer.c code might bump its ->b_count for a while, it might
> be written out right now, etc. As the result, bforget() leaves the
> sucker alive. It's not a big deal, since we will do unmap_underlying_metadata()
> before we write anything there (if it will be reused for data) or we'll
> just pick the bh and zero the buffer out (if it will be reused for metadata).
> 
> Unfortunately, we also leave it on the per-inode dirty blocks list. Guess
> what happens if inode is destroyed, page that used to hold it gets reused
> and bh gets finally written? Exactly.
> 
> Suggested fix: void bforget_inode(struct buffer_head *bh) that would
> be a copy of __bforget(), except that it would call remove_inode_queue(bh)
> unconditionally. And replace bforget() with bforget_inode() in those places
> of ext2/inode.c that are followed by freeing the block.
> 
> Comments? I'll do a patch, but I'ld really like to know what had already
> gone into the main tree. Linus, could you put the 12-pre4-dont-use on
> ftp.kernel.org?

Al,

I am always amazed at how rapidly you seem to be able to run down some
of these file system corruption problems.   You seem to understand the
interaction of this layer extremely well.  :-)

Jeff

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
