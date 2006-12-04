Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937149AbWLDQ5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937149AbWLDQ5Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937150AbWLDQ5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:57:16 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:37998 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937149AbWLDQ5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:57:14 -0500
Date: Mon, 4 Dec 2006 22:32:03 +0530
From: Bharata B Rao <bharata@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, linux-aio@kvack.org,
       suparna@in.ibm.com, Zach Brown <zach.brown@oracle.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>, sebastien.dugue@bull.net
Subject: [RFC] AIO: listio support - syscall approach
Message-ID: <20061204170203.GA27379@in.ibm.com>
Reply-To: bharata@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have modified the listio support patch by Sebastien to provide
the listio support through a new system call.

long lio_submit(aio_context_t ctx_id, int mode, long nr,
	struct iocb __user * __user *iocbpp, struct sigevent __user *event)

More details about the system call appears within the patch itself.

Sebastien had taken the approach of overloading the io_submit() with
new aio_lio_opcode of IOCB_CMD_GROUP to support the listio behaviour.
And this is an alternative approach for supporting listio.

Would this system call approach be agreeable ?

Would it make sense to add another argument to support partial
completion notification ? i,e., generate a notification when a minimum
number of ios complete. Would such a feature be desirable ?

Note that I have only done some minimal testing of this on i386 using
libposix-aio library. Haven't yet tested the compat stuff.

Comments welcome.

Regards,
Bharata.
--

This patch provides POSIX listio support by means of a new system call.

long lio_submit(aio_context_t ctx_id, int mode, long nr,
	struct iocb __user * __user *iocbpp, struct sigevent __user *event)

This system call is similar to the io_submit() system call, but takes
two more arguments.

'mode' argument can be LIO_WAIT or LIO_NOWAIT.

'event' argument specifies the signal notification mechanism.

This patch is built on support provided by the aio signal notification
patch by Sebastien. The following two structures together provide
the support for grouping iocbs belonging to a list (lio).

struct aio_notify {
	struct task_struct	*target;
	__u16			signo;
	__u16			notify;
	sigval_t		value;
	struct sigqueue		*sigq;
};

struct lio_event {
	atomic_t		lio_users;
	struct aio_notify	lio_notify;
};

A single lio_event struct is maintained for the list of iocbs.
lio_users holds the number of requests attached to this lio and lio_notify
has the necessary information for generating completion notification
signal.

If the mode is LIO_WAIT, the event argument is ignored and the system
call waits until all the requests of the lio are completed.

If the mode is LIO_NOWAIT, the system call returns immediately after
submitting the io requests and may optionally notify the process on
list io completion depending on the event argument.

This patch applies on top of 1st four AIO completion signal
notification v4 patches by Sebastien Dugue.
(http://lkml.org/lkml/2006/11/30/223). While Sebastien takes the
IOCB_CMD_GROUP approach, this patch introduces a separate syscall
to provide listio support.

Signed-off-by: Sébastien Dugué <sebastien.dugue@bull.net>
Signed-off-by: Laurent Vivier <laurent.vivier@bull.net>
Signed-off-by: Bharata B Rao <bharata@in.ibm.com>
---

 arch/i386/kernel/syscall_table.S |    1 
 fs/aio.c                         |  175 ++++++++++++++++++++++++++++++++++-----
 fs/compat.c                      |  111 ++++++++++++++++++++----
 include/asm-i386/unistd.h        |    3 
 include/linux/aio.h              |   15 ++-
 include/linux/aio_abi.h          |    5 +
 include/linux/syscalls.h         |    2 
 7 files changed, 269 insertions(+), 43 deletions(-)

diff -puN fs/aio.c~aio-listio-support fs/aio.c
--- linux-2.6.19-rc6-mm2/fs/aio.c~aio-listio-support	2006-12-01 09:50:56.000000000 +0530
+++ linux-2.6.19-rc6-mm2-bharata/fs/aio.c	2006-12-01 17:00:50.000000000 +0530
@@ -413,6 +413,7 @@ static struct kiocb fastcall *__aio_get_
 	req->ki_ctx = ctx;
 	req->ki_cancel = NULL;
 	req->ki_retry = NULL;
+	req->ki_lio = NULL;
 	req->ki_dtor = NULL;
 	req->private = NULL;
 	req->ki_iovec = NULL;
@@ -1009,6 +1010,59 @@ out_unlock:
 	return -EINVAL;
 }
 
