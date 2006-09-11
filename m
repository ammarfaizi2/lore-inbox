Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWIKJmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWIKJmA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 05:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWIKJmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 05:42:00 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:10731 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S932161AbWIKJl7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 05:41:59 -0400
Date: Mon, 11 Sep 2006 11:41:51 +0200
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: linux-kernel@vger.kernel.org
Cc: linux-aio@kvack.org, drepper@redhat.com, suparna@in.ibm.com,
       pbadari@us.ibm.com, zach.brown@oracle.com, hch@infradead.org,
       johnpol@2ka.mipt.ru, davem@davemloft.net, sebastien.dugue@bull.net
Subject: [PATCH AIO 1/2] Add AIO completion notification
Message-ID: <20060911114151.3b418c4d@frecb000686>
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 11/09/2006 11:47:32,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 11/09/2006 11:47:34,
	Serialize complete at 11/09/2006 11:47:34
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




                      AIO completion notification

  The current 2.6 kernel does not support notification of user space via
an RT signal upon an asynchronous IO completion. The POSIX specification
states that when an AIO request completes, a signal can be delivered to
the application as notification.

  The aioevent patch adds a struct sigevent *aio_sigeventp to the iocb.
The relevant fields (pid, signal number and value) are stored in the kiocb
for use when the request completes.

  That sigevent structure is filled by the application as part of the AIO
request preparation. Upon request completion, the kernel notifies the
application using those sigevent parameters. If SIGEV_NONE has been specified,
then the old behaviour is retained and the application must rely on polling
the completion queue using io_getevents().


  A struct sigevent *aio_sigeventp field is added to struct iocb in
include/linux/aio_abi.h

  A struct aio_notify containing the sigevent parameters is defined in aio.h:

  struct aio_notify {
	pid_t			pid;
	__u16			signo;
	__u16			notify;
	sigval_t		value;
  };

  A struct aio_notify ki_notify is added to struct kiocb in include/linux/aio.h

  In io_submit_one(), if the application provided a sigevent then
setup_sigevent() is called which does the following:

	- check access to the user sigevent and make a local copy

	- if the requested notification is SIGEV_NONE, then nothing to do

	- fill in the kiocb->ki_notify fields (notify, signo, value)

	- check sigevent consistency, get the signal target task and
	  save it in kiocb->ki_notify.pid

  Upon request completion, in aio_complete(), if notification is needed for
this request (iocb->ki_notify.notify != SIGEV_NONE), then aio_send_signal()
is called to signal the target task as follows:

	- fill in the siginfo struct to be sent to the task

	- if notify is SIGEV_THREAD_ID then send signal to specific task
	  using specific_send_sig_info()

	- else send signal to task group using __group_send_sig_info()

  NOTE: specific_send_sig_info() has to be made non static and exported to be
	used here.



 fs/aio.c                |  197 ++++++++++++++++++++++++++++++++++++++----------
 include/linux/aio.h     |   11 ++
 include/linux/aio_abi.h |    3
 include/linux/signal.h  |    1
 kernel/signal.c         |    2
 5 files changed, 172 insertions(+), 42 deletions(-)

Signed-off-by: Laurent Vivier <laurent.vivier@bull.net>
Signed-off-by: Sébastien Dugué <sebastien.dugue@bull.net>
Signed-off-by: Benjamin LaHaise <bcrl@linux.intel.com>

Index: linux-2.6.18-rc6/fs/aio.c
===================================================================
--- linux-2.6.18-rc6.orig/fs/aio.c	2006-09-04 17:03:56.000000000 +0200
+++ linux-2.6.18-rc6/fs/aio.c	2006-09-06 16:38:10.000000000 +0200
@@ -925,6 +925,140 @@ void fastcall kick_iocb(struct kiocb *io
 }
 EXPORT_SYMBOL(kick_iocb);
 
