Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbTFUFbe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 01:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbTFUFbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 01:31:34 -0400
Received: from dm1-30.slc.aros.net ([66.219.220.30]:30879 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S262267AbTFUF3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 01:29:53 -0400
Message-ID: <3EF3F08B.5060305@aros.net>
Date: Fri, 20 Jun 2003 23:43:39 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
       Steven Whitehouse <steve@chygwyn.com>
Subject: [RFC][PATCH] nbd driver for 2.5.72
Content-Type: multipart/mixed;
 boundary="------------020103020209000205050901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020103020209000205050901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The following (attached) patch to the network block device driver (nbd) 
is now specific to just 2.5.72 with various other changes as suggested 
by Pavel and Steven. Please let me know what you think. There's 
definately room for more improvements but I don't believe the existing 
2.5 series nbd driver (at least up through 2.5.72) works at all. Has 
anyone tested nbd as distributed with 2.5? I've been too busy writing 
this new nbd driver to even have checked the original driver (but some 
of the bugs I've encountered make me believe the original won't work at 
all). Here's a URL to follow to see just the two resultant files (and/or 
the patch in case it doesn't come through as an attachment): 
<http://www.aros.net/~ldl/linux/kernel/2.5.72/>.

Thanks!

PS: Please email me or CC me if you have any feedback for me.

--------------020103020209000205050901
Content-Type: text/plain;
 name="nbd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nbd.patch"

diff -urN linux-2.5.72/drivers/block/nbd.c linux-2.5.72-new/drivers/block/nbd.c
--- linux-2.5.72/drivers/block/nbd.c	2003-06-16 22:19:44.000000000 -0600
+++ linux-2.5.72-new/drivers/block/nbd.c	2003-06-20 21:27:44.650037153 -0600
@@ -6,6 +6,7 @@
  * 
  * Copyright 1997-2000 Pavel Machek <pavel@ucw.cz>
  * Parts copyright 2001 Steven Whitehouse <steve@chygwyn.com>
+ * Parts copyright 2003 Louis D. Langholtz <ldl@aros.net>
  *
  * (part of code stolen from loop.c)
  *
@@ -24,10 +25,35 @@
  * 01-3-11 Make nbd work with new Linux block layer code. It now supports
  *   plugging like all the other block devices. Also added in MSG_MORE to
  *   reduce number of partial TCP segments sent. <steve@chygwyn.com>
- * 01-12-6 Fix deadlock condition by making queue locks independent of
+ * 01-12-6 Fix deadlock condition by making queue locks independant of
  *   the transmit lock. <steve@chygwyn.com>
  * 02-10-11 Allow hung xmit to be aborted via SIGKILL & various fixes.
  *   <Paul.Clements@SteelEye.com> <James.Bottomley@SteelEye.com>
+ * 03-05-02 Ported thread patch by <steve@uk.sistina.com> which moves
+ *   network I/O into seperate kernel threads so request function no longer
+ *   blocks. <ldl@aros.net>
+ * 03-05-02 Switched to configurable debugging output. <ldl@aros.net>
+ * 03-05-19 Added connection establishment code and new IP:port managing ioctls
+ *   to support tool-less startup and simplified management. <ldl@aros.net>
+ * 03-05-19 Added module parameters to support insertion time configuration
+ *   of various aspects of this driver. <ldl@aros.net>
+ * 03-05-27 Added procfs support for greater runtime monitorability of driver.
+ *   <ldl@aros.net>
+ * 03-06-08 Added session management code to try reconnecting in case of
+ *   connection shutdown. <ldl@aros.net>
+ * 03-06-10 Fixed bug in network read logic that's been there from the
+ *   original 2.5 series nbd driver where data was being read into possibly
+ *   non-contiguous memory using bio_data() call (and caused kernel lockups).
+ * 03-06-12 Added a default BLOCKING stratedgy on network downtime with a
+ *   non-default NBD_NONBLOCKING flag. This has the net effect of blocking
+ *   I/O when there's only transient problems like a server reboot. If used
+ *   in conjunction now with RAID mirroring, transient errors (while they'll
+ *   pause the system) will not nessesitate a complete recopying of the
+ *   server's exported block device which could potentially take much longer
+ *   than a reboot.
+ * 03-06-13 Implemented NBD_WRITE_NOCHK. <ldl@aros.net>
+ * 03-06-15 Fixed code to report proper size even when using nbd-client.
+ *   <ldl@aros.net>
  *
  * possible FIXME: make set_sock / set_blksize / set_size / do_it one syscall
  * why not: would need verify_area and friends, would share yet another 
@@ -35,89 +61,139 @@
  */
 
 #define PARANOIA
+#include <linux/version.h>
 #include <linux/major.h>
-
-#include <linux/blk.h>
-#include <linux/blkdev.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/sched.h>
+#include <linux/blkdev.h>
 #include <linux/fs.h>
 #include <linux/bio.h>
 #include <linux/stat.h>
 #include <linux/errno.h>
 #include <linux/file.h>
 #include <linux/ioctl.h>
-#include <linux/blkdev.h>
-#include <linux/blk.h>
+#include <linux/ctype.h>
+#include <linux/inet.h>
+#include <linux/proc_fs.h>
 #include <net/sock.h>
 
 #include <linux/devfs_fs_kernel.h>
 
 #include <asm/uaccess.h>
 #include <asm/types.h>
+#include <asm/system.h>	/* for __xchg()... */
+#define atomic_exchange(x,ptr,size) __xchg((x),(ptr),(size))
 
+#define MAJOR_NR NBD_MAJOR
 #include <linux/nbd.h>
 
+#define USE_ZEROCOPY
 #define LO_MAGIC 0x68797548
+#define DISCONNECT_NBD 2
 
-static struct nbd_device nbd_dev[MAX_NBD];
+#define NBD_DEBUG_OPEN    0x0001
+#define NBD_DEBUG_RELEASE 0x0002
+#define NBD_DEBUG_IOCTL   0x0004
+#define NBD_DEBUG_MEDIA   0x0008
+#define NBD_DEBUG_THREADS 0x0010
+#define NBD_DEBUG_SESSION 0x0020
+#define NBD_DEBUG_INIT    0x0040
+#define NBD_DEBUG_EXIT    0x0080
+#define NBD_DEBUG_RX      0x0100
+#define NBD_DEBUG_TX      0x0200
+#define NBD_DEBUG_BLKDEV  0x0400
+
+#ifdef NDEBUG
+#define dprintk(flags, fmt...)
+#else
+#define dprintk(flags, fmt...) do { \
+	if (debugflags & (flags)) printk(fmt); \
+} while (0)
+#endif
 
-static spinlock_t nbd_lock = SPIN_LOCK_UNLOCKED;
+#define DEVICE_TO_MINOR(lo) ((int)((lo)-nbd_devs))
 
-#define DEBUG( s )
-/* #define DEBUG( s ) printk( s ) 
- */
+#  define REQUEST_QUEUE(req) (&(req)->queuelist)
+#  define REQUEST_QUEUE_NEXT_REQUEST(q) (elv_next_request(q))
+#  define REQUEST_CMD(req) ((req)->cmd[0])
+#  define DAEMONIZE(fmt...) daemonize(fmt)
+#  define NBD_BYTESIZE(lo) ((lo)->bytesize)
+#  define NBD_BLKSIZE(lo) ((lo)->blksize)
+#  define INODE_TO_NBD(i) ((i)->i_bdev->bd_disk->private_data)
+#  define DEVICE_NAME "nbd"
+#  define request_queue_lock(q) spin_lock_irq((q)->queue_lock)
+#  define request_queue_unlock(q) spin_unlock_irq((q)->queue_lock)
+#  define request_queue_lock_save(q,flags) \
+	spin_lock_irqsave((q)->queue_lock, (flags))
+#  define request_queue_unlock_restore(q,flags) \
+	spin_unlock_irqrestore((q)->queue_lock, (flags))
 
-static int requests_in;
-static int requests_out;
+/*
+ * Private structure declarations...
+ */
+typedef int (*thread_fn_t)(void *);
 
-static void nbd_end_request(struct request *req)
-{
-	int uptodate = (req->errors == 0) ? 1 : 0;
-	request_queue_t *q = req->q;
-	unsigned long flags;
+/*
+ * Forward function declarations to keep compiler happy...
+ */
+static void nbd_set_size64(nbd_device_t *lo, u64 size);
+static int nbd_thread_start(nbd_device_t *lo, nbd_thread_t *th, thread_fn_t fn);
+static int nbd_thread_stop(nbd_device_t *lo, nbd_thread_t *th, int wait);
+static int rx_loop(void *data);
+static int tx_loop(void *data);
+static int nbd_deactivate_sin(nbd_device_t *lo);
+static int nbd_activate_sin(nbd_device_t *lo);
+static int nbd_do_it(nbd_device_t *lo);
+static int nbd_redo_queue(nbd_device_t *lo);
+static int nbd_clear_queue(nbd_device_t *lo);
 
-#ifdef PARANOIA
-	requests_out++;
-#endif
-	spin_lock_irqsave(q->queue_lock, flags);
-	if (!end_that_request_first(req, uptodate, req->nr_sectors)) {
-		end_that_request_last(req);
-	}
-	spin_unlock_irqrestore(q->queue_lock, flags);
-}
+/*
+ * Private global definitions...
+ */
 
-static int nbd_open(struct inode *inode, struct file *file)
-{
-	struct nbd_device *lo = inode->i_bdev->bd_disk->private_data;
-	lo->refcnt++;
-	return 0;
-}
+static nbd_device_t nbd_devs[MAX_NBD];
+static struct request_queue nbd_queue[MAX_NBD];
+static spinlock_t nbd_lock[MAX_NBD];
+static uint32_t request_magic;
+static uint32_t reply_magic;
+static u64 requests_in;
+static u64 requests_out;
+static u64 qhandler_loops;
+static u64 initial_bytesize = (u64)-512; /* formerly 0x7ffffc00<<10 (~2TB) */
 
 /*
- *  Send or receive packet.
+ * Module parameter definitions...
+ */
+static char *connects[64];
+#ifndef NDEBUG
+static unsigned int debugflags = 0;
+#endif
+static char *initial_size = NULL;
+static int initial_blksize_bits = 12; /* formerly 10 (or 1K block sizes) */
+static short default_port = NBD_DEFAULT_PORT;
+
+/**
+ * sock_xmit - send or recieve a packet.
+ * @sock: the socket on which to send or recieve.
+ * @send: receive if false, else send.
+ * @buf: byte address of the packet.
+ * @size: number of bytes to send or receive.
+ * @msg_flags: flags passed to sock_sendmsg or sock_recvmsg call.
+ *
+ * Returns the last result status: < 0 for particular error, 0 for closed
+ *   and > 0 for success.
  */
-static int nbd_xmit(int send, struct socket *sock, char *buf, int size, int msg_flags)
+static int sock_xmit(struct socket *sock, int send, void *buf, int size,
+		int msg_flags)
 {
 	mm_segment_t oldfs;
 	int result;
 	struct msghdr msg;
 	struct iovec iov;
-	unsigned long flags;
-	sigset_t oldset;
 
 	oldfs = get_fs();
 	set_fs(get_ds());
-	/* Allow interception of SIGKILL only
-	 * Don't allow other signals to interrupt the transmission */
-	spin_lock_irqsave(&current->sighand->siglock, flags);
-	oldset = current->blocked;
-	sigfillset(&current->blocked);
-	sigdelsetmask(&current->blocked, sigmask(SIGKILL));
-	recalc_sigpending();
-	spin_unlock_irqrestore(&current->sighand->siglock, flags);
-
 
 	do {
 		sock->sk->sk_allocation = GFP_NOIO;
@@ -137,481 +213,2177 @@
 		else
 			result = sock_recvmsg(sock, &msg, size, 0);
 
-		if (signal_pending(current)) {
-			siginfo_t info;
-			spin_lock_irqsave(&current->sighand->siglock, flags);
-			printk(KERN_WARNING "NBD (pid %d: %s) got signal %d\n",
-				current->pid, current->comm, 
-				dequeue_signal(current, &current->blocked, &info));
-			spin_unlock_irqrestore(&current->sighand->siglock, flags);
-			result = -EINTR;
+		if (result <= 0)
 			break;
-		}
-
-		if (result <= 0) {
-#ifdef PARANOIA
-			printk(KERN_ERR "NBD: %s - sock=%ld at buf=%ld, size=%d returned %d.\n",
-			       send ? "send" : "receive", (long) sock, (long) buf, size, result);
-#endif
-			break;
-		}
 		size -= result;
 		buf += result;
 	} while (size > 0);
 
-	spin_lock_irqsave(&current->sighand->siglock, flags);
-	current->blocked = oldset;
-	recalc_sigpending();
-	spin_unlock_irqrestore(&current->sighand->siglock, flags);
-
 	set_fs(oldfs);
 	return result;
 }
 
