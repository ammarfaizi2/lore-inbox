Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267758AbTBYHH4>; Tue, 25 Feb 2003 02:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267762AbTBYHH4>; Tue, 25 Feb 2003 02:07:56 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:28099 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267758AbTBYHHv>;
	Tue, 25 Feb 2003 02:07:51 -0500
Date: Tue, 25 Feb 2003 13:06:54 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, Rick Lindsley <ricklind@us.ibm.com>
Subject: [patch] Make diskstats per-cpu using kmalloc_percpu
Message-ID: <20030225073654.GB28052@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
Sometime back you'd asked for this on irc.  This version makes
the disk stats on struct gendisk per-cpu.  I am working on making the
per partition stats per-cpu too (struct hd_struct), Meanwhile, I was 
wondering if this can get some testing on the -mm tree.  Patch has been 
tested on a PIII 4way in smp and up configurations. Applies on 2.5.63.

Thanks,
Kiran


 drivers/block/genhd.c     |   23 +++++++---
 drivers/block/ll_rw_blk.c |   29 +++++++------
 drivers/md/md.c           |    4 +
 fs/partitions/check.c     |    8 ---
 include/linux/genhd.h     |   97 ++++++++++++++++++++++++++++++++++++++++++----
 5 files changed, 124 insertions(+), 37 deletions(-)

diff -ruN -X dontdiff linux-2.5.62/drivers/block/genhd.c diskstat-2.5.62/drivers/block/genhd.c
--- linux-2.5.62/drivers/block/genhd.c	Tue Feb 18 04:26:14 2003
+++ diskstat-2.5.62/drivers/block/genhd.c	Wed Feb 19 15:44:47 2003
@@ -328,14 +328,16 @@
 		"%8u %8u %8llu %8u "
 		"%8u %8u %8u"
 		"\n",
-		disk->reads, disk->read_merges,
-		(unsigned long long)disk->read_sectors,
-		jiffies_to_msec(disk->read_ticks),
-		disk->writes, disk->write_merges,
-		(unsigned long long)disk->write_sectors,
-		jiffies_to_msec(disk->write_ticks),
-		disk->in_flight, jiffies_to_msec(disk->io_ticks),
-		jiffies_to_msec(disk->time_in_queue));
+		DISK_STAT_READ(disk, reads), DISK_STAT_READ(disk, read_merges),
+		(unsigned long long)DISK_STAT_READ(disk, read_sectors),
+		jiffies_to_msec(DISK_STAT_READ(disk, read_ticks)),
+		DISK_STAT_READ(disk, writes), 
+		DISK_STAT_READ(disk, write_merges),
+		(unsigned long long)DISK_STAT_READ(disk, write_sectors),
+		jiffies_to_msec(DISK_STAT_READ(disk, write_ticks)),
+		DISK_STAT_READ(disk, in_flight), 
+		jiffies_to_msec(DISK_STAT_READ(disk, io_ticks)),
+		jiffies_to_msec(DISK_STAT_READ(disk, time_in_queue)));
 }
 static struct disk_attribute disk_attr_dev = {
 	.attr = {.name = "dev", .mode = S_IRUGO },
@@ -367,6 +369,7 @@
 	struct gendisk *disk = to_disk(kobj);
 	kfree(disk->random);
 	kfree(disk->part);
+	free_disk_stats(disk);
 	kfree(disk);
 }
 
