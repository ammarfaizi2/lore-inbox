Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262192AbVATWqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbVATWqv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 17:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262203AbVATWqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 17:46:51 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:998 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id S262192AbVATWoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 17:44:34 -0500
Message-ID: <41F0344C.1030404@oracle.com>
Date: Thu, 20 Jan 2005 14:44:28 -0800
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC] tracepipe -- event streams, debugfs, and pipe_buffers
Content-Type: multipart/mixed;
 boundary="------------050901050004030508000903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050901050004030508000903
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This quick tracepipe patch is an attempt to make it trivial for a
developer to generate debugging traces in the kernel and get them to
mass storage without having the tracing enormously skew behaviour.  It
is built off of Greg's debugfs and Linus' advocacy of efficient buffer
transit with pipes and pipe_buffers.

A kernel subsystem registers a file in debugfs and gets a struct cookie
in return.  The file that is created uses fs/pipe's file_operations but
wraps its own open and release tracking around it.

While it's running the kernel subsystem can send binary blobs, less than
the length of a page, down this channel.  The blobs are copied into
per-cpu lists of pages.  Cutesy little headers with get_cycles() and the
cpu id are prepended to each blob.  The traces are only recorded if user
space has open references to the file.

As the pages fill they're kicked off to a work_struct worker who puts
them in the bufs[] array in the debugfs pipe file.  Userspace can then
do whatever it wants with the data via the pipe.  One can imagine it
wanting to splice() these pages to disk in huge batches, or perhaps some
zero-copy network card, etc.  I've only tested this so far as verifying
that 'cat' is able to push data into a regular file.

I didn't aim for for optimal behaviour before sending this patch out.
I'm looking for comments.  There's lots of room for improvement,
particularly in reducing synchronization between cpus (not as it fills
each dinky page) and in more flexible buffering semantics.  As written
there is no support for cyclic lists of pages rather than streaming nor
are a huge amount of pending pages allowed.  debugfs masks the mode of
the file so it appears to be a regular file, but that'd be trivial to
fix if this is methodology is useful.

Thoughts?  I, for one, am tired of writing throw-away per-cpu tracing
patches ;)

--------------050901050004030508000903
Content-Type: text/x-patch;
 name="tracepipe-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tracepipe-2.patch"

Index: 2.6-mm-tracepipe/fs/Makefile
===================================================================
--- 2.6-mm-tracepipe.orig/fs/Makefile	2005-01-20 10:37:50.000000000 -0800
+++ 2.6-mm-tracepipe/fs/Makefile	2005-01-20 11:01:47.000000000 -0800
@@ -45,6 +45,8 @@
 obj-y				+= devpts/
 
 obj-$(CONFIG_PROFILING)		+= dcookies.o
+
+obj-$(CONFIG_DEBUG_TRACEPIPE)	+= tracepipe.o
  
 # Do not add any filesystems before this line
 obj-$(CONFIG_FSCACHE)		+= fscache/
Index: 2.6-mm-tracepipe/fs/pipe.c
===================================================================
--- 2.6-mm-tracepipe.orig/fs/pipe.c	2005-01-20 10:37:50.000000000 -0800
+++ 2.6-mm-tracepipe/fs/pipe.c	2005-01-20 12:58:35.000000000 -0800
@@ -107,7 +107,7 @@
 	kunmap(buf->page);
 }
 
