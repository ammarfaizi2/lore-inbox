Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262818AbVAKQfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262818AbVAKQfj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 11:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262832AbVAKQfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 11:35:39 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:29056 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262818AbVAKQ0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 11:26:11 -0500
To: akpm@osdl.org, torvalds@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/11] FUSE - device functions
Message-Id: <E1CoOq3-0003Jq-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Jan 2005 17:25:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the FUSE device handling functions.

This contains the following files:

 o dev.c
    - fuse device operations (read, write, release, poll)
    - registers misc device
    - support for sending requests to userspace

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
diff -Nurp a/fs/fuse/Makefile b/fs/fuse/Makefile
--- a/fs/fuse/Makefile	2005-01-11 16:28:29.000000000 +0100
+++ b/fs/fuse/Makefile	2005-01-11 16:28:29.000000000 +0100
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_FUSE_FS) += fuse.o
 
-fuse-objs := inode.o
+fuse-objs := dev.o inode.o
diff -Nurp a/fs/fuse/dev.c b/fs/fuse/dev.c
--- a/fs/fuse/dev.c	1970-01-01 01:00:00.000000000 +0100
+++ b/fs/fuse/dev.c	2005-01-11 16:28:29.000000000 +0100
@@ -0,0 +1,826 @@
+/*
+  FUSE: Filesystem in Userspace
+  Copyright (C) 2001-2005  Miklos Szeredi <miklos@szeredi.hu>
+
+  This program can be distributed under the terms of the GNU GPL.
+  See the file COPYING.
+*/
+
+#include "fuse_i.h"
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/poll.h>
+#include <linux/uio.h>
+#include <linux/miscdevice.h>
+#include <linux/pagemap.h>
+#include <linux/file.h>
+#include <linux/slab.h>
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
+static inline void fuse_request_init(struct fuse_req *req)
+{
+	memset(req, 0, sizeof(*req));
+	INIT_LIST_HEAD(&req->list);
+	init_waitqueue_head(&req->waitq);
+	atomic_set(&req->count, 1);
+}
+
+struct fuse_req *fuse_request_alloc(void)
+{
+	struct fuse_req *req = kmem_cache_alloc(fuse_req_cachep, SLAB_KERNEL);
+	if (req)
+		fuse_request_init(req);
+	return req;
+}
+
+void fuse_request_free(struct fuse_req *req)
+{
+	kmem_cache_free(fuse_req_cachep, req);
+}
+
+static inline void block_sigs(sigset_t *oldset)
+{
+	sigset_t sigmask;
+
+	siginitsetinv(&sigmask, sigmask(SIGKILL));
+	sigprocmask(SIG_BLOCK, &sigmask, oldset);
+}
+
+static inline void restore_sigs(sigset_t *oldset)
+{
+	sigprocmask(SIG_SETMASK, oldset, NULL);
+}
+
+void fuse_reset_request(struct fuse_req *req)
+{
+	int preallocated = req->preallocated;
+	BUG_ON(atomic_read(&req->count) != 1);
+	fuse_request_init(req);
+	req->preallocated = preallocated;
+}
+
+static void __fuse_get_request(struct fuse_req *req)
+{
+	atomic_inc(&req->count);
+}
+
+/* Must be called with > 1 refcount */
+static void __fuse_put_request(struct fuse_req *req)
+{
+	BUG_ON(atomic_read(&req->count) < 2);
+	atomic_dec(&req->count);
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
+	fuse_request_init(req);
+	req->preallocated = 1;
+	req->in.h.uid = current->fsuid;
+	req->in.h.gid = current->fsgid;
+	req->in.h.pid = current->pid;
+	return req;
+}
+
+struct fuse_req *fuse_get_request(struct fuse_conn *fc)
+{
+	if (down_interruptible(&fc->outstanding_sem))
+		return NULL;
+	return do_get_request(fc);
+}
+
+struct fuse_req *fuse_get_request_nonint(struct fuse_conn *fc)
+{
+	int intr;
+	sigset_t oldset;
+
+	block_sigs(&oldset);
+	intr = down_interruptible(&fc->outstanding_sem);
+	restore_sigs(&oldset);
+	return intr ? NULL : do_get_request(fc);
+}
+
+void fuse_putback_request(struct fuse_conn *fc, struct fuse_req *req)
+{
+	if (!req->preallocated)
+		fuse_request_free(req);
+
+	spin_lock(&fuse_lock);
+	if (req->preallocated)
+		list_add(&req->list, &fc->unused_list);
+
+	if (fc->outstanding_debt)
+		fc->outstanding_debt--;
+	else
+		up(&fc->outstanding_sem);
+	spin_unlock(&fuse_lock);
+}
+
+void fuse_put_request(struct fuse_conn *fc, struct fuse_req *req)
+{
+	if (atomic_dec_and_test(&req->count))
+		fuse_putback_request(fc, req);
+}
+
+/* Called with fuse_lock, unlocks it */
+static void request_end(struct fuse_conn *fc, struct fuse_req *req)
+{
+	int putback;
+	req->finished = 1;
+	putback = atomic_dec_and_test(&req->count);
+	spin_unlock(&fuse_lock);
+	if (req->background) {
+		if (req->inode)
+			iput(req->inode);
+		if (req->inode2)
+			iput(req->inode2);
+		if (req->file)
+			fput(req->file);
+	}
+	wake_up(&req->waitq);
+	if (req->in.h.opcode == FUSE_INIT) {
+		int i;
+		/* After INIT reply is received other requests can go
+		   out.  So do (FUSE_MAX_OUTSTANDING - 1) number of
+		   up()s on outstanding_sem.  The last up() is done in
+		   fuse_putback_request() */
+		for (i = 1; i < FUSE_MAX_OUTSTANDING; i++)
+			up(&fc->outstanding_sem);
+	}
+	if (putback)
+		fuse_putback_request(fc, req);
+}
+
+static void background_request(struct fuse_req *req)
+{
+	/* Need to get hold of the inode(s) and/or file used in the
+	   request, so FORGET and RELEASE are not sent too early */
+	req->background = 1;
+	if (req->inode)
+		req->inode = igrab(req->inode);
+	if (req->inode2)
+		req->inode2 = igrab(req->inode2);
+	if (req->file)
+		get_file(req->file);
+}
+
+static int request_wait_answer_nonint(struct fuse_req *req)
+{
+	int err;
+	sigset_t oldset;
+	block_sigs(&oldset);
+	err = wait_event_interruptible(req->waitq, req->finished);
+	restore_sigs(&oldset);
+	return err;
+}
+
+/* Called with fuse_lock held.  Releases, and then reacquires it. */
+static void request_wait_answer(struct fuse_req *req, int interruptible)
+{
+	int intr;
+
+	spin_unlock(&fuse_lock);
+	if (interruptible)
+		intr = wait_event_interruptible(req->waitq, req->finished);
+	else
+		intr = request_wait_answer_nonint(req);
+	spin_lock(&fuse_lock);
+	if (intr && interruptible && req->sent) {
+		/* If request is already in userspace, only allow KILL
+		   signal to interrupt */
+		spin_unlock(&fuse_lock);
+		intr = request_wait_answer_nonint(req);
+		spin_lock(&fuse_lock);
+	}
+	if (!intr)
+		return;
+
+	if (!interruptible || req->sent)
+		req->out.h.error = -EINTR;
+	else
+		req->out.h.error = -ERESTARTNOINTR;
+
+	req->interrupted = 1;
+	if (req->locked) {
+		/* This is uninterruptible sleep, because data is
+		   being copied to/from the buffers of req.  During
+		   locked state, there musn't be any filesystem
+		   operation (e.g. page fault), since that could lead
+		   to deadlock */
+		spin_unlock(&fuse_lock);
+		wait_event(req->waitq, !req->locked);
+		spin_lock(&fuse_lock);
+	}
+	if (!req->sent && !list_empty(&req->list)) {
+		list_del(&req->list);
+		__fuse_put_request(req);
+	} else if (req->sent)
+		background_request(req);
+}
+
+static unsigned len_args(unsigned numargs, struct fuse_arg *args)
+{
+	unsigned nbytes = 0;
+	unsigned i;
+
+	for (i = 0; i < numargs; i++)
+		nbytes += args[i].size;
+
+	return nbytes;
+}
+
+static void queue_request(struct fuse_conn *fc, struct fuse_req *req)
+{
+	fc->reqctr++;
+	/* zero is special */
+	if (fc->reqctr == 0)
+		fc->reqctr = 1;
+	req->in.h.unique = fc->reqctr;
+	req->in.h.len = sizeof(struct fuse_in_header) + 
+		len_args(req->in.numargs, (struct fuse_arg *) req->in.args);
+	if (!req->preallocated) {
+		/* decrease outstanding_sem, but without blocking... */
+		if (down_trylock(&fc->outstanding_sem))
+			fc->outstanding_debt++;
+	}
+	list_add_tail(&req->list, &fc->pending);
+	wake_up(&fc->waitq);
+}
+
+static void request_send_wait(struct fuse_conn *fc, struct fuse_req *req,
+			      int interruptible)
+{
+	req->isreply = 1;
+	spin_lock(&fuse_lock);
+	req->out.h.error = -ENOTCONN;
+	if (fc->file) {
+		queue_request(fc, req);
+		/* acquire extra reference, since request is still needed
+		   after request_end() */
+		__fuse_get_request(req);
+
+		request_wait_answer(req, interruptible);
+	}
+	spin_unlock(&fuse_lock);
+}
+
+void request_send(struct fuse_conn *fc, struct fuse_req *req)
+{
+	request_send_wait(fc, req, 1);
+}
+
+void request_send_nonint(struct fuse_conn *fc, struct fuse_req *req)
+{
+	request_send_wait(fc, req, 0);
+}
+
+void request_send_nowait(struct fuse_conn *fc, struct fuse_req *req)
+{
+	spin_lock(&fuse_lock);
+	if (fc->file) {
+		queue_request(fc, req);
+		spin_unlock(&fuse_lock);
+	} else {
+		req->out.h.error = -ENOTCONN;
+		request_end(fc, req);
+	}
+}
+
+void request_send_noreply(struct fuse_conn *fc, struct fuse_req *req)
+{
+	req->isreply = 0;
+	request_send_nowait(fc, req);
+}
+
+void request_send_background(struct fuse_conn *fc, struct fuse_req *req)
+{
+	req->isreply = 1;
+	background_request(req);
+	request_send_nowait(fc, req);
+}
+
+void fuse_send_init(struct fuse_conn *fc)
+{
+	/* This is called from fuse_read_super() so there's guaranteed
+	   to be a request available */
+	struct fuse_req *req = do_get_request(fc);
+	struct fuse_init_in_out *arg = &req->misc.init_in_out;
+	arg->major = FUSE_KERNEL_VERSION;
+	arg->minor = FUSE_KERNEL_MINOR_VERSION;
+	req->in.h.opcode = FUSE_INIT;
+	req->in.numargs = 1;
+	req->in.args[0].size = sizeof(*arg);
+	req->in.args[0].value = arg;
+	req->out.numargs = 1;
+	req->out.args[0].size = sizeof(*arg);
+	req->out.args[0].value = arg;
+	request_send_background(fc, req);
+}
+
+static inline int lock_request(struct fuse_req *req)
+{
+	int err = 0;
+	if (req) {
+		spin_lock(&fuse_lock);
+		if (req->interrupted)
+			err = -ENOENT;
+		else
+			req->locked = 1;
+		spin_unlock(&fuse_lock);
+	}
+	return err;
+}
+
+static inline void unlock_request(struct fuse_req *req)
+{
+	if (req) {
+		spin_lock(&fuse_lock);
+		req->locked = 0;
+		if (req->interrupted)
+			wake_up(&req->waitq);
+		spin_unlock(&fuse_lock);
+	}
+}
+
+/* Why all this complex one-page-at-a-time copying needed instead of
+   just copy_to/from_user()?  The reason is that blocking on a page
+   fault must be avoided while the request is locked.  This is because
+   if servicing that pagefault happens to be done by this filesystem,
+   an unbreakable deadlock can occur.  So the code is careful to allow
+   request interruption during get_user_pages(), and only lock the
+   request while doing kmapped copying, which cannot block.
+ */
+
+struct fuse_copy_state {
+	int write;
+	struct fuse_req *req;
+	const struct iovec *iov;
+	unsigned long nr_segs;
+	unsigned long seglen;
+	unsigned long addr;
+	struct page *pg;
+	void *mapaddr;
+	void *buf;
+	unsigned len;
+};
+
+static unsigned fuse_copy_init(struct fuse_copy_state *cs, int write,
+			       struct fuse_req *req, const struct iovec *iov,
+			       unsigned long nr_segs)
+{
+	unsigned i;
+	unsigned nbytes;
+
+	memset(cs, 0, sizeof(*cs));
+	cs->write = write;
+	cs->req = req;
+	cs->iov = iov;
+	cs->nr_segs = nr_segs;
+
+	nbytes = 0;
+	for (i = 0; i < nr_segs; i++)
+		nbytes += iov[i].iov_len;
+
+	return nbytes;
+}
+
+static inline void fuse_copy_finish(struct fuse_copy_state *cs)
+{
+	if (cs->mapaddr) {
+		kunmap_atomic(cs->mapaddr, KM_USER0);
+		if (cs->write) {
+			flush_dcache_page(cs->pg);
+			set_page_dirty_lock(cs->pg);
+		}
+		put_page(cs->pg);
+		cs->mapaddr = NULL;
+	}
+}
+
+static int fuse_copy_fill(struct fuse_copy_state *cs)
+{
+	unsigned long offset;
+	int err;
+
+	unlock_request(cs->req);
+	fuse_copy_finish(cs);
+	if (!cs->seglen) {
+		BUG_ON(!cs->nr_segs);
+		cs->seglen = cs->iov[0].iov_len;
+		cs->addr = (unsigned long) cs->iov[0].iov_base;
+		cs->iov ++;
+		cs->nr_segs --;
+	}
+	down_read(&current->mm->mmap_sem);
+	err = get_user_pages(current, current->mm, cs->addr, 1, cs->write, 0,
+			     &cs->pg, NULL);
+	up_read(&current->mm->mmap_sem);
+	if (err < 0)
+		return err;
+	BUG_ON(err != 1);
+	offset = cs->addr % PAGE_SIZE;
+	cs->mapaddr = kmap_atomic(cs->pg, KM_USER0);
+	cs->buf = cs->mapaddr + offset;
+	cs->len = min(PAGE_SIZE - offset, cs->seglen);
+	cs->seglen -= cs->len;
+	cs->addr += cs->len;
+
+	return lock_request(cs->req);
+}
+
+static inline int fuse_copy_do(struct fuse_copy_state *cs, void **val,
+			       unsigned *size)
+{
+	unsigned ncpy = min(*size, cs->len);
+	if (val) {
+		if (cs->write)
+			memcpy(cs->buf, *val, ncpy);
+		else
+			memcpy(*val, cs->buf, ncpy);
+		*val += ncpy;
+	}
+	*size -= ncpy;
+	cs->len -= ncpy;
+	cs->buf += ncpy;
+	return ncpy;
+}
+
+static inline int fuse_copy_page(struct fuse_copy_state *cs, struct page *page,
+				 unsigned offset, unsigned count, int zeroing)
+{
+	if (page && zeroing && count < PAGE_SIZE) {
+		void *mapaddr = kmap_atomic(page, KM_USER1);
+		memset(mapaddr, 0, PAGE_SIZE);
+		kunmap_atomic(mapaddr, KM_USER1);
+	}
+	while (count) {
+		int err;
+		if (!cs->len && (err = fuse_copy_fill(cs)))
+			return err;
+		if (page) {
+			void *mapaddr = kmap_atomic(page, KM_USER1);
+			void *buf = mapaddr + offset;
+			offset += fuse_copy_do(cs, &buf, &count);
+			kunmap_atomic(mapaddr, KM_USER1);
+		} else
+			offset += fuse_copy_do(cs, NULL, &count);
+	}
+	if (page && !cs->write)
+		flush_dcache_page(page);
+	return 0;
+}
+
+static int fuse_copy_pages(struct fuse_copy_state *cs, unsigned nbytes,
+			   int zeroing)
+{
+	unsigned i;
+	struct fuse_req *req = cs->req;
+	unsigned offset = req->page_offset;
+	unsigned count = min(nbytes, (unsigned) PAGE_SIZE - offset);
+
+	for (i = 0; i < req->num_pages && nbytes; i++) {
+		struct page *page = req->pages[i];
+		int err = fuse_copy_page(cs, page, offset, count, zeroing);
+		if (err)
+			return err;
+
+		nbytes -= count;
+		count = min(nbytes, (unsigned) PAGE_SIZE);
+		offset = 0;
+	}
+	return 0;
+}
+
+static int fuse_copy_one(struct fuse_copy_state *cs, void *val, unsigned size)
+{
+	while (size) {
+		int err;
+		if (!cs->len && (err = fuse_copy_fill(cs)))
+			return err;
+		fuse_copy_do(cs, &val, &size);
+	}
+	return 0;
+}
+
+static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
+			  unsigned argpages, struct fuse_arg *args,
+			  int zeroing)
+{
+	int err = 0;
+	unsigned i;
+
+	for (i = 0; !err && i < numargs; i++)  {
+		struct fuse_arg *arg = &args[i];
+		if (i == numargs - 1 && argpages)
+			err = fuse_copy_pages(cs, arg->size, zeroing);
+		else
+			err = fuse_copy_one(cs, arg->value, arg->size);
+	}
+	return err;
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
+static ssize_t fuse_dev_readv(struct file *file, const struct iovec *iov,
+			      unsigned long nr_segs, loff_t *off)
+{
+	int err;
+	struct fuse_conn *fc;
+	struct fuse_req *req;
+	struct fuse_in *in;
+	struct fuse_copy_state cs;
+	unsigned nbytes;
+	unsigned reqsize;
+
+	spin_lock(&fuse_lock);
+	fc = file->private_data;
+	err = -EPERM;
+	if (!fc)
+		goto err_unlock;
+	request_wait(fc);
+	err = -ENODEV;
+	if (!fc->sb)
+		goto err_unlock;
+	err = -ERESTARTSYS;
+	if (list_empty(&fc->pending))
+		goto err_unlock;
+
+	req = list_entry(fc->pending.next, struct fuse_req, list);
+	list_del_init(&req->list);
+	spin_unlock(&fuse_lock);
+
+	in = &req->in;
+	reqsize = req->in.h.len;
+	nbytes = fuse_copy_init(&cs, 1, req, iov, nr_segs);
+	err = -EINVAL;
+	if (nbytes >= reqsize) {
+		err = fuse_copy_one(&cs, &in->h, sizeof(in->h));
+		if (!err)
+			err = fuse_copy_args(&cs, in->numargs, in->argpages,
+					     (struct fuse_arg *) in->args, 0);
+	}
+	fuse_copy_finish(&cs);
+
+	spin_lock(&fuse_lock);
+	req->locked = 0;
+	if (!err && req->interrupted)
+		err = -ENOENT;
+	if (err) {
+		if (!req->interrupted)
+			req->out.h.error = -EIO;
+		request_end(fc, req);
+		return err;
+	}
+	if (!req->isreply)
+		request_end(fc, req);
+	else {
+		req->sent = 1;
+		list_add_tail(&req->list, &fc->processing);
+		spin_unlock(&fuse_lock);
+	}
+	return reqsize;
+
+ err_unlock:
+	spin_unlock(&fuse_lock);
+	return err;
+}
+
+static ssize_t fuse_dev_read(struct file *file, char __user *buf,
+			     size_t nbytes, loff_t *off)
+{
+	struct iovec iov;
+	iov.iov_len = nbytes;
+	iov.iov_base = buf;
+	return fuse_dev_readv(file, &iov, 1, off);
+}
+
+static struct fuse_req *request_find(struct fuse_conn *fc, unsigned unique)
+{
+	struct list_head *entry;
+
+	list_for_each(entry, &fc->processing) {
+		struct fuse_req *req;
+		req = list_entry(entry, struct fuse_req, list);
+		if (req->in.h.unique == unique)
+			return req;
+	}
+	return NULL;
+}
+
+static int copy_out_args(struct fuse_copy_state *cs, struct fuse_out *out,
+			 unsigned nbytes)
+{
+	unsigned reqsize = sizeof(struct fuse_out_header);
+
+	if (out->h.error)
+		return nbytes != reqsize ? -EINVAL : 0;
+
+	reqsize += len_args(out->numargs, out->args);
+
+	if (reqsize < nbytes || (reqsize > nbytes && !out->argvar))
+		return -EINVAL;
+	else if (reqsize > nbytes) {
+		struct fuse_arg *lastarg = &out->args[out->numargs-1];
+		unsigned diffsize = reqsize - nbytes;
+		if (diffsize > lastarg->size)
+			return -EINVAL;
+		lastarg->size -= diffsize;
+	}
+	return fuse_copy_args(cs, out->numargs, out->argpages, out->args,
+			      out->page_zeroing);
+}
+
+static ssize_t fuse_dev_writev(struct file *file, const struct iovec *iov,
+			       unsigned long nr_segs, loff_t *off)
+{
+	int err;
+	unsigned nbytes;
+	struct fuse_req *req;
+	struct fuse_out_header oh;
+	struct fuse_copy_state cs;
+	struct fuse_conn *fc = fuse_get_conn(file);
+	if (!fc)
+		return -ENODEV;
+
+	nbytes = fuse_copy_init(&cs, 0, NULL, iov, nr_segs);
+	if (nbytes < sizeof(struct fuse_out_header))
+		return -EINVAL;
+
+	err = fuse_copy_one(&cs, &oh, sizeof(oh));
+	if (err)
+		goto err_finish;
+	err = -EINVAL;
+	if (!oh.unique || oh.error <= -1000 || oh.error > 0 || 
+	    oh.len != nbytes)
+		goto err_finish;
+
+	spin_lock(&fuse_lock);
+	req = request_find(fc, oh.unique);
+	err = -EINVAL;
+	if (!req)
+		goto err_unlock;
+
+	list_del_init(&req->list);
+	if (req->interrupted) {
+		request_end(fc, req);
+		fuse_copy_finish(&cs);
+		return -ENOENT;
+	}
+	req->out.h = oh;
+	req->locked = 1;
+	cs.req = req;
+	spin_unlock(&fuse_lock);
+
+	err = copy_out_args(&cs, &req->out, nbytes);
+	fuse_copy_finish(&cs);
+
+	spin_lock(&fuse_lock);
+	req->locked = 0;
+	if (!err) {
+		if (req->interrupted)
+			err = -ENOENT;
+	} else if (!req->interrupted)
+		req->out.h.error = -EIO;
+	request_end(fc, req);
+
+	return err ? err : nbytes;
+
+ err_unlock:
+	spin_unlock(&fuse_lock);
+ err_finish:
+	fuse_copy_finish(&cs);
+	return err;
+}
+
+static ssize_t fuse_dev_write(struct file *file, const char __user *buf,
+			      size_t nbytes, loff_t *off)
+{
+	struct iovec iov;
+	iov.iov_len = nbytes;
+	iov.iov_base = (char __user *) buf;
+	return fuse_dev_writev(file, &iov, 1, off);
+}
+
+static unsigned fuse_dev_poll(struct file *file, poll_table *wait)
+{
+	struct fuse_conn *fc = fuse_get_conn(file);
+	unsigned mask = POLLOUT | POLLWRNORM;
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
+		req->out.h.error = -ECONNABORTED;
+		request_end(fc, req);
+		spin_lock(&fuse_lock);
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
+	.readv		= fuse_dev_readv,
+	.write		= fuse_dev_write,
+	.writev		= fuse_dev_writev,
+	.poll		= fuse_dev_poll,
+	.release	= fuse_dev_release,
+};
+
+static struct miscdevice fuse_miscdevice = {
+	.minor = FUSE_MINOR,
+	.name  = "fuse",
+	.fops = &fuse_dev_operations,
+};
+
+int __init fuse_dev_init(void)
+{
+	int err = -ENOMEM;
+	fuse_req_cachep = kmem_cache_create("fuse_request",
+					    sizeof(struct fuse_req),
+					    0, 0, NULL, NULL);
+	if (!fuse_req_cachep)
+		goto out;
+
+	err = misc_register(&fuse_miscdevice);
+	if (err)
+		goto out_cache_clean;
+
+	return 0;
+
+ out_cache_clean:
+	kmem_cache_destroy(fuse_req_cachep);
+ out:
+	return err;
+}
+
+void fuse_dev_cleanup(void)
+{
+	misc_deregister(&fuse_miscdevice);
+	kmem_cache_destroy(fuse_req_cachep);
+}
diff -Nurp a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
--- a/fs/fuse/fuse_i.h	2005-01-11 16:28:29.000000000 +0100
+++ b/fs/fuse/fuse_i.h	2005-01-11 16:28:29.000000000 +0100
@@ -15,6 +15,12 @@
 #include <linux/backing-dev.h>
 #include <asm/semaphore.h>
 
+/** Max number of pages that can be used in a single read request */
+#define FUSE_MAX_PAGES_PER_REQ 32
+
+/** If more requests are outstanding, then the operation will block */
+#define FUSE_MAX_OUTSTANDING 10
+
 /** FUSE inode */
 struct fuse_inode {
 	/** Inode data */
@@ -28,6 +34,123 @@ struct fuse_inode {
 	unsigned long i_time;
 };
 
+/** One input argument of a request */
+struct fuse_in_arg {
+	unsigned size;
+	const void *value;
+};
+
+/** The request input */
+struct fuse_in {
+	/** The request header */
+	struct fuse_in_header h;
+
+	/** True if the data for the last argument is in req->pages */
+	unsigned argpages:1;
+
+	/** Number of arguments */
+	unsigned numargs;
+
+	/** Array of arguments */
+	struct fuse_in_arg args[3];
+};
+
+/** One output argument of a request */
+struct fuse_arg {
+	unsigned size;
+	void *value;
+};
+
+/** The request output */
+struct fuse_out {
+	/** Header returned from userspace */
+	struct fuse_out_header h;
+
+	/** Last argument is variable length (can be shorter than
+	    arg->size) */
+	unsigned argvar:1;
+
+	/** Last argument is a list of pages to copy data to */
+	unsigned argpages:1;
+
+	/** Zero partially or not copied pages */
+	unsigned page_zeroing:1;
+
+	/** Number or arguments */
+	unsigned numargs;
+
+	/** Array of arguments */
+	struct fuse_arg args[3];
+};
+
+struct fuse_req;
+struct fuse_conn;
+
+/**
+ * A request to the client
+ */
+struct fuse_req {
+	/** This can be on either unused_list, pending or processing
+	    lists in fuse_conn */
+	struct list_head list;
+
+	/** refcount */
+	atomic_t count;
+
+	/** True if the request has reply */
+	unsigned isreply:1;
+
+	/** The request is preallocated */
+	unsigned preallocated:1;
+
+	/** The request was interrupted */
+	unsigned interrupted:1;
+
+	/** Request is sent in the background */
+	unsigned background:1;
+	
+	/** Data is being copied to/from the request */
+	unsigned locked:1;
+
+	/** Request has been sent to userspace */
+	unsigned sent:1;
+
+	/** The request is finished */
+	unsigned finished:1;
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
+		struct fuse_init_in_out init_in_out;
+	} misc;
+
+	/** page vector */
+	struct page *pages[FUSE_MAX_PAGES_PER_REQ];
+
+	/** number of pages in vector */
+	unsigned num_pages;
+
+	/** offset of data on first page */
+	unsigned page_offset;
+
+	/** Inode used in the request */
+	struct inode *inode;
+	
+	/** Second inode used in the request (or NULL) */
+	struct inode *inode2;
+
+	/** File used in the request (or NULL) */
+	struct file *file;
+};
+
 /**
  * A Fuse connection.
  *
@@ -39,9 +162,34 @@ struct fuse_conn {
 	/** The superblock of the mounted filesystem */
 	struct super_block *sb;
 
+	/** The opened client device */
+	struct file *file;
+
 	/** The user id for this mount */
 	uid_t user_id;
 
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
+	struct semaphore outstanding_sem;
+
+	/** This counts the number of outstanding requests if
+	    outstanding_sem would go negative */
+	unsigned outstanding_debt;
+
+	/** The list of unused requests */
+	struct list_head unused_list;
+
+	/** The next unique request id */
+	int reqctr;
+
 	/** Backing dev info */
 	struct backing_dev_info bdi;
 };
