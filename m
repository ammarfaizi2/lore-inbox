Return-Path: <SRS0=S+k/=7R=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98A5C433E0
	for <io-uring@archiver.kernel.org>; Thu,  4 Jun 2020 11:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA3F5206C3
	for <io-uring@archiver.kernel.org>; Thu,  4 Jun 2020 11:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgFDLnx (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 4 Jun 2020 07:43:53 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:52864 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbgFDLnx (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 4 Jun 2020 07:43:53 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jgoHn-0006x4-S6; Thu, 04 Jun 2020 05:43:51 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jgoHm-0005J8-T3; Thu, 04 Jun 2020 05:43:51 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-kernel@vger.kernel.org>, io-uring@vger.kernel.org
Date:   Thu, 04 Jun 2020 06:39:52 -0500
Message-ID: <87a71jjbzr.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jgoHm-0005J8-T3;;;mid=<87a71jjbzr.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19bzVDa02BMFQbK6IVGpEyjtJ8JcakdHO8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: io_wq_work task_pid is nonsense
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org


I was looking at something else and I happened to come across the
task_pid field in struct io_wq_work.  The field is initialized with
task_pid_vnr.  Then it is used for cancelling pending work.

The only appropriate and safe use of task_pid_vnr is for sending
a pid value to userspace and that is not what is going on here.

This use is particularly bad as it looks like I can start a pid
namespace create an io work queue and create threads that happen to have
the userspace pid in question and then terminate them, or close their
io_work_queue file descriptors, and wind up closing someone else's work.

There is also pid wrap around, and the craziness of de_thread to contend
with as well.

Perhaps since all the task_pid field is used for is cancelling work for
an individual task you could do something like the patch below.  I am
assuming no reference counting is necessary as the field can not live
past the life of a task.

Of cource the fact that you don't perform this work for file descriptors
that are closed just before a task exits makes me wonder.

Can you please fix this code up to do something sensible?
Maybe like below?

Eric

diff --git a/fs/io-wq.h b/fs/io-wq.h
index 5ba12de7572f..bef29fff7403 100644
--- a/fs/io-wq.h
+++ b/fs/io-wq.h
@@ -91,7 +91,7 @@ struct io_wq_work {
 	const struct cred *creds;
 	struct fs_struct *fs;
 	unsigned flags;
-	pid_t task_pid;
+	struct task_struct *task;
 };
 
 #define INIT_IO_WORK(work, _func)				\
@@ -129,7 +129,7 @@ static inline bool io_wq_is_hashed(struct io_wq_work *work)
 
 void io_wq_cancel_all(struct io_wq *wq);
 enum io_wq_cancel io_wq_cancel_work(struct io_wq *wq, struct io_wq_work *cwork);
-enum io_wq_cancel io_wq_cancel_pid(struct io_wq *wq, pid_t pid);
+enum io_wq_cancel io_wq_cancel_task(struct io_wq *wq, struct task_struct *task);
 
 typedef bool (work_cancel_fn)(struct io_wq_work *, void *);
 
diff --git a/fs/io-wq.c b/fs/io-wq.c
index 4023c9846860..2139a049d548 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -1004,18 +1004,16 @@ enum io_wq_cancel io_wq_cancel_work(struct io_wq *wq, struct io_wq_work *cwork)
 	return io_wq_cancel_cb(wq, io_wq_io_cb_cancel_data, (void *)cwork);
 }
 
-static bool io_wq_pid_match(struct io_wq_work *work, void *data)
+static bool io_wq_task_match(struct io_wq_work *work, void *data)
 {
-	pid_t pid = (pid_t) (unsigned long) data;
+	struct task_struct *task = data;
 
-	return work->task_pid == pid;
+	return work->task == task;
 }
 
-enum io_wq_cancel io_wq_cancel_pid(struct io_wq *wq, pid_t pid)
+enum io_wq_cancel io_wq_cancel_task(struct io_wq *wq, struct task_struct *task)
 {
-	void *data = (void *) (unsigned long) pid;
-
-	return io_wq_cancel_cb(wq, io_wq_pid_match, data);
+	return io_wq_cancel_cb(wq, io_wq_task_match, task);
 }
 
 struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
diff --git a/fs/io_uring.c b/fs/io_uring.c
index c687f57fb651..b9d557a21a26 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1031,8 +1031,8 @@ static inline void io_req_work_grab_env(struct io_kiocb *req,
 		}
 		spin_unlock(&current->fs->lock);
 	}
-	if (!req->work.task_pid)
-		req->work.task_pid = task_pid_vnr(current);
+	if (!req->work.task)
+		req->work.task = current;
 }
 
 static inline void io_req_work_drop_env(struct io_kiocb *req)
@@ -7421,7 +7421,7 @@ static int io_uring_flush(struct file *file, void *data)
 	 * If the task is going away, cancel work it may have pending
 	 */
 	if (fatal_signal_pending(current) || (current->flags & PF_EXITING))
-		io_wq_cancel_pid(ctx->io_wq, task_pid_vnr(current));
+		io_wq_cancel_task(ctx->io_wq, current);
 
 	return 0;
 }
