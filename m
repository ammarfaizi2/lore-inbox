Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUEJDdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUEJDdo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 23:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264502AbUEJDdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 23:33:44 -0400
Received: from fmr10.intel.com ([192.55.52.30]:60116 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S264500AbUEJDdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 23:33:33 -0400
Subject: Re: ACPI and broken PCI IRQ sharing on Asus M5N laptop
From: Len Brown <len.brown@intel.com>
To: Patrick Reynolds <reynolds@cs.duke.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FAF0D@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FAF0D@hdsmsx403.hd.intel.com>
Content-Type: multipart/mixed; boundary="=-+0HHEOsZiTNHIoGMmPum"
Organization: 
Message-Id: <1084160004.12352.82.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 09 May 2004 23:33:25 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+0HHEOsZiTNHIoGMmPum
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2004-05-09 at 22:47, Brown, Len wrote:
> On Sun, 2004-05-09 at 20:44, Patrick Reynolds wrote:

> >    12:      310     XT-PIC  i8042, Intel 82801DB-ICH4, yenta

> 
> try booting with "acpi_irq_isa=12"
> 
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 12) *0, disabled.
> 
> ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 12

On the assumption that cmdline works, please try this patch
(without any cmdline param).

It simply tweaks the heuristic and makes IRQ12 less attractive compared
to the others.

thanks,
-Len


--=-+0HHEOsZiTNHIoGMmPum
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

--=-+0HHEOsZiTNHIoGMmPum--

