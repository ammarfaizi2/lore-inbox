Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbUCUXEf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 18:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbUCUXEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 18:04:35 -0500
Received: from smtpq3.home.nl ([213.51.128.198]:13522 "EHLO smtpq3.home.nl")
	by vger.kernel.org with ESMTP id S261460AbUCUXAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 18:00:19 -0500
Message-ID: <405E1E56.6020203@keyaccess.nl>
Date: Sun, 21 Mar 2004 23:59:34 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031029
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Osamu Tomita <tomita@cinet.co.jp>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] 2.6.5-rc2{,-mm1} i386 probe_roms() damage
Content-Type: multipart/mixed;
 boundary="------------010709020909040108010000"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010709020909040108010000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

as said (see 0/2) this patch doesn't change any code, just moves stuff
from the "mach_resources.h" header to a "std_resources.c" subarch
specific file, and introduces a "std_resources.h" header for the prototypes.

Hope those names are okay. I first put this in the subarch "setup.c",
noticed it seemed very out of place there, moved it to
"legacy_resources.[ch]", found that name to be a bit long, renamed them 
to "legacy.[ch]", found that to be too generic a name, and settled on 
this one...

Rene.


--------------010709020909040108010000
Content-Type: text/plain;
 name="00-linux-2.6.5-rc2-mm1_i386-std_resources.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="00-linux-2.6.5-rc2-mm1_i386-std_resources.diff"

diff -urN linux-2.6.5-rc2-mm1.orig/arch/i386/kernel/setup.c linux-2.6.5-rc2-mm1/arch/i386/kernel/setup.c
--- linux-2.6.5-rc2-mm1.orig/arch/i386/kernel/setup.c	2004-03-21 15:30:00.000000000 +0100
+++ linux-2.6.5-rc2-mm1/arch/i386/kernel/setup.c	2004-03-21 15:52:07.000000000 +0100
@@ -47,8 +47,8 @@
 #include <asm/sections.h>
 #include <asm/io_apic.h>
 #include <asm/ist.h>
+#include <asm/std_resources.h>
 #include "setup_arch_pre.h"
