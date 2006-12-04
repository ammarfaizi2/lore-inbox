Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936264AbWLDMce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936264AbWLDMce (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 07:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936263AbWLDMce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 07:32:34 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:11230 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S936258AbWLDMcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 07:32:33 -0500
From: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, viro@ftp.linux.org.uk,
       linux-fsdevel@vger.kernel.org, mhalcrow@us.ibm.com,
       Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Subject: [PATCH 17/35] Unionfs: Dentry operations
Date: Mon,  4 Dec 2006 07:30:50 -0500
Message-Id: <11652354703719-git-send-email-jsipek@cs.sunysb.edu>
X-Mailer: git-send-email 1.4.3.3
In-Reply-To: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch contains the dentry operations for Unionfs.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>
---
 fs/unionfs/dentry.c |  236 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 236 insertions(+), 0 deletions(-)

diff --git a/fs/unionfs/dentry.c b/fs/unionfs/dentry.c
new file mode 100644
index 0000000..4e2ffa1
--- /dev/null
+++ b/fs/unionfs/dentry.c
@@ -0,0 +1,236 @@
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
+/* declarations added for "sparse" */
+extern int unionfs_d_revalidate_wrap(struct dentry *dentry,
+				     struct nameidata *nd);
+extern void unionfs_d_release(struct dentry *dentry);
+extern void unionfs_d_iput(struct dentry *dentry, struct inode *inode);
+
+/*
+ * returns 1 if valid, 0 otherwise.
+ */
+int unionfs_d_revalidate(struct dentry *dentry, struct nameidata *nd)
+{
+	int valid = 1;		/* default is valid (1); invalid is 0. */
+	struct dentry *hidden_dentry;
+	int bindex, bstart, bend;
+	int sbgen, dgen;
+	int positive = 0;
+	int locked = 0;
+	int restart = 0;
+	int interpose_flag;
+
+	struct nameidata lowernd; /* TODO: be gentler to the stack */
+
+	if (nd)
+		memcpy(&lowernd, nd, sizeof(struct nameidata));
+	else
+		memset(&lowernd, 0, sizeof(struct nameidata));
+
+restart:
+	verify_locked(dentry);
+
+	/* if the dentry is unhashed, do NOT revalidate */
+	if (d_deleted(dentry)) {
+		printk(KERN_DEBUG "unhashed dentry being revalidated: %*s\n",
+		       dentry->d_name.len, dentry->d_name.name);
+		goto out;
+	}
+
+	BUG_ON(dbstart(dentry) == -1);
+	if (dentry->d_inode)
+		positive = 1;
+	dgen = atomic_read(&UNIONFS_D(dentry)->generation);
+	sbgen = atomic_read(&UNIONFS_SB(dentry->d_sb)->generation);
+	/* If we are working on an unconnected dentry, then there is no
+	 * revalidation to be done, because this file does not exist within the
+	 * namespace, and Unionfs operates on the namespace, not data.
+	 */
+	if (sbgen != dgen) {
+		struct dentry *result;
+		int pdgen;
+
+		unionfs_read_lock(dentry->d_sb);
+		locked = 1;
+
+		/* The root entry should always be valid */
+		BUG_ON(IS_ROOT(dentry));
+
+		/* We can't work correctly if our parent isn't valid. */
+		pdgen = atomic_read(&UNIONFS_D(dentry->d_parent)->generation);
+		if (!restart && (pdgen != sbgen)) {
+			unionfs_read_unlock(dentry->d_sb);
+			locked = 0;
+			/* We must be locked before our parent. */
+			if (!
+			    (dentry->d_parent->d_op->
+			     d_revalidate(dentry->d_parent, nd))) {
+				valid = 0;
+				goto out;
+			}
+			restart = 1;
+			goto restart;
+		}
+		BUG_ON(pdgen != sbgen);
+
+		/* Free the pointers for our inodes and this dentry. */
+		bstart = dbstart(dentry);
+		bend = dbend(dentry);
+		if (bstart >= 0) {
+			struct dentry *hidden_dentry;
+			for (bindex = bstart; bindex <= bend; bindex++) {
+				hidden_dentry =
+				    unionfs_lower_dentry_idx(dentry, bindex);
+				dput(hidden_dentry);
+			}
+		}
+		set_dbstart(dentry, -1);
+		set_dbend(dentry, -1);
+
+		interpose_flag = INTERPOSE_REVAL_NEG;
+		if (positive) {
+			interpose_flag = INTERPOSE_REVAL;
+			mutex_lock(&dentry->d_inode->i_mutex);
+			bstart = ibstart(dentry->d_inode);
+			bend = ibend(dentry->d_inode);
+			if (bstart >= 0) {
+				struct inode *hidden_inode;
+				for (bindex = bstart; bindex <= bend; bindex++) {
+					hidden_inode =
+					    unionfs_lower_inode_idx(dentry->d_inode,
+							bindex);
+					iput(hidden_inode);
+				}
+			}
+			kfree(UNIONFS_I(dentry->d_inode)->lower_inodes);
+			UNIONFS_I(dentry->d_inode)->lower_inodes = NULL;
+			ibstart(dentry->d_inode) = -1;
+			ibend(dentry->d_inode) = -1;
+			mutex_unlock(&dentry->d_inode->i_mutex);
+		}
+
+		result = unionfs_lookup_backend(dentry, &lowernd, interpose_flag);
+		if (result) {
+			if (IS_ERR(result)) {
+				valid = 0;
+				goto out;
+			}
+			/* current unionfs_lookup_backend() doesn't return
+			   a valid dentry */
+			dput(dentry);
+			dentry = result;
+		}
+
+		if (positive && UNIONFS_I(dentry->d_inode)->stale) {
+			make_stale_inode(dentry->d_inode);
+			d_drop(dentry);
+			valid = 0;
+			goto out;
+		}
+		goto out;
+	}
+
+	/* The revalidation must occur across all branches */
+	bstart = dbstart(dentry);
+	bend = dbend(dentry);
+	BUG_ON(bstart == -1);
+	for (bindex = bstart; bindex <= bend; bindex++) {
+		hidden_dentry = unionfs_lower_dentry_idx(dentry, bindex);
+		if (!hidden_dentry || !hidden_dentry->d_op
+		    || !hidden_dentry->d_op->d_revalidate)
+			continue;
+
+		if (!hidden_dentry->d_op->d_revalidate(hidden_dentry, nd))
+			valid = 0;
+	}
+
+	if (!dentry->d_inode)
+		valid = 0;
+	if (valid)
+		fsstack_copy_attr_all(dentry->d_inode, unionfs_lower_inode(dentry->d_inode),
+				unionfs_get_nlinks);
+
+out:
+	if (locked)
+		unionfs_read_unlock(dentry->d_sb);
+	return valid;
+}
+
+int unionfs_d_revalidate_wrap(struct dentry *dentry, struct nameidata *nd)
+{
+	int err;
+
+	lock_dentry(dentry);
+	err = unionfs_d_revalidate(dentry, nd);
+	unlock_dentry(dentry);
+
+	return err;
+}
+
+void unionfs_d_release(struct dentry *dentry)
+{
+	int bindex, bstart, bend;
+
+	/* There is no reason to lock the dentry, because we have the only
+	 * reference, but the printing functions verify that we have a lock
+	 * on the dentry before calling dbstart, etc. */
+	lock_dentry(dentry);
+
+	/* this could be a negative dentry, so check first */
+	if (!UNIONFS_D(dentry)) {
+		printk(KERN_DEBUG "dentry without private data: %.*s",
+		       dentry->d_name.len, dentry->d_name.name);
+		goto out;
+	} else if (dbstart(dentry) < 0) {
+		/* this is due to a failed lookup */
+		printk(KERN_DEBUG "dentry without hidden dentries : %.*s",
+		       dentry->d_name.len, dentry->d_name.name);
+		goto out_free;
+	}
+
+	/* Release all the hidden dentries */
+	bstart = dbstart(dentry);
+	bend = dbend(dentry);
+	for (bindex = bstart; bindex <= bend; bindex++) {
+		dput(unionfs_lower_dentry_idx(dentry, bindex));
+		mntput(unionfs_lower_mnt_idx(dentry, bindex));
+
+		unionfs_set_lower_dentry_idx(dentry, bindex, NULL);
+		unionfs_set_lower_mnt_idx(dentry, bindex, NULL);
+	}
+	/* free private data (unionfs_dentry_info) here */
+	kfree(UNIONFS_D(dentry)->lower_paths);
+	UNIONFS_D(dentry)->lower_paths = NULL;
+
+out_free:
+	/* No need to unlock it, because it is disappeared. */
+	free_dentry_private_data(UNIONFS_D(dentry));
+	dentry->d_fsdata = NULL;	/* just to be safe */
+
+out:
+	return;
+}
+
+struct dentry_operations unionfs_dops = {
+	.d_revalidate = unionfs_d_revalidate_wrap,
+	.d_release = unionfs_d_release,
+};
+
-- 
1.4.3.3

