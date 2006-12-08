Return-Path: <linux-kernel-owner+w=401wt.eu-S1425550AbWLHPVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425550AbWLHPVT (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 10:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938063AbWLHPVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 10:21:18 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:46222 "EHLO
	mtagate1.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936710AbWLHPVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 10:21:17 -0500
Date: Fri, 8 Dec 2006 16:21:06 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, horst.hummel@de.ibm.com
Subject: [S390] New DASD feature for ERP related logging
Message-ID: <20061208152106.GA15860@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horst Hummel <horst.hummel@de.ibm.com>

[S390] New DASD feature for ERP related logging

It is now possible to enable/disable ERP related logging without re-compile
and re-ipl. A additional sysfs-attribute 'erplog' allows to switch the 
logging non-interruptive.

Signed-off-by: Horst Hummel <horst.hummel@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c          |    8 +++---
 drivers/s390/block/dasd_3990_erp.c |   23 ++++++-----------
 drivers/s390/block/dasd_devmap.c   |   49 +++++++++++++++++++++++++++++++++++++
 drivers/s390/block/dasd_int.h      |    4 ---
 include/asm-s390/dasd.h            |    2 +
 5 files changed, 64 insertions(+), 22 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd_3990_erp.c linux-2.6-patched/drivers/s390/block/dasd_3990_erp.c
--- linux-2.6/drivers/s390/block/dasd_3990_erp.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_3990_erp.c	2006-12-08 15:52:50.000000000 +0100
@@ -2641,14 +2641,12 @@ dasd_3990_erp_action(struct dasd_ccw_req
 	struct dasd_ccw_req *erp = NULL;
 	struct dasd_device *device = cqr->device;
 	__u32 cpa = cqr->irb.scsw.cpa;
+	struct dasd_ccw_req *temp_erp = NULL;
 
-#ifdef ERP_DEBUG
-	/* print current erp_chain */
-	DEV_MESSAGE(KERN_ERR, device, "%s",
-		    "ERP chain at BEGINNING of ERP-ACTION");
-	{
-		struct dasd_ccw_req *temp_erp = NULL;
-
+	if (device->features & DASD_FEATURE_ERPLOG) {
+		/* print current erp_chain */
+		DEV_MESSAGE(KERN_ERR, device, "%s",
+			    "ERP chain at BEGINNING of ERP-ACTION");
 		for (temp_erp = cqr;
 		     temp_erp != NULL; temp_erp = temp_erp->refers) {
 
@@ -2658,7 +2656,6 @@ dasd_3990_erp_action(struct dasd_ccw_req
 				    temp_erp->refers);
 		}
 	}
-#endif				/* ERP_DEBUG */
 
 	/* double-check if current erp/cqr was successfull */
 	if ((cqr->irb.scsw.cstat == 0x00) &&
@@ -2695,11 +2692,10 @@ dasd_3990_erp_action(struct dasd_ccw_req
 		erp = dasd_3990_erp_handle_match_erp(cqr, erp);
 	}
 
-#ifdef ERP_DEBUG
-	/* print current erp_chain */
-	DEV_MESSAGE(KERN_ERR, device, "%s", "ERP chain at END of ERP-ACTION");
-	{
-		struct dasd_ccw_req *temp_erp = NULL;
+	if (device->features & DASD_FEATURE_ERPLOG) {
+		/* print current erp_chain */
+		DEV_MESSAGE(KERN_ERR, device, "%s",
+			    "ERP chain at END of ERP-ACTION");
 		for (temp_erp = erp;
 		     temp_erp != NULL; temp_erp = temp_erp->refers) {
 
@@ -2709,7 +2705,6 @@ dasd_3990_erp_action(struct dasd_ccw_req
 				    temp_erp->refers);
 		}
 	}
-#endif				/* ERP_DEBUG */
 
 	if (erp->status == DASD_CQR_FAILED)
 		dasd_log_ccw(erp, 1, cpa);
diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2006-12-08 15:52:24.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2006-12-08 15:52:50.000000000 +0100
@@ -1050,10 +1050,10 @@ dasd_int_handler(struct ccw_device *cdev
 		}
 	} else {		/* error */
 		memcpy(&cqr->irb, irb, sizeof (struct irb));
-#ifdef ERP_DEBUG
-		/* dump sense data */
-		dasd_log_sense(cqr, irb);
-#endif
+		if (device->features & DASD_FEATURE_ERPLOG) {
+			/* dump sense data */
+			dasd_log_sense(cqr, irb);
+		}
 		switch (era) {
 		case dasd_era_fatal:
 			cqr->status = DASD_CQR_FAILED;
diff -urpN linux-2.6/drivers/s390/block/dasd_devmap.c linux-2.6-patched/drivers/s390/block/dasd_devmap.c
--- linux-2.6/drivers/s390/block/dasd_devmap.c	2006-12-08 15:52:24.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_devmap.c	2006-12-08 15:52:50.000000000 +0100
@@ -202,6 +202,8 @@ dasd_feature_list(char *str, char **endp
 			features |= DASD_FEATURE_READONLY;
 		else if (len == 4 && !strncmp(str, "diag", 4))
 			features |= DASD_FEATURE_USEDIAG;
+		else if (len == 6 && !strncmp(str, "erplog", 6))
+			features |= DASD_FEATURE_ERPLOG;
 		else {
 			MESSAGE(KERN_WARNING,
 				"unsupported feature: %*s, "
@@ -709,6 +711,52 @@ dasd_ro_store(struct device *dev, struct
 }
 
 static DEVICE_ATTR(readonly, 0644, dasd_ro_show, dasd_ro_store);
+/*
+ * erplog controls the logging of ERP related data
+ * (e.g. failing channel programs).
+ */
+static ssize_t
+dasd_erplog_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct dasd_devmap *devmap;
+	int erplog;
+
+	devmap = dasd_find_busid(dev->bus_id);
+	if (!IS_ERR(devmap))
+		erplog = (devmap->features & DASD_FEATURE_ERPLOG) != 0;
+	else
+		erplog = (DASD_FEATURE_DEFAULT & DASD_FEATURE_ERPLOG) != 0;
+	return snprintf(buf, PAGE_SIZE, erplog ? "1\n" : "0\n");
+}
+
+static ssize_t
+dasd_erplog_store(struct device *dev, struct device_attribute *attr,
+	      const char *buf, size_t count)
+{
+	struct dasd_devmap *devmap;
+	int val;
+	char *endp;
+
+	devmap = dasd_devmap_from_cdev(to_ccwdev(dev));
+	if (IS_ERR(devmap))
+		return PTR_ERR(devmap);
+
+	val = simple_strtoul(buf, &endp, 0);
+	if (((endp + 1) < (buf + count)) || (val > 1))
+		return -EINVAL;
+
+	spin_lock(&dasd_devmap_lock);
+	if (val)
+		devmap->features |= DASD_FEATURE_ERPLOG;
+	else
+		devmap->features &= ~DASD_FEATURE_ERPLOG;
+	if (devmap->device)
+		devmap->device->features = devmap->features;
+	spin_unlock(&dasd_devmap_lock);
+	return count;
+}
+
+static DEVICE_ATTR(erplog, 0644, dasd_erplog_show, dasd_erplog_store);
 
 /*
  * use_diag controls whether the driver should use diag rather than ssch
@@ -896,6 +944,7 @@ static struct attribute * dasd_attrs[] =
 	&dev_attr_uid.attr,
 	&dev_attr_use_diag.attr,
 	&dev_attr_eer_enabled.attr,
+	&dev_attr_erplog.attr,
 	NULL,
 };
 
diff -urpN linux-2.6/drivers/s390/block/dasd_int.h linux-2.6-patched/drivers/s390/block/dasd_int.h
--- linux-2.6/drivers/s390/block/dasd_int.h	2006-12-08 15:52:24.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_int.h	2006-12-08 15:52:50.000000000 +0100
@@ -13,10 +13,6 @@
 
 #ifdef __KERNEL__
 
-/* erp debugging in dasd.c and dasd_3990_erp.c */
-#define ERP_DEBUG
-
-
 /* we keep old device allocation scheme; IOW, minors are still in 0..255 */
 #define DASD_PER_MAJOR (1U << (MINORBITS - DASD_PARTN_BITS))
 #define DASD_PARTN_MASK ((1 << DASD_PARTN_BITS) - 1)
diff -urpN linux-2.6/include/asm-s390/dasd.h linux-2.6-patched/include/asm-s390/dasd.h
--- linux-2.6/include/asm-s390/dasd.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/dasd.h	2006-12-08 15:52:50.000000000 +0100
@@ -69,11 +69,13 @@ typedef struct dasd_information2_t {
  * 0x01: readonly (ro)
  * 0x02: use diag discipline (diag)
  * 0x04: set the device initially online (internal use only)
+ * 0x08: enable ERP related logging
  */
 #define DASD_FEATURE_DEFAULT	     0x00
 #define DASD_FEATURE_READONLY	     0x01
 #define DASD_FEATURE_USEDIAG	     0x02
 #define DASD_FEATURE_INITIAL_ONLINE  0x04
+#define DASD_FEATURE_ERPLOG	     0x08
 
 #define DASD_PARTN_BITS 2
 
