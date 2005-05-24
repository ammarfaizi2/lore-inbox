Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbVEXQkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbVEXQkc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 12:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbVEXQjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 12:39:39 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:8498 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262168AbVEXQfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 12:35:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=EF8d01n70kR2DRC1SBMbY+W9Y7SYjT8GRmWitgf8JDcQ/vnb/Mhj12h/gp42JlvYOC5q+E09AvzZJh7MiKhp/cewqL7spqSE0jxQPPjuXqPshZA9EslFp22AAM9J2S291ihPUfh1fhi0fzVlyCImWnTiZZl/Dclg9/EREhEPi00=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050524163518.0DA61D6C@htj.dyndns.org>
In-Reply-To: <20050524163518.0DA61D6C@htj.dyndns.org>
Subject: Re: [PATCH Linux 2.6.12-rc4-mm2 03/03] cfq: remove serveral unused fields from cfq data structures
Message-ID: <20050524163518.EA42F6F1@htj.dyndns.org>
Date: Wed, 25 May 2005 01:35:34 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

03_cfq_remove_unused_fields.patch

	cfq_data->idle_start, cfq_data->end_prio and cfq_rq->end_pos
	are not used in meaningful way.  Remove'em.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 cfq-iosched.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

Index: blk-fixes/drivers/block/cfq-iosched.c
===================================================================
--- blk-fixes.orig/drivers/block/cfq-iosched.c	2005-05-25 01:35:16.000000000 +0900
+++ blk-fixes/drivers/block/cfq-iosched.c	2005-05-25 01:35:17.000000000 +0900
@@ -143,11 +143,10 @@ struct cfq_data {
 	 */
 	struct timer_list idle_slice_timer;
 	struct work_struct unplug_work;
-	unsigned long idle_start;
 
 	struct cfq_queue *active_queue;
 	struct cfq_io_context *active_cic;
-	int cur_prio, cur_end_prio, end_prio;
+	int cur_prio, cur_end_prio;
 	unsigned int dispatch_slice;
 
 	struct timer_list idle_class_timer;
@@ -234,8 +233,6 @@ struct cfq_rq {
 	struct cfq_queue *cfq_queue;
 	struct cfq_io_context *io_context;
 
-	sector_t end_pos;
-
 	unsigned in_flight : 1;
 	unsigned accounted : 1;
 	unsigned is_sync   : 1;
@@ -770,12 +767,9 @@ static int cfq_get_next_prio_level(struc
 		cfqd->cur_end_prio = cfqd->cur_prio;
 		cfqd->cur_prio = 0;
 	}
-	if (cfqd->cur_end_prio > cfqd->end_prio)
-		cfqd->end_prio = cfqd->cur_end_prio;
-	if (cfqd->end_prio == CFQ_PRIO_LISTS) {
+	if (cfqd->cur_end_prio == CFQ_PRIO_LISTS) {
 		cfqd->cur_prio = 0;
 		cfqd->cur_end_prio = 0;
-		cfqd->end_prio = 0;
 	}
 
 	return prio;
@@ -876,7 +870,6 @@ static int cfq_arm_slice_timer(struct cf
 	if (!timer_pending(&cfqd->idle_slice_timer)) {
 		unsigned long slice_left = cfqq->slice_end - 1;
 
-		cfqd->idle_start = jiffies;
 		cfqd->idle_slice_timer.expires = min(jiffies + cfqd->cfq_slice_idle, slice_left);
 		add_timer(&cfqd->idle_slice_timer);
 	}
@@ -926,7 +919,6 @@ static void cfq_dispatch_sort(request_qu
 	cfq_del_crq_rb(crq);
 	cfq_remove_merge_hints(q, crq);
 
-	crq->end_pos = crq->request->sector + crq->request->nr_sectors;
 	crq->in_flight = 1;
 	crq->requeued = 0;
 	cfqq->in_flight++;

