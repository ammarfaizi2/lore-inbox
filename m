Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVBRRxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVBRRxP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 12:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVBRRxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 12:53:15 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:64689 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261425AbVBRRuY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 12:50:24 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16918.10967.325166.756203@tut.ibm.com>
Date: Fri, 18 Feb 2005 11:50:15 -0600
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@muc.de>, Roman Zippel <zippel@linux-m68k.org>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@am.sony.com>,
       Christoph Hellwig <hch@infradead.org>, karim@opersys.com,
       penberg@cs.helsinki.fi
Subject: [PATCH] relayfs redux, part 5
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's the latest version of relayfs, with changes incorporating the
previous round of suggestions.  Thanks to Pekka Enberg and Maneesh
Soni for commenting on the previous patch.  Since there weren't any
complaints about the API last time, I went ahead and did some SMP
testing (see below) and wrote some Documentation.  The patch size
without the documentation hasn't changed much and is still about 41K.

Here's a list of the changes in this version:

- cleaned up some of the code in buffers.c and moved everything
  buffer-related there.
- got rid of the extra parameter in relay_create_entry().
- added a prev_subbuf_data param to the subbuf_start() callback.
- the subbuf_start() callback is now called for the first sub-buffer
  when a buffer is created.
- added relay_flush(), needed when closing a channel.
- added sanity checks to all the non-performance-critical API
  functions.
- some small changes needed for proper handling of the buffer-full
  condition.
- the reserved address is now passed into relay_commit() in order to
  make it easier to use.
- added kref to channel
- other random cleanup


I've done some pretty heavy pounding on this version and haven't had
much luck breaking it yet. ;-)  Using a hacked version of the kprobes
network packet tracing module, I tested it on a couple different
systems: a 4x700MHz Pentium III SMP system and a 3GHz Pentium 4 system
with hyperthreading on.

Here's a summary of the results of the test on the 4x700MHz Pentium
III system:

The following tests were run while transferring a 1 Gb test file.  All
numbers are averaged over 5 runs.

1) 5:37.58 minutes - baseline, netpktlog not inserted
2) 5:46.76 minutes - netpktlog inserted, but with empty kprobes handlers
3) 6:26.29 minutes - formatting data but no relay_write
4) 6:27.71 minutes - relay_write() with logging to disk
5) 6:27.70 minutes - relay_write() with no logging to disk

The average trace file size generated for 4), which is the only test
that generates data, was 1,154,171,258 bytes (yes, the trace file is
larger than the transferred file).

The total event count for 4) was 6,770,949 events of average length
149.

The amount of data logged in this test averaged 2.98 Mb/sec, and the
average number of events logged was 17464/sec.

Some comments:

For 2), I hadn't intended on testing the efficiency of kprobes, but
since I was there I thought I'd try replacing the handler code with
nothing but jprobes_return() and see what kind of overhead kprobes
alone introduces.  On this system, there was a small but noticeable
hit due to kprobes.  On the 3 GHz P4 system, this didn't show up in
the numbers.

For 3) nothing is being written to the relayfs channel - the main
thing going on in the kprobes handlers is the formatting of the data
using vsnprintf(), which here seems very expensive.  On the other
system tested, it was much less of a factor in the numbers.

For 4) and 5), writing to the channel using relay_write() seems to be
pretty efficient; in any case the numbers don't show a significant hit
to this system even when logging to disk.  Of course, the fact that
the numbers with and without logging to disk were essentially the same
means that the disk subsystem is pretty efficient too.  Since this
wasn't a very controlled test, I don't really trust any numbers this
close together, but using them anyway, it shows about a 0.3 - 0.4%
overhead when logging 3Mb/sec to disk on this system.  Actually, there
was one run that was 3 seconds longer than the others - if we remove
that the average time was 6:27.03 minutes, which makes it < 0.2%.


Here's a summary of the results of the test on the 3GHz hyperthreading
system:

The following tests were run while transferring a 250Mb test file.  All
numbers are averaged over 3 runs.

1) 4:38.79 minutes - baseline, netpktlog not inserted
2) 4:37.73 minutes - formatting data but no relay_write
3) 4:43.70 minutes - relay_write() with logging to disk
4) 4:37.59 minutes - relay_write() with no logging to disk

The average trace file size generated for 3), which is the only test
that generates data, was 295,514,458 bytes.

