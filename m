Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131562AbRDSRn3>; Thu, 19 Apr 2001 13:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131614AbRDSRnK>; Thu, 19 Apr 2001 13:43:10 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:32253 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S131562AbRDSRnC>; Thu, 19 Apr 2001 13:43:02 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104191741.f3JHfaMZ013988@webber.adilger.int>
Subject: Re: ext2 inode size (on-disk)
In-Reply-To: <Pine.GSO.4.21.0104190719240.16930-100000@weyl.math.psu.edu>
 "from Alexander Viro at Apr 19, 2001 07:55:20 am"
To: Alexander Viro <viro@math.psu.edu>
Date: Thu, 19 Apr 2001 11:41:36 -0600 (MDT)
CC: linux-kernel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al, you write:
> 	Erm... Folks, can ->s_inode_size be not a power of 2? Both
> libext2fs and kernel break in that case. Example:
> 
> dd if=/dev/zero of=foo bs=1024 count=20480
> mkfs -I 192 foo

I had always assumed that it would be a power-of-two size, but since it
is an undocumented option to mke2fs, I suppose it was never really
intended to be used.  It appears, however, that the mke2fs code
doesn't do ANY checking on the parameter, so you could concievably make
the inode size SMALLER than the current size, and this would DEFINITELY
be bad as well.

> corrupts memory and segfaults. Reason: ext2_read_inode() (same problem
> is present in the kernel version of said beast) finds inode offset within
> cylinder group piece of inode table, splits it into block*block_size+offset,
> reads the block and works with the structure at given offset.

However, we _should_ be safe against this, because ext2_read_super() does:

        if (le32_to_cpu(es->s_rev_level) == EXT2_GOOD_OLD_REV) {
                sb->u.ext2_sb.s_inode_size = EXT2_GOOD_OLD_INODE_SIZE;
                sb->u.ext2_sb.s_first_ino = EXT2_GOOD_OLD_FIRST_INO;
        } else {
                sb->u.ext2_sb.s_inode_size = le16_to_cpu(es->s_inode_size);
                sb->u.ext2_sb.s_first_ino = le32_to_cpu(es->s_first_ino);
                if (sb->u.ext2_sb.s_inode_size != EXT2_GOOD_OLD_INODE_SIZE) {
                        printk ("EXT2-fs: unsupported inode size: %d\n",
                                sb->u.ext2_sb.s_inode_size);
                        goto failed_mount;
                }
        }

Are you talking about user-space code or kernel code when you say it is
segfaulting and corrupting memory?

> 	a) require inode size to be a power of 2

This would be my preferred solution, makes the math in the kernel a lot
faster.  Should probably be put into mke2fs for safety, and also checked
when/if we ever allow the kernel to mount a filesystem with non-power-of-2
inode sizes.

> PS: can we assume that inodes_per_group is a multiple of inodes_per_block
> or it isn't guaranteed?

mke2fs will always set up the filesystem this way, and there is no real
reason NOT to do that.  If you are using a filesystem block for the inode
table, it is pointless to leave part of it empty, because you can't use
it for anything else anyways.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
