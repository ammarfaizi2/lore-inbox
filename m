Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268339AbTGOPEk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 11:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268295AbTGOPEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 11:04:40 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:35499 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268339AbTGOPCq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 11:02:46 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16148.6870.780484.906779@gargle.gargle.HOWL>
Date: Tue, 15 Jul 2003 10:16:38 -0500
To: linux-kernel@vger.kernel.org
Cc: karim@opersys.com, bob@watson.ibm.com
Subject: [RFC][PATCH 2/5] relayfs include files
X-Mailer: VM(ViewMail) 7.01 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN -X dontdiff linux-2.6.0-test1/include/linux/relayfs_fs.h linux-2.6.0-test1-relayfs-printk/include/linux/relayfs_fs.h
--- linux-2.6.0-test1/include/linux/relayfs_fs.h	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/include/linux/relayfs_fs.h	Sun Jul 13 22:32:32 2003
@@ -0,0 +1,675 @@
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
+#include <linux/fs.h>
+
+/*
+ * Tracks changes to rchan struct
+ */
+#define RELAYFS_CHANNEL_VERSION		1
+
+/*
+ * Maximum number of simultaneously open channels
+ */
+#define RELAY_MAX_CHANNELS		256
+
+/*
+ * Relay properties
+ */
+#define RELAY_MIN_BUFS			2
+#define RELAY_MIN_BUFSIZE		4096
+#define RELAY_MAX_BUFS			256
+#define RELAY_LOCKLESS_MAX_BUF_SIZE	0x1000000
+#define RELAY_LOCKLESS_MAX_TOTAL_BUF_SIZE 0x8000000
+
+/*
+ * Lockless scheme utility macros
+ */
+#define RELAY_MAX_BUFNO(bufno_bits) (1UL << (bufno_bits))
+#define RELAY_BUF_SIZE(offset_bits) (1UL << (offset_bits))
+#define RELAY_BUF_OFFSET_MASK(offset_bits) (RELAY_BUF_SIZE(offset_bits) - 1)
+#define RELAY_BUFNO_GET(index, offset_bits) ((index) >> (offset_bits))
+#define RELAY_BUF_OFFSET_GET(index, mask) ((index) & (mask))
+#define RELAY_BUF_OFFSET_CLEAR(index, mask) ((index) & ~(mask))
+
+/*
+ * Flags returned by relay_reserve()
+ */
+#define RELAY_BUFFER_SWITCH_NONE 0x00
+#define RELAY_WRITE_DISCARD_NONE 0x00
+#define RELAY_BUFFER_SWITCH      0x01
+#define RELAY_WRITE_DISCARD      0x02
+#define RELAY_WRITE_TOO_LONG     0x04
+
+/*
+ * Relay attribute flags
+ */
+#define RELAY_DELIVERY_BULK		0x1
+#define RELAY_DELIVERY_PACKET		0x2
+#define RELAY_SCHEME_LOCKLESS		0x4
+#define RELAY_SCHEME_LOCKING		0x8
+#define RELAY_SCHEME_ANY		0xC
+#define RELAY_TIMESTAMP_TSC		0x10
+#define RELAY_TIMESTAMP_GETTIMEOFDAY	0x20
+#define RELAY_TIMESTAMP_ANY		0x30
+#define RELAY_USAGE_SMP			0x40
+#define RELAY_USAGE_GLOBAL		0x80
+
+/*
+ * Flags for needs_resize() callback
+ */
+#define RELAY_RESIZE_NONE	0x00
+#define RELAY_RESIZE_EXPAND	0x01
+#define RELAY_RESIZE_SHRINK	0x02
+#define RELAY_RESIZE_REPLACE	0x04
+#define RELAY_RESIZE_REPLACED	0x08
+
+#define MAX_RESIZE_FAILURES	1
+
+/* 
+ * If the channel usage has been below the low water mark for more than
+ * this time, we can shrink the buffer if necessary.
+ */
+#define LOW_WATER_TIME 60 * 1000000
+
+/*
+ * Data structure returned by relay_info()
+ */
+struct rchan_info
+{
+	u32 flags;		/* relay attribute flags for channel */
+	u32 buf_size;		/* channel's sub-buffer size */
+	char *buf_addr;		/* address of channel start */
+	u32 alloc_size;		/* total buffer size actually allocated */
+	u32 n_bufs;		/* number of sub-buffers in channel */
+	u32 bufs_produced;	/* current count of sub-buffers produced */
+	u32 bufs_consumed;	/* current count of sub-buffers consumed */
+	u32 buf_id;		/* buf_id of current sub-buffer */
+	u32 events_lost;	/* total events lost due to buffers-full */
+	int buffer_complete[RELAY_MAX_BUFS];	/* boolean per sub-buffer */
+	int unused_bytes[RELAY_MAX_BUFS];	/* count per sub-buffer */
+};
+
+/*
+ * Relay channel client callbacks
+ */
+struct rchan_callbacks
+{
+	/*
+	 * buffer_start - called at the beginning of a new sub-buffer
+	 * @rchan_id: the channel id
+	 * @current_write_pos: position in sub-buffer client should write to
+	 * @buffer_id: the id of the new sub-buffer
+	 * @start_time: the timestamp associated with the start of sub-buffer
+	 * @start_tsc: the TSC associated with the timestamp, if using_tsc
+	 * @using_tsc: boolean, indicates whether start_tsc is valid
+	 *
+	 * Return value should be the number of bytes written by the client.
+	 *
+	 * The buffer_start callback gives the client an opportunity to
+	 * write data into space reserved at the beginning of a sub-buffer.
+	 * The client should only write into the buffer if it specified
+	 * a value for start_reserve and/or rchan_start_reserve when the 
+	 * channel was opened.  In the latter case, the client can 
+	 * determine whether to write its one-time rchan_start_reserve
+	 * data by examining the value of buffer_id, which will be 0 for
+	 * the first sub-buffer.
+	 */
+	int (*buffer_start) (int rchan_id,
+			     char *current_write_pos,
+			     u32 buffer_id,
+			     struct timeval start_time,
+			     u32 start_tsc,
+			     int using_tsc);
+
+	/*
+	 * buffer_end - called at the end of a sub-buffer
+	 * @rchan_id: the channel id
+	 * @current_write_pos: position in sub-buffer of end of data
+	 * @end_of_buffer: the position of the end of the sub-buffer
+	 * @end_time: the timestamp associated with the end of the sub-buffer
+	 * @end_tsc: the TSC associated with the end_time, if using_tsc
+	 * @using_tsc: boolean, indicates whether end_tsc is valid
+	 *
+	 * Return value should be the number of bytes written by the client.
+	 *
+	 * The buffer_end callback gives the client an opportunity to
+	 * perform end-of-buffer processing.  Note that the current_write_pos
+	 * is the position where the next write would occur, but since
+ 	 * the current write wouldn't fit, the buffer is considered full
+ 	 * even though there may be unused space at the end.  The
+ 	 * end_of_buffer value can be used to determine exactly the size
+	 * of the unused space.  The client should only write into the 
+	 * buffer if it specified a value for end_reserve when the channel
+	 * was opened.  If the client doesn't write anything i.e. returns
+	 * 0, the unused space at the end of the sub-buffer is available
+	 * via relay_info() - this data may be needed by the client later
+	 * if it needs to process raw sub-buffers (an alternative would 
+	 * be to save the unused bytes count value in end_reserve space at
+	 * the end of each sub-buffer during buffer_end processing and
+	 * read it when needed at a later time).
+	 */
+	int (*buffer_end) (int rchan_id,
+			   char *current_write_pos,
+			   char *end_of_buffer,
+			   struct timeval end_time,
+			   u32 end_tsc,
+			   int using_tsc);
+
+	/*
+	 * deliver - called when data is ready for the client
+	 * @rchan_id: the channel id
+	 * @from: the start of the delivered data
+	 * @len: the length of the delivered data
+	 *
+	 * This callback is used to notify a client when a sub-buffer is 
+	 * complete (bulk delivery) or a single write is complete (packet 
+	 * delivery).  A bulk delivery client might wish to then signal a
+	 * daemon that a sub-buffer is ready.  A packet delivery client
+	 * might wish to process the packet or send it elsewhere..
+	 */
+	void (*deliver) (int rchan_id, char *from, u32 len);
+
+	/*
+	 * buffers_full - called when a buffers-full condition is detected
+	 * @rchan_id: the channel id
+	 *
+	 * This callback is used to notify a client that further writes
+	 * to the channel will result in unread data being overwritten.
+	 * The client can signal that it doesn't want this to happen by
+	 * returning 1, which will 'suspend' the channel.  Further writes
+	 * to the channel will be discarded, and the channel's events_lost
+	 * counter will be incremented for each discarded write.  The 
+	 * channel can be subsequently 'resumed' by calling the relay_resume
+	 * API function.  If the client returns 0, writing will continue 
+	 * unhindered into the next sub-buffer.  This 'feature' could be used
+	 * to implement 'flight recorder' applications, for instance.
+	 */
+	int (*buffers_full)(int rchan_id);
+
+	/*
+	 * needs_resize - called when a resizing event occurs
+	 * @rchan_id: the channel id
+	 * @resize_type: the type of resizing event
+	 * @suggested_buf_size: the suggested new sub-buffer size
+	 * @suggested_buf_size: the suggested new number of sub-buffers
+	 *
+	 * Called when a channel's buffers are in danger of becoming
+	 * full i.e. the number of unread bytes in the channel passes
+	 * a preset threshold, or when the current capacity of a
+	 * channel's buffer is no longer needed.  Also called to
+	 * notify the client when a channel's buffer has been
+	 * replaced.  If resize_type is RELAY_RESIZE_EXPAND or
+	 * RELAY_RESIZE_SHRINK, the kernel client should arrange to
+	 * call relay_realloc_buffer() with the suggested buffer size
+	 * and buffer count, which will allocate (but will not
+	 * replace the old one) a new buffer of the recommended size
+	 * for the channel.  Note that this function should not be
+	 * called with locks held, as it may sleep, but may be called
+	 * from within interrupt context - in this case the
+	 * allocation will be put on a work queue.  When the
+	 * allocation has completed, needs_resize() is again called,
+	 * this time with a resize_type of RELAY_RESIZE_REPLACE.  The
+	 * kernel client should then arrange to call
+	 * relay_replace_buffer() to actually replace the old channel
+	 * buffer with the newly allocated buffer.  Note that this
+	 * function can be called in any context, but clients should
+	 * make sure that the channel isn't currently in use, to
+	 * avoid pulling out the rug from under any current users.
+	 * Finally, once the buffer replacement has completed,
+	 * needs_resize() is again called, this time with a
+	 * resize_type of RELAY_RESIZE_REPLACED, to inform the client
+	 * that the replacement is complete and additionally
+	 * confirming the current sub-buffer size and number of
+	 * sub-buffers.
+	 */
+	void (*needs_resize)(int rchan_id,
+			     int resize_type,
+			     u32 suggested_buf_size,
+			     u32 suggested_n_bufs);
+
+	/*
+	 * resize_offset - called to notify a client to adjust buffer offsets
+	 * @rchan_id: the channel id
+	 * @ge_offset: if the offset is >= this value
+	 * @le_offset: and <= this value
+	 * @delta: adjust the offset by this amount
+	 *
+	 * Called during the buffer copying phase of buffer
+	 * replacement in order to let the client know that if it
+	 * currently holds any offsets into the channel buffer, those
+	 * offsets may be invalid due to resizing and should be
+	 * adjusted.  The client should check any offsets it's using
+	 * that reference the channel buffer to see whether or not
+	 * they fall within the offset range defined by ge_offset and
+	 * le_offset.  If so, it should add the delta value (which
+	 * may be negative) to any offset contained within the range.
+	 * Note that any particular offset can only be affected once
+	 * per resize, so the client should take care that subsequent
+	 * resize_offset() calls don't mistakenly change the offset
+	 * again within the same resize (e.g. set a flag once an
+	 * offset has been adjusted, which doesn't get reset until
+	 * the RELAY_RESIZE_REPLACED needs_resize() call is made
+	 * signifying the completion of the resize.
+	 */
+	void (*resize_offset)(int rchan_id,
+			      u32 ge_offset,
+			      u32 le_offset,
+			      int delta);
+};
+
+/*
+ * Lockless scheme-specific data
+ */
+struct lockless_rchan
+{
+	u8 bufno_bits;		/* # bits used for sub-buffer id */
+	u8 offset_bits;		/* # bits used for offset within sub-buffer */
+	u32 index;		/* current index = sub-buffer id and offset */
+	u32 offset_mask;	/* used to obtain offset portion of index */
+	u32 index_mask;		/* used to mask off unused bits index */
+	u32 last_event_index;	/* used for channel suspend */
+	struct timeval last_event_timestamp;	/* used for channel suspend */
+	u32 last_event_tsc;	/* used for channel suspend */
+	int resize_order;	/* how large was the last resize */
+	atomic_t fill_count[RELAY_MAX_BUFS];	/* fill count per sub-buffer */
+};
+
+/*
+ * Locking scheme-specific data
+ */
+struct locking_rchan
+{
+	char *write_buf;		/* start of write sub-buffer */
+	char *read_buf;			/* start of read sub-buffer */
+	char *write_buf_end;		/* end of write sub-buffer */
+	char *read_buf_end;		/* end of read sub-buffer */
+	char *current_write_pos;	/* current write pointer */
+	char *read_limit;		/* takes reserves into account */
+	char *write_limit;		/* takes reserves into account */
+	char *in_progress_event_pos;	/* used for interrupted writes */
+	u16 in_progress_event_size;	/* used for interrupted writes */
+	char *interrupted_pos;		/* used for interrupted writes */
+	u16 interrupting_size;		/* used for interrupted writes */
+	spinlock_t lock;		/* channel lock for locking scheme */
+	int bytes_produced;		/* # bytes produced in cur sub-buf */
+};
+
+struct relay_ops;
+
+/*
+ * Relay channel data structure
+ */
+struct rchan
+{
+	u32 version;			/* the version of this struct */
+	char *buf;			/* the channel buffer */
+	int id;				/* the channel id */
+	struct rchan_callbacks *callbacks;	/* client callbacks */
+	u32 flags;			/* relay channel attributes */
+	u32 buf_id;			/* current sub-buffer id */
+
+	atomic_t suspended;		/* channel suspended? */
+	u32 events_lost;		/* events lost via buffers-full */
+
+	struct timeval  buf_start_time;	/* current sub-buffer start time */
+	u32 buf_start_tsc;		/* current sub-buffer start TSC */
+	
+	u32 buf_size;			/* sub-buffer size */
+	u32 alloc_size;			/* total buffer size allocated */
+	u32 n_bufs;			/* number of sub-buffers */
+
+	u32 bufs_produced;		/* count of sub-buffers produced */
+	u32 bufs_consumed;		/* count of sub-buffers consumed */
+	u32 bytes_consumed;		/* since last bufs_consumed */
+
+	int initialized;		/* first buffer initialized? */
+	int finalized;			/* channel finalized? */
+
+	u32 start_reserve;		/* reserve at start of sub-buffers */
+	u32 end_reserve;		/* reserve at end of sub-buffers */
+	u32 rchan_start_reserve;	/* additional reserve sub-buffer 0 */
+	
+	int mapped;			/* has channel been mapped? */
+	struct dentry *dentry;		/* channel file dentry */
+
+	wait_queue_head_t read_wait;	/* VFS read wait queue */
+	atomic_t refcount;		/* channel refcount */
+
+	struct relay_ops *relay_ops;	/* scheme-specific channel ops */
+
+	int unused_bytes[RELAY_MAX_BUFS]; /* unused count per sub-buffer */
+
+	struct semaphore resize_sem;	/* serializes alloc/repace */
+	struct timeval  low_water_time;	/* last time above low water */
+	struct work_struct work;	/* resize allocation work struct */
+	
+	u32 resize_min;			/* minimum resized total buffer size */
+	u32 resize_max;			/* maximum resized total buffer size */
+	char *resize_buf;		/* for autosize alloc/free */
+	u32 resize_buf_size;		/* resized sub-buffer size */
+	u32 resize_n_bufs;		/* resized number of sub-buffers */
+	u32 resize_alloc_size;		/* resized actual total size */
+	
+	int resizing;			/* is resizing in progress? */
+	int resize_err;			/* resizing err code */
+	int resize_failures;		/* number of resize failures */
+	int offsets_changed;		/* did potential offsets change? */
+	int replace_buffer;		/* is the alloced buffer ready?  */
+
+	union
+	{
+		struct lockless_rchan lockless;
+		struct locking_rchan locking;
+	} scheme;			/* scheme-specific channel data */
+} ____cacheline_aligned;
+
+/*
+ * Used for deferring resized channel free
+ */
+struct free_rchan_buf
+{
+	char *free_buf;			/* for autosize alloc/free */
+	u32 free_alloc_size;		/* total buffer size allocated */
+	struct work_struct work;	/* resize de-allocation work struct */
+};
+
+/*
+ * These help make union member access less tedious
+ */
+#define channel_buffer(rchan) ((rchan)->buf)
+#define idx(rchan) ((rchan)->scheme.lockless.index)
+#define bufno_bits(rchan) ((rchan)->scheme.lockless.bufno_bits)
+#define offset_bits(rchan) ((rchan)->scheme.lockless.offset_bits)
+#define offset_mask(rchan) ((rchan)->scheme.lockless.offset_mask)
+#define idx_mask(rchan) ((rchan)->scheme.lockless.index_mask)
+#define bulk_delivery(rchan) (((rchan)->flags & RELAY_DELIVERY_BULK) ? 1 : 0)
+#define packet_delivery(rchan) (((rchan)->flags & RELAY_DELIVERY_PACKET) ? 1 : 0)
+#define using_lockless(rchan) (((rchan)->flags & RELAY_SCHEME_LOCKLESS) ? 1 : 0)
+#define using_locking(rchan) (((rchan)->flags & RELAY_SCHEME_LOCKING) ? 1 : 0)
+#define using_tsc(rchan) (((rchan)->flags & RELAY_TIMESTAMP_TSC) ? 1 : 0)
+#define using_gettimeofday(rchan) (((rchan)->flags & RELAY_TIMESTAMP_GETTIMEOFDAY) ? 1 : 0)
+#define usage_smp(rchan) (((rchan)->flags & RELAY_USAGE_SMP) ? 1 : 0)
+#define usage_global(rchan) (((rchan)->flags & RELAY_USAGE_GLOBAL) ? 1 : 0)
+#define fill_count(rchan, i) ((rchan)->scheme.lockless.fill_count[(i)])
+#define last_event_index(rchan) ((rchan)->scheme.lockless.last_event_index)
+#define last_event_timestamp(rchan) ((rchan)->scheme.lockless.last_event_timestamp)
+#define last_event_tsc(rchan) ((rchan)->scheme.lockless.last_event_tsc)
+#define write_buf(rchan) ((rchan)->scheme.locking.write_buf)
+#define read_buf(rchan) ((rchan)->scheme.locking.read_buf)
+#define write_buf_end(rchan) ((rchan)->scheme.locking.write_buf_end)
+#define read_buf_end(rchan) ((rchan)->scheme.locking.read_buf_end)
+#define cur_write_pos(rchan) ((rchan)->scheme.locking.current_write_pos)
+#define read_limit(rchan) ((rchan)->scheme.locking.read_limit)
+#define write_limit(rchan) ((rchan)->scheme.locking.write_limit)
+#define in_progress_event_pos(rchan) ((rchan)->scheme.locking.in_progress_event_pos)
+#define in_progress_event_size(rchan) ((rchan)->scheme.locking.in_progress_event_size)
+#define interrupted_pos(rchan) ((rchan)->scheme.locking.interrupted_pos)
+#define interrupting_size(rchan) ((rchan)->scheme.locking.interrupting_size)
+#define channel_lock(rchan) ((rchan)->scheme.locking.lock)
+#define bytes_produced(rchan) ((rchan)->scheme.locking.bytes_produced)
+#define resize_order(rchan) ((rchan)->scheme.lockless.resize_order)
+
+/**
+ *	calc_time_delta - utility function for time delta calculation
+ *	@now: current time
+ *	@start: start time
+ *
+ *	Returns the time delta produced by subtracting start time from now.
+ */
+static inline u32
+calc_time_delta(struct timeval *now, 
+		struct timeval *start)
+{
+	return (now->tv_sec - start->tv_sec) * 1000000
+		+ (now->tv_usec - start->tv_usec);
+}
+
+/**
+ *	recalc_time_delta - utility function for time delta recalculation
+ *	@now: current time
+ *	@new_delta: the new time delta calculated
+ *	@cpu: the associated CPU id
+ */
+static inline void 
+recalc_time_delta(struct timeval *now,
+		  u32 *new_delta,
+		  struct rchan *rchan)
+{
+	if (using_tsc(rchan) == 0)
+		*new_delta = calc_time_delta(now, &rchan->buf_start_time);
+}
+
+/**
+ *	have_cmpxchg - does this architecture have a cmpxchg?
+ *
+ *	Returns 1 if this architecture has a cmpxchg useable by 
+ *	the lockless scheme, 0 otherwise.
+ */
+static inline int 
+have_cmpxchg(void)
+{
+#if defined(__HAVE_ARCH_CMPXCHG)
+	return 1;
+#else
+	return 0;
+#endif
+}
+
+/**
+ *	relay_write_direct - write data directly into destination buffer
+ */
+#define relay_write_direct(DEST, SRC, SIZE) \
+do\
+{\
+   memcpy(DEST, SRC, SIZE);\
+   DEST += SIZE;\
+} while (0);
+
+/**
+ *	relay_lock_channel - lock the relay channel if applicable
+ *
+ *	This macro only affects the locking scheme.  If the locking scheme
+ *	is in use and the channel usage is SMP, does a local_irq_save.  If the 
+ *	locking sheme is in use and the channel usage is GLOBAL, uses 
+ *	spin_lock_irqsave.  FLAGS is initialized to 0 since we know that
+ *	it is being initialized prior to use and we avoid the compiler warning.
+ */
+#define relay_lock_channel(RCHAN, FLAGS) \
+do\
+{\
+   FLAGS = 0;\
+   if (using_locking(RCHAN)) {\
+      if (usage_smp(RCHAN)) {\
+         local_irq_save(FLAGS); \
+      } else {\
+         spin_lock_irqsave(&(RCHAN)->scheme.locking.lock, FLAGS); \
+      }\
+   }\
+} while (0);
+
+/**
+ *	relay_unlock_channel - unlock the relay channel if applicable
+ *
+ *	This macro only affects the locking scheme.  See relay_lock_channel.
+ */
+#define relay_unlock_channel(RCHAN, FLAGS) \
+do\
+{\
+   if (using_locking(RCHAN)) {\
+      if (usage_smp(RCHAN)) {\
+         local_irq_restore(FLAGS); \
+      } else {\
+         spin_unlock_irqrestore(&(RCHAN)->scheme.locking.lock, FLAGS); \
+      }\
+   }\
+} while (0);
+
+/*
+ * Define cmpxchg if we don't have it
+ */
+#ifndef __HAVE_ARCH_CMPXCHG
+#define cmpxchg(p,o,n) 0
+#endif
+
+/*
+ * High-level relayfs kernel API, fs/relayfs/relay.c
+ */
+extern int
+relay_open(char *chanpath,
+	   int bufsize_lockless,
+	   int nbufs_lockless,
+	   int bufsize_locking,
+	   int nbufs_locking,
+	   u32 flags,
+	   struct rchan_callbacks *callbacks,
+	   u32 start_reserve,
+	   u32 end_reserve,
+	   u32 rchan_start_reserve,
+	   u32 resize_min,
+	   u32 resize_max);
+
+extern int 
+relay_write(int rchan_id,
+	    const void *data_ptr, 
+	    size_t count,
+	    int td_offset);
+
+extern ssize_t
+relay_read(int rchan_id, 
+	   char * buf, 
+	   size_t count, 
+	   u32 read_offset, 
+	   u32 *new_offset,
+	   int wait);
+
+extern void 
+relay_buffers_consumed(int rchan_id, u32 buffers_consumed);
+
+extern void
+relay_bytes_consumed(int rchan_id, u32 bytes_consumed, u32 read_offset);
+
+extern void 
+relay_resume(int rchan_id);
+
+extern int 
+relay_info(int rchan_id, struct rchan_info *rchan_info);
+
+extern int 
+relay_close(int rchan_id);
+
+extern ssize_t
+relay_bytes_avail(int rchan_id, u32 read_offset);
+
+extern int
+relay_realloc_buffer(int rchan_id, u32 new_bufsize, u32 new_nbufs);
+
+extern int
+relay_replace_buffer(int rchan_id);
+
+extern ssize_t
+relay_read_last(int rchan_id, char * buf, size_t count);
+
+/*
+ * Low-level relayfs kernel API, fs/relayfs/relay.c
+ */
+extern struct rchan *
+rchan_get(int rchan_id);
+
+extern void
+rchan_put(struct rchan *rchan);
+
+extern char *
+relay_reserve(struct rchan *rchan,
+	      u32 data_len,
+	      struct timeval *time_stamp,
+	      u32 *time_delta,
+	      int *errcode,
+	      int *interrupting);
+
+extern void 
+relay_commit(struct rchan *rchan,
+	     char *from, 
+	     u32 len, 
+	     int reserve_code,
+	     int interrupting);
+
+extern int 
+relay_mmap_buffer(int rchan_id, struct vm_area_struct *vma);
+
+extern int 
+relay_busy(void);
+
+extern u32 
+relay_get_offset(struct rchan *rchan, u32 *max_offset);
+
+/*
+ * VFS functions, fs/relayfs/inode.c
+ */
+extern int 
+relayfs_create_dir(const char *name, 
+		   struct dentry *parent, 
+		   struct dentry **dentry);
+
+extern int
+relayfs_create_file(const char * name,
+		    struct dentry *parent, 
+		    struct dentry **dentry,
+		    void * data);
+
+extern int 
+relayfs_remove_file(struct dentry *dentry);
+
+/*
+ * Scheme-specific channel ops
+ */
+struct relay_ops
+{
+	char * (*reserve) (struct rchan *rchan,
+			   u32 slot_len,
+			   struct timeval *time_stamp,
+			   u32 *tsc,
+			   int * errcode,
+			   int * interrupting);
+	
+	void (*commit) (struct rchan *rchan,
+		       char *from,
+		       u32 len, 
+		       int deliver, 
+		       int interrupting);
+
+	u32 (*get_offset) (struct rchan *rchan,
+			   u32 *max_offset);
+	
+	void (*resume) (struct rchan *rchan);
+	void (*finalize) (struct rchan *rchan);
+	void (*copy_contents) (struct rchan *rchan,
+			       int newsize,
+			       int oldsize,
+			       char * oldbuf,
+			       u32 old_cur_idx,
+			       u32 old_buf_size,
+			       u32 old_n_bufs);
+};
+
+#endif /* _LINUX_RELAYFS_FS_H */
+
+
+
+
+
diff -urpN -X dontdiff linux-2.6.0-test1/include/asm-alpha/relay.h linux-2.6.0-test1-relayfs-printk/include/asm-alpha/relay.h
--- linux-2.6.0-test1/include/asm-alpha/relay.h	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/include/asm-alpha/relay.h	Sun Jul 13 22:32:32 2003
@@ -0,0 +1,5 @@
+#ifndef _ASM_ALPHA_RELAY_H
+#define _ASM_ALPHA_RELAY_H
+
+#include <asm-generic/relay.h>
+#endif
diff -urpN -X dontdiff linux-2.6.0-test1/include/asm-arm/relay.h linux-2.6.0-test1-relayfs-printk/include/asm-arm/relay.h
--- linux-2.6.0-test1/include/asm-arm/relay.h	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/include/asm-arm/relay.h	Sun Jul 13 22:32:32 2003
@@ -0,0 +1,5 @@
+#ifndef _ASM_ARM_RELAY_H
+#define _ASM_ARM_RELAY_H
+
+#include <asm-generic/relay.h>
+#endif
diff -urpN -X dontdiff linux-2.6.0-test1/include/asm-arm26/relay.h linux-2.6.0-test1-relayfs-printk/include/asm-arm26/relay.h
--- linux-2.6.0-test1/include/asm-arm26/relay.h	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/include/asm-arm26/relay.h	Sun Jul 13 22:32:32 2003
@@ -0,0 +1,5 @@
+#ifndef _ASM_ARM_RELAY_H
+#define _ASM_ARM_RELAY_H
+
+#include <asm-generic/relay.h>
+#endif
diff -urpN -X dontdiff linux-2.6.0-test1/include/asm-cris/relay.h linux-2.6.0-test1-relayfs-printk/include/asm-cris/relay.h
--- linux-2.6.0-test1/include/asm-cris/relay.h	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/include/asm-cris/relay.h	Sun Jul 13 22:32:32 2003
@@ -0,0 +1,5 @@
+#ifndef _ASM_CRIS_RELAY_H
+#define _ASM_CRIS_RELAY_H
+
+#include <asm-generic/relay.h>
+#endif
diff -urpN -X dontdiff linux-2.6.0-test1/include/asm-generic/relay.h linux-2.6.0-test1-relayfs-printk/include/asm-generic/relay.h
--- linux-2.6.0-test1/include/asm-generic/relay.h	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/include/asm-generic/relay.h	Sun Jul 13 22:32:32 2003
@@ -0,0 +1,76 @@
+#ifndef _ASM_GENERIC_RELAY_H
+#define _ASM_GENERIC_RELAY_H
+/*
+ * linux/include/asm-generic/relay.h
+ *
+ * Copyright (C) 2002, 2003 - Tom Zanussi (zanussi@us.ibm.com), IBM Corp
+ * Copyright (C) 2002 - Karim Yaghmour (karim@opersys.com)
+ *
+ * Architecture-independent definitions for relayfs
+ */
+
+#include <linux/relayfs_fs.h>
+
+/**
+ *	get_time_delta - utility function for getting time delta
+ *	@now: pointer to a timeval struct that may be given current time
+ *	@rchan: the channel
+ *
+ *	Returns the time difference between the current time and the buffer
+ *	start time.
+ */
+static inline u32
+get_time_delta(struct timeval *now, struct rchan *rchan)
+{
+	u32 time_delta;
+
+	do_gettimeofday(now);
+	time_delta = calc_time_delta(now, &rchan->buf_start_time);
+
+	return time_delta;
+}
+
+/**
+ *	get_timestamp - utility function for getting a time and TSC pair
+ *	@now: current time
+ *	@tsc: the TSC associated with now
+ *	@rchan: the channel
+ *
+ *	Sets the value pointed to by now to the current time. Value pointed to
+ *	by tsc is not set since there is no generic TSC support.
+ */
+static inline void 
+get_timestamp(struct timeval *now, 
+	      u32 *tsc,
+	      struct rchan *rchan)
+{
+	do_gettimeofday(now);
+}
+
+/**
+ *	get_time_or_tsc: - Utility function for getting a time or a TSC.
+ *	@now: current time
+ *	@tsc: current TSC
+ *	@rchan: the channel
+ *
+ *	Sets the value pointed to by now to the current time.
+ */
+static inline void 
+get_time_or_tsc(struct timeval *now, 
+		u32 *tsc,
+		struct rchan *rchan)
+{
+	do_gettimeofday(now);
+}
+
+/**
+ *	have_tsc - does this platform have a useable TSC?
+ *
+ *	Returns 0.
+ */
+static inline int 
+have_tsc(void)
+{
+	return 0;
+}
+#endif
diff -urpN -X dontdiff linux-2.6.0-test1/include/asm-h8300/relay.h linux-2.6.0-test1-relayfs-printk/include/asm-h8300/relay.h
--- linux-2.6.0-test1/include/asm-h8300/relay.h	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/include/asm-h8300/relay.h	Sun Jul 13 22:32:32 2003
@@ -0,0 +1,5 @@
+#ifndef _ASM_H8300_RELAY_H
+#define _ASM_H8300_RELAY_H
+
+#include <asm-generic/relay.h>
+#endif
diff -urpN -X dontdiff linux-2.6.0-test1/include/asm-i386/relay.h linux-2.6.0-test1-relayfs-printk/include/asm-i386/relay.h
--- linux-2.6.0-test1/include/asm-i386/relay.h	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/include/asm-i386/relay.h	Sun Jul 13 22:32:32 2003
@@ -0,0 +1,101 @@
+#ifndef _ASM_I386_RELAY_H
+#define _ASM_I386_RELAY_H
+/*
+ * linux/include/asm-i386/relay.h
+ *
+ * Copyright (C) 2002, 2003 - Tom Zanussi (zanussi@us.ibm.com), IBM Corp
+ * Copyright (C) 2002 - Karim Yaghmour (karim@opersys.com)
+ *
+ * i386 definitions for relayfs
+ */
+
+#include <linux/relayfs_fs.h>
+
+#ifdef CONFIG_X86_TSC
+#include <asm/msr.h>
+
+/**
+ *	get_time_delta - utility function for getting time delta
+ *	@now: pointer to a timeval struct that may be given current time
+ *	@rchan: the channel
+ *
+ *	Returns either the TSC if TSCs are being used, or the time and the
+ *	time difference between the current time and the buffer start time 
+ *	if TSCs are not being used.
+ */
+static inline u32
+get_time_delta(struct timeval *now, struct rchan *rchan)
+{
+	u32 time_delta;
+
+	if ((using_tsc(rchan) == 1) && cpu_has_tsc)
+		rdtscl(time_delta);
+	else {
+		do_gettimeofday(now);
+		time_delta = calc_time_delta(now, &rchan->buf_start_time);
+	}
+
+	return time_delta;
+}
+
+/**
+ *	get_timestamp - utility function for getting a time and TSC pair
+ *	@now: current time
+ *	@tsc: the TSC associated with now
+ *	@rchan: the channel
+ *
+ *	Sets the value pointed to by now to the current time and the value
+ *	pointed to by tsc to the tsc associated with that time, if the 
+ *	platform supports TSC.
+ */
+static inline void 
+get_timestamp(struct timeval *now,
+	      u32 *tsc,
+	      struct rchan *rchan)
+{
+	do_gettimeofday(now);
+
+	if ((using_tsc(rchan) == 1) && cpu_has_tsc)
+		rdtscl(*tsc);
+}
+
+/**
+ *	get_time_or_tsc - utility function for getting a time or a TSC
+ *	@now: current time
+ *	@tsc: current TSC
+ *	@rchan: the channel
+ *
+ *	Sets the value pointed to by now to the current time or the value
+ *	pointed to by tsc to the current tsc, depending on whether we're
+ *	using TSCs or not.
+ */
+static inline void 
+get_time_or_tsc(struct timeval *now,
+		u32 *tsc,
+		struct rchan *rchan)
+{
+	if ((using_tsc(rchan) == 1) && cpu_has_tsc)
+		rdtscl(*tsc);
+	else
+		do_gettimeofday(now);
+}
+
+/**
+ *	have_tsc - does this platform have a useable TSC?
+ *
+ *	Returns 1 if this platform has a useable TSC counter for
+ *	timestamping purposes, 0 otherwise.
+ */
+static inline int
+have_tsc(void)
+{
+	if (cpu_has_tsc)
+		return 1;
+	else
+		return 0;
+}
+
+#else /* No TSC support (#ifdef CONFIG_X86_TSC) */
+#include <asm-generic/relay.h>
+#endif /* #ifdef CONFIG_X86_TSC */
+#endif
diff -urpN -X dontdiff linux-2.6.0-test1/include/asm-ia64/relay.h linux-2.6.0-test1-relayfs-printk/include/asm-ia64/relay.h
--- linux-2.6.0-test1/include/asm-ia64/relay.h	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/include/asm-ia64/relay.h	Sun Jul 13 22:32:32 2003
@@ -0,0 +1,5 @@
+#ifndef _ASM_IA64_RELAY_H
+#define _ASM_IA64_RELAY_H
+
+#include <asm-generic/relay.h>
+#endif
diff -urpN -X dontdiff linux-2.6.0-test1/include/asm-m68k/relay.h linux-2.6.0-test1-relayfs-printk/include/asm-m68k/relay.h
--- linux-2.6.0-test1/include/asm-m68k/relay.h	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/include/asm-m68k/relay.h	Sun Jul 13 22:32:32 2003
@@ -0,0 +1,5 @@
+#ifndef _ASM_M68K_RELAY_H
+#define _ASM_M68K_RELAY_H
+
+#include <asm-generic/relay.h>
+#endif
diff -urpN -X dontdiff linux-2.6.0-test1/include/asm-m68knommu/relay.h linux-2.6.0-test1-relayfs-printk/include/asm-m68knommu/relay.h
--- linux-2.6.0-test1/include/asm-m68knommu/relay.h	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/include/asm-m68knommu/relay.h	Sun Jul 13 22:32:32 2003
@@ -0,0 +1,5 @@
+#ifndef _ASM_M68KNOMMU_RELAY_H
+#define _ASM_M68KNOMMU_RELAY_H
+
+#include <asm-generic/relay.h>
+#endif
diff -urpN -X dontdiff linux-2.6.0-test1/include/asm-mips/relay.h linux-2.6.0-test1-relayfs-printk/include/asm-mips/relay.h
--- linux-2.6.0-test1/include/asm-mips/relay.h	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/include/asm-mips/relay.h	Sun Jul 13 22:32:32 2003
@@ -0,0 +1,5 @@
+#ifndef _ASM_RELAY_H
+#define _ASM_RELAY_H
+
+#include <asm-generic/relay.h>
+#endif
diff -urpN -X dontdiff linux-2.6.0-test1/include/asm-mips64/relay.h linux-2.6.0-test1-relayfs-printk/include/asm-mips64/relay.h
--- linux-2.6.0-test1/include/asm-mips64/relay.h	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/include/asm-mips64/relay.h	Sun Jul 13 22:32:32 2003
@@ -0,0 +1,5 @@
+#ifndef _ASM_RELAY_H
+#define _ASM_RELAY_H
+
+#include <asm-generic/relay.h>
+#endif
diff -urpN -X dontdiff linux-2.6.0-test1/include/asm-parisc/relay.h linux-2.6.0-test1-relayfs-printk/include/asm-parisc/relay.h
--- linux-2.6.0-test1/include/asm-parisc/relay.h	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/include/asm-parisc/relay.h	Sun Jul 13 22:32:32 2003
@@ -0,0 +1,5 @@
+#ifndef _ASM_PARISC_RELAY_H
+#define _ASM_PARISC_RELAY_H
+
+#include <asm-generic/relay.h>
+#endif
diff -urpN -X dontdiff linux-2.6.0-test1/include/asm-ppc/relay.h linux-2.6.0-test1-relayfs-printk/include/asm-ppc/relay.h
--- linux-2.6.0-test1/include/asm-ppc/relay.h	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/include/asm-ppc/relay.h	Sun Jul 13 22:32:32 2003
@@ -0,0 +1,5 @@
+#ifndef _ASM_PPC_RELAY_H
+#define _ASM_PPC_RELAY_H
+
+#include <asm-generic/relay.h>
+#endif
diff -urpN -X dontdiff linux-2.6.0-test1/include/asm-ppc64/relay.h linux-2.6.0-test1-relayfs-printk/include/asm-ppc64/relay.h
--- linux-2.6.0-test1/include/asm-ppc64/relay.h	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/include/asm-ppc64/relay.h	Sun Jul 13 22:32:32 2003
@@ -0,0 +1,5 @@
+#ifndef _ASM_PPC64_RELAY_H
+#define _ASM_PPC64_RELAY_H
+
+#include <asm-generic/relay.h>
+#endif
diff -urpN -X dontdiff linux-2.6.0-test1/include/asm-s390/relay.h linux-2.6.0-test1-relayfs-printk/include/asm-s390/relay.h
--- linux-2.6.0-test1/include/asm-s390/relay.h	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/include/asm-s390/relay.h	Sun Jul 13 22:32:32 2003
@@ -0,0 +1,5 @@
+#ifndef _ASM_S390_RELAY_H
+#define _ASM_S390_RELAY_H
+
+#include <asm-generic/relay.h>
+#endif
diff -urpN -X dontdiff linux-2.6.0-test1/include/asm-sh/relay.h linux-2.6.0-test1-relayfs-printk/include/asm-sh/relay.h
--- linux-2.6.0-test1/include/asm-sh/relay.h	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/include/asm-sh/relay.h	Sun Jul 13 22:32:32 2003
@@ -0,0 +1,5 @@
+#ifndef _ASM_SH_RELAY_H
+#define _ASM_SH_RELAY_H
+
+#include <asm-generic/relay.h>
+#endif
diff -urpN -X dontdiff linux-2.6.0-test1/include/asm-sparc/relay.h linux-2.6.0-test1-relayfs-printk/include/asm-sparc/relay.h
--- linux-2.6.0-test1/include/asm-sparc/relay.h	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/include/asm-sparc/relay.h	Sun Jul 13 22:32:32 2003
@@ -0,0 +1,5 @@
+#ifndef _ASM_SPARC_RELAY_H
+#define _ASM_SPARC_RELAY_H
+
+#include <asm-generic/relay.h>
+#endif
diff -urpN -X dontdiff linux-2.6.0-test1/include/asm-sparc64/relay.h linux-2.6.0-test1-relayfs-printk/include/asm-sparc64/relay.h
--- linux-2.6.0-test1/include/asm-sparc64/relay.h	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/include/asm-sparc64/relay.h	Sun Jul 13 22:32:32 2003
@@ -0,0 +1,5 @@
+#ifndef _ASM_SPARC64_RELAY_H
+#define _ASM_SPARC64_RELAY_H
+
+#include <asm-generic/relay.h>
+#endif
diff -urpN -X dontdiff linux-2.6.0-test1/include/asm-um/relay.h linux-2.6.0-test1-relayfs-printk/include/asm-um/relay.h
--- linux-2.6.0-test1/include/asm-um/relay.h	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/include/asm-um/relay.h	Sun Jul 13 22:32:32 2003
@@ -0,0 +1,5 @@
+#ifndef __UM_RELAY_H
+#define __UM_RELAY_H
+
+#include <asm-generic/relay.h>
+#endif
diff -urpN -X dontdiff linux-2.6.0-test1/include/asm-v850/relay.h linux-2.6.0-test1-relayfs-printk/include/asm-v850/relay.h
--- linux-2.6.0-test1/include/asm-v850/relay.h	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/include/asm-v850/relay.h	Sun Jul 13 22:32:32 2003
@@ -0,0 +1,5 @@
+#ifndef __V850_RELAY_H
+#define __V850_RELAY_H
+
+#include <asm-generic/relay.h>
+#endif
diff -urpN -X dontdiff linux-2.6.0-test1/include/asm-x86_64/relay.h linux-2.6.0-test1-relayfs-printk/include/asm-x86_64/relay.h
--- linux-2.6.0-test1/include/asm-x86_64/relay.h	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/include/asm-x86_64/relay.h	Sun Jul 13 22:32:32 2003
@@ -0,0 +1,5 @@
+#ifndef _ASM_X86_64_RELAY_H
+#define _ASM_X86_64_RELAY_H
+
+#include <asm-generic/relay.h>
+#endif

-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

