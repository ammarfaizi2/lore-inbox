Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWG2XRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWG2XRU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 19:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWG2XRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 19:17:20 -0400
Received: from hera.kernel.org ([140.211.167.34]:41625 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750754AbWG2XRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 19:17:19 -0400
Date: Sat, 29 Jul 2006 23:16:34 GMT
From: Eric Van Hensbergen <ericvh@hera.kernel.org>
Message-Id: <200607292316.k6TNGYDS017029@hera.kernel.org>
To: akpm@osdl.org
Subject: [PATCH] 9p: fix fid behavior on failed remove
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       ericvh@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 188a447b579a96ef485ee6911f0e6f7d520f896a Mon Sep 17 00:00:00 2001
From: Eric Van Hensbergen <ericvh@gmail.com>
Date: Sat, 29 Jul 2006 18:13:49 -0500
Subject: [PATCH] 9p: fix fid behavior on failed remove

Fix fid behavior on failed remove.

Based on a bug report from Russ Ross <russruss@gmail.com>

According to the spec:

"The remove request asks the file server both to remove the file
 represented by fid and to clunk the fid, even if the remove fails."

but the Linux client seems to expect the fid to be valid after a
failed remove attempt.  Specifically, I'm getting this behavior when
attempting to remove a non-empty directory.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>
---
 fs/9p/vfs_inode.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 61ce38d..91a0ea5 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -433,10 +433,10 @@ static int v9fs_remove(struct inode *dir
 	result = v9fs_t_remove(v9ses, fid, &fcall);
 	if (result < 0) {
 		PRINT_FCALL_ERROR("remove fails", fcall);
-	} else {
-		v9fs_put_idpool(fid, &v9ses->fidpool);
-		v9fs_fid_destroy(v9fid);
-	}
+	} 
+
+	v9fs_put_idpool(fid, &v9ses->fidpool);
+	v9fs_fid_destroy(v9fid);
 
 	kfree(fcall);
 	return result;
-- 
1.4.2.rc1.g83e1

