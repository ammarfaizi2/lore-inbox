Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbTDHUHO (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 16:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbTDHUHO (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 16:07:14 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:6580 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261570AbTDHUHF (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 16:07:05 -0400
Subject: [RFC][PATCH] Process Attribute API for Security Modules
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alexander Viro <viro@math.psu.edu>, lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Apr 2003 16:17:52 -0400
Message-Id: <1049833073.1018.9.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As part of preparing SELinux for submission to mainline 2.5, the SELinux
API is being reworked based on earlier discussions (starting when
sys_security was removed from 2.5).  As a preliminary step toward
submitting SELinux, I'd like to request comments on a new process
attribute API for security modules that is implemented via nodes in a
/proc/PID/attr directory (credit for that idea goes to Al Viro).  This
message includes a patch against 2.5.67 (also available from 
http://www.nsa.gov/lk/A01proc.patch.gz) that implements the changes to
the base kernel and the LSM framework to support such a process
attribute API.  You can obtain a full SELinux patch against 2.5.67 that
includes these changes along with the SELinux code that uses them from
http://www.nsa.gov/selinux/lk/2.5.67-selinux1.patch.gz, and some
relevant userland components from
http://www.nsa.gov/selinux/lk/selinux-2.5.tgz.  Note that the full
SELinux patch also contains some other changes to the base kernel and
LSM framework that will be submitted as separate RFCs.

The patch below implements a /proc/PID/attr directory with three nodes
that can be read and written to get and set the corresponding attribute
values.  The get and set operations are implemented by the security
module using the getprocattr and setprocattr hook functions.  The
intended meaning of the three nodes is described below, along with an
explanation of the SELinux semantics as an example of how they are used:

1) /proc/PID/attr/current represents the current attributes of the
process.  In SELinux, this node is used to get the security context of a
process, but not to set the security context (a write is always denied),
since SELinux limits process security transitions to execve (see
below).  Other security modules may choose to support set operations via
writes to this node, and the patch allows for such usage.

2) /proc/PID/attr/exec represents the attributes to assign to the
process upon a subsequent execve call.  A write to this node followed by
an execve replaces the execve_secure call of the original SELinux API. 
This is needed to support role/domain transitions in SELinux, and execve
is the preferred point to make such transitions because it offers better
control over the initialization of the process in the new security label
and the inheritance of state.  In SELinux, this attribute is reset on
execve after use so that the new program reverts to the default behavior
for any exec calls that it may make.  In SELinux, a process can only set
its own /proc/PID/attr/exec attribute.

3) /proc/PID/attr/fscreate represents the attributes to assign to files
created by subsequent calls to open, mkdir, symlink, and mknod. A write
to this node followed by a file creation call replaces the extended file
creation calls of the original SELinux API.  This call is necessary to
support creation of a file in a secure state, so that there is no risk
of inappropriate access being obtained between the time of creation and
the time that attributes are set.  Using a single default based on the
parent directory is inadequate, e.g. /etc/shadow and /etc/passwd require
different security protections, but are re-created in the same parent
directory on each transaction.  In SELinux, this attribute is also reset
on execve so that the new program reverts to the default behavior for
any file creation calls it may make, but the attribute will persist
across multiple file creation calls within a program unless it is
explicitly reset.  In SELinux, a process can only set its own
/proc/PID/attr/fscreate attribute.

 fs/proc/base.c           |  250 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/security.h |   23 ++++
 security/dummy.c         |   12 ++
 3 files changed, 285 insertions(+)

Index: linux-2.5/fs/proc/base.c
diff -u linux-2.5/fs/proc/base.c:1.1.1.2 linux-2.5/fs/proc/base.c:1.5
--- linux-2.5/fs/proc/base.c:1.1.1.2	Tue Apr  8 09:47:57 2003
+++ linux-2.5/fs/proc/base.c	Tue Apr  8 10:15:57 2003
@@ -58,6 +58,10 @@
 	PROC_PID_MAPS,
 	PROC_PID_MOUNTS,
 	PROC_PID_WCHAN,
+	PROC_PID_ATTR,
+	PROC_PID_ATTR_CURRENT,
+	PROC_PID_ATTR_EXEC,
+	PROC_PID_ATTR_FSCREATE,
 	PROC_PID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
 };
 
@@ -82,11 +86,18 @@
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
+  E(PROC_PID_ATTR_EXEC,		"exec",		S_IFREG|S_IRUGO|S_IWUSR),
+  E(PROC_PID_ATTR_FSCREATE,	"fscreate",	S_IFREG|S_IRUGO|S_IWUSR),
+  {0,0,NULL,0}
+};
 #undef E
 
 static inline struct task_struct *proc_task(struct inode *inode)
