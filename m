Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbUDIWXI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 18:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbUDIWXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 18:23:08 -0400
Received: from smtpq2.home.nl ([213.51.128.197]:6315 "EHLO smtpq2.home.nl")
	by vger.kernel.org with ESMTP id S261822AbUDIWWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 18:22:34 -0400
Message-ID: <407721EB.20708@keyaccess.nl>
Date: Sat, 10 Apr 2004 00:21:31 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031029
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.5-mm3, x86_64: probe_roms()
References: <4076CDA5.4090609@keyaccess.nl> <20040409190205.1781d33d.ak@suse.de>
In-Reply-To: <20040409190205.1781d33d.ak@suse.de>
Content-Type: multipart/mixed;
 boundary="------------010005070702000201020705"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010005070702000201020705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andi Kleen wrote:

>>x86_64 inherits arch/x86_64/kernel/setup.c:probe_roms() from i386 and 
>>shares its problems (minus the first) described at:
>>
>>http://marc.theaimsgroup.com/?l=linux-kernel&m=107991009932451&w=2
>>
>>Like the i386 version, the attached x86_64 version also c99ifies the 
>>data and adds IORESOURCE_* type flags. It's been (cross-)compiled but 
>>not booted due to lack of hardware.
> 
> The C99ification is really ugly, because the tables end up more or less 
> unreadable unlike the previous version.

Our tastes differ. Dec99ed version attached.

> I don't think it's a good idea to use values from the ROM unchecked
> (like you did with the length for the checksum). In fact this
> checksum change looks quite dangerous on i386 because there is very
> likely a machine out somewhere with bogus length bytes which explodes
> when you do an access after the video ROM.

This is not the case though. As to the "unchecked"; the only way _to_ 
check the length byte is via the checksum. The new code accepts it if it 
checks out, and hardcodes 0xc7fff as before if not. The only other thing 
that could be done is accept the length byte unconditionally which is 
inadvisable since, as you say, it's somewhat likely that there's some 
VGA out there with a bogus length byte. But note, somewhat, not very. A 
"standard PC BIOS" checks it the same as this code does.

Futhermore, note how the original code already unconditionally touched 
every 2k boundary between c8000 and e0000. So for this to be a problem, 
you'd need a VGA ROM smaller than 32K, a bogus length byte and this 
unthinkable chipset erratum that makes the machine explode while doing 
an access after the videorom, but before c8000, and didn't do so while 
the BIOS did the same thing on boot.

> Chipsets sometimes have interesting errata in these areas.
> [that's probably more an issue on i386 than on x86-64, but it's better
> to be safe than sorry]

It's not an issue on i386 either. I'm all for caution, and yes, I do 
know all about the vast amount of broken PC hardware out there, but 
there's defensive programming and then there's madness :-)

> The other changes look ok. If you send me a patch just for these 
> I will apply it.

Hope you agree with this c99less version given the explanation. As said, 
the only other option is to accept the length byte without any check 
whatsoever or hardcoding it as 32K as the current code does which is not 
nice with almost all current-day VGAs hosting a larger ROM. That, in 
fact, was the reason I looked there; linux confused me by claiming 
(through /proc/iomem) that I had a 32K ROM, while it's actually 48K.

Rene.

--------------010005070702000201020705
Content-Type: text/plain;
 name="linux-2.6.5-mm3_x86_64-probe_roms-c89.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.5-mm3_x86_64-probe_roms-c89.diff"

