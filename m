Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261718AbSJMVjz>; Sun, 13 Oct 2002 17:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261723AbSJMVjy>; Sun, 13 Oct 2002 17:39:54 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:52378 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261718AbSJMVjl>; Sun, 13 Oct 2002 17:39:41 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.42: accessfs 3/3: access permission filesystem
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Sun, 13 Oct 2002 23:45:20 +0200
Message-ID: <878z129fnz.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new permission managing file system. Furthermore, it
adds two modules, which make use of this file system.

One module allows granting capabilities based on user-/groupid. The
second module allows to grant access to lower numbered ports based on
user-/groupid, too.

Changes:
- fixed module reference counting
- fixed oops, when init_capabilities() failed
- my first try at locking. It seems to work here, but I do have UP
  only. So SMP might do nasty things, I just don't know.

Regards, Olaf.

diff -urN a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	Sat Oct 12 14:24:11 2002
+++ b/MAINTAINERS	Sat Oct 12 17:38:40 2002
@@ -138,6 +138,12 @@
 L:	linux-aio@kvack.org
 S:	Supported
 
+ACCESS FILE SYSTEM
+P:	Olaf Dietsche
+M:	olaf.dietsche@t-online.de
+M:	olaf.dietsche@gmx.net
+S:	Maintained
+
 ACENIC DRIVER
 P:	Jes Sorensen
 M:	jes@trained-monkey.org
diff -urN a/fs/Config.in b/fs/Config.in
--- a/fs/Config.in	Sat Oct 12 14:24:17 2002
+++ b/fs/Config.in	Sat Oct 12 17:38:40 2002
@@ -108,6 +108,9 @@
    define_bool CONFIG_QUOTACTL y
 fi
 
+dep_tristate 'Accessfs support (EXPERIMENTAL)' CONFIG_ACCESS_FS $CONFIG_EXPERIMENTAL
+source fs/accessfs/Config.in
+
 if [ "$CONFIG_NET" = "y" ]; then
 
    mainmenu_option next_comment
diff -urN a/fs/Makefile b/fs/Makefile
--- a/fs/Makefile	Sat Oct 12 14:24:17 2002
+++ b/fs/Makefile	Sat Oct 12 17:38:40 2002
@@ -84,5 +84,6 @@
 obj-$(CONFIG_SUN_OPENPROMFS)	+= openpromfs/
 obj-$(CONFIG_JFS_FS)		+= jfs/
 obj-$(CONFIG_XFS_FS)		+= xfs/
+obj-$(CONFIG_ACCESS_FS)		+= accessfs/
 
 include $(TOPDIR)/Rules.make
