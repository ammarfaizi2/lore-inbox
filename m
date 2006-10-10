Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWJJQEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWJJQEJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 12:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWJJQEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 12:04:08 -0400
Received: from havoc.gtf.org ([69.61.125.42]:20381 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932162AbWJJQEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 12:04:05 -0400
Date: Tue, 10 Oct 2006 12:03:59 -0400
From: Jeff Garzik <jeff@garzik.org>
To: markus.lidel@shadowconnect.com, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] I2O: handle a few sysfs errors
Message-ID: <20061010160359.GA21592@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

This was just the low-hanging fruit.  There are more unchecked-return
calls in there.

 drivers/message/i2o/bus-osm.c  |   12 ++++++++++--
 drivers/message/i2o/exec-osm.c |   17 ++++++++++++++---
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/message/i2o/bus-osm.c b/drivers/message/i2o/bus-osm.c
index ac06f10..d96c687 100644
--- a/drivers/message/i2o/bus-osm.c
+++ b/drivers/message/i2o/bus-osm.c
@@ -80,18 +80,26 @@ static DEVICE_ATTR(scan, S_IWUSR, NULL, 
  *	@dev: device to verify if it is a I2O Bus Adapter device
  *
  *	Because we want all Bus Adapters always return 0.
+ *	Except when we fail.  Then we are sad.
  *
- *	Returns 0.
+ *	Returns 0, except when we fail to excel.
  */
 static int i2o_bus_probe(struct device *dev)
 {
 	struct i2o_device *i2o_dev = to_i2o_device(get_device(dev));
+	int rc;
 
-	device_create_file(dev, &dev_attr_scan);
+	rc = device_create_file(dev, &dev_attr_scan);
+	if (rc)
+		goto err_out;
 
 	osm_info("device added (TID: %03x)\n", i2o_dev->lct_data.tid);
 
 	return 0;
+
+err_out:
+	put_device(dev);
+	return rc;
 };
 
 /**
diff --git a/drivers/message/i2o/exec-osm.c b/drivers/message/i2o/exec-osm.c
index 7bd4d85..91f95d1 100644
--- a/drivers/message/i2o/exec-osm.c
+++ b/drivers/message/i2o/exec-osm.c
@@ -325,13 +325,24 @@ static DEVICE_ATTR(product_id, S_IRUGO, 
 static int i2o_exec_probe(struct device *dev)
 {
 	struct i2o_device *i2o_dev = to_i2o_device(dev);
+	int rc;
 
-	i2o_event_register(i2o_dev, &i2o_exec_driver, 0, 0xffffffff);
+	rc = i2o_event_register(i2o_dev, &i2o_exec_driver, 0, 0xffffffff);
+	if (rc) goto err_out;
 
-	device_create_file(dev, &dev_attr_vendor_id);
-	device_create_file(dev, &dev_attr_product_id);
+	rc = device_create_file(dev, &dev_attr_vendor_id);
+	if (rc) goto err_evtreg;
+	rc = device_create_file(dev, &dev_attr_product_id);
+	if (rc) goto err_vid;
 
 	return 0;
+
+err_vid:
+	device_remove_file(dev, &dev_attr_vendor_id);
+err_evtreg:
+	i2o_event_register(to_i2o_device(dev), &i2o_exec_driver, 0, 0);
+err_out:
+	return rc;
 };
 
 /**
