Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262463AbVA1TyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbVA1TyA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 14:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbVA1TyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 14:54:00 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:48023 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262794AbVA1Tif
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 14:38:35 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16890.38062.477373.644205@tut.ibm.com>
Date: Fri, 28 Jan 2005 13:38:22 -0600
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@muc.de>, Roman Zippel <zippel@linux-m68k.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>,
       karim@opersys.com
Subject: [PATCH] relayfs redux, part 2
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch is the result of the latest round of liposuction on relayfs
- the patch size is now 44K, down from 110K and the 200K before that.
I'm posting it as a patch against 2.6.10 rather than -mm in order to
make it easier to review, but will create one for -mm once the changes
have settled down.

The code has been restructured so much that I can't begin to list all
the changes, but here are the main ones:

- replaced the ad-hoc and managed modes with the single algorithm
  suggested by Roman Zippel

- as also suggested by Roman, a relay channel now is really just a
  container that automatically creates and manages a set of per-cpu
  channels

- simplified the API, as suggested by many.  Here's what it currently
  looks like:

    rchan *relay_open(chanpath, bufsize, nbufs, flags, callbacks);
    void relay_close(chan);
    void *relay_reserve(chan, length, cpu);
    unsigned relay_write(chan, data, length);
    void relay_buffers_consumed(chan, bufs_consumed, cpu);
    extern void relay_reset(chan);
    void relay_commit(buffer, subbuf_idx, count);

  helper macros:

    relay_get_buffer(chan, cpu)
    relay_get_padding(buf, subbuf_idx)
    relay_get_commit(buf, subbuf_idx)

  callbacks:

    int buffer_start(buffer, data, prev_subbuf_idx);
    int deliver(buffer, subbuf, prev_subbuf_idx);
    int fileop_notify(buffer, filp, fileop);

I've also made most of the other specific changes people had, but
haven't gotten to them all; I'll incorporate those in the next round.
Thanks to everyone who looked at the code and pointed out problems.

I've tested this code using a hacked version of the kprobes network
packet tracing module that was submitted along with kprobes awhile ago
and it seems to work fine, at least on my single proc test machine.
Below is a link to the test code - at this point it's a real hack just
to test that the basic mechanism works e.g. it doesn't log the padding
or take it out when writing to disk, for instance.  I'll be doing some
SMP stress-testing when I get the chance and once the code settles
down and will clean it up for that.

http://prdownloads.sourceforge.net/dprobes/plog.tar.gz?download


Thanks,

Tom


Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>


 fs/Kconfig                 |   16 
 fs/Makefile                |    1 
 fs/relayfs/Makefile        |    8 
 fs/relayfs/buffers.c       |  136 +++++++
 fs/relayfs/buffers.h       |   14 
 fs/relayfs/inode.c         |  477 ++++++++++++++++++++++++++
 fs/relayfs/relay.c         |  814 +++++++++++++++++++++++++++++++++++++++++++++
 fs/relayfs/relay.h         |   37 ++
 include/linux/relayfs_fs.h |  150 ++++++++
 9 files changed, 1653 insertions(+)


diff -urpN -X dontdiff linux-2.6.10/fs/Kconfig linux-2.6.10-cur/fs/Kconfig
--- linux-2.6.10/fs/Kconfig	2004-12-24 15:34:58.000000000 -0600
+++ linux-2.6.10-cur/fs/Kconfig	2005-01-24 07:58:43.000000000 -0600
@@ -972,6 +972,22 @@ config RAMFS
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
+	  This file system is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module is called relayfs.  If you want to compile it as a
+	  module, say M here and read <file:Documentation/modules.txt>.
+
+	  If unsure, say N.
+
 endmenu
 
 menu "Miscellaneous filesystems"
diff -urpN -X dontdiff linux-2.6.10/fs/Makefile linux-2.6.10-cur/fs/Makefile
--- linux-2.6.10/fs/Makefile	2004-12-24 15:34:58.000000000 -0600
+++ linux-2.6.10-cur/fs/Makefile	2005-01-24 07:58:43.000000000 -0600
@@ -94,3 +94,4 @@ obj-$(CONFIG_AFS_FS)		+= afs/
 obj-$(CONFIG_BEFS_FS)		+= befs/
 obj-$(CONFIG_HOSTFS)		+= hostfs/
 obj-$(CONFIG_HPPFS)		+= hppfs/
