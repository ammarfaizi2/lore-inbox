Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311306AbSCLRLs>; Tue, 12 Mar 2002 12:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311291AbSCLRL3>; Tue, 12 Mar 2002 12:11:29 -0500
Received: from rwcrmhc54.attbi.com ([216.148.227.87]:24218 "EHLO
	rwcrmhc54.attbi.com") by vger.kernel.org with ESMTP
	id <S311278AbSCLRLZ>; Tue, 12 Mar 2002 12:11:25 -0500
Message-ID: <3C8E3694.1BA6DF48@didntduck.org>
Date: Tue, 12 Mar 2002 12:10:44 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alexander Viro <viro@math.psu.edu>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] struct super_block cleanup - cramfs
Content-Type: multipart/mixed;
 boundary="------------B7D721F31C38E86C19BFE518"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B7D721F31C38E86C19BFE518
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Seperates cramfs_sb_info from struct super_block.

-- 

						Brian Gerst
--------------B7D721F31C38E86C19BFE518
Content-Type: text/plain; charset=us-ascii;
 name="sb-cramfs-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb-cramfs-1"

diff -urN linux-2.5.6/fs/cramfs/inode.c linux/fs/cramfs/inode.c
--- linux-2.5.6/fs/cramfs/inode.c	Fri Mar  8 07:51:32 2002
+++ linux/fs/cramfs/inode.c	Tue Mar 12 11:37:33 2002
@@ -20,16 +20,12 @@
 #include <linux/blkdev.h>
 #include <linux/cramfs_fs.h>
 #include <linux/smp_lock.h>
+#include <linux/slab.h>
+#include <linux/cramfs_fs_sb.h>
 #include <asm/semaphore.h>
 
 #include <asm/uaccess.h>
 
-#define CRAMFS_SB_MAGIC u.cramfs_sb.magic
-#define CRAMFS_SB_SIZE u.cramfs_sb.size
-#define CRAMFS_SB_BLOCKS u.cramfs_sb.blocks
-#define CRAMFS_SB_FILES u.cramfs_sb.files
-#define CRAMFS_SB_FLAGS u.cramfs_sb.flags
-
 static struct super_operations cramfs_ops;
 static struct inode_operations cramfs_dir_inode_operations;
 static struct file_operations cramfs_directory_operations;
@@ -188,12 +184,23 @@
 	return read_buffers[buffer] + offset;
 }
 
+static void cramfs_put_super(struct super_block *sb)
+{
+	kfree(sb->u.generic_sbp);
+	sb->u.generic_sbp = NULL;
+}
 
 static int cramfs_fill_super(struct super_block *sb, void *data, int silent)
 {
 	int i;
 	struct cramfs_super super;
 	unsigned long root_offset;
+	struct cramfs_sb_info *sbi;
+
+	sbi = kmalloc(sizeof(struct cramfs_sb_info), GFP_KERNEL);
+	if (!sbi)
+		return -ENOMEM;
+	sb->u.generic_sbp = sbi;
 
 	sb_set_blocksize(sb, PAGE_CACHE_SIZE);
 
@@ -229,16 +236,16 @@
 	}
 	root_offset = super.root.offset << 2;
 	if (super.flags & CRAMFS_FLAG_FSID_VERSION_2) {
-		sb->CRAMFS_SB_SIZE=super.size;
-		sb->CRAMFS_SB_BLOCKS=super.fsid.blocks;
-		sb->CRAMFS_SB_FILES=super.fsid.files;
+		sbi->size=super.size;
+		sbi->blocks=super.fsid.blocks;
+		sbi->files=super.fsid.files;
 	} else {
-		sb->CRAMFS_SB_SIZE=1<<28;
-		sb->CRAMFS_SB_BLOCKS=0;
-		sb->CRAMFS_SB_FILES=0;
+		sbi->size=1<<28;
+		sbi->blocks=0;
+		sbi->files=0;
 	}
