Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264635AbTEQAlh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 20:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264637AbTEQAlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 20:41:37 -0400
Received: from c3po.aoltw.net ([64.236.137.25]:39633 "EHLO netscape.com")
	by vger.kernel.org with ESMTP id S264635AbTEQAlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 20:41:32 -0400
Date: Fri, 16 May 2003 17:54:14 -0700 (PDT)
From: John Myers <jgmyers@netscape.com>
Message-Id: <200305170054.RAA10802@pagarcia.nscp.aoltw.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: aio_poll in 2.6?
References: <fa.mc7vl0v.u7u2ah@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's basically waiting for someone to merge the patch.  There were
some people making unsubstantiated claims that it didn't scale, but
the available benchmarks showed that it scaled perfectly across the
parameters tested.

diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet ./fs/Makefile ../linux-aiopoll/fs/Makefile
--- ./fs/Makefile	Fri May 16 17:01:25 2003
+++ ../linux-aiopoll/fs/Makefile	Fri May 16 16:57:55 2003
@@ -10,7 +10,8 @@
 		namei.o fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
 		dcache.o inode.o attr.o bad_inode.o file.o dnotify.o \
 		filesystems.o namespace.o seq_file.o xattr.o libfs.o \
-		fs-writeback.o mpage.o direct-io.o aio.o eventpoll.o
+		fs-writeback.o mpage.o direct-io.o aio.o eventpoll.o \
+		aiopoll.o
 
 obj-$(CONFIG_COMPAT) += compat.o
 
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet ./fs/aio.c ../linux-aiopoll/fs/aio.c
--- ./fs/aio.c	Fri May 16 17:01:25 2003
+++ ../linux-aiopoll/fs/aio.c	Fri May 16 16:57:55 2003
@@ -58,6 +58,8 @@
 
 static void aio_kick_handler(void *);
 
