Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWHINoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWHINoB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 09:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWHINoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 09:44:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7577 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750813AbWHINoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 09:44:00 -0400
From: David Howells <dhowells@redhat.com>
References: <32278.1155057836@warthog.cambridge.redhat.com>  <200608081639.38245.rjw@sisk.pl> <20060804192540.17098.39244.stgit@warthog.cambridge.redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       Olof Johansson <olof@lixom.net>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       dhowells@redhat.com
Subject: [PATCH] ReiserFS: Make sure all dentries refs are released before calling kill_block_super() [try #2]
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 09 Aug 2006 14:43:26 +0100
Message-ID: <912.1155131006@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make sure all dentries refs are released before calling kill_block_super() so
that the assumption that generic_shutdown_super() can completely destroy the
dentry tree for there will be no external references holds true.

What was being done in the put_super() superblock op, is now done in the
kill_sb() filesystem op instead, prior to calling kill_block_super().


Changes made in [try #2]:

 (*) reiserfs_kill_sb() now checks that the superblock FS info pointer is set
     before trying to dereference it.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/reiserfs/super.c |   31 ++++++++++++++++++++-----------
 1 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 5567328..c6e327a 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -430,22 +430,31 @@ int remove_save_link(struct inode *inode
 	return journal_end(&th, inode->i_sb, JOURNAL_PER_BALANCE_CNT);
 }
 
+static void reiserfs_kill_sb(struct super_block *s)
+{
+	if (REISERFS_SB(s)) {
+		if (REISERFS_SB(s)->xattr_root) {
+			d_invalidate(REISERFS_SB(s)->xattr_root);
+			dput(REISERFS_SB(s)->xattr_root);
+			REISERFS_SB(s)->xattr_root = NULL;
+		}
+
+		if (REISERFS_SB(s)->priv_root) {
+			d_invalidate(REISERFS_SB(s)->priv_root);
+			dput(REISERFS_SB(s)->priv_root);
+			REISERFS_SB(s)->priv_root = NULL;
+		}
+	}
+
+	kill_block_super(s);
+}
+
 static void reiserfs_put_super(struct super_block *s)
 {
 	int i;
 	struct reiserfs_transaction_handle th;
 	th.t_trans_id = 0;
 
-	if (REISERFS_SB(s)->xattr_root) {
-		d_invalidate(REISERFS_SB(s)->xattr_root);
-		dput(REISERFS_SB(s)->xattr_root);
-	}
-
-	if (REISERFS_SB(s)->priv_root) {
-		d_invalidate(REISERFS_SB(s)->priv_root);
-		dput(REISERFS_SB(s)->priv_root);
-	}
-
 	/* change file system state to current state if it was mounted with read-write permissions */
 	if (!(s->s_flags & MS_RDONLY)) {
 		if (!journal_begin(&th, s, 10)) {
@@ -2300,7 +2309,7 @@ struct file_system_type reiserfs_fs_type
 	.owner = THIS_MODULE,
 	.name = "reiserfs",
 	.get_sb = get_super_block,
-	.kill_sb = kill_block_super,
+	.kill_sb = reiserfs_kill_sb,
 	.fs_flags = FS_REQUIRES_DEV,
 };
 
