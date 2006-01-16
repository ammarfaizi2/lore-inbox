Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbWAPEJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWAPEJA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 23:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWAPEJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 23:09:00 -0500
Received: from xproxy.gmail.com ([66.249.82.201]:28862 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751011AbWAPEI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 23:08:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=PHceHKmo4My7jsJ87BvW/fB9wySsttKOyW+fYy5MI96HkXZFNK0R284FJQ2a2nIPT+cxH4GI7Gg/UdcojTNzN02WSTLU8hV8xQtKWgNFafb0M/hYzkKiFwrSRNclnyGeatK5acIDMzFp3llTau8MG/HNf6GlGUjRX+qzmtdqLls=
Date: Mon, 16 Jan 2006 13:08:53 +0900
From: Tejun Heo <htejun@gmail.com>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-mm4
Message-ID: <20060116040853.GA10588@htj.dyndns.org>
References: <20060114055153.04684592.akpm@osdl.org> <43C97FE6.8040402@reub.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C97FE6.8040402@reub.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2006 at 11:49:10AM +1300, Reuben Farrelly wrote:
> On 15/01/2006 2:51 a.m., Andrew Morton wrote:
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm4/
> >
> >(Will take an hour or so to mirror)
> >
> >
> >
> >- Lots of mutex conversions
> >
> >- FUSE update
> >
> >- nfsd update (mainly nfs4)
> >
> >- CPU scheduler update
> >
> >- A few new syscalls.
> 
> A couple of issues to look at with this kernel, it seems.  I'll report them 
> one by one, each in a different message so as to work the threading 
> properly.
> 
> A trace:
> 
> Freeing unused kernel memory: 196k freed
> Write protecting the kernel read-only data: 655k
> Badness in blk_do_ordered at block/ll_rw_blk.c:549
>  [<b01040d1>] show_trace+0xd/0xf
>  [<b0104172>] dump_stack+0x17/0x19
>  [<b01e2926>] blk_do_ordered+0x301/0x306
>  [<b01de3a5>] elv_next_request+0x3a/0x120
>  [<b0257ed1>] scsi_request_fn+0x57/0x2d5
>  [<b01e0fc3>] __generic_unplug_device+0x22/0x25
>  [<b01e119a>] generic_unplug_device+0x2c/0x39
>  [<b028fb2c>] unplug_slaves+0x5d/0xea
>  [<b028fbca>] raid1_unplug+0x11/0x1f
>  [<b01ded12>] blk_backing_dev_unplug+0xf/0x11
>  [<b01596a0>] sync_buffer+0x2e/0x37
>  [<b030ab61>] __wait_on_bit+0x45/0x62
>  [<b030abe9>] out_of_line_wait_on_bit+0x6b/0x82
>  [<b0159600>] __wait_on_buffer+0x27/0x2d
>  [<b01a7888>] search_by_key+0x14e/0x11a5
>  [<b019431f>] reiserfs_read_locked_inode+0x64/0x561
>  [<b019488c>] reiserfs_iget+0x70/0x88
>  [<b01917c0>] reiserfs_lookup+0xbf/0x10e
>  [<b016366e>] do_lookup+0x105/0x132
>  [<b01647fd>] __link_path_walk+0x11e/0xd4b
>  [<b0165470>] link_path_walk+0x46/0xd2
>  [<b0165715>] do_path_lookup+0xa9/0x215
>  [<b01661c0>] __path_lookup_intent_open+0x44/0x7f
>  [<b0166273>] path_lookup_open+0x21/0x27
>  [<b0166367>] open_namei+0x62/0x5a0
>  [<b0155a52>] do_filp_open+0x26/0x43
>  [<b0155ab0>] do_sys_open+0x41/0xc2
>  [<b0155b69>] sys_open+0x1c/0x1e
>  [<b0100460>] init+0x193/0x325
>  [<b0100d25>] kernel_thread_helper+0x5/0xb
> INIT: version 2.86 booting
> 
> It has never properly blown up into a full detailed oops, just spews out 
> the trace to console and then hangs.
> 
> I've seen this multiple times today, it is however fatal as every time it 
> has occurred the box needs a reset.
> 
> reuben
> 

Hello, Reuben.

Thanks for reporting the bug.  Can you please verify whether the
following patch fixes the bug?

--- a/block/elevator.c
+++ b/block/elevator.c
@@ -304,7 +304,7 @@ void elv_requeue_request(request_queue_t
 
 	rq->flags &= ~REQ_STARTED;
 
-	__elv_add_request(q, rq, ELEVATOR_INSERT_REQUEUE, 0);
+	elv_insert(q, rq, ELEVATOR_INSERT_REQUEUE);
 }
 
 static void elv_drain_elevator(request_queue_t *q)
@@ -321,42 +321,13 @@ static void elv_drain_elevator(request_q
 	}
 }
 
