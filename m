Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbVBOTsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbVBOTsT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 14:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVBOTsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 14:48:19 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:41938 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261843AbVBOTli
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 14:41:38 -0500
Date: Tue, 15 Feb 2005 13:37:12 -0600
From: Jake Moilanen <moilanen@austin.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: pwil3058@bigpond.net.au
Subject: [ANNOUNCE 2/4] Genetic-lib version 0.2
Message-Id: <20050215133712.4b9c9c01.moilanen@austin.ibm.com>
In-Reply-To: <20050215132906.33f88505.moilanen@austin.ibm.com>
References: <20050215132906.33f88505.moilanen@austin.ibm.com>
Organization: IBM
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the base patch for the IO Schedulers.  

Needs a finer granularity for fitness routines.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

---


diff -puN drivers/block/genhd.c~genetic-io-sched drivers/block/genhd.c
--- linux-2.6.10/drivers/block/genhd.c~genetic-io-sched	Fri Jan 28 15:49:42 2005
+++ linux-2.6.10-moilanen/drivers/block/genhd.c	Fri Jan 28 15:49:42 2005
@@ -32,6 +32,8 @@ static struct blk_major_name {
 
 static spinlock_t major_names_lock = SPIN_LOCK_UNLOCKED;
 
+LIST_HEAD(gendisks);
+
 /* index in the above - for now: assume no multimajor ranges */
 static inline int major_to_index(int major)
 {
@@ -600,6 +602,7 @@ struct gendisk *alloc_disk(int minors)
 		kobj_set_kset_s(disk,block_subsys);
 		kobject_init(&disk->kobj);
 		rand_initialize_disk(disk);
+		list_add_tail(&disk->gendisks, &gendisks);
 	}
 	return disk;
 }
diff -puN drivers/block/ll_rw_blk.c~genetic-io-sched drivers/block/ll_rw_blk.c
--- linux-2.6.10/drivers/block/ll_rw_blk.c~genetic-io-sched	Fri Jan 28 15:49:42 2005
+++ linux-2.6.10-moilanen/drivers/block/ll_rw_blk.c	Fri Jan 28 15:49:42 2005
@@ -28,6 +28,7 @@
 #include <linux/slab.h>
 #include <linux/swap.h>
 #include <linux/writeback.h>
