Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312189AbSCRDqe>; Sun, 17 Mar 2002 22:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312190AbSCRDqZ>; Sun, 17 Mar 2002 22:46:25 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:14524 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S312189AbSCRDqQ>; Sun, 17 Mar 2002 22:46:16 -0500
Message-ID: <3C9562E1.7050705@didntduck.org>
Date: Sun, 17 Mar 2002 22:45:37 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] struct super_block cleanup - hfs
Content-Type: multipart/mixed;
 boundary="------------030801060202090802070807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030801060202090802070807
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Seperates hfs_sb_info from struct super_block.

-- 

						Brian Gerst

--------------030801060202090802070807
Content-Type: text/plain;
 name="sb-hfs-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb-hfs-1"

diff -urN linux-2.5.7-pre2/fs/hfs/super.c linux/fs/hfs/super.c
--- linux-2.5.7-pre2/fs/hfs/super.c	Sat Mar 16 00:17:32 2002
+++ linux/fs/hfs/super.c	Sun Mar 17 20:07:45 2002
@@ -178,6 +178,9 @@
 
 	/* restore default blocksize for the device */
 	set_blocksize(sb->s_dev, BLOCK_SIZE);
+
+	kfree(sb->u.generic_sbp);
+	sb->u.generic_sbp = NULL;
 }
 
 /*
@@ -443,6 +446,7 @@
  */
 int hfs_fill_super(struct super_block *s, void *data, int silent)
 {
+	struct hfs_sb_info *sbi;
 	struct hfs_mdb *mdb;
 	struct hfs_cat_key key;
 	kdev_t dev = s->s_dev;
@@ -450,7 +454,13 @@
 	struct inode *root_inode;
 	int part;
 
-	if (!parse_options((char *)data, HFS_SB(s), &part)) {
+	sbi = kmalloc(sizeof(struct hfs_sb_info), GFP_KERNEL);
+	if (!sbi)
+		return -ENOMEM;
+	s->u.generic_sbp = sbi;
+	memset(sbi, 0, sizeof(struct hfs_sb_info));
+
+	if (!parse_options((char *)data, sbi, &part)) {
 		hfs_warn("hfs_fs: unable to parse mount options.\n");
 		goto bail3;
 	}
@@ -485,7 +495,7 @@
 		goto bail2;
 	}
 
-	HFS_SB(s)->s_mdb = mdb;
+	sbi->s_mdb = mdb;
 	if (HFS_ITYPE(mdb->next_id) != 0) {
 		hfs_warn("hfs_fs: too many files.\n");
 		goto bail1;
@@ -522,6 +532,8 @@
 bail2:
 	set_blocksize(dev, BLOCK_SIZE);
 bail3:
+	kfree(sbi);
+	sb->u.generic_sbp = NULL;
 	return -EINVAL;	
 }
 
diff -urN linux-2.5.7-pre2/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.5.7-pre2/include/linux/fs.h	Sat Mar 16 00:17:34 2002
+++ linux/include/linux/fs.h	Sun Mar 17 20:04:52 2002
@@ -653,7 +653,6 @@
 #include <linux/affs_fs_sb.h>
 #include <linux/ufs_fs_sb.h>
 #include <linux/romfs_fs_sb.h>
-#include <linux/hfs_fs_sb.h>
 #include <linux/adfs_fs_sb.h>
 #include <linux/reiserfs_fs_sb.h>
 #include <linux/bfs_fs_sb.h>
@@ -703,7 +702,6 @@
 		struct ufs_sb_info	ufs_sb;
 		struct shmem_sb_info	shmem_sb;
 		struct romfs_sb_info	romfs_sb;
-		struct hfs_sb_info	hfs_sb;
 		struct adfs_sb_info	adfs_sb;
 		struct reiserfs_sb_info	reiserfs_sb;
 		struct bfs_sb_info	bfs_sb;
diff -urN linux-2.5.7-pre2/include/linux/hfs_fs.h linux/include/linux/hfs_fs.h
--- linux-2.5.7-pre2/include/linux/hfs_fs.h	Thu Mar  7 21:18:16 2002
+++ linux/include/linux/hfs_fs.h	Sun Mar 17 20:05:09 2002
@@ -318,12 +318,17 @@
 extern void hfs_tolower(unsigned char *, int);
 
 #include <linux/hfs_fs_i.h>
+#include <linux/hfs_fs_sb.h>
 
 static inline struct hfs_inode_info *HFS_I(struct inode *inode)
 {
 	return list_entry(inode, struct hfs_inode_info, vfs_inode);
 }
-#define	HFS_SB(X)	(&((X)->u.hfs_sb))
+
+static inline struct hfs_sb_info *HFS_SB(struct super_block *sb)
+{
+	return sb->u.generic_sbp;
+}
 
 static inline void hfs_nameout(struct inode *dir, struct hfs_name *out,
 				   const char *in, int len) {

--------------030801060202090802070807--