diff -urN a/fs/accessfs/Config.help b/fs/accessfs/Config.help
--- a/fs/accessfs/Config.help	Thu Jan  1 01:00:00 1970
+++ b/fs/accessfs/Config.help	Sat Oct 12 17:38:40 2002
@@ -0,0 +1,68 @@
+Accessfs support (EXPERIMENTAL)
+CONFIG_ACCESS_FS
+  This is a new file system to manage permissions. It is not very
+  useful on its own. You need to enable other options below.
+
+  The recommended mount point for this file-system is /proc/access,
+  which will appear automatically in the /proc filesystem.
+
+  If you're unsure, say N.
+
+User permission based IP ports
+CONFIG_ACCESSFS_USER_PORTS
+  If you say Y here, you will be able to control access to IP ports
+  based on user-/groupid. For this to work, you must say Y
+  to CONFIG_NET_HOOKS.
+
+  With this option, there's no need anymore to run internet daemons
+  as root. You can individually configure which user/program can bind to
+  protected ports (by default, below 1024).
+
+  For example, you can say, user www is allowed to bind to port 80 or
+  user mail is allowed to bind to port 25. Then, you can run apache as
+  user www and sendmail as user mail. Now, you don't have to rely on
+  apache or sendmail giving up superuser rights to enhance security.
+
+  To use this option, you need to mount the access file system
+  and do a chown on the appropriate ports:
+
+  # mount -t accessfs none /proc/access
+  # chown www /proc/access/net/ip/bind/80
+  # chown mail /proc/access/net/ip/bind/25
+
+  You can grant access to a group for individual ports as well. Just say:
+
+  # chgrp lp /proc/access/net/ip/bind/515
+  # chown g+x /proc/access/net/ip/bind/515
+
+  If you're unsure, say N.
+
+Range of protected ports
+CONFIG_ACCESSFS_PROT_SOCK
+  Here you can extend the range of protected ports. This is
+  from 1-1023 inclusive on normal unix systems. One use for this
+  could be to reserve ports for X11 (port 6000) or database
+  servers (port 3306 for mysql), so nobody else could grab this port.
+  The default permission for extended ports is --x--x--x.
+
+  If you build this as a module, you can specify the range of
+  protected ports at module load time (max_prot_sock).
+
+  If you're unsure, say 1024.
+
+User permission based capabilities
+CONFIG_ACCESSFS_USER_CAPABILITIES
+  If you say Y here, you will be able to grant capabilities based on
+  user-/groupid (root by default). For this to work, you must say M or
+  N to CONFIG_SECURITY_CAPABILITIES.
+
+  For example you can create a group raw and change the capability
+  net_raw to this group:
+
+  # chgrp raw /proc/access/capabilities/net_raw
+  # chmod ug+x /proc/access/capabilities/net_raw
+  # chgrp raw /sbin/ping
+  # chmod u-s /sbin/ping; chmod g+s /sbin/ping
+
+  If you're unsure, say N.
+
diff -urN a/fs/accessfs/Config.in b/fs/accessfs/Config.in
--- a/fs/accessfs/Config.in	Thu Jan  1 01:00:00 1970
+++ b/fs/accessfs/Config.in	Sat Oct 12 17:38:40 2002
@@ -0,0 +1,11 @@
+#
+# Accessfs configuration
+#
+
+if [ "$CONFIG_ACCESS_FS" != "n" ]; then
+	dep_tristate '  User permission based capabilities' CONFIG_ACCESSFS_USER_CAPABILITIES $CONFIG_ACCESS_FS
+	dep_tristate '  User permission based IP ports' CONFIG_ACCESSFS_USER_PORTS $CONFIG_ACCESS_FS
+	if [ "$CONFIG_ACCESSFS_USER_PORTS" != "n" ]; then
+		int '  Range of protected ports (1024-65536)' CONFIG_ACCESSFS_PROT_SOCK 1024
+	fi
+fi
diff -urN a/fs/accessfs/Makefile b/fs/accessfs/Makefile
--- a/fs/accessfs/Makefile	Thu Jan  1 01:00:00 1970
+++ b/fs/accessfs/Makefile	Sun Oct 13 16:44:35 2002
@@ -0,0 +1,13 @@
+#
+# Makefile for the linux accessfs routines.
+#
+
+obj-$(CONFIG_ACCESS_FS) += accessfs.o
+obj-$(CONFIG_ACCESSFS_USER_CAPABILITIES) += usercaps.o
+obj-$(CONFIG_ACCESSFS_USER_PORTS) += userports.o
+export-objs := inode.o
+accessfs-objs := inode.o
+usercaps-objs := capabilities.o
+userports-objs := ip.o
+
+include $(TOPDIR)/Rules.make
diff -urN a/fs/accessfs/capabilities.c b/fs/accessfs/capabilities.c
--- a/fs/accessfs/capabilities.c	Thu Jan  1 01:00:00 1970
+++ b/fs/accessfs/capabilities.c	Sun Oct 13 18:50:48 2002
@@ -0,0 +1,120 @@
+/* Copyright (c) 2002 Olaf Dietsche
+ *
+ * User based capabilities for Linux.
+ */
+
+#include <linux/accessfs_fs.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/security.h>
+
+static struct access_attr caps[29];
+static const char *names[] = {
+	"chown",
+	"dac_override",
+	"dac_read_search",
+	"fowner",
+	"fsetid",
+	"kill",
+	"setgid",
+	"setuid",
+	"setpcap",
+	"linux_immutable",
+	"net_bind_service",
+	"net_broadcast",
+	"net_admin",
+	"net_raw",
+	"ipc_lock",
+	"ipc_owner",
+	"sys_module",
+	"sys_rawio",
+	"sys_chroot",
+	"sys_ptrace",
+	"sys_pacct",
+	"sys_admin",
+	"sys_boot",
+	"sys_nice",
+	"sys_resource",
+	"sys_time",
+	"sys_tty_config",
+	"mknod",
+	"lease"
+};
+
+static int accessfs_capable(struct task_struct *tsk, int cap)
+{
+	if (accessfs_permitted(&caps[cap], MAY_EXEC)) {
+		/* capability granted */
+		tsk->flags |= PF_SUPERPRIV;
+		return 0;
+	}
+
+	/* capability denied */
+	return -EPERM;
+}
+
+static struct security_operations accessfs_security_ops = {
+	.capable =	accessfs_capable,
+};
+
+static void __init fill_empty_from(struct security_operations *to, const struct security_operations *from)
+{
+	unsigned long *__from = (unsigned long *) from;
+	unsigned long *__to = (unsigned long *) to;
+	unsigned long *__end = __to + sizeof(*to) / sizeof(unsigned long *);
+	while (__to != __end) {
+		if (*__to == 0)
+			*__to = *__from;
+
+		++__to;
+		++__from;
+	}
+}
+
+static void unregister_capabilities(struct accessfs_direntry *dir, int n)
+{
+	int	i;
+	for (i = 0; i < n; ++i) {
+		accessfs_unregister(dir, names[i]);
+	}
+}
+
+static int __init init_capabilities(void)
+{
+	struct accessfs_direntry *dir = accessfs_make_dirpath("capabilities");
+	int i, rc;
+	if (dir == 0)
+		return -ENOTDIR;
+
+	for (i = 0; i < sizeof(caps) / sizeof(caps[0]); ++i) {
+		caps[i].uid = 0;
+		caps[i].gid = 0;
+		caps[i].mode = S_IXUSR;
+		rc = accessfs_register(dir, names[i], &caps[i]);
+		if (rc != 0) {
+			unregister_capabilities(dir, i);
+			return rc;
+		}
+	}
+
+	fill_empty_from(&accessfs_security_ops, security_ops);
+	rc = register_security(&accessfs_security_ops);
+	if (rc != 0)
+		unregister_capabilities(dir, sizeof(names) / sizeof(names[0]));
+
+	return rc;
+}
+
+static void __exit exit_capabilities(void)
+{
+	struct accessfs_direntry *dir = accessfs_make_dirpath("capabilities");
+	unregister_security(&accessfs_security_ops);
+	unregister_capabilities(dir, sizeof(names) / sizeof(names[0]));
+}
+
+module_init(init_capabilities)
+module_exit(exit_capabilities)
+
+MODULE_AUTHOR("Olaf Dietsche");
+MODULE_DESCRIPTION("User based capabilities");
+MODULE_LICENSE("GPL");
diff -urN a/fs/accessfs/inode.c b/fs/accessfs/inode.c
--- a/fs/accessfs/inode.c	Thu Jan  1 01:00:00 1970
+++ b/fs/accessfs/inode.c	Sun Oct 13 19:17:39 2002
@@ -0,0 +1,429 @@
+/* Copyright (c) 2001 Olaf Dietsche
+ *
+ * Access permission filesystem for Linux.
+ *
+ * 2002 Ben Clifford, create mount point at /proc/access
+ * 2002 Ben Clifford, trying to make it work under 2.5.5-dj2
+ *          (see comments: BENC255 for reminders and todos)
+ *
+ *
+ * BENC255: the kernel doesn't lock BKL for us when entering methods 
+ *          (see Documentation/fs/porting.txt)
+ *          Need to look at code here and see if we need either the BKL
+ *          or our own lock - I think probably not.
+ *
+ */
+
+#include <linux/accessfs_fs.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/pagemap.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/proc_fs.h>
+
+#include <asm/uaccess.h>
+
+#define ACCESSFS_MAGIC	0x3c1d36e7
+
+#ifdef CONFIG_PROC_FS           
+static struct proc_dir_entry *mountdir = NULL;
+#endif
+
+spinlock_t accessfs_lock = SPIN_LOCK_UNLOCKED;
+
+static struct inode_operations accessfs_inode_operations;
+static struct file_operations accessfs_dir_file_operations;
+static struct inode_operations accessfs_dir_inode_operations;
+
+static int accessfs_statfs(struct super_block *sb, struct statfs *buf)
+{
+	buf->f_type = ACCESSFS_MAGIC;
+	buf->f_bsize = PAGE_CACHE_SIZE;
+	buf->f_namelen = 255;
+	return 0;
+}
+
+static inline void accessfs_readdir_aux(struct file *filp, struct accessfs_direntry *dir, int start, void *dirent, filldir_t filldir)
+{
+	struct list_head *list;
+	int i;
+
+	list = dir->children.next;
+	for (i = 2; i < start && list != &dir->children; ++i)
+		list = list->next;
+
+	while (list != &dir->children) {
+		struct accessfs_entry *de;
+		de = list_entry(list, struct accessfs_entry, siblings);
+		if (filldir(dirent, de->name, strlen(de->name), filp->f_pos, de->ino, DT_UNKNOWN) < 0)
+			break;
+
+		++filp->f_pos;
+		list = list->next;
+	}
+}
+
+static int accessfs_readdir(struct file *filp, void *dirent, filldir_t filldir)
+{
+	int i;
+	struct dentry *dentry = filp->f_dentry;
+	struct accessfs_direntry *dir;
+
+	i = filp->f_pos;
+	switch (i) {
+	case 0:
+		if (filldir(dirent, ".", 1, i, dentry->d_inode->i_ino, DT_DIR) < 0)
+			break;
+
+		++i;
+		++filp->f_pos;
+		/* NO break; */
+	case 1:
+		if (filldir(dirent, "..", 2, i, dentry->d_parent->d_inode->i_ino, DT_DIR) < 0)
+			break;
+
+		++i;
+		++filp->f_pos;
+		/* NO break; */
+	default:
+		spin_lock(&accessfs_lock);
+		dir = (struct accessfs_direntry *) dentry->d_inode->u.generic_ip;
+		accessfs_readdir_aux(filp, dir, i, dirent, filldir);
+		spin_unlock(&accessfs_lock);
+		break;
+	}
+
+	return 0;
+}
+
+static struct accessfs_entry *accessfs_lookup_entry(struct accessfs_entry *pe, const char *name, int len)
+{
+	if (S_ISDIR(pe->attr->mode)) {
+		struct list_head *list;
+		struct accessfs_direntry *dir;
+		dir = (struct accessfs_direntry *) pe;
+		list_for_each(list, &dir->children) {
+			struct accessfs_entry *de;
+			de = list_entry(list, struct accessfs_entry, siblings);
+			if (strncmp(de->name, name, len) == 0 && de->name[len] == 0)
+				return de;
+		}
+	}
+
+	return NULL;
+}
+
+static struct dentry *accessfs_lookup(struct inode *dir, struct dentry *dentry)
+{
+	struct inode *inode = NULL;
+	struct accessfs_entry *pe;
+	spin_lock(&accessfs_lock);
+	pe = accessfs_lookup_entry(dir->u.generic_ip, dentry->d_name.name, dentry->d_name.len);
+	if (pe)
+		inode = iget(dir->i_sb, pe->ino);
+
+	d_add(dentry, inode);
+	spin_unlock(&accessfs_lock);
+	return NULL;
+}
+
+static struct accessfs_direntry	accessfs_rootdir = {
+	{ "/", 
+	  LIST_HEAD_INIT(accessfs_rootdir.node.hash), 
+	  LIST_HEAD_INIT(accessfs_rootdir.node.siblings), 
+	  1, &accessfs_rootdir.attr },
+	NULL, LIST_HEAD_INIT(accessfs_rootdir.children), 
+	{ 0, 0, S_IFDIR | 0755 }
+};
+
+static void accessfs_init_inode(struct inode *inode, struct accessfs_entry *pe)
+{
+	inode->u.generic_ip = pe;
+	inode->i_uid = pe->attr->uid;
+	inode->i_gid = pe->attr->gid;
+	inode->i_mode = pe->attr->mode;
+/*
+	inode->i_blksize = PAGE_CACHE_SIZE;
+	inode->i_blocks = 0;
+	inode->i_rdev = NODEV;
+*/
+	inode->i_atime = inode->i_mtime = inode->i_ctime = 0;
+	switch (inode->i_mode & S_IFMT) {
+	case S_IFREG:
+		inode->i_op = &accessfs_inode_operations;
+		break;
+	case S_IFDIR:
+		inode->i_op = &accessfs_dir_inode_operations;
+		inode->i_fop = &accessfs_dir_file_operations;
+		break;
+	default:
+		printk(KERN_ERR "accessfs_init_inode(): '%s' unhandled mode=%d\n", pe->name, inode->i_mode);
+		BUG();
+		break;
+	}
+}
+
+static struct inode *accessfs_get_root_inode(struct super_block *sb)
+{
+	struct inode *inode = new_inode(sb);
+	if (inode) {
+		spin_lock(&accessfs_lock);
+/* 		inode->i_ino = accessfs_rootdir.node.ino; */
+		accessfs_init_inode(inode, &accessfs_rootdir.node);
+		accessfs_rootdir.node.ino = inode->i_ino;
+		spin_unlock(&accessfs_lock);
+	}
+
+	return inode;
+}
+
+static LIST_HEAD(hash);
+
+static int accessfs_node_init(struct accessfs_direntry *parent, struct accessfs_entry *de, const char *name, size_t len, struct access_attr *attr, mode_t mode)
+{
+	static unsigned long ino = 1;
+	de->name = kmalloc(len + 1, GFP_KERNEL);
+	if (de->name == NULL)
+		return -ENOMEM;
+
+	strncpy(de->name, name, len);
+	de->name[len] = 0;
+	de->ino = ++ino;
+	de->attr = attr;
+	de->attr->uid = 0;
+	de->attr->gid = 0;
+	de->attr->mode = mode;
+	list_add_tail(&de->hash, &hash);
+	list_add_tail(&de->siblings, &parent->children);
+	return 0;
+}
+
+static int accessfs_mknod(struct accessfs_direntry *dir, const char *name, struct access_attr *attr)
+{
+	struct accessfs_entry *pe;
+	pe = kmalloc(sizeof(struct accessfs_entry), GFP_KERNEL);
+	if (pe == NULL)
+		return -ENOMEM;
+
+	spin_lock(&accessfs_lock);
+	accessfs_node_init(dir, pe, name, strlen(name), attr, S_IFREG | attr->mode);
+	spin_unlock(&accessfs_lock);
+	return 0;
+}
+
+static struct accessfs_direntry	*accessfs_mkdir(struct accessfs_direntry *parent, const char *name, size_t len)
+{
+	int error;
+	struct accessfs_direntry *dir;
+	dir = kmalloc(sizeof(struct accessfs_direntry), GFP_KERNEL);
+	if (dir == NULL)
+		return NULL;
+
+	spin_lock(&accessfs_lock);
+	error = accessfs_node_init(parent, &dir->node, name, len, &dir->attr, S_IFDIR | 0755);
+	if (error) {
+		kfree(dir);
+		dir = 0;
+	} else {
+		dir->parent = parent;
+		INIT_LIST_HEAD(&dir->children);
+	}
+
+	spin_unlock(&accessfs_lock);
+	return dir;
+}
+
+struct accessfs_direntry *accessfs_make_dirpath(const char *name)
+{
+	struct accessfs_direntry *dir = &accessfs_rootdir;
+	const char *slash;
+	do {
+		struct accessfs_entry *de;
+		size_t len;
+		while (*name == '/')
+			++name;
+
+		slash = strchr(name, '/');
+		len = slash ? slash - name : strlen(name);
+		de = accessfs_lookup_entry(&dir->node, name, len);
+		if (de == NULL) {
+			dir = accessfs_mkdir(dir, name, len);
+		} else if (S_ISDIR(de->attr->mode)) {
+			dir = (struct accessfs_direntry *) de;
+		} else {
+			return NULL;
+		}
+
+		if (dir == NULL)
+			return NULL;
+
+		name = slash  + 1;
+	} while (slash != NULL);
+
+	return dir;
+}
+
+static void accessfs_unlink(struct accessfs_entry *pe)
+{
+	spin_lock(&accessfs_lock);
+	list_del(&pe->hash);
+	list_del(&pe->siblings);
+	kfree(pe->name);
+	kfree(pe);
+	spin_unlock(&accessfs_lock);
+}
+
+static int accessfs_notify_change(struct dentry *dentry, struct iattr *iattr)
+{
+	struct inode *i = dentry->d_inode;
+	int error = inode_setattr(i, iattr);
+	if (!error) {
+		struct accessfs_entry *pe;
+		pe = (struct accessfs_entry *) i->u.generic_ip;
+		pe->attr->uid = i->i_uid;
+		pe->attr->gid = i->i_gid;
+		pe->attr->mode = i->i_mode;
+	}
+
+	return error;
+}
+
+static void accessfs_read_inode(struct inode *inode)
+{
+	ino_t	ino = inode->i_ino;
+	struct list_head	*list;
+	spin_lock(&accessfs_lock);
+	list_for_each(list, &hash) {
+		struct accessfs_entry *pe;
+		pe = list_entry(list, struct accessfs_entry, hash);
+		if (pe->ino == ino) {
+			accessfs_init_inode(inode, pe);
+			break;
+		}
+	}
+
+	spin_unlock(&accessfs_lock);
+}
+
+static struct inode_operations accessfs_inode_operations = {
+	.setattr =	accessfs_notify_change,
+};
+
+static struct inode_operations accessfs_dir_inode_operations = {
+	.lookup =	accessfs_lookup,
+	.setattr =	accessfs_notify_change,
+};
+
+static struct file_operations accessfs_dir_file_operations = {
+	.readdir =	accessfs_readdir,
+};
+
+static struct super_operations accessfs_ops = {
+	.read_inode =	accessfs_read_inode,
+	.statfs =		accessfs_statfs,
+};
+
+static int accessfs_fill_super(struct super_block *sb, void *data, int silent)
+{
+	struct inode *inode;
+	struct dentry *root;
+
+	sb->s_blocksize = PAGE_CACHE_SIZE;
+	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
+	sb->s_magic = ACCESSFS_MAGIC;
+	sb->s_op = &accessfs_ops;
+	inode = accessfs_get_root_inode(sb);
+	if (!inode)
+		return -ENOMEM;
+
+	root = d_alloc_root(inode);
+	if (!root) {
+		iput(inode);
+		return -ENOMEM;
+	}
+
+	sb->s_root = root;
+	MOD_INC_USE_COUNT;
+	return 0;
+}
+
+static struct super_block *accessfs_get_sb(struct file_system_type *fs_type, int flags, char *dev_name, void *data)
+{
+	return get_sb_single(fs_type, flags, data, accessfs_fill_super);
+}
+
+static void accessfs_kill_sb(struct super_block *sb)
+{
+	kill_anon_super(sb);
+	MOD_DEC_USE_COUNT;
+}
+
+int accessfs_permitted(struct access_attr *p, int mask)
+{
+	mode_t mode = p->mode;
+	if (current->fsuid == p->uid)
+		mode >>= 6;
+	else if (in_group_p(p->gid))
+		mode >>= 3;
+
+	return (mode & mask) == mask;
+}
+
+int accessfs_register(struct accessfs_direntry *dir, const char *name, struct access_attr *attr)
+{
+	if (dir == 0)
+		return -EINVAL;
+
+	return accessfs_mknod(dir, name, attr);
+}
+
+void accessfs_unregister(struct accessfs_direntry *dir, const char *name)
+{
+	struct accessfs_entry *pe;
+	spin_lock(&accessfs_lock);
+	pe = accessfs_lookup_entry(&dir->node, name, strlen(name));
+	if (pe) {
+		accessfs_unlink(pe);
+	}
+
+	spin_unlock(&accessfs_lock);
+}
+
+static struct file_system_type accessfs_fs_type = {
+	.name =		"accessfs",
+	.get_sb =	accessfs_get_sb,
+	.kill_sb =	accessfs_kill_sb,
+};
+
+static int __init init_accessfs_fs(void)
+{
+
+#ifdef CONFIG_PROC_FS
+	/* create mount point for accessfs */
+	mountdir = proc_mkdir("access",&proc_root);
+#endif
+	return register_filesystem(&accessfs_fs_type);
+}
+
+static void __exit exit_accessfs_fs(void)
+{
+	unregister_filesystem(&accessfs_fs_type);
+
+#ifdef CONFIG_PROC_FS
+	remove_proc_entry("access",&proc_root);
+#endif
+}
+
+module_init(init_accessfs_fs)
+module_exit(exit_accessfs_fs)
+
+MODULE_AUTHOR("Olaf Dietsche");
+MODULE_DESCRIPTION("Access Filesystem");
+MODULE_LICENSE("GPL");
+
+EXPORT_SYMBOL(accessfs_permitted);
+EXPORT_SYMBOL(accessfs_make_dirpath);
+EXPORT_SYMBOL(accessfs_register);
+EXPORT_SYMBOL(accessfs_unregister);
diff -urN a/fs/accessfs/ip.c b/fs/accessfs/ip.c
--- a/fs/accessfs/ip.c	Thu Jan  1 01:00:00 1970
+++ b/fs/accessfs/ip.c	Sun Oct 13 16:56:30 2002
@@ -0,0 +1,92 @@
+/* Copyright (c) 2002 Olaf Dietsche
+ *
+ * User permission based port access for Linux.
+ */
+
+#include <linux/accessfs_fs.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <net/sock.h>
+
+static int max_prot_sock = CONFIG_ACCESSFS_PROT_SOCK;
+static struct access_attr *bind_to_port;
+
+static int accessfs_ip_prot_sock(struct socket *sock,
+				 struct sockaddr *uaddr, int addr_len)
+{
+	struct sockaddr_in *addr = (struct sockaddr_in *) uaddr;
+	unsigned short snum = ntohs(addr->sin_port);
+	if (snum && snum < max_prot_sock
+	    && !accessfs_permitted(&bind_to_port[snum], MAY_EXEC)
+	    && !capable(CAP_NET_BIND_SERVICE))
+		return -EACCES;
+
+	return 0;
+}
+
+static int accessfs_ip6_prot_sock(struct socket *sock,
+				  struct sockaddr *uaddr, int addr_len)
+{
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+	struct sockaddr_in6 *addr = (struct sockaddr_in6 *) uaddr;
+	unsigned short snum = ntohs(addr->sin6_port);
+	if (snum && snum < max_prot_sock
+	    && !accessfs_permitted(&bind_to_port[snum], MAY_EXEC)
+	    && !capable(CAP_NET_BIND_SERVICE))
+		return -EACCES;
+
+	return 0;
+#else
+	return -EACCES;
+#endif
+}
+
+static struct net_hook_operations ip_net_ops = {
+	.ip_prot_sock =	accessfs_ip_prot_sock,
+	.ip6_prot_sock =	accessfs_ip6_prot_sock,
+};
+
+static int __init init_ip(void)
+{
+	struct accessfs_direntry *dir = accessfs_make_dirpath("net/ip/bind");
+	int i;
+	bind_to_port = kmalloc(max_prot_sock * sizeof(*bind_to_port), GFP_KERNEL);
+	if (bind_to_port == 0)
+		return -ENOMEM;
+
+	for (i = 1; i < max_prot_sock; ++i) {
+		char	buf[sizeof("65536")];
+		bind_to_port[i].uid = 0;
+		bind_to_port[i].gid = 0;
+		bind_to_port[i].mode = i < PROT_SOCK ? S_IXUSR : S_IXUGO;
+		sprintf(buf, "%d", i);
+		accessfs_register(dir, buf, &bind_to_port[i]);
+	}
+
+	net_hooks_register(&ip_net_ops);
+	return 0;
+}
+
+static void __exit exit_ip(void)
+{
+	struct accessfs_direntry *dir = accessfs_make_dirpath("net/ip/bind");
+	int i;
+	net_hooks_unregister(&ip_net_ops);
+	for (i = 1; i < max_prot_sock; ++i) {
+		char	buf[sizeof("65536")];
+		sprintf(buf, "%d", i);
+		accessfs_unregister(dir, buf);
+	}
+
+	if (bind_to_port != 0)
+		kfree(bind_to_port);
+}
+
+module_init(init_ip)
+module_exit(exit_ip)
+
+MODULE_AUTHOR("Olaf Dietsche");
+MODULE_DESCRIPTION("User based IP ports permission");
+MODULE_LICENSE("GPL");
+MODULE_PARM(max_prot_sock, "i");
+MODULE_PARM_DESC(max_prot_sock, "Number of protected ports");
diff -urN a/include/linux/accessfs_fs.h b/include/linux/accessfs_fs.h
--- a/include/linux/accessfs_fs.h	Thu Jan  1 01:00:00 1970
+++ b/include/linux/accessfs_fs.h	Sun Oct 13 17:11:15 2002
@@ -0,0 +1,49 @@
+/* -*- mode: c -*- */
+#ifndef __accessfs_fs_h_included__
+#define __accessfs_fs_h_included__	1
+
+/* Copyright (c) 2001 Olaf Dietsche
+ *
+ * Access permission filesystem for Linux.
+ */
+
+#include <linux/config.h>
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <net/sock.h>
+
+struct access_attr {
+	uid_t	uid;
+	gid_t	gid;
+	mode_t	mode;
+};
+
+struct accessfs_entry {
+	char	*name;
+	struct list_head	hash;
+	struct list_head	siblings;
+	ino_t	ino;
+	struct access_attr	*attr;
+};
+
+struct accessfs_direntry {
+	struct accessfs_entry	node;
+	struct accessfs_direntry	*parent;
+	struct list_head	children;
+	struct access_attr	attr;
+};
+
+extern int accessfs_permitted(struct access_attr *p, int mask);
+extern struct accessfs_direntry *accessfs_make_dirpath(const char *name);
+extern int accessfs_register(struct accessfs_direntry *dir, const char *name, struct access_attr *attr);
+extern void accessfs_unregister(struct accessfs_direntry *dir, const char *name);
+
+#if  CONFIG_ACCESSFS_PROT_SOCK < PROT_SOCK
+#define CONFIG_ACCESSFS_PROT_SOCK	PROT_SOCK
+#elseif CONFIG_ACCESSFS_PROT_SOCK > 65536
+#define CONFIG_ACCESSFS_PROT_SOCK	65536
+#endif
+
+#endif
