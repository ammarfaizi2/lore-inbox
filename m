Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262893AbTJGVEq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 17:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262907AbTJGVEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 17:04:45 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:5862 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262893AbTJGVAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 17:00:40 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16259.10573.604292.689170@gargle.gargle.HOWL>
Date: Tue, 7 Oct 2003 15:59:57 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] relayfs (3/4) (VFS and scheme-specific code)
X-Mailer: VM(ViewMail) 7.01 under Emacs 20.7.2
Cc: karim@opersys.com, bob@watson.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN -X dontdiff linux-2.6.0-test6/fs/Kconfig linux-2.6.0-test6.cur/fs/Kconfig
--- linux-2.6.0-test6/fs/Kconfig	Sat Sep 27 19:50:29 2003
+++ linux-2.6.0-test6.cur/fs/Kconfig	Tue Oct  7 11:56:19 2003
@@ -892,6 +892,26 @@ config RAMFS
 	  To compile this as a module, choose M here: the module will be called
 	  ramfs.
 
+config RELAYFS_FS
+	tristate "Relayfs file system support"
+	---help---
+	  Relayfs is a high-speed data relay filesystem designed to provide
+	  an efficient mechanism for tools and facilities to relay large
+	  amounts of data from kernel space to user space.  It's not useful
+	  on its own, and should only be enabled if other facilities that
+	  need it are enabled, such as for example dynamic printk or the
+	  Linux Trace Toolkit.
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
 endmenu
 
 menu "Miscellaneous filesystems"
diff -urpN -X dontdiff linux-2.6.0-test6/fs/Makefile linux-2.6.0-test6.cur/fs/Makefile
--- linux-2.6.0-test6/fs/Makefile	Sat Sep 27 19:50:29 2003
+++ linux-2.6.0-test6.cur/fs/Makefile	Tue Oct  7 11:54:47 2003
@@ -51,6 +51,7 @@ obj-$(CONFIG_EXT2_FS)		+= ext2/
 obj-$(CONFIG_CRAMFS)		+= cramfs/
 obj-$(CONFIG_RAMFS)		+= ramfs/
 obj-$(CONFIG_HUGETLBFS)		+= hugetlbfs/
+obj-$(CONFIG_RELAYFS_FS)	+= relayfs/
 obj-$(CONFIG_CODA_FS)		+= coda/
 obj-$(CONFIG_INTERMEZZO_FS)	+= intermezzo/
 obj-$(CONFIG_MINIX_FS)		+= minix/
