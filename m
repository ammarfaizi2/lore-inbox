Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWAKJ7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWAKJ7L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 04:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWAKJ7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 04:59:10 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:5567 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751435AbWAKJ7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 04:59:09 -0500
Date: Wed, 11 Jan 2006 18:58:51 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: "Brown, Len" <len.brown@intel.com>
Subject: [Patch 2/2]Memory hotplug from ACPI container driver take 2.(allow -EEXIST.)
Cc: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       ACPI-ML <linux-acpi@vger.kernel.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.057
Message-Id: <20060111184657.BCB4.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When acpi_memory_device_init() is called at boottime to
register struct memory acpi_memory_device. So, 
acpi_bus_add() are called via acpi_driver_attach().
But it also calls ops->start() function.
It is called even if the memory blocks are initialized at
early boottime. In this case add_memory() return -EEXIST, and
the memory blocks becomes INVALID state even if it is normal.

This is patch for it.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>


Index: new_feature_patch/drivers/acpi/acpi_memhotplug.c
===================================================================
--- new_feature_patch.orig/drivers/acpi/acpi_memhotplug.c	2006-01-11 16:03:34.000000000 +0900
+++ new_feature_patch/drivers/acpi/acpi_memhotplug.c	2006-01-11 16:44:18.000000000 +0900
@@ -203,8 +203,19 @@ static int acpi_memory_enable_device(str
 	 */
 	result = add_memory(mem_device->start_addr,
 			    (mem_device->end_addr - mem_device->start_addr) + 1);
-	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "\nadd_memory failed\n"));
+
+	switch(result) {
+	case 0:
+		break;
+	case -EEXIST:
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+				  "\nmemory %lu-%lu has already existed\n"
+				  mem_device->start_addr,
+				  mem_device->end_addr));
+		return 0;
+	default:
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "\nadd_memory failed result=%d\n", result));
 		mem_device->state = MEMORY_INVALID_STATE;
 		return result;
 	}

-- 
Yasunori Goto 


