Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318118AbSGWPyI>; Tue, 23 Jul 2002 11:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318111AbSGWPyA>; Tue, 23 Jul 2002 11:54:00 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:47036 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S318118AbSGWPvs>; Tue, 23 Jul 2002 11:51:48 -0400
Message-Id: <200207231554.g6NFsgW30398@d06relay02.portsmouth.uk.ibm.com>
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: Re: [PATCH] 2.5.27: s390 fixes.
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Mail-Copies-To: arndb@de.ibm.com
Date: Tue, 23 Jul 2002 19:49:09 +0200
References: <200207221950.45748.schwidefsky@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

updated patch, part 4/6:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.683.1.3 -> 1.683.1.4
#	drivers/s390/block/dasd_eckd.c	1.9     -> 1.10   
#	drivers/s390/block/dasd_ioctl.c	1.2     -> 1.3    
#	drivers/s390/block/dasd_diag.c	1.6     -> 1.7    
#	drivers/s390/block/dasd_proc.c	1.2     -> 1.3    
#	drivers/s390/block/dasd.c	1.26    -> 1.27   
#	drivers/s390/block/dasd_devmap.c	1.1     -> 1.2    
#	drivers/s390/block/dasd_fba.c	1.6     -> 1.7    
#	drivers/s390/block/dasd_int.h	1.6     -> 1.7    
#	drivers/s390/block/dasd_genhd.c	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/23	arnd@bergmann-dalldorf.de	1.683.1.4
# convert dasd driver to use struct block_device instead of kdev_t internally
# use C99 style named initializers for dasd
# --------------------------------------------
#
diff -Nru a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
--- a/drivers/s390/block/dasd.c	Tue Jul 23 18:53:47 2002
+++ b/drivers/s390/block/dasd.c	Tue Jul 23 18:53:47 2002
@@ -292,8 +292,8 @@
 		return -ENODEV;
 	minor = devmap->devindex % DASD_PER_MAJOR;
 
-	/* Set kdev and the device name. */
-	device->kdev = mk_kdev(gdp->major, minor << DASD_PARTN_BITS);
+	/* Set bdev and the device name. */
+	device->bdev = bdget(MKDEV(gdp->major, minor << DASD_PARTN_BITS));
 	dasd_device_name(device->name, minor, 0, gdp);
 
 	/* Find a discipline for the device. */
@@ -304,14 +304,14 @@
 	/* Add a proc directory and the dasd device entry to devfs. */
 	sprintf(buffer, "%04x", device->devinfo.devno);
 	dir = devfs_mk_dir(dasd_devfs_handle, buffer, device);
-	gdp->de_arr[minor(device->kdev) >> DASD_PARTN_BITS] = dir;
+	gdp->de_arr[minor] = dir;
 	if (devmap->features & DASD_FEATURE_READONLY)
 		devfs_perm = S_IFBLK | S_IRUSR;
 	else
 		devfs_perm = S_IFBLK | S_IRUSR | S_IWUSR;
 	device->devfs_entry = devfs_register(dir, "device", DEVFS_FL_DEFAULT,
-					     major(device->kdev),
-					     minor(device->kdev),
+					     gdp->major,
+					     minor << DASD_PARTN_BITS,
 					     devfs_perm,
 					     &dasd_device_operations, NULL);
 	device->state = DASD_STATE_KNOWN;
@@ -326,6 +326,7 @@
 {
 	struct gendisk *gdp;
 	dasd_devmap_t *devmap;
+	struct block_device *bdev;
 	int minor;
 
 	devmap = dasd_devmap_from_devno(device->devinfo.devno);
@@ -341,6 +342,11 @@
 	/* Forget the discipline information. */
 	device->discipline = NULL;
 	device->state = DASD_STATE_NEW;
+
+	/* Forget the block device */
+	bdev = device->bdev;
+	device->bdev = NULL;
+	bdput(bdev);
 }
 
 /*
@@ -427,21 +433,29 @@
 }
 
 /*
+ * get the kdev_t of a device 
+ * FIXME: remove this when no longer needed
+ */
+static inline kdev_t
+dasd_partition_to_kdev_t(dasd_device_t *device, unsigned int partition)
+{
+	return to_kdev_t(device->bdev->bd_dev+partition);
+}
+
+
+/*
  * Setup block device.
  */
 static inline int
 dasd_state_accept_to_ready(dasd_device_t * device)
 {
 	dasd_devmap_t *devmap;
-	int major, minor;
 	int rc, i;
 
 	devmap = dasd_devmap_from_devno(device->devinfo.devno);
 	if (devmap->features & DASD_FEATURE_READONLY) {
-		major = major(device->kdev);
-		minor = minor(device->kdev);
 		for (i = 0; i < (1 << DASD_PARTN_BITS); i++)
-			set_device_ro(mk_kdev(major, minor+i), 1);
+			set_device_ro(dasd_partition_to_kdev_t(device, i), 1);
 		DEV_MESSAGE (KERN_WARNING, device, "%s",
 			     "setting read-only mode ");
 	}
@@ -1547,11 +1561,9 @@
 			goto restart;
 		}
 
