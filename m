Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267163AbTBLNjI>; Wed, 12 Feb 2003 08:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266965AbTBLNiu>; Wed, 12 Feb 2003 08:38:50 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:32896 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267157AbTBLNiE>; Wed, 12 Feb 2003 08:38:04 -0500
Date: Wed, 12 Feb 2003 22:46:37 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.60 (14/34) floppy98-update
Message-ID: <20030212134637.GO1551@yuzuki.cinet.co.jp>
References: <20030212131737.GA1551@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212131737.GA1551@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.60 (14/34).

Updates floppy driver for PC98 in 2.5.50-ac1.

- Osamu Tomita

diff -Nru linux-2.5.50-ac1/drivers/block/Makefile linux-2.5.60/drivers/block/Makefile
--- linux-2.5.50-ac1/drivers/block/Makefile	2003-02-11 09:47:18.000000000 +0900
+++ linux-2.5.60/drivers/block/Makefile	2003-02-11 12:40:35.000000000 +0900
@@ -11,7 +11,7 @@
 obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o deadline-iosched.o
 
 obj-$(CONFIG_MAC_FLOPPY)	+= swim3.o
-ifneq ($(CONFIG_PC9800),y)
+ifneq ($(CONFIG_X86_PC9800),y)
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy.o
 else
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy98.o
diff -Nru linux-2.5.50-ac1/drivers/block/floppy98.c linux-2.5.60/drivers/block/floppy98.c
--- linux-2.5.50-ac1/drivers/block/floppy98.c	2003-02-11 09:47:18.000000000 +0900
+++ linux-2.5.60/drivers/block/floppy98.c	2003-02-11 12:44:51.000000000 +0900
@@ -167,6 +167,7 @@
 #include <linux/kernel.h>
 #include <linux/timer.h>
 #include <linux/workqueue.h>
+#include <linux/version.h>
 #define FDPATCHES
 #include <linux/fdreg.h>
 
@@ -254,7 +255,6 @@
 void floppy_interrupt(int irq, void *dev_id, struct pt_regs * regs);
 static int set_mode(char mask, char data);
 static void register_devfs_entries (int drive) __init;
-static devfs_handle_t devfs_handle;
 
 #define K_64	0x10000		/* 64KB */
 
@@ -275,9 +275,8 @@
 static int irqdma_allocated;
 
 #define LOCAL_END_REQUEST
-#define MAJOR_NR FLOPPY_MAJOR
 #define DEVICE_NAME "floppy"
-#define DEVICE_NR(device) ( (minor(device) & 3) | ((minor(device) & 0x80 ) >> 5 ))
+
 #include <linux/blk.h>
 #include <linux/blkpg.h>
 #include <linux/cdrom.h> /* for the compatibility eject ioctl */
@@ -2354,7 +2353,7 @@
 	if (end_that_request_first(req, uptodate, current_count_sectors))
 		return;
 	add_disk_randomness(req->rq_disk);
-	floppy_off((int)req->rq_disk->private_data);
+	floppy_off((long)req->rq_disk->private_data);
 	blkdev_dequeue_request(req);
 	end_that_request_last(req);
 
@@ -2687,7 +2686,7 @@
 		return 0;
 	}
 
-	set_fdc((int)current_req->rq_disk->private_data);
+	set_fdc((long)current_req->rq_disk->private_data);
 
 	raw_cmd = &default_raw_cmd;
 	raw_cmd->flags = FD_RAW_SPIN | FD_RAW_NEED_DISK | FD_RAW_NEED_DISK |
