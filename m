Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbVCHTpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbVCHTpO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 14:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbVCHTpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 14:45:13 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:41886 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262062AbVCHT3s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 14:29:48 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16941.64796.766807.503028@tut.ibm.com>
Date: Tue, 8 Mar 2005 13:29:32 -0600
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, karim@opersys.com
Subject: [PATCH] relayfs for linux-2.6.11-mm2
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Here's the latest version of relayfs, against linux-2.6.11-mm2.  I'm
hoping you'll consider putting this version back into your tree - the
previous rounds of comment seem to have shaken out all the API issues
and the number of comments on the code itself have also steadily
dwindled.

This patch is essentially the same as the relayfs redux part 5 patch,
with some minor changes based on reviewer comments.  Thanks again to
Pekka Enberg for those.  The patch size without documentation is now a
little smaller at just over 40k.  Here's a detailed list of the
changes:

- removed the attribute_flags in relay open and changed it to a
  boolean specifying either overwrite or no-overwrite mode, and removed
  everything referencing the attribute flags.
- added a check for NULL names in relayfs_create_entry()
- got rid of the unnecessary multiple labels in relay_create_buf()
- some minor simplification of relay_alloc_buf() which got rid of a
  couple params
- updated the Documentation

In addition, this version (through code contained in the relay-apps
tarball linked to below, not as part of the relayfs patch) tries to
make it as easy as possible to create the cooperating kernel/user
pieces of a typical and common type of logging application, one where
kernel logging is kicked off when a user space data collection app
starts and stops when the collection app exits, with the data being
automatically logged to disk in between.  To create this type of
application, you basically just include a header file (relay-app.h,
included in the relay-apps tarball) in your kernel module, define a
couple of callbacks and call an initialization function, and on the
user side call a single function that sets up and continuously
monitors the buffers, and writes data to files as it becomes
available.  Channels are created when the collection app is started
and destroyed when it exits, not when the kernel module is inserted,
so different channel buffer sizes can be specified for each separate
run via command-line options.  See the README in the relay-apps
tarball for details.

Also included in the relay-apps tarball are a couple examples
demonstrating how you can use this to create quick and dirty kernel
logging/debugging applications.  They are:

- tprintk, short for 'tee printk', which temporarily puts a kprobe on
  printk() and writes a duplicate stream of printk output to a relayfs
  channel.  This could be used anywhere there's printk() debugging code
  in the kernel which you'd like to exercise, but would rather not have
  your system logs cluttered with debugging junk.  You'd probably want
  to kill klogd while you do this, otherwise there wouldn't be much
  point (since putting a kprobe on printk() doesn't change the output
  of printk()).  I've used this method to temporarily divert the packet
  logging output of the iptables LOG target from the system logs to
  relayfs files instead, for instance.

- klog, which just provides a printk-like formatted logging function
  on top of relayfs.  Again, you can use this to keep stuff out of your
  system logs if used in place of printk.

The example applications can be found here:

http://prdownloads.sourceforge.net/dprobes/relay-apps.tar.gz?download


Thanks,

Tom


Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>

 Documentation/filesystems/relayfs.txt |  206 +++++++++++++
 fs/Kconfig                            |   12 
 fs/Makefile                           |    1 
 fs/relayfs/Makefile                   |    4 
 fs/relayfs/buffers.c                  |  195 ++++++++++++
 fs/relayfs/buffers.h                  |   12 
 fs/relayfs/inode.c                    |  423 +++++++++++++++++++++++++++
 fs/relayfs/relay.c                    |  530 ++++++++++++++++++++++++++++++++++
 fs/relayfs/relay.h                    |   12 
 include/linux/relayfs_fs.h            |  263 ++++++++++++++++
 10 files changed, 1658 insertions(+)

