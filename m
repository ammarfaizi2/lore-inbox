Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbTIQA3x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 20:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbTIQA3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 20:29:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:18070 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262539AbTIQA3v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 20:29:51 -0400
Date: Tue, 16 Sep 2003 17:29:47 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       linux-acpi@intel.com, Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] 2.6.0-test4 Don't change BIOS allocated IRQs
Message-ID: <20030916172947.K22486@osdlab.pdx.osdl.net>
References: <200309170011.03630.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200309170011.03630.adq_dvb@lidskialf.net>; from adq_dvb@lidskialf.net on Wed, Sep 17, 2003 at 12:11:03AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew de Quincey (adq_dvb@lidskialf.net) wrote:
> With the help of Chris Wright testing several failed patches, I've tracked 
> down another ACPI IRQ problem. On many systems, the BIOS 
> pre-allocates IRQs for certain PCI devices, providing a list of alternate 
> possibilities as well.

As Andrew showed me, this manifested itself like:

ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *6 7 10 11 12)
...
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10

whereas the patch does:

ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *6 7 10 11 12)
...
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 6

> On some systems, changing the IRQ to one of those alternate possibilities 
> works fine. On others however, it really isn't a good idea. As theres no 
> way to tell which systems are good and bad in advance, this patch simply 
> ensures that ACPI does not change an IRQ if the BIOS has pre-allocated it.

Thanks for the patch Andrew ;-)  I tested this patch (or applicable
variation) on test3-bk3 (where the original breakage ocurred) up through
test5-mm2, all worked fine.  This patch doesn't actually apply to current
test5-bk (inline patch and url below) or test5-mm2 (inline patch and
url below) for those who'd like to test.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

2.6.0-test5-bk_current acpi pci irq fix:
http://developer.osdl.org/chrisw/acpi/2.6.0-test5/test5-bk-acpi_pci_irq_fix.diff

===== drivers/acpi/pci_link.c 1.17 vs edited =====
--- 1.17/drivers/acpi/pci_link.c	Sun Aug 31 16:14:25 2003
+++ edited/drivers/acpi/pci_link.c	Tue Sep 16 16:59:46 2003
@@ -456,7 +456,6 @@
 		irq = link->irq.active;
 	} else {
 		irq = link->irq.possible[0];
-	}
 
 		/* 
 		 * Select the best IRQ.  This is done in reverse to promote 
@@ -466,6 +465,7 @@
 			if (acpi_irq_penalty[irq] > acpi_irq_penalty[link->irq.possible[i]])
 				irq = link->irq.possible[i];
 		}
+	}
 
 	/* Attempt to enable the link device at this IRQ. */
 	if (acpi_pci_link_set(link, irq)) {


2.6.0-test5-mm2 acpi pci irq fix:
http://developer.osdl.org/chrisw/acpi/2.6.0-test5-mm2/mm2-acpi_pci_irq_fix.diff

--- 2.6.0-test5-mm2-clean/drivers/acpi/pci_link.c	2003-09-16 14:17:27.000000000 -0700
+++ 2.6.0-test5-mm2/drivers/acpi/pci_link.c	2003-09-16 15:01:31.000000000 -0700
@@ -509,15 +509,15 @@
 		irq = link->irq.active;
 	} else {
 		irq = link->irq.possible[0];
-	}
 
-	/*
-	 * Select the best IRQ.  This is done in reverse to promote
-	 * the use of IRQs 9, 10, 11, and >15.
-	 */
-	for (i=(link->irq.possible_count-1); i>0; i--) {
-		if (acpi_irq_penalty[irq] > acpi_irq_penalty[link->irq.possible[i]])
-			irq = link->irq.possible[i];
+		/*
+		 * Select the best IRQ.  This is done in reverse to promote
+		 * the use of IRQs 9, 10, 11, and >15.
+		 */
+		for (i=(link->irq.possible_count-1); i>0; i--) {
+			if (acpi_irq_penalty[irq] > acpi_irq_penalty[link->irq.possible[i]])
+				irq = link->irq.possible[i];
+		}
 	}
 
 	/* Attempt to enable the link device at this IRQ. */
