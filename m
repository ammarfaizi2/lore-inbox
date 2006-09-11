Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWIKJmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWIKJmY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 05:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWIKJmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 05:42:04 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:15595 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S932164AbWIKJmA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 05:42:00 -0400
Date: Mon, 11 Sep 2006 11:41:52 +0200
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: linux-kernel@vger.kernel.org
Cc: linux-aio@kvack.org, drepper@redhat.com, suparna@in.ibm.com,
       pbadari@us.ibm.com, zach.brown@oracle.com, hch@infradead.org,
       johnpol@2ka.mipt.ru, davem@davemloft.net, sebastien.dugue@bull.net
Subject: [PATCH AIO 2/2] Add listio support
Message-ID: <20060911114152.4f67e59f@frecb000686>
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 11/09/2006 11:47:34,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 11/09/2006 11:47:37,
	Serialize complete at 11/09/2006 11:47:37
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


                        POSIX listio support

  This patch adds POSIX listio completion notification support. It builds
on support provided by the aio event patch and adds an IOCB_CMD_GROUP
command to io_submit().

  The purpose of IOCB_CMD_GROUP is to group together the following requests in
the list up to the end of the list sumbitted to io_submit.

  As io_submit already accepts an array of iocbs, as part of listio submission,
the user process prepends to a list of requests an empty special aiocb with
an aio_lio_opcode of IOCB_CMD_GROUP, filling only the aio_sigevent fields.



  An IOCB_CMD_GROUP is added to the IOCB_CMD enum in include/linux/aio_abi.h

  A struct lio_event is added in include/linux/aio.h

  A struct lio_event *ki_lio is added to struct iocb in include/linux/aio.h

  In io_submit(), upon detecting such an IOCB_CMD_GROUP marker iocb, an
lio_event is created in lio_create() which contains the necessary information
for signaling a thread (signal number, pid, notify type and value) along with
a count of requests attached to this event.

        The following depicts the lio_event structure:

        struct lio_event {
                atomic_t        	lio_users;
                int             	lio_wait;
                struct aio_notify	lio_notify;
        };

  lio_users holds an atomic counter of the number of requests attached to this
lio. It is incremented with each request submitted and decremented at each
request completion. When the counter reaches 0, we send the notification.

  Each subsequent submitted request is attached to this lio_event by setting
the request kiocb->ki_lio to that lio_event (in io_submit_one()) and
incrementing the lio_users count.

  In aio_complete(), if the request is attached to an lio (ki_lio <> 0),
then lio_check() is called to decrement the lio_users count and eventually
signal the user process when all the requests in the group have completed.


  The IOCB_CMD_GROUP semantic is as follows:

       - if the associated sigevent is NULL then we want to group
         requests for the purpose of blocking on the group completion
         (LIO_WAIT sync behavior) and lio_event->lio_wait is set to 1.

       - if the associated sigevent is valid (not NULL) then we want to
         group requests for the purpose of being notified upon that
         group of requests completion (LIO_NOWAIT async behaviour).





 fs/aio.c                |  118 ++++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/aio.h     |   14 ++++-
 include/linux/aio_abi.h |    1
 3 files changed, 127 insertions(+), 6 deletions(-)

Signed-off-by: Laurent Vivier <laurent.vivier@bull.net>
Signed-off-by: Sébastien Dugué <sebastien.dugue@bull.net>

Index: linux-2.6.18-rc6/fs/aio.c
===================================================================
--- linux-2.6.18-rc6.orig/fs/aio.c	2006-09-06 16:38:10.000000000 +0200
+++ linux-2.6.18-rc6/fs/aio.c	2006-09-06 16:49:24.000000000 +0200
@@ -413,6 +413,7 @@ static struct kiocb fastcall *__aio_get_
 	req->ki_cancel = NULL;
 	req->ki_retry = NULL;
 	req->ki_dtor = NULL;
+	req->ki_lio = NULL;
 	req->private = NULL;
 	INIT_LIST_HEAD(&req->ki_run_list);
 
