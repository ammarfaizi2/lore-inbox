Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265603AbTASGeI>; Sun, 19 Jan 2003 01:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265608AbTASGeI>; Sun, 19 Jan 2003 01:34:08 -0500
Received: from yuzuki.cinet.co.jp ([61.197.228.219]:52866 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S265603AbTASGd4>; Sun, 19 Jan 2003 01:33:56 -0500
Date: Sun, 19 Jan 2003 15:42:47 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 sub-arch (9/29) ac-update
Message-ID: <20030119064247.GH2965@yuzuki.cinet.co.jp>
References: <20030119051043.GA2662@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030119051043.GA2662@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.59 (9/29).

Updates floppy driver for PC98 in 2.5.50-ac1.

diff -Nru linux-2.5.50-ac1/drivers/block/Makefile linux-2.5.54/drivers/block/Makefile
--- linux-2.5.50-ac1/drivers/block/Makefile	2003-01-04 10:47:57.000000000 +0900
+++ linux-2.5.54/drivers/block/Makefile	2003-01-04 13:35:45.000000000 +0900
@@ -14,7 +14,7 @@
 obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o deadline-iosched.o
 
 obj-$(CONFIG_MAC_FLOPPY)	+= swim3.o
-ifneq ($(CONFIG_PC9800),y)
+ifneq ($(CONFIG_X86_PC9800),y)
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy.o
 else
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy98.o
diff -Nru linux-2.5.50-ac1/drivers/block/floppy98.c linux-2.5.52/drivers/block/floppy98.c
--- linux-2.5.50-ac1/drivers/block/floppy98.c	2002-12-16 09:15:54.000000000 +0900
+++ linux-2.5.52/drivers/block/floppy98.c	2002-12-16 14:42:13.000000000 +0900
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
@@ -3354,7 +3353,7 @@
 static int invalidate_drive(struct block_device *bdev)
 {
 	/* invalidate the buffer track to force a reread */
-	set_bit(DRIVE(to_kdev_t(bdev->bd_dev)), &fake_change);
+	set_bit((int)bdev->bd_disk->private_data, &fake_change);
 	process_fd_request();
 	check_disk_change(bdev);
 	return 0;
@@ -4058,27 +4057,28 @@
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
@@ -4086,8 +4086,8 @@
 	do {
 	    char name[16];
 
-	    sprintf (name, "%d%s", drive, table[table_sup[UDP->cmos][i]]);
-	    devfs_register (devfs_handle, name, DEVFS_FL_DEFAULT, MAJOR_NR,
+	    sprintf(name, "floppy/%d%s", drive, table[table_sup[UDP->cmos][i]]);
+	    devfs_register(NULL, name, DEVFS_FL_DEFAULT, FLOPPY_MAJOR,
 			    base_minor + (table_sup[UDP->cmos][i] << 2),
 			    S_IFBLK | S_IRUSR | S_IWUSR | S_IRGRP |S_IWGRP,
 			    &floppy_fops, NULL);
@@ -4268,21 +4268,21 @@
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
@@ -4401,8 +4401,8 @@
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
@@ -4592,6 +4592,18 @@
 
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
@@ -4621,15 +4633,17 @@
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
