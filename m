Return-Path: <linux-kernel-owner+w=401wt.eu-S1030202AbWL3Be2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbWL3Be2 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 20:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbWL3Be2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 20:34:28 -0500
Received: from mga03.intel.com ([143.182.124.21]:42309 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030202AbWL3Be1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 20:34:27 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,220,1165219200"; 
   d="scan'208"; a="163599566:sNHT35466557"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>, "'Benjamin LaHaise'" <bcrl@kvack.org>,
       <zach.brown@oracle.com>
Cc: <linux-aio@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [patch] aio: fix buggy put_ioctx call in aio_complete - v2
Date: Fri, 29 Dec 2006 17:34:26 -0800
Message-ID: <000101c72bb2$a47bfa70$d634030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccrsqREOG8bzD1gR3q5CgACkLhnew==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An AIO bug was reported that sleeping function is being called in softirq
context:

BUG: warning at kernel/mutex.c:132/__mutex_lock_common()
Call Trace:
     [<a000000100577b00>] __mutex_lock_slowpath+0x640/0x6c0
     [<a000000100577ba0>] mutex_lock+0x20/0x40
     [<a0000001000a25b0>] flush_workqueue+0xb0/0x1a0
     [<a00000010018c0c0>] __put_ioctx+0xc0/0x240
     [<a00000010018d470>] aio_complete+0x2f0/0x420
     [<a00000010019cc80>] finished_one_bio+0x200/0x2a0
     [<a00000010019d1c0>] dio_bio_complete+0x1c0/0x200
     [<a00000010019d260>] dio_bio_end_aio+0x60/0x80
     [<a00000010014acd0>] bio_endio+0x110/0x1c0
     [<a0000001002770e0>] __end_that_request_first+0x180/0xba0
     [<a000000100277b90>] end_that_request_chunk+0x30/0x60
     [<a0000002073c0c70>] scsi_end_request+0x50/0x300 [scsi_mod]
     [<a0000002073c1240>] scsi_io_completion+0x200/0x8a0 [scsi_mod]
     [<a0000002074729b0>] sd_rw_intr+0x330/0x860 [sd_mod]
     [<a0000002073b3ac0>] scsi_finish_command+0x100/0x1c0 [scsi_mod]
     [<a0000002073c2910>] scsi_softirq_done+0x230/0x300 [scsi_mod]
     [<a000000100277d20>] blk_done_softirq+0x160/0x1c0
     [<a000000100083e00>] __do_softirq+0x200/0x240
     [<a000000100083eb0>] do_softirq+0x70/0xc0

See report: http://marc.theaimsgroup.com/?l=linux-kernel&m=116599593200888&w=2

flush_workqueue() is not allowed to be called in the softirq context. 
However, aio_complete() called from I/O interrupt can potentially call
put_ioctx with last ref count on ioctx and triggers bug.  It is simply
incorrect to perform ioctx freeing from aio_complete.

The bug is trigger-able from a race between io_destroy() and aio_complete().
A possible scenario:

cpu0                               cpu1
io_destroy                         aio_complete
  wait_for_all_aios {                __aio_put_req
     ...                                 ctx->reqs_active--;
     if (!ctx->reqs_active)
        return;
  }
  ...
  put_ioctx(ioctx)

                                     put_ioctx(ctx);
                                        __put_ioctx
                                          bam! Bug trigger!

The real problem is that the condition check of ctx->reqs_active in
wait_for_all_aios() is incorrect that access to reqs_active is not
being properly protected by spin lock.

This patch adds that protective spin lock, and at the same time removes
all duplicate ref counting for each kiocb as reqs_active is already used
as a ref count for each active ioctx.  This also ensures that buggy call
to flush_workqueue() in softirq context is eliminated.


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

--- ./fs/aio.c.orig	2006-12-21 08:08:14.000000000 -0800
+++ ./fs/aio.c	2006-12-21 08:14:27.000000000 -0800
@@ -298,17 +298,23 @@ static void wait_for_all_aios(struct kio
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
 
+	spin_lock_irq(&ctx->ctx_lock);
 	if (!ctx->reqs_active)
-		return;
+		goto out;
 
 	add_wait_queue(&ctx->wait, &wait);
 	set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 	while (ctx->reqs_active) {
+		spin_unlock_irq(&ctx->ctx_lock);
 		schedule();
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+		spin_lock_irq(&ctx->ctx_lock);
 	}
 	__set_task_state(tsk, TASK_RUNNING);
 	remove_wait_queue(&ctx->wait, &wait);
+
+out:
+	spin_unlock_irq(&ctx->ctx_lock);
 }
 
 /* wait_on_sync_kiocb:
@@ -424,7 +430,6 @@ static struct kiocb fastcall *__aio_get_
 	ring = kmap_atomic(ctx->ring_info.ring_pages[0], KM_USER0);
 	if (ctx->reqs_active < aio_ring_avail(&ctx->ring_info, ring)) {
 		list_add(&req->ki_list, &ctx->active_reqs);
-		get_ioctx(ctx);
 		ctx->reqs_active++;
 		okay = 1;
 	}
@@ -536,8 +541,6 @@ int fastcall aio_put_req(struct kiocb *r
 	spin_lock_irq(&ctx->ctx_lock);
 	ret = __aio_put_req(ctx, req);
 	spin_unlock_irq(&ctx->ctx_lock);
-	if (ret)
-		put_ioctx(ctx);
 	return ret;
 }
 
@@ -782,8 +785,7 @@ static int __aio_run_iocbs(struct kioctx
 		 */
 		iocb->ki_users++;       /* grab extra reference */
 		aio_run_iocb(iocb);
-		if (__aio_put_req(ctx, iocb))  /* drop extra ref */
-			put_ioctx(ctx);
+		__aio_put_req(ctx, iocb);
  	}
 	if (!list_empty(&ctx->run_list))
 		return 1;
@@ -998,14 +1000,10 @@ put_rq:
 	/* everything turned out well, dispose of the aiocb. */
 	ret = __aio_put_req(ctx, iocb);
 
-	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
-
 	if (waitqueue_active(&ctx->wait))
 		wake_up(&ctx->wait);
 
-	if (ret)
-		put_ioctx(ctx);
-
+	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
 	return ret;
 }
 
