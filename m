Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268391AbTGOPGH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 11:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268449AbTGOPGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 11:06:07 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:7582 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268391AbTGOPDZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 11:03:25 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16148.6900.468379.558953@gargle.gargle.HOWL>
Date: Tue, 15 Jul 2003 10:17:08 -0500
To: linux-kernel@vger.kernel.org
Cc: karim@opersys.com, bob@watson.ibm.com
Subject: [RFC][PATCH 3/5] relayfs VFS-related files
X-Mailer: VM(ViewMail) 7.01 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN -X dontdiff linux-2.6.0-test1/fs/Kconfig linux-2.6.0-test1-relayfs-printk/fs/Kconfig
--- linux-2.6.0-test1/fs/Kconfig	Sun Jul 13 22:34:42 2003
+++ linux-2.6.0-test1-relayfs-printk/fs/Kconfig	Sun Jul 13 22:32:38 2003
@@ -1221,7 +1221,25 @@ config SYSV_FS
 
 	  If you haven't heard about all of this before, it's safe to say N.
 
+config RELAYFS_FS
+	tristate "Relayfs file system support"
+	---help---
+	  Relayfs is a high-speed data relay filesystem designed to provide
+	  an efficient mechanism for tools and facilities to relay large
+	  amounts of data from kernel space to user space.  It's not useful
+	  on its own, and should only be enabled if other facilities that
+	  need it are enabled, such as for example dynamic printk or the
+	  Linux Trace Toolkit.
 
+	  See <file:Documentation/filesystems/relayfs.txt> for further
+	  information.
+
+	  This file system is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module is called relayfs.ko.  If you want to compile it as a
+	  module, say M here and read <file:Documentation/modules.txt>.
+
+	  If unsure, say N.
 
 config UFS_FS
 	tristate "UFS file system support (read only)"
diff -urpN -X dontdiff linux-2.6.0-test1/fs/Makefile linux-2.6.0-test1-relayfs-printk/fs/Makefile
--- linux-2.6.0-test1/fs/Makefile	Sun Jul 13 22:34:42 2003
+++ linux-2.6.0-test1-relayfs-printk/fs/Makefile	Sun Jul 13 22:32:38 2003
@@ -67,6 +67,7 @@ obj-$(CONFIG_ISO9660_FS)	+= isofs/
 obj-$(CONFIG_DEVFS_FS)		+= devfs/
 obj-$(CONFIG_HFS_FS)		+= hfs/
 obj-$(CONFIG_VXFS_FS)		+= freevxfs/
+obj-$(CONFIG_RELAYFS_FS)	+= relayfs/
 obj-$(CONFIG_NFS_FS)		+= nfs/
 obj-$(CONFIG_EXPORTFS)		+= exportfs/
 obj-$(CONFIG_NFSD)		+= nfsd/
