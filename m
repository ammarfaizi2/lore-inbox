Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267500AbRHBRpb>; Thu, 2 Aug 2001 13:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267534AbRHBRpX>; Thu, 2 Aug 2001 13:45:23 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:63127 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S267500AbRHBRpN>;
	Thu, 2 Aug 2001 13:45:13 -0400
Date: Thu, 2 Aug 2001 13:45:20 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <Torvalds@Transmeta.COM>
cc: Nikita Danilov <NikitaDanilov@Yahoo.COM>,
        Reiserfs developers mail-list <Reiserfs-Dev@Namesys.COM>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: reiserfs: D-clear-i_blocks.patch
In-Reply-To: <15209.30134.699801.417492@beta.namesys.com>
Message-ID: <Pine.GSO.4.21.0108021322360.29563-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Aug 2001, Nikita Danilov wrote:

> Hello, Linus,
> 
> This patch sets inode.i_blocks to zero on deletion of reiserfs
> file. This in particular cures hard to believe bug when saving file in
> EMACS caused top to loose sight of all processes:
>  . reiserfs didn't properly cleared i_blocks when removing
>    symlinks. Actually -7 was inserted into unsigned i_blocks field. This
>    didn't usually hurt because file is being deleted;
>  . inode is reused for procfs and neither get_new_inode() nor
>    proc_read_inode() cleared i_blocks;
>  . now procfs inode has huge i_blocks field;
>  . top calls stat on it and libc wrapper returns EOVERFLOW, as i_blocks
>    doesn't fit into user-level struct.
>  . top sees nothing.
>   
> [lkml: please CC me, I am not subscribed.]

Thanks for spotting, but I have to disagree with analysis.
	a) it's a procfs bug. We leave ->i_blocks uninitialized and inode
constructor leaves it in undefined state.
	b) I'd rather fix it once in fs/inode.c::clean_inode() instead of
hunting similar bugs down again and again.

See if the patch below works for you. It makes sure that inodes passed to
->read_inode() or returned by new_inode() have zero in i_blocks and removes
the redundant assignments in filesystems. Warning: it's completely untested.

diff -urN S8-pre3/drivers/isdn/avmb1/capifs.c S8-pre3-i_blocks/drivers/isdn/avmb1/capifs.c
--- S8-pre3/drivers/isdn/avmb1/capifs.c	Tue Jul  3 21:09:09 2001
+++ S8-pre3-i_blocks/drivers/isdn/avmb1/capifs.c	Thu Aug  2 13:30:28 2001
@@ -389,7 +389,6 @@
 	struct inode *inode = new_inode(sb);
 	if (inode) {
 		inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
-		inode->i_blocks = 0;
 		inode->i_blksize = 1024;
 		inode->i_uid = inode->i_gid = 0;
 	}
diff -urN S8-pre3/fs/autofs/inode.c S8-pre3-i_blocks/fs/autofs/inode.c
--- S8-pre3/fs/autofs/inode.c	Tue Jul  3 21:09:13 2001
+++ S8-pre3-i_blocks/fs/autofs/inode.c	Thu Aug  2 13:30:47 2001
@@ -212,7 +212,6 @@
 	inode->i_mode = S_IFDIR | S_IRUGO | S_IXUGO;
 	inode->i_nlink = 2;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
-	inode->i_blocks = 0;
 	inode->i_blksize = 1024;
 
 	if ( ino == AUTOFS_ROOT_INO ) {
diff -urN S8-pre3/fs/autofs4/inode.c S8-pre3-i_blocks/fs/autofs4/inode.c
--- S8-pre3/fs/autofs4/inode.c	Fri Feb 16 22:52:15 2001
+++ S8-pre3-i_blocks/fs/autofs4/inode.c	Thu Aug  2 13:30:51 2001
@@ -307,7 +307,6 @@
 		inode->i_gid = 0;
 	}
 	inode->i_blksize = PAGE_CACHE_SIZE;
-	inode->i_blocks = 0;
 	inode->i_rdev = 0;
 	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 
