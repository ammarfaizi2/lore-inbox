Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbWDYIkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWDYIkJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 04:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWDYIkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 04:40:09 -0400
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:10644 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751448AbWDYIkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 04:40:07 -0400
To: torvalds@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <E1FYJ0r-0006Tv-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Tue, 25 Apr 2006 10:35:13 +0200)
Subject: [PATCH 3/4] [fuse] fix race between checking and setting file->private_data
References: <E1FYJ0r-0006Tv-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1FYJ5M-0006VC-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 25 Apr 2006 10:39:52 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BKL does not protect against races if the task may sleep between
checking and setting a value.  So move checking of file->private_data
near to setting it in fuse_fill_super().

Found by Al Viro.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

---

 fs/fuse/inode.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

2e6c033a9b3a0e8b191b8d916364562a442c3955
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index fd34037..7627022 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -500,11 +500,6 @@ static int fuse_fill_super(struct super_
 	if (file->f_op != &fuse_dev_operations)
 		return -EINVAL;
 
-	/* Setting file->private_data can't race with other mount()
-	   instances, since BKL is held for ->get_sb() */
-	if (file->private_data)
-		return -EINVAL;
-
 	fc = new_conn();
 	if (!fc)
 		return -ENOMEM;
@@ -540,6 +535,12 @@ static int fuse_fill_super(struct super_
 	if (err)
 		goto err_free_req;
 
+	/* Setting file->private_data can't race with other mount()
+	   instances, since BKL is held for ->get_sb() */
+	err = -EINVAL;
+	if (file->private_data)
+		goto err_kobject_del;
+
 	sb->s_root = root_dentry;
 	fc->mounted = 1;
 	fc->connected = 1;
@@ -556,6 +557,8 @@ static int fuse_fill_super(struct super_
 
 	return 0;
 
+ err_kobject_del:
+	kobject_del(&fc->kobj);
  err_free_req:
 	fuse_request_free(init_req);
  err_put_root:
-- 
1.2.4

