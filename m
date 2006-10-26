Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423458AbWJZMb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423458AbWJZMb0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 08:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423460AbWJZMbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 08:31:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:16685 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1423458AbWJZMbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 08:31:22 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,361,1157353200"; 
   d="scan'208"; a="150975284:sNHT25644297"
Message-ID: <4540AA97.3030301@intel.com>
Date: Thu, 26 Oct 2006 20:31:19 +0800
From: "bibo,mao" <bibo.mao@intel.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] i386 create e820.c to handle standard io/mem resources
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch creates new file named e820.c to hanle standard io/mem
resources, moving request_standard_resources function from setup.c
to e820.c. Also this patch modifies Makfile to compile file e820.c.

Signed-off-by: bibo,mao <bibo.mao@intel.com>

 Makefile |    2
 e820.c   |  289 ++++++++++++++++++++++
 setup.c  |  276 ------------------
 3 files changed, 293 insertions(+), 274 deletions(-)
----------------------------------------------------------
diff -Nrup -X 2.6.19-rc2-mm2/Documentation/dontdiff 2.6.19-rc2-mm2.org/arch/i386/kernel/e820.c 2.6.19-rc2-mm2/arch/i386/kernel/e820.c
--- 2.6.19-rc2-mm2.org/arch/i386/kernel/e820.c	1970-01-01 08:00:00.000000000 +0800
+++ 2.6.19-rc2-mm2/arch/i386/kernel/e820.c	2006-10-25 15:21:04.000000000 +0800
@@ -0,0 +1,289 @@
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/bootmem.h>
+#include <linux/ioport.h>
+#include <linux/string.h>
+#include <linux/kexec.h>
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/efi.h>
+
+#include <asm/pgtable.h>
+#include <asm/page.h>
+#include <asm/e820.h>
+
+#ifdef CONFIG_EFI
+int efi_enabled = 0;
+EXPORT_SYMBOL(efi_enabled);
+#endif
+
+struct e820map e820;
+struct resource data_resource = {
+	.name	= "Kernel data",
+	.start	= 0,
+	.end	= 0,
+	.flags	= IORESOURCE_BUSY | IORESOURCE_MEM
+};
+
+struct resource code_resource = {
+	.name	= "Kernel code",
+	.start	= 0,
+	.end	= 0,
+	.flags	= IORESOURCE_BUSY | IORESOURCE_MEM
+};
+
+static struct resource system_rom_resource = {
+	.name	= "System ROM",
+	.start	= 0xf0000,
+	.end	= 0xfffff,
+	.flags	= IORESOURCE_BUSY | IORESOURCE_READONLY | IORESOURCE_MEM
+};
+
+static struct resource extension_rom_resource = {
+	.name	= "Extension ROM",
+	.start	= 0xe0000,
+	.end	= 0xeffff,
+	.flags	= IORESOURCE_BUSY | IORESOURCE_READONLY | IORESOURCE_MEM
+};
+
+static struct resource adapter_rom_resources[] = { {
+	.name 	= "Adapter ROM",
+	.start	= 0xc8000,
+	.end	= 0,
+	.flags	= IORESOURCE_BUSY | IORESOURCE_READONLY | IORESOURCE_MEM
+}, {
+	.name 	= "Adapter ROM",
+	.start	= 0,
+	.end	= 0,
+	.flags	= IORESOURCE_BUSY | IORESOURCE_READONLY | IORESOURCE_MEM
+}, {
+	.name 	= "Adapter ROM",
+	.start	= 0,
+	.end	= 0,
+	.flags	= IORESOURCE_BUSY | IORESOURCE_READONLY | IORESOURCE_MEM
+}, {
+	.name 	= "Adapter ROM",
+	.start	= 0,
+	.end	= 0,
+	.flags	= IORESOURCE_BUSY | IORESOURCE_READONLY | IORESOURCE_MEM
+}, {
+	.name 	= "Adapter ROM",
+	.start	= 0,
+	.end	= 0,
+	.flags	= IORESOURCE_BUSY | IORESOURCE_READONLY | IORESOURCE_MEM
+}, {
+	.name 	= "Adapter ROM",
+	.start	= 0,
+	.end	= 0,
+	.flags	= IORESOURCE_BUSY | IORESOURCE_READONLY | IORESOURCE_MEM
+} };
+
+static struct resource video_rom_resource = {
+	.name 	= "Video ROM",
+	.start	= 0xc0000,
+	.end	= 0xc7fff,
+	.flags	= IORESOURCE_BUSY | IORESOURCE_READONLY | IORESOURCE_MEM
+};
+
+static struct resource video_ram_resource = {
+	.name	= "Video RAM area",
+	.start	= 0xa0000,
+	.end	= 0xbffff,
+	.flags	= IORESOURCE_BUSY | IORESOURCE_MEM
+};
+
+static struct resource standard_io_resources[] = { {
+	.name	= "dma1",
+	.start	= 0x0000,
+	.end	= 0x001f,
+	.flags	= IORESOURCE_BUSY | IORESOURCE_IO
+}, {
+	.name	= "pic1",
+	.start	= 0x0020,
+	.end	= 0x0021,
+	.flags	= IORESOURCE_BUSY | IORESOURCE_IO
+}, {
+	.name   = "timer0",
+	.start	= 0x0040,
+	.end    = 0x0043,
+	.flags  = IORESOURCE_BUSY | IORESOURCE_IO
+}, {
+	.name   = "timer1",
+	.start  = 0x0050,
+	.end    = 0x0053,
+	.flags	= IORESOURCE_BUSY | IORESOURCE_IO
+}, {
+	.name	= "keyboard",
+	.start	= 0x0060,
+	.end	= 0x006f,
+	.flags	= IORESOURCE_BUSY | IORESOURCE_IO
+}, {
+	.name	= "dma page reg",
+	.start	= 0x0080,
+	.end	= 0x008f,
+	.flags	= IORESOURCE_BUSY | IORESOURCE_IO
+}, {
+	.name	= "pic2",
+	.start	= 0x00a0,
+	.end	= 0x00a1,
+	.flags	= IORESOURCE_BUSY | IORESOURCE_IO
+}, {
+	.name	= "dma2",
+	.start	= 0x00c0,
+	.end	= 0x00df,
+	.flags	= IORESOURCE_BUSY | IORESOURCE_IO
+}, {
+	.name	= "fpu",
+	.start	= 0x00f0,
+	.end	= 0x00ff,
+	.flags	= IORESOURCE_BUSY | IORESOURCE_IO
+} };
+
+#define romsignature(x) (*(unsigned short *)(x) == 0xaa55)
+
+static int __init romchecksum(unsigned char *rom, unsigned long length)
+{
+	unsigned char *p, sum = 0;
+
+	for (p = rom; p < rom + length; p++)
+		sum += *p;
+	return sum == 0;
+}
+
+static void __init probe_roms(void)
+{
+	unsigned long start, length, upper;
+	unsigned char *rom;
+	int	      i;
+
+	/* video rom */
+	upper = adapter_rom_resources[0].start;
+	for (start = video_rom_resource.start; start < upper; start += 2048) {
+		rom = isa_bus_to_virt(start);
+		if (!romsignature(rom))
+			continue;
+
+		video_rom_resource.start = start;
+
+		/* 0 < length <= 0x7f * 512, historically */
+		length = rom[2] * 512;
+
+		/* if checksum okay, trust length byte */
+		if (length && romchecksum(rom, length))
+			video_rom_resource.end = start + length - 1;
+
+		request_resource(&iomem_resource, &video_rom_resource);
+		break;
+	}
+
+	start = (video_rom_resource.end + 1 + 2047) & ~2047UL;
+	if (start < upper)
+		start = upper;
+
+	/* system rom */
+	request_resource(&iomem_resource, &system_rom_resource);
+	upper = system_rom_resource.start;
+
+	/* check for extension rom (ignore length byte!) */
+	rom = isa_bus_to_virt(extension_rom_resource.start);
+	if (romsignature(rom)) {
+		length = extension_rom_resource.end - extension_rom_resource.start + 1;
+		if (romchecksum(rom, length)) {
+			request_resource(&iomem_resource, &extension_rom_resource);
+			upper = extension_rom_resource.start;
+		}
+	}
+
+	/* check for adapter roms on 2k boundaries */
+	for (i = 0; i < ARRAY_SIZE(adapter_rom_resources) && start < upper; start += 2048) {
+		rom = isa_bus_to_virt(start);
+		if (!romsignature(rom))
+			continue;
+
+		/* 0 < length <= 0x7f * 512, historically */
+		length = rom[2] * 512;
+
+		/* but accept any length that fits if checksum okay */
+		if (!length || start + length > upper || !romchecksum(rom, length))
+			continue;
+
+		adapter_rom_resources[i].start = start;
+		adapter_rom_resources[i].end = start + length - 1;
+		request_resource(&iomem_resource, &adapter_rom_resources[i]);
+
+		start = adapter_rom_resources[i++].end & ~2047UL;
+	}
+}
+
+/*
+ * Request address space for all standard RAM and ROM resources
+ * and also for regions reported as reserved by the e820.
+ */
+static void __init
+legacy_init_iomem_resources(struct resource *code_resource, struct resource *data_resource)
+{
+	int i;
+
+	probe_roms();
+	for (i = 0; i < e820.nr_map; i++) {
+		struct resource *res;
+#ifndef CONFIG_RESOURCES_64BIT
+		if (e820.map[i].addr + e820.map[i].size > 0x100000000ULL)
+			continue;
+#endif
+		res = kzalloc(sizeof(struct resource), GFP_ATOMIC);
+		switch (e820.map[i].type) {
+		case E820_RAM:	res->name = "System RAM"; break;
+		case E820_ACPI:	res->name = "ACPI Tables"; break;
+		case E820_NVS:	res->name = "ACPI Non-volatile Storage"; break;
+		default:	res->name = "reserved";
+		}
+		res->start = e820.map[i].addr;
+		res->end = res->start + e820.map[i].size - 1;
+		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+		if (request_resource(&iomem_resource, res)) {
+			kfree(res);
+			continue;
+		}
+		if (e820.map[i].type == E820_RAM) {
+			/*
+			 *  We don't know which RAM region contains kernel data,
+			 *  so we try it repeatedly and let the resource manager
+			 *  test it.
+			 */
+			request_resource(res, code_resource);
+			request_resource(res, data_resource);
+#ifdef CONFIG_KEXEC
+			request_resource(res, &crashk_res);
+#endif
+		}
+	}
+}
+
+/*
+ * Request address space for all standard resources
+ *
+ * This is called just before pcibios_init(), which is also a
+ * subsys_initcall, but is linked in later (in arch/i386/pci/common.c).
+ */
+static int __init request_standard_resources(void)
+{
+	int i;
+
+	printk("Setting up standard PCI resources\n");
+	if (efi_enabled)
+		efi_initialize_iomem_resources(&code_resource, &data_resource);
+	else
+		legacy_init_iomem_resources(&code_resource, &data_resource);
+
+	/* EFI systems may still have VGA */
+	request_resource(&iomem_resource, &video_ram_resource);
+
+	/* request I/O space for devices used on all i[345]86 PCs */
+	for (i = 0; i < ARRAY_SIZE(standard_io_resources); i++)
+		request_resource(&ioport_resource, &standard_io_resources[i]);
+	return 0;
+}
+
+subsys_initcall(request_standard_resources);
diff -Nrup -X 2.6.19-rc2-mm2/Documentation/dontdiff 2.6.19-rc2-mm2.org/arch/i386/kernel/Makefile 2.6.19-rc2-mm2/arch/i386/kernel/Makefile
--- 2.6.19-rc2-mm2.org/arch/i386/kernel/Makefile	2006-10-25 14:59:45.000000000 +0800
+++ 2.6.19-rc2-mm2/arch/i386/kernel/Makefile	2006-10-25 15:10:00.000000000 +0800
@@ -6,7 +6,7 @@ extra-y := head.o init_task.o vmlinux.ld
 
 obj-y	:= process.o signal.o entry.o traps.o irq.o \
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_i386.o \
-		pci-dma.o i386_ksyms.o i387.o bootflag.o \
+		pci-dma.o i386_ksyms.o i387.o bootflag.o e820.o\
 		quirks.o i8237.o topology.o alternative.o i8253.o tsc.o
 
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
diff -Nrup -X 2.6.19-rc2-mm2/Documentation/dontdiff 2.6.19-rc2-mm2.org/arch/i386/kernel/setup.c 2.6.19-rc2-mm2/arch/i386/kernel/setup.c
--- 2.6.19-rc2-mm2.org/arch/i386/kernel/setup.c	2006-10-25 14:59:45.000000000 +0800
+++ 2.6.19-rc2-mm2/arch/i386/kernel/setup.c	2006-10-25 15:18:53.000000000 +0800
@@ -76,11 +76,9 @@ int disable_pse __devinitdata = 0;
 /*
  * Machine setup..
  */
