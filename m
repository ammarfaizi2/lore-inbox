Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965213AbWH2SJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965213AbWH2SJS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 14:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965229AbWH2SGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 14:06:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45284 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965213AbWH2SGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 14:06:24 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 11/19] BLOCK: Move common FS-specific ioctls to linux/fs.h [try #6]
Date: Tue, 29 Aug 2006 19:06:16 +0100
To: axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060829180616.32596.68921.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060829180552.32596.15290.stgit@warthog.cambridge.redhat.com>
References: <20060829180552.32596.15290.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Move common FS-specific ioctls from linux/ext2_fs.h to linux/fs.h as FS_IOC_*
and FS_IOC32_* and have the users of them use those as a base.

Also move the GETFLAGS/SETFLAGS flags to linux/fs.h as FS_*_FL macros, and then
have the other users use them as a base.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/cifs/ioctl.c             |    7 ++---
 fs/compat_ioctl.c           |   15 ----------
 fs/hfsplus/hfsplus_fs.h     |    8 +----
 fs/hfsplus/ioctl.c          |   17 +++++------
 fs/jfs/ioctl.c              |   15 +++++-----
 include/linux/ext2_fs.h     |   66 ++++++++++++++++++++++++-------------------
 include/linux/ext3_fs.h     |   20 ++++++++++---
 include/linux/fs.h          |   39 +++++++++++++++++++++++++
 include/linux/reiserfs_fs.h |   28 ++++++++----------
 9 files changed, 125 insertions(+), 90 deletions(-)

diff --git a/fs/cifs/ioctl.c b/fs/cifs/ioctl.c
index b0ea668..e34c7db 100644
--- a/fs/cifs/ioctl.c
+++ b/fs/cifs/ioctl.c
@@ -22,7 +22,6 @@
  */
 
 #include <linux/fs.h>
-#include <linux/ext2_fs.h>
 #include "cifspdu.h"
 #include "cifsglob.h"
 #include "cifsproto.h"
@@ -74,7 +73,7 @@ #endif /* CONFIG_CIFS_POSIX */
 			}
 			break;
 #ifdef CONFIG_CIFS_POSIX
-		case EXT2_IOC_GETFLAGS:
+		case FS_IOC_GETFLAGS:
 			if(CIFS_UNIX_EXTATTR_CAP & caps) {
 				if (pSMBFile == NULL)
 					break;
@@ -82,12 +81,12 @@ #ifdef CONFIG_CIFS_POSIX
 					&ExtAttrBits, &ExtAttrMask);
 				if(rc == 0)
 					rc = put_user(ExtAttrBits &
-						EXT2_FL_USER_VISIBLE,
+						FS_FL_USER_VISIBLE,
 						(int __user *)arg);
 			}
 			break;
 