-		/* Dechain request from device request queue ... */
+		/* Rechain request on device device request queue */
 		cqr->endclk = get_clock();
-		list_del(&cqr->list);
-		/* ... and add it to list of final requests. */
-		list_add_tail(&cqr->list, final_queue);
+		list_move_tail(&cqr->list, final_queue);
 	}
 }
 
@@ -1580,6 +1592,10 @@
 	dasd_ccw_req_t *cqr;
 	int nr_queued;
 
+	/* No bdev, no queue. */
+	bdev = device->bdev;
+	if (!bdev)
+		return;
 	queue = device->request_queue;
 	/* No queue ? Then there is nothing to do. */
 	if (queue == NULL)
@@ -1602,9 +1618,6 @@
 		if (cqr->status == DASD_CQR_QUEUED)
 			nr_queued++;
 	}
-	bdev = bdget(kdev_t_to_nr(device->kdev));
-	if (!bdev)
-		return;
 	while (!blk_queue_plugged(queue) &&
 	       !blk_queue_empty(queue) &&
 		nr_queued < DASD_CHANQ_MAX_SIZE) {
@@ -1636,7 +1649,6 @@
 		dasd_profile_start(device, cqr, req);
 		nr_queued++;
 	}
-	bdput(bdev);
 }
 
 /*
@@ -1715,11 +1727,9 @@
 			__dasd_process_erp(device, cqr);
 			continue;
 		}
-		/* Dechain request from device request queue ... */
+		/* Rechain request on device request queue */
 		cqr->endclk = get_clock();
-		list_del(&cqr->list);
-		/* ... and add it to list of flushed requests. */
-		list_add_tail(&cqr->list, &flush_queue);
+		list_move_tail(&cqr->list, &flush_queue);
 	}
 	spin_unlock_irq(get_irq_lock(device->devinfo.irq));
 	/* Now call the callback function of flushed requests */
@@ -2186,10 +2196,10 @@
 
 struct
 block_device_operations dasd_device_operations = {
-	owner:THIS_MODULE,
-	open:dasd_open,
-	release:dasd_release,
-	ioctl:dasd_ioctl,
+	.owner=THIS_MODULE,
+	.open=dasd_open,
+	.release=dasd_release,
+	.ioctl=dasd_ioctl,
 };
 
 
diff -Nru a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
--- a/drivers/s390/block/dasd_devmap.c	Tue Jul 23 18:53:47 2002
+++ b/drivers/s390/block/dasd_devmap.c	Tue Jul 23 18:53:47 2002
@@ -449,6 +449,15 @@
 }
 
 /*
+ * Find the devmap for a device corresponding to a block_device.
+ */
+dasd_devmap_t *
+dasd_devmap_from_bdev(struct block_device *bdev)
+{
+	return dasd_devmap_from_kdev(to_kdev_t(bdev->bd_dev));
+}
+
+/*
  * Find the device structure for device number devno. If it does not
  * exists yet, allocate it. Increase the reference counter in the device
  * structure and return a pointer to it.
diff -Nru a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
--- a/drivers/s390/block/dasd_diag.c	Tue Jul 23 18:53:47 2002
+++ b/drivers/s390/block/dasd_diag.c	Tue Jul 23 18:53:47 2002
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/hdreg.h>	/* HDIO_GETGEO			    */
+#include <linux/bio.h>
 
 #include <asm/dasd.h>
 #include <asm/debug.h>
@@ -489,19 +490,19 @@
  * for one request. Give a little safety and the result is 240.
  */
 static dasd_discipline_t dasd_diag_discipline = {
-	owner:THIS_MODULE,
-	name:"DIAG",
-	ebcname:"DIAG",
-	max_blocks:240,
-	check_device:dasd_diag_check_device,
-	fill_geometry:dasd_diag_fill_geometry,
-	start_IO:dasd_start_diag,
-	examine_error:dasd_diag_examine_error,
-	erp_action:dasd_diag_erp_action,
-	erp_postaction:dasd_diag_erp_postaction,
-	build_cp:dasd_diag_build_cp,
-	dump_sense:dasd_diag_dump_sense,
-	fill_info:dasd_diag_fill_info,
+	.owner=THIS_MODULE,
+	.name="DIAG",
+	.ebcname="DIAG",
+	.max_blocks=240,
+	.check_device=dasd_diag_check_device,
+	.fill_geometry=dasd_diag_fill_geometry,
+	.start_IO=dasd_start_diag,
+	.examine_error=dasd_diag_examine_error,
+	.erp_action=dasd_diag_erp_action,
+	.erp_postaction=dasd_diag_erp_postaction,
+	.build_cp=dasd_diag_build_cp,
+	.dump_sense=dasd_diag_dump_sense,
+	.fill_info=dasd_diag_fill_info,
 };
 
 int
diff -Nru a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
--- a/drivers/s390/block/dasd_eckd.c	Tue Jul 23 18:53:47 2002
+++ b/drivers/s390/block/dasd_eckd.c	Tue Jul 23 18:53:47 2002
@@ -29,6 +29,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/hdreg.h>	/* HDIO_GETGEO			    */
+#include <linux/bio.h>
 
 #include <asm/debug.h>
 #include <asm/idals.h>
