Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936329AbWK3MiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936329AbWK3MiH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936278AbWK3MPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:15:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21128 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936288AbWK3MPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:15:07 -0500
Subject: [GFS2] Change argument of gfs2_dinode_out [17/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:15:33 +0000
Message-Id: <1164888933.3752.338.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 539e5d6b7ae8612c0393fe940d2da5b591318d3d Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Tue, 31 Oct 2006 15:07:05 -0500
Subject: [PATCH] [GFS2] Change argument of gfs2_dinode_out

Everywhere this was called, a struct gfs2_inode was available,
but despite that, it was always called with a struct gfs2_dinode
as an argument. By making this change it paves the way to start
eliminating fields duplicated between the kernel's struct inode
and the struct gfs2_dinode.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/acl.c               |    2 +-
 fs/gfs2/bmap.c              |   12 ++++++------
 fs/gfs2/dir.c               |   20 ++++++++++----------
 fs/gfs2/eattr.c             |   14 +++++++-------
 fs/gfs2/inode.c             |    6 +++---
 fs/gfs2/ondisk.c            |    5 ++++-
 fs/gfs2/ops_file.c          |    2 +-
 fs/gfs2/ops_inode.c         |   10 +++++-----
 include/linux/gfs2_ondisk.h |    3 ++-
 9 files changed, 39 insertions(+), 35 deletions(-)

diff --git a/fs/gfs2/acl.c b/fs/gfs2/acl.c
index 5f959b8..906e403 100644
--- a/fs/gfs2/acl.c
+++ b/fs/gfs2/acl.c
@@ -201,7 +201,7 @@ static int munge_mode(struct gfs2_inode 
 				(ip->i_di.di_mode & S_IFMT) == (mode & S_IFMT));
 		ip->i_di.di_mode = mode;
 		gfs2_trans_add_bh(ip->i_gl, dibh, 1);
-		gfs2_dinode_out(&ip->i_di, dibh->b_data);
+		gfs2_dinode_out(ip, dibh->b_data);
 		brelse(dibh);
 	}
 
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 51f6356..8c092ab 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -498,7 +498,7 @@ static int gfs2_block_pointers(struct in
 			error = gfs2_meta_inode_buffer(ip, &dibh);
 			if (!error) {
 				gfs2_trans_add_bh(ip->i_gl, dibh, 1);
-				gfs2_dinode_out(&ip->i_di, dibh->b_data);
+				gfs2_dinode_out(ip, dibh->b_data);
 				brelse(dibh);
 			}
 			set_buffer_new(bh_map);
@@ -780,7 +780,7 @@ static int do_strip(struct gfs2_inode *i
 
 	ip->i_di.di_mtime = ip->i_di.di_ctime = get_seconds();
 
-	gfs2_dinode_out(&ip->i_di, dibh->b_data);
+	gfs2_dinode_out(ip, dibh->b_data);
 
 	up_write(&ip->i_rw_mutex);
 
@@ -860,7 +860,7 @@ static int do_grow(struct gfs2_inode *ip
 		goto out_end_trans;
 
 	gfs2_trans_add_bh(ip->i_gl, dibh, 1);
-	gfs2_dinode_out(&ip->i_di, dibh->b_data);
+	gfs2_dinode_out(ip, dibh->b_data);
 	brelse(dibh);
 
 out_end_trans:
@@ -970,7 +970,7 @@ static int trunc_start(struct gfs2_inode
 		ip->i_di.di_size = size;
 		ip->i_di.di_mtime = ip->i_di.di_ctime = get_seconds();
 		gfs2_trans_add_bh(ip->i_gl, dibh, 1);
-		gfs2_dinode_out(&ip->i_di, dibh->b_data);
+		gfs2_dinode_out(ip, dibh->b_data);
 		gfs2_buffer_clear_tail(dibh, sizeof(struct gfs2_dinode) + size);
 		error = 1;
 
@@ -983,7 +983,7 @@ static int trunc_start(struct gfs2_inode
 			ip->i_di.di_mtime = ip->i_di.di_ctime = get_seconds();
 			ip->i_di.di_flags |= GFS2_DIF_TRUNC_IN_PROG;
 			gfs2_trans_add_bh(ip->i_gl, dibh, 1);
-			gfs2_dinode_out(&ip->i_di, dibh->b_data);
+			gfs2_dinode_out(ip, dibh->b_data);
 		}
 	}
 
@@ -1057,7 +1057,7 @@ static int trunc_end(struct gfs2_inode *
 	ip->i_di.di_flags &= ~GFS2_DIF_TRUNC_IN_PROG;
 
 	gfs2_trans_add_bh(ip->i_gl, dibh, 1);
-	gfs2_dinode_out(&ip->i_di, dibh->b_data);
+	gfs2_dinode_out(ip, dibh->b_data);
 	brelse(dibh);
 
 out:
diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 59dc823..0742761 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -132,7 +132,7 @@ static int gfs2_dir_write_stuffed(struct
 	if (ip->i_di.di_size < offset + size)
 		ip->i_di.di_size = offset + size;
 	ip->i_di.di_mtime = ip->i_di.di_ctime = get_seconds();
-	gfs2_dinode_out(&ip->i_di, dibh->b_data);
+	gfs2_dinode_out(ip, dibh->b_data);
 
 	brelse(dibh);
 
@@ -232,7 +232,7 @@ out:
 	ip->i_di.di_mtime = ip->i_di.di_ctime = get_seconds();
 
 	gfs2_trans_add_bh(ip->i_gl, dibh, 1);
-	gfs2_dinode_out(&ip->i_di, dibh->b_data);
+	gfs2_dinode_out(ip, dibh->b_data);
 	brelse(dibh);
 
 	return copied;
@@ -907,7 +907,7 @@ static int dir_make_exhash(struct inode 
 	for (x = sdp->sd_hash_ptrs, y = -1; x; x >>= 1, y++) ;
 	dip->i_di.di_depth = y;
 
-	gfs2_dinode_out(&dip->i_di, dibh->b_data);
+	gfs2_dinode_out(dip, dibh->b_data);
 
 	brelse(dibh);
 
@@ -1039,7 +1039,7 @@ static int dir_split_leaf(struct inode *
 	error = gfs2_meta_inode_buffer(dip, &dibh);
 	if (!gfs2_assert_withdraw(GFS2_SB(&dip->i_inode), !error)) {
 		dip->i_di.di_blocks++;
-		gfs2_dinode_out(&dip->i_di, dibh->b_data);
+		gfs2_dinode_out(dip, dibh->b_data);
 		brelse(dibh);
 	}
 
@@ -1119,7 +1119,7 @@ static int dir_double_exhash(struct gfs2
 	error = gfs2_meta_inode_buffer(dip, &dibh);
 	if (!gfs2_assert_withdraw(sdp, !error)) {
 		dip->i_di.di_depth++;
-		gfs2_dinode_out(&dip->i_di, dibh->b_data);
+		gfs2_dinode_out(dip, dibh->b_data);
 		brelse(dibh);
 	}
 
@@ -1517,7 +1517,7 @@ static int dir_new_leaf(struct inode *in
 		return error;
 	gfs2_trans_add_bh(ip->i_gl, bh, 1);
 	ip->i_di.di_blocks++;
-	gfs2_dinode_out(&ip->i_di, bh->b_data);
+	gfs2_dinode_out(ip, bh->b_data);
 	brelse(bh);
 	return 0;
 }
@@ -1561,7 +1561,7 @@ int gfs2_dir_add(struct inode *inode, co
 			gfs2_trans_add_bh(ip->i_gl, bh, 1);
 			ip->i_di.di_entries++;
 			ip->i_di.di_mtime = ip->i_di.di_ctime = get_seconds();
-			gfs2_dinode_out(&ip->i_di, bh->b_data);
+			gfs2_dinode_out(ip, bh->b_data);
 			brelse(bh);
 			error = 0;
 			break;
@@ -1647,7 +1647,7 @@ int gfs2_dir_del(struct gfs2_inode *dip,
 	gfs2_trans_add_bh(dip->i_gl, bh, 1);
 	dip->i_di.di_entries--;
 	dip->i_di.di_mtime = dip->i_di.di_ctime = get_seconds();
-	gfs2_dinode_out(&dip->i_di, bh->b_data);
+	gfs2_dinode_out(dip, bh->b_data);
 	brelse(bh);
 	mark_inode_dirty(&dip->i_inode);
 
@@ -1695,7 +1695,7 @@ int gfs2_dir_mvino(struct gfs2_inode *di
 	}
 
 	dip->i_di.di_mtime = dip->i_di.di_ctime = get_seconds();
-	gfs2_dinode_out(&dip->i_di, bh->b_data);
+	gfs2_dinode_out(dip, bh->b_data);
 	brelse(bh);
 	return 0;
 }
@@ -1875,7 +1875,7 @@ static int leaf_dealloc(struct gfs2_inod
 		goto out_end_trans;
 
 	gfs2_trans_add_bh(dip->i_gl, dibh, 1);
-	gfs2_dinode_out(&dip->i_di, dibh->b_data);
+	gfs2_dinode_out(dip, dibh->b_data);
 	brelse(dibh);
 
 out_end_trans:
diff --git a/fs/gfs2/eattr.c b/fs/gfs2/eattr.c
index 518f0c0..9b7bb56 100644
--- a/fs/gfs2/eattr.c
+++ b/fs/gfs2/eattr.c
@@ -302,7 +302,7 @@ static int ea_dealloc_unstuffed(struct g
 	if (!error) {
 		ip->i_di.di_ctime = get_seconds();
 		gfs2_trans_add_bh(ip->i_gl, dibh, 1);
-		gfs2_dinode_out(&ip->i_di, dibh->b_data);
+		gfs2_dinode_out(ip, dibh->b_data);
 		brelse(dibh);
 	}
 
@@ -717,7 +717,7 @@ static int ea_alloc_skeleton(struct gfs2
 		}
 		ip->i_di.di_ctime = get_seconds();
 		gfs2_trans_add_bh(ip->i_gl, dibh, 1);
-		gfs2_dinode_out(&ip->i_di, dibh->b_data);
+		gfs2_dinode_out(ip, dibh->b_data);
 		brelse(dibh);
 	}
 
@@ -852,7 +852,7 @@ static int ea_set_simple_noalloc(struct 
 	}
 	ip->i_di.di_ctime = get_seconds();
 	gfs2_trans_add_bh(ip->i_gl, dibh, 1);
-	gfs2_dinode_out(&ip->i_di, dibh->b_data);
+	gfs2_dinode_out(ip, dibh->b_data);
 	brelse(dibh);
 out:
 	gfs2_trans_end(GFS2_SB(&ip->i_inode));
@@ -1132,7 +1132,7 @@ static int ea_remove_stuffed(struct gfs2
 	if (!error) {
 		ip->i_di.di_ctime = get_seconds();
 		gfs2_trans_add_bh(ip->i_gl, dibh, 1);
-		gfs2_dinode_out(&ip->i_di, dibh->b_data);
+		gfs2_dinode_out(ip, dibh->b_data);
 		brelse(dibh);
 	}
 
@@ -1287,7 +1287,7 @@ int gfs2_ea_acl_chmod(struct gfs2_inode 
 		gfs2_assert_warn(GFS2_SB(&ip->i_inode), !error);
 		gfs2_inode_attr_out(ip);
 		gfs2_trans_add_bh(ip->i_gl, dibh, 1);
-		gfs2_dinode_out(&ip->i_di, dibh->b_data);
+		gfs2_dinode_out(ip, dibh->b_data);
 		brelse(dibh);
 	}
 
@@ -1397,7 +1397,7 @@ static int ea_dealloc_indirect(struct gf
 	error = gfs2_meta_inode_buffer(ip, &dibh);
 	if (!error) {
 		gfs2_trans_add_bh(ip->i_gl, dibh, 1);
-		gfs2_dinode_out(&ip->i_di, dibh->b_data);
+		gfs2_dinode_out(ip, dibh->b_data);
 		brelse(dibh);
 	}
 
@@ -1446,7 +1446,7 @@ static int ea_dealloc_block(struct gfs2_
 	error = gfs2_meta_inode_buffer(ip, &dibh);
 	if (!error) {
 		gfs2_trans_add_bh(ip->i_gl, dibh, 1);
-		gfs2_dinode_out(&ip->i_di, dibh->b_data);
+		gfs2_dinode_out(ip, dibh->b_data);
 		brelse(dibh);
 	}
 
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index fb96930..b861ddb 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -338,7 +338,7 @@ int gfs2_change_nlink(struct gfs2_inode 
 	ip->i_inode.i_nlink = nlink;
 
 	gfs2_trans_add_bh(ip->i_gl, dibh, 1);
-	gfs2_dinode_out(&ip->i_di, dibh->b_data);
+	gfs2_dinode_out(ip, dibh->b_data);
 	brelse(dibh);
 	mark_inode_dirty(&ip->i_inode);
 
@@ -792,7 +792,7 @@ static int link_dinode(struct gfs2_inode
 		goto fail_end_trans;
 	ip->i_di.di_nlink = 1;
 	gfs2_trans_add_bh(ip->i_gl, dibh, 1);
-	gfs2_dinode_out(&ip->i_di, dibh->b_data);
+	gfs2_dinode_out(ip, dibh->b_data);
 	brelse(dibh);
 	return 0;
 
@@ -1349,7 +1349,7 @@ __gfs2_setattr_simple(struct gfs2_inode 
 		gfs2_inode_attr_out(ip);
 
 		gfs2_trans_add_bh(ip->i_gl, dibh, 1);
-		gfs2_dinode_out(&ip->i_di, dibh->b_data);
+		gfs2_dinode_out(ip, dibh->b_data);
 		brelse(dibh);
 	}
 	return error;
diff --git a/fs/gfs2/ondisk.c b/fs/gfs2/ondisk.c
index 2d1682d..2c50fa0 100644
--- a/fs/gfs2/ondisk.c
+++ b/fs/gfs2/ondisk.c
@@ -15,6 +15,8 @@ #include <linux/buffer_head.h>
 
 #include "gfs2.h"
 #include <linux/gfs2_ondisk.h>
+#include <linux/lm_interface.h>
+#include "incore.h"
 
 #define pv(struct, member, fmt) printk(KERN_INFO "  "#member" = "fmt"\n", \
 				       struct->member);
@@ -187,8 +189,9 @@ void gfs2_dinode_in(struct gfs2_dinode_h
 
 }
 
-void gfs2_dinode_out(const struct gfs2_dinode_host *di, void *buf)
+void gfs2_dinode_out(const struct gfs2_inode *ip, void *buf)
 {
+	const struct gfs2_dinode_host *di = &ip->i_di;
 	struct gfs2_dinode *str = buf;
 
 	gfs2_meta_header_out(&di->di_header, buf);
diff --git a/fs/gfs2/ops_file.c b/fs/gfs2/ops_file.c
index 2fc8868..7ea4175 100644
--- a/fs/gfs2/ops_file.c
+++ b/fs/gfs2/ops_file.c
@@ -336,7 +336,7 @@ static int do_gfs2_set_flags(struct file
 		goto out_trans_end;
 	gfs2_trans_add_bh(ip->i_gl, bh, 1);
 	ip->i_di.di_flags = new_flags;
-	gfs2_dinode_out(&ip->i_di, bh->b_data);
+	gfs2_dinode_out(ip, bh->b_data);
 	brelse(bh);
 out_trans_end:
 	gfs2_trans_end(sdp);
diff --git a/fs/gfs2/ops_inode.c b/fs/gfs2/ops_inode.c
index ef6e5ed..bd26885 100644
--- a/fs/gfs2/ops_inode.c
+++ b/fs/gfs2/ops_inode.c
@@ -339,7 +339,7 @@ static int gfs2_symlink(struct inode *di
 	error = gfs2_meta_inode_buffer(ip, &dibh);
 
 	if (!gfs2_assert_withdraw(sdp, !error)) {
-		gfs2_dinode_out(&ip->i_di, dibh->b_data);
+		gfs2_dinode_out(ip, dibh->b_data);
 		memcpy(dibh->b_data + sizeof(struct gfs2_dinode), symname,
 		       size);
 		brelse(dibh);
@@ -414,7 +414,7 @@ static int gfs2_mkdir(struct inode *dir,
 		gfs2_inum_out(&dip->i_num, &dent->de_inum);
 		dent->de_type = cpu_to_be16(DT_DIR);
 
-		gfs2_dinode_out(&ip->i_di, di);
+		gfs2_dinode_out(ip, di);
 
 		brelse(dibh);
 	}
@@ -541,7 +541,7 @@ static int gfs2_mknod(struct inode *dir,
 	error = gfs2_meta_inode_buffer(ip, &dibh);
 
 	if (!gfs2_assert_withdraw(sdp, !error)) {
-		gfs2_dinode_out(&ip->i_di, dibh->b_data);
+		gfs2_dinode_out(ip, dibh->b_data);
 		brelse(dibh);
 	}
 
@@ -762,7 +762,7 @@ static int gfs2_rename(struct inode *odi
 			goto out_end_trans;
 		ip->i_di.di_ctime = get_seconds();
 		gfs2_trans_add_bh(ip->i_gl, dibh, 1);
-		gfs2_dinode_out(&ip->i_di, dibh->b_data);
+		gfs2_dinode_out(ip, dibh->b_data);
 		brelse(dibh);
 	}
 
@@ -949,7 +949,7 @@ static int setattr_chown(struct inode *i
 	gfs2_inode_attr_out(ip);
 
 	gfs2_trans_add_bh(ip->i_gl, dibh, 1);
-	gfs2_dinode_out(&ip->i_di, dibh->b_data);
+	gfs2_dinode_out(ip, dibh->b_data);
 	brelse(dibh);
 
 	if (ouid != NO_QUOTA_CHANGE || ogid != NO_QUOTA_CHANGE) {
diff --git a/include/linux/gfs2_ondisk.h b/include/linux/gfs2_ondisk.h
index 10a507d..550effa 100644
--- a/include/linux/gfs2_ondisk.h
+++ b/include/linux/gfs2_ondisk.h
@@ -535,7 +535,8 @@ extern void gfs2_rgrp_in(struct gfs2_rgr
 extern void gfs2_rgrp_out(const struct gfs2_rgrp_host *rg, void *buf);
 extern void gfs2_quota_in(struct gfs2_quota_host *qu, const void *buf);
 extern void gfs2_dinode_in(struct gfs2_dinode_host *di, const void *buf);
-extern void gfs2_dinode_out(const struct gfs2_dinode_host *di, void *buf);
+struct gfs2_inode;
+extern void gfs2_dinode_out(const struct gfs2_inode *ip, void *buf);
 extern void gfs2_ea_header_in(struct gfs2_ea_header *ea, const void *buf);
 extern void gfs2_ea_header_out(const struct gfs2_ea_header *ea, void *buf);
 extern void gfs2_log_header_in(struct gfs2_log_header_host *lh, const void *buf);
-- 
1.4.1



