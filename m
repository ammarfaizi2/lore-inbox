Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbWGCBBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbWGCBBy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 21:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWGCBBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 21:01:41 -0400
Received: from thunk.org ([69.25.196.29]:6084 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750961AbWGCBA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 21:00:26 -0400
Message-Id: <20060703010023.056369000@candygram.thunk.org>
References: <20060703005333.706556000@candygram.thunk.org>
Date: Sun, 02 Jul 2006 20:53:38 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch 5/8] inode-diet: Eliminate i_blksize and use a per-superblock default
Content-Disposition: inline; filename=inode-slim-5
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This eliminates the i_blksize field from struct inode.  Filesystems
that want to provide a per-inode st_blksize can do so by providing
their own getattr routine instead of using the generic_fillattr()
function.

Note that some filesystems were providing pretty much random (and
incorrect) values for i_blksize.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

Index: linux-2.6.17-mm5/include/linux/fs.h
===================================================================
--- linux-2.6.17-mm5.orig/include/linux/fs.h	2006-07-02 20:28:58.000000000 -0400
+++ linux-2.6.17-mm5/include/linux/fs.h	2006-07-02 20:29:16.000000000 -0400
@@ -507,7 +507,6 @@
 	struct timespec		i_mtime;
 	struct timespec		i_ctime;
 	unsigned int		i_blkbits;
-	unsigned long		i_blksize;
 	unsigned long		i_version;
 	blkcnt_t		i_blocks;
 	unsigned short          i_bytes;
Index: linux-2.6.17-mm5/fs/stat.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/stat.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/stat.c	2006-07-02 20:29:16.000000000 -0400
@@ -14,6 +14,7 @@
 #include <linux/namei.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/pagemap.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -32,7 +33,7 @@
 	stat->ctime = inode->i_ctime;
 	stat->size = i_size_read(inode);
 	stat->blocks = inode->i_blocks;
-	stat->blksize = inode->i_blksize;
+	stat->blksize = PAGE_CACHE_SIZE;
 }
 
 EXPORT_SYMBOL(generic_fillattr);
Index: linux-2.6.17-mm5/fs/binfmt_misc.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/binfmt_misc.c	2006-07-02 20:27:00.000000000 -0400
+++ linux-2.6.17-mm5/fs/binfmt_misc.c	2006-07-02 20:29:16.000000000 -0400
@@ -507,7 +507,6 @@
 		inode->i_mode = mode;
 		inode->i_uid = 0;
 		inode->i_gid = 0;
-		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_atime = inode->i_mtime = inode->i_ctime =
 			current_fs_time(inode->i_sb);
Index: linux-2.6.17-mm5/fs/eventpoll.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/eventpoll.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/eventpoll.c	2006-07-02 20:29:16.000000000 -0400
@@ -1590,7 +1590,6 @@
 	inode->i_uid = current->fsuid;
 	inode->i_gid = current->fsgid;
 	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
-	inode->i_blksize = PAGE_SIZE;
 	return inode;
 
 eexit_1:
Index: linux-2.6.17-mm5/fs/libfs.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/libfs.c	2006-07-02 20:27:00.000000000 -0400
+++ linux-2.6.17-mm5/fs/libfs.c	2006-07-02 20:29:16.000000000 -0400
@@ -383,7 +383,6 @@
 		return -ENOMEM;
 	inode->i_mode = S_IFDIR | 0755;
 	inode->i_uid = inode->i_gid = 0;
-	inode->i_blksize = PAGE_CACHE_SIZE;
 	inode->i_blocks = 0;
 	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 	inode->i_op = &simple_dir_inode_operations;
@@ -405,7 +404,6 @@
 			goto out;
 		inode->i_mode = S_IFREG | files->mode;
 		inode->i_uid = inode->i_gid = 0;
-		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		inode->i_fop = files->ops;
Index: linux-2.6.17-mm5/fs/pipe.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/pipe.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/pipe.c	2006-07-02 20:29:16.000000000 -0400
@@ -879,7 +879,6 @@
 	inode->i_uid = current->fsuid;
 	inode->i_gid = current->fsgid;
 	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
-	inode->i_blksize = PAGE_SIZE;
 
 	return inode;
 
Index: linux-2.6.17-mm5/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/arch/powerpc/platforms/cell/spufs/inode.c	2006-07-02 20:27:00.000000000 -0400
+++ linux-2.6.17-mm5/arch/powerpc/platforms/cell/spufs/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -82,7 +82,6 @@
 	inode->i_mode = mode;
 	inode->i_uid = current->fsuid;
 	inode->i_gid = current->fsgid;
-	inode->i_blksize = PAGE_CACHE_SIZE;
 	inode->i_blocks = 0;
 	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 out:
Index: linux-2.6.17-mm5/drivers/isdn/capi/capifs.c
===================================================================
--- linux-2.6.17-mm5.orig/drivers/isdn/capi/capifs.c	2006-07-02 20:25:32.000000000 -0400
+++ linux-2.6.17-mm5/drivers/isdn/capi/capifs.c	2006-07-02 20:29:16.000000000 -0400
@@ -104,7 +104,6 @@
 	inode->i_ino = 1;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	inode->i_blocks = 0;
-	inode->i_blksize = 1024;
 	inode->i_uid = inode->i_gid = 0;
 	inode->i_mode = S_IFDIR | S_IRUGO | S_IXUGO | S_IWUSR;
 	inode->i_op = &simple_dir_inode_operations;
@@ -149,7 +148,6 @@
 	if (!inode)
 		return;
 	inode->i_ino = number+2;
-	inode->i_blksize = 1024;
 	inode->i_uid = config.setuid ? config.uid : current->fsuid;
 	inode->i_gid = config.setgid ? config.gid : current->fsgid;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
Index: linux-2.6.17-mm5/drivers/misc/ibmasm/ibmasmfs.c
===================================================================
--- linux-2.6.17-mm5.orig/drivers/misc/ibmasm/ibmasmfs.c	2006-07-02 20:27:00.000000000 -0400
+++ linux-2.6.17-mm5/drivers/misc/ibmasm/ibmasmfs.c	2006-07-02 20:29:16.000000000 -0400
@@ -147,7 +147,6 @@
 	if (ret) {
 		ret->i_mode = mode;
 		ret->i_uid = ret->i_gid = 0;
-		ret->i_blksize = PAGE_CACHE_SIZE;
 		ret->i_blocks = 0;
 		ret->i_atime = ret->i_mtime = ret->i_ctime = CURRENT_TIME;
 	}
Index: linux-2.6.17-mm5/drivers/oprofile/oprofilefs.c
===================================================================
--- linux-2.6.17-mm5.orig/drivers/oprofile/oprofilefs.c	2006-07-02 20:27:00.000000000 -0400
+++ linux-2.6.17-mm5/drivers/oprofile/oprofilefs.c	2006-07-02 20:29:16.000000000 -0400
@@ -31,7 +31,6 @@
 		inode->i_mode = mode;
 		inode->i_uid = 0;
 		inode->i_gid = 0;
