Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319409AbSILCGN>; Wed, 11 Sep 2002 22:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319411AbSILCGN>; Wed, 11 Sep 2002 22:06:13 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:61438 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319409AbSILCGG>; Wed, 11 Sep 2002 22:06:06 -0400
Message-Id: <200209120210.g8C2AkD26470@eng4.beaverton.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] sard changes for 2.5.34
Date: Wed, 11 Sep 2002 19:10:45 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch to put sard changes similar to those in 2.4 into 2.5.  I
say "similar" because the I/O subsystem has changed sufficiently in 2.5
that making them exactly the same might be more effort that it's
worth.  Still, we do record per-partition reads/writes/sectors, and
per-disk stats on the same plus queue time and number of I/O merges.
Once applied, "cat /proc/diskstats" outputs this information.

Because in 2.5.34, gendisk->part[0] no longer is an hd_struct that
refers to the whole disk, there wasn't a convenient place to record
this information.  I gratuitously added an hd_struct to gendisk to have
a place to store the information, below, but that's distasteful and
ugly. I'd like to move it to a different place.

Also, with this patch, we are collecting stats twice, once for these
stats and once for /proc/stat (kstat).  That's stupid and I'd like to
get the stats only once and use them, perhaps, in two places.

What follows works, but needs refinements.  Comments welcome.

Rick

diff -ru linux-2.5.34/drivers/block/genhd.c clnstat-2.5.34/drivers/block/genhd.c
--- linux-2.5.34/drivers/block/genhd.c	Mon Sep  9 10:35:11 2002
+++ clnstat-2.5.34/drivers/block/genhd.c	Wed Sep 11 17:59:51 2002
@@ -57,6 +57,7 @@
 			memset(p, 0, size);
 	}
 	gp->part = p;
+	memset(&gp->whole_disk, 0, sizeof(struct hd_struct));
 
 	write_lock(&gendisk_lock);
 
@@ -184,7 +185,116 @@
 	stop:	part_stop,
 	show:	show_partition
 };
-#endif
+
+/* iterator */
+static void *diskstats_start(struct seq_file *part, loff_t *pos)
+{
+	loff_t k = *pos;
+	struct gendisk *sgp;
+
+	read_lock(&gendisk_lock);
+	for (sgp = gendisk_head; sgp; sgp = sgp->next) {
+		if (!k--)
+			return sgp;
+	}
+	return NULL;
+}
+
+static void *diskstats_next(struct seq_file *part, void *v, loff_t *pos)
+{
+	++*pos;
+	return ((struct gendisk *)v)->next;
+}
+
+static void diskstats_stop(struct seq_file *part, void *v)
+{
+	read_unlock(&gendisk_lock);
+}
+
+#define MSEC(x) ((x) * 1000 / HZ)
+
+void dump_gendisk(struct seq_file *s)
+{
+	struct gendisk *gp = NULL;
+
+	read_lock(&gendisk_lock);
+	for (gp = gendisk_head; gp; gp = gp->next) {
+		seq_printf(s,
+		    "%8lx: major=%d, part=%8lx, first_minor=%d, minor_shift=%d\n",
+		    (unsigned long) gp,
+		    (int) gp->major,
+		    (unsigned long) gp->part,
+		    (int) gp->first_minor,
+		    (int) gp->minor_shift);
+	}
+	read_unlock(&gendisk_lock);
+}
+
+static int diskstats_show(struct seq_file *s, void *v)
+{
+	struct gendisk *gp = v;
+	char buf[64];
+	int n;
+	struct hd_struct *hd;
+
+	if (gp == gendisk_head) {
+		seq_puts(s, "          major minor  #blocks  name"
+			    "      rio   rmerge    rsect     ruse      wio"
+			    "   wmerge    wsect     wuse  running      use"
+			    "     aveq"
+			    "\n\n");
+	}
+
+	/* show the full disk ... */
+	hd = &gp->whole_disk;
+	if (hd) {
+	    disk_round_stats(hd);
+	    seq_printf(s, "%8x %4d  %4d %10ld %-5s "
+		      "%8d %8d %8d %8d %8d %8d %8d %8d %8d %8d %8d\n",
+		      (unsigned int) hd,
+		      gp->major, gp->first_minor,
+		      hd->nr_sects >> 1,
+		      disk_name(gp, 0, buf),
+		      hd->rd_ios, hd->rd_merges,
+		      hd->rd_sectors, MSEC(hd->rd_ticks),
+		      hd->wr_ios, hd->wr_merges,
+		      hd->wr_sectors, MSEC(hd->wr_ticks),
+		      hd->ios_in_flight, MSEC(hd->io_ticks),
+		      MSEC(hd->aveq));
+	}
+
+	/* ... and all non-0 size partitions of it */
+	for (n = 0; n < (1 << gp->minor_shift)-1; n++) {
+		if (gp->part[n].nr_sects) {
+			hd = &gp->part[n];
+			disk_round_stats(hd);
+			seq_printf(s, "%8x %4d  %4d %10ld %-5s "
+				      "%8d %8d %8d %8d %8d %8d %8d %8d %8d %8d %8d\n",
+				      (unsigned int) hd,
+				      gp->major, n + gp->first_minor + 1,
+				      hd->nr_sects >> 1,
+				      disk_name(gp, n + 1, buf),
+				      hd->rd_ios, hd->rd_merges,
+				      hd->rd_sectors, MSEC(hd->rd_ticks),
+				      hd->wr_ios, hd->wr_merges,
+				      hd->wr_sectors, MSEC(hd->wr_ticks),
+				      hd->ios_in_flight, MSEC(hd->io_ticks),
+				      MSEC(hd->aveq));
+		}
+	}
+	return 0;
+}
+
+#undef MSEC
+
+struct seq_operations diskstats_op = {
+	start:	diskstats_start,
+	next:	diskstats_next,
+	stop:	diskstats_stop,
+	show:	diskstats_show
+};
+
+#endif /* CONFIG_PROC_FS */
 
 
 extern int blk_dev_init(void);
