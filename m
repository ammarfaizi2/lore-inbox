Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263876AbTEFQDR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 12:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263870AbTEFQDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 12:03:16 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:17150 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S263876AbTEFQBy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 12:01:54 -0400
Subject: [PATCH] Process Attribute API for Security Modules 2.5.69
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       lkml <linux-kernel@vger.kernel.org>, Jan Harkes <jaharkes@cs.cmu.edu>,
       lsm <linux-security-module@wirex.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1052237601.1377.991.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 12:13:25 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.5.69 implements a process attribute API for
security modules via a set of nodes in a /proc/pid/attr directory.
Credit for the idea of implementing this API via /proc/pid/attr nodes
goes to Al Viro.  Jan Harkes provided a nice cleanup of the
implementation to reduce the code bloat.  Al, if you approve of this
change, please acknowledge.  If not, please advise as to what must
change.  Thanks.

 fs/proc/base.c           |  187 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/security.h |   23 +++++
 security/dummy.c         |   12 +++
 3 files changed, 222 insertions(+)

Index: linux-2.5/fs/proc/base.c
diff -u linux-2.5/fs/proc/base.c:1.1.1.3 linux-2.5/fs/proc/base.c:1.8
--- linux-2.5/fs/proc/base.c:1.1.1.3	Mon Apr 21 10:15:46 2003
+++ linux-2.5/fs/proc/base.c	Wed Apr 30 14:26:51 2003
@@ -58,6 +58,11 @@
 	PROC_PID_MAPS,
 	PROC_PID_MOUNTS,
 	PROC_PID_WCHAN,
+	PROC_PID_ATTR,
+	PROC_PID_ATTR_CURRENT,
+	PROC_PID_ATTR_PREV,
+	PROC_PID_ATTR_EXEC,
+	PROC_PID_ATTR_FSCREATE,
 	PROC_PID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
 };
 
@@ -82,11 +87,19 @@
   E(PROC_PID_ROOT,	"root",		S_IFLNK|S_IRWXUGO),
   E(PROC_PID_EXE,	"exe",		S_IFLNK|S_IRWXUGO),
   E(PROC_PID_MOUNTS,	"mounts",	S_IFREG|S_IRUGO),
+  E(PROC_PID_ATTR,	"attr",		S_IFDIR|S_IRUGO|S_IXUGO),
 #ifdef CONFIG_KALLSYMS
   E(PROC_PID_WCHAN,	"wchan",	S_IFREG|S_IRUGO),
 #endif
   {0,0,NULL,0}
 };
+static struct pid_entry attr_stuff[] = {
+  E(PROC_PID_ATTR_CURRENT,	"current",	S_IFREG|S_IRUGO|S_IWUSR),
+  E(PROC_PID_ATTR_PREV,	"prev",	S_IFREG|S_IRUGO|S_IWUSR),
+  E(PROC_PID_ATTR_EXEC,	"exec",	S_IFREG|S_IRUGO|S_IWUSR),
+  E(PROC_PID_ATTR_FSCREATE,	"fscreate",	S_IFREG|S_IRUGO|S_IWUSR),
+  {0,0,NULL,0}
+};
 #undef E
 
 static inline struct task_struct *proc_task(struct inode *inode)
@@ -961,6 +974,175 @@
 	.permission	= proc_permission,
 };
 
