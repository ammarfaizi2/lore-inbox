Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290463AbSAYAf0>; Thu, 24 Jan 2002 19:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290465AbSAYAfQ>; Thu, 24 Jan 2002 19:35:16 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:39811 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S290463AbSAYAfE>;
	Thu, 24 Jan 2002 19:35:04 -0500
Date: Fri, 25 Jan 2002 01:35:02 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200201250035.BAA27730@harpo.it.uu.se>
To: torvalds@transmeta.com, viro@math.psu.edu
Subject: [PATCH] ext2 FS corruption in 2.5.3-pre[3-5]
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al & Linus,

There is a file system corruption problem in 2.5.3-pre[3-5], caused
by leaking uninitialised memory to in-core and later on-disk inodes.

I can easily observe the problem by creating lots of files in an
ext2 FS, reboot to single-user, and fsck the ext2 FS partition.
fsck will then give a lot of warnings about:

"i_fsize for inode NNN (...) is XX, should be zero"

where XX is a random non-zero 8-bit number.

I traced it to the pre2->pre3 transition, which contains:
> - Al Viro: VFS inode allocation moved down to filesystem, trim inodes

When FS-specific data was stored in inode->u, that data was cleared by
the memset() in fs/inode.c:alloc_inode(). The FS didn't have to bother.
Since -pre3, ext2 (and perhaps other FSs, I haven't checked) uses an
in-core inode layout consisting of an FS-specific head followed by the
generic inode. ext2 allocates these in fs/ext2/super.c:ext2_alloc_inode(),
but doesn't clear the ext2-specific fields. fs/inode.c:alloc_inode()
neither knows about these fields nor clears them, so the ext2-specific
data remains uninitialised when the new inode is returned for use. Ouch.

The patch below fixes this by adding the missing memset() to
fs/ext2/super.c:ext2_alloc_inode(). Works fine over here.

/Mikael

--- linux-2.5.3-pre5/fs/ext2/super.c.~1~	Fri Jan 25 00:03:58 2002
+++ linux-2.5.3-pre5/fs/ext2/super.c	Fri Jan 25 00:35:12 2002
@@ -155,6 +155,7 @@
 	ei = (struct ext2_inode_info *)kmem_cache_alloc(ext2_inode_cachep, SLAB_KERNEL);
 	if (!ei)
 		return NULL;
+	memset(ei, 0, offsetof(struct ext2_inode_info, vfs_inode));
 	return &ei->vfs_inode;
 }
 