@@ -73,25 +74,25 @@
 static
 devreg_t dasd_eckd_known_devices[] = {
 	{
-		ci: { hc: { ctype: 0x3880, dtype:3390 } },
-		flag:(DEVREG_MATCH_CU_TYPE | DEVREG_MATCH_DEV_TYPE |
+		.ci = { .hc = { .ctype = 0x3880, .dtype = 3390 } },
+		.flag = (DEVREG_MATCH_CU_TYPE | DEVREG_MATCH_DEV_TYPE |
 		      DEVREG_TYPE_DEVCHARS),
-		oper_func:dasd_oper_handler
+		.oper_func = dasd_oper_handler
 	},
 	{
-		ci: { hc: { ctype:0x3990 } },
-		flag:(DEVREG_MATCH_CU_TYPE | DEVREG_TYPE_DEVCHARS),
-		oper_func:dasd_oper_handler
+		.ci = { .hc = { .ctype = 0x3990 } },
+		.flag =(DEVREG_MATCH_CU_TYPE | DEVREG_TYPE_DEVCHARS),
+		.oper_func = dasd_oper_handler
 	},
 	{
-		ci: { hc: { ctype:0x2105 } },
-		flag:(DEVREG_MATCH_CU_TYPE | DEVREG_TYPE_DEVCHARS),
-		oper_func:dasd_oper_handler
+		.ci = { .hc = { .ctype = 0x2105 } },
+		.flag = (DEVREG_MATCH_CU_TYPE | DEVREG_TYPE_DEVCHARS),
+		.oper_func = dasd_oper_handler
 	},
 	{
-		ci: { hc: { ctype:0x9343 } },
-		flag:(DEVREG_MATCH_CU_TYPE | DEVREG_TYPE_DEVCHARS),
-		oper_func:dasd_oper_handler
+		.ci = { .hc = { .ctype = 0x9343 } },
+		.flag = (DEVREG_MATCH_CU_TYPE | DEVREG_TYPE_DEVCHARS),
+		.oper_func = dasd_oper_handler
 	}
 };
 #endif
@@ -1092,7 +1093,8 @@
  * Buils a channel programm to releases a prior reserved 
  * (see dasd_eckd_reserve) device.
  */
-static int dasd_eckd_release(void *inp, int no, long args)
+static int
+dasd_eckd_release(struct block_device *bdev, int no, long args)
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
@@ -1101,7 +1103,7 @@
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-	devmap = dasd_devmap_from_kdev(((struct inode *) inp)->i_rdev);
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -1134,7 +1136,8 @@
  * 'timeout the request'. This leads to an terminate IO if 
  * the interrupt is outstanding for a certain time. 
  */
-static int dasd_eckd_reserve(void *inp, int no, long args)
+static int
+dasd_eckd_reserve(struct block_device *bdev, int no, long args)
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
@@ -1143,7 +1146,7 @@
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-	devmap = dasd_devmap_from_kdev(((struct inode *) inp)->i_rdev);
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -1168,7 +1171,7 @@
 
 	if (rc == -EIO) {
 		/* Request got an eror or has been timed out. */
-		dasd_eckd_release(inp, no, args);
+		dasd_eckd_release(bdev, no, args);
 	}
 	dasd_kfree_request(cqr, cqr->device);
 	dasd_put_device(devmap);
@@ -1180,7 +1183,8 @@
  * Buils a channel programm to break a device's reservation. 
  * (unconditional reserve)
  */
-static int dasd_eckd_steal_lock(void *inp, int no, long args)
+static int
+dasd_eckd_steal_lock(struct block_device *bdev, int no, long args)
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
@@ -1189,7 +1193,7 @@
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-	devmap = dasd_devmap_from_kdev(((struct inode *) inp)->i_rdev);
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -1213,7 +1217,7 @@
 
 	if (rc == -EIO) {
 		/* Request got an eror or has been timed out. */
-		dasd_eckd_release(inp, no, args);
+		dasd_eckd_release(bdev, no, args);
 	}
 	dasd_kfree_request(cqr, cqr->device);
 	dasd_put_device(devmap);
@@ -1223,7 +1227,8 @@
 /*
  * Read performance statistics
  */
-static int dasd_eckd_performance(void *inp, int no, long args)
+static int
+dasd_eckd_performance(struct block_device *bdev, int no, long args)
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
@@ -1233,7 +1238,7 @@
 	ccw1_t *ccw;
 	int rc;
 
-	devmap = dasd_devmap_from_kdev(((struct inode *) inp)->i_rdev);
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -1292,7 +1297,8 @@
  * Set attributes (cache operations)
  * Stores the attributes for cache operation to be used in Define Extend (DE).
  */
-static int dasd_eckd_set_attrib(void *inp, int no, long args)
+static int
+dasd_eckd_set_attrib(struct block_device *bdev, int no, long args)
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
@@ -1304,7 +1310,7 @@
 	if (!args)
 		return -EINVAL;
 
-	devmap = dasd_devmap_from_kdev(((struct inode *) inp)->i_rdev);
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -1414,22 +1420,22 @@
  * for one request. Give a little safety and the result is 240.
  */
 static dasd_discipline_t dasd_eckd_discipline = {
-	owner:THIS_MODULE,
-	name:"ECKD",
-	ebcname:"ECKD",
-	max_blocks:240,
-	check_device:dasd_eckd_check_device,
-	do_analysis:dasd_eckd_do_analysis,
-	fill_geometry:dasd_eckd_fill_geometry,
-	start_IO:dasd_start_IO,
-	term_IO:dasd_term_IO,
-	format_device:dasd_eckd_format_device,
-	examine_error:dasd_eckd_examine_error,
-	erp_action:dasd_eckd_erp_action,
-	erp_postaction:dasd_eckd_erp_postaction,
-	build_cp:dasd_eckd_build_cp,
-	dump_sense:dasd_eckd_dump_sense,
-	fill_info:dasd_eckd_fill_info,
+	.owner=THIS_MODULE,
+	.name="ECKD",
+	.ebcname="ECKD",
+	.max_blocks=240,
+	.check_device=dasd_eckd_check_device,
+	.do_analysis=dasd_eckd_do_analysis,
+	.fill_geometry=dasd_eckd_fill_geometry,
+	.start_IO=dasd_start_IO,
+	.term_IO=dasd_term_IO,
+	.format_device=dasd_eckd_format_device,
+	.examine_error=dasd_eckd_examine_error,
+	.erp_action=dasd_eckd_erp_action,
+	.erp_postaction=dasd_eckd_erp_postaction,
+	.build_cp=dasd_eckd_build_cp,
+	.dump_sense=dasd_eckd_dump_sense,
+	.fill_info=dasd_eckd_fill_info,
 };
 
 int
diff -Nru a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
--- a/drivers/s390/block/dasd_fba.c	Tue Jul 23 18:53:47 2002
+++ b/drivers/s390/block/dasd_fba.c	Tue Jul 23 18:53:47 2002
@@ -16,6 +16,7 @@
 
 #include <linux/slab.h>
 #include <linux/hdreg.h>	/* HDIO_GETGEO			    */
+#include <linux/bio.h>
 
 #include <asm/idals.h>
 #include <asm/ebcdic.h>
@@ -47,16 +48,16 @@
 static
 devreg_t dasd_fba_known_devices[] = {
 	{
-		ci: {hc: {ctype: 0x6310, dtype:0x9336}},
-		flag:(DEVREG_MATCH_CU_TYPE |
+		.ci = { .hc = { .ctype = 0x6310, .dtype = 0x9336}},
+		.flag = (DEVREG_MATCH_CU_TYPE |
 		      DEVREG_MATCH_DEV_TYPE | DEVREG_TYPE_DEVCHARS),
-		oper_func:dasd_oper_handler
+		.oper_func = dasd_oper_handler
 	},
 	{
-		ci: {hc: {ctype: 0x3880, dtype:0x3370}},
-		flag:(DEVREG_MATCH_CU_TYPE |
+		.ci = { .hc = { .ctype = 0x3880, .dtype = 0x3370}},
+		.flag = (DEVREG_MATCH_CU_TYPE |
 		      DEVREG_MATCH_DEV_TYPE | DEVREG_TYPE_DEVCHARS),
-		oper_func:dasd_oper_handler
+		.oper_func = dasd_oper_handler
 	}
 };
 #endif
@@ -393,21 +394,21 @@
  * for one request. Give a little safety and the result is 96.
  */
 static dasd_discipline_t dasd_fba_discipline = {
-	owner:THIS_MODULE,
-	name:"FBA ",
-	ebcname:"FBA ",
-	max_blocks:96,
-	check_device:dasd_fba_check_device,
-	do_analysis:dasd_fba_do_analysis,
-	fill_geometry:dasd_fba_fill_geometry,
-	start_IO:dasd_start_IO,
-	term_IO:dasd_term_IO,
-	examine_error:dasd_fba_examine_error,
-	erp_action:dasd_fba_erp_action,
-	erp_postaction:dasd_fba_erp_postaction,
-	build_cp:dasd_fba_build_cp,
-	dump_sense:dasd_fba_dump_sense,
-	fill_info:dasd_fba_fill_info,
+	.owner=THIS_MODULE,
+	.name="FBA ",
+	.ebcname="FBA ",
+	.max_blocks=96,
+	.check_device=dasd_fba_check_device,
+	.do_analysis=dasd_fba_do_analysis,
+	.fill_geometry=dasd_fba_fill_geometry,
+	.start_IO=dasd_start_IO,
+	.term_IO=dasd_term_IO,
+	.examine_error=dasd_fba_examine_error,
+	.erp_action=dasd_fba_erp_action,
+	.erp_postaction=dasd_fba_erp_postaction,
+	.build_cp=dasd_fba_build_cp,
+	.dump_sense=dasd_fba_dump_sense,
+	.fill_info=dasd_fba_fill_info,
 };
 
 int
diff -Nru a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
--- a/drivers/s390/block/dasd_genhd.c	Tue Jul 23 18:53:47 2002
+++ b/drivers/s390/block/dasd_genhd.c	Tue Jul 23 18:53:47 2002
@@ -200,13 +200,15 @@
  * Return pointer to gendisk structure by kdev.
  */
 struct gendisk *
-dasd_gendisk_from_major(int major)
+dasd_gendisk_from_bdev(struct block_device *bdev)
 {
 	struct list_head *l;
 	struct major_info *mi;
 	struct gendisk *gdp;
+	int major;
 
 	spin_lock(&dasd_major_lock);
+	major = MAJOR(bdev->bd_dev);
 	gdp = NULL;
 	list_for_each(l, &dasd_major_info) {
 		mi = list_entry(l, struct major_info, list);
@@ -322,7 +324,8 @@
 void
 dasd_setup_partitions(dasd_device_t * device)
 {
-	grok_partitions(device->kdev, device->blocks << device->s2b_shift);
+	grok_partitions(to_kdev_t(device->bdev->bd_dev),
+			device->blocks << device->s2b_shift);
 }
 
 /*
@@ -335,14 +338,14 @@
 	struct gendisk *gdp;
 	int minor, i;
 
-	gdp = dasd_gendisk_from_major(major(device->kdev));
+	gdp = dasd_gendisk_from_bdev(device->bdev);
 	if (gdp == NULL)
 		return;
 
-	wipe_partitions(device->kdev);
+	wipe_partitions(to_kdev_t(device->bdev->bd_dev));
 
 	/* FIXME: do we really need that */
-	minor = minor(device->kdev);
+	minor = MINOR(device->bdev->bd_dev);
 	for (i = 0; i < (1 << DASD_PARTN_BITS); i++)
 		gdp->sizes[minor + i] = 0;
 
@@ -351,7 +354,7 @@
 	 * but the 1 as third parameter makes it do an unregister...
 	 * FIXME: there must be a better way to get rid of the devfs entries
 	 */
-	devfs_register_partitions(gdp, minor(device->kdev), 1);
+	devfs_register_partitions(gdp, minor, 1);
 }
 
 extern int (*genhd_dasd_name)(char *, int, int, struct gendisk *);
diff -Nru a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
--- a/drivers/s390/block/dasd_int.h	Tue Jul 23 18:53:47 2002
+++ b/drivers/s390/block/dasd_int.h	Tue Jul 23 18:53:47 2002
@@ -69,7 +69,9 @@
 /*
  * SECTION: Type definitions
  */
-typedef int (*dasd_ioctl_fn_t) (void *inp, int no, long args);
+struct dasd_device_t;
+
+typedef int (*dasd_ioctl_fn_t) (struct block_device *bdev, int no, long args);
 
 typedef struct {
 	struct list_head list;
@@ -139,9 +141,8 @@
 /* messages to be written via klogd and dbf */
 #define DEV_MESSAGE(d_loglevel,d_device,d_string,d_args...)\
 do { \
-	printk(d_loglevel PRINTK_HEADER " /dev/%-7s(%3d:%3d),%04x@%02x: " \
-	       d_string "\n", d_device->name, \
-	       major(d_device->kdev), minor(d_device->kdev), \
+	printk(d_loglevel PRINTK_HEADER " %s,%04x@%02x: " \
+	       d_string "\n", bdevname(d_device->bdev), \
 	       d_device->devinfo.devno, d_device->devinfo.irq, \
 	       d_args); \
 	DBF_DEV_EVENT(DBF_ALERT, d_device, d_string, d_args); \
@@ -153,8 +154,6 @@
 	DBF_EVENT(DBF_ALERT, d_string, d_args); \
 } while(0)
 
-struct dasd_device_t;
-
 typedef struct dasd_ccw_req_t {
 	unsigned int magic;		/* Eye catcher */
         struct list_head list;		/* list_head for request queueing. */
@@ -262,7 +261,7 @@
 typedef struct dasd_device_t {
 	/* Block device stuff. */
 	char name[16];			/* The device name in /dev. */
-	kdev_t kdev;
+	struct block_device *bdev;
 	devfs_handle_t devfs_entry;
 	request_queue_t *request_queue;
 	spinlock_t request_queue_lock;
@@ -467,6 +466,7 @@
 dasd_devmap_t *dasd_devmap_from_devindex(int);
 dasd_devmap_t *dasd_devmap_from_irq(int);
 dasd_devmap_t *dasd_devmap_from_kdev(kdev_t);
+dasd_devmap_t *dasd_devmap_from_bdev(struct block_device *bdev);
 dasd_device_t *dasd_get_device(dasd_devmap_t *);
 void dasd_put_device(dasd_devmap_t *);
 
@@ -480,7 +480,7 @@
 void dasd_gendisk_exit(void);
 int  dasd_gendisk_new_major(void);
 int  dasd_gendisk_major_index(int);
-struct gendisk *dasd_gendisk_from_major(int);
+struct gendisk *dasd_gendisk_from_bdev(struct block_device *bdev);
 struct gendisk *dasd_gendisk_from_devindex(int);
 int  dasd_device_name(char *, int, int, struct gendisk *);
 void dasd_setup_partitions(dasd_device_t *);
diff -Nru a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
--- a/drivers/s390/block/dasd_ioctl.c	Tue Jul 23 18:53:47 2002
+++ b/drivers/s390/block/dasd_ioctl.c	Tue Jul 23 18:53:47 2002
@@ -91,6 +91,7 @@
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
 	dasd_ioctl_list_t *ioctl;
+	struct block_device *bdev;
 	struct list_head *l;
 	const char *dir;
 	int rc;
@@ -101,13 +102,17 @@
 		PRINT_DEBUG("empty data ptr");
 		return -EINVAL;
 	}
-	devmap = dasd_devmap_from_kdev(inp->i_rdev);
+	bdev = bdget(kdev_t_to_nr(inp->i_rdev));
+	if (!bdev)
+		return -EINVAL;
+
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device)) {
 		MESSAGE(KERN_WARNING,
-			"No device registered as device (%d:%d)",
-			major(inp->i_rdev), minor(inp->i_rdev));
+			"No device registered as device %s", bdevname(bdev));
+		bdput(bdev);
 		return -EINVAL;
 	}
 	dir = _IOC_DIR (no) == _IOC_NONE ? "0" :
@@ -125,11 +130,12 @@
 			if (ioctl->owner) {
 				if (try_inc_mod_count(ioctl->owner) != 0)
 					continue;
-				rc = ioctl->handler(inp, no, data);
+				rc = ioctl->handler(bdev, no, data);
 				__MOD_DEC_USE_COUNT(ioctl->owner);
 			} else
-				rc = ioctl->handler(inp, no, data);
+				rc = ioctl->handler(bdev, no, data);
 			dasd_put_device(devmap);
+			bdput(bdev);
 			return rc;
 		}
 	}
@@ -138,10 +144,12 @@
 		      "unknown ioctl 0x%08x=%s'0x%x'%d(%d) data %8lx", no,
 		      dir, _IOC_TYPE(no), _IOC_NR(no), _IOC_SIZE(no), data);
 	dasd_put_device(devmap);
+	bdput(bdev);
 	return -ENOTTY;
 }
 
