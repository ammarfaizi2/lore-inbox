Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315427AbSGEFXA>; Fri, 5 Jul 2002 01:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315430AbSGEFW7>; Fri, 5 Jul 2002 01:22:59 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:11199 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315427AbSGEFW6>;
	Fri, 5 Jul 2002 01:22:58 -0400
Date: Fri, 5 Jul 2002 01:25:32 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] assorted kdev_t cleanups in filesystems
Message-ID: <Pine.GSO.4.21.0207050120410.14718-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	* JFS uses its ->logdev only twice - one of the places assigns
it to_kdev_t(le32_to_cpu(...)), another uses kdev_t_to_nr() of it.
Switched to u32 - it's just a place where we store device number we'd got
from superblock.
	* several reiserfs_fs.h function prototypes removed - functions
in question don't exist anymore.
	* smbfs doesn't support device nodes; ->f_rdev removed.

diff -urN C24-0/fs/jfs/jfs_incore.h C24-current/fs/jfs/jfs_incore.h
--- C24-0/fs/jfs/jfs_incore.h	Sun Jun  9 23:04:20 2002
+++ C24-current/fs/jfs/jfs_incore.h	Sun Jun 30 01:05:01 2002
@@ -122,7 +122,7 @@
 	short		nbperpage;	/* 2: blocks per page		*/
 	short		l2nbperpage;	/* 2: log2 blocks per page	*/
 	short		l2niperblk;	/* 2: log2 inodes per page	*/
-	kdev_t		logdev;		/* 2: external log device	*/
+	u32		logdev;		/* 2: external log device	*/
 	uint		aggregate;	/* volume identifier in log record */
 	pxd_t		logpxd;		/* 8: pxd describing log	*/
 	pxd_t		ait2;		/* 8: pxd describing AIT copy	*/
diff -urN C24-0/fs/jfs/jfs_logmgr.c C24-current/fs/jfs/jfs_logmgr.c
--- C24-0/fs/jfs/jfs_logmgr.c	Thu Jun 20 20:27:59 2002
+++ C24-current/fs/jfs/jfs_logmgr.c	Sun Jun 30 01:05:33 2002
@@ -1102,7 +1102,7 @@
 	 */
       externalLog:
 
-	if (!(bdev = bdget(kdev_t_to_nr(JFS_SBI(sb)->logdev)))) {
+	if (!(bdev = bdget(JFS_SBI(sb)->logdev))) {
 		rc = ENODEV;
 		goto free;
 	}
diff -urN C24-0/fs/jfs/jfs_mount.c C24-current/fs/jfs/jfs_mount.c
--- C24-0/fs/jfs/jfs_mount.c	Thu Jun 20 13:37:04 2002
+++ C24-current/fs/jfs/jfs_mount.c	Sun Jun 30 01:05:14 2002
@@ -406,7 +406,7 @@
 	if (sbi->mntflag & JFS_INLINELOG)
 		sbi->logpxd = j_sb->s_logpxd;
 	else {
-		sbi->logdev = to_kdev_t(le32_to_cpu(j_sb->s_logdev));
+		sbi->logdev = le32_to_cpu(j_sb->s_logdev);
 		memcpy(sbi->uuid, j_sb->s_uuid, sizeof(sbi->uuid));
 		memcpy(sbi->loguuid, j_sb->s_loguuid, sizeof(sbi->uuid));
 	}
diff -urN C24-0/include/linux/reiserfs_fs.h C24-current/include/linux/reiserfs_fs.h
--- C24-0/include/linux/reiserfs_fs.h	Thu Jun 20 13:37:25 2002
+++ C24-current/include/linux/reiserfs_fs.h	Sun Jun 30 00:51:25 2002
@@ -1675,13 +1675,10 @@
 int journal_transaction_should_end(struct reiserfs_transaction_handle *, int) ;
 int reiserfs_in_journal(struct super_block *p_s_sb, unsigned long bl, int searchall, unsigned long *next) ;
 int journal_begin(struct reiserfs_transaction_handle *, struct super_block *p_s_sb, unsigned long) ;
-struct super_block *reiserfs_get_super(kdev_t dev) ;
 void flush_async_commits(struct super_block *p_s_sb) ;
 
 int buffer_journaled(const struct buffer_head *bh) ;
 int mark_buffer_journal_new(struct buffer_head *bh) ;
-int reiserfs_sync_all_buffers(kdev_t dev, int wait) ;
-int reiserfs_sync_buffers(kdev_t dev, int wait) ;
 int reiserfs_add_page_to_flush_list(struct reiserfs_transaction_handle *,
                                     struct inode *, struct buffer_head *) ;
 int reiserfs_remove_page_from_flush_list(struct reiserfs_transaction_handle *,
diff -urN C24-0/include/linux/reiserfs_fs_sb.h C24-current/include/linux/reiserfs_fs_sb.h
--- C24-0/include/linux/reiserfs_fs_sb.h	Thu Jun 20 13:37:05 2002
+++ C24-current/include/linux/reiserfs_fs_sb.h	Sun Jun 30 00:51:41 2002
@@ -160,7 +160,7 @@
   int t_blocks_allocated ;      /* number of blocks this writer allocated */
   unsigned long t_trans_id ;    /* sanity check, equals the current trans id */
   struct super_block *t_super ; /* super for this FS when journal_begin was 
-                                   called. saves calls to reiserfs_get_super */
+                                   called. */
 } ;
 
 /*
diff -urN C24-0/fs/smbfs/inode.c C24-current/fs/smbfs/inode.c
--- C24-0/fs/smbfs/inode.c	Sun Jun  9 23:04:21 2002
+++ C24-current/fs/smbfs/inode.c	Wed Jul  3 04:56:39 2002
@@ -145,7 +145,6 @@
 	fattr->f_ino	= inode->i_ino;
 	fattr->f_uid	= inode->i_uid;
 	fattr->f_gid	= inode->i_gid;
-	fattr->f_rdev	= inode->i_rdev;
 	fattr->f_size	= inode->i_size;
 	fattr->f_mtime	= inode->i_mtime;
 	fattr->f_ctime	= inode->i_ctime;
@@ -183,7 +182,6 @@
 	inode->i_nlink	= fattr->f_nlink;
 	inode->i_uid	= fattr->f_uid;
 	inode->i_gid	= fattr->f_gid;
-	inode->i_rdev	= fattr->f_rdev;
 	inode->i_ctime	= fattr->f_ctime;
 	inode->i_blksize= fattr->f_blksize;
 	inode->i_blocks = fattr->f_blocks;
diff -urN C24-0/include/linux/smb.h C24-current/include/linux/smb.h
--- C24-0/include/linux/smb.h	Fri Mar  8 19:50:26 2002
+++ C24-current/include/linux/smb.h	Wed Jul  3 04:56:32 2002
@@ -10,7 +10,6 @@
 #define _LINUX_SMB_H
 
 #include <linux/types.h>
-#include <linux/kdev_t.h>
 
 enum smb_protocol { 
 	SMB_PROTOCOL_NONE, 
@@ -85,7 +84,6 @@
 	nlink_t		f_nlink;
 	uid_t		f_uid;
 	gid_t		f_gid;
-	kdev_t		f_rdev;
 	loff_t		f_size;
 	time_t		f_atime;
 	time_t		f_mtime;

