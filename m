Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311470AbSCNBnq>; Wed, 13 Mar 2002 20:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311471AbSCNBni>; Wed, 13 Mar 2002 20:43:38 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:7067 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S311470AbSCNBnZ>; Wed, 13 Mar 2002 20:43:25 -0500
Message-ID: <3C900021.6040701@didntduck.org>
Date: Wed, 13 Mar 2002 20:42:57 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] struct super_block cleanup - qnx4
Content-Type: multipart/mixed;
 boundary="------------050405040807090108050701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050405040807090108050701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Seperates qnx4_sb_info from struct super_block.

-- 

						Brian Gerst

--------------050405040807090108050701
Content-Type: text/plain;
 name="sb-qnx4-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb-qnx4-1"

diff -urN linux-2.5.7-pre1/fs/qnx4/bitmap.c linux/fs/qnx4/bitmap.c
--- linux-2.5.7-pre1/fs/qnx4/bitmap.c	Thu Mar  7 21:18:54 2002
+++ linux/fs/qnx4/bitmap.c	Wed Mar 13 20:06:39 2002
@@ -62,11 +62,11 @@
 
 unsigned long qnx4_count_free_blocks(struct super_block *sb)
 {
-	int start = le32_to_cpu(sb->u.qnx4_sb.BitMap->di_first_xtnt.xtnt_blk) - 1;
+	int start = le32_to_cpu(qnx4_sb(sb)->BitMap->di_first_xtnt.xtnt_blk) - 1;
 	int total = 0;
 	int total_free = 0;
 	int offset = 0;
-	int size = le32_to_cpu(sb->u.qnx4_sb.BitMap->di_size);
+	int size = le32_to_cpu(qnx4_sb(sb)->BitMap->di_size);
 	struct buffer_head *bh;
 
 	while (total < size) {
@@ -87,8 +87,8 @@
 
 int qnx4_is_free(struct super_block *sb, long block)
 {
-	int start = le32_to_cpu(sb->u.qnx4_sb.BitMap->di_first_xtnt.xtnt_blk) - 1;
-	int size = le32_to_cpu(sb->u.qnx4_sb.BitMap->di_size);
+	int start = le32_to_cpu(qnx4_sb(sb)->BitMap->di_first_xtnt.xtnt_blk) - 1;
+	int size = le32_to_cpu(qnx4_sb(sb)->BitMap->di_size);
 	struct buffer_head *bh;
 	const char *g;
 	int ret = -EIO;
@@ -116,8 +116,8 @@
 
 int qnx4_set_bitmap(struct super_block *sb, long block, int busy)
 {
-	int start = le32_to_cpu(sb->u.qnx4_sb.BitMap->di_first_xtnt.xtnt_blk) - 1;
-	int size = le32_to_cpu(sb->u.qnx4_sb.BitMap->di_size);
+	int start = le32_to_cpu(qnx4_sb(sb)->BitMap->di_first_xtnt.xtnt_blk) - 1;
+	int size = le32_to_cpu(qnx4_sb(sb)->BitMap->di_size);
 	struct buffer_head *bh;
 	char *g;
 
diff -urN linux-2.5.7-pre1/fs/qnx4/inode.c linux/fs/qnx4/inode.c
--- linux-2.5.7-pre1/fs/qnx4/inode.c	Tue Mar 12 22:44:12 2002
+++ linux/fs/qnx4/inode.c	Wed Mar 13 20:29:20 2002
@@ -147,7 +147,7 @@
 {
 	struct qnx4_sb_info *qs;
 
-	qs = &sb->u.qnx4_sb;
+	qs = qnx4_sb(sb);
 	qs->Version = QNX4_VERSION;
 	if (*flags & MS_RDONLY) {
 		return 0;
@@ -280,7 +280,7 @@
 {
 	buf->f_type    = sb->s_magic;
 	buf->f_bsize   = sb->s_blocksize;
-	buf->f_blocks  = le32_to_cpu(sb->u.qnx4_sb.BitMap->di_size) * 8;
+	buf->f_blocks  = le32_to_cpu(qnx4_sb(sb)->BitMap->di_size) * 8;
 	buf->f_bfree   = qnx4_count_free_blocks(sb);
 	buf->f_bavail  = buf->f_bfree;
 	buf->f_namelen = QNX4_NAME_MAX;
@@ -301,12 +301,12 @@
 	int i, j;
 	int found = 0;
 
-	if (*(sb->u.qnx4_sb.sb->RootDir.di_fname) != '/') {
+	if (*(qnx4_sb(sb)->sb->RootDir.di_fname) != '/') {
 		return "no qnx4 filesystem (no root dir).";
 	} else {
 		QNX4DEBUG(("QNX4 filesystem found on dev %s.\n", sb->s_id));
-		rd = le32_to_cpu(sb->u.qnx4_sb.sb->RootDir.di_first_xtnt.xtnt_blk) - 1;
-		rl = le32_to_cpu(sb->u.qnx4_sb.sb->RootDir.di_first_xtnt.xtnt_size);
+		rd = le32_to_cpu(qnx4_sb(sb)->sb->RootDir.di_first_xtnt.xtnt_blk) - 1;
+		rl = le32_to_cpu(qnx4_sb(sb)->sb->RootDir.di_first_xtnt.xtnt_size);
 		for (j = 0; j < rl; j++) {
 			bh = sb_bread(sb, rd + j);	/* root dir, first block */
 			if (bh == NULL) {
@@ -318,8 +318,8 @@
 					QNX4DEBUG(("Rootdir entry found : [%s]\n", rootdir->di_fname));
 					if (!strncmp(rootdir->di_fname, QNX4_BMNAME, sizeof QNX4_BMNAME)) {
 						found = 1;
-						sb->u.qnx4_sb.BitMap = kmalloc( sizeof( struct qnx4_inode_entry ), GFP_KERNEL );
-						memcpy( sb->u.qnx4_sb.BitMap, rootdir, sizeof( struct qnx4_inode_entry ) );	/* keep bitmap inode known */
+						qnx4_sb(sb)->BitMap = kmalloc( sizeof( struct qnx4_inode_entry ), GFP_KERNEL );
+						memcpy( qnx4_sb(sb)->BitMap, rootdir, sizeof( struct qnx4_inode_entry ) );	/* keep bitmap inode known */
 						break;
 					}
 				}
@@ -341,6 +341,13 @@
 	struct buffer_head *bh;
 	struct inode *root;
 	const char *errmsg;
+	struct qnx4_sb_info *qs;
+
+	qs = kmalloc(sizeof(struct qnx4_sb_info), GFP_KERNEL);
+	if (!qs)
+		return -ENOMEM;
+	s->u.generic_sbp = qs;
+	memset(qs, 0, sizeof(struct qnx4_sb_info));
 
 	sb_set_blocksize(s, QNX4_BLOCK_SIZE);
 
@@ -369,8 +376,8 @@
 #ifndef CONFIG_QNX4FS_RW
 	s->s_flags |= MS_RDONLY;	/* Yup, read-only yet */
 #endif
-	s->u.qnx4_sb.sb_buf = bh;
-	s->u.qnx4_sb.sb = (struct qnx4_super_block *) bh->b_data;
+	qnx4_sb(s)->sb_buf = bh;
+	qnx4_sb(s)->sb = (struct qnx4_super_block *) bh->b_data;
 
 
  	/* check before allocating dentries, inodes, .. */
@@ -401,13 +408,17 @@
       out:
 	brelse(bh);
       outnobh:
-
+	kfree(qs);
+	s->u.generic_sbp = NULL;
 	return -EINVAL;
 }
 
 static void qnx4_put_super(struct super_block *sb)
 {
-	kfree( sb->u.qnx4_sb.BitMap );
+	struct qnx4_sb_info *qs = qnx4_sb(sb);
+	kfree( qs->BitMap );
+	kfree( qs );
+	sb->u.generic_sbp = NULL;
 	return;
 }
 
diff -urN linux-2.5.7-pre1/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.5.7-pre1/include/linux/fs.h	Tue Mar 12 22:44:13 2002
+++ linux/include/linux/fs.h	Wed Mar 13 20:24:17 2002
@@ -663,7 +663,6 @@
 #include <linux/smb_fs_sb.h>
 #include <linux/hfs_fs_sb.h>
 #include <linux/adfs_fs_sb.h>
-#include <linux/qnx4_fs_sb.h>
 #include <linux/reiserfs_fs_sb.h>
 #include <linux/bfs_fs_sb.h>
 #include <linux/udf_fs_sb.h>
@@ -720,7 +719,6 @@
 		struct smb_sb_info	smbfs_sb;
 		struct hfs_sb_info	hfs_sb;
 		struct adfs_sb_info	adfs_sb;
-		struct qnx4_sb_info	qnx4_sb;
 		struct reiserfs_sb_info	reiserfs_sb;
 		struct bfs_sb_info	bfs_sb;
 		struct udf_sb_info	udf_sb;
diff -urN linux-2.5.7-pre1/include/linux/qnx4_fs.h linux/include/linux/qnx4_fs.h
--- linux-2.5.7-pre1/include/linux/qnx4_fs.h	Thu Mar  7 21:18:31 2002
+++ linux/include/linux/qnx4_fs.h	Wed Mar 13 20:27:37 2002
@@ -97,6 +97,13 @@
 #define QNX4DEBUG(X) (void) 0
 #endif
 
+struct qnx4_sb_info {
+	struct buffer_head	*sb_buf;	/* superblock buffer */
+	struct qnx4_super_block	*sb;		/* our superblock */
+	unsigned int		Version;	/* may be useful */
+	struct qnx4_inode_entry	*BitMap;	/* useful */
+};
+
 struct qnx4_inode_info {
 	struct qnx4_inode_entry raw;
 	unsigned long mmu_private;
@@ -126,6 +133,11 @@
 extern int qnx4_sync_inode(struct inode *inode);
 extern int qnx4_get_block(struct inode *inode, sector_t iblock, struct buffer_head *bh, int create);
 
+static inline struct qnx4_sb_info *qnx4_sb(struct super_block *sb)
+{
+	return sb->u.generic_sbp;
+}
+
 static inline struct qnx4_inode_info *qnx4_i(struct inode *inode)
 {
 	return list_entry(inode, struct qnx4_inode_info, vfs_inode);
diff -urN linux-2.5.7-pre1/include/linux/qnx4_fs_sb.h linux/include/linux/qnx4_fs_sb.h
--- linux-2.5.7-pre1/include/linux/qnx4_fs_sb.h	Wed Mar 13 09:24:40 2002
+++ linux/include/linux/qnx4_fs_sb.h	Wed Dec 31 19:00:00 1969
@@ -1,27 +0,0 @@
-/*
- *  Name                         : qnx4_fs_sb.h
- *  Author                       : Richard Frowijn
- *  Function                     : qnx4 superblock definitions
- *  Version                      : 1.0.2
- *  Last modified                : 2000-01-06
- * 
- *  History                      : 23-03-1998 created
- * 
- */
-#ifndef _QNX4_FS_SB
-#define _QNX4_FS_SB
-
-#include <linux/qnx4_fs.h>
-
-/*
- * qnx4 super-block data in memory
- */
-
-struct qnx4_sb_info {
-	struct buffer_head	*sb_buf;	/* superblock buffer */
-	struct qnx4_super_block	*sb;		/* our superblock */
-	unsigned int		Version;	/* may be useful */
-	struct qnx4_inode_entry	*BitMap;	/* useful */
-};
-
-#endif

--------------050405040807090108050701--

