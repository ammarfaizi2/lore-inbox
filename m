Return-Path: <linux-kernel-owner+w=401wt.eu-S932485AbXAGKtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbXAGKtR (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 05:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbXAGKtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 05:49:16 -0500
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:35575 "EHLO
	smtpq1.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932485AbXAGKtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 05:49:16 -0500
Message-ID: <45A0CFC6.3030707@gmail.com>
Date: Sun, 07 Jan 2007 11:47:34 +0100
From: Rene Herman <rene.herman@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] romsignature/checksum cleanup
References: <458EEDF7.4000200@gmail.com>  <458F20FB.7040900@gmail.com> <1167179512.16175.4.camel@localhost.localdomain> <459310A3.4060706@vmware.com> <459ABA2F.6070907@gmail.com> <459EDDD1.6060208@goop.org> <459F1B82.6000808@gmail.com> <45A0B660.4060505@goop.org> <45A0B71F.1080704@gmail.com> <45A0C977.4070800@goop.org>
In-Reply-To: <45A0C977.4070800@goop.org>
Content-Type: multipart/mixed;
 boundary="------------030503020301070609020602"
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030503020301070609020602
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 01/07/2007 11:20 AM, Jeremy Fitzhardinge wrote:

> Rene Herman wrote:

>> How is it for efficiency? I thought it was for correctness.
>> romsignature is using probe_kernel_adress() while all other accesses
>> to the ROMs there aren't.
>>
>> If nothing else, anyone reading that code is likely to ask himself the
>> very same question -- why the one, and not the others.
> 
> Well, I was wondering about all the uses of __get_user; why not
> probe_kernel_address() everywhere?

It's just a manual version of probe_kernel_adress():

#define probe_kernel_address(addr, retval)              \
         ({                                              \
                 long ret;                               \
                 mm_segment_t old_fs = get_fs();         \
                                                         \
                 set_fs(KERNEL_DS);                      \
                 pagefault_disable();                    \
                 ret = __get_user(retval, [ ... ]);      \
                 pagefault_enable();                     \
                 set_fs(old_fs);                         \
                 ret;                                    \
         })

Doing the set_fs() and pagefault_{disable,enable} calls for every single 
byte during the checksum seems rather silly. The patch as posted has the 
set_fs() and pagefault_ calls only once in probe_roms() (as said when 
posted, I'm not sure the pagefault calls are still useful now that it's 
no longer a generic function/macro, but used directly at probe_roms() time).

> I think its reasonable to assume that if the signature is mapped and 
> correct, then everything else is mapped.  That's certainly the case
> for Xen, which is why I added it.  If you think this is unclear, then
> I think a comment to explain this rather than code changes is the 
> appropriate fix.

I disagree I'm afraid. Given what __get_user compiles to (nothing more 
than a .fixup entry, basically) they're largely "free" and it makes the 
code completely obvious: "If you're touching this, do so via __get_user 
and not directly" and frees it from any assumptions, however reasonable 
or unreasonable.

Would you _mind_ if I submit it? If not, if you could comment on whether 
or not these pagefault calls are still useful, that would be great. The 
comment at probe_kernel_address() says:

  * We ensure that the __get_user() is executed in atomic context so that
  * do_page_fault() doesn't attempt to take mmap_sem. This makes
  * probe_kernel_address() suitable for use within regions where the
  * caller already holds mmap_sem, or other locks which nest inside
  * mmap_sem

This sounds like it might be nonsensical at probe_roms() time, but I'm 
not familiar with these virtualized environments -- I do not know which 
assumptions break.

Patch attached again for reference...

Rene.

--------------030503020301070609020602
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

--------------030503020301070609020602--