-static struct pipe_buf_operations anon_pipe_buf_ops = {
+struct pipe_buf_operations anon_pipe_buf_ops = {
 	.can_merge = 1,
 	.map = anon_pipe_buf_map,
 	.unmap = anon_pipe_buf_unmap,
@@ -486,7 +486,7 @@
 }
 
 
-static int
+int
 pipe_read_release(struct inode *inode, struct file *filp)
 {
 	pipe_read_fasync(-1, filp, 0);
@@ -511,7 +511,7 @@
 	return pipe_release(inode, decr, decw);
 }
 
-static int
+int
 pipe_read_open(struct inode *inode, struct file *filp)
 {
 	/* We could have perhaps used atomic_t, but this and friends
Index: 2.6-mm-tracepipe/fs/tracepipe.c
===================================================================
--- 2.6-mm-tracepipe.orig/fs/tracepipe.c	2004-02-23 13:02:56.000000000 -0800
+++ 2.6-mm-tracepipe/fs/tracepipe.c	2005-01-20 14:10:42.544825265 -0800
@@ -0,0 +1,536 @@
+/*
+ *  Copyright (C) 2004 Oracle Inc.
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License version
+ *	2 as published by the Free Software Foundation.
+ *
+ * XXX
+ * 	- func in PIPE_WAIT to kick work queue on POLL_OUT after read
+ * 	- actually communicate missed to userspace
+ * 	- how to specify wrapping or dropping
+ * 	- non-temporal stores into bufs
+ * 	- let caller reserve space and get a pointer into buf
+ * 	- could more aggressively use free space in bufs, but not cheaply
+ * 	- per-interrupting state instaed of per cpu
+ * 	- make sure pages are allocated near cpus
+ * 	- if we keep tiny pipe_buffer allocations, use slab
+ * 	- {un,}likely() annotation 
+ * 	- get some .owner story
+ */
+/*#define DEBUG*/
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/pagemap.h>
+#include <linux/pipe_fs_i.h>
+#include <linux/debugfs.h>
+#include <linux/workqueue.h>
+
+/* this serializes create, remove, open, and release.. I wonder how 
+ * much is really needed */
+static DECLARE_MUTEX(tracepipe_sem);
+static struct dentry *tracepipe_dentry;
+
+struct trace_per_cpu {
+	unsigned long		enabled;
+	uint64_t		missed;
+	/* these are cached to avoid page_address() and some math in the 
+	 * _event() path.. dunno if that's really worth it */
+	void			*next_region;
+	unsigned int		region_space;
+	struct pipe_buffer	*active;
+};
+
+/* totally arbitrary */
+#define TRACEPIPE_PAGES_PER_CHANNEL ((64 * 1024) / PAGE_SIZE) 
+
+struct trace_channel {
+	struct dentry		*dentry;
+	struct work_struct	to_inode_work;
+
+	/* this is a compromise for simplicity in this proof of concept.  For
+	 * now cpus synchronize as they complete pages.  I would prefer per-cpu
+	 * waiting and full tracking with more forgiving synchronization. */
+	spinlock_t		bufs_lock;
+	struct list_head	waiting_bufs;
+	struct list_head	full_bufs;
+	unsigned int		needed_bufs;
+
+	struct trace_per_cpu cpu_data[NR_CPUS] ____cacheline_aligned_in_smp;
+};
+
+struct trace_header {
+	u64	cycles;
+	u16	cpu;
+} __attribute__((packed));
+
+static void free_chan_pages(struct list_head *list, unsigned int nr)
+{
+	struct page *page;
+	struct pipe_buffer *buf;
+
+	while (!list_empty(list) && nr-- > 0) {
+		page = list_entry(list->next, struct page, lru);
+		list_del_init(&page->lru);
+
+		buf = (struct pipe_buffer *)page->private;
+		kfree(buf);
+		page->private = 0;
+		__free_page(page);
+	}
+}
+
+static int alloc_chan_pages(struct list_head *list, unsigned int nr)
+{
+	struct page *page = NULL;
+	struct pipe_buffer *buf = NULL;
+	int ret = 0;
+	unsigned int i;
+
+	for (i = 0; i < nr; i++) {
+		page = alloc_page(GFP_KERNEL);
+		buf = kmalloc(sizeof(*buf), GFP_KERNEL);
+		if (page == NULL || buf == NULL) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		buf->page = page;
+		buf->offset = 0;
+		buf->len = 0;
+		buf->ops = &anon_pipe_buf_ops;
+
+		page->private = (unsigned long)buf;
+		list_add_tail(&page->lru, list);
+
+		buf = NULL;
+		page = NULL;
+		ret++;
+	}
+
+	if (buf)
+		kfree(buf);
+	if (page)
+		__free_page(page);
+	if (ret < 0)
+		free_chan_pages(list, ~0);
+	return ret;
+}
+
+/* for now we transfer buffers from the channel's list onto the actual
+ * pipe_inode_info from a work queue.  This should be changed, of course */ 
+static void tracepipe_to_inode(void *data)
+{
+	struct trace_channel *chan = data;
+	struct inode *inode = chan->dentry->d_inode;
+	struct pipe_inode_info *info = inode->i_pipe;
+	LIST_HEAD(pages);
+	unsigned long flags;
+	int do_wakeup = 0, alloced;
+	struct pipe_buffer *dest, *src;
+	struct page *page;
+
+	/* 
+	 * This is goofy for now.
+	 *
+	 * We want to pull as many bufs as we can from the channel's full
+	 * list and put it in the pipe.  We want to replace these bufs
+	 * with new pages in the channel's waiting list.  We also want
+	 * to top off the waiting list to fill any existing defecit so it
+	 * totals PAGES_PER_CHANNEL when we're done.
+	 *
+	 * The wiggle is that pages in the channel can be consumed while
+	 * we're off allocating.  So for now we just allocate a full
+	 * PAGES_PER_CHANNEL (don't hit me!) and only use as many as we need
+	 * come time to transfer things.
+	 *
+	 * This will obviously be improved once there is consensus on
+	 * just what the buffering semantics should be.
+	 */
+	alloced = alloc_chan_pages(&pages, TRACEPIPE_PAGES_PER_CHANNEL);
+	if (alloced < 0)
+		goto out;
+
+	/* lost race with close, they'll synchronize on our completion
+	 * and teardown the buffers */
+	if (!PIPE_READERS(*inode))
+		goto out;
+
+	down(PIPE_SEM(*inode));
+	spin_lock_irqsave(&chan->bufs_lock, flags);
+
+	for ( ; info->nrbufs < PIPE_BUFFERS; info->nrbufs++) {
+		if (list_empty(&chan->full_bufs))
+			break;
+		/* pluck a full page and append it to the pipe */
+		page = list_entry(chan->full_bufs.next, struct page, lru);
+		list_del_init(&page->lru);
+		chan->needed_bufs++;
+
+		src = (struct pipe_buffer *)page->private;
+		pr_debug("moving page %p to inode %p\n", page, inode);
+		dest = info->bufs + ((info->curbuf + info->nrbufs) &
+		       (PIPE_BUFFERS-1));
+		page->private = 0;
+		*dest = *src;
+		do_wakeup = 1;
+
+		/* reuse our pipe_buffer to put a new page in waiting */
+		if (list_empty(&pages)) {
+			kfree(src);
+			continue;
+		}
+
+		pr_debug("put page %p on inode %p's waiting\n", page, inode);
+		page = list_entry(pages.next, struct page, lru);
+		list_move_tail(&page->lru, &chan->waiting_bufs);
+		alloced--;
+
+		page->private = (unsigned long)src;
+		src->page = page;
+		src->offset = 0;
+		src->len = 0;
+	}
+
+	if (chan->needed_bufs && alloced) {
+		if (alloced > chan->needed_bufs)
+			free_chan_pages(&pages, alloced - chan->needed_bufs);
+		list_splice_init(&pages, &chan->waiting_bufs);
+	}
+
+	spin_unlock_irqrestore(&chan->bufs_lock, flags);
+	up(PIPE_SEM(*inode));
+
+	if (do_wakeup) {
+		pr_debug("waking up pipe waiters\n");
+		wake_up_interruptible_sync(PIPE_WAIT(*inode));
+		kill_fasync(PIPE_FASYNC_READERS(*inode), SIGIO, POLL_IN);
+	}
+out:
+	free_chan_pages(&pages, ~0);
+}
+
+/* must be called with chan->bufs_lock held */
+static void active_to_chan(struct trace_channel *chan,
+			   struct trace_per_cpu *tcpu)
+{
+	struct pipe_buffer *buf;
+	struct page *page;
+
+	buf = tcpu->active;
+	buf->len = PAGE_SIZE - tcpu->region_space;
+
+	page = buf->page;
+	list_add_tail(&page->lru, &chan->full_bufs);
+	tcpu->active = NULL;
+
+	schedule_work(&chan->to_inode_work);
+
+}
+
+static void tracepipe_update_enabled(void *val)
+{
+	struct trace_channel *chan = val;
+	struct inode *inode = chan->dentry->d_inode;
+	int cpu = get_cpu(); /* smp_processor_id? */
+	struct trace_per_cpu *tcpu = &chan->cpu_data[cpu];
+
+	tcpu->enabled = PIPE_READERS(*inode) ? 1 : 0;
+
+	pr_debug("cpu %d has enabled %lu\n", cpu, tcpu->enabled);
+
+	if (!tcpu->enabled && tcpu->active)
+		active_to_chan(chan, tcpu);
+
+	put_cpu();
+}
+
+static int tracepipe_open(struct inode *inode, struct file *filp)
+{
+	struct trace_channel *chan;
+	int ret;
+
+	down(&tracepipe_sem);
+
+	/* look for racing with an in-kernel tracepipe_remove() */
+	chan = inode->u.generic_ip;
+	if (chan == NULL) {
+		ret = -EIO;
+		goto out;
+	}
+
+	ret = pipe_read_open(inode, filp);
+	if (ret)
+		goto out;
+
+	if (PIPE_READERS(*inode) == 1) {
+		ret = alloc_chan_pages(&chan->waiting_bufs,
+				       TRACEPIPE_PAGES_PER_CHANNEL);
+		if (ret > 0) {
+			chan->needed_bufs = TRACEPIPE_PAGES_PER_CHANNEL - ret;
+			on_each_cpu(tracepipe_update_enabled, chan, 0, 1);
+			ret = 0;
+		}
+	}
+
+	if (ret)
+		pipe_read_release(inode, filp);
+
+out:
+	up(&tracepipe_sem);
+	return ret;
+}
+
+static int tracepipe_release(struct inode *inode, struct file *filp)
+{
+	struct trace_channel *chan;
+	int ret;
+
+	down(&tracepipe_sem);
+
+	/* look for racing with an in-kernel tracepipe_remove() */
+	chan = inode->u.generic_ip;
+	if (chan == NULL) {
+		ret = -EIO;
+		goto out;
+	}
+
+	ret = pipe_read_release(inode, filp);
+
+	if (PIPE_READERS(*inode) == 0) {
+		on_each_cpu(tracepipe_update_enabled, chan, 0, 1);
+		free_chan_pages(&chan->waiting_bufs, ~0);
+		free_chan_pages(&chan->full_bufs, ~0);
+	}
+
+out:
+	up(&tracepipe_sem);
+	return ret;
+}
+
+/**
+ * tracepipe_event - send bytes down a tracepipe channel
+ *
+ * @chan: the previously created channel from tracepipe_create_channel
+ * @data: the bytes to copy into the event stream
+ * @len: the number of bytes to copy
+ *
+ * This sends the given bytes down the referenced tracing pipe.  A header will
+ * be prepended to the bytes as they are copied into the stream.  
+ *
+ * This is intended to be light weight and safe to be called from any context.
+ * In the common case it disables interrupts on the cpu, copies the data, and
+ * returns.
+ *
+ * If there is no room for the new bytes the event will simply be dropped.
+ */
+void tracepipe_event(struct trace_channel *chan, void *data, unsigned int len)
+{
+	int cpu = get_cpu();
+	struct trace_per_cpu *tcpu = &chan->cpu_data[cpu];
+	unsigned long flags;
+	struct page *page;
+	struct trace_header *hdr;
+
+	if (len > PAGE_SIZE - sizeof(*hdr))
+		goto out;
+
+	if (!tcpu->enabled)
+		goto out;
+
+have_new_active:
+	/* common case where there is an active pipe_buffer */
+	if (tcpu->active && tcpu->region_space >= sizeof(*hdr) + len) {
+		pr_debug("page %p got %u bytes from %lu\n", tcpu->active->page,
+			 len, PAGE_SIZE - tcpu->region_space);
+
+		hdr = tcpu->next_region;
+		hdr->cycles = get_cycles();
+		hdr->cpu = cpu;
+
+		memcpy(tcpu->next_region + sizeof(*hdr), data, len);
+		tcpu->next_region += sizeof(*hdr) + len;
+		tcpu->region_space -= sizeof(*hdr) + len;
+		goto out;
+	}
+
+	/* ok, time to dump our full active or acquire a new one */
+	spin_lock_irqsave(&chan->bufs_lock, flags);
+
+	if (tcpu->active) {
+		pr_debug("page %p is full, moving", tcpu->active->page);
+		active_to_chan(chan, tcpu);
+	}
+
+	/* active must be empty now */
+	if (!list_empty(&chan->waiting_bufs)) {
+		page = list_entry(chan->waiting_bufs.next, struct page, lru);
+		list_del_init(&page->lru);
+		
+		pr_debug("got new page %p\n", page);
+		tcpu->active = (struct pipe_buffer *)page->private;
+		tcpu->next_region = page_address(page);
+		tcpu->region_space = PAGE_SIZE;
+	}
+
+	spin_unlock_irqrestore(&chan->bufs_lock, flags);
+
+	if (tcpu->active)
+		goto have_new_active;
+
+	/* no active?  that's too bad. */
+	tcpu->missed++;
+out:
+	put_cpu();
+}
+EXPORT_SYMBOL_GPL(tracepipe_event);
+
+static struct file_operations tracepipe_fops;
+
+/**
+ * tracepipe_create_channel - create a tracepipe file in the debugfs filesystem
+ *
+ * @name: a pointer to a null-terminated string containing the name to create
+ *
+ * The specified file is created under a /tracepipe/ directory in the
+ * debugfs mount.  
+ *
+ * The returned trace_channel is used to send events to the file and to
+ * tear down the file.  It is the caller's responsibility to serialize
+ * creation of, event generation with, and removal of a channel.
+ *
+ * The file behaves as a pipe.  If user space does not hold the file open
+ * events are dropped.  When user space has open descriptors on the file events
+ * will be logged up in pages, up to a given number of pages (currently 64k's
+ * worth).  As those pages are given to userspace through the pipe new events
+ * may be queued in new pages.
+ */
+struct trace_channel *tracepipe_create_channel(char *name)
+{
+	struct trace_channel *chan;
+	struct inode *inode;
+	int ret = 0;
+
+	chan = kcalloc(1, sizeof(*chan), GFP_KERNEL);
+	if (chan == NULL) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	INIT_WORK(&chan->to_inode_work, tracepipe_to_inode, chan);
+	spin_lock_init(&chan->bufs_lock);
+	INIT_LIST_HEAD(&chan->waiting_bufs);
+	INIT_LIST_HEAD(&chan->full_bufs);
+
+	down(&tracepipe_sem);
+
+	if (tracepipe_dentry == NULL) {
+		tracepipe_dentry = debugfs_create_dir("tracepipe", NULL);
+		if (tracepipe_dentry == NULL) {
+			ret = -ENOENT;
+			goto out_up;
+		}
+	}
+		
+	chan->dentry = debugfs_create_file(name, S_IRUSR|S_IFIFO, 
+					   tracepipe_dentry, chan,
+					   &tracepipe_fops);
+	if (chan->dentry == NULL) {
+		ret = -ENOENT;
+		goto out_up;
+	}
+	inode = chan->dentry->d_inode;
+
+	if (pipe_new(inode) == NULL) {
+		ret = -ENOMEM;
+		goto out_up;
+	}
+	PIPE_WRITERS(*inode) = 1;
+	PIPE_READERS(*inode) = 0;
+	PIPE_RCOUNTER(*inode) = PIPE_WCOUNTER(*inode) = 0;
+
+	/* the callers chan * holds a ref on the inode */
+	igrab(inode);
+
+out_up:
+	up(&tracepipe_sem);
+out:
+	if (ret) {
+		if (chan) {
+			if (chan->dentry)
+				debugfs_remove(chan->dentry);
+			kfree(chan);
+		}
+		chan = ERR_PTR(ret);
+	}
+	return chan;
+}
+EXPORT_SYMBOL_GPL(tracepipe_create_channel);
+
+/**
+ * tracepipe_remove_channel - tear down a tracepipe file
+ *
+ * @chan: the previously created channel from tracepipe_create_channel
+ *
+ * This frees all memory associated with the specified channel and removes its
+ * file from the debugfs file system.  If user space holds open references
+ * to the channel through its file when this is called then this call will
+ * fail with -EBUSY.
+ */
+int tracepipe_remove_channel(struct trace_channel *chan)
+{
+	struct inode *inode = chan->dentry->d_inode;
+	int ret = 0;
+
+	down(&tracepipe_sem);
+
+	/* I'm not a huge fan of this.  It'd be better to have this remove
+	 * unlink the file from debugfs but current readers could continue to
+	 * harvest the buffers off the inode and their iput would tear it down.
+	 * as one would expect. */
+	if (PIPE_READERS(*inode)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	/* keventd might be in tracepipe_to_inode() */
+	flush_scheduled_work();
+
+	free_pipe_info(inode);
+	debugfs_remove(chan->dentry);
+	/* let ->open()/->release() stuck in tracepipe_sem know that
+	 * we've torn down things under them */
+	inode->u.generic_ip = NULL;
+	iput(inode);
+	inode = NULL;
+
+	/* these should be empty, but.. */
+	free_chan_pages(&chan->waiting_bufs, ~0);
+	free_chan_pages(&chan->full_bufs, ~0);
+
+	kfree(chan);
+out:
+	up(&tracepipe_sem);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tracepipe_remove_channel);
+
+static int __init tracepipe_init(void)
+{
+	tracepipe_fops = read_pipe_fops;
+	tracepipe_fops.open = tracepipe_open;
+	tracepipe_fops.release = tracepipe_release;
+
+	return 0;
+}
+
+static void __exit tracepipe_exit(void)
+{
+	if (tracepipe_dentry)
+		debugfs_remove(tracepipe_dentry);
+}
+
+module_init(tracepipe_init);
+module_exit(tracepipe_exit);
Index: 2.6-mm-tracepipe/include/linux/pipe_fs_i.h
===================================================================
--- 2.6-mm-tracepipe.orig/include/linux/pipe_fs_i.h	2005-01-20 10:37:52.000000000 -0800
+++ 2.6-mm-tracepipe/include/linux/pipe_fs_i.h	2005-01-20 12:58:54.000000000 -0800
@@ -56,4 +56,8 @@
 struct inode* pipe_new(struct inode* inode);
 void free_pipe_info(struct inode* inode);
 
+extern struct pipe_buf_operations anon_pipe_buf_ops;
+int pipe_read_open(struct inode *inode, struct file *filp);
+int pipe_read_release(struct inode *inode, struct file *filp);
+
 #endif
Index: 2.6-mm-tracepipe/include/linux/tracepipe.h
===================================================================
--- 2.6-mm-tracepipe.orig/include/linux/tracepipe.h	2004-02-23 13:02:56.000000000 -0800
+++ 2.6-mm-tracepipe/include/linux/tracepipe.h	2005-01-20 11:01:47.000000000 -0800
@@ -0,0 +1,39 @@
+/*
+ *  Copyright (C) 2004 Oracle Inc.
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License version
+ *	2 as published by the Free Software Foundation.
+ */
+
+#ifndef _TRACEPIPE_H_
+#define _TRACEPIPE_H_
+
+struct trace_channel;
+
+#if defined(CONFIG_DEBUG_TRACEPIPE)
+
+struct trace_channel *tracepipe_create_channel(char *name);
+int tracepipe_remove_channel(struct trace_channel *chan);
+void tracepipe_event(struct trace_channel *chan, void *data, unsigned int len);
+
+#else
+
+static inline struct trace_channel *tracepipe_create_channel(char *name)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline int tracepipe_remove_channel(struct trace_channel *chan)
+{
+	return -ENODEV;
+}
+
+static inline void tracepipe_event(struct trace_channel *chan, void *data,
+				   unsigned int len)
+{
+}
+
+#endif
+
+#endif
Index: 2.6-mm-tracepipe/lib/Kconfig.debug
===================================================================
--- 2.6-mm-tracepipe.orig/lib/Kconfig.debug	2005-01-20 10:37:52.000000000 -0800
+++ 2.6-mm-tracepipe/lib/Kconfig.debug	2005-01-20 11:01:47.000000000 -0800
@@ -140,6 +140,17 @@
 
 	  If unsure, say N.
 
+config DEBUG_TRACEPIPE
+	bool "Provide debugfs named pipes with tracing events"
+	depends on DEBUG_FS
+	help
+	  tracepipe is a facility that lets kernel developers expose streams
+	  of debugging events as named pipes in the debugfs file system.
+	  Enable this option to give kernel subsytems the ability to register
+	  these kinds of named pipes.
+
+	  If unsure, say N.
+
 if !X86_64
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"

--------------050901050004030508000903--
