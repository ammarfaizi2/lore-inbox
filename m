Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283012AbRLHRzA>; Sat, 8 Dec 2001 12:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283045AbRLHRyu>; Sat, 8 Dec 2001 12:54:50 -0500
Received: from mail211.mail.bellsouth.net ([205.152.58.151]:34108 "EHLO
	imf11bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S283012AbRLHRyd>; Sat, 8 Dec 2001 12:54:33 -0500
Message-ID: <3C1253D3.75EAA26E@mandrakesoft.com>
Date: Sat, 08 Dec 2001 12:54:27 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.13-12mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <3C110B3F.D94DDE62@zip.com.au> <9useu4$f4o$1@penguin.transmeta.com> <E16ClLY-000124-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> Linus wrote:
> > So "ext2_write_inode()" would basically become somehting like
> >
> >       struct ext2_inode *raw_inode = inode->u.ext2_i.i_raw_inode;
> >       struct buffer_head *bh = inode->u.ext2_i.i_raw_bh;
> >
> >       /* Update the stuff we've brought into the generic part of the inode */
> >       raw_inode->i_size = cpu_to_le32(inode->i_size);
> >       ...
> >       mark_buffer_dirty(bh);
> >
> > with part of the data already in the right place (ie the current
> > "inode->u.ext2_i.i_data[block]" wouldn't exist, it would just exist as
> > "raw_inode->i_block[block]" directly in the buffer block.

note we do this for the superblock already, and it's pretty useful


> I'd then be able to write a trivial program that would eat inode+blocksize
> worth of cache for each cached inode, by opening one file on each itable
> block.

you already have X overhead per inode cached... yes this would increase
X but since there is typically more than one inode per block there is
also sharing as well.  So inode+blocksize is not true.


> I'd also regret losing the genericity that comes from the read_inode (unpack)
> and update_inode (repack) abstraction.

so what is write_inode... re-repack?  :)


> Right now, I don't see any fields in
> _info that aren't directly copied, but I expect there soon will be.

i_data[] is copied, and that would be nice to directly access in
inode->u.ext2_i.i_bh...

Also in my ibu fs (you can look at it now in gkernel cvs) it uses a
fixed inode size of 512 bytes, with file or extent data packed into that
512 bytes after the fixed header ends.  Having the bh right there would
be nice.  [note there shouldn't be aliasing problems related to that in
ibu's case, because when data-in-inode is implemented readpage and
writepage handle that case anyway]


> An alternative approach: suppose we were to map the itable blocks with
> smaller-than-blocksize granularity.  We could then fall back to smaller
> transfers under cache pressure, eliminating much thrashing.

in ibu fs the entire inode table[1] is accessing via the page cache. 
ext2 could do this too.  If ext2's per-block-group inode table has
padding at the end page calculations get a bit more annoying but it's
still doable.

	Jeff


[1] ibu's inode table is a normal, potentially-fragmented file.  thus it
is possibly broken up in chunks spread across the disk like ext2's block
groups.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

