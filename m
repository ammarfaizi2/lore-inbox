Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286895AbSA2XaX>; Tue, 29 Jan 2002 18:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286934AbSA2X3C>; Tue, 29 Jan 2002 18:29:02 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:27552 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S286647AbSA2X1a>;
	Tue, 29 Jan 2002 18:27:30 -0500
Message-ID: <3C572F5E.2C555E6D@us.ibm.com>
Date: Tue, 29 Jan 2002 15:25:18 -0800
From: Mingming cao <cmm@us.ibm.com>
Organization: Linux Technology Center
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
        lse-tech@lists.sourceforge.net, Jens Axboe <axboe@suse.de>
Subject: Updated disk I/O statistics patch for 2.5.3-pre6
Content-Type: multipart/mixed;
 boundary="------------FDC39D0376112907EE3ED08E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------FDC39D0376112907EE3ED08E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi, Jens and All,

A couple of months ago,  I made a patch to gathering disk I/O statistics
for all majors.  Thank you all for your feedbacks.  Basically, in that
patch, the disk I/O statistics are gathered at the per request queue
level,  instead of at the global level in the current implementation. 
Statistic data are moved from the global kstat structure to the
request_queue structures, and it is allocated/freed when the request
queue is initialized and freed.  This way it is 1)self-controlled,
2)statistics implementation is not affected by the major/minor numbers,
3) faster the lookup, and 4)able to gathering statistics for all disks
while keep the memory needs minimized.

Here is the updated disk I/O statistics patch corresponding to the block
I/O layer changes in 2.5. It's aganist 2.5.3-pre6. Please take a look.


-- 
Mingming Cao
IBM Linux Technology Center
--------------FDC39D0376112907EE3ED08E
Content-Type: text/plain; charset=us-ascii;
 name="disk-stat-rq-253-pre6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="disk-stat-rq-253-pre6"

diff -urN -X dontdiff 253-pre6/drivers/block/ll_rw_blk.c dk-pre6/drivers/block/ll_rw_blk.c
--- 253-pre6/drivers/block/ll_rw_blk.c	Tue Jan 29 14:29:39 2002
+++ dk-pre6/drivers/block/ll_rw_blk.c	Tue Jan 29 14:52:44 2002
@@ -724,6 +724,11 @@
 
 	elevator_exit(q, &q->elevator);
 
+	/*
+	 * free statistics structure
+	 */
+	kfree(q->dk_stat);
+
 	memset(q, 0, sizeof(*q));
 }
 
@@ -800,6 +805,7 @@
 int blk_init_queue(request_queue_t *q, request_fn_proc *rfn, spinlock_t *lock)
 {
 	int ret;
+	struct disk_stat * new;
 
 	if (blk_init_free_list(q))
 		return -ENOMEM;
@@ -827,6 +833,17 @@
 
 	blk_queue_max_hw_segments(q, MAX_HW_SEGMENTS);
 	blk_queue_max_phys_segments(q, MAX_PHYS_SEGMENTS);
+
+	/*
+	 * At last, allocate and initilize the statistics
+	 */
+	new = kmalloc(sizeof(struct disk_stat),GFP_KERNEL);
+	if ( new == NULL)
+		printk(KERN_WARNING "blk_init_queue:error in allocating queue statistics\n");
+	else
+		memset(new, 0, sizeof(struct disk_stat));
+	q->dk_stat = new;
+
 	return 0;
 }
 
