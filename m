Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbTKGXNz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 18:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTKGWXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:23:32 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:41184 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264236AbTKGNDz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 08:03:55 -0500
Message-ID: <3FAB9817.5020502@cyberone.com.au>
Date: Sat, 08 Nov 2003 00:03:19 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
References: <20031106130030.GC1145@suse.de> <3FAA4737.3060906@cyberone.com.au> <20031106130553.GD1145@suse.de> <3FAA4880.8090600@cyberone.com.au> <20031106131141.GE1145@suse.de> <3FAA4D48.6040709@gmx.de> <20031106133136.GA477@suse.de> <3FAA5043.8060907@gmx.de> <20031106134713.GA798@suse.de> <3FAA5397.6010702@gmx.de> <20031106135134.GA1194@suse.de> <3FAA5CCB.5030902@gmx.de> <3FAB0754.2040209@cyberone.com.au> <3FAB7F94.7050504@gmx.de> <3FAB82A2.4070907@cyberone.com.au> <3FAB8428.7090307@gmx.de> <3FAB870D.1050003@cyberone.com.au> <3FAB95B9.3020601@gmx.de>
In-Reply-To: <3FAB95B9.3020601@gmx.de>
Content-Type: multipart/mixed;
 boundary="------------080104000407000700050602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080104000407000700050602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Prakash K. Cheemplavam wrote:

>
> Yes, with this patch, it seems to be like in mm1 again, no more 
> stuttering (or at least I can't notice it anymore, as since 2 daysI 
> have an LCD), but also the bad stuttering at erase and burn start are 
> gone again. So do you have an idea what causes the problem?
>

Getting there, thanks for testing. We'll take the others off the CC
list: the problem is not in Linus' tree. Please try this patch.


--------------080104000407000700050602
Content-Type: text/plain;
 name="as-revert2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="as-revert2.patch"

 linux-2.6-npiggin/drivers/block/as-iosched.c |  219 +++++++++------------------
 1 files changed, 78 insertions(+), 141 deletions(-)

diff -puN drivers/block/as-iosched.c~as-revert2 drivers/block/as-iosched.c
--- linux-2.6/drivers/block/as-iosched.c~as-revert2	2003-11-07 23:59:20.000000000 +1100
+++ linux-2.6-npiggin/drivers/block/as-iosched.c	2003-11-08 00:00:25.000000000 +1100
@@ -70,7 +70,6 @@
 /* Bits in as_io_context.state */
 enum as_io_states {
 	AS_TASK_RUNNING=0,	/* Process has not exitted */
-	AS_TASK_IOSTARTED,	/* Process has started some IO */
 	AS_TASK_IORUNNING,	/* Process has completed some IO */
 };
 
