Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936300AbWK3MQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936300AbWK3MQG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936302AbWK3MQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:16:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2441 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936301AbWK3MQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:16:01 -0500
Subject: [GFS2] Shrink gfs2_inode (2) - di_major/di_minor [22/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:16:03 +0000
Message-Id: <1164888963.3752.348.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From e7f14f4d094ea1a9ce1953375f5bc1500c760c79 Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Tue, 31 Oct 2006 21:45:08 -0500
Subject: [PATCH] [GFS2] Shrink gfs2_inode (2) - di_major/di_minor

This removes the device numbers from this structure by using
inode->i_rdev instead. It also cleans up the code in gfs2_mknod.
It results in shrinking the gfs2_inode by 8 bytes.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/inode.c             |   36 ++++++++++++++++--------------------
 fs/gfs2/inode.h             |    2 +-
 fs/gfs2/ondisk.c            |    4 ----
 fs/gfs2/ops_inode.c         |   38 +++++---------------------------------
 include/linux/gfs2_ondisk.h |    2 --
 5 files changed, 22 insertions(+), 60 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 7ba05fc..a995919 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -51,17 +51,6 @@ void gfs2_inode_attr_in(struct gfs2_inod
 	struct gfs2_dinode_host *di = &ip->i_di;
 
 	inode->i_ino = ip->i_num.no_addr;
-
-	switch (di->di_mode & S_IFMT) {
-	case S_IFBLK:
-	case S_IFCHR:
-		inode->i_rdev = MKDEV(di->di_major, di->di_minor);
-		break;
-	default:
-		inode->i_rdev = 0;
-		break;
-	};
-
 	inode->i_mode = di->di_mode;
 	inode->i_nlink = di->di_nlink;
 	inode->i_uid = di->di_uid;
@@ -222,6 +211,15 @@ static int gfs2_dinode_in(struct gfs2_in
 		return -ESTALE;
 
 	di->di_mode = be32_to_cpu(str->di_mode);
+	ip->i_inode.i_rdev = 0;
+	switch (di->di_mode & S_IFMT) {
+	case S_IFBLK:
+	case S_IFCHR:
+		ip->i_inode.i_rdev = MKDEV(be32_to_cpu(str->di_major),
+					   be32_to_cpu(str->di_minor));
+		break;
+	};
+
 	di->di_uid = be32_to_cpu(str->di_uid);
 	di->di_gid = be32_to_cpu(str->di_gid);
 	di->di_nlink = be32_to_cpu(str->di_nlink);
@@ -230,8 +228,6 @@ static int gfs2_dinode_in(struct gfs2_in
 	di->di_atime = be64_to_cpu(str->di_atime);
 	di->di_mtime = be64_to_cpu(str->di_mtime);
 	di->di_ctime = be64_to_cpu(str->di_ctime);
-	di->di_major = be32_to_cpu(str->di_major);
-	di->di_minor = be32_to_cpu(str->di_minor);
 
 	di->di_goal_meta = be64_to_cpu(str->di_goal_meta);
 	di->di_goal_data = be64_to_cpu(str->di_goal_data);
@@ -270,7 +266,6 @@ int gfs2_inode_refresh(struct gfs2_inode
 	}
 
 	error = gfs2_dinode_in(ip, dibh->b_data);
-
 	brelse(dibh);
 	ip->i_vn = ip->i_gl->gl_vn;
 
@@ -684,7 +679,7 @@ out:
 static void init_dinode(struct gfs2_inode *dip, struct gfs2_glock *gl,
 			const struct gfs2_inum_host *inum, unsigned int mode,
 			unsigned int uid, unsigned int gid,
-			const u64 *generation)
+			const u64 *generation, dev_t dev)
 {
 	struct gfs2_sbd *sdp = GFS2_SB(&dip->i_inode);
 	struct gfs2_dinode *di;
@@ -705,7 +700,8 @@ static void init_dinode(struct gfs2_inod
 	di->di_size = cpu_to_be64(0);
 	di->di_blocks = cpu_to_be64(1);
 	di->di_atime = di->di_mtime = di->di_ctime = cpu_to_be64(get_seconds());
-	di->di_major = di->di_minor = cpu_to_be32(0);
+	di->di_major = cpu_to_be32(MAJOR(dev));
+	di->di_minor = cpu_to_be32(MINOR(dev));
 	di->di_goal_meta = di->di_goal_data = cpu_to_be64(inum->no_addr);
 	di->di_generation = cpu_to_be64(*generation);
 	di->di_flags = cpu_to_be32(0);
@@ -740,7 +736,7 @@ static void init_dinode(struct gfs2_inod
 
 static int make_dinode(struct gfs2_inode *dip, struct gfs2_glock *gl,
 		       unsigned int mode, const struct gfs2_inum_host *inum,
-		       const u64 *generation)
+		       const u64 *generation, dev_t dev)
 {
 	struct gfs2_sbd *sdp = GFS2_SB(&dip->i_inode);
 	unsigned int uid, gid;
@@ -761,7 +757,7 @@ static int make_dinode(struct gfs2_inode
 	if (error)
 		goto out_quota;
 
-	init_dinode(dip, gl, inum, mode, uid, gid, generation);
+	init_dinode(dip, gl, inum, mode, uid, gid, generation, dev);
 	gfs2_quota_change(dip, +1, uid, gid);
 	gfs2_trans_end(sdp);
 
@@ -892,7 +888,7 @@ static int gfs2_security_init(struct gfs
  */
 
 struct inode *gfs2_createi(struct gfs2_holder *ghs, const struct qstr *name,
-			   unsigned int mode)
+			   unsigned int mode, dev_t dev)
 {
 	struct inode *inode;
 	struct gfs2_inode *dip = ghs->gh_gl->gl_object;
@@ -950,7 +946,7 @@ struct inode *gfs2_createi(struct gfs2_h
 			goto fail_gunlock;
 	}
 
-	error = make_dinode(dip, ghs[1].gh_gl, mode, &inum, &generation);
+	error = make_dinode(dip, ghs[1].gh_gl, mode, &inum, &generation, dev);
 	if (error)
 		goto fail_gunlock2;
 
diff --git a/fs/gfs2/inode.h b/fs/gfs2/inode.h
index d699b92..33c9ea6 100644
--- a/fs/gfs2/inode.h
+++ b/fs/gfs2/inode.h
@@ -37,7 +37,7 @@ int gfs2_change_nlink(struct gfs2_inode 
 struct inode *gfs2_lookupi(struct inode *dir, const struct qstr *name,
 			   int is_root, struct nameidata *nd);
 struct inode *gfs2_createi(struct gfs2_holder *ghs, const struct qstr *name,
-			   unsigned int mode);
+			   unsigned int mode, dev_t dev);
 int gfs2_rmdiri(struct gfs2_inode *dip, const struct qstr *name,
 		struct gfs2_inode *ip);
 int gfs2_unlink_ok(struct gfs2_inode *dip, const struct qstr *name,
diff --git a/fs/gfs2/ondisk.c b/fs/gfs2/ondisk.c
index 4bc590e..60dd943 100644
--- a/fs/gfs2/ondisk.c
+++ b/fs/gfs2/ondisk.c
@@ -170,8 +170,6 @@ void gfs2_dinode_out(const struct gfs2_i
 	str->di_atime = cpu_to_be64(di->di_atime);
 	str->di_mtime = cpu_to_be64(di->di_mtime);
 	str->di_ctime = cpu_to_be64(di->di_ctime);
-	str->di_major = cpu_to_be32(di->di_major);
-	str->di_minor = cpu_to_be32(di->di_minor);
 
 	str->di_goal_meta = cpu_to_be64(di->di_goal_meta);
 	str->di_goal_data = cpu_to_be64(di->di_goal_data);
@@ -202,8 +200,6 @@ void gfs2_dinode_print(const struct gfs2
 	printk(KERN_INFO "  di_atime = %lld\n", (long long)di->di_atime);
 	printk(KERN_INFO "  di_mtime = %lld\n", (long long)di->di_mtime);
 	printk(KERN_INFO "  di_ctime = %lld\n", (long long)di->di_ctime);
-	pv(di, di_major, "%u");
-	pv(di, di_minor, "%u");
 
 	printk(KERN_INFO "  di_goal_meta = %llu\n", (unsigned long long)di->di_goal_meta);
 	printk(KERN_INFO "  di_goal_data = %llu\n", (unsigned long long)di->di_goal_data);
diff --git a/fs/gfs2/ops_inode.c b/fs/gfs2/ops_inode.c
index b2c2fe6..c10b914 100644
--- a/fs/gfs2/ops_inode.c
+++ b/fs/gfs2/ops_inode.c
@@ -59,7 +59,7 @@ static int gfs2_create(struct inode *dir
 	gfs2_holder_init(dip->i_gl, 0, 0, ghs);
 
 	for (;;) {
-		inode = gfs2_createi(ghs, &dentry->d_name, S_IFREG | mode);
+		inode = gfs2_createi(ghs, &dentry->d_name, S_IFREG | mode, 0);
 		if (!IS_ERR(inode)) {
 			gfs2_trans_end(sdp);
 			if (dip->i_alloc.al_rgd)
@@ -326,7 +326,7 @@ static int gfs2_symlink(struct inode *di
 
 	gfs2_holder_init(dip->i_gl, 0, 0, ghs);
 
-	inode = gfs2_createi(ghs, &dentry->d_name, S_IFLNK | S_IRWXUGO);
+	inode = gfs2_createi(ghs, &dentry->d_name, S_IFLNK | S_IRWXUGO, 0);
 	if (IS_ERR(inode)) {
 		gfs2_holder_uninit(ghs);
 		return PTR_ERR(inode);
@@ -379,7 +379,7 @@ static int gfs2_mkdir(struct inode *dir,
 
 	gfs2_holder_init(dip->i_gl, 0, 0, ghs);
 
-	inode = gfs2_createi(ghs, &dentry->d_name, S_IFDIR | mode);
+	inode = gfs2_createi(ghs, &dentry->d_name, S_IFDIR | mode, 0);
 	if (IS_ERR(inode)) {
 		gfs2_holder_uninit(ghs);
 		return PTR_ERR(inode);
@@ -504,47 +504,19 @@ out:
 static int gfs2_mknod(struct inode *dir, struct dentry *dentry, int mode,
 		      dev_t dev)
 {
-	struct gfs2_inode *dip = GFS2_I(dir), *ip;
+	struct gfs2_inode *dip = GFS2_I(dir);
 	struct gfs2_sbd *sdp = GFS2_SB(dir);
 	struct gfs2_holder ghs[2];
 	struct inode *inode;
-	struct buffer_head *dibh;
-	u32 major = 0, minor = 0;
-	int error;
-
-	switch (mode & S_IFMT) {
-	case S_IFBLK:
-	case S_IFCHR:
-		major = MAJOR(dev);
-		minor = MINOR(dev);
-		break;
-	case S_IFIFO:
-	case S_IFSOCK:
-		break;
-	default:
-		return -EOPNOTSUPP;
-	};
 
 	gfs2_holder_init(dip->i_gl, 0, 0, ghs);
 
-	inode = gfs2_createi(ghs, &dentry->d_name, mode);
+	inode = gfs2_createi(ghs, &dentry->d_name, mode, dev);
 	if (IS_ERR(inode)) {
 		gfs2_holder_uninit(ghs);
 		return PTR_ERR(inode);
 	}
 
-	ip = ghs[1].gh_gl->gl_object;
-
-	ip->i_di.di_major = major;
-	ip->i_di.di_minor = minor;
-
-	error = gfs2_meta_inode_buffer(ip, &dibh);
-
-	if (!gfs2_assert_withdraw(sdp, !error)) {
-		gfs2_dinode_out(ip, dibh->b_data);
-		brelse(dibh);
-	}
-
 	gfs2_trans_end(sdp);
 	if (dip->i_alloc.al_rgd)
 		gfs2_inplace_release(dip);
diff --git a/include/linux/gfs2_ondisk.h b/include/linux/gfs2_ondisk.h
index c0e76fc..5bcf895 100644
--- a/include/linux/gfs2_ondisk.h
+++ b/include/linux/gfs2_ondisk.h
@@ -331,8 +331,6 @@ struct gfs2_dinode_host {
 	__u64 di_atime;	/* time last accessed */
 	__u64 di_mtime;	/* time last modified */
 	__u64 di_ctime;	/* time last changed */
-	__u32 di_major;	/* device major number */
-	__u32 di_minor;	/* device minor number */
 
 	/* This section varies from gfs1. Padding added to align with
          * remainder of dinode
-- 
1.4.1



