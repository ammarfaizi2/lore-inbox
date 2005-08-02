Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVHBUQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVHBUQl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 16:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVHBUQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 16:16:40 -0400
Received: from piraten.student.lu.se ([130.235.208.46]:2969 "EHLO
	piraten.student.lu.se") by vger.kernel.org with ESMTP
	id S261756AbVHBUOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 16:14:54 -0400
Date: Tue, 02 Aug 2005 22:14:53 +0200
From: Johan Veenhuizen <veenhuizen@users.sf.net>
Subject: [PATCH 2.6.12.3] Deny chmod in /proc/<pid>/
To: linux-kernel@vger.kernel.org
Message-id: <42efd43d.ijkrXtpGJUM7deW2%veenhuizen@users.sf.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
User-Agent: nail 11.24 7/14/05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch tries to fix the strange behaviour in /proc/<pid>/,
where it is currently possible for the owner of a process to
temporarily chmod the entries.

Since the inodes for these entries are only temporary, the
permissions will suddenly be reset when the cache is reclaimed.
This is confusing and ugly.

The fix is simple: Deny chmod for all entries in /proc/<pid>/.
I figured this would be a lot easier than maintaining persistent
modes.  The patch does also trigger an EPERM when someone tries
to chown/chgrp an entry (which is currently silently ignored).

Please send comments, corrections and suggestions.

	Johan Veenhuizen


--- linux-2.6.12.3/fs/proc/base.c	2005-07-15 23:18:57.000000000 +0200
+++ linux-2.6.12.3-jpv/fs/proc/base.c	2005-08-02 20:08:36.000000000 +0200
@@ -496,6 +496,17 @@
 	return proc_check_root(inode);
 }
 
+static int proc_setattr(struct dentry *dentry, struct iattr *attr)
+{
+	unsigned int ia_valid = attr->ia_valid;
+
+	if ((ia_valid & ATTR_MODE) || (ia_valid & ATTR_UID)
+	                           || (ia_valid & ATTR_GID))
+		return -EPERM;
+	else
+		return inode_setattr(dentry->d_inode, attr);
+}
+
 extern struct seq_operations proc_pid_maps_op;
 static int maps_open(struct inode *inode, struct file *file)
 {
@@ -766,8 +777,13 @@
 	.write		= oom_adjust_write,
 };
 
+static struct inode_operations proc_default_inode_operations = {
+	.setattr	= proc_setattr,
+};
+
 static struct inode_operations proc_mem_inode_operations = {
 	.permission	= proc_permission,
+	.setattr	= proc_setattr,
 };
 
 #ifdef CONFIG_AUDITSYSCALL
@@ -965,7 +981,8 @@
 
 static struct inode_operations proc_pid_link_inode_operations = {
 	.readlink	= proc_pid_readlink,
-	.follow_link	= proc_pid_follow_link
+	.follow_link	= proc_pid_follow_link,
+	.setattr	= proc_setattr,
 };
 
 #define NUMBUF 10
@@ -1133,6 +1150,7 @@
 	ei->task = NULL;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	inode->i_ino = fake_ino(task->pid, ino);
+	inode->i_op = &proc_default_inode_operations;
 
 	if (!pid_alive(task))
 		goto out_unlock;
@@ -1349,11 +1367,13 @@
 static struct inode_operations proc_fd_inode_operations = {
 	.lookup		= proc_lookupfd,
 	.permission	= proc_permission,
+	.setattr	= proc_setattr,
 };
 
 static struct inode_operations proc_task_inode_operations = {
 	.lookup		= proc_task_lookup,
 	.permission	= proc_permission,
+	.setattr	= proc_setattr,
 };
 
 #ifdef CONFIG_SECURITY
@@ -1627,10 +1647,12 @@
 
 static struct inode_operations proc_tgid_base_inode_operations = {
 	.lookup		= proc_tgid_base_lookup,
+	.setattr	= proc_setattr,
 };
 
 static struct inode_operations proc_tid_base_inode_operations = {
 	.lookup		= proc_tid_base_lookup,
+	.setattr	= proc_setattr,
 };
 
 #ifdef CONFIG_SECURITY
@@ -1672,10 +1694,12 @@
 
 static struct inode_operations proc_tgid_attr_inode_operations = {
 	.lookup		= proc_tgid_attr_lookup,
+	.setattr	= proc_setattr,
 };
 
 static struct inode_operations proc_tid_attr_inode_operations = {
 	.lookup		= proc_tid_attr_lookup,
+	.setattr	= proc_setattr,
 };
 #endif
 
@@ -1700,6 +1724,7 @@
 static struct inode_operations proc_self_inode_operations = {
 	.readlink	= proc_self_readlink,
 	.follow_link	= proc_self_follow_link,
+	.setattr	= proc_setattr,
 };
 
 /**
