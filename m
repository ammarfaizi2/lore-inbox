Return-Path: <linux-kernel-owner+w=401wt.eu-S932355AbXADJbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbXADJbV (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 04:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbXADJbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 04:31:21 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:36782 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932350AbXADJbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 04:31:19 -0500
Date: Thu, 4 Jan 2007 15:08:43 +0530
From: Bharata B Rao <bharata@in.ibm.com>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: linux-aio@kvack.org, akpm@osdl.org, drepper@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com, mingo@elte.hu,
       =?iso-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Subject: [PATCHSET 3][PATCH 4/5][AIO] - AIO completion signal notification
Message-ID: <20070104093843.GH9608@in.ibm.com>
Reply-To: bharata@in.ibm.com
References: <20061227153855.GA25898@in.ibm.com> <20070104092733.GD9608@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ILuaRSyQpoVaJ1HG"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20070104092733.GD9608@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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
application using those sigevent parameters. If SIGEV_NONE has been specifi=
ed,
then the old behaviour is retained and the application must rely on polling
the completion queue using io_getevents().


  A struct sigevent *aio_sigeventp field is added to struct iocb in
include/linux/aio_abi.h

  A struct aio_notify containing the sigevent parameters is defined in aio.=
h:

  struct aio_notify {
	struct task_struct	*target;
	__u16			signo;
	__u16			notify;
	sigval_t		value;
  };

  A struct aio_notify ki_notify is added to struct kiocb in include/linux/a=
io.h

  In io_submit_one(), if the application provided a sigevent then
setup_sigevent() is called which does the following:

	- check access to the user sigevent and make a local copy

	- if the requested notification is SIGEV_NONE, then nothing to do

	- fill in the kiocb->ki_notify fields (notify, signo, value)

	- check sigevent consistency, get the signal target task and
	  save it in kiocb->ki_notify.target

	- preallocate a sigqueue for this event using sigqueue_alloc()

  Upon request completion, in aio_complete(), if notification is needed for
this request (iocb->ki_notify.notify !=3D SIGEV_NONE), then
aio_send_signal is called to signal the target task as follows:

	- fill in the siginfo struct to be sent to the task

	- if notify is SIGEV_THREAD_ID then send signal to specific task
	  using send_sigqueue()

	- else send signal to task group using send_5group_sigqueue()



Notes concerning sigqueue preallocation:

 To ensure reliable delivery of completion notification, the sigqueue is
preallocated in the submission path so that there is no chance it can fail
in the completion path.

 Unlike the posix-timers case (currently the single other user of sigqueue
preallocation), where the sigqueue is allocated for the lifetime of the
timer and freed at timer destruction time, the aio case is a bit more tricky
due to the async nature of the whole thing.

  In the aio case, the sigqueue exists for the lifetime of the request,
therefore it must be freed only once the signal for the request completion
has been delivered. This involves changing __sigqueue_free() to free the
sigqueue when the signal is collected if si_code is SI_ASYNCIO even if it
was preallocated as well as explicitly calling sigqueue_free() in submission
and completion error paths.

--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="aio-notify-sig.patch"
Content-Transfer-Encoding: 8bit


From: Sébastien Dugué <sebastien.dugue@bull.net>

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

Signed-off-by: Sébastien Dugué <sebastien.dugue@bull.net>
Signed-off-by: Laurent Vivier <laurent.vivier@bull.net>
Signed-off-by: Bharata B Rao <bharata@in.ibm.com>
---

 fs/aio.c                |  115 ++++++++++++++++++++++++++++++++++++++++++++++--
 fs/compat.c             |   18 +++++++
 include/linux/aio.h     |   12 +++++
 include/linux/aio_abi.h |    3 -
 kernel/signal.c         |    2 
 5 files changed, 144 insertions(+), 6 deletions(-)

diff -puN fs/aio.c~aio-notify-sig fs/aio.c
--- linux-2.6.20-rc2/fs/aio.c~aio-notify-sig	2007-01-03 10:27:12.000000000 +0530
+++ linux-2.6.20-rc2-bharata/fs/aio.c	2007-01-04 13:19:50.000000000 +0530
@@ -415,6 +415,7 @@ static struct kiocb fastcall *__aio_get_
 	req->ki_dtor = NULL;
 	req->private = NULL;
 	req->ki_iovec = NULL;
+	req->ki_notify.sigq = NULL;
 	INIT_LIST_HEAD(&req->ki_run_list);
 
 	/* Check if the completion queue has enough free space to
@@ -461,6 +462,12 @@ static inline void really_put_req(struct
 		req->ki_dtor(req);
 	if (req->ki_iovec != &req->ki_inline_vec)
 		kfree(req->ki_iovec);
+
+	/* Release task ref */
+	if (req->ki_notify.notify == SIGEV_THREAD_ID ||
+	    req->ki_notify.notify == SIGEV_SIGNAL)
+		put_task_struct(req->ki_notify.target);
+
 	kmem_cache_free(kiocb_cachep, req);
 	ctx->reqs_active--;
 
@@ -911,6 +918,79 @@ void fastcall kick_iocb(struct kiocb *io
 }
 EXPORT_SYMBOL(kick_iocb);
 
+static int aio_send_signal(struct aio_notify *notify)
+{
+	struct sigqueue *sigq = notify->sigq;
+	struct siginfo *info = &sigq->info;
+	int ret;
+
+	memset(info, 0, sizeof(struct siginfo));
+
+	info->si_signo = notify->signo;
+	info->si_errno = 0;
+	info->si_code = SI_ASYNCIO;
+	info->si_pid = 0;
+	info->si_uid = 0;
+	info->si_value = notify->value;
+
+	if (notify->notify & SIGEV_THREAD_ID)
+		ret = send_sigqueue(notify->signo, sigq, notify->target);
+	else
+		ret = send_group_sigqueue(notify->signo, sigq, notify->target);
+
+	return ret;
+}
+
+static long aio_setup_sigevent(struct aio_notify *notify,
+			       struct sigevent __user *user_event)
+{
+	sigevent_t event;
+	struct task_struct *target;
+
+	if (copy_from_user(&event, user_event, sizeof (event)))
+		return -EFAULT;
+
+	if (event.sigev_notify == SIGEV_NONE)
+		return 0;
+
+	notify->notify = event.sigev_notify;
+	notify->signo = event.sigev_signo;
+	notify->value = event.sigev_value;
+
+	read_lock(&tasklist_lock);
+	target = good_sigevent(&event);
+
+	if (unlikely(!target || (target->flags & PF_EXITING)))
+		goto out_unlock;
+
+	/*
+	 * At this point, we know that notify is either SIGEV_SIGNAL or
+	 * SIGEV_THREAD_ID and the target task is valid. So get a reference
+	 * on the task, it will be dropped in really_put_req() when
+	 * we're done with the request.
+	 */
+	get_task_struct(target);
+	notify->target = target;
+	read_unlock(&tasklist_lock);
+
+	/*
+	 * NOTE: we cannot free the sigqueue in the completion path as
+	 * the signal may not have been delivered to the target task.
+	 * Therefore it has to be freed in __sigqueue_free() when the
+	 * signal is collected if si_code is SI_ASYNCIO.
+	 */
+	notify->sigq = sigqueue_alloc();
+
+	if (unlikely(!notify->sigq))
+		return -EAGAIN;
+
+	return 0;
+
+out_unlock:
+	read_unlock(&tasklist_lock);
+	return -EINVAL;
+}
+
 /* aio_complete
  *	Called when the io request on the given iocb is complete.
  *	Returns true if this is the last user of the request.  The 
@@ -958,8 +1038,11 @@ int fastcall aio_complete(struct kiocb *
 	 * cancelled requests don't get events, userland was given one
 	 * when the event got cancelled.
 	 */
-	if (kiocbIsCancelled(iocb))
+	if (kiocbIsCancelled(iocb)) {
+		if (iocb->ki_notify.sigq)
+			sigqueue_free(iocb->ki_notify.sigq);
 		goto put_rq;
+	}
 
 	ring = kmap_atomic(info->ring_pages[0], KM_IRQ1);
 
@@ -989,6 +1072,14 @@ int fastcall aio_complete(struct kiocb *
 	kunmap_atomic(ring, KM_IRQ1);
 
 	pr_debug("added to ring %p at [%lu]\n", iocb, tail);
+
+	if (iocb->ki_notify.notify != SIGEV_NONE) {
+		ret = aio_send_signal(&iocb->ki_notify);
+
+		/* If signal generation failed, release the sigqueue */
+		if (ret)
+			sigqueue_free(iocb->ki_notify.sigq);
+	}
 put_rq:
 	/* everything turned out well, dispose of the aiocb. */
 	rcu_read_lock();
@@ -1528,8 +1619,7 @@ int fastcall io_submit_one(struct kioctx
 	ssize_t ret;
 
 	/* enforce forwards compatibility on users */
-	if (unlikely(iocb->aio_reserved1 || iocb->aio_reserved2 ||
-		     iocb->aio_reserved3)) {
+	if (unlikely(iocb->aio_reserved1 || iocb->aio_reserved3)) {
 		pr_debug("EINVAL: io_submit: reserve field set\n");
 		return -EINVAL;
 	}
@@ -1538,6 +1628,7 @@ int fastcall io_submit_one(struct kioctx
 	if (unlikely(
 	    (iocb->aio_buf != (unsigned long)iocb->aio_buf) ||
 	    (iocb->aio_nbytes != (size_t)iocb->aio_nbytes) ||
+	    (iocb->aio_sigeventp != (unsigned long)iocb->aio_sigeventp) ||
 	    ((ssize_t)iocb->aio_nbytes < 0)
 	   )) {
 		pr_debug("EINVAL: io_submit: overflow check\n");
@@ -1571,10 +1662,21 @@ int fastcall io_submit_one(struct kioctx
 	init_waitqueue_func_entry(&req->ki_wait, aio_wake_function);
 	INIT_LIST_HEAD(&req->ki_wait.task_list);
 
+	/* handle setting up the sigevent for POSIX AIO signals */
+	req->ki_notify.notify = SIGEV_NONE;
+
+	if (iocb->aio_sigeventp) {
+		ret = aio_setup_sigevent(&req->ki_notify,
+					 (struct sigevent __user *)(unsigned long)
+					 iocb->aio_sigeventp);
+		if (ret)
+			goto out_put_req;
+	}
+
 	ret = aio_setup_iocb(req);
 
 	if (ret)
-		goto out_put_req;
+		goto out_sigqfree;
 
 	spin_lock_irq(&ctx->ctx_lock);
 	aio_run_iocb(req);
@@ -1587,6 +1689,11 @@ int fastcall io_submit_one(struct kioctx
 	aio_put_req(req);	/* drop extra ref to req */
 	return 0;
 
+out_sigqfree:
+	/* Undo the sigqueue alloc if someting went bad */
+	if (req->ki_notify.sigq)
+		sigqueue_free(req->ki_notify.sigq);
+
 out_put_req:
 	aio_put_req(req);	/* drop extra ref to req */
 	aio_put_req(req);	/* drop i/o ref to req */
diff -puN fs/compat.c~aio-notify-sig fs/compat.c
--- linux-2.6.20-rc2/fs/compat.c~aio-notify-sig	2007-01-03 10:27:12.000000000 +0530
+++ linux-2.6.20-rc2-bharata/fs/compat.c	2007-01-04 13:19:50.000000000 +0530
@@ -665,6 +665,7 @@ compat_sys_io_submit(aio_context_t ctx_i
 		compat_uptr_t uptr;
 		struct iocb __user *user_iocb;
 		struct iocb tmp;
+		struct compat_sigevent __user *uevent;
 
 		if (unlikely(get_user(uptr, iocb + i))) {
 			ret = -EFAULT;
@@ -678,6 +679,23 @@ compat_sys_io_submit(aio_context_t ctx_i
 			break;
 		}
 
+		uevent = (struct compat_sigevent __user *)tmp.aio_sigeventp;
+
+		if (uevent) {
+			struct sigevent __user *event = NULL;
+			struct sigevent kevent;
+
+			event = compat_alloc_user_space(sizeof(*event));
+
+			if (get_compat_sigevent(&kevent, uevent) ||
+			    copy_to_user(event, &kevent, sizeof(*event))) {
+				ret = -EFAULT;
+				break;
+			}
+
+			tmp.aio_sigeventp = (__u64)event;
+		}
+
 		ret = io_submit_one(ctx, user_iocb, &tmp);
 		if (ret)
 			break;
diff -puN include/linux/aio_abi.h~aio-notify-sig include/linux/aio_abi.h
--- linux-2.6.20-rc2/include/linux/aio_abi.h~aio-notify-sig	2007-01-03 10:27:12.000000000 +0530
+++ linux-2.6.20-rc2-bharata/include/linux/aio_abi.h	2007-01-04 13:19:50.000000000 +0530
@@ -82,8 +82,9 @@ struct iocb {
 	__u64	aio_nbytes;
 	__s64	aio_offset;
 
+	__u64	aio_sigeventp;	/* pointer to struct sigevent */
+
 	/* extra parameters */
-	__u64	aio_reserved2;	/* TODO: use this for a (struct sigevent *) */
 	__u64	aio_reserved3;
 }; /* 64 bytes */
 
diff -puN include/linux/aio.h~aio-notify-sig include/linux/aio.h
--- linux-2.6.20-rc2/include/linux/aio.h~aio-notify-sig	2007-01-03 10:27:12.000000000 +0530
+++ linux-2.6.20-rc2-bharata/include/linux/aio.h	2007-01-04 13:19:50.000000000 +0530
@@ -7,6 +7,7 @@
 #include <linux/uio.h>
 
 #include <asm/atomic.h>
+#include <asm/siginfo.h>
 
 #define AIO_MAXSEGS		4
 #define AIO_KIOGRP_NR_ATOMIC	8
@@ -49,6 +50,14 @@ struct kioctx;
 #define kiocbIsKicked(iocb)	test_bit(KIF_KICKED, &(iocb)->ki_flags)
 #define kiocbIsCancelled(iocb)	test_bit(KIF_CANCELLED, &(iocb)->ki_flags)
 
+struct aio_notify {
+	struct task_struct	*target;
+	__u16			signo;
+	__u16			notify;
+	sigval_t		value;
+	struct sigqueue		*sigq;
+};
+
 /* is there a better place to document function pointer methods? */
 /**
  * ki_retry	-	iocb forward progress callback
@@ -118,6 +127,9 @@ struct kiocb {
 
 	struct list_head	ki_list;	/* the aio core uses this
 						 * for cancellation */
+
+	/* to notify a process on I/O event */
+	struct aio_notify	ki_notify;
 };
 
 #define is_sync_kiocb(iocb)	((iocb)->ki_key == KIOCB_SYNC_KEY)
diff -puN kernel/signal.c~aio-notify-sig kernel/signal.c
--- linux-2.6.20-rc2/kernel/signal.c~aio-notify-sig	2007-01-03 10:27:12.000000000 +0530
+++ linux-2.6.20-rc2-bharata/kernel/signal.c	2007-01-03 10:27:12.000000000 +0530
@@ -297,7 +297,7 @@ static struct sigqueue *__sigqueue_alloc
 
 static void __sigqueue_free(struct sigqueue *q)
 {
-	if (q->flags & SIGQUEUE_PREALLOC)
+	if (q->flags & SIGQUEUE_PREALLOC && q->info.si_code != SI_ASYNCIO)
 		return;
 	atomic_dec(&q->user->sigpending);
 	free_uid(q->user);
_

--ILuaRSyQpoVaJ1HG--
