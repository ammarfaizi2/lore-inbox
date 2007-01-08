Return-Path: <linux-kernel-owner+w=401wt.eu-S1030463AbXAHCuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030463AbXAHCuU (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 21:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030464AbXAHCuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 21:50:19 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:64873 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030465AbXAHCuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 21:50:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=Vv4FaKVXXtkuDAad+B2MU489mB+y+ygk5/sgpTyr4rNuiaSEuQWYg7pFoKB5XHnvJ+2tOzokCuBzDicxxDkiY65Edryqq3nPxXsQpTVVAHdeSwO6e6wSli6bJyFKx5I9EVQaj1f02mg4kKmH+v0Kjznrdxb0+9xxuMm8rLqqINE=
Message-ID: <45A1B10B.5080005@gmail.com>
Date: Mon, 08 Jan 2007 03:48:43 +0100
From: Rene Herman <rene.herman@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>
CC: Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] romsignature/checksum cleanup
References: <458EEDF7.4000200@gmail.com>  <458F20FB.7040900@gmail.com> <1167179512.16175.4.camel@localhost.localdomain> <459310A3.4060706@vmware.com> <459ABA2F.6070907@gmail.com> <459EDDD1.6060208@goop.org> <459F1B82.6000808@gmail.com> <45A0B660.4060505@goop.org> <45A0B71F.1080704@gmail.com> <45A0C977.4070800@goop.org> <45A0CFC6.3030707@gmail.com> <45A136CC.60007@goop.org>
In-Reply-To: <45A136CC.60007@goop.org>
Content-Type: multipart/mixed;
 boundary="------------080503020204050402010005"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080503020204050402010005
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 01/07/2007 07:07 PM, Jeremy Fitzhardinge wrote:

> Rene Herman wrote:

>> Doing the set_fs() and pagefault_{disable,enable} calls for every
>> single byte during the checksum seems rather silly.
> 
> Why?

Because it makes for dumb code. But oh well, given that it all compiles 
to basically nothing I guess I'll stop objecting.

Andrew: The attached removes the assumption that if the first page of an 
ISA ROM is mapped, it'll all be mapped. This'll also stop people reading 
this code from wondering if they're looking at a bug.

This replaces "romsignature-checksum-cleanup.patch" in current -mm.

Signed-off-by: Rene Herman <rene.herman@gmail.com>
Not-strongly-objected-to-by: Jeremy Fitzhardinge <jeremy@goop.org>

Rene.

--------------080503020204050402010005
Content-Type: text/plain;
 name="probe_kernel_address.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="probe_kernel_address.diff"

diff --git a/arch/i386/kernel/e820.c b/arch/i386/kernel/e820.c
index f391abc..8b8741f 100644
--- a/arch/i386/kernel/e820.c
+++ b/arch/i386/kernel/e820.c
@@ -156,29 +156,31 @@ static struct resource standard_io_resou
 	.flags	= IORESOURCE_BUSY | IORESOURCE_IO
 } };
 
-static int romsignature(const unsigned char *x)
+#define ROMSIGNATURE 0xaa55
+
+static int __init romsignature(const unsigned char *rom)
 {
+	const unsigned short * const ptr = (const unsigned short *)rom;
 	unsigned short sig;
-	int ret = 0;
-	if (probe_kernel_address((const unsigned short *)x, sig) == 0)
-		ret = (sig == 0xaa55);
-	return ret;
+	
+	return probe_kernel_address(ptr, sig) == 0 && sig == ROMSIGNATURE;
 }
 
-static int __init romchecksum(unsigned char *rom, unsigned long length)
+static int __init romchecksum(const unsigned char *rom, unsigned long length)
 {
-	unsigned char *p, sum = 0;
+	unsigned char sum, c;
 
-	for (p = rom; p < rom + length; p++)
-		sum += *p;
-	return sum == 0;
+	for (sum = 0; length && probe_kernel_address(rom++, c) == 0; length--)
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
 
 	/* video rom */
 	upper = adapter_rom_resources[0].start;
@@ -189,8 +191,11 @@ static void __init probe_roms(void)
 
 		video_rom_resource.start = start;
 
+		if (probe_kernel_address(rom + 2, c) != 0)
+			continue;
+
 		/* 0 < length <= 0x7f * 512, historically */
-		length = rom[2] * 512;
+		length = c * 512;
 
 		/* if checksum okay, trust length byte */
 		if (length && romchecksum(rom, length))
@@ -224,8 +229,11 @@ static void __init probe_roms(void)
 		if (!romsignature(rom))
 			continue;
 
+		if (probe_kernel_address(rom + 2, c) != 0)
+			continue;
+
 		/* 0 < length <= 0x7f * 512, historically */
-		length = rom[2] * 512;
+		length = c * 512;
 
 		/* but accept any length that fits if checksum okay */
 		if (!length || start + length > upper || !romchecksum(rom, length))

--------------080503020204050402010005--
