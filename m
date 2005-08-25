Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbVHYVYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbVHYVYm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 17:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbVHYVYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 17:24:42 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:32963 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751490AbVHYVYm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 17:24:42 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17166.14023.9399.33806@tut.ibm.com>
Date: Thu, 25 Aug 2005 16:23:19 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, axboe@suse.de, karim@opersys.com
Subject: [-mm patch] relayfs: upgraded read() implementation
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The current relayfs read implementation works fine, but was designed
to be used mainly for 'draining' the buffer after a tracing run.  It
turns out that people really want to be able to read from the buffer
during a live trace, for example the blktrace application submitted
recently:

http://marc.theaimsgroup.com/?l=linux-kernel&m=112480046405961&w=2

Here's an improved read implementation for relayfs which allows for
that.

This version has been tested pretty thoroughly, using both the
blktrace application and a new example I added to the relay-apps
tarball called 'readtest' which is basically a unit test for the read
functionality.  All the tests I've come up with have passed and it
looks pretty solid at this point.  Here's a link to the test code:

http://prdownloads.sourceforge.net/relayfs/relay-apps-0.8.tar.gz?download

Andrew, please apply.

Thanks,

Tom


Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>

diff -urpN -X dontdiff linux-2.6.13-rc6-mm2/Documentation/filesystems/relayfs.txt linux-2.6.13-rc6-mm2-cur/Documentation/filesystems/relayfs.txt
--- linux-2.6.13-rc6-mm2/Documentation/filesystems/relayfs.txt	2005-08-25 19:28:59.000000000 -0500
+++ linux-2.6.13-rc6-mm2-cur/Documentation/filesystems/relayfs.txt	2005-08-25 17:07:48.000000000 -0500
@@ -82,10 +82,15 @@ mmap()	 results in channel buffer being 
 	 memory space. Note that you can't do a partial mmap - you must
 	 map the entire file, which is NRBUF * SUBBUFSIZE.
 
-read()	 read the contents of a channel buffer.  If there are active
-	 channel writers, results may be unpredictable - users should
-	 make sure that all logging to the channel has ended before
-	 using read().
+read()	 read the contents of a channel buffer.  The bytes read are
+	 'consumed' by the reader i.e. they won't be available again
+	 to subsequent reads.  If the channel is being used in
+	 no-overwrite mode (the default), it can be read at any time
+	 even if there's an active kernel writer.  If the channel is
+	 being used in overwrite mode and there are active channel
+	 writers, results may be unpredictable - users should make
+	 sure that all logging to the channel has ended before using
+	 read() with overwrite mode.
 
 poll()	 POLLIN/POLLRDNORM/POLLERR supported.  User applications are
 	 notified when sub-buffer boundaries are crossed.
@@ -256,8 +261,8 @@ consulted.
 
 The default subbuf_start() implementation, used if the client doesn't
 define any callbacks, or doesn't define the subbuf_start() callback,
-implements the simplest possible 'overwrite' mode i.e. it does nothing
-but return 1.
+implements the simplest possible 'no-overwrite' mode i.e. it does
+nothing but return 0.
 
 Header information can be reserved at the beginning of each sub-buffer
 by calling the subbuf_start_reserve() helper function from within the
diff -urpN -X dontdiff linux-2.6.13-rc6-mm2/fs/relayfs/inode.c linux-2.6.13-rc6-mm2-cur/fs/relayfs/inode.c
--- linux-2.6.13-rc6-mm2/fs/relayfs/inode.c	2005-08-25 19:29:02.000000000 -0500
+++ linux-2.6.13-rc6-mm2-cur/fs/relayfs/inode.c	2005-08-25 18:21:31.000000000 -0500
@@ -295,101 +295,143 @@ static int relayfs_release(struct inode 
 }
 
 /**
- *	relayfs_read_start - find the first available byte to read
- *
- *	If the read_pos is in the middle of padding, return the
- *	position of the first actually available byte, otherwise
- *	return the original value.
+ *	relayfs_read_consume - update the consumed count for the buffer
  */
