Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751803AbWKFLFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbWKFLFi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 06:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbWKFLFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 06:05:38 -0500
Received: from fogou.chygwyn.com ([195.171.2.24]:51634 "EHLO fogou.chygwyn.com")
	by vger.kernel.org with ESMTP id S1751803AbWKFLFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 06:05:37 -0500
Subject: [GFS2] Fix incorrect fs sync behaviour [2/5]
From: Steven Whitehouse <steve@chygwyn.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Russell Cattelan <cattelan@redhat.com>
Content-Type: text/plain
Organization: ChyGwyn Limited
Date: Mon, 06 Nov 2006 11:07:59 +0000
Message-Id: <1162811279.18219.32.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "fogou.chygwyn.com", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  >From 4a221953ed121692aa25998451a57c7f4be8b4f6 Mon Sep
	17 00:00:00 2001 From: Steven Whitehouse <swhiteho@redhat.com> Date:
	Wed, 1 Nov 2006 09:57:57 -0500 Subject: [PATCH] [GFS2] Fix incorrect fs
	sync behaviour. [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 4a221953ed121692aa25998451a57c7f4be8b4f6 Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Wed, 1 Nov 2006 09:57:57 -0500
Subject: [PATCH] [GFS2] Fix incorrect fs sync behaviour.

This adds a sync_fs superblock operation for GFS2 and removes
the journal flush from write_super in favour of sync_fs where it
ought to be. This is more or less identical to the way in which ext3
does this.

This bug was pointed out by Russell Cattelan <cattelan@redhat.com>

Cc: Russell Cattelan <cattelan@redhat.com>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/ops_super.c |   44 ++++++++++++++++++++++++++++----------------
 1 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/fs/gfs2/ops_super.c b/fs/gfs2/ops_super.c
index 06f06f7..b47d959 100644
--- a/fs/gfs2/ops_super.c
+++ b/fs/gfs2/ops_super.c
@@ -138,16 +138,27 @@ static void gfs2_put_super(struct super_
 }
 
 /**
- * gfs2_write_super - disk commit all incore transactions
- * @sb: the filesystem
+ * gfs2_write_super
+ * @sb: the superblock
  *
- * This function is called every time sync(2) is called.
- * After this exits, all dirty buffers are synced.
  */
 
 static void gfs2_write_super(struct super_block *sb)
 {
+	sb->s_dirt = 0;
+}
+
+/**
+ * gfs2_sync_fs - sync the filesystem
+ * @sb: the superblock
+ *
+ * Flushes the log to disk.
+ */
+static int gfs2_sync_fs(struct super_block *sb, int wait)
+{
+	sb->s_dirt = 0;
 	gfs2_log_flush(sb->s_fs_info, NULL);
+	return 0;
 }
 
 /**
@@ -452,17 +463,18 @@ static void gfs2_destroy_inode(struct in
 }
 
 struct super_operations gfs2_super_ops = {
-	.alloc_inode = gfs2_alloc_inode,
-	.destroy_inode = gfs2_destroy_inode,
-	.write_inode = gfs2_write_inode,
-	.delete_inode = gfs2_delete_inode,
-	.put_super = gfs2_put_super,
-	.write_super = gfs2_write_super,
-	.write_super_lockfs = gfs2_write_super_lockfs,
-	.unlockfs = gfs2_unlockfs,
-	.statfs = gfs2_statfs,
-	.remount_fs = gfs2_remount_fs,
-	.clear_inode = gfs2_clear_inode,
-	.show_options = gfs2_show_options,
+	.alloc_inode		= gfs2_alloc_inode,
+	.destroy_inode		= gfs2_destroy_inode,
+	.write_inode		= gfs2_write_inode,
+	.delete_inode		= gfs2_delete_inode,
+	.put_super		= gfs2_put_super,
+	.write_super		= gfs2_write_super,
+	.sync_fs		= gfs2_sync_fs,
+	.write_super_lockfs 	= gfs2_write_super_lockfs,
+	.unlockfs		= gfs2_unlockfs,
+	.statfs			= gfs2_statfs,
+	.remount_fs		= gfs2_remount_fs,
+	.clear_inode		= gfs2_clear_inode,
+	.show_options		= gfs2_show_options,
 };
 
-- 
1.4.1



