Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbVANDEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbVANDEF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 22:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVANDEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 22:04:04 -0500
Received: from opersys.com ([64.40.108.71]:53007 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261871AbVANC5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 21:57:00 -0500
Message-ID: <41E736BF.1020902@opersys.com>
Date: Thu, 13 Jan 2005 22:04:31 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: [PATCH 2/4] relayfs for 2.6.10: common files
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The basic relayfs files.

Signed-off-by: Karim Yaghmour (karim@opersys.com)

Karim

--- linux-2.6.10/fs/Kconfig	2004-12-24 13:34:58.000000000 -0800
+++ linux-2.6.10-relayfs/fs/Kconfig	2005-01-13 10:40:25.000000000 -0800
@@ -972,6 +972,57 @@ config RAMFS
 	  To compile this as a module, choose M here: the module will be called
 	  ramfs.

+config RELAYFS_FS
+	tristate "Relayfs file system support"
+	---help---
+	  Relayfs is a high-speed data relay filesystem designed to provide
+	  an efficient mechanism for tools and facilities to relay large
+	  amounts of data from kernel space to user space.  It's not useful
+	  on its own, and should only be enabled if other facilities that
+	  need it are enabled, such as for example klog or the Linux Trace
+	  Toolkit.
+
+	  See <file:Documentation/filesystems/relayfs.txt> for further
+	  information.
+
+	  This file system is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module is called relayfs.  If you want to compile it as a
+	  module, say M here and read <file:Documentation/modules.txt>.
+
+	  If unsure, say N.
+
+config KLOG_CHANNEL
+	bool "Enable klog debugging support"
+	depends on RELAYFS_FS
+	default n
+	help
+	  If you say Y to this, a relayfs channel named klog will be created
+	  in the root of the relayfs file system.  You can write to the klog
+	  channel using klog() or klog_raw() from within the kernel or
+	  kernel modules, and read from the klog channel by mounting relayfs
+	  and using read(2) to read from it (or using cat).  If you're not
+	  sure, say N.
+
+config KLOG_CHANNEL_AUTOENABLE
+	bool "Enable klog logging on startup"
+	depends on KLOG_CHANNEL
+	default y
+	help
+	  If you say Y to this, the klog channel will be automatically enabled
+	  on startup.  Otherwise, to turn klog logging on, you need use
+	  sysctl (fs.relayfs.klog_enabled).  This option is used in cases where
+	  you don't actually want the channel to be written to until it's
+	  enabled.  If you're not sure, say Y.
+
+config KLOG_CHANNEL_SHIFT
+	depends on KLOG_CHANNEL
+	int "klog debugging channel size (14 => 16KB, 22 => 4MB)"
+	range 14 22
+	default 21
+	help
+	  Select klog debugging channel size as a power of 2.
+
 endmenu

 menu "Miscellaneous filesystems"
@@ -1297,8 +1348,6 @@ config HPFS_FS
 	  To compile this file system support as a module, choose M here: the
 	  module will be called hpfs.  If unsure, say N.

-
-
 config QNX4FS_FS
 	tristate "QNX4 file system support (read only)"
 	help
@@ -1324,8 +1373,6 @@ config QNX4FS_RW
 	  It's currently broken, so for now:
 	  answer N.

-
-
 config SYSV_FS
 	tristate "System V/Xenix/V7/Coherent file system support"
 	help
@@ -1362,8 +1409,6 @@ config SYSV_FS

 	  If you haven't heard about all of this before, it's safe to say N.

-
-
 config UFS_FS
 	tristate "UFS file system support (read only)"
 	help
--- linux-2.6.10/fs/Makefile	2004-12-24 13:34:58.000000000 -0800
+++ linux-2.6.10-relayfs/fs/Makefile	2005-01-13 10:40:25.000000000 -0800
@@ -53,6 +53,7 @@ obj-$(CONFIG_EXT2_FS)		+= ext2/
 obj-$(CONFIG_CRAMFS)		+= cramfs/
 obj-$(CONFIG_RAMFS)		+= ramfs/
 obj-$(CONFIG_HUGETLBFS)		+= hugetlbfs/
+obj-$(CONFIG_RELAYFS_FS)	+= relayfs/
 obj-$(CONFIG_CODA_FS)		+= coda/
 obj-$(CONFIG_MINIX_FS)		+= minix/
 obj-$(CONFIG_FAT_FS)		+= fat/
--- linux-2.6.10/fs/relayfs/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.10-relayfs/fs/relayfs/Makefile	2005-01-13 10:40:25.000000000 -0800
@@ -0,0 +1,8 @@
+#
+# relayfs Makefile
+#
+
+obj-$(CONFIG_RELAYFS_FS) += relayfs.o
+
+relayfs-y := relay.o relay_lockless.o relay_locking.o inode.o resize.o
+relayfs-$(CONFIG_KLOG_CHANNEL) += klog.o
--- linux-2.6.10/fs/relayfs/inode.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.10-relayfs/fs/relayfs/inode.c	2005-01-13 10:40:25.000000000 -0800
@@ -0,0 +1,629 @@
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
+#include <linux/poll.h>
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
+static int				relayfs_mount_count;
+
+static struct backing_dev_info		relayfs_backing_dev_info = {
+	.ra_pages	= 0,	/* No readahead */
+	.memory_backed	= 1,	/* Does not contribute to dirty memory */
+};
+
+static struct inode *
+relayfs_get_inode(struct super_block *sb, int mode, dev_t dev)
+{
+	struct inode * inode;
+	
+	inode = new_inode(sb);
+
+	if (inode) {
+		inode->i_mode = mode;
+		inode->i_uid = current->fsuid;
+		inode->i_gid = current->fsgid;
+		inode->i_blksize = PAGE_CACHE_SIZE;
+		inode->i_blocks = 0;
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
+	struct inode * inode;
+	int error = -ENOSPC;
+
+	inode = relayfs_get_inode(dir->i_sb, mode, dev);
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
+	int retval;
+
+	retval = relayfs_mknod(dir, dentry, mode | S_IFDIR, 0);
+
+	if (!retval)
+		dir->i_nlink++;
+	return retval;
+}
+
+static int
+relayfs_create(struct inode *dir, struct dentry *dentry, int mode, struct nameidata *nd)
+{
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
+	error = simple_pin_fs("relayfs", &relayfs_mount, &relayfs_mount_count);
+	if (error) {
+		printk(KERN_ERR "Couldn't mount relayfs: errcode %d\n", error);
+		return error;
+	}
+
+	qname.name = name;
+	qname.len = strlen(name);
+	qname.hash = full_name_hash(name, qname.len);
+
+	if (parent == NULL)
+		if (relayfs_mount && relayfs_mount->mnt_sb)
+			parent = relayfs_mount->mnt_sb->s_root;
+
+	if (parent == NULL) {
+		simple_release_fs(&relayfs_mount, &relayfs_mount_count);
+ 		return -EINVAL;
+	}
+
+	parent = dget(parent);
+	down(&parent->d_inode->i_sem);
+	d = lookup_hash(&qname, parent);
+	if (IS_ERR(d)) {
+		error = PTR_ERR(d);
+		goto release_mount;
+	}
+	
+	if (d->d_inode) {
+		error = -EEXIST;
+		goto release_mount;
+	}
+
+	if (entry_type == S_IFREG)
+		error = relayfs_create(parent->d_inode, d, entry_type | mode, NULL);
+	else
+		error = relayfs_mkdir(parent->d_inode, d, entry_type | mode);
+	if (error)
+		goto release_mount;
+
+	if ((entry_type == S_IFREG) && data) {
+		d->d_inode->u.generic_ip = data;
+		goto exit; /* don't release mount for regular files */
+	}
+
+release_mount:
+	simple_release_fs(&relayfs_mount, &relayfs_mount_count);
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
+ *	@mode: mode, if not specied the default perms are used
+ *
+ *	The file will be created user rw on behalf of current user.
+ */
+int
+relayfs_create_file(const char * name, struct dentry * parent, struct dentry **dentry, void * data, int mode)
+{
+	if (!mode)
+		mode = S_IRUSR | S_IWUSR;
+	
+	return relayfs_create_entry(name, parent, dentry, S_IFREG,
+				    mode, data);
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
+	int is_reg;
+	
+	parent = dentry->d_parent;
+	if (parent == NULL)
+		return -EINVAL;
+
+	is_reg = S_ISREG(dentry->d_inode->i_mode);
+
+	parent = dget(parent);
+	down(&parent->d_inode->i_sem);
+	if (dentry->d_inode) {
+		simple_unlink(parent->d_inode, dentry);
+		d_delete(dentry);
+	}
+	dput(dentry);
+	up(&parent->d_inode->i_sem);
+	dput(parent);
+
+	if(is_reg)
+		simple_release_fs(&relayfs_mount, &relayfs_mount_count);
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
+ *	channel refcount.  Reads will be 'auto-consuming'.
+ */
+int
+relayfs_open(struct inode *inode, struct file *filp)
+{
+	struct rchan *rchan;
+	struct rchan_reader *reader;
+	int retval = 0;
+
+	if (inode->u.generic_ip) {
+		rchan = (struct rchan *)inode->u.generic_ip;
+		if (rchan == NULL)
+			return -EACCES;
+		reader = __add_rchan_reader(rchan, filp, 1, 0);
+		if (reader == NULL)
+			return -ENOMEM;
+		filp->private_data = reader;
+		retval = rchan->callbacks->fileop_notify(rchan->id, filp,
+							 RELAY_FILE_OPEN);
+		if (retval == 0)
+			/* Inc relay channel refcount for file */
+			rchan_get(rchan->id);
+		else {
+			__remove_rchan_reader(reader);
+			retval = -EPERM;
+		}
+	}
+
+	return retval;
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
+	struct rchan *rchan;
+	
+	rchan = ((struct rchan_reader *)filp->private_data)->rchan;
+
+	return __relay_mmap_buffer(rchan, vma);
+}
+
+/**
+ *	relayfs_file_read - read file op for relayfs files
+ *	@filp: the file
+ *	@buf: user buf to read into
+ *	@count: bytes requested
+ *	@offset: offset into file
+ *
+ *	Reads count bytes from the channel, or as much as is available within
+ *	the sub-buffer currently being read.  Reads are 'auto-consuming'.
+ *	See relay_read() for details.
+ *
+ *	Returns bytes read on success, 0 or -EAGAIN if nothing available,
+ *	negative otherwise.
+ */
+ssize_t
+relayfs_file_read(struct file *filp, char * buf, size_t count, loff_t *offset)
+{
+	size_t read_count;
+	struct rchan_reader *reader;
+	u32 dummy; /* all VFS readers are auto-consuming */
+
+	if (count == 0)
+		return 0;
+
+	reader = (struct rchan_reader *)filp->private_data;
+	read_count = relay_read(reader, buf, count,
+		filp->f_flags & (O_NDELAY | O_NONBLOCK) ? 0 : 1, &dummy, (u32 *)offset);
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
+ *	worth.  The user_deliver() channel callback will be invoked on
+ *	
+ *	Returns bytes written on success, 0 or -EAGAIN if nothing available,
+ *	negative otherwise.
+ */
+ssize_t
+relayfs_file_write(struct file *filp, const char *buf, size_t count, loff_t *offset)
+{
+	int write_count;
+	char * write_buf;
+	struct rchan *rchan;
+	int err = 0;
+	void *wrote_pos;
+	struct rchan_reader *reader;
+
+	reader = (struct rchan_reader *)filp->private_data;
+	if (reader == NULL)
+		return -EPERM;
+
+	rchan = reader->rchan;
+	if (rchan == NULL)
+		return -EPERM;
+
+	if (count == 0)
+		return 0;
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
+	if (filp->f_flags & (O_NDELAY | O_NONBLOCK)) {
+		write_count = relay_write(rchan->id, write_buf, count, -1, &wrote_pos);
+		if (write_count == 0)
+			return -EAGAIN;
+	} else {
+		err = wait_event_interruptible(rchan->write_wait,
+	         (write_count = relay_write(rchan->id, write_buf, count, -1, &wrote_pos)));
+		if (err)
+			return err;
+	}
+	
+	free_pages((unsigned long)write_buf, 1);
+	
+        rchan->callbacks->user_deliver(rchan->id, wrote_pos, write_count);
+
+	*offset += write_count;
+	
+	return write_count;
+}
+
+/**
+ *	relayfs_ioctl - ioctl file op for relayfs files
+ *	@inode: the inode
+ *	@filp: the file
+ *	@cmd: the command
+ *	@arg: command arg
+ *
+ *	Passes the specified cmd/arg to the kernel client.  arg may be a
+ *	pointer to user-space data, in which case the kernel client is
+ *	responsible for copying the data to/from user space appropriately.
+ *	The kernel client is also responsible for returning a meaningful
+ *	return value for ioctl calls.
+ *	
+ *	Returns result of relay channel callback, -EPERM if unsuccessful.
+ */
+int
+relayfs_ioctl(struct inode *inode, struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct rchan *rchan;
+	struct rchan_reader *reader;
+
+	reader = (struct rchan_reader *)filp->private_data;
+	if (reader == NULL)
+		return -EPERM;
+
+	rchan = reader->rchan;
+	if (rchan == NULL)
+		return -EPERM;
+
+	return rchan->callbacks->ioctl(rchan->id, cmd, arg);
+}
+
+/**
+ *	relayfs_poll - poll file op for relayfs files
+ *	@filp: the file
+ *	@wait: poll table
+ *
+ *	Poll implemention.
+ */
+static unsigned int
+relayfs_poll(struct file *filp, poll_table *wait)
+{
+	struct rchan_reader *reader;
+	unsigned int mask = 0;
+	
+	reader = (struct rchan_reader *)filp->private_data;
+
+	if (reader->rchan->finalized)
+		return POLLERR;
+
+	if (filp->f_mode & FMODE_READ) {
+		poll_wait(filp, &reader->rchan->read_wait, wait);
+		if (!rchan_empty(reader))
+			mask |= POLLIN | POLLRDNORM;
+	}
+	
+	if (filp->f_mode & FMODE_WRITE) {
+		poll_wait(filp, &reader->rchan->write_wait, wait);
+		if (!rchan_full(reader))
+			mask |= POLLOUT | POLLWRNORM;
+	}
+	
+	return mask;
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
+	struct rchan_reader *reader;
+	struct rchan *rchan;
+
+	reader = (struct rchan_reader *)filp->private_data;
+	if (reader == NULL || reader->rchan == NULL)
+		return 0;
+	rchan = reader->rchan;
+	
+        rchan->callbacks->fileop_notify(reader->rchan->id, filp,
+					RELAY_FILE_CLOSE);
+	__remove_rchan_reader(reader);
+	/* The channel is no longer in use as far as this file is concerned */
+	rchan_put(rchan);
+
+	return 0;
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
+	.llseek		= no_llseek,
+	.read		= relayfs_file_read,
+	.write		= relayfs_file_write,
+	.ioctl		= relayfs_ioctl,
+	.poll		= relayfs_poll,
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
+	int err = register_filesystem(&relayfs_fs_type);
+#ifdef CONFIG_KLOG_CHANNEL
+	if (!err)
+		create_klog_channel();
+#endif
+	return err;
+}
+
+static void __exit
+exit_relayfs_fs(void)
+{
+#ifdef CONFIG_KLOG_CHANNEL
+	remove_klog_channel();
+#endif
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
--- linux-2.6.10/fs/relayfs/klog.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.10-relayfs/fs/relayfs/klog.c	2005-01-13 10:40:25.000000000 -0800
@@ -0,0 +1,206 @@
+/*
+ * KLOG		Generic Logging facility built upon the relayfs infrastructure
+ *
+ * Authors:	Hubertus Franke  (frankeh@us.ibm.com)
+ *		Tom Zanussi  (zanussi@us.ibm.com)
+ *
+ *		Please direct all questions/comments to zanussi@us.ibm.com
+ *
+ *		Copyright (C) 2003, IBM Corp
+ *
+ *		This program is free software; you can redistribute it and/or
+ *		modify it under the terms of the GNU General Public License
+ *		as published by the Free Software Foundation; either version
+ *		2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/smp_lock.h>
+#include <linux/console.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/delay.h>
+#include <linux/smp.h>
+#include <linux/sysctl.h>
+#include <linux/relayfs_fs.h>
+#include <linux/klog.h>
+
+/* klog channel id */
+static int klog_channel = -1;
+
+/* maximum size of klog formatting buffer beyond which truncation will occur */
+#define KLOG_BUF_SIZE (512)
+/* per-cpu klog formatting buffer */
+static char buf[NR_CPUS][KLOG_BUF_SIZE];
+
+/*
+ *	klog_enabled determines whether klog()/klog_raw() actually do write
+ *	to the klog channel at any given time. If klog_enabled == 1 they do,
+ *	otherwise they don't.  Settable using sysctl fs.relayfs.klog_enabled.
+ */
+#ifdef CONFIG_KLOG_CHANNEL_AUTOENABLE
+static int klog_enabled = 1;
+#else
+static int klog_enabled = 0;
+#endif
+
+/**
+ *	klog - write a formatted string into the klog channel
+ *	@fmt: format string
+ *
+ *	Returns number of bytes written, negative number on failure.
+ */
+int klog(const char *fmt, ...)
+{
+	va_list args;
+	int len, err;
+	char *cbuf;
+	unsigned long flags;
+
+	if (!klog_enabled || klog_channel < 0)
+		return 0;
+
+	local_irq_save(flags);
+	cbuf = buf[smp_processor_id()];
+
+	va_start(args, fmt);
+	len = vsnprintf(cbuf, KLOG_BUF_SIZE, fmt, args);
+	va_end(args);
+	
+	err = relay_write(klog_channel, cbuf, len, -1, NULL);
+	local_irq_restore(flags);
+
+	return err;
+}
+
+/**
+ *	klog_raw - directly write into the klog channel
+ *	@buf: buffer containing data to write
+ *	@len: # bytes to write
+ *
+ *	Returns number of bytes written, negative number on failure.
+ */
+int klog_raw(const char *buf,int len)
+{
+	int err = 0;
+	
+	if (klog_enabled && klog_channel >= 0)
+		err = relay_write(klog_channel, buf, len, -1, NULL);
+
+	return err;
+}
+
+/**
+ *	relayfs sysctl data
+ *
+ *	Only sys/fs/relayfs/klog_enabled for now.
+ */
+#define CTL_ENABLE_KLOG		100
+#define CTL_RELAYFS		100
+
+static struct ctl_table_header *relayfs_ctl_table_header;
+
+static struct ctl_table relayfs_table[] =
+{
+	{
+		.ctl_name	= CTL_ENABLE_KLOG,
+		.procname	= "klog_enabled",
+		.data		= &klog_enabled,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		0
+	}
+};
+
+static struct ctl_table relayfs_dir_table[] =
+{
+	{
+		.ctl_name	= CTL_RELAYFS,
+		.procname	= "relayfs",
+		.data		= NULL,
+		.maxlen		= 0,
+		.mode		= 0555,
+		.child		= relayfs_table,
+	},
+	{
+		0
+	}
+};
+
+static struct ctl_table relayfs_root_table[] =
+{
+	{
+		.ctl_name	= CTL_FS,
+		.procname	= "fs",
+		.data		= NULL,
+		.maxlen		= 0,
+		.mode		= 0555,
+		.child		= relayfs_dir_table,
+	},
+	{
+		0
+	}
+};
+
+/**
+ *	create_klog_channel - creates channel /mnt/relay/klog
+ *
+ *	Returns channel id on success, negative otherwise.
+ */
+int
+create_klog_channel(void)
+{
+	u32 bufsize, nbufs;
+	u32 channel_flags;
+
+	channel_flags = RELAY_DELIVERY_PACKET | RELAY_USAGE_GLOBAL;
+	channel_flags |= RELAY_SCHEME_ANY | RELAY_TIMESTAMP_ANY;
+
+	bufsize = 1 << (CONFIG_KLOG_CHANNEL_SHIFT - 2);
+	nbufs = 4;
+
+	klog_channel = relay_open("klog",
+				  bufsize,
+				  nbufs,
+				  channel_flags,
+				  NULL,
+				  0,
+				  0,
+				  0,
+				  0,
+				  0,
+				  0,
+				  NULL,
+				  0);
+
+	if (klog_channel < 0)
+		printk("klog channel creation failed, errcode: %d\n", klog_channel);
+	else {
+		printk("klog channel created (%u bytes)\n", 1 << CONFIG_KLOG_CHANNEL_SHIFT);
+		relayfs_ctl_table_header = register_sysctl_table(relayfs_root_table, 1);
+	}
+
+	return klog_channel;
+}
+
+/**
+ *	remove_klog_channel - destroys channel /mnt/relay/klog
+ *
+ *	Returns 0, negative otherwise.
+ */
+int
+remove_klog_channel(void)
+{
+	if (relayfs_ctl_table_header)
+		unregister_sysctl_table(relayfs_ctl_table_header);
+	
+	return relay_close(klog_channel);
+}
+
+EXPORT_SYMBOL(klog);
+EXPORT_SYMBOL(klog_raw);
+
--- linux-2.6.10/fs/relayfs/relay.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.10-relayfs/fs/relayfs/relay.c	2005-01-13 12:10:04.577024426 -0800
@@ -0,0 +1,1954 @@
+/*
+ * Public API and common code for RelayFS.
+ *
+ * Please see Documentation/filesystems/relayfs.txt for API description.
+ *
+ * Copyright (C) 2002, 2003 - Tom Zanussi (zanussi@us.ibm.com), IBM Corp
+ * Copyright (C) 1999, 2000, 2001, 2002 - Karim Yaghmour (karim@opersys.com)
+ *
+ * This file is released under the GPL.
+ */
+
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/stddef.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/time.h>
+#include <linux/page-flags.h>
+#include <linux/vmalloc.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/delay.h>
+
+#include <asm/io.h>
+#include <asm/current.h>
+#include <asm/uaccess.h>
+#include <asm/bitops.h>
+#include <asm/pgtable.h>
+#include <asm/relay.h>
+#include <asm/hardirq.h>
+
+#include "relay_lockless.h"
+#include "relay_locking.h"
+#include "resize.h"
+
+/* Relay channel table, indexed by channel id */
+static struct rchan *	rchan_table[RELAY_MAX_CHANNELS];
+static rwlock_t		rchan_table_lock = RW_LOCK_UNLOCKED;
+
+/* Relay operation structs, one per scheme */
+static struct relay_ops lockless_ops = {
+	.reserve = lockless_reserve,
+	.commit = lockless_commit,
+	.get_offset = lockless_get_offset,
+	.finalize = lockless_finalize,
+	.reset = lockless_reset,
+	.reset_index = lockless_reset_index
+};
+
+static struct relay_ops locking_ops = {
+	.reserve = locking_reserve,
+	.commit = locking_commit,
+	.get_offset = locking_get_offset,
+	.finalize = locking_finalize,
+	.reset = locking_reset,
+	.reset_index = locking_reset_index
+};
+
+/*
+ * Low-level relayfs kernel API.  These functions should not normally be
+ * used by clients.  See high-level kernel API below.
+ */
+
+/**
+ *	rchan_get - get channel associated with id, incrementing refcount
+ *	@rchan_id: the channel id
+ *
+ *	Returns channel if successful, NULL otherwise.
+ */
+struct rchan *
+rchan_get(int rchan_id)
+{
+	struct rchan *rchan;
+	
+	if ((rchan_id < 0) || (rchan_id >= RELAY_MAX_CHANNELS))
+		return NULL;
+	
+	read_lock(&rchan_table_lock);
+	rchan = rchan_table[rchan_id];
+	if (rchan)
+		atomic_inc(&rchan->refcount);
+	read_unlock(&rchan_table_lock);
+
+	return rchan;
+}
+
+/**
+ *	clear_readers - clear non-VFS readers
+ *	@rchan: the channel
+ *
+ *	Clear the channel pointers of all non-VFS readers open on the channel.
+ */
+static inline void
+clear_readers(struct rchan *rchan)
+{
+	struct list_head *p;
+	struct rchan_reader *reader;
+	
+	read_lock(&rchan->open_readers_lock);
+	list_for_each(p, &rchan->open_readers) {
+		reader = list_entry(p, struct rchan_reader, list);
+		if (!reader->vfs_reader)
+			reader->rchan = NULL;
+	}
+	read_unlock(&rchan->open_readers_lock);
+}
+
+/**
+ *	rchan_alloc_id - reserve a channel id and store associated channel
+ *	@rchan: the channel
+ *
+ *	Returns channel id if successful, -1 otherwise.
+ */
+static inline int
+rchan_alloc_id(struct rchan *rchan)
+{
+	int i;
+	int rchan_id = -1;
+	
+	if (rchan == NULL)
+		return -1;
+
+	write_lock(&rchan_table_lock);
+	for (i = 0; i < RELAY_MAX_CHANNELS; i++) {
+		if (rchan_table[i] == NULL) {
+			rchan_table[i] = rchan;
+			rchan_id = rchan->id = i;
+			break;
+		}
+	}
+	if (rchan_id != -1)
+		atomic_inc(&rchan->refcount);
+	write_unlock(&rchan_table_lock);
+	
+	return rchan_id;
+}
+
+/**
+ *	rchan_free_id - revoke a channel id and remove associated channel
+ *	@rchan_id: the channel id
+ */
+static inline void
+rchan_free_id(int rchan_id)
+{
+	struct rchan *rchan;
+
+	if ((rchan_id < 0) || (rchan_id >= RELAY_MAX_CHANNELS))
+		return;
+
+	write_lock(&rchan_table_lock);
+	rchan = rchan_table[rchan_id];
+	rchan_table[rchan_id] = NULL;
+	write_unlock(&rchan_table_lock);
+}
+
+/**
+ *	rchan_destroy_buf - destroy the current channel buffer
+ *	@rchan: the channel
+ */
+static inline int
+rchan_destroy_buf(struct rchan *rchan)
+{
+	int err = 0;
+	
+	if (rchan->buf && !rchan->init_buf)
+		err = free_rchan_buf(rchan->buf,
+				     rchan->buf_page_array,
+				     rchan->buf_page_count);
+
+	return err;
+}
+
+/**
+ *     remove_rchan_file - remove the channel file
+ *     @private: pointer to the channel struct
+ *
+ *     Internal - manages the removal of old channel file
+ */
+static void
+remove_rchan_file(void *private)
+{
+	struct rchan *rchan = (struct rchan *)private;
+
+	relayfs_remove_file(rchan->dentry);
+}
+
+
+/**
+ *	relay_release - perform end-of-buffer processing for last buffer
+ *	@rchan: the channel
+ *
+ *	Returns 0 if successful, negative otherwise.
+ *
+ *	Releases the channel buffer, destroys the channel, and removes the
+ *	relay file from the relayfs filesystem.  Should only be called from
+ *	rchan_put().  If we're here, it means by definition refcount is 0.
+ */
+static int
+relay_release(struct rchan *rchan)
+{
+	int err = 0;
+	
+	if (rchan == NULL) {
+		err = -EBADF;
+		goto exit;
+	}
+
+	err = rchan_destroy_buf(rchan);
+	if (err)
+		goto exit;
+
+	rchan_free_id(rchan->id);
+
+	INIT_WORK(&rchan->work, remove_rchan_file, rchan);
+	schedule_delayed_work(&rchan->work, 1);
+
+	clear_readers(rchan);
+	kfree(rchan);
+exit:
+	return err;
+}
+
+/**
+ *	rchan_get - decrement channel refcount, releasing it if 0
+ *	@rchan: the channel
+ *
+ *	If the refcount reaches 0, the channel will be destroyed.
+ */
+void
+rchan_put(struct rchan *rchan)
+{
+	if (atomic_dec_and_test(&rchan->refcount))
+		relay_release(rchan);
+}
+
+/**
+ *	relay_reserve -  reserve a slot in the channel buffer
+ *	@rchan: the channel
+ *	@len: the length of the slot to reserve
+ *	@td: the time delta between buffer start and current write, or TSC
+ *	@err: receives the result flags
+ *	@interrupting: 1 if interrupting previous, used only in locking scheme
+ *
+ *	Returns pointer to the beginning of the reserved slot, NULL if error.
+ *
+ *	The errcode value contains the result flags and is an ORed combination
+ *	of the following:
+ *
+ *	RELAY_BUFFER_SWITCH_NONE - no buffer switch occurred
+ *	RELAY_EVENT_DISCARD_NONE - event should not be discarded
+ *	RELAY_BUFFER_SWITCH - buffer switch occurred
+ *	RELAY_EVENT_DISCARD - event should be discarded (all buffers are full)
+ *	RELAY_EVENT_TOO_LONG - event won't fit into even an empty buffer
+ *
+ *	buffer_start and buffer_end callbacks are triggered at this point
+ *	if applicable.
+ */
+char *
+relay_reserve(struct rchan *rchan,
+	      u32 len,
+	      struct timeval *ts,
+	      u32 *td,
+	      int *err,
+	      int *interrupting)
+{
+	if (rchan == NULL)
+		return NULL;
+	
+	*interrupting = 0;
+
+	return rchan->relay_ops->reserve(rchan, len, ts, td, err, interrupting);
+}
+
+
+/**
+ *	wakeup_readers - wake up VFS readers waiting on a channel
+ *	@private: the channel
+ *
+ *	This is the work function used to defer reader waking.  The
+ *	reason waking is deferred is that calling directly from commit
+ *	causes problems if you're writing from say the scheduler.
+ */
+static void
+wakeup_readers(void *private)
+{
+	struct rchan *rchan = (struct rchan *)private;
+
+	wake_up_interruptible(&rchan->read_wait);
+}
+
+
+/**
+ *	relay_commit - commit a reserved slot in the buffer
+ *	@rchan: the channel
+ *	@from: commit the length starting here
+ *	@len: length committed
+ *	@interrupting: 1 if interrupting previous, used only in locking scheme
+ *
+ *      After the write into the reserved buffer has been complted, this
+ *      function must be called in order for the relay to determine whether
+ *      buffers are complete and to wake up VFS readers.
+ *
+ *	delivery callback is triggered at this point if applicable.
+ */
+void
+relay_commit(struct rchan *rchan,
+	     char *from,
+	     u32 len,
+	     int reserve_code,
+	     int interrupting)
+{
+	int deliver;
+
+	if (rchan == NULL)
+		return;
+	
+	deliver = packet_delivery(rchan) ||
+		   (reserve_code & RELAY_BUFFER_SWITCH);
+
+	rchan->relay_ops->commit(rchan, from, len, deliver, interrupting);
+
+	/* The params are always the same, so no worry about re-queuing */
+	if (deliver && 	waitqueue_active(&rchan->read_wait)) {
+		PREPARE_WORK(&rchan->wake_readers, wakeup_readers, rchan);
+		schedule_delayed_work(&rchan->wake_readers, 1);
+	}
+}
+
+/**
+ *	relay_get_offset - get current and max channel buffer offsets
+ *	@rchan: the channel
+ *	@max_offset: maximum channel offset
+ *
+ *	Returns the current and maximum channel buffer offsets.
+ */
+u32
+relay_get_offset(struct rchan *rchan, u32 *max_offset)
+{
+	return rchan->relay_ops->get_offset(rchan, max_offset);
+}
+
+/**
+ *	reset_index - try once to reset the current channel index
+ *	@rchan: the channel
+ *	@old_index: the index read before reset
+ *
+ *	Attempts to reset the channel index to 0.  It tries once, and
+ *	if it fails, returns negative, 0 otherwise.
+ */
+int
+reset_index(struct rchan *rchan, u32 old_index)
+{
+	return rchan->relay_ops->reset_index(rchan, old_index);
+}
+
+/*
+ * close() vm_op implementation for relayfs file mapping.
+ */
+static void
+relay_file_mmap_close(struct vm_area_struct *vma)
+{
+	struct file *filp = vma->vm_file;
+	struct rchan_reader *reader;
+	struct rchan *rchan;
+
+	reader = (struct rchan_reader *)filp->private_data;
+	rchan = reader->rchan;
+
+	atomic_dec(&rchan->mapped);
+
+	rchan->callbacks->fileop_notify(reader->rchan->id, filp,
+					RELAY_FILE_UNMAP);
+}
+
+/*
+ * vm_ops for relay file mappings.
+ */
+static struct vm_operations_struct relay_file_mmap_ops = {
+	.close = relay_file_mmap_close
+};
+
+/* \begin{Code inspired from BTTV driver} */
+static inline unsigned long
+kvirt_to_pa(unsigned long adr)
+{
+	unsigned long kva, ret;
+
+	kva = (unsigned long) page_address(vmalloc_to_page((void *) adr));
+	kva |= adr & (PAGE_SIZE - 1);
+	ret = __pa(kva);
+	return ret;
+}
+
+static int
+relay_mmap_region(struct vm_area_struct *vma,
+		  const char *adr,
+		  const char *start_pos,
+		  unsigned long size)
+{
+	unsigned long start = (unsigned long) adr;
+	unsigned long page, pos;
+
+	pos = (unsigned long) start_pos;
+
+	while (size > 0) {
+		page = kvirt_to_pa(pos);
+		if (remap_pfn_range(vma, start, page >> PAGE_SHIFT,
+					PAGE_SIZE, PAGE_SHARED))
+			return -EAGAIN;
+		start += PAGE_SIZE;
+		pos += PAGE_SIZE;
+		size -= PAGE_SIZE;
+	}
+
+	return 0;
+}
+/* \end{Code inspired from BTTV driver} */
+
+/**
+ *	relay_mmap_buffer: - mmap buffer to process address space
+ *	@rchan_id: relay channel id
+ *	@vma: vm_area_struct describing memory to be mapped
+ *
+ *	Returns:
+ *	0 if ok
+ *	-EAGAIN, when remap failed
+ *	-EINVAL, invalid requested length
+ *
+ *	Caller should already have grabbed mmap_sem.
+ */
+int
+__relay_mmap_buffer(struct rchan *rchan,
+		    struct vm_area_struct *vma)
+{
+	int err = 0;
+	unsigned long length = vma->vm_end - vma->vm_start;
+	struct file *filp = vma->vm_file;
+
+	if (rchan == NULL) {
+		err = -EBADF;
+		goto exit;
+	}
+
+	if (rchan->init_buf) {
+		err = -EPERM;
+		goto exit;
+	}
+	
+	if (length != (unsigned long)rchan->alloc_size) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	err = relay_mmap_region(vma,
+				(char *)vma->vm_start,
+				rchan->buf,
+				rchan->alloc_size);
+
+	if (err == 0) {
+		vma->vm_ops = &relay_file_mmap_ops;
+		err = rchan->callbacks->fileop_notify(rchan->id, filp,
+						      RELAY_FILE_MAP);
+		if (err == 0)
+			atomic_inc(&rchan->mapped);
+	}
+exit:	
+	return err;
+}
+
+/*
+ * High-level relayfs kernel API.  See Documentation/filesystems/relafys.txt.
+ */
+
+/*
+ * rchan_callback implementations defining default channel behavior.  Used
+ * in place of corresponding NULL values in client callback struct.
+ */
+
+/*
+ * buffer_end() default callback.  Does nothing.
+ */
+static int
+buffer_end_default_callback(int rchan_id,
+			    char *current_write_pos,
+			    char *end_of_buffer,
+			    struct timeval end_time,
+			    u32 end_tsc,
+			    int using_tsc)
+{
+	return 0;
+}
+
+/*
+ * buffer_start() default callback.  Does nothing.
+ */
+static int
+buffer_start_default_callback(int rchan_id,
+			      char *current_write_pos,
+			      u32 buffer_id,
+			      struct timeval start_time,
+			      u32 start_tsc,
+			      int using_tsc)
+{
+	return 0;
+}
+
+/*
+ * deliver() default callback.  Does nothing.
+ */
+static void
+deliver_default_callback(int rchan_id, char *from, u32 len)
+{
+}
+
+/*
+ * user_deliver() default callback.  Does nothing.
+ */
+static void
+user_deliver_default_callback(int rchan_id, char *from, u32 len)
+{
+}
+
+/*
+ * needs_resize() default callback.  Does nothing.
+ */
+static void
+needs_resize_default_callback(int rchan_id,
+			      int resize_type,
+			      u32 suggested_buf_size,
+			      u32 suggested_n_bufs)
+{
+}
+
+/*
+ * fileop_notify() default callback.  Does nothing.
+ */
+static int
+fileop_notify_default_callback(int rchan_id,
+			       struct file *filp,
+			       enum relay_fileop fileop)
+{
+	return 0;
+}
+
+/*
+ * ioctl() default callback.  Does nothing.
+ */
+static int
+ioctl_default_callback(int rchan_id,
+		       unsigned int cmd,
+		       unsigned long arg)
+{
+	return 0;
+}
+
+/* relay channel default callbacks */
+static struct rchan_callbacks default_channel_callbacks = {
+	.buffer_start = buffer_start_default_callback,
+	.buffer_end = buffer_end_default_callback,
+	.deliver = deliver_default_callback,
+	.user_deliver = user_deliver_default_callback,
+	.needs_resize = needs_resize_default_callback,
+	.fileop_notify = fileop_notify_default_callback,
+	.ioctl = ioctl_default_callback,
+};
+
+/**
+ *	check_attribute_flags - check sanity of channel attributes
+ *	@flags: channel attributes
+ *	@resizeable: 1 if true
+ *
+ *	Returns 0 if successful, negative otherwise.
+ */
+static int
+check_attribute_flags(u32 *attribute_flags, int resizeable)
+{
+	u32 flags = *attribute_flags;
+	
+	if (!(flags & RELAY_DELIVERY_BULK) && !(flags & RELAY_DELIVERY_PACKET))
+		return -EINVAL; /* Delivery mode must be specified */
+	
+	if (!(flags & RELAY_USAGE_SMP) && !(flags & RELAY_USAGE_GLOBAL))
+		return -EINVAL; /* Usage must be specified */
+	
+	if (resizeable) {  /* Resizeable can never be continuous */
+		*attribute_flags &= ~RELAY_MODE_CONTINUOUS;
+		*attribute_flags |= RELAY_MODE_NO_OVERWRITE;
+	}
+	
+	if ((flags & RELAY_MODE_CONTINUOUS) &&
+	    (flags & RELAY_MODE_NO_OVERWRITE))
+		return -EINVAL; /* Can't have it both ways */
+	
+	if (!(flags & RELAY_MODE_CONTINUOUS) &&
+	    !(flags & RELAY_MODE_NO_OVERWRITE))
+		*attribute_flags |= RELAY_MODE_CONTINUOUS; /* Default to continuous */
+	
+	if (!(flags & RELAY_SCHEME_ANY))
+		return -EINVAL; /* One or both must be specified */
+	else if (flags & RELAY_SCHEME_LOCKLESS) {
+		if (have_cmpxchg())
+			*attribute_flags &= ~RELAY_SCHEME_LOCKING;
+		else if (flags & RELAY_SCHEME_LOCKING)
+			*attribute_flags &= ~RELAY_SCHEME_LOCKLESS;
+		else
+			return -EINVAL; /* Locking scheme not an alternative */
+	}
+	
+	if (!(flags & RELAY_TIMESTAMP_ANY))
+		return -EINVAL; /* One or both must be specified */
+	else if (flags & RELAY_TIMESTAMP_TSC) {
+		if (have_tsc())
+			*attribute_flags &= ~RELAY_TIMESTAMP_GETTIMEOFDAY;
+		else if (flags & RELAY_TIMESTAMP_GETTIMEOFDAY)
+			*attribute_flags &= ~RELAY_TIMESTAMP_TSC;
+		else
+			return -EINVAL; /* gettimeofday not an alternative */
+	}
+
+	return 0;
+}
+
+/*
+ * High-level API functions.
+ */
+
+/**
+ *	__relay_reset - internal reset function
+ *	@rchan: the channel
+ *	@init: 1 if this is a first-time channel initialization
+ *
+ *	See relay_reset for description of effect.
+ */
+void
+__relay_reset(struct rchan *rchan, int init)
+{
+	int i;
+	
+	if (init) {
+		rchan->version = RELAYFS_CHANNEL_VERSION;
+		init_MUTEX(&rchan->resize_sem);
+		init_waitqueue_head(&rchan->read_wait);
+		init_waitqueue_head(&rchan->write_wait);
+		atomic_set(&rchan->refcount, 0);
+		INIT_LIST_HEAD(&rchan->open_readers);
+		rchan->open_readers_lock = RW_LOCK_UNLOCKED;
+	}
+	
+	rchan->buf_id = rchan->buf_idx = 0;
+	atomic_set(&rchan->suspended, 0);
+	atomic_set(&rchan->mapped, 0);
+	rchan->half_switch = 0;
+	rchan->bufs_produced = 0;
+	rchan->bufs_consumed = 0;
+	rchan->bytes_consumed = 0;
+	rchan->read_start = 0;
+	rchan->initialized = 0;
+	rchan->finalized = 0;
+	rchan->resize_min = rchan->resize_max = 0;
+	rchan->resizing = 0;
+	rchan->replace_buffer = 0;
+	rchan->resize_buf = NULL;
+	rchan->resize_buf_size = 0;
+	rchan->resize_alloc_size = 0;
+	rchan->resize_n_bufs = 0;
+	rchan->resize_err = 0;
+	rchan->resize_failures = 0;
+	rchan->resize_order = 0;
+
+	rchan->expand_page_array = NULL;
+	rchan->expand_page_count = 0;
+	rchan->shrink_page_array = NULL;
+	rchan->shrink_page_count = 0;
+	rchan->resize_page_array = NULL;
+	rchan->resize_page_count = 0;
+	rchan->old_buf_page_array = NULL;
+	rchan->expand_buf_id = 0;
+
+	INIT_WORK(&rchan->wake_readers, NULL, NULL);
+	INIT_WORK(&rchan->wake_writers, NULL, NULL);
+
+	for (i = 0; i < RELAY_MAX_BUFS; i++)
+		rchan->unused_bytes[i] = 0;
+	
+	rchan->relay_ops->reset(rchan, init);
+}
+
+/**
+ *	relay_reset - reset the channel
+ *	@rchan: the channel
+ *
+ *	Returns 0 if successful, negative if not.
+ *
+ *	This has the effect of erasing all data from the buffer and
+ *	restarting the channel in its initial state.  The buffer itself
+ *	is not freed, so any mappings are still in effect.
+ *
+ *	NOTE: Care should be taken that the channel isn't actually
+ *	being used by anything when this call is made.
+ */
+int
+relay_reset(int rchan_id)
+{
+	struct rchan *rchan;
+
+	rchan = rchan_get(rchan_id);
+	if (rchan == NULL)
+		return -EBADF;
+
+	__relay_reset(rchan, 0);
+	update_readers_consumed(rchan, 0, 0);
+
+	rchan_put(rchan);
+
+	return 0;
+}
+
+/**
+ *	check_init_buf - check the sanity of init_buf, if present
+ *	@init_buf: the initbuf
+ *	@init_buf_size: the total initbuf size
+ *	@bufsize: the channel's sub-buffer size
+ *	@nbufs: the number of sub-buffers in the channel
+ *
+ *	Returns 0 if ok, negative otherwise.
+ */
+static int
+check_init_buf(char *init_buf, u32 init_buf_size, u32 bufsize, u32 nbufs)
+{
+	int err = 0;
+	
+	if (init_buf && nbufs == 1) /* 1 sub-buffer makes no sense */
+		err = -EINVAL;
+
+	if (init_buf && (bufsize * nbufs != init_buf_size))
+		err = -EINVAL;
+
+	return err;
+}
+
+/**
+ *	rchan_create_buf - allocate the initial channel buffer
+ *	@rchan: the channel
+ *	@size_alloc: the total size of the channel buffer
+ *
+ *	Returns 0 if successful, negative otherwise.
+ */
+static inline int
+rchan_create_buf(struct rchan *rchan, int size_alloc)
+{
+	struct page **page_array;
+	int page_count;
+
+	if ((rchan->buf = (char *)alloc_rchan_buf(size_alloc, &page_array, &page_count)) == NULL) {
+		rchan->buf_page_array = NULL;
+		rchan->buf_page_count = 0;
+		return -ENOMEM;
+	}
+
+	rchan->buf_page_array = page_array;
+	rchan->buf_page_count = page_count;
+
+	return 0;
+}
+
+/**
+ *	rchan_create - allocate and initialize a channel, including buffer
+ *	@chanpath: path specifying the relayfs channel file to create
+ *	@bufsize: the size of the sub-buffers within the channel buffer
+ *	@nbufs: the number of sub-buffers within the channel buffer
+ *	@rchan_flags: flags specifying buffer attributes
+ *	@err: err code
+ *
+ *	Returns channel if successful, NULL otherwise, err receives errcode.
+ *
+ *	Allocates a struct rchan representing a relay channel, according
+ *	to the attributes passed in via rchan_flags.  Does some basic sanity
+ *	checking but doesn't try to do anything smart.  In particular, the
+ *	number of buffers must be a power of 2, and if the lockless scheme
+ *	is being used, the sub-buffer size must also be a power of 2.  The
+ *	locking scheme can use buffers of any size.
+ */
+static struct rchan *
+rchan_create(const char *chanpath,
+	     int bufsize,
+	     int nbufs,
+	     u32 rchan_flags,
+	     char *init_buf,
+	     u32 init_buf_size,
+	     int *err)
+{
+	int size_alloc;
+	struct rchan *rchan = NULL;
+
+	*err = 0;
+
+	rchan = (struct rchan *)kmalloc(sizeof(struct rchan), GFP_KERNEL);
+	if (rchan == NULL) {
+		*err = -ENOMEM;
+		return NULL;
+	}
+	rchan->buf = rchan->init_buf = NULL;
+
+	*err = check_init_buf(init_buf, init_buf_size, bufsize, nbufs);
+	if (*err)
+		goto exit;
+	
+	if (nbufs == 1 && bufsize) {
+		rchan->n_bufs = nbufs;
+		rchan->buf_size = bufsize;
+		size_alloc = bufsize;
+		goto alloc;
+	}
+	
+	if (bufsize <= 0 ||
+	    (rchan_flags & RELAY_SCHEME_LOCKLESS && hweight32(bufsize) != 1) ||
+	    hweight32(nbufs) != 1 ||
+	    nbufs < RELAY_MIN_BUFS ||
+	    nbufs > RELAY_MAX_BUFS) {
+		*err = -EINVAL;
+		goto exit;
+	}
+
+	size_alloc = FIX_SIZE(bufsize * nbufs);
+	if (size_alloc > RELAY_MAX_BUF_SIZE) {
+		*err = -EINVAL;
+		goto exit;
+	}
+	rchan->n_bufs = nbufs;
+	rchan->buf_size = bufsize;
+
+	if (rchan_flags & RELAY_SCHEME_LOCKLESS) {
+		offset_bits(rchan) = ffs(bufsize) - 1;
+		offset_mask(rchan) =  RELAY_BUF_OFFSET_MASK(offset_bits(rchan));
+		bufno_bits(rchan) = ffs(nbufs) - 1;
+	}
+alloc:
+	if (rchan_alloc_id(rchan) == -1) {
+		*err = -ENOMEM;
+		goto exit;
+	}
+
+	if (init_buf == NULL) {
+		*err = rchan_create_buf(rchan, size_alloc);
+		if (*err) {
+			rchan_free_id(rchan->id);
+			goto exit;
+		}
+	} else
+		rchan->buf = rchan->init_buf = init_buf;
+	
+	rchan->alloc_size = size_alloc;
+
+	if (rchan_flags & RELAY_SCHEME_LOCKLESS)
+		rchan->relay_ops = &lockless_ops;
+	else
+		rchan->relay_ops = &locking_ops;
+
+exit:
+	if (*err) {
+		kfree(rchan);
+		rchan = NULL;
+	}
+
+	return rchan;
+}
+
+
+static char tmpname[NAME_MAX];
+
+/**
+ *	rchan_create_dir - create directory for file
+ *	@chanpath: path to file, including filename
+ *	@residual: filename remaining after parse
+ *	@topdir: the directory filename should be created in
+ *
+ *	Returns 0 if successful, negative otherwise.
+ *
+ *	Inspired by xlate_proc_name() in procfs.  Given a file path which
+ *	includes the filename, creates any and all directories necessary
+ *	to create the file.
+ */
+static int
+rchan_create_dir(const char * chanpath,
+		 const char **residual,
+		 struct dentry **topdir)
+{
+	const char *cp = chanpath, *next;
+	struct dentry *parent = NULL;
+	int len, err = 0;
+	
+	while (1) {
+		next = strchr(cp, '/');
+		if (!next)
+			break;
+
+		len = next - cp;
+
+		strncpy(tmpname, cp, len);
+		tmpname[len] = '\0';
+		err = relayfs_create_dir(tmpname, parent, &parent);
+		if (err && (err != -EEXIST))
+			return err;
+		cp += len + 1;
+	}
+
+	*residual = cp;
+	*topdir = parent;
+
+	return err;
+}
+
+/**
+ *	rchan_create_file - create file, including parent directories
+ *	@chanpath: path to file, including filename
+ *	@dentry: result dentry
+ *	@data: data to associate with the file
+ *
+ *	Returns 0 if successful, negative otherwise.
+ */
+static int
+rchan_create_file(const char * chanpath,
+		  struct dentry **dentry,
+		  struct rchan * data,
+		  int mode)
+{
+	int err;
+	const char * fname;
+	struct dentry *topdir;
+
+	err = rchan_create_dir(chanpath, &fname, &topdir);
+	if (err && (err != -EEXIST))
+		return err;
+
+	err = relayfs_create_file(fname, topdir, dentry, (void *)data, mode);
+
+	return err;
+}
+
+/**
+ *	relay_open - create a new file/channel buffer in relayfs
+ *	@chanpath: name of file to create, including path
+ *	@bufsize: size of sub-buffers
+ *	@nbufs: number of sub-buffers
+ *	@flags: channel attributes
+ *	@callbacks: client callback functions
+ *	@start_reserve: number of bytes to reserve at start of each sub-buffer
+ *	@end_reserve: number of bytes to reserve at end of each sub-buffer
+ *	@rchan_start_reserve: additional reserve at start of first sub-buffer
+ *	@resize_min: minimum total buffer size, if set
+ *	@resize_max: maximum total buffer size, if set
+ *	@mode: the perms to be given to the relayfs file, 0 to accept defaults
+ *	@init_buf: initial memory buffer to start out with, NULL if N/A
+ *	@init_buf_size: initial memory buffer size to start out with, 0 if N/A
+ *
+ *	Returns channel id if successful, negative otherwise.
+ *
+ *	Creates a relay channel using the sizes and attributes specified.
+ *	The default permissions, used if mode == 0 are S_IRUSR | S_IWUSR.  See
+ *	Documentation/filesystems/relayfs.txt for details.
+ */
+int
+relay_open(const char *chanpath,
+	   int bufsize,
+	   int nbufs,
+	   u32 flags,
+	   struct rchan_callbacks *channel_callbacks,
+	   u32 start_reserve,
+	   u32 end_reserve,
+	   u32 rchan_start_reserve,
+	   u32 resize_min,
+	   u32 resize_max,
+	   int mode,
+	   char *init_buf,
+	   u32 init_buf_size)
+{
+	int err;
+	struct rchan *rchan;
+	struct dentry *dentry;
+	struct rchan_callbacks *callbacks = NULL;
+
+	if (chanpath == NULL)
+		return -EINVAL;
+
+	if (nbufs != 1) {
+		err = check_attribute_flags(&flags, resize_min ? 1 : 0);
+		if (err)
+			return err;
+	}
+
+	rchan = rchan_create(chanpath, bufsize, nbufs, flags, init_buf, init_buf_size, &err);
+
+	if (err < 0)
+		return err;
+
+	/* Create file in fs */
+	if ((err = rchan_create_file(chanpath, &dentry, rchan, mode)) < 0) {
+		rchan_destroy_buf(rchan);
+		rchan_free_id(rchan->id);
+		kfree(rchan);
+		return err;
+	}
+
+	rchan->dentry = dentry;
+
+	if (channel_callbacks == NULL)
+		callbacks = &default_channel_callbacks;
+	else
+		callbacks = channel_callbacks;
+
+	if (callbacks->buffer_end == NULL)
+		callbacks->buffer_end = buffer_end_default_callback;
+	if (callbacks->buffer_start == NULL)
+		callbacks->buffer_start = buffer_start_default_callback;
+	if (callbacks->deliver == NULL)
+		callbacks->deliver = deliver_default_callback;
+	if (callbacks->user_deliver == NULL)
+		callbacks->user_deliver = user_deliver_default_callback;
+	if (callbacks->needs_resize == NULL)
+		callbacks->needs_resize = needs_resize_default_callback;
+	if (callbacks->fileop_notify == NULL)
+		callbacks->fileop_notify = fileop_notify_default_callback;
+	if (callbacks->ioctl == NULL)
+		callbacks->ioctl = ioctl_default_callback;
+	rchan->callbacks = callbacks;
+
+	/* Just to let the client know the sizes used */
+	rchan->callbacks->needs_resize(rchan->id,
+				       RELAY_RESIZE_REPLACED,
+				       rchan->buf_size,
+				       rchan->n_bufs);
+
+	rchan->flags = flags;
+	rchan->start_reserve = start_reserve;
+	rchan->end_reserve = end_reserve;
+	rchan->rchan_start_reserve = rchan_start_reserve;
+
+	__relay_reset(rchan, 1);
+
+	if (resize_min > 0 && resize_max > 0 &&
+	   resize_max < RELAY_MAX_TOTAL_BUF_SIZE) {
+		rchan->resize_min = resize_min;
+		rchan->resize_max = resize_max;
+		init_shrink_timer(rchan);
+	}
+
+	rchan_get(rchan->id);
+
+	return rchan->id;
+}
+
+/**
+ *	relay_discard_init_buf - alloc channel buffer and copy init_buf into it
+ *	@rchan_id: the channel id
+ *
+ *	Returns 0 if successful, negative otherwise.
+ *
+ *	NOTE: May sleep.  Should also be called only when the channel isn't
+ *	actively being written into.
+ */
+int
+relay_discard_init_buf(int rchan_id)
+{
+	struct rchan *rchan;
+	int err = 0;
+	
+	rchan = rchan_get(rchan_id);
+	if (rchan == NULL)
+		return -EBADF;
+
+	if (rchan->init_buf == NULL) {
+		err = -EINVAL;
+		goto out;
+	}
+	
+	err = rchan_create_buf(rchan, rchan->alloc_size);
+	if (err)
+		goto out;
+	
+	memcpy(rchan->buf, rchan->init_buf, rchan->n_bufs * rchan->buf_size);
+	rchan->init_buf = NULL;
+out:
+	rchan_put(rchan);
+	
+	return err;
+}
+
+/**
+ *	relay_finalize - perform end-of-buffer processing for last buffer
+ *	@rchan_id: the channel id
+ *	@releasing: true if called when releasing file
+ *
+ *	Returns 0 if successful, negative otherwise.
+ */
+static int
+relay_finalize(int rchan_id)
+{
+	struct rchan *rchan = rchan_get(rchan_id);
+	if (rchan == NULL)
+		return -EBADF;
+
+	if (rchan->finalized == 0) {
+		rchan->relay_ops->finalize(rchan);
+		rchan->finalized = 1;
+	}
+
+	if (waitqueue_active(&rchan->read_wait)) {
+		PREPARE_WORK(&rchan->wake_readers, wakeup_readers, rchan);
+		schedule_delayed_work(&rchan->wake_readers, 1);
+	}
+
+	rchan_put(rchan);
+
+	return 0;
+}
+
+/**
+ *	restore_callbacks - restore default channel callbacks
+ *	@rchan: the channel
+ *
+ *	Restore callbacks to the default versions.
+ */
+static inline void
+restore_callbacks(struct rchan *rchan)
+{
+	if (rchan->callbacks != &default_channel_callbacks)
+		rchan->callbacks = &default_channel_callbacks;
+}
+
+/**
+ *	relay_close - close the channel
+ *	@rchan_id: relay channel id
+ *	
+ *	Finalizes the last sub-buffer and marks the channel as finalized.
+ *	The channel buffer and channel data structure are then freed
+ *	automatically when the last reference to the channel is given up.
+ */
+int
+relay_close(int rchan_id)
+{
+	int err;
+	struct rchan *rchan;
+
+	if ((rchan_id < 0) || (rchan_id >= RELAY_MAX_CHANNELS))
+		return -EBADF;
+
+	err = relay_finalize(rchan_id);
+
+	if (!err) {
+		read_lock(&rchan_table_lock);
+		rchan = rchan_table[rchan_id];
+		read_unlock(&rchan_table_lock);
+
+		if (rchan) {
+			restore_callbacks(rchan);
+			if (rchan->resize_min)
+				del_timer(&rchan->shrink_timer);
+			rchan_put(rchan);
+		}
+	}
+	
+	return err;
+}
+
+/**
+ *	relay_write - reserve a slot in the channel and write data into it
+ *	@rchan_id: relay channel id
+ *	@data_ptr: data to be written into reserved slot
+ *	@count: number of bytes to write
+ *	@td_offset: optional offset where time delta should be written
+ *	@wrote_pos: optional ptr returning buf pos written to, ignored if NULL
+ *
+ *	Returns the number of bytes written, 0 or negative on failure.
+ *
+ *	Reserves space in the channel and writes count bytes of data_ptr
+ *	to it.  Automatically performs any necessary locking, depending
+ *	on the scheme and SMP usage in effect (no locking is done for the
+ *	lockless scheme regardless of usage).
+ *
+ *	If td_offset is >= 0, the internal time delta calculated when
+ *	slot was reserved will be written at that offset.
+ *
+ *	If wrote_pos is non-NULL, it will receive the location the data
+ *	was written to, which may be needed for some applications but is not
+ *	normally interesting.
+ */
+int
+relay_write(int rchan_id,
+	    const void *data_ptr,
+	    size_t count,
+	    int td_offset,
+	    void **wrote_pos)
+{
+	unsigned long flags;
+	char *reserved, *write_pos;
+	int bytes_written = 0;
+	int reserve_code, interrupting;
+	struct timeval ts;
+	u32 td;
+	struct rchan *rchan;
+	
+	rchan = rchan_get(rchan_id);
+	if (rchan == NULL)
+		return -EBADF;
+
+	relay_lock_channel(rchan, flags); /* nop for lockless */
+
+	write_pos = reserved = relay_reserve(rchan, count, &ts, &td,
+					     &reserve_code, &interrupting);
+
+	if (reserved != NULL) {
+		relay_write_direct(write_pos, data_ptr, count);
+		if ((td_offset >= 0) && (td_offset < count - sizeof(td)))
+			*((u32 *)(reserved + td_offset)) = td;
+		bytes_written = count;
+	} else if (reserve_code == RELAY_WRITE_TOO_LONG)
+		bytes_written = -EINVAL;
+
+	if (bytes_written > 0)
+		relay_commit(rchan, reserved, bytes_written, reserve_code, interrupting);
+
+	relay_unlock_channel(rchan, flags); /* nop for lockless */
+
+	rchan_put(rchan);
+
+	if (wrote_pos)
+		*wrote_pos = reserved;
+	
+	return bytes_written;
+}
+
+/**
+ *	wakeup_writers - wake up VFS writers waiting on a channel
+ *	@private: the channel
+ *
+ *	This is the work function used to defer writer waking.  The
+ *	reason waking is deferred is that calling directly from
+ *	buffers_consumed causes problems if you're writing from say
+ *	the scheduler.
+ */
+static void
+wakeup_writers(void *private)
+{
+	struct rchan *rchan = (struct rchan *)private;
+	
+	wake_up_interruptible(&rchan->write_wait);
+}
+
+
+/**
+ *	__relay_buffers_consumed - internal version of relay_buffers_consumed
+ *	@rchan: the relay channel
+ *	@bufs_consumed: number of buffers to add to current count for channel
+ *	
+ *	Internal - updates the channel's consumed buffer count.
+ */
+static void
+__relay_buffers_consumed(struct rchan *rchan, u32 bufs_consumed)
+{
+	rchan->bufs_consumed += bufs_consumed;
+	
+	if (rchan->bufs_consumed > rchan->bufs_produced)
+		rchan->bufs_consumed = rchan->bufs_produced;
+	
+	atomic_set(&rchan->suspended, 0);
+
+	PREPARE_WORK(&rchan->wake_writers, wakeup_writers, rchan);
+	schedule_delayed_work(&rchan->wake_writers, 1);
+}
+
+/**
+ *	__reader_buffers_consumed - update reader/channel consumed buffer count
+ *	@reader: channel reader
+ *	@bufs_consumed: number of buffers to add to current count for channel
+ *	
+ *	Internal - updates the reader's consumed buffer count.  If the reader's
+ *	resulting total is greater than the channel's, update the channel's.
+*/
+static void
+__reader_buffers_consumed(struct rchan_reader *reader, u32 bufs_consumed)
+{
+	reader->bufs_consumed += bufs_consumed;
+	
+	if (reader->bufs_consumed > reader->rchan->bufs_consumed)
+		__relay_buffers_consumed(reader->rchan, bufs_consumed);
+}
+
+/**
+ *	relay_buffers_consumed - add to the # buffers consumed for the channel
+ *	@reader: channel reader
+ *	@bufs_consumed: number of buffers to add to current count for channel
+ *	
+ *	Adds to the channel's consumed buffer count.  buffers_consumed should
+ *	be the number of buffers newly consumed, not the total number consumed.
+ *
+ *	NOTE: kernel clients don't need to call this function if the reader
+ *	is auto-consuming or the channel is MODE_CONTINUOUS.
+ */
+void
+relay_buffers_consumed(struct rchan_reader *reader, u32 bufs_consumed)
+{
+	if (reader && reader->rchan)
+		__reader_buffers_consumed(reader, bufs_consumed);
+}
+
+/**
+ *	__relay_bytes_consumed - internal version of relay_bytes_consumed
+ *	@rchan: the relay channel
+ *	@bytes_consumed: number of bytes to add to current count for channel
+ *	@read_offset: where the bytes were consumed from
+ *	
+ *	Internal - updates the channel's consumed count.
+*/
+static void
+__relay_bytes_consumed(struct rchan *rchan, u32 bytes_consumed, u32 read_offset)
+{
+	u32 consuming_idx;
+	u32 unused;
+
+	consuming_idx = read_offset / rchan->buf_size;
+
+	if (consuming_idx >= rchan->n_bufs)
+		consuming_idx = rchan->n_bufs - 1;
+	rchan->bytes_consumed += bytes_consumed;
+
+	unused = rchan->unused_bytes[consuming_idx];
+	
+	if (rchan->bytes_consumed + unused >= rchan->buf_size) {
+		__relay_buffers_consumed(rchan, 1);
+		rchan->bytes_consumed = 0;
+	}
+}
+
+/**
+ *	__reader_bytes_consumed - update reader/channel consumed count
+ *	@reader: channel reader
+ *	@bytes_consumed: number of bytes to add to current count for channel
+ *	@read_offset: where the bytes were consumed from
+ *	
+ *	Internal - updates the reader's consumed count.  If the reader's
+ *	resulting total is greater than the channel's, update the channel's.
+*/
+static void
+__reader_bytes_consumed(struct rchan_reader *reader, u32 bytes_consumed, u32 read_offset)
+{
+	u32 consuming_idx;
+	u32 unused;
+
+	consuming_idx = read_offset / reader->rchan->buf_size;
+
+	if (consuming_idx >= reader->rchan->n_bufs)
+		consuming_idx = reader->rchan->n_bufs - 1;
+
+	reader->bytes_consumed += bytes_consumed;
+	
+	unused = reader->rchan->unused_bytes[consuming_idx];
+	
+	if (reader->bytes_consumed + unused >= reader->rchan->buf_size) {
+		reader->bufs_consumed++;
+		reader->bytes_consumed = 0;
+	}
+
+	if ((reader->bufs_consumed > reader->rchan->bufs_consumed) ||
+	    ((reader->bufs_consumed == reader->rchan->bufs_consumed) &&
+	     (reader->bytes_consumed > reader->rchan->bytes_consumed)))
+		__relay_bytes_consumed(reader->rchan, bytes_consumed, read_offset);
+}
+
+/**
+ *	relay_bytes_consumed - add to the # bytes consumed for the channel
+ *	@reader: channel reader
+ *	@bytes_consumed: number of bytes to add to current count for channel
+ *	@read_offset: where the bytes were consumed from
+ *	
+ *	Adds to the channel's consumed count.  bytes_consumed should be the
+ *	number of bytes actually read e.g. return value of relay_read() and
+ *	the read_offset should be the actual offset the bytes were read from
+ *	e.g. the actual_read_offset set by relay_read(). See
+ *	Documentation/filesystems/relayfs.txt for more details.
+ *
+ *	NOTE: kernel clients don't need to call this function if the reader
+ *	is auto-consuming or the channel is MODE_CONTINUOUS.
+ */
+void
+relay_bytes_consumed(struct rchan_reader *reader, u32 bytes_consumed, u32 read_offset)
+{
+	if (reader && reader->rchan)
+		__reader_bytes_consumed(reader, bytes_consumed, read_offset);
+}
+
+/**
+ *	update_readers_consumed - apply offset change to reader
+ *	@rchan: the channel
+ *
+ *	Apply the consumed counts to all readers open on the channel.
+ */
+void
+update_readers_consumed(struct rchan *rchan, u32 bufs_consumed, u32 bytes_consumed)
+{
+	struct list_head *p;
+	struct rchan_reader *reader;
+	
+	read_lock(&rchan->open_readers_lock);
+	list_for_each(p, &rchan->open_readers) {
+		reader = list_entry(p, struct rchan_reader, list);
+		reader->bufs_consumed = bufs_consumed;
+		reader->bytes_consumed = bytes_consumed;
+		if (reader->vfs_reader)
+			reader->pos.file->f_pos = 0;
+		else
+			reader->pos.f_pos = 0;
+		reader->offset_changed = 1;
+	}
+	read_unlock(&rchan->open_readers_lock);
+	rchan->read_start = 0;
+}
+
+/**
+ *	do_read - utility function to do the actual read to user
+ *	@rchan: the channel
+ *	@buf: user buf to read into, NULL if just getting info
+ *	@count: bytes requested
+ *	@read_offset: offset into channel
+ *	@new_offset: new offset into channel after read
+ *	@actual_read_offset: read offset actually used
+ *
+ *	Returns the number of bytes read, 0 if none.
+ */
+static ssize_t
+do_read(struct rchan *rchan, char *buf, size_t count, u32 read_offset, u32 *new_offset, u32 *actual_read_offset)
+{
+	u32 read_bufno, cur_bufno;
+	u32 avail_offset, cur_idx, max_offset, buf_end_offset;
+	u32 avail_count, buf_size;
+	int unused_bytes = 0;
+	size_t read_count = 0;
+	u32 last_buf_byte_offset;
+
+	*actual_read_offset = read_offset;
+	
+	buf_size = rchan->buf_size;
+	if (unlikely(!buf_size)) BUG();
+
+	read_bufno = read_offset / buf_size;
+	if (unlikely(read_bufno >= RELAY_MAX_BUFS)) BUG();
+	unused_bytes = rchan->unused_bytes[read_bufno];
+
+	avail_offset = cur_idx = relay_get_offset(rchan, &max_offset);
+
+	if (cur_idx == read_offset) {
+		if (atomic_read(&rchan->suspended) == 1) {
+			read_offset += 1;
+			if (read_offset >= max_offset)
+				read_offset = 0;
+			*actual_read_offset = read_offset;
+		} else {
+			*new_offset = read_offset;
+			return 0;
+		}
+	} else {
+		last_buf_byte_offset = (read_bufno + 1) * buf_size - 1;
+		if (read_offset == last_buf_byte_offset) {
+			if (unused_bytes != 1) {
+				read_offset += 1;
+				if (read_offset >= max_offset)
+					read_offset = 0;
+				*actual_read_offset = read_offset;
+			}
+		}
+	}
+
+	read_bufno = read_offset / buf_size;
+	if (unlikely(read_bufno >= RELAY_MAX_BUFS)) BUG();
+	unused_bytes = rchan->unused_bytes[read_bufno];
+
+	cur_bufno = cur_idx / buf_size;
+
+	buf_end_offset = (read_bufno + 1) * buf_size - unused_bytes;
+	if (avail_offset > buf_end_offset)
+		avail_offset = buf_end_offset;
+	else if (avail_offset < read_offset)
+		avail_offset = buf_end_offset;
+	avail_count = avail_offset - read_offset;
+	read_count = avail_count >= count ? count : avail_count;
+
+	if (read_count && buf != NULL)
+		if (copy_to_user(buf, rchan->buf + read_offset, read_count))
+			return -EFAULT;
+
+	if (read_bufno == cur_bufno)
+		if (read_count && (read_offset + read_count >= buf_end_offset) && (read_offset + read_count <= cur_idx)) {
+			*new_offset = cur_idx;
+			return read_count;
+		}
+
+	if (read_offset + read_count + unused_bytes > max_offset)
+		*new_offset = 0;
+	else if (read_offset + read_count >= buf_end_offset)
+		*new_offset = read_offset + read_count + unused_bytes;
+	else
+		*new_offset = read_offset + read_count;
+
+	return read_count;
+}
+
+/**
+ *	__relay_read - read bytes from channel, relative to current reader pos
+ *	@reader: channel reader
+ *	@buf: user buf to read into, NULL if just getting info
+ *	@count: bytes requested
+ *	@read_offset: offset into channel
+ *	@new_offset: new offset into channel after read
+ *	@actual_read_offset: read offset actually used
+ *	@wait: if non-zero, wait for something to read
+ *
+ *	Internal - see relay_read() for details.
+ *
+ *	Returns the number of bytes read, 0 if none, negative on failure.
+ */
+static ssize_t
+__relay_read(struct rchan_reader *reader, char *buf, size_t count, u32 read_offset, u32 *new_offset, u32 *actual_read_offset, int wait)
+{
+	int err = 0;
+	size_t read_count = 0;
+	struct rchan *rchan = reader->rchan;
+
+	if (!wait && !rchan->initialized)
+		return -EAGAIN;
+
+	if (using_lockless(rchan))
+		read_offset &= idx_mask(rchan);
+
+	if (read_offset >= rchan->n_bufs * rchan->buf_size) {
+		*new_offset = 0;
+		if (!wait)
+			return -EAGAIN;
+		else
+			return -EINTR;
+	}
+	
+	if (buf != NULL && wait) {
+		err = wait_event_interruptible(rchan->read_wait,
+		       ((rchan->finalized == 1) ||
+			(atomic_read(&rchan->suspended) == 1) ||
+			(relay_get_offset(rchan, NULL) != read_offset)));
+
+		if (rchan->finalized)
+			return 0;
+
+		if (reader->offset_changed) {
+			reader->offset_changed = 0;
+			return -EINTR;
+		}
+		
+		if (err)
+			return err;
+	}
+
+	read_count = do_read(rchan, buf, count, read_offset, new_offset, actual_read_offset);
+
+	if (read_count < 0)
+		err = read_count;
+	
+	if (err)
+		return err;
+	else
+		return read_count;
+}
+
+/**
+ *	relay_read - read bytes from channel, relative to current reader pos
+ *	@reader: channel reader
+ *	@buf: user buf to read into, NULL if just getting info
+ *	@count: bytes requested
+ *	@wait: if non-zero, wait for something to read
+ *	@actual_read_offset: set read offset actually used, must not be NULL
+ *
+ *	Reads count bytes from the channel, or as much as is available within
+ *	the sub-buffer currently being read.  The read offset that will be
+ *	read from is the position contained within the reader object.  If the
+ *	wait flag is set, buf is non-NULL, and there is nothing available,
+ *	it will wait until there is.  If the wait flag is 0 and there is
+ *	nothing available, -EAGAIN is returned.  If buf is NULL, the value
+ *	returned is the number of bytes that would have been read.
+ *	actual_read_offset is the value that should be passed as the read
+ *	offset to relay_bytes_consumed, needed only if the reader is not
+ *	auto-consuming and the channel is MODE_NO_OVERWRITE, but in any case,
+ *	it must not be NULL.  See Documentation/filesystems/relayfs.txt for
+ *	more details.
+ */
+ssize_t
+relay_read(struct rchan_reader *reader, char *buf, size_t count, int wait, u32 *actual_read_offset, u32 *new_offset)
+{
+	u32 read_offset;
+	ssize_t read_count;
+	
+	if (reader == NULL || reader->rchan == NULL)
+		return -EBADF;
+
+	if (actual_read_offset == NULL)
+		return -EINVAL;
+
+	if (reader->vfs_reader)
+		read_offset = (u32)(reader->pos.file->f_pos);
+	else
+		read_offset = reader->pos.f_pos;
+	*actual_read_offset = read_offset;
+	
+	read_count = __relay_read(reader, buf, count, read_offset,
+				  new_offset, actual_read_offset, wait);
+
+	if (read_count < 0)
+		return read_count;
+
+	if (reader->vfs_reader) {
+		down(&reader->rchan->resize_sem);
+		if (!(reader->rchan->flags & RELAY_MODE_START_AT_ZERO))
+			reader->rchan->read_start = *new_offset;
+		up(&reader->rchan->resize_sem);
+	} else
+		reader->pos.f_pos = *new_offset;
+
+	if (reader->auto_consume && ((read_count) || (*new_offset != read_offset)))
+		__reader_bytes_consumed(reader, read_count, *actual_read_offset);
+
+	if (read_count == 0 && !wait)
+		return -EAGAIN;
+	
+	return read_count;
+}
+
+/**
+ *	relay_bytes_avail - number of bytes available in current sub-buffer
+ *	@reader: channel reader
+ *	
+ *	Returns the number of bytes available relative to the reader's
+ *	current read position within the corresponding sub-buffer, 0 if
+ *	there is nothing available.  See Documentation/filesystems/relayfs.txt
+ *	for more details.
+ */
+ssize_t
+relay_bytes_avail(struct rchan_reader *reader)
+{
+	u32 f_pos;
+	u32 new_offset;
+	u32 actual_read_offset;
+	ssize_t bytes_read;
+	
+	if (reader == NULL || reader->rchan == NULL)
+		return -EBADF;
+	
+	if (reader->vfs_reader)
+		f_pos = (u32)reader->pos.file->f_pos;
+	else
+		f_pos = reader->pos.f_pos;
+	new_offset = f_pos;
+
+	bytes_read = __relay_read(reader, NULL, reader->rchan->buf_size,
+				  f_pos, &new_offset, &actual_read_offset, 0);
+
+	if ((new_offset != f_pos) &&
+	    ((bytes_read == -EINTR) || (bytes_read == 0)))
+		bytes_read = -EAGAIN;
+	else if ((bytes_read < 0) && (bytes_read != -EAGAIN))
+		bytes_read = 0;
+
+	return bytes_read;
+}
+
+/**
+ *	rchan_empty - boolean, is the channel empty wrt reader?
+ *	@reader: channel reader
+ *	
+ *	Returns 1 if the channel is empty, 0 otherwise.
+ */
+int
+rchan_empty(struct rchan_reader *reader)
+{
+	ssize_t avail_count;
+	u32 buffers_ready;
+	struct rchan *rchan = reader->rchan;
+	u32 cur_idx, curbuf_bytes;
+	int mapped;
+
+	if (atomic_read(&rchan->suspended) == 1)
+		return 0;
+
+	mapped = atomic_read(&rchan->mapped);
+	
+	if (mapped && bulk_delivery(rchan)) {
+		buffers_ready = rchan->bufs_produced - rchan->bufs_consumed;
+		return buffers_ready ? 0 : 1;
+	}
+
+	if (mapped && packet_delivery(rchan)) {
+		buffers_ready = rchan->bufs_produced - rchan->bufs_consumed;
+		if (buffers_ready)
+			return 0;
+		else {
+			cur_idx = relay_get_offset(rchan, NULL);
+			curbuf_bytes = cur_idx % rchan->buf_size;
+			return curbuf_bytes == rchan->bytes_consumed ? 1 : 0;
+		}
+	}
+
+	avail_count = relay_bytes_avail(reader);
+
+	return avail_count ? 0 : 1;
+}
+
+/**
+ *	rchan_full - boolean, is the channel full wrt consuming reader?
+ *	@reader: channel reader
+ *	
+ *	Returns 1 if the channel is full, 0 otherwise.
+ */
+int
+rchan_full(struct rchan_reader *reader)
+{
+	u32 buffers_ready;
+	struct rchan *rchan = reader->rchan;
+
+	if (mode_continuous(rchan))
+		return 0;
+
+	buffers_ready = rchan->bufs_produced - rchan->bufs_consumed;
+
+	return buffers_ready > reader->rchan->n_bufs - 1 ? 1 : 0;
+}
+
+/**
+ *	relay_info - get status and other information about a relay channel
+ *	@rchan_id: relay channel id
+ *	@rchan_info: pointer to the rchan_info struct to be filled in
+ *	
+ *	Fills in an rchan_info struct with channel status and attribute
+ *	information.  See Documentation/filesystems/relayfs.txt for details.
+ *
+ *	Returns 0 if successful, negative otherwise.
+ */
+int
+relay_info(int rchan_id, struct rchan_info *rchan_info)
+{
+	int i;
+	struct rchan *rchan;
+
+	rchan = rchan_get(rchan_id);
+	if (rchan == NULL)
+		return -EBADF;
+
+	rchan_info->flags = rchan->flags;
+	rchan_info->buf_size = rchan->buf_size;
+	rchan_info->buf_addr = rchan->buf;
+	rchan_info->alloc_size = rchan->alloc_size;
+	rchan_info->n_bufs = rchan->n_bufs;
+	rchan_info->cur_idx = relay_get_offset(rchan, NULL);
+	rchan_info->bufs_produced = rchan->bufs_produced;
+	rchan_info->bufs_consumed = rchan->bufs_consumed;
+	rchan_info->buf_id = rchan->buf_id;
+
+	for (i = 0; i < rchan->n_bufs; i++) {
+		rchan_info->unused_bytes[i] = rchan->unused_bytes[i];
+		if (using_lockless(rchan))
+			rchan_info->buffer_complete[i] = (atomic_read(&fill_count(rchan, i)) == rchan->buf_size);
+		else
+			rchan_info->buffer_complete[i] = 0;
+	}
+
+	rchan_put(rchan);
+
+	return 0;
+}
+
+/**
+ *	__add_rchan_reader - creates and adds a reader to a channel
+ *	@rchan: relay channel
+ *	@filp: the file associated with rchan, if applicable
+ *	@auto_consume: boolean, whether reader's reads automatically consume
+ *	@map_reader: boolean, whether reader's reading via a channel mapping
+ *
+ *	Returns a pointer to the reader object create, NULL if unsuccessful
+ *
+ *	Creates and initializes an rchan_reader object for reading the channel.
+ *	If filp is non-NULL, the reader is a VFS reader, otherwise not.
+ *
+ *	If the reader is a map reader, it isn't considered a VFS reader for
+ *	our purposes.  Also, map_readers can't be auto-consuming.
+ */
+struct rchan_reader *
+__add_rchan_reader(struct rchan *rchan, struct file *filp, int auto_consume, int map_reader)
+{
+	struct rchan_reader *reader;
+	u32 will_read;
+	
+	reader = kmalloc(sizeof(struct rchan_reader), GFP_KERNEL);
+
+	if (reader) {
+		reader->rchan = rchan;
+		if (filp) {
+			reader->vfs_reader = 1;
+			down(&rchan->resize_sem);
+			filp->f_pos = rchan->read_start;
+			up(&rchan->resize_sem);
+			reader->pos.file = filp;
+		} else {
+			reader->vfs_reader = 0;
+			reader->pos.f_pos = 0;
+		}
+		reader->map_reader = map_reader;
+		reader->auto_consume = auto_consume;
+
+		if (!map_reader) {
+			will_read = rchan->bufs_produced % rchan->n_bufs;
+			if (!will_read && atomic_read(&rchan->suspended))
+				will_read = rchan->n_bufs;
+			reader->bufs_consumed = rchan->bufs_produced - will_read;
+			rchan->bufs_consumed = reader->bufs_consumed;
+			rchan->bytes_consumed = reader->bytes_consumed = 0;
+			reader->offset_changed = 0;
+		}
+		
+		write_lock(&rchan->open_readers_lock);
+		list_add(&reader->list, &rchan->open_readers);
+		write_unlock(&rchan->open_readers_lock);
+	}
+
+	return reader;
+}
+
+/**
+ *	add_rchan_reader - create a reader for a channel
+ *	@rchan_id: relay channel handle
+ *	@auto_consume: boolean, whether reader's reads automatically consume
+ *
+ *	Returns a pointer to the reader object created, NULL if unsuccessful
+ *
+ *	Creates and initializes an rchan_reader object for reading the channel.
+ *	This function is useful only for non-VFS readers.
+ */
+struct rchan_reader *
+add_rchan_reader(int rchan_id, int auto_consume)
+{
+	struct rchan *rchan = rchan_get(rchan_id);
+	if (rchan == NULL)
+		return NULL;
+
+	return __add_rchan_reader(rchan, NULL, auto_consume, 0);
+}
+
+/**
+ *	add_map_reader - create a map reader for a channel
+ *	@rchan_id: relay channel handle
+ *
+ *	Returns a pointer to the reader object created, NULL if unsuccessful
+ *
+ *	Creates and initializes an rchan_reader object for reading the channel.
+ *	This function is useful only for map readers.
+ */
+struct rchan_reader *
+add_map_reader(int rchan_id)
+{
+	struct rchan *rchan = rchan_get(rchan_id);
+	if (rchan == NULL)
+		return NULL;
+
+	return __add_rchan_reader(rchan, NULL, 0, 1);
+}
+
+/**
+ *	__remove_rchan_reader - destroy a channel reader
+ *	@reader: channel reader
+ *
+ *	Internal - removes reader from the open readers list, and frees it.
+ */
+void
+__remove_rchan_reader(struct rchan_reader *reader)
+{
+	struct list_head *p;
+	struct rchan_reader *found_reader = NULL;
+	
+	write_lock(&reader->rchan->open_readers_lock);
+	list_for_each(p, &reader->rchan->open_readers) {
+		found_reader = list_entry(p, struct rchan_reader, list);
+		if (found_reader == reader) {
+			list_del(&found_reader->list);
+			break;
+		}
+	}
+	write_unlock(&reader->rchan->open_readers_lock);
+
+	if (found_reader)
+		kfree(found_reader);
+}
+
+/**
+ *	remove_rchan_reader - destroy a channel reader
+ *	@reader: channel reader
+ *
+ *	Finds and removes the given reader from the channel.  This function
+ *	is useful only for non-VFS readers.
+ *
+ *	Returns 0 if successful, negative otherwise.
+ */
+int
+remove_rchan_reader(struct rchan_reader *reader)
+{
+	int err = 0;
+	
+	if (reader) {
+		rchan_put(reader->rchan);
+		__remove_rchan_reader(reader);
+	} else
+		err = -EINVAL;
+
+	return err;
+}
+
+/**
+ *	remove_map_reader - destroy a map reader
+ *	@reader: channel reader
+ *
+ *	Finds and removes the given map reader from the channel.  This function
+ *	is useful only for map readers.
+ *
+ *	Returns 0 if successful, negative otherwise.
+ */
+int
+remove_map_reader(struct rchan_reader *reader)
+{
+	return remove_rchan_reader(reader);
+}
+
+EXPORT_SYMBOL(relay_open);
+EXPORT_SYMBOL(relay_close);
+EXPORT_SYMBOL(relay_reset);
+EXPORT_SYMBOL(relay_reserve);
+EXPORT_SYMBOL(relay_commit);
+EXPORT_SYMBOL(relay_read);
+EXPORT_SYMBOL(relay_write);
+EXPORT_SYMBOL(relay_bytes_avail);
+EXPORT_SYMBOL(relay_buffers_consumed);
+EXPORT_SYMBOL(relay_bytes_consumed);
+EXPORT_SYMBOL(relay_info);
+EXPORT_SYMBOL(relay_discard_init_buf);
+EXPORT_SYMBOL(add_rchan_reader);
+EXPORT_SYMBOL(remove_rchan_reader);
+EXPORT_SYMBOL(add_map_reader);
+EXPORT_SYMBOL(remove_map_reader);
+EXPORT_SYMBOL(rchan_empty);
+EXPORT_SYMBOL(rchan_full);
+
+
