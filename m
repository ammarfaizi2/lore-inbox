Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263167AbUEQXku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263167AbUEQXku (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 19:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbUEQXku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 19:40:50 -0400
Received: from smtpq2.home.nl ([213.51.128.197]:7815 "EHLO smtpq2.home.nl")
	by vger.kernel.org with ESMTP id S263167AbUEQXkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 19:40:24 -0400
Message-ID: <40A94CFF.2020005@keyaccess.nl>
Date: Tue, 18 May 2004 01:38:39 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040117
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: [2.6.6-mm3] 2/3: small tweaks to standard resource stuff
Content-Type: multipart/mixed;
 boundary="------------050204050704050303010200"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050204050704050303010200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew.

Various small tweaks. Compiled and booted.

1. add IORESOURCE_BUSY | IORESOURCE_MEM also for the kernel code and
     data resources. I don't believe this actually matters one bit, but
     they're hooked into a BUSY/MEM parent ("System RAM") and marking
     them busy seems to make sense.

2. delete the .start = 1M default for the kernel code resource. This
     isn't actually a change; it's set to virt_to_phys(_text) in
     setup_arch() overriding any default anyways.

3. s/vram_resource/video_ram_resource/. Lines up much nicer with
     video_rom_resource...

4. s/checksum/romchecksum/. setup.c is a fairly large file, and
     "checksum" pollutes the namespace.

If pc9800 doesn't go after all, I'll resubmit this against the current
setup once it's back.

Rene.


--------------050204050704050303010200
Content-Type: text/plain;
 name="linux-2.6.6-mm3_resources-smallstuff.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.6-mm3_resources-smallstuff.diff"

diff -urN linux-2.6.6-mm3.orig/arch/i386/kernel/setup.c linux-2.6.6-mm3/arch/i386/kernel/setup.c
--- linux-2.6.6-mm3.orig/arch/i386/kernel/setup.c	2004-05-17 23:43:50.000000000 +0200
+++ linux-2.6.6-mm3/arch/i386/kernel/setup.c	2004-05-17 23:37:36.000000000 +0200
@@ -136,13 +136,15 @@
 static struct resource data_resource = {
 	.name	= "Kernel data",
 	.start	= 0,
-	.end	= 0
+	.end	= 0,
+	.flags	= IORESOURCE_BUSY | IORESOURCE_MEM
 };
 
 static struct resource code_resource = {
 	.name	= "Kernel code",
-	.start	= 0x100000,
-	.end	= 0
+	.start	= 0,
+	.end	= 0,
+	.flags	= IORESOURCE_BUSY | IORESOURCE_MEM
 };
 
 static struct resource system_rom_resource = {
@@ -201,7 +203,7 @@
 	.flags	= IORESOURCE_BUSY | IORESOURCE_READONLY | IORESOURCE_MEM
 };
 
-static struct resource vram_resource = {
+static struct resource video_ram_resource = {
 	.name	= "Video RAM area",
 	.start	= 0xa0000,
 	.end	= 0xbffff,
@@ -255,7 +257,7 @@
 
 #define romsignature(x) (*(unsigned short *)(x) == 0xaa55)
 	
-static int __init checksum(unsigned char *rom, unsigned long length)
+static int __init romchecksum(unsigned char *rom, unsigned long length)
 {
 	unsigned char *p, sum = 0;
 
@@ -283,7 +285,7 @@
 		length = rom[2] * 512;
 
 		/* if checksum okay, trust length byte */
-		if (length && checksum(rom, length))
+		if (length && romchecksum(rom, length))
 			video_rom_resource.end = start + length - 1;
 
 		request_resource(&iomem_resource, &video_rom_resource);
@@ -302,7 +304,7 @@
 	rom = isa_bus_to_virt(extension_rom_resource.start);
 	if (romsignature(rom)) {
 		length = extension_rom_resource.end - extension_rom_resource.start + 1;
-		if (checksum(rom, length)) {
+		if (romchecksum(rom, length)) {
 			request_resource(&iomem_resource, &extension_rom_resource);
 			upper = extension_rom_resource.start;
 		}
@@ -318,7 +320,7 @@
 		length = rom[2] * 512;
 
 		/* but accept any length that fits if checksum okay */
-		if (!length || start + length > upper || !checksum(rom, length))
+		if (!length || start + length > upper || !romchecksum(rom, length))
 			continue;
 
 		adapter_rom_resources[i].start = start;
@@ -1149,7 +1151,7 @@
 		legacy_init_iomem_resources(&code_resource, &data_resource);
 
 	/* EFI systems may still have VGA */
-	request_resource(&iomem_resource, &vram_resource);
+	request_resource(&iomem_resource, &video_ram_resource);
 
 	/* request I/O space for devices used on all i[345]86 PCs */
 	for (i = 0; i < STANDARD_IO_RESOURCES; i++)

--------------050204050704050303010200--
