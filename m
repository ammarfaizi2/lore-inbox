Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130610AbRBVIJ4>; Thu, 22 Feb 2001 03:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130069AbRBVIJq>; Thu, 22 Feb 2001 03:09:46 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:48118 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S130610AbRBVIJe>; Thu, 22 Feb 2001 03:09:34 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200102220806.f1M86HE21665@webber.adilger.net>
Subject: Re: [rfc] [LONG] Near-constant time directory index for Ext2
In-Reply-To: <3A9482C9.65A51FEF@innominate.de> from Daniel Phillips at "Feb 22,
 2001 04:08:57 am"
To: Daniel Phillips <phillips@innominate.de>
Date: Thu, 22 Feb 2001 01:06:17 -0700 (MST)
CC: Linux kernel development list <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@ns.caldera.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips writes:
> Andreas Dilger wrote:
> > I was just doing the math for 1k ext2 filesystems, and the numbers aren't
> > nearly as nice.  We get:
> > 
> >         (1024 / 16) * 127 * .75 = 6096          # 1 level
> >         (1024 / 16) * 128 * 127 * .75 = 780288  # 2 levels
> 
> But if you are *determined* to use 1K blocks and have more than 1/2
> million files in one directory then I suppose a 3rd level is what you
> need.  The uniform-depth tree still works just fine and still doesn't
> need to be rebalanced - it's never out of balance.

I would rather simply go to some chained block scheme at that point.
ext2 is already fairly fast at linear searching, so if we index a HUGE
directory we are still linearly searching only 1/2^16 of the directory
(at worst for 1k blocks, 1/2^20 for 4k blocks).

I just had a clever idea - on a single-level index you put the header
and index data in block 0, and put the directory data in the first
indirect block (11 sparse blocks, instead of 511).  If you need to go
to a second-level index, you can simply shift the indirect data block to
be a double-indirect block, and start the level-2 index in the first
indirect block.  If we ever need a third-level index, you basically do
the same thing - move the double-indirect blocks to triple-indirect,
and put the level-3 index in the double-indirect block.  It will always
fit, because the index branching level is 1/2 of the indirect block
branching level because the index has the extra 4-byte hash values.

Andreas:
>> One thing I was thinking was that you could put "." and ".." in the first
>> block (like usual), and then put the index data after that.  This way
>> "." and ".." still exist and e2fsck and the kernel code doesn't complain,
>> except about the sparse directory blocks.

Daniel:
>The kernel code - ext2 fs that is - doesn't complain at the moment
>because I removed the complaint, and everything seems to be fine.  All
>references to "." and ".." are now intercepted and never reach the
>filesystem level.  If they did then I'd just fix ext2_is_empty_dir to
>tolerate those entries being somewhere other than the first block. 
>But, reading ahead, I see you are talking about forward compatibility...

One of the (many) benefits of ext2 is that it has tried to maintain
compatibility as much as possible, if possible.  In this case, I
don't see that there is an overwhelming reason to NOT keep compatibility,
and I think Ted agrees:

Ted Ts'o writes:
> E2fsck uses '..' to be able to climb up the directory tree when it needs
> to print a pathname given only a directory inode.  So yes, removing it 
> will cause e2fsck to not work as well.  '.' is not as useful, but it's
> useful as a sanity check.  

> Of course, if we completely give up on compatibility, we don't actually
> need to have special directory entries for '.' and '..' complete with
> their names; we can just store the inode numbers for both in a 32bit
> field along with the indexes.  (And so magic number for sanity checking;
> magic numbers are good things....)

Having real dirents for "." and ".." only costs 16 more bytes (2 index
leaves), compared to only keeping the inode numbers.

