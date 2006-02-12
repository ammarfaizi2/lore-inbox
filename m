Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbWBLRj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWBLRj0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 12:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWBLRj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 12:39:26 -0500
Received: from verein.lst.de ([213.95.11.210]:56216 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1750822AbWBLRjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 12:39:21 -0500
Date: Sun, 12 Feb 2006 18:39:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org, schwidefsky@de.ibm.com, linux390@de.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] dasd: add per-disciple ioctl method
Message-ID: <20060212173913.GC26035@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an ->ioctl method to the dasd_discipline structure.  This allows to
apply the same kind of cleanups the last patch applied to dasd_ioctl.c
to dasd_eckd.c (the only dasd discipline with special ioctls) aswell.

Again lots of code removed.  During auditing the ioctls I found two
fishy return value propagations from copy_{from,to}_user, maintainers
please check those, I've marked them with XXX comments.


 dasd_eckd.c  |  147 +++++++++++++++++++----------------------------------------
 dasd_int.h   |    1 
 dasd_ioctl.c |    9 +++
 3 files changed, 58 insertions(+), 99 deletions(-)

Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6.16-rc2-mm1/drivers/s390/block/dasd_eckd.c
===================================================================
--- linux-2.6.16-rc2-mm1.orig/drivers/s390/block/dasd_eckd.c	2006-02-11 17:32:51.000000000 +0100
+++ linux-2.6.16-rc2-mm1/drivers/s390/block/dasd_eckd.c	2006-02-11 17:38:16.000000000 +0100
@@ -1227,19 +1227,14 @@
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
@@ -1272,19 +1267,14 @@
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
@@ -1316,19 +1306,14 @@
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
@@ -1358,19 +1343,14 @@
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
@@ -1414,7 +1394,11 @@
 		/* Prepare for Read Subsystem Data */
 		prssdp = (struct dasd_psf_prssd_data *) cqr->data;
 		stats = (struct dasd_rssd_perf_stats_t *) (prssdp + 1);
-		rc = copy_to_user((long __user *) args, (long *) stats,
+		/*
+		 * XXX(hch): is it intentional to return the copied bytes in
+		 *	     the error case?
+		 */
+		rc = copy_to_user(argp, stats,
 				  sizeof(struct dasd_rssd_perf_stats_t));
 	}
 	dasd_sfree_request(cqr, cqr->device);
@@ -1426,29 +1410,22 @@
  * Returnes the cache attributes used in Define Extend (DE).
  */
 static int
-dasd_eckd_get_attrib (struct block_device *bdev, int no, long args)
+dasd_eckd_get_attrib(struct dasd_device *device, void __user *argp)
 {
-	struct dasd_device *device;
-        struct dasd_eckd_private *private;
-        struct attrib_data_t attrib;
-	int rc;
+        struct dasd_eckd_private *private =
+		(struct dasd_eckd_private *)device->private;
+        struct attrib_data_t attrib = private->attrib;
 
         if (!capable(CAP_SYS_ADMIN))
                 return -EACCES;
-        if (!args)
+        if (!argp)
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
-
-	return rc;
+	/*
+	 * XXX(hch): is it intentional to return the copied bytes in
+	 *	     the error case?
+	 */
+        return copy_to_user(argp, &attrib, sizeof(struct attrib_data_t));
 }
 
 /*
@@ -1456,26 +1433,19 @@
  * Stores the attributes for cache operation to be used in Define Extend (DE).
  */
 static int
-dasd_eckd_set_attrib(struct block_device *bdev, int no, long args)
+dasd_eckd_set_attrib(struct dasd_device *device, void __user *argp)
 {
-	struct dasd_device *device;
-	struct dasd_eckd_private *private;
+        struct dasd_eckd_private *private =
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
@@ -1484,6 +1454,27 @@
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
@@ -1642,6 +1633,7 @@
 	.free_cp = dasd_eckd_free_cp,
 	.dump_sense = dasd_eckd_dump_sense,
 	.fill_info = dasd_eckd_fill_info,
+	.ioctl = dasd_eckd_ioctl,
 };
 
 static int __init
@@ -1649,59 +1641,18 @@
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
Index: linux-2.6.16-rc2-mm1/drivers/s390/block/dasd_int.h
===================================================================
--- linux-2.6.16-rc2-mm1.orig/drivers/s390/block/dasd_int.h	2006-02-11 17:33:47.000000000 +0100
+++ linux-2.6.16-rc2-mm1/drivers/s390/block/dasd_int.h	2006-02-11 17:38:16.000000000 +0100
@@ -271,6 +271,7 @@
         /* i/o control functions. */
 	int (*fill_geometry) (struct dasd_device *, struct hd_geometry *);
 	int (*fill_info) (struct dasd_device *, struct dasd_information2_t *);
+	int (*ioctl) (struct dasd_device *, unsigned int, void __user *);
 };
 
 extern struct dasd_discipline *dasd_diag_discipline_pointer;
Index: linux-2.6.16-rc2-mm1/drivers/s390/block/dasd_ioctl.c
===================================================================
--- linux-2.6.16-rc2-mm1.orig/drivers/s390/block/dasd_ioctl.c	2006-02-11 17:34:03.000000000 +0100
+++ linux-2.6.16-rc2-mm1/drivers/s390/block/dasd_ioctl.c	2006-02-11 17:56:44.000000000 +0100
@@ -448,7 +448,14 @@
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