-		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 	}
Index: linux-2.6.17-mm5/drivers/usb/core/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/drivers/usb/core/inode.c	2006-07-02 20:27:00.000000000 -0400
+++ linux-2.6.17-mm5/drivers/usb/core/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -249,7 +249,6 @@
 		inode->i_mode = mode;
 		inode->i_uid = current->fsuid;
 		inode->i_gid = current->fsgid;
-		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		switch (mode & S_IFMT) {
Index: linux-2.6.17-mm5/drivers/usb/gadget/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/drivers/usb/gadget/inode.c	2006-07-02 20:27:00.000000000 -0400
+++ linux-2.6.17-mm5/drivers/usb/gadget/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -1966,7 +1966,6 @@
 		inode->i_mode = mode;
 		inode->i_uid = default_uid;
 		inode->i_gid = default_gid;
-		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_atime = inode->i_mtime = inode->i_ctime
 				= CURRENT_TIME;
Index: linux-2.6.17-mm5/fs/9p/vfs_inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/9p/vfs_inode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/9p/vfs_inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -204,7 +204,6 @@
 		inode->i_mode = mode;
 		inode->i_uid = current->fsuid;
 		inode->i_gid = current->fsgid;
-		inode->i_blksize = sb->s_blocksize;
 		inode->i_blocks = 0;
 		inode->i_rdev = 0;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
@@ -950,9 +949,8 @@
 
 	inode->i_size = stat->length;
 
-	inode->i_blksize = sb->s_blocksize;
 	inode->i_blocks =
-	    (inode->i_size + inode->i_blksize - 1) >> sb->s_blocksize_bits;
+	    (inode->i_size + sb->s_blocksize - 1) >> sb->s_blocksize_bits;
 }
 
 /**
Index: linux-2.6.17-mm5/fs/adfs/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/adfs/inode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/adfs/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -269,7 +269,6 @@
 	inode->i_ino	 = obj->file_id;
 	inode->i_size	 = obj->size;
 	inode->i_nlink	 = 2;
-	inode->i_blksize = PAGE_SIZE;
 	inode->i_blocks	 = (inode->i_size + sb->s_blocksize - 1) >>
 			    sb->s_blocksize_bits;
 
Index: linux-2.6.17-mm5/fs/afs/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/afs/inode.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17-mm5/fs/afs/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -72,7 +72,6 @@
 	inode->i_ctime.tv_sec	= vnode->status.mtime_server;
 	inode->i_ctime.tv_nsec	= 0;
 	inode->i_atime		= inode->i_mtime = inode->i_ctime;
-	inode->i_blksize	= PAGE_CACHE_SIZE;
 	inode->i_blocks		= 0;
 	inode->i_version	= vnode->fid.unique;
 	inode->i_mapping->a_ops	= &afs_fs_aops;
Index: linux-2.6.17-mm5/fs/autofs/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/autofs/inode.c	2006-07-02 20:27:00.000000000 -0400
+++ linux-2.6.17-mm5/fs/autofs/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -216,7 +216,6 @@
 	inode->i_nlink = 2;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	inode->i_blocks = 0;
-	inode->i_blksize = 1024;
 
 	if ( ino == AUTOFS_ROOT_INO ) {
 		inode->i_mode = S_IFDIR | S_IRUGO | S_IXUGO | S_IWUSR;
Index: linux-2.6.17-mm5/fs/autofs4/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/autofs4/inode.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17-mm5/fs/autofs4/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -446,7 +446,6 @@
 		inode->i_uid = 0;
 		inode->i_gid = 0;
 	}
-	inode->i_blksize = PAGE_CACHE_SIZE;
 	inode->i_blocks = 0;
 	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 
Index: linux-2.6.17-mm5/fs/befs/linuxvfs.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/befs/linuxvfs.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/befs/linuxvfs.c	2006-07-02 20:29:16.000000000 -0400
@@ -365,7 +365,6 @@
 	inode->i_mtime.tv_nsec = 0;   /* lower 16 bits are not a time */	
 	inode->i_ctime = inode->i_mtime;
 	inode->i_atime = inode->i_mtime;
-	inode->i_blksize = befs_sb->block_size;
 
 	befs_ino->i_inode_num = fsrun_to_cpu(sb, raw_inode->inode_num);
 	befs_ino->i_parent = fsrun_to_cpu(sb, raw_inode->parent);
Index: linux-2.6.17-mm5/fs/bfs/dir.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/bfs/dir.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17-mm5/fs/bfs/dir.c	2006-07-02 20:29:16.000000000 -0400
@@ -102,7 +102,7 @@
 	inode->i_uid = current->fsuid;
 	inode->i_gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->fsgid;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
-	inode->i_blocks = inode->i_blksize = 0;
+	inode->i_blocks = 0;
 	inode->i_op = &bfs_file_inops;
 	inode->i_fop = &bfs_file_operations;
 	inode->i_mapping->a_ops = &bfs_aops;
Index: linux-2.6.17-mm5/fs/bfs/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/bfs/inode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/bfs/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -76,7 +76,6 @@
 	inode->i_size = BFS_FILESIZE(di);
 	inode->i_blocks = BFS_FILEBLOCKS(di);
         if (inode->i_size || inode->i_blocks) dprintf("Registered inode with %lld size, %ld blocks\n", inode->i_size, inode->i_blocks);
-	inode->i_blksize = PAGE_SIZE;
 	inode->i_atime.tv_sec =  le32_to_cpu(di->i_atime);
 	inode->i_mtime.tv_sec =  le32_to_cpu(di->i_mtime);
 	inode->i_ctime.tv_sec =  le32_to_cpu(di->i_ctime);
