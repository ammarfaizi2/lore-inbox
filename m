Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSHFOFX>; Tue, 6 Aug 2002 10:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSHFOFX>; Tue, 6 Aug 2002 10:05:23 -0400
Received: from verein.lst.de ([212.34.181.86]:8971 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S313060AbSHFOFT>;
	Tue, 6 Aug 2002 10:05:19 -0400
Date: Tue, 6 Aug 2002 16:08:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: marcelo@conectiva.com.br
Cc: garloff@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] conditionally re-enable per-disk stats, convert to seq_file
Message-ID: <20020806160848.A2413@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, marcelo@conectiva.com.br,
	garloff@suse.de, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.4.20-pre1 converts /proc/partitions to the seq_file
interface as in 2.5, makes it report the sard-style extended disk
statistics condititional on CONFIG_BLK_STATS and disables the gathering
of those totally otherwise to not waste memory and processing power.

This patch is based on the concept of Kurt's statistics patch, although
it is implemented very differently to avoid #ifdef hell.


diff -uNr -Xdontdiff -p linux-2.4.20-pre1/Documentation/Configure.help linux/Documentation/Configure.help
--- linux-2.4.20-pre1/Documentation/Configure.help	Tue Aug  6 11:31:46 2002
+++ linux/Documentation/Configure.help	Tue Aug  6 14:04:50 2002
@@ -531,6 +531,17 @@ CONFIG_BLK_DEV_NBD
 
   If unsure, say N.
 
+Per partition statistics in /proc/partitions
+CONFIG_BLK_STATS
+  If you say yes here, your kernel will keep statistical information
+  for every partition. The information includes things as numbers of
+  read and write accesses, thenumber of merged requests etc.
+
+  This is required for the full functionality of sar(8) and interesting
+  if you want to do performance tuning, by tweaking the elevator, e.g.
+
+  If unsure, say N.
+
 ATA/IDE/MFM/RLL support
 CONFIG_IDE
   If you say Y here, your kernel will be able to manage low cost mass
