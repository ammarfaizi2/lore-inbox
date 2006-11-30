Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936373AbWK3M1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936373AbWK3M1k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936380AbWK3MWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:22:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52878 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936373AbWK3MWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:22:46 -0500
Subject: [GFS2] Fix recursive locking in gfs2_getattr [60/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:22:24 +0000
Message-Id: <1164889344.3752.425.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From dcf3dd852f554bb0016aa23892596717cc123a26 Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Mon, 27 Nov 2006 10:12:05 -0500
Subject: [PATCH] [GFS2] Fix recursive locking in gfs2_getattr

The readdirplus NFS operation can result in gfs2_getattr being
called with the glock already held. In this case we do not want
to try and grab the lock again.

This fixes Red Hat bugzilla #215727

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/ops_inode.c |   22 +++++++++++++++++-----
 1 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/ops_inode.c b/fs/gfs2/ops_inode.c
index fd9fee2..fbe38c1 100644
--- a/fs/gfs2/ops_inode.c
+++ b/fs/gfs2/ops_inode.c
@@ -992,6 +992,12 @@ out:
  * @dentry: The dentry to stat
  * @stat: The inode's stats
  *
+ * This may be called from the VFS directly, or from within GFS2 with the
+ * inode locked, so we look to see if the glock is already locked and only
+ * lock the glock if its not already been done. Note that its the NFS
+ * readdirplus operation which causes this to be called (from filldir)
+ * with the glock already held.
+ *
  * Returns: errno
  */
 
@@ -1002,14 +1008,20 @@ static int gfs2_getattr(struct vfsmount 
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_holder gh;
 	int error;
+	int unlock = 0;
 
-	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY, &gh);
-	if (!error) {
-		generic_fillattr(inode, stat);
-		gfs2_glock_dq_uninit(&gh);
+	if (gfs2_glock_is_locked_by_me(ip->i_gl) == 0) {
+		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY, &gh);
+		if (error)
+			return error;
+		unlock = 1;
 	}
 
-	return error;
+	generic_fillattr(inode, stat);
+	if (unlock);
+		gfs2_glock_dq_uninit(&gh);
+
+	return 0;
 }
 
 static int gfs2_setxattr(struct dentry *dentry, const char *name,
-- 
1.4.1