@@ -386,6 +389,10 @@
 	struct gendisk *disk = kmalloc(sizeof(struct gendisk), GFP_KERNEL);
 	if (disk) {
 		memset(disk, 0, sizeof(struct gendisk));
+		if (!init_disk_stats(disk)) {
+			kfree(disk);
+			return NULL;
+		}
 		if (minors > 1) {
 			int size = (minors - 1) * sizeof(struct hd_struct);
 			disk->part = kmalloc(size, GFP_KERNEL);
diff -ruN -X dontdiff linux-2.5.62/drivers/block/ll_rw_blk.c diskstat-2.5.62/drivers/block/ll_rw_blk.c
--- linux-2.5.62/drivers/block/ll_rw_blk.c	Tue Feb 18 04:25:53 2003
+++ diskstat-2.5.62/drivers/block/ll_rw_blk.c	Thu Feb 20 12:07:18 2003
@@ -1474,17 +1474,17 @@
 		return;
 
 	if (rw == READ) {
-		rq->rq_disk->read_sectors += nr_sectors;
+		DISK_STAT_ADD(rq->rq_disk, read_sectors, nr_sectors);
 		if (!new_io)
-			rq->rq_disk->read_merges++;
+			DISK_STAT_INC(rq->rq_disk, read_merges);
 	} else if (rw == WRITE) {
-		rq->rq_disk->write_sectors += nr_sectors;
+		DISK_STAT_ADD(rq->rq_disk, write_sectors, nr_sectors);
 		if (!new_io)
-			rq->rq_disk->write_merges++;
+			DISK_STAT_INC(rq->rq_disk, write_merges);
 	}
 	if (new_io) {
 		disk_round_stats(rq->rq_disk);
-		rq->rq_disk->in_flight++;
+		DISK_STAT_INC(rq->rq_disk, in_flight);
 	}
 }
 
@@ -1524,11 +1524,12 @@
 {
 	unsigned long now = jiffies;
 
-	disk->time_in_queue += disk->in_flight * (now - disk->stamp);
+	DISK_STAT_ADD(disk, time_in_queue, 
+			DISK_STAT_READ(disk, in_flight) * (now - disk->stamp));
 	disk->stamp = now;
 
-	if (disk->in_flight)
-		disk->io_ticks += (now - disk->stamp_idle);
+	if (DISK_STAT_READ(disk, in_flight))
+		DISK_STAT_ADD(disk, io_ticks, (now - disk->stamp_idle));
 	disk->stamp_idle = now;
 }
 
@@ -1646,7 +1647,7 @@
 
 		if (req->rq_disk) {
 			disk_round_stats(req->rq_disk);
-			req->rq_disk->in_flight--;
+			DISK_STAT_DEC(req->rq_disk, in_flight);
 		}
 
 		__blk_put_request(q, next);
@@ -2198,16 +2199,16 @@
 		unsigned long duration = jiffies - req->start_time;
 		switch (rq_data_dir(req)) {
 		    case WRITE:
-			disk->writes++;
-			disk->write_ticks += duration;
+			DISK_STAT_INC(disk, writes);
+			DISK_STAT_ADD(disk, write_ticks, duration);
 			break;
 		    case READ:
-			disk->reads++;
-			disk->read_ticks += duration;
+			DISK_STAT_INC(disk, reads);
+			DISK_STAT_ADD(disk, read_ticks, duration);
 			break;
 		}
 		disk_round_stats(disk);
-		disk->in_flight--;
+		DISK_STAT_DEC(disk, in_flight);
 	}
 	__blk_put_request(req->q, req);
 }
