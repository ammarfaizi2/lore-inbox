Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268111AbUJCUHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268111AbUJCUHX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 16:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268113AbUJCUHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 16:07:22 -0400
Received: from scanner2.mail.elte.hu ([157.181.151.9]:32748 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268111AbUJCUGf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 16:06:35 -0400
Date: Sun, 3 Oct 2004 22:08:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Joel White <cv223@comcast.net>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm4-S7
Message-ID: <20041003200810.GB32090@elte.hu>
References: <20040919122618.GA24982@elte.hu> <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu> <1096768900.1375.26.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096768900.1375.26.camel@krustophenia.net>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> I believe we have found a bug.  A user reported massive xruns with S7,
> they turned out to be printk() overhead from tons of "using
> smp_processor_id() in preemptible code" errors.  The trace below
> repeats over and over.  Looks like raid0 is the problem.

the patch below should fix this issue - it's in rc3-mm1 already.

	Ingo


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
 
