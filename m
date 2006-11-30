Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936258AbWK3MLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936258AbWK3MLp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936260AbWK3MLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:11:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22917 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936258AbWK3MLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:11:44 -0500
Subject: [GFS2] split gfs2_dinode into on-disk and host variants [1/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:12:23 +0000
Message-Id: <1164888743.3752.303.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 3ca68df6ee61e1a2034f3307b9edb9b3d87e5ca1 Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Fri, 13 Oct 2006 20:11:25 -0400
Subject: [PATCH] [GFS2] split gfs2_dinode into on-disk and host variants

The latter is used as part of gfs2-private part of struct inode.
It actually stores a lot of fields differently; for now the
declaration is just cloned, inode field is swtiched and changes
propagated.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/inode.c             |    4 ++--
 fs/gfs2/ondisk.c            |    6 +++--
 include/linux/gfs2_ondisk.h |   48 ++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index d470e52..191a3df 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -48,7 +48,7 @@ #include "util.h"
 void gfs2_inode_attr_in(struct gfs2_inode *ip)
 {
 	struct inode *inode = &ip->i_inode;
-	struct gfs2_dinode *di = &ip->i_di;
+	struct gfs2_dinode_host *di = &ip->i_di;
 
 	inode->i_ino = ip->i_num.no_addr;
 
@@ -98,7 +98,7 @@ void gfs2_inode_attr_in(struct gfs2_inod
 void gfs2_inode_attr_out(struct gfs2_inode *ip)
 {
 	struct inode *inode = &ip->i_inode;
-	struct gfs2_dinode *di = &ip->i_di;
+	struct gfs2_dinode_host *di = &ip->i_di;
 	gfs2_assert_withdraw(GFS2_SB(inode),
 		(di->di_mode & S_IFMT) == (inode->i_mode & S_IFMT));
 	di->di_mode = inode->i_mode;
diff --git a/fs/gfs2/ondisk.c b/fs/gfs2/ondisk.c
index 1025960..52cb9a2 100644
--- a/fs/gfs2/ondisk.c
+++ b/fs/gfs2/ondisk.c
@@ -153,7 +153,7 @@ void gfs2_quota_in(struct gfs2_quota *qu
 	qu->qu_value = be64_to_cpu(str->qu_value);
 }
 
-void gfs2_dinode_in(struct gfs2_dinode *di, const void *buf)
+void gfs2_dinode_in(struct gfs2_dinode_host *di, const void *buf)
 {
 	const struct gfs2_dinode *str = buf;
 
@@ -187,7 +187,7 @@ void gfs2_dinode_in(struct gfs2_dinode *
 
 }
 
-void gfs2_dinode_out(const struct gfs2_dinode *di, void *buf)
+void gfs2_dinode_out(const struct gfs2_dinode_host *di, void *buf)
 {
 	struct gfs2_dinode *str = buf;
 
@@ -221,7 +221,7 @@ void gfs2_dinode_out(const struct gfs2_d
 
 }
 
-void gfs2_dinode_print(const struct gfs2_dinode *di)
+void gfs2_dinode_print(const struct gfs2_dinode_host *di)
 {
 	gfs2_meta_header_print(&di->di_header);
 	gfs2_inum_print(&di->di_num);
diff --git a/include/linux/gfs2_ondisk.h b/include/linux/gfs2_ondisk.h
index a7ae7c1..f334b4b 100644
--- a/include/linux/gfs2_ondisk.h
+++ b/include/linux/gfs2_ondisk.h
@@ -270,6 +270,48 @@ struct gfs2_dinode {
 	__u8 di_reserved[56];
 };
 
+struct gfs2_dinode_host {
+	struct gfs2_meta_header di_header;
+
+	struct gfs2_inum di_num;
+
+	__be32 di_mode;	/* mode of file */
+	__be32 di_uid;	/* owner's user id */
+	__be32 di_gid;	/* owner's group id */
+	__be32 di_nlink;	/* number of links to this file */
+	__be64 di_size;	/* number of bytes in file */
+	__be64 di_blocks;	/* number of blocks in file */
+	__be64 di_atime;	/* time last accessed */
+	__be64 di_mtime;	/* time last modified */
+	__be64 di_ctime;	/* time last changed */
+	__be32 di_major;	/* device major number */
+	__be32 di_minor;	/* device minor number */
+
+	/* This section varies from gfs1. Padding added to align with
+         * remainder of dinode
+	 */
+	__be64 di_goal_meta;	/* rgrp to alloc from next */
+	__be64 di_goal_data;	/* data block goal */
+	__be64 di_generation;	/* generation number for NFS */
+
+	__be32 di_flags;	/* GFS2_DIF_... */
+	__be32 di_payload_format;  /* GFS2_FORMAT_... */
+	__u16 __pad1;	/* Was ditype in gfs1 */
+	__be16 di_height;	/* height of metadata */
+	__u32 __pad2;	/* Unused incarnation number from gfs1 */
+
+	/* These only apply to directories  */
+	__u16 __pad3;	/* Padding */
+	__be16 di_depth;	/* Number of bits in the table */
+	__be32 di_entries;	/* The number of entries in the directory */
+
+	struct gfs2_inum __pad4; /* Unused even in current gfs1 */
+
+	__be64 di_eattr;	/* extended attribute block number */
+
+	__u8 di_reserved[56];
+};
+
 /*
  * directory structure - many of these per directory file
  */
@@ -422,8 +464,8 @@ extern void gfs2_rgrp_in(struct gfs2_rgr
 extern void gfs2_rgrp_out(const struct gfs2_rgrp *rg, void *buf);
 extern void gfs2_quota_in(struct gfs2_quota *qu, const void *buf);
 extern void gfs2_quota_out(const struct gfs2_quota *qu, void *buf);
-extern void gfs2_dinode_in(struct gfs2_dinode *di, const void *buf);
-extern void gfs2_dinode_out(const struct gfs2_dinode *di, void *buf);
+extern void gfs2_dinode_in(struct gfs2_dinode_host *di, const void *buf);
+extern void gfs2_dinode_out(const struct gfs2_dinode_host *di, void *buf);
 extern void gfs2_ea_header_in(struct gfs2_ea_header *ea, const void *buf);
 extern void gfs2_ea_header_out(const struct gfs2_ea_header *ea, void *buf);
 extern void gfs2_log_header_in(struct gfs2_log_header *lh, const void *buf);
@@ -436,7 +478,7 @@ extern void gfs2_quota_change_in(struct 
 /* Printing functions */
 
 extern void gfs2_rindex_print(const struct gfs2_rindex *ri);
-extern void gfs2_dinode_print(const struct gfs2_dinode *di);
+extern void gfs2_dinode_print(const struct gfs2_dinode_host *di);
 
 #endif /* __KERNEL__ */
 
-- 
1.4.1



