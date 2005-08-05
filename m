Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262822AbVHECd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262822AbVHECd6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 22:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbVHECdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 22:33:51 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:9444 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262821AbVHECc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 22:32:56 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17138.53203.430849.147593@tut.ibm.com>
Date: Thu, 4 Aug 2005 21:32:51 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, karim@opersys.com, prasadav@us.ibm.com
Subject: [-mm patch] relayfs: add read() support
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the kernel summit, there was some discussion of relayfs and the
consensus was that it didn't make sense for relayfs to not implement
read().  So here's a read implementation...

Andrew, please apply.

Tom

Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>

diff -urpN -X dontdiff linux-2.6.13-rc4-mm1/fs/relayfs/inode.c linux-2.6.13-rc4-mm1-cur/fs/relayfs/inode.c
--- linux-2.6.13-rc4-mm1/fs/relayfs/inode.c	2005-08-05 10:14:34.000000000 -0500
+++ linux-2.6.13-rc4-mm1-cur/fs/relayfs/inode.c	2005-08-05 10:17:47.000000000 -0500
@@ -232,7 +232,7 @@ int relayfs_remove_dir(struct dentry *de
  *
  *	Increments the channel buffer refcount.
  */
-int relayfs_open(struct inode *inode, struct file *filp)
+static int relayfs_open(struct inode *inode, struct file *filp)
 {
 	struct rchan_buf *buf = RELAYFS_I(inode)->buf;
 	kref_get(&buf->kref);
@@ -247,7 +247,7 @@ int relayfs_open(struct inode *inode, st
  *
  *	Calls upon relay_mmap_buf to map the file into user space.
  */
-int relayfs_mmap(struct file *filp, struct vm_area_struct *vma)
+static int relayfs_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
 	return relay_mmap_buf(RELAYFS_I(inode)->buf, vma);
@@ -260,7 +260,7 @@ int relayfs_mmap(struct file *filp, stru
  *
  *	Poll implemention.
  */
-unsigned int relayfs_poll(struct file *filp, poll_table *wait)
+static unsigned int relayfs_poll(struct file *filp, poll_table *wait)
 {
 	unsigned int mask = 0;
 	struct inode *inode = filp->f_dentry->d_inode;
@@ -286,7 +286,7 @@ unsigned int relayfs_poll(struct file *f
  *	Decrements the channel refcount, as the filesystem is
  *	no longer using it.
  */
-int relayfs_release(struct inode *inode, struct file *filp)
+static int relayfs_release(struct inode *inode, struct file *filp)
 {
 	struct rchan_buf *buf = RELAYFS_I(inode)->buf;
 	kref_put(&buf->kref, relay_remove_buf);
@@ -295,6 +295,157 @@ int relayfs_release(struct inode *inode,
 }
 
 /**
+ *	relayfs_read_start - find the first available byte to read
+ *
+ *	If the read_pos is in the middle of padding, return the
+ *	position of the first actually available byte, otherwise
+ *	return the original value.
+ */
+static inline unsigned int relayfs_read_start(unsigned int read_pos,
+					      unsigned int avail,
+					      unsigned int start_subbuf,
+					      struct rchan_buf *buf)
+{
+	unsigned int read_subbuf, adj_read_subbuf;
+	unsigned int padding, padding_start, padding_end;
+	unsigned int subbuf_size = buf->chan->subbuf_size;
+	unsigned int n_subbufs = buf->chan->n_subbufs;
+	
+	read_subbuf = read_pos / subbuf_size;
+	adj_read_subbuf = (read_subbuf + start_subbuf) % n_subbufs;
+	
+	if ((read_subbuf + 1) * subbuf_size <= avail) {
+		padding = buf->padding[adj_read_subbuf];
+		padding_start = (read_subbuf + 1) * subbuf_size - padding;
+		padding_end = (read_subbuf + 1) * subbuf_size;
+		if (read_pos >= padding_start && read_pos < padding_end) {
+			read_subbuf = (read_subbuf + 1) % n_subbufs;
+			read_pos = read_subbuf * subbuf_size;
+		}
+	}
+
+	return read_pos;
+}
+
+/**
+ *	relayfs_read_end - return the end of available bytes to read
+ *
+ *	If the read_pos is in the middle of a full sub-buffer, return
+ *	the padding-adjusted end of that sub-buffer, otherwise return
+ *	the position after the last byte written to the buffer.  At
+ *	most, 1 sub-buffer can be read at a time.
+ *	
+ */
+static inline unsigned int relayfs_read_end(unsigned int read_pos,
+					    unsigned int avail,
+					    unsigned int start_subbuf,
+					    struct rchan_buf *buf)
+{
+	unsigned int padding, read_endpos, buf_offset;
+	unsigned int read_subbuf, adj_read_subbuf;
+	unsigned int subbuf_size = buf->chan->subbuf_size;
+	unsigned int n_subbufs = buf->chan->n_subbufs;
+
+	buf_offset = buf->offset > subbuf_size ? subbuf_size : buf->offset;
+	read_subbuf = read_pos / subbuf_size;
+	adj_read_subbuf = (read_subbuf + start_subbuf) % n_subbufs;
+
+	if ((read_subbuf + 1) * subbuf_size <= avail) {
+		padding = buf->padding[adj_read_subbuf];
+		read_endpos = (read_subbuf + 1) * subbuf_size - padding;
+	} else
+		read_endpos = read_subbuf * subbuf_size + buf_offset;
+
+	return read_endpos;
+}
+
+/**
+ *	relayfs_read_avail - return total available along with buffer start
+ *
+ *	Because buffers are circular, the 'beginning' of the buffer
+ *	depends on where the buffer was last written.  If the writer
+ *	has cycled around the buffer, the beginning is defined to be
+ *	the beginning of the sub-buffer following the last sub-buffer
+ *	written to, otherwise it's the beginning of sub-buffer 0.
+ *	
+ */
+static inline unsigned int relayfs_read_avail(struct rchan_buf *buf,
+					      unsigned int *start_subbuf)
+{
+	unsigned int avail, complete_subbufs, cur_subbuf, buf_offset;
+	unsigned int subbuf_size = buf->chan->subbuf_size;
+	unsigned int n_subbufs = buf->chan->n_subbufs;
+
+	buf_offset = buf->offset > subbuf_size ? subbuf_size : buf->offset;
+	
+	if (buf->subbufs_produced >= n_subbufs) {
+		complete_subbufs = n_subbufs - 1;
+		cur_subbuf = (buf->data - buf->start) / subbuf_size;
+		*start_subbuf = (cur_subbuf + 1) % n_subbufs;
+	} else {
+		complete_subbufs = buf->subbufs_produced;
+		*start_subbuf = 0;
+	}
+	
+	avail = complete_subbufs * subbuf_size + buf_offset;
+
+	return avail;
+}
+
+/**
+ *	relayfs_read - read file op for relayfs files
+ *	@filp: the file
+ *	@buffer: the userspace buffer
+ *	@count: number of bytes to read
+ *	@ppos: position to read from
+ *
+ *	Reads count bytes or the number of bytes available in the
+ *	current sub-buffer being read, whichever is smaller.
+ *	
+ *	NOTE: The results of reading a relayfs file which is currently
+ *	being written to are undefined.  This is because the buffer is
+ *	circular and an active writer in the kernel could be
+ *	overwriting the data currently being read.  Therefore read()
+ *	is mainly useful for reading the contents of a buffer after
+ *	logging has completed.
+ */
+static ssize_t relayfs_read(struct file *filp,
+			    char __user *buffer,
+			    size_t count,
+			    loff_t *ppos)
+{
+	struct inode *inode = filp->f_dentry->d_inode;
+	struct rchan_buf *buf = RELAYFS_I(inode)->buf;
+	unsigned int read_start, read_end, avail, start_subbuf;
+	unsigned int buf_size = buf->chan->subbuf_size * buf->chan->n_subbufs;
+	void *from;
+
+	avail = relayfs_read_avail(buf, &start_subbuf);
+	if (*ppos >= avail)
+		return 0;
+
+	read_start = relayfs_read_start(*ppos, avail, start_subbuf, buf);
+	if (read_start == 0 && *ppos)
+		return 0;
+	
+	read_end = relayfs_read_end(read_start, avail, start_subbuf, buf);
+	if (read_end == read_start)
+		return 0;
+	
+	from = buf->start + start_subbuf * buf->chan->subbuf_size + read_start;
+	if (from >= buf->start + buf_size)
+		from -= buf_size;
+
+	count = min(count, read_end - read_start);
+	if (copy_to_user(buffer, from, count))
+		return -EFAULT;
+
+	*ppos = read_start + count;
+	
+	return count;
+}
+
+/**
  *	relayfs alloc_inode() implementation
  */
 static struct inode *relayfs_alloc_inode(struct super_block *sb)
@@ -329,6 +480,7 @@ struct file_operations relayfs_file_oper
 	.open		= relayfs_open,
 	.poll		= relayfs_poll,
 	.mmap		= relayfs_mmap,
+	.read		= relayfs_read,
 	.release	= relayfs_release,
 };
 
@@ -404,10 +556,6 @@ static void __exit exit_relayfs_fs(void)
 module_init(init_relayfs_fs)
 module_exit(exit_relayfs_fs)
 
-EXPORT_SYMBOL_GPL(relayfs_open);
-EXPORT_SYMBOL_GPL(relayfs_poll);
-EXPORT_SYMBOL_GPL(relayfs_mmap);
-EXPORT_SYMBOL_GPL(relayfs_release);
 EXPORT_SYMBOL_GPL(relayfs_file_operations);
 EXPORT_SYMBOL_GPL(relayfs_create_dir);
 EXPORT_SYMBOL_GPL(relayfs_remove_dir);


