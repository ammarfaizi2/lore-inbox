Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbVKKQyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbVKKQyF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 11:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbVKKQyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 11:54:04 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:64937 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750912AbVKKQyD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 11:54:03 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17268.52358.960133.986945@tut.ibm.com>
Date: Fri, 11 Nov 2005 10:53:26 -0600
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, karim@opersys.com
Subject: [PATCH 11/12] relayfs: cleanup, change relayfs_file_* to relay_file_*
In-Reply-To: <17268.51814.215178.281986@tut.ibm.com>
References: <17268.51814.215178.281986@tut.ibm.com>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames relayfs_file_operations to relay_file_operations,
and the file operations themselves from relayfs_XXX to relay_file_XXX,
to make it more clear that they refer to relay files.

Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>

---

 fs/relayfs/inode.c         |   89 +++++++++++++++++++++++----------------------
 fs/relayfs/relay.c         |    2 -
 include/linux/relayfs_fs.h |    5 +-
 3 files changed, 50 insertions(+), 46 deletions(-)

diff --git a/fs/relayfs/inode.c b/fs/relayfs/inode.c
--- a/fs/relayfs/inode.c
+++ b/fs/relayfs/inode.c
@@ -247,13 +247,13 @@ int relayfs_remove_dir(struct dentry *de
 }
 
 /**
- *	relayfs_open - open file op for relayfs files
+ *	relay_file_open - open file op for relay files
  *	@inode: the inode
  *	@filp: the file
  *
  *	Increments the channel buffer refcount.
  */
-static int relayfs_open(struct inode *inode, struct file *filp)
+static int relay_file_open(struct inode *inode, struct file *filp)
 {
 	struct rchan_buf *buf = inode->u.generic_ip;
 	kref_get(&buf->kref);
@@ -263,26 +263,26 @@ static int relayfs_open(struct inode *in
 }
 
 /**
- *	relayfs_mmap - mmap file op for relayfs files
+ *	relay_file_mmap - mmap file op for relay files
  *	@filp: the file
  *	@vma: the vma describing what to map
  *
  *	Calls upon relay_mmap_buf to map the file into user space.
  */
-static int relayfs_mmap(struct file *filp, struct vm_area_struct *vma)
+static int relay_file_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct rchan_buf *buf = filp->private_data;
 	return relay_mmap_buf(buf, vma);
 }
 
 /**
- *	relayfs_poll - poll file op for relayfs files
+ *	relay_file_poll - poll file op for relay files
  *	@filp: the file
  *	@wait: poll table
  *
  *	Poll implemention.
  */