@@ -1016,6 +1017,69 @@ static long setup_sigevent(struct aio_no
 	return error;
 }
 
+static void lio_wait(struct kioctx *ctx, struct lio_event *lio)
+{
+       struct task_struct *tsk = current;
+       DECLARE_WAITQUEUE(wait, tsk);
+
+       add_wait_queue(&ctx->wait, &wait);
+       set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+
+       while ( atomic_read(&lio->lio_users) ) {
+               schedule();
+               set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+       }
+       __set_task_state(tsk, TASK_RUNNING);
+       remove_wait_queue(&ctx->wait, &wait);
+
+       /* Now free the lio */
+       kfree(lio);
+}
+
+static inline void lio_check(struct lio_event *lio)
+{
+	int ret;
+
+	ret = atomic_dec_and_test(&(lio->lio_users));
+
+	if (unlikely(ret) && lio->lio_notify.notify != SIGEV_NONE) {
+		/* last one -> notify process */
+		aio_send_signal(&lio->lio_notify);
+		kfree(lio);
+	}
+}
+
+static int lio_create(struct lio_event **lio, struct sigevent __user
*user_event) +{
+	int ret = 0;
+
+	if (*lio) {
+               printk (KERN_DEBUG "lio_create: already have an lio\n");
+               return 0;
+       }
+
+	*lio = kmalloc(sizeof(*lio), GFP_KERNEL);
+
+	if (!*lio)
+		return -EAGAIN;
+
+	memset (*lio, 0, sizeof(struct lio_event));
+
+	(*lio)->lio_notify.notify = SIGEV_NONE;
+
+	if (user_event)
+		/* User specified an event for this lio,
+		 * he wants to be notified upon lio completion.
+		 */
+		ret = setup_sigevent(&((*lio)->lio_notify), user_event);
+
+	else
+		/* No sigevent specified, it's an LIO_WAIT operation */
+               (*lio)->lio_wait = 1;
+
+	return ret;
+}
+
 static void __aio_write_evt(struct kioctx *ctx, struct io_event *event)
 {
 	struct aio_ring_info	*info;
@@ -1110,6 +1174,9 @@ int fastcall aio_complete(struct kiocb *
 	if (iocb->ki_notify.notify != SIGEV_NONE)
 		aio_send_signal(&iocb->ki_notify);
 
+	if (iocb->ki_lio)
+		lio_check(iocb->ki_lio);
+
 	pr_debug("%ld retries: %d of %d\n", iocb->ki_retried,
 		iocb->ki_nbytes - iocb->ki_left, iocb->ki_nbytes);
 put_rq:
@@ -1580,7 +1647,7 @@ static int aio_wake_function(wait_queue_
 }
 
 int fastcall io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
-			 struct iocb *iocb)
+			   struct iocb *iocb, struct lio_event *lio)
 {
 	struct kiocb *req;
 	struct file *file;
@@ -1642,6 +1709,9 @@ int fastcall io_submit_one(struct kioctx
 			goto out_put_req;
 	}
 
+	/* Attach this iocb to its lio */
+	req->ki_lio = lio;
+
 	ret = aio_setup_iocb(req);
 
 	if (ret)
@@ -1680,6 +1750,7 @@ asmlinkage long sys_io_submit(aio_contex
 			      struct iocb __user * __user *iocbpp)
 {
 	struct kioctx *ctx;
+	struct lio_event *lio = NULL;
 	long ret = 0;
 	int i;
 
@@ -1713,11 +1784,50 @@ asmlinkage long sys_io_submit(aio_contex
 			break;
 		}
 
-		ret = io_submit_one(ctx, user_iocb, &tmp);
-		if (ret)
-			break;
+		if (tmp.aio_lio_opcode == IOCB_CMD_GROUP) {
+
+			/* this command means that all following IO commands
+			 * are in the same group.
+			 *
+			 * Userspace either wants to be notified upon or block
until
+			 * completion of all the requests in the group.
+			 */
+			ret = lio_create(&lio,
+					 (struct sigevent __user *)(unsigned
long)
+					 tmp.aio_sigeventp);
+			if (ret)
+				break;
+
+			continue;
+		}
+
+		if (lio && ((tmp.aio_lio_opcode == IOCB_CMD_PREAD) ||
+			    (tmp.aio_lio_opcode == IOCB_CMD_PWRITE))) {
+
+			atomic_inc(&lio->lio_users);
+			ret = io_submit_one(ctx, user_iocb, &tmp, lio);
+
+			/*
+			 * If a request failed, just decrement the users count,
+			 * but go on submitting subsequent requests.
+			 *
+			 */
+			if (ret)
+				atomic_dec(&lio->lio_users);
+
+			continue;
+
+		} else {
+			ret = io_submit_one(ctx, user_iocb, &tmp, NULL);
+			if (ret)
+				break;
+		}
 	}
 
+	/* User wants to block until list completion */
+	if (lio && lio->lio_wait)
+		lio_wait(ctx, lio);
+
 	put_ioctx(ctx);
 	return i ? i : ret;
 }