Index: linux-2.6.17-mm5/fs/configfs/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/configfs/inode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/configfs/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -136,7 +136,6 @@
 {
 	struct inode * inode = new_inode(configfs_sb);
 	if (inode) {
-		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_mapping->a_ops = &configfs_aops;
 		inode->i_mapping->backing_dev_info = &configfs_backing_dev_info;
Index: linux-2.6.17-mm5/fs/cramfs/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/cramfs/inode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/cramfs/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -73,7 +73,6 @@
 	inode->i_uid = cramfs_inode->uid;
 	inode->i_size = cramfs_inode->size;
 	inode->i_blocks = (cramfs_inode->size - 1) / 512 + 1;
-	inode->i_blksize = PAGE_CACHE_SIZE;
 	inode->i_gid = cramfs_inode->gid;
 	/* Struct copy intentional */
 	inode->i_mtime = inode->i_atime = inode->i_ctime = zerotime;
Index: linux-2.6.17-mm5/fs/debugfs/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/debugfs/inode.c	2006-07-02 20:27:00.000000000 -0400
+++ linux-2.6.17-mm5/fs/debugfs/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -40,7 +40,6 @@
 		inode->i_mode = mode;
 		inode->i_uid = 0;
 		inode->i_gid = 0;
-		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		switch (mode & S_IFMT) {
Index: linux-2.6.17-mm5/fs/devpts/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/devpts/inode.c	2006-07-02 20:27:00.000000000 -0400
+++ linux-2.6.17-mm5/fs/devpts/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -113,7 +113,6 @@
 	inode->i_ino = 1;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	inode->i_blocks = 0;
-	inode->i_blksize = 1024;
 	inode->i_uid = inode->i_gid = 0;
 	inode->i_mode = S_IFDIR | S_IRUGO | S_IXUGO | S_IWUSR;
 	inode->i_op = &simple_dir_inode_operations;
@@ -172,7 +171,6 @@
 		return -ENOMEM;
 
 	inode->i_ino = number+2;
-	inode->i_blksize = 1024;
 	inode->i_uid = config.setuid ? config.uid : current->fsuid;
 	inode->i_gid = config.setgid ? config.gid : current->fsgid;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
Index: linux-2.6.17-mm5/fs/ext2/ialloc.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/ext2/ialloc.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/ext2/ialloc.c	2006-07-02 20:29:16.000000000 -0400
@@ -574,7 +574,6 @@
 	inode->i_mode = mode;
 
 	inode->i_ino = ino;
-	inode->i_blksize = PAGE_SIZE;	/* This is the optimal IO size (for stat), not the fs block size */
 	inode->i_blocks = 0;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
 	memset(ei->i_data, 0, sizeof(ei->i_data));
Index: linux-2.6.17-mm5/fs/ext2/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/ext2/inode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/ext2/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -1094,7 +1094,6 @@
 		brelse (bh);
 		goto bad_inode;
 	}
-	inode->i_blksize = PAGE_SIZE;	/* This is the optimal IO size (for stat), not the fs block size */
 	inode->i_blocks = le32_to_cpu(raw_inode->i_blocks);
 	ei->i_flags = le32_to_cpu(raw_inode->i_flags);
 	ei->i_faddr = le32_to_cpu(raw_inode->i_faddr);
Index: linux-2.6.17-mm5/fs/ext3/ialloc.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/ext3/ialloc.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/ext3/ialloc.c	2006-07-02 20:29:16.000000000 -0400
@@ -559,7 +559,6 @@
 
 	inode->i_ino = ino;
 	/* This is the optimal IO size (for stat), not the fs block size */
-	inode->i_blksize = PAGE_SIZE;
 	inode->i_blocks = 0;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
 
Index: linux-2.6.17-mm5/fs/ext3/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/ext3/inode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/ext3/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -2628,9 +2628,6 @@
 		 * recovery code: that's fine, we're about to complete
 		 * the process of deleting those. */
 	}
-	inode->i_blksize = PAGE_SIZE;	/* This is the optimal IO size
-					 * (for stat), not the fs block
-					 * size */  
 	inode->i_blocks = le32_to_cpu(raw_inode->i_blocks);
 	ei->i_flags = le32_to_cpu(raw_inode->i_flags);
 #ifdef EXT3_FRAGMENTS
Index: linux-2.6.17-mm5/fs/fat/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/fat/inode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/fat/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -375,8 +375,6 @@
 			inode->i_flags |= S_IMMUTABLE;
 	}
 	MSDOS_I(inode)->i_attrs = de->attr & ATTR_UNUSED;
-	/* this is as close to the truth as we can get ... */
-	inode->i_blksize = sbi->cluster_size;
 	inode->i_blocks = ((inode->i_size + (sbi->cluster_size - 1))
 			   & ~((loff_t)sbi->cluster_size - 1)) >> 9;
 	inode->i_mtime.tv_sec =
@@ -1137,7 +1135,6 @@
 		MSDOS_I(inode)->i_start = 0;
 		inode->i_size = sbi->dir_entries * sizeof(struct msdos_dir_entry);
 	}
-	inode->i_blksize = sbi->cluster_size;
 	inode->i_blocks = ((inode->i_size + (sbi->cluster_size - 1))
 			   & ~((loff_t)sbi->cluster_size - 1)) >> 9;
 	MSDOS_I(inode)->i_logstart = 0;
Index: linux-2.6.17-mm5/fs/freevxfs/vxfs_inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/freevxfs/vxfs_inode.c	2006-07-02 20:27:00.000000000 -0400
+++ linux-2.6.17-mm5/fs/freevxfs/vxfs_inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -239,7 +239,6 @@
 	ip->i_ctime.tv_nsec = 0;
 	ip->i_mtime.tv_nsec = 0;
 
-	ip->i_blksize = PAGE_SIZE;
 	ip->i_blocks = vip->vii_blocks;
 	ip->i_generation = vip->vii_gen;
 
Index: linux-2.6.17-mm5/fs/fuse/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/fuse/inode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/fuse/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -118,7 +118,6 @@
 	inode->i_uid     = attr->uid;
 	inode->i_gid     = attr->gid;
 	i_size_write(inode, attr->size);
-	inode->i_blksize = PAGE_CACHE_SIZE;
 	inode->i_blocks  = attr->blocks;
 	inode->i_atime.tv_sec   = attr->atime;
 	inode->i_atime.tv_nsec  = attr->atimensec;
Index: linux-2.6.17-mm5/fs/hfs/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/hfs/inode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/hfs/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -154,7 +154,6 @@
 	inode->i_gid = current->fsgid;
 	inode->i_nlink = 1;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
-	inode->i_blksize = HFS_SB(sb)->alloc_blksz;
 	HFS_I(inode)->flags = 0;
 	HFS_I(inode)->rsrc_inode = NULL;
 	HFS_I(inode)->fs_blocks = 0;
@@ -284,7 +283,6 @@
 	inode->i_uid = hsb->s_uid;
 	inode->i_gid = hsb->s_gid;
 	inode->i_nlink = 1;
-	inode->i_blksize = HFS_SB(inode->i_sb)->alloc_blksz;
 
 	if (idata->key)
 		HFS_I(inode)->cat_key = *idata->key;
Index: linux-2.6.17-mm5/fs/hfsplus/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/hfsplus/inode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/hfsplus/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -304,7 +304,6 @@
 	inode->i_gid = current->fsgid;
 	inode->i_nlink = 1;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
-	inode->i_blksize = HFSPLUS_SB(sb).alloc_blksz;
 	INIT_LIST_HEAD(&HFSPLUS_I(inode).open_dir_list);
 	init_MUTEX(&HFSPLUS_I(inode).extents_lock);
 	atomic_set(&HFSPLUS_I(inode).opencnt, 0);
@@ -407,7 +406,6 @@
 	type = hfs_bnode_read_u16(fd->bnode, fd->entryoffset);
 
 	HFSPLUS_I(inode).dev = 0;
