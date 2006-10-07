Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932734AbWJGF6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932734AbWJGF6q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 01:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932726AbWJGF6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 01:58:20 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:12465 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932699AbWJGF4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 01:56:31 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 17 of 23] Unionfs: Miscellaneous helper functions
Message-Id: <378d7ec841702bcb55e3.1160197656@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1160197639@thor.fsl.cs.sunysb.edu>
Date: Sat, 07 Oct 2006 01:07:36 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch contains miscellaneous helper functions used thoughout Unionfs.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>

---

1 file changed, 179 insertions(+)
fs/unionfs/subr.c |  179 +++++++++++++++++++++++++++++++++++++++++++++++++++++

diff -r 766f19339624 -r 378d7ec84170 fs/unionfs/subr.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/fs/unionfs/subr.c	Sat Oct 07 00:46:19 2006 -0400
@@ -0,0 +1,179 @@
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
+		hidden_dentry = dtohd_index(dentry, bindex);
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
+				printk(KERN_DEBUG
+				       "create_parents failed for bindex = %d\n",
+				       bindex);
+				continue;
+			}
+		}
+
+		hidden_wh_dentry =
+		    lookup_one_len(name, hidden_dentry->d_parent,
+				   dentry->d_name.len + UNIONFS_WHLEN);
+		if (IS_ERR(hidden_wh_dentry))
+			continue;
+
+		/* The whiteout already exists. This used to be impossible, but
+		 * now is possible because of opaqueness. */
+		if (hidden_wh_dentry->d_inode) {
+			dput(hidden_wh_dentry);
+			err = 0;
+			goto out;
+		}
+
+		hidden_dir_dentry = lock_parent(hidden_wh_dentry);
+		if (!(err = is_robranch_super(dentry->d_sb, bindex))) {
+			err =
+			    vfs_create(hidden_dir_dentry->d_inode,
+				       hidden_wh_dentry,
+				       ~current->fs->umask & S_IRWXUGO, NULL);
+
+		}
+		unlock_dir(hidden_dir_dentry);
+		dput(hidden_wh_dentry);
+
+		if (!err)
+			break;
+
+		if (!IS_COPYUP_ERR(err))
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
+ * when it needs to revert. */
+int unionfs_refresh_hidden_dentry(struct dentry *dentry, int bindex)
+{
+	struct dentry *hidden_dentry;
+	struct dentry *hidden_parent;
+	int err = 0;
+
+	verify_locked(dentry);
+
+	lock_dentry(dentry->d_parent);
+	hidden_parent = dtohd_index(dentry->d_parent, bindex);
+	unlock_dentry(dentry->d_parent);
+
+	BUG_ON(!S_ISDIR(hidden_parent->d_inode->i_mode));
+
+	hidden_dentry =
+	    lookup_one_len(dentry->d_name.name, hidden_parent,
+			   dentry->d_name.len);
+	if (IS_ERR(hidden_dentry)) {
+		err = PTR_ERR(hidden_dentry);
+		goto out;
+	}
+
+	if (dtohd_index(dentry, bindex))
+		dput(dtohd_index(dentry, bindex));
+	if (itohi_index(dentry->d_inode, bindex)) {
+		iput(itohi_index(dentry->d_inode, bindex));
+		set_itohi_index(dentry->d_inode, bindex, NULL);
+	}
+	if (!hidden_dentry->d_inode) {
+		dput(hidden_dentry);
+		set_dtohd_index(dentry, bindex, NULL);
+	} else {
+		set_dtohd_index(dentry, bindex, hidden_dentry);
+		set_itohi_index(dentry->d_inode, bindex,
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
+	hidden_dentry = dtohd_index(dentry, bindex);
+	hidden_dir = hidden_dentry->d_inode;
+	BUG_ON(!S_ISDIR(dentry->d_inode->i_mode)
+	       || !S_ISDIR(hidden_dir->i_mode));
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


