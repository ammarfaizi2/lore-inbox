Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWAEAxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWAEAxe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWAEAww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:52:52 -0500
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:48792 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751050AbWAEAwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:52:37 -0500
Date: Wed, 4 Jan 2006 19:56:40 -0500
From: Latchesar Ionkov <lucho@ionkov.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: [PATCH 2/3] v9fs: fix fid management in v9fs_create
Message-ID: <20060105005640.GB27375@ionkov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

v9fs_create doesn't manage correctly the fids when it is called to create a
directory.. The fid created by the create 9P call (newfid) and the one
created by walking to already created file (wfidno) are not used
consistently.

This patch cleans up the usage of newfid and wfidno.

Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>

---

 fs/9p/vfs_inode.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

6e8f41a184e17e096c78a7d248add06afae4759a
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 466002a..f11edde 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -385,13 +385,14 @@ v9fs_create(struct inode *dir,
 		fid->iounit = iounit;
 	} else {
 		err = v9fs_t_clunk(v9ses, newfid);
+		newfid = -1;
 		if (err < 0)
 			dprintk(DEBUG_ERROR, "clunk for mkdir failed: %d\n", err);
 	}
 
 	/* walk to the newly created file and put the fid in the dentry */
 	wfidno = v9fs_get_idpool(&v9ses->fidpool);
-	if (newfid < 0) {
+	if (wfidno < 0) {
 		eprintk(KERN_WARNING, "no free fids available\n");
 		return -ENOSPC;
 	}
@@ -408,7 +409,6 @@ v9fs_create(struct inode *dir,
 	fcall = NULL;
 
 	if (!v9fs_fid_create(file_dentry, v9ses, wfidno, 0)) {
-		v9fs_t_clunk(v9ses, newfid);
 		v9fs_put_idpool(wfidno, &v9ses->fidpool);
 
 		goto CleanUpFid;
@@ -419,7 +419,7 @@ v9fs_create(struct inode *dir,
 	    (perm & V9FS_DMDEVICE))
 		return 0;
 
-	result = v9fs_t_stat(v9ses, newfid, &fcall);
+	result = v9fs_t_stat(v9ses, wfidno, &fcall);
 	if (result < 0) {
 		dprintk(DEBUG_ERROR, "stat error: %s(%d)\n", FCALL_ERROR(fcall),
 			result);
-- 
1.0.6
