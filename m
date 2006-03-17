Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbWCQTK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbWCQTK4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 14:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbWCQTK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 14:10:56 -0500
Received: from hera.kernel.org ([140.211.167.34]:44697 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030267AbWCQTKz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 14:10:55 -0500
Date: Fri, 17 Mar 2006 19:10:27 GMT
From: Eric Van Hensbergen <ericvh@hera.kernel.org>
Message-Id: <200603171910.k2HJARgO006427@hera.kernel.org>
To: akpm@osdl.org
Subject: [PATCH] v9fs: assign dentry ops to negative dentries
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       ericvh@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] assign dentry ops to negative dentries
From: Latchesar Ionkov <lucho@ionkov.net>
Date: 1142219619 -0500

If a file is not found in v9fs_vfs_lookup, the function creates negative
dentry, but doesn't assign any dentry ops. This leaves the negative entry
in the cache (there is no d_delete to mark it for removal). If the file is
created outside of the mounted v9fs filesystem, the file shows up in the
directory with weird permissions.

This patch assigns the default v9fs dentry ops to the negative dentry.

Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>
Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---

 fs/9p/vfs_inode.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

1c2ced3fa5281cc5f96272186c8f180b8e2823c8
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 3438e6a..d3c4cd4 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -614,6 +614,7 @@ static struct dentry *v9fs_vfs_lookup(st
 
 	sb = dir->i_sb;
 	v9ses = v9fs_inode2v9ses(dir);
+	dentry->d_op = &v9fs_dentry_operations;
 	dirfid = v9fs_fid_lookup(dentry->d_parent);
 
 	if (!dirfid) {
@@ -681,8 +682,6 @@ static struct dentry *v9fs_vfs_lookup(st
 		goto FreeFcall;
 
 	fid->qid = fcall->params.rstat.stat.qid;
-
-	dentry->d_op = &v9fs_dentry_operations;
 	v9fs_stat2inode(&fcall->params.rstat.stat, inode, inode->i_sb);
 
 	d_add(dentry, inode);
-- 
1.1.0