diff -urpN -X dontdiff linux-2.6.11-mm2/Documentation/filesystems/relayfs.txt linux-2.6.11-mm2-cur/Documentation/filesystems/relayfs.txt
--- linux-2.6.11-mm2/Documentation/filesystems/relayfs.txt	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.11-mm2-cur/Documentation/filesystems/relayfs.txt	2005-03-04 20:27:34.000000000 -0600
@@ -0,0 +1,206 @@
+
+relayfs - a high-speed data relay filesystem
+============================================
+
+relayfs is a filesystem designed to provide an efficient mechanism for
+tools and facilities to relay large and potentially sustained streams
+of data from kernel space to user space.
+
+The main abstraction of relayfs is the 'channel'.  A channel consists
+of a set of per-cpu kernel buffers each represented by a file in the
+relayfs filesystem.  Kernel clients write into a channel using
+efficient write functions which automatically log to the current cpu's
+channel buffer.  User space applications mmap() the per-cpu files and
+retrieve the data as it becomes available.
+
+The format of the data logged into the channel buffers is completely
+up to the relayfs client; relayfs does however provide hooks which
+allow clients to impose some stucture on the buffer data.  Nor does
+relayfs implement any form of data filtering - this also is left to
+the client.  The purpose is to keep relayfs as simple as possible.
+
+This document provides an overview of the relayfs API.  The details of
+the function parameters are documented along with the functions in the
+filesystem code - please see that for details.
+
+
+The relayfs user space API
+==========================
+
+relayfs implements basic file operations for user space access to
+relayfs channel buffer data.  Here are the file operations that are
+available and some comments regarding their behavior:
+
+open()	 enables user to open an _existing_ buffer.
+
+mmap()	 results in channel buffer being mapped into the caller's
+	 memory space.
+
+poll()	 POLLIN/POLLRDNORM/POLLERR supported.  User applications are
+	 notified when sub-buffer boundaries are crossed.
+
+close() decrements the channel buffer's refcount.  When the refcount
+	reaches 0 i.e. when no process or kernel client has the buffer
+	open, the channel buffer is freed.
+
+
+In order for a user application to make use of relayfs files, the
+relayfs filesystem must be mounted.  For example,
+
+	mount -t relayfs relayfs /mnt/relay
+
+NOTE:	relayfs doesn't need to be mounted for kernel clients to create
+	or use channels - it only needs to be mounted when user space
+	applications need access to the buffer data.
+
+
+The relayfs kernel API
+======================
+
+Here's a summary of the API relayfs provides to in-kernel clients:
+
+
+  channel management functions:
+
+    relay_open(base_filename, parent, subbuf_size, n_subbufs,
+               overwrite, callbacks)
+    relay_close(chan)
+    relay_flush(chan)
+    relay_reset(chan)
+    relayfs_create_dir(name, parent)
+    relayfs_remove_dir(dentry)
+    relay_commit(buf, reserved, count)
+    relay_subbufs_consumed(chan, cpu, subbufs_consumed)
+
+  write functions:
+
+    relay_write(chan, data, length)
+    __relay_write(chan, data, length)
+    relay_reserve(chan, length)
+
+  callbacks:
+
+    subbuf_start(buf, subbuf, prev_subbuf_idx, prev_subbuf)
+    deliver(buf, subbuf_idx, subbuf)
+    buf_mapped(buf, filp)
+    buf_unmapped(buf, filp)
+    buf_full(buf, subbuf_idx)
+
+
+A relayfs channel is made of up one or more per-cpu channel buffers,
+each implemented as a circular buffer subdivided into one or more
+sub-buffers.
+
+relay_open() is used to create a channel, along with its per-cpu
+channel buffers.  Each channel buffer will have an associated file
+created for it in the relayfs filesystem, which can be opened and
+mmapped from user space if desired.  The files are named
+basename0...basenameN-1 where N is the number of online cpus, and by
+default will be created in the root of the filesystem.  If you want a
+directory structure to contain your relayfs files, you can create it
+with relayfs_create_dir() and pass the parent directory to
+relay_open().  Clients are responsible for cleaning up any directory
+structure they create when the channel is closed - use
+relayfs_remove_dir() for that.
+
+The total size of each per-cpu buffer is calculated by multiplying the
+number of sub-buffers by the sub-buffer size passed into relay_open().
+The idea behind sub-buffers is that they're basically an extension of
+double-buffering to N buffers, and they also allow applications to
+easily implement random-access-on-buffer-boundary schemes, which can
+be important for some high-volume applications.  The number and size
+of sub-buffers is completely dependent on the application and even for
+the same application, different conditions will warrant different
+values for these parameters at different times.  Typically, the right
+values to use are best decided after some experimentation; in general,
+though, it's safe to assume that having only 1 sub-buffer is a bad
+idea - you're guaranteed to either overwrite data or lose events
+depending on the channel mode being used.
+
+relayfs channels can be opened in either of two modes - 'overwrite' or
+'no-overwrite'.  In overwrite mode, writes continuously cycle around
+the buffer and will never fail, but will unconditionally overwrite old
+data regardless of whether it's actually been consumed.  In
+no-overwrite mode, writes will fail i.e. data will be lost, if the
+number of unconsumed sub-buffers equals the total number of
+sub-buffers in the channel.  In this mode, the client is reponsible
+for notifying relayfs when sub-buffers have been consumed via
+relay_subbufs_consumed().  A full buffer will become 'unfull' and
+logging will continue once the client calls relay_subbufs_consumed()
+again.  When a buffer becomes full, the buf_full() callback is invoked
+to notify the client.  In both modes, the subbuf_start() callback will
+notify the client whenever a sub-buffer boundary is crossed.  This can
+be used to write header information into the new sub-buffer or fill in
+header information reserved in the previous sub-buffer.  One piece of
+information that's useful to save in a reserved header slot is the
+number of bytes of 'padding' for a sub-buffer, which is the amount of
+unused space at the end of a sub-buffer.  The padding count for each
+sub-buffer is contained in an array in the rchan_buf struct passed
+into the subbuf_start() callback: rchan_buf->padding[prev_subbuf_idx]
+can be used to to get the padding for the just-finished sub-buffer.
+subbuf_start() is also called for the first sub-buffer in each channel
+buffer when the channel is created.  The mode is specified to
+relay_open() using the overwrite parameter.
+
+kernel clients write data into the current cpu's channel buffer using
+relay_write() or __relay_write().  relay_write() is the main logging
+function - it uses local_irqsave() to protect the buffer and should be
+used if you might be logging from interrupt context.  If you know
+you'll never be logging from interrupt context, you can use
+__relay_write(), which only disables preemption.  These functions
+don't return a value, so you can't determine whether or not they
+failed - the assumption is that you wouldn't want to check a return
+value in the fast logging path anyway, and that they'll always succeed
+unless the buffer is full and in no-overwrite mode, in which case
+you'll be notified via the buf_full() callback.
+
+relay_reserve() is used to reserve a slot in a channel buffer which
+can be written to later.  This would typically be used in applications
+that need to write directly into a channel buffer without having to
+stage data in a temporary buffer beforehand.  Because the actual write
+may not happen immediately after the slot is reserved, applications
+using relay_reserve() can call relay_commit() to notify relayfs when
+the slot has actually been written.  When all the reserved slots have
+been committed, the deliver() callback is invoked to notify the client
+that a guaranteed full sub-buffer has been produced.  Because the
+write is under control of the client and is separated from the
+reserve, relay_reserve() doesn't protect the buffer at all - it's up
+to the client to provide the appropriate synchronization when using
+relay_reserve().
+
+The client calls relay_close() when it's finished using the channel.
+The channel and its associated buffers are destroyed when there are no
+longer any references to any of the channel buffers.  relay_flush()
+forces a sub-buffer switch on all the channel buffers, and can be used
+to finalize and process the last sub-buffers before the channel is
+closed.
+
+Some applications may want to keep a channel around and re-use it
+rather than open and close a new channel for each use.  relay_reset()
+can be used for this purpose - it resets a channel to its initial
+state without reallocating channel buffer memory or destroying
+existing mappings.  It should however only be called when it's safe to
+do so i.e. when the channel isn't currently being written to.
+
+Finally, there are a couple of utility callbacks that can be used for
+different purposes.  buf_mapped() is called whenever a channel buffer
+is mmapped from user space and buf_unmapped() is called when it's
+unmapped.  The client can use this notification to trigger actions
+within the kernel application, such as enabling/disabling logging to
+the channel.
+
+
+Credits
+=======
+
+The ideas and specs for relayfs came about as a result of discussions
+on tracing involving the following:
+
+Michel Dagenais		<michel.dagenais@polymtl.ca>
+Richard Moore		<richardj_moore@uk.ibm.com>
+Bob Wisniewski		<bob@watson.ibm.com>
+Karim Yaghmour		<karim@opersys.com>
+Tom Zanussi		<zanussi@us.ibm.com>
+
+Also thanks to Hubertus Franke for a lot of useful suggestions and bug
+reports.
diff -urpN -X dontdiff linux-2.6.11-mm2/fs/Kconfig linux-2.6.11-mm2-cur/fs/Kconfig
--- linux-2.6.11-mm2/fs/Kconfig	2005-03-04 20:25:51.000000000 -0600
+++ linux-2.6.11-mm2-cur/fs/Kconfig	2005-03-04 20:27:34.000000000 -0600
@@ -932,6 +932,18 @@ config RAMFS
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
diff -urpN -X dontdiff linux-2.6.11-mm2/fs/Makefile linux-2.6.11-mm2-cur/fs/Makefile
--- linux-2.6.11-mm2/fs/Makefile	2005-03-04 20:25:51.000000000 -0600
+++ linux-2.6.11-mm2-cur/fs/Makefile	2005-03-04 20:27:34.000000000 -0600
@@ -101,3 +101,4 @@ obj-$(CONFIG_HOSTFS)		+= hostfs/
 obj-$(CONFIG_HPPFS)		+= hppfs/
 obj-$(CONFIG_CACHEFS)		+= cachefs/
 obj-$(CONFIG_DEBUG_FS)		+= debugfs/
