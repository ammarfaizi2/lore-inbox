Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319206AbSIKQPk>; Wed, 11 Sep 2002 12:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319173AbSIKQPY>; Wed, 11 Sep 2002 12:15:24 -0400
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:17581 "EHLO
	d06lmsgate-4.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S319206AbSIKQHA> convert rfc822-to-8bit; Wed, 11 Sep 2002 12:07:00 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.34 s390 fixes (5/10): dasd driver.
Date: Wed, 11 Sep 2002 18:08:36 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209111802.28920.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
another patch for the dasd driver. I picked up all of Al Viros improvements
to the dasd driver and then made the dasd gendisk stuff even simpler.
The second important change is to replace kdev_t by a bdev pointer where
possible.

blue skies,
  Martin.

diff -urN linux-2.5.34/drivers/s390/block/dasd.c linux-2.5.34-s390/drivers/s390/block/dasd.c
--- linux-2.5.34/drivers/s390/block/dasd.c	Mon Sep  9 19:35:11 2002
+++ linux-2.5.34-s390/drivers/s390/block/dasd.c	Tue Sep 10 17:30:32 2002
@@ -203,20 +203,24 @@
 dasd_alloc_device(dasd_devmap_t *devmap)
 {
 	dasd_device_t *device;
+	struct gendisk *gdp;
 	int rc;
 
-	/* Make sure the gendisk structure for this device exists. */
-	while (dasd_gendisk_from_devindex(devmap->devindex) == NULL) {
-		rc = dasd_gendisk_new_major();
-		if (rc)
-			return ERR_PTR(rc);
-	}
-
 	device = kmalloc(sizeof (dasd_device_t), GFP_ATOMIC);
 	if (device == NULL)
 		return ERR_PTR(-ENOMEM);
 	memset(device, 0, sizeof (dasd_device_t));
 
+	/* Get devinfo from the common io layer. */
+	rc = get_dev_info_by_devno(devmap->devno, &device->devinfo);
+	if (rc) {
+		kfree(device);
+		return ERR_PTR(rc);
+	}
+	DBF_EVENT(DBF_NOTICE, "got devinfo CU-type %04x and dev-type %04x",
+		  device->devinfo.sid_data.cu_type,
+		  device->devinfo.sid_data.dev_type);
+
 	/* Get two pages for normal block device operations. */
 	device->ccw_mem = (void *) __get_free_pages(GFP_ATOMIC | GFP_DMA, 1);
 	if (device->ccw_mem == NULL) {
@@ -231,17 +235,15 @@
 		return ERR_PTR(-ENOMEM);
 	}
 
-	/* Get devinfo from the common io layer. */
-	rc = get_dev_info_by_devno(devmap->devno, &device->devinfo);
-	if (rc) {
- 		free_page((unsigned long) device->erp_mem);
+	/* Allocate gendisk structure for device. */
+	gdp = dasd_gendisk_alloc(device->name, devmap->devindex);
+	if (IS_ERR(gdp)) {
+		free_page((unsigned long) device->erp_mem);
 		free_pages((unsigned long) device->ccw_mem, 1);
 		kfree(device);
-		return ERR_PTR(rc);
+		return (dasd_device_t *) gdp;
 	}
-	DBF_EVENT(DBF_NOTICE, "got devinfo CU-type %04x and dev-type %04x",
-		  device->devinfo.sid_data.cu_type,
-		  device->devinfo.sid_data.dev_type);
+	device->gdp = gdp;
 
 	dasd_init_chunklist(&device->ccw_chunks, device->ccw_mem, PAGE_SIZE*2);
 	dasd_init_chunklist(&device->erp_chunks, device->erp_mem, PAGE_SIZE);
@@ -268,6 +270,7 @@
 		kfree(device->private);
 	free_page((unsigned long) device->erp_mem);
 	free_pages((unsigned long) device->ccw_mem, 1);
+	dasd_gendisk_free(device->gdp);
 	kfree(device);
 }
 
@@ -278,21 +281,22 @@
 dasd_state_new_to_known(dasd_device_t *device)
 {
 	char buffer[5];
-	struct gendisk *gdp;
 	dasd_devmap_t *devmap;
 	umode_t devfs_perm;
 	devfs_handle_t dir;
-	int minor, rc;
+	int major, minor, rc;
 
 	devmap = dasd_devmap_from_devno(device->devinfo.devno);
 	if (devmap == NULL)
 		return -ENODEV;
-	gdp = dasd_gendisk_from_devindex(devmap->devindex);
-	if (gdp == NULL)
+	major = dasd_gendisk_index_major(devmap->devindex);
+	if (major < 0)
 		return -ENODEV;
-	/* Set kdev and the device name. */
-	device->kdev = mk_kdev(gdp->major, gdp->first_minor);
-	strcpy(device->name, gdp->major_name);
+	minor = devmap->devindex % DASD_PER_MAJOR;
+
+	/* Set bdev and the device name. */
+	device->bdev = bdget(MKDEV(major, minor << DASD_PARTN_BITS));
+	strcpy(device->name, device->gdp->major_name);
 
 	/* Find a discipline for the device. */
 	rc = dasd_find_disc(device);
@@ -302,14 +306,13 @@
 	/* Add a proc directory and the dasd device entry to devfs. */
 	sprintf(buffer, "%04x", device->devinfo.devno);
 	dir = devfs_mk_dir(dasd_devfs_handle, buffer, device);
-	gdp->de = dir;
+	device->gdp->de = dir;
 	if (devmap->features & DASD_FEATURE_READONLY)
 		devfs_perm = S_IFBLK | S_IRUSR;
 	else
 		devfs_perm = S_IFBLK | S_IRUSR | S_IWUSR;
 	device->devfs_entry = devfs_register(dir, "device", DEVFS_FL_DEFAULT,
-					     major(device->kdev),
-					     minor(device->kdev),
+					     major, minor << DASD_PARTN_BITS,
 					     devfs_perm,
 					     &dasd_device_operations, NULL);
 	device->state = DASD_STATE_KNOWN;
@@ -322,17 +325,25 @@
 static inline void
 dasd_state_known_to_new(dasd_device_t * device)
 {
-	dasd_devmap_t *devmap = dasd_devmap_from_devno(device->devinfo.devno);
-	struct gendisk *gdp = dasd_gendisk_from_devindex(devmap->devindex);
-	if (gdp == NULL)
-		return;
+	dasd_devmap_t *devmap;
+	struct block_device *bdev;
+	int minor;
+
+	devmap = dasd_devmap_from_devno(device->devinfo.devno);
+	minor = devmap->devindex % DASD_PER_MAJOR;
+
 	/* Remove device entry and devfs directory. */
 	devfs_unregister(device->devfs_entry);
-	devfs_unregister(gdp->de);
+	devfs_unregister(device->gdp->de);
 
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
@@ -419,21 +430,29 @@
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
@@ -1539,11 +1558,9 @@
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
 
@@ -1572,6 +1589,10 @@
 	dasd_ccw_req_t *cqr;
 	int nr_queued;
 
+	/* No bdev, no queue. */
+	bdev = device->bdev;
+	if (!bdev)
+		return;
 	queue = device->request_queue;
 	/* No queue ? Then there is nothing to do. */
 	if (queue == NULL)
@@ -1594,9 +1615,6 @@
 		if (cqr->status == DASD_CQR_QUEUED)
 			nr_queued++;
 	}
-	bdev = bdget(kdev_t_to_nr(device->kdev));
-	if (!bdev)
-		return;
 	while (!blk_queue_plugged(queue) &&
 	       !blk_queue_empty(queue) &&
 		nr_queued < DASD_CHANQ_MAX_SIZE) {
@@ -1628,7 +1646,6 @@
 		dasd_profile_start(device, cqr, req);
 		nr_queued++;
 	}
-	bdput(bdev);
 }
 
 /*
@@ -1707,11 +1724,9 @@
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
diff -urN linux-2.5.34/drivers/s390/block/dasd_devmap.c linux-2.5.34-s390/drivers/s390/block/dasd_devmap.c
--- linux-2.5.34/drivers/s390/block/dasd_devmap.c	Mon Sep  9 19:35:12 2002
+++ linux-2.5.34-s390/drivers/s390/block/dasd_devmap.c	Tue Sep 10 17:30:32 2002
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
diff -urN linux-2.5.34/drivers/s390/block/dasd_diag.c linux-2.5.34-s390/drivers/s390/block/dasd_diag.c
--- linux-2.5.34/drivers/s390/block/dasd_diag.c	Mon Sep  9 19:35:00 2002
+++ linux-2.5.34-s390/drivers/s390/block/dasd_diag.c	Tue Sep 10 17:30:32 2002
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/hdreg.h>	/* HDIO_GETGEO			    */
+#include <linux/bio.h>
 
 #include <asm/dasd.h>
 #include <asm/debug.h>
@@ -155,7 +156,7 @@
 	private->iob.key = 0;
 	private->iob.flags = 2;	/* do asynchronous io */
 	private->iob.block_count = dreq->block_count;
-	private->iob.interrupt_params = (u32) cqr;
+	private->iob.interrupt_params = (u32)(addr_t) cqr;
 	private->iob.bio_list = __pa(dreq->bio);
 
 	cqr->startclk = get_clock();
@@ -196,21 +197,21 @@
 	ip = S390_lowcore.ext_params;
 
 	cpu = smp_processor_id();
-	irq_enter(cpu, -1);
+	irq_enter();
 
 	if (!ip) {		/* no intparm: unsolicited interrupt */
 		MESSAGE(KERN_DEBUG, "%s", "caught unsolicited interrupt");
-		irq_exit(cpu, -1);
+		irq_exit();
 		return;
 	}
-	cqr = (dasd_ccw_req_t *) ip;
+	cqr = (dasd_ccw_req_t *)(addr_t) ip;
 	device = (dasd_device_t *) cqr->device;
 	if (strncmp(device->discipline->ebcname, (char *) &cqr->magic, 4)) {
 		DEV_MESSAGE(KERN_WARNING, device,
 			    " magic number of dasd_ccw_req_t 0x%08X doesn't"
 			    " match discipline 0x%08X",
 			    cqr->magic, *(int *) (&device->discipline->name));
-		irq_exit(cpu, -1);
+		irq_exit();
 		return;
 	}
 
@@ -244,8 +245,7 @@
 	dasd_schedule_bh(device);
 
 	spin_unlock_irqrestore(get_irq_lock(device->devinfo.irq), flags);
-	irq_exit(cpu, -1);
-
+	irq_exit();
 }
 
 static int
