Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbWINDtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWINDtt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 23:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWINDtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 23:49:49 -0400
Received: from tomts43-srv.bellnexxia.net ([209.226.175.110]:60080 "EHLO
	tomts43-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751293AbWINDtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 23:49:47 -0400
Date: Wed, 13 Sep 2006 23:49:40 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>
Cc: ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: [PATCH 10/11] LTTng-core 0.5.108 : relayfs
Message-ID: <20060914034940.GK2194@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_Krystal-12024-1158205780-0001-2"
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 23:48:49 up 22 days, 57 min,  6 users,  load average: 0.47, 0.63, 0.38
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-12024-1158205780-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

10 - Forward port of RelayFS 2.6.16 API, plus some enhancements.
patch-2.6.17-lttng-core-0.5.108-relayfs.diff

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

--=_Krystal-12024-1158205780-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-2.6.17-lttng-core-0.5.108-relayfs.diff"

--- a/Documentation/ioctl-number.txt
+++ b/Documentation/ioctl-number.txt
@@ -190,3 +190,6 @@ Code	Seq#	Include File		Comments
 					<mailto:aherrman@de.ibm.com>
 0xF3	00-3F	video/sisfb.h		sisfb (in development)
 					<mailto:thomas@winischhofer.net>
+0xF4	00-3F	linux/relayfs_fs.h RelayFS
+					<mailto:mathieu.desnoyers@polymtl.ca>
+
--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -1,6 +1,7 @@
 /*
  * linux/include/linux/relay.h
  *
+ * Copyright (C) 2005, Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
  * Copyright (C) 2002, 2003 - Tom Zanussi (zanussi@us.ibm.com), IBM Corp
  * Copyright (C) 1999, 2000, 2001, 2002 - Karim Yaghmour (karim@opersys.com)
  *
@@ -37,11 +38,13 @@ struct rchan_buf
 	size_t offset;			/* current offset into sub-buffer */
 	size_t subbufs_produced;	/* count of sub-buffers produced */
 	size_t subbufs_consumed;	/* count of sub-buffers consumed */
+	atomic_t full;		/* buffer is in full state */
 	struct rchan *chan;		/* associated channel */
 	wait_queue_head_t read_wait;	/* reader wait queue */
 	struct work_struct wake_readers; /* reader wake-up work struct */
 	struct dentry *dentry;		/* channel file dentry */
 	struct kref kref;		/* channel buffer refcount */
+	atomic_t open_count;			/* file open count */
 	struct page **page_array;	/* array of current buffer pages */
 	unsigned int page_count;	/* number of current buffer pages */
 	unsigned int finalized;		/* buffer has been finalized */
@@ -60,11 +63,18 @@ struct rchan
 	size_t subbuf_size;		/* sub-buffer size */
 	size_t n_subbufs;		/* number of sub-buffers per buffer */
 	size_t alloc_size;		/* total buffer size allocated */
+	int overwrite;			/* overwrite buffer when full? */
 	struct rchan_callbacks *cb;	/* client callbacks */
+	struct file_operations *fops; 	/* file operations */
+	void *client_data; 		/* client data associated with the
+					   client callbacks */
+	void (*free_client_data_cb)(void*); /* Callback function to free the
+					       client data */
 	struct kref kref;		/* channel refcount */
 	void *private_data;		/* for user-defined data */
 	size_t last_toobig;		/* tried to log event > subbuf size */
 	struct rchan_buf *buf[NR_CPUS]; /* per-cpu channel buffers */
+	struct module *client_module;	/* Client module */
 };
 
 /*
@@ -76,6 +86,7 @@ struct rchan_callbacks
 	 * subbuf_start - called on buffer-switch to a new sub-buffer
 	 * @buf: the channel buffer containing the new sub-buffer
 	 * @subbuf: the start of the new sub-buffer
+	 * @prev_subbuf_idx: the previous sub-buffer's index
 	 * @prev_subbuf: the start of the previous sub-buffer
 	 * @prev_padding: unused space at the end of previous sub-buffer
 	 *
@@ -95,6 +106,18 @@ struct rchan_callbacks
 			     size_t prev_padding);
 
 	/*
+	 * deliver - deliver a guaranteed full sub-buffer to client
+	 * @buf: the channel buffer containing the sub-buffer
+	 * @subbuf_idx: the sub-buffer's index
+	 * @subbuf: the start of the new sub-buffer
+	 *
+	 * Only works if relay_commit is also used
+	 */
+	void (*deliver) (struct rchan_buf *buf,
+			 unsigned subbuf_idx,
+			 void *subbuf);
+
+	/*
 	 * buf_mapped - relay buffer mmap notification
 	 * @buf: the channel buffer
 	 * @filp: relay file pointer
@@ -113,6 +136,7 @@ struct rchan_callbacks
 	 */
         void (*buf_unmapped)(struct rchan_buf *buf,
 			     struct file *filp);
+
 	/*
 	 * create_buf_file - create file to represent a relay channel buffer
 	 * @filename: the name of the file to create
@@ -153,6 +177,31 @@ struct rchan_callbacks
 	 * The callback should return 0 if successful, negative if not.
 	 */
 	int (*remove_buf_file)(struct dentry *dentry);
