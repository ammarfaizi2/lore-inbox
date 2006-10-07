Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932702AbWJGF42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932702AbWJGF42 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 01:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbWJGF4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 01:56:25 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:8369 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932618AbWJGF4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 01:56:16 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 15 of 23] Unionfs: Privileged operations workqueue
Message-Id: <b601a3cced0e325c9420.1160197654@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1160197639@thor.fsl.cs.sunysb.edu>
Date: Sat, 07 Oct 2006 01:07:34 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

Workqueue & helper functions used to perform privileged operations on
behalf of the user process.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>

---

3 files changed, 200 insertions(+), 2 deletions(-)
fs/unionfs/main.c |    8 ++-
fs/unionfs/sioq.c |  115 +++++++++++++++++++++++++++++++++++++++++++++++++++++
fs/unionfs/sioq.h |   79 ++++++++++++++++++++++++++++++++++++

diff -r e7c28c2447c2 -r b601a3cced0e fs/unionfs/main.c
--- a/fs/unionfs/main.c	Sat Oct 07 00:46:19 2006 -0400
+++ b/fs/unionfs/main.c	Sat Oct 07 00:46:19 2006 -0400
@@ -256,12 +256,16 @@ static int parse_dirs_option(struct supe
 			branches++;
 
 	/* allocate space for underlying pointers to hidden dentry */
-	if (!(stopd(sb)->usi_data = alloc_new_data(branches))) {
+	stopd(sb)->usi_data = kcalloc(branches,
+			sizeof(struct unionfs_usi_data), GFP_KERNEL);
+	if (!stopd(sb)->usi_data) {
 		err = -ENOMEM;
 		goto out;
 	}
 
-	if (!(hidden_root_info->udi_dentry = alloc_new_dentries(branches))) {
+	hidden_root_info->udi_dentry = kcalloc(branches,
+			sizeof(struct dentry *), GFP_KERNEL);
+	if (!hidden_root_info->udi_dentry) {
 		err = -ENOMEM;
 		goto out;
 	}
diff -r e7c28c2447c2 -r b601a3cced0e fs/unionfs/sioq.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/fs/unionfs/sioq.c	Sat Oct 07 00:46:19 2006 -0400
@@ -0,0 +1,115 @@
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
+	struct create_args *c = &args->u.create;
+
+	args->err = vfs_create(c->parent, c->dentry, c->mode, c->nd);
+	complete(&args->comp);
+}
+
+void __unionfs_mkdir(void *data)
+{
+	struct sioq_args *args = data;
+	struct mkdir_args *m = &args->u.mkdir;
+
+	args->err = vfs_mkdir(m->parent, m->dentry, m->mode);
+	complete(&args->comp);
+}
+
+void __unionfs_mknod(void *data)
+{
+	struct sioq_args *args = data;
+	struct mknod_args *m = &args->u.mknod;
+
+	args->err = vfs_mknod(m->parent, m->dentry, m->mode, m->dev);
+	complete(&args->comp);
+}
+void __unionfs_symlink(void *data)
+{
+	struct sioq_args *args = data;
+	struct symlink_args *s = &args->u.symlink;
+
+	args->err = vfs_symlink(s->parent, s->dentry, s->symbuf, s->mode);
+	complete(&args->comp);
+}
+
+void __unionfs_unlink(void *data)
+{
+	struct sioq_args *args = data;
+	struct unlink_args *u = &args->u.unlink;
+
+	args->err = vfs_unlink(u->parent, u->dentry);
+	complete(&args->comp);
+}
+
+void __delete_whiteouts(void *data) {
+	struct sioq_args *args = data;
+	struct deletewh_args *d = &args->u.deletewh;
+
+	args->err = do_delete_whiteouts(d->dentry, d->bindex, d->namelist);
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
+
diff -r e7c28c2447c2 -r b601a3cced0e fs/unionfs/sioq.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/fs/unionfs/sioq.h	Sat Oct 07 00:46:19 2006 -0400
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


