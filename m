Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282948AbRLIDZE>; Sat, 8 Dec 2001 22:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282954AbRLIDYz>; Sat, 8 Dec 2001 22:24:55 -0500
Received: from dsl-213-023-038-245.arcor-ip.net ([213.23.38.245]:28168 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S282948AbRLIDYs>;
	Sat, 8 Dec 2001 22:24:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
Date: Sun, 9 Dec 2001 04:27:29 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <E16ClLY-000124-00@starship.berlin> <3C1253D3.75EAA26E@mandrakesoft.com>
In-Reply-To: <3C1253D3.75EAA26E@mandrakesoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Cucn-00015D-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 8, 2001 06:54 pm, Jeff Garzik wrote:
> Daniel Phillips wrote:
> > Linus wrote:
> > > So "ext2_write_inode()" would basically become somehting like
> > >
> > >       struct ext2_inode *raw_inode = inode->u.ext2_i.i_raw_inode;
> > >       struct buffer_head *bh = inode->u.ext2_i.i_raw_bh;
> > >
> > >       /* Update the stuff we've brought into the generic part of the 
inode */
> > >       raw_inode->i_size = cpu_to_le32(inode->i_size);
> > >       ...
> > >       mark_buffer_dirty(bh);
> > >
> > > with part of the data already in the right place (ie the current
> > > "inode->u.ext2_i.i_data[block]" wouldn't exist, it would just exist as
> > > "raw_inode->i_block[block]" directly in the buffer block.
> 
> note we do this for the superblock already, and it's pretty useful

The difference is, there's only one superblock per mount.  There are 
bazillions
of inodes.

> > I'd then be able to write a trivial program that would eat inode+blocksize
> > worth of cache for each cached inode, by opening one file on each itable
> > block.
> 
> you already have X overhead per inode cached... yes this would increase
> X but since there is typically more than one inode per block there is
> also sharing as well.  So inode+blocksize is not true.

You skipped over my example too fast.

> > I'd also regret losing the genericity that comes from the read_inode 
(unpack)
> > and update_inode (repack) abstraction.
> 
> so what is write_inode... re-repack?  :)

It's a trivial shell for update_inode:

http://innominate.org/~graichen/projects/lxr/source/fs/ext2/inode.c?v=v2.4#L1146

> > Right now, I don't see any fields in
> > _info that aren't directly copied, but I expect there soon will be.
> 
> i_data[] is copied, and that would be nice to directly access in
> inode->u.ext2_i.i_bh...

Yes, that's the major one, it's 60 bytes, more than the other _info fields 
put together.  However, almost half the itable block data is going to be 
redundant, and the proposal as I understand it is to lock it in cache while 
the inode is in cache.  This makes things worse, not better - it reduces the 
total number of inodes that can be cached.  And that's the best case, 
when *all* the inodes on an itable block are in cache.  Take a look at the 
inode distribution in your directories and see if you think that's likely.

> > An alternative approach: suppose we were to map the itable blocks with
> > smaller-than-blocksize granularity.  We could then fall back to smaller
> > transfers under cache pressure, eliminating much thrashing.
> 
> in ibu fs the entire inode table[1] is accessing via the page cache. 
> ext2 could do this too.  If ext2's per-block-group inode table has
> padding at the end page calculations get a bit more annoying but it's
> still doable.

That's roughly what I had in mind, for starters.

It's worth keeping in mind that tweaking the icache efficiency in this case 
is really just curing a symptom - the underlying problem is a mismatch 
between readdir order and inode order.

--
Daniel
