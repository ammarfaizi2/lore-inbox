Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262930AbSJGLUW>; Mon, 7 Oct 2002 07:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262985AbSJGLUW>; Mon, 7 Oct 2002 07:20:22 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:4272 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S262930AbSJGLUS> convert rfc822-to-8bit; Mon, 7 Oct 2002 07:20:18 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: viro@math.psu.edu
Subject: Re: [PATCH] 2.5.40 s390.
Date: Mon, 7 Oct 2002 13:23:57 +0200
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210071323.57791.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,
> > * please switch to use of alloc_disk()/put_disk()
> > * don't bother with disk->part allocation - it's done by add_disk()
> > * ditto for freeing it (del_gendisk())
> > * dasd_partition_to_kdev_t() - please use ->gdp->{major,first_minor}
> > * s/bdevname(d_device->bdev)/d_device->gdp->disk_name/
> > * lose ->bdev
> I'll do that.

Done.

blue skies,
   Martin

ChangeLog:

Get rid of name and bdev in dasd_device_t structure.

diff -urN linux-2.5/drivers/s390/block/dasd.c linux-2.5-s390/drivers/s390/block/dasd.c
--- linux-2.5/drivers/s390/block/dasd.c	Mon Oct  7 11:21:49 2002
+++ linux-2.5-s390/drivers/s390/block/dasd.c	Mon Oct  7 11:13:48 2002
@@ -236,7 +236,7 @@
 	}
 
 	/* Allocate gendisk structure for device. */
-	gdp = dasd_gendisk_alloc(device->name, devmap->devindex);
+	gdp = dasd_gendisk_alloc(devmap->devindex);
 	if (IS_ERR(gdp)) {
 		free_page((unsigned long) device->erp_mem);
 		free_pages((unsigned long) device->ccw_mem, 1);
@@ -294,10 +294,6 @@
 		return -ENODEV;
 	minor = devmap->devindex % DASD_PER_MAJOR;
 
-	/* Set bdev and the device name. */
-	device->bdev = bdget(MKDEV(major, minor << DASD_PARTN_BITS));
-	strcpy(device->name, device->gdp->disk_name);
-
 	/* Find a discipline for the device. */
 	rc = dasd_find_disc(device);
 	if (rc)
@@ -341,8 +337,8 @@
 	device->state = DASD_STATE_NEW;
 
 	/* Forget the block device */
-	bdev = device->bdev;
-	device->bdev = NULL;
+	bdev = bdget(MKDEV(device->gdp->major, device->gdp->first_minor));
+	bdput(bdev);
 	bdput(bdev);
 }
 
@@ -355,7 +351,7 @@
 	int rc;
 
 	/* register 'device' debug area, used for all DBF_DEV_XXX calls */