-		case EXT2_IOC_SETFLAGS:
+		case FS_IOC_SETFLAGS:
 			if(CIFS_UNIX_EXTATTR_CAP & caps) {
 				if(get_user(ExtAttrBits,(int __user *)arg)) {
 					rc = -EFAULT;
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 3b0cf7f..bd9c4f4 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -123,21 +123,6 @@ #include <linux/dvb/frontend.h>
 #include <linux/dvb/video.h>
 #include <linux/lp.h>
 
-/* Aiee. Someone does not find a difference between int and long */
-#define EXT2_IOC32_GETFLAGS               _IOR('f', 1, int)
-#define EXT2_IOC32_SETFLAGS               _IOW('f', 2, int)
-#define EXT3_IOC32_GETVERSION             _IOR('f', 3, int)
-#define EXT3_IOC32_SETVERSION             _IOW('f', 4, int)
-#define EXT3_IOC32_GETRSVSZ               _IOR('f', 5, int)
-#define EXT3_IOC32_SETRSVSZ               _IOW('f', 6, int)
-#define EXT3_IOC32_GROUP_EXTEND           _IOW('f', 7, unsigned int)
-#ifdef CONFIG_JBD_DEBUG
-#define EXT3_IOC32_WAIT_FOR_READONLY      _IOR('f', 99, int)
-#endif
-
-#define EXT2_IOC32_GETVERSION             _IOR('v', 1, int)
-#define EXT2_IOC32_SETVERSION             _IOW('v', 2, int)
-
 static int do_ioctl32_pointer(unsigned int fd, unsigned int cmd,
 			      unsigned long arg, struct file *f)
 {
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 8a1ca5e..3915635 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -246,12 +246,8 @@ #define hfs_part_find hfsplus_part_find
 
 /* ext2 ioctls (EXT2_IOC_GETFLAGS and EXT2_IOC_SETFLAGS) to support
  * chattr/lsattr */
-#define HFSPLUS_IOC_EXT2_GETFLAGS	_IOR('f', 1, long)
-#define HFSPLUS_IOC_EXT2_SETFLAGS	_IOW('f', 2, long)
-
-#define EXT2_FLAG_IMMUTABLE		0x00000010 /* Immutable file */
-#define EXT2_FLAG_APPEND		0x00000020 /* writes to file may only append */
-#define EXT2_FLAG_NODUMP		0x00000040 /* do not dump file */
+#define HFSPLUS_IOC_EXT2_GETFLAGS	FS_IOC_GETFLAGS
+#define HFSPLUS_IOC_EXT2_SETFLAGS	FS_IOC_SETFLAGS
 
 
 /*
diff --git a/fs/hfsplus/ioctl.c b/fs/hfsplus/ioctl.c
index 13cf848..79fd104 100644
--- a/fs/hfsplus/ioctl.c
+++ b/fs/hfsplus/ioctl.c
@@ -28,11 +28,11 @@ int hfsplus_ioctl(struct inode *inode, s
 	case HFSPLUS_IOC_EXT2_GETFLAGS:
 		flags = 0;
 		if (HFSPLUS_I(inode).rootflags & HFSPLUS_FLG_IMMUTABLE)
-			flags |= EXT2_FLAG_IMMUTABLE; /* EXT2_IMMUTABLE_FL */
+			flags |= FS_IMMUTABLE_FL; /* EXT2_IMMUTABLE_FL */
 		if (HFSPLUS_I(inode).rootflags & HFSPLUS_FLG_APPEND)
-			flags |= EXT2_FLAG_APPEND; /* EXT2_APPEND_FL */
+			flags |= FS_APPEND_FL; /* EXT2_APPEND_FL */
 		if (HFSPLUS_I(inode).userflags & HFSPLUS_FLG_NODUMP)
-			flags |= EXT2_FLAG_NODUMP; /* EXT2_NODUMP_FL */
+			flags |= FS_NODUMP_FL; /* EXT2_NODUMP_FL */
 		return put_user(flags, (int __user *)arg);
 	case HFSPLUS_IOC_EXT2_SETFLAGS: {
 		if (IS_RDONLY(inode))
@@ -44,32 +44,31 @@ int hfsplus_ioctl(struct inode *inode, s
 		if (get_user(flags, (int __user *)arg))
 			return -EFAULT;
 
-		if (flags & (EXT2_FLAG_IMMUTABLE|EXT2_FLAG_APPEND) ||
+		if (flags & (FS_IMMUTABLE_FL|FS_APPEND_FL) ||
 		    HFSPLUS_I(inode).rootflags & (HFSPLUS_FLG_IMMUTABLE|HFSPLUS_FLG_APPEND)) {
 			if (!capable(CAP_LINUX_IMMUTABLE))
 				return -EPERM;
 		}
 
 		/* don't silently ignore unsupported ext2 flags */
-		if (flags & ~(EXT2_FLAG_IMMUTABLE|EXT2_FLAG_APPEND|
-			      EXT2_FLAG_NODUMP))
+		if (flags & ~(FS_IMMUTABLE_FL|FS_APPEND_FL|FS_NODUMP_FL))
 			return -EOPNOTSUPP;
 
-		if (flags & EXT2_FLAG_IMMUTABLE) { /* EXT2_IMMUTABLE_FL */
+		if (flags & FS_IMMUTABLE_FL) { /* EXT2_IMMUTABLE_FL */
 			inode->i_flags |= S_IMMUTABLE;
 			HFSPLUS_I(inode).rootflags |= HFSPLUS_FLG_IMMUTABLE;
 		} else {
 			inode->i_flags &= ~S_IMMUTABLE;
 			HFSPLUS_I(inode).rootflags &= ~HFSPLUS_FLG_IMMUTABLE;
 		}
-		if (flags & EXT2_FLAG_APPEND) { /* EXT2_APPEND_FL */
+		if (flags & FS_APPEND_FL) { /* EXT2_APPEND_FL */
 			inode->i_flags |= S_APPEND;
 			HFSPLUS_I(inode).rootflags |= HFSPLUS_FLG_APPEND;
 		} else {
 			inode->i_flags &= ~S_APPEND;
 			HFSPLUS_I(inode).rootflags &= ~HFSPLUS_FLG_APPEND;
 		}
-		if (flags & EXT2_FLAG_NODUMP) /* EXT2_NODUMP_FL */
+		if (flags & FS_NODUMP_FL) /* EXT2_NODUMP_FL */
 			HFSPLUS_I(inode).userflags |= HFSPLUS_FLG_NODUMP;
 		else
 			HFSPLUS_I(inode).userflags &= ~HFSPLUS_FLG_NODUMP;
diff --git a/fs/jfs/ioctl.c b/fs/jfs/ioctl.c
index 67b3774..37db524 100644
--- a/fs/jfs/ioctl.c
+++ b/fs/jfs/ioctl.c
@@ -6,7 +6,6 @@
  */
 
 #include <linux/fs.h>
-#include <linux/ext2_fs.h>
 #include <linux/ctype.h>
 #include <linux/capability.h>
 #include <linux/time.h>
@@ -22,13 +21,13 @@ static struct {
 	long jfs_flag;
 	long ext2_flag;
 } jfs_map[] = {
-	{JFS_NOATIME_FL, EXT2_NOATIME_FL},
-	{JFS_DIRSYNC_FL, EXT2_DIRSYNC_FL},
-	{JFS_SYNC_FL, EXT2_SYNC_FL},
-	{JFS_SECRM_FL, EXT2_SECRM_FL},
-	{JFS_UNRM_FL, EXT2_UNRM_FL},
-	{JFS_APPEND_FL, EXT2_APPEND_FL},
-	{JFS_IMMUTABLE_FL, EXT2_IMMUTABLE_FL},
+	{JFS_NOATIME_FL,	FS_NOATIME_FL},
+	{JFS_DIRSYNC_FL,	FS_DIRSYNC_FL},
+	{JFS_SYNC_FL,		FS_SYNC_FL},
+	{JFS_SECRM_FL,		FS_SECRM_FL},
+	{JFS_UNRM_FL,		FS_UNRM_FL},
+	{JFS_APPEND_FL,		FS_APPEND_FL},
+	{JFS_IMMUTABLE_FL,	FS_IMMUTABLE_FL},
 	{0, 0},
 };
 
diff --git a/include/linux/ext2_fs.h b/include/linux/ext2_fs.h
index facf34e..9996d2e 100644
--- a/include/linux/ext2_fs.h
+++ b/include/linux/ext2_fs.h
@@ -169,41 +169,49 @@ #define	EXT2_TIND_BLOCK			(EXT2_DIND_BLO
 #define	EXT2_N_BLOCKS			(EXT2_TIND_BLOCK + 1)
 
 /*
- * Inode flags
- */
-#define	EXT2_SECRM_FL			0x00000001 /* Secure deletion */
-#define	EXT2_UNRM_FL			0x00000002 /* Undelete */
-#define	EXT2_COMPR_FL			0x00000004 /* Compress file */
-#define EXT2_SYNC_FL			0x00000008 /* Synchronous updates */
-#define EXT2_IMMUTABLE_FL		0x00000010 /* Immutable file */
-#define EXT2_APPEND_FL			0x00000020 /* writes to file may only append */
-#define EXT2_NODUMP_FL			0x00000040 /* do not dump file */
-#define EXT2_NOATIME_FL			0x00000080 /* do not update atime */
+ * Inode flags (GETFLAGS/SETFLAGS)
+ */
+#define	EXT2_SECRM_FL			FS_SECRM_FL	/* Secure deletion */
+#define	EXT2_UNRM_FL			FS_UNRM_FL	/* Undelete */
+#define	EXT2_COMPR_FL			FS_COMPR_FL	/* Compress file */
+#define EXT2_SYNC_FL			FS_SYNC_FL	/* Synchronous updates */
+#define EXT2_IMMUTABLE_FL		FS_IMMUTABLE_FL	/* Immutable file */
+#define EXT2_APPEND_FL			FS_APPEND_FL	/* writes to file may only append */
+#define EXT2_NODUMP_FL			FS_NODUMP_FL	/* do not dump file */
+#define EXT2_NOATIME_FL			FS_NOATIME_FL	/* do not update atime */
 /* Reserved for compression usage... */
-#define EXT2_DIRTY_FL			0x00000100
-#define EXT2_COMPRBLK_FL		0x00000200 /* One or more compressed clusters */
-#define EXT2_NOCOMP_FL			0x00000400 /* Don't compress */
-#define EXT2_ECOMPR_FL			0x00000800 /* Compression error */
+#define EXT2_DIRTY_FL			FS_DIRTY_FL
+#define EXT2_COMPRBLK_FL		FS_COMPRBLK_FL	/* One or more compressed clusters */
+#define EXT2_NOCOMP_FL			FS_NOCOMP_FL	/* Don't compress */
+#define EXT2_ECOMPR_FL			FS_ECOMPR_FL	/* Compression error */
 /* End compression flags --- maybe not all used */	
-#define EXT2_BTREE_FL			0x00001000 /* btree format dir */
-#define EXT2_INDEX_FL			0x00001000 /* hash-indexed directory */
-#define EXT2_IMAGIC_FL			0x00002000 /* AFS directory */
-#define EXT2_JOURNAL_DATA_FL		0x00004000 /* Reserved for ext3 */
-#define EXT2_NOTAIL_FL			0x00008000 /* file tail should not be merged */
-#define EXT2_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
-#define EXT2_TOPDIR_FL			0x00020000 /* Top of directory hierarchies*/
-#define EXT2_RESERVED_FL		0x80000000 /* reserved for ext2 lib */
-
-#define EXT2_FL_USER_VISIBLE		0x0003DFFF /* User visible flags */
-#define EXT2_FL_USER_MODIFIABLE		0x000380FF /* User modifiable flags */
+#define EXT2_BTREE_FL			FS_BTREE_FL	/* btree format dir */
+#define EXT2_INDEX_FL			FS_INDEX_FL	/* hash-indexed directory */
+#define EXT2_IMAGIC_FL			FS_IMAGIC_FL	/* AFS directory */
+#define EXT2_JOURNAL_DATA_FL		FS_JOURNAL_DATA_FL /* Reserved for ext3 */
+#define EXT2_NOTAIL_FL			FS_NOTAIL_FL	/* file tail should not be merged */
+#define EXT2_DIRSYNC_FL			FS_DIRSYNC_FL	/* dirsync behaviour (directories only) */
+#define EXT2_TOPDIR_FL			FS_TOPDIR_FL	/* Top of directory hierarchies*/
+#define EXT2_RESERVED_FL		FS_RESERVED_FL	/* reserved for ext2 lib */
+
+#define EXT2_FL_USER_VISIBLE		FS_FL_USER_VISIBLE	/* User visible flags */
+#define EXT2_FL_USER_MODIFIABLE		FS_FL_USER_MODIFIABLE	/* User modifiable flags */
 
 /*
  * ioctl commands
  */
-#define	EXT2_IOC_GETFLAGS		_IOR('f', 1, long)
-#define	EXT2_IOC_SETFLAGS		_IOW('f', 2, long)
-#define	EXT2_IOC_GETVERSION		_IOR('v', 1, long)
-#define	EXT2_IOC_SETVERSION		_IOW('v', 2, long)
+#define	EXT2_IOC_GETFLAGS		FS_IOC_GETFLAGS
+#define	EXT2_IOC_SETFLAGS		FS_IOC_SETFLAGS
+#define	EXT2_IOC_GETVERSION		FS_IOC_GETVERSION
+#define	EXT2_IOC_SETVERSION		FS_IOC_SETVERSION
+
+/*
+ * ioctl commands in 32 bit emulation
+ */
+#define EXT2_IOC32_GETFLAGS		FS_IOC32_GETFLAGS
+#define EXT2_IOC32_SETFLAGS		FS_IOC32_SETFLAGS
+#define EXT2_IOC32_GETVERSION		FS_IOC32_GETVERSION
+#define EXT2_IOC32_SETVERSION		FS_IOC32_SETVERSION
 
 /*
  * Structure of an inode on the disk
diff --git a/include/linux/ext3_fs.h b/include/linux/ext3_fs.h
index 9f9cce7..90cfba2 100644
--- a/include/linux/ext3_fs.h
+++ b/include/linux/ext3_fs.h
@@ -220,14 +220,14 @@ struct ext3_new_group_data {
 /*
  * ioctl commands
  */
-#define	EXT3_IOC_GETFLAGS		_IOR('f', 1, long)
-#define	EXT3_IOC_SETFLAGS		_IOW('f', 2, long)
+#define	EXT3_IOC_GETFLAGS		FS_IOC_GETFLAGS
+#define	EXT3_IOC_SETFLAGS		FS_IOC_SETFLAGS
 #define	EXT3_IOC_GETVERSION		_IOR('f', 3, long)
 #define	EXT3_IOC_SETVERSION		_IOW('f', 4, long)
 #define EXT3_IOC_GROUP_EXTEND		_IOW('f', 7, unsigned long)
 #define EXT3_IOC_GROUP_ADD		_IOW('f', 8,struct ext3_new_group_input)
-#define	EXT3_IOC_GETVERSION_OLD		_IOR('v', 1, long)
-#define	EXT3_IOC_SETVERSION_OLD		_IOW('v', 2, long)
+#define	EXT3_IOC_GETVERSION_OLD		FS_IOC_GETVERSION
+#define	EXT3_IOC_SETVERSION_OLD		FS_IOC_SETVERSION
 #ifdef CONFIG_JBD_DEBUG
 #define EXT3_IOC_WAIT_FOR_READONLY	_IOR('f', 99, long)
 #endif
@@ -235,6 +235,18 @@ #define EXT3_IOC_GETRSVSZ		_IOR('f', 5, 
 #define EXT3_IOC_SETRSVSZ		_IOW('f', 6, long)
 
 /*
+ * ioctl commands in 32 bit emulation
+ */
+#define EXT3_IOC32_GETVERSION		_IOR('f', 3, int)
+#define EXT3_IOC32_SETVERSION		_IOW('f', 4, int)
+#define EXT3_IOC32_GETRSVSZ		_IOR('f', 5, int)
+#define EXT3_IOC32_SETRSVSZ		_IOW('f', 6, int)
+#define EXT3_IOC32_GROUP_EXTEND		_IOW('f', 7, unsigned int)
+#ifdef CONFIG_JBD_DEBUG
+#define EXT3_IOC32_WAIT_FOR_READONLY	_IOR('f', 99, int)
+#endif
+
+/*
  *  Mount options
  */
 struct ext3_mount_options {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9b2e4f7..2d8217a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -216,6 +216,45 @@ #define BMAP_IOCTL 1		/* obsolete - kept
 #define FIBMAP	   _IO(0x00,1)	/* bmap access */
 #define FIGETBSZ   _IO(0x00,2)	/* get the block size used for bmap */
 
+#define	FS_IOC_GETFLAGS			_IOR('f', 1, long)
+#define	FS_IOC_SETFLAGS			_IOW('f', 2, long)
+#define	FS_IOC_GETVERSION		_IOR('v', 1, long)
+#define	FS_IOC_SETVERSION		_IOW('v', 2, long)
+#define FS_IOC32_GETFLAGS		_IOR('f', 1, int)
+#define FS_IOC32_SETFLAGS		_IOW('f', 2, int)
+#define FS_IOC32_GETVERSION		_IOR('v', 1, int)
+#define FS_IOC32_SETVERSION		_IOW('v', 2, int)
+
+/*
+ * Inode flags (FS_IOC_GETFLAGS / FS_IOC_SETFLAGS)
+ */
+#define	FS_SECRM_FL			0x00000001 /* Secure deletion */
+#define	FS_UNRM_FL			0x00000002 /* Undelete */
+#define	FS_COMPR_FL			0x00000004 /* Compress file */
+#define FS_SYNC_FL			0x00000008 /* Synchronous updates */
+#define FS_IMMUTABLE_FL			0x00000010 /* Immutable file */
+#define FS_APPEND_FL			0x00000020 /* writes to file may only append */
+#define FS_NODUMP_FL			0x00000040 /* do not dump file */
+#define FS_NOATIME_FL			0x00000080 /* do not update atime */
+/* Reserved for compression usage... */
+#define FS_DIRTY_FL			0x00000100
+#define FS_COMPRBLK_FL			0x00000200 /* One or more compressed clusters */
+#define FS_NOCOMP_FL			0x00000400 /* Don't compress */
+#define FS_ECOMPR_FL			0x00000800 /* Compression error */
+/* End compression flags --- maybe not all used */
+#define FS_BTREE_FL			0x00001000 /* btree format dir */
+#define FS_INDEX_FL			0x00001000 /* hash-indexed directory */
+#define FS_IMAGIC_FL			0x00002000 /* AFS directory */
+#define FS_JOURNAL_DATA_FL		0x00004000 /* Reserved for ext3 */
+#define FS_NOTAIL_FL			0x00008000 /* file tail should not be merged */
+#define FS_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
+#define FS_TOPDIR_FL			0x00020000 /* Top of directory hierarchies*/
+#define FS_RESERVED_FL			0x80000000 /* reserved for ext2 lib */
+
+#define FS_FL_USER_VISIBLE		0x0003DFFF /* User visible flags */
+#define FS_FL_USER_MODIFIABLE		0x000380FF /* User modifiable flags */
+
+
 #define SYNC_FILE_RANGE_WAIT_BEFORE	1
 #define SYNC_FILE_RANGE_WRITE		2
 #define SYNC_FILE_RANGE_WAIT_AFTER	4
diff --git a/include/linux/reiserfs_fs.h b/include/linux/reiserfs_fs.h
index daa2d83..54c3054 100644
--- a/include/linux/reiserfs_fs.h
+++ b/include/linux/reiserfs_fs.h
@@ -813,21 +813,19 @@ #define sd_v1_first_direct_byte(sdp) \
 #define set_sd_v1_first_direct_byte(sdp,v) \
                                 ((sdp)->sd_first_direct_byte = cpu_to_le32(v))
 
-#include <linux/ext2_fs.h>
-
 /* inode flags stored in sd_attrs (nee sd_reserved) */
 
 /* we want common flags to have the same values as in ext2,
    so chattr(1) will work without problems */
-#define REISERFS_IMMUTABLE_FL EXT2_IMMUTABLE_FL
-#define REISERFS_APPEND_FL    EXT2_APPEND_FL
-#define REISERFS_SYNC_FL      EXT2_SYNC_FL
-#define REISERFS_NOATIME_FL   EXT2_NOATIME_FL
-#define REISERFS_NODUMP_FL    EXT2_NODUMP_FL
-#define REISERFS_SECRM_FL     EXT2_SECRM_FL
-#define REISERFS_UNRM_FL      EXT2_UNRM_FL
-#define REISERFS_COMPR_FL     EXT2_COMPR_FL
-#define REISERFS_NOTAIL_FL    EXT2_NOTAIL_FL
+#define REISERFS_IMMUTABLE_FL FS_IMMUTABLE_FL
+#define REISERFS_APPEND_FL    FS_APPEND_FL
+#define REISERFS_SYNC_FL      FS_SYNC_FL
+#define REISERFS_NOATIME_FL   FS_NOATIME_FL
+#define REISERFS_NODUMP_FL    FS_NODUMP_FL
+#define REISERFS_SECRM_FL     FS_SECRM_FL
+#define REISERFS_UNRM_FL      FS_UNRM_FL
+#define REISERFS_COMPR_FL     FS_COMPR_FL
+#define REISERFS_NOTAIL_FL    FS_NOTAIL_FL
 
 /* persistent flags that file inherits from the parent directory */
 #define REISERFS_INHERIT_MASK ( REISERFS_IMMUTABLE_FL |	\
@@ -2174,10 +2172,10 @@ int reiserfs_ioctl(struct inode *inode, 
 #define REISERFS_IOC_UNPACK		_IOW(0xCD,1,long)
 /* define following flags to be the same as in ext2, so that chattr(1),
    lsattr(1) will work with us. */
-#define REISERFS_IOC_GETFLAGS		EXT2_IOC_GETFLAGS
-#define REISERFS_IOC_SETFLAGS		EXT2_IOC_SETFLAGS
-#define REISERFS_IOC_GETVERSION		EXT2_IOC_GETVERSION
-#define REISERFS_IOC_SETVERSION		EXT2_IOC_SETVERSION
+#define REISERFS_IOC_GETFLAGS		FS_IOC_GETFLAGS
+#define REISERFS_IOC_SETFLAGS		FS_IOC_SETFLAGS
+#define REISERFS_IOC_GETVERSION		FS_IOC_GETVERSION
+#define REISERFS_IOC_SETVERSION		FS_IOC_SETVERSION
 
 /* Locking primitives */
 /* Right now we are still falling back to (un)lock_kernel, but eventually that