diff -urpN -X dontdiff linux-2.6.0-test1/fs/relayfs/Makefile linux-2.6.0-test1-relayfs-printk/fs/relayfs/Makefile
--- linux-2.6.0-test1/fs/relayfs/Makefile	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/fs/relayfs/Makefile	Sun Jul 13 22:32:38 2003
@@ -0,0 +1,7 @@
+#
+# relayfs Makefile
+#
+
+obj-$(CONFIG_RELAYFS_FS) += relayfs.o
+
+relayfs-objs := relay.o relay_lockless.o relay_locking.o inode.o
diff -urpN -X dontdiff linux-2.6.0-test1/fs/relayfs/inode.c linux-2.6.0-test1-relayfs-printk/fs/relayfs/inode.c
--- linux-2.6.0-test1/fs/relayfs/inode.c	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/fs/relayfs/inode.c	Sun Jul 13 22:32:38 2003
@@ -0,0 +1,487 @@
+/*
+ * VFS-related code for RelayFS, a high-speed data relay filesystem.
+ *
+ * Copyright (C) 2003 - Tom Zanussi <zanussi@us.ibm.com>, IBM Corp
+ * Copyright (C) 2003 - Karim Yaghmour <karim@opersys.com>
+ *
+ * Based on ramfs, Copyright (C) 2002 - Linus Torvalds
+ *
+ * This file is released under the GPL.
+ */
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/pagemap.h>
+#include <linux/highmem.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/smp_lock.h>
+#include <linux/backing-dev.h>
+#include <linux/namei.h>
+#include <asm/uaccess.h>
+#include <asm/relay.h>
+
+#define RELAYFS_MAGIC			0x26F82121
+
+static struct super_operations		relayfs_ops;
+static struct address_space_operations	relayfs_aops;
+static struct inode_operations		relayfs_file_inode_operations;
+static struct file_operations		relayfs_file_operations;
+static struct inode_operations		relayfs_dir_inode_operations;
+
+static struct vfsmount *		relayfs_mount;
+
+static struct backing_dev_info		relayfs_backing_dev_info = {
+	.ra_pages	= 0,	/* No readahead */
+	.memory_backed	= 1,	/* Does not contribute to dirty memory */
+};
+
+static struct inode *
+relayfs_get_inode(struct super_block *sb, int mode, dev_t dev)
+{
+	struct inode * inode = new_inode(sb);
+
+	if (inode) {
+		inode->i_mode = mode;
+		inode->i_uid = current->fsuid;
+		inode->i_gid = current->fsgid;
+		inode->i_blksize = PAGE_CACHE_SIZE;
+		inode->i_blocks = 0;
+		inode->i_rdev = NODEV;
+		inode->i_mapping->a_ops = &relayfs_aops;
+		inode->i_mapping->backing_dev_info = &relayfs_backing_dev_info;
+		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+		switch (mode & S_IFMT) {
+		default:
+			init_special_inode(inode, mode, dev);
+			break;
+		case S_IFREG:
+			inode->i_op = &relayfs_file_inode_operations;
+			inode->i_fop = &relayfs_file_operations;
+			break;
+		case S_IFDIR:
+			inode->i_op = &relayfs_dir_inode_operations;
+			inode->i_fop = &simple_dir_operations;
+
+			/* directory inodes start off with i_nlink == 2 (for "." entry) */
+			inode->i_nlink++;
+			break;
+		case S_IFLNK:
+			inode->i_op = &page_symlink_inode_operations;
+			break;
+		}
+	}
+	return inode;
+}
+
+/*
+ * File creation. Allocate an inode, and we're done..
+ */
+/* SMP-safe */
+static int 
+relayfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
+{
+	struct inode * inode = relayfs_get_inode(dir->i_sb, mode, dev);
+	int error = -ENOSPC;
+
+	if (inode) {
+		d_instantiate(dentry, inode);
+		dget(dentry);	/* Extra count - pin the dentry in core */
+		error = 0;
+	}
+	return error;
+}
+
+static int 
+relayfs_mkdir(struct inode * dir, struct dentry * dentry, int mode)
+{
+	int retval = relayfs_mknod(dir, dentry, mode | S_IFDIR, 0);
+
+	if (!retval)
+		dir->i_nlink++;
+	return retval;
+}
+
+static int 
+relayfs_create(struct inode *dir, struct dentry *dentry, int mode, struct nameidata *nd)
+{
+
+	return relayfs_mknod(dir, dentry, mode | S_IFREG, 0);
+}
+
+static int 
+relayfs_symlink(struct inode * dir, struct dentry *dentry, const char * symname)
+{
+	struct inode *inode;
+	int error = -ENOSPC;
+
+	inode = relayfs_get_inode(dir->i_sb, S_IFLNK|S_IRWXUGO, 0);
+
+	if (inode) {
+		int l = strlen(symname)+1;
+		error = page_symlink(inode, symname, l);
+		if (!error) {
+			d_instantiate(dentry, inode);
+			dget(dentry);
+		} else
+			iput(inode);
+	}
+	return error;
+}
+
+/**
+ *	relayfs_create_entry - create a relayfs directory or file
+ *	@name: the name of the file to create
+ *	@parent: parent directory
+ *	@dentry: result dentry
+ *	@entry_type: type of file to create (S_IFREG, S_IFDIR)
+ *	@mode: mode
+ *	@data: data to associate with the file
+ *
+ *	Creates a file or directory with the specifed permissions.
+ */
+static int 
+relayfs_create_entry(const char * name, struct dentry * parent, struct dentry **dentry, int entry_type, int mode, void * data)
+{
+	struct qstr qname;
+	struct dentry * d;
+	
+	int error = 0;
+
+	qname.name = name;
+	qname.len = strlen(name);
+	qname.hash = full_name_hash(name, qname.len);
+
+	if (parent == NULL)
+		if (relayfs_mount && relayfs_mount->mnt_sb)
+			parent = relayfs_mount->mnt_sb->s_root;
+
+	if (parent == NULL)
+		return -EINVAL;
+
+	parent = dget(parent);
+	down(&parent->d_inode->i_sem);
+	d = lookup_hash(&qname, parent);
+	if (IS_ERR(d)) {
+		error = PTR_ERR(d);
+		goto exit;
+	}
+	
+	if (d->d_inode) {
+		error = -EEXIST;
+		goto exit;
+	}
+
+	if (entry_type == S_IFREG)
+		error = relayfs_create(parent->d_inode, d, entry_type | mode, NULL);
+	else
+		error = relayfs_mkdir(parent->d_inode, d, entry_type | mode);
+
+	if ((entry_type == S_IFREG) && data && !error)
+		d->d_inode->u.generic_ip = data;
+exit:	
+	*dentry = d;
+	up(&parent->d_inode->i_sem);
+	dput(parent);
+
+	return error;
+}
+
+/**
+ *	relayfs_create_file - create a file in the relay filesystem
+ *	@name: the name of the file to create
+ *	@parent: parent directory
+ *	@dentry: result dentry
+ *	@data: data to associate with the file
+ *
+ *	The file will be created user rwx on behalf of current user.
+ */
+int 
+relayfs_create_file(const char * name, struct dentry * parent, struct dentry **dentry, void * data)
+{
+	return relayfs_create_entry(name, parent, dentry, S_IFREG,
+				    S_IRWXU, data);
+}
+
+/**
+ *	relayfs_create_dir - create a directory in the relay filesystem
+ *	@name: the name of the directory to create
+ *	@parent: parent directory
+ *	@dentry: result dentry
+ *
+ *	The directory will be created world rwx on behalf of current user.
+ */
+int 
+relayfs_create_dir(const char * name, struct dentry * parent, struct dentry **dentry)
+{
+	return relayfs_create_entry(name, parent, dentry, S_IFDIR,
+				    S_IRWXU | S_IRUGO | S_IXUGO, NULL);
+}
+
+/**
+ *	relayfs_remove_file - remove a file in the relay filesystem
+ *	@dentry: file dentry
+ *
+ *	Remove a file previously created by relayfs_create_file.
+ */
+int 
+relayfs_remove_file(struct dentry *dentry)
+{
+	struct dentry *parent;
+	
+	parent = dentry->d_parent;
+	if (parent == NULL)
+		return -EINVAL;
+
+	parent = dget(parent);
+	down(&parent->d_inode->i_sem);
+	if (dentry->d_inode) {
+		simple_unlink(parent->d_inode, dentry);
+		d_delete(dentry);
+	}
+	up(&parent->d_inode->i_sem);
+	dput(parent);
+	
+	return 0;
+}
+
+/**
+ *	relayfs_open - open file op for relayfs files
+ *	@inode: the inode
+ *	@filp: the file
+ *
+ *	Associates the channel with the file, and increments the
+ *	channel refcount.
+ */
+int
+relayfs_open(struct inode *inode, struct file *filp)
+{
+	struct rchan *rchan;
+
+	if (inode->u.generic_ip) {
+		filp->private_data = inode->u.generic_ip;
+		rchan = (struct rchan *)inode->u.generic_ip;
+		/* Inc relay channel refcount for file */
+		rchan_get(rchan->id);
+	}
+
+	return 0;
+}
+
+/**
+ *	relayfs_mmap - mmap file op for relayfs files
+ *	@filp: the file
+ *	@vma: the vma describing what to map
+ *
+ *	Calls upon relay_mmap_buffer to map the file into user space.
+ */
+int 
+relayfs_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct rchan *rchan = (struct rchan *)filp->private_data;
+
+	return relay_mmap_buffer(rchan->id, vma);
+}
+
+/**
+ *	relayfs_file_read - read file op for relayfs files
+ *	@filp: the file
+ *	@buf: user buf to read into
+ *	@count: bytes requested
+ *	@offset: offset into file
+ *
+ *	Attempt to read count bytes into buffer.  If there are fewer
+ *	than count bytes available, return available.  if the read would
+ *	cross a sub-buffer boundary, this function will only return the
+ *	bytes available to the end of the sub-buffer; a subsequent read
+ *	would get the remaining bytes (starting from the beginning of the
+ *	buffer).  Because we're	reading from a circular buffer, if the
+ *	read would wrap around to sub-buffer 0, offset will be reset
+ *	to 0 to mark the beginning of the buffer.  If nothing at all
+ *	is available, the caller will be put on a wait queue until
+ *	there is.  This function takes into account the 'unused bytes',
+ *	if any, at the end of each sub-buffer, and will transparently
+ *	skip over them.
+ */
+ssize_t 
+relayfs_file_read(struct file *filp, char * buf, size_t count, loff_t *offset)
+{
+	u32 new_offset;
+	size_t read_count;
+
+	struct rchan *rchan = (struct rchan *)filp->private_data;
+
+	read_count = relay_read(rchan->id, buf, count, (u32)*offset, &new_offset, 1);
+	*offset = (loff_t)new_offset;
+
+	return read_count;
+}
+
+/**
+ *	relayfs_file_write - write file op for relayfs files
+ *	@filp: the file
+ *	@buf: user buf to write from
+ *	@count: bytes to write
+ *	@offset: offset into file
+ *
+ *	Reserves a slot in the relay buffer and writes count bytes
+ *	into it.  The current limit for a single write is 2 pages
+ *	worth.
+ */
+ssize_t 
+relayfs_file_write(struct file *filp, const char *buf, size_t count, loff_t *offset)
+{
+	int bytes_written;
+	char * write_buf;
+	
+	struct rchan *rchan = (struct rchan *)filp->private_data;
+
+	/* Change this if need to write more than 2 pages at once */
+	if (count > 2 * PAGE_SIZE)
+		return -EINVAL;
+	
+	write_buf = (char *)__get_free_pages(GFP_KERNEL, 1);
+	if (write_buf == NULL)
+		return -ENOMEM;
+
+	if (copy_from_user(write_buf, buf, count))
+		return -EFAULT;
+
+	
+	bytes_written = relay_write(rchan->id, write_buf, count, -1);
+	if (bytes_written > 0)
+		*offset += bytes_written;
+
+	free_pages((unsigned long)write_buf, 1);
+	
+	return bytes_written;
+}
+
+/**
+ *	relayfs_release - release file op for relayfs files
+ *	@inode: the inode
+ *	@filp: the file
+ *
+ *	Decrements the channel refcount, as the filesystem is
+ *	no longer using it.
+ */
+int
+relayfs_release(struct inode *inode, struct file *filp)
+{
+	int err = 0;
+	
+	struct rchan *rchan = (struct rchan *)filp->private_data;
+
+	/* The channel is no longer in use as far as this file is concerned */
+	rchan_put(rchan);
+	
+	return err;
+}
+
+static struct address_space_operations relayfs_aops = {
+	.readpage	= simple_readpage,
+	.prepare_write	= simple_prepare_write,
+	.commit_write	= simple_commit_write
+};
+
+static struct file_operations relayfs_file_operations = {
+	.open		= relayfs_open,
+	.read		= relayfs_file_read,
+	.write		= relayfs_file_write,
+	.mmap		= relayfs_mmap,
+	.fsync		= simple_sync_file,
+	.release	= relayfs_release,
+};
+
+static struct inode_operations relayfs_file_inode_operations = {
+	.getattr	= simple_getattr,
+};
+
+static struct inode_operations relayfs_dir_inode_operations = {
+	.create		= relayfs_create,
+	.lookup		= simple_lookup,
+	.link		= simple_link,
+	.unlink		= simple_unlink,
+	.symlink	= relayfs_symlink,
+	.mkdir		= relayfs_mkdir,
+	.rmdir		= simple_rmdir,
+	.mknod		= relayfs_mknod,
+	.rename		= simple_rename,
+};
+
+static struct super_operations relayfs_ops = {
+	.statfs		= simple_statfs,
+	.drop_inode	= generic_delete_inode,
+};
+
+static int 
+relayfs_fill_super(struct super_block * sb, void * data, int silent)
+{
+	struct inode * inode;
+	struct dentry * root;
+
+	sb->s_blocksize = PAGE_CACHE_SIZE;
+	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
+	sb->s_magic = RELAYFS_MAGIC;
+	sb->s_op = &relayfs_ops;
+	inode = relayfs_get_inode(sb, S_IFDIR | 0755, 0);
+
+	if (!inode)
+		return -ENOMEM;
+
+	root = d_alloc_root(inode);
+	if (!root) {
+		iput(inode);
+		return -ENOMEM;
+	}
+	sb->s_root = root;
+
+	return 0;
+}
+
+static struct super_block *
+relayfs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data)
+{
+	return get_sb_single(fs_type, flags, data, relayfs_fill_super);
+}
+
+static struct file_system_type relayfs_fs_type = {
+	.owner		= THIS_MODULE,
+	.name		= "relayfs",
+	.get_sb		= relayfs_get_sb,
+	.kill_sb	= kill_litter_super,
+};
+
+static int __init 
+init_relayfs_fs(void)
+{
+	int err;
+	
+	err = register_filesystem(&relayfs_fs_type);
+	if (!err) {
+		relayfs_mount = kern_mount(&relayfs_fs_type);
+		if (IS_ERR(relayfs_mount)) {
+			err = PTR_ERR(relayfs_mount);
+			printk(KERN_ERR "Couldn't mount relayfs: errcode %d\n", err);
+			relayfs_mount = NULL;
+		}
+	}
+	
+	return err;
+}
+
+static void __exit 
+exit_relayfs_fs(void)
+{
+	unregister_filesystem(&relayfs_fs_type);
+}
+
+module_init(init_relayfs_fs)
+module_exit(exit_relayfs_fs)
+
+MODULE_AUTHOR("Tom Zanussi <zanussi@us.ibm.com> and Karim Yaghmour <karim@opersys.com>");
+MODULE_DESCRIPTION("Relay Filesystem");
+MODULE_LICENSE("GPL");
+

-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

