Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269085AbUIHKEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269085AbUIHKEP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 06:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269089AbUIHKEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 06:04:15 -0400
Received: from mx2.elte.hu ([157.181.151.9]:45989 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269085AbUIHKDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 06:03:30 -0400
Date: Wed, 8 Sep 2004 12:04:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [patch] max-sectors-2.6.9-rc1-bk14-A0
Message-ID: <20040908100448.GA4994@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
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


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


this is a re-send of the max-sectors patch against 2.6.9-rc1-bk14.

the attached patch introduces two new /sys/block values:

  /sys/block/*/queue/max_hw_sectors_kb
  /sys/block/*/queue/max_sectors_kb

max_hw_sectors_kb is the maximum that the driver can handle and is
readonly. max_sectors_kb is the current max_sectors value and can be
tuned by root. PAGE_SIZE granularity is enforced.

It's all locking-safe and all affected layered drivers have been updated
as well. The patch has been in testing for a couple of weeks already as
part of the voluntary-preempt patches and it works just fine - people
use it to reduce IDE IRQ handling latencies. Please apply.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

	Ingo

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="max-sectors-2.6.9-rc1-bk14-A0"

--- linux/include/linux/blkdev.h.orig	
+++ linux/include/linux/blkdev.h	
@@ -344,6 +344,7 @@ struct request_queue
 	unsigned int		nr_congestion_off;
 
 	unsigned short		max_sectors;
+	unsigned short		max_hw_sectors;
 	unsigned short		max_phys_segments;
 	unsigned short		max_hw_segments;
 	unsigned short		hardsect_size;
--- linux/drivers/block/ll_rw_blk.c.orig	
+++ linux/drivers/block/ll_rw_blk.c	
@@ -352,7 +352,7 @@ void blk_queue_max_sectors(request_queue
 		printk("%s: set to minimum %d\n", __FUNCTION__, max_sectors);
 	}
 
-	q->max_sectors = max_sectors;
+	q->max_sectors = q->max_hw_sectors = max_sectors;
 }
 
 EXPORT_SYMBOL(blk_queue_max_sectors);
@@ -454,7 +454,8 @@ EXPORT_SYMBOL(blk_queue_hardsect_size);
 void blk_queue_stack_limits(request_queue_t *t, request_queue_t *b)
 {
 	/* zero is "infinity" */
-	t->max_sectors = min_not_zero(t->max_sectors,b->max_sectors);
+	t->max_sectors = t->max_hw_sectors =
+		min_not_zero(t->max_sectors,b->max_sectors);
 
 	t->max_phys_segments = min(t->max_phys_segments,b->max_phys_segments);
 	t->max_hw_segments = min(t->max_hw_segments,b->max_hw_segments);
@@ -2583,11 +2584,11 @@ end_io:
 			break;
 		}
 
-		if (unlikely(bio_sectors(bio) > q->max_sectors)) {
+		if (unlikely(bio_sectors(bio) > q->max_hw_sectors)) {
 			printk("bio too big device %s (%u > %u)\n", 
 				bdevname(bio->bi_bdev, b),
 				bio_sectors(bio),
-				q->max_sectors);
+				q->max_hw_sectors);
 			goto end_io;
 		}
 
@@ -3206,13 +3207,61 @@ queue_ra_store(struct request_queue *q, 
 	unsigned long ra_kb;
 	ssize_t ret = queue_var_store(&ra_kb, page, count);
 
+	spin_lock_irq(q->queue_lock);
 	if (ra_kb > (q->max_sectors >> 1))
 		ra_kb = (q->max_sectors >> 1);
 
 	q->backing_dev_info.ra_pages = ra_kb >> (PAGE_CACHE_SHIFT - 10);
+	spin_unlock_irq(q->queue_lock);
+
 	return ret;
 }
 
+static ssize_t queue_max_sectors_show(struct request_queue *q, char *page)
+{
+	int max_sectors_kb = q->max_sectors >> 1;
+
+	return queue_var_show(max_sectors_kb, (page));
+}
+
+static ssize_t
+queue_max_sectors_store(struct request_queue *q, const char *page, size_t count)
+{
+	unsigned long max_sectors_kb,
+			max_hw_sectors_kb = q->max_hw_sectors >> 1,
+			page_kb = 1 << (PAGE_CACHE_SHIFT - 10);
+	ssize_t ret = queue_var_store(&max_sectors_kb, page, count);
+	int ra_kb;
+
+	if (max_sectors_kb > max_hw_sectors_kb || max_sectors_kb < page_kb)
+		return -EINVAL;
+	/*
+	 * Take the queue lock to update the readahead and max_sectors
+	 * values synchronously:
+	 */
+	spin_lock_irq(q->queue_lock);
+	/*
+	 * Trim readahead window as well, if necessary:
+	 */
+	ra_kb = q->backing_dev_info.ra_pages << (PAGE_CACHE_SHIFT - 10);
+	if (ra_kb > max_sectors_kb)
+		q->backing_dev_info.ra_pages =
+				max_sectors_kb >> (PAGE_CACHE_SHIFT - 10);
+
+	q->max_sectors = max_sectors_kb << 1;
+	spin_unlock_irq(q->queue_lock);
+
+	return ret;
+}
+
+static ssize_t queue_max_hw_sectors_show(struct request_queue *q, char *page)
+{
+	int max_hw_sectors_kb = q->max_hw_sectors >> 1;
+
+	return queue_var_show(max_hw_sectors_kb, (page));
+}
+
+
 static struct queue_sysfs_entry queue_requests_entry = {
 	.attr = {.name = "nr_requests", .mode = S_IRUGO | S_IWUSR },
 	.show = queue_requests_show,
@@ -3225,9 +3274,22 @@ static struct queue_sysfs_entry queue_ra
 	.store = queue_ra_store,
 };
 
