Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261755AbSIXTAv>; Tue, 24 Sep 2002 15:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261756AbSIXTAv>; Tue, 24 Sep 2002 15:00:51 -0400
Received: from p5084EB48.dip.t-dialin.net ([80.132.235.72]:12357 "EHLO
	goat.bogus.local") by vger.kernel.org with ESMTP id <S261755AbSIXTAb>;
	Tue, 24 Sep 2002 15:00:31 -0400
X-From-Line: nobody Tue Sep 24 17:39:56 2002
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: [PATCH] accessfs v0.5 ported to LSM - 2/2
From: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Date: Tue, 24 Sep 2002 17:39:56 +0200
Message-ID: <873crzpfar.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Accessfs is a new file system to control access to system resources.
For further information see the help text.

Changes:
- ported to LSM
- support capabilities
- merged ipv4/ipv6 into ip

This part (2/2) adds accessfs itself on top of (1/2).

The patch is attached below. It is also available at:
<http://home.t-online.de/home/olaf.dietsche/linux/accessfs-2.5.34-0.5-2_2.patch.gz>

It applies to 2.5.3[5-8] with some offsets.

I did minimal testing using uml 0.58-2.5.34.

Regards, Olaf.

diff -urN v2.5.34/fs/Config.in v2.5.34-accessfs/fs/Config.in
--- v2.5.34/fs/Config.in	Sun Sep  1 00:05:30 2002
+++ v2.5.34-accessfs/fs/Config.in	Tue Sep 24 14:57:10 2002
@@ -101,6 +101,9 @@
 tristate 'UFS file system support (read only)' CONFIG_UFS_FS
 dep_mbool '  UFS file system write support (DANGEROUS)' CONFIG_UFS_FS_WRITE $CONFIG_UFS_FS $CONFIG_EXPERIMENTAL
 
+dep_tristate 'Accessfs support (EXPERIMENTAL)' CONFIG_ACCESS_FS $CONFIG_EXPERIMENTAL
+source fs/accessfs/Config.in
+
 if [ "$CONFIG_NET" = "y" ]; then
 
    mainmenu_option next_comment
diff -urN v2.5.34/fs/Makefile v2.5.34-accessfs/fs/Makefile
--- v2.5.34/fs/Makefile	Tue Sep 24 11:52:13 2002
+++ v2.5.34-accessfs/fs/Makefile	Tue Sep 24 17:11:48 2002
@@ -81,6 +81,7 @@
 obj-$(CONFIG_AUTOFS_FS)		+= autofs/
 obj-$(CONFIG_AUTOFS4_FS)	+= autofs4/
 obj-$(CONFIG_ADFS_FS)		+= adfs/
+obj-$(CONFIG_ACCESS_FS)		+= accessfs/
 obj-$(CONFIG_REISERFS_FS)	+= reiserfs/
 obj-$(CONFIG_SUN_OPENPROMFS)	+= openpromfs/
 obj-$(CONFIG_JFS_FS)		+= jfs/
diff -urN v2.5.34/fs/accessfs/Config.help v2.5.34-accessfs/fs/accessfs/Config.help
--- v2.5.34/fs/accessfs/Config.help	Thu Jan  1 01:00:00 1970
+++ v2.5.34-accessfs/fs/accessfs/Config.help	Tue Sep 24 14:57:10 2002
@@ -0,0 +1,44 @@
+Accessfs support (EXPERIMENTAL)
+CONFIG_ACCESS_FS
+  This is a new file system to control access to system resources.
+  Currently it controls access to bind() for IPv4 and IPv6. 
+  Additionally you can grant capabilities to individual users or
+  groups (root by default). 
+
+  With this file system, there's no need anymore to run internet daemons
+  as root. You can individually configure which user/program can bind to
+  protected ports (by default, below 1024).
+
+  For example, you can say, user www is allowed to bind to port 80 or
+  user mail is allowed to bind to port 25. Then, you can run apache as
+  user www and sendmail as user mail. Now, you don't have to rely on
+  apache or sendmail giving up superuser rights to enhance security.
+
+  To use this file system, you need to mount the file system 
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
+  The recommended mount point for this file-system is /proc/access,
+  which will appear automatically in the /proc filesystem.
+
+  If you're unsure, say N.
+
+Range of protected ports
+CONFIG_ACCESSFS_PROT_SOCK
+  Here you can extend the range of protected ports. This is
+  from 1-1023 inclusive on normal unix systems. One use for this
+  could be to reserve ports for X11 (port 6000) or database
+  servers (port 3306 for mysql), so nobody else could grab this
+  port.
+  The default permission for extended ports is --x--x--x.
+
+  If you're unsure, say 1024.
+
diff -urN v2.5.34/fs/accessfs/Config.in v2.5.34-accessfs/fs/accessfs/Config.in
--- v2.5.34/fs/accessfs/Config.in	Thu Jan  1 01:00:00 1970
+++ v2.5.34-accessfs/fs/accessfs/Config.in	Tue Sep 24 14:57:10 2002
@@ -0,0 +1,7 @@
+#
+# Accessfs configuration
+#
+
+if [ "$CONFIG_ACCESS_FS" != "n" ]; then
+	int '  Range of protected ports (1024-65536)' CONFIG_ACCESSFS_PROT_SOCK 1024
+fi
diff -urN v2.5.34/fs/accessfs/Makefile v2.5.34-accessfs/fs/accessfs/Makefile
--- v2.5.34/fs/accessfs/Makefile	Thu Jan  1 01:00:00 1970
+++ v2.5.34-accessfs/fs/accessfs/Makefile	Tue Sep 24 14:57:10 2002
@@ -0,0 +1,10 @@
+#
+# Makefile for the linux accessfs routines.
+#
+
+obj-$(CONFIG_ACCESS_FS) += accessfs.o accessfs-lsm.o
+accessfs-objs := inode.o
+accessfs-lsm-objs := security.o capabilities.o ip.o
+export-objs := inode.o
+
+include $(TOPDIR)/Rules.make
diff -urN v2.5.34/fs/accessfs/capabilities.c v2.5.34-accessfs/fs/accessfs/capabilities.c
--- v2.5.34/fs/accessfs/capabilities.c	Thu Jan  1 01:00:00 1970
+++ v2.5.34-accessfs/fs/accessfs/capabilities.c	Tue Sep 24 15:20:53 2002
@@ -0,0 +1,73 @@
+/* Copyright (c) 2002 Olaf Dietsche
+ *
+ * Access permission filesystem for Linux.
+ *
+ * $Log$
+ */
+
+#include	<linux/accessfs_fs.h>
+#include	<linux/init.h>
+
+static struct access_attr	caps[29];
+static const char	*names[] = {
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
+int	accessfs_capable(struct task_struct *tsk, int cap)
+{
+	if (accessfs_permitted(&caps[cap], MAY_EXEC))
+		/* capability granted */
+		return 0;
+
+	/* capability denied */
+	return -EPERM;
+}
+
+void __init	init_capabilities(void)
+{
+	struct accessfs_direntry *dir = accessfs_make_dirpath("capabilities");
+	int	i;
+	for (i = 0; i < sizeof(caps) / sizeof(caps[0]); ++i) {
+		caps[i].uid = 0;
+		caps[i].gid = 0;
+		caps[i].mode = S_IXUSR;
+		accessfs_register(dir, names[i], &caps[i]);
+	}
+}
+
+void __exit	exit_capabilities(void)
+{
+	struct accessfs_direntry *dir = accessfs_make_dirpath("capabilities");
+	int	i;
+	for (i = 0; i < sizeof(names) / sizeof(names[0]); ++i) {
+		accessfs_unregister(dir, names[i]);
+	}
+}
diff -urN v2.5.34/fs/accessfs/inode.c v2.5.34-accessfs/fs/accessfs/inode.c
--- v2.5.34/fs/accessfs/inode.c	Thu Jan  1 01:00:00 1970
+++ v2.5.34-accessfs/fs/accessfs/inode.c	Tue Sep 24 14:57:10 2002
@@ -0,0 +1,390 @@
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
+typedef struct accessfs_entry	afs_entry_t;
+typedef struct accessfs_direntry	afs_dir_t;
+
+#define ACCESSFS_MAGIC	0x3c1d36e7
+
+#ifdef CONFIG_PROC_FS           
+static struct proc_dir_entry *mountdir = NULL;
+#endif  
+
+
+static struct inode_operations	accessfs_inode_operations;
+static struct file_operations	accessfs_dir_file_operations;
+static struct inode_operations	accessfs_dir_inode_operations;
+
+static int	accessfs_statfs(struct super_block *sb, struct statfs *buf)
+{
+	buf->f_type = ACCESSFS_MAGIC;
+	buf->f_bsize = PAGE_CACHE_SIZE;
+	buf->f_namelen = 255;
+	return 0;
+}
+
+static int	accessfs_readdir(struct file *filp, void *dirent, filldir_t filldir)
+{
+	int	i;
+	struct dentry	*dentry = filp->f_dentry;
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
+	default: {
+		afs_dir_t	*de = (afs_dir_t *) dentry->d_inode->u.generic_ip;
+		struct list_head	*list;
+		int	j;
+
+		list = de->children.next;
+
+		for (j = 2; j < i && list != &de->children; ++j)
+			list = list->next;
+
+		while (list != &de->children) {
+			afs_entry_t	*pe = list_entry(list, afs_entry_t, siblings);
+			if (filldir(dirent, pe->name, strlen(pe->name), filp->f_pos, pe->ino, DT_UNKNOWN) < 0)
+				break;
+
+			++filp->f_pos;
+			list = list->next;
+		}
+	}
+
+		break;
+	}
+
+	return 0;
+}
+
+static afs_entry_t	*accessfs_lookup_entry(afs_entry_t *pe, const char *name, int len)
+{
+	if (S_ISDIR(pe->attr->mode)) {
+		struct list_head	*list;
+		afs_dir_t	*dir = (afs_dir_t *) pe;
+		list_for_each(list, &dir->children) {
+			afs_entry_t	*de = list_entry(list, afs_entry_t, siblings);
+			if (strncmp(de->name, name, len) == 0 && de->name[len] == 0)
+				return de;
+		}
+	}
+
+	return NULL;
+}
+
+static struct dentry	*accessfs_lookup(struct inode *dir, struct dentry *dentry)
+{
+	struct inode	*inode = NULL;
+	afs_entry_t	*pe;
+	pe = accessfs_lookup_entry(dir->u.generic_ip, dentry->d_name.name, dentry->d_name.len);
+	if (pe)
+		inode = iget(dir->i_sb, pe->ino);
+
+	d_add(dentry, inode);
+	return NULL;
+}
+
+static afs_dir_t	accessfs_rootdir = {
+	{ "/", 
+	  LIST_HEAD_INIT(accessfs_rootdir.node.hash), 
+	  LIST_HEAD_INIT(accessfs_rootdir.node.siblings), 
+	  1, &accessfs_rootdir.attr },
+	NULL, LIST_HEAD_INIT(accessfs_rootdir.children), 
+	{ 0, 0, S_IFDIR | 0755 }
+};
+
+static void	accessfs_init_inode(struct inode *inode, afs_entry_t *pe)
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
+static struct inode	*accessfs_get_root_inode(struct super_block *sb)
+{
+	struct inode	*inode = new_inode(sb);
+	if (inode) {
+/* 		inode->i_ino = accessfs_rootdir.node.ino; */
+		accessfs_init_inode(inode, &accessfs_rootdir.node);
+		accessfs_rootdir.node.ino = inode->i_ino;
+	}
+
+	return inode;
+}
+
+static LIST_HEAD(hash);
+
+static int	accessfs_node_init(afs_dir_t *parent, afs_entry_t *de, const char *name, size_t len, struct access_attr *attr, mode_t mode)
+{
+	static unsigned long	ino = 1;
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
+static int	accessfs_mknod(afs_dir_t *dir, const char *name, struct access_attr *attr)
+{
+	afs_entry_t	*pe = kmalloc(sizeof(afs_entry_t), GFP_KERNEL);
+	if (pe == NULL)
+		return -ENOMEM;
+
+	accessfs_node_init(dir, pe, name, strlen(name), attr, S_IFREG | attr->mode);
+	return 0;
+}
+
+static afs_dir_t	*accessfs_mkdir(afs_dir_t *parent, const char *name, size_t len)
+{
+	int	error;
+	afs_dir_t	*dir = kmalloc(sizeof(afs_dir_t), GFP_KERNEL);
+	if (dir == NULL)
+		return NULL;
+
+	error = accessfs_node_init(parent, &dir->node, name, len, &dir->attr, S_IFDIR | 0755);
+	if (error) {
+		kfree(dir);
+		return NULL;
+	}
+
+	dir->parent = parent;
+	INIT_LIST_HEAD(&dir->children);
+	return dir;
+}
+
+afs_dir_t	*accessfs_make_dirpath(const char *name)
+{
+	afs_dir_t	*dir = &accessfs_rootdir;
+	const char	*slash;
+	do {
+		afs_entry_t	*de;
+		size_t	len;
+		while (*name == '/')
+			++name;
+
+		slash = strchr(name, '/');
+		len = slash ? slash - name : strlen(name);
+		de = accessfs_lookup_entry(&dir->node, name, len);
+		if (de == NULL) {
+			dir = accessfs_mkdir(dir, name, len);
+		} else if (S_ISDIR(de->attr->mode)) {
+			dir = (afs_dir_t *) de;
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
+static void	accessfs_unlink(afs_entry_t *pe)
+{
+	list_del(&pe->hash);
+	list_del(&pe->siblings);
+	kfree(pe->name);
+	kfree(pe);
+}
+
+static int	accessfs_notify_change(struct dentry *dentry, struct iattr *iattr)
+{
+	struct inode	*i = dentry->d_inode;
+	int	error = inode_setattr(i, iattr);
+	if (!error) {
+		afs_entry_t	*pe = (afs_entry_t *) i->u.generic_ip;
+		pe->attr->uid = i->i_uid;
+		pe->attr->gid = i->i_gid;
+		pe->attr->mode = i->i_mode;
+	}
+
+	return error;
+}
+
+static void	accessfs_read_inode(struct inode *inode)
+{
+	ino_t	ino = inode->i_ino;
+	struct list_head	*list;
+	list_for_each(list, &hash) {
+		afs_entry_t	*pe = list_entry(list, afs_entry_t, hash);
+		if (pe->ino == ino) {
+			accessfs_init_inode(inode, pe);
+			return;
+		}
+	}
+}
+
+static struct inode_operations	accessfs_inode_operations = {
+	.setattr =	accessfs_notify_change,
+};
+
+static struct inode_operations	accessfs_dir_inode_operations = {
+	.lookup =	accessfs_lookup,
+	.setattr =	accessfs_notify_change,
+};
+
+static struct file_operations	accessfs_dir_file_operations = {
+	.readdir =	accessfs_readdir,
+};
+
+static struct super_operations	accessfs_ops = {
+	.read_inode =	accessfs_read_inode,
+	.statfs =		accessfs_statfs,
+};
+
+static int	accessfs_fill_super(struct super_block *sb, void *data, int silent)
+{
+	struct inode	*inode;
+	struct dentry	*root;
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
+	return 0;
+}
+
+static struct super_block	*accessfs_get_sb(struct file_system_type *fs_type, int flags, char *dev_name, void *data)
+{
+	return get_sb_single(fs_type, flags, data, accessfs_fill_super);
+}
+
+int	accessfs_permitted(struct access_attr *p, int mask)
+{
+	mode_t	mode = p->mode;
+	if (current->fsuid == p->uid)
+		mode >>= 6;
+	else if (in_group_p(p->gid))
+		mode >>= 3;
+
+	return (mode & mask) == mask;
+}
+
+void	accessfs_register(afs_dir_t *dir, const char *name, struct access_attr *attr)
+{
+	if (dir) {
+		accessfs_mknod(dir, name, attr);
+	}
+}
+
+void	accessfs_unregister(afs_dir_t *dir, const char *name)
+{
+	afs_entry_t	*pe = accessfs_lookup_entry(&dir->node, name, strlen(name));
+	if (pe) {
+		accessfs_unlink(pe);
+	}
+}
+
+static struct file_system_type accessfs_fs_type = {
+	.name =		"accessfs",
+	.get_sb =	accessfs_get_sb,
+/* 	.kill_sb =	kill_litter_super, */
+	.kill_sb =	kill_anon_super,
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
+EXPORT_SYMBOL(accessfs_permitted);
+EXPORT_SYMBOL(accessfs_make_dirpath);
+EXPORT_SYMBOL(accessfs_register);
+EXPORT_SYMBOL(accessfs_unregister);
diff -urN v2.5.34/fs/accessfs/ip.c v2.5.34-accessfs/fs/accessfs/ip.c
--- v2.5.34/fs/accessfs/ip.c	Thu Jan  1 01:00:00 1970
+++ v2.5.34-accessfs/fs/accessfs/ip.c	Tue Sep 24 14:57:10 2002
@@ -0,0 +1,41 @@
+/* Copyright (c) 2002 Olaf Dietsche
+ *
+ * Access permission filesystem for Linux.
+ *
+ * $Log$
+ */
+
+#include	<linux/accessfs_fs.h>
+#include	<linux/init.h>
+
+static struct access_attr bind_to_port[CONFIG_ACCESSFS_PROT_SOCK];
+
+int	accessfs_ip_prot_sock(int port)
+{
+	return port && port < CONFIG_ACCESSFS_PROT_SOCK && !accessfs_permitted(&bind_to_port[port], MAY_EXEC);
+}
+
+void __init	init_ip(void)
+{
+	struct accessfs_direntry *dir = accessfs_make_dirpath("net/ip/bind");
+	int i;
+	for (i = 1; i < CONFIG_ACCESSFS_PROT_SOCK; ++i) {
+		char	buf[sizeof("65536")];
+		bind_to_port[i].uid = 0;
+		bind_to_port[i].gid = 0;
+		bind_to_port[i].mode = i < PROT_SOCK ? S_IXUSR : S_IXUGO;
+		sprintf(buf, "%d", i);
+		accessfs_register(dir, buf, &bind_to_port[i]);
+	}
+}
+
+void __exit	exit_ip(void)
+{
+	struct accessfs_direntry *dir = accessfs_make_dirpath("net/ip/bind");
+	int i;
+	for (i = 1; i < CONFIG_ACCESSFS_PROT_SOCK; ++i) {
+		char	buf[sizeof("65536")];
+		sprintf(buf, "%d", i);
+		accessfs_unregister(dir, buf);
+	}
+}
diff -urN v2.5.34/fs/accessfs/security.c v2.5.34-accessfs/fs/accessfs/security.c
--- v2.5.34/fs/accessfs/security.c	Thu Jan  1 01:00:00 1970
+++ v2.5.34-accessfs/fs/accessfs/security.c	Tue Sep 24 14:57:10 2002
@@ -0,0 +1,47 @@
+/* Copyright (c) 2002 Olaf Dietsche
+ *
+ * Access permission filesystem for Linux.
+ *
+ * $Log$
+ */
+
+#include	<linux/accessfs_fs.h>
+#include	<linux/init.h>
+#include	<linux/security.h>
+
+static struct security_operations accessfs_security_ops = {
+	.capable =	accessfs_capable,
+	.ip_prot_sock =	accessfs_ip_prot_sock,
+};
+
+static void __init	fill_empty_from(struct security_operations *to, const struct security_operations *from)
+{
+	unsigned long	*__from = (unsigned long *) from;
+	unsigned long	*__to = (unsigned long *) to;
+	unsigned long	*__end = __to + sizeof(*to) / sizeof(unsigned long *);
+	while (__to != __end) {
+		if (*__to == 0)
+			*__to = *__from;
+
+		++__to;
+		++__from;
+	}
+}
+
+static int __init	init_security(void)
+{
+	fill_empty_from(&accessfs_security_ops, security_ops);
+	init_capabilities();
+	init_ip();
+	return register_security(&accessfs_security_ops);
+}
+
+static void __exit	exit_security(void)
+{
+	exit_capabilities();
+	exit_ip();
+	unregister_security(&accessfs_security_ops);
+}
+
+module_init(init_security)
+module_exit(exit_security)
diff -urN v2.5.34/include/linux/accessfs_fs.h v2.5.34-accessfs/include/linux/accessfs_fs.h
--- v2.5.34/include/linux/accessfs_fs.h	Thu Jan  1 01:00:00 1970
+++ v2.5.34-accessfs/include/linux/accessfs_fs.h	Tue Sep 24 15:21:55 2002
@@ -0,0 +1,55 @@
+/* -*- mode: c -*- */
+#ifndef	__accessfs_fs_h_included__
+#define	__accessfs_fs_h_included__	1
+
+/* Copyright (c) 2001 Olaf Dietsche
+ *
+ * $Log$
+ */
+
+#include	<linux/config.h>
+#include	<linux/fs.h>
+#include	<linux/init.h>
+#include	<net/sock.h>
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
+extern int	accessfs_capable(struct task_struct *tsk, int cap);
+extern int	accessfs_ip_prot_sock(int port);
+
+extern void	init_capabilities(void) __init;
+extern void	exit_capabilities(void) __exit;
+extern void	init_ip(void) __init;
+extern void	exit_ip(void) __exit;
+
+extern int	accessfs_permitted(struct access_attr *p, int mask);
+extern struct accessfs_direntry	*accessfs_make_dirpath(const char *name);
+extern void	accessfs_register(struct accessfs_direntry *dir, const char *name, struct access_attr *attr);
+extern void	accessfs_unregister(struct accessfs_direntry *dir, const char *name);
+
+#if 	CONFIG_ACCESSFS_PROT_SOCK < PROT_SOCK
+#define	CONFIG_ACCESSFS_PROT_SOCK	PROT_SOCK
+#elseif	CONFIG_ACCESSFS_PROT_SOCK > 65536
+#define	CONFIG_ACCESSFS_PROT_SOCK	65536
+#endif
+
+#endif
