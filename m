Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262244AbSJNWlk>; Mon, 14 Oct 2002 18:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262248AbSJNWlj>; Mon, 14 Oct 2002 18:41:39 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:4069 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262244AbSJNWlb>;
	Mon, 14 Oct 2002 18:41:31 -0400
Message-ID: <3DAB46FD.9010405@watson.ibm.com>
Date: Mon, 14 Oct 2002 18:36:45 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
Cc: Andrew Morton <akpm@digeo.com>, Ben LaHaise <bcrl@redhat.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: [PATCH] async poll for 2.5 
Content-Type: multipart/mixed;
 boundary="------------020507000603030404000607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020507000603030404000607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

As of today, there is no scalable alternative to poll/select in the 2.5
kernel even though the topic has been discussed a number of times
before. The case for a scalable poll has been made often so I won't
get into that.

Attached is a port of the 2.4 async poll code to 2.5.41, written by
David Stevens with assistance from Jay Vosburgh and Mingming Cao (a
port for 2.5.42 is in progress and will be posted shortly). The
patch is a clean port of the 2.4 design and eliminates the use of
worktodos, just as Ben had done through the do_hack() function. The
patch has been tested on 2.5.41 using simple poll tests. A performance
evaluation and further testing is underway.

Even though Ben has indicated, on linux-aio and in OLS, that the 2.4
design doesn't scale well enough, it is a lot better than normal poll.
With the absence of alternatives and the impending feature freeze,
this patch would be one way to ensure that users have at least one
alternative to regular poll.

Ben, are you working on a different async poll implementation that is
likely to be ready by the feature freeze ?

Regards,
Shailabh


--------------020507000603030404000607
Content-Type: text/plain;
 name="aiopoll-2.5.41-5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aiopoll-2.5.41-5.patch"

diff -ruN linux-2.5.41/fs/aio.c linux-2.5.41AIO/fs/aio.c
--- linux-2.5.41/fs/aio.c	Mon Oct  7 11:24:13 2002
+++ linux-2.5.41AIO/fs/aio.c	Mon Oct 14 12:27:05 2002
@@ -59,6 +59,8 @@
 static spinlock_t	fput_lock = SPIN_LOCK_UNLOCKED;
 LIST_HEAD(fput_head);
 
+int async_poll(struct kiocb *iocb, int events);
+
 /* aio_setup
  *	Creates the slab caches used by the aio routines, panic on
  *	failure as this is done early during the boot sequence.
@@ -893,6 +895,19 @@
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
 static int FASTCALL(io_submit_one(struct kioctx *ctx, struct iocb *user_iocb,
 				  struct iocb *iocb));
 static int io_submit_one(struct kioctx *ctx, struct iocb *user_iocb,
@@ -978,12 +993,15 @@
 		if (file->f_op->aio_fsync)
 			ret = file->f_op->aio_fsync(req, 0);
 		break;
+	case IOCB_CMD_POLL:
+		ret = generic_aio_poll(file, req, iocb);
+		break;
 	default:
 		dprintk("EINVAL: io_submit: no operation provided\n");
 		ret = -EINVAL;
 	}
 
-	if (likely(EIOCBQUEUED == ret))
+	if (likely(-EIOCBQUEUED == ret))
 		return 0;
 	if (ret >= 0) {
 		aio_complete(req, ret, 0);
diff -ruN linux-2.5.41/fs/select.c linux-2.5.41AIO/fs/select.c
--- linux-2.5.41/fs/select.c	Mon Oct  7 11:23:21 2002
+++ linux-2.5.41AIO/fs/select.c	Mon Oct 14 13:39:58 2002
@@ -20,6 +20,8 @@
 #include <linux/personality.h> /* for STICKY_TIMEOUTS */
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/aio.h>
+#include <linux/init.h>
 
 #include <asm/uaccess.h>
 
@@ -27,19 +29,34 @@
 #define DEFAULT_POLLMASK (POLLIN | POLLOUT | POLLRDNORM | POLLWRNORM)
 
 struct poll_table_entry {
-	struct file * filp;
 	wait_queue_t wait;
 	wait_queue_head_t * wait_address;
+	struct file * filp;
+	poll_table *p;
 };
 
 struct poll_table_page {
+	unsigned long size;
 	struct poll_table_page * next;
 	struct poll_table_entry * entry;
 	struct poll_table_entry entries[0];
 };
 
 #define POLL_TABLE_FULL(table) \
