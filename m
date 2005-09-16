Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161033AbVIPBtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161033AbVIPBtL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 21:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161034AbVIPBtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 21:49:11 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:29904 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161033AbVIPBtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 21:49:09 -0400
Date: Fri, 16 Sep 2005 10:48:35 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Fix interface for memory hotplug in 2.6.13-mm3
Cc: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.050
Message-Id: <20050916101541.D1B1.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew-san.

I found old unsuitable interfaces for memory hotplug in 2.6.13-mm3.

The third argument of sparse_add_one_section() was changed from mem_map
to nr_pages. And the third argument of add/remove_memory() was removed.
However, both still remain at a few place.

Could you apply this patch?

Thanks.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Index: linux-2.6.13-mm3/mm/memory_hotplug.c
===================================================================
--- linux-2.6.13-mm3.orig/mm/memory_hotplug.c	2005-09-15 19:51:36.000000000 +0900
+++ linux-2.6.13-mm3/mm/memory_hotplug.c	2005-09-15 20:19:00.000000000 +0900
@@ -39,15 +39,14 @@ static void __add_zone(struct zone *zone
 }
 
 extern int sparse_add_one_section(struct zone *zone, unsigned long start_pfn,
-				  struct page *mem_map);
+				  int nr_pages);
 int __add_section(struct zone *zone, unsigned long phys_start_pfn)
 {
 	struct pglist_data *pgdat = zone->zone_pgdat;
 	int nr_pages = PAGES_PER_SECTION;
-	struct page *memmap;
 	int ret;
 
-	ret = sparse_add_one_section(zone, phys_start_pfn, memmap);
+	ret = sparse_add_one_section(zone, phys_start_pfn, nr_pages);
 
 	if (ret < 0)
 		return ret;
Index: linux-2.6.13-mm3/drivers/acpi/acpi_memhotplug.c
===================================================================
--- linux-2.6.13-mm3.orig/drivers/acpi/acpi_memhotplug.c	2005-09-15 19:51:31.000000000 +0900
+++ linux-2.6.13-mm3/drivers/acpi/acpi_memhotplug.c	2005-09-15 20:21:21.000000000 +0900
@@ -200,8 +200,7 @@ static int acpi_memory_enable_device(str
 	 * Note: Assume that this function returns zero on success
 	 */
 	result = add_memory(mem_device->start_addr,
-			    (mem_device->end_addr - mem_device->start_addr) + 1,
-			    mem_device->read_write_attribute);
+			    (mem_device->end_addr - mem_device->start_addr) + 1);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "\nadd_memory failed\n"));
 		mem_device->state = MEMORY_INVALID_STATE;
@@ -259,7 +258,7 @@ static int acpi_memory_disable_device(st
 	 * Ask the VM to offline this memory range.
 	 * Note: Assume that this function returns zero on success
 	 */
-	result = remove_memory(start, len, attr);
+	result = remove_memory(start, len);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Hot-Remove failed.\n"));
 		return_VALUE(result);

-- 
Yasunori Goto 

