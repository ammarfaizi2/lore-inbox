Return-Path: <linux-kernel-owner+w=401wt.eu-S1030496AbXAHERF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030496AbXAHERF (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 23:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030497AbXAHEQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 23:16:41 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:50268 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030492AbXAHEQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 23:16:34 -0500
From: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, hch@infradead.org, viro@ftp.linux.org.uk,
       torvalds@osdl.org, akpm@osdl.org, mhalcrow@us.ibm.com,
       Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>,
       David Quigley <dquigley@fsl.cs.sunysb.edu>,
       Erez Zadok <ezk@cs.sunysb.edu>
Subject: [PATCH 15/24] Unionfs: Privileged operations workqueue
Date: Sun,  7 Jan 2007 23:13:07 -0500
Message-Id: <1168229598972-git-send-email-jsipek@cs.sunysb.edu>
X-Mailer: git-send-email 1.4.4.2
In-Reply-To: <1168229596580-git-send-email-jsipek@cs.sunysb.edu>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

Workqueue & helper functions used to perform privileged operations on
behalf of the user process.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>
---
 fs/unionfs/sioq.c |  122 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/unionfs/sioq.h |   79 ++++++++++++++++++++++++++++++++++
 2 files changed, 201 insertions(+), 0 deletions(-)

diff --git a/fs/unionfs/sioq.c b/fs/unionfs/sioq.c
new file mode 100644
index 0000000..444a3e5
--- /dev/null
+++ b/fs/unionfs/sioq.c
@@ -0,0 +1,122 @@
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
+/* Super-user IO work Queue - sometimes we need to perform actions which
+ * would fail due to the unix permissions on the parent directory (e.g.,
+ * rmdir a directory which appears empty, but in reality contains
+ * whiteouts).
+ */
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
+void __exit stop_sioq(void)
+{
+	if (sioq)
+		destroy_workqueue(sioq);
+}
+
+void run_sioq(work_func_t func, struct sioq_args *args)
+{
+	INIT_WORK(&args->work, func);
+
+	init_completion(&args->comp);
+	while (!queue_work(sioq, &args->work)) {
+		/* TODO: do accounting if needed */
+		schedule();
+	}
+	wait_for_completion(&args->comp);
+}
+
+void __unionfs_create(struct work_struct *work)
+{
+	struct sioq_args *args = container_of(work, struct sioq_args, work);
+	struct create_args *c = &args->create;
+
+	args->err = vfs_create(c->parent, c->dentry, c->mode, c->nd);
+	complete(&args->comp);
+}
+
+void __unionfs_mkdir(struct work_struct *work)
+{
+	struct sioq_args *args = container_of(work, struct sioq_args, work);
+	struct mkdir_args *m = &args->mkdir;
+
+	args->err = vfs_mkdir(m->parent, m->dentry, m->mode);
+	complete(&args->comp);
+}
+
+void __unionfs_mknod(struct work_struct *work)
+{
+	struct sioq_args *args = container_of(work, struct sioq_args, work);
+	struct mknod_args *m = &args->mknod;
+
+	args->err = vfs_mknod(m->parent, m->dentry, m->mode, m->dev);
+	complete(&args->comp);
+}
+
+void __unionfs_symlink(struct work_struct *work)
+{
+	struct sioq_args *args = container_of(work, struct sioq_args, work);
+	struct symlink_args *s = &args->symlink;
+
+	args->err = vfs_symlink(s->parent, s->dentry, s->symbuf, s->mode);
+	complete(&args->comp);
+}
+
+void __unionfs_unlink(struct work_struct *work)
+{
+	struct sioq_args *args = container_of(work, struct sioq_args, work);
+	struct unlink_args *u = &args->unlink;
+
+	args->err = vfs_unlink(u->parent, u->dentry);
+	complete(&args->comp);
+}
+
+void __delete_whiteouts(struct work_struct *work) {
+	struct sioq_args *args = container_of(work, struct sioq_args, work);
+	struct deletewh_args *d = &args->deletewh;
+
+	args->err = do_delete_whiteouts(d->dentry, d->bindex, d->namelist);
+	complete(&args->comp);
+}
+
+void __is_opaque_dir(struct work_struct *work)
+{
+	struct sioq_args *args = container_of(work, struct sioq_args, work);
+
+	args->ret = lookup_one_len(UNIONFS_DIR_OPAQUE, args->is_opaque.dentry,
+				sizeof(UNIONFS_DIR_OPAQUE) - 1);
+	complete(&args->comp);
+}
+
diff --git a/fs/unionfs/sioq.h b/fs/unionfs/sioq.h
new file mode 100644
index 0000000..5a93414
--- /dev/null
+++ b/fs/unionfs/sioq.h
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
+struct is_opaque_args {
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
+	struct completion comp;
+	struct work_struct work;
+	int err;
+	void *ret;
+
+	union {
+		struct deletewh_args deletewh;
+		struct is_opaque_args is_opaque;
+		struct create_args create;
+		struct mkdir_args mkdir;
+		struct mknod_args mknod;
+		struct symlink_args symlink;
+		struct unlink_args unlink;
+	};
+};
+
+extern struct workqueue_struct *sioq;
+extern int __init init_sioq(void);
+extern __exit void stop_sioq(void);
+extern void run_sioq(work_func_t func, struct sioq_args *args);
+
+/* Extern definitions for our privlege escalation helpers */
+extern void __unionfs_create(struct work_struct *work);
+extern void __unionfs_mkdir(struct work_struct *work);
+extern void __unionfs_mknod(struct work_struct *work);
+extern void __unionfs_symlink(struct work_struct *work);
+extern void __unionfs_unlink(struct work_struct *work);
+extern void __delete_whiteouts(struct work_struct *work);
+extern void __is_opaque_dir(struct work_struct *work);
+
+#endif /* _SIOQ_H */
+
-- 
1.4.4.2

