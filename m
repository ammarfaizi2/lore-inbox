Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313041AbSDKXv3>; Thu, 11 Apr 2002 19:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313060AbSDKXv2>; Thu, 11 Apr 2002 19:51:28 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:62980 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S313041AbSDKXvZ>; Thu, 11 Apr 2002 19:51:25 -0400
Message-ID: <3CB612EF.A20AA3C9@zip.com.au>
Date: Thu, 11 Apr 2002 15:49:19 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [prepatch] address_space-based writeback
In-Reply-To: <a94r5k$m23$1@penguin.transmeta.com> <Pine.GSO.4.21.0204111629370.21089-100000@weyl.math.psu.edu> <3CB5FFB5.693E7755@zip.com.au> <20020411225536.GE8062@turbolinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> On Apr 11, 2002  14:27 -0700, Andrew Morton wrote:
> > One thing I'm not clear on with the private metadata address_space
> > concept: how will it handle blocksize less than PAGE_CACHE_SIZE?
> > The only means we have at present of representing sub-page
> > segments is the buffer_head.  Do we want to generalise the buffer
> > layer so that it can be applied against private address_spaces?
> > That wouldn't be a big leap.
> 
> I was going to send you an email on this previously, but I (think I)
> didn't in the end...
> 
> At one time Linus proposed having an array of dirty bits for a page,
> which would allow us to mark only parts of a page dirty (say down to
> the sector level).  I believe this was in the discussion about moving
> the block devices to the page cache around 2.4.10.

What Christoph said :)

One problem with having a bitmap at page->private is that
we don't know how big the blocks are.  You could have
0x00000003 but you don't know if that's two 1k blocks
or two 2k blocks.  Not hard to work around I guess.

But you will, I suspect, end up needing additional
information.  Whether that part of the page has a
disk mapping.  If so, what block is it.  Maybe not a
lot more.

In the delalloc no-buffer_head code I'm just sticking a block
number at page->private, to cache the disk mapping, to save
additional get_block calls when the file is overwritten.  That
works if all the page's blocks are disk-contiguous.  If they're
not, repeated get_block calls are needed.   That all works OK.
Even when I wasn't caching get_block results at all I didn't
observe any particular performance problems from the need for
repeated get_block calls.

We could also just stick a dynamically-allocated array
of next-gen buffer_heads at page->private.  There's really
no need to allocate each buffer separately.  This would
save memory, save CPU and with a bit of pointer arithmetic,
liberate b_this_page and b_data.


Anyway, I puzzled it out.  Private address_spaces will "just work"
at present.  There are some wrinkles.  Take the example of ext2
indirect blocks.   Suppose they are in an address_space which is
contained in the private part of the inode.  Presumably, that
address_space's ->host points back at the IS_REG inode.  But even if
it doesn't, the indirect block's address_space needs to make damn
sure that it passes the main file's inode into the block allocator
so that the indirects are laid out in the right place.    The cost
of not placing the first indirect immediately behind block 11 is
30%.  Been there, done that :)

Now, if it's done right, that indirect block address_space is
disk-fragmented all over the shop.  Each of its blocks are four
megabytes apart.  This has the potential to come significantly
unstuck with address_space-based writeback, because the walk
across the file's pages will be in a separate pass from the
walk across the indirects.

In the 2.4-way of doing things, the regular data and the indirects
are nicely sorted on the global buffer LRU.

It is easy to solve this with delayed-allocate.  Because here,
you *know* that when an indirect block is allocated, I/O
is underway right now against its neighbouring data blocks.
So you just start I/O against the indirect as soon as you
allocate it.

But for synchronous-allocate filesystems I have a problem.  This
could significantly suck for writeout of very large files, when
the request queue is at its current teeny size.  Maybe writepage
of regular data at an indirect boundary needs to hunt down its
associated indirect block and start low-level I/O against that.
That will work.

Hopefully when Jens gets the new I/O scheduler in place we can
comfortably extend the request queue to 1024 slots or so.

-