+obj-$(CONFIG_RELAYFS_FS)	+= relayfs/
diff -urpN -X dontdiff linux-2.6.10/fs/relayfs/Makefile linux-2.6.10-cur/fs/relayfs/Makefile
--- linux-2.6.10/fs/relayfs/Makefile	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-cur/fs/relayfs/Makefile	2005-01-24 07:58:43.000000000 -0600
@@ -0,0 +1,8 @@
+#
+# relayfs Makefile
+#
+
+obj-$(CONFIG_RELAYFS_FS) += relayfs.o
+
+relayfs-y := relay.o buffers.o inode.o
+
diff -urpN -X dontdiff linux-2.6.10/fs/relayfs/buffers.c linux-2.6.10-cur/fs/relayfs/buffers.c
--- linux-2.6.10/fs/relayfs/buffers.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-cur/fs/relayfs/buffers.c	2005-01-24 09:07:54.000000000 -0600
@@ -0,0 +1,127 @@
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
+#include "buffers.h"
+
+/**
+ *	alloc_page_array - alloc array to hold pages, but not pages
+ *	@size: the total size of the memory represented by the page array
+ *	@page_count: the number of pages the array can hold
+ *
+ *	Returns a pointer to the page array if successful, NULL otherwise.
+ */
+static inline struct page **
+alloc_page_array(int size, int *page_count)
+{
+	int n_pages;
+	struct page **page_array;
+
+	size = PAGE_ALIGN(size);
+	n_pages = size >> PAGE_SHIFT;
+
+	page_array = kcalloc(n_pages, sizeof(struct page *), GFP_KERNEL);
+	if (page_array == NULL)
+		return NULL;
+	*page_count = n_pages;
+
+	return page_array;
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
+
+	*page_array = alloc_page_array(size, page_count);
+	if (!*page_array)
+		return NULL;
+
+	if (populate_page_array(*page_array, *page_count)) {
+		kfree(*page_array);
+		*page_array = NULL;
+		return NULL;
+	}
+
+	mem = vmap(*page_array, *page_count, GFP_KERNEL, PAGE_KERNEL);
+	if (!mem) {
+		depopulate_page_array(*page_array, *page_count);
+		kfree(*page_array);
+		*page_array = NULL;
+		return NULL;
+	}
+	memset(mem, 0, size);
+
+	return mem;
+}
+
+/**
+ *	free_rchan_buf - free a channel buffer
+ *	@buf: pointer to the buffer to free
+ *	@page_array: pointer to the buffer's page array
+ *	@page_count: number of pages in page array
+ */
+void
+free_rchan_buf(void *buf, struct page **page_array, int page_count)
+{
+	vunmap(buf);
+
+	depopulate_page_array(page_array,
+			      page_count);
+	kfree(page_array);
+}
diff -urpN -X dontdiff linux-2.6.10/fs/relayfs/buffers.h linux-2.6.10-cur/fs/relayfs/buffers.h
--- linux-2.6.10/fs/relayfs/buffers.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-cur/fs/relayfs/buffers.h	2005-01-24 07:58:43.000000000 -0600
@@ -0,0 +1,14 @@
+#ifndef _BUFFERS_H
+#define _BUFFERS_H
+
+/* This inspired by rtai/shmem */
+#define FIX_SIZE(x) (((x) - 1) & PAGE_MASK) + PAGE_SIZE
+
+extern void * alloc_rchan_buf(unsigned long size,
+			      struct page ***page_array,
+			      int *page_count);
+extern void free_rchan_buf(void *buf,
+			   struct page **page_array,
+			   int page_count);
+
+#endif/* _BUFFERS_H */
diff -urpN -X dontdiff linux-2.6.10/fs/relayfs/inode.c linux-2.6.10-cur/fs/relayfs/inode.c
--- linux-2.6.10/fs/relayfs/inode.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-cur/fs/relayfs/inode.c	2005-01-24 10:01:51.000000000 -0600
@@ -0,0 +1,450 @@
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
+		inode->i_uid = 0;
+		inode->i_gid = 0;
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
+	if (dentry->d_inode)
+		return -EEXIST;
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
+	retval = relayfs_mknod(dir, dentry, (mode & (S_IRWXUGO | S_ISVTX)) | S_IFDIR, 0);
+
+	if (!retval)
+		dir->i_nlink++;
+	return retval;
+}
+
+static int
+relayfs_create(struct inode *dir, struct dentry *dentry, int mode, struct nameidata *nd)
+{
+	return relayfs_mknod(dir, dentry, (mode & S_IALLUGO) | S_IFREG, 0);
+}
+
+/**
+ *	relayfs_create_entry - create a relayfs directory or file
+ *	@name: the name of the file to create
+ *	@parent: parent directory
+ *	@dentry: result dentry
+ *	@mode: mode
+ *	@data: data to associate with the file
+ *
+ *	Creates a file or directory with the specifed permissions.
+ */
+static int
+relayfs_create_entry(const char * name, struct dentry * parent, struct dentry **dentry, int mode, void * data)
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
+	if (mode & S_IFREG)
+		error = relayfs_create(parent->d_inode, d, mode, NULL);
+	else
+		error = relayfs_mkdir(parent->d_inode, d, mode);
+	if (error)
+		goto release_mount;
+
+	if ((mode & S_IFREG) && data) {
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
+	return relayfs_create_entry(name, parent, dentry, mode | S_IFREG, data);
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
+	return relayfs_create_entry(name, parent, dentry, 
+				    S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO, NULL);
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
+	struct rchan_buf *rchan;
+	int retval = 0;
+
+	if (inode->u.generic_ip) {
+		rchan = inode->u.generic_ip;
+		if (rchan == NULL)
+			return -EACCES;
+		filp->private_data = rchan;
+		retval = rchan->cb->fileop_notify(rchan, filp, RELAY_FILE_OPEN);
+		if (retval == 0)
+			rchan_buffer_get(rchan);
+		else
+			retval = -EPERM;
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
+	struct rchan_buf *rchan = filp->private_data;
+  
+	return __relay_mmap_buffer(rchan, vma);
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
+	struct rchan_buf *rchan;
+	unsigned int mask = 0;
+
+	rchan = filp->private_data;
+
+	if (rchan->finalized)
+		return POLLERR;
+
+	if (filp->f_mode & FMODE_READ) {
+		poll_wait(filp, &rchan->read_wait, wait);
+		if (!rchan_buffer_empty(rchan))
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
+	struct rchan_buf *rchan;
+
+	rchan = filp->private_data;
+	if (rchan == NULL)
+		return 0;
+
+        rchan->cb->fileop_notify(rchan, filp, RELAY_FILE_CLOSE);
+	/* The channel is no longer in use as far as this file is concerned */
+	rchan_buffer_put(rchan);
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
+	inode = relayfs_get_inode(sb, S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO, 0);
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
diff -urpN -X dontdiff linux-2.6.10/fs/relayfs/relay.c linux-2.6.10-cur/fs/relayfs/relay.c
--- linux-2.6.10/fs/relayfs/relay.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-cur/fs/relayfs/relay.c	2005-01-24 10:02:09.000000000 -0600
@@ -0,0 +1,867 @@
+/*
+ * Public API and common code for RelayFS.
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
+#include <asm/local.h>
+
+#include "relay.h"
+#include "buffers.h"
+
+/**
+ *	rchan_buffer_empty - boolean, is the buffer channel empty?
+ *	@chan: channel buffer
+ *
+ *	Returns 1 if the buffer is empty, 0 otherwise.
+ */
+int rchan_buffer_empty(struct rchan_buf *chan)
+{
+	u32 subbufs_ready;
+
+	subbufs_ready = chan->bufs_produced - chan->bufs_consumed;
+
+	return subbufs_ready ? 0 : 1;
+}
+
+/**
+ *	rchan_buffer_full - boolean, is the channel buffer full?
+ *	@buffer: channel buffer
+ *
+ *	Returns 1 if the buffer is full, 0 otherwise.
+ */
+static inline int rchan_buffer_full(struct rchan_buf *buffer)
+{
+	u32 subbufs_ready;
+
+	if (mode_continuous(buffer))
+		return 0;
+
+	subbufs_ready = buffer->bufs_produced - buffer->bufs_consumed;
+
+	return subbufs_ready > buffer->nbufs - 1 ? 1 : 0;
+}
+
+/*
+ * close() vm_op implementation for relayfs file mapping.
+ */
+static void relay_file_mmap_close(struct vm_area_struct *vma)
+{
+	struct file *filp = vma->vm_file;
+	struct rchan_buf *chan = filp->private_data;
+
+	chan->cb->fileop_notify(chan, filp, RELAY_FILE_UNMAP);
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
+static inline unsigned long kvirt_to_pa(unsigned long adr)
+{
+	unsigned long kva, ret;
+
+	kva = (unsigned long) page_address(vmalloc_to_page((void *) adr));
+	kva |= adr & (PAGE_SIZE - 1);
+	ret = __pa(kva);
+	return ret;
+}
+
+static int relay_mmap_region(struct vm_area_struct *vma,
+			     const char *adr,
+			     const char *start_pos,
+			     unsigned long size)
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
+ *	@chan: relay channel buffer
+ *	@vma: vm_area_struct describing memory to be mapped
+ *
+ *	Returns:
+ *	0 if ok
+ *	-EAGAIN, when remap failed
+ *	-EINVAL, invalid requested length
+ *
+ *	Caller should already have grabbed mmap_sem.
+ */
+int __relay_mmap_buffer(struct rchan_buf *chan,
+			struct vm_area_struct *vma)
+{
+	int err = 0;
+	unsigned long length = vma->vm_end - vma->vm_start;
+	struct file *filp = vma->vm_file;
+
+	if (chan == NULL) {
+		err = -EBADF;
+		goto exit;
+	}
+
+	if (length != (unsigned long)chan->alloc_size) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	err = relay_mmap_region(vma,
+				(char *)vma->vm_start,
+				chan->start,
+				chan->alloc_size);
+
+	if (err == 0) {
+		vma->vm_ops = &relay_file_mmap_ops;
+		err = chan->cb->fileop_notify(chan, filp, RELAY_FILE_MAP);
+	}
+exit:
+	return err;
+}
+
+/*
+ * High-level relayfs kernel API and associated functions.
+ */
+
+/*
+ * rchan_callback implementations defining default channel behavior.  Used
+ * in place of corresponding NULL values in client callback struct.
+ */
+
+/*
+ * buffer_start() default callback.  Does nothing.
+ */
+static int buffer_start_default_callback(struct rchan_buf *buffer,
+					 void *subbuf,
+					 unsigned prev_subbuf_idx)
+{
+	return 0;
+}
+
+/*
+ * deliver() default callback.  Does nothing.
+ */
+static void deliver_default_callback (struct rchan_buf *buffer,
+				      void *subbuf,
+				      unsigned subbuf_idx)
+{
+}
+
+/*
+ * fileop_notify() default callback.  Does nothing.
+ */
+static int fileop_notify_default_callback(struct rchan_buf *rchan,
+					  struct file *filp,
+					  enum relay_fileop fileop)
+{
+	return 0;
+}
+
+/* relay channel default callbacks */
+static struct rchan_callbacks default_channel_callbacks = {
+	.buffer_start = buffer_start_default_callback,
+	.deliver = deliver_default_callback,
+	.fileop_notify = fileop_notify_default_callback,
+};
+
+/**
+ *	wakeup_readers - wake up readers waiting on a channel
+ *	@private: the channel buffer
+ *
+ *	This is the work function used to defer reader waking.  The
+ *	reason waking is deferred is that calling directly from write
+ *	causes problems if you're writing from say the scheduler.
+ */
+static void wakeup_readers(void *private)
+{
+	struct rchan_buf *chan = private;
+
+	wake_up_interruptible(&chan->read_wait);
+}
+
+/**
+ *	get_next_buffer - return next sub-buffer within channel buffer
+ *	@buffer: channel buffer
+ */
+static inline void *get_next_buffer(struct rchan_buf *chan)
+{
+	void *next = chan->data + chan->bufsize;
+
+	if (next >= chan->start + chan->bufsize * chan->nbufs)
+		next = chan->start;
+
+	return next;
+}
+
+/**
+ *	rchan_destroy_buf - destroy a channel buffer
+ *	@buffer: the buffer
+ */
+static inline void rchan_destroy_buf(struct rchan_buf *buffer)
+{
+	if (likely(buffer->start))
+		free_rchan_buf(buffer->start,
+			       buffer->page_array,
+			       buffer->page_count);
+}
+
+/**
+ *     remove_rchan_file - remove a channel buffer file
+ *     @private: pointer to the channel buffer struct
+ */
+static inline void remove_rchan_file(void *private)
+{
+	struct rchan_buf *chan = private;
+
+	relayfs_remove_file(chan->dentry);
+	kfree(chan->padding);
+	kfree(chan->commit);
+	kfree(chan);
+}
+
+/**
+ *	relay_release - release a channel buffer
+ *	@chan: the channel
+ *
+ *	Releases a channel buffer, destroys the channel, and removes the
+ *	file from the relayfs filesystem.  Should only be called from
+ *	rchan_buffer_put().  If we're here, it means refcount is 0.
+ */
+static inline void relay_release(struct rchan_buf *chan)
+{
+	rchan_destroy_buf(chan);
+	INIT_WORK(&chan->work, remove_rchan_file, chan);
+	schedule_delayed_work(&chan->work, 1);
+}
+
+/**
+ *	rchan_buffer_put - decrement channel buffer refcount, releasing it if 0
+ *	@chan: the channel buffer
+ */
+void rchan_buffer_put(struct rchan_buf *chan)
+{
+	if (atomic_dec_and_test(&chan->refcount))
+		relay_release(chan);
+}
+
+/**
+ *	rchan_buffer_get - increment channel buffer refcount
+ *	@chan: the channel buffer
+ */
+void rchan_buffer_get(struct rchan_buf *chan)
+{
+	atomic_inc(&chan->refcount);
+}
+
+/**
+ *	__relay_reset - internal reset function
+ *	@chan: the channel buffer
+ *	@init: 1 if this is a first-time initialization
+ *
+ *	See relay_reset for description of effect.
+ */
+static inline void __relay_reset(struct rchan_buf *rchan, int init)
+{
+	int i;
+	
+	if (init) {
+		init_waitqueue_head(&rchan->read_wait);
+		atomic_set(&rchan->refcount, 0);
+	}
+
+	rchan->bufs_produced = 0;
+	rchan->bufs_consumed = 0;
+	rchan->finalized = 0;
+	rchan->data = rchan->start;
+	local_set(&rchan->offset, 0);
+
+	for (i = 0; i < rchan->nbufs; i++) {
+		rchan->padding[i] = 0;
+		rchan->commit[i] = 0;
+	}
+
+	INIT_WORK(&rchan->wake_readers, NULL, NULL);
+}
+
+/**
+ *	relay_reset - reset the channel
+ *	@chan: the channel
+ *
+ *	Returns 0 if successful, negative if not.
+ *
+ *	This has the effect of erasing all data from all channel buffers
+ *	and restarting the channel in its initial state.  The buffers
+ *	are not freed, so any mappings are still in effect.
+ *
+ *	NOTE: Care should be taken that the channel isn't actually
+ *	being used by anything when this call is made.
+ */
+void relay_reset(struct rchan *chan)
+{
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++)
+		if (chan->buffer[i] != NULL)
+			__relay_reset(chan->buffer[i], 0);
+}
+
+/**
+ *	rchan_create_buf - allocate a channel buffer
+ *	@chan: the channel buffer struct
+ *	@size_alloc: the total size of the channel buffer
+ *
+ *	Returns 0 if successful, negative otherwise.
+ */
+static inline int rchan_create_buf(struct rchan_buf *chan, int size_alloc)
+{
+	struct page **page_array;
+	int page_count;
+
+	if ((chan->start = alloc_rchan_buf(size_alloc, &page_array, &page_count)) == NULL) {
+		chan->page_array = NULL;
+		chan->page_count = 0;
+		return -ENOMEM;
+	}
+
+	chan->page_array = page_array;
+	chan->page_count = page_count;
+
+	return 0;
+}
+
+/**
+ *	rchan_create - allocate and initialize a channel buffer struct
+ *	@chanpath: path specifying the relayfs channel file to create
+ *	@bufsize: the size of the sub-buffers within the channel buffer
+ *	@nbufs: the number of sub-buffers within the channel buffer
+ *	@rchan_flags: flags specifying buffer attributes
+ *
+ *	Returns channel buffer if successful, NULL otherwise
+ *
+ *	Allocates a struct rchan_buf representing a relay channel buffer,
+ *	according to the attributes passed in via rchan_flags.
+ */
+static struct rchan_buf *rchan_create(const char *chanpath,
+				      unsigned bufsize,
+				      unsigned nbufs,
+				      u32 rchan_flags)
+{
+	unsigned size_alloc;
+	struct rchan_buf *rchan = NULL;
+
+	rchan = kmalloc(sizeof(struct rchan_buf), GFP_KERNEL);
+	if (rchan == NULL)
+		return NULL;
+	rchan->start = NULL;
+
+	rchan->padding = kmalloc(nbufs * sizeof(unsigned *), GFP_KERNEL);
+	if (rchan->padding == NULL) {
+		kfree(rchan);
+		return NULL;
+	}
+	
+	rchan->commit = kmalloc(nbufs * sizeof(unsigned *), GFP_KERNEL);
+	if (rchan->commit == NULL) {
+		kfree(rchan);
+		kfree(rchan->padding);
+		return NULL;
+	}
+	
+	size_alloc = FIX_SIZE(bufsize * nbufs);
+	rchan->nbufs = nbufs;
+	rchan->bufsize = bufsize;
+
+	if (rchan_create_buf(rchan, size_alloc)) {
+		kfree(rchan->padding);
+		kfree(rchan->commit);
+		kfree(rchan);
+		return NULL;
+	}
+
+	rchan->alloc_size = size_alloc;
+
+	return rchan;
+}
+
+/**
+ *	rchan_create_dir - create directory for relay files
+ *	@chanpath: path to file, including base filename
+ *	@residual: filename remaining after parse
+ *	@topdir: the directory filename should be created in
+ *
+ *	Returns 0 if successful, negative otherwise.
+ *
+ *	Inspired by xlate_proc_name() in procfs.  Given a file path which
+ *	includes the filename, creates any and all directories necessary
+ *	to create the file.
+ */
+static int rchan_create_dir(const char *chanpath,
+			    const char **residual,
+			    struct dentry **topdir)
+{
+	const char *cp = chanpath, *next;
+	struct dentry *parent = NULL;
+	int len, err = 0;
+	char *tmpname = kmalloc(NAME_MAX + 1, GFP_KERNEL);
+
+	if (tmpname == NULL)
+		return -ENOMEM;
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
+		if (err && (err != -EEXIST)) {
+			kfree(tmpname);
+			return err;
+		}
+		cp += len + 1;
+	}
+
+	*residual = cp;
+	*topdir = parent;
+
+	kfree(tmpname);
+
+	return err;
+}
+
+/**
+ *	rchan_create_file - create relay file, including parent directories
+ *	@chanpath: path to file, including filename
+ *	@dentry: result dentry
+ *	@data: data to associate with the file
+ *
+ *	Returns 0 if successful, negative otherwise.
+ */
+static inline int rchan_create_file(const char *chanpath,
+				    struct dentry **dentry,
+				    struct rchan_buf *data)
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
+ *	check_attribute_flags - check sanity of channel attributes
+ *	@flags: channel attributes
+ *
+ *	Returns 0 if successful, negative otherwise.
+ */
+static inline int check_attribute_flags(u32 *attribute_flags)
+{
+	u32 flags = *attribute_flags;
+
+	if ((flags & RELAY_MODE_CONTINUOUS) &&
+	    (flags & RELAY_MODE_NO_OVERWRITE))
+		return -EINVAL; /* Can't have it both ways */
+
+	if (!(flags & RELAY_MODE_CONTINUOUS) &&
+	    !(flags & RELAY_MODE_NO_OVERWRITE))
+		*attribute_flags |= RELAY_MODE_CONTINUOUS; /* Default */
+
+	return 0;
+}
+
+/**
+ *	relay_open_buffer - create a new channel buffer in relayfs
+ *
+ *	Internal - used by relay_open().
+ */
+static struct rchan_buf *relay_open_buffer(const char *chanpath,
+					   unsigned bufsize,
+					   unsigned nbufs,
+					   u32 flags,
+					   struct rchan_callbacks *channel_callbacks)
+{
+	struct rchan_buf *buffer;
+	struct dentry *dentry;
+	struct rchan_callbacks *callbacks = NULL;
+
+	buffer = rchan_create(chanpath, bufsize, nbufs, flags);
+	if (buffer == NULL)
+		return NULL;
+
+	/* Create file in fs */
+	if (rchan_create_file(chanpath, &dentry, buffer) < 0) {
+		rchan_destroy_buf(buffer);
+		kfree(buffer);
+		return NULL;
+	}
+
+	buffer->dentry = dentry;
+
+	if (channel_callbacks == NULL)
+		callbacks = &default_channel_callbacks;
+	else
+		callbacks = channel_callbacks;
+	if (callbacks->buffer_start == NULL)
+		callbacks->buffer_start = buffer_start_default_callback;
+	if (callbacks->deliver == NULL)
+		callbacks->deliver = deliver_default_callback;
+	if (callbacks->fileop_notify == NULL)
+		callbacks->fileop_notify = fileop_notify_default_callback;
+	buffer->cb = callbacks;
+
+	buffer->flags = flags;
+
+	__relay_reset(buffer, 1);
+
+	rchan_buffer_get(buffer);
+
+	return buffer;
+}
+
+static void relay_close_buffer(struct rchan_buf *buffer);
+
+/**
+ *	relay_open - create a new relayfs channel
+ *	@chanpath: base name of files to create, including path
+ *	@bufsize: size of sub-buffers
+ *	@nbufs: number of sub-buffers
+ *	@flags: channel attributes
+ *	@callbacks: client callback functions
+ *
+ *	Returns channel pointer if successful, NULL otherwise.
+ *
+ *	Creates a channel buffer for each cpu using the sizes and
+ *	attributes specified. File permissions are S_IRUSR | S_IWUSR.
+ */
+struct rchan *relay_open(const char *chanpath,
+			 unsigned bufsize,
+			 unsigned nbufs,
+			 u32 flags,
+			 struct rchan_callbacks *callbacks)
+{
+	int i;
+	struct rchan *chan;
+	char *tmpname;
+
+	if (chanpath == NULL)
+		return NULL;
+
+	if (check_attribute_flags(&flags))
+		return NULL;
+
+	chan = kcalloc(1, sizeof(struct rchan), GFP_KERNEL);
+	if (chan == NULL)
+		return NULL;
+
+	chan->version = RELAYFS_CHANNEL_VERSION;
+
+	if (nbufs == 0)
+		nbufs = RELAY_DEFAULT_NBUFS;
+	if (bufsize == 0)
+		bufsize = RELAY_DEFAULT_BUFSIZE;
+
+	tmpname = kmalloc(NAME_MAX + 1, GFP_KERNEL);
+	if (tmpname == NULL)
+		goto free_chan;
+
+	for_each_online_cpu(i) {
+		sprintf(tmpname, "%s%d", chanpath, i);
+		chan->buffer[i] = relay_open_buffer(tmpname, bufsize, nbufs,
+						    flags, callbacks);
+		if (chan->buffer[i] == NULL)
+			goto free_buffers;
+	}
+
+	kfree(tmpname);
+	return chan;
+	
+free_buffers:
+	for (i = 0; i < NR_CPUS; i++)
+		if (chan->buffer[i] != NULL)
+			relay_close_buffer(chan->buffer[i]);
+	kfree(tmpname);
+
+free_chan:
+	kfree(chan);
+		
+	return NULL;
+}
+
+
+/**
+ *	deliver_check - deliver a guaranteed full sub-buffer if applicable
+ */
+static inline void deliver_check(struct rchan_buf *buffer,
+				 unsigned subbuf_idx)
+{
+	unsigned full;
+	void *subbuf;
+
+	full = buffer->bufsize - buffer->padding[subbuf_idx];
+
+	if (buffer->commit[subbuf_idx] == full) {
+		subbuf = buffer->start + subbuf_idx * buffer->bufsize;
+		buffer->cb->deliver(buffer, subbuf, subbuf_idx);
+	}
+}
+
+/**
+ *	relay_switch_buffer - slow path of relay_reserve()
+ *
+ *	Returns pointer to the switched buffer, NULL if full.
+ */
+static struct rchan_buf *relay_switch_buffer(struct rchan_buf *buffer,
+					     unsigned offset,
+					     unsigned length)
+{
+	unsigned long flags;
+	unsigned padding = buffer->bufsize - offset;
+	unsigned cur_subbuf, prev_subbuf, count = 0;
+
+	local_irq_save(flags);
+	
+	if (unlikely(rchan_buffer_full(buffer))) {
+		local_irq_restore(flags);
+		return NULL;
+	}
+
+	if (unlikely(local_read(&buffer->offset) + length < buffer->bufsize)) {
+		local_irq_restore(flags);
+		return buffer;
+	}
+
+	cur_subbuf = prev_subbuf = buffer->bufs_produced % buffer->nbufs;
+	buffer->padding[cur_subbuf] = padding;
+
+	buffer->bufs_produced++;
+
+	if (waitqueue_active(&buffer->read_wait)) {
+		PREPARE_WORK(&buffer->wake_readers, wakeup_readers, buffer);
+		schedule_delayed_work(&buffer->wake_readers, 1);
+	}
+
+	if (unlikely(rchan_buffer_full(buffer))) {
+		local_irq_restore(flags);
+		return NULL;
+	}
+
+	buffer->data = get_next_buffer(buffer);
+	cur_subbuf = buffer->bufs_produced % buffer->nbufs;
+	buffer->padding[cur_subbuf] = buffer->commit[cur_subbuf] = 0;
+	count = buffer->cb->buffer_start(buffer, buffer->data, prev_subbuf);
+	deliver_check(buffer, prev_subbuf);
+
+	local_set(&buffer->offset, count);
+ 
+	local_irq_restore(flags);
+ 
+	return buffer;
+}
+
+/**
+ *	local_add_return - atomic add returning previous value
+ */
+static inline unsigned long local_add_return(local_t *offset, unsigned long length)
+{
+	unsigned long prev, flags;
+	
+	local_irq_save(flags);
+	prev = local_read(offset);
+	local_add(length, offset);
+	local_irq_restore(flags);
+
+	return prev;
+}
+
+/**
+ *	relay_reserve - atomically reserve a slot in the channel
+ *	@chan: relay channel
+ *	@length: number of bytes to reserve
+ *	@cpu: reserve in the given cpu's channel buffer
+ *
+ *	Returns a pointer to the reserved slot, NULL on failure.
+ */
+void *relay_reserve(struct rchan *chan,
+		    unsigned length,
+		    int cpu)
+{
+	unsigned offset;
+	struct rchan_buf *buffer;
+
+	buffer = relay_get_buffer(chan, cpu);
+	
+	while(1) {
+		offset = local_add_return(&buffer->offset, length);
+		if (likely(offset + length <= buffer->bufsize))
+			break;
+		buffer = relay_switch_buffer(buffer, offset, length);
+		if (buffer == NULL)
+			return NULL;
+	}
+	
+	return buffer->data + offset;
+}
+
+
+/**
+ *	relay_commit - add count bytes to a sub-buffer's commit count
+ *	@buffer: relay channel buffer
+ *	@subbuf_idx: sub-buffer index to add to
+ *	@count: number of bytes committed
+ *
+ *	Invokes deliver() callback if sub-buffer is completely written
+ */
+void relay_commit(struct rchan_buf *buffer,
+		  unsigned subbuf_idx,
+		  unsigned count)
+{
+	if (subbuf_idx >= buffer->nbufs)
+		return;
+	
+	buffer->commit[subbuf_idx] += count;
+
+	deliver_check(buffer, subbuf_idx);
+}
+
+/**
+ *	relay_write - write data into the channel
+ *	@chan: relay channel
+ *	@data: data to be written into reserved slot
+ *	@length: number of bytes to write
+ *
+ *	Returns the number of bytes written, 0 or negative on failure.
+ *
+ *	Writes data into the current cpu's channel buffer
+ */
+unsigned relay_write(struct rchan *chan,
+		     const void *data,
+		     unsigned length)
+{
+	int cpu;
+	char *reserved;
+	unsigned count = 0;
+
+	cpu = get_cpu();
+
+	reserved = relay_reserve(chan, length, cpu);
+	if(reserved) {
+		memcpy(reserved, data, length);
+		count = length;
+	}
+
+	put_cpu();
+ 
+	return count;
+}
+
+/**
+ *	relay_buffers_consumed - update the buffer's sub-buffers-consumed count
+ *	@chan: channel buffer
+ *	@bufs_consumed: number of sub-buffers to add to current buffer's count
+ *
+ *	Adds to the channel buffer's consumed buffer count.  buffers_consumed
+ *	should be the number of buffers newly consumed, not the total consumed.
+ *
+ *	NOTE: kernel clients don't need to call this function if the channel
+ *	is MODE_CONTINUOUS.
+ */
+void relay_buffers_consumed(struct rchan *chan, unsigned bufs_consumed, int cpu)
+{
+	struct rchan_buf *buffer = relay_get_buffer(chan, cpu);
+
+	buffer->bufs_consumed += bufs_consumed;
+
+	if (buffer->bufs_consumed > buffer->bufs_produced)
+		buffer->bufs_consumed = buffer->bufs_produced;
+}
+
+/**
+ *	relay_close_buffer - close the channel buffer
+ *	@buffer: channel buffer
+ *
+ *	Finalizes the last sub-buffer and marks the buffer as finalized.
+ *	The channel buffer and channel buffer data structure are then freed
+ *	automatically when the last reference is given up.
+ */
+static void relay_close_buffer(struct rchan_buf *buffer)
+{
+	unsigned offset = local_read(&buffer->offset);
+	relay_switch_buffer(buffer, offset, buffer->bufsize);
+	buffer->finalized = 1;
+	buffer->cb = &default_channel_callbacks;
+
+	rchan_buffer_put(buffer);
+}
+
+/**
+ *	relay_close - close the channel
+ *	@rchan_id: relay channel id
+ *
+ *	Closes all channel buffers and frees the channel.
+ */
+void relay_close(struct rchan *chan)
+{
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++)
+		if (chan->buffer[i] != NULL)
+			relay_close_buffer(chan->buffer[i]);
+	
+	kfree(chan);
+}
+
+EXPORT_SYMBOL_GPL(relay_open);
+EXPORT_SYMBOL_GPL(relay_close);
+EXPORT_SYMBOL_GPL(relay_reset);
+EXPORT_SYMBOL_GPL(relay_write);
+EXPORT_SYMBOL_GPL(relay_reserve);
+EXPORT_SYMBOL_GPL(relay_commit);
+EXPORT_SYMBOL_GPL(relay_buffers_consumed);
diff -urpN -X dontdiff linux-2.6.10/fs/relayfs/relay.h linux-2.6.10-cur/fs/relayfs/relay.h
--- linux-2.6.10/fs/relayfs/relay.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-cur/fs/relayfs/relay.h	2005-01-24 07:58:43.000000000 -0600
@@ -0,0 +1,37 @@
+/*
+ * fs/relayfs/relay.h
+ *
+ * Copyright (C) 1999-2005 - Karim Yaghmour (karim@opersys.com), Opersys inc.
+ * Copyright (C) 2002, 2003 - Tom Zanussi (zanussi@us.ibm.com), IBM Corp
+ *
+ * RelayFS internal definitions and declarations
+ */
+
+#ifndef _RELAY_H
+#define _RELAY_H
+
+/*
+ * Internal relayfs kernel API, fs/relayfs/relay.c
+ */
+
+#define mode_continuous(rchan) (((rchan)->flags & RELAY_MODE_CONTINUOUS) ? 1 : 0)
+
+extern int __relay_mmap_buffer(struct rchan_buf *rchan,
+			       struct vm_area_struct *vma);
+
+extern int relayfs_create_dir(const char *name,
+			      struct dentry *parent,
+			      struct dentry **dentry);
+
+extern int relayfs_create_file(const char * name,
+			       struct dentry *parent,
+			       struct dentry **dentry,
+			       void * data,
+			       int mode);
+
+extern int relayfs_remove_file(struct dentry *dentry);
+extern void rchan_buffer_get(struct rchan_buf *rchan);
+extern void rchan_buffer_put(struct rchan_buf *rchan);
+extern int rchan_buffer_empty(struct rchan_buf *chan);
+
+#endif /* _RELAY_H */
diff -urpN -X dontdiff linux-2.6.10/include/linux/relayfs_fs.h linux-2.6.10-cur/include/linux/relayfs_fs.h
--- linux-2.6.10/include/linux/relayfs_fs.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-cur/include/linux/relayfs_fs.h	2005-01-24 10:02:32.000000000 -0600
@@ -0,0 +1,157 @@
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
+#include <asm/local.h>
+
+/*
+ * Tracks changes to rchan_buf struct
+ */
+#define RELAYFS_CHANNEL_VERSION		3
+
+/*
+ * Relay properties
+ */
+#define RELAY_DEFAULT_BUFSIZE		4096
+#define RELAY_DEFAULT_NBUFS		4
+
+/*
+ * Relay attribute flags
+ */
+#define RELAY_MODE_CONTINUOUS		0x1
+#define RELAY_MODE_NO_OVERWRITE		0x2
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
+ * Per-cpu relay channel buffer
+ */
+struct rchan_buf
+{
+	void *start;			/* start of channel buffer */
+	void *data;			/* start of current sub-buffer */
+	local_t offset;			/* current offset into sub-buffer */
+	unsigned bufsize;		/* sub-buffer size */
+	unsigned alloc_size;		/* total buffer size allocated */
+	unsigned nbufs;			/* number of sub-buffers */
+	unsigned bufs_produced;		/* count of sub-buffers produced */
+	unsigned bufs_consumed;		/* count of sub-buffers consumed */
+	wait_queue_head_t read_wait;	/* reader wait queue */
+	struct work_struct wake_readers; /* reader wake-up work struct */
+	struct rchan_callbacks *cb;	/* client callbacks */
+	struct work_struct work;	/* remove file work struct */
+	u32 flags;			/* relay channel attributes */
+	struct dentry *dentry;		/* channel file dentry */
+	atomic_t refcount;		/* channel refcount */
+	struct page **page_array;	/* array of current buffer pages */
+	int page_count;			/* number of current buffer pages */
+	unsigned *padding;		/* padding counts per sub-buffer */
+	unsigned *commit;		/* commit counts per sub-buffer */
+	int finalized;			/* buffer has been finalized */
+} ____cacheline_aligned;
+
+/*
+ * Relay channel data structure
+ */
+struct rchan
+{
+	u32 version;			/* the version of this struct */
+	struct rchan_buf *buffer[NR_CPUS]; /* per-cpu channel buffers */
+};
+
+/*
+ * Relay channel client callbacks
+ */
+struct rchan_callbacks
+{
+	/*
+	 * buffer_start - called on buffer-switch to a new sub-buffer
+	 * @buffer: the channel buffer containing the new sub-buffer
+	 * @data: the start of the new sub-buffer
+	 * @prev_subbuf_idx: the previous sub-buffer's index
+	 *
+	 */
+	int (*buffer_start) (struct rchan_buf *buffer,
+			     void *subbuf,
+			     unsigned prev_subbuf_idx);
+
+	/*
+	 * deliver - deliver a guaranteed full sub-buffer to client
+	 * @buffer: the channel buffer containing the sub-buffer
+	 * @data: the start of the new sub-buffer
+	 * @subbuf_idx: the sub-buffer's index
+	 *
+	 * Only works if relay_commit is also used
+	 */
+	void (*deliver) (struct rchan_buf *buffer,
+			 void *subbuf,
+			 unsigned subbuf_idx);
+
+	/*
+	 * fileop_notify - called on open/close/mmap/munmap of a relayfs file
+	 * @chan: the channel channel buffer
+	 * @filp: relayfs file pointer
+	 * @fileop: which file operation is in progress
+	 *
+	 * The return value can direct the outcome of the operation.
+	 */
+        int (*fileop_notify)(struct rchan_buf *rchan,
+			     struct file *filp,
+			     enum relay_fileop fileop);
+};
+
+/*
+ * relayfs kernel API, fs/relayfs/relay.c
+ */
+
+#define relay_get_buffer(chan, cpu)	(chan->buffer[cpu])
+#define relay_get_padding(buf, subbuf_idx)	(buf->padding[subbuf_idx])
+#define relay_get_commit(buf, subbuf_idx)	(buf->commit[subbuf_idx])
+
+extern struct rchan *relay_open(const char *chanpath,
+				unsigned bufsize,
+				unsigned nbufs,
+				u32 flags,
+				struct rchan_callbacks *callbacks);
+extern void relay_close(struct rchan *chan);
+extern void *relay_reserve(struct rchan *chan,
+			   unsigned length,
+			   int cpu);
+extern void relay_commit(struct rchan_buf *buffer,
+			 unsigned subbuf_idx,
+			 unsigned count);
+extern unsigned relay_write(struct rchan *chan,
+			    const void *data,
+			    unsigned length);
+extern void relay_buffers_consumed(struct rchan *chan,
+				   unsigned bufs_consumed,
+				   int cpu);
+extern void relay_reset(struct rchan *chan);
+
+#endif /* _LINUX_RELAYFS_FS_H */
+

-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