+void lio_check(struct lio_event *lio)
+{
+	int ret;
+
+	ret = atomic_dec_and_test(&lio->lio_users);
+
+	if (unlikely(ret) && lio->lio_notify.notify != SIGEV_NONE) {
+		/* last one -> notify process */
+		if (aio_send_signal(&lio->lio_notify))
+			sigqueue_free(lio->lio_notify.sigq);
+		kfree(lio);
+	}
+}
+
+struct lio_event *lio_create(struct sigevent __user *user_event,
+			int mode)
+{
+	int ret = 0;
+	struct lio_event *lio = NULL;
+
+	if (unlikely((mode == LIO_NOWAIT) && !user_event))
+		return lio;
+
+	lio = kzalloc(sizeof(*lio), GFP_KERNEL);
+
+	if (!lio)
+		return ERR_PTR(-EAGAIN);
+
+	/*
+	 * Grab an initial ref on the lio to avoid races between
+	 * submission and completion.
+	 */
+	atomic_set(&lio->lio_users, 1);
+
+	lio->lio_notify.notify = SIGEV_NONE;
+
+	/* sigevent argument is ignored with LIO_WAIT */
+	if (user_event && (mode == LIO_NOWAIT)) {
+		/*
+		 * User specified an event for this lio,
+		 * he wants to be notified upon lio completion.
+		 */
+		ret = aio_setup_sigevent(&lio->lio_notify, user_event);
+
+		if (ret) {
+			kfree(lio);
+			return ERR_PTR(ret);
+		}
+	}
+
+	return lio;
+}
+
 /* aio_complete
  *	Called when the io request on the given iocb is complete.
  *	Returns true if this is the last user of the request.  The 
@@ -1057,6 +1111,9 @@ int fastcall aio_complete(struct kiocb *
 	 * when the event got cancelled.
 	 */
 	if (kiocbIsCancelled(iocb)) {
+		if (iocb->ki_lio)
+			lio_check(iocb->ki_lio);
+
 		if (iocb->ki_notify.sigq)
 			sigqueue_free(iocb->ki_notify.sigq);
 		goto put_rq;
@@ -1099,6 +1156,9 @@ int fastcall aio_complete(struct kiocb *
 			sigqueue_free(iocb->ki_notify.sigq);
 	}
 
+	if (iocb->ki_lio)
+		lio_check(iocb->ki_lio);
+
 	pr_debug("%ld retries: %zd of %zd\n", iocb->ki_retried,
 		iocb->ki_nbytes - iocb->ki_left, iocb->ki_nbytes);
 put_rq:
@@ -1633,7 +1693,7 @@ static int aio_wake_function(wait_queue_
 }
 
 int fastcall io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
-			 struct iocb *iocb)
+			 struct iocb *iocb, struct lio_event *lio)
 {
 	struct kiocb *req;
 	struct file *file;
@@ -1695,6 +1755,9 @@ int fastcall io_submit_one(struct kioctx
 			goto out_put_req;
 	}
 
+	/* Attach this iocb to its lio */
+	req->ki_lio = lio;
+
 	ret = aio_setup_iocb(req);
 
 	if (ret)
@@ -1722,6 +1785,48 @@ out_put_req:
 	return ret;
 }
 
