Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWDCAZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWDCAZU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 20:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbWDCAZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 20:25:20 -0400
Received: from hera.kernel.org ([140.211.167.34]:5042 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932157AbWDCAZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 20:25:18 -0400
Date: Mon, 3 Apr 2006 00:25:03 GMT
From: Eric Van Hensbergen <ericvh@hera.kernel.org>
Message-Id: <200604030025.k330P30m023809@hera.kernel.org>
To: akpm@osdl.org
Subject: [PATCH] 9p: handle sget() failure
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       ericvh@gmail.com, hch@lst.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Handle a failing sget() in v9fs_get_sb().

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---

 fs/9p/vfs_super.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

fc6530fb690a8a7b2cd9f5581debcf0f7d98074d
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index b0a0ae5..61c599b 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -127,12 +127,13 @@ static struct super_block *v9fs_get_sb(s
 
 	if ((newfid = v9fs_session_init(v9ses, dev_name, data)) < 0) {
 		dprintk(DEBUG_ERROR, "problem initiating session\n");
-		kfree(v9ses);
-		return ERR_PTR(newfid);
+		sb = ERR_PTR(newfid);
+		goto out_free_session;
 	}
 
 	sb = sget(fs_type, NULL, v9fs_set_super, v9ses);
-
+	if (IS_ERR(sb))
+		goto out_close_session;
 	v9fs_fill_super(sb, v9ses, flags);
 
 	inode = v9fs_get_inode(sb, S_IFDIR | mode);
@@ -185,6 +186,12 @@ static struct super_block *v9fs_get_sb(s
 
 	return sb;
 
+out_close_session:
+	v9fs_session_close(v9ses);
+out_free_session:
+	kfree(v9ses);
+	return sb;
+
 put_back_sb:
 	/* deactivate_super calls v9fs_kill_super which will frees the rest */
 	up_write(&sb->s_umount);
-- 
1.2.GIT

