Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVBRAOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVBRAOf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 19:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVBRAOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 19:14:34 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:52690 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261257AbVBRAFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 19:05:17 -0500
Subject: [RFC][PATCH] Memory Hotplug
From: Dave Hansen <haveblue@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: lhms <lhms-devel@lists.sourceforge.net>, linux-mm <linux-mm@kvack.org>,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <1108685033.6482.38.camel@localhost>
References: <1108685033.6482.38.camel@localhost>
Content-Type: multipart/mixed; boundary="=-CFNAnV48gUGKokJyfycj"
Date: Thu, 17 Feb 2005 16:05:11 -0800
Message-Id: <1108685111.6482.40.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CFNAnV48gUGKokJyfycj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The attached patch is a prototype implementation of memory hot-add.  It
allows you to boot your system, and add memory to it later.  Why would
you want to do this?  Well, it's a step before memory removal which can
help cope with things like bad RAM.  This is primarily useful for a
machine that you don't want to reboot during an upgrade.

For instance, on my 1GB laptop, I booted with mem=512M on the kernel
command-line.  Once I had booted, I did the following:

cd /sys/devices/system/memory
echo 0x20000000 > probe
echo 0x30000000 > probe
echo online > memory2/state
echo online > memory3/state

and the last 512MB of my laptop's memory was onlined.  The onlining
operations can occur from an /etc/hotplug script if desired.

Here's the config file that I used:
http://www.sr71.net/patches/2.6.11/2.6.11-rc3-mhp1/configs/config-i386-T41-laptop

The important config options are:
CONFIG_MEMORY_HOTPLUG=y 
CONFIG_SPARSEMEM=y
CONFIG_SIMULATED_MEM_HOTPLUG=y

This patch depends on the previously posed "Sparse Memory Handling
(hot-add foundation)" patch.

There are a number of individual patches (with descriptions) which are
rolled up in the attached patch: all of the files listed after
"G2-no-memory-at-high_memory-ppc64.patch" from this directory:
http://www.sr71.net/patches/2.6.11/2.6.11-rc3-mhp1/broken-out/

I can post individual patches if anyone would like to comment on them.

-- Dave

--=-CFNAnV48gUGKokJyfycj
Content-Disposition: attachment; filename=memory-hot-add-2.6.11-rc3.patch
Content-Type: text/x-patch; name=memory-hot-add-2.6.11-rc3.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

--- memhotplug/arch/i386/kernel/setup.c~Y2-page_is_ram_hotplug	2005-02-17 15:51:10.000000000 -0800
+++ /arch/i386/kernel/setup.c	2005-02-17 15:51:10.000000000 -0800
@@ -118,6 +118,7 @@
 struct edid_info edid_info;
 struct ist_info ist_info;
 struct e820map e820;
+struct e820map bios_e820;
 
 unsigned char aux_device_present;
 
@@ -1417,6 +1418,7 @@
 	else {
 		printk(KERN_INFO "BIOS-provided physical RAM map:\n");
 		print_memory_map(machine_specific_memory_setup());
+		bios_e820 = e820;
 	}
 
 	copy_edd();
--- memhotplug/arch/i386/mm/init.c~L1-sysfs-memory-class	2005-02-17 15:51:08.000000000 -0800
+++ /arch/i386/mm/init.c	2005-02-17 15:51:10.000000000 -0800
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/proc_fs.h>
 #include <linux/efi.h>
+#include <linux/memory_hotplug.h>
 
 #include <asm/processor.h>
 #include <asm/system.h>
@@ -191,38 +192,42 @@
 
 extern int is_available_memory(efi_memory_desc_t *);
 
-int page_is_ram(unsigned long pagenr)
+static int page_is_ram_efi(unsigned long pagenr)
 {
+#ifdef CONFIG_EFI
 	int i;
 	unsigned long addr, end;
+	efi_memory_desc_t *md;
 
-	if (efi_enabled) {
-		efi_memory_desc_t *md;
-
-		for (i = 0; i < memmap.nr_map; i++) {
-			md = &memmap.map[i];
-			if (!is_available_memory(md))
-				continue;
-			addr = (md->phys_addr+PAGE_SIZE-1) >> PAGE_SHIFT;
-			end = (md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT)) >> PAGE_SHIFT;
-
-			if ((pagenr >= addr) && (pagenr < end))
-				return 1;
-		}
-		return 0;
+	for (i = 0; i < memmap.nr_map; i++) {
+		md = &memmap.map[i];
+		if (!is_available_memory(md))
+			continue;
+		addr = (md->phys_addr+PAGE_SIZE-1) >> PAGE_SHIFT;
+		end = (md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT)) >> PAGE_SHIFT;
+		if ((pagenr >= addr) && (pagenr < end))
+			return 1;
 	}
+#endif /* CONFIG_EFI */
+	return 0;
+}
 
-	for (i = 0; i < e820.nr_map; i++) {
+int page_is_ram_e820(unsigned long pagenr, struct e820map *local_e820)
+{
+	int i;
+	unsigned long addr, end;
+
+	for (i = 0; i < local_e820->nr_map; i++) {
 
-		if (e820.map[i].type != E820_RAM)	/* not usable memory */
+		if (local_e820->map[i].type != E820_RAM) /* not usable memory */
 			continue;
 		/*
 		 *	!!!FIXME!!! Some BIOSen report areas as RAM that
 		 *	are not. Notably the 640->1Mb area. We need a sanity
 		 *	check here.
 		 */
-		addr = (e820.map[i].addr+PAGE_SIZE-1) >> PAGE_SHIFT;
-		end = (e820.map[i].addr+e820.map[i].size) >> PAGE_SHIFT;
+		addr = (local_e820->map[i].addr+PAGE_SIZE-1) >> PAGE_SHIFT;
+		end = (local_e820->map[i].addr+local_e820->map[i].size) >> PAGE_SHIFT;
 		if  ((pagenr >= addr) && (pagenr < end))
 			return 1;
 	}
@@ -543,6 +548,7 @@
 	int tmp;
 	int bad_ppro;
 
+
 #ifdef CONFIG_FLATMEM
 	if (!mem_map)
 		BUG();
@@ -617,6 +623,104 @@
 #endif
 }
 
+int add_one_highpage(struct page *page, int pfn, int bad_ppro)
+{
+	/*
+	 * there's no page_is_ram() check because that only covers ram
+	 * from boot-time.  We learned about this ram later
+	 */
+	if ( !(bad_ppro && page_kills_ppro(pfn))) {
+		set_bit(PG_highmem, &page->flags);
+		set_page_count(page, 1);
+		__free_page(page);
+		totalhigh_pages++;
+	} else {
+		SetPageReserved(page);
+		BUG(); /* for debugging.  remove later */
+	}
+	totalram_pages++;
+#ifdef CONFIG_FLATMEM
+	max_mapnr++;
+#endif
+	num_physpages++;
+	return 0;
+}
+
+
+/*
+ * Not currently handling the NUMA case.
+ * Assuming single node and all memory that
+ * has been added dynamically that would be
+ * onlined here is in HIGHMEM
+ */
+
+void online_page(struct page *page)
+{
+	ClearPageReserved(page);
+	add_one_highpage(page, page_to_pfn(page), 0);
+}
+
+/*
+ * this is for the non-NUMA, single node SMP system case.
+ * Specifically, in the case of x86, we will always add
+ * memory to the highmem for now.
+ */
+#ifndef CONFIG_NUMA
+int add_memory(u64 start, u64 size, unsigned long attr)
+{
+	struct pglist_data *pgdata = &contig_page_data;
+	struct zone *zone = pgdata->node_zones + MAX_NR_ZONES-1;
+	unsigned long start_pfn = start >> PAGE_SHIFT;
+	unsigned long nr_pages = size >> PAGE_SHIFT;
+
+	return __add_pages(zone, start_pfn, nr_pages, attr);
+}
+
+int remove_memory(u64 start, u64 size, unsigned long attr)
+{
+	struct zone *zone;
+	unsigned long start_pfn, end_pfn, nr_pages;
+
+	start_pfn = start >> PAGE_SHIFT;
+	nr_pages = size >> PAGE_SHIFT;
+	end_pfn = start_pfn + nr_pages;
+
+	/*
+	 * check to see which zone the page range is in. If
+	 * not in a zone where we allow hotplug (i.e. highmem),
+	 * just fail it right now.
+	 */
+	zone = page_zone(pfn_to_page(start_pfn));
+
+	printk(KERN_DEBUG "%s(): memory will be removed from "
+			"the %s zone\n", __func__, zone->name);
+
+	/*
+	 * not handling removing memory ranges that
+	 * overlap multiple zones yet
+	 */
+	if (zone != page_zone(pfn_to_page(end_pfn-1)))
+		goto overlap;
+
+	/* make sure it is in highmem */
+	if (!is_highmem(zone)) {
+		printk(KERN_DEBUG "%s(): range to be removed must be in highmem!\n",
+			__func__);
+		goto not_highmem;
+	}
+
+	return __remove_pages(zone, start_pfn, nr_pages, attr);
+
+overlap:
+	printk(KERN_DEBUG "%s(): memory range to be removed overlaps "
+		"multiple zones!!!\n", __func__);
+not_highmem:
+	return -EINVAL;
+}
+#endif
+
+
+
 kmem_cache_t *pgd_cache;
 kmem_cache_t *pmd_cache;
 
@@ -697,3 +801,10 @@
 	}
 }
 #endif
