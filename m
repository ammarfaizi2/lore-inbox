Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262343AbVAQRmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbVAQRmE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 12:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbVAQRmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 12:42:03 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:59656 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262343AbVAQRkW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 12:40:22 -0500
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/13] FAT: merge msdos_fs_{i,sb}.h into msdos_fs.h
References: <87pt04oszi.fsf@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 18 Jan 2005 02:40:13 +0900
In-Reply-To: <87pt04oszi.fsf@devron.myhome.or.jp> (OGAWA Hirofumi's message
 of "Tue, 18 Jan 2005 02:39:13 +0900")
Message-ID: <87llasosxu.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We don't have the union in "struct inode" and "struct super_block", so
we doesn't need xxx_fs_i.h and xxx_fs_sb.h anymore.

 From Christoph Hellwig <hch@lst.de>

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 include/linux/msdos_fs.h    |   80 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/msdos_fs_i.h  |   29 ---------------
 include/linux/msdos_fs_sb.h |   60 ---------------------------------
 3 files changed, 78 insertions(+), 91 deletions(-)

diff -puN include/linux/msdos_fs.h~fat_remove_headers include/linux/msdos_fs.h
--- linux-2.6.10/include/linux/msdos_fs.h~fat_remove_headers	2005-01-08 09:07:45.000000000 +0900
+++ linux-2.6.10-hirofumi/include/linux/msdos_fs.h	2005-01-08 09:07:45.000000000 +0900
@@ -189,8 +189,84 @@ struct vfat_slot_info {
 #include <linux/buffer_head.h>
 #include <linux/string.h>
 #include <linux/nls.h>
-#include <linux/msdos_fs_i.h>
-#include <linux/msdos_fs_sb.h>
+#include <linux/fs.h>
+
+struct fat_mount_options {
+	uid_t fs_uid;
+	gid_t fs_gid;
+	unsigned short fs_fmask;
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
+
+#define FAT_HASH_BITS	8
+#define FAT_HASH_SIZE	(1UL << FAT_HASH_BITS)
+#define FAT_HASH_MASK	(FAT_HASH_SIZE-1)
+
+/*
+ * MS-DOS file system in-core superblock data
+ */
+struct msdos_sb_info {
+	unsigned short sec_per_clus; /* sectors/cluster */
+	unsigned short cluster_bits; /* log2(cluster_size) */
+	unsigned int cluster_size;   /* cluster size */
+	unsigned char fats,fat_bits; /* number of FATs, FAT bits (12 or 16) */
+	unsigned short fat_start;
+	unsigned long fat_length;    /* FAT start & length (sec.) */
+	unsigned long dir_start;
+	unsigned short dir_entries;  /* root dir start & entries */
+	unsigned long data_start;    /* first data sector */
+	unsigned long clusters;      /* number of clusters */
+	unsigned long root_cluster;  /* first cluster of the root directory */
+	unsigned long fsinfo_sector; /* sector number of FAT32 fsinfo */
+	struct semaphore fat_lock;
+	int prev_free;               /* previously allocated cluster number */
+	int free_clusters;           /* -1 if undefined */
+	struct fat_mount_options options;
+	struct nls_table *nls_disk;  /* Codepage used on disk */
+	struct nls_table *nls_io;    /* Charset used for input and display */
+	void *dir_ops;		     /* Opaque; default directory operations */
+	int dir_per_block;	     /* dir entries per block */
+	int dir_per_block_bits;	     /* log2(dir_per_block) */
+
+	spinlock_t inode_hash_lock;
+	struct hlist_head inode_hashtable[FAT_HASH_SIZE];
+};
+
+#define FAT_CACHE_VALID	0	/* special case for valid cache */
+
+/*
+ * MS-DOS file system inode data in memory
+ */
+struct msdos_inode_info {
+	spinlock_t cache_lru_lock;
+	struct list_head cache_lru;
+	int nr_caches;
+	/* for avoiding the race between fat_free() and fat_get_cluster() */
+	unsigned int cache_valid_id;
+
+	loff_t mmu_private;
+	int i_start;	/* first cluster or 0 */
+	int i_logstart;	/* logical first cluster */
+	int i_attrs;	/* unused attribute bits */
+	int i_ctime_ms;	/* unused change time in milliseconds */
+	loff_t i_pos;	/* on-disk position of directory entry or 0 */
+	struct hlist_node i_fat_hash;	/* hash by i_location */
+	struct inode vfs_inode;
+};
 
 static inline struct msdos_sb_info *MSDOS_SB(struct super_block *sb)
 {
diff -L include/linux/msdos_fs_i.h -puN include/linux/msdos_fs_i.h~fat_remove_headers /dev/null
--- linux-2.6.10/include/linux/msdos_fs_i.h
+++ /dev/null	2004-09-13 22:36:32.000000000 +0900
@@ -1,29 +0,0 @@
-#ifndef _MSDOS_FS_I
-#define _MSDOS_FS_I
-
-#include <linux/fs.h>
-
-/*
- * MS-DOS file system inode data in memory
- */
-
-#define FAT_CACHE_VALID	0	/* special case for valid cache */
-
-struct msdos_inode_info {
-	spinlock_t cache_lru_lock;
-	struct list_head cache_lru;
-	int nr_caches;
-	/* for avoiding the race between fat_free() and fat_get_cluster() */
-	unsigned int cache_valid_id;
-
-	loff_t mmu_private;
-	int i_start;	/* first cluster or 0 */
-	int i_logstart;	/* logical first cluster */
-	int i_attrs;	/* unused attribute bits */
-	int i_ctime_ms;	/* unused change time in milliseconds */
-	loff_t i_pos;	/* on-disk position of directory entry or 0 */
-	struct hlist_node i_fat_hash;	/* hash by i_location */
-	struct inode vfs_inode;
-};
-
-#endif
diff -L include/linux/msdos_fs_sb.h -puN include/linux/msdos_fs_sb.h~fat_remove_headers /dev/null
--- linux-2.6.10/include/linux/msdos_fs_sb.h
+++ /dev/null	2004-09-13 22:36:32.000000000 +0900
@@ -1,60 +0,0 @@
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
-	unsigned short fs_fmask;
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
-#define FAT_HASH_BITS	8
-#define FAT_HASH_SIZE	(1UL << FAT_HASH_BITS)
-#define FAT_HASH_MASK	(FAT_HASH_SIZE-1)
-
-struct msdos_sb_info {
-	unsigned short sec_per_clus; /* sectors/cluster */
-	unsigned short cluster_bits; /* log2(cluster_size) */
-	unsigned int cluster_size;   /* cluster size */
-	unsigned char fats,fat_bits; /* number of FATs, FAT bits (12 or 16) */
-	unsigned short fat_start;
-	unsigned long fat_length;    /* FAT start & length (sec.) */
-	unsigned long dir_start;
-	unsigned short dir_entries;  /* root dir start & entries */
-	unsigned long data_start;    /* first data sector */
-	unsigned long clusters;      /* number of clusters */
-	unsigned long root_cluster;  /* first cluster of the root directory */
-	unsigned long fsinfo_sector; /* sector number of FAT32 fsinfo */
-	struct semaphore fat_lock;
-	int prev_free;               /* previously allocated cluster number */
-	int free_clusters;           /* -1 if undefined */
-	struct fat_mount_options options;
-	struct nls_table *nls_disk;  /* Codepage used on disk */
-	struct nls_table *nls_io;    /* Charset used for input and display */
-	void *dir_ops;		     /* Opaque; default directory operations */
-	int dir_per_block;	     /* dir entries per block */
-	int dir_per_block_bits;	     /* log2(dir_per_block) */
-
-	spinlock_t inode_hash_lock;
-	struct hlist_head inode_hashtable[FAT_HASH_SIZE];
-};
-
-#endif
_
