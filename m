Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbVANDLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbVANDLA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 22:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbVANDLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 22:11:00 -0500
Received: from opersys.com ([64.40.108.71]:54031 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261873AbVANC5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 21:57:03 -0500
Message-ID: <41E736C1.5060104@opersys.com>
Date: Thu, 13 Jan 2005 22:04:33 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: [PATCH 3/4] relayfs for 2.6.10: locking/lockless implementation
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The implementation of the actual locking/lockless mechanisms.

Signed-off-by: Karim Yaghmour (karim@opersys.com)

Karim

--- linux-2.6.10/fs/relayfs/relay_locking.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.10-relayfs/fs/relayfs/relay_locking.c	2005-01-13 10:40:25.000000000 -0800
@@ -0,0 +1,322 @@
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
+#include "resize.h"
+
+/**
+ *	switch_buffers - switches between read and write buffers.
+ *	@cur_time: current time.
+ *	@cur_tsc: the TSC associated with current_time, if applicable
+ *	@rchan: the channel
+ *	@finalizing: if true, don't start a new buffer
+ *	@resetting: if true,
+ *
+ *	This should be called from with interrupts disabled.
+ */
+static void
+switch_buffers(struct timeval cur_time,
+	       u32 cur_tsc,
+	       struct rchan *rchan,
+	       int finalizing,
+	       int resetting,
+	       int finalize_buffer_only)
+{
+	char *chan_buf_end;
+	int bytes_written;
+
+	if (!rchan->half_switch) {
+		bytes_written = rchan->callbacks->buffer_end(rchan->id,
+			     cur_write_pos(rchan), write_buf_end(rchan),
+			     cur_time, cur_tsc, using_tsc(rchan));
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
+	write_limit(rchan) = write_buf_end(rchan) - rchan->end_reserve;
+	cur_write_pos(rchan) = write_buf(rchan);
+
+	rchan->buf_start_time = cur_time;
+	rchan->buf_start_tsc = cur_tsc;
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
+		bytes_written = rchan->callbacks->buffer_start(rchan->id, cur_write_pos(rchan), rchan->buf_id, cur_time, cur_tsc, using_tsc(rchan));
+		cur_write_pos(rchan) += bytes_written;
+	}
+}
+
+/**
+ *	locking_reserve - reserve a slot in the buffer for an event.
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
+				get_timestamp(ts, tsc, rchan);
+				switch_buffers(*ts, *tsc, rchan, 0, 0, 1);
+				recalc_time_delta(ts, tsc, rchan);
+				rchan->half_switch = 1;
+
+				cur_write_pos(rchan) = write_buf_end(rchan) - 1;
+				*err = RELAY_BUFFER_SWITCH | RELAY_WRITE_DISCARD;
+				return NULL;
+			}
+		}
+
+		get_timestamp(ts, tsc, rchan);
+		switch_buffers(*ts, *tsc, rchan, 0, 0, 0);
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
+		if (bulk_delivery(rchan)) {
+			u32 cur_idx = cur_write_pos(rchan) - rchan->buf;
+			u32 cur_bufno = cur_idx / rchan->buf_size;
+			from = rchan->buf + cur_bufno * rchan->buf_size;
+			len = cur_idx - cur_bufno * rchan->buf_size;
+		}
+		rchan->callbacks->deliver(rchan->id, from, len);
+		expand_check(rchan);
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
+	switch_buffers(time, tsc, rchan, 1, 0, 0);
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
+/**
+ *	locking_reset_index - atomically set channel index to the beginning
+ *	@rchan: the channel
+ *
+ *	If this fails, it means that something else just logged something
+ *	and therefore we probably no longer want to do this.  It's up to the
+ *	caller anyway...
+ *
+ *	Returns 0 if the index was successfully set, negative otherwise
+ */
+int
+locking_reset_index(struct rchan *rchan, u32 old_idx)
+{
+	unsigned long flags;
+	struct timeval time;
+	u32 tsc;
+	u32 cur_idx;
+	
+	relay_lock_channel(rchan, flags);
+	cur_idx = locking_get_offset(rchan, NULL);
+	if (cur_idx != old_idx) {
+		relay_unlock_channel(rchan, flags);
+		return -1;
+	}
+
+	get_timestamp(&time, &tsc, rchan);
+	switch_buffers(time, tsc, rchan, 0, 1, 0);
+
+	relay_unlock_channel(rchan, flags);
+
+	return 0;
+}
+
+
+
+
+
+
+
--- linux-2.6.10/fs/relayfs/relay_locking.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.10-relayfs/fs/relayfs/relay_locking.h	2005-01-13 10:40:25.000000000 -0800
@@ -0,0 +1,34 @@
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
+locking_reset(struct rchan *rchan, int init);
+
+extern int
+locking_reset_index(struct rchan *rchan, u32 old_idx);
+
+#endif	/* _RELAY_LOCKING_H */
--- linux-2.6.10/fs/relayfs/relay_lockless.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.10-relayfs/fs/relayfs/relay_lockless.c	2005-01-13 10:40:25.000000000 -0800
@@ -0,0 +1,541 @@
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
+#include "resize.h"
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
+		u32 mask = offset_mask(rchan);
+		if (bulk_delivery(rchan)) {
+			from = rchan->buf + RELAY_BUF_OFFSET_CLEAR(idx, mask);
+			len += RELAY_BUF_OFFSET_GET(idx, mask);
+		}
+		rchan->callbacks->deliver(rchan->id, from, len);
+		expand_check(rchan);
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
+
+/**
+ *	finalize_buffer - utility function consolidating end-of-buffer tasks.
+ *	@rchan: the channel
+ *	@end_idx: index into buffer to write the end-buffer event at
+ *	@size_lost: number of unused bytes at the end of the buffer
+ *	@time_stamp: the time of the end-buffer event
+ *	@tsc: the timestamp counter associated with time
+ *	@resetting: are we resetting the channel?
+ *
+ *	This function must be called with local irqs disabled.
+ */
+static inline void
+finalize_buffer(struct rchan *rchan,
+		u32 end_idx,
+		u32 size_lost,
+		struct timeval *time_stamp,
+		u32 *tsc,
+		int resetting)
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
+	if (bytes_written == 0)
+		rchan->unused_bytes[rchan->buf_idx % rchan->n_bufs] = size_lost;
+	
+        bufno = RELAY_BUFNO_GET(end_idx, offset_bits(rchan));
+        atomic_add_volatile(&fill_count(rchan, bufno), size_lost);
+	if (resetting) {
+		rchan->bufs_produced = rchan->bufs_produced + rchan->n_bufs;
+		rchan->bufs_produced -= rchan->bufs_produced % rchan->n_bufs;
+		rchan->bufs_consumed = rchan->bufs_produced;
+		rchan->bytes_consumed = 0;
+		update_readers_consumed(rchan, rchan->bufs_consumed, rchan->bytes_consumed);
+	} else
+		rchan->bufs_produced++;
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
+	finalize_buffer(rchan, idx(rchan) & idx_mask(rchan), size_lost,
+			&time, &tsc, 0);
+	local_irq_restore(flags);
+}
+
+/**
+ *	discard_check: - determine whether a write should be discarded
+ *	@rchan: the channel
+ *	@old_idx: index into buffer where check for space should begin
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
+	if (atomic_read(&rchan->suspended) == 1) {
+		local_irq_restore(flags);
+		return RELAY_WRITE_DISCARD;
+	}
+	if (rchan->half_switch) {
+		local_irq_restore(flags);
+		return RELAY_WRITE_DISCARD_NONE;
+	}
+	buffers_ready = rchan->bufs_produced - rchan->bufs_consumed;
+	if (buffers_ready == rchan->n_bufs - 1) {
+		atomic_set(&rchan->suspended, 1);
+		size_lost = RELAY_BUF_SIZE(offset_bits)
+			- RELAY_BUF_OFFSET_GET(old_idx, offset_mask);
+		finalize_buffer(rchan, old_idx & idx_mask, size_lost,
+				time_stamp, tsc, 0);
+		rchan->half_switch = 1;
+		idx(rchan) = RELAY_BUF_OFFSET_CLEAR((old_idx & idx_mask), offset_mask(rchan)) + RELAY_BUF_SIZE(offset_bits) - 1;
+		local_irq_restore(flags);
+
+		return RELAY_BUFFER_SWITCH | RELAY_WRITE_DISCARD;
+	}
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
+ *	@resetting: are we resetting the channel?
+ */
+static inline void
+switch_buffers(struct rchan *rchan,
+	       u32 slot_len,
+	       u32 offset,
+	       struct timeval *ts,
+	       u32 *tsc,
+	       u32 new_idx,
+	       u32 old_idx,
+	       int resetting)
+{
+	u32 size_lost = rchan->end_reserve;
+	unsigned long int flags;
+	u32 idx_mask = idx_mask(rchan);
+	u8 offset_bits = offset_bits(rchan);
+	char *cur_write_pos;
+	u32 new_buf_no;
+	u32 start_reserve = rchan->start_reserve;
+	
+	if (resetting)
+		size_lost = RELAY_BUF_SIZE(offset_bits(rchan)) - old_idx % rchan->buf_size;
+
+	if (offset > 0)
+		size_lost += slot_len - offset;
+	else
+		old_idx += slot_len;
+
+	local_irq_save(flags);
+	if (!rchan->half_switch)
+		finalize_buffer(rchan, old_idx & idx_mask, size_lost,
+				ts, tsc, resetting);
+	rchan->half_switch = 0;
+	rchan->buf_start_time = *ts;
+	rchan->buf_start_tsc = *tsc;
+	local_irq_restore(flags);
+
+	cur_write_pos = rchan->buf + RELAY_BUF_OFFSET_CLEAR((new_idx
+					     & idx_mask), offset_mask(rchan));
+	if (resetting)
+		rchan->buf_idx = 0;
+	else
+		rchan->buf_idx++;
+	rchan->buf_id++;
+	
+	rchan->unused_bytes[rchan->buf_idx % rchan->n_bufs] = 0;
+
+	rchan->callbacks->buffer_start(rchan->id, cur_write_pos,
+			       rchan->buf_id, *ts, *tsc, using_tsc(rchan));
+	new_buf_no = RELAY_BUFNO_GET(new_idx & idx_mask, offset_bits);
+	atomic_sub_volatile(&fill_count(rchan, new_buf_no),
+			    RELAY_BUF_SIZE(offset_bits) - start_reserve);
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
+			       old_idx, 0);
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
+ *	lockless_reserve - reserve a slot in the buffer for an event.
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
+		if (offset < slot_len)
+			return lockless_reserve_slow(rchan, slot_len,
+				     ts, tsc, old_idx, err);
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
+ *	lockless_get_offset - get current and max channel offsets
+ *	@rchan: the channel
+ *	@max_offset: maximum channel offset
+ *
+ *	Returns the current and maximum channel offsets.
+ */
+u32
+lockless_get_offset(struct rchan *rchan,
+			u32 *max_offset)
+{
+	if (max_offset)
+		*max_offset = rchan->buf_size * rchan->n_bufs - 1;
+
+	return rchan->initialized ? idx(rchan) & idx_mask(rchan) : 0;
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
+/**
+ *	lockless_reset_index - atomically set channel index to the beginning
+ *	@rchan: the channel
+ *	@old_idx: the current index
+ *
+ *	If this fails, it means that something else just logged something
+ *	and therefore we probably no longer want to do this.  It's up to the
+ *	caller anyway...
+ *
+ *	Returns 0 if the index was successfully set, negative otherwise
+ */
+int
+lockless_reset_index(struct rchan *rchan, u32 old_idx)
+{
+	struct timeval ts;
+	u32 tsc;
+	u32 new_idx;
+
+	if (compare_and_store_volatile(&idx(rchan), old_idx, 0)) {
+		new_idx = rchan->start_reserve;
+		switch_buffers(rchan, 0, 0, &ts, &tsc, new_idx, old_idx, 1);
+		return 0;
+	} else
+		return -1;
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
--- linux-2.6.10/fs/relayfs/relay_lockless.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.10-relayfs/fs/relayfs/relay_lockless.h	2005-01-13 10:40:25.000000000 -0800
@@ -0,0 +1,34 @@
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
+lockless_reset(struct rchan *rchan, int init);
+
+extern int
+lockless_reset_index(struct rchan *rchan, u32 old_idx);
+
+#endif/* _RELAY_LOCKLESS_H */
--- linux-2.6.10/fs/relayfs/resize.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.10-relayfs/fs/relayfs/resize.c	2005-01-13 10:40:25.000000000 -0800
@@ -0,0 +1,1105 @@
+/*
+ * RelayFS buffer management and resizing code.
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
+#include <asm/relay.h>
+#include "resize.h"
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
+ *	expand_check - check whether the channel needs expanding
+ *	@rchan: the channel
+ *
+ *	If the channel needs expanding, the needs_resize callback is
+ *	called with RELAY_RESIZE_EXPAND.
+ *
+ *	Returns the suggested number of sub-buffers for the new
+ *	buffer.
+ */
+void
+expand_check(struct rchan *rchan)
+{
+	u32 active_bufs;
+	u32 new_n_bufs = 0;
+	u32 threshold = rchan->n_bufs * RESIZE_THRESHOLD;
+
+	if (rchan->init_buf)
+		return;
+
+	if (rchan->resize_min == 0)
+		return;
+
+	if (rchan->resizing || rchan->replace_buffer)
+		return;
+	
+	active_bufs = rchan->bufs_produced - rchan->bufs_consumed + 1;
+
+	if (rchan->resize_max && active_bufs == threshold) {
+		new_n_bufs = rchan->n_bufs * 2;
+	}
+
+	if (new_n_bufs && (new_n_bufs * rchan->buf_size <= rchan->resize_max))
+		rchan->callbacks->needs_resize(rchan->id,
+					       RELAY_RESIZE_EXPAND,
+					       rchan->buf_size,
+					       new_n_bufs);
+}
+
+/**
+ *	can_shrink - check whether the channel can shrink
+ *	@rchan: the channel
+ *	@cur_idx: the current channel index
+ *
+ *	Returns the suggested number of sub-buffers for the new
+ *	buffer, 0 if the buffer is not shrinkable.
+ */
+static inline u32
+can_shrink(struct rchan *rchan, u32 cur_idx)
+{
+	u32 active_bufs = rchan->bufs_produced - rchan->bufs_consumed + 1;
+	u32 new_n_bufs = 0;
+	u32 cur_bufno_bytes = cur_idx % rchan->buf_size;
+
+	if (rchan->resize_min == 0 ||
+	    rchan->resize_min >= rchan->n_bufs * rchan->buf_size)
+		goto out;
+	
+	if (active_bufs > 1)
+		goto out;
+
+	if (cur_bufno_bytes != rchan->bytes_consumed)
+		goto out;
+	
+	new_n_bufs = rchan->resize_min / rchan->buf_size;
+out:
+	return new_n_bufs;
+}
+
+/**
+ *	shrink_check: - timer function checking whether the channel can shrink
+ *	@data: unused
+ *
+ *	Every SHRINK_TIMER_SECS, check whether the channel is shrinkable.
+ *	If so, we attempt to atomically reset the channel to the beginning.
+ *	The needs_resize callback is then called with RELAY_RESIZE_SHRINK.
+ *	If the reset fails, it means we really shouldn't be shrinking now
+ *	and need to wait until the next time around.
+ */
+static void
+shrink_check(unsigned long data)
+{
+	struct rchan *rchan = (struct rchan *)data;
+	u32 shrink_to_nbufs, cur_idx;
+	
+	del_timer(&rchan->shrink_timer);
+	rchan->shrink_timer.expires = jiffies + SHRINK_TIMER_SECS * HZ;
+	add_timer(&rchan->shrink_timer);
+
+	if (rchan->init_buf)
+		return;
+
+	if (rchan->resizing || rchan->replace_buffer)
+		return;
+
+	if (using_lockless(rchan))
+		cur_idx = idx(rchan);
+	else
+		cur_idx = relay_get_offset(rchan, NULL);
+
+	shrink_to_nbufs = can_shrink(rchan, cur_idx);
+	if (shrink_to_nbufs != 0 && reset_index(rchan, cur_idx) == 0) {
+		update_readers_consumed(rchan, rchan->bufs_consumed, 0);
+		rchan->callbacks->needs_resize(rchan->id,
+					       RELAY_RESIZE_SHRINK,
+					       rchan->buf_size,
+					       shrink_to_nbufs);
+	}
+}
+
+/**
+ *	init_shrink_timer: - Start timer used to check shrinkability.
+ *	@rchan: the channel
+ */
+void
+init_shrink_timer(struct rchan *rchan)
+{
+	if (rchan->resize_min) {
+		init_timer(&rchan->shrink_timer);
+		rchan->shrink_timer.function = shrink_check;
+		rchan->shrink_timer.data = (unsigned long)rchan;
+		rchan->shrink_timer.expires = jiffies + SHRINK_TIMER_SECS * HZ;
+		add_timer(&rchan->shrink_timer);
+	}
+}
+
+
+/**
+ *	alloc_new_pages - allocate new pages for expanding buffer
+ *	@rchan: the channel
+ *
+ *	Returns 0 on success, negative otherwise.
+ */
+static int
+alloc_new_pages(struct rchan *rchan)
+{
+	int new_pages_size, err;
+
+	if (unlikely(rchan->expand_page_array))	BUG();
+
+	new_pages_size = rchan->resize_alloc_size - rchan->alloc_size;
+	rchan->expand_page_array = alloc_page_array(new_pages_size,
+					    &rchan->expand_page_count, &err);
+	if (rchan->expand_page_array == NULL) {
+		rchan->resize_err = -ENOMEM;
+		return -ENOMEM;
+	}
+	
+	err = populate_page_array(rchan->expand_page_array,
+				  rchan->expand_page_count);
+	if (err) {
+		rchan->resize_err = -ENOMEM;
+		free_page_array(rchan->expand_page_array);
+		rchan->expand_page_array = NULL;
+	}
+
+	return err;
+}
+
+/**
+ *	clear_resize_offset - helper function for buffer resizing
+ *	@rchan: the channel
+ *
+ *	Clear the saved offset change.
+ */
+static inline void
+clear_resize_offset(struct rchan *rchan)
+{
+	rchan->resize_offset.ge = 0UL;
+	rchan->resize_offset.le = 0UL;
+	rchan->resize_offset.delta = 0;
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
+	rchan->resize_offset.ge = ge;
+	rchan->resize_offset.le = le;
+	rchan->resize_offset.delta = delta;
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
+update_file_offset(struct rchan_reader *reader)
+{
+	int applied = 0;
+	struct rchan *rchan = reader->rchan;
+	u32 f_pos;
+	int delta = reader->rchan->resize_offset.delta;
+
+	if (reader->vfs_reader)
+		f_pos = (u32)reader->pos.file->f_pos;
+	else
+		f_pos = reader->pos.f_pos;
+
+	if (f_pos == relay_get_offset(rchan, NULL))
+		return 0;
+
+	if ((f_pos >= rchan->resize_offset.ge - 1) &&
+	    (f_pos <= rchan->resize_offset.le)) {
+		if (reader->vfs_reader) {
+			if (reader->rchan->read_start == f_pos)
+				if (!(rchan->flags & RELAY_MODE_START_AT_ZERO))
+					reader->rchan->read_start += delta;
+			reader->pos.file->f_pos += delta;
+		} else
+			reader->pos.f_pos += delta;
+		applied = 1;
+	}
+
+	return applied;
+}
+
+/**
+ *	update_file_offsets - apply offset change to readers
+ *	@rchan: the channel
+ *
+ *	Apply the saved offset deltas to all files open on the channel.
+ */
+static inline void
+update_file_offsets(struct rchan *rchan)
+{
+	struct list_head *p;
+	struct rchan_reader *reader;
+	
+	read_lock(&rchan->open_readers_lock);
+	list_for_each(p, &rchan->open_readers) {
+		reader = list_entry(p, struct rchan_reader, list);
+		if (update_file_offset(reader))
+			reader->offset_changed = 1;
+	}
+	read_unlock(&rchan->open_readers_lock);
+}
+
+/**
+ *	setup_expand_buf - setup expand buffer for replacement
+ *	@rchan: the channel
+ *	@newsize: the size of the new buffer
+ *	@oldsize: the size of the old buffer
+ *	@old_n_bufs: the number of sub-buffers in the old buffer
+ *
+ *	Inserts new pages into the old buffer to create a larger
+ *	new channel buffer, splitting them at old_cur_idx, the bottom
+ *	half of the old buffer going to the bottom of the new, likewise
+ *	for the top half.
+ */
+static void
+setup_expand_buf(struct rchan *rchan, int newsize, int oldsize, u32 old_n_bufs)
+{
+	u32 cur_idx;
+	int cur_bufno, delta, i, j;
+	u32 ge, le;
+	int cur_pageno;
+	u32 free_bufs, free_pages;
+	u32 free_pages_in_cur_buf;
+	u32 free_bufs_to_end;
+	u32 cur_pages = rchan->alloc_size >> PAGE_SHIFT;
+	u32 pages_per_buf = cur_pages / rchan->n_bufs;
+	u32 bufs_ready = rchan->bufs_produced - rchan->bufs_consumed;
+
+	if (!rchan->resize_page_array || !rchan->expand_page_array ||
+	    !rchan->buf_page_array)
+		return;
+
+	if (bufs_ready >= rchan->n_bufs) {
+		bufs_ready = rchan->n_bufs;
+		free_bufs = 0;
+	} else
+		free_bufs = rchan->n_bufs - bufs_ready - 1;
+
+	cur_idx = relay_get_offset(rchan, NULL);
+	cur_pageno = cur_idx / PAGE_SIZE;
+	cur_bufno = cur_idx / rchan->buf_size;
+
+	free_pages_in_cur_buf = (pages_per_buf - 1) - (cur_pageno % pages_per_buf);
+	free_pages = free_bufs * pages_per_buf + free_pages_in_cur_buf;
+	free_bufs_to_end = (rchan->n_bufs - 1) - cur_bufno;
+	if (free_bufs >= free_bufs_to_end) {
+		free_pages = free_bufs_to_end * pages_per_buf + free_pages_in_cur_buf;
+		free_bufs = free_bufs_to_end;
+	}
+		
+	for (i = 0, j = 0; i <= cur_pageno + free_pages; i++, j++)
+		rchan->resize_page_array[j] = rchan->buf_page_array[i];
+	for (i = 0; i < rchan->expand_page_count; i++, j++)
+		rchan->resize_page_array[j] = rchan->expand_page_array[i];
+	for (i = cur_pageno + free_pages + 1; i < rchan->buf_page_count; i++, j++)
+		rchan->resize_page_array[j] = rchan->buf_page_array[i];
+
+	delta = newsize - oldsize;
+	ge = (cur_pageno + 1 + free_pages) * PAGE_SIZE;
+	le = oldsize;
+	save_resize_offset(rchan, ge, le, delta);
+
+	rchan->expand_buf_id = rchan->buf_id + 1 + free_bufs;
+}
+
+/**
+ *	setup_shrink_buf - setup shrink buffer for replacement
+ *	@rchan: the channel
+ *
+ *	Removes pages from the old buffer to create a smaller
+ *	new channel buffer.
+ */
+static void
+setup_shrink_buf(struct rchan *rchan)
+{
+	int i;
+	int copy_end_page;
+
+	if (!rchan->resize_page_array || !rchan->shrink_page_array ||
+	    !rchan->buf_page_array)
+		return;
+	
+	copy_end_page = rchan->resize_alloc_size / PAGE_SIZE;
+
+	for (i = 0; i < copy_end_page; i++)
+		rchan->resize_page_array[i] = rchan->buf_page_array[i];
+}
+
+/**
+ *	cleanup_failed_alloc - relaybuf_alloc helper
+ */
+static void
+cleanup_failed_alloc(struct rchan *rchan)
+{
+	if (rchan->expand_page_array) {
+		depopulate_page_array(rchan->expand_page_array,
+				      rchan->expand_page_count);
+		free_page_array(rchan->expand_page_array);
+		rchan->expand_page_array = NULL;
+		rchan->expand_page_count = 0;
+	} else if (rchan->shrink_page_array) {
+		free_page_array(rchan->shrink_page_array);
+		rchan->shrink_page_array = NULL;
+		rchan->shrink_page_count = 0;
+	}
+
+	if (rchan->resize_page_array) {
+		free_page_array(rchan->resize_page_array);
+		rchan->resize_page_array = NULL;
+		rchan->resize_page_count = 0;
+	}
+}
+
+/**
+ *	relaybuf_alloc - allocate a new resized channel buffer
+ *	@private: pointer to the channel struct
+ *
+ *	Internal - manages the allocation and remapping of new channel
+ *	buffers.
+ */
+static void
+relaybuf_alloc(void *private)
+{
+	struct rchan *rchan = (struct rchan *)private;
+	int i, j, err;
+	u32 old_cur_idx;
+	int free_size;
+	int free_start_page, free_end_page;
+	u32 newsize, oldsize;
+
+	if (rchan->resize_alloc_size > rchan->alloc_size) {
+		err = alloc_new_pages(rchan);
+		if (err) goto cleanup;
+	} else {
+		free_size = rchan->alloc_size - rchan->resize_alloc_size;
+		BUG_ON(free_size <= 0);
+		rchan->shrink_page_array = alloc_page_array(free_size,
+					    &rchan->shrink_page_count, &err);
+		if (rchan->shrink_page_array == NULL)
+			goto cleanup;
+		free_start_page = rchan->resize_alloc_size / PAGE_SIZE;
+		free_end_page = rchan->alloc_size / PAGE_SIZE;
+		for (i = 0, j = free_start_page; j < free_end_page; i++, j++)
+			rchan->shrink_page_array[i] = rchan->buf_page_array[j];
+	}
+
+	rchan->resize_page_array = alloc_page_array(rchan->resize_alloc_size,
+					    &rchan->resize_page_count, &err);
+	if (rchan->resize_page_array == NULL)
+		goto cleanup;
+
+	old_cur_idx = relay_get_offset(rchan, NULL);
+	clear_resize_offset(rchan);
+	newsize = rchan->resize_alloc_size;
+	oldsize = rchan->alloc_size;
+	if (newsize > oldsize)
+		setup_expand_buf(rchan, newsize, oldsize, rchan->n_bufs);
+	else
+		setup_shrink_buf(rchan);
+
+	rchan->resize_buf = vmap(rchan->resize_page_array, rchan->resize_page_count, GFP_KERNEL, PAGE_KERNEL);
+
+	if (rchan->resize_buf == NULL)
+		goto cleanup;
+
+	rchan->replace_buffer = 1;
+	rchan->resizing = 0;
+
+	rchan->callbacks->needs_resize(rchan->id, RELAY_RESIZE_REPLACE, 0, 0);
+	return;
+
+cleanup:
+	cleanup_failed_alloc(rchan);
+	rchan->resize_err = -ENOMEM;
+	return;
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
+ *	calc_order - determine the power-of-2 order of a resize
+ *	@high: the larger size
+ *	@low: the smaller size
+ *
+ *	Returns order
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
+		rchan->resize_order = calc_order(nbufs, rchan->n_bufs);
+		if (!rchan->resize_order) {
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
+		rchan->resize_order = -calc_order(rchan->n_bufs, nbufs);
+		if (!rchan->resize_order) {
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
+ *	@new_nbufs: the new number of sub-buffers
+ *	@async: do the allocation using a work queue
+ *
+ *	Internal - see relay_realloc_buffer() for details.
+ */
+static int
+__relay_realloc_buffer(struct rchan *rchan, u32 new_nbufs, int async)
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
+	if (rchan->init_buf) {
+		err = -EPERM;
+		goto out;
+	}
+
+	if (rchan->replace_buffer) {
+		err = -EBUSY;
+		goto out;
+	}
+
+	if (rchan->resizing) {
+		err = -EBUSY;
+		goto out;
+	} else
+		rchan->resizing = 1;
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
+	if (async) {
+		INIT_WORK(&rchan->work, relaybuf_alloc, rchan);
+		schedule_delayed_work(&rchan->work, 1);
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
+ *	Allocates a new channel buffer using the specified sub-buffer size
+ *	and count.  If async is non-zero, the allocation is done in the
+ *	background using a work queue.  When the allocation has completed,
+ *	the needs_resize() callback is called with a resize_type of
+ *	RELAY_RESIZE_REPLACE.  This function doesn't replace the old buffer
+ *	with the new - see relay_replace_buffer().  See
+ *	Documentation/filesystems/relayfs.txt for more details.
+ *
+ *	Returns 0 on success, or errcode if the channel is busy or if
+ *	the allocation couldn't happen for some reason.
+ */
+int
+relay_realloc_buffer(int rchan_id, u32 new_nbufs, int async)
+{
+	int err;
+	
+	struct rchan *rchan;
+
+	rchan = rchan_get(rchan_id);
+	if (rchan == NULL)
+		return -EBADF;
+
+	err = __relay_realloc_buffer(rchan, new_nbufs, async);
+	
+	rchan_put(rchan);
+
+	return err;
+}
+
+/**
+ *	expand_cancel_check - check whether the current expand needs canceling
+ *	@rchan: the channel
+ *
+ *	Returns 1 if the expand should be canceled, 0 otherwise.
+ */
+static int
+expand_cancel_check(struct rchan *rchan)
+{
+	if (rchan->buf_id >= rchan->expand_buf_id)
+		return 1;
+	else
+		return 0;
+}
+
+/**
+ *	shrink_cancel_check - check whether the current shrink needs canceling
+ *	@rchan: the channel
+ *
+ *	Returns 1 if the shrink should be canceled, 0 otherwise.
+ */
+static int
+shrink_cancel_check(struct rchan *rchan, u32 newsize)
+{
+	u32 active_bufs = rchan->bufs_produced - rchan->bufs_consumed + 1;
+	u32 cur_idx = relay_get_offset(rchan, NULL);
+
+	if (cur_idx >= newsize)
+		return 1;
+
+	if (active_bufs > 1)
+		return 1;
+
+	return 0;
+}
+
+/**
+ *	switch_rchan_buf - do_replace_buffer helper
+ */
+static void
+switch_rchan_buf(struct rchan *rchan,
+		 int newsize,
+		 int oldsize,
+		 u32 old_nbufs,
+		 u32 cur_idx)
+{
+	u32 newbufs, cur_bufno;
+	int i;
+
+	cur_bufno = cur_idx / rchan->buf_size;
+
+	rchan->buf = rchan->resize_buf;
+	rchan->alloc_size = rchan->resize_alloc_size;
+	rchan->n_bufs = rchan->resize_n_bufs;
+
+	if (newsize > oldsize) {
+		u32 ge = rchan->resize_offset.ge;
+		u32 moved_buf = ge / rchan->buf_size;
+
+		newbufs = (newsize - oldsize) / rchan->buf_size;
+		for (i = moved_buf; i < old_nbufs; i++) {
+			if (using_lockless(rchan))
+				atomic_set(&fill_count(rchan, i + newbufs),
+					   atomic_read(&fill_count(rchan, i)));
+			rchan->unused_bytes[i + newbufs] = rchan->unused_bytes[i];
+ 		}
+		for (i = moved_buf; i < moved_buf + newbufs; i++) {
+			if (using_lockless(rchan))
+				atomic_set(&fill_count(rchan, i),
+					   (int)RELAY_BUF_SIZE(offset_bits(rchan)));
+			rchan->unused_bytes[i] = 0;
+		}
+	}
+
+	rchan->buf_idx = cur_bufno;
+
+	if (!using_lockless(rchan)) {
+		cur_write_pos(rchan) = rchan->buf + cur_idx;
+		write_buf(rchan) = rchan->buf + cur_bufno * rchan->buf_size;
+		write_buf_end(rchan) = write_buf(rchan) + rchan->buf_size;
+		write_limit(rchan) = write_buf_end(rchan) - rchan->end_reserve;
+	} else {
+		idx(rchan) &= idx_mask(rchan);
+		bufno_bits(rchan) += rchan->resize_order;
+		idx_mask(rchan) =
+			(1UL << (bufno_bits(rchan) + offset_bits(rchan))) - 1;
+	}
+}
+
+/**
+ *	do_replace_buffer - does the work of channel buffer replacement
+ *	@rchan: the channel
+ *	@newsize: new channel buffer size
+ *	@oldsize: old channel buffer size
+ *	@old_n_bufs: old channel sub-buffer count
+ *
+ *	Returns 0 if replacement happened, 1 if canceled
+ *
+ *	Does the work of switching buffers and fixing everything up
+ *	so the channel can continue with a new size.
+ */
+static int
+do_replace_buffer(struct rchan *rchan,
+		  int newsize,
+		  int oldsize,
+		  u32 old_nbufs)
+{
+	u32 cur_idx;
+	int err = 0;
+	int canceled;
+
+	cur_idx = relay_get_offset(rchan, NULL);
+
+	if (newsize > oldsize)
+		canceled = expand_cancel_check(rchan);
+	else
+		canceled = shrink_cancel_check(rchan, newsize);
+
+	if (canceled) {
+		err = -EAGAIN;
+		goto out;
+	}
+
+	switch_rchan_buf(rchan, newsize, oldsize, old_nbufs, cur_idx);
+
+	if (rchan->resize_offset.delta)
+		update_file_offsets(rchan);
+
+	atomic_set(&rchan->suspended, 0);
+
+	rchan->old_buf_page_array = rchan->buf_page_array;
+	rchan->buf_page_array = rchan->resize_page_array;
+	rchan->buf_page_count = rchan->resize_page_count;
+	rchan->resize_page_array = NULL;
+	rchan->resize_page_count = 0;
+	rchan->resize_buf = NULL;
+	rchan->resize_buf_size = 0;
+	rchan->resize_alloc_size = 0;
+	rchan->resize_n_bufs = 0;
+	rchan->resize_err = 0;
+	rchan->resize_order = 0;
+out:
+	rchan->callbacks->needs_resize(rchan->id,
+				       RELAY_RESIZE_REPLACED,
+				       rchan->buf_size,
+				       rchan->n_bufs);
+	return err;
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
+
+/**
+ *	free_replaced_buffer - free a channel's old buffer
+ *	@rchan: the channel
+ *	@oldbuf: the old buffer
+ *	@oldsize: old buffer size
+ *
+ *	Frees a channel buffer via work queue.
+ */
+static int
+free_replaced_buffer(struct rchan *rchan, char *oldbuf, int oldsize)
+{
+	struct free_rchan_buf *free_buf;
+
+	free_buf = kmalloc(sizeof(struct free_rchan_buf), GFP_ATOMIC);
+	if (!free_buf)
+		return -ENOMEM;
+	memset(free_buf, 0, sizeof(struct free_rchan_buf));
+
+	free_buf->unmap_buf = oldbuf;
+	add_free_page_array(free_buf, rchan->old_buf_page_array, 0);
+	rchan->old_buf_page_array = NULL;
+	add_free_page_array(free_buf, rchan->expand_page_array, 0);
+	add_free_page_array(free_buf, rchan->shrink_page_array, rchan->shrink_page_count);
+
+	rchan->expand_page_array = NULL;
+	rchan->expand_page_count = 0;
+	rchan->shrink_page_array = NULL;
+	rchan->shrink_page_count = 0;
+
+	INIT_WORK(&free_buf->work, relaybuf_free, free_buf);
+	schedule_delayed_work(&free_buf->work, 1);
+
+	return 0;
+}
+
+/**
+ *	free_canceled_resize - free buffers allocated for a canceled resize
+ *	@rchan: the channel
+ *
+ *	Frees canceled buffers via work queue.
+ */
+static int
+free_canceled_resize(struct rchan *rchan)
+{
+	struct free_rchan_buf *free_buf;
+
+	free_buf = kmalloc(sizeof(struct free_rchan_buf), GFP_ATOMIC);
+	if (!free_buf)
+		return -ENOMEM;
+	memset(free_buf, 0, sizeof(struct free_rchan_buf));
+
+	if (rchan->resize_alloc_size > rchan->alloc_size)
+		add_free_page_array(free_buf, rchan->expand_page_array, rchan->expand_page_count);
+	else
+		add_free_page_array(free_buf, rchan->shrink_page_array, 0);
+	
+	add_free_page_array(free_buf, rchan->resize_page_array, 0);
+	free_buf->unmap_buf = rchan->resize_buf;
+
+	rchan->expand_page_array = NULL;
+	rchan->expand_page_count = 0;
+	rchan->shrink_page_array = NULL;
+	rchan->shrink_page_count = 0;
+	rchan->resize_page_array = NULL;
+	rchan->resize_page_count = 0;
+	rchan->resize_buf = NULL;
+
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
+ *	Internal - see relay_replace_buffer() for details.
+ *
+ *	Returns 0 if successful, negative otherwise.
+ */
+static int
+__relay_replace_buffer(struct rchan *rchan)
+{
+	int oldsize;
+	int err = 0;
+	char *oldbuf;
+	
+	if (down_trylock(&rchan->resize_sem))
+		return -EBUSY;
+
+	if (rchan->init_buf) {
+		err = -EPERM;
+		goto out;
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
+		err = -EINVAL;
+		goto out;
+	}
+
+	oldbuf = rchan->buf;
+	oldsize = rchan->alloc_size;
+
+	err = do_replace_buffer(rchan, rchan->resize_alloc_size,
+				oldsize, rchan->n_bufs);
+	if (err == 0)
+		err = free_replaced_buffer(rchan, oldbuf, oldsize);
+	else
+		err = free_canceled_resize(rchan);
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
+ *	Replaces the current channel buffer with the new buffer allocated
+ *	by relay_alloc_buffer and contained in the channel struct.  When the
+ *	replacement is complete, the needs_resize() callback is called with
+ *	RELAY_RESIZE_REPLACED.
+ *
+ *	Returns 0 on success, or errcode if the channel is busy or if
+ *	the replacement or previous allocation didn't happen for some reason.
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
+EXPORT_SYMBOL(relay_realloc_buffer);
+EXPORT_SYMBOL(relay_replace_buffer);
+
--- linux-2.6.10/fs/relayfs/resize.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.10-relayfs/fs/relayfs/resize.h	2005-01-13 10:40:25.000000000 -0800
@@ -0,0 +1,51 @@
+#ifndef _RELAY_RESIZE_H
+#define _RELAY_RESIZE_H
+
+/*
+ * If the channel usage has been below the low water mark for more than
+ * this amount of time, we can shrink the buffer if necessary.
+ */
+#define SHRINK_TIMER_SECS	60
+
+/* This inspired by rtai/shmem */
+#define FIX_SIZE(x) (((x) - 1) & PAGE_MASK) + PAGE_SIZE
+
+/* Don't attempt resizing again after this many failures */
+#define MAX_RESIZE_FAILURES	1
+
+/* Trigger resizing if a resizable channel is this full */
+#define RESIZE_THRESHOLD	3 / 4
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
+	struct work_struct work;	/* resize de-allocation work struct */
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
+extern void
+expand_check(struct rchan *rchan);
+
+extern void
+init_shrink_timer(struct rchan *rchan);
+
+#endif/* _RELAY_RESIZE_H */

