Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262995AbVHERHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262995AbVHERHR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 13:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbVHERHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 13:07:17 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:33448 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262995AbVHERHC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 13:07:02 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17139.40109.278366.876492@tut.ibm.com>
Date: Fri, 5 Aug 2005 12:06:53 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Tom Zanussi <zanussi@us.ibm.com>, linux-kernel@vger.kernel.org,
       karim@opersys.com, prasadav@us.ibm.com
Subject: Re: [-mm patch] relayfs: add read() support
In-Reply-To: <20050805005753.031db798.akpm@osdl.org>
References: <17138.53203.430849.147593@tut.ibm.com>
	<20050805005753.031db798.akpm@osdl.org>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > 
 > The use of `unsigned int' in here will cause >4G reads to fail on 64-bit
 > platforms.  I think you want size_t throughout.

OK, here's a patch that does that.  It also switches to size_t for the
buffer-related sizes elsewhere in relayfs.

This applies on top of the previous patches.

Tom

Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>

diff -urpN -X dontdiff linux-2.6.13-rc4-mm1-cur-prev/fs/relayfs/buffers.c linux-2.6.13-rc4-mm1-cur/fs/relayfs/buffers.c
--- linux-2.6.13-rc4-mm1-cur-prev/fs/relayfs/buffers.c	2005-08-05 10:17:30.000000000 -0500
+++ linux-2.6.13-rc4-mm1-cur/fs/relayfs/buffers.c	2005-08-06 11:33:56.000000000 -0500
@@ -137,7 +137,7 @@ struct rchan_buf *relay_create_buf(struc
 	if (!buf)
 		return NULL;
 
-	buf->padding = kmalloc(chan->n_subbufs * sizeof(unsigned *), GFP_KERNEL);
+	buf->padding = kmalloc(chan->n_subbufs * sizeof(size_t *), GFP_KERNEL);
 	if (!buf->padding)
 		goto free_buf;
 
diff -urpN -X dontdiff linux-2.6.13-rc4-mm1-cur-prev/fs/relayfs/inode.c linux-2.6.13-rc4-mm1-cur/fs/relayfs/inode.c
--- linux-2.6.13-rc4-mm1-cur-prev/fs/relayfs/inode.c	2005-08-05 10:17:47.000000000 -0500
+++ linux-2.6.13-rc4-mm1-cur/fs/relayfs/inode.c	2005-08-06 11:36:02.000000000 -0500
@@ -301,15 +301,15 @@ static int relayfs_release(struct inode 
  *	position of the first actually available byte, otherwise
  *	return the original value.
  */
-static inline unsigned int relayfs_read_start(unsigned int read_pos,
-					      unsigned int avail,
-					      unsigned int start_subbuf,
-					      struct rchan_buf *buf)
-{
-	unsigned int read_subbuf, adj_read_subbuf;
-	unsigned int padding, padding_start, padding_end;
-	unsigned int subbuf_size = buf->chan->subbuf_size;
-	unsigned int n_subbufs = buf->chan->n_subbufs;
+static inline size_t relayfs_read_start(size_t read_pos,
+					size_t avail,
+					size_t start_subbuf,
+					struct rchan_buf *buf)
+{
+	size_t read_subbuf, adj_read_subbuf;
+	size_t padding, padding_start, padding_end;
+	size_t subbuf_size = buf->chan->subbuf_size;
+	size_t n_subbufs = buf->chan->n_subbufs;
 	
 	read_subbuf = read_pos / subbuf_size;
 	adj_read_subbuf = (read_subbuf + start_subbuf) % n_subbufs;
@@ -336,15 +336,15 @@ static inline unsigned int relayfs_read_
  *	most, 1 sub-buffer can be read at a time.
  *	
  */
-static inline unsigned int relayfs_read_end(unsigned int read_pos,
-					    unsigned int avail,
-					    unsigned int start_subbuf,
-					    struct rchan_buf *buf)
-{
-	unsigned int padding, read_endpos, buf_offset;
-	unsigned int read_subbuf, adj_read_subbuf;
-	unsigned int subbuf_size = buf->chan->subbuf_size;
-	unsigned int n_subbufs = buf->chan->n_subbufs;
+static inline size_t relayfs_read_end(size_t read_pos,
+				      size_t avail,
+				      size_t start_subbuf,
+				      struct rchan_buf *buf)
+{
+	size_t padding, read_endpos, buf_offset;
+	size_t read_subbuf, adj_read_subbuf;
+	size_t subbuf_size = buf->chan->subbuf_size;
+	size_t n_subbufs = buf->chan->n_subbufs;
 
 	buf_offset = buf->offset > subbuf_size ? subbuf_size : buf->offset;
 	read_subbuf = read_pos / subbuf_size;
@@ -369,12 +369,12 @@ static inline unsigned int relayfs_read_
  *	written to, otherwise it's the beginning of sub-buffer 0.
  *	
  */
-static inline unsigned int relayfs_read_avail(struct rchan_buf *buf,
-					      unsigned int *start_subbuf)
+static inline size_t relayfs_read_avail(struct rchan_buf *buf,
+					size_t *start_subbuf)
 {
-	unsigned int avail, complete_subbufs, cur_subbuf, buf_offset;
-	unsigned int subbuf_size = buf->chan->subbuf_size;
-	unsigned int n_subbufs = buf->chan->n_subbufs;
+	size_t avail, complete_subbufs, cur_subbuf, buf_offset;
+	size_t subbuf_size = buf->chan->subbuf_size;
+	size_t n_subbufs = buf->chan->n_subbufs;
 
 	buf_offset = buf->offset > subbuf_size ? subbuf_size : buf->offset;
 	
@@ -416,8 +416,8 @@ static ssize_t relayfs_read(struct file 
 {
 	struct inode *inode = filp->f_dentry->d_inode;
 	struct rchan_buf *buf = RELAYFS_I(inode)->buf;
-	unsigned int read_start, read_end, avail, start_subbuf;
-	unsigned int buf_size = buf->chan->subbuf_size * buf->chan->n_subbufs;
+	size_t read_start, read_end, avail, start_subbuf;
+	size_t buf_size = buf->chan->subbuf_size * buf->chan->n_subbufs;
 	void *from;
 
 	avail = relayfs_read_avail(buf, &start_subbuf);
diff -urpN -X dontdiff linux-2.6.13-rc4-mm1-cur-prev/fs/relayfs/relay.c linux-2.6.13-rc4-mm1-cur/fs/relayfs/relay.c
--- linux-2.6.13-rc4-mm1-cur-prev/fs/relayfs/relay.c	2005-08-05 10:17:30.000000000 -0500
+++ linux-2.6.13-rc4-mm1-cur/fs/relayfs/relay.c	2005-08-06 11:20:10.000000000 -0500
@@ -37,7 +37,7 @@ int relay_buf_empty(struct rchan_buf *bu
  */
 int relay_buf_full(struct rchan_buf *buf)
 {
-	unsigned int ready = buf->subbufs_produced - buf->subbufs_consumed;
+	size_t ready = buf->subbufs_produced - buf->subbufs_consumed;
 	return (ready >= buf->chan->n_subbufs) ? 1 : 0;
 }
 
@@ -56,7 +56,7 @@ int relay_buf_full(struct rchan_buf *buf
 static int subbuf_start_default_callback (struct rchan_buf *buf,
 					  void *subbuf,
 					  void *prev_subbuf,
-					  unsigned int prev_padding)
+					  size_t prev_padding)
 {
 	return 1;
 }
@@ -107,7 +107,7 @@ static void wakeup_readers(void *private
  */
 static inline void __relay_reset(struct rchan_buf *buf, unsigned int init)
 {
-	unsigned int i;
+	size_t i;
 	
 	if (init) {
 		init_waitqueue_head(&buf->read_wait);
@@ -230,8 +230,8 @@ static inline void setup_callbacks(struc
  */
 struct rchan *relay_open(const char *base_filename,
 			 struct dentry *parent,
-			 unsigned int subbuf_size,
-			 unsigned int n_subbufs,
+			 size_t subbuf_size,
+			 size_t n_subbufs,
 			 struct rchan_callbacks *cb)
 {
 	unsigned int i;
@@ -292,10 +292,10 @@ free_chan:
  *	Performs sub-buffer-switch tasks such as invoking callbacks,
  *	updating padding counts, waking up readers, etc.
  */
-unsigned int relay_switch_subbuf(struct rchan_buf *buf, unsigned int length)
+size_t relay_switch_subbuf(struct rchan_buf *buf, size_t length)
 {
 	void *old, *new;
-	unsigned int old_subbuf, new_subbuf;
+	size_t old_subbuf, new_subbuf;
 
 	if (unlikely(length > buf->chan->subbuf_size))
 		goto toobig;
@@ -348,7 +348,7 @@ toobig:
  */
 void relay_subbufs_consumed(struct rchan *chan,
 			    unsigned int cpu,
-			    unsigned int subbufs_consumed)
+			    size_t subbufs_consumed)
 {
 	struct rchan_buf *buf;
 
diff -urpN -X dontdiff linux-2.6.13-rc4-mm1-cur-prev/include/linux/relayfs_fs.h linux-2.6.13-rc4-mm1-cur/include/linux/relayfs_fs.h
--- linux-2.6.13-rc4-mm1-cur-prev/include/linux/relayfs_fs.h	2005-08-05 10:17:30.000000000 -0500
+++ linux-2.6.13-rc4-mm1-cur/include/linux/relayfs_fs.h	2005-08-06 11:33:16.000000000 -0500
@@ -31,9 +31,9 @@ struct rchan_buf
 {
 	void *start;			/* start of channel buffer */
 	void *data;			/* start of current sub-buffer */
-	unsigned int offset;		/* current offset into sub-buffer */
-	unsigned int subbufs_produced;	/* count of sub-buffers produced */
-	unsigned int subbufs_consumed;	/* count of sub-buffers consumed */
+	size_t offset;			/* current offset into sub-buffer */
+	size_t subbufs_produced;	/* count of sub-buffers produced */
+	size_t subbufs_consumed;	/* count of sub-buffers consumed */
 	struct rchan *chan;		/* associated channel */
 	wait_queue_head_t read_wait;	/* reader wait queue */
 	struct work_struct wake_readers; /* reader wake-up work struct */
@@ -42,8 +42,8 @@ struct rchan_buf
 	struct page **page_array;	/* array of current buffer pages */
 	unsigned int page_count;	/* number of current buffer pages */
 	unsigned int finalized;		/* buffer has been finalized */
-	unsigned *padding;		/* padding counts per sub-buffer */
-	unsigned int prev_padding;	/* temporary variable */
+	size_t *padding;		/* padding counts per sub-buffer */
+	size_t prev_padding;		/* temporary variable */
 } ____cacheline_aligned;
 
 /*
@@ -52,9 +52,9 @@ struct rchan_buf
 struct rchan
 {
 	u32 version;			/* the version of this struct */
-	unsigned int subbuf_size;	/* sub-buffer size */
-	unsigned int n_subbufs;		/* number of sub-buffers per buffer */
-	unsigned int alloc_size;	/* total buffer size allocated */
+	size_t subbuf_size;		/* sub-buffer size */
+	size_t n_subbufs;		/* number of sub-buffers per buffer */
+	size_t alloc_size;		/* total buffer size allocated */
 	struct rchan_callbacks *cb;	/* client callbacks */
 	struct kref kref;		/* channel refcount */
 	void *private_data;		/* for user-defined data */
@@ -100,7 +100,7 @@ struct rchan_callbacks
 	int (*subbuf_start) (struct rchan_buf *buf,
 			     void *subbuf,
 			     void *prev_subbuf,
-			     unsigned int prev_padding);
+			     size_t prev_padding);
 
 	/*
 	 * buf_mapped - relayfs buffer mmap notification
@@ -129,19 +129,19 @@ struct rchan_callbacks
 
 struct rchan *relay_open(const char *base_filename,
 			 struct dentry *parent,
-			 unsigned int subbuf_size,
-			 unsigned int n_subbufs,
+			 size_t subbuf_size,
+			 size_t n_subbufs,
 			 struct rchan_callbacks *cb);
 extern void relay_close(struct rchan *chan);
 extern void relay_flush(struct rchan *chan);
 extern void relay_subbufs_consumed(struct rchan *chan,
 				   unsigned int cpu,
-				   unsigned int consumed);
+				   size_t consumed);
 extern void relay_reset(struct rchan *chan);
 extern int relay_buf_full(struct rchan_buf *buf);
 
-extern unsigned int relay_switch_subbuf(struct rchan_buf *buf,
-					unsigned int length);
+extern size_t relay_switch_subbuf(struct rchan_buf *buf,
+				  size_t length);
 extern struct dentry *relayfs_create_dir(const char *name,
 					 struct dentry *parent);
 extern int relayfs_remove_dir(struct dentry *dentry);
@@ -161,7 +161,7 @@ extern int relayfs_remove_dir(struct den
  */
 static inline void relay_write(struct rchan *chan,
 			       const void *data,
-			       unsigned int length)
+			       size_t length)
 {
 	unsigned long flags;
 	struct rchan_buf *buf;
@@ -189,7 +189,7 @@ static inline void relay_write(struct rc
  */
 static inline void __relay_write(struct rchan *chan,
 				 const void *data,
-				 unsigned int length)
+				 size_t length)
 {
 	struct rchan_buf *buf;
 
@@ -212,7 +212,7 @@ static inline void __relay_write(struct 
  *	Does not protect the buffer at all - caller must provide
  *	appropriate synchronization.
  */
-static inline void *relay_reserve(struct rchan *chan, unsigned length)
+static inline void *relay_reserve(struct rchan *chan, size_t length)
 {
 	void *reserved;
 	struct rchan_buf *buf = chan->buf[smp_processor_id()];
@@ -237,7 +237,7 @@ static inline void *relay_reserve(struct
  *	a sub-buffer in the subbuf_start() callback.
  */
 static inline void subbuf_start_reserve(struct rchan_buf *buf,
-					unsigned int length)
+					size_t length)
 {
 	BUG_ON(length >= buf->chan->subbuf_size - 1);
 	buf->offset = length;


