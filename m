Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWEFK2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWEFK2s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 06:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbWEFK2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 06:28:47 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:53084 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750709AbWEFK2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 06:28:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=W7T5jOQfoN3Gf0eoW5UW95fvW4kwzNcq8Px5VS6uGZXtmE9HEYtNMLkPqXbC0XpgXbfBaDDpztD/FuBLMfrZmrnO/XzTt2TVe2VNS2O9lQITQt197gI5TbFoyq6UhtqQ7arMTNTfINU1DI0lbuZ32tiFOfI0oLbVt3dHU/C3O5I=
Message-ID: <445C7AE9.4060808@gmail.com>
Date: Sat, 06 May 2006 13:31:05 +0300
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: John Coffman <johninsd@san.rr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Barry K. Nathan" <barryn@pobox.com>, Adrian Bunk <bunk@fs.tum.de>,
       tony.luck@intel.com
Subject: Re: [PATCH][TAKE 4] THE LINUX/I386 BOOT PROTOCOL - Breaking    the
 256 limit
References: <445B5524.2090001@gmail.com> <445B5C92.5070401@zytor.com> <445B610A.7020009@gmail.com> <445B62AC.90600@zytor.com> <6.2.3.4.0.20060505110517.036df928@pop-server.san.rr.com> <445B96D2.9070301@zytor.com> <6.2.3.4.0.20060505144445.03642988@pop-server.san.rr.com> <445BCA33.30903@zytor.com> <6.2.3.4.0.20060505204729.036dfdf8@pop-server.san.rr.com> <445C301E.6060509@zytor.com>
In-Reply-To: <445C301E.6060509@zytor.com>
Content-Type: multipart/mixed;
 boundary="------------070601090903030202090004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070601090903030202090004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

H. Peter Anvin wrote:
> John Coffman wrote:
>> At 02:57 PM  Friday 5/5/2006, H. Peter Anvin wrote:
>> Okay, let me ask this:
>>
>>> If the *kernel* limit is modified, but the LILO limit is not, what
>>> will happen?  This is the real crux of the matter.
>>
>> The length of the kernel command line will be limited by the size of
>> the boot loader buffer.  LILO always inserts a NUL terminator.
>>
>> --John
>>
>> P.S.  The LILO command line buffer has always been 1 sector (512
>> bytes); however, only the first half is actually used for the command
>> line. No kernel can do any harm by setting "boot_cmdline[511] = 0;"
>> for any version of LILO back to version 20 (and probably before).
>>
> 
> Okay... **DOES ANYONE HAVE ANY ACTUAL EVIDENCE TO THE CONTRARY???**, and
> if so, **WHAT ARE THE DETAILS**?
> 
> All I've heard so far is hearsay.  "X said that Y had said..."
> 
>     -hpa
> 
> 

So here is an updated patch. Notice that I've removed the
redundant COMMAND_LINE_SIZE from param.h of i386 to make it
closer to other architectures. It was required in the past
to allow a boot loader to know the COMMAND_LINE_SIZE, but
LILO, GRUB, syslinux have a local definition for this, and
is not required in boot protocol >= 2.02 since a boot loader
can pass any null terminated string.

Best Regards,
Alon Bar-Lev.

--------------070601090903030202090004
Content-Type: text/plain;
 name="linux-2.6.17-rc3-x86-command-line.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.17-rc3-x86-command-line.patch"

diff -urNp linux-2.6.17-rc3/include/asm-i386/param.h linux-2.6.17-rc3.new/include/asm-i386/param.h
--- linux-2.6.17-rc3/include/asm-i386/param.h	2006-03-20 07:53:29.000000000 +0200
+++ linux-2.6.17-rc3.new/include/asm-i386/param.h	2006-05-06 12:38:32.000000000 +0300
@@ -19,6 +19,5 @@
 #endif
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
-#define COMMAND_LINE_SIZE 256
 
 #endif
diff -urNp linux-2.6.17-rc3/include/asm-i386/setup.h linux-2.6.17-rc3.new/include/asm-i386/setup.h
--- linux-2.6.17-rc3/include/asm-i386/setup.h	2006-05-06 12:35:09.000000000 +0300
+++ linux-2.6.17-rc3.new/include/asm-i386/setup.h	2006-05-06 12:38:44.000000000 +0300
@@ -15,7 +15,7 @@
 #define MAX_NONPAE_PFN	(1 << 20)
 
 #define PARAM_SIZE 4096
-#define COMMAND_LINE_SIZE 256
+#define COMMAND_LINE_SIZE 2048
 
 #define OLD_CL_MAGIC_ADDR	0x90020
 #define OLD_CL_MAGIC		0xA33F
diff -urNp linux-2.6.17-rc3/include/asm-ia64/setup.h linux-2.6.17-rc3.new/include/asm-ia64/setup.h
--- linux-2.6.17-rc3/include/asm-ia64/setup.h	2006-03-20 07:53:29.000000000 +0200
+++ linux-2.6.17-rc3.new/include/asm-ia64/setup.h	2006-05-06 12:40:32.000000000 +0300
@@ -1,6 +1,6 @@
 #ifndef __IA64_SETUP_H
 #define __IA64_SETUP_H
 
-#define COMMAND_LINE_SIZE	512
+#define COMMAND_LINE_SIZE	2048
 
 #endif

--------------070601090903030202090004--
