Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268752AbTCCSTY>; Mon, 3 Mar 2003 13:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268754AbTCCSRw>; Mon, 3 Mar 2003 13:17:52 -0500
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:50842 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S268751AbTCCSRj> convert rfc822-to-8bit; Mon, 3 Mar 2003 13:17:39 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (3/5): dasd driver.
Date: Mon, 3 Mar 2003 19:23:04 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200303031923.04495.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Better take the request queue lock before calling dasd_end_request which in
  turn calls end_that_request_first & end_that_request_last.
* Make it work with CONFIG_DEVFS_FS=y.

diff -urN linux-2.5.63/drivers/s390/block/dasd.c linux-2.5.63-s390/drivers/s390/block/dasd.c
--- linux-2.5.63/drivers/s390/block/dasd.c	Mon Feb 24 20:05:31 2003
+++ linux-2.5.63-s390/drivers/s390/block/dasd.c	Mon Mar  3 18:26:23 2003
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.74 $
+ * $Revision: 1.79 $
  *
  * History of changes (starts July 2000)
  * 11/09/00 complete redesign after code review
@@ -194,8 +194,10 @@
 
 	/* Add a proc directory and the dasd device entry to devfs. */
  	sprintf(buffer, "dasd/%04x", device->devno);
+#ifdef CONFIG_DEVFS_FS
  	dir = devfs_mk_dir(NULL, buffer, NULL);
 	device->gdp->de = dir;
+#endif
 	if (device->ro_flag)
 		devfs_perm = S_IFBLK | S_IRUSR;
 	else
@@ -1176,7 +1178,9 @@
 
 	req = (struct request *) data;
 	dasd_profile_end(cqr->device, cqr, req);
+	spin_lock_irq(&cqr->device->request_queue_lock);
 	dasd_end_request(req, (cqr->status == DASD_CQR_DONE));
+	spin_unlock_irq(&cqr->device->request_queue_lock);
 	dasd_sfree_request(cqr, cqr->device);
 }
 
@@ -2077,11 +2081,13 @@
 
 	DBF_EVENT(DBF_EMERG, "%s", "debug area created");
 
-	if (devfs_mk_dir(NULL, "dasd", NULL)) {
+#ifdef CONFIG_DEVFS_FS
+	if (!devfs_mk_dir(NULL, "dasd", NULL)) {
 		DBF_EVENT(DBF_ALERT, "%s", "no devfs");
 		rc = -ENOSYS;
 		goto failed;
 	}
+#endif
 	rc = dasd_devmap_init();
 	if (rc)
 		goto failed;
diff -urN linux-2.5.63/drivers/s390/block/dasd_genhd.c linux-2.5.63-s390/drivers/s390/block/dasd_genhd.c
--- linux-2.5.63/drivers/s390/block/dasd_genhd.c	Mon Feb 24 20:05:39 2003
+++ linux-2.5.63-s390/drivers/s390/block/dasd_genhd.c	Mon Mar  3 18:26:23 2003
@@ -9,7 +9,7 @@
  *
  * Dealing with devices registered to multiple major numbers.
  *
- * $Revision: 1.23 $
+ * $Revision: 1.24 $
  *
  * History of changes
  * 05/04/02 split from dasd.c, code restructuring.
@@ -145,6 +145,7 @@
 	gdp->major = mi->major;
 	gdp->first_minor = index << DASD_PARTN_BITS;
 	gdp->fops = &dasd_device_operations;
+	gdp->flags |= GENHD_FL_DEVFS;
 
 	/*
 	 * Set device name.

