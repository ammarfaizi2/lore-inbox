Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265551AbUFCPLB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265551AbUFCPLB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 11:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265602AbUFCPK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 11:10:29 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:4842 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264108AbUFCPJY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 11:09:24 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Aric Cyr <acyr@alumni.uwaterloo.ca>
Subject: Re: [PATCH] nForce2 C1halt fixup, again
Date: Thu, 3 Jun 2004 17:12:51 +0200
User-Agent: KMail/1.5.3
References: <20040604112618.A1789%acyr@alumni.uwaterloo.ca>
In-Reply-To: <20040604112618.A1789%acyr@alumni.uwaterloo.ca>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406031712.51458.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 of June 2004 04:26, Aric Cyr wrote:
> With so many people reporting that 2.6.6 fixed the nForce2 hard lock
> problem I soon started using it.  However, on my system it would still
> lock up!  I tried disabling APIC, IO-APIC, ACPI, PREEMPT, etc. to no
> avail.
>
> After looking into the pci_fixup_nforce2() function, I saw that it was
> expecting one of two cases for the PCI config value: 0x1F0FFF01 or
> 0x9F0FFF01, then, depending on the PCI revision ID it would set the
> config value to 0x1F01FF01 or 0x9F01FF01 resp. I looked at the value
> of my nForce2 board and saw that it was actually 0x8F0FFF01.
>
> So the current 2.6.6 fixup was inadvertently flipping the high nibble
> to 0x9 in my case.  Since the fixup is actually idependent of the PCI
> revision ID (the 5th nibble is changed from 0xF to 0x1 in either
> case), I tried explicitly changing only that part of the config value.
> Sure enough, for the first time in a while my system is finally stable
> again.
>
> My patch is attached.  Comments please!

If bit 0x10000000 is not set then C1 Halt Disconnect is disabled.
I have reports that it is unsupported on some boards.

So what about patch below instead?


[PATCH] apply nForce2 fixup only if C1 Halt Disconnect is enabled

Some boards don't support C1 Halt Disconnect.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-rc2-bk2-bzolnier/arch/i386/pci/fixup.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

diff -puN arch/i386/pci/fixup.c~nForce2_C1Halt_fixup arch/i386/pci/fixup.c
--- linux-2.6.7-rc2-bk2/arch/i386/pci/fixup.c~nForce2_C1Halt_fixup	2004-06-03 16:52:46.556771744 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/arch/i386/pci/fixup.c	2004-06-03 16:58:17.275494856 +0200
@@ -226,7 +226,12 @@ static void __init pci_fixup_nforce2(str
 	fixed_val = rev < 0xC1 ? 0x1F01FF01 : 0x9F01FF01;
 
 	pci_read_config_dword(dev, 0x6c, &val);
-	if (val != fixed_val) {
+
+	/*
+	 * Apply fixup only if C1 Halt Disconnect is enabled
+	 * (bit28) because it is not supported on some boards.
+	 */
+	if ((val & (1 << 28)) && val != fixed_val) {
 		printk(KERN_WARNING "PCI: nForce2 C1 Halt Disconnect fixup\n");
 		pci_write_config_dword(dev, 0x6c, fixed_val);
 	}

_

