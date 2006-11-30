Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936320AbWK3Mew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936320AbWK3Mew (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936266AbWK3MRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:17:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28297 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936311AbWK3MQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:16:28 -0500
Subject: [GFS2] Shrink gfs2_inode (4) - di_uid/di_gid [24/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:16:14 +0000
Message-Id: <1164888974.3752.352.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 2933f9254a6af33db25270778c998a42029da668 Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Wed, 1 Nov 2006 13:23:29 -0500
Subject: [PATCH] [GFS2] Shrink gfs2_inode (4) - di_uid/di_gid

Remove duplicate di_uid/di_gid fields in favour of using
inode->i_uid/inode->i_gid instead. This saves 8 bytes.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/acl.c               |    2 +-
 fs/gfs2/bmap.c              |    2 +-
 fs/gfs2/eattr.c             |    2 +-
 fs/gfs2/inode.c             |   23 +++++++++--------------
 fs/gfs2/ondisk.c            |    6 ++----
 fs/gfs2/ops_address.c       |    2 +-
 fs/gfs2/ops_inode.c         |   10 ++++------
 fs/gfs2/ops_vm.c            |    2 +-
 fs/gfs2/quota.c             |    8 ++++----
 fs/gfs2/rgrp.c              |   11 +++++------
 include/linux/gfs2_ondisk.h |    2 --
 11 files changed, 29 insertions(+), 41 deletions(-)

diff --git a/fs/gfs2/acl.c b/fs/gfs2/acl.c
index 87f6304..3908992 100644
--- a/fs/gfs2/acl.c
+++ b/fs/gfs2/acl.c
@@ -74,7 +74,7 @@ int gfs2_acl_validate_remove(struct gfs2
 {
 	if (!GFS2_SB(&ip->i_inode)->sd_args.ar_posix_acl)
 		return -EOPNOTSUPP;
-	if (current->fsuid != ip->i_di.di_uid && !capable(CAP_FOWNER))
+	if (current->fsuid != ip->i_inode.i_uid && !capable(CAP_FOWNER))
 		return -EPERM;
 	if (S_ISLNK(ip->i_inode.i_mode))
 		return -EOPNOTSUPP;
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 481a068..0c913ee 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -819,7 +819,7 @@ static int do_grow(struct gfs2_inode *ip
 	if (error)
 		goto out;
 
-	error = gfs2_quota_check(ip, ip->i_di.di_uid, ip->i_di.di_gid);
+	error = gfs2_quota_check(ip, ip->i_inode.i_uid, ip->i_inode.i_gid);
 	if (error)
 		goto out_gunlock_q;
 
diff --git a/fs/gfs2/eattr.c b/fs/gfs2/eattr.c
index 5208fa9..935cc9a 100644
--- a/fs/gfs2/eattr.c
+++ b/fs/gfs2/eattr.c
@@ -687,7 +687,7 @@ static int ea_alloc_skeleton(struct gfs2
 	if (error)
 		goto out;
 
-	error = gfs2_quota_check(ip, ip->i_di.di_uid, ip->i_di.di_gid);
+	error = gfs2_quota_check(ip, ip->i_inode.i_uid, ip->i_inode.i_gid);
 	if (error)
 		goto out_gunlock_q;
 
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index de46604..0de9b22 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -52,8 +52,6 @@ void gfs2_inode_attr_in(struct gfs2_inod
 
 	inode->i_ino = ip->i_num.no_addr;
 	inode->i_nlink = di->di_nlink;
-	inode->i_uid = di->di_uid;
-	inode->i_gid = di->di_gid;
 	i_size_write(inode, di->di_size);
 	inode->i_atime.tv_sec = di->di_atime;
 	inode->i_mtime.tv_sec = di->di_mtime;
@@ -87,8 +85,6 @@ void gfs2_inode_attr_out(struct gfs2_ino
 {
 	struct inode *inode = &ip->i_inode;
 	struct gfs2_dinode_host *di = &ip->i_di;
-	di->di_uid = inode->i_uid;
-	di->di_gid = inode->i_gid;
 	di->di_atime = inode->i_atime.tv_sec;
 	di->di_mtime = inode->i_mtime.tv_sec;
 	di->di_ctime = inode->i_ctime.tv_sec;
@@ -216,8 +212,8 @@ static int gfs2_dinode_in(struct gfs2_in
 		break;
 	};
 
-	di->di_uid = be32_to_cpu(str->di_uid);
-	di->di_gid = be32_to_cpu(str->di_gid);
+	ip->i_inode.i_uid = be32_to_cpu(str->di_uid);
+	ip->i_inode.i_gid = be32_to_cpu(str->di_gid);
 	di->di_nlink = be32_to_cpu(str->di_nlink);
 	di->di_size = be64_to_cpu(str->di_size);
 	di->di_blocks = be64_to_cpu(str->di_blocks);
@@ -616,19 +612,19 @@ static void munge_mode_uid_gid(struct gf
 			       unsigned int *uid, unsigned int *gid)
 {
 	if (GFS2_SB(&dip->i_inode)->sd_args.ar_suiddir &&
-	    (dip->i_inode.i_mode & S_ISUID) && dip->i_di.di_uid) {
+	    (dip->i_inode.i_mode & S_ISUID) && dip->i_inode.i_uid) {
 		if (S_ISDIR(*mode))
 			*mode |= S_ISUID;
-		else if (dip->i_di.di_uid != current->fsuid)
+		else if (dip->i_inode.i_uid != current->fsuid)
 			*mode &= ~07111;
-		*uid = dip->i_di.di_uid;
+		*uid = dip->i_inode.i_uid;
 	} else
 		*uid = current->fsuid;
 
 	if (dip->i_inode.i_mode & S_ISGID) {
 		if (S_ISDIR(*mode))
 			*mode |= S_ISGID;
-		*gid = dip->i_di.di_gid;
+		*gid = dip->i_inode.i_gid;
 	} else
 		*gid = current->fsgid;
 }
@@ -783,8 +779,7 @@ static int link_dinode(struct gfs2_inode
 	if (alloc_required < 0)
 		goto fail;
 	if (alloc_required) {
-		error = gfs2_quota_check(dip, dip->i_di.di_uid,
-					 dip->i_di.di_gid);
+		error = gfs2_quota_check(dip, dip->i_inode.i_uid, dip->i_inode.i_gid);
 		if (error)
 			goto fail_quota_locks;
 
@@ -1050,8 +1045,8 @@ int gfs2_unlink_ok(struct gfs2_inode *di
 		return -EPERM;
 
 	if ((dip->i_inode.i_mode & S_ISVTX) &&
-	    dip->i_di.di_uid != current->fsuid &&
-	    ip->i_di.di_uid != current->fsuid && !capable(CAP_FOWNER))
+	    dip->i_inode.i_uid != current->fsuid &&
+	    ip->i_inode.i_uid != current->fsuid && !capable(CAP_FOWNER))
 		return -EPERM;
 
 	if (IS_APPEND(&dip->i_inode))
diff --git a/fs/gfs2/ondisk.c b/fs/gfs2/ondisk.c
index 6b50a57..e224f6a 100644
--- a/fs/gfs2/ondisk.c
+++ b/fs/gfs2/ondisk.c
@@ -162,8 +162,8 @@ void gfs2_dinode_out(const struct gfs2_i
 	gfs2_inum_out(&ip->i_num, &str->di_num);
 
 	str->di_mode = cpu_to_be32(ip->i_inode.i_mode);
-	str->di_uid = cpu_to_be32(di->di_uid);
-	str->di_gid = cpu_to_be32(di->di_gid);
+	str->di_uid = cpu_to_be32(ip->i_inode.i_uid);
+	str->di_gid = cpu_to_be32(ip->i_inode.i_gid);
 	str->di_nlink = cpu_to_be32(di->di_nlink);
 	str->di_size = cpu_to_be64(di->di_size);
 	str->di_blocks = cpu_to_be64(di->di_blocks);
@@ -191,8 +191,6 @@ void gfs2_dinode_print(const struct gfs2
 
 	gfs2_inum_print(&ip->i_num);
 
-	pv(di, di_uid, "%u");
-	pv(di, di_gid, "%u");
 	pv(di, di_nlink, "%u");
 	printk(KERN_INFO "  di_size = %llu\n", (unsigned long long)di->di_size);
 	printk(KERN_INFO "  di_blocks = %llu\n", (unsigned long long)di->di_blocks);
diff --git a/fs/gfs2/ops_address.c b/fs/gfs2/ops_address.c
index 45a3d85..38b702a 100644
--- a/fs/gfs2/ops_address.c
+++ b/fs/gfs2/ops_address.c
@@ -386,7 +386,7 @@ static int gfs2_prepare_write(struct fil
 		if (error)
 			goto out_alloc_put;
 
-		error = gfs2_quota_check(ip, ip->i_di.di_uid, ip->i_di.di_gid);
+		error = gfs2_quota_check(ip, ip->i_inode.i_uid, ip->i_inode.i_gid);
 		if (error)
 			goto out_qunlock;
 
diff --git a/fs/gfs2/ops_inode.c b/fs/gfs2/ops_inode.c
index cf7a5ba..efbcec3 100644
--- a/fs/gfs2/ops_inode.c
+++ b/fs/gfs2/ops_inode.c
@@ -196,8 +196,7 @@ static int gfs2_link(struct dentry *old_
 		if (error)
 			goto out_alloc;
 
-		error = gfs2_quota_check(dip, dip->i_di.di_uid,
-					 dip->i_di.di_gid);
+		error = gfs2_quota_check(dip, dip->i_inode.i_uid, dip->i_inode.i_gid);
 		if (error)
 			goto out_gunlock_q;
 
@@ -673,8 +672,7 @@ static int gfs2_rename(struct inode *odi
 		if (error)
 			goto out_alloc;
 
-		error = gfs2_quota_check(ndip, ndip->i_di.di_uid,
-					 ndip->i_di.di_gid);
+		error = gfs2_quota_check(ndip, ndip->i_inode.i_uid, ndip->i_inode.i_gid);
 		if (error)
 			goto out_gunlock_q;
 
@@ -885,8 +883,8 @@ static int setattr_chown(struct inode *i
 	u32 ouid, ogid, nuid, ngid;
 	int error;
 
-	ouid = ip->i_di.di_uid;
-	ogid = ip->i_di.di_gid;
+	ouid = inode->i_uid;
+	ogid = inode->i_gid;
 	nuid = attr->ia_uid;
 	ngid = attr->ia_gid;
 
diff --git a/fs/gfs2/ops_vm.c b/fs/gfs2/ops_vm.c
index 5453d29..45a5f11 100644
--- a/fs/gfs2/ops_vm.c
+++ b/fs/gfs2/ops_vm.c
@@ -76,7 +76,7 @@ static int alloc_page_backing(struct gfs
 	if (error)
 		goto out;
 
-	error = gfs2_quota_check(ip, ip->i_di.di_uid, ip->i_di.di_gid);
+	error = gfs2_quota_check(ip, ip->i_inode.i_uid, ip->i_inode.i_gid);
 	if (error)
 		goto out_gunlock_q;
 
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 5d00e9b..d0db881 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -452,19 +452,19 @@ int gfs2_quota_hold(struct gfs2_inode *i
 	if (sdp->sd_args.ar_quota == GFS2_QUOTA_OFF)
 		return 0;
 
-	error = qdsb_get(sdp, QUOTA_USER, ip->i_di.di_uid, CREATE, qd);
+	error = qdsb_get(sdp, QUOTA_USER, ip->i_inode.i_uid, CREATE, qd);
 	if (error)
 		goto out;
 	al->al_qd_num++;
 	qd++;
 
-	error = qdsb_get(sdp, QUOTA_GROUP, ip->i_di.di_gid, CREATE, qd);
+	error = qdsb_get(sdp, QUOTA_GROUP, ip->i_inode.i_gid, CREATE, qd);
 	if (error)
 		goto out;
 	al->al_qd_num++;
 	qd++;
 
-	if (uid != NO_QUOTA_CHANGE && uid != ip->i_di.di_uid) {
+	if (uid != NO_QUOTA_CHANGE && uid != ip->i_inode.i_uid) {
 		error = qdsb_get(sdp, QUOTA_USER, uid, CREATE, qd);
 		if (error)
 			goto out;
@@ -472,7 +472,7 @@ int gfs2_quota_hold(struct gfs2_inode *i
 		qd++;
 	}
 
-	if (gid != NO_QUOTA_CHANGE && gid != ip->i_di.di_gid) {
+	if (gid != NO_QUOTA_CHANGE && gid != ip->i_inode.i_gid) {
 		error = qdsb_get(sdp, QUOTA_GROUP, gid, CREATE, qd);
 		if (error)
 			goto out;
diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index 07dfd63..ff08465 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -1217,7 +1217,7 @@ u64 gfs2_alloc_data(struct gfs2_inode *i
 	al->al_alloced++;
 
 	gfs2_statfs_change(sdp, 0, -1, 0);
-	gfs2_quota_change(ip, +1, ip->i_di.di_uid, ip->i_di.di_gid);
+	gfs2_quota_change(ip, +1, ip->i_inode.i_uid, ip->i_inode.i_gid);
 
 	spin_lock(&sdp->sd_rindex_spin);
 	rgd->rd_free_clone--;
@@ -1261,7 +1261,7 @@ u64 gfs2_alloc_meta(struct gfs2_inode *i
 	al->al_alloced++;
 
 	gfs2_statfs_change(sdp, 0, -1, 0);
-	gfs2_quota_change(ip, +1, ip->i_di.di_uid, ip->i_di.di_gid);
+	gfs2_quota_change(ip, +1, ip->i_inode.i_uid, ip->i_inode.i_gid);
 	gfs2_trans_add_unrevoke(sdp, block);
 
 	spin_lock(&sdp->sd_rindex_spin);
@@ -1337,8 +1337,7 @@ void gfs2_free_data(struct gfs2_inode *i
 	gfs2_trans_add_rg(rgd);
 
 	gfs2_statfs_change(sdp, 0, +blen, 0);
-	gfs2_quota_change(ip, -(s64)blen,
-			 ip->i_di.di_uid, ip->i_di.di_gid);
+	gfs2_quota_change(ip, -(s64)blen, ip->i_inode.i_uid, ip->i_inode.i_gid);
 }
 
 /**
@@ -1366,7 +1365,7 @@ void gfs2_free_meta(struct gfs2_inode *i
 	gfs2_trans_add_rg(rgd);
 
 	gfs2_statfs_change(sdp, 0, +blen, 0);
-	gfs2_quota_change(ip, -(s64)blen, ip->i_di.di_uid, ip->i_di.di_gid);
+	gfs2_quota_change(ip, -(s64)blen, ip->i_inode.i_uid, ip->i_inode.i_gid);
 	gfs2_meta_wipe(ip, bstart, blen);
 }
 
@@ -1411,7 +1410,7 @@ static void gfs2_free_uninit_di(struct g
 void gfs2_free_di(struct gfs2_rgrpd *rgd, struct gfs2_inode *ip)
 {
 	gfs2_free_uninit_di(rgd, ip->i_num.no_addr);
-	gfs2_quota_change(ip, -1, ip->i_di.di_uid, ip->i_di.di_gid);
+	gfs2_quota_change(ip, -1, ip->i_inode.i_uid, ip->i_inode.i_gid);
 	gfs2_meta_wipe(ip, ip->i_num.no_addr, 1);
 }
 
diff --git a/include/linux/gfs2_ondisk.h b/include/linux/gfs2_ondisk.h
index f1ea0b4..896c7f8 100644
--- a/include/linux/gfs2_ondisk.h
+++ b/include/linux/gfs2_ondisk.h
@@ -322,8 +322,6 @@ struct gfs2_dinode {
 };
 
 struct gfs2_dinode_host {
-	__u32 di_uid;	/* owner's user id */
-	__u32 di_gid;	/* owner's group id */
 	__u32 di_nlink;	/* number of links to this file */
 	__u64 di_size;	/* number of bytes in file */
 	__u64 di_blocks;	/* number of blocks in file */
-- 
1.4.1



