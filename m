Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265055AbUGZKOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265055AbUGZKOs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 06:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265091AbUGZKOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 06:14:48 -0400
Received: from mx1.elte.hu ([157.181.1.137]:11457 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265055AbUGZKOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 06:14:43 -0400
Date: Mon, 26 Jul 2004 12:15:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>, Jens Axboe <axboe@suse.de>
Cc: William Lee Irwin III <wli@holomorphy.com>, Lenar L?hmus <lenar@vision.ee>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-J4
Message-ID: <20040726101536.GA29408@elte.hu>
References: <20040713122805.GZ21066@holomorphy.com> <40F3F0A0.9080100@vision.ee> <20040713143947.GG21066@holomorphy.com> <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <20040726100103.GA29072@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040726100103.GA29072@elte.hu>
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


> Changes since -J3:
> 
>  - make block device max_sectors sysfs tunable. There's a new entry
>    /sys/block/*/queue/max_sectors_kb which stores the current max 
>    request size in KB. You can write it to change the size.
> 
>    Jens: i've attached a standalone patch against 2.6.8-rc2 below. 
>    Please apply if it looks good to you. (I've added extra locking to 
>    make sure max_sectors and readahead_pages gets updated at once, for 
>    the unlikely event of two CPUs updating max_sectors at once.) I've 
>    tested this on IDE using the UP kernel.

i've refined the patch (new version attached below): drivers use
blk_queue_max_sectors() to set the maximum # of sectors that the driver
or hw can handle.

so i've introduced a new queue entry called max_hw_sectors, and the new
/sys entry listens to this maximum and only updates max_sectors. This
entry is also exported to /sys as a readonly entry. (so that users can
see the maximum the driver supports.)

i've added another fix as well: do not allow users to set a max_sectors
value lower than the pagecache page size.

these changes should make the new tunable pretty fool-proof.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/include/linux/blkdev.h.orig	
+++ linux/include/linux/blkdev.h	
@@ -338,6 +338,7 @@ struct request_queue
 	unsigned int		nr_congestion_off;
 
 	unsigned short		max_sectors;
+	unsigned short		max_hw_sectors;
 	unsigned short		max_phys_segments;
 	unsigned short		max_hw_segments;
 	unsigned short		hardsect_size;
--- linux/drivers/block/ll_rw_blk.c.orig	
+++ linux/drivers/block/ll_rw_blk.c	
@@ -311,7 +311,7 @@ void blk_queue_max_sectors(request_queue
 		printk("%s: set to minimum %d\n", __FUNCTION__, max_sectors);
 	}
 
-	q->max_sectors = max_sectors;
+	q->max_sectors = q->max_hw_sectors = max_sectors;
 }
 
 EXPORT_SYMBOL(blk_queue_max_sectors);
@@ -3062,13 +3063,61 @@ queue_ra_store(struct request_queue *q, 
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
@@ -3081,9 +3130,22 @@ static struct queue_sysfs_entry queue_ra
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
 
