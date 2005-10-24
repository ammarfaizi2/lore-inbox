Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbVJXD1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbVJXD1l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 23:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbVJXD1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 23:27:41 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:38361 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750941AbVJXD1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 23:27:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=mvDlzdsYO+cwPPeFoKA9kKg0H5ZZ0SlUHV0rJ8nCuXif2CFtHDZr20xre5GneZzH4dv4xwoXGSMluuVLeguO7QoybbBWPJ0iphXB94gj4Lg54GmM+owffkcXQNHaPA6BxX3eqK2tyMQUMTHAKP+tcwHHGU4ynxuX1qjZJ+hKJHE=
Date: Mon, 24 Oct 2005 12:27:31 +0900
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH linux-block-2.6:generic-dispatch] kill max_back_kb handling
Message-ID: <20051024032731.GA14202@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Jens.

 This patch kills max_back_kb handling from elv_dispatch_sort() and
kills max_back_kb field from struct request_queue.  The implementation
was broken (subtracted bytes from blocks) and the usefulness of the
feature is doubtful.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/block/elevator.c b/drivers/block/elevator.c
--- a/drivers/block/elevator.c
+++ b/drivers/block/elevator.c
@@ -136,7 +136,6 @@ static int elevator_attach(request_queue
 	q->elevator = eq;
 	q->end_sector = 0;
 	q->boundary_rq = NULL;
-	q->max_back_kb = 0;
 
 	if (eq->ops->elevator_init_fn)
 		ret = eq->ops->elevator_init_fn(q, eq);
@@ -227,16 +226,13 @@ void elevator_exit(elevator_t *e)
 void elv_dispatch_sort(request_queue_t *q, struct request *rq)
 {
 	sector_t boundary;
-	unsigned max_back;
 	struct list_head *entry;
 
 	if (q->last_merge == rq)
 		q->last_merge = NULL;
 
 	boundary = q->end_sector;
-	max_back = q->max_back_kb * 2;
-	boundary = boundary > max_back ? boundary - max_back : 0;
-	
+
 	list_for_each_prev(entry, &q->queue_head) {
 		struct request *pos = list_entry_rq(entry);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -339,7 +339,6 @@ struct request_queue
 	 */
 	sector_t		end_sector;
 	struct request		*boundary_rq;
-	unsigned int		max_back_kb;
 
 	/*
 	 * Auto-unplugging state
