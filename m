Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262416AbVAPDii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbVAPDii (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 22:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbVAPDii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 22:38:38 -0500
Received: from mail.suse.de ([195.135.220.2]:6562 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262413AbVAPDh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 22:37:59 -0500
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] Ext3 nanosecond timestamps in big inodes
Date: Fri, 14 Jan 2005 22:16:12 +0100
User-Agent: KMail/1.7.1
Cc: Alex Tomas <alex@clusterfs.com>, Andrew Tridgell <tridge@samba.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501142216.12726.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is a spin-off of an old patch by Alex Tomas <alex@clusterfs.com>:
Alex originally had nanosecond timestamps in his original patch; here is
a rejuvenated version. Please tell me what you think. Alex also added a
create timestamp in his original patch. Do we actually need that?

Nanoseconds consume 30 bits in the 32-bit fields. The remaining two bits 
currently are zeroed out implicitly. We could later use them remaining two 
bits for years beyond 2038.

Index: linux-2.6.11-rc1-mm1/fs/ext3/inode.c
===================================================================
--- linux-2.6.11-rc1-mm1.orig/fs/ext3/inode.c
+++ linux-2.6.11-rc1-mm1/fs/ext3/inode.c
@@ -628,7 +628,7 @@ static int ext3_splice_branch(handle_t *
 
 	/* We are done with atomic stuff, now do the rest of housekeeping */
 
-	inode->i_ctime = CURRENT_TIME_SEC;
+	inode->i_ctime = ext3_current_time(inode);
 	ext3_mark_inode_dirty(handle, inode);
 
 	/* had we spliced it onto indirect block? */
@@ -2201,7 +2201,7 @@ do_indirects:
 			;
 	}
 	up(&ei->truncate_sem);
-	inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
+	inode->i_mtime = inode->i_ctime = ext3_current_time(inode);
 	ext3_mark_inode_dirty(handle, inode);
 
 	/* In a multi-transaction truncate, we only make the final
@@ -2501,6 +2501,14 @@ void ext3_read_inode(struct inode * inod
 				ei->i_extra_isize;
 		if (le32_to_cpu(*magic))
 			 ei->i_state |= EXT3_STATE_XATTR;
+		if (ei->i_extra_isize >= 2*sizeof(__le16) + 3*sizeof(__le32)) {
+			inode->i_atime.tv_nsec =
+				le32_to_cpu(raw_inode->i_atime_nsec);
+			inode->i_ctime.tv_nsec =
+				le32_to_cpu(raw_inode->i_ctime_nsec);
+			inode->i_mtime.tv_nsec =
+				le32_to_cpu(raw_inode->i_mtime_nsec);
+		}
 	}
 
 	if (S_ISREG(inode->i_mode)) {
@@ -2638,8 +2646,17 @@ static int ext3_do_update_inode(handle_t
 	} else for (block = 0; block < EXT3_N_BLOCKS; block++)
 		raw_inode->i_block[block] = ei->i_data[block];
 
-	if (EXT3_INODE_SIZE(inode->i_sb) > EXT3_GOOD_OLD_INODE_SIZE)
+	if (ei->i_extra_isize) {
 		raw_inode->i_extra_isize = cpu_to_le16(ei->i_extra_isize);
+		if (ei->i_extra_isize > 2*sizeof(__le16) + 3*sizeof(__le32)) {
+			raw_inode->i_atime_nsec =
+				cpu_to_le32(inode->i_atime.tv_nsec);
+			raw_inode->i_ctime_nsec =
+				cpu_to_le32(inode->i_ctime.tv_nsec);
+			raw_inode->i_mtime_nsec =
+				cpu_to_le32(inode->i_mtime.tv_nsec);
+		}
+	}
 
 	BUFFER_TRACE(bh, "call ext3_journal_dirty_metadata");
 	rc = ext3_journal_dirty_metadata(handle, bh);
Index: linux-2.6.11-rc1-mm1/fs/ext3/super.c
===================================================================
--- linux-2.6.11-rc1-mm1.orig/fs/ext3/super.c
+++ linux-2.6.11-rc1-mm1/fs/ext3/super.c
@@ -1402,6 +1402,8 @@ static int ext3_fill_super (struct super
 				sbi->s_inode_size);
 			goto failed_mount;
 		}
+		if (sbi->s_inode_size > EXT3_GOOD_OLD_INODE_SIZE)
+			sb->s_time_gran = 1;
 	}
 	sbi->s_frag_size = EXT3_MIN_FRAG_SIZE <<
 				   le32_to_cpu(es->s_log_frag_size);
Index: linux-2.6.11-rc1-mm1/fs/ext3/ialloc.c
===================================================================
--- linux-2.6.11-rc1-mm1.orig/fs/ext3/ialloc.c
+++ linux-2.6.11-rc1-mm1/fs/ext3/ialloc.c
@@ -558,7 +558,7 @@ got:
 	/* This is the optimal IO size (for stat), not the fs block size */
 	inode->i_blksize = PAGE_SIZE;
 	inode->i_blocks = 0;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
+	inode->i_mtime = inode->i_atime = inode->i_ctime = ext3_current_time(inode);
 
 	memset(ei->i_data, 0, sizeof(ei->i_data));
 	ei->i_next_alloc_block = 0;
Index: linux-2.6.11-rc1-mm1/fs/ext3/xattr.c
===================================================================
--- linux-2.6.11-rc1-mm1.orig/fs/ext3/xattr.c
+++ linux-2.6.11-rc1-mm1/fs/ext3/xattr.c
@@ -1001,7 +1001,7 @@ ext3_xattr_set_handle(handle_t *handle, 
 		}
 	}
 	if (!error) {
-		inode->i_ctime = CURRENT_TIME_SEC;
+		inode->i_ctime = ext3_current_time(inode);
 		error = ext3_mark_iloc_dirty(handle, inode, &is.iloc);
 		/*
 		 * The bh is consumed by ext3_mark_iloc_dirty, even with
Index: linux-2.6.11-rc1-mm1/fs/ext3/ioctl.c
===================================================================
--- linux-2.6.11-rc1-mm1.orig/fs/ext3/ioctl.c
+++ linux-2.6.11-rc1-mm1/fs/ext3/ioctl.c
@@ -87,7 +87,7 @@ int ext3_ioctl (struct inode * inode, st
 		ei->i_flags = flags;
 
 		ext3_set_inode_flags(inode);
-		inode->i_ctime = CURRENT_TIME_SEC;
+		inode->i_ctime = ext3_current_time(inode);
 
 		err = ext3_mark_iloc_dirty(handle, inode, &iloc);
 flags_err:
@@ -121,7 +121,7 @@ flags_err:
 			return PTR_ERR(handle);
 		err = ext3_reserve_inode_write(handle, inode, &iloc);
 		if (err == 0) {
-			inode->i_ctime = CURRENT_TIME_SEC;
+			inode->i_ctime = ext3_current_time(inode);
 			inode->i_generation = generation;
 			err = ext3_mark_iloc_dirty(handle, inode, &iloc);
 		}
Index: linux-2.6.11-rc1-mm1/include/linux/ext3_fs.h
===================================================================
--- linux-2.6.11-rc1-mm1.orig/include/linux/ext3_fs.h
+++ linux-2.6.11-rc1-mm1/include/linux/ext3_fs.h
@@ -245,9 +245,9 @@ struct ext3_inode {
 	__le16	i_mode;		/* File mode */
 	__le16	i_uid;		/* Low 16 bits of Owner Uid */
 	__le32	i_size;		/* Size in bytes */
-	__le32	i_atime;	/* Access time */
-	__le32	i_ctime;	/* Creation time */
-	__le32	i_mtime;	/* Modification time */
+	__le32	i_atime;	/* Access time (seconds) */
+	__le32	i_ctime;	/* Change time (seconds) */
+	__le32	i_mtime;	/* Modification time (seconds) */
 	__le32	i_dtime;	/* Deletion Time */
 	__le16	i_gid;		/* Low 16 bits of Group Id */
 	__le16	i_links_count;	/* Links count */
@@ -295,6 +295,9 @@ struct ext3_inode {
 	} osd2;				/* OS dependent 2 */
 	__le16	i_extra_isize;
 	__le16	i_pad1;
+	__le32	i_atime_nsec;		/* Access time (nanoseconds) */
+	__le32	i_ctime_nsec;		/* Change time (nanoseconds) */
+	__le32	i_mtime_nsec;		/* Modification time (nanoseconds) */
 };
 
 #define i_size_high	i_dir_acl
