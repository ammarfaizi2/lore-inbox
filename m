Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030624AbWJJWke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030624AbWJJWke (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 18:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030626AbWJJWkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 18:40:06 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:64130 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030622AbWJJWjQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 18:39:16 -0400
To: torvalds@osdl.org
Subject: [PATCH 15/16] ufs endianness annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXQFn-000067-VW@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 23:39:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Sun, 13 Aug 2006 01:54:30 -0400

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ufs/util.c          |   14 ++++++--------
 include/linux/ufs_fs.h |   10 +++++++++-
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/ufs/util.c b/fs/ufs/util.c
index 22f820a..1743757 100644
--- a/fs/ufs/util.c
+++ b/fs/ufs/util.c
@@ -184,14 +184,13 @@ void _ubh_memcpyubh_(struct ufs_sb_priva
 dev_t
 ufs_get_inode_dev(struct super_block *sb, struct ufs_inode_info *ufsi)
 {
-	__fs32 fs32;
+	__u32 fs32;
 	dev_t dev;
 
 	if ((UFS_SB(sb)->s_flags & UFS_ST_MASK) == UFS_ST_SUNx86)
-		fs32 = ufsi->i_u1.i_data[1];
+		fs32 = fs32_to_cpu(sb, ufsi->i_u1.i_data[1]);
 	else
-		fs32 = ufsi->i_u1.i_data[0];
-	fs32 = fs32_to_cpu(sb, fs32);
+		fs32 = fs32_to_cpu(sb, ufsi->i_u1.i_data[0]);
 	switch (UFS_SB(sb)->s_flags & UFS_ST_MASK) {
 	case UFS_ST_SUNx86:
 	case UFS_ST_SUN:
@@ -212,7 +211,7 @@ ufs_get_inode_dev(struct super_block *sb
 void
 ufs_set_inode_dev(struct super_block *sb, struct ufs_inode_info *ufsi, dev_t dev)
 {
-	__fs32 fs32;
+	__u32 fs32;
 
 	switch (UFS_SB(sb)->s_flags & UFS_ST_MASK) {
 	case UFS_ST_SUNx86:
@@ -227,11 +226,10 @@ ufs_set_inode_dev(struct super_block *sb
 		fs32 = old_encode_dev(dev);
 		break;
 	}
-	fs32 = cpu_to_fs32(sb, fs32);
 	if ((UFS_SB(sb)->s_flags & UFS_ST_MASK) == UFS_ST_SUNx86)
-		ufsi->i_u1.i_data[1] = fs32;
+		ufsi->i_u1.i_data[1] = cpu_to_fs32(sb, fs32);
 	else
-		ufsi->i_u1.i_data[0] = fs32;
+		ufsi->i_u1.i_data[0] = cpu_to_fs32(sb, fs32);
 }
 
 /**
diff --git a/include/linux/ufs_fs.h b/include/linux/ufs_fs.h
index fc62887..61eef50 100644
--- a/include/linux/ufs_fs.h
+++ b/include/linux/ufs_fs.h
@@ -351,6 +351,14 @@ struct ufs2_csum_total {
 	__fs64   cs_spare[3];	/* future expansion */
 };
 
+struct ufs_csum_core {
+	__u64	cs_ndir;	/* number of directories */
+	__u64	cs_nbfree;	/* number of free blocks */
+	__u64	cs_nifree;	/* number of free inodes */
+	__u64	cs_nffree;	/* number of free frags */
+	__u64   cs_numclusters;	/* number of free clusters */
+};
+
 /*
  * File system flags
  */
@@ -715,7 +723,7 @@ struct ufs_cg_private_info {
 
 struct ufs_sb_private_info {
 	struct ufs_buffer_head s_ubh; /* buffer containing super block */
-	struct ufs2_csum_total cs_total;
+	struct ufs_csum_core cs_total;
 	__u32	s_sblkno;	/* offset of super-blocks in filesys */
 	__u32	s_cblkno;	/* offset of cg-block in filesys */
 	__u32	s_iblkno;	/* offset of inode-blocks in filesys */
-- 
1.4.2.GIT


