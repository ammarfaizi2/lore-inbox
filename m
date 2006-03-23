Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbWCWNpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWCWNpW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 08:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWCWNpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 08:45:22 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:11208 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751055AbWCWNpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 08:45:21 -0500
Date: Thu, 23 Mar 2006 22:44:32 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH: 002/002] Catch notification of memory add event of ACPI via container driver.(avoid redundant call add_memory)
Cc: ACPI-ML <linux-acpi@vger.kernel.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>
In-Reply-To: <20060323221810.8A0B.Y-GOTO@jp.fujitsu.com>
References: <20060323221810.8A0B.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060323224252.8A0F.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When acpi_memory_device_init() is called at boottime to
register struct memory acpi_memory_device, 
acpi_bus_add() are called via acpi_driver_attach().

But it also calls ops->start() function.
It is called even if the memory blocks are initialized at
early boottime. In this case add_memory() return -EEXIST, and
the memory blocks becomes INVALID state even if it is normal.

This is patch to avoid calling add_memory() for already available memory.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

 drivers/acpi/acpi_memhotplug.c |   11 +++++++++++
 1 files changed, 11 insertions(+)

Index: pgdat9/drivers/acpi/acpi_memhotplug.c
===================================================================
--- pgdat9.orig/drivers/acpi/acpi_memhotplug.c	2006-03-23 19:59:01.000000000 +0900
+++ pgdat9/drivers/acpi/acpi_memhotplug.c	2006-03-23 20:20:04.000000000 +0900
@@ -234,6 +234,17 @@ static int acpi_memory_enable_device(str
          * (i.e. memory-hot-remove function)
 	 */
 	list_for_each_entry(info, &mem_device->res_list, list) {
+		u64 start_pfn, end_pfn;
+
+		start_pfn= info->start_addr >> PAGE_SHIFT;
+		end_pfn = (info->start_addr + info->length - 1) >> PAGE_SHIFT;
+
+		if (pfn_valid(start_pfn) || pfn_valid(end_pfn)){
+			/* already enabled. try next area */
+			num_enabled++;
+			continue;
+		}
+
 		result = add_memory(info->start_addr, info->length);
 		if (result)
 			continue;

-- 
Yasunori Goto 


