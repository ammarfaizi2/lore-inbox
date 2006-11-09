Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423960AbWKIA6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423960AbWKIA6x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 19:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423980AbWKIA6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 19:58:53 -0500
Received: from gate.crashing.org ([63.228.1.57]:4792 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1423960AbWKIA6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 19:58:52 -0500
Subject: [PATCH 2/2] Use dev_sysdata for ACPI and remove firmware_data
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
Content-Type: text/plain
Date: Thu, 09 Nov 2006 11:58:36 +1100
Message-Id: <1163033916.28571.803.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes ACPI to use the new dev_sysdata on x86 and x86_64 (is there
any other arch using ACPI ?) to store it's acpi_handle. It also removes the
firmware_data field from struct device as this was the only user.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-cell/drivers/acpi/glue.c
===================================================================
--- linux-cell.orig/drivers/acpi/glue.c	2006-10-06 13:48:00.000000000 +1000
+++ linux-cell/drivers/acpi/glue.c	2006-11-09 11:25:30.000000000 +1100
@@ -267,9 +267,9 @@ static int acpi_bind_one(struct device *
 {
 	acpi_status status;
 
-	if (dev->firmware_data) {
+	if (dev->sysdata.acpi_handle) {
 		printk(KERN_WARNING PREFIX
-		       "Drivers changed 'firmware_data' for %s\n", dev->bus_id);
+		       "Drivers changed 'acpi_handle' for %s\n", dev->bus_id);
 		return -EINVAL;
 	}
 	get_device(dev);
@@ -278,25 +278,26 @@ static int acpi_bind_one(struct device *
 		put_device(dev);
 		return -EINVAL;
 	}
-	dev->firmware_data = handle;
+	dev->sysdata.acpi_handle = handle;
 
 	return 0;
 }
 
 static int acpi_unbind_one(struct device *dev)
 {
-	if (!dev->firmware_data)
+	if (!dev->sysdata.acpi_handle)
 		return 0;
-	if (dev == acpi_get_physical_device(dev->firmware_data)) {
+	if (dev == acpi_get_physical_device(dev->sysdata.acpi_handle)) {
 		/* acpi_get_physical_device increase refcnt by one */
 		put_device(dev);
-		acpi_detach_data(dev->firmware_data, acpi_glue_data_handler);
-		dev->firmware_data = NULL;
+		acpi_detach_data(dev->sysdata.acpi_handle,
+				 acpi_glue_data_handler);
+		dev->sysdata.acpi_handle = NULL;
 		/* acpi_bind_one increase refcnt by one */
 		put_device(dev);
 	} else {
 		printk(KERN_ERR PREFIX
-		       "Oops, 'firmware_data' corrupt for %s\n", dev->bus_id);
+		       "Oops, 'acpi_handle' corrupt for %s\n", dev->bus_id);
 	}
 	return 0;
 }
@@ -328,7 +329,8 @@ static int acpi_platform_notify(struct d
 	if (!ret) {
 		struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
-		acpi_get_name(dev->firmware_data, ACPI_FULL_PATHNAME, &buffer);
+		acpi_get_name(dev->sysdata.acpi_handle,
+			      ACPI_FULL_PATHNAME, &buffer);
 		DBG("Device %s -> %s\n", dev->bus_id, (char *)buffer.pointer);
 		kfree(buffer.pointer);
 	} else
Index: linux-cell/include/acpi/acpi_bus.h
===================================================================
--- linux-cell.orig/include/acpi/acpi_bus.h	2006-10-06 13:48:20.000000000 +1000
+++ linux-cell/include/acpi/acpi_bus.h	2006-11-09 11:26:11.000000000 +1100
@@ -357,7 +357,7 @@ struct device *acpi_get_physical_device(
 /* helper */
 acpi_handle acpi_get_child(acpi_handle, acpi_integer);
 acpi_handle acpi_get_pci_rootbridge_handle(unsigned int, unsigned int);
-#define DEVICE_ACPI_HANDLE(dev) ((acpi_handle)((dev)->firmware_data))
+#define DEVICE_ACPI_HANDLE(dev) ((acpi_handle)((dev)->sysdata.acpi_handle))
 
 #endif /* CONFIG_ACPI */
 
Index: linux-cell/include/asm-i386/device.h
===================================================================
--- linux-cell.orig/include/asm-i386/device.h	2006-11-09 11:20:28.000000000 +1100
+++ linux-cell/include/asm-i386/device.h	2006-11-09 11:24:28.000000000 +1100
@@ -9,6 +9,9 @@
 #define _ASM_DEVICE_H
 
 struct dev_sysdata {
+#ifdef CONFIG_ACPI
+	void	*acpi_handle;
+#endif
 };
 
 #endif /* _ASM_DEVICE_H */
Index: linux-cell/include/linux/device.h
===================================================================
--- linux-cell.orig/include/linux/device.h	2006-11-09 11:17:36.000000000 +1100
+++ linux-cell/include/linux/device.h	2006-11-09 11:26:58.000000000 +1100
@@ -368,8 +368,6 @@ struct device {
 	void		*driver_data;	/* data private to the driver */
 	void		*platform_data;	/* Platform specific data, device
 					   core doesn't touch it */
-	void		*firmware_data; /* Firmware specific data (e.g. ACPI,
-					   BIOS data),reserved for device core*/
 	struct dev_pm_info	power;
 
 	u64		*dma_mask;	/* dma mask (if dma'able device) */
Index: linux-cell/include/asm-x86_64/device.h
===================================================================
--- linux-cell.orig/include/asm-x86_64/device.h	2006-11-09 11:20:29.000000000 +1100
+++ linux-cell/include/asm-x86_64/device.h	2006-11-09 11:37:19.000000000 +1100
@@ -9,6 +9,9 @@
 #define _ASM_DEVICE_H
 
 struct dev_sysdata {
+#ifdef CONFIG_ACPI
+	void	*acpi_handle;
+#endif
 };
 
 #endif /* _ASM_DEVICE_H */