diff -urpN -X dontdiff linux-2.6.0-test6/fs/relayfs/Makefile linux-2.6.0-test6.cur/fs/relayfs/Makefile
--- linux-2.6.0-test6/fs/relayfs/Makefile	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test6.cur/fs/relayfs/Makefile	Tue Oct  7 11:52:47 2003
@@ -0,0 +1,7 @@
+#
+# relayfs Makefile
+#
+
+obj-$(CONFIG_RELAYFS_FS) += relayfs.o
+
+relayfs-objs := relay.o relay_lockless.o relay_locking.o inode.o
diff -urpN -X dontdiff linux-2.6.0-test6/fs/relayfs/inode.c linux-2.6.0-test6.cur/fs/relayfs/inode.c
--- linux-2.6.0-test6/fs/relayfs/inode.c	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test6.cur/fs/relayfs/inode.c	Tue Oct  7 11:52:47 2003
@@ -0,0 +1,572 @@
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
+	struct inode * inode = new_inode(sb);
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
+
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
+
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
+				    S_IRUSR | S_IWUSR, data);
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
+ *	channel refcount.  If the file is opened O_EXCL, reads
+ *	will be 'auto-consuming'.
+ */
+int
+relayfs_open(struct inode *inode, struct file *filp)
+{
+	struct rchan *rchan;
+	struct rchan_reader *reader;
+	int auto_consume = 0;
+
+	if (inode->u.generic_ip) {
+		if(filp->f_flags & O_EXCL)
+			auto_consume = 1;
+		rchan = (struct rchan *)inode->u.generic_ip;
+		reader = __add_rchan_reader(rchan, filp, auto_consume);
+		if (reader == NULL)
+			return -ENOMEM;
+		filp->private_data = reader;
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
+	struct rchan *rchan;
+	
+	rchan = ((struct rchan_reader *)filp->private_data)->rchan;
+
+	return relay_mmap_buffer(rchan->id, vma);
+}
+
+extern void __relay_bytes_consumed(struct rchan *rchan,
+				   u32 bytes_consumed,
+				   u32 read_offset);
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
+	size_t read_count;
+	struct rchan_reader *reader;
+
+	if (offset != &filp->f_pos) /* pread, seeking not supported */
+		return -ESPIPE;
+
+	if (count == 0)
+		return 0;
+
+	reader = (struct rchan_reader *)filp->private_data;
+	read_count = relay_read(reader, buf, count,
+			filp->f_flags & (O_NDELAY | O_NONBLOCK) ? 0 : 1);
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
+	int write_count;
+	char * write_buf;
+	struct rchan *rchan;
+	int err = 0;
+
+	if (offset != &filp->f_pos) /* pwrite, not supported */
+		return -ESPIPE;
+
+	if (count == 0)
+		return 0;
+
+	rchan = ((struct rchan_reader *)filp->private_data)->rchan;
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
+		write_count = relay_write(rchan->id, write_buf, count, -1);
+		if (write_count == 0)
+			return -EAGAIN;
+	} else {
+		err = wait_event_interruptible(rchan->write_wait,
+	         (write_count = relay_write(rchan->id, write_buf, count, -1)));
+		if (err)
+			return err;
+	}
+	
+	if (write_count > 0)
+		*offset += write_count;
+			
+	free_pages((unsigned long)write_buf, 1);
+	
+	return write_count;
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
+	int err = 0;
+	
+	reader = (struct rchan_reader *)filp->private_data;
+
+	/* The channel is no longer in use as far as this file is concerned */
+	rchan_put(reader->rchan);
+	__remove_rchan_reader(reader);
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
+	return register_filesystem(&relayfs_fs_type);
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
diff -urpN -X dontdiff linux-2.6.0-test6/fs/relayfs/relay_locking.c linux-2.6.0-test6.cur/fs/relayfs/relay_locking.c
--- linux-2.6.0-test6/fs/relayfs/relay_locking.c	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test6.cur/fs/relayfs/relay_locking.c	Tue Oct  7 11:52:47 2003
@@ -0,0 +1,248 @@
+/*
+ * RelayFS locking scheme implementation.
+ *
+ * Copyright (C) 1999, 2000, 2001, 2002 - Karim Yaghmour (karim@opersys.com)
+ * Copyright (C) 2002, 2003 - Tom Zanussi (zanussi@us.ibm.com), IBM Corp
+ *
+ * This file is released under the GPL.
+ */
+
+#include <asm/relay.h>
+#include "relay_locking.h"
+
+/**
+ *	switch_buffers - switches between read and write buffers.
+ *	@cur_time: current time.
+ *	@cur_tsc: the TSC associated with current_time, if applicable
+ *	@rchan: the channel
+ *	@finalizing: if true, don't start a new buffer 
+ *
+ *	This should be called from with interrupts disabled.
+ */
+static void 
+switch_buffers(struct timeval cur_time,
+	       u32 cur_tsc,
+	       struct rchan *rchan,
+	       int finalizing)
+{
+	char *chan_buf_end;
+	
+	int bytes_written;
+	
+	bytes_written = rchan->callbacks->buffer_end(rchan->id,
+			     cur_write_pos(rchan), write_buf_end(rchan),
+			     cur_time, cur_tsc, using_tsc(rchan));
+	if (bytes_written == 0)
+		rchan->unused_bytes[rchan->buf_idx % rchan->n_bufs] = 
+			write_buf_end(rchan) - cur_write_pos(rchan);
+
+	chan_buf_end = rchan->buf + rchan->n_bufs * rchan->buf_size;
+	if(write_buf(rchan) + rchan->buf_size >= chan_buf_end)
+		write_buf(rchan) = rchan->buf;
+	else
+		write_buf(rchan) += rchan->buf_size;
+	write_buf_end(rchan) = write_buf(rchan) + rchan->buf_size;
+	write_limit(rchan) = write_buf_end(rchan) - rchan->end_reserve;
+	cur_write_pos(rchan) = write_buf(rchan);
+
+	rchan->buf_start_time = cur_time;
+	rchan->buf_start_tsc = cur_tsc;
+
+	rchan->buf_idx++;
+	rchan->buf_id++;
+	if (!packet_delivery(rchan))
+		rchan->unused_bytes[rchan->buf_idx % rchan->n_bufs] = 0;
+	rchan->bufs_produced++;
+
+	if (!finalizing) {
+		bytes_written = rchan->callbacks->buffer_start(rchan->id, cur_write_pos(rchan), rchan->buf_id, cur_time, cur_tsc, using_tsc(rchan));
+		cur_write_pos(rchan) += bytes_written;
+	}
+}
+
+/**
+ *	locking_reserve - reserve a slot in the trace buffer for an event.
+ *	@rchan: the channel
+ *	@slot_len: the length of the slot to reserve
+ *	@ts: variable that will receive the time the slot was reserved
+ *	@tsc: the timestamp counter associated with time
+ *	@err: receives the result flags
+ *	@interrupting: if this write is interrupting another, set to non-zero 
+ *
+ *	Returns pointer to the beginning of the reserved slot, NULL if error.
+ *
+ *	The err value contains the result flags and is an ORed combination 
+ *	of the following:
+ *
+ *	RELAY_BUFFER_SWITCH_NONE - no buffer switch occurred
+ *	RELAY_EVENT_DISCARD_NONE - event should not be discarded
+ *	RELAY_BUFFER_SWITCH - buffer switch occurred
+ *	RELAY_EVENT_DISCARD - event should be discarded (all buffers are full)
+ *	RELAY_EVENT_TOO_LONG - event won't fit into even an empty buffer
+ */
+inline char *
+locking_reserve(struct rchan *rchan,
+		u32 slot_len,
+		struct timeval *ts,
+		u32 *tsc,
+		int *err,
+		int *interrupting)
+{
+	u32 buffers_ready;
+	int bytes_written;
+
+	*err = RELAY_BUFFER_SWITCH_NONE;
+
+	if (slot_len >= rchan->buf_size) {
+		*err = RELAY_WRITE_DISCARD | RELAY_WRITE_TOO_LONG;
+		return NULL;
+	}
+
+	if (rchan->initialized == 0) {
+		rchan->initialized = 1;
+		get_timestamp(&rchan->buf_start_time, 
+			      &rchan->buf_start_tsc, rchan);
+		rchan->unused_bytes[0] = 0;
+		bytes_written = rchan->callbacks->buffer_start(
+			rchan->id, cur_write_pos(rchan), 
+			rchan->buf_id, rchan->buf_start_time, 
+			rchan->buf_start_tsc, using_tsc(rchan));
+		cur_write_pos(rchan) += bytes_written;
+		*tsc = get_time_delta(ts, rchan);
+		return cur_write_pos(rchan);
+	}
+
+	*tsc = get_time_delta(ts, rchan);
+
+	if (in_progress_event_size(rchan)) {
+		interrupted_pos(rchan) = cur_write_pos(rchan);
+		cur_write_pos(rchan) = in_progress_event_pos(rchan) 
+			+ in_progress_event_size(rchan) 
+			+ interrupting_size(rchan);
+		*interrupting = 1;
+	} else {
+		in_progress_event_pos(rchan) = cur_write_pos(rchan);
+		in_progress_event_size(rchan) = slot_len;
+		interrupting_size(rchan) = 0;
+	}
+
+	if (cur_write_pos(rchan) + slot_len > write_limit(rchan)) {
+		if (atomic_read(&rchan->suspended) == 1) {
+			*err = RELAY_WRITE_DISCARD;
+			return NULL;
+		}
+
+		buffers_ready = rchan->bufs_produced - rchan->bufs_consumed;
+		if (buffers_ready == rchan->n_bufs - 1) {
+			if (!mode_continuous(rchan)) {
+				atomic_set(&rchan->suspended, 1);
+				*err = RELAY_WRITE_DISCARD;
+				return NULL;
+			}
+		}
+
+		get_timestamp(ts, tsc, rchan);
+		switch_buffers(*ts, *tsc, rchan, 0);
+		recalc_time_delta(ts, tsc, rchan);
+		*err = RELAY_BUFFER_SWITCH;
+	}
+
+	return cur_write_pos(rchan);
+}
+
+/**
+ *	locking_commit - commit a reserved slot in the buffer
+ *	@rchan: the channel
+ *	@from: commit the length starting here
+ *	@len: length committed
+ *	@deliver: length committed
+ *	@interrupting: not used
+ *
+ *      Commits len bytes and calls deliver callback if applicable.
+ */
+inline void
+locking_commit(struct rchan *rchan,
+	       char *from,
+	       u32 len, 
+	       int deliver, 
+	       int interrupting)
+{
+	cur_write_pos(rchan) += len;
+	
+	if (interrupting) {
+		cur_write_pos(rchan) = interrupted_pos(rchan);
+		interrupting_size(rchan) += len;
+	} else {
+		in_progress_event_size(rchan) = 0;
+		if (interrupting_size(rchan)) {
+			cur_write_pos(rchan) += interrupting_size(rchan);
+			interrupting_size(rchan) = 0;
+		}
+	}
+
+	if (deliver) {
+		rchan->callbacks->deliver(rchan->id, from, len);
+		resize_check(rchan);
+	}
+}
+
+/**
+ *	locking_finalize: - finalize last buffer at end of channel use
+ *	@rchan: the channel
+ */
+inline void 
+locking_finalize(struct rchan *rchan)
+{
+	unsigned long int flags;
+	struct timeval time;
+	u32 tsc;
+
+	local_irq_save(flags);
+	get_timestamp(&time, &tsc, rchan);
+	switch_buffers(time, tsc, rchan, 1);
+	local_irq_restore(flags);
+}
+
+/**
+ *	locking_get_offset - get current and max 'file' offsets for VFS
+ *	@rchan: the channel
+ *	@max_offset: maximum channel offset
+ *
+ *	Returns the current and maximum buffer offsets in VFS terms.
+ */
+u32 
+locking_get_offset(struct rchan *rchan,
+		   u32 *max_offset)
+{
+	if (max_offset)
+		*max_offset = rchan->buf_size * rchan->n_bufs - 1;
+
+	return cur_write_pos(rchan) - rchan->buf;
+}
+
+/**
+ *	locking_reset - reset the channel
+ *	@rchan: the channel
+ *	@init: 1 if this is a first-time channel initialization
+ */
+void locking_reset(struct rchan *rchan, int init)
+{
+	if (init)
+		channel_lock(rchan) = SPIN_LOCK_UNLOCKED;
+	write_buf(rchan) = rchan->buf;
+	write_buf_end(rchan) = write_buf(rchan) + rchan->buf_size;
+	cur_write_pos(rchan) = write_buf(rchan);
+	write_limit(rchan) = write_buf_end(rchan) - rchan->end_reserve;
+	in_progress_event_pos(rchan) = NULL;
+	in_progress_event_size(rchan) = 0;
+	interrupted_pos(rchan) = NULL;
+	interrupting_size(rchan) = 0;
+}
+
+
+
+
+
+
+
+
diff -urpN -X dontdiff linux-2.6.0-test6/fs/relayfs/relay_locking.h linux-2.6.0-test6.cur/fs/relayfs/relay_locking.h
--- linux-2.6.0-test6/fs/relayfs/relay_locking.h	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test6.cur/fs/relayfs/relay_locking.h	Tue Oct  7 11:52:47 2003
@@ -0,0 +1,32 @@
+#ifndef _RELAY_LOCKING_H
+#define _RELAY_LOCKING_H
+
+extern char *
+locking_reserve(struct rchan *rchan,
+		u32 slot_len, 
+		struct timeval *time_stamp,
+		u32 *tsc,
+		int *err,
+		int *interrupting);
+
+extern void 
+locking_commit(struct rchan *rchan,
+	       char *from,
+	       u32 len, 
+	       int deliver, 
+	       int interrupting);
+
+extern void 
+locking_resume(struct rchan *rchan);
+
+extern void 
+locking_finalize(struct rchan *rchan);
+
+extern u32 
+locking_get_offset(struct rchan *rchan, u32 *max_offset);
+
+extern void 
+locking_reset(struct rchan *rchan,
+	      int init);
+
+#endif	/* _RELAY_LOCKING_H */
diff -urpN -X dontdiff linux-2.6.0-test6/fs/relayfs/relay_lockless.c linux-2.6.0-test6.cur/fs/relayfs/relay_lockless.c
--- linux-2.6.0-test6/fs/relayfs/relay_lockless.c	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test6.cur/fs/relayfs/relay_lockless.c	Tue Oct  7 11:52:47 2003
@@ -0,0 +1,499 @@
+/*
+ * RelayFS lockless scheme implementation.
+ *
+ * Copyright (C) 1999, 2000, 2001, 2002 - Karim Yaghmour (karim@opersys.com)
+ * Copyright (C) 2002, 2003 - Tom Zanussi (zanussi@us.ibm.com), IBM Corp
+ * Copyright (C) 2002, 2003 - Bob Wisniewski (bob@watson.ibm.com), IBM Corp
+ *
+ * This file is released under the GPL.
+ */
+
+#include <asm/relay.h>
+#include "relay_lockless.h"
+
+/**
+ *	compare_and_store_volatile - self-explicit
+ *	@ptr: ptr to the word that will receive the new value
+ *	@oval: the value we think is currently in *ptr
+ *	@nval: the value *ptr will get if we were right
+ */
+inline int 
+compare_and_store_volatile(volatile u32 *ptr, 
+			   u32 oval,
+			   u32 nval)
+{
+	u32 prev;
+
+	barrier();
+	prev = cmpxchg(ptr, oval, nval);
+	barrier();
+
+	return (prev == oval);
+}
+
+/**
+ *	atomic_set_volatile - atomically set the value in ptr to nval.
+ *	@ptr: ptr to the word that will receive the new value
+ *	@nval: the new value
+ */
+inline void 
+atomic_set_volatile(atomic_t *ptr,
+		    u32 nval)
+{
+	barrier();
+	atomic_set(ptr, (int)nval);
+	barrier();
+}
+
+/**
+ *	atomic_add_volatile - atomically add val to the value at ptr.
+ *	@ptr: ptr to the word that will receive the addition
+ *	@val: the value to add to *ptr
+ */
+inline void 
+atomic_add_volatile(atomic_t *ptr, u32 val)
+{
+	barrier();
+	atomic_add((int)val, ptr);
+	barrier();
+}
+
+/**
+ *	atomic_sub_volatile - atomically substract val from the value at ptr.
+ *	@ptr: ptr to the word that will receive the subtraction
+ *	@val: the value to subtract from *ptr
+ */
+inline void 
+atomic_sub_volatile(atomic_t *ptr, s32 val)
+{
+	barrier();
+	atomic_sub((int)val, ptr);
+	barrier();
+}
+
+/**
+ *	lockless_commit - commit a reserved slot in the buffer
+ *	@rchan: the channel
+ *	@from: commit the length starting here
+ *	@len: length committed
+ *	@deliver: length committed
+ *	@interrupting: not used
+ *
+ *      Commits len bytes and calls deliver callback if applicable.
+ */
+inline void 
+lockless_commit(struct rchan *rchan,
+		char *from,
+		u32 len, 
+		int deliver, 
+		int interrupting)
+{
+	u32 bufno, idx;
+	
+	idx = from - rchan->buf;
+
+	if (len > 0) {
+		bufno = RELAY_BUFNO_GET(idx, offset_bits(rchan));
+		atomic_add_volatile(&fill_count(rchan, bufno), len);
+	}
+
+	if (deliver) {
+		rchan->callbacks->deliver(rchan->id, from, len);
+		resize_check(rchan);
+	}
+}
+
+/**
+ *	get_buffer_end - get the address of the end of buffer 
+ *	@rchan: the channel
+ *	@buf_idx: index into channel corresponding to address
+ */
+static inline char * 
+get_buffer_end(struct rchan *rchan, u32 buf_idx)
+{
+	return rchan->buf
+		+ RELAY_BUF_OFFSET_CLEAR(buf_idx, offset_mask(rchan))
+		+ RELAY_BUF_SIZE(offset_bits(rchan));
+}
+
+/**
+ *	finalize_buffer - utility function consolidating end-of-buffer tasks.
+ *	@end_idx: index into trace buffer to write the end-buffer event at
+ *	@size_lost: number of unused bytes at the end of the buffer
+ *	@time_stamp: the time of the end-buffer event
+ *	@tsc: the timestamp counter associated with time
+ *	@cpu_id: the CPU id associated with the event
+ *
+ *	This function must be called with local irqs disabled.
+ */
+static inline void 
+finalize_buffer(u32 end_idx,
+		u32 size_lost, 
+		struct timeval *time_stamp,
+		u32 *tsc, 
+		struct rchan *rchan)
+{
+	char* cur_write_pos;
+	char* write_buf_end;
+	u32 bufno;
+	int bytes_written;
+
+	cur_write_pos = rchan->buf + end_idx;
+	write_buf_end = get_buffer_end(rchan, end_idx - 1);
+
+	bytes_written = rchan->callbacks->buffer_end(rchan->id, cur_write_pos, 
+		     write_buf_end, *time_stamp, *tsc, using_tsc(rchan));
+	/* We assume that since the client didn't write anything, at some
+	   point the unused_bytes value will be needed. */ 
+	if (bytes_written == 0)
+		rchan->unused_bytes[rchan->buf_idx % rchan->n_bufs] = size_lost;
+	
+        bufno = RELAY_BUFNO_GET(end_idx, offset_bits(rchan));
+        atomic_add_volatile(&fill_count(rchan, bufno), size_lost);
+	rchan->bufs_produced++;
+}
+
+/**
+ *	lockless_finalize: - finalize last buffer at end of channel use
+ *	@rchan: the channel
+ */
+inline void
+lockless_finalize(struct rchan *rchan)
+{
+	u32 event_end_idx;
+	u32 size_lost;
+	unsigned long int flags;
+	struct timeval time;
+	u32 tsc;
+
+	event_end_idx = RELAY_BUF_OFFSET_GET(idx(rchan), offset_mask(rchan));
+	size_lost = RELAY_BUF_SIZE(offset_bits(rchan)) - event_end_idx;
+
+	local_irq_save(flags);
+	get_timestamp(&time, &tsc, rchan);
+	finalize_buffer(idx(rchan) & idx_mask(rchan), size_lost, 
+			&time, &tsc, rchan);
+	local_irq_restore(flags);
+}
+
+/**
+ *	discard_check: - determine whether a write should be discarded
+ *	@rchan: the channel
+ *	@old_idx: index into trace buffer where check for space should begin
+ *	@write_len: the length of the write to check
+ *	@time_stamp: the time of the end-buffer event
+ *	@tsc: the timestamp counter associated with time
+ *
+ *	The return value contains the result flags and is an ORed combination 
+ *	of the following:
+ *
+ *	RELAY_WRITE_DISCARD_NONE - write should not be discarded
+ *	RELAY_BUFFER_SWITCH - buffer switch occurred
+ *	RELAY_WRITE_DISCARD - write should be discarded (all buffers are full)
+ *	RELAY_WRITE_TOO_LONG - write won't fit into even an empty buffer
+ */
+static inline int
+discard_check(struct rchan *rchan,
+	      u32 old_idx,
+	      u32 write_len, 
+	      struct timeval *time_stamp,
+	      u32 *tsc)
+{
+	u32 buffers_ready;
+	u32 offset_mask = offset_mask(rchan);
+	u8 offset_bits = offset_bits(rchan);
+	u32 idx_mask = idx_mask(rchan);
+	u32 size_lost;
+	unsigned long int flags;
+
+	if (write_len > RELAY_BUF_SIZE(offset_bits))
+		return RELAY_WRITE_DISCARD | RELAY_WRITE_TOO_LONG;
+
+	if (mode_continuous(rchan))
+		return RELAY_WRITE_DISCARD_NONE;
+	
+	local_irq_save(flags);
+
+	if (atomic_read(&rchan->suspended) == 1) {
+		local_irq_restore(flags);
+		return RELAY_WRITE_DISCARD;
+	}
+
+	buffers_ready = rchan->bufs_produced - rchan->bufs_consumed;
+	if (buffers_ready == rchan->n_bufs - 1) {
+		atomic_set(&rchan->suspended, 1);
+		size_lost = RELAY_BUF_SIZE(offset_bits)
+			- RELAY_BUF_OFFSET_GET(old_idx, offset_mask);
+		finalize_buffer(old_idx & idx_mask, size_lost, 
+				time_stamp, tsc, rchan);
+
+		local_irq_restore(flags);
+
+		return RELAY_BUFFER_SWITCH | RELAY_WRITE_DISCARD;
+	}
+
+	local_irq_restore(flags);
+
+	return RELAY_WRITE_DISCARD_NONE;
+}
+
+/**
+ *	switch_buffers - switch over to a new sub-buffer
+ *	@rchan: the channel
+ *	@slot_len: the length of the slot needed for the current write
+ *	@offset: the offset calculated for the new index
+ *	@ts: timestamp
+ *	@tsc: the timestamp counter associated with time
+ *	@old_idx: the value of the buffer control index when we were called
+ *	@old_idx: the new calculated value of the buffer control index
+ */
+static inline void
+switch_buffers(struct rchan *rchan,
+	       u32 slot_len,
+	       u32 offset,
+	       struct timeval *ts,
+	       u32 *tsc,
+	       u32 new_idx,
+	       u32 old_idx)
+{
+	u32 size_lost = rchan->end_reserve;
+	unsigned long int flags;
+	u32 idx_mask = idx_mask(rchan);
+	u8 offset_bits = offset_bits(rchan);
+	char *cur_write_pos;
+	u32 new_buf_no;
+	u32 start_reserve = rchan->start_reserve;
+	
+	if (offset > 0)
+		size_lost += slot_len - offset;
+	else
+		old_idx += slot_len;
+
+	local_irq_save(flags);
+	finalize_buffer(old_idx & idx_mask, size_lost, 
+			ts, tsc, rchan);
+	rchan->buf_start_time = *ts;
+	rchan->buf_start_tsc = *tsc;
+
+	local_irq_restore(flags);
+
+	cur_write_pos = rchan->buf + RELAY_BUF_OFFSET_CLEAR((new_idx
+					     & idx_mask), offset_mask(rchan));
+
+	rchan->buf_idx++;
+	rchan->buf_id++;
+
+	rchan->unused_bytes[rchan->buf_idx % rchan->n_bufs] = 0;
+	
+	rchan->callbacks->buffer_start(rchan->id, cur_write_pos, 
+			       rchan->buf_id, *ts, *tsc, using_tsc(rchan));
+
+	new_buf_no = RELAY_BUFNO_GET(new_idx & idx_mask, offset_bits);
+
+	atomic_sub_volatile(&fill_count(rchan, new_buf_no),
+			    RELAY_BUF_SIZE(offset_bits) - start_reserve);
+
+	if (atomic_read(&fill_count(rchan, new_buf_no)) < start_reserve)
+		atomic_set_volatile(&fill_count(rchan, new_buf_no), 
+				    start_reserve);
+}
+
+/**
+ *	lockless_reserve_slow - the slow reserve path in the lockless scheme
+ *	@rchan: the channel
+ *	@slot_len: the length of the slot to reserve
+ *	@ts: variable that will receive the time the slot was reserved
+ *	@tsc: the timestamp counter associated with time
+ *	@old_idx: the value of the buffer control index when we were called
+ *	@err: receives the result flags
+ *
+ *	Returns pointer to the beginning of the reserved slot, NULL if error.
+
+ *	err values same as for lockless_reserve.
+ */
+static inline char *
+lockless_reserve_slow(struct rchan *rchan,
+		      u32 slot_len,
+		      struct timeval *ts,
+		      u32 *tsc,
+		      u32 old_idx,
+		      int *err)
+{
+	u32 new_idx, offset;
+	unsigned long int flags;
+	u32 offset_mask = offset_mask(rchan);
+	u32 idx_mask = idx_mask(rchan);
+	u32 start_reserve = rchan->start_reserve;
+	u32 end_reserve = rchan->end_reserve;
+	int discard_event;
+	u32 reserved_idx;
+	char *cur_write_pos;
+	int initializing = 0;
+
+	*err = RELAY_BUFFER_SWITCH_NONE;
+
+	discard_event = discard_check(rchan, old_idx, slot_len, ts, tsc);
+	if (discard_event != RELAY_WRITE_DISCARD_NONE) {
+		*err = discard_event;
+		return NULL;
+	}
+
+	local_irq_save(flags);
+	if (rchan->initialized == 0) {
+		rchan->initialized = initializing = 1;
+		idx(rchan) = rchan->start_reserve + rchan->rchan_start_reserve;
+	}
+	local_irq_restore(flags);
+
+	do {
+		old_idx = idx(rchan);
+		new_idx = old_idx + slot_len;
+
+		offset = RELAY_BUF_OFFSET_GET(new_idx + end_reserve,
+					      offset_mask);
+
+		if ((offset < slot_len) && (offset > 0)) {
+			reserved_idx = RELAY_BUF_OFFSET_CLEAR(new_idx 
+				+ end_reserve, offset_mask) + start_reserve;
+			new_idx = reserved_idx + slot_len;
+		} else if (offset < slot_len) {
+			reserved_idx = old_idx;
+			new_idx = RELAY_BUF_OFFSET_CLEAR(new_idx
+			      + end_reserve, offset_mask) + start_reserve;
+		} else
+			reserved_idx = old_idx;
+
+		get_timestamp(ts, tsc, rchan);
+	} while (!compare_and_store_volatile(&idx(rchan), old_idx, new_idx));
+
+	reserved_idx &= idx_mask;
+
+	if (initializing == 1) {
+		cur_write_pos = rchan->buf 
+			+ RELAY_BUF_OFFSET_CLEAR((old_idx & idx_mask),
+						 offset_mask(rchan));
+		rchan->buf_start_time = *ts;
+		rchan->buf_start_tsc = *tsc;
+		rchan->unused_bytes[0] = 0;
+
+		rchan->callbacks->buffer_start(rchan->id, cur_write_pos, 
+			       rchan->buf_id, *ts, *tsc, using_tsc(rchan));
+	}
+
+	if (offset < slot_len) {
+		switch_buffers(rchan, slot_len, offset, ts, tsc, new_idx,
+			       old_idx);
+		*err = RELAY_BUFFER_SWITCH;
+	}
+
+	/* If not using TSC, need to calc time delta */
+	recalc_time_delta(ts, tsc, rchan);
+
+	return rchan->buf + reserved_idx;
+}
+
+/**
+ *	lockless_reserve - reserve a slot in the trace buffer for an event.
+ *	@rchan: the channel
+ *	@slot_len: the length of the slot to reserve
+ *	@ts: variable that will receive the time the slot was reserved
+ *	@tsc: the timestamp counter associated with time
+ *	@err: receives the result flags
+ *	@interrupting: not used
+ *
+ *	Returns pointer to the beginning of the reserved slot, NULL if error.
+ *
+ *	The err value contains the result flags and is an ORed combination 
+ *	of the following:
+ *
+ *	RELAY_BUFFER_SWITCH_NONE - no buffer switch occurred
+ *	RELAY_EVENT_DISCARD_NONE - event should not be discarded
+ *	RELAY_BUFFER_SWITCH - buffer switch occurred
+ *	RELAY_EVENT_DISCARD - event should be discarded (all buffers are full)
+ *	RELAY_EVENT_TOO_LONG - event won't fit into even an empty buffer
+ */
+inline char * 
+lockless_reserve(struct rchan *rchan,
+		 u32 slot_len,
+		 struct timeval *ts,
+		 u32 *tsc,
+		 int *err,
+		 int *interrupting)
+{
+	u32 old_idx, new_idx, offset;
+	u32 offset_mask = offset_mask(rchan);
+
+	do {
+		old_idx = idx(rchan);
+		new_idx = old_idx + slot_len;
+
+		offset = RELAY_BUF_OFFSET_GET(new_idx + rchan->end_reserve, 
+					      offset_mask);
+
+		if (offset < slot_len)
+			return lockless_reserve_slow(rchan, slot_len, 
+				     ts, tsc, old_idx, err);
+
+		get_time_or_tsc(ts, tsc, rchan);
+	} while (!compare_and_store_volatile(&idx(rchan), old_idx, new_idx));
+
+	/* If not using TSC, need to calc time delta */
+	recalc_time_delta(ts, tsc, rchan);
+
+	*err = RELAY_BUFFER_SWITCH_NONE;
+
+	return rchan->buf + (old_idx & idx_mask(rchan));
+}
+
+/**
+ *	lockless_get_offset - get current and max 'file' offsets for VFS
+ *	@rchan: the channel
+ *	@max_offset: maximum channel offset
+ *
+ *	Returns the current and maximum buffer offsets in VFS terms.
+ */
+u32 
+lockless_get_offset(struct rchan *rchan,
+			u32 *max_offset)
+{
+	if (max_offset)
+		*max_offset = rchan->buf_size * rchan->n_bufs - 1;
+
+	return idx(rchan) & idx_mask(rchan);
+}
+
+/**
+ *	lockless_reset - reset the channel
+ *	@rchan: the channel
+ *	@init: 1 if this is a first-time channel initialization
+ */
+void lockless_reset(struct rchan *rchan, int init)
+{
+	int i;
+	
+	resize_order(rchan) = 0;
+	/* Start first buffer at 0 - (end_reserve + 1) so that it
+	   gets initialized via buffer_start callback as well. */
+	idx(rchan) =  0UL - (rchan->end_reserve + 1);
+	idx_mask(rchan) =
+		(1UL << (bufno_bits(rchan) + offset_bits(rchan))) - 1;
+	atomic_set(&fill_count(rchan, 0), 
+		   (int)rchan->start_reserve + 
+		   (int)rchan->rchan_start_reserve);
+	for (i = 1; i < rchan->n_bufs; i++)
+		atomic_set(&fill_count(rchan, i),
+			   (int)RELAY_BUF_SIZE(offset_bits(rchan)));
+}
+
+
+
+
+
+
+
+
+
+
+
+
+
diff -urpN -X dontdiff linux-2.6.0-test6/fs/relayfs/relay_lockless.h linux-2.6.0-test6.cur/fs/relayfs/relay_lockless.h
--- linux-2.6.0-test6/fs/relayfs/relay_lockless.h	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test6.cur/fs/relayfs/relay_lockless.h	Tue Oct  7 11:52:47 2003
@@ -0,0 +1,32 @@
+#ifndef _RELAY_LOCKLESS_H
+#define _RELAY_LOCKLESS_H
+
+extern char *
+lockless_reserve(struct rchan *rchan,
+		 u32 slot_len,
+		 struct timeval *time_stamp,
+		 u32 *tsc,
+		 int * interrupting,
+		 int * errcode);
+
+extern void 
+lockless_commit(struct rchan *rchan,
+		char * from,
+		u32 len, 
+		int deliver, 
+		int interrupting);
+
+extern void 
+lockless_resume(struct rchan *rchan);
+
+extern void 
+lockless_finalize(struct rchan *rchan);
+
+extern u32 
+lockless_get_offset(struct rchan *rchan, u32 *max_offset);
+
+extern void
+lockless_reset(struct rchan *rchan,
+	       int init);
+
+#endif/* _RELAY_LOCKLESS_H */


-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