+static int proc_attr_readdir(struct file * filp,
+	void * dirent, filldir_t filldir)
+{
+	int i;
+	int pid, ino;
+	struct inode *inode = filp->f_dentry->d_inode;
+	struct pid_entry *p;
+	int ret = 0;
+
+	lock_kernel();
+
+	pid = proc_task(inode)->pid;
+	if (!pid) {
+		ret = -ENOENT;
+		goto out;
+	}
+	i = filp->f_pos;
+	switch (i) {
+		case 0:
+			if (filldir(dirent, ".", 1, i, inode->i_ino, DT_DIR) < 0)
+				goto out;
+			i++;
+			filp->f_pos++;
+			/* fall through */
+		case 1:
+			ino = fake_ino(pid, PROC_PID_INO);
+			if (filldir(dirent, "..", 2, 1, ino, DT_DIR) < 0)
+				goto out;
+			i++;
+			filp->f_pos++;
+			/* fall through */
+		default:
+			i -= 2;
+			if (i>=sizeof(attr_stuff)/sizeof(attr_stuff[0])) {
+				ret = 1;
+				goto out;
+			}
+			p = attr_stuff + i;
+			while (p->name) {
+				if (filldir(dirent, p->name, p->len, filp->f_pos,
+					    fake_ino(pid, p->type), p->mode >> 12) < 0)
+					goto out;
+				filp->f_pos++;
+				p++;
+			}
+	}
+
+	ret = 1;
+out:
+	unlock_kernel();
+	return ret;
+}
+
+static ssize_t proc_pid_attr_read(struct file * file, char * buf,
+				  size_t count, loff_t *ppos)
+{
+	struct inode * inode = file->f_dentry->d_inode;
+	unsigned long page;
+	ssize_t length;
+	ssize_t end;
+	struct task_struct *task = proc_task(inode);
+
+	if (count > PAGE_SIZE)
+		count = PAGE_SIZE;
+	if (!(page = __get_free_page(GFP_KERNEL)))
+		return -ENOMEM;
+
+	length = security_getprocattr(task, 
+				      (char*)file->f_dentry->d_name.name, 
+				      (void*)page, count);
+	if (length < 0) {
+		free_page(page);
+		return length;
+	}
+	/* Static 4kB (or whatever) block capacity */
+	if (*ppos >= length) {
+		free_page(page);
+		return 0;
+	}
+	if (count + *ppos > length)
+		count = length - *ppos;
+	end = count + *ppos;
+	copy_to_user(buf, (char *) page + *ppos, count);
+	*ppos = end;
+	free_page(page);
+	return count;
+}
+
+static ssize_t proc_pid_attr_write(struct file * file, const char * buf,
+				   size_t count, loff_t *ppos)
+{ 
+	struct inode * inode = file->f_dentry->d_inode;
+	char *page; 
+	ssize_t length; 
+	struct task_struct *task = proc_task(inode); 
+
+	if (count > PAGE_SIZE) 
+		count = PAGE_SIZE; 
+	if (*ppos != 0) {
+		/* No partial writes. */
+		return -EINVAL;
+	}
+	page = (char*)__get_free_page(GFP_USER); 
+	if (!page) 
+		return -ENOMEM;
+	length = -EFAULT; 
+	if (copy_from_user(page, buf, count)) 
+		goto out;
+
+	length = security_setprocattr(task, 
+				      (char*)file->f_dentry->d_name.name, 
+				      (void*)page, count);
+out:
+	free_page((unsigned long) page);
+	return length;
+} 
+
+static struct file_operations proc_pid_attr_operations = {
+	.read		= proc_pid_attr_read,
+	.write		= proc_pid_attr_write,
+};
+
+static struct dentry *proc_attr_lookup(struct inode *dir, struct dentry *dentry)
+{
+	struct inode *inode;
+	int error;
+	struct task_struct *task = proc_task(dir);
+	struct pid_entry *p;
+	struct proc_inode *ei;
+
+	error = -ENOENT;
+	inode = NULL;
+
+	for (p = attr_stuff; p->name; p++) {
+		if (p->len != dentry->d_name.len)
+			continue;
+		if (!memcmp(dentry->d_name.name, p->name, p->len))
+			break;
+	}
+	if (!p->name)
+		goto out;
+
+	error = -EINVAL;
+	inode = proc_pid_make_inode(dir->i_sb, task, p->type);
+	if (!inode)
+		goto out;
+
+	ei = PROC_I(inode);
+	inode->i_mode = p->mode;
+	inode->i_fop = &proc_pid_attr_operations;
+	dentry->d_op = &pid_dentry_operations;
+	d_add(dentry, inode);
+	if (!proc_task(dentry->d_inode)->pid)
+		d_drop(dentry);
+	return NULL;
+
+out:
+	return ERR_PTR(error);
+}
+
+static struct file_operations proc_attr_operations = {
+	.read		= generic_read_dir,
+	.readdir	= proc_attr_readdir,
+};
+
+static struct inode_operations proc_attr_inode_operations = {
+	.lookup		= proc_attr_lookup,
+};
+
 /* SMP-safe */
 static struct dentry *proc_base_lookup(struct inode *dir, struct dentry *dentry)
 {
@@ -1040,6 +1222,11 @@
 			break;
 		case PROC_PID_MOUNTS:
 			inode->i_fop = &proc_mounts_operations;
+			break;
+		case PROC_PID_ATTR:
+			inode->i_nlink = 2;
+			inode->i_op = &proc_attr_inode_operations;
+			inode->i_fop = &proc_attr_operations;
 			break;
 #ifdef CONFIG_KALLSYMS
 		case PROC_PID_WCHAN:
Index: linux-2.5/include/linux/security.h
diff -u linux-2.5/include/linux/security.h:1.1.1.2 linux-2.5/include/linux/security.h:1.16
--- linux-2.5/include/linux/security.h:1.1.1.2	Wed Mar 19 09:54:58 2003
+++ linux-2.5/include/linux/security.h	Fri Apr 18 11:17:19 2003
@@ -1123,6 +1128,9 @@
 
 	void (*d_instantiate) (struct dentry *dentry, struct inode *inode);
 
+ 	int (*getprocattr)(struct task_struct *p, char *name, void *value, size_t size);
+ 	int (*setprocattr)(struct task_struct *p, char *name, void *value, size_t size);
+
 #ifdef CONFIG_SECURITY_NETWORK
 	int (*unix_stream_connect) (struct socket * sock,
 				    struct socket * other, struct sock * newsk);
@@ -1755,6 +1769,16 @@
 	security_ops->d_instantiate (dentry, inode);
 }
 