+
+int page_is_ram(unsigned long pagenr)
+{
+	if (efi_enabled)
+		return page_is_ram_efi(pagenr);
+	return page_is_ram_e820(pagenr, &e820);
+}
--- memhotplug/arch/ia64/mm/init.c~L2-ia64-hotplug-stubs	2005-02-17 15:51:09.000000000 -0800
+++ /arch/ia64/mm/init.c	2005-02-17 15:51:09.000000000 -0800
@@ -618,3 +618,24 @@
 	ia32_mem_init();
 #endif
 }
+
+#ifdef	CONFIG_MEMORY_HOTPLUG
+void online_page(struct page *page)
+{
+	ClearPageReserved(page);
+	set_page_count(page, 1);
+	__free_page(page);
+	totalram_pages++;
+	num_physpages++;
+}
+
+int add_memory(u64 start, u64 size, unsigned long attr)
+{
+	return -ENOSYS;
+}
+
+int remove_memory(u64 start, u64 size, unsigned long attr)
+{
+	return -ENOSYS;
+}
+#endif
--- memhotplug/arch/ppc64/mm/init.c~I0-nonlinear-types	2005-02-17 15:51:06.000000000 -0800
+++ /arch/ppc64/mm/init.c	2005-02-17 15:51:06.000000000 -0800
@@ -677,7 +677,7 @@
 	zholes_size[ZONE_DMA] = (top_of_ram - total_ram) >> PAGE_SHIFT;
 
 	free_area_init_node(0, &contig_page_data, zones_size,
-			    __pa(PAGE_OFFSET) >> PAGE_SHIFT, zholes_size);
+			    __pa((void *)PAGE_OFFSET) >> PAGE_SHIFT, zholes_size);
 }
 #endif /* CONFIG_NUMA */
 
--- memhotplug/drivers/acpi/Kconfig~Q-ACPI-hotplug-driver	2005-02-17 15:51:10.000000000 -0800
+++ /drivers/acpi/Kconfig	2005-02-17 15:51:10.000000000 -0800
@@ -342,4 +342,11 @@
 	 	This is the ACPI generic container driver which supports
 		ACPI0004, PNP0A05 and PNP0A06 devices
 
+config ACPI_HOTPLUG_MEMORY
+	tristate "Memory Hotplug"
+	depends on ACPI
+	depends on MEMORY_HOTPLUG
+	default m
+	help
+	  This driver adds supports for ACPI Memory Hotplug.
 endmenu
--- memhotplug/drivers/acpi/Makefile~Q-ACPI-hotplug-driver	2005-02-17 15:51:10.000000000 -0800
+++ /drivers/acpi/Makefile	2005-02-17 15:51:10.000000000 -0800
@@ -55,3 +55,4 @@
 obj-$(CONFIG_ACPI_IBM)		+= ibm_acpi.o
 obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
 obj-$(CONFIG_ACPI_BUS)		+= scan.o motherboard.o