+
+	/*
+	 * buf_full - relayfs buffer full notification
+	 * @buf: the channel channel buffer
+	 * @subbuf_idx: the current sub-buffer's index
+	 * @subbuf: the start of the current sub-buffer
+	 *
+	 * Called when a relayfs buffer becomes full
+	 */
+	void (*buf_full)(struct rchan_buf *buf,
+			unsigned subbuf_idx,
+			void *subbuf);
+
+	/*
+	 * buf_unfull - relayfs buffer unfull notification
+	 * @buf: the channel channel buffer
+	 * @subbuf_idx: the current sub-buffer's index
+	 * @subbuf: the start of the current sub-buffer
+	 *
+	 * Called when a relayfs buffer passes from full to not full
+	 */
+	void (*buf_unfull)(struct rchan_buf *buf,
+			unsigned subbuf_idx,
+			void *subbuf);
+
 };
 
 /*
@@ -163,7 +212,12 @@ struct rchan *relay_open(const char *bas
 			 struct dentry *parent,
 			 size_t subbuf_size,
 			 size_t n_subbufs,
-			 struct rchan_callbacks *cb);
+			 int overwrite,
+			 struct module *client_module,
+			 struct rchan_callbacks *cb,
+			 struct file_operations *fops,
+			 void *client_data,
+			 void (*free_client_data_cb)(void*));
 extern void relay_close(struct rchan *chan);
 extern void relay_flush(struct rchan *chan);
 extern void relay_subbufs_consumed(struct rchan *chan,
@@ -175,6 +229,17 @@ extern int relay_buf_full(struct rchan_b
 extern size_t relay_switch_subbuf(struct rchan_buf *buf,
 				  size_t length);
 
+extern struct dentry *relayfs_create_dir(const char *name,
+					 struct dentry *parent);
+extern int relayfs_remove_dir(struct dentry *dentry);
+extern struct dentry *relayfs_create_file(const char *name,
+					  struct dentry *parent,
+					  int mode,
+					  struct file_operations *fops,
+					  void *data);
+extern int relayfs_remove_file(struct dentry *dentry);
+
+
 /**
  *	relay_write - write data into the channel
  *	@chan: relay channel
@@ -251,6 +316,7 @@ static inline void *relay_reserve(struct
 		if (!length)
 			return NULL;
 	}
+
 	reserved = buf->data + buf->offset;
 	buf->offset += length;
 
--- /dev/null
+++ b/fs/relayfs/Makefile
@@ -0,0 +1,4 @@
+obj-$(CONFIG_RELAY)	 += relayfs.o
+
+relayfs-y := relay.o inode.o buffers.o
+
--- /dev/null
+++ b/fs/relayfs/inode.c
@@ -0,0 +1,591 @@
+/*
+ * VFS-related code for RelayFS, a high-speed data relay filesystem.
+ *
+ * Copyright (C) 2003-2005 - Tom Zanussi <zanussi@us.ibm.com>, IBM Corp
+ * Copyright (C) 2003-2005 - Karim Yaghmour <karim@opersys.com>
+ *
+ * Based on ramfs, Copyright (C) 2002 - Linus Torvalds
+ *
+ * This file is released under the GPL.
+ */
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/pagemap.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/backing-dev.h>
+#include <linux/namei.h>
+#include <linux/poll.h>
+#include <linux/relay.h>
+#include "relay.h"
+#include "buffers.h"
+
+#define RELAYFS_MAGIC			0xF0B4A981
+
+static struct vfsmount *		relayfs_mount;
+static int				relayfs_mount_count;
+
+static struct backing_dev_info		relayfs_backing_dev_info = {
+	.ra_pages	= 0,	/* No readahead */
+	.capabilities	= BDI_CAP_NO_ACCT_DIRTY | BDI_CAP_NO_WRITEBACK,
+};
+
+static struct inode *relayfs_get_inode(struct super_block *sb,
+				       int mode,
+ 				       struct file_operations *fops,
+				       void *data)
+{
+	struct inode *inode;
+
+	inode = new_inode(sb);
+	if (!inode)
+		return NULL;
+
+	inode->i_mode = mode;
+	inode->i_uid = 0;
+	inode->i_gid = 0;
+	inode->i_blksize = PAGE_CACHE_SIZE;
+	inode->i_blocks = 0;
+	inode->i_mapping->backing_dev_info = &relayfs_backing_dev_info;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	switch (mode & S_IFMT) {
+	case S_IFREG:
+		inode->i_fop = fops;
+		if (data)
+			inode->u.generic_ip = data;
+		break;
+	case S_IFDIR:
+		inode->i_op = &simple_dir_inode_operations;
+		inode->i_fop = &simple_dir_operations;
+
+		/* directory inodes start off with i_nlink == 2 (for "." entry) */
+		inode->i_nlink++;
+		break;
+	default:
+		break;
+	}
+
+	return inode;
+}
+
+/**
+ *	relayfs_create_entry - create a relayfs directory or file
+ *	@name: the name of the file to create
+ *	@parent: parent directory
+ *	@mode: mode
+ *	@fops: file operations to use for the file
+ *	@data: user-associated data for this file
+ *
+ *	Returns the new dentry, NULL on failure
+ *
+ *	Creates a file or directory with the specifed permissions.
+ */
+static struct dentry *relayfs_create_entry(const char *name,
+					   struct dentry *parent,
+					   int mode,
+					   struct file_operations *fops,
+					   void *data)
+{
+	struct dentry *d;
+	struct inode *inode;
+	int error = 0;
+
+	BUG_ON(!name || !(S_ISREG(mode) || S_ISDIR(mode)));
+
+	error = simple_pin_fs("relayfs", &relayfs_mount, &relayfs_mount_count);
+	if (error) {
+		printk(KERN_ERR "Couldn't mount relayfs: errcode %d\n", error);
+		return NULL;
+	}
+
+	if (!parent && relayfs_mount && relayfs_mount->mnt_sb)
+		parent = relayfs_mount->mnt_sb->s_root;
+
+	if (!parent) {
+		simple_release_fs(&relayfs_mount, &relayfs_mount_count);
+		return NULL;
+	}
+
+	parent = dget(parent);
+	mutex_lock(&parent->d_inode->i_mutex);
+	d = lookup_one_len(name, parent, strlen(name));
+	if (IS_ERR(d)) {
+		d = NULL;
+		goto release_mount;
+	}
+
+	if (d->d_inode) {
+		d = NULL;
+		goto release_mount;
+	}
+
+	inode = relayfs_get_inode(parent->d_inode->i_sb, mode, fops, data);
+	if (!inode) {
+		d = NULL;
+		goto release_mount;
+	}
+
+	d_instantiate(d, inode);
+	dget(d);	/* Extra count - pin the dentry in core */
+
+	if (S_ISDIR(mode))
+		parent->d_inode->i_nlink++;
+
+	goto exit;
+
+release_mount:
+	simple_release_fs(&relayfs_mount, &relayfs_mount_count);
+
+exit:
+	mutex_unlock(&parent->d_inode->i_mutex);
+	dput(parent);
+	return d;
+}
+
+/**
+ *	relayfs_create_file - create a file in the relay filesystem
+ *	@name: the name of the file to create
+ *	@parent: parent directory
+ *	@mode: mode, if not specied the default perms are used
+ *	@fops: file operations to use for the file
+ *	@data: user-associated data for this file
+ *
+ *	Returns file dentry if successful, NULL otherwise.
+ *
+ *	The file will be created user r on behalf of current user.
+ */
+struct dentry *relayfs_create_file(const char *name,
+				   struct dentry *parent,
+				   int mode,
+				   struct file_operations *fops,
+				   void *data)
+{
+	BUG_ON(!fops);
+
+	if (!mode)
+		mode = S_IRUSR;
+	mode = (mode & S_IALLUGO) | S_IFREG;
+
+	return relayfs_create_entry(name, parent, mode, fops, data);
+}
+
+/**
+ *	relayfs_create_dir - create a directory in the relay filesystem
+ *	@name: the name of the directory to create
+ *	@parent: parent directory, NULL if parent should be fs root
+ *
+ *	Returns directory dentry if successful, NULL otherwise.
+ *
+ *	The directory will be created world rwx on behalf of current user.
+ */
+struct dentry *relayfs_create_dir(const char *name, struct dentry *parent)
+{
+	int mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
+	return relayfs_create_entry(name, parent, mode, NULL, NULL);
+}
+
+/**
+ *	relayfs_remove - remove a file or directory in the relay filesystem
+ *	@dentry: file or directory dentry
+ *
+ *	Returns 0 if successful, negative otherwise.
+ */
+int relayfs_remove(struct dentry *dentry)
+{
+	struct dentry *parent;
+	int error = 0;
+
+	if (!dentry)
+		return -EINVAL;
+	parent = dentry->d_parent;
+	if (!parent)
+		return -EINVAL;
+
+	parent = dget(parent);
+	mutex_lock(&parent->d_inode->i_mutex);
+	if (dentry->d_inode) {
+		//if (S_ISDIR(dentry->d_inode->i_mode))
+		//	error = simple_rmdir(parent->d_inode, dentry);
+		//else
+		error = simple_unlink(parent->d_inode, dentry);
+		if (!error)
+			d_delete(dentry);
+	}
+	if (!error)
+		dput(dentry);
+	mutex_unlock(&parent->d_inode->i_mutex);
+	dput(parent);
+
+	if (!error)
+		simple_release_fs(&relayfs_mount, &relayfs_mount_count);
+
+	return error;
+}
+
+/**
+ *	relayfs_remove_file - remove a file from relay filesystem
+ *	@dentry: directory dentry
+ *
+ *	Returns 0 if successful, negative otherwise.
+ */
+int relayfs_remove_file(struct dentry *dentry)
+{
+	return relayfs_remove(dentry);
+}
+
+/**
+ *	relayfs_remove_dir - remove a directory in the relay filesystem
+ *	@dentry: directory dentry
+ *
+ *	Returns 0 if successful, negative otherwise.
+ */
+int relayfs_remove_dir(struct dentry *dentry)
+{
+	if (!dentry)
+		return -EINVAL;
+
+	return relayfs_remove(dentry);
+}
+
+/**
+ *	relay_file_open - open file op for relay files
+ *	@inode: the inode
+ *	@filp: the file
+ *
+ *	Increments the channel buffer refcount.
+ */
+static int relay_file_open(struct inode *inode, struct file *filp)
+{
+	struct rchan_buf *buf = inode->u.generic_ip;
+
+	if(!atomic_dec_and_test(&buf->open_count)) {
+		atomic_inc(&buf->open_count);
+		return -EACCES;
+	}
+	
+	kref_get(&buf->kref);
+	filp->private_data = buf;
+
+	return 0;
+}
+
+/**
+ *	relay_file_mmap - mmap file op for relay files
+ *	@filp: the file
+ *	@vma: the vma describing what to map
+ *
+ *	Calls upon relay_mmap_buf to map the file into user space.
+ */
+static int relay_file_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct rchan_buf *buf = filp->private_data;
+	return relay_mmap_buf(buf, vma);
+}
+
+/**
+ *	relay_file_poll - poll file op for relay files
+ *	@filp: the file
+ *	@wait: poll table
+ *
+ *	Poll implemention.
+ */
+static unsigned int relay_file_poll(struct file *filp, poll_table *wait)
+{
+	unsigned int mask = 0;
+	struct rchan_buf *buf = filp->private_data;
+
+	if (buf->finalized)
+		return POLLERR;
+
+	if (filp->f_mode & FMODE_READ) {
+		poll_wait(filp, &buf->read_wait, wait);
+		if (!relay_buf_empty(buf))
+			mask |= POLLIN | POLLRDNORM;
+	}
+
+	return mask;
+}
+
+
+/**
+ *	relay_file_release - release file op for relay files
+ *	@inode: the inode
+ *	@filp: the file
+ *
+ *	Decrements the channel refcount, as the filesystem is
+ *	no longer using it.
+ */
+static int relay_file_release(struct inode *inode, struct file *filp)
+{
+	struct rchan_buf *buf = filp->private_data;
+
+	atomic_inc(&buf->open_count);
+	
+	kref_put(&buf->kref, relay_remove_buf);
+
+	return 0;
+}
+
+/**
+ *	relay_file_read_consume - update the consumed count for the buffer
+ */
+static void relay_file_read_consume(struct rchan_buf *buf,
+				    size_t read_pos,
+				    size_t bytes_consumed)
+{
+	size_t subbuf_size = buf->chan->subbuf_size;
+	size_t n_subbufs = buf->chan->n_subbufs;
+	size_t read_subbuf;
+
+	if (buf->bytes_consumed + bytes_consumed > subbuf_size) {
+		relay_subbufs_consumed(buf->chan, buf->cpu, 1);
+		buf->bytes_consumed = 0;
+	}
+
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
+ *	relay_file_read_avail - boolean, are there unconsumed bytes available?
+ */
+static int relay_file_read_avail(struct rchan_buf *buf, size_t read_pos)
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
+		}
+	}
+
+	if (buf->offset > subbuf_size)
+		bytes_produced = (produced - 1) * subbuf_size + write_offset;
+	else
+		bytes_produced = produced * subbuf_size + write_offset;
+	bytes_consumed = consumed * subbuf_size + buf->bytes_consumed;
+
+	if (bytes_produced == bytes_consumed)
+		return 0;
+
+	relay_file_read_consume(buf, read_pos, 0);
+
+	return 1;
+}
+
+/**
+ *	relay_file_read_subbuf_avail - return bytes available in sub-buffer
+ */
+static size_t relay_file_read_subbuf_avail(size_t read_pos,
+					   struct rchan_buf *buf)
+{
+	size_t padding, avail = 0;
+	size_t read_subbuf, read_offset, write_subbuf, write_offset;
+	size_t subbuf_size = buf->chan->subbuf_size;
+
+	write_subbuf = (buf->data - buf->start) / subbuf_size;
+	write_offset = buf->offset > subbuf_size ? subbuf_size : buf->offset;
+	read_subbuf = read_pos / subbuf_size;
+	read_offset = read_pos % subbuf_size;
+	padding = buf->padding[read_subbuf];
+
+	if (read_subbuf == write_subbuf) {
+		if (read_offset + padding < write_offset)
+			avail = write_offset - (read_offset + padding);
+	} else
+		avail = (subbuf_size - padding) - read_offset;
+
+	return avail;
+}
+
+/**
+ *	relay_file_read_start_pos - find the first available byte to read
+ *
+ *	If the read_pos is in the middle of padding, return the
+ *	position of the first actually available byte, otherwise
+ *	return the original value.
+ */
+static size_t relay_file_read_start_pos(size_t read_pos,
+					struct rchan_buf *buf)
+{
+	size_t read_subbuf, padding, padding_start, padding_end;
+	size_t subbuf_size = buf->chan->subbuf_size;
+	size_t n_subbufs = buf->chan->n_subbufs;
+
+	read_subbuf = read_pos / subbuf_size;
+	padding = buf->padding[read_subbuf];
+	padding_start = (read_subbuf + 1) * subbuf_size - padding;
+	padding_end = (read_subbuf + 1) * subbuf_size;
+	if (read_pos >= padding_start && read_pos < padding_end) {
+		read_subbuf = (read_subbuf + 1) % n_subbufs;
+		read_pos = read_subbuf * subbuf_size;
+	}
+
+	return read_pos;
+}
+
+/**
+ *	relay_file_read_end_pos - return the new read position
+ */
+static size_t relay_file_read_end_pos(struct rchan_buf *buf,
+				      size_t read_pos,
+				      size_t count)
+{
+	size_t read_subbuf, padding, end_pos;
+	size_t subbuf_size = buf->chan->subbuf_size;
+	size_t n_subbufs = buf->chan->n_subbufs;
+
+	read_subbuf = read_pos / subbuf_size;
+	padding = buf->padding[read_subbuf];
+	if (read_pos % subbuf_size + count + padding == subbuf_size)
+		end_pos = (read_subbuf + 1) * subbuf_size;
+	else
+		end_pos = read_pos + count;
+	if (end_pos >= subbuf_size * n_subbufs)
+		end_pos = 0;
+
+	return end_pos;
+}
+
+/**
+ *	relay_file_read - read file op for relay files
+ *	@filp: the file
+ *	@buffer: the userspace buffer
+ *	@count: number of bytes to read
+ *	@ppos: position to read from
+ *
+ *	Reads count bytes or the number of bytes available in the
+ *	current sub-buffer being read, whichever is smaller.
+ */
+static ssize_t relay_file_read(struct file *filp,
+			       char __user *buffer,
+			       size_t count,
+			       loff_t *ppos)
+{
+	struct rchan_buf *buf = filp->private_data;
+	struct inode *inode = filp->f_dentry->d_inode;
+	size_t read_start, avail;
+	ssize_t ret = 0;
+	void *from;
+
+	mutex_lock(&inode->i_mutex);
+	if(!relay_file_read_avail(buf, *ppos))
+		goto out;
+
+	read_start = relay_file_read_start_pos(*ppos, buf);
+	avail = relay_file_read_subbuf_avail(read_start, buf);
+	if (!avail)
+		goto out;
+
+	from = buf->start + read_start;
+	ret = count = min(count, avail);
+	if (copy_to_user(buffer, from, count)) {
+		ret = -EFAULT;
+		goto out;
+	}
+	relay_file_read_consume(buf, read_start, count);
+	*ppos = relay_file_read_end_pos(buf, read_start, count);
+out:
+	mutex_unlock(&inode->i_mutex);
+	return ret;
+}
+
+
+struct file_operations relay_file_operations = {
+	.owner = THIS_MODULE,
+	.open = relay_file_open,
+	.poll = relay_file_poll,
+	.mmap = relay_file_mmap,
+	.read = relay_file_read,
+	.llseek = no_llseek,
+	.release = relay_file_release,
+};
+
+static struct super_operations relayfs_ops = {
+	.statfs		= simple_statfs,
+	.drop_inode	= generic_delete_inode,
+};
+
+static int relayfs_fill_super(struct super_block * sb, void * data, int silent)
+{
+	struct inode *inode;
+	struct dentry *root;
+	int mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
+
+	sb->s_blocksize = PAGE_CACHE_SIZE;
+	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
+	sb->s_magic = RELAYFS_MAGIC;
+	sb->s_op = &relayfs_ops;
+	inode = relayfs_get_inode(sb, mode, NULL, NULL);
+
+	if (!inode)
+		return -ENOMEM;
+
+	root = d_alloc_root(inode);
+	if (!root) {
+		iput(inode);
+		return -ENOMEM;
+	}
+	sb->s_root = root;
+
+	return 0;
+}
+
+static struct super_block * relayfs_get_sb(struct file_system_type *fs_type,
+					   int flags, const char *dev_name,
+					   void *data)
+{
+	return get_sb_single(fs_type, flags, data, relayfs_fill_super);
+}
+
+static struct file_system_type relayfs_fs_type = {
+	.owner		= THIS_MODULE,
+	.name		= "relayfs",
+	.get_sb		= relayfs_get_sb,
+	.kill_sb	= kill_litter_super,
+};
+
+static int __init init_relayfs_fs(void)
+{
+	return register_filesystem(&relayfs_fs_type);
+}
+
+static void __exit exit_relayfs_fs(void)
+{
+	unregister_filesystem(&relayfs_fs_type);
+}
+
+fs_initcall(init_relayfs_fs);
+module_exit(exit_relayfs_fs)
+
+EXPORT_SYMBOL_GPL(relay_file_operations);
+EXPORT_SYMBOL_GPL(relayfs_create_dir);
+EXPORT_SYMBOL_GPL(relayfs_remove_dir);
+EXPORT_SYMBOL_GPL(relayfs_create_file);
+EXPORT_SYMBOL_GPL(relayfs_remove_file);
+
+MODULE_AUTHOR("Tom Zanussi <zanussi@us.ibm.com> and Karim Yaghmour <karim@opersys.com>");
+MODULE_DESCRIPTION("Relay Filesystem");
+MODULE_LICENSE("GPL");
+
--- /dev/null
+++ b/fs/relayfs/relay.c
@@ -0,0 +1,560 @@
+/*
+ * Public API and common code for RelayFS.
+ *
+ * See Documentation/filesystems/relayfs.txt for an overview of relayfs.
+ *
+ * Copyright (C) 2002-2005 - Tom Zanussi (zanussi@us.ibm.com), IBM Corp
+ * Copyright (C) 1999-2005 - Karim Yaghmour (karim@opersys.com)
+ *
+ * This file is released under the GPL.
+ */
+
+#include <linux/errno.h>
+#include <linux/stddef.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/relay.h>
+#include "relay.h"
+#include "buffers.h"
+
+
+/**
+ *	relay_buf_empty - boolean, is the channel buffer empty?
+ *	@buf: channel buffer
+ *
+ *	Returns 1 if the buffer is empty, 0 otherwise.
+ */
+int relay_buf_empty(struct rchan_buf *buf)
+{
+	return (buf->subbufs_produced - buf->subbufs_consumed) ? 0 : 1;
+}
+
+/**
+ *	relay_buf_full - boolean, is the channel buffer full?
+ *	@buf: channel buffer
+ *
+ *	Returns 1 if the buffer is full, 0 otherwise.
+ */
+int relay_buf_full(struct rchan_buf *buf)
+{
+	size_t ready = buf->subbufs_produced - buf->subbufs_consumed;
+	return (ready >= buf->chan->n_subbufs) ? 1 : 0;
+}
+
+/*
+ * High-level relayfs kernel API and associated functions.
+ */
+
+/*
+ * rchan_callback implementations defining default channel behavior.  Used
+ * in place of corresponding NULL values in client callback struct.
+ */
+
+/*
+ * subbuf_start() default callback.  Does nothing.
+ */
+static int subbuf_start_default_callback (struct rchan_buf *buf,
+					  void *subbuf,
+					  void *prev_subbuf,
+					  size_t prev_padding)
+{
+	if (relay_buf_full(buf))
+		return 0;
+
+	return 1;
+}
+
+/*
+ * deliver() default callback.  Does nothing.
+ */
+static void deliver_default_callback (struct rchan_buf *buf,
+				      unsigned subbuf_idx,
+				      void *subbuf)
+{
+}
+
+/*
+ * buf_mapped() default callback.  Does nothing.
+ */
+static void buf_mapped_default_callback(struct rchan_buf *buf,
+					struct file *filp)
+{
+}
+
+/*
+ * buf_unmapped() default callback.  Does nothing.
+ */
+static void buf_unmapped_default_callback(struct rchan_buf *buf,
+					  struct file *filp)
+{
+}
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
+	return relayfs_create_file(filename, parent, mode, buf->chan->fops,
+				   buf);
+}
+
+/*
+ * remove_buf_file() default callback.  Removes file representing relay buffer.
+ */
+static int remove_buf_file_default_callback(struct dentry *dentry)
+{
+	return relayfs_remove(dentry);
+}
+
+/*
+ * buf_full() default callback.  Does nothing.
+ */
+static void buf_full_default_callback(struct rchan_buf *buf,
+				      unsigned subbuf_idx,
+				      void *subbuf)
+{
+}
+
+/*
+ * buf_unfull() default callback.  Does nothing.
+ */
+static void buf_unfull_default_callback(struct rchan_buf *buf,
+				      unsigned subbuf_idx,
+				      void *subbuf)
+{
+}
+
+/* relay channel default callbacks */
+static struct rchan_callbacks default_channel_callbacks = {
+	.subbuf_start = subbuf_start_default_callback,
+	.deliver = deliver_default_callback,
+	.buf_mapped = buf_mapped_default_callback,
+	.buf_unmapped = buf_unmapped_default_callback,
+	.create_buf_file = create_buf_file_default_callback,
+	.remove_buf_file = remove_buf_file_default_callback,
+	.buf_full = buf_full_default_callback,
+	.buf_unfull = buf_unfull_default_callback,
+};
+
+/**
+ *	wakeup_readers - wake up readers waiting on a channel
+ *	@private: the channel buffer
+ *
+ *	This is the work function used to defer reader waking.  The
+ *	reason waking is deferred is that calling directly from write
+ *	causes problems if you're writing from say the scheduler.
+ */
+static void wakeup_readers(void *private)
+{
+	struct rchan_buf *buf = private;
+	wake_up_interruptible(&buf->read_wait);
+}
+
+/**
+ *	get_next_subbuf - return next sub-buffer within channel buffer
+ *	@buf: channel buffer
+ */
+static inline void *get_next_subbuf(struct rchan_buf *buf)
+{
+	void *next = buf->data + buf->chan->subbuf_size;
+	if (next >= buf->start + buf->chan->subbuf_size * buf->chan->n_subbufs)
+		next = buf->start;
+
+	return next;
+}
+
+/**
+ *	__relay_reset - reset a channel buffer
+ *	@buf: the channel buffer
+ *	@init: 1 if this is a first-time initialization
+ *	@subbufs_count number of subbuffers
+ *
+ *	See relay_reset for description of effect.
+ */
+static inline void __relay_reset(struct rchan_buf *buf, unsigned int init)
+{
+	size_t i;
+
+	if (init) {
+		init_waitqueue_head(&buf->read_wait);
+		kref_init(&buf->kref);
+		INIT_WORK(&buf->wake_readers, NULL, NULL);
+	} else {
+		cancel_delayed_work(&buf->wake_readers);
+		flush_scheduled_work();
+	}
+
+	buf->subbufs_produced = 0;
+	buf->subbufs_consumed = 0;
+	buf->bytes_consumed = 0;
+	atomic_set(&buf->full, 0);
+	buf->finalized = 0;
+	buf->data = buf->start;
+	buf->offset = 0;
+	atomic_set(&buf->open_count, 1);
+
+	for (i = 0; i < buf->chan->n_subbufs; i++)
+		buf->padding[i] = 0;
+
+	buf->chan->cb->subbuf_start(buf, buf->data, NULL, 0);
+}
+
+/**
+ *	relay_reset - reset the channel
+ *	@chan: the channel
+ *
+ *	Returns 0 if successful, negative if not.
+ *
+ *	This has the effect of erasing all data from all channel buffers
+ *	and restarting the channel in its initial state.  The buffers
+ *	are not freed, so any mappings are still in effect.
+ *
+ *	NOTE: Care should be taken that the channel isn't actually
+ *	being used by anything when this call is made.
+ */
+void relay_reset(struct rchan *chan)
+{
+	unsigned int i;
+	struct rchan_buf *prev = NULL;
+
+	if (!chan)
+		return;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!chan->buf[i] || chan->buf[i] == prev)
+			break;
+		__relay_reset(chan->buf[i], 0);
+		prev = chan->buf[i];
+	}
+}
+
+/**
+ *	relay_open_buf - create a new channel buffer in relayfs
+ *
+ *	Internal - used by relay_open().
+ */
+static struct rchan_buf *relay_open_buf(struct rchan *chan,
+					const char *filename,
+					struct dentry *parent,
+					int *is_global)
+{
+	struct rchan_buf *buf;
+	struct dentry *dentry;
+
+	if (*is_global)
+		return chan->buf[0];
+
+ 	buf = relay_create_buf(chan);
+ 	if (!buf)
+ 		return NULL;
+
+	/* Create file in fs */
+ 	dentry = chan->cb->create_buf_file(filename, parent, S_IRUSR,
+ 					   buf, is_global);
+ 	if (!dentry) {
+ 		relay_destroy_buf(buf);
+		return NULL;
+ 	}
+
+	buf->dentry = dentry;
+	__relay_reset(buf, 1);
+
+	return buf;
+}
+
+/**
+ *	relay_close_buf - close a channel buffer
+ *	@buf: channel buffer
+ *
+ *	Marks the buffer finalized and restores the default callbacks.
+ *	The channel buffer and channel buffer data structure are then freed
+ *	automatically when the last reference is given up.
+ */
+static inline void relay_close_buf(struct rchan_buf *buf)
+{
+	buf->finalized = 1;
+	buf->chan->cb = &default_channel_callbacks;
+	//cancel_delayed_work(&buf->wake_readers);
+	//flush_scheduled_work();
+	kref_put(&buf->kref, relay_remove_buf);
+}
+
+static inline void setup_callbacks(struct rchan *chan,
+				   struct rchan_callbacks *cb)
+{
+	if (!cb) {
+		chan->cb = &default_channel_callbacks;
+		return;
+	}
+
+	if (!cb->subbuf_start)
+		cb->subbuf_start = subbuf_start_default_callback;
+	if (!cb->deliver)
+		cb->deliver = deliver_default_callback;
+	if (!cb->buf_mapped)
+		cb->buf_mapped = buf_mapped_default_callback;
+	if (!cb->buf_unmapped)
+		cb->buf_unmapped = buf_unmapped_default_callback;
+	if (!cb->create_buf_file)
+		cb->create_buf_file = create_buf_file_default_callback;
+	if (!cb->remove_buf_file)
+		cb->remove_buf_file = remove_buf_file_default_callback;
+	if (!cb->buf_full)
+		cb->buf_full = buf_full_default_callback;
+	if (!cb->buf_unfull)
+		cb->buf_unfull = buf_unfull_default_callback;
+	chan->cb = cb;
+}
+
+/**
+ *	relay_open - create a new relayfs channel
+ *	@base_filename: base name of files to create
+ *	@parent: dentry of parent directory, NULL for root directory
+ *	@subbuf_size: size of sub-buffers
+ *	@n_subbufs: number of sub-buffers
+ *	@overwrite: overwrite buffer when full?
+ *	@cb: client callback functions
+ *	@fops: client file operations (override relayfs). NULL for default.
+ *	@client_data: client specific data
+ *	@free_client_data_cb: callback function to free the client data.
+ *
+ *	Returns channel pointer if successful, NULL otherwise.
+ *
+ *	Creates a channel buffer for each cpu using the sizes and
+ *	attributes specified.  The created channel buffer files
+ *	will be named base_filename0...base_filenameN-1.  File
+ *	permissions will be S_IRUSR.
+ *	relay_open increments the usage count of the client_module.
+ */
+struct rchan *relay_open(const char *base_filename,
+			 struct dentry *parent,
+			 size_t subbuf_size,
+			 size_t n_subbufs,
+			 int overwrite,
+			 struct module *client_module,
+			 struct rchan_callbacks *cb,
+			 struct file_operations *fops,
+			 void *client_data,
+			 void (*free_client_data_cb)(void*))
+{
+	unsigned int i;
+	struct rchan *chan;
+	char *tmpname;
+	int is_global = 0;
+
+	if (!base_filename)
+		return NULL;
+
+	if (!(subbuf_size && n_subbufs))
+		return NULL;
+
+	chan = kcalloc(1, sizeof(struct rchan), GFP_KERNEL);
+	if (!chan)
+		return NULL;
+
+	chan->version = RELAYFS_CHANNEL_VERSION;
+	chan->overwrite = overwrite;
+	chan->n_subbufs = n_subbufs;
+	chan->subbuf_size = subbuf_size;
+	chan->alloc_size = FIX_SIZE(subbuf_size * n_subbufs);
+	chan->client_module = client_module;
+	//if(!try_module_get(client_module)) {
+	//	printk(KERN_ERR "RelayFS : cannot increment client module refcount\n");
+	//	return NULL;
+	//}
+	chan->client_data = client_data;
+	chan->free_client_data_cb = free_client_data_cb;
+	setup_callbacks(chan, cb);
+	if(fops) chan->fops = fops;
+	else chan->fops = &relay_file_operations;
+	kref_init(&chan->kref);
+
+	tmpname = kmalloc(NAME_MAX + 1, GFP_KERNEL);
+	if (!tmpname)
+		goto free_chan;
+
+	for_each_online_cpu(i) {
+		sprintf(tmpname, "%s_%d", base_filename, i);
+		chan->buf[i] = relay_open_buf(chan, tmpname, parent,
+					      &is_global);
+		chan->buf[i]->cpu = i;
+		if (!chan->buf[i])
+			goto free_bufs;
+	}
+
+	kfree(tmpname);
+	return chan;
+
+free_bufs:
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!chan->buf[i])
+			break;
+		relay_close_buf(chan->buf[i]);
+		if (is_global)
+			break;
+	}
+	kfree(tmpname);
+
+free_chan:
+	kref_put(&chan->kref, relay_destroy_channel);
+	return NULL;
+}
+
+/**
+ *	relay_switch_subbuf - switch to a new sub-buffer
+ *	@buf: channel buffer
+ *	@length: size of current event
+ *
+ *	Returns either the length passed in or 0 if full.
+
+ *	Performs sub-buffer-switch tasks such as invoking callbacks,
+ *	updating padding counts, waking up readers, etc.
+ */
+size_t relay_switch_subbuf(struct rchan_buf *buf, size_t length)
+{
+	void *old, *new;
+	size_t old_subbuf, new_subbuf;
+
+	if (unlikely(length > buf->chan->subbuf_size))
+		goto toobig;
+
+	if (buf->offset != buf->chan->subbuf_size + 1) {
+		buf->prev_padding = buf->chan->subbuf_size - buf->offset;
+		old_subbuf = buf->subbufs_produced % buf->chan->n_subbufs;
+		buf->padding[old_subbuf] = buf->prev_padding;
+		buf->subbufs_produced++;
+		if (waitqueue_active(&buf->read_wait)) {
+			PREPARE_WORK(&buf->wake_readers, wakeup_readers, buf);
+			schedule_delayed_work(&buf->wake_readers, 1);
+		}
+	}
+
+	old = buf->data;
+	new_subbuf = buf->subbufs_produced % buf->chan->n_subbufs;
+	new = buf->start + new_subbuf * buf->chan->subbuf_size;
+	buf->offset = 0;
+	if (!buf->chan->cb->subbuf_start(buf, new, old, buf->prev_padding)) {
+		buf->offset = buf->chan->subbuf_size + 1;
+		return 0;
+	}
+	buf->data = new;
+	buf->padding[new_subbuf] = 0;
+
+	if (unlikely(length + buf->offset > buf->chan->subbuf_size))
+		goto toobig;
+
+	return length;
+
+toobig:
+	buf->chan->last_toobig = length;
+	return 0;
+}
+
+/**
+ *	relay_subbufs_consumed - update the buffer's sub-buffers-consumed count
+ *	@chan: the channel
+ *	@cpu: the cpu associated with the channel buffer to update
+ *	@subbufs_consumed: number of sub-buffers to add to current buf's count
+ *
+ *	Adds to the channel buffer's consumed sub-buffer count.
+ *	subbufs_consumed should be the number of sub-buffers newly consumed,
+ *	not the total consumed.
+ *
+ *	NOTE: kernel clients don't need to call this function if the channel
+ *	mode is 'overwrite'.
+ */
+void relay_subbufs_consumed(struct rchan *chan,
+			    unsigned int cpu,
+			    size_t subbufs_consumed)
+{
+	struct rchan_buf *buf;
+
+	if (!chan)
+		return;
+
+	if (cpu >= NR_CPUS || !chan->buf[cpu])
+		return;
+
+	buf = chan->buf[cpu];
+	buf->subbufs_consumed += subbufs_consumed;
+	if (buf->subbufs_consumed > buf->subbufs_produced)
+		buf->subbufs_consumed = buf->subbufs_produced;
+}
+
+/**
+ *	relay_destroy_channel - free the channel struct
+ *
+ *	Should only be called from kref_put().
+ */
+void relay_destroy_channel(struct kref *kref)
+{
+	struct rchan *chan = container_of(kref, struct rchan, kref);
+	//module_put(chan->client_module);
+	if(chan->free_client_data_cb)
+		chan->free_client_data_cb(chan->client_data);
+	kfree(chan);
+}
+
+/**
+ *	relay_close - close the channel
+ *	@chan: the channel
+ *
+ *	Closes all channel buffers and frees the channel.
+ */
+void relay_close(struct rchan *chan)
+{
+	unsigned int i;
+	struct rchan_buf *prev = NULL;
+
+	if (!chan)
+		return;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!chan->buf[i] || chan->buf[i] == prev)
+			break;
+		relay_close_buf(chan->buf[i]);
+		prev = chan->buf[i];
+	}
+
+	if (chan->last_toobig)
+		printk(KERN_WARNING "relayfs: one or more items not logged "
+		       "[item size (%Zd) > sub-buffer size (%Zd)]\n",
+		       chan->last_toobig, chan->subbuf_size);
+
+	kref_put(&chan->kref, relay_destroy_channel);
+}
+
+/**
+ *	relay_flush - close the channel
+ *	@chan: the channel
+ *
+ *	Flushes all channel buffers i.e. forces buffer switch.
+ */
+void relay_flush(struct rchan *chan)
+{
+	unsigned int i;
+	struct rchan_buf *prev = NULL;
+
+	if (!chan)
+		return;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!chan->buf[i] || chan->buf[i] == prev)
+			break;
+		relay_switch_subbuf(chan->buf[i], 0);
+		prev = chan->buf[i];
+	}
+}
+
+EXPORT_SYMBOL_GPL(relay_open);
+EXPORT_SYMBOL_GPL(relay_close);
+EXPORT_SYMBOL_GPL(relay_flush);
+EXPORT_SYMBOL_GPL(relay_reset);
+EXPORT_SYMBOL_GPL(relay_subbufs_consumed);
+EXPORT_SYMBOL_GPL(relay_switch_subbuf);
+EXPORT_SYMBOL_GPL(relay_buf_full);
--- /dev/null
+++ b/fs/relayfs/buffers.c
@@ -0,0 +1,190 @@
+/*
+ * RelayFS buffer management code.
+ *
+ * Copyright (C) 2002-2005 - Tom Zanussi (zanussi@us.ibm.com), IBM Corp
+ * Copyright (C) 1999-2005 - Karim Yaghmour (karim@opersys.com)
+ *
+ * This file is released under the GPL.
+ */
+
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include <linux/mm.h>
+#include <linux/relay.h>
+#include "relay.h"
+#include "buffers.h"
+
+/*
+ * close() vm_op implementation for relayfs file mapping.
+ */
+static void relay_file_mmap_close(struct vm_area_struct *vma)
+{
+	struct rchan_buf *buf = vma->vm_private_data;
+	buf->chan->cb->buf_unmapped(buf, vma->vm_file);
+}
+
+/*
+ * nopage() vm_op implementation for relayfs file mapping.
+ */
+static struct page *relay_buf_nopage(struct vm_area_struct *vma,
+				     unsigned long address,
+				     int *type)
+{
+	struct page *page;
+	struct rchan_buf *buf = vma->vm_private_data;
+	unsigned long offset = address - vma->vm_start;
+
+	if (address > vma->vm_end)
+		return NOPAGE_SIGBUS; /* Disallow mremap */
+	if (!buf)
+		return NOPAGE_OOM;
+
+	page = vmalloc_to_page(buf->start + offset);
+	if (!page)
+		return NOPAGE_OOM;
+	get_page(page);
+
+	if (type)
+		*type = VM_FAULT_MINOR;
+
+	return page;
+}
+
+/*
+ * vm_ops for relay file mappings.
+ */
+static struct vm_operations_struct relay_file_mmap_ops = {
+	.nopage = relay_buf_nopage,
+	.close = relay_file_mmap_close,
+};
+
+/**
+ *	relay_mmap_buf: - mmap channel buffer to process address space
+ *	@buf: relay channel buffer
+ *	@vma: vm_area_struct describing memory to be mapped
+ *
+ *	Returns 0 if ok, negative on error
+ *
+ *	Caller should already have grabbed mmap_sem.
+ */
+int relay_mmap_buf(struct rchan_buf *buf, struct vm_area_struct *vma)
+{
+	unsigned long length = vma->vm_end - vma->vm_start;
+	struct file *filp = vma->vm_file;
+
+	if (!buf)
+		return -EBADF;
+
+	if (length != (unsigned long)buf->chan->alloc_size)
+		return -EINVAL;
+
+	vma->vm_ops = &relay_file_mmap_ops;
+	vma->vm_private_data = buf;
+	buf->chan->cb->buf_mapped(buf, filp);
+
+	return 0;
+}
+
+/**
+ *	relay_alloc_buf - allocate a channel buffer
+ *	@buf: the buffer struct
+ *	@size: total size of the buffer
+ *
+ *	Returns a pointer to the resulting buffer, NULL if unsuccessful
+ */
+static void *relay_alloc_buf(struct rchan_buf *buf, unsigned long size)
+{
+	void *mem;
+	unsigned int i, j, n_pages;
+
+	size = PAGE_ALIGN(size);
+	n_pages = size >> PAGE_SHIFT;
+
+	buf->page_array = kcalloc(n_pages, sizeof(struct page *), GFP_KERNEL);
+	if (!buf->page_array)
+		return NULL;
+
+	for (i = 0; i < n_pages; i++) {
+		buf->page_array[i] = alloc_page(GFP_KERNEL);
+		if (unlikely(!buf->page_array[i]))
+			goto depopulate;
+	}
+	mem = vmap(buf->page_array, n_pages, VM_MAP, PAGE_KERNEL);
+	if (!mem)
+		goto depopulate;
+
+	memset(mem, 0, size);
+	buf->page_count = n_pages;
+	return mem;
+
+depopulate:
+	for (j = 0; j < i; j++)
+		__free_page(buf->page_array[j]);
+	kfree(buf->page_array);
+	return NULL;
+}
+
+/**
+ *	relay_create_buf - allocate and initialize a channel buffer
+ *	@alloc_size: size of the buffer to allocate
+ *	@n_subbufs: number of sub-buffers in the channel
+ *
+ *	Returns channel buffer if successful, NULL otherwise
+ */
+struct rchan_buf *relay_create_buf(struct rchan *chan)
+{
+	struct rchan_buf *buf = kcalloc(1, sizeof(struct rchan_buf), GFP_KERNEL);
+	if (!buf)
+		return NULL;
+
+	buf->padding = kmalloc(chan->n_subbufs * sizeof(size_t *), GFP_KERNEL);
+	if (!buf->padding)
+		goto free_buf;
+
+	buf->start = relay_alloc_buf(buf, chan->alloc_size);
+	if (!buf->start)
+		goto free_buf;
+
+	buf->chan = chan;
+	kref_get(&buf->chan->kref);
+	return buf;
+
+free_buf:
+	kfree(buf->padding);
+	kfree(buf);
+	return NULL;
+}
+
+/**
+ *	relay_destroy_buf - destroy an rchan_buf struct and associated buffer
+ *	@buf: the buffer struct
+ */
+void relay_destroy_buf(struct rchan_buf *buf)
+{
+	struct rchan *chan = buf->chan;
+	unsigned int i;
+
+	if (likely(buf->start)) {
+		vunmap(buf->start);
+		for (i = 0; i < buf->page_count; i++)
+			__free_page(buf->page_array[i]);
+		kfree(buf->page_array);
+	}
+	kfree(buf->padding);
+	kfree(buf);
+	kref_put(&chan->kref, relay_destroy_channel);
+}
+
+/**
+ *	relay_remove_buf - remove a channel buffer
+ *
+ *	Removes the file from the relayfs fileystem, which also frees the
+ *	rchan_buf_struct and the channel buffer.  Should only be called from
+ *	kref_put().
+ */
+void relay_remove_buf(struct kref *kref)
+{
+	struct rchan_buf *buf = container_of(kref, struct rchan_buf, kref);
+	buf->chan->cb->remove_buf_file(buf->dentry);
+	relay_destroy_buf(buf);
+}
--- /dev/null
+++ b/fs/relayfs/buffers.h
@@ -0,0 +1,9 @@
+#ifndef _BUFFERS_H
+#define _BUFFERS_H
+
+extern int relay_mmap_buf(struct rchan_buf *buf, struct vm_area_struct *vma);
+extern struct rchan_buf *relay_create_buf(struct rchan *chan);
+extern void relay_destroy_buf(struct rchan_buf *buf);
+extern void relay_remove_buf(struct kref *kref);
+
+#endif/* _BUFFERS_H */
--- /dev/null
+++ b/fs/relayfs/relay.h
@@ -0,0 +1,12 @@
+#ifndef _RELAY_H
+#define _RELAY_H
+
+extern int relayfs_remove(struct dentry *dentry);
+extern int relay_buf_empty(struct rchan_buf *buf);
+extern int relay_buf_full(struct rchan_buf *buf);
+extern void relay_destroy_channel(struct kref *kref);
+extern void setup_fileops(struct rchan *chan,
+				   struct file_operations *fops,
+					 struct module *client_module);
+
+#endif /* _RELAY_H */
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -102,3 +102,4 @@ obj-$(CONFIG_HOSTFS)		+= hostfs/
 obj-$(CONFIG_HPPFS)		+= hppfs/
 obj-$(CONFIG_DEBUG_FS)		+= debugfs/
 obj-$(CONFIG_OCFS2_FS)		+= ocfs2/
+obj-$(CONFIG_RELAY)		+= relayfs/
--- a/block/blktrace.c
+++ b/block/blktrace.c
@@ -330,7 +330,7 @@ static int blk_trace_setup(request_queue
 	if (!bt->dropped_file)
 		goto err;
 
-	bt->rchan = relay_open("trace", dir, buts.buf_size, buts.buf_nr, &blk_relay_callbacks);
+	bt->rchan = relay_open("trace", dir, buts.buf_size, buts.buf_nr, 0, THIS_MODULE, &blk_relay_callbacks, NULL, NULL, NULL);
 	if (!bt->rchan)
 		goto err;
 	bt->rchan->private_data = bt;

--=_Krystal-12024-1158205780-0001-2--
