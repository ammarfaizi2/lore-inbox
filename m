Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbWDTKLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWDTKLK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 06:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWDTKLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 06:11:10 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:20626 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750828AbWDTKLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 06:11:08 -0400
Date: Thu, 20 Apr 2006 19:10:08 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch: 002/006] pgdat allocation for new node add (get node id by acpi)
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <20060420185123.EE48.Y-GOTO@jp.fujitsu.com>
References: <20060420185123.EE48.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060420190511.EE4C.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is to find node id from acpi's handle of memory_device in DSDT.
_PXM for the new node can be found by acpi_get_pxm()
by using new memory's handle. 
So, node id can be found by pxm_to_nid_map[].

  This patch becomes simpler than v2 of node hot-add patch.
  Because old add_memory() function doesn't have node id parameter.
  So, kernel must find its handle by physical address via DSDT again.
  But, v3 just give node id to add_memory() now.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

 drivers/acpi/acpi_memhotplug.c |    3 ++-
 drivers/acpi/numa.c            |   15 +++++++++++++++
 include/linux/acpi.h           |    6 ++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

Index: pgdat11/drivers/acpi/acpi_memhotplug.c
===================================================================
--- pgdat11.orig/drivers/acpi/acpi_memhotplug.c	2006-04-20 11:00:09.000000000 +0900
+++ pgdat11/drivers/acpi/acpi_memhotplug.c	2006-04-20 11:00:17.000000000 +0900
@@ -215,7 +215,7 @@ static int acpi_memory_enable_device(str
 {
 	int result, num_enabled = 0;
 	struct acpi_memory_info *info;
-	int node = 0;
+	int node;
 
 	ACPI_FUNCTION_TRACE("acpi_memory_enable_device");
 
@@ -227,6 +227,7 @@ static int acpi_memory_enable_device(str
 		return result;
 	}
 
+	node = acpi_get_node(mem_device->handle);
 	/*
 	 * Tell the VM there is more memory here...
 	 * Note: Assume that this function returns zero on success
Index: pgdat11/drivers/acpi/numa.c
===================================================================
--- pgdat11.orig/drivers/acpi/numa.c	2006-04-20 11:00:04.000000000 +0900
+++ pgdat11/drivers/acpi/numa.c	2006-04-20 11:00:17.000000000 +0900
@@ -256,3 +256,18 @@ int acpi_get_pxm(acpi_handle h)
 }
 
 EXPORT_SYMBOL(acpi_get_pxm);
+
+int acpi_get_node(acpi_handle *handle)
+{
+	int pxm, node = -1;
+
+	ACPI_FUNCTION_TRACE("acpi_get_node");
+
+	pxm = acpi_get_pxm(handle);
+	if (pxm >= 0)
+		node = acpi_map_pxm_to_node(pxm);
+
+	return_VALUE(node);
+}
+
+EXPORT_SYMBOL(acpi_get_node);
Index: pgdat11/include/linux/acpi.h
===================================================================
--- pgdat11.orig/include/linux/acpi.h	2006-04-20 11:00:07.000000000 +0900
+++ pgdat11/include/linux/acpi.h	2006-04-20 11:00:17.000000000 +0900
@@ -529,12 +529,18 @@ static inline void acpi_set_cstate_limit
 
 #ifdef CONFIG_ACPI_NUMA
 int acpi_get_pxm(acpi_handle handle);
+int acpi_get_node(acpi_handle *handle);
 #else
 static inline int acpi_get_pxm(acpi_handle handle)
 {
 	return 0;
 }
+static inline int acpi_get_node(acpi_handle *handle)
+{
+	return 0;
+}
 #endif
+extern int acpi_paddr_to_node(u64 start_addr, u64 size);
 
 extern int pnpacpi_disabled;
 

-- 
Yasunori Goto 