diff -urN S8-pre3/fs/bfs/dir.c S8-pre3-i_blocks/fs/bfs/dir.c
--- S8-pre3/fs/bfs/dir.c	Fri Feb 16 20:12:01 2001
+++ S8-pre3-i_blocks/fs/bfs/dir.c	Thu Aug  2 13:31:10 2001
@@ -93,7 +93,7 @@
 	inode->i_uid = current->fsuid;
 	inode->i_gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->fsgid;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
-	inode->i_blocks = inode->i_blksize = 0;
+	inode->i_blksize = 0;
 	inode->i_op = &bfs_file_inops;
 	inode->i_fop = &bfs_file_operations;
 	inode->i_mapping->a_ops = &bfs_aops;
diff -urN S8-pre3/fs/devfs/base.c S8-pre3-i_blocks/fs/devfs/base.c
--- S8-pre3/fs/devfs/base.c	Sun Jul 29 01:54:47 2001
+++ S8-pre3-i_blocks/fs/devfs/base.c	Thu Aug  2 13:31:31 2001
@@ -2263,7 +2263,6 @@
 	printk ("%s: read_inode(%d): VFS inode: %p  devfs_entry: %p\n",
 		DEVFS_NAME, (int) inode->i_ino, inode, de);
 #endif
-    inode->i_blocks = 0;
     inode->i_blksize = 1024;
     inode->i_op = &devfs_iops;
     inode->i_fop = &devfs_fops;
diff -urN S8-pre3/fs/devpts/inode.c S8-pre3-i_blocks/fs/devpts/inode.c
--- S8-pre3/fs/devpts/inode.c	Wed Apr 18 00:35:58 2001
+++ S8-pre3-i_blocks/fs/devpts/inode.c	Thu Aug  2 13:31:40 2001
@@ -145,7 +145,6 @@
 		goto fail_free;
 	inode->i_ino = 1;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
-	inode->i_blocks = 0;
 	inode->i_blksize = 1024;
 	inode->i_uid = inode->i_gid = 0;
 	inode->i_mode = S_IFDIR | S_IRUGO | S_IXUGO | S_IWUSR;
@@ -193,7 +192,6 @@
 	if (!inode)
 		return;
 	inode->i_ino = number+2;
-	inode->i_blocks = 0;
 	inode->i_blksize = 1024;
 	inode->i_uid = sbi->setuid ? sbi->uid : current->fsuid;
 	inode->i_gid = sbi->setgid ? sbi->gid : current->fsgid;
diff -urN S8-pre3/fs/efs/inode.c S8-pre3-i_blocks/fs/efs/inode.c
--- S8-pre3/fs/efs/inode.c	Fri Feb 16 13:07:52 2001
+++ S8-pre3-i_blocks/fs/efs/inode.c	Thu Aug  2 13:32:14 2001
@@ -93,11 +93,8 @@
 	inode->i_ctime = be32_to_cpu(efs_inode->di_ctime);
 
 	/* this is the number of blocks in the file */
-	if (inode->i_size == 0) {
-		inode->i_blocks = 0;
-	} else {
+	if (inode->i_size)
 		inode->i_blocks = ((inode->i_size - 1) >> EFS_BLOCKSIZE_BITS) + 1;
-	}
 
 	/*
 	 * BUG: irix dev_t is 32-bits. linux dev_t is only 16-bits.
diff -urN S8-pre3/fs/ext2/ialloc.c S8-pre3-i_blocks/fs/ext2/ialloc.c
--- S8-pre3/fs/ext2/ialloc.c	Tue Jul  3 21:09:13 2001
+++ S8-pre3-i_blocks/fs/ext2/ialloc.c	Thu Aug  2 13:32:24 2001
@@ -431,7 +431,6 @@
 
 	inode->i_ino = j;
 	inode->i_blksize = PAGE_SIZE;	/* This is the optimal IO size (for stat), not the fs block size */
-	inode->i_blocks = 0;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	inode->u.ext2_i.i_new_inode = 1;
 	inode->u.ext2_i.i_flags = dir->u.ext2_i.i_flags;
diff -urN S8-pre3/fs/inode.c S8-pre3-i_blocks/fs/inode.c
--- S8-pre3/fs/inode.c	Sun Jul 29 01:54:47 2001
+++ S8-pre3-i_blocks/fs/inode.c	Thu Aug  2 13:38:23 2001
@@ -750,6 +750,7 @@
 	inode->i_nlink = 1;
 	atomic_set(&inode->i_writecount, 0);
 	inode->i_size = 0;