+#include <linux/genetic.h>
 
 /*
  * for max sense size
@@ -2111,6 +2112,92 @@ static inline void add_request(request_q
 	__elv_add_request(q, req, ELEVATOR_INSERT_SORT, 0);
 }
  
+#ifdef CONFIG_GENETIC_IOSCHED_AS
+extern struct list_head gendisks;
+
+void disk_stats_snapshot(phenotype_t * pt)
+{
+	struct list_head * d;
+	struct gendisk *disk;
+	struct disk_stats_snapshot * ss = (struct disk_stats_snapshot *)pt->child_ranking[0]->stats_snapshot;
+    
+	memset(ss, 0, sizeof(struct disk_stats_snapshot));
+
+	list_for_each(d, &gendisks) {
+	    disk = list_entry(d, struct gendisk, gendisks);
+
+	    disk_round_stats(disk);
+
+	    ss->reads += disk_stat_read(disk, reads);
+	    ss->writes += disk_stat_read(disk, writes);
+	    ss->read_sectors += disk_stat_read(disk, read_sectors);
+	    ss->write_sectors += disk_stat_read(disk, write_sectors);
+	    ss->time_in_queue += disk_stat_read(disk, time_in_queue);
+	}
+}
+
+/* XXX is this the best method to calc fitness */
+unsigned long disk_calc_fitness(genetic_child_t * child)
+{
+	struct list_head * d;
+	struct gendisk *disk;
+	struct disk_stats_snapshot * ss = (struct disk_stats_snapshot *)child->stats_snapshot;
+	unsigned long reads = 0;
+	unsigned long writes = 0;
+	unsigned long time_in_queue = 0;
+	unsigned long read_sectors = 0;
+	unsigned long write_sectors = 0;
+	long long total_fitness = 0;
+    
+	list_for_each(d, &gendisks) {
+	    disk = list_entry(d, struct gendisk, gendisks);
+
+	    disk_round_stats(disk);
+	    
+	    reads += disk_stat_read(disk, reads);
+	    writes += disk_stat_read(disk, writes);
+
+	    read_sectors += disk_stat_read(disk, read_sectors);
+	    write_sectors += disk_stat_read(disk, write_sectors);
+
+	    time_in_queue += disk_stat_read(disk, time_in_queue);
+
+	}
+
+	reads -= ss->reads;
+	writes -= ss->writes;
+	time_in_queue = -(time_in_queue - ss->time_in_queue);
+	read_sectors -= ss->read_sectors;
+	write_sectors -= ss->write_sectors;
+
+	/* Various attempts at collecting good fitness */
+#if 0
+	if (time_in_queue)
+		disk_fitness = ((reads + writes) 2 * HZ) / time_in_queue;
+	else
+		disk_fitness = 0;
+
+#endif
+
+#if 0
+	if (time_in_queue)
+		disk_fitness = ((read_sectors + write_sectors) * 2 * HZ) / time_in_queue;
+	else
+		disk_fitness = 0;
+#endif
+
+#if 0
+	disk_fitness = reads + writes;
+#endif
+
+#if 1
+	total_fitness = read_sectors + write_sectors;
+#endif
+	    
+	return total_fitness;
+}
+#endif
+
 /*
  * disk_round_stats()	- Round off the performance stats on a struct
  * disk_stats.
@@ -2133,7 +2220,6 @@ void disk_round_stats(struct gendisk *di
 	__disk_stat_add(disk, time_in_queue,
 			disk->in_flight * (now - disk->stamp));
 	disk->stamp = now;
-
 	if (disk->in_flight)
 		__disk_stat_add(disk, io_ticks, (now - disk->stamp_idle));
 	disk->stamp_idle = now;
diff -puN include/linux/genhd.h~genetic-io-sched include/linux/genhd.h
--- linux-2.6.10/include/linux/genhd.h~genetic-io-sched	Fri Jan 28 15:49:42 2005
+++ linux-2.6.10-moilanen/include/linux/genhd.h	Fri Jan 28 15:49:42 2005
@@ -121,11 +121,20 @@ struct gendisk {
 	atomic_t sync_io;		/* RAID */
 	unsigned long stamp, stamp_idle;
 	int in_flight;
+	struct list_head gendisks;
 #ifdef	CONFIG_SMP
 	struct disk_stats *dkstats;
 #else
 	struct disk_stats dkstats;
 #endif
+#ifdef CONFIG_GENETIC_LIB
+	unsigned reads_snap;
+	unsigned writes_snap;
+	unsigned read_sectors_snap;
+	unsigned write_sectors_snap;
+	unsigned time_in_queue_snap;
+#endif	
+
 };
 
 /* 
diff -puN include/linux/blkdev.h~genetic-io-sched include/linux/blkdev.h
--- linux-2.6.10/include/linux/blkdev.h~genetic-io-sched	Fri Jan 28 15:52:18 2005
+++ linux-2.6.10-moilanen/include/linux/blkdev.h	Fri Jan 28 15:52:47 2005
@@ -723,5 +723,16 @@ void kblockd_flush(void);
 #define MODULE_ALIAS_BLOCKDEV_MAJOR(major) \
 	MODULE_ALIAS("block-major-" __stringify(major) "-*")
 
+#ifdef CONFIG_GENETIC_IOSCHED_AS
+
+struct disk_stats_snapshot
+{
+	unsigned long reads;
+	unsigned long writes;
+	unsigned long read_sectors;
+	unsigned long write_sectors;
+	unsigned long time_in_queue;	
+};
+#endif /* CONFIG_GENETIC_IOSCHED_AS */
 
 #endif

_
