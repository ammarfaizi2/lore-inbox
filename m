Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424093AbWKIP7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424093AbWKIP7X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 10:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424094AbWKIP7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 10:59:22 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:15012 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1424093AbWKIP7S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 10:59:18 -0500
Subject: [PATCH -mm 3/3][AIO] - AIO completion signal notification
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>, Zach Brown <zach.brown@oracle.com>,
       Dave Jones <davej@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       "moi @ Bull" <sebastien.dugue@bull.net>
In-Reply-To: <1163087717.3879.34.camel@frecb000686>
References: <1163087717.3879.34.camel@frecb000686>
Date: Thu, 09 Nov 2006 16:59:06 +0100
Message-Id: <1163087946.3879.43.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/11/2006 17:06:03,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/11/2006 17:06:05,
	Serialize complete at 09/11/2006 17:06:05
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


                      AIO completion signal notification

  The current 2.6 kernel does not support notification of user space via
an RT signal upon an asynchronous IO completion. The POSIX specification
states that when an AIO request completes, a signal can be delivered to
the application as notification.

  This patch adds a struct sigevent *aio_sigeventp to the iocb.
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
	struct task_struct	*target;
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
	  save it in kiocb->ki_notify.target

	- preallocate a sigqueue for this event using sigqueue_alloc()

  Upon request completion, in aio_complete(), if notification is needed for
this request (iocb->ki_notify.notify != SIGEV_NONE), then aio_send_signal()
is called to signal the target task as follows:

	- fill in the siginfo struct to be sent to the task

	- if notify is SIGEV_THREAD_ID then send signal to specific task
	  using send_sigqueue()

	- else send signal to task group using send_5group_sigqueue()



Notes concerning sigqueue preallocation:

 To ensure reliable delivery of completion notification, the sigqueue is
preallocated in the submission path so that there is no chance it can fail
in the completion path.

 Unlike the posix-timers case (currently the single other user of sigqueue
preallocation), where the sigqueue is allocated for the lifetime of the timer
and freed at timer destruction time, the aio case is a bit more tricky due to
the async nature of the whole thing.

  In the aio case, the sigqueue exists for the lifetime of the request, therefore
it must be freed only once the signal for the request completion has been
delivered. This involves changing __sigqueue_free() to free the sigqueue when the
signal is collected if si_code is SI_ASYNCIO even if it was preallocated as well
as explicitly calling sigqueue_free() in submission and completion error paths.


 fs/aio.c                |  129 ++++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/aio.h     |   12 ++++
 include/linux/aio_abi.h |    3 -
 kernel/signal.c         |    2
 4 files changed, 141 insertions(+), 5 deletions(-)


Signed-off-by: Sébastien Dugué <sebastien.dugue@bull.net>
Signed-off-by: Laurent Vivier <laurent.vivier@bull.net>

Index: linux-2.6.19-rc5-mm1/fs/aio.c
===================================================================
--- linux-2.6.19-rc5-mm1.orig/fs/aio.c	2006-11-09 10:43:57.000000000 +0100
+++ linux-2.6.19-rc5-mm1/fs/aio.c	2006-11-09 14:34:07.000000000 +0100
@@ -416,6 +416,7 @@ static struct kiocb fastcall *__aio_get_
 	req->ki_dtor = NULL;
 	req->private = NULL;
 	req->ki_iovec = NULL;
+	req->ki_sigq = NULL;
 	INIT_LIST_HEAD(&req->ki_run_list);
 
 	/* Check if the completion queue has enough free space to
@@ -463,6 +464,11 @@ static inline void really_put_req(struct
 		req->ki_dtor(req);
 	if (req->ki_iovec != &req->ki_inline_vec)
 		kfree(req->ki_iovec);
+
+	/* Release task ref */
+	if (req->ki_notify.notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID))
+		put_task_struct(req->ki_notify.target);
+
 	kmem_cache_free(kiocb_cachep, req);
 	ctx->reqs_active--;
 
@@ -929,6 +935,97 @@ void fastcall kick_iocb(struct kiocb *io
 }
 EXPORT_SYMBOL(kick_iocb);
 
