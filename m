Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266341AbUI0I4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266341AbUI0I4c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 04:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266357AbUI0I4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 04:56:32 -0400
Received: from scanner2.mail.elte.hu ([157.181.151.9]:35261 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266341AbUI0I40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 04:56:26 -0400
Date: Mon, 27 Sep 2004 10:57:44 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: Stack traces in 2.6.9-rc2-mm4
Message-ID: <20040927085744.GA32407@elte.hu>
References: <6.1.2.0.2.20040927184123.019b48b8@tornado.reub.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6.1.2.0.2.20040927184123.019b48b8@tornado.reub.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Reuben Farrelly <reuben-lkml@reub.net> wrote:

> Since upgrading from -mm3 to -mm4, I'm now getting messages like this 
> logged every second or so:
> 
> Sep 27 18:28:06 tornado kernel: using smp_processor_id() in preemptible code: swapper/1
> Sep 27 18:28:06 tornado kernel:  [<c0104dce>] dump_stack+0x17/0x19
> Sep 27 18:28:06 tornado kernel:  [<c0117fc6>] smp_processor_id+0x80/0x86
> Sep 27 18:28:06 tornado kernel:  [<c0282bf3>] make_request+0x174/0x2e7
> Sep 27 18:28:06 tornado kernel:  [<c02073dd>] generic_make_request+0xda/0x190

this is the remove-bkl patch's debugging feature showing that there's
more preempt-unsafe disk statistics code in the RAID code.

i've attached a patch that introduces preempt and non-preempt versions
of the statistics code and updates the block code to use the appropriate
ones - does this fix all the smp_processor_id() warnings you get?

	Ingo

--- linux/drivers/block/ll_rw_blk.c.orig	
+++ linux/drivers/block/ll_rw_blk.c	
@@ -2099,13 +2099,13 @@ void drive_stat_acct(struct request *rq,
 		return;
 
 	if (rw == READ) {
-		disk_stat_add(rq->rq_disk, read_sectors, nr_sectors);
+		__disk_stat_add(rq->rq_disk, read_sectors, nr_sectors);
 		if (!new_io)
-			disk_stat_inc(rq->rq_disk, read_merges);
+			__disk_stat_inc(rq->rq_disk, read_merges);
 	} else if (rw == WRITE) {
-		disk_stat_add(rq->rq_disk, write_sectors, nr_sectors);
+		__disk_stat_add(rq->rq_disk, write_sectors, nr_sectors);
 		if (!new_io)
-			disk_stat_inc(rq->rq_disk, write_merges);
+			__disk_stat_inc(rq->rq_disk, write_merges);
 	}
 	if (new_io) {
 		disk_round_stats(rq->rq_disk);
@@ -2151,12 +2151,12 @@ void disk_round_stats(struct gendisk *di
 {
 	unsigned long now = jiffies;
 
-	disk_stat_add(disk, time_in_queue, 
+	__disk_stat_add(disk, time_in_queue, 
 			disk->in_flight * (now - disk->stamp));
 	disk->stamp = now;
 
 	if (disk->in_flight)
-		disk_stat_add(disk, io_ticks, (now - disk->stamp_idle));
+		__disk_stat_add(disk, io_ticks, (now - disk->stamp_idle));
 	disk->stamp_idle = now;
 }
 
@@ -2957,12 +2957,12 @@ void end_that_request_last(struct reques
 		unsigned long duration = jiffies - req->start_time;
 		switch (rq_data_dir(req)) {
 		    case WRITE:
-			disk_stat_inc(disk, writes);
-			disk_stat_add(disk, write_ticks, duration);
+			__disk_stat_inc(disk, writes);
+			__disk_stat_add(disk, write_ticks, duration);
 			break;
 		    case READ:
-			disk_stat_inc(disk, reads);
-			disk_stat_add(disk, read_ticks, duration);
+			__disk_stat_inc(disk, reads);
+			__disk_stat_add(disk, read_ticks, duration);
 			break;
 		}
 		disk_round_stats(disk);
--- linux/include/linux/genhd.h.orig	
+++ linux/include/linux/genhd.h	
@@ -112,13 +112,14 @@ struct gendisk {
 
 /* 
  * Macros to operate on percpu disk statistics:
- * Since writes to disk_stats are serialised through the queue_lock,
- * smp_processor_id() should be enough to get to the per_cpu versions
- * of statistics counters
+ *
+ * The __ variants should only be called in critical sections. The full
+ * variants disable/enable preemption.
  */
 #ifdef	CONFIG_SMP
-#define disk_stat_add(gendiskp, field, addnd) 	\
+#define __disk_stat_add(gendiskp, field, addnd) 	\
 	(per_cpu_ptr(gendiskp->dkstats, smp_processor_id())->field += addnd)
+
 #define disk_stat_read(gendiskp, field)					\
 ({									\
 	typeof(gendiskp->dkstats->field) res = 0;			\
@@ -142,7 +143,8 @@ static inline void disk_stat_set_all(str
 }		
 				
 #else
-#define disk_stat_add(gendiskp, field, addnd) (gendiskp->dkstats.field += addnd)
+#define __disk_stat_add(gendiskp, field, addnd) \
+				(gendiskp->dkstats.field += addnd)
 #define disk_stat_read(gendiskp, field)	(gendiskp->dkstats.field)
 
 static inline void disk_stat_set_all(struct gendisk *gendiskp, int value)	{
@@ -150,8 +152,21 @@ static inline void disk_stat_set_all(str
 }
 #endif
 
-#define disk_stat_inc(gendiskp, field) disk_stat_add(gendiskp, field, 1)
+#define disk_stat_add(gendiskp, field, addnd)			\
+	do {							\
+		preempt_disable();				\
+		__disk_stat_add(gendiskp, field, addnd);	\
+		preempt_enable();				\
+	} while (0)
+
+#define __disk_stat_dec(gendiskp, field) __disk_stat_add(gendiskp, field, -1)
 #define disk_stat_dec(gendiskp, field) disk_stat_add(gendiskp, field, -1)
+
+#define __disk_stat_inc(gendiskp, field) __disk_stat_add(gendiskp, field, 1)
+#define disk_stat_inc(gendiskp, field) disk_stat_add(gendiskp, field, 1)
+
+#define __disk_stat_sub(gendiskp, field, subnd) \
+		__disk_stat_add(gendiskp, field, -subnd)
 #define disk_stat_sub(gendiskp, field, subnd) \
 		disk_stat_add(gendiskp, field, -subnd)
 
