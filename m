Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262077AbVCTKRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbVCTKRf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 05:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbVCTKQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 05:16:58 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:36015 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S262078AbVCTKOo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 05:14:44 -0500
Subject: [PATCH][4/5] Add inode_operations for proc sysctl
In-Reply-To: <1111278162.22BA.5209@neapel230.server4you.de>
Date: Sun, 20 Mar 2005 11:14:43 +0100
Message-Id: <1111313683.C4EFe5.17773@neapel230.server4you.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add getattr and permission inode_operations for base /proc/<pid> entries
that make sure the value of inode->i_mode is up-to-date with its
respective sysctl setting.  This is achieved by calling the new function
proc_update_mode.  It currently spares the init process.

diff -pur l1/fs/proc/base.c l2/fs/proc/base.c
--- l1/fs/proc/base.c	2005-03-19 20:08:30.000000000 +0100
+++ l2/fs/proc/base.c	2005-03-19 20:08:39.000000000 +0100
@@ -243,6 +243,40 @@ static struct pid_entry tid_attr_stuff[]
 mode_t proc_base_permissions[] = {
 	S_IRUGO,	/* PROC_CMDLINE */
 };
+
+static void proc_update_mode(struct inode *inode)
+{
+	struct task_struct *task = proc_task(inode);
+	int ctl_name = proc_ctl_name(inode);
+
+	if (ctl_name == 0)
+		return;
+	if (task->pid == 1)	/* Don't touch init.  TODO: kernel threads? */
+		return;
+	inode->i_mode = (inode->i_mode & ~S_IALLUGO) |
+	                proc_base_permissions[ctl_name-1];
+}
+
+static int proc_base_permission(struct inode *inode, int mask,
+                                struct nameidata *nd)
+{
+	proc_update_mode(inode);
+	return generic_permission(inode, mask, NULL);
+}
+
+static int proc_base_getattr(struct vfsmount *mnt, struct dentry *dentry,
+                             struct kstat *stat)
+{
+	struct inode *inode = dentry->d_inode;
+	proc_update_mode(inode);
+	generic_fillattr(inode, stat);
+	return 0;
+}
+
+static struct inode_operations proc_base_inode_operations = {
+	.getattr	= proc_base_getattr,
+	.permission	= proc_base_permission,
+};
 #endif /* CONFIG_SYSCTL */
 
 static int proc_fd_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
@@ -1474,6 +1508,8 @@ static struct dentry *proc_pident_lookup
 	ei = PROC_I(inode);
 #ifdef CONFIG_SYSCTL
 	ei->ctl_name = p->ctl_name;
+	proc_update_mode(inode);
+	inode->i_op = &proc_base_inode_operations;
 #endif
 	inode->i_mode = p->mode;
 	/*