-static int dasd_ioctl_api_version(void *inp, int no, long args)
+static int
+dasd_ioctl_api_version(struct block_device *bdev, int no, long args)
 {
 	int ver = DASD_API_VERSION;
 	return put_user(ver, (int *) args);
@@ -150,7 +158,8 @@
 /*
  * Enable device.
  */
-static int dasd_ioctl_enable(void *inp, int no, long args)
+static int
+dasd_ioctl_enable(struct block_device *bdev, int no, long args)
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
@@ -158,7 +167,7 @@
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-	devmap = dasd_devmap_from_kdev(((struct inode *) inp)->i_rdev);
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -172,14 +181,15 @@
 /*
  * Disable device.
  */
-static int dasd_ioctl_disable(void *inp, int no, long args)
+static int
+dasd_ioctl_disable(struct block_device *bdev, int no, long args)
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-	devmap = dasd_devmap_from_kdev(((struct inode *) inp)->i_rdev);
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -245,7 +255,8 @@
 /*
  * Format device.
  */
-static int dasd_ioctl_format(void *inp, int no, long args)
+static int
+dasd_ioctl_format(struct block_device *bdev, int no, long args)
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
@@ -257,8 +268,8 @@
 	if (!args)
 		return -EINVAL;
 	/* fdata == NULL is no longer a valid arg to dasd_format ! */
-	partn = minor(((struct inode *) inp)->i_rdev) & DASD_PARTN_MASK;
-	devmap = dasd_devmap_from_kdev(((struct inode *) inp)->i_rdev);
+	partn = MINOR(bdev->bd_dev) & DASD_PARTN_MASK;
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -283,14 +294,15 @@
 /*
  * Reset device profile information
  */
-static int dasd_ioctl_reset_profile(void *inp, int no, long args)
+static int
+dasd_ioctl_reset_profile(struct block_device *bdev, int no, long args)
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-	devmap = dasd_devmap_from_kdev(((struct inode *) inp)->i_rdev);
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -303,13 +315,14 @@
 /*
  * Return device profile information
  */
-static int dasd_ioctl_read_profile(void *inp, int no, long args)
+static int
+dasd_ioctl_read_profile(struct block_device *bdev, int no, long args)
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
 	int rc;
 
-	devmap = dasd_devmap_from_kdev(((struct inode *) inp)->i_rdev);
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -322,12 +335,14 @@
 	return rc;
 }
 #else