-void __elv_add_request(request_queue_t *q, struct request *rq, int where,
-		       int plug)
+void elv_insert(request_queue_t *q, struct request *rq, int where)
 {
 	struct list_head *pos;
 	unsigned ordseq;
 
 	blk_add_trace_rq(q, rq, BLK_TA_INSERT);
 
-	if (q->ordcolor)
-		rq->flags |= REQ_ORDERED_COLOR;
-
-	if (rq->flags & (REQ_SOFTBARRIER | REQ_HARDBARRIER)) {
-		/*
-		 * toggle ordered color
-		 */
-		q->ordcolor ^= 1;
-
-		/*
-		 * barriers implicitly indicate back insertion
-		 */
-		if (where == ELEVATOR_INSERT_SORT)
-			where = ELEVATOR_INSERT_BACK;
-
-		/*
-		 * this request is scheduling boundary, update end_sector
-		 */
-		if (blk_fs_request(rq)) {
-			q->end_sector = rq_end_sector(rq);
-			q->boundary_rq = rq;
-		}
-	} else if (!(rq->flags & REQ_ELVPRIV) && where == ELEVATOR_INSERT_SORT)
-		where = ELEVATOR_INSERT_BACK;
-
-	if (plug)
-		blk_plug_device(q);
-
 	rq->q = q;
 
 	switch (where) {
@@ -437,6 +408,42 @@ void __elv_add_request(request_queue_t *
 	}
 }
 
+void __elv_add_request(request_queue_t *q, struct request *rq, int where,
+		       int plug)
+{
+	if (q->ordcolor)
+		rq->flags |= REQ_ORDERED_COLOR;
+
+	if (rq->flags & (REQ_SOFTBARRIER | REQ_HARDBARRIER)) {
+		/*
+		 * toggle ordered color
+		 */
+		if (blk_barrier_rq(rq))
+			q->ordcolor ^= 1;
+
+		/*
+		 * barriers implicitly indicate back insertion
+		 */
+		if (where == ELEVATOR_INSERT_SORT)
+			where = ELEVATOR_INSERT_BACK;
+
+		/*
+		 * this request is scheduling boundary, update
+		 * end_sector
+		 */
+		if (blk_fs_request(rq)) {
+			q->end_sector = rq_end_sector(rq);
+			q->boundary_rq = rq;
+		}
+	} else if (!(rq->flags & REQ_ELVPRIV) && where == ELEVATOR_INSERT_SORT)
+		where = ELEVATOR_INSERT_BACK;
+
+	if (plug)
+		blk_plug_device(q);
+
+	elv_insert(q, rq, where);
+}
+
 void elv_add_request(request_queue_t *q, struct request *rq, int where,
 		     int plug)
 {
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -453,7 +453,7 @@ static void queue_flush(request_queue_t 
 	rq->end_io = end_io;
 	q->prepare_flush_fn(q, rq);
 
-	__elv_add_request(q, rq, ELEVATOR_INSERT_FRONT, 0);
+	elv_insert(q, rq, ELEVATOR_INSERT_FRONT);
 }
 
 static inline struct request *start_ordered(request_queue_t *q,
@@ -489,7 +489,7 @@ static inline struct request *start_orde
 	else
 		q->ordseq |= QUEUE_ORDSEQ_POSTFLUSH;
 
-	__elv_add_request(q, rq, ELEVATOR_INSERT_FRONT, 0);
+	elv_insert(q, rq, ELEVATOR_INSERT_FRONT);
 
 	if (q->ordered & QUEUE_ORDERED_PREFLUSH) {
 		queue_flush(q, QUEUE_ORDERED_PREFLUSH);
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -82,6 +82,7 @@ struct elevator_queue
 extern void elv_dispatch_sort(request_queue_t *, struct request *);
 extern void elv_add_request(request_queue_t *, struct request *, int, int);
 extern void __elv_add_request(request_queue_t *, struct request *, int, int);
+extern void elv_insert(request_queue_t *, struct request *, int);
 extern int elv_merge(request_queue_t *, struct request **, struct bio *);
 extern void elv_merge_requests(request_queue_t *, struct request *,
 			       struct request *);

