Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267805AbTBYHpp>; Tue, 25 Feb 2003 02:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267806AbTBYHpp>; Tue, 25 Feb 2003 02:45:45 -0500
Received: from packet.digeo.com ([12.110.80.53]:43909 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267805AbTBYHpk>;
	Tue, 25 Feb 2003 02:45:40 -0500
Date: Mon, 24 Feb 2003 23:56:10 -0800
From: Andrew Morton <akpm@digeo.com>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, ricklind@us.ibm.com
Subject: Re: [patch] Make diskstats per-cpu using kmalloc_percpu
Message-Id: <20030224235610.67e38b34.akpm@digeo.com>
In-Reply-To: <20030225073654.GB28052@in.ibm.com>
References: <20030225073654.GB28052@in.ibm.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Feb 2003 07:55:47.0953 (UTC) FILETIME=[4ECB6E10:01C2DCA3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@in.ibm.com> wrote:
>
> This version makes the disk stats on struct gendisk per-cpu.

Well OK, but it has lots of SCARY UPPER-CASE MACROS and disk_stat_inc(),
disk_stat_dec() and disk_stat_sub() can all be defined in terms of
disk_stat_add().

I did this to it:


 drivers/block/genhd.c     |   27 ++++++++-----
 drivers/block/ll_rw_blk.c |   29 +++++++-------
 drivers/md/md.c           |    4 +
 fs/partitions/check.c     |    8 ---
 include/linux/genhd.h     |   94 ++++++++++++++++++++++++++++++++++++++++++----
 5 files changed, 123 insertions(+), 39 deletions(-)

diff -puN drivers/block/genhd.c~per-cpu-disk-stats drivers/block/genhd.c
--- 25/drivers/block/genhd.c~per-cpu-disk-stats	2003-02-24 23:44:09.000000000 -0800
+++ 25-akpm/drivers/block/genhd.c	2003-02-24 23:50:04.000000000 -0800
@@ -318,7 +318,7 @@ static inline unsigned jiffies_to_msec(u
 	return (jif / HZ) * 1000 + (jif % HZ) * 1000 / HZ;
 #endif
 }
-static ssize_t disk_stat_read(struct gendisk * disk, char *page)
+static ssize_t disk_stats_read(struct gendisk * disk, char *page)
 {
 	disk_round_stats(disk);
 	return sprintf(page,
@@ -326,14 +326,16 @@ static ssize_t disk_stat_read(struct gen
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
+		disk_stat_read(disk, reads), disk_stat_read(disk, read_merges),
+		(unsigned long long)disk_stat_read(disk, read_sectors),
+		jiffies_to_msec(disk_stat_read(disk, read_ticks)),
+		disk_stat_read(disk, writes), 
+		disk_stat_read(disk, write_merges),
+		(unsigned long long)disk_stat_read(disk, write_sectors),
+		jiffies_to_msec(disk_stat_read(disk, write_ticks)),
+		disk_stat_read(disk, in_flight), 
+		jiffies_to_msec(disk_stat_read(disk, io_ticks)),
+		jiffies_to_msec(disk_stat_read(disk, time_in_queue)));
 }
 static struct disk_attribute disk_attr_dev = {
 	.attr = {.name = "dev", .mode = S_IRUGO },
@@ -349,7 +351,7 @@ static struct disk_attribute disk_attr_s
 };
 static struct disk_attribute disk_attr_stat = {
 	.attr = {.name = "stat", .mode = S_IRUGO },
-	.show	= disk_stat_read
+	.show	= disk_stats_read
 };
 
 static struct attribute * default_attrs[] = {
@@ -365,6 +367,7 @@ static void disk_release(struct kobject 
 	struct gendisk *disk = to_disk(kobj);
 	kfree(disk->random);
 	kfree(disk->part);
+	free_disk_stats(disk);
 	kfree(disk);
 }
 
@@ -384,6 +387,10 @@ struct gendisk *alloc_disk(int minors)
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
diff -puN drivers/block/ll_rw_blk.c~per-cpu-disk-stats drivers/block/ll_rw_blk.c
--- 25/drivers/block/ll_rw_blk.c~per-cpu-disk-stats	2003-02-24 23:44:09.000000000 -0800
+++ 25-akpm/drivers/block/ll_rw_blk.c	2003-02-24 23:44:09.000000000 -0800
@@ -1458,17 +1458,17 @@ void drive_stat_acct(struct request *rq,
 		return;
 
 	if (rw == READ) {
-		rq->rq_disk->read_sectors += nr_sectors;
+		disk_stat_add(rq->rq_disk, read_sectors, nr_sectors);
 		if (!new_io)
-			rq->rq_disk->read_merges++;
+			disk_stat_inc(rq->rq_disk, read_merges);
 	} else if (rw == WRITE) {
-		rq->rq_disk->write_sectors += nr_sectors;
+		disk_stat_add(rq->rq_disk, write_sectors, nr_sectors);
 		if (!new_io)
-			rq->rq_disk->write_merges++;
+			disk_stat_inc(rq->rq_disk, write_merges);
 	}
 	if (new_io) {
 		disk_round_stats(rq->rq_disk);
-		rq->rq_disk->in_flight++;
+		disk_stat_inc(rq->rq_disk, in_flight);
 	}
 }
 
@@ -1508,11 +1508,12 @@ void disk_round_stats(struct gendisk *di
 {
 	unsigned long now = jiffies;
 
-	disk->time_in_queue += disk->in_flight * (now - disk->stamp);
+	disk_stat_add(disk, time_in_queue, 
+			disk_stat_read(disk, in_flight) * (now - disk->stamp));
 	disk->stamp = now;
 
-	if (disk->in_flight)
-		disk->io_ticks += (now - disk->stamp_idle);
+	if (disk_stat_read(disk, in_flight))
+		disk_stat_add(disk, io_ticks, (now - disk->stamp_idle));
 	disk->stamp_idle = now;
 }
 
@@ -1628,7 +1629,7 @@ static int attempt_merge(request_queue_t
 
 		if (req->rq_disk) {
 			disk_round_stats(req->rq_disk);
-			req->rq_disk->in_flight--;
+			disk_stat_dec(req->rq_disk, in_flight);
 		}
 
 		__blk_put_request(q, next);
@@ -2180,16 +2181,16 @@ void end_that_request_last(struct reques
 		unsigned long duration = jiffies - req->start_time;
 		switch (rq_data_dir(req)) {
 		    case WRITE:
-			disk->writes++;
-			disk->write_ticks += duration;
+			disk_stat_inc(disk, writes);
+			disk_stat_add(disk, write_ticks, duration);
 			break;
 		    case READ:
-			disk->reads++;
-			disk->read_ticks += duration;
+			disk_stat_inc(disk, reads);
+			disk_stat_add(disk, read_ticks, duration);
 			break;
 		}
 		disk_round_stats(disk);
-		disk->in_flight--;
+		disk_stat_dec(disk, in_flight);
 	}
 	__blk_put_request(req->q, req);
 }
diff -puN drivers/md/md.c~per-cpu-disk-stats drivers/md/md.c
--- 25/drivers/md/md.c~per-cpu-disk-stats	2003-02-24 23:44:09.000000000 -0800
+++ 25-akpm/drivers/md/md.c	2003-02-24 23:44:09.000000000 -0800
@@ -2803,7 +2803,9 @@ static int is_mddev_idle(mddev_t *mddev)
 	idle = 1;
 	ITERATE_RDEV(mddev,rdev,tmp) {
 		struct gendisk *disk = rdev->bdev->bd_contains->bd_disk;
-		curr_events = disk->read_sectors + disk->write_sectors - disk->sync_io;
+		curr_events = disk_stat_read(disk, read_sectors) + 
+				disk_stat_read(disk, write_sectors) - 
+				disk->sync_io;
 		if ((curr_events - rdev->last_events) > 32) {
 			rdev->last_events = curr_events;
 			idle = 0;
diff -puN fs/partitions/check.c~per-cpu-disk-stats fs/partitions/check.c
--- 25/fs/partitions/check.c~per-cpu-disk-stats	2003-02-24 23:44:09.000000000 -0800
+++ 25-akpm/fs/partitions/check.c	2003-02-24 23:44:09.000000000 -0800
@@ -503,13 +503,7 @@ void del_gendisk(struct gendisk *disk)
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
diff -puN include/linux/genhd.h~per-cpu-disk-stats include/linux/genhd.h
--- 25/include/linux/genhd.h~per-cpu-disk-stats	2003-02-24 23:44:09.000000000 -0800
+++ 25-akpm/include/linux/genhd.h	2003-02-24 23:46:31.000000000 -0800
@@ -70,6 +70,16 @@ struct hd_struct {
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
@@ -94,16 +104,86 @@ struct gendisk {
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
+#define disk_stat_add(gendiskp, field, addnd) 	\
+	(per_cpu_ptr(gendiskp->dkstats, smp_processor_id())->field += addnd)
+#define disk_stat_read(gendiskp, field)					\
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
+#define disk_stat_add(gendiskp, field, addnd) (gendiskp->dkstats.field += addnd)
+#define disk_stat_read(gendiskp, field)	(gendiskp->dkstats.field)
+
+static inline void disk_stat_set_all(struct gendisk *gendiskp, int value)	{
+	memset(&gendiskp->dkstats, value, sizeof (struct disk_stats));
+}
+#endif
+
+#define disk_stat_inc(gendiskp, field) disk_stat_add(gendiskp, field, 1)
+#define disk_stat_dec(gendiskp, field) disk_stat_add(gendiskp, field, -1)
+#define disk_stat_sub(gendiskp, field, subnd) \
+		disk_stat_add(gendiskp, field, -subnd)
+
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
 

_

