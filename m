Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031066AbWKPDQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031066AbWKPDQW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 22:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031068AbWKPDQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 22:16:22 -0500
Received: from smtp-out.google.com ([216.239.45.12]:34474 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1031066AbWKPDQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 22:16:20 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:content-type;
	b=LVNZAt+rdvagC91EIA0wKYhIfBvHATK5v0KLFRNWRwoObsoG0rcN3uYtEqGTmslNp
	iN6AMGfy9fhTLRsAz6qXw==
Message-ID: <455BD7E8.9020303@google.com>
Date: Wed, 15 Nov 2006 19:15:52 -0800
From: Edward Falk <efalk@google.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, jens.axboe@oracle.com
CC: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Introduce block I/O performance histograms
Content-Type: multipart/mixed;
 boundary="------------020205050504040708020802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020205050504040708020802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch introduces performance histogram record keeping for block 
I/O, used for performance tuning.  It is turned off by default.

When turned on, you simply do something like:

# cat /sys/block/sda/read_request_histo
rows = bytes columns = ms
         10      20      50      100     200     500     1000    2000
    2048 5       0       0       0       0       0       0       0
    4096 0       0       0       0       0       0       0       0
    8192 17231   135     41      10      0       0       0       0
   16384 4400    24      6       2       0       0       0       0
   32768 2897    34      4       4       0       0       0       0
   65536 7089    87      5       1       2       0       0       0
#

Signed-off-by:	Edward A. Falk <efalk@google.com>

--------------020205050504040708020802
Content-Type: text/plain;
 name="block_histogram.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="block_histogram.patch"

diff -uprN linux-2.6.18.1/block/Kconfig block_histogram/block/Kconfig
--- linux-2.6.18.1/block/Kconfig	2006-10-13 20:34:03.000000000 -0700
+++ block_histogram/block/Kconfig	2006-11-15 18:08:07.000000000 -0800
@@ -24,6 +24,31 @@ config BLK_DEV_IO_TRACE
 
 	  git://brick.kernel.dk/data/git/blktrace.git
 
+config BLOCK_HISTOGRAM
+	bool "Performance histogram data"
+	help
+	  This option causes block devices to collect statistics on transfer
+	  sizes and times.  Useful for performance-tuning a system.  Creates
+	  entries in /sys/block/.  Increases kernel size about 21k.
+
+	  If you are unsure, say N here.
+
+config HISTO_SIZE_BUCKETS
+	int "Number of size buckets in histogram"
+	depends on BLOCK_HISTOGRAM
+	default "6"
+	help
+	  This option controls how many buckets are used to collect
+	  transfer size statistics.
+
+config HISTO_TIME_BUCKETS
+	int "Number of time buckets in histogram"
+	depends on BLOCK_HISTOGRAM
+	default "8"
+	help
+	  This option controls how many buckets are used to collect
+	  transfer time statistics.
+
 config LSF
 	bool "Support for Large Single Files"
 	depends on X86 || (MIPS && 32BIT) || PPC32 || ARCH_S390_31 || SUPERH || UML
diff -uprN linux-2.6.18.1/block/genhd.c block_histogram/block/genhd.c
--- linux-2.6.18.1/block/genhd.c	2006-10-13 20:34:03.000000000 -0700
+++ block_histogram/block/genhd.c	2006-11-15 18:08:07.000000000 -0800
@@ -16,6 +16,13 @@
 #include <linux/buffer_head.h>
 #include <linux/mutex.h>
 
+#ifdef	CONFIG_BLOCK_HISTOGRAM
+static ssize_t disk_read_request_histo_read(struct gendisk *, char *page);
+static ssize_t disk_read_dma_histo_read(struct gendisk *, char *page);
+static ssize_t disk_write_request_histo_read(struct gendisk *, char *page);
+static ssize_t disk_write_dma_histo_read(struct gendisk *, char *page);
+#endif
+
 struct subsystem block_subsys;
 static DEFINE_MUTEX(block_subsys_lock);
 
@@ -412,6 +419,25 @@ static struct disk_attribute disk_attr_s
 	.show	= disk_stats_read
 };
 
