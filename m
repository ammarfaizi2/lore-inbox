Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289990AbSAOQCC>; Tue, 15 Jan 2002 11:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289997AbSAOQBq>; Tue, 15 Jan 2002 11:01:46 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:49113 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S289990AbSAOQB3>; Tue, 15 Jan 2002 11:01:29 -0500
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE][PATCH] New fs to control access to system resources
From: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Date: 15 Jan 2002 17:01:11 +0100
Message-ID: <87k7uj61tk.fsf@tigram.bogus.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

this is a new file system to control access to system resources.
Currently it controls access to inet_bind() with ports < 1024 only.

With this patch, there's no need anymore to run internet daemons as
root. You can individually configure which user/program can bind to
ports below 1024.

For example, you can say, user www is allowed to bind to port 80 or
user mail is allowed to bind to port 25. Then, you can run apache as
user www and sendmail as user mail. Now, you don't have to rely on
apache or sendmail giving up superuser rights to enhance security.

To use this, you need to mount the file system and do a chown on the
appropriate ports:

# mount -t accessfs none /mnt
# chown www /mnt/net/ipv4/bind/80
# chown mail /mnt/net/ipv4/bind/25
...

You can grant access to a group for individual ports as well. Just say:

# chgrp lp /mnt/net/ipv4/bind/515
# chown g+x /mnt/net/ipv4/bind/515

... and you're done.

This patch is against 2.4.14, but it applies with offsets to 2.4.17
and 2.5.2 as well. However, I have built and tested 2.4.14 only.

Now, I would like to here from you, whether you find this useful or
not, have any suggestions, objections ... please tell me.
Of course, comments on the code are welcome too :-).

Thanks for your time.

Regards, Olaf.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=accessfs.patch
Content-Description: New linux accessfs

diff -X dontdiff -urN v2.4.14/Documentation/Configure.help linux/Documentation/Configure.help
--- v2.4.14/Documentation/Configure.help	Mon Nov  5 22:40:59 2001
+++ linux/Documentation/Configure.help	Fri Jan 11 21:45:16 2002
@@ -19179,6 +19179,34 @@
   To use this option, you have to check that the "/proc file system
   support" (CONFIG_PROC_FS) is enabled, too.
 
+Accessfs support (EXPERIMENTAL)
+CONFIG_ACCESS_FS
+  This is a new file system to control access to system resources.
+  Currently it controls access to bind() with ports < 1024 only.
+
+  With this file system, there's no need anymore to run internet daemons
+  as root. You can individually configure which user/program can bind to
+  ports below 1024.
+
+  For example, you can say, user www is allowed to bind to port 80 or
+  user mail is allowed to bind to port 25. Then, you can run apache as
+  user www and sendmail as user mail. Now, you don't have to rely on
+  apache or sendmail giving up superuser rights to enhance security.
+
+  To use this file system, you need to mount the file system somewhere
+  and do a chown on the appropriate ports:
+
+  # mount -t accessfs none /mnt
+  # chown www /mnt/net/ipv4/bind/80
+  # chown mail /mnt/net/ipv4/bind/25
+
+  You can grant access to a group for individual ports as well. Just say:
+
+  # chgrp lp /mnt/net/ipv4/bind/515
+  # chown g+x /mnt/net/ipv4/bind/515
+
+  If you're unsure, say N.
+
 #
 # A couple of things I keep forgetting:
 #   capitalize: AppleTalk, Ethernet, DOS, DMA, FAT, FTP, Internet, 
diff -X dontdiff -urN v2.4.14/fs/Config.in linux/fs/Config.in
--- v2.4.14/fs/Config.in	Mon Nov  5 22:40:59 2001
+++ linux/fs/Config.in	Thu Jan 10 19:49:32 2002
@@ -78,6 +78,8 @@
 tristate 'UFS file system support (read only)' CONFIG_UFS_FS
 dep_mbool '  UFS file system write support (DANGEROUS)' CONFIG_UFS_FS_WRITE $CONFIG_UFS_FS $CONFIG_EXPERIMENTAL
 
+dep_bool 'Accessfs support (EXPERIMENTAL)' CONFIG_ACCESS_FS $CONFIG_EXPERIMENTAL
+
 if [ "$CONFIG_NET" = "y" ]; then
 
    mainmenu_option next_comment
diff -X dontdiff -urN v2.4.14/fs/Makefile linux/fs/Makefile
--- v2.4.14/fs/Makefile	Mon Nov  5 22:40:59 2001
+++ linux/fs/Makefile	Thu Jan 10 19:39:46 2002
@@ -64,6 +64,7 @@
 subdir-$(CONFIG_REISERFS_FS)	+= reiserfs
 subdir-$(CONFIG_DEVPTS_FS)	+= devpts
 subdir-$(CONFIG_SUN_OPENPROMFS)	+= openpromfs
+subdir-$(CONFIG_ACCESS_FS)	+= accessfs
 
 
 obj-$(CONFIG_BINFMT_AOUT)	+= binfmt_aout.o