@@ -961,6 +972,240 @@
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
+#define ATTRGET(name) \
+static ssize_t proc_pid_attr_get##name(struct task_struct *task, char *buffer, size_t count) \
+{ \
+	return security_getprocattr(task, #name , buffer, count); \
+}
+ATTRGET(current)
+ATTRGET(exec)
+ATTRGET(fscreate)
+#undef ATTRGET
+
+static ssize_t proc_pid_attr_read(struct file * file, char * buf,
+				  size_t count, loff_t *ppos,
+				  int (*attr_read)(struct task_struct *task, char *page, size_t count))
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
+	length = attr_read(task, (char*)page, count);
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
+#define ATTRREAD(name) \
+static ssize_t proc_pid_attr_read##name(struct file * file, \
+					char * buf, \
+					size_t count, loff_t *ppos) \
+{ \
+	return proc_pid_attr_read(file, buf, count, ppos, proc_pid_attr_get##name); \
+}
+ATTRREAD(current);
+ATTRREAD(exec);
+ATTRREAD(fscreate);
+#undef ATTRREAD
+
+#define ATTRSET(name) \
+static ssize_t proc_pid_attr_set##name(struct task_struct *task, char *buffer, size_t count) \
+{ \
+	return security_setprocattr(task, #name , buffer, count); \
+}
+ATTRSET(current)
+ATTRSET(exec)
+ATTRSET(fscreate)
+#undef ATTRSET
+
+static ssize_t proc_pid_attr_write(struct file * file, const char * buf,
+				   size_t count, loff_t *ppos,
+				   int (*attr_write)(struct task_struct *task, char *page, size_t count))
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
+	length = attr_write(task, page, count);
+out:
+	free_page((unsigned long) page);
+	return length;
+} 
+
+#define ATTRWRITE(name) \
+static ssize_t proc_pid_attr_write##name(struct file * file, \
+					 const char * buf, \
+					 size_t count, loff_t *ppos) \
+{ \
+	return proc_pid_attr_write(file, buf, count, ppos, proc_pid_attr_set##name); \
+}
+ATTRWRITE(current);
+ATTRWRITE(exec);
+ATTRWRITE(fscreate);
+#undef ATTRWRITE
+
+#define ATTROPS(name) \
+static struct file_operations proc_pid_attr_##name##_operations = { \
+	.read		= proc_pid_attr_read##name, \
+	.write		= proc_pid_attr_write##name, \
+};
+ATTROPS(current);
+ATTROPS(exec);
+ATTROPS(fscreate);
+#undef ATTROPS
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
+	/*
+	 * Yes, it does not scale. And it should not. Don't add
+	 * new entries into /proc/<pid>/attr without very good reasons.
+	 */
+	switch(p->type) {
+		case PROC_PID_ATTR_CURRENT:
+			inode->i_fop = &proc_pid_attr_current_operations;
+			break;
+		case PROC_PID_ATTR_EXEC:
+			inode->i_fop = &proc_pid_attr_exec_operations;
+			break;
+		case PROC_PID_ATTR_FSCREATE:
+			inode->i_fop = &proc_pid_attr_fscreate_operations;
+			break;
+		default:
+			printk("procfs: impossible type (%d)",p->type);
+			iput(inode);
+			return ERR_PTR(-EINVAL);
+	}
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
@@ -1040,6 +1285,11 @@
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
diff -u linux-2.5/include/linux/security.h:1.1.1.2 linux-2.5/include/linux/security.h:1.13
--- linux-2.5/include/linux/security.h:1.1.1.2	Wed Mar 19 09:54:58 2003
+++ linux-2.5/include/linux/security.h	Tue Apr  1 15:27:53 2003
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
+	return -ENOSYS;
+}
+
+static inline int security_setprocattr(struct task_struct *p, char *name, void *value, size_t size)
+{
+	return -ENOSYS;
+}
 
 /*
  * The netlink capability defaults need to be used inline by default
Index: linux-2.5/security/dummy.c
diff -u linux-2.5/security/dummy.c:1.1.1.2 linux-2.5/security/dummy.c:1.11
--- linux-2.5/security/dummy.c:1.1.1.2	Wed Mar 19 09:59:17 2003
+++ linux-2.5/security/dummy.c	Mon Mar 31 16:37:37 2003
@@ -736,6 +741,16 @@
 	return;
 }
 
+static inline int dummy_getprocattr(struct task_struct *p, char *name, void *value, size_t size)
+{
+	return -ENOSYS;
+}
+
+static inline int dummy_setprocattr(struct task_struct *p, char *name, void *value, size_t size)
+{
+	return -ENOSYS;
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