+static inline int security_getprocattr(struct task_struct *p, char *name, void *value, size_t size)
+{
+	return security_ops->getprocattr(p, name, value, size);
+}
+
+static inline int security_setprocattr(struct task_struct *p, char *name, void *value, size_t size)
+{
+	return security_ops->setprocattr(p, name, value, size);
+}
+
 static inline int security_netlink_send(struct sk_buff * skb)
 {
 	return security_ops->netlink_send(skb);
@@ -2339,6 +2367,16 @@
 
 static inline void security_d_instantiate (struct dentry *dentry, struct inode *inode)
 { }
+
+static inline int security_getprocattr(struct task_struct *p, char *name, void *value, size_t size)
+{
+	return -EINVAL;
+}
+
+static inline int security_setprocattr(struct task_struct *p, char *name, void *value, size_t size)
+{
+	return -EINVAL;
+}
 
 /*
  * The netlink capability defaults need to be used inline by default
Index: linux-2.5/security/dummy.c
diff -u linux-2.5/security/dummy.c:1.1.1.2 linux-2.5/security/dummy.c:1.14
--- linux-2.5/security/dummy.c:1.1.1.2	Wed Mar 19 09:59:17 2003
+++ linux-2.5/security/dummy.c	Fri Apr 18 11:17:20 2003
@@ -736,6 +741,16 @@
 	return;
 }
 
+static int dummy_getprocattr(struct task_struct *p, char *name, void *value, size_t size)
+{
+	return -EINVAL;
+}
+
+static int dummy_setprocattr(struct task_struct *p, char *name, void *value, size_t size)
+{
+	return -EINVAL;
+}
+
 
 struct security_operations dummy_security_ops;
 
@@ -860,6 +876,8 @@
 	set_to_dummy_if_null(ops, register_security);
 	set_to_dummy_if_null(ops, unregister_security);
 	set_to_dummy_if_null(ops, d_instantiate);
+ 	set_to_dummy_if_null(ops, getprocattr);
+ 	set_to_dummy_if_null(ops, setprocattr);
 #ifdef CONFIG_SECURITY_NETWORK
 	set_to_dummy_if_null(ops, unix_stream_connect);
 	set_to_dummy_if_null(ops, unix_may_send);



-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

