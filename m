Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268752AbUJKKBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268752AbUJKKBE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 06:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268745AbUJKKBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 06:01:04 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:5216 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268752AbUJKKAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 06:00:23 -0400
Message-ID: <416A5857.1090307@yahoo.com.au>
Date: Mon, 11 Oct 2004 19:54:31 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>
Subject: Re: Linux 2.6.9-rc4 - pls test (and no more patches)
References: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------050707070002080901090505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050707070002080901090505
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> Ok, 
>  trying to make ready for the real 2.6.9 in a week or so, so please give
> this a beating, and if you have pending patches, please hold on to them
> for a bit longer, until after the 2.6.9 release. It would be good to have
> a 2.6.9 that doesn't need a dot-release immediately ;)
> 
> The appended shortlog gives a pretty good idea of what has been going on. 
> Mostly small stuff, with some architecture updates and an ACPI update 
> thrown in for good measure.
> 
> (The ACPI update fixes broken AML with implied returns, and in particular
> the Compaq Evo notebook fan control. Yay! Guess who has one..)
> 
> 		Linus
> 

ACPI still explodes on my old PII and stops it booting. (I've reported it
to Len a few times but he seems to be ignoring me).

Anyway, it is oopsing in drivers/acpi/scan.c line 207 where element
(which is NULL) gets dereferenced.

Adding a WARN_ON and return AE_BAD_PARAMETER for the element==NULL case
gives the following:

Badness in acpi_bus_extract_wakeup_device_power_package at drivers/acpi/scan.c:208
  [<c021f8bf>] acpi_bus_extract_wakeup_device_power_package+0xfe/0x14b
  [<c021f941>] acpi_bus_get_wakeup_device_flags+0x35/0x89
  [<c021ff83>] acpi_bus_add+0xd4/0x152
  [<c0220105>] acpi_bus_scan+0x104/0x156
  [<c03d7742>] acpi_scan_init+0x48/0x5e
  [<c03c57f4>] do_initcalls+0x54/0xc0
  [<c0100410>] init+0x0/0x100
  [<c0100410>] init+0x0/0x100
  [<c010043a>] init+0x2a/0x100
  [<c0102078>] kernel_thread_helper+0x0/0x18
  [<c010207d>] kernel_thread_helper+0x5/0x18
  [<c0100410>] init+0x0/0x100
  [<c010043a>] init+0x2a/0x100
  [<c0102078>] kernel_thread_helper+0x0/0x18
  [<c010207d>] kernel_thread_helper+0x5/0x18

The ACPI bios on this thing has always seemed to be pretty broken, but
this at least allows the 'power' button to continue to work (the only
reason why I want ACPI).


Hmm... I don't want to hold up the release for this isolated problem.
Maybe if you're forced to do another -rc I could send in a trivial two
liner? (what's the policy with such a situation?)

--------------050707070002080901090505
Content-Type: text/x-patch;
 name="acpi-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi-fix.patch"




---

 linux-2.6-npiggin/drivers/acpi/scan.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN drivers/acpi/scan.c~acpi-fix drivers/acpi/scan.c
--- linux-2.6/drivers/acpi/scan.c~acpi-fix	2004-10-11 19:44:36.000000000 +1000
+++ linux-2.6-npiggin/drivers/acpi/scan.c	2004-10-11 19:44:51.000000000 +1000
@@ -204,6 +204,8 @@ acpi_bus_extract_wakeup_device_power_pac
 		return AE_BAD_PARAMETER;
 
 	element = &(package->package.elements[0]);
+	if (!element)
+		return AE_BAD_PARAMETER;
 	if (element->type == ACPI_TYPE_PACKAGE) {
 		if ((element->package.count < 2) ||
 			(element->package.elements[0].type != ACPI_TYPE_LOCAL_REFERENCE) ||

_

--------------050707070002080901090505--
