Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313490AbSDJUSf>; Wed, 10 Apr 2002 16:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313743AbSDJUSe>; Wed, 10 Apr 2002 16:18:34 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:50188 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S313490AbSDJUSd>; Wed, 10 Apr 2002 16:18:33 -0400
Message-ID: <3CB48F8A.DF534834@zip.com.au>
Date: Wed, 10 Apr 2002 12:16:26 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [prepatch] address_space-based writeback
In-Reply-To: <3CB4203D.C3BE7298@zip.com.au> <Pine.GSO.4.21.0204100725410.15110-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Wed, 10 Apr 2002, Andrew Morton wrote:
> 
> >
> > This is a largish patch which makes some fairly deep changes.  It's
> > currently at the "wow, it worked" stage.  Most of it is fairly
> > mature code, but some conceptual changes were recently made.
> > Hopefully it'll be in respectable state in a few days, but I'd
> > like people to take a look.
> >
> > The idea is: all writeback is against address_spaces.  All dirty data
> > has the dirty bit set against its page.  So all dirty data is
> > accessible by
> >
> >       superblock list
> >               -> superblock dirty inode list
> >                       -> inode mapping's dirty page list.
> >                               -> page_buffers(page) (maybe)
> 
> Wait.

Hi, Al.  Nothing has really changed wrt the things to which you
refer.  ie: they would already be a problem.  The relationships
between dirty pages, address_spaces, inodes and superblocks
are unchanged, except for one thing:  __mark_inode_dirty will
now attach blockdev inodes to the dummy blockdev's dirty
inodes list.

The main thing which is being changed is buffers. The assumption is
that buffers can be hunted down via
superblocklist->superblock->dirty_inode->i_mapping->writeback_mapping,
not via the global LRU.

>  You are assuming that all address_spaces happen to be ->i_mapping of
> some inode.

Sorry, the above diagram is not really accurate.  The sync/kupdate/bdflush
writeback path is really:

	superblock list
		-> superblock dirty inode list
			->inode->i_mapping->a_ops->writeback_mapping(mapping)

So core kernel does not actually assume that the to-be-written
pages are accessible via inode->i_mapping->dirty_pages.

I believe that the object relationship you're describing is
that the inode->i_mapping points to the main address_space,
and the `host' field of both the main and private address_spaces
both point at the same inode?  That the inode owns two
address_spaces?

That's OK.  When a page is dirtied, the kernel will attach
that page to the private address_space's dirty pages list and
will attach the common inode to its superblock's dirty inodes list.

For writeback, core kernel will perform

	inode->i_mapping->writeback_mapping(mapping, nr_pages)

which will hit the inode's main address_space's writeback_mapping()
method will do:

my_writeback_mapping(mapping, nr_pages)
{
	generic_writeback_mapping(mapping, nr_pages);
	mapping->host->private_mapping->a_ops->writeback_mapping(
		mapping->host->private_mapping, nr_pages);
}

> ...
> What's more, I wonder how well does your scheme work with ->i_mapping
> to a different inode's ->i_data (CODA et.al., file access to block devices).

Presumably, those different inodes have a superblock?  In that
case set_page_dirty will mark that inode dirty wrt its own
superblock.  set_page_dirty() is currently an optional a_op,
but it's not obvious that there will be a need for that.

The one thing which does worry me a bit is why __mark_inode_dirty
tests for a null ->i_sb.  If the inode doesn't have a superblock
then its pages are hidden from the writeback functions.

This is not fatal per-se.  The pages are still visible to the VM
via the LRU, and presumably the filesystem knows how to sync
its own stuff.  But for memory-balancing and throttling purposes,
I'd prefer that the null ->i_sb not be allowed.  Where can this
occur?

> BTW, CODA-like beasts can have several local filesystems for cache - i.e.
> ->i_mapping for dirty inodes from the same superblock can ultimately go
> to different queues.

When a page is dirtied, those inodes will be attached to their
->i_sb's dirty inode list; I haven't changed any of that.

>  Again, the same goes for stuff like
> dd if=foo of=/dev/floppy - you get dirty inode of /dev/floppy with ->i_mapping
> pointing to bdev filesystem and queue we end up with having nothing in common
> with that of root fs' device.

OK.  What has changed here is that the resulting mark_buffer_dirty
calls will now set the page dirty, and attach the page to its
mapping's dirty_pages, and attach its mapping's host to
mapping->host->i_sb->s_dirty.

So writeback for the floppy device is no longer via the
buffer LRU.  It's via

	dummy blockdev superblock
		-> blockdev's inode
			->i_mapping
				->writeback_mapping

> I'd really like to see where are you going with all that stuff - if you
> expect some correspondence between superblocks and devices, you've are
> walking straight into major PITA.

Hopefully, none of that has changed.  It's just the null inode->i_sb
which is a potential problem.

-
