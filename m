Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbVBJCw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVBJCw2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 21:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVBJCw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 21:52:28 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:2479 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261847AbVBJCty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 21:49:54 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16906.52160.870346.806462@tut.ibm.com>
Date: Wed, 9 Feb 2005 20:49:36 -0600
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@muc.de>, Roman Zippel <zippel@linux-m68k.org>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>,
       Christoph Hellwig <hch@infradead.org>, karim@opersys.com
Subject: [PATCH] relayfs redux, part 4
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's the latest relayfs patch, incorporating the previous round of
suggestions.  Thanks to everyone who sent comments.  Here's a list of
the major changes:

- replaced remap_page_range() and reserved bits with a nopage()
  handler.
- buffers are now allocated/freed as part of inode alloc/destroy.
- got rid of the automatic creation/teardown of directory hierarchies,
  and exported create/remove dir functions instead.
- replaced the fileop callback with explicit map/unmap callbacks - these
  were the only fileops currently being used by anything, so I got rid
  of the other cases.
- relay_write() and __relay_write() no longer return a value - it
  doesn't really make sense for clients to check a return value in the
  fast path anyway.
- added a buf_full() callback to notify users that a buffer has become
  full and therefore events might be lost.
- got rid of the 'helper' macros, which weren't helping much.
- various other bits of code and comment cleanup.

Also, there was some question as to whether or not the memcpy in
relay_write() was being inlined properly - I looked at the generated
assembly code, and it seems to be, but I'll be taking a closer look
later.


This is what the API now looks like:

  API functions:

    rchan *relay_open(base_filename, parent, subbuf_size, n_subbufs,
                      flags, callbacks);
    void relay_close(chan);
    dentry *relayfs_create_dir(name, parent);
    int relayfs_remove_dir(dentry);
    void relay_reset(chan);
  
    void relay_write(chan, data, length);
    void __relay_write(chan, data, length);
    void *relay_reserve(chan, length);

    void relay_subbufs_consumed(chan, subbufs_consumed, cpu);
    void relay_commit(buf, subbuf_idx, count);

  callbacks:

    int subbuf_start(buf, subbuf, prev_subbuf_idx);
    int deliver(buffer, subbuf, subbuf_idx);
    void buf_mapped(buf, filp);
    void buf_unmapped(buf, filp);
    void buf_full(buf);

As before, I've tested this code on a single proc machine using a
hacked version of the kprobes network packet tracing module, which can
be found here:

http://prdownloads.sourceforge.net/dprobes/plog.tar.gz?download

If people are more or less happy with the current version, I'll do
some SMP testing and write some Documentation.


Thanks,

Tom


Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>


 fs/Kconfig                 |   12 
 fs/Makefile                |    1 
 fs/relayfs/Makefile        |    4 
 fs/relayfs/buffers.c       |  119 ++++++++
 fs/relayfs/buffers.h       |   14 +
 fs/relayfs/inode.c         |  447 ++++++++++++++++++++++++++++++++
 fs/relayfs/relay.c         |  616 +++++++++++++++++++++++++++++++++++++++++++++
 fs/relayfs/relay.h         |   31 ++
 include/linux/relayfs_fs.h |  253 ++++++++++++++++++
 9 files changed, 1497 insertions(+)


diff -urpN -X dontdiff linux-2.6.10/fs/Kconfig linux-2.6.10-cur/fs/Kconfig
--- linux-2.6.10/fs/Kconfig	2004-12-24 15:34:58.000000000 -0600
+++ linux-2.6.10-cur/fs/Kconfig	2005-01-31 21:49:27.000000000 -0600
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
+++ linux-2.6.10-cur/fs/Makefile	2005-01-31 21:49:27.000000000 -0600
@@ -94,3 +94,4 @@ obj-$(CONFIG_AFS_FS)		+= afs/
 obj-$(CONFIG_BEFS_FS)		+= befs/
 obj-$(CONFIG_HOSTFS)		+= hostfs/
 obj-$(CONFIG_HPPFS)		+= hppfs/
