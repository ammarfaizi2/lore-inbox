Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWIOL1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWIOL1R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 07:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWIOL1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 07:27:17 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:16039 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751269AbWIOL1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 07:27:15 -0400
Date: Fri, 15 Sep 2006 13:27:12 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, peter.oberparleiter@de.ibm.com
Subject: [S390] set modalias for ccw bus uevents.
Message-ID: <20060915112712.GB23134@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

[S390] set modalias for ccw bus uevents.

Add the MODALIAS environment variable for ccw bus uevents.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.c |  109 +++++++++++++++++++++++++++-------------------
 1 files changed, 66 insertions(+), 43 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/device.c linux-2.6-patched/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	2006-09-15 12:17:37.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device.c	2006-09-15 12:18:42.000000000 +0200
@@ -52,53 +52,81 @@ ccw_bus_match (struct device * dev, stru
 	return 1;
 }
 
-/*
- * Hotplugging interface for ccw devices.
- * Heavily modeled on pci and usb hotplug.
- */
-static int
-ccw_uevent (struct device *dev, char **envp, int num_envp,
-	     char *buffer, int buffer_size)
+/* Store modalias string delimited by prefix/suffix string into buffer with
+ * specified size. Return length of resulting string (excluding trailing '\0')
+ * even if string doesn't fit buffer (snprintf semantics). */
+static int snprint_alias(char *buf, size_t size, const char *prefix,
+			 struct ccw_device_id *id, const char *suffix)
+{
+	int len;
+
+	len = snprintf(buf, size, "%sccw:t%04Xm%02X", prefix, id->cu_type,
+		       id->cu_model);
+	if (len > size)
+		return len;
+	buf += len;
+	size -= len;
+
+	if (id->dev_type != 0)
+		len += snprintf(buf, size, "dt%04Xdm%02X%s", id->dev_type,
+				id->dev_model, suffix);
+	else
+		len += snprintf(buf, size, "dtdm%s", suffix);
+
+	return len;
+}
+
+/* Set up environment variables for ccw device uevent. Return 0 on success,
+ * non-zero otherwise. */
+static int ccw_uevent(struct device *dev, char **envp, int num_envp,
+		      char *buffer, int buffer_size)
 {
 	struct ccw_device *cdev = to_ccwdev(dev);
+	struct ccw_device_id *id = &(cdev->id);
 	int i = 0;
-	int length = 0;
+	int len;
 
-	if (!cdev)
-		return -ENODEV;
-
-	/* what we want to pass to /sbin/hotplug */
-
-	envp[i++] = buffer;
-	length += scnprintf(buffer, buffer_size - length, "CU_TYPE=%04X",
-			   cdev->id.cu_type);
-	if ((buffer_size - length <= 0) || (i >= num_envp))
+	/* CU_TYPE= */
+	len = snprintf(buffer, buffer_size, "CU_TYPE=%04X", id->cu_type) + 1;
+	if (len > buffer_size || i >= num_envp)
 		return -ENOMEM;
-	++length;
-	buffer += length;
-
 	envp[i++] = buffer;
-	length += scnprintf(buffer, buffer_size - length, "CU_MODEL=%02X",
-			   cdev->id.cu_model);
-	if ((buffer_size - length <= 0) || (i >= num_envp))
+	buffer += len;
+	buffer_size -= len;
+
+	/* CU_MODEL= */
+	len = snprintf(buffer, buffer_size, "CU_MODEL=%02X", id->cu_model) + 1;
+	if (len > buffer_size || i >= num_envp)
 		return -ENOMEM;
-	++length;
-	buffer += length;
+	envp[i++] = buffer;
+	buffer += len;
+	buffer_size -= len;
 
 	/* The next two can be zero, that's ok for us */
-	envp[i++] = buffer;
-	length += scnprintf(buffer, buffer_size - length, "DEV_TYPE=%04X",
-			   cdev->id.dev_type);
-	if ((buffer_size - length <= 0) || (i >= num_envp))
+	/* DEV_TYPE= */
+	len = snprintf(buffer, buffer_size, "DEV_TYPE=%04X", id->dev_type) + 1;
+	if (len > buffer_size || i >= num_envp)
 		return -ENOMEM;
-	++length;
-	buffer += length;
+	envp[i++] = buffer;
+	buffer += len;
+	buffer_size -= len;
 
+	/* DEV_MODEL= */
+	len = snprintf(buffer, buffer_size, "DEV_MODEL=%02X",
+			(unsigned char) id->dev_model) + 1;
+	if (len > buffer_size || i >= num_envp)
+		return -ENOMEM;
 	envp[i++] = buffer;
-	length += scnprintf(buffer, buffer_size - length, "DEV_MODEL=%02X",
-			   cdev->id.dev_model);
-	if ((buffer_size - length <= 0) || (i >= num_envp))
+	buffer += len;
+	buffer_size -= len;
+
+	/* MODALIAS=  */
+	len = snprint_alias(buffer, buffer_size, "MODALIAS=", id, "") + 1;
+	if (len > buffer_size || i >= num_envp)
 		return -ENOMEM;
+	envp[i++] = buffer;
+	buffer += len;
+	buffer_size -= len;
 
 	envp[i] = NULL;
 
@@ -251,16 +279,11 @@ modalias_show (struct device *dev, struc
 {
 	struct ccw_device *cdev = to_ccwdev(dev);
 	struct ccw_device_id *id = &(cdev->id);
-	int ret;
+	int len;
 
-	ret = sprintf(buf, "ccw:t%04Xm%02X",
-			id->cu_type, id->cu_model);
-	if (id->dev_type != 0)
-		ret += sprintf(buf + ret, "dt%04Xdm%02X\n",
-				id->dev_type, id->dev_model);
-	else
-		ret += sprintf(buf + ret, "dtdm\n");
-	return ret;
+	len = snprint_alias(buf, PAGE_SIZE, "", id, "\n") + 1;
+
+	return len > PAGE_SIZE ? PAGE_SIZE : len;
 }
 
 static ssize_t
