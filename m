Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWB0EMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWB0EMn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 23:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWB0EMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 23:12:43 -0500
Received: from cpe-70-112-167-32.austin.res.rr.com ([70.112.167.32]:55948 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751273AbWB0EMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 23:12:42 -0500
To: akpm@osdl.org
Subject: [PATCH 2/3] v9fs: fix bug in atomic create open fix
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       ericvh@gmail.com
Message-Id: <20060227041255.A9B375A8075@localhost.localdomain>
Date: Sun, 26 Feb 2006 22:12:55 -0600 (CST)
From: ericvh@gmail.com (Eric Van Hensbergen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] v9fs: Fix lucho's atomic create+open

Lucho's atomic create+open fix had a bug in the super block initialization
causing all mounts to fail.  He was freeing an fcall too early.  This patch
fixes that oversight.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---

 fs/9p/vfs_super.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

40d713812e51d2dbca49a3db8ca802f373b71f51
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -160,7 +160,6 @@ static struct super_block *v9fs_get_sb(s
 		v9fs_t_clunk(v9ses, newfid);
 	} else {
 		/* Setup the Root Inode */
-		kfree(fcall);
 		root_fid = v9fs_fid_create(v9ses, newfid);
 		if (root_fid == NULL) {
 			retval = -ENOMEM;
@@ -168,8 +167,10 @@ static struct super_block *v9fs_get_sb(s
 		}
 
 		retval = v9fs_fid_insert(root_fid, root);
-		if (retval < 0)
+		if (retval < 0) {
+			kfree(fcall);
 			goto put_back_sb;
+		}
 
 		root_fid->qid = fcall->params.rstat.stat.qid;
 		root->d_inode->i_ino =
@@ -177,6 +178,8 @@ static struct super_block *v9fs_get_sb(s
 		v9fs_stat2inode(&fcall->params.rstat.stat, root->d_inode, sb);
 	}
 
+	kfree(fcall);
+
 	if (stat_result < 0) {
 		retval = stat_result;
 		goto put_back_sb;