+obj-$(CONFIG_RELAYFS_FS)	+= relayfs/
diff -urpN -X dontdiff linux-2.6.10/fs/relayfs/Makefile linux-2.6.10-cur/fs/relayfs/Makefile
--- linux-2.6.10/fs/relayfs/Makefile	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-cur/fs/relayfs/Makefile	2005-02-03 06:34:11.000000000 -0600
@@ -0,0 +1,4 @@
+obj-$(CONFIG_RELAYFS_FS) += relayfs.o
+
+relayfs-y := relay.o buffers.o inode.o
+
diff -urpN -X dontdiff linux-2.6.10/fs/relayfs/buffers.c linux-2.6.10-cur/fs/relayfs/buffers.c
--- linux-2.6.10/fs/relayfs/buffers.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-cur/fs/relayfs/buffers.c	2005-02-03 08:16:39.000000000 -0600
@@ -0,0 +1,119 @@
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
+	if (!page_array)
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
+	for (i = 0; i < page_count; i++)
+		__free_page(page_array[i]);
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
+	depopulate_page_array(page_array, page_count);
+	kfree(page_array);
+}
diff -urpN -X dontdiff linux-2.6.10/fs/relayfs/buffers.h linux-2.6.10-cur/fs/relayfs/buffers.h
--- linux-2.6.10/fs/relayfs/buffers.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-cur/fs/relayfs/buffers.h	2005-01-31 21:49:27.000000000 -0600
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
+++ linux-2.6.10-cur/fs/relayfs/inode.c	2005-02-06 00:22:18.000000000 -0600
@@ -0,0 +1,447 @@
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
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/backing-dev.h>
+#include <linux/namei.h>
+#include <linux/poll.h>
+#include <linux/relayfs_fs.h>
+#include "relay.h"
+
+#define RELAYFS_MAGIC			0x26F82121
+
+static struct vfsmount *		relayfs_mount;
+static int				relayfs_mount_count;
+static kmem_cache_t *			relayfs_inode_cachep;
+
+static struct backing_dev_info		relayfs_backing_dev_info = {
+	.ra_pages	= 0,	/* No readahead */
+	.memory_backed	= 1,	/* Does not contribute to dirty memory */
+};
+
+static struct inode *relayfs_get_inode(struct super_block *sb, int mode,
+				       struct rchan *chan)
+{
+	struct rchan_buf *buf = NULL;
+	struct inode *inode;
+
+	if (S_ISREG(mode)) {
+		BUG_ON(!chan);
+		buf = rchan_create_buf(chan);
+		if (!buf)
+			return NULL;
+	}
+	
+	inode = new_inode(sb);
+	if (!inode) {
+		rchan_destroy_buf(buf);
+		return NULL;
+	}
+	
+	inode->i_mode = mode;
+	inode->i_uid = 0;
+	inode->i_gid = 0;
+	inode->i_blksize = PAGE_CACHE_SIZE;
+	inode->i_blocks = 0;
+	inode->i_mapping->backing_dev_info = &relayfs_backing_dev_info;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	switch (mode & S_IFMT) {
+	case S_IFREG:
+		inode->i_fop = &relayfs_file_operations;
+		RELAYFS_I(inode)->buf = buf;
+		break;
+	case S_IFDIR:
+		inode->i_op = &simple_dir_inode_operations;
+		inode->i_fop = &simple_dir_operations;
+		
+		/* directory inodes start off with i_nlink == 2 (for "." entry) */
+		inode->i_nlink++;
+		break;
+	default:
+		break;
+	}
+
+	return inode;
+}
+
+/**
+ *	relayfs_create_entry - create a relayfs directory or file
+ *	@name: the name of the file to create
+ *	@parent: parent directory
+ *	@mode: mode
+ *	@chan: relay channel associated with the file
+ *	@dentry: result dentry
+ *
+ *	Creates a file or directory with the specifed permissions.
+ */
+static int relayfs_create_entry(const char *name, struct dentry *parent,
+				int mode, struct rchan *chan,
+				struct dentry **dentry)
+{
+	struct qstr qname;
+	struct dentry *d;
+	struct inode *inode;
+	int error = 0;
+
+	BUG_ON(!(S_ISREG(mode) || S_ISDIR(mode)));
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
+	if (!parent)
+		if (relayfs_mount && relayfs_mount->mnt_sb)
+			parent = relayfs_mount->mnt_sb->s_root;
+
+	if (!parent) {
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
+	inode = relayfs_get_inode(parent->d_inode->i_sb, mode, chan);
+	if (!inode) {
+		error = -ENOSPC;
+		goto release_mount;
+	}
+
+	d_instantiate(d, inode);
+	dget(d);	/* Extra count - pin the dentry in core */
+
+	if (S_ISDIR(mode))
+		parent->d_inode->i_nlink++;
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
+ *	@mode: mode, if not specied the default perms are used
+ *	@chan: channel associated with the file
+ *
+ *	Returns file dentry if successful, NULL otherwise.
+ *
+ *	The file will be created user r on behalf of current user.
+ */
+struct dentry *relayfs_create_file(const char *name, struct dentry *parent,
+				   int mode, struct rchan *chan)
+{
+	struct dentry *dentry;
+	int error;
+	
+	if (!mode)
+		mode = S_IRUSR;
+	mode = (mode & S_IALLUGO) | S_IFREG;
+
+	error = relayfs_create_entry(name, parent, mode, chan, &dentry);
+	if (error)
+		return NULL;
+	
+	return dentry;
+}
+
+/**
+ *	relayfs_create_dir - create a directory in the relay filesystem
+ *	@name: the name of the directory to create
+ *	@parent: parent directory, NULL if parent should be fs root
+ *
+ *	Returns directory dentry if successful, NULL otherwise.
+ *
+ *	The directory will be created world rwx on behalf of current user.
+ */
+struct dentry *relayfs_create_dir(const char *name, struct dentry *parent)
+{
+	int error;
+	struct dentry *dentry = NULL;
+	int mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
+
+	if (!name)
+		return NULL;
+	
+	error = relayfs_create_entry(name, parent, mode, NULL, &dentry);
+	if (error)
+		return NULL;
+	
+	return dentry;
+}
+
+/**
+ *	relayfs_remove - remove a file or directory in the relay filesystem
+ *	@dentry: file or directory dentry
+ */
+int relayfs_remove(struct dentry *dentry)
+{
+	struct dentry *parent = dentry->d_parent;
+
+	if (!parent)
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
+ *	relayfs_remove_dir - remove a directory in the relay filesystem
+ *	@dentry: directory dentry
+ *
+ *	Returns 0 if successful, negative otherwise.
+ */
+int relayfs_remove_dir(struct dentry *dentry)
+{
+	if (!dentry)
+		return -EINVAL;
+	
+	return relayfs_remove(dentry);
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
+	struct rchan_buf *buf = RELAYFS_I(inode)->buf;
+	kref_get(&buf->kref);
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
+int relayfs_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct inode *inode = filp->f_dentry->d_inode;
+	struct rchan_buf *buf = RELAYFS_I(inode)->buf;
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
+	struct inode *inode = filp->f_dentry->d_inode;
+	struct rchan_buf *buf = RELAYFS_I(inode)->buf;
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
+	struct rchan_buf *buf = RELAYFS_I(inode)->buf;
+
+	kref_put(&buf->kref, relay_destroy_buf);
+
+	return 0;
+}
+
+/**
+ *	relayfs alloc_inode() implementation
+ */
+static struct inode *relayfs_alloc_inode(struct super_block *sb)
+{
+	struct relayfs_inode_info *p;
+	p = (struct relayfs_inode_info *)kmem_cache_alloc(relayfs_inode_cachep,
+							  SLAB_KERNEL);
+	if (!p)
+		return NULL;
+	p->buf = NULL;
+	
+	return &p->vfs_inode;
+}
+
+/**
+ *	relayfs destroy_inode() implementation
+ */
+static void relayfs_destroy_inode(struct inode *inode)
+{
+	if (RELAYFS_I(inode)->buf)
+		rchan_destroy_buf(RELAYFS_I(inode)->buf);
+
+	kmem_cache_free(relayfs_inode_cachep, RELAYFS_I(inode));
+}
+
+static void init_once(void *p, kmem_cache_t *cachep, unsigned long flags)
+{
+	struct relayfs_inode_info *i = p;
+	if ((flags & (SLAB_CTOR_VERIFY | SLAB_CTOR_CONSTRUCTOR)) == SLAB_CTOR_CONSTRUCTOR)
+		inode_init_once(&i->vfs_inode);
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
+	.alloc_inode	= relayfs_alloc_inode,
+	.destroy_inode	= relayfs_destroy_inode,
+};
+
+static int relayfs_fill_super(struct super_block * sb, void * data, int silent)
+{
+	struct inode *inode;
+	struct dentry *root;
+	int mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
+
+	sb->s_blocksize = PAGE_CACHE_SIZE;
+	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
+	sb->s_magic = RELAYFS_MAGIC;
+	sb->s_op = &relayfs_ops;
+	inode = relayfs_get_inode(sb, mode, NULL);
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
+	int err;
+	
+	relayfs_inode_cachep = kmem_cache_create("relayfs_inode_cache",
+				sizeof(struct relayfs_inode_info), 0,
+				0, init_once, NULL);
+	if (!relayfs_inode_cachep)
+		return -ENOMEM;
+
+	err = register_filesystem(&relayfs_fs_type);
+	if (err)
+		kmem_cache_destroy(relayfs_inode_cachep);
+	
+	return err;
+}
+
+static void __exit exit_relayfs_fs(void)
+{
+	unregister_filesystem(&relayfs_fs_type);
+	kmem_cache_destroy(relayfs_inode_cachep);
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
+EXPORT_SYMBOL_GPL(relayfs_create_dir);
+EXPORT_SYMBOL_GPL(relayfs_remove_dir);
+
+MODULE_AUTHOR("Tom Zanussi <zanussi@us.ibm.com> and Karim Yaghmour <karim@opersys.com>");
+MODULE_DESCRIPTION("Relay Filesystem");
+MODULE_LICENSE("GPL");
+
diff -urpN -X dontdiff linux-2.6.10/fs/relayfs/relay.c linux-2.6.10-cur/fs/relayfs/relay.c
--- linux-2.6.10/fs/relayfs/relay.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-cur/fs/relayfs/relay.c	2005-02-06 00:22:32.000000000 -0600
@@ -0,0 +1,616 @@
+/*
+ * Public API and common code for RelayFS.
+ *
+ * Copyright (C) 2002, 2003 - Tom Zanussi (zanussi@us.ibm.com), IBM Corp
+ * Copyright (C) 1999, 2000, 2001, 2002 - Karim Yaghmour (karim@opersys.com)
+ *
+ * This file is released under the GPL.
+ */
+
+#include <linux/errno.h>
+#include <linux/stddef.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/relayfs_fs.h>
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
+	struct rchan_buf *buf = vma->vm_private_data;
+	buf->chan->cb->buf_unmapped(buf, vma->vm_file);
+}
+
+/*
+ * nopage() vm_op implementation for relayfs file mapping.
+ */
+static struct page *relay_buf_nopage(struct vm_area_struct *vma,
+				     unsigned long address,
+				     int *type)
+{
+	struct page *page;
+	struct rchan_buf *buf = vma->vm_private_data;
+	unsigned long offset = address - vma->vm_start;
+
+	if (address > vma->vm_end)
+		return NOPAGE_SIGBUS; /* Disallow mremap */
+	if (!buf)
+		return NOPAGE_OOM;
+
+	page = vmalloc_to_page(buf->start + offset);
+	if (!page)
+		return NOPAGE_OOM;
+	get_page(page);
+
+	if (type)
+		*type = VM_FAULT_MINOR;
+
+	return page;
+}
+
+/*
+ * vm_ops for relay file mappings.
+ */
+static struct vm_operations_struct relay_file_mmap_ops = {
+	.nopage = relay_buf_nopage,
+	.close = relay_file_mmap_close,
+};
+
+/**
+ *	relay_mmap_buffer: - mmap buffer to process address space
+ *	@buf: relay channel buffer
+ *	@vma: vm_area_struct describing memory to be mapped
+ *
+ *	Returns 0 if ok, negative on error
+ *
+ *	Caller should already have grabbed mmap_sem.
+ */
+int relay_mmap_buffer(struct rchan_buf *buf, struct vm_area_struct *vma)
+{
+	unsigned long length = vma->vm_end - vma->vm_start;
+	struct file *filp = vma->vm_file;
+
+	if (!buf)
+		return -EBADF;
+
+	if (length != (unsigned long)buf->chan->alloc_size)
+		return -EINVAL;
+
+	vma->vm_ops = &relay_file_mmap_ops;
+	vma->vm_private_data = buf;
+	buf->chan->cb->buf_mapped(buf, filp);
+
+	return 0;
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
+ * buf_mapped() default callback.  Does nothing.
+ */
+static void buf_mapped_default_callback(struct rchan_buf *buf,
+					struct file *filp)
+{
+}
+
+/*
+ * buf_unmapped() default callback.  Does nothing.
+ */
+static void buf_unmapped_default_callback(struct rchan_buf *buf,
+					  struct file *filp)
+{
+}
+
+/*
+ * buf_full() default callback.  Does nothing.
+ */
+static void buf_full_default_callback(struct rchan_buf *buf)
+{
+}
+
+/* relay channel default callbacks */
+static struct rchan_callbacks default_channel_callbacks = {
+	.subbuf_start = subbuf_start_default_callback,
+	.deliver = deliver_default_callback,
+	.buf_mapped = buf_mapped_default_callback,
+	.buf_unmapped = buf_unmapped_default_callback,
+	.buf_full = buf_full_default_callback,
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
+void rchan_destroy_buf(struct rchan_buf *buf)
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
+ *
+ *	Removes the file from the relayfs fileystem, which also frees the
+ *	rchan_buf_struct and the channel buffer.  Should only be called from
+ *	kref_put().
+ */
+void relay_destroy_buf(struct kref *kref)
+{
+	struct rchan_buf *buf = container_of(kref, struct rchan_buf, kref);
+	relayfs_remove(buf->dentry);
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
+ *	@attibute_flags: channel attributes
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
+ *	@alloc_size: size of the buffer to allocate
+ *	@n_subbufs: number of sub-buffers in the channel
+ *
+ *	Returns channel buffer if successful, NULL otherwise
+ */
+struct rchan_buf *rchan_create_buf(struct rchan *chan)
+{
+	struct page **page_array;
+	int page_count;
+	struct rchan_buf *buf;
+
+	buf = kcalloc(1, sizeof(struct rchan_buf), GFP_KERNEL);
+	if (!buf)
+		return NULL;
+
+	buf->padding = kmalloc(chan->n_subbufs * sizeof(unsigned *), GFP_KERNEL);
+	if (!buf->padding)
+		goto free_buf;
+	
+	buf->commit = kmalloc(chan->n_subbufs * sizeof(unsigned *), GFP_KERNEL);
+	if (!buf->commit)
+		goto free_padding;
+
+	buf->start = relay_alloc_rchan_buf(chan->alloc_size, &page_array, &page_count);
+	if (!buf->start)
+		goto free_commit;
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
+	/* Create file in fs */
+	dentry = relayfs_create_file(filename, parent, S_IRUSR, chan);
+	if (!dentry)
+		return NULL;
+
+	buf = RELAYFS_I(dentry->d_inode)->buf;
+	buf->dentry = dentry;
+	__relay_reset(buf, 1);
+
+	return buf;
+}
+
+static void relay_close_buf(struct rchan_buf *buf);
+
+static inline void setup_callbacks(struct rchan *chan,
+				   struct rchan_callbacks *cb)
+{
+	if (!cb) {
+		chan->cb = &default_channel_callbacks;
+		return;
+	}
+
+	if (!cb->subbuf_start)
+		cb->subbuf_start = subbuf_start_default_callback;
+	if (!cb->deliver)
+		cb->deliver = deliver_default_callback;
+	if (!cb->buf_mapped)
+		cb->buf_mapped = buf_mapped_default_callback;
+	if (!cb->buf_unmapped)
+		cb->buf_unmapped = buf_unmapped_default_callback;
+	if (!cb->buf_full)
+		cb->buf_full = buf_full_default_callback;
+	chan->cb = cb;
+}
+
+/**
+ *	relay_open - create a new relayfs channel
+ *	@base_filename: base name of files to create
+ *	@parent: dentry of parent directory, NULL for root directory
+ *	@subbuf_size: size of sub-buffers
+ *	@n_subbufs: number of sub-buffers
+ *	@attribute_flags: channel attributes
+ *	@cb: client callback functions
+ *
+ *	Returns channel pointer if successful, NULL otherwise.
+ *
+ *	Creates a channel buffer for each cpu using the sizes and
+ *	attributes specified.  The created channel buffer files
+ *	will be named base_filename0...base_filenameN-1.  File
+ *	permissions will be S_IRUSR.
+ */
+struct rchan *relay_open(const char *base_filename,
+			 struct dentry *parent,
+			 unsigned subbuf_size,
+			 unsigned n_subbufs,
+			 u32 attribute_flags,
+			 struct rchan_callbacks *cb)
+{
+	int i;
+	struct rchan *chan;
+	char *tmpname;
+
+	if (!base_filename)
+		return NULL;
+
+	if (check_attribute_flags(attribute_flags))
+		return NULL;
+
+	chan = kcalloc(1, sizeof(struct rchan), GFP_KERNEL);
+	if (!chan)
+		return NULL;
+
+	chan->version = RELAYFS_CHANNEL_VERSION;
+	chan->flags = attribute_flags;
+	chan->n_subbufs = n_subbufs;
+	chan->subbuf_size = subbuf_size;
+	chan->alloc_size = FIX_SIZE(subbuf_size * n_subbufs);
+	setup_callbacks(chan, cb);
+	
+	tmpname = kmalloc(NAME_MAX + 1, GFP_KERNEL);
+	if (!tmpname)
+		goto free_chan;
+
+	for_each_online_cpu(i) {
+		sprintf(tmpname, "%s%d", base_filename, i);
+		chan->buf[i] = relay_open_buf(chan, tmpname, parent);
+		if (!chan->buf[i])
+			goto free_bufs;
+	}
+
+	kfree(tmpname);
+	return chan;
+	
+free_bufs:
+	for (i = 0; i < NR_CPUS; i++)
+		if (chan->buf[i])
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
+ *	@length: size of current event
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
+	if (unlikely(relay_buf_full(buf))) {
+		return 0;
+		buf->chan->cb->buf_full(buf);
+	}
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
+ *	@cpu: the cpu associated with the channel buffer to update
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
+	struct rchan_buf *buf = chan->buf[cpu];
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
+
+	buf->finalized = 1;
+	buf->chan->cb = &default_channel_callbacks;
+
+	kref_put(&buf->kref, relay_destroy_buf);
+}
+
+/**
+ *	relay_close - close the channel
+ *	@chan: the channel
+ *
+ *	Closes all channel buffers and frees the channel.
+ */
+void relay_close(struct rchan *chan)
+{
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++)
+		if (chan->buf[i])
+			relay_close_buf(chan->buf[i]);
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
+++ linux-2.6.10-cur/fs/relayfs/relay.h	2005-02-05 23:00:10.000000000 -0600
@@ -0,0 +1,31 @@
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
+struct dentry *relayfs_create_file(const char *name,
+				   struct dentry *parent,
+				   int mode,
+				   struct rchan *chan);
+extern int relayfs_remove(struct dentry *dentry);
+extern int relay_mmap_buffer(struct rchan_buf *buf,
+			     struct vm_area_struct *vma);
+extern struct rchan_buf *rchan_create_buf(struct rchan *chan);
+extern void rchan_destroy_buf(struct rchan_buf *buf);
+extern void relay_destroy_buf(struct kref *kref);
+extern int relay_buf_empty(struct rchan_buf *buf);
+
+#endif /* _RELAY_H */
diff -urpN -X dontdiff linux-2.6.10/include/linux/relayfs_fs.h linux-2.6.10-cur/include/linux/relayfs_fs.h
--- linux-2.6.10/include/linux/relayfs_fs.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-cur/include/linux/relayfs_fs.h	2005-02-06 00:21:44.000000000 -0600
@@ -0,0 +1,253 @@
+/*
+ * linux/include/linux/relayfs_fs.h
+ *
+ * Copyright (C) 2002, 2003 - Tom Zanussi (zanussi@us.ibm.com), IBM Corp
+ * Copyright (C) 1999, 2000, 2001, 2002 - Karim Yaghmour (karim@opersys.com)
+ *
+ * RelayFS definitions and declarations
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
+	struct rchan_buf *buf[NR_CPUS]; /* per-cpu channel buffers */
+};
+
+/*
+ * Relayfs inode
+ */
+struct relayfs_inode_info
+{
+	struct inode vfs_inode;
+	struct rchan_buf *buf;
+};
+
+static inline struct relayfs_inode_info *RELAYFS_I(struct inode *inode)
+{
+	return container_of(inode, struct relayfs_inode_info, vfs_inode);
+}
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
+	 * buf_mapped - relayfs buffer mmap notification
+	 * @buf: the channel buffer
+	 * @filp: relayfs file pointer
+	 *
+	 * Called when a relayfs file is successfully mmapped
+	 */
+        void (*buf_mapped)(struct rchan_buf *buf,
+			   struct file *filp);
+
+	/*
+	 * buf_unmapped - relayfs buffer unmap notification
+	 * @buf: the channel buffer
+	 * @filp: relayfs file pointer
+	 *
+	 * Called when a relayfs file is successfully unmapped
+	 */
+        void (*buf_unmapped)(struct rchan_buf *buf,
+			     struct file *filp);
+
+	/*
+	 * buf_full - relayfs buffer full notification
+	 * @buf: the channel channel buffer
+	 *
+	 * Called when a relayfs buffer becomes full
+	 */
+        void (*buf_full)(struct rchan_buf *buf);
+};
+
+/*
+ * relayfs kernel API, fs/relayfs/relay.c
+ */
+
+struct rchan *relay_open(const char *base_filename,
+			 struct dentry *parent,
+			 unsigned subbuf_size,
+			 unsigned n_subbufs,
+			 u32 flags,
+			 struct rchan_callbacks *cb);
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
+extern struct dentry *relayfs_create_dir(const char *name,
+					 struct dentry *parent);
+extern int relayfs_remove_dir(struct dentry *dentry);
+
+/**
+ *	relay_write - write data into the channel
+ *	@chan: relay channel
+ *	@data: data to be written
+ *	@length: number of bytes to write
+ *
+ *	Writes data into the current cpu's channel buffer.
+ *
+ *	Can be called in any context.  Try __relay_write() if you know
+ *	you won't be logging in interrupt context.
+ */
+static inline void relay_write(struct rchan *chan,
+			       const void *data,
+			       unsigned length)
+{
+	unsigned long flags;
+	struct rchan_buf *buf;
+
+	local_irq_save(flags);
+	buf = chan->buf[smp_processor_id()];
+	if (unlikely(buf->offset + length > chan->subbuf_size))
+		length = relay_switch_subbuf(buf, length);
+	memcpy(buf->data + buf->offset, data, length);
+	buf->offset += length;
+	local_irq_restore(flags);
+}
+
+/**
+ *	__relay_write - write data into the channel
+ *	@chan: relay channel
+ *	@data: data to be written
+ *	@length: number of bytes to write
+ *
+ *	Writes data into the current cpu's channel buffer.
+ *
+ *	Preempt-safe but not irq-safe.  Use relay_write() if you might
+ *	be logging in interrupt context.
+ */
+static inline void __relay_write(struct rchan *chan,
+				 const void *data,
+				 unsigned length)
+{
+	struct rchan_buf *buf;
+	
+	buf = chan->buf[get_cpu()];
+	if (unlikely(buf->offset + length > buf->chan->subbuf_size))
+		length = relay_switch_subbuf(buf, length);
+	memcpy(buf->data + buf->offset, data, length);
+	buf->offset += length;
+	put_cpu();
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
+ *	Not irq- or preempt-safe - caller must provide synchronization.
+ */
+static inline void *relay_reserve(struct rchan *chan, unsigned length)
+{
+	void *reserved;
+	struct rchan_buf *buf = chan->buf[smp_processor_id()];
+
+	if (unlikely(buf->offset + length > buf->chan->subbuf_size)) {
+		length = relay_switch_subbuf(buf, length);
+		if (!length)
+			return NULL;
+	}
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