-	sb->CRAMFS_SB_MAGIC=super.magic;
-	sb->CRAMFS_SB_FLAGS=super.flags;
+	sbi->magic=super.magic;
+	sbi->flags=super.flags;
 	if (root_offset == 0)
 		printk(KERN_INFO "cramfs: empty filesystem");
 	else if (!(super.flags & CRAMFS_FLAG_SHIFTED_ROOT_OFFSET) &&
@@ -254,6 +261,8 @@
 	sb->s_root = d_alloc_root(get_cramfs_inode(sb, &super.root));
 	return 0;
 out:
+	kfree(sbi);
+	sb->u.generic_sbp = NULL;
 	return -EINVAL;
 }
 
@@ -261,10 +270,10 @@
 {
 	buf->f_type = CRAMFS_MAGIC;
 	buf->f_bsize = PAGE_CACHE_SIZE;
-	buf->f_blocks = sb->CRAMFS_SB_BLOCKS;
+	buf->f_blocks = CRAMFS_SB(sb)->blocks;
 	buf->f_bfree = 0;
 	buf->f_bavail = 0;
-	buf->f_files = sb->CRAMFS_SB_FILES;
+	buf->f_files = CRAMFS_SB(sb)->files;
 	buf->f_ffree = 0;
 	buf->f_namelen = CRAMFS_MAXPATHLEN;
 	return 0;
@@ -334,7 +343,7 @@
 	int sorted;
 
 	lock_kernel();
-	sorted = dir->i_sb->CRAMFS_SB_FLAGS & CRAMFS_FLAG_SORTED_DIRS;
+	sorted = CRAMFS_SB(dir->i_sb)->flags & CRAMFS_FLAG_SORTED_DIRS;
 	while (offset < dir->i_size) {
 		struct cramfs_inode *de;
 		char *name;
@@ -445,6 +454,7 @@
 };
 
 static struct super_operations cramfs_ops = {
+	put_super:	cramfs_put_super,
 	statfs:		cramfs_statfs,
 };
 
diff -urN linux-2.5.6/include/linux/cramfs_fs_sb.h linux/include/linux/cramfs_fs_sb.h
--- linux-2.5.6/include/linux/cramfs_fs_sb.h	Thu Jul 19 19:14:53 2001
+++ linux/include/linux/cramfs_fs_sb.h	Tue Mar 12 11:35:33 2002
@@ -12,4 +12,9 @@
 			unsigned long flags;
 };
 
+static inline struct cramfs_sb_info *CRAMFS_SB(struct super_block *sb)
+{
+	return sb->u.generic_sbp;
+}
+
 #endif
diff -urN linux-2.5.6/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.5.6/include/linux/fs.h	Tue Mar 12 11:33:22 2002
+++ linux/include/linux/fs.h	Tue Mar 12 11:35:38 2002
@@ -291,7 +291,6 @@
 #include <linux/pipe_fs_i.h>
 /* #include <linux/umsdos_fs_i.h> */
 #include <linux/romfs_fs_i.h>
-#include <linux/cramfs_fs_sb.h>
 
 /*
  * Attribute flags.  These should be or-ed together to figure out what
@@ -671,7 +670,6 @@
 #include <linux/bfs_fs_sb.h>
 #include <linux/udf_fs_sb.h>
 #include <linux/ncp_fs_sb.h>
-#include <linux/cramfs_fs_sb.h>
 #include <linux/jffs2_fs_sb.h>
 
 extern struct list_head super_blocks;
@@ -731,7 +729,6 @@
 		struct udf_sb_info	udf_sb;
 		struct ncp_sb_info	ncpfs_sb;
 		struct jffs2_sb_info	jffs2_sb;
-		struct cramfs_sb_info	cramfs_sb;
 		void			*generic_sbp;
 	} u;
 	/*

--------------B7D721F31C38E86C19BFE518--

