Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbUCRKG0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 05:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262487AbUCRKG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 05:06:26 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:13785 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262496AbUCRKGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 05:06:17 -0500
Date: Thu, 18 Mar 2004 11:06:06 +0100
From: Jens Axboe <axboe@suse.de>
To: Eric Valette <eric.valette@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-mm2 : Badness in elv_requeue_request at drivers/block/elevator.c:157
Message-ID: <20040318100606.GG22234@suse.de>
References: <40596FC5.3080703@free.fr> <20040318100222.GE22234@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318100222.GE22234@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18 2004, Jens Axboe wrote:
> On Thu, Mar 18 2004, Eric Valette wrote:
> > I have this message two times as I have two adaptec controllers...
> > 
> > Attached my .config and the dmesg output
> > 
> > ksymoops 2.4.9 on i686 2.6.5-rc1-mm2.  Options used
> >      -V (default)
> >      -k /proc/ksyms (default)
> >      -l /proc/modules (default)
> >      -o /lib/modules/2.6.5-rc1-mm2/ (default)
> >      -m /System.map (specified)
> > 
> > Error (regular_file): read_ksyms stat /proc/ksyms failed
> > No modules in ksyms, skipping objects
> > No ksyms, skipping lsmod
> > CPU 0 irqstacks, hard=c05f7000 soft=c05f6000
> > Call Trace:
> >  [<c02b268d>] elv_requeue_request+0x8d/0xa0
> 
> Ah damn, requeue through blk_insert_request... Let me think about this
> a bit, I'll post a fix for you.

Does this work for you?

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