diff -ru linux-2.5.34/drivers/block/ll_rw_blk.c clnstat-2.5.34/drivers/block/ll_rw_blk.c
--- linux-2.5.34/drivers/block/ll_rw_blk.c	Mon Sep  9 10:35:02 2002
+++ clnstat-2.5.34/drivers/block/ll_rw_blk.c	Wed Sep 11 18:24:25 2002
@@ -1329,6 +1329,164 @@
 }
 
 /*
+ * Return an hd_struct on which to do IO accounting for a given request.
+ */
+static struct hd_struct *locate_hd_struct(struct request *req)
+{
+	struct gendisk *gd;
+	int partition;
+	struct hd_struct *hd = NULL;
+
+	gd = get_gendisk(req->rq_dev);
+	if (gd) {
+		/*
+		 * need to get *just* the partition number here. minor() gives
+		 * us both the minor number and the partition number
+		 * combined. Note that starting in 2.5.34, gd->part[0] is the
+		 * first partition (partition 1), not the whole disk.
+		 */
+		partition =
+		    (minor(req->rq_dev) & ((1 << gd->minor_shift) - 1)) - 1;
+		if (partition < 0) {
+		    hd = &gd->whole_disk;
+		} else {
+		   hd = &gd->part[partition];
+		}
+	}
+	return hd;
+}
+
+/*
+ * Round off the performance stats on an hd_struct.
+ *
+ * The average IO queue length and utilisation statistics are maintained
+ * by observing the current state of the queue length and the amount of
+ * time it has been in this state for.
+ * Normally, that accounting is done on IO completion, but that can result
+ * in more than a second's worth of IO being accounted for within any one
+ * second, leading to >100% utilisation.  To deal with that, we do a
+ * round-off before returning the results when reading /proc/diskstats,
+ * accounting immediately for all queue usage up to the current jiffies and
+ * restarting the counters again.
+ */
+void disk_round_stats(struct hd_struct *hd)
+{
+	unsigned long now = jiffies;
+
+	hd->aveq += (hd->ios_in_flight * (jiffies - hd->last_queue_change));
+	hd->last_queue_change = now;
+
+	if (hd->ios_in_flight)
+		hd->io_ticks += (now - hd->last_idle_time);
+	hd->last_idle_time = now;	
+}
+
+static inline void down_ios(struct hd_struct *hd)
+{
+	disk_round_stats(hd);	
+	--hd->ios_in_flight;
+}
+
+static inline void up_ios(struct hd_struct *hd)
+{
+	disk_round_stats(hd);
+	++hd->ios_in_flight;
+}
+
+static void collect_part_stats(struct bio *bio)
+{
+	struct hd_struct *hd = NULL;
+	struct gendisk *gd;
+	kdev_t kdev;
+
+	kdev = to_kdev_t(bio->bi_bdev->bd_dev);
+	gd = get_gendisk(kdev);
+	if (gd) {
+		hd= &gd->part[(minor(kdev) & ((1 << gd->minor_shift) - 1)) - 1];
+	}
+
+	switch (bio->bi_rw) {
+	case READ:
+		if (hd) {
+			hd->rd_sectors += bio_sectors(bio);
+			hd->rd_ios++;
+		}
+		break;
+	case WRITE:
+		if (hd) {
+			hd->wr_sectors += bio_sectors(bio);
+			hd->wr_ios++;
+		}
+		break;
+	}
+}
+
+static void account_io_start(struct hd_struct *hd, struct request *req,
+			     int merge, int sectors)
+{
+	switch (rq_data_dir(req)) {
+	case WRITE:
+		if (merge)
+			hd->wr_merges++;
+		hd->wr_sectors += sectors;
+		break;
+	case READ:
+		if (merge)
+			hd->rd_merges++;
+		hd->rd_sectors += sectors;
+		break;
+	}
+	if (!merge)
+		up_ios(hd);
+}
+
+static void account_io_end(struct hd_struct *hd, struct request *req, int tag)
+{
+	unsigned long duration = jiffies - req->start_time;
+
+	switch (rq_data_dir(req)) {
+	case WRITE:
+		hd->wr_ticks += duration;
+		hd->wr_ios++;
+		break;
+	case READ:
+		hd->rd_ticks += duration;
+		hd->rd_ios++;
+		break;
+	}
+
+	down_ios(hd);
+}
+
+void req_new_io(struct request *req, int merge, int sectors)
+{
+	struct hd_struct *hd;
+
+	hd = locate_hd_struct(req);
+	if (hd)
+		account_io_start(hd, req, merge, sectors);
+}
+
+void req_merged_io(struct request *req)
+{
+	struct hd_struct *hd;
+
+	hd = locate_hd_struct(req);
+	if (hd)
+		down_ios(hd);
+}
+
+void req_finished_io(struct request *req, int tag)
+{
+	struct hd_struct *hd;
+
+	hd = locate_hd_struct(req);
+	if (hd)
+		account_io_end(hd, req, tag);
+}
+EXPORT_SYMBOL(req_finished_io);
+
+/*
  * add-request adds a request to the linked list.
  * queue lock is held and interrupts disabled, as we muck with the
  * request queue list.
@@ -1408,6 +1566,13 @@
 
 		elv_merge_requests(q, req, next);
 
+		/*
+		 * One last thing: we have removed a request, so we now
+		 * have one less expected IO to complete for accounting
+		 * purposes.
+		 */
+		req_merged_io(req);
+
 		blkdev_dequeue_request(next);
 		blk_put_request(next);
 	}
