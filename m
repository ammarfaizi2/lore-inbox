Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbTESTZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 15:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263023AbTESTZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 15:25:26 -0400
Received: from c3po.aoltw.net ([64.236.137.25]:38911 "EHLO netscape.com")
	by vger.kernel.org with ESMTP id S262884AbTESTZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 15:25:13 -0400
Date: Mon, 19 May 2003 12:38:00 -0700 (PDT)
From: John Myers <jgmyers@netscape.com>
Message-Id: <200305191938.MAA11946@pagarcia.nscp.aoltw.net>
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: aio_poll in 2.6
References: <fa.mc7vl0v.u7u2ah@ifi.uio.no>
	<200305170054.RAA10802@pagarcia.nscp.aoltw.net>
	<20030516195025.4bf5dd8d.akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> What is the testing status of this?

I've beaten on it with my multithreaded test program on a 2-way
Pentium II box.

> Have any real-life applications been converted?

Not that I'm aware of.  My test program uses a real-life async i/o
thread pool framework which I've converted to Linux aio, but that
framework also depends on IOCB_CMD_NOOP (which Ben LaHaise has been
sitting on for months).

Note that aio poll is primarily for programs which either have a
thread pool architecture or which need to use the aio framework for
other operations.  Single threaded straight-networking applications
would be better served by epoll.

> Does it require libaio changes to test?

Don't think so--one could create an IO_CMD_POLL iocb by hand.  I just
found it easier to change libaio.

> growl.  Please don't put function prototypes in .c files.  It defeats
> typechecking.  I've moved this to aio.h.

That's how the patch was before I got my hands on it.  I would have
moved it to poll.h, but whatever.

> > +	iocb->ki_users++;
> 
> There is no locking around this modification of ->ki_users.  Is this
> correct?

Yes.  This is the submission path.  No other thread can access that
iocb until after the wmb().

> Barriers always need comments explaining why they are there.

I looked through LXR to find similar wmb() calls to mimic, but didn't
find any non-trivially commented calls.  I hope the comment I added is
acceptable.

> > +	if (unlikely(apiocb->outofmem) && xchg(&apiocb->armed, NULL)) {
> > +		async_poll_freewait(apiocb, NULL);
> > +		aio_put_req(iocb);
> > +		aio_put_req(iocb);
> 
> Is the double-put intentional?

Yes it was intentional and yes it is a bug.  One frees the reference
held by the async_poll() call (obtained before the wmb() call) as
protection against submit/complete and submit/cancel races.  The other
frees the reference held by the poll operation itself (obtained in
aio_get_req()), but when the routine returns -ENOMEM that causes
io_submit_one() to call aio_complete() which again frees that
reference.

Corrected patch follows.

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
+++ ../linux-aiopoll/fs/aio.c	Mon May 19 11:38:32 2003
@@ -984,6 +984,19 @@
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
@@ -1070,6 +1083,9 @@
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
--- fs/aiopoll.c	1969-12-31 16:00:00.000000000 -0800
+++ ../linux-aiopoll/fs/aiopoll.c	2003-05-19 12:26:41.000000000 -0700
@@ -0,0 +1,178 @@
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
+	iocb->ki_users++;
+
+	/*
+	 * Flush the preceeding before letting the complete
+	 * or cancel paths get at this iocb.
+	 */
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
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet ./include/linux/aio.h ../linux-aiopoll/include/linux/aio.h
--- ./include/linux/aio.h	Fri May 16 17:02:12 2003
+++ ../linux-aiopoll/include/linux/aio.h	Mon May 19 11:38:32 2003
@@ -166,4 +166,6 @@
 /* for sysctl: */
 extern unsigned aio_max_nr, aio_max_size, aio_max_pinned;
 
+extern int async_poll(struct kiocb *iocb, int events);
+
 #endif /* __LINUX__AIO_H */
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
+++ ../linux-aiopoll/include/linux/poll.h	Mon May 19 11:20:13 2003
@@ -10,6 +10,8 @@
 #include <linux/mm.h>
 #include <asm/uaccess.h>
 
+#define DEFAULT_POLLMASK (POLLIN | POLLOUT | POLLRDNORM | POLLWRNORM)
+
 struct poll_table_struct;
 
 /* 
