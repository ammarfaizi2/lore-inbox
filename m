Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263239AbUKTXWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263239AbUKTXWP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 18:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263246AbUKTXU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 18:20:57 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:17547 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S263206AbUKTXJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 18:09:47 -0500
To: akpm@osdl.org, torvalds@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/13] Filesystem in Userspace
Message-Id: <E1CVeML-0007PA-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 21 Nov 2004 00:09:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds FUSE core. 

This contains the following files:

 o dev.c
    - fuse device operations (read, write, release, poll)
    - adds /sys/fs/fuse/version
    - registers misc device

 o dir.c
    - directory operations (only lookup this patch)

 o inode.c
    - superblock operations (alloc_inode, destroy_inode, read_inode,
      clear_inode, put_super, show_options)
    - registers FUSE filesystem

 o util.c
    - module initialization and cleanup

 o fuse_i.h
    - private header file

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
--- linux-2.6.10-rc2/fs/fuse/dev.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/dev.c	2004-11-20 22:56:25.000000000 +0100
@@ -0,0 +1,538 @@
+/*
+    FUSE: Filesystem in Userspace
+    Copyright (C) 2001-2004  Miklos Szeredi <miklos@szeredi.hu>
+
+    This program can be distributed under the terms of the GNU GPL.
+    See the file COPYING.
+*/
+
+#include "fuse_i.h"
+
+#include <linux/module.h>
+#include <linux/poll.h>
+#include <linux/kobject.h>
+#include <linux/miscdevice.h>
+#include <linux/file.h>
+
+static kmem_cache_t *fuse_req_cachep;
+
+static inline struct fuse_conn *fuse_get_conn(struct file *file)
+{
+	struct fuse_conn *fc;
+	spin_lock(&fuse_lock);
+	fc = file->private_data;
+	if (fc && !fc->sb)
+		fc = NULL;
+	spin_unlock(&fuse_lock);
+	return fc;
+}
+
+struct fuse_req *fuse_request_alloc(void)
+{
+	struct fuse_req *req = kmem_cache_alloc(fuse_req_cachep, SLAB_KERNEL);
+	if (req) {
+		memset(req, 0, sizeof(*req));
+		INIT_LIST_HEAD(&req->list);
+		init_waitqueue_head(&req->waitq);
+	}
+	return req;
+}
+
+void fuse_request_free(struct fuse_req *req)
+{
+	kmem_cache_free(fuse_req_cachep, req);
+}
+
+/* Called with fuse_lock held.  Releases, and then reaquires it. */
+static void request_wait_answer(struct fuse_req *req)
+{
+	spin_unlock(&fuse_lock);
+	wait_event(req->waitq, req->finished);
+	spin_lock(&fuse_lock);
+}
+
+static int get_unique(struct fuse_conn *fc)
+{
+	fc->reqctr++;
+	if (fc->reqctr == 0)
+		fc->reqctr = 1;
+	return fc->reqctr;
+}
+
+void fuse_reset_request(struct fuse_req *req)
+{
+	int preallocated = req->preallocated;
+	
+	memset(req, 0, sizeof(*req));
+	INIT_LIST_HEAD(&req->list);
+	init_waitqueue_head(&req->waitq);
+	req->preallocated = preallocated;
+}
+
+static struct fuse_req *do_get_request(struct fuse_conn *fc)
+{
+	struct fuse_req *req;
+
+	spin_lock(&fuse_lock);
+	BUG_ON(list_empty(&fc->unused_list));
+	req = list_entry(fc->unused_list.next, struct fuse_req, list);
+	list_del_init(&req->list);
+	spin_unlock(&fuse_lock);
+	fuse_reset_request(req);
+	req->in.h.uid = current->fsuid;
+	req->in.h.gid = current->fsgid;
+	req->in.h.pid = current->pid;
+	return req;
+}
+
+struct fuse_req *fuse_get_request(struct fuse_conn *fc)
+{
+	if (down_interruptible(&fc->unused_sem))
+		return NULL;
+	return  do_get_request(fc);
+}
+
+struct fuse_req *fuse_get_request_nonblock(struct fuse_conn *fc)
+{
+	if (down_trylock(&fc->unused_sem))
+		return NULL;
+	return  do_get_request(fc);
+}
+
+void fuse_put_request(struct fuse_conn *fc, struct fuse_req *req)
+{
+	if (!req->preallocated)
+		fuse_request_free(req);
+	else {
+		spin_lock(&fuse_lock);
+		list_add(&req->list, &fc->unused_list);
+		spin_unlock(&fuse_lock);
+		up(&fc->unused_sem);
+	}
+}
+
+/* Must be called with fuse_lock held, and unlocks it */
+static void request_end(struct fuse_conn *fc, struct fuse_req *req)
+{
+	wake_up(&req->waitq);
+	spin_unlock(&fuse_lock);
+}
+
+void request_send(struct fuse_conn *fc, struct fuse_req *req)
+{
+	req->isreply = 1;
+		
+	spin_lock(&fuse_lock);
+	req->out.h.error = -ENOTCONN;
+	if (fc->file) {
+		req->in.h.unique = get_unique(fc);		
+		list_add_tail(&req->list, &fc->pending);
+		wake_up(&fc->waitq);
+		request_wait_answer(req);
+		list_del(&req->list);
+	}
+	spin_unlock(&fuse_lock);
+}
+
+void request_send_noreply(struct fuse_conn *fc, struct fuse_req *req)
+{
+	req->isreply = 0;
+
+	spin_lock(&fuse_lock);
+	if (fc->file) {
+		list_add_tail(&req->list, &fc->pending);
+		wake_up(&fc->waitq);
+		spin_unlock(&fuse_lock);
+	} else {
+		spin_unlock(&fuse_lock);
+		fuse_put_request(fc, req);
+	}
+}
+
+static void request_wait(struct fuse_conn *fc)
+{
+	DECLARE_WAITQUEUE(wait, current);
+
+	add_wait_queue_exclusive(&fc->waitq, &wait);
+	while (fc->sb && list_empty(&fc->pending)) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (signal_pending(current))
+			break;
+
+		spin_unlock(&fuse_lock);
+		schedule();
+		spin_lock(&fuse_lock);
+	}
+	set_current_state(TASK_RUNNING);
+	remove_wait_queue(&fc->waitq, &wait);
+}
+
+static inline int copy_in_one(const void *src, size_t srclen,
+			      char __user **dstp, size_t *dstlenp)
+{
+	if (*dstlenp < srclen) {
+		printk("fuse_dev_read: buffer too small\n");
+		return -EINVAL;
+	}
+			
+	if (srclen && copy_to_user(*dstp, src, srclen))
+		return -EFAULT;
+
+	*dstp += srclen;
+	*dstlenp -= srclen;
+
+	return 0;
+}
+
+static inline int copy_in_args(struct fuse_in *in, char __user *buf,
+			       size_t nbytes)
+{
+	int err;
+	int i;
+	size_t orignbytes = nbytes;
+		
+	err = copy_in_one(&in->h, sizeof(in->h), &buf, &nbytes);
+	if (err)
+		return err;
+
+	for (i = 0; i < in->numargs; i++) {
+		struct fuse_in_arg *arg = &in->args[i];
+		err = copy_in_one(arg->value, arg->size, &buf, &nbytes);
+		if (err)
+			return err;
+	}
+
+	return orignbytes - nbytes;
+}
+
+static ssize_t fuse_dev_read(struct file *file, char __user *buf,
+			     size_t nbytes, loff_t *off)
+{
+	ssize_t ret;
+	struct fuse_conn *fc;
+	struct fuse_req *req = NULL;
+
+	spin_lock(&fuse_lock);
+	fc = file->private_data;
+	if (!fc) {
+		spin_unlock(&fuse_lock);
+		return -EPERM;
+	}
+	request_wait(fc);
+	if (!fc->sb)
+		fc = NULL;
+	else if (!list_empty(&fc->pending)) {
+		req = list_entry(fc->pending.next, struct fuse_req, list);
+		list_del_init(&req->list);
+	}
+	spin_unlock(&fuse_lock);
+	if (!fc)
+		return -ENODEV;
+	if (req == NULL)
+		return -EINTR;
+
+	ret = copy_in_args(&req->in, buf, nbytes);
+	spin_lock(&fuse_lock);
+	if (req->isreply) {
+		if (ret < 0) {
+			req->out.h.error = -EPROTO;
+			req->finished = 1;
+		} else
+			list_add_tail(&req->list, &fc->processing);
+		if (ret < 0)
+			/* Unlocks fuse_lock: */
+			request_end(fc, req);
+		else
+			spin_unlock(&fuse_lock);
+	} else {
+		spin_unlock(&fuse_lock);
+		fuse_put_request(fc, req);
+	}
+	return ret;
+}
+
+static struct fuse_req *request_find(struct fuse_conn *fc, unsigned int unique)
+{
+	struct list_head *entry;
+	struct fuse_req *req = NULL;
+
+	list_for_each(entry, &fc->processing) {
+		struct fuse_req *tmp;
+		tmp = list_entry(entry, struct fuse_req, list);
+		if (tmp->in.h.unique == unique) {
+			req = tmp;
+			break;
+		}
+	}
+
+	return req;
+}
+
+static inline int copy_out_one(struct fuse_out_arg *arg,
+			       const char __user **srcp,
+			       size_t *srclenp, int allowvar)
+{
+	size_t dstlen = arg->size;
+	if (*srclenp < dstlen) {
+		if (!allowvar) {
+			printk("fuse_dev_write: write is short\n");
+			return -EINVAL;
+		}
+		dstlen = *srclenp;
+	}
+
+	if (dstlen && copy_from_user(arg->value, *srcp, dstlen))
+		return -EFAULT;
+
+	*srcp += dstlen;
+	*srclenp -= dstlen;
+	arg->size = dstlen;
+
+	return 0;
+}
+
+static inline int copy_out_args(struct fuse_req *req, const char __user *buf,
+				size_t nbytes)
+{
+	struct fuse_out *out = &req->out;
+	int err;
+	int i;
+
+	buf += sizeof(struct fuse_out_header);
+	nbytes -= sizeof(struct fuse_out_header);
+		
+	if (!out->h.error) {
+		for (i = 0; i < out->numargs; i++) {
+			struct fuse_out_arg *arg = &out->args[i];
+			int allowvar;
+			
+			if (out->argvar && i == out->numargs - 1)
+				allowvar = 1;
+			else
+				allowvar = 0;
+			
+			err = copy_out_one(arg, &buf, &nbytes, allowvar);
+			if (err)
+				return err;
+		}
+	}
+
+	if (nbytes != 0) {
+		printk("fuse_dev_write: write is long\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static inline int copy_out_header(struct fuse_out_header *oh,
+				  const char __user *buf, size_t nbytes)
+{
+	if (nbytes < sizeof(struct fuse_out_header)) {
+		printk("fuse_dev_write: write is short\n");
+		return -EINVAL;
+	}
+	
+	if (copy_from_user(oh, buf, sizeof(struct fuse_out_header)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static ssize_t fuse_dev_write(struct file *file, const char __user *buf,
+			      size_t nbytes, loff_t *off)
+{
+	int err;
+	struct fuse_conn *fc = fuse_get_conn(file);
+	struct fuse_req *req;
+	struct fuse_out_header oh;
+	
+	if (!fc)
+		return -ENODEV;
+
+	err = copy_out_header(&oh, buf, nbytes);
+	if (err)
+		return err;
+
+	if (!oh.unique)	{
+		err = -EINVAL;
+		goto out;
+	}     
+
+        if (oh.error <= -1000 || oh.error > 0) {
+                printk("fuse_dev_write: bad error value\n");
+                return -EINVAL;
+        }
+
+	spin_lock(&fuse_lock);
+	req = request_find(fc, oh.unique);
+	if (req != NULL)
+		list_del_init(&req->list);
+	spin_unlock(&fuse_lock);
+	if (!req)
+		return -ENOENT;
+
+	req->out.h = oh;
+	err = copy_out_args(req, buf, nbytes);
+
+	spin_lock(&fuse_lock);
+	if (err)
+		req->out.h.error = -EPROTO;
+
+	req->finished = 1;
+	/* Unlocks fuse_lock: */
+	request_end(fc, req);
+
+  out:
+	if (!err)
+		return nbytes;
+	else
+		return err;
+}
+
+static unsigned int fuse_dev_poll(struct file *file, poll_table *wait)
+{
+	struct fuse_conn *fc = fuse_get_conn(file);
+	unsigned int mask = POLLOUT | POLLWRNORM;
+
+	if (!fc)
+		return -ENODEV;
+
+	poll_wait(file, &fc->waitq, wait);
+
+	spin_lock(&fuse_lock);
+	if (!list_empty(&fc->pending))
+                mask |= POLLIN | POLLRDNORM;
+	spin_unlock(&fuse_lock);
+
+	return mask;
+}
+
+static void end_requests(struct fuse_conn *fc, struct list_head *head)
+{
+	while (!list_empty(head)) {
+		struct fuse_req *req;
+		req = list_entry(head->next, struct fuse_req, list);
+		list_del_init(&req->list);
+		if (req->isreply) {
+			req->out.h.error = -ECONNABORTED;
+			req->finished = 1;
+			/* Unlocks fuse_lock: */
+			request_end(fc, req);
+			spin_lock(&fuse_lock);
+		} else {
+			spin_unlock(&fuse_lock);
+			fuse_put_request(fc, req);
+			spin_lock(&fuse_lock);
+		}
+	}
+}
+
+static int fuse_dev_release(struct inode *inode, struct file *file)
+{
+	struct fuse_conn *fc;
+
+	spin_lock(&fuse_lock);
+	fc = file->private_data;
+	if (fc) {
+		fc->file = NULL;
+		end_requests(fc, &fc->pending);
+		end_requests(fc, &fc->processing);
+		fuse_release_conn(fc);
+	}
+	spin_unlock(&fuse_lock);
+	return 0;
+}
+
+struct file_operations fuse_dev_operations = {
+	.owner		= THIS_MODULE,
+	.read		= fuse_dev_read,
+	.write		= fuse_dev_write,
+	.poll		= fuse_dev_poll,
+	.release	= fuse_dev_release,
+};
+
+#define FUSE_MINOR MISC_DYNAMIC_MINOR
+
+static decl_subsys(fuse, NULL, NULL);
+
+static ssize_t version_show(struct subsystem *subsys, char *buf)
+{
+	return sprintf(buf, "%i.%i\n", FUSE_KERNEL_VERSION,
+		       FUSE_KERNEL_MINOR_VERSION);
+}
+static struct subsys_attribute fuse_attr_version = __ATTR_RO(version);
+
+static struct miscdevice fuse_miscdevice = {
+	.minor = FUSE_MINOR,
+	.name  = "fuse",
+	.fops = &fuse_dev_operations,
+};
+
+static int __init fuse_sysfs_init(void)
+{
+	int err;
+	err = fs_subsys_register(&fuse_subsys);
+	if (err)
+		return err;
+	err = subsys_create_file(&fuse_subsys, &fuse_attr_version);
+	if (err) {
+		subsystem_unregister(&fuse_subsys);
+		return err;
+	}
+	return 0;
+}
+
+static void fuse_sysfs_clean(void)
+{
+	subsys_remove_file(&fuse_subsys, &fuse_attr_version);
+	subsystem_unregister(&fuse_subsys);
+}
+
+static int __init fuse_device_init(void)
+{
+	int err = fuse_sysfs_init();
+	if (err)
+		return err;
+
+	err = misc_register(&fuse_miscdevice);
+	if (err) {
+		fuse_sysfs_clean();
+		return err;
+	}
+	return 0;
+}
+
+static void fuse_device_clean(void)
+{
+	misc_deregister(&fuse_miscdevice);
+	fuse_sysfs_clean();
+}
+
+int __init fuse_dev_init(void)
+{
+	int err;
+	err = fuse_device_init();
+	if (err)
+		goto out;
+
+	err = -ENOMEM;
+	fuse_req_cachep = kmem_cache_create("fuser_request",
+					    sizeof(struct fuse_req),
+					    0, 0, NULL, NULL);
+	if (!fuse_req_cachep)
+		goto out_device_clean;
+	
+	return 0;
+	
+ out_device_clean:
+	fuse_device_clean();
+ out:
+	return err;
+}
+
+void fuse_dev_cleanup(void)
+{
+	fuse_device_clean();
+	kmem_cache_destroy(fuse_req_cachep);
+}
--- linux-2.6.10-rc2/fs/fuse/dir.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/dir.c	2004-11-20 22:56:25.000000000 +0100
@@ -0,0 +1,166 @@
+/*
+    FUSE: Filesystem in Userspace
+    Copyright (C) 2001-2004  Miklos Szeredi <miklos@szeredi.hu>
+
+    This program can be distributed under the terms of the GNU GPL.
+    See the file COPYING.
+*/
+
+#include "fuse_i.h"
+
+#include <linux/pagemap.h>
+#include <linux/file.h>
+
+static struct inode_operations fuse_dir_inode_operations;
+
+static void change_attributes(struct inode *inode, struct fuse_attr *attr)
+{
+	if (S_ISREG(inode->i_mode) && i_size_read(inode) != attr->size) {
+		invalidate_inode_pages(inode->i_mapping);
+	}
+
+	inode->i_ino     = attr->ino;
+	inode->i_mode    = (inode->i_mode & S_IFMT) + (attr->mode & 07777);
+	inode->i_nlink   = attr->nlink;
+	inode->i_uid     = attr->uid;
+	inode->i_gid     = attr->gid;
+	i_size_write(inode, attr->size);
+	inode->i_blksize = PAGE_CACHE_SIZE;
+	inode->i_blocks  = attr->blocks;
+	inode->i_atime.tv_sec   = attr->atime;
+	inode->i_atime.tv_nsec  = attr->atimensec;
+	inode->i_mtime.tv_sec   = attr->mtime;
+	inode->i_mtime.tv_nsec  = attr->mtimensec;
+	inode->i_ctime.tv_sec   = attr->ctime;
+	inode->i_ctime.tv_nsec  = attr->ctimensec;
+}
+
+static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr)
+{
+	inode->i_mode = attr->mode & S_IFMT;
+	i_size_write(inode, attr->size);
+	if (S_ISDIR(inode->i_mode))
+		inode->i_op = &fuse_dir_inode_operations;
+}
+
+static int fuse_inode_eq(struct inode *inode, void *_nodeidp)
+{
+	unsigned long nodeid = *(unsigned long *) _nodeidp;
+	struct fuse_inode *fi = INO_FI(inode);
+	if (fi->nodeid == nodeid)
+		return 1;
+	else
+		return 0;
+}
+
+static int fuse_inode_set(struct inode *inode, void *_nodeidp)
+{
+	unsigned long nodeid = *(unsigned long *) _nodeidp;
+	struct fuse_inode *fi = INO_FI(inode);
+	fi->nodeid = nodeid;
+	return 0;
+}
+
+struct inode *fuse_iget(struct super_block *sb, unsigned long nodeid,
+			int generation, struct fuse_attr *attr, int version)
+{
+	struct inode *inode;
+
+	inode = iget5_locked(sb, nodeid, fuse_inode_eq, fuse_inode_set, &nodeid);
+	if (!inode)
+		return NULL;
+
+	if ((inode->i_state & I_NEW)) {
+		inode->i_generation = generation;
+		fuse_init_inode(inode, attr);
+		unlock_new_inode(inode);
+	} else if (inode->i_generation != generation)
+		printk("fuse_iget: bad generation for node %lu\n", nodeid);
+
+	change_attributes(inode, attr);
+	inode->i_version = version;
+	return inode;
+}
+
+static int fuse_send_lookup(struct fuse_conn *fc, struct fuse_req *req,
+			    struct inode *dir, struct dentry *entry, 
+			    struct fuse_entry_out *outarg, int *version)
+{
+	struct fuse_inode *fi = INO_FI(dir);
+	req->in.h.opcode = FUSE_LOOKUP;
+	req->in.h.nodeid = fi->nodeid;
+	req->in.numargs = 1;
+	req->in.args[0].size = entry->d_name.len + 1;
+	req->in.args[0].value = entry->d_name.name;
+	req->out.numargs = 1;
+	req->out.args[0].size = sizeof(struct fuse_entry_out);
+	req->out.args[0].value = outarg;
+	request_send(fc, req);
+	*version = req->out.h.unique;
+	return req->out.h.error;
+}
+
+static inline unsigned long time_to_jiffies(unsigned long sec,
+					    unsigned long nsec)
+{
+	/* prevent wrapping of jiffies */
+	if (sec + 1 >= LONG_MAX / HZ)
+		return 0;
+	
+	return jiffies + sec * HZ + nsec / (1000000000 / HZ);
+}
+
+static int fuse_lookup_iget(struct inode *dir, struct dentry *entry,
+			    struct inode **inodep)
+{
+	struct fuse_conn *fc = INO_FC(dir);
+	int err;
+	struct fuse_entry_out outarg;
+	int version;
+	struct inode *inode = NULL;
+	struct fuse_req *req;
+
+	if (entry->d_name.len > FUSE_NAME_MAX)
+		return -ENAMETOOLONG;
+	req = fuse_get_request(fc);
+	if (!req)
+		return -ERESTARTSYS;
+
+	err = fuse_send_lookup(fc, req, dir, entry, &outarg, &version);
+	if (!err) {
+		inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
+				  &outarg.attr, version);
+		if (!inode) {
+			fuse_send_forget(fc, req, outarg.nodeid, version);
+			return -ENOMEM;
+		}
+	} 
+	fuse_put_request(fc, req);
+	if (err && err != -ENOENT)
+		return err;
+
+	if (inode) {
+		struct fuse_inode *fi = INO_FI(inode);
+		entry->d_time =	time_to_jiffies(outarg.entry_valid,
+						outarg.entry_valid_nsec);
+		fi->i_time = time_to_jiffies(outarg.attr_valid,
+					     outarg.attr_valid_nsec);
+	}
+
+	*inodep = inode;
+	return 0;
+}
+
+static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
+				   struct nameidata *nd)
+{
+	struct inode *inode;
+	int err = fuse_lookup_iget(dir, entry, &inode);
+	if (err)
+		return ERR_PTR(err);
+	return d_splice_alias(inode, entry);
+}
+
+static struct inode_operations fuse_dir_inode_operations = {
+	.lookup		= fuse_lookup,
+};
--- linux-2.6.10-rc2/fs/fuse/fuse_i.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/fuse_i.h	2004-11-20 22:56:25.000000000 +0100
@@ -0,0 +1,216 @@
+/*
+    FUSE: Filesystem in Userspace
+    Copyright (C) 2001-2004  Miklos Szeredi <miklos@szeredi.hu>
+
+    This program can be distributed under the terms of the GNU GPL.
+    See the file COPYING.
+*/
+
+
+#include <linux/fuse.h>
+#include <linux/fs.h>
+#include <linux/wait.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <asm/semaphore.h>
+
+/* If more requests are outstanding, then the operation will block */
+#define FUSE_MAX_OUTSTANDING 10
+
+/** FUSE specific inode data */
+struct fuse_inode {
+	unsigned long nodeid;
+	struct fuse_req *forget_req;
+	unsigned long i_time;
+};
+
+/** One input argument of a request */
+struct fuse_in_arg {
+	unsigned int size;
+	const void *value;
+};
+
+/** The request input */
+struct fuse_in {
+	struct fuse_in_header h;
+	unsigned int numargs;
+	struct fuse_in_arg args[3];
+};
+
+/** One output argument of a request */
+struct fuse_out_arg {
+	unsigned int size;
+	void *value;
+};
+
+/** The request output */
+struct fuse_out {
+	struct fuse_out_header h;
+	unsigned int argvar;
+	unsigned int numargs;
+	struct fuse_out_arg args[3];
+};
+
+struct fuse_req;
+struct fuse_conn;
+
+/**
+ * A request to the client
+ */
+struct fuse_req {
+	/** The request list */
+	struct list_head list;
+
+	/** True if the request has reply */
+	unsigned int isreply:1;
+
+	/* The request is preallocated */
+	unsigned int preallocated:1;
+
+	/* The request is finished */
+	unsigned int finished;
+
+	/** The request input */
+	struct fuse_in in;
+
+	/** The request output */
+	struct fuse_out out;
+
+	/** Used to wake up the task waiting for completion of request*/
+	wait_queue_head_t waitq;
+
+	/** Data for asynchronous requests */
+	union {
+		struct fuse_forget_in forget_in;
+	} misc;
+};
+
+/**
+ * A Fuse connection.
+ *
+ * This structure is created, when the client device is opened, and is
+ * destroyed, when the client device is closed _and_ the filesystem is
+ * unmounted.
+ */
+struct fuse_conn {
+	/** The superblock of the mounted filesystem */
+	struct super_block *sb;
+	
+	/** The opened client device */
+	struct file *file;
+
+	/** The user id for this mount */
+	uid_t uid;
+
+	/** Readers of the connection are waiting on this */
+	wait_queue_head_t waitq;
+
+	/** The list of pending requests */
+	struct list_head pending;
+
+	/** The list of requests being processed */
+	struct list_head processing;
+
+	/** Controls the maximum number of outstanding requests */
+	struct semaphore unused_sem;
+
+	/** The list of unused requests */
+	struct list_head unused_list;
+	
+	/** The next unique request id */
+	int reqctr;
+};
+
+#define SB_FC(sb) ((sb)->s_fs_info)
+#define INO_FC(inode) SB_FC((inode)->i_sb)
+#define INO_FI(i) ((struct fuse_inode *) (((struct inode *)(i))+1))
+
+/** Device operations */
+extern struct file_operations fuse_dev_operations;
+
+/**
+ * This is the single global spinlock which protects FUSE's structures
+ *
+ * The following data is protected by this lock:
+ * 
+ *  - the private_data field of the device file
+ *  - the s_fs_info field of the super block
+ *  - unused_list, pending, processing lists in fuse_conn
+ *  - the unique request ID counter reqctr in fuse_conn
+ *  - the sb (super_block) field in fuse_conn
+ *  - the file (device file) field in fuse_conn
+ */
+extern spinlock_t fuse_lock;
+
+/**
+ * Get a filled in inode
+ */
+struct inode *fuse_iget(struct super_block *sb, unsigned long nodeid,
+			int generation, struct fuse_attr *attr, int version);
+
+/**
+ * Send FORGET command
+ */
+void fuse_send_forget(struct fuse_conn *fc, struct fuse_req *req,
+		      unsigned long nodeid, int version);
+
+/**
+ * Check if the connection can be released, and if yes, then free the
+ * connection structure
+ */
+void fuse_release_conn(struct fuse_conn *fc);
+
+/**
+ * Initialize the client device
+ */
+int fuse_dev_init(void);
+
+/**
+ * Cleanup the client device
+ */
+void fuse_dev_cleanup(void);
+
+/**
+ * Initialize the fuse filesystem 
+ */
+int fuse_fs_init(void);
+
+/**
+ * Cleanup the fuse filesystem
+ */
+void fuse_fs_cleanup(void);
+
+/** 
+ * Allocate a request
+ */
+struct fuse_req *fuse_request_alloc(void);
+
+/**
+ * Free a request
+ */
+void fuse_request_free(struct fuse_req *req);
+
+/**
+ * Reinitialize a request, the preallocated flag is left unmodified
+ */
+void fuse_reset_request(struct fuse_req *req);
+
+/**
+ * Reserve a preallocated request
+ */
+struct fuse_req *fuse_get_request(struct fuse_conn *fc);
+
+/**
+ * Free a request
+ */
+void fuse_put_request(struct fuse_conn *fc, struct fuse_req *req);
+
+/**
+ * Send a request
+ */
+void request_send(struct fuse_conn *fc, struct fuse_req *req);
+
+/**
+ * Send a request for which a reply is not expected
+ */
+void request_send_noreply(struct fuse_conn *fc, struct fuse_req *req);
--- linux-2.6.10-rc2/fs/fuse/inode.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/inode.c	2004-11-20 22:56:25.000000000 +0100
@@ -0,0 +1,361 @@
+/*
+    FUSE: Filesystem in Userspace
+    Copyright (C) 2001-2004  Miklos Szeredi <miklos@szeredi.hu>
+
+    This program can be distributed under the terms of the GNU GPL.
+    See the file COPYING.
+*/
+
+#include "fuse_i.h"
+
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/file.h>
+#include <linux/mount.h>
+#include <linux/seq_file.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/parser.h>
+
+static kmem_cache_t *fuse_inode_cachep;
+
+#define FUSE_SUPER_MAGIC 0x65735546
+
+struct fuse_mount_data {
+	int fd;
+	unsigned int rootmode;
+	unsigned int uid;
+};
+
+static struct inode *fuse_alloc_inode(struct super_block *sb)
+{
+	struct inode *inode;
+	struct fuse_inode *fi;
+
+	inode = kmem_cache_alloc(fuse_inode_cachep, SLAB_KERNEL);
+	if (!inode)
+		return NULL;
+
+
+	fi = INO_FI(inode);
+	memset(fi, 0, sizeof(*fi));
+	fi->forget_req = fuse_request_alloc();
+	if (!fi->forget_req) {
+		kmem_cache_free(fuse_inode_cachep, inode);
+		return NULL;
+	}
+	return inode;
+}
+
+static void fuse_destroy_inode(struct inode *inode)
+{
+	struct fuse_inode *fi = INO_FI(inode);
+	if (fi->forget_req)
+		fuse_request_free(fi->forget_req);
+	kmem_cache_free(fuse_inode_cachep, inode);
+}
+
+static void fuse_read_inode(struct inode *inode)
+{
+	/* No op */
+}
+
+void fuse_send_forget(struct fuse_conn *fc, struct fuse_req *req,
+		      unsigned long nodeid, int version)
+{
+	struct fuse_forget_in *inarg = &req->misc.forget_in;
+	inarg->version = version;
+	req->in.h.opcode = FUSE_FORGET;
+	req->in.h.nodeid = nodeid;
+	req->in.numargs = 1;
+	req->in.args[0].size = sizeof(struct fuse_forget_in);
+	req->in.args[0].value = inarg;
+	request_send_noreply(fc, req);
+}
+
+static void fuse_clear_inode(struct inode *inode)
+{
+	struct fuse_conn *fc = INO_FC(inode);
+	
+	if (fc) {
+		struct fuse_inode *fi = INO_FI(inode);
+		fuse_send_forget(fc, fi->forget_req, fi->nodeid, inode->i_version);
+		fi->forget_req = NULL;
+	}
+}
+
+static void fuse_put_super(struct super_block *sb)
+{
+	struct fuse_conn *fc = SB_FC(sb);
+
+	spin_lock(&fuse_lock);
+	fc->sb = NULL;
+	fc->uid = 0;
+	/* Flush all readers on this fs */
+	wake_up_all(&fc->waitq);
+	fuse_release_conn(fc);
+	SB_FC(sb) = NULL;
+	spin_unlock(&fuse_lock);
+}
+
+enum {
+	OPT_FD,
+	OPT_ROOTMODE,
+	OPT_UID,
+	OPT_ERR 
+};
+
+static match_table_t tokens = {
+	{OPT_FD,			"fd=%u"},
+	{OPT_ROOTMODE,			"rootmode=%o"},
+	{OPT_UID,			"uid=%u"},
+	{OPT_ERR,			NULL}
+};
+
+static int parse_fuse_opt(char *opt, struct fuse_mount_data *d)
+{
+	char *p;
+	memset(d, 0, sizeof(struct fuse_mount_data));
+	d->fd = -1;
+
+	while ((p = strsep(&opt, ",")) != NULL) {
+		int token;
+		int value;
+		substring_t args[MAX_OPT_ARGS];
+		if (!*p)
+			continue;
+		
+		token = match_token(p, tokens, args);
+		switch (token) {
+		case OPT_FD:
+			if (match_int(&args[0], &value))
+				return 0;
+			d->fd = value;
+			break;
+
+		case OPT_ROOTMODE:
+			if (match_octal(&args[0], &value))
+				return 0;
+			d->rootmode = value;
+			break;
+			
+		case OPT_UID:
+			if (match_int(&args[0], &value))
+				return 0;
+			d->uid = value;
+			break;
+			
+		default:
+			return 0;
+		}
+	}
+	if (d->fd == -1)
+		return 0;
+
+	return 1;
+}
+
+static int fuse_show_options(struct seq_file *m, struct vfsmount *mnt)
+{
+	struct fuse_conn *fc = SB_FC(mnt->mnt_sb);
+
+	seq_printf(m, ",uid=%u", fc->uid);
+	return 0;
+}
+
+static void free_conn(struct fuse_conn *fc)
+{
+	while (!list_empty(&fc->unused_list)) {
+		struct fuse_req *req;
+		req = list_entry(fc->unused_list.next, struct fuse_req, list);
+		list_del(&req->list);
+		fuse_request_free(req);
+	}
+	kfree(fc);
+}
+
+/* Must be called with the fuse lock held */
+void fuse_release_conn(struct fuse_conn *fc)
+{
+	if (!fc->sb && !fc->file)
+		free_conn(fc);
+}
+
+static struct fuse_conn *new_conn(void)
+{
+	struct fuse_conn *fc;
+
+	fc = kmalloc(sizeof(*fc), GFP_KERNEL);
+	if (fc != NULL) {
+		int i;
+		memset(fc, 0, sizeof(*fc));
+		fc->sb = NULL;
+		fc->file = NULL;
+		fc->uid = 0;
+		init_waitqueue_head(&fc->waitq);
+		INIT_LIST_HEAD(&fc->pending);
+		INIT_LIST_HEAD(&fc->processing);
+		INIT_LIST_HEAD(&fc->unused_list);
+		sema_init(&fc->unused_sem, FUSE_MAX_OUTSTANDING);
+		for (i = 0; i < FUSE_MAX_OUTSTANDING; i++) {
+			struct fuse_req *req = fuse_request_alloc();
+			if (!req) {
+				free_conn(fc);
+				return NULL;
+			}
+			req->preallocated = 1;
+			list_add(&req->list, &fc->unused_list);
+		}
+		fc->reqctr = 1;
+	}
+	return fc;
+}
+
+static struct fuse_conn *get_conn(struct file *file, struct super_block *sb)
+{
+	struct fuse_conn *fc;
+
+	if (file->f_op != &fuse_dev_operations) {
+		printk("FUSE: bad communication file descriptor\n");
+		return NULL;
+	}
+	fc = new_conn();
+	if (fc == NULL) {
+		printk("FUSE: failed to allocate connection data\n");
+		return NULL;
+	}
+	spin_lock(&fuse_lock);
+	if (file->private_data) {
+		printk("fuse_read_super: connection already mounted\n");
+		free_conn(fc);
+		fc = NULL;
+	} else {
+		file->private_data = fc;
+		fc->sb = sb;
+		fc->file = file;
+	}
+	spin_unlock(&fuse_lock);
+	return fc;
+}
+
+static struct inode *get_root_inode(struct super_block *sb, unsigned int mode)
+{
+	struct fuse_attr attr;
+	memset(&attr, 0, sizeof(attr));
+
+	attr.mode = mode;
+	attr.ino = FUSE_ROOT_ID;
+	return fuse_iget(sb, 1, 0, &attr, 0);
+}
+
+static struct super_operations fuse_super_operations = {
+	.alloc_inode    = fuse_alloc_inode,
+	.destroy_inode  = fuse_destroy_inode,
+	.read_inode	= fuse_read_inode,
+	.clear_inode	= fuse_clear_inode,
+	.put_super	= fuse_put_super,
+	.show_options	= fuse_show_options,
+};
+
+static int fuse_read_super(struct super_block *sb, void *data, int silent)
+{	
+	struct fuse_conn *fc;
+	struct inode *root;
+	struct fuse_mount_data d;
+	struct file *file;
+
+	if (!parse_fuse_opt((char *) data, &d))
+		return -EINVAL;
+
+	sb->s_blocksize = PAGE_CACHE_SIZE;
+	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
+	sb->s_magic = FUSE_SUPER_MAGIC;
+	sb->s_op = &fuse_super_operations;
+	sb->s_maxbytes = MAX_LFS_FILESIZE;
+
+	file = fget(d.fd);
+	if (!file)
+		return -EINVAL;
+
+	fc = get_conn(file, sb);
+	fput(file);
+	if (fc == NULL)
+		return -EINVAL;
+
+	fc->uid = d.uid;
+	
+	SB_FC(sb) = fc;
+
+	root = get_root_inode(sb, d.rootmode);
+	if (root == NULL) {
+		printk("fuse_read_super: failed to get root inode\n");
+		goto err;
+	}
+
+	sb->s_root = d_alloc_root(root);
+	if (!sb->s_root) {
+		iput(root);
+		goto err;
+	}
+
+	return 0;
+
+ err:
+	spin_lock(&fuse_lock);
+	fc->sb = NULL;
+	fuse_release_conn(fc);
+	spin_unlock(&fuse_lock);
+	SB_FC(sb) = NULL;
+	return -EINVAL;
+}
+
+static struct super_block *fuse_get_sb(struct file_system_type *fs_type,
+				       int flags, const char *dev_name,
+				       void *raw_data)
+{
+	return get_sb_nodev(fs_type, flags, raw_data, fuse_read_super);
+}
+
+static struct file_system_type fuse_fs_type = {
+	.owner		= THIS_MODULE,
+	.name		= "fuse",
+	.get_sb		= fuse_get_sb,
+	.kill_sb	= kill_anon_super,
+};
+
+static void fuse_inode_init_once(void * foo, kmem_cache_t * cachep,
+				 unsigned long flags)
+{
+	struct inode * inode = foo;
+
+	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
+	    SLAB_CTOR_CONSTRUCTOR)
+		inode_init_once(inode);
+}
+
+int fuse_fs_init(void)
+{
+	int err;
+
+	err = register_filesystem(&fuse_fs_type);
+	if (err)
+		printk("fuse: failed to register filesystem\n");
+	else {
+		fuse_inode_cachep = kmem_cache_create("fuse_inode",
+						      sizeof(struct inode) + sizeof(struct fuse_inode) ,
+						      0, SLAB_HWCACHE_ALIGN,
+						      fuse_inode_init_once, NULL);
+		if (!fuse_inode_cachep) {
+			unregister_filesystem(&fuse_fs_type);
+			err = -ENOMEM;
+		}
+	}
+
+	return err;
+}
+
+void fuse_fs_cleanup(void)
+{
+	unregister_filesystem(&fuse_fs_type);
+	kmem_cache_destroy(fuse_inode_cachep);
+}
--- linux-2.6.10-rc2/fs/fuse/util.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/util.c	2004-11-20 22:41:18.000000000 +0100
@@ -0,0 +1,53 @@
+/*
+    FUSE: Filesystem in Userspace
+    Copyright (C) 2001-2004  Miklos Szeredi <miklos@szeredi.hu>
+
+    This program can be distributed under the terms of the GNU GPL.
+    See the file COPYING.
+*/
+
+#include "fuse_i.h"
+
+#include <linux/init.h>
+#include <linux/module.h>
+
+MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
+MODULE_DESCRIPTION("Filesystem in Userspace");
+MODULE_LICENSE("GPL");
+
+spinlock_t fuse_lock;
+
+int __init fuse_init(void)
+{
+	int res;
+
+	printk("fuse init (API version %i.%i)\n",
+	       FUSE_KERNEL_VERSION, FUSE_KERNEL_MINOR_VERSION);
+
+	spin_lock_init(&fuse_lock);
+	res = fuse_fs_init();
+	if (res)
+		goto err;
+	
+	res = fuse_dev_init();
+	if (res)
+		goto err_fs_cleanup;
+	
+	return 0;
+
+  err_fs_cleanup:
+	fuse_fs_cleanup();
+  err:
+	return res;
+}
+
+void __exit fuse_exit(void)
+{
+	printk(KERN_DEBUG "fuse exit\n");
+	
+	fuse_fs_cleanup();
+	fuse_dev_cleanup();
+}
+
+module_init(fuse_init);
+module_exit(fuse_exit);
--- linux-2.6.10-rc2/fs/fuse/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/Makefile	2004-11-20 22:56:24.000000000 +0100
@@ -0,0 +1,7 @@
+#
+# Makefile for the linux fuse routines.
+#
+
+obj-$(CONFIG_FUSE) += fuse.o
+
+fuse-objs := dev.o dir.o inode.o util.o
--- linux-2.6.10-rc2/include/linux/fuse.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc2-fuse/include/linux/fuse.h	2004-11-20 22:56:25.000000000 +0100
@@ -0,0 +1,103 @@
+/*
+    FUSE: Filesystem in Userspace
+    Copyright (C) 2001-2004  Miklos Szeredi <miklos@szeredi.hu>
+
+    This program can be distributed under the terms of the GNU GPL.
+    See the file COPYING.
+*/
+
+/* This file defines the kernel interface of FUSE */
+
+/** Version number of this interface */
+#define FUSE_KERNEL_VERSION 4
+
+/** Minor version number of this interface */
+#define FUSE_KERNEL_MINOR_VERSION 2
+
+/** The node ID of the root inode */
+#define FUSE_ROOT_ID 1
+
+/** Opening this will yield a new control file */
+#define FUSE_DEV "/dev/fuse"
+
+/** The file containing the version in the form MAJOR.MINOR */
+#define FUSE_VERSION_FILE "/sys/fs/fuse/version"
+
+struct fuse_attr {
+	unsigned long       ino;
+	unsigned int        mode;
+	unsigned int        nlink;
+	unsigned int        uid;
+	unsigned int        gid;
+	unsigned int        rdev;
+	unsigned long long  size;
+	unsigned long       blocks;
+	unsigned long       atime;
+	unsigned long       atimensec;
+	unsigned long       mtime;
+	unsigned long       mtimensec;
+	unsigned long       ctime;
+	unsigned long       ctimensec;
+};
+
+enum fuse_opcode {
+	FUSE_LOOKUP	   = 1,
+	FUSE_FORGET	   = 2,  /* no reply */
+	/* FUSE_GETATTR	   = 3, */
+	/* FUSE_SETATTR	   = 4, */
+	/* FUSE_READLINK   = 5, */
+	/* FUSE_SYMLINK	   = 6, */
+	/* FUSE_GETDIR	   = 7, */
+	/* FUSE_MKNOD	   = 8, */
+	/* FUSE_MKDIR	   = 9, */
+	/* FUSE_UNLINK	   = 10, */
+	/* FUSE_RMDIR	   = 11, */
+	/* FUSE_RENAME	   = 12, */
+	/* FUSE_LINK	   = 13, */
+	/* FUSE_OPEN	   = 14, */
+	/* FUSE_READ	   = 15, */
+	/* FUSE_WRITE	   = 16, */
+	/* FUSE_STATFS	   = 17, */
+	/* FUSE_RELEASE       = 18, */
+	/* FUSE_INVALIDATE    = 19, */
+	/* FUSE_FSYNC         = 20, */
+	/* FUSE_SETXATTR      = 21, */
+	/* FUSE_GETXATTR      = 22, */
+	/* FUSE_LISTXATTR     = 23, */
+	/* FUSE_REMOVEXATTR   = 24, */
+	/* FUSE_FLUSH         = 25, */
+};
+
+/* Conservative buffer size for the client */
+#define FUSE_MAX_IN 8192
+
+#define FUSE_NAME_MAX 1024
+
+struct fuse_entry_out {
+	unsigned long nodeid;      /* Inode ID */
+	unsigned long generation;  /* Inode generation: nodeid:gen must
+                                      be unique for the fs's lifetime */
+	unsigned long entry_valid; /* Cache timeout for the name */
+	unsigned long entry_valid_nsec;
+	unsigned long attr_valid;  /* Cache timeout for the attributes */
+	unsigned long attr_valid_nsec;
+	struct fuse_attr attr;
+};
+
+struct fuse_forget_in {
+	int version;
+};
+
+struct fuse_in_header {
+	int unique;
+	enum fuse_opcode opcode;
+	unsigned long nodeid;
+	unsigned int uid;
+	unsigned int gid;
+	unsigned int pid;
+};
+
+struct fuse_out_header {
+	int unique;
+	int error;
+};
