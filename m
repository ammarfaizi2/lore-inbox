Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268486AbUJTQ3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268486AbUJTQ3X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 12:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267362AbUJTQ2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 12:28:00 -0400
Received: from fire.osdl.org ([65.172.181.4]:36486 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S268486AbUJTQRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 12:17:35 -0400
Message-ID: <41768D60.3090305@osdl.org>
Date: Wed, 20 Oct 2004 09:08:00 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Andrew Morton <akpm@osdl.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
       davej@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] __init dependencies: ignore __param
References: <24112.1097561162@kao2.melbourne.sgi.com>
In-Reply-To: <24112.1097561162@kao2.melbourne.sgi.com>
Content-Type: multipart/mixed;
 boundary="------------090507000707090204050906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090507000707090204050906
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Keith Owens wrote:
> 
> 
> They may only be OK because the code is never run more than once.
> Normal code that refers to data.*init and is run more than once is a
> bug just waiting to bite you.
> 
> Andrew - small fix for reference_init.pl, against 2.6.9-rc4.
> 
> ------------------------------------------------------------
> 
> Treat .pci_fixup entries the same as .init code/data.
> 
> Signed off by: Keith Owens <kaos@ocs.com.au>
> 
> Index: linux/scripts/reference_init.pl
> ===================================================================
> --- linux.orig/scripts/reference_init.pl	Sat Aug 14 15:37:37 2004
> +++ linux/scripts/reference_init.pl	Tue Oct 12 15:59:39 2004
> @@ -93,6 +93,8 @@ foreach $object (sort(keys(%object))) {
>  		     $from !~ /\.stab$/ &&
>  		     $from !~ /\.rodata$/ &&
>  		     $from !~ /\.text\.lock$/ &&
> +		     $from !~ /\.pci_fixup_header$/ &&
> +		     $from !~ /\.pci_fixup_final$/ &&
>  		     $from !~ /\.debug_/)) {
>  			printf("Error: %s %s refers to %s\n", $object, $from, $line);
>  		}

Keith,

It looks like __param section references can also be safely
ignored by 'reference_init.pl', since they are not discarded AFAIK.
Or am I wrong about that one?
Patch attached -- applies on top of yours.

-- 
~Randy

--------------090507000707090204050906
Content-Type: text/x-patch;
 name="refer_param.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="refer_param.patch"


Ignore __param section references; they aren't discarded.

Error: ./drivers/mtd/devices/phram.o __param refers to 0000000000000010 R_X86_64_64       .init.text+0x0000000000000013
Error: ./drivers/scsi/dc395x.o __param refers to 0000000000000020 R_X86_64_64       .init.data+0x0000000000000064
Error: ./drivers/usb/gadget/ether.o __param refers to 0000000000000048 R_X86_64_64       .init.data+0x0000000000000020

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 scripts/reference_init.pl |    1 +
 1 files changed, 1 insertion(+)

diff -Naurp ./scripts/reference_init.pl~refer_param ./scripts/reference_init.pl
--- ./scripts/reference_init.pl~refer_param	2004-10-20 08:39:44.976489696 -0700
+++ ./scripts/reference_init.pl	2004-10-20 08:45:26.217613160 -0700
@@ -95,6 +95,7 @@ foreach $object (sort(keys(%object))) {
 		     $from !~ /\.text\.lock$/ &&
 		     $from !~ /\.pci_fixup_header$/ &&
 		     $from !~ /\.pci_fixup_final$/ &&
+		     $from !~ /\__param$/ &&
 		     $from !~ /\.debug_/)) {
 			printf("Error: %s %s refers to %s\n", $object, $from, $line);
 		}

--------------090507000707090204050906--
