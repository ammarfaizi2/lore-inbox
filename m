Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967730AbWLDWvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967730AbWLDWvy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 17:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967725AbWLDWvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 17:51:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:21763 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967711AbWLDWvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 17:51:52 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,494,1157353200"; 
   d="scan'208"; a="170149571:sNHT3255504140"
Date: Mon, 4 Dec 2006 14:49:43 -0800
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: len.brown@intel.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [patch 1/3] Make the dock station driver a platform device driver.
Message-Id: <20061204144943.30120719.kristen.c.accardi@intel.com>
In-Reply-To: <20061204224037.713257809@localhost.localdomain>
References: <20061204224037.713257809@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the dock station driver a platform device driver so that
we can create sysfs entries under /sys/device/platform.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
---
 drivers/acpi/dock.c |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

--- kristen-2.6.orig/drivers/acpi/dock.c
+++ kristen-2.6/drivers/acpi/dock.c
@@ -27,6 +27,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/notifier.h>
+#include <linux/platform_device.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
@@ -38,6 +39,8 @@ MODULE_DESCRIPTION(ACPI_DOCK_DRIVER_NAME
 MODULE_LICENSE("GPL");
 
 static struct atomic_notifier_head dock_notifier_list;
+static struct platform_device dock_device;
+static char dock_device_name[] = "dock";
 
 struct dock_station {
 	acpi_handle handle;
@@ -628,6 +631,15 @@ static int dock_add(acpi_handle handle)
 	spin_lock_init(&dock_station->hp_lock);
 	ATOMIC_INIT_NOTIFIER_HEAD(&dock_notifier_list);
 
+	/* initialize platform device stuff */
+	dock_device.name = dock_device_name;
+	ret = platform_device_register(&dock_device);
+	if (ret) {
+		printk(KERN_ERR PREFIX "Error registering dock device\n", ret);
+		kfree(dock_station);
+		return ret;
+	}
+
 	/* Find dependent devices */
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
 			    ACPI_UINT32_MAX, find_dock_devices, dock_station,
@@ -637,7 +649,8 @@ static int dock_add(acpi_handle handle)
 	dd = alloc_dock_dependent_device(handle);
 	if (!dd) {
 		kfree(dock_station);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto dock_add_err_unregister;
 	}
 	add_dock_dependent_device(dock_station, dd);
 
@@ -657,8 +670,10 @@ static int dock_add(acpi_handle handle)
 	return 0;
 
 dock_add_err:
-	kfree(dock_station);
 	kfree(dd);
+dock_add_err_unregister:
+	platform_device_unregister(&dock_device);
+	kfree(dock_station);
 	return ret;
 }
 
@@ -685,6 +700,9 @@ static int dock_remove(void)
 	if (ACPI_FAILURE(status))
 		printk(KERN_ERR "Error removing notify handler\n");
 
+	/* cleanup sysfs */
+	platform_device_unregister(&dock_device);
+
 	/* free dock station memory */
 	kfree(dock_station);
 	return 0;

--