diff -X dontdiff -urN v2.4.14/fs/accessfs/Makefile linux/fs/accessfs/Makefile
--- v2.4.14/fs/accessfs/Makefile	Thu Jan  1 01:00:00 1970
+++ linux/fs/accessfs/Makefile	Thu Jan 10 19:42:52 2002
@@ -0,0 +1,9 @@
+#
+# Makefile for the linux accessfs routines.
+#
+
+O_TARGET := accessfs.o
+obj-y := inode.o
+export-objs := inode.o
+
+include $(TOPDIR)/Rules.make
diff -X dontdiff -urN v2.4.14/fs/accessfs/inode.c linux/fs/accessfs/inode.c
--- v2.4.14/fs/accessfs/inode.c	Thu Jan  1 01:00:00 1970
+++ linux/fs/accessfs/inode.c	Fri Jan 11 22:08:26 2002
@@ -0,0 +1,355 @@
+/* Copyright (c) 2001 Olaf Dietsche
+ *
+ * Access permission filesystem for Linux.
+ */
+
+#include <linux/accessfs_fs.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/pagemap.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/locks.h>
+
+#include <asm/uaccess.h>
+
+typedef struct accessfs_entry	afs_entry_t;
+typedef struct accessfs_direntry	afs_dir_t;
+
+#define ACCESSFS_MAGIC	0x3c1d36e7
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
+static struct super_block	*accessfs_read_super(struct super_block *sb, void *data, int silent)
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
+		return NULL;
+
+	root = d_alloc_root(inode);
+	if (!root) {
+		iput(inode);
+		return NULL;
+	}
+
+	sb->s_root = root;
+	return sb;
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
+static DECLARE_FSTYPE(accessfs_fs_type, "accessfs", accessfs_read_super, FS_SINGLE);
+
+static int __init init_accessfs_fs(void)
+{
+	return register_filesystem(&accessfs_fs_type);
+}
+
+static void __exit exit_accessfs_fs(void)
+{
+	unregister_filesystem(&accessfs_fs_type);
+}
+
+module_init(init_accessfs_fs)
+module_exit(exit_accessfs_fs)
+
+EXPORT_SYMBOL(accessfs_permitted);
+EXPORT_SYMBOL(accessfs_make_dirpath);
+EXPORT_SYMBOL(accessfs_register);
+EXPORT_SYMBOL(accessfs_unregister);
diff -X dontdiff -urN v2.4.14/include/linux/accessfs_fs.h linux/include/linux/accessfs_fs.h
--- v2.4.14/include/linux/accessfs_fs.h	Thu Jan  1 01:00:00 1970
+++ linux/include/linux/accessfs_fs.h	Fri Jan 11 22:10:18 2002
@@ -0,0 +1,38 @@
+/* -*- mode: c -*- */
+#ifndef	__accessfs_fs_h_included__
+#define	__accessfs_fs_h_included__	1
+
+/* Copyright (c) 2001 Olaf Dietsche
+ *
+ * $Log$
+ */
+
+#include	<linux/fs.h>
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
+#endif
diff -X dontdiff -urN v2.4.14/net/ipv4/af_inet.c linux/net/ipv4/af_inet.c
--- v2.4.14/net/ipv4/af_inet.c	Mon Nov  5 18:46:12 2001
+++ linux/net/ipv4/af_inet.c	Thu Jan 10 20:14:29 2002
@@ -116,6 +116,9 @@
 #if defined(CONFIG_NET_RADIO) || defined(CONFIG_NET_PCMCIA_RADIO)
 #include <linux/wireless.h>		/* Note : will define WIRELESS_EXT */
 #endif	/* CONFIG_NET_RADIO || CONFIG_NET_PCMCIA_RADIO */
+#ifdef CONFIG_ACCESS_FS
+#include <linux/accessfs_fs.h>
+#endif
 
 struct linux_mib net_statistics[NR_CPUS*2];
 
@@ -467,6 +470,10 @@
 	return(0);
 }
 
+#ifdef CONFIG_ACCESS_FS
+static struct access_attr bind_to_port[PROT_SOCK];
+#endif
+
 /* It is off by default, see below. */
 int sysctl_ip_nonlocal_bind;
 
@@ -503,7 +510,11 @@
 		return -EADDRNOTAVAIL;
 
 	snum = ntohs(addr->sin_port);
+#ifdef CONFIG_ACCESS_FS
+	if (snum && snum < PROT_SOCK && !accessfs_permitted(&bind_to_port[snum], MAY_EXEC))
+#else
 	if (snum && snum < PROT_SOCK && !capable(CAP_NET_BIND_SERVICE))
+#endif
 		return -EACCES;
 
 	/*      We keep a pair of addresses. rcv_saddr is the one
@@ -1101,6 +1112,21 @@
 	}
 }
 
+#ifdef CONFIG_ACCESS_FS
+static void	accessfs_init(void)
+{
+	struct accessfs_direntry *dir = accessfs_make_dirpath("net/ipv4/bind");
+	int i;
+	for (i = 1; i < PROT_SOCK; ++i) {
+		char	buf[sizeof("1023")];
+		bind_to_port[i].uid = 0;
+		bind_to_port[i].gid = 0;
+		bind_to_port[i].mode = S_IXUSR;
+		sprintf(buf, "%d", i);
+		accessfs_register(dir, buf, &bind_to_port[i]);
+	}
+}
+#endif
 
 /*
  *	Called by socket.c on kernel startup.  
@@ -1197,6 +1223,11 @@
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

--=-=-=--
