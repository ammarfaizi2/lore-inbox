Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVAaSDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVAaSDW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 13:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVAaSDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 13:03:22 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:46283 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S261294AbVAaR6h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 12:58:37 -0500
Date: Mon, 31 Jan 2005 18:58:28 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 6/8] s390: key protected i/o.
Message-ID: <20050131175828.GF7940@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 6/8] s390: key protected i/o.

From: Thomas Spatzier <tspat@de.ibm.com>

Add interface for key protected i/o.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/cio/cio.c        |   21 ++++++++++++++-------
 drivers/s390/cio/cio.h        |    1 +
 drivers/s390/cio/device_ops.c |   37 ++++++++++++++++++++++++++++++-------
 include/asm-s390/ccwdev.h     |   13 +++++++++++++
 4 files changed, 58 insertions(+), 14 deletions(-)

diff -urN linux-2.6/drivers/s390/cio/cio.c linux-2.6-patched/drivers/s390/cio/cio.c
--- linux-2.6/drivers/s390/cio/cio.c	2005-01-31 18:51:07.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/cio.c	2005-01-31 18:51:23.000000000 +0100
@@ -175,9 +175,10 @@
 }
 
 int
-cio_start (struct subchannel *sch,	/* subchannel structure */
-	   struct ccw1 * cpa,		/* logical channel prog addr */
-	   __u8 lpm)			/* logical path mask */
+cio_start_key (struct subchannel *sch,	/* subchannel structure */
+	       struct ccw1 * cpa,	/* logical channel prog addr */
+	       __u8 lpm,		/* logical path mask */
+	       __u8 key)                /* storage key */
 {
 	char dbf_txt[15];
 	int ccode;
@@ -200,12 +201,12 @@
 	sch->orb.c64 = 1;
 	sch->orb.i2k = 0;
 #endif
+	sch->orb.key = key >> 4;
+	/* issue "Start Subchannel" */
 	sch->orb.cpa = (__u32) __pa (cpa);
-
-	/*
-	 * Issue "Start subchannel" and process condition code
-	 */
 	ccode = ssch (sch->irq, &sch->orb);
+
+	/* process condition code */
 	sprintf (dbf_txt, "ccode:%d", ccode);
 	CIO_TRACE_EVENT (4, dbf_txt);
 
@@ -224,6 +225,12 @@
 	}
 }
 
+int
+cio_start (struct subchannel *sch, struct ccw1 *cpa, __u8 lpm)
+{
+	return cio_start_key(sch, cpa, lpm, default_storage_key);
+}
+
 /*
  * resume suspended I/O operation
  */
diff -urN linux-2.6/drivers/s390/cio/cio.h linux-2.6-patched/drivers/s390/cio/cio.h
--- linux-2.6/drivers/s390/cio/cio.h	2004-12-24 22:33:49.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/cio.h	2005-01-31 18:51:23.000000000 +0100
@@ -122,6 +122,7 @@
 extern int cio_resume (struct subchannel *);
 extern int cio_halt (struct subchannel *);
 extern int cio_start (struct subchannel *, struct ccw1 *, __u8);
+extern int cio_start_key (struct subchannel *, struct ccw1 *, __u8, __u8);
 extern int cio_cancel (struct subchannel *);
 extern int cio_set_options (struct subchannel *, int);
 extern int cio_get_options (struct subchannel *);
diff -urN linux-2.6/drivers/s390/cio/device_ops.c linux-2.6-patched/drivers/s390/cio/device_ops.c
--- linux-2.6/drivers/s390/cio/device_ops.c	2005-01-31 18:51:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device_ops.c	2005-01-31 18:51:23.000000000 +0100
@@ -67,8 +67,9 @@
 }
 
 int
