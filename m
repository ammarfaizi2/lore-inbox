Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936382AbWLDMg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936382AbWLDMg5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 07:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936374AbWLDMgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 07:36:19 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:12255 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S936348AbWLDMfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 07:35:53 -0500
From: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, viro@ftp.linux.org.uk,
       linux-fsdevel@vger.kernel.org, mhalcrow@us.ibm.com,
       Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Subject: [PATCH 14/35] Unionfs: Branch management functionality
Date: Mon,  4 Dec 2006 07:30:47 -0500
Message-Id: <11652354703754-git-send-email-jsipek@cs.sunysb.edu>
X-Mailer: git-send-email 1.4.3.3
In-Reply-To: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch contains the ioctls to increase the union generation and to query
which branch a file exists on.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>
---
 fs/unionfs/branchman.c |   81 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/fs/unionfs/branchman.c b/fs/unionfs/branchman.c
new file mode 100644
index 0000000..168c5d5
--- /dev/null
+++ b/fs/unionfs/branchman.c
@@ -0,0 +1,81 @@
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
+/* increase the superblock generation count; effectively invalidating every
+ * upper inode, dentry and file object */
+int unionfs_ioctl_incgen(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct super_block *sb;
+	int gen;
+
+	sb = file->f_dentry->d_sb;
+
+	unionfs_write_lock(sb);
+
+	gen = atomic_inc_return(&UNIONFS_SB(sb)->generation);
+
+	atomic_set(&UNIONFS_D(sb->s_root)->generation, gen);
+	atomic_set(&UNIONFS_I(sb->s_root->d_inode)->generation, gen);
+
+	unionfs_write_unlock(sb);
+
+	return gen;
+}
+
+/* return to userspace the branch indices containing the file in question
+ *
+ * We use fd_set and therefore we are limited to the number of the branches
+ * to FD_SETSIZE, which is currently 1024 - plenty for most people
+ */
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
+		hidden_dentry = unionfs_lower_dentry_idx(dentry, bindex);
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
-- 
1.4.3.3

