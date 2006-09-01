Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbWIABzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbWIABzw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 21:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbWIABzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 21:55:51 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:4744 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1030188AbWIABzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 21:55:50 -0400
Date: Thu, 31 Aug 2006 21:55:39 -0400
From: Josef Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@ftp.linux.org.uk
Subject: [PATCH 15/22][RFC] Unionfs: Privileged operations workqueue
Message-ID: <20060901015539.GP5788@fsl.cs.sunysb.edu>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901013512.GA5788@fsl.cs.sunysb.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

Workqueue & helper functions used to perform privileged operations on
behalf of the user process.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>

---

 fs/unionfs/sioq.c |  114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/unionfs/sioq.h |   79 +++++++++++++++++++++++++++++++++++++
 2 files changed, 193 insertions(+)

diff -Nur -x linux-2.6-git/Documentation/dontdiff linux-2.6-git/fs/unionfs/sioq.c linux-2.6-git-unionfs/fs/unionfs/sioq.c
--- linux-2.6-git/fs/unionfs/sioq.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6-git-unionfs/fs/unionfs/sioq.c	2006-08-31 19:04:00.000000000 -0400
@@ -0,0 +1,114 @@
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
+struct workqueue_struct *sioq;
+
+int __init init_sioq(void)
+{
+	int err;
+
+	sioq = create_workqueue("unionfs_siod");
+	if (!IS_ERR(sioq))
+		return 0;
+
+	err = PTR_ERR(sioq);
+	printk(KERN_ERR "create_workqueue failed %d\n", err);
+	sioq = NULL;
+	return err;
+}
+
+void fin_sioq(void)
+{
+	if (sioq)
+		destroy_workqueue(sioq);
+}
+
+void run_sioq(void (*func)(void *arg), struct sioq_args *args)
+{
+	DECLARE_WORK(wk, func, &args->comp);
+
+	init_completion(&args->comp);
+	while (!queue_work(sioq, &wk)) {
+		// TODO: do accounting if needed
+		schedule();
+	}
+	wait_for_completion(&args->comp);
+}
+
+void __unionfs_create(void *data)
+{
+	struct sioq_args *args = data;
+
+	args->err = vfs_create(args->u.create.parent, args->u.create.dentry,
+				args->u.create.mode, args->u.create.nd);
+	complete(&args->comp);
+}
+
+void __unionfs_mkdir(void *data)
+{
+	struct sioq_args *args = data;
+
+	args->err = vfs_mkdir(args->u.mkdir.parent, args->u.mkdir.dentry,
+				args->u.mkdir.mode);
+	complete(&args->comp);
+}
+
+void __unionfs_mknod(void *data)
+{
+	struct sioq_args *args = data;
+
+	args->err = vfs_mknod(args->u.mknod.parent, args->u.mknod.dentry,
+				args->u.mknod.mode, args->u.mknod.dev);
+	complete(&args->comp);
+}
+void __unionfs_symlink(void *data)
+{
+	struct sioq_args *args = data;
+
+	args->err = vfs_symlink(args->u.symlink.parent, args->u.symlink.dentry,
+				args->u.symlink.symbuf, args->u.symlink.mode);
+}
+
+void __unionfs_unlink(void *data)
+{
+	struct sioq_args *args = data;
+
+	args->err = vfs_unlink(args->u.unlink.parent, args->u.unlink.dentry);
+	complete(&args->comp);
+}
+
+void __delete_whiteouts(void *data) {
+	struct sioq_args *args = data;
+
+	args->err = do_delete_whiteouts(args->u.deletewh.dentry, args->u.deletewh.bindex,
+					args->u.deletewh.namelist);
+
+	complete(&args->comp);
+}
+
+void __is_opaque_dir(void *data)
+{
+	struct sioq_args *args = data;
+
+	args->ret = lookup_one_len(UNIONFS_DIR_OPAQUE, args->u.isopaque.dentry,
+				sizeof(UNIONFS_DIR_OPAQUE) - 1);
+	complete(&args->comp);
+}
diff -Nur -x linux-2.6-git/Documentation/dontdiff linux-2.6-git/fs/unionfs/sioq.h linux-2.6-git-unionfs/fs/unionfs/sioq.h
--- linux-2.6-git/fs/unionfs/sioq.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6-git-unionfs/fs/unionfs/sioq.h	2006-08-31 19:04:01.000000000 -0400
@@ -0,0 +1,79 @@
+#ifndef _SIOQ_H
+#define _SIOQ_H
+
+struct deletewh_args {
+	struct unionfs_dir_state *namelist;
+	struct dentry *dentry;
+	int bindex;
+};
+
+struct isopaque_args {
+	struct dentry *dentry;
+};
+
+struct create_args {
+	struct inode *parent;
+	struct dentry *dentry;
+	umode_t mode;
+	struct nameidata *nd;
+};
+
+struct mkdir_args {
+	struct inode *parent;
+	struct dentry *dentry;
+	umode_t mode;
+};
+
+struct mknod_args {
+	struct inode *parent;
+	struct dentry *dentry;
+	umode_t mode;
+	dev_t dev;
+};
+
+struct symlink_args {
+	struct inode *parent;
+	struct dentry *dentry;
+	char *symbuf;
+	umode_t mode;
+};
+
+struct unlink_args {
+	struct inode *parent;
+	struct dentry *dentry;
+};
+
+
+struct sioq_args {
+
+	struct completion comp;
+	int err;
+	void *ret;
+
+	union {
+		struct deletewh_args deletewh;
+		struct isopaque_args isopaque;
+		struct create_args create;
+		struct mkdir_args mkdir;
+		struct mknod_args mknod;
+		struct symlink_args symlink;
+		struct unlink_args unlink;
+	} u;
+};
+
+extern struct workqueue_struct *sioq;
+int __init init_sioq(void);
+extern void fin_sioq(void);
+extern void run_sioq(void (*func)(void *arg), struct sioq_args *args);
+
+/* Extern definitions for our privledge escalation helpers */
+extern void __unionfs_create(void *data);
+extern void __unionfs_mkdir(void *data);
+extern void __unionfs_mknod(void *data);
+extern void __unionfs_symlink(void *data);
+extern void __unionfs_unlink(void *data);
+extern void __delete_whiteouts(void *data);
+extern void __is_opaque_dir(void *data);
+
+#endif /* _SIOQ_H */
+