+obj-$(CONFIG_ACPI_HOTPLUG_MEMORY)	+= acpi_memhotplug.o
--- /dev/null	2004-11-08 15:18:04.000000000 -0800
+++ /drivers/acpi/acpi_memhotplug.c	2005-02-17 15:51:10.000000000 -0800
@@ -0,0 +1,542 @@
+/*
+ * Copyright (C) 2004 Intel Corporation <naveen.b.s@intel.com>
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *
+ * ACPI based HotPlug driver that supports Memory Hotplug
+ * This driver fields notifications from firmare for memory add
+ * and remove operations and alerts the VM of the affected memory
+ * ranges.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/memory_hotplug.h>
+#include <acpi/acpi_drivers.h>
+
+
+#define ACPI_MEMORY_DEVICE_COMPONENT		0x08000000UL
+#define ACPI_MEMORY_DEVICE_CLASS		"memory"
+#define ACPI_MEMORY_DEVICE_HID			"PNP0C80"
+#define ACPI_MEMORY_DEVICE_DRIVER_NAME		"Hotplug Mem Driver"
+#define ACPI_MEMORY_DEVICE_NAME			"Hotplug Mem Device"
+
+#define _COMPONENT		ACPI_MEMORY_DEVICE_COMPONENT
+
+ACPI_MODULE_NAME		("acpi_memory")
+MODULE_AUTHOR("Naveen B S <naveen.b.s@intel.com>");
+MODULE_DESCRIPTION(ACPI_MEMORY_DEVICE_DRIVER_NAME);
+MODULE_LICENSE("GPL");
+
+/* ACPI _STA method values */
+#define ACPI_MEMORY_STA_PRESENT		(0x00000001UL)
+#define ACPI_MEMORY_STA_ENABLED		(0x00000002UL)
+#define ACPI_MEMORY_STA_FUNCTIONAL	(0x00000008UL)
+
+/* Memory Device States */
+#define MEMORY_INVALID_STATE	0
+#define MEMORY_POWER_ON_STATE	1
+#define MEMORY_POWER_OFF_STATE	2
+
+static int acpi_memory_device_add (struct acpi_device *device);
+static int acpi_memory_device_remove (struct acpi_device *device, int type);
+
+static struct acpi_driver acpi_memory_device_driver = {
+	.name =		ACPI_MEMORY_DEVICE_DRIVER_NAME,
+	.class =	ACPI_MEMORY_DEVICE_CLASS,
+	.ids =		ACPI_MEMORY_DEVICE_HID,
+	.ops =		{
+				.add =		acpi_memory_device_add,
+				.remove =	acpi_memory_device_remove,
+			},
+};
+
+struct acpi_memory_device {
+	acpi_handle handle;
+	unsigned int state;		/* State of the memory device */
+	unsigned short cache_attribute;	/* memory cache attribute */
+	unsigned short read_write_attribute;/* memory read/write attribute */
+	u64 start_addr;	/* Memory Range start physical addr */
+	u64 end_addr;	/* Memory Range end physical addr */
+};
+
+
+static int
+acpi_memory_get_device_resources(struct acpi_memory_device *mem_device)
+{
+	acpi_status status;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	struct acpi_resource *resource = NULL;
+	struct acpi_resource_address64 address64;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_get_device_resources");
+
+	/* Get the range from the _CRS */
+	status = acpi_get_current_resources(mem_device->handle, &buffer);
+	if (ACPI_FAILURE(status))
+		return_VALUE(-EINVAL);
+
+	resource = (struct acpi_resource *) buffer.pointer;
+	status = acpi_resource_to_address64(resource, &address64);
+	if (ACPI_SUCCESS(status)) {
+		if (address64.resource_type == ACPI_MEMORY_RANGE) {
+			/* Populate the structure */
+			mem_device->cache_attribute =
+				address64.attribute.memory.cache_attribute;
+			mem_device->read_write_attribute =
+			address64.attribute.memory.read_write_attribute;
+			mem_device->start_addr = address64.min_address_range;
+			mem_device->end_addr = address64.max_address_range;
+		}
+	}
+
+	acpi_os_free(buffer.pointer);
+	return_VALUE(0);
+}
+
+static int
+acpi_memory_get_device(acpi_handle handle,
+	struct acpi_memory_device **mem_device)
+{
+	acpi_status status;
+	acpi_handle phandle;
+	struct acpi_device *device = NULL;
+	struct acpi_device *pdevice = NULL;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_get_device");
+
+	if (!acpi_bus_get_device(handle, &device) && device)
+		goto end;
+
+	status = acpi_get_parent(handle, &phandle);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Error in acpi_get_parent\n"));
+		return_VALUE(-EINVAL);
+	}
+
+	/* Get the parent device */
+	status = acpi_bus_get_device(phandle, &pdevice);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Error in acpi_bus_get_device\n"));
+		return_VALUE(-EINVAL);
+	}
+
+	/*
+	 * Now add the notified device.  This creates the acpi_device
+	 * and invokes .add function
+	 */
+	status = acpi_bus_add(&device, pdevice, handle, ACPI_BUS_TYPE_DEVICE);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Error in acpi_bus_add\n"));
+		return_VALUE(-EINVAL);
+	}
+
+end:
+	*mem_device = acpi_driver_data(device);
+	if (!(*mem_device)) {
+		printk(KERN_ERR "\n driver data not found" );
+		return_VALUE(-ENODEV);
+	}
+
+	return_VALUE(0);
+}
+
+static int
+acpi_memory_check_device(struct acpi_memory_device *mem_device)
+{
+	unsigned long current_status;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_check_device");
+
+	/* Get device present/absent information from the _STA */
+	if (ACPI_FAILURE(acpi_evaluate_integer(mem_device->handle, "_STA",
+		NULL, &current_status)))
+		return_VALUE(-ENODEV);
+	/*
+	 * Check for device status. Device should be
+	 * present/enabled/functioning.
+	 */
+	if (!((current_status & ACPI_MEMORY_STA_PRESENT)
+		&& (current_status & ACPI_MEMORY_STA_ENABLED)
+		&& (current_status & ACPI_MEMORY_STA_FUNCTIONAL)))
+		return_VALUE(-ENODEV);
+
+	return_VALUE(0);
+}
+
+static int
+acpi_memory_enable_device(struct acpi_memory_device *mem_device)
+{
+	int result;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_enable_device");
+
+	/* Get the range from the _CRS */
+	result = acpi_memory_get_device_resources(mem_device);
+	if (result) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"\nget_device_resources failed\n"));
+		mem_device->state = MEMORY_INVALID_STATE;
+		return result;
+	}
+
+	/*
+	 * Tell the VM there is more memory here...
+	 * Note: Assume that this function returns zero on success
+	 */
+	result = add_memory(mem_device->start_addr,
+			(mem_device->end_addr - mem_device->start_addr) + 1,
+			mem_device->read_write_attribute);
+	if (result) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"\nadd_memory failed\n"));
+		mem_device->state = MEMORY_INVALID_STATE;
+		return result;
+	}
+
+	return result;
+}
+
+static int
+acpi_memory_powerdown_device(struct acpi_memory_device *mem_device)
+{
+	acpi_status status;
+	struct acpi_object_list	arg_list;
+	union acpi_object arg;
+	unsigned long current_status;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_powerdown_device");
+
+	/* Issue the _EJ0 command */
+	arg_list.count = 1;
+	arg_list.pointer = &arg;
+	arg.type = ACPI_TYPE_INTEGER;
+	arg.integer.value = 1;
+	status = acpi_evaluate_object(mem_device->handle,
+			"_EJ0", &arg_list, NULL);
+	/* Return on _EJ0 failure */
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,"_EJ0 failed.\n"));
+		return_VALUE(-ENODEV);
+	}
+
+	/* Evalute _STA to check if the device is disabled */
+	status = acpi_evaluate_integer(mem_device->handle, "_STA",
+		NULL, &current_status);
+	if (ACPI_FAILURE(status))
+		return_VALUE(-ENODEV);
+
+	/* Check for device status.  Device should be disabled */
+	if (current_status & ACPI_MEMORY_STA_ENABLED)
+		return_VALUE(-EINVAL);
+
+	return_VALUE(0);
+}
+
+static int
+acpi_memory_disable_device(struct acpi_memory_device *mem_device)
+{
+	int result;
+	u64 start = mem_device->start_addr;
+	u64 len = mem_device->end_addr - start + 1;
+	unsigned long attr = mem_device->read_write_attribute;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_disable_device");
+
+	/*
+	 * Ask the VM to offline this memory range.
+	 * Note: Assume that this function returns zero on success
+	 */
+	result = remove_memory(start, len, attr);
+	if (result) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Hot-Remove failed.\n"));
+		return_VALUE(result);
+	}
+
+	/* Power-off and eject the device */
+	result = acpi_memory_powerdown_device(mem_device);
+	if (result) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+					"Device Power Down failed.\n"));
+		/* Set the status of the device to invalid */
+		mem_device->state = MEMORY_INVALID_STATE;
+		return result;
+	}
+
+	mem_device->state = MEMORY_POWER_OFF_STATE;
+	return result;
+}
+
+static void
+acpi_memory_device_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct acpi_memory_device *mem_device;
+	struct acpi_device *device;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_device_notify");
+
+	switch (event) {
+	case ACPI_NOTIFY_BUS_CHECK:
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			"\nReceived BUS CHECK notification for device\n"));
+		/* Fall Through */
+	case ACPI_NOTIFY_DEVICE_CHECK:
+		if (event == ACPI_NOTIFY_DEVICE_CHECK)
+			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			"\nReceived DEVICE CHECK notification for device\n"));
+		if (acpi_memory_get_device(handle, &mem_device)) {
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				"Error in finding driver data\n"));
+			return_VOID;
+		}
+
+		if (!acpi_memory_check_device(mem_device)) {
+			if (acpi_memory_enable_device(mem_device))
+				ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				"Error in acpi_memory_enable_device\n"));
+		}
+		break;
+	case ACPI_NOTIFY_EJECT_REQUEST:
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			"\nReceived EJECT REQUEST notification for device\n"));
+
+		if (acpi_bus_get_device(handle, &device)) {
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+					"Device doesn't exist\n"));
+			break;
+		}
+		mem_device = acpi_driver_data(device);
+		if (!mem_device) {
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+					"Driver Data is NULL\n"));
+			break;
+		}
+
+		/*
+		 * Currently disabling memory device from kernel mode
+		 * TBD: Can also be disabled from user mode scripts
+		 * TBD: Can also be disabled by Callback registration
+		 * 	with generic sysfs driver
+		 */
+		if (acpi_memory_disable_device(mem_device))
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				"Error in acpi_memory_disable_device\n"));
+		/*
+		 * TBD: Invoke acpi_bus_remove to cleanup data structures
+		 */
+		break;
+	default:
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			"Unsupported event [0x%x]\n", event));
+		break;
+	}
+
+	return_VOID;
+}
+
+static int
+acpi_memory_device_add(struct acpi_device *device)
+{
+	int result;
+	struct acpi_memory_device *mem_device = NULL;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_device_add");
+
+	if (!device)
+		return_VALUE(-EINVAL);
+
+	mem_device = kmalloc(sizeof(struct acpi_memory_device), GFP_KERNEL);
+	if (!mem_device)
+		return_VALUE(-ENOMEM);
+	memset(mem_device, 0, sizeof(struct acpi_memory_device));
+
+	mem_device->handle = device->handle;
+	sprintf(acpi_device_name(device), "%s", ACPI_MEMORY_DEVICE_NAME);
+	sprintf(acpi_device_class(device), "%s", ACPI_MEMORY_DEVICE_CLASS);
+	acpi_driver_data(device) = mem_device;
+
+	/* Get the range from the _CRS */
+	result = acpi_memory_get_device_resources(mem_device);
+	if (result) {
+		kfree(mem_device);
+		return_VALUE(result);
+	}
+
+	/* Set the device state */
+	mem_device->state = MEMORY_POWER_ON_STATE;
+
+	printk(KERN_INFO "%s \n", acpi_device_name(device));
+
+	return_VALUE(result);
+}
+
+static int
+acpi_memory_device_remove (struct acpi_device *device, int type)
+{
+	struct acpi_memory_device *mem_device = NULL;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_device_remove");
+
+	if (!device || !acpi_driver_data(device))
+		return_VALUE(-EINVAL);
+
+	mem_device = (struct acpi_memory_device *) acpi_driver_data(device);
+	kfree(mem_device);
+
+	return_VALUE(0);
+}
+
+/*
+ * Helper function to check for memory device
+ */
+static acpi_status
+is_memory_device(acpi_handle handle)
+{
+	char *hardware_id;
+	acpi_status status;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	struct acpi_device_info *info;
+
+	ACPI_FUNCTION_TRACE("is_memory_device");
+
+	status = acpi_get_object_info(handle, &buffer);
+	if (ACPI_FAILURE(status))
+		return_ACPI_STATUS(AE_ERROR);
+
+	info = buffer.pointer;
+	if (!(info->valid & ACPI_VALID_HID)) {
+		acpi_os_free(buffer.pointer);
+		return_ACPI_STATUS(AE_ERROR);
+	}
+
+	hardware_id = info->hardware_id.value;
+	if ((hardware_id == NULL) ||
+		(strcmp(hardware_id, ACPI_MEMORY_DEVICE_HID)))
+		status = AE_ERROR;
+
+	acpi_os_free(buffer.pointer);
+	return_ACPI_STATUS(status);
+}
+
+static acpi_status
+acpi_memory_register_notify_handler (acpi_handle handle,
+	u32 level, void *ctxt, void **retv)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_register_notify_handler");
+
+	status = is_memory_device(handle);
+	if (ACPI_FAILURE(status))
+		return_ACPI_STATUS(AE_OK);	/* continue */
+
+	status = acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
+			acpi_memory_device_notify, NULL);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Error installing notify handler\n"));
+		return_ACPI_STATUS(AE_OK);	/* continue */
+	}
+
+	return_ACPI_STATUS(status);
+}
+
+static acpi_status
+acpi_memory_deregister_notify_handler (acpi_handle handle,
+			       u32 level, void *ctxt, void **retv)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_deregister_notify_handler");
+
+	status = is_memory_device(handle);
+	if (ACPI_FAILURE(status))
+		return_ACPI_STATUS(AE_OK);	/* continue */
+
+	status = acpi_remove_notify_handler(handle,
+			ACPI_SYSTEM_NOTIFY, acpi_memory_device_notify);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				"Error removing notify handler\n"));
+		return_ACPI_STATUS(AE_OK);	/* continue */
+	}
+
+	return_ACPI_STATUS(status);
+}
+
+static int __init
+acpi_memory_device_init (void)
+{
+	int result;
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_device_init");
+
+	result = acpi_bus_register_driver(&acpi_memory_device_driver);
+
+	if (result < 0)
+		return_VALUE(-ENODEV);
+
+	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+				ACPI_UINT32_MAX,
+				acpi_memory_register_notify_handler,
+				NULL, NULL);
+
+	if (ACPI_FAILURE (status)) {
+		ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "walk_namespace failed\n"));
+		acpi_bus_unregister_driver(&acpi_memory_device_driver);
+		return_VALUE(-ENODEV);
+	}
+
+	return_VALUE(0);
+}
+
+static void __exit
+acpi_memory_device_exit (void)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_device_exit");
+
+	/*
+	 * Adding this to un-install notification handlers for all the device
+	 * handles.
+	 */
+	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+			ACPI_UINT32_MAX,
+			acpi_memory_deregister_notify_handler,
+			NULL, NULL);
+
+	if (ACPI_FAILURE (status))
+		ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "walk_namespace failed\n"));
+
+	acpi_bus_unregister_driver(&acpi_memory_device_driver);
+
+	return_VOID;
+}
+
+module_init(acpi_memory_device_init);
+module_exit(acpi_memory_device_exit);
+
+
--- memhotplug/drivers/base/Makefile~L1-sysfs-memory-class	2005-02-17 15:51:08.000000000 -0800
+++ /drivers/base/Makefile	2005-02-17 15:51:08.000000000 -0800
@@ -7,6 +7,7 @@
 obj-y			+= power/
 obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
 obj-$(CONFIG_NUMA)	+= node.o
