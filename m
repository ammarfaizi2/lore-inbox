Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267042AbSKLXel>; Tue, 12 Nov 2002 18:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267043AbSKLXel>; Tue, 12 Nov 2002 18:34:41 -0500
Received: from jstevenson.plus.com ([212.159.71.212]:5549 "EHLO alpha.stev.org")
	by vger.kernel.org with ESMTP id <S267042AbSKLXec>;
	Tue, 12 Nov 2002 18:34:32 -0500
Subject: Re: iostats broken for devices with major number > DK_MAX_DISK (16)
From: James Stevenson <james@stev.org>
To: Cliff White <cliffw@osdl.org>
Cc: Per Andreas Buer <perbu@linpro.no>, linux-kernel@vger.kernel.org
In-Reply-To: <200211122325.gACNPhr08344@mail.osdl.org>
References: <200211122325.gACNPhr08344@mail.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 12 Nov 2002 23:40:43 +0000
Message-Id: <1037144443.1796.5.camel@god.stev.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > sorry for the intrusion. I noticed iostats didn't display statistics for
> > > devices on Mylex RAID constrollers. Det statistics are completely
> > > missing in /proc/stat. The reason seems to be an assumption that disks
> > > Devices on Mylex-controllers have major number 48. Would it break
> > > anything if DK_MAX_MAJOR if set higher (e.g. 64)?
> > > 
> > > AFAIK this goes for both 2.4 and the 2.5 series.
> > 
> > i have been runing with 2.4.x kernel with this number
> > set higher i have still yet to see any problem with it
> > other than using more memory.
> > 
> We've had the same problem, and we've been running with DK_MAX_MAJOR == 64, 
> using megaraid and acceleraid 2000 controllers. 
> Haven't seen any problems 
> cliffw
> OSDL

i had a patch for a while which solved the problem
though it had problems with scsi stuff and i dont know
if it will even run at all last time i was running it
was on 2.4.17 i think lots of stuff changed and i did not port
it to 2.4.19. Its was not my patch though i picked it off this list
and yet again i cannot remember the original author.

heres what it is but dont hold me to this its not tested on newer
kernels !!.

	James

Index: drivers/block/ll_rw_blk.c
===================================================================
RCS file: /cvs-root/kernel-source/drivers/block/ll_rw_blk.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ll_rw_blk.c
--- drivers/block/ll_rw_blk.c	30 Dec 2001 08:47:06 -0000	1.1.1.1
+++ drivers/block/ll_rw_blk.c	13 Jan 2002 15:33:30 -0000
@@ -183,7 +183,11 @@
 
 	if (count)
 		printk("blk_cleanup_queue: leaked requests (%d)\n", count);
-
+	/*
+	 * free statistics structure
+	 */
+	kfree(q->dk_stat);
+	
 	memset(q, 0, sizeof(*q));
 }
 
@@ -393,6 +397,8 @@
  **/
 void blk_init_queue(request_queue_t * q, request_fn_proc * rfn)
 {
+	struct disk_stat * new;	
+
 	INIT_LIST_HEAD(&q->queue_head);
 	elevator_init(&q->elevator, ELEVATOR_LINUS);
 	blk_init_free_list(q);
@@ -413,6 +419,15 @@
 	 */
 	q->plug_device_fn 	= generic_plug_device;
 	q->head_active    	= 1;
+	/* 
+	 * At last, allocate and initialize the statistics 
+	 */
+	new = kmalloc(sizeof(struct disk_stat), GFP_KERNEL);
+	if (new == NULL)
+		printk(KERN_ERR "blk_init_queue:error allocating statisitcs\n");
+	else
+		memset(new, 0, sizeof(struct disk_stat));
+	q->dk_stat = new;
 }
 
 #define blkdev_free_rq(list) list_entry((list)->next, struct request, queue);
@@ -497,23 +512,18 @@
 	else ro_bits[major][minor >> 5] &= ~(1 << (minor & 31));
 }
 