-static int dasd_ioctl_reset_profile(void *inp, int no, long args)
+static int
+dasd_ioctl_reset_profile(struct block_device *bdev, int no, long args)
 {
 	return -ENOSYS;
 }
 
-static int dasd_ioctl_read_profile(void *inp, int no, long args)
+static int
+dasd_ioctl_read_profile(struct block_device *bdev, int no, long args)
 {
 	return -ENOSYS;
 }
@@ -336,15 +351,16 @@
 /*
  * Return dasd information. Used for BIODASDINFO and BIODASDINFO2.
  */
-static int dasd_ioctl_information(void *inp, int no, long args)
+static int
+dasd_ioctl_information(struct block_device *bdev, int no, long args)
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
-	dasd_information2_t dasd_info;
+	dasd_information2_t *dasd_info;
 	unsigned long flags;
 	int rc;
 
-	devmap = dasd_devmap_from_kdev(((struct inode *) inp)->i_rdev);
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -354,20 +370,26 @@
 		return -EINVAL;
 	}
 
-	rc = device->discipline->fill_info(device, &dasd_info);
+	dasd_info = kmalloc(sizeof(dasd_information2_t), GFP_KERNEL);
+	if (dasd_info == NULL) {
+		dasd_put_device(devmap);
+		return -ENOMEM;
+	}
+	rc = device->discipline->fill_info(device, dasd_info);
 	if (rc) {
 		dasd_put_device(devmap);
+		kfree(dasd_info);
 		return rc;
 	}
 