diff -urN linux-2.5.34/drivers/s390/block/dasd_eckd.c linux-2.5.34-s390/drivers/s390/block/dasd_eckd.c
--- linux-2.5.34/drivers/s390/block/dasd_eckd.c	Mon Sep  9 19:35:00 2002
+++ linux-2.5.34-s390/drivers/s390/block/dasd_eckd.c	Tue Sep 10 17:30:32 2002
@@ -29,6 +29,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/hdreg.h>	/* HDIO_GETGEO			    */
+#include <linux/bio.h>
 
 #include <asm/debug.h>
 #include <asm/idals.h>
@@ -69,7 +70,6 @@
 	attrib_data_t attrib;	/* e.g. cache operations */
 } dasd_eckd_private_t;
 
-#ifdef CONFIG_DASD_DYNAMIC
 static
 devreg_t dasd_eckd_known_devices[] = {
 	{
@@ -94,7 +94,6 @@
 		oper_func:dasd_oper_handler
 	}
 };
-#endif
 
 static const int sizes_trk0[] = { 28, 148, 84 };
 #define LABEL_SIZE 140
@@ -1092,7 +1091,8 @@
  * Buils a channel programm to releases a prior reserved 
  * (see dasd_eckd_reserve) device.
  */
-static int dasd_eckd_release(void *inp, int no, long args)
+static int
+dasd_eckd_release(struct block_device *bdev, int no, long args)
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
@@ -1101,7 +1101,7 @@
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-	devmap = dasd_devmap_from_kdev(((struct inode *) inp)->i_rdev);
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -1134,7 +1134,8 @@
  * 'timeout the request'. This leads to an terminate IO if 
  * the interrupt is outstanding for a certain time. 
  */
