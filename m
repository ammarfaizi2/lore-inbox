Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbTJGVHy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 17:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbTJGVHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 17:07:53 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:22502 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262888AbTJGVAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 17:00:52 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16259.10588.955363.35587@gargle.gargle.HOWL>
Date: Tue, 7 Oct 2003 16:00:12 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] relayfs (4/4) (public API and common code)
X-Mailer: VM(ViewMail) 7.01 under Emacs 20.7.2
Cc: karim@opersys.com, bob@watson.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN -X dontdiff linux-2.6.0-test6/fs/relayfs/relay.c linux-2.6.0-test6.cur/fs/relayfs/relay.c
--- linux-2.6.0-test6/fs/relayfs/relay.c	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test6.cur/fs/relayfs/relay.c	Tue Oct  7 12:06:10 2003
@@ -0,0 +1,2638 @@
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
+
+/* Relay channel table, indexed by channel id */
+static struct rchan *	rchan_table[RELAY_MAX_CHANNELS];
+static rwlock_t		rchan_table_lock = RW_LOCK_UNLOCKED;
+
+/* Relay operation structs, one for each scheme */
+static struct relay_ops lockless_ops = {
+	.reserve = lockless_reserve,
+	.commit = lockless_commit,
+	.get_offset = lockless_get_offset,
+	.finalize = lockless_finalize,
+	.reset = lockless_reset
+};
+
+static struct relay_ops locking_ops = {
+	.reserve = locking_reserve,
+	.commit = locking_commit,
+	.get_offset = locking_get_offset,
+	.finalize = locking_finalize,
+	.reset = locking_reset
+};
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
+/* This inspired by rtai/shmem */
+#define FIX_SIZE(x) (((x) - 1) & PAGE_MASK) + PAGE_SIZE
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
+static void *
+rvmalloc(unsigned long size)
+{
+	void *mem;
+	unsigned long adr;
+
+	mem = vmalloc_32(size);
+	if (!mem)
+		return NULL;
+	memset(mem, 0, size);
+	adr = (unsigned long) mem;
+	while (size > 0) {
+		SetPageReserved(vmalloc_to_page((void *) adr));
+		adr += PAGE_SIZE;
+		size -= PAGE_SIZE;
+	}
+	return mem;
+}
+
+static void 
+rvfree(void *mem, unsigned long size)
+{
+	unsigned long adr;
+
+	if (!mem)
+		return;
+	adr = (unsigned long) mem;
+	while ((long) size > 0) {
+		ClearPageReserved(vmalloc_to_page((void *) adr));
+		adr += PAGE_SIZE;
+		size -= PAGE_SIZE;
+	}
+	
+	vfree(mem);
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
+		if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
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
+ *	relaybuf_alloc - allocate a new resized channel buffer
+ *	@private: pointer to the channel struct
+ */
+static void 
+relaybuf_alloc(void *private)
+{
+	struct rchan *rchan = (struct rchan *)private;
+
+	rchan->resize_buf = (char *) rvmalloc(rchan->resize_alloc_size);
+	
+	if (rchan->resize_buf == NULL)
+		rchan->resize_err = -ENOMEM;
+	else
+		rchan->resize_err = 0;
+
+	rchan->replace_buffer = 1;
+	rchan->resizing = 0;
+
+	rchan->callbacks->needs_resize(rchan->id, RELAY_RESIZE_REPLACE, 0, 0);
+}
+
+/**
+ *	relaybuf_free - free a resized channel buffer
+ *	@private: pointer to the channel struct
+ */
+static void
+relaybuf_free(void *private)
+{
+	struct free_rchan_buf *free_buf = (struct free_rchan_buf *)private;
+
+	if (free_buf->free_buf)
+		rvfree(free_buf->free_buf, free_buf->free_alloc_size);
+	kfree(free_buf);
+}
+
+/**
+ *	calc_order - determine the power-of-2 order of a resize
+ *	@high: the larger size
+ *	@low: the smaller size
+ */
+static inline int
+calc_order(u32 high, u32 low)
+{
+	int order = 0;
+	
+	if (!high || !low || high <= low)
+		return 0;
+	
+	while (high > low) {
+		order++;
+		high /= 2;
+	}
+	
+	return order;
+}
+
+/**
+ *	check_size - check the sanity of the requested channel size
+ *	@rchan: the channel
+ *	@bufsize: the new sub-buffer size
+ *	@nbufs: the new number of sub-buffers
+ *	@err: return code
+ *
+ *	Returns the non-zero total buffer size if ok, otherwise 0 and
+ *	sets errcode if not.
+ */
+static inline u32
+check_size(struct rchan *rchan, u32 nbufs, int *err)
+{
+	u32 new_channel_size = 0;
+
+	*err = 0;
+	
+	if (nbufs > rchan->n_bufs) {
+		resize_order(rchan) = calc_order(nbufs, rchan->n_bufs);
+		if (!resize_order(rchan)) {
+			*err = -EINVAL;
+			goto out;
+		}
+
+		new_channel_size = rchan->buf_size * nbufs;
+		if (new_channel_size > rchan->resize_max) {
+			*err = -EINVAL;
+			goto out;
+		}
+	} else if (nbufs < rchan->n_bufs) {
+		if (rchan->n_bufs < 2) {
+			*err = -EINVAL;
+			goto out;
+		}
+		resize_order(rchan) = -calc_order(rchan->n_bufs, nbufs);
+		if (!resize_order(rchan)) {
+			*err = -EINVAL;
+			goto out;
+		}
+		
+		new_channel_size = rchan->buf_size * nbufs;
+		if (new_channel_size < rchan->resize_min) {
+			*err = -EINVAL;
+			goto out;
+		}
+	} else
+		*err = -EINVAL;
+out:
+	return new_channel_size;
+}
+
+/**
+ *	__relay_realloc_buffer - allocate a new channel buffer
+ *	@rchan: the channel
+ *	@bufsize: the new sub-buffer size
+ *	@nbufs: the new number of sub-buffers
+ *
+ *	Allocates a new channel buffer using the specified sub-buffer size
+ *	and count.  If called from within interrupt context, the allocation
+ *	is put onto a work queue.  When the allocation has completed,
+ *	the needs_resize() callback is called with a resize_type of
+ *	RELAY_RESIZE_REPLACE.  This function doesn't copy the old buffer
+ *	contents to the new buffer - see relay_replace_buffer().
+ *
+ *	This function (or rather the handle version, relay_realloc_buffer())
+ *	is called by kernel clients in response to a needs_resize() callback
+ *	call with a resize type of RELAY_RESIZE_EXPAND or RELAY_RESIZE_SHRINK.
+ *	That callback also includes a suggested new_bufsize and new_nbufs
+ *	which should be used when calling this function.
+ *
+ *	Returns 0 on success, or errcode if the channel is busy or if
+ *	the allocation couldn't happen for some reason.
+ *	
+ *	NOTE: should not be called with a lock held, as it may sleep.
+ */
+static int
+__relay_realloc_buffer(struct rchan *rchan, u32 new_nbufs)
+{
+	u32 new_channel_size;
+	int err = 0;
+	
+	if (new_nbufs == rchan->n_bufs)
+		return -EINVAL;
+		
+	if (down_trylock(&rchan->resize_sem))
+		return -EBUSY;
+
+	if (rchan->resizing) {
+		err = -EBUSY;
+		goto out;
+	}
+	else
+		rchan->resizing = 1;
+
+	if (rchan->replace_buffer) {
+		err = -EBUSY;
+		goto out;
+	}
+
+	if (rchan->resize_failures > MAX_RESIZE_FAILURES) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	new_channel_size = check_size(rchan, new_nbufs, &err);
+	if (err)
+		goto out;
+	
+	rchan->resize_n_bufs = new_nbufs;
+	rchan->resize_buf_size = rchan->buf_size;
+	rchan->resize_alloc_size = FIX_SIZE(new_channel_size);
+	
+	if (in_interrupt()) {
+		INIT_WORK(&rchan->work, relaybuf_alloc, rchan);
+		schedule_work(&rchan->work);
+	} else
+		relaybuf_alloc((void *)rchan);
+out:
+	up(&rchan->resize_sem);
+	
+	return err;
+}
+
+/**
+ *	relay_realloc_buffer - allocate a new channel buffer
+ *	@rchan_id: the channel id
+ *	@bufsize: the new sub-buffer size
+ *	@nbufs: the new number of sub-buffers
+ *
+ *	The handle version - see __relay_realloc_buffer for details.
+ */
+int
+relay_realloc_buffer(int rchan_id, u32 new_nbufs)
+{
+	int err;
+	
+	struct rchan *rchan;
+
+	rchan = rchan_get(rchan_id);
+	if (rchan == NULL)
+		return -EBADF;
+
+	err = __relay_realloc_buffer(rchan, new_nbufs);
+	
+	rchan_put(rchan);
+
+	return err;
+}
+
+/**
+ *	relay_busy - determine whether or not relay is busy
+ *
+ *	Returns 1 if busy, 0 otherwise.
+ */
+int 
+relay_busy(void)
+{
+	int i, busy = 0;
+	
+	read_lock(&rchan_table_lock);
+	for (i = 0; i < RELAY_MAX_CHANNELS; i++)
+		if (rchan_table[i] != NULL) {
+			busy = 1;
+			break;
+		}
+	read_unlock(&rchan_table_lock);
+
+	return busy;
+}
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
+	if (rchan == NULL)
+	   return -EBADF;
+
+	if (rchan->buf != NULL)
+		rvfree(rchan->buf, rchan->alloc_size);
+
+	rchan_free_id(rchan->id);
+	relayfs_remove_file(rchan->dentry);
+	kfree(rchan);
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
+ *	number of buffers must be a power of 2, and if the lockess scheme
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
+	rchan = (struct rchan *)kmalloc(sizeof(struct rchan), GFP_KERNEL);
+	if (rchan == NULL) {
+		*err = -ENOMEM;
+		return NULL;
+	}
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
+	if ((rchan->buf = (char *) rvmalloc(size_alloc)) == NULL) {
+		*err = -ENOMEM;
+		goto exit;
+	}
+
+	if (rchan_alloc_id(rchan) == -1) {
+		*err = -ENOMEM;
+		goto exit;
+	}
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
+/**
+ *	clear_resize_offsets - helper function for buffer resizing
+ *	@rchan: the channel
+ *
+ *	Clear the saved offset changes.
+ */
+static inline void
+clear_resize_offsets(struct rchan *rchan)
+{
+	unsigned i;
+	
+	rchan->offset_change_count = 0;
+	
+	for (i = 0; i < MAX_RESIZE_OFFSETS; i++) {
+		rchan->resize_offsets[i].ge = 0UL;
+		rchan->resize_offsets[i].le = 0UL;
+		rchan->resize_offsets[i].delta = 0;
+	}
+}
+
+/**
+ *	save_resize_offset - helper function for buffer resizing
+ *	@rchan: the channel
+ *	@ge: affected region ge this
+ *	@le: affected region le this
+ *	@delta: apply this delta
+ *
+ *	Save a resize offset.
+ */
+static inline void
+save_resize_offset(struct rchan *rchan, u32 ge, u32 le, int delta)
+{
+	unsigned slot = rchan->offset_change_count;
+	
+	if (slot < MAX_RESIZE_OFFSETS) {
+		rchan->resize_offsets[slot].ge = ge;
+		rchan->resize_offsets[slot].le = le;
+		rchan->resize_offsets[slot].delta = delta;
+		rchan->offset_change_count++;
+	}
+}
+
+/**
+ *	update_file_offset - apply offset change to reader
+ *	@reader: the channel reader
+ *	@change_idx: the offset index into the offsets array
+ *
+ *	Returns non-zero if the offset was applied.
+ *
+ *	Apply the offset delta saved in change_idx to the reader's
+ *	current read position.
+ */
+static inline int
+update_file_offset(struct rchan_reader *reader, unsigned change_idx)
+{
+	int applied = 0;
+	struct rchan *rchan = reader->rchan;
+	u32 f_pos;
+	int delta = reader->rchan->resize_offsets[change_idx].delta;
+
+	if (reader->vfs_reader)
+		f_pos = (u32)reader->pos.file->f_pos;
+	else
+		f_pos = reader->pos.f_pos;
+
+	if ((f_pos >= rchan->resize_offsets[change_idx].ge) &&
+	    (f_pos <= rchan->resize_offsets[change_idx].le)) {
+		if (reader->vfs_reader)
+			reader->pos.file->f_pos += delta;
+		else
+			reader->pos.f_pos += delta;
+		applied = 1;
+	}
+
+	return applied;
+}
+
+/**
+ *	update_file_offset - apply offset change to reader
+ *	@rchan: the channel
+ *
+ *	Apply the saved offset deltas to all files open on the channel.
+ */
+static inline void 
+update_file_offsets(struct rchan *rchan)
+{
+	struct list_head *p;
+	struct rchan_reader *reader;
+	unsigned i;
+	
+	read_lock(&rchan->open_readers_lock);
+	list_for_each(p, &rchan->open_readers) {
+		reader = list_entry(p, struct rchan_reader, list);
+		for (i = 0; i < rchan->offset_change_count; i++) {
+			if (update_file_offset(reader, i)) {
+				reader->offset_changed = 1;
+				break; /* only apply first hit */
+			}
+		}
+	}
+	read_unlock(&rchan->open_readers_lock);
+}
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
+		rchan->mapped = 0;
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
+	rchan->bufs_produced = 0;
+	rchan->bufs_consumed = 0;
+	rchan->bytes_consumed = 0;
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
+	do_gettimeofday(&rchan->low_water_time);
+
+	INIT_WORK(&rchan->wake_readers, NULL, NULL);
+	INIT_WORK(&rchan->wake_writers, NULL, NULL);
+
+	for (i = 0; i < RELAY_MAX_BUFS; i++)
+		rchan->unused_bytes[i] = 0;
+	
+	rchan->relay_ops->reset(rchan, init);
+
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
+ *	NOTE: Care should be taken that the channnel isn't actually
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
+
+	rchan_put(rchan);
+
+	return 0;
+}
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
+	err = relayfs_create_file(fname, topdir, dentry, (void *)data);
+
+	return err;
+}
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
+	*interrupting = 0;
+	
+	return rchan->relay_ops->reserve(rchan, len, ts, td, err, interrupting);
+}
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
+ *	relay_mmap_buffer: - mmap buffer to process address space
+ *	@rchan_id: relay channel id
+ *	@vma: vm_area_struct describing memory to be mapped
+ *
+ *	Returns:
+ *	0 if ok
+ *	-EAGAIN, when remap failed
+ *	-EINVAL, invalid requested length
+ *	-EBUSY, channel already mapped
+ *
+ *	Caller should already have grabbed mmap_sem.  Currently only
+ *	the whole buffer can be mapped and only once.
+ */
+int 
+relay_mmap_buffer(int rchan_id,
+		  struct vm_area_struct *vma)
+{
+	int err = 0;
+	unsigned long length = vma->vm_end - vma->vm_start;
+	struct rchan *rchan;
+
+	rchan = rchan_get(rchan_id);
+	if (rchan == NULL)
+		return -EBADF;
+
+	if (length != (unsigned long)rchan->alloc_size) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	if (rchan->mapped) {
+		err = -EBUSY;
+		goto exit;
+	}
+
+	err = relay_mmap_region(vma,
+				(char *)vma->vm_start,
+				rchan->buf,
+				rchan->alloc_size);
+
+	if (!err)
+		rchan->mapped = 1;
+exit:	
+	rchan_put(rchan);
+	
+	return err;
+}
+
+/**
+ *	relay_get_offset - get current and max 'file' offsets for VFS
+ *	@rchan: the channel
+ *	@max_offset: maximum channel offset
+ *
+ *	Returns the current and maximum buffer offsets in VFS terms.
+ */
+u32 
+relay_get_offset(struct rchan *rchan, u32 *max_offset)
+{
+	return rchan->relay_ops->get_offset(rchan, max_offset);
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
+ * Do nothing at buffer_end.  Return 0 bytes written.
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
+ * Do nothing at buffer_start.  Return 0 bytes written.
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
+ * Do nothing upon delivery.
+ */
+static void 
+deliver_default_callback(int rchan_id, char *from, u32 len)
+{
+}
+
+/*
+ * Do nothing for resize events.
+ */
+static void
+needs_resize_default_callback(int rchan_id,
+			      int resize_type,
+			      u32 suggested_buf_size,
+			      u32 suggested_n_bufs)
+{
+}
+
+/* relay channel default callbacks */
+static struct rchan_callbacks default_channel_callbacks = {
+	.buffer_start = buffer_start_default_callback,
+	.buffer_end = buffer_end_default_callback,
+	.deliver = deliver_default_callback,
+	.needs_resize = needs_resize_default_callback,
+};
+
+/**
+ *	check_attribute_flags - check sanity of channel attributes
+ *	@flags: channel attributes
+ *	@nbufs: receives the new number of nbufs to use, if applicable
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
+	if (!(flags & RELAY_MODE_CONTINUOUS) &&
+	    !(flags & RELAY_MODE_NO_OVERWRITE))
+		flags |= RELAY_MODE_CONTINUOUS; /* Default to continuous */
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
+ *
+ *	Returns channel id if successful, negative otherwise.
+ *
+ *	Creates a relay channel using the sizes and attributes specified.
+ *	If RELAY_SCHEME_ANY is specified, the lockless scheme will be used
+ *	if the architecture supports it (i.e. has_cmpxchg()), otherwise
+ *	the locking scheme will be used.  If RELAY_TIMESTAMP_ANY is specified,
+ *	TSC timestamping will be used if the architecture supports it,
+ *	otherwise the delta between gettimeofday calls between the beginning
+ *	of the sub-buffer and the current write is used.  Note that these
+ *	timestamps and time deltas aren't written anywhere in the channel
+ *	unless requested, and are available via the channel callbacks.  Unless
+ *	RELAY_MODE_NO_OVERWRITE is specified, the channel will be created as
+ *	RELAY_MODE_CONTINUOUS, which means that writes to the channel will
+ *	succeed regardless of whether there are up-to-date consumers or not.
+ *	Both the delivery mode (RELAY_DELIVERY_xxx) and the usage mode 
+ *	(RELAY_USAGE_xxx) must be explicitly specified.
+ *
+ *	The total size of the channel buffer is bufsize * nbufs rounded up 
+ *	to the next kernel page size.  If the lockless scheme is used, both
+ *	bufsize and nbufs must be a power of 2.  If the locking scheme is
+ *	used, the bufsize can be anything and nbufs should be 2.
+ *
+ *	start_reserve and end_reserve allow clients to specify areas at the 
+ *	beginning and end of each sub-buffer which will be 'reserved' for
+ *	private use by the client.  The client has the opportunity to write
+ *	into the corresponding sub-buffer area when the buffer_start and
+ *	buffer_end callbacks are invoked.  The rchan_start_reserve param
+ *	specifies an additional area at the beginning of the first buffer
+ *	that the client can use to write information for instance describing
+ *	the channel as a whole.
+ *
+ *	Any NULL rchan_callback function contained in the callbacks
+ *	struct will be filled in with a default callback function that does
+ *	nothing.
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
+	   u32 resize_max)
+{
+	int err;
+	struct rchan *rchan;
+	struct dentry *dentry;
+	struct rchan_callbacks *callbacks = NULL;
+
+	if (chanpath == NULL)
+		return -EINVAL;
+
+	if (channel_callbacks == NULL)
+		callbacks = &default_channel_callbacks;
+	else
+		callbacks = channel_callbacks;
+
+	if (nbufs != 1) {
+		err = check_attribute_flags(&flags);
+		if (err)
+			return err;
+	}
+	
+	rchan = rchan_create(chanpath, bufsize, nbufs, flags, &err);
+
+	if (err < 0)
+		return err;
+
+	/* Create file in fs */
+	if ((err = rchan_create_file(chanpath, &dentry, rchan)) < 0) {
+		rchan_free_id(rchan->id);
+		kfree(rchan);
+		return err;
+	}
+
+	rchan->dentry = dentry;
+
+	if (callbacks->buffer_end == NULL)
+		callbacks->buffer_end = buffer_end_default_callback;
+	if (callbacks->buffer_start == NULL)
+		callbacks->buffer_start = buffer_start_default_callback;
+	if (callbacks->deliver == NULL)
+		callbacks->deliver = deliver_default_callback;
+	if (callbacks->needs_resize == NULL)
+		callbacks->needs_resize = needs_resize_default_callback;
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
+	}
+
+	rchan_get(rchan->id);
+
+	return rchan->id;
+}
+
+/**
+ *	relay_write - reserve a slot in the channel and write data into it
+ *	@rchan_id: relay channel id
+ *	@data_ptr: data to be written into reserved slot
+ *	@count: number of bytes to write
+ *	@td_offset: optional offset where time delta should be written
+ *
+ *	Returns number of bytes written, negative number on failure.
+ *
+ *	Reserves space in the channel and writes count bytes of data_ptr
+ *	to it.  Automatically performs any necessary locking, depending
+ *	on the scheme and SMP usage in effect (no locking is done for the
+ *	lockless scheme regardless of usage). 
+ *
+ *	If td_offset is >= 0, the internal time delta calculated when
+ *	slot was reserved will be written at that offset.
+ */
+int 
+relay_write(int rchan_id, 
+	    const void *data_ptr, 
+	    size_t count,
+	    int td_offset)
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
+		relay_commit(rchan, write_pos, bytes_written, reserve_code,
+			     interrupting);
+
+	relay_unlock_channel(rchan, flags); /* nop for lockless */
+
+	rchan_put(rchan);
+
+	return bytes_written;
+}
+
+/**
+ *	__add_rchan_reader - internal function for adding readers to a channel
+ *	@rchan: relay channel
+ *	@filp: the file associated with rchan, if applicable
+ *	@auto_consume: boolean, whether reader's reads automatically consume
+ *
+ *	Returns a pointer to the reader object create, NULL if unsuccessful
+ *
+ *	Creates and initializes an rchan_reader object for reading the channel.
+ *	If filp is non-NULL, the reader is a VFS reader, otherwise not.
+ */
+struct rchan_reader *
+__add_rchan_reader(struct rchan *rchan, struct file *filp, int auto_consume)
+{
+	struct rchan_reader *reader;
+	
+	reader = kmalloc(sizeof(struct rchan_reader), GFP_KERNEL);
+
+	if (reader) {
+		write_lock(&rchan->open_readers_lock);
+		reader->rchan = rchan;
+		if (filp) {
+			reader->vfs_reader = 1;
+			reader->pos.file = filp;
+		} else {
+			reader->vfs_reader = 0;
+			reader->pos.f_pos = 0;
+		}
+		reader->auto_consume = auto_consume;
+		reader->offset_changed = 0;
+		list_add(&reader->list, &rchan->open_readers);
+		write_unlock(&rchan->open_readers_lock);
+	}
+
+	return reader;
+}
+
+/**
+ *	add_rchan_reader - create a non-VFS reader for a channel
+ *	@rchan_id: relay channel handle
+ *	@auto_consume: boolean, whether reader's reads automatically consume
+ *
+ *	Returns a pointer to the reader object create, NULL if unsuccessful
+ *
+ *	Creates and initializes an rchan_reader object for reading the channel.
+ *	This function is used only by non-VFS readers.
+ */
+struct rchan_reader *
+add_rchan_reader(int rchan_id, int auto_consume)
+{
+	struct rchan *rchan = rchan_get(rchan_id);
+	if (rchan == NULL)
+		return NULL;
+
+	return __add_rchan_reader(rchan, NULL, auto_consume);
+}
+
+/**
+ *	__remove_rchan_reader - internal function for removing a channel reader
+ *	@reader: relay channel reader
+ *
+ *	Removes the reader from the list of channel readers and frees it.
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
+ *	remove_rchan_reader - remove a non-VFS reader for a channel
+ *	@reader: relay channel reader
+ *
+ *	Returns 0 if successful, negative otherwise.
+ *
+ *	Finds and removes the given reader from the channel.
+ *	This function is used only by non-VFS readers.
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
+ *	__relay_buffers_consumed - internal version of relay_buffers_consumed
+ *	@rchan: the relay channel
+ *	@bufs_consumed: number of buffers to add to current count for channel
+ *	
+ *	See relay_buffers_consumed.
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
+ *	relay_buffers_consumed - add to the # buffers consumed for the channel
+ *	@rchan_id: relay channel id
+ *	@bufs_consumed: number of buffers to add to current count for channel
+ *	
+ *	In order for the relay to detect the 'buffers full' condition for
+ *	a channel, it must be kept up-to-date with respect to the number of
+ *	buffers consumed by the client.  If the channel is being used in a
+ *	continuous or 'flight recorder' fashion, this function is essentially
+ *	useless.
+ *
+ *	If the addition of the value of the bufs_consumed param to the current
+ *	bufs_consumed count for the channel would exceed the bufs_produced
+ *	count for the channel, the channel's bufs_consumed count will be set
+ *	to the bufs_produced count for the channel.  This allows clients to
+ *	'catch up' if necessary.
+ */
+void 
+relay_buffers_consumed(int rchan_id, u32 bufs_consumed)
+{
+	struct rchan *rchan;
+
+	rchan = rchan_get(rchan_id);
+	if (rchan == NULL)
+		return;
+
+	__relay_buffers_consumed(rchan, bufs_consumed);
+
+	rchan_put(rchan);
+}
+
+/**
+ *	__relay_bytes_consumed - internal version of relay_bytes_consumed 
+ *	@rchan: the relay channel
+ *	@bytes_consumed: number of bytes to add to current count for channel
+ *	@read_offset: where the bytes were consumed from
+ *	
+ *	See relay_bytes_consumed.
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
+
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
+ *	relay_bytes_consumed - add to the # bytes consumed for the channel
+ *	@rchan_id: relay channel id
+ *	@bytes_consumed: number of bytes to add to current count for channel
+ *	@read_offset: where the bytes were consumed from
+ *	
+ *	In order for the relay to detect the 'buffers full' condition for
+ *	a channel, it must be kept up-to-date with respect to the number of
+ *	buffers consumed by the client.  If the channel is being used in a
+ *	continuous or 'flight recorder' fashion, this function is essentially
+ *	useless.
+ *
+ *	For packet clients, it makes more sense to update after each read
+ *	rather than after each complete sub-buffer read.  The bytes_consumed
+ *	count updates bufs_consumed when a buffer has been consumed so this
+ *	count remains consistent.
+ *	
+ *	NOTE: clients don't need to worry about this function if they
+ *	use auto-consuming readers.
+ */
+void
+relay_bytes_consumed(int rchan_id, u32 bytes_consumed, u32 read_offset)
+{
+	struct rchan *rchan;
+
+	rchan = rchan_get(rchan_id);
+	if (rchan == NULL)
+		return;
+
+	__relay_bytes_consumed(rchan, bytes_consumed, read_offset);
+	
+	rchan_put(rchan);
+}
+
+/**
+ *	do_read - utility function to do the actual read to user
+ *	@rchan: the channel
+ *	@buf: user buf to read into, NULL if just getting info
+ *	@count: bytes requested
+ *	@read_offset: offset into file
+ *	@new_offset: new offset into file
+ *
+ *	Attempt to read count bytes into buffer.  See relay_read for
+ *	full description.
+ *
+ *	Returns the number of bytes read, or negative on error.
+ */
+static ssize_t
+do_read(struct rchan *rchan, char *buf, size_t count, u32 read_offset, u32 *new_offset)
+{
+	u32 read_bufno;
+	u32 avail_offset, max_offset, buf_end_offset;
+	u32 avail_count, buf_size;
+	int unused_bytes = 0;
+	size_t read_count = 0;
+
+	if (!rchan->initialized)
+		return 0;
+	
+	buf_size = rchan->buf_size;
+	if (buf_size) { /* paranoia */
+		read_bufno = read_offset / buf_size;
+		if (read_bufno < RELAY_MAX_BUFS)
+			unused_bytes = rchan->unused_bytes[read_bufno];
+		else
+			return -EINVAL;
+	} else
+		return -EINVAL;
+
+	avail_offset = relay_get_offset(rchan, &max_offset);
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
+	if (read_offset + read_count + unused_bytes >= max_offset)
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
+ *	__relay_read - read file op for relayfs files
+ *	@rchan: the channel
+ *	@buf: user buf to read into, NULL if just getting info
+ *	@count: bytes requested
+ *	@read_offset: offset into file
+ *	@new_offset: new offset into file
+ *	@wait: if non-zero, wait for something to read
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
+ *	skip over them.  If the return value is <= 0, *new_offset contains
+ *	unpredictable data.  If buf is NULL, will return the read_count
+ *	and new offset without actually doing the read.
+ */
+static ssize_t
+__relay_read(struct rchan_reader *reader, char *buf, size_t count, u32 read_offset, u32 *new_offset, int wait)
+{
+	int err = 0;
+	size_t read_count = 0;
+	struct rchan *rchan = reader->rchan;
+
+	if (!rchan->initialized)
+		return 0;
+	
+	if (rchan->replace_buffer)
+		return 0;
+	
+	if (using_lockless(rchan))
+		read_offset &= idx_mask(rchan);
+
+	if (read_offset >= rchan->n_bufs * rchan->buf_size) {
+		*new_offset = 0;
+		return 0;
+	}
+	
+	if (buf != NULL && wait) {
+		err = wait_event_interruptible(rchan->read_wait,
+		       ((rchan->finalized == 1) ||
+			(relay_get_offset(rchan, NULL) != read_offset)));
+
+		if (rchan->finalized)
+			return -EINTR;
+
+		if (reader->offset_changed) {
+			reader->offset_changed = 0;
+			return -EINTR;
+		}
+		
+		if (rchan->replace_buffer)
+			return -EINTR;
+
+		if (err)
+			return err;
+	}
+
+	read_count = do_read(rchan, buf, count, read_offset, new_offset);
+	
+	if (read_count == 0 && !wait)
+		err = -EAGAIN;
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
+ *	relay_read - read file op for relayfs files
+ *	@rchan_id: the channel
+ *	@buf: user buf to read into, NULL if just getting info
+ *	@count: bytes requested
+ *	@wait: if non-zero, wait for something to read
+ *
+ *	The handle version - see __relay_read for details.
+ */
+ssize_t
+relay_read(struct rchan_reader *reader, char * buf, size_t count, int wait)
+{
+	u32 new_offset;
+	u32 read_offset;
+	ssize_t read_count;
+	
+	if (reader == NULL)
+		return -EBADF;
+
+	if (reader->vfs_reader)
+		read_offset = (u32)(reader->pos.file->f_pos);
+	else
+		read_offset = reader->pos.f_pos;
+
+	read_count = __relay_read(reader, buf, count, read_offset,
+				  &new_offset, wait);
+
+	if (read_count <= 0)
+		return read_count;
+	
+	if (reader->vfs_reader)
+		reader->pos.file->f_pos = new_offset;
+	else
+		reader->pos.f_pos = new_offset;
+
+	if (read_count && reader->auto_consume)
+		__relay_bytes_consumed(reader->rchan, read_count, read_offset);
+
+	return read_count;
+}
+
+/**
+ *	find_last_start - find start buffer/offset for relay_read_last
+ *	@rchan: the channel
+ *	@count: bytes requested
+ *	@start_bufno: the sub-buffer to start copying from
+ *	@start_offset: the offset within sub-buffer to start copying from
+ *	@use_nbufs: this many sub-buffers are needed to fullfill the request
+ *
+ *	Returns the # of bytes available within the buffer, or negative
+ *	errcode on error.
+ */
+static size_t
+find_last_start(struct rchan *rchan, size_t count, int *start_bufno, u32 *start_offset, int *use_nbufs)
+{
+	int err = 0;
+	int try_bufcount, cur_bufno = 0, include_nbufs = 1;
+	u32 cur_idx, buf_size;
+	size_t avail_count = 0, avail_in_buf;
+	int unused_bytes = 0;
+
+	if (rchan->bufs_produced < rchan->n_bufs)
+		try_bufcount = rchan->bufs_produced;
+	else
+		try_bufcount = rchan->n_bufs - 1;
+
+	cur_idx = relay_get_offset(rchan, NULL);
+	
+	buf_size = rchan->buf_size;
+	if (buf_size) /* paranoia */
+		cur_bufno = cur_idx / buf_size;
+	else {
+		err = -EINVAL;
+		goto out;
+	}
+
+	avail_count = cur_idx % buf_size;
+	*start_offset = 0;
+
+	if (avail_count > count)
+		*start_offset = avail_count - count;
+
+	while ((avail_count < count) && (try_bufcount > 0)) {
+		cur_bufno -= 1;
+		if (cur_bufno < 0)
+			cur_bufno = rchan->n_bufs - 1;
+		if (cur_bufno < RELAY_MAX_BUFS)
+			unused_bytes = rchan->unused_bytes[cur_bufno];
+		else {
+			err = -EINVAL;
+			goto out;
+		}
+
+		avail_in_buf = buf_size - unused_bytes;
+		if (avail_count + avail_in_buf > count)
+			*start_offset = buf_size - (count - avail_count) - unused_bytes;
+		avail_count += avail_in_buf;
+		include_nbufs++;
+		try_bufcount--;
+	}
+	*start_bufno = cur_bufno;
+	*use_nbufs = include_nbufs;
+	return avail_count;
+out:
+	return err;
+}
+
+/**
+ *	__relay_read_last - read last count bytes from channel
+ *	@rchan: the channel
+ *	@buf: user buf to read into
+ *	@count: bytes requested
+ *
+ *	Copies the last count bytes in the channel into the user
+ *	buffer.  Skips over unused bytes at the end of sub-buffers.
+
+ *	Returns # bytes actually read, or negative on error.
+ */
+static ssize_t
+__relay_read_last(struct rchan *rchan, char * buf, size_t count)
+{
+	size_t avail_count;
+	u32 buf_size = rchan->buf_size;
+	int err = 0, unused_bytes = 0;
+	int include_nbufs = 1;
+	int write_count, total_write_count = 0;
+	int cur_bufno = 0;
+	u32 start_offset;
+	int i;
+	
+	if (!rchan->initialized)
+		return 0;
+	
+	if (buf == NULL)
+		return -EINVAL;
+
+	avail_count = find_last_start(rchan, count, &cur_bufno, &start_offset,
+				      &include_nbufs);
+	if (avail_count <= 0) 
+	{
+		err = avail_count;
+		goto out;
+	} else if (avail_count > count)
+		avail_count = count;
+
+	for (i=0; i < include_nbufs; i++) {
+		cur_bufno += i;
+		if (cur_bufno == rchan->n_bufs)
+			cur_bufno = 0;
+		unused_bytes = rchan->unused_bytes[cur_bufno];
+		if (avail_count > buf_size - unused_bytes - start_offset)
+			write_count = buf_size - unused_bytes - start_offset;
+		else
+			write_count = avail_count;
+
+		if ((err = copy_to_user(buf + total_write_count, rchan->buf + cur_bufno * buf_size + start_offset, write_count))) {
+			err = -EFAULT;
+			goto out;
+		}
+
+		start_offset = 0;
+		avail_count -= write_count;
+		total_write_count += write_count;
+	}
+	return total_write_count;	
+out:
+	return err;
+}
+
+/**
+ *	relay_read_last - read last count bytes from channel
+ *	@rchan_id: the channel id
+ *	@buf: user buf to read into
+ *	@count: bytes requested
+ *
+ *	The handle version - see _relay_read_last for details.
+ */
+ssize_t
+relay_read_last(int rchan_id, char * buf, size_t count)
+{
+	ssize_t read_count;
+	
+	struct rchan *rchan;
+
+	rchan = rchan_get(rchan_id);
+	if (rchan == NULL)
+		return -EBADF;
+
+	read_count = __relay_read_last(rchan, buf, count);
+
+	rchan_put(rchan);
+
+	return read_count;
+}
+
+/**
+ *	__relay_bytes_avail - get # bytes available in a sub-buffer
+ *	@rchan: the channel
+ *	@read_offset: starting at this offset
+ *	
+ *	Returns the number of bytes available in the current buffer,
+ *	following read_offset.  Note that this doesn't return the total
+ *	bytes available in the buffer - this is enough though to know
+ *	if anything is available.
+ */
+static ssize_t
+__relay_bytes_avail(struct rchan *rchan, u32 read_offset)
+{
+	u32 read_bufno;
+	u32 avail_offset, max_offset, buf_end_offset;
+	u32 avail_count = 0, buf_size;
+	u32 n_bufs;
+	int err = 0, unused_bytes = 0;
+
+	if (!rchan->initialized)
+		return 0;
+	
+	if (rchan->replace_buffer)
+		return 0;
+
+	buf_size = rchan->buf_size;
+	n_bufs = rchan->n_bufs;
+	
+	if ((n_bufs <= 0) || (n_bufs >= RELAY_MAX_BUFS)) {
+		err = -EINVAL;
+		goto out;
+	}
+	
+	if (buf_size) { /* paranoia */
+		read_bufno = read_offset / buf_size;
+		if (read_bufno < RELAY_MAX_BUFS)
+			unused_bytes = rchan->unused_bytes[read_bufno];
+		else {
+			err = -EINVAL;
+			goto out;
+		}
+	} else {
+		err = -EINVAL;
+		goto out;
+	}
+
+	avail_offset = relay_get_offset(rchan, &max_offset);
+	buf_end_offset = (read_bufno + 1) * buf_size - unused_bytes;
+
+	if (avail_offset > buf_end_offset || avail_offset < read_offset)
+		avail_offset = buf_end_offset;
+
+	avail_count = avail_offset - read_offset;
+	return avail_count;
+out:
+	return err;
+}
+
+/**
+ *	relay_bytes_avail - get # bytes available in a sub-buffer
+ *	@rchan_id: relay channel id
+ *	@read_offset: starting at this offset
+ *	
+ *	The handle version - see __relay_bytes_avail for details.
+ */
+ssize_t
+relay_bytes_avail(int rchan_id, u32 read_offset)
+{
+	ssize_t avail_count;
+	
+	struct rchan *rchan;
+
+	rchan = rchan_get(rchan_id);
+	if (rchan == NULL)
+		return -EBADF;
+
+	avail_count = __relay_bytes_avail(rchan, read_offset);
+
+	rchan_put(rchan);
+
+	return avail_count;
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
+	u32 f_pos;
+	ssize_t avail_count;
+	u32 buffers_ready;
+	struct rchan *rchan = reader->rchan;
+	u32 cur_idx, curbuf_bytes;
+
+	if (rchan->mapped && bulk_delivery(rchan)) {
+		buffers_ready = rchan->bufs_produced - rchan->bufs_consumed;
+		return buffers_ready ? 0 : 1;
+	}
+
+	if ((rchan->mapped && packet_delivery(rchan)) || reader->auto_consume) {
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
+	if (reader->vfs_reader)
+		f_pos = (u32)reader->pos.file->f_pos;
+	else
+		f_pos = reader->pos.f_pos;
+
+	avail_count = __relay_bytes_avail(rchan, f_pos);
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
+ *	
+ *	Fills in an rchan_info struct with channel status and attribute 
+ *	information such as usage modes, sub-buffer size and count, the
+ *	allocated size of the entire buffer, buffers produced and consumed,
+ *	current buffer id, count of writes lost due to buffers full condition.
+ *	
+ *	Clients may need to know how many 'unused' bytes there are at the
+ *	end of a given sub-buffer.  This would only be the case if the client
+ *	1) didn't either write this count to the end of the sub-buffer or
+ *	otherwise note it (it's available as the difference between the buffer
+ *	end and current write pos params in the buffer_end callback) (if the
+ *	client returned 0 from the buffer_end callback, it's assumed that this
+ *	is indeed the case)  2) isn't using the read() system call to read the 
+ *	buffer.  In other words, if the client isn't annotating the stream
+ *	and is reading the buffer by mmaping it, this information would be
+ *	needed in order for the client to 'skip over' the unused bytes at the
+ *	ends of sub-buffers.
+ *
+ *	Additionally, for the lockless scheme, clients may need to know whether
+ *	a particular sub-buffer is actually complete.  An array of boolean
+ *	values, one per sub-buffer, contains non-zero if the buffer is 
+ *	complete, non-zero otherwise.
+ */
+int 
+relay_info(int rchan_id, struct rchan_info *rchan_info)
+{
+	int i;
+	struct rchan *rchan;
+
+	rchan = rchan_get(rchan_id);
+	if (rchan == NULL) {
+		return -1;
+	}
+
+	rchan_info->flags = rchan->flags;
+	rchan_info->buf_size = rchan->buf_size;
+	rchan_info->buf_addr = rchan->buf;
+	rchan_info->alloc_size = rchan->alloc_size;
+	rchan_info->n_bufs = rchan->n_bufs;
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
+ *	relay_close - close the channel
+ *	@rchan_id: relay channel id
+ *	
+ *	Finalizes the last sub-buffer and marks the channel as finalized.
+ *	The release of the channel buffer and channel data structure is
+ *	handled elsewhere.
+ */
+int 
+relay_close(int rchan_id)
+{
+	struct rchan *rchan;
+	int err;
+
+	if ((rchan_id < 0) || (rchan_id >= RELAY_MAX_CHANNELS))
+		return -EBADF;
+	
+	err = relay_finalize(rchan_id);
+	if (!err) {
+		read_lock(&rchan_table_lock);
+		rchan = rchan_table[rchan_id];
+		read_unlock(&rchan_table_lock);
+
+		if (rchan)
+			rchan_put(rchan);
+	}
+	
+	return err;
+}
+
+/**
+ *	expand_check - check whether the channel needs expanding
+ *	@rchan: the channel
+ *	@active_bufs: the number of unread sub-buffers
+ *
+ *	See resize_check() for details.
+ *
+ *	Returns the suggested number of sub-buffers for the new
+ *	buffer.
+ */
+static inline u32
+expand_check(struct rchan *rchan, u32 active_bufs)
+{
+	u32 new_n_bufs = 0;
+	
+	if (rchan->resize_max && !rchan->mapped &&
+	   active_bufs == (rchan->n_bufs * RESIZE_THRESHOLD)) {
+		new_n_bufs = rchan->n_bufs * 2;
+	}
+
+	return new_n_bufs;
+}
+
+/**
+ *	shrink_check - check whether the channel needs shrinking
+ *	@rchan: the channel
+ *	@active_bufs: the number of unread sub-buffers
+ *
+ *	See resize_check() for details.
+ *
+ *	Returns the suggested number of sub-buffers for the new
+ *	buffer.
+ */
+static inline u32
+shrink_check(struct rchan *rchan, u32 active_bufs)
+{
+	u32 needed_bufsize, n;
+	struct timeval ts;
+	u32 low_water_time;
+	u32 new_n_bufs = 0;
+
+	if (rchan->resize_min == 0 || rchan->mapped ||
+	   rchan->resize_min >= rchan->n_bufs * rchan->buf_size)
+		goto out;
+	
+	if (active_bufs > rchan->n_bufs * RESIZE_THRESHOLD) {
+		do_gettimeofday(&rchan->low_water_time);
+		goto out;
+	}
+	
+	do_gettimeofday(&ts);
+	low_water_time = calc_time_delta(&ts, &rchan->low_water_time);
+	if (low_water_time > LOW_WATER_TIME) {
+		needed_bufsize = active_bufs * rchan->buf_size;
+		for (n = 4; n < rchan->n_bufs; n *= 2) {
+			if ((n * rchan->buf_size >= rchan->resize_min) &&
+			   (n * rchan->buf_size <= rchan->resize_max) &&
+			   (n * (rchan->buf_size * RESIZE_THRESHOLD) > needed_bufsize))
+				break;
+		}
+
+		if (n >= rchan->n_bufs || n < 4)
+			goto out;
+		
+		new_n_bufs = n;
+	}
+out:
+	return new_n_bufs;
+}
+
+/**
+ *	resize_check - check whether the channel needs resizing
+ *	@rchan: the channel
+ *
+ *	If the channel is above 3/4 full, it will be doubled in
+ *	size.  If a minute has passed since the last resize, and
+ *	it's no longer full, it will be shrunk to whatever size
+ *	will comfortably fit the contents.
+ */
+void
+resize_check(struct rchan *rchan)
+{
+	u32 active_bufs;
+	u32 new_n_bufs;
+	int resize_type = RELAY_RESIZE_NONE;
+
+	if (rchan->resize_min == 0)
+		return;
+
+	active_bufs = rchan->bufs_produced - rchan->bufs_consumed + 1;
+
+	new_n_bufs = expand_check(rchan, active_bufs);
+	if (new_n_bufs) {
+		resize_type = RELAY_RESIZE_EXPAND;
+	}
+	else {
+		new_n_bufs = shrink_check(rchan, active_bufs);
+		if (new_n_bufs)
+			resize_type = RELAY_RESIZE_SHRINK;
+	}
+	
+	if (resize_type != RELAY_RESIZE_NONE)
+		rchan->callbacks->needs_resize(rchan->id,
+					       resize_type,
+					       rchan->buf_size, 
+					       new_n_bufs);
+}
+
+/**
+ *	move_expand - moves old buffer to larger buffer
+ *	@rchan: the channel
+ *	@newsize: the size of the new buffer
+ *	@oldsize: the size of the old buffer
+ *	@oldsize: the old buffer
+ *	@old_cur_idx: the current index into the old buffer
+ *	@old_buf_size: the old buffer's sub-buffer size
+ *
+ *	Moves the contents of the current relay channel buffer into the
+ *	new channel buffer, splitting them at old_cur_idx, the bottom
+ *	half of the old buffer going to the bottom of the new, likewise
+ *	for the top half.
+ */
+static void
+move_expand(struct rchan *rchan, int newsize, int oldsize, char * oldbuf, u32 old_cur_idx, u32 old_buf_size, u32 old_n_bufs)
+{
+	char *copy_first, *copy_last = NULL;
+	u32 copy_first_size = 0, copy_last_size = 0;
+	u32 newbufs;
+	int old_cur_bufno, new_cur_bufno, delta, i;
+	u32 ge, le;
+
+	old_cur_bufno = old_cur_idx / old_buf_size;
+	new_cur_bufno = old_cur_bufno;
+
+	copy_first = oldbuf;
+	copy_first_size = (old_cur_bufno + 1) * old_buf_size;
+	memcpy(rchan->buf, copy_first, copy_first_size);
+
+	copy_last = copy_first + copy_first_size;
+	copy_last_size = oldsize - copy_first_size;
+	memcpy(rchan->buf + copy_first_size + newsize - oldsize,
+	       copy_last, copy_last_size);
+
+	memset(rchan->buf + copy_first_size, 0, newsize - oldsize);
+
+	newbufs = (newsize - oldsize) / rchan->buf_size;
+	for (i = old_cur_bufno + 1; i < old_n_bufs; i++) {
+		if (using_lockless(rchan))
+			atomic_set(&fill_count(rchan, i + newbufs), 
+				   atomic_read(&fill_count(rchan, i)));
+		rchan->unused_bytes[i + newbufs] = rchan->unused_bytes[i];
+	}
+	for (i = old_cur_bufno + 1; i < old_cur_bufno + newbufs + 1; i++) {
+		if (using_lockless(rchan))
+			atomic_set(&fill_count(rchan, i),
+				   (int)RELAY_BUF_SIZE(offset_bits(rchan)));
+		rchan->unused_bytes[i] = 0;
+	}
+
+	rchan->buf_idx = new_cur_bufno;
+
+	if (!using_lockless(rchan)) {
+		cur_write_pos(rchan) = rchan->buf + old_cur_idx;
+		write_buf(rchan) = rchan->buf + old_cur_bufno * rchan->buf_size;
+		write_buf_end(rchan) = write_buf(rchan) + rchan->buf_size;
+		write_limit(rchan) = write_buf_end(rchan) - rchan->end_reserve;
+		if (in_progress_event_pos(rchan) != NULL)
+			in_progress_event_pos(rchan) = rchan->buf + (in_progress_event_pos(rchan) - oldbuf);
+		if (interrupted_pos(rchan) != NULL)
+			interrupted_pos(rchan) = rchan->buf + (interrupted_pos(rchan) - oldbuf);
+	}
+	
+	delta = newsize - oldsize;
+	ge = (old_cur_bufno + 1) * old_buf_size;
+	le = oldsize;
+	save_resize_offset(rchan, ge, le, delta);
+}
+
+/* Used only for buffer shrinking */
+static int tmp_unused[RELAY_MAX_BUFS];
+static atomic_t tmp_fill[RELAY_MAX_BUFS];
+
+/**
+ *	move_to_bottom - helper function used to move to shrunken buffer
+ *
+ *	Moves the contents of the current relay channel sub-buffer into
+ *	the bottom of the new channel buffer.
+
+ *	Returns the change in position of the new sub-buffer.
+ */
+static int
+move_to_bottom(struct rchan *rchan, char * oldbuf, u32 old_buf_size, int old_cur_bufno, int new_cur_bufno)
+{
+	int delta;
+	u32 ge, le;
+
+	memcpy(rchan->buf + new_cur_bufno * old_buf_size,
+	       oldbuf + old_cur_bufno * old_buf_size, old_buf_size);
+	if (using_lockless(rchan))
+		atomic_set(&fill_count(rchan, new_cur_bufno),
+			   atomic_read(&tmp_fill[old_cur_bufno]));
+	rchan->unused_bytes[new_cur_bufno] = tmp_unused[old_cur_bufno];
+
+	ge = old_cur_bufno * old_buf_size;
+	le = (old_cur_bufno + 1) * old_buf_size;
+	delta = -(old_cur_bufno * old_buf_size);
+	if (old_cur_bufno != 0)
+		save_resize_offset(rchan, ge, le, delta);
+
+	return delta;
+}
+
+/**
+ *	move_remainder - helper function used to move to shrunken buffer
+ *
+ *	Moves the the contents of the rest of the relay channel sub-buffers
+ *	not already moved, into the remainder of the new channel buffer.
+ */
+static void
+move_remainder(struct rchan *rchan, char * oldbuf, u32 old_buf_size, u32 old_n_bufs, int old_cur_bufno, int new_cur_bufno, int move_n_bufs)
+{
+	int delta = 0, i;
+	u32 ge, le;
+
+	le = (old_cur_bufno + 1) * old_buf_size;
+	ge = le;
+		
+	for (i = 0; i < move_n_bufs; i++, --old_cur_bufno, --new_cur_bufno) {
+		if (old_cur_bufno < 0) {
+			if (le != ge) {
+				old_cur_bufno = old_n_bufs - 1;
+				save_resize_offset(rchan, ge, le, delta);
+				le = (old_cur_bufno + 1) * old_buf_size;
+				ge = le;
+			}
+		}
+
+		memcpy(rchan->buf + new_cur_bufno * old_buf_size,
+		       oldbuf + old_cur_bufno * old_buf_size, old_buf_size);
+		if (using_lockless(rchan))
+			atomic_set(&fill_count(rchan, new_cur_bufno),
+				   atomic_read(&tmp_fill[old_cur_bufno]));
+		rchan->unused_bytes[new_cur_bufno] = tmp_unused[old_cur_bufno];
+
+		ge -= old_buf_size;
+		if (old_cur_bufno >= new_cur_bufno)
+			delta = -(old_cur_bufno - new_cur_bufno);
+		else
+			delta = new_cur_bufno - old_cur_bufno;
+		
+		delta *= old_buf_size;
+	}
+	
+	if (le != ge)
+		save_resize_offset(rchan, ge, le, delta);
+}
+
+/**
+ *	move_shrink - move old buffer to smaller buffer
+ *	@rchan: the channel
+ *	@newsize: the size of the new buffer
+ *	@oldsize: the size of the old buffer
+ *	@oldsize: the old buffer
+ *	@old_cur_idx: the current index into the old buffer
+ *	@old_buf_size: the old buffer's sub-buffer size
+ *	@old_n_buf: the old buffer's sub-buffer count
+ *
+ *	Moves the contents of the old relay channel buffer into the
+ *	new channel buffer.
+ */
+static void
+move_shrink(struct rchan *rchan, int newsize, int oldsize, char * oldbuf, u32 old_cur_idx, u32 old_buf_size, u32 old_n_bufs)
+{
+	int old_cur_bufno, new_cur_bufno, move_n_bufs, delta, i;
+
+	for (i = 0; i < RELAY_MAX_BUFS; i++) {
+		tmp_unused[i] = rchan->unused_bytes[i];
+		if (using_lockless(rchan))
+			tmp_fill[i] = rchan->scheme.lockless.fill_count[i];
+	}
+	
+	old_cur_bufno = old_cur_idx / old_buf_size;
+	new_cur_bufno = 0;
+
+	delta = move_to_bottom(rchan, oldbuf, old_buf_size, old_cur_bufno, new_cur_bufno);
+	if (using_lockless(rchan))
+		idx(rchan) += delta;
+	else {
+		cur_write_pos(rchan) = rchan->buf + old_cur_idx;
+		cur_write_pos(rchan) += delta;
+		write_buf(rchan) = rchan->buf;
+		write_buf_end(rchan) = write_buf(rchan) + rchan->buf_size;
+		write_limit(rchan) = write_buf_end(rchan) - rchan->end_reserve;
+		if (in_progress_event_pos(rchan) != NULL)
+			in_progress_event_pos(rchan) = rchan->buf + (in_progress_event_pos(rchan) - oldbuf);
+		if (interrupted_pos(rchan) != NULL)
+			interrupted_pos(rchan) = rchan->buf + (interrupted_pos(rchan) - oldbuf);
+	}
+
+	move_n_bufs = rchan->n_bufs - 1;
+	new_cur_bufno = rchan->n_bufs - 1;
+	old_cur_bufno--;
+	if (old_cur_bufno < 0)
+		old_cur_bufno = old_n_bufs - 1;
+
+	move_remainder(rchan, oldbuf, old_buf_size, old_n_bufs, old_cur_bufno,
+		       new_cur_bufno, move_n_bufs);
+
+	rchan->buf_idx = rchan->buf_idx - rchan->buf_idx % rchan->n_bufs;
+}
+
+/**
+ *	move_contents - moves the contents of the old buffer into the new
+ *	@rchan: the channel
+ *	@newsize: the size of the new buffer
+ *	@oldsize: the size of the old buffer
+ *	@oldsize: the old buffer
+ *	@old_cur_idx: the current index into the old buffer
+ *	@old_buf_size: the old buffer's sub-buffer size
+ *	@old_n_bufs: the old buffer's sub-buffer count
+ *
+ *	Moves the contents of the old relay channel buffer into the
+ *	new channel buffer.
+ */
+static void
+move_contents(struct rchan *rchan, int newsize, int oldsize, char * oldbuf, u32 old_cur_idx, u32 old_buf_size, u32 old_n_bufs)
+{
+	int i;
+
+	clear_resize_offsets(rchan);
+	
+	if (using_lockless(rchan)) {
+		bufno_bits(rchan) += resize_order(rchan);
+		idx_mask(rchan) =
+			(1UL << (bufno_bits(rchan) + offset_bits(rchan))) - 1;
+	}
+	
+	if (resize_order(rchan) > 0) {
+		for (i = rchan->n_bufs / 2; i < rchan->n_bufs; i++) {
+			if (using_lockless(rchan))
+				atomic_set(&fill_count(rchan, i),
+				   (int)RELAY_BUF_SIZE(offset_bits(rchan)));
+			rchan->unused_bytes[i] = 0;
+		}
+	}
+
+	if (newsize > oldsize)
+		move_expand(rchan, newsize, oldsize, oldbuf,
+			    old_cur_idx, old_buf_size, old_n_bufs);
+	else
+		move_shrink(rchan, newsize, oldsize, oldbuf,
+			    old_cur_idx, old_buf_size, old_n_bufs);
+
+	if (rchan->offset_change_count)
+		update_file_offsets(rchan);
+}
+
+/**
+ *	do_replace_buffer - does the work of channel buffer replacement
+ *	@rchan: the channel
+ *	@newsize: new channel buffer size
+ *	@oldsize: old channel buffer size
+ *	@oldbuf: pointer to the old channel buffer
+ *	@old_buf_size: old channel sub-buffer size
+ *	@old_n_bufs: old channel sub-buffer count
+ *
+ *	Does the work of copying old buffer contents to new and fixing
+ *	everything up so the channel can continue with a new size.
+ */
+static void
+do_replace_buffer(struct rchan *rchan,
+		  int newsize,
+		  int oldsize,
+		  char * oldbuf,
+		  u32 old_buf_size,
+		  u32 old_n_bufs)
+{
+	u32 old_cur_idx;
+	
+	old_cur_idx = relay_get_offset(rchan, NULL);
+	
+	rchan->buf = rchan->resize_buf;
+	rchan->alloc_size = rchan->resize_alloc_size;
+	rchan->buf_size = rchan->resize_buf_size;
+	rchan->n_bufs = rchan->resize_n_bufs;
+
+	move_contents(rchan, newsize, oldsize, oldbuf, old_cur_idx, old_buf_size, old_n_bufs);
+
+	rchan->resize_buf = NULL;
+	rchan->resize_buf_size = 0;
+	rchan->resize_alloc_size = 0;
+	rchan->resize_n_bufs = 0;
+	rchan->resize_err = 0;
+	resize_order(rchan) = 0;
+
+	rchan->callbacks->needs_resize(rchan->id,
+				       RELAY_RESIZE_REPLACED,
+				       rchan->buf_size,
+				       rchan->n_bufs);
+}
+
+/**
+ *	free_replaced_buffer - free a channel's old buffer
+ *	@rchan: the channel
+ *	@oldbuf: the old buffer
+ *	@oldsize: old buffer size
+ *
+ *	Frees a channel buffer via a work queue.
+ */
+static int
+free_replaced_buffer(struct rchan *rchan, char *oldbuf, int oldsize)
+{
+	struct free_rchan_buf *free_buf;
+
+	free_buf = kmalloc(sizeof(struct free_rchan_buf), GFP_ATOMIC);
+	if (!free_buf) {
+		return -ENOMEM;
+	}
+	free_buf->free_buf = oldbuf;
+	free_buf->free_alloc_size = oldsize;
+	INIT_WORK(&free_buf->work, relaybuf_free, free_buf);
+	schedule_delayed_work(&free_buf->work, 1);
+
+	return 0;
+}
+
+/**
+ *	__relay_replace_buffer - replace channel buffer with new buffer
+ *	@rchan: the channel
+ *
+ *	Replaces the current channel buffer with the new buffer allocated
+ *	by relay_alloc_buffer and contained in rchan.
+ *	When the replacement is done, the needs_resize() callback is 
+ *	called with a resize_type of RELAY_RESIZE_REPLACED.
+ *	
+ *	This function (or rather the handle version, relay_replace_buffer())
+ *	is called by kernel clients in response to a needs_resize() callback
+ *	call with a resize type of RELAY_RESIZE_REPLACE.  Because the copy
+ *	of contents from the old buffer into the new can result in sections
+ *	of the buffer being rearranged, if the client is using offsets to
+ *	reference positions within the buffer, those offsets may no longer
+ *	be valid.  The resize_offset() callback is used to deal with this
+ *	situation.
+ *
+ *	Returns 0 on success, or errcode if the channel is busy or if
+ *	the replacement or previous allocation didn't happen for some reason.
+ *	
+ *	NOTE: This function will not sleep, so can called in any context
+ *	and with locks held.  The client should, however, ensure that the
+ *	channel isn't actively being read from or written to.
+ */
+static int
+__relay_replace_buffer(struct rchan *rchan)
+{
+	int oldsize;
+	int err = 0;
+	char *oldbuf;
+	
+	if (down_trylock(&rchan->resize_sem)) {
+		return -EBUSY;
+	}
+
+	if (!rchan->replace_buffer)
+		goto out;
+
+	if (rchan->resizing) {
+		err = -EBUSY;
+		goto out;
+	}
+
+	if (rchan->resize_buf == NULL) {
+		err = rchan->resize_err;
+		rchan->resize_failures++;
+		goto out;
+	}
+
+	if (rchan->buf == NULL) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	oldbuf = rchan->buf;
+	oldsize = rchan->alloc_size;
+
+	do_replace_buffer(rchan, rchan->resize_alloc_size, oldsize, oldbuf,
+			  rchan->buf_size, rchan->n_bufs);
+
+	err = free_replaced_buffer(rchan, oldbuf, oldsize);
+	if (err)
+		goto out;
+	
+	do_gettimeofday(&rchan->low_water_time);
+out:
+	rchan->replace_buffer = 0;
+	up(&rchan->resize_sem);
+	
+	return err;
+}
+
+/**
+ *	relay_replace_buffer - replace channel buffer with new buffer
+ *	@rchan_id: the channel id
+ *
+ *	The handle version - see __relay_replace_buffer for details.
+ */
+int
+relay_replace_buffer(int rchan_id)
+{
+	int err;
+	
+	struct rchan *rchan;
+
+	rchan = rchan_get(rchan_id);
+	if (rchan == NULL)
+		return -EBADF;
+
+	err = __relay_replace_buffer(rchan);
+	
+	rchan_put(rchan);
+
+	return err;
+}
+
+EXPORT_SYMBOL(relay_open);
+EXPORT_SYMBOL(relay_reset);
+EXPORT_SYMBOL(relay_close);
+EXPORT_SYMBOL(relay_reserve);
+EXPORT_SYMBOL(relay_commit);
+EXPORT_SYMBOL(relay_read);
+EXPORT_SYMBOL(relay_read_last);
+EXPORT_SYMBOL(relay_write);
+EXPORT_SYMBOL(relay_buffers_consumed);
+EXPORT_SYMBOL(relay_bytes_consumed);
+EXPORT_SYMBOL(relay_info);
+EXPORT_SYMBOL(relay_realloc_buffer);
+EXPORT_SYMBOL(relay_replace_buffer);
+EXPORT_SYMBOL(relay_bytes_avail);
+
+
+



-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