-static inline size_t relayfs_read_start(size_t read_pos,
-					size_t avail,
-					size_t start_subbuf,
-					struct rchan_buf *buf)
+static void relayfs_read_consume(struct rchan_buf *buf,
+				 size_t read_pos,
+				 size_t bytes_consumed)
 {
-	size_t read_subbuf, adj_read_subbuf;
-	size_t padding, padding_start, padding_end;
 	size_t subbuf_size = buf->chan->subbuf_size;
 	size_t n_subbufs = buf->chan->n_subbufs;
+	size_t read_subbuf;
 
-	read_subbuf = read_pos / subbuf_size;
-	adj_read_subbuf = (read_subbuf + start_subbuf) % n_subbufs;
+	if (buf->bytes_consumed + bytes_consumed > subbuf_size) {
+		relay_subbufs_consumed(buf->chan, buf->cpu, 1);
+		buf->bytes_consumed = 0;
+	}
 
-	if ((read_subbuf + 1) * subbuf_size <= avail) {
-		padding = buf->padding[adj_read_subbuf];
-		padding_start = (read_subbuf + 1) * subbuf_size - padding;
-		padding_end = (read_subbuf + 1) * subbuf_size;
-		if (read_pos >= padding_start && read_pos < padding_end) {
-			read_subbuf = (read_subbuf + 1) % n_subbufs;
-			read_pos = read_subbuf * subbuf_size;
+	buf->bytes_consumed += bytes_consumed;
+	read_subbuf = read_pos / buf->chan->subbuf_size;
+	if (buf->bytes_consumed + buf->padding[read_subbuf] == subbuf_size) {
+		if ((read_subbuf == buf->subbufs_produced % n_subbufs) &&
+		    (buf->offset == subbuf_size))
+			return;
+		relay_subbufs_consumed(buf->chan, buf->cpu, 1);
+		buf->bytes_consumed = 0;
+	}
+}
+
+/**
+ *	relayfs_read_avail - boolean, are there unconsumed bytes available?
+ */
+static int relayfs_read_avail(struct rchan_buf *buf, size_t read_pos)
+{
+	size_t bytes_produced, bytes_consumed, write_offset;
+	size_t subbuf_size = buf->chan->subbuf_size;
+	size_t n_subbufs = buf->chan->n_subbufs;
+	size_t produced = buf->subbufs_produced % n_subbufs;
+	size_t consumed = buf->subbufs_consumed % n_subbufs;
+
+	write_offset = buf->offset > subbuf_size ? subbuf_size : buf->offset;
+
+	if (consumed > produced) {
+		if ((produced > n_subbufs) &&
+		    (produced + n_subbufs - consumed <= n_subbufs))
+			produced += n_subbufs;
+	} else if (consumed == produced) {
+		if (buf->offset > subbuf_size) {
+			produced += n_subbufs;
+			if (buf->subbufs_produced == buf->subbufs_consumed)
+				consumed += n_subbufs;
 		}
 	}
 
-	return read_pos;
+	if (buf->offset > subbuf_size)
+		bytes_produced = (produced - 1) * subbuf_size + write_offset;
+	else
+		bytes_produced = produced * subbuf_size + write_offset;
+	bytes_consumed = consumed * subbuf_size + buf->bytes_consumed;
+
+	if (bytes_produced == bytes_consumed)
+		return 0;
+
+	relayfs_read_consume(buf, read_pos, 0);
+
+	return 1;
 }
 
 /**
- *	relayfs_read_end - return the end of available bytes to read
- *
- *	If the read_pos is in the middle of a full sub-buffer, return
- *	the padding-adjusted end of that sub-buffer, otherwise return
- *	the position after the last byte written to the buffer.  At
- *	most, 1 sub-buffer can be read at a time.
- *
+ *	relayfs_read_subbuf_avail - return bytes available in sub-buffer
  */
-static inline size_t relayfs_read_end(size_t read_pos,
-				      size_t avail,
-				      size_t start_subbuf,
-				      struct rchan_buf *buf)
+static size_t relayfs_read_subbuf_avail(size_t read_pos,
+					struct rchan_buf *buf)
 {
-	size_t padding, read_endpos, buf_offset;
-	size_t read_subbuf, adj_read_subbuf;
+	size_t padding, avail = 0;
+	size_t read_subbuf, read_offset, write_subbuf, write_offset;
 	size_t subbuf_size = buf->chan->subbuf_size;
-	size_t n_subbufs = buf->chan->n_subbufs;
 
-	buf_offset = buf->offset > subbuf_size ? subbuf_size : buf->offset;
+	write_subbuf = (buf->data - buf->start) / subbuf_size;
+	write_offset = buf->offset > subbuf_size ? subbuf_size : buf->offset;
 	read_subbuf = read_pos / subbuf_size;
-	adj_read_subbuf = (read_subbuf + start_subbuf) % n_subbufs;
+	read_offset = read_pos % subbuf_size;
+	padding = buf->padding[read_subbuf];
 
-	if ((read_subbuf + 1) * subbuf_size <= avail) {
-		padding = buf->padding[adj_read_subbuf];
-		read_endpos = (read_subbuf + 1) * subbuf_size - padding;
+	if (read_subbuf == write_subbuf) {
+		if (read_offset + padding < write_offset)
+			avail = write_offset - (read_offset + padding);
 	} else
-		read_endpos = read_subbuf * subbuf_size + buf_offset;
+		avail = (subbuf_size - padding) - read_offset;
 
-	return read_endpos;
+	return avail;
 }
 
 /**
- *	relayfs_read_avail - return total available along with buffer start
- *
- *	Because buffers are circular, the 'beginning' of the buffer
- *	depends on where the buffer was last written.  If the writer
- *	has cycled around the buffer, the beginning is defined to be
- *	the beginning of the sub-buffer following the last sub-buffer
- *	written to, otherwise it's the beginning of sub-buffer 0.
+ *	relayfs_read_start_pos - find the first available byte to read
  *
+ *	If the read_pos is in the middle of padding, return the
+ *	position of the first actually available byte, otherwise
+ *	return the original value.
  */
-static inline size_t relayfs_read_avail(struct rchan_buf *buf,
-					size_t *start_subbuf)
+static size_t relayfs_read_start_pos(size_t read_pos,
+				     struct rchan_buf *buf)
 {
-	size_t avail, complete_subbufs, cur_subbuf, buf_offset;
+	size_t read_subbuf, padding, padding_start, padding_end;
 	size_t subbuf_size = buf->chan->subbuf_size;
 	size_t n_subbufs = buf->chan->n_subbufs;
+	
+	read_subbuf = read_pos / subbuf_size;
+	padding = buf->padding[read_subbuf];
+	padding_start = (read_subbuf + 1) * subbuf_size - padding;
+	padding_end = (read_subbuf + 1) * subbuf_size;
+	if (read_pos >= padding_start && read_pos < padding_end) {
+		read_subbuf = (read_subbuf + 1) % n_subbufs;
+		read_pos = read_subbuf * subbuf_size;
+	}
 
-	buf_offset = buf->offset > subbuf_size ? subbuf_size : buf->offset;
+	return read_pos;
+}
 
-	if (buf->subbufs_produced >= n_subbufs) {
-		complete_subbufs = n_subbufs - 1;
-		cur_subbuf = (buf->data - buf->start) / subbuf_size;
-		*start_subbuf = (cur_subbuf + 1) % n_subbufs;
-	} else {
-		complete_subbufs = buf->subbufs_produced;
-		*start_subbuf = 0;
-	}
+/**
+ *	relayfs_read_end_pos - return the new read position
+ */
+static size_t relayfs_read_end_pos(struct rchan_buf *buf,
+				   size_t read_pos,
+				   size_t count)
+{
+	size_t read_subbuf, padding, end_pos;
+	size_t subbuf_size = buf->chan->subbuf_size;
+	size_t n_subbufs = buf->chan->n_subbufs;
 
-	avail = complete_subbufs * subbuf_size + buf_offset;
+	read_subbuf = read_pos / subbuf_size;
+	padding = buf->padding[read_subbuf];
+	if (read_pos % subbuf_size + count + padding == subbuf_size)
+		end_pos = (read_subbuf + 1) * subbuf_size;
+	else
+		end_pos = read_pos + count;
+	if (end_pos >= subbuf_size * n_subbufs)
+		end_pos = 0;
 
-	return avail;
+	return end_pos;
 }
 
 /**
@@ -401,13 +443,6 @@ static inline size_t relayfs_read_avail(
  *
  *	Reads count bytes or the number of bytes available in the
  *	current sub-buffer being read, whichever is smaller.
- *
- *	NOTE: The results of reading a relayfs file which is currently
- *	being written to are undefined.  This is because the buffer is
- *	circular and an active writer in the kernel could be
- *	overwriting the data currently being read.  Therefore read()
- *	is mainly useful for reading the contents of a buffer after
- *	logging has completed.
  */
 static ssize_t relayfs_read(struct file *filp,
 			    char __user *buffer,
@@ -416,33 +451,30 @@ static ssize_t relayfs_read(struct file 
 {
 	struct inode *inode = filp->f_dentry->d_inode;
 	struct rchan_buf *buf = RELAYFS_I(inode)->buf;
-	size_t read_start, read_end, avail, start_subbuf;
-	size_t buf_size = buf->chan->subbuf_size * buf->chan->n_subbufs;
+	size_t read_start, avail;
+	ssize_t ret = 0;
 	void *from;
 
-	avail = relayfs_read_avail(buf, &start_subbuf);
-	if (*ppos >= avail)
-		return 0;
-
-	read_start = relayfs_read_start(*ppos, avail, start_subbuf, buf);
-	if (read_start == 0 && *ppos)
-		return 0;
-
-	read_end = relayfs_read_end(read_start, avail, start_subbuf, buf);
-	if (read_end == read_start)
-		return 0;
-
-	from = buf->start + start_subbuf * buf->chan->subbuf_size + read_start;
-	if (from >= buf->start + buf_size)
-		from -= buf_size;
-
-	count = min(count, read_end - read_start);
-	if (copy_to_user(buffer, from, count))
-		return -EFAULT;
-
-	*ppos = read_start + count;
-
-	return count;
+	down(&inode->i_sem);
+	if(!relayfs_read_avail(buf, *ppos))
+		goto out;
+
+	read_start = relayfs_read_start_pos(*ppos, buf);
+	avail = relayfs_read_subbuf_avail(read_start, buf);
+	if (!avail)
+		goto out;
+	
+	from = buf->start + read_start;
+	ret = count = min(count, avail);
+	if (copy_to_user(buffer, from, count)) {
+		ret = -EFAULT;
+		goto out;
+	}
+	relayfs_read_consume(buf, read_start, count);
+	*ppos = relayfs_read_end_pos(buf, read_start, count);
+out:
+	up(&inode->i_sem);
+	return ret;
 }
 
 /**
@@ -481,6 +513,7 @@ struct file_operations relayfs_file_oper
 	.poll		= relayfs_poll,
 	.mmap		= relayfs_mmap,
 	.read		= relayfs_read,
+	.llseek		= no_llseek,
 	.release	= relayfs_release,
 };
 
diff -urpN -X dontdiff linux-2.6.13-rc6-mm2/fs/relayfs/relay.c linux-2.6.13-rc6-mm2-cur/fs/relayfs/relay.c
--- linux-2.6.13-rc6-mm2/fs/relayfs/relay.c	2005-08-25 19:29:02.000000000 -0500
+++ linux-2.6.13-rc6-mm2-cur/fs/relayfs/relay.c	2005-08-25 21:12:29.000000000 -0500
@@ -58,6 +58,9 @@ static int subbuf_start_default_callback
 					  void *prev_subbuf,
 					  size_t prev_padding)
 {
+	if (relay_buf_full(buf))
+		return 0;
+	
 	return 1;
 }
 
@@ -120,6 +123,7 @@ static inline void __relay_reset(struct 
 
 	buf->subbufs_produced = 0;
 	buf->subbufs_consumed = 0;
+	buf->bytes_consumed = 0;
 	buf->finalized = 0;
 	buf->data = buf->start;
 	buf->offset = 0;
@@ -262,6 +266,7 @@ struct rchan *relay_open(const char *bas
 	for_each_online_cpu(i) {
 		sprintf(tmpname, "%s%d", base_filename, i);
 		chan->buf[i] = relay_open_buf(chan, tmpname, parent);
+		chan->buf[i]->cpu = i;
 		if (!chan->buf[i])
 			goto free_bufs;
 	}
@@ -328,7 +333,7 @@ size_t relay_switch_subbuf(struct rchan_
 	return length;
 
 toobig:
-	printk(KERN_WARNING "relayfs: event too large (%u)\n", length);
+	printk(KERN_WARNING "relayfs: event too large (%Zd)\n", length);
 	WARN_ON(1);
 	return 0;
 }
diff -urpN -X dontdiff linux-2.6.13-rc6-mm2/include/linux/relayfs_fs.h linux-2.6.13-rc6-mm2-cur/include/linux/relayfs_fs.h
--- linux-2.6.13-rc6-mm2/include/linux/relayfs_fs.h	2005-08-25 19:29:03.000000000 -0500
+++ linux-2.6.13-rc6-mm2-cur/include/linux/relayfs_fs.h	2005-08-24 00:16:37.000000000 -0500
@@ -22,7 +22,7 @@
 /*
  * Tracks changes to rchan_buf struct
  */
-#define RELAYFS_CHANNEL_VERSION		4
+#define RELAYFS_CHANNEL_VERSION		5
 
 /*
  * Per-cpu relay channel buffer
@@ -44,6 +44,8 @@ struct rchan_buf
 	unsigned int finalized;		/* buffer has been finalized */
 	size_t *padding;		/* padding counts per sub-buffer */
 	size_t prev_padding;		/* temporary variable */
+	size_t bytes_consumed;		/* bytes consumed in cur read subbuf */
+	unsigned int cpu;		/* this buf's cpu */
 } ____cacheline_aligned;
 
 /*