Andreas:
> > So, we would have (for the root entry, let's say):
(in directory block 0)

> > ext2_dir_entry_2{ EXT2_ROOT_INO, 12, 1, EXT2_FT_DIR, ".\0\0\0"}
> > ext2_dir_entry_2{ EXT2_ROOT_INO, <blocksize> - 12, 2, EXT2_FT_DIR, "..\0\0"}
> > <index magic (maybe)>
> > <index header>
> > <index data>
> > 
> > For the index ext2 kernel code, it would notice the EXT2_INDEX_FL and
> > access the data after the end of the ".." dir entry, and this would also
> > give you read-only "compatibility" of sorts with older kernels (modulo
> > calling ext2_error() for all of the sparse blocks before the start of the
> > actual directory data blocks).  You lose 24 bytes of data in the first
> > block, but gain some compatibility.  For second-level index blocks, if you
> > want to keep compatibility you lose 8 bytes each block if you start with:
> > 
> > ext2_dir_entry_2 { 0, <blocksize>, 0, EXT2_FT_DIR, "" }
> > <index magic (maybe)>
> > <second level index data>

Daniel:
> I really think INCOMPAT is the way to go and if you must mount it with
> an old kernel, do a fsck.  Old fsck manages to put things back into a
> form it can understand without too much difficulty, though you do have
> to answer quite a few questions.  The exact answers you give don't seem
> to be that important.

You don't always have the luxury to go back to an old kernel (for whatever
reason), and if an incompat flag is set the kernel will refuse to mount
your old filesystem.  If this is your root, you can't even run fsck.  Yes,
I know - have a rescue disk/partition - but _sometimes_ you are just stuck
and it would be good to not get into that situation in the first place.

Andreas:
> > Will there be a lower limit at which you create indexed directories?

Daniel:
> Yes, I hashed that out today with Al Viro on #kernelnewbies.  The
> breakeven happens at 3 directory blocks.

Andreas:
> > I guess the tradeoff is if you have to index all of the existing entries
> > in a non-indexed directory.  However, you need to handle this anyways if
> > you are updating an existing non-indexed directory from an old filesystem.

Daniel:
> If I do the optimization just for the first directory block then it's
> very nearly free - just one extra read of the first directory block,
> and it's almost certainly in cache anyway because it was just read to
> see if the entry already exists.

But you still need to handle the case for an arbitrary-sized non-indexed
directory, if you want to be able to upgrade an existing ext2 filesystem.
Since you need this, you may as well only turn indexing when you are
actually getting a speed benefit, because doing anything else still
wastes space.  It may even be that indexing a large existing directory
and _then_ doing the lookup is still faster than doing the lookup on the
original un-indexed directory...

Ted writes:
> A couple of comments.  If you make the beginning of each index block
> look like a an empty directory block:
> 
> 	32 bits: ino == 0
> 	16 bits: rec_len == blocksize
> 	16 bits: name_len = 0

This is what I also suggested for second-level index blocks above.
However, for a single-level index, blocks 1-511 (1-127 on a 1k filesystem)
will be sparse, because they will be unused - we don't want to have 511
(or 127) real empty dir blocks just for compatibility on a single-level
index.  The ext2 dir code handles the case of a sparse directory block
with an ext2_error() and continues.  By default ext2_error() is just
a printk, and on the only system I have seen where it is otherwise
(Debian), it is remount-ro for root only.

> ... then you will have full backwards compatibility, both for reading
> *and* writing.  When reading, old kernels will simply ignore the index
> blocks, since it looks like it has an unpopulated directory entry.  And
> if the kernel attempts to write into the directory, it will clear the
> BTREE_FL flag, in which case new kernels won't treat the directory as a
> tree anymore.

Yes, I had something like this on the tip of my brain as well.  When you
boot with a non-index ext2 kernel, it will naturally find free space in
the first block, immediately after "." and ".." (with the setup above).
Not only will it clear BTREE_FL, it will also overwrite the index magic
(if we have one) so we definitely know that the index is not valid.
Since the index head is only using 4 of the 8 bytes needed for alignment,
we could stick in a 4 byte magic before or after the index header, and
still be assured that it will be overwritten by a new dirent.

Full COMPAT support would be a win, IMHO.  You could leave it to e2fsck
to do reindexing, or the next time a file is added (or even removed)
from a candidate directory it could do the reindexing, which it needs
to be able to do for compatibility with old filesystems.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