-static int dasd_eckd_reserve(void *inp, int no, long args)
+static int
+dasd_eckd_reserve(struct block_device *bdev, int no, long args)
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
@@ -1143,7 +1144,7 @@
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-	devmap = dasd_devmap_from_kdev(((struct inode *) inp)->i_rdev);
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -1168,7 +1169,7 @@
 
 	if (rc == -EIO) {
 		/* Request got an eror or has been timed out. */
-		dasd_eckd_release(inp, no, args);
+		dasd_eckd_release(bdev, no, args);
 	}
 	dasd_kfree_request(cqr, cqr->device);
 	dasd_put_device(devmap);
@@ -1180,7 +1181,8 @@
  * Buils a channel programm to break a device's reservation. 
  * (unconditional reserve)
  */
-static int dasd_eckd_steal_lock(void *inp, int no, long args)
+static int
+dasd_eckd_steal_lock(struct block_device *bdev, int no, long args)
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
@@ -1189,7 +1191,7 @@
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-	devmap = dasd_devmap_from_kdev(((struct inode *) inp)->i_rdev);
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -1213,7 +1215,7 @@
 
 	if (rc == -EIO) {
 		/* Request got an eror or has been timed out. */
-		dasd_eckd_release(inp, no, args);
+		dasd_eckd_release(bdev, no, args);
 	}
 	dasd_kfree_request(cqr, cqr->device);
 	dasd_put_device(devmap);
@@ -1223,7 +1225,8 @@
 /*
  * Read performance statistics
  */
-static int dasd_eckd_performance(void *inp, int no, long args)
+static int
+dasd_eckd_performance(struct block_device *bdev, int no, long args)
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
@@ -1233,7 +1236,7 @@
 	ccw1_t *ccw;
 	int rc;
 
-	devmap = dasd_devmap_from_kdev(((struct inode *) inp)->i_rdev);
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -1292,7 +1295,8 @@
  * Set attributes (cache operations)
  * Stores the attributes for cache operation to be used in Define Extend (DE).
  */
