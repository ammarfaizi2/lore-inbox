Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289194AbSAGNWL>; Mon, 7 Jan 2002 08:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289198AbSAGNVz>; Mon, 7 Jan 2002 08:21:55 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:34445 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S289188AbSAGNVZ>;
	Mon, 7 Jan 2002 08:21:25 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: torvalds@transmeta.com, viro@math.psu.edu, phillips@bonn-fries.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
Subject: PATCH 2.5.2.9: ext2 unbork fs.h (part 3/7)
Message-Id: <20020107132121.7169C1F6C@gtf.org>
Date: Mon,  7 Jan 2002 07:21:21 -0600 (CST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch3 desc: dynamically allocate sb->u.ext2_sbp



diff -Naur -X /g/g/lib/dontdiff linux-fs2/fs/ext2/balloc.c linux-fs3/fs/ext2/balloc.c
--- linux-fs2/fs/ext2/balloc.c	Mon Jan  7 00:42:14 2002
+++ linux-fs3/fs/ext2/balloc.c	Mon Jan  7 01:53:43 2002
@@ -14,6 +14,7 @@
 #include <linux/config.h>
 #include <linux/fs.h>
 #include <linux/ext2_fs.h>
+#include <linux/ext2_fs_sb.h>
 #include <linux/locks.h>
 #include <linux/quotaops.h>
 
diff -Naur -X /g/g/lib/dontdiff linux-fs2/fs/ext2/dir.c linux-fs3/fs/ext2/dir.c
--- linux-fs2/fs/ext2/dir.c	Mon Jan  7 00:00:20 2002
+++ linux-fs3/fs/ext2/dir.c	Mon Jan  7 01:53:55 2002
@@ -23,6 +23,7 @@
 
 #include <linux/fs.h>
 #include <linux/ext2_fs.h>
+#include <linux/ext2_fs_sb.h>
 #include <linux/pagemap.h>
 
 typedef struct ext2_dir_entry_2 ext2_dirent;
diff -Naur -X /g/g/lib/dontdiff linux-fs2/fs/ext2/ialloc.c linux-fs3/fs/ext2/ialloc.c
--- linux-fs2/fs/ext2/ialloc.c	Mon Jan  7 00:42:49 2002
+++ linux-fs3/fs/ext2/ialloc.c	Mon Jan  7 01:54:10 2002
@@ -15,6 +15,7 @@
 #include <linux/config.h>
 #include <linux/fs.h>
 #include <linux/ext2_fs.h>
+#include <linux/ext2_fs_sb.h>
 #include <linux/locks.h>
 #include <linux/quotaops.h>
 
diff -Naur -X /g/g/lib/dontdiff linux-fs2/fs/ext2/inode.c linux-fs3/fs/ext2/inode.c
--- linux-fs2/fs/ext2/inode.c	Mon Jan  7 09:19:19 2002
+++ linux-fs3/fs/ext2/inode.c	Mon Jan  7 09:19:39 2002
@@ -24,6 +24,7 @@
 
 #include <linux/fs.h>
 #include <linux/ext2_fs.h>
+#include <linux/ext2_fs_sb.h>
 #include <linux/locks.h>
 #include <linux/smp_lock.h>
 #include <linux/sched.h>
diff -Naur -X /g/g/lib/dontdiff linux-fs2/fs/ext2/super.c linux-fs3/fs/ext2/super.c
--- linux-fs2/fs/ext2/super.c	Mon Jan  7 00:44:34 2002
+++ linux-fs3/fs/ext2/super.c	Mon Jan  7 07:02:23 2002
@@ -21,6 +21,7 @@
 #include <linux/string.h>
 #include <linux/fs.h>
 #include <linux/ext2_fs.h>
+#include <linux/ext2_fs_sb.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/locks.h>
@@ -149,7 +150,8 @@
 			brelse (esb->s_block_bitmap[i]);
 	brelse (esb->s_sbh);
 
-	return;
+	kfree(esb);
+	sb->u.ext2_sbp = NULL;
 }
 
 static struct super_operations ext2_sops = {
@@ -419,8 +421,12 @@
 	int i, j;
 	struct ext2_sb_info *esb;
 
-	/* when dynamically allocated, this will change */
-	esb = ext2_sb(sb);
+	/* dynamically allocate fs-private sb data */
+	sb->u.ext2_sbp = kmalloc(sizeof(*esb), GFP_NOFS);
+	if (!sb->u.ext2_sbp)
+		return NULL;
+	esb = sb->u.ext2_sbp;
+	memset(esb, 0, sizeof(*esb));
 
 	/*
 	 * See what the current blocksize for the device is, and
@@ -433,13 +439,13 @@
 	esb->s_mount_opt = 0;
 	if (!parse_options ((char *) data, &sb_block, &resuid, &resgid,
 	    &esb->s_mount_opt)) {
-		return NULL;
+		goto err;
 	}
 
 	blocksize = sb_min_blocksize(sb, BLOCK_SIZE);
 	if (!blocksize) {
 		printk ("EXT2-fs: unable to set blocksize\n");
-		return NULL;
+		goto err;
 	}
 
 	/*
@@ -454,7 +460,7 @@
 
 	if (!(bh = sb_bread(sb, logic_sb_block))) {
 		printk ("EXT2-fs: unable to read superblock\n");
-		return NULL;
+		goto err;
 	}
 	/*
 	 * Note: s_es must be initialized as soon as possible because
@@ -500,7 +506,7 @@
 
 		if (!sb_set_blocksize(sb, blocksize)) {
 			printk(KERN_ERR "EXT2-fs: blocksize too small for device.\n");
-			return NULL;
+			goto err;
 		}
 
 		logic_sb_block = (sb_block*BLOCK_SIZE) / blocksize;
@@ -658,6 +664,9 @@
 	kfree(esb->s_group_desc);
 failed_mount:
 	brelse(bh);
+err:
+	kfree(esb);
+	sb->u.ext2_sbp = NULL;
 	return NULL;
 }
 
diff -Naur -X /g/g/lib/dontdiff linux-fs2/include/linux/ext2_fs.h linux-fs3/include/linux/ext2_fs.h
--- linux-fs2/include/linux/ext2_fs.h	Mon Jan  7 09:28:01 2002
+++ linux-fs3/include/linux/ext2_fs.h	Mon Jan  7 08:00:23 2002
@@ -604,9 +604,9 @@
 
 static inline struct ext2_sb_info *ext2_sb(struct super_block *sb)
 {
-	if (!sb)
+	if (!sb->u.ext2_sbp)
 		BUG();
-	return &sb->u.ext2_sb;
+	return sb->u.ext2_sbp;
 }
 
 extern void ext2_error (struct super_block *, const char *, const char *, ...)
diff -Naur -X /g/g/lib/dontdiff linux-fs2/include/linux/fs.h linux-fs3/include/linux/fs.h
--- linux-fs2/include/linux/fs.h	Mon Jan  7 09:24:33 2002
+++ linux-fs3/include/linux/fs.h	Mon Jan  7 06:54:45 2002
@@ -664,7 +664,6 @@
 #define MNT_DETACH	0x00000002	/* Just detach from the tree */
 
 #include <linux/minix_fs_sb.h>
-#include <linux/ext2_fs_sb.h>
 #include <linux/ext3_fs_sb.h>
 #include <linux/hpfs_fs_sb.h>
 #include <linux/ntfs_fs_sb.h>
@@ -687,6 +686,8 @@
 #include <linux/cramfs_fs_sb.h>
 #include <linux/jffs2_fs_sb.h>
 
+struct ext2_sb_info;
+
 extern struct list_head super_blocks;
 extern spinlock_t sb_lock;
 
@@ -722,7 +723,6 @@
 
 	union {
 		struct minix_sb_info	minix_sb;
-		struct ext2_sb_info	ext2_sb;
 		struct ext3_sb_info	ext3_sb;
 		struct hpfs_sb_info	hpfs_sb;
 		struct ntfs_sb_info	ntfs_sb;
@@ -745,6 +745,9 @@
 		struct ncp_sb_info	ncpfs_sb;
 		struct jffs2_sb_info	jffs2_sb;
 		struct cramfs_sb_info	cramfs_sb;
+
+		struct ext2_sb_info	*ext2_sbp;
+
 		void			*generic_sbp;
 	} u;
 	/*
