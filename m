Return-Path: <linux-kernel-owner+w=401wt.eu-S1751165AbXAFDrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbXAFDrz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 22:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbXAFDrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 22:47:55 -0500
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:50209 "EHLO
	smtpq1.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbXAFDry (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 22:47:54 -0500
Message-ID: <459F1B82.6000808@gmail.com>
Date: Sat, 06 Jan 2007 04:46:10 +0100
From: Rene Herman <rene.herman@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] romsignature/checksum cleanup
References: <458EEDF7.4000200@gmail.com>  <458F20FB.7040900@gmail.com> <1167179512.16175.4.camel@localhost.localdomain> <459310A3.4060706@vmware.com> <459ABA2F.6070907@gmail.com> <459EDDD1.6060208@goop.org>
In-Reply-To: <459EDDD1.6060208@goop.org>
Content-Type: multipart/mixed;
 boundary="------------090709060704050500080803"
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090709060704050500080803
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Jeremy Fitzhardinge wrote:

> Well, in the Xen case, where the pages are simply not mapped, then
> the signature simply won't exist.  In other cases, I guess its
> possible the signature might exist but the rest of the ROM doesn't,
> but that won't happen on normal hardware.

In your opinion, is the attached (versus 2.6.20-rc3) better? This uses 
probe_kernel_address() for all accesses. Or rather, an expanded version 
thereof. The set_fs() and pagefault_{disable,enable} calls are only done 
once in probe_roms().

Accessing the length byte at rom[2] with __get_user() is overkill after 
just checking the signature at 0 and 1 but direcly accessing only that 
makes for inconsistent code IMO. It's only a .fixup entry...

I can't say I'm all that sure that that pagefault_disable() call is 
still applicable now that it got expanded into the probe_roms() stage?

Rene.


--------------090709060704050500080803
Content-Type: text/plain;
 name="probe_kernel_address.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="probe_kernel_address.diff"

commit f153a588097c08cefdb799f22123192a9975d273
Author: Rene Herman <rene.herman@gmail.com>
Date:   Sat Jan 6 04:09:32 2007 +0100

    Use __get_user() for ISA ROM accesses.
    
    In virtualized environments, the ISA ROMs may not be mapped so be careful
    about touching them.
    
    Signed-off-by: Rene Herman <rene.herman@gmail.com>

diff --git a/arch/i386/kernel/e820.c b/arch/i386/kernel/e820.c
index f391abc..8b54f65 100644
--- a/arch/i386/kernel/e820.c
+++ b/arch/i386/kernel/e820.c
@@ -156,29 +156,34 @@ static struct resource standard_io_resou
 	.flags	= IORESOURCE_BUSY | IORESOURCE_IO
 } };
 
-static int romsignature(const unsigned char *x)
+#define ROM_SIG 0xaa55
+
+static int __init romsignature(const unsigned char *rom)
 {
 	unsigned short sig;
-	int ret = 0;
-	if (probe_kernel_address((const unsigned short *)x, sig) == 0)
-		ret = (sig == 0xaa55);
-	return ret;
+	
+	return !__get_user(sig, (const unsigned short *)rom) && sig == ROM_SIG;
 }
 
-static int __init romchecksum(unsigned char *rom, unsigned long length)
+static int __init romchecksum(const unsigned char *rom, unsigned long length)
 {
-	unsigned char *p, sum = 0;
+	unsigned char sum, c;
 
-	for (p = rom; p < rom + length; p++)
-		sum += *p;
-	return sum == 0;
+	for (sum = 0; length && !__get_user(c, rom); rom++, length--)
+		sum += c;
+	return !length && !sum;
 }
 
 static void __init probe_roms(void)
 {
+	const unsigned char *rom;
 	unsigned long start, length, upper;
-	unsigned char *rom;
-	int	      i;
+	unsigned char c;
+	int i;
+	mm_segment_t old_fs = get_fs();
+
+	set_fs(KERNEL_DS);
+	pagefault_disable();
 
 	/* video rom */
 	upper = adapter_rom_resources[0].start;
@@ -189,8 +194,11 @@ static void __init probe_roms(void)
 
 		video_rom_resource.start = start;
 
+		if (__get_user(c, rom + 2))
+			continue;
+
 		/* 0 < length <= 0x7f * 512, historically */
-		length = rom[2] * 512;
+		length = c * 512;
 
 		/* if checksum okay, trust length byte */
 		if (length && romchecksum(rom, length))
@@ -224,8 +232,11 @@ static void __init probe_roms(void)
 		if (!romsignature(rom))
 			continue;
 
+		if (__get_user(c, rom + 2))
+			continue;
+
 		/* 0 < length <= 0x7f * 512, historically */
-		length = rom[2] * 512;
+		length = c * 512;
 
 		/* but accept any length that fits if checksum okay */
 		if (!length || start + length > upper || !romchecksum(rom, length))
@@ -237,6 +248,9 @@ static void __init probe_roms(void)
 
 		start = adapter_rom_resources[i++].end & ~2047UL;
 	}
+
+	pagefault_enable();
+	set_fs(old_fs);
 }
 
 /*

--------------090709060704050500080803--
