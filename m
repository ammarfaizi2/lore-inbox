Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135635AbRDSLzz>; Thu, 19 Apr 2001 07:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135636AbRDSLzo>; Thu, 19 Apr 2001 07:55:44 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:64426 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135635AbRDSLzc>;
	Thu, 19 Apr 2001 07:55:32 -0400
Date: Thu, 19 Apr 2001 07:55:20 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
cc: Andreas Dilger <adilger@turbolinux.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
Subject: ext2 inode size (on-disk)
In-Reply-To: <20001202014045.F2272@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.GSO.4.21.0104190719240.16930-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Erm... Folks, can ->s_inode_size be not a power of 2? Both
libext2fs and kernel break in that case. Example:

dd if=/dev/zero of=foo bs=1024 count=20480
mkfs -I 192 foo

corrupts memory and segfaults. Reason: ext2_read_inode() (same problem
is present in the kernel version of said beast) finds inode offset within
cylinder group piece of inode table, splits it into block*block_size+offset,
reads the block and works with the structure at given offset.

I.e. it does
	group = (ino-1) / inodes_per_group;
	number_in_group = (ino-1) % inodes_per_group;
	offset_in_group = number_in_group * inode_size;
	block_number = inode_table_base[group] + offset_in_group/block_size;
	offset_in_block = offset_in_group % block_size

Guess what happens if inode crosses block boundary? Exactly.

AFAICS we have two sane solutions:

	a) require inode size to be a power of 2

	b) switch to

	group = (ino-1) / inodes_per_group;
	number_in_group = (ino-1) % inodes_per_group;
	block_in_group = number_in_group / inodes_per_block;
	number_in_block = number_in_group % inodes_per_block;
	block = inode_table_fragments[group] + block_in_group;
	offset_in_block = number_in_block * inode_size;

	i.e. instead of current "pack inodes into piece of inode table and
pad it in the end" do "pack inodes into blocks padding the end of every block".

Something has to be done - right now mke2fs effectively mandates "inode size
is a power of 2" and as far as I'm concerned it's OK, but segfaulting is
a bit too drastic way of telling user "don't do it"...
								Al

PS: can we assume that inodes_per_group is a multiple of inodes_per_block
or it isn't guaranteed?