@@ -1510,6 +1675,7 @@
 			req->nr_sectors = req->hard_nr_sectors += nr_sectors;
 			elv_merge_cleanup(q, req, nr_sectors);
 			drive_stat_acct(req, nr_sectors, 0);
+			req_new_io(req, 1, nr_sectors);
 			attempt_back_merge(q, req);
 			goto out;
 
@@ -1534,6 +1700,7 @@
 			req->nr_sectors = req->hard_nr_sectors += nr_sectors;
 			elv_merge_cleanup(q, req, nr_sectors);
 			drive_stat_acct(req, nr_sectors, 0);
+			req_new_io(req, 1, nr_sectors);
 			attempt_front_merge(q, req);
 			goto out;
 
@@ -1602,6 +1769,8 @@
 	req->waiting = NULL;
 	req->bio = req->biotail = bio;
 	req->rq_dev = to_kdev_t(bio->bi_bdev->bd_dev);
+	req->start_time = jiffies;
+	req_new_io(req, 0, nr_sectors);
 	add_request(q, req, insert_here);
 out:
 	if (freereq)
@@ -1706,6 +1875,12 @@
 		BUG_ON(bio_sectors(bio) > q->max_sectors);
 
 		/*
+		 * collect per-partition i/o stats before we lose track
+		 * of which partition this was.
+		 */
+		collect_part_stats(bio);
+		
+		/*
 		 * If this device has partitions, remap block n
 		 * of partition p to block n+start(p) of the disk.
 		 */
