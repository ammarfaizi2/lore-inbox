Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262066AbVATGR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbVATGR6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 01:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVATGRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 01:17:44 -0500
Received: from opersys.com ([64.40.108.71]:15113 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262061AbVATGNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 01:13:11 -0500
Message-ID: <41EF4E74.2000304@opersys.com>
Date: Thu, 20 Jan 2005 01:23:48 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Roman Zippel <zippel@linux-m68k.org>, Greg KH <greg@kroah.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>
Subject: [PATCH] relayfs redux for 2.6.10: lean and mean
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've reworked the relayfs patch extensively. The API and internals
have been heavily purged. The patch is in fact almost HALF! its
original size, loosing 90KB and going from 200KB to 110KB.

Here's a summary of changes:
- Dropped the lockless scheme (complaints from Christoph, Arjan,
  Ingo, Andrew, etc. regarding the debatable efficiency of cmpxchng
  over traditional locks.)
- Dropped the resizing capabilities (Andi, Christoph, etc.)
- Dropped all user-space read/write capabilities (Andi, Christoph,
  Roman, Tim, etc.) Basically this is about making relayfs do
  one thing and do it good: transfer high volumes of data to
  user-space as efficiently as possible.
- Implemented the ad-hoc mode. This mode contrasts with the
  managed mode (old locking scheme) in that it manages only
  one ring buffer, doesn't care about outside synchronization,
  and is basically the most basic buffer scheme one could have.
  (ongoing discussion with Roman on this issue.)
- Dropped the klog client (Greg).
- Modified API to use pointers instead of IDs (Roman).
- Miscallaneous cleanups (Domen).
- Miscallaneous rearrangement of code (me).

I've tested this with a hacked ltt patch and I can get it
to collect data in the managed mode without a problem.
Reading the data though is another story, I'll update the
LTT patch once I know where the relayfs stuff is heading.
Beware: don't try to use the ltt code in Andrew's tree with
this relayfs, it's a completely different beast.

So without further ado, here's the code. I've removed the
Documentation/filesystems/relayfs.txt file for now (no, don't
worry that's not part of the 90KB that went away ;). It's
probably going to need some rewriting before we're done,
so let's not get distracted by it for now.

Karim

The full patch is here:
http://www.opersys.com/ftp/pub/relayfs/patch-relayfs-redux-2.6.10-050120-real
http://www.opersys.com/ftp/pub/relayfs/patch-relayfs-redux-2.6.10-050120-real.bz2

Signed-off-by: Karim Yaghmour <karim@opersys.com>

diffstat:
 fs/Kconfig                            |   18
 fs/Makefile                           |    4
 fs/relayfs/Makefile                   |    8
 fs/relayfs/buffers.c                  |  202 +++++
 fs/relayfs/buffers.h                  |   33
 fs/relayfs/inode.c                    |  520 ++++++++++++++
 fs/relayfs/relay.c                    | 1193 ++++++++++++++++++++++++++++++++++
 fs/relayfs/relay.h                    |   62 +
 fs/relayfs/relay_adhoc.c              |  109 +++
 fs/relayfs/relay_adhoc.h              |   26
 fs/relayfs/relay_managed.c            |  270 +++++++
 fs/relayfs/relay_managed.h            |   26
 include/linux/relayfs_fs.h            |  378 ++++++++++
 14 files changed, 3659 insertions(+), 2 deletions(-)

--- linux-2.6.10/fs/Kconfig	2004-12-24 16:34:58.000000000 -0500
+++ linux-2.6.10-relayfs-redux-1/fs/Kconfig	2005-01-20 01:24:17.000000000 -0500
@@ -972,6 +972,24 @@ config RAMFS
 	  To compile this as a module, choose M here: the module will be called
 	  ramfs.

+config RELAYFS_FS
+	tristate "Relayfs file system support"
+	---help---
+	  Relayfs is a high-speed data relay filesystem designed to provide
+	  an efficient mechanism for tools and facilities to relay large
+	  amounts of data from kernel space to user space.  It's not useful
+	  on its own, and should only be enabled if other facilities that
+	  need it are enabled, such as for example the Linux Trace Toolkit.
+
+	  See <file:Documentation/filesystems/relayfs.txt> for further
+	  information.
+
+	  This file system is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module is called relayfs.  If you want to compile it as a
+	  module, say M here and read <file:Documentation/modules.txt>.
+	  If unsure, say N.
+
 endmenu

 menu "Miscellaneous filesystems"
--- linux-2.6.10/fs/Makefile	2004-12-24 16:34:58.000000000 -0500
+++ linux-2.6.10-relayfs-redux-1/fs/Makefile	2005-01-20 01:23:27.000000000 -0500
@@ -1,5 +1,4 @@
-#
-# Makefile for the Linux filesystems.
+## Makefile for the Linux filesystems.
 #
 # 14 Sep 2000, Christoph Hellwig <hch@infradead.org>
 # Rewritten to use lists instead of if-statements.
@@ -53,6 +52,7 @@ obj-$(CONFIG_EXT2_FS)		+= ext2/
 obj-$(CONFIG_CRAMFS)		+= cramfs/
 obj-$(CONFIG_RAMFS)		+= ramfs/
 obj-$(CONFIG_HUGETLBFS)		+= hugetlbfs/
+obj-$(CONFIG_RELAYFS_FS)	+= relayfs/
 obj-$(CONFIG_CODA_FS)		+= coda/
 obj-$(CONFIG_MINIX_FS)		+= minix/
 obj-$(CONFIG_FAT_FS)		+= fat/
--- linux-2.6.10/fs/relayfs/buffers.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.10-relayfs-redux-1/fs/relayfs/buffers.c	2005-01-20 01:19:26.000000000 -0500
@@ -0,0 +1,202 @@
+/*
+ * RelayFS buffer management code.
+ *
+ * Copyright (C) 2002, 2003 - Tom Zanussi (zanussi@us.ibm.com), IBM Corp
+ * Copyright (C) 1999, 2000, 2001, 2002 - Karim Yaghmour (karim@opersys.com)
+ *
+ * This file is released under the GPL.
+ */
+
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include <linux/mm.h>
+#include <linux/relayfs_fs.h>
+#include "buffers.h"
+
+/**
+ *	alloc_page_array - alloc array to hold pages, but not pages
+ *	@size: the total size of the memory represented by the page array
+ *	@page_count: the number of pages the array can hold
+ *	@err: 0 on success, negative otherwise
+ *
+ *	Returns a pointer to the page array if successful, NULL otherwise.
+ */
+static struct page **
+alloc_page_array(int size, int *page_count, int *err)
+{
+	int n_pages;
+	struct page **page_array;
+	int page_array_size;
+
+	*err = 0;
+
+	size = PAGE_ALIGN(size);
+	n_pages = size >> PAGE_SHIFT;
+	page_array_size = n_pages * sizeof(struct page *);
+	page_array = kmalloc(page_array_size, GFP_KERNEL);
+	if (page_array == NULL) {
+		*err = -ENOMEM;
+		return NULL;
+	}
+	*page_count = n_pages;
+	memset(page_array, 0, page_array_size);
+
+	return page_array;
+}
+
+/**
+ *	free_page_array - free array to hold pages, but not pages
+ *	@page_array: pointer to the page array
+ */
+static inline void
+free_page_array(struct page **page_array)
+{
+	kfree(page_array);
+}
+
+/**
+ *	depopulate_page_array - free and unreserve all pages in the array
+ *	@page_array: pointer to the page array
+ *	@page_count: number of pages to free
+ */
+static void
+depopulate_page_array(struct page **page_array, int page_count)
+{
+	int i;
+
+	for (i = 0; i < page_count; i++) {
+		ClearPageReserved(page_array[i]);
+		__free_page(page_array[i]);
+	}
+}
+
+/**
+ *	populate_page_array - allocate and reserve pages
+ *	@page_array: pointer to the page array
+ *	@page_count: number of pages to allocate
+ *
+ *	Returns 0 if successful, negative otherwise.
+ */
+static int
+populate_page_array(struct page **page_array, int page_count)
+{
+	int i;
+
+	for (i = 0; i < page_count; i++) {
+		page_array[i] = alloc_page(GFP_KERNEL);
+		if (unlikely(!page_array[i])) {
+			depopulate_page_array(page_array, i);
+			return -ENOMEM;
+		}
+		SetPageReserved(page_array[i]);
+	}
+	return 0;
+}
+
+/**
+ *	alloc_rchan_buf - allocate the initial channel buffer
+ *	@size: total size of the buffer
+ *	@page_array: receives a pointer to the buffer's page array
+ *	@page_count: receives the number of pages allocated
+ *
+ *	Returns a pointer to the resulting buffer, NULL if unsuccessful
+ */
+void *
+alloc_rchan_buf(unsigned long size, struct page ***page_array, int *page_count)
+{
+	void *mem;
+	int err;
+
+	*page_array = alloc_page_array(size, page_count, &err);
+	if (!*page_array)
+		return NULL;
+
+	err = populate_page_array(*page_array, *page_count);
+	if (err) {
+		free_page_array(*page_array);
+		*page_array = NULL;
+		return NULL;
+	}
+
+	mem = vmap(*page_array, *page_count, GFP_KERNEL, PAGE_KERNEL);
+	if (!mem) {
+		depopulate_page_array(*page_array, *page_count);
+		free_page_array(*page_array);
+		*page_array = NULL;
+		return NULL;
+	}
+	memset(mem, 0, size);
+
+	return mem;
+}
+
+/**
+ *	relaybuf_free - free a resized channel buffer
+ *	@private: pointer to the channel struct
+ *
+ *	Internal - manages the de-allocation and unmapping of old channel
+ *	buffers.
+ */
+static void
+relaybuf_free(void *private)
+{
+	struct free_rchan_buf *free_buf = (struct free_rchan_buf *)private;
+	int i;
+
+	if (free_buf->unmap_buf)
+		vunmap(free_buf->unmap_buf);
+
+	for (i = 0; i < 3; i++) {
+		if (!free_buf->page_array[i].array)
+			continue;
+		if (free_buf->page_array[i].count)
+			depopulate_page_array(free_buf->page_array[i].array,
+					      free_buf->page_array[i].count);
+		free_page_array(free_buf->page_array[i].array);
+	}
+
+	kfree(free_buf);
+}
+
+/**
+ *	add_free_page_array - add a page_array to be freed
+ *	@free_rchan_buf: the free_rchan_buf struct
+ *	@page_array: the page array to free
+ *	@page_count: the number of pages to free, 0 to free the array only
+ *
+ *	Internal - Used add page_arrays to be freed asynchronously.
+ */
+static inline void
+add_free_page_array(struct free_rchan_buf *free_rchan_buf,
+		    struct page **page_array, int page_count)
+{
+	int cur = free_rchan_buf->cur++;
+
+	free_rchan_buf->page_array[cur].array = page_array;
+	free_rchan_buf->page_array[cur].count = page_count;
+}
+
+/**
+ *	free_rchan_buf - free a channel buffer
+ *	@buf: pointer to the buffer to free
+ *	@page_array: pointer to the buffer's page array
+ *	@page_count: number of pages in page array
+ */
+int
+free_rchan_buf(void *buf, struct page **page_array, int page_count)
+{
+	struct free_rchan_buf *free_buf;
+
+	free_buf = kmalloc(sizeof(struct free_rchan_buf), GFP_ATOMIC);
+	if (!free_buf)
+		return -ENOMEM;
+	memset(free_buf, 0, sizeof(struct free_rchan_buf));
+
+	free_buf->unmap_buf = buf;
+	add_free_page_array(free_buf, page_array, page_count);
+
+	INIT_WORK(&free_buf->work, relaybuf_free, free_buf);
+	schedule_delayed_work(&free_buf->work, 1);
+
+	return 0;
+}
--- linux-2.6.10/fs/relayfs/buffers.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.10-relayfs-redux-1/fs/relayfs/buffers.h	2005-01-20 01:19:26.000000000 -0500
@@ -0,0 +1,33 @@
+#ifndef _BUFFERS_H
+#define _BUFFERS_H
+
+/* This inspired by rtai/shmem */
+#define FIX_SIZE(x) (((x) - 1) & PAGE_MASK) + PAGE_SIZE
+
+/*
+ * Used for deferring resized channel free
+ */
+struct free_rchan_buf
+{
+	char *unmap_buf;
+	struct
+	{
+		struct page **array;
+		int count;
+	} page_array[3];
+
+	int cur;
+	struct work_struct work;	/* de-allocation work struct */
+};
+
+extern void *
+alloc_rchan_buf(unsigned long size,
+		struct page ***page_array,
+		int *page_count);
+
+extern int
+free_rchan_buf(void *buf,
+	       struct page **page_array,
+	       int page_count);
+
+#endif/* _BUFFERS_H */
--- linux-2.6.10/fs/relayfs/inode.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.10-relayfs-redux-1/fs/relayfs/inode.c	2005-01-20 01:19:26.000000000 -0500
@@ -0,0 +1,520 @@
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
+#include <linux/relayfs_fs.h>
+
+#include <asm/uaccess.h>
+
+#include "relay.h"
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
+		rchan = inode->u.generic_ip;
+		if (rchan == NULL)
+			return -EACCES;
+		reader = __add_rchan_reader(rchan, filp, 1, 0);
+		if (reader == NULL)
+			return -ENOMEM;
+		filp->private_data = reader;
+		retval = rchan->callbacks->fileop_notify(rchan, filp,
+							 RELAY_FILE_OPEN);
+		if (retval == 0)
+			/* Inc relay channel refcount for file */
+			rchan_get(rchan);
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
+	reader = filp->private_data;
+	if (reader == NULL)
+		return -EPERM;
+
+	rchan = reader->rchan;
+	if (rchan == NULL)
+		return -EPERM;
+
+	return rchan->callbacks->ioctl(rchan, cmd, arg);
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
+	reader = filp->private_data;
+
+	if (reader->rchan->finalized)
+		return POLLERR;
+
+	if (filp->f_mode & FMODE_READ) {
+		poll_wait(filp, &reader->rchan->mmap_read_wait, wait);
+		if (!rchan_empty(reader))
+			mask |= POLLIN | POLLRDNORM;
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
+        rchan->callbacks->fileop_notify(reader->rchan, filp,
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
--- linux-2.6.10/fs/relayfs/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.10-relayfs-redux-1/fs/relayfs/Makefile	2005-01-20 01:19:26.000000000 -0500
@@ -0,0 +1,8 @@
+#
+# relayfs Makefile
+#
+
+obj-$(CONFIG_RELAYFS_FS) += relayfs.o
+
+relayfs-y := relay.o buffers.o relay_managed.o relay_adhoc.o inode.o
+
--- linux-2.6.10/fs/relayfs/relay_adhoc.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.10-relayfs-redux-1/fs/relayfs/relay_adhoc.c	2005-01-20 01:19:26.000000000 -0500
@@ -0,0 +1,109 @@
+/*
+ * RelayFS adhoc mode implementation.
+ *
+ * Copyright (C) 2005 - Karim Yaghmour (karim@opersys.com), Opersys inc.
+ * Copyright (C) 2002, 2003 - Tom Zanussi (zanussi@us.ibm.com), IBM Corp
+ *
+ * This file is released under the GPL.
+ */
+
+#include <linux/relayfs_fs.h>
+
+#include "relay.h"
+#include "buffers.h"
+#include "relay_adhoc.h"
+
+/* Helper functions for the Ad-Hoc mode */
+#define write_buf(rchan) ((rchan)->mode.adhoc.write_buf)
+#define write_limit(rchan) ((rchan)->mode.adhoc.write_limit)
+#define cur_write_pos(rchan) ((rchan)->mode.adhoc.current_write_pos)
+#define channel_lock(rchan) ((rchan)->mode.adhoc.lock)
+
+/**
+ *	adhoc_reserve - reserve a slot in the buffer for an event
+ *	@rchan: the channel
+ *	@slot_len: the length of the slot to reserve
+ *	@err: receives the result flags
+ *	@interrupting: if this write is interrupting another, set to non-zero
+ *
+ *	Returns pointer to the beginning of the reserved slot, NULL if error.
+ */
+char *
+adhoc_reserve(struct rchan *rchan,
+		u32 slot_len,
+		int *err,
+		int *interrupting)
+{
+	*err = 0;
+
+	if (unlikely(cur_write_pos(rchan) + slot_len > write_limit(rchan))) {
+		if (mode_continuous(rchan))
+			cur_write_pos(rchan) = rchan->buf;
+		else {
+			cur_write_pos(rchan) = write_limit(rchan) + 1;
+			return NULL;
+		}
+	}
+
+	return cur_write_pos(rchan);
+}
+
+/**
+ *	adhoc_commit - commit a reserved slot in the buffer
+ *	@rchan: the channel
+ *	@from: commit the length starting here
+ *	@len: length committed
+ *	@deliver: length committed
+ *	@interrupting: value set by relay_reserve()
+ *
+ *      Commits len bytes.
+ */
+void
+adhoc_commit(struct rchan *rchan,
+	       char *from,
+	       u32 len,
+	       int deliver,
+	       int interrupting)
+{
+	cur_write_pos(rchan) += len;
+}
+
+/**
+ *	managed_finalize: - finalize last buffer at end of channel use
+ *	@rchan: the channel
+ */
+void
+adhoc_finalize(struct rchan *rchan)
+{
+	return;
+}
+
+/**
+ *	managed_get_offset - get current and max 'file' offsets for VFS
+ *	@rchan: the channel
+ *	@max_offset: maximum channel offset
+ *
+ *	Returns the current and maximum buffer offsets in VFS terms.
+ */
+u32
+adhoc_get_offset(struct rchan *rchan, u32 *max_offset)
+{
+	*max_offset = rchan->buf_size - 1;
+
+	return cur_write_pos(rchan) - rchan->buf;
+}
+
+/**
+ *	managed_reset - reset the channel
+ *	@rchan: the channel
+ *	@init: 1 if this is a first-time channel initialization
+ */
+void
+adhoc_reset(struct rchan *rchan, int init)
+{
+	if (init)
+		channel_lock(rchan) = SPIN_LOCK_UNLOCKED;
+	write_buf(rchan) = rchan->buf;
+	write_limit(rchan) = write_buf(rchan) + rchan->buf_size;
+	cur_write_pos(rchan) = write_buf(rchan);
+}
--- linux-2.6.10/fs/relayfs/relay_adhoc.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.10-relayfs-redux-1/fs/relayfs/relay_adhoc.h	2005-01-20 01:19:26.000000000 -0500
@@ -0,0 +1,26 @@
+#ifndef _RELAY_ADHOC_H
+#define _RELAY_ADHOC_H
+
+extern char *
+adhoc_reserve(struct rchan *rchan,
+		u32 slot_len,
+		int *err,
+		int *interrupting);
+
+extern void
+adhoc_commit(struct rchan *rchan,
+	       char *from,
+	       u32 len,
+	       int deliver,
+	       int interrupting);
+
+extern void
+adhoc_finalize(struct rchan *rchan);
+
+extern u32
+adhoc_get_offset(struct rchan *rchan, u32 *max_offset);
+
+extern void
+adhoc_reset(struct rchan *rchan, int init);
+
+#endif	/* _RELAY_ADHOC_H */
--- linux-2.6.10/fs/relayfs/relay.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.10-relayfs-redux-1/fs/relayfs/relay.c	2005-01-20 01:19:26.000000000 -0500
@@ -0,0 +1,1193 @@
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
+#include <linux/relayfs_fs.h>
+
+#include <asm/io.h>
+#include <asm/current.h>
+#include <asm/uaccess.h>
+#include <asm/bitops.h>
+#include <asm/pgtable.h>
+#include <asm/hardirq.h>
+
+#include "relay.h"
+#include "buffers.h"
+#include "relay_managed.h"
+#include "relay_adhoc.h"
+
+/* Relay channel table, indexed by channel id */
+static struct rchan *	rchan_table[RELAY_MAX_CHANNELS];
+static rwlock_t		rchan_table_lock = RW_LOCK_UNLOCKED;
+
+/* Relay operation structs, one per mode */
+static struct relay_ops managed_ops = {
+	.reserve = managed_reserve,
+	.commit = managed_commit,
+	.get_offset = managed_get_offset,
+	.finalize = managed_finalize,
+	.reset = managed_reset,
+};
+
+static struct relay_ops adhoc_ops = {
+	.reserve = adhoc_reserve,
+	.commit = adhoc_commit,
+	.get_offset = adhoc_get_offset,
+	.finalize = adhoc_finalize,
+	.reset = adhoc_reset,
+};
+
+/*
+ * Low-level relayfs kernel API.  These functions should not normally be
+ * used by clients.  See high-level kernel API below.
+ */
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
+	if (rchan->buf)
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
+
+	kfree(rchan);
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
+exit:
+	return err;
+}
+
+/**
+ *	rchan_get - get channel associated with id, incrementing refcount
+ *	@rchan_id: the channel id
+ *
+ *	Returns channel if successful, NULL otherwise.
+ */
+void
+rchan_get(struct rchan *rchan)
+{
+	atomic_inc(&rchan->refcount);
+}
+
+/**
+ *	rchan_put - decrement channel refcount, releasing it if 0
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
+	      int *err,
+	      int *interrupting)
+{
+	if (rchan == NULL)
+		return NULL;
+
+	*interrupting = 0;
+
+	return rchan->relay_ops->reserve(rchan, len, err, interrupting);
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
+	wake_up_interruptible(&rchan->mmap_read_wait);
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
+	if (deliver && 	waitqueue_active(&rchan->mmap_read_wait)) {
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
+	reader = filp->private_data;
+	rchan = reader->rchan;
+
+	atomic_dec(&rchan->mapped);
+
+	rchan->callbacks->fileop_notify(reader->rchan, filp,
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
+		if (remap_pfn_range(vma, start, page >> PAGE_SHIFT, PAGE_SIZE, PAGE_SHARED))
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
+		err = rchan->callbacks->fileop_notify(rchan, filp,
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
+buffer_end_default_callback(struct rchan *rchan,
+			    char *current_write_pos,
+			    char *end_of_buffer)
+{
+	return 0;
+}
+
+/*
+ * buffer_start() default callback.  Does nothing.
+ */
+static int
+buffer_start_default_callback(struct rchan *rchan,
+			      char *current_write_pos,
+			      u32 buffer_id)
+{
+	return 0;
+}
+
+/*
+ * deliver() default callback.  Does nothing.
+ */
+static void
+deliver_default_callback(struct rchan *rchan, char *from, u32 len)
+{
+}
+
+/*
+ * fileop_notify() default callback.  Does nothing.
+ */
+static int
+fileop_notify_default_callback(struct rchan *rchan,
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
+ioctl_default_callback(struct rchan *rchan,
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
+	.fileop_notify = fileop_notify_default_callback,
+	.ioctl = ioctl_default_callback,
+};
+
+/**
+ *	check_attribute_flags - check sanity of channel attributes
+ *	@flags: channel attributes
+ *
+ *	Returns 0 if successful, negative otherwise.
+ */
+static int
+check_attribute_flags(u32 *attribute_flags)
+{
+	u32 flags = *attribute_flags;
+
+	if (!(flags & RELAY_DELIVERY_BULK) && !(flags & RELAY_DELIVERY_PACKET))
+		return -EINVAL; /* Delivery mode must be specified */
+
+	if (!(flags & RELAY_USAGE_SMP) && !(flags & RELAY_USAGE_GLOBAL))
+		return -EINVAL; /* Usage must be specified */
+
+	if ((flags & RELAY_MODE_CONTINUOUS) &&
+	    (flags & RELAY_MODE_NO_OVERWRITE))
+		return -EINVAL; /* Can't have it both ways */
+
+	if (!(flags & RELAY_MODE_CONTINUOUS) &&
+	    !(flags & RELAY_MODE_NO_OVERWRITE))
+		*attribute_flags |= RELAY_MODE_CONTINUOUS; /* Default to continuous */
+
+	if (!(flags & (RELAY_MANAGED | RELAY_ADHOC )))
+		return -EINVAL; /* One or both must be specified */
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
+		init_waitqueue_head(&rchan->mmap_read_wait);
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
+
+	rchan->old_buf_page_array = NULL;
+
+	INIT_WORK(&rchan->wake_readers, NULL, NULL);
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
+relay_reset(struct rchan *rchan)
+{
+	rchan_get(rchan);
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
+	     int *err)
+{
+	int size_alloc;
+	struct rchan *rchan = NULL;
+
+	*err = 0;
+
+	rchan = kmalloc(sizeof(struct rchan), GFP_KERNEL);
+	if (rchan == NULL) {
+		*err = -ENOMEM;
+		return NULL;
+	}
+	rchan->buf = NULL;
+
+	if (nbufs == 1 && bufsize) {
+		rchan->n_bufs = nbufs;
+		rchan->buf_size = bufsize;
+		size_alloc = bufsize;
+		goto alloc;
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
+alloc:
+	if (rchan_alloc_id(rchan) == -1) {
+		*err = -ENOMEM;
+		goto exit;
+	}
+
+	*err = rchan_create_buf(rchan, size_alloc);
+	if (*err) {
+		rchan_free_id(rchan->id);
+		goto exit;
+	}
+
+	rchan->alloc_size = size_alloc;
+
+	if (rchan_flags & RELAY_MANAGED)
+		rchan->relay_ops = &managed_ops;
+	else
+		rchan->relay_ops = &adhoc_ops;
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
+		  struct rchan * data)
+{
+	int err;
+	const char * fname;
+	struct dentry *topdir;
+
+	err = rchan_create_dir(chanpath, &fname, &topdir);
+	if (err && (err != -EEXIST))
+		return err;
+
+	err = relayfs_create_file(fname, topdir, dentry, data, S_IRUSR);
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
+ *
+ *	Returns channel pointer if successful, NULL otherwise.
+ *
+ *	Creates a relay channel using the sizes and attributes specified.
+ *	The default permissions, used if mode == 0 are S_IRUSR | S_IWUSR.  See
+ *	Documentation/filesystems/relayfs.txt for details.
+ */
+struct rchan *
+relay_open(const char *chanpath,
+	   int bufsize,
+	   int nbufs,
+	   u32 flags,
+	   struct rchan_callbacks *channel_callbacks)
+{
+	int err;
+	struct rchan *rchan;
+	struct dentry *dentry;
+	struct rchan_callbacks *callbacks = NULL;
+
+	if (chanpath == NULL)
+		return NULL;
+
+	if (nbufs != 1) {
+		err = check_attribute_flags(&flags);
+		if (err)
+			return NULL;
+	}
+
+	if (nbufs == 0)
+		nbufs = RELAY_DFLT_NBUFS;
+
+	if (flags & RELAY_ADHOC)
+		nbufs = 1;
+
+	rchan = rchan_create(chanpath, bufsize, nbufs, flags, &err);
+
+	if (err < 0)
+		return NULL;
+
+	/* Create file in fs */
+	if ((err = rchan_create_file(chanpath, &dentry, rchan)) < 0) {
+		rchan_destroy_buf(rchan);
+		rchan_free_id(rchan->id);
+		kfree(rchan);
+		return NULL;
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
+	if (callbacks->fileop_notify == NULL)
+		callbacks->fileop_notify = fileop_notify_default_callback;
+	if (callbacks->ioctl == NULL)
+		callbacks->ioctl = ioctl_default_callback;
+	rchan->callbacks = callbacks;
+
+	rchan->flags = flags;
+
+	__relay_reset(rchan, 1);
+
+	rchan_get(rchan);
+
+	return rchan;
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
+relay_finalize(struct rchan *rchan)
+{
+	rchan_get(rchan);
+
+	if (rchan->finalized == 0) {
+		rchan->relay_ops->finalize(rchan);
+		rchan->finalized = 1;
+	}
+
+	if (waitqueue_active(&rchan->mmap_read_wait)) {
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
+relay_close(struct rchan *rchan)
+{
+	int err;
+
+	err = relay_finalize(rchan);
+
+	if (!err) {
+		restore_callbacks(rchan);
+		rchan_put(rchan);
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
+ *	@wrote_pos: optional ptr returning buf pos written to, ignored if NULL
+ *
+ *	Returns the number of bytes written, 0 or negative on failure.
+ *
+ *	Reserves space in the channel and writes count bytes of data_ptr
+ *	to it.  Automatically performs any necessary locking, depending
+ *	on the scheme and SMP usage in effect (no locking is done for the
+ *	lockless scheme regardless of usage).
+ *
+ *	If wrote_pos is non-NULL, it will receive the location the data
+ *	was written to, which may be needed for some applications but is not
+ *	normally interesting.
+ */
+int
+relay_write(struct rchan *rchan,
+	    const void *data_ptr,
+	    size_t count,
+	    void **wrote_pos)
+{
+	unsigned long flags;
+	char *write_pos;
+	int reserve_code, interrupting;
+
+	rchan_get(rchan);
+
+	relay_lock_channel(rchan, flags);
+
+	write_pos = relay_reserve(rchan, count, &reserve_code, &interrupting);
+
+	if (likely(write_pos != NULL)) {
+		relay_write_direct(write_pos, data_ptr, count);
+		relay_commit(rchan, write_pos, count, reserve_code, interrupting);
+		*wrote_pos = write_pos;
+	} else if (reserve_code == RELAY_WRITE_TOO_LONG)
+		count = -EINVAL;
+	else
+		count = 0;
+
+	relay_unlock_channel(rchan, flags);
+
+	rchan_put(rchan);
+
+	return count;
+}
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
+		reader->pos = 0;
+		reader->offset_changed = 1;
+	}
+	read_unlock(&rchan->open_readers_lock);
+	rchan->read_start = 0;
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
+	return 1;
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
+
+	reader = kmalloc(sizeof(struct rchan_reader), GFP_KERNEL);
+
+	if (reader) {
+		reader->rchan = rchan;
+		reader->pos = 0;
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
+ *	add_map_reader - create a map reader for a channel
+ *	@rchan_id: relay channel handle
+ *
+ *	Returns a pointer to the reader object created, NULL if unsuccessful
+ *
+ *	Creates and initializes an rchan_reader object for reading the channel.
+ *	This function is useful only for map readers.
+ */
+struct rchan_reader *
+add_map_reader(struct rchan *rchan)
+{
+	rchan_get(rchan);
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
+ *	remove_map_reader - destroy a map reader
+ *	@reader: channel reader
+ *
+ *	Finds and removes the given map reader from the channel.  This function
+ *	is useful only for map readers.
+ *
+ *	Returns 0 if successful, negative otherwise.
+ */
+void
+remove_map_reader(struct rchan_reader *reader)
+{
+	__remove_rchan_reader(reader);
+}
+
+EXPORT_SYMBOL(relay_open);
+EXPORT_SYMBOL(relay_close);
+EXPORT_SYMBOL(relay_reset);
+EXPORT_SYMBOL(relay_reserve);
+EXPORT_SYMBOL(relay_commit);
+EXPORT_SYMBOL(relay_write);
+EXPORT_SYMBOL(relay_buffers_consumed);
+EXPORT_SYMBOL(add_map_reader);
+EXPORT_SYMBOL(remove_map_reader);
--- linux-2.6.10/fs/relayfs/relay.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.10-relayfs-redux-1/fs/relayfs/relay.h	2005-01-20 01:19:26.000000000 -0500
@@ -0,0 +1,62 @@
+/*
+ * fs/relayfs/relay.h
+ *
+ * Copyright (C) 1999-2005 - Karim Yaghmour (karim@opersys.com), Opersys inc.
+ * Copyright (C) 2002, 2003 - Tom Zanussi (zanussi@us.ibm.com), IBM Corp
+ *
+ * RelayFS internal definitions and declarations
+ *
+ * Please see Documentation/filesystems/relayfs.txt for more info.
+ */
+
+#ifndef _RELAY_H
+#define _RELAY_H
+
+/*
+ * Helper functions
+ */
+#define channel_buffer(rchan) ((rchan)->buf)
+
+#define bulk_delivery(rchan) (((rchan)->flags & RELAY_DELIVERY_BULK) ? 1 : 0)
+#define packet_delivery(rchan) (((rchan)->flags & RELAY_DELIVERY_PACKET) ? 1 : 0)
+#define using_managed(rchan) (((rchan)->flags & RELAY_MODE_MANAGED) ? 1 : 0)
+#define using_adhoc(rchan) (((rchan)->flags & RELAY_MODE_ADHOC) ? 1 : 0)
+#define usage_smp(rchan) (((rchan)->flags & RELAY_USAGE_SMP) ? 1 : 0)
+#define usage_global(rchan) (((rchan)->flags & RELAY_USAGE_GLOBAL) ? 1 : 0)
+#define mode_continuous(rchan) (((rchan)->flags & RELAY_MODE_CONTINUOUS) ? 1 : 0)
+
+/*
+ * Internal high-level relayfs kernel API, fs/relayfs/relay.c
+ */
+
+extern void
+update_readers_consumed(struct rchan *rchan, u32 bufs_consumed, u32 bytes_consumed);
+
+extern int
+__relay_mmap_buffer(struct rchan *rchan, struct vm_area_struct *vma);
+
+extern struct rchan_reader *
+__add_rchan_reader(struct rchan *rchan, struct file *filp, int auto_consume, int map_reader);
+
+extern void
+__remove_rchan_reader(struct rchan_reader *reader);
+
+/*
+ * VFS functions, fs/relayfs/inode.c
+ */
+extern int
+relayfs_create_dir(const char *name,
+		   struct dentry *parent,
+		   struct dentry **dentry);
+
+extern int
+relayfs_create_file(const char * name,
+		    struct dentry *parent,
+		    struct dentry **dentry,
+		    void * data,
+		    int mode);
+
+extern int
+relayfs_remove_file(struct dentry *dentry);
+
+#endif /* _RELAY_H */
--- linux-2.6.10/fs/relayfs/relay_managed.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.10-relayfs-redux-1/fs/relayfs/relay_managed.c	2005-01-20 01:19:26.000000000 -0500
@@ -0,0 +1,270 @@
+/*
+ * RelayFS managed/locking mode implementation.
+ *
+ * Copyright (C) 1999, 2000, 2001, 2002 - Karim Yaghmour (karim@opersys.com)
+ * Copyright (C) 2002, 2003 - Tom Zanussi (zanussi@us.ibm.com), IBM Corp
+ *
+ * This file is released under the GPL.
+ */
+
+#include <linux/relayfs_fs.h>
+
+#include "relay.h"
+#include "buffers.h"
+#include "relay_managed.h"
+
+
+/* Helper functions for the managed mode */
+#define write_buf(rchan) ((rchan)->mode.managed.write_buf)
+#define write_buf_end(rchan) ((rchan)->mode.managed.write_buf_end)
+#define cur_write_pos(rchan) ((rchan)->mode.managed.current_write_pos)
+#define write_limit(rchan) ((rchan)->mode.managed.write_limit)
+#define in_progress_event_pos(rchan) ((rchan)->mode.managed.in_progress_event_pos)
+#define in_progress_event_size(rchan) ((rchan)->mode.managed.in_progress_event_size)
+#define interrupted_pos(rchan) ((rchan)->mode.managed.interrupted_pos)
+#define interrupting_size(rchan) ((rchan)->mode.managed.interrupting_size)
+#define channel_lock(rchan) ((rchan)->mode.managed.lock)
+
+/**
+ *	switch_buffers - switches between read and write buffers.
+ *	@rchan: the channel
+ *	@finalizing: if true, don't start a new buffer
+ *	@resetting: if true,
+ *      @finalize_buffer_only: if true,
+ *
+ *	This should be called from with interrupts disabled.
+ */
+static void
+switch_buffers(struct rchan *rchan,
+	       int finalizing,
+	       int resetting,
+	       int finalize_buffer_only)
+{
+	char *chan_buf_end;
+	int bytes_written;
+
+	if (!rchan->half_switch) {
+		bytes_written = rchan->callbacks->buffer_end(rchan,
+							     cur_write_pos(rchan), write_buf_end(rchan));
+		if (bytes_written == 0)
+			rchan->unused_bytes[rchan->buf_idx % rchan->n_bufs] =
+				write_buf_end(rchan) - cur_write_pos(rchan);
+	}
+
+	if (finalize_buffer_only) {
+		rchan->bufs_produced++;
+		return;
+	}
+
+	chan_buf_end = rchan->buf + rchan->n_bufs * rchan->buf_size;
+	if((write_buf(rchan) + rchan->buf_size >= chan_buf_end) || resetting)
+		write_buf(rchan) = rchan->buf;
+	else
+		write_buf(rchan) += rchan->buf_size;
+	write_buf_end(rchan) = write_buf(rchan) + rchan->buf_size;
+	write_limit(rchan) = write_buf_end(rchan);
+	cur_write_pos(rchan) = write_buf(rchan);
+
+	if (resetting)
+		rchan->buf_idx = 0;
+	else
+		rchan->buf_idx++;
+	rchan->buf_id++;
+
+	if (!packet_delivery(rchan))
+		rchan->unused_bytes[rchan->buf_idx % rchan->n_bufs] = 0;
+
+	if (resetting) {
+		rchan->bufs_produced = rchan->bufs_produced + rchan->n_bufs;
+		rchan->bufs_produced -= rchan->bufs_produced % rchan->n_bufs;
+		rchan->bufs_consumed = rchan->bufs_produced;
+		rchan->bytes_consumed = 0;
+		update_readers_consumed(rchan, rchan->bufs_consumed, rchan->bytes_consumed);
+	} else if (!rchan->half_switch)
+		rchan->bufs_produced++;
+
+	rchan->half_switch = 0;
+
+	if (!finalizing) {
+		bytes_written = rchan->callbacks->buffer_start(rchan, cur_write_pos(rchan), rchan->buf_id);
+		cur_write_pos(rchan) += bytes_written;
+	}
+}
+
+/**
+ *	managed_reserve - reserve a slot in the buffer for an event.
+ *	@rchan: the channel
+ *	@slot_len: the length of the slot to reserve
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
+managed_reserve(struct rchan *rchan,
+		u32 slot_len,
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
+		rchan->unused_bytes[0] = 0;
+		bytes_written = rchan->callbacks->buffer_start(
+			rchan, cur_write_pos(rchan), rchan->buf_id);
+		cur_write_pos(rchan) += bytes_written;
+		return cur_write_pos(rchan);
+	}
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
+			in_progress_event_pos(rchan) = NULL;
+			in_progress_event_size(rchan) = 0;
+			interrupting_size(rchan) = 0;
+			*err = RELAY_WRITE_DISCARD;
+			return NULL;
+		}
+
+		buffers_ready = rchan->bufs_produced - rchan->bufs_consumed;
+		if (buffers_ready == rchan->n_bufs - 1) {
+			if (!mode_continuous(rchan)) {
+				atomic_set(&rchan->suspended, 1);
+				in_progress_event_pos(rchan) = NULL;
+				in_progress_event_size(rchan) = 0;
+				interrupting_size(rchan) = 0;
+				switch_buffers(rchan, 0, 0, 1);
+				rchan->half_switch = 1;
+
+				cur_write_pos(rchan) = write_buf_end(rchan) - 1;
+				*err = RELAY_BUFFER_SWITCH | RELAY_WRITE_DISCARD;
+				return NULL;
+			}
+		}
+
+		switch_buffers(rchan, 0, 0, 0);
+		*err = RELAY_BUFFER_SWITCH;
+	}
+
+	return cur_write_pos(rchan);
+}
+
+/**
+ *	managed_commit - commit a reserved slot in the buffer
+ *	@rchan: the channel
+ *	@from: commit the length starting here
+ *	@len: length committed
+ *	@deliver: length committed
+ *	@interrupting: value set by relay_reserve()
+ *
+ *      Commits len bytes and calls deliver callback if applicable.
+ */
+inline void
+managed_commit(struct rchan *rchan,
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
+		if (bulk_delivery(rchan)) {
+			u32 cur_idx = cur_write_pos(rchan) - rchan->buf;
+			u32 cur_bufno = cur_idx / rchan->buf_size;
+			from = rchan->buf + cur_bufno * rchan->buf_size;
+			len = cur_idx - cur_bufno * rchan->buf_size;
+		}
+		rchan->callbacks->deliver(rchan, from, len);
+	}
+}
+
+/**
+ *	managed_finalize: - finalize last buffer at end of channel use
+ *	@rchan: the channel
+ */
+inline void
+managed_finalize(struct rchan *rchan)
+{
+	unsigned long int flags;
+
+	local_irq_save(flags);
+	switch_buffers(rchan, 1, 0, 0);
+	local_irq_restore(flags);
+}
+
+/**
+ *	managed_get_offset - get current and max 'file' offsets for VFS
+ *	@rchan: the channel
+ *	@max_offset: maximum channel offset
+ *
+ *	Returns the current and maximum buffer offsets in VFS terms.
+ */
+u32
+managed_get_offset(struct rchan *rchan,
+		   u32 *max_offset)
+{
+	if (max_offset)
+		*max_offset = rchan->buf_size * rchan->n_bufs - 1;
+
+	return cur_write_pos(rchan) - rchan->buf;
+}
+
+/**
+ *	managed_reset - reset the channel
+ *	@rchan: the channel
+ *	@init: 1 if this is a first-time channel initialization
+ */
+void managed_reset(struct rchan *rchan, int init)
+{
+	if (init)
+		channel_lock(rchan) = SPIN_LOCK_UNLOCKED;
+	write_buf(rchan) = rchan->buf;
+	write_buf_end(rchan) = write_buf(rchan) + rchan->buf_size;
+	cur_write_pos(rchan) = write_buf(rchan);
+	write_limit(rchan) = write_buf_end(rchan);
+	in_progress_event_pos(rchan) = NULL;
+	in_progress_event_size(rchan) = 0;
+	interrupted_pos(rchan) = NULL;
+	interrupting_size(rchan) = 0;
+}
--- linux-2.6.10/fs/relayfs/relay_managed.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.10-relayfs-redux-1/fs/relayfs/relay_managed.h	2005-01-20 01:19:26.000000000 -0500
@@ -0,0 +1,26 @@
+#ifndef _RELAY_MANAGED_H
+#define _RELAY_MANAGED_H
+
+extern char *
+managed_reserve(struct rchan *rchan,
+		u32 slot_len,
+		int *err,
+		int *interrupting);
+
+extern void
+managed_commit(struct rchan *rchan,
+	       char *from,
+	       u32 len,
+	       int deliver,
+	       int interrupting);
+
+extern void
+managed_finalize(struct rchan *rchan);
+
+extern u32
+managed_get_offset(struct rchan *rchan, u32 *max_offset);
+
+extern void
+managed_reset(struct rchan *rchan, int init);
+
+#endif	/* _RELAY_MANAGED_H */
--- linux-2.6.10/include/linux/relayfs_fs.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.10-relayfs-redux-1/include/linux/relayfs_fs.h	2005-01-20 01:20:11.000000000 -0500
@@ -0,0 +1,378 @@
+/*
+ * linux/include/linux/relayfs_fs.h
+ *
+ * Copyright (C) 2002, 2003 - Tom Zanussi (zanussi@us.ibm.com), IBM Corp
+ * Copyright (C) 1999, 2000, 2001, 2002 - Karim Yaghmour (karim@opersys.com)
+ *
+ * RelayFS definitions and declarations
+ *
+ * Please see Documentation/filesystems/relayfs.txt for more info.
+ */
+
+#ifndef _LINUX_RELAYFS_FS_H
+#define _LINUX_RELAYFS_FS_H
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <linux/wait.h>
+#include <linux/list.h>
+#include <linux/fs.h>
+
+/*
+ * Tracks changes to rchan struct
+ */
+#define RELAYFS_CHANNEL_VERSION		2
+
+/*
+ * Maximum number of simultaneously open channels
+ */
+#define RELAY_MAX_CHANNELS		256
+
+/*
+ * Relay properties
+ */
+#define RELAY_MIN_BUFS			2
+#define RELAY_MIN_BUFSIZE		4096
+#define RELAY_MAX_BUFS			256
+#define RELAY_MAX_BUF_SIZE		0x1000000
+#define RELAY_MAX_TOTAL_BUF_SIZE	0x8000000
+#define RELAY_DFLT_NBUFS		4
+
+/*
+ * Flags returned by relay_reserve()
+ */
+#define RELAY_BUFFER_SWITCH_NONE	0x0
+#define RELAY_WRITE_DISCARD_NONE	0x0
+#define RELAY_BUFFER_SWITCH		0x1
+#define RELAY_WRITE_DISCARD		0x2
+#define RELAY_WRITE_TOO_LONG		0x4
+
+/*
+ * Relay attribute flags
+ */
+#define RELAY_DELIVERY_BULK		0x1
+#define RELAY_DELIVERY_PACKET		0x2
+#define RELAY_MANAGED			0x4
+#define RELAY_ADHOC			0x8
+#define RELAY_UNUSED1			0xC
+#define RELAY_UNUSED2			0x10
+#define RELAY_UNUSED3			0x20
+#define RELAY_UNUSED4			0x30
+#define RELAY_USAGE_SMP			0x40
+#define RELAY_USAGE_GLOBAL		0x80
+#define RELAY_MODE_CONTINUOUS		0x100
+#define RELAY_MODE_NO_OVERWRITE		0x200
+#define RELAY_MODE_START_AT_ZERO	0x400
+
+/*
+ * Values for fileop_notify() callback
+ */
+enum relay_fileop
+{
+	RELAY_FILE_OPEN,
+	RELAY_FILE_CLOSE,
+	RELAY_FILE_MAP,
+	RELAY_FILE_UNMAP
+};
+
+/*
+ * Managed mode-specific data
+ */
+struct managed_rchan
+{
+	char *write_buf;		/* start of write sub-buffer */
+	char *write_buf_end;		/* end of write sub-buffer */
+	char *current_write_pos;	/* current write pointer */
+	char *write_limit;		/* upper limit */
+	char *in_progress_event_pos;	/* used for interrupted writes */
+	u16 in_progress_event_size;	/* used for interrupted writes */
+	char *interrupted_pos;		/* used for interrupted writes */
+	u16 interrupting_size;		/* used for interrupted writes */
+	spinlock_t lock;		/* channel lock for locking scheme */
+};
+
+/*
+ * Adhoc mode-specific data
+ */
+struct adhoc_rchan
+{
+	char *write_buf;		/* start of write buffer */
+	char *write_limit;		/* end of write buffer */
+	char *current_write_pos;	/* current write pointer */
+	spinlock_t lock;		/* channel lock for locking scheme */
+};
+
+struct relay_ops;
+
+/*
+ * Relay channel data structure
+ */
+struct rchan
+{
+	u32 version;			/* the version of this struct */
+	char *buf;			/* the channel buffer */
+	union
+	{
+		struct managed_rchan managed;
+		struct adhoc_rchan adhoc;
+	} mode;
+
+	int id;				/* the channel id */
+	struct rchan_callbacks *callbacks;	/* client callbacks */
+	u32 flags;			/* relay channel attributes */
+	u32 buf_id;			/* current sub-buffer id */
+	u32 buf_idx;			/* current sub-buffer index */
+
+	atomic_t mapped;		/* map count */
+
+	atomic_t suspended;		/* channel suspended i.e full? */
+	int half_switch;		/* used internally for suspend */
+
+	struct timeval  buf_start_time;	/* current sub-buffer start time */
+	u32 buf_start_tsc;		/* current sub-buffer start TSC */
+
+	u32 buf_size;			/* sub-buffer size */
+	u32 alloc_size;			/* total buffer size allocated */
+	u32 n_bufs;			/* number of sub-buffers */
+
+	u32 bufs_produced;		/* count of sub-buffers produced */
+	u32 bufs_consumed;		/* count of sub-buffers consumed */
+	u32 bytes_consumed;		/* bytes consumed in cur sub-buffer */
+	u32 read_start;			/* start VFS readers here */
+
+	int initialized;		/* first buffer initialized? */
+	int finalized;			/* channel finalized? */
+
+	struct dentry *dentry;		/* channel file dentry */
+
+	atomic_t refcount;		/* channel refcount */
+
+	wait_queue_head_t mmap_read_wait; /* mmap reader wait queue */
+	struct work_struct wake_readers; /* reader wake-up work struct */
+
+	struct relay_ops *relay_ops;	/* scheme-specific channel ops */
+
+	int unused_bytes[RELAY_MAX_BUFS]; /* unused count per sub-buffer */
+
+	struct work_struct work;	/* allocation/deallocation work struct */
+
+	struct list_head open_readers;	/* open readers for this channel */
+	rwlock_t open_readers_lock;	/* protection for open_readers list */
+
+	struct page **buf_page_array;	/* array of current buffer pages */
+	int buf_page_count;		/* number of current buffer pages */
+	struct page **old_buf_page_array; /* hold for freeing */
+} ____cacheline_aligned;
+
+/*
+ * Relay channel client callbacks
+ */
+struct rchan_callbacks
+{
+	/*
+	 * buffer_start - called at the beginning of a new sub-buffer
+	 * @rchan_id: the channel id
+	 * @current_write_pos: position in sub-buffer client should write to
+	 * @buffer_id: the id of the new sub-buffer
+	 *
+	 * Return value should be the number of bytes written by the client.
+	 *
+	 * See Documentation/filesystems/relayfs.txt for details.
+	 */
+	int (*buffer_start) (struct rchan *rchan,
+			     char *current_write_pos,
+			     u32 buffer_id);
+
+	/*
+	 * buffer_end - called at the end of a sub-buffer
+	 * @rchan_id: the channel id
+	 * @current_write_pos: position in sub-buffer of end of data
+	 * @end_of_buffer: the position of the end of the sub-buffer
+	 *
+	 * Return value should be the number of bytes written by the client.
+	 *
+	 * See Documentation/filesystems/relayfs.txt for details.
+	 */
+	int (*buffer_end) (struct rchan *rchan,
+			   char *current_write_pos,
+			   char *end_of_buffer);
+
+	/*
+	 * deliver - called when data is ready for the client
+	 * @rchan_id: the channel id
+	 * @from: the start of the delivered data
+	 * @len: the length of the delivered data
+	 *
+	 * See Documentation/filesystems/relayfs.txt for details.
+	 */
+	void (*deliver) (struct rchan *rchan, char *from, u32 len);
+
+	/*
+	 * fileop_notify - called on open/close/mmap/munmap of a relayfs file
+	 * @rchan_id: the channel id
+	 * @filp: relayfs file pointer
+	 * @fileop: which file operation is in progress
+	 *
+	 * The return value can direct the outcome of the operation.
+	 *
+	 * See Documentation/filesystems/relayfs.txt for details.
+	 */
+        int (*fileop_notify)(struct rchan *rchan,
+			     struct file *filp,
+			     enum relay_fileop fileop);
+
+	/*
+	 * ioctl - called in ioctl context from userspace
+	 * @rchan_id: the channel id
+	 * @cmd: ioctl cmd
+	 * @arg: ioctl cmd arg
+	 *
+	 * The return value is returned as the value from the ioctl call.
+	 *
+	 * See Documentation/filesystems/relayfs.txt for details.
+	 */
+	int (*ioctl) (struct rchan *rchan, unsigned int cmd, unsigned long arg);
+};
+
+/*
+ * Relay channel reader struct
+ */
+struct rchan_reader
+{
+	struct list_head list;		/* for list inclusion */
+	struct rchan *rchan;		/* the channel we're reading from */
+	u32 bufs_consumed;		/* buffers this reader has consumed */
+	u32 bytes_consumed;		/* bytes consumed in cur sub-buffer */
+	int offset_changed;		/* have channel offsets changed? */
+	u32 pos;			/* current read offset */
+};
+
+/**
+ *	relay_write_direct - write data directly into destination buffer
+ */
+#define relay_write_direct(DEST, SRC, SIZE) \
+do\
+{\
+   memcpy(DEST, SRC, SIZE);\
+   DEST += SIZE;\
+} while (0);
+
+/**
+ *	relay_lock_channel - lock the relay channel if applicable
+ *
+ *	If the channel usage is SMP, does a local_irq_save.  Otherwise,
+ *	uses spin_lock_irqsave.  FLAGS is initialized to 0 since we know that
+ *	it is being initialized prior to use and we avoid the compiler warning.
+ */
+#define relay_lock_channel(RCHAN, FLAGS) \
+do\
+{\
+   FLAGS = 0;\
+   if (RCHAN->flags & RELAY_USAGE_SMP) local_irq_save(FLAGS); \
+   else spin_lock_irqsave(&(RCHAN)->mode.managed.lock, FLAGS); \
+} while (0);
+
+/**
+ *	relay_unlock_channel - unlock the relay channel if applicable
+ *
+ *	See relay_lock_channel.
+ */
+#define relay_unlock_channel(RCHAN, FLAGS) \
+do\
+{\
+  if (RCHAN->flags & RELAY_USAGE_SMP) local_irq_restore(FLAGS); \
+  else spin_unlock_irqrestore(&(RCHAN)->mode.managed.lock, FLAGS); \
+} while (0);
+
+
+/*
+ * High-level relayfs kernel API, fs/relayfs/relay.c
+ */
+extern struct rchan *
+relay_open(const char *chanpath,
+	   int bufsize,
+	   int nbufs,
+	   u32 flags,
+	   struct rchan_callbacks *channel_callbacks);
+
+extern int
+relay_close(struct rchan *rchan);
+
+extern int
+relay_write(struct rchan *rchan,
+	    const void *data_ptr,
+	    size_t count,
+	    void **wrote_pos);
+
+
+extern struct rchan_reader *
+add_map_reader(struct rchan *rchan);
+
+extern void
+remove_map_reader(struct rchan_reader *reader);
+
+extern int
+rchan_empty(struct rchan_reader *reader);
+
+extern int
+rchan_full(struct rchan_reader *reader);
+
+extern void
+relay_buffers_consumed(struct rchan_reader *reader, u32 buffers_consumed);
+
+/*
+ * Low-level relayfs kernel API, fs/relayfs/relay.c
+ */
+extern void
+rchan_get(struct rchan *rchan);
+
+extern void
+rchan_put(struct rchan *rchan);
+
+extern char *
+relay_reserve(struct rchan *rchan,
+	      u32 data_len,
+	      int *errcode,
+	      int *interrupting);
+
+extern void
+relay_commit(struct rchan *rchan,
+	     char *from,
+	     u32 len,
+	     int reserve_code,
+	     int interrupting);
+
+extern u32
+relay_get_offset(struct rchan *rchan, u32 *max_offset);
+
+extern int
+relay_reset(struct rchan *rchan);
+
+
+/*
+ * Scheme-specific channel ops
+ */
+struct relay_ops
+{
+	char * (*reserve) (struct rchan *rchan,
+			   u32 slot_len,
+			   int * errcode,
+			   int * interrupting);
+
+	void (*commit) (struct rchan *rchan,
+			char *from,
+			u32 len,
+			int deliver,
+			int interrupting);
+
+	u32 (*get_offset) (struct rchan *rchan,
+			   u32 *max_offset);
+
+	void (*finalize) (struct rchan *rchan);
+	void (*reset) (struct rchan *rchan,
+		       int init);
+};
+
+#endif /* _LINUX_RELAYFS_FS_H */
+