-	inode->i_blksize = HFSPLUS_SB(inode->i_sb).alloc_blksz;
 	if (type == HFSPLUS_FOLDER) {
 		struct hfsplus_cat_folder *folder = &entry.folder;
 
Index: linux-2.6.17-mm5/fs/hpfs/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/hpfs/inode.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17-mm5/fs/hpfs/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -17,7 +17,6 @@
 	i->i_gid = hpfs_sb(sb)->sb_gid;
 	i->i_mode = hpfs_sb(sb)->sb_mode;
 	hpfs_inode->i_conv = hpfs_sb(sb)->sb_conv;
-	i->i_blksize = 512;
 	i->i_size = -1;
 	i->i_blocks = -1;
 	
Index: linux-2.6.17-mm5/fs/hppfs/hppfs_kern.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/hppfs/hppfs_kern.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/hppfs/hppfs_kern.c	2006-07-02 20:29:16.000000000 -0400
@@ -152,7 +152,6 @@
 	ino->i_mode = proc_ino->i_mode;
 	ino->i_nlink = proc_ino->i_nlink;
 	ino->i_size = proc_ino->i_size;
-	ino->i_blksize = proc_ino->i_blksize;
 	ino->i_blocks = proc_ino->i_blocks;
 }
 
Index: linux-2.6.17-mm5/fs/isofs/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/isofs/inode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/isofs/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -1238,7 +1238,7 @@
 	}
 	inode->i_uid = sbi->s_uid;
 	inode->i_gid = sbi->s_gid;
-	inode->i_blocks = inode->i_blksize = 0;
+	inode->i_blocks = 0;
 
 	ei->i_format_parm[0] = 0;
 	ei->i_format_parm[1] = 0;
@@ -1294,7 +1294,6 @@
 			      isonum_711 (de->ext_attr_length));
 
 	/* Set the number of blocks for stat() - should be done before RR */
-	inode->i_blksize = PAGE_CACHE_SIZE; /* For stat() only */
 	inode->i_blocks  = (inode->i_size + 511) >> 9;
 
 	/*
Index: linux-2.6.17-mm5/fs/jffs/inode-v23.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/jffs/inode-v23.c	2006-07-02 20:27:00.000000000 -0400
+++ linux-2.6.17-mm5/fs/jffs/inode-v23.c	2006-07-02 20:29:16.000000000 -0400
@@ -364,7 +364,6 @@
 	inode->i_ctime.tv_nsec = 0;
 	inode->i_mtime.tv_nsec = 0;
 	inode->i_atime.tv_nsec = 0;
-	inode->i_blksize = PAGE_SIZE;
 	inode->i_blocks = (inode->i_size + 511) >> 9;
 
 	f = jffs_find_file(c, raw_inode->ino);
@@ -1706,7 +1705,6 @@
 	inode->i_mtime.tv_nsec = 
 	inode->i_ctime.tv_nsec = 0;
 
-	inode->i_blksize = PAGE_SIZE;
 	inode->i_blocks = (inode->i_size + 511) >> 9;
 	if (S_ISREG(inode->i_mode)) {
 		inode->i_op = &jffs_file_inode_operations;
Index: linux-2.6.17-mm5/fs/jffs2/fs.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/jffs2/fs.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/jffs2/fs.c	2006-07-02 20:29:16.000000000 -0400
@@ -263,7 +263,6 @@
 
 	inode->i_nlink = f->inocache->nlink;
 
-	inode->i_blksize = PAGE_SIZE;
 	inode->i_blocks = (inode->i_size + 511) >> 9;
 
 	switch (inode->i_mode & S_IFMT) {
@@ -449,7 +448,6 @@
 	inode->i_atime = inode->i_ctime = inode->i_mtime = CURRENT_TIME_SEC;
 	ri->atime = ri->mtime = ri->ctime = cpu_to_je32(I_SEC(inode->i_mtime));
 
-	inode->i_blksize = PAGE_SIZE;
 	inode->i_blocks = 0;
 	inode->i_size = 0;
 
Index: linux-2.6.17-mm5/fs/minix/bitmap.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/minix/bitmap.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17-mm5/fs/minix/bitmap.c	2006-07-02 20:29:16.000000000 -0400
@@ -254,7 +254,7 @@
 	inode->i_gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->fsgid;
 	inode->i_ino = j;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
-	inode->i_blocks = inode->i_blksize = 0;
+	inode->i_blocks = 0;
 	memset(&minix_i(inode)->u, 0, sizeof(minix_i(inode)->u));
 	insert_inode_hash(inode);
 	mark_inode_dirty(inode);
Index: linux-2.6.17-mm5/fs/minix/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/minix/inode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/minix/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -392,7 +392,7 @@
 	inode->i_mtime.tv_nsec = 0;
 	inode->i_atime.tv_nsec = 0;
 	inode->i_ctime.tv_nsec = 0;
-	inode->i_blocks = inode->i_blksize = 0;
+	inode->i_blocks = 0;
 	for (i = 0; i < 9; i++)
 		minix_inode->u.i1_data[i] = raw_inode->i_zone[i];
 	minix_set_inode(inode, old_decode_dev(raw_inode->i_zone[0]));
@@ -425,7 +425,7 @@
 	inode->i_mtime.tv_nsec = 0;
 	inode->i_atime.tv_nsec = 0;
 	inode->i_ctime.tv_nsec = 0;
-	inode->i_blocks = inode->i_blksize = 0;
+	inode->i_blocks = 0;
 	for (i = 0; i < 10; i++)
 		minix_inode->u.i2_data[i] = raw_inode->i_zone[i];
 	minix_set_inode(inode, old_decode_dev(raw_inode->i_zone[0]));
Index: linux-2.6.17-mm5/fs/ntfs/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/ntfs/inode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/ntfs/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -556,8 +556,6 @@
 
 	/* Setup the generic vfs inode parts now. */
 
-	/* This is the optimal IO size (for stat), not the fs block size. */
-	vi->i_blksize = PAGE_CACHE_SIZE;
 	/*
 	 * This is for checking whether an inode has changed w.r.t. a file so
 	 * that the file can be updated if necessary (compare with f_version).
@@ -1234,7 +1232,6 @@
 	base_ni = NTFS_I(base_vi);
 
 	/* Just mirror the values from the base inode. */
-	vi->i_blksize	= base_vi->i_blksize;
 	vi->i_version	= base_vi->i_version;
 	vi->i_uid	= base_vi->i_uid;
 	vi->i_gid	= base_vi->i_gid;
@@ -1504,7 +1501,6 @@
 	ni	= NTFS_I(vi);
 	base_ni = NTFS_I(base_vi);
 	/* Just mirror the values from the base inode. */
-	vi->i_blksize	= base_vi->i_blksize;
 	vi->i_version	= base_vi->i_version;
 	vi->i_uid	= base_vi->i_uid;
 	vi->i_gid	= base_vi->i_gid;