-	dasd_info.devno = device->devinfo.devno;
-	dasd_info.schid = device->devinfo.irq;
-	dasd_info.cu_type = device->devinfo.sid_data.cu_type;
-	dasd_info.cu_model = device->devinfo.sid_data.cu_model;
-	dasd_info.dev_type = device->devinfo.sid_data.dev_type;
-	dasd_info.dev_model = device->devinfo.sid_data.dev_model;
-	dasd_info.open_count = atomic_read(&device->open_count);
-	dasd_info.status = device->state;
+	dasd_info->devno = device->devinfo.devno;
+	dasd_info->schid = device->devinfo.irq;
+	dasd_info->cu_type = device->devinfo.sid_data.cu_type;
+	dasd_info->cu_model = device->devinfo.sid_data.cu_model;
+	dasd_info->dev_type = device->devinfo.sid_data.dev_type;
+	dasd_info->dev_model = device->devinfo.sid_data.dev_model;
+	dasd_info->open_count = atomic_read(&device->open_count);
+	dasd_info->status = device->state;
 	
 	/*
 	 * check if device is really formatted
@@ -375,16 +397,16 @@
 	 */
 	if ((device->state < DASD_STATE_READY) ||
 	    (dasd_check_blocksize(device->bp_block)))
-		dasd_info.format = DASD_FORMAT_NONE;
+		dasd_info->format = DASD_FORMAT_NONE;
 	
