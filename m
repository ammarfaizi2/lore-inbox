Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752095AbWCGHCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbWCGHCU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 02:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752089AbWCGHCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 02:02:20 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:4588 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1752026AbWCGHCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 02:02:18 -0500
Date: Tue, 7 Mar 2006 16:01:43 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Dave Hansen <haveblue@us.ibm.com>,
       LHMS <lhms-devel@lists.sourceforge.net>, Greg KH <greg@kroah.com>,
       ACPI <linux-acpi@vger.kernel.org>
Subject: [PATCH] naming memory hotplug's phys_device take2 [2/3] name memory
 hot-added by acpi
Message-Id: <20060307160143.5850ee4b.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch work with "changing phys_device from int to string" patch.
This exports acpi object name in dsdt to memory hotplug control sysfs.

Signed-Off-By: KAMEZAWA Hiroyu <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.16-rc5-mm2/drivers/acpi/acpi_memhotplug.c
===================================================================
--- linux-2.6.16-rc5-mm2.orig/drivers/acpi/acpi_memhotplug.c	2006-03-07 15:12:01.000000000 +0900
+++ linux-2.6.16-rc5-mm2/drivers/acpi/acpi_memhotplug.c	2006-03-07 15:28:08.000000000 +0900
@@ -1,3 +1,4 @@
+
 /*
  * Copyright (C) 2004 Intel Corporation <naveen.b.s@intel.com>
  *
@@ -30,6 +31,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/memory_hotplug.h>
+#include <linux/memory.h>
 #include <acpi/acpi_drivers.h>
 
 #define ACPI_MEMORY_DEVICE_COMPONENT		0x08000000UL
@@ -178,6 +180,22 @@
 	return_VALUE(0);
 }
 
+static int acpi_memory_device_export_name(struct acpi_memory_device *mem_device)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	acpi_status result;
+	int ret;
+
+	result = acpi_get_name(mem_device->handle, ACPI_FULL_PATHNAME, &buffer);
+	if (ACPI_FAILURE(result))
+		return result;
+	ret = memory_device_export_name(mem_device->start_addr,
+				mem_device->start_addr + mem_device->length,
+				buffer.pointer);
+	acpi_os_free(buffer.pointer);
+	return_VALUE(ret);
+}
+
 static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 {
 	int result;
@@ -203,6 +221,11 @@
 		return result;
 	}
 
+	/*
+	 * export ACPI memory object name from sysfs's memory object
+	 */
+	result = acpi_memory_device_export_name(mem_device);
+
 	return result;
 }
 