+static void aio_send_signal(struct aio_notify *notify)
+{
+	struct siginfo info;
+	struct task_struct *p;
+	unsigned long flags;
+	int ret = -1;
+
+	memset(&info, 0, sizeof(struct siginfo));
+
+	info.si_signo = notify->signo;
+	info.si_errno = 0;
+	info.si_code = SI_ASYNCIO;
+	info.si_pid = 0;
+	info.si_uid = 0;
+	info.si_value = notify->value;
+
+	read_lock(&tasklist_lock);
+	p = find_task_by_pid(notify->pid);
+
+	if (!p || !p->sighand)
+		goto out_unlock;
+
+	spin_lock_irqsave(&p->sighand->siglock, flags);
+
+	if (notify->notify & SIGEV_THREAD_ID)
+		ret = specific_send_sig_info(notify->signo, &info, p);
+	else
+		ret = __group_send_sig_info(notify->signo, &info, p);
+
+
+	spin_unlock_irqrestore(&p->sighand->siglock, flags);
+
+	if (ret)
+		printk(KERN_DEBUG "aio_send_signal: failed to send signal %d
to %d\n",
+		       notify->signo, notify->pid);
+out_unlock:
+	read_unlock(&tasklist_lock);
+}
+
+static struct task_struct * good_sigevent(sigevent_t * event)
+{
+	struct task_struct *target = current->group_leader;
+
+	if ((event->sigev_notify & SIGEV_THREAD_ID ) &&
+		(!(target = find_task_by_pid(event->sigev_notify_thread_id)) ||
+		 target->tgid != current->tgid ||
+		 (event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_SIGNAL))
+		return NULL;
+
+	if (((event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE) &&
+	    ((event->sigev_signo <= 0) || (event->sigev_signo > SIGRTMAX)))
+		return NULL;
+
+	return target;
+}
+
+static long setup_sigevent(struct aio_notify *notify,
+			   struct sigevent __user *user_event)
+{
+	int error = 0;
+	sigevent_t event;
+	struct task_struct *target;
+
+	if (!access_ok(VERIFY_READ, user_event, sizeof(struct sigevent)))
+		return -EFAULT;
+
+	if (copy_from_user(&event, user_event, sizeof (event)))
+		return -EFAULT;
+
+	/* Check for the SIGEV_NONE case */
+	if (event.sigev_notify == SIGEV_NONE)
+		return 0;
+
+	/* Setup the request completion notification parameters */
+	notify->notify = event.sigev_notify;
+	notify->signo = event.sigev_signo;
+	notify->value = event.sigev_value;
+
+	/* Now get the notification target */
+	read_lock(&tasklist_lock);
+
+	if ((target = good_sigevent(&event)))
+		notify->pid = target->pid;
+	else
+		error = -EINVAL;
+
+	read_unlock(&tasklist_lock);
+
+	return error;
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
@@ -933,11 +1067,8 @@ EXPORT_SYMBOL(kick_iocb);
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
 
 	/*
@@ -955,14 +1086,13 @@ int fastcall aio_complete(struct kiocb *
 		return 1;
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
@@ -975,34 +1105,10 @@ int fastcall aio_complete(struct kiocb *
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
-
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
+	__aio_write_evt(ctx, &event);
 
-	pr_debug("added to ring %p at [%lu]\n", iocb, tail);
+	if (iocb->ki_notify.notify != SIGEV_NONE)
+		aio_send_signal(&iocb->ki_notify);
 
 	pr_debug("%ld retries: %d of %d\n", iocb->ki_retried,
 		iocb->ki_nbytes - iocb->ki_left, iocb->ki_nbytes);
@@ -1481,8 +1587,7 @@ int fastcall io_submit_one(struct kioctx
 	ssize_t ret;
 
 	/* enforce forwards compatibility on users */
-	if (unlikely(iocb->aio_reserved1 || iocb->aio_reserved2 ||
-		     iocb->aio_reserved3)) {
+	if (unlikely(iocb->aio_reserved1)) {
 		pr_debug("EINVAL: io_submit: reserve field set\n");
 		return -EINVAL;
 	}
@@ -1491,6 +1596,7 @@ int fastcall io_submit_one(struct kioctx
 	if (unlikely(
 	    (iocb->aio_buf != (unsigned long)iocb->aio_buf) ||
 	    (iocb->aio_nbytes != (size_t)iocb->aio_nbytes) ||
+	    (iocb->aio_sigeventp != (unsigned long)iocb->aio_sigeventp) ||
 	    ((ssize_t)iocb->aio_nbytes < 0)
 	   )) {
 		pr_debug("EINVAL: io_submit: overflow check\n");
@@ -1525,6 +1631,17 @@ int fastcall io_submit_one(struct kioctx
 	INIT_LIST_HEAD(&req->ki_wait.task_list);
 	req->ki_retried = 0;
 
+	/* handle setting up the sigevent for POSIX AIO signals */
+	req->ki_notify.notify = SIGEV_NONE;
+
+	if (iocb->aio_sigeventp) {
+		ret = setup_sigevent(&req->ki_notify,
+				     (struct sigevent __user *)(unsigned long)
+				     iocb->aio_sigeventp);
+		if (ret)
+			goto out_put_req;
+	}
+
 	ret = aio_setup_iocb(req);
 
 	if (ret)
Index: linux-2.6.18-rc6/include/linux/aio_abi.h
===================================================================
--- linux-2.6.18-rc6.orig/include/linux/aio_abi.h	2006-06-18
03:49:35.000000000 +0200 +++ linux-2.6.18-rc6/include/linux/aio_abi.h
2006-09-06 16:32:17.000000000 +0200 @@ -80,8 +80,9 @@ struct iocb {
 	__u64	aio_nbytes;
 	__s64	aio_offset;
 
+	__u64	aio_sigeventp;	/* pointer to struct sigevent */
+
 	/* extra parameters */
-	__u64	aio_reserved2;	/* TODO: use this for a (struct
sigevent *) */ __u64	aio_reserved3;
 }; /* 64 bytes */
 
Index: linux-2.6.18-rc6/include/linux/aio.h
===================================================================
--- linux-2.6.18-rc6.orig/include/linux/aio.h	2006-06-18
03:49:35.000000000 +0200 +++ linux-2.6.18-rc6/include/linux/aio.h
2006-09-06 16:32:17.000000000 +0200 @@ -6,6 +6,7 @@
 #include <linux/aio_abi.h>
 
 #include <asm/atomic.h>
+#include <asm/siginfo.h>
 
 #define AIO_MAXSEGS		4
 #define AIO_KIOGRP_NR_ATOMIC	8
@@ -48,6 +49,13 @@ struct kioctx;
 #define kiocbIsKicked(iocb)	test_bit(KIF_KICKED, &(iocb)->ki_flags)
 #define kiocbIsCancelled(iocb)	test_bit(KIF_CANCELLED,
&(iocb)->ki_flags) 
+struct aio_notify {
+	pid_t			pid;
+	__u16			signo;
+	__u16			notify;
+	sigval_t		value;
+};
+
 /* is there a better place to document function pointer methods? */
 /**
  * ki_retry	-	iocb forward progress callback
@@ -115,6 +123,9 @@ struct kiocb {
 
 	struct list_head	ki_list;	/* the aio core uses this
 						 * for cancellation */
+
+	/* to notify a process on I/O event */
+	struct aio_notify	ki_notify;
 };
 
 #define is_sync_kiocb(iocb)	((iocb)->ki_key == KIOCB_SYNC_KEY)
Index: linux-2.6.18-rc6/include/linux/signal.h
===================================================================
--- linux-2.6.18-rc6.orig/include/linux/signal.h	2006-09-04
17:07:26.000000000 +0200 +++ linux-2.6.18-rc6/include/linux/signal.h
2006-09-05 16:37:23.000000000 +0200 @@ -233,6 +233,7 @@ static inline int
valid_signal(unsigned return sig <= _NSIG ? 1 : 0;
 }
 
+extern int specific_send_sig_info(int sig, struct siginfo *info, struct
task_struct *t); extern int group_send_sig_info(int sig, struct siginfo *info,
struct task_struct *p); extern int __group_send_sig_info(int, struct siginfo *,
struct task_struct *); extern long do_sigpending(void __user *, unsigned long);
Index: linux-2.6.18-rc6/kernel/signal.c
===================================================================
--- linux-2.6.18-rc6.orig/kernel/signal.c	2006-09-04 17:07:56.000000000
+0200 +++ linux-2.6.18-rc6/kernel/signal.c	2006-09-05 16:34:18.000000000
+0200 @@ -763,7 +763,7 @@ out_set:
 	(((sig) < SIGRTMIN) && sigismember(&(sigptr)->signal, (sig)))
 
 
-static int
+int
 specific_send_sig_info(int sig, struct siginfo *info, struct task_struct *t)
 {
 	int ret = 0;


-----------------------------------------------------

  Sébastien Dugué                BULL/FREC:B1-247
  phone: (+33) 476 29 77 70      Bullcom: 229-7770

  mailto:sebastien.dugue@bull.net

  Linux POSIX AIO: http://www.bullopensource.org/posix
                   http://sourceforge.net/projects/paiol
  
-----------------------------------------------------
