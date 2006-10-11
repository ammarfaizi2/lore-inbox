Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161524AbWJKVlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161524AbWJKVlv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161530AbWJKVlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:41:51 -0400
Received: from havoc.gtf.org ([69.61.125.42]:33495 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1161524AbWJKVlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:41:49 -0400
Date: Wed, 11 Oct 2006 17:41:48 -0400
From: Jeff Garzik <jeff@garzik.org>
To: markus.lidel@shadowconnect.com, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] I2O: more error checking
Message-ID: <20061011214148.GA20524@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i2o_scsi: handle sysfs failure

i2o_device:
* convert i2o_device_add() to return integer error code
  rather than pointer.  Fortunately -nobody- checks the return code of
  this function, so changing has nil impact.  
* handle errors thrown by device_register() 

More work in i2o_device remains.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/message/i2o/device.c   |   16 +++++++++++-----
 drivers/message/i2o/i2o_scsi.c |   12 +++++++++---

diff --git a/drivers/message/i2o/device.c b/drivers/message/i2o/device.c
index ee18305..5f2c317 100644
--- a/drivers/message/i2o/device.c
+++ b/drivers/message/i2o/device.c
@@ -217,15 +217,15 @@ static struct i2o_device *i2o_device_all
  *	Returns a pointer to the I2O device on success or negative error code
  *	on failure.
  */
-static struct i2o_device *i2o_device_add(struct i2o_controller *c,
-					 i2o_lct_entry * entry)
+static int i2o_device_add(struct i2o_controller *c, i2o_lct_entry *entry)
 {
 	struct i2o_device *i2o_dev, *tmp;
+	int rc;
 
 	i2o_dev = i2o_device_alloc();
 	if (IS_ERR(i2o_dev)) {
 		printk(KERN_ERR "i2o: unable to allocate i2o device\n");
-		return i2o_dev;
+		return PTR_ERR(i2o_dev);
 	}
 
 	i2o_dev->lct_data = *entry;
@@ -236,7 +236,9 @@ static struct i2o_device *i2o_device_add
 	i2o_dev->iop = c;
 	i2o_dev->device.parent = &c->device;
 
-	device_register(&i2o_dev->device);
+	rc = device_register(&i2o_dev->device);
+	if (rc)
+		goto err;
 
 	list_add_tail(&i2o_dev->list, &c->devices);
 
@@ -270,7 +272,11 @@ static struct i2o_device *i2o_device_add
 
 	pr_debug("i2o: device %s added\n", i2o_dev->device.bus_id);
 
-	return i2o_dev;
+	return 0;
+
+err:
+	kfree(i2o_dev);
+	return rc;
 }
 
 /**
diff --git a/drivers/message/i2o/i2o_scsi.c b/drivers/message/i2o/i2o_scsi.c
index 6ebf382..d5f93b1 100644
--- a/drivers/message/i2o/i2o_scsi.c
+++ b/drivers/message/i2o/i2o_scsi.c
@@ -220,7 +220,7 @@ static int i2o_scsi_probe(struct device 
 	u32 id = -1;
 	u64 lun = -1;
 	int channel = -1;
-	int i;
+	int i, rc;
 
 	i2o_shost = i2o_scsi_get_host(c);
 	if (!i2o_shost)
@@ -304,14 +304,20 @@ #endif
 		return PTR_ERR(scsi_dev);
 	}
 
-	sysfs_create_link(&i2o_dev->device.kobj, &scsi_dev->sdev_gendev.kobj,
-			  "scsi");
+	rc = sysfs_create_link(&i2o_dev->device.kobj,
+			       &scsi_dev->sdev_gendev.kobj, "scsi");
+	if (rc)
+		goto err;
 
 	osm_info("device added (TID: %03x) channel: %d, id: %d, lun: %ld\n",
 		 i2o_dev->lct_data.tid, channel, le32_to_cpu(id),
 		 (long unsigned int)le64_to_cpu(lun));
 
 	return 0;
+
+err:
+	scsi_remove_device(scsi_dev);
+	return rc;
 };
 
 static const char *i2o_scsi_info(struct Scsi_Host *SChost)
