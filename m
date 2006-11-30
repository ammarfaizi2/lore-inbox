Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936374AbWK3MWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936374AbWK3MWl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936372AbWK3MWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:22:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46478 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936375AbWK3MWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:22:37 -0500
Subject: [GFS2] Fix recursive locking in gfs2_permission [59/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:22:19 +0000
Message-Id: <1164889339.3752.423.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 300c7d75f3a5e8edd3e390ccd56b808f3fb14e33 Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Mon, 27 Nov 2006 09:55:28 -0500
Subject: [PATCH] [GFS2] Fix recursive locking in gfs2_permission

Since gfs2_permission may be called either from the VFS (in which case
we need to obtain a shared glock) or from GFS2 (in which case we already
have a glock) we need to test to see whether or not a lock is required.
The original test was buggy due to a potential race. This one should
be safe.

This fixes Red Hat bugzilla #217129

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/ops_inode.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/gfs2/ops_inode.c b/fs/gfs2/ops_inode.c
index b247f25..fd9fee2 100644
--- a/fs/gfs2/ops_inode.c
+++ b/fs/gfs2/ops_inode.c
@@ -835,6 +835,10 @@ static void *gfs2_follow_link(struct den
  * @mask:
  * @nd: passed from Linux VFS, ignored by us
  *
+ * This may be called from the VFS directly, or from within GFS2 with the
+ * inode locked, so we look to see if the glock is already locked and only
+ * lock the glock if its not already been done.
+ *
  * Returns: errno
  */
 
@@ -843,15 +847,18 @@ static int gfs2_permission(struct inode 
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_holder i_gh;
 	int error;
+	int unlock = 0;
 
-	if (!test_bit(GIF_INVALID, &ip->i_flags))
-		return generic_permission(inode, mask, gfs2_check_acl);
+	if (gfs2_glock_is_locked_by_me(ip->i_gl) == 0) {
+		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY, &i_gh);
+		if (error)
+			return error;
+		unlock = 1;
+	}
 
-	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY, &i_gh);
-	if (!error) {
-		error = generic_permission(inode, mask, gfs2_check_acl_locked);
+	error = generic_permission(inode, mask, gfs2_check_acl_locked);
+	if (unlock)
 		gfs2_glock_dq_uninit(&i_gh);
-	}
 
 	return error;
 }
-- 
1.4.1



