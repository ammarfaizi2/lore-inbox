Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWAKJ7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWAKJ7T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 04:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWAKJ7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 04:59:19 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:14276 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932185AbWAKJ7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 04:59:18 -0500
Date: Wed, 11 Jan 2006 18:58:44 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: "Brown, Len" <len.brown@intel.com>
Subject: [Patch 1/2]Memory hotplug from ACPI container driver take 2.(Register start func.)
Cc: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       ACPI-ML <linux-acpi@vger.kernel.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.057
Message-Id: <20060111184634.BCB2.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a patch to create start function which calls add_memory().
Container driver can call add_memory() by this.


Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Index: new_feature_patch/drivers/acpi/acpi_memhotplug.c
===================================================================
--- new_feature_patch.orig/drivers/acpi/acpi_memhotplug.c	2006-01-11 15:49:06.000000000 +0900
+++ new_feature_patch/drivers/acpi/acpi_memhotplug.c	2006-01-11 16:03:34.000000000 +0900
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
 
@@ -394,6 +396,26 @@ static int acpi_memory_device_remove(str
 	return_VALUE(0);
 }
 
+static int
+acpi_memory_device_start (struct acpi_device *device)
+{
+	struct acpi_memory_device *mem_device = NULL;
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


