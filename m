Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbWBQNbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWBQNbF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 08:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWBQNar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 08:30:47 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:24517 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964843AbWBQNae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 08:30:34 -0500
Date: Fri, 17 Feb 2006 22:29:56 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH: 012/012] Memory hotplug for new nodes v.2 (allow -EEXIST of add_memory)
Cc: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       Joel Schopp <jschopp@austin.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       linux-ia64@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       x86-64 Discuss <discuss@x86-64.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060217214125.4080.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
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

Index: pgdat3/drivers/acpi/acpi_memhotplug.c
===================================================================
--- pgdat3.orig/drivers/acpi/acpi_memhotplug.c	2006-02-17 16:18:36.000000000 +0900
+++ pgdat3/drivers/acpi/acpi_memhotplug.c	2006-02-17 16:20:53.000000000 +0900
@@ -199,7 +199,16 @@ static int acpi_memory_enable_device(str
 	 * Note: Assume that this function returns zero on success
 	 */
 	result = add_memory(mem_device->start_addr, mem_device->length);
-	if (result) {
+	switch(result) {
+	case 0:
+		break;
+	case -EEXIST:
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+				  "\nmemory start=%lu size=%lu has already existed\n",
+				  mem_device->start_addr,
+				  mem_device->length));
+		return 0;
+	default:
 		ACPI_ERROR((AE_INFO, "add_memory failed"));
 		mem_device->state = MEMORY_INVALID_STATE;
 		return result;

-- 
Yasunori Goto 