diff -uNr -Xdontdiff -p linux-2.4.20-pre1/drivers/block/Config.in linux/drivers/block/Config.in
--- linux-2.4.20-pre1/drivers/block/Config.in	Tue Aug  6 11:29:02 2002
+++ linux/drivers/block/Config.in	Tue Aug  6 14:05:46 2002
@@ -48,4 +48,6 @@ if [ "$CONFIG_BLK_DEV_RAM" = "y" -o "$CO
 fi
 dep_bool '  Initial RAM disk (initrd) support' CONFIG_BLK_DEV_INITRD $CONFIG_BLK_DEV_RAM
 
+bool 'Per partition statistics in /proc/partitions' CONFIG_BLK_STATS
+
 endmenu
diff -uNr -Xdontdiff -p linux-2.4.20-pre1/drivers/block/genhd.c linux/drivers/block/genhd.c
--- linux-2.4.20-pre1/drivers/block/genhd.c	Tue Aug  6 11:30:40 2002
+++ linux/drivers/block/genhd.c	Tue Aug  6 15:13:41 2002
@@ -22,10 +22,9 @@
 #include <linux/blk.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
+#include <linux/seq_file.h>
 
 
-static rwlock_t gendisk_lock;
-
 /*
  * Global kernel list of partitioning information.
  *
@@ -34,6 +33,7 @@ static rwlock_t gendisk_lock;
  */
 /*static*/ struct gendisk *gendisk_head;
 static struct gendisk *gendisk_array[MAX_BLKDEV];
+static rwlock_t gendisk_lock = RW_LOCK_UNLOCKED;
 
 EXPORT_SYMBOL(gendisk_head);
 
@@ -153,46 +153,83 @@ walk_gendisk(int (*walk)(struct gendisk 
 	return error;
 }
 
-
 #ifdef CONFIG_PROC_FS
-int
-get_partition_list(char *page, char **start, off_t offset, int count)
+/* iterator */
+static void *part_start(struct seq_file *s, loff_t *pos)
 {
 	struct gendisk *gp;
-	struct hd_struct *hd;
-	char buf[64];
-	int len, n;
 
-	len = sprintf(page, "major minor  #blocks  name\n\n");
-		
 	read_lock(&gendisk_lock);
-	for (gp = gendisk_head; gp; gp = gp->next) {
-		for (n = 0; n < (gp->nr_real << gp->minor_shift); n++) {
-			if (gp->part[n].nr_sects == 0)
-				continue;
-
-			hd = &gp->part[n]; disk_round_stats(hd);
-			len += sprintf(page + len,
-				"%4d  %4d %10d %s\n", gp->major,
-				n, gp->sizes[n], disk_name(gp, n, buf));
-
-			if (len < offset)
-				offset -= len, len = 0;
-			else if (len >= offset + count)
-				goto out;
-		}
-	}
+	for (gp = gendisk_head; gp; gp = gp->next)
+		if (!*pos--)
+			return gp;
+	return NULL;
+}
 
-out:
+static void *part_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	++*pos;
+	return ((struct gendisk *)v)->next;
+}
+
+static void part_stop(struct seq_file *s, void *v)
+{
 	read_unlock(&gendisk_lock);
-	*start = page + offset;
-	len -= offset;
-	if (len < 0)
-		len = 0;
-	return len > count ? count : len;
 }
+
+static int part_show(struct seq_file *s, void *v)
+{
+	struct gendisk *gp = v;
+	char buf[64];
+	int n;
+
+	if (gp == gendisk_head) {
+		seq_puts(s, "major minor  #blocks  name"
+#ifdef CONFIG_BLK_STATS
+			    "     rio rmerge rsect ruse wio wmerge "
+			    "wsect wuse running use aveq"
 #endif
+			   "\n\n");
+	}
 
+	/* show the full disk and all non-0 size partitions of it */
+	for (n = 0; n < (gp->nr_real << gp->minor_shift); n++) {
+		int mask = (1<<gp->minor_shift) - 1;
+
+		if (!(n & mask) || gp->part[n].nr_sects) {
+			struct hd_struct *hd = &gp->part[n];
+
+#ifdef CONFIG_BLK_STATS
+			disk_round_stats(hd);
+			seq_printf(s, "%4d  %4d %10d %s "
+				      "%d %d %d %d %d %d %d %d %d %d %d\n",
+				      gp->major, n, gp->sizes[n],
+				      disk_name(gp, n, buf),
+				      hd->rd_ios, hd->rd_merges,
+#define MSEC(x) ((x) * 1000 / HZ)
+				      hd->rd_sectors, MSEC(hd->rd_ticks),
+				      hd->wr_ios, hd->wr_merges,
+				      hd->wr_sectors, MSEC(hd->wr_ticks),
+				      hd->ios_in_flight, MSEC(hd->io_ticks),
+				      MSEC(hd->aveq));
+#else
+			seq_printf(s, "%4d  %4d %10d %s\n",
+				   gp->major, n, gp->sizes[n],
+				   disk_name(gp, n, buf));
+#endif /* CONFIG_BLK_STATS */
+		}
+	}
+
+	return 0;
+}
+
+struct seq_operations partitions_op = {
+	.start		= part_start,
+	.next		= part_next,
+	.stop		= part_stop,
+	.show		= part_show,
+};
+#endif
 
 extern int blk_dev_init(void);
 extern int net_dev_init(void);
@@ -201,7 +238,6 @@ extern int atmdev_init(void);
 
 int __init device_init(void)
 {
-	rwlock_init(&gendisk_lock);
 	blk_dev_init();
 	sti();
 #ifdef CONFIG_NET
diff -uNr -Xdontdiff -p linux-2.4.20-pre1/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- linux-2.4.20-pre1/drivers/block/ll_rw_blk.c	Tue Aug  6 11:27:59 2002
+++ linux/drivers/block/ll_rw_blk.c	Tue Aug  6 15:13:53 2002
@@ -594,9 +594,14 @@ inline void drive_stat_acct (kdev_t dev,
 		printk(KERN_ERR "drive_stat_acct: cmd not R/W?\n");
 }
 
-/* Return up to two hd_structs on which to do IO accounting for a given
- * request.  On a partitioned device, we want to account both against
- * the partition and against the whole disk.  */
+#ifdef CONFIG_BLK_STATS
+/*
+ * Return up to two hd_structs on which to do IO accounting for a given
+ * request.
+ *
+ * On a partitioned device, we want to account both against the partition
+ * and against the whole disk.
+ */
 static void locate_hd_struct(struct request *req, 
 			     struct hd_struct **hd1,
 			     struct hd_struct **hd2)
@@ -611,22 +616,26 @@ static void locate_hd_struct(struct requ
 		/* Mask out the partition bits: account for the entire disk */
 		int devnr = MINOR(req->rq_dev) >> gd->minor_shift;
 		int whole_minor = devnr << gd->minor_shift;
+
 		*hd1 = &gd->part[whole_minor];
 		if (whole_minor != MINOR(req->rq_dev))
 			*hd2= &gd->part[MINOR(req->rq_dev)];
 	}
 }
 
-/* Round off the performance stats on an hd_struct.  The average IO
- * queue length and utilisation statistics are maintained by observing
- * the current state of the queue length and the amount of time it has
- * been in this state for.  Normally, that accounting is done on IO
- * completion, but that can result in more than a second's worth of IO
- * being accounted for within any one second, leading to >100%
- * utilisation.  To deal with that, we do a round-off before returning
- * the results when reading /proc/partitions, accounting immediately for
- * all queue usage up to the current jiffies and restarting the counters
- * again. */
+/*
+ * Round off the performance stats on an hd_struct.
+ *
+ * The average IO queue length and utilisation statistics are maintained
+ * by observing the current state of the queue length and the amount of
+ * time it has been in this state for.
+ * Normally, that accounting is done on IO completion, but that can result
+ * in more than a second's worth of IO being accounted for within any one
+ * second, leading to >100% utilisation.  To deal with that, we do a
+ * round-off before returning the results when reading /proc/partitions,
+ * accounting immediately for all queue usage up to the current jiffies and
+ * restarting the counters again.
+ */
 void disk_round_stats(struct hd_struct *hd)
 {
 	unsigned long now = jiffies;
@@ -639,7 +648,6 @@ void disk_round_stats(struct hd_struct *
 	hd->last_idle_time = now;	
 }
 
-
 static inline void down_ios(struct hd_struct *hd)
 {
 	disk_round_stats(hd);	
@@ -690,6 +698,7 @@ static void account_io_end(struct hd_str
 void req_new_io(struct request *req, int merge, int sectors)
 {
 	struct hd_struct *hd1, *hd2;
+
 	locate_hd_struct(req, &hd1, &hd2);
 	if (hd1)
 		account_io_start(hd1, req, merge, sectors);
@@ -697,15 +706,29 @@ void req_new_io(struct request *req, int
 		account_io_start(hd2, req, merge, sectors);
 }
 
+void req_merged_io(struct request *req)
+{
+	struct hd_struct *hd1, *hd2;
+
+	locate_hd_struct(req, &hd1, &hd2);
+	if (hd1)
+		down_ios(hd1);
+	if (hd2)	
+		down_ios(hd2);
+}
+
 void req_finished_io(struct request *req)
 {
 	struct hd_struct *hd1, *hd2;
+
 	locate_hd_struct(req, &hd1, &hd2);
 	if (hd1)
 		account_io_end(hd1, req);
 	if (hd2)	
 		account_io_end(hd2, req);
 }
+EXPORT_SYMBOL(req_finished_io);
+#endif /* CONFIG_BLK_STATS */
 
 /*
  * add-request adds a request to the linked list.
@@ -764,7 +787,6 @@ static void attempt_merge(request_queue_
 			  int max_segments)
 {
 	struct request *next;
-	struct hd_struct *hd1, *hd2;
   
 	next = blkdev_next_request(req);
 	if (req->sector + req->nr_sectors != next->sector)
@@ -791,12 +813,8 @@ static void attempt_merge(request_queue_
 
 	/* One last thing: we have removed a request, so we now have one
 	   less expected IO to complete for accounting purposes. */
+	req_merged_io(req);
 
-	locate_hd_struct(req, &hd1, &hd2);
-	if (hd1)
-		down_ios(hd1);
-	if (hd2)	
-		down_ios(hd2);
 	blkdev_release_request(next);
 }
 
@@ -1439,5 +1457,4 @@ EXPORT_SYMBOL(blk_queue_headactive);
 EXPORT_SYMBOL(blk_queue_make_request);
 EXPORT_SYMBOL(generic_make_request);
 EXPORT_SYMBOL(blkdev_release_request);
-EXPORT_SYMBOL(req_finished_io);
 EXPORT_SYMBOL(generic_unplug_device);
diff -uNr -Xdontdiff -p linux-2.4.20-pre1/fs/proc/proc_misc.c linux/fs/proc/proc_misc.c
--- linux-2.4.20-pre1/fs/proc/proc_misc.c	Tue Aug  6 11:28:14 2002
+++ linux/fs/proc/proc_misc.c	Tue Aug  6 13:42:21 2002
@@ -55,7 +55,6 @@ extern int get_stram_list(char *);
 extern int get_module_list(char *);
 #endif
 extern int get_device_list(char *);
-extern int get_partition_list(char *, char **, off_t, int);
 extern int get_filesystem_list(char *);
 extern int get_exec_domain_list(char *);
 extern int get_irq_list(char *);
@@ -254,6 +253,18 @@ static int stram_read_proc(char *page, c
 }
 #endif
 
+extern struct seq_operations partitions_op;
+static int partitions_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &partitions_op);
+}
+static struct file_operations proc_partitions_operations = {
+	open:		partitions_open,
+	read:		seq_read,
+	llseek:		seq_lseek,
+	release:	seq_release,
+};
+
 #ifdef CONFIG_MODULES
 static int modules_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
@@ -377,14 +388,6 @@ static int devices_read_proc(char *page,
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
-static int partitions_read_proc(char *page, char **start, off_t off,
-				 int count, int *eof, void *data)
-{
-	int len = get_partition_list(page, start, off, count);
-	if (len < count) *eof = 1;
-	return len;
-}
-
 #if !defined(CONFIG_ARCH_S390)
 static int interrupts_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
@@ -561,7 +564,6 @@ void __init proc_misc_init(void)
 #endif
 		{"stat",	kstat_read_proc},
 		{"devices",	devices_read_proc},
-		{"partitions",	partitions_read_proc},
 #if !defined(CONFIG_ARCH_S390)
 		{"interrupts",	interrupts_read_proc},
 #endif
@@ -588,6 +590,7 @@ void __init proc_misc_init(void)
 	if (entry)
 		entry->proc_fops = &proc_kmsg_operations;
 	create_seq_entry("cpuinfo", 0, &proc_cpuinfo_operations);
+	create_seq_entry("partitions", 0, &proc_partitions_operations);
 	create_seq_entry("slabinfo",S_IWUSR|S_IRUGO,&proc_slabinfo_operations);
 #ifdef CONFIG_MODULES
 	create_seq_entry("ksyms", 0, &proc_ksyms_operations);
diff -uNr -Xdontdiff -p linux-2.4.20-pre1/include/linux/genhd.h linux/include/linux/genhd.h
--- linux-2.4.20-pre1/include/linux/genhd.h	Tue Aug  6 11:28:19 2002
+++ linux/include/linux/genhd.h	Tue Aug  6 15:14:13 2002
@@ -62,8 +62,8 @@ struct hd_struct {
 	unsigned long start_sect;
 	unsigned long nr_sects;
 	devfs_handle_t de;              /* primary (master) devfs entry  */
-	int number;                     /* stupid old code wastes space  */
 
+#ifdef CONFIG_BLK_STATS
 	/* Performance stats: */
 	unsigned int ios_in_flight;
 	unsigned int io_ticks;
@@ -79,6 +79,7 @@ struct hd_struct {
 	unsigned int wr_merges;
 	unsigned int wr_ticks;
 	unsigned int wr_sectors;	
+#endif /* CONFIG_BLK_STATS */
 };
 
 #define GENHD_FL_REMOVABLE  1
@@ -259,18 +260,22 @@ struct unixware_disklabel {
 
 char *disk_name (struct gendisk *hd, int minor, char *buf);
 
-/*
- * disk_round_stats is used to round off the IO statistics for a disk
- * for a complete clock tick.
- */
-void disk_round_stats(struct hd_struct *hd);
-
 /* 
  * Account for the completion of an IO request (used by drivers which 
  * bypass the normal end_request processing) 
  */
 struct request;
-void req_finished_io(struct request *);
+
+#ifdef CONFIG_BLK_STATS
+extern void disk_round_stats(struct hd_struct *hd);
+extern void req_new_io(struct request *req, int merge, int sectors);
+extern void req_merged_io(struct request *req);
+extern void req_finished_io(struct request *req);
+#else
+static inline void req_new_io(struct request *req, int merge, int sectors) { }
+static inline void req_merged_io(struct request *req) { }
+static inline void req_finished_io(struct request *req) { }
+#endif /* CONFIG_BLK_STATS */
 
 extern void devfs_register_partitions (struct gendisk *dev, int minor,
 				       int unregister);