Index: linux-2.6.17-mm5/fs/ntfs/mft.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/ntfs/mft.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17-mm5/fs/ntfs/mft.c	2006-07-02 20:29:16.000000000 -0400
@@ -2638,11 +2638,6 @@
 		}
 		vi->i_ino = bit;
 		/*
-		 * This is the optimal IO size (for stat), not the fs block
-		 * size.
-		 */
-		vi->i_blksize = PAGE_CACHE_SIZE;
-		/*
 		 * This is for checking whether an inode has changed w.r.t. a
 		 * file so that the file can be updated if necessary (compare
 		 * with f_version).
Index: linux-2.6.17-mm5/fs/ocfs2/dlm/dlmfs.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/ocfs2/dlm/dlmfs.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/ocfs2/dlm/dlmfs.c	2006-07-02 20:29:16.000000000 -0400
@@ -335,7 +335,6 @@
 		inode->i_mode = mode;
 		inode->i_uid = current->fsuid;
 		inode->i_gid = current->fsgid;
-		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_mapping->backing_dev_info = &dlmfs_backing_dev_info;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
@@ -362,7 +361,6 @@
 	inode->i_mode = mode;
 	inode->i_uid = current->fsuid;
 	inode->i_gid = current->fsgid;
-	inode->i_blksize = PAGE_CACHE_SIZE;
 	inode->i_blocks = 0;
 	inode->i_mapping->backing_dev_info = &dlmfs_backing_dev_info;
 	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
Index: linux-2.6.17-mm5/fs/ocfs2/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/ocfs2/inode.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17-mm5/fs/ocfs2/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -251,7 +251,6 @@
 	inode->i_mode = le16_to_cpu(fe->i_mode);
 	inode->i_uid = le32_to_cpu(fe->i_uid);
 	inode->i_gid = le32_to_cpu(fe->i_gid);
-	inode->i_blksize = (u32)osb->s_clustersize;
 
 	/* Fast symlinks will have i_size but no allocated clusters. */
 	if (S_ISLNK(inode->i_mode) && !fe->i_clusters)
@@ -1174,7 +1173,6 @@
 	inode->i_uid = le32_to_cpu(fe->i_uid);
 	inode->i_gid = le32_to_cpu(fe->i_gid);
 	inode->i_mode = le16_to_cpu(fe->i_mode);
-	inode->i_blksize = (u32) osb->s_clustersize;
 	if (S_ISLNK(inode->i_mode) && le32_to_cpu(fe->i_clusters) == 0)
 		inode->i_blocks = 0;
 	else
Index: linux-2.6.17-mm5/fs/qnx4/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/qnx4/inode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/qnx4/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -497,7 +497,6 @@
 	inode->i_ctime.tv_sec   = le32_to_cpu(raw_inode->di_ctime);
 	inode->i_ctime.tv_nsec = 0;
 	inode->i_blocks  = le32_to_cpu(raw_inode->di_first_xtnt.xtnt_size);
