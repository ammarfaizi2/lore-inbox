Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262359AbSJOBME>; Mon, 14 Oct 2002 21:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262364AbSJOBME>; Mon, 14 Oct 2002 21:12:04 -0400
Received: from h-64-236-139-249.aoltw.net ([64.236.139.249]:36560 "EHLO
	msglinux1.mcom.com") by vger.kernel.org with ESMTP
	id <S262359AbSJOBMB>; Mon, 14 Oct 2002 21:12:01 -0400
Date: Mon, 14 Oct 2002 18:17:33 -0700
From: John Myers <jgmyers@netscape.com>
Message-Id: <200210150117.g9F1HXm26163@msglinux1.mcom.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] aio updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.850   -> 1.851  
#	            fs/aio.c	1.22    -> 1.23   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/14	jgmyers@netscape.com	1.851
# aio updates
#     fix uninitialized variable causing incorrect timeout
#     add support for IO_CMD_NOOP
#     make sys_io_cancel(), not cancel method, initialize most of returned result
#     minor aio_cancel_all() optimization
#     fix a debug printk
# --------------------------------------------
#
diff -Nru a/fs/aio.c b/fs/aio.c
--- a/fs/aio.c	Mon Oct 14 16:51:45 2002
+++ b/fs/aio.c	Mon Oct 14 16:51:45 2002
@@ -248,7 +248,7 @@
 	write_unlock(&mm->ioctx_list_lock);
 
 	dprintk("aio: allocated ioctx %p[%ld]: mm=%p mask=0x%x\n",
-		ctx, ctx->user_id, current->mm, ctx->ring_info.ring->nr);
+		ctx, ctx->user_id, current->mm, ctx->ring_info.nr);
 	return ctx;
 
 out_cleanup:
@@ -281,12 +281,12 @@
 		struct kiocb *iocb = list_kiocb(pos);
 		list_del_init(&iocb->ki_list);
 		cancel = iocb->ki_cancel;
-		if (cancel)
+		if (cancel) {
 			iocb->ki_users++;
-		spin_unlock_irq(&ctx->ctx_lock);
-		if (cancel)
+			spin_unlock_irq(&ctx->ctx_lock);
 			cancel(iocb, &res);
-		spin_lock_irq(&ctx->ctx_lock);
+			spin_lock_irq(&ctx->ctx_lock);
+		}
 	}
 	spin_unlock_irq(&ctx->ctx_lock);
 }
@@ -845,13 +845,13 @@
 
 	/* End fast path */
 
+	init_timeout(&to);
 	if (timeout) {
 		struct timespec	ts;
 		ret = -EFAULT;
 		if (unlikely(copy_from_user(&ts, timeout, sizeof(ts))))
 			goto out;
 
-		init_timeout(&to);
 		set_timeout(start_jiffies, &to, &ts);
 	}
 
@@ -1073,6 +1073,9 @@
 		if (file->f_op->aio_fsync)
 			ret = file->f_op->aio_fsync(req, 0);
 		break;
+	case IOCB_CMD_NOOP:
+		aio_complete(req, iocb->aio_buf, iocb->aio_offset);
+		return 0;
 	default:
 		dprintk("EINVAL: io_submit: no operation provided\n");
 		ret = -EINVAL;
@@ -1197,6 +1200,9 @@
 	if (NULL != cancel) {
 		struct io_event tmp;
 		printk("calling cancel\n");
+		memset(&tmp, 0, sizeof(tmp));
+		tmp.obj = (u64)(unsigned long)kiocb->ki_user_obj;
+		tmp.data = kiocb->ki_user_data;
 		ret = cancel(kiocb, &tmp);
 		if (!ret) {
 			/* Cancellation succeeded -- copy the result
