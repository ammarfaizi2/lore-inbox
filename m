Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbUCSKPC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 05:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbUCSKPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 05:15:01 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:47315 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262453AbUCSKO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 05:14:58 -0500
Date: Fri, 19 Mar 2004 11:14:51 +0100
From: Jens Axboe <axboe@suse.de>
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5-rc1-mm2 very slow
Message-ID: <20040319101451.GM22234@suse.de>
References: <Pine.LNX.4.58.0403190956560.18369@praktifix.dwd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403190956560.18369@praktifix.dwd.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19 2004, Holger Kiehl wrote:
> Hello
> 
> I am testing 2.6.5-rc1-mm2 and find it very slow when I do a bonnie
> test, also the system itself feels very sluggish. Looking at dmesg
> I get the following:
> 
>    Badness in elv_remove_request at drivers/block/elevator.c:249
>    Call Trace:
>     [<c028b28f>] elv_remove_request+0x8d/0x8f
>     [<c02b6a4e>] scsi_request_fn+0x289/0x333
>     [<c028b174>] elv_next_request+0x3d/0xcb
>     [<c028c8da>] generic_unplug_device+0x43/0x45

Does it still complain with this patch?

--- drivers/block/elevator.c~	2004-03-18 10:56:34.494431670 +0100
+++ drivers/block/elevator.c	2004-03-18 11:05:00.115063157 +0100
@@ -153,7 +153,7 @@
 	 * it already went through dequeue, we need to decrement the
 	 * in_flight count again
 	 */
-	if (blk_rq_started(rq)) {
+	if (blk_account_rq(rq)) {
 		WARN_ON(q->in_flight == 0);
 		q->in_flight--;
 	}
@@ -244,7 +244,7 @@
 	 * driver has seen (REQ_STARTED set), to avoid false accounting
 	 * for request-request merges
 	 */
-	if (blk_rq_started(rq)) {
+	if (blk_account_rq(rq)) {
 		q->in_flight++;
 		WARN_ON(q->in_flight > 2 * q->nr_requests);
 	}
@@ -341,7 +341,7 @@
 	/*
 	 * request is released from the driver, io must be done
 	 */
-	if (blk_rq_started(rq)) {
+	if (blk_account_rq(rq)) {
 		WARN_ON(q->in_flight == 0);
 		q->in_flight--;
 	}
--- include/linux/blkdev.h~	2004-03-18 11:03:59.431584757 +0100
+++ include/linux/blkdev.h	2004-03-18 11:05:16.980250506 +0100
@@ -381,6 +381,8 @@
 #define blk_noretry_request(rq)	((rq)->flags & REQ_FAILFAST)
 #define blk_rq_started(rq)	((rq)->flags & REQ_STARTED)
 
+#define blk_account_rq(rq)	(blk_rq_started(rq) && blk_fs_request(rq))
+
 #define blk_pm_suspend_request(rq)	((rq)->flags & REQ_PM_SUSPEND)
 #define blk_pm_resume_request(rq)	((rq)->flags & REQ_PM_RESUME)
 #define blk_pm_request(rq)	\


-- 
Jens Axboe

