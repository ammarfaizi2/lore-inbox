Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161253AbVKIVwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161253AbVKIVwP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 16:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161248AbVKIVwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 16:52:15 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:31628 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161253AbVKIVwJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 16:52:09 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
Message-ID: <17266.28513.999738.223252@tut.ibm.com>
Date: Wed, 9 Nov 2005 15:51:29 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, karim@opersys.com
Subject: [PATCH 3/4] relayfs: make exported relay fileops useful
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The relayfs relay_file_operations have always been exported, the
intent being to make it possible to create relay files in other
filesystems such as debugfs.  The problem, though, is that currently
the file operations are too tightly coupled to relayfs to actually be
used for this purpose.  This patch fixes that by adding a couple of
callback functions that allow a client to hook into
relay_open()/close() and supply the files that will be used to
represent the channel buffers; the default implementation if no
callbacks are defined is to create the files in relayfs.  It also
removes relayfs-specific code in the file operations themselves and
renames some functions to better reflect their purpose.
    
The file creation callback also supplies an optional param, is_global,
that can be used by clients to create a single global relayfs buffer
instead of the default per-cpu buffers.  This was suggested as being
useful for certain debugging applications where it's more convenient
to be able to get all the data from a single channel without having to
go to the bother of dealing with per-cpu files.
    
There are a couple of new examples that demonstrate both usages in the
examples/exported-relayfile directory of the relay-apps tarball:
    
http://prdownloads.sourceforge.net/relayfs/relay-apps-0.9.tar.gz?download

This patch depends on [PATCH 1/4] relayfs: add support for non-relay files.

Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>

---

 fs/relayfs/buffers.c       |    3 
 fs/relayfs/inode.c         |  201 ++++++++++++---------------------------------
 fs/relayfs/relay.c         |   69 ++++++++++++---
 fs/relayfs/relay.h         |    4 
 include/linux/relayfs_fs.h |   56 +++++++++---
 5 files changed, 159 insertions(+), 174 deletions(-)