-static unsigned int relayfs_poll(struct file *filp, poll_table *wait)
+static unsigned int relay_file_poll(struct file *filp, poll_table *wait)
 {
 	unsigned int mask = 0;
 	struct rchan_buf *buf = filp->private_data;
@@ -300,14 +300,14 @@ static unsigned int relayfs_poll(struct 
 }
 
 /**
- *	relayfs_release - release file op for relayfs files
+ *	relay_file_release - release file op for relay files
  *	@inode: the inode
  *	@filp: the file
  *
  *	Decrements the channel refcount, as the filesystem is
  *	no longer using it.
  */
-static int relayfs_release(struct inode *inode, struct file *filp)
+static int relay_file_release(struct inode *inode, struct file *filp)
 {
 	struct rchan_buf *buf = filp->private_data;
 	kref_put(&buf->kref, relay_remove_buf);
@@ -316,11 +316,11 @@ static int relayfs_release(struct inode 
 }
 
 /**
- *	relayfs_read_consume - update the consumed count for the buffer
+ *	relay_file_read_consume - update the consumed count for the buffer
  */
-static void relayfs_read_consume(struct rchan_buf *buf,
-				 size_t read_pos,
-				 size_t bytes_consumed)
+static void relay_file_read_consume(struct rchan_buf *buf,
+				    size_t read_pos,
+				    size_t bytes_consumed)
 {
 	size_t subbuf_size = buf->chan->subbuf_size;
 	size_t n_subbufs = buf->chan->n_subbufs;
@@ -343,9 +343,9 @@ static void relayfs_read_consume(struct 
 }
 
 /**
- *	relayfs_read_avail - boolean, are there unconsumed bytes available?
+ *	relay_file_read_avail - boolean, are there unconsumed bytes available?
  */
-static int relayfs_read_avail(struct rchan_buf *buf, size_t read_pos)
+static int relay_file_read_avail(struct rchan_buf *buf, size_t read_pos)
 {
 	size_t bytes_produced, bytes_consumed, write_offset;
 	size_t subbuf_size = buf->chan->subbuf_size;
@@ -376,16 +376,16 @@ static int relayfs_read_avail(struct rch
 	if (bytes_produced == bytes_consumed)
 		return 0;
 
-	relayfs_read_consume(buf, read_pos, 0);
+	relay_file_read_consume(buf, read_pos, 0);
 
 	return 1;
 }
 
 /**
- *	relayfs_read_subbuf_avail - return bytes available in sub-buffer
+ *	relay_file_read_subbuf_avail - return bytes available in sub-buffer
  */
-static size_t relayfs_read_subbuf_avail(size_t read_pos,
-					struct rchan_buf *buf)
+static size_t relay_file_read_subbuf_avail(size_t read_pos,
+					   struct rchan_buf *buf)
 {
 	size_t padding, avail = 0;
 	size_t read_subbuf, read_offset, write_subbuf, write_offset;
@@ -407,14 +407,14 @@ static size_t relayfs_read_subbuf_avail(
 }
 
 /**
- *	relayfs_read_start_pos - find the first available byte to read
+ *	relay_file_read_start_pos - find the first available byte to read
  *
  *	If the read_pos is in the middle of padding, return the
  *	position of the first actually available byte, otherwise
  *	return the original value.
  */
-static size_t relayfs_read_start_pos(size_t read_pos,
-				     struct rchan_buf *buf)
+static size_t relay_file_read_start_pos(size_t read_pos,
+					struct rchan_buf *buf)
 {
 	size_t read_subbuf, padding, padding_start, padding_end;
 	size_t subbuf_size = buf->chan->subbuf_size;
@@ -433,11 +433,11 @@ static size_t relayfs_read_start_pos(siz
 }
 
 /**
- *	relayfs_read_end_pos - return the new read position
+ *	relay_file_read_end_pos - return the new read position
  */
-static size_t relayfs_read_end_pos(struct rchan_buf *buf,
-				   size_t read_pos,
-				   size_t count)
+static size_t relay_file_read_end_pos(struct rchan_buf *buf,
+				      size_t read_pos,
+				      size_t count)
 {
 	size_t read_subbuf, padding, end_pos;
 	size_t subbuf_size = buf->chan->subbuf_size;
@@ -456,7 +456,7 @@ static size_t relayfs_read_end_pos(struc
 }
 
 /**
- *	relayfs_read - read file op for relayfs files
+ *	relay_file_read - read file op for relay files
  *	@filp: the file
  *	@buffer: the userspace buffer
  *	@count: number of bytes to read
@@ -465,10 +465,10 @@ static size_t relayfs_read_end_pos(struc
  *	Reads count bytes or the number of bytes available in the
  *	current sub-buffer being read, whichever is smaller.
  */
-static ssize_t relayfs_read(struct file *filp,
-			    char __user *buffer,
-			    size_t count,
-			    loff_t *ppos)
+static ssize_t relay_file_read(struct file *filp,
+			       char __user *buffer,
+			       size_t count,
+			       loff_t *ppos)
 {
 	struct rchan_buf *buf = filp->private_data;
 	struct inode *inode = filp->f_dentry->d_inode;
@@ -477,11 +477,11 @@ static ssize_t relayfs_read(struct file 
 	void *from;
 
 	down(&inode->i_sem);
-	if(!relayfs_read_avail(buf, *ppos))
+	if(!relay_file_read_avail(buf, *ppos))
 		goto out;
 
-	read_start = relayfs_read_start_pos(*ppos, buf);
-	avail = relayfs_read_subbuf_avail(read_start, buf);
+	read_start = relay_file_read_start_pos(*ppos, buf);
+	avail = relay_file_read_subbuf_avail(read_start, buf);
 	if (!avail)
 		goto out;
 
@@ -491,20 +491,20 @@ static ssize_t relayfs_read(struct file 
 		ret = -EFAULT;
 		goto out;
 	}
-	relayfs_read_consume(buf, read_start, count);
-	*ppos = relayfs_read_end_pos(buf, read_start, count);
+	relay_file_read_consume(buf, read_start, count);
+	*ppos = relay_file_read_end_pos(buf, read_start, count);
 out:
 	up(&inode->i_sem);
 	return ret;
 }
 
-struct file_operations relayfs_file_operations = {
-	.open		= relayfs_open,
-	.poll		= relayfs_poll,
-	.mmap		= relayfs_mmap,
-	.read		= relayfs_read,
+struct file_operations relay_file_operations = {
+	.open		= relay_file_open,
+	.poll		= relay_file_poll,
+	.mmap		= relay_file_mmap,
+	.read		= relay_file_read,
 	.llseek		= no_llseek,
-	.release	= relayfs_release,
+	.release	= relay_file_release,
 };
 
 static struct super_operations relayfs_ops = {
@@ -558,13 +558,18 @@ static int __init init_relayfs_fs(void)
 
 static void __exit exit_relayfs_fs(void)
 {
+
+
+
+
+
 	unregister_filesystem(&relayfs_fs_type);
 }
 
 module_init(init_relayfs_fs)
 module_exit(exit_relayfs_fs)
 
-EXPORT_SYMBOL_GPL(relayfs_file_operations);
+EXPORT_SYMBOL_GPL(relay_file_operations);
 EXPORT_SYMBOL_GPL(relayfs_create_dir);
 EXPORT_SYMBOL_GPL(relayfs_remove_dir);
 EXPORT_SYMBOL_GPL(relayfs_create_file);
diff --git a/fs/relayfs/relay.c b/fs/relayfs/relay.c
--- a/fs/relayfs/relay.c
+++ b/fs/relayfs/relay.c
@@ -90,7 +90,7 @@ static struct dentry *create_buf_file_de
 						       int *is_global)
 {
 	return relayfs_create_file(filename, parent, mode,
-				   &relayfs_file_operations, buf);
+				   &relay_file_operations, buf);
 }
 
 /*
diff --git a/include/linux/relayfs_fs.h b/include/linux/relayfs_fs.h
--- a/include/linux/relayfs_fs.h
+++ b/include/linux/relayfs_fs.h
@@ -278,10 +278,9 @@ static inline void subbuf_start_reserve(
 }
 
 /*
- * exported relayfs file operations, fs/relayfs/inode.c
+ * exported relay file operations, fs/relayfs/inode.c
  */
-
-extern struct file_operations relayfs_file_operations;
+extern struct file_operations relay_file_operations;
 
 #endif /* _LINUX_RELAYFS_FS_H */
 


