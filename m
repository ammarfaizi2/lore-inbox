Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133006AbRDST0i>; Thu, 19 Apr 2001 15:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133005AbRDST03>; Thu, 19 Apr 2001 15:26:29 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:47869 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S133006AbRDST0O>; Thu, 19 Apr 2001 15:26:14 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104191924.f3JJODWr015608@webber.adilger.int>
Subject: Re: ext2 inode size (on-disk)
In-Reply-To: <Pine.GSO.4.21.0104191345400.16930-100000@weyl.math.psu.edu>
 "from Alexander Viro at Apr 19, 2001 02:02:03 pm"
To: Alexander Viro <viro@math.psu.edu>
Date: Thu, 19 Apr 2001 13:24:12 -0600 (MDT)
CC: Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al writes:
> > I had always assumed that it would be a power-of-two size, but since it
> > is an undocumented option to mke2fs, I suppose it was never really
> > intended to be used.  It appears, however, that the mke2fs code
> > doesn't do ANY checking on the parameter, so you could concievably make
> > the inode size SMALLER than the current size, and this would DEFINITELY
> > be bad as well.
> 
> In some sense it does - it dies if you've passed it not a power of two ;-)
> I don't think that segfault is a good way to report the problem, though...

Strange, I run "mke2fs -I 192 /dev/hdc2" and do not have a segfault or any
problems with e2fsck or debugfs on the resulting filesystem.  I'm running
1.20-WIP, but I don't think anything was changed in this area for some time.

However, looking at the output from dumpe2fs shows it is packing inodes
across block boundaries (inode_size = 192, inodes_per_group = 16144,
inode_blocks_per_group = 757).  It is also not filling the last inode
table block (which would give us 16149 inodes).

Also, looking at the disk, it shows garbage data in the space after the
end of the normal inode, and ext2 should always zero-fill unused fields.

Basically, packing inodes across block boundaries is TOTALLY broken.
This can lead to all sorts of data corruption issues if one block is
written to disk, and the other is not.  For that matter, the same would
hold true with any not-power-of-two inode size.  In this case, the
inode will still be crossing a hard disk sector boundary, and have the
(small) possibility that part of the inode is written and part is not.

In this light, the safe inode sizes are 128 (current size), 256, and 512.

> > mke2fs will always set up the filesystem this way, and there is no real
> > reason NOT to do that.  If you are using a filesystem block for the inode
> > table, it is pointless to leave part of it empty, because you can't use
> > it for anything else anyways.
> 
> It's not that simple - if you need 160 bytes per inode rounding it up
> to the next power of two will lose a lot. On 4Kb fs it will be
> 16 inodes per block instead of 25 - 36% loss...

What I was getting at, is that no matter what size of inode we are using,
we should ALWAYS fill the last inode table block as full as possible.  Once
you have allocated a block to the inode table, it should be filled with
as many inodes as fit in a single block.  To do anything else is a waste.

For example, with 160 byte inodes, and a 4k inode table block, we can fit

4096 / 160 = 25 inodes into this block (with 96 bytes remaining)

There is no reason to only have 1 or 2 or 17 inodes in this block.  If we
assume we are not crossing a block boundary with the inode, then
inodes_per_group = n * inodes_per_block, where n = number of inode blocks.

Cheers, Andreas

PS - is this a code cleanup issue, or do you have some reason that you want
     to increase the inode size?
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