-inline void drive_stat_acct (kdev_t dev, int rw,
+inline void drive_stat_acct (struct disk_stat * ds, int rw,
 				unsigned long nr_sectors, int new_io)
 {
-	unsigned int major = MAJOR(dev);
-	unsigned int index;
-
-	index = disk_index(dev);
-	if ((index >= DK_MAX_DISK) || (major >= DK_MAX_MAJOR))
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
@@ -529,7 +539,7 @@
 static inline void add_request(request_queue_t * q, struct request * req,
 			       struct list_head *insert_here)
 {
-	drive_stat_acct(req->rq_dev, req->cmd, req->nr_sectors, 1);
+	drive_stat_acct(q->dk_stat, req->cmd, req->nr_sectors, 1);
 
 	if (!q->plugged && q->head_active && insert_here == &q->queue_head) {
 		spin_unlock_irq(&io_request_lock);
@@ -701,7 +711,7 @@
 			req->bhtail = bh;
 			req->nr_sectors = req->hard_nr_sectors += count;
 			blk_started_io(count);
-			drive_stat_acct(req->rq_dev, req->cmd, count, 0);
+			drive_stat_acct(q->dk_stat, req->cmd, count, 0);
 			attempt_back_merge(q, req, max_sectors, max_segments);
 			goto out;
 
@@ -716,7 +726,7 @@
 			req->sector = req->hard_sector = sector;
 			req->nr_sectors = req->hard_nr_sectors += count;
 			blk_started_io(count);
-			drive_stat_acct(req->rq_dev, req->cmd, count, 0);
+			drive_stat_acct(q->dk_stat, req->cmd, count, 0);
 			attempt_front_merge(q, head, req, max_sectors, max_segments);
 			goto out;
 
Index: drivers/ide/ide.c
===================================================================
RCS file: /cvs-root/kernel-source/drivers/ide/ide.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ide.c
--- drivers/ide/ide.c	30 Dec 2001 08:47:37 -0000	1.1.1.1
+++ drivers/ide/ide.c	13 Jan 2002 15:33:31 -0000
@@ -1451,8 +1451,10 @@
 request_queue_t *ide_get_queue (kdev_t dev)
 {
 	ide_hwif_t *hwif = (ide_hwif_t *)blk_dev[MAJOR(dev)].data;
-
-	return &hwif->drives[DEVICE_NR(dev) & 1].queue;
+	if (DEVICE_NR(dev) >= MAX_DRIVES)
+		 return NULL;
+	else 
+		return &hwif->drives[DEVICE_NR(dev)].queue;
 }
 
 /*
Index: drivers/md/md.c
===================================================================
RCS file: /cvs-root/kernel-source/drivers/md/md.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 md.c
--- drivers/md/md.c	30 Dec 2001 08:47:51 -0000	1.1.1.1
+++ drivers/md/md.c	13 Jan 2002 15:33:32 -0000
@@ -3302,12 +3302,15 @@
 	ITERATE_RDEV(mddev,rdev,tmp) {
 		int major = MAJOR(rdev->dev);
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
Index: fs/proc/proc_misc.c
===================================================================
RCS file: /cvs-root/kernel-source/fs/proc/proc_misc.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 proc_misc.c
--- fs/proc/proc_misc.c	30 Dec 2001 08:44:42 -0000	1.1.1.1
+++ fs/proc/proc_misc.c	13 Jan 2002 15:33:35 -0000
@@ -36,12 +36,12 @@
 #include <linux/init.h>
 #include <linux/smp_lock.h>
 #include <linux/seq_file.h>
+#include <linux/blkdev.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
 
-
 #define LOAD_INT(x) ((x) >> FSHIFT)
 #define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
 /*
@@ -234,7 +234,23 @@
 	release:	seq_release,
 };
 #endif
-
+static int show_disk_stat(char * page, int len, struct disk_stat * ds,
+					int major, int disk)
+{
+	int active = ds->dk_drive_rio + ds->dk_drive_wio +
+		 ds->dk_drive_rblk + ds->dk_drive_wblk;
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
@@ -284,21 +300,27 @@
 
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
+			struct gendisk * hd = get_gendisk(MKDEV(major,0));
+			int max_disk = MINORMASK>>hd->minor_shift;
+
+			for (disk = 0; disk <= max_disk; disk++) {
+				q = blk_get_queue(MKDEV(major,disk<<hd->minor_shift));
+				if (!q)
+					continue;
+				ds = q->dk_stat;
+				if (!ds)
+					continue;
+				len = show_disk_stat(page, len, ds, major,disk);
+			}
 		}
 	}
 
Index: include/linux/blkdev.h
===================================================================
RCS file: /cvs-root/kernel-source/include/linux/blkdev.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 blkdev.h
--- include/linux/blkdev.h	30 Dec 2001 08:45:13 -0000	1.1.1.1
+++ include/linux/blkdev.h	13 Jan 2002 15:33:37 -0000
@@ -71,6 +71,13 @@
 	struct list_head free;
 };
 
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
@@ -122,6 +129,10 @@
 	 * Tasks wait here for free request
 	 */
 	wait_queue_head_t	wait_for_request;
+	/*
+	 * statistics
+	 */
+	struct disk_stat * dk_stat;
 };
 
 struct blk_dev_struct {
@@ -186,7 +197,7 @@
 #define blkdev_next_request(req) blkdev_entry_to_request((req)->queue.next)
 #define blkdev_prev_request(req) blkdev_entry_to_request((req)->queue.prev)
 
-extern void drive_stat_acct (kdev_t dev, int rw,
+extern void drive_stat_acct (struct disk_stat *, int rw,
 					unsigned long nr_sectors, int new_io);
 
 static inline int get_hardsect_size(kdev_t dev)
Index: include/linux/kernel_stat.h
===================================================================
RCS file: /cvs-root/kernel-source/include/linux/kernel_stat.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 kernel_stat.h
--- include/linux/kernel_stat.h	30 Dec 2001 08:45:14 -0000	1.1.1.1
+++ include/linux/kernel_stat.h	13 Jan 2002 15:33:37 -0000
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

