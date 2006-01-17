Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWAQOvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWAQOvj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 09:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWAQOvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 09:51:23 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:942 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750864AbWAQOub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:50:31 -0500
Message-Id: <20060117143329.723437000@sergelap>
References: <20060117143258.150807000@sergelap>
Date: Tue, 17 Jan 2006 08:33:31 -0600
From: Serge Hallyn <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       Serge E Hallyn <serue@us.ibm.com>
Subject: RFC [patch 33/34] PID Virtualization per container /proc filesystem 
Content-Disposition: inline; filename=G7-percontainer-procfs.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Provide the interception and virtualization of the proc interface.
In particular, from within the container the processes need to be 
identified as virtual under /proc as well as we need to limit the 
ones shown to the ones in the container.
NOTE: This is only temporarily since this exhibits some performance problems.

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
Signed-off-by: Serge E Hallyn <serue@us.ibm.com>
---
 base.c  |    2 ++
 inode.c |   28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

Index: linux-2.6.15/fs/proc/inode.c
===================================================================
--- linux-2.6.15.orig/fs/proc/inode.c	2006-01-17 08:17:28.000000000 -0500
+++ linux-2.6.15/fs/proc/inode.c	2006-01-17 08:37:10.000000000 -0500
@@ -190,6 +190,33 @@
 	return NULL;
 }			
 
+/* This service performs checks on virtualization marker to allow multiple
+ * dentries with the same name in the dcache.
+ */
+
+#define procpid_check_marker(task, data) (task->container == data)
+static int proc_root_compare(struct dentry *dentry, struct qstr *a,
+			      struct qstr *b)
+{
+	/* CAUTION: to evaluate pointer of target dentry, we assume parameter
+	 * 'a' is its 'd_name' field. This is always the case anyway.
+	 */
+	struct dentry* d = (struct dentry *)
+		((unsigned long) a -
+		((unsigned long) &dentry->d_name - (unsigned long) dentry));
+	int result = 1;
+
+	if (a->len == b->len && !memcmp(a->name, b->name, a->len))
+		result = !procpid_check_marker(current, d->d_fsdata);
+
+	return result;
+}
+
+static struct dentry_operations root_dentry_operations =
+{
+	d_compare:      proc_root_compare,
+};
+
 int proc_fill_super(struct super_block *s, void *data, int silent)
 {
 	struct inode * root_inode;
@@ -213,6 +240,7 @@
 	s->s_root = d_alloc_root(root_inode);
 	if (!s->s_root)
 		goto out_no_root;
+	s->s_root->d_op = &root_dentry_operations;
 	return 0;
 
 out_no_root:
Index: linux-2.6.15/fs/proc/base.c
===================================================================
--- linux-2.6.15.orig/fs/proc/base.c	2006-01-17 08:37:09.000000000 -0500
+++ linux-2.6.15/fs/proc/base.c	2006-01-17 08:37:10.000000000 -0500
@@ -1497,6 +1497,7 @@
 	inode->i_op = &proc_pid_link_inode_operations;
 	inode->i_size = 64;
 	ei->op.proc_get_link = proc_fd_link;
+	dentry->d_fsdata = current->container;
 	dentry->d_op = &tid_fd_dentry_operations;
 	d_add(dentry, inode);
 	return NULL;
@@ -2002,6 +2003,7 @@
 	inode->i_nlink = 4;
 #endif
 
+	dentry->d_fsdata = current->container;
 	dentry->d_op = &pid_base_dentry_operations;
 
 	died = 0;

--

