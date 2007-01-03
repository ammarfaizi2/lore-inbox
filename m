Return-Path: <linux-kernel-owner+w=401wt.eu-S1754872AbXACHTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754872AbXACHTV (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 02:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754893AbXACHTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 02:19:20 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:57247 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754872AbXACHTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 02:19:19 -0500
Date: Wed, 3 Jan 2007 12:53:45 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, akpm@osdl.org, drepper@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com, mingo@elte.hu
Subject: [PATCHSET 2][PATCH 1/1] Combining epoll and disk file AIO
Message-ID: <20070103072345.GA21346@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20061227153855.GA25898@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061227153855.GA25898@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27, 2006 at 09:08:56PM +0530, Suparna Bhattacharya wrote:
> (2) Most of these other applications need the ability to process both
>     network events (epoll) and disk file AIO in the same loop. With POSIX AIO
>     they could at least sort of do this using signals (yeah, and all associated
>     issues). The IO_CMD_EPOLL_WAIT patch (originally from Zach Brown with
>     modifications from Jeff Moyer and me) addresses this problem for native
>     linux aio in a simple manner. Tridge has written a test harness to
>     try out the Samba4 event library modifications to use this. Jeff Moyer
>     has a modified version of pipetest for comparison.
> 


Enable epoll wait to be unified with io_getevents

From: Zach Brown, Jeff Moyer, Suparna Bhattacharya

Previously there have been (complicated and scary) attempts to funnel
individual aio events down epoll or vice versa.  This instead lets one
issue an entire sys_epoll_wait() as an aio op.  You'd setup epoll as
usual and then issue epoll_wait aio ops which would complete once epoll
events had been copied. This will enable a single io_getevents() event
loop to process both disk AIO and epoll notifications.

>From an application standpoint a typical flow works like this:
- Use epoll_ctl as usual to add/remove epoll registrations
- Instead of issuing sys_epoll_wait, setup an iocb using
  io_prep_epoll_wait (see examples below) specifying the epoll
  events buffer to fill up with epoll notifications. Submit the iocb
  using io_submit
- Now io_getevents can be used to wait for both epoll waits and
  disk aio completion. If the returned AIO event is of type
  IO_CMD_EPOLL_WAIT, then corresponding result value indicates the
  number of epoll notifications in the iocb's event buffer, which
  can now be processed just like once would process results from a
  sys_epoll_wait()

There are a couple of sample applications:
- Andrew Tridgell has implemented a little test harness using an aio events
  library implementation intended for samba4 
  http://samba.org/~tridge/etest
  (The -e aio option uses aio epoll wait and can issue disk aio as well)
- An updated version of pipetest from Jeff Moyer has a --aio-epoll option
  http://people.redhat.com/jmoyer/aio/epoll/pipetest.c

There is obviously a little overhead compared to using sys_epoll_wait(), due
to the extra step of submitting the epoll wait iocb, most noticible when
there are very few events processed per loop. However, the goal here is not
to build an epoll alternative but merely to allow network and disk I/O to
be processed in the same event loop which is where the efficiencies really
come from. Picking up more epoll events in each loop can amortize the
overhead across many operations to mitigate the impact.
  
Thanks to Arjan Van de Van for helping figure out how to resolve the
lockdep complaints. Both ctx->lock and ep->lock can be held in certain 
wait queue callback routines, thus being nested inside q->lock. However, this
excludes ctx->wait or ep->wq wait queues, which can safetly be nested
inside ctx->lock or ep->lock respectively. So we teach lockdep to recognize
these as distinct classes.

Signed-off-by: Zach Brown <zach.brown@oracle.com>
Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Suparna Bhattacharya <suparna@in.ibm.com>

---

 linux-2.6.20-rc1-root/fs/aio.c                  |   54 +++++++++++++
 linux-2.6.20-rc1-root/fs/eventpoll.c            |   95 +++++++++++++++++++++---
 linux-2.6.20-rc1-root/include/linux/aio.h       |    2 
 linux-2.6.20-rc1-root/include/linux/aio_abi.h   |    1 
 linux-2.6.20-rc1-root/include/linux/eventpoll.h |   31 +++++++
 linux-2.6.20-rc1-root/include/linux/sched.h     |    2 
 linux-2.6.20-rc1-root/kernel/timer.c            |   21 +++++
 7 files changed, 196 insertions(+), 10 deletions(-)

diff -puN fs/aio.c~aio-epoll-wait fs/aio.c
--- linux-2.6.20-rc1/fs/aio.c~aio-epoll-wait	2006-12-28 14:22:52.000000000 +0530
+++ linux-2.6.20-rc1-root/fs/aio.c	2007-01-03 11:45:40.000000000 +0530
@@ -30,6 +30,7 @@
 #include <linux/highmem.h>
 #include <linux/workqueue.h>
 #include <linux/security.h>
+#include <linux/eventpoll.h>
 
 #include <asm/kmap_types.h>
 #include <asm/uaccess.h>
@@ -193,6 +194,8 @@ static int aio_setup_ring(struct kioctx 
 	kunmap_atomic((void *)((unsigned long)__event & PAGE_MASK), km); \
 } while(0)
 
+static struct lock_class_key ioctx_wait_queue_head_lock_key;
+
 /* ioctx_alloc
  *	Allocates and initializes an ioctx.  Returns an ERR_PTR if it failed.
  */
@@ -224,6 +227,8 @@ static struct kioctx *ioctx_alloc(unsign
 	spin_lock_init(&ctx->ctx_lock);
 	spin_lock_init(&ctx->ring_info.ring_lock);
 	init_waitqueue_head(&ctx->wait);
+	/* Teach lockdep to recognize this lock as a different class */
+	lockdep_set_class(&ctx->wait.lock, &ioctx_wait_queue_head_lock_key);
 
 	INIT_LIST_HEAD(&ctx->active_reqs);
 	INIT_LIST_HEAD(&ctx->run_list);
@@ -1401,6 +1406,42 @@ static ssize_t aio_setup_single_vector(s
 	return 0;
 }
 
+/* Uses iocb->ki_private */
+void aio_free_iocb_timer(struct kiocb *iocb)
+{
+	struct timer_list *timer = (struct timer_list *)iocb->private;
+
+	if (timer) {
+		del_timer(timer);
+		kfree(timer);
+		iocb->private = NULL;
+	}
+}
+
+/* Uses iocb->private */
+int aio_setup_iocb_timer(struct kiocb *iocb, unsigned long expires,
+	void (*function)(unsigned long))
+{
+	struct timer_list *timer;
+
+	if (iocb->private)
+		return -EEXIST;
+
+	timer = kmalloc(sizeof(struct timer_list), GFP_KERNEL);
+	if (!timer)
+		return -ENOMEM;
+
+	init_timer(timer);
+	timer->function = function;
+	timer->data = (unsigned long)iocb;
+	timer->expires = expires;
+
+	iocb->private = timer;
+	iocb->ki_dtor = aio_free_iocb_timer;
+	return 0;
+}
+
+
 /*
  * aio_setup_iocb:
  *	Performs the initial checks and aio retry method
@@ -1486,6 +1527,19 @@ static ssize_t aio_setup_iocb(struct kio
 		if (file->f_op->aio_fsync)
 			kiocb->ki_retry = aio_fsync;
 		break;
+	case IOCB_CMD_EPOLL_WAIT:
+		/*
+	 	 *  Note that we unconditionally allocate a timer, but we
+	 	 *  only use it if a timeout was specified.  Otherwise, it
+	 	 *  is just a holder for the "infinite" value.
+	 	 */
+		ret = aio_setup_iocb_timer(kiocb, ep_relative_ms_to_jiffies(
+					kiocb->ki_pos), eventpoll_aio_timer);
+		if (unlikely(ret))
+			break;
+		kiocb->ki_retry = eventpoll_aio_wait;
+		kiocb->ki_cancel = eventpoll_aio_cancel;
+		break;
 	default:
 		dprintk("EINVAL: io_submit: no operation provided\n");
 		ret = -EINVAL;
diff -puN fs/eventpoll.c~aio-epoll-wait fs/eventpoll.c
--- linux-2.6.20-rc1/fs/eventpoll.c~aio-epoll-wait	2006-12-28 14:22:52.000000000 +0530
+++ linux-2.6.20-rc1-root/fs/eventpoll.c	2006-12-28 14:22:52.000000000 +0530
@@ -35,6 +35,7 @@
 #include <linux/mount.h>
 #include <linux/bitops.h>
 #include <linux/mutex.h>
+#include <linux/aio.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <asm/io.h>
@@ -642,6 +643,75 @@ eexit_1:
 	return error;
 }
 
+/*
+ * Called when the eventpoll timer expires or a cancellation
+ * occurs for an aio_epoll_wait. It is enough for this function to
+ * trigger a wakeup on the eventpoll waitqueue. The aio_wake_function()
+ * callback will pull out the wait queue entry and kick the iocb so that
+ * the rest gets taken care of in aio_run_iocb->aio_epoll_wait which
+ * can recognize the cancelled state or timeout expiration and do
+ * the right thing.
+ */
+void eventpoll_aio_timer(unsigned long data)
+{
+	struct kiocb *iocb = (struct kiocb *)data;
+	struct timer_list *timer = iocb_timer(iocb);
+	struct file *file = iocb->ki_filp;
+	struct eventpoll *ep = (struct eventpoll *)file->private_data;
+	unsigned long flags;
+
+	if (timer)
+		del_timer(timer);
+	write_lock_irqsave(&ep->lock, flags);
+	/* because ep->lock also protects ep->wq */
+	__wake_up_locked(&ep->wq, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE);
+	write_unlock_irqrestore(&ep->lock, flags);
+}
+
+
+int eventpoll_aio_cancel(struct kiocb *iocb, struct io_event *event)
+{
+	/* to wakeup the iocb, so actual cancellation happens aio_run_iocb */
+	eventpoll_aio_timer((unsigned long)iocb);
+
+	event->res = event->res2 = 0;
+	/* drop the cancel reference */
+	aio_put_req(iocb);
+
+	return 0;
+}
+
+/*
+ * iocb->ki_nbytes -- number of events
+ * iocb->ki_pos    -- relative timeout in milliseconds
+ * iocb->private   -- timer with absolute timeout in jiffies
+ */
+ssize_t eventpoll_aio_wait(struct kiocb *iocb)
+{
+	struct file *file = iocb->ki_filp;
+	ssize_t ret = -EINVAL;
+	unsigned long expires;
+	struct timer_list *timer = iocb_timer(iocb);
+
+	if (!is_file_epoll(file) || iocb->ki_nbytes > EP_MAX_EVENTS ||
+	    iocb->ki_nbytes <= 0)
+		return -EINVAL;
+
+	expires = timer->expires;
+	ret = ep_poll(file->private_data,
+		      (struct epoll_event __user *)iocb->ki_buf,
+		      iocb->ki_nbytes, ep_jiffies_to_relative_ms(expires));
+
+	/*
+	 *  If a timeout was specified, ep_poll returned retry, and we have
+	 *  not yet registered a timer, go ahead and register one.
+	 */
+	if (ret == -EIOCBRETRY) {
+		mod_timer(timer, expires);
+	}
+
+	return ret;
+}
 
 /*
  * Implement the event wait interface for the eventpoll file. It is the kernel
@@ -824,6 +894,7 @@ eexit_1:
 	return error;
 }
 
+static struct lock_class_key eventpoll_wait_queue_head_lock_key;
 
 static int ep_alloc(struct eventpoll **pep)
 {
@@ -835,6 +906,9 @@ static int ep_alloc(struct eventpoll **p
 	rwlock_init(&ep->lock);
 	init_rwsem(&ep->sem);
 	init_waitqueue_head(&ep->wq);
+	/* Teach lockdep to recognize this lock as a different class */
+	lockdep_set_class(&ep->wq.lock, &eventpoll_wait_queue_head_lock_key);
+
 	init_waitqueue_head(&ep->poll_wait);
 	INIT_LIST_HEAD(&ep->rdllist);
 	ep->rbr = RB_ROOT;
@@ -1549,7 +1623,7 @@ static int ep_poll(struct eventpoll *ep,
 	int res, eavail;
 	unsigned long flags;
 	long jtimeout;
-	wait_queue_t wait;
+	wait_queue_t *wait = current->io_wait;
 
 	/*
 	 * Calculate the timeout by checking for the "infinite" value ( -1 )
@@ -1569,16 +1643,13 @@ retry:
 		 * We need to sleep here, and we will be wake up by
 		 * ep_poll_callback() when events will become available.
 		 */
-		init_waitqueue_entry(&wait, current);
-		__add_wait_queue(&ep->wq, &wait);
-
 		for (;;) {
 			/*
 			 * We don't want to sleep if the ep_poll_callback() sends us
 			 * a wakeup in between. That's why we set the task state
 			 * to TASK_INTERRUPTIBLE before doing the checks.
 			 */
-			set_current_state(TASK_INTERRUPTIBLE);
+			prepare_to_wait(&ep->wq, wait, TASK_INTERRUPTIBLE);
 			if (!list_empty(&ep->rdllist) || !jtimeout)
 				break;
 			if (signal_pending(current)) {
@@ -1587,12 +1658,16 @@ retry:
 			}
 
 			write_unlock_irqrestore(&ep->lock, flags);
-			jtimeout = schedule_timeout(jtimeout);
+			if ((jtimeout = schedule_timeout_wait(jtimeout, wait))
+				< 0) {
+				if ((res = jtimeout) == -EIOCBRETRY)
+					goto out;
+			}
+			if (res < 0)
+				break;
 			write_lock_irqsave(&ep->lock, flags);
 		}
-		__remove_wait_queue(&ep->wq, &wait);
-
-		set_current_state(TASK_RUNNING);
+		finish_wait(&ep->wq, wait);
 	}
 
 	/* Is it worth to try to dig for events ? */
@@ -1608,7 +1683,7 @@ retry:
 	if (!res && eavail &&
 	    !(res = ep_events_transfer(ep, events, maxevents)) && jtimeout)
 		goto retry;
-
+out:
 	return res;
 }
 