-
-#ifdef CONFIG_EFI
-int efi_enabled = 0;
-EXPORT_SYMBOL(efi_enabled);
-#endif
+extern struct e820map e820;
+extern struct resource code_resource;
+extern struct resource data_resource;
 
 /* cpu data as detected by the assembly code in head.S */
 struct cpuinfo_x86 new_cpu_data __initdata = { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
@@ -134,7 +132,6 @@ struct ist_info ist_info;
 	defined(CONFIG_X86_SPEEDSTEP_SMI_MODULE)
 EXPORT_SYMBOL(ist_info);
 #endif
-struct e820map e820;
 
 extern void early_cpu_init(void);
 extern int root_mountflags;
@@ -149,203 +146,6 @@ static char command_line[COMMAND_LINE_SI
 
 unsigned char __initdata boot_params[PARAM_SIZE];
 
-static struct resource data_resource = {
-	.name	= "Kernel data",
-	.start	= 0,
-	.end	= 0,
-	.flags	= IORESOURCE_BUSY | IORESOURCE_MEM
-};
-
-static struct resource code_resource = {
-	.name	= "Kernel code",
-	.start	= 0,
-	.end	= 0,
-	.flags	= IORESOURCE_BUSY | IORESOURCE_MEM
-};
-
-static struct resource system_rom_resource = {
-	.name	= "System ROM",
-	.start	= 0xf0000,
-	.end	= 0xfffff,
-	.flags	= IORESOURCE_BUSY | IORESOURCE_READONLY | IORESOURCE_MEM
-};
-
-static struct resource extension_rom_resource = {
-	.name	= "Extension ROM",
-	.start	= 0xe0000,
-	.end	= 0xeffff,
-	.flags	= IORESOURCE_BUSY | IORESOURCE_READONLY | IORESOURCE_MEM
-};
-
-static struct resource adapter_rom_resources[] = { {
-	.name 	= "Adapter ROM",
-	.start	= 0xc8000,
-	.end	= 0,
-	.flags	= IORESOURCE_BUSY | IORESOURCE_READONLY | IORESOURCE_MEM
-}, {
-	.name 	= "Adapter ROM",
-	.start	= 0,
-	.end	= 0,
-	.flags	= IORESOURCE_BUSY | IORESOURCE_READONLY | IORESOURCE_MEM
-}, {
-	.name 	= "Adapter ROM",
-	.start	= 0,
-	.end	= 0,
-	.flags	= IORESOURCE_BUSY | IORESOURCE_READONLY | IORESOURCE_MEM
-}, {
-	.name 	= "Adapter ROM",
-	.start	= 0,
-	.end	= 0,
-	.flags	= IORESOURCE_BUSY | IORESOURCE_READONLY | IORESOURCE_MEM
-}, {
-	.name 	= "Adapter ROM",
-	.start	= 0,
-	.end	= 0,
-	.flags	= IORESOURCE_BUSY | IORESOURCE_READONLY | IORESOURCE_MEM
-}, {
-	.name 	= "Adapter ROM",
-	.start	= 0,
-	.end	= 0,
-	.flags	= IORESOURCE_BUSY | IORESOURCE_READONLY | IORESOURCE_MEM
-} };
-
-static struct resource video_rom_resource = {
-	.name 	= "Video ROM",
-	.start	= 0xc0000,
-	.end	= 0xc7fff,
-	.flags	= IORESOURCE_BUSY | IORESOURCE_READONLY | IORESOURCE_MEM
-};
-
-static struct resource video_ram_resource = {
-	.name	= "Video RAM area",
-	.start	= 0xa0000,
-	.end	= 0xbffff,
-	.flags	= IORESOURCE_BUSY | IORESOURCE_MEM
-};
-
-static struct resource standard_io_resources[] = { {
-	.name	= "dma1",
-	.start	= 0x0000,
-	.end	= 0x001f,
-	.flags	= IORESOURCE_BUSY | IORESOURCE_IO
-}, {
-	.name	= "pic1",
-	.start	= 0x0020,
-	.end	= 0x0021,
-	.flags	= IORESOURCE_BUSY | IORESOURCE_IO
-}, {
-	.name   = "timer0",
-	.start	= 0x0040,
-	.end    = 0x0043,
-	.flags  = IORESOURCE_BUSY | IORESOURCE_IO
-}, {
-	.name   = "timer1",
-	.start  = 0x0050,
-	.end    = 0x0053,
-	.flags	= IORESOURCE_BUSY | IORESOURCE_IO
-}, {
-	.name	= "keyboard",
-	.start	= 0x0060,
-	.end	= 0x006f,
-	.flags	= IORESOURCE_BUSY | IORESOURCE_IO
-}, {
-	.name	= "dma page reg",
-	.start	= 0x0080,
-	.end	= 0x008f,
-	.flags	= IORESOURCE_BUSY | IORESOURCE_IO
-}, {
-	.name	= "pic2",
-	.start	= 0x00a0,
-	.end	= 0x00a1,
-	.flags	= IORESOURCE_BUSY | IORESOURCE_IO
-}, {
-	.name	= "dma2",
-	.start	= 0x00c0,
-	.end	= 0x00df,
-	.flags	= IORESOURCE_BUSY | IORESOURCE_IO
-}, {
-	.name	= "fpu",
-	.start	= 0x00f0,
-	.end	= 0x00ff,
-	.flags	= IORESOURCE_BUSY | IORESOURCE_IO
-} };
-
-#define romsignature(x) (*(unsigned short *)(x) == 0xaa55)
-
-static int __init romchecksum(unsigned char *rom, unsigned long length)
-{
-	unsigned char *p, sum = 0;
-
-	for (p = rom; p < rom + length; p++)
-		sum += *p;
-	return sum == 0;
-}
-
-static void __init probe_roms(void)
-{
-	unsigned long start, length, upper;
-	unsigned char *rom;
-	int	      i;
-
-	/* video rom */
-	upper = adapter_rom_resources[0].start;
-	for (start = video_rom_resource.start; start < upper; start += 2048) {
-		rom = isa_bus_to_virt(start);
-		if (!romsignature(rom))
-			continue;
-
-		video_rom_resource.start = start;
-
-		/* 0 < length <= 0x7f * 512, historically */
-		length = rom[2] * 512;
-
-		/* if checksum okay, trust length byte */
-		if (length && romchecksum(rom, length))
-			video_rom_resource.end = start + length - 1;
-
-		request_resource(&iomem_resource, &video_rom_resource);
-		break;
-	}
-
-	start = (video_rom_resource.end + 1 + 2047) & ~2047UL;
-	if (start < upper)
-		start = upper;
-
-	/* system rom */
-	request_resource(&iomem_resource, &system_rom_resource);
-	upper = system_rom_resource.start;
-
-	/* check for extension rom (ignore length byte!) */
-	rom = isa_bus_to_virt(extension_rom_resource.start);
-	if (romsignature(rom)) {
-		length = extension_rom_resource.end - extension_rom_resource.start + 1;
-		if (romchecksum(rom, length)) {
-			request_resource(&iomem_resource, &extension_rom_resource);
-			upper = extension_rom_resource.start;
-		}
-	}
-
-	/* check for adapter roms on 2k boundaries */
-	for (i = 0; i < ARRAY_SIZE(adapter_rom_resources) && start < upper; start += 2048) {
-		rom = isa_bus_to_virt(start);
-		if (!romsignature(rom))
-			continue;
-
-		/* 0 < length <= 0x7f * 512, historically */
-		length = rom[2] * 512;
-
-		/* but accept any length that fits if checksum okay */
-		if (!length || start + length > upper || !romchecksum(rom, length))
-			continue;
-
-		adapter_rom_resources[i].start = start;
-		adapter_rom_resources[i].end = start + length - 1;
-		request_resource(&iomem_resource, &adapter_rom_resources[i]);
-
-		start = adapter_rom_resources[i++].end & ~2047UL;
-	}
-}
-
 static void __init print_memory_map(char *who);
 static void __init limit_regions(unsigned long long size)
 {
@@ -1216,77 +1016,7 @@ void __init remapped_pgdat_init(void)
 	}
 }
 
-/*
- * Request address space for all standard RAM and ROM resources
- * and also for regions reported as reserved by the e820.
- */
-static void __init
-legacy_init_iomem_resources(struct resource *code_resource, struct resource *data_resource)
-{
-	int i;
-
-	probe_roms();
-	for (i = 0; i < e820.nr_map; i++) {
-		struct resource *res;
-#ifndef CONFIG_RESOURCES_64BIT
-		if (e820.map[i].addr + e820.map[i].size > 0x100000000ULL)
-			continue;
-#endif
-		res = kzalloc(sizeof(struct resource), GFP_ATOMIC);
-		switch (e820.map[i].type) {
-		case E820_RAM:	res->name = "System RAM"; break;
-		case E820_ACPI:	res->name = "ACPI Tables"; break;
-		case E820_NVS:	res->name = "ACPI Non-volatile Storage"; break;
-		default:	res->name = "reserved";
-		}
-		res->start = e820.map[i].addr;
-		res->end = res->start + e820.map[i].size - 1;
-		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
-		if (request_resource(&iomem_resource, res)) {
-			kfree(res);
-			continue;
-		}
-		if (e820.map[i].type == E820_RAM) {
-			/*
-			 *  We don't know which RAM region contains kernel data,
-			 *  so we try it repeatedly and let the resource manager
-			 *  test it.
-			 */
-			request_resource(res, code_resource);
-			request_resource(res, data_resource);
-#ifdef CONFIG_KEXEC
-			request_resource(res, &crashk_res);
-#endif
-		}
-	}
-}
-
-/*
- * Request address space for all standard resources
- *
- * This is called just before pcibios_init(), which is also a
- * subsys_initcall, but is linked in later (in arch/i386/pci/common.c).
- */
-static int __init request_standard_resources(void)
-{
-	int i;
-
-	printk("Setting up standard PCI resources\n");
-	if (efi_enabled)
-		efi_initialize_iomem_resources(&code_resource, &data_resource);
-	else
-		legacy_init_iomem_resources(&code_resource, &data_resource);
-
-	/* EFI systems may still have VGA */
-	request_resource(&iomem_resource, &video_ram_resource);
-
-	/* request I/O space for devices used on all i[345]86 PCs */
-	for (i = 0; i < ARRAY_SIZE(standard_io_resources); i++)
-		request_resource(&ioport_resource, &standard_io_resources[i]);
-	return 0;
-}
 
-subsys_initcall(request_standard_resources);
 
 static void __init register_memory(void)
 {