@@ -71,13 +219,20 @@ static inline u64 get_node_id(struct ino
 	return get_fuse_inode(inode)->nodeid;
 }
 
+/** Device operations */
+extern struct file_operations fuse_dev_operations;
+
 /**
  * This is the single global spinlock which protects FUSE's structures
  *
  * The following data is protected by this lock:
  *
+ *  - the private_data field of the device file
  *  - the s_fs_info field of the super block
+ *  - unused_list, pending, processing lists in fuse_conn
+ *  - the unique request ID counter reqctr in fuse_conn
  *  - the sb (super_block) field in fuse_conn
+ *  - the file (device file) field in fuse_conn
  */
 extern spinlock_t fuse_lock;
 
@@ -87,3 +242,68 @@ extern spinlock_t fuse_lock;
  */
 void fuse_release_conn(struct fuse_conn *fc);
 
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
+ * Reserve a preallocated request, only interruptible by SIGKILL
+ */
+struct fuse_req *fuse_get_request_nonint(struct fuse_conn *fc);
+
+/**
+ * Decrement reference count of a request.  If count goes to zero put
+ * on unused list (preallocated) or free reqest (not preallocated).
+ */
+void fuse_put_request(struct fuse_conn *fc, struct fuse_req *req);
+
+/**
+ * Send a request (synchronous, interruptible)
+ */
+void request_send(struct fuse_conn *fc, struct fuse_req *req);
+
+/**
+ * Send a request (synchronous, non-interruptible except by SIGKILL)
+ */
+void request_send_nonint(struct fuse_conn *fc, struct fuse_req *req);
+
+/**
+ * Send a request with no reply
+ */
+void request_send_noreply(struct fuse_conn *fc, struct fuse_req *req);
+
+/**
+ * Send a request in the background
+ */
+void request_send_background(struct fuse_conn *fc, struct fuse_req *req);
+
+/**
+ * Send the INIT message
+ */
+void fuse_send_init(struct fuse_conn *fc);
diff -Nurp a/fs/fuse/inode.c b/fs/fuse/inode.c
--- a/fs/fuse/inode.c	2005-01-11 16:28:29.000000000 +0100
+++ b/fs/fuse/inode.c	2005-01-11 16:28:29.000000000 +0100
@@ -151,6 +151,8 @@ static void fuse_put_super(struct super_
 	mount_count --;
 	fc->sb = NULL;
 	fc->user_id = 0;
+	/* Flush all readers on this fs */
+	wake_up_all(&fc->waitq);
 	fuse_release_conn(fc);
 	*get_fuse_conn_super_p(sb) = NULL;
 	spin_unlock(&fuse_lock);
@@ -229,22 +231,51 @@ static int fuse_show_options(struct seq_
 	return 0;
 }
 
-void fuse_release_conn(struct fuse_conn *fc)
+static void free_conn(struct fuse_conn *fc)
 {
+	while (!list_empty(&fc->unused_list)) {
+		struct fuse_req *req;
+		req = list_entry(fc->unused_list.next, struct fuse_req, list);
+		list_del(&req->list);
+		fuse_request_free(req);
+	}
 	kfree(fc);
 }
 
+/* Must be called with the fuse lock held */
+void fuse_release_conn(struct fuse_conn *fc)
+{
+	if (!fc->sb && !fc->file)
+		free_conn(fc);
+}
+
 static struct fuse_conn *new_conn(void)
 {
 	struct fuse_conn *fc;
 
 	fc = kmalloc(sizeof(*fc), GFP_KERNEL);
 	if (fc != NULL) {
+		int i;
 		memset(fc, 0, sizeof(*fc));
 		fc->sb = NULL;
+		fc->file = NULL;
 		fc->user_id = 0;
+		init_waitqueue_head(&fc->waitq);
+		INIT_LIST_HEAD(&fc->pending);
+		INIT_LIST_HEAD(&fc->processing);
+		INIT_LIST_HEAD(&fc->unused_list);
+		sema_init(&fc->outstanding_sem, 0);
+		for (i = 0; i < FUSE_MAX_OUTSTANDING; i++) {
+			struct fuse_req *req = fuse_request_alloc();
+			if (!req) {
+				free_conn(fc);
+				return NULL;
+			}
+			list_add(&req->list, &fc->unused_list);
+		}
 		fc->bdi.ra_pages = (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE;
 		fc->bdi.unplug_io_fn = default_unplug_io_fn;
+		fc->reqctr = 1;
 	}
 	return fc;
 }
@@ -253,11 +284,20 @@ static struct fuse_conn *get_conn(struct
 {
 	struct fuse_conn *fc;
 
+	if (file->f_op != &fuse_dev_operations)
+		return NULL;
 	fc = new_conn();
 	if (fc == NULL)
 		return NULL;
 	spin_lock(&fuse_lock);
-	fc->sb = sb;
+	if (file->private_data) {
+		free_conn(fc);
+		fc = NULL;
+	} else {
+		file->private_data = fc;
+		fc->sb = sb;
+		fc->file = file;
+	}
 	spin_unlock(&fuse_lock);
 	return fc;
 }
@@ -336,6 +376,7 @@ static int fuse_fill_super(struct super_
 		iput(root);
 		goto err;
 	}
+	fuse_send_init(fc);
 	return 0;
 
  err:
@@ -411,8 +452,14 @@ static int __init fuse_init(void)
 	if (res)
 		goto err;
 
+	res = fuse_dev_init();
+	if (res)
+		goto err_fs_cleanup;
+
 	return 0;
 
+ err_fs_cleanup:
+	fuse_fs_cleanup();
  err:
 	return res;
 }
@@ -422,6 +469,7 @@ static void __exit fuse_exit(void)
 	printk(KERN_DEBUG "fuse exit\n");
 
 	fuse_fs_cleanup();
+	fuse_dev_cleanup();
 }
 
 module_init(fuse_init);
diff -Nurp a/include/linux/fuse.h b/include/linux/fuse.h
--- a/include/linux/fuse.h	2005-01-11 16:28:29.000000000 +0100
+++ b/include/linux/fuse.h	2005-01-11 16:28:29.000000000 +0100
@@ -19,6 +19,12 @@
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
 
+/** The major number of the fuse character device */
+#define FUSE_MAJOR 10
+
+/** The minor number of the fuse character device */
+#define FUSE_MINOR 229
+
 struct fuse_attr {
 	__u64	ino;
 	__u64	size;
@@ -36,3 +42,31 @@ struct fuse_attr {
 	__u32	rdev;
 };
 
+enum fuse_opcode {
+	FUSE_INIT          = 26
+};
+
+/* Conservative buffer size for the client */
+#define FUSE_MAX_IN 8192
+
+struct fuse_init_in_out {
+	__u32	major;
+	__u32	minor;
+};
+
+struct fuse_in_header {
+	__u32	len;
+	__u32	opcode;
+	__u64	unique;
+	__u64	nodeid;
+	__u32	uid;
+	__u32	gid;
+	__u32	pid;
+};
+
+struct fuse_out_header {
+	__u32	len;
+	__s32	error;
+	__u64	unique;
+};
+