-	inode->i_blksize = QNX4_DIR_ENTRY_SIZE;
 
 	memcpy(qnx4_inode, raw_inode, QNX4_DIR_ENTRY_SIZE);
 	if (S_ISREG(inode->i_mode)) {
Index: linux-2.6.17-mm5/fs/ramfs/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/ramfs/inode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/ramfs/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -58,7 +58,6 @@
 		inode->i_mode = mode;
 		inode->i_uid = current->fsuid;
 		inode->i_gid = current->fsgid;
-		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_mapping->a_ops = &ramfs_aops;
 		inode->i_mapping->backing_dev_info = &ramfs_backing_dev_info;
Index: linux-2.6.17-mm5/fs/reiserfs/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/reiserfs/inode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/reiserfs/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -17,8 +17,6 @@
 #include <linux/writeback.h>
 #include <linux/quotaops.h>
 
-extern int reiserfs_default_io_size;	/* default io size devuned in super.c */
-
 static int reiserfs_commit_write(struct file *f, struct page *page,
 				 unsigned from, unsigned to);
 static int reiserfs_prepare_write(struct file *f, struct page *page,
@@ -1130,7 +1128,6 @@
 	ih = PATH_PITEM_HEAD(path);
 
 	copy_key(INODE_PKEY(inode), &(ih->ih_key));
-	inode->i_blksize = reiserfs_default_io_size;
 
 	INIT_LIST_HEAD(&(REISERFS_I(inode)->i_prealloc_list));
 	REISERFS_I(inode)->i_flags = 0;
@@ -1885,7 +1882,6 @@
 	}
 	// these do not go to on-disk stat data
 	inode->i_ino = le32_to_cpu(ih.ih_key.k_objectid);
-	inode->i_blksize = reiserfs_default_io_size;
 
 	// store in in-core inode the key of stat data and version all
 	// object items will have (directory items will have old offset
Index: linux-2.6.17-mm5/fs/sysfs/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/sysfs/inode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/sysfs/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -113,7 +113,6 @@
 {
 	struct inode * inode = new_inode(sysfs_sb);
 	if (inode) {
-		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_mapping->a_ops = &sysfs_aops;
 		inode->i_mapping->backing_dev_info = &sysfs_backing_dev_info;
Index: linux-2.6.17-mm5/fs/sysv/ialloc.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/sysv/ialloc.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17-mm5/fs/sysv/ialloc.c	2006-07-02 20:29:16.000000000 -0400
@@ -170,7 +170,7 @@
 	inode->i_uid = current->fsuid;
 	inode->i_ino = fs16_to_cpu(sbi, ino);
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
-	inode->i_blocks = inode->i_blksize = 0;
+	inode->i_blocks = 0;
 	memset(SYSV_I(inode)->i_data, 0, sizeof(SYSV_I(inode)->i_data));
 	SYSV_I(inode)->i_dir_start_lookup = 0;
 	insert_inode_hash(inode);
Index: linux-2.6.17-mm5/fs/sysv/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/sysv/inode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/sysv/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -201,7 +201,7 @@
 	inode->i_ctime.tv_nsec = 0;
 	inode->i_atime.tv_nsec = 0;
 	inode->i_mtime.tv_nsec = 0;
-	inode->i_blocks = inode->i_blksize = 0;
+	inode->i_blocks = 0;
 
 	si = SYSV_I(inode);
 	for (block = 0; block < 10+1+1+1; block++)
Index: linux-2.6.17-mm5/fs/udf/ialloc.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/udf/ialloc.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17-mm5/fs/udf/ialloc.c	2006-07-02 20:29:16.000000000 -0400
@@ -120,7 +120,6 @@
 	UDF_I_LOCATION(inode).logicalBlockNum = block;
 	UDF_I_LOCATION(inode).partitionReferenceNum = UDF_I_LOCATION(dir).partitionReferenceNum;
 	inode->i_ino = udf_get_lb_pblock(sb, UDF_I_LOCATION(inode), 0);
-	inode->i_blksize = PAGE_SIZE;
 	inode->i_blocks = 0;
 	UDF_I_LENEATTR(inode) = 0;
 	UDF_I_LENALLOC(inode) = 0;
Index: linux-2.6.17-mm5/fs/udf/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/udf/inode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/udf/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -916,8 +916,6 @@
 	 *      i_nlink = 1
 	 *      i_op = NULL;
 	 */
-	inode->i_blksize = PAGE_SIZE;
-
 	bh = udf_read_ptagged(inode->i_sb, UDF_I_LOCATION(inode), 0, &ident);
 
 	if (!bh)
Index: linux-2.6.17-mm5/fs/ufs/ialloc.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/ufs/ialloc.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/ufs/ialloc.c	2006-07-02 20:29:16.000000000 -0400
@@ -255,7 +255,6 @@
 		inode->i_gid = current->fsgid;
 
 	inode->i_ino = cg * uspi->s_ipg + bit;
-	inode->i_blksize = PAGE_SIZE;	/* This is the optimal IO size (for stat), not the fs block size */
 	inode->i_blocks = 0;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
 	ufsi->i_flags = UFS_I(dir)->i_flags;
Index: linux-2.6.17-mm5/include/linux/nfsd/nfsfh.h
===================================================================
--- linux-2.6.17-mm5.orig/include/linux/nfsd/nfsfh.h	2006-07-02 20:25:49.000000000 -0400
+++ linux-2.6.17-mm5/include/linux/nfsd/nfsfh.h	2006-07-02 20:29:16.000000000 -0400
@@ -269,14 +269,8 @@
 	fhp->fh_post_uid	= inode->i_uid;
 	fhp->fh_post_gid	= inode->i_gid;
 	fhp->fh_post_size       = inode->i_size;
-	if (inode->i_blksize) {
-		fhp->fh_post_blksize    = inode->i_blksize;
-		fhp->fh_post_blocks     = inode->i_blocks;
-	} else {
-		fhp->fh_post_blksize    = BLOCK_SIZE;
-		/* how much do we care for accuracy with MinixFS? */
-		fhp->fh_post_blocks     = (inode->i_size+511) >> 9;
-	}
+	fhp->fh_post_blksize    = BLOCK_SIZE;
+	fhp->fh_post_blocks     = inode->i_blocks;
 	fhp->fh_post_rdev[0]    = htonl((u32)imajor(inode));
 	fhp->fh_post_rdev[1]    = htonl((u32)iminor(inode));
 	fhp->fh_post_atime      = inode->i_atime;
Index: linux-2.6.17-mm5/ipc/mqueue.c
===================================================================
--- linux-2.6.17-mm5.orig/ipc/mqueue.c	2006-07-02 20:25:49.000000000 -0400
+++ linux-2.6.17-mm5/ipc/mqueue.c	2006-07-02 20:29:16.000000000 -0400
@@ -115,7 +115,6 @@
 		inode->i_mode = mode;
 		inode->i_uid = current->fsuid;
 		inode->i_gid = current->fsgid;
-		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_mtime = inode->i_ctime = inode->i_atime =
 				CURRENT_TIME;
Index: linux-2.6.17-mm5/kernel/cpuset.c
===================================================================
--- linux-2.6.17-mm5.orig/kernel/cpuset.c	2006-07-02 20:25:49.000000000 -0400
+++ linux-2.6.17-mm5/kernel/cpuset.c	2006-07-02 20:29:16.000000000 -0400
@@ -289,7 +289,6 @@
 		inode->i_mode = mode;
 		inode->i_uid = current->fsuid;
 		inode->i_gid = current->fsgid;
-		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		inode->i_mapping->backing_dev_info = &cpuset_backing_dev_info;
Index: linux-2.6.17-mm5/mm/shmem.c
===================================================================
--- linux-2.6.17-mm5.orig/mm/shmem.c	2006-07-02 20:25:49.000000000 -0400
+++ linux-2.6.17-mm5/mm/shmem.c	2006-07-02 20:29:16.000000000 -0400
@@ -1350,7 +1350,6 @@
 		inode->i_mode = mode;
 		inode->i_uid = current->fsuid;
 		inode->i_gid = current->fsgid;
-		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_mapping->a_ops = &shmem_aops;
 		inode->i_mapping->backing_dev_info = &shmem_backing_dev_info;
Index: linux-2.6.17-mm5/net/sunrpc/rpc_pipe.c
===================================================================
--- linux-2.6.17-mm5.orig/net/sunrpc/rpc_pipe.c	2006-07-02 20:25:50.000000000 -0400
+++ linux-2.6.17-mm5/net/sunrpc/rpc_pipe.c	2006-07-02 20:29:16.000000000 -0400
@@ -490,7 +490,6 @@
 		return NULL;
 	inode->i_mode = mode;
 	inode->i_uid = inode->i_gid = 0;
-	inode->i_blksize = PAGE_CACHE_SIZE;
 	inode->i_blocks = 0;
 	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 	switch(mode & S_IFMT) {
Index: linux-2.6.17-mm5/security/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/security/inode.c	2006-07-02 20:27:00.000000000 -0400
+++ linux-2.6.17-mm5/security/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -64,7 +64,6 @@
 		inode->i_mode = mode;
 		inode->i_uid = 0;
 		inode->i_gid = 0;
-		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		switch (mode & S_IFMT) {
Index: linux-2.6.17-mm5/security/selinux/selinuxfs.c
===================================================================
--- linux-2.6.17-mm5.orig/security/selinux/selinuxfs.c	2006-07-02 20:25:50.000000000 -0400
+++ linux-2.6.17-mm5/security/selinux/selinuxfs.c	2006-07-02 20:29:16.000000000 -0400
@@ -771,7 +771,6 @@
 	if (ret) {
 		ret->i_mode = mode;
 		ret->i_uid = ret->i_gid = 0;
-		ret->i_blksize = PAGE_CACHE_SIZE;
 		ret->i_blocks = 0;
 		ret->i_atime = ret->i_mtime = ret->i_ctime = CURRENT_TIME;
 	}
Index: linux-2.6.17-mm5/fs/cifs/cifsfs.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/cifs/cifsfs.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/cifs/cifsfs.c	2006-07-02 20:29:16.000000000 -0400
@@ -255,7 +255,6 @@
 	file data or metadata */
 	cifs_inode->clientCanCacheRead = FALSE;
 	cifs_inode->clientCanCacheAll = FALSE;
-	cifs_inode->vfs_inode.i_blksize = CIFS_MAX_MSGSIZE;
 	cifs_inode->vfs_inode.i_blkbits = 14;  /* 2**14 = CIFS_MAX_MSGSIZE */
 	cifs_inode->vfs_inode.i_flags = S_NOATIME | S_NOCMTIME;
 	INIT_LIST_HEAD(&cifs_inode->openFileList);
Index: linux-2.6.17-mm5/fs/cifs/readdir.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/cifs/readdir.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/cifs/readdir.c	2006-07-02 20:29:16.000000000 -0400
@@ -219,10 +219,9 @@
 
 	if (allocation_size < end_of_file)
 		cFYI(1, ("May be sparse file, allocation less than file size"));
-	cFYI(1, ("File Size %ld and blocks %llu and blocksize %ld",
+	cFYI(1, ("File Size %ld and blocks %llu",
 		(unsigned long)tmp_inode->i_size,
-		(unsigned long long)tmp_inode->i_blocks,
-		tmp_inode->i_blksize));
+		(unsigned long long)tmp_inode->i_blocks));
 	if (S_ISREG(tmp_inode->i_mode)) {
 		cFYI(1, ("File inode"));
 		tmp_inode->i_op = &cifs_file_inode_ops;
Index: linux-2.6.17-mm5/fs/hugetlbfs/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/hugetlbfs/inode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/hugetlbfs/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -359,7 +359,6 @@
 		inode->i_mode = mode;
 		inode->i_uid = uid;
 		inode->i_gid = gid;
-		inode->i_blksize = HPAGE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_mapping->a_ops = &hugetlbfs_aops;
 		inode->i_mapping->backing_dev_info =&hugetlbfs_backing_dev_info;
Index: linux-2.6.17-mm5/fs/jfs/jfs_extent.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/jfs/jfs_extent.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/jfs/jfs_extent.c	2006-07-02 20:29:16.000000000 -0400
@@ -468,7 +468,7 @@
 int extFill(struct inode *ip, xad_t * xp)
 {
 	int rc, nbperpage = JFS_SBI(ip->i_sb)->nbperpage;
-	s64 blkno = offsetXAD(xp) >> ip->i_blksize;
+	s64 blkno = offsetXAD(xp) >> ip->i_blkbits;
 
 //      assert(ISSPARSE(ip));
 
Index: linux-2.6.17-mm5/fs/jfs/jfs_imap.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/jfs/jfs_imap.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17-mm5/fs/jfs/jfs_imap.c	2006-07-02 20:29:16.000000000 -0400
@@ -3115,7 +3115,6 @@
 	ip->i_mtime.tv_nsec = le32_to_cpu(dip->di_mtime.tv_nsec);
 	ip->i_ctime.tv_sec = le32_to_cpu(dip->di_ctime.tv_sec);
 	ip->i_ctime.tv_nsec = le32_to_cpu(dip->di_ctime.tv_nsec);
-	ip->i_blksize = ip->i_sb->s_blocksize;
 	ip->i_blocks = LBLK2PBLK(ip->i_sb, le64_to_cpu(dip->di_nblocks));
 	ip->i_generation = le32_to_cpu(dip->di_gen);
 
Index: linux-2.6.17-mm5/fs/jfs/jfs_inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/jfs/jfs_inode.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17-mm5/fs/jfs/jfs_inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -115,7 +115,6 @@
 	}
 	jfs_inode->mode2 |= mode;
 
-	inode->i_blksize = sb->s_blocksize;
 	inode->i_blocks = 0;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	jfs_inode->otime = inode->i_ctime.tv_sec;
Index: linux-2.6.17-mm5/fs/jfs/jfs_metapage.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/jfs/jfs_metapage.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/jfs/jfs_metapage.c	2006-07-02 20:29:16.000000000 -0400
@@ -257,7 +257,7 @@
 	int rc = 0;
 	int xflag;
 	s64 xaddr;
-	sector_t file_blocks = (inode->i_size + inode->i_blksize - 1) >>
+	sector_t file_blocks = (inode->i_size + inode->i_sb->s_blocksize - 1) >>
 			       inode->i_blkbits;
 
 	if (lblock >= file_blocks)
Index: linux-2.6.17-mm5/fs/ncpfs/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/ncpfs/inode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/ncpfs/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -224,7 +224,6 @@
 	inode->i_nlink = 1;
 	inode->i_uid = server->m.uid;
 	inode->i_gid = server->m.gid;
-	inode->i_blksize = NCP_BLOCK_SIZE;
 
 	ncp_update_dates(inode, &nwinfo->i);
 	ncp_update_inode(inode, nwinfo);
Index: linux-2.6.17-mm5/drivers/block/loop.c
===================================================================
--- linux-2.6.17-mm5.orig/drivers/block/loop.c	2006-07-02 20:25:29.000000000 -0400
+++ linux-2.6.17-mm5/drivers/block/loop.c	2006-07-02 20:29:16.000000000 -0400
@@ -662,7 +662,8 @@
 
 	mapping_set_gfp_mask(old_file->f_mapping, lo->old_gfp_mask);
 	lo->lo_backing_file = file;
-	lo->lo_blocksize = mapping->host->i_blksize;
+	lo->lo_blocksize = S_ISBLK(mapping->host->i_mode) ?
+		mapping->host->i_bdev->bd_block_size : PAGE_SIZE;
 	lo->old_gfp_mask = mapping_gfp_mask(mapping);
 	mapping_set_gfp_mask(mapping, lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
 	complete(&p->wait);
@@ -800,7 +801,9 @@
 		if (!(lo_flags & LO_FLAGS_USE_AOPS) && !file->f_op->write)
 			lo_flags |= LO_FLAGS_READ_ONLY;
 
-		lo_blocksize = inode->i_blksize;
+		lo_blocksize = S_ISBLK(inode->i_mode) ?
+			inode->i_bdev->bd_block_size : PAGE_SIZE;
+
 		error = 0;
 	} else {
 		goto out_putf;
Index: linux-2.6.17-mm5/fs/coda/coda_linux.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/coda/coda_linux.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17-mm5/fs/coda/coda_linux.c	2006-07-02 20:29:16.000000000 -0400
@@ -110,8 +110,6 @@
 	        inode->i_nlink = attr->va_nlink;
 	if (attr->va_size != -1)
 	        inode->i_size = attr->va_size;
-	if (attr->va_blocksize != -1)
-		inode->i_blksize = attr->va_blocksize;
 	if (attr->va_size != -1)
 		inode->i_blocks = (attr->va_size + 511) >> 9;
 	if (attr->va_atime.tv_sec != -1) 
Index: linux-2.6.17-mm5/fs/smbfs/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/smbfs/inode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/smbfs/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -167,7 +167,6 @@
 	fattr->f_mtime	= inode->i_mtime;
 	fattr->f_ctime	= inode->i_ctime;
 	fattr->f_atime	= inode->i_atime;
-	fattr->f_blksize= inode->i_blksize;
 	fattr->f_blocks	= inode->i_blocks;
 
 	fattr->attr	= SMB_I(inode)->attr;
@@ -201,7 +200,6 @@
 	inode->i_uid	= fattr->f_uid;
 	inode->i_gid	= fattr->f_gid;
 	inode->i_ctime	= fattr->f_ctime;
-	inode->i_blksize= fattr->f_blksize;
 	inode->i_blocks = fattr->f_blocks;
 	inode->i_size	= fattr->f_size;
 	inode->i_mtime	= fattr->f_mtime;
Index: linux-2.6.17-mm5/fs/smbfs/proc.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/smbfs/proc.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/smbfs/proc.c	2006-07-02 20:29:16.000000000 -0400
@@ -1826,7 +1826,6 @@
 	fattr->f_nlink = 1;
 	fattr->f_uid = server->mnt->uid;
 	fattr->f_gid = server->mnt->gid;
-	fattr->f_blksize = SMB_ST_BLKSIZE;
 	fattr->f_unix = 0;
 }
 
Index: linux-2.6.17-mm5/include/linux/smb.h
===================================================================
--- linux-2.6.17-mm5.orig/include/linux/smb.h	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17-mm5/include/linux/smb.h	2006-07-02 20:29:16.000000000 -0400
@@ -88,7 +88,6 @@
 	struct timespec	f_atime;
 	struct timespec f_mtime;
 	struct timespec f_ctime;
-	unsigned long	f_blksize;
 	unsigned long	f_blocks;
 	int		f_unix;
 };
Index: linux-2.6.17-mm5/fs/hostfs/hostfs_kern.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/hostfs/hostfs_kern.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/hostfs/hostfs_kern.c	2006-07-02 20:29:16.000000000 -0400
@@ -156,7 +156,6 @@
 	ino->i_mode = i_mode;
 	ino->i_nlink = i_nlink;
 	ino->i_size = i_size;
-	ino->i_blksize = i_blksize;
 	ino->i_blocks = i_blocks;
 	return(0);
 }
Index: linux-2.6.17-mm5/fs/nfs/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/nfs/inode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/nfs/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -282,10 +282,8 @@
 			 * report the blocks in 512byte units
 			 */
 			inode->i_blocks = nfs_calc_block_size(fattr->du.nfs3.used);
-			inode->i_blksize = inode->i_sb->s_blocksize;
 		} else {
 			inode->i_blocks = fattr->du.nfs2.blocks;
-			inode->i_blksize = fattr->du.nfs2.blocksize;
 		}
 		nfsi->attrtimeo = NFS_MINATTRTIMEO(inode);
 		nfsi->attrtimeo_timestamp = jiffies;
@@ -970,10 +968,8 @@
 		 * report the blocks in 512byte units
 		 */
 		inode->i_blocks = nfs_calc_block_size(fattr->du.nfs3.used);
-		inode->i_blksize = inode->i_sb->s_blocksize;
  	} else {
  		inode->i_blocks = fattr->du.nfs2.blocks;
- 		inode->i_blksize = fattr->du.nfs2.blocksize;
  	}
 
 	if ((fattr->valid & NFS_ATTR_FATTR_V4) != 0 &&
Index: linux-2.6.17-mm5/fs/xfs/linux-2.6/xfs_super.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/xfs/linux-2.6/xfs_super.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/xfs/linux-2.6/xfs_super.c	2006-07-02 20:29:16.000000000 -0400
@@ -171,7 +171,6 @@
 		break;
 	}
 
-	inode->i_blksize = xfs_preferred_iosize(mp);
 	inode->i_generation = ip->i_d.di_gen;
 	i_size_write(inode, ip->i_d.di_size);
 	inode->i_blocks =
Index: linux-2.6.17-mm5/fs/xfs/linux-2.6/xfs_vnode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/xfs/linux-2.6/xfs_vnode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/xfs/linux-2.6/xfs_vnode.c	2006-07-02 20:29:16.000000000 -0400
@@ -122,7 +122,6 @@
 	inode->i_blocks	    = vap->va_nblocks;
 	inode->i_mtime	    = vap->va_mtime;
 	inode->i_ctime	    = vap->va_ctime;
-	inode->i_blksize    = vap->va_blocksize;
 	if (vap->va_xflags & XFS_XFLAG_IMMUTABLE)
 		inode->i_flags |= S_IMMUTABLE;
 	else
Index: linux-2.6.17-mm5/drivers/infiniband/hw/ipath/ipath_fs.c
===================================================================
--- linux-2.6.17-mm5.orig/drivers/infiniband/hw/ipath/ipath_fs.c	2006-07-02 20:27:00.000000000 -0400
+++ linux-2.6.17-mm5/drivers/infiniband/hw/ipath/ipath_fs.c	2006-07-02 20:29:16.000000000 -0400
@@ -61,7 +61,6 @@
 	inode->i_mode = mode;
 	inode->i_uid = 0;
 	inode->i_gid = 0;
-	inode->i_blksize = PAGE_CACHE_SIZE;
 	inode->i_blocks = 0;
 	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 	inode->i_private = data;
Index: linux-2.6.17-mm5/arch/s390/hypfs/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/arch/s390/hypfs/inode.c	2006-07-02 20:27:00.000000000 -0400
+++ linux-2.6.17-mm5/arch/s390/hypfs/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -91,7 +91,6 @@
 		ret->i_mode = mode;
 		ret->i_uid = hypfs_info->uid;
 		ret->i_gid = hypfs_info->gid;
-		ret->i_blksize = PAGE_CACHE_SIZE;
 		ret->i_blocks = 0;
 		ret->i_atime = ret->i_mtime = ret->i_ctime = CURRENT_TIME;
 		if (mode & S_IFDIR)
Index: linux-2.6.17-mm5/fs/ecryptfs/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/ecryptfs/inode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/ecryptfs/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -91,7 +91,6 @@
 	dest->i_atime = src->i_atime;
 	dest->i_mtime = src->i_mtime;
 	dest->i_ctime = src->i_ctime;
-	dest->i_blksize = src->i_blksize;
 	dest->i_blkbits = src->i_blkbits;
 	dest->i_flags = src->i_flags;
 }
Index: linux-2.6.17-mm5/fs/gfs2/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/gfs2/inode.c	2006-07-02 20:27:00.000000000 -0400
+++ linux-2.6.17-mm5/fs/gfs2/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -69,7 +69,6 @@
 	inode->i_atime.tv_nsec = 0;
 	inode->i_mtime.tv_nsec = 0;
 	inode->i_ctime.tv_nsec = 0;
-	inode->i_blksize = PAGE_SIZE;
 	inode->i_blocks = ip->i_di.di_blocks <<
 		(GFS2_SB(inode)->sd_sb.sb_bsize_shift - GFS2_BASIC_BLOCK_SHIFT);
 
Index: linux-2.6.17-mm5/fs/reiser4/plugin/item/static_stat.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/reiser4/plugin/item/static_stat.c	2006-07-02 20:27:00.000000000 -0400
+++ linux-2.6.17-mm5/fs/reiser4/plugin/item/static_stat.c	2006-07-02 20:29:16.000000000 -0400
@@ -169,7 +169,6 @@
 	}
 	state->extmask = bigmask;
 	/* common initialisations */
-	inode->i_blksize = get_super_private(inode->i_sb)->optimal_io_size;
 	if (len - (bit / 16 * sizeof(d16)) > 0) {
 		/* alignment in save_len_static_sd() is taken into account
 		   -edward */
Index: linux-2.6.17-mm5/fs/ufs/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/ufs/inode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/ufs/inode.c	2006-07-02 20:29:16.000000000 -0400
@@ -734,7 +734,6 @@
 		ufs1_read_inode(inode, ufs_inode + ufs_inotofsbo(inode->i_ino));
 	}
 
-	inode->i_blksize = PAGE_SIZE;/*This is the optimal IO size (for stat)*/
 	inode->i_version++;
 	ufsi->i_lastfrag =
 		(inode->i_size + uspi->s_fsize - 1) >> uspi->s_fshift;

--