@@ -2040,6 +2215,7 @@
 	if (req->waiting)
 		complete(req->waiting);
 
+	req_finished_io(req,0);
 	blk_put_request(req);
 }
 
diff -ru linux-2.5.34/fs/proc/proc_misc.c clnstat-2.5.34/fs/proc/proc_misc.c
--- linux-2.5.34/fs/proc/proc_misc.c	Mon Sep  9 10:35:03 2002
+++ clnstat-2.5.34/fs/proc/proc_misc.c	Mon Sep  9 19:03:41 2002
@@ -261,6 +261,18 @@
 	release:	seq_release,
 };
 
+extern struct seq_operations diskstats_op;
+static int diskstats_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &diskstats_op);
+}
+static struct file_operations proc_diskstats_operations = {
+	open:		diskstats_open,
+	read:		seq_read,
+	llseek:		seq_lseek,
+	release:	seq_release,
+};
+
 #ifdef CONFIG_MODULES
 extern struct seq_operations modules_op;
 static int modules_open(struct inode *inode, struct file *file)
@@ -624,6 +636,7 @@
 	create_seq_entry("partitions", 0, &proc_partitions_operations);
 	create_seq_entry("interrupts", 0, &proc_interrupts_operations);
 	create_seq_entry("slabinfo",S_IWUSR|S_IRUGO,&proc_slabinfo_operations);
+	create_seq_entry("diskstats", 0, &proc_diskstats_operations);
 #ifdef CONFIG_MODULES
 	create_seq_entry("modules", 0, &proc_modules_operations);
 	create_seq_entry("ksyms", 0, &proc_ksyms_operations);
diff -ru linux-2.5.34/include/linux/blkdev.h clnstat-2.5.34/include/linux/blkdev.h
--- linux-2.5.34/include/linux/blkdev.h	Mon Sep  9 10:35:05 2002
+++ clnstat-2.5.34/include/linux/blkdev.h	Mon Sep  9 19:03:41 2002
@@ -36,6 +36,7 @@
 	kdev_t rq_dev;
 	int errors;
 	sector_t sector;
+	unsigned long start_time;
 	unsigned long nr_sectors;
 	unsigned long hard_sector;	/* the hard_* are block layer
 					 * internals, no driver should
diff -ru linux-2.5.34/include/linux/genhd.h clnstat-2.5.34/include/linux/genhd.h
--- linux-2.5.34/include/linux/genhd.h	Mon Sep  9 10:35:03 2002
+++ clnstat-2.5.34/include/linux/genhd.h	Wed Sep 11 18:01:10 2002
@@ -63,6 +63,21 @@
 	unsigned long nr_sects;
 	devfs_handle_t de;              /* primary (master) devfs entry  */
 	struct device hd_driverfs_dev;  /* support driverfs hiearchy     */
+	/* Performance stats: */
+	unsigned int ios_in_flight;
+	unsigned int io_ticks;
+	unsigned int last_idle_time;
+	unsigned int last_queue_change;
+	unsigned int aveq;
+
+	unsigned int rd_ios;
+	unsigned int rd_merges;
+	unsigned int rd_ticks;
+	unsigned int rd_sectors;
+	unsigned int wr_ios;
+	unsigned int wr_merges;
+	unsigned int wr_ticks;
+	unsigned int wr_sectors;	
 };
 
 #define GENHD_FL_REMOVABLE  1
@@ -76,7 +91,8 @@
 	int minor_shift;		/* number of times minor is shifted to
 					   get real minor */
 
-	struct hd_struct *part;		/* [indexed by minor] */
+	struct hd_struct *part;		/* [indexed by minor-1] */
+	struct hd_struct whole_disk;
 	struct gendisk *next;
 	struct block_device_operations *fops;
 	sector_t capacity;
@@ -265,6 +281,12 @@
 	return g ? (minor(dev) >> g->minor_shift) : 0;
 }
 
+struct request;
+extern void disk_round_stats(struct hd_struct *hd);
+extern void req_new_io(struct request *req, int merge, int sectors);
+extern void req_merged_io(struct request *req);
+extern void req_finished_io(struct request *req, int tag);
+
 #endif
 
 #endif
