Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbUCUXC0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 18:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbUCUXC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 18:02:26 -0500
Received: from smtpq1.home.nl ([213.51.128.196]:60092 "EHLO smtpq1.home.nl")
	by vger.kernel.org with ESMTP id S261462AbUCUXAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 18:00:40 -0500
Message-ID: <405E1E68.7060507@keyaccess.nl>
Date: Sun, 21 Mar 2004 23:59:52 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031029
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Osamu Tomita <tomita@cinet.co.jp>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] 2.6.5-rc2{,-mm1} i386 probe_roms() damage
Content-Type: multipart/mixed;
 boundary="------------030109040901080701000404"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030109040901080701000404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew.

This patch tries to improve the i386/mach-default probe_roms(). See 0/2
for the problems it tries to solve. This also c99ifies the data, adds an
IORESOURCE_IO flag for the I/O port resources, an IORESOURCE_MEM flag
for the VRAM resource, IORESOURCE_READONLY | IORESOURCE_MEM for the ROM
resources and adds two additional "adapter ROM slots" (for a total of 6)
since it now also scans the 0xe0000 segment.

Hope this is useful...

Rene.




--------------030109040901080701000404
Content-Type: text/plain;
 name="01-linux-2.6.5-rc2-mm1_i386-probe_roms.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-linux-2.6.5-rc2-mm1_i386-probe_roms.diff"

diff -urN linux-2.6.5-rc2-mm1.orig/arch/i386/mach-default/std_resources.c linux-2.6.5-rc2-mm1/arch/i386/mach-default/std_resources.c
--- linux-2.6.5-rc2-mm1.orig/arch/i386/mach-default/std_resources.c	2004-03-21 16:16:36.000000000 +0100
+++ linux-2.6.5-rc2-mm1/arch/i386/mach-default/std_resources.c	2004-03-21 16:22:06.000000000 +0100
@@ -1,96 +1,192 @@
 /*
  *  Machine specific resource allocation for generic.
- *  Split out from setup.c by Osamu Tomita <tomita@cinet.co.jp>
  */
 
 #include <linux/ioport.h>
 #include <asm/io.h>
 #include <asm/std_resources.h>
 
-static struct resource standard_io_resources[] = {
-	{ "dma1", 0x00, 0x1f, IORESOURCE_BUSY },
-	{ "pic1", 0x20, 0x21, IORESOURCE_BUSY },
-	{ "timer", 0x40, 0x5f, IORESOURCE_BUSY },
-	{ "keyboard", 0x60, 0x6f, IORESOURCE_BUSY },
-	{ "dma page reg", 0x80, 0x8f, IORESOURCE_BUSY },
-	{ "pic2", 0xa0, 0xa1, IORESOURCE_BUSY },
-	{ "dma2", 0xc0, 0xdf, IORESOURCE_BUSY },
-	{ "fpu", 0xf0, 0xff, IORESOURCE_BUSY }
-};
+#define romsignature(x) (*(unsigned short *)(x) == 0xaa55)
 
-#define STANDARD_IO_RESOURCES (sizeof(standard_io_resources)/sizeof(struct resource))
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
 
-static struct resource vram_resource = { "Video RAM area", 0xa0000, 0xbffff, IORESOURCE_BUSY };
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
 
-/* System ROM resources */
-#define MAXROMS 6
-static struct resource rom_resources[MAXROMS] = {
-	{ "System ROM", 0xF0000, 0xFFFFF, IORESOURCE_BUSY },
-	{ "Video ROM", 0xc0000, 0xc7fff, IORESOURCE_BUSY }
+static struct resource vram_resource = {
+	.name	= "Video RAM area",
+	.start	= 0xa0000,
+	.end	= 0xbffff,
+	.flags	= IORESOURCE_BUSY | IORESOURCE_MEM
 };
 
-#define romsignature(x) (*(unsigned short *)(x) == 0xaa55)
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
 
+static int __init checksum(unsigned char *rom, unsigned long length)
+{
+	unsigned char *p, sum = 0;
+
+	for (p = rom; p < rom + length; p++)
+		sum += *p;
+	return sum == 0;
+}
+	
 void __init probe_roms(void)
 {
-	unsigned long base;
-	unsigned char *romstart;
-	int roms = 1;
-
-	request_resource(&iomem_resource, rom_resources+0);
-
-	/* Video ROM is standard at C000:0000 - C7FF:0000, check signature */
-	for (base = 0xC0000; base < 0xE0000; base += 2048) {
-		romstart = isa_bus_to_virt(base);
-		if (!romsignature(romstart))
+	unsigned long start, length, upper;
+	unsigned char *rom;
+	int	      i;
+	
+	/* video rom */
+	upper = adapter_rom_resources[0].start;
+	for (start = video_rom_resource.start; start < upper; start += 2048) {
+		rom = isa_bus_to_virt(start);
+		if (!romsignature(rom))
 			continue;
-		request_resource(&iomem_resource, rom_resources + roms);
-		roms++;
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
 		break;
 	}
 
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
 		}
 	}
 
-	/* Final check for motherboard extension rom at E000:0000 */
-	base = 0xE0000;
-	romstart = isa_bus_to_virt(base);
-
-	if (romsignature(romstart)) {
-		rom_resources[roms].start = base;
-		rom_resources[roms].end = base + 65535;
-		rom_resources[roms].name = "Extension ROM";
-		rom_resources[roms].flags = IORESOURCE_BUSY;
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
 
-		request_resource(&iomem_resource, rom_resources + roms);
+		start = adapter_rom_resources[i++].end & ~2047UL;
 	}
 }
 
@@ -104,5 +200,5 @@
 	int i;
 
 	for (i = 0; i < STANDARD_IO_RESOURCES; i++)
-		request_resource(&ioport_resource, standard_io_resources+i);
+		request_resource(&ioport_resource, &standard_io_resources[i]);
 }

--------------030109040901080701000404--

