Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbWCQIYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbWCQIYv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 03:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbWCQIYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 03:24:19 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:13805 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964942AbWCQIX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 03:23:59 -0500
Date: Fri, 17 Mar 2006 17:22:58 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH: 015/017]Memory hotplug for new nodes v.4.(avoid calling add_memory() for already exist memory)
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org,
       linux-mm <linux-mm@kvack.org>, "Luck, Tony" <tony.luck@intel.com>,
       Andi Kleen <ak@suse.de>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060317163803.C655.Y-GOTO@jp.fujitsu.com>
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

 drivers/acpi/acpi_memhotplug.c |   10 ++++++++++
 1 files changed, 10 insertions(+)

Index: pgdat8/drivers/acpi/acpi_memhotplug.c
===================================================================
--- pgdat8.orig/drivers/acpi/acpi_memhotplug.c	2006-03-16 16:06:27.000000000 +0900
+++ pgdat8/drivers/acpi/acpi_memhotplug.c	2006-03-16 16:41:36.000000000 +0900
@@ -234,6 +234,16 @@ static int acpi_memory_enable_device(str
          * (i.e. memory-hot-remove function)
 	 */
 	list_for_each_entry(info, &mem_device->res_list, list) {
+		u64 start_pfn, end_pfn;
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


