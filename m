Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbTJWDvh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 23:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbTJWDvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 23:51:37 -0400
Received: from mail-05.iinet.net.au ([203.59.3.37]:1745 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261640AbTJWDve
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 23:51:34 -0400
Message-ID: <3F974FA9.4090802@cyberone.com.au>
Date: Thu, 23 Oct 2003 13:48:57 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Olien <dmo@osdl.org>
CC: rwhron@earthlink.net, venom@sns.it, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Mary Edie Meredith <maryedie@osdl.org>
Subject: Re: [BENCHMARK] I/O regression after 2.6.0-test5
References: <20031021130501.GA4409@rushmore> <3F9653E6.4060209@cyberone.com.au> <20031022183028.GA10249@osdl.org> <3F973BC9.4080005@cyberone.com.au>
In-Reply-To: <3F973BC9.4080005@cyberone.com.au>
Content-Type: multipart/mixed;
 boundary="------------020200080101010209060803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020200080101010209060803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Nick Piggin wrote:

>
>
> Dave Olien wrote:
>
>> Sorry, this patch didn't fix our performance problems.  Mary just
>> finished running dbt2 on test8 with your patch:
>>
>> NOTPM   kernel          scheduler
>> 965     2.6.0-test8-np  AS
>> 1632    2.6.-test6-mm4  deadline
>>
>
> Thanks. hmm.
> And NOTPM was better with AS in test5? Does using as-iosched.c from test5
> in a test8 kernel help?
>

If that helps, can you try this patch.


--------------020200080101010209060803
Content-Type: text/plain;
 name="as-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="as-fix.patch"

 linux-2.6-npiggin/drivers/block/as-iosched.c |   23 +++--------------------
 1 files changed, 3 insertions(+), 20 deletions(-)

diff -puN drivers/block/as-iosched.c~as-fix drivers/block/as-iosched.c
--- linux-2.6/drivers/block/as-iosched.c~as-fix	2003-10-23 13:46:11.000000000 +1000
+++ linux-2.6-npiggin/drivers/block/as-iosched.c	2003-10-23 13:47:58.000000000 +1000
@@ -99,7 +99,6 @@ struct as_data {
 	sector_t last_sector[2];	/* last REQ_SYNC & REQ_ASYNC sectors */
 	struct list_head *dispatch;	/* driver dispatch queue */
 	struct list_head *hash;		/* request hash */
-	unsigned long new_success; /* anticipation success on new proc */
 	unsigned long current_batch_expires;
 	unsigned long last_check_fifo[2];
 	int changed_batch;		/* 1: waiting for old batch to end */
@@ -585,18 +584,11 @@ static void as_antic_stop(struct as_data
 	int status = ad->antic_status;
 
 	if (status == ANTIC_WAIT_REQ || status == ANTIC_WAIT_NEXT) {
-		struct as_io_context *aic;
-
 		if (status == ANTIC_WAIT_NEXT)
 			del_timer(&ad->antic_timer);
 		ad->antic_status = ANTIC_FINISHED;
 		/* see as_work_handler */
 		kblockd_schedule_work(&ad->antic_work);
-
-		aic = ad->io_context->aic;
-		if (aic->seek_samples == 0)
-			/* new process */
-			ad->new_success = (ad->new_success * 3) / 4 + 256;
 	}
 }
 
@@ -612,14 +604,8 @@ static void as_antic_timeout(unsigned lo
 	spin_lock_irqsave(q->queue_lock, flags);
 	if (ad->antic_status == ANTIC_WAIT_REQ
 			|| ad->antic_status == ANTIC_WAIT_NEXT) {
-		struct as_io_context *aic;
 		ad->antic_status = ANTIC_FINISHED;
 		kblockd_schedule_work(&ad->antic_work);
-
-		aic = ad->io_context->aic;
-		if (aic->seek_samples == 0)
-			/* new process */
-			ad->new_success = (ad->new_success * 3) / 4;
 	}
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }
@@ -708,11 +694,10 @@ static int as_can_break_anticipation(str
 		return 1;
 	}
 
-	if (ad->new_success < 256 &&
-			(aic->seek_samples == 0 || aic->ttime_samples == 0)) {
+	if (aic->seek_samples == 0 || aic->ttime_samples == 0) {
 		/*
-		 * Process has just started IO and we have a bad history of
-		 * success anticipating on new processes!
+		 * Process has just started IO. Don't anticipate.
+		 * TODO! Must fix this up.
 		 */
 		return 1;
 	}
@@ -1822,8 +1807,6 @@ static int as_init(request_queue_t *q, e
 	if (ad->write_batch_count < 2)
 		ad->write_batch_count = 2;
 
-	ad->new_success = 512;
-
 	return 0;
 }
 

_

--------------020200080101010209060803--

