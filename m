Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932623AbWJGFze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623AbWJGFze (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 01:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932615AbWJGFzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 01:55:06 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:54960 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932605AbWJGFyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 01:54:55 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 3 of 23] Unionfs: Branch management functionality
Message-Id: <283be70922a4ed04834a.1160197642@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1160197639@thor.fsl.cs.sunysb.edu>
Date: Sat, 07 Oct 2006 01:07:22 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch contains the ioctls to increase the union generation and to query
which branch a file exists on.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>

---

1 file changed, 74 insertions(+)
fs/unionfs/branchman.c |   74 ++++++++++++++++++++++++++++++++++++++++++++++++

diff -r 3104d077379c -r 283be70922a4 fs/unionfs/branchman.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/fs/unionfs/branchman.c	Sat Oct 07 00:46:18 2006 -0400
@@ -0,0 +1,74 @@
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
+int unionfs_ioctl_incgen(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct super_block *sb;
+	int gen;
+
+	sb = file->f_dentry->d_sb;
+
+	unionfs_write_lock(sb);
+
+	gen = atomic_inc_return(&stopd(sb)->usi_generation);
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


