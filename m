Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbVHIU5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbVHIU5N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 16:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbVHIU5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 16:57:13 -0400
Received: from fmr22.intel.com ([143.183.121.14]:62349 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S964961AbVHIU5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 16:57:12 -0400
Date: Tue, 9 Aug 2005 17:00:27 -0400
From: Benjamin LaHaise <bcrl@linux.intel.com>
To: S?bastien Dugu? <sebastien.dugue@bull.net>
Cc: "linux-aio kvack.org" <linux-aio@kvack.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RFC] slight rework of [PATCH 2/5] Add support for AIO completion notification
Message-ID: <20050809210027.GA15958@linux.intel.com>
References: <1122565592.2019.81.camel@frecb000686>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1122565592.2019.81.camel@frecb000686>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sebastien et al,

The patch below is a slight rework of Sebastien's POSIX AIO completion 
signals patch.  Most of the changes are cosmetic for splitting up the 
code into smaller functions, but one significant change is that the 
uid/euid is checked against the target process when the signal is about 
to be delivered, whereas before Sebastien's patch only checked at the 
time the iocb was submitted.  Extra eyes peering over the code in 
__aio_send_signal would be appreciated.  This patch applies towards 
the end of the whole series I've got pending which will be posted in 
a few hours.  Sebastien, can you verify this still works with your 
signal tests?  Thanks,

		-ben

 fs/aio.c                |  227 +++++++++++++++++++++++++++++++++++++++---------
 include/linux/aio.h     |   12 ++
 include/linux/aio_abi.h |    3 
 3 files changed, 199 insertions(+), 43 deletions(-)

[AIO] add support for POSIX AIO completion signals

This patch adds POSIX AIO completion notification event by adding an 
aio_sigevent field to the aiocb.

The sigevent structure is filled in by the user application as part of the
AIO request preparation. Upon request completion, the kernel notifies the
application using those sigevent parameters.

The original patch was by Sébastien Dugué with heavy modifications by 
Benjamin LaHaise.

Signed-off-by: Sébastien Dugué <sebastien.dugue@bull.net>
Signed-off-by: Benjamin LaHaise <bcrl@linux.intel.com>
diff -purN --exclude=description 82_aio_threads/fs/aio.c 83_sigevent/fs/aio.c
--- 82_aio_threads/fs/aio.c	2005-08-08 23:28:52.000000000 -0400
+++ 83_sigevent/fs/aio.c	2005-08-09 16:34:02.000000000 -0400
@@ -404,6 +404,7 @@ static struct kiocb fastcall *__aio_get_
 	req->ki_cancel = NULL;
 	req->ki_retry = NULL;
 	req->ki_dtor = NULL;
+	req->ki_signo = 0;
 	req->private = NULL;
 	INIT_LIST_HEAD(&req->ki_run_list);
 
@@ -932,6 +933,97 @@ void fastcall kick_iocb(struct kiocb *io
 }
 EXPORT_SYMBOL(kick_iocb);
 
