Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVCMXci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVCMXci (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 18:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVCMXci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 18:32:38 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:40597 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261587AbVCMXc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 18:32:28 -0500
Date: Mon, 14 Mar 2005 00:32:24 +0100
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk, pj@engr.sgi.com,
       7eggert@gmx.de
Subject: [PATCH][RFC] Make /proc/<pid> chmod'able
Message-ID: <20050313233224.GA4871@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, folks, another try to enhance privacy by hiding process details
from other users.  Why not simply use chmod to set the permissions of
/proc/<pid> directories?  This patch implements it.

Children processes inherit their parents' proc permissions on fork.  You
can only set (and remove) read and execute permissions, the bits for
write, suid etc. are not changable.  A user would add

	chmod 500 /proc/$$

or something similar to his .profile to cloak his processes.

What do you think about that one?

Thanks,
Rene



diff -urp linux-2.6.11-mm3/fs/proc/base.c linux-2.6.11-mm3+/fs/proc/base.c
--- linux-2.6.11-mm3/fs/proc/base.c	2005-03-12 19:23:36.000000000 +0100
+++ linux-2.6.11-mm3+/fs/proc/base.c	2005-03-13 18:36:06.000000000 +0100
@@ -1605,6 +1605,55 @@ out:
 	return ERR_PTR(error);
 }
 
+static int proc_base_setattr(struct dentry *dentry, struct iattr *attr)
+{
+	struct inode *inode = dentry->d_inode;
+	struct task_struct *task;
+	unsigned id;
+	int error;
+
+	BUG_ON(!inode);
+
+	error = -EPERM;
+	if (attr->ia_valid != (ATTR_MODE | ATTR_CTIME))
+		goto out;
+	if (attr->ia_mode & S_IALLUGO & ~(S_IRUGO | S_IXUGO))
+		goto out;
+
+	error = inode_change_ok(inode, attr);
+	if (error)
+		goto out;
+
+	error = -ENOENT;
+	id = name_to_int(dentry);
+	if (id == ~0U)
+		goto out;
+
+	read_lock(&tasklist_lock);
+	task = find_task_by_pid(id);
+	if (task)
+		get_task_struct(task);
+	read_unlock(&tasklist_lock);
+	if (!task)
+		goto out;
+
+	error = inode_setattr(inode, attr);
+	if (error)
+		goto out_drop_task;
+	/*
+ 	 * Save permissions in task_struct as the reverse of the mode.
+	 * This way a value of zero, which is the default value of a
+	 * task_struct member, means "normal permissions".  Children
+	 * inherit the proc_dir_mask value of their parent process.
+ 	 */
+	task->proc_dir_mask = S_IRWXUGO - (attr->ia_mode & S_IRWXUGO);
+
+out_drop_task:
+	put_task_struct(task);
+out:
+	return error;
+}
+
 static struct dentry *proc_tgid_base_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd){
 	return proc_pident_lookup(dir, dentry, tgid_base_stuff);
 }
@@ -1625,10 +1674,12 @@ static struct file_operations proc_tid_b
 
 static struct inode_operations proc_tgid_base_inode_operations = {
 	.lookup		= proc_tgid_base_lookup,
+	.setattr	= proc_base_setattr,
 };
 
 static struct inode_operations proc_tid_base_inode_operations = {
 	.lookup		= proc_tid_base_lookup,
+	.setattr	= proc_base_setattr,
 };
 
 #ifdef CONFIG_SECURITY
@@ -1797,11 +1848,10 @@ struct dentry *proc_pid_lookup(struct in
 		put_task_struct(task);
 		goto out;
 	}
-	inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
+	inode->i_mode = (S_IFDIR|S_IRUGO|S_IXUGO) & ~task->proc_dir_mask;
 	inode->i_op = &proc_tgid_base_inode_operations;
 	inode->i_fop = &proc_tgid_base_operations;
 	inode->i_nlink = 3;
-	inode->i_flags|=S_IMMUTABLE;
 
 	dentry->d_op = &pid_base_dentry_operations;
 
@@ -1852,11 +1902,10 @@ static struct dentry *proc_task_lookup(s
 
 	if (!inode)
 		goto out_drop_task;
-	inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
+	inode->i_mode = (S_IFDIR|S_IRUGO|S_IXUGO) & ~task->proc_dir_mask;
 	inode->i_op = &proc_tid_base_inode_operations;
 	inode->i_fop = &proc_tid_base_operations;
 	inode->i_nlink = 3;
-	inode->i_flags|=S_IMMUTABLE;
 
 	dentry->d_op = &pid_base_dentry_operations;
 
diff -urp linux-2.6.11-mm3/include/linux/sched.h linux-2.6.11-mm3+/include/linux/sched.h
--- linux-2.6.11-mm3/include/linux/sched.h	2005-03-12 19:23:37.000000000 +0100
+++ linux-2.6.11-mm3+/include/linux/sched.h	2005-03-13 11:54:13.000000000 +0100
@@ -719,6 +719,10 @@ struct task_struct {
 	struct audit_context *audit_context;
 	seccomp_t seccomp;
 
+#ifdef CONFIG_PROC_FS
+	umode_t proc_dir_mask;
+#endif
+
 /* Thread group tracking */
    	u32 parent_exec_id;
    	u32 self_exec_id;
