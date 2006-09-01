Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932503AbWIABkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbWIABkX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 21:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWIABkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 21:40:23 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:36230 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932446AbWIABkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 21:40:21 -0400
Date: Thu, 31 Aug 2006 21:40:10 -0400
From: Josef Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@ftp.linux.org.uk
Subject: [PATCH 03/22][RFC] Unionfs: Branch management functionality
Message-ID: <20060901014010.GD5788@fsl.cs.sunysb.edu>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901013512.GA5788@fsl.cs.sunysb.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Quigley <dquigley@fsl.cs.sunysb.edu>

This patch contains the ioctls to increase the union generation and to query
which branch a file exists on.

Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>

---

 fs/unionfs/branchman.c |   92 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff -Nur -x linux-2.6-git/Documentation/dontdiff linux-2.6-git/fs/unionfs/branchman.c linux-2.6-git-unionfs/fs/unionfs/branchman.c
--- linux-2.6-git/fs/unionfs/branchman.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6-git-unionfs/fs/unionfs/branchman.c	2006-08-31 19:04:00.000000000 -0400
@@ -0,0 +1,92 @@
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
+struct dentry **alloc_new_dentries(int objs)
+{
+	if (!objs)
+		return NULL;
+
+	return kzalloc(sizeof(struct dentry *) * objs, GFP_KERNEL);
+}
+
+struct unionfs_usi_data *alloc_new_data(int objs)
+{
+	if (!objs)
+		return NULL;
+
+	return kzalloc(sizeof(struct unionfs_usi_data) * objs, GFP_KERNEL);
+}
+
+int unionfs_ioctl_incgen(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct super_block *sb;
+	int gen;
+
+	sb = file->f_dentry->d_sb;
+
+	unionfs_write_lock(sb);
+
+	atomic_inc(&stopd(sb)->usi_generation);
+	gen = atomic_read(&stopd(sb)->usi_generation);
+
+	atomic_set(&dtopd(sb->s_root)->udi_generation, gen);
+	atomic_set(&itopd(sb->s_root->d_inode)->uii_generation, gen);
+
+	unionfs_write_unlock(sb);
+
+	return gen;
+}
+
+int unionfs_ioctl_queryfile(struct file *file, unsigned int cmd,
+			    unsigned long arg)
+{
+	int err = 0;
+	fd_set branchlist;
+
+	int bstart = 0, bend = 0, bindex = 0;
+	struct dentry *dentry, *hidden_dentry;
+
+	dentry = file->f_dentry;
+	lock_dentry(dentry);
+	if ((err = unionfs_partial_lookup(dentry)))
+		goto out;
+	bstart = dbstart(dentry);
+	bend = dbend(dentry);
+
+	FD_ZERO(&branchlist);
+
+	for (bindex = bstart; bindex <= bend; bindex++) {
+		hidden_dentry = dtohd_index(dentry, bindex);
+		if (!hidden_dentry)
+			continue;
+		if (hidden_dentry->d_inode)
+			FD_SET(bindex, &branchlist);
+	}
+
+	err = copy_to_user((void __user *)arg, &branchlist, sizeof(fd_set));
+	if (err)
+		err = -EFAULT;
+
+out:
+	unlock_dentry(dentry);
+	return err < 0 ? err : bend;
+}
+