-static int dasd_eckd_set_attrib(void *inp, int no, long args)
+static int
+dasd_eckd_set_attrib(struct block_device *bdev, int no, long args)
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
@@ -1304,7 +1308,7 @@
 	if (!args)
 		return -EINVAL;
 
-	devmap = dasd_devmap_from_kdev(((struct inode *) inp)->i_rdev);
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -1452,10 +1456,8 @@
 	ASCEBC(dasd_eckd_discipline.ebcname, 4);
 	dasd_discipline_add(&dasd_eckd_discipline);
 
-#ifdef CONFIG_DASD_DYNAMIC
 	for (i = 0; i < sizeof(dasd_eckd_known_devices)/sizeof(devreg_t); i++)
 			s390_device_register(&dasd_eckd_known_devices[i]);
-#endif
 	return 0;
 }
 
@@ -1464,10 +1466,8 @@
 {
 	int i;
 
-#ifdef CONFIG_DASD_DYNAMIC
 	for (i = 0; i < sizeof(dasd_eckd_known_devices)/sizeof(devreg_t); i++)
 		s390_device_unregister(&dasd_eckd_known_devices[i]);
-#endif				/* CONFIG_DASD_DYNAMIC */
 
 	dasd_discipline_del(&dasd_eckd_discipline);
 
diff -urN linux-2.5.34/drivers/s390/block/dasd_fba.c linux-2.5.34-s390/drivers/s390/block/dasd_fba.c
--- linux-2.5.34/drivers/s390/block/dasd_fba.c	Mon Sep  9 19:35:13 2002
+++ linux-2.5.34-s390/drivers/s390/block/dasd_fba.c	Tue Sep 10 17:30:32 2002
@@ -16,6 +16,7 @@
 
 #include <linux/slab.h>
 #include <linux/hdreg.h>	/* HDIO_GETGEO			    */
+#include <linux/bio.h>
 
 #include <asm/idals.h>
 #include <asm/ebcdic.h>
@@ -43,7 +44,6 @@
 	dasd_fba_characteristics_t rdc_data;
 } dasd_fba_private_t;
 
-#ifdef CONFIG_DASD_DYNAMIC
 static
 devreg_t dasd_fba_known_devices[] = {
 	{
@@ -59,7 +59,6 @@
 		oper_func:dasd_oper_handler
 	}
 };
-#endif
 
 static inline void
 define_extent(ccw1_t * ccw, DE_fba_data_t *data, int rw,
@@ -417,10 +416,8 @@
 
 	ASCEBC(dasd_fba_discipline.ebcname, 4);
 	dasd_discipline_add(&dasd_fba_discipline);
-#ifdef CONFIG_DASD_DYNAMIC
 	for (i = 0; i < sizeof(dasd_fba_known_devices) / sizeof(devreg_t); i++)
 		s390_device_register(&dasd_fba_known_devices[i]);
-#endif
 	return 0;
 }
 
@@ -429,10 +426,8 @@
 {
 	int i;
 
-#ifdef CONFIG_DASD_DYNAMIC
 	for (i = 0; i < sizeof(dasd_fba_known_devices) / sizeof(devreg_t); i++)
 		s390_device_unregister(&dasd_fba_known_devices[i]);
-#endif
 	dasd_discipline_del(&dasd_fba_discipline);
 }
 
diff -urN linux-2.5.34/drivers/s390/block/dasd_genhd.c linux-2.5.34-s390/drivers/s390/block/dasd_genhd.c
--- linux-2.5.34/drivers/s390/block/dasd_genhd.c	Mon Sep  9 19:35:14 2002
+++ linux-2.5.34-s390/drivers/s390/block/dasd_genhd.c	Tue Sep 10 17:30:33 2002
@@ -33,8 +33,6 @@
 struct major_info {
 	struct list_head list;
 	int major;
-	struct gendisk disks[DASD_PER_MAJOR];
-	char names[DASD_PER_MAJOR * 8];
 };
 
 /*
@@ -66,12 +64,8 @@
 dasd_register_major(int major)
 {
 	struct major_info *mi;
-	int new_major, rc;
-	struct list_head *l;
-	int index;
-	int i;
+	int new_major;
 
-	rc = 0;
 	/* Allocate major info structure. */
 	mi = kmalloc(sizeof(struct major_info), GFP_KERNEL);
 
@@ -80,67 +74,39 @@
 		MESSAGE(KERN_WARNING, "%s",
 			"Cannot get memory to allocate another "
 			"major number");
-		rc = -ENOMEM;
-		goto out_error;
+		return -ENOMEM;
 	}
 
 	/* Register block device. */
 	new_major = register_blkdev(major, "dasd", &dasd_device_operations);
 	if (new_major < 0) {
 		MESSAGE(KERN_WARNING,
-			"Cannot register to major no %d, rc = %d", major, rc);
-		rc = new_major;
-		goto out_error;
+			"Cannot register to major no %d, rc = %d",
+			major, new_major);
+		kfree(mi);
+		return new_major;
 	}
 	if (major != 0)
 		new_major = major;
-	
+
 	/* Initialize major info structure. */
-	memset(mi, 0, sizeof(struct major_info));
 	mi->major = new_major;
-	for (i = 0; i < DASD_PER_MAJOR; i++) {
-		struct gendisk *disk = mi->disks + i;
-		disk->major = new_major;
-		disk->first_minor = i << DASD_PARTN_BITS;
-		disk->minor_shift = DASD_PARTN_BITS;
-		disk->fops = &dasd_device_operations;
-		disk->flags = GENHD_FL_DEVFS;
-	}
 
 	/* Setup block device pointers for the new major. */
 	blk_dev[new_major].queue = dasd_get_queue;
 
+	/* Insert the new major info structure into dasd_major_info list. */
 	spin_lock(&dasd_major_lock);
-	index = 0;
-	list_for_each(l, &dasd_major_info)
-		index += DASD_PER_MAJOR;
-	for (i = 0; i < DASD_PER_MAJOR; i++, index++) {
-		char *name = mi->names + i * 8;
-		mi->disks[i].major_name = name;
-		sprintf(name, "dasd");
-		name += 4;
-		if (index > 701)
-			*name++ = 'a' + (((index - 702) / 676) % 26);
-		if (index > 25)
-			*name++ = 'a' + (((index - 26) / 26) % 26);
-		sprintf(name, "%c", 'a' + (index % 26));
-	}
 	list_add_tail(&mi->list, &dasd_major_info);
 	spin_unlock(&dasd_major_lock);
 
 	return 0;
-
-	/* Something failed. Do the cleanup and return rc. */
-out_error:
-	/* We rely on kfree to do the != NULL check. */
-	kfree(mi);
-	return rc;
 }
 
 static void
 dasd_unregister_major(struct major_info * mi)
 {
-	int major, rc;
+	int rc;
 
 	if (mi == NULL)
 		return;
@@ -151,100 +117,178 @@
 	spin_unlock(&dasd_major_lock);
 
 	/* Clear block device pointers. */
-	major = mi->major;
-	blk_dev[major].queue = NULL;
-	blk_clear(major);
+	blk_dev[mi->major].queue = NULL;
+	blk_clear(mi->major);
 
-	rc = unregister_blkdev(major, "dasd");
+	rc = unregister_blkdev(mi->major, "dasd");
 	if (rc < 0)
 		MESSAGE(KERN_WARNING,
 			"Cannot unregister from major no %d, rc = %d",
-			major, rc);
+			mi->major, rc);
 
 	/* Free memory. */
 	kfree(mi);
 }
 
 /*
- * Dynamically allocate a new major for dasd devices.
+ * This one is needed for naming 18000+ possible dasd devices.
+ *   dasda - dasdz : 26 devices
+ *   dasdaa - dasdzz : 676 devices, added up = 702
+ *   dasdaaa - dasdzzz : 17576 devices, added up = 18278
  */
 int
-dasd_gendisk_new_major(void)
+dasd_device_name(char *str, int index, int partition)
 {
-	int rc;
-	
-	rc = dasd_register_major(0);
-	if (rc)
-		DBF_EXC(DBF_ALERT, "%s", "out of major numbers!");
-	return rc;
+	int len;
+
+	if (partition > DASD_PARTN_MASK)
+		return -EINVAL;
+
+	len = sprintf(str, "dasd");
+	if (index > 25) {
+		if (index > 701)
+			len += sprintf(str + len, "%c",
+				       'a' + (((index - 702) / 676) % 26));
+		len += sprintf(str + len, "%c",
+			       'a' + (((index - 26) / 26) % 26));
+	}
+	len += sprintf(str + len, "%c", 'a' + (index % 26));
+
+	if (partition)
+		len += sprintf(str + len, "%d", partition);
+	return 0;
 }
 
 /*
- * Return pointer to gendisk structure by kdev.
+ * Allocate gendisk structure for devindex.
  */
-static struct gendisk *dasd_gendisk_by_dev(kdev_t dev)
+struct gendisk *
+dasd_gendisk_alloc(char *device_name, int devindex)
 {
 	struct list_head *l;
 	struct major_info *mi;
 	struct gendisk *gdp;
-	int major = major(dev);
+	struct hd_struct *gd_part;
+	int index, len, rc;
 
-	spin_lock(&dasd_major_lock);
-	gdp = NULL;
-	list_for_each(l, &dasd_major_info) {
-		mi = list_entry(l, struct major_info, list);
-		if (mi->major == major) {
-			gdp = &mi->disks[minor(dev) >> DASD_PARTN_BITS];
+	/* Make sure the major for this device exists. */
+	mi = NULL;
+	while (1) {
+		spin_lock(&dasd_major_lock);
+		index = devindex;
+		list_for_each(l, &dasd_major_info) {
+			mi = list_entry(l, struct major_info, list);
+			if (index < DASD_PER_MAJOR)
+				break;
+			index -= DASD_PER_MAJOR;
+		}
+		spin_unlock(&dasd_major_lock);
+		if (index < DASD_PER_MAJOR)
 			break;
+		rc = dasd_register_major(0);
+		if (rc) {
+			DBF_EXC(DBF_ALERT, "%s", "out of major numbers!");
+			return ERR_PTR(rc);
 		}
 	}
-	spin_unlock(&dasd_major_lock);
+
+	/* Allocate genhd structure and gendisk arrays. */
+	gdp = kmalloc(sizeof(struct gendisk), GFP_KERNEL);
+	gd_part = kmalloc(sizeof (struct hd_struct) << DASD_PARTN_BITS,
+			  GFP_ATOMIC);
+
+	/* Check if one of the allocations failed. */
+	if (gdp == NULL || gd_part == NULL) {
+		/* We rely on kfree to do the != NULL check. */
+		kfree(gd_part);
+		kfree(gdp);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* Initialize gendisk structure. */
+	memset(gdp, 0, sizeof(struct gendisk));
+	gdp->major = mi->major;
+	gdp->major_name = device_name;
+	gdp->first_minor = index << DASD_PARTN_BITS;
+	gdp->minor_shift = DASD_PARTN_BITS;
+	gdp->part = gd_part;
+	gdp->fops = &dasd_device_operations;
+
+	/*
+	 * Set device name.
+	 *   dasda - dasdz : 26 devices
+	 *   dasdaa - dasdzz : 676 devices, added up = 702
+	 *   dasdaaa - dasdzzz : 17576 devices, added up = 18278
+	 */
+	len = sprintf(device_name, "dasd");
+	if (devindex > 25) {
+		if (devindex > 701)
+			len += sprintf(device_name + len, "%c",
+				       'a' + (((devindex - 702) / 676) % 26));
+		len += sprintf(device_name + len, "%c",
+			       'a' + (((devindex - 26) / 26) % 26));
+	}
+	len += sprintf(device_name + len, "%c", 'a' + (devindex % 26));
+
+	/* Initialize the gendisk arrays. */
+	memset(gd_part, 0, sizeof (struct hd_struct) << DASD_PARTN_BITS);
+
 	return gdp;
 }
 
 /*
- * Return pointer to gendisk structure by devindex.
+ * Free gendisk structure for devindex.
  */
-struct gendisk *
-dasd_gendisk_from_devindex(int devindex)
+void
+dasd_gendisk_free(struct gendisk *gdp)
+{
+	/* Free memory. */
+	kfree(gdp->part);
+	kfree(gdp);
+}
+
+/*
+ * Return devindex of first device using a specific major number.
+ */
+int dasd_gendisk_major_index(int major)
 {
 	struct list_head *l;
 	struct major_info *mi;
-	struct gendisk *gdp;
+	int devindex, rc;
 
 	spin_lock(&dasd_major_lock);
-	gdp = NULL;
+	rc = -EINVAL;
+	devindex = 0;
 	list_for_each(l, &dasd_major_info) {
 		mi = list_entry(l, struct major_info, list);
-		if (devindex < DASD_PER_MAJOR) {
-			gdp = &mi->disks[devindex];
+		if (mi->major == major) {
+			rc = devindex;
 			break;
 		}
-		devindex -= DASD_PER_MAJOR;
+		devindex += DASD_PER_MAJOR;
 	}
 	spin_unlock(&dasd_major_lock);
-	return gdp;
+	return rc;
 }
 
 /*
- * Return devindex of first device using a specifiy major number.
+ * Return major number for device with device index devindex.
  */
-int dasd_gendisk_major_index(int major)
+int dasd_gendisk_index_major(int devindex)
 {
 	struct list_head *l;
 	struct major_info *mi;
-	int devindex, rc;
+	int rc;
 
 	spin_lock(&dasd_major_lock);
-	rc = -EINVAL;
-	devindex = 0;
+	rc = -ENODEV;
 	list_for_each(l, &dasd_major_info) {
 		mi = list_entry(l, struct major_info, list);
-		if (mi->major == major) {
-			rc = devindex;
+		if (devindex < DASD_PER_MAJOR) {
+			rc = mi->major;
 			break;
 		}
-		devindex += DASD_PER_MAJOR;
+		devindex -= DASD_PER_MAJOR;
 	}
 	spin_unlock(&dasd_major_lock);
 	return rc;
@@ -256,13 +300,11 @@
 void
 dasd_setup_partitions(dasd_device_t * device)
 {
-	struct gendisk *disk = dasd_gendisk_by_dev(device->kdev);
-	if (disk == NULL)
-		return;
-	add_gendisk(disk);
-	register_disk(disk, mk_kdev(disk->major, disk->first_minor),
-			1<<disk->minor_shift, disk->fops,
-			device->blocks << device->s2b_shift);
+	/* Make the disk known. */
+	add_gendisk(device->gdp);
+	register_disk(device->gdp, to_kdev_t(device->bdev->bd_dev),
+		      1 << DASD_PARTN_BITS, &dasd_device_operations,
+		      device->blocks << device->s2b_shift);
 }
 
 /*
@@ -272,13 +314,7 @@
 void
 dasd_destroy_partitions(dasd_device_t * device)
 {
-	struct gendisk *disk = dasd_gendisk_by_dev(device->kdev);
-	int minor, i;
-
-	if (disk == NULL)
-		return;
-
-	del_gendisk(disk);
+	del_gendisk(device->gdp);
 }
 
 int
@@ -299,6 +335,7 @@
 dasd_gendisk_exit(void)
 {
 	struct list_head *l, *n;
+
 	spin_lock(&dasd_major_lock);
 	list_for_each_safe(l, n, &dasd_major_info)
 		dasd_unregister_major(list_entry(l, struct major_info, list));
diff -urN linux-2.5.34/drivers/s390/block/dasd_int.h linux-2.5.34-s390/drivers/s390/block/dasd_int.h
--- linux-2.5.34/drivers/s390/block/dasd_int.h	Mon Sep  9 19:35:14 2002
+++ linux-2.5.34-s390/drivers/s390/block/dasd_int.h	Tue Sep 10 17:30:33 2002
@@ -64,12 +64,12 @@
 #include <asm/irq.h>
 #include <asm/s390dyn.h>
 
-#define CONFIG_DASD_DYNAMIC
-
 /*
  * SECTION: Type definitions
  */
-typedef int (*dasd_ioctl_fn_t) (void *inp, int no, long args);
+struct dasd_device_t;
+
+typedef int (*dasd_ioctl_fn_t) (struct block_device *bdev, int no, long args);
 
 typedef struct {
 	struct list_head list;
@@ -139,9 +139,8 @@
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
@@ -153,8 +152,6 @@
 	DBF_EVENT(DBF_ALERT, d_string, d_args); \
 } while(0)
 
-struct dasd_device_t;
-
 typedef struct dasd_ccw_req_t {
 	unsigned int magic;		/* Eye catcher */
         struct list_head list;		/* list_head for request queueing. */
@@ -262,7 +259,8 @@
 typedef struct dasd_device_t {
 	/* Block device stuff. */
 	char name[16];			/* The device name in /dev. */
-	kdev_t kdev;
+	struct block_device *bdev;
+	struct gendisk *gdp;
 	devfs_handle_t devfs_entry;
 	request_queue_t *request_queue;
 	spinlock_t request_queue_lock;
@@ -467,6 +465,7 @@
 dasd_devmap_t *dasd_devmap_from_devindex(int);
 dasd_devmap_t *dasd_devmap_from_irq(int);
 dasd_devmap_t *dasd_devmap_from_kdev(kdev_t);
+dasd_devmap_t *dasd_devmap_from_bdev(struct block_device *bdev);
 dasd_device_t *dasd_get_device(dasd_devmap_t *);
 void dasd_put_device(dasd_devmap_t *);
 
@@ -478,9 +477,10 @@
 /* externals in dasd_gendisk.c */
 int  dasd_gendisk_init(void);
 void dasd_gendisk_exit(void);
-int  dasd_gendisk_new_major(void);
 int  dasd_gendisk_major_index(int);
-struct gendisk *dasd_gendisk_from_devindex(int);
+int  dasd_gendisk_index_major(int);
+struct gendisk *dasd_gendisk_alloc(char *, int);
+void dasd_gendisk_free(struct gendisk *);
 void dasd_setup_partitions(dasd_device_t *);
 void dasd_destroy_partitions(dasd_device_t *);
 
diff -urN linux-2.5.34/drivers/s390/block/dasd_ioctl.c linux-2.5.34-s390/drivers/s390/block/dasd_ioctl.c
--- linux-2.5.34/drivers/s390/block/dasd_ioctl.c	Mon Sep  9 19:35:12 2002
+++ linux-2.5.34-s390/drivers/s390/block/dasd_ioctl.c	Tue Sep 10 17:30:33 2002
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
@@ -450,16 +471,15 @@
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
@@ -468,7 +488,7 @@
 	if (device != NULL && device->discipline != NULL &&
 	    device->discipline->fill_geometry != NULL) {
 		device->discipline->fill_geometry(device, &geo);
-		geo.start = get_start_sect(inode->i_bdev);
+		geo.start = get_start_sect(bdev);
 		if (copy_to_user((struct hd_geometry *) args, &geo,
 				 sizeof (struct hd_geometry)))
 			rc = -EFAULT;
diff -urN linux-2.5.34/drivers/s390/block/dasd_proc.c linux-2.5.34-s390/drivers/s390/block/dasd_proc.c
--- linux-2.5.34/drivers/s390/block/dasd_proc.c	Mon Sep  9 19:35:05 2002
+++ linux-2.5.34-s390/drivers/s390/block/dasd_proc.c	Tue Sep 10 17:30:33 2002
@@ -15,6 +15,7 @@
 #include <linux/config.h>
 #include <linux/version.h>
 #include <linux/ctype.h>
+#include <linux/vmalloc.h>
 
 #include <asm/debug.h>
 #include <asm/irq.h>
@@ -123,7 +124,7 @@
 	}
 	features = dasd_feature_list(str, &str);
 	/* Negative numbers in from/to/features indicate errors */
-	if (from < 0 || to < 0 || features < 0)
+	if (from < 0 || to < 0 || from > 65546 || to > 65536 || features < 0)
 		goto out_error;
 
 	if (add_or_set == 0) {
@@ -152,10 +153,8 @@
 dasd_devices_print(dasd_devmap_t *devmap, char *str)
 {
 	dasd_device_t *device;
-	struct gendisk *gdp;
-	char buffer[7];
 	char *substr;
-	int minor;
+	int major, minor;
 	int len;
 
 	device = dasd_get_device(devmap);
@@ -169,11 +168,11 @@
 	else
 		len += sprintf(str + len, "(none)");
 	/* Print kdev. */
-	gdp = dasd_gendisk_from_devindex(devmap->devindex);
-	minor = devmap->devindex % DASD_PER_MAJOR;
-	len += sprintf(str + len, " at (%3d:%3d)", gdp->major, minor);
+	major = MAJOR(device->bdev->bd_dev);
+	minor = MINOR(device->bdev->bd_dev);
+	len += sprintf(str + len, " at (%3d:%3d)", major, minor);
 	/* Print device name. */
-	len += sprintf(str + len, " is %-7s", gdp->major_name);
+	len += sprintf(str + len, " is %-7s", device->name);
 	/* Print devices features. */
 	substr = (devmap->features & DASD_FEATURE_READONLY) ? "(ro)" : " ";
 	len += sprintf(str + len, "%4s: ", substr);
diff -urN linux-2.5.34/include/asm-s390/dasd.h linux-2.5.34-s390/include/asm-s390/dasd.h
--- linux-2.5.34/include/asm-s390/dasd.h	Mon Sep  9 19:35:04 2002
+++ linux-2.5.34-s390/include/asm-s390/dasd.h	Tue Sep 10 17:30:33 2002
@@ -13,6 +13,8 @@
  * 12/06/01 DASD_API_VERSION 2 - binary compatible to 0 (new BIODASDINFO2)
  * 01/23/02 DASD_API_VERSION 3 - added BIODASDPSRD (and BIODASDENAPAV) IOCTL
  * 02/15/02 DASD_API_VERSION 4 - added BIODASDSATTR IOCTL
+ * ##/##/## DASD_API_VERSION 5 - added boxed dasd support TOBEDONE
+ * 21/06/02 DASD_API_VERSION 6 - fixed HDIO_GETGEO: geo.start is in sectors!
  *         
  */
 
@@ -22,7 +24,7 @@
 
 #define DASD_IOCTL_LETTER 'D'
 
-#define DASD_API_VERSION 4
+#define DASD_API_VERSION 6
 
 /* 
  * struct dasd_information2_t
diff -urN linux-2.5.34/include/asm-s390x/dasd.h linux-2.5.34-s390/include/asm-s390x/dasd.h
--- linux-2.5.34/include/asm-s390x/dasd.h	Mon Sep  9 19:35:06 2002
+++ linux-2.5.34-s390/include/asm-s390x/dasd.h	Tue Sep 10 17:30:33 2002
@@ -13,6 +13,8 @@
  * 12/06/01 DASD_API_VERSION 2 - binary compatible to 0 (new BIODASDINFO2)
  * 01/23/02 DASD_API_VERSION 3 - added BIODASDPSRD (and BIODASDENAPAV) IOCTL
  * 02/15/02 DASD_API_VERSION 4 - added BIODASDSATTR IOCTL
+ * ##/##/## DASD_API_VERSION 5 - added boxed dasd support TOBEDONE
+ * 21/06/02 DASD_API_VERSION 6 - fixed HDIO_GETGEO: geo.start is in sectors!
  *         
  */
 
@@ -22,7 +24,7 @@
 
 #define DASD_IOCTL_LETTER 'D'
 
-#define DASD_API_VERSION 4
+#define DASD_API_VERSION 6
 
 /* 
  * struct dasd_information2_t