Index: linux-2.6.18-rc6/include/linux/aio_abi.h
===================================================================
--- linux-2.6.18-rc6.orig/include/linux/aio_abi.h	2006-09-06
16:32:17.000000000 +0200 +++ linux-2.6.18-rc6/include/linux/aio_abi.h
2006-09-06 16:38:17.000000000 +0200 @@ -41,6 +41,7 @@ enum {
 	 * IOCB_CMD_POLL = 5,
 	 */
 	IOCB_CMD_NOOP = 6,
+	IOCB_CMD_GROUP = 7,
 };
 
 /* read() from /dev/aio returns these structures. */
Index: linux-2.6.18-rc6/include/linux/aio.h
===================================================================
--- linux-2.6.18-rc6.orig/include/linux/aio.h	2006-09-06
16:32:17.000000000 +0200 +++ linux-2.6.18-rc6/include/linux/aio.h
2006-09-06 16:38:17.000000000 +0200 @@ -56,6 +56,12 @@ struct aio_notify {
 	sigval_t		value;
 };
 
+struct lio_event {
+	atomic_t		lio_users;
+	int			lio_wait;
+	struct aio_notify	lio_notify;
+};
+
 /* is there a better place to document function pointer methods? */
 /**
  * ki_retry	-	iocb forward progress callback
@@ -111,6 +117,9 @@ struct kiocb {
 	wait_queue_t		ki_wait;
 	loff_t			ki_pos;
 
+	/* lio this iocb might be attached to */
+	struct lio_event	*ki_lio;
+
 	void			*private;
 	/* State that we remember to be able to restart/retry  */
 	unsigned short		ki_opcode;
@@ -216,12 +225,13 @@ struct mm_struct;
 extern void FASTCALL(exit_aio(struct mm_struct *mm));
 extern struct kioctx *lookup_ioctx(unsigned long ctx_id);
 extern int FASTCALL(io_submit_one(struct kioctx *ctx,
-			struct iocb __user *user_iocb, struct iocb *iocb));
+			struct iocb __user *user_iocb, struct iocb *iocb,
+			struct lio_event *lio));
 
 /* semi private, but used by the 32bit emulations: */
 struct kioctx *lookup_ioctx(unsigned long ctx_id);
 int FASTCALL(io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
-				  struct iocb *iocb));
+				  struct iocb *iocb, struct lio_event *lio));
 
 #define get_ioctx(kioctx) do {						\
 	BUG_ON(unlikely(atomic_read(&(kioctx)->users) <= 0));		\



-----------------------------------------------------

  Sébastien Dugué                BULL/FREC:B1-247
  phone: (+33) 476 29 77 70      Bullcom: 229-7770

  mailto:sebastien.dugue@bull.net

  Linux POSIX AIO: http://www.bullopensource.org/posix
                   http://sourceforge.net/projects/paiol
  
-----------------------------------------------------
