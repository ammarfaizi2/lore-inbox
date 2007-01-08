Return-Path: <linux-kernel-owner+w=401wt.eu-S1030483AbXAHEQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030483AbXAHEQd (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 23:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030490AbXAHEQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 23:16:33 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:50261 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030483AbXAHEQc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 23:16:32 -0500
From: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, hch@infradead.org, viro@ftp.linux.org.uk,
       torvalds@osdl.org, akpm@osdl.org, mhalcrow@us.ibm.com,
       Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>,
       David Quigley <dquigley@fsl.cs.sunysb.edu>,
       Erez Zadok <ezk@cs.sunysb.edu>
Subject: [PATCH 17/24] Unionfs: Miscellaneous helper functions
Date: Sun,  7 Jan 2007 23:13:09 -0500
Message-Id: <116822959930-git-send-email-jsipek@cs.sunysb.edu>
X-Mailer: git-send-email 1.4.4.2
In-Reply-To: <1168229596580-git-send-email-jsipek@cs.sunysb.edu>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch contains miscellaneous helper functions used thoughout Unionfs.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>
---
 fs/unionfs/subr.c |  172 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 172 insertions(+), 0 deletions(-)

diff --git a/fs/unionfs/subr.c b/fs/unionfs/subr.c
new file mode 100644
index 0000000..6734776
--- /dev/null
+++ b/fs/unionfs/subr.c
@@ -0,0 +1,172 @@
+/*
+ * Copyright (c) 2003-2006 Erez Zadok
+ * Copyright (c) 2003-2006 Charles P. Wright
+ * Copyright (c) 2005-2006 Josef 'Jeff' Sipek
+ * Copyright (c) 2005-2006 Junjiro Okajima
+ * Copyright (c) 2005      Arun M. Krishnakumar
+ * Copyright (c) 2004-2006 David P. Quigley
+ * Copyright (c) 2003-2004 Mohammad Nayyer Zubair
+ * Copyright (c) 2003      Puja Gupta
+ * Copyright (c) 2003      Harikesavan Krishnan
+ * Copyright (c) 2003-2006 Stony Brook University
+ * Copyright (c) 2003-2006 The Research Foundation of State University of New York
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "union.h"
+
+/* Pass an unionfs dentry and an index.  It will try to create a whiteout
+ * for the filename in dentry, and will try in branch 'index'.  On error,
+ * it will proceed to a branch to the left.
+ */
+int create_whiteout(struct dentry *dentry, int start)
+{
+	int bstart, bend, bindex;
+	struct dentry *hidden_dir_dentry;
+	struct dentry *hidden_dentry;
+	struct dentry *hidden_wh_dentry;
+	char *name = NULL;
+	int err = -EINVAL;
+
+	verify_locked(dentry);
+
+	bstart = dbstart(dentry);
+	bend = dbend(dentry);
+
+	/* create dentry's whiteout equivalent */
+	name = alloc_whname(dentry->d_name.name, dentry->d_name.len);
+	if (IS_ERR(name)) {
+		err = PTR_ERR(name);
+		goto out;
+	}
+
+	for (bindex = start; bindex >= 0; bindex--) {
+		hidden_dentry = unionfs_lower_dentry_idx(dentry, bindex);
+
+		if (!hidden_dentry) {
+			/* if hidden dentry is not present, create the entire
+			 * hidden dentry directory structure and go ahead.
+			 * Since we want to just create whiteout, we only want
+			 * the parent dentry, and hence get rid of this dentry.
+			 */
+			hidden_dentry = create_parents(dentry->d_inode,
+						       dentry, bindex);
+			if (!hidden_dentry || IS_ERR(hidden_dentry)) {
+				printk(KERN_DEBUG "create_parents failed for "
+						"bindex = %d\n", bindex);
+				continue;
+			}
+		}
+
+		hidden_wh_dentry = lookup_one_len(name, hidden_dentry->d_parent,
+					dentry->d_name.len + UNIONFS_WHLEN);
+		if (IS_ERR(hidden_wh_dentry))
+			continue;
+
+		/* The whiteout already exists. This used to be impossible, but
+		 * now is possible because of opaqueness.
+		 */
+		if (hidden_wh_dentry->d_inode) {
+			dput(hidden_wh_dentry);
+			err = 0;
+			goto out;
+		}
+
+		hidden_dir_dentry = lock_parent(hidden_wh_dentry);
+		if (!(err = is_robranch_super(dentry->d_sb, bindex))) {
+			err = vfs_create(hidden_dir_dentry->d_inode,
+				       hidden_wh_dentry,
+				       ~current->fs->umask & S_IRWXUGO, NULL);
+
+		}
+		unlock_dir(hidden_dir_dentry);
+		dput(hidden_wh_dentry);
+
+		if (!err || !IS_COPYUP_ERR(err))
+			break;
+	}
+
+	/* set dbopaque  so that lookup will not proceed after this branch */
+	if (!err)
+		set_dbopaque(dentry, bindex);
+
+out:
+	kfree(name);
+	return err;
+}
+
+/* This is a helper function for rename, which ends up with hosed over dentries
+ * when it needs to revert.
+ */
+int unionfs_refresh_hidden_dentry(struct dentry *dentry, int bindex)
+{
+	struct dentry *hidden_dentry;
+	struct dentry *hidden_parent;
+	int err = 0;
+
+	verify_locked(dentry);
+
+	lock_dentry(dentry->d_parent);
+	hidden_parent = unionfs_lower_dentry_idx(dentry->d_parent, bindex);
+	unlock_dentry(dentry->d_parent);
+
+	BUG_ON(!S_ISDIR(hidden_parent->d_inode->i_mode));
+
+	hidden_dentry = lookup_one_len(dentry->d_name.name, hidden_parent,
+				dentry->d_name.len);
+	if (IS_ERR(hidden_dentry)) {
+		err = PTR_ERR(hidden_dentry);
+		goto out;
+	}
+
+	dput(unionfs_lower_dentry_idx(dentry, bindex));
+	iput(unionfs_lower_inode_idx(dentry->d_inode, bindex));
+	unionfs_set_lower_inode_idx(dentry->d_inode, bindex, NULL);
+
+	if (!hidden_dentry->d_inode) {
+		dput(hidden_dentry);
+		unionfs_set_lower_dentry_idx(dentry, bindex, NULL);
+	} else {
+		unionfs_set_lower_dentry_idx(dentry, bindex, hidden_dentry);
+		unionfs_set_lower_inode_idx(dentry->d_inode, bindex,
+				igrab(hidden_dentry->d_inode));
+	}
+
+out:
+	return err;
+}
+
+int make_dir_opaque(struct dentry *dentry, int bindex)
+{
+	int err = 0;
+	struct dentry *hidden_dentry, *diropq;
+	struct inode *hidden_dir;
+
+	hidden_dentry = unionfs_lower_dentry_idx(dentry, bindex);
+	hidden_dir = hidden_dentry->d_inode;
+	BUG_ON(!S_ISDIR(dentry->d_inode->i_mode) ||
+	       !S_ISDIR(hidden_dir->i_mode));
+
+	mutex_lock(&hidden_dir->i_mutex);
+	diropq = lookup_one_len(UNIONFS_DIR_OPAQUE, hidden_dentry,
+				sizeof(UNIONFS_DIR_OPAQUE) - 1);
+	if (IS_ERR(diropq)) {
+		err = PTR_ERR(diropq);
+		goto out;
+	}
+
+	if (!diropq->d_inode)
+		err = vfs_create(hidden_dir, diropq, S_IRUGO, NULL);
+	if (!err)
+		set_dbopaque(dentry, bindex);
+
+	dput(diropq);
+
+out:
+	mutex_unlock(&hidden_dir->i_mutex);
+	return err;
+}
+
-- 
1.4.4.2