diff --git a/fs/relayfs/buffers.c b/fs/relayfs/buffers.c
--- a/fs/relayfs/buffers.c
+++ b/fs/relayfs/buffers.c
@@ -185,5 +185,6 @@ void relay_destroy_buf(struct rchan_buf 
 void relay_remove_buf(struct kref *kref)
 {
 	struct rchan_buf *buf = container_of(kref, struct rchan_buf, kref);
-	relayfs_remove(buf->dentry);
+	buf->chan->cb->remove_buf_file(buf->dentry);
+	relay_destroy_buf(buf);
 }
diff --git a/fs/relayfs/inode.c b/fs/relayfs/inode.c
--- a/fs/relayfs/inode.c
+++ b/fs/relayfs/inode.c
@@ -26,7 +26,6 @@
 
 static struct vfsmount *		relayfs_mount;
 static int				relayfs_mount_count;
-static kmem_cache_t *			relayfs_inode_cachep;
 
 static struct backing_dev_info		relayfs_backing_dev_info = {
 	.ra_pages	= 0,	/* No readahead */
@@ -35,24 +34,13 @@ static struct backing_dev_info		relayfs_
 
 static struct inode *relayfs_get_inode(struct super_block *sb,
 				       int mode,
-				       struct rchan *chan,
 				       struct file_operations *fops)
 {
-	struct rchan_buf *buf = NULL;
 	struct inode *inode;
 
-	if (S_ISREG(mode) && chan) {
-		buf = relay_create_buf(chan);
-		if (!buf)
-			return NULL;
-	}
-
 	inode = new_inode(sb);
-	if (!inode) {
-		if (chan)
-			relay_destroy_buf(buf);
+	if (!inode)
 		return NULL;
-	}
 
 	inode->i_mode = mode;
 	inode->i_uid = 0;
@@ -64,7 +52,6 @@ static struct inode *relayfs_get_inode(s
 	switch (mode & S_IFMT) {
 	case S_IFREG:
 		inode->i_fop = fops;
-		RELAYFS_I(inode)->buf = buf;
 		break;
 	case S_IFDIR:
 		inode->i_op = &simple_dir_inode_operations;
@@ -94,7 +81,6 @@ static struct inode *relayfs_get_inode(s
 static struct dentry *relayfs_create_entry(const char *name,
 					   struct dentry *parent,
 					   int mode,
-					   struct rchan *chan,
 					   struct file_operations *fops)
 {
 	struct dentry *d;
@@ -130,7 +116,7 @@ static struct dentry *relayfs_create_ent
 		goto release_mount;
 	}
 
-	inode = relayfs_get_inode(parent->d_inode->i_sb, mode, chan, fops);
+	inode = relayfs_get_inode(parent->d_inode->i_sb, mode, fops);
 	if (!inode) {
 		d = NULL;
 		goto release_mount;
@@ -180,36 +166,11 @@ struct dentry *relayfs_create_file(const
 		mode = S_IRUSR;
 	mode = (mode & S_IALLUGO) | S_IFREG;
 
-	d = relayfs_create_entry(name, parent, mode, NULL, fops);
-	if (d)
-		d->d_inode->u.generic_ip = data;
-	
-	return d;
-}
+	d = relayfs_create_entry(name, parent, mode, fops);
+	if (d && data)
+  		d->d_inode->u.generic_ip = data;
 
-/**
- *	relayfs_create_relay_file - create a relay file in the relay filesystem
- *	@name: the name of the file to create
- *	@parent: parent directory
- *	@mode: mode, if not specied the default perms are used
- *	@chan: channel associated with the file
- *
- *	Returns file dentry if successful, NULL otherwise.
- *
- *	The file will be created user r on behalf of current user if
- *	mode is not specified.
- */
-struct dentry *relayfs_create_relay_file(const char *name,
-					 struct dentry *parent,
-					 int mode,
-					 struct rchan *chan)
-{
-	if (!mode)
-		mode = S_IRUSR;
-	mode = (mode & S_IALLUGO) | S_IFREG;
-	
-	return relayfs_create_entry(name, parent, mode, chan,
-				    &relayfs_file_operations);
+	return d;
 }
 
 /**
@@ -224,7 +185,7 @@ struct dentry *relayfs_create_relay_file
 struct dentry *relayfs_create_dir(const char *name, struct dentry *parent)
 {
 	int mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
-	return relayfs_create_entry(name, parent, mode, NULL, NULL);
+	return relayfs_create_entry(name, parent, mode, NULL);
 }
 
 /**
@@ -288,45 +249,45 @@ int relayfs_remove_dir(struct dentry *de
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
-	struct rchan_buf *buf = RELAYFS_I(inode)->buf;
+	struct rchan_buf *buf = inode->u.generic_ip;
 	kref_get(&buf->kref);
+	filp->private_data = buf;
 
 	return 0;
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
-	struct inode *inode = filp->f_dentry->d_inode;
-	return relay_mmap_buf(RELAYFS_I(inode)->buf, vma);
+	struct rchan_buf *buf = filp->private_data;
+	return relay_mmap_buf(buf, vma);
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
-	struct inode *inode = filp->f_dentry->d_inode;
-	struct rchan_buf *buf = RELAYFS_I(inode)->buf;
+	struct rchan_buf *buf = filp->private_data;
 
 	if (buf->finalized)
 		return POLLERR;
@@ -341,27 +302,27 @@ static unsigned int relayfs_poll(struct 
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
-	struct rchan_buf *buf = RELAYFS_I(inode)->buf;
+	struct rchan_buf *buf = filp->private_data;
 	kref_put(&buf->kref, relay_remove_buf);
 
 	return 0;
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
@@ -384,9 +345,9 @@ static void relayfs_read_consume(struct 
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
@@ -417,16 +378,16 @@ static int relayfs_read_avail(struct rch
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
@@ -448,14 +409,14 @@ static size_t relayfs_read_subbuf_avail(
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
@@ -474,11 +435,11 @@ static size_t relayfs_read_start_pos(siz
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
@@ -497,7 +458,7 @@ static size_t relayfs_read_end_pos(struc
 }
 
 /**
- *	relayfs_read - read file op for relayfs files
+ *	relay_file_read - read file op for relay files
  *	@filp: the file
  *	@buffer: the userspace buffer
  *	@count: number of bytes to read
@@ -506,23 +467,23 @@ static size_t relayfs_read_end_pos(struc
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
+	struct rchan_buf *buf = filp->private_data;
 	struct inode *inode = filp->f_dentry->d_inode;
-	struct rchan_buf *buf = RELAYFS_I(inode)->buf;
 	size_t read_start, avail;
 	ssize_t ret = 0;
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
 
@@ -532,58 +493,25 @@ static ssize_t relayfs_read(struct file 
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
 
-/**
- *	relayfs alloc_inode() implementation
- */
-static struct inode *relayfs_alloc_inode(struct super_block *sb)
-{
-	struct relayfs_inode_info *p = kmem_cache_alloc(relayfs_inode_cachep, SLAB_KERNEL);
-	if (!p)
-		return NULL;
-	p->buf = NULL;
-
-	return &p->vfs_inode;
-}
-
-/**
- *	relayfs destroy_inode() implementation
- */
-static void relayfs_destroy_inode(struct inode *inode)
-{
-	if (RELAYFS_I(inode)->buf)
-		relay_destroy_buf(RELAYFS_I(inode)->buf);
-
-	kmem_cache_free(relayfs_inode_cachep, RELAYFS_I(inode));
-}
-
-static void init_once(void *p, kmem_cache_t *cachep, unsigned long flags)
-{
-	struct relayfs_inode_info *i = p;
-	if ((flags & (SLAB_CTOR_VERIFY | SLAB_CTOR_CONSTRUCTOR)) == SLAB_CTOR_CONSTRUCTOR)
-		inode_init_once(&i->vfs_inode);
-}
-
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
 	.statfs		= simple_statfs,
 	.drop_inode	= generic_delete_inode,
-	.alloc_inode	= relayfs_alloc_inode,
-	.destroy_inode	= relayfs_destroy_inode,
 };
 
 static int relayfs_fill_super(struct super_block * sb, void * data, int silent)
@@ -596,7 +524,7 @@ static int relayfs_fill_super(struct sup
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = RELAYFS_MAGIC;
 	sb->s_op = &relayfs_ops;
-	inode = relayfs_get_inode(sb, mode, NULL, NULL);
+	inode = relayfs_get_inode(sb, mode, NULL);
 
 	if (!inode)
 		return -ENOMEM;
@@ -627,31 +555,18 @@ static struct file_system_type relayfs_f
 
 static int __init init_relayfs_fs(void)
 {
-	int err;
-
-	relayfs_inode_cachep = kmem_cache_create("relayfs_inode_cache",
-				sizeof(struct relayfs_inode_info), 0,
-				0, init_once, NULL);
-	if (!relayfs_inode_cachep)
-		return -ENOMEM;
-
-	err = register_filesystem(&relayfs_fs_type);
-	if (err)
-		kmem_cache_destroy(relayfs_inode_cachep);
-
-	return err;
+	return register_filesystem(&relayfs_fs_type);
 }
 
 static void __exit exit_relayfs_fs(void)
 {
 	unregister_filesystem(&relayfs_fs_type);
-	kmem_cache_destroy(relayfs_inode_cachep);
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
@@ -79,12 +79,35 @@ static void buf_unmapped_default_callbac
 					  struct file *filp)
 {
 }
+	
+/*
+ * create_buf_file_create() default callback.  Creates file to represent buf.
+ */
+static struct dentry *create_buf_file_default_callback(const char *filename,
+						       struct dentry *parent,
+						       int mode,
+						       struct rchan_buf *buf,
+						       int *is_global)
+{
+	return relayfs_create_file(filename, parent, mode,
+				   &relay_file_operations, buf);
+}
+
+/*
+ * remove_buf_file() default callback.  Removes file representing relay buffer.
+ */
+static int remove_buf_file_default_callback(struct dentry *dentry)
+{
+	return relayfs_remove(dentry);
+}
 
 /* relay channel default callbacks */
 static struct rchan_callbacks default_channel_callbacks = {
 	.subbuf_start = subbuf_start_default_callback,
 	.buf_mapped = buf_mapped_default_callback,
 	.buf_unmapped = buf_unmapped_default_callback,
+	.create_buf_file = create_buf_file_default_callback,
+	.remove_buf_file = remove_buf_file_default_callback,
 };
 
 /**
@@ -148,14 +171,16 @@ static inline void __relay_reset(struct 
 void relay_reset(struct rchan *chan)
 {
 	unsigned int i;
+	struct rchan_buf *prev = NULL;
 
 	if (!chan)
 		return;
 
 	for (i = 0; i < NR_CPUS; i++) {
-		if (!chan->buf[i])
-			continue;
+		if (!chan->buf[i] || chan->buf[i] == prev)
+			break;
 		__relay_reset(chan->buf[i], 0);
+		prev = chan->buf[i];
 	}
 }
 
@@ -166,17 +191,27 @@ void relay_reset(struct rchan *chan)
  */
 static struct rchan_buf *relay_open_buf(struct rchan *chan,
 					const char *filename,
-					struct dentry *parent)
+					struct dentry *parent,
+					int *is_global)
 {
 	struct rchan_buf *buf;
 	struct dentry *dentry;
 
+	if (*is_global)
+		return chan->buf[0];
+ 	
+ 	buf = relay_create_buf(chan);
+ 	if (!buf)
+ 		return NULL;
+
 	/* Create file in fs */
-	dentry = relayfs_create_relay_file(filename, parent, S_IRUSR, chan);
-	if (!dentry)
+ 	dentry = chan->cb->create_buf_file(filename, parent, S_IRUSR,
+ 					   buf, is_global);
+ 	if (!dentry) {
+ 		relay_destroy_buf(buf);
 		return NULL;
+ 	}
 
-	buf = RELAYFS_I(dentry->d_inode)->buf;
 	buf->dentry = dentry;
 	__relay_reset(buf, 1);
 
@@ -214,6 +249,10 @@ static inline void setup_callbacks(struc
 		cb->buf_mapped = buf_mapped_default_callback;
 	if (!cb->buf_unmapped)
 		cb->buf_unmapped = buf_unmapped_default_callback;
+	if (!cb->create_buf_file)
+		cb->create_buf_file = create_buf_file_default_callback;
+	if (!cb->remove_buf_file)
+		cb->remove_buf_file = remove_buf_file_default_callback;
 	chan->cb = cb;
 }
 
@@ -241,6 +280,7 @@ struct rchan *relay_open(const char *bas
 	unsigned int i;
 	struct rchan *chan;
 	char *tmpname;
+	int is_global = 0;
 
 	if (!base_filename)
 		return NULL;
@@ -265,7 +305,8 @@ struct rchan *relay_open(const char *bas
 
 	for_each_online_cpu(i) {
 		sprintf(tmpname, "%s%d", base_filename, i);
-		chan->buf[i] = relay_open_buf(chan, tmpname, parent);
+		chan->buf[i] = relay_open_buf(chan, tmpname, parent,
+					      &is_global);
 		chan->buf[i]->cpu = i;
 		if (!chan->buf[i])
 			goto free_bufs;
@@ -279,6 +320,8 @@ free_bufs:
 		if (!chan->buf[i])
 			break;
 		relay_close_buf(chan->buf[i]);
+		if (is_global)
+			break;
 	}
 	kfree(tmpname);
 
@@ -389,14 +432,16 @@ void relay_destroy_channel(struct kref *
 void relay_close(struct rchan *chan)
 {
 	unsigned int i;
+	struct rchan_buf *prev = NULL;
 
 	if (!chan)
 		return;
 
 	for (i = 0; i < NR_CPUS; i++) {
-		if (!chan->buf[i])
-			continue;
+		if (!chan->buf[i] || chan->buf[i] == prev)
+			break;
 		relay_close_buf(chan->buf[i]);
+		prev = chan->buf[i];
 	}
 
 	kref_put(&chan->kref, relay_destroy_channel);
@@ -411,14 +456,16 @@ void relay_close(struct rchan *chan)
 void relay_flush(struct rchan *chan)
 {
 	unsigned int i;
+	struct rchan_buf *prev = NULL;
 
 	if (!chan)
 		return;
 
 	for (i = 0; i < NR_CPUS; i++) {
-		if (!chan->buf[i])
-			continue;
+		if (!chan->buf[i] || chan->buf[i] == prev)
+			break;
 		relay_switch_subbuf(chan->buf[i], 0);
+		prev = chan->buf[i];
 	}
 }
 
diff --git a/fs/relayfs/relay.h b/fs/relayfs/relay.h
--- a/fs/relayfs/relay.h
+++ b/fs/relayfs/relay.h
@@ -1,10 +1,6 @@
 #ifndef _RELAY_H
 #define _RELAY_H
 
-struct dentry *relayfs_create_relay_file(const char *name,
-					 struct dentry *parent,
-					 int mode,
-					 struct rchan *chan);
 extern int relayfs_remove(struct dentry *dentry);
 extern int relay_buf_empty(struct rchan_buf *buf);
 extern void relay_destroy_channel(struct kref *kref);
diff --git a/include/linux/relayfs_fs.h b/include/linux/relayfs_fs.h
--- a/include/linux/relayfs_fs.h
+++ b/include/linux/relayfs_fs.h
@@ -64,20 +64,6 @@ struct rchan
 };
 
 /*
- * Relayfs inode
- */
-struct relayfs_inode_info
-{
-	struct inode vfs_inode;
-	struct rchan_buf *buf;
-};
-
-static inline struct relayfs_inode_info *RELAYFS_I(struct inode *inode)
-{
-	return container_of(inode, struct relayfs_inode_info, vfs_inode);
-}
-
-/*
  * Relay channel client callbacks
  */
 struct rchan_callbacks
@@ -123,6 +109,46 @@ struct rchan_callbacks
 	 */
         void (*buf_unmapped)(struct rchan_buf *buf,
 			     struct file *filp);
+
+	/*
+	 * create_buf_file - create file to represent a relayfs channel buffer
+	 * @filename: the name of the file to create
+	 * @parent: the parent of the file to create
+	 * @mode: the mode of the file to create
+	 * @buf: the channel buffer
+	 * @is_global: outparam - set non-zero if the buffer should be global
+	 *
+	 * Called during relay_open(), once for each per-cpu buffer,
+	 * to allow the client to create a file to be used to
+	 * represent the corresponding channel buffer.  If the file is
+	 * created outside of relayfs, the parent must also exist in
+	 * that filesystem.
+	 *
+	 * The callback should return the dentry of the file created
+	 * to represent the relay buffer.
+	 *
+	 * Setting the is_global outparam to a non-zero value will
+	 * cause relay_open() to create a single global buffer rather
+	 * than the default set of per-cpu buffers.
+	 *
+	 * See Documentation/filesystems/relayfs.txt for more info.
+	 */
+	struct dentry *(*create_buf_file)(const char *filename,
+					  struct dentry *parent,
+					  int mode,
+					  struct rchan_buf *buf,
+					  int *is_global);
+	/*
+	 * remove_buf_file - remove file representing a relayfs channel buffer
+	 * @dentry: the dentry of the file to remove
+	 *
+	 * Called during relay_close(), once for each per-cpu buffer,
+	 * to allow the client to remove a file used to represent a
+	 * channel buffer.
+	 *
+	 * The callback should return 0 if successful, negative if not.
+	 */
+	int (*remove_buf_file)(struct dentry *dentry);
 };
 
 /*
@@ -255,7 +281,7 @@ static inline void subbuf_start_reserve(
  * exported relayfs file operations, fs/relayfs/inode.c
  */
 
-extern struct file_operations relayfs_file_operations;
+extern struct file_operations relay_file_operations;
 
 #endif /* _LINUX_RELAYFS_FS_H */
 


