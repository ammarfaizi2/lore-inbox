Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262246AbSITL3B>; Fri, 20 Sep 2002 07:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbSITL3B>; Fri, 20 Sep 2002 07:29:01 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:3262 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262246AbSITL2x>; Fri, 20 Sep 2002 07:28:53 -0400
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE][PATCH] accessfs v0.4 - 2.5.34
From: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Date: Fri, 20 Sep 2002 13:33:39 +0200
Message-ID: <87y99w99po.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Accessfs is a new file system to control access to system resources.
Currently it controls access to inet_bind() with ports < 1024 only.

With this patch, there's no need anymore to run internet daemons as
root. You can individually configure which user/program can bind to
ports below 1024.

For further information see the help text.

I adapted accessfs to linux 2.5.34.

The patch is attached below. It is also available at:
<http://home.t-online.de/home/olaf.dietsche/linux/accessfs-2.5.34-0.4.patch.gz>

I did minimal testing using uml 0.58-2.5.34.

Regards, Olaf.

diff -urN v2.5.34/fs/Config.in v2.5.34-accessfs/fs/Config.in
--- v2.5.34/fs/Config.in	Sun Sep  1 00:05:30 2002
+++ v2.5.34-accessfs/fs/Config.in	Thu Sep 19 21:45:49 2002
@@ -101,6 +101,9 @@
 tristate 'UFS file system support (read only)' CONFIG_UFS_FS
 dep_mbool '  UFS file system write support (DANGEROUS)' CONFIG_UFS_FS_WRITE $CONFIG_UFS_FS $CONFIG_EXPERIMENTAL
 
+dep_bool 'Accessfs support (EXPERIMENTAL)' CONFIG_ACCESS_FS $CONFIG_EXPERIMENTAL
+source fs/accessfs/Config.in
+
 if [ "$CONFIG_NET" = "y" ]; then
 
    mainmenu_option next_comment
diff -urN v2.5.34/fs/Makefile v2.5.34-accessfs/fs/Makefile
--- v2.5.34/fs/Makefile	Sun Sep  1 00:05:27 2002
+++ v2.5.34-accessfs/fs/Makefile	Thu Sep 19 21:45:49 2002
@@ -83,5 +83,6 @@
 obj-$(CONFIG_REISERFS_FS)	+= reiserfs/
 obj-$(CONFIG_SUN_OPENPROMFS)	+= openpromfs/
 obj-$(CONFIG_JFS_FS)		+= jfs/
+obj-$(CONFIG_ACCESS_FS)		+= accessfs/
 
 include $(TOPDIR)/Rules.make
