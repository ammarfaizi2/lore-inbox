Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936926AbWLDOt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936926AbWLDOt5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936928AbWLDOt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:49:57 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:42503 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S936926AbWLDOtz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:49:55 -0500
Date: Mon, 4 Dec 2006 15:49:49 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, horst.hummel@de.ibm.com
Subject: [S390] handle incorrect values when writing to dasd sysfs attributes.
Message-ID: <20061204144949.GB32059@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horst Hummel <horst.hummel@de.ibm.com>

[S390] handle incorrect values when writing to dasd sysfs attributes.

When writing to dasd attributes (e.g. readonly), all values besides '1'
are handled like '0'.
Other sysfs-attributes like 'online' are checking for '1' and for '0'
and do not accept other values. Therefore enhanced checking and error
handling in dasd_devmap attribute store functions.

Signed-off-by: Horst Hummel <horst.hummel@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_devmap.c |   43 ++++++++++++++++++++++++++-------------
 1 files changed, 29 insertions(+), 14 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd_devmap.c linux-2.6-patched/drivers/s390/block/dasd_devmap.c
--- linux-2.6/drivers/s390/block/dasd_devmap.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_devmap.c	2006-12-04 14:50:29.000000000 +0100
@@ -684,21 +684,26 @@ dasd_ro_store(struct device *dev, struct
 	      const char *buf, size_t count)
 {
 	struct dasd_devmap *devmap;
-	int ro_flag;
+	int val;
+	char *endp;
 
 	devmap = dasd_devmap_from_cdev(to_ccwdev(dev));
 	if (IS_ERR(devmap))
 		return PTR_ERR(devmap);
-	ro_flag = buf[0] == '1';
+
+	val = simple_strtoul(buf, &endp, 0);
+	if (((endp + 1) < (buf + count)) || (val > 1))
+		return -EINVAL;
+
 	spin_lock(&dasd_devmap_lock);
-	if (ro_flag)
+	if (val)
 		devmap->features |= DASD_FEATURE_READONLY;
 	else
 		devmap->features &= ~DASD_FEATURE_READONLY;
 	if (devmap->device)
 		devmap->device->features = devmap->features;
 	if (devmap->device && devmap->device->gdp)
-		set_disk_ro(devmap->device->gdp, ro_flag);
+		set_disk_ro(devmap->device->gdp, val);
 	spin_unlock(&dasd_devmap_lock);
 	return count;
 }
@@ -729,17 +734,22 @@ dasd_use_diag_store(struct device *dev, 
 {
 	struct dasd_devmap *devmap;
 	ssize_t rc;
-	int use_diag;
+	int val;
+	char *endp;
 
 	devmap = dasd_devmap_from_cdev(to_ccwdev(dev));
 	if (IS_ERR(devmap))
 		return PTR_ERR(devmap);
-	use_diag = buf[0] == '1';
+
+	val = simple_strtoul(buf, &endp, 0);
+	if (((endp + 1) < (buf + count)) || (val > 1))
+		return -EINVAL;
+
 	spin_lock(&dasd_devmap_lock);
 	/* Changing diag discipline flag is only allowed in offline state. */
 	rc = count;
 	if (!devmap->device) {
-		if (use_diag)
+		if (val)
 			devmap->features |= DASD_FEATURE_USEDIAG;
 		else
 			devmap->features &= ~DASD_FEATURE_USEDIAG;
@@ -854,20 +864,25 @@ dasd_eer_store(struct device *dev, struc
 	       const char *buf, size_t count)
 {
 	struct dasd_devmap *devmap;
-	int rc;
+	int val, rc;
+	char *endp;
 
 	devmap = dasd_devmap_from_cdev(to_ccwdev(dev));
 	if (IS_ERR(devmap))
 		return PTR_ERR(devmap);
 	if (!devmap->device)
-		return count;
-	if (buf[0] == '1') {
+		return -ENODEV;
+
+	val = simple_strtoul(buf, &endp, 0);
+	if (((endp + 1) < (buf + count)) || (val > 1))
+		return -EINVAL;
+
+	rc = count;
+	if (val)
 		rc = dasd_eer_enable(devmap->device);
-		if (rc)
-			return rc;
-	} else
+	else
 		dasd_eer_disable(devmap->device);
-	return count;
+	return rc;
 }
 
 static DEVICE_ATTR(eer_enabled, 0644, dasd_eer_show, dasd_eer_store);