-	((unsigned long)((table)->entry+1) > PAGE_SIZE + (unsigned long)(table))
+	((unsigned long)((table)->entry+1) > \
+	 (table)->size + (unsigned long)(table))
+
+/* async poll uses only one entry per poll table as it is linked to an iocb */
+typedef struct async_poll_table_struct {
+	poll_table		pt;		
+	int			events;		/* event mask for async poll */
+	int			wake;
+	long			sync;
+	struct poll_table_page	pt_page;	/* one poll table page hdr */
+	struct poll_table_entry entries[1];	/* space for a single entry */
+} async_poll_table;
+
+static kmem_cache_t *async_poll_table_cache;
 
 /*
  * Ok, Peter made a complicated, but straightforward multiple_wait() function.
@@ -53,8 +70,7 @@
  * as all select/poll functions have to call it to add an entry to the
  * poll table.
  */
-
-void poll_freewait(poll_table* pt)
+void __poll_freewait(poll_table* pt, wait_queue_t *wait)
 {
 	struct poll_table_page * p = pt->table;
 	while (p) {
@@ -62,15 +78,141 @@
 		struct poll_table_page *old;
 
 		entry = p->entry;
+		if (entry == p->entries) /* may happen with async poll */
+			break;
 		do {
 			entry--;
-			remove_wait_queue(entry->wait_address,&entry->wait);
+			if (wait != &entry->wait)
+				remove_wait_queue(entry->wait_address,&entry->wait);
+			else
+				__remove_wait_queue(entry->wait_address,&entry->wait);
 			fput(entry->filp);
 		} while (entry > p->entries);
 		old = p;
 		p = p->next;
-		free_page((unsigned long) old);
+		if (old->size == PAGE_SIZE)
+			free_page((unsigned long) old);
 	}
+	if (pt->iocb)
+		kmem_cache_free(async_poll_table_cache, pt);
+}
+
+void poll_freewait(poll_table* pt)
+{
+	__poll_freewait(pt, NULL);
+}
+
+void async_poll_complete(void *data)
+{
+	async_poll_table *pasync = data;
+	poll_table *p = data;
+	struct kiocb	*iocb = p->iocb;
+	unsigned int	mask;
+
+	pasync->wake = 0;
+	wmb();
+	do {
+		mask = iocb->ki_filp->f_op->poll(iocb->ki_filp, p);
+		mask &= pasync->events | POLLERR | POLLHUP;
+		if (mask) {
+			poll_table *p2 = xchg(&iocb->ki_data, NULL);
+			if (p2) {
+				poll_freewait(p2); 
+				aio_complete(iocb, mask, 0);
+			}
+			return;
+		}
+		pasync->sync = 0;
+		wmb();
+	} while (pasync->wake);
+}
+
+static int async_poll_waiter(wait_queue_t *wait, unsigned mode, int sync)
+{
+	struct poll_table_entry *entry = (struct poll_table_entry *)wait;
+	async_poll_table *pasync = (async_poll_table *)(entry->p);
+	struct kiocb	*iocb;
+	unsigned int	mask;
+
+	iocb = pasync->pt.iocb;
+	mask = iocb->ki_filp->f_op->poll(iocb->ki_filp, NULL);
+	mask &= pasync->events | POLLERR | POLLHUP;
+	if (mask) {
+		poll_table *p2 = xchg(&iocb->ki_data, NULL);
+		if (p2) {
+			__poll_freewait(p2, wait); 
+			aio_complete(iocb, mask, 0);
+			return 1;
+		}
+	}
+	return 0;
+}
+
+int async_poll_cancel(struct kiocb *iocb, struct io_event *res)
+{
+	poll_table *p;
+
+	/* FIXME: almost right */
+	p = xchg(&iocb->ki_data, NULL);
+	if (p) {
+		poll_freewait(p); 
+		aio_complete(iocb, 0, 0);
+		aio_put_req(iocb);
+		return 0;
+	}
+	aio_put_req(iocb);
+	return -EAGAIN;
+}
+
+int async_poll(struct kiocb *iocb, int events)
+{
+	unsigned int mask;
+	async_poll_table *pasync;
+	poll_table *p;
+
+	/* Fast path */
+	if (iocb->ki_filp->f_op && iocb->ki_filp->f_op->poll) {
+		mask = iocb->ki_filp->f_op->poll(iocb->ki_filp, NULL);
+		mask &= events | POLLERR | POLLHUP;
+		if (mask & events)
+			return events;
+	}
+
+	pasync = kmem_cache_alloc(async_poll_table_cache, SLAB_KERNEL);
+	if (!pasync)
+		return -ENOMEM;
+
+	p = (poll_table *)pasync;
+	poll_initwait(p);
+	p->iocb = iocb;
+	pasync->wake = 0;
+	pasync->sync = 0;
+	pasync->events = events;
+	pasync->pt_page.entry = pasync->pt_page.entries;
+	pasync->pt_page.size = sizeof(pasync->pt_page) + sizeof(pasync->entries);
+	pasync->pt_page.next = 0;
+	p->table = &pasync->pt_page;
+
+	iocb->ki_data = p;
+	wmb();
+	iocb->ki_cancel = async_poll_cancel;
+
+	mask = DEFAULT_POLLMASK;
+#warning broken
+	iocb->ki_users ++;
+	if (iocb->ki_filp->f_op && iocb->ki_filp->f_op->poll)
+		mask = iocb->ki_filp->f_op->poll(iocb->ki_filp, p);
+	mask &= events | POLLERR | POLLHUP;
+	if (mask && !test_and_set_bit(0, &pasync->sync))
+		aio_complete(iocb, mask, 0);
+
+	if (aio_put_req(iocb))
+		/* Must be freed after aio_complete to synchronise with 
+		 * cancellation of the request.
+		 */
+		poll_freewait(p);
+
+	return -EIOCBQUEUED;
 }
 
 void __pollwait(struct file * filp, wait_queue_head_t * wait_address, poll_table *p)
