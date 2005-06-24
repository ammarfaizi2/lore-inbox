Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263253AbVFXU5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263253AbVFXU5k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 16:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVFXUyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 16:54:32 -0400
Received: from mail2.ameuro.de ([195.140.232.8]:37895 "EHLO mail2.ameuro.de")
	by vger.kernel.org with ESMTP id S263220AbVFXUvm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 16:51:42 -0400
Date: Fri, 24 Jun 2005 20:52:52 +0000
From: Anders Larsen <al@alarsen.net>
Subject: [patch 1/1] fs/qnx4/*: fix sparse warnings
To: Linus Torvalds <torvalds@osdl.org>
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org,
       Alexey Dobriyan <adobriyan@mail.ru>, Domen Puncer <domen@coderock.org>
X-Mailer: Balsa 2.3.2
Message-Id: <1119646372l.5901l.1l@oscar.alarsen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-AEV-SpamCheck: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Dobriyan <adobriyan@mail.ru>

This patch fixes sparse warnings in the qnx4fs (and might even make
qnx4fs work on big-endian boxes)

Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Anders Larsen <al@alarsen.net>
---
 fs/qnx4/dir.c            |    2 +-
 fs/qnx4/inode.c          |    4 ++--
 include/linux/qnx4_fs.h  |   18 +++++++++---------
 include/linux/qnxtypes.h |   16 ++++++++--------
 4 files changed, 20 insertions(+), 20 deletions(-)

Index: quilt/fs/qnx4/dir.c
===================================================================
--- quilt.orig/fs/qnx4/dir.c
+++ quilt/fs/qnx4/dir.c
@@ -61,7 +61,7 @@ static int qnx4_readdir(struct file *fil
 						ino = blknum * QNX4_INODES_PER_BLOCK + ix - 1;
 					else {
 						le  = (struct qnx4_link_info*)de;
-						ino = ( le->dl_inode_blk - 1 ) *
+						ino = ( le32_to_cpu(le->dl_inode_blk) - 1 ) *
 							QNX4_INODES_PER_BLOCK +
 							le->dl_inode_ndx;
 					}
Index: quilt/fs/qnx4/inode.c
===================================================================
--- quilt.orig/fs/qnx4/inode.c
+++ quilt/fs/qnx4/inode.c
@@ -236,7 +236,7 @@ unsigned long qnx4_block_map( struct ino
 	struct buffer_head *bh = NULL;
 	struct qnx4_xblk *xblk = NULL;
 	struct qnx4_inode_entry *qnx4_inode = qnx4_raw_inode(inode);
-	qnx4_nxtnt_t nxtnt = le16_to_cpu(qnx4_inode->di_num_xtnts);
+	u16 nxtnt = le16_to_cpu(qnx4_inode->di_num_xtnts);
 
 	if ( iblock < le32_to_cpu(qnx4_inode->di_first_xtnt.xtnt_size) ) {
 		// iblock is in the first extent. This is easy.
@@ -372,7 +372,7 @@ static int qnx4_fill_super(struct super_
 		printk("qnx4: unable to read the superblock\n");
 		goto outnobh;
 	}
-	if ( le32_to_cpu( *(__u32*)bh->b_data ) != QNX4_SUPER_MAGIC ) {
+	if ( le32_to_cpup((__le32*) bh->b_data) != QNX4_SUPER_MAGIC ) {
 		if (!silent)
 			printk("qnx4: wrong fsid in superblock.\n");
 		goto out;
Index: quilt/include/linux/qnx4_fs.h
===================================================================
--- quilt.orig/include/linux/qnx4_fs.h
+++ quilt/include/linux/qnx4_fs.h
@@ -46,11 +46,11 @@ struct qnx4_inode_entry {
 	char		di_fname[QNX4_SHORT_NAME_MAX];
 	qnx4_off_t	di_size;
 	qnx4_xtnt_t	di_first_xtnt;
-	__u32		di_xblk;
-	__s32		di_ftime;
-	__s32		di_mtime;
-	__s32		di_atime;
-	__s32		di_ctime;
+	__le32		di_xblk;
+	__le32		di_ftime;
+	__le32		di_mtime;
+	__le32		di_atime;
+	__le32		di_ctime;
 	qnx4_nxtnt_t	di_num_xtnts;
 	qnx4_mode_t	di_mode;
 	qnx4_muid_t	di_uid;
@@ -63,18 +63,18 @@ struct qnx4_inode_entry {
 
 struct qnx4_link_info {
 	char		dl_fname[QNX4_NAME_MAX];
-	__u32		dl_inode_blk;
+	__le32		dl_inode_blk;
 	__u8		dl_inode_ndx;
 	__u8		dl_spare[10];
 	__u8		dl_status;
 };
 
 struct qnx4_xblk {
-	__u32		xblk_next_xblk;
-	__u32		xblk_prev_xblk;
+	__le32		xblk_next_xblk;
+	__le32		xblk_prev_xblk;
 	__u8		xblk_num_xtnts;
 	__u8		xblk_spare[3];
-	__s32		xblk_num_blocks;
+	__le32		xblk_num_blocks;
 	qnx4_xtnt_t	xblk_xtnts[QNX4_MAX_XTNTS_PER_XBLK];
 	char		xblk_signature[8];
 	qnx4_xtnt_t	xblk_first_xtnt;
Index: quilt/include/linux/qnxtypes.h
===================================================================
--- quilt.orig/include/linux/qnxtypes.h
+++ quilt/include/linux/qnxtypes.h
@@ -12,18 +12,18 @@
 #ifndef _QNX4TYPES_H
 #define _QNX4TYPES_H
 
-typedef __u16 qnx4_nxtnt_t;
+typedef __le16 qnx4_nxtnt_t;
 typedef __u8  qnx4_ftype_t;
 
 typedef struct {
-	__u32 xtnt_blk;
-	__u32 xtnt_size;
+	__le32 xtnt_blk;
+	__le32 xtnt_size;
 } qnx4_xtnt_t;
 
-typedef __u16 qnx4_mode_t;
-typedef __u16 qnx4_muid_t;
-typedef __u16 qnx4_mgid_t;
-typedef __u32 qnx4_off_t;
-typedef __u16 qnx4_nlink_t;
+typedef __le16 qnx4_mode_t;
+typedef __le16 qnx4_muid_t;
+typedef __le16 qnx4_mgid_t;
+typedef __le32 qnx4_off_t;
+typedef __le16 qnx4_nlink_t;
 
 #endif

--