+static void __aio_send_signal(struct kiocb *iocb)
+{
+	struct siginfo info;
+	struct task_struct *p;
+	unsigned long flags;
+	int ret = -1;
+
+	memset(&info, 0, sizeof(struct siginfo));
+
+	info.si_signo = iocb->ki_signo;
+	info.si_errno = 0;
+	info.si_code = SI_ASYNCIO;
+	info.si_pid = 0;
+	info.si_uid = 0;
+	info.si_value = iocb->ki_sigev_value;
+
+	read_lock(&tasklist_lock);
+	p = find_task_by_pid(iocb->ki_pid);
+	if (!p || !p->sighand)
+		goto out_unlock;
+
+	/* Do we have permission to signal this task? */
+	if ((iocb->ki_euid ^ p->suid) && (iocb->ki_euid ^ p->uid)
+            && (iocb->ki_uid ^ p->suid) && (iocb->ki_uid ^ p->uid))
+		goto out_unlock;	/* No. */
+
+	spin_lock_irqsave(&p->sighand->siglock, flags);
+
+	switch(iocb->ki_notify) {
+	case IO_NOTIFY_SIGNAL:
+		ret = __group_send_sig_info(iocb->ki_signo, &info, p);
+		break;
+	case IO_NOTIFY_THREAD_ID:
+		//ret = specific_send_sig_info(iocb->ki_signo, &info, p);
+		ret = __group_send_sig_info(iocb->ki_signo, &info, p);
+		break;
+	}
+
+	spin_unlock_irqrestore(&p->sighand->siglock, flags);
+
+	if (ret)
+		printk(KERN_DEBUG "__aio_send_signal: failed to send signal %d to %d\n",
+		       iocb->ki_signo, iocb->ki_pid);
+
+out_unlock:
+	read_unlock(&tasklist_lock);
+}
+
+static void __aio_write_evt(struct kioctx *ctx, struct io_event *event)
+{
+	struct aio_ring_info	*info;
+	struct aio_ring *ring;
+	struct io_event *ring_event;
+	unsigned long   tail;
+
+	info = &ctx->ring_info;
+
+	/* add a completion event to the ring buffer.
+	 * must be done holding ctx->ctx_lock to prevent
+	 * other code from messing with the tail
+	 * pointer since we might be called from irq
+	 * context.
+	 */
+
+	ring = kmap_atomic(info->ring_pages[0], KM_IRQ1);
+
+	tail = info->tail;
+	ring_event = aio_ring_event(info, tail, KM_IRQ0);
+	if (++tail >= info->nr)
+		tail = 0;
+
+	*ring_event = *event;
+
+	dprintk("aio_write_evt: %p[%lu]: %Lx %Lx %Lx %Lx\n",
+		ctx, tail, event->obj, event->data, event->res, event->res2);
+
+	/* after flagging the request as done, we
+	 * must never even look at it again
+	 */
+
+	smp_wmb();	/* make event visible before updating tail */
+
+	info->tail = tail;
+	ring->tail = tail;
+
+	put_aio_ring_event(ring_event, KM_IRQ0);
+	kunmap_atomic(ring, KM_IRQ1);
+
+	pr_debug("added to ring at [%lu]\n", tail);
+}
+
 /* aio_complete
  *	Called when the io request on the given iocb is complete.
  *	Returns true if this is the last user of the request.  The 
@@ -940,11 +1032,8 @@ EXPORT_SYMBOL(kick_iocb);
 int fastcall aio_complete(struct kiocb *iocb, long res, long res2)
 {
 	struct kioctx	*ctx = iocb->ki_ctx;
-	struct aio_ring_info	*info;
-	struct aio_ring	*ring;
-	struct io_event	*event;
+	struct io_event event;
 	unsigned long	flags;
-	unsigned long	tail;
 	int		ret;
 
 	/* Special case handling for sync iocbs: events go directly
@@ -971,14 +1060,13 @@ int fastcall aio_complete(struct kiocb *
 		return ret;
 	}
 
-	info = &ctx->ring_info;
+	/* insert event in the event ring */
+
+	event.obj = (u64)(unsigned long)iocb->ki_obj.user;
+	event.data = iocb->ki_user_data;
+	event.res = res;
+	event.res2 = res2;
 
-	/* add a completion event to the ring buffer.
-	 * must be done holding ctx->ctx_lock to prevent
-	 * other code from messing with the tail
-	 * pointer since we might be called from irq
-	 * context.
-	 */
 	spin_lock_irqsave(&ctx->ctx_lock, flags);
 
 	if (iocb->ki_run_list.prev && !list_empty(&iocb->ki_run_list))
