Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936286AbWK3MRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936286AbWK3MRf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936311AbWK3MRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:17:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27273 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936302AbWK3MQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:16:28 -0500
Subject: [GFS2] Shrink gfs2_inode (5) - di_nlink [25/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:16:18 +0000
Message-Id: <1164888978.3752.354.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 4f56110a00af5fb2e22fbccfcaf944d62cae8fcf Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Wed, 1 Nov 2006 14:04:17 -0500
Subject: [PATCH] [GFS2] Shrink gfs2_inode (5) - di_nlink

Remove the di_nlink field in favour of inode->i_nlink and
update the nlink handling to use the proper macros. This
saves 4 bytes.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/inode.c             |   37 ++++++++++++++++++++++++-------------
 fs/gfs2/ondisk.c            |    3 +--
 fs/gfs2/ops_inode.c         |   12 ++++++------
 include/linux/gfs2_ondisk.h |    1 -
 4 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 0de9b22..7112039 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -51,7 +51,6 @@ void gfs2_inode_attr_in(struct gfs2_inod
 	struct gfs2_dinode_host *di = &ip->i_di;
 
 	inode->i_ino = ip->i_num.no_addr;
-	inode->i_nlink = di->di_nlink;
 	i_size_write(inode, di->di_size);
 	inode->i_atime.tv_sec = di->di_atime;
 	inode->i_mtime.tv_sec = di->di_mtime;
@@ -214,7 +213,12 @@ static int gfs2_dinode_in(struct gfs2_in
 
 	ip->i_inode.i_uid = be32_to_cpu(str->di_uid);
 	ip->i_inode.i_gid = be32_to_cpu(str->di_gid);
-	di->di_nlink = be32_to_cpu(str->di_nlink);
+	/*
+	 * We will need to review setting the nlink count here in the
+	 * light of the forthcoming ro bind mount work. This is a reminder
+	 * to do that.
+	 */
+	ip->i_inode.i_nlink = be32_to_cpu(str->di_nlink);
 	di->di_size = be64_to_cpu(str->di_size);
 	di->di_blocks = be64_to_cpu(str->di_blocks);
 	di->di_atime = be64_to_cpu(str->di_atime);
@@ -336,12 +340,12 @@ int gfs2_change_nlink(struct gfs2_inode 
 	u32 nlink;
 	int error;
 
-	BUG_ON(ip->i_di.di_nlink != ip->i_inode.i_nlink);
-	nlink = ip->i_di.di_nlink + diff;
+	BUG_ON(diff != 1 && diff != -1);
+	nlink = ip->i_inode.i_nlink + diff;
 
 	/* If we are reducing the nlink count, but the new value ends up being
 	   bigger than the old one, we must have underflowed. */
-	if (diff < 0 && nlink > ip->i_di.di_nlink) {
+	if (diff < 0 && nlink > ip->i_inode.i_nlink) {
 		if (gfs2_consist_inode(ip))
 			gfs2_dinode_print(ip);
 		return -EIO;
@@ -351,16 +355,19 @@ int gfs2_change_nlink(struct gfs2_inode 
 	if (error)
 		return error;
 
-	ip->i_di.di_nlink = nlink;
+	if (diff > 0)
+		inc_nlink(&ip->i_inode);
+	else
+		drop_nlink(&ip->i_inode);
+
 	ip->i_di.di_ctime = get_seconds();
-	ip->i_inode.i_nlink = nlink;
 
 	gfs2_trans_add_bh(ip->i_gl, dibh, 1);
 	gfs2_dinode_out(ip, dibh->b_data);
 	brelse(dibh);
 	mark_inode_dirty(&ip->i_inode);
 
-	if (ip->i_di.di_nlink == 0) {
+	if (ip->i_inode.i_nlink == 0) {
 		struct gfs2_rgrpd *rgd;
 		struct gfs2_holder ri_gh, rg_gh;
 
@@ -375,7 +382,6 @@ int gfs2_change_nlink(struct gfs2_inode 
 		if (error)
 			goto out_norgrp;
 
-		clear_nlink(&ip->i_inode);
 		gfs2_unlink_di(&ip->i_inode); /* mark inode unlinked */
 		gfs2_glock_dq_uninit(&rg_gh);
 out_norgrp:
@@ -586,7 +592,7 @@ static int create_ok(struct gfs2_inode *
 		return error;
 
 	/*  Don't create entries in an unlinked directory  */
-	if (!dip->i_di.di_nlink)
+	if (!dip->i_inode.i_nlink)
 		return -EPERM;
 
 	error = gfs2_dir_search(&dip->i_inode, name, NULL, NULL);
@@ -602,7 +608,7 @@ static int create_ok(struct gfs2_inode *
 
 	if (dip->i_di.di_entries == (u32)-1)
 		return -EFBIG;
-	if (S_ISDIR(mode) && dip->i_di.di_nlink == (u32)-1)
+	if (S_ISDIR(mode) && dip->i_inode.i_nlink == (u32)-1)
 		return -EMLINK;
 
 	return 0;
@@ -808,7 +814,7 @@ static int link_dinode(struct gfs2_inode
 	error = gfs2_meta_inode_buffer(ip, &dibh);
 	if (error)
 		goto fail_end_trans;
-	ip->i_di.di_nlink = 1;
+	ip->i_inode.i_nlink = 1;
 	gfs2_trans_add_bh(ip->i_gl, dibh, 1);
 	gfs2_dinode_out(ip, dibh->b_data);
 	brelse(dibh);
@@ -1016,7 +1022,12 @@ int gfs2_rmdiri(struct gfs2_inode *dip, 
 	if (error)
 		return error;
 
-	error = gfs2_change_nlink(ip, -2);
+	/* It looks odd, but it really should be done twice */
+	error = gfs2_change_nlink(ip, -1);
+	if (error)
+		return error;
+
+	error = gfs2_change_nlink(ip, -1);
 	if (error)
 		return error;
 
diff --git a/fs/gfs2/ondisk.c b/fs/gfs2/ondisk.c
index e224f6a..b4e354b 100644
--- a/fs/gfs2/ondisk.c
+++ b/fs/gfs2/ondisk.c
@@ -164,7 +164,7 @@ void gfs2_dinode_out(const struct gfs2_i
 	str->di_mode = cpu_to_be32(ip->i_inode.i_mode);
 	str->di_uid = cpu_to_be32(ip->i_inode.i_uid);
 	str->di_gid = cpu_to_be32(ip->i_inode.i_gid);
-	str->di_nlink = cpu_to_be32(di->di_nlink);
+	str->di_nlink = cpu_to_be32(ip->i_inode.i_nlink);
 	str->di_size = cpu_to_be64(di->di_size);
 	str->di_blocks = cpu_to_be64(di->di_blocks);
 	str->di_atime = cpu_to_be64(di->di_atime);
@@ -191,7 +191,6 @@ void gfs2_dinode_print(const struct gfs2
 
 	gfs2_inum_print(&ip->i_num);
 
-	pv(di, di_nlink, "%u");
 	printk(KERN_INFO "  di_size = %llu\n", (unsigned long long)di->di_size);
 	printk(KERN_INFO "  di_blocks = %llu\n", (unsigned long long)di->di_blocks);
 	printk(KERN_INFO "  di_atime = %lld\n", (long long)di->di_atime);
diff --git a/fs/gfs2/ops_inode.c b/fs/gfs2/ops_inode.c
index efbcec3..06176de 100644
--- a/fs/gfs2/ops_inode.c
+++ b/fs/gfs2/ops_inode.c
@@ -169,7 +169,7 @@ static int gfs2_link(struct dentry *old_
 	}
 
 	error = -EINVAL;
-	if (!dip->i_di.di_nlink)
+	if (!dip->i_inode.i_nlink)
 		goto out_gunlock;
 	error = -EFBIG;
 	if (dip->i_di.di_entries == (u32)-1)
@@ -178,10 +178,10 @@ static int gfs2_link(struct dentry *old_
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
 		goto out_gunlock;
 	error = -EINVAL;
-	if (!ip->i_di.di_nlink)
+	if (!ip->i_inode.i_nlink)
 		goto out_gunlock;
 	error = -EMLINK;
-	if (ip->i_di.di_nlink == (u32)-1)
+	if (ip->i_inode.i_nlink == (u32)-1)
 		goto out_gunlock;
 
 	alloc_required = error = gfs2_diradd_alloc_required(dir, &dentry->d_name);
@@ -386,7 +386,7 @@ static int gfs2_mkdir(struct inode *dir,
 
 	ip = ghs[1].gh_gl->gl_object;
 
-	ip->i_di.di_nlink = 2;
+	ip->i_inode.i_nlink = 2;
 	ip->i_di.di_size = sdp->sd_sb.sb_bsize - sizeof(struct gfs2_dinode);
 	ip->i_di.di_flags |= GFS2_DIF_JDATA;
 	ip->i_di.di_payload_format = GFS2_FORMAT_DE;
@@ -636,7 +636,7 @@ static int gfs2_rename(struct inode *odi
 		};
 
 		if (odip != ndip) {
-			if (!ndip->i_di.di_nlink) {
+			if (!ndip->i_inode.i_nlink) {
 				error = -EINVAL;
 				goto out_gunlock;
 			}
@@ -645,7 +645,7 @@ static int gfs2_rename(struct inode *odi
 				goto out_gunlock;
 			}
 			if (S_ISDIR(ip->i_inode.i_mode) &&
-			    ndip->i_di.di_nlink == (u32)-1) {
+			    ndip->i_inode.i_nlink == (u32)-1) {
 				error = -EMLINK;
 				goto out_gunlock;
 			}
diff --git a/include/linux/gfs2_ondisk.h b/include/linux/gfs2_ondisk.h
index 896c7f8..c61517b 100644
--- a/include/linux/gfs2_ondisk.h
+++ b/include/linux/gfs2_ondisk.h
@@ -322,7 +322,6 @@ struct gfs2_dinode {
 };
 
 struct gfs2_dinode_host {
-	__u32 di_nlink;	/* number of links to this file */
 	__u64 di_size;	/* number of bytes in file */
 	__u64 di_blocks;	/* number of blocks in file */
 	__u64 di_atime;	/* time last accessed */
-- 
1.4.1



