Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVBNWrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVBNWrM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 17:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVBNWrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 17:47:12 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:2713 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261465AbVBNWqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 17:46:42 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <greg@kroah.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       tom.l.nguyen@intel.com
Subject: Re: avoiding pci_disable_device()...
X-Message-Flag: Warning: May contain useful information
References: <4210021F.7060401@pobox.com> <20050214190619.GA9241@kroah.com>
	<4211013E.6@pobox.com> <52hdke29sh.fsf@topspin.com>
	<20050214200043.GA15868@havoc.gtf.org> <52d5v224z3.fsf@topspin.com>
	<42112544.2030006@pobox.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 14 Feb 2005 14:46:38 -0800
In-Reply-To: <42112544.2030006@pobox.com> (Jeff Garzik's message of "Mon, 14
 Feb 2005 17:25:08 -0500")
Message-ID: <528y5q220h.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 14 Feb 2005 22:46:38.0607 (UTC) FILETIME=[0B49F9F0:01C512E7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I'm happy to go along with that (it definitely simplifies my
driver code).  Here's the patch.


Remove the call to request_mem_region() in msix_capability_init() to
grab the MSI-X vector table.  Drivers should be using
pci_request_regions() so that they own all of the PCI BARs, and the
MSI-X core should trust it's being called by a correct driver.

Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux-orig/drivers/pci/msi.c	(revision 26881)
+++ linux/drivers/pci/msi.c	(working copy)
@@ -616,15 +616,10 @@ static int msix_capability_init(struct p
 	bir = (u8)(table_offset & PCI_MSIX_FLAGS_BIRMASK);
 	phys_addr = pci_resource_start (dev, bir);
 	phys_addr += (u32)(table_offset & ~PCI_MSIX_FLAGS_BIRMASK);
-	if (!request_mem_region(phys_addr,
-		nr_entries * PCI_MSIX_ENTRY_SIZE,
-		"MSI-X vector table"))
-		return -ENOMEM;
 	base = ioremap_nocache(phys_addr, nr_entries * PCI_MSIX_ENTRY_SIZE);
-	if (base == NULL) {
-		release_mem_region(phys_addr, nr_entries * PCI_MSIX_ENTRY_SIZE);
+	if (base == NULL)
 		return -ENOMEM;
-	}
+
 	/* MSI-X Table Initialization */
 	for (i = 0; i < nvec; i++) {
 		entry = alloc_msi_entry();
@@ -859,8 +854,6 @@ static int msi_free_vector(struct pci_de
 			phys_addr += (u32)(table_offset &
 				~PCI_MSIX_FLAGS_BIRMASK);
 			iounmap(base);
-			release_mem_region(phys_addr,
-				nr_entries * PCI_MSIX_ENTRY_SIZE);
 		}
 	}
 
@@ -1133,8 +1126,6 @@ void msi_remove_pci_irq_vectors(struct p
 			phys_addr += (u32)(table_offset &
 				~PCI_MSIX_FLAGS_BIRMASK);
 			iounmap(base);
-			release_mem_region(phys_addr, PCI_MSIX_ENTRY_SIZE *
-				multi_msix_capable(control));
 			printk(KERN_WARNING "PCI: %s: msi_remove_pci_irq_vectors() "
 			       "called without free_irq() on all MSI-X vectors\n",
 			       pci_name(dev));
