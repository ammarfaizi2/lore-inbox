Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264492AbUEJD1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264492AbUEJD1Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 23:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbUEJD1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 23:27:24 -0400
Received: from fmr11.intel.com ([192.55.52.31]:21709 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S264492AbUEJD1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 23:27:20 -0400
Subject: Re: hdc: lost interrupt ide-cd: cmd 0x3 timed out ...
From: Len Brown <len.brown@intel.com>
To: Bob Gill <gillb4@telusplanet.net>
Cc: Alex Riesen <fork0@users.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FAF0B@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FAF0B@hdsmsx403.hd.intel.com>
Content-Type: multipart/mixed; boundary="=-c4yPN4jhZLF89OsGbbz9"
Organization: 
Message-Id: <1084159623.12352.71.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 09 May 2004 23:27:03 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-c4yPN4jhZLF89OsGbbz9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2004-05-09 at 22:16, Brown, Len wrote:
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15) *9
...
> Didn't see it in your .JPG dmesg, but I expect this was there:
> 
> ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 15
> 
> and probably that set IRQ15 to level/low which killed IDE.
> 
> Please try the attached patch which disables the sanity
> check above.
> 
> Also might be interesting to see what happens on this system
> if it is booted (without the patch) with "acpi_irq_balance"

Better yet, here's a proposd fix.  Please give it a whirl.

The curve ball was that "illegal" IRQ9.
Its "illegalness" caused us to grab a new IRQ off the possible list,
but since it wasn't zero, we didn't scrub the new IRQ with our
usual heuristics for selecting ISA range IRQs.

I expect this will assign sound to IRQ10 or IRQ11.

thanks,
-Len


--=-c4yPN4jhZLF89OsGbbz9
Content-Disposition: attachment; filename=pci_link.patch
Content-Type: text/plain; name=pci_link.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== drivers/acpi/pci_link.c 1.28 vs edited =====
--- 1.28/drivers/acpi/pci_link.c	Thu May  6 16:03:17 2004
+++ edited/drivers/acpi/pci_link.c	Sun May  9 23:16:48 2004
@@ -478,7 +478,7 @@
 	PIRQ_PENALTY_PCI_AVAILABLE,	/* IRQ9  PCI, often acpi */
 	PIRQ_PENALTY_PCI_AVAILABLE,	/* IRQ10 PCI */
 	PIRQ_PENALTY_PCI_AVAILABLE,	/* IRQ11 PCI */
-	PIRQ_PENALTY_ISA_TYPICAL,	/* IRQ12 mouse */
+	PIRQ_PENALTY_ISA_USED,	/* IRQ12 mouse */
 	PIRQ_PENALTY_ISA_USED,	/* IRQ13 fpe, sometimes */
 	PIRQ_PENALTY_ISA_USED,	/* IRQ14 ide0 */
 	PIRQ_PENALTY_ISA_USED,	/* IRQ15 ide1 */
@@ -545,17 +545,23 @@
 		if (link->irq.active == link->irq.possible[i])
 			break;
 	}
+	/*
+	 * forget active IRQ that is not in possible list
+	 */
+	if (i == link->irq.possible_count) {
+		if (acpi_strict)
+			printk(KERN_WARNING PREFIX "_CRS %d not found"
+				" in _PRS\n", link->irq.active);
+		link->irq.active = 0;
+	}
 
 	/*
 	 * if active found, use it; else pick entry from end of possible list.
 	 */
-	if (i != link->irq.possible_count) {
+	if (link->irq.active) {
 		irq = link->irq.active;
 	} else {
 		irq = link->irq.possible[link->irq.possible_count - 1];
-		if (acpi_strict)
-			printk(KERN_WARNING PREFIX "_CRS %d not found"
-				" in _PRS\n", link->irq.active);
 	}
 
 	if (acpi_irq_balance || !link->irq.active) {

--=-c4yPN4jhZLF89OsGbbz9--

