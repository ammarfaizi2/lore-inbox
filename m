Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVBDUep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVBDUep (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 15:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266710AbVBDUdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 15:33:21 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:50637 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S266446AbVBDURx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 15:17:53 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16899.55393.651042.627079@tut.ibm.com>
Date: Fri, 4 Feb 2005 14:17:37 -0600
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@muc.de>, Roman Zippel <zippel@linux-m68k.org>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>,
       karim@opersys.com
Subject: [PATCH] relayfs redux, part 3
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's the latest version of relayfs, against 2.6.10.  It includes a
bunch of cleanup and restructuring prompted by the previous round of
comments, but the major change that people would care about would
probably be the changes to the logging functions relay_write(),
__relay_write(), and relay_reserve().  They've been rewritten to be
more efficient, or so I hope - I'm sure I'll hear about how they
should be improved for the next version in any case. ;-) Thanks to
everyone who commented on the previous version.

This is what the API currently looks like:

    rchan *relay_open(chanpath, subbuf_size, n_subbufs, flags, callbacks);
    void relay_close(chan);
    unsigned relay_write(chan, data, length);
    unsigned __relay_write(chan, data, length);
    void *relay_reserve(chan, length);
    void relay_subbufs_consumed(chan, subbufs_consumed, cpu);
    extern void relay_reset(chan);
    void relay_commit(buf, subbuf_idx, count);

  helper macros:

    relay_get_buffer(chan, cpu)
    relay_get_padding(buf, subbuf_idx)
    relay_get_commit(buf, subbuf_idx)

  callbacks:

    int subbuf_start(buf, subbuf, prev_subbuf_idx);
    int deliver(buffer, subbuf, subbuf_idx);
    int fileop_notify(buf, filp, fileop);

As before, I've tested this code on a single proc machine using a
hacked version of the kprobes network packet tracing module, which can
be found here:

http://prdownloads.sourceforge.net/dprobes/plog.tar.gz?download

Once everyone's more or less happy with the API and implementation,
I'll do some SMP testing and write some Documentation.

Thanks,

Tom


Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>


 fs/Kconfig                 |   12 
 fs/Makefile                |    1 
 fs/relayfs/Makefile        |    8 
 fs/relayfs/buffers.c       |  124 ++++++++
 fs/relayfs/buffers.h       |   14 
 fs/relayfs/inode.c         |  481 +++++++++++++++++++++++++++++++++
 fs/relayfs/relay.c         |  653 +++++++++++++++++++++++++++++++++++++++++++++
 fs/relayfs/relay.h         |   34 ++
 include/linux/relayfs_fs.h |  239 ++++++++++++++++
 9 files changed, 1566 insertions(+)


diff -urpN -X dontdiff linux-2.6.10/fs/Kconfig linux-2.6.10-cur/fs/Kconfig
--- linux-2.6.10/fs/Kconfig	2004-12-24 15:34:58.000000000 -0600
+++ linux-2.6.10-cur/fs/Kconfig	2005-01-29 09:09:52.000000000 -0600
@@ -972,6 +972,18 @@ config RAMFS
 	  To compile this as a module, choose M here: the module will be called
 	  ramfs.
 
+config RELAYFS_FS
+	tristate "Relayfs file system support"
+	---help---
+	  Relayfs is a high-speed data relay filesystem designed to provide
+	  an efficient mechanism for tools and facilities to relay large
+	  amounts of data from kernel space to user space.
+
+	  To compile this code as a module, choose M here: the module will be
+	  called relayfs.
+
+	  If unsure, say N.
+
 endmenu
 
 menu "Miscellaneous filesystems"
diff -urpN -X dontdiff linux-2.6.10/fs/Makefile linux-2.6.10-cur/fs/Makefile
--- linux-2.6.10/fs/Makefile	2004-12-24 15:34:58.000000000 -0600
+++ linux-2.6.10-cur/fs/Makefile	2005-01-25 08:40:23.000000000 -0600
@@ -94,3 +94,4 @@ obj-$(CONFIG_AFS_FS)		+= afs/
 obj-$(CONFIG_BEFS_FS)		+= befs/
 obj-$(CONFIG_HOSTFS)		+= hostfs/
 obj-$(CONFIG_HPPFS)		+= hppfs/
