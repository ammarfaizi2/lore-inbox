Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268256AbTGOPMo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 11:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268522AbTGOPMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 11:12:44 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:56710 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268256AbTGOPEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 11:04:09 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16148.6952.56851.689890@gargle.gargle.HOWL>
Date: Tue, 15 Jul 2003 10:18:00 -0500
To: linux-kernel@vger.kernel.org
Cc: karim@opersys.com, bob@watson.ibm.com
Subject: [RFC][PATCH 5/5] relayfs scheme-dependent code
X-Mailer: VM(ViewMail) 7.01 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN -X dontdiff linux-2.6.0-test1/fs/relayfs/relay_locking.c linux-2.6.0-test1-relayfs-printk/fs/relayfs/relay_locking.c
--- linux-2.6.0-test1/fs/relayfs/relay_locking.c	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/fs/relayfs/relay_locking.c	Sun Jul 13 22:32:49 2003
@@ -0,0 +1,632 @@
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
+
+/**
+ *	expand_check - check whether the channel needs expanding
+ *	@rchan: the channel
+ *	@active_bufs: the number of unread sub-buffers
+ *
+ *	If the channel is above 1/3 full, it will be doubled in
+ *	size.  This low threshold has to do with the fact that we
+ *	only have two buffers and they're checked during buffer
+ *	switches only.
+ *
+ *	Returns the suggested sub-buffer size for the new buffer.
+ *
+ *	NOTE: this check will only work correctly during buffer switches.
+ */
+static u32
+expand_check(struct rchan *rchan)
+{
+	u32 bytes_ready;
+	u32 bytes_consumed;
+	u32 bytes_produced;
+	u32 new_bufsize = 0;
+	u32 cur_idx = cur_write_pos(rchan) - rchan->buf;
+
+	bytes_consumed = rchan->bufs_consumed * rchan->buf_size;
+	bytes_consumed += rchan->bytes_consumed;
+	bytes_produced = rchan->bufs_produced * rchan->buf_size;
+	bytes_produced += bytes_produced(rchan) + cur_idx;
+	if (cur_idx > rchan->buf_size)
+		bytes_produced -= rchan->buf_size;
+
+	bytes_ready = bytes_produced - bytes_consumed;
+
+	if (rchan->resize_max && !rchan->mapped && bytes_ready > 
+	   (rchan->n_bufs * rchan->buf_size) * RESIZE_THRESHOLD_LOCKING)
+		new_bufsize = rchan->buf_size * 2;
+	
+	return new_bufsize;
+}
+
+/**
+ *	shrink_check - check whether the channel needs shrinking
+ *	@rchan: the channel
+ *	@active_bufs: the number of unread sub-buffers
+ *
+ *	If a minute has passed since the last resize, and it's no 
+ *	longer full, it will be shrunk to whatever size	will comfortably
+ *	fit the contents.
+ *
+ *	Returns the suggested sub-buffer size for the new buffer.
+ */
+static u32
+shrink_check(struct rchan *rchan)
+{
+	u32 needed_bufsize;
+	struct timeval ts;
+	u32 low_water_delta;
+	u32 bytes_ready;
+	u32 bytes_consumed;
+	u32 bytes_produced;
+	u32 new_bufsize = 0;
+	u32 cur_idx = cur_write_pos(rchan) - rchan->buf;
+	u32 n;
+
+	bytes_consumed = rchan->bufs_consumed * rchan->buf_size;
+	bytes_consumed += rchan->bytes_consumed;
+	bytes_produced = rchan->bufs_produced * rchan->buf_size;
+	bytes_produced += bytes_produced(rchan);
+	if (cur_idx > rchan->buf_size)
+		bytes_produced += cur_idx - rchan->buf_size;
+	else
+		bytes_produced += cur_idx;
+	
+	bytes_ready = bytes_produced - bytes_consumed;
+	
+	if (!rchan->resize_min || rchan->mapped ||
+	   rchan->resize_min >= rchan->n_bufs * rchan->buf_size)
+		goto out;
+
+	if (bytes_ready > (rchan->n_bufs * rchan->buf_size) * RESIZE_THRESHOLD_LOCKING) {
+		do_gettimeofday(&rchan->low_water_time);
+		goto out;
+	}
+	
+	do_gettimeofday(&ts);
+	low_water_delta = calc_time_delta(&ts, &rchan->low_water_time);
+	if (low_water_delta > LOW_WATER_TIME) {
+		needed_bufsize = bytes_ready;
+
+		for (n = RELAY_MIN_BUFSIZE; n < rchan->buf_size; n *= 2) {
+			if ((n * rchan->n_bufs >= rchan->resize_min) &&
+			   (n * rchan->n_bufs <= rchan->resize_max) &&
+			   (n * rchan->n_bufs * RESIZE_THRESHOLD_LOCKING > needed_bufsize))
+				break;
+		}
+
+		if (n >= rchan->buf_size)
+			goto out;
+		
+		new_bufsize = n;
+	}
+out:
+	return new_bufsize;
+}
+
+/**
+ *	switch_buffers - switches between read and write buffers.
+ *	@cur_time: current time.
+ *	@cur_tsc: the TSC associated with current_time, if applicable
+ *	@rchan: the channel
+ *	@finalizing: if true, don't start a new buffer 
+ *
+ *	This should be called from with interrupts disabled.
+ */
+static void 
+switch_buffers(struct timeval cur_time,
+	       u32 cur_tsc,
+	       struct rchan *rchan,
+	       int finalizing)
+{
+	char *temp_buf;
+	char *temp_buf_end;
+	int bytes_written;
+	u32 new_bufsize;
+	
+	bytes_written = rchan->callbacks->buffer_end(rchan->id,
+			     cur_write_pos(rchan), write_buf_end(rchan),
+			     cur_time, cur_tsc, using_tsc(rchan));
+	if (bytes_written == 0)
+		rchan->unused_bytes[rchan->buf_id % rchan->n_bufs] = 
+			write_buf_end(rchan) - cur_write_pos(rchan);
+
+	new_bufsize = expand_check(rchan);
+	if (new_bufsize)
+		rchan->callbacks->needs_resize(rchan->id,
+					       RELAY_RESIZE_EXPAND,
+					       new_bufsize,
+					       rchan->n_bufs);
+
+	
+	cur_write_pos(rchan) += bytes_written;
+	temp_buf = read_buf(rchan);
+	read_buf(rchan) = write_buf(rchan);
+	write_buf(rchan) = temp_buf;
+	temp_buf_end = read_buf_end(rchan);
+	read_buf_end(rchan) = write_buf_end(rchan);
+	write_buf_end(rchan) = temp_buf_end;
+	read_limit(rchan) = read_buf_end(rchan);
+	write_limit(rchan) = write_buf_end(rchan) - rchan->end_reserve;
+	cur_write_pos(rchan) = write_buf(rchan);
+
+	rchan->buf_start_time = cur_time;
+	rchan->buf_start_tsc = cur_tsc;
+
+	rchan->buf_id++;
+	if (!packet_delivery(rchan))
+		rchan->unused_bytes[rchan->buf_id % rchan->n_bufs] = 0;
+	rchan->bufs_produced++;
+
+	if (!finalizing) {
+		bytes_written = rchan->callbacks->buffer_start(rchan->id, cur_write_pos(rchan), rchan->buf_id, cur_time, cur_tsc, using_tsc(rchan));
+		cur_write_pos(rchan) += bytes_written;
+	}
+}
+
+/**
+ *	locking_reserve - reserve a slot in the trace buffer for an event.
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
+	int bytes_written;
+
+	*err = RELAY_BUFFER_SWITCH_NONE;
+
+	if (slot_len >= rchan->buf_size) {
+		*err = RELAY_WRITE_DISCARD | RELAY_WRITE_TOO_LONG;
+		rchan->events_lost++;
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
+			*err = RELAY_WRITE_DISCARD;
+			rchan->events_lost++;
+			return NULL;
+		}
+
+		if (rchan->bufs_produced - rchan->bufs_consumed > 0) {
+			if (rchan->callbacks->buffers_full(rchan->id)) {
+				atomic_set(&rchan->suspended, 1);
+				*err = RELAY_WRITE_DISCARD;
+				rchan->events_lost++;
+				return NULL;
+			}
+		}
+
+		get_timestamp(ts, tsc, rchan);
+		switch_buffers(*ts, *tsc, rchan, 0);
+		recalc_time_delta(ts, tsc, rchan);
+		*err = RELAY_BUFFER_SWITCH;
+	}
+
+	return cur_write_pos(rchan);
+}
+
+/**
+ *	locking_resume - resume a suspended channel
+ *	@rchan: the channel
+ */
+inline void 
+locking_resume(struct rchan *rchan)
+{
+	atomic_set(&rchan->suspended, 0);
+}
+
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
+locking_commit(struct rchan *rchan,
+	       char *from,
+	       u32 len, 
+	       int deliver, 
+	       int interrupting)
+{
+	u32 new_bufsize;
+	
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
+		rchan->callbacks->deliver(rchan->id, from, len);
+		new_bufsize = shrink_check(rchan);
+		if (new_bufsize)
+			rchan->callbacks->needs_resize(rchan->id,
+						       RELAY_RESIZE_SHRINK,
+						       new_bufsize,
+						       rchan->n_bufs);
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
+	switch_buffers(time, tsc, rchan, 1);
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
+ *	copy_split - helper function used to copy to expanded buffer
+ *
+ *	Copies the contents of the current relay channel buffer into the
+ *	new channel buffer, splitting them at old_cur_idx, the bottom
+ *	half of the old buffer going to the bottom of the new, likewise
+ *	for the top half.
+ */
+static void
+copy_split(struct rchan *rchan, int newsize, int oldsize, char * oldbuf, u32 old_cur_idx, u32 old_buf_size)
+{
+	u32 old_cur_bufno;
+	int ge = 0, le = 0, delta;
+
+	old_cur_bufno = old_cur_idx / old_buf_size;
+
+	if (old_cur_idx >= old_buf_size) {
+		memcpy(rchan->buf, oldbuf, old_buf_size - rchan->unused_bytes[0]);
+		memcpy(rchan->buf + old_buf_size - rchan->unused_bytes[0], 
+		       oldbuf + old_buf_size, old_cur_idx - old_buf_size);
+
+		ge = old_buf_size;
+		le = old_cur_idx;
+		delta = -rchan->unused_bytes[0];
+		rchan->callbacks->resize_offset(rchan->id, ge, le, delta);
+			
+		memcpy(rchan->buf + newsize - (oldsize - old_cur_idx),
+		       oldbuf + old_cur_idx, oldsize - old_cur_idx);
+
+		ge = old_cur_idx;
+		le = oldsize - 1;
+		delta = newsize - oldsize;
+		rchan->callbacks->resize_offset(rchan->id, ge, le, delta);
+
+		cur_write_pos(rchan) = rchan->buf + old_cur_idx - rchan->unused_bytes[0];
+		rchan->unused_bytes[0] = 0;
+	} else {
+		memcpy(rchan->buf, oldbuf, old_cur_idx);
+		memcpy(rchan->buf + newsize - old_buf_size,
+		       oldbuf + old_buf_size, old_buf_size);
+
+		ge = old_buf_size;
+		le = oldsize - 1;
+		delta = newsize - oldsize;
+		rchan->callbacks->resize_offset(rchan->id, ge, le, delta);
+
+		memcpy(rchan->buf + newsize - oldsize + rchan->unused_bytes[0],
+		       oldbuf + old_cur_idx, old_buf_size - old_cur_idx);
+
+		ge = old_cur_idx;
+		le = old_buf_size - 1;
+		delta = newsize - oldsize + rchan->unused_bytes[0];
+		rchan->callbacks->resize_offset(rchan->id, ge, le, delta);
+
+		cur_write_pos(rchan) = rchan->buf + old_cur_idx;
+		rchan->unused_bytes[0] = 0;
+	}
+}
+
+/**
+ *	copy_expand - copies old buffer to larger buffer
+ *	@rchan: the channel
+ *	@newsize: the size of the new buffer
+ *	@oldsize: the size of the old buffer
+ *	@oldsize: the old buffer
+ *	@old_cur_idx: the current index into the old buffer
+ *	@old_buf_size: the old buffer's sub-buffer size
+ *
+ *	Copies the contents of the old relay channel buffer into the
+ *	new channel buffer.
+ */
+void
+copy_expand(struct rchan *rchan, int newsize, int oldsize, char * oldbuf, u32 old_cur_idx, u32 old_buf_size)
+{
+	u32 total_bytes;
+	u32 cur_idx;
+	
+	copy_split(rchan, newsize, oldsize, oldbuf, old_cur_idx, old_buf_size);
+
+	total_bytes = rchan->bufs_produced * old_buf_size +
+		bytes_produced(rchan) + old_cur_idx;
+
+	if (old_cur_idx > old_buf_size)
+		total_bytes -= old_buf_size;
+
+	cur_idx = cur_write_pos(rchan) - rchan->buf;
+	
+	if (cur_idx >= rchan->buf_size)
+		total_bytes -= (cur_idx - rchan->buf_size);
+	else
+		total_bytes -= cur_idx;
+	rchan->bufs_produced = total_bytes / rchan->buf_size;
+	bytes_produced(rchan) = total_bytes % rchan->buf_size;
+		
+	total_bytes = rchan->bufs_consumed * old_buf_size +
+		rchan->bytes_consumed;
+	rchan->bufs_consumed = total_bytes / rchan->buf_size;
+	rchan->bytes_consumed = total_bytes % rchan->buf_size;
+	
+	if (rchan->buf_id % 2)
+		rchan->buf_id++;
+}
+
+/**
+ *	copy_from_curbuf - helper function used to copy to shrunken buffer
+ *
+ *	Copies the contents of the current relay channel sub-buffer into the
+ *	new channel buffer.
+ */
+static u32
+copy_from_curbuf(struct rchan *rchan, u32 old_cur_idx, u32 old_buf_size, int newsize, char *oldbuf)
+{
+	u32 old_cur_bufno;
+	u32 copy_bytes;
+	char *copy_to;
+	char *copy_from;
+	int ge = 0, le = 0, delta;
+
+	old_cur_bufno = old_cur_idx / old_buf_size;
+	copy_bytes = old_cur_idx;
+
+	if (old_cur_idx >= old_buf_size) {
+		copy_bytes -= old_buf_size;
+		if (copy_bytes > newsize)
+			copy_bytes = newsize;
+
+		delta = -(old_buf_size - newsize) - old_cur_idx;
+	} else {
+		copy_bytes = old_cur_idx;
+		if (copy_bytes > newsize) {
+			copy_bytes = newsize;
+			delta = -(old_buf_size - (newsize + 
+					  (old_buf_size - old_cur_idx)));
+		} else
+			delta = newsize - copy_bytes;
+	}
+
+	ge = old_cur_idx - copy_bytes;
+	le = old_cur_idx;
+
+	copy_to = rchan->buf + newsize - copy_bytes;
+	copy_from = oldbuf + old_cur_idx - copy_bytes;
+		
+	memcpy(copy_to, copy_from, copy_bytes);
+	rchan->callbacks->resize_offset(rchan->id, ge, le, delta);
+
+	return copy_bytes;
+}
+
+/**
+ *	copy_from_otherbuf - helper function used to copy to shrunken buffer
+ *
+ *	Copies the contents of the non-current relay channel sub-buffer into
+ *	the new channel buffer.
+ */
+static void
+copy_from_otherbuf(struct rchan *rchan, u32 old_cur_idx, u32 old_buf_size, int oldsize, int newsize, char *copy_to, u32 copied_bytes, char *oldbuf)
+{
+	char *copy_from;
+	int ge = 0, le = 0, delta;
+	u32 copy_bytes = newsize - copied_bytes;
+
+	if (old_cur_idx >= old_buf_size) {
+		copy_from = oldbuf + old_buf_size -
+			rchan->unused_bytes[0] - copy_bytes;
+		delta = -(old_buf_size - newsize + copied_bytes -
+			  rchan->unused_bytes[0]);
+		ge = old_buf_size - copy_bytes - rchan->unused_bytes[0];
+		le = old_buf_size;
+	} else {
+		copy_from = oldbuf + oldsize -
+			rchan->unused_bytes[1] - copy_bytes;
+		delta = -(oldsize - newsize + copied_bytes -
+			  rchan->unused_bytes[1]);
+		ge = oldsize - copy_bytes - rchan->unused_bytes[1];
+		le = oldsize;
+	}
+
+	memcpy(copy_to, copy_from, copy_bytes);
+	rchan->callbacks->resize_offset(rchan->id, ge, le, delta);
+}
+
+/**
+ *	copy_shrink - copies old buffer to smaller buffer
+ *	@rchan: the channel
+ *	@newsize: the size of the new buffer
+ *	@oldsize: the size of the old buffer
+ *	@oldsize: the old buffer
+ *	@old_cur_idx: the current index into the old buffer
+ *	@old_buf_size: the old buffer's sub-buffer size
+ *
+ *	Copies the contents of the old relay channel buffer into the
+ *	new channel buffer.
+ */
+void 
+copy_shrink(struct rchan *rchan, int newsize, int oldsize, char *oldbuf, u32 old_cur_idx, u32 old_buf_size)
+{
+	u32 copy_bytes;
+	char *copy_to;
+	u32 total_bytes;
+	
+	copy_bytes = copy_from_curbuf(rchan, old_cur_idx, old_buf_size,
+				      newsize, oldbuf);
+
+	copy_to = rchan->buf + newsize - copy_bytes;
+	copy_bytes = newsize - copy_bytes;
+	if (copy_bytes) {
+		copy_to -= copy_bytes;
+		copy_from_otherbuf(rchan, old_cur_idx, old_buf_size, oldsize,
+				   newsize, copy_to, copy_bytes, oldbuf);
+	}
+		
+	cur_write_pos(rchan) = rchan->buf;
+	rchan->unused_bytes[0] = 0;
+	rchan->unused_bytes[1] = 0;
+		
+	total_bytes = rchan->bufs_produced * old_buf_size +
+		bytes_produced(rchan) + old_cur_idx;
+
+	if (old_cur_idx > old_buf_size)
+		total_bytes -= old_buf_size;
+		
+	rchan->bufs_produced = total_bytes / rchan->buf_size;
+	bytes_produced(rchan) = total_bytes % rchan->buf_size;
+	
+	total_bytes = rchan->bufs_consumed * old_buf_size +
+		rchan->bytes_consumed;
+	rchan->bufs_consumed = total_bytes / rchan->buf_size;
+	rchan->bytes_consumed = total_bytes % rchan->buf_size;
+	
+	if (rchan->buf_id % 2)
+		rchan->buf_id++;
+}
+
+/**
+ *	locking_copy_contents - relayfs copy_contents() implementation
+ *	@rchan: the channel
+ *	@newsize: the size of the new buffer
+ *	@oldsize: the size of the old buffer
+ *	@oldsize: the old buffer
+ *	@old_cur_idx: the current index into the old buffer
+ *	@old_buf_size: the old buffer's sub-buffer size
+ *	@old_n_bufs: the old buffer's sub-buffer count
+ *
+ *	Copies the contents of the old relay channel buffer into the
+ *	new channel buffer.
+ */
+void
+locking_copy_contents(struct rchan *rchan, int newsize, int oldsize, char * oldbuf, u32 old_cur_idx, u32 old_buf_size, u32 old_n_bufs)
+{
+	u32 old_cur_bufno;
+	old_cur_bufno = old_cur_idx / old_buf_size;
+
+	if (newsize > oldsize)
+		copy_expand(rchan, newsize, oldsize, oldbuf,
+			    old_cur_idx, old_buf_size);
+	else
+		copy_shrink(rchan, newsize, oldsize, oldbuf,
+			    old_cur_idx, old_buf_size);
+
+	write_buf(rchan) = rchan->buf;
+	read_buf(rchan) = rchan->buf + rchan->buf_size;
+	write_buf_end(rchan) = write_buf(rchan) + rchan->buf_size;
+	read_buf_end(rchan) = read_buf(rchan) + rchan->buf_size;
+	read_limit(rchan) = read_buf(rchan);
+	write_limit(rchan) = write_buf_end(rchan) - rchan->end_reserve;
+
+	rchan->offsets_changed = 1;
+}
+
+
+
+
+
+
+
+
diff -urpN -X dontdiff linux-2.6.0-test1/fs/relayfs/relay_locking.h linux-2.6.0-test1-relayfs-printk/fs/relayfs/relay_locking.h
--- linux-2.6.0-test1/fs/relayfs/relay_locking.h	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/fs/relayfs/relay_locking.h	Sun Jul 13 22:32:49 2003
@@ -0,0 +1,39 @@
+#ifndef _RELAY_LOCKING_H
+#define _RELAY_LOCKING_H
+
+#define RESIZE_THRESHOLD_LOCKING 1 / 3
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
+locking_copy_contents(struct rchan *rchan,
+		      int newsize,
+		      int oldsize,
+		      char * oldbuf,
+		      u32 old_cur_idx,
+		      u32 old_buf_size,
+		      u32 old_n_bufs);
+
+#endif	/* _RELAY_LOCKING_H */
diff -urpN -X dontdiff linux-2.6.0-test1/fs/relayfs/relay_lockless.c linux-2.6.0-test1-relayfs-printk/fs/relayfs/relay_lockless.c
--- linux-2.6.0-test1/fs/relayfs/relay_lockless.c	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/fs/relayfs/relay_lockless.c	Sun Jul 13 22:32:49 2003
@@ -0,0 +1,905 @@
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
+	   active_bufs == (rchan->n_bufs * RESIZE_THRESHOLD_LOCKLESS)) {
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
+	if (active_bufs > rchan->n_bufs * RESIZE_THRESHOLD_LOCKLESS) {
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
+			   (n * (rchan->buf_size * RESIZE_THRESHOLD_LOCKLESS) > needed_bufsize))
+				break;
+		}
+
+		if (n >= rchan->n_bufs || n < 4)
+			goto out;
+		
+		new_n_bufs = n;
+	}
+
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
+static void
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
+		rchan->callbacks->deliver(rchan->id, from, len);
+		resize_check(rchan);
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
+/**
+ *	finalize_buffer - utility function consolidating end-of-buffer tasks.
+ *	@end_idx: index into trace buffer to write the end-buffer event at
+ *	@size_lost: number of unused bytes at the end of the buffer
+ *	@time_stamp: the time of the end-buffer event
+ *	@tsc: the timestamp counter associated with time
+ *	@cpu_id: the CPU id associated with the event
+ *
+ *	This function must be called with local irqs disabled.
+ */
+static inline void 
+finalize_buffer(u32 end_idx,
+		u32 size_lost, 
+		struct timeval *time_stamp,
+		u32 *tsc, 
+		struct rchan *rchan)
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
+	/* We assume that since the client didn't write anything, at some
+	   point the unused_bytes value will be needed. */ 
+	if (bytes_written == 0)
+		rchan->unused_bytes[rchan->buf_id % rchan->n_bufs] = size_lost;
+	
+        bufno = RELAY_BUFNO_GET(end_idx, offset_bits(rchan));
+        atomic_add_volatile(&fill_count(rchan, bufno), size_lost);
+	rchan->bufs_produced++;
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
+	finalize_buffer(idx(rchan) & idx_mask(rchan), size_lost, 
+			&time, &tsc, rchan);
+	local_irq_restore(flags);
+}
+
+/**
+ *	discard_check: - determine whether a write should be discarded
+ *	@rchan: the channel
+ *	@old_idx: index into trace buffer where check for space should begin
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
+	if (write_len > RELAY_BUF_SIZE(offset_bits)) {
+		rchan->events_lost++;
+		return RELAY_WRITE_DISCARD | RELAY_WRITE_TOO_LONG;
+	}
+
+	local_irq_save(flags);
+
+	if (atomic_read(&rchan->suspended) == 1) {
+		local_irq_restore(flags);
+		rchan->events_lost++;	
+		return RELAY_WRITE_DISCARD;
+	}
+
+	buffers_ready = rchan->bufs_produced - rchan->bufs_consumed;
+	if (buffers_ready == rchan->n_bufs - 1) {
+		if (rchan->callbacks->buffers_full(rchan->id)) {
+			atomic_set(&rchan->suspended, 1);
+			get_timestamp(time_stamp, tsc, rchan);
+			size_lost = RELAY_BUF_SIZE(offset_bits)
+				- RELAY_BUF_OFFSET_GET(old_idx, offset_mask);
+			finalize_buffer(old_idx & idx_mask, size_lost, 
+					time_stamp, tsc, rchan);
+
+			last_event_index(rchan) = old_idx;
+			last_event_timestamp(rchan) = *time_stamp;
+			last_event_tsc(rchan) = *tsc;
+
+			local_irq_restore(flags);
+
+			rchan->events_lost++;
+
+			return RELAY_BUFFER_SWITCH | RELAY_WRITE_DISCARD;
+		}
+	}
+
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
+ */
+static inline void
+switch_buffers(struct rchan *rchan,
+	       u32 slot_len,
+	       u32 offset,
+	       struct timeval *ts,
+	       u32 *tsc,
+	       u32 new_idx,
+	       u32 old_idx)
+{
+	u32 size_lost = rchan->end_reserve;
+	unsigned long int flags;
+	u32 idx_mask = idx_mask(rchan);
+	u8 offset_bits = offset_bits(rchan);
+	char *cur_write_pos;
+	u32 new_buf_no;
+	u32 start_reserve = rchan->start_reserve;
+	
+	if (offset > 0)
+		size_lost += slot_len - offset;
+	else
+		old_idx += slot_len;
+
+	local_irq_save(flags);
+	finalize_buffer(old_idx & idx_mask, size_lost, 
+			ts, tsc, rchan);
+	rchan->buf_start_time = *ts;
+	rchan->buf_start_tsc = *tsc;
+
+	local_irq_restore(flags);
+
+	cur_write_pos = rchan->buf + RELAY_BUF_OFFSET_CLEAR((new_idx
+					     & idx_mask), offset_mask(rchan));
+
+	rchan->buf_id++;
+
+	rchan->unused_bytes[rchan->buf_id % rchan->n_bufs] = 0;
+	
+	rchan->callbacks->buffer_start(rchan->id, cur_write_pos, 
+			       rchan->buf_id, *ts, *tsc, using_tsc(rchan));
+
+	new_buf_no = RELAY_BUFNO_GET(new_idx & idx_mask, offset_bits);
+
+	atomic_sub_volatile(&fill_count(rchan, new_buf_no),
+			    RELAY_BUF_SIZE(offset_bits) - start_reserve);
+
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
+
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
+
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
+			       old_idx);
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
+ *	lockless_reserve - reserve a slot in the trace buffer for an event.
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
+
+		if (offset < slot_len)
+			return lockless_reserve_slow(rchan, slot_len, 
+				     ts, tsc, old_idx, err);
+
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
+ *	lockless_resume - resume a suspended channel
+ *	@rchan: the channel
+ */
+inline void 
+lockless_resume(struct rchan *rchan)
+{
+	int discard_size;
+	u32 last_event_buf_no;
+	u32 last_buffer_lost_size;
+	u32 last_event_offset;
+	u32 new_idx;
+	int freed_buf_no;
+	char *cur_write_pos;
+	char *write_buf_end;
+	u32 bufno;
+	u32 size_lost;
+	int bytes_written;
+	
+	freed_buf_no = rchan->bufs_produced % rchan->n_bufs;
+
+	atomic_set_volatile(&fill_count(rchan, freed_buf_no), 
+			    rchan->start_reserve);
+
+	last_event_offset = RELAY_BUF_OFFSET_GET(last_event_index(rchan), 
+						 offset_mask(rchan));
+	last_event_buf_no = RELAY_BUFNO_GET(last_event_index(rchan), 
+					    offset_bits(rchan));
+	last_buffer_lost_size = RELAY_BUF_SIZE(offset_bits(rchan)) 
+		- last_event_offset;
+
+	discard_size = atomic_read(&fill_count(rchan, last_event_buf_no))
+		- last_event_offset - last_buffer_lost_size;
+	if (discard_size > 0)
+		atomic_sub_volatile(&fill_count(rchan, last_event_buf_no), 
+				    discard_size);
+
+	cur_write_pos = rchan->buf
+		+ (last_event_index(rchan) & idx_mask(rchan));
+	
+	write_buf_end = get_buffer_end(rchan, last_event_index(rchan) - 1);
+	size_lost = write_buf_end - cur_write_pos;
+	
+	bytes_written = rchan->callbacks->buffer_end(rchan->id,
+					     cur_write_pos,
+					     write_buf_end,
+					     last_event_timestamp(rchan),
+					     last_event_tsc(rchan),
+					     using_tsc(rchan));
+	/* We assume that since the client didn't write anything, at some
+	   point the unused_bytes value will be needed. */ 
+	if (bytes_written == 0)
+		rchan->unused_bytes[rchan->buf_id % rchan->n_bufs] = size_lost;
+
+        bufno = RELAY_BUFNO_GET(last_event_index(rchan), offset_bits(rchan));
+        atomic_add_volatile(&fill_count(rchan, bufno), size_lost);
+
+	get_timestamp(&rchan->buf_start_time, &rchan->buf_start_tsc, rchan);
+
+	new_idx = idx(rchan) + RELAY_BUF_SIZE(offset_bits(rchan));
+	new_idx = RELAY_BUF_OFFSET_CLEAR(new_idx, 
+				   offset_mask(rchan)) + rchan->start_reserve;
+
+	cur_write_pos = rchan->buf
+		+ RELAY_BUF_OFFSET_CLEAR((new_idx & idx_mask(rchan)),
+					 offset_mask(rchan));
+
+	rchan->buf_id++;
+	rchan->unused_bytes[rchan->buf_id % rchan->n_bufs] = 0;
+	
+	rchan->callbacks->buffer_start(rchan->id,
+				       cur_write_pos,
+				       rchan->buf_id,
+				       rchan->buf_start_time, 
+				       rchan->buf_start_tsc,
+				       using_tsc(rchan));
+
+	bufno = RELAY_BUFNO_GET(new_idx & idx_mask(rchan), 
+				offset_bits(rchan));
+
+	atomic_sub_volatile(&fill_count(rchan, bufno),
+		    RELAY_BUF_SIZE(offset_bits(rchan)) - rchan->start_reserve);
+
+	if (atomic_read(&fill_count(rchan, bufno)) < rchan->start_reserve)
+			atomic_set_volatile(&fill_count(rchan, bufno), 
+					    rchan->start_reserve);
+
+	idx(rchan) = new_idx;
+
+	atomic_set(&rchan->suspended, 0);
+}
+
+/**
+ *	lockless_get_offset - get current and max 'file' offsets for VFS
+ *	@rchan: the channel
+ *	@max_offset: maximum channel offset
+ *
+ *	Returns the current and maximum buffer offsets in VFS terms.
+ */
+u32 
+lockless_get_offset(struct rchan *rchan,
+			u32 *max_offset)
+{
+	if (max_offset)
+		*max_offset = rchan->buf_size * rchan->n_bufs - 1;
+
+	return idx(rchan) & idx_mask(rchan);
+}
+
+/**
+ *	copy_expand - copies old buffer to larger buffer
+ *	@rchan: the channel
+ *	@newsize: the size of the new buffer
+ *	@oldsize: the size of the old buffer
+ *	@oldsize: the old buffer
+ *	@old_cur_idx: the current index into the old buffer
+ *	@old_buf_size: the old buffer's sub-buffer size
+ *
+ *	Copies the contents of the current relay channel buffer into the
+ *	new channel buffer, splitting them at old_cur_idx, the bottom
+ *	half of the old buffer going to the bottom of the new, likewise
+ *	for the top half.
+ */
+static void
+copy_expand(struct rchan *rchan, int newsize, int oldsize, char * oldbuf, u32 old_cur_idx, u32 old_buf_size, u32 old_n_bufs)
+{
+	char *copy_first, *copy_last = NULL;
+	u32 copy_first_size = 0, copy_last_size = 0;
+	u32 new_cur_idx = 0, newbufs;
+	int old_cur_bufno, new_cur_bufno, delta, i;
+	u32 ge, le;
+
+	new_cur_idx = relay_get_offset(rchan, NULL) & idx_mask(rchan);
+	old_cur_bufno = old_cur_idx / old_buf_size;
+	new_cur_bufno = new_cur_idx / rchan->buf_size;
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
+		atomic_set(&fill_count(rchan, i + newbufs), atomic_read(&fill_count(rchan, i)));
+		rchan->unused_bytes[i + newbufs] = rchan->unused_bytes[i];
+	}
+	for (i = old_cur_bufno + 1; i < old_cur_bufno + newbufs + 1; i++) {
+		atomic_set(&fill_count(rchan, i),
+			   (int)RELAY_BUF_SIZE(offset_bits(rchan)));
+		rchan->unused_bytes[i] = 0;
+	}
+
+	rchan->buf_id = new_cur_bufno;
+	
+	delta = newsize - oldsize;
+	ge = (old_cur_bufno + 1) * old_buf_size;
+	le = oldsize;
+	rchan->callbacks->resize_offset(rchan->id, ge, le, delta);
+
+	rchan->offsets_changed = 1;
+}
+
+/* Used only for buffer shrinking */
+static int tmp_unused[RELAY_MAX_BUFS];
+static atomic_t tmp_fill[RELAY_MAX_BUFS];
+
+/**
+ *	copy_to_bottom - helper function used to copy to shrunken buffer
+ *
+ *	Copies the contents of the current relay channel sub-buffer into
+ *	the bottom of the new channel buffer.
+
+ *	Returns the change in position of the new sub-buffer.
+ */
+static int
+copy_to_bottom(struct rchan *rchan, char * oldbuf, u32 old_buf_size, int old_cur_bufno, int new_cur_bufno)
+{
+	int delta;
+	u32 ge, le;
+
+	memcpy(rchan->buf + new_cur_bufno * old_buf_size,
+	       oldbuf + old_cur_bufno * old_buf_size, old_buf_size);
+	atomic_set(&fill_count(rchan, new_cur_bufno),
+		   atomic_read(&tmp_fill[old_cur_bufno]));
+	rchan->unused_bytes[new_cur_bufno] = tmp_unused[old_cur_bufno];
+
+	ge = old_cur_bufno * old_buf_size;
+	le = (old_cur_bufno + 1) * old_buf_size;
+	delta = -(old_cur_bufno * old_buf_size);
+	if (old_cur_bufno != 0) {
+		rchan->callbacks->resize_offset(rchan->id, ge, le, delta);
+		rchan->offsets_changed = 1;
+	}
+
+	return delta;
+}
+
+/**
+ *	copy_rest - helper function used to copy to shrunken buffer
+ *
+ *	Copies the the contents of the rest of the relay channel sub-buffers
+ *	not already copied, into the remainder of the new channel buffer.
+ */
+static void
+copy_rest(struct rchan *rchan, char * oldbuf, u32 old_buf_size, u32 old_n_bufs, int old_cur_bufno, int new_cur_bufno, int copy_n_bufs)
+{
+	int delta = 0, i;
+	u32 ge, le;
+
+	le = (old_cur_bufno + 1) * old_buf_size;
+	ge = le;
+		
+	for (i = 0; i < copy_n_bufs; i++, --old_cur_bufno, --new_cur_bufno) {
+		if (old_cur_bufno < 0) {
+			if (le != ge) {
+				old_cur_bufno = old_n_bufs - 1;
+				rchan->callbacks->resize_offset(rchan->id,
+								ge, le, delta);
+				rchan->offsets_changed = 1;
+				le = (old_cur_bufno + 1) * old_buf_size;
+				ge = le;
+			}
+		}
+
+		memcpy(rchan->buf + new_cur_bufno * old_buf_size,
+		       oldbuf + old_cur_bufno * old_buf_size, old_buf_size);
+		atomic_set(&fill_count(rchan, new_cur_bufno),
+			   atomic_read(&tmp_fill[old_cur_bufno]));
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
+	if (le != ge) {
+		rchan->callbacks->resize_offset(rchan->id, ge, le, delta);
+		rchan->offsets_changed = 1;
+	}
+}
+
+/**
+ *	copy_shrink - copies old buffer to smaller buffer
+ *	@rchan: the channel
+ *	@newsize: the size of the new buffer
+ *	@oldsize: the size of the old buffer
+ *	@oldsize: the old buffer
+ *	@old_cur_idx: the current index into the old buffer
+ *	@old_buf_size: the old buffer's sub-buffer size
+ *	@old_n_buf: the old buffer's sub-buffer count
+ *
+ *	Copies the contents of the old relay channel buffer into the
+ *	new channel buffer.
+ */
+static void
+copy_shrink(struct rchan *rchan, int newsize, int oldsize, char * oldbuf, u32 old_cur_idx, u32 old_buf_size, u32 old_n_bufs)
+{
+	int old_cur_bufno, new_cur_bufno, copy_n_bufs, delta, i;
+
+	for (i = 0; i < RELAY_MAX_BUFS; i++) {
+		tmp_unused[i] = rchan->unused_bytes[i];
+		tmp_fill[i] = rchan->scheme.lockless.fill_count[i];
+	}
+	
+	old_cur_bufno = old_cur_idx / old_buf_size;
+	new_cur_bufno = 0;
+
+	delta = copy_to_bottom(rchan, oldbuf, old_buf_size, old_cur_bufno, new_cur_bufno);
+	idx(rchan) += delta;
+
+	copy_n_bufs = rchan->n_bufs - 1;
+	new_cur_bufno = rchan->n_bufs - 1;
+	old_cur_bufno--;
+	if (old_cur_bufno < 0)
+		old_cur_bufno = old_n_bufs - 1;
+
+	copy_rest(rchan, oldbuf, old_buf_size, old_n_bufs, old_cur_bufno,
+		  new_cur_bufno, copy_n_bufs);
+
+	rchan->buf_id = rchan->buf_id - rchan->buf_id % rchan->n_bufs;
+}
+
+/**
+ *	lockless_copy_contents - relayfs copy_contents() implementation
+ *	@rchan: the channel
+ *	@newsize: the size of the new buffer
+ *	@oldsize: the size of the old buffer
+ *	@oldsize: the old buffer
+ *	@old_cur_idx: the current index into the old buffer
+ *	@old_buf_size: the old buffer's sub-buffer size
+ *	@old_n_bufs: the old buffer's sub-buffer count
+ *
+ *	Copies the contents of the old relay channel buffer into the
+ *	new channel buffer.
+ */
+void
+lockless_copy_contents(struct rchan *rchan, int newsize, int oldsize, char * oldbuf, u32 old_cur_idx, u32 old_buf_size, u32 old_n_bufs)
+{
+	int i;
+
+	bufno_bits(rchan) += resize_order(rchan);
+	idx_mask(rchan) =
+		(1UL << (bufno_bits(rchan) + offset_bits(rchan))) - 1;
+	if (resize_order(rchan) > 0) {
+		for (i = rchan->n_bufs / 2; i < rchan->n_bufs; i++) {
+			atomic_set(&fill_count(rchan, i),
+				   (int)RELAY_BUF_SIZE(offset_bits(rchan)));
+			rchan->unused_bytes[i] = 0;
+		}
+	}
+
+	if (newsize > oldsize)
+		copy_expand(rchan, newsize, oldsize, oldbuf,
+			    old_cur_idx, old_buf_size, old_n_bufs);
+	else
+		copy_shrink(rchan, newsize, oldsize, oldbuf,
+			    old_cur_idx, old_buf_size, old_n_bufs);
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
diff -urpN -X dontdiff linux-2.6.0-test1/fs/relayfs/relay_lockless.h linux-2.6.0-test1-relayfs-printk/fs/relayfs/relay_lockless.h
--- linux-2.6.0-test1/fs/relayfs/relay_lockless.h	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/fs/relayfs/relay_lockless.h	Sun Jul 13 22:32:49 2003
@@ -0,0 +1,39 @@
+#ifndef _RELAY_LOCKLESS_H
+#define _RELAY_LOCKLESS_H
+
+#define RESIZE_THRESHOLD_LOCKLESS 3 / 4
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
+u32 
+lockless_get_offset(struct rchan *rchan, u32 *max_offset);
+
+extern void
+lockless_copy_contents(struct rchan *rchan,
+		       int newsize,
+		       int oldsize,
+		       char * oldbuf,
+		       u32 old_cur_idx,
+		       u32 old_buf_size,
+		       u32 old_n_bufs);
+
+#endif/* _RELAY_LOCKLESS_H */

-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

