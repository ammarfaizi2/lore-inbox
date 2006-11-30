Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936315AbWK3MQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936315AbWK3MQx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936277AbWK3MQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:16:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10377 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936301AbWK3MQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:16:06 -0500
Subject: [GFS2] Shrink gfs2_inode (3) - di_mode [23/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:16:09 +0000
Message-Id: <1164888969.3752.350.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From b60623c238b6a819bd04090139704e2cb57a751f Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Wed, 1 Nov 2006 12:22:46 -0500
Subject: [PATCH] [GFS2] Shrink gfs2_inode (3) - di_mode

This removes the duplicate di_mode field in favour of using the
inode->i_mode field. This saves 4 bytes.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/acl.c               |   16 ++++++++--------
 fs/gfs2/bmap.c              |    2 +-
 fs/gfs2/eaops.c             |    2 +-
 fs/gfs2/eattr.c             |    8 ++++----
 fs/gfs2/glock.c             |    2 +-
 fs/gfs2/glops.c             |    8 ++++----
 fs/gfs2/inode.c             |   18 +++++++-----------
 fs/gfs2/inode.h             |    2 +-
 fs/gfs2/ondisk.c            |    3 +--
 fs/gfs2/ops_address.c       |    1 -
 fs/gfs2/ops_dentry.c        |    2 +-
 fs/gfs2/ops_file.c          |    6 +++---
 fs/gfs2/ops_inode.c         |   17 ++++++++---------
 fs/gfs2/ops_super.c         |    2 +-
 include/linux/gfs2_ondisk.h |    1 -
 15 files changed, 41 insertions(+), 49 deletions(-)

diff --git a/fs/gfs2/acl.c b/fs/gfs2/acl.c
index 906e403..87f6304 100644
--- a/fs/gfs2/acl.c
+++ b/fs/gfs2/acl.c
@@ -76,9 +76,9 @@ int gfs2_acl_validate_remove(struct gfs2
 		return -EOPNOTSUPP;
 	if (current->fsuid != ip->i_di.di_uid && !capable(CAP_FOWNER))
 		return -EPERM;
-	if (S_ISLNK(ip->i_di.di_mode))
+	if (S_ISLNK(ip->i_inode.i_mode))
 		return -EOPNOTSUPP;
-	if (!access && !S_ISDIR(ip->i_di.di_mode))
+	if (!access && !S_ISDIR(ip->i_inode.i_mode))
 		return -EACCES;
 
 	return 0;
@@ -198,8 +198,8 @@ static int munge_mode(struct gfs2_inode 
 	error = gfs2_meta_inode_buffer(ip, &dibh);
 	if (!error) {
 		gfs2_assert_withdraw(sdp,
-				(ip->i_di.di_mode & S_IFMT) == (mode & S_IFMT));
-		ip->i_di.di_mode = mode;
+				(ip->i_inode.i_mode & S_IFMT) == (mode & S_IFMT));
+		ip->i_inode.i_mode = mode;
 		gfs2_trans_add_bh(ip->i_gl, dibh, 1);
 		gfs2_dinode_out(ip, dibh->b_data);
 		brelse(dibh);
@@ -215,12 +215,12 @@ int gfs2_acl_create(struct gfs2_inode *d
 	struct gfs2_sbd *sdp = GFS2_SB(&dip->i_inode);
 	struct posix_acl *acl = NULL, *clone;
 	struct gfs2_ea_request er;
-	mode_t mode = ip->i_di.di_mode;
+	mode_t mode = ip->i_inode.i_mode;
 	int error;
 
 	if (!sdp->sd_args.ar_posix_acl)
 		return 0;
-	if (S_ISLNK(ip->i_di.di_mode))
+	if (S_ISLNK(ip->i_inode.i_mode))
 		return 0;
 
 	memset(&er, 0, sizeof(struct gfs2_ea_request));
@@ -232,7 +232,7 @@ int gfs2_acl_create(struct gfs2_inode *d
 		return error;
 	if (!acl) {
 		mode &= ~current->fs->umask;
-		if (mode != ip->i_di.di_mode)
+		if (mode != ip->i_inode.i_mode)
 			error = munge_mode(ip, mode);
 		return error;
 	}
@@ -244,7 +244,7 @@ int gfs2_acl_create(struct gfs2_inode *d
 	posix_acl_release(acl);
 	acl = clone;
 
-	if (S_ISDIR(ip->i_di.di_mode)) {
+	if (S_ISDIR(ip->i_inode.i_mode)) {
 		er.er_name = GFS2_POSIX_ACL_DEFAULT;
 		er.er_name_len = GFS2_POSIX_ACL_DEFAULT_LEN;
 		error = gfs2_system_eaops.eo_set(ip, &er);
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 8c092ab..481a068 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1109,7 +1109,7 @@ int gfs2_truncatei(struct gfs2_inode *ip
 {
 	int error;
 
-	if (gfs2_assert_warn(GFS2_SB(&ip->i_inode), S_ISREG(ip->i_di.di_mode)))
+	if (gfs2_assert_warn(GFS2_SB(&ip->i_inode), S_ISREG(ip->i_inode.i_mode)))
 		return -EINVAL;
 
 	if (size > ip->i_di.di_size)
diff --git a/fs/gfs2/eaops.c b/fs/gfs2/eaops.c
index 92c54e9..cd747c0 100644
--- a/fs/gfs2/eaops.c
+++ b/fs/gfs2/eaops.c
@@ -120,7 +120,7 @@ static int system_eo_set(struct gfs2_ino
 
 	if (GFS2_ACL_IS_ACCESS(er->er_name, er->er_name_len)) {
 		if (!(er->er_flags & GFS2_ERF_MODE)) {
-			er->er_mode = ip->i_di.di_mode;
+			er->er_mode = ip->i_inode.i_mode;
 			er->er_flags |= GFS2_ERF_MODE;
 		}
 		error = gfs2_acl_validate_set(ip, 1, er,
diff --git a/fs/gfs2/eattr.c b/fs/gfs2/eattr.c
index 9b7bb56..5208fa9 100644
--- a/fs/gfs2/eattr.c
+++ b/fs/gfs2/eattr.c
@@ -711,9 +711,9 @@ static int ea_alloc_skeleton(struct gfs2
 	if (!error) {
 		if (er->er_flags & GFS2_ERF_MODE) {
 			gfs2_assert_withdraw(GFS2_SB(&ip->i_inode),
-					    (ip->i_di.di_mode & S_IFMT) ==
+					    (ip->i_inode.i_mode & S_IFMT) ==
 					    (er->er_mode & S_IFMT));
-			ip->i_di.di_mode = er->er_mode;
+			ip->i_inode.i_mode = er->er_mode;
 		}
 		ip->i_di.di_ctime = get_seconds();
 		gfs2_trans_add_bh(ip->i_gl, dibh, 1);
@@ -847,8 +847,8 @@ static int ea_set_simple_noalloc(struct 
 
 	if (er->er_flags & GFS2_ERF_MODE) {
 		gfs2_assert_withdraw(GFS2_SB(&ip->i_inode),
-			(ip->i_di.di_mode & S_IFMT) == (er->er_mode & S_IFMT));
-		ip->i_di.di_mode = er->er_mode;
+			(ip->i_inode.i_mode & S_IFMT) == (er->er_mode & S_IFMT));
+		ip->i_inode.i_mode = er->er_mode;
 	}
 	ip->i_di.di_ctime = get_seconds();
 	gfs2_trans_add_bh(ip->i_gl, dibh, 1);
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 78fe0fa..44633c4 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2078,7 +2078,7 @@ static int dump_inode(struct gfs2_inode 
 	printk(KERN_INFO "    num = %llu %llu\n",
 		    (unsigned long long)ip->i_num.no_formal_ino,
 		    (unsigned long long)ip->i_num.no_addr);
-	printk(KERN_INFO "    type = %u\n", IF2DT(ip->i_di.di_mode));
+	printk(KERN_INFO "    type = %u\n", IF2DT(ip->i_inode.i_mode));
 	printk(KERN_INFO "    i_flags =");
 	for (x = 0; x < 32; x++)
 		if (test_bit(x, &ip->i_flags))
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 5406b19..aad45b7 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -92,7 +92,7 @@ static void gfs2_pte_inval(struct gfs2_g
 
 	ip = gl->gl_object;
 	inode = &ip->i_inode;
-	if (!ip || !S_ISREG(ip->i_di.di_mode))
+	if (!ip || !S_ISREG(inode->i_mode))
 		return;
 
 	if (!test_bit(GIF_PAGED, &ip->i_flags))
@@ -119,7 +119,7 @@ static void gfs2_page_inval(struct gfs2_
 
 	ip = gl->gl_object;
 	inode = &ip->i_inode;
-	if (!ip || !S_ISREG(ip->i_di.di_mode))
+	if (!ip || !S_ISREG(inode->i_mode))
 		return;
 
 	truncate_inode_pages(inode->i_mapping, 0);
@@ -142,7 +142,7 @@ static void gfs2_page_wait(struct gfs2_g
 	struct address_space *mapping = inode->i_mapping;
 	int error;
 
-	if (!S_ISREG(ip->i_di.di_mode))
+	if (!S_ISREG(inode->i_mode))
 		return;
 
 	error = filemap_fdatawait(mapping);
@@ -164,7 +164,7 @@ static void gfs2_page_writeback(struct g
 	struct inode *inode = &ip->i_inode;
 	struct address_space *mapping = inode->i_mapping;
 
-	if (!S_ISREG(ip->i_di.di_mode))
+	if (!S_ISREG(inode->i_mode))
 		return;
 
 	filemap_fdatawrite(mapping);
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index a995919..de46604 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -51,7 +51,6 @@ void gfs2_inode_attr_in(struct gfs2_inod
 	struct gfs2_dinode_host *di = &ip->i_di;
 
 	inode->i_ino = ip->i_num.no_addr;
-	inode->i_mode = di->di_mode;
 	inode->i_nlink = di->di_nlink;
 	inode->i_uid = di->di_uid;
 	inode->i_gid = di->di_gid;
@@ -88,9 +87,6 @@ void gfs2_inode_attr_out(struct gfs2_ino
 {
 	struct inode *inode = &ip->i_inode;
 	struct gfs2_dinode_host *di = &ip->i_di;
-	gfs2_assert_withdraw(GFS2_SB(inode),
-		(di->di_mode & S_IFMT) == (inode->i_mode & S_IFMT));
-	di->di_mode = inode->i_mode;
 	di->di_uid = inode->i_uid;
 	di->di_gid = inode->i_gid;
 	di->di_atime = inode->i_atime.tv_sec;
@@ -210,9 +206,9 @@ static int gfs2_dinode_in(struct gfs2_in
 	if (ip->i_num.no_formal_ino != be64_to_cpu(str->di_num.no_formal_ino))
 		return -ESTALE;
 
-	di->di_mode = be32_to_cpu(str->di_mode);
+	ip->i_inode.i_mode = be32_to_cpu(str->di_mode);
 	ip->i_inode.i_rdev = 0;
-	switch (di->di_mode & S_IFMT) {
+	switch (ip->i_inode.i_mode & S_IFMT) {
 	case S_IFBLK:
 	case S_IFCHR:
 		ip->i_inode.i_rdev = MKDEV(be32_to_cpu(str->di_major),
@@ -620,7 +616,7 @@ static void munge_mode_uid_gid(struct gf
 			       unsigned int *uid, unsigned int *gid)
 {
 	if (GFS2_SB(&dip->i_inode)->sd_args.ar_suiddir &&
-	    (dip->i_di.di_mode & S_ISUID) && dip->i_di.di_uid) {
+	    (dip->i_inode.i_mode & S_ISUID) && dip->i_di.di_uid) {
 		if (S_ISDIR(*mode))
 			*mode |= S_ISUID;
 		else if (dip->i_di.di_uid != current->fsuid)
@@ -629,7 +625,7 @@ static void munge_mode_uid_gid(struct gf
 	} else
 		*uid = current->fsuid;
 
-	if (dip->i_di.di_mode & S_ISGID) {
+	if (dip->i_inode.i_mode & S_ISGID) {
 		if (S_ISDIR(*mode))
 			*mode |= S_ISGID;
 		*gid = dip->i_di.di_gid;
@@ -810,7 +806,7 @@ static int link_dinode(struct gfs2_inode
 			goto fail_quota_locks;
 	}
 
-	error = gfs2_dir_add(&dip->i_inode, name, &ip->i_num, IF2DT(ip->i_di.di_mode));
+	error = gfs2_dir_add(&dip->i_inode, name, &ip->i_num, IF2DT(ip->i_inode.i_mode));
 	if (error)
 		goto fail_end_trans;
 
@@ -1053,7 +1049,7 @@ int gfs2_unlink_ok(struct gfs2_inode *di
 	if (IS_IMMUTABLE(&ip->i_inode) || IS_APPEND(&ip->i_inode))
 		return -EPERM;
 
-	if ((dip->i_di.di_mode & S_ISVTX) &&
+	if ((dip->i_inode.i_mode & S_ISVTX) &&
 	    dip->i_di.di_uid != current->fsuid &&
 	    ip->i_di.di_uid != current->fsuid && !capable(CAP_FOWNER))
 		return -EPERM;
@@ -1072,7 +1068,7 @@ int gfs2_unlink_ok(struct gfs2_inode *di
 	if (!gfs2_inum_equal(&inum, &ip->i_num))
 		return -ENOENT;
 
-	if (IF2DT(ip->i_di.di_mode) != type) {
+	if (IF2DT(ip->i_inode.i_mode) != type) {
 		gfs2_consist_inode(dip);
 		return -EIO;
 	}
diff --git a/fs/gfs2/inode.h b/fs/gfs2/inode.h
index 33c9ea6..69cbf98 100644
--- a/fs/gfs2/inode.h
+++ b/fs/gfs2/inode.h
@@ -22,7 +22,7 @@ static inline int gfs2_is_jdata(struct g
 
 static inline int gfs2_is_dir(struct gfs2_inode *ip)
 {
-	return S_ISDIR(ip->i_di.di_mode);
+	return S_ISDIR(ip->i_inode.i_mode);
 }
 
 void gfs2_inode_attr_in(struct gfs2_inode *ip);
diff --git a/fs/gfs2/ondisk.c b/fs/gfs2/ondisk.c
index 60dd943..6b50a57 100644
--- a/fs/gfs2/ondisk.c
+++ b/fs/gfs2/ondisk.c
@@ -161,7 +161,7 @@ void gfs2_dinode_out(const struct gfs2_i
 
 	gfs2_inum_out(&ip->i_num, &str->di_num);
 
-	str->di_mode = cpu_to_be32(di->di_mode);
+	str->di_mode = cpu_to_be32(ip->i_inode.i_mode);
 	str->di_uid = cpu_to_be32(di->di_uid);
 	str->di_gid = cpu_to_be32(di->di_gid);
 	str->di_nlink = cpu_to_be32(di->di_nlink);
@@ -191,7 +191,6 @@ void gfs2_dinode_print(const struct gfs2
 
 	gfs2_inum_print(&ip->i_num);
 
-	pv(di, di_mode, "0%o");
 	pv(di, di_uid, "%u");
 	pv(di, di_gid, "%u");
 	pv(di, di_nlink, "%u");
diff --git a/fs/gfs2/ops_address.c b/fs/gfs2/ops_address.c
index 015640b..45a3d85 100644
--- a/fs/gfs2/ops_address.c
+++ b/fs/gfs2/ops_address.c
@@ -498,7 +498,6 @@ static int gfs2_commit_write(struct file
 		di->di_size = cpu_to_be64(inode->i_size);
 	}
 
-	di->di_mode = cpu_to_be32(inode->i_mode);
 	di->di_atime = cpu_to_be64(inode->i_atime.tv_sec);
 	di->di_mtime = cpu_to_be64(inode->i_mtime.tv_sec);
 	di->di_ctime = cpu_to_be64(inode->i_ctime.tv_sec);
diff --git a/fs/gfs2/ops_dentry.c b/fs/gfs2/ops_dentry.c
index c36f9e3..d355899 100644
--- a/fs/gfs2/ops_dentry.c
+++ b/fs/gfs2/ops_dentry.c
@@ -76,7 +76,7 @@ static int gfs2_drevalidate(struct dentr
 	if (!gfs2_inum_equal(&ip->i_num, &inum))
 		goto invalid_gunlock;
 
-	if (IF2DT(ip->i_di.di_mode) != type) {
+	if (IF2DT(ip->i_inode.i_mode) != type) {
 		gfs2_consist_inode(dip);
 		goto fail_gunlock;
 	}
diff --git a/fs/gfs2/ops_file.c b/fs/gfs2/ops_file.c
index 7ea4175..b52b9db 100644
--- a/fs/gfs2/ops_file.c
+++ b/fs/gfs2/ops_file.c
@@ -425,7 +425,7 @@ static int gfs2_open(struct inode *inode
 	gfs2_assert_warn(GFS2_SB(inode), !file->private_data);
 	file->private_data = fp;
 
-	if (S_ISREG(ip->i_di.di_mode)) {
+	if (S_ISREG(ip->i_inode.i_mode)) {
 		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY,
 					   &i_gh);
 		if (error)
@@ -515,7 +515,7 @@ static int gfs2_lock(struct file *file, 
 
 	if (!(fl->fl_flags & FL_POSIX))
 		return -ENOLCK;
-	if ((ip->i_di.di_mode & (S_ISGID | S_IXGRP)) == S_ISGID)
+	if ((ip->i_inode.i_mode & (S_ISGID | S_IXGRP)) == S_ISGID)
 		return -ENOLCK;
 
 	if (sdp->sd_args.ar_localflocks) {
@@ -617,7 +617,7 @@ static int gfs2_flock(struct file *file,
 
 	if (!(fl->fl_flags & FL_FLOCK))
 		return -ENOLCK;
-	if ((ip->i_di.di_mode & (S_ISGID | S_IXGRP)) == S_ISGID)
+	if ((ip->i_inode.i_mode & (S_ISGID | S_IXGRP)) == S_ISGID)
 		return -ENOLCK;
 
 	if (sdp->sd_args.ar_localflocks)
diff --git a/fs/gfs2/ops_inode.c b/fs/gfs2/ops_inode.c
index c10b914..cf7a5ba 100644
--- a/fs/gfs2/ops_inode.c
+++ b/fs/gfs2/ops_inode.c
@@ -144,7 +144,7 @@ static int gfs2_link(struct dentry *old_
 	int alloc_required;
 	int error;
 
-	if (S_ISDIR(ip->i_di.di_mode))
+	if (S_ISDIR(inode->i_mode))
 		return -EPERM;
 
 	gfs2_holder_init(dip->i_gl, LM_ST_EXCLUSIVE, 0, ghs);
@@ -220,7 +220,7 @@ static int gfs2_link(struct dentry *old_
 	}
 
 	error = gfs2_dir_add(dir, &dentry->d_name, &ip->i_num,
-			     IF2DT(ip->i_di.di_mode));
+			     IF2DT(inode->i_mode));
 	if (error)
 		goto out_end_trans;
 
@@ -564,11 +564,10 @@ static int gfs2_rename(struct inode *odi
 
 	/* Make sure we aren't trying to move a dirctory into it's subdir */
 
-	if (S_ISDIR(ip->i_di.di_mode) && odip != ndip) {
+	if (S_ISDIR(ip->i_inode.i_mode) && odip != ndip) {
 		dir_rename = 1;
 
-		error = gfs2_glock_nq_init(sdp->sd_rename_gl,
-					   LM_ST_EXCLUSIVE, 0,
+		error = gfs2_glock_nq_init(sdp->sd_rename_gl, LM_ST_EXCLUSIVE, 0,
 					   &r_gh);
 		if (error)
 			goto out;
@@ -609,7 +608,7 @@ static int gfs2_rename(struct inode *odi
 		if (error)
 			goto out_gunlock;
 
-		if (S_ISDIR(nip->i_di.di_mode)) {
+		if (S_ISDIR(nip->i_inode.i_mode)) {
 			if (nip->i_di.di_entries < 2) {
 				if (gfs2_consist_inode(nip))
 					gfs2_dinode_print(nip);
@@ -646,7 +645,7 @@ static int gfs2_rename(struct inode *odi
 				error = -EFBIG;
 				goto out_gunlock;
 			}
-			if (S_ISDIR(ip->i_di.di_mode) &&
+			if (S_ISDIR(ip->i_inode.i_mode) &&
 			    ndip->i_di.di_nlink == (u32)-1) {
 				error = -EMLINK;
 				goto out_gunlock;
@@ -701,7 +700,7 @@ static int gfs2_rename(struct inode *odi
 	/* Remove the target file, if it exists */
 
 	if (nip) {
-		if (S_ISDIR(nip->i_di.di_mode))
+		if (S_ISDIR(nip->i_inode.i_mode))
 			error = gfs2_rmdiri(ndip, &ndentry->d_name, nip);
 		else {
 			error = gfs2_dir_del(ndip, &ndentry->d_name);
@@ -743,7 +742,7 @@ static int gfs2_rename(struct inode *odi
 		goto out_end_trans;
 
 	error = gfs2_dir_add(ndir, &ndentry->d_name, &ip->i_num,
-			     IF2DT(ip->i_di.di_mode));
+			     IF2DT(ip->i_inode.i_mode));
 	if (error)
 		goto out_end_trans;
 
diff --git a/fs/gfs2/ops_super.c b/fs/gfs2/ops_super.c
index 9c786d1..8635175 100644
--- a/fs/gfs2/ops_super.c
+++ b/fs/gfs2/ops_super.c
@@ -407,7 +407,7 @@ static void gfs2_delete_inode(struct ino
 	if (error)
 		goto out_uninit;
 
-	if (S_ISDIR(ip->i_di.di_mode) &&
+	if (S_ISDIR(inode->i_mode) &&
 	    (ip->i_di.di_flags & GFS2_DIF_EXHASH)) {
 		error = gfs2_dir_exhash_dealloc(ip);
 		if (error)
diff --git a/include/linux/gfs2_ondisk.h b/include/linux/gfs2_ondisk.h
index 5bcf895..f1ea0b4 100644
--- a/include/linux/gfs2_ondisk.h
+++ b/include/linux/gfs2_ondisk.h
@@ -322,7 +322,6 @@ struct gfs2_dinode {
 };
 
 struct gfs2_dinode_host {
-	__u32 di_mode;	/* mode of file */
 	__u32 di_uid;	/* owner's user id */
 	__u32 di_gid;	/* owner's group id */
 	__u32 di_nlink;	/* number of links to this file */
-- 
1.4.1



