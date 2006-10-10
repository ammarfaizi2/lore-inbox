Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965036AbWJJGsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbWJJGsJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 02:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbWJJGsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 02:48:08 -0400
Received: from havoc.gtf.org ([69.61.125.42]:51341 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965036AbWJJGsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 02:48:07 -0400
Date: Tue, 10 Oct 2006 02:48:05 -0400
From: Jeff Garzik <jeff@garzik.org>
To: bcollins@debian.org, stefanr@s5r6.in-berlin.de,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] firewire: handle sysfs errors
Message-ID: <20061010064805.GA21310@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Handle sysfs, driver core errors.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/ieee1394/nodemgr.c         |   36 ++++++++++++++++++++++++++++--------

diff --git a/drivers/ieee1394/nodemgr.c b/drivers/ieee1394/nodemgr.c
index 8e7b83f..8628e3f 100644
--- a/drivers/ieee1394/nodemgr.c
+++ b/drivers/ieee1394/nodemgr.c
@@ -414,9 +414,11 @@ static BUS_ATTR(destroy_node, S_IWUSR | 
 
 static ssize_t fw_set_rescan(struct bus_type *bus, const char *buf, size_t count)
 {
+	int rc;
+
 	if (simple_strtoul(buf, NULL, 10) == 1)
-		bus_rescan_devices(&ieee1394_bus_type);
-	return count;
+		rc = bus_rescan_devices(&ieee1394_bus_type);
+	return rc < 0 ? rc : count;
 }
 static ssize_t fw_get_rescan(struct bus_type *bus, char *buf)
 {
@@ -576,13 +578,23 @@ static struct driver_attribute *const fw
 };
 
 
-static void nodemgr_create_drv_files(struct hpsb_protocol_driver *driver)
+static int nodemgr_create_drv_files(struct hpsb_protocol_driver *driver)
 {
 	struct device_driver *drv = &driver->driver;
-	int i;
+	int i, j, rc;
 
-	for (i = 0; i < ARRAY_SIZE(fw_drv_attrs); i++)
-		driver_create_file(drv, fw_drv_attrs[i]);
+	for (i = 0; i < ARRAY_SIZE(fw_drv_attrs); i++) {
+		rc = driver_create_file(drv, fw_drv_attrs[i]);
+		if (rc)
+			goto err_out;
+	}
+
+	return 0;
+
+err_out:
+	for (j = 0; j < i; j++)
+		driver_remove_file(drv, fw_drv_attrs[j]);
+	return rc;
 }
 
 
@@ -1166,9 +1178,17 @@ int hpsb_register_protocol(struct hpsb_p
 
 	/* This will cause a probe for devices */
 	ret = driver_register(&driver->driver);
-	if (!ret)
-		nodemgr_create_drv_files(driver);
+	if (ret)
+		return ret;
+
+	ret = nodemgr_create_drv_files(driver);
+	if (ret)
+		goto err_out;
+
+	return 0;
 
+err_out:
+	driver_unregister(&driver->driver);
 	return ret;
 }
 
