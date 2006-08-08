Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965005AbWHHRY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbWHHRY2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 13:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbWHHRY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 13:24:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12677 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965005AbWHHRY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 13:24:27 -0400
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       Olof Johansson <olof@lixom.net>, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ReiserFS: Make sure all dentries refs are released before calling kill_block_super()
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
References: <200608081639.38245.rjw@sisk.pl> <20060804192540.17098.39244.stgit@warthog.cambridge.redhat.com>
Date: Tue, 08 Aug 2006 18:23:56 +0100
Message-ID: <32278.1155057836@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make sure all dentries refs are released before calling kill_block_super() so
that the assumption that generic_shutdown_super() can completely destroy the
dentry tree for there will be no external references holds true.

What was being done in the put_super() superblock op, is now done in the
kill_sb() filesystem op instead, prior to calling kill_block_super().

This prevents the BUG_ON() in the reduced-locking dcache destroyer patch from
barking at reiserfs.

I've tested this patch by creating a ReiserFS partition, mounting and
unmounting it a few times, and doing things to its contents whilst it is
mounted.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/reiserfs/super.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 5567328..69eefe2 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -430,22 +430,29 @@ int remove_save_link(struct inode *inode
 	return journal_end(&th, inode->i_sb, JOURNAL_PER_BALANCE_CNT);
 }
 
-static void reiserfs_put_super(struct super_block *s)
+static void reiserfs_kill_sb(struct super_block *s)
 {
-	int i;
-	struct reiserfs_transaction_handle th;
-	th.t_trans_id = 0;
-
 	if (REISERFS_SB(s)->xattr_root) {
 		d_invalidate(REISERFS_SB(s)->xattr_root);
 		dput(REISERFS_SB(s)->xattr_root);
+		REISERFS_SB(s)->xattr_root = NULL;
 	}
 
 	if (REISERFS_SB(s)->priv_root) {
 		d_invalidate(REISERFS_SB(s)->priv_root);
 		dput(REISERFS_SB(s)->priv_root);
+		REISERFS_SB(s)->priv_root = NULL;
 	}
 
+	kill_block_super(s);
+}
+
+static void reiserfs_put_super(struct super_block *s)
+{
+	int i;
+	struct reiserfs_transaction_handle th;
+	th.t_trans_id = 0;
+
 	/* change file system state to current state if it was mounted with read-write permissions */
 	if (!(s->s_flags & MS_RDONLY)) {
 		if (!journal_begin(&th, s, 10)) {
@@ -2300,7 +2307,7 @@ struct file_system_type reiserfs_fs_type
 	.owner = THIS_MODULE,
 	.name = "reiserfs",
 	.get_sb = get_super_block,
-	.kill_sb = kill_block_super,
+	.kill_sb = reiserfs_kill_sb,
 	.fs_flags = FS_REQUIRES_DEV,
 };
 
