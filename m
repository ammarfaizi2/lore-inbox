Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264368AbTDKNuk (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 09:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264369AbTDKNuk (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 09:50:40 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:51157 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264368AbTDKNub (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 09:50:31 -0400
Date: Fri, 11 Apr 2003 16:02:16 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] automatic acoustic management
Message-ID: <20030411140216.GI9776@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a little something to play with on your laptop, if you are bored
this weekend. It adds automatic adjustment of the acoustic level of the
drive, mainly to conserve power.

How does it work? Well, it adjusts the acoustic level of the drive
depending on the current io pattern. If you have a high rate of ios/sec,
we enable fast speed of the drive (consuming more power, but also being
somewhat quicker). When the io rate drops down, we set quiet operation.

There are no knobs to tune, except in the source. It's not really clear
whether this even wants to be handled in the kernel. But a quick
prototype cannot hurt, and it could potentially be used for other types
of power management as well.

The source knobs (and the default settings):

BLK_POWER_HIGH_MARK	50
BLK_POWER_HIGH_CYCLE	(2 * HZ)

"If the io rate exceeds 50 ios/sec for a duration of 2 seconds or more,
set fast drive operation".

BLK_POWER_LOW_MARK	10
BLK_POWER_LOW_CYCLE	(60 * HZ)

"If the io rate drops below 10 ios/sec for a duration of 60 seconds, set
quiet drive operation".

Being a debug patch and all, it even dumps the state changes to dmesg:

blk_power_timer: iorate=5, switching to quiet operation
blk_power_acct: iorate=637, switching to fast operation
blk_power_timer: iorate=0, switching to quiet operation

This will work for any ide drives that support acoustic management, so
that includes most desktop drives as well I suppose.

Patch is against 2.4.21-pre7 (sort of, should apply to 2.4.21-pre7
pristine).

===== drivers/block/ll_rw_blk.c 1.40 vs edited =====
--- 1.40/drivers/block/ll_rw_blk.c	Sat Apr  5 02:22:07 2003
+++ edited/drivers/block/ll_rw_blk.c	Fri Apr 11 13:13:04 2003
@@ -375,6 +375,66 @@
 	spin_unlock_irqrestore(&io_request_lock, flags);
 }
 
+void blk_set_power_fn(request_queue_t *q, power_fn *pfn)
+{
+	q->power_fn = pfn;
+}
+
+/*
+ * task context for switching to lower power state
+ */
+static void blk_power_task(void *data)
+{
+	request_queue_t *q = data;
+
+	/*
+	 * never there, or perhaps cancelled
+	 */
+	if (!q->power_change)
+		return;
+
+	q->power_change = 0;
+	q->power_fn(q);
+
+	if (q->power_state == BLK_POWER_HIGH)
+		mod_timer(&q->power_timer, jiffies + HZ);
+
+	q->sample_ios = -1;
+}
+
+/*
+ * checks whether it's time to set low power mode again
+ */
+static void blk_power_timer(unsigned long data)
+{
+	request_queue_t *q = (request_queue_t *) data;
+	int iorate;
+
+	if (q->power_state == BLK_POWER_LOW)
+		return;
+
+	/*
+	 * haven't sampled for long enough
+	 */
+	if (time_before(jiffies, q->sample_start + BLK_POWER_LOW_CYCLE))
+		goto out_timer;
+
+	/*
+	 * we have a sample, check if we need to change
+	 */
+	iorate = (q->sample_ios * HZ) / (jiffies - q->sample_start);
+	if (iorate <= BLK_POWER_LOW_MARK) {
+		printk("%s: iorate=%d, switching to quiet operation\n", __FUNCTION__, iorate);
+		q->power_change = 1;
+		q->power_state = BLK_POWER_LOW;
+		schedule_task(&q->power_task);
+		return;
+	}
+	q->sample_ios = -1;
+out_timer:
+	mod_timer(&q->power_timer, jiffies + HZ);
+}
+
 /** blk_grow_request_list
  *  @q: The &request_queue_t
  *  @nr_requests: how many requests are desired
@@ -501,6 +561,15 @@
 	q->head_active    	= 1;
 
 	blk_queue_bounce_limit(q, BLK_BOUNCE_HIGH);
+
+	q->power_state		= BLK_POWER_LOW;
+	q->power_change		= 0;
+	q->power_timer.data	= (unsigned long) q;
+	q->power_timer.function	= blk_power_timer;
+	init_timer(&q->power_timer);
+	q->sample_start		= 0;
+	q->sample_ios		= 0;
+	INIT_TQUEUE(&q->power_task, blk_power_task, q);
 }
 
 #define blkdev_free_rq(list) list_entry((list)->next, struct request, queue);
@@ -651,6 +720,52 @@
 		printk(KERN_ERR "drive_stat_acct: cmd not R/W?\n");
 }
 
+static void blk_power_acct(request_queue_t *q)
+{
+	int iorate;
+
+	if (!q->power_fn)
+		return;
+
+	/*
+	 * start a new sample
+	 */
+	if (q->sample_ios == -1) {
+		q->sample_start = jiffies;
+		q->sample_ios = 0;
+	}
+
+	q->sample_ios++;
+
+	/*
+	 * already going full speed
+	 */
+	if (q->power_state == BLK_POWER_HIGH)
+		return;
+
+	/*
+	 * haven't sampled for long enough
+	 */
+	if (time_before(jiffies, q->sample_start + BLK_POWER_HIGH_CYCLE))
+		return;
+
+	/*
+	 * we have a sample, check if we need to change
+	 */
+	iorate = (q->sample_ios * HZ) / (jiffies - q->sample_start);
+	if (iorate >= BLK_POWER_HIGH_MARK) {
+		printk("%s: iorate=%d, switching to fast operation\n", __FUNCTION__, iorate);
+		q->power_state = BLK_POWER_HIGH;
+		q->power_change = 1;
+		schedule_task(&q->power_task);
+	}
+
+	/*
+	 * expire this sample
+	 */
+	q->sample_ios = -1;
+}
+
 #ifdef CONFIG_BLK_STATS
 /*
  * Return up to two hd_structs on which to do IO accounting for a given
@@ -799,6 +914,7 @@
 			       struct list_head *insert_here)
 {
 	drive_stat_acct(req->rq_dev, req->cmd, req->nr_sectors, 1);
+	blk_power_acct(q);
 
 	if (!q->plugged && q->head_active && insert_here == &q->queue_head) {
 		spin_unlock_irq(&io_request_lock);
===== drivers/ide/ide-disk.c 1.16 vs edited =====
--- 1.16/drivers/ide/ide-disk.c	Fri Apr 11 13:00:02 2003
+++ edited/drivers/ide/ide-disk.c	Fri Apr 11 15:50:05 2003
@@ -1550,6 +1550,17 @@
 	return 0;
 }
 
+static void idedisk_power_fn(request_queue_t *q)
+{
+	ide_drive_t *drive = q->queuedata;
+	int arg = 0x80;
+
+	if (q->power_state == BLK_POWER_HIGH)
+		arg = 0xfe;
+
+	set_acoustic(drive, arg);
+}
+
 static int probe_lba_addressing (ide_drive_t *drive, int arg)
 {
 	drive->addressing =  0;
@@ -1733,6 +1744,12 @@
 	drive->no_io_32bit = id->dword_io ? 1 : 0;
 	if (drive->id->cfs_enable_2 & 0x3000)
 		write_cache(drive, (id->cfs_enable_2 & 0x3000));
+
+	/*
+	 * acoustic management supported
+	 */
+	if ((id->command_set_2 & 0x200) && (id->cfs_enable_2 & 0x200))
+		blk_set_power_fn(&drive->queue, idedisk_power_fn);
 }
 
 static int idedisk_cleanup(ide_drive_t *drive)
