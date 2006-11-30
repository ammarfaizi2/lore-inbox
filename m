Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936398AbWK3MZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936398AbWK3MZO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936379AbWK3MZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:25:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49296 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936368AbWK3MYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:24:48 -0500
Subject: [GFS2] Remove gfs2_check_acl() [67/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Adrian Bunk <bunk@stusta.de>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:23:39 +0000
Message-Id: <1164889419.3752.443.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 77386e1f662f104680da7885d32e068e4b11b882 Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Wed, 29 Nov 2006 10:41:49 -0500
Subject: [PATCH] [GFS2] Remove gfs2_check_acl()

As pointed out by Adrian Bunk, the gfs2_check_acl() function is no
longer used. This patch removes it and renamed gfs2_check_acl_locked()
to gfs2_check_acl() since we only need one variant of that function now.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
Cc: Adrian Bunk <bunk@stusta.de>
---
 fs/gfs2/acl.c       |   19 ++-----------------
 fs/gfs2/acl.h       |    1 -
 fs/gfs2/ops_inode.c |    2 +-
 3 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/fs/gfs2/acl.c b/fs/gfs2/acl.c
index 3908992..6e80844 100644
--- a/fs/gfs2/acl.c
+++ b/fs/gfs2/acl.c
@@ -145,14 +145,14 @@ out:
 }
 
 /**
- * gfs2_check_acl_locked - Check an ACL to see if we're allowed to do something
+ * gfs2_check_acl - Check an ACL to see if we're allowed to do something
  * @inode: the file we want to do something to
  * @mask: what we want to do
  *
  * Returns: errno
  */
 
-int gfs2_check_acl_locked(struct inode *inode, int mask)
+int gfs2_check_acl(struct inode *inode, int mask)
 {
 	struct posix_acl *acl = NULL;
 	int error;
@@ -170,21 +170,6 @@ int gfs2_check_acl_locked(struct inode *
 	return -EAGAIN;
 }
 
-int gfs2_check_acl(struct inode *inode, int mask)
-{
-	struct gfs2_inode *ip = GFS2_I(inode);
-	struct gfs2_holder i_gh;
-	int error;
-
-	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY, &i_gh);
-	if (!error) {
-		error = gfs2_check_acl_locked(inode, mask);
-		gfs2_glock_dq_uninit(&i_gh);
-	}
-
-	return error;
-}
-
 static int munge_mode(struct gfs2_inode *ip, mode_t mode)
 {
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
diff --git a/fs/gfs2/acl.h b/fs/gfs2/acl.h
index 05c294f..6751930 100644
--- a/fs/gfs2/acl.h
+++ b/fs/gfs2/acl.h
@@ -31,7 +31,6 @@ int gfs2_acl_validate_set(struct gfs2_in
 			  struct gfs2_ea_request *er,
 			  int *remove, mode_t *mode);
 int gfs2_acl_validate_remove(struct gfs2_inode *ip, int access);
-int gfs2_check_acl_locked(struct inode *inode, int mask);
 int gfs2_check_acl(struct inode *inode, int mask);
 int gfs2_acl_create(struct gfs2_inode *dip, struct gfs2_inode *ip);
 int gfs2_acl_chmod(struct gfs2_inode *ip, struct iattr *attr);
diff --git a/fs/gfs2/ops_inode.c b/fs/gfs2/ops_inode.c
index fbe38c1..636dda4 100644
--- a/fs/gfs2/ops_inode.c
+++ b/fs/gfs2/ops_inode.c
@@ -856,7 +856,7 @@ static int gfs2_permission(struct inode 
 		unlock = 1;
 	}
 
-	error = generic_permission(inode, mask, gfs2_check_acl_locked);
+	error = generic_permission(inode, mask, gfs2_check_acl);
 	if (unlock)
 		gfs2_glock_dq_uninit(&i_gh);
 
-- 
1.4.1