@@ -2967,7 +2966,11 @@
 
 	for (;;) {
 		if (!current_req) {
-			struct request *req = elv_next_request(&floppy_queue);
+			struct request *req;
+
+			spin_lock_irq(floppy_queue.queue_lock);
+			req = elv_next_request(&floppy_queue);
+			spin_unlock_irq(floppy_queue.queue_lock);
 			if (!req) {
 				do_floppy = NULL;
 				unlock_fdc();
@@ -2975,7 +2978,7 @@
 			}
 			current_req = req;
 		}
-		drive = (int)current_req->rq_disk->private_data;
+		drive = (long)current_req->rq_disk->private_data;
 		set_fdc(drive);
 		reschedule_timeout(current_reqD, "redo fd request", 0);
 
@@ -3354,7 +3357,7 @@
 static int invalidate_drive(struct block_device *bdev)
 {
 	/* invalidate the buffer track to force a reread */
-	set_bit(DRIVE(to_kdev_t(bdev->bd_dev)), &fake_change);
+	set_bit((long)bdev->bd_disk->private_data, &fake_change);
 	process_fd_request();
 	check_disk_change(bdev);
 	return 0;
@@ -3902,7 +3905,7 @@
  */
 static int check_floppy_change(struct gendisk *disk)
 {
-	int drive = (int)disk->private_data;
+	int drive = (long)disk->private_data;
 
 #ifdef PC9800_DEBUG_FLOPPY
 	printk("check_floppy_change: MINOR=%d\n", minor(dev));
@@ -4009,7 +4012,7 @@
  * geometry formats */
 static int floppy_revalidate(struct gendisk *disk)
 {
-	int drive=(int)disk->private_data;
+	int drive=(long)disk->private_data;
 #define NO_GEOM (!current_type[drive] && !ITYPE(UDRS->fd_device))
 	int cf;
 	int res = 0;
@@ -4058,27 +4061,28 @@
 	.revalidate_disk= floppy_revalidate,
 };
 
-static void __init register_devfs_entries (int drive)
-{
-    int base_minor, i;
-    static char *table[] =
-    {"",
+static char *table[] =
+{"",
 #if 0
-     "d360", 
+"d360", 
 #else
-     "h1232",
+"h1232",
 #endif
-     "h1200", "u360", "u720", "h360", "h720",
-     "u1440", "u2880", "CompaQ", "h1440", "u1680", "h410",
-     "u820", "h1476", "u1722", "h420", "u830", "h1494", "u1743",
-     "h880", "u1040", "u1120", "h1600", "u1760", "u1920",
-     "u3200", "u3520", "u3840", "u1840", "u800", "u1600",
-     NULL
-    };
-    static int t360[] = {1,0}, t1200[] = {2,5,6,10,12,14,16,18,20,23,0},
-      t3in[] = {8,9,26,27,28, 7,11,15,19,24,25,29,31, 3,4,13,17,21,22,30,0};
-    static int *table_sup[] = 
-    {NULL, t360, t1200, t3in+5+8, t3in+5, t3in, t3in};
+"h1200", "u360", "u720", "h360", "h720",
+"u1440", "u2880", "CompaQ", "h1440", "u1680", "h410",
+"u820", "h1476", "u1722", "h420", "u830", "h1494", "u1743",
+"h880", "u1040", "u1120", "h1600", "u1760", "u1920",
+"u3200", "u3520", "u3840", "u1840", "u800", "u1600",
+NULL
+};
+static int t360[] = {1,0}, t1200[] = {2,5,6,10,12,14,16,18,20,23,0},
+t3in[] = {8,9,26,27,28, 7,11,15,19,24,25,29,31, 3,4,13,17,21,22,30,0};
+static int *table_sup[] = 
+{NULL, t360, t1200, t3in+5+8, t3in+5, t3in, t3in};
+
+static void __init register_devfs_entries (int drive)
+{
+    int base_minor, i;
 
     base_minor = (drive < 4) ? drive : (124 + drive);
     if (UDP->cmos < NUMBER(default_drive_params)) {
@@ -4086,8 +4090,8 @@
 	do {
 	    char name[16];
 
-	    sprintf (name, "%d%s", drive, table[table_sup[UDP->cmos][i]]);
-	    devfs_register (devfs_handle, name, DEVFS_FL_DEFAULT, MAJOR_NR,
+	    sprintf(name, "floppy/%d%s", drive, table[table_sup[UDP->cmos][i]]);
+	    devfs_register(NULL, name, DEVFS_FL_DEFAULT, FLOPPY_MAJOR,
 			    base_minor + (table_sup[UDP->cmos][i] << 2),
 			    S_IFBLK | S_IRUSR | S_IWUSR | S_IRGRP |S_IWGRP,
 			    &floppy_fops, NULL);
@@ -4268,21 +4272,21 @@
 			goto Enomem;
 	}
 
-	devfs_handle = devfs_mk_dir (NULL, "floppy", NULL);
-	if (register_blkdev(MAJOR_NR,"fd",&floppy_fops)) {
-		printk("Unable to get major %d for floppy\n",MAJOR_NR);
+	devfs_mk_dir (NULL, "floppy", NULL);
+	if (register_blkdev(FLOPPY_MAJOR,"fd",&floppy_fops)) {
+		printk("Unable to get major %d for floppy\n",FLOPPY_MAJOR);
 		err = -EBUSY;
 		goto out;
 	}
 
 	for (i=0; i<N_DRIVE; i++) {
-		disks[i]->major = MAJOR_NR;
+		disks[i]->major = FLOPPY_MAJOR;
 		disks[i]->first_minor = TOMINOR(i);
 		disks[i]->fops = &floppy_fops;
 		sprintf(disks[i]->disk_name, "fd%d", i);
 	}
 
-	blk_register_region(MKDEV(MAJOR_NR, 0), 256, THIS_MODULE,
+	blk_register_region(MKDEV(FLOPPY_MAJOR, 0), 256, THIS_MODULE,
 				floppy_find, NULL, NULL);
 
 	for (i=0; i<256; i++)
@@ -4390,7 +4394,7 @@
 		if (fdc_state[FDC(drive)].version == FDC_NONE)
 			continue;
 		/* to be cleaned up... */
-		disks[drive]->private_data = (void*)drive;
+		disks[drive]->private_data = (void*)(long)drive;
 		disks[drive]->queue = &floppy_queue;
 		add_disk(disks[drive]);
 	}
@@ -4401,8 +4405,8 @@
 out1:
 	del_timer(&fd_timeout);
 out2:
-	blk_unregister_region(MKDEV(MAJOR_NR, 0), 256);
-	unregister_blkdev(MAJOR_NR,"fd");
+	blk_unregister_region(MKDEV(FLOPPY_MAJOR, 0), 256);
+	unregister_blkdev(FLOPPY_MAJOR,"fd");
 	blk_cleanup_queue(&floppy_queue);
 out:
 	for (i=0; i<N_DRIVE; i++)
@@ -4592,6 +4596,18 @@
 
 char *floppy;
 
+static void unregister_devfs_entries (int drive)
+{
+    int i;
+
+    if (UDP->cmos < NUMBER(default_drive_params)) {
+	i = 0;
+	do {
+	    devfs_remove("floppy/%d%s", drive, table[table_sup[UDP->cmos][i]]);
+	} while (table_sup[UDP->cmos][i++]);
+    }
+}
+
 static void __init parse_floppy_cfg_string(char *cfg)
 {
 	char *ptr;
@@ -4621,15 +4637,17 @@
 	int drive;
 		
 	platform_device_unregister(&floppy_device);
-	devfs_unregister (devfs_handle);
-	blk_unregister_region(MKDEV(MAJOR_NR, 0), 256);
-	unregister_blkdev(MAJOR_NR, "fd");
+	blk_unregister_region(MKDEV(FLOPPY_MAJOR, 0), 256);
+	unregister_blkdev(FLOPPY_MAJOR, "fd");
 	for (drive = 0; drive < N_DRIVE; drive++) {
 		if ((allowed_drive_mask & (1 << drive)) &&
-		    fdc_state[FDC(drive)].version != FDC_NONE)
+		    fdc_state[FDC(drive)].version != FDC_NONE) {
 			del_gendisk(disks[drive]);
+			unregister_devfs_entries(drive);
+		}
 		put_disk(disks[drive]);
 	}
+	devfs_remove("floppy");
 
 	blk_cleanup_queue(&floppy_queue);
 	/* eject disk, if any */
