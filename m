Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030659AbWHIKXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030659AbWHIKXn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 06:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030655AbWHIKXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 06:23:43 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:40926 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030659AbWHIKXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 06:23:41 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] ReiserFS: Make sure all dentries refs are released before calling kill_block_super()
Date: Wed, 9 Aug 2006 12:23:04 +0200
User-Agent: KMail/1.9.3
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com, Olof Johansson <olof@lixom.net>
References: <200608090116.38476.rjw@sisk.pl> <32278.1155057836@warthog.cambridge.redhat.com> <6818.1155118467@warthog.cambridge.redhat.com>
In-Reply-To: <6818.1155118467@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608091223.04492.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 August 2006 12:14, David Howells wrote:
> Rafael J. Wysocki <rjw@sisk.pl> wrote:
> 
> > It didn't apply cleanly to -rc3-mm2 for me and produces the appended oops
> > every time at the kernel startup (on x86_64).
> 
> Can you send me your modified patch?

Index: linux-2.6.18-rc3-mm2/fs/reiserfs/super.c
===================================================================
--- linux-2.6.18-rc3-mm2.orig/fs/reiserfs/super.c
+++ linux-2.6.18-rc3-mm2/fs/reiserfs/super.c
@@ -430,21 +430,29 @@ int remove_save_link(struct inode *inode
 	return journal_end(&th, inode->i_sb, JOURNAL_PER_BALANCE_CNT);
 }
 
-static void reiserfs_put_super(struct super_block *s)
+static void reiserfs_kill_sb(struct super_block *s)
 {
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
@@ -2155,7 +2163,7 @@ struct file_system_type reiserfs_fs_type
 	.owner = THIS_MODULE,
 	.name = "reiserfs",
 	.get_sb = get_super_block,
-	.kill_sb = kill_block_super,
+	.kill_sb = reiserfs_kill_sb,
 	.fs_flags = FS_REQUIRES_DEV,
 };
 
