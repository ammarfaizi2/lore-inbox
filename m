Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263060AbVCXF46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbVCXF46 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 00:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbVCXF4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 00:56:38 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:28648 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263052AbVCXFyp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 00:54:45 -0500
Message-ID: <42425635.30808@in.ibm.com>
Date: Thu, 24 Mar 2005 11:25:01 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fastboot <fastboot@lists.osdl.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH 3/7] i386 code for the physmem map
References: <424254E0.6060003@in.ibm.com> <42425582.7040508@in.ibm.com> <424255EA.9010905@in.ibm.com>
In-Reply-To: <424255EA.9010905@in.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------090207030509080507030805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090207030509080507030805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Regards, Hari

--------------090207030509080507030805
Content-Type: text/plain;
 name="physmem-i386.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="physmem-i386.patch"


---

This patch contains the i386 specific code to generate the
/proc/physmem view.

Signed-off-by: Hariprasad Nellitheertha <hari@in.ibm.com>
---

 linux-2.6.12-rc1-hari/arch/i386/kernel/efi.c   |  134 +++++++++++++++----------
 linux-2.6.12-rc1-hari/arch/i386/kernel/setup.c |   82 +++++++++++++--
 linux-2.6.12-rc1-hari/include/linux/efi.h      |    2 
 linux-2.6.12-rc1-hari/include/linux/ioport.h   |    1 
 4 files changed, 156 insertions(+), 63 deletions(-)

diff -puN arch/i386/kernel/efi.c~physmem-i386 arch/i386/kernel/efi.c
--- linux-2.6.12-rc1/arch/i386/kernel/efi.c~physmem-i386	2005-03-23 17:48:06.000000000 +0530
+++ linux-2.6.12-rc1-hari/arch/i386/kernel/efi.c	2005-03-23 17:48:06.000000000 +0530
@@ -49,6 +49,7 @@ struct efi efi;
 EXPORT_SYMBOL(efi);
 static struct efi efi_phys __initdata;
 struct efi_memory_map memmap __initdata;
+struct efi_memory_map memmapcopy __initdata;
 
 /*
  * We require an early boot_ioremap mapping mechanism initially
@@ -527,6 +528,67 @@ void __init efi_enter_virtual_mode(void)
 					efi.systab->runtime->reset_system;
 }
 
+static struct resource * __init alloc_efi_resource(efi_memory_desc_t *md,
+						   struct resource *resource,
+						   int i)
+{
+	struct resource *res;
+
+	res = alloc_bootmem_low(sizeof(struct resource));
+	switch (md->type) {
+	case EFI_RESERVED_TYPE:
+		res->name = "Reserved Memory";
+		break;
+	case EFI_LOADER_CODE:
+		res->name = "Loader Code";
+		break;
+	case EFI_LOADER_DATA:
+		res->name = "Loader Data";
+		break;
+	case EFI_BOOT_SERVICES_DATA:
+		res->name = "BootServices Data";
+		break;
+	case EFI_BOOT_SERVICES_CODE:
+		res->name = "BootServices Code";
+		break;
+	case EFI_RUNTIME_SERVICES_CODE:
+		res->name = "Runtime Service Code";
+		break;
+	case EFI_RUNTIME_SERVICES_DATA:
+		res->name = "Runtime Service Data";
+		break;
+	case EFI_CONVENTIONAL_MEMORY:
+		res->name = "Conventional Memory";
+		break;
+	case EFI_UNUSABLE_MEMORY:
+		res->name = "Unusable Memory";
+		break;
+	case EFI_ACPI_RECLAIM_MEMORY:
+		res->name = "ACPI Reclaim";
+		break;
+	case EFI_ACPI_MEMORY_NVS:
+		res->name = "ACPI NVS";
+		break;
+	case EFI_MEMORY_MAPPED_IO:
+		res->name = "Memory Mapped IO";
+		break;
+	case EFI_MEMORY_MAPPED_IO_PORT_SPACE:
+		res->name = "Memory Mapped IO Port Space";
+		break;
+	default:
+		res->name = "Reserved";
+		break;
+	}
+
+	res->start = md->phys_addr;
+	res->end = res->start + ((md->num_pages << EFI_PAGE_SHIFT) - 1);
+	res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+	if (request_resource(resource, res) < 0)
+		printk(KERN_ERR PFX "Failed to allocate res %s : 0x%llx-0x%llx\n",
+			res->name, res->start, res->end);
+	return res;
+}
+
 void __init
 efi_initialize_iomem_resources(struct resource *code_resource,
 			       struct resource *data_resource)
@@ -541,57 +603,7 @@ efi_initialize_iomem_resources(struct re
 		if ((md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT)) >
 		    0x100000000ULL)
 			continue;
-		res = alloc_bootmem_low(sizeof(struct resource));
-		switch (md->type) {
-		case EFI_RESERVED_TYPE:
-			res->name = "Reserved Memory";
-			break;
-		case EFI_LOADER_CODE:
-			res->name = "Loader Code";
-			break;
-		case EFI_LOADER_DATA:
-			res->name = "Loader Data";
-			break;
-		case EFI_BOOT_SERVICES_DATA:
-			res->name = "BootServices Data";
-			break;
-		case EFI_BOOT_SERVICES_CODE:
-			res->name = "BootServices Code";
-			break;
-		case EFI_RUNTIME_SERVICES_CODE:
-			res->name = "Runtime Service Code";
-			break;
-		case EFI_RUNTIME_SERVICES_DATA:
-			res->name = "Runtime Service Data";
-			break;
-		case EFI_CONVENTIONAL_MEMORY:
-			res->name = "Conventional Memory";
-			break;
-		case EFI_UNUSABLE_MEMORY:
-			res->name = "Unusable Memory";
-			break;
-		case EFI_ACPI_RECLAIM_MEMORY:
-			res->name = "ACPI Reclaim";
-			break;
-		case EFI_ACPI_MEMORY_NVS:
-			res->name = "ACPI NVS";
-			break;
-		case EFI_MEMORY_MAPPED_IO:
-			res->name = "Memory Mapped IO";
-			break;
-		case EFI_MEMORY_MAPPED_IO_PORT_SPACE:
-			res->name = "Memory Mapped IO Port Space";
-			break;
-		default:
-			res->name = "Reserved";
-			break;
-		}
-		res->start = md->phys_addr;
-		res->end = res->start + ((md->num_pages << EFI_PAGE_SHIFT) - 1);
-		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
-		if (request_resource(&iomem_resource, res) < 0)
-			printk(KERN_ERR PFX "Failed to allocate res %s : 0x%llx-0x%llx\n",
-				res->name, res->start, res->end);
+		res = alloc_efi_resource(md, &iomem_resource, i);
 		/*
 		 * We don't know which region contains kernel data so we try
 		 * it repeatedly and let the resource manager test it.
@@ -606,6 +618,26 @@ efi_initialize_iomem_resources(struct re
 	}
 }
 
+void __init efi_initialize_physmem_resources(void)
+{
+	struct resource *res;
+	efi_memory_desc_t *md;
+	int i;
+
+	for (i = 0; i < memmapcopy.nr_map; i++) {
+		md = &memmapcopy.map[i];
+		res = alloc_efi_resource(md, &physmem_resource, i);
+	}
+}
+
+/*
+ * Make a copy of memmap for creating the physmem resources later.
+ */
+void __init preserve_memmap(void)
+{
+	memcpy(&memmapcopy, &memmap, sizeof(memmap));
+}
+
 /*
  * Convenience functions to obtain memory types and attributes
  */