The total event count for 3) was 1,683,751 events of average length
176.

The amount of data logged in this test averaged 913 Kb/sec, and the
average number of events logged was 5202/sec.

Some comments:

For 2) the kprobes cost and the cost of formatting the data doesn't
show up in the numbers at all, maybe since it's a much faster
processor.

For 3) the number basically reflects the cost of logging the trace
data to disk for this system and not the cost of relay_write(), since
as we can see from 4), if not logging to disk there's essentially no
difference between the relay_write() and no-relay_write() runs.
Again, this wasn't a controlled test, so any differences here are
definitely in the noise.

The network packet tracing module and userspace program I used for
testing can be found here (the raw test data is also included):

http://prdownloads.sourceforge.net/dprobes/plog.tar.gz?download


Thanks,

Tom


Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>

 Documentation/filesystems/relayfs.txt |  200 ++++++++++++
 fs/Kconfig                            |   12 
 fs/Makefile                           |    1 
 fs/relayfs/Makefile                   |    4 
 fs/relayfs/buffers.c                  |  204 ++++++++++++
 fs/relayfs/buffers.h                  |   12 
 fs/relayfs/inode.c                    |  426 ++++++++++++++++++++++++++
 fs/relayfs/relay.c                    |  552 ++++++++++++++++++++++++++++++++++
 fs/relayfs/relay.h                    |   27 +
 include/linux/relayfs_fs.h            |  269 ++++++++++++++++
 10 files changed, 1707 insertions(+)

diff -urpN -X dontdiff linux-2.6.10/Documentation/filesystems/relayfs.txt linux-2.6.10-cur/Documentation/filesystems/relayfs.txt
--- linux-2.6.10/Documentation/filesystems/relayfs.txt	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-cur/Documentation/filesystems/relayfs.txt	2005-02-14 18:55:09.000000000 -0600
@@ -0,0 +1,200 @@
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
+               attribute_flags, callbacks)
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
+relayfs channels can be opened in either of two modes - 'continuous'
+or 'no-overwrite'.  In continuous mode, writes continuously cycle
+around the buffer and will never fail, but will unconditionally
+overwrite old data regardless of whether it's actually been consumed.
+In no-overwrite mode, writes will fail i.e. data will be lost, if the
+number of unconsumed sub-buffers equals the total number of
+sub-buffers in the channel.  In this mode, the client is reponsible
+for notifying relayfs when sub-buffers have been consumed via
+relay_subbufs_consumed().  A full buffer will become 'unfull' and
+logging will continue once the client calls relay_subbufs_consumed()
+again.  When a buffer becomes full, the buf_full() callback is invoked
+to notify the client.  In both modes, the subbuf_start() callback will
+notify the client whenever a sub-buffer boundary is crossed.  This can
+be used to write header information into the new sub-buffer or fill in
+header information reserved in the previous sub-buffer. subbuf_start()
+is also called for the first sub-buffer in each channel buffer when
+the channel is created.  The mode is specified to relay_open() using
+the RELAY_MODE_NO_OVERWRITE and RELAY_MODE_CONTINUOUS flags.
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
diff -urpN -X dontdiff linux-2.6.10/fs/Kconfig linux-2.6.10-cur/fs/Kconfig
--- linux-2.6.10/fs/Kconfig	2004-12-24 15:34:58.000000000 -0600
+++ linux-2.6.10-cur/fs/Kconfig	2005-02-06 21:32:49.000000000 -0600
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
+++ linux-2.6.10-cur/fs/Makefile	2005-02-06 21:32:49.000000000 -0600
@@ -94,3 +94,4 @@ obj-$(CONFIG_AFS_FS)		+= afs/
 obj-$(CONFIG_BEFS_FS)		+= befs/
 obj-$(CONFIG_HOSTFS)		+= hostfs/
 obj-$(CONFIG_HPPFS)		+= hppfs/
+obj-$(CONFIG_RELAYFS_FS)	+= relayfs/
diff -urpN -X dontdiff linux-2.6.10/fs/relayfs/Makefile linux-2.6.10-cur/fs/relayfs/Makefile
--- linux-2.6.10/fs/relayfs/Makefile	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-cur/fs/relayfs/Makefile	2005-02-12 19:34:30.000000000 -0600
@@ -0,0 +1,4 @@
+obj-$(CONFIG_RELAYFS_FS) += relayfs.o
+
+relayfs-y := relay.o inode.o buffers.o
+
diff -urpN -X dontdiff linux-2.6.10/fs/relayfs/buffers.c linux-2.6.10-cur/fs/relayfs/buffers.c
--- linux-2.6.10/fs/relayfs/buffers.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-cur/fs/relayfs/buffers.c	2005-02-14 20:10:33.000000000 -0600
@@ -0,0 +1,204 @@
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
+ *	@size: total size of the buffer
+ *	@page_array: receives a pointer to the buffer's page array
+ *	@page_count: receives the number of pages allocated
+ *
+ *	Returns a pointer to the resulting buffer, NULL if unsuccessful
+ */
+static void *relay_alloc_buf(unsigned long size, struct page ***page_array,
+			     int *page_count)
+{
+	void *mem;
+	struct page **array;
+	int i, j, n_pages;
+	
+	size = PAGE_ALIGN(size);
+	n_pages = size >> PAGE_SHIFT;
+
+	array = kcalloc(n_pages, sizeof(struct page *), GFP_KERNEL);
+	if (!array)
+		return NULL;
+
+	for (i = 0; i < n_pages; i++) {
+		array[i] = alloc_page(GFP_KERNEL);
+		if (unlikely(!array[i]))
+			goto depopulate;
+	}
+	mem = vmap(array, n_pages, GFP_KERNEL, PAGE_KERNEL);
+	if (!mem)
+		goto depopulate;
+
+	memset(mem, 0, size);
+	*page_array = array;
+	*page_count = n_pages;
+	return mem;
+
+depopulate:
+	for (j = 0; j < i; j++)
+		__free_page(array[j]);
+	kfree(array);
+	*page_array = NULL;
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
+		goto free_padding;
+
+	buf->start = relay_alloc_buf(chan->alloc_size, &buf->page_array, &buf->page_count);
+	if (!buf->start)
+		goto free_commit;
+
+	buf->chan = chan;
+	kref_get(&buf->chan->kref);
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
diff -urpN -X dontdiff linux-2.6.10/fs/relayfs/buffers.h linux-2.6.10-cur/fs/relayfs/buffers.h
--- linux-2.6.10/fs/relayfs/buffers.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-cur/fs/relayfs/buffers.h	2005-02-12 19:33:10.000000000 -0600
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
diff -urpN -X dontdiff linux-2.6.10/fs/relayfs/inode.c linux-2.6.10-cur/fs/relayfs/inode.c
--- linux-2.6.10/fs/relayfs/inode.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-cur/fs/relayfs/inode.c	2005-02-14 20:10:33.000000000 -0600
@@ -0,0 +1,426 @@
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
+	BUG_ON(!(S_ISREG(mode) || S_ISDIR(mode)));
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
+	if (!name)
+		return NULL;
+	
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
diff -urpN -X dontdiff linux-2.6.10/fs/relayfs/relay.c linux-2.6.10-cur/fs/relayfs/relay.c
--- linux-2.6.10/fs/relayfs/relay.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-cur/fs/relayfs/relay.c	2005-02-14 20:13:29.000000000 -0600
@@ -0,0 +1,552 @@
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
+	if (!(subbuf_size && n_subbufs))
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
+ *	is MODE_CONTINUOUS.
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
diff -urpN -X dontdiff linux-2.6.10/fs/relayfs/relay.h linux-2.6.10-cur/fs/relayfs/relay.h
--- linux-2.6.10/fs/relayfs/relay.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-cur/fs/relayfs/relay.h	2005-02-13 21:33:42.000000000 -0600
@@ -0,0 +1,27 @@
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
+extern int relay_buf_empty(struct rchan_buf *buf);
+extern void relay_destroy_channel(struct kref *kref);
+
+#endif /* _RELAY_H */
diff -urpN -X dontdiff linux-2.6.10/include/linux/relayfs_fs.h linux-2.6.10-cur/include/linux/relayfs_fs.h
--- linux-2.6.10/include/linux/relayfs_fs.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-cur/include/linux/relayfs_fs.h	2005-02-14 01:32:16.000000000 -0600
@@ -0,0 +1,269 @@
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
+	u32 flags;			/* relay channel attributes */
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
+			 u32 flags,
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