+	inode->i_blocks = 0;
 	inode->i_generation = 0;
 	memset(&inode->i_dquot, 0, sizeof(inode->i_dquot));
 	inode->i_pipe = NULL;
diff -urN S8-pre3/fs/isofs/inode.c S8-pre3-i_blocks/fs/isofs/inode.c
--- S8-pre3/fs/isofs/inode.c	Thu Apr 19 23:46:45 2001
+++ S8-pre3-i_blocks/fs/isofs/inode.c	Thu Aug  2 13:33:16 2001
@@ -1173,7 +1173,7 @@
 	}
 	inode->i_uid = inode->i_sb->u.isofs_sb.s_uid;
 	inode->i_gid = inode->i_sb->u.isofs_sb.s_gid;
-	inode->i_blocks = inode->i_blksize = 0;
+	inode->i_blksize = 0;
 
 
 	inode->u.isofs_i.i_section_size = isonum_733 (de->size);
diff -urN S8-pre3/fs/minix/bitmap.c S8-pre3-i_blocks/fs/minix/bitmap.c
--- S8-pre3/fs/minix/bitmap.c	Fri Feb 16 20:12:05 2001
+++ S8-pre3-i_blocks/fs/minix/bitmap.c	Thu Aug  2 13:33:50 2001
@@ -261,7 +261,7 @@
 	inode->i_gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->fsgid;
 	inode->i_ino = j;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
-	inode->i_blocks = inode->i_blksize = 0;
+	inode->i_blksize = 0;
 	insert_inode_hash(inode);
 	mark_inode_dirty(inode);
 
diff -urN S8-pre3/fs/minix/inode.c S8-pre3-i_blocks/fs/minix/inode.c
--- S8-pre3/fs/minix/inode.c	Thu Apr 19 23:46:46 2001
+++ S8-pre3-i_blocks/fs/minix/inode.c	Thu Aug  2 13:34:06 2001
@@ -456,7 +456,7 @@
 	inode->i_nlink = raw_inode->i_nlinks;
 	inode->i_size = raw_inode->i_size;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = raw_inode->i_time;
-	inode->i_blocks = inode->i_blksize = 0;
+	inode->i_blksize = 0;
 	for (block = 0; block < 9; block++)
 		inode->u.minix_i.u.i1_data[block] = raw_inode->i_zone[block];
 	if (S_ISREG(inode->i_mode)) {
@@ -509,7 +509,7 @@
 	inode->i_mtime = raw_inode->i_mtime;
 	inode->i_atime = raw_inode->i_atime;
 	inode->i_ctime = raw_inode->i_ctime;
-	inode->i_blocks = inode->i_blksize = 0;
+	inode->i_blksize = 0;
 	for (block = 0; block < 10; block++)
 		inode->u.minix_i.u.i2_data[block] = raw_inode->i_zone[block];
 	if (S_ISREG(inode->i_mode)) {
diff -urN S8-pre3/fs/ramfs/inode.c S8-pre3-i_blocks/fs/ramfs/inode.c
--- S8-pre3/fs/ramfs/inode.c	Thu May 24 18:26:54 2001
+++ S8-pre3-i_blocks/fs/ramfs/inode.c	Thu Aug  2 13:34:25 2001
@@ -117,7 +117,6 @@
 		inode->i_uid = current->fsuid;
 		inode->i_gid = current->fsgid;
 		inode->i_blksize = PAGE_CACHE_SIZE;
-		inode->i_blocks = 0;
 		inode->i_rdev = NODEV;
 		inode->i_mapping->a_ops = &ramfs_aops;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
diff -urN S8-pre3/fs/reiserfs/inode.c S8-pre3-i_blocks/fs/reiserfs/inode.c
--- S8-pre3/fs/reiserfs/inode.c	Sun Jul 29 01:54:47 2001
+++ S8-pre3-i_blocks/fs/reiserfs/inode.c	Thu Aug  2 13:34:54 2001
@@ -940,7 +940,6 @@
 	inode->i_op = &page_symlink_inode_operations;
 	inode->i_mapping->a_ops = &reiserfs_address_space_operations;
     } else {
-	inode->i_blocks = 0;
 	init_special_inode(inode, inode->i_mode, rdev) ;
     }
 }