--- linux-2.6.5-mm3/arch/x86_64/kernel/setup.c.orig	2004-04-09 16:37:44.000000000 +0200
+++ linux-2.6.5-mm3/arch/x86_64/kernel/setup.c	2004-04-09 22:35:07.000000000 +0200
@@ -102,91 +102,115 @@
 char command_line[COMMAND_LINE_SIZE];
 
 struct resource standard_io_resources[] = {
-	{ "dma1", 0x00, 0x1f, IORESOURCE_BUSY },
-	{ "pic1", 0x20, 0x21, IORESOURCE_BUSY },
-	{ "timer", 0x40, 0x5f, IORESOURCE_BUSY },
-	{ "keyboard", 0x60, 0x6f, IORESOURCE_BUSY },
-	{ "dma page reg", 0x80, 0x8f, IORESOURCE_BUSY },
-	{ "pic2", 0xa0, 0xa1, IORESOURCE_BUSY },
-	{ "dma2", 0xc0, 0xdf, IORESOURCE_BUSY },
-	{ "fpu", 0xf0, 0xff, IORESOURCE_BUSY }
+	{ "dma1", 0x00, 0x1f, IORESOURCE_BUSY | IORESOURCE_IO },
+	{ "pic1", 0x20, 0x21, IORESOURCE_BUSY | IORESOURCE_IO },
+	{ "timer", 0x40, 0x5f, IORESOURCE_BUSY | IORESOURCE_IO },
+	{ "keyboard", 0x60, 0x6f, IORESOURCE_BUSY | IORESOURCE_IO },
+	{ "dma page reg", 0x80, 0x8f, IORESOURCE_BUSY | IORESOURCE_IO },
+	{ "pic2", 0xa0, 0xa1, IORESOURCE_BUSY | IORESOURCE_IO },
+	{ "dma2", 0xc0, 0xdf, IORESOURCE_BUSY | IORESOURCE_IO },
+	{ "fpu", 0xf0, 0xff, IORESOURCE_BUSY | IORESOURCE_IO }
 };
 
-#define STANDARD_IO_RESOURCES (sizeof(standard_io_resources)/sizeof(struct resource))
+#define STANDARD_IO_RESOURCES \
+	(sizeof standard_io_resources / sizeof standard_io_resources[0])
 
-struct resource code_resource = { "Kernel code", 0x100000, 0 };
-struct resource data_resource = { "Kernel data", 0, 0 };
-struct resource vram_resource = { "Video RAM area", 0xa0000, 0xbffff, IORESOURCE_BUSY };
-
-/* System ROM resources */
-#define MAXROMS 6
-static struct resource rom_resources[MAXROMS] = {
-	{ "System ROM", 0xF0000, 0xFFFFF, IORESOURCE_BUSY },
-	{ "Video ROM", 0xc0000, 0xc7fff, IORESOURCE_BUSY }
+struct resource code_resource = { "Kernel code", 0x100000, 0, IORESOURCE_MEM };
+struct resource data_resource = { "Kernel data", 0, 0, IORESOURCE_MEM };
+struct resource vram_resource = { "Video RAM area", 0xa0000, 0xbffff, IORESOURCE_BUSY | IORESOURCE_MEM };
+
+#define IORESOURCE_ROM (IORESOURCE_BUSY | IORESOURCE_READONLY | IORESOURCE_MEM)
+
+static struct resource system_rom_resource = { "System ROM", 0xf0000, 0xfffff, IORESOURCE_ROM };
+static struct resource extension_rom_resource = { "Extension ROM", 0xe0000, 0xeffff, IORESOURCE_ROM };
+
+static struct resource adapter_rom_resources[] = {
+	{ "Adapter ROM", 0xc8000, 0, IORESOURCE_ROM },
+	{ "Adapter ROM", 0, 0, IORESOURCE_ROM },
+	{ "Adapter ROM", 0, 0, IORESOURCE_ROM },
+	{ "Adapter ROM", 0, 0, IORESOURCE_ROM },
+	{ "Adapter ROM", 0, 0, IORESOURCE_ROM },
+	{ "Adapter ROM", 0, 0, IORESOURCE_ROM }
 };
 
+#define ADAPTER_ROM_RESOURCES \
+	(sizeof adapter_rom_resources / sizeof adapter_rom_resources[0])
+
+static struct resource video_rom_resource = { "Video ROM", 0xc0000, 0xc7fff, IORESOURCE_ROM };
+
 #define romsignature(x) (*(unsigned short *)(x) == 0xaa55)
 
+static int __init checksum(unsigned char *rom, unsigned long length)
+{
+	unsigned char *p, sum = 0;
+
+	for (p = rom; p < rom + length; p++)
+		sum += *p;
+	return sum == 0;
+}
+
 static void __init probe_roms(void)
 {
-	int roms = 1;
-	unsigned long base;
-	unsigned char *romstart;
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
 

--------------010005070702000201020705--