-	device->debug_area = debug_register(device->name, 0, 2,
+	device->debug_area = debug_register(device->gdp->disk_name, 0, 2,
 					    8 * sizeof (long));
 	debug_register_view(device->debug_area, &debug_sprintf_view);
 	debug_set_level(device->debug_area, DBF_ERR);
@@ -436,7 +432,7 @@
 static inline kdev_t
 dasd_partition_to_kdev_t(dasd_device_t *device, unsigned int partition)
 {
-	return to_kdev_t(device->bdev->bd_dev+partition);
+	return mk_kdev(device->gdp->major, device->gdp->first_minor+partition);
 }
 
 
@@ -453,6 +449,7 @@
 	if (devmap->features & DASD_FEATURE_READONLY) {
 		for (i = 0; i < (1 << DASD_PARTN_BITS); i++)
 			set_device_ro(dasd_partition_to_kdev_t(device, i), 1);
+		device->ro_flag = 1;
 		DEV_MESSAGE (KERN_WARNING, device, "%s",
 			     "setting read-only mode ");
 	}
@@ -1582,17 +1579,12 @@
 static inline void
 __dasd_process_blk_queue(dasd_device_t * device)
 {
-	struct block_device *bdev;
 	request_queue_t *queue;
 	struct list_head *l;
 	struct request *req;
 	dasd_ccw_req_t *cqr;
 	int nr_queued;
 
-	/* No bdev, no queue. */
-	bdev = device->bdev;
-	if (!bdev)
-		return;
 	queue = device->request_queue;
 	/* No queue ? Then there is nothing to do. */
 	if (queue == NULL)
@@ -1619,7 +1611,7 @@
 	       !blk_queue_empty(queue) &&
 		nr_queued < DASD_CHANQ_MAX_SIZE) {
 		req = elv_next_request(queue);
-		if (bdev_read_only(bdev) && rq_data_dir(req) == WRITE) {
+		if (device->ro_flag && rq_data_dir(req) == WRITE) {
 			DBF_EVENT(DBF_ERR,
 				  "(%04x) Rejecting write request %p",
 				  device->devinfo.devno, req);
diff -urN linux-2.5/drivers/s390/block/dasd_genhd.c linux-2.5-s390/drivers/s390/block/dasd_genhd.c
--- linux-2.5/drivers/s390/block/dasd_genhd.c	Mon Oct  7 11:21:49 2002
+++ linux-2.5-s390/drivers/s390/block/dasd_genhd.c	Mon Oct  7 11:13:48 2002
@@ -162,7 +162,7 @@
  * Allocate gendisk structure for devindex.
  */
 struct gendisk *
-dasd_gendisk_alloc(char *device_name, int devindex)
+dasd_gendisk_alloc(int devindex)
 {
 	struct list_head *l;
 	struct major_info *mi;
@@ -195,7 +195,7 @@
 		return ERR_PTR(-ENOMEM);
 
 	/* Initialize gendisk structure. */
-	memcpy(gdp->disk_name, device_name, 16);	/* huh? -- AV */
+	memset(gdp, 0, sizeof(struct gendisk));
 	gdp->major = mi->major;
 	gdp->first_minor = index << DASD_PARTN_BITS;
 	gdp->minor_shift = DASD_PARTN_BITS;
@@ -207,15 +207,16 @@
 	 *   dasdaa - dasdzz : 676 devices, added up = 702
 	 *   dasdaaa - dasdzzz : 17576 devices, added up = 18278
 	 */
-	len = sprintf(device_name, "dasd");
+	len = sprintf(gdp->disk_name, "dasd");
 	if (devindex > 25) {
 		if (devindex > 701)
-			len += sprintf(device_name + len, "%c",
+			len += sprintf(gdp->disk_name + len, "%c",
 				       'a' + (((devindex - 702) / 676) % 26));
-		len += sprintf(device_name + len, "%c",
+		len += sprintf(gdp->disk_name + len, "%c",
 			       'a' + (((devindex - 26) / 26) % 26));
 	}
-	len += sprintf(device_name + len, "%c", 'a' + (devindex % 26));
+	len += sprintf(gdp->disk_name + len, "%c", 'a' + (devindex % 26));
+
 	return gdp;
 }
 
diff -urN linux-2.5/drivers/s390/block/dasd_int.h linux-2.5-s390/drivers/s390/block/dasd_int.h
--- linux-2.5/drivers/s390/block/dasd_int.h	Mon Oct  7 11:21:49 2002
+++ linux-2.5-s390/drivers/s390/block/dasd_int.h	Mon Oct  7 11:13:48 2002
@@ -140,7 +140,7 @@
 #define DEV_MESSAGE(d_loglevel,d_device,d_string,d_args...)\
 do { \
 	printk(d_loglevel PRINTK_HEADER " %s,%04x@%02x: " \
-	       d_string "\n", bdevname(d_device->bdev), \
+	       d_string "\n", d_device->gdp->disk_name, \
 	       d_device->devinfo.devno, d_device->devinfo.irq, \
 	       d_args); \
 	DBF_DEV_EVENT(DBF_ALERT, d_device, d_string, d_args); \
@@ -258,8 +258,6 @@
 
 typedef struct dasd_device_t {
 	/* Block device stuff. */
-	char name[16];			/* The device name in /dev. */
-	struct block_device *bdev;
 	struct gendisk *gdp;
 	devfs_handle_t devfs_entry;
 	request_queue_t *request_queue;
@@ -267,6 +265,7 @@
 	unsigned long blocks;		/* size of volume in blocks */
 	unsigned int bp_block;		/* bytes per block */
 	unsigned int s2b_shift;		/* log2 (bp_block/512) */
+	int ro_flag;			/* read-only flag */
 
 	/* Device discipline stuff. */
 	dasd_discipline_t *discipline;
@@ -479,7 +478,7 @@
 void dasd_gendisk_exit(void);
 int  dasd_gendisk_major_index(int);
 int  dasd_gendisk_index_major(int);
-struct gendisk *dasd_gendisk_alloc(char *, int);
+struct gendisk *dasd_gendisk_alloc(int);
 void dasd_setup_partitions(dasd_device_t *);
 void dasd_destroy_partitions(dasd_device_t *);
 
diff -urN linux-2.5/drivers/s390/block/dasd_ioctl.c linux-2.5-s390/drivers/s390/block/dasd_ioctl.c
--- linux-2.5/drivers/s390/block/dasd_ioctl.c	Mon Oct  7 11:21:34 2002
+++ linux-2.5-s390/drivers/s390/block/dasd_ioctl.c	Mon Oct  7 11:13:48 2002
@@ -464,6 +464,7 @@
 		devmap->features &= ~DASD_FEATURE_READONLY;
 	for (i = 0; i < (1 << DASD_PARTN_BITS); i++)
 		set_device_ro(to_kdev_t(bdev->bd_dev + i), intval);
+	device->ro_flag = intval;
 	dasd_put_device(devmap);
 	return 0;
 }
diff -urN linux-2.5/drivers/s390/block/dasd_proc.c linux-2.5-s390/drivers/s390/block/dasd_proc.c
--- linux-2.5/drivers/s390/block/dasd_proc.c	Mon Oct  7 11:21:34 2002
+++ linux-2.5-s390/drivers/s390/block/dasd_proc.c	Mon Oct  7 11:13:48 2002
@@ -154,7 +154,6 @@
 {
 	dasd_device_t *device;
 	char *substr;
-	int major, minor;
 	int len;
 
 	device = dasd_get_device(devmap);
@@ -168,11 +167,10 @@
 	else
 		len += sprintf(str + len, "(none)");
 	/* Print kdev. */
-	major = MAJOR(device->bdev->bd_dev);
-	minor = MINOR(device->bdev->bd_dev);
-	len += sprintf(str + len, " at (%3d:%3d)", major, minor);
+	len += sprintf(str + len, " at (%3d:%3d)",
+		       device->gdp->major, device->gdp->first_minor);
 	/* Print device name. */
-	len += sprintf(str + len, " is %-7s", device->name);
+	len += sprintf(str + len, " is %-7s", device->gdp->disk_name);
 	/* Print devices features. */
 	substr = (devmap->features & DASD_FEATURE_READONLY) ? "(ro)" : " ";
 	len += sprintf(str + len, "%4s: ", substr);