-#define FAIL( s ) { printk( KERN_ERR "NBD: " s "(result %d)\n", result ); goto error_out; }
-
-void nbd_send_req(struct nbd_device *lo, struct request *req)
+static inline void wait_for_completion_interuptably(struct completion *x)
 {
-	int result, i, flags;
-	struct nbd_request request;
-	unsigned long size = req->nr_sectors << 9;
-	struct socket *sock = lo->sock;
-
-	DEBUG("NBD: sending control, ");
-	
-	request.magic = htonl(NBD_REQUEST_MAGIC);
-	request.type = htonl(nbd_cmd(req));
-	request.from = cpu_to_be64( (u64) req->sector << 9);
-	request.len = htonl(size);
-	memcpy(request.handle, &req, sizeof(req));
+	spin_lock_irq(&x->wait.lock);
+	if (!x->done) {
+		DECLARE_WAITQUEUE(wait, current);
 
-	down(&lo->tx_lock);
-
-	if (!sock || !lo->sock) {
-		printk(KERN_ERR "NBD: Attempted sendmsg to closed socket\n");
-		goto error_out;
+		wait.flags |= WQ_FLAG_EXCLUSIVE;
+		__add_wait_queue_tail(&x->wait, &wait);
+		do {
+			__set_current_state(TASK_INTERRUPTIBLE);
+			spin_unlock_irq(&x->wait.lock);
+			schedule();
+			spin_lock_irq(&x->wait.lock);
+		} while (!x->done && !signal_pending(current));
+		__remove_wait_queue(&x->wait, &wait);
 	}
+	x->done--;
+	spin_unlock_irq(&x->wait.lock);
+}
 
-	result = nbd_xmit(1, sock, (char *) &request, sizeof(request), nbd_cmd(req) == NBD_CMD_WRITE ? MSG_MORE : 0);
-	if (result <= 0)
-		FAIL("Sendmsg failed for control.");
+static int wait_for_io_threads(nbd_device_t *lo)
+{
+	int signaled = 0;
+	struct task_struct *tsk = current;
+	DECLARE_WAITQUEUE(wait, tsk);
+#ifndef NDEBUG
+	int minor = DEVICE_TO_MINOR(lo);
+#endif
 
-	if (nbd_cmd(req) == NBD_CMD_WRITE) {
-		struct bio *bio;
-		/*
-		 * we are really probing at internals to determine
-		 * whether to set MSG_MORE or not...
-		 */
-		rq_for_each_bio(bio, req) {
-			struct bio_vec *bvec;
-			bio_for_each_segment(bvec, bio, i) {
-				flags = 0;
-				if ((i < (bio->bi_vcnt - 1)) || bio->bi_next)
-					flags = MSG_MORE;
-				DEBUG("data, ");
-				result = nbd_xmit(1, sock, page_address(bvec->bv_page) + bvec->bv_offset, bvec->bv_len, flags);
-				if (result <= 0)
-					FAIL("Send data failed.");
-			}
-		}
+	add_wait_queue(&lo->no_io_waiters, &wait);
+	if (atomic_read(&lo->num_io_threads) > 0) {
+		dprintk(NBD_DEBUG_SESSION, "nb%d: %s: going to sleep...\n",
+			minor, __FUNCTION__);
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule();
+		set_current_state(TASK_RUNNING);
+		if (signal_pending(current))
+			signaled = 1;
+		dprintk(NBD_DEBUG_SESSION, "nb%d: %s: woken up (%s)\n",
+			minor, __FUNCTION__, signaled? "signaled": "done");
 	}
-	up(&lo->tx_lock);
-	return;
+	remove_wait_queue(&lo->no_io_waiters, &wait);
+	return signaled? 0: 1;
+}
 
-      error_out:
-	up(&lo->tx_lock);
-	req->errors++;
+/**
+ * request_end_while_locked - low level block device system request ender.
+ * @req: the block device request after blkdev_dequeue_request() done on it.
+ * @uptodate: 1 (true), or 0 (false) depending on if buffer sync'd with store.
+ *
+ * This function must be called with io_request_lock held & interupts disabled.
+ */
+static void request_end_while_locked(struct request *req, int uptodate)
+{
+	if (!end_that_request_first(req, uptodate, req->nr_sectors)) {
+		end_that_request_last(req);
+	}
+	requests_out++;
+	if (current) {
+		dprintk(NBD_DEBUG_BLKDEV, "%s[%d]: released request (%p).\n",
+				current->comm, current->pid, req);
+	}
+	else {
+		/* can current ever even be null??? */
+		printk(KERN_ERR DEVICE_NAME ": null current pointer!!\n");
+		dprintk(NBD_DEBUG_BLKDEV, "%s: released request (%p).\n",
+				DEVICE_NAME, req);
+	}
 }
 
-static struct request *nbd_find_request(struct nbd_device *lo, char *handle)
+/**
+ * request_end - block device system request ender.
+ * @req: the block device request after blkdev_dequeue_request() done on it.
+ * @uptodate: 1 (true), or 0 (false) depending on if buffer sync'd with store.
+ *
+ * This function must not be called when io_request_lock is held! Use
+ * request_end_while_locked() instead when this lock is already held.
+ */
+static void request_end(struct request *req, int uptodate)
 {
-	struct request *req;
-	struct list_head *tmp;
-	struct request *xreq;
+	unsigned long flags;
 
-	memcpy(&xreq, handle, sizeof(xreq));
+	if (REQUEST_CMD(req) == DISCONNECT_NBD)
+		return;
+	request_queue_lock_save(req->q, flags);
+	request_end_while_locked(req, uptodate);
+	request_queue_unlock_restore(req->q, flags);
+}
 
-	spin_lock(&lo->queue_lock);
-	list_for_each(tmp, &lo->queue_head) {
-		req = list_entry(tmp, struct request, queuelist);
-		if (req != xreq)
-			continue;
-		list_del_init(&req->queuelist);
-		spin_unlock(&lo->queue_lock);
-		return req;
-	}
-	spin_unlock(&lo->queue_lock);
-	return NULL;
+static void nbd_qsys_enq_tail(nbd_qsys_t *q, struct request *req)
+{
+	spin_lock(&q->lock);
+	list_add_tail(REQUEST_QUEUE(req), &q->head);
+	q->len++;
+	spin_unlock(&q->lock);
+	wake_up(&q->waiters);
 }
 
-#define HARDFAIL( s ) { printk( KERN_ERR "NBD: " s "(result %d)\n", result ); lo->harderror = result; return NULL; }
-struct request *nbd_read_stat(struct nbd_device *lo)
-		/* NULL returned = something went wrong, inform userspace       */ 
+static void nbd_qsys_enq_head(nbd_qsys_t *q, struct request *req)
 {
-	int result;
-	struct nbd_reply reply;
-	struct request *req;
+	spin_lock(&q->lock);
+	list_add(REQUEST_QUEUE(req), &q->head);
+	q->len++;
+	spin_unlock(&q->lock);
+	wake_up(&q->waiters);
+}
 
-	DEBUG("reading control, ");
-	reply.magic = 0;
-	result = nbd_xmit(0, lo->sock, (char *) &reply, sizeof(reply), MSG_WAITALL);
-	if (result <= 0)
-		HARDFAIL("Recv control failed.");
-	req = nbd_find_request(lo, reply.handle);
-	if (req == NULL)
-		HARDFAIL("Unexpected reply");
-
-	DEBUG("ok, ");
-	if (ntohl(reply.magic) != NBD_REPLY_MAGIC)
-		HARDFAIL("Not enough magic.");
-	if (ntohl(reply.error))
-		FAIL("Other side returned error.");
-
-	if (nbd_cmd(req) == NBD_CMD_READ) {
-		struct bio *bio = req->bio;
-		DEBUG("data, ");
-		do {
-			result = nbd_xmit(0, lo->sock, bio_data(bio), bio->bi_size, MSG_WAITALL);
-			if (result <= 0)
-				HARDFAIL("Recv data failed.");
-			bio = bio->bi_next;
-		} while(bio);
+static struct request *nbd_qsys_deq_head(nbd_qsys_t *q)
+{
+	struct request *req = NULL;
+	spin_lock(&q->lock);
+	if (!list_empty(&q->head)) {
+		req = blkdev_entry_to_request(q->head.next);
+		list_del_init(REQUEST_QUEUE(req));
+		q->len--;
 	}
-	DEBUG("done.\n");
+	spin_unlock(&q->lock);
 	return req;
+}
 
-/* Can we get here? Yes, if other side returns error */
-      error_out:
-	req->errors++;
+static struct request *nbd_qsys_deq_tail(nbd_qsys_t *q)
+{
+	struct request *req = NULL;
+	spin_lock(&q->lock);
+	if (!list_empty(&q->head)) {
+		req = blkdev_entry_to_request(q->head.prev);
+		list_del_init(REQUEST_QUEUE(req));
+		q->len--;
+	}
+	spin_unlock(&q->lock);
 	return req;
 }
 
-void nbd_do_it(struct nbd_device *lo)
+static struct request *nbd_qsys_deq_request(nbd_qsys_t *q, char *handle)
 {
-	struct request *req;
-
-	while (1) {
-		req = nbd_read_stat(lo);
+	struct list_head *tmp;
+	struct request *req, *xreq;
 
-		if (!req) {
-			printk(KERN_ALERT "req should never be null\n" );
-			goto out;
+	memcpy(&xreq, handle, sizeof(xreq));
+	spin_lock(&q->lock);
+	list_for_each(tmp, &q->head) {
+		req = blkdev_entry_to_request(tmp);
+		if (req == xreq) {
+			list_del_init(REQUEST_QUEUE(req));
+			q->len--;
+			spin_unlock(&q->lock);
+			return req;
 		}
-		BUG_ON(lo->magic != LO_MAGIC);
-		nbd_end_request(req);
 	}
- out:
-	return;
+	spin_unlock(&q->lock);
+	return NULL;
 }
 
-void nbd_clear_que(struct nbd_device *lo)
+static int nbd_qsys_len(nbd_qsys_t *q)
 {
-	struct request *req;
+	int len;
+	spin_lock(&q->lock);
+	len = q->len;
+	spin_unlock(&q->lock);
+	return len;
+}
 
-	BUG_ON(lo->magic != LO_MAGIC);
+static struct request *nbd_qsys_deq_head_eventually(nbd_qsys_t *q)
+{
+	struct request *req;
 
-	do {
-		req = NULL;
-		spin_lock(&lo->queue_lock);
-		if (!list_empty(&lo->queue_head)) {
-			req = list_entry(lo->queue_head.next, struct request, queuelist);
-			list_del_init(&req->queuelist);
-		}
-		spin_unlock(&lo->queue_lock);
-		if (req) {
-			req->errors++;
-			nbd_end_request(req);
+	req = nbd_qsys_deq_head(q);
+	if (!req) {
+		struct task_struct *tsk = current;
+		DECLARE_WAITQUEUE(wait, tsk);
+
+		add_wait_queue(&q->waiters, &wait);
+		for (;;) {
+			set_current_state(TASK_INTERRUPTIBLE);
+			req = nbd_qsys_deq_head(q);
+			if (req)
+				break;
+			if (signal_pending(current))
+				break;
+			schedule();
 		}
-	} while(req);
+		set_current_state(TASK_RUNNING);
+		remove_wait_queue(&q->waiters, &wait);
+	}
+	return req;
 }
 
-/*
- * We always wait for result of write, for now. It would be nice to make it optional
- * in future
- * if ((req->cmd == WRITE) && (lo->flags & NBD_WRITE_NOCHK)) 
- *   { printk( "Warning: Ignoring result!\n"); nbd_end_request( req ); }
- */
+static int nbd_qsys_clear(nbd_qsys_t *q)
+{
+	struct request *req;
+	int ncleared;
 
-#undef FAIL
-#define FAIL( s ) { printk( KERN_ERR "%s: " s "\n", req->rq_disk->disk_name ); goto error_out; }
+	for (ncleared = 0;; ncleared++) {
+		req = nbd_qsys_deq_head(q);
+		if (!req)
+			break;
+		req->errors++;
+		request_end(req, 0);
+	}
+	return ncleared;
+}
 
-static void do_nbd_request(request_queue_t * q)
+static inline int sock_recv_bvec(struct socket *sock, struct bio_vec *bvec,
+		int flags)
 {
-	struct request *req;
-	
-	while ((req = elv_next_request(q)) != NULL) {
-		struct nbd_device *lo;
+	return sock_xmit(sock, 0, page_address(bvec->bv_page) + bvec->bv_offset,
+			bvec->bv_len, flags);
+}
 
-		if (!(req->flags & REQ_CMD))
-			goto error_out;
+static inline int sock_recv_buffers(struct socket *sock, struct request *req)
+{
+	int result = -ENOMEM; /* only returned if bh == NULL */
+	int i;
+	struct bio *bio;
 
-		lo = req->rq_disk->private_data;
-		if (!lo->file)
-			FAIL("Request when not-ready.");
-		nbd_cmd(req) = NBD_CMD_READ;
-		if (rq_data_dir(req) == WRITE) {
-			nbd_cmd(req) = NBD_CMD_WRITE;
-			if (lo->flags & NBD_READ_ONLY)
-				FAIL("Write on read-only");
+	rq_for_each_bio(bio, req) {
+		struct bio_vec *bvec;
+		bio_for_each_segment(bvec, bio, i) {
+			result = sock_recv_bvec(sock, bvec, MSG_WAITALL);
+			if (result <= 0)
+				return result;
 		}
-		BUG_ON(lo->magic != LO_MAGIC);
-		requests_in++;
+	}
+	return result;
+}
 
-		req->errors = 0;
-		blkdev_dequeue_request(req);
-		spin_unlock_irq(q->queue_lock);
+static inline int sock_send_bvec(struct socket *sock, struct bio_vec *bvec,
+		int flags)
+{
+#ifdef USE_ZEROCOPY
+	struct page *page = bvec->bv_page;
+	size_t size = bvec->bv_len;
+	int offset = bvec->bv_offset;
+	int result;
 
-		spin_lock(&lo->queue_lock);
+	flags |= MSG_NOSIGNAL;
+	do {
+		result = sock->ops->sendpage(sock, page, offset, size, flags);
+		if (result <= 0)
+			break;
+		size -= result;
+		offset += result;
+	} while (size > 0);
+	return result;
+#else /* USE_ZEROCOPY */
+	return sock_xmit(sock, 1, page_address(bvec->bv_page) + bvec->bv_offset,
+			bvec->bv_len, flags);
+#endif /* USE_ZEROCOPY */
+}
 
-		if (!lo->file) {
-			spin_unlock(&lo->queue_lock);
-			printk(KERN_ERR "nbd: failed between accept and semaphore, file lost\n");
-			req->errors++;
-			nbd_end_request(req);
-			spin_lock_irq(q->queue_lock);
-			continue;
+static inline int sock_send_buffers(struct socket *sock, struct request *req)
+{
+	int flags;
+	int result = -ENOMEM; /* returned if bh == NULL */
+	int msg_eor = (sock->type == SOCK_SEQPACKET)? MSG_EOR: 0;
+	int i;
+	struct bio *bio;
+	/*
+	 * we are really probing at internals to determine
+	 * whether to set MSG_MORE or not...
+	 */
+	rq_for_each_bio(bio, req) {
+		struct bio_vec *bvec;
+		bio_for_each_segment(bvec, bio, i) {
+			flags = ((i + 1 < bio->bi_vcnt) || bio->bi_next)?
+				MSG_MORE: msg_eor;
+			result = sock_send_bvec(sock, bvec, flags);
+			if (result <= 0)
+				return result;
 		}
+	}
+	return result;
+}
 
-		list_add(&req->queuelist, &lo->queue_head);
-		spin_unlock(&lo->queue_lock);
+#ifndef NDEBUG
+static const char *cmd_to_ascii(int cmd)
+{
+	switch (cmd) {
+	case 0: return "read";
+	case 1: return "write";
+	case 2: return "disconnect";
+	}
+	return "invalid";
+}
+#endif /* NDEBUG */
 
-		nbd_send_req(lo, req);
+static inline int sock_send_request(struct socket *sock, struct request *req)
+{
+	int result;
+	nbd_request_t request;
+	unsigned long size = req->nr_sectors << 9;
 
-		if (req->errors) {
-			printk(KERN_ERR "nbd: nbd_send_req failed\n");
-			spin_lock(&lo->queue_lock);
-			list_del_init(&req->queuelist);
-			spin_unlock(&lo->queue_lock);
-			nbd_end_request(req);
-			spin_lock_irq(q->queue_lock);
-			continue;
-		}
+	request.magic = request_magic;
+	request.type = htonl(REQUEST_CMD(req));
+	request.from = cpu_to_be64( (u64) req->sector << 9);
+	request.len = htonl(size);
+	memcpy(request.handle, &req, sizeof(req));
 
-		spin_lock_irq(q->queue_lock);
-		continue;
+	result = sock_xmit(sock, 1, &request, sizeof(request),
+			(REQUEST_CMD(req) == WRITE)? MSG_MORE: 0);
+	if (result <= 0)
+		return result;
+	if (REQUEST_CMD(req) == WRITE)
+		result = sock_send_buffers(sock, req);
+	return result;
+}
 
-	      error_out:
-		req->errors++;
-		blkdev_dequeue_request(req);
-		spin_unlock(q->queue_lock);
-		nbd_end_request(req);
-		spin_lock(q->queue_lock);
+/**
+ * nbd_send_request - called by tx thread to send NBD requests
+ * @lo: nbd device
+ * @req: pointer to request
+ *
+ * Should only be called by tx thread to ensure integrity of data stream.
+ */
+static int nbd_send_request(nbd_device_t *lo, struct request *req)
+{
+	int result;
+
+	result = sock_send_request(lo->sock, req);
+	if (result < 0) {
+		lo->errcnt++;
+		lo->lasterr = -result;
+		printk(KERN_ERR "nb%d: error sending request %p (%d).\n",
+				DEVICE_TO_MINOR(lo), req, result);
 	}
-	return;
+	else if (result == 0) {
+		lo->closed |= SEND_SHUTDOWN;
+		lo->lasterr = ECONNRESET;
+		printk("nb%d: write closed on request %p\n",
+				DEVICE_TO_MINOR(lo), req);
+	}
+	return result;
 }
 
-static int nbd_ioctl(struct inode *inode, struct file *file,
-		     unsigned int cmd, unsigned long arg)
+static int nbd_recv_reply(nbd_device_t *lo, struct request **req)
 {
-	struct nbd_device *lo = inode->i_bdev->bd_disk->private_data;
-	int error, temp;
-	struct request sreq ;
+	int result;
+	nbd_reply_t reply;
+	struct socket *sock;
+#ifndef NDEBUG
+	int minor = DEVICE_TO_MINOR(lo);
+#endif
 
-	/* Anyone capable of this syscall can do *real bad* things */
+	*req = NULL;
+	sock = lo->sock;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-	switch (cmd) {
-	case NBD_DISCONNECT:
-	        printk(KERN_INFO "NBD_DISCONNECT\n");
-		sreq.flags = REQ_SPECIAL;
-		nbd_cmd(&sreq) = NBD_CMD_DISC;
-                if (!lo->sock)
-			return -EINVAL;
-                nbd_send_req(lo, &sreq);
-                return 0 ;
- 
-	case NBD_CLEAR_SOCK:
-		nbd_clear_que(lo);
-		spin_lock(&lo->queue_lock);
-		if (!list_empty(&lo->queue_head)) {
-			spin_unlock(&lo->queue_lock);
-			printk(KERN_ERR "nbd: Some requests are in progress -> can not turn off.\n");
-			return -EBUSY;
-		}
-		file = lo->file;
-		if (!file) {
-			spin_unlock(&lo->queue_lock);
-			return -EINVAL;
+	result = sock_xmit(sock, 0, &reply, sizeof(reply), MSG_WAITALL);
+	if (result < 0) {
+		printk(KERN_ERR "nb%d: error receiving reply (%d).\n",
+				minor, result);
+		goto leave;
+	}
+	if (result == 0) {
+		printk("nb%d: read reply closed.\n", minor);
+		goto leave;
+	}
+	if (reply.magic != reply_magic) {
+		result = -EPROTO;
+		printk(KERN_ERR "nb%d: wrong reply magic.\n", minor);
+		goto leave;
+	}
+	*req = nbd_qsys_deq_request(&lo->rx_queue, reply.handle);
+	if (!*req) {
+		if (nbd_write_nochk(lo)) {
+			/* No big deal when NBD_WRITE_NOCHK set */
+			dprintk(NBD_DEBUG_RX, "nb%d: unexpected reply %p\n",
+					minor, req);
 		}
-		lo->file = NULL;
-		lo->sock = NULL;
-		spin_unlock(&lo->queue_lock);
-		fput(file);
-		return 0;
-	case NBD_SET_SOCK:
-		if (lo->file)
-			return -EBUSY;
-		error = -EINVAL;
-		file = fget(arg);
-		if (file) {
-			inode = file->f_dentry->d_inode;
-			if (inode->i_sock) {
-				lo->file = file;
-				lo->sock = SOCKET_I(inode);
-				error = 0;
-			} else {
-				fput(file);
-			}
+		else {
+			/* We'd better indicate error though in this case! */
+			result = -ESRCH;
+			printk(KERN_ERR "nb%d: unexpected reply!\n", minor);
 		}
-		return error;
-	case NBD_SET_BLKSIZE:
-		if ((arg & (arg-1)) || (arg < 512) || (arg > PAGE_SIZE))
-			return -EINVAL;
-		lo->blksize = arg;
-		temp = arg >> 9;
-		lo->blksize_bits = 9;
-		while (temp > 1) {
-			lo->blksize_bits++;
-			temp >>= 1;
+		goto leave;
+	}
+	lo->harderror = ntohl(reply.error);
+	if (lo->harderror) {
+		printk(KERN_ERR "nb%d: request %p, remote error (%d).\n",
+				minor, *req, lo->harderror);
+		(*req)->errors++;
+		goto leave;
+	}
+	if (REQUEST_CMD(*req) == READ) {    /* then more to read... */
+		result = sock_recv_buffers(sock, *req);
+		if (result < 0)
+			printk(KERN_ERR "nb%d: request %p, error receiving data (%d).\n",
+					minor, *req, result);
+		else if (result == 0)
+			printk(KERN_ERR "nb%d: request %p, read data closed.\n",
+					minor, *req);
+		else {
+			dprintk(NBD_DEBUG_RX, "nb%d: request %p, received reply\n",
+					minor, *req);
+			/* yeah! got entire request! */
+			goto leave;
 		}
-		lo->bytesize &= ~(lo->blksize-1); 
-		set_capacity(lo->disk, lo->bytesize >> 9);
-		return 0;
-	case NBD_SET_SIZE:
-		lo->bytesize = arg & ~(lo->blksize-1); 
-		set_capacity(lo->disk, lo->bytesize >> 9);
-		return 0;
-	case NBD_SET_SIZE_BLOCKS:
-		lo->bytesize = ((u64) arg) << lo->blksize_bits;
-		set_capacity(lo->disk, lo->bytesize >> 9);
-		return 0;
-	case NBD_DO_IT:
-		if (!lo->file)
-			return -EINVAL;
-		nbd_do_it(lo);
-		/* on return tidy up in case we have a signal */
-		/* Forcibly shutdown the socket causing all listeners
-		 * to error
-		 *
-		 * FIXME: This code is duplicated from sys_shutdown, but
-		 * there should be a more generic interface rather than
-		 * calling socket ops directly here */
-		down(&lo->tx_lock);
-		printk(KERN_WARNING "nbd: shutting down socket\n");
-		lo->sock->ops->shutdown(lo->sock, SEND_SHUTDOWN|RCV_SHUTDOWN);
-		lo->sock = NULL;
-		up(&lo->tx_lock);
-		spin_lock(&lo->queue_lock);
-		file = lo->file;
-		lo->file = NULL;
-		spin_unlock(&lo->queue_lock);
-		nbd_clear_que(lo);
-		printk(KERN_WARNING "nbd: queue cleared\n");
-		if (file)
-			fput(file);
-		return lo->harderror;
-	case NBD_CLEAR_QUE:
-		nbd_clear_que(lo);
-		return 0;
-#ifdef PARANOIA
-	case NBD_PRINT_DEBUG:
-		printk(KERN_INFO "%s: next = %p, prev = %p. Global: in %d, out %d\n",
-		       inode->i_bdev->bd_disk->disk_name, lo->queue_head.next,
-		       lo->queue_head.prev, requests_in, requests_out);
-		return 0;
-#endif
+		/* re-rx-queue request for possible future redo... */
+		nbd_qsys_enq_head(&lo->rx_queue, *req);
+		*req = NULL; /* make it seem like we never got request */
 	}
-	return -EINVAL;
+leave:
+	if (result < 0) {
+		lo->errcnt++;
+		lo->lasterr = -result;
+	}
+	else if (result == 0) {
+		lo->closed |= RCV_SHUTDOWN;
+		lo->lasterr = ECONNRESET;
+	}
+	return result;
 }
 
-static int nbd_release(struct inode *inode, struct file *file)
+static inline int nbd_activate_kids(nbd_device_t *lo)
 {
-	struct nbd_device *lo = inode->i_bdev->bd_disk->private_data;
-	if (lo->refcnt <= 0)
-		printk(KERN_ALERT "nbd_release: refcount(%d) <= 0\n", lo->refcnt);
-	lo->refcnt--;
-	/* N.B. Doesn't lo->file need an fput?? */
+	int rv;
+
+	rv = nbd_thread_start(lo, &lo->rx_thread, rx_loop);
+	if (rv < 0)
+		return rv;
+	rv = nbd_thread_start(lo, &lo->tx_thread, tx_loop);
+	if (rv < 0) {
+		nbd_thread_stop(lo, &lo->rx_thread, 1);
+		return rv;
+	}
 	return 0;
 }
 
-static struct block_device_operations nbd_fops =
+static inline int nbd_deactivate_kids(nbd_device_t *lo)
 {
-	.owner =	THIS_MODULE,
-	.open =		nbd_open,
-	.release =	nbd_release,
-	.ioctl =	nbd_ioctl,
-};
+	nbd_thread_stop(lo, &lo->tx_thread, 1);
+	nbd_thread_stop(lo, &lo->rx_thread, 1);
+	return 0;
+}
 
-/*
- * And here should be modules and kernel interface 
- *  (Just smiley confuses emacs :-)
+/**
+ * nbd_shutdown - shutdown kids & network connection as needed.
+ * @lo: pointer to nbd_device_t
+ *
+ * Must be called with lo->semalock held!
  */
-
-static struct request_queue nbd_queue;
-
-static int __init nbd_init(void)
+static int nbd_shutdown(nbd_device_t *lo)
 {
-	int err = -ENOMEM;
-	int i;
-
-	if (sizeof(struct nbd_request) != 28) {
-		printk(KERN_CRIT "Sizeof nbd_request needs to be 28 in order to work!\n" );
-		return -EIO;
-	}
-
-	for (i = 0; i < MAX_NBD; i++) {
-		struct gendisk *disk = alloc_disk(1);
-		if (!disk)
-			goto out;
-		nbd_dev[i].disk = disk;
-	}
+#ifdef PARANOIA
+	BUG_ON(atomic_read(&lo->semalock.count) != 0);
+#endif
+	dprintk(NBD_DEBUG_SESSION, "nb%d: %s called.\n",
+			DEVICE_TO_MINOR(lo), __FUNCTION__);
+	nbd_deactivate_kids(lo);
+	if (lo->sin.sin_addr.s_addr)
+		nbd_deactivate_sin(lo);
+	return 0;
+}
 
-	if (register_blkdev(NBD_MAJOR, "nbd")) {
-		err = -EIO;
-		goto out;
-	}
-#ifdef MODULE
-	printk("nbd: registered device at major %d\n", NBD_MAJOR);
+/**
+ * nbd_startup - startup network connection & kids as needed.
+ * @lo: pointer to nbd_device_t
+ *
+ * Must be called with lo->semalock held!
+ */
+static int nbd_startup(nbd_device_t *lo)
+{
+	int rv;
+#ifndef NDEBUG
+	int minor = DEVICE_TO_MINOR(lo);
+#endif /* NDEBUG */
+#ifdef PARANOIA
+	BUG_ON(atomic_read(&lo->semalock.count) != 0);
 #endif
-	blk_init_queue(&nbd_queue, do_nbd_request, &nbd_lock);
-	devfs_mk_dir("nbd");
-	for (i = 0; i < MAX_NBD; i++) {
-		struct gendisk *disk = nbd_dev[i].disk;
-		nbd_dev[i].refcnt = 0;
-		nbd_dev[i].file = NULL;
-		nbd_dev[i].magic = LO_MAGIC;
-		nbd_dev[i].flags = 0;
-		spin_lock_init(&nbd_dev[i].queue_lock);
-		INIT_LIST_HEAD(&nbd_dev[i].queue_head);
-		init_MUTEX(&nbd_dev[i].tx_lock);
-		nbd_dev[i].blksize = 1024;
-		nbd_dev[i].blksize_bits = 10;
-		nbd_dev[i].bytesize = ((u64)0x7ffffc00) << 10; /* 2TB */
-		disk->major = NBD_MAJOR;
-		disk->first_minor = i;
-		disk->fops = &nbd_fops;
-		disk->private_data = &nbd_dev[i];
-		disk->queue = &nbd_queue;
-		sprintf(disk->disk_name, "nbd%d", i);
-		sprintf(disk->devfs_name, "nbd/%d", i);
-		set_capacity(disk, 0x3ffffe);
-		add_disk(disk);
+	dprintk(NBD_DEBUG_SESSION, "nb%d: %s called.\n", minor, __FUNCTION__);
+	if (lo->sin.sin_addr.s_addr) {
+		dprintk(NBD_DEBUG_SESSION, "nb%d: %s: trying to connect\n",
+				minor, __FUNCTION__);
+		/*
+		 * The following nbd_activate_sin() then will
+		 * block till the remote host or network is up
+		 * or the connection attempt times out...
+		 * Don't forget we're holding lo->semalock now!
+		 */
+		if (nbd_activate_sin(lo) < 0)
+			return -ENOMEDIUM;
+		dprintk(NBD_DEBUG_SESSION, "nb%d: %s: connection established\n",
+				minor, __FUNCTION__);
 	}
-
+	if (!lo->sock)
+		return -ENOMEDIUM;
+	rv = nbd_activate_kids(lo);
+	if (rv < 0) {
+		nbd_deactivate_sin(lo);
+		return rv;
+	}
+	dprintk(NBD_DEBUG_SESSION, "nb%d: %s: succeeded.\n", minor, __FUNCTION__);
 	return 0;
-out:
-	while (i--)
-		put_disk(nbd_dev[i].disk);
-	return err;
 }
 
-static void __exit nbd_cleanup(void)
+static void unblock_sigkill(void)
 {
-	int i;
-	for (i = 0; i < MAX_NBD; i++) {
-		del_gendisk(nbd_dev[i].disk);
-		put_disk(nbd_dev[i].disk);
+	int unblocked = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&current->sighand->siglock, flags);
+	if (sigismember(&current->blocked, SIGKILL)) {
+		sigdelsetmask(&current->blocked, sigmask(SIGKILL));
+		recalc_sigpending();
+		unblocked = 1;
 	}
-	devfs_remove("nbd");
-	blk_cleanup_queue(&nbd_queue);
-	unregister_blkdev(NBD_MAJOR, "nbd");
+	spin_unlock_irqrestore(&current->sighand->siglock, flags);
+	if (unblocked)
+		dprintk(NBD_DEBUG_THREADS, "%s[%d]: SIGKILL unblocked.\n",
+				current->comm, current->pid);
 }
 
-module_init(nbd_init);
-module_exit(nbd_cleanup);
+static int session_loop(void *data)
+{
+	nbd_device_t *lo = (nbd_device_t *)data;
+	int rv = 0, seconds, ncleared;
+#ifndef NDEBUG
+	int minor = DEVICE_TO_MINOR(lo);
+#endif /* NDEBUG */
+
+	__module_get(THIS_MODULE);
+	DAEMONIZE("nb%d-sess", lo - nbd_devs);
+	spin_lock(&lo->lock);
+	lo->ss_thread.task = current;
+	spin_unlock(&lo->lock);
+	unblock_sigkill();
+	complete(&lo->ss_thread.startup);
 
-MODULE_DESCRIPTION("Network Block Device");
-MODULE_LICENSE("GPL");
+	dprintk(NBD_DEBUG_THREADS, "%s[%d]: started.\n",
+			current->comm, current->pid);
 
+	seconds = 10;
+	do {
+		if (nbd_do_it(lo) == 0) {
+			/* connection succeeded at least so reset sleep... */
+			seconds = 60; /* a minimum server reboot time */
+		}
+		if (!(lo->flags & NBD_RESTARTABLE))
+			break;
+		if (signal_pending(current))
+			break;
+		dprintk(NBD_DEBUG_SESSION,
+			"nb%d: sleeping %ds before attempting re-connect\n",
+			minor, seconds);
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ * seconds);
+		set_current_state(TASK_RUNNING);
+		/*
+		 * Already waited seconds, so probably don't need to sleep
+		 * as long next time...
+		 */
+		if (seconds > 10)
+			seconds -= 10;
+	} while (!signal_pending(current));
+
+	ncleared = nbd_qsys_clear(&lo->tx_queue);
+	if (ncleared)
+		dprintk(NBD_DEBUG_SESSION,
+			"nb%d: cleared %d tx requests.\n",
+			DEVICE_TO_MINOR(lo), ncleared);
+	ncleared = nbd_qsys_clear(&lo->rx_queue);
+	if (ncleared)
+		dprintk(NBD_DEBUG_SESSION,
+			"nb%d: cleared %d rx requests.\n",
+			DEVICE_TO_MINOR(lo), ncleared);
+
+	dprintk(NBD_DEBUG_THREADS, "%s[%d]: ending.\n",
+			current->comm, current->pid);
+
+	spin_lock(&lo->lock);
+	lo->ss_thread.task = NULL;
+	spin_unlock(&lo->lock);
+	complete(&lo->ss_thread.finish);
+	module_put(THIS_MODULE);
 
+	return rv;
+}
+
+static void end_io_cycle(nbd_device_t *lo)
+{
+	dprintk(NBD_DEBUG_THREADS, "%s[%d]: called %s (flags=%x)\n",
+			current->comm, current->pid, __FUNCTION__, lo->flags);
+	down(&lo->semalock);
+	if (lo->flags & NBD_NONBLOCKING)
+		nbd_clear_queue(lo);
+	else
+		nbd_redo_queue(lo);
+	up(&lo->semalock);
+	wake_up(&lo->no_io_waiters);
+}
+
+static int rx_loop(void *data)
+{
+	nbd_device_t *lo = (nbd_device_t *)data;
+	int signr;
+	struct request *req;
+	int result;
+
+	__module_get(THIS_MODULE);
+	atomic_inc(&lo->num_io_threads);
+	DAEMONIZE("nb%d-rx", lo - nbd_devs);
+	spin_lock(&lo->lock);
+	lo->rx_thread.task = current;
+	spin_unlock(&lo->lock);
+	unblock_sigkill();
+	complete(&lo->rx_thread.startup);
+
+	dprintk(NBD_DEBUG_THREADS, "%s[%d]: started.\n",
+			current->comm, current->pid);
+
+	while ((signr = signal_pending(current)) == 0) {
+		result = nbd_recv_reply(lo, &req);
+		if (result <= 0) {
+			if (result == -ERESTARTSYS || result == -EINTR)
+				signr = signal_pending(current);
+			if (req)
+				request_end(req, 0);
+			break;
+		}
+		dprintk(NBD_DEBUG_RX, "nb%d: received reply, req=%p\n",
+				DEVICE_TO_MINOR(lo), req);
+		if (req)
+			request_end(req, req->errors? 0: 1);
+	}
+
+	if (signr)
+		printk("%s[%d]: signaled to exit (state=%ld)\n",
+				current->comm, current->pid, current->state);
+	set_current_state(TASK_RUNNING);
+	dprintk(NBD_DEBUG_THREADS, "%s[%d]: ending.\n",
+			current->comm, current->pid);
+
+	/*
+	 * Nullify our task ptr before trying to stop tx thread so tx
+	 * thread does not wind up trying to stop us back.
+	 */
+	spin_lock(&lo->lock);
+	lo->rx_thread.task = NULL;
+	spin_unlock(&lo->lock);
+	nbd_thread_stop(lo, &lo->tx_thread, 0);
+	complete(&lo->rx_thread.finish);
+	if (atomic_dec_and_test(&lo->num_io_threads))
+		end_io_cycle(lo);
+	module_put(THIS_MODULE);
+	return 0;
+}
+
+/**
+ * tx_loop - transmit loop
+ * @data: pointer to nbd_device_t
+ *
+ * Invoked as a seperate kernel thread to process the transmit queue for
+ * the device.
+ */
+static int tx_loop(void *data)
+{
+	nbd_device_t *lo = (nbd_device_t *)data;
+	struct request *req;
+	int result, signr, enqueued;
+#ifndef NDEBUG
+	int minor = DEVICE_TO_MINOR(lo);
+#endif
+
+	__module_get(THIS_MODULE);
+	atomic_inc(&lo->num_io_threads);
+	DAEMONIZE("nb%d-tx", lo - nbd_devs);
+	spin_lock(&lo->lock);
+	lo->tx_thread.task = current;
+	spin_unlock(&lo->lock);
+	unblock_sigkill();
+	complete(&lo->tx_thread.startup);
+
+	dprintk(NBD_DEBUG_THREADS, "%s[%d]: started.\n",
+			current->comm, current->pid);
+
+	while ((signr = signal_pending(current)) == 0) {
+		req = nbd_qsys_deq_head_eventually(&lo->tx_queue);
+		if (!req)
+			continue;
+		enqueued = 0;
+		if (REQUEST_CMD(req) != DISCONNECT_NBD) {
+			if (REQUEST_CMD(req) != WRITE || !nbd_write_nochk(lo)) {
+				nbd_qsys_enq_tail(&lo->rx_queue, req);
+				enqueued = 1;
+			}
+		}
+		result = nbd_send_request(lo, req);
+		if (result <= 0) {
+			if (result == -ERESTARTSYS || result == -EINTR)
+				signr = signal_pending(current);
+			if (!enqueued)
+				break;
+			if (!nbd_qsys_deq_request(&lo->rx_queue, (char *)req)) {
+				dprintk(NBD_DEBUG_TX,
+						"nb%d: lost request %p???\n",
+						minor, req);
+				break;
+			}
+			goto reque_request;
+		}
+		dprintk(NBD_DEBUG_TX, "nb%d: sent request %p(%s@%llu,%luB)\n",
+				minor, req,
+				cmd_to_ascii(REQUEST_CMD(req)),
+				(u64) req->sector << 9,
+				req->nr_sectors << 9);
+		if (REQUEST_CMD(req) == DISCONNECT_NBD)
+			break;
+		if (REQUEST_CMD(req) == WRITE && nbd_write_nochk(lo))
+			request_end(req, 1);
+		continue;
+
+reque_request:
+		/* put request back on tx queue... */
+		nbd_qsys_enq_head(&lo->tx_queue, req);
+		dprintk(NBD_DEBUG_TX, "nb%d: re-tx-queued request %p\n",
+				minor, req);
+		break;
+	}
+
+	if (signr)
+		printk("%s[%d]: signaled to exit (state=%ld)\n",
+				current->comm, current->pid, current->state);
+	set_current_state(TASK_RUNNING);
+	dprintk(NBD_DEBUG_THREADS, "%s[%d]: ending.\n",
+			current->comm, current->pid);
+
+	spin_lock(&lo->lock);
+	lo->tx_thread.task = NULL;
+	spin_unlock(&lo->lock);
+	nbd_thread_stop(lo, &lo->rx_thread, 0);
+	complete(&lo->tx_thread.finish);
+	if (atomic_dec_and_test(&lo->num_io_threads))
+		end_io_cycle(lo);
+	module_put(THIS_MODULE);
+	return 0;
+}
+
+static int nbd_thread_start(nbd_device_t *lo, nbd_thread_t *th, thread_fn_t fn)
+{
+	int rv;
+	struct task_struct *task;
+
+	dprintk(NBD_DEBUG_THREADS, "nb%d: %s[%d] called %s.\n",
+			DEVICE_TO_MINOR(lo), current->comm, current->pid,
+			__FUNCTION__);
+
+	spin_lock(&lo->lock);
+	task = th->task;
+	if (!task) {
+		/* insure no thread start races */
+		th->task = (struct task_struct *)-1;
+	}
+	spin_unlock(&lo->lock);
+	if (task)
+		return -EBUSY;
+	init_completion(&th->startup);
+	init_completion(&th->finish);
+	rv = kernel_thread(fn, lo, CLONE_FS|CLONE_FILES);
+	if (rv >= 0)
+		wait_for_completion(&th->startup);
+	return rv;
+}
+
+static int nbd_thread_stop(nbd_device_t *lo, nbd_thread_t *th, int wait)
+{
+	pid_t signaled;
+	struct task_struct *task;
+
+	dprintk(NBD_DEBUG_THREADS, "nb%d: %s[%d] called %s.\n",
+			DEVICE_TO_MINOR(lo), current->comm, current->pid,
+			__FUNCTION__);
+
+	signaled = 0;
+	// read_lock(&tasklist_lock);
+	spin_lock(&lo->lock);
+	task = th->task;
+	if (task) {
+		// XXX task no longer has field counter
+		// th->task->counter = 5 * HZ;
+		// XXX Why add PF_MEMALLOC?? Not in memalloc routine!
+		// th->task->flags |= PF_MEMALLOC;
+		force_sig(SIGKILL, task);
+		signaled = task->pid;
+		// th->task = NULL;
+	}
+	spin_unlock(&lo->lock);
+	// read_unlock(&tasklist_lock);
+	if (signaled) {
+		dprintk(NBD_DEBUG_THREADS,
+			"nb%d: %s signaled pid %d.\n",
+			DEVICE_TO_MINOR(lo), __FUNCTION__, signaled);
+		if (wait)
+			wait_for_completion(&th->finish);
+		return 1;
+	}
+	return 0;
+}
+
+static int getconnection(struct sockaddr_in *sin, struct socket **sock)
+{
+	int rv;
+
+	rv = sock_create(PF_INET, SOCK_STREAM, IPPROTO_TCP, sock);
+	if (rv < 0) {
+		printk(DEVICE_NAME ": error creating socket: %d\n", rv);
+		return rv;
+	}
+	rv = (*sock)->ops->connect(*sock, (struct sockaddr *)sin,
+			sizeof(*sin), 0);
+	if (rv < 0) {
+		printk(DEVICE_NAME ": error connecting to 0x%X:%d (%d).\n",
+				ntohl(sin->sin_addr.s_addr),
+				ntohs(sin->sin_port), rv);
+		return rv;
+	}
+	return 0;
+}
+
+static unsigned char protomagic[] = NBD_PROTOMAGIC;
+
+static int handshake(struct socket *sock, nbd_svr_info_t *svrinfo)
+{
+	int rv;
+	static const char initpwd[] = NBD_INIT_PASSWD;
+
+	/* get initial NBD password (more of a header magic really) */
+	rv = sock_xmit(sock, 0, svrinfo->initpwd, sizeof(svrinfo->initpwd),
+			MSG_WAITALL);
+	if (rv <= 0)
+		goto error;
+	if (strncmp(svrinfo->initpwd, initpwd, sizeof(svrinfo->initpwd))) {
+		printk(DEVICE_NAME ": bad handshake: expecting \"%s\", got \"%.8s\"!\n",
+				initpwd, svrinfo->initpwd);
+		goto error;
+	}
+
+	/* get protocol magic */
+	rv = sock_xmit(sock, 0, svrinfo->magic, sizeof(svrinfo->magic),
+			MSG_WAITALL);
+	if (rv <= 0)
+		goto error;
+	if (*(u64 *)svrinfo->magic != *(u64 *)protomagic) {
+		printk(DEVICE_NAME ": bad handshake: wrong magic (got 0x%llx)!\n",
+				*((u64 *)svrinfo->magic));
+		goto error;
+	}
+
+	/* get server storage size */
+	rv = sock_xmit(sock, 0, &svrinfo->size, sizeof(svrinfo->size),
+			MSG_WAITALL);
+	if (rv <= 0)
+		goto error;
+	svrinfo->size = ntohll(svrinfo->size);
+	printk(DEVICE_NAME ": server says size is %lld bytes.\n", svrinfo->size);
+
+	/* get zeros */
+	rv = sock_xmit(sock, 0, svrinfo->zeros, sizeof(svrinfo->zeros),
+			MSG_WAITALL);
+	if (rv <= 0)
+		goto error;
+
+	return 0;
+
+error:
+	if (rv < 0) return rv;
+	return -EPROTO;
+}
+
+/* Must be called with semalock held! */
+static int nbd_deactivate_sin(nbd_device_t *lo)
+{
+	struct socket *sock;
+
+	spin_lock(&lo->lock);
+	sock = lo->sock;
+	if (sock)
+		lo->sock = NULL;
+	spin_unlock(&lo->lock);
+	if (!sock)
+		return -ENOTCONN;
+	lo->closed = (RCV_SHUTDOWN|SEND_SHUTDOWN);
+	// XXX is this right???
+	if (sock->state == SS_CONNECTED) {
+		struct sock *sk = sock->sk;
+		sock->sk = NULL;
+		sk->sk_prot->close(sk, 0L);
+	}
+	sock_release(sock);
+	if (!lo->lasterr)
+		lo->lasterr = ENOTCONN;
+	if (atomic_dec_and_test(&lo->refcnt)) {
+		if (lo->flags & NBD_CLEARED) {
+			lo->flags &= ~NBD_NONBLOCKING;
+			lo->flags &= ~NBD_CLEARED;
+		}
+	}
+	return 0;
+}
+
+static int nbd_activate_sin(nbd_device_t *lo)
+{
+	int rv;
+	nbd_svr_info_t svrinfo;
+
+	if (!lo->sin.sin_addr.s_addr)
+		return -ENOENT;
+	atomic_inc(&lo->refcnt);
+	lo->errcnt = 0;
+	rv = getconnection(&lo->sin, &lo->sock);
+	if (rv < 0)
+		goto leave;
+	lo->closed = 0;
+	rv = handshake(lo->sock, &svrinfo);
+leave:
+	if (rv < 0) {
+		lo->lasterr = -rv;
+		nbd_deactivate_sin(lo);
+	}
+	else {
+		lo->lasterr = 0;
+		nbd_set_size64(lo, svrinfo.size);
+	}
+	return rv;
+}
+
+static void nbd_qsys_init(nbd_qsys_t *q)
+{
+	spin_lock_init(&q->lock);
+	q->len = 0;
+	INIT_LIST_HEAD(&q->head);
+	init_waitqueue_head(&q->waiters);
+}
+
+/*
+ * Here begins definitions of ioctl handling functions...
+ */
+
+/* Must be called with lo->semalock held */
+static int nbd_clear_queue(nbd_device_t *lo)
+{
+	int rv, ncleared, set_nonblocking;
+
+#ifdef PARANOIA
+	BUG_ON(lo->magic != LO_MAGIC);
+#endif
+	ncleared = 0;
+	set_nonblocking = 0;
+
+	dprintk(NBD_DEBUG_IOCTL, "nb%d: %s called\n",
+			DEVICE_TO_MINOR(lo), __FUNCTION__);
+	if (lo->file) {
+		spin_lock(&lo->lock);
+		if (lo->rx_thread.task)
+			printk("nb%d: NBD_CLEAR_QUEUE ioctl invoked while RX active, upgrade tools!\n",
+					DEVICE_TO_MINOR(lo));
+		else {
+			if (!(lo->flags & NBD_NONBLOCKING)) {
+				lo->flags |= NBD_NONBLOCKING;
+				set_nonblocking++;
+			}
+			ncleared += nbd_qsys_clear(&lo->rx_queue);
+		}
+		if (lo->tx_thread.task)
+			printk("nb%d: NBD_CLEAR_QUEUE ioctl invoked while TX active, upgrade tools!\n",
+					DEVICE_TO_MINOR(lo));
+		else {
+			if (!(lo->flags & NBD_NONBLOCKING)) {
+				lo->flags |= NBD_NONBLOCKING;
+				set_nonblocking++;
+			}
+			ncleared += nbd_qsys_clear(&lo->tx_queue);
+		}
+		spin_unlock(&lo->lock);
+		if (set_nonblocking)
+			lo->flags |= NBD_CLEARED;
+		dprintk(NBD_DEBUG_IOCTL,
+				"nb%d: %s cleared %d requests.\n",
+				DEVICE_TO_MINOR(lo), __FUNCTION__, ncleared);
+		return 0;
+	}
+
+	spin_lock(&lo->lock);
+	if (lo->rx_thread.task || lo->tx_thread.task)
+		rv = -EBUSY;
+	else {
+		if (!(lo->flags & NBD_NONBLOCKING)) {
+			lo->flags |= NBD_NONBLOCKING;
+			set_nonblocking++;
+		}
+		ncleared += nbd_qsys_clear(&lo->rx_queue);
+		ncleared += nbd_qsys_clear(&lo->tx_queue);
+		rv = ncleared;
+	}
+	spin_unlock(&lo->lock);
+	if (set_nonblocking)
+		lo->flags |= NBD_CLEARED;
+	dprintk(NBD_DEBUG_IOCTL,
+			"nb%d: %s ended %d requests.\n",
+			DEVICE_TO_MINOR(lo), __FUNCTION__, ncleared);
+	return rv;
+}
+
+static int nbd_redo_queue(nbd_device_t *lo)
+{
+	int rv;
+	struct request *req;
+
+	rv = 0;
+	spin_lock(&lo->lock);
+	if (lo->rx_thread.task || lo->tx_thread.task) {
+		rv = -EBUSY;
+		goto leave;
+	}
+	/* must preserve order of requests... */
+	while ((req = nbd_qsys_deq_tail(&lo->rx_queue)) != NULL) {
+		nbd_qsys_enq_head(&lo->tx_queue, req);
+		rv++;
+	}
+leave:
+	spin_unlock(&lo->lock);
+	if (rv >= 0)
+		dprintk(NBD_DEBUG_SESSION,
+				"nb%d: %s moved %d requests from rx queue\n",
+				DEVICE_TO_MINOR(lo), __FUNCTION__, rv);
+	return rv;
+}
+
+static int nbd_set_sin(nbd_device_t *lo, struct sockaddr_in *sin)
+{
+	if (lo->file)
+		return -EINVAL;
+	if (lo->closed != (RCV_SHUTDOWN|SEND_SHUTDOWN))
+		return -EBUSY;
+	if (lo->sock)
+		return -EBUSY;
+	if (lo->sin.sin_addr.s_addr)
+		return -EBUSY;
+	memcpy(&lo->sin, sin, sizeof(lo->sin));
+	return 0;
+}
+
+static int nbd_clr_sin(nbd_device_t *lo)
+{
+	if (lo->file)
+		return -EINVAL;
+	if (lo->sock)
+		return -EBUSY;
+	if (!lo->sin.sin_addr.s_addr)
+		return -EINVAL;
+	memset(&lo->sin, 0, sizeof(lo->sin));
+	return 0;
+}
+
+/*
+ * This must implement old NBD_SET_SOCK sematics...
+ */
+static int nbd_set_sock(nbd_device_t *lo, unsigned long arg)
+{
+	int rv;
+	struct file *file;
+	struct inode *inode;
+	struct socket *sock;
+
+	rv = 0;
+	file = NULL;
+
+	/*
+	 * Establish EBUSY or not first to help user space tool(s) know.
+	 * Using an illegal file descriptor of -1 then provides user space
+	 * programs with an easy way to figure out if device is already
+	 * connected without worry that descriptor will get used.
+	 */
+	if (lo->sock || lo->file) {
+		rv = -EBUSY;
+		goto leave;
+	}
+
+	file = fget(arg);
+	if (!file) {
+		rv = -EBADF;
+		goto leave;
+	}
+	inode = file->f_dentry->d_inode;
+	if (!S_ISSOCK(inode->i_mode)) {
+		rv = -ENOTSOCK;
+		goto leave;
+	}
+	if (!inode->i_sock) {
+		rv = -ENOTSOCK;
+		goto leave;
+	}
+	sock = SOCKET_I(inode);
+	if (sock->type != SOCK_STREAM && sock->type != SOCK_SEQPACKET) {
+		rv = -EPROTONOSUPPORT;
+		goto leave;
+	}
+	lo->file = file;
+	lo->sock = sock;
+	memset(&lo->sin, 0, sizeof(lo->sin));
+	lo->errcnt = 0;
+	lo->lasterr = 0;
+	lo->closed = 0;
+leave:
+	if (rv < 0) {
+		if (file)
+			fput(file);
+	}
+	dprintk(NBD_DEBUG_IOCTL,
+			"nb%d: %s descriptor %d, returning %d\n",
+			DEVICE_TO_MINOR(lo), __FUNCTION__, (int)arg, rv);
+	return rv;
+}
+
+/**
+ * nbd_clear_sock - Supports old style nbd shutdown.
+ * @lo: pointer to network block device.
+ *
+ * It's left up to the nbd_client user process to cause the
+ * close() of the socket (as it was in the old).
+ */
+static int nbd_clear_sock(nbd_device_t *lo)
+{
+	int rv;
+	struct file *file;
+
+	rv = 0;
+	file = NULL;
+	if (!lo->sock) {
+		rv = -ENOTCONN;
+		goto leave;
+	}
+	file = lo->file;
+	if (!file) {
+		/*
+		 * Must have been setup using nbd_set_sin().
+		 * User needs to use nbd_clr_sin() instead!
+		 */
+		rv = -EINVAL;
+		goto leave;
+	}
+	rv = -EBUSY;
+	spin_lock(&lo->lock);
+	if (!lo->rx_thread.task && !lo->tx_thread.task)
+		rv = 0;
+	spin_unlock(&lo->lock);
+	if (rv)
+		goto leave;
+	lo->file = NULL;
+	lo->sock = NULL;
+	lo->closed = (RCV_SHUTDOWN|SEND_SHUTDOWN);
+	if (!lo->lasterr)
+		lo->lasterr = ENOTCONN;
+leave:
+	if (file)
+		fput(file);
+	return rv;
+}
+
+static inline int nbd_start(nbd_device_t *lo)
+{
+	int rv;
+
+	down(&lo->semalock);
+	rv = nbd_startup(lo);
+	up(&lo->semalock);
+	return rv;
+}
+
+static inline int nbd_stop(nbd_device_t *lo)
+{
+	int rv;
+
+	down(&lo->semalock);
+	rv = nbd_shutdown(lo);
+	up(&lo->semalock);
+	return rv;
+}
+
+/**
+ * nbd_do_it - startup rx & tx threads then block till they're done.
+ * @lo: Pointer to network block device.
+ *
+ * Note: This function is meant for backward compatability with oldstyle
+ *   NBD usage & the oldstyle nbd_client program. This function is invoked
+ *   via the NBD_DO_IT ioctl or by the internal session thread.
+ */
+static int nbd_do_it(nbd_device_t *lo)
+{
+	int rv;
+#ifndef NDEBUG
+	int minor = DEVICE_TO_MINOR(lo);
+#endif
+
+	dprintk(NBD_DEBUG_SESSION, "nb%d: %s called.\n", minor, __FUNCTION__);
+
+	rv = 0;
+	spin_lock(&lo->lock);
+	if (lo->ss_thread.task && lo->ss_thread.task != current)
+		rv = -EBUSY;
+	spin_unlock(&lo->lock);
+	if (rv < 0)
+		goto leave;
+
+	rv = nbd_start(lo);
+	if (rv < 0)
+		goto leave;
+	wait_for_io_threads(lo);
+	nbd_stop(lo);
+
+leave:
+	dprintk(NBD_DEBUG_SESSION,
+		"nb%d: %s returning %d (rxlen %d, txlen %d)\n",
+		minor, __FUNCTION__, rv,
+		nbd_qsys_len(&lo->rx_queue), nbd_qsys_len(&lo->tx_queue));
+	return rv;
+}
+
+static int nbd_disconnect(nbd_device_t *lo)
+{
+	int rv, signaled_ss, signaled_tx, managed;
+	struct request sreq;
+
+	dprintk(NBD_DEBUG_SESSION, "nb%d: %s called\n",
+			DEVICE_TO_MINOR(lo), __FUNCTION__);
+
+	rv = 0;
+	signaled_ss = signaled_tx = 0;
+	down(&lo->semalock);
+	if (!lo->sock) {
+		rv = -ENOTCONN;
+		goto leave;
+	}
+	if (lo->flags & NBD_RESTARTABLE) {
+		dprintk(NBD_DEBUG_SESSION, "nb%d: disabling restart\n",
+				DEVICE_TO_MINOR(lo));
+		lo->flags &= ~NBD_RESTARTABLE;
+	}
+	spin_lock(&lo->lock);
+	managed = lo->ss_thread.task? 1: 0;
+	spin_unlock(&lo->lock);
+	REQUEST_CMD(&sreq) = DISCONNECT_NBD;
+	/* Enqueue request in turn onto Tx request queue if Tx thread up */
+	if (!lo->tx_thread.task)
+		goto leave;
+	nbd_qsys_enq_tail(&lo->tx_queue, &sreq);
+
+	/*
+	 * Any waiting we do for kids should be after up'ing
+	 * semalock to avoid deadlock'ing on the semaphore.
+	 */
+	up(&lo->semalock);
+	if (managed) {
+		dprintk(NBD_DEBUG_SESSION,
+			"nb%d: %s: waiting for session completion\n",
+			DEVICE_TO_MINOR(lo), __FUNCTION__);
+		wait_for_completion(&lo->ss_thread.finish);
+	}
+	else
+		wait_for_io_threads(lo);
+	down(&lo->semalock);
+
+leave:
+	if (rv == 0) {
+		nbd_shutdown(lo);
+		lo->lasterr = ENOTCONN;
+	}
+	up(&lo->semalock);
+	dprintk(NBD_DEBUG_SESSION, "nb%d: %s returning %d\n",
+			DEVICE_TO_MINOR(lo), __FUNCTION__, rv);
+	return rv;
+}
+
+/**
+ * do_nbd_request - the block device system request handling function.
+ * @q: queue of pending requests to operate on.
+ *
+ * This function may not actually handle any requests at all if it can't
+ * get all the needed resources. It's assumed that in this case, returning
+ * will let other things schedule and that this is okay with the blkdev
+ * system, specifically with linux/drivers/block/ll_rw_blk.c.
+ */
+static void do_nbd_request(request_queue_t *q)
+{
+	struct request *req;
+	int minor, nreqs;
+	nbd_device_t *lo;
+
+	dprintk(NBD_DEBUG_BLKDEV, DEVICE_NAME ": %s(%p) called\n",
+			__FUNCTION__, q);
+	qhandler_loops++;
+	nreqs = 0;
+	while ((req = REQUEST_QUEUE_NEXT_REQUEST(q)) != NULL) {
+		dprintk(NBD_DEBUG_BLKDEV, DEVICE_NAME ": got request (%p)\n",
+				req);
+		blkdev_dequeue_request(req);
+		nreqs++;
+		lo = req->rq_disk->private_data;
+		minor = DEVICE_TO_MINOR(lo);
+#ifdef PARANOIA
+		BUG_ON(lo->magic != LO_MAGIC);
+		if (minor >= MAX_NBD) {
+			printk(KERN_ERR DEVICE_NAME
+				": request %p: minor too big (%d>=%d)!\n",
+				req, minor, MAX_NBD);
+			goto fail_request;
+		}
+#endif
+		if (!blk_fs_request(req)) {
+			printk(KERN_ERR
+				"nb%d: request %p: not for fs - flags=0x%lX\n",
+				minor, req, req->flags);
+			goto fail_request;
+		}
+		REQUEST_CMD(req) = READ;
+		if (rq_data_dir(req) == WRITE)
+			REQUEST_CMD(req) = WRITE;
+		if ((REQUEST_CMD(req) == WRITE) && nbd_read_only(lo)) {
+			printk(KERN_ERR
+				"nb%d: request %p: write on read-only\n",
+				minor, req);
+			goto fail_request;
+		}
+		if (!lo->tx_thread.task && (lo->flags & NBD_NONBLOCKING)) {
+			printk(KERN_ERR
+				"nb%d: request %p: no tx task & non-blocking\n",
+				minor, req);
+			goto fail_request;
+		}
+		dprintk(NBD_DEBUG_BLKDEV, "nb%d: enqueuing tx request (%p)\n",
+				minor, req);
+		nbd_qsys_enq_tail(&lo->tx_queue, req);
+		continue;
+
+fail_request:
+		/*
+		 * Fail the request: anyone waiting on a read or write gets
+		 * an error and can move on to their close() call.
+		 */
+		req->errors++;
+		request_end_while_locked(req, 0);
+	}
+	requests_in += nreqs;
+	dprintk(NBD_DEBUG_BLKDEV, DEVICE_NAME ": %s(%p) returning\n",
+			__FUNCTION__, q);
+	return;
+}
+
+static void bd_set_size(struct block_device *bdev, loff_t size, int block_size)
+{
+#if 0
+	atomic_inc(&bdev->bd_count);
+	bdev->bd_openers++;
+#endif
+	// XXX need to roll this in with media-change handling!
+	if (bdev->bd_inode->i_size != size) {
+		dprintk(NBD_DEBUG_OPEN, DEVICE_NAME
+				": %s: i_size was %llu, changing to %llu\n",
+				__FUNCTION__, bdev->bd_inode->i_size, size);
+		bdev->bd_inode->i_size = size;
+	}
+	if (bdev->bd_block_size != block_size) {
+		dprintk(NBD_DEBUG_OPEN, DEVICE_NAME
+				": %s: block size was %u, changing to %u\n",
+				__FUNCTION__, bdev->bd_block_size, block_size);
+		bdev->bd_block_size = block_size;
+	}
+	if (bdev->bd_inode->i_blkbits != blksize_bits(block_size)) {
+		dprintk(NBD_DEBUG_OPEN, DEVICE_NAME
+				": %s: blkbits was %u, changing to %u\n",
+				__FUNCTION__, bdev->bd_inode->i_blkbits,
+				blksize_bits(block_size));
+		bdev->bd_inode->i_blkbits = blksize_bits(block_size);
+	}
+}
+
+static int nbd_open(struct inode *inode, struct file *file)
+{
+	nbd_device_t *lo;
+	int minor, rv, running;
+
+	if (!inode)
+		return -EINVAL;
+	lo = INODE_TO_NBD(inode);
+	minor = DEVICE_TO_MINOR(lo);
+	if (minor >= MAX_NBD)
+		return -ENODEV;
+#ifdef PARANOIA
+	BUG_ON(lo->magic != LO_MAGIC);
+	BUG_ON(file == NULL);
+#endif
+
+	rv = 0;
+	down(&lo->semalock);
+	if ((file->f_mode & FMODE_WRITE) && nbd_read_only(lo)) {
+		rv = -EROFS;
+		goto leave;
+	}
+	if ((file->f_flags & O_EXCL) && (atomic_read(&lo->refcnt) > 0)) {
+		rv = -EBUSY;
+		goto leave;
+	}
+	if (file->f_flags & O_NDELAY) {
+		dprintk(NBD_DEBUG_OPEN,
+			"nb%d: %s[%d] called %s(%p,%p(no-delay)).\n",
+			minor, current->comm, current->pid,
+			__FUNCTION__, inode, file);
+		atomic_inc(&lo->refcnt);
+		goto leave;
+	}
+	dprintk(NBD_DEBUG_OPEN, "nb%d: %s[%d] called %s(%p,%p).\n",
+			minor, current->comm, current->pid,
+			__FUNCTION__, inode, file);
+
+	/*
+	 * As much as possible, keep requests from queuing if not ready.
+	 * We accomplish that by returning ENOMEDIUM when we're not ready
+	 * and we can't be made ready...
+	 */
+	running = 0;
+	spin_lock(&lo->lock);
+	if (lo->tx_thread.task)
+		running = 1;
+	spin_unlock(&lo->lock);
+	if (running) {
+		dprintk(NBD_DEBUG_OPEN, "nb%d: %s: ready, refcnt=%d.\n",
+				minor, __FUNCTION__, atomic_read(&lo->refcnt));
+		atomic_inc(&lo->refcnt);
+		goto leave;
+	}
+	dprintk(NBD_DEBUG_OPEN, "nb%d: %s: not ready.\n",
+			minor, __FUNCTION__);
+	if (lo->sin.sin_addr.s_addr) {
+		if (lo->sock) {
+			dprintk(NBD_DEBUG_OPEN,
+				"nb%d: %s: terminating old connection\n",
+				minor, __FUNCTION__);
+			/*
+			 * Connection died. Remote host or network is
+			 * down. Make sure it's complete...
+			 */
+			nbd_shutdown(lo);
+		}
+		if (lo->flags & NBD_RESTARTABLE)
+			rv = nbd_thread_start(lo, &lo->ss_thread, session_loop);
+		else
+			rv = nbd_startup(lo);
+		if (rv < 0 && (lo->flags & NBD_NONBLOCKING))
+			goto leave;
+		rv = 0;
+		atomic_inc(&lo->refcnt);
+		goto leave;
+	}
+	if (lo->flags & NBD_NONBLOCKING)
+		rv = -ENOMEDIUM;
+	else
+		atomic_inc(&lo->refcnt);
+leave:
+	up(&lo->semalock);
+	if (rv == 0) {
+		bd_set_size(inode->i_bdev, get_capacity(lo->disk) << 9,
+				NBD_BLKSIZE(lo));
+	}
+	dprintk(NBD_DEBUG_OPEN, "nb%d: %s: returning %d.\n",
+			minor, __FUNCTION__, rv);
+	return rv;
+}
+
+static int nbd_release(struct inode *inode, struct file *file)
+{
+	nbd_device_t *lo;
+	int minor, refcnt;
+
+	if (!inode)
+		return -ENODEV;
+	lo = INODE_TO_NBD(inode);
+	minor = DEVICE_TO_MINOR(lo);
+	if (minor >= MAX_NBD)
+		return -ENODEV;
+	dprintk(NBD_DEBUG_RELEASE, "nb%d: %s[%d] called %s(%p,%p)\n",
+		minor, current->comm, current->pid,
+		__FUNCTION__, inode, file);
+
+	down(&lo->semalock);
+	refcnt = atomic_read(&lo->refcnt);
+	if (refcnt <= 0)
+		printk(KERN_ALERT "nb%d: %s: refcount(%d) <= 0\n",
+				minor, __FUNCTION__, refcnt);
+	if (refcnt == 1 && lo->sin.sin_addr.s_addr && lo->sock) {
+		int running = 0;
+		spin_lock(&lo->lock);
+		if (lo->ss_thread.task)
+			running = 1;
+		spin_unlock(&lo->lock);
+		if (!running) {
+			dprintk(NBD_DEBUG_RELEASE,
+				"nb%d: last holder: rxlen %d, txlen %d.\n",
+				minor,
+				nbd_qsys_len(&lo->rx_queue),
+				nbd_qsys_len(&lo->tx_queue));
+			BUG_ON(nbd_qsys_len(&lo->rx_queue) != 0);
+			BUG_ON(nbd_qsys_len(&lo->tx_queue) != 0);
+			nbd_shutdown(lo);
+		}
+	}
+	else if (atomic_dec_and_test(&lo->refcnt)) {
+		if (lo->flags & NBD_CLEARED) {
+			lo->flags &= ~NBD_NONBLOCKING;
+			lo->flags &= ~NBD_CLEARED;
+		}
+	}
+	up(&lo->semalock);
+	dprintk(NBD_DEBUG_RELEASE, "nb%d: %s returning (refcnt %d)\n", 
+		minor, __FUNCTION__, atomic_read(&lo->refcnt));
+	return 0;
+}
+
+/**
+ * nbd_set_size64 - sets byte size of nbd device
+ * @lo: pointer to nbd device
+ * @size: size of device in bytes
+ *
+ * Only call when lo inactive (ie. when rx/tx threads not running).
+ */
+static void nbd_set_size64(nbd_device_t *lo, u64 size)
+{
+	u64 oldsize;
+	oldsize = lo->bytesize;
+	size = size & ~(lo->blksize - 1);
+	lo->bytesize = size;
+	set_capacity(lo->disk, size >> 9);
+	dprintk(NBD_DEBUG_IOCTL, "nb%d: %s: size now %llu\n",
+			DEVICE_TO_MINOR(lo), __FUNCTION__, size);
+}
+
+static int nbd_set_blksize(nbd_device_t *lo, unsigned long arg)
+{
+	int rv;
+
+	// XXX ldl: maybe we'd be better off calling block_dev.c
+	//   set_blocksize(dev, arg) as this would also handle
+	//   any block buffers: return set_blocksize(dev, arg);
+	if ((arg & (arg - 1)) || (arg < 512) || (arg > PAGE_SIZE))
+		return -EINVAL;
+
+	rv = 0;
+	spin_lock(&lo->lock);
+	if (lo->rx_thread.task || lo->tx_thread.task) {
+		rv = -EBUSY;
+		goto unlock;
+	}
+
+	lo->blksize = arg;
+	lo->bytesize &= ~(lo->blksize - 1);
+	set_capacity(lo->disk, lo->bytesize >> 9);
+
+unlock:
+	spin_unlock(&lo->lock);
+	return rv;
+}
+
+static int nbd_set_size(nbd_device_t *lo, unsigned long arg)
+{
+	int rv;
+
+	rv = 0;
+	spin_lock(&lo->lock);
+	if (lo->rx_thread.task || lo->tx_thread.task) {
+		rv = -EBUSY;
+		goto unlock;
+	}
+	nbd_set_size64(lo, arg);
+unlock:
+	spin_unlock(&lo->lock);
+	return rv;
+}
+
+static int nbd_set_size_blocks(nbd_device_t *lo, unsigned long arg)
+{
+	int rv;
+
+	rv = 0;
+	spin_lock(&lo->lock);
+	if (lo->rx_thread.task || lo->tx_thread.task) {
+		rv = -EBUSY;
+		goto unlock;
+	}
+	nbd_set_size64(lo, ((u64)arg) * NBD_BLKSIZE(lo));
+unlock:
+	spin_unlock(&lo->lock);
+	return rv;
+}
+
+static int nbd_print_debug(nbd_device_t *lo)
+{
+	printk(KERN_INFO "nb%d:", DEVICE_TO_MINOR(lo));
+	printk(" refcnt=%d", atomic_read(&lo->refcnt));
+	printk(" flags=0x%x", lo->flags);
+	printk(" harderror=%d", lo->harderror);
+	printk(" q-loops=%llu", qhandler_loops);
+	printk(" reqsin=%llu", requests_in);
+	printk(" reqsout=%llu", requests_out);
+	printk(" rx=%p(%d)", lo->rx_thread.task, lo->rx_queue.len);
+	printk(" tx=%p(%d)", lo->tx_thread.task, lo->tx_queue.len);
+	printk(" ss=%p", lo->ss_thread.task);
+	printk("\n");
+	return 0;
+}
+
+#ifndef NDEBUG
+static const char *ioctl_cmd_to_ascii(int cmd)
+{
+	switch (cmd) {
+	case NBD_SET_SOCK: return "set-sock";
+	case NBD_SET_BLKSIZE: return "set-blksize";
+	case NBD_SET_SIZE: return "set-size";
+	case NBD_DO_IT: return "do-it";
+	case NBD_CLEAR_SOCK: return "clear-sock";
+	case NBD_CLEAR_QUE: return "clear-que";
+	case NBD_PRINT_DEBUG: return "print-debug";
+	case NBD_SET_SIZE_BLOCKS: return "set-size-blocks";
+	case NBD_DISCONNECT: return "disconnect";
+	case NBD_GET_SIN: return "get-sin";
+	case NBD_SET_SIN: return "set-sin";
+	case NBD_CLR_SIN: return "clear-sin";
+	case NBD_SET_FLAGS: return "set-flags";
+	case NBD_GET_FLAGS: return "get-flags";
+	case BLKROSET: return "set-read-only";
+	case BLKROGET: return "get-read-only";
+	case BLKGETSIZE: return "block-get-size";
+	case BLKFLSBUF: return "flush-buffer-cache";
+	}
+	return "unknown";
+}
+#endif /* NDEBUG */
+
+static int nbd_ioctl(struct inode *inode, struct file *file,
+		     unsigned int cmd, unsigned long arg)
+{
+	nbd_device_t *lo;
+	int minor, rv;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	if (!inode)
+		return -EINVAL;
+	lo = inode->i_bdev->bd_disk->private_data;
+	minor = DEVICE_TO_MINOR(lo);
+	if (minor >= MAX_NBD)
+		return -ENODEV;
+	dprintk(NBD_DEBUG_IOCTL,
+			"nb%d: %s[%d] called %s: cmd=%s(0x%x) arg=%lu.\n",
+			minor, current->comm, current->pid, __FUNCTION__,
+			ioctl_cmd_to_ascii(cmd), cmd, arg);
+
+	/*
+	 * Handled outside normal ioctl handling since it
+	 * needs to play with semalock differently...
+	 */
+	switch (cmd) {
+	case NBD_DO_IT:
+		return nbd_do_it(lo);
+	case NBD_DISCONNECT:
+                return nbd_disconnect(lo);
+	}
+
+	rv = 0;
+	down(&lo->semalock);
+	switch (cmd) {
+	case NBD_SET_SIN:
+		{
+			struct sockaddr_in sin;
+			rv = copy_from_user(&sin, (void *)arg, sizeof(sin))?
+				-EFAULT: nbd_set_sin(lo, &sin);
+		}
+		break;
+	case NBD_GET_SIN:
+		rv = copy_to_user((void *)arg, &lo->sin, sizeof(lo->sin))?
+			-EFAULT: 0;
+		break;
+	case NBD_CLR_SIN:
+		rv = nbd_clr_sin(lo);
+		break;
+	case NBD_CLEAR_QUE:
+		rv = nbd_clear_queue(lo);
+		break;
+	case NBD_PRINT_DEBUG:
+		rv = nbd_print_debug(lo);
+		break;
+	case NBD_SET_SOCK:
+		rv = nbd_set_sock(lo, arg);
+		break;
+	case NBD_CLEAR_SOCK:
+		rv = nbd_clear_sock(lo);
+		break;
+	case NBD_SET_BLKSIZE:
+		rv = nbd_set_blksize(lo, arg);
+		break;
+	case NBD_SET_SIZE:
+		rv = nbd_set_size(lo, arg);
+		break;
+	case NBD_SET_SIZE_BLOCKS:
+		rv = nbd_set_size_blocks(lo, arg);
+		break;
+	case NBD_SET_FLAGS:
+		arg &= ~NBD_CLEARED; /* not valid user flag */
+		if ((lo->flags & NBD_READ_ONLY) != (arg & NBD_READ_ONLY))
+			set_disk_ro(lo->disk, (arg & NBD_READ_ONLY)? 1: 0);
+		lo->flags = (unsigned int)arg;
+		break;
+	case NBD_GET_FLAGS:
+		rv = put_user(lo->flags, (unsigned int *)arg);
+		break;
+	case BLKROSET:
+		if (arg)
+			lo->flags |= NBD_READ_ONLY;
+		else
+			lo->flags &= ~NBD_READ_ONLY;
+		set_disk_ro(lo->disk, arg);
+		break;
+	default:
+		rv = -EINVAL;
+		dprintk(NBD_DEBUG_IOCTL,
+			"nb%d: %s: no handler for 0x%x ioctl.\n",
+			minor, __FUNCTION__, cmd);
+		break;
+	}
+	up(&lo->semalock);
+	return rv;
+}
+
+static struct block_device_operations nbd_fops =
+{
+	owner:			THIS_MODULE,
+	open:			nbd_open,
+	release:		nbd_release,
+	ioctl:			nbd_ioctl,
+};
+
+#ifdef CONFIG_PROC_FS
+static const char *strerror(int err)
+{
+	switch (err) {
+	case 0:
+		return "OK";
+	case EIO:
+		return "I/O error";
+	case ENOTCONN:
+		return "Not connected";
+	case ECONNRESET:
+		return "Connection reset by peer";
+	case ETIMEDOUT:
+		return "Connection timed out";
+	case ENETUNREACH:
+		return "Network is unreachable";
+	case EINTR:
+		return "Interupted";
+	case ENOMEM:
+		return "Out of memory";
+	case ENOBUFS:
+		return "Queue full";
+	case ECONNREFUSED:
+		return "Remote host refused connection";
+	case EPROTO:
+		return "Protocol error";
+	case ESRCH:
+		return "Unmatched reply packet";
+	case ENOMEDIUM:
+		return "No medium found";
+	}
+	return "error";
+}
+
+#ifndef NDEBUG
+static int nbd_debug_read_proc(char *page, char **start, off_t offset,
+		                        int count, int *eof, void *data)
+{
+	int sz = 0;
+
+	*eof = 1;
+	sz += sprintf(page + sz, "%x\n", debugflags);
+	return sz;
+}
+
+static int nbd_debug_write_proc(struct file *file, const char *buffer,
+		unsigned long count, void *data)
+{
+	unsigned int newflags;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+	if (sscanf(buffer, "%x", &newflags) != 1)
+		return -EINVAL;
+	printk(KERN_INFO DEVICE_NAME ": changing debugflags to 0x%x\n",
+			newflags);
+	debugflags = newflags;
+	return count;
+}
+#endif
+
+static int nbd_totals_read_proc(char *page, char **start, off_t offset,
+		                        int count, int *eof, void *data)
+{
+	int sz = 0;
+
+	*eof = 1;
+	sz += sprintf(page + sz, " Requests in: %llu\n", requests_in);
+	sz += sprintf(page + sz, "Requests out: %llu\n", requests_out);
+	sz += sprintf(page + sz, " Queue loops: %llu\n", qhandler_loops);
+	return sz;
+}
+
+static int nbd_device_read_proc(char *page, char **start, off_t offset,
+		                        int count, int *eof, void *data)
+{
+	nbd_device_t *lo = (nbd_device_t *)data;
+	int sz, n;
+	struct socket *sock;
+	struct file *file;
+	struct sockaddr_in sin;
+	pid_t rxpid, txpid, sspid;
+
+	/* Careful! Buffer "page" is just that - a 1 page sized buffer! */
+	sz = 0;
+	*eof = 1;
+
+	sz += sprintf(page + sz, "Reference count: %d\n",
+			atomic_read(&lo->refcnt));
+	sz += sprintf(page + sz, "   Device flags: 0x%X\n", lo->flags);
+	sz += sprintf(page + sz, " Network status: %s (%d)\n",
+			strerror(lo->lasterr), lo->lasterr);
+	sz += sprintf(page + sz, "    Disk status: %s (%d)\n",
+			strerror(lo->harderror), lo->harderror);
+	sz += sprintf(page + sz, "Device size (B): %llu\n", NBD_BYTESIZE(lo));
+	sz += sprintf(page + sz, " Block size (B): %d\n", NBD_BLKSIZE(lo));
+	sz += sprintf(page + sz, "Rx queue length: %u\n", lo->rx_queue.len);
+	sz += sprintf(page + sz, "Tx queue length: %u\n", lo->tx_queue.len);
+	sock = lo->sock;
+	if (sock) {
+		struct proto_ops *ops = sock->ops;
+		n = sizeof(sin);
+		sz += sprintf(page + sz, " Socket pointer: %p", lo->sock);
+		if (ops && ops->getname(sock, (struct sockaddr *)&sin, &n, 1)
+				== 0)
+			sz += sprintf(page + sz, " (0x%x:%d)",
+					ntohl(sin.sin_addr.s_addr),
+					ntohs(sin.sin_port));
+		sz += sprintf(page + sz, "\n");
+	}
+	memcpy(&sin, &lo->sin, sizeof(sin));
+	if (sin.sin_addr.s_addr)
+		sz += sprintf(page + sz, " Remote address: 0x%x:%d\n",
+			ntohl(sin.sin_addr.s_addr), ntohs(sin.sin_port));
+	file = lo->file;
+	if (file)
+		sz += sprintf(page + sz, "   File pointer: %p\n", file);
+
+	spin_lock(&lo->lock);
+	sspid = (lo->ss_thread.task)? lo->ss_thread.task->pid: 0;
+	rxpid = (lo->rx_thread.task)? lo->rx_thread.task->pid: 0;
+	txpid = (lo->tx_thread.task)? lo->tx_thread.task->pid: 0;
+	spin_unlock(&lo->lock);
+
+	if (sspid)
+		sz += sprintf(page + sz, "Ses. thread PID: %d\n", sspid);
+	if (rxpid)
+		sz += sprintf(page + sz, "  Rx thread PID: %d\n", rxpid);
+	if (txpid)
+		sz += sprintf(page + sz, "  Tx thread PID: %d\n", txpid);
+	n = atomic_read(&lo->num_io_threads);
+	if (n)
+		sz += sprintf(page + sz, "  # I/O Threads: %d\n", n);
+	return sz;
+}
+
+#ifndef NDEBUG
+static struct proc_dir_entry *proc_array;
+static struct proc_dir_entry *proc_debug = NULL;
+
+static void __init mk_debug_proc_entry(void)
+{
+	proc_debug = create_proc_entry("debugflags", S_IFREG|S_IRUSR|S_IWUSR,
+			proc_array);
+	if (!proc_debug)
+		return;
+	proc_debug->nlink = 1;
+	proc_debug->data = NULL;
+	proc_debug->read_proc = nbd_debug_read_proc;
+	proc_debug->write_proc = nbd_debug_write_proc;
+}
+
+static void __exit rm_debug_proc_entry(void)
+{
+	if (proc_debug)
+		remove_proc_entry("debugflags", proc_debug);
+}
+#endif /* NDEBUG */
+
+static void __init init_proc_fs(void)
+{
+	int i;
+	char devname[16];
+
+	if (!proc_array) {
+		proc_array = proc_mkdir(DEVICE_NAME, proc_root_driver);
+		if (!proc_array)
+			return;
+	}
+	create_proc_read_entry("totals", 0, proc_array,
+			nbd_totals_read_proc, NULL);
+#ifndef NDEBUG
+	mk_debug_proc_entry();
+#endif
+	for (i = 0; i < MAX_NBD; i++) {
+		sprintf(devname, "%d", i);
+		create_proc_read_entry(devname, 0, proc_array,
+				nbd_device_read_proc, nbd_devs + i);
+	}
+}
+
+static void __exit exit_proc_fs(void)
+{
+	int i;
+	char devname[16];
+
+	for (i = 0; i < MAX_NBD; i++) {
+		sprintf(devname, "%d", i);
+		remove_proc_entry(devname, proc_array);
+	}
+#ifndef NDEBUG
+	rm_debug_proc_entry();
+#endif
+	remove_proc_entry("totals", proc_array);
+	remove_proc_entry(DEVICE_NAME, proc_root_driver);
+}
+#endif
+
+/*
+ * And here should be modules and kernel interface 
+ *  (Just smiley confuses emacs :-)
+ */
+
+static struct gendisk *nbd_alloc_disk(nbd_device_t *dev)
+{
+	struct gendisk *disk = alloc_disk(1);
+	if (disk) {
+		int minor = DEVICE_TO_MINOR(dev);
+		disk->major = NBD_MAJOR;
+		disk->first_minor = minor;
+		disk->fops = &nbd_fops;
+		disk->private_data = dev;
+		disk->queue = &nbd_queue[minor];
+		sprintf(disk->disk_name, "%s%d", DEVICE_NAME, minor);
+		sprintf(disk->devfs_name, "%s/%d", DEVICE_NAME, minor);
+		set_capacity(disk, dev->bytesize >> 9);
+	}
+	return disk;
+}
+
+static void __init init_nbd_dev(nbd_device_t *dev)
+{
+#ifdef PARANOIA
+	dev->magic = LO_MAGIC;
+#endif
+	atomic_set(&dev->refcnt, 0);
+	dev->flags = 0;
+	spin_lock_init(&dev->lock);
+	dev->harderror = 0;
+	nbd_qsys_init(&dev->tx_queue);
+	nbd_qsys_init(&dev->rx_queue);
+	dev->file = NULL;
+	dev->sock = NULL;
+	memset(&dev->sin, 0, sizeof(dev->sin));
+	dev->errcnt = 0;
+	dev->lasterr = ENOTCONN;
+	dev->closed = (RCV_SHUTDOWN|SEND_SHUTDOWN);
+	dev->ss_thread.task = NULL;
+	dev->tx_thread.task = NULL;
+	dev->rx_thread.task = NULL;
+	atomic_set(&dev->num_io_threads, 0);
+	init_waitqueue_head(&dev->no_io_waiters);
+	init_MUTEX(&dev->semalock);
+	dev->blksize = 1 << initial_blksize_bits;
+	dev->bytesize = initial_bytesize;
+	dev->disk = nbd_alloc_disk(dev);
+	if (dev->disk)
+		add_disk(dev->disk);
+}
+
+static inline void parse_sin(char *str, struct sockaddr_in *sin)
+{
+	char *s = str;
+	u16 port = default_port;
+
+	/* parse format like: "10.0.0.5[:30666]" */
+	while (*s && *s != ':')
+		s++;
+	if (*s == ':') {
+		*s++ = '\0';
+		sscanf(s, "%hu", &port);
+	}
+	sin->sin_family = PF_INET;
+	sin->sin_port = htons(port);
+	sin->sin_addr.s_addr = in_aton(str);
+}
+
+static void __init parse_connects(void)
+{
+	int i, maxi;
+
+	maxi = sizeof(connects)/sizeof(char *);
+	for (i = 0; i < maxi && connects[i]; i++) {
+		struct sockaddr_in sin;
+		int result;
+		nbd_device_t *lo = nbd_devs + i;
+
+		dprintk(NBD_DEBUG_INIT, DEVICE_NAME ": connects[%d]=\"%s\"\n",
+				i, connects[i]);
+		parse_sin(connects[i], &sin);
+		result = nbd_set_sin(lo, &sin);
+		if (result < 0)
+			printk(KERN_ERR "nb%d: bad connect \"%s\" (%d)\n",
+					i, connects[i], result);
+		else {
+			lo->flags |= NBD_RESTARTABLE;
+			result = nbd_thread_start(lo, &lo->ss_thread,
+					session_loop);
+			if (result < 0)
+				printk(KERN_ERR "nb%d: can't start session manager (%d)\n",
+						i, result);
+		}
+	}
+}
+
+static void __init parse_initial_size(void)
+{
+	if (!initial_size)
+		return;
+	dprintk(NBD_DEBUG_INIT, DEVICE_NAME ": initial_size=\"%s\"\n",
+			initial_size);
+	sscanf(initial_size, "%Lu", &initial_bytesize);
+}
+
+int __init nbd_init(void)
+{
+	int i;
+
+	if (sizeof(nbd_request_t) != 28) {
+		printk(KERN_CRIT DEVICE_NAME ": Size of nbd_request must be 28 bytes to work!\n");
+		return -EIO;
+	}
+	if (sizeof(nbd_reply_t) != 16) {
+		printk(KERN_CRIT DEVICE_NAME ": Size of nbd_reply must be 16 bytes to work!\n");
+		return -EIO;
+	}
+
+	if (register_blkdev(MAJOR_NR, DEVICE_NAME)) {
+		printk(DEVICE_NAME ": Unable to get major number %d.\n", MAJOR_NR);
+		return -EIO;
+	}
+	requests_in = 0;
+	requests_out = 0;
+	qhandler_loops = 0;
+
+	request_magic = htonl(NBD_REQUEST_MAGIC);
+	reply_magic = htonl(NBD_REPLY_MAGIC);
+	parse_initial_size();
+
+	printk(KERN_INFO DEVICE_NAME ": registered at major %d\n", MAJOR_NR);
+	dprintk(NBD_DEBUG_INIT, DEVICE_NAME ": debugflags=0x%x.\n",
+			debugflags);
+	dprintk(NBD_DEBUG_INIT, DEVICE_NAME ": default_port=%d.\n",
+			default_port);
+	dprintk(NBD_DEBUG_INIT, DEVICE_NAME ": initial_size=%llu.\n",
+			initial_bytesize);
+	dprintk(NBD_DEBUG_INIT, DEVICE_NAME ": initial_blksize_bits=%d.\n",
+			initial_blksize_bits);
+	for (i = 0; i < MAX_NBD; i++) {
+		nbd_lock[i] = SPIN_LOCK_UNLOCKED;
+		blk_init_queue(&nbd_queue[i], do_nbd_request, &nbd_lock[i]);
+	}
+	devfs_mk_dir(DEVICE_NAME);
+	for (i = 0; i < MAX_NBD; i++) {
+		init_nbd_dev(nbd_devs + i);
+	}
+	if (connects[0])
+		parse_connects();
+
+#ifdef CONFIG_PROC_FS
+	init_proc_fs();
+#endif
+	return 0;
+}
+
+static void __exit dprintk_disk(int minor, char *msg, struct gendisk *disk)
+{
+	dprintk(NBD_DEBUG_EXIT,
+			"nb%d: %s %p: %d %d-%d ref#=%d q=%p q.e.ref#=%d\n",
+			minor, msg, disk, disk->major, disk->first_minor,
+			disk->first_minor + disk->minors - 1,
+			atomic_read(&disk->kobj.refcount), disk->queue,
+			atomic_read(&disk->queue->elevator.kobj.refcount));
+}
+
+static void __exit nbd_exit(void)
+{
+	int i;
+
+	dprintk(NBD_DEBUG_EXIT, DEVICE_NAME ": %s called.\n", __FUNCTION__);
+
+	for (i = 0; i < MAX_NBD; i++) {
+		if (nbd_devs[i].sin.sin_addr.s_addr)
+			nbd_clr_sin(nbd_devs + i);
+		else if (nbd_devs[i].file && nbd_devs[i].sock) {
+			nbd_disconnect(nbd_devs + i);
+			nbd_clear_sock(nbd_devs + i);
+		}
+	}
+#ifdef CONFIG_PROC_FS
+	exit_proc_fs();
+#endif
+	{
+		int minor;
+		struct gendisk *disk;
+		for (minor = 0; minor < MAX_NBD; minor++) {
+			disk = nbd_devs[minor].disk;
+			if (disk) {
+				dprintk_disk(minor, "...del_gendisk", disk);
+				del_gendisk(disk);
+				dprintk_disk(minor, "...put_disk", disk);
+				put_disk(disk);
+			}
+			blk_cleanup_queue(&nbd_queue[minor]);
+		}
+	}
+	devfs_remove(DEVICE_NAME);
+	if (unregister_blkdev(MAJOR_NR, DEVICE_NAME) != 0)
+		printk(KERN_ERR DEVICE_NAME ": module cleanup failed!\n");
+	else
+		printk(KERN_INFO DEVICE_NAME ": module exiting.\n");
+}
+
+module_init(nbd_init);
+module_exit(nbd_exit);
+
+/*
+ * XXX Should the module author refer to the last developer to release
+ *   this code, or the very first developer?
+ *   This driver is very much a derivative of previous work by:
+ *      Pavel Machek <pavel@atrey.karlin.mff.cuni.cz>.
+ */
+MODULE_AUTHOR("Louis D. Langholtz");
+
+MODULE_DESCRIPTION("Network Block Device");
+MODULE_LICENSE("GPL");
+MODULE_PARM(default_port, "i");
+MODULE_PARM_DESC(default_port, "default " DEVICE_NAME " service port number");
+MODULE_PARM(initial_size, "s");
+MODULE_PARM_DESC(initial_size, "initial byte size of " DEVICE_NAME " devices");
+MODULE_PARM(initial_blksize_bits, "i");
+MODULE_PARM_DESC(initial_blksize_bits, "initial block size in bits (9-12)");
+MODULE_PARM(connects, "1-64s");
+#ifndef NDEBUG
+MODULE_PARM(debugflags, "i");
+MODULE_PARM_DESC(debugflags, "flags for controlling debugging output");
+#endif
diff -urN linux-2.5.72/include/linux/nbd.h linux-2.5.72-new/include/linux/nbd.h
--- linux-2.5.72/include/linux/nbd.h	2003-06-16 22:20:23.000000000 -0600
+++ linux-2.5.72-new/include/linux/nbd.h	2003-06-20 21:28:10.209232024 -0600
@@ -5,82 +5,233 @@
  * 2001 Copyright (C) Steven Whitehouse
  *            New nbd_end_request() for compatibility with new linux block
  *            layer code.
+ * 2003 Copyright (C) Louis D. Langholtz ldl@aros.net
+ *            Moved nbd_end_request like code to nbd.c, added structure
+ *            type definitions, changed device structure to accomadate
+ *            changes made to nbd.c (see nbd.c for more details).
  */
 
 #ifndef LINUX_NBD_H
 #define LINUX_NBD_H
 
-#define NBD_SET_SOCK	_IO( 0xab, 0 )
-#define NBD_SET_BLKSIZE	_IO( 0xab, 1 )
-#define NBD_SET_SIZE	_IO( 0xab, 2 )
-#define NBD_DO_IT	_IO( 0xab, 3 )
-#define NBD_CLEAR_SOCK	_IO( 0xab, 4 )
-#define NBD_CLEAR_QUE	_IO( 0xab, 5 )
-#define NBD_PRINT_DEBUG	_IO( 0xab, 6 )
-#define NBD_SET_SIZE_BLOCKS	_IO( 0xab, 7 )
-#define NBD_DISCONNECT  _IO( 0xab, 8 )
-
-enum {
-	NBD_CMD_READ = 0,
-	NBD_CMD_WRITE = 1,
-	NBD_CMD_DISC = 2
-};
-
+/*
+ * Everything up till we check if MAJOR_NR is defined, is needed
+ * for kernel (driver) as well as user space tools.
+ */
 
-#ifdef PARANOIA
-extern int requests_in;
-extern int requests_out;
+#include <asm/byteorder.h>
+                                                                                
+#if !defined(__BYTE_ORDER)
+#  if defined(__LITTLE_ENDIAN) && !defined(__BIG_ENDIAN)
+#    define __BYTE_ORDER __LITTLE_ENDIAN
+#  else
+#    if defined(__BIG_ENDIAN) && !defined(__LITTLE_ENDIAN)
+#      define __BYTE_ORDER __BIG_ENDIAN
+#    else
+#      error Need to know __BYTE_ORDER!
+#    endif
+#  endif
 #endif
 
-#define nbd_cmd(req) ((req)->cmd[0])
+#if __BYTE_ORDER == __BIG_ENDIAN
+#  define ntohll(x) (x)
+#  define htonll(x) (x)
+#else
+#  if __BYTE_ORDER == __LITTLE_ENDIAN
+#    define ntohll(x) __constant_be64_to_cpu(x)
+#    define htonll(x) __constant_cpu_to_be64(x)
+#  else
+#    error Need to know __BYTE_ORDER!
+#  endif
+#endif
 
-#define MAX_NBD 128
+/* Define available ioctl requests... */
+#define NBD_SET_SOCK		_IO( 0xab, 0 )
+#define NBD_SET_BLKSIZE		_IO( 0xab, 1 )
+#define NBD_SET_SIZE		_IO( 0xab, 2 )
+#define NBD_DO_IT		_IO( 0xab, 3 )
+#define NBD_CLEAR_SOCK		_IO( 0xab, 4 )
+#define NBD_CLEAR_QUE		_IO( 0xab, 5 )
+#define NBD_PRINT_DEBUG		_IO( 0xab, 6 )
+#define NBD_SET_SIZE_BLOCKS	_IO( 0xab, 7 )
+#define NBD_DISCONNECT		_IO( 0xab, 8 )
+#define NBD_SET_SIN		_IO( 0xab, 9 )
+#define NBD_CLR_SIN		_IO( 0xab, 10 )
+#define NBD_GET_SIN		_IO( 0xab, 11 )
+#define NBD_SET_FLAGS		_IO( 0xab, 12 )
+#define NBD_GET_FLAGS		_IO( 0xab, 13 )
 
-struct nbd_device {
-	int refcnt;	
-	int flags;
-	int harderror;		/* Code of hard error			*/
-#define NBD_READ_ONLY 0x0001
-#define NBD_WRITE_NOCHK 0x0002
-	struct socket * sock;
-	struct file * file; 	/* If == NULL, device is not ready, yet	*/
-	int magic;		/* FIXME: not if debugging is off	*/
-	spinlock_t queue_lock;
-	struct list_head queue_head;/* Requests are added here...	*/
-	struct semaphore tx_lock;
-	struct gendisk *disk;
-	int blksize;
-	int blksize_bits;
-	u64 bytesize;
-};
+/*
+ * Define protocol data types, structures, and values for initial
+ * client/server handshake...
+ */
 
-/* This now IS in some kind of include file...	*/
+#define NBD_DEFAULT_PORT 30666
+#define NBD_INIT_PASSWD  "NBDMAGIC"
 
-/* These are send over network in request/reply magic field */
+/* defined as an array so no need for byte swapping (ever) */
+#define NBD_PROTOMAGIC { 0x00, 0x00, 0x42, 0x02, 0x81, 0x86, 0x12, 0x53 }
+typedef struct nbd_protomagic { unsigned char bytes[8]; } nbd_protomagic_t
+#ifdef __GNUC__
+        __attribute__ ((packed))
+#endif
+;
 
-#define NBD_REQUEST_MAGIC 0x25609513
-#define NBD_REPLY_MAGIC 0x67446698
-/* Do *not* use magics: 0x12560953 0x96744668. */
+typedef struct nbd_svr_info {
+	char initpwd[8];	/* Always "NBDMAGIC" */
+	unsigned char magic[8];	/* Protocol magic (NBD_PROTOMAGIC) */
+	uint64_t size;		/* Size in bytes of server storage */
+	unsigned char zeros[128];
+} nbd_svr_info_t
+#ifdef __GNUC__
+	__attribute__ ((packed))
+#endif
+;
 
 /*
- * This is packet used for communication between client and
- * server. All data are in network byte order.
+ * Define protocol data types, structures, and values for servicing
+ * block requests...
  */
+
+/* Do *not* use magics: 0x12560953 0x96744668. */
+#define NBD_REQUEST_MAGIC 0x25609513
+#define NBD_REPLY_MAGIC   0x67446698
+
 struct nbd_request {
-	u32 magic;
-	u32 type;	/* == READ || == WRITE 	*/
-	char handle[8];
-	u64 from;
-	u32 len;
+	uint32_t magic; /* NBD_REQUEST_MAGIC */
+	uint32_t type;	/* == READ || == WRITE */
+	char handle[8];	/* address of request for 32 or 64 bit arches */
+	uint64_t from;	/* in NBO */
+	uint32_t len;	/* in NBO */
 }
 #ifdef __GNUC__
 	__attribute__ ((packed))
 #endif
 ;
+typedef struct nbd_request nbd_request_t;
 
 struct nbd_reply {
-	u32 magic;
-	u32 error;		/* 0 = ok, else error	*/
+	uint32_t magic;
+	uint32_t error;		/* 0 = ok, else error	*/
 	char handle[8];		/* handle you got from request	*/
-};
+}
+#ifdef __GNUC__
+	__attribute__ ((packed))
 #endif
+;
+typedef struct nbd_reply nbd_reply_t;
+
+/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
+ *
+ * Values for nbd_device flags: set/get with NBD_SET_FLAGS/NBD_GET_FLAGS
+ * ioctl calls. Some of these flags are also manipulated by other system
+ * calls.
+ */
+
+#define NBD_READ_ONLY   0x0001
+
+/*
+ * Set NBD_WRITE_NOCHK when you care more about speed than data integrity.
+ * This flag has been available for some time but only recently was actually
+ * implemented. If you turn it on, the driver will immediately react to any
+ * write requests as though they have been successfully written onto the
+ * server, and will ignore the actual server response code. So if the server
+ * has a disk I/O error, the client won't know it unless it later verifies
+ * what's actually been saved to disk.
+ */
+#define NBD_WRITE_NOCHK 0x0002
+
+#define NBD_RESTARTABLE 0x0004
+
+/*
+ * Set NBD_NONBLOCKING only when you want network errors to be counted as
+ * non-transient errors. By default, this flag is off so that only actual
+ * disk errors are recorded as non-transient errors. When off, the driver
+ * blocks on network failures assuming that something transient - like a
+ * server reboot - is in progress. Root can call the NBD_CLEAR_QUE ioctl
+ * to cause any such blocked I/O operations to immediately fail.
+ */
+#define NBD_NONBLOCKING 0x0008	/* fail requests when disconnected */
+
+/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
+ *
+ * End of definitions shared with user space.
+ * From here on out, these definitions are only for kernel (driver).
+ */
+
+#ifdef MAJOR_NR
+
+#include <linux/in.h>
+#include <asm/semaphore.h>
+
+#define LOCAL_END_REQUEST
+
+#include <linux/blk.h>
+
+#define MAX_NBD 128
+#define NBD_NAME_MAXLEN 128
+#define NBD_MAX_PATHS (MAX_NBD * 2)
+
+typedef struct nbd_device nbd_device_t;
+typedef struct nbd_thread nbd_thread_t;
+typedef struct nbd_qsys nbd_qsys_t;
+
+struct nbd_thread {
+	struct task_struct *task;
+	struct completion startup;
+	struct completion finish;
+};
+		
+struct nbd_qsys {
+	spinlock_t lock;
+	unsigned int len;
+	struct list_head head;
+	wait_queue_head_t waiters;
+};
+
+/*
+ * The nbd_device struct is a block device association with a remote
+ * served block device.
+ */
+struct nbd_device {
+#ifdef PARANOIA
+	unsigned int magic;
+#endif /* PARANOIA */
+	atomic_t refcnt; /* parent rw, child no */
+	unsigned int flags; /* parent rw, child no */
+	spinlock_t lock; /* for atomic access to (rx|tx)_thread.task */
+	int harderror; /* Code of hard error */
+	nbd_qsys_t tx_queue;
+	nbd_qsys_t rx_queue;
+	struct socket *sock; /* parent rw, child r */
+	struct file *file; /* saved from userland via fget() */
+	struct sockaddr_in sin;
+	unsigned int errcnt; /* to count path dependent errors */
+	int lasterr; /* last error for path (not request) */
+	int closed; /* parent rw, child rw */
+	nbd_thread_t ss_thread; /* session thread */
+	nbd_thread_t tx_thread; /* transmit I/O thread */
+	nbd_thread_t rx_thread; /* receive I/O thread */
+	atomic_t num_io_threads; /* count of existing I/O threads (0-2) */
+	wait_queue_head_t no_io_waiters;
+	struct semaphore semalock; /* protect parent level rw access */
+	struct gendisk *disk;
+	int blksize;
+	u64 bytesize;
+};
+
+/* nbd_device flags not settable (nor interpretable) by users */
+#define NBD_CLEARED     0x0010
+
+static inline unsigned long nbd_read_only(nbd_device_t *lo)
+{
+	return lo->flags & NBD_READ_ONLY;
+}
+
+static inline unsigned long nbd_write_nochk(nbd_device_t *lo)
+{
+	return lo->flags & NBD_WRITE_NOCHK;
+}
+
+#endif /* MAJOR_NR */
+#endif /* LINUX_NBD_H */

--------------020103020209000205050901--