-	dasd_info.features = devmap->features;
+	dasd_info->features = devmap->features;
 	
 	if (device->discipline)
-		memcpy(dasd_info.type, device->discipline->name, 4);
+		memcpy(dasd_info->type, device->discipline->name, 4);
 	else
-		memcpy(dasd_info.type, "none", 4);
-	dasd_info.req_queue_len = 0;
-	dasd_info.chanq_len = 0;
+		memcpy(dasd_info->type, "none", 4);
+	dasd_info->req_queue_len = 0;
+	dasd_info->chanq_len = 0;
 	if (device->request_queue->request_fn) {
 		struct list_head *l;
 #ifdef DASD_EXTENDED_PROFILING
@@ -392,45 +414,46 @@
 			struct list_head *l;
 			spin_lock_irqsave(&device->lock, flags);
 			list_for_each(l, &device->request_queue->queue_head)
-				dasd_info.req_queue_len++;
+				dasd_info->req_queue_len++;
 			spin_unlock_irqrestore(&device->lock, flags);
 		}
 #endif				/* DASD_EXTENDED_PROFILING */
 		spin_lock_irqsave(get_irq_lock(device->devinfo.irq), flags);
 		list_for_each(l, &device->ccw_queue)
-			dasd_info.chanq_len++;
+			dasd_info->chanq_len++;
 		spin_unlock_irqrestore(get_irq_lock(device->devinfo.irq),
 				       flags);
 	}
 	
 	rc = 0;
-	if (copy_to_user((long *) args, (long *) &dasd_info,
+	if (copy_to_user((long *) args, (long *) dasd_info,
 			 ((no == (unsigned int) BIODASDINFO2) ?
 			  sizeof (dasd_information2_t) :
 			  sizeof (dasd_information_t))))
 		rc = -EFAULT;
 	dasd_put_device(devmap);
+	kfree(dasd_info);
 	return rc;
 }
 
 /*
  * Set read only
  */
-static int dasd_ioctl_set_ro(void *inp, int no, long args)
+static int
+dasd_ioctl_set_ro(struct block_device *bdev, int no, long args)
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
-	int major, minor;
 	int intval, i;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-	if (minor(((struct inode *) inp)->i_rdev) & DASD_PARTN_MASK)
+	if (MINOR(bdev->bd_dev) & DASD_PARTN_MASK)
 		// ro setting is not allowed for partitions
 		return -EINVAL;
 	if (get_user(intval, (int *) args))
 		return -EFAULT;
-	devmap = dasd_devmap_from_kdev(((struct inode *) inp)->i_rdev);
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -439,10 +462,8 @@
 		devmap->features |= DASD_FEATURE_READONLY;
 	else
 		devmap->features &= ~DASD_FEATURE_READONLY;
-	major = major(device->kdev);
-	minor = minor(device->kdev);
 	for (i = 0; i < (1 << DASD_PARTN_BITS); i++)
-		set_device_ro(mk_kdev(major, minor + i), intval);
+		set_device_ro(to_kdev_t(bdev->bd_dev + i), intval);
 	dasd_put_device(devmap);
 	return 0;
 }
