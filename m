Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136465AbREDR2v>; Fri, 4 May 2001 13:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136466AbREDR2l>; Fri, 4 May 2001 13:28:41 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:30482 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136465AbREDR2b>; Fri, 4 May 2001 13:28:31 -0400
Date: Fri, 4 May 2001 10:28:10 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, volodya@mindspring.com,
        Alexander Viro <viro@math.psu.edu>, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <200105041140.NAA03391@cave.bitwizard.nl>
Message-ID: <Pine.LNX.4.21.0105041015520.521-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 May 2001, Rogier Wolff wrote:
>
> Linus Torvalds wrote:
> > 
> > Ehh. Doing that would be extremely stupid, and would slow down your boot
> > and nothing more.
> 
> Ehhh, Linus, Linearly reading my harddisk goes at 26Mb per second.

You obviously didn't read my explanation of _why_ it is stupid.

> By analyzing my boot process I determine that 50M of my disk is used
> during boot. I can then reshuffle my disk to have that 50M of data at
> the beginning and reading all that into 50M of cache, I can save
> thousands of 10ms seeks.

No. Have you _tried_ this?

What the above would do is to move 50M of the disk into the buffer cache.

Then, a second later, when the boot proceeds, Linux would start filling
the page cache.

BY READING THE CONTENTS FROM DISK AGAIN!

In short, by doing a "dd" from the disk, you would _not_ help anything at
all. You would only make things slower, by reading things twice.

The Linux buffer cache and page cache are two separate entities. They are
not synchronized, and they are indexed through totally different
means. The page cache is virtually indexed by <inode,pagenr>, while
the
buffer cache is indexed by <dev,blocknr,blocksize>. 

> Is this simply: Don't try this then? 

Try it. You will see. 

You _can_ actually try to optimize certain things with 2.4.x: all
meta-data is still in the buffer cache in 2.4.x, so what you could do is
to lay out the image so that the metadata is at the front of the disk,
and do the "dd" to cache just the metadata. Even then you need to be
careful, and make sure that the "dd" uses the same block size as the
filesystem will use.

And even that will largely stop working very early in 2.5.x when the
directory contents and possibly inode and bitmap metadata moves into the
page cache.

Now, you may ask "why use the page cache at all then"? The answer is that
the page cache is a _lot_ faster to look up, exactly because of the
virtual indexing (and also because the data structure is much better
designed - fixed-size entities with none of the complexities of the buffer
cache. The buffer cache needs to be able to do IO, while the page cache is
_only_ a cache and does that one thing really well - doing IO is a
completely separate issue with the page cache).

Now, if you want to speed up accesses, there are things you can do. You
can lay out the filesystem in the access order - trace the IO accesses at
bootup ("which file, which offset, which metadata block?") and lay out the
blocks of the files in exactly the right order. Then you will get linear
reads _without_ doing any "dd" at all.

Now, laying out the filesystem that way is _hard_. No question about it.
It's kind of equivalent to doing a filesystem "defreagment" operation,
except you use a different sorting function (instead of sorting blocks
linearly within each file, you sort according to access order).

		Linus