+int async_poll(struct kiocb *iocb, int events);
+
 /* aio_setup
  *	Creates the slab caches used by the aio routines, panic on
  *	failure as this is done early during the boot sequence.
@@ -984,6 +986,19 @@
 	return -EINVAL;
 }
 
+ssize_t generic_aio_poll(struct file *file, struct kiocb *req, struct iocb *iocb)
+{
+	unsigned events = iocb->aio_buf;
+
+	/* Did the user set any bits they weren't supposed to? (The 
+	 * above is actually a cast.
+	 */
+	if (unlikely(events != iocb->aio_buf))
+		return -EINVAL;
+	
+	return async_poll(req, events);
+}
+
 int FASTCALL(io_submit_one(struct kioctx *ctx, struct iocb *user_iocb,
 				  struct iocb *iocb));
 int io_submit_one(struct kioctx *ctx, struct iocb *user_iocb,
@@ -1070,6 +1085,9 @@
 		if (file->f_op->aio_fsync)
 			ret = file->f_op->aio_fsync(req, 0);
 		break;
+ 	case IOCB_CMD_POLL:
+ 		ret = generic_aio_poll(file, req, iocb);
+ 		break;
 	default:
 		dprintk("EINVAL: io_submit: no operation provided\n");
 		ret = -EINVAL;
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet ./fs/aiopoll.c ../linux-aiopoll/fs/aiopoll.c
--- ./fs/aiopoll.c	Wed Dec 31 16:00:00 1969
+++ ../linux-aiopoll/fs/aiopoll.c	Fri May 16 16:57:55 2003
@@ -0,0 +1,175 @@
+/*
+ * This file contains the procedures for the handling of aio poll
+ */
+
+#include <linux/slab.h>
+#include <linux/poll.h>
+#include <linux/aio.h>
+#include <linux/init.h>
+
+struct async_poll_iocb;
+
+struct async_poll_entry {
+	wait_queue_t wait;
+	wait_queue_head_t *whead;
+	struct async_poll_entry *next;
+	struct async_poll_iocb *apiocb;
+};
+
+struct async_poll_iocb {
+	poll_table		pt;
+	void			*armed;
+	int			outofmem;
+	int			events;		/* event mask for async poll */
+	struct async_poll_entry *ehead;
+	struct async_poll_entry entry[2];	/* space for two entries */
+};
+
+static kmem_cache_t *async_poll_entry_cache;
+
+static inline struct async_poll_iocb *kiocb_to_apiocb(struct kiocb *iocb)
+{
+	BUG_ON(sizeof(struct async_poll_iocb) > KIOCB_PRIVATE_SIZE);
+	return (struct async_poll_iocb *)iocb->private;
+}
+
+static inline struct kiocb *apiocb_to_kiocb(struct async_poll_iocb *apiocb)
+{
+	return container_of((void *)apiocb, struct kiocb, private);
+}
+
+static void async_poll_freewait(struct async_poll_iocb *apiocb, wait_queue_t *wait)
+{
+	struct async_poll_entry *entry = apiocb->ehead;
+	struct async_poll_entry *old;
+
+	while (entry) {
+		if (wait != &entry->wait) {
+			remove_wait_queue(entry->whead, &entry->wait);
+		} else {
+			__remove_wait_queue(entry->whead, &entry->wait);
+		}
+		old = entry;
+		entry = entry->next;
+		if (old != &apiocb->entry[0] && old != &apiocb->entry[1]) {
+			kmem_cache_free(async_poll_entry_cache, old);
+		}
+	}
+}
+
+static int async_poll_waiter(wait_queue_t *wait, unsigned mode, int sync)
+{
+	struct async_poll_entry *entry = (struct async_poll_entry *)wait;
+	struct async_poll_iocb *apiocb = entry->apiocb;
+	struct kiocb *iocb = apiocb_to_kiocb(apiocb);
+	unsigned int mask;
+
+	mask = iocb->ki_filp->f_op->poll(iocb->ki_filp, NULL);
+	mask &= apiocb->events | POLLERR | POLLHUP;
+	if (mask) {
+		if (xchg(&apiocb->armed, NULL)) {
+			async_poll_freewait(apiocb, wait); 
+			aio_complete(iocb, mask, 0);
+			return 1;
+		}
+	}
+	return 0;
+}
+
+int async_poll_cancel(struct kiocb *iocb, struct io_event *res)
+{
+	struct async_poll_iocb *apiocb = kiocb_to_apiocb(iocb);
+	void *armed;
+
+	armed = xchg(&apiocb->armed, NULL);
+	aio_put_req(iocb);
+	if (armed) {
+		async_poll_freewait(apiocb, NULL); 
+ 		/*
+ 		 * Since async_poll_freewait() locks the wait queue, we
+		 * know that async_poll_waiter() is either not going to
+		 * be run or has finished all its work.
+ 		 */
+  		aio_put_req(iocb);
+		return 0;
+	}
+	return -EAGAIN;
+}
+
+static void async_poll_queue_proc(struct file *file, wait_queue_head_t *whead, poll_table *pt)
+{
+	struct async_poll_iocb *apiocb = (struct async_poll_iocb *)pt;
+	struct async_poll_entry *entry;
+
+	if (!apiocb->ehead) {
+		entry = &apiocb->entry[0];
+	} else if (apiocb->ehead == &apiocb->entry[0]) {
+		entry = &apiocb->entry[1];
+	} else {
+		entry = kmem_cache_alloc(async_poll_entry_cache, SLAB_KERNEL);
+		if (!entry) {
+			apiocb->outofmem = 1;
+			return;
+		}
+	}
+	init_waitqueue_func_entry(&entry->wait, async_poll_waiter);
+	entry->whead = whead;
+	entry->next = apiocb->ehead;
+	entry->apiocb = apiocb;
+	add_wait_queue(whead, &entry->wait);
+	apiocb->ehead = entry;
+}
+
+int async_poll(struct kiocb *iocb, int events)
+{
+	unsigned int mask;
+	struct async_poll_iocb *apiocb = kiocb_to_apiocb(iocb);
+
+	/* Fast path */
+	if (iocb->ki_filp->f_op && iocb->ki_filp->f_op->poll) {
+		mask = iocb->ki_filp->f_op->poll(iocb->ki_filp, NULL);
+		mask &= events | POLLERR | POLLHUP;
+		if (mask & events)
+			return events;
+	}
+
+	init_poll_funcptr(&apiocb->pt, async_poll_queue_proc);
+	apiocb->armed = &apiocb;
+	apiocb->outofmem = 0;
+	apiocb->events = events;
+	apiocb->ehead = NULL;
+
+	iocb->ki_users++;
+	wmb();
+
+	mask = DEFAULT_POLLMASK;
+	if (iocb->ki_filp->f_op && iocb->ki_filp->f_op->poll)
+		mask = iocb->ki_filp->f_op->poll(iocb->ki_filp, &apiocb->pt);
+	mask &= events | POLLERR | POLLHUP;
+ 	if (mask && xchg(&apiocb->armed, NULL)) {
+		async_poll_freewait(apiocb, NULL);
+		aio_complete(iocb, mask, 0);
+	}
+	if (unlikely(apiocb->outofmem) && xchg(&apiocb->armed, NULL)) {
+		async_poll_freewait(apiocb, NULL);
+		aio_put_req(iocb);
+		aio_put_req(iocb);
+		return -ENOMEM;
+	}
+
+	iocb->ki_cancel = async_poll_cancel;
+	aio_put_req(iocb);
+	return -EIOCBQUEUED;
+}
+
+static int __init async_poll_init(void)
+{
+	async_poll_entry_cache = kmem_cache_create("async poll entry",
+                        sizeof(struct async_poll_entry), 0, 0, NULL, NULL);
+	if (!async_poll_entry_cache)
+		panic("unable to alloc poll_entry_cache");
+	return 0;
+}
+
+module_init(async_poll_init);
+
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet ./fs/select.c ../linux-aiopoll/fs/select.c
--- ./fs/select.c	Fri May 16 17:01:26 2003
+++ ../linux-aiopoll/fs/select.c	Fri May 16 16:57:55 2003
@@ -24,7 +24,6 @@
 #include <asm/uaccess.h>
 
 #define ROUND_UP(x,y) (((x)+(y)-1)/(y))
-#define DEFAULT_POLLMASK (POLLIN | POLLOUT | POLLRDNORM | POLLWRNORM)
 
 struct poll_table_entry {
 	struct file * filp;
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet ./include/linux/aio_abi.h ../linux-aiopoll/include/linux/aio_abi.h
--- ./include/linux/aio_abi.h	Fri May 16 17:02:12 2003
+++ ../linux-aiopoll/include/linux/aio_abi.h	Fri May 16 16:58:29 2003
@@ -38,8 +38,8 @@
 	IOCB_CMD_FDSYNC = 3,
 	/* These two are experimental.
 	 * IOCB_CMD_PREADX = 4,
-	 * IOCB_CMD_POLL = 5,
 	 */
+	IOCB_CMD_POLL = 5,
 	IOCB_CMD_NOOP = 6,
 };
 
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet ./include/linux/poll.h ../linux-aiopoll/include/linux/poll.h
--- ./include/linux/poll.h	Fri May 16 17:02:16 2003
+++ ../linux-aiopoll/include/linux/poll.h	Fri May 16 16:58:33 2003
@@ -10,6 +10,8 @@
 #include <linux/mm.h>
 #include <asm/uaccess.h>
 
+#define DEFAULT_POLLMASK (POLLIN | POLLOUT | POLLRDNORM | POLLWRNORM)
+
 struct poll_table_struct;
 
 /* 