@@ -991,34 +1079,10 @@ int fastcall aio_complete(struct kiocb *
 	if (kiocbIsCancelled(iocb))
 		goto put_rq;
 
-	ring = kmap_atomic(info->ring_pages[0], KM_IRQ1);
-
-	tail = info->tail;
-	event = aio_ring_event(info, tail, KM_IRQ0);
-	if (++tail >= info->nr)
-		tail = 0;
-
-	event->obj = (u64)(unsigned long)iocb->ki_obj.user;
-	event->data = iocb->ki_user_data;
-	event->res = res;
-	event->res2 = res2;
-
-	dprintk("aio_complete: %p[%lu]: %p: %p %Lx %lx %lx\n",
-		ctx, tail, iocb, iocb->ki_obj.user, iocb->ki_user_data,
-		res, res2);
+	__aio_write_evt(ctx, &event);
 
-	/* after flagging the request as done, we
-	 * must never even look at it again
-	 */
-	smp_wmb();	/* make event visible before updating tail */
-
-	info->tail = tail;
-	ring->tail = tail;
-
-	put_aio_ring_event(event, KM_IRQ0);
-	kunmap_atomic(ring, KM_IRQ1);
-
-	pr_debug("added to ring %p at [%lu]\n", iocb, tail);
+	if (iocb->ki_signo)
+		__aio_send_signal(iocb);
 
 	pr_debug("%ld retries: %d of %d\n", iocb->ki_retried,
 		iocb->ki_nbytes - iocb->ki_left, iocb->ki_nbytes);
@@ -1443,7 +1507,7 @@ static ssize_t aio_kernel_thread(struct 
 	 */
 	ret = kernel_thread(fn, iocb, CLONE_FS|CLONE_FILES);
 	if (ret < 0)
-		return -ENOMEM;
+		return ret;
 	return -EIOCBQUEUED;
 }
 
@@ -1593,6 +1657,71 @@ int aio_wake_function(wait_queue_t *wait
 	return 0;
 }
 
+static long iocb_setup_sigevent(struct kiocb *req,
+				struct sigevent __user *user_event)
+{
+	int notify = 0;
+	pid_t aio_pid;
+	int aio_signo = 0;
+
+	req->ki_uid = current->uid;
+	req->ki_euid = current->euid;
+
+	if (!access_ok(VERIFY_READ, user_event, sizeof(struct sigevent)))
+		return -EFAULT;
+	/*
+	 * We avoid copying the whole sigevent bunch and only get the
+	 * needed fields.
+	 */
+	if (unlikely(__get_user(aio_pid, &user_event->sigev_notify_thread_id)))
+		return -EFAULT;
+
+	if (unlikely(__get_user(aio_signo, &user_event->sigev_signo)))
+		return -EFAULT;
+
+	if (unlikely(__copy_from_user(&req->ki_sigev_value,
+				      &user_event->sigev_value,
+				      sizeof(sigval_t))))
+		return -EFAULT;
+
+	if (!aio_signo)
+		return 0; /* no signal number, we do nothing */
+
+	if (aio_pid == 0) {
+		/* notify itself */
+		aio_pid = current->pid;
+		notify = IO_NOTIFY_SIGNAL;
+	} else {
+	        pid_t group_id;
+		task_t *ptask;
+		/* notify given thread */
+
+		/* caller thread and target thread must be in same
+		 * thread group
+		 */
+		read_lock(&tasklist_lock);
+
+		ptask = find_task_by_pid(req->ki_pid);
+		if (ptask)
+			group_id = ptask->tgid;
+		read_unlock(&tasklist_lock);
+
+		if (unlikely (ptask == NULL))
+			return -ESRCH;
+
+		if (group_id != current->tgid)
+			return -EINVAL;
+
+		notify = IO_NOTIFY_THREAD_ID;
+	}
+
+	req->ki_pid = aio_pid;
+	req->ki_signo = aio_signo;
+	req->ki_notify = notify;
+
+	return 0;
+}
+
 int fastcall io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 			 struct iocb *iocb)
 {
@@ -1601,8 +1730,7 @@ int fastcall io_submit_one(struct kioctx
 	ssize_t ret;
 
 	/* enforce forwards compatibility on users */
-	if (unlikely(iocb->aio_reserved1 || iocb->aio_reserved2 ||
-		     iocb->aio_reserved3)) {
+	if (unlikely(iocb->aio_reserved1)) {
 		pr_debug("EINVAL: io_submit: reserve field set\n");
 		return -EINVAL;
 	}
@@ -1611,6 +1739,7 @@ int fastcall io_submit_one(struct kioctx
 	if (unlikely(
 	    (iocb->aio_buf != (unsigned long)iocb->aio_buf) ||
 	    (iocb->aio_nbytes != (size_t)iocb->aio_nbytes) ||
+	    (iocb->aio_sigeventp != (unsigned long)iocb->aio_sigeventp) ||
 	    ((ssize_t)iocb->aio_nbytes < 0)
 	   )) {
 		pr_debug("EINVAL: io_submit: overflow check\n");
@@ -1646,8 +1775,16 @@ int fastcall io_submit_one(struct kioctx
  	req->ki_run_list.next = req->ki_run_list.prev = NULL;
 	req->ki_retried = 0;
 
-	ret = aio_setup_iocb(req);
+	/* handle setting up the sigevent for POSIX AIO signals */
+	if (iocb->aio_sigeventp) {
+		ret = iocb_setup_sigevent(req, 
+				(struct sigevent __user *)(unsigned long)
+					iocb->aio_sigeventp);
+		if (ret)
+			goto out_put_req;
+	}
 
+	ret = aio_setup_iocb(req);
 	if (ret)
 		goto out_put_req;
 
@@ -1720,6 +1857,12 @@ asmlinkage long sys_io_submit(aio_contex
 			break;
 		}
 
+		/* Check user_iocb access */
+		if (unlikely(!access_ok(VERIFY_READ, user_iocb, sizeof(struct iocb)))) {
+			ret = -EFAULT;
+			break;
+		}
+
 		ret = io_submit_one(ctx, user_iocb, &tmp);
 		if (ret)
 			break;
diff -purN --exclude=description 82_aio_threads/include/linux/aio.h 83_sigevent/include/linux/aio.h
--- 82_aio_threads/include/linux/aio.h	2005-08-08 17:16:06.000000000 -0400
+++ 83_sigevent/include/linux/aio.h	2005-08-09 16:02:13.000000000 -0400
@@ -7,6 +7,11 @@
 
 #include <asm/atomic.h>
 
+enum {
+	IO_NOTIFY_SIGNAL = 0,		/* send signal to a processe */
+	IO_NOTIFY_THREAD_ID = 1,	/* send signal to a specific thread */
+};
+
 #define AIO_MAXSEGS		4
 #define AIO_KIOGRP_NR_ATOMIC	8
 
@@ -84,6 +89,13 @@ struct kiocb {
 	long			ki_queued; 	/* just for testing */
 
 	void			*private;
+
+	/* to notify a process on I/O event only valid if ki_signo != 0 */
+	pid_t			ki_pid;
+	__u16			ki_signo;
+	__u16			ki_notify;
+	uid_t			ki_uid, ki_euid;
+	sigval_t		ki_sigev_value; 
 };
 
 #define is_sync_kiocb(iocb)	((iocb)->ki_key == KIOCB_SYNC_KEY)
diff -purN --exclude=description 82_aio_threads/include/linux/aio_abi.h 83_sigevent/include/linux/aio_abi.h
--- 82_aio_threads/include/linux/aio_abi.h	2005-06-20 13:33:38.000000000 -0400
+++ 83_sigevent/include/linux/aio_abi.h	2005-08-09 12:37:25.000000000 -0400
@@ -80,8 +80,9 @@ struct iocb {
 	__u64	aio_nbytes;
 	__s64	aio_offset;
 
+	__u64	aio_sigeventp;	/* pointer to struct sigevent */
+
 	/* extra parameters */
-	__u64	aio_reserved2;	/* TODO: use this for a (struct sigevent *) */
 	__u64	aio_reserved3;
 }; /* 64 bytes */
 
