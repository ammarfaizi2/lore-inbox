Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263166AbUEQXkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUEQXkl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 19:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbUEQXkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 19:40:41 -0400
Received: from smtpq1.home.nl ([213.51.128.196]:61658 "EHLO smtpq1.home.nl")
	by vger.kernel.org with ESMTP id S263166AbUEQXkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 19:40:22 -0400
Message-ID: <40A94CFA.6070805@keyaccess.nl>
Date: Tue, 18 May 2004 01:38:34 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040117
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: [2.6.6-mm3] 1/3: merge std_resources.c back into setup.c
Content-Type: multipart/mixed;
 boundary="------------040505050704020601000208"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040505050704020601000208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew.

std_resources.{c,h} was only split off due to pc9800 wanting to override
it. With it gone, it might as well be merged back in. Doesn't change any
code. It was compiled and booted.

This time this also actually doesn't break compilation of any of the
subarches. That's to say, any further. I guess it might have been my
.config (my regular PC config, with just the subarch switched through
menuconfig) or O=, but only ELAN actually compiled. Voyager and VISWS
bombed out at the final link and NUMAQ much sooner (with "physnode_map
undeclared" during compilation of numaq.c).

Rene.


--------------040505050704020601000208
Content-Type: text/plain;
 name="linux-2.6.6-mm3_resources-move.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.6-mm3_resources-move.diff"

diff -urN linux-2.6.6-mm3.orig/arch/i386/Kconfig linux-2.6.6-mm3/arch/i386/Kconfig
--- linux-2.6.6-mm3.orig/arch/i386/Kconfig	2004-05-17 03:18:30.000000000 +0200
+++ linux-2.6.6-mm3/arch/i386/Kconfig	2004-05-17 21:05:14.000000000 +0200
@@ -1518,12 +1518,6 @@
 	depends on X86_SMP || (X86_VOYAGER && SMP)
 	default y
 
-# std_resources is overridden for pc9800, but that's not
-# a currently selectable arch choice
-config X86_STD_RESOURCES
-	bool
-	default y
-
 config PC
 	bool
 	depends on X86 && !EMBEDDED
diff -urN linux-2.6.6-mm3.orig/arch/i386/kernel/Makefile linux-2.6.6-mm3/arch/i386/kernel/Makefile
--- linux-2.6.6-mm3.orig/arch/i386/kernel/Makefile	2004-05-17 03:18:30.000000000 +0200
+++ linux-2.6.6-mm3/arch/i386/kernel/Makefile	2004-05-17 21:07:52.000000000 +0200
@@ -32,7 +32,6 @@
 obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
 obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
-obj-$(CONFIG_X86_STD_RESOURCES)	+= std_resources.o
 
 EXTRA_AFLAGS   := -traditional
 
diff -urN linux-2.6.6-mm3.orig/arch/i386/kernel/setup.c linux-2.6.6-mm3/arch/i386/kernel/setup.c
--- linux-2.6.6-mm3.orig/arch/i386/kernel/setup.c	2004-05-17 03:18:30.000000000 +0200
+++ linux-2.6.6-mm3/arch/i386/kernel/setup.c	2004-05-17 22:00:47.000000000 +0200
@@ -47,7 +47,7 @@
 #include <asm/sections.h>
 #include <asm/io_apic.h>
 #include <asm/ist.h>
-#include <asm/std_resources.h>
+#include <asm/io.h>
 #include "setup_arch_pre.h"
 
 /* This value is set up by the early boot code to point to the value
@@ -133,8 +133,201 @@
 
 unsigned char __initdata boot_params[PARAM_SIZE];
 
-static struct resource code_resource = { "Kernel code", 0x100000, 0 };
-static struct resource data_resource = { "Kernel data", 0, 0 };
+static struct resource data_resource = {
+	.name	= "Kernel data",
+	.start	= 0,
+	.end	= 0
+};
+
+static struct resource code_resource = {
+	.name	= "Kernel code",
+	.start	= 0x100000,
+	.end	= 0
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
+#define ADAPTER_ROM_RESOURCES \
+	(sizeof adapter_rom_resources / sizeof adapter_rom_resources[0])
+
+static struct resource video_rom_resource = {
+	.name 	= "Video ROM",
+	.start	= 0xc0000,
+	.end	= 0xc7fff,
+	.flags	= IORESOURCE_BUSY | IORESOURCE_READONLY | IORESOURCE_MEM
+};
+
+static struct resource vram_resource = {
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
+	.name	= "timer",
+	.start	= 0x0040,
+	.end	= 0x005f,
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
+#define STANDARD_IO_RESOURCES \
+	(sizeof standard_io_resources / sizeof standard_io_resources[0])
+
+#define romsignature(x) (*(unsigned short *)(x) == 0xaa55)
+	
+static int __init checksum(unsigned char *rom, unsigned long length)
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
+		if (length && checksum(rom, length))
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
+		if (checksum(rom, length)) {
+			request_resource(&iomem_resource, &extension_rom_resource);
+			upper = extension_rom_resource.start;
+		}
+	}
+
+	/* check for adapter roms on 2k boundaries */
+	for (i = 0; i < ADAPTER_ROM_RESOURCES && start < upper; start += 2048) {
+		rom = isa_bus_to_virt(start);
+		if (!romsignature(rom))
+			continue;
+
+		/* 0 < length <= 0x7f * 512, historically */
+		length = rom[2] * 512;
+
+		/* but accept any length that fits if checksum okay */
+		if (!length || start + length > upper || !checksum(rom, length))
+			continue;
+
+		adapter_rom_resources[i].start = start;
+		adapter_rom_resources[i].end = start + length - 1;
+		request_resource(&iomem_resource, &adapter_rom_resources[i]);
+
+		start = adapter_rom_resources[i++].end & ~2047UL;
+	}
+}
 
 static void __init limit_regions(unsigned long long size)
 {
@@ -948,6 +1141,7 @@
 static void __init register_memory(unsigned long max_low_pfn)
 {
 	unsigned long low_mem_size;
+	int	      i;
 
 	if (efi_enabled)
 		efi_initialize_iomem_resources(&code_resource, &data_resource);
@@ -955,10 +1149,11 @@
 		legacy_init_iomem_resources(&code_resource, &data_resource);
 
 	/* EFI systems may still have VGA */
-	request_graphics_resource();
+	request_resource(&iomem_resource, &vram_resource);
 
 	/* request I/O space for devices used on all i[345]86 PCs */
-	request_standard_io_resources();
+	for (i = 0; i < STANDARD_IO_RESOURCES; i++)
+		request_resource(&ioport_resource, &standard_io_resources[i]);
 
 	/* Tell the PCI layer not to allocate too close to the RAM area.. */
 	low_mem_size = ((max_low_pfn << PAGE_SHIFT) + 0xfffff) & ~0xfffff;
diff -urN linux-2.6.6-mm3.orig/arch/i386/kernel/std_resources.c linux-2.6.6-mm3/arch/i386/kernel/std_resources.c
--- linux-2.6.6-mm3.orig/arch/i386/kernel/std_resources.c	2004-05-10 09:31:43.000000000 +0200
+++ linux-2.6.6-mm3/arch/i386/kernel/std_resources.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,204 +0,0 @@
-/*
- *  Machine specific resource allocation for generic.
- */
-
-#include <linux/ioport.h>
-#include <asm/io.h>
-#include <asm/std_resources.h>
-
-#define romsignature(x) (*(unsigned short *)(x) == 0xaa55)
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
-#define ADAPTER_ROM_RESOURCES \
-	(sizeof adapter_rom_resources / sizeof adapter_rom_resources[0])
-
-static struct resource video_rom_resource = {
-	.name 	= "Video ROM",
-	.start	= 0xc0000,
-	.end	= 0xc7fff,
-	.flags	= IORESOURCE_BUSY | IORESOURCE_READONLY | IORESOURCE_MEM
-};
-
-static struct resource vram_resource = {
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
-	.name	= "timer",
-	.start	= 0x0040,
-	.end	= 0x005f,
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
-#define STANDARD_IO_RESOURCES \
-	(sizeof standard_io_resources / sizeof standard_io_resources[0])
-
-static int __init checksum(unsigned char *rom, unsigned long length)
-{
-	unsigned char *p, sum = 0;
-
-	for (p = rom; p < rom + length; p++)
-		sum += *p;
-	return sum == 0;
-}
-
-void __init probe_roms(void)
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
-		if (length && checksum(rom, length))
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
-		if (checksum(rom, length)) {
-			request_resource(&iomem_resource, &extension_rom_resource);
-			upper = extension_rom_resource.start;
-		}
-	}
-
-	/* check for adapter roms on 2k boundaries */
-	for (i = 0; i < ADAPTER_ROM_RESOURCES && start < upper; start += 2048) {
-		rom = isa_bus_to_virt(start);
-		if (!romsignature(rom))
-			continue;
-
-		/* 0 < length <= 0x7f * 512, historically */
-		length = rom[2] * 512;
-
-		/* but accept any length that fits if checksum okay */
-		if (!length || start + length > upper || !checksum(rom, length))
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
-void __init request_graphics_resource(void)
-{
-	request_resource(&iomem_resource, &vram_resource);
-}
-
-void __init request_standard_io_resources(void)
-{
-	int i;
-
-	for (i = 0; i < STANDARD_IO_RESOURCES; i++)
-		request_resource(&ioport_resource, &standard_io_resources[i]);
-}
diff -urN linux-2.6.6-mm3.orig/include/asm-i386/std_resources.h linux-2.6.6-mm3/include/asm-i386/std_resources.h
--- linux-2.6.6-mm3.orig/include/asm-i386/std_resources.h	2004-05-10 09:31:47.000000000 +0200
+++ linux-2.6.6-mm3/include/asm-i386/std_resources.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,14 +0,0 @@
-/*
- * include/asm-i386/std_resources.h
- */
-
-#ifndef __ASM_I386_STD_RESOURCES_H
-#define __ASM_I386_STD_RESOURCES_H
-
-#include <linux/init.h>
-
-void probe_roms(void) __init;
-void request_graphics_resource(void) __init;
-void request_standard_io_resources(void) __init;
-
-#endif

--------------040505050704020601000208--