+#ifdef	CONFIG_BLOCK_HISTOGRAM
+static struct disk_attribute disk_attr_read_request_histo = {
+	.attr = {.name = "read_request_histo", .mode = S_IRUGO },
+	.show	= disk_read_request_histo_read,
+};
+static struct disk_attribute disk_attr_read_dma_histo = {
+	.attr = {.name = "read_dma_histo", .mode = S_IRUGO },
+	.show	= disk_read_dma_histo_read,
+};
+static struct disk_attribute disk_attr_write_request_histo = {
+	.attr = {.name = "write_request_histo", .mode = S_IRUGO },
+	.show	= disk_write_request_histo_read,
+};
+static struct disk_attribute disk_attr_write_dma_histo = {
+	.attr = {.name = "write_dma_histo", .mode = S_IRUGO },
+	.show	= disk_write_dma_histo_read,
+};
+#endif
+
 static struct attribute * default_attrs[] = {
 	&disk_attr_uevent.attr,
 	&disk_attr_dev.attr,
@@ -419,6 +445,12 @@ static struct attribute * default_attrs[
 	&disk_attr_removable.attr,
 	&disk_attr_size.attr,
 	&disk_attr_stat.attr,
+#ifdef	CONFIG_BLOCK_HISTOGRAM
+	&disk_attr_read_request_histo.attr,
+	&disk_attr_read_dma_histo.attr,
+	&disk_attr_write_request_histo.attr,
+	&disk_attr_write_dma_histo.attr,
+#endif
 	NULL,
 };
 
@@ -708,3 +740,288 @@ int invalidate_partition(struct gendisk 
 }
 
 EXPORT_SYMBOL(invalidate_partition);
+
+
+
+#ifdef	CONFIG_BLOCK_HISTOGRAM
+
+/*
+ *  Explanation of histogram code:
+ *
+ *  The block_histogram code implements a 2-variable histogram, with transfers
+ *  tracked by transfer size and completion time.  The /sysfs files are
+ *  /sysfs/block/DEV/read_request_histo, /sysfs/block/DEV/write_request_histo,
+ *  /sysfs/block/DEV/read_dma_histo, and /sysfs/block/DEV/write_dma_histo
+ *
+ *  The *request_histo files measure time from when the request is first
+ *  submitted into the drive's queue.  The *dma_histo files measure time
+ *  from when the request is transfered from the queue to the device.
+ *
+ *  block_histogram_start_time() is used to note the time that the
+ *  request was transfered to the device.  block_histogram_completion()
+ *  is used to note the time the transfer was completed.
+ */
+
+
+#define	HISTO_REQUEST	0
+#define	HISTO_DMA	1
+
+/**
+ * Clear one per-cpu instance of one channel of I/O histogram
+ */
+static inline void block_histogram_init2(struct disk_stats *stats,
+			int cmd, int type)
+{
+	if (type == HISTO_REQUEST) {
+		if (cmd == READ)
+			memset(&stats->read_req_histo, 0,
+			  sizeof(stats->read_req_histo));
+		else
+			memset(&stats->write_req_histo, 0,
+			  sizeof(stats->write_req_histo));
+	}
+	else {
+		if (cmd == READ)
+			memset(&stats->read_dma_histo, 0,
+			  sizeof(stats->read_dma_histo));
+		else
+			memset(&stats->write_dma_histo, 0,
+			  sizeof(stats->write_dma_histo));
+	}
+}
+
+
+/**
+ * Clear one channel of I/O histogram
+ */
+static void block_histogram_init1(struct gendisk *disk, int cmd, int type)
+{
+#ifdef	CONFIG_SMP
+	int i;
+
+	for (i=0; i < NR_CPUS; ++i)
+		if (cpu_possible(i))
+			block_histogram_init2(per_cpu_ptr(disk->dkstats, i),
+			  cmd, type);
+#else
+	block_histogram_init2(&disk->dkstats, cmd, type);
+#endif
+}
+
+
+/**
+ * Clear all channels of I/O histogram.
+ */
+void block_histogram_init(struct gendisk *disk)
+{
+	block_histogram_init1(disk, HISTO_REQUEST, READ);
+	block_histogram_init1(disk, HISTO_REQUEST, WRITE);
+	block_histogram_init1(disk, HISTO_DMA, READ);
+	block_histogram_init1(disk, HISTO_DMA, WRITE);
+}
+EXPORT_SYMBOL(block_histogram_init);
+
+
+
+/*
+ * Map transfer size to histogram bucket.  Transfer sizes use an
+ * exponential backoff:  4, 8, 16, ... sectors.
+ */
+static inline int stats_size_bucket(int sectors)
+{
+	int	i;
+	sectors /= BASE_HISTO_SIZE;
+	if (sectors >= (1<<(CONFIG_HISTO_SIZE_BUCKETS-2)))
+		return CONFIG_HISTO_SIZE_BUCKETS - 1;
+
+	for (i = 0; sectors > 0; ++i, sectors /= 2);
+	return i;
+}
+
+
+/*
+ * Map transfer time to histogram bucket.  This also uses an exponential
+ * backoff, but we like the 1,2,5,10,20,50 progression.  Start at 10 ms.
+ */
+static inline int stats_time_bucket(int jiffies)
+{
+	int	i;
+	int	ms = jiffies * ( 1000 / HZ);
+	int	t = BASE_HISTO_TIME;
+
+	for (i = 0;; t *= 10) {
+	  if (++i >= CONFIG_HISTO_TIME_BUCKETS || ms <= t) return i - 1;
+	  if (++i >= CONFIG_HISTO_TIME_BUCKETS || ms <= t*2) return i - 1;
+	  if (++i >= CONFIG_HISTO_TIME_BUCKETS || ms <= t*5) return i - 1;
+	}
+}
+
+
+/**
+ * Log I/O completion, update histogram.
+ *
+ * @disk:         disk device
+ * @flags:        r/w command
+ * @sectors:      # sectors transferred
+ * @jiffies:      time transfer required
+ * @jiffies_dma:  time dma required, or -1 if n/a
+ */
+void block_histogram_completion(struct gendisk *disk,
+				unsigned long flags,
+				int sectors,
+				int jiffies,
+				int jiffies_dma)
+{
+	int size_idx = stats_size_bucket(sectors);
+	int req_time_idx = stats_time_bucket(jiffies);
+
+	if (!(flags & REQ_CMD))
+		return;
+
+	if (!(flags & REQ_RW)) {
+		__disk_stat_add(disk,
+			read_req_histo[size_idx][req_time_idx], 1);
+	} else {
+		__disk_stat_add(disk,
+			write_req_histo[size_idx][req_time_idx], 1);
+	}
+  
+	if (jiffies_dma >= 0) {
+		int dma_time_idx = stats_time_bucket(jiffies_dma);
+		if (!(flags & REQ_RW)) {
+			__disk_stat_add(disk,
+				read_dma_histo[size_idx][dma_time_idx], 1);
+		} else {
+			__disk_stat_add(disk,
+				write_dma_histo[size_idx][dma_time_idx], 1);
+		}
+	}
+}
+EXPORT_SYMBOL(block_histogram_completion);
+
+
+/**
+ * Helper function:  calls block_histogram_completion after a dma
+ * interrupt.
+ */
+void block_histogram_req_cmplt(struct gendisk *disk, struct request *req)
+{
+	static int count = 20;
+
+	if (req) {
+		int rq_elapsed = jiffies - req->start_time;
+		int io_elapsed;
+
+		if (req->io_start_time == 0) {
+			if( count > 0 ) {
+			    printk( KERN_NOTICE
+				    "%s: unexpected transfer w/out start time\n",
+				    disk->disk_name);
+			    dump_stack();
+			    --count;
+			}
+			io_elapsed = -1;
+		} else {
+			io_elapsed = jiffies - req->io_start_time;
+		}
+		block_histogram_completion(disk,
+					   req->flags,
+					   req->nr_sectors,
+					   rq_elapsed,
+					   io_elapsed);
+	}
+}
+
+
+/**
+ * Tiny helper utility, append sprintf() output to a buffer, update pointers,
+ * and guard against overflow.
+ */
+static inline void sysfs_out(char **ptr, ssize_t *rem, const char *fmt, ...)
+{
+	va_list	ap;
+	int	i;
+	va_start(ap, fmt);
+	i = vsnprintf(*ptr, *rem, fmt, ap);
+	*ptr += i;
+	*rem -= i;
+	va_end(ap);
+}
+
+
+/**
+ * Dumps the specified 'type' of histogram for disk to out.
+ * The result must be less than PAGE_SIZE
+ */
+static int dump_histo (int cmd, int type, struct gendisk *disk, char* page)
+{
+	ssize_t	rem = PAGE_SIZE;
+	char	*optr = page;
+	int	len, j, k;
+	int	v;
+	int	ms;
+	int	size = BASE_HISTO_SIZE * 512;
+	static const int mults[3] = {1,2,5};
+
+	/* Key */
+	len = snprintf(page, rem, "rows = bytes columns = ms\n");
+	page += len; rem -= len;
+
+	/* Row header */
+	len = snprintf(page, rem, "       "); page += len; rem -= len;
+
+	for (j = 0, ms = BASE_HISTO_TIME; j < CONFIG_HISTO_TIME_BUCKETS; ms *= 10)
+	{
+		for(k=0; k < 3 && j < CONFIG_HISTO_TIME_BUCKETS; ++k, ++j) {
+			len = snprintf(page, rem, "\t%d", ms * mults[k]);
+			page += len; rem -= len;
+		}
+	}
+	*page++ = '\n'; --rem;
+  
+	/* Payload */
+	for (j = 0; j < CONFIG_HISTO_SIZE_BUCKETS; j++, size *= 2) {
+		len = snprintf(page, rem, "%7d", size);
+		page += len; rem -= len;
+		for (k = 0; k < CONFIG_HISTO_TIME_BUCKETS; k++) {
+			v = (type == HISTO_REQUEST) ?
+			      ((cmd == READ) ?
+				  disk_stat_read(disk, read_req_histo[j][k]) :
+				  disk_stat_read(disk, write_req_histo[j][k])) :
+			      ((cmd == READ) ?
+				  disk_stat_read(disk, read_dma_histo[j][k]) :
+				  disk_stat_read(disk, write_dma_histo[j][k]));
+			len = snprintf(page, rem, "\t%d", v);
+			page += len; rem -= len;
+		}
+		len = snprintf(page, rem, "\n");
+		page += len; rem -= len;
+	}
+	return page - optr;
+}
+
+
+/**
+ * sysfs show() methods for the four histogram channels.
+ */
+static ssize_t disk_read_request_histo_read(struct gendisk * disk, char *page)
+{
+	return dump_histo(READ, HISTO_REQUEST, disk, page);
+}
+
+static ssize_t disk_read_dma_histo_read(struct gendisk * disk, char *page)
+{
+	return dump_histo(READ, HISTO_DMA, disk, page);
+}
+
+static ssize_t disk_write_request_histo_read(struct gendisk * disk, char *page)
+{
+	return dump_histo(WRITE, HISTO_REQUEST, disk, page);
+}
+
+static ssize_t disk_write_dma_histo_read(struct gendisk * disk, char *page)
+{
+	return dump_histo(WRITE, HISTO_DMA, disk, page);
+}
+
+#endif
diff -uprN linux-2.6.18.1/block/ll_rw_blk.c block_histogram/block/ll_rw_blk.c
--- linux-2.6.18.1/block/ll_rw_blk.c	2006-11-15 15:12:00.000000000 -0800
+++ block_histogram/block/ll_rw_blk.c	2006-11-15 18:08:07.000000000 -0800
@@ -3469,6 +3469,7 @@ void end_that_request_last(struct reques
 		__disk_stat_add(disk, ticks[rw], duration);
 		disk_round_stats(disk);
 		disk->in_flight--;
+		block_histogram_req_cmplt(disk, req);
 	}
 	if (req->end_io)
 		req->end_io(req, error);
diff -uprN linux-2.6.18.1/drivers/scsi/scsi_lib.c block_histogram/drivers/scsi/scsi_lib.c
--- linux-2.6.18.1/drivers/scsi/scsi_lib.c	2006-11-15 16:37:34.000000000 -0800
+++ block_histogram/drivers/scsi/scsi_lib.c	2006-11-15 18:08:07.000000000 -0800
@@ -1477,6 +1477,7 @@ static void scsi_request_fn(struct reque
 		/*
 		 * Dispatch the command to the low-level driver.
 		 */
+		block_histogram_start_time(req);
 		rtn = scsi_dispatch_cmd(cmd);
 		spin_lock_irq(q->queue_lock);
 		if(rtn) {
diff -uprN linux-2.6.18.1/include/linux/blkdev.h block_histogram/include/linux/blkdev.h
--- linux-2.6.18.1/include/linux/blkdev.h	2006-10-13 20:34:03.000000000 -0700
+++ block_histogram/include/linux/blkdev.h	2006-11-15 18:08:07.000000000 -0800
@@ -154,7 +154,10 @@ struct request {
 	int rq_status;	/* should split this into a few status bits */
 	int errors;
 	struct gendisk *rq_disk;
-	unsigned long start_time;
+	unsigned long start_time;	/* when request submitted */
+#ifdef	CONFIG_BLOCK_HISTOGRAM
+	unsigned long io_start_time;	/* when passed to hardware */
+#endif
 
 	/* Number of scatter-gather DMA addr+len pairs after
 	 * physical address coalescing is performed.
@@ -840,5 +843,13 @@ void kblockd_flush(void);
 #define MODULE_ALIAS_BLOCKDEV_MAJOR(major) \
 	MODULE_ALIAS("block-major-" __stringify(major) "-*")
 
+#ifdef	CONFIG_BLOCK_HISTOGRAM
+inline static void block_histogram_start_time(struct request *req)
+{
+	req->io_start_time = jiffies;
+}
+#else
+#define block_histogram_start_time(req)
+#endif
 
 #endif
diff -uprN linux-2.6.18.1/include/linux/genhd.h block_histogram/include/linux/genhd.h
--- linux-2.6.18.1/include/linux/genhd.h	2006-10-13 20:34:03.000000000 -0700
+++ block_histogram/include/linux/genhd.h	2006-11-15 18:08:07.000000000 -0800
@@ -11,6 +11,8 @@
 
 #include <linux/types.h>
 
+struct request;
+
 enum {
 /* These three have identical behaviour; use the second one if DOS FDISK gets
    confused about extended/logical partitions starting past cylinder 1023. */
@@ -89,6 +91,10 @@ struct hd_struct {
 #define GENHD_FL_UP				16
 #define GENHD_FL_SUPPRESS_PARTITION_INFO	32
 
+#define	BASE_HISTO_SIZE	4	/* smallest transfer size, sectors */
+#define	BASE_HISTO_TIME	10	/* shortest transfer time, ms */
+
+
 struct disk_stats {
 	unsigned long sectors[2];	/* READs and WRITEs */
 	unsigned long ios[2];
@@ -96,6 +102,12 @@ struct disk_stats {
 	unsigned long ticks[2];
 	unsigned long io_ticks;
 	unsigned long time_in_queue;
+#ifdef	CONFIG_BLOCK_HISTOGRAM
+	int	read_req_histo[CONFIG_HISTO_SIZE_BUCKETS][CONFIG_HISTO_TIME_BUCKETS];
+	int	read_dma_histo[CONFIG_HISTO_SIZE_BUCKETS][CONFIG_HISTO_TIME_BUCKETS];
+	int	write_req_histo[CONFIG_HISTO_SIZE_BUCKETS][CONFIG_HISTO_TIME_BUCKETS];
+	int	write_dma_histo[CONFIG_HISTO_SIZE_BUCKETS][CONFIG_HISTO_TIME_BUCKETS];
+#endif
 };
 	
 struct gendisk {
@@ -230,6 +242,21 @@ extern struct gendisk *get_gendisk(dev_t
 extern void set_device_ro(struct block_device *bdev, int flag);
 extern void set_disk_ro(struct gendisk *disk, int flag);
 
+#ifdef	CONFIG_BLOCK_HISTOGRAM
+extern void block_histogram_init(struct gendisk *disk);
+extern void block_histogram_completion(struct gendisk *disk,
+					unsigned long flags,
+					int sectors,
+					int jiffies,
+					int jiffies_dma);
+extern void block_histogram_req_cmplt(struct gendisk *disk, struct request *);
+#else
+#define block_histogram_init(disk)
+#define block_histogram_completion(disk, flags, sectors, jiffies, jiffies_dma)
+#define block_histogram_req_cmplt(disk, req)
+#endif
+
+
 /* drivers/char/random.c */
 extern void add_disk_randomness(struct gendisk *disk);
 extern void rand_initialize_disk(struct gendisk *disk);

--------------020205050504040708020802--
