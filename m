Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263265AbTIVRao (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 13:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263266AbTIVRao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 13:30:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:11918 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263265AbTIVRah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 13:30:37 -0400
Date: Mon, 22 Sep 2003 10:30:28 -0700
From: Chris Wright <chrisw@osdl.org>
To: Ruediger Scholz <rscholz@hrzpub.tu-darmstadt.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: irq 9: nobody cared!
Message-ID: <20030922103028.A18616@osdlab.pdx.osdl.net>
References: <3F6EBEC7.7050204@hrzpub.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3F6EBEC7.7050204@hrzpub.tu-darmstadt.de>; from rscholz@hrzpub.tu-darmstadt.de on Mon, Sep 22, 2003 at 11:20:07AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ruediger Scholz (rscholz@hrzpub.tu-darmstadt.de) wrote:
> Hi there!
> 
> I own a P4 with SIS 645DX-Chipset, so I tried kernel 2.6.0-test5-mm3 in 
> order to get a working IOAPIC mode with the SIS Chipset. When I boot the 
<snip> 
> If I use the boot param "pci=noacpi" then everything works fine, even sound.

Can you try this patch against 2.6.0-test5-mm3?  PCI IRQ routing is
broken in some circumstances with ACPI.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

--- 2.6.0-test5-mm3/drivers/acpi/pci_link.c~acpi_pci_irq_fix	2003-09-22 10:00:16.000000000 -0700
+++ 2.6.0-test5-mm3/drivers/acpi/pci_link.c	2003-09-22 10:10:06.000000000 -0700
@@ -500,15 +500,15 @@ static int acpi_pci_link_allocate(struct
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