-#include "mach_resources.h"
 
 /* This value is set up by the early boot code to point to the value
    immediately after the boot time page tables.  It contains a *physical*
@@ -134,19 +134,6 @@
 static struct resource code_resource = { "Kernel code", 0x100000, 0 };
 static struct resource data_resource = { "Kernel data", 0, 0 };
 
-static void __init probe_roms(void)
-{
-	int roms = 1;
-
-	request_resource(&iomem_resource, rom_resources+0);
-
-	/* Video ROM is standard at C000:0000 - C7FF:0000, check signature */
-	probe_video_rom(roms);
-
-	/* Extension roms */
-	probe_extension_roms(roms);
-}
-
 static void __init limit_regions(unsigned long long size)
 {
 	unsigned long long current_addr = 0;
@@ -938,19 +925,17 @@
 static void __init register_memory(unsigned long max_low_pfn)
 {
 	unsigned long low_mem_size;
-	int i;
 
 	if (efi_enabled)
 		efi_initialize_iomem_resources(&code_resource, &data_resource);
 	else
 		legacy_init_iomem_resources(&code_resource, &data_resource);
 
- 	 /* EFI systems may still have VGA */
+	/* EFI systems may still have VGA */
 	request_graphics_resource();
 
 	/* request I/O space for devices used on all i[345]86 PCs */
-	for (i = 0; i < STANDARD_IO_RESOURCES; i++)
-		request_resource(&ioport_resource, standard_io_resources+i);
+	request_standard_io_resources();
 
 	/* Tell the PCI layer not to allocate too close to the RAM area.. */
 	low_mem_size = ((max_low_pfn << PAGE_SHIFT) + 0xfffff) & ~0xfffff;
diff -urN linux-2.6.5-rc2-mm1.orig/arch/i386/mach-default/Makefile linux-2.6.5-rc2-mm1/arch/i386/mach-default/Makefile
--- linux-2.6.5-rc2-mm1.orig/arch/i386/mach-default/Makefile	2004-03-21 15:30:00.000000000 +0100
+++ linux-2.6.5-rc2-mm1/arch/i386/mach-default/Makefile	2004-03-21 15:52:07.000000000 +0100
@@ -2,4 +2,4 @@
 # Makefile for the linux kernel.
 #
 
-obj-y				:= setup.o topology.o
+obj-y				:= setup.o topology.o std_resources.o
diff -urN linux-2.6.5-rc2-mm1.orig/arch/i386/mach-default/std_resources.c linux-2.6.5-rc2-mm1/arch/i386/mach-default/std_resources.c
--- linux-2.6.5-rc2-mm1.orig/arch/i386/mach-default/std_resources.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.5-rc2-mm1/arch/i386/mach-default/std_resources.c	2004-03-21 15:52:23.000000000 +0100
@@ -0,0 +1,108 @@
+/*
+ *  Machine specific resource allocation for generic.
+ *  Split out from setup.c by Osamu Tomita <tomita@cinet.co.jp>
+ */
+
+#include <linux/ioport.h>
+#include <asm/io.h>
+#include <asm/std_resources.h>
+
+static struct resource standard_io_resources[] = {
+	{ "dma1", 0x00, 0x1f, IORESOURCE_BUSY },
+	{ "pic1", 0x20, 0x21, IORESOURCE_BUSY },
+	{ "timer", 0x40, 0x5f, IORESOURCE_BUSY },
+	{ "keyboard", 0x60, 0x6f, IORESOURCE_BUSY },
+	{ "dma page reg", 0x80, 0x8f, IORESOURCE_BUSY },
+	{ "pic2", 0xa0, 0xa1, IORESOURCE_BUSY },
+	{ "dma2", 0xc0, 0xdf, IORESOURCE_BUSY },
+	{ "fpu", 0xf0, 0xff, IORESOURCE_BUSY }
+};
+
+#define STANDARD_IO_RESOURCES (sizeof(standard_io_resources)/sizeof(struct resource))
+
+static struct resource vram_resource = { "Video RAM area", 0xa0000, 0xbffff, IORESOURCE_BUSY };
+
+/* System ROM resources */
+#define MAXROMS 6
+static struct resource rom_resources[MAXROMS] = {
+	{ "System ROM", 0xF0000, 0xFFFFF, IORESOURCE_BUSY },
+	{ "Video ROM", 0xc0000, 0xc7fff, IORESOURCE_BUSY }
+};
+
+#define romsignature(x) (*(unsigned short *)(x) == 0xaa55)
+
+void __init probe_roms(void)
+{
+	unsigned long base;
+	unsigned char *romstart;
+	int roms = 1;
+
+	request_resource(&iomem_resource, rom_resources+0);
+
+	/* Video ROM is standard at C000:0000 - C7FF:0000, check signature */
+	for (base = 0xC0000; base < 0xE0000; base += 2048) {
+		romstart = isa_bus_to_virt(base);
+		if (!romsignature(romstart))
+			continue;
+		request_resource(&iomem_resource, rom_resources + roms);
+		roms++;
+		break;
+	}
+
+	/* Extension roms at C800:0000 - DFFF:0000 */
+	for (base = 0xC8000; base < 0xE0000; base += 2048) {
+		unsigned long length;
+
+		romstart = isa_bus_to_virt(base);
+		if (!romsignature(romstart))
+			continue;
+		length = romstart[2] * 512;
+		if (length) {
+			unsigned int i;
+			unsigned char chksum;
+
+			chksum = 0;
+			for (i = 0; i < length; i++)
+				chksum += romstart[i];
+
+			/* Good checksum? */
+			if (!chksum) {
+				rom_resources[roms].start = base;
+				rom_resources[roms].end = base + length - 1;
+				rom_resources[roms].name = "Extension ROM";
+				rom_resources[roms].flags = IORESOURCE_BUSY;
+
+				request_resource(&iomem_resource, rom_resources + roms);
+				roms++;
+				if (roms >= MAXROMS)
+					return;
+			}
+		}
+	}
+
+	/* Final check for motherboard extension rom at E000:0000 */
+	base = 0xE0000;
+	romstart = isa_bus_to_virt(base);
+
+	if (romsignature(romstart)) {
+		rom_resources[roms].start = base;
+		rom_resources[roms].end = base + 65535;
+		rom_resources[roms].name = "Extension ROM";
+		rom_resources[roms].flags = IORESOURCE_BUSY;
+
+		request_resource(&iomem_resource, rom_resources + roms);
+	}
+}
+
+void __init request_graphics_resource(void)
+{
+	request_resource(&iomem_resource, &vram_resource);
+}
+
+void __init request_standard_io_resources(void)
+{
+	int i;
+
+	for (i = 0; i < STANDARD_IO_RESOURCES; i++)
+		request_resource(&ioport_resource, standard_io_resources+i);
+}
diff -urN linux-2.6.5-rc2-mm1.orig/arch/i386/mach-pc9800/Makefile linux-2.6.5-rc2-mm1/arch/i386/mach-pc9800/Makefile
--- linux-2.6.5-rc2-mm1.orig/arch/i386/mach-pc9800/Makefile	2004-03-21 15:30:00.000000000 +0100
+++ linux-2.6.5-rc2-mm1/arch/i386/mach-pc9800/Makefile	2004-03-21 15:52:07.000000000 +0100
@@ -2,4 +2,4 @@
 # Makefile for the linux kernel.
 #
 
-obj-y				:= setup.o topology.o
+obj-y				:= setup.o topology.o std_resources.o
diff -urN linux-2.6.5-rc2-mm1.orig/arch/i386/mach-pc9800/std_resources.c linux-2.6.5-rc2-mm1/arch/i386/mach-pc9800/std_resources.c
--- linux-2.6.5-rc2-mm1.orig/arch/i386/mach-pc9800/std_resources.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.5-rc2-mm1/arch/i386/mach-pc9800/std_resources.c	2004-03-21 15:52:07.000000000 +0100
@@ -0,0 +1,195 @@
+/*
+ *  Machine specific resource allocation for PC-9800.
+ *  Written by Osamu Tomita <tomita@cinet.co.jp>
+ */
+
+#include <linux/ioport.h>
+#include <asm/io.h>
+#include <asm/std_resources.h>
+
+static char str_pic1[] = "pic1";
+static char str_dma[] = "dma";
+static char str_pic2[] = "pic2";
+static char str_calender_clock[] = "calender clock";
+static char str_system[] = "system";
+static char str_nmi_control[] = "nmi control";
+static char str_kanji_rom[] = "kanji rom";
+static char str_keyboard[] = "keyboard";
+static char str_text_gdc[] = "text gdc";
+static char str_crtc[] = "crtc";
+static char str_timer[] = "timer";
+static char str_graphic_gdc[] = "graphic gdc";
+static char str_dma_ex_bank[] = "dma ex. bank";
+static char str_beep_freq[] = "beep freq.";
+static char str_mouse_pio[] = "mouse pio";
+struct resource standard_io_resources[] = {
+	{ str_pic1, 0x00, 0x00, IORESOURCE_BUSY },
+	{ str_dma, 0x01, 0x01, IORESOURCE_BUSY },
+	{ str_pic1, 0x02, 0x02, IORESOURCE_BUSY },
+	{ str_dma, 0x03, 0x03, IORESOURCE_BUSY },
+	{ str_dma, 0x05, 0x05, IORESOURCE_BUSY },
+	{ str_dma, 0x07, 0x07, IORESOURCE_BUSY },
+	{ str_pic2, 0x08, 0x08, IORESOURCE_BUSY },
+	{ str_dma, 0x09, 0x09, IORESOURCE_BUSY },
+	{ str_pic2, 0x0a, 0x0a, IORESOURCE_BUSY },
+	{ str_dma, 0x0b, 0x0b, IORESOURCE_BUSY },
+	{ str_dma, 0x0d, 0x0d, IORESOURCE_BUSY },
+	{ str_dma, 0x0f, 0x0f, IORESOURCE_BUSY },
+	{ str_dma, 0x11, 0x11, IORESOURCE_BUSY },
+	{ str_dma, 0x13, 0x13, IORESOURCE_BUSY },
+	{ str_dma, 0x15, 0x15, IORESOURCE_BUSY },
+	{ str_dma, 0x17, 0x17, IORESOURCE_BUSY },
+	{ str_dma, 0x19, 0x19, IORESOURCE_BUSY },
+	{ str_dma, 0x1b, 0x1b, IORESOURCE_BUSY },
+	{ str_dma, 0x1d, 0x1d, IORESOURCE_BUSY },
+	{ str_dma, 0x1f, 0x1f, IORESOURCE_BUSY },
+	{ str_calender_clock, 0x20, 0x20, 0 },
+	{ str_dma, 0x21, 0x21, IORESOURCE_BUSY },
+	{ str_calender_clock, 0x22, 0x22, 0 },
+	{ str_dma, 0x23, 0x23, IORESOURCE_BUSY },
+	{ str_dma, 0x25, 0x25, IORESOURCE_BUSY },
+	{ str_dma, 0x27, 0x27, IORESOURCE_BUSY },
+	{ str_dma, 0x29, 0x29, IORESOURCE_BUSY },
+	{ str_dma, 0x2b, 0x2b, IORESOURCE_BUSY },
+	{ str_dma, 0x2d, 0x2d, IORESOURCE_BUSY },
+	{ str_system, 0x31, 0x31, IORESOURCE_BUSY },
+	{ str_system, 0x33, 0x33, IORESOURCE_BUSY },
+	{ str_system, 0x35, 0x35, IORESOURCE_BUSY },
+	{ str_system, 0x37, 0x37, IORESOURCE_BUSY },
+	{ str_nmi_control, 0x50, 0x50, IORESOURCE_BUSY },
+	{ str_nmi_control, 0x52, 0x52, IORESOURCE_BUSY },
+	{ "time stamp", 0x5c, 0x5f, IORESOURCE_BUSY },
+	{ str_kanji_rom, 0xa1, 0xa1, IORESOURCE_BUSY },
+	{ str_kanji_rom, 0xa3, 0xa3, IORESOURCE_BUSY },
+	{ str_kanji_rom, 0xa5, 0xa5, IORESOURCE_BUSY },
+	{ str_kanji_rom, 0xa7, 0xa7, IORESOURCE_BUSY },
+	{ str_kanji_rom, 0xa9, 0xa9, IORESOURCE_BUSY },
+	{ str_keyboard, 0x41, 0x41, IORESOURCE_BUSY },
+	{ str_keyboard, 0x43, 0x43, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x60, 0x60, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x62, 0x62, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x64, 0x64, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x66, 0x66, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x68, 0x68, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x6a, 0x6a, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x6c, 0x6c, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x6e, 0x6e, IORESOURCE_BUSY },
+	{ str_crtc, 0x70, 0x70, IORESOURCE_BUSY },
+	{ str_crtc, 0x72, 0x72, IORESOURCE_BUSY },
+	{ str_crtc, 0x74, 0x74, IORESOURCE_BUSY },
+	{ str_crtc, 0x74, 0x74, IORESOURCE_BUSY },
+	{ str_crtc, 0x76, 0x76, IORESOURCE_BUSY },
+	{ str_crtc, 0x78, 0x78, IORESOURCE_BUSY },
+	{ str_crtc, 0x7a, 0x7a, IORESOURCE_BUSY },
+	{ str_timer, 0x71, 0x71, IORESOURCE_BUSY },
+	{ str_timer, 0x73, 0x73, IORESOURCE_BUSY },
+	{ str_timer, 0x75, 0x75, IORESOURCE_BUSY },
+	{ str_timer, 0x77, 0x77, IORESOURCE_BUSY },
+	{ str_graphic_gdc, 0xa0, 0xa0, IORESOURCE_BUSY },
+	{ str_graphic_gdc, 0xa2, 0xa2, IORESOURCE_BUSY },
+	{ str_graphic_gdc, 0xa4, 0xa4, IORESOURCE_BUSY },
+	{ str_graphic_gdc, 0xa6, 0xa6, IORESOURCE_BUSY },
+	{ "cpu", 0xf0, 0xf7, IORESOURCE_BUSY },
+	{ "fpu", 0xf8, 0xff, IORESOURCE_BUSY },
+	{ str_dma_ex_bank, 0x0e05, 0x0e05, 0 },
+	{ str_dma_ex_bank, 0x0e07, 0x0e07, 0 },
+	{ str_dma_ex_bank, 0x0e09, 0x0e09, 0 },
+	{ str_dma_ex_bank, 0x0e0b, 0x0e0b, 0 },
+	{ str_beep_freq, 0x3fd9, 0x3fd9, IORESOURCE_BUSY },
+	{ str_beep_freq, 0x3fdb, 0x3fdb, IORESOURCE_BUSY },
+	{ str_beep_freq, 0x3fdd, 0x3fdd, IORESOURCE_BUSY },
+	{ str_beep_freq, 0x3fdf, 0x3fdf, IORESOURCE_BUSY },
+	/* All PC-9800 have (exactly) one mouse interface.  */
+	{ str_mouse_pio, 0x7fd9, 0x7fd9, 0 },
+	{ str_mouse_pio, 0x7fdb, 0x7fdb, 0 },
+	{ str_mouse_pio, 0x7fdd, 0x7fdd, 0 },
+	{ str_mouse_pio, 0x7fdf, 0x7fdf, 0 },
+	{ "mouse timer", 0xbfdb, 0xbfdb, 0 },
+	{ "mouse irq", 0x98d7, 0x98d7, 0 },
+};
+
+#define STANDARD_IO_RESOURCES (sizeof(standard_io_resources)/sizeof(struct resource))
+
+static struct resource tvram_resource = { "Text VRAM/CG window", 0xa0000, 0xa4fff, IORESOURCE_BUSY };
+static struct resource gvram_brg_resource = { "Graphic VRAM (B/R/G)", 0xa8000, 0xbffff, IORESOURCE_BUSY };
+static struct resource gvram_e_resource = { "Graphic VRAM (E)", 0xe0000, 0xe7fff, IORESOURCE_BUSY };
+
+/* System ROM resources */
+#define MAXROMS 6
+static struct resource rom_resources[MAXROMS] = {
+	{ "System ROM", 0xe8000, 0xfffff, IORESOURCE_BUSY }
+};
+
+void __init probe_roms(void)
+{
+	int i;
+	__u8 *xrom_id;
+	int roms = 1;
+
+	request_resource(&iomem_resource, rom_resources+0);
+	
+	xrom_id = (__u8 *) isa_bus_to_virt(PC9800SCA_XROM_ID + 0x10);
+
+	for (i = 0; i < 16; i++) {
+		if (xrom_id[i] & 0x80) {
+			int j;
+
+			for (j = i + 1; j < 16 && (xrom_id[j] & 0x80); j++)
+				;
+			rom_resources[roms].start = 0x0d0000 + i * 0x001000;
+			rom_resources[roms].end = 0x0d0000 + j * 0x001000 - 1;
+			rom_resources[roms].name = "Extension ROM";
+			rom_resources[roms].flags = IORESOURCE_BUSY;
+
+			request_resource(&iomem_resource,
+					  rom_resources + roms);
+			if (++roms >= MAXROMS)
+				return;
+		}
+	}
+}
+
+void __init request_graphics_resource(void)
+{
+	int i;
+
+	if (PC9800_HIGHRESO_P()) {
+		tvram_resource.start = 0xe0000;
+		tvram_resource.end   = 0xe4fff;
+		gvram_brg_resource.name  = "Graphic VRAM";
+		gvram_brg_resource.start = 0xc0000;
+		gvram_brg_resource.end   = 0xdffff;
+	}
+
+	request_resource(&iomem_resource, &tvram_resource);
+	request_resource(&iomem_resource, &gvram_brg_resource);
+	if (!PC9800_HIGHRESO_P())
+		request_resource(&iomem_resource, &gvram_e_resource);
+
+	if (PC9800_HIGHRESO_P() || PC9800_9821_P()) {
+		static char graphics[] = "graphics";
+		static struct resource graphics_resources[] = {
+			{ graphics, 0x9a0, 0x9a0, 0 },
+			{ graphics, 0x9a2, 0x9a2, 0 },
+			{ graphics, 0x9a4, 0x9a4, 0 },
+			{ graphics, 0x9a6, 0x9a6, 0 },
+			{ graphics, 0x9a8, 0x9a8, 0 },
+			{ graphics, 0x9aa, 0x9aa, 0 },
+			{ graphics, 0x9ac, 0x9ac, 0 },
+			{ graphics, 0x9ae, 0x9ae, 0 },
+		};
+
+#define GRAPHICS_RESOURCES (sizeof(graphics_resources)/sizeof(struct resource))
+
+		for (i = 0; i < GRAPHICS_RESOURCES; i++)
+			request_resource(&ioport_resource, graphics_resources + i);
+	}
+}
+
+void __init request_standard_io_resources(void)
+{
+	int i;
+
+	for (i = 0; i < STANDARD_IO_RESOURCES; i++)
+		request_resource(&ioport_resource, standard_io_resources+i);
+}
diff -urN linux-2.6.5-rc2-mm1.orig/include/asm-i386/mach-default/mach_resources.h linux-2.6.5-rc2-mm1/include/asm-i386/mach-default/mach_resources.h
--- linux-2.6.5-rc2-mm1.orig/include/asm-i386/mach-default/mach_resources.h	2004-03-21 15:30:00.000000000 +0100
+++ linux-2.6.5-rc2-mm1/include/asm-i386/mach-default/mach_resources.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,106 +0,0 @@
-/*
- *  include/asm-i386/mach-default/mach_resources.h
- *
- *  Machine specific resource allocation for generic.
- *  Split out from setup.c by Osamu Tomita <tomita@cinet.co.jp>
- */
-#ifndef _MACH_RESOURCES_H
-#define _MACH_RESOURCES_H
-
-struct resource standard_io_resources[] = {
-	{ "dma1", 0x00, 0x1f, IORESOURCE_BUSY },
-	{ "pic1", 0x20, 0x21, IORESOURCE_BUSY },
-	{ "timer", 0x40, 0x5f, IORESOURCE_BUSY },
-	{ "keyboard", 0x60, 0x6f, IORESOURCE_BUSY },
-	{ "dma page reg", 0x80, 0x8f, IORESOURCE_BUSY },
-	{ "pic2", 0xa0, 0xa1, IORESOURCE_BUSY },
-	{ "dma2", 0xc0, 0xdf, IORESOURCE_BUSY },
-	{ "fpu", 0xf0, 0xff, IORESOURCE_BUSY }
-};
-
-#define STANDARD_IO_RESOURCES (sizeof(standard_io_resources)/sizeof(struct resource))
-
-static struct resource vram_resource = { "Video RAM area", 0xa0000, 0xbffff, IORESOURCE_BUSY };
-
-/* System ROM resources */
-#define MAXROMS 6
-static struct resource rom_resources[MAXROMS] = {
-	{ "System ROM", 0xF0000, 0xFFFFF, IORESOURCE_BUSY },
-	{ "Video ROM", 0xc0000, 0xc7fff, IORESOURCE_BUSY }
-};
-
-#define romsignature(x) (*(unsigned short *)(x) == 0xaa55)
-
-static inline void probe_video_rom(int roms)
-{
-	unsigned long base;
-	unsigned char *romstart;
-
-
-	/* Video ROM is standard at C000:0000 - C7FF:0000, check signature */
-	for (base = 0xC0000; base < 0xE0000; base += 2048) {
-		romstart = isa_bus_to_virt(base);
-		if (!romsignature(romstart))
-			continue;
-		request_resource(&iomem_resource, rom_resources + roms);
-		roms++;
-		break;
-	}
-}
-
-static inline void probe_extension_roms(int roms)
-{
-	unsigned long base;
-	unsigned char *romstart;
-
-	/* Extension roms at C800:0000 - DFFF:0000 */
-	for (base = 0xC8000; base < 0xE0000; base += 2048) {
-		unsigned long length;
-
-		romstart = isa_bus_to_virt(base);
-		if (!romsignature(romstart))
-			continue;
-		length = romstart[2] * 512;
-		if (length) {
-			unsigned int i;
-			unsigned char chksum;
-
-			chksum = 0;
-			for (i = 0; i < length; i++)
-				chksum += romstart[i];
-
-			/* Good checksum? */
-			if (!chksum) {
-				rom_resources[roms].start = base;
-				rom_resources[roms].end = base + length - 1;
-				rom_resources[roms].name = "Extension ROM";
-				rom_resources[roms].flags = IORESOURCE_BUSY;
-
-				request_resource(&iomem_resource, rom_resources + roms);
-				roms++;
-				if (roms >= MAXROMS)
-					return;
-			}
-		}
-	}
-
-	/* Final check for motherboard extension rom at E000:0000 */
-	base = 0xE0000;
-	romstart = isa_bus_to_virt(base);
-
-	if (romsignature(romstart)) {
-		rom_resources[roms].start = base;
-		rom_resources[roms].end = base + 65535;
-		rom_resources[roms].name = "Extension ROM";
-		rom_resources[roms].flags = IORESOURCE_BUSY;
-
-		request_resource(&iomem_resource, rom_resources + roms);
-	}
-}
-
-static inline void request_graphics_resource(void)
-{
-	request_resource(&iomem_resource, &vram_resource);
-}
-
-#endif /* !_MACH_RESOURCES_H */
diff -urN linux-2.6.5-rc2-mm1.orig/include/asm-i386/mach-pc9800/mach_resources.h linux-2.6.5-rc2-mm1/include/asm-i386/mach-pc9800/mach_resources.h
--- linux-2.6.5-rc2-mm1.orig/include/asm-i386/mach-pc9800/mach_resources.h	2004-03-21 15:30:00.000000000 +0100
+++ linux-2.6.5-rc2-mm1/include/asm-i386/mach-pc9800/mach_resources.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,191 +0,0 @@
-/*
- *  include/asm-i386/mach-pc9800/mach_resources.h
- *
- *  Machine specific resource allocation for PC-9800.
- *  Written by Osamu Tomita <tomita@cinet.co.jp>
- */
-#ifndef _MACH_RESOURCES_H
-#define _MACH_RESOURCES_H
-
-static char str_pic1[] = "pic1";
-static char str_dma[] = "dma";
-static char str_pic2[] = "pic2";
-static char str_calender_clock[] = "calender clock";
-static char str_system[] = "system";
-static char str_nmi_control[] = "nmi control";
-static char str_kanji_rom[] = "kanji rom";
-static char str_keyboard[] = "keyboard";
-static char str_text_gdc[] = "text gdc";
-static char str_crtc[] = "crtc";
-static char str_timer[] = "timer";
-static char str_graphic_gdc[] = "graphic gdc";
-static char str_dma_ex_bank[] = "dma ex. bank";
-static char str_beep_freq[] = "beep freq.";
-static char str_mouse_pio[] = "mouse pio";
-struct resource standard_io_resources[] = {
-	{ str_pic1, 0x00, 0x00, IORESOURCE_BUSY },
-	{ str_dma, 0x01, 0x01, IORESOURCE_BUSY },
-	{ str_pic1, 0x02, 0x02, IORESOURCE_BUSY },
-	{ str_dma, 0x03, 0x03, IORESOURCE_BUSY },
-	{ str_dma, 0x05, 0x05, IORESOURCE_BUSY },
-	{ str_dma, 0x07, 0x07, IORESOURCE_BUSY },
-	{ str_pic2, 0x08, 0x08, IORESOURCE_BUSY },
-	{ str_dma, 0x09, 0x09, IORESOURCE_BUSY },
-	{ str_pic2, 0x0a, 0x0a, IORESOURCE_BUSY },
-	{ str_dma, 0x0b, 0x0b, IORESOURCE_BUSY },
-	{ str_dma, 0x0d, 0x0d, IORESOURCE_BUSY },
-	{ str_dma, 0x0f, 0x0f, IORESOURCE_BUSY },
-	{ str_dma, 0x11, 0x11, IORESOURCE_BUSY },
-	{ str_dma, 0x13, 0x13, IORESOURCE_BUSY },
-	{ str_dma, 0x15, 0x15, IORESOURCE_BUSY },
-	{ str_dma, 0x17, 0x17, IORESOURCE_BUSY },
-	{ str_dma, 0x19, 0x19, IORESOURCE_BUSY },
-	{ str_dma, 0x1b, 0x1b, IORESOURCE_BUSY },
-	{ str_dma, 0x1d, 0x1d, IORESOURCE_BUSY },
-	{ str_dma, 0x1f, 0x1f, IORESOURCE_BUSY },
-	{ str_calender_clock, 0x20, 0x20, 0 },
-	{ str_dma, 0x21, 0x21, IORESOURCE_BUSY },
-	{ str_calender_clock, 0x22, 0x22, 0 },
-	{ str_dma, 0x23, 0x23, IORESOURCE_BUSY },
-	{ str_dma, 0x25, 0x25, IORESOURCE_BUSY },
-	{ str_dma, 0x27, 0x27, IORESOURCE_BUSY },
-	{ str_dma, 0x29, 0x29, IORESOURCE_BUSY },
-	{ str_dma, 0x2b, 0x2b, IORESOURCE_BUSY },
-	{ str_dma, 0x2d, 0x2d, IORESOURCE_BUSY },
-	{ str_system, 0x31, 0x31, IORESOURCE_BUSY },
-	{ str_system, 0x33, 0x33, IORESOURCE_BUSY },
-	{ str_system, 0x35, 0x35, IORESOURCE_BUSY },
-	{ str_system, 0x37, 0x37, IORESOURCE_BUSY },
-	{ str_nmi_control, 0x50, 0x50, IORESOURCE_BUSY },
-	{ str_nmi_control, 0x52, 0x52, IORESOURCE_BUSY },
-	{ "time stamp", 0x5c, 0x5f, IORESOURCE_BUSY },
-	{ str_kanji_rom, 0xa1, 0xa1, IORESOURCE_BUSY },
-	{ str_kanji_rom, 0xa3, 0xa3, IORESOURCE_BUSY },
-	{ str_kanji_rom, 0xa5, 0xa5, IORESOURCE_BUSY },
-	{ str_kanji_rom, 0xa7, 0xa7, IORESOURCE_BUSY },
-	{ str_kanji_rom, 0xa9, 0xa9, IORESOURCE_BUSY },
-	{ str_keyboard, 0x41, 0x41, IORESOURCE_BUSY },
-	{ str_keyboard, 0x43, 0x43, IORESOURCE_BUSY },
-	{ str_text_gdc, 0x60, 0x60, IORESOURCE_BUSY },
-	{ str_text_gdc, 0x62, 0x62, IORESOURCE_BUSY },
-	{ str_text_gdc, 0x64, 0x64, IORESOURCE_BUSY },
-	{ str_text_gdc, 0x66, 0x66, IORESOURCE_BUSY },
-	{ str_text_gdc, 0x68, 0x68, IORESOURCE_BUSY },
-	{ str_text_gdc, 0x6a, 0x6a, IORESOURCE_BUSY },
-	{ str_text_gdc, 0x6c, 0x6c, IORESOURCE_BUSY },
-	{ str_text_gdc, 0x6e, 0x6e, IORESOURCE_BUSY },
-	{ str_crtc, 0x70, 0x70, IORESOURCE_BUSY },
-	{ str_crtc, 0x72, 0x72, IORESOURCE_BUSY },
-	{ str_crtc, 0x74, 0x74, IORESOURCE_BUSY },
-	{ str_crtc, 0x74, 0x74, IORESOURCE_BUSY },
-	{ str_crtc, 0x76, 0x76, IORESOURCE_BUSY },
-	{ str_crtc, 0x78, 0x78, IORESOURCE_BUSY },
-	{ str_crtc, 0x7a, 0x7a, IORESOURCE_BUSY },
-	{ str_timer, 0x71, 0x71, IORESOURCE_BUSY },
-	{ str_timer, 0x73, 0x73, IORESOURCE_BUSY },
-	{ str_timer, 0x75, 0x75, IORESOURCE_BUSY },
-	{ str_timer, 0x77, 0x77, IORESOURCE_BUSY },
-	{ str_graphic_gdc, 0xa0, 0xa0, IORESOURCE_BUSY },
-	{ str_graphic_gdc, 0xa2, 0xa2, IORESOURCE_BUSY },
-	{ str_graphic_gdc, 0xa4, 0xa4, IORESOURCE_BUSY },
-	{ str_graphic_gdc, 0xa6, 0xa6, IORESOURCE_BUSY },
-	{ "cpu", 0xf0, 0xf7, IORESOURCE_BUSY },
-	{ "fpu", 0xf8, 0xff, IORESOURCE_BUSY },
-	{ str_dma_ex_bank, 0x0e05, 0x0e05, 0 },
-	{ str_dma_ex_bank, 0x0e07, 0x0e07, 0 },
-	{ str_dma_ex_bank, 0x0e09, 0x0e09, 0 },
-	{ str_dma_ex_bank, 0x0e0b, 0x0e0b, 0 },
-	{ str_beep_freq, 0x3fd9, 0x3fd9, IORESOURCE_BUSY },
-	{ str_beep_freq, 0x3fdb, 0x3fdb, IORESOURCE_BUSY },
-	{ str_beep_freq, 0x3fdd, 0x3fdd, IORESOURCE_BUSY },
-	{ str_beep_freq, 0x3fdf, 0x3fdf, IORESOURCE_BUSY },
-	/* All PC-9800 have (exactly) one mouse interface.  */
-	{ str_mouse_pio, 0x7fd9, 0x7fd9, 0 },
-	{ str_mouse_pio, 0x7fdb, 0x7fdb, 0 },
-	{ str_mouse_pio, 0x7fdd, 0x7fdd, 0 },
-	{ str_mouse_pio, 0x7fdf, 0x7fdf, 0 },
-	{ "mouse timer", 0xbfdb, 0xbfdb, 0 },
-	{ "mouse irq", 0x98d7, 0x98d7, 0 },
-};
-
-#define STANDARD_IO_RESOURCES (sizeof(standard_io_resources)/sizeof(struct resource))
-
-static struct resource tvram_resource = { "Text VRAM/CG window", 0xa0000, 0xa4fff, IORESOURCE_BUSY };
-static struct resource gvram_brg_resource = { "Graphic VRAM (B/R/G)", 0xa8000, 0xbffff, IORESOURCE_BUSY };
-static struct resource gvram_e_resource = { "Graphic VRAM (E)", 0xe0000, 0xe7fff, IORESOURCE_BUSY };
-
-/* System ROM resources */
-#define MAXROMS 6
-static struct resource rom_resources[MAXROMS] = {
-	{ "System ROM", 0xe8000, 0xfffff, IORESOURCE_BUSY }
-};
-
-static inline void probe_video_rom(int roms)
-{
-	/* PC-9800 has no video ROM */
-}
-
-static inline void probe_extension_roms(int roms)
-{
-	int i;
-	__u8 *xrom_id;
-
-	xrom_id = (__u8 *) isa_bus_to_virt(PC9800SCA_XROM_ID + 0x10);
-
-	for (i = 0; i < 16; i++) {
-		if (xrom_id[i] & 0x80) {
-			int j;
-
-			for (j = i + 1; j < 16 && (xrom_id[j] & 0x80); j++)
-				;
-			rom_resources[roms].start = 0x0d0000 + i * 0x001000;
-			rom_resources[roms].end = 0x0d0000 + j * 0x001000 - 1;
-			rom_resources[roms].name = "Extension ROM";
-			rom_resources[roms].flags = IORESOURCE_BUSY;
-
-			request_resource(&iomem_resource,
-					  rom_resources + roms);
-			if (++roms >= MAXROMS)
-				return;
-		}
-	}
-}
-
-static inline void request_graphics_resource(void)
-{
-	int i;
-
-	if (PC9800_HIGHRESO_P()) {
-		tvram_resource.start = 0xe0000;
-		tvram_resource.end   = 0xe4fff;
-		gvram_brg_resource.name  = "Graphic VRAM";
-		gvram_brg_resource.start = 0xc0000;
-		gvram_brg_resource.end   = 0xdffff;
-	}
-
-	request_resource(&iomem_resource, &tvram_resource);
-	request_resource(&iomem_resource, &gvram_brg_resource);
-	if (!PC9800_HIGHRESO_P())
-		request_resource(&iomem_resource, &gvram_e_resource);
-
-	if (PC9800_HIGHRESO_P() || PC9800_9821_P()) {
-		static char graphics[] = "graphics";
-		static struct resource graphics_resources[] = {
-			{ graphics, 0x9a0, 0x9a0, 0 },
-			{ graphics, 0x9a2, 0x9a2, 0 },
-			{ graphics, 0x9a4, 0x9a4, 0 },
-			{ graphics, 0x9a6, 0x9a6, 0 },
-			{ graphics, 0x9a8, 0x9a8, 0 },
-			{ graphics, 0x9aa, 0x9aa, 0 },
-			{ graphics, 0x9ac, 0x9ac, 0 },
-			{ graphics, 0x9ae, 0x9ae, 0 },
-		};
-
-#define GRAPHICS_RESOURCES (sizeof(graphics_resources)/sizeof(struct resource))
-
-		for (i = 0; i < GRAPHICS_RESOURCES; i++)
-			request_resource(&ioport_resource, graphics_resources + i);
-	}
-}
-
-#endif /* !_MACH_RESOURCES_H */
diff -urN linux-2.6.5-rc2-mm1.orig/include/asm-i386/std_resources.h linux-2.6.5-rc2-mm1/include/asm-i386/std_resources.h
--- linux-2.6.5-rc2-mm1.orig/include/asm-i386/std_resources.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.5-rc2-mm1/include/asm-i386/std_resources.h	2004-03-21 15:52:07.000000000 +0100
@@ -0,0 +1,14 @@
+/*
+ * include/asm-i386/std_resources.h
+ */
+
+#ifndef __ASM_I386_STD_RESOURCES_H
+#define __ASM_I386_STD_RESOURCES_H
+
+#include <linux/init.h>
+
+void probe_roms(void) __init;
+void request_graphics_resource(void) __init;
+void request_standard_io_resources(void) __init;
+
+#endif

--------------010709020909040108010000--