diff -puN arch/i386/kernel/setup.c~physmem-i386 arch/i386/kernel/setup.c
--- linux-2.6.12-rc1/arch/i386/kernel/setup.c~physmem-i386	2005-03-23 17:48:06.000000000 +0530
+++ linux-2.6.12-rc1-hari/arch/i386/kernel/setup.c	2005-03-23 17:48:06.000000000 +0530
@@ -121,6 +121,7 @@ struct sys_desc_table_struct {
 struct edid_info edid_info;
 struct ist_info ist_info;
 struct e820map e820;
+struct e820map __initdata e820copy;
 
 extern void early_cpu_init(void);
 extern void dmi_scan_machine(void);
@@ -639,6 +640,14 @@ static int __init copy_e820_map(struct e
 	return 0;
 }
 
+/* Copy e820 into e820copy. We later use the e820copy to create
+ * the physmem resources.
+ */
+static void __init preserve_e820_map(void)
+{
+	memcpy(&e820copy, &e820, sizeof(e820));
+}
+
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
 struct edd edd;
 #ifdef CONFIG_EDD_MODULE
@@ -662,6 +671,17 @@ static inline void copy_edd(void)
 }
 #endif
 
+/* Make a copy of the e820 or memmap data structure.
+ * We use this copy to setup the physmem resources later.
+ */
+static void __init copy_physmem_map(void)
+{
+	if (efi_enabled)
+		preserve_memmap();
+	else
+		preserve_e820_map();
+}
+
 /*
  * Do NOT EVER look at the BIOS memory size location.
  * It does not work on many machines.
@@ -1218,6 +1238,27 @@ void __init remapped_pgdat_init(void)
 }
 
 /*
+ * Common routine to alloc and initialize an e820 type ROM or RAM resource.
+ */
+static struct resource * __init alloc_e820_resource(struct e820map *emap, struct resource *resource, int i)
+{
+	struct resource *res;
+
+	res = alloc_bootmem_low(sizeof(struct resource));
+	switch (emap->map[i].type) {
+	case E820_RAM:	res->name = "System RAM"; break;
+	case E820_ACPI:	res->name = "ACPI Tables"; break;
+	case E820_NVS:	res->name = "ACPI Non-volatile Storage"; break;
+	default:	res->name = "reserved";
+	}
+	res->start = emap->map[i].addr;
+	res->end = res->start + emap->map[i].size - 1;
+	res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+	request_resource(resource, res);
+	return res;
+}
+
+/*
  * Request address space for all standard RAM and ROM resources
  * and also for regions reported as reserved by the e820.
  */
