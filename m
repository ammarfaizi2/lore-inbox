Return-Path: <linux-kernel-owner+w=401wt.eu-S1422713AbWLPWlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422713AbWLPWlR (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 17:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422719AbWLPWlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 17:41:16 -0500
Received: from mga02.intel.com ([134.134.136.20]:37778 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422712AbWLPWlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 17:41:14 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,179,1165219200"; 
   d="scan'208"; a="175382228:sNHT19787915"
Date: Sat, 16 Dec 2006 14:40:58 -0800
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 2/2] Convert the bay driver to be a platform driver
Message-Id: <20061216144058.2f2cfd9b.kristen.c.accardi@intel.com>
In-Reply-To: <20061216223309.365745735@localhost.localdomain>
References: <20061216223309.365745735@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the bay driver to be a platform driver, so that we can have sysfs 
entries.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
---

 drivers/acpi/bay.c |   87 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 75 insertions(+), 12 deletions(-)

--- kristen-2.6.orig/drivers/acpi/bay.c
+++ kristen-2.6/drivers/acpi/bay.c
@@ -30,6 +30,7 @@
 #include <acpi/acpi_drivers.h>
 #include <linux/seq_file.h>
 #include <asm/uaccess.h>
+#include <linux/platform_device.h>
 
 #define ACPI_BAY_DRIVER_NAME "ACPI Removable Drive Bay Driver"
 
@@ -45,7 +46,6 @@ MODULE_LICENSE("GPL");
 	struct acpi_buffer buffer = {sizeof(prefix), prefix};\
 	acpi_get_name(h, ACPI_FULL_PATHNAME, &buffer);\
 	printk(KERN_DEBUG PREFIX "%s: %s\n", prefix, s); }
-
 static void bay_notify(acpi_handle handle, u32 event, void *data);
 static int acpi_bay_add(struct acpi_device *device);
 static int acpi_bay_remove(struct acpi_device *device, int type);
@@ -66,6 +66,7 @@ struct bay {
 	acpi_handle handle;
 	char *name;
 	struct list_head list;
+	struct platform_device *pdev;
 };
 
 LIST_HEAD(drive_bays);
@@ -133,6 +134,33 @@ static void eject_device(acpi_handle han
 		pr_debug("Failed to evaluate _EJ0!\n");
 }
 
+/*
+ * show_present - read method for "present" file in sysfs
+ */
+static ssize_t show_present(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct bay *bay = dev_get_drvdata(dev);
+	return snprintf(buf, PAGE_SIZE, "%d\n", bay_present(bay));
+
+}
+DEVICE_ATTR(present, S_IRUGO, show_present, NULL);
+
+/*
+ * write_eject - write method for "eject" file in sysfs
+ */
+static ssize_t write_eject(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct bay *bay = dev_get_drvdata(dev);
+
+	if (!count)
+		return -EINVAL;
+
+	eject_device(bay->handle);
+	return count;
+}
+DEVICE_ATTR(eject, S_IWUSR, NULL, write_eject);
 
 /**
  * is_ata - see if a device is an ata device
@@ -218,16 +246,32 @@ static int acpi_bay_add(struct acpi_devi
 
 static int acpi_bay_add_fs(struct bay *bay)
 {
-	if (!bay)
-		return -EINVAL;
+	int ret;
+	struct device *dev = &bay->pdev->dev;
 
+	ret = device_create_file(dev, &dev_attr_present);
+	if (ret)
+		goto add_fs_err;
+	ret = device_create_file(dev, &dev_attr_eject);
+	if (ret) {
+		device_remove_file(dev, &dev_attr_present);
+		goto add_fs_err;
+	}
 	return 0;
+
+add_fs_err:
+	bay_dprintk(bay->handle, "Error adding sysfs files\n");
+	return ret;
+
 }
 
 static void acpi_bay_remove_fs(struct bay *bay)
 {
-	if (!bay)
-		return;
+	struct device *dev = &bay->pdev->dev;
+
+	/* cleanup sysfs */
+	device_remove_file(dev, &dev_attr_present);
+	device_remove_file(dev, &dev_attr_eject);
 }
 
 static int bay_is_dock_device(acpi_handle handle)
@@ -242,10 +286,11 @@ static int bay_is_dock_device(acpi_handl
 	return (is_dock_device(handle) || is_dock_device(parent));
 }
 
-static int bay_add(acpi_handle handle)
+static int bay_add(acpi_handle handle, int id)
 {
 	acpi_status status;
 	struct bay *new_bay;
+	struct platform_device *pdev;
 	struct acpi_buffer nbuffer = {ACPI_ALLOCATE_BUFFER, NULL};
 	acpi_get_name(handle, ACPI_FULL_PATHNAME, &nbuffer);
 
@@ -254,12 +299,24 @@ static int bay_add(acpi_handle handle)
 	/*
 	 * Initialize bay device structure
 	 */
-	new_bay = kmalloc(GFP_ATOMIC, sizeof(*new_bay));
+	new_bay = kzalloc(GFP_ATOMIC, sizeof(*new_bay));
 	INIT_LIST_HEAD(&new_bay->list);
 	new_bay->handle = handle;
 	new_bay->name = (char *)nbuffer.pointer;
-	list_add(&new_bay->list, &drive_bays);
-	acpi_bay_add_fs(new_bay);
+
+	/* initialize platform device stuff */
+	pdev = platform_device_register_simple(ACPI_BAY_CLASS, id, NULL, 0);
+	if (pdev == NULL) {
+		printk(KERN_ERR PREFIX "Error registering bay device\n");
+		goto bay_add_err;
+	}
+	new_bay->pdev = pdev;
+	platform_set_drvdata(pdev, new_bay);
+
+	if (acpi_bay_add_fs(new_bay)) {
+		platform_device_unregister(new_bay->pdev);
+		goto bay_add_err;
+	}
 
 	/* register for events on this device */
 	status = acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
@@ -275,8 +332,14 @@ static int bay_add(acpi_handle handle)
 		bay_dprintk(handle, "Is dependent on dock\n");
 		register_hotplug_dock_device(handle, bay_notify, new_bay);
 	}
+	list_add(&new_bay->list, &drive_bays);
 	printk(KERN_INFO PREFIX "Bay [%s] Added\n", new_bay->name);
 	return 0;
+
+bay_add_err:
+	kfree(new_bay->name);
+	kfree(new_bay);
+	return -ENODEV;
 }
 
 static int acpi_bay_remove(struct acpi_device *device, int type)
@@ -349,7 +412,6 @@ static struct acpi_device * bay_create_a
 static void bay_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct acpi_device *dev;
-	struct bay *bay = data;
 
 	bay_dprintk(handle, "Bay event");
 
@@ -396,8 +458,8 @@ find_bay(acpi_handle handle, u32 lvl, vo
 	 */
 	if (is_ejectable_bay(handle)) {
 		bay_dprintk(handle, "found ejectable bay");
-		bay_add(handle);
-		(*count)++;
+		if (!bay_add(handle, *count))
+			(*count)++;
 	}
 	return AE_OK;
 }
@@ -432,6 +494,7 @@ static void __exit bay_exit(void)
 		acpi_bay_remove_fs(bay);
 		acpi_remove_notify_handler(bay->handle, ACPI_SYSTEM_NOTIFY,
 			bay_notify);
+		platform_device_unregister(bay->pdev);
 		kfree(bay->name);
 		kfree(bay);
 	}

--
