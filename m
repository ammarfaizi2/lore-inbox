Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbSKBT4i>; Sat, 2 Nov 2002 14:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261340AbSKBT4i>; Sat, 2 Nov 2002 14:56:38 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:16134 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S261290AbSKBT4c>; Sat, 2 Nov 2002 14:56:32 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cleanup headers of fat (1/2)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 03 Nov 2002 05:02:40 +0900
Message-ID: <871y63agf3.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch from Christoph Hellwig. Please apply.


merge msdos_fs_i.h and msdos_fs_sb.h into msdos_fs.h.  In 2.5 fs.h
doesn't need the first two anymore so they can safely be merged into
it.

umsdos will need trivial adoption for that if it ever comes back from
the bitbucket.


 include/linux/msdos_fs.h    |   82 ++++++++++++++++++++++++++++++++++++++------
 include/linux/umsdos_fs_i.h |    2 -
 include/linux/msdos_fs_i.h  |   21 -----------
 include/linux/msdos_fs_sb.h |   52 ---------------------------
 4 files changed, 72 insertions(+), 85 deletions(-)

--- fat-2.5.45-bk1/include/linux/msdos_fs.h~fat_header_cleanup	2002-11-03 03:40:31.000000000 +0900
+++ fat-2.5.45-bk1-hirofumi/include/linux/msdos_fs.h	2002-11-03 03:40:31.000000000 +0900
@@ -5,6 +5,7 @@
  * The MS-DOS filesystem constants/structures
  */
 #include <linux/buffer_head.h>
+#include <linux/nls.h>
 #include <asm/byteorder.h>
 
 #define SECTOR_SIZE	512		/* sector size (bytes) */
