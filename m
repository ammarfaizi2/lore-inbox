Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266058AbRGKUAn>; Wed, 11 Jul 2001 16:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266013AbRGKUAd>; Wed, 11 Jul 2001 16:00:33 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:25079 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S266058AbRGKUAX>; Wed, 11 Jul 2001 16:00:23 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107111959.f6BJx22R009430@webber.adilger.int>
Subject: [PATCH] ext2 i_high_size cleanup
To: torvalds@transmeta.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 11 Jul 2001 13:59:02 -0600 (MDT)
CC: Linux kernel development list <linux-kernel@vger.kernel.org>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
Action: 
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up usage of the i_size_high/i_dir_acl* field for ext2 inodes.
The problem was first reported regarding the size of symlinks, but applies
to all non-regular files.  The issue is that we currently load/restore the
"high 32 bits" of the file size for everything except directories* but
none of the other file types actually needs this extended file size.

The correct way to do it (as discussed on ext2-devel) is that this field
is only used for the LFS file size on regular files, and is otherwise
passed through untouched in the i_dir_acl field from whence it came.

(*) The i_dir_acl field is overloaded as i_size_high for regular files.
    It was not clearly defined either way for other file types, but in the
    latest version of e2fsck we ensure that it is the high 32 bits of the
    size only for regular files, as this patch also does.

The patch also removes the i_high_size field (note, not the i_size_high
field previously discussed), which formerly passed the high 32-bits
of the file size through the in-memory inode, before LFS, but it has
become obsolete since i_size is now 64-bits wide (it is only set in one
place and never referenced again anyways, and is only consuming space
in ext2_inode_info these days).

Finally, for setting the COMPAT_LARGE_FILE flag, we should check for
files larger than 2^31-1 (2GB -1), rather than 2^32 (4GB), because this
is what e2fsck (and the LFS spec I think as well) expects for large files.

The patch is against 2.4.6, but should apply cleanly to 2.4.7-preX and
-ac kernels as well.

Cheers, Andreas
==========================================================================
diff -ru linux-2.4.6.orig/fs/ext2/inode.c linux-2.4.6-aed/fs/ext2/inode.c
--- linux-2.4.6.orig/fs/ext2/inode.c	Thu Jun 28 14:28:24 2001
+++ linux-2.4.6-aed/fs/ext2/inode.c	Thu Jun 28 14:27:24 2001
@@ -964,12 +961,10 @@
 	inode->u.ext2_i.i_frag_no = raw_inode->i_frag;
 	inode->u.ext2_i.i_frag_size = raw_inode->i_fsize;
 	inode->u.ext2_i.i_file_acl = le32_to_cpu(raw_inode->i_file_acl);
-	if (S_ISDIR(inode->i_mode))
-		inode->u.ext2_i.i_dir_acl = le32_to_cpu(raw_inode->i_dir_acl);
-	else {
-		inode->u.ext2_i.i_high_size = le32_to_cpu(raw_inode->i_size_high);
+	if (S_ISREG(inode->i_mode))
 		inode->i_size |= ((__u64)le32_to_cpu(raw_inode->i_size_high)) << 32;
-	}
+	else
+		inode->u.ext2_i.i_dir_acl = le32_to_cpu(raw_inode->i_dir_acl);
 	inode->i_generation = le32_to_cpu(raw_inode->i_generation);
 	inode->u.ext2_i.i_prealloc_count = 0;
 	inode->u.ext2_i.i_block_group = block_group;
@@ -1114,7 +1109,7 @@
 		raw_inode->i_dir_acl = cpu_to_le32(inode->u.ext2_i.i_dir_acl);
 	else {
 		raw_inode->i_size_high = cpu_to_le32(inode->i_size >> 32);
-		if (raw_inode->i_size_high) {
+		if (inode->i_size > 0x7fffffffULL) {
 			struct super_block *sb = inode->i_sb;
 			if (!EXT2_HAS_RO_COMPAT_FEATURE(sb,
 					EXT2_FEATURE_RO_COMPAT_LARGE_FILE) ||
diff -ru linux-2.4.6.orig/include/linux/ext2_fs_i.h linux-2.4.6-aed/include/linux/ext2_fs_i.h
--- linux-2.4.6.orig/include/linux/ext2_fs_i.h	Tue May 11 15:37:47 1999
+++ linux-2.4.6-aed/include/linux/ext2_fs_i.h	Thu May  3 16:08:29 2001
@@ -35,7 +35,6 @@
 	__u32	i_next_alloc_goal;
 	__u32	i_prealloc_block;
 	__u32	i_prealloc_count;
-	__u32	i_high_size;
 	int	i_new_inode:1;	/* Is a freshly allocated inode */
 };
 
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
