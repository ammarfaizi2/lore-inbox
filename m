Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268396AbTGOPJw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 11:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268470AbTGOPJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 11:09:51 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:5791 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268396AbTGOPD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 11:03:56 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16148.6938.551232.876021@gargle.gargle.HOWL>
Date: Tue, 15 Jul 2003 10:17:46 -0500
To: linux-kernel@vger.kernel.org
Cc: karim@opersys.com, bob@watson.ibm.com
Subject: [RFC][PATCH 4/5] relayfs API and common code
X-Mailer: VM(ViewMail) 7.01 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN -X dontdiff linux-2.6.0-test1/fs/relayfs/relay.c linux-2.6.0-test1-relayfs-printk/fs/relayfs/relay.c
--- linux-2.6.0-test1/fs/relayfs/relay.c	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/fs/relayfs/relay.c	Sun Jul 13 22:32:44 2003
@@ -0,0 +1,2000 @@
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
+	.resume = lockless_resume,
+	.finalize = lockless_finalize,
+	.copy_contents = lockless_copy_contents
+};
+
+static struct relay_ops locking_ops = {
+	.reserve = locking_reserve,
+	.commit = locking_commit,
+	.get_offset = locking_get_offset,
+	.resume = locking_resume,
+	.finalize = locking_finalize,
+	.copy_contents = locking_copy_contents
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
+check_size(struct rchan *rchan, u32 bufsize, u32 nbufs, int *err)
+{
+	u32 new_channel_size = 0;
+
+	*err = 0;
+	
+	if (bufsize > rchan->buf_size || nbufs > rchan->n_bufs) {
+		if (using_lockless(rchan)) {
+			resize_order(rchan) = calc_order(nbufs, rchan->n_bufs);
+			if (!resize_order(rchan)) {
+				*err = -EINVAL;
+				goto out;
+			}
+		}
+
+		new_channel_size = bufsize * nbufs;
+		if (new_channel_size > rchan->resize_max) {
+			*err = -EINVAL;
+			goto out;
+		}
+	} else if (bufsize < rchan->buf_size || nbufs < rchan->n_bufs) {
+		if (using_lockless(rchan)) {
+			if (rchan->n_bufs == 2) {
+				*err = -EINVAL;
+				goto out;
+			}
+			resize_order(rchan) = -calc_order(rchan->n_bufs, nbufs);
+			if (!resize_order(rchan)) {
+				*err = -EINVAL;
+				goto out;
+			}
+		} else {
+			if (rchan->buf_size == RELAY_MIN_BUFSIZE) {
+				*err = -EINVAL;
+				goto out;
+			}
+		}
+		
+		new_channel_size = bufsize * nbufs;
+		if (new_channel_size < rchan->resize_min) {
+			*err = -EINVAL;
+			goto out;
+		}
+	} else {
+		*err = -EINVAL;
+		goto out;
+	}
+out:
+	return new_channel_size;
+}
+
+/**
+ *	_relay_realloc_buffer - allocate a new channel buffer
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
+_relay_realloc_buffer(struct rchan *rchan, u32 new_bufsize, u32 new_nbufs)
+{
+	u32 new_channel_size;
+	int err = 0;
+	
+	if ((using_lockless(rchan) && new_nbufs == rchan->n_bufs) ||
+	   (!using_lockless(rchan) && new_bufsize == rchan->buf_size))
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
+	new_channel_size = check_size(rchan, new_bufsize, new_nbufs, &err);
+	if (err)
+		goto out;
+	
+	rchan->resize_buf_size = new_bufsize;
+	rchan->resize_n_bufs = new_nbufs;
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
+ *	The handle version - see _relay_realloc_buffer for details.
+ */
+int
+relay_realloc_buffer(int rchan_id, u32 new_bufsize, u32 new_nbufs)
+{
+	int err;
+	
+	struct rchan *rchan;
+
+	rchan = rchan_get(rchan_id);
+	if (rchan == NULL)
+		return -EBADF;
+
+	err = _relay_realloc_buffer(rchan, new_bufsize, new_nbufs);
+	
+	rchan_put(rchan);
+
+	return err;
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
+	if (using_lockless(rchan))
+		old_cur_idx = relay_get_offset(rchan, NULL) & idx_mask(rchan);
+	else
+		old_cur_idx = relay_get_offset(rchan, NULL);
+	
+	rchan->buf = rchan->resize_buf;
+	rchan->alloc_size = rchan->resize_alloc_size;
+	rchan->buf_size = rchan->resize_buf_size;
+	rchan->n_bufs = rchan->resize_n_bufs;
+
+	rchan->relay_ops->copy_contents(rchan, newsize, oldsize, oldbuf, old_cur_idx, old_buf_size, old_n_bufs);
+
+	rchan->resize_buf = NULL;
+	rchan->resize_buf_size = 0;
+	rchan->resize_alloc_size = 0;
+	rchan->resize_n_bufs = 0;
+	rchan->resize_err = 0;
+	if (using_lockless(rchan))
+		resize_order(rchan) = 0;
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
+	schedule_work(&free_buf->work);
+
+	return 0;
+}
+
+/**
+ *	_relay_replace_buffer - replace channel buffer with new buffer
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
+_relay_replace_buffer(struct rchan *rchan)
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
+ *	The handle version - see _relay_replace_buffer for details.
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
+	err = _relay_replace_buffer(rchan);
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
+	if (waitqueue_active(&rchan->read_wait))
+		wake_up_interruptible(&rchan->read_wait);
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
+ *	locking scheme can use buffers of any size, but is hardcoded at 2.
+ */
+static struct rchan *
+rchan_create(char *chanpath, 
+	     int bufsize_lockless, 
+	     int nbufs_lockless, 
+	     int bufsize_locking,
+	     int nbufs_locking, 
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
+	if (nbufs_lockless == 1 && bufsize_lockless) {
+		rchan->n_bufs = nbufs_lockless;
+		rchan->buf_size = bufsize_lockless;
+		size_alloc = bufsize_lockless;
+		goto alloc;
+	}
+	
+	if (hweight32(nbufs_lockless) != 1 || hweight32(nbufs_locking) != 1 ||
+	    (rchan_flags & RELAY_SCHEME_LOCKING && nbufs_locking != 2) ||
+	    nbufs_lockless < RELAY_MIN_BUFS ||
+	    nbufs_lockless > RELAY_MAX_BUFS || bufsize_lockless <= 0 ||
+	    nbufs_locking < RELAY_MIN_BUFS ||
+	    nbufs_locking > RELAY_MAX_BUFS || bufsize_locking <= 0) {
+		*err = -EINVAL;
+		goto exit;
+	}
+
+	if (rchan_flags & RELAY_SCHEME_LOCKING) {
+		rchan->n_bufs = 2;
+		rchan->buf_size = bufsize_locking;
+		size_alloc = FIX_SIZE(bufsize_locking << 1);
+	} else {
+		if (hweight32(bufsize_lockless) != 1) {
+			*err = -EINVAL;
+			goto exit;
+		}
+		offset_bits(rchan) = ffs(bufsize_lockless) - 1;
+		offset_mask(rchan) =  RELAY_BUF_OFFSET_MASK(offset_bits(rchan));
+		size_alloc = FIX_SIZE(bufsize_lockless * nbufs_lockless);
+		if (size_alloc > RELAY_LOCKLESS_MAX_BUF_SIZE) {
+			*err = -EINVAL;
+			goto exit;
+		}
+		bufno_bits(rchan) = ffs(nbufs_lockless) - 1;
+		rchan->n_bufs = RELAY_MAX_BUFNO(bufno_bits(rchan));
+		rchan->buf_size = bufsize_lockless;
+	}
+
+alloc:
+
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
+ *	rchan_init - initialize channel
+ *	@rchan: the channel
+ */
+static void 
+rchan_init(struct rchan *rchan)
+{
+	unsigned i;
+
+	rchan->version = RELAYFS_CHANNEL_VERSION;
+	rchan->buf_id = 0;
+	atomic_set(&rchan->suspended, 0);
+	rchan->events_lost = 0;
+	rchan->bufs_produced = 0;
+	rchan->bufs_consumed = 0;
+	rchan->bytes_consumed = 0;
+	rchan->initialized = 0;
+	rchan->finalized = 0;
+	rchan->mapped = 0;
+	rchan->resize_min = rchan->resize_max = 0;
+	rchan->resizing = 0;
+	rchan->replace_buffer = 0;
+	rchan->resize_buf = NULL;
+	rchan->resize_buf_size = 0;
+	rchan->resize_alloc_size = 0;
+	rchan->resize_n_bufs = 0;
+	rchan->resize_err = 0;
+	rchan->resize_failures = 0;
+	rchan->offsets_changed = 0;
+
+	do_gettimeofday(&rchan->low_water_time);
+	init_MUTEX(&rchan->resize_sem);
+	
+	init_waitqueue_head(&rchan->read_wait);
+	atomic_set(&rchan->refcount, 0);
+
+	for (i = 0; i < RELAY_MAX_BUFS; i++)
+		rchan->unused_bytes[i] = 0;
+	
+	if (using_locking(rchan)) {
+		write_buf(rchan) = rchan->buf;
+		read_buf(rchan) = rchan->buf + rchan->buf_size;
+		write_buf_end(rchan) = write_buf(rchan) + rchan->buf_size;
+		read_buf_end(rchan) = read_buf(rchan) + rchan->buf_size;
+		cur_write_pos(rchan) = write_buf(rchan);
+		read_limit(rchan) = read_buf(rchan);
+		write_limit(rchan) = write_buf_end(rchan) - rchan->end_reserve;
+		in_progress_event_pos(rchan) = NULL;
+		in_progress_event_size(rchan) = 0;
+		interrupted_pos(rchan) = NULL;
+		interrupting_size(rchan) = 0;
+		channel_lock(rchan) = SPIN_LOCK_UNLOCKED;
+		bytes_produced(rchan) = 0;
+	} else {
+		resize_order(rchan) = 0;
+		/* Start first buffer at 0 - (end_reserve + 1) so that it
+		   gets initialized via buffer_start callback as well. */
+		idx(rchan) =  0UL - (rchan->end_reserve + 1);
+		idx_mask(rchan) =
+			(1UL << (bufno_bits(rchan) + offset_bits(rchan))) - 1;
+		atomic_set(&fill_count(rchan, 0), 
+			   (int)rchan->start_reserve + 
+			   (int)rchan->rchan_start_reserve);
+		for (i = 1; i < rchan->n_bufs; i++)
+			atomic_set(&fill_count(rchan, i),
+				   (int)RELAY_BUF_SIZE(offset_bits(rchan)));
+	}
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
+rchan_create_dir(char * chanpath, 
+		 char **residual, 
+		 struct dentry **topdir)
+{
+	char *cp = chanpath, *next;
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
+rchan_create_file(char * chanpath, 
+		  struct dentry **dentry, 
+		  struct rchan * data)
+{
+	int err;
+	char * fname;
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
+ *	buffer_start, buffer_end and buffers_full callbacks are triggered
+ *	at this point if applicable.
+ *
+ */
+char *relay_reserve(struct rchan *rchan,
+		    u32 len,
+		    struct timeval *ts,
+		    u32 *td,
+		    int *err,
+		    int *interrupting)
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
+void relay_commit(struct rchan *rchan,
+		  char *from, 
+		  u32 len, 
+		  int reserve_code,
+		  int interrupting)
+{
+	int deliver;
+
+	deliver = packet_delivery(rchan) || 
+		   (reserve_code & RELAY_BUFFER_SWITCH);
+
+	rchan->relay_ops->commit(rchan, from, len, deliver, interrupting);
+
+	if (deliver && waitqueue_active(&rchan->read_wait))
+		wake_up_interruptible(&rchan->read_wait);
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
+ * Do nothing when buffers_full condition detected.  Return 0 i.e. continue.
+ */
+static int 
+buffers_full_default_callback(int rchan_id)
+{
+	return 0;
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
+
+/*
+ * Do nothing for resized offsets.
+ */
+static void
+resize_offset_default_callback(int rchan_id,
+			       u32 ge_offset,
+			       u32 le_offset,
+			       int delta)
+{
+}
+
+/* relay channel default callbacks */
+static struct rchan_callbacks default_channel_callbacks = {
+	.buffer_start = buffer_start_default_callback,
+	.buffer_end = buffer_end_default_callback,
+	.deliver = deliver_default_callback,
+	.buffers_full = buffers_full_default_callback,
+	.needs_resize = needs_resize_default_callback,
+	.resize_offset = resize_offset_default_callback
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
+ *	@bufsize_lockless: size of lockless sub-buffers, if scheme is lockless
+ *	@nbufs_lockless: number of lockless sub-buffers, if scheme is lockless
+ *	@bufsize_locking: size of locking sub-buffers, if scheme is locking
+ *	@nbufs_locking: number of locking sub-buffers, if scheme is locking
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
+ *	unless requested, and are available via the channel callbacks.  Both
+ *	the delivery mode (RELAY_DELIVERY_xxx) and the usage mode 
+ *	(RELAY_USAGE_xxx) must be explicitly specified.
+ *
+ *	The total size of the channel buffer is bufsize * nbufs rounded up 
+ *	to the next kernel page size.  If the lockless scheme is used, both
+ *	bufsize and nbufs must be a power of 2.  If the locking scheme is
+ *	used, the bufsize can be anything and nbufs should be 2.  If
+ *	RELAY_SCHEME_ANY is specified, clients should specify a bufsize that's
+ *	a power of 2, and an nbufs value that would be preferred for the 
+ *	lockless scheme - if the locking scheme is chosen, nbufs will be 
+ *	automatically set to 2.
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
+ *	nothing.  The default buffers_full callback returns 0, which will
+ *	cause the channel to wrap around continuously.
+ */
+int 
+relay_open(char *chanpath,
+	   int bufsize_lockless,
+	   int nbufs_lockless,
+	   int bufsize_locking,
+	   int nbufs_locking,
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
+	if (nbufs_lockless != 1) {
+		err = check_attribute_flags(&flags);
+		if (err)
+			return err;
+	}
+	
+	rchan = rchan_create(chanpath, bufsize_lockless, nbufs_lockless,
+			     bufsize_locking, nbufs_locking, flags, &err);
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
+	if (callbacks->buffers_full == NULL)
+		callbacks->buffers_full = buffers_full_default_callback;
+	if (callbacks->needs_resize == NULL)
+		callbacks->needs_resize = needs_resize_default_callback;
+	if (callbacks->resize_offset == NULL)
+		callbacks->resize_offset = resize_offset_default_callback;
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
+	rchan_init(rchan);
+
+	if (resize_min > 0 && resize_max > 0 && 
+	   resize_max < RELAY_LOCKLESS_MAX_TOTAL_BUF_SIZE) {
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
+ *	_relay_read - read file op for relayfs files
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
+_relay_read(struct rchan *rchan, char * buf, size_t count, u32 read_offset, u32 *new_offset, int wait)
+{
+	int err = 0;
+	size_t read_count = 0;
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
+		if (rchan->offsets_changed) {
+			rchan->offsets_changed = 0;
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
+ *	@read_offset: offset into file
+ *	@new_offset: new offset into file
+ *	@wait: if non-zero, wait for something to read
+ *
+ *	The handle version - see _relay_read for details.
+ */
+ssize_t
+relay_read(int rchan_id, char * buf, size_t count, u32 read_offset, u32 *new_offset, int wait)
+{
+	ssize_t read_count;
+	
+	struct rchan *rchan;
+
+	rchan = rchan_get(rchan_id);
+	if (rchan == NULL)
+		return -EBADF;
+
+	read_count = _relay_read(rchan, buf, count, read_offset,
+				 new_offset, wait);
+
+	rchan_put(rchan);
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
+	size_t avail_count, avail_in_buf;
+	int unused_bytes = 0;
+
+	if (rchan->bufs_produced < rchan->n_bufs)
+		try_bufcount = rchan->bufs_produced;
+	else
+		try_bufcount = rchan->n_bufs - 1;
+
+	if (using_lockless(rchan))
+		cur_idx = relay_get_offset(rchan, NULL) & idx_mask(rchan);
+	else {
+		cur_idx = relay_get_offset(rchan, NULL);
+		try_bufcount = 1;
+	}
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
+out:
+	if (err)
+		return err;
+	else {
+		*start_bufno = cur_bufno;
+		*use_nbufs = include_nbufs;
+		return avail_count;
+	}
+}
+
+/**
+ *	_relay_read_last - read last count bytes from channel
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
+_relay_read_last(struct rchan *rchan, char * buf, size_t count)
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
+	
+out:
+	if (err)
+		return err;
+	else
+		return total_write_count;
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
+	read_count = _relay_read_last(rchan, buf, count);
+
+	rchan_put(rchan);
+
+	return read_count;
+}
+
+/**
+ *	_relay_bytes_avail - get # bytes available in a sub-buffer
+ *	@rchan: the channel
+ *	@read_offset: starting at this offset
+ *	
+ *	Returns the number of bytes available in the current buffer,
+ *	following read_offset.  Note that this doesn't return the total
+ *	bytes available in the buffer - this is enough though to know
+ *	if anything is available.
+ */
+ssize_t
+_relay_bytes_avail(struct rchan *rchan, u32 read_offset)
+{
+	u32 read_bufno;
+	u32 avail_offset, max_offset, buf_end_offset;
+	u32 avail_count = 0, buf_size;
+	u32 n_bufs;
+	int err = 0, unused_bytes = 0;
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
+
+out:
+	if (err)
+		return err;
+	else
+		return avail_count;
+}
+
+/**
+ *	relay_bytes_avail - get # bytes available in a sub-buffer
+ *	@rchan_id: relay channel id
+ *	@read_offset: starting at this offset
+ *	
+ *	The handle version - see _relay_bytes_avail for details.
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
+	avail_count = _relay_bytes_avail(rchan, read_offset);
+
+	rchan_put(rchan);
+
+	return avail_count;
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
+ *	continuous or 'flight recorder' fashion, this function can be ignored.
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
+	rchan->bufs_consumed += bufs_consumed;
+
+	if (using_lockless(rchan) && rchan->bufs_consumed > rchan->bufs_produced)
+		rchan->bufs_consumed = rchan->bufs_produced;
+
+	rchan_put(rchan);
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
+ *	continuous or 'flight recorder' fashion, this function can be ignored.
+ *
+ *	For packet clients, it makes more sense to update after each read
+ *	rather than after each complete sub-buffer read.  The bytes_consumed
+ *	count updates bufs_consumed when a buffer has been consumed so this
+ *	count remains consistent.
+ */
+void
+relay_bytes_consumed(int rchan_id, u32 bytes_consumed, u32 read_offset)
+{
+	struct rchan *rchan;
+	u32 consuming_idx;
+	u32 unused;
+
+	rchan = rchan_get(rchan_id);
+	if (rchan == NULL)
+		return;
+
+	if (using_lockless(rchan))
+		consuming_idx = read_offset / rchan->buf_size;
+	else
+		consuming_idx = rchan->bufs_consumed % rchan->n_bufs;
+
+	if (consuming_idx >= rchan->n_bufs)
+		consuming_idx = rchan->n_bufs - 1;
+
+	rchan->bytes_consumed += bytes_consumed;
+	
+	unused = rchan->unused_bytes[consuming_idx];
+	
+	if (rchan->bytes_consumed + unused >= rchan->buf_size) {
+		relay_buffers_consumed(rchan_id, 1);
+
+		if (using_lockless(rchan))
+			rchan->bytes_consumed = 0;
+		else
+			rchan->bytes_consumed = rchan->bytes_consumed +
+				unused - rchan->buf_size;
+	}
+
+	rchan_put(rchan);
+}
+
+/**
+ *	relay_resume - resume a suspended channel
+ *	@rchan_id: relay channel id
+ *	
+ *	A channel that had a 'buffers full' condition detected for it, and
+ *	was told to 'suspend' via a non-zero buffers_full callback return 
+ *	value can again be written to following this call.
+ */
+void 
+relay_resume(int rchan_id)
+{
+	struct rchan *rchan;
+
+	rchan = rchan_get(rchan_id);
+	if (rchan == NULL)
+		return;
+
+	rchan->relay_ops->resume(rchan);
+
+	rchan_put(rchan);
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
+	rchan_info->events_lost = rchan->events_lost;
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
+EXPORT_SYMBOL(relay_open);
+EXPORT_SYMBOL(relay_close);
+EXPORT_SYMBOL(relay_reserve);
+EXPORT_SYMBOL(relay_commit);
+EXPORT_SYMBOL(relay_read);
+EXPORT_SYMBOL(relay_read_last);
+EXPORT_SYMBOL(relay_write);
+EXPORT_SYMBOL(relay_buffers_consumed);
+EXPORT_SYMBOL(relay_bytes_consumed);
+EXPORT_SYMBOL(relay_resume);
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

