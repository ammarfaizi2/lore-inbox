Return-Path: <linux-kernel-owner+w=401wt.eu-S932353AbXADJde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbXADJde (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 04:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbXADJdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 04:33:33 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:54779 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932347AbXADJdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 04:33:31 -0500
Date: Thu, 4 Jan 2007 15:10:56 +0530
From: Bharata B Rao <bharata@in.ibm.com>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: linux-aio@kvack.org, akpm@osdl.org, drepper@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com, mingo@elte.hu,
       =?iso-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Subject: [PATCHSET 3][PATCH 5/5][AIO] - Add listio support
Message-ID: <20070104094056.GI9608@in.ibm.com>
Reply-To: bharata@in.ibm.com
References: <20061227153855.GA25898@in.ibm.com> <20070104092733.GD9608@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sDKAb4OeUBrWWL6P"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20070104092733.GD9608@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sDKAb4OeUBrWWL6P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	listio support through a system call(lio_submit)

This builds on the infrastructure provided by Sebastien's AIO
completion signal notification and listio patches to provide listio
support via a new system call.

long lio_submit(aio_context_t ctx_id, int mode, long nr,
	struct iocb __user * __user *iocbpp, struct sigevent __user *event)

More details about the system call appears within the patch itself.

Sebastien had taken the approach of overloading the io_submit() with
new aio_lio_opcode of IOCB_CMD_GROUP to support the listio behaviour.
And this is an alternative approach for supporting listio.

Would this system call approach be agreeable ?

Would it make sense to add another argument to support partial
completion notification ? i,e., generate a notification when a minimum
number of ios complete. Would such a feature be desirable ? Is it ok
to add one more argument to the system call for this purpose ?

This patch along with the previous 4 AIO completion signal notification
patches have been tested using libposix-aio library. Tests have been
done on x86 and x86_64 boxes. The compat syscall changes have been tested
on x86_64 system.

--sDKAb4OeUBrWWL6P
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="aio-listio-support.patch"
Content-Transfer-Encoding: 8bit


From: Bharata B Rao <bharata@in.ibm.com>

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

Signed-off-by: Sébastien Dugué <sebastien.dugue@bull.net>
Signed-off-by: Laurent Vivier <laurent.vivier@bull.net>
Signed-off-by: Bharata B Rao <bharata@in.ibm.com>
---

 arch/i386/kernel/syscall_table.S |    1 
 arch/x86_64/ia32/ia32entry.S     |    4 
 fs/aio.c                         |  175 ++++++++++++++++++++++++++++++++++-----
 fs/compat.c                      |  117 +++++++++++++++++++++-----
 include/asm-i386/unistd.h        |    3 
 include/asm-x86_64/unistd.h      |    4 
 include/linux/aio.h              |   14 ++-
 include/linux/aio_abi.h          |    5 +
 include/linux/syscalls.h         |    2 
 9 files changed, 280 insertions(+), 45 deletions(-)

diff -puN arch/i386/kernel/syscall_table.S~aio-listio-support arch/i386/kernel/syscall_table.S
--- linux-2.6.20-rc2/arch/i386/kernel/syscall_table.S~aio-listio-support	2007-01-04 13:23:19.000000000 +0530
+++ linux-2.6.20-rc2-bharata/arch/i386/kernel/syscall_table.S	2007-01-04 13:23:19.000000000 +0530
@@ -319,3 +319,4 @@ ENTRY(sys_call_table)
 	.long sys_move_pages
 	.long sys_getcpu
 	.long sys_epoll_pwait
+	.long sys_lio_submit		/* 320 */
diff -puN fs/aio.c~aio-listio-support fs/aio.c
--- linux-2.6.20-rc2/fs/aio.c~aio-listio-support	2007-01-04 13:23:19.000000000 +0530
+++ linux-2.6.20-rc2-bharata/fs/aio.c	2007-01-04 13:23:19.000000000 +0530
@@ -412,6 +412,7 @@ static struct kiocb fastcall *__aio_get_
 	req->ki_ctx = ctx;
 	req->ki_cancel = NULL;
 	req->ki_retry = NULL;
+	req->ki_lio = NULL;
 	req->ki_dtor = NULL;
 	req->private = NULL;
 	req->ki_iovec = NULL;
@@ -991,6 +992,59 @@ out_unlock:
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
@@ -1039,6 +1093,9 @@ int fastcall aio_complete(struct kiocb *
 	 * when the event got cancelled.
 	 */
 	if (kiocbIsCancelled(iocb)) {
+		if (iocb->ki_lio)
+			lio_check(iocb->ki_lio);
+
 		if (iocb->ki_notify.sigq)
 			sigqueue_free(iocb->ki_notify.sigq);
 		goto put_rq;
@@ -1080,6 +1137,9 @@ int fastcall aio_complete(struct kiocb *
 		if (ret)
 			sigqueue_free(iocb->ki_notify.sigq);
 	}
+
+	if (iocb->ki_lio)
+		lio_check(iocb->ki_lio);
 put_rq:
 	/* everything turned out well, dispose of the aiocb. */
 	rcu_read_lock();
@@ -1612,7 +1672,7 @@ static int aio_wake_function(wait_queue_
 }
 
 int fastcall io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
-			 struct iocb *iocb)
+			 struct iocb *iocb, struct lio_event *lio)
 {
 	struct kiocb *req;
 	struct file *file;
@@ -1673,6 +1733,9 @@ int fastcall io_submit_one(struct kioctx
 			goto out_put_req;
 	}
 
+	/* Attach this iocb to its lio */
+	req->ki_lio = lio;
+
 	ret = aio_setup_iocb(req);
 
 	if (ret)
@@ -1700,6 +1763,48 @@ out_put_req:
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
@@ -1717,7 +1822,6 @@ asmlinkage long sys_io_submit(aio_contex
 {
 	struct kioctx *ctx;
 	long ret = 0;
-	int i;
 
 	if (unlikely(nr < 0))
 		return -EINVAL;
@@ -1731,31 +1835,60 @@ asmlinkage long sys_io_submit(aio_contex
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
diff -puN fs/compat.c~aio-listio-support fs/compat.c
--- linux-2.6.20-rc2/fs/compat.c~aio-listio-support	2007-01-04 13:23:19.000000000 +0530
+++ linux-2.6.20-rc2-bharata/fs/compat.c	2007-01-04 13:23:19.000000000 +0530
@@ -644,24 +644,13 @@ out:
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
@@ -696,13 +685,103 @@ compat_sys_io_submit(aio_context_t ctx_i
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
 	}
+	return i ? i : ret;
+}
 
+asmlinkage long
+compat_sys_io_submit(aio_context_t ctx_id, int nr, u32 __user *iocb)
+{
+	struct kioctx *ctx;
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
+	ret = compat_io_submit_group(ctx, nr, iocb, NULL);
+	put_ioctx(ctx);
+	return ret;
+}
+
+asmlinkage long
+compat_sys_lio_submit(aio_context_t ctx_id, int mode, int nr, u32 __user *iocb,
+		struct compat_sigevent __user *sig_user)
+{
+	struct kioctx *ctx;
+	struct lio_event *lio = NULL;
+	struct sigevent __user *event = NULL;
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
+	}
+
+	/*
+	 * Drop extra ref on the lio now that we're done submitting requests.
+	 */
+	if (lio)
+		lio_check(lio);
+
+
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
diff -puN include/asm-i386/unistd.h~aio-listio-support include/asm-i386/unistd.h
--- linux-2.6.20-rc2/include/asm-i386/unistd.h~aio-listio-support	2007-01-04 13:23:19.000000000 +0530
+++ linux-2.6.20-rc2-bharata/include/asm-i386/unistd.h	2007-01-04 13:23:19.000000000 +0530
@@ -325,10 +325,11 @@
 #define __NR_move_pages		317
 #define __NR_getcpu		318
 #define __NR_epoll_pwait	319
+#define __NR_lio_submit		320
 
 #ifdef __KERNEL__
 
-#define NR_syscalls 320
+#define NR_syscalls 321
 
 #define __ARCH_WANT_IPC_PARSE_VERSION
 #define __ARCH_WANT_OLD_READDIR
diff -puN include/linux/aio_abi.h~aio-listio-support include/linux/aio_abi.h
--- linux-2.6.20-rc2/include/linux/aio_abi.h~aio-listio-support	2007-01-04 13:23:19.000000000 +0530
+++ linux-2.6.20-rc2-bharata/include/linux/aio_abi.h	2007-01-04 13:23:19.000000000 +0530
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
--- linux-2.6.20-rc2/include/linux/aio.h~aio-listio-support	2007-01-04 13:23:19.000000000 +0530
+++ linux-2.6.20-rc2-bharata/include/linux/aio.h	2007-01-04 13:23:19.000000000 +0530
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
@@ -112,6 +117,8 @@ struct kiocb {
 	__u64			ki_user_data;	/* user's data for completion */
 	wait_queue_t		ki_wait;
 	loff_t			ki_pos;
+	/* lio this iocb might be attached to */
+	struct lio_event	*ki_lio;
 
 	atomic_t		ki_bio_count;	/* num bio used for this iocb */
 	void			*private;
@@ -220,12 +227,15 @@ struct mm_struct;
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
diff -puN include/linux/syscalls.h~aio-listio-support include/linux/syscalls.h
--- linux-2.6.20-rc2/include/linux/syscalls.h~aio-listio-support	2007-01-04 13:23:19.000000000 +0530
+++ linux-2.6.20-rc2-bharata/include/linux/syscalls.h	2007-01-04 13:23:19.000000000 +0530
@@ -317,6 +317,8 @@ asmlinkage long sys_io_getevents(aio_con
 				struct timespec __user *timeout);
 asmlinkage long sys_io_submit(aio_context_t, long,
 				struct iocb __user * __user *);
+asmlinkage long sys_lio_submit(aio_context_t, int, long,
+		struct iocb __user * __user *, struct sigevent __user *);
 asmlinkage long sys_io_cancel(aio_context_t ctx_id, struct iocb __user *iocb,
 			      struct io_event __user *result);
 asmlinkage ssize_t sys_sendfile(int out_fd, int in_fd,
diff -puN include/asm-x86_64/unistd.h~aio-listio-support include/asm-x86_64/unistd.h
--- linux-2.6.20-rc2/include/asm-x86_64/unistd.h~aio-listio-support	2007-01-04 13:23:19.000000000 +0530
+++ linux-2.6.20-rc2-bharata/include/asm-x86_64/unistd.h	2007-01-04 13:23:19.000000000 +0530
@@ -619,8 +619,10 @@ __SYSCALL(__NR_sync_file_range, sys_sync
 __SYSCALL(__NR_vmsplice, sys_vmsplice)
 #define __NR_move_pages		279
 __SYSCALL(__NR_move_pages, sys_move_pages)
+#define __NR_lio_submit		280
+__SYSCALL(__NR_lio_submit, sys_lio_submit)
 
-#define __NR_syscall_max __NR_move_pages
+#define __NR_syscall_max __NR_lio_submit
 
 #ifndef __NO_STUBS
 #define __ARCH_WANT_OLD_READDIR
diff -puN arch/x86_64/ia32/ia32entry.S~aio-listio-support arch/x86_64/ia32/ia32entry.S
--- linux-2.6.20-rc2/arch/x86_64/ia32/ia32entry.S~aio-listio-support	2007-01-04 13:23:19.000000000 +0530
+++ linux-2.6.20-rc2-bharata/arch/x86_64/ia32/ia32entry.S	2007-01-04 13:23:19.000000000 +0530
@@ -714,8 +714,10 @@ ia32_sys_call_table:
 	.quad compat_sys_get_robust_list
 	.quad sys_splice
 	.quad sys_sync_file_range
-	.quad sys_tee
+	.quad sys_tee			/* 315 */
 	.quad compat_sys_vmsplice
 	.quad compat_sys_move_pages
 	.quad sys_getcpu
+	.quad quiet_ni_syscall		/* sys_epoll_wait */
+	.quad compat_sys_lio_submit
 ia32_syscall_end:		
_

--sDKAb4OeUBrWWL6P--