diff -ruN -X dontdiff linux-2.5.62/drivers/md/md.c diskstat-2.5.62/drivers/md/md.c
--- linux-2.5.62/drivers/md/md.c	Tue Feb 18 04:26:10 2003
+++ diskstat-2.5.62/drivers/md/md.c	Wed Feb 19 15:56:38 2003
@@ -2771,7 +2771,9 @@
 	idle = 1;
 	ITERATE_RDEV(mddev,rdev,tmp) {
 		struct gendisk *disk = rdev->bdev->bd_contains->bd_disk;
-		curr_events = disk->read_sectors + disk->write_sectors - disk->sync_io;
+		curr_events = DISK_STAT_READ(disk, read_sectors) + 
+				DISK_STAT_READ(disk, write_sectors) - 
+				disk->sync_io;
 		if ((curr_events - rdev->last_events) > 32) {
 			rdev->last_events = curr_events;
 			idle = 0;
diff -ruN -X dontdiff linux-2.5.62/fs/partitions/check.c diskstat-2.5.62/fs/partitions/check.c
--- linux-2.5.62/fs/partitions/check.c	Tue Feb 18 04:26:56 2003
+++ diskstat-2.5.62/fs/partitions/check.c	Wed Feb 19 16:48:13 2003
@@ -503,13 +503,7 @@
 	disk->capacity = 0;
 	disk->flags &= ~GENHD_FL_UP;
 	unlink_gendisk(disk);
-	disk->reads = disk->writes = 0;
-	disk->read_sectors = disk->write_sectors = 0;
-	disk->read_merges = disk->write_merges = 0;
-	disk->read_ticks = disk->write_ticks = 0;
-	disk->in_flight = 0;
-	disk->io_ticks = 0;
-	disk->time_in_queue = 0;
+	disk_stat_set_all(disk, 0);
 	disk->stamp = disk->stamp_idle = 0;
 	devfs_remove_partitions(disk);
 	if (disk->driverfs_dev) {
diff -ruN -X dontdiff linux-2.5.62/include/linux/genhd.h diskstat-2.5.62/include/linux/genhd.h
--- linux-2.5.62/include/linux/genhd.h	Tue Feb 18 04:25:57 2003
+++ diskstat-2.5.62/include/linux/genhd.h	Thu Feb 20 12:05:14 2003
@@ -73,6 +73,16 @@
 #define GENHD_FL_CD	8
 #define GENHD_FL_UP	16
 
+struct disk_stats {
+	unsigned read_sectors, write_sectors;
+	unsigned reads, writes;
+	unsigned read_merges, write_merges;
+	unsigned read_ticks, write_ticks;
+	unsigned io_ticks;
+	int in_flight;
+	unsigned time_in_queue;
+};
+	
 struct gendisk {
 	int major;			/* major number of driver */
 	int first_minor;
@@ -97,16 +107,89 @@
 	int policy;
 
 	unsigned sync_io;		/* RAID */
-	unsigned read_sectors, write_sectors;
-	unsigned reads, writes;
-	unsigned read_merges, write_merges;
-	unsigned read_ticks, write_ticks;
-	unsigned io_ticks;
-	int in_flight;
 	unsigned long stamp, stamp_idle;
-	unsigned time_in_queue;
+#ifdef	CONFIG_SMP
+	struct disk_stats *dkstats;
+#else
+	struct disk_stats dkstats;
+#endif
 };
 
+/* 
+ * Macros to operate on percpu disk statistics:
+ * Since writes to disk_stats are serialised through the queue_lock,
+ * smp_processor_id() should be enough to get to the per_cpu versions
+ * of statistics counters
+ */
+#ifdef	CONFIG_SMP
+#define DISK_STAT_INC(gendiskp, field)		\
+	(per_cpu_ptr(gendiskp->dkstats, smp_processor_id())->field++)
+#define DISK_STAT_DEC(gendiskp, field)		\
+	(per_cpu_ptr(gendiskp->dkstats, smp_processor_id())->field--)
+#define DISK_STAT_ADD(gendiskp, field, addnd) 	\
+	(per_cpu_ptr(gendiskp->dkstats, smp_processor_id())->field += addnd)
+#define DISK_STAT_SUB(gendiskp, field, subnd) 	\
+	(per_cpu_ptr(gendiskp->dkstats, smp_processor_id())->field -= subnd)
+#define DISK_STAT_READ(gendiskp, field)					\
+({									\
+	typeof(gendiskp->dkstats->field) res = 0;			\
+	int i;								\
+	for (i=0; i < NR_CPUS; i++) {					\
+		if (!cpu_possible(i))					\
+			continue;					\
+		res += per_cpu_ptr(gendiskp->dkstats, i)->field;	\
+	}								\
+	res;								\
+})
+
+static inline void disk_stat_set_all(struct gendisk *gendiskp, int value)	{
+	int i;
+	for (i=0; i < NR_CPUS; i++) {
+		if (cpu_possible(i)) {
+			memset(per_cpu_ptr(gendiskp->dkstats, i), value,	
+					sizeof (struct disk_stats));
+		}
+	}
+}		
+				
+#else
+#define DISK_STAT_INC(gendiskp, field) (gendiskp->dkstats.field++)
+#define DISK_STAT_DEC(gendiskp, field) (gendiskp->dkstats.field--)
+#define DISK_STAT_ADD(gendiskp, field, addnd) (gendiskp->dkstats.field += addnd)
+#define DISK_STAT_SUB(gendiskp, field, subnd) (gendiskp->dkstats.field -= subnd)
+#define DISK_STAT_READ(gendiskp, field)	(gendiskp->dkstats.field)
+
+static inline void disk_stat_set_all(struct gendisk *gendiskp, int value)	{
+	memset(&gendiskp->dkstats, value, sizeof (struct disk_stats));
+}
+#endif
+
+/* Inlines to alloc and free disk stats in struct gendisk */
+#ifdef  CONFIG_SMP
+static inline int init_disk_stats(struct gendisk *disk)
+{
+	disk->dkstats = kmalloc_percpu(sizeof (struct disk_stats), GFP_KERNEL);
+	if (!disk->dkstats)
+		return 0;
+	disk_stat_set_all(disk, 0);
+	return 1;
+}
+
+static inline void free_disk_stats(struct gendisk *disk)
+{
+	kfree_percpu(disk->dkstats);
+}
+#else	/* CONFIG_SMP */
+static inline int init_disk_stats(struct gendisk *disk)
+{
+	return 1;
+}
+
+static inline void free_disk_stats(struct gendisk *disk)
+{
+}
+#endif	/* CONFIG_SMP */
+
 /* drivers/block/ll_rw_blk.c */
 extern void disk_round_stats(struct gendisk *disk);
 