@@ -450,41 +471,40 @@
 /*
  * Return device size in number of sectors.
  */
-static int dasd_ioctl_blkgetsize(void *inp, int no, long args)
+static int
+dasd_ioctl_blkgetsize(struct block_device *bdev, int no, long args)
 {
 	struct gendisk *gdp;
-	kdev_t kdev;
 	long blocks;
 
-	kdev = ((struct inode *) inp)->i_rdev;
-	gdp = dasd_gendisk_from_major(major(kdev));
+	gdp = dasd_gendisk_from_bdev(bdev);
 	if (gdp == NULL)
 		return -EINVAL;
-	blocks = gdp->sizes[minor(kdev)] << 1;
+	blocks = gdp->sizes[MINOR(bdev->bd_dev)] << 1;
 	return put_user(blocks, (long *) args);
 }
 
 /*
  * Return device size in number of sectors, 64bit version.
  */
-static int dasd_ioctl_blkgetsize64(void *inp, int no, long args)
+static int
+dasd_ioctl_blkgetsize64(struct block_device *bdev, int no, long args)
 {
 	struct gendisk *gdp;
-	kdev_t kdev;
 	u64 blocks;
 
-	kdev = ((struct inode *) inp)->i_rdev;
-	gdp = dasd_gendisk_from_major(major(kdev));
+	gdp = dasd_gendisk_from_bdev(bdev);
 	if (gdp == NULL)
 		return -EINVAL;
-	blocks = gdp->sizes[minor(kdev)] << 1;
+	blocks = gdp->sizes[MINOR(bdev->bd_dev)] << 1;
 	return put_user(blocks << 10, (u64 *) args);
 }
 
 /*
  * Reread partition table.
  */
-static int dasd_ioctl_rr_partition(void *inp, int no, long args)
+static int
+dasd_ioctl_rr_partition(struct block_device *bdev, int no, long args)
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
@@ -492,7 +512,7 @@
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
-	devmap = dasd_devmap_from_kdev(((struct inode *) inp)->i_rdev);
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -509,16 +529,15 @@
 /*
  * Return disk geometry.
  */
-static int dasd_ioctl_getgeo(void *inp, int no, long args)
+static int
+dasd_ioctl_getgeo(struct block_device *bdev, int no, long args)
 {
 	struct hd_geometry geo = { 0, };
-	struct inode *inode = inp;
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
-	kdev_t kdev = inode->i_rdev;
 	int rc;
 
-	devmap = dasd_devmap_from_kdev(kdev);
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -527,7 +546,7 @@
 	if (device != NULL && device->discipline != NULL &&
 	    device->discipline->fill_geometry != NULL) {
 		device->discipline->fill_geometry(device, &geo);
-		geo.start = get_start_sect(inode->i_bdev);
+		geo.start = get_start_sect(bdev);
 		if (copy_to_user((struct hd_geometry *) args, &geo,
 				 sizeof (struct hd_geometry)))
 			rc = -EFAULT;
diff -Nru a/drivers/s390/block/dasd_proc.c b/drivers/s390/block/dasd_proc.c
--- a/drivers/s390/block/dasd_proc.c	Tue Jul 23 18:53:47 2002
+++ b/drivers/s390/block/dasd_proc.c	Tue Jul 23 18:53:47 2002
@@ -15,6 +15,7 @@
 #include <linux/config.h>
 #include <linux/version.h>
 #include <linux/ctype.h>
+#include <linux/vmalloc.h>
 
 #include <asm/debug.h>
 #include <asm/irq.h>
@@ -274,10 +275,10 @@
 }
 
 static struct file_operations dasd_devices_file_ops = {
-	read:dasd_generic_read,		/* read */
-	write:dasd_devices_write,	/* write */
-	open:dasd_devices_open,		/* open */
-	release:dasd_generic_close,	/* close */
+	.read    = dasd_generic_read,
+	.write   = dasd_devices_write,
+	.open    = dasd_devices_open,
+	.release = dasd_generic_close,
 };
 
 static struct inode_operations dasd_devices_inode_ops = {
@@ -430,10 +431,10 @@
 }
 
 static struct file_operations dasd_statistics_file_ops = {
-	read:	dasd_generic_read,	/* read */
-	write:	dasd_statistics_write,	/* write */
-	open:	dasd_statistics_open,	/* open */
-	release:dasd_generic_close,	/* close */
+	.read    = dasd_generic_read,
+	.write   = dasd_statistics_write,
+	.open    = dasd_statistics_open,
+	.release = dasd_generic_close,
 };
 