+static int aio_send_signal(struct kiocb *iocb)
+{
+	int ret;
+
+	memset(&iocb->ki_sigq->info, 0, sizeof(struct siginfo));
+
+	iocb->ki_sigq->info.si_signo = iocb->ki_notify.signo;
+	iocb->ki_sigq->info.si_errno = 0;
+	iocb->ki_sigq->info.si_code = SI_ASYNCIO;
+	iocb->ki_sigq->info.si_pid = 0;
+	iocb->ki_sigq->info.si_uid = 0;
+	iocb->ki_sigq->info.si_value = iocb->ki_notify.value;
+
+	if (iocb->ki_notify.notify & SIGEV_THREAD_ID)
+		ret = send_sigqueue(iocb->ki_notify.signo, iocb->ki_sigq,
+				    iocb->ki_notify.target);
+	else
+		ret = send_group_sigqueue(iocb->ki_notify.signo, iocb->ki_sigq,
+					  iocb->ki_notify.target);
+
+	return ret;
+}
+
+static long aio_setup_sigevent(struct kiocb *iocb,
+			       struct sigevent __user *user_event)
+{
+	int error = 0;
+	sigevent_t event;
+	struct task_struct *target;
+	unsigned long flags;
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
+	iocb->ki_notify.notify = event.sigev_notify;
+	iocb->ki_notify.signo = event.sigev_signo;
+	iocb->ki_notify.value = event.sigev_value;
+
+	/* Now get the notification target */
+	read_lock(&tasklist_lock);
+
+	if ((target = good_sigevent(&event))) {
+
+		spin_lock_irqsave(&target->sighand->siglock, flags);
+
+		if (!(target->flags & PF_EXITING)) {
+			iocb->ki_notify.target = target;
+
+			spin_unlock_irqrestore(&target->sighand->siglock, flags);
+
+			/*
+			 * Get a ref on the task. It is dropped in really_put_req()
+			 * when we're done with the iocb, be it from the normal
+			 * completion path, the cancellation path or an error path.
+			 */
+			if (iocb->ki_notify.notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID))
+				get_task_struct(target);
+		} else {
+			spin_unlock_irqrestore(&target->sighand->siglock, flags);
+			error = -EINVAL;
+		}
+	} else
+		error = -EINVAL;
+
+	read_unlock(&tasklist_lock);
+
+	if (!error) {
+		/*
+		 * Alloc a sigqueue for this request
+		 *
+		 * NOTE: we cannot free the sigqueue in the completion path as
+		 * the signal may not have been delivered to the target task.
+		 * Therefore it has to be freed in __sigqueue_free() when the
+		 * signal is collected if si_code is SI_ASYNCIO.
+		 */
+		if (unlikely(!(iocb->ki_sigq = sigqueue_alloc())))
+			error =  -EAGAIN;
+	}
+
+
+	return error;
+}
+
 /* aio_complete
  *	Called when the io request on the given iocb is complete.
  *	Returns true if this is the last user of the request.  The 
@@ -976,8 +1073,11 @@ int fastcall aio_complete(struct kiocb *
 	 * cancelled requests don't get events, userland was given one
 	 * when the event got cancelled.
 	 */
-	if (kiocbIsCancelled(iocb))
+	if (kiocbIsCancelled(iocb)) {
+		if (iocb->ki_sigq)
+			sigqueue_free(iocb->ki_sigq);
 		goto put_rq;
+	}
 
 	ring = kmap_atomic(info->ring_pages[0], KM_IRQ1);
 