@@ -187,19 +188,68 @@ struct vfat_slot_info {
 
 #ifdef __KERNEL__
 
-#include <linux/nls.h>
-#include <linux/msdos_fs_i.h>
-#include <linux/msdos_fs_sb.h>
+/*
+ * MS-DOS file system in-core superblock data
+ */
 
-static inline struct msdos_sb_info *MSDOS_SB(struct super_block *sb)
-{
-	return sb->s_fs_info;
-}
+struct fat_mount_options {
+	uid_t fs_uid;
+	gid_t fs_gid;
+	unsigned short fs_umask;
+	unsigned short fs_dmask;
+	unsigned short codepage;  /* Codepage for shortname conversions */
+	char *iocharset;          /* Charset used for filename input/display */
+	unsigned short shortname; /* flags for shortname display/create rule */
+	unsigned char name_check; /* r = relaxed, n = normal, s = strict */
+	unsigned quiet:1,         /* set = fake successful chmods and chowns */
+		 showexec:1,      /* set = only set x bit for com/exe/bat */
+		 sys_immutable:1, /* set = system files are immutable */
+		 dotsOK:1,        /* set = hidden and system files are named '.filename' */
+		 isvfat:1,        /* 0=no vfat long filename support, 1=vfat support */
+		 utf8:1,	  /* Use of UTF8 character set (Default) */
+		 unicode_xlate:1, /* create escape sequences for unhandled Unicode */
+		 numtail:1,       /* Does first alias have a numeric '~1' type tail? */
+		 atari:1,         /* Use Atari GEMDOS variation of MS-DOS fs */
+		 nocase:1;	  /* Does this need case conversion? 0=need case conversion*/
+};
 
-static inline struct msdos_inode_info *MSDOS_I(struct inode *inode)
-{
-	return container_of(inode, struct msdos_inode_info, vfs_inode);
-}
+struct msdos_sb_info {
+	unsigned short cluster_size; /* sectors/cluster */
+	unsigned short cluster_bits; /* sectors/cluster */
+	unsigned char fats,fat_bits; /* number of FATs, FAT bits (12 or 16) */
+	unsigned short fat_start;
+	unsigned long fat_length;    /* FAT start & length (sec.) */
+	unsigned long dir_start;
+	unsigned short dir_entries;  /* root dir start & entries */
+	unsigned long data_start;    /* first data sector */
+	unsigned long clusters;      /* number of clusters */
+	unsigned long root_cluster;  /* first cluster of the root directory */
+	unsigned long fsinfo_sector; /* FAT32 fsinfo offset from start of disk */
+	struct semaphore fat_lock;
+	int prev_free;               /* previously returned free cluster number */
+	int free_clusters;           /* -1 if undefined */
+	struct fat_mount_options options;
+	struct nls_table *nls_disk;  /* Codepage used on disk */
+	struct nls_table *nls_io;    /* Charset used for input and display */
+	struct inode_operations *dir_ops;/* Default directory operations */
+	int dir_per_block;	     /* dir entries per block */
+	int dir_per_block_bits;	     /* log2(dir_per_block) */
+};
+
+/*
+ * MS-DOS file system inode data in memory
+ */
+
+struct msdos_inode_info {
+	loff_t mmu_private;
+	int i_start;	/* first cluster or 0 */
+	int i_logstart;	/* logical first cluster */
+	int i_attrs;	/* unused attribute bits */
+	int i_ctime_ms;	/* unused change time in milliseconds */
+	int i_location;	/* on-disk position of directory entry or 0 */
+	struct list_head i_fat_hash;	/* hash by i_location */
+	struct inode vfs_inode;
+};
 
 struct fat_cache {
 	struct super_block *sb; /* fs in question.  NULL means unused */
@@ -209,6 +259,16 @@ struct fat_cache {
 	struct fat_cache *next; /* next cache entry */
 };
 
+static inline struct msdos_sb_info *MSDOS_SB(struct super_block *sb)
+{
+	return sb->s_fs_info;
+}
+
+static inline struct msdos_inode_info *MSDOS_I(struct inode *inode)
+{
+	return container_of(inode, struct msdos_inode_info, vfs_inode);
+}
+
 static inline void fat16_towchar(wchar_t *dst, const __u8 *src, size_t len)
 {
 #ifdef __BIG_ENDIAN
--- fat-2.5.45-bk1/include/linux/msdos_fs_i.h
+++ /dev/null	2002-07-27 03:36:37.000000000 +0900
@@ -1,21 +0,0 @@
-#ifndef _MSDOS_FS_I
-#define _MSDOS_FS_I
-
-#include <linux/fs.h>
-
-/*
- * MS-DOS file system inode data in memory
- */
-
-struct msdos_inode_info {
-	loff_t mmu_private;
-	int i_start;	/* first cluster or 0 */
-	int i_logstart;	/* logical first cluster */
-	int i_attrs;	/* unused attribute bits */
-	int i_ctime_ms;	/* unused change time in milliseconds */
-	int i_location;	/* on-disk position of directory entry or 0 */
-	struct list_head i_fat_hash;	/* hash by i_location */
-	struct inode vfs_inode;
-};
-
-#endif
--- fat-2.5.45-bk1/include/linux/msdos_fs_sb.h
+++ /dev/null	2002-07-27 03:36:37.000000000 +0900
@@ -1,52 +0,0 @@
-#ifndef _MSDOS_FS_SB
-#define _MSDOS_FS_SB
-
-/*
- * MS-DOS file system in-core superblock data
- */
-
-struct fat_mount_options {
-	uid_t fs_uid;
-	gid_t fs_gid;
-	unsigned short fs_umask;
-	unsigned short fs_dmask;
-	unsigned short codepage;  /* Codepage for shortname conversions */
-	char *iocharset;          /* Charset used for filename input/display */
-	unsigned short shortname; /* flags for shortname display/create rule */
-	unsigned char name_check; /* r = relaxed, n = normal, s = strict */
-	unsigned quiet:1,         /* set = fake successful chmods and chowns */
-		 showexec:1,      /* set = only set x bit for com/exe/bat */
-		 sys_immutable:1, /* set = system files are immutable */
-		 dotsOK:1,        /* set = hidden and system files are named '.filename' */
-		 isvfat:1,        /* 0=no vfat long filename support, 1=vfat support */
-		 utf8:1,	  /* Use of UTF8 character set (Default) */
-		 unicode_xlate:1, /* create escape sequences for unhandled Unicode */
-		 numtail:1,       /* Does first alias have a numeric '~1' type tail? */
-		 atari:1,         /* Use Atari GEMDOS variation of MS-DOS fs */
-		 nocase:1;	  /* Does this need case conversion? 0=need case conversion*/
-};
-
-struct msdos_sb_info {
-	unsigned short cluster_size; /* sectors/cluster */
-	unsigned short cluster_bits; /* sectors/cluster */
-	unsigned char fats,fat_bits; /* number of FATs, FAT bits (12 or 16) */
-	unsigned short fat_start;
-	unsigned long fat_length;    /* FAT start & length (sec.) */
-	unsigned long dir_start;
-	unsigned short dir_entries;  /* root dir start & entries */
-	unsigned long data_start;    /* first data sector */
-	unsigned long clusters;      /* number of clusters */
-	unsigned long root_cluster;  /* first cluster of the root directory */
-	unsigned long fsinfo_sector; /* FAT32 fsinfo offset from start of disk */
-	struct semaphore fat_lock;
-	int prev_free;               /* previously returned free cluster number */
-	int free_clusters;           /* -1 if undefined */
-	struct fat_mount_options options;
-	struct nls_table *nls_disk;  /* Codepage used on disk */
-	struct nls_table *nls_io;    /* Charset used for input and display */
-	void *dir_ops;		     /* Opaque; default directory operations */
-	int dir_per_block;	     /* dir entries per block */
-	int dir_per_block_bits;	     /* log2(dir_per_block) */
-};
-
-#endif
--- fat-2.5.45-bk1/include/linux/umsdos_fs_i.h~fat_header_cleanup	2002-11-03 03:40:31.000000000 +0900
+++ fat-2.5.45-bk1-hirofumi/include/linux/umsdos_fs_i.h	2002-11-03 03:40:31.000000000 +0900
@@ -5,7 +5,7 @@
 #include <linux/types.h>
 #endif
 
-#include <linux/msdos_fs_i.h>
+/*#include <linux/msdos_fs_i.h>*/
 #include <linux/pipe_fs_i.h>
 
 /* #Specification: strategy / in memory inode

.

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
