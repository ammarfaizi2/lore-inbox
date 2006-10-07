Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932715AbWJGF6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932715AbWJGF6Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 01:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932713AbWJGF4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 01:56:31 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:9905 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932605AbWJGF4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 01:56:24 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 6 of 23] Unionfs: Dentry operations
Message-Id: <22463296bc1ffe9006ad.1160197645@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1160197639@thor.fsl.cs.sunysb.edu>
Date: Sat, 07 Oct 2006 01:07:25 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch contains the dentry operations for Unionfs.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>

---

1 file changed, 244 insertions(+)
fs/unionfs/dentry.c |  244 +++++++++++++++++++++++++++++++++++++++++++++++++++

diff -r 2bae4a1f2233 -r 22463296bc1f fs/unionfs/dentry.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/fs/unionfs/dentry.c	Sat Oct 07 00:46:18 2006 -0400
@@ -0,0 +1,244 @@
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
+	struct nameidata lowernd;
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
+	dgen = atomic_read(&dtopd(dentry)->udi_generation);
+	sbgen = atomic_read(&stopd(dentry->d_sb)->usi_generation);
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
+		pdgen = atomic_read(&dtopd(dentry->d_parent)->udi_generation);
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
+				    dtohd_index_nocheck(dentry, bindex);
+				if (!hidden_dentry)
+					continue;
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
+					    itohi_index(dentry->d_inode,
+							bindex);
+					if (!hidden_inode)
+						continue;
+					iput(hidden_inode);
+				}
+			}
+			kfree(itohi_ptr(dentry->d_inode));
+			itohi_ptr(dentry->d_inode) = NULL;
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
+		if (positive && itopd(dentry->d_inode)->uii_stale) {
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
+		hidden_dentry = dtohd_index(dentry, bindex);
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
+		fist_copy_attr_all(dentry->d_inode, itohi(dentry->d_inode));
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
+
+	err = unionfs_d_revalidate(dentry, nd);
+
+	unlock_dentry(dentry);
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
+	if (!dtopd(dentry)) {
+		printk(KERN_DEBUG "dentry without private data: %.*s",
+		       dentry->d_name.len, dentry->d_name.name);
+		goto out;
+	} else if (dbstart(dentry) < 0) {
+		/* this is due to a failed lookup */
+		/* the failed lookup has a dtohd_ptr set to null,
+		   but this is a better check */
+		printk(KERN_DEBUG "dentry without hidden dentries : %.*s",
+		       dentry->d_name.len, dentry->d_name.name);
+		goto out_free;
+	}
+
+	/* Release all the hidden dentries */
+	bstart = dbstart(dentry);
+	bend = dbend(dentry);
+	for (bindex = bstart; bindex <= bend; bindex++) {
+		dput(dtohd_index(dentry, bindex));
+		mntput(dtohm_index(dentry, bindex));
+
+		set_dtohd_index(dentry, bindex, NULL);
+		set_dtohm_index(dentry, bindex, NULL);
+	}
+	/* free private data (unionfs_dentry_info) here */
+	kfree(dtohd_ptr(dentry));
+	kfree(dtohm_ptr(dentry));
+	dtohd_ptr(dentry) = NULL;
+	dtohm_ptr(dentry) = NULL;
+
+out_free:
+	/* No need to unlock it, because it is disappeared. */
+	free_dentry_private_data(dtopd(dentry));
+	dtopd_lhs(dentry) = NULL;	/* just to be safe */
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