diff -urN v2.5.34/fs/accessfs/Config.help v2.5.34-accessfs/fs/accessfs/Config.help
--- v2.5.34/fs/accessfs/Config.help	Thu Jan  1 01:00:00 1970
+++ v2.5.34-accessfs/fs/accessfs/Config.help	Thu Sep 19 21:45:49 2002
@@ -0,0 +1,53 @@
+Accessfs support (EXPERIMENTAL)
+CONFIG_ACCESS_FS
+  This is a new file system to control access to system resources.
+  Currently it controls access to bind() for IPv4 and IPv6.
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
+  # chown www /proc/access/net/ipv4/bind/80
+  # chown www /proc/access/net/ipv6/bind/80
+  # chown mail /proc/access/net/ipv4/bind/25
+  # chown mail /proc/access/net/ipv6/bind/25
+
+  You can grant access to a group for individual ports as well. Just say:
+
+  # chgrp lp /proc/access/net/ipv4/bind/515
+  # chown g+x /proc/access/net/ipv4/bind/515
+
+  The recommended mount point for this file-system is /proc/access,
+  which will appear automatically in the /proc filesystem.
+
+  If you're unsure, say N.
+
+Keep capabilities
+CONFIG_ACCESSFS_KEEP_CAPABILITIES
+  This option lets you choose, wether you want accessfs alone (N)
+  or in addition to capabilities (Y).
+  If you say N to this option, you may break applications and
+  configurations, which use capabilities already (e.g. BIND v9).
+
+  If you're unsure, say Y.
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
+++ v2.5.34-accessfs/fs/accessfs/Config.in	Thu Sep 19 21:45:49 2002
@@ -0,0 +1,8 @@
+#
+# Accessfs configuration
+#
+dep_bool '  Keep capabilities' CONFIG_ACCESSFS_KEEP_CAPABILITIES $CONFIG_ACCESS_FS
+
+if [ "$CONFIG_ACCESS_FS" != "n" ]; then
+	int '  Range of protected ports (1024-65536)' CONFIG_ACCESSFS_PROT_SOCK 1024
+fi
diff -urN v2.5.34/fs/accessfs/Makefile v2.5.34-accessfs/fs/accessfs/Makefile
--- v2.5.34/fs/accessfs/Makefile	Thu Jan  1 01:00:00 1970
+++ v2.5.34-accessfs/fs/accessfs/Makefile	Thu Sep 19 21:57:58 2002
@@ -0,0 +1,9 @@
+#
+# Makefile for the linux accessfs routines.
+#
+
+obj-$(CONFIG_ACCESS_FS) += accessfs.o
+accessfs-objs := inode.o
+export-objs := inode.o
+
+include $(TOPDIR)/Rules.make
diff -urN v2.5.34/fs/accessfs/inode.c v2.5.34-accessfs/fs/accessfs/inode.c
--- v2.5.34/fs/accessfs/inode.c	Thu Jan  1 01:00:00 1970
+++ v2.5.34-accessfs/fs/accessfs/inode.c	Fri Sep 20 12:18:53 2002
@@ -0,0 +1,391 @@
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
+	setattr:	accessfs_notify_change,
+};
+
+static struct inode_operations	accessfs_dir_inode_operations = {
+	lookup:	accessfs_lookup,
+	setattr:	accessfs_notify_change,
+};
+
+static struct file_operations	accessfs_dir_file_operations = {
+	readdir:	accessfs_readdir,
+};
+
+static struct super_operations	accessfs_ops = {
+	read_inode:	accessfs_read_inode,
+	statfs:		accessfs_statfs,
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
+	name:		"accessfs",
+	get_sb:	accessfs_get_sb,
+/* 	kill_sb:	kill_litter_super, */
+	kill_sb:	kill_anon_super,
+};
+
+static int __init init_accessfs_fs(void)
+{
+
+#ifdef CONFIG_PROC_FS
+	/* create mount point for accessfs */
+	mountdir = proc_mkdir("access",&proc_root);
+#endif
+	
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
diff -urN v2.5.34/include/linux/accessfs_fs.h v2.5.34-accessfs/include/linux/accessfs_fs.h
--- v2.5.34/include/linux/accessfs_fs.h	Thu Jan  1 01:00:00 1970
+++ v2.5.34-accessfs/include/linux/accessfs_fs.h	Thu Sep 19 21:45:49 2002
@@ -0,0 +1,52 @@
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
+extern int	accessfs_permitted(struct access_attr *p, int mask);
+extern struct accessfs_direntry	*accessfs_make_dirpath(const char *name);
+extern void	accessfs_register(struct accessfs_direntry *dir, const char *name, struct access_attr *attr);
+extern void	accessfs_unregister(struct accessfs_direntry *dir, const char *name);
+
+#ifdef 	CONFIG_ACCESSFS_KEEP_CAPABILITIES
+#define	accessfs_capable(x)	capable(x)
+#else
+#define	accessfs_capable(x)	0
+#endif
+
+#if 	CONFIG_ACCESSFS_PROT_SOCK < PROT_SOCK
+#define	CONFIG_ACCESSFS_PROT_SOCK	PROT_SOCK
+#elseif	CONFIG_ACCESSFS_PROT_SOCK > 65536
+#define	CONFIG_ACCESSFS_PROT_SOCK	65536
+#endif
+
+#endif
diff -urN v2.5.34/net/ipv4/af_inet.c v2.5.34-accessfs/net/ipv4/af_inet.c
--- v2.5.34/net/ipv4/af_inet.c	Sun Sep  1 00:04:50 2002
+++ v2.5.34-accessfs/net/ipv4/af_inet.c	Thu Sep 19 21:45:49 2002
@@ -120,6 +120,9 @@
 #if defined(CONFIG_NET_RADIO) || defined(CONFIG_NET_PCMCIA_RADIO)
 #include <linux/wireless.h>		/* Note : will define WIRELESS_EXT */
 #endif	/* CONFIG_NET_RADIO || CONFIG_NET_PCMCIA_RADIO */
+#ifdef CONFIG_ACCESS_FS
+#include <linux/accessfs_fs.h>
+#endif
 
 struct linux_mib net_statistics[NR_CPUS * 2];
 
@@ -349,6 +352,14 @@
  *	Create an inet socket.
  */
 
+#ifdef CONFIG_ACCESS_FS
+static struct access_attr	raw_socket = {
+	uid:	0,
+	gid:	0,
+	mode:	S_IXUSR,
+};
+#endif
+
 static int inet_create(struct socket *sock, int protocol)
 {
 	struct sock *sk;
@@ -390,7 +401,11 @@
 	if (!answer)
 		goto out_sk_free;
 	err = -EPERM;
+#ifdef CONFIG_ACCESS_FS
+	if (answer->capability > 0 && !(answer->capability == CAP_NET_RAW && accessfs_permitted(&raw_socket, MAY_EXEC)) && !accessfs_capable(answer->capability))
+#else
 	if (answer->capability > 0 && !capable(answer->capability))
+#endif
 		goto out_sk_free;
 	err = -EPROTONOSUPPORT;
 	if (!protocol)
@@ -490,6 +505,10 @@
 	return 0;
 }
 
+#ifdef CONFIG_ACCESS_FS
+static struct access_attr bind_to_port[CONFIG_ACCESSFS_PROT_SOCK];
+#endif
+
 /* It is off by default, see below. */
 int sysctl_ip_nonlocal_bind;
 
@@ -531,7 +550,11 @@
 
 	snum = ntohs(addr->sin_port);
 	err = -EACCES;
+#ifdef CONFIG_ACCESS_FS
+	if (snum && snum < CONFIG_ACCESSFS_PROT_SOCK && !accessfs_permitted(&bind_to_port[snum], MAY_EXEC) && !accessfs_capable(CAP_NET_BIND_SERVICE))
+#else
 	if (snum && snum < PROT_SOCK && !capable(CAP_NET_BIND_SERVICE))
+#endif
 		goto out;
 
 	/*      We keep a pair of addresses. rcv_saddr is the one
@@ -1121,6 +1144,29 @@
 	}
 }
 
+#ifdef CONFIG_ACCESS_FS
+static void	accessfs_init(void)
+{
+	struct accessfs_direntry *dir = accessfs_make_dirpath("net/ipv4/bind");
+	int i;
+	for (i = 1; i < CONFIG_ACCESSFS_PROT_SOCK; ++i) {
+		char	buf[sizeof("65536")];
+		bind_to_port[i].uid = 0;
+		bind_to_port[i].gid = 0;
+		bind_to_port[i].mode = i < PROT_SOCK ? S_IXUSR : S_IXUGO;
+		sprintf(buf, "%d", i);
+		accessfs_register(dir, buf, &bind_to_port[i]);
+	}
+
+	dir = accessfs_make_dirpath("net/ipv4");
+#if	0
+	raw_socket.uid = 0;
+	raw_socket.gid = 0;
+	raw_socket.mode = S_IXUSR;
+#endif
+	accessfs_register(dir, "raw", &raw_socket);
+}
+#endif
 
 /*
  *	Called by socket.c on kernel startup.  
@@ -1229,6 +1275,11 @@
 	proc_net_create ("tcp", 0, tcp_get_info);
 	proc_net_create ("udp", 0, udp_get_info);
 #endif		/* CONFIG_PROC_FS */
+
+#ifdef CONFIG_ACCESS_FS
+	accessfs_init();
+#endif
+
 	return 0;
 }
 module_init(inet_init);