+static int io_submit_group(struct kioctx *ctx, long nr,
+	struct iocb __user * __user *iocbpp, struct lio_event *lio)
+{
+	int i;
+	long ret = 0;
+
+	/*
+	 * AKPM: should this return a partial result if some of the IOs were
+	 * successfully submitted?
+	 */
+	for (i = 0; i < nr; i++) {
+		struct iocb __user *user_iocb;
+		struct iocb tmp;
+
+		if (unlikely(__get_user(user_iocb, iocbpp + i))) {
+			ret = -EFAULT;
+			break;
+		}
+
+		if (unlikely(copy_from_user(&tmp, user_iocb, sizeof(tmp)))) {
+			ret = -EFAULT;
+			break;
+		}
+
+		if (lio)
+			atomic_inc(&lio->lio_users);
+
+		ret = io_submit_one(ctx, user_iocb, &tmp, lio);
+		if (ret) {
+			if (lio) {
+				/*
+				 * In case of listio, continue with
+				 * the subsequent requests
+				 */
+				atomic_dec(&lio->lio_users);
+			} else
+				break;
+		}
+	}
+	return i ? i : ret;
+}
+
 /* sys_io_submit:
  *	Queue the nr iocbs pointed to by iocbpp for processing.  Returns
  *	the number of iocbs queued.  May return -EINVAL if the aio_context
@@ -1739,7 +1844,6 @@ asmlinkage long sys_io_submit(aio_contex
 {
 	struct kioctx *ctx;
 	long ret = 0;
-	int i;
 
 	if (unlikely(nr < 0))
 		return -EINVAL;
@@ -1753,31 +1857,60 @@ asmlinkage long sys_io_submit(aio_contex
 		return -EINVAL;
 	}
 
-	/*
-	 * AKPM: should this return a partial result if some of the IOs were
-	 * successfully submitted?
-	 */
-	for (i=0; i<nr; i++) {
-		struct iocb __user *user_iocb;
-		struct iocb tmp;
+	ret = io_submit_group(ctx, nr, iocbpp, NULL);
 
-		if (unlikely(__get_user(user_iocb, iocbpp + i))) {
-			ret = -EFAULT;
-			break;
-		}
+	put_ioctx(ctx);
+	return ret;
+}
 
-		if (unlikely(copy_from_user(&tmp, user_iocb, sizeof(tmp)))) {
-			ret = -EFAULT;
-			break;
-		}
+asmlinkage long sys_lio_submit(aio_context_t ctx_id, int mode, long nr,
+	struct iocb __user * __user *iocbpp, struct sigevent __user *event)
+{
+	struct kioctx *ctx;
+	struct lio_event *lio = NULL;
+	long ret = 0;
 
-		ret = io_submit_one(ctx, user_iocb, &tmp);
-		if (ret)
-			break;
+	if (unlikely(nr < 0))
+		return -EINVAL;
+
+	if (unlikely(!access_ok(VERIFY_READ, iocbpp, (nr*sizeof(*iocbpp)))))
+		return -EFAULT;
+
+	ctx = lookup_ioctx(ctx_id);
+	if (unlikely(!ctx)) {
+		pr_debug("EINVAL: lio_submit: invalid context id\n");
+		return -EINVAL;
+	}
+
+	lio = lio_create(event, mode);
+
+	ret = PTR_ERR(lio);
+	if (IS_ERR(lio))
+		goto out_put_ctx;
+
+	ret = io_submit_group(ctx, nr, iocbpp, lio);
+
+	/* If we failed to submit even one request just return */
+	if (ret < 0 ) {
+		if (lio)
+			kfree(lio);
+		goto out_put_ctx;
+	}
+
+	/*
+	 * Drop extra ref on the lio now that we're done submitting requests.
+	 */
+	if (lio)
+		lio_check(lio);
+
+	if (mode == LIO_WAIT) {
+		wait_event(ctx->wait, atomic_read(&lio->lio_users) == 0);
+		kfree(lio);
 	}
 
+out_put_ctx:
 	put_ioctx(ctx);
-	return i ? i : ret;
+	return ret;
 }
 
 /* lookup_kiocb
diff -puN include/linux/aio_abi.h~aio-listio-support include/linux/aio_abi.h
--- linux-2.6.19-rc6-mm2/include/linux/aio_abi.h~aio-listio-support	2006-12-01 11:12:30.000000000 +0530
+++ linux-2.6.19-rc6-mm2-bharata/include/linux/aio_abi.h	2006-12-01 11:13:04.000000000 +0530
@@ -45,6 +45,11 @@ enum {
 	IOCB_CMD_PWRITEV = 8,
 };
 
+enum {
+	LIO_WAIT = 0,
+	LIO_NOWAIT = 1,
+};
+
 /* read() from /dev/aio returns these structures. */
 struct io_event {
 	__u64		data;		/* the data field from the iocb */
diff -puN include/linux/aio.h~aio-listio-support include/linux/aio.h
--- linux-2.6.19-rc6-mm2/include/linux/aio.h~aio-listio-support	2006-12-01 11:14:01.000000000 +0530
+++ linux-2.6.19-rc6-mm2-bharata/include/linux/aio.h	2006-12-01 11:19:10.000000000 +0530
@@ -58,6 +58,11 @@ struct aio_notify {
 	struct sigqueue		*sigq;
 };
 
+struct lio_event {
+	atomic_t		lio_users;
+	struct aio_notify	lio_notify;
+};
+
 /* is there a better place to document function pointer methods? */
 /**
  * ki_retry	-	iocb forward progress callback
@@ -113,6 +118,9 @@ struct kiocb {
 	wait_queue_t		ki_wait;
 	loff_t			ki_pos;
 
+	/* lio this iocb might be attached to */
+	struct lio_event	*ki_lio;
+
 	void			*private;
 	/* State that we remember to be able to restart/retry  */
 	unsigned short		ki_opcode;
@@ -220,12 +228,15 @@ struct mm_struct;
 extern void FASTCALL(exit_aio(struct mm_struct *mm));
 extern struct kioctx *lookup_ioctx(unsigned long ctx_id);
 extern int FASTCALL(io_submit_one(struct kioctx *ctx,
-			struct iocb __user *user_iocb, struct iocb *iocb));
+			struct iocb __user *user_iocb, struct iocb *iocb,
+			struct lio_event *lio));
+struct lio_event *lio_create(struct sigevent __user *user_event, int mode);
+void lio_check(struct lio_event *lio);
 
 /* semi private, but used by the 32bit emulations: */
 struct kioctx *lookup_ioctx(unsigned long ctx_id);
 int FASTCALL(io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
-				  struct iocb *iocb));
+				  struct iocb *iocb, struct lio_event *lio));
 
 #define get_ioctx(kioctx) do {						\
 	BUG_ON(atomic_read(&(kioctx)->users) <= 0);			\