-ccw_device_start(struct ccw_device *cdev, struct ccw1 *cpa,
-		 unsigned long intparm, __u8 lpm, unsigned long flags)
+ccw_device_start_key(struct ccw_device *cdev, struct ccw1 *cpa,
+		     unsigned long intparm, __u8 lpm, __u8 key,
+		     unsigned long flags)
 {
 	struct subchannel *sch;
 	int ret;
@@ -88,29 +89,49 @@
 	ret = cio_set_options (sch, flags);
 	if (ret)
 		return ret;
-	ret = cio_start (sch, cpa, lpm);
+	ret = cio_start_key (sch, cpa, lpm, key);
 	if (ret == 0)
 		cdev->private->intparm = intparm;
 	return ret;
 }
 
+
 int
-ccw_device_start_timeout(struct ccw_device *cdev, struct ccw1 *cpa,
-			 unsigned long intparm, __u8 lpm, unsigned long flags,
-			 int expires)
+ccw_device_start_timeout_key(struct ccw_device *cdev, struct ccw1 *cpa,
+			     unsigned long intparm, __u8 lpm, __u8 key,
+			     unsigned long flags, int expires)
 {
 	int ret;
 
 	if (!cdev)
 		return -ENODEV;
 	ccw_device_set_timeout(cdev, expires);
-	ret = ccw_device_start(cdev, cpa, intparm, lpm, flags);
+	ret = ccw_device_start_key(cdev, cpa, intparm, lpm, key, flags);
 	if (ret != 0)
 		ccw_device_set_timeout(cdev, 0);
 	return ret;
 }
 
 int
+ccw_device_start(struct ccw_device *cdev, struct ccw1 *cpa,
+		 unsigned long intparm, __u8 lpm, unsigned long flags)
+{
+	return ccw_device_start_key(cdev, cpa, intparm, lpm,
+				    default_storage_key, flags);
+}
+
+int
+ccw_device_start_timeout(struct ccw_device *cdev, struct ccw1 *cpa,
+			 unsigned long intparm, __u8 lpm, unsigned long flags,
+			 int expires)
+{
+	return ccw_device_start_timeout_key(cdev, cpa, intparm, lpm,
+					    default_storage_key, flags,
+					    expires);
+}
+
+
+int
 ccw_device_halt(struct ccw_device *cdev, unsigned long intparm)
 {
 	struct subchannel *sch;
@@ -541,6 +562,8 @@
 EXPORT_SYMBOL(ccw_device_resume);
 EXPORT_SYMBOL(ccw_device_start_timeout);
 EXPORT_SYMBOL(ccw_device_start);
+EXPORT_SYMBOL(ccw_device_start_timeout_key);
+EXPORT_SYMBOL(ccw_device_start_key);
 EXPORT_SYMBOL(ccw_device_get_ciw);
 EXPORT_SYMBOL(ccw_device_get_path_mask);
 EXPORT_SYMBOL(read_conf_data);
diff -urN linux-2.6/include/asm-s390/ccwdev.h linux-2.6-patched/include/asm-s390/ccwdev.h
--- linux-2.6/include/asm-s390/ccwdev.h	2004-12-24 22:35:25.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/ccwdev.h	2005-01-31 18:51:23.000000000 +0100
@@ -144,6 +144,19 @@
  */
 extern int ccw_device_start_timeout(struct ccw_device *, struct ccw1 *,
 				    unsigned long, __u8, unsigned long, int);
+/*
+ * ccw_device_start_key()
+ * ccw_device_start_key_timeout()
+ *
+ * Same as ccw_device_start() and ccw_device_start_timeout(), except a
+ * storage key != default key can be provided for the I/O.
+ */
+extern int ccw_device_start_key(struct ccw_device *, struct ccw1 *,
+				unsigned long, __u8, __u8, unsigned long);
+extern int ccw_device_start_timeout_key(struct ccw_device *, struct ccw1 *,
+					unsigned long, __u8, __u8,
+					unsigned long, int);
+
 
 extern int ccw_device_resume(struct ccw_device *);
 extern int ccw_device_halt(struct ccw_device *, unsigned long);
