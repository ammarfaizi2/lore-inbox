Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbWCQIYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbWCQIYw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 03:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964954AbWCQIYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 03:24:16 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:28141 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964952AbWCQIYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 03:24:08 -0500
Date: Fri, 17 Mar 2006 17:22:51 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH: 014/017]Memory hotplug for new nodes v.4.(add start function acpi_memhotplug)
Cc: Andi Kleen <ak@suse.de>, "Luck, Tony" <tony.luck@intel.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, linux-mm <linux-mm@kvack.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060317163738.C653.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a patch to call add_memory() when notify reaches for 
new node's add event.

When new node is added, notify of ACPI reaches container device
which means the node.
Container device driver calls acpi_bus_scan() to find and add
belonging devices (which means cpu, memory and so on).
Its function calls add and start function of belonging 
devices's driver.

Howevever, current memory hotplug driver just register add function to
create sysfs file for its memory. But, acpi_memory_enable_device()
is not called because it is considered just the case that notify reaches
memory device directly. So, if notify reaches container device 
nothing can call add_memory().

This is a patch to create start function which calls add_memory().
add_memory() can be called by this when notify reaches container device.


Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

 drivers/acpi/acpi_memhotplug.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+)

Index: pgdat8/drivers/acpi/acpi_memhotplug.c
===================================================================
--- pgdat8.orig/drivers/acpi/acpi_memhotplug.c	2006-03-16 16:05:38.000000000 +0900
+++ pgdat8/drivers/acpi/acpi_memhotplug.c	2006-03-16 16:41:56.000000000 +0900
@@ -57,6 +57,7 @@ MODULE_LICENSE("GPL");
 
 static int acpi_memory_device_add(struct acpi_device *device);
 static int acpi_memory_device_remove(struct acpi_device *device, int type);
+static int acpi_memory_device_start (struct acpi_device *device);
 
 static struct acpi_driver acpi_memory_device_driver = {
 	.name = ACPI_MEMORY_DEVICE_DRIVER_NAME,
@@ -65,6 +66,7 @@ static struct acpi_driver acpi_memory_de
 	.ops = {
 		.add = acpi_memory_device_add,
 		.remove = acpi_memory_device_remove,
+		.start = acpi_memory_device_start,
 		},
 };
 
@@ -429,6 +431,26 @@ static int acpi_memory_device_remove(str
 	return_VALUE(0);
 }
 
+static int
+acpi_memory_device_start (struct acpi_device *device)
+{
+	struct acpi_memory_device *mem_device;
+	int result = 0;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_device_start");
+
+	mem_device = (struct acpi_memory_device *) acpi_driver_data(device);
+
+	if (!acpi_memory_check_device(mem_device)){
+		/* call add_memory func */
+		result = acpi_memory_enable_device(mem_device);
+		if (result)
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Error in acpi_memory_enable_device\n"));
+	}
+	return_VALUE(result);
+}
+
 /*
  * Helper function to check for memory device
  */

-- 
Yasunori Goto 