diff -puN include/linux/aio_abi.h~aio-epoll-wait include/linux/aio_abi.h
--- linux-2.6.20-rc1/include/linux/aio_abi.h~aio-epoll-wait	2006-12-28 14:22:52.000000000 +0530
+++ linux-2.6.20-rc1-root/include/linux/aio_abi.h	2006-12-28 14:22:52.000000000 +0530
@@ -43,6 +43,7 @@ enum {
 	IOCB_CMD_NOOP = 6,
 	IOCB_CMD_PREADV = 7,
 	IOCB_CMD_PWRITEV = 8,
+	IOCB_CMD_EPOLL_WAIT = 9,
 };
 
 /* read() from /dev/aio returns these structures. */
diff -puN include/linux/aio.h~aio-epoll-wait include/linux/aio.h
--- linux-2.6.20-rc1/include/linux/aio.h~aio-epoll-wait	2006-12-28 14:22:52.000000000 +0530
+++ linux-2.6.20-rc1-root/include/linux/aio.h	2006-12-28 14:22:52.000000000 +0530
@@ -244,6 +244,8 @@ do {									\
 
 #define io_wait_to_kiocb(io_wait) container_of(container_of(io_wait,	\
 	struct wait_bit_queue, wait), struct kiocb, ki_wait)
