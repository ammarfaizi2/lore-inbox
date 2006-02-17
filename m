Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbWBQNbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWBQNbZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 08:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWBQNal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 08:30:41 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:59610 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964913AbWBQNaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 08:30:25 -0500
Date: Fri, 17 Feb 2006 22:29:42 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH: 010/012] Memory hotplug for new nodes v.2(find node id via ACPI's dsdt)
Cc: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       Joel Schopp <jschopp@austin.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, x86-64 Discuss <discuss@x86-64.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060217213906.407C.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is to find node id from physical address via acpi's DSDT.
The acpi_memhotplug driver searches its handle of memory block
in DSDT by paddr, and gets pxm.
Then it translates pxm to node id.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Index: pgdat3/drivers/acpi/acpi_memhotplug.c
===================================================================
--- pgdat3.orig/drivers/acpi/acpi_memhotplug.c	2006-02-17 18:53:20.000000000 +0900
+++ pgdat3/drivers/acpi/acpi_memhotplug.c	2006-02-17 18:53:20.000000000 +0900
@@ -485,6 +485,93 @@ acpi_memory_deregister_notify_handler(ac
 	return_ACPI_STATUS(AE_OK);	/* continue */
 }
 
+struct find_memdevice_arg{
+	u64 start_addr;
+	u64 size;
+};
+
+acpi_status
+acpi_memory_match_paddr_to_memdevice(acpi_handle handle, u32 lvl,
+				     void *context, void **retv)
+{
+	acpi_status status;
+	struct acpi_device *device = NULL;
+	struct find_memdevice_arg *arg = context;
+	struct acpi_memory_device *mem_device = NULL;
+	unsigned long mem_dev_end, arg_end;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_match_paddr_to_memdevice");
+
+	/* If this device is NOT memory device, continue to walk name space.*/
+	status = is_memory_device(handle);
+	if (ACPI_FAILURE(status))
+		return_ACPI_STATUS(AE_OK);
+
+	/* If the device is not attached. continue */
+	if (acpi_bus_get_device(handle, &device) || !device)
+		return_ACPI_STATUS(AE_OK);
+
+	/* If this mem_device is NOT online. continue */
+	mem_device = acpi_driver_data(device);
+	if ((status = acpi_memory_check_device(mem_device)) < 0)
+		return_ACPI_STATUS(AE_OK);
+
+	/* If this mem_device doesn't match target, continue.*/
+	mem_dev_end = mem_device->start_addr + mem_device->length;
+	arg_end = arg->start_addr + arg->size;
+	if (mem_device->start_addr > arg->start_addr || mem_dev_end < arg_end)
+		return_ACPI_STATUS(AE_OK);
+
+	/* Ok. We could get mem_device for this physical memory. */
+	*retv = (void *)mem_device;
+
+	return_ACPI_STATUS(AE_CTRL_TERMINATE);
+}
+
+static int
+acpi_memory_find_memdevice(u64 start_addr, u64 size,
+			struct acpi_memory_device **mem_device)
+{
+	acpi_status status;
+	struct find_memdevice_arg arg;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_find_memdevice");
+
+	arg.start_addr = start_addr;
+	arg.size = size;
+
+	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+				     ACPI_UINT32_MAX,
+				     acpi_memory_match_paddr_to_memdevice,
+				     (void *)&arg, (void **)mem_device);
+
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT ((ACPI_DB_ERROR,
+			"walk_namespace_failed at acpi_memory_fine_memdevice"));
+		return_VALUE(-ENODEV);
+	}
+	return_VALUE(0);
+}
+
+/*
+ * acpi_paddr_to_node():
+ *   Helper function to find which node the physical memory
+ *   belongs to via DSDT.
+ */
+
+int
+acpi_paddr_to_node(u64 start_addr, u64 size)
+{
+	struct acpi_memory_device *mem_device;
+	int node = -1;
+	ACPI_FUNCTION_TRACE("acpi_paddr_to_node");
+
+	if (!acpi_memory_find_memdevice(start_addr, size, &mem_device))
+		node = acpi_get_node(mem_device->handle);
+
+	return_VALUE(node);
+}
+
 static int __init acpi_memory_device_init(void)
 {
 	int result;
Index: pgdat3/drivers/acpi/numa.c
===================================================================
--- pgdat3.orig/drivers/acpi/numa.c	2006-02-17 18:53:01.000000000 +0900
+++ pgdat3/drivers/acpi/numa.c	2006-02-17 18:53:20.000000000 +0900
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
Index: pgdat3/include/linux/acpi.h
===================================================================
--- pgdat3.orig/include/linux/acpi.h	2006-02-17 18:53:01.000000000 +0900
+++ pgdat3/include/linux/acpi.h	2006-02-17 18:53:20.000000000 +0900
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