+obj-$(CONFIG_RELAYFS_FS)	+= relayfs/
diff -urpN -X dontdiff linux-2.6.10/fs/relayfs/Makefile linux-2.6.10-cur/fs/relayfs/Makefile
--- linux-2.6.10/fs/relayfs/Makefile	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-cur/fs/relayfs/Makefile	2005-01-25 08:40:23.000000000 -0600
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
+++ linux-2.6.10-cur/fs/relayfs/buffers.c	2005-01-31 20:31:50.000000000 -0600
@@ -0,0 +1,124 @@
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
+static inline struct page **alloc_page_array(int size, int *page_count)
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
+static void depopulate_page_array(struct page **page_array, int page_count)
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
+static int populate_page_array(struct page **page_array, int page_count)
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
+ *	relay_alloc_rchan_buf - allocate a channel buffer
+ *	@size: total size of the buffer
+ *	@page_array: receives a pointer to the buffer's page array
+ *	@page_count: receives the number of pages allocated
+ *
+ *	Returns a pointer to the resulting buffer, NULL if unsuccessful
+ */
+void *relay_alloc_rchan_buf(unsigned long size, struct page ***page_array,
+			    int *page_count)
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
+ *	relay_free_rchan_buf - free a channel buffer
+ *	@buf: pointer to the buffer to free
+ *	@page_array: pointer to the buffer's page array
+ *	@page_count: number of pages in page array
+ */
+void relay_free_rchan_buf(void *buf, struct page **page_array,
+			  int page_count)
+{
+	vunmap(buf);
+
+	depopulate_page_array(page_array,
+			      page_count);
+	kfree(page_array);
+}
diff -urpN -X dontdiff linux-2.6.10/fs/relayfs/buffers.h linux-2.6.10-cur/fs/relayfs/buffers.h
--- linux-2.6.10/fs/relayfs/buffers.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-cur/fs/relayfs/buffers.h	2005-01-31 20:31:22.000000000 -0600
@@ -0,0 +1,14 @@
+#ifndef _BUFFERS_H
+#define _BUFFERS_H
+
+/* This inspired by rtai/shmem */
+#define FIX_SIZE(x) (((x) - 1) & PAGE_MASK) + PAGE_SIZE
+
+extern void *relay_alloc_rchan_buf(unsigned long size,
+				   struct page ***page_array,
+				   int *page_count);
+extern void relay_free_rchan_buf(void *buf,
+				 struct page **page_array,
+				 int page_count);
+
+#endif/* _BUFFERS_H */
diff -urpN -X dontdiff linux-2.6.10/fs/relayfs/inode.c linux-2.6.10-cur/fs/relayfs/inode.c
--- linux-2.6.10/fs/relayfs/inode.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-cur/fs/relayfs/inode.c	2005-01-31 21:14:48.000000000 -0600
@@ -0,0 +1,481 @@
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
+#include <asm/uaccess.h>
+#include "relay.h"
+
+#define RELAYFS_MAGIC			0x26F82121
+
+static struct vfsmount *		relayfs_mount;
+static int				relayfs_mount_count;
+
+static struct backing_dev_info		relayfs_backing_dev_info = {
+	.ra_pages	= 0,	/* No readahead */
+	.memory_backed	= 1,	/* Does not contribute to dirty memory */
+};
+
+static struct inode *relayfs_get_inode(struct super_block *sb, int mode,
+				       dev_t dev)
+{
+	struct inode * inode = new_inode(sb);
+
+	if (inode) {
+		inode->i_mode = mode;
+		inode->i_uid = 0;
+		inode->i_gid = 0;
+		inode->i_blksize = PAGE_CACHE_SIZE;
+		inode->i_blocks = 0;
+		inode->i_mapping->backing_dev_info = &relayfs_backing_dev_info;
+		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+		switch (mode & S_IFMT) {
+		case S_IFREG:
+			inode->i_fop = &relayfs_file_operations;
+			break;
+		case S_IFDIR:
+			inode->i_op = &simple_dir_inode_operations;
+			inode->i_fop = &simple_dir_operations;
+
+			/* directory inodes start off with i_nlink == 2 (for "." entry) */
+			inode->i_nlink++;
+			break;
+		default:
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
+static int relayfs_mknod(struct inode *dir, struct dentry *dentry, int mode,
+			 dev_t dev)
+{
+	int error = -ENOSPC;
+	struct inode * inode = relayfs_get_inode(dir->i_sb, mode, dev);
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
+static int relayfs_mkdir(struct inode * dir, struct dentry * dentry, int mode)
+{
+	int retval;
+
+	mode = (mode & (S_IRWXUGO | S_ISVTX)) | S_IFDIR;
+	retval = relayfs_mknod(dir, dentry, mode, 0);
+	if (!retval)
+		dir->i_nlink++;
+	return retval;
+}
+
+static int relayfs_create(struct inode *dir, struct dentry *dentry, int mode,
+			  struct nameidata *nd)
+{
+	mode = (mode & S_IALLUGO) | S_IFREG;
+	return relayfs_mknod(dir, dentry, mode, 0);
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
+static int relayfs_create_entry(const char * name, struct dentry * parent,
+				struct dentry **dentry, int mode, void * data)
+{
+	struct qstr qname;
+	struct dentry *d;
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
+	if ((mode & S_IFREG) && data)
+		d->d_inode->u.generic_ip = data;
+
+	goto exit;
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
+ *	@mode: mode, if not specied the default perms are used
+ *
+ *	The file will be created user rw on behalf of current user.
+ */
+int relayfs_create_file(const char * name, struct dentry * parent,
+			struct dentry **dentry, void * data, int mode)
+{
+	if (!mode)
+		mode = S_IRUSR | S_IWUSR;
+	mode |= S_IFREG;
+	return relayfs_create_entry(name, parent, dentry, mode, data);
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
+int relayfs_create_dir(const char * name, struct dentry * parent,
+		       struct dentry **dentry)
+{
+	int mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
+	return relayfs_create_entry(name, parent, dentry, mode, NULL);
+}
+
+/**
+ *	relayfs_remove_file - remove a file in the relay filesystem
+ *	@dentry: file dentry
+ *
+ *	Remove a file previously created by relayfs_create_file.
+ */
+int relayfs_remove_file(struct dentry *dentry)
+{
+	struct dentry *parent = dentry->d_parent;
+
+	if (parent == NULL)
+		return -EINVAL;
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
+	simple_release_fs(&relayfs_mount, &relayfs_mount_count);
+
+	return 0;
+}
+
+/**
+ *	relayfs_create_dirs - create directories for relay files
+ *	@chanpath: path to file, including base filename
+ *	@residual: filename remaining after parse
+ *	@topdir: the last directory successully created, NULL if none created
+ *
+ *	Returns 0 if successful, negative otherwise.
+ *
+ *	Inspired by xlate_proc_name() in procfs.  Given a file path which
+ *	includes the filename, creates any and all directories necessary
+ *	to create the file.
+ */
+int relayfs_create_dirs(const char *chanpath, const char **residual,
+			struct dentry **topdir)
+{
+	const char *cp = chanpath, *next;
+	struct dentry *parent = NULL;
+	int len, err = 0;
+	char *tmpname = kmalloc(NAME_MAX + 1, GFP_KERNEL);
+
+	*topdir = parent;
+
+	if (tmpname == NULL)
+		return -ENOMEM;
+
+	if (*chanpath == '/')
+		return -EINVAL;
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
+		*topdir = parent;
+		cp += len + 1;
+	}
+
+	*residual = cp;
+
+	kfree(tmpname);
+
+	return err;
+}
+
+/**
+ *	relayfs_remove_dirs - remove directories created for relay files
+ *	@dir: the top directory to remove
+ *
+ *	Removes dir and alldirectories below it, if empty
+ */
+void relayfs_remove_dirs(struct dentry *dir)
+{
+	struct dentry *parent;
+	
+	while (dir != NULL)
+	{
+		if (!simple_empty(dir))
+			break;
+
+		parent = dir->d_parent;
+
+		if (!(relayfs_mount && relayfs_mount->mnt_sb))
+			break;
+		if (dir == relayfs_mount->mnt_sb->s_root)
+			break;
+		
+		relayfs_remove_file(dir);
+		dir = parent;
+	}
+}
+
+/**
+ *	relayfs_open - open file op for relayfs files
+ *	@inode: the inode
+ *	@filp: the file
+ *
+ *	Associates the channel buffer with the file, and increments the
+ *	channel buffer refcount.
+ */
+int relayfs_open(struct inode *inode, struct file *filp)
+{
+	struct rchan_buf *buf;
+	int retval = 0;
+
+	if (inode->u.generic_ip) {
+		buf = inode->u.generic_ip;
+		if (buf == NULL)
+			return -EACCES;
+		filp->private_data = buf;
+		retval = buf->chan->cb->fileop_notify(buf, filp, RELAY_FILE_OPEN);
+		if (retval == 0)
+			kref_get(&buf->kref);
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
+int relayfs_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct rchan_buf *buf = filp->private_data;
+  
+	return relay_mmap_buffer(buf, vma);
+}
+
+/**
+ *	relayfs_poll - poll file op for relayfs files
+ *	@filp: the file
+ *	@wait: poll table
+ *
+ *	Poll implemention.
+ */
+unsigned int relayfs_poll(struct file *filp, poll_table *wait)
+{
+	unsigned int mask = 0;
+	struct rchan_buf *buf = filp->private_data;
+
+	if (buf->finalized)
+		return POLLERR;
+
+	if (filp->f_mode & FMODE_READ) {
+		poll_wait(filp, &buf->read_wait, wait);
+		if (!relay_buf_empty(buf))
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
+int relayfs_release(struct inode *inode, struct file *filp)
+{
+	struct rchan_buf *buf = filp->private_data;
+	if (buf == NULL)
+		return 0;
+
+        buf->chan->cb->fileop_notify(buf, filp, RELAY_FILE_CLOSE);
+	kref_put(&buf->kref, relay_destroy_buf);
+
+	return 0;
+}
+
+struct file_operations relayfs_file_operations = {
+	.open		= relayfs_open,
+	.poll		= relayfs_poll,
+	.mmap		= relayfs_mmap,
+	.release	= relayfs_release,
+};
+
+static struct super_operations relayfs_ops = {
+	.statfs		= simple_statfs,
+	.drop_inode	= generic_delete_inode,
+};
+
+static int relayfs_fill_super(struct super_block * sb, void * data, int silent)
+{
+	struct inode * inode;
+	struct dentry * root;
+	int mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
+
+	sb->s_blocksize = PAGE_CACHE_SIZE;
+	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
+	sb->s_magic = RELAYFS_MAGIC;
+	sb->s_op = &relayfs_ops;
+	inode = relayfs_get_inode(sb, mode, 0);
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
+static struct super_block * relayfs_get_sb(struct file_system_type *fs_type,
+					   int flags, const char *dev_name,
+					   void *data)
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
+static int __init init_relayfs_fs(void)
+{
+	int err = register_filesystem(&relayfs_fs_type);
+	return err;
+}
+
+static void __exit exit_relayfs_fs(void)
+{
+	unregister_filesystem(&relayfs_fs_type);
+}
+
+module_init(init_relayfs_fs)
+module_exit(exit_relayfs_fs)
+
+EXPORT_SYMBOL_GPL(relayfs_open);
+EXPORT_SYMBOL_GPL(relayfs_poll);
+EXPORT_SYMBOL_GPL(relayfs_mmap);
+EXPORT_SYMBOL_GPL(relayfs_release);
+EXPORT_SYMBOL_GPL(relayfs_file_operations);
+
+MODULE_AUTHOR("Tom Zanussi <zanussi@us.ibm.com> and Karim Yaghmour <karim@opersys.com>");
+MODULE_DESCRIPTION("Relay Filesystem");
+MODULE_LICENSE("GPL");
+
diff -urpN -X dontdiff linux-2.6.10/fs/relayfs/relay.c linux-2.6.10-cur/fs/relayfs/relay.c
--- linux-2.6.10/fs/relayfs/relay.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-cur/fs/relayfs/relay.c	2005-01-31 21:15:04.000000000 -0600
@@ -0,0 +1,653 @@
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
+ *	relay_buf_empty - boolean, is the channel buffer empty?
+ *	@buf: channel buffer
+ *
+ *	Returns 1 if the buffer is empty, 0 otherwise.
+ */
+int relay_buf_empty(struct rchan_buf *buf)
+{
+	int produced = atomic_read(&buf->subbufs_produced);
+	int consumed = atomic_read(&buf->subbufs_consumed);
+
+	return (produced - consumed) ? 0 : 1;
+}
+
+/**
+ *	relay_buf_full - boolean, is the channel buffer full?
+ *	@buf: channel buffer
+ *
+ *	Returns 1 if the buffer is full, 0 otherwise.
+ */
+static inline int relay_buf_full(struct rchan_buf *buf)
+{
+	int produced, consumed;
+
+	if (relay_mode_continuous(buf->chan))
+		return 0;
+
+	produced = atomic_read(&buf->subbufs_produced);
+	consumed = atomic_read(&buf->subbufs_consumed);
+
+	return (produced - consumed > buf->chan->n_subbufs - 1) ? 1 : 0;
+}
+
+/*
+ * close() vm_op implementation for relayfs file mapping.
+ */
+static void relay_file_mmap_close(struct vm_area_struct *vma)
+{
+	struct file *filp = vma->vm_file;
+	struct rchan_buf *buf = filp->private_data;
+
+	buf->chan->cb->fileop_notify(buf, filp, RELAY_FILE_UNMAP);
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
+int relay_mmap_buffer(struct rchan_buf *buf, struct vm_area_struct *vma)
+{
+	int err = 0;
+	unsigned long length = vma->vm_end - vma->vm_start;
+	struct file *filp = vma->vm_file;
+
+	if (buf == NULL) {
+		err = -EBADF;
+		goto exit;
+	}
+
+	if (length != (unsigned long)buf->chan->alloc_size) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	err = relay_mmap_region(vma,
+				(char *)vma->vm_start,
+				buf->start,
+				buf->chan->alloc_size);
+
+	if (err == 0) {
+		vma->vm_ops = &relay_file_mmap_ops;
+		err = buf->chan->cb->fileop_notify(buf, filp, RELAY_FILE_MAP);
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
+ * subbuf_start() default callback.  Does nothing.
+ */
+static int subbuf_start_default_callback(struct rchan_buf *buf,
+					 void *subbuf,
+					 unsigned prev_subbuf_idx)
+{
+	return 0;
+}
+
+/*
+ * deliver() default callback.  Does nothing.
+ */
+static void deliver_default_callback (struct rchan_buf *buf,
+				      void *subbuf,
+				      unsigned subbuf_idx)
+{
+}
+
+/*
+ * fileop_notify() default callback.  Does nothing.
+ */
+static int fileop_notify_default_callback(struct rchan_buf *buf,
+					  struct file *filp,
+					  enum relay_fileop fileop)
+{
+	return 0;
+}
+
+/* relay channel default callbacks */
+static struct rchan_callbacks default_channel_callbacks = {
+	.subbuf_start = subbuf_start_default_callback,
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
+	struct rchan_buf *buf = private;
+
+	wake_up_interruptible(&buf->read_wait);
+}
+
+/**
+ *	get_next_subbuf - return next sub-buffer within channel buffer
+ *	@buf: channel buffer
+ */
+static inline void *get_next_subbuf(struct rchan_buf *buf)
+{
+	void *next = buf->data + buf->chan->subbuf_size;
+
+	if (next >= buf->start + buf->chan->subbuf_size * buf->chan->n_subbufs)
+		next = buf->start;
+
+	return next;
+}
+
+/**
+ *	rchan_destroy_buf - destroy an rchan_buf struct and associated buffer
+ *	@buf: the buffer struct
+ */
+static inline void rchan_destroy_buf(struct rchan_buf *buf)
+{
+	if (likely(buf->start))
+		relay_free_rchan_buf(buf->start, buf->page_array, buf->page_count);
+	kfree(buf->padding);
+	kfree(buf->commit);
+	kfree(buf);
+}
+
+/**
+ *	relay_destroy_buf - destroy a channel buffer
+ *	@buf: the channel buffer
+ *
+ *	Frees the rchan_buf_struct and the channel buffer, and removes
+ *	the file from the relayfs filesystem.  Should only be called from
+ *	kref_put().
+ */
+void relay_destroy_buf(struct kref *kref)
+{
+	struct dentry *dentry, *parent;
+	struct rchan_buf *buf = container_of(kref, struct rchan_buf, kref);
+
+	dentry = buf->dentry;
+	parent = dentry->d_parent;
+	rchan_destroy_buf(buf);
+	
+	relayfs_remove_file(dentry);
+	relayfs_remove_dirs(parent);
+}
+
+/**
+ *	__relay_reset - reset a channel buffer
+ *	@buf: the channel buffer
+ *	@init: 1 if this is a first-time initialization
+ *
+ *	See relay_reset for description of effect.
+ */
+static inline void __relay_reset(struct rchan_buf *buf, int init)
+{
+	int i;
+	
+	if (init) {
+		init_waitqueue_head(&buf->read_wait);
+		kref_init(&buf->kref);
+	}
+
+	atomic_set(&buf->subbufs_produced, 0);
+	atomic_set(&buf->subbufs_consumed, 0);
+	buf->finalized = 0;
+	buf->data = buf->start;
+	buf->offset = 0;
+
+	for (i = 0; i < buf->chan->n_subbufs; i++) {
+		buf->padding[i] = 0;
+		buf->commit[i] = 0;
+	}
+
+	INIT_WORK(&buf->wake_readers, NULL, NULL);
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
+		if (chan->buf[i] != NULL)
+			__relay_reset(chan->buf[i], 0);
+}
+
+/**
+ *	check_attribute_flags - check sanity of channel attributes
+ *	@flags: channel attributes
+ *
+ *	Returns 0 if successful, negative otherwise.
+ */
+static inline int check_attribute_flags(u32 attribute_flags)
+{
+	if ((attribute_flags & RELAY_MODE_CONTINUOUS) &&
+	    (attribute_flags & RELAY_MODE_NO_OVERWRITE))
+		return -EINVAL; /* Can't have it both ways */
+
+	if (!(attribute_flags & RELAY_MODE_CONTINUOUS) &&
+	    !(attribute_flags & RELAY_MODE_NO_OVERWRITE))
+		return -EINVAL; /* Gotta have it one way */
+
+	return 0;
+}
+
+/**
+ *	rchan_create_buf - allocate and initialize a channel buffer
+ *	@chan: channel associated with buffer
+ *	@chanpath: path specifying the relayfs channel file to create
+ *
+ *	Returns channel buffer if successful, NULL otherwise
+ */
+static struct rchan_buf *rchan_create_buf(struct rchan *chan)
+{
+	struct page **page_array;
+	int page_count;
+	struct rchan_buf *buf;
+
+	if ((buf = kcalloc(1, sizeof(struct rchan_buf), GFP_KERNEL)) == NULL)
+		return NULL;
+
+	buf->padding = kmalloc(chan->n_subbufs * sizeof(unsigned *), GFP_KERNEL);
+	if (buf->padding == NULL)
+		goto free_buf;
+	
+	buf->commit = kmalloc(chan->n_subbufs * sizeof(unsigned *), GFP_KERNEL);
+	if (buf->commit == NULL)
+		goto free_padding;
+
+	if ((buf->start = relay_alloc_rchan_buf(chan->alloc_size, &page_array, &page_count)) == NULL) {
+		buf->page_array = NULL;
+		buf->page_count = 0;
+		goto free_commit;
+	}
+
+	buf->page_array = page_array;
+	buf->page_count = page_count;
+	buf->chan = chan;
+	return buf;
+
+free_commit:
+	kfree(buf->commit);
+
+free_padding:
+	kfree(buf->padding);
+
+free_buf:
+	kfree(buf);
+	return NULL;
+}
+
+/**
+ *	relay_open_buf - create a new channel buffer in relayfs
+ *
+ *	Internal - used by relay_open().
+ */
+static struct rchan_buf *relay_open_buf(struct rchan *chan,
+					const char *filename,
+					struct dentry *parent)
+{
+	struct rchan_buf *buf;
+	struct dentry *dentry;
+
+	if ((buf = rchan_create_buf(chan)) == NULL)
+		return NULL;
+
+	/* Create file in fs */
+	if (relayfs_create_file(filename, parent, &dentry, buf, S_IRUSR) < 0) {
+		rchan_destroy_buf(buf);
+		return NULL;
+	}
+
+	buf->dentry = dentry;
+	__relay_reset(buf, 1);
+
+	return buf;
+}
+
+static void relay_close_buf(struct rchan_buf *buf);
+
+static inline void setup_callbacks(struct rchan *chan,
+				   struct rchan_callbacks *callbacks)
+{
+	if (callbacks == NULL) {
+		chan->cb = &default_channel_callbacks;
+		return;
+	}
+
+	if (callbacks->subbuf_start == NULL)
+		callbacks->subbuf_start = subbuf_start_default_callback;
+	if (callbacks->deliver == NULL)
+		callbacks->deliver = deliver_default_callback;
+	if (callbacks->fileop_notify == NULL)
+		callbacks->fileop_notify = fileop_notify_default_callback;
+	chan->cb = callbacks;
+}
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
+			 unsigned subbuf_size,
+			 unsigned n_subbufs,
+			 u32 flags,
+			 struct rchan_callbacks *cb)
+{
+	int i;
+	struct rchan *chan;
+	char *tmpname;
+	const char *filebase;
+	struct dentry *topdir;
+	int err;
+
+	if (chanpath == NULL)
+		return NULL;
+
+	if (check_attribute_flags(flags))
+		return NULL;
+
+	chan = kcalloc(1, sizeof(struct rchan), GFP_KERNEL);
+	if (chan == NULL)
+		return NULL;
+
+	chan->version = RELAYFS_CHANNEL_VERSION;
+	chan->flags = flags;
+	chan->n_subbufs = n_subbufs;
+	chan->subbuf_size = subbuf_size;
+	chan->alloc_size = FIX_SIZE(subbuf_size * n_subbufs);
+	setup_callbacks(chan, cb);
+	
+	tmpname = kmalloc(NAME_MAX + 1, GFP_KERNEL);
+	if (tmpname == NULL)
+		goto free_chan;
+
+	err = relayfs_create_dirs(chanpath, &filebase, &topdir);
+	if (err && (err != -EEXIST))
+		goto free_bufs;
+
+	for_each_online_cpu(i) {
+		sprintf(tmpname, "%s%d", filebase, i);
+		chan->buf[i] = relay_open_buf(chan, tmpname, topdir);
+		if (chan->buf[i] == NULL)
+			goto free_bufs;
+	}
+
+	chan->path_dentry = topdir;
+	
+	kfree(tmpname);
+	return chan;
+	
+free_bufs:
+	relayfs_remove_dirs(topdir);
+	
+	for (i = 0; i < NR_CPUS; i++)
+		if (chan->buf[i] != NULL)
+			relay_close_buf(chan->buf[i]);
+	kfree(tmpname);
+
+free_chan:
+	kfree(chan);
+	return NULL;
+}
+
+/**
+ *	deliver_check - deliver a guaranteed full sub-buffer if applicable
+ */
+static inline void deliver_check(struct rchan_buf *buf,
+				 unsigned subbuf_idx)
+{
+	unsigned full;
+	void *subbuf;
+
+	full = buf->chan->subbuf_size - buf->padding[subbuf_idx];
+
+	if (buf->commit[subbuf_idx] == full) {
+		subbuf = buf->start + subbuf_idx * buf->chan->subbuf_size;
+		buf->chan->cb->deliver(buf, subbuf, subbuf_idx);
+	}
+}
+
+/**
+ *	relay_switch_subbuf - switch to a new sub-buffer
+ *	@buf: channel buffer
+ *	@length: number of bytes to write
+ *
+ *	Returns either the length passed in or 0 if full.
+
+ *	Performs sub-buffer-switch tasks such as invoking callbacks,
+ *	updating padding counts, waking up readers, etc.
+ */
+unsigned relay_switch_subbuf(struct rchan_buf *buf, unsigned length)
+{
+	int cur_subbuf, prev_subbuf, subbufs_produced;
+	unsigned start = 0, padding = buf->chan->subbuf_size - buf->offset;
+	
+	if (unlikely(relay_buf_full(buf)))
+		return 0;
+
+	subbufs_produced = atomic_read(&buf->subbufs_produced);
+	cur_subbuf = prev_subbuf = subbufs_produced % buf->chan->n_subbufs;
+	buf->padding[cur_subbuf] = padding;
+
+	atomic_inc(&buf->subbufs_produced);
+
+	if (waitqueue_active(&buf->read_wait)) {
+		PREPARE_WORK(&buf->wake_readers, wakeup_readers, buf);
+		schedule_delayed_work(&buf->wake_readers, 1);
+	}
+
+	if (unlikely(relay_buf_full(buf)))
+		return 0;
+
+	buf->data = get_next_subbuf(buf);
+	cur_subbuf = (subbufs_produced + 1) % buf->chan->n_subbufs;
+	buf->padding[cur_subbuf] = buf->commit[cur_subbuf] = 0;
+	start = buf->chan->cb->subbuf_start(buf, buf->data, prev_subbuf);
+	deliver_check(buf, prev_subbuf);
+
+	buf->offset = start;
+
+	return length;
+}
+
+/**
+ *	relay_commit - add count bytes to a sub-buffer's commit count
+ *	@buf: channel buffer
+ *	@subbuf_idx: sub-buffer index to add to
+ *	@count: number of bytes committed
+ *
+ *	Invokes deliver() callback if sub-buffer is completely written
+ */
+void relay_commit(struct rchan_buf *buf,
+		  unsigned subbuf_idx,
+		  unsigned count)
+{
+	if (subbuf_idx >= buf->chan->n_subbufs)
+		return;
+	
+	buf->commit[subbuf_idx] += count;
+
+	deliver_check(buf, subbuf_idx);
+}
+
+/**
+ *	relay_subbufs_consumed - update the buffer's sub-buffers-consumed count
+ *	@chan: the channel
+ *	@subbufs_consumed: number of sub-buffers to add to current buf's count
+ *	@cpu: the cpu associated with the channel buffer
+ *
+ *	Adds to the channel buffer's consumed sub-buffer count.
+ *	subbufs_consumed should be the number of sub-buffers newly consumed,
+ *	not the total consumed.
+ *
+ *	NOTE: kernel clients don't need to call this function if the channel
+ *	is MODE_CONTINUOUS.
+ */
+void relay_subbufs_consumed(struct rchan *chan, int subbufs_consumed, int cpu)
+{
+	int produced, consumed;
+	struct rchan_buf *buf = relay_get_buf(chan, cpu);
+
+	atomic_add(subbufs_consumed, &buf->subbufs_consumed);
+	produced = atomic_read(&buf->subbufs_produced);
+	consumed = atomic_read(&buf->subbufs_consumed);
+	if (consumed > produced)
+		atomic_set(&buf->subbufs_consumed, produced);
+}
+
+/**
+ *	relay_close_buf - close a channel buffer
+ *	@buf: channel buffer
+ *
+ *	Finalizes the last sub-buffer and marks the buffer as finalized.
+ *	The channel buffer and channel buffer data structure are then freed
+ *	automatically when the last reference is given up.
+ */
+static void relay_close_buf(struct rchan_buf *buf)
+{
+	relay_switch_subbuf(buf, 0);
+	buf->finalized = 1;
+	buf->chan->cb = &default_channel_callbacks;
+
+	kref_put(&buf->kref, relay_destroy_buf);
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
+		if (chan->buf[i] != NULL)
+			relay_close_buf(chan->buf[i]);
+
+	relayfs_remove_dirs(chan->path_dentry);
+	
+	kfree(chan);
+}
+
+EXPORT_SYMBOL_GPL(relay_open);
+EXPORT_SYMBOL_GPL(relay_close);
+EXPORT_SYMBOL_GPL(relay_reset);
+EXPORT_SYMBOL_GPL(relay_subbufs_consumed);
+EXPORT_SYMBOL_GPL(relay_switch_subbuf);
+EXPORT_SYMBOL_GPL(relay_commit);
diff -urpN -X dontdiff linux-2.6.10/fs/relayfs/relay.h linux-2.6.10-cur/fs/relayfs/relay.h
--- linux-2.6.10/fs/relayfs/relay.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-cur/fs/relayfs/relay.h	2005-01-31 20:30:29.000000000 -0600
@@ -0,0 +1,34 @@
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
+#define relay_mode_continuous(chan) (((chan)->flags & RELAY_MODE_CONTINUOUS) ? 1 : 0)
+
+extern int relayfs_create_file(const char * name,
+			       struct dentry *parent,
+			       struct dentry **dentry,
+			       void * data,
+			       int mode);
+extern int relayfs_remove_file(struct dentry *dentry);
+extern int relayfs_create_dirs(const char *chanpath,
+			       const char **residual,
+			       struct dentry **topdir);
+extern void relayfs_remove_dirs(struct dentry *dir);
+extern int relay_mmap_buffer(struct rchan_buf *buf,
+			     struct vm_area_struct *vma);
+extern void relay_destroy_buf(struct kref *kref);
+extern int relay_buf_empty(struct rchan_buf *buf);
+
+#endif /* _RELAY_H */
diff -urpN -X dontdiff linux-2.6.10/include/linux/relayfs_fs.h linux-2.6.10-cur/include/linux/relayfs_fs.h
--- linux-2.6.10/include/linux/relayfs_fs.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-cur/include/linux/relayfs_fs.h	2005-01-31 21:14:20.000000000 -0600
@@ -0,0 +1,239 @@
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
+#include <linux/poll.h>
+#include <linux/kref.h>
+#include <asm/local.h>
+
+/*
+ * Tracks changes to rchan_buf struct
+ */
+#define RELAYFS_CHANNEL_VERSION		3
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
+	unsigned offset;		/* current offset into sub-buffer */
+	atomic_t subbufs_produced;	/* count of sub-buffers produced */
+	atomic_t subbufs_consumed;	/* count of sub-buffers consumed */
+	struct rchan *chan;		/* associated channel */
+	wait_queue_head_t read_wait;	/* reader wait queue */
+	struct work_struct wake_readers; /* reader wake-up work struct */
+	struct dentry *dentry;		/* channel file dentry */
+	struct kref kref;		/* channel refcount */
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
+	unsigned subbuf_size;		/* sub-buffer size */
+	unsigned n_subbufs;		/* number of sub-buffers per buffer */
+	unsigned alloc_size;		/* total buffer size allocated */
+	u32 flags;			/* relay channel attributes */
+	struct rchan_callbacks *cb;	/* client callbacks */
+	struct dentry *path_dentry;	/* channel path dentry */
+	struct rchan_buf *buf[NR_CPUS]; /* per-cpu channel buffers */
+};
+
+/*
+ * Relay channel client callbacks
+ */
+struct rchan_callbacks
+{
+	/*
+	 * subbuf_start - called on buffer-switch to a new sub-buffer
+	 * @buf: the channel buffer containing the new sub-buffer
+	 * @subbuf: the start of the new sub-buffer
+	 * @prev_subbuf_idx: the previous sub-buffer's index
+	 *
+	 */
+	int (*subbuf_start) (struct rchan_buf *buf,
+			     void *subbuf,
+			     unsigned prev_subbuf_idx);
+
+	/*
+	 * deliver - deliver a guaranteed full sub-buffer to client
+	 * @buf: the channel buffer containing the sub-buffer
+	 * @subbuf: the start of the new sub-buffer
+	 * @subbuf_idx: the sub-buffer's index
+	 *
+	 * Only works if relay_commit is also used
+	 */
+	void (*deliver) (struct rchan_buf *buf,
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
+        int (*fileop_notify)(struct rchan_buf *buf,
+			     struct file *filp,
+			     enum relay_fileop fileop);
+};
+
+/*
+ * relayfs kernel API, fs/relayfs/relay.c
+ */
+
+extern struct rchan *relay_open(const char *chanpath,
+				unsigned subbuf_size,
+				unsigned n_subbufs,
+				u32 flags,
+				struct rchan_callbacks *callbacks);
+extern void relay_close(struct rchan *chan);
+extern void relay_subbufs_consumed(struct rchan *chan,
+				   int subbufs_consumed,
+				   int cpu);
+extern void relay_reset(struct rchan *chan);
+extern unsigned relay_switch_subbuf(struct rchan_buf *buf,
+				    unsigned length);
+extern void relay_commit(struct rchan_buf *buf,
+			 unsigned subbuf_idx,
+			 unsigned count);
+
+#define relay_get_buf(chan, cpu)		(chan->buf[cpu])
+#define relay_get_padding(buf, subbuf_idx)	(buf->padding[subbuf_idx])
+#define relay_get_commit(buf, subbuf_idx)	(buf->commit[subbuf_idx])
+
+/**
+ *	relay_write - write data into the channel
+ *	@chan: relay channel
+ *	@data: data to be written
+ *	@length: number of bytes to write
+ *
+ *	Returns the number of bytes written, 0 if full.
+ *
+ *	Writes data into the current cpu's channel buffer.  irq safe.
+ */
+static inline unsigned relay_write(struct rchan *chan,
+				   const void *data,
+				   unsigned length)
+{
+	unsigned long flags;
+	struct rchan_buf *buf = relay_get_buf(chan, smp_processor_id());
+
+	local_irq_save(flags);
+	if (unlikely(buf->offset + length > chan->subbuf_size))
+		length = relay_switch_subbuf(buf, length);
+	memcpy(buf->data + buf->offset, data, length);
+	buf->offset += length;
+	local_irq_restore(flags);
+ 
+	return length;
+}
+
+/**
+ *	__relay_write - write data into the channel
+ *	@chan: relay channel
+ *	@data: data to be written
+ *	@length: number of bytes to write
+ *
+ *	Returns the number of bytes written, 0 if full.
+ *
+ *	Writes data into the current cpu's channel buffer.  Preempt safe.
+ */
+static inline unsigned __relay_write(struct rchan *chan,
+				     const void *data,
+				     unsigned length)
+{
+	struct rchan_buf *buf = relay_get_buf(chan, get_cpu());
+
+	if (unlikely(buf->offset + length > buf->chan->subbuf_size))
+		length = relay_switch_subbuf(buf, length);
+	memcpy(buf->data + buf->offset, data, length);
+	buf->offset += length;
+	put_cpu();
+ 
+	return length;
+}
+
+/**
+ *	relay_reserve - reserve slot in channel buffer
+ *	@chan: relay channel
+ *	@length: number of bytes to reserve
+ *
+ *	Returns pointer to reserved slot, NULL if full.
+ *
+ *	Reserves slot in the current cpu's channel buffer.
+ *	Not irq or preempt safe - caller must provide synchronization.
+ */
+static inline void *relay_reserve(struct rchan *chan, unsigned length)
+{
+	void *reserved;
+	struct rchan_buf *buf = relay_get_buf(chan, smp_processor_id());
+
+	if (unlikely(buf->offset + length > buf->chan->subbuf_size)) {
+		length = relay_switch_subbuf(buf, length);
+		if (length == 0)
+			return NULL;
+	}
+	
+	reserved = buf->data + buf->offset;
+	buf->offset += length;
+
+	return reserved;
+}
+
+/*
+ * exported relayfs file operations, fs/relayfs/inode.c
+ */
+
+extern struct file_operations relayfs_file_operations;
+extern int relayfs_open(struct inode *inode, struct file *filp);
+extern unsigned int relayfs_poll(struct file *filp, poll_table *wait);
+extern int relayfs_mmap(struct file *filp, struct vm_area_struct *vma);
+extern int relayfs_release(struct inode *inode, struct file *filp);
+
+#endif /* _LINUX_RELAYFS_FS_H */
+

-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