+#define iocb_timer(iocb)	((struct timer_list *)((iocb)->private))
+
 
 #include <linux/aio_abi.h>
 
diff -puN include/linux/eventpoll.h~aio-epoll-wait include/linux/eventpoll.h
--- linux-2.6.20-rc1/include/linux/eventpoll.h~aio-epoll-wait	2006-12-28 14:22:52.000000000 +0530
+++ linux-2.6.20-rc1-root/include/linux/eventpoll.h	2006-12-28 14:22:52.000000000 +0530
@@ -48,6 +48,33 @@ struct epoll_event {
 /* Forward declarations to avoid compiler errors */
 struct file;
 
+/* Maximum msec timeout value storeable in a long int */
+#define EP_MAX_MSTIMEO min(1000ULL * MAX_SCHEDULE_TIMEOUT / HZ, (LONG_MAX - 999ULL) / HZ)
+
+static inline int ep_jiffies_to_relative_ms(unsigned long expires)
+{
+	int relative_ms = 0;
+	unsigned long now = jiffies;
+
+	if (expires == MAX_SCHEDULE_TIMEOUT)
+		relative_ms = EP_MAX_MSTIMEO;
+	else if (time_before(now, expires))
+		relative_ms = jiffies_to_msecs(expires - now);
+
+	return relative_ms;
+}
+
+static inline unsigned long ep_relative_ms_to_jiffies(int relative_ms)
+{
+	unsigned long expires;
+
+	if (relative_ms < 0 || relative_ms >= EP_MAX_MSTIMEO)
+		expires = MAX_SCHEDULE_TIMEOUT;
+	else
+		expires = jiffies + msecs_to_jiffies(relative_ms);
+	return expires;
+}
+
 
 #ifdef CONFIG_EPOLL
 
@@ -90,6 +117,10 @@ static inline void eventpoll_release(str
 	eventpoll_release_file(file);
 }
 
+extern void eventpoll_aio_timer(unsigned long data);
+extern int eventpoll_aio_cancel(struct kiocb *iocb, struct io_event *event);
+extern ssize_t eventpoll_aio_wait(struct kiocb *iocb);
+
 #else
 
 static inline void eventpoll_init_file(struct file *file) {}
diff -puN include/linux/sched.h~aio-epoll-wait include/linux/sched.h
--- linux-2.6.20-rc1/include/linux/sched.h~aio-epoll-wait	2006-12-28 14:22:52.000000000 +0530
+++ linux-2.6.20-rc1-root/include/linux/sched.h	2006-12-28 14:22:52.000000000 +0530
@@ -247,6 +247,8 @@ extern int in_sched_functions(unsigned l
 
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
+extern signed long FASTCALL(schedule_timeout_wait(signed long timeout,
+				wait_queue_t *wait));
 extern signed long schedule_timeout_interruptible(signed long timeout);
 extern signed long schedule_timeout_uninterruptible(signed long timeout);
 asmlinkage void schedule(void);
diff -puN kernel/timer.c~aio-epoll-wait kernel/timer.c
--- linux-2.6.20-rc1/kernel/timer.c~aio-epoll-wait	2006-12-28 14:22:52.000000000 +0530
+++ linux-2.6.20-rc1-root/kernel/timer.c	2006-12-28 14:22:52.000000000 +0530
@@ -1369,6 +1369,27 @@ fastcall signed long __sched schedule_ti
 EXPORT_SYMBOL(schedule_timeout);
 
 /*
+ * Same as schedule_timeout, except that it checks the wait queue context
+ * passed in, and in case of an asynchronous waiter it does not sleep,
+ * but returns -EIOCBRETRY to allow the operation to be retried later when
+ * notified, unless it has been cancelled in which case it returns -EINTR
+ */
+fastcall signed long __sched schedule_timeout_wait(signed long timeout,
+	wait_queue_t *wait)
+{
+	struct kiocb *iocb;
+	if (is_sync_wait(wait))
+		return schedule_timeout(timeout);
+
+	iocb = io_wait_to_kiocb(wait);
+	if (kiocbIsCancelled(iocb))
+		return -EINTR;
+
+	return -EIOCBRETRY;
+}
+
+
+/*
  * We can use __set_current_state() here because schedule_timeout() calls
  * schedule() unconditionally.
  */
_


-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

