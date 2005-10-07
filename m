Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbVJGCqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbVJGCqs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 22:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbVJGCqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 22:46:48 -0400
Received: from fmr21.intel.com ([143.183.121.13]:58586 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751327AbVJGCqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 22:46:47 -0400
Message-Id: <200510070246.j972kig22629@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Jens Axboe'" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: [RFC] add sysfs to dynamically control blk request tag maintenance
Date: Thu, 6 Oct 2005 19:46:44 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcXK6VqBO5NqiI69SjGVUDwFyimUvg==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

blk_queue_start_tag and blk_queue_end_tag are called for tagging
I/O to scsi device that is capable of tcq. blk_queue_find_tag is
a function that utilizes the tag information built up on every I/O.

However, there aren't many consumers for blk_queue_find_tag, except
NCR53c700 and tekram-dc390.  Vast majority of scsi drivers don't
use these tag currently.  So why bother build them at the beginning
of an I/O and then tear it all down at the end, all doing hard work
but no other functions in the kernel appears to care.

Is there another big scheme in the works to use these tags?  If not,
I'd like to propose we add a sysfs attribute to dynamically control
whether kernel maintains blk request tag or not.  This has performance
advantage that we don't needlessly waste CPU cycle on things we throw
away without using them. Would the following patch be acceptable?
Comments?


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

--- linux-2.6.14-rc3/drivers/block/ll_rw_blk.c.orig	2005-10-06 19:11:28.452697852 -0700
+++ linux-2.6.14-rc3/drivers/block/ll_rw_blk.c	2005-10-06 19:11:43.198791421 -0700
@@ -757,7 +757,7 @@ static void __blk_queue_free_tags(reques
 	}
 
 	q->queue_tags = NULL;
-	q->queue_flags &= ~(1 << QUEUE_FLAG_QUEUED);
+	q->queue_flags &= ~(1 << QUEUE_FLAG_QUEUED | 1 << QUEUE_FLAG_TAGGED);
 }
 
 /**
@@ -771,6 +771,7 @@ static void __blk_queue_free_tags(reques
 void blk_queue_free_tags(request_queue_t *q)
 {
 	clear_bit(QUEUE_FLAG_QUEUED, &q->queue_flags);
+	clear_bit(QUEUE_FLAG_TAGGED, &q->queue_flags);
 }
 
 EXPORT_SYMBOL(blk_queue_free_tags);
@@ -838,6 +839,7 @@ int blk_queue_init_tags(request_queue_t 
 		if ((rc = blk_queue_resize_tags(q, depth)))
 			return rc;
 		set_bit(QUEUE_FLAG_QUEUED, &q->queue_flags);
+		set_bit(QUEUE_FLAG_TAGGED, &q->queue_flags);
 		return 0;
 	} else
 		atomic_inc(&tags->refcnt);
@@ -846,7 +848,7 @@ int blk_queue_init_tags(request_queue_t 
 	 * assign it, all done
 	 */
 	q->queue_tags = tags;
-	q->queue_flags |= (1 << QUEUE_FLAG_QUEUED);
+	q->queue_flags |= (1 << QUEUE_FLAG_QUEUED | 1 << QUEUE_FLAG_TAGGED);
 	return 0;
 fail:
 	kfree(tags);
@@ -3589,6 +3591,26 @@ static ssize_t queue_max_hw_sectors_show
 	return queue_var_show(max_hw_sectors_kb, (page));
 }
 
+static ssize_t
+queue_tag_maint_store(struct request_queue *q, const char *page, size_t count)
+{
+	unsigned long tag_maint;
+	ssize_t ret = queue_var_store(&tag_maint, page, count);
+
+	if (blk_queue_queued(q)) {
+		if (tag_maint)
+			set_bit(QUEUE_FLAG_TAGGED, &q->queue_flags);
+		else
+			clear_bit(QUEUE_FLAG_TAGGED, &q->queue_flags);
+	}
+
+	return ret;
+}
+
+static ssize_t queue_tag_maint_show(struct request_queue *q, char *page)
+{
+	return queue_var_show(blk_queue_tagged(q), (page));
+}
 
 static struct queue_sysfs_entry queue_requests_entry = {
 	.attr = {.name = "nr_requests", .mode = S_IRUGO | S_IWUSR },
@@ -3619,12 +3641,19 @@ static struct queue_sysfs_entry queue_io
 	.store = elv_iosched_store,
 };
 
+static struct queue_sysfs_entry queue_tag_maint_entry = {
+	.attr = {.name = "tag_maint", .mode = S_IRUGO | S_IWUSR },
+	.show = queue_tag_maint_show,
+	.store = queue_tag_maint_store,
+};
+
 static struct attribute *default_attrs[] = {
 	&queue_requests_entry.attr,
 	&queue_ra_entry.attr,
 	&queue_max_hw_sectors_entry.attr,
 	&queue_max_sectors_entry.attr,
 	&queue_iosched_entry.attr,
+	&queue_tag_maint_entry.attr,
 	NULL,
 };
 
--- linux-2.6.14-rc3/include/linux/blkdev.h.orig	2005-10-06 19:14:45.193906379 -0700
+++ linux-2.6.14-rc3/include/linux/blkdev.h	2005-10-06 19:18:17.228083470 -0700
@@ -436,9 +436,11 @@ enum {
 #define QUEUE_FLAG_PLUGGED	7	/* queue is plugged */
 #define QUEUE_FLAG_DRAIN	8	/* draining queue for sched switch */
 #define QUEUE_FLAG_FLUSH	9	/* doing barrier flush sequence */
+#define QUEUE_FLAG_TAGGED	10	/* maintain per request tag */
 
 #define blk_queue_plugged(q)	test_bit(QUEUE_FLAG_PLUGGED, &(q)->queue_flags)
-#define blk_queue_tagged(q)	test_bit(QUEUE_FLAG_QUEUED, &(q)->queue_flags)
+#define blk_queue_queued(q)	test_bit(QUEUE_FLAG_QUEUED, &(q)->queue_flags)
+#define blk_queue_tagged(q)	test_bit(QUEUE_FLAG_TAGGED, &(q)->queue_flags)
 #define blk_queue_stopped(q)	test_bit(QUEUE_FLAG_STOPPED, &(q)->queue_flags)
 #define blk_queue_flushing(q)	test_bit(QUEUE_FLAG_FLUSH, &(q)->queue_flags)
 

