Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131191AbRCGUfx>; Wed, 7 Mar 2001 15:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131184AbRCGUfp>; Wed, 7 Mar 2001 15:35:45 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:5618 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S131177AbRCGUfg>; Wed, 7 Mar 2001 15:35:36 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103072035.f27KZ5V20201@webber.adilger.net>
Subject: Re: [linux-lvm] EXT2-fs panic (device lvm(58,0)):
To: Linux kernel development list <linux-kernel@vger.kernel.org>,
        Linux FS development list <linux-fsdevel@vger.kernel.org>
Date: Wed, 7 Mar 2001 13:35:05 -0700 (MST)
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Clark wrote (to the moderated linux-lvm@sistina.com list):
> Not sure if this is a LVM problem or a ext2fs problem. It is happening
> with the 2.4.2 kernel and the 0.9 release of the LVM user tools.  
> 
> kernel: Kernel panic: EXT2-fs panic (device lvm(58,0)):
> load_block_bitmap: block_group >= groups_count - block_group = 131071,
> groups_count = 24
> 
> There is a 1gig+ file on the filesystem, and most operations on it seem
> to bring about the error.  

Basically, the error you are getting is impossible.  In all calls to
load_block_bitmap(), the "group number" is either checked directly, or
"block" (which is what is used to find "group number") is checked to be <
s_blocks_count, so by inference should return a valid group number.

The only remote possibility is in ext2_free_blocks() if block+count
overflows a 32-bit unsigned value.  Only 2 places call ext2_free_blocks()
with a count != 1, and ext2_free_data() looks to be OK.  The other
possibility is that i_prealloc_count is bogus - that is it!  Nowhere
is i_prealloc_count initialized to zero AFAICS.

In most cases, this would return a "freeing blocks not in datazone" error,
but depending on the values, it may just pass the test.  This may also
be the cause of the errors people have previously reported where it
looks like they are freeing block numbers which look like ASCII data.
This would happen in ext2_discard_prealloc() when we have a value for
i_prealloc_count != 0 (easy) and i_prealloc_block points to some valid
block number (less likely, but moreso on a large filesystem).

Cheers, Andreas
==========================================================================
diff -ru linux/fs/ext2/ialloc.c.orig linux/fs/ext2/ialloc.c
--- linux/fs/ext2/ialloc.c.orig	Fri Dec  8 18:35:54 2000
+++ linux/fs/ext2/ialloc.c	Wed Mar  7 12:22:11 2001
@@ -432,6 +444,8 @@
 	inode->u.ext2_i.i_file_acl = 0;
 	inode->u.ext2_i.i_dir_acl = 0;
 	inode->u.ext2_i.i_dtime = 0;
+	inode->u.ext2_i.i_prealloc_count = 0;
 	inode->u.ext2_i.i_block_group = i;
 	if (inode->u.ext2_i.i_flags & EXT2_SYNC_FL)
 		inode->i_flags |= S_SYNC;
diff -ru linux/fs/ext2/inode.c.orig linux/fs/ext2/inode.c
--- linux/fs/ext2/inode.c.orig	Tue Jan 16 01:29:29 2001
+++ linux/fs/ext2/inode.c	Wed Mar  7 12:05:47 2001
@@ -1048,6 +1038,8 @@
 			(((__u64)le32_to_cpu(raw_inode->i_size_high)) << 32);
	}
 	inode->i_generation = le32_to_cpu(raw_inode->i_generation);
+	inode->u.ext2_i.i_prealloc_count = 0;
 	inode->u.ext2_i.i_block_group = block_group;
 
 	/*
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
