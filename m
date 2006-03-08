Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbWCHNog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWCHNog (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 08:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbWCHNoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 08:44:15 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:6076 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030189AbWCHNnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 08:43:11 -0500
Date: Wed, 08 Mar 2006 22:43:07 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       Joel Schopp <jschopp@austin.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: [PATCH: 016/017](RFC) Memory hotplug for new nodes v.3. (get node id from acpi's handle)
Cc: linux-ia64@vger.kernel.org, Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060308213726.0042.Y-GOTO@jp.fujitsu.com>
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

  This patch becomes simpler than v2. Because old add_memory()
  function doesn't have node id parameter. So, kernel must 
  find its handle by physical address via DSDT again.
  But, v3 just give node id to add_memory() now.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Index: pgdat6/drivers/acpi/acpi_memhotplug.c
===================================================================
--- pgdat6.orig/drivers/acpi/acpi_memhotplug.c	2006-03-06 18:26:30.000000000 +0900
+++ pgdat6/drivers/acpi/acpi_memhotplug.c	2006-03-06 18:26:31.000000000 +0900
@@ -182,7 +182,7 @@ static int acpi_memory_check_device(stru
 
 static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 {
-	int result;
+	int result, node;
 
 	ACPI_FUNCTION_TRACE("acpi_memory_enable_device");
 
@@ -194,11 +194,12 @@ static int acpi_memory_enable_device(str
 		return result;
 	}
 
+	node = acpi_get_node(mem_device->handle);
 	/*
 	 * Tell the VM there is more memory here...
 	 * Note: Assume that this function returns zero on success
 	 */
-	result = add_memory(mem_device->start_addr, mem_device->length);
+	result = add_memory(node, mem_device->start_addr, mem_device->length);
 	switch(result) {
 	case 0:
 		break;
Index: pgdat6/drivers/acpi/numa.c
===================================================================
--- pgdat6.orig/drivers/acpi/numa.c	2006-03-06 18:25:32.000000000 +0900
+++ pgdat6/drivers/acpi/numa.c	2006-03-06 18:26:31.000000000 +0900
@@ -258,3 +258,18 @@ int acpi_get_pxm(acpi_handle h)
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
Index: pgdat6/include/linux/acpi.h
===================================================================
--- pgdat6.orig/include/linux/acpi.h	2006-03-06 18:25:37.000000000 +0900
+++ pgdat6/include/linux/acpi.h	2006-03-06 18:26:31.000000000 +0900
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