@@ -934,21 +951,20 @@
 
 void drive_stat_acct(struct request *rq, int nr_sectors, int new_io)
 {
-	unsigned int major = major(rq->rq_dev);
 	int rw = rq_data_dir(rq);
-	unsigned int index;
+	request_queue_t * q = rq->q;
+	struct disk_stat * ds;
 
-	index = disk_index(rq->rq_dev);
-	if ((index >= DK_MAX_DISK) || (major >= DK_MAX_MAJOR))
+	ds = q->dk_stat;
+	if (ds == NULL)
 		return;
 
-	kstat.dk_drive[major][index] += new_io;
 	if (rw == READ) {
-		kstat.dk_drive_rio[major][index] += new_io;
-		kstat.dk_drive_rblk[major][index] += nr_sectors;
+		ds->dk_drive_rio += new_io;
+		ds->dk_drive_rblk += nr_sectors;
 	} else if (rw == WRITE) {
-		kstat.dk_drive_wio[major][index] += new_io;
-		kstat.dk_drive_wblk[major][index] += nr_sectors;
+		ds->dk_drive_wio += new_io;
+		ds->dk_drive_wblk += nr_sectors;
 	} else
 		printk(KERN_ERR "drive_stat_acct: cmd not R/W?\n");
 }
diff -urN -X dontdiff 253-pre6/drivers/ide/ide.c dk-pre6/drivers/ide/ide.c
--- 253-pre6/drivers/ide/ide.c	Tue Jan 29 14:29:40 2002
+++ dk-pre6/drivers/ide/ide.c	Tue Jan 29 14:52:44 2002
@@ -1409,7 +1409,10 @@
 {
 	ide_hwif_t *hwif = (ide_hwif_t *)blk_dev[major(dev)].data;
 
-	return &hwif->drives[DEVICE_NR(dev) & 1].queue;
+	if (DEVICE_NR(dev) >= MAX_DRIVES)
+		return NULL;
+	else
+		return &hwif->drives[DEVICE_NR(dev) & 1].queue;
 }
 
 /*
diff -urN -X dontdiff 253-pre6/drivers/md/md.c dk-pre6/drivers/md/md.c
--- 253-pre6/drivers/md/md.c	Tue Jan 29 14:29:41 2002
+++ dk-pre6/drivers/md/md.c	Tue Jan 29 14:52:44 2002
@@ -3311,12 +3311,15 @@
 	ITERATE_RDEV(mddev,rdev,tmp) {
 		int major = major(rdev->dev);
 		int idx = disk_index(rdev->dev);
-
+		request_queue_t * rq = blk_get_queue(rdev->dev);
+		
 		if ((idx >= DK_MAX_DISK) || (major >= DK_MAX_MAJOR))
 			continue;
-
-		curr_events = kstat.dk_drive_rblk[major][idx] +
-						kstat.dk_drive_wblk[major][idx] ;
+		
+		if (rq == NULL || (rq->dk_stat == NULL))
+			continue;
+		curr_events = rq->dk_stat->dk_drive_rblk + 
+			rq->dk_stat->dk_drive_wblk ;
 		curr_events -= sync_io[major][idx];
 		if ((curr_events - rdev->last_events) > 32) {
 			rdev->last_events = curr_events;
diff -urN -X dontdiff 253-pre6/fs/proc/proc_misc.c dk-pre6/fs/proc/proc_misc.c
--- 253-pre6/fs/proc/proc_misc.c	Mon Jan  7 12:55:16 2002
+++ dk-pre6/fs/proc/proc_misc.c	Tue Jan 29 14:52:44 2002
@@ -36,6 +36,7 @@
 #include <linux/init.h>
 #include <linux/smp_lock.h>
 #include <linux/seq_file.h>
+#include <linux/blkdev.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -223,6 +224,23 @@
 };
 #endif
 
+static int show_disk_stat(char * page, int len, struct disk_stat * ds,
+				int major, int disk)
+{
+	int active = ds->dk_drive_rio + ds->dk_drive_wio +
+		ds->dk_drive_rblk + ds->dk_drive_wblk;
+	if (active)
+		len += sprintf(page + len,
+			"(%u,%u):(%u,%u,%u,%u,%u) ",
+			major, disk,
+			ds->dk_drive_rio + ds->dk_drive_wio,
+			ds->dk_drive_rio,
+			ds->dk_drive_rblk,
+			ds->dk_drive_wio,
+			ds->dk_drive_wblk
+		);
+	return len;
+}
 static int kstat_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -272,24 +290,29 @@
 
 	len += sprintf(page + len, "\ndisk_io: ");
 
-	for (major = 0; major < DK_MAX_MAJOR; major++) {
-		for (disk = 0; disk < DK_MAX_DISK; disk++) {
-			int active = kstat.dk_drive[major][disk] +
-				kstat.dk_drive_rblk[major][disk] +
-				kstat.dk_drive_wblk[major][disk];
-			if (active)
-				len += sprintf(page + len,
-					"(%u,%u):(%u,%u,%u,%u,%u) ",
-					major, disk,
-					kstat.dk_drive[major][disk],
-					kstat.dk_drive_rio[major][disk],
-					kstat.dk_drive_rblk[major][disk],
-					kstat.dk_drive_wio[major][disk],
-					kstat.dk_drive_wblk[major][disk]
-			);
+	for (major = 0; major < MAX_BLKDEV; major++) {
+		struct disk_stat * ds;
+
+		if (!(blk_dev[major].queue)){
+			ds = (BLK_DEFAULT_QUEUE(major))->dk_stat;
+			if (ds)
+				len = show_disk_stat(page, len, ds, major, 0);
+		}else {
+			request_queue_t * q;
+			struct gendisk * hd = get_gendisk(mk_kdev(major,0));
+			int max_disk = MINORMASK>>hd->minor_shift;
+
+			for (disk = 0; disk <= max_disk; disk++) {
+				q = blk_get_queue(mk_kdev(major,disk<<hd->minor_shift));
+				if (!q)
+					continue;
+				ds = q->dk_stat;
+				if (!ds)
+					continue;
+				len = show_disk_stat(page, len, ds, major,disk);
+			}
 		}
 	}
-
 	len += sprintf(page + len,
 		"\nctxt %lu\n"
 		"btime %lu\n"
diff -urN -X dontdiff 253-pre6/include/linux/blkdev.h dk-pre6/include/linux/blkdev.h
--- 253-pre6/include/linux/blkdev.h	Tue Jan 29 14:29:55 2002
+++ dk-pre6/include/linux/blkdev.h	Tue Jan 29 14:52:44 2002
@@ -131,6 +131,13 @@
  */
 #define QUEUE_NR_REQUESTS	8192
 
