Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264496AbUEJCRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264496AbUEJCRt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 22:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264495AbUEJCRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 22:17:49 -0400
Received: from fmr02.intel.com ([192.55.52.25]:29906 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S264500AbUEJCQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 22:16:22 -0400
Subject: Re: hdc: lost interrupt ide-cd: cmd 0x3 timed out ...
From: Len Brown <len.brown@intel.com>
To: Bob Gill <gillb4@telusplanet.net>
Cc: Alex Riesen <fork0@users.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1084135217.4430.141.camel@localhost.localdomain>
References: <A6974D8E5F98D511BB910002A50A6647615FAE21@hdsmsx403.hd.intel.com>
	 <1084071367.2326.62.camel@dhcppc4>
	 <1084135217.4430.141.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-dB+ge7OdpC2LWRV2plqF"
Organization: 
Message-Id: <1084155368.12352.26.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 09 May 2004 22:16:08 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dB+ge7OdpC2LWRV2plqF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Bob,
thanks for the info.
The BIOS on this box has a bug where it is reporting a current
IRQ to be outside the list of possible IRQs:

ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15) *9

It then references this with pinA of device 9:

Package (0x04) { 0x0009FFFF, 0x00, \_SB.PCI0.LNKB, 0x00 },

which is
00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
07)

In the past, we'd enable this on IRQ9, even thought it is illegal.

ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9

But we found that broke some boxes.

So, now we choose an IRQ from the possible list, preferring
the highest interrupt number in the list -- 15.
Didn't see it in your .JPG dmesg, but I expect this was there:

ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 15

and probably that set IRQ15 to level/low which killed IDE.

Please try the attached patch which disables the sanity
check above.

Also might be interesting to see what happens on this system
if it is booted (without the patch) with "acpi_irq_balance"

thanks,
-Len


--=-dB+ge7OdpC2LWRV2plqF
Content-Disposition: attachment; filename=sis-debug.patch
Content-Type: text/plain; name=sis-debug.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== drivers/acpi/pci_link.c 1.28 vs edited =====
--- 1.28/drivers/acpi/pci_link.c	Thu May  6 16:03:17 2004
+++ edited/drivers/acpi/pci_link.c	Sun May  9 21:57:39 2004
@@ -549,7 +549,7 @@
 	/*
 	 * if active found, use it; else pick entry from end of possible list.
 	 */
-	if (i != link->irq.possible_count) {
+	if (link->irq.active) {
 		irq = link->irq.active;
 	} else {
 		irq = link->irq.possible[link->irq.possible_count - 1];

--=-dB+ge7OdpC2LWRV2plqF--

