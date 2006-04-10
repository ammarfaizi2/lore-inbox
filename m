Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWDJJW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWDJJW4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 05:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbWDJJW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 05:22:56 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:23185 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751042AbWDJJWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 05:22:55 -0400
Date: Mon, 10 Apr 2006 18:23:25 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Greg <greg@kroah.com>, mochel@linux.intel.com, len.brown@intel.com,
       ACPI <linux-acpi@vger.kernel.org>, Dave Hansen <haveblue@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] memory hotplug : change phys_device to symbolic [2/2] for
 acpi
Message-Id: <20060410182325.32b8c90b.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is acpi part.
-Kame
===

This patch adds symbolic link from memmory sysfs device to
memory device in acpi namespace.

like this:
[kamezawa@casares ~]$ readlink /sys/devices/system/memory/memory10/phys_device
../../../../firmware/acpi/namespace/ACPI/_SB/LSB1/MEM2

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.17-rc1-mm2/drivers/acpi/acpi_memhotplug.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/drivers/acpi/acpi_memhotplug.c	2006-04-10 18:09:39.000000000 +0900
+++ linux-2.6.17-rc1-mm2/drivers/acpi/acpi_memhotplug.c	2006-04-10 18:09:57.000000000 +0900
@@ -30,6 +30,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/memory_hotplug.h>
+#include <linux/memory.h>
 #include <acpi/acpi_drivers.h>
 
 #define ACPI_MEMORY_DEVICE_COMPONENT		0x08000000UL
@@ -215,6 +216,7 @@
 {
 	int result, num_enabled = 0;
 	struct acpi_memory_info *info;
+	struct acpi_device *device;
 
 	ACPI_FUNCTION_TRACE("acpi_memory_enable_device");
 
@@ -250,6 +252,15 @@
 		info->enabled = 1;
 		num_enabled++;
 	}
+	result = acpi_bus_get_device(mem_device->handle, &device);
+	if (!result) {
+		/* create symbolic link between acpi namespace <->
+		   memory sysfs */
+		list_for_each_entry(info, &mem_device->res_list, list)
+			attach_device_to_memsection(info->start_addr,
+					info->start_addr + info->length,
+						    &device->kobj);
+	}
 
 	if (!num_enabled) {
 		ACPI_ERROR((AE_INFO, "add_memory failed"));

