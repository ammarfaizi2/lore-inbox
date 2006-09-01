Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWIACCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWIACCO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 22:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWIACCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 22:02:14 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:50312 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1750712AbWIACCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 22:02:11 -0400
Date: Thu, 31 Aug 2006 22:01:51 -0400
From: Josef Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@ftp.linux.org.uk
Subject: [PATCH 21/22][RFC] Unionfs: Unlink
Message-ID: <20060901020151.GV5788@fsl.cs.sunysb.edu>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901013512.GA5788@fsl.cs.sunysb.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch provides unlink functionality for Unionfs.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>

---

 fs/unionfs/unlink.c |  179 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 179 insertions(+)

diff -Nur -x linux-2.6-git/Documentation/dontdiff linux-2.6-git/fs/unionfs/unlink.c linux-2.6-git-unionfs/fs/unionfs/unlink.c
--- linux-2.6-git/fs/unionfs/unlink.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6-git-unionfs/fs/unionfs/unlink.c	2006-08-31 19:04:01.000000000 -0400
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
+ * For specific licensing information, see the COPYING file distributed with
+ * this package.
+ *
+ * This Copyright notice must be kept intact and distributed with all sources.
+ */
+
+#include "union.h"
+
+static int unionfs_unlink_whiteout(struct inode *dir, struct dentry *dentry)
+{
+	struct dentry *hidden_dentry;
+	struct dentry *hidden_dir_dentry;
+	int bindex;
+	int err = 0;
+
+	if ((err = unionfs_partial_lookup(dentry)))
+		goto out;
+
+	bindex = dbstart(dentry);
+
+	hidden_dentry = dtohd_index(dentry, bindex);
+	if (!hidden_dentry)
+		goto out;
+
+	hidden_dir_dentry = lock_parent(hidden_dentry);
+
+	/* avoid destroying the hidden inode if the file is in use */
+	dget(hidden_dentry);
+	if (!(err = is_robranch_super(dentry->d_sb, bindex)))
+		err = vfs_unlink(hidden_dir_dentry->d_inode, hidden_dentry);
+	dput(hidden_dentry);
+	fist_copy_attr_times(dir, hidden_dir_dentry->d_inode);
+	unlock_dir(hidden_dir_dentry);
+
+	if (err && !IS_COPYUP_ERR(err))
+		goto out;
+
+	if (err) {
+		if (dbstart(dentry) == 0)
+			goto out;
+
+		err = create_whiteout(dentry, dbstart(dentry) - 1);
+	} else if (dbopaque(dentry) != -1) {
+		/* There is a hidden lower-priority file with the same name. */
+		err = create_whiteout(dentry, dbopaque(dentry));
+	} else {
+		err = create_whiteout(dentry, dbstart(dentry));
+	}
+
+out:
+	if (!err)
+		dentry->d_inode->i_nlink--;
+
+	/* We don't want to leave negative leftover dentries for revalidate. */
+	if (!err && (dbopaque(dentry) != -1))
+		update_bstart(dentry);
+
+	return err;
+}
+
+int unionfs_unlink(struct inode *dir, struct dentry *dentry)
+{
+	int err = 0;
+
+	lock_dentry(dentry);
+
+	err = unionfs_unlink_whiteout(dir, dentry);
+	/* call d_drop so the system "forgets" about us */
+	if (!err)
+		d_drop(dentry);
+
+	unlock_dentry(dentry);
+	return err;
+}
+
+static int unionfs_rmdir_first(struct inode *dir, struct dentry *dentry,
+			       struct unionfs_dir_state *namelist)
+{
+	int err;
+	struct dentry *hidden_dentry;
+	struct dentry *hidden_dir_dentry = NULL;
+
+	/* Here we need to remove whiteout entries. */
+	err = delete_whiteouts(dentry, dbstart(dentry), namelist);
+	if (err) {
+		goto out;
+	}
+
+	hidden_dentry = dtohd(dentry);
+
+	hidden_dir_dentry = lock_parent(hidden_dentry);
+
+	/* avoid destroying the hidden inode if the file is in use */
+	dget(hidden_dentry);
+	if (!(err = is_robranch(dentry))) {
+		err = vfs_rmdir(hidden_dir_dentry->d_inode, hidden_dentry);
+	}
+	dput(hidden_dentry);
+
+	fist_copy_attr_times(dir, hidden_dir_dentry->d_inode);
+	/* propagate number of hard-links */
+	dentry->d_inode->i_nlink = get_nlinks(dentry->d_inode);
+
+out:
+	if (hidden_dir_dentry) {
+		unlock_dir(hidden_dir_dentry);
+	}
+	return err;
+}
+
+int unionfs_rmdir(struct inode *dir, struct dentry *dentry)
+{
+	int err = 0;
+	struct unionfs_dir_state *namelist = NULL;
+
+	lock_dentry(dentry);
+
+	/* check if this unionfs directory is empty or not */
+	err = check_empty(dentry, &namelist);
+	if (err) {
+#if 0
+		/* vfs_rmdir(our caller) unhashed the dentry.  This will recover
+		 * the Unionfs inode number for the directory itself, but the
+		 * children are already lost.  It seems that tmpfs manages its
+		 * way around this by upping the refcount on everything.
+		 *
+		 * Even if we do this, we still lose the inode numbers of the
+		 * children.  The best way to fix this is to fix the VFS (or
+		 * use persistent inode maps). */
+		if (d_unhashed(dentry))
+			d_rehash(dentry);
+#endif
+		goto out;
+	}
+
+	err = unionfs_rmdir_first(dir, dentry, namelist);
+	/* create whiteout */
+	if (!err) {
+		err = create_whiteout(dentry, dbstart(dentry));
+	} else {
+		int new_err;
+
+		if (dbstart(dentry) == 0)
+			goto out;
+
+		/* exit if the error returned was NOT -EROFS */
+		if (!IS_COPYUP_ERR(err))
+			goto out;
+
+		new_err = create_whiteout(dentry, dbstart(dentry) - 1);
+		if (new_err != -EEXIST)
+			err = new_err;
+	}
+
+out:
+	/* call d_drop so the system "forgets" about us */
+	if (!err)
+		d_drop(dentry);
+
+	if (namelist)
+		free_rdstate(namelist);
+
+	unlock_dentry(dentry);
+	return err;
+}
+
