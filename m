Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285099AbRL2Rd5>; Sat, 29 Dec 2001 12:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285114AbRL2Rds>; Sat, 29 Dec 2001 12:33:48 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:25359 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S285099AbRL2Rde>;
	Sat, 29 Dec 2001 12:33:34 -0500
Date: Sat, 29 Dec 2001 18:33:15 +0100
From: Jens Axboe <axboe@suse.de>
To: rwhron@earthlink.net
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre1 dbench 32 hangs in vmstat "b" state
Message-ID: <20011229183315.E1821@suse.de>
In-Reply-To: <20011221154654.E811@suse.de> <20011221185538.A131@earthlink.net> <20011224150337.A593@suse.de> <20011224115953.A118@earthlink.net> <20011224180244.C1241@suse.de> <20011227140723.A4713@earthlink.net> <20011228124037.K2973@suse.de> <20011228091401.A15569@earthlink.net> <20011228153022.D1248@suse.de> <20011229014248.A17257@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011229014248.A17257@earthlink.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29 2001, rwhron@earthlink.net wrote:
> > > Kernel panic: Out of memory and no killable processes...
> > 
> > Someone else did report a similar case. Very strange, doesn't look bio
> 
> Al Viro posted a fix:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=100959128922157&w=2
> 
> I used Al's patch and 2.5.2-pre3 boots with reiserfs root_fs
> and no panic.
> 
> Below is the trace on 2.5.2-pre3 after dbench 32 livelocked.

Thanks, could you try with this patch? It's not a fix (haven't found the
bug yet), but I think we are looking at list corruption so please check
if this patch at least alters when it hangs etc.

--- /opt/kernel/linux-2.5.2-pre3/drivers/block/elevator.c	Sat Dec 29 12:17:53 2001
+++ drivers/block/elevator.c	Sat Dec 29 12:30:20 2001
@@ -142,7 +142,7 @@
 int elevator_linus_merge(request_queue_t *q, struct request **req,
 			 struct bio *bio)
 {
-	struct list_head *entry;
+	struct list_head *entry, *head = &q->queue_head;
 	struct request *__rq;
 	int ret;
 
@@ -160,17 +160,22 @@
 		}
 	}
 
+	if ((__rq = __elv_next_request(q)))
+		if (__rq->flags & REQ_STARTED)
+			head = head->next;
+
 	entry = &q->queue_head;
 	ret = ELEVATOR_NO_MERGE;
-	while ((entry = entry->prev) != &q->queue_head) {
+	while ((entry = entry->prev) != head) {
 		__rq = list_entry_rq(entry);
 
+		if (__rq->flags & (REQ_BARRIER | REQ_STARTED))
+			break;
+
 		/*
 		 * simply "aging" of requests in queue
 		 */
 		if (__rq->elevator_sequence-- <= 0)
-			break;
-		if (__rq->flags & (REQ_BARRIER | REQ_STARTED))
 			break;
 		if (!(__rq->flags & REQ_CMD))
 			continue;

-- 
Jens Axboe

