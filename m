Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263173AbUEQXmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbUEQXmJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 19:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbUEQXlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 19:41:04 -0400
Received: from smtpq3.home.nl ([213.51.128.198]:65429 "EHLO smtpq3.home.nl")
	by vger.kernel.org with ESMTP id S263169AbUEQXka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 19:40:30 -0400
Message-ID: <40A94D06.5060909@keyaccess.nl>
Date: Tue, 18 May 2004 01:38:46 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040117
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: [2.6.6-mm3] 3/3: same small tweaks, x86_64 version
Content-Type: multipart/mixed;
 boundary="------------040203030805020907040804"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040203030805020907040804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew.

The same small tweaks for x86_64. Just to keep the two in sync. One
additional wrinkle: vram_resource was exported to e820.c, which didn't
actually use it. Undo that.

(cross-)compiled but not booted due to lack of hardware.

Rene.


--------------040203030805020907040804
Content-Type: text/plain;
 name="linux-2.6.6-mm3_resources-smallstuff-x86_64.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.6-mm3_resources-smallstuff-x86_64.diff"

diff -urN linux-2.6.6-mm3.orig/arch/x86_64/kernel/e820.c linux-2.6.6-mm3/arch/x86_64/kernel/e820.c
--- linux-2.6.6-mm3.orig/arch/x86_64/kernel/e820.c	2004-04-04 05:36:53.000000000 +0200
+++ linux-2.6.6-mm3/arch/x86_64/kernel/e820.c	2004-05-18 00:06:14.000000000 +0200
@@ -34,7 +34,7 @@
  */
 unsigned long end_user_pfn = MAXMEM>>PAGE_SHIFT;  
 
-extern struct resource code_resource, data_resource, vram_resource;
+extern struct resource code_resource, data_resource;
 
 /* Check for some hardcoded bad areas that early boot is not allowed to touch */ 
 static inline int bad_addr(unsigned long *addrp, unsigned long size)
diff -urN linux-2.6.6-mm3.orig/arch/x86_64/kernel/setup.c linux-2.6.6-mm3/arch/x86_64/kernel/setup.c
--- linux-2.6.6-mm3.orig/arch/x86_64/kernel/setup.c	2004-05-17 03:18:31.000000000 +0200
+++ linux-2.6.6-mm3/arch/x86_64/kernel/setup.c	2004-05-18 00:18:31.000000000 +0200
@@ -116,9 +116,10 @@
 #define STANDARD_IO_RESOURCES \
 	(sizeof standard_io_resources / sizeof standard_io_resources[0])
 
-struct resource code_resource = { "Kernel code", 0x100000, 0, IORESOURCE_MEM };
-struct resource data_resource = { "Kernel data", 0, 0, IORESOURCE_MEM };
-struct resource vram_resource = { "Video RAM area", 0xa0000, 0xbffff, IORESOURCE_BUSY | IORESOURCE_MEM };
+#define IORESOURCE_RAM (IORESOURCE_BUSY | IORESOURCE_MEM)
+	
+struct resource data_resource = { "Kernel data", 0, 0, IORESOURCE_RAM };
+struct resource code_resource = { "Kernel code", 0, 0, IORESOURCE_RAM };
 
 #define IORESOURCE_ROM (IORESOURCE_BUSY | IORESOURCE_READONLY | IORESOURCE_MEM)
 
@@ -138,10 +139,11 @@
 	(sizeof adapter_rom_resources / sizeof adapter_rom_resources[0])
 
 static struct resource video_rom_resource = { "Video ROM", 0xc0000, 0xc7fff, IORESOURCE_ROM };
+static struct resource video_ram_resource = { "Video RAM area", 0xa0000, 0xbffff, IORESOURCE_RAM };
 
 #define romsignature(x) (*(unsigned short *)(x) == 0xaa55)
 
-static int __init checksum(unsigned char *rom, unsigned long length)
+static int __init romchecksum(unsigned char *rom, unsigned long length)
 {
 	unsigned char *p, sum = 0;
 
@@ -169,7 +171,7 @@
 		length = rom[2] * 512;
 
 		/* if checksum okay, trust length byte */
-		if (length && checksum(rom, length))
+		if (length && romchecksum(rom, length))
 			video_rom_resource.end = start + length - 1;
 
 		request_resource(&iomem_resource, &video_rom_resource);
@@ -188,7 +190,7 @@
 	rom = isa_bus_to_virt(extension_rom_resource.start);
 	if (romsignature(rom)) {
 		length = extension_rom_resource.end - extension_rom_resource.start + 1;
-		if (checksum(rom, length)) {
+		if (romchecksum(rom, length)) {
 			request_resource(&iomem_resource, &extension_rom_resource);
 			upper = extension_rom_resource.start;
 		}
@@ -204,7 +206,7 @@
 		length = rom[2] * 512;
 
 		/* but accept any length that fits if checksum okay */
-		if (!length || start + length > upper || !checksum(rom, length))
+		if (!length || start + length > upper || !romchecksum(rom, length))
 			continue;
 
 		adapter_rom_resources[i].start = start;
@@ -554,13 +556,13 @@
 	probe_roms();
 	e820_reserve_resources(); 
 
-	request_resource(&iomem_resource, &vram_resource);
+	request_resource(&iomem_resource, &video_ram_resource);
 
 	{
 	unsigned i;
 	/* request I/O space for devices used on all i[345]86 PCs */
 	for (i = 0; i < STANDARD_IO_RESOURCES; i++)
-		request_resource(&ioport_resource, standard_io_resources+i);
+		request_resource(&ioport_resource, &standard_io_resources[i]);
 	}
 
 	/* Will likely break when you have unassigned resources with more

--------------040203030805020907040804--