@@ -100,14 +99,6 @@ struct as_data {
 	sector_t last_sector[2];	/* last REQ_SYNC & REQ_ASYNC sectors */
 	struct list_head *dispatch;	/* driver dispatch queue */
 	struct list_head *hash;		/* request hash */
-
-	unsigned long exit_prob;	/* probability a task will exit while
-					   being waited on */
-	unsigned long new_ttime_total; 	/* mean thinktime on new proc */
-	unsigned long new_ttime_mean;
-	u64 new_seek_total;		/* mean seek on new proc */
-	sector_t new_seek_mean;
-
 	unsigned long current_batch_expires;
 	unsigned long last_check_fifo[2];
 	int changed_batch;		/* 1: waiting for old batch to end */
@@ -195,7 +186,6 @@ static void free_as_io_context(struct as
 /* Called when the task exits */
 static void exit_as_io_context(struct as_io_context *aic)
 {
-	WARN_ON(!test_bit(AS_TASK_RUNNING, &aic->state));
 	clear_bit(AS_TASK_RUNNING, &aic->state);
 }
 
@@ -618,15 +608,8 @@ static void as_antic_timeout(unsigned lo
 	spin_lock_irqsave(q->queue_lock, flags);
 	if (ad->antic_status == ANTIC_WAIT_REQ
 			|| ad->antic_status == ANTIC_WAIT_NEXT) {
-		struct as_io_context *aic = ad->io_context->aic;
-
 		ad->antic_status = ANTIC_FINISHED;
 		kblockd_schedule_work(&ad->antic_work);
-
-		if (aic->ttime_samples == 0) {
-			/* process anticipated on has exitted or timed out*/
-			ad->exit_prob = (7*ad->exit_prob + 256)/8;
-		}
 	}
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }
@@ -640,7 +623,7 @@ static int as_close_req(struct as_data *
 	unsigned long delay;	/* milliseconds */
 	sector_t last = ad->last_sector[ad->batch_data_dir];
 	sector_t next = arq->request->sector;
-	sector_t delta; /* acceptable close offset (in sectors) */
+	sector_t delta;	/* acceptable close offset (in sectors) */
 
 	if (ad->antic_status == ANTIC_OFF || !ad->ioc_finished)
 		delay = 0;
@@ -657,7 +640,6 @@ static int as_close_req(struct as_data *
 	return (last - (delta>>1) <= next) && (next <= last + delta);
 }
 
-static void as_update_thinktime(struct as_data *ad, struct as_io_context *aic, unsigned long ttime);
 /*
  * as_can_break_anticipation returns true if we have been anticipating this
  * request.
@@ -675,27 +657,9 @@ static int as_can_break_anticipation(str
 {
 	struct io_context *ioc;
 	struct as_io_context *aic;
-	sector_t s;
-
-	ioc = ad->io_context;
-	BUG_ON(!ioc);
-
-	if (arq && ioc == arq->io_context) {
-		/* request from same process */
-		return 1;
-	}
 
 	if (arq && arq->is_sync == REQ_SYNC && as_close_req(ad, arq)) {
 		/* close request */
-		struct as_io_context *aic = ioc->aic;
-		if (aic) {
-			unsigned long thinktime;
-			spin_lock(&aic->lock);
-			thinktime = jiffies - aic->last_end_request;
-			aic->last_end_request = jiffies;
-			as_update_thinktime(ad, aic, thinktime);
-			spin_unlock(&aic->lock);
-		}
 		return 1;
 	}
 
@@ -707,14 +671,20 @@ static int as_can_break_anticipation(str
 		return 1;
 	}
 
+	ioc = ad->io_context;
+	BUG_ON(!ioc);
+
+	if (arq && ioc == arq->io_context) {
+		/* request from same process */
+		return 1;
+	}
+
 	aic = ioc->aic;
 	if (!aic)
 		return 0;
 
 	if (!test_bit(AS_TASK_RUNNING, &aic->state)) {
 		/* process anticipated on has exitted */
-		if (aic->ttime_samples == 0)
-			ad->exit_prob = (7*ad->exit_prob + 256)/8;
 		return 1;
 	}
 
@@ -728,36 +698,27 @@ static int as_can_break_anticipation(str
 		return 1;
 	}
 
-	if (aic->ttime_samples == 0) {
-		if (ad->new_ttime_mean > ad->antic_expire)
-			return 1;
-		if (ad->exit_prob > 128)
-			return 1;
-	} else if (aic->ttime_mean > ad->antic_expire) {
-		/* the process thinks too much between requests */
+	if (aic->seek_samples == 0 || aic->ttime_samples == 0) {
+		/*
+		 * Process has just started IO. Don't anticipate.
+		 * TODO! Must fix this up.
+		 */
 		return 1;
 	}
 
-	if (!arq)
-		return 0;
-
-	if (ad->last_sector[REQ_SYNC] < arq->request->sector)
-		s = arq->request->sector - ad->last_sector[REQ_SYNC];
-	else
-		s = ad->last_sector[REQ_SYNC] - arq->request->sector;
+	if (aic->ttime_mean > ad->antic_expire) {
+		/* the process thinks too much between requests */
+		return 1;
+	}
 
-	if (aic->seek_samples == 0) {
-		/*
-		 * Process has just started IO. Use past statistics to
-		 * guage success possibility
-		 */
-		if (ad->new_seek_mean/2 > s) {
-			/* this request is better than what we're expecting */
-			return 1;
-		}
+	if (arq && aic->seek_samples) {
+		sector_t s;
+		if (ad->last_sector[REQ_SYNC] < arq->request->sector)
+			s = arq->request->sector - ad->last_sector[REQ_SYNC];
+		else
+			s = ad->last_sector[REQ_SYNC] - arq->request->sector;
 
-	} else {
-		if (aic->seek_mean/2 > s) {
+		if (aic->seek_mean > (s>>1)) {
 			/* this request is better than what we're expecting */
 			return 1;
 		}
@@ -802,51 +763,12 @@ static int as_can_anticipate(struct as_d
 	return 1;
 }
 
-static void as_update_thinktime(struct as_data *ad, struct as_io_context *aic, unsigned long ttime)
-{
-	/* fixed point: 1.0 == 1<<8 */
-	if (aic->ttime_samples == 0) {
-		ad->new_ttime_total = (7*ad->new_ttime_total + 256*ttime) / 8;
-		ad->new_ttime_mean = ad->new_ttime_total / 256;
-
-		ad->exit_prob = (7*ad->exit_prob)/8;
-	}
-	aic->ttime_samples = (7*aic->ttime_samples + 256) / 8;
-	aic->ttime_total = (7*aic->ttime_total + 256*ttime) / 8;
-	aic->ttime_mean = (aic->ttime_total + 128) / aic->ttime_samples;
-}
-
-static void as_update_seekdist(struct as_data *ad, struct as_io_context *aic, sector_t sdist)
-{
-	u64 total;
-
-	if (aic->seek_samples == 0) {
-		ad->new_seek_total = (7*ad->new_seek_total + 256*(u64)sdist)/8;
-		ad->new_seek_mean = ad->new_seek_total / 256;
-	}
-
-	/*
-	 * Don't allow the seek distance to get too large from the
-	 * odd fragment, pagein, etc
-	 */
-	if (aic->seek_samples <= 60) /* second&third seek */
-		sdist = min(sdist, (aic->seek_mean * 4) + 2*1024*1024);
-	else
-		sdist = min(sdist, (aic->seek_mean * 4)	+ 2*1024*64);
-
-	aic->seek_samples = (7*aic->seek_samples + 256) / 8;
-	aic->seek_total = (7*aic->seek_total + (u64)256*sdist) / 8;
-	total = aic->seek_total + (aic->seek_samples/2);
-	do_div(total, aic->seek_samples);
-	aic->seek_mean = (sector_t)total;
-}
-
 /*
  * as_update_iohist keeps a decaying histogram of IO thinktimes, and
  * updates @aic->ttime_mean based on that. It is called when a new
  * request is queued.
  */
-static void as_update_iohist(struct as_data *ad, struct as_io_context *aic, struct request *rq)
+static void as_update_iohist(struct as_io_context *aic, struct request *rq)
 {
 	struct as_rq *arq = RQ_DATA(rq);
 	int data_dir = arq->is_sync;
@@ -857,29 +779,60 @@ static void as_update_iohist(struct as_d
 		return;
 
 	if (data_dir == REQ_SYNC) {
-		unsigned long in_flight = atomic_read(&aic->nr_queued)
-					+ atomic_read(&aic->nr_dispatched);
 		spin_lock(&aic->lock);
-		if (test_bit(AS_TASK_IORUNNING, &aic->state) ||
-			test_bit(AS_TASK_IOSTARTED, &aic->state)) {
+
+		if (test_bit(AS_TASK_IORUNNING, &aic->state)
+				&& !atomic_read(&aic->nr_queued)
+				&& !atomic_read(&aic->nr_dispatched)) {
 			/* Calculate read -> read thinktime */
-			if (test_bit(AS_TASK_IORUNNING, &aic->state)
-							&& in_flight == 0) {
-				thinktime = jiffies - aic->last_end_request;
-				thinktime = min(thinktime, MAX_THINKTIME-1);
-			} else
-				thinktime = 0;
-			as_update_thinktime(ad, aic, thinktime);
-
-			/* Calculate read -> read seek distance */
-			if (aic->last_request_pos < rq->sector)
-				seek_dist = rq->sector - aic->last_request_pos;
-			else
-				seek_dist = aic->last_request_pos - rq->sector;
-			as_update_seekdist(ad, aic, seek_dist);
-		}
+			thinktime = jiffies - aic->last_end_request;
+			thinktime = min(thinktime, MAX_THINKTIME-1);
+			/* fixed point: 1.0 == 1<<8 */
+			aic->ttime_samples += 256;
+			aic->ttime_total += 256*thinktime;
+			if (aic->ttime_samples)
+				/* fixed point factor is cancelled here */
+				aic->ttime_mean = (aic->ttime_total + 128)
+							/ aic->ttime_samples;
+			aic->ttime_samples = (aic->ttime_samples>>1)
+						+ (aic->ttime_samples>>2);
+			aic->ttime_total = (aic->ttime_total>>1)
+						+ (aic->ttime_total>>2);
+		}
+
+		/* Calculate read -> read seek distance */
+		if (!aic->seek_samples)
+			seek_dist = 0;
+		else if (aic->last_request_pos < rq->sector)
+			seek_dist = rq->sector - aic->last_request_pos;
+		else
+			seek_dist = aic->last_request_pos - rq->sector;
+
 		aic->last_request_pos = rq->sector + rq->nr_sectors;
-		set_bit(AS_TASK_IOSTARTED, &aic->state);
+
+		/*
+		 * Don't allow the seek distance to get too large from the
+		 * odd fragment, pagein, etc
+		 */
+		if (aic->seek_samples < 400) /* second&third seek */
+			seek_dist = min(seek_dist, (aic->seek_mean * 4)
+							+ 2*1024*1024);
+		else
+			seek_dist = min(seek_dist, (aic->seek_mean * 4)
+							+ 2*1024*64);
+
+		aic->seek_samples += 256;
+		aic->seek_total += (u64)256*seek_dist;
+		if (aic->seek_samples) {
+			u64 total = aic->seek_total + (aic->seek_samples>>1);
+			do_div(total, aic->seek_samples);
+			aic->seek_mean = (sector_t)total;
+		}
+		aic->seek_samples = (aic->seek_samples>>1)
+					+ (aic->seek_samples>>2);
+		aic->seek_total = (aic->seek_total>>1)
+					+ (aic->seek_total>>2);
+
 		spin_unlock(&aic->lock);
 	}
 }
@@ -1426,8 +1379,8 @@ static void as_add_request(struct as_dat
 	arq->io_context = as_get_io_context();
 
 	if (arq->io_context) {
-		as_update_iohist(ad, arq->io_context->aic, arq->request);
 		atomic_inc(&arq->io_context->aic->nr_queued);
+		as_update_iohist(arq->io_context->aic, arq->request);
 	}
 
 	alias = as_add_arq_rb(ad, arq);
@@ -1933,17 +1886,6 @@ as_var_store(unsigned long *var, const c
 	return count;
 }
 
-static ssize_t as_est_show(struct as_data *ad, char *page)
-{
-	int pos = 0;
-
-	pos += sprintf(page+pos, "%lu %% exit probability\n", 100*ad->exit_prob/256);
-	pos += sprintf(page+pos, "%lu ms new thinktime\n", ad->new_ttime_mean);
-	pos += sprintf(page+pos, "%llu sectors new seek distance\n", (unsigned long long)ad->new_seek_mean);
-
-	return pos;
-}
-
 #define SHOW_FUNCTION(__FUNC, __VAR)					\
 static ssize_t __FUNC(struct as_data *ad, char *page)		\
 {									\
@@ -1975,10 +1917,6 @@ STORE_FUNCTION(as_write_batchexpire_stor
 			&ad->batch_expire[REQ_ASYNC], 0, INT_MAX);
 #undef STORE_FUNCTION
 
-static struct as_fs_entry as_est_entry = {
-	.attr = {.name = "est_time", .mode = S_IRUGO },
-	.show = as_est_show,
-};
 static struct as_fs_entry as_readexpire_entry = {
 	.attr = {.name = "read_expire", .mode = S_IRUGO | S_IWUSR },
 	.show = as_readexpire_show,
@@ -2006,7 +1944,6 @@ static struct as_fs_entry as_write_batch
 };
 
 static struct attribute *default_attrs[] = {
-	&as_est_entry.attr,
 	&as_readexpire_entry.attr,
 	&as_writeexpire_entry.attr,
 	&as_anticexpire_entry.attr,

_

--------------080104000407000700050602--