@@ -476,6 +479,11 @@ static inline struct ext3_inode_info *EX
 {
 	return container_of(inode, struct ext3_inode_info, vfs_inode);
 }
+static inline struct timespec ext3_current_time(struct inode *inode)
+{
+	return (inode->i_sb->s_time_gran == 1) ?
+	       CURRENT_TIME : CURRENT_TIME_SEC;
+}
 #else
 /* Assume that user mode programs are passing in an ext3fs superblock, not
  * a kernel struct super_block.  This will allow us to call the feature-test
Index: linux-2.6.11-rc1-mm1/fs/ext3/namei.c
===================================================================
--- linux-2.6.11-rc1-mm1.orig/fs/ext3/namei.c
+++ linux-2.6.11-rc1-mm1/fs/ext3/namei.c
@@ -1256,7 +1256,7 @@ static int add_dirent_to_buf(handle_t *h
 	 * happen is that the times are slightly out of date
 	 * and/or different from the directory change time.
 	 */
-	dir->i_mtime = dir->i_ctime = CURRENT_TIME_SEC;
+	dir->i_mtime = dir->i_ctime = ext3_current_time(dir);
 	ext3_update_dx_flag(dir);
 	dir->i_version++;
 	ext3_mark_inode_dirty(handle, dir);
@@ -2034,7 +2034,7 @@ static int ext3_rmdir (struct inode * di
 	 * recovery. */
 	inode->i_size = 0;
 	ext3_orphan_add(handle, inode);
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME_SEC;
+	inode->i_ctime = dir->i_ctime = dir->i_mtime = ext3_current_time(inode);
 	ext3_mark_inode_dirty(handle, inode);
 	dir->i_nlink--;
 	ext3_update_dx_flag(dir);
@@ -2084,7 +2084,7 @@ static int ext3_unlink(struct inode * di
 	retval = ext3_delete_entry(handle, dir, de, bh);
 	if (retval)
 		goto end_unlink;
-	dir->i_ctime = dir->i_mtime = CURRENT_TIME_SEC;
+	dir->i_ctime = dir->i_mtime = ext3_current_time(dir);
 	ext3_update_dx_flag(dir);
 	ext3_mark_inode_dirty(handle, dir);
 	inode->i_nlink--;
@@ -2174,7 +2174,7 @@ retry:
 	if (IS_DIRSYNC(dir))
 		handle->h_sync = 1;
 
-	inode->i_ctime = CURRENT_TIME_SEC;
+	inode->i_ctime = ext3_current_time(inode);
 	ext3_inc_count(handle, inode);
 	atomic_inc(&inode->i_count);
 
@@ -2275,7 +2275,7 @@ static int ext3_rename (struct inode * o
 	 * Like most other Unix systems, set the ctime for inodes on a
 	 * rename.
 	 */
-	old_inode->i_ctime = CURRENT_TIME_SEC;
+	old_inode->i_ctime = ext3_current_time(old_inode);
 	ext3_mark_inode_dirty(handle, old_inode);
 
 	/*
@@ -2308,9 +2308,9 @@ static int ext3_rename (struct inode * o
 
 	if (new_inode) {
 		new_inode->i_nlink--;
-		new_inode->i_ctime = CURRENT_TIME_SEC;
+		new_inode->i_ctime = ext3_current_time(new_inode);
 	}
-	old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME_SEC;
+	old_dir->i_ctime = old_dir->i_mtime = ext3_current_time(old_dir);
 	ext3_update_dx_flag(old_dir);
 	if (dir_bh) {
 		BUFFER_TRACE(dir_bh, "get_write_access");

Regards,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH
