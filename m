Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWCVPTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWCVPTk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWCVPTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:19:40 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:45955 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751285AbWCVPTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:19:39 -0500
Date: Wed, 22 Mar 2006 16:20:06 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, hch@lst.de, linux-kernel@vger.kernel.org
Subject: [patch 10/24] s390: use normal switch statement for ioctls in dasd_ioctl.c.
Message-ID: <20060322152006.GJ5801@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[patch 10/24] s390: add per-discipline ioctl method.

Add an ->ioctl method to the dasd_discipline structure.  This allows to
apply the same kind of cleanups the last patch applied to dasd_ioctl.c
to dasd_eckd.c (the only dasd discipline with special ioctls) aswell.

Again lots of code removed.  During auditing the ioctls I found two
fishy return value propagations from copy_{from,to}_user, maintainers
please check those, I've marked them with XXX comments.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_eckd.c  |  142 ++++++++++++----------------------------
 drivers/s390/block/dasd_int.h   |    1 
 drivers/s390/block/dasd_ioctl.c |    9 ++
 3 files changed, 55 insertions(+), 97 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd_eckd.c linux-2.6-patched/drivers/s390/block/dasd_eckd.c
--- linux-2.6/drivers/s390/block/dasd_eckd.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_eckd.c	2006-03-22 14:36:20.000000000 +0100
@@ -1227,19 +1227,14 @@ dasd_eckd_fill_info(struct dasd_device *
  * (see dasd_eckd_reserve) device.
  */
 static int
-dasd_eckd_release(struct block_device *bdev, int no, long args)
+dasd_eckd_release(struct dasd_device *device)
 {
-	struct dasd_device *device;
 	struct dasd_ccw_req *cqr;
 	int rc;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
-	device = bdev->bd_disk->private_data;
-	if (device == NULL)
-		return -ENODEV;
-
 	cqr = dasd_smalloc_request(dasd_eckd_discipline.name,
 				   1, 32, device);
 	if (IS_ERR(cqr)) {
@@ -1272,19 +1267,14 @@ dasd_eckd_release(struct block_device *b
  * the interrupt is outstanding for a certain time. 
  */
 static int
-dasd_eckd_reserve(struct block_device *bdev, int no, long args)
+dasd_eckd_reserve(struct dasd_device *device)
 {
-	struct dasd_device *device;
 	struct dasd_ccw_req *cqr;
 	int rc;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
-	device = bdev->bd_disk->private_data;
-	if (device == NULL)
-		return -ENODEV;
-
 	cqr = dasd_smalloc_request(dasd_eckd_discipline.name,
 				   1, 32, device);
 	if (IS_ERR(cqr)) {
@@ -1316,19 +1306,14 @@ dasd_eckd_reserve(struct block_device *b
  * (unconditional reserve)
  */
 static int
-dasd_eckd_steal_lock(struct block_device *bdev, int no, long args)
+dasd_eckd_steal_lock(struct dasd_device *device)
 {
-	struct dasd_device *device;
 	struct dasd_ccw_req *cqr;
 	int rc;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
-	device = bdev->bd_disk->private_data;
-	if (device == NULL)
-		return -ENODEV;
-
 	cqr = dasd_smalloc_request(dasd_eckd_discipline.name,
 				   1, 32, device);
 	if (IS_ERR(cqr)) {
@@ -1358,19 +1343,14 @@ dasd_eckd_steal_lock(struct block_device
  * Read performance statistics
  */
 static int
-dasd_eckd_performance(struct block_device *bdev, int no, long args)
+dasd_eckd_performance(struct dasd_device *device, void __user *argp)
 {
-	struct dasd_device *device;
 	struct dasd_psf_prssd_data *prssdp;
 	struct dasd_rssd_perf_stats_t *stats;
 	struct dasd_ccw_req *cqr;
 	struct ccw1 *ccw;
 	int rc;
 
-	device = bdev->bd_disk->private_data;
-	if (device == NULL)
-		return -ENODEV;
-
 	cqr = dasd_smalloc_request(dasd_eckd_discipline.name,
 				   1 /* PSF */  + 1 /* RSSD */ ,
 				   (sizeof (struct dasd_psf_prssd_data) +
@@ -1414,8 +1394,9 @@ dasd_eckd_performance(struct block_devic
 		/* Prepare for Read Subsystem Data */
 		prssdp = (struct dasd_psf_prssd_data *) cqr->data;
 		stats = (struct dasd_rssd_perf_stats_t *) (prssdp + 1);
-		rc = copy_to_user((long __user *) args, (long *) stats,
-				  sizeof(struct dasd_rssd_perf_stats_t));
+		if (copy_to_user(argp, stats,
+				 sizeof(struct dasd_rssd_perf_stats_t)))
+			rc = -EFAULT;
 	}
 	dasd_sfree_request(cqr, cqr->device);
 	return rc;
@@ -1426,27 +1407,22 @@ dasd_eckd_performance(struct block_devic
  * Returnes the cache attributes used in Define Extend (DE).
  */
 static int
-dasd_eckd_get_attrib (struct block_device *bdev, int no, long args)
+dasd_eckd_get_attrib(struct dasd_device *device, void __user *argp)
 {
-	struct dasd_device *device;
-        struct dasd_eckd_private *private;
-        struct attrib_data_t attrib;
+	struct dasd_eckd_private *private =
+		(struct dasd_eckd_private *)device->private;
+	struct attrib_data_t attrib = private->attrib;
 	int rc;
 
         if (!capable(CAP_SYS_ADMIN))
                 return -EACCES;
-        if (!args)
+	if (!argp)
                 return -EINVAL;
 
-        device = bdev->bd_disk->private_data;
-        if (device == NULL)
-                return -ENODEV;
-
-        private = (struct dasd_eckd_private *) device->private;
-        attrib = private->attrib;
-
-        rc = copy_to_user((long __user *) args, (long *) &attrib,
-			  sizeof (struct attrib_data_t));
+	rc = 0;
+	if (copy_to_user(argp, (long *) &attrib,
+			 sizeof (struct attrib_data_t)))
+		rc = -EFAULT;
 
 	return rc;
 }
@@ -1456,26 +1432,19 @@ dasd_eckd_get_attrib (struct block_devic
  * Stores the attributes for cache operation to be used in Define Extend (DE).
  */
 static int
-dasd_eckd_set_attrib(struct block_device *bdev, int no, long args)
+dasd_eckd_set_attrib(struct dasd_device *device, void __user *argp)
 {
-	struct dasd_device *device;
-	struct dasd_eckd_private *private;
+	struct dasd_eckd_private *private =
+		(struct dasd_eckd_private *)device->private;
 	struct attrib_data_t attrib;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-	if (!args)
+	if (!argp)
 		return -EINVAL;
 
-	device = bdev->bd_disk->private_data;
-	if (device == NULL)
-		return -ENODEV;
-
-	if (copy_from_user(&attrib, (void __user *) args,
-			   sizeof (struct attrib_data_t))) {
+	if (copy_from_user(&attrib, argp, sizeof(struct attrib_data_t)))
 		return -EFAULT;
-	}
-	private = (struct dasd_eckd_private *) device->private;
 	private->attrib = attrib;
 
 	DEV_MESSAGE(KERN_INFO, device,
@@ -1484,6 +1453,27 @@ dasd_eckd_set_attrib(struct block_device
 	return 0;
 }
 
+static int
+dasd_eckd_ioctl(struct dasd_device *device, unsigned int cmd, void __user *argp)
+{
+	switch (cmd) {
+	case BIODASDGATTR:
+		return dasd_eckd_get_attrib(device, argp);
+	case BIODASDSATTR:
+		return dasd_eckd_set_attrib(device, argp);
+	case BIODASDPSRD:
+		return dasd_eckd_performance(device, argp);
+	case BIODASDRLSE:
+		return dasd_eckd_release(device);
+	case BIODASDRSRV:
+		return dasd_eckd_reserve(device);
+	case BIODASDSLCK:
+		return dasd_eckd_steal_lock(device);
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
 /*
  * Print sense data and related channel program.
  * Parts are printed because printk buffer is only 1024 bytes.
@@ -1642,6 +1632,7 @@ static struct dasd_discipline dasd_eckd_
 	.free_cp = dasd_eckd_free_cp,
 	.dump_sense = dasd_eckd_dump_sense,
 	.fill_info = dasd_eckd_fill_info,
+	.ioctl = dasd_eckd_ioctl,
 };
 
 static int __init
@@ -1649,59 +1640,18 @@ dasd_eckd_init(void)
 {
 	int ret;
 
-	dasd_ioctl_no_register(THIS_MODULE, BIODASDGATTR,
-			       dasd_eckd_get_attrib);
-	dasd_ioctl_no_register(THIS_MODULE, BIODASDSATTR,
-			       dasd_eckd_set_attrib);
-	dasd_ioctl_no_register(THIS_MODULE, BIODASDPSRD,
-			       dasd_eckd_performance);
-	dasd_ioctl_no_register(THIS_MODULE, BIODASDRLSE,
-			       dasd_eckd_release);
-	dasd_ioctl_no_register(THIS_MODULE, BIODASDRSRV,
-			       dasd_eckd_reserve);
-	dasd_ioctl_no_register(THIS_MODULE, BIODASDSLCK,
-			       dasd_eckd_steal_lock);
-
 	ASCEBC(dasd_eckd_discipline.ebcname, 4);
 
 	ret = ccw_driver_register(&dasd_eckd_driver);
-	if (ret) {
-		dasd_ioctl_no_unregister(THIS_MODULE, BIODASDGATTR,
-					 dasd_eckd_get_attrib);
-		dasd_ioctl_no_unregister(THIS_MODULE, BIODASDSATTR,
-					 dasd_eckd_set_attrib);
-		dasd_ioctl_no_unregister(THIS_MODULE, BIODASDPSRD,
-					 dasd_eckd_performance);
-		dasd_ioctl_no_unregister(THIS_MODULE, BIODASDRLSE,
-					 dasd_eckd_release);
-		dasd_ioctl_no_unregister(THIS_MODULE, BIODASDRSRV,
-					 dasd_eckd_reserve);
-		dasd_ioctl_no_unregister(THIS_MODULE, BIODASDSLCK,
-					 dasd_eckd_steal_lock);
-		return ret;
-	}
-
-	dasd_generic_auto_online(&dasd_eckd_driver);
-	return 0;
+	if (!ret)
+		dasd_generic_auto_online(&dasd_eckd_driver);
+	return ret;
 }
 
 static void __exit
 dasd_eckd_cleanup(void)
 {
 	ccw_driver_unregister(&dasd_eckd_driver);
-
-	dasd_ioctl_no_unregister(THIS_MODULE, BIODASDGATTR,
-				 dasd_eckd_get_attrib);
-	dasd_ioctl_no_unregister(THIS_MODULE, BIODASDSATTR,
-				 dasd_eckd_set_attrib);
-	dasd_ioctl_no_unregister(THIS_MODULE, BIODASDPSRD,
-				 dasd_eckd_performance);
-	dasd_ioctl_no_unregister(THIS_MODULE, BIODASDRLSE,
-				 dasd_eckd_release);
-	dasd_ioctl_no_unregister(THIS_MODULE, BIODASDRSRV,
-				 dasd_eckd_reserve);
-	dasd_ioctl_no_unregister(THIS_MODULE, BIODASDSLCK,
-				 dasd_eckd_steal_lock);
 }
 
 module_init(dasd_eckd_init);
diff -urpN linux-2.6/drivers/s390/block/dasd_int.h linux-2.6-patched/drivers/s390/block/dasd_int.h
--- linux-2.6/drivers/s390/block/dasd_int.h	2006-03-22 14:36:20.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_int.h	2006-03-22 14:36:20.000000000 +0100
@@ -272,6 +272,7 @@ struct dasd_discipline {
         /* i/o control functions. */
 	int (*fill_geometry) (struct dasd_device *, struct hd_geometry *);
 	int (*fill_info) (struct dasd_device *, struct dasd_information2_t *);
+	int (*ioctl) (struct dasd_device *, unsigned int, void __user *);
 };
 
 extern struct dasd_discipline *dasd_diag_discipline_pointer;
diff -urpN linux-2.6/drivers/s390/block/dasd_ioctl.c linux-2.6-patched/drivers/s390/block/dasd_ioctl.c
--- linux-2.6/drivers/s390/block/dasd_ioctl.c	2006-03-22 14:36:20.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_ioctl.c	2006-03-22 14:36:20.000000000 +0100
@@ -448,7 +448,14 @@ dasd_ioctl(struct inode *inode, struct f
 	case DASDAPIVER:
 		return dasd_ioctl_api_version(argp);
 	default:
-		/* resort to the deprecated dynamic ioctl list */
+		/* if the discipline has an ioctl method try it. */
+		if (device->discipline->ioctl) {
+			int rval = device->discipline->ioctl(device, cmd, argp);
+			if (rval != -ENOIOCTLCMD)
+				return rval;
+		}
+
+		/* else resort to the deprecated dynamic ioctl list */
 		list_for_each_entry(ioctl, &dasd_ioctl_list, list) {
 			if (ioctl->no == cmd) {
 				/* Found a matching ioctl. Call it. */