diff -urN S8-pre3/fs/sysv/ialloc.c S8-pre3-i_blocks/fs/sysv/ialloc.c
--- S8-pre3/fs/sysv/ialloc.c	Sun Jul 29 01:54:48 2001
+++ S8-pre3-i_blocks/fs/sysv/ialloc.c	Thu Aug  2 13:36:08 2001
@@ -164,7 +164,7 @@
 	inode->i_uid = current->fsuid;
 	inode->i_ino = fs16_to_cpu(sb, ino);
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
-	inode->i_blocks = inode->i_blksize = 0;
+	inode->i_blksize = 0;
 	insert_inode_hash(inode);
 	mark_inode_dirty(inode);
 
diff -urN S8-pre3/fs/sysv/inode.c S8-pre3-i_blocks/fs/sysv/inode.c
--- S8-pre3/fs/sysv/inode.c	Sun Jul 29 01:54:48 2001
+++ S8-pre3-i_blocks/fs/sysv/inode.c	Thu Aug  2 13:36:13 2001
@@ -171,7 +171,7 @@
 	inode->i_atime = fs32_to_cpu(sb, raw_inode->i_atime);
 	inode->i_mtime = fs32_to_cpu(sb, raw_inode->i_mtime);
 	inode->i_ctime = fs32_to_cpu(sb, raw_inode->i_ctime);
-	inode->i_blocks = inode->i_blksize = 0;
+	inode->i_blksize = 0;
 	for (block = 0; block < 10+1+1+1; block++)
 		read3byte(sb, &raw_inode->i_a.i_addb[3*block],
 			(unsigned char*)&inode->u.sysv_i.i_data[block]);
diff -urN S8-pre3/fs/udf/ialloc.c S8-pre3-i_blocks/fs/udf/ialloc.c
--- S8-pre3/fs/udf/ialloc.c	Tue Jul  3 21:09:13 2001
+++ S8-pre3-i_blocks/fs/udf/ialloc.c	Thu Aug  2 13:36:22 2001
@@ -128,7 +128,6 @@
 	UDF_I_LOCATION(inode).partitionReferenceNum = UDF_I_LOCATION(dir).partitionReferenceNum;
 	inode->i_ino = udf_get_lb_pblock(sb, UDF_I_LOCATION(inode), 0);
 	inode->i_blksize = PAGE_SIZE;
-	inode->i_blocks = 0;
 	UDF_I_LENEATTR(inode) = 0;
 	UDF_I_LENALLOC(inode) = 0;
 	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_EXTENDED_FE))
diff -urN S8-pre3/fs/ufs/ialloc.c S8-pre3-i_blocks/fs/ufs/ialloc.c
--- S8-pre3/fs/ufs/ialloc.c	Fri Feb 16 20:12:10 2001
+++ S8-pre3-i_blocks/fs/ufs/ialloc.c	Thu Aug  2 13:37:05 2001
@@ -268,7 +268,6 @@
 
 	inode->i_ino = cg * uspi->s_ipg + bit;
 	inode->i_blksize = PAGE_SIZE;	/* This is the optimal IO size (for stat), not the fs block size */
-	inode->i_blocks = 0;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	inode->u.ufs_i.i_flags = dir->u.ufs_i.i_flags;
 	inode->u.ufs_i.i_lastfrag = 0;
diff -urN S8-pre3/mm/shmem.c S8-pre3-i_blocks/mm/shmem.c
--- S8-pre3/mm/shmem.c	Sun Jul 29 01:54:48 2001
+++ S8-pre3-i_blocks/mm/shmem.c	Thu Aug  2 13:37:35 2001
@@ -508,7 +508,6 @@
 		inode->i_uid = current->fsuid;
 		inode->i_gid = current->fsgid;
 		inode->i_blksize = PAGE_CACHE_SIZE;
-		inode->i_blocks = 0;
 		inode->i_rdev = NODEV;
 		inode->i_mapping->a_ops = &shmem_aops;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;

