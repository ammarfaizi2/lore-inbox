Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262820AbVHECci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262820AbVHECci (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 22:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262821AbVHECcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 22:32:35 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:56035 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262820AbVHECcd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 22:32:33 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17138.53178.227173.470701@tut.ibm.com>
Date: Thu, 4 Aug 2005 21:32:26 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, karim@opersys.com, prasadav@us.ibm.com
Subject: [-mm patch] relayfs: API cleanup
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does a bit of cleanup of the relayfs API, as discussed
previously:

http://marc.theaimsgroup.com/?l=linux-kernel&m=112134773617086&w=2

To recap, it:

- removes the commit counts, relay_commit() and the deliver() callback
(the padding counts had to stay, for the read() implementation)
- removes the buffer_full() callback
- changes the subbuf_start() callback
- changes 'unsigned' to 'unsigned int'
- other similar and related changes

The examples have been updated to use the new API (there's also a new
example that does commit/deliver in the client):

http://prdownloads.sourceforge.net/relayfs/relay-apps-0.7.tar.gz?download

Andrew, please apply.

Thanks,

Tom

Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>

diff -urpN -X dontdiff linux-2.6.13-rc4-mm1/fs/relayfs/buffers.c linux-2.6.13-rc4-mm1-cur/fs/relayfs/buffers.c
--- linux-2.6.13-rc4-mm1/fs/relayfs/buffers.c	2005-08-05 10:14:34.000000000 -0500
+++ linux-2.6.13-rc4-mm1-cur/fs/relayfs/buffers.c	2005-08-05 10:17:30.000000000 -0500
@@ -95,7 +95,7 @@ int relay_mmap_buf(struct rchan_buf *buf
 static void *relay_alloc_buf(struct rchan_buf *buf, unsigned long size)
 {
 	void *mem;
-	int i, j, n_pages;
+	unsigned int i, j, n_pages;
 
 	size = PAGE_ALIGN(size);
 	n_pages = size >> PAGE_SHIFT;
@@ -141,20 +141,15 @@ struct rchan_buf *relay_create_buf(struc
 	if (!buf->padding)
 		goto free_buf;
 
-	buf->commit = kmalloc(chan->n_subbufs * sizeof(unsigned *), GFP_KERNEL);
-	if (!buf->commit)
-		goto free_buf;
-
 	buf->start = relay_alloc_buf(buf, chan->alloc_size);
 	if (!buf->start)
 		goto free_buf;
-
+	
 	buf->chan = chan;
 	kref_get(&buf->chan->kref);
 	return buf;
 
 free_buf:
-	kfree(buf->commit);
 	kfree(buf->padding);
 	kfree(buf);
 	return NULL;
@@ -167,7 +162,7 @@ free_buf:
 void relay_destroy_buf(struct rchan_buf *buf)
 {
 	struct rchan *chan = buf->chan;
-	int i;
+	unsigned int i;
 
 	if (likely(buf->start)) {
 		vunmap(buf->start);
@@ -176,7 +171,6 @@ void relay_destroy_buf(struct rchan_buf 
 		kfree(buf->page_array);
 	}
 	kfree(buf->padding);
-	kfree(buf->commit);
 	kfree(buf);
 	kref_put(&chan->kref, relay_destroy_channel);
 }
diff -urpN -X dontdiff linux-2.6.13-rc4-mm1/fs/relayfs/relay.c linux-2.6.13-rc4-mm1-cur/fs/relayfs/relay.c
--- linux-2.6.13-rc4-mm1/fs/relayfs/relay.c	2005-08-05 10:14:34.000000000 -0500
+++ linux-2.6.13-rc4-mm1-cur/fs/relayfs/relay.c	2005-08-05 10:17:30.000000000 -0500
@@ -26,10 +26,7 @@
  */
 int relay_buf_empty(struct rchan_buf *buf)
 {
-	int produced = atomic_read(&buf->subbufs_produced);
-	int consumed = atomic_read(&buf->subbufs_consumed);
-
-	return (produced - consumed) ? 0 : 1;
+	return (buf->subbufs_produced - buf->subbufs_consumed) ? 0 : 1;
 }
 
 /**
@@ -38,17 +35,10 @@ int relay_buf_empty(struct rchan_buf *bu
  *
  *	Returns 1 if the buffer is full, 0 otherwise.
  */
-static inline int relay_buf_full(struct rchan_buf *buf)
+int relay_buf_full(struct rchan_buf *buf)
 {
-	int produced, consumed;
-
-	if (buf->chan->overwrite)
-		return 0;
-
-	produced = atomic_read(&buf->subbufs_produced);
-	consumed = atomic_read(&buf->subbufs_consumed);
-
-	return (produced - consumed > buf->chan->n_subbufs - 1) ? 1 : 0;
+	unsigned int ready = buf->subbufs_produced - buf->subbufs_consumed;
+	return (ready >= buf->chan->n_subbufs) ? 1 : 0;
 }
 
 /*
@@ -65,19 +55,10 @@ static inline int relay_buf_full(struct 
  */
 static int subbuf_start_default_callback (struct rchan_buf *buf,
 					  void *subbuf,
-					  unsigned prev_subbuf_idx,
-					  void *prev_subbuf)
-{
-	return 0;
-}
-
-/*
- * deliver() default callback.  Does nothing.
- */
-static void deliver_default_callback (struct rchan_buf *buf,
-				      unsigned subbuf_idx,
-				      void *subbuf)
+					  void *prev_subbuf,
+					  unsigned int prev_padding)
 {
+	return 1;
 }
 
 /*
@@ -96,22 +77,11 @@ static void buf_unmapped_default_callbac
 {
 }
 
-/*
- * buf_full() default callback.  Does nothing.
- */
-static void buf_full_default_callback(struct rchan_buf *buf,
-				      unsigned subbuf_idx,
-				      void *subbuf)
-{
-}
-
 /* relay channel default callbacks */
 static struct rchan_callbacks default_channel_callbacks = {
 	.subbuf_start = subbuf_start_default_callback,
-	.deliver = deliver_default_callback,
 	.buf_mapped = buf_mapped_default_callback,
 	.buf_unmapped = buf_unmapped_default_callback,
-	.buf_full = buf_full_default_callback,
 };
 
 /**
@@ -129,29 +99,16 @@ static void wakeup_readers(void *private
 }
 
 /**
- *	get_next_subbuf - return next sub-buffer within channel buffer
- *	@buf: channel buffer
- */
-static inline void *get_next_subbuf(struct rchan_buf *buf)
-{
-	void *next = buf->data + buf->chan->subbuf_size;
-	if (next >= buf->start + buf->chan->subbuf_size * buf->chan->n_subbufs)
-		next = buf->start;
-
-	return next;
-}
-
-/**
  *	__relay_reset - reset a channel buffer
  *	@buf: the channel buffer
  *	@init: 1 if this is a first-time initialization
  *
  *	See relay_reset for description of effect.
  */
-static inline void __relay_reset(struct rchan_buf *buf, int init)
+static inline void __relay_reset(struct rchan_buf *buf, unsigned int init)
 {
-	int i;
-
+	unsigned int i;
+	
 	if (init) {
 		init_waitqueue_head(&buf->read_wait);
 		kref_init(&buf->kref);
@@ -161,28 +118,22 @@ static inline void __relay_reset(struct 
 		flush_scheduled_work();
 	}
 
-	atomic_set(&buf->subbufs_produced, 0);
-	atomic_set(&buf->subbufs_consumed, 0);
-	atomic_set(&buf->unfull, 0);
+	buf->subbufs_produced = 0;
+	buf->subbufs_consumed = 0;
 	buf->finalized = 0;
 	buf->data = buf->start;
 	buf->offset = 0;
 
-	for (i = 0; i < buf->chan->n_subbufs; i++) {
+	for (i = 0; i < buf->chan->n_subbufs; i++)
 		buf->padding[i] = 0;
-		buf->commit[i] = 0;
-	}
 
-	buf->offset = buf->chan->cb->subbuf_start(buf, buf->data, 0, NULL);
-	buf->commit[0] = buf->offset;
+	buf->chan->cb->subbuf_start(buf, buf->data, NULL, 0);
 }
 
 /**
  *	relay_reset - reset the channel
  *	@chan: the channel
  *
- *	Returns 0 if successful, negative if not.
- *
  *	This has the effect of erasing all data from all channel buffers
  *	and restarting the channel in its initial state.  The buffers
  *	are not freed, so any mappings are still in effect.
@@ -192,7 +143,7 @@ static inline void __relay_reset(struct 
  */
 void relay_reset(struct rchan *chan)
 {
-	int i;
+	unsigned int i;
 
 	if (!chan)
 		return;
@@ -255,14 +206,10 @@ static inline void setup_callbacks(struc
 
 	if (!cb->subbuf_start)
 		cb->subbuf_start = subbuf_start_default_callback;
-	if (!cb->deliver)
-		cb->deliver = deliver_default_callback;
 	if (!cb->buf_mapped)
 		cb->buf_mapped = buf_mapped_default_callback;
 	if (!cb->buf_unmapped)
 		cb->buf_unmapped = buf_unmapped_default_callback;
-	if (!cb->buf_full)
-		cb->buf_full = buf_full_default_callback;
 	chan->cb = cb;
 }
 
@@ -272,7 +219,6 @@ static inline void setup_callbacks(struc
  *	@parent: dentry of parent directory, NULL for root directory
  *	@subbuf_size: size of sub-buffers
  *	@n_subbufs: number of sub-buffers
- *	@overwrite: overwrite buffer when full?
  *	@cb: client callback functions
  *
  *	Returns channel pointer if successful, NULL otherwise.
@@ -284,12 +230,11 @@ static inline void setup_callbacks(struc
  */
 struct rchan *relay_open(const char *base_filename,
 			 struct dentry *parent,
-			 unsigned subbuf_size,
-			 unsigned n_subbufs,
-			 int overwrite,
+			 unsigned int subbuf_size,
+			 unsigned int n_subbufs,
 			 struct rchan_callbacks *cb)
 {
-	int i;
+	unsigned int i;
 	struct rchan *chan;
 	char *tmpname;
 
@@ -304,7 +249,6 @@ struct rchan *relay_open(const char *bas
 		return NULL;
 
 	chan->version = RELAYFS_CHANNEL_VERSION;
-	chan->overwrite = overwrite;
 	chan->n_subbufs = n_subbufs;
 	chan->subbuf_size = subbuf_size;
 	chan->alloc_size = FIX_SIZE(subbuf_size * n_subbufs);
@@ -339,35 +283,6 @@ free_chan:
 }
 
 /**
- *	deliver_check - deliver a guaranteed full sub-buffer if applicable
- */
-static inline void deliver_check(struct rchan_buf *buf,
-				 unsigned subbuf_idx)
-{
-	void *subbuf;
-	unsigned full = buf->chan->subbuf_size - buf->padding[subbuf_idx];
-
-	if (buf->commit[subbuf_idx] == full) {
-		subbuf = buf->start + subbuf_idx * buf->chan->subbuf_size;
-		buf->chan->cb->deliver(buf, subbuf_idx, subbuf);
-	}
-}
-
-/**
- *	do_switch - change subbuf pointer and do related bookkeeping
- */
-static inline void do_switch(struct rchan_buf *buf, unsigned new, unsigned old)
-{
-	unsigned start = 0;
-	void *old_data = buf->start + old * buf->chan->subbuf_size;
-
-	buf->data = get_next_subbuf(buf);
-	buf->padding[new] = 0;
-	start = buf->chan->cb->subbuf_start(buf, buf->data, old, old_data);
-	buf->offset = buf->commit[new] = start;
-}
-
-/**
  *	relay_switch_subbuf - switch to a new sub-buffer
  *	@buf: channel buffer
  *	@length: size of current event
@@ -377,45 +292,35 @@ static inline void do_switch(struct rcha
  *	Performs sub-buffer-switch tasks such as invoking callbacks,
  *	updating padding counts, waking up readers, etc.
  */
-unsigned relay_switch_subbuf(struct rchan_buf *buf, unsigned length)
+unsigned int relay_switch_subbuf(struct rchan_buf *buf, unsigned int length)
 {
-	int new, old, produced = atomic_read(&buf->subbufs_produced);
-	unsigned padding;
+	void *old, *new;
+	unsigned int old_subbuf, new_subbuf;
 
 	if (unlikely(length > buf->chan->subbuf_size))
 		goto toobig;
 
-	if (unlikely(atomic_read(&buf->unfull))) {
-		atomic_set(&buf->unfull, 0);
-		new = produced % buf->chan->n_subbufs;
-		old = (produced - 1) % buf->chan->n_subbufs;
-		do_switch(buf, new, old);
-		return 0;
+	if (buf->offset != buf->chan->subbuf_size + 1) {
+		buf->prev_padding = buf->chan->subbuf_size - buf->offset;
+		old_subbuf = buf->subbufs_produced % buf->chan->n_subbufs;
+		buf->padding[old_subbuf] = buf->prev_padding;
+		buf->subbufs_produced++;
+		if (waitqueue_active(&buf->read_wait)) {
+			PREPARE_WORK(&buf->wake_readers, wakeup_readers, buf);
+			schedule_delayed_work(&buf->wake_readers, 1);
+		}
 	}
 
-	if (unlikely(relay_buf_full(buf)))
-		return 0;
-
-	old = produced % buf->chan->n_subbufs;
-	padding = buf->chan->subbuf_size - buf->offset;
-	buf->padding[old] = padding;
-	deliver_check(buf, old);
-	buf->offset = buf->chan->subbuf_size;
-	atomic_inc(&buf->subbufs_produced);
-
-	if (waitqueue_active(&buf->read_wait)) {
-		PREPARE_WORK(&buf->wake_readers, wakeup_readers, buf);
-		schedule_delayed_work(&buf->wake_readers, 1);
-	}
-
-	if (unlikely(relay_buf_full(buf))) {
-		void *old_data = buf->start + old * buf->chan->subbuf_size;
-		buf->chan->cb->buf_full(buf, old, old_data);
+	old = buf->data;
+	new_subbuf = buf->subbufs_produced % buf->chan->n_subbufs;
+	new = buf->start + new_subbuf * buf->chan->subbuf_size;
+	buf->offset = 0;
+	if (!buf->chan->cb->subbuf_start(buf, new, old, buf->prev_padding)) {
+		buf->offset = buf->chan->subbuf_size + 1;
 		return 0;
 	}
-
-	new = (produced + 1) % buf->chan->n_subbufs;
-	do_switch(buf, new, old);
+	buf->data = new;
+	buf->padding[new_subbuf] = 0;
 
 	if (unlikely(length + buf->offset > buf->chan->subbuf_size))
 		goto toobig;
@@ -429,26 +334,6 @@ toobig:
 }
 
 /**
- *	relay_commit - add count bytes to a sub-buffer's commit count
- *	@buf: channel buffer
- *	@reserved: reserved address associated with commit
- *	@count: number of bytes committed
- *
- *	Invokes deliver() callback if sub-buffer is completely written.
- */
-void relay_commit(struct rchan_buf *buf,
-		  void *reserved,
-		  unsigned count)
-{
-	unsigned offset, subbuf_idx;
-
-	offset = reserved - buf->start;
-	subbuf_idx = offset / buf->chan->subbuf_size;
-	buf->commit[subbuf_idx] += count;
-	deliver_check(buf, subbuf_idx);
-}
-
-/**
  *	relay_subbufs_consumed - update the buffer's sub-buffers-consumed count
  *	@chan: the channel
  *	@cpu: the cpu associated with the channel buffer to update
@@ -461,9 +346,10 @@ void relay_commit(struct rchan_buf *buf,
  *	NOTE: kernel clients don't need to call this function if the channel
  *	mode is 'overwrite'.
  */
-void relay_subbufs_consumed(struct rchan *chan, int cpu, int subbufs_consumed)
+void relay_subbufs_consumed(struct rchan *chan,
+			    unsigned int cpu,
+			    unsigned int subbufs_consumed)
 {
-	int produced, consumed;
 	struct rchan_buf *buf;
 
 	if (!chan)
@@ -473,14 +359,9 @@ void relay_subbufs_consumed(struct rchan
 		return;
 
 	buf = chan->buf[cpu];
-	if (relay_buf_full(buf))
-		atomic_set(&buf->unfull, 1);
-
-	atomic_add(subbufs_consumed, &buf->subbufs_consumed);
-	produced = atomic_read(&buf->subbufs_produced);
-	consumed = atomic_read(&buf->subbufs_consumed);
-	if (consumed > produced)
-		atomic_set(&buf->subbufs_consumed, produced);
+	buf->subbufs_consumed += subbufs_consumed;
+	if (buf->subbufs_consumed > buf->subbufs_produced)
+		buf->subbufs_consumed = buf->subbufs_produced;
 }
 
 /**
@@ -502,7 +383,7 @@ void relay_destroy_channel(struct kref *
  */
 void relay_close(struct rchan *chan)
 {
-	int i;
+	unsigned int i;
 
 	if (!chan)
 		return;
@@ -524,7 +405,7 @@ void relay_close(struct rchan *chan)
  */
 void relay_flush(struct rchan *chan)
 {
-	int i;
+	unsigned int i;
 
 	if (!chan)
 		return;
@@ -541,5 +422,5 @@ EXPORT_SYMBOL_GPL(relay_close);
 EXPORT_SYMBOL_GPL(relay_flush);
 EXPORT_SYMBOL_GPL(relay_reset);
 EXPORT_SYMBOL_GPL(relay_subbufs_consumed);
-EXPORT_SYMBOL_GPL(relay_commit);
 EXPORT_SYMBOL_GPL(relay_switch_subbuf);
+EXPORT_SYMBOL_GPL(relay_buf_full);
diff -urpN -X dontdiff linux-2.6.13-rc4-mm1/include/linux/relayfs_fs.h linux-2.6.13-rc4-mm1-cur/include/linux/relayfs_fs.h
--- linux-2.6.13-rc4-mm1/include/linux/relayfs_fs.h	2005-08-05 10:14:35.000000000 -0500
+++ linux-2.6.13-rc4-mm1-cur/include/linux/relayfs_fs.h	2005-08-05 10:17:30.000000000 -0500
@@ -22,7 +22,7 @@
 /*
  * Tracks changes to rchan_buf struct
  */
-#define RELAYFS_CHANNEL_VERSION		3
+#define RELAYFS_CHANNEL_VERSION		4
 
 /*
  * Per-cpu relay channel buffer
@@ -31,20 +31,19 @@ struct rchan_buf
 {
 	void *start;			/* start of channel buffer */
 	void *data;			/* start of current sub-buffer */
-	unsigned offset;		/* current offset into sub-buffer */
-	atomic_t subbufs_produced;	/* count of sub-buffers produced */
-	atomic_t subbufs_consumed;	/* count of sub-buffers consumed */
-	atomic_t unfull;		/* state has gone from full to not */
+	unsigned int offset;		/* current offset into sub-buffer */
+	unsigned int subbufs_produced;	/* count of sub-buffers produced */
+	unsigned int subbufs_consumed;	/* count of sub-buffers consumed */
 	struct rchan *chan;		/* associated channel */
 	wait_queue_head_t read_wait;	/* reader wait queue */
 	struct work_struct wake_readers; /* reader wake-up work struct */
 	struct dentry *dentry;		/* channel file dentry */
 	struct kref kref;		/* channel buffer refcount */
 	struct page **page_array;	/* array of current buffer pages */
-	int page_count;			/* number of current buffer pages */
+	unsigned int page_count;	/* number of current buffer pages */
+	unsigned int finalized;		/* buffer has been finalized */
 	unsigned *padding;		/* padding counts per sub-buffer */
-	unsigned *commit;		/* commit counts per sub-buffer */
-	int finalized;			/* buffer has been finalized */
+	unsigned int prev_padding;	/* temporary variable */
 } ____cacheline_aligned;
 
 /*
@@ -53,10 +52,9 @@ struct rchan_buf
 struct rchan
 {
 	u32 version;			/* the version of this struct */
-	unsigned subbuf_size;		/* sub-buffer size */
-	unsigned n_subbufs;		/* number of sub-buffers per buffer */
-	unsigned alloc_size;		/* total buffer size allocated */
-	int overwrite;			/* overwrite buffer when full? */
+	unsigned int subbuf_size;	/* sub-buffer size */
+	unsigned int n_subbufs;		/* number of sub-buffers per buffer */
+	unsigned int alloc_size;	/* total buffer size allocated */
 	struct rchan_callbacks *cb;	/* client callbacks */
 	struct kref kref;		/* channel refcount */
 	void *private_data;		/* for user-defined data */
@@ -86,32 +84,23 @@ struct rchan_callbacks
 	 * subbuf_start - called on buffer-switch to a new sub-buffer
 	 * @buf: the channel buffer containing the new sub-buffer
 	 * @subbuf: the start of the new sub-buffer
-	 * @prev_subbuf_idx: the previous sub-buffer's index
 	 * @prev_subbuf: the start of the previous sub-buffer
+	 * @prev_padding: unused space at the end of previous sub-buffer
 	 *
-	 * The client should return the number of bytes it reserves at
-	 * the beginning of the sub-buffer, 0 if none.
+	 * The client should return 1 to continue logging, 0 to stop
+	 * logging.
 	 *
 	 * NOTE: subbuf_start will also be invoked when the buffer is
 	 *       created, so that the first sub-buffer can be initialized
 	 *       if necessary.  In this case, prev_subbuf will be NULL.
+	 *
+	 * NOTE: the client can reserve bytes at the beginning of the new
+	 *       sub-buffer by calling subbuf_start_reserve() in this callback.
 	 */
 	int (*subbuf_start) (struct rchan_buf *buf,
 			     void *subbuf,
-			     unsigned prev_subbuf_idx,
-			     void *prev_subbuf);
-
-	/*
-	 * deliver - deliver a guaranteed full sub-buffer to client
-	 * @buf: the channel buffer containing the sub-buffer
-	 * @subbuf_idx: the sub-buffer's index
-	 * @subbuf: the start of the new sub-buffer
-	 *
-	 * Only works if relay_commit is also used
-	 */
-	void (*deliver) (struct rchan_buf *buf,
-			 unsigned subbuf_idx,
-			 void *subbuf);
+			     void *prev_subbuf,
+			     unsigned int prev_padding);
 
 	/*
 	 * buf_mapped - relayfs buffer mmap notification
@@ -132,18 +121,6 @@ struct rchan_callbacks
 	 */
         void (*buf_unmapped)(struct rchan_buf *buf,
 			     struct file *filp);
-
-	/*
-	 * buf_full - relayfs buffer full notification
-	 * @buf: the channel channel buffer
-	 * @subbuf_idx: the current sub-buffer's index
-	 * @subbuf: the start of the current sub-buffer
-	 *
-	 * Called when a relayfs buffer becomes full
-	 */
-        void (*buf_full)(struct rchan_buf *buf,
-			 unsigned subbuf_idx,
-			 void *subbuf);
 };
 
 /*
@@ -152,21 +129,19 @@ struct rchan_callbacks
 
 struct rchan *relay_open(const char *base_filename,
 			 struct dentry *parent,
-			 unsigned subbuf_size,
-			 unsigned n_subbufs,
-			 int overwrite,
+			 unsigned int subbuf_size,
+			 unsigned int n_subbufs,
 			 struct rchan_callbacks *cb);
 extern void relay_close(struct rchan *chan);
 extern void relay_flush(struct rchan *chan);
 extern void relay_subbufs_consumed(struct rchan *chan,
-				   int cpu,
-				   int subbufs_consumed);
+				   unsigned int cpu,
+				   unsigned int consumed);
 extern void relay_reset(struct rchan *chan);
-extern unsigned relay_switch_subbuf(struct rchan_buf *buf,
-				    unsigned length);
-extern void relay_commit(struct rchan_buf *buf,
-			 void *reserved,
-			 unsigned count);
+extern int relay_buf_full(struct rchan_buf *buf);
+
+extern unsigned int relay_switch_subbuf(struct rchan_buf *buf,
+					unsigned int length);
 extern struct dentry *relayfs_create_dir(const char *name,
 					 struct dentry *parent);
 extern int relayfs_remove_dir(struct dentry *dentry);
@@ -186,7 +161,7 @@ extern int relayfs_remove_dir(struct den
  */
 static inline void relay_write(struct rchan *chan,
 			       const void *data,
-			       unsigned length)
+			       unsigned int length)
 {
 	unsigned long flags;
 	struct rchan_buf *buf;
@@ -214,7 +189,7 @@ static inline void relay_write(struct rc
  */
 static inline void __relay_write(struct rchan *chan,
 				 const void *data,
-				 unsigned length)
+				 unsigned int length)
 {
 	struct rchan_buf *buf;
 
@@ -253,15 +228,26 @@ static inline void *relay_reserve(struct
 	return reserved;
 }
 
+/**
+ *	subbuf_start_reserve - reserve bytes at the start of a sub-buffer
+ *	@buf: relay channel buffer
+ *	@length: number of bytes to reserve
+ *
+ *	Helper function used to reserve bytes at the beginning of
+ *	a sub-buffer in the subbuf_start() callback.
+ */
+static inline void subbuf_start_reserve(struct rchan_buf *buf,
+					unsigned int length)
+{
+	BUG_ON(length >= buf->chan->subbuf_size - 1);
+	buf->offset = length;
+}
+
 /*
  * exported relayfs file operations, fs/relayfs/inode.c
  */
 
 extern struct file_operations relayfs_file_operations;
-extern int relayfs_open(struct inode *inode, struct file *filp);
-extern unsigned int relayfs_poll(struct file *filp, poll_table *wait);
-extern int relayfs_mmap(struct file *filp, struct vm_area_struct *vma);
-extern int relayfs_release(struct inode *inode, struct file *filp);
 
 #endif /* _LINUX_RELAYFS_FS_H */
 