+obj-$(CONFIG_MEMORY_HOTPLUG) += memory.o
 
 ifeq ($(CONFIG_DEBUG_DRIVER),y)
 EXTRA_CFLAGS += -DDEBUG
--- memhotplug/drivers/base/init.c~L1-sysfs-memory-class	2005-02-17 15:51:08.000000000 -0800
+++ /drivers/base/init.c	2005-02-17 15:51:08.000000000 -0800
@@ -9,6 +9,7 @@
 
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/memory.h>
 
 extern int devices_init(void);
 extern int buses_init(void);
@@ -39,5 +40,6 @@
 	platform_bus_init();
 	system_bus_init();
 	cpu_dev_init();
+	memory_dev_init();
 	attribute_container_init();
 }
--- /dev/null	2004-11-08 15:18:04.000000000 -0800
+++ /drivers/base/memory.c	2005-02-17 15:51:10.000000000 -0800
@@ -0,0 +1,525 @@
+/*
+ * drivers/base/memory.c - basic Memory class support
+ */
+
+#include <linux/sysdev.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/sched.h>	/* capable() */
+#include <linux/topology.h>
+#include <linux/device.h>
+#include <linux/memory.h>
+#include <linux/kobject.h>
+#include <linux/memory_hotplug.h>
+#include <linux/mm.h>
+#include <asm/atomic.h>
+#include <asm/uaccess.h>
+
+#define MEMORY_CLASS_NAME	"memory"
+
+struct sysdev_class memory_sysdev_class = {
+	set_kset_name(MEMORY_CLASS_NAME),
+};
+EXPORT_SYMBOL(memory_sysdev_class);
+
+/*
+ * With these ops structures, we can override actions for things
+ * like merging or splitting
+ */
+static int memory_hotplug_filter(struct kset *kset, struct kobject *kobj)
+{
+/*	struct kobj_type *ktype = get_ktype(kobj); */
+	return 1;
+}
+
+static char *memory_hotplug_name(struct kset *kset, struct kobject *kobj)
+{
+	return MEMORY_CLASS_NAME;
+}
+
+static int memory_hotplug(struct kset *kset, struct kobject *kobj, char **envp,
+			int num_envp, char *buffer, int buffer_size)
+{
+	int retval = 0;
+
+	return retval;
+}
+
+static struct kset_hotplug_ops memory_hotplug_ops = {
+	.filter = memory_hotplug_filter,
+	.name	= memory_hotplug_name,
+	.hotplug	= memory_hotplug,
+};
+
+
+/*
+ * register_memory - Setup a sysfs device for a memory block
+ */
+int
+register_memory(struct memory_block *memory, struct mem_section *section,
+		struct node *root)
+{
+	int error;
+
+	memory->sysdev.cls = &memory_sysdev_class;
+	memory->sysdev.id = __section_nr(section);
+
+	error = sysdev_register(&memory->sysdev);
+
+	if (root && !error)
+		error = sysfs_create_link(&root->sysdev.kobj,
+					  &memory->sysdev.kobj,
+					  kobject_name(&memory->sysdev.kobj));
+
+	return error;
+}
+
+void
+unregister_memory(struct memory_block *memory, struct mem_section *section,
+		struct node *root)
+{
+	BUG_ON(memory->sysdev.cls != &memory_sysdev_class);
+	BUG_ON(memory->sysdev.id != __section_nr(section));
+
+	sysdev_unregister(&memory->sysdev);
+	if (root)
+		sysfs_remove_link(&root->sysdev.kobj, kobject_name(&memory->sysdev.kobj));
+}
+
+/*
+ * use this as the physical section index that this memsection
+ * uses.
+ */
+
+static ssize_t show_mem_phys_index(struct sys_device *dev, char *buf)
+{
+	struct memory_block *mem =
+		container_of(dev, struct memory_block, sysdev);
+	return sprintf(buf, "%08lx\n", mem->phys_index);
+}
+
+/*
+ * online, offline, going offline, etc.
+ */
+static ssize_t show_mem_state(struct sys_device *dev, char *buf)
+{
+	struct memory_block *mem =
+		container_of(dev, struct memory_block, sysdev);
+	ssize_t len = 0;
+
+	/*
+	 * We can probably put these states in a nice little array
+	 * so that they're not open-coded
+	 */
+	switch (mem->state) {
+		case MEM_ONLINE:
+			len = sprintf(buf, "online\n");
+			break;
+		case MEM_OFFLINE:
+			len = sprintf(buf, "offline\n");
+			break;
+		case MEM_GOING_OFFLINE:
+			len = sprintf(buf, "going-offline\n");
+			break;
+		case MEM_INVALID:
+			len = sprintf(buf, "invalid\n");
+			break;
+		default:
+			len = sprintf(buf, "ERROR\n");
+			break;
+	}
+
+	return len;
+}
+
+#ifdef CONFIG_SPARSEMEM
+/* this can't stay here.  it needs to go into nonlinear.c or something */
+static int
+memory_block_action(struct memory_block *mem, unsigned long action)
+{
+	int i;
+	unsigned long psection;
+	unsigned long start_pfn, start_paddr;
+	struct page *first_page;
+	int ret;
+	int old_state = mem->state;
+
+	/*
+	 * this eventually needs to be a loop so that a memory_block
+	 * can contain more than a single section
+	 */
+	psection = mem->phys_index; //pfn_to_section()??
+	first_page = pfn_to_page(psection << PFN_SECTION_SHIFT);
+	printk(KERN_DEBUG "%s()\n"
+	       KERN_DEBUG "\tpsection: %ld\n"
+	       KERN_DEBUG "\tfirst_page: %p\n"
+	       KERN_DEBUG "\tphys_index: %08lx\n",
+		__func__, psection, first_page, mem->phys_index);
+	for (i = 0; i < PAGES_PER_SECTION; i++) {
+		if ((action == MEM_ONLINE) && !PageReserved(first_page+i)) {
+			printk(KERN_WARNING "%s: section number %ld page number %d "
+				"not reserved, was it already online? \n",
+				__func__, psection, i);
+			return -EBUSY;
+		}
+	}
+
+	switch (action) {
+		case MEM_ONLINE:
+			start_pfn = page_to_pfn(first_page);
+			ret = online_pages(start_pfn, PAGES_PER_SECTION);
+			break;
+		case MEM_OFFLINE:
+			mem->state = MEM_GOING_OFFLINE;
+			start_paddr = page_to_pfn(first_page) <<PAGE_SHIFT;
+			ret = remove_memory(start_paddr, PAGES_PER_SECTION<<PAGE_SHIFT, 0);
+			printk(KERN_DEBUG "%s(%p, %ld) remove_memory() res: %d\n",
+					__func__, mem, action, ret);
+			if (ret)
+				mem->state = old_state;
+			break;
+		default:
+			printk(KERN_WARNING "%s(%p, %ld) unknown action: %ld\n", __func__,
+				mem, action, action);
+			ret = -EINVAL;
+	}
+
+	return ret;
+}
+#else
+static int
+memory_block_action(struct memory_block *mem, unsigned long action)
+{
+	printk(KERN_WARNING "%s() failed to perform action: %d, SPAARSE is "
+			"compiled out\n", __FUNCTION__, action);
+	return -ENOSYS;
+}
+#endif
+
+/*
+ * These to_state and from_state things really are just state
+ * machine changes.  It might just be better to declare them
+ * all in a table instead of in code like this.
+ */
+static int memory_block_change_state(struct memory_block *mem,
+		unsigned long to_state, unsigned long from_state_req)
+{
+	int ret = 0;
+	down(&mem->state_sem);
+
+	if (mem->state != from_state_req) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = memory_block_action(mem, to_state);
+	if (!ret)
+		mem->state = to_state;
+
+out:
+	up(&mem->state_sem);
+	return ret;
+}
+
+static ssize_t
+store_mem_state(struct sys_device *dev, const char *buf, size_t count)
+{
+	struct memory_block *mem =
+		container_of(dev, struct memory_block, sysdev);
+	unsigned int phys_section_nr = mem->phys_index;
+	int ret = -EINVAL;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	if (!valid_section_nr(phys_section_nr)) {
+		printk(KERN_DEBUG "%s: section (%d) is not valid\n",
+			__func__, phys_section_nr);
+		goto out;
+	}
+
+	if (!strncmp(buf, "online", min((int)count, 6)))
+		ret = memory_block_change_state(mem, MEM_ONLINE, MEM_OFFLINE);
+	else if(!strncmp(buf, "offline", min((int)count, 7)))
+		ret = memory_block_change_state(mem, MEM_OFFLINE, MEM_ONLINE);
+
+out:
+	if (ret)
+		return ret;
+	return count;
+}
+
+/*
+ * phys_device is a bad name for this.  What I really want
+ * is a way to differentiate between memory ranges that
+ * are part of physical devices that constitute
+ * a complete removable unit or fru.
+ * i.e. do these ranges belong to the same physical device,
+ * s.t. if I offline all of these sections I can then
+ * remove the physical device?
+ */
+static ssize_t show_phys_device(struct sys_device *dev, char *buf)
+{
+	struct memory_block *mem =
+		container_of(dev, struct memory_block, sysdev);
+	return sprintf(buf, "%d\n", mem->phys_device);
+}
+
+SYSDEV_ATTR(phys_index, 0444, show_mem_phys_index, NULL);
+SYSDEV_ATTR(state, 0644, show_mem_state, store_mem_state);
+SYSDEV_ATTR(phys_device, 0444, show_phys_device, NULL);
+
+#define mem_create_simple_file(mem, attr_name)	\
+	sysdev_create_file(&mem->sysdev, &attr_##attr_name)
+#define mem_remove_simple_file(mem, attr_name)	\
+	sysdev_remove_file(&mem->sysdev, &attr_##attr_name)
+
+/*
+ * Block size attribute stuff
+ */
+
+static ssize_t
+print_block_size(struct class *class, char *buf)
+{
+	return sprintf(buf, "%lx\n", (unsigned long)PAGES_PER_SECTION*PAGE_SIZE);
+}
+
+static CLASS_ATTR(block_size_bytes, 0444, print_block_size, NULL);
+
+static int block_size_init(void)
+{
+	sysfs_create_file(&memory_sysdev_class.kset.kobj,
+		&class_attr_block_size_bytes.attr);
+	return 0;
+}
+
+/*
+ * All the probe stuff here
+ */
+
+extern int page_is_hotpluggable_ram(unsigned long pfn);
+/* define this off in some header somewhere ... */
+#ifdef CONFIG_ARCH_MEMORY_PROBE
+static ssize_t
+memory_probe_store(struct class *class, const char __user *buf, size_t count)
+{
+	u64 phys_addr;
+	unsigned long offset;
+	int ret;
+	/*
+	 * Hmmm... what do we really want this to do?
+	 */
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	phys_addr = simple_strtoull(buf, NULL, 0);
+
+	// a hardware check for the ram?
+	for (offset = 0; offset < PAGES_PER_SECTION; offset++) {
+		unsigned long page_nr = (phys_addr >> PAGE_SHIFT) + offset;
+		if (page_is_hotpluggable_ram(page_nr))
+			break;
+	}
+	if (offset == PAGES_PER_SECTION)
+		return -EINVAL;
+
+	ret = add_memory(phys_addr, (PAGES_PER_SECTION << PAGE_SHIFT), 0);
+
+	if (ret)
+		count = ret;
+
+	return count;
+}
+static CLASS_ATTR(probe, 0700, NULL, memory_probe_store);
+
+static int memory_probe_init(void)
+{
+	sysfs_create_file(&memory_sysdev_class.kset.kobj,
+		&class_attr_probe.attr);
+	return 0;
+}
+#else
+#define memory_probe_init(...) (1)
+#endif
+
+/*
+ * Note that phys_device is optional.  It is here to allow for
+ * differentiation between which *physical* devices each
+ * section belongs to...
+ */
+
+int add_memory_block(unsigned long node_id, struct mem_section *section,
+		     unsigned long state, int phys_device)
+{
+	size_t size = sizeof(struct memory_block);
+	struct memory_block *mem = kmalloc(size, GFP_KERNEL);
+	int ret = 0;
+
+	if (!mem)
+		return -ENOMEM;
+
+	memset(mem, 0, size);
+
+	mem->phys_index = __section_nr(section);
+	mem->state = state;
+	init_MUTEX(&mem->state_sem);
+	mem->phys_device = phys_device;
+
+#if 0
+	/* not yet sure how this can be optimally structured
+	 * to get the fru information from hw/fw specific drivers
+	 */
+	if (mem->callback)
+		callback(mem);
+#endif
+
+	ret = register_memory(mem, section, NULL);
+	if (!ret)
+		ret = mem_create_simple_file(mem, phys_index);
+	if (!ret)
+		ret = mem_create_simple_file(mem, state);
+	if (!ret)
+		ret = mem_create_simple_file(mem, phys_device);
+
+	return ret;
+}
+
+#define online_section(...) 	do {} while(0)
+
+static ssize_t
+online_store(struct class *class, const char *buf, size_t count)
+{
+	unsigned int section = simple_strtoul(buf, NULL, 10);
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	if (valid_section(&mem_section[section])) {
+		printk(KERN_WARNING "memory state store: section %d is "
+				    "not currently mapped\n", section);
+		return -EINVAL;
+	}
+
+	/*
+	 * Crude section based onlining; probably need random
+	 * address onlining...
+	 */
+	online_section(section);
+
+	return count;
+}
+static CLASS_ATTR(online, 0700, NULL, online_store);
+
+static int online_init(void)
+{
+	sysfs_create_file(&memory_sysdev_class.kset.kobj,
+		&class_attr_online.attr);
+	return 0;
+}
+
+/*
+ * For now, we have a linear search to go find the appropriate
+ * memory_block corresponding to a particular phys_index. If
+ * this gets to be a real problem, we can always use a radix
+ * tree or something here.
+ *
+ * This could be made generic for all sysdev classes.
+ */
+struct memory_block *find_memory_block(struct mem_section *section)
+{
+	struct kobject *kobj;
+	struct sys_device *sysdev;
+	struct memory_block *mem;
+	char name[sizeof(MEMORY_CLASS_NAME) + 9 + 1];
+
+	/*
+	 * This only works because we know that section == sysdev->id
+	 * slightly redundant with sysdev_register()
+	 */
+	sprintf(&name[0], "%s%d", MEMORY_CLASS_NAME, __section_nr(section));
+	printk(KERN_DEBUG "%s() looking for name: \"%s\"\n", __func__, name);
+
+	kobj = kset_find_obj(&memory_sysdev_class.kset, name);
+	if (!kobj)
+		return NULL;
+
+	sysdev = container_of(kobj, struct sys_device, kobj);
+	mem = container_of(sysdev, struct memory_block, sysdev);
+
+	return mem;
+}
+
+int remove_memory_block(unsigned long node_id, struct mem_section *section,
+		int phys_device)
+{
+	struct memory_block *mem;
+
+	mem = find_memory_block(section);
+
+#if 0
+	/* not yet sure how this can be optimally structured
+	 * to get the fru information from hw/fw specific drivers
+	 */
+	if (mem->callback)
+		callback(mem);
+#endif
+
+	mem_remove_simple_file(mem, phys_index);
+	mem_remove_simple_file(mem, state);
+	mem_remove_simple_file(mem, phys_device);
+	unregister_memory(mem, section, NULL);
+
+	return 0;
+}
+
+/*
+ * need an interface for the VM to add new memory regions,
+ * but without onlining it.
+ */
+int register_new_memory(struct mem_section *section)
+{
+	printk(KERN_DEBUG "%s(%p)\n", __func__, section);
+
+	/* need some node info here and some sort of callback .... */
+	return add_memory_block(0, section, MEM_OFFLINE, 0);
+}
+
+int unregister_memory_section(struct mem_section *section)
+{
+	if (!valid_section(section)) {
+		printk(KERN_WARNING "%s: section %d is already invalid\n",
+					__func__, __section_nr(section));
+		return -EINVAL;
+	}
+
+	/* need some node info here and some sort of callback .... */
+	return remove_memory_block(0, section, 0);
+}
+
+/*
+ * Initialize the sysfs support for memory devices...
+ */
+int __init memory_dev_init(void)
+{
+	unsigned int i;
+	int ret;
+
+	memory_sysdev_class.kset.hotplug_ops = &memory_hotplug_ops;
+	ret = sysdev_class_register(&memory_sysdev_class);
+
+	/*
+	 * Create entries for memory sections that were found
+	 * during boot and have been initialized
+	 */
+	for (i = 0; i < NR_MEM_SECTIONS; i++) {
+		if (!valid_section_nr(i))
+			break;
+		add_memory_block(0, &mem_section[i], MEM_ONLINE, 0);
+	}
+
+	memory_probe_init();
+	block_size_init();
+	online_init();
+
+	return ret;
+}
--- memhotplug/include/asm-i386/highmem.h~L1-sysfs-memory-class	2005-02-17 15:51:08.000000000 -0800
+++ /include/asm-i386/highmem.h	2005-02-17 15:51:08.000000000 -0800
@@ -65,6 +65,7 @@
 
 extern void * FASTCALL(kmap_high(struct page *page));
 extern void FASTCALL(kunmap_high(struct page *page));
+extern void flush_all_zero_pkmaps(void);
 
 void *kmap(struct page *page);
 void kunmap(struct page *page);
--- memhotplug/include/linux/highmem.h~L1-sysfs-memory-class	2005-02-17 15:51:08.000000000 -0800
+++ /include/linux/highmem.h	2005-02-17 15:51:08.000000000 -0800
@@ -29,6 +29,7 @@
 #define kmap_atomic(page, idx)		page_address(page)
 #define kunmap_atomic(addr, idx)	do { } while (0)
 #define kmap_atomic_to_page(ptr)	virt_to_page(ptr)
+#define flush_all_zero_pkmaps()		do { } while (0)
 
 #endif /* CONFIG_HIGHMEM */
 
--- /dev/null	2004-11-08 15:18:04.000000000 -0800
+++ /include/linux/memory.h	2005-02-17 15:51:10.000000000 -0800
@@ -0,0 +1,78 @@
+/*
+ * include/linux/memory.h - generic memory definition
+ *
+ * This is mainly for topological representation. We define the
+ * basic "struct memory_block" here, which can be embedded in per-arch
+ * definitions or NUMA information.
+ *
+ * Basic handling of the devices is done in drivers/base/memory.c
+ * and system devices are handled in drivers/base/sys.c.
+ *
+ * Memory block are exported via sysfs in the class/memory/devices/
+ * directory.
+ *
+ */
+#ifndef _LINUX_MEMORY_H_
+#define _LINUX_MEMORY_H_
+
+#include <linux/sysdev.h>
+#include <linux/node.h>
+#include <linux/compiler.h>
+
+#include <asm/semaphore.h>
+
+struct memory_block {
+	unsigned long phys_index;
+	unsigned long state;
+	struct semaphore state_sem;
+	int phys_device;		/* to which fru does this belong? */
+	void *hw;			/* optional pointer to fw/hw data */
+	int (*phys_callback)(struct memory_block *);
+	struct sys_device sysdev;
+};
+
+#ifndef CONFIG_MEMORY_HOTPLUG
+static inline int memory_dev_init(void)
+{
+	return 0;
+}
+#else
+extern int register_memory(struct memory_block *, struct mem_section *section, struct node *);
+extern int register_new_memory(struct mem_section *);
+extern int unregister_memory_section(struct mem_section *);
+extern int memory_dev_init(void);
+#endif
+
+#ifndef CONFIG_SPARSEMEM
+#define CONFIG_MEM_BLOCK_SIZE	(1<<27)
+#else /* tie this to nonlinear */
+#define CONFIG_MEM_BLOCK_SIZE	(PAGES_PER_SECTION<<PAGE_SHIFT)
+#endif
+
+#define CONFIG_ARCH_MEMORY_PROBE 1
+
+#define	MEM_ONLINE		(1<<0)
+#define	MEM_OFFLINE		(1<<1)
+#define	MEM_GOING_OFFLINE	(1<<2)
+#define MEM_INVALID		(1<<3)
+#define MEM_BROKEN		(1<<4)
+
+extern int invalidate_phys_mapping(unsigned long, unsigned long);
+extern int hot_add_zone_init(struct zone *zone, unsigned long phys_start_pfn, unsigned long size_pages);
+struct notifier_block;
+
+extern int register_memory_notifier(struct notifier_block *nb);
+extern void unregister_memory_notifier(struct notifier_block *nb);
+
+extern struct sysdev_class memory_sysdev_class;
+extern struct semaphore memory_sem;
+
+#define lock_memory_hotplug()	down(&memory_sem)
+#define unlock_memory_hotplug()	up(&memory_sem)
+#define lock_memory_hotplug_interruptible() down_interruptible(&memory_sem)
+#define hot_memory_notifier(fn, pri) {				\
+	static struct notifier_block fn##_nb = { fn, pri };	\
+	register_memory_notifier(&fn##_nb);			\
+}
+
+#endif /* _LINUX_MEMORY_H_ */
--- /dev/null	2004-11-08 15:18:04.000000000 -0800
+++ /include/linux/memory_hotplug.h	2005-02-17 15:51:08.000000000 -0800
@@ -0,0 +1,41 @@
+#ifndef __MEMORY_HOTPLUG_H
+#define __MEMORY_HOTPLUG_H
+
+extern int zone_grow_free_lists(struct zone *zone, unsigned long new_nr_pages);
+extern int zone_grow_waitqueues(struct zone *zone, unsigned long nr_pages);
+extern int add_one_highpage(struct page *page, int pfn, int bad_ppro);
+/* need some defines for these for archs that don't support it */
+extern void online_page(struct page *page);
+/* VM interface that may be used by firmware interface */
+extern int add_memory(u64 start, u64 size, unsigned long attr);
+extern int remove_memory(u64 start, u64 size, unsigned long attr);
+extern int online_pages(unsigned long, unsigned long);
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+/* reasonably generic interface to expand the physical pages in a zone  */
+extern int __add_pages(struct zone *zone, unsigned long start_pfn,
+	unsigned long nr_pages, unsigned long attr);
+extern int __remove_pages(struct zone *zone, unsigned long start_pfn,
+	unsigned long nr_pages, unsigned long attr);
+#else
+static inline int mhp_notimplemented(char *func)
+{
+	printk(KERN_WARNING "%s() called, with CONFIG_MEMORY_HOTPLUG disabled\n", __func__);
+	dump_stack();
+	return -ENOSYS;
+}
+
+static inline int __add_pages(struct zone *zone, unsigned long start_pfn,
+	unsigned long nr_pages, unsigned long attr)
+{
+	return mhp_notimplemented(__FUNCTION__);
+}
+static inline int __remove_pages(struct zone *zone, unsigned long start_pfn,
+	unsigned long nr_pages, unsigned long attr)
+{
+	return mhp_notimplemented(__FUNCTION__);
+}
+
+#endif /* CONFIG_MEMORY_HOTPLUG */
+
+#endif
--- memhotplug/include/linux/mmzone.h~J-zone_resize_sem	2005-02-17 15:51:08.000000000 -0800
+++ /include/linux/mmzone.h	2005-02-17 15:51:09.000000000 -0800
@@ -12,6 +12,7 @@
 #include <linux/threads.h>
 #include <linux/numa.h>
 #include <asm/atomic.h>
+#include <asm/semaphore.h>
 
 /* Free memory management - zoned buddy allocator.  */
 #ifndef CONFIG_FORCE_MAX_ZONEORDER
@@ -204,6 +205,7 @@
 
 	unsigned long		spanned_pages;	/* total size, including holes */
 	unsigned long		present_pages;	/* amount of memory (excluding holes) */
+	struct semaphore	resize_sem;
 
 	/*
 	 * rarely used fields:
@@ -277,6 +279,7 @@
 void wakeup_kswapd(struct zone *zone, int order);
 int zone_watermark_ok(struct zone *z, int order, unsigned long mark,
 		int alloc_type, int can_try_harder, int gfp_high);
+void setup_per_zone_pages_min(void);
 
 /*
  * zone_idx() returns 0 for the ZONE_DMA zone, 1 for the ZONE_NORMAL zone, etc.
@@ -472,16 +475,25 @@
 	return (section->section_mem_map & SECTION_HAS_MEM_MAP);
 }
 
+static inline int valid_section_nr(int nr)
+{
+	return valid_section(&mem_section[nr]);
+}
+
 /*
  * Given a kernel address, find the home node of the underlying memory.
  */
 #define kvaddr_to_nid(kaddr)	pfn_to_nid(__pa(kaddr) >> PAGE_SHIFT)
-
 static inline struct mem_section *__pfn_to_section(unsigned long pfn)
 {
 	return &mem_section[pfn >> PFN_SECTION_SHIFT];
 }
 
+static inline int __section_nr(struct mem_section* ms)
+{
+	return ms - &mem_section[0];
+}
+
 #define pfn_to_page(pfn) 						\
 ({ 									\
 	unsigned long __pfn = (pfn);					\
--- memhotplug/mm/Kconfig~L1-sysfs-memory-class	2005-02-17 15:51:08.000000000 -0800
+++ /mm/Kconfig	2005-02-17 15:51:10.000000000 -0800
@@ -1,3 +1,7 @@
+config MEMORY_HOTPLUG
+	bool "Allow for memory hot-add"
+	depends on SPARSEMEM && HOTPLUG
+
 choice
 	prompt "Memory model"
 	default SPARSEMEM if ARCH_SPARSEMEM_DEFAULT
@@ -16,4 +20,7 @@
 
 endchoice
 
+config SIMULATED_MEM_HOTPLUG
+	bool "Simulate memory hotplug on non-hotplug hardware"
+	depends on X86 && !X86_64
 
--- memhotplug/mm/Makefile~L1-sysfs-memory-class	2005-02-17 15:51:08.000000000 -0800
+++ /mm/Makefile	2005-02-17 15:51:08.000000000 -0800
@@ -18,4 +18,5 @@
 obj-$(CONFIG_SPARSEMEM)	+= sparse.o
 obj-$(CONFIG_SHMEM) += shmem.o
 obj-$(CONFIG_TINY_SHMEM) += tiny-shmem.o
+obj-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
 
--- memhotplug/mm/highmem.c~L1-sysfs-memory-class	2005-02-17 15:51:08.000000000 -0800
+++ /mm/highmem.c	2005-02-17 15:51:08.000000000 -0800
@@ -59,7 +59,7 @@
 
 static DECLARE_WAIT_QUEUE_HEAD(pkmap_map_wait);
 
-static void flush_all_zero_pkmaps(void)
+void flush_all_zero_pkmaps(void)
 {
 	int i;
 
--- /dev/null	2004-11-08 15:18:04.000000000 -0800
+++ /mm/memory_hotplug.c	2005-02-17 15:51:10.000000000 -0800
@@ -0,0 +1,222 @@
+/*
+ *  linux/mm/memory_hotplug.c
+ *
+ *  Copyright (C)
+ */
+
+#include <linux/config.h>
+#include <linux/stddef.h>
+#include <linux/mm.h>
+#include <linux/swap.h>
+#include <linux/interrupt.h>
+#include <linux/pagemap.h>
+#include <linux/bootmem.h>
+#include <linux/compiler.h>
+#include <linux/module.h>
+#include <linux/pagevec.h>
+#include <linux/slab.h>
+#include <linux/sysctl.h>
+#include <linux/cpu.h>
+#include <linux/memory.h>
+#include <linux/memory_hotplug.h>
+#include <linux/highmem.h>
+
+#include <asm/tlbflush.h>
+
+static struct page *__kmalloc_section_memmap(unsigned long nr_pages)
+{
+	struct page *page, *ret;
+	unsigned long memmap_size = sizeof(struct page) * nr_pages;
+
+	page = alloc_pages(GFP_KERNEL, get_order(memmap_size));
+	if (page)
+		goto got_map_page;
+
+	ret = vmalloc(memmap_size);
+	if (ret)
+		goto got_map_ptr;
+
+	return NULL;
+got_map_page:
+	ret = (struct page *)pfn_to_kaddr(page_to_pfn(page));
+got_map_ptr:
+	memset(ret, 0, memmap_size);
+
+	return ret;
+}
+
+extern int sparse_add_one_section(int, int, struct page *); /* FIXME header*/
+void zonetable_add(struct zone *zone, int nid, int zid, unsigned long pfn, unsigned long size);
+int __add_section(struct zone *zone, unsigned long phys_start_pfn,
+		  unsigned long attr)
+{
+	struct pglist_data *pgdat = zone->zone_pgdat;
+	int nr_pages = PAGES_PER_SECTION;
+	struct page *memmap;
+	int zone_type;
+	int nid = 0;
+	int ret;
+
+	printk(KERN_DEBUG "%s(%p, %08lx, %08lx)\n", __func__, zone,
+		phys_start_pfn, attr);
+
+	/*
+	 * don't check this for failure because it is possible that the
+	 * section already has a mem_map.  The sparse code will fix this up
+	 */
+	memmap = __kmalloc_section_memmap(nr_pages);
+
+	down(&zone->resize_sem);
+
+	printk(KERN_DEBUG "%s() phys_start_pfn: %08lx\n", __func__, phys_start_pfn);
+	ret = sparse_add_one_section(phys_start_pfn, nr_pages, memmap);
+
+	if (ret <= 0) {
+		/* the mem_map didn't get used */
+		if (memmap >= (struct page *)VMALLOC_START &&
+		    memmap < (struct page *)VMALLOC_END)
+			vfree(memmap);
+		else
+			free_pages((unsigned long)memmap,
+				   get_order(sizeof(struct page) * nr_pages));
+	}
+
+	if (zone->zone_start_pfn > phys_start_pfn) {
+		zone->spanned_pages += zone->zone_start_pfn - phys_start_pfn;
+		zone->zone_start_pfn = phys_start_pfn;
+	}
+	if (phys_start_pfn + nr_pages > zone->zone_start_pfn + zone->spanned_pages) {
+		zone->spanned_pages = (phys_start_pfn + nr_pages) -
+					zone->zone_start_pfn;
+	}
+
+	hot_add_zone_init(zone, phys_start_pfn, PAGES_PER_SECTION);
+
+	up(&zone->resize_sem);
+
+	if (ret < 0) {
+		printk(KERN_WARNING "%s(): error onlining section: %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	zone_type = zone - pgdat->node_zones;
+	memmap_init_zone(nr_pages, nid, zone_type, phys_start_pfn);
+	zonetable_add(zone, nid, zone_type, phys_start_pfn, nr_pages);
+
+	/*
+	 * Actually, we don't want to online the pages here at all.  We
+	 * will enable the new regions to be available via sysfs and thus
+	 * onlined from user space.
+	 */
+	{
+		struct mem_section *ms = __pfn_to_section(phys_start_pfn);
+		register_new_memory(ms);
+	}
+
+	return 0;
+}
+
+/*
+ * Reasonably generic function for adding memory.  It is
+ * expected that archs that support memory hotplug will
+ * call this function after deciding the zone to which to
+ * add the new pages.
+ */
+int __add_pages(struct zone *zone, unsigned long phys_start_pfn,
+		 unsigned long nr_pages, unsigned long attr)
+{
+	unsigned long i;
+	int err = 0;
+
+	printk(KERN_DEBUG "%s(%p, %08lx, %ld, %08lx)\n", __func__,
+			zone, phys_start_pfn, nr_pages, attr);
+
+	for (i = 0; i < nr_pages; i += PAGES_PER_SECTION) {
+		 printk(KERN_DEBUG "\tfor: i: %ld\n", i);
+		 err = __add_section(zone, phys_start_pfn + i, attr);
+
+		 if (err)
+			break;
+	}
+
+	/*
+	 * Should we back the ones out that succeeded if any part of
+	 * the addition fails?
+	 */
+
+	return err;
+}
+
+#ifdef CONFIG_SIMULATED_MEM_HOTPLUG
+int page_is_hotpluggable_ram(unsigned long pfn)
+{
+	extern struct e820map bios_e820;
+	extern int page_is_ram_e820(unsigned long, struct e820map*);
+
+	return page_is_ram_e820(pfn, &bios_e820);
+}
+#else
+int page_is_hotpluggable_ram(unsigned long pfn)
+{
+	return 1;
+}
+#endif
+
+int online_pages(unsigned long pfn, unsigned long nr_pages)
+{
+	int i;
+
+	printk(KERN_DEBUG "%s: onlining 0x%lx pages starting from pfn: 0x%lx\n",
+		__func__, nr_pages, pfn);
+
+	for (i = 0; i < nr_pages; i++) {
+		struct page *page = pfn_to_page(pfn + i);
+
+		if (page_is_hotpluggable_ram(pfn + i))
+			online_page(page);
+	}
+
+	page_zone(pfn_to_page(pfn))->present_pages += nr_pages;
+
+	setup_per_zone_pages_min();
+
+	return 0;
+}
+
+extern void flush_all_zero_pkmaps(void);
+int __remove_pages(struct zone *zone, unsigned long start_pfn,
+		unsigned long nr_pages, unsigned long attr)
+{
+	int order = get_order(nr_pages<<PAGE_SHIFT);
+	struct mem_section *ms = __pfn_to_section(start_pfn);
+	/*
+	 * for now, only handle 2^x sized areas
+	 */
+	if (nr_pages != 1<<order)
+		return -EINVAL;
+
+#ifdef CONFIG_MEMORY_REMOVE
+	if (capture_page_range(start_pfn, order)) {
+		printk(KERN_WARNING "%s(): failed to capture page range: %ld -> %ld\n",
+				__func__, start_pfn, start_pfn + nr_pages);
+
+		return -EAGAIN;
+	}
+#else
+	return -EINVAL;
+#endif
+
+	unregister_memory_section(ms);
+
+	/*
+	 * Permanent kmaps keep ptes to a page long after a kunmap() to
+	 * keep global tlb flushes to a minimum.  When it flushes, it
+	 * works out a pfn and a struct page from that pte which can be
+	 * long after the page is removed.  Flush before removal.
+	 */
+	flush_all_zero_pkmaps();
+//	invalidate_phys_mapping(start_pfn, nr_pages);
+	ms->section_mem_map &= ~SECTION_MARKED_PRESENT;
+	return 0;
+}
--- memhotplug/mm/page_alloc.c~I0-nonlinear-types	2005-02-17 15:51:06.000000000 -0800
+++ /mm/page_alloc.c	2005-02-17 15:51:10.000000000 -0800
@@ -1296,7 +1296,7 @@
 /*
  * Builds allocation fallback zone lists.
  */
-static int __init build_zonelists_node(pg_data_t *pgdat, struct zonelist *zonelist, int j, int k)
+int __devinit build_zonelists_node(pg_data_t *pgdat, struct zonelist *zonelist, int j, int k)
 {
 	switch (k) {
 		struct zone *zone;
@@ -1304,7 +1304,12 @@
 		BUG();
 	case ZONE_HIGHMEM:
 		zone = pgdat->node_zones + ZONE_HIGHMEM;
-		if (zone->present_pages) {
+		/*
+		 * with mem hotplug we don't increment present_pages
+		 * until the pages are actually freed into the zone,
+		 * but we increment spanned pages much earlier
+		 */
+		if (zone->spanned_pages) {
 #ifndef CONFIG_HIGHMEM
 			BUG();
 #endif
@@ -1312,11 +1317,11 @@
 		}
 	case ZONE_NORMAL:
 		zone = pgdat->node_zones + ZONE_NORMAL;
-		if (zone->present_pages)
+		if (zone->spanned_pages)
 			zonelist->zones[j++] = zone;
 	case ZONE_DMA:
 		zone = pgdat->node_zones + ZONE_DMA;
-		if (zone->present_pages)
+		if (zone->spanned_pages)
 			zonelist->zones[j++] = zone;
 	}
 
@@ -1387,7 +1392,7 @@
 	return best_node;
 }
 
-static void __init build_zonelists(pg_data_t *pgdat)
+void __devinit build_zonelists(pg_data_t *pgdat)
 {
 	int i, j, k, node, local_node;
 	int prev_node, load;
@@ -1434,7 +1439,7 @@
 
 #else	/* CONFIG_NUMA */
 
-static void __init build_zonelists(pg_data_t *pgdat)
+void __devinit build_zonelists(pg_data_t *pgdat)
 {
 	int i, j, k, node, local_node;
 
@@ -1554,7 +1559,7 @@
  * up by free_all_bootmem() once the early boot process is
  * done. Non-atomic initialization, single-pass.
  */
-void __init memmap_init_zone(unsigned long size, int nid, unsigned long zone,
+void __devinit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		unsigned long start_pfn)
 {
 	struct page *page;
@@ -1613,7 +1618,7 @@
 	memmap_init_zone((size), (nid), (zone), (start_pfn))
 #endif
 
-static __devinit void zone_pcp_init(struct zone *zone)
+void zone_pcp_init(struct zone *zone)
 {
 	unsigned long batch;
 	int cpu;
@@ -1653,7 +1658,7 @@
 			zone->name, zone->present_pages, batch);
 }
 
-static __devinit void zone_wait_table_init(struct zone *zone, unsigned long zone_size_pages)
+void zone_wait_table_init(struct zone *zone, unsigned long zone_size_pages)
 {
 	int table_size_bytes;
 	int i;
@@ -1679,7 +1684,6 @@
 {
 	const unsigned long zone_required_alignment = 1UL << (MAX_ORDER-1);
 	struct pglist_data *pgdat = zone->zone_pgdat;
-	int nid = pgdat->node_id;
 
 	zone->zone_mem_map = pfn_to_page(zone_start_pfn);
 	zone->zone_start_pfn = zone_start_pfn;
@@ -1687,9 +1691,8 @@
 	if ((zone_start_pfn) & (zone_required_alignment-1))
 		printk("BUG: wrong zone alignment, it will crash\n");
 
-	memmap_init(size, nid, zone_idx(zone), zone_start_pfn);
-
 	zone_init_free_lists(pgdat, zone, zone->spanned_pages);
+	zone->spanned_pages = size;
 
 	pgdat->nr_zones++;
 }
@@ -1723,11 +1726,11 @@
 			nr_kernel_pages += realsize;
 		nr_all_pages += realsize;
 
-		zone->spanned_pages = size;
 		zone->present_pages = realsize;
 		zone->name = zone_names[j];
 		spin_lock_init(&zone->lock);
 		spin_lock_init(&zone->lru_lock);
+		init_MUTEX(&zone->resize_sem);
 		zone->zone_pgdat = pgdat;
 		zone->free_pages = 0;
 
@@ -1748,6 +1751,7 @@
 
 		zone_wait_table_init(zone, size);
 		init_currently_empty_zone(zone, zone_start_pfn, size);
+		//memmap_init(size, nid, zone_idx(zone), zone_start_pfn);
 		zone_start_pfn += size;
 	}
 }
@@ -1801,7 +1805,7 @@
 void __init free_area_init(unsigned long *zones_size)
 {
 	free_area_init_node(0, &contig_page_data, zones_size,
-			__pa(PAGE_OFFSET) >> PAGE_SHIFT, NULL);
+			__pa((void*)PAGE_OFFSET) >> PAGE_SHIFT, NULL);
 }
 #endif
 
@@ -2032,7 +2036,7 @@
  *	that the pages_{min,low,high} values for each zone are set correctly 
  *	with respect to min_free_kbytes.
  */
-static void setup_per_zone_pages_min(void)
+void setup_per_zone_pages_min(void)
 {
 	unsigned long pages_min = min_free_kbytes >> (PAGE_SHIFT - 10);
 	unsigned long lowmem_pages = 0;
@@ -2241,3 +2245,32 @@
 
 	return table;
 }
+
+static inline int zone_previously_initialized(struct zone *zone)
+{
+	if (zone->wait_table_size)
+		return 1;
+
+	return 0;
+}
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+int  hot_add_zone_init(struct zone *zone, unsigned long phys_start_pfn, unsigned long size_pages)
+{
+	if (zone_previously_initialized(zone))
+		return -EEXIST;
+
+	zone_wait_table_init(zone, PAGES_PER_SECTION);
+	init_currently_empty_zone(zone, phys_start_pfn, PAGES_PER_SECTION);
+	zone_pcp_init(zone);
+
+	/*
+	 * FIXME: there is no locking at all for the zonelists.
+	 * Least impactful (codewise) way to do this is probably
+	 * to freeze all the CPUs for a sec while this is done.
+	 */
+	build_zonelists(zone->zone_pgdat);
+
+	return 0;
+}
+#endif

--=-CFNAnV48gUGKokJyfycj--

