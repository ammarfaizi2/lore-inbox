Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbVIGUpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbVIGUpl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 16:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbVIGUpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 16:45:41 -0400
Received: from fmr22.intel.com ([143.183.121.14]:47288 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932254AbVIGUpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 16:45:41 -0400
Date: Wed, 7 Sep 2005 16:41:07 -0400
From: Benjamin LaHaise <bcrl@linux.intel.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [AIO] kiocb locking to serialise retry and cancel
Message-ID: <20050907204107.GB21330@linux.intel.com>
References: <20050907203956.GA21330@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050907203956.GA21330@linux.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[AIO] kiocb locking to serialise retry and cancel

Implement a per-kiocb lock to serialise retry operations and cancel.  This
is done using wait_on_bit_lock() on the KIF_LOCKED bit of kiocb->ki_flags.
Also, make the cancellation path lock the kiocb and subsequently release
all references to it if the cancel was successful.  This version includes 
a fix for the deadlock with __aio_run_iocbs.

Signed-off-by: Benjamin LaHaise <bcrl@linux.intel.com>

 aio.c |   29 +++++++++++++++++++++++++----
 1 files changed, 25 insertions(+), 4 deletions(-)

diff -purN --exclude=description 01_aio_enosys/fs/aio.c 02_lock_kiocb/fs/aio.c
--- 01_aio_enosys/fs/aio.c	2005-09-07 11:03:55.000000000 -0400
+++ 02_lock_kiocb/fs/aio.c	2005-09-07 11:03:57.000000000 -0400
@@ -546,6 +546,24 @@ struct kioctx *lookup_ioctx(unsigned lon
 	return ioctx;
 }
 
+static int lock_kiocb_action(void *param)
+{
+	schedule();
+	return 0;
+}
+
+static inline void lock_kiocb(struct kiocb *iocb)
+{
+	wait_on_bit_lock(&iocb->ki_flags, KIF_LOCKED, lock_kiocb_action,
+			 TASK_UNINTERRUPTIBLE);
+}
+
+static inline void unlock_kiocb(struct kiocb *iocb)
+{
+	kiocbClearLocked(iocb);
+	wake_up_bit(&iocb->ki_flags, KIF_LOCKED);
+}
+
 /*
  * use_mm
  *	Makes the calling kernel thread take on the specified
@@ -786,7 +804,9 @@ static int __aio_run_iocbs(struct kioctx
 		 * Hold an extra reference while retrying i/o.
 		 */
 		iocb->ki_users++;       /* grab extra reference */
+		lock_kiocb(iocb);
 		aio_run_iocb(iocb);
+		unlock_kiocb(iocb);
 		if (__aio_put_req(ctx, iocb))  /* drop extra ref */
 			put_ioctx(ctx);
  	}
@@ -1527,10 +1547,9 @@ int fastcall io_submit_one(struct kioctx
 		goto out_put_req;
 
 	spin_lock_irq(&ctx->ctx_lock);
-	if (likely(list_empty(&ctx->run_list))) {
-		aio_run_iocb(req);
-	} else {
-		list_add_tail(&req->ki_run_list, &ctx->run_list);
+	aio_run_iocb(req);
+	unlock_kiocb(req);
+	if (!list_empty(&ctx->run_list)) {
 		/* drain the run list */
 		while (__aio_run_iocbs(ctx))
 			;
@@ -1661,6 +1680,7 @@ asmlinkage long sys_io_cancel(aio_contex
 	if (NULL != cancel) {
 		struct io_event tmp;
 		pr_debug("calling cancel\n");
+		lock_kiocb(kiocb);
 		memset(&tmp, 0, sizeof(tmp));
 		tmp.obj = (u64)(unsigned long)kiocb->ki_obj.user;
 		tmp.data = kiocb->ki_user_data;
@@ -1672,6 +1692,7 @@ asmlinkage long sys_io_cancel(aio_contex
 			if (copy_to_user(result, &tmp, sizeof(tmp)))
 				ret = -EFAULT;
 		}
+		unlock_kiocb(kiocb);
 	} else
 		ret = -EINVAL;
 
