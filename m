Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbVLOOln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbVLOOln (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 09:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbVLOOlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 09:41:17 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:8859 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1750733AbVLOOjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 09:39:39 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
Message-Id: <20051215143931.563781000@elg11.watson.ibm.com>
References: <20051215143557.421393000@elg11.watson.ibm.com>
Date: Thu, 15 Dec 2005 09:36:17 -0500
To: linux-kernel@vger.kernel.org
Cc: Cedric Le Goater <clg@fr.ibm.com>, Serge E Hallyn <serue@us.ibm.com>
Subject: [RFC][patch 20/21] PID Virtualization: per container /proc filesystem 
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
--

 fs/proc/base.c  |    2 ++
 fs/proc/inode.c |   28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

Index: linux-2.6.15-rc1/fs/proc/inode.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/proc/inode.c	2005-12-12 11:46:46.000000000 -0500
+++ linux-2.6.15-rc1/fs/proc/inode.c	2005-12-12 16:27:15.000000000 -0500
@@ -190,6 +190,33 @@ out_mod:
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
@@ -213,6 +240,7 @@ int proc_fill_super(struct super_block *
 	s->s_root = d_alloc_root(root_inode);
 	if (!s->s_root)
 		goto out_no_root;
+	s->s_root->d_op = &root_dentry_operations;
 	return 0;
 
 out_no_root:
Index: linux-2.6.15-rc1/fs/proc/base.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/proc/base.c	2005-12-12 16:27:11.000000000 -0500
+++ linux-2.6.15-rc1/fs/proc/base.c	2005-12-12 16:27:15.000000000 -0500
@@ -1497,6 +1497,7 @@ static struct dentry *proc_lookupfd(stru
 	inode->i_op = &proc_pid_link_inode_operations;
 	inode->i_size = 64;
 	ei->op.proc_get_link = proc_fd_link;
+	dentry->d_fsdata = current->container;
 	dentry->d_op = &tid_fd_dentry_operations;
 	d_add(dentry, inode);
 	return NULL;
@@ -2002,6 +2003,7 @@ struct dentry *proc_pid_lookup(struct in
 	inode->i_nlink = 4;
 #endif
 
+	dentry->d_fsdata = current->container;
 	dentry->d_op = &pid_base_dentry_operations;
 
 	died = 0;

--