diff -urN v2.5.34/net/ipv6/af_inet6.c v2.5.34-accessfs/net/ipv6/af_inet6.c
--- v2.5.34/net/ipv6/af_inet6.c	Sun Sep  1 00:05:27 2002
+++ v2.5.34-accessfs/net/ipv6/af_inet6.c	Thu Sep 19 21:45:49 2002
@@ -47,6 +47,9 @@
 #include <linux/icmpv6.h>
 #include <linux/brlock.h>
 #include <linux/smp_lock.h>
+#ifdef CONFIG_ACCESS_FS
+#include <linux/accessfs_fs.h>
+#endif
 
 #include <net/ip.h>
 #include <net/ipv6.h>
@@ -272,6 +275,9 @@
 	return -ENOBUFS;
 }
 
+#ifdef CONFIG_ACCESS_FS
+static struct access_attr bind_to_port[CONFIG_ACCESSFS_PROT_SOCK];
+#endif
 
 /* bind for INET6 API */
 int inet6_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
@@ -313,7 +319,11 @@
 	}
 
 	snum = ntohs(addr->sin6_port);
+#ifdef CONFIG_ACCESS_FS
+	if (snum && snum < CONFIG_ACCESSFS_PROT_SOCK && !accessfs_permitted(&bind_to_port[snum], MAY_EXEC) && !accessfs_capable(CAP_NET_BIND_SERVICE))
+#else
 	if (snum && snum < PROT_SOCK && !capable(CAP_NET_BIND_SERVICE))
+#endif
 		return -EACCES;
 
 	lock_sock(sk);
@@ -632,6 +642,35 @@
 	inet_unregister_protosw(p);
 }
 
+#ifdef CONFIG_ACCESS_FS
+static void	accessfs_init(void)
+{
+	struct accessfs_direntry *dir = accessfs_make_dirpath("net/ipv6/bind");
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
+#ifdef MODULE
+static void	accessfs_exit(void)
+{
+	struct accessfs_direntry *dir = accessfs_make_dirpath("net/ipv6/bind");
+	int i;
+	for (i = 1; i < CONFIG_ACCESSFS_PROT_SOCK; ++i) {
+		char	buf[sizeof("65536")];
+		sprintf(buf, "%d", i);
+		accessfs_unregister(dir, buf);
+	}
+}
+#endif
+#endif
+
 static int __init inet6_init(void)
 {
 	struct sk_buff *dummy_skb;
@@ -679,6 +718,10 @@
 	 * be able to create sockets. (?? is this dangerous ??)
 	 */
 	(void) sock_register(&inet6_family_ops);
+
+#ifdef CONFIG_ACCESS_FS
+	accessfs_init();
+#endif
 	
 	/*
 	 *	ipngwg API draft makes clear that the correct semantics
@@ -775,6 +818,9 @@
 	icmpv6_cleanup();
 #ifdef CONFIG_SYSCTL
 	ipv6_sysctl_unregister();	
+#endif
+#ifdef CONFIG_ACCESS_FS
+	accessfs_exit();
 #endif
 }
 module_exit(inet6_exit);