+static struct queue_sysfs_entry queue_max_sectors_entry = {
+	.attr = {.name = "max_sectors_kb", .mode = S_IRUGO | S_IWUSR },
+	.show = queue_max_sectors_show,
+	.store = queue_max_sectors_store,
+};
+
+static struct queue_sysfs_entry queue_max_hw_sectors_entry = {
+	.attr = {.name = "max_hw_sectors_kb", .mode = S_IRUGO },
+	.show = queue_max_hw_sectors_show,
+};
+
 static struct attribute *default_attrs[] = {
 	&queue_requests_entry.attr,
 	&queue_ra_entry.attr,
+	&queue_max_hw_sectors_entry.attr,
+	&queue_max_sectors_entry.attr,
 	NULL,
 };
 
--- linux/drivers/md/dm-table.c.orig	
+++ linux/drivers/md/dm-table.c	
@@ -825,7 +825,7 @@ void dm_table_set_restrictions(struct dm
 	 * Make sure we obey the optimistic sub devices
 	 * restrictions.
 	 */
-	q->max_sectors = t->limits.max_sectors;
+	blk_queue_max_sectors(q, t->limits.max_sectors);
 	q->max_phys_segments = t->limits.max_phys_segments;
 	q->max_hw_segments = t->limits.max_hw_segments;
 	q->hardsect_size = t->limits.hardsect_size;
--- linux/drivers/md/linear.c.orig	
+++ linux/drivers/md/linear.c	
@@ -157,7 +157,7 @@ static int linear_run (mddev_t *mddev)
 		 */
 		if (rdev->bdev->bd_disk->queue->merge_bvec_fn &&
 		    mddev->queue->max_sectors > (PAGE_SIZE>>9))
-			mddev->queue->max_sectors = (PAGE_SIZE>>9);
+			blk_queue_max_sectors(mddev->queue, PAGE_SIZE>>9);
 
 		disk->size = rdev->size;
 		mddev->array_size += rdev->size;
--- linux/drivers/md/multipath.c.orig	
+++ linux/drivers/md/multipath.c	
@@ -325,7 +325,7 @@ static int multipath_add_disk(mddev_t *m
 		 */
 			if (rdev->bdev->bd_disk->queue->merge_bvec_fn &&
 			    mddev->queue->max_sectors > (PAGE_SIZE>>9))
-				mddev->queue->max_sectors = (PAGE_SIZE>>9);
+				blk_queue_max_sectors(mddev->queue, PAGE_SIZE>>9);
 
 			conf->working_disks++;
 			rdev->raid_disk = path;
@@ -479,7 +479,7 @@ static int multipath_run (mddev_t *mddev
 		 * a merge_bvec_fn to be involved in multipath */
 		if (rdev->bdev->bd_disk->queue->merge_bvec_fn &&
 		    mddev->queue->max_sectors > (PAGE_SIZE>>9))
-			mddev->queue->max_sectors = (PAGE_SIZE>>9);
+			blk_queue_max_sectors(mddev->queue, PAGE_SIZE>>9);
 
 		if (!rdev->faulty) 
 			conf->working_disks++;
--- linux/drivers/md/raid0.c.orig	
+++ linux/drivers/md/raid0.c	
@@ -162,7 +162,7 @@ static int create_strip_zones (mddev_t *
 
 		if (rdev1->bdev->bd_disk->queue->merge_bvec_fn &&
 		    mddev->queue->max_sectors > (PAGE_SIZE>>9))
-			mddev->queue->max_sectors = (PAGE_SIZE>>9);
+			blk_queue_max_sectors(mddev->queue, PAGE_SIZE>>9);
 
 		if (!smallest || (rdev1->size <smallest->size))
 			smallest = rdev1;
--- linux/drivers/md/raid1.c.orig	
+++ linux/drivers/md/raid1.c	
@@ -753,7 +753,7 @@ static int raid1_add_disk(mddev_t *mddev
 			 */
 			if (rdev->bdev->bd_disk->queue->merge_bvec_fn &&
 			    mddev->queue->max_sectors > (PAGE_SIZE>>9))
-				mddev->queue->max_sectors = (PAGE_SIZE>>9);
+				blk_queue_max_sectors(mddev->queue, PAGE_SIZE>>9);
 
 			p->head_position = 0;
 			rdev->raid_disk = mirror;
@@ -1196,7 +1196,7 @@ static int run(mddev_t *mddev)
 		 */
 		if (rdev->bdev->bd_disk->queue->merge_bvec_fn &&
 		    mddev->queue->max_sectors > (PAGE_SIZE>>9))
-			mddev->queue->max_sectors = (PAGE_SIZE>>9);
+			blk_queue_max_sectors(mddev->queue, PAGE_SIZE>>9);
 
 		disk->head_position = 0;
 		if (!rdev->faulty && rdev->in_sync)

--k1lZvvs/B4yU6o8G--