@@ -86,6 +228,7 @@
 			__set_current_state(TASK_RUNNING);
 			return;
 		}
+		new_table->size = PAGE_SIZE;
 		new_table->entry = new_table->entries;
 		new_table->next = table;
 		p->table = new_table;
@@ -99,7 +242,11 @@
 	 	get_file(filp);
 	 	entry->filp = filp;
 		entry->wait_address = wait_address;
-		init_waitqueue_entry(&entry->wait, current);
+		entry->p = p;
+		if (p->iocb) /* async poll */
+			init_waitqueue_func_entry(&entry->wait, async_poll_waiter);
+		else
+			init_waitqueue_entry(&entry->wait, current);
 		add_wait_queue(wait_address,&entry->wait);
 	}
 }
@@ -495,3 +642,14 @@
 	poll_freewait(&table);
 	return err;
 }
+
+static int __init async_poll_init(void)
+{
+	async_poll_table_cache = kmem_cache_create("async poll table",
+                        sizeof(async_poll_table), 0, 0, NULL, NULL);
+	if (!async_poll_table_cache)
+		panic("unable to alloc poll_table_cache");
+	return 0;
+}
+
+module_init(async_poll_init);
diff -ruN linux-2.5.41/include/linux/aio_abi.h linux-2.5.41AIO/include/linux/aio_abi.h
--- linux-2.5.41/include/linux/aio_abi.h	Mon Oct  7 11:23:28 2002
+++ linux-2.5.41AIO/include/linux/aio_abi.h	Mon Oct  7 16:33:36 2002
@@ -40,6 +40,7 @@
 	 * IOCB_CMD_PREADX = 4,
 	 * IOCB_CMD_POLL = 5,
 	 */
+	IOCB_CMD_POLL = 5,
 	IOCB_CMD_NOOP = 6,
 };
 
diff -ruN linux-2.5.41/include/linux/poll.h linux-2.5.41AIO/include/linux/poll.h
--- linux-2.5.41/include/linux/poll.h	Mon Oct  7 11:24:12 2002
+++ linux-2.5.41AIO/include/linux/poll.h	Tue Oct  8 12:06:44 2002
@@ -9,12 +9,14 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <asm/uaccess.h>
+#include <linux/workqueue.h>
 
 struct poll_table_page;
 
 typedef struct poll_table_struct {
-	int error;
-	struct poll_table_page * table;
+	int			error;
+	struct poll_table_page	*table;
+	struct kiocb		*iocb;		/* iocb for async poll */
 } poll_table;
 
 extern void __pollwait(struct file * filp, wait_queue_head_t * wait_address, poll_table *p);
@@ -29,6 +31,7 @@
 {
 	pt->error = 0;
 	pt->table = NULL;
+	pt->iocb = NULL;
 }
 extern void poll_freewait(poll_table* pt);
 

--------------020507000603030404000607--

