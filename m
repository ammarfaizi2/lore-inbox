Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936271AbWK3MQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936271AbWK3MQI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936306AbWK3MQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:16:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57992 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936271AbWK3MPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:15:51 -0500
Subject: [GFS2] Shrink gfs2_inode (1) - di_header/di_num [21/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:15:58 +0000
Message-Id: <1164888958.3752.346.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From af339c0241d0dd3b35f9097b4f4999bb22ffe502 Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Wed, 1 Nov 2006 10:34:15 -0500
Subject: [PATCH] [GFS2] Shrink gfs2_inode (1) - di_header/di_num

The metadata header doesn't need to be stored in the incore
struct gfs2_inode since its constant, and this patch removes it.
Also, there is already a field for the inode's number in the
struct gfs2_inode, so we don't need one in struct gfs2_dinode_host
as well.

This saves 28 bytes of space in the struct gfs2_inode.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/inode.c             |   25 +++++++++++--------------
 fs/gfs2/ondisk.c            |   22 +++++++++-------------
 include/linux/gfs2_ondisk.h |    5 -----
 3 files changed, 20 insertions(+), 32 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 4c5d286..7ba05fc 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -208,13 +208,18 @@ fail:
 	return ERR_PTR(error);
 }
 
-static void gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
+static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 {
 	struct gfs2_dinode_host *di = &ip->i_di;
 	const struct gfs2_dinode *str = buf;
 
-	gfs2_meta_header_in(&di->di_header, buf);
-	gfs2_inum_in(&di->di_num, &str->di_num);
+	if (ip->i_num.no_addr != be64_to_cpu(str->di_num.no_addr)) {
+		if (gfs2_consist_inode(ip))
+			gfs2_dinode_print(ip);
+		return -EIO;
+	}
+	if (ip->i_num.no_formal_ino != be64_to_cpu(str->di_num.no_formal_ino))
+		return -ESTALE;
 
 	di->di_mode = be32_to_cpu(str->di_mode);
 	di->di_uid = be32_to_cpu(str->di_uid);
@@ -240,6 +245,7 @@ static void gfs2_dinode_in(struct gfs2_i
 	di->di_entries = be32_to_cpu(str->di_entries);
 
 	di->di_eattr = be64_to_cpu(str->di_eattr);
+	return 0;
 }
 
 /**
@@ -263,21 +269,12 @@ int gfs2_inode_refresh(struct gfs2_inode
 		return -EIO;
 	}
 
-	gfs2_dinode_in(ip, dibh->b_data);
+	error = gfs2_dinode_in(ip, dibh->b_data);
 
 	brelse(dibh);
-
-	if (ip->i_num.no_addr != ip->i_di.di_num.no_addr) {
-		if (gfs2_consist_inode(ip))
-			gfs2_dinode_print(ip);
-		return -EIO;
-	}
-	if (ip->i_num.no_formal_ino != ip->i_di.di_num.no_formal_ino)
-		return -ESTALE;
-
 	ip->i_vn = ip->i_gl->gl_vn;
 
-	return 0;
+	return error;
 }
 
 int gfs2_dinode_dealloc(struct gfs2_inode *ip)
diff --git a/fs/gfs2/ondisk.c b/fs/gfs2/ondisk.c
index 77bed44..4bc590e 100644
--- a/fs/gfs2/ondisk.c
+++ b/fs/gfs2/ondisk.c
@@ -56,7 +56,7 @@ static void gfs2_inum_print(const struct
 	printk(KERN_INFO "  no_addr = %llu\n", (unsigned long long)no->no_addr);
 }
 
-void gfs2_meta_header_in(struct gfs2_meta_header_host *mh, const void *buf)
+static void gfs2_meta_header_in(struct gfs2_meta_header_host *mh, const void *buf)
 {
 	const struct gfs2_meta_header *str = buf;
 
@@ -74,13 +74,6 @@ static void gfs2_meta_header_out(const s
 	str->mh_format = cpu_to_be32(mh->mh_format);
 }
 
-static void gfs2_meta_header_print(const struct gfs2_meta_header_host *mh)
-{
-	pv(mh, mh_magic, "0x%.8X");
-	pv(mh, mh_type, "%u");
-	pv(mh, mh_format, "%u");
-}
-
 void gfs2_sb_in(struct gfs2_sb_host *sb, const void *buf)
 {
 	const struct gfs2_sb *str = buf;
@@ -160,8 +153,13 @@ void gfs2_dinode_out(const struct gfs2_i
 	const struct gfs2_dinode_host *di = &ip->i_di;
 	struct gfs2_dinode *str = buf;
 
-	gfs2_meta_header_out(&di->di_header, buf);
-	gfs2_inum_out(&di->di_num, (char *)&str->di_num);
+	str->di_header.mh_magic = cpu_to_be32(GFS2_MAGIC);
+	str->di_header.mh_type = cpu_to_be32(GFS2_METATYPE_DI);
+	str->di_header.__pad0 = 0;
+	str->di_header.mh_format = cpu_to_be32(GFS2_FORMAT_DI);
+	str->di_header.__pad1 = 0;
+
+	gfs2_inum_out(&ip->i_num, &str->di_num);
 
 	str->di_mode = cpu_to_be32(di->di_mode);
 	str->di_uid = cpu_to_be32(di->di_uid);
@@ -187,15 +185,13 @@ void gfs2_dinode_out(const struct gfs2_i
 	str->di_entries = cpu_to_be32(di->di_entries);
 
 	str->di_eattr = cpu_to_be64(di->di_eattr);
-
 }
 
 void gfs2_dinode_print(const struct gfs2_inode *ip)
 {
 	const struct gfs2_dinode_host *di = &ip->i_di;
 
-	gfs2_meta_header_print(&di->di_header);
-	gfs2_inum_print(&di->di_num);
+	gfs2_inum_print(&ip->i_num);
 
 	pv(di, di_mode, "0%o");
 	pv(di, di_uid, "%u");
diff --git a/include/linux/gfs2_ondisk.h b/include/linux/gfs2_ondisk.h
index cf4c655..c0e76fc 100644
--- a/include/linux/gfs2_ondisk.h
+++ b/include/linux/gfs2_ondisk.h
@@ -322,10 +322,6 @@ struct gfs2_dinode {
 };
 
 struct gfs2_dinode_host {
-	struct gfs2_meta_header_host di_header;
-
-	struct gfs2_inum_host di_num;
-
 	__u32 di_mode;	/* mode of file */
 	__u32 di_uid;	/* owner's user id */
 	__u32 di_gid;	/* owner's group id */
@@ -528,7 +524,6 @@ #ifdef __KERNEL__
 
 extern void gfs2_inum_in(struct gfs2_inum_host *no, const void *buf);
 extern void gfs2_inum_out(const struct gfs2_inum_host *no, void *buf);
-extern void gfs2_meta_header_in(struct gfs2_meta_header_host *mh, const void *buf);
 extern void gfs2_sb_in(struct gfs2_sb_host *sb, const void *buf);
 extern void gfs2_rindex_in(struct gfs2_rindex_host *ri, const void *buf);
 extern void gfs2_rindex_out(const struct gfs2_rindex_host *ri, void *buf);
-- 
1.4.1



