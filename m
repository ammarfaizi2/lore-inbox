Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262896AbVAFQWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbVAFQWY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 11:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262898AbVAFQWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 11:22:24 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:51128 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262896AbVAFQVs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 11:21:48 -0500
Date: Thu, 6 Jan 2005 10:18:38 -0600
From: Jake Moilanen <moilanen@austin.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE 2/4][RFC] Genetic Algorithm Library
Message-ID: <20050106101838.067732c7@localhost>
In-Reply-To: <20050106100844.53a762a0@localhost>
References: <20050106100844.53a762a0@localhost>
Organization: LTC
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the base patch for the io-schedulers.  

It contains the fitness routine, disk_calc_fitness(), that could use a
rework. 

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

---


diff -puN drivers/block/genhd.c~genetic-io-sched drivers/block/genhd.c
--- linux-2.6.9/drivers/block/genhd.c~genetic-io-sched	Wed Jan  5 15:45:57 2005
+++ linux-2.6.9-moilanen/drivers/block/genhd.c	Wed Jan  5 15:45:57 2005
@@ -32,6 +32,8 @@ static struct blk_major_name {
 
 static spinlock_t major_names_lock = SPIN_LOCK_UNLOCKED;
 
+LIST_HEAD(gendisks);
+
 /* index in the above - for now: assume no multimajor ranges */
 static inline int major_to_index(int major)
 {
@@ -556,6 +558,7 @@ struct gendisk *alloc_disk(int minors)
 		kobj_set_kset_s(disk,block_subsys);
 		kobject_init(&disk->kobj);
 		rand_initialize_disk(disk);
+		list_add_tail(&disk->gendisks, &gendisks);
 	}
 	return disk;
 }
diff -puN drivers/block/ll_rw_blk.c~genetic-io-sched drivers/block/ll_rw_blk.c
--- linux-2.6.9/drivers/block/ll_rw_blk.c~genetic-io-sched	Wed Jan  5 15:45:57 2005
+++ linux-2.6.9-moilanen/drivers/block/ll_rw_blk.c	Wed Jan  5 15:45:57 2005
@@ -28,6 +28,7 @@
 #include <linux/slab.h>
 #include <linux/swap.h>
 #include <linux/writeback.h>
+#include <linux/genetic.h>
 
 /*
  * for max sense size
@@ -2115,6 +2116,81 @@ static inline void add_request(request_q
 	__elv_add_request(q, req, ELEVATOR_INSERT_SORT, 0);
 }
  
+#ifdef CONFIG_GENETIC_IOSCHED_AS
+extern struct list_head gendisks;
+
+void disk_stats_snapshot(void)
+{
+	struct list_head * d;
+	struct gendisk *disk;
+    
+	list_for_each(d, &gendisks) {
+	    disk = list_entry(d, struct gendisk, gendisks);
+
+	    disk_round_stats(disk);
+
+	    disk->reads_snap = disk_stat_read(disk, reads);
+	    disk->writes_snap = disk_stat_read(disk, writes);
+	    disk->read_sectors_snap = disk_stat_read(disk, read_sectors);
+	    disk->write_sectors_snap = disk_stat_read(disk, write_sectors);
+	    disk->time_in_queue_snap = disk_stat_read(disk, time_in_queue);
+	}
+}
+
+/* XXX is this the best method to calc fitness */
+unsigned long disk_calc_fitness(void)
+{
+	struct list_head * d;
+	struct gendisk *disk;
+	unsigned long reads, writes, time_in_queue;
+	unsigned long read_sectors, write_sectors;
+	unsigned long disk_fitness;
+	unsigned long total_fitness = 0;
+    
+	list_for_each(d, &gendisks) {
+	    disk = list_entry(d, struct gendisk, gendisks);
+
+	    disk_round_stats(disk);
+	    
+	    reads = disk_stat_read(disk, reads) - disk->reads_snap;
+	    writes = disk_stat_read(disk, writes) - disk->writes_snap;
+
+	    read_sectors = disk_stat_read(disk, read_sectors) - disk->read_sectors_snap;
+	    write_sectors = disk_stat_read(disk, write_sectors) - disk->write_sectors_snap;
+
+	    time_in_queue = disk_stat_read(disk, time_in_queue)	- disk->time_in_queue_snap;
+
+	    /* Various attempts at collecting good fitness */
+#if 0
+	    if (time_in_queue)
+		disk_fitness = ((reads + writes) 2 * HZ) / time_in_queue;
+	    else
+		disk_fitness = 0;
+
+#endif
+
+#if 1
+	    if (time_in_queue)
+		disk_fitness = ((read_sectors + write_sectors) * 2 * HZ) / time_in_queue;
+	    else
+		disk_fitness = 0;
+#endif
+
+#if 0
+	    disk_fitness = reads + writes;
+#endif
+
+#if 0
+	    disk_fitness = read_sectors + write_sectors;
+#endif
+	    
+	    total_fitness += disk_fitness;
+	}
+
+	return total_fitness;
+}
+#endif
+
 /*
  * disk_round_stats()	- Round off the performance stats on a struct
  * disk_stats.
@@ -2137,7 +2213,6 @@ void disk_round_stats(struct gendisk *di
 	disk_stat_add(disk, time_in_queue, 
 			disk->in_flight * (now - disk->stamp));
 	disk->stamp = now;
-
 	if (disk->in_flight)
 		disk_stat_add(disk, io_ticks, (now - disk->stamp_idle));
 	disk->stamp_idle = now;
diff -puN include/linux/genhd.h~genetic-io-sched include/linux/genhd.h
--- linux-2.6.9/include/linux/genhd.h~genetic-io-sched	Wed Jan  5 15:45:57 2005
+++ linux-2.6.9-moilanen/include/linux/genhd.h	Wed Jan  5 15:45:57 2005
@@ -120,11 +120,20 @@ struct gendisk {
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

_