===== drivers/ide/ide-io.c 1.3 vs edited =====
--- 1.3/drivers/ide/ide-io.c	Fri Apr  4 23:08:33 2003
+++ edited/drivers/ide/ide-io.c	Fri Apr 11 13:13:04 2003
@@ -893,7 +893,9 @@
  */
 void do_ide_request(request_queue_t *q)
 {
-	ide_do_request(q->queuedata, IDE_NO_IRQ);
+	ide_drive_t *drive = q->queuedata;
+
+	ide_do_request(HWGROUP(drive), IDE_NO_IRQ);
 }
 
 /*
===== drivers/ide/ide-probe.c 1.26 vs edited =====
--- 1.26/drivers/ide/ide-probe.c	Fri Apr 11 08:43:31 2003
+++ edited/drivers/ide/ide-probe.c	Fri Apr 11 13:13:04 2003
@@ -970,8 +970,8 @@
 {
 	request_queue_t *q = &drive->queue;
 
-	q->queuedata = HWGROUP(drive);
 	blk_init_queue(q, do_ide_request);
+	q->queuedata = drive;
 }
 
 #undef __IRQ_HELL_SPIN
===== include/linux/blkdev.h 1.24 vs edited =====
--- 1.24/include/linux/blkdev.h	Tue Dec 24 08:57:30 2002
+++ edited/include/linux/blkdev.h	Fri Apr 11 13:14:17 2003
@@ -63,6 +63,7 @@
 typedef int (make_request_fn) (request_queue_t *q, int rw, struct buffer_head *bh);
 typedef void (plug_device_fn) (request_queue_t *q, kdev_t device);
 typedef void (unplug_device_fn) (void *q);
+typedef void (power_fn) (request_queue_t *);
 
 /*
  * Default nr free requests per queue, ll_rw_blk will scale it down
@@ -75,6 +76,17 @@
 	struct list_head free;
 };
 
+enum blk_power_state {
+	BLK_POWER_HIGH,
+	BLK_POWER_LOW,
+};
+
+#define BLK_POWER_LOW_MARK	(10)
+#define BLK_POWER_HIGH_MARK	(50)
+
+#define BLK_POWER_HIGH_CYCLE	(2 * HZ)
+#define BLK_POWER_LOW_CYCLE	(60 * HZ)
+
 struct request_queue
 {
 	/*
@@ -104,6 +116,19 @@
 	merge_requests_fn	* merge_requests_fn;
 	make_request_fn		* make_request_fn;
 	plug_device_fn		* plug_device_fn;
+	power_fn		* power_fn;
+
+	/*
+	 * power management stuff
+	 */
+	char			power_state;
+	char			power_change;
+	struct timer_list	power_timer;
+	struct tq_struct	power_task;
+
+	unsigned long		sample_start;
+	unsigned int		sample_ios;
+
 	/*
 	 * The queue owner gets to use this for whatever they like.
 	 * ll_rw_blk doesn't touch it.
@@ -228,6 +253,7 @@
 extern void blk_queue_make_request(request_queue_t *, make_request_fn *);
 extern void generic_unplug_device(void *);
 extern inline int blk_seg_merge_ok(struct buffer_head *, struct buffer_head *);
+extern void blk_set_power_fn(request_queue_t *, power_fn *);
 
 extern int * blk_size[MAX_BLKDEV];
 
 

-- 
Jens Axboe