@@ -1008,6 +1108,14 @@ int fastcall aio_complete(struct kiocb *
 
 	pr_debug("added to ring %p at [%lu]\n", iocb, tail);
 
+	if (iocb->ki_notify.notify != SIGEV_NONE) {
+		ret = aio_send_signal(iocb);
+
+		/* If signal generation failed, release the sigqueue */
+		if (ret)
+			sigqueue_free(iocb->ki_sigq);
+	}
+
 	pr_debug("%ld retries: %zd of %zd\n", iocb->ki_retried,
 		iocb->ki_nbytes - iocb->ki_left, iocb->ki_nbytes);
 put_rq:
@@ -1549,8 +1657,7 @@ int fastcall io_submit_one(struct kioctx
 	ssize_t ret;
 
 	/* enforce forwards compatibility on users */
-	if (unlikely(iocb->aio_reserved1 || iocb->aio_reserved2 ||
-		     iocb->aio_reserved3)) {
+	if (unlikely(iocb->aio_reserved1)) {
 		pr_debug("EINVAL: io_submit: reserve field set\n");
 		return -EINVAL;
 	}
@@ -1559,6 +1666,7 @@ int fastcall io_submit_one(struct kioctx
 	if (unlikely(
 	    (iocb->aio_buf != (unsigned long)iocb->aio_buf) ||
 	    (iocb->aio_nbytes != (size_t)iocb->aio_nbytes) ||
+	    (iocb->aio_sigeventp != (unsigned long)iocb->aio_sigeventp) ||
 	    ((ssize_t)iocb->aio_nbytes < 0)
 	   )) {
 		pr_debug("EINVAL: io_submit: overflow check\n");
@@ -1593,6 +1701,17 @@ int fastcall io_submit_one(struct kioctx
 	INIT_LIST_HEAD(&req->ki_wait.task_list);
 	req->ki_retried = 0;
 
+	/* handle setting up the sigevent for POSIX AIO signals */
+	req->ki_notify.notify = SIGEV_NONE;
+
+	if (iocb->aio_sigeventp) {
+		ret = aio_setup_sigevent(req,
+				     (struct sigevent __user *)(unsigned long)
+				     iocb->aio_sigeventp);
+		if (ret)
+			goto out_put_req;
+	}
+
 	ret = aio_setup_iocb(req);
 
 	if (ret)
@@ -1610,6 +1729,10 @@ int fastcall io_submit_one(struct kioctx
 	return 0;
 
 out_put_req:
+	/* Undo the sigqueue alloc if someting went bad */
+	if (req->ki_sigq)
+		sigqueue_free(req->ki_sigq);
+
 	aio_put_req(req);	/* drop extra ref to req */
 	aio_put_req(req);	/* drop i/o ref to req */
 	return ret;
Index: linux-2.6.19-rc5-mm1/include/linux/aio_abi.h
===================================================================
--- linux-2.6.19-rc5-mm1.orig/include/linux/aio_abi.h	2006-11-09 10:43:57.000000000 +0100
+++ linux-2.6.19-rc5-mm1/include/linux/aio_abi.h	2006-11-09 10:46:25.000000000 +0100
@@ -82,8 +82,9 @@ struct iocb {
 	__u64	aio_nbytes;
 	__s64	aio_offset;
 
+	__u64	aio_sigeventp;	/* pointer to struct sigevent */
+
 	/* extra parameters */
-	__u64	aio_reserved2;	/* TODO: use this for a (struct sigevent *) */
 	__u64	aio_reserved3;
 }; /* 64 bytes */
 
Index: linux-2.6.19-rc5-mm1/include/linux/aio.h
===================================================================
--- linux-2.6.19-rc5-mm1.orig/include/linux/aio.h	2006-11-09 10:46:18.000000000 +0100
+++ linux-2.6.19-rc5-mm1/include/linux/aio.h	2006-11-09 14:34:09.000000000 +0100
@@ -7,6 +7,7 @@
 #include <linux/uio.h>
 
 #include <asm/atomic.h>
+#include <asm/siginfo.h>
 
 #define AIO_MAXSEGS		4
 #define AIO_KIOGRP_NR_ATOMIC	8
@@ -49,6 +50,13 @@ struct kioctx;
 #define kiocbIsKicked(iocb)	test_bit(KIF_KICKED, &(iocb)->ki_flags)
 #define kiocbIsCancelled(iocb)	test_bit(KIF_CANCELLED, &(iocb)->ki_flags)
 
+struct aio_notify {
+	struct task_struct	*target;
+	__u16			signo;
+	__u16			notify;
+	sigval_t		value;
+};
+
 /* is there a better place to document function pointer methods? */
 /**
  * ki_retry	-	iocb forward progress callback
@@ -118,6 +126,10 @@ struct kiocb {
 
 	struct list_head	ki_list;	/* the aio core uses this
 						 * for cancellation */
+
+	/* to notify a process on I/O event */
+	struct aio_notify	ki_notify;
+	struct sigqueue		*ki_sigq;
 };
 
 #define is_sync_kiocb(iocb)	((iocb)->ki_key == KIOCB_SYNC_KEY)
Index: linux-2.6.19-rc5-mm1/kernel/signal.c
===================================================================
--- linux-2.6.19-rc5-mm1.orig/kernel/signal.c	2006-11-09 10:46:23.000000000 +0100
+++ linux-2.6.19-rc5-mm1/kernel/signal.c	2006-11-09 10:46:25.000000000 +0100
@@ -297,7 +297,7 @@ static struct sigqueue *__sigqueue_alloc
 
 static void __sigqueue_free(struct sigqueue *q)
 {
-	if (q->flags & SIGQUEUE_PREALLOC)
+	if (q->flags & SIGQUEUE_PREALLOC && q->info.si_code != SI_ASYNCIO)
 		return;
 	atomic_dec(&q->user->sigpending);
 	free_uid(q->user);