+obj-$(CONFIG_RELAYFS_FS)	+= relayfs/
diff -urpN -X dontdiff linux-2.6.11-mm2/fs/relayfs/Makefile linux-2.6.11-mm2-cur/fs/relayfs/Makefile
--- linux-2.6.11-mm2/fs/relayfs/Makefile	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.11-mm2-cur/fs/relayfs/Makefile	2005-03-04 20:27:34.000000000 -0600
@@ -0,0 +1,4 @@
+obj-$(CONFIG_RELAYFS_FS) += relayfs.o
+
+relayfs-y := relay.o inode.o buffers.o
+
diff -urpN -X dontdiff linux-2.6.11-mm2/fs/relayfs/buffers.c linux-2.6.11-mm2-cur/fs/relayfs/buffers.c
--- linux-2.6.11-mm2/fs/relayfs/buffers.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.11-mm2-cur/fs/relayfs/buffers.c	2005-03-04 20:27:34.000000000 -0600
@@ -0,0 +1,195 @@
+/*
+ * RelayFS buffer management code.
+ *
+ * Copyright (C) 2002-2005 - Tom Zanussi (zanussi@us.ibm.com), IBM Corp
+ * Copyright (C) 1999-2005 - Karim Yaghmour (karim@opersys.com)
+ *
+ * This file is released under the GPL.
+ */
+
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include <linux/mm.h>
+#include <linux/relayfs_fs.h>
+#include "relay.h"
+#include "buffers.h"
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
+ *	relay_mmap_buf: - mmap channel buffer to process address space
+ *	@buf: relay channel buffer
+ *	@vma: vm_area_struct describing memory to be mapped
+ *
+ *	Returns 0 if ok, negative on error
+ *
+ *	Caller should already have grabbed mmap_sem.
+ */
+int relay_mmap_buf(struct rchan_buf *buf, struct vm_area_struct *vma)
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
+/**
+ *	relay_alloc_buf - allocate a channel buffer
+ *	@buf: the buffer struct
+ *	@size: total size of the buffer
+ *
+ *	Returns a pointer to the resulting buffer, NULL if unsuccessful
+ */
+static void *relay_alloc_buf(struct rchan_buf *buf, unsigned long size)
+{
+	void *mem;
+	int i, j, n_pages;
+
+	size = PAGE_ALIGN(size);
+	n_pages = size >> PAGE_SHIFT;
+
+	buf->page_array = kcalloc(n_pages, sizeof(struct page *), GFP_KERNEL);
+	if (!buf->page_array)
+		return NULL;
+
+	for (i = 0; i < n_pages; i++) {
+		buf->page_array[i] = alloc_page(GFP_KERNEL);
+		if (unlikely(!buf->page_array[i]))
+			goto depopulate;
+	}
+	mem = vmap(buf->page_array, n_pages, GFP_KERNEL, PAGE_KERNEL);
+	if (!mem)
+		goto depopulate;
+
+	memset(mem, 0, size);
+	buf->page_count = n_pages;
+	return mem;
+
+depopulate:
+	for (j = 0; j < i; j++)
+		__free_page(buf->page_array[j]);
+	kfree(buf->page_array);
+	return NULL;
+}
+
+/**
+ *	relay_create_buf - allocate and initialize a channel buffer
+ *	@alloc_size: size of the buffer to allocate
+ *	@n_subbufs: number of sub-buffers in the channel
+ *
+ *	Returns channel buffer if successful, NULL otherwise
+ */
+struct rchan_buf *relay_create_buf(struct rchan *chan)
+{
+	struct rchan_buf *buf = kcalloc(1, sizeof(struct rchan_buf), GFP_KERNEL);
+	if (!buf)
+		return NULL;
+
+	buf->padding = kmalloc(chan->n_subbufs * sizeof(unsigned *), GFP_KERNEL);
+	if (!buf->padding)
+		goto free_buf;
+	
+	buf->commit = kmalloc(chan->n_subbufs * sizeof(unsigned *), GFP_KERNEL);
+	if (!buf->commit)
+		goto free_buf;
+
+	buf->start = relay_alloc_buf(buf, chan->alloc_size);
+	if (!buf->start)
+		goto free_buf;
+
+	buf->chan = chan;
+	kref_get(&buf->chan->kref);
+	return buf;
+
+free_buf:
+	kfree(buf->commit);
+	kfree(buf->padding);
+	kfree(buf);
+	return NULL;
+}
+
+/**
+ *	relay_destroy_buf - destroy an rchan_buf struct and associated buffer
+ *	@buf: the buffer struct
+ */
+void relay_destroy_buf(struct rchan_buf *buf)
+{
+	struct rchan *chan = buf->chan;
+	int i;
+
+	if (likely(buf->start)) {
+		vunmap(buf->start);
+		for (i = 0; i < buf->page_count; i++)
+			__free_page(buf->page_array[i]);
+		kfree(buf->page_array);
+	}
+	kfree(buf->padding);
+	kfree(buf->commit);
+	kfree(buf);
+	kref_put(&chan->kref, relay_destroy_channel);
+}
+
+/**
+ *	relay_remove_buf - remove a channel buffer
+ *
+ *	Removes the file from the relayfs fileystem, which also frees the
+ *	rchan_buf_struct and the channel buffer.  Should only be called from
+ *	kref_put().
+ */
+void relay_remove_buf(struct kref *kref)
+{
+	struct rchan_buf *buf = container_of(kref, struct rchan_buf, kref);
+	relayfs_remove(buf->dentry);
+}
diff -urpN -X dontdiff linux-2.6.11-mm2/fs/relayfs/buffers.h linux-2.6.11-mm2-cur/fs/relayfs/buffers.h
--- linux-2.6.11-mm2/fs/relayfs/buffers.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.11-mm2-cur/fs/relayfs/buffers.h	2005-03-04 20:27:34.000000000 -0600
@@ -0,0 +1,12 @@
+#ifndef _BUFFERS_H
+#define _BUFFERS_H
+
+/* This inspired by rtai/shmem */
+#define FIX_SIZE(x) (((x) - 1) & PAGE_MASK) + PAGE_SIZE
+
+extern int relay_mmap_buf(struct rchan_buf *buf, struct vm_area_struct *vma);
+extern struct rchan_buf *relay_create_buf(struct rchan *chan);
+extern void relay_destroy_buf(struct rchan_buf *buf);
+extern void relay_remove_buf(struct kref *kref);
+
+#endif/* _BUFFERS_H */
diff -urpN -X dontdiff linux-2.6.11-mm2/fs/relayfs/inode.c linux-2.6.11-mm2-cur/fs/relayfs/inode.c
--- linux-2.6.11-mm2/fs/relayfs/inode.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.11-mm2-cur/fs/relayfs/inode.c	2005-03-04 20:27:34.000000000 -0600
@@ -0,0 +1,423 @@
+/*
+ * VFS-related code for RelayFS, a high-speed data relay filesystem.
+ *
+ * Copyright (C) 2003-2005 - Tom Zanussi <zanussi@us.ibm.com>, IBM Corp
+ * Copyright (C) 2003-2005 - Karim Yaghmour <karim@opersys.com>
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
+#include "buffers.h"
+
+#define RELAYFS_MAGIC			0xF0B4A981
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
+		buf = relay_create_buf(chan);
+		if (!buf)
+			return NULL;
+	}
+	
+	inode = new_inode(sb);
+	if (!inode) {
+		relay_destroy_buf(buf);
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
+ *
+ *	Returns the new dentry, NULL on failure
+ *
+ *	Creates a file or directory with the specifed permissions.
+ */
+static struct dentry *relayfs_create_entry(const char *name,
+					   struct dentry *parent,
+					   int mode,
+					   struct rchan *chan)
+{
+	struct qstr qname;
+	struct dentry *d;
+	struct inode *inode;
+	int error = 0;
+
+	BUG_ON(!name || !(S_ISREG(mode) || S_ISDIR(mode)));
+
+	error = simple_pin_fs("relayfs", &relayfs_mount, &relayfs_mount_count);
+	if (error) {
+		printk(KERN_ERR "Couldn't mount relayfs: errcode %d\n", error);
+		return NULL;
+	}
+
+	qname.name = name;
+	qname.len = strlen(name);
+	qname.hash = full_name_hash(name, qname.len);
+
+	if (!parent && relayfs_mount && relayfs_mount->mnt_sb)
+		parent = relayfs_mount->mnt_sb->s_root;
+
+	if (!parent) {
+		simple_release_fs(&relayfs_mount, &relayfs_mount_count);
+		return NULL;
+	}
+
+	parent = dget(parent);
+	down(&parent->d_inode->i_sem);
+	d = lookup_hash(&qname, parent);
+	if (IS_ERR(d)) {
+		d = NULL;
+		goto release_mount;
+	}
+
+	if (d->d_inode) {
+		d = NULL;
+		goto release_mount;
+	}
+
+	inode = relayfs_get_inode(parent->d_inode->i_sb, mode, chan);
+	if (!inode) {
+		d = NULL;
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
+	up(&parent->d_inode->i_sem);
+	dput(parent);
+	return d;
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
+	if (!mode)
+		mode = S_IRUSR;
+	mode = (mode & S_IALLUGO) | S_IFREG;
+
+	return relayfs_create_entry(name, parent, mode, chan);
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
+	int mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
+	return relayfs_create_entry(name, parent, mode, NULL);
+}
+
+/**
+ *	relayfs_remove - remove a file or directory in the relay filesystem
+ *	@dentry: file or directory dentry
+ */
+int relayfs_remove(struct dentry *dentry)
+{
+	struct dentry *parent = dentry->d_parent;
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
+ *	Increments the channel buffer refcount.
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
+ *	Calls upon relay_mmap_buf to map the file into user space.
+ */
+int relayfs_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct inode *inode = filp->f_dentry->d_inode;
+	return relay_mmap_buf(RELAYFS_I(inode)->buf, vma);
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
+	kref_put(&buf->kref, relay_remove_buf);
+
+	return 0;
+}
+
+/**
+ *	relayfs alloc_inode() implementation
+ */
+static struct inode *relayfs_alloc_inode(struct super_block *sb)
+{
+	struct relayfs_inode_info *p = kmem_cache_alloc(relayfs_inode_cachep, SLAB_KERNEL);
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
+		relay_destroy_buf(RELAYFS_I(inode)->buf);
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
diff -urpN -X dontdiff linux-2.6.11-mm2/fs/relayfs/relay.c linux-2.6.11-mm2-cur/fs/relayfs/relay.c
--- linux-2.6.11-mm2/fs/relayfs/relay.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.11-mm2-cur/fs/relayfs/relay.c	2005-03-04 20:27:34.000000000 -0600
@@ -0,0 +1,530 @@
+/*
+ * Public API and common code for RelayFS.
+ *
+ * See Documentation/filesystems/relayfs.txt for an overview of relayfs.
+ *
+ * Copyright (C) 2002-2005 - Tom Zanussi (zanussi@us.ibm.com), IBM Corp
+ * Copyright (C) 1999-2005 - Karim Yaghmour (karim@opersys.com)
+ *
+ * This file is released under the GPL.
+ */
+
+#include <linux/errno.h>
+#include <linux/stddef.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/string.h>
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
+	if (buf->chan->overwrite)
+		return 0;
+
+	produced = atomic_read(&buf->subbufs_produced);
+	consumed = atomic_read(&buf->subbufs_consumed);
+
+	return (produced - consumed > buf->chan->n_subbufs - 1) ? 1 : 0;
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
+static int subbuf_start_default_callback (struct rchan_buf *buf,
+					  void *subbuf,
+					  unsigned prev_subbuf_idx,
+					  void *prev_subbuf)
+{
+	return 0;
+}
+
+/*
+ * deliver() default callback.  Does nothing.
+ */
+static void deliver_default_callback (struct rchan_buf *buf,
+				      unsigned subbuf_idx,
+				      void *subbuf)
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
+static void buf_full_default_callback(struct rchan_buf *buf,
+				      unsigned subbuf_idx,
+				      void *subbuf)
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
+	if (next >= buf->start + buf->chan->subbuf_size * buf->chan->n_subbufs)
+		next = buf->start;
+
+	return next;
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
+	atomic_set(&buf->unfull, 0);
+	buf->finalized = 0;
+	buf->data = buf->start;
+	buf->offset = 0;
+
+	for (i = 0; i < buf->chan->n_subbufs; i++) {
+		buf->padding[i] = 0;
+		buf->commit[i] = 0;
+	}
+
+	buf->offset = buf->chan->cb->subbuf_start(buf, buf->data, 0, NULL);
+	buf->commit[0] = buf->offset;
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
+	if (!chan)
+		return;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!chan->buf[i])
+			continue;
+		__relay_reset(chan->buf[i], 0);
+	}
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
+/**
+ *	relay_close_buf - close a channel buffer
+ *	@buf: channel buffer
+ *
+ *	Marks the buffer finalized and restores the default callbacks.
+ *	The channel buffer and channel buffer data structure are then freed
+ *	automatically when the last reference is given up.
+ */
+static inline void relay_close_buf(struct rchan_buf *buf)
+{
+	buf->finalized = 1;
+	buf->chan->cb = &default_channel_callbacks;
+	kref_put(&buf->kref, relay_remove_buf);
+}
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
+ *	@overwrite: overwrite buffer when full?
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
+			 int overwrite,
+			 struct rchan_callbacks *cb)
+{
+	int i;
+	struct rchan *chan;
+	char *tmpname;
+
+	if (!base_filename)
+		return NULL;
+
+	if (!(subbuf_size && n_subbufs))
+		return NULL;
+	
+	chan = kcalloc(1, sizeof(struct rchan), GFP_KERNEL);
+	if (!chan)
+		return NULL;
+
+	chan->version = RELAYFS_CHANNEL_VERSION;
+	chan->overwrite = overwrite;
+	chan->n_subbufs = n_subbufs;
+	chan->subbuf_size = subbuf_size;
+	chan->alloc_size = FIX_SIZE(subbuf_size * n_subbufs);
+	setup_callbacks(chan, cb);
+	kref_init(&chan->kref);
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
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!chan->buf[i])
+			break;
+		relay_close_buf(chan->buf[i]);
+	}
+	kfree(tmpname);
+
+free_chan:
+	kref_put(&chan->kref, relay_destroy_channel);
+	return NULL;
+}
+
+/**
+ *	deliver_check - deliver a guaranteed full sub-buffer if applicable
+ */
+static inline void deliver_check(struct rchan_buf *buf,
+				 unsigned subbuf_idx)
+{
+	void *subbuf;
+	unsigned full = buf->chan->subbuf_size - buf->padding[subbuf_idx];
+
+	if (buf->commit[subbuf_idx] == full) {
+		subbuf = buf->start + subbuf_idx * buf->chan->subbuf_size;
+		buf->chan->cb->deliver(buf, subbuf_idx, subbuf);
+	}
+}
+
+/**
+ *	do_switch - change subbuf pointer and do related bookkeeping
+ */
+static inline void do_switch(struct rchan_buf *buf, unsigned new, unsigned old)
+{
+	unsigned start = 0;
+	void *old_data = buf->start + old * buf->chan->subbuf_size;
+
+	buf->data = get_next_subbuf(buf);
+	buf->padding[new] = 0;
+	start = buf->chan->cb->subbuf_start(buf, buf->data, old, old_data);
+	buf->offset = buf->commit[new] = start;
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
+	int new, old, produced = atomic_read(&buf->subbufs_produced);
+	unsigned padding;
+
+	if (atomic_read(&buf->unfull)) {
+		atomic_set(&buf->unfull, 0);
+		new = produced % buf->chan->n_subbufs;
+		old = (produced - 1) % buf->chan->n_subbufs;
+		do_switch(buf, new, old);
+		return 0;
+	}
+	
+	if (unlikely(relay_buf_full(buf)))
+		return 0;
+
+	old = produced % buf->chan->n_subbufs;
+	padding = buf->chan->subbuf_size - buf->offset;
+	buf->padding[old] = padding;
+	deliver_check(buf, old);
+	buf->offset = buf->chan->subbuf_size;
+	atomic_inc(&buf->subbufs_produced);
+
+	if (waitqueue_active(&buf->read_wait)) {
+		PREPARE_WORK(&buf->wake_readers, wakeup_readers, buf);
+		schedule_delayed_work(&buf->wake_readers, 1);
+	}
+
+	if (unlikely(relay_buf_full(buf))) {
+		void *old_data = buf->start + old * buf->chan->subbuf_size;
+		buf->chan->cb->buf_full(buf, old, old_data);
+		return 0;
+	}
+
+	new = (produced + 1) % buf->chan->n_subbufs;
+	do_switch(buf, new, old);
+
+	return length;
+}
+
+/**
+ *	relay_commit - add count bytes to a sub-buffer's commit count
+ *	@buf: channel buffer
+ *	@reserved: reserved address associated with commit
+ *	@count: number of bytes committed
+ *
+ *	Invokes deliver() callback if sub-buffer is completely written.
+ */
+void relay_commit(struct rchan_buf *buf,
+		  void *reserved,
+		  unsigned count)
+{
+	unsigned offset, subbuf_idx;
+
+	offset = reserved - buf->start;
+	subbuf_idx = offset / buf->chan->subbuf_size;
+	buf->commit[subbuf_idx] += count;
+	deliver_check(buf, subbuf_idx);
+}
+
+/**
+ *	relay_subbufs_consumed - update the buffer's sub-buffers-consumed count
+ *	@chan: the channel
+ *	@cpu: the cpu associated with the channel buffer to update
+ *	@subbufs_consumed: number of sub-buffers to add to current buf's count
+ *
+ *	Adds to the channel buffer's consumed sub-buffer count.
+ *	subbufs_consumed should be the number of sub-buffers newly consumed,
+ *	not the total consumed.
+ *
+ *	NOTE: kernel clients don't need to call this function if the channel
+ *	mode is 'overwrite'.
+ */
+void relay_subbufs_consumed(struct rchan *chan, int cpu, int subbufs_consumed)
+{
+	int produced, consumed;
+	struct rchan_buf *buf;
+
+	if (!chan)
+		return;
+
+	if (cpu >= NR_CPUS || !chan->buf[cpu])
+		return;
+	
+	buf = chan->buf[cpu];
+	if (relay_buf_full(buf))
+		atomic_set(&buf->unfull, 1);
+
+	atomic_add(subbufs_consumed, &buf->subbufs_consumed);
+	produced = atomic_read(&buf->subbufs_produced);
+	consumed = atomic_read(&buf->subbufs_consumed);
+	if (consumed > produced)
+		atomic_set(&buf->subbufs_consumed, produced);
+}
+
+/**
+ *	relay_destroy_channel - free the channel struct
+ *
+ *	Should only be called from kref_put().
+ */
+void relay_destroy_channel(struct kref *kref)
+{
+	struct rchan *chan = container_of(kref, struct rchan, kref);
+	kfree(chan);
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
+	if (!chan)
+		return;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!chan->buf[i])
+			continue;
+		relay_close_buf(chan->buf[i]);
+	}
+
+	kref_put(&chan->kref, relay_destroy_channel);
+}
+
+/**
+ *	relay_flush - close the channel
+ *	@chan: the channel
+ *
+ *	Flushes all channel buffers i.e. forces buffer switch.
+ */
+void relay_flush(struct rchan *chan)
+{
+	int i;
+
+	if (!chan)
+		return;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!chan->buf[i])
+			continue;
+		relay_switch_subbuf(chan->buf[i], 0);
+	}
+}
+
+EXPORT_SYMBOL_GPL(relay_open);
+EXPORT_SYMBOL_GPL(relay_close);
+EXPORT_SYMBOL_GPL(relay_flush);
+EXPORT_SYMBOL_GPL(relay_reset);
+EXPORT_SYMBOL_GPL(relay_subbufs_consumed);
+EXPORT_SYMBOL_GPL(relay_commit);
+EXPORT_SYMBOL_GPL(relay_switch_subbuf);
diff -urpN -X dontdiff linux-2.6.11-mm2/fs/relayfs/relay.h linux-2.6.11-mm2-cur/fs/relayfs/relay.h
--- linux-2.6.11-mm2/fs/relayfs/relay.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.11-mm2-cur/fs/relayfs/relay.h	2005-03-04 20:27:34.000000000 -0600
@@ -0,0 +1,12 @@
+#ifndef _RELAY_H
+#define _RELAY_H
+
+struct dentry *relayfs_create_file(const char *name,
+				   struct dentry *parent,
+				   int mode,
+				   struct rchan *chan);
+extern int relayfs_remove(struct dentry *dentry);
+extern int relay_buf_empty(struct rchan_buf *buf);
+extern void relay_destroy_channel(struct kref *kref);
+
+#endif /* _RELAY_H */
diff -urpN -X dontdiff linux-2.6.11-mm2/include/linux/relayfs_fs.h linux-2.6.11-mm2-cur/include/linux/relayfs_fs.h
--- linux-2.6.11-mm2/include/linux/relayfs_fs.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.11-mm2-cur/include/linux/relayfs_fs.h	2005-03-04 20:27:34.000000000 -0600
@@ -0,0 +1,263 @@
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
+ * Per-cpu relay channel buffer
+ */
+struct rchan_buf
+{
+	void *start;			/* start of channel buffer */
+	void *data;			/* start of current sub-buffer */
+	unsigned offset;		/* current offset into sub-buffer */
+	atomic_t subbufs_produced;	/* count of sub-buffers produced */
+	atomic_t subbufs_consumed;	/* count of sub-buffers consumed */
+	atomic_t unfull;		/* state has gone from full to not */
+	struct rchan *chan;		/* associated channel */
+	wait_queue_head_t read_wait;	/* reader wait queue */
+	struct work_struct wake_readers; /* reader wake-up work struct */
+	struct dentry *dentry;		/* channel file dentry */
+	struct kref kref;		/* channel buffer refcount */
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
+	int overwrite;			/* overwrite buffer when full? */
+	struct rchan_callbacks *cb;	/* client callbacks */
+	struct kref kref;		/* channel refcount */
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
+	 * @prev_subbuf: the start of the previous sub-buffer
+	 *
+	 * NOTE: subbuf_start will also be invoked when the buffer is
+	 *       created, so that the first sub-buffer can be initialized
+	 *       if necessary.  In this case, prev_subbuf will be NULL.
+	 */
+	int (*subbuf_start) (struct rchan_buf *buf,
+			     void *subbuf,
+			     unsigned prev_subbuf_idx,
+			     void *prev_subbuf);
+
+	/*
+	 * deliver - deliver a guaranteed full sub-buffer to client
+	 * @buf: the channel buffer containing the sub-buffer
+	 * @subbuf_idx: the sub-buffer's index
+	 * @subbuf: the start of the new sub-buffer
+	 *
+	 * Only works if relay_commit is also used
+	 */
+	void (*deliver) (struct rchan_buf *buf,
+			 unsigned subbuf_idx,
+			 void *subbuf);
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
+	 * @subbuf_idx: the current sub-buffer's index
+	 * @subbuf: the start of the current sub-buffer
+	 *
+	 * Called when a relayfs buffer becomes full
+	 */
+        void (*buf_full)(struct rchan_buf *buf,
+			 unsigned subbuf_idx,
+			 void *subbuf);
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
+			 int overwrite,
+			 struct rchan_callbacks *cb);
+extern void relay_close(struct rchan *chan);
+extern void relay_flush(struct rchan *chan);
+extern void relay_subbufs_consumed(struct rchan *chan,
+				   int cpu,
+				   int subbufs_consumed);
+extern void relay_reset(struct rchan *chan);
+extern unsigned relay_switch_subbuf(struct rchan_buf *buf,
+				    unsigned length);
+extern void relay_commit(struct rchan_buf *buf,
+			 void *reserved,
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
+ *	Protects the buffer by disabling interrupts.  Use this
+ *	if you might be logging from interrupt context.  Try
+ *	__relay_write() if you know you	won't be logging from
+ *	interrupt context.
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
+ *	Protects the buffer by disabling preemption.  Use
+ *	relay_write() if you might be logging from interrupt
+ *	context.
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
+ *	Reserves a slot in the current cpu's channel buffer.
+ *	Does not protect the buffer at all - caller must provide
+ *	appropriate synchronization.
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

