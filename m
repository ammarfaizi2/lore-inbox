Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261289AbRGCJrB>; Tue, 3 Jul 2001 05:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262116AbRGCJqw>; Tue, 3 Jul 2001 05:46:52 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:35018 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261289AbRGCJqk>;
	Tue, 3 Jul 2001 05:46:40 -0400
Date: Tue, 3 Jul 2001 05:46:37 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Ken Brownfield <brownfld@irridia.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Recent change in directory g+s behavior (bug?)
In-Reply-To: <20010703034335.A3735@asooo.flowerfire.com>
Message-ID: <Pine.GSO.4.21.0107030537560.9812-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 3 Jul 2001, Ken Brownfield wrote:

> Somewhere between 2.4.5-pre1 and 2.4.6-pre3, the behavior of the setgid
> bit on directories has changed:

	Fsck... Linus, please apply the patch below. That's a bug in
ext2_new_inode() that used to be hidden by redundant code in ext2_mkdir().

	Notice that current code in ext2_new_inode() makes no sense at all -
the only reason why gcc doesn't scream bloody murder is that we have (unrelated)
S_ISLNK(mode) several lines below.

--- fs/ext2/ialloc.c	Tue Jun  5 09:24:52 2001
+++ fs/ext2/ialloc.c.fix	Tue Jul  3 05:38:37 2001
@@ -417,7 +417,6 @@
 		cpu_to_le32(le32_to_cpu(es->s_free_inodes_count) - 1);
 	mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
 	sb->s_dirt = 1;
-	inode->i_mode = mode;
 	inode->i_uid = current->fsuid;
 	if (test_opt (sb, GRPID))
 		inode->i_gid = dir->i_gid;
@@ -427,6 +426,7 @@
 			mode |= S_ISGID;
 	} else
 		inode->i_gid = current->fsgid;
+	inode->i_mode = mode;
 
 	inode->i_ino = j;
 	inode->i_blksize = PAGE_SIZE;	/* This is the optimal IO size (for stat), not the fs block size */