@@ -1225,23 +1266,13 @@ static void __init
 legacy_init_iomem_resources(struct resource *code_resource, struct resource *data_resource)
 {
 	int i;
+	struct resource *res;
 
 	probe_roms();
 	for (i = 0; i < e820.nr_map; i++) {
-		struct resource *res;
 		if (e820.map[i].addr + e820.map[i].size > 0x100000000ULL)
 			continue;
-		res = alloc_bootmem_low(sizeof(struct resource));
-		switch (e820.map[i].type) {
-		case E820_RAM:	res->name = "System RAM"; break;
-		case E820_ACPI:	res->name = "ACPI Tables"; break;
-		case E820_NVS:	res->name = "ACPI Non-volatile Storage"; break;
-		default:	res->name = "reserved";
-		}
-		res->start = e820.map[i].addr;
-		res->end = res->start + e820.map[i].size - 1;
-		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
-		request_resource(&iomem_resource, res);
+		res = alloc_e820_resource(&e820, &iomem_resource, i);
 		if (e820.map[i].type == E820_RAM) {
 			/*
 			 *  We don't know which RAM region contains kernel data,
@@ -1258,6 +1289,20 @@ legacy_init_iomem_resources(struct resou
 }
 
 /*
+ * Request address space for standard ROM and RAM resources. This will contain
+ * the entire e820 map even if the original map has been modified due to mem=
+ * or memmap=exactmap command line parameters
+ */
+static void __init legacy_init_physmem_resources(void)
+{
+	int i;
+	struct resource *res;
+
+	for (i = 0; i < e820copy.nr_map; i++)
+		res = alloc_e820_resource(&e820copy, &physmem_resource, i);
+}
+
+/*
  * Request address space for all standard resources
  */
 static void __init register_memory(void)
@@ -1438,6 +1483,15 @@ static void set_mca_bus(int x)
 static void set_mca_bus(int x) { }
 #endif
 
+static void __init register_physmem_resources(void)
+{
+	if (efi_enabled)
+		efi_initialize_physmem_resources();
+	else
+		legacy_init_physmem_resources();
+}
+
+
 /*
  * Determine if we were loaded by an EFI loader.  If so, then we have also been
  * passed the efi memmap, systab, etc., so we should use these data structures
@@ -1495,6 +1549,8 @@ void __init setup_arch(char **cmdline_p)
 
 	copy_edd();
 
+	copy_physmem_map();
+
 	if (!MOUNT_ROOT_RDONLY)
 		root_mountflags &= ~MS_RDONLY;
 	init_mm.start_code = (unsigned long) _text;
@@ -1532,6 +1588,8 @@ void __init setup_arch(char **cmdline_p)
 	 * NOTE: at this point the bootmem allocator is fully available.
 	 */
 
+	register_physmem_resources();
+
 #ifdef CONFIG_EARLY_PRINTK
 	{
 		char *s = strstr(*cmdline_p, "earlyprintk=");
diff -puN include/linux/efi.h~physmem-i386 include/linux/efi.h
--- linux-2.6.12-rc1/include/linux/efi.h~physmem-i386	2005-03-23 17:48:06.000000000 +0530
+++ linux-2.6.12-rc1-hari/include/linux/efi.h	2005-03-23 17:48:06.000000000 +0530
@@ -301,6 +301,8 @@ extern u64 efi_mem_attributes (unsigned 
 extern int __init efi_uart_console_only (void);
 extern void efi_initialize_iomem_resources(struct resource *code_resource,
 					struct resource *data_resource);
+extern void efi_initialize_physmem_resources(void);
+extern void preserve_memmap(void);
 extern unsigned long __init efi_get_time(void);
 extern int __init efi_set_rtc_mmss(unsigned long nowtime);
 extern struct efi_memory_map memmap;
diff -puN include/linux/ioport.h~physmem-i386 include/linux/ioport.h
--- linux-2.6.12-rc1/include/linux/ioport.h~physmem-i386	2005-03-23 17:48:06.000000000 +0530
+++ linux-2.6.12-rc1-hari/include/linux/ioport.h	2005-03-23 17:48:06.000000000 +0530
@@ -91,6 +91,7 @@ struct resource_list {
 /* PC/ISA/whatever - the normal PC address spaces: IO and memory */
 extern struct resource ioport_resource;
 extern struct resource iomem_resource;
+extern struct resource physmem_resource;
 
 extern int request_resource(struct resource *root, struct resource *new);
 extern struct resource * ____request_resource(struct resource *root, struct resource *new);
_

--------------090207030509080507030805--
