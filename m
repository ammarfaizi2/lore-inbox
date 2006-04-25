Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbWDYIjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWDYIjP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 04:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWDYIjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 04:39:15 -0400
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:10132 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751436AbWDYIjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 04:39:14 -0400
To: torvalds@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <E1FYJ0r-0006Tv-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Tue, 25 Apr 2006 10:35:13 +0200)
Subject: [PATCH 2/4] [fuse] fix deadlock between fuse_put_super() and request_end()
References: <E1FYJ0r-0006Tv-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1FYJ4W-0006Ux-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 25 Apr 2006 10:39:00 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A deadlock was possible, when the last reference to the superblock was
held due to a background request containing a file reference.

Releasing the file would release the vfsmount which in turn would
release the superblock.  Since sbput_sem is held during the fput() and
fuse_put_super() tries to acquire this same semaphore, a deadlock
results.

The solution is to move the fput() outside the region protected by
sbput_sem.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

---

 fs/fuse/dev.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

cdea55d00688ed9a494345b131521a2cae36d42a
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 4967bd4..104a62d 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -128,12 +128,16 @@ void fuse_put_request(struct fuse_conn *
 	}
 }
 
+/*
+ * Called with sbput_sem held for read (request_end) or write
+ * (fuse_put_super).  By the time fuse_put_super() is finished, all
+ * inodes belonging to background requests must be released, so the
+ * iputs have to be done within the locked region.
+ */
 void fuse_release_background(struct fuse_conn *fc, struct fuse_req *req)
 {
 	iput(req->inode);
 	iput(req->inode2);
-	if (req->file)
-		fput(req->file);
 	spin_lock(&fc->lock);
 	list_del(&req->bg_entry);
 	if (fc->num_background == FUSE_MAX_BACKGROUND) {
@@ -178,6 +182,11 @@ static void request_end(struct fuse_conn
 		if (fc->mounted)
 			fuse_release_background(fc, req);
 		up_read(&fc->sbput_sem);
+
+		/* fput must go outside sbput_sem, otherwise it can deadlock */
+		if (req->file)
+			fput(req->file);
+
 		if (end)
 			end(fc, req);
 		else
-- 
1.2.4

