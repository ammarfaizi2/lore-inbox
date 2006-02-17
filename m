Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932511AbWBQGpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbWBQGpH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 01:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbWBQGpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 01:45:07 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:21988 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932511AbWBQGpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 01:45:05 -0500
Message-ID: <43F5711F.8010508@jp.fujitsu.com>
Date: Fri, 17 Feb 2006 15:45:51 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Dave Hansen <haveblue@us.ibm.com>, gregkh@suse.de,
       lhms <lhms-devel@lists.sourceforge.net>,
       Yasunori Goto <y-goto@jp.fujitsu.com>
Subject: [PATCH] change memoryX->phys_device from number to symlink [2/2]
 acpi func
Content-Type: multipart/mixed;
 boundary="------------090505020402080006070303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090505020402080006070303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------090505020402080006070303
Content-Type: text/x-patch;
 name="physdevice_symlink_02.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="physdevice_symlink_02.patch"

This patch add phys_device symbolic link support to acpi memory hotplug.
This will help shell script for memory hotplug.

example)
%readlink /sys/devices/system/memory/memory10/phys_device
../../../../firmware/acpi/namespace/ACPI/_SB/LSB1/MEM3


Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


Index: testtree/drivers/acpi/acpi_memhotplug.c
===================================================================
--- testtree.orig/drivers/acpi/acpi_memhotplug.c	2006-02-17 15:07:53.000000000 +0900
+++ testtree/drivers/acpi/acpi_memhotplug.c	2006-02-17 15:08:30.000000000 +0900
@@ -30,6 +30,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/memory_hotplug.h>
+#include <linux/memory.h>
 #include <acpi/acpi_drivers.h>
 
 #define ACPI_MEMORY_DEVICE_COMPONENT		0x08000000UL
@@ -180,6 +181,19 @@
 	return_VALUE(0);
 }
 
+static acpi_status acpi_memory_link_name(struct acpi_memory_device *mem_device)
+{
+	struct acpi_device *device = NULL;
+	acpi_status status;
+	int ret;
+	status = acpi_bus_get_device(mem_device->handle, &device);
+	if (ACPI_FAILURE(status))
+		return status;
+	ret = attach_device_to_memsection(mem_device->start_addr,
+					mem_device->end_addr, &device->kobj);
+	return_VALUE(ret);
+}
+
 static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 {
 	int result;
@@ -206,7 +220,8 @@
 		mem_device->state = MEMORY_INVALID_STATE;
 		return result;
 	}
-
+	/* link to /sys/devices/system/memory/memoryX  */
+	result = acpi_memory_link_name(mem_device);
 	return result;
 }
 
@@ -471,6 +486,22 @@
 	return_ACPI_STATUS(status);
 }
 
+static acpi_status __init acpi_memory_link_name_cb(acpi_handle handle, u32 level,
+						  void *ctxt, void **retv)
+{
+	acpi_status status;
+	struct acpi_memory_device *mem_device;
+	status = is_memory_device(handle);
+	if (ACPI_FAILURE(status))
+		return_ACPI_STATUS(AE_OK); /* continue */
+	if (acpi_memory_get_device(handle, &mem_device)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "Error in finding driver data\n"));
+		return_ACPI_STATUS(AE_OK); /* continue */
+	}
+	return acpi_memory_link_name(mem_device);
+}
+
 static int __init acpi_memory_device_init(void)
 {
 	int result;
@@ -494,6 +525,16 @@
 		return_VALUE(-ENODEV);
 	}
 
+	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+				     ACPI_UINT32_MAX,
+				     acpi_memory_link_name_cb,
+				     NULL, NULL);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "walk_namespace failed\n"));
+		acpi_bus_unregister_driver(&acpi_memory_device_driver);
+		return_VALUE(-ENODEV);
+	}
+
 	return_VALUE(0);
 }
 

--------------090505020402080006070303--


