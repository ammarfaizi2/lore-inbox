Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936384AbWK3MYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936384AbWK3MYm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936366AbWK3MYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:24:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14992 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936379AbWK3MYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:24:14 -0500
Subject: [GFS2] Don't flush everything on fdatasync [70/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:24:08 +0000
Message-Id: <1164889448.3752.449.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 33c3de32872ef3c075e4dac04c0de8f86ac39f6f Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Thu, 30 Nov 2006 10:14:32 -0500
Subject: [PATCH] [GFS2] Don't flush everything on fdatasync

The gfs2_fsync() function was doing a journal flush on each
and every call. While this is correct, its also a lot of
overhead. This patch means that on fdatasync flushes we
rely on the VFS to flush the data for us and we don't do
a journal flush unless we really need to.

We have to do a journal flush for stuffed files though because
they have the data and the inode metadata in the same block.
Journaled files also need a journal flush too of course.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/ops_file.c |   30 +++++++++++++++++++++++++++---
 1 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/ops_file.c b/fs/gfs2/ops_file.c
index c2be216..7bd971b 100644
--- a/fs/gfs2/ops_file.c
+++ b/fs/gfs2/ops_file.c
@@ -22,6 +22,7 @@ #include <linux/gfs2_ondisk.h>
 #include <linux/ext2_fs.h>
 #include <linux/crc32.h>
 #include <linux/lm_interface.h>
+#include <linux/writeback.h>
 #include <asm/uaccess.h>
 
 #include "gfs2.h"
@@ -503,16 +504,39 @@ static int gfs2_close(struct inode *inod
  * @file: the file that points to the dentry (we ignore this)
  * @dentry: the dentry that points to the inode to sync
  *
+ * The VFS will flush "normal" data for us. We only need to worry
+ * about metadata here. For journaled data, we just do a log flush
+ * as we can't avoid it. Otherwise we can just bale out if datasync
+ * is set. For stuffed inodes we must flush the log in order to
+ * ensure that all data is on disk.
+ *
  * Returns: errno
  */
 
 static int gfs2_fsync(struct file *file, struct dentry *dentry, int datasync)
 {
-	struct gfs2_inode *ip = GFS2_I(dentry->d_inode);
+	struct inode *inode = dentry->d_inode;
+	int sync_state = inode->i_state & (I_DIRTY_SYNC|I_DIRTY_DATASYNC);
+	int ret = 0;
+	struct writeback_control wbc = {
+		.sync_mode = WB_SYNC_ALL,
+		.nr_to_write = 0,
+	};
+
+	if (gfs2_is_jdata(GFS2_I(inode))) {
+		gfs2_log_flush(GFS2_SB(inode), GFS2_I(inode)->i_gl);
+		return 0;
+	}
 
-	gfs2_log_flush(ip->i_gl->gl_sbd, ip->i_gl);
+	if (sync_state != 0) {
+		if (!datasync)
+			ret = sync_inode(inode, &wbc);
 
-	return 0;
+		if (gfs2_is_stuffed(GFS2_I(inode)))
+			gfs2_log_flush(GFS2_SB(inode), GFS2_I(inode)->i_gl);
+	}
+
+	return ret;
 }
 
 /**
-- 
1.4.1



