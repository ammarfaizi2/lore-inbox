Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVCKW7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVCKW7h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 17:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVCKWzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 17:55:55 -0500
Received: from fmr20.intel.com ([134.134.136.19]:5293 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261820AbVCKWxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 17:53:15 -0500
Date: Fri, 11 Mar 2005 16:13:33 -0800
From: long <tlnguyen@snoqualmie.dp.intel.com>
Message-Id: <200503120013.j2C0DXcK020305@snoqualmie.dp.intel.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 2/6] PCI Express Advanced Error Reporting Driver
Cc: greg@kroah.com, tom.l.nguyen@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch includes the source code of sysfs component of PCI
Express Advanced Error Reporting driver.

Signed-off-by: T. Long Nguyen <tom.l.nguyen@intel.com>

--------------------------------------------------------------------
diff -urpN linux-2.6.11-rc5/drivers/pci/pcie/aer/aerdrv_sysfs.c patch-2.6.11-rc5-aerc3-split2/drivers/pci/pcie/aer/aerdrv_sysfs.c
--- linux-2.6.11-rc5/drivers/pci/pcie/aer/aerdrv_sysfs.c	1969-12-31 19:00:00.000000000 -0500
+++ patch-2.6.11-rc5-aerc3-split2/drivers/pci/pcie/aer/aerdrv_sysfs.c	2005-03-09 13:25:36.000000000 -0500
@@ -0,0 +1,87 @@
+/*
+ * Copyright (C) 2005 Intel
+ * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
+ *
+ */
+
+#include "aerdrv_sysfs.h"
+                  	
+static ssize_t aer_sysfs_consume_show(struct device_driver *dev, char *buf)
+{
+	return aer_fsprint_record(buf);
+}
+                  	
+static ssize_t aer_sysfs_status_show(struct device_driver *dev, char *buf)
+{
+	return aer_fsprint_devices(buf);
+}
+                  	
+static ssize_t aer_sysfs_verbose_show(struct device_driver *dev, char *buf)
+{
+	return sprintf(buf, "Verbose display set to %d\n", 
+		aer_get_verbose());				
+}
+                  	
+static ssize_t aer_sysfs_verbose_store(struct device_driver *drv, 	
+					const char *buf, size_t count)  
+{                            
+	aer_set_verbose(buf[0] - 0x30);			
+	return count;							
+}
+
+static ssize_t aer_sysfs_auto_show(struct device_driver *dev, char *buf)
+{
+	return sprintf(buf, "Automatic reporting is %s\n", 		
+		(aer_get_auto_mode()) ? "on" : "off");  			
+}
+                  	
+static ssize_t aer_sysfs_auto_store(struct device_driver *drv, 	
+					const char *buf, size_t count)          
+{                            
+	aer_set_auto_mode(buf[0] - 0x30);			
+	return count;							
+}
+
+/*
+ * Define AER Sysfs user interfaces
+ */
+static DRIVER_ATTR(consume, S_IRUGO, aer_sysfs_consume_show, NULL);
+static DRIVER_ATTR(status, S_IRUGO, aer_sysfs_status_show, NULL);
+static DRIVER_ATTR(verbose, S_IWUSR | S_IRUGO, aer_sysfs_verbose_show,
+		   aer_sysfs_verbose_store);
+static DRIVER_ATTR(auto, S_IWUSR | S_IRUGO, aer_sysfs_auto_show,
+		   aer_sysfs_auto_store);
+
+static struct attribute *aer_sysfs_driver_attrs[] = {
+	&driver_attr_status.attr,
+	&driver_attr_verbose.attr,
+	&driver_attr_consume.attr,
+	&driver_attr_auto.attr,
+	NULL
+};
+
+static struct attribute_group aer_sysfs_driver_attr_group = {
+	.attrs = aer_sysfs_driver_attrs,
+};
+
+/**
+ * aer_sysfs_init - AER user interface initialization
+ * @drv: pointer to device_driver data structure of AER service driver
+ *
+ * Invoked when AER service driver is loaded. 
+ **/
+int aer_sysfs_init(struct device_driver *drv)
+{
+	return sysfs_create_group(&drv->kobj, &aer_sysfs_driver_attr_group);
+}
+
+/**
+ * aer_sysfs_cleanup - remove AER user interface
+ * @drv: pointer to device_driver data structure of AER service driver
+ *
+ * Invoked when AER service driver is unloaded. 
+ **/
+void aer_sysfs_cleanup(struct device_driver *drv)
+{
+	sysfs_remove_group(&drv->kobj, &aer_sysfs_driver_attr_group);
+}
diff -urpN linux-2.6.11-rc5/drivers/pci/pcie/aer/aerdrv_sysfs.h patch-2.6.11-rc5-aerc3-split2/drivers/pci/pcie/aer/aerdrv_sysfs.h
--- linux-2.6.11-rc5/drivers/pci/pcie/aer/aerdrv_sysfs.h	1969-12-31 19:00:00.000000000 -0500
+++ patch-2.6.11-rc5-aerc3-split2/drivers/pci/pcie/aer/aerdrv_sysfs.h	2005-03-09 13:25:36.000000000 -0500
@@ -0,0 +1,19 @@
+/*
+ * Copyright (C) 2005 Intel
+ * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
+ *
+ */
+
+#ifndef	_AERDRV_SYSFS_H_
+#define	_AERDRV_SYSFS_H_
+
+#include <linux/device.h>
+
+extern int aer_fsprint_devices(char *page);
+extern int aer_fsprint_record(char *page);
+extern void aer_set_verbose(int value);
+extern int aer_get_verbose(void);
+extern void aer_set_auto_mode(int value);
+extern int aer_get_auto_mode(void);
+
+#endif	//_AERDRV_SYSFS_H_