+struct disk_stat{
+	unsigned int dk_drive_rio;
+	unsigned int dk_drive_wio;
+	unsigned int dk_drive_rblk;
+	unsigned int dk_drive_wblk;
+};
+
 struct request_queue
 {
 	/*
@@ -191,6 +198,10 @@
 	unsigned long		seg_boundary_mask;
 
 	wait_queue_head_t	queue_wait;
+	/*
+	 * statistics
+	 */
+	struct disk_stat 	*dk_stat;
 };
 
 #define RQ_INACTIVE		(-1)
diff -urN -X dontdiff 253-pre6/include/linux/kernel_stat.h dk-pre6/include/linux/kernel_stat.h
--- 253-pre6/include/linux/kernel_stat.h	Mon Jan 14 13:27:06 2002
+++ dk-pre6/include/linux/kernel_stat.h	Tue Jan 29 14:52:44 2002
@@ -19,11 +19,6 @@
 	unsigned int per_cpu_user[NR_CPUS],
 	             per_cpu_nice[NR_CPUS],
 	             per_cpu_system[NR_CPUS];
-	unsigned int dk_drive[DK_MAX_MAJOR][DK_MAX_DISK];
-	unsigned int dk_drive_rio[DK_MAX_MAJOR][DK_MAX_DISK];
-	unsigned int dk_drive_wio[DK_MAX_MAJOR][DK_MAX_DISK];
-	unsigned int dk_drive_rblk[DK_MAX_MAJOR][DK_MAX_DISK];
-	unsigned int dk_drive_wblk[DK_MAX_MAJOR][DK_MAX_DISK];
 	unsigned int pgpgin, pgpgout;
 	unsigned int pswpin, pswpout;
 #if !defined(CONFIG_ARCH_S390)


--------------FDC39D0376112907EE3ED08E--

