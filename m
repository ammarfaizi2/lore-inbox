Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262553AbTIQBCw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 21:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbTIQBCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 21:02:52 -0400
Received: from mail.kroah.org ([65.200.24.183]:2025 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262553AbTIQBCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 21:02:51 -0400
Date: Tue, 16 Sep 2003 18:02:55 -0700
From: Greg KH <greg@kroah.com>
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       linux-acpi@intel.com, Chris Wright <chrisw@osdl.org>
Subject: Re: [ACPI] [PATCH] 2.6.0-test4 Don't change BIOS allocated IRQs
Message-ID: <20030917010254.GA1640@kroah.com>
References: <200309170011.03630.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309170011.03630.adq_dvb@lidskialf.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 17, 2003 at 12:11:03AM +0100, Andrew de Quincey wrote:
> With the help of Chris Wright testing several failed patches, I've tracked 
> down another ACPI IRQ problem. On many systems, the BIOS 
> pre-allocates IRQs for certain PCI devices, providing a list of alternate 
> possibilities as well.
> 
> On some systems, changing the IRQ to one of those alternate possibilities 
> works fine. On others however, it really isn't a good idea. As theres no 
> way to tell which systems are good and bad in advance, this patch simply 
> ensures that ACPI does not change an IRQ if the BIOS has pre-allocated it.

Nice, the patch below, which Chris told me is from you, fixed my
problems too.  It is against 2.6.0-test5-bk3 and fixes bug number 1186
in the bugzilla.kernel.org database.

Many thanks for this work, I really appreciate it.

thanks,

greg k-h

test5-bk_current
===== drivers/acpi/pci_link.c 1.13 vs edited =====
--- 1.13/drivers/acpi/pci_link.c	Mon Sep  8 05:51:03 2003
+++ edited/drivers/acpi/pci_link.c	Tue Sep 16 16:16:31 2003
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


