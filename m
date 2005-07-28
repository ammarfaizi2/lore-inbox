Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVG1Pju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVG1Pju (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 11:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVG1Pjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 11:39:37 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:16857 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S261529AbVG1Phj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 11:37:39 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: VIA PCI routing problem
Date: Thu, 28 Jul 2005 09:37:33 -0600
User-Agent: KMail/1.8.1
Cc: "Brown, Len" <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <42E8CB27.4010100@yahoo.com.au>
In-Reply-To: <42E8CB27.4010100@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507280937.33971.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 July 2005 6:10 am, Nick Piggin wrote:
> I have a VIA SMP system and somewhere between 2.6.12-rc3 and 2.6.12
> the USB mouse started moving around really slowly. Anyway, it turns
> out that the attached patch (against 2.6.13-rc3-git8) fixes the problem.

Can you try this:

Index: work/drivers/pci/quirks.c
===================================================================
--- work.orig/drivers/pci/quirks.c	2005-07-25 15:04:26.000000000 -0600
+++ work/drivers/pci/quirks.c	2005-07-28 09:26:09.000000000 -0600
@@ -503,7 +503,7 @@
 
 	new_irq = dev->irq & 0xf;
 	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
-	if (new_irq != irq) {
+	if (1 || new_irq != irq) {
 		printk(KERN_INFO "PCI: Via IRQ fixup for %s, from %d to %d\n",
 			pci_name(dev), irq, new_irq);
 		udelay(15);	/* unknown if delay really needed */


If that doesn't help, remove it and see if this does:

Index: work/drivers/pci/quirks.c
===================================================================
--- work.orig/drivers/pci/quirks.c	2005-07-25 15:04:26.000000000 -0600
+++ work/drivers/pci/quirks.c	2005-07-28 09:27:23.000000000 -0600
@@ -510,7 +510,7 @@
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
 	}
 }
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
+DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, quirk_via_irq);
 
 /*
  * PIIX3 USB: We have to disable USB interrupts that are


Can you also include "lspci" output?