diff -puN fs/compat.c~aio-listio-support fs/compat.c
--- linux-2.6.19-rc6-mm2/fs/compat.c~aio-listio-support	2006-12-01 11:19:58.000000000 +0530
+++ linux-2.6.19-rc6-mm2-bharata/fs/compat.c	2006-12-01 16:07:42.000000000 +0530
@@ -642,24 +642,13 @@ out:
 	return ret;
 }
 
-asmlinkage long
-compat_sys_io_submit(aio_context_t ctx_id, int nr, u32 __user *iocb)
+static int compat_io_submit_group(struct kioctx *ctx, long nr,
+	u32 __user *iocb, struct lio_event *lio)
 {
-	struct kioctx *ctx;
-	long ret = 0;
 	int i;
+	long ret = 0;
 
-	if (unlikely(nr < 0))
-		return -EINVAL;
-
-	if (unlikely(!access_ok(VERIFY_READ, iocb, (nr * sizeof(u32)))))
-		return -EFAULT;
-
-	ctx = lookup_ioctx(ctx_id);
-	if (unlikely(!ctx))
-		return -EINVAL;
-
-	for (i=0; i<nr; i++) {
+	for (i = 0; i < nr; i++) {
 		compat_uptr_t uptr;
 		struct iocb __user *user_iocb;
 		struct iocb tmp;
@@ -694,13 +683,97 @@ compat_sys_io_submit(aio_context_t ctx_i
 			tmp.aio_sigeventp = (__u64)event;
 		}
 
-		ret = io_submit_one(ctx, user_iocb, &tmp);
-		if (ret)
-			break;
+		if (lio)
+			atomic_inc(&lio->lio_users);
+
+		ret = io_submit_one(ctx, user_iocb, &tmp, lio);
+		if (ret) {
+			if (lio) {
+				/*
+				 * In case of listio, continue with
+				 * the subsequent requests
+				 */
+				atomic_dec(&lio->lio_users);
+			} else
+				break;
+		}
+
+
+	}
+	return i ? i : ret;
+}
+
+asmlinkage long
+compat_sys_io_submit(aio_context_t ctx_id, int nr, u32 __user *iocb)
+{
+	struct kioctx *ctx;
+	long ret = 0;
+	int i;
+
+	if (unlikely(nr < 0))
+		return -EINVAL;
+
+	if (unlikely(!access_ok(VERIFY_READ, iocb, (nr * sizeof(u32)))))
+		return -EFAULT;
+
+	ctx = lookup_ioctx(ctx_id);
+	if (unlikely(!ctx))
+		return -EINVAL;
+
+	ret = compat_io_submit_group(ctx, nr, iocb, NULL);
+	put_ioctx(ctx);
+	return ret;
+}
+
+asmlinkage long
+compat_sys_lio_submit(aio_context_t ctx_id, int mode, int nr, u32 __user *iocb,
+		u32 __user *sig_user)
+{
+	struct kioctx *ctx;
+	struct lio_event *lio = NULL;
+	struct sigvent __user *event = NULL;
+	long ret = 0;
+
+	if (unlikely(nr < 0))
+		return -EINVAL;
+
+	if (unlikely(!access_ok(VERIFY_READ, iocb, (nr * sizeof(u32)))))
+		return -EFAULT;
+
+	ctx = lookup_ioctx(ctx_id);
+	if (unlikely(!ctx))
+		return -EINVAL;
+
+	if (sig_user) {
+		struct sigevent kevent;
+		event = compat_alloc_user_space(sizeof(struct sigevent));
+		if (get_compat_sigevent(&kevent, sig_user) ||
+			copy_to_user(event, &kevent, sizeof(struct sigevent)))
+			return -EFAULT;
+	}
+
+	lio = lio_create(event, mode);
+
+	ret = PTR_ERR(lio);
+	if (IS_ERR(lio))
+		goto out_put_ctx;
+
+	ret = compat_io_submit_group(ctx, nr, iocb, lio);
+
+	/* If we failed to submit even one request just return */
+	if (ret < 0) {
+		if (lio)
+			kfree(lio);
+		goto out_put_ctx;
 	}
 
+	if (mode == LIO_WAIT) {
+		wait_event(ctx->wait, atomic_read(&lio->lio_users) == 0);
+		kfree(lio);
+	}
+out_put_ctx:
 	put_ioctx(ctx);
-	return i ? i: ret;
+	return ret;
 }
 
 struct compat_ncp_mount_data {
diff -puN include/linux/syscalls.h~aio-listio-support include/linux/syscalls.h
--- linux-2.6.19-rc6-mm2/include/linux/syscalls.h~aio-listio-support	2006-12-01 11:21:24.000000000 +0530
+++ linux-2.6.19-rc6-mm2-bharata/include/linux/syscalls.h	2006-12-01 11:22:36.000000000 +0530
@@ -319,6 +319,8 @@ asmlinkage long sys_io_getevents(aio_con
 				struct timespec __user *timeout);
 asmlinkage long sys_io_submit(aio_context_t, long,
 				struct iocb __user * __user *);
+asmlinkage long sys_lio_submit(aio_context_t, int, long,
+		struct iocb __user * __user *, struct sigevent __user *);
 asmlinkage long sys_io_cancel(aio_context_t ctx_id, struct iocb __user *iocb,
 			      struct io_event __user *result);
 asmlinkage ssize_t sys_sendfile(int out_fd, int in_fd,
diff -puN include/asm-i386/unistd.h~aio-listio-support include/asm-i386/unistd.h
--- linux-2.6.19-rc6-mm2/include/asm-i386/unistd.h~aio-listio-support	2006-12-04 10:02:46.000000000 +0530
+++ linux-2.6.19-rc6-mm2-bharata/include/asm-i386/unistd.h	2006-12-04 10:03:16.000000000 +0530
@@ -329,10 +329,11 @@
 #define __NR_kevent_ctl		321
 #define __NR_kevent_wait	322
 #define __NR_kevent_ring_init	323
+#define __NR_lio_submit		324
 
 #ifdef __KERNEL__
 
-#define NR_syscalls 324
+#define NR_syscalls 325
 
 #define __ARCH_WANT_IPC_PARSE_VERSION
 #define __ARCH_WANT_OLD_READDIR
diff -puN arch/i386/kernel/syscall_table.S~aio-listio-support arch/i386/kernel/syscall_table.S
--- linux-2.6.19-rc6-mm2/arch/i386/kernel/syscall_table.S~aio-listio-support	2006-12-04 20:14:33.000000000 +0530
+++ linux-2.6.19-rc6-mm2-bharata/arch/i386/kernel/syscall_table.S	2006-12-04 20:15:01.000000000 +0530
@@ -323,3 +323,4 @@ ENTRY(sys_call_table)
 	.long sys_kevent_ctl
 	.long sys_kevent_wait
 	.long sys_kevent_ring_init
+	.long sys_lio_submit
_
