Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUJXNxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUJXNxR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 09:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbUJXNvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 09:51:19 -0400
Received: from verein.lst.de ([213.95.11.210]:62630 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261478AbUJXNsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 09:48:20 -0400
Date: Sun, 24 Oct 2004 15:48:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] merge msdos_fs_{i,sb}.h into msdos_fs.h
Message-ID: <20041024134812.GA20353@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- 1.42/include/linux/msdos_fs.h	2004-10-20 10:12:10 +02:00
+++ edited/include/linux/msdos_fs.h	2004-10-20 22:06:30 +02:00
@@ -189,8 +189,84 @@
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
--- 1.10/include/linux/msdos_fs_i.h	2004-10-20 10:12:09 +02:00
+++ edited/include/linux/msdos_fs_i.h	2004-10-20 22:05:57 +02:00
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
===== include/linux/msdos_fs_sb.h 1.16 vs edited =====
--- 1.16/include/linux/msdos_fs_sb.h	2004-10-20 10:12:09 +02:00
+++ edited/include/linux/msdos_fs_sb.h	2004-10-20 22:05:59 +02:00
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
